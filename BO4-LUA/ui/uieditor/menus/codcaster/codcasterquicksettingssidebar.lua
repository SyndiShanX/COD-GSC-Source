require("x64:e99196b904ad18")
require("x64:4c9a492524a6a24")
require("x64:e41af73729601d6")
require("x64:48be5c6feaceeb4")
require("x64:d5504359f8c0fcd")
require("x64:7889ce1e3e2e8a")
require("x64:19c1945d2e472b0")
require("x64:be779d5e87238aa")
local PostLoadFunc = function(f1_arg0, f1_arg1)
	f1_arg0.disableBlur = true
	f1_arg0.animateInFromOffset = -225
end
CoD.CodCasterQuickSettingsSideBar = InheritFrom(CoD.Menu)
LUI.createMenu.CodCasterQuickSettingsSideBar = function(f2_arg0, f2_arg1)
	local self = CoD.Menu.NewForUIEditor("CodCasterQuickSettingsSideBar", f2_arg0)
	local f2_local1 = self
	CoD.BaseUtility.InitGlobalModel("GametypeSettings.Update", nil)
	CoD.BaseUtility.InitGlobalModel("GametypeSettings.Reset", nil)
	MenuHidesFreeCursor(f2_local1, f2_arg0)
	self:setClass(CoD.CodCasterQuickSettingsSideBar)
	self.soundSet = "ChooseDecal"
	self:setOwner(f2_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f2_arg0)
	self.anyChildUsesUpdateState = true
	f2_local1:addElementToPendingUpdateStateList(self)
	local texture = LUI.UIImage.new(0, 0, 0, 820, 0, 0, 0, 1080)
	texture:setAlpha(0.75)
	texture:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	texture:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(texture)
	self.texture = texture
	local Background = CoD.StartMenuOptionsBackground.new(f2_local1, f2_arg0, 0, 0, -1100, 820, 0, 0, 0, 1080)
	self:addElement(Background)
	self.Background = Background
	local BackingBlack = CoD.CodCasterSettingFooter.new(f2_local1, f2_arg0, 0, 0, -246, 820, 0, 0, 1015, 1268)
	BackingBlack:setYRot(180)
	self:addElement(BackingBlack)
	self.BackingBlack = BackingBlack
	local OptionInfo = CoD.StartMenu_Options_SettingInfo.new(f2_local1, f2_arg0, 0, 0, 63, 763, 0, 0, 540, 644)
	self:addElement(OptionInfo)
	self.OptionInfo = OptionInfo
	local ButtonList = LUI.UIList.new(f2_local1, f2_arg0, 6, 0, nil, false, false, false, false)
	ButtonList:setLeftRight(0, 0, 63, 763)
	ButtonList:setTopBottom(0, 0, 126, 484)
	ButtonList:setWidgetType(CoD.StartMenu_Options_SettingSlider)
	ButtonList:setVerticalCount(7)
	ButtonList:setSpacing(6)
	ButtonList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ButtonList:setDataSource("CodCasterQuickSettingsList")
	ButtonList:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f3_local0
	end)
	f2_local1:AddButtonCallbackFunction(ButtonList, f2_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		ToggleCodCasterQuickSettings(self, element, controller)
		ToggleControllerModelValueNumber(controller, "CodCaster.profileSettingsUpdated")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, nil)
		return false
	end, false)
	self:addElement(ButtonList)
	self.ButtonList = ButtonList
	local BGSceneBlur = LUI.UIImage.new(0, 0, 0, 820, 0, 0, -15.5, 51.5)
	BGSceneBlur:setRGB(ColorSet.Title.r, ColorSet.Title.g, ColorSet.Title.b)
	BGSceneBlur:setAlpha(0)
	self:addElement(BGSceneBlur)
	self.BGSceneBlur = BGSceneBlur
	local f2_local8 = nil
	self.background2 = LUI.UIElement.createFake()
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f2_local1, f2_arg0, 0, 0, -164, 820, 0, 0, 9.5, 51.5)
	DotTiledBacking:setAlpha(0.5)
	DotTiledBacking.NoiseBacking:setAlpha(0)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local TopBar2 = LUI.UIImage.new(0, 0, 0, 820, 0, 0, 51, 54)
	TopBar2:setRGB(0.46, 0.46, 0.51)
	TopBar2:setAlpha(0.8)
	TopBar2:setImage(RegisterImage(0x42BCCF45B82FBED))
	TopBar2:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	TopBar2:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(TopBar2)
	self.TopBar2 = TopBar2
	local BackingGrayMediumLeft = CoD.header_container_frontend.new(f2_local1, f2_arg0, 0, 0, -131, 689, 0, 0, 0.5, 42.5)
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	local Title = LUI.UIText.new(0, 0, 63, 381, 0, 0, 15.5, 45.5)
	Title:setRGB(ColorSet.T8__GOLD.r, ColorSet.T8__GOLD.g, ColorSet.T8__GOLD.b)
	Title:setText(LocalizeToUpperString(0x4EA93CFFE505B27))
	Title:setTTF("ttmussels_regular")
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Title:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(Title)
	self.Title = Title
	local FooterContainerIngameRight = CoD.CodCasterSettingsSideBarLeftbuttoncontainer.new(f2_local1, f2_arg0, 0, 0, 140, 720, 0, 0, 1032, 1080)
	self:addElement(FooterContainerIngameRight)
	self.FooterContainerIngameRight = FooterContainerIngameRight
	local backButton = nil
	backButton = CoD.featureOverlay_Button.new(f2_local1, f2_arg0, 0, 0, 563, 763, 0, 0, 924, 984)
	backButton.ButtonContainer.Title:setText(Engine[0xF9F1239CFD921FE](0x70A9FDC87CD3D48))
	backButton:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f6_local0
	end)
	f2_local1:AddButtonCallbackFunction(backButton, f2_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "MOUSE1", function(element, menu, controller, model)
		CoD.GridAndListUtility.SetFocusToFirstSelectableItem(self.ButtonList)
		ToggleControllerModelValueNumber(controller, "CodCaster.showQuickSettingsSideBar")
		SaveShoutcasterSettings(self, element, controller)
		GoBack(self, controller)
		SetLuiKeyCatcher(false)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "MOUSE1")
		return false
	end, false)
	self:addElement(backButton)
	self.backButton = backButton
	local resetButton = nil
	resetButton = CoD.featureOverlay_Button.new(f2_local1, f2_arg0, 0, 0, 302, 502, 0, 0, 924, 984)
	resetButton.ButtonContainer.Title:setText(Engine[0xF9F1239CFD921FE](0xFA987631536BD44))
	resetButton:registerEventHandler("gain_focus", function(element, event)
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f9_local0
	end)
	f2_local1:AddButtonCallbackFunction(resetButton, f2_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "MOUSE1", function(element, menu, controller, model)
		CoD.CodCasterUtility.OpenResetCodCasterSettingsPopup(self, element, controller, "", menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "MOUSE1")
		return false
	end, false)
	self:addElement(resetButton)
	self.resetButton = resetButton
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return Engine[0xDD333420C49E6D0](f2_arg0, Enum[0x7F032C2EF103A1A][0x198075B069840DC])
			end,
		},
		{
			stateName = "PCGamepad",
			condition = function(menu, element, event)
				return IsPC() and IsGamepad(f2_arg0)
			end,
		},
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	local f2_local16 = self
	local f2_local17 = self.subscribeToModel
	local f2_local18 = Engine[0x4DF5CFBC1771947](f2_arg0)
	f2_local17(f2_local16, f2_local18["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f15_arg0)
		f2_local1:updateElementState(self, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f16_arg0, f16_arg1)
		f16_arg1.menu = f16_arg1.menu or f2_local1
		f2_local1:updateElementState(self, f16_arg1)
	end)
	f2_local16 = self
	f2_local17 = self.subscribeToModel
	f2_local18 = Engine[0x4DF5CFBC1771947](f2_arg0)
	f2_local17(f2_local16, f2_local18.LastInput, function(f17_arg0)
		f2_local1:updateElementState(self, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f17_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f18_arg0, f18_arg1)
		f18_arg1.menu = f18_arg1.menu or f2_local1
		CoD.Menu.UpdateButtonShownState(f18_arg0, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end)
	f2_local16 = self
	f2_local17 = self.subscribeToModel
	f2_local18 = Engine[0x4DF5CFBC1771947](f2_arg0)
	f2_local17(f2_local16, f2_local18.LastInput, function(f19_arg0, f19_arg1)
		CoD.Menu.UpdateButtonShownState(f19_arg1, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], "R", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			CoD.GridAndListUtility.SetFocusToFirstSelectableItem(self.ButtonList)
			ToggleControllerModelValueNumber(controller, "CodCaster.showQuickSettingsSideBar")
			SaveShoutcasterSettings(self, element, controller)
			GoBack(self, controller)
			SetLuiKeyCatcher(false)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], 0x70A9FDC87CD3D48, nil, "R")
			return true
		else
			return false
		end
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], "ui_contextual_2", function(element, menu, controller, model)
		if IsGamepad(controller) then
			CoD.CodCasterUtility.ResetCodcasterSettingsGamepad(controller, menu)
			PlaySoundAlias("uin_party_ease_slide")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0xFA987631536BD44, Enum[0xBEBDBAEEB3ECCCA][0x2919C98A7A845F0] | 750 << Enum[0xBEBDBAEEB3ECCCA][0x76ADD225D738C93], "ui_contextual_2")
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f24_arg2, f24_arg3, f24_arg4)
		if IsMenuInState(f2_local1, "Hidden") then
			CoD.GridAndListUtility.SetFocusToFirstSelectableItem(self.ButtonList)
			ToggleControllerModelValueNumber(controller, "CodCaster.showQuickSettingsSideBar")
			SaveShoutcasterSettings(self, element, controller)
			GoBack(self, controller)
			SetLuiKeyCatcher(false)
		end
	end)
	ButtonList.id = "ButtonList"
	FooterContainerIngameRight:setModel(self.buttonModel, f2_arg0)
	if CoD.isPC then
		FooterContainerIngameRight.id = "FooterContainerIngameRight"
	end
	if CoD.isPC then
		backButton.id = "backButton"
	end
	if CoD.isPC then
		resetButton.id = "resetButton"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f2_arg0,
	})
	self.__defaultFocus = ButtonList
	if CoD.isPC and (IsKeyboard(f2_arg0) or self.ignoreCursor) then
		self:restoreState(f2_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f2_arg0)
	end
	return self
