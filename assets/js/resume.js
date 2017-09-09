$(function () {
    var SCROLL_TOP_OFFSET = 10;
    var $scrollableBlock = $('html, body');
    var $collapseBlocks = $('.collapse');
    var $toggles = $('.toggle .fa');

    var $workHeaders = $('.work .collapse-heading');
    var $skillsHeader = $('#skills');
    var $skillsCollapse = $('#hidden-skills-collapse');
    var $downloadToggleBlock = $('.download .toggle');
    var $downloadToggle = $('#download-toggle');
    var $downloadToggleableBlocks = $('.download .dropdown-item');
    var $interestsToggle = $('#interests-toggle');
    var $interestsToggleableBlocks = $('.interests .emoji, .interests .details-text');

    $workHeaders.each(function () {
        var id = $(this).attr('id');

        if ('#' + id === window.location.hash) {
            $('#' + id + '-collapse').collapse('show');

            return false;
        }
    });

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

    $downloadToggleBlock.click(function () {
        return false;
    });

    $downloadToggle.click(function () {
        $downloadToggleableBlocks.toggleClass('visible');

        return false;
    });

    $interestsToggle.click(function () {
        $interestsToggleableBlocks.toggle();
    });
});
