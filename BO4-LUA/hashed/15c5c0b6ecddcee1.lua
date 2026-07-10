CoD.AARTierRewardParticle = InheritFrom(LUI.UIElement)
CoD.AARTierRewardParticle.__defaultWidth = 391
CoD.AARTierRewardParticle.__defaultHeight = 630
CoD.AARTierRewardParticle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARTierRewardParticle)
	self.id = "AARTierRewardParticle"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Fx3 = LUI.UIImage.new(0, 0, 0, 391, 0, 0, 0, 630)
	Fx3:setAlpha(0)
	Fx3:setImage(RegisterImage(0x49BF12CB6D0F8F4))
	Fx3:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Fx3)
	self.Fx3 = Fx3
	local Fx3Loop = LUI.UIImage.new(0, 0, 0, 391, 0, 0, 0, 630)
	Fx3Loop:setAlpha(0.15)
	Fx3Loop:setScale(1.46, 1.46)
	Fx3Loop:setImage(RegisterImage(0x49BF12CB6D0F8F4))
	Fx3Loop:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Fx3Loop)
	self.Fx3Loop = Fx3Loop
	local Fx2 = LUI.UIImage.new(0, 0, 0, 391, 0, 0, 0, 630)
	Fx2:setAlpha(0)
	Fx2:setZRot(180)
	Fx2:setImage(RegisterImage(0x49BF22CB6D0FAA7))
	Fx2:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Fx2)
	self.Fx2 = Fx2
	local Fx = LUI.UIImage.new(0, 0, 0, 391, 0, 0, 0, 630)
	Fx:setAlpha(0)
	Fx:setImage(RegisterImage(0x20548CD7DC5A10F))
	Fx:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Fx)
	self.Fx = Fx
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARTierRewardParticle.__resetProperties = function(f2_arg0)
	f2_arg0.Fx3Loop:completeAnimation()
	f2_arg0.Fx:completeAnimation()
	f2_arg0.Fx2:completeAnimation()
	f2_arg0.Fx3:completeAnimation()
	f2_arg0.Fx3Loop:setAlpha(0.15)
	f2_arg0.Fx3Loop:setScale(1.46, 1.46)
	f2_arg0.Fx:setAlpha(0)
	f2_arg0.Fx:setScale(1, 1)
	f2_arg0.Fx2:setAlpha(0)
	f2_arg0.Fx2:setScale(1, 1)
	f2_arg0.Fx3:setAlpha(0)
	f2_arg0.Fx3:setScale(1, 1)
end
CoD.AARTierRewardParticle.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(4)
			local f3_local0 = function(f4_arg0)
				f4_arg0:beginAnimation(200)
				f4_arg0:setAlpha(1)
				f4_arg0:setScale(1.25, 1.25)
				f4_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.Fx3:beginAnimation(400)
			f3_arg0.Fx3:setAlpha(0)
			f3_arg0.Fx3:setScale(1, 1)
			f3_arg0.Fx3:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.Fx3:registerEventHandler("transition_complete_keyframe", f3_local0)
			local f3_local1 = function(f5_arg0)
				f3_arg0.Fx3Loop:beginAnimation(200)
				f3_arg0.Fx3Loop:setAlpha(0)
				f3_arg0.Fx3Loop:setScale(1.5, 1.5)
				f3_arg0.Fx3Loop:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Fx3Loop:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.Fx3Loop:completeAnimation()
			f3_arg0.Fx3Loop:setAlpha(1)
			f3_arg0.Fx3Loop:setScale(1.25, 1.25)
			f3_local1(f3_arg0.Fx3Loop)
			local f3_local2 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(200)
					f7_arg0:setAlpha(0)
					f7_arg0:setScale(1.5, 1.5)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f6_arg0:beginAnimation(200)
				f6_arg0:setAlpha(1)
				f6_arg0:setScale(1.25, 1.25)
				f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f3_arg0.Fx2:beginAnimation(200)
			f3_arg0.Fx2:setAlpha(0)
			f3_arg0.Fx2:setScale(1, 1)
			f3_arg0.Fx2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.Fx2:registerEventHandler("transition_complete_keyframe", f3_local2)
			local f3_local3 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					f9_arg0:beginAnimation(200)
					f9_arg0:setAlpha(0)
					f9_arg0:setScale(1.5, 1.5)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.Fx:beginAnimation(200)
				f3_arg0.Fx:setAlpha(1)
				f3_arg0.Fx:setScale(1.25, 1.25)
				f3_arg0.Fx:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Fx:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f3_arg0.Fx:completeAnimation()
			f3_arg0.Fx:setAlpha(0)
			f3_arg0.Fx:setScale(1, 1)
			f3_local3(f3_arg0.Fx)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
