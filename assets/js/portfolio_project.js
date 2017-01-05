$(function () {
    var $screenshotBlock = $('#screenshot');
    var $screenshotLoading = $screenshotBlock.find('.loading');
    var $screenshotLink = $screenshotBlock.find('.screenshot-link');
    var $screenshot = $screenshotBlock.find('.screenshot-image');

    var SCREENSHOT_MENU_ITEM_SELECTOR = '.screenshot-menu-item';
    var $screenshotMenuItems = $(SCREENSHOT_MENU_ITEM_SELECTOR);

    $screenshotMenuItems.click(function () {
        $screenshotLoading.show();
        $screenshotLink.hide();

        var $this = $(this);
        var link = $this.data('src');
        var title = $this.data('title');

        $screenshotMenuItems.removeClass('active');
        $screenshot
            .attr('src', link)
            .attr('alt', title)
            .attr('title', title);
        $screenshotLink.attr('href', link);
        $this.closest(SCREENSHOT_MENU_ITEM_SELECTOR).addClass('active');
    });

    $screenshot.on('load', function () {
        $screenshotLoading.hide();
        $screenshotLink.show();
    });
});
