CoD.ArmorPortraitZM = InheritFrom(LUI.UIElement)
CoD.ArmorPortraitZM.__defaultWidth = 50
CoD.ArmorPortraitZM.__defaultHeight = 50
CoD.ArmorPortraitZM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArmorPortraitZM)
	self.id = "ArmorPortraitZM"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local armor = LUI.UIImage.new(-0.07, 1.07, 0, 0, -0.07, 1.07, 0, 0)
	armor:setAlpha(0)
	armor:setImage(RegisterImage(0x66921D2569FBAE6))
	self:addElement(armor)
	self.armor = armor
	local armordamage1 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	armordamage1:setAlpha(0)
	armordamage1:setImage(RegisterImage(0xF27C140343E5BBF))
	self:addElement(armordamage1)
	self.armordamage1 = armordamage1
	local armordamage2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	armordamage2:setAlpha(0)
	armordamage2:setImage(RegisterImage(0xF27C240343E5D72))
	self:addElement(armordamage2)
	self.armordamage2 = armordamage2
	local armordamage3 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	armordamage3:setAlpha(0)
	armordamage3:setImage(RegisterImage(0xF27C340343E5F25))
	self:addElement(armordamage3)
	self.armordamage3 = armordamage3
	local armordamage4 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	armordamage4:setAlpha(0)
	armordamage4:setImage(RegisterImage(0xF27BC40343E5340))
	self:addElement(armordamage4)
	self.armordamage4 = armordamage4
	self:mergeStateConditions({
		{
			stateName = "ArmorFull",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(self, f1_arg1, "armor", 0)
			end,
		},
		{
			stateName = "ArmorHigh",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "ArmorMid",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "ArmorLow",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	self:linkToElementModel(self, "armor", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "armor",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArmorPortraitZM.__resetProperties = function(f7_arg0)
	f7_arg0.armor:completeAnimation()
	f7_arg0.armordamage1:completeAnimation()
	f7_arg0.armordamage2:completeAnimation()
	f7_arg0.armordamage3:completeAnimation()
	f7_arg0.armordamage4:completeAnimation()
	f7_arg0.armor:setAlpha(0)
	f7_arg0.armordamage1:setRGB(1, 1, 1)
	f7_arg0.armordamage1:setAlpha(0)
	f7_arg0.armordamage2:setRGB(1, 1, 1)
	f7_arg0.armordamage2:setAlpha(0)
	f7_arg0.armordamage3:setRGB(1, 1, 1)
	f7_arg0.armordamage3:setAlpha(0)
	f7_arg0.armordamage4:setAlpha(0)
end
CoD.ArmorPortraitZM.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	ArmorFull = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.armor:completeAnimation()
			f9_arg0.armor:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.armor)
		end,
		ArmorHigh = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					f12_arg0:beginAnimation(100)
					f12_arg0:setRGB(1, 1, 1)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
				end
				f10_arg0.armordamage1:beginAnimation(100)
				f10_arg0.armordamage1:setRGB(1, 0, 0)
				f10_arg0.armordamage1:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.armordamage1:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f10_arg0.armordamage1:completeAnimation()
			f10_arg0.armordamage1:setRGB(1, 1, 1)
			f10_arg0.armordamage1:setAlpha(1)
			f10_local0(f10_arg0.armordamage1)
		end,
		ArmorMid = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			local f13_local0 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					f15_arg0:beginAnimation(100)
					f15_arg0:setRGB(1, 1, 1)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
				end
				f13_arg0.armordamage2:beginAnimation(100)
				f13_arg0.armordamage2:setRGB(1, 0, 0)
				f13_arg0.armordamage2:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.armordamage2:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f13_arg0.armordamage2:completeAnimation()
			f13_arg0.armordamage2:setRGB(1, 1, 1)
			f13_arg0.armordamage2:setAlpha(1)
			f13_local0(f13_arg0.armordamage2)
		end,
		ArmorLow = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			local f16_local0 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					f18_arg0:beginAnimation(100)
					f18_arg0:setRGB(1, 1, 1)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
				end
				f16_arg0.armordamage3:beginAnimation(100)
				f16_arg0.armordamage3:setRGB(1, 0, 0)
				f16_arg0.armordamage3:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.armordamage3:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f16_arg0.armordamage3:completeAnimation()
			f16_arg0.armordamage3:setRGB(1, 1, 1)
			f16_arg0.armordamage3:setAlpha(1)
			f16_local0(f16_arg0.armordamage3)
		end,
		DefaultState = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			local f19_local0 = function(f20_arg0)
				f19_arg0.armor:beginAnimation(330)
				f19_arg0.armor:setAlpha(0)
				f19_arg0.armor:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.armor:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.armor:completeAnimation()
			f19_arg0.armor:setAlpha(1)
			f19_local0(f19_arg0.armor)
		end,
	},
	ArmorHigh = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.armordamage1:completeAnimation()
			f21_arg0.armordamage1:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.armordamage1)
		end,
		ArmorMid = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			local f22_local0 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					f24_arg0:beginAnimation(100)
					f24_arg0:setRGB(1, 1, 1)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
				end
				f22_arg0.armordamage2:beginAnimation(100)
				f22_arg0.armordamage2:setRGB(1, 0, 0)
				f22_arg0.armordamage2:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.armordamage2:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f22_arg0.armordamage2:completeAnimation()
			f22_arg0.armordamage2:setRGB(1, 1, 1)
			f22_arg0.armordamage2:setAlpha(1)
			f22_local0(f22_arg0.armordamage2)
		end,
		ArmorLow = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			local f25_local0 = function(f26_arg0)
				local f26_local0 = function(f27_arg0)
					f27_arg0:beginAnimation(100)
					f27_arg0:setRGB(1, 1, 1)
					f27_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
				end
				f25_arg0.armordamage3:beginAnimation(100)
				f25_arg0.armordamage3:setRGB(1, 0, 0)
				f25_arg0.armordamage3:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.armordamage3:registerEventHandler("transition_complete_keyframe", f26_local0)
			end
			f25_arg0.armordamage3:completeAnimation()
			f25_arg0.armordamage3:setRGB(1, 1, 1)
			f25_arg0.armordamage3:setAlpha(1)
			f25_local0(f25_arg0.armordamage3)
		end,
		DefaultState = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(1)
			local f28_local0 = function(f29_arg0)
				f28_arg0.armordamage4:beginAnimation(200)
				f28_arg0.armordamage4:setAlpha(0)
				f28_arg0.armordamage4:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.armordamage4:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.armordamage4:completeAnimation()
			f28_arg0.armordamage4:setAlpha(1)
			f28_local0(f28_arg0.armordamage4)
		end,
	},
	ArmorMid = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(1)
			f30_arg0.armordamage2:completeAnimation()
			f30_arg0.armordamage2:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.armordamage2)
		end,
		ArmorLow = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(1)
			local f31_local0 = function(f32_arg0)
				local f32_local0 = function(f33_arg0)
					f33_arg0:beginAnimation(100)
					f33_arg0:setRGB(1, 1, 1)
					f33_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
				end
				f31_arg0.armordamage3:beginAnimation(100)
				f31_arg0.armordamage3:setRGB(1, 0, 0)
				f31_arg0.armordamage3:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.armordamage3:registerEventHandler("transition_complete_keyframe", f32_local0)
			end
			f31_arg0.armordamage3:completeAnimation()
			f31_arg0.armordamage3:setRGB(1, 1, 1)
			f31_arg0.armordamage3:setAlpha(1)
			f31_local0(f31_arg0.armordamage3)
		end,
		DefaultState = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(1)
			local f34_local0 = function(f35_arg0)
				f34_arg0.armordamage4:beginAnimation(200)
				f34_arg0.armordamage4:setAlpha(0)
				f34_arg0.armordamage4:registerEventHandler("interrupted_keyframe", f34_arg0.clipInterrupted)
				f34_arg0.armordamage4:registerEventHandler("transition_complete_keyframe", f34_arg0.clipFinished)
			end
			f34_arg0.armordamage4:completeAnimation()
			f34_arg0.armordamage4:setAlpha(1)
			f34_local0(f34_arg0.armordamage4)
		end,
	},
	ArmorLow = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(1)
			f36_arg0.armordamage3:completeAnimation()
			f36_arg0.armordamage3:setAlpha(1)
			f36_arg0.clipFinished(f36_arg0.armordamage3)
		end,
		ArmorLow = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(1)
			local f37_local0 = function(f38_arg0)
				local f38_local0 = function(f39_arg0)
					f39_arg0:beginAnimation(100)
					f39_arg0:setRGB(1, 1, 1)
					f39_arg0:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
				end
				f37_arg0.armordamage3:beginAnimation(100)
				f37_arg0.armordamage3:setRGB(1, 0, 0)
				f37_arg0.armordamage3:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.armordamage3:registerEventHandler("transition_complete_keyframe", f38_local0)
			end
			f37_arg0.armordamage3:completeAnimation()
			f37_arg0.armordamage3:setRGB(1, 1, 1)
			f37_arg0.armordamage3:setAlpha(1)
			f37_local0(f37_arg0.armordamage3)
		end,
		DefaultState = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(1)
			local f40_local0 = function(f41_arg0)
				f40_arg0.armordamage4:beginAnimation(200)
				f40_arg0.armordamage4:setAlpha(0)
				f40_arg0.armordamage4:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
				f40_arg0.armordamage4:registerEventHandler("transition_complete_keyframe", f40_arg0.clipFinished)
			end
			f40_arg0.armordamage4:completeAnimation()
			f40_arg0.armordamage4:setAlpha(1)
			f40_local0(f40_arg0.armordamage4)
		end,
	},
}
