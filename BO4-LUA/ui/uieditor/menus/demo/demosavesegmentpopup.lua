require("x64:c2f840fd2528321")
require("x64:3f0c583dc4db051")
require("x64:d7ba7c36104672")
require("x64:5498fd235ed9285")
require("x64:8a2bfd7fd77a149")
CoD.DemoSaveSegmentPopup = InheritFrom(CoD.Menu)
LUI.createMenu.DemoSaveSegmentPopup = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("DemoSaveSegmentPopup", f1_arg0)
	local f1_local1 = self
	if IsPC() then
		CoD.BaseUtility.InitControllerModel(f1_arg0, "DemoTitleText")
	end
	self:setClass(CoD.DemoSaveSegmentPopup)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local emptyFocusableNoCursorUpdate = nil
	emptyFocusableNoCursorUpdate = CoD.emptyFocusableNoCursorUpdate.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(emptyFocusableNoCursorUpdate)
	self.emptyFocusableNoCursorUpdate = emptyFocusableNoCursorUpdate
	local FullscreenPopupTemplate = CoD.FullscreenPopupTemplate.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	FullscreenPopupTemplate.Subtitle:setText(Engine[0xF9F1239CFD921FE](0x7BDC7223FDD20A0))
	FullscreenPopupTemplate.ErrorSubtitle:setText(Engine[0xF9F1239CFD921FE](0x9C62D3C1C35DC01))
	FullscreenPopupTemplate.WorkingTitle:setText(Engine[0xF9F1239CFD921FE](0xC76223999D97EC9))
	FullscreenPopupTemplate.Title:setText(Engine[0xF9F1239CFD921FE](0x471098B0579A24C))
	FullscreenPopupTemplate.DoneTitle:setText(LocalizeToUpperString(0x93E719493E9E18F))
	self:addElement(FullscreenPopupTemplate)
	self.FullscreenPopupTemplate = FullscreenPopupTemplate
	local TitleText = LUI.UIText.new(0.5, 0.5, -267, 835, 0.5, 0.5, -93, -72)
	TitleText:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	TitleText:setText(Engine[0xF9F1239CFD921FE](0x6C2F065A6AA8DA7))
	TitleText:setTTF("ttmussels_regular")
	TitleText:setLetterSpacing(2)
	TitleText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TitleText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(TitleText)
	self.TitleText = TitleText
	local TitlePreview = LUI.UIText.new(0.5, 0.5, -267, 835, 0.5, 0.5, 0, 21)
	TitlePreview:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	TitlePreview:setText(Engine[0xF9F1239CFD921FE](0x9E22C6CE275ABC3))
	TitlePreview:setTTF("ttmussels_regular")
	TitlePreview:setLetterSpacing(2)
	TitlePreview:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TitlePreview:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(TitlePreview)
	self.TitlePreview = TitlePreview
	local LblPermissions = LUI.UIText.new(0.5, 0.5, -267, -217, 0.5, 0.5, 88, 126)
	LblPermissions:setAlpha(0)
	LblPermissions:setText(Engine[0xF9F1239CFD921FE](0x843FACDBE21C207))
	LblPermissions:setTTF("default")
	LblPermissions:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	LblPermissions:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(LblPermissions)
	self.LblPermissions = LblPermissions
	local leftButtonBar = CoD.fe_LeftContainer_NOTLobby.new(f1_local1, f1_arg0, 0.5, 0.5, -350, 298, 0.5, 0.5, 188, 236)
	self:addElement(leftButtonBar)
	self.leftButtonBar = leftButtonBar
	local ButtonSave = CoD.EmblemOptionsButton.new(f1_local1, f1_arg0, 0.5, 0.5, -267, 133, 0.5, 0.5, 114, 174)
	ButtonSave.Button.Title:setText(Engine[0xF9F1239CFD921FE](0x3B7168B75575032))
	ButtonSave:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f2_local0
	end)
	f1_local1:AddButtonCallbackFunction(ButtonSave, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ENTER", function(element, menu, controller, model)
		CoD.DemoUtility.SaveSegment(menu, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ENTER")
		return true
	end, false)
	self:addElement(ButtonSave)
	self.ButtonSave = ButtonSave
	local ButtonPreview = CoD.EmblemOptionsButton.new(f1_local1, f1_arg0, 0.5, 0.5, -267, 133, 0.5, 0.5, 24, 84)
	ButtonPreview.Button.Title:setText(Engine[0xF9F1239CFD921FE](0x9E22C6CE275ABC3))
	ButtonPreview:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f5_local0
	end)
	f1_local1:AddButtonCallbackFunction(ButtonPreview, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		CoD.DemoUtility.PreviewSegment(menu, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	self:addElement(ButtonPreview)
	self.ButtonPreview = ButtonPreview
	local f1_local10 = nil
	f1_local10 = LUI.UIElement.createFake()
	self.ButtonTitle = f1_local10
	local TitleTextBox = nil
	TitleTextBox = CoD.DemoRenameTextBox.new(f1_local1, f1_arg0, 0.5, 0.5, -274, 138, 0.5, 0.5, -67, -7)
	TitleTextBox:mergeStateConditions({
		{
			stateName = "InputState",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsControllerModelValueNonEmptyString(f1_arg0, "DemoTitleText")
			end,
		},
	})
	local f1_local12 = TitleTextBox
	local f1_local13 = TitleTextBox.subscribeToModel
	local f1_local14 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local13(f1_local12, f1_local14.DemoTitleText, function(f9_arg0)
		f1_local1:updateElementState(TitleTextBox, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f9_arg0:get(),
			modelName = "DemoTitleText",
		})
	end, false)
	TitleTextBox:subscribeToGlobalModel(f1_arg0, "Demo", "segmentName", function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			TitleTextBox.RenameText:setText(CoD.BaseUtility.LocalizeIfXHash(f10_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(TitleTextBox, "childFocusLost", function(element)
		if CoD.ModelUtility.IsControllerModelValueNonEmptyString(f1_arg0, "DemoTitleText") then
			SetElementState(self, element, f1_arg0, "DefaultState")
			CoD.DemoUtility.SaveFileProperty(element, Enum[0xEAFC1D0E771FFBD][0x107B30313EA4156])
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(TitleTextBox, "close", function(element)
		if IsPC() then
			SetControllerModelValue(f1_arg0, "DemoTitleText", "")
		end
	end)
	self:addElement(TitleTextBox)
	self.TitleTextBox = TitleTextBox
	if CoD.isPC then
		emptyFocusableNoCursorUpdate.id = "emptyFocusableNoCursorUpdate"
	end
	FullscreenPopupTemplate.id = "FullscreenPopupTemplate"
	leftButtonBar:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		leftButtonBar.id = "leftButtonBar"
	end
	ButtonSave.id = "ButtonSave"
	ButtonPreview.id = "ButtonPreview"
	f1_local10.id = "ButtonTitle"
	if CoD.isPC then
		TitleTextBox.id = "TitleTextBox"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local13 = self
	f1_local13 = TitleTextBox
	if IsPC() then
		CoD.PCUtility.SetElementEditBoxMaxChar(f1_local13, 16)
		CoD.PCUtility.MakeElementEditBoxRealtime(f1_local13, "DemoTitleText")
		CoD.PCUtility.SetupElementEditControlWithControllerModel(f1_local13, f1_arg0, f1_local1, "DemoTitleText")
	end
	return self
end
CoD.DemoSaveSegmentPopup.__onClose = function(f13_arg0)
	f13_arg0.emptyFocusableNoCursorUpdate:close()
	f13_arg0.FullscreenPopupTemplate:close()
	f13_arg0.leftButtonBar:close()
	f13_arg0.ButtonSave:close()
	f13_arg0.ButtonPreview:close()
	f13_arg0.ButtonTitle:close()
	f13_arg0.TitleTextBox:close()
end
