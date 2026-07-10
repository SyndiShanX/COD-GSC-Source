require("x64:dadb11e1c159899")
require("x64:8df6938499c11c8")
require("x64:7046b0d9f3594f1")
require("x64:d13dde082cbfc3a")
require("x64:eddcb6b27ca1e41")
require("x64:5dfd98ce8acdef7")
require("x64:602298da419f4f")
CoD.DirectorCustomizeClassZM = InheritFrom(LUI.UIElement)
CoD.DirectorCustomizeClassZM.__defaultWidth = 1920
CoD.DirectorCustomizeClassZM.__defaultHeight = 1080
CoD.DirectorCustomizeClassZM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorCustomizeClassZM)
	self.id = "DirectorCustomizeClassZM"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local EquippedBGBContainer = CoD.EquippedBGBContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -899, -549, 0.5, 0.5, -289, 61)
	EquippedBGBContainer:linkToElementModel(self, nil, false, function(model)
		EquippedBGBContainer:setModel(model, f1_arg1)
	end)
	self:addElement(EquippedBGBContainer)
	self.EquippedBGBContainer = EquippedBGBContainer
	local PCEquippedBGBContainer = nil
	PCEquippedBGBContainer = CoD.PC_EquippedBGBContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -795, -668, 0.5, 0.5, -334, 114)
	PCEquippedBGBContainer:linkToElementModel(self, nil, false, function(model)
		PCEquippedBGBContainer:setModel(model, f1_arg1)
	end)
	self:addElement(PCEquippedBGBContainer)
	self.PCEquippedBGBContainer = PCEquippedBGBContainer
	local startWeapon = CoD.LoadoutClassItemZombie.new(f1_arg0, f1_arg1, 0.5, 0.5, 622, 922, 0.5, 0.5, 56.5, 198.5)
	startWeapon.LoadoutClassItemContainerZombie.loadoutName:setText(LocalizeToUpperString(0xB489D5E5A067675))
	startWeapon:linkToElementModel(self, "primary", false, function(model)
		startWeapon:setModel(model, f1_arg1)
	end)
	startWeapon:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(startWeapon, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		CoD.CACUtility.OpenCACOverlay(self, menu, controller, "ZMStartWeaponSelect", self, "zmStartWeapon")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	self:addElement(startWeapon)
	self.startWeapon = startWeapon
	local primarygrenade = CoD.LoadoutClassItemZombie.new(f1_arg0, f1_arg1, 0.5, 0.5, 622, 922, 0.5, 0.5, -111, 32)
	primarygrenade.LoadoutClassItemContainerZombie.loadoutName:setText(LocalizeToUpperString(0x6933F4D2B4D95C9))
	primarygrenade:linkToElementModel(self, "primarygrenade", false, function(model)
		primarygrenade:setModel(model, f1_arg1)
	end)
	primarygrenade:registerEventHandler("gain_focus", function(element, event)
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f9_local0
	end)
	f1_arg0:AddButtonCallbackFunction(primarygrenade, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		CoD.CACUtility.OpenCACOverlay(self, menu, controller, "ZMEquipmentSelect", self, "primarygrenade")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	self:addElement(primarygrenade)
	self.primarygrenade = primarygrenade
	local specialWeapon = CoD.LoadoutClassItemZombie.new(f1_arg0, f1_arg1, 0.5, 0.5, 622, 922, 0.5, 0.5, -333, -133)
	specialWeapon.LoadoutClassItemContainerZombie.itemImage:setScale(1.2, 1.2)
	specialWeapon.LoadoutClassItemContainerZombie.loadoutName:setText(LocalizeToUpperString(0x987AAEBF5D492B))
	specialWeapon:linkToElementModel(self, "herogadget", false, function(model)
		specialWeapon:setModel(model, f1_arg1)
	end)
	specialWeapon:registerEventHandler("gain_focus", function(element, event)
		local f13_local0 = nil
		if element.gainFocus then
			f13_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f13_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f13_local0
	end)
	f1_arg0:AddButtonCallbackFunction(specialWeapon, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		CoD.CACUtility.OpenCACOverlay(self, menu, controller, "ZMSpecialWeaponSelect", self, "herogadget")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	self:addElement(specialWeapon)
	self.specialWeapon = specialWeapon
	local ZMTallismanStatusButton = CoD.ZMTalismanStatusButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -774, -684, 0.5, 0.5, 269.5, 359.5)
	ZMTallismanStatusButton:linkToElementModel(self, "talisman1", false, function(model)
		ZMTallismanStatusButton:setModel(model, f1_arg1)
	end)
	local ZMTalismanEquipLine = ZMTallismanStatusButton
	local PerkAltars = ZMTallismanStatusButton.subscribeToModel
	local LabelWeapons = Engine[0x8DF2E5447F384B9]()
	PerkAltars(ZMTalismanEquipLine, LabelWeapons["lobbyRoot.lobbyNetworkMode"], function(f17_arg0, f17_arg1)
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end, false)
	ZMTalismanEquipLine = ZMTallismanStatusButton
	PerkAltars = ZMTallismanStatusButton.subscribeToModel
	LabelWeapons = Engine[0x8DF2E5447F384B9]()
	PerkAltars(ZMTalismanEquipLine, LabelWeapons["lobbyRoot.lobbyNav"], function(f18_arg0, f18_arg1)
		CoD.Menu.UpdateButtonShownState(f18_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f18_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
		CoD.Menu.UpdateButtonShownState(f18_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end, false)
	ZMTallismanStatusButton:linkToElementModel(ZMTallismanStatusButton, "itemIndex", true, function(model, f19_arg1)
		CoD.Menu.UpdateButtonShownState(f19_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
		CoD.Menu.UpdateButtonShownState(f19_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end)
	ZMTallismanStatusButton:appendEventHandler("input_source_changed", function(f20_arg0, f20_arg1)
		f20_arg1.menu = f20_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f20_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
		CoD.Menu.UpdateButtonShownState(f20_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end)
	ZMTalismanEquipLine = ZMTallismanStatusButton
	PerkAltars = ZMTallismanStatusButton.subscribeToModel
	LabelWeapons = Engine[0x4DF5CFBC1771947](f1_arg1)
	PerkAltars(ZMTalismanEquipLine, LabelWeapons.LastInput, function(f21_arg0, f21_arg1)
		CoD.Menu.UpdateButtonShownState(f21_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
		CoD.Menu.UpdateButtonShownState(f21_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end, false)
	ZMTallismanStatusButton:registerEventHandler("gain_focus", function(element, event)
		local f22_local0 = nil
		if element.gainFocus then
			f22_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f22_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		return f22_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ZMTallismanStatusButton, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if IsLive() then
			CoD.CACUtility.OpenCACOverlay(self, menu, controller, "ZMTalismanSelect", self, "talisman1")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsLive() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(ZMTallismanStatusButton, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB], "ui_remove", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "itemIndex", CoD.CACUtility.EmptyItemIndex) and IsMouseOrKeyboard(controller) and IsLive() then
			CoD.CACUtility.UnequipItem(controller, menu, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "itemIndex", CoD.CACUtility.EmptyItemIndex) and IsMouseOrKeyboard(controller) and IsLive() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xA86619565BE54DB], 0x679ACA6FFC6C8F3, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(ZMTallismanStatusButton, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "itemIndex", CoD.CACUtility.EmptyItemIndex) and IsGamepad(controller) and IsLive() then
			CoD.CACUtility.UnequipItem(controller, menu, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "itemIndex", CoD.CACUtility.EmptyItemIndex) and IsGamepad(controller) and IsLive() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x679ACA6FFC6C8F3, nil, nil)
			return true
		else
			return false
		end
	end, false)
	ZMTallismanStatusButton:AddContextualMenuAction(f1_arg0, f1_arg1, 0x679ACA6FFC6C8F3, function(f29_arg0, f29_arg1, f29_arg2, f29_arg3)
		if not CoD.ModelUtility.IsSelfModelValueEqualTo(f29_arg0, f29_arg2, "itemIndex", CoD.CACUtility.EmptyItemIndex) and IsLive() then
			return function(f30_arg0, f30_arg1, f30_arg2, f30_arg3)
				CoD.CACUtility.UnequipItem(f30_arg2, f30_arg1, f30_arg0)
			end
		else
		end
	end)
	self:addElement(ZMTallismanStatusButton)
	self.ZMTallismanStatusButton = ZMTallismanStatusButton
	PerkAltars = LUI.UIList.new(f1_arg0, f1_arg1, 14, 0, nil, false, false, false, false)
	PerkAltars:mergeStateConditions({
		{
			stateName = "Modifier",
			condition = function(menu, element, event)
				return IsLastListElement(element)
			end,
		},
	})
	PerkAltars:setLeftRight(0.5, 0.5, -480, 482)
	PerkAltars:setTopBottom(0.5, 0.5, -338, 112)
	PerkAltars:setWidgetType(CoD.ZMPerkSlot)
	PerkAltars:setHorizontalCount(4)
	PerkAltars:setSpacing(14)
	PerkAltars:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	PerkAltars:setDataSource("ZMEquippedPerks")
	PerkAltars:registerEventHandler("gain_focus", function(element, event)
		local f32_local0 = nil
		if element.gainFocus then
			f32_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f32_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f32_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PerkAltars, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		CoD.ZMPerkUtility.PerkSlotHighlighted(element, controller)
		CoD.CACUtility.OpenCACOverlay(self, menu, controller, "ZMPerkSelect", self, "specialty")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	PerkAltars:linkToElementModel(self, "classNum", true, function(model)
		CoD.GridAndListUtility.UpdateDataSource(PerkAltars, false, false, true)
	end)
	self:addElement(PerkAltars)
	self.PerkAltars = PerkAltars
	ZMTalismanEquipLine = CoD.ZMTalismanEquipLine.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	ZMTalismanEquipLine:linkToElementModel(self, "talisman1", false, function(model)
		ZMTalismanEquipLine:setModel(model, f1_arg1)
	end)
	self:addElement(ZMTalismanEquipLine)
	self.ZMTalismanEquipLine = ZMTalismanEquipLine
	LabelWeapons = LUI.UIText.new(0.5, 0.5, 625, 825, 0.5, 0.5, -377, -356)
	LabelWeapons:setRGB(0.58, 0.86, 1)
	LabelWeapons:setText(Engine[0xF9F1239CFD921FE](0x58AE0822C5041FC))
	LabelWeapons:setTTF("ttmussels_regular")
	LabelWeapons:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	LabelWeapons:setShaderVector(0, 1, 0, 0, 0)
	LabelWeapons:setShaderVector(1, 0, 0, 0, 0)
	LabelWeapons:setShaderVector(2, 0.2, 0.3, 1, 0.3)
	LabelWeapons:setLetterSpacing(4)
	LabelWeapons:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	LabelWeapons:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(LabelWeapons)
	self.LabelWeapons = LabelWeapons
	local LabelPerks = LUI.UIText.new(0.5, 0.5, -481, -281, 0.5, 0.5, -377, -356)
	LabelPerks:setRGB(0.58, 0.86, 1)
	LabelPerks:setText(Engine[0xF9F1239CFD921FE](0xFD7640D13C9158C))
	LabelPerks:setTTF("ttmussels_regular")
	LabelPerks:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	LabelPerks:setShaderVector(0, 1, 0, 0, 0)
	LabelPerks:setShaderVector(1, 0, 0, 0, 0)
	LabelPerks:setShaderVector(2, 0.2, 0.3, 1, 0.3)
	LabelPerks:setLetterSpacing(4)
	LabelPerks:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	LabelPerks:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(LabelPerks)
	self.LabelPerks = LabelPerks
	local LabelElixirs = LUI.UIText.new(0.5, 0.5, -824, -624, 0.5, 0.5, -377, -356)
	LabelElixirs:setRGB(0.58, 0.85, 1)
	LabelElixirs:setText(Engine[0xF9F1239CFD921FE](0xA83642C38DB951))
	LabelElixirs:setTTF("ttmussels_regular")
	LabelElixirs:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	LabelElixirs:setShaderVector(0, 1, 0, 0, 0)
	LabelElixirs:setShaderVector(1, 0, 0, 0, 0)
	LabelElixirs:setShaderVector(2, 0.2, 0.3, 1, 0.3)
	LabelElixirs:setLetterSpacing(4)
	LabelElixirs:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	LabelElixirs:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(LabelElixirs)
	self.LabelElixirs = LabelElixirs
	local LabelTalisman = LUI.UIText.new(0.5, 0.5, -824, -624, 0.5, 0.5, 181, 202)
	LabelTalisman:setRGB(0.58, 0.85, 1)
	LabelTalisman:setText(Engine[0xF9F1239CFD921FE](0x8C0FE859EC263E0))
	LabelTalisman:setTTF("ttmussels_regular")
	LabelTalisman:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	LabelTalisman:setShaderVector(0, 1, 0, 0, 0)
	LabelTalisman:setShaderVector(1, 0, 0, 0, 0)
	LabelTalisman:setShaderVector(2, 0.2, 0.3, 1, 0.3)
	LabelTalisman:setLetterSpacing(4)
	LabelTalisman:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	LabelTalisman:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(LabelTalisman)
	self.LabelTalisman = LabelTalisman
	local ChooseClassLockedOverlay = CoD.ChooseClassLockedOverlay.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 1, 1, -1080, 0)
	ChooseClassLockedOverlay:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "ZombiesVisible",
			condition = function(menu, element, event)
				return CoD.CACUtility.IsCurrentClassLocked(menu, f1_arg1)
			end,
		},
	})
	ChooseClassLockedOverlay:linkToElementModel(ChooseClassLockedOverlay, nil, true, function(model)
		f1_arg0:updateElementState(ChooseClassLockedOverlay, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = nil,
		})
	end)
	ChooseClassLockedOverlay:linkToElementModel(self, nil, false, function(model)
		ChooseClassLockedOverlay:setModel(model, f1_arg1)
	end)
	self:addElement(ChooseClassLockedOverlay)
	self.ChooseClassLockedOverlay = ChooseClassLockedOverlay
	self:mergeStateConditions({
		{
			stateName = "PublicKeyboard",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.ShowDirectorPublic(f1_arg1) and IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "Public",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.ShowDirectorPublic(f1_arg1)
			end,
		},
		{
			stateName = "DefaultStateKeyboard",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	local f1_local14 = self
	local f1_local15 = self.subscribeToModel
	local f1_local16 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local14, f1_local16["lobbyRoot.lobbyNav"], function(f44_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f44_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f45_arg0, f45_arg1)
		f45_arg1.menu = f45_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f45_arg1)
	end)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16.LastInput, function(f46_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f46_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	EquippedBGBContainer.id = "EquippedBGBContainer"
	if CoD.isPC then
		PCEquippedBGBContainer.id = "PCEquippedBGBContainer"
	end
	startWeapon.id = "startWeapon"
	primarygrenade.id = "primarygrenade"
	specialWeapon.id = "specialWeapon"
	ZMTallismanStatusButton.id = "ZMTallismanStatusButton"
	PerkAltars.id = "PerkAltars"
	if CoD.isPC then
		ChooseClassLockedOverlay.id = "ChooseClassLockedOverlay"
	end
	self.__defaultFocus = PerkAltars
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local15 = self
	if IsPC() and AlwaysFalse() then
		CoD.PCUtility.SetLoadoutKeypadShortcut(f1_arg0, self, f1_arg1, self.customClasssList)
	end
	f1_local15 = ZMTallismanStatusButton
	if IsPC() then
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local15, f1_arg1, "name", "", "")
	end
	return self
end
CoD.DirectorCustomizeClassZM.__resetProperties = function(f47_arg0)
	f47_arg0.PCEquippedBGBContainer:completeAnimation()
	f47_arg0.EquippedBGBContainer:completeAnimation()
	f47_arg0.PCEquippedBGBContainer:setAlpha(1)
	f47_arg0.EquippedBGBContainer:setAlpha(1)
end
CoD.DirectorCustomizeClassZM.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(1)
			f48_arg0.PCEquippedBGBContainer:completeAnimation()
			f48_arg0.PCEquippedBGBContainer:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.PCEquippedBGBContainer)
		end,
	},
	PublicKeyboard = {
		DefaultClip = function(f49_arg0, f49_arg1)
			f49_arg0:__resetProperties()
			f49_arg0:setupElementClipCounter(1)
			f49_arg0.EquippedBGBContainer:completeAnimation()
			f49_arg0.EquippedBGBContainer:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.EquippedBGBContainer)
		end,
	},
	Public = {
		DefaultClip = function(f50_arg0, f50_arg1)
			f50_arg0:__resetProperties()
			f50_arg0:setupElementClipCounter(1)
			f50_arg0.PCEquippedBGBContainer:completeAnimation()
			f50_arg0.PCEquippedBGBContainer:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.PCEquippedBGBContainer)
		end,
	},
	DefaultStateKeyboard = {
		DefaultClip = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties()
			f51_arg0:setupElementClipCounter(1)
			f51_arg0.EquippedBGBContainer:completeAnimation()
			f51_arg0.EquippedBGBContainer:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.EquippedBGBContainer)
		end,
	},
}
CoD.DirectorCustomizeClassZM.__onClose = function(f52_arg0)
	f52_arg0.EquippedBGBContainer:close()
	f52_arg0.PCEquippedBGBContainer:close()
	f52_arg0.startWeapon:close()
	f52_arg0.primarygrenade:close()
	f52_arg0.specialWeapon:close()
	f52_arg0.ZMTallismanStatusButton:close()
	f52_arg0.PerkAltars:close()
	f52_arg0.ZMTalismanEquipLine:close()
	f52_arg0.ChooseClassLockedOverlay:close()
end
