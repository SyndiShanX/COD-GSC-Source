require("x64:8d52912a320cd2e")
require("x64:35152a333fa2552")
require("x64:8e954fb331b89f8")
require("x64:d7a5c3c600baead")
require("x64:892762a382e42c9")
require("x64:d55d115474e5d67")
require("x64:e104ba18fbd90a8")
require("x64:3e25c2bb91944f2")
require("x64:574bf6c47de6a59")
CoD.PlayerWidgetWZ = InheritFrom(LUI.UIElement)
CoD.PlayerWidgetWZ.__defaultWidth = 278
CoD.PlayerWidgetWZ.__defaultHeight = 112
CoD.PlayerWidgetWZ.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.lastStand.progress", 0)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.lastStand.beingRevived", 0)
	self:setClass(CoD.PlayerWidgetWZ)
	self.id = "PlayerWidgetWZ"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(0, 0, 15, 315, 0, 0, 26.5, 92.5)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local GlowSpecialist = LUI.UIImage.new(0, 0, 19, 107, 0, 0, -4, 112)
	GlowSpecialist:setAlpha(0.12)
	GlowSpecialist:setImage(RegisterImage(@"hash_2D1DEF58D810CED5"))
	self:addElement(GlowSpecialist)
	self.GlowSpecialist = GlowSpecialist
	local PanelDark = LUI.UIImage.new(0, 0, 17, 178, 0, 0, 26, 90)
	PanelDark:setRGB(0.18, 0.17, 0.16)
	PanelDark:setAlpha(0.94)
	self:addElement(PanelDark)
	self.PanelDark = PanelDark
	local PanelLight = LUI.UIImage.new(0, 0, 178.5, 313.5, 0, 0, 26.5, 88.5)
	PanelLight:setRGB(0.22, 0.21, 0.19)
	PanelLight:setAlpha(0.75)
	self:addElement(PanelLight)
	self.PanelLight = PanelLight
	local AmmoHeal_Prompt = CoD.AmmoWidget_Prompt.new(f1_arg0, f1_arg1, 0, 0, 174.5, 238.5, 0, 0, 88.5, 100.5)
	AmmoHeal_Prompt:mergeStateConditions({
		{
			stateName = "LowHealth",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsClientModelValueGreaterThan(f1_arg1, "health.healthValue", 0) and CoD.ModelUtility.IsClientModelValueLessThanOrEqualTo(f1_arg1, "health.healthValue", 75)
			end,
		},
	})
	local Armor = AmmoHeal_Prompt
	local HealthValue = AmmoHeal_Prompt.subscribeToModel
	local CharacterPortrait2 = Engine[@"getmodelforclient"](Engine[@"getclientnum"](f1_arg1))
	HealthValue(Armor, CharacterPortrait2["health.healthValue"], function(f3_arg0)
		f1_arg0:updateElementState(AmmoHeal_Prompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "health.healthValue",
		})
	end, false)
	AmmoHeal_Prompt:setAlpha(0)
	AmmoHeal_Prompt.PromptText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_38CADD3D78C04519"))
	self:addElement(AmmoHeal_Prompt)
	self.AmmoHeal_Prompt = AmmoHeal_Prompt
	HealthValue = CoD.PlayerWidgetWZHealth.new(f1_arg0, f1_arg1, 0, 0, 86.5, 174.5, 0, 0, 24, 96)
	HealthValue:subscribeToGlobalModel(f1_arg1, "PerController", "predictedClientModel", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			HealthValue:setModel(f4_local0, f1_arg1)
		end
	end)
	self:addElement(HealthValue)
	self.HealthValue = HealthValue
	Armor = CoD.PlayerWidgetWZArmor.new(f1_arg0, f1_arg1, 0, 0, 249, 313, 0, 0, 25, 89)
	Armor:subscribeToGlobalModel(f1_arg1, "PerController", "predictedClientModel", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Armor:setModel(f5_local0, f1_arg1)
		end
	end)
	self:addElement(Armor)
	self.Armor = Armor
	CharacterPortrait2 = CoD.AmmoWidget_CharacterPortrait.new(f1_arg0, f1_arg1, 0, 0, 16, 110, 0, 0, 24, 92)
	CharacterPortrait2:setScale(1.3, 1.3)
	CharacterPortrait2:subscribeToGlobalModel(f1_arg1, "PerController", "predictedClientModel", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			CharacterPortrait2:setModel(f6_local0, f1_arg1)
		end
	end)
	self:addElement(CharacterPortrait2)
	self.CharacterPortrait2 = CharacterPortrait2
	local LEDarmor = LUI.UIImage.new(0, 0, 246, 314, 0, 0, 23, 91)
	LEDarmor:setRGB(0, 0, 0)
	LEDarmor:setAlpha(0.2)
	LEDarmor:setImage(RegisterImage(@"hash_59715DAADF2D1074"))
	self:addElement(LEDarmor)
	self.LEDarmor = LEDarmor
	local LEDplayer = LUI.UIImage.new(0, 0, 3.5, 183.5, 0, 0, 8, 108)
	LEDplayer:setRGB(0, 0, 0)
	LEDplayer:setAlpha(0.2)
	LEDplayer:setImage(RegisterImage(@"hash_BA2206DF71A2020"))
	self:addElement(LEDplayer)
	self.LEDplayer = LEDplayer
	local Frame = LUI.UIImage.new(0, 0, 1.5, 329.5, 0, 0, 8, 108)
	Frame:setImage(RegisterImage(@"hash_3BA5A94668BDF7FD"))
	self:addElement(Frame)
	self.Frame = Frame
	local AmmoWidgetMPAbilityItem = CoD.AmmoWidgetWZ_AbilityItem_Heal.new(f1_arg0, f1_arg1, 0, 0, 178, 250, 0, 0, 27.5, 86.5)
	AmmoWidgetMPAbilityItem.HeroAbilityUseString.KBMText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_234175BD548C4C21"))
	AmmoWidgetMPAbilityItem.HeroAbilityUseString.GamepadText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_234175BD548C4C21"))
	AmmoWidgetMPAbilityItem:subscribeToGlobalModel(f1_arg1, "PlayerAbilities", "playerGadget1", function(model)
		AmmoWidgetMPAbilityItem:setModel(model, f1_arg1)
	end)
	self:addElement(AmmoWidgetMPAbilityItem)
	self.AmmoWidgetMPAbilityItem = AmmoWidgetMPAbilityItem
	local InventoryEquipmentSmall2 = CoD.WarzoneContextualArmorStashItems.new(f1_arg0, f1_arg1, 0, 0, 101, 393, 0, 0, -78.5, 17.5)
	InventoryEquipmentSmall2.InventoryEquipmentLarge:setFilter(function(f8_arg0)
		local f8_local0
		if f8_arg0.availableAction:get() ~= CoD.WZUtility.ItemAvailableAction.REPAIR or f8_arg0.quickEquip:get() ~= 1 then
			f8_local0 = false
		else
			f8_local0 = true
		end
		return f8_local0
	end)
	InventoryEquipmentSmall2.InventoryEquipmentLarge:setDataSource("WarzoneShards")
	InventoryEquipmentSmall2.InventoryEquipmentSmall:setFilter(function(f9_arg0)
		local f9_local0
		if f9_arg0.availableAction:get() ~= CoD.WZUtility.ItemAvailableAction.REPAIR or f9_arg0.quickEquip:get() ~= 1 then
			f9_local0 = false
		else
			f9_local0 = true
		end
		return f9_local0
	end)
	InventoryEquipmentSmall2.InventoryEquipmentSmall:setDataSource("WarzoneShards")
	InventoryEquipmentSmall2.InventoryEquipmentStashCount:setDataSource("WarzoneShards")
	self:addElement(InventoryEquipmentSmall2)
	self.InventoryEquipmentSmall2 = InventoryEquipmentSmall2
	local InventoryEquipmentSmall = CoD.WarzoneContextualExtraItems_LeftAlign.new(f1_arg0, f1_arg1, 0, 0, 34, 326, 0, 0, -78.5, 17.5)
	InventoryEquipmentSmall.InventoryEquipmentSmall:setFilter(function(f10_arg0)
		local f10_local0
		if f10_arg0.type:get() ~= "health" or f10_arg0.equipped:get() ~= 0 or f10_arg0.quickEquip:get() ~= 1 then
			f10_local0 = false
		else
			f10_local0 = true
		end
		return f10_local0
	end)
	InventoryEquipmentSmall.InventoryEquipmentSmall:setDataSource("WarzoneInventory")
	InventoryEquipmentSmall.InventoryEquipmentLarge:setFilter(function(f11_arg0)
		local f11_local0
		if f11_arg0.type:get() ~= "health" or f11_arg0.equipped:get() ~= 0 or f11_arg0.quickEquip:get() ~= 1 then
			f11_local0 = false
		else
			f11_local0 = true
		end
		return f11_local0
	end)
	InventoryEquipmentSmall.InventoryEquipmentLarge:setDataSource("WarzoneInventory")
	InventoryEquipmentSmall:subscribeToGlobalModel(f1_arg1, "WarzoneInventoryGlobal", "health", function(model)
		InventoryEquipmentSmall.QuickInventoryItemCurrent:setModel(model, f1_arg1)
	end)
	InventoryEquipmentSmall:subscribeToGlobalModel(f1_arg1, "WarzoneInventoryGlobal", "health0", function(model)
		InventoryEquipmentSmall.QuickInventoryItemMid:setModel(model, f1_arg1)
	end)
	InventoryEquipmentSmall:subscribeToGlobalModel(f1_arg1, "WarzoneInventoryGlobal", "health1", function(model)
		InventoryEquipmentSmall.QuickInventoryItemTop:setModel(model, f1_arg1)
	end)
	self:addElement(InventoryEquipmentSmall)
	self.InventoryEquipmentSmall = InventoryEquipmentSmall
	local PlayerWidgetWZBleedIndicator = CoD.PlayerWidgetWZBleedIndicator.new(f1_arg0, f1_arg1, 0, 0, 84, 179, 0, 0, 67.5, 85.5)
	self:addElement(PlayerWidgetWZBleedIndicator)
	self.PlayerWidgetWZBleedIndicator = PlayerWidgetWZBleedIndicator
	local DemoPip = CoD.DemoPip.new(f1_arg0, f1_arg1, 0, 0, 19, 24, 0, 0, 100.5, 105.5)
	self:addElement(DemoPip)
	self.DemoPip = DemoPip
	self:mergeStateConditions({
		{
			stateName = "HiddenHealth",
			condition = function(menu, element, event)
				return CoD.WZUtility.IsWarzoneUIHidden(f1_arg1, "wzHidePlayerHealthUI", "warzoneHidePlayerHealth")
			end,
		},
	})
	local f1_local17 = self
	local f1_local18 = self.subscribeToModel
	local f1_local19 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local18(f1_local17, f1_local19.PlayerSettingsUpdate, function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "PlayerSettingsUpdate",
		})
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "WarzoneInventory", "isOpen", function(model)
		local f17_local0 = self
		if CoD.WZUtility.IsInventoryOpen(f1_arg1) then
			CoD.WZUtility.CloseQuickAccessInventory(f1_arg0, f1_arg1)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "hudItems.inventory.consumedItem", function(model)
		local f18_local0 = self
		UpdateAllMenuButtonPrompts(f1_arg0, f1_arg1)
	end)
	Armor.id = "Armor"
	InventoryEquipmentSmall2.id = "InventoryEquipmentSmall2"
	InventoryEquipmentSmall.id = "InventoryEquipmentSmall"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local18 = self
	CoD.WZUtility.AddQuickAccessInventoryWidget(f1_arg0, f1_arg1, InventoryEquipmentSmall2, 2, false)
	CoD.WZUtility.AddQuickAccessInventoryWidget(f1_arg0, f1_arg1, InventoryEquipmentSmall, 1, true)
	return self
