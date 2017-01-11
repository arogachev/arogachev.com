var fs = require('fs');
var path = require('path');

var docxTemplater = require('docxtemplater');
var jsZip = require('jszip');
var expressions = require('angular-expressions');
var DOMParser = require('xmldom').DOMParser;
var XMLSerializer = require('xmldom').XMLSerializer;

var yaml = require('js-yaml');

var downloadFile = require('../files.js').download;

var generatedDir = path.join(__dirname, '..', '..', '_generated');
var templatePath = path.join(__dirname, 'template.docx');

process.argv[2] == '--download-template' ? downloadTemplate(exportToDocx) : exportToDocx();

function exportToDocx() {
    var data = getData();
    generateFile(data);
}

function getData() {
    try {
        var dataPath = path.join(generatedDir, 'resume.yml');

        return yaml.safeLoad(fs.readFileSync(dataPath, 'utf8'));
    } catch (e) {
        throw new Error("Data from YAML file can't be retrieved. " + e);
    }
}

function generateFile(data) {
    var content = fs.readFileSync(templatePath, 'binary');
    var zip = new jsZip(content);
    expressions.filters.asSentence = function (arr) {
        return arr.join(', ');
    };
    var angularParser = function (tag) {
        var getFunction = function (scope) {
            return scope;
        };

        return {
            get: tag == '.' ? getFunction : expressions.compile(tag)
        };
    };
    var template = new docxTemplater()
        .loadZip(zip)
        .setOptions({parser: angularParser})
        .setData(data)
        .render();

    // Remove empty paragraphs generated with loops
    // https://github.com/open-xml-templating/docxtemplater/issues/272

    var xml = template.getZip().file('word/document.xml').asText();
    var doc = new DOMParser().parseFromString(xml, 'text/xml');
    var paragraphs = doc.getElementsByTagName('w:p');

    for (var i = 0, len = paragraphs.length; i < len; i++) {
        var paragraph = paragraphs[i];
        var text = paragraph.getElementsByTagName('w:t')[0];
        if (text && text.textContent === '') {
            doc.documentElement.removeChild(paragraph);
        }
    }

    var editedXml = new XMLSerializer().serializeToString(doc);
    template.getZip().file('word/document.xml', editedXml);

    var buffer = template.getZip().generate({type: 'nodebuffer'});
    var outputFile = path.join(generatedDir, 'resume.docx');
    fs.writeFileSync(outputFile, buffer);
}

/**
 * Download a template from Google Drive
 * @param {function} cb Callback to execute after downloading was completed.
 */
function downloadTemplate(cb) {
    var id = '1EDiiMb8ZmpshcJpjfKl3FDO9OykoNkCAfn6iBHOcwO4';
    var url = 'https://docs.google.com/document/export?format=docx&id=' + id;

    downloadFile(url, templatePath, cb);
}
