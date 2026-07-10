CoD.SprintMeterDots = InheritFrom(LUI.UIElement)
CoD.SprintMeterDots.__defaultWidth = 207
CoD.SprintMeterDots.__defaultHeight = 54
CoD.SprintMeterDots.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModel(f1_arg1, "playerAbilities.playerSprintBoosting", false)
	self:setClass(CoD.SprintMeterDots)
	self.id = "SprintMeterDots"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local maxSprintBarBacking = LUI.UIImage.new(0, 0, 0, 137, 0, 0, 22, 34)
	maxSprintBarBacking:setRGB(0, 0, 0)
	maxSprintBarBacking:setAlpha(0)
	maxSprintBarBacking:setZRot(180)
	self:addElement(maxSprintBarBacking)
	self.maxSprintBarBacking = maxSprintBarBacking
	local sprintDecaryBarBacking = LUI.UIImage.new(0, 0, 142, 212, 0, 0, 22, 34)
	sprintDecaryBarBacking:setRGB(0, 0, 0)
	sprintDecaryBarBacking:setAlpha(0)
	sprintDecaryBarBacking:setYRot(180)
	sprintDecaryBarBacking:setImage(RegisterImage(0xA60C595B14D44BE))
	self:addElement(sprintDecaryBarBacking)
	self.sprintDecaryBarBacking = sprintDecaryBarBacking
	local dots = LUI.UIImage.new(0, 0, -16, 224, 0, 0, -8, 64)
	dots:setRGB(0.84, 0.95, 0.97)
	dots:setAlpha(0)
	dots:setImage(RegisterImage(0xB52839D1088C8F9))
	dots:setMaterial(LUI.UIImage.GetCachedMaterial(0xD5CA1A25ED87F4F))
	dots:setShaderVector(0, 0.52, 0, 0, 0)
	dots:setShaderVector(1, 0.5, 0, 0, 0)
	dots:setShaderVector(2, -2.84, 0, 0, 0)
	dots:setShaderVector(3, 0, 0, 0, 0)
	dots:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(dots)
	self.dots = dots
	local fill = LUI.UIImage.new(0, 0, -16, 224, 0, 0, -8, 64)
	fill:setAlpha(0)
	fill:setImage(RegisterImage(0xB11522973E5A2F2))
	fill:setMaterial(LUI.UIImage.GetCachedMaterial(0xD5CA1A25ED87F4F))
	fill:setShaderVector(0, 0.52, 0, 0, 0)
	fill:setShaderVector(1, 0.5, 0, 0, 0)
	fill:setShaderVector(2, -2.84, 0, 0, 0)
	fill:setShaderVector(3, 0, 0, 0, 0)
	fill:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(fill)
	self.fill = fill
	local infinite = LUI.UIImage.new(0, 0, -16, 224, 0, 0, -8, 64)
	infinite:setRGB(0.3, 0.64, 1)
	infinite:setImage(RegisterImage(0x46C427DBED7301C))
	infinite:setMaterial(LUI.UIImage.GetCachedMaterial(0xD5CA1A25ED87F4F))
	infinite:setShaderVector(0, 0.52, 0, 0, 0)
	infinite:setShaderVector(1, 0.5, 0, 0, 0)
	infinite:setShaderVector(2, -2.84, 0, 0, 0)
	infinite:setShaderVector(3, 0, 0, 0, 0)
	infinite:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(infinite)
	self.infinite = infinite
	local blur = LUI.UIImage.new(0, 0, -16, 224, 0, 0, -8, 64)
	blur:setRGB(0.69, 0.91, 1)
	blur:setImage(RegisterImage(0xB1ADE2842467525))
	blur:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(blur)
	self.blur = blur
	local blur2 = LUI.UIImage.new(0, 0, -16, 224, 0, 0, -8, 64)
	blur2:setRGB(0.69, 0.91, 1)
	blur2:setAlpha(0)
	blur2:setImage(RegisterImage(0xB1ADE2842467525))
	blur2:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(blur2)
	self.blur2 = blur2
	local maxSprintBar = LUI.UIImage.new(0, 0, 0, 137, 0, 0, 22, 34)
	maxSprintBar:setAlpha(0)
	maxSprintBar:setZRot(180)
	maxSprintBar:setMaterial(LUI.UIImage.GetCachedMaterial(0x316E67E1DF2198E))
	maxSprintBar:setShaderVector(1, 0, 0, 0, 0)
	maxSprintBar:setShaderVector(2, 1, 0, 0, 0)
	maxSprintBar:setShaderVector(3, 0, 0, 0, 0)
	maxSprintBar:setShaderVector(4, 0, 0, 0, 0)
	maxSprintBar:subscribeToGlobalModel(f1_arg1, "PlayerAbilities", "playerSprintMaxSpeedRatio", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			maxSprintBar:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(maxSprintBar)
	self.maxSprintBar = maxSprintBar
	local sprintDecaryBar = LUI.UIImage.new(0, 0, 142, 212, 0, 0, 22, 34)
	sprintDecaryBar:setAlpha(0)
	sprintDecaryBar:setYRot(180)
	sprintDecaryBar:setImage(RegisterImage(0xA60C595B14D44BE))
	sprintDecaryBar:setMaterial(LUI.UIImage.GetCachedMaterial(0x316E67E1DF2198E))
	sprintDecaryBar:setShaderVector(1, -0.02, 0, 0, 0)
	sprintDecaryBar:setShaderVector(2, 1, 0, 0, 0)
	sprintDecaryBar:setShaderVector(3, 0.11, 0, 0, 0)
	sprintDecaryBar:setShaderVector(4, 0, 0, 0, 0)
	sprintDecaryBar:subscribeToGlobalModel(f1_arg1, "PlayerAbilities", "playerSprintDecaySpeedRatio", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			sprintDecaryBar:setShaderVector(0, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4))
		end
	end)
	self:addElement(sprintDecaryBar)
	self.sprintDecaryBar = sprintDecaryBar
	self:mergeStateConditions({
		{
			stateName = "SprintDecay",
			condition = function(menu, element, event)
				return IsUsingSprintDecay()
			end,
		},
		{
			stateName = "Infinite",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg1, "playerAbilities.playerSprintBoosting")
			end,
		},
	})
	local f1_local10 = self
	local f1_local11 = self.subscribeToModel
	local f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local11(f1_local10, f1_local12["playerAbilities.playerSprintBoosting"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "playerAbilities.playerSprintBoosting",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SprintMeterDots.__resetProperties = function(f7_arg0)
	f7_arg0.infinite:completeAnimation()
	f7_arg0.blur:completeAnimation()
	f7_arg0.fill:completeAnimation()
	f7_arg0.sprintDecaryBar:completeAnimation()
	f7_arg0.maxSprintBar:completeAnimation()
	f7_arg0.blur2:completeAnimation()
	f7_arg0.dots:completeAnimation()
	f7_arg0.maxSprintBarBacking:completeAnimation()
	f7_arg0.sprintDecaryBarBacking:completeAnimation()
	f7_arg0.infinite:setAlpha(1)
	f7_arg0.blur:setAlpha(1)
	f7_arg0.fill:setAlpha(0)
	f7_arg0.sprintDecaryBar:setAlpha(0)
	f7_arg0.maxSprintBar:setAlpha(0)
	f7_arg0.blur2:setAlpha(0)
	f7_arg0.dots:setAlpha(0)
	f7_arg0.maxSprintBarBacking:setAlpha(0)
	f7_arg0.sprintDecaryBarBacking:setAlpha(0)
end
CoD.SprintMeterDots.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			f8_arg0.fill:completeAnimation()
			f8_arg0.fill:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.fill)
			f8_arg0.infinite:completeAnimation()
			f8_arg0.infinite:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.infinite)
			f8_arg0.blur:completeAnimation()
			f8_arg0.blur:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.blur)
		end,
		IntroAnimation = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	SprintDecay = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(9)
			f10_arg0.maxSprintBarBacking:completeAnimation()
			f10_arg0.maxSprintBarBacking:setAlpha(0.5)
			f10_arg0.clipFinished(f10_arg0.maxSprintBarBacking)
			f10_arg0.sprintDecaryBarBacking:completeAnimation()
			f10_arg0.sprintDecaryBarBacking:setAlpha(0.5)
			f10_arg0.clipFinished(f10_arg0.sprintDecaryBarBacking)
			f10_arg0.dots:completeAnimation()
			f10_arg0.dots:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.dots)
			f10_arg0.fill:completeAnimation()
			f10_arg0.fill:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.fill)
			f10_arg0.infinite:completeAnimation()
			f10_arg0.infinite:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.infinite)
			f10_arg0.blur:completeAnimation()
			f10_arg0.blur:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.blur)
			f10_arg0.blur2:completeAnimation()
			f10_arg0.blur2:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.blur2)
			f10_arg0.maxSprintBar:completeAnimation()
			f10_arg0.maxSprintBar:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.maxSprintBar)
			f10_arg0.sprintDecaryBar:completeAnimation()
			f10_arg0.sprintDecaryBar:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.sprintDecaryBar)
		end,
	},
	Infinite = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			local f11_local0 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					local f13_local0 = function(f14_arg0)
						local f14_local0 = function(f15_arg0)
							local f15_local0 = function(f16_arg0)
								local f16_local0 = function(f17_arg0)
									f17_arg0:beginAnimation(539)
									f17_arg0:setAlpha(0)
									f17_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
								end
								f16_arg0:beginAnimation(370)
								f16_arg0:setAlpha(0.93)
								f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
							end
							f15_arg0:beginAnimation(159)
							f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
						end
						f14_arg0:beginAnimation(120)
						f14_arg0:setAlpha(1)
						f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
					end
					f13_arg0:beginAnimation(120)
					f13_arg0:setAlpha(0.43)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
				end
				f11_arg0.blur:beginAnimation(120)
				f11_arg0.blur:setAlpha(1)
				f11_arg0.blur:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.blur:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f11_arg0.blur:completeAnimation()
			f11_arg0.blur:setAlpha(0)
			f11_local0(f11_arg0.blur)
			local f11_local1 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					local f19_local0 = function(f20_arg0)
						local f20_local0 = function(f21_arg0)
							f21_arg0:beginAnimation(530)
							f21_arg0:setAlpha(0)
							f21_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
						end
						f20_arg0:beginAnimation(120)
						f20_arg0:setAlpha(0.95)
						f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
					end
					f19_arg0:beginAnimation(120)
					f19_arg0:setAlpha(0)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
				end
				f11_arg0.blur2:beginAnimation(120)
				f11_arg0.blur2:setAlpha(0.88)
				f11_arg0.blur2:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.blur2:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f11_arg0.blur2:completeAnimation()
			f11_arg0.blur2:setAlpha(0)
			f11_local1(f11_arg0.blur2)
			f11_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.SprintMeterDots.__onClose = function(f22_arg0)
	f22_arg0.maxSprintBar:close()
	f22_arg0.sprintDecaryBar:close()
end
