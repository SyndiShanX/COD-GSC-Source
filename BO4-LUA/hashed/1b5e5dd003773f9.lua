CoD.ReticleEnemyIndicatorInternal = InheritFrom(LUI.UIElement)
CoD.ReticleEnemyIndicatorInternal.__defaultWidth = 600
CoD.ReticleEnemyIndicatorInternal.__defaultHeight = 600
CoD.ReticleEnemyIndicatorInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReticleEnemyIndicatorInternal)
	self.id = "ReticleEnemyIndicatorInternal"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Triangle = LUI.UIImage.new(0.5, 0.5, -34, 34, 0, 0, 115, 159)
	Triangle:setAlpha(0.8)
	Triangle:setImage(RegisterImage(0x108B57FEAA671EF))
	Triangle:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	Triangle:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(Triangle)
	self.Triangle = Triangle
	self:mergeStateConditions({
		{
			stateName = "Left",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "angle", 90)
			end,
		},
		{
			stateName = "Right",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEitherValue(element, f1_arg1, "angle", -90, 270)
			end,
		},
	})
	self:linkToElementModel(self, "angle", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "angle",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ReticleEnemyIndicatorInternal.__resetProperties = function(f5_arg0)
	f5_arg0.Triangle:completeAnimation()
	f5_arg0.Triangle:setTopBottom(0, 0, 115, 159)
	f5_arg0.Triangle:setShaderVector(0, 1, 0, 0, 0)
end
CoD.ReticleEnemyIndicatorInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(500)
					f8_arg0:setShaderVector(0, 1, 0, 0, 0)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
				end
				f6_arg0.Triangle:beginAnimation(500)
				f6_arg0.Triangle:setShaderVector(0, 1.5, 0, 0, 0)
				f6_arg0.Triangle:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.Triangle:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f6_arg0.Triangle:completeAnimation()
			f6_arg0.Triangle:setTopBottom(0, 0, 115, 159)
			f6_arg0.Triangle:setShaderVector(0, 1, 0, 0, 0)
			f6_local0(f6_arg0.Triangle)
			f6_arg0.nextClip = "DefaultClip"
		end,
		Left = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					f11_arg0:beginAnimation(50)
					f11_arg0:setShaderVector(0, 1, 0, 0, 0)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
				end
				f9_arg0.Triangle:beginAnimation(100, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f9_arg0.Triangle:setTopBottom(0.05, 0.05, 0, 44)
				f9_arg0.Triangle:setShaderVector(0, 1.5, 0, 0, 0)
				f9_arg0.Triangle:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.Triangle:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f9_arg0.Triangle:completeAnimation()
			f9_arg0.Triangle:setTopBottom(0.05, 0.05, 70, 114)
			f9_arg0.Triangle:setShaderVector(0, 1, 0, 0, 0)
			f9_local0(f9_arg0.Triangle)
		end,
		Right = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			local f12_local0 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					f14_arg0:beginAnimation(50)
					f14_arg0:setShaderVector(0, 1, 0, 0, 0)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
				end
				f12_arg0.Triangle:beginAnimation(100, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f12_arg0.Triangle:setTopBottom(0.05, 0.05, 0, 44)
				f12_arg0.Triangle:setShaderVector(0, 1.5, 0, 0, 0)
				f12_arg0.Triangle:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.Triangle:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f12_arg0.Triangle:completeAnimation()
			f12_arg0.Triangle:setTopBottom(0.05, 0.05, 70, 114)
			f12_arg0.Triangle:setShaderVector(0, 1, 0, 0, 0)
			f12_local0(f12_arg0.Triangle)
		end,
	},
	Left = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			local f15_local0 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					f17_arg0:beginAnimation(500)
					f17_arg0:setShaderVector(0, 1, 0, 0, 0)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
				end
				f15_arg0.Triangle:beginAnimation(500)
				f15_arg0.Triangle:setShaderVector(0, 1.5, 0, 0, 0)
				f15_arg0.Triangle:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.Triangle:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f15_arg0.Triangle:completeAnimation()
			f15_arg0.Triangle:setTopBottom(0, 0, 31, 75)
			f15_arg0.Triangle:setShaderVector(0, 1, 0, 0, 0)
			f15_local0(f15_arg0.Triangle)
			f15_arg0.nextClip = "DefaultClip"
		end,
		DefaultState = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			local f18_local0 = function(f19_arg0)
				local f19_local0 = function(f20_arg0)
					f20_arg0:beginAnimation(50)
					f20_arg0:setShaderVector(0, 1, 0, 0, 0)
					f20_arg0:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
				end
				f18_arg0.Triangle:beginAnimation(100, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f18_arg0.Triangle:setTopBottom(0, 0, 115, 159)
				f18_arg0.Triangle:setShaderVector(0, 1.5, 0, 0, 0)
				f18_arg0.Triangle:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.Triangle:registerEventHandler("transition_complete_keyframe", f19_local0)
			end
			f18_arg0.Triangle:completeAnimation()
			f18_arg0.Triangle:setTopBottom(0, 0, 175, 219)
			f18_arg0.Triangle:setShaderVector(0, 1, 0, 0, 0)
			f18_local0(f18_arg0.Triangle)
		end,
	},
	Right = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			local f21_local0 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					f23_arg0:beginAnimation(500)
					f23_arg0:setShaderVector(0, 1, 0, 0, 0)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
				end
				f21_arg0.Triangle:beginAnimation(500)
				f21_arg0.Triangle:setShaderVector(0, 1.5, 0, 0, 0)
				f21_arg0.Triangle:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.Triangle:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f21_arg0.Triangle:completeAnimation()
			f21_arg0.Triangle:setTopBottom(0, 0, 31, 75)
			f21_arg0.Triangle:setShaderVector(0, 1, 0, 0, 0)
			f21_local0(f21_arg0.Triangle)
			f21_arg0.nextClip = "DefaultClip"
		end,
		DefaultState = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			local f24_local0 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					f26_arg0:beginAnimation(50)
					f26_arg0:setShaderVector(0, 1, 0, 0, 0)
					f26_arg0:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
				end
				f24_arg0.Triangle:beginAnimation(100, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f24_arg0.Triangle:setTopBottom(0, 0, 115, 159)
				f24_arg0.Triangle:setShaderVector(0, 1.5, 0, 0, 0)
				f24_arg0.Triangle:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.Triangle:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f24_arg0.Triangle:completeAnimation()
			f24_arg0.Triangle:setTopBottom(0, 0, 175, 219)
			f24_arg0.Triangle:setShaderVector(0, 1, 0, 0, 0)
			f24_local0(f24_arg0.Triangle)
		end,
	},
}
