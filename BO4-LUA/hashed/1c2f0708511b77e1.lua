require("x64:2675595fa323085")
require("x64:1de9b3de837a34c")
require("x64:90bfa8fd4b71a33")
require("x64:2e06eec4ea38539")
require("x64:7631da4ee57d7b6")
CoD.MultiItemPickupKBM = InheritFrom(LUI.UIElement)
CoD.MultiItemPickupKBM.__defaultWidth = 1920
CoD.MultiItemPickupKBM.__defaultHeight = 1080
CoD.MultiItemPickupKBM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.MultiItemPickupKBM)
	self.id = "MultiItemPickupKBM"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	emptyFocusable:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(emptyFocusable, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "MOUSE1", function(element, menu, controller, model)
		CoD.ModelUtility.SetGlobalDatasourceModelValueToEnum(controller, "MultiItemPickup", "status", Enum[0x163CDAE6010C493][0xE16E7DEBC8823D8])
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "MOUSE1")
		return false
	end, false)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local focusBlocker = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0.5, 0.5, -468, 168, 0.5, 0.5, -160, 160)
	self:addElement(focusBlocker)
	self.focusBlocker = focusBlocker
	local Blur = LUI.UIImage.new(0.5, 0.5, -468, 168, 0.5, 0.5, -160, 160)
	Blur:setRGB(0.08, 0.08, 0.08)
	Blur:setAlpha(0.7)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local GridBacking = CoD.WeaponPickupPrompt_Backing.new(f1_arg0, f1_arg1, 0.5, 0.5, -468, 168, 0.5, 0.5, -160, 160)
	GridBacking:setRGB(0.08, 0.08, 0.08)
	self:addElement(GridBacking)
	self.GridBacking = GridBacking
	local ItemHeader = CoD.MultiItemPickupWaypoint_Header.new(f1_arg0, f1_arg1, 0.5, 0.5, -300, 0, 0.5, 0.5, 120, 160)
	self:addElement(ItemHeader)
	self.ItemHeader = ItemHeader
	local ItemPickupList = LUI.UIList.new(f1_arg0, f1_arg1, -15, 100, nil, false, false, false, true)
	ItemPickupList:setLeftRight(0.5, 0.5, -439.5, 139.5)
	ItemPickupList:setTopBottom(0.5, 0.5, -159, 120)
	ItemPickupList:setWidgetType(CoD.MultiItemPickupWaypointItem)
	ItemPickupList:setHorizontalCount(4)
	ItemPickupList:setVerticalCount(4)
	ItemPickupList:setSpacing(-15)
	ItemPickupList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ItemPickupList:setVerticalScrollbar(CoD.verticalScrollbar)
	ItemPickupList:setDataSource("MultiItemPickup")
	ItemPickupList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f5_local0 = nil
		CoD.HUDUtility.SetAsCurrentMultiItemPickup(f1_arg1, element)
		return f5_local0
	end)
	ItemPickupList:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ItemPickupList, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "MOUSE1", function(element, menu, controller, model)
		CoD.WZUtility.SendInventoryPickUpNotify(controller, element)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "MOUSE1")
		return false
	end, false)
	ItemPickupList:subscribeToGlobalModel(f1_arg1, "MultiItemPickup", "status", function(model)
		local f9_local0 = ItemPickupList
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "MultiItemPickup", "status", Enum[0x163CDAE6010C493][0xC9FADA56582F80F]) then
			CoD.BaseUtility.EnableNavigation(f9_local0)
		else
			CoD.BaseUtility.DisableNavigation(f9_local0)
		end
	end)
	ItemPickupList:subscribeToGlobalModel(f1_arg1, "PerController", "scriptNotify", function(model)
		local f10_local0 = ItemPickupList
		if CoD.ModelUtility.IsParamModelEqualToHashString(model, 0x15EF5E7734C15F5) then
			CoD.WZUtility.SendInventoryPickUpNotify(f1_arg1, f10_local0)
		end
	end)
	self:addElement(ItemPickupList)
	self.ItemPickupList = ItemPickupList
	ItemHeader:linkToElementModel(ItemPickupList, nil, false, function(model)
		ItemHeader:setModel(model, f1_arg1)
	end)
	self:mergeStateConditions({
		{
			stateName = "Active",
			condition = function(menu, element, event)
				local f12_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "MultiItemPickup", "status", Enum[0x163CDAE6010C493][0xC9FADA56582F80F])
				if f12_local0 then
					if
						not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769])
						and Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x49AC9E07ED19EB6])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6668F0686232679])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD567EDB5609CCEC])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA77EB9347BE4DFF])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
					then
						f12_local0 = IsMouseOrKeyboard(f1_arg1)
						if f12_local0 then
							f12_local0 = AlwaysFalse()
						end
					else
						f12_local0 = false
					end
				end
				return f12_local0
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = DataSources.MultiItemPickup.getModel(f1_arg1)
	f1_local8(f1_local7, f1_local9.status, function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "status",
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769]], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7]], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x49AC9E07ED19EB6]], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x49AC9E07ED19EB6],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679]], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD567EDB5609CCEC]], function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD567EDB5609CCEC],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]], function(f23_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA77EB9347BE4DFF]], function(f24_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA77EB9347BE4DFF],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f25_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5]], function(f26_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f26_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f27_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5]], function(f28_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD]], function(f29_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f29_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f30_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f30_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f31_arg0, f31_arg1)
		f31_arg1.menu = f31_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f31_arg1)
	end)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9.LastInput, function(f32_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f32_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = DataSources.MultiItemPickup.getModel(f1_arg1)
	f1_local8(f1_local7, f1_local9.status, function(f33_arg0, f33_arg1)
		CoD.Menu.UpdateButtonShownState(f33_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end, false)
	self:registerEventHandler("input_source_changed", function(self, event)
		local f34_local0 = nil
		if IsMouseOrKeyboard(f1_arg1) and not IsInDefaultState(self) then
			LockInput(self, f1_arg1, true)
			SetAllowCursorMovement(f1_arg0, true)
		elseif not IsMouseOrKeyboard(f1_arg1) and not IsInDefaultState(self) then
			LockInput(self, f1_arg1, false)
			SetAllowCursorMovement(f1_arg0, false)
		end
		if not f34_local0 then
			f34_local0 = self:dispatchEventToChildren(event)
		end
		return f34_local0
	end)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ESCAPE", function(element, menu, controller, model)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(controller, "MultiItemPickup", "status", Enum[0x163CDAE6010C493][0xC9FADA56582F80F]) then
			CoD.ModelUtility.SetGlobalDatasourceModelValueToEnum(controller, "MultiItemPickup", "status", Enum[0x163CDAE6010C493][0xE16E7DEBC8823D8])
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(controller, "MultiItemPickup", "status", Enum[0x163CDAE6010C493][0xC9FADA56582F80F]) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "ESCAPE")
			return false
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f37_arg2, f37_arg3, f37_arg4)
		if CoD.BaseUtility.IsSelfInState(self, "Active") then
			LockInput(self, controller, true)
			SetAllowCursorMovement(f1_arg0, true)
		else
			LockInput(self, controller, false)
			SetAllowCursorMovement(f1_arg0, false)
		end
	end)
	emptyFocusable.id = "emptyFocusable"
	focusBlocker.id = "focusBlocker"
	ItemPickupList.id = "ItemPickupList"
	self.__defaultFocus = ItemPickupList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local8 = self
	DisableKeyboardNavigationByElement(emptyFocusable)
	DisableKeyboardNavigationByElement(focusBlocker)
	f1_local8 = ItemPickupList
	CoD.PCUtility.ActivateListPCSelectionBehavior(f1_local8)
	CoD.GridAndListUtility.AddListUpDownNavigation(f1_arg0, f1_local8, f1_arg1)
	CoD.GridAndListUtility.AddActiveLeftRightNavigation(f1_arg0, f1_local8, f1_arg1, false)
	SetElementProperty(self.ItemPickupList, "__isForKBM", true)
	return self
