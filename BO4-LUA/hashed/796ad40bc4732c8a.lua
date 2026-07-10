require("x64:db806626fb64f10")
require("x64:a38a98b7d7843d5")
require("x64:7f67615a49af700")
CoD.Store_DLC = InheritFrom(CoD.Menu)
LUI.createMenu.Store_DLC = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("Store_DLC", f1_arg0)
	local f1_local1 = self
	CoD.StoreUtility.InitSingleCategoryStoreMenu(self, f1_arg0, "mappacks")
	self:setClass(CoD.Store_DLC)
	self.soundSet = "ChooseDecal"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local Background = LUI.UIImage.new(0.5, 0.5, -957, 963, 0.5, 0.5, -540, 540)
	Background:setImage(RegisterImage(@"uie_t7_mp_menu_cac_version6_backdrop720p"))
	self:addElement(Background)
	self.Background = Background
	local editorBackground = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	editorBackground:setRGB(0, 0, 0)
	editorBackground:setAlpha(0.75)
	self:addElement(editorBackground)
	self.editorBackground = editorBackground
	local frame = CoD.GenericMenuFrameIdentity.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	frame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_BB7AA7A26F39DFA"))
	frame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			frame.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(frame)
	self.frame = frame
	local StartMenuCurrencyCounts = CoD.StartMenu_CurrencyCounts.new(f1_local1, f1_arg0, 1, 1, -918, -608, 0, 0, 37.5, 117.5)
	StartMenuCurrencyCounts.vialCount:setText(SetValueIfNumberEqualTo(-1, "-", 0))
	self:addElement(StartMenuCurrencyCounts)
	self.StartMenuCurrencyCounts = StartMenuCurrencyCounts
	local StoreNonFeaturedFrame = CoD.Store_NonFeaturedFrame.new(f1_local1, f1_arg0, 0, 0, 474, 1866, 0, 0, 160, 840)
	self:addElement(StoreNonFeaturedFrame)
	self.StoreNonFeaturedFrame = StoreNonFeaturedFrame
	self:registerEventHandler("menu_loaded", function(self, event)
		local f3_local0 = nil
		if self.menuLoaded then
			f3_local0 = self:menuLoaded(event)
		elseif self.super.menuLoaded then
			f3_local0 = self.super:menuLoaded(event)
		end
		ShowPsStoreIcon(f1_arg0, Enum[@"hash_6784DC8CE13E1E13"][@"center"])
		if not f3_local0 then
			f3_local0 = self:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		ClearMenuSavedState(menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"mp/back", nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		if not IsPC() then
			RedeemCode(self, element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_2AC7CDF7FDA3D9D3", nil, nil)
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		HidePsStoreIcon(f1_arg0)
		ClearSelectedStoreCategory(f1_arg0)
		SetControllerModelValue(f1_arg0, "StoreRoot.isCategoryListInFocus", 0)
	end)
	self:subscribeToGlobalModel(f1_arg0, "PerController", "StoreRoot.ready", function(model)
		local f9_local0 = self
		if CoD.ModelUtility.IsParamModelEqualTo(model, 1) then
			SetFocusToElement(self, "StoreNonFeaturedFrame", f1_arg0)
		end
	end)
	frame:setModel(self.buttonModel, f1_arg0)
	frame.id = "frame"
	StoreNonFeaturedFrame.id = "StoreNonFeaturedFrame"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = StoreNonFeaturedFrame
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.Store_DLC.__onClose = function(f10_arg0)
	f10_arg0.frame:close()
	f10_arg0.StartMenuCurrencyCounts:close()
	f10_arg0.StoreNonFeaturedFrame:close()
end
