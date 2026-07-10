require("x64:3a3f25394a55e03")
require("x64:cd6f611d2187487")
CoD.StartMenu_Inventory_CurrentWeaponPC = InheritFrom(LUI.UIElement)
CoD.StartMenu_Inventory_CurrentWeaponPC.__defaultWidth = 450
CoD.StartMenu_Inventory_CurrentWeaponPC.__defaultHeight = 214
CoD.StartMenu_Inventory_CurrentWeaponPC.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Inventory_CurrentWeaponPC)
	self.id = "StartMenu_Inventory_CurrentWeaponPC"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(0, 0, 0, 450, 0, 0, 0, 214)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local Background = LUI.UIImage.new(0, 0, 0, 450, 0, 0, 0, 214)
	Background:setRGB(0.04, 0.04, 0.04)
	Background:setAlpha(0.8)
	self:addElement(Background)
	self.Background = Background
	local GridTiled = LUI.UIImage.new(0, 0, 0, 450, 0, 0, 21, 214)
	GridTiled:setAlpha(0.55)
	GridTiled:setScale(1, 1)
	GridTiled:setImage(RegisterImage(@"uie_ui_menu_store_bg_grid"))
	GridTiled:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	GridTiled:setShaderVector(0, 0, 0, 0, 0)
	GridTiled:setupNineSliceShader(64, 64)
	self:addElement(GridTiled)
	self.GridTiled = GridTiled
	local CurrentWeaponVignette = CoD.StartMenu_Inventory_CurrentWeaponPC_Vignette.new(f1_arg0, f1_arg1, 0.5, 0.5, -205, 185, 0, 0, 35, 190)
	CurrentWeaponVignette:linkToElementModel(self, "currentWeapon", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CurrentWeaponVignette.CurrentWeaponImage:setImage(CoD.WZUtility.GetPreviewImageLarge(f2_local0))
		end
	end)
	CurrentWeaponVignette:linkToElementModel(self, "currentWeapon", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CurrentWeaponVignette.CurrentWeaponName:setText(ToUpper(CoD.WZUtility.GetWeaponNameAndAmmoString(f1_arg1, f3_local0)))
		end
	end)
	CurrentWeaponVignette:linkToElementModel(CurrentWeaponVignette, "id", true, function(model, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end)
	CurrentWeaponVignette:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f5_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		CoD.Menu.UpdateButtonShownState(f5_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end)
	local HeaderWeapon2 = CurrentWeaponVignette
	local HeaderWeapon = CurrentWeaponVignette.subscribeToModel
	local GamepadText = Engine[@"getmodelforcontroller"](f1_arg1)
	HeaderWeapon(HeaderWeapon2, GamepadText.LastInput, function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end, false)
	HeaderWeapon2 = CurrentWeaponVignette
	HeaderWeapon = CurrentWeaponVignette.subscribeToModel
	GamepadText = DataSources.WarzoneInventory.getModel(f1_arg1)
	HeaderWeapon(HeaderWeapon2, GamepadText.currentWeaponIndex, function(f7_arg0, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end, false)
	HeaderWeapon2 = CurrentWeaponVignette
	HeaderWeapon = CurrentWeaponVignette.subscribeToModel
	GamepadText = DataSources.WarzoneInventory.getModel(f1_arg1)
	HeaderWeapon(HeaderWeapon2, GamepadText["weapon0.hasAttachments"], function(f8_arg0, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end, false)
	HeaderWeapon2 = CurrentWeaponVignette
	HeaderWeapon = CurrentWeaponVignette.subscribeToModel
	GamepadText = DataSources.WarzoneInventory.getModel(f1_arg1)
	HeaderWeapon(HeaderWeapon2, GamepadText["weapon1.hasAttachments"], function(f9_arg0, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end, false)
	CurrentWeaponVignette:registerEventHandler("gain_focus", function(element, event)
		local f10_local0 = nil
		if element.gainFocus then
			f10_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f10_local0 = element.super:gainFocus(event)
		end
		CoD.WZUtility.SetElementModelToCurrentWeaponModel(f1_arg1, element)
		CoD.WZUtility.UpdateWZInventoryTooltipOnElementPC(f1_arg1, element)
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		return f10_local0
	end)
	f1_arg0:AddButtonCallbackFunction(CurrentWeaponVignette, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"], "MOUSE2", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"hash_64D2505E19049444"], @"warzone/drop", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "MOUSE2")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(CurrentWeaponVignette, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"], "MOUSE3", function(element, menu, controller, model)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "WarzoneInventory", "currentWeaponIndex", 0) and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "WarzoneInventory", "weapon0.hasAttachments", 1) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.WZUtility.SendInventoryDropCurrentWeaponAndDetachNotify(controller)
			return true
		elseif CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "WarzoneInventory", "currentWeaponIndex", 1) and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "WarzoneInventory", "weapon1.hasAttachments", 1) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.WZUtility.SendInventoryDropCurrentWeaponAndDetachNotify(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "WarzoneInventory", "currentWeaponIndex", 0) and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "WarzoneInventory", "weapon0.hasAttachments", 1) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_pckey_2"], @"hash_294D6AF2F50BEFEF", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "MOUSE3")
			return true
		elseif CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "WarzoneInventory", "currentWeaponIndex", 1) and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "WarzoneInventory", "weapon1.hasAttachments", 1) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_pckey_2"], @"hash_294D6AF2F50BEFEF", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "MOUSE3")
			return true
		else
			return false
		end
	end, false)
	CurrentWeaponVignette:subscribeToGlobalModel(f1_arg1, "WarzoneInventory", "currentWeaponIndex", function(model)
		local f15_local0 = CurrentWeaponVignette
		if IsElementInFocus(f15_local0) then
			CoD.WZUtility.SetElementModelToCurrentWeaponModel(f1_arg1, f15_local0)
			CoD.WZUtility.UpdateWZInventoryTooltipOnElementPC(f1_arg1, f15_local0)
		end
	end)
	self:addElement(CurrentWeaponVignette)
	self.CurrentWeaponVignette = CurrentWeaponVignette
	HeaderWeapon = CoD.StartMenu_Inventory_SwitchWeaponTab.new(f1_arg0, f1_arg1, 0.5, 0.5, -225, 0, 0, 0, 0, 21)
	HeaderWeapon:mergeStateConditions({
		{
			stateName = "Selected",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "WarzoneInventory", "currentWeaponIndex", 0)
			end,
		},
	})
	GamepadText = HeaderWeapon
	HeaderWeapon2 = HeaderWeapon.subscribeToModel
	local SwitchWeaponImage = DataSources.WarzoneInventory.getModel(f1_arg1)
	HeaderWeapon2(GamepadText, SwitchWeaponImage.currentWeaponIndex, function(f17_arg0)
		f1_arg0:updateElementState(HeaderWeapon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "currentWeaponIndex",
		})
	end, false)
	GamepadText = HeaderWeapon
	HeaderWeapon2 = HeaderWeapon.subscribeToModel
	SwitchWeaponImage = DataSources.WarzoneInventory.getModel(f1_arg1)
	HeaderWeapon2(GamepadText, SwitchWeaponImage["weapon0.hasAttachments"], function(f18_arg0, f18_arg1)
		CoD.Menu.UpdateButtonShownState(f18_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
	end, false)
	HeaderWeapon:registerEventHandler("gain_focus", function(element, event)
		local f19_local0 = nil
		if element.gainFocus then
			f19_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f19_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
		return f19_local0
	end)
	f1_arg0:AddButtonCallbackFunction(HeaderWeapon, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if IsInDefaultState(element) then
			CoD.WZUtility.SwitchToWeaponInSlot(controller, 0)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsInDefaultState(element) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(HeaderWeapon, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "ui_remove", function(element, menu, controller, model)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) then
			CoD.WZUtility.SendInventoryDropWeaponInSlotNotify(controller, 0)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"warzone/drop", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(HeaderWeapon, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "F", function(element, menu, controller, model)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "WarzoneInventory", "weapon0.hasAttachments", 1) then
			CoD.WZUtility.SendInventoryDropWeaponInSlotAndDetachNotify(controller, 0)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "WarzoneInventory", "weapon0.hasAttachments", 1) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_294D6AF2F50BEFEF", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "F")
			return true
		else
			return false
		end
	end, false)
	HeaderWeapon:AddContextualMenuAction(f1_arg0, f1_arg1, @"warzone/drop", function(f26_arg0, f26_arg1, f26_arg2, f26_arg3)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f26_arg2) then
			return function(f27_arg0, f27_arg1, f27_arg2, f27_arg3)
				CoD.WZUtility.SendInventoryDropWeaponInSlotNotify(f27_arg2, 0)
			end
		else
		end
	end)
	HeaderWeapon:AddContextualMenuAction(f1_arg0, f1_arg1, @"hash_294D6AF2F50BEFEF", function(f28_arg0, f28_arg1, f28_arg2, f28_arg3)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f28_arg2) and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f28_arg2, "WarzoneInventory", "weapon0.hasAttachments", 1) then
			return function(f29_arg0, f29_arg1, f29_arg2, f29_arg3)
				CoD.WZUtility.SendInventoryDropWeaponInSlotAndDetachNotify(f29_arg2, 0)
			end
		else
		end
	end)
	self:addElement(HeaderWeapon)
	self.HeaderWeapon = HeaderWeapon
	HeaderWeapon2 = CoD.StartMenu_Inventory_SwitchWeaponTab.new(f1_arg0, f1_arg1, 0.5, 0.5, 0, 225, 0, 0, 0, 21)
	HeaderWeapon2:mergeStateConditions({
		{
			stateName = "Selected",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "WarzoneInventory", "currentWeaponIndex", 1)
			end,
		},
	})
	SwitchWeaponImage = HeaderWeapon2
	GamepadText = HeaderWeapon2.subscribeToModel
	local f1_local9 = DataSources.WarzoneInventory.getModel(f1_arg1)
	GamepadText(SwitchWeaponImage, f1_local9.currentWeaponIndex, function(f31_arg0)
		f1_arg0:updateElementState(HeaderWeapon2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f31_arg0:get(),
			modelName = "currentWeaponIndex",
		})
	end, false)
	HeaderWeapon2.HeaderWeapon:setText(Engine[@"hash_4F9F1239CFD921FE"](@"warzone/weapon_2"))
	HeaderWeapon2.HeaderWeaponAsian:setText(Engine[@"hash_4F9F1239CFD921FE"](@"warzone/weapon_2"))
	SwitchWeaponImage = HeaderWeapon2
	GamepadText = HeaderWeapon2.subscribeToModel
	f1_local9 = DataSources.WarzoneInventory.getModel(f1_arg1)
	GamepadText(SwitchWeaponImage, f1_local9["weapon1.hasAttachments"], function(f32_arg0, f32_arg1)
		CoD.Menu.UpdateButtonShownState(f32_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
	end, false)
	HeaderWeapon2:registerEventHandler("gain_focus", function(element, event)
		local f33_local0 = nil
		if element.gainFocus then
			f33_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f33_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
		return f33_local0
	end)
	f1_arg0:AddButtonCallbackFunction(HeaderWeapon2, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if IsInDefaultState(element) then
			CoD.WZUtility.SwitchToWeaponInSlot(controller, 1)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsInDefaultState(element) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(HeaderWeapon2, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "ui_remove", function(element, menu, controller, model)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) then
			CoD.WZUtility.SendInventoryDropWeaponInSlotNotify(controller, 1)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"warzone/drop", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(HeaderWeapon2, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "F", function(element, menu, controller, model)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "WarzoneInventory", "weapon1.hasAttachments", 1) then
			CoD.WZUtility.SendInventoryDropWeaponInSlotAndDetachNotify(controller, 1)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "WarzoneInventory", "weapon1.hasAttachments", 1) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_294D6AF2F50BEFEF", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "F")
			return true
		else
			return false
		end
	end, false)
	HeaderWeapon2:AddContextualMenuAction(f1_arg0, f1_arg1, @"warzone/drop", function(f40_arg0, f40_arg1, f40_arg2, f40_arg3)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f40_arg2) then
			return function(f41_arg0, f41_arg1, f41_arg2, f41_arg3)
				CoD.WZUtility.SendInventoryDropWeaponInSlotNotify(f41_arg2, 1)
			end
		else
		end
	end)
	HeaderWeapon2:AddContextualMenuAction(f1_arg0, f1_arg1, @"hash_294D6AF2F50BEFEF", function(f42_arg0, f42_arg1, f42_arg2, f42_arg3)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f42_arg2) and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f42_arg2, "WarzoneInventory", "weapon1.hasAttachments", 1) then
			return function(f43_arg0, f43_arg1, f43_arg2, f43_arg3)
				CoD.WZUtility.SendInventoryDropWeaponInSlotAndDetachNotify(f43_arg2, 1)
			end
		else
		end
	end)
	self:addElement(HeaderWeapon2)
	self.HeaderWeapon2 = HeaderWeapon2
	GamepadText = LUI.UIText.new(0, 0, 0, 450, 0, 0, 0, 21)
	GamepadText:setRGB(0.55, 0.54, 0.49)
	GamepadText:setAlpha(0)
	GamepadText:setText(LocalizeToUpperString(@"menu/switch_weapon"))
	GamepadText:setTTF("ttmussels_regular")
	GamepadText:setLetterSpacing(4)
	GamepadText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	GamepadText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(GamepadText)
	self.GamepadText = GamepadText
	SwitchWeaponImage = LUI.UIImage.new(0, 0, 423, 444, 0, 0, 0, 21)
	SwitchWeaponImage:setAlpha(0)
	SwitchWeaponImage:subscribeToGlobalModel(f1_arg1, "Controller", "alt2_button_image", function(model)
		local f44_local0 = model:get()
		if f44_local0 ~= nil then
			SwitchWeaponImage:setImage(RegisterImage(f44_local0))
		end
	end)
	self:addElement(SwitchWeaponImage)
	self.SwitchWeaponImage = SwitchWeaponImage
	self.HeaderWeapon:linkToElementModel(self, nil, false, function(model)
		HeaderWeapon:setModel(model, f1_arg1)
	end)
	self.HeaderWeapon2:linkToElementModel(self, nil, false, function(model)
		HeaderWeapon2:setModel(model, f1_arg1)
	end)
	self:mergeStateConditions({
		{
			stateName = "VisibleGamepad",
			condition = function(menu, element, event)
				local f47_local0 = IsGamepad(f1_arg1)
				if f47_local0 then
					f47_local0 = CoD.WZUtility.ShouldShowWeaponAndAttachments(self)
					if f47_local0 then
						if not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "WarzoneInventory", "weapon0.id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
							f47_local0 = not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "WarzoneInventory", "weapon1.id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE)
						else
							f47_local0 = false
						end
					end
				end
				return f47_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f48_local0 = CoD.WZUtility.ShouldShowWeaponAndAttachments(self)
				if f48_local0 then
					if not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "WarzoneInventory", "weapon0.id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
						f48_local0 = not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "WarzoneInventory", "weapon1.id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE)
					else
						f48_local0 = false
					end
				end
				return f48_local0
			end,
		},
		{
			stateName = "VisibleNoSwitch0",
			condition = function(menu, element, event)
				return CoD.WZUtility.ShouldShowWeaponAndAttachments(self) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "WarzoneInventory", "weapon0.id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE)
			end,
		},
		{
			stateName = "VisibleNoSwitch1",
			condition = function(menu, element, event)
				return CoD.WZUtility.ShouldShowWeaponAndAttachments(self) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "WarzoneInventory", "weapon1.id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f51_arg0, f51_arg1)
		f51_arg1.menu = f51_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f51_arg1)
	end)
	local f1_local10 = self
	f1_local9 = self.subscribeToModel
	local f1_local11 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local10, f1_local11.LastInput, function(f52_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f52_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:linkToElementModel(self, "currentWeapon", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "currentWeapon",
		})
	end)
	f1_local10 = self
	f1_local9 = self.subscribeToModel
	f1_local11 = DataSources.WarzoneInventory.getModel(f1_arg1)
	f1_local9(f1_local10, f1_local11["weapon0.id"], function(f54_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f54_arg0:get(),
			modelName = "weapon0.id",
		})
	end, false)
	f1_local10 = self
	f1_local9 = self.subscribeToModel
	f1_local11 = DataSources.WarzoneInventory.getModel(f1_arg1)
	f1_local9(f1_local10, f1_local11["weapon1.id"], function(f55_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f55_arg0:get(),
			modelName = "weapon1.id",
		})
	end, false)
	CurrentWeaponVignette.id = "CurrentWeaponVignette"
	HeaderWeapon.id = "HeaderWeapon"
	HeaderWeapon2.id = "HeaderWeapon2"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local9 = self
	CoD.PCWidgetUtility.SetupContextualMenu(HeaderWeapon, f1_arg1, "weapon0.name", "", "")
	CoD.PCWidgetUtility.SetupContextualMenu(HeaderWeapon2, f1_arg1, "weapon1.name", "", "")
	return self
