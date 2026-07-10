require("x64:6c3c8e6b1823b97")
require("x64:40cf6dbf464a83d")
CoD.SDDemObjectiveNotification = InheritFrom(LUI.UIElement)
CoD.SDDemObjectiveNotification.__defaultWidth = 142
CoD.SDDemObjectiveNotification.__defaultHeight = 60
CoD.SDDemObjectiveNotification.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SDDemObjectiveNotification)
	self.id = "SDDemObjectiveNotification"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WaypointA = CoD.ScoreNotificationWaypoint.new(f1_arg0, f1_arg1, 0, 0, 0, 80, 0, 0, -9, 69)
	WaypointA:mergeStateConditions({
		{
			stateName = "Captured",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("control") and AlwaysFalse()
			end,
		},
		{
			stateName = "NoFrame",
			condition = function(menu, element, event)
				return CoD.WaypointUtility.ShouldShowProgressOnIcon(f1_arg1, self) and not CoD.WaypointUtility.IsFriendlyUsing(element, f1_arg1)
			end,
		},
	})
	WaypointA:linkToElementModel(WaypointA, "objId", true, function(model)
		f1_arg0:updateElementState(WaypointA, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "objId",
		})
	end)
	WaypointA:linkToElementModel(WaypointA, "clientUseMask", true, function(model)
		f1_arg0:updateElementState(WaypointA, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientUseMask",
		})
	end)
	WaypointA:subscribeToGlobalModel(f1_arg1, "WaypointObjectiveSDDem", "waypointObjectiveA", function(model)
		WaypointA:setModel(model, f1_arg1)
	end)
	self:addElement(WaypointA)
	self.WaypointA = WaypointA
	local WaypointB = CoD.ScoreNotificationWaypoint.new(f1_arg0, f1_arg1, 0, 0, 62, 142, 0, 0, -9, 69)
	WaypointB:mergeStateConditions({
		{
			stateName = "Captured",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("control") and AlwaysFalse()
			end,
		},
		{
			stateName = "NoFrame",
			condition = function(menu, element, event)
				return CoD.WaypointUtility.ShouldShowProgressOnIcon(f1_arg1, self) and not CoD.WaypointUtility.IsFriendlyUsing(element, f1_arg1)
			end,
		},
	})
	WaypointB:linkToElementModel(WaypointB, "objId", true, function(model)
		f1_arg0:updateElementState(WaypointB, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "objId",
		})
	end)
	WaypointB:linkToElementModel(WaypointB, "clientUseMask", true, function(model)
		f1_arg0:updateElementState(WaypointB, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientUseMask",
		})
	end)
	WaypointB:subscribeToGlobalModel(f1_arg1, "WaypointObjectiveSDDem", "waypointObjectiveB", function(model)
		WaypointB:setModel(model, f1_arg1)
	end)
	self:addElement(WaypointB)
	self.WaypointB = WaypointB
	local BombPlanted = CoD.SDDemObjectiveNotification_BombPlanted.new(f1_arg0, f1_arg1, 0, 0, 0, 142, 0, 0, 0, 60)
	BombPlanted:mergeStateConditions({
		{
			stateName = "DisarmBombA",
			condition = function(menu, element, event)
				return Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xABEA46F8DE7F02F]) and not CoD.ModelUtility.IsModelValueTrue(f1_arg1, "SearchAndDestroy.defending")
			end,
		},
		{
			stateName = "DisarmBombB",
			condition = function(menu, element, event)
				return Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xABEA56F8DE7F1E2]) and not CoD.ModelUtility.IsModelValueTrue(f1_arg1, "SearchAndDestroy.defending")
			end,
		},
		{
			stateName = "DefendBombA",
			condition = function(menu, element, event)
				return Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xABEA46F8DE7F02F]) and CoD.ModelUtility.IsModelValueTrue(f1_arg1, "SearchAndDestroy.defending")
			end,
		},
		{
			stateName = "DefendBombB",
			condition = function(menu, element, event)
				return Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xABEA56F8DE7F1E2]) and CoD.ModelUtility.IsModelValueTrue(f1_arg1, "SearchAndDestroy.defending")
			end,
		},
	})
	local f1_local4 = BombPlanted
	local f1_local5 = BombPlanted.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xABEA46F8DE7F02F]], function(f16_arg0)
		f1_arg0:updateElementState(BombPlanted, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xABEA46F8DE7F02F],
		})
	end, false)
	f1_local4 = BombPlanted
	f1_local5 = BombPlanted.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["SearchAndDestroy.defending"], function(f17_arg0)
		f1_arg0:updateElementState(BombPlanted, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "SearchAndDestroy.defending",
		})
	end, false)
	f1_local4 = BombPlanted
	f1_local5 = BombPlanted.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xABEA56F8DE7F1E2]], function(f18_arg0)
		f1_arg0:updateElementState(BombPlanted, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xABEA56F8DE7F1E2],
		})
	end, false)
	BombPlanted:setAlpha(0)
	BombPlanted:subscribeToGlobalModel(f1_arg1, "WaypointObjectiveSDDem", "waypointObjectiveA", function(model)
		BombPlanted:setModel(model, f1_arg1)
	end)
	self:addElement(BombPlanted)
	self.BombPlanted = BombPlanted
	self:mergeStateConditions({
		{
			stateName = "BombPlanted",
			condition = function(menu, element, event)
				local f20_local0
				if not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xABEA46F8DE7F02F]) then
					f20_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xABEA56F8DE7F1E2])
					if f20_local0 then
						if not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5]) then
							f20_local0 = not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
						else
							f20_local0 = false
						end
					end
				elseif not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5]) then
					f20_local0 = not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
				else
					f20_local0 = false
				end
				return f20_local0
			end,
		},
	})
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xABEA46F8DE7F02F]], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xABEA46F8DE7F02F],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xABEA56F8DE7F1E2]], function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xABEA56F8DE7F1E2],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5]], function(f23_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f24_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SDDemObjectiveNotification.__resetProperties = function(f25_arg0)
	f25_arg0.WaypointA:completeAnimation()
	f25_arg0.WaypointB:completeAnimation()
	f25_arg0.BombPlanted:completeAnimation()
	f25_arg0.WaypointA:setAlpha(1)
	f25_arg0.WaypointB:setAlpha(1)
	f25_arg0.BombPlanted:setAlpha(0)
end
CoD.SDDemObjectiveNotification.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(3)
			f26_arg0.WaypointA:completeAnimation()
			f26_arg0.WaypointA:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.WaypointA)
			f26_arg0.WaypointB:completeAnimation()
			f26_arg0.WaypointB:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.WaypointB)
			f26_arg0.BombPlanted:completeAnimation()
			f26_arg0.BombPlanted:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.BombPlanted)
		end,
		BombPlanted = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(2)
			local f27_local0 = function(f28_arg0)
				f27_arg0.WaypointA:beginAnimation(250)
				f27_arg0.WaypointA:setAlpha(0)
				f27_arg0.WaypointA:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.WaypointA:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.WaypointA:completeAnimation()
			f27_arg0.WaypointA:setAlpha(1)
			f27_local0(f27_arg0.WaypointA)
			local f27_local1 = function(f29_arg0)
				f27_arg0.WaypointB:beginAnimation(250)
				f27_arg0.WaypointB:setAlpha(0)
				f27_arg0.WaypointB:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.WaypointB:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.WaypointB:completeAnimation()
			f27_arg0.WaypointB:setAlpha(1)
			f27_local1(f27_arg0.WaypointB)
		end,
	},
	BombPlanted = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(3)
			f30_arg0.WaypointA:completeAnimation()
			f30_arg0.WaypointA:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.WaypointA)
			f30_arg0.WaypointB:completeAnimation()
			f30_arg0.WaypointB:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.WaypointB)
			f30_arg0.BombPlanted:completeAnimation()
			f30_arg0.BombPlanted:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.BombPlanted)
		end,
		DefaultState = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(3)
			f31_arg0.WaypointA:completeAnimation()
			f31_arg0.WaypointA:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.WaypointA)
			f31_arg0.WaypointB:completeAnimation()
			f31_arg0.WaypointB:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.WaypointB)
			local f31_local0 = function(f32_arg0)
				f31_arg0.BombPlanted:beginAnimation(2000)
				f31_arg0.BombPlanted:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.BombPlanted:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.BombPlanted:completeAnimation()
			f31_arg0.BombPlanted:setAlpha(1)
			f31_local0(f31_arg0.BombPlanted)
		end,
	},
}
CoD.SDDemObjectiveNotification.__onClose = function(f33_arg0)
	f33_arg0.WaypointA:close()
	f33_arg0.WaypointB:close()
	f33_arg0.BombPlanted:close()
end
