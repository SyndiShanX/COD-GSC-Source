require("x64:3fb67c82deb1955")
CoD.WaypointIconSimple = InheritFrom(LUI.UIElement)
CoD.WaypointIconSimple.__defaultWidth = 76
CoD.WaypointIconSimple.__defaultHeight = 76
CoD.WaypointIconSimple.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WaypointIconSimple)
	self.id = "WaypointIconSimple"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local waypointCenterImage = LUI.UIImage.new(0, 0, 0, 76, 0, 0, 0, 76)
	waypointCenterImage:linkToElementModel(self, "color", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			waypointCenterImage:setRGB(CoD.WaypointUtility.ConvertToBaseColor(f2_local0))
		end
	end)
	waypointCenterImage:linkToElementModel(self, "icon", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			waypointCenterImage:setImage(RegisterImage(BlackTransparentIfNilOrEmpty(f3_local0)))
		end
	end)
	self:addElement(waypointCenterImage)
	self.waypointCenterImage = waypointCenterImage
	local waypointLowProgressPulse = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	waypointLowProgressPulse:setAlpha(0)
	waypointLowProgressPulse:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	waypointLowProgressPulse:setShaderVector(0, 0, 1, 0, 0)
	waypointLowProgressPulse:setShaderVector(1, 0, 0, 0, 0)
	waypointLowProgressPulse:setShaderVector(3, 0, 0, 0, 0)
	waypointLowProgressPulse:setShaderVector(4, 0, 0, 0, 0)
	waypointLowProgressPulse:linkToElementModel(self, "color", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			waypointLowProgressPulse:setRGB(CoD.WaypointUtility.ConvertToBaseColor(f4_local0))
		end
	end)
	waypointLowProgressPulse:linkToElementModel(self, "progress", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			waypointLowProgressPulse:setShaderVector(2, CoD.WaypointUtility.SetIconProgressMeter(f1_arg1, true, CoD.GetVectorComponentFromString(f5_local0, 1), CoD.GetVectorComponentFromString(f5_local0, 2), CoD.GetVectorComponentFromString(f5_local0, 3), CoD.GetVectorComponentFromString(f5_local0, 4)))
		end
	end)
	self:addElement(waypointLowProgressPulse)
	self.waypointLowProgressPulse = waypointLowProgressPulse
	local waypointCenterImageDarkWipe = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	waypointCenterImageDarkWipe:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	waypointCenterImageDarkWipe:setShaderVector(0, 0, 1, 0, 0)
	waypointCenterImageDarkWipe:setShaderVector(1, 0, 0, 0, 0)
	waypointCenterImageDarkWipe:setShaderVector(3, 0, 0, 0, 0)
	waypointCenterImageDarkWipe:setShaderVector(4, 0, 0, 0, 0)
	waypointCenterImageDarkWipe:linkToElementModel(self, "color", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			waypointCenterImageDarkWipe:setRGB(ColorMultiply(0.5, CoD.WaypointUtility.ConvertToBaseColor(f6_local0)))
		end
	end)
	waypointCenterImageDarkWipe:linkToElementModel(self, "icon", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			waypointCenterImageDarkWipe:setImage(RegisterImage(BlackTransparentIfNilOrEmpty(f7_local0)))
		end
	end)
	waypointCenterImageDarkWipe:linkToElementModel(self, "progress", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			waypointCenterImageDarkWipe:setShaderVector(2, CoD.WaypointUtility.SetIconProgressMeter(f1_arg1, false, CoD.GetVectorComponentFromString(f8_local0, 1), CoD.GetVectorComponentFromString(f8_local0, 2), CoD.GetVectorComponentFromString(f8_local0, 3), CoD.GetVectorComponentFromString(f8_local0, 4)))
		end
	end)
	self:addElement(waypointCenterImageDarkWipe)
	self.waypointCenterImageDarkWipe = waypointCenterImageDarkWipe
	local waypointCenterImageDarkClock = CoD.WaypointIconTimer.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	waypointCenterImageDarkClock:linkToElementModel(self, "radialTimer", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			waypointCenterImageDarkClock:setModel(f9_local0, f1_arg1)
		end
	end)
	waypointCenterImageDarkClock:linkToElementModel(self, "color", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			waypointCenterImageDarkClock.waypointCenterImageDarkClock:setRGB(ColorMultiply(0.5, CoD.WaypointUtility.ConvertToBaseColor(f10_local0)))
		end
	end)
	waypointCenterImageDarkClock:linkToElementModel(self, "icon", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			waypointCenterImageDarkClock.waypointCenterImageDarkClock:setImage(RegisterImage(BlackTransparentIfNilOrEmpty(f11_local0)))
		end
	end)
	self:addElement(waypointCenterImageDarkClock)
	self.waypointCenterImageDarkClock = waypointCenterImageDarkClock
	self:mergeStateConditions({
		{
			stateName = "LowProgressPulse",
			condition = function(menu, element, event)
				return CoD.WaypointUtility.ShouldShowPulsingProgressOnIcon(f1_arg1, self)
			end,
		},
		{
			stateName = "ShowProgress",
			condition = function(menu, element, event)
				return CoD.WaypointUtility.ShouldShowProgressOnIcon(f1_arg1, self)
			end,
		},
		{
			stateName = "RadialTimer",
			condition = function(menu, element, event)
				return CoD.WaypointUtility.ShouldShowRadialTimerOnIcon(f1_arg1, self)
			end,
		},
	})
	self:linkToElementModel(self, "objId", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "objId",
		})
	end)
	self:linkToElementModel(self, "progress", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "progress",
		})
	end)
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xABEA46F8DE7F02F]], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xABEA46F8DE7F02F],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xABEA56F8DE7F1E2]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xABEA56F8DE7F1E2],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WaypointIconSimple.__resetProperties = function(f19_arg0)
	f19_arg0.waypointCenterImageDarkWipe:completeAnimation()
	f19_arg0.waypointLowProgressPulse:completeAnimation()
	f19_arg0.waypointCenterImageDarkClock:completeAnimation()
	f19_arg0.waypointCenterImageDarkWipe:setAlpha(1)
	f19_arg0.waypointLowProgressPulse:setLeftRight(0, 1, 0, 0)
	f19_arg0.waypointLowProgressPulse:setTopBottom(0, 1, 0, 0)
	f19_arg0.waypointLowProgressPulse:setAlpha(0)
	f19_arg0.waypointCenterImageDarkClock:setAlpha(1)
