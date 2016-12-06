$(function () {
    var $screenshotBlock = $('#screenshot');
    var $screenshot = $screenshotBlock.find('img');
    var $screenshotLink = $screenshotBlock.find('a');

    var SCREENSHOT_MENU_ITEM_SELECTOR = '.screenshot-menu-item';
    var $screenshotMenuItems = $(SCREENSHOT_MENU_ITEM_SELECTOR);

    $screenshotMenuItems.click(function () {
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
});
