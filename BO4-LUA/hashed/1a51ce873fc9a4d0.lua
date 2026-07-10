require("x64:3a3f25394a55e03")
require("x64:f7f8755bdbe6239")
require("x64:e8dbd840828bc3")
require("x64:f12de8d76142ccd")
require("x64:ac7ca8b9e6b6c7a")
CoD.StartMenu_Inventory_WeaponsDisplayPC = InheritFrom(LUI.UIElement)
CoD.StartMenu_Inventory_WeaponsDisplayPC.__defaultWidth = 449
CoD.StartMenu_Inventory_WeaponsDisplayPC.__defaultHeight = 443
CoD.StartMenu_Inventory_WeaponsDisplayPC.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.SetUseStencil(self)
	self:setClass(CoD.StartMenu_Inventory_WeaponsDisplayPC)
	self.id = "StartMenu_Inventory_WeaponsDisplayPC"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(1, 1, -449, 1, 0, 0, 0, 251)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local Background = LUI.UIImage.new(1, 1, -449, 1, 0, 0, 0, 251)
	Background:setRGB(0.04, 0.04, 0.04)
	Background:setAlpha(0.8)
	self:addElement(Background)
	self.Background = Background
	local TiledBacking = LUI.UIImage.new(1, 1, -449, 1, 0, 0, 0, 433)
	TiledBacking:setAlpha(0.5)
	TiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	TiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	TiledBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking:setupNineSliceShader(196, 88)
	self:addElement(TiledBacking)
	self.TiledBacking = TiledBacking
	local GridTiled = LUI.UIImage.new(1, 1, -448.5, 0.5, 0, 0, 32, 443)
	GridTiled:setAlpha(0.55)
	GridTiled:setScale(1, 1)
	GridTiled:setImage(RegisterImage(0xCA386792563DE8))
	GridTiled:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	GridTiled:setShaderVector(0, 0, 0, 0, 0)
	GridTiled:setupNineSliceShader(64, 64)
	self:addElement(GridTiled)
	self.GridTiled = GridTiled
	local WeaponVignette = CoD.StartMenu_Inventory_CurrentWeaponPC_Vignette.new(f1_arg0, f1_arg1, 1, 1, -419, -29, 0, 0, 40, 195)
	WeaponVignette:linkToElementModel(self, "icon", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			WeaponVignette.CurrentWeaponImage:setImage(RegisterImage(f2_local0))
		end
	end)
	WeaponVignette.CurrentWeaponName.__CurrentWeaponName = function(f3_arg0)
		local f3_local0 = f3_arg0:get()
		if f3_local0 ~= nil then
			WeaponVignette.CurrentWeaponName:setText(ToUpper(CoD.WZUtility.AddAmmoString(f1_arg1, self, f3_local0)))
		end
	end
	WeaponVignette:linkToElementModel(self, "name", true, WeaponVignette.CurrentWeaponName.__CurrentWeaponName)
	WeaponVignette.CurrentWeaponName.__CurrentWeaponName_FullPath = function()
		local f4_local0 = self:getModel()
		if f4_local0 then
			f4_local0 = self:getModel()
			f4_local0 = f4_local0.name
		end
		if f4_local0 then
			WeaponVignette.CurrentWeaponName.__CurrentWeaponName(f4_local0)
		end
	end
	WeaponVignette:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.WZUtility.SetElementModelToElementWeaponModel(f1_arg1, element, self)
		CoD.WZUtility.UpdateWZInventoryTooltipOnElementPC(f1_arg1, element)
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(WeaponVignette, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		CoD.WZUtility.SwitchToNextWeapon(controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(WeaponVignette, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "MOUSE1", function(element, menu, controller, model)
		CoD.WZUtility.SwitchToNextWeapon(controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "MOUSE1")
		return false
	end, false)
	self:addElement(WeaponVignette)
	self.WeaponVignette = WeaponVignette
	local GamepadText = LUI.UIText.new(1, 1, -449, 1, 0, 0, 0, 21)
	GamepadText:setRGB(0.55, 0.54, 0.49)
	GamepadText:setAlpha(0)
	GamepadText:setText(LocalizeToUpperString(0x23D1BB78E8AA44))
	GamepadText:setTTF("ttmussels_regular")
	GamepadText:setLetterSpacing(4)
	GamepadText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	GamepadText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(GamepadText)
	self.GamepadText = GamepadText
	local SwitchWeaponImage = LUI.UIImage.new(1, 1, -72, -51, 0, 0, 0, 21)
	SwitchWeaponImage:setAlpha(0)
	SwitchWeaponImage:subscribeToGlobalModel(f1_arg1, "Controller", "alt2_button_image", function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			SwitchWeaponImage:setImage(RegisterImage(f10_local0))
		end
	end)
	self:addElement(SwitchWeaponImage)
	self.SwitchWeaponImage = SwitchWeaponImage
	local WeaponHeader = CoD.StartMenu_Inventory_SwitchWeaponTab_Activate.new(f1_arg0, f1_arg1, 1, 1, -448, 0, 0, 0, 0, 32)
	WeaponHeader:mergeStateConditions({
		{
			stateName = "ClosedGamePad",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "WarzoneInventory", "currentWeaponIndex", self.weaponId)
			end,
		},
		{
			stateName = "Closed",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "WarzoneInventory", "currentWeaponIndex", self.weaponId)
			end,
		},
	})
	WeaponHeader:appendEventHandler("input_source_changed", function(f13_arg0, f13_arg1)
		f13_arg1.menu = f13_arg1.menu or f1_arg0
		f1_arg0:updateElementState(WeaponHeader, f13_arg1)
	end)
	local WeaponAttachmentsSmall = WeaponHeader
	local WeaponAttachments = WeaponHeader.subscribeToModel
	local DropAndDetachButtonPC = Engine[0x4DF5CFBC1771947](f1_arg1)
	WeaponAttachments(WeaponAttachmentsSmall, DropAndDetachButtonPC.LastInput, function(f14_arg0)
		f1_arg0:updateElementState(WeaponHeader, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	WeaponAttachmentsSmall = WeaponHeader
	WeaponAttachments = WeaponHeader.subscribeToModel
	DropAndDetachButtonPC = DataSources.WarzoneInventory.getModel(f1_arg1)
	WeaponAttachments(WeaponAttachmentsSmall, DropAndDetachButtonPC.currentWeaponIndex, function(f15_arg0)
		f1_arg0:updateElementState(WeaponHeader, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "currentWeaponIndex",
		})
	end, false)
	WeaponHeader:linkToElementModel(WeaponHeader, "hasAttachments", true, function(model, f16_arg1)
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end)
	WeaponHeader:registerEventHandler("gain_focus", function(element, event)
		local f17_local0 = nil
		if element.gainFocus then
			f17_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f17_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		return f17_local0
	end)
	f1_arg0:AddButtonCallbackFunction(WeaponHeader, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		CoD.WZUtility.SwitchToNextWeapon(controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(WeaponHeader, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_remove", function(element, menu, controller, model)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) then
			CoD.WZUtility.SendInventoryDropWeaponInSlotNotify(controller, self.weaponId)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0xFFD03BF8361AC75, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(WeaponHeader, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "F", function(element, menu, controller, model)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and CoD.ModelUtility.IsSelfModelValueEqualTo(self, controller, "hasAttachments", 0) then
			CoD.WZUtility.SendInventoryDropWeaponInSlotAndDetachNotify(controller, self.weaponId)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and CoD.ModelUtility.IsSelfModelValueEqualTo(self, controller, "hasAttachments", 0) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x94D6AF2F50BEFEF, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "F")
			return true
		else
			return false
		end
	end, false)
	self.__on_menuOpened_WeaponHeader = function(f24_arg0, f24_arg1, f24_arg2, f24_arg3)
		CoD.WZUtility.SetWeaponHeaderTexts(self, WeaponHeader)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_WeaponHeader)
	WeaponHeader:AddContextualMenuAction(f1_arg0, f1_arg1, 0xFFD03BF8361AC75, function(f25_arg0, f25_arg1, f25_arg2, f25_arg3)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f25_arg2) then
			return function(f26_arg0, f26_arg1, f26_arg2, f26_arg3)
				CoD.WZUtility.SendInventoryDropWeaponInSlotNotify(f26_arg2, self.weaponId)
			end
		else
		end
	end)
	WeaponHeader:AddContextualMenuAction(f1_arg0, f1_arg1, 0x94D6AF2F50BEFEF, function(f27_arg0, f27_arg1, f27_arg2, f27_arg3)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f27_arg2) and CoD.ModelUtility.IsSelfModelValueEqualTo(self, f27_arg2, "hasAttachments", 1) then
			return function(f28_arg0, f28_arg1, f28_arg2, f28_arg3)
				CoD.WZUtility.SendInventoryDropWeaponInSlotAndDetachNotify(f28_arg2, self.weaponId)
			end
		else
		end
	end)
	self:addElement(WeaponHeader)
	self.WeaponHeader = WeaponHeader
	WeaponAttachments = LUI.UIList.new(f1_arg0, f1_arg1, 40, 0, nil, false, false, false, false)
	WeaponAttachments:setLeftRight(1, 1, -404, -48)
	WeaponAttachments:setTopBottom(0, 0, 195.5, 415.5)
	WeaponAttachments:setScale(0.9, 0.9)
	WeaponAttachments:setWidgetType(CoD.WarzoneInventoryMenuItem)
	WeaponAttachments:setHorizontalCount(3)
	WeaponAttachments:setVerticalCount(2)
	WeaponAttachments:setSpacing(40)
	WeaponAttachments:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	WeaponAttachments:appendEventHandler("input_source_changed", function(f29_arg0, f29_arg1)
		f29_arg1.menu = f29_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f29_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f29_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x6CE8023188D673F])
		CoD.Menu.UpdateButtonShownState(f29_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A])
		CoD.Menu.UpdateButtonShownState(f29_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f29_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		CoD.Menu.UpdateButtonShownState(f29_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		CoD.Menu.UpdateButtonShownState(f29_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
		CoD.Menu.UpdateButtonShownState(f29_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end)
	DropAndDetachButtonPC = WeaponAttachments
	WeaponAttachmentsSmall = WeaponAttachments.subscribeToModel
	local DropButtonPC = Engine[0x4DF5CFBC1771947](f1_arg1)
	WeaponAttachmentsSmall(DropAndDetachButtonPC, DropButtonPC.LastInput, function(f30_arg0, f30_arg1)
		CoD.Menu.UpdateButtonShownState(f30_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f30_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x6CE8023188D673F])
		CoD.Menu.UpdateButtonShownState(f30_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A])
		CoD.Menu.UpdateButtonShownState(f30_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f30_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		CoD.Menu.UpdateButtonShownState(f30_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		CoD.Menu.UpdateButtonShownState(f30_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
		CoD.Menu.UpdateButtonShownState(f30_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end, false)
	WeaponAttachments:linkToElementModel(WeaponAttachments, "id", true, function(model, f31_arg1)
		CoD.Menu.UpdateButtonShownState(f31_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f31_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x6CE8023188D673F])
		CoD.Menu.UpdateButtonShownState(f31_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A])
		CoD.Menu.UpdateButtonShownState(f31_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f31_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		CoD.Menu.UpdateButtonShownState(f31_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		CoD.Menu.UpdateButtonShownState(f31_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		CoD.Menu.UpdateButtonShownState(f31_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
		CoD.Menu.UpdateButtonShownState(f31_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end)
	DropAndDetachButtonPC = WeaponAttachments
	WeaponAttachmentsSmall = WeaponAttachments.subscribeToModel
	DropButtonPC = Engine[0x4DF5CFBC1771947](f1_arg1)
	WeaponAttachmentsSmall(DropAndDetachButtonPC, DropButtonPC["hudItems.inventory.count"], function(f32_arg0, f32_arg1)
		CoD.Menu.UpdateButtonShownState(f32_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f32_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x6CE8023188D673F])
		CoD.Menu.UpdateButtonShownState(f32_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		CoD.Menu.UpdateButtonShownState(f32_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end, false)
	DropAndDetachButtonPC = WeaponAttachments
	WeaponAttachmentsSmall = WeaponAttachments.subscribeToModel
	DropButtonPC = Engine[0x4DF5CFBC1771947](f1_arg1)
	WeaponAttachmentsSmall(DropAndDetachButtonPC, DropButtonPC["hudItems.inventory.filledSlots"], function(f33_arg0, f33_arg1)
		CoD.Menu.UpdateButtonShownState(f33_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f33_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x6CE8023188D673F])
		CoD.Menu.UpdateButtonShownState(f33_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		CoD.Menu.UpdateButtonShownState(f33_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end, false)
	DropAndDetachButtonPC = WeaponAttachments
	WeaponAttachmentsSmall = WeaponAttachments.subscribeToModel
	DropButtonPC = Engine[0x4DF5CFBC1771947](f1_arg1)
	WeaponAttachmentsSmall(DropAndDetachButtonPC, DropButtonPC["hudItems.inventory.shard0.stackCount"], function(f34_arg0, f34_arg1)
		CoD.Menu.UpdateButtonShownState(f34_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f34_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x6CE8023188D673F])
		CoD.Menu.UpdateButtonShownState(f34_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		CoD.Menu.UpdateButtonShownState(f34_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end, false)
	WeaponAttachments:linkToElementModel(WeaponAttachments, "canTransferAttachment", true, function(model, f35_arg1)
		CoD.Menu.UpdateButtonShownState(f35_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A])
		CoD.Menu.UpdateButtonShownState(f35_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end)
	WeaponAttachments:registerEventHandler("list_item_gain_focus", function(element, event)
		local f36_local0 = nil
		if not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() then
			CoD.WZUtility.UpdateWZInventoryTooltipOnElementPC(f1_arg1, element)
			CoD.WZUtility.SendInventoryItemFocusNotify(f1_arg1, element)
		else
			CoD.WZUtility.UpdateWZInventoryTooltipOnElementPC(f1_arg1, element)
		end
		return f36_local0
	end)
	WeaponAttachments:registerEventHandler("gain_focus", function(element, event)
		local f37_local0 = nil
		if element.gainFocus then
			f37_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f37_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x6CE8023188D673F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
		return f37_local0
	end)
	f1_arg0:AddButtonCallbackFunction(WeaponAttachments, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
		if IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.InventoryFull(controller) then
			CoD.WZUtility.SendInventoryDetachNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.InventoryFull(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x6099347F51AF260, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3] | Enum[0xBEBDBAEEB3ECCCA][0x2919C98A7A845F0] | 400 << Enum[0xBEBDBAEEB3ECCCA][0x76ADD225D738C93], nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(WeaponAttachments, f1_arg1, Enum[0x3DD78803F918E9D][0x6CE8023188D673F], "ui_confirm", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.InventoryFull(controller) then
			CoD.WZUtility.SendInventoryDetachNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.InventoryFull(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x6CE8023188D673F], 0x6099347F51AF260, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(WeaponAttachments, f1_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A], "ui_contextual_1", function(element, menu, controller, model)
		if not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "canTransferAttachment", CoD.WZUtility.ItemAvailableAction.ATTACH) then
			CoD.WZUtility.SendInventoryEquipOnWeaponNotify(controller, element, menu, false, true)
			return true
		elseif not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "canTransferAttachment", CoD.WZUtility.ItemAvailableAction.SWAP) then
			CoD.WZUtility.SendInventoryEquipOnWeaponNotify(controller, element, menu, false, true)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "canTransferAttachment", CoD.WZUtility.ItemAvailableAction.ATTACH) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x22361E23588705A], 0x234736A1C101BE7, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_contextual_1")
			return true
		elseif not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "canTransferAttachment", CoD.WZUtility.ItemAvailableAction.SWAP) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x22361E23588705A], 0xD409BB4890E1387, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_contextual_1")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(WeaponAttachments, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xFFD03BF8361AC75, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3] | Enum[0xBEBDBAEEB3ECCCA][0x2919C98A7A845F0] | 400 << Enum[0xBEBDBAEEB3ECCCA][0x76ADD225D738C93], nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(WeaponAttachments, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], "ui_remove", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], 0xFFD03BF8361AC75, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(WeaponAttachments, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], "MOUSE1", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.InventoryFull(controller) then
			CoD.WZUtility.SendInventoryDetachNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.InventoryFull(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], 0x6099347F51AF260, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "MOUSE1")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(WeaponAttachments, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "MOUSE1", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.InventoryFull(controller) then
			CoD.WZUtility.SendInventoryDetachNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.InventoryFull(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "MOUSE1")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(WeaponAttachments, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444], "MOUSE2", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x4D2505E19049444], 0xFFD03BF8361AC75, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "MOUSE2")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(WeaponAttachments, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB], "MOUSE3", function(element, menu, controller, model)
		if not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "canTransferAttachment", CoD.WZUtility.ItemAvailableAction.ATTACH) then
			CoD.WZUtility.SendInventoryEquipOnWeaponNotify(controller, element, menu, false, true)
			return true
		elseif not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "canTransferAttachment", CoD.WZUtility.ItemAvailableAction.SWAP) then
			CoD.WZUtility.SendInventoryEquipOnWeaponNotify(controller, element, menu, false, true)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "canTransferAttachment", CoD.WZUtility.ItemAvailableAction.ATTACH) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xA86619565BE54DB], 0x234736A1C101BE7, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "MOUSE3")
			return true
		elseif not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "canTransferAttachment", CoD.WZUtility.ItemAvailableAction.SWAP) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xA86619565BE54DB], 0xD409BB4890E1387, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "MOUSE3")
			return true
		else
			return false
		end
	end, false)
	WeaponAttachments:AddContextualMenuAction(f1_arg0, f1_arg1, 0x6099347F51AF260, function(f56_arg0, f56_arg1, f56_arg2, f56_arg3)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f56_arg2) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f56_arg0, f56_arg2, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.InventoryFull(f56_arg2) then
			return function(f57_arg0, f57_arg1, f57_arg2, f57_arg3)
				CoD.WZUtility.SendInventoryDetachNotify(f57_arg2, f57_arg0)
			end
		else
		end
	end)
	WeaponAttachments:AddContextualMenuAction(f1_arg0, f1_arg1, 0xFFD03BF8361AC75, function(f58_arg0, f58_arg1, f58_arg2, f58_arg3)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f58_arg2) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f58_arg0, f58_arg2, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			return function(f59_arg0, f59_arg1, f59_arg2, f59_arg3)
				CoD.WZUtility.SendInventoryDropNotify(f59_arg2, f59_arg0)
			end
		else
		end
	end)
	WeaponAttachments:AddContextualMenuAction(f1_arg0, f1_arg1, 0x234736A1C101BE7, function(f60_arg0, f60_arg1, f60_arg2, f60_arg3)
		if not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f60_arg0, f60_arg2, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f60_arg2) and IsMouseOrKeyboard(f60_arg2) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(f60_arg0, f60_arg2, "canTransferAttachment", CoD.WZUtility.ItemAvailableAction.ATTACH) then
			return function(f61_arg0, f61_arg1, f61_arg2, f61_arg3)
				CoD.WZUtility.SendInventoryEquipOnWeaponNotify(f61_arg2, f61_arg0, f61_arg1, false, false)
			end
		else
		end
	end)
	WeaponAttachments:AddContextualMenuAction(f1_arg0, f1_arg1, 0xD409BB4890E1387, function(f62_arg0, f62_arg1, f62_arg2, f62_arg3)
		if not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f62_arg0, f62_arg2, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f62_arg2) and IsMouseOrKeyboard(f62_arg2) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(f62_arg0, f62_arg2, "canTransferAttachment", CoD.WZUtility.ItemAvailableAction.SWAP) then
			return function(f63_arg0, f63_arg1, f63_arg2, f63_arg3)
				CoD.WZUtility.SendInventoryEquipOnWeaponNotify(f63_arg2, f63_arg0, f63_arg1, false, false)
			end
		else
		end
	end)
	self:addElement(WeaponAttachments)
	self.WeaponAttachments = WeaponAttachments
	WeaponAttachmentsSmall = LUI.UIList.new(f1_arg0, f1_arg1, 12, 0, nil, false, false, false, false)
	WeaponAttachmentsSmall:setLeftRight(1, 1, -406, -46)
	WeaponAttachmentsSmall:setTopBottom(0, 0, 213, 263)
	WeaponAttachmentsSmall:setWidgetType(CoD.WarzoneInventoryMenuItemAttachmentSmall)
	WeaponAttachmentsSmall:setHorizontalCount(6)
	WeaponAttachmentsSmall:setSpacing(12)
	WeaponAttachmentsSmall:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	WeaponAttachmentsSmall:appendEventHandler("input_source_changed", function(f64_arg0, f64_arg1)
		f64_arg1.menu = f64_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f64_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f64_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x6CE8023188D673F])
		CoD.Menu.UpdateButtonShownState(f64_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f64_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		CoD.Menu.UpdateButtonShownState(f64_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A])
		CoD.Menu.UpdateButtonShownState(f64_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		CoD.Menu.UpdateButtonShownState(f64_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
		CoD.Menu.UpdateButtonShownState(f64_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end)
	DropButtonPC = WeaponAttachmentsSmall
	DropAndDetachButtonPC = WeaponAttachmentsSmall.subscribeToModel
	local f1_local13 = Engine[0x4DF5CFBC1771947](f1_arg1)
	DropAndDetachButtonPC(DropButtonPC, f1_local13.LastInput, function(f65_arg0, f65_arg1)
		CoD.Menu.UpdateButtonShownState(f65_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f65_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x6CE8023188D673F])
		CoD.Menu.UpdateButtonShownState(f65_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f65_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		CoD.Menu.UpdateButtonShownState(f65_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A])
		CoD.Menu.UpdateButtonShownState(f65_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		CoD.Menu.UpdateButtonShownState(f65_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
		CoD.Menu.UpdateButtonShownState(f65_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end, false)
	WeaponAttachmentsSmall:linkToElementModel(WeaponAttachmentsSmall, "id", true, function(model, f66_arg1)
		CoD.Menu.UpdateButtonShownState(f66_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f66_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x6CE8023188D673F])
		CoD.Menu.UpdateButtonShownState(f66_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f66_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		CoD.Menu.UpdateButtonShownState(f66_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A])
		CoD.Menu.UpdateButtonShownState(f66_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		CoD.Menu.UpdateButtonShownState(f66_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		CoD.Menu.UpdateButtonShownState(f66_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
		CoD.Menu.UpdateButtonShownState(f66_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end)
	DropButtonPC = WeaponAttachmentsSmall
	DropAndDetachButtonPC = WeaponAttachmentsSmall.subscribeToModel
	f1_local13 = Engine[0x4DF5CFBC1771947](f1_arg1)
	DropAndDetachButtonPC(DropButtonPC, f1_local13["hudItems.inventory.count"], function(f67_arg0, f67_arg1)
		CoD.Menu.UpdateButtonShownState(f67_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f67_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x6CE8023188D673F])
		CoD.Menu.UpdateButtonShownState(f67_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		CoD.Menu.UpdateButtonShownState(f67_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end, false)
	DropButtonPC = WeaponAttachmentsSmall
	DropAndDetachButtonPC = WeaponAttachmentsSmall.subscribeToModel
	f1_local13 = Engine[0x4DF5CFBC1771947](f1_arg1)
	DropAndDetachButtonPC(DropButtonPC, f1_local13["hudItems.inventory.filledSlots"], function(f68_arg0, f68_arg1)
		CoD.Menu.UpdateButtonShownState(f68_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f68_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x6CE8023188D673F])
		CoD.Menu.UpdateButtonShownState(f68_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		CoD.Menu.UpdateButtonShownState(f68_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end, false)
	DropButtonPC = WeaponAttachmentsSmall
	DropAndDetachButtonPC = WeaponAttachmentsSmall.subscribeToModel
	f1_local13 = Engine[0x4DF5CFBC1771947](f1_arg1)
	DropAndDetachButtonPC(DropButtonPC, f1_local13["hudItems.inventory.shard0.stackCount"], function(f69_arg0, f69_arg1)
		CoD.Menu.UpdateButtonShownState(f69_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f69_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x6CE8023188D673F])
		CoD.Menu.UpdateButtonShownState(f69_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		CoD.Menu.UpdateButtonShownState(f69_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end, false)
	WeaponAttachmentsSmall:linkToElementModel(WeaponAttachmentsSmall, "canTransferAttachment", true, function(model, f70_arg1)
		CoD.Menu.UpdateButtonShownState(f70_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A])
		CoD.Menu.UpdateButtonShownState(f70_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end)
	WeaponAttachmentsSmall:registerEventHandler("list_item_gain_focus", function(element, event)
		local f71_local0 = nil
		if not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() then
			CoD.WZUtility.UpdateWZInventoryTooltipOnElementPC(f1_arg1, element)
			CoD.WZUtility.SendInventoryItemFocusNotify(f1_arg1, element)
		else
			CoD.WZUtility.UpdateWZInventoryTooltipOnElementPC(f1_arg1, element)
		end
		return f71_local0
	end)
	WeaponAttachmentsSmall:registerEventHandler("gain_focus", function(element, event)
		local f72_local0 = nil
		if element.gainFocus then
			f72_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f72_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x6CE8023188D673F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
		return f72_local0
	end)
	f1_arg0:AddButtonCallbackFunction(WeaponAttachmentsSmall, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
		if IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.InventoryFull(controller) then
			CoD.WZUtility.SendInventoryDetachNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.InventoryFull(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x6099347F51AF260, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3] | Enum[0xBEBDBAEEB3ECCCA][0x2919C98A7A845F0] | 400 << Enum[0xBEBDBAEEB3ECCCA][0x76ADD225D738C93], nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(WeaponAttachmentsSmall, f1_arg1, Enum[0x3DD78803F918E9D][0x6CE8023188D673F], "ui_confirm", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.InventoryFull(controller) then
			CoD.WZUtility.SendInventoryDetachNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.InventoryFull(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x6CE8023188D673F], 0x6099347F51AF260, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(WeaponAttachmentsSmall, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xFFD03BF8361AC75, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3] | Enum[0xBEBDBAEEB3ECCCA][0x2919C98A7A845F0] | 400 << Enum[0xBEBDBAEEB3ECCCA][0x76ADD225D738C93], nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(WeaponAttachmentsSmall, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], "ui_remove", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], 0xFFD03BF8361AC75, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(WeaponAttachmentsSmall, f1_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A], "ui_contextual_1", function(element, menu, controller, model)
		if not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "canTransferAttachment", CoD.WZUtility.ItemAvailableAction.ATTACH) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		elseif not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "canTransferAttachment", CoD.WZUtility.ItemAvailableAction.SWAP) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "canTransferAttachment", CoD.WZUtility.ItemAvailableAction.ATTACH) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x22361E23588705A], 0xDAF6A96C5DF8207, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_contextual_1")
			return true
		elseif not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "canTransferAttachment", CoD.WZUtility.ItemAvailableAction.SWAP) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x22361E23588705A], 0xD2838B2DBAF9E27, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_contextual_1")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(WeaponAttachmentsSmall, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], "MOUSE1", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.InventoryFull(controller) then
			CoD.WZUtility.SendInventoryDetachNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.InventoryFull(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], 0x6099347F51AF260, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "MOUSE1")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(WeaponAttachmentsSmall, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "MOUSE1", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.InventoryFull(controller) then
			CoD.WZUtility.SendInventoryDetachNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.InventoryFull(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "MOUSE1")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(WeaponAttachmentsSmall, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444], "MOUSE2", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x4D2505E19049444], 0xFFD03BF8361AC75, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "MOUSE2")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(WeaponAttachmentsSmall, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB], "MOUSE3", function(element, menu, controller, model)
		if not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "canTransferAttachment", CoD.WZUtility.ItemAvailableAction.ATTACH) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		elseif not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "canTransferAttachment", CoD.WZUtility.ItemAvailableAction.SWAP) then
			CoD.WZUtility.SendInventoryEquipNotify(controller, element, menu, false)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "canTransferAttachment", CoD.WZUtility.ItemAvailableAction.ATTACH) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xA86619565BE54DB], 0xDAF6A96C5DF8207, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "MOUSE3")
			return true
		elseif not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "canTransferAttachment", CoD.WZUtility.ItemAvailableAction.SWAP) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xA86619565BE54DB], 0xD2838B2DBAF9E27, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "MOUSE3")
			return true
		else
			return false
		end
	end, false)
	WeaponAttachmentsSmall:AddContextualMenuAction(f1_arg0, f1_arg1, 0x6099347F51AF260, function(f91_arg0, f91_arg1, f91_arg2, f91_arg3)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f91_arg2) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f91_arg0, f91_arg2, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.InventoryFull(f91_arg2) then
			return function(f92_arg0, f92_arg1, f92_arg2, f92_arg3)
				CoD.WZUtility.SendInventoryDetachNotify(f92_arg2, f92_arg0)
			end
		else
		end
	end)
	WeaponAttachmentsSmall:AddContextualMenuAction(f1_arg0, f1_arg1, 0xFFD03BF8361AC75, function(f93_arg0, f93_arg1, f93_arg2, f93_arg3)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f93_arg2) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f93_arg0, f93_arg2, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			return function(f94_arg0, f94_arg1, f94_arg2, f94_arg3)
				CoD.WZUtility.SendInventoryDropNotify(f94_arg2, f94_arg0)
			end
		else
		end
	end)
	WeaponAttachmentsSmall:AddContextualMenuAction(f1_arg0, f1_arg1, 0xDAF6A96C5DF8207, function(f95_arg0, f95_arg1, f95_arg2, f95_arg3)
		if not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f95_arg0, f95_arg2, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f95_arg2) and IsMouseOrKeyboard(f95_arg2) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(f95_arg0, f95_arg2, "canTransferAttachment", CoD.WZUtility.ItemAvailableAction.ATTACH) then
			return function(f96_arg0, f96_arg1, f96_arg2, f96_arg3)
				CoD.WZUtility.SendInventoryEquipNotify(f96_arg2, f96_arg0, f96_arg1, false)
			end
		else
		end
	end)
	WeaponAttachmentsSmall:AddContextualMenuAction(f1_arg0, f1_arg1, 0xD2838B2DBAF9E27, function(f97_arg0, f97_arg1, f97_arg2, f97_arg3)
		if not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f97_arg0, f97_arg2, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f97_arg2) and IsMouseOrKeyboard(f97_arg2) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(f97_arg0, f97_arg2, "canTransferAttachment", CoD.WZUtility.ItemAvailableAction.SWAP) then
			return function(f98_arg0, f98_arg1, f98_arg2, f98_arg3)
				CoD.WZUtility.SendInventoryEquipNotify(f98_arg2, f98_arg0, f98_arg1, false)
			end
		else
		end
	end)
	self:addElement(WeaponAttachmentsSmall)
	self.WeaponAttachmentsSmall = WeaponAttachmentsSmall
	DropAndDetachButtonPC = nil
	DropAndDetachButtonPC = CoD.StartMenu_Inventory_ActionIconPC.new(f1_arg0, f1_arg1, 1, 1, -444, -410, 0, 0, 106.5, 140.5)
	DropAndDetachButtonPC:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.WZUtility.HasAttachments(f1_arg1, self.weaponId)
			end,
		},
	})
	f1_local13 = DropAndDetachButtonPC
	DropButtonPC = DropAndDetachButtonPC.subscribeToModel
	local f1_local14 = DataSources.WarzoneInventory.getModel(f1_arg1)
	DropButtonPC(f1_local13, f1_local14["weapon0.hasAttachments"], function(f100_arg0)
		f1_arg0:updateElementState(DropAndDetachButtonPC, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f100_arg0:get(),
			modelName = "weapon0.hasAttachments",
		})
	end, false)
	f1_local13 = DropAndDetachButtonPC
	DropButtonPC = DropAndDetachButtonPC.subscribeToModel
	f1_local14 = DataSources.WarzoneInventory.getModel(f1_arg1)
	DropButtonPC(f1_local13, f1_local14["weapon1.hasAttachments"], function(f101_arg0)
		f1_arg0:updateElementState(DropAndDetachButtonPC, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f101_arg0:get(),
			modelName = "weapon1.hasAttachments",
		})
	end, false)
	DropAndDetachButtonPC.Image:setImage(RegisterImage(0x11FFBA26DA10CCC))
	DropAndDetachButtonPC:appendEventHandler("input_source_changed", function(f102_arg0, f102_arg1)
		f102_arg1.menu = f102_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f102_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
		CoD.Menu.UpdateButtonShownState(f102_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	f1_local13 = DropAndDetachButtonPC
	DropButtonPC = DropAndDetachButtonPC.subscribeToModel
	f1_local14 = Engine[0x4DF5CFBC1771947](f1_arg1)
	DropButtonPC(f1_local13, f1_local14.LastInput, function(f103_arg0, f103_arg1)
		CoD.Menu.UpdateButtonShownState(f103_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
		CoD.Menu.UpdateButtonShownState(f103_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local13 = DropAndDetachButtonPC
	DropButtonPC = DropAndDetachButtonPC.subscribeToModel
	f1_local14 = DataSources.WarzoneInventory.getModel(f1_arg1)
	DropButtonPC(f1_local13, f1_local14["weapon0.hasAttachments"], function(f104_arg0, f104_arg1)
		CoD.Menu.UpdateButtonShownState(f104_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
		CoD.Menu.UpdateButtonShownState(f104_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local13 = DropAndDetachButtonPC
	DropButtonPC = DropAndDetachButtonPC.subscribeToModel
	f1_local14 = DataSources.WarzoneInventory.getModel(f1_arg1)
	DropButtonPC(f1_local13, f1_local14["weapon1.hasAttachments"], function(f105_arg0, f105_arg1)
		CoD.Menu.UpdateButtonShownState(f105_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
		CoD.Menu.UpdateButtonShownState(f105_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	DropAndDetachButtonPC:registerEventHandler("gain_focus", function(element, event)
		local f106_local0 = nil
		if element.gainFocus then
			f106_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f106_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f106_local0
	end)
	f1_arg0:AddButtonCallbackFunction(DropAndDetachButtonPC, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444], "MOUSE2", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and CoD.WZUtility.HasAttachments(controller, self.weaponId) then
			CoD.WZUtility.SendInventoryDropWeaponInSlotAndDetachNotify(controller, self.weaponId)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and CoD.WZUtility.HasAttachments(controller, self.weaponId) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x4D2505E19049444], 0x94D6AF2F50BEFEF, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "MOUSE2")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(DropAndDetachButtonPC, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if IsGamepad(controller) and CoD.WZUtility.HasAttachments(controller, self.weaponId) then
			CoD.WZUtility.SendInventoryDropWeaponInSlotAndDetachNotify(controller, self.weaponId)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) and CoD.WZUtility.HasAttachments(controller, self.weaponId) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x94D6AF2F50BEFEF, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(DropAndDetachButtonPC)
	self.DropAndDetachButtonPC = DropAndDetachButtonPC
	DropButtonPC = nil
	DropButtonPC = CoD.StartMenu_Inventory_ActionIconPC.new(f1_arg0, f1_arg1, 1, 1, -444, -410, 0, 0, 68.5, 102.5)
	DropButtonPC:linkToElementModel(DropButtonPC, "id", true, function(model, f111_arg1)
		CoD.Menu.UpdateButtonShownState(f111_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
		CoD.Menu.UpdateButtonShownState(f111_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	DropButtonPC:appendEventHandler("input_source_changed", function(f112_arg0, f112_arg1)
		f112_arg1.menu = f112_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f112_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
		CoD.Menu.UpdateButtonShownState(f112_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	f1_local14 = DropButtonPC
	f1_local13 = DropButtonPC.subscribeToModel
	local f1_local15 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local13(f1_local14, f1_local15.LastInput, function(f113_arg0, f113_arg1)
		CoD.Menu.UpdateButtonShownState(f113_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
		CoD.Menu.UpdateButtonShownState(f113_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	DropButtonPC:registerEventHandler("gain_focus", function(element, event)
		local f114_local0 = nil
		if element.gainFocus then
			f114_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f114_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f114_local0
	end)
	f1_arg0:AddButtonCallbackFunction(DropButtonPC, f1_arg1, Enum[0x3DD78803F918E9D][0x4D2505E19049444], "MOUSE2", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and IsMouseOrKeyboard(controller) then
			CoD.WZUtility.SendInventoryDropWeaponInSlotNotify(controller, self.weaponId)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x4D2505E19049444], 0xFFD03BF8361AC75, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "MOUSE2")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(DropButtonPC, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and IsGamepad(controller) then
			CoD.WZUtility.SendInventoryDropWeaponInSlotNotify(controller, self.weaponId)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xFFD03BF8361AC75, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(DropButtonPC)
	self.DropButtonPC = DropButtonPC
	f1_local14 = WeaponVignette
	f1_local13 = WeaponVignette.subscribeToModel
	f1_local15 = DataSources.WarzoneInventory.getModel(f1_arg1)
	f1_local13(f1_local14, f1_local15["weapon0.ammoType"], WeaponVignette.CurrentWeaponName.__CurrentWeaponName_FullPath)
	f1_local14 = WeaponVignette
	f1_local13 = WeaponVignette.subscribeToModel
	f1_local15 = DataSources.WarzoneInventory.getModel(f1_arg1)
	f1_local13(f1_local14, f1_local15["weapon1.ammoType"], WeaponVignette.CurrentWeaponName.__CurrentWeaponName_FullPath)
	self:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return true
			end,
		},
		{
			stateName = "Open_NoAttachments",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "WarzoneInventory", "currentWeaponIndex", self.weaponId) and not CoD.WZUtility.HasWeaponAttachments(f1_arg1, self.weaponId)
			end,
		},
		{
			stateName = "Open",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "WarzoneInventory", "currentWeaponIndex", self.weaponId)
			end,
		},
		{
			stateName = "Close_NoAttachments",
			condition = function(menu, element, event)
				return not CoD.WZUtility.HasWeaponAttachments(f1_arg1, self.weaponId)
			end,
		},
		{
			stateName = "Close",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	f1_local14 = self
	f1_local13 = self.subscribeToModel
	f1_local15 = DataSources.WarzoneInventory.getModel(f1_arg1)
	f1_local13(f1_local14, f1_local15.currentWeaponIndex, function(f124_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f124_arg0:get(),
			modelName = "currentWeaponIndex",
		})
	end, false)
	f1_local14 = self
	f1_local13 = self.subscribeToModel
	f1_local15 = DataSources.WarzoneInventory.getModel(f1_arg1)
	f1_local13(f1_local14, f1_local15["weapon0.supportsAttachments"], function(f125_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f125_arg0:get(),
			modelName = "weapon0.supportsAttachments",
		})
	end, false)
	f1_local14 = self
	f1_local13 = self.subscribeToModel
	f1_local15 = DataSources.WarzoneInventory.getModel(f1_arg1)
	f1_local13(f1_local14, f1_local15["weapon1.supportsAttachments"], function(f126_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f126_arg0:get(),
			modelName = "weapon1.supportsAttachments",
		})
	end, false)
	WeaponVignette.id = "WeaponVignette"
	WeaponHeader.id = "WeaponHeader"
	WeaponAttachments.id = "WeaponAttachments"
	WeaponAttachmentsSmall.id = "WeaponAttachmentsSmall"
	if CoD.isPC then
		DropAndDetachButtonPC.id = "DropAndDetachButtonPC"
	end
	if CoD.isPC then
		DropButtonPC.id = "DropButtonPC"
	end
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_WeaponHeader)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local13 = self
	f1_local13 = WeaponVignette
	DisableAutoButtonCallback(f1_arg0, f1_local13, f1_arg1)
	CoD.PCWidgetUtility.SetupContextualMenu(f1_local13, f1_arg1, "weaponName", "", "")
	CoD.PCWidgetUtility.SetupContextualMenu(WeaponHeader, f1_arg1, "weaponName", "", "")
	f1_local13 = WeaponAttachments
	if IsPC() then
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local13, f1_arg1, "name", "", "")
	end
	f1_local13 = WeaponAttachmentsSmall
	if IsPC() then
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local13, f1_arg1, "name", "", "")
	end
	return self
end
CoD.StartMenu_Inventory_WeaponsDisplayPC.__resetProperties = function(f128_arg0)
	f128_arg0.GridTiled:completeAnimation()
	f128_arg0.Background:completeAnimation()
	f128_arg0.Blur:completeAnimation()
	f128_arg0.WeaponAttachmentsSmall:completeAnimation()
	f128_arg0.GamepadText:completeAnimation()
	f128_arg0.WeaponAttachments:completeAnimation()
	f128_arg0.WeaponHeader:completeAnimation()
	f128_arg0.SwitchWeaponImage:completeAnimation()
	f128_arg0.WeaponVignette:completeAnimation()
	f128_arg0.TiledBacking:completeAnimation()
	f128_arg0.DropButtonPC:completeAnimation()
	f128_arg0.GridTiled:setTopBottom(0, 0, 32, 443)
	f128_arg0.GridTiled:setAlpha(0.55)
	f128_arg0.Background:setTopBottom(0, 0, 0, 251)
	f128_arg0.Background:setAlpha(0.8)
	f128_arg0.Blur:setTopBottom(0, 0, 0, 251)
	f128_arg0.Blur:setAlpha(1)
	f128_arg0.WeaponAttachmentsSmall:setTopBottom(0, 0, 213, 263)
	f128_arg0.WeaponAttachmentsSmall:setAlpha(1)
	f128_arg0.GamepadText:setAlpha(0)
	f128_arg0.WeaponAttachments:setAlpha(1)
	f128_arg0.WeaponHeader:setAlpha(1)
	f128_arg0.SwitchWeaponImage:setAlpha(0)
	f128_arg0.WeaponVignette:setAlpha(1)
	f128_arg0.TiledBacking:setTopBottom(0, 0, 0, 433)
	f128_arg0.TiledBacking:setAlpha(0.5)
	f128_arg0.DropButtonPC:setAlpha(1)
end
CoD.StartMenu_Inventory_WeaponsDisplayPC.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f129_arg0, f129_arg1)
			f129_arg0:__resetProperties()
			f129_arg0:setupElementClipCounter(5)
			f129_arg0.Blur:completeAnimation()
			f129_arg0.Blur:setAlpha(1)
			f129_arg0.clipFinished(f129_arg0.Blur)
			f129_arg0.Background:completeAnimation()
			f129_arg0.Background:setAlpha(1)
			f129_arg0.clipFinished(f129_arg0.Background)
			f129_arg0.GridTiled:completeAnimation()
			f129_arg0.GridTiled:setTopBottom(0, 0, 32, 433)
			f129_arg0.GridTiled:setAlpha(1)
			f129_arg0.clipFinished(f129_arg0.GridTiled)
			f129_arg0.GamepadText:completeAnimation()
			f129_arg0.GamepadText:setAlpha(1)
			f129_arg0.clipFinished(f129_arg0.GamepadText)
			f129_arg0.WeaponAttachmentsSmall:completeAnimation()
			f129_arg0.WeaponAttachmentsSmall:setAlpha(0)
			f129_arg0.clipFinished(f129_arg0.WeaponAttachmentsSmall)
		end,
	},
	Invisible = {
		DefaultClip = function(f130_arg0, f130_arg1)
			f130_arg0:__resetProperties()
			f130_arg0:setupElementClipCounter(11)
			f130_arg0.Blur:completeAnimation()
			f130_arg0.Blur:setAlpha(0)
			f130_arg0.clipFinished(f130_arg0.Blur)
			f130_arg0.Background:completeAnimation()
			f130_arg0.Background:setAlpha(0)
			f130_arg0.clipFinished(f130_arg0.Background)
			f130_arg0.TiledBacking:completeAnimation()
			f130_arg0.TiledBacking:setAlpha(0)
			f130_arg0.clipFinished(f130_arg0.TiledBacking)
			f130_arg0.GridTiled:completeAnimation()
			f130_arg0.GridTiled:setAlpha(0)
			f130_arg0.clipFinished(f130_arg0.GridTiled)
			f130_arg0.WeaponVignette:completeAnimation()
			f130_arg0.WeaponVignette:setAlpha(0)
			f130_arg0.clipFinished(f130_arg0.WeaponVignette)
			f130_arg0.GamepadText:completeAnimation()
			f130_arg0.GamepadText:setAlpha(0)
			f130_arg0.clipFinished(f130_arg0.GamepadText)
			f130_arg0.SwitchWeaponImage:completeAnimation()
			f130_arg0.SwitchWeaponImage:setAlpha(0)
			f130_arg0.clipFinished(f130_arg0.SwitchWeaponImage)
			f130_arg0.WeaponHeader:completeAnimation()
			f130_arg0.WeaponHeader:setAlpha(0)
			f130_arg0.clipFinished(f130_arg0.WeaponHeader)
			f130_arg0.WeaponAttachments:completeAnimation()
			f130_arg0.WeaponAttachments:setAlpha(0)
			f130_arg0.clipFinished(f130_arg0.WeaponAttachments)
			f130_arg0.WeaponAttachmentsSmall:completeAnimation()
			f130_arg0.WeaponAttachmentsSmall:setAlpha(0)
			f130_arg0.clipFinished(f130_arg0.WeaponAttachmentsSmall)
			f130_arg0.DropButtonPC:completeAnimation()
			f130_arg0.DropButtonPC:setAlpha(0)
			f130_arg0.clipFinished(f130_arg0.DropButtonPC)
		end,
	},
	Open_NoAttachments = {
		DefaultClip = function(f131_arg0, f131_arg1)
			f131_arg0:__resetProperties()
			f131_arg0:setupElementClipCounter(7)
			f131_arg0.Blur:completeAnimation()
			f131_arg0.Blur:setTopBottom(0, 0, 0, 217)
			f131_arg0.clipFinished(f131_arg0.Blur)
			f131_arg0.Background:completeAnimation()
			f131_arg0.Background:setTopBottom(0, 0, 0, 217)
			f131_arg0.clipFinished(f131_arg0.Background)
			f131_arg0.TiledBacking:completeAnimation()
			f131_arg0.TiledBacking:setTopBottom(0, 0, 0, 217)
			f131_arg0.clipFinished(f131_arg0.TiledBacking)
			f131_arg0.GridTiled:completeAnimation()
			f131_arg0.GridTiled:setTopBottom(0, 0, 32, 220)
			f131_arg0.clipFinished(f131_arg0.GridTiled)
			f131_arg0.WeaponVignette:completeAnimation()
			f131_arg0.WeaponVignette:setAlpha(1)
			f131_arg0.clipFinished(f131_arg0.WeaponVignette)
			f131_arg0.WeaponAttachments:completeAnimation()
			f131_arg0.WeaponAttachments:setAlpha(0)
			f131_arg0.clipFinished(f131_arg0.WeaponAttachments)
			f131_arg0.WeaponAttachmentsSmall:completeAnimation()
			f131_arg0.WeaponAttachmentsSmall:setTopBottom(0, 0, 176, -15)
			f131_arg0.WeaponAttachmentsSmall:setAlpha(0)
			f131_arg0.clipFinished(f131_arg0.WeaponAttachmentsSmall)
		end,
	},
	Open = {
		DefaultClip = function(f132_arg0, f132_arg1)
			f132_arg0:__resetProperties()
			f132_arg0:setupElementClipCounter(5)
			f132_arg0.Blur:completeAnimation()
			f132_arg0.Blur:setTopBottom(0, 0, 0, 433)
			f132_arg0.clipFinished(f132_arg0.Blur)
			f132_arg0.Background:completeAnimation()
			f132_arg0.Background:setTopBottom(0, 0, 0, 433)
			f132_arg0.clipFinished(f132_arg0.Background)
			f132_arg0.GridTiled:completeAnimation()
			f132_arg0.GridTiled:setTopBottom(0, 0, 32, 433)
			f132_arg0.clipFinished(f132_arg0.GridTiled)
			f132_arg0.WeaponVignette:completeAnimation()
			f132_arg0.WeaponVignette:setAlpha(1)
			f132_arg0.clipFinished(f132_arg0.WeaponVignette)
			f132_arg0.WeaponAttachmentsSmall:completeAnimation()
			f132_arg0.WeaponAttachmentsSmall:setAlpha(0)
			f132_arg0.clipFinished(f132_arg0.WeaponAttachmentsSmall)
		end,
	},
	Close_NoAttachments = {
		DefaultClip = function(f133_arg0, f133_arg1)
			f133_arg0:__resetProperties()
			f133_arg0:setupElementClipCounter(7)
			f133_arg0.Blur:completeAnimation()
			f133_arg0.Blur:setTopBottom(0, 0, 0, 212)
			f133_arg0.clipFinished(f133_arg0.Blur)
			f133_arg0.Background:completeAnimation()
			f133_arg0.Background:setTopBottom(0, 0, 0, 212)
			f133_arg0.clipFinished(f133_arg0.Background)
			f133_arg0.TiledBacking:completeAnimation()
			f133_arg0.TiledBacking:setTopBottom(0, 0, 0, 213)
			f133_arg0.clipFinished(f133_arg0.TiledBacking)
			f133_arg0.GridTiled:completeAnimation()
			f133_arg0.GridTiled:setTopBottom(0, 0, 32, 212)
			f133_arg0.clipFinished(f133_arg0.GridTiled)
			f133_arg0.WeaponVignette:completeAnimation()
			f133_arg0.WeaponVignette:setAlpha(1)
			f133_arg0.clipFinished(f133_arg0.WeaponVignette)
			f133_arg0.WeaponAttachments:completeAnimation()
			f133_arg0.WeaponAttachments:setAlpha(0)
			f133_arg0.clipFinished(f133_arg0.WeaponAttachments)
			f133_arg0.WeaponAttachmentsSmall:completeAnimation()
			f133_arg0.WeaponAttachmentsSmall:setAlpha(0)
			f133_arg0.clipFinished(f133_arg0.WeaponAttachmentsSmall)
		end,
	},
	Close = {
		DefaultClip = function(f134_arg0, f134_arg1)
			f134_arg0:__resetProperties()
			f134_arg0:setupElementClipCounter(6)
			f134_arg0.Blur:completeAnimation()
			f134_arg0.Blur:setTopBottom(0, 0, 0, 272)
			f134_arg0.clipFinished(f134_arg0.Blur)
			f134_arg0.Background:completeAnimation()
			f134_arg0.Background:setTopBottom(0, 0, 0, 272)
			f134_arg0.clipFinished(f134_arg0.Background)
			f134_arg0.TiledBacking:completeAnimation()
			f134_arg0.TiledBacking:setTopBottom(0, 0, 0, 272)
			f134_arg0.clipFinished(f134_arg0.TiledBacking)
			f134_arg0.GridTiled:completeAnimation()
			f134_arg0.GridTiled:setTopBottom(0, 0, 32, 272)
			f134_arg0.clipFinished(f134_arg0.GridTiled)
			f134_arg0.WeaponVignette:completeAnimation()
			f134_arg0.WeaponVignette:setAlpha(1)
			f134_arg0.clipFinished(f134_arg0.WeaponVignette)
			f134_arg0.WeaponAttachments:completeAnimation()
			f134_arg0.WeaponAttachments:setAlpha(0)
			f134_arg0.clipFinished(f134_arg0.WeaponAttachments)
		end,
	},
}
CoD.StartMenu_Inventory_WeaponsDisplayPC.__onClose = function(f135_arg0)
	f135_arg0.__on_close_removeOverrides()
	f135_arg0.WeaponVignette:close()
	f135_arg0.SwitchWeaponImage:close()
	f135_arg0.WeaponHeader:close()
	f135_arg0.WeaponAttachments:close()
	f135_arg0.WeaponAttachmentsSmall:close()
	f135_arg0.DropAndDetachButtonPC:close()
	f135_arg0.DropButtonPC:close()
end
