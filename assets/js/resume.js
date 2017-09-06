$(function () {
    var SCROLL_TOP_OFFSET = 10;
    var $scrollableBlock = $('html, body');
    var $collapseBlocks = $('.collapse');
    var $toggles = $('.toggle .fa');

    var $skillsHeader = $('#skills');
    var $skillsCollapse = $('#hidden-skills-collapse');
    var $interestsToggle = $('#interests-toggle');
    var $interestsToggleableBlocks = $('.interests .emoji, .interests .details-text');
    var $downloadToggleBlock = $('.download .toggle');
    var $downloadToggle = $('#download-toggle');
    var $downloadToggleableBlocks = $('.download .dropdown-item');

    $collapseBlocks.on('show.bs.collapse', function () {
        $(this).closest('.collapse-item').find('.collapse-trigger').addClass('active');
    });

    $collapseBlocks.on('hide.bs.collapse', function () {
        $(this).closest('.collapse-item').find('.collapse-trigger').removeClass('active');
    });

    $toggles.click(function () {
        $(this).toggleClass('active');
    });

    $skillsCollapse.on('hide.bs.collapse', function () {
        $scrollableBlock.scrollTop($skillsHeader.offset().top - SCROLL_TOP_OFFSET);
    });

    $interestsToggle.click(function () {
        $interestsToggleableBlocks.toggle();
    });

    $downloadToggleBlock.click(function () {
        return false;
    });

    $downloadToggle.click(function () {
        $downloadToggleableBlocks.toggleClass('visible');

        return false;
    });
});
