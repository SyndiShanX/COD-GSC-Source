require("x64:ce1e6b6549d478c")
require("x64:efe3159fb7dfed3")
require("x64:3dd43113c4e1bd6")
require("x64:f027dcc6409e42c")
CoD.FTUEWZInventoryMenu = InheritFrom(CoD.Menu)
LUI.createMenu.FTUEWZInventoryMenu = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("FTUEWZInventoryMenu", f1_arg0)
	local f1_local1 = self
	EnableAnyController(self, f1_arg0)
	self:setClass(CoD.FTUEWZInventoryMenu)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local StartMenuBackground = CoD.StartMenu_Background.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(StartMenuBackground)
	self.StartMenuBackground = StartMenuBackground
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local Title = LUI.UIText.new(0.5, 0.5, -557.5, 556.5, 0, 0, 140, 205)
	Title:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	Title:setText(LocalizeToUpperString(0xBD3B433D869AB91))
	Title:setTTF("ttmussels_regular")
	Title:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0x58C8A85F2048829]))
	Title:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3]))
	self:addElement(Title)
	self.Title = Title
	local InventoryImage = LUI.UIImage.new(0.5, 0.5, -557, 557, 0, 0, 277, 803)
	self:addElement(InventoryImage)
	self.InventoryImage = InventoryImage
	local AmmoInfo = CoD.FTUEDescriptionWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -858.5, -557.5, 0, 0, 277, 336)
	AmmoInfo.InventoryTitleLabel:setText(LocalizeToUpperString(0xF5027E25ECEDB35))
	self:addElement(AmmoInfo)
	self.AmmoInfo = AmmoInfo
	local InventoryInfo = CoD.FTUEDescriptionWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -217.5, 217.5, 0, 0, 848, 907)
	InventoryInfo.InventoryTitleLabel:setText(LocalizeToUpperString(0xBD3B433D869AB91))
	InventoryInfo.AmmoTextBox:setText(Engine[0xF9F1239CFD921FE](0x4F2D8F7156A5524))
	self:addElement(InventoryInfo)
	self.InventoryInfo = InventoryInfo
	local AttachmentInfo = CoD.FTUEDescriptionWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -858.5, -557.5, 0, 0, 540, 599)
	AttachmentInfo.InventoryTitleLabel:setText(LocalizeToUpperString(0x31E6136F9B444FB))
	AttachmentInfo.AmmoTextBox:setText(Engine[0xF9F1239CFD921FE](0xD71011C74942E2F))
	self:addElement(AttachmentInfo)
	self.AttachmentInfo = AttachmentInfo
	local WeaponInfo = CoD.FTUEDescriptionWidget.new(f1_local1, f1_arg0, 0.5, 0.5, 557, 858, 0, 0, 277, 336)
	WeaponInfo.InventoryTitleLabel:setText(LocalizeToUpperString(0x71489612B1BCA6F))
	WeaponInfo.AmmoTextBox:setText(Engine[0xF9F1239CFD921FE](0x4346B668FE3054))
	self:addElement(WeaponInfo)
	self.WeaponInfo = WeaponInfo
	local ItemDescriptionInfo = CoD.FTUEDescriptionWidget.new(f1_local1, f1_arg0, 0.5, 0.5, 557, 858, 0, 0, 540, 599)
	ItemDescriptionInfo.InventoryTitleLabel:setText(LocalizeToUpperString(0x2C3F70FE9C51A42))
	ItemDescriptionInfo.AmmoTextBox:setText(Engine[0xF9F1239CFD921FE](0x1A0161A55165DD2))
	self:addElement(ItemDescriptionInfo)
	self.ItemDescriptionInfo = ItemDescriptionInfo
	local LoadoutInfo = CoD.FTUEDescriptionWidget.new(f1_local1, f1_arg0, 0.5, 0.5, 557, 858, 0, 0, 697, 756)
	LoadoutInfo.InventoryTitleLabel:setText(LocalizeToUpperString(0x8BBB3C989F6B999))
	LoadoutInfo.AmmoTextBox:setText(Engine[0xF9F1239CFD921FE](0x74AC65E586B8B20))
	self:addElement(LoadoutInfo)
	self.LoadoutInfo = LoadoutInfo
	local PCButton = nil
	PCButton = CoD.PC_MOTD_Buttons.new(f1_local1, f1_arg0, 0.18, 0.18, -120, 120, 0.8, 0.8, 0, 80)
	PCButton.OptionText:setText(LocalizeToUpperString(0x6393FF34EA56966))
	PCButton:linkToElementModel(self, "image", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			PCButton.Icon:setImage(RegisterImage(f3_local0))
		end
	end)
	PCButton:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f4_local0
	end)
	f1_local1:AddButtonCallbackFunction(PCButton, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		CoD.FTUEUtility.AdvanceCurrentSequence(self, controller)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(PCButton)
	self.PCButton = PCButton
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "MOUSE1", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			CoD.FTUEUtility.AdvanceCurrentSequence(self, controller)
			GoBack(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x6393FF34EA56966, nil, "MOUSE1")
			return true
		else
			return false
		end
	end, false)
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	if CoD.isPC then
		PCButton.id = "PCButton"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.FTUEWZInventoryMenu.__onClose = function(f9_arg0)
	f9_arg0.StartMenuBackground:close()
	f9_arg0.FooterContainerFrontendRight:close()
	f9_arg0.AmmoInfo:close()
	f9_arg0.InventoryInfo:close()
	f9_arg0.AttachmentInfo:close()
	f9_arg0.WeaponInfo:close()
	f9_arg0.ItemDescriptionInfo:close()
	f9_arg0.LoadoutInfo:close()
	f9_arg0.PCButton:close()
end
