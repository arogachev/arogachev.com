$(function () {
    var SCREENSHOT_MENU_ITEM_SELECTOR = '.screenshot-menu-item';
    var $screenshotMenuItems = $(SCREENSHOT_MENU_ITEM_SELECTOR);
    var $screenshotTriggers = $('.screenshot-trigger');
    var $screenshotBlock = $('#screenshot');
    var $screenshotLoading = $screenshotBlock.find('.loading');
    var $screenshotLink = $screenshotBlock.find('.screenshot-link');
    var $screenshot;

    $screenshotTriggers.click(function () {
        var $this = $(this);
        var link = $this.attr('href');
        var title = $this.data('title');

        $screenshotMenuItems.removeClass('active');
        $this.closest(SCREENSHOT_MENU_ITEM_SELECTOR).addClass('active');

        $screenshotLoading.show();
        $screenshotLink.hide();

        if (!$screenshot) {
            $screenshot = $('<img>', {'class': 'img-responsive', alt: title, title: title});

            $screenshot.on('load', function () {
                $screenshotLoading.hide();
                $screenshotLink.show();
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
