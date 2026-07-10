require("x64:71c0f535bc61e87")
require("x64:4868cce57a2eed8")
require("x64:ba72b08fda6493")
require("x64:c829ac7d797ba4c")
CoD.ScorestreakOverCapacity = InheritFrom(CoD.Menu)
LUI.createMenu.ScorestreakOverCapacity = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("ScorestreakOverCapacity", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	self:setClass(CoD.ScorestreakOverCapacity)
	self.soundSet = "CAC_Overcapacity"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local background = CoD.CACFullPopupBackground.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	background:linkToElementModel(self, nil, false, function(model)
		background.buttons:setModel(model, f1_arg0)
	end)
	self:addElement(background)
	self.background = background
	local Description = LUI.UIText.new(0.5, 0.5, -412, 607, 0, 0, 384, 405)
	Description:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Description:setText(Engine[0xF9F1239CFD921FE](0x907CEE75F9A972D))
	Description:setTTF("dinnext_regular")
	Description:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Description:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Description)
	self.Description = Description
	local Title = LUI.UIText.new(0.5, 0.5, -412, 607, 0, 0, 319, 364)
	Title:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	Title:setText(LocalizeToUpperString(0x7F7631DF17A852D))
	Title:setTTF("ttmussels_demibold")
	Title:setLetterSpacing(6)
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Title:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Title)
	self.Title = Title
	local EquippedScorestreaks = LUI.UIList.new(f1_local1, f1_arg0, 30, 0, nil, false, false, false, false)
	EquippedScorestreaks:mergeStateConditions({
		{
			stateName = "Focusable",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	EquippedScorestreaks:linkToElementModel(EquippedScorestreaks, "itemIndex", true, function(model)
		f1_local1:updateElementState(EquippedScorestreaks, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	EquippedScorestreaks:setLeftRight(0.5, 0.5, -317, 43)
	EquippedScorestreaks:setTopBottom(0, 0, 490, 640)
	EquippedScorestreaks:setScale(1.5, 1.5)
	EquippedScorestreaks:setWidgetType(CoD.EquippedScorestreakListItem)
	EquippedScorestreaks:setHorizontalCount(3)
	EquippedScorestreaks:setSpacing(30)
	EquippedScorestreaks:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	EquippedScorestreaks:setDataSource("EquippedScorestreaks")
	EquippedScorestreaks:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f5_local0
	end)
	f1_local1:AddButtonCallbackFunction(EquippedScorestreaks, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		CoD.ScorestreakSelectUtility.SwapScorestreaks(element, controller, menu)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
		return true
	end, false)
	self:addElement(EquippedScorestreaks)
	self.EquippedScorestreaks = EquippedScorestreaks
	local SelectedImage = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -931.5, -484.5, 0, 0, 331.5, 778.5)
	SelectedImage:setAlpha(0.95)
	SelectedImage:linkToElementModel(self, "iconLarge", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			SelectedImage:setImage(CoD.BaseUtility.AlreadyRegistered(f8_local0))
		end
	end)
	self:addElement(SelectedImage)
	self.SelectedImage = SelectedImage
	local featureOverlayButtonMouseOnly = nil
	featureOverlayButtonMouseOnly = CoD.featureOverlay_Button_MouseOnly.new(f1_local1, f1_arg0, 0.5, 0.5, -406, -280, 0, 0, 691, 748)
	featureOverlayButtonMouseOnly.featureOverlayButtonContainer.Title:setText(Engine[0xF9F1239CFD921FE](0x78D439E1B360368))
	featureOverlayButtonMouseOnly:registerEventHandler("gain_focus", function(element, event)
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f9_local0
	end)
	f1_local1:AddButtonCallbackFunction(featureOverlayButtonMouseOnly, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		PlaySoundSetSound(self, "menu_no_selection")
		ClearMenuSavedState(menu)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(featureOverlayButtonMouseOnly)
	self.featureOverlayButtonMouseOnly = featureOverlayButtonMouseOnly
	local PCSmallCloseButton = nil
	PCSmallCloseButton = CoD.PC_SmallCloseButton.new(f1_local1, f1_arg0, 0.5, 0.5, 846, 880, 0.5, 0.5, -221, -187)
	PCSmallCloseButton:registerEventHandler("gain_focus", function(element, event)
		local f12_local0 = nil
		if element.gainFocus then
			f12_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f12_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		return f12_local0
	end)
	f1_local1:AddButtonCallbackFunction(PCSmallCloseButton, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "MOUSE1", function(element, menu, controller, model)
		PlaySoundSetSound(self, "menu_no_selection")
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "MOUSE1")
		return false
	end, false)
	f1_local1:AddButtonCallbackFunction(PCSmallCloseButton, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_confirm", function(element, menu, controller, model)
		PlaySoundSetSound(self, "menu_no_selection")
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(PCSmallCloseButton)
	self.PCSmallCloseButton = PCSmallCloseButton
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		PlaySoundSetSound(self, "menu_no_selection")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		ClearMenuSavedState(f1_local1)
	end)
	background:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		background.id = "background"
	end
	EquippedScorestreaks.id = "EquippedScorestreaks"
	if CoD.isPC then
		featureOverlayButtonMouseOnly.id = "featureOverlayButtonMouseOnly"
	end
	if CoD.isPC then
		PCSmallCloseButton.id = "PCSmallCloseButton"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = EquippedScorestreaks
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local9 = self
	if IsPC() then
		CoD.BaseUtility.SetModelFromPropertyModel(f1_arg0, self, f1_local9)
		CoD.PCUtility.SetupUIMenuShortcutBlocker(self, f1_local1)
		MenuHidesFreeCursor(f1_local1, f1_arg0)
	else
		CoD.BaseUtility.SetModelFromPropertyModel(f1_arg0, self, f1_local9)
		MenuHidesFreeCursor(f1_local1, f1_arg0)
	end
	return self
end
CoD.ScorestreakOverCapacity.__onClose = function(f20_arg0)
	f20_arg0.background:close()
	f20_arg0.EquippedScorestreaks:close()
	f20_arg0.SelectedImage:close()
	f20_arg0.featureOverlayButtonMouseOnly:close()
	f20_arg0.PCSmallCloseButton:close()
end
