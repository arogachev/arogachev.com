var fs = require('fs');
var request = require('request');
var fileUtils = {};

/**
 * Download a file from the given url and save it to destination folder with optional execution of a callback.
 * @param {string} url Download url. Required.
 * @param {string} dest Destination folder (where to save downloaded file). Required.
 * @param {function} cb Callback to execute after downloading and saving file were successfully completed. Optional.
 */
fileUtils.download = function (url, dest, cb) {
    var file = fs.createWriteStream(dest);
    var req = request.get(url);

    req.on('response', function (response) {
        if (response.statusCode !== 200) {
            var message = 'Downloading of a file ' + url + ' failed. Response code was ' + response.statusCode + '.';
            throw new Error(message);
        }
    });

    req.on('error', function (err) {
        fs.unlink(dest);
        var message = 'There was an error during downloading file ' + url + '. ' + err.message;
        throw new Error(message);
    });

    req.pipe(file);

    file.on('finish', function () {
        file.close(cb);
    });

    file.on('error', function (err) {
        fs.unlink(dest);
        throw new Error('There was an error during saving downloaded file ' + url + '. ' + err.message);
    });
};

module.exports = fileUtils;
