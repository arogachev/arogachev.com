(function ($) {
    function Screenshot(index, title, url) {
        this.index = index;
        this.title = title;
        this.url = url;
    }

    $.extend(Screenshot.prototype, {
        getAnchor: function () {
            return '#screenshot-' + (this.index + 1);
        }
    });

    function ScreenshotsCollection(screenshots) {
        var self = this;

        this.screenshots = [];
        $.each(screenshots, function (index, data) {
            var screenshot = new Screenshot(index, data.title, data.url);
            self.screenshots.push(screenshot);
        });

        this.currentScreenshot = undefined;

        this.SCROLL_TOP_OFFSET = 16;
        this.$scrollableBlock = $('html, body');
        this.$tab = $('#screenshots-tab');
        this.$tabContent = $('#portfolio-project-screenshots');
        this.$row = $('.screenshots');
        this.$collapseMenu = $('#screenshots-collapse-menu');
        this.$collapseMenuTrigger = $('.screenshots-collapse-menu-trigger');
        this.$collapseMenuTriggerTitle = this.$collapseMenuTrigger.find('.title');
        this.$triggers = this.$row.find('.nav-link');
        this.$image = $('<img>', {'class': 'img-fluid'});

        var $screenshotBlock = this.$row.find('.screenshot');
        this.$loading = $screenshotBlock.find('.loading');
        this.$link = $screenshotBlock.find('.link');

        this.init();
    }

    $.extend(ScreenshotsCollection.prototype, {
        init: function () {
            this.attachTabHandler();
            this.attachTriggersHandler();
            this.attachImageHandler();
            this.attachLinkHandler();
        },

        attachTabHandler: function () {
            var self = this;

            this.$tab.click(function () {
                if (!self.currentScreenshot) {
                    self.changeCurrentScreenshot(0);
                }
            })
        },

        attachTriggersHandler: function () {
            var self = this;

            this.$triggers.click(function () {
                self.changeCurrentScreenshot($(this).data('index'));
            });
        },

        attachImageHandler: function () {
            var self = this;

            this.$image.on('load', function () {
                self.$loading.hide();

                self.$collapseMenu.collapse('hide');
                self.$collapseMenuTriggerTitle.text(self.currentScreenshot.title);

                self.$link.show();
                self.scrollTop();
            });
        },

        attachLinkHandler: function () {
            var self = this;

            this.$link.click(function () {
                if (!self.getUrlScreenshot()) {
                    window.location.hash = self.currentScreenshot.getAnchor();
                }
            });
        },

        changeCurrentScreenshot: function (index) {
            if (this.currentScreenshot && this.currentScreenshot.index === index) {
                return;
            }

            this.currentScreenshot = this.getScreenshot(index);

            this.$triggers.removeClass('active');
            this.$triggers.filter('[data-index=' + index + ']').addClass('active');

            this.$link.hide();
            this.$loading.show();

            this.$image
                .attr('src', this.currentScreenshot.url)
                .attr('alt', this.currentScreenshot.title)
                .attr('title', this.currentScreenshot.title);
            this.$link.attr('href', this.currentScreenshot.url);

            if (this.$link.is(':empty')) {
                this.$link.html(this.$image);
            }
        },

        loadUrlScreenshot: function () {
            var screenshot = this.getUrlScreenshot();
            if (!screenshot) {
                return false;
            }

            if (!this.$tabContent.is(':visible')) {
                this.$tab.trigger('click');
            }

            this.changeCurrentScreenshot(screenshot.index);

            return true;
        },

        getScreenshot: function (index) {
            return this.screenshots[index];
        },

        getUrlScreenshot: function () {
            var regex = /screenshot-([1-9]\d?)/;
            var matches = window.location.hash.match(regex);
            if (!matches) {
                return;
            }

            var index = matches[1] - 1;

            return this.getScreenshot(index)
        },

        scrollTop: function () {
            if (!this.$row.is(':visible') || !this.getUrlScreenshot()) {
                return;
            }

            this.$scrollableBlock.scrollTop(this.$row.offset().top - this.SCROLL_TOP_OFFSET);
        }
    });

    $(function () {
        var screenshotsCollection = new ScreenshotsCollection(window.screenshots);

        var $detailsTab = $('#details-tab');
        var $detailsTabContent = $('#portfolio-project-details');
        var $detailsCollapseMenu = $('#details-collapse-menu');
        var $detailsCollapseMenuTrigger = $('.details-collapse-menu-trigger');

        initTab();

        $(window).on('hashchange', function() {
            initTab();
        });

        $detailsCollapseMenu.on('show.bs.collapse', function () {
            $detailsCollapseMenuTrigger.addClass('active');
        });

        $detailsCollapseMenu.on('hide.bs.collapse', function () {
            $detailsCollapseMenuTrigger.removeClass('active');
        });

        screenshotsCollection.$collapseMenu.on('show.bs.collapse', function () {
            screenshotsCollection.$collapseMenuTrigger.addClass('active');
        });

        screenshotsCollection.$collapseMenu.on('hide.bs.collapse', function () {
            screenshotsCollection.$collapseMenuTrigger.removeClass('active');
        });

        function initTab() {
            if (screenshotsCollection.loadUrlScreenshot()) {
                return;
            }

            if (screenshotsCollection.$tabContent.is(':visible') && window.location.hash === '') {
                screenshotsCollection.changeCurrentScreenshot(0);

                return;
            }

            if (!$detailsTabContent.is(':visible')) {
                $detailsTab.trigger('click');

                // Force page to navigate to anchor after details tab becomes visible
                window.location.hash = window.location.hash;
            }
        }
    });
})(window.jQuery);
