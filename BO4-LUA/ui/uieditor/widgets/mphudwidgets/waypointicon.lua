require("ui/uieditor/widgets/mphudwidgets/waypointicontimer")
CoD.WaypointIcon = InheritFrom(LUI.UIElement)
CoD.WaypointIcon.__defaultWidth = 76
CoD.WaypointIcon.__defaultHeight = 76
CoD.WaypointIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WaypointIcon)
	self.id = "WaypointIcon"
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
	local waypointCenterImage2 = LUI.UIImage.new(0, 0, 0, 76, 0, 0, 0, 76)
	waypointCenterImage2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	waypointCenterImage2:setShaderVector(0, 1, 0, 0, 0)
	waypointCenterImage2:linkToElementModel(self, "color", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			waypointCenterImage2:setRGB(CoD.WaypointUtility.ConvertToMutedColor(f4_local0))
		end
	end)
	waypointCenterImage2:linkToElementModel(self, "icon", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			waypointCenterImage2:setImage(RegisterImage(BlackTransparentIfNilOrEmpty(f5_local0)))
		end
	end)
	self:addElement(waypointCenterImage2)
	self.waypointCenterImage2 = waypointCenterImage2
	local waypointCenterImage3 = LUI.UIImage.new(0, 0, 0, 76, 0, 0, 0, 76)
	waypointCenterImage3:setAlpha(0.5)
	waypointCenterImage3:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	waypointCenterImage3:setShaderVector(0, 1.2, 0, 0, 0)
	waypointCenterImage3:linkToElementModel(self, "color", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			waypointCenterImage3:setRGB(CoD.WaypointUtility.ConvertToBrightColor(f6_local0))
		end
	end)
	waypointCenterImage3:linkToElementModel(self, "icon", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			waypointCenterImage3:setImage(RegisterImage(BlackTransparentIfNilOrEmpty(f7_local0)))
		end
	end)
	self:addElement(waypointCenterImage3)
	self.waypointCenterImage3 = waypointCenterImage3
	local waypointLowProgressPulse = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	waypointLowProgressPulse:setAlpha(0)
	waypointLowProgressPulse:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe_delta_normal"))
	waypointLowProgressPulse:setShaderVector(0, 0, 1, 0, 0)
	waypointLowProgressPulse:setShaderVector(1, 0, 0, 0, 0)
	waypointLowProgressPulse:setShaderVector(3, 0, 0, 0, 0)
	waypointLowProgressPulse:setShaderVector(4, 0, 0, 0, 0)
	waypointLowProgressPulse:linkToElementModel(self, "color", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			waypointLowProgressPulse:setRGB(CoD.WaypointUtility.ConvertToBaseColor(f8_local0))
		end
	end)
	waypointLowProgressPulse:linkToElementModel(self, "progress", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			waypointLowProgressPulse:setShaderVector(2, CoD.WaypointUtility.SetIconProgressMeter(f1_arg1, true, CoD.GetVectorComponentFromString(f9_local0, 1), CoD.GetVectorComponentFromString(f9_local0, 2), CoD.GetVectorComponentFromString(f9_local0, 3), CoD.GetVectorComponentFromString(f9_local0, 4)))
		end
	end)
	self:addElement(waypointLowProgressPulse)
	self.waypointLowProgressPulse = waypointLowProgressPulse
	local waypointCenterImageDarkWipe = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	waypointCenterImageDarkWipe:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe_delta_normal"))
	waypointCenterImageDarkWipe:setShaderVector(0, 0, 1, 0, 0)
	waypointCenterImageDarkWipe:setShaderVector(1, 0, 0, 0, 0)
	waypointCenterImageDarkWipe:setShaderVector(3, 0, 0, 0, 0)
	waypointCenterImageDarkWipe:setShaderVector(4, 0, 0, 0, 0)
	waypointCenterImageDarkWipe:linkToElementModel(self, "color", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			waypointCenterImageDarkWipe:setRGB(ColorMultiply(0.5, CoD.WaypointUtility.ConvertToBaseColor(f10_local0)))
		end
	end)
	waypointCenterImageDarkWipe:linkToElementModel(self, "icon", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			waypointCenterImageDarkWipe:setImage(RegisterImage(BlackTransparentIfNilOrEmpty(f11_local0)))
		end
	end)
	waypointCenterImageDarkWipe:linkToElementModel(self, "progress", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			waypointCenterImageDarkWipe:setShaderVector(2, CoD.WaypointUtility.SetIconProgressMeter(f1_arg1, false, CoD.GetVectorComponentFromString(f12_local0, 1), CoD.GetVectorComponentFromString(f12_local0, 2), CoD.GetVectorComponentFromString(f12_local0, 3), CoD.GetVectorComponentFromString(f12_local0, 4)))
		end
	end)
	self:addElement(waypointCenterImageDarkWipe)
	self.waypointCenterImageDarkWipe = waypointCenterImageDarkWipe
	local waypointCenterImageDarkClock = CoD.WaypointIconTimer.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	waypointCenterImageDarkClock:linkToElementModel(self, "radialTimer", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			waypointCenterImageDarkClock:setModel(f13_local0, f1_arg1)
		end
	end)
	waypointCenterImageDarkClock:linkToElementModel(self, "color", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			waypointCenterImageDarkClock.waypointCenterImageDarkClock:setRGB(ColorMultiply(0.5, CoD.WaypointUtility.ConvertToBaseColor(f14_local0)))
		end
	end)
	waypointCenterImageDarkClock:linkToElementModel(self, "icon", true, function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			waypointCenterImageDarkClock.waypointCenterImageDarkClock:setImage(RegisterImage(BlackTransparentIfNilOrEmpty(f15_local0)))
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
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine.GetModelForController(f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum.UIVisibilityBit[@"bit_bomb_timer_a"]], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit[@"bit_bomb_timer_a"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine.GetModelForController(f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum.UIVisibilityBit[@"bit_bomb_timer_b"]], function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit[@"bit_bomb_timer_b"],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WaypointIcon.__resetProperties = function(f23_arg0)
	f23_arg0.waypointCenterImageDarkWipe:completeAnimation()
	f23_arg0.waypointLowProgressPulse:completeAnimation()
	f23_arg0.waypointCenterImageDarkClock:completeAnimation()
	f23_arg0.waypointCenterImageDarkWipe:setAlpha(1)
	f23_arg0.waypointLowProgressPulse:setLeftRight(0, 1, 0, 0)
	f23_arg0.waypointLowProgressPulse:setTopBottom(0, 1, 0, 0)
	f23_arg0.waypointLowProgressPulse:setAlpha(0)
	f23_arg0.waypointCenterImageDarkClock:setAlpha(1)
end
CoD.WaypointIcon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(3)
			f24_arg0.waypointLowProgressPulse:completeAnimation()
			f24_arg0.waypointLowProgressPulse:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.waypointLowProgressPulse)
			f24_arg0.waypointCenterImageDarkWipe:completeAnimation()
			f24_arg0.waypointCenterImageDarkWipe:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.waypointCenterImageDarkWipe)
			f24_arg0.waypointCenterImageDarkClock:completeAnimation()
			f24_arg0.waypointCenterImageDarkClock:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.waypointCenterImageDarkClock)
		end,
	},
	LowProgressPulse = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(3)
			local f25_local0 = function(f26_arg0)
				local f26_local0 = function(f27_arg0)
					f27_arg0:beginAnimation(250)
					f27_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
				end
				f25_arg0.waypointLowProgressPulse:beginAnimation(750)
				f25_arg0.waypointLowProgressPulse:setLeftRight(-0.25, 1.25, 0, 0)
				f25_arg0.waypointLowProgressPulse:setAlpha(0)
				f25_arg0.waypointLowProgressPulse:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.waypointLowProgressPulse:registerEventHandler("transition_complete_keyframe", f26_local0)
			end
			f25_arg0.waypointLowProgressPulse:completeAnimation()
			f25_arg0.waypointLowProgressPulse:setLeftRight(0.5, 0.5, 0, 0)
			f25_arg0.waypointLowProgressPulse:setTopBottom(0, 1, 0, 0)
			f25_arg0.waypointLowProgressPulse:setAlpha(1)
			f25_local0(f25_arg0.waypointLowProgressPulse)
			f25_arg0.waypointCenterImageDarkWipe:completeAnimation()
			f25_arg0.waypointCenterImageDarkWipe:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.waypointCenterImageDarkWipe)
			f25_arg0.waypointCenterImageDarkClock:completeAnimation()
			f25_arg0.waypointCenterImageDarkClock:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.waypointCenterImageDarkClock)
			f25_arg0.nextClip = "DefaultClip"
		end,
	},
	ShowProgress = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(3)
			f28_arg0.waypointLowProgressPulse:completeAnimation()
			f28_arg0.waypointLowProgressPulse:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.waypointLowProgressPulse)
			f28_arg0.waypointCenterImageDarkWipe:completeAnimation()
			f28_arg0.waypointCenterImageDarkWipe:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.waypointCenterImageDarkWipe)
			f28_arg0.waypointCenterImageDarkClock:completeAnimation()
			f28_arg0.waypointCenterImageDarkClock:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.waypointCenterImageDarkClock)
		end,
	},
	RadialTimer = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(3)
			f29_arg0.waypointLowProgressPulse:completeAnimation()
			f29_arg0.waypointLowProgressPulse:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.waypointLowProgressPulse)
			f29_arg0.waypointCenterImageDarkWipe:completeAnimation()
			f29_arg0.waypointCenterImageDarkWipe:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.waypointCenterImageDarkWipe)
			f29_arg0.waypointCenterImageDarkClock:completeAnimation()
			f29_arg0.waypointCenterImageDarkClock:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.waypointCenterImageDarkClock)
		end,
	},
}
CoD.WaypointIcon.__onClose = function(f30_arg0)
	f30_arg0.waypointCenterImage:close()
	f30_arg0.waypointCenterImage2:close()
	f30_arg0.waypointCenterImage3:close()
	f30_arg0.waypointLowProgressPulse:close()
	f30_arg0.waypointCenterImageDarkWipe:close()
	f30_arg0.waypointCenterImageDarkClock:close()
end
