require("x64:95a71fda29b6a0a")
CoD.CompassAwarenessRingSegment = InheritFrom(LUI.UIElement)
CoD.CompassAwarenessRingSegment.__defaultWidth = 330
CoD.CompassAwarenessRingSegment.__defaultHeight = 330
CoD.CompassAwarenessRingSegment.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CompassAwarenessRingSegment)
	self.id = "CompassAwarenessRingSegment"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local Inner = CoD.CompassAwarenessRingZone.new(f1_arg0, f1_arg1, 0.5, 0.5, -165, 165, 0.5, 0.5, -165, 165)
	Inner:mergeStateConditions({
		{
			stateName = "Detect_CUAV",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueBitSet(element, f1_arg1, "segmentValue", CoD.HUDUtility.AwarenessLevels.AWARENESS_LEVEL_INNER_BIT) and IsVisibilityBitSet(f1_arg1, Enum[0x7F032C2EF103A1A][0xF0EF20BB6FB88F])
			end,
		},
		{
			stateName = "Detect_Jammed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueBitSet(element, f1_arg1, "segmentValue", CoD.HUDUtility.AwarenessLevels.AWARENESS_LEVEL_INNER_BIT) and CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "HUDItems", "jammedStrength", 0)
			end,
		},
		{
			stateName = "Detect",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueBitSet(element, f1_arg1, "segmentValue", CoD.HUDUtility.AwarenessLevels.AWARENESS_LEVEL_INNER_BIT)
			end,
		},
	})
	Inner:linkToElementModel(Inner, "segmentValue", true, function(model)
		f1_arg0:updateElementState(Inner, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "segmentValue",
		})
	end)
	local f1_local2 = Inner
	local Outer = Inner.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	Outer(f1_local2, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF0EF20BB6FB88F]], function(f6_arg0)
		f1_arg0:updateElementState(Inner, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF0EF20BB6FB88F],
		})
	end, false)
	f1_local2 = Inner
	Outer = Inner.subscribeToModel
	f1_local4 = DataSources.HUDItems.getModel(f1_arg1)
	Outer(f1_local2, f1_local4.jammedStrength, function(f7_arg0)
		f1_arg0:updateElementState(Inner, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "jammedStrength",
		})
	end, false)
	Inner:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
	Inner:linkToElementModel(self, nil, false, function(model)
		Inner:setModel(model, f1_arg1)
	end)
	self:addElement(Inner)
	self.Inner = Inner
	Outer = CoD.CompassAwarenessRingZone.new(f1_arg0, f1_arg1, 0.5, 0.5, -165, 165, 0.5, 0.5, -165, 165)
	Outer:mergeStateConditions({
		{
			stateName = "Detect_CUAV",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueBitSet(element, f1_arg1, "segmentValue", CoD.HUDUtility.AwarenessLevels.AWARENESS_LEVEL_OUTER_BIT) and IsVisibilityBitSet(f1_arg1, Enum[0x7F032C2EF103A1A][0xF0EF20BB6FB88F])
			end,
		},
		{
			stateName = "Detect_Jammed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueBitSet(element, f1_arg1, "segmentValue", CoD.HUDUtility.AwarenessLevels.AWARENESS_LEVEL_OUTER_BIT) and CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "HUDItems", "jammedStrength", 0)
			end,
		},
		{
			stateName = "Detect",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueBitSet(element, f1_arg1, "segmentValue", CoD.HUDUtility.AwarenessLevels.AWARENESS_LEVEL_OUTER_BIT)
			end,
		},
	})
	Outer:linkToElementModel(Outer, "segmentValue", true, function(model)
		f1_arg0:updateElementState(Outer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "segmentValue",
		})
	end)
	f1_local4 = Outer
	f1_local2 = Outer.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local2(f1_local4, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF0EF20BB6FB88F]], function(f13_arg0)
		f1_arg0:updateElementState(Outer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF0EF20BB6FB88F],
		})
	end, false)
	f1_local4 = Outer
	f1_local2 = Outer.subscribeToModel
	f1_local5 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local2(f1_local4, f1_local5.jammedStrength, function(f14_arg0)
		f1_arg0:updateElementState(Outer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "jammedStrength",
		})
	end, false)
	Outer:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
	Outer:linkToElementModel(self, nil, false, function(model)
		Outer:setModel(model, f1_arg1)
	end)
	self:addElement(Outer)
	self.Outer = Outer
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CompassAwarenessRingSegment.__onClose = function(f16_arg0)
	f16_arg0.Inner:close()
	f16_arg0.Outer:close()
end