end
CoD.MultiItemPickupKBM.__resetProperties = function(f38_arg0)
	f38_arg0.ItemHeader:completeAnimation()
	f38_arg0.GridBacking:completeAnimation()
	f38_arg0.ItemPickupList:completeAnimation()
	f38_arg0.Blur:completeAnimation()
	f38_arg0.emptyFocusable:completeAnimation()
	f38_arg0.focusBlocker:completeAnimation()
	f38_arg0.ItemHeader:setAlpha(1)
	f38_arg0.GridBacking:setAlpha(1)
	f38_arg0.ItemPickupList:setAlpha(1)
	f38_arg0.Blur:setAlpha(0.7)
	f38_arg0.emptyFocusable:setAlpha(1)
	f38_arg0.focusBlocker:setAlpha(1)
end
CoD.MultiItemPickupKBM.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(6)
			f39_arg0.emptyFocusable:completeAnimation()
			f39_arg0.emptyFocusable:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.emptyFocusable)
			f39_arg0.focusBlocker:completeAnimation()
			f39_arg0.focusBlocker:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.focusBlocker)
			f39_arg0.Blur:completeAnimation()
			f39_arg0.Blur:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.Blur)
			f39_arg0.GridBacking:completeAnimation()
			f39_arg0.GridBacking:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.GridBacking)
			f39_arg0.ItemHeader:completeAnimation()
			f39_arg0.ItemHeader:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.ItemHeader)
			f39_arg0.ItemPickupList:completeAnimation()
			f39_arg0.ItemPickupList:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.ItemPickupList)
		end,
	},
	Active = {
		DefaultClip = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(5)
			f40_arg0.emptyFocusable:completeAnimation()
			f40_arg0.emptyFocusable:setAlpha(1)
			f40_arg0.clipFinished(f40_arg0.emptyFocusable)
			f40_arg0.Blur:completeAnimation()
			f40_arg0.Blur:setAlpha(0.7)
			f40_arg0.clipFinished(f40_arg0.Blur)
			f40_arg0.GridBacking:completeAnimation()
			f40_arg0.GridBacking:setAlpha(1)
			f40_arg0.clipFinished(f40_arg0.GridBacking)
			f40_arg0.ItemHeader:completeAnimation()
			f40_arg0.ItemHeader:setAlpha(1)
			f40_arg0.clipFinished(f40_arg0.ItemHeader)
			f40_arg0.ItemPickupList:completeAnimation()
			f40_arg0.ItemPickupList:setAlpha(1)
			f40_arg0.clipFinished(f40_arg0.ItemPickupList)
		end,
	},
}
CoD.MultiItemPickupKBM.__onClose = function(f41_arg0)
	f41_arg0.ItemHeader:close()
	f41_arg0.emptyFocusable:close()
	f41_arg0.focusBlocker:close()
	f41_arg0.GridBacking:close()
	f41_arg0.ItemPickupList:close()
end
