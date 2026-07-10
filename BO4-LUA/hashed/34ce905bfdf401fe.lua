require("x64:f78acfcbc465bba")
require("x64:ce1e6b6549d478c")
require("x64:efe3159fb7dfed3")
require("x64:3dd43113c4e1bd6")
require("x64:f027dcc6409e42c")
CoD.FTUEZMInventoryMenu = InheritFrom(CoD.Menu)
LUI.createMenu.FTUEZMInventoryMenu = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("FTUEZMInventoryMenu", f1_arg0)
	local f1_local1 = self
	EnableAnyController(self, f1_arg0)
	self:setClass(CoD.FTUEZMInventoryMenu)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local StartMenuBackground = CoD.StartMenu_Background.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	StartMenuBackground:setAlpha(0)
	self:addElement(StartMenuBackground)
	self.StartMenuBackground = StartMenuBackground
	local backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	backing:setRGB(0, 0, 0)
	backing:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	backing:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(backing)
	self.backing = backing
	local BackgroundImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackgroundImage:setAlpha(0.85)
	BackgroundImage:setImage(RegisterImage(@"uie_fe_cp_background"))
	self:addElement(BackgroundImage)
	self.BackgroundImage = BackgroundImage
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local Title = LUI.UIText.new(0.5, 0.5, -867, 414, 0, 0, 102, 167)
	Title:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
	Title:setText(LocalizeToUpperString(@"hash_3AADDF41A08B2C4E"))
	Title:setTTF("ttmussels_regular")
	Title:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_left"]))
	Title:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_top"]))
	self:addElement(Title)
	self.Title = Title
	local DescriptionTextBox = LUI.UIText.new(0.5, 0.5, -864, 854, 0, 0, 167, 189)
	DescriptionTextBox:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	DescriptionTextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6702AC7A44CEB8CA"))
	DescriptionTextBox:setTTF("dinnext_regular")
	DescriptionTextBox:setLineSpacing(5)
	DescriptionTextBox:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_left"]))
	DescriptionTextBox:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_top"]))
	self:addElement(DescriptionTextBox)
	self.DescriptionTextBox = DescriptionTextBox
	local InventoryImage = LUI.UIImage.new(0.5, 0.5, -267, 273, 0, 0, 306.5, 630.5)
	InventoryImage:setImage(RegisterImage(@"hash_41A4837B919A0460"))
	self:addElement(InventoryImage)
	self.InventoryImage = InventoryImage
	local InventoryImage2 = LUI.UIImage.new(0.5, 0.5, -552.5, -298.5, 0, 0, 347.5, 771.5)
	InventoryImage2:setImage(RegisterImage(@"hash_53335D002A10CBF6"))
	self:addElement(InventoryImage2)
	self.InventoryImage2 = InventoryImage2
	local InventoryImage2PC = nil
	InventoryImage2PC = LUI.UIImage.new(0.5, 0.5, -566, -286, 0, 0, 306.5, 773.5)
	InventoryImage2PC:setAlpha(0)
	InventoryImage2PC:setImage(RegisterImage(@"uie_ui_menu_ftue_zm_loadouts_elixirs_talismans_pc"))
	self:addElement(InventoryImage2PC)
	self.InventoryImage2PC = InventoryImage2PC
	local InventoryImage3 = LUI.UIImage.new(0.5, 0.5, 320.5, 536.5, 0, 0, 306.5, 770.5)
	InventoryImage3:setImage(RegisterImage(@"hash_1B52F80A9B03D861"))
	self:addElement(InventoryImage3)
	self.InventoryImage3 = InventoryImage3
	local ElixirInfo = CoD.FTUEDescriptionWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -864, -563, 0, 0, 316, 375)
	ElixirInfo.InventoryTitleLabel:setText(LocalizeToUpperString(@"menu/elixirs"))
	ElixirInfo.AmmoTextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6EE20D5C5263C58C"))
	self:addElement(ElixirInfo)
	self.ElixirInfo = ElixirInfo
	local TalismanInfo = CoD.FTUEDescriptionWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -864, -563, 0, 0, 655.5, 714.5)
	TalismanInfo.InventoryTitleLabel:setText(LocalizeToUpperString(@"hash_4813595698C26EB"))
	TalismanInfo.AmmoTextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5862E9BF360BCC1B"))
	self:addElement(TalismanInfo)
	self.TalismanInfo = TalismanInfo
	local PerksInfo = CoD.FTUEDescriptionWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -267, 263, 0, 0, 655.5, 714.5)
	PerksInfo.InventoryTitleLabel:setText(LocalizeToUpperString(@"menu/perks"))
	PerksInfo.AmmoTextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_776240345D1A215C"))
	self:addElement(PerksInfo)
	self.PerksInfo = PerksInfo
	local SpecialWeaponInfo = CoD.FTUEDescriptionWidget.new(f1_local1, f1_arg0, 0.5, 0.5, 563, 864, 0, 0, 306.5, 365.5)
	SpecialWeaponInfo.InventoryTitleLabel:setText(LocalizeToUpperString(@"hash_3F52AF57D201C5B0"))
	SpecialWeaponInfo.AmmoTextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](0x50532E2C661D78))
	self:addElement(SpecialWeaponInfo)
	self.SpecialWeaponInfo = SpecialWeaponInfo
	local EquipmentInfo = CoD.FTUEDescriptionWidget.new(f1_local1, f1_arg0, 0.5, 0.5, 563, 864, 0, 0, 534, 593)
	EquipmentInfo.InventoryTitleLabel:setText(LocalizeToUpperString(@"menu/equipment"))
	EquipmentInfo.AmmoTextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5F090683CB4F3BF9"))
	self:addElement(EquipmentInfo)
	self.EquipmentInfo = EquipmentInfo
	local StartingWeaponInfo = CoD.FTUEDescriptionWidget.new(f1_local1, f1_arg0, 0.5, 0.5, 563, 864, 0, 0, 655.5, 714.5)
	StartingWeaponInfo.InventoryTitleLabel:setText(LocalizeToUpperString(@"menu/starting_weapon"))
	StartingWeaponInfo.AmmoTextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_3E24AADA1E3D89B8"))
	self:addElement(StartingWeaponInfo)
	self.StartingWeaponInfo = StartingWeaponInfo
	local PCButton = nil
	PCButton = CoD.PC_MOTD_Buttons.new(f1_local1, f1_arg0, 0.5, 0.5, -734.5, -494.5, 0.8, 0.8, 48.5, 128.5)
	PCButton.OptionText:setText(LocalizeToUpperString(@"menu/continue"))
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
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f4_local0
	end)
	f1_local1:AddButtonCallbackFunction(PCButton, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		CoD.FTUEUtility.AdvanceCurrentSequence(self, controller)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	self:addElement(PCButton)
	self.PCButton = PCButton
	local FrontendFocusPip = LUI.UIImage.new(0.5, 0.5, -523.5, -326.5, 0, 0, 376, 571)
	FrontendFocusPip:setAlpha(0.05)
	FrontendFocusPip:setZRot(45)
	FrontendFocusPip:setImage(RegisterImage(@"uie_ui_menu_store_focus_pips"))
	FrontendFocusPip:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFocusPip:setShaderVector(0, 0, 0, 0, 0)
	FrontendFocusPip:setupNineSliceShader(44, 44)
	self:addElement(FrontendFocusPip)
	self.FrontendFocusPip = FrontendFocusPip
	local Lines = CoD.DirectorSelectButtonLines.new(f1_local1, f1_arg0, 0.5, 0.5, -266, 273, 0.28, 0.28, 0, 326)
	Lines:setRGB(0.64, 0.71, 0.78)
	self:addElement(Lines)
	self.Lines = Lines
	self:mergeStateConditions({
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsPC() and IsMouseOrKeyboard(f1_arg0)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f8_arg0, f8_arg1)
		f8_arg1.menu = f8_arg1.menu or f1_local1
		f1_local1:updateElementState(self, f8_arg1)
	end)
	local f1_local21 = self
	local f1_local22 = self.subscribeToModel
	local f1_local23 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local22(f1_local21, f1_local23.LastInput, function(f9_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f9_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "MOUSE1", function(element, menu, controller, model)
		CoD.FTUEUtility.AdvanceCurrentSequence(self, controller)
		GoBack(self, controller)
		PlaySoundAlias("uin_toggle_generic")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/continue", nil, "MOUSE1")
		return true
	end, false)
	self.__on_menuOpened_self = function(f12_arg0, f12_arg1, f12_arg2, f12_arg3)
		local f12_local0 = self
		PlaySoundAlias("uin_message_screen_open")
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
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
	self.__on_close_removeOverrides = function()
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local22 = self
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	return self
end
CoD.FTUEZMInventoryMenu.__resetProperties = function(f14_arg0)
	f14_arg0.ElixirInfo:completeAnimation()
	f14_arg0.InventoryImage2PC:completeAnimation()
	f14_arg0.FrontendFocusPip:completeAnimation()
	f14_arg0.InventoryImage2:completeAnimation()
	f14_arg0.ElixirInfo.AmmoTextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6EE20D5C5263C58C"))
	f14_arg0.InventoryImage2PC:setAlpha(0)
	f14_arg0.FrontendFocusPip:setAlpha(0.05)
	f14_arg0.InventoryImage2:setAlpha(1)
end
CoD.FTUEZMInventoryMenu.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
	},
	KBM = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(4)
			f16_arg0.InventoryImage2:completeAnimation()
			f16_arg0.InventoryImage2:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.InventoryImage2)
			f16_arg0.InventoryImage2PC:completeAnimation()
			f16_arg0.InventoryImage2PC:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.InventoryImage2PC)
			f16_arg0.ElixirInfo:completeAnimation()
			f16_arg0.ElixirInfo.AmmoTextBox:completeAnimation()
			f16_arg0.ElixirInfo.AmmoTextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](0x6026B677F033B3))
			f16_arg0.clipFinished(f16_arg0.ElixirInfo)
			f16_arg0.FrontendFocusPip:completeAnimation()
			f16_arg0.FrontendFocusPip:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.FrontendFocusPip)
		end,
	},
}
CoD.FTUEZMInventoryMenu.__onClose = function(f17_arg0)
	f17_arg0.__on_close_removeOverrides()
	f17_arg0.StartMenuBackground:close()
	f17_arg0.FooterContainerFrontendRight:close()
	f17_arg0.ElixirInfo:close()
	f17_arg0.TalismanInfo:close()
	f17_arg0.PerksInfo:close()
	f17_arg0.SpecialWeaponInfo:close()
	f17_arg0.EquipmentInfo:close()
	f17_arg0.StartingWeaponInfo:close()
	f17_arg0.PCButton:close()
	f17_arg0.Lines:close()
end
