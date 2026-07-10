require("x64:1b66f971ffa1f09")
require("x64:fe9df26e257edb3")
require("x64:ba72b08fda6493")
CoD.CustomGames_BotSettingsPopup = InheritFrom(CoD.Menu)
LUI.createMenu.CustomGames_BotSettingsPopup = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("CustomGames_BotSettingsPopup", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.CustomGames_BotSettingsPopup)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local CommomCenteredPopup = CoD.CommonCenteredPopup.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	CommomCenteredPopup.TitleText:setText(LocalizeToUpperString(@"menu/bot_settings"))
	CommomCenteredPopup.HeaderBackground:setAlpha(0)
	CommomCenteredPopup.HeaderTopBar:setAlpha(0)
	CommomCenteredPopup.HeaderBottomBar:setAlpha(0)
	self:addElement(CommomCenteredPopup)
	self.CommomCenteredPopup = CommomCenteredPopup
	local BotSettingsList = LUI.UIList.new(f1_local1, f1_arg0, 2, 0, nil, false, false, false, false)
	BotSettingsList:setLeftRight(0.5, 0.5, -250, 250)
	BotSettingsList:setTopBottom(0.5, 0.5, -380, -320)
	BotSettingsList:setAutoScaleContent(true)
	BotSettingsList:setWidgetType(CoD.CustomGames_SettingSliderNoCustom)
	BotSettingsList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	BotSettingsList:setDataSource("BotSettings")
	self:addElement(BotSettingsList)
	self.BotSettingsList = BotSettingsList
	local SettingDescription = LUI.UIText.new(0.5, 0.5, -250, 250, 0.5, 0.5, -284, -263)
	SettingDescription:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	SettingDescription:setTTF("dinnext_regular")
	SettingDescription:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	SettingDescription:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(SettingDescription)
	self.SettingDescription = SettingDescription
	local PCSmallCloseButton = nil
	PCSmallCloseButton = CoD.PC_SmallCloseButton.new(f1_local1, f1_arg0, 0.5, 0.5, 308, 342, 0.5, 0.5, -438.5, -404.5)
	PCSmallCloseButton:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_none"])
		return f2_local0
	end)
	f1_local1:AddButtonCallbackFunction(PCSmallCloseButton, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "MOUSE1", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MOUSE1")
		return false
	end, false)
	f1_local1:AddButtonCallbackFunction(PCSmallCloseButton, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "ui_confirm", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	self:addElement(PCSmallCloseButton)
	self.PCSmallCloseButton = PCSmallCloseButton
	SettingDescription:linkToElementModel(BotSettingsList, "desc", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			SettingDescription:setText(Engine[@"hash_4F9F1239CFD921FE"](f7_local0))
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg0)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f9_arg0, f9_arg1)
		f9_arg1.menu = f9_arg1.menu or f1_local1
		f1_local1:updateElementState(self, f9_arg1)
	end)
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local7(f1_local6, f1_local8.LastInput, function(f10_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f10_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		ClearMenuSavedState(menu)
		ForceNotifyGlobalModel(controller, "GametypeSettings.Update")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	CommomCenteredPopup.buttons:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		CommomCenteredPopup.id = "CommomCenteredPopup"
	end
	BotSettingsList.id = "BotSettingsList"
	if CoD.isPC then
		PCSmallCloseButton.id = "PCSmallCloseButton"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = BotSettingsList
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local7 = self
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	return self
end
CoD.CustomGames_BotSettingsPopup.__resetProperties = function(f13_arg0)
	f13_arg0.BotSettingsList:completeAnimation()
	f13_arg0.SettingDescription:completeAnimation()
	f13_arg0.BotSettingsList:setLeftRight(0.5, 0.5, -250, 250)
	f13_arg0.SettingDescription:setLeftRight(0.5, 0.5, -250, 250)
end
CoD.CustomGames_BotSettingsPopup.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
	},
	KBM = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.BotSettingsList:completeAnimation()
			f15_arg0.BotSettingsList:setLeftRight(0.5, 0.5, -290, 290)
			f15_arg0.clipFinished(f15_arg0.BotSettingsList)
			f15_arg0.SettingDescription:completeAnimation()
			f15_arg0.SettingDescription:setLeftRight(0.5, 0.5, -290, 290)
			f15_arg0.clipFinished(f15_arg0.SettingDescription)
		end,
	},
}
CoD.CustomGames_BotSettingsPopup.__onClose = function(f16_arg0)
	f16_arg0.SettingDescription:close()
	f16_arg0.CommomCenteredPopup:close()
	f16_arg0.BotSettingsList:close()
	f16_arg0.PCSmallCloseButton:close()
end
