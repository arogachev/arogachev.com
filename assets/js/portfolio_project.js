$(function () {
    var SCROLL_TOP_OFFSET = 16;

    var $scrollableBlock = $('html, body');
    var $screenshotsRow = $('.screenshots');
    var $screenshotTriggers = $screenshotsRow.find('.nav-link');
    var $screenshotBlock = $screenshotsRow.find('.screenshot');
    var $screenshotLoading = $screenshotBlock.find('.loading');
    var $screenshotLink = $screenshotBlock.find('.link');
    var $screenshot;

    $screenshotTriggers.click(function () {
        var $this = $(this);
        var link = $this.attr('href');
        var title = $this.data('title');

        $screenshotTriggers.removeClass('active');
        $this.addClass('active');

        $screenshotLoading.show();
        $screenshotLink.hide();

        if (!$screenshot) {
            $screenshot = $('<img>', {'class': 'img-fluid', alt: title, title: title});

            $screenshot.on('load', function () {
                $screenshotLoading.hide();
                $screenshotLink.show();
                $scrollableBlock.scrollTop($screenshotsRow.offset().top - SCROLL_TOP_OFFSET);
            });

            $screenshot.attr('src', link);
            $screenshotLink.attr('href', link);
            $screenshotLink.html($screenshot);

            return false;
        }

        $screenshot
            .attr('src', link)
            .attr('alt', title)
            .attr('title', title);
        $screenshotLink.attr('href', link);

        return false;
    });

    $screenshotTriggers.first().trigger('click');
});
