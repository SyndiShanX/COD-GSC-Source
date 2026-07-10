require("x64:b6f9e612c26d159")
CoD.BMStackPips = InheritFrom(LUI.UIElement)
CoD.BMStackPips.__defaultWidth = 60
CoD.BMStackPips.__defaultHeight = 12
CoD.BMStackPips.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BMStackPips)
	self.id = "BMStackPips"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local pip1 = LUI.UIImage.new(0.5, 0.5, -24, -12, 0.5, 0.5, -6, 6)
	pip1:setRGB(1, 0.54, 0)
	pip1:setImage(RegisterImage(0x357069940064F75))
	self:addElement(pip1)
	self.pip1 = pip1
	local pip2 = LUI.UIImage.new(0.5, 0.5, -6, 6, 0.5, 0.5, -6, 6)
	pip2:setRGB(1, 0.54, 0)
	pip2:setAlpha(0.25)
	pip2:setImage(RegisterImage(0x357069940064F75))
	self:addElement(pip2)
	self.pip2 = pip2
	local pip3 = LUI.UIImage.new(0.5, 0.5, 12, 24, 0.5, 0.5, -6, 6)
	pip3:setRGB(1, 0.54, 0)
	pip3:setAlpha(0.25)
	pip3:setImage(RegisterImage(0x357069940064F75))
	self:addElement(pip3)
	self.pip3 = pip3
	local pip4 = LUI.UIImage.new(0.5, 0.5, 12, 24, 0.5, 0.5, -6, 6)
	pip4:setRGB(1, 0.54, 0)
	pip4:setAlpha(0)
	pip4:setImage(RegisterImage(0x357069940064F75))
	self:addElement(pip4)
	self.pip4 = pip4
	local CommonGlowFlickerAnim = CoD.CommonGlowFlickerAnim.new(f1_arg0, f1_arg1, 0.5, 0.5, -118, 82, 0.5, 0.5, -100, 100)
	CommonGlowFlickerAnim:setAlpha(0)
	CommonGlowFlickerAnim:setScale(0.2, 0.2)
	self:addElement(CommonGlowFlickerAnim)
	self.CommonGlowFlickerAnim = CommonGlowFlickerAnim
	local CommonGlowFlickerAnim2 = CoD.CommonGlowFlickerAnim.new(f1_arg0, f1_arg1, 0.5, 0.5, -118, 82, 0.5, 0.5, -100, 100)
	CommonGlowFlickerAnim2:setAlpha(0)
	CommonGlowFlickerAnim2:setScale(0.2, 0.2)
	self:addElement(CommonGlowFlickerAnim2)
	self.CommonGlowFlickerAnim2 = CommonGlowFlickerAnim2
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f2_local0 = IsBooleanDvarSet("loot_sunsetBlackjackShopActive")
				if f2_local0 then
					f2_local0 = IsMenuPropertyValue(menu, "_currentTab", "itemshop")
					if f2_local0 then
						f2_local0 = not CoD.ModelUtility.IsSelfModelValueNilOrTrue(element, f1_arg1, "emptyItem")
					end
				end
				return f2_local0
			end,
		},
	})
	self:linkToElementModel(self, "emptyItem", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "emptyItem",
		})
	end)
	self:linkToElementModel(self, "revealed", true, function(model)
		if CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "revealed") then
			PlayClip(self, "StackReveal", f1_arg1)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BMStackPips.__resetProperties = function(f5_arg0)
	f5_arg0.pip3:completeAnimation()
	f5_arg0.pip2:completeAnimation()
	f5_arg0.pip1:completeAnimation()
	f5_arg0.pip4:completeAnimation()
	f5_arg0.CommonGlowFlickerAnim:completeAnimation()
	f5_arg0.CommonGlowFlickerAnim2:completeAnimation()
	f5_arg0.pip3:setLeftRight(0.5, 0.5, 12, 24)
	f5_arg0.pip3:setAlpha(0.25)
	f5_arg0.pip2:setLeftRight(0.5, 0.5, -6, 6)
	f5_arg0.pip2:setTopBottom(0.5, 0.5, -6, 6)
	f5_arg0.pip2:setRGB(1, 0.54, 0)
	f5_arg0.pip2:setAlpha(0.25)
	f5_arg0.pip1:setLeftRight(0.5, 0.5, -24, -12)
	f5_arg0.pip1:setAlpha(1)
	f5_arg0.pip4:setLeftRight(0.5, 0.5, 12, 24)
	f5_arg0.pip4:setAlpha(0)
	f5_arg0.CommonGlowFlickerAnim:setAlpha(0)
	f5_arg0.CommonGlowFlickerAnim:setScale(0.2, 0.2)
	f5_arg0.CommonGlowFlickerAnim2:setAlpha(0)
	f5_arg0.CommonGlowFlickerAnim2:setScale(0.2, 0.2)