end
CoD.StartMenu_Inventory_CurrentWeaponPC.__resetProperties = function(f56_arg0)
	f56_arg0.HeaderWeapon:completeAnimation()
	f56_arg0.HeaderWeapon2:completeAnimation()
	f56_arg0.CurrentWeaponVignette:completeAnimation()
	f56_arg0.GridTiled:completeAnimation()
	f56_arg0.Background:completeAnimation()
	f56_arg0.Blur:completeAnimation()
	f56_arg0.GamepadText:completeAnimation()
	f56_arg0.SwitchWeaponImage:completeAnimation()
	f56_arg0.HeaderWeapon:setAlpha(1)
	f56_arg0.HeaderWeapon2:setAlpha(1)
	f56_arg0.CurrentWeaponVignette:setAlpha(1)
	f56_arg0.GridTiled:setAlpha(0.55)
	f56_arg0.Background:setAlpha(0.8)
	f56_arg0.Blur:setAlpha(1)
	f56_arg0.GamepadText:setAlpha(0)
	f56_arg0.SwitchWeaponImage:setAlpha(0)
end
CoD.StartMenu_Inventory_CurrentWeaponPC.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f57_arg0, f57_arg1)
			f57_arg0:__resetProperties()
			f57_arg0:setupElementClipCounter(6)
			f57_arg0.Blur:completeAnimation()
			f57_arg0.Blur:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.Blur)
			f57_arg0.Background:completeAnimation()
			f57_arg0.Background:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.Background)
			f57_arg0.GridTiled:completeAnimation()
			f57_arg0.GridTiled:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.GridTiled)
			f57_arg0.CurrentWeaponVignette:completeAnimation()
			f57_arg0.CurrentWeaponVignette:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.CurrentWeaponVignette)
			f57_arg0.HeaderWeapon:completeAnimation()
			f57_arg0.HeaderWeapon:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.HeaderWeapon)
			f57_arg0.HeaderWeapon2:completeAnimation()
			f57_arg0.HeaderWeapon2:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.HeaderWeapon2)
		end,
	},
	VisibleGamepad = {
		DefaultClip = function(f58_arg0, f58_arg1)
			f58_arg0:__resetProperties()
			f58_arg0:setupElementClipCounter(4)
			f58_arg0.HeaderWeapon:completeAnimation()
			f58_arg0.HeaderWeapon:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.HeaderWeapon)
			f58_arg0.HeaderWeapon2:completeAnimation()
			f58_arg0.HeaderWeapon2:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.HeaderWeapon2)
			f58_arg0.GamepadText:completeAnimation()
			f58_arg0.GamepadText:setAlpha(1)
			f58_arg0.clipFinished(f58_arg0.GamepadText)
			f58_arg0.SwitchWeaponImage:completeAnimation()
			f58_arg0.SwitchWeaponImage:setAlpha(1)
			f58_arg0.clipFinished(f58_arg0.SwitchWeaponImage)
		end,
	},
	Visible = {
		DefaultClip = function(f59_arg0, f59_arg1)
			f59_arg0:__resetProperties()
			f59_arg0:setupElementClipCounter(0)
		end,
	},
	VisibleNoSwitch0 = {
		DefaultClip = function(f60_arg0, f60_arg1)
			f60_arg0:__resetProperties()
			f60_arg0:setupElementClipCounter(2)
			f60_arg0.HeaderWeapon:completeAnimation()
			f60_arg0.HeaderWeapon:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.HeaderWeapon)
			f60_arg0.HeaderWeapon2:completeAnimation()
			f60_arg0.HeaderWeapon2:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.HeaderWeapon2)
		end,
	},
	VisibleNoSwitch1 = {
		DefaultClip = function(f61_arg0, f61_arg1)
			f61_arg0:__resetProperties()
			f61_arg0:setupElementClipCounter(2)
			f61_arg0.HeaderWeapon:completeAnimation()
			f61_arg0.HeaderWeapon:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.HeaderWeapon)
			f61_arg0.HeaderWeapon2:completeAnimation()
			f61_arg0.HeaderWeapon2:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.HeaderWeapon2)
		end,
	},
}
CoD.StartMenu_Inventory_CurrentWeaponPC.__onClose = function(f62_arg0)
	f62_arg0.CurrentWeaponVignette:close()
	f62_arg0.HeaderWeapon:close()
	f62_arg0.HeaderWeapon2:close()
	f62_arg0.SwitchWeaponImage:close()
end