end
CoD.CodCasterQuickSettingsSideBar.__resetProperties = function(f25_arg0)
	f25_arg0.backButton:completeAnimation()
	f25_arg0.resetButton:completeAnimation()
	f25_arg0.FooterContainerIngameRight:completeAnimation()
	f25_arg0.Title:completeAnimation()
	f25_arg0.BackingGrayMediumLeft:completeAnimation()
	f25_arg0.TopBar2:completeAnimation()
	f25_arg0.DotTiledBacking:completeAnimation()
	f25_arg0.background2:completeAnimation()
	f25_arg0.BGSceneBlur:completeAnimation()
	f25_arg0.ButtonList:completeAnimation()
	f25_arg0.OptionInfo:completeAnimation()
	f25_arg0.BackingBlack:completeAnimation()
	f25_arg0.Background:completeAnimation()
	f25_arg0.texture:completeAnimation()
	f25_arg0.backButton:setAlpha(1)
	f25_arg0.backButton.ButtonContainer.Title:setText(Engine[0xF9F1239CFD921FE](0x70A9FDC87CD3D48))
	f25_arg0.resetButton:setAlpha(1)
	f25_arg0.resetButton.ButtonContainer.Title:setText(Engine[0xF9F1239CFD921FE](0xFA987631536BD44))
	f25_arg0.FooterContainerIngameRight:setLeftRight(0, 0, 140, 720)
	f25_arg0.FooterContainerIngameRight:setTopBottom(0, 0, 1032, 1080)
	f25_arg0.FooterContainerIngameRight:setAlpha(1)
	f25_arg0.Title:setAlpha(1)
	f25_arg0.BackingGrayMediumLeft:setAlpha(1)
	f25_arg0.TopBar2:setAlpha(0.8)
	f25_arg0.DotTiledBacking:setAlpha(0.5)
	f25_arg0.background2:setAlpha(0.2)
	f25_arg0.BGSceneBlur:setAlpha(0)
	f25_arg0.ButtonList:setAlpha(1)
	f25_arg0.OptionInfo:setAlpha(1)
	f25_arg0.BackingBlack:setAlpha(1)
	f25_arg0.Background:setTopBottom(0, 0, 0, 1080)
	f25_arg0.Background:setAlpha(1)
	f25_arg0.texture:setAlpha(0.75)
