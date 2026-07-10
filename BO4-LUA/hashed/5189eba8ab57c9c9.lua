require("x64:3ff0962d6263ce2")
require("x64:7978b51255faa9f")
require("x64:8fae367edb12f66")
require("x64:4eb3d9feda3ad66")
require("x64:f3949c53c73a596")
CoD.BlackjackReserveFrame = InheritFrom(LUI.UIElement)
CoD.BlackjackReserveFrame.__defaultWidth = 1920
CoD.BlackjackReserveFrame.__defaultHeight = 1080
CoD.BlackjackReserveFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	if not IsBooleanDvarSet("loot_sunsetBlackjackShopActive") then
		SendClientScriptMenuChangeNotifyWithState(f1_arg1, f1_arg0, true, "reserves")
		CoD.BlackMarketUtility.SendClientScriptBlackjackReserveNotify(f1_arg1, true)
		CoD.FTUEUtility.ShowFTUESequenceIfNotSeen(self, f1_arg1, "BlackjackReservesIntroduction")
		DataSourceHelperRecreate(f1_arg1, "ReservesLootPurchaseCrateBundle")
	else
		SendClientScriptMenuChangeNotifyWithState(f1_arg1, f1_arg0, true, "reserves")
		CoD.BlackMarketUtility.SendClientScriptBlackjackReserveNotify(f1_arg1, true)
		DataSourceHelperRecreate(f1_arg1, "ReservesLootPurchaseCrateBundle")
	end
	self:setClass(CoD.BlackjackReserveFrame)
	self.id = "BlackjackReserveFrame"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local ReservesPreview = CoD.ReservesPreviewContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, 311, 711, 0.5, 0.5, 365, 389)
	self:addElement(ReservesPreview)
	self.ReservesPreview = ReservesPreview
	local SpecialContract = CoD.ReservesSpecialContract.new(f1_arg0, f1_arg1, 0.5, 0.5, -847, -163, 0.5, 0.5, 238, 370)
	SpecialContract:subscribeToGlobalModel(f1_arg1, "ReservesSpecialContract", nil, function(model)
		SpecialContract:setModel(model, f1_arg1)
	end)
	SpecialContract:linkToElementModel(SpecialContract, "active", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	SpecialContract:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(SpecialContract, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "active") then
			OpenOverlay(self, "ReservesSpecialContractMenu", controller, {
				_model = element:getModel(),
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "active") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(SpecialContract)
	self.SpecialContract = SpecialContract
	local OffersCarousel = CoD.ReservesButtonLayout.new(f1_arg0, f1_arg1, 0.5, 0.5, -880, 111, 0.5, 0.5, -383, 145)
	self:addElement(OffersCarousel)
	self.OffersCarousel = OffersCarousel
	local ReservesMeter = CoD.ReservesMeter.new(f1_arg0, f1_arg1, 0, 0, 1356, 2040, 0, 0, 850, 917)
	ReservesMeter:subscribeToGlobalModel(f1_arg1, "LootStreamProgress", nil, function(model)
		ReservesMeter:setModel(model, f1_arg1)
	end)
	self:addElement(ReservesMeter)
	self.ReservesMeter = ReservesMeter
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		CoD.BlackMarketUtility.SendClientScriptBlackjackReserveNotify(f1_arg1, false)
	end)
	self.__on_menuOpened_self = function(f9_arg0, f9_arg1, f9_arg2, f9_arg3)
		local f9_local0 = self
		if not IsMenuPropertyValue(f9_arg2, "_itemPurchaseId", nil) then
			CoD.BlackMarketUtility.AutoOpenItemPurchasePopup(self.LootCrateButton, f9_arg1, f9_arg2)
		end
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	SpecialContract.id = "SpecialContract"
	OffersCarousel.id = "OffersCarousel"
	self.__defaultFocus = OffersCarousel
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local5 = self
	CoD.BlackMarketUtility.UpdateLootCaseBreadcrumbStatValue(f1_arg1)
	ForceNotifyControllerModel(f1_arg1, "updateLootCaseBreadcrumb")
	return self
end
CoD.BlackjackReserveFrame.__onClose = function(f11_arg0)
	f11_arg0.__on_close_removeOverrides()
	f11_arg0.ReservesPreview:close()
	f11_arg0.SpecialContract:close()
	f11_arg0.OffersCarousel:close()
	f11_arg0.ReservesMeter:close()
end
