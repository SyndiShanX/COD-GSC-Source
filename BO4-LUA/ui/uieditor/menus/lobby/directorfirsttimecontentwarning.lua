require("x64:1b66f971ffa1f09")
require("x64:f93e6387e9d051")
require("x64:b0810588c9ad0b8")
CoD.DirectorFirstTimeContentWarning = InheritFrom(CoD.Menu)
LUI.createMenu.DirectorFirstTimeContentWarning = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("DirectorFirstTimeContentWarning", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	self:setClass(CoD.DirectorFirstTimeContentWarning)
	self.soundSet = "MultiplayerMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local CommomCenteredPopup = CoD.CommonCenteredPopup.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	CommomCenteredPopup.featureOverlayButtonMouseOnly.featureOverlayButtonContainer.Title:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/confirm"))
	CommomCenteredPopup.TitleText:setText(LocalizeToUpperString(@"menu/content_filter"))
	self:addElement(CommomCenteredPopup)
	self.CommomCenteredPopup = CommomCenteredPopup
	local f1_local3 = nil
	local PCOptionGroup = LUI.UIList.new(f1_local1, f1_arg0, 2, 0, nil, false, false, false, false)
	PCOptionGroup:setLeftRight(0.5, 0.5, -325, 325)
	PCOptionGroup:setTopBottom(0.5, 0.5, -67, 132)
	PCOptionGroup:setAlpha(0)
	PCOptionGroup:setAutoScaleContent(true)
	PCOptionGroup:setWidgetType(CoD.PC_StartMenu_Options_Controls_KeyBinder)
	PCOptionGroup:setVerticalCount(3)
	PCOptionGroup:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PCOptionGroup:setDataSource("OptionGraphicContentPC")
	self:addElement(PCOptionGroup)
	self.PCOptionGroup = PCOptionGroup
	local OptionGroups = LUI.UIList.new(f1_local1, f1_arg0, 10, 0, nil, false, false, false, false)
	OptionGroups:setLeftRight(0.5, 0.5, -350, 350)
	OptionGroups:setTopBottom(0.5, 0.5, -23, 23)
	OptionGroups:setWidgetType(CoD.StartMenu_Options_SettingSlider_Wrapper)
	OptionGroups:setSpacing(10)
	OptionGroups:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	OptionGroups:setDataSource("PlayerSettingsFirstTimeContentList")
	OptionGroups:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_local1:AddButtonCallbackFunction(OptionGroups, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if HasListAction(element, controller) then
			ProcessListAction(self, element, controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if HasListAction(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(OptionGroups)
	self.OptionGroups = OptionGroups
	local OptionDesc = LUI.UIText.new(0.5, 0.5, -328, 321, 0.5, 0.5, -351, -330)
	OptionDesc:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	OptionDesc:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_3562DFE5E1BB4809"))
	OptionDesc:setTTF("dinnext_regular")
	OptionDesc:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	OptionDesc:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(OptionDesc)
	self.OptionDesc = OptionDesc
	local OptionTitle = LUI.UIText.new(0.5, 0.5, -328, 321, 0.5, 0.5, -400, -370)
	OptionTitle:setRGB(0.63, 0.57, 0.2)
	OptionTitle:setText(LocalizeToUpperString(@"menu/graphic_content"))
	OptionTitle:setTTF("ttmussels_regular")
	OptionTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	OptionTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	self:addElement(OptionTitle)
	self.OptionTitle = OptionTitle
	self:mergeStateConditions({
		{
			stateName = "DefaultStateKBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg0)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f1_local1
		f1_local1:updateElementState(self, f6_arg1)
	end)
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local9(f1_local8, f1_local10.LastInput, function(f7_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f7_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:registerEventHandler("input_source_changed", function(self, event)
		local f8_local0 = nil
		if IsPC() then
			SetFocusToElement(self, "OptionGroups", f1_arg0)
		end
		if not f8_local0 then
			f8_local0 = self:dispatchEventToChildren(event)
		end
		return f8_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		ClearMenuSavedState(menu)
		CoD.LobbyUtility.CompleteFirstTimeContentWarning(menu, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/confirm", nil, nil)
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		if IsPC() then
			CoD.LobbyUtility.CompleteFirstTimeContentWarning(f1_local1, f1_arg0)
		end
	end)
	CommomCenteredPopup.buttons:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		CommomCenteredPopup.id = "CommomCenteredPopup"
	end
	PCOptionGroup.id = "PCOptionGroup"
	OptionGroups.id = "OptionGroups"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = OptionGroups
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.DirectorFirstTimeContentWarning.__resetProperties = function(f12_arg0)
	f12_arg0.PCOptionGroup:completeAnimation()
	f12_arg0.OptionGroups:completeAnimation()
	f12_arg0.PCOptionGroup:setAlpha(0)
	f12_arg0.OptionGroups:setAlpha(1)
end
CoD.DirectorFirstTimeContentWarning.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
	DefaultStateKBM = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.PCOptionGroup:completeAnimation()
			f14_arg0.PCOptionGroup:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.PCOptionGroup)
			f14_arg0.OptionGroups:completeAnimation()
			f14_arg0.OptionGroups:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.OptionGroups)
		end,
	},
}
CoD.DirectorFirstTimeContentWarning.__onClose = function(f15_arg0)
	f15_arg0.CommomCenteredPopup:close()
	f15_arg0.PCOptionGroup:close()
	f15_arg0.OptionGroups:close()
end
