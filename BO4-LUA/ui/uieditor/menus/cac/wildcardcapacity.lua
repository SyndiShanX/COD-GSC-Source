require("x64:71c0f535bc61e87")
require("x64:4c5f8b13130c111")
require("x64:c829ac7d797ba4c")
CoD.WildcardCapacity = InheritFrom(CoD.Menu)
LUI.createMenu.WildcardCapacity = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("WildcardCapacity", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	self:setClass(CoD.WildcardCapacity)
	self.soundSet = "CAC_Overcapacity"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local background = CoD.CACFullPopupBackground.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 1080)
	background:linkToElementModel(self, nil, false, function(model)
		background.buttons:setModel(model, f1_arg0)
	end)
	self:addElement(background)
	self.background = background
	local Title = LUI.UIText.new(0, 0, 154, 1173, 0, 0, 186, 245)
	Title:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Title:setText(LocalizeToUpperString(0xE2C3AE1D6F2A2A3))
	Title:setTTF("ttmussels_demibold")
	Title:setLetterSpacing(6)
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Title:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Title)
	self.Title = Title
	local Description = LUI.UIText.new(0, 0, 705, 1724, 0, 0, 365, 387)
	Description:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Description:setText(Engine[0xF9F1239CFD921FE](0xA83310B9F003575))
	Description:setTTF("dinnext_regular")
	Description:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Description:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Description)
	self.Description = Description
	local SelectedImage = LUI.UIFixedAspectRatioImage.new(0, 0, 147, 594, 0, 0, 325.5, 772.5)
	SelectedImage:setAlpha(0.95)
	self:addElement(SelectedImage)
	self.SelectedImage = SelectedImage
	local selectionList = LUI.UIList.new(f1_local1, f1_arg0, 15, 0, nil, true, false, false, false)
	selectionList:setLeftRight(0, 0, 706, 1336)
	selectionList:setTopBottom(0, 0, 488, 588)
	selectionList:setWidgetType(CoD.OverCapacityItem)
	selectionList:setHorizontalCount(3)
	selectionList:setSpacing(15)
	selectionList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	selectionList:setDataSource("WildcardOvercapacityList")
	selectionList:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f3_local0
	end)
	f1_local1:AddButtonCallbackFunction(selectionList, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		RemoveOverflowWildcardFromClass(self, element, menu, controller, "WildcardSelect")
		CoD.CACUtility.EquippedItemsChanged(menu, controller)
		PlaySoundAlias("cac_overload_select")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x679ACA6FFC6C8F3, nil, "ui_confirm")
		return true
	end, false)
	self:addElement(selectionList)
	self.selectionList = selectionList
	local featureOverlayButtonMouseOnly = nil
	featureOverlayButtonMouseOnly = CoD.featureOverlay_Button_MouseOnly.new(f1_local1, f1_arg0, 0.5, 0.5, -255, -129, 0, 0, 675, 732)
	featureOverlayButtonMouseOnly.featureOverlayButtonContainer.Title:setText(Engine[0xF9F1239CFD921FE](0x78D439E1B360368))
	featureOverlayButtonMouseOnly:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f6_local0
	end)
	f1_local1:AddButtonCallbackFunction(featureOverlayButtonMouseOnly, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		PlaySoundSetSound(self, "menu_no_selection")
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(featureOverlayButtonMouseOnly)
	self.featureOverlayButtonMouseOnly = featureOverlayButtonMouseOnly
	SelectedImage:linkToElementModel(selectionList, "image", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			SelectedImage:setImage(RegisterImage(f9_local0))
		end
	end)
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
	selectionList.id = "selectionList"
	if CoD.isPC then
		featureOverlayButtonMouseOnly.id = "featureOverlayButtonMouseOnly"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = selectionList
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local8 = self
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	return self
end
CoD.WildcardCapacity.__onClose = function(f13_arg0)
	f13_arg0.SelectedImage:close()
	f13_arg0.background:close()
	f13_arg0.selectionList:close()
	f13_arg0.featureOverlayButtonMouseOnly:close()
end
