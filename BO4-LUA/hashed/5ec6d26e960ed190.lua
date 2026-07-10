CoD.WeaponBribeAcquiredCheck = InheritFrom(LUI.UIElement)
CoD.WeaponBribeAcquiredCheck.__defaultWidth = 64
CoD.WeaponBribeAcquiredCheck.__defaultHeight = 64
CoD.WeaponBribeAcquiredCheck.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponBribeAcquiredCheck)
	self.id = "WeaponBribeAcquiredCheck"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CheckBacking = LUI.UIImage.new(0, 0, 0, 64, 0, 0, 0, 64)
	CheckBacking:setRGB(0.16, 0.65, 0.07)
	CheckBacking:setAlpha(0.8)
	CheckBacking:setImage(RegisterImage(0xB8A6E9D12CAE19))
	self:addElement(CheckBacking)
	self.CheckBacking = CheckBacking
	local CheckMark = LUI.UIImage.new(0, 0, 0, 64, 0, 0, 0, 64)
	CheckMark:setRGB(0.08, 0.65, 0)
	CheckMark:setImage(RegisterImage(0x661A673636FB8C3))
	self:addElement(CheckMark)
	self.CheckMark = CheckMark
	local CheckGlow = LUI.UIImage.new(0, 0, 0, 64, 0, 0, 0, 64)
	CheckGlow:setRGB(0, 1, 0.02)
	CheckGlow:setImage(RegisterImage(0x13FA817ECDA23A5))
	CheckGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(CheckGlow)
	self.CheckGlow = CheckGlow
	self:mergeStateConditions({
		{
			stateName = "UnOwned",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "purchased")
			end,
		},
	})
	self:linkToElementModel(self, "purchased", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "purchased",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponBribeAcquiredCheck.__resetProperties = function(f4_arg0)
	f4_arg0.CheckGlow:completeAnimation()
	f4_arg0.CheckMark:completeAnimation()
	f4_arg0.CheckBacking:completeAnimation()
	f4_arg0.CheckGlow:setAlpha(1)
	f4_arg0.CheckMark:setAlpha(1)
	f4_arg0.CheckBacking:setAlpha(0.8)
end
CoD.WeaponBribeAcquiredCheck.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(1520, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f7_arg0:setAlpha(0.3)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
				end
				f5_arg0.CheckGlow:beginAnimation(980, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f5_arg0.CheckGlow:setAlpha(0.8)
				f5_arg0.CheckGlow:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.CheckGlow:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f5_arg0.CheckGlow:completeAnimation()
			f5_arg0.CheckGlow:setAlpha(0.3)
			f5_local0(f5_arg0.CheckGlow)
			f5_arg0.nextClip = "DefaultClip"
		end,
	},
	UnOwned = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			f8_arg0.CheckBacking:completeAnimation()
			f8_arg0.CheckBacking:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.CheckBacking)
			f8_arg0.CheckMark:completeAnimation()
			f8_arg0.CheckMark:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.CheckMark)
			f8_arg0.CheckGlow:completeAnimation()
			f8_arg0.CheckGlow:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.CheckGlow)
			f8_arg0.nextClip = "DefaultClip"
		end,
	},
}