end
CoD.BMStackPips.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.pip1:completeAnimation()
			f6_arg0.pip1:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.pip1)
			f6_arg0.pip2:completeAnimation()
			f6_arg0.pip2:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.pip2)
			f6_arg0.pip3:completeAnimation()
			f6_arg0.pip3:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.pip3)
		end,
		Visible = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(3)
			local f7_local0 = function(f8_arg0)
				f7_arg0.pip1:beginAnimation(200)
				f7_arg0.pip1:setLeftRight(0.5, 0.5, -24, -12)
				f7_arg0.pip1:setAlpha(1)
				f7_arg0.pip1:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.pip1:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.pip1:completeAnimation()
			f7_arg0.pip1:setLeftRight(0.5, 0.5, -6, 6)
			f7_arg0.pip1:setAlpha(0)
			f7_local0(f7_arg0.pip1)
			local f7_local1 = function(f9_arg0)
				f7_arg0.pip2:beginAnimation(200)
				f7_arg0.pip2:setAlpha(0.25)
				f7_arg0.pip2:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.pip2:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.pip2:completeAnimation()
			f7_arg0.pip2:setAlpha(0)
			f7_local1(f7_arg0.pip2)
			local f7_local2 = function(f10_arg0)
				f7_arg0.pip3:beginAnimation(200)
				f7_arg0.pip3:setLeftRight(0.5, 0.5, 12, 24)
				f7_arg0.pip3:setAlpha(0.25)
				f7_arg0.pip3:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.pip3:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.pip3:completeAnimation()
			f7_arg0.pip3:setLeftRight(0.5, 0.5, -6, 6)
			f7_arg0.pip3:setAlpha(0)
			f7_local2(f7_arg0.pip3)
		end,
	},
	Visible = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.pip1:completeAnimation()
			f11_arg0.pip1:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.pip1)
			f11_arg0.pip2:completeAnimation()
			f11_arg0.pip2:setAlpha(0.25)
			f11_arg0.clipFinished(f11_arg0.pip2)
			f11_arg0.pip3:completeAnimation()
			f11_arg0.pip3:setAlpha(0.25)
			f11_arg0.clipFinished(f11_arg0.pip3)
		end,
		StackReveal = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(6)
			local f12_local0 = function(f13_arg0)
				f12_arg0.pip1:beginAnimation(200)
				f12_arg0.pip1:setLeftRight(0.5, 0.5, -42, -30)
				f12_arg0.pip1:setAlpha(0)
				f12_arg0.pip1:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.pip1:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.pip1:completeAnimation()
			f12_arg0.pip1:setLeftRight(0.5, 0.5, -24, -12)
			f12_arg0.pip1:setAlpha(1)
			f12_local0(f12_arg0.pip1)
			local f12_local1 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					local f15_local0 = function(f16_arg0)
						f16_arg0:beginAnimation(119)
						f16_arg0:setLeftRight(0.5, 0.5, -24, -12)
						f16_arg0:setTopBottom(0.5, 0.5, -6, 6)
						f16_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
					end
					f15_arg0:beginAnimation(100)
					f15_arg0:setLeftRight(0.5, 0.5, -21, -15)
					f15_arg0:setTopBottom(0.5, 0.5, -3, 3)
					f15_arg0:setAlpha(1)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
				end
				f12_arg0.pip2:beginAnimation(100)
				f12_arg0.pip2:setLeftRight(0.5, 0.5, -26.5, 8.5)
				f12_arg0.pip2:setTopBottom(0.5, 0.5, -17.5, 17.5)
				f12_arg0.pip2:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.pip2:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f12_arg0.pip2:completeAnimation()
			f12_arg0.pip2:setLeftRight(0.5, 0.5, -6, 6)
			f12_arg0.pip2:setTopBottom(0.5, 0.5, -6, 6)
			f12_arg0.pip2:setRGB(1, 0.54, 0)
			f12_arg0.pip2:setAlpha(0.25)
			f12_local1(f12_arg0.pip2)
			local f12_local2 = function(f17_arg0)
				f12_arg0.pip3:beginAnimation(200)
				f12_arg0.pip3:setLeftRight(0.5, 0.5, -6, 6)
				f12_arg0.pip3:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.pip3:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.pip3:completeAnimation()
			f12_arg0.pip3:setLeftRight(0.5, 0.5, 12, 24)
			f12_arg0.pip3:setAlpha(0.25)
			f12_local2(f12_arg0.pip3)
			local f12_local3 = function(f18_arg0)
				f12_arg0.pip4:beginAnimation(200)
				f12_arg0.pip4:setLeftRight(0.5, 0.5, 12, 24)
				f12_arg0.pip4:setAlpha(0.25)
				f12_arg0.pip4:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.pip4:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.pip4:completeAnimation()
			f12_arg0.pip4:setLeftRight(0.5, 0.5, 30, 42)
			f12_arg0.pip4:setAlpha(0)
			f12_local3(f12_arg0.pip4)
			local f12_local4 = function(f19_arg0)
				local f19_local0 = function(f20_arg0)
					local f20_local0 = function(f21_arg0)
						f21_arg0:beginAnimation(349)
						f21_arg0:setAlpha(0)
						f21_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
					end
					f20_arg0:beginAnimation(10)
					f20_arg0:setAlpha(1)
					f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
				end
				f12_arg0.CommonGlowFlickerAnim:beginAnimation(220)
				f12_arg0.CommonGlowFlickerAnim:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.CommonGlowFlickerAnim:registerEventHandler("transition_complete_keyframe", f19_local0)
			end
			f12_arg0.CommonGlowFlickerAnim:completeAnimation()
			f12_arg0.CommonGlowFlickerAnim:setAlpha(0)
			f12_arg0.CommonGlowFlickerAnim:setScale(0.05, 0.05)
			f12_local4(f12_arg0.CommonGlowFlickerAnim)
			local f12_local5 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					local f23_local0 = function(f24_arg0)
						f24_arg0:beginAnimation(240)
						f24_arg0:setAlpha(0)
						f24_arg0:setScale(0.2, 0.2)
						f24_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
					end
					f23_arg0:beginAnimation(10)
					f23_arg0:setAlpha(1)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
				end
				f12_arg0.CommonGlowFlickerAnim2:beginAnimation(190)
				f12_arg0.CommonGlowFlickerAnim2:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.CommonGlowFlickerAnim2:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f12_arg0.CommonGlowFlickerAnim2:completeAnimation()
			f12_arg0.CommonGlowFlickerAnim2:setAlpha(0)
			f12_arg0.CommonGlowFlickerAnim2:setScale(0.05, 0.05)
			f12_local5(f12_arg0.CommonGlowFlickerAnim2)
		end,
	},
}
CoD.BMStackPips.__onClose = function(f25_arg0)
	f25_arg0.CommonGlowFlickerAnim:close()
	f25_arg0.CommonGlowFlickerAnim2:close()
end