end
CoD.PlayerWidgetWZ.__resetProperties = function(f19_arg0)
	f19_arg0.AmmoWidgetMPAbilityItem:completeAnimation()
	f19_arg0.DemoPip:completeAnimation()
	f19_arg0.PlayerWidgetWZBleedIndicator:completeAnimation()
	f19_arg0.Frame:completeAnimation()
	f19_arg0.LEDplayer:completeAnimation()
	f19_arg0.LEDarmor:completeAnimation()
	f19_arg0.CharacterPortrait2:completeAnimation()
	f19_arg0.Armor:completeAnimation()
	f19_arg0.HealthValue:completeAnimation()
	f19_arg0.AmmoHeal_Prompt:completeAnimation()
	f19_arg0.PanelLight:completeAnimation()
	f19_arg0.PanelDark:completeAnimation()
	f19_arg0.GlowSpecialist:completeAnimation()
	f19_arg0.Blur:completeAnimation()
	f19_arg0.AmmoWidgetMPAbilityItem:setAlpha(1)
	f19_arg0.DemoPip:setAlpha(1)
	f19_arg0.PlayerWidgetWZBleedIndicator:setAlpha(1)
	f19_arg0.Frame:setAlpha(1)
	f19_arg0.LEDplayer:setAlpha(0.2)
	f19_arg0.LEDarmor:setAlpha(0.2)
	f19_arg0.CharacterPortrait2:setAlpha(1)
	f19_arg0.Armor:setAlpha(1)
	f19_arg0.HealthValue:setAlpha(1)
	f19_arg0.AmmoHeal_Prompt:setAlpha(0)
	f19_arg0.PanelLight:setAlpha(0.75)
	f19_arg0.PanelDark:setAlpha(0.94)
	f19_arg0.GlowSpecialist:setAlpha(0.12)
	f19_arg0.Blur:setAlpha(1)
