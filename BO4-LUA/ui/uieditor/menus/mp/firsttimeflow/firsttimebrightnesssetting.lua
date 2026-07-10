require("x64:71d4e66447f837e")
require("x64:17dcd66c5f1d136")
require("x64:d5504359f8c0fcd")
require("x64:7889ce1e3e2e8a")
require("x64:b42aabdb2e1a7d3")
require("x64:55aca670e9903a3")
require("x64:a9255c570c68aa8")
local PostLoadFunc = function(self, controller, menu)
	if CoD.isPC then
		self.continueButton:registerEventHandler("button_action", function(element, event)
			SetProfileVar(controller, "com_first_time", 0)
			UpdateGamerprofile(self, self, controller)
			ForceNotifyGlobalModel(controller, "mainFirstTimeFlowComplete")
		end)
	end
	if CoD.isDurango then
		self.XboxGamerTag:setText(Engine[@"hash_4F9F1239CFD921FE"](0x7C28F82C17DAE8, Engine[@"getgamertagforcontroller"](0)))
	else
		self.XboxGamerTag:setText("")
	end
end
CoD.FirstTimeBrightnessSetting = InheritFrom(CoD.Menu)
LUI.createMenu.FirstTimeBrightnessSetting = function(f3_arg0, f3_arg1)
	local self = CoD.Menu.NewForUIEditor("FirstTimeBrightnessSetting", f3_arg0)
	local f3_local1 = self
	MenuHidesFreeCursor(f3_local1, f3_arg0)
	CoD.BaseUtility.CreateControllerModel(f3_arg0, "profile.brightnessPreviewColor")
	self:setClass(CoD.FirstTimeBrightnessSetting)
	self.soundSet = "default"
	self:setOwner(f3_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f3_arg0)
	self.anyChildUsesUpdateState = true
	f3_local1:addElementToPendingUpdateStateList(self)
	local Background = CoD.StartMenuOptionsBackground.new(f3_local1, f3_arg0, 0.5, 1.5, -960, -960, 0.5, 1.5, -540.5, -540.5)
	self:addElement(Background)
	self.Background = Background
	local MenuFrame = CoD.MenuFrameIngame.new(f3_local1, f3_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	self:addElement(MenuFrame)
	self.MenuFrame = MenuFrame
	local OverlayLarge = LUI.UIImage.new(0, 1, 0, 0, 0.11, 0.11, 0, 900)
	OverlayLarge:setRGB(0, 0, 0)
	OverlayLarge:setAlpha(0)
	OverlayLarge:setupUIStreamedImage(0)
	self:addElement(OverlayLarge)
	self.OverlayLarge = OverlayLarge
	local OverlaySmall = LUI.UIImage.new(0.5, 0.5, -306, 306, 0.5, 0.5, -320, 320)
	OverlaySmall:setRGB(0, 0, 0)
	OverlaySmall:setAlpha(0.99)
	OverlaySmall:setZoom(40)
	OverlaySmall:setupUIStreamedImage(0)
	self:addElement(OverlaySmall)
	self.OverlaySmall = OverlaySmall
	local DescText = LUI.UIText.new(0.5, 0.5, -557, 557, 0, 0, 239.5, 260.5)
	DescText:setRGB(0.6, 0.6, 0.6)
	DescText:setZoom(40)
	DescText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_639538A6EEE7239A"))
	DescText:setTTF("ttmussels_regular")
	DescText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	DescText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(DescText)
	self.DescText = DescText
	local Logo = LUI.UIImage.new(0.5, 0.5, -210.5, 210.5, 0, 0, 324, 776)
	Logo:setZoom(40)
	Logo:setImage(RegisterImage(@"uie_ui_icon_startmenu_option_brightnesslogo"))
	Logo:setupUIStreamedImage(0)
	Logo:subscribeToGlobalModel(f3_arg0, "PerController", "profile.brightnessPreviewColor", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Logo:setRGB(f4_local0)
		end
	end)
	self:addElement(Logo)
	self.Logo = Logo
	local continueButton = CoD.GenericClickButton.new(f3_local1, f3_arg0, 0, 0, 938, 1141, 0, 0, 943, 1003)
	continueButton:setAlpha(0)
	continueButton:setZoom(50)
	continueButton.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/continue"))
	self:addElement(continueButton)
	self.continueButton = continueButton
	local XboxGamerTag = LUI.UIText.new(0.5, 0.5, -400, 400, 0, 0, 943, 982)
	XboxGamerTag:setZoom(50)
	XboxGamerTag:setText("")
	XboxGamerTag:setTTF("notosans_regular")
	XboxGamerTag:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(XboxGamerTag)
	self.XboxGamerTag = XboxGamerTag
	local Button = CoD.StartMenu_Options_SettingSlider.new(f3_local1, f3_arg0, 0.5, 0.5, -350, 350, 0, 0, 870, 916)
	Button:setZoom(50)
	self:addElement(Button)
	self.Button = Button
	local Header = CoD.StartMenuOptionsHeader.new(f3_local1, f3_arg0, 0, 1, 2, 2, 0, 0, 44, 124)
	Header.HeaderText:setText(LocalizeToUpperString(@"menu/brightness"))
	self:addElement(Header)
	self.Header = Header
	local BGFrame = CoD.StartMenuOptionsMainFrame.new(f3_local1, f3_arg0, 0.5, 0.5, -306, 306, 0.5, 0.5, -320, 320)
	BGFrame:setAlpha(0.01)
	BGFrame:setZoom(40)
	self:addElement(BGFrame)
	self.BGFrame = BGFrame
	local BGCorner = CoD.StartMenuOptionsMainCorners.new(f3_local1, f3_arg0, 0.5, 0.5, -306, 306, 0.5, 0.5, -320, 320)
	BGCorner:setAlpha(0.8)
	BGCorner:setZoom(40)
	self:addElement(BGCorner)
	self.BGCorner = BGCorner
	self:mergeStateConditions({
		{
			stateName = "KBMouse",
			condition = function(menu, element, event)
				return IsPC() and IsMouse(f3_arg0)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f3_local1
		f3_local1:updateElementState(self, f6_arg1)
	end)
	local f3_local14 = self
	local f3_local15 = self.subscribeToModel
	local f3_local16 = Engine[@"getmodelforcontroller"](f3_arg0)
	f3_local15(f3_local14, f3_local16.LastInput, function(f7_arg0)
		f3_local1:updateElementState(self, {
			name = "model_validation",
			menu = f3_local1,
			controller = f3_arg0,
			modelValue = f7_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	f3_local1:AddButtonCallbackFunction(self, f3_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		ClearMenuSavedState(menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"hash_0", nil, nil)
		return false
	end, false)
	f3_local1:AddButtonCallbackFunction(self, f3_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		CoD.OptionsUtility.ResetPlayerSettingToDefault(self.Button, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/default", nil, nil)
		return true
	end, false)
	f3_local1:AddButtonCallbackFunction(self, f3_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		ClearMenuSavedState(menu)
		CoD.LobbyUtility.CompleteFirstTimeBrightness(menu, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/confirm", nil, nil)
		return true
	end, false)
	self:subscribeToGlobalModel(f3_arg0, "PerController", "PlayerSettingsUpdate", function(model)
		local f14_local0 = self
		if CoD.ModelUtility.IsModelValueEqualTo(f3_arg0, "PlayerSettingsUpdate", "scene_brightness") then
			CoD.OptionsUtility.UpdateBrightnessPreviewColor(f3_arg0)
		end
	end)
	MenuFrame:setModel(self.buttonModel, f3_arg0)
	if CoD.isPC then
		MenuFrame.id = "MenuFrame"
	end
	continueButton.id = "continueButton"
	Button.id = "Button"
	self:processEvent({
		name = "menu_loaded",
		controller = f3_arg0,
	})
	self.__defaultFocus = Button
	if CoD.isPC and (IsKeyboard(f3_arg0) or self.ignoreCursor) then
		self:restoreState(f3_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f3_arg0)
	end
	f3_local15 = self
	CoD.OptionsUtility.SetPlayerSettingsModel(Button, f3_arg0, "scene_brightness")
	return self
end
CoD.FirstTimeBrightnessSetting.__resetProperties = function(f15_arg0)
	f15_arg0.continueButton:completeAnimation()
	f15_arg0.continueButton:setAlpha(0)
end
CoD.FirstTimeBrightnessSetting.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
	},
	KBMouse = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.continueButton:completeAnimation()
			f17_arg0.continueButton:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.continueButton)
		end,
	},
}
CoD.FirstTimeBrightnessSetting.__onClose = function(f18_arg0)
	f18_arg0.Background:close()
	f18_arg0.MenuFrame:close()
	f18_arg0.Logo:close()
	f18_arg0.continueButton:close()
	f18_arg0.Button:close()
	f18_arg0.Header:close()
	f18_arg0.BGFrame:close()
	f18_arg0.BGCorner:close()
end