end
CoD.CodCasterQuickSettingsSideBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			f26_arg0.backButton:completeAnimation()
			f26_arg0.backButton.ButtonContainer.Title:completeAnimation()
			f26_arg0.backButton.ButtonContainer.Title:setText(Engine[0xF9F1239CFD921FE](0xFA987631536BD44))
			f26_arg0.clipFinished(f26_arg0.backButton)
		end,
	},
	Hidden = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(13)
			f27_arg0.texture:completeAnimation()
			f27_arg0.texture:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.texture)
			f27_arg0.Background:completeAnimation()
			f27_arg0.Background:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.Background)
			f27_arg0.BackingBlack:completeAnimation()
			f27_arg0.BackingBlack:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.BackingBlack)
			f27_arg0.OptionInfo:completeAnimation()
			f27_arg0.OptionInfo:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.OptionInfo)
			f27_arg0.ButtonList:completeAnimation()
			f27_arg0.ButtonList:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.ButtonList)
			f27_arg0.BGSceneBlur:completeAnimation()
			f27_arg0.BGSceneBlur:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.BGSceneBlur)
			f27_arg0.background2:completeAnimation()
			f27_arg0.background2:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.background2)
			f27_arg0.DotTiledBacking:completeAnimation()
			f27_arg0.DotTiledBacking:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.DotTiledBacking)
			f27_arg0.TopBar2:completeAnimation()
			f27_arg0.TopBar2:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.TopBar2)
			f27_arg0.BackingGrayMediumLeft:completeAnimation()
			f27_arg0.BackingGrayMediumLeft:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.BackingGrayMediumLeft)
			f27_arg0.Title:completeAnimation()
			f27_arg0.Title:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.Title)
			f27_arg0.FooterContainerIngameRight:completeAnimation()
			f27_arg0.FooterContainerIngameRight:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.FooterContainerIngameRight)
			f27_arg0.backButton:completeAnimation()
			f27_arg0.backButton:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.backButton)
			f27_arg0.resetButton:completeAnimation()
			f27_arg0.resetButton:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.resetButton)
		end,
	},
	PCGamepad = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(5)
			f28_arg0.Background:completeAnimation()
			f28_arg0.Background:setTopBottom(0, 0, 0, 1200)
			f28_arg0.clipFinished(f28_arg0.Background)
			f28_arg0.BackingBlack:completeAnimation()
			f28_arg0.BackingBlack:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.BackingBlack)
			f28_arg0.FooterContainerIngameRight:completeAnimation()
			f28_arg0.FooterContainerIngameRight:setLeftRight(0, 0, 0, 820)
			f28_arg0.FooterContainerIngameRight:setTopBottom(1, 1, -48, 0)
			f28_arg0.FooterContainerIngameRight:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.FooterContainerIngameRight)
			f28_arg0.backButton:completeAnimation()
			f28_arg0.backButton:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.backButton)
			f28_arg0.resetButton:completeAnimation()
			f28_arg0.resetButton:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.resetButton)
		end,
	},
	PC = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(5)
			f29_arg0.Background:completeAnimation()
			f29_arg0.Background:setTopBottom(0, 0, 0, 1200)
			f29_arg0.clipFinished(f29_arg0.Background)
			f29_arg0.BackingBlack:completeAnimation()
			f29_arg0.BackingBlack:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.BackingBlack)
			f29_arg0.FooterContainerIngameRight:completeAnimation()
			f29_arg0.FooterContainerIngameRight:setLeftRight(0, 0, 0, 820)
			f29_arg0.FooterContainerIngameRight:setTopBottom(1, 1, -48, 0)
			f29_arg0.FooterContainerIngameRight:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.FooterContainerIngameRight)
			f29_arg0.backButton:completeAnimation()
			f29_arg0.backButton.ButtonContainer.Title:completeAnimation()
			f29_arg0.backButton.ButtonContainer.Title:setText(Engine[0xF9F1239CFD921FE](0x70A9FDC87CD3D48))
			f29_arg0.clipFinished(f29_arg0.backButton)
			f29_arg0.resetButton:completeAnimation()
			f29_arg0.resetButton.ButtonContainer.Title:completeAnimation()
			f29_arg0.resetButton:setAlpha(1)
			f29_arg0.resetButton.ButtonContainer.Title:setText(Engine[0xF9F1239CFD921FE](0xFA987631536BD44))
			f29_arg0.clipFinished(f29_arg0.resetButton)
		end,
	},
}
CoD.CodCasterQuickSettingsSideBar.__onClose = function(f30_arg0)
	f30_arg0.Background:close()
	f30_arg0.BackingBlack:close()
	f30_arg0.OptionInfo:close()
	f30_arg0.ButtonList:close()
	f30_arg0.DotTiledBacking:close()
	f30_arg0.BackingGrayMediumLeft:close()
	f30_arg0.FooterContainerIngameRight:close()
	f30_arg0.backButton:close()
	f30_arg0.resetButton:close()
end
