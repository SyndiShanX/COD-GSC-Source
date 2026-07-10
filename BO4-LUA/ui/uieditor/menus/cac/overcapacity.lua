require("x64:71c0f535bc61e87")
require("x64:467fecdabbc31f6")
require("x64:ba72b08fda6493")
require("x64:c829ac7d797ba4c")
CoD.OverCapacity = InheritFrom(CoD.Menu)
LUI.createMenu.OverCapacity = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("OverCapacity", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	self:setClass(CoD.OverCapacity)
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
	local itemList = CoD.OverCapacityList.new(f1_local1, f1_arg0, 0.5, 0.5, -612, 1668, 0, 0, 526, 626)
	self:addElement(itemList)
	self.itemList = itemList
	local Description = LUI.UIText.new(0.5, 0.5, -612, 407, 0, 0, 384, 405)
	Description:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Description:setText(Engine[0xF9F1239CFD921FE](0x757E50CC35560C))
	Description:setTTF("dinnext_regular")
	Description:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Description:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Description)
	self.Description = Description
	local DescriptionLine2 = LUI.UIText.new(0.5, 0.5, -612, 407, 0, 0, 443, 464)
	DescriptionLine2:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	DescriptionLine2:setTTF("dinnext_regular")
	DescriptionLine2:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	DescriptionLine2:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	DescriptionLine2:subscribeToGlobalModel(f1_arg0, "PerController", "CACMenu.numItemsToRemove", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			DescriptionLine2:setText(Engine[0xF9F1239CFD921FE](CoD.CACUtility.GetRemoveItemDescription(f1_arg0, f3_local0)))
		end
	end)
	self:addElement(DescriptionLine2)
	self.DescriptionLine2 = DescriptionLine2
	local Title = LUI.UIText.new(0.5, 0.5, -612, 407, 0, 0, 319, 364)
	Title:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	Title:setText(LocalizeToUpperString(0x96CBF472B3593BB))
	Title:setTTF("ttmussels_regular")
	Title:setLetterSpacing(6)
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Title:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Title)
	self.Title = Title
	local featureOverlayButtonMouseOnly = nil
	featureOverlayButtonMouseOnly = CoD.featureOverlay_Button_MouseOnly.new(f1_local1, f1_arg0, 0.5, 0.5, -606, -480, 0, 0, 675, 732)
	featureOverlayButtonMouseOnly.featureOverlayButtonContainer.Title:setText(Engine[0xF9F1239CFD921FE](0x78D439E1B360368))
	featureOverlayButtonMouseOnly:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f4_local0
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
	PCSmallCloseButton = CoD.PC_SmallCloseButton.new(f1_local1, f1_arg0, 0.5, 0.5, 913, 947, 0.5, 0.5, -221, -187)
	PCSmallCloseButton:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		return f7_local0
	end)
	f1_local1:AddButtonCallbackFunction(PCSmallCloseButton, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "MOUSE1", function(element, menu, controller, model)
		ClearMenuSavedState(menu)
		PlaySoundSetSound(self, "menu_no_selection")
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "MOUSE1")
		return false
	end, false)
	f1_local1:AddButtonCallbackFunction(PCSmallCloseButton, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_confirm", function(element, menu, controller, model)
		ClearMenuSavedState(menu)
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
		ClearMenuSavedState(menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	background:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		background.id = "background"
	end
	itemList.id = "itemList"
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
	self.__defaultFocus = itemList
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local9 = self
	if IsPC() then
		CoD.PCUtility.SetupUIMenuShortcutBlocker(self, f1_local1)
	end
	return self
end
CoD.OverCapacity.__onClose = function(f14_arg0)
	f14_arg0.background:close()
	f14_arg0.itemList:close()
	f14_arg0.DescriptionLine2:close()
	f14_arg0.featureOverlayButtonMouseOnly:close()
	f14_arg0.PCSmallCloseButton:close()
end
