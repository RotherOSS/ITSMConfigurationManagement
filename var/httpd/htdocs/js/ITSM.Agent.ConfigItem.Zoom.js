// --
// OTOBO is a web-based ticketing system for service organisations.
// --
// Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
// Copyright (C) 2019-2025 Rother OSS GmbH, https://otobo.io/
// --
// This program is free software: you can redistribute it and/or modify it under
// the terms of the GNU General Public License as published by the Free Software
// Foundation, either version 3 of the License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <https://www.gnu.org/licenses/>.
// --

"use strict";

var ITSM = ITSM || {};
ITSM.Agent = ITSM.Agent || {};
ITSM.Agent.ConfigItem = ITSM.Agent.ConfigItem || {};

/**
 * @namespace ITSM.Agent.ConfigItem.Zoom
 * @memberof ITSM.Agent.ConfigItem
 * @author Rother OSS GmbH
 * @description
 *      This namespace contains the special module functions for the config item add.
 */
ITSM.Agent.ConfigItem.Zoom = (function (TargetNS) {

    /*
    * @name Init
    * @memberof ITSM.Agent.ConfigItem.Zoom
    * @function
    * @description
    *      This function initializes config item zoom section.
    */
    TargetNS.Init = function () {
        $('#VersionSelection').on('change', function () {
            var Redirect = $(this).val();
            if ( Redirect ) {
                window.location = Redirect;
            }
        });

        var ITSMShowConfirmDialog = Core.Config.Get('ITSMShowConfirmDialog');

        ITSM.Agent.Zoom.Init(Core.Config.Get('UserConfigItemZoomTableHeight'));

        $('ul.Actions a.AsPopup').on('click', function () {
            Core.UI.Popup.OpenPopup($(this).attr('href'), 'Action');
            return false;
        });

        $('.MasterAction').on('click', function (Event) {
            var $MasterActionLink = $(this).find('.MasterActionLink');
            // only act if the link was not clicked directly
            if (Event.target !== $MasterActionLink.get(0)) {
                window.location = $MasterActionLink.attr('href');
                return false;
            }
        });

        // Initialize allocation list for link object table.
        Core.Agent.TableFilters.SetAllocationList();

        if (ITSMShowConfirmDialog) {
            $.each(ITSMShowConfirmDialog, function(Key, Data) {
                ITSM.Agent.ConfirmDialog.BindConfirmDialog({
                    ElementID:                  Data.MenuID,
                    ElementSelector:            Data.ElementSelector,
                    DialogContentQueryString:   Data.DialogContentQueryString,
                    ConfirmedActionQueryString: Data.ConfirmedActionQueryString,
                    DialogTitle:                Data.DialogTitle,
                    TranslatedText:             {
                        Yes: Core.Language.Translate("Yes"),
                        No:  Core.Language.Translate("No"),
                        Ok:  Core.Language.Translate("Ok")
                    }
                });
            });
        }

        setTimeout(function () {
            let LinkCells = $('.ConfigItemLinks_Cell');
            if (LinkCells.length == 0) {
                return;
            }

            LinkCells.each(function () {
                let LinkCellStartRow = $(this).css('grid-row-start');
                let LinkCellEndRow = $(this).css('grid-row-end');
                let NewHeight = 0; /*specify default height here*/
                if (LinkCellStartRow && LinkCellEndRow) {
                    $(this).siblings('.oooContentCell:not(.ConfigItemLinks_Cell)').each(function () {
                        let StartRow = $(this).css('grid-row-start');
                        let EndRow = $(this).css('grid-row-end');
                        if (StartRow == LinkCellStartRow && EndRow == LinkCellEndRow) {
                            NewHeight = $(this).height();
                        }
                    })
                }

                if (NewHeight == 0) {
                    NewHeight = parseInt(Math.min($(this).scrollHeight, 400));
                }

                $(this).height(NewHeight);
            })
        }, 100);
    };

    /**
     * @name IframeAutoHeight
     * @memberof ITSM.Agent.ConfigItem.Zoom
     * @function
     * @param {jQueryObject} $Iframe - The iframe which should be auto-heighted
     * @description
     *      Set iframe height automatically based on real content height and hardcoded max height.
     */
    TargetNS.IframeAutoHeight = function ($Iframe) {

        var NewHeight,
            IframeBodyHeight,

            // max height
            DescriptionHeightMax = 1000;

        if (isJQueryObject($Iframe)) {
            IframeBodyHeight = $Iframe.contents().find('body').height();
            NewHeight = $Iframe.contents().height();
            if (!NewHeight || isNaN(NewHeight)) {

                // default height
                NewHeight = 100;
            }
            else {
                if (IframeBodyHeight > DescriptionHeightMax
                    || NewHeight > DescriptionHeightMax) {
                    NewHeight = DescriptionHeightMax;
                }
                else if (IframeBodyHeight > NewHeight) {
                    NewHeight = IframeBodyHeight;
                }
            }

            // add delta for scrollbar
            NewHeight = parseInt(NewHeight, 10) + 25;

            // make sure the minimum height is in line with the avatar images
            if (NewHeight < 46) {
                NewHeight = 46;
            }

            $Iframe.height(NewHeight + 'px');
        }
    };

    Core.Init.RegisterNamespace(TargetNS, 'APP_MODULE');

    return TargetNS;
}(ITSM.Agent.ConfigItem.Zoom || {}));