end
CoD.WaypointIconSimple.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(3)
			f20_arg0.waypointLowProgressPulse:completeAnimation()
			f20_arg0.waypointLowProgressPulse:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.waypointLowProgressPulse)
			f20_arg0.waypointCenterImageDarkWipe:completeAnimation()
			f20_arg0.waypointCenterImageDarkWipe:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.waypointCenterImageDarkWipe)
			f20_arg0.waypointCenterImageDarkClock:completeAnimation()
			f20_arg0.waypointCenterImageDarkClock:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.waypointCenterImageDarkClock)
		end,
	},
	LowProgressPulse = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			local f21_local0 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					f23_arg0:beginAnimation(250)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
				end
				f21_arg0.waypointLowProgressPulse:beginAnimation(750)
				f21_arg0.waypointLowProgressPulse:setLeftRight(-0.25, 1.25, 0, 0)
				f21_arg0.waypointLowProgressPulse:setAlpha(0)
				f21_arg0.waypointLowProgressPulse:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.waypointLowProgressPulse:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f21_arg0.waypointLowProgressPulse:completeAnimation()
			f21_arg0.waypointLowProgressPulse:setLeftRight(0.5, 0.5, 0, 0)
			f21_arg0.waypointLowProgressPulse:setTopBottom(0, 1, 0, 0)
			f21_arg0.waypointLowProgressPulse:setAlpha(1)
			f21_local0(f21_arg0.waypointLowProgressPulse)
			f21_arg0.waypointCenterImageDarkWipe:completeAnimation()
			f21_arg0.waypointCenterImageDarkWipe:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.waypointCenterImageDarkWipe)
			f21_arg0.waypointCenterImageDarkClock:completeAnimation()
			f21_arg0.waypointCenterImageDarkClock:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.waypointCenterImageDarkClock)
			f21_arg0.nextClip = "DefaultClip"
		end,
	},
	ShowProgress = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(3)
			f24_arg0.waypointLowProgressPulse:completeAnimation()
			f24_arg0.waypointLowProgressPulse:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.waypointLowProgressPulse)
			f24_arg0.waypointCenterImageDarkWipe:completeAnimation()
			f24_arg0.waypointCenterImageDarkWipe:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.waypointCenterImageDarkWipe)
			f24_arg0.waypointCenterImageDarkClock:completeAnimation()
			f24_arg0.waypointCenterImageDarkClock:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.waypointCenterImageDarkClock)
		end,
	},
	RadialTimer = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(3)
			f25_arg0.waypointLowProgressPulse:completeAnimation()
			f25_arg0.waypointLowProgressPulse:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.waypointLowProgressPulse)
			f25_arg0.waypointCenterImageDarkWipe:completeAnimation()
			f25_arg0.waypointCenterImageDarkWipe:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.waypointCenterImageDarkWipe)
			f25_arg0.waypointCenterImageDarkClock:completeAnimation()
			f25_arg0.waypointCenterImageDarkClock:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.waypointCenterImageDarkClock)
		end,
	},
}
CoD.WaypointIconSimple.__onClose = function(f26_arg0)
	f26_arg0.waypointCenterImage:close()
	f26_arg0.waypointLowProgressPulse:close()
	f26_arg0.waypointCenterImageDarkWipe:close()
	f26_arg0.waypointCenterImageDarkClock:close()
end