end
CoD.PlayerWidgetWZ.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(0)
		end,
	},
	HiddenHealth = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(14)
			f21_arg0.Blur:completeAnimation()
			f21_arg0.Blur:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Blur)
			f21_arg0.GlowSpecialist:completeAnimation()
			f21_arg0.GlowSpecialist:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.GlowSpecialist)
			f21_arg0.PanelDark:completeAnimation()
			f21_arg0.PanelDark:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.PanelDark)
			f21_arg0.PanelLight:completeAnimation()
			f21_arg0.PanelLight:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.PanelLight)
			f21_arg0.AmmoHeal_Prompt:completeAnimation()
			f21_arg0.AmmoHeal_Prompt:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.AmmoHeal_Prompt)
			f21_arg0.HealthValue:completeAnimation()
			f21_arg0.HealthValue:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.HealthValue)
			f21_arg0.Armor:completeAnimation()
			f21_arg0.Armor:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Armor)
			f21_arg0.CharacterPortrait2:completeAnimation()
			f21_arg0.CharacterPortrait2:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.CharacterPortrait2)
			f21_arg0.LEDarmor:completeAnimation()
			f21_arg0.LEDarmor:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.LEDarmor)
			f21_arg0.LEDplayer:completeAnimation()
			f21_arg0.LEDplayer:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.LEDplayer)
			f21_arg0.Frame:completeAnimation()
			f21_arg0.Frame:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Frame)
			f21_arg0.AmmoWidgetMPAbilityItem:completeAnimation()
			f21_arg0.AmmoWidgetMPAbilityItem:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.AmmoWidgetMPAbilityItem)
			f21_arg0.PlayerWidgetWZBleedIndicator:completeAnimation()
			f21_arg0.PlayerWidgetWZBleedIndicator:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.PlayerWidgetWZBleedIndicator)
			f21_arg0.DemoPip:completeAnimation()
			f21_arg0.DemoPip:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.DemoPip)
		end,
	},
}
CoD.PlayerWidgetWZ.__onClose = function(f22_arg0)
	f22_arg0.AmmoHeal_Prompt:close()
	f22_arg0.HealthValue:close()
	f22_arg0.Armor:close()
	f22_arg0.CharacterPortrait2:close()
	f22_arg0.AmmoWidgetMPAbilityItem:close()
	f22_arg0.InventoryEquipmentSmall2:close()
	f22_arg0.InventoryEquipmentSmall:close()
	f22_arg0.PlayerWidgetWZBleedIndicator:close()
	f22_arg0.DemoPip:close()
end
