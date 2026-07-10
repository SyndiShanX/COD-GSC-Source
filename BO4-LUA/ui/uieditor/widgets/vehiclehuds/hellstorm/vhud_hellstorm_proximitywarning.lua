CoD.vhud_hellstorm_ProximityWarning = InheritFrom(LUI.UIElement)
CoD.vhud_hellstorm_ProximityWarning.__defaultWidth = 342
CoD.vhud_hellstorm_ProximityWarning.__defaultHeight = 37
CoD.vhud_hellstorm_ProximityWarning.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_hellstorm_ProximityWarning)
	self.id = "vhud_hellstorm_ProximityWarning"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ApproachingTarget = LUI.UIText.new(-0.5, -0.5, 171, 513, -0.5, -0.5, 26, 48)
	ApproachingTarget:setRGB(1, 0.81, 0)
	ApproachingTarget:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_3E386BB4AB0520EC"))
	ApproachingTarget:setTTF("0arame_mono_stencil")
	ApproachingTarget:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ApproachingTarget:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(ApproachingTarget)
	self.ApproachingTarget = ApproachingTarget
	local TargetInRange = LUI.UIText.new(-0.5, -0.5, 171, 513, -0.5, -0.5, 26, 48)
	TargetInRange:setRGB(1, 0, 0)
	TargetInRange:setAlpha(0)
	TargetInRange:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_718CAFFCA49E94D"))
	TargetInRange:setTTF("0arame_mono_stencil")
	TargetInRange:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TargetInRange:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(TargetInRange)
	self.TargetInRange = TargetInRange
	self:linkToElementModel(self, "collisionWarning", true, function(model)
		if CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "collisionWarning", 1) then
		else
		end
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_hellstorm_ProximityWarning.__resetProperties = function(f3_arg0)
	f3_arg0.ApproachingTarget:completeAnimation()
	f3_arg0.TargetInRange:completeAnimation()
	f3_arg0.ApproachingTarget:setAlpha(1)
	f3_arg0.TargetInRange:setAlpha(0)
end
CoD.vhud_hellstorm_ProximityWarning.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.ApproachingTarget:completeAnimation()
			f4_arg0.ApproachingTarget:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.ApproachingTarget)
		end,
	},
	ApproachingTarget = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(300)
					f7_arg0:setAlpha(0)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
				end
				f5_arg0.ApproachingTarget:beginAnimation(300)
				f5_arg0.ApproachingTarget:setAlpha(1)
				f5_arg0.ApproachingTarget:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.ApproachingTarget:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f5_arg0.ApproachingTarget:completeAnimation()
			f5_arg0.ApproachingTarget:setAlpha(0)
			f5_local0(f5_arg0.ApproachingTarget)
			f5_arg0.nextClip = "DefaultClip"
		end,
	},
	TargetInRange = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.ApproachingTarget:completeAnimation()
			f8_arg0.ApproachingTarget:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.ApproachingTarget)
			local f8_local0 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(300)
					f10_arg0:setAlpha(0)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
				end
				f8_arg0.TargetInRange:beginAnimation(300)
				f8_arg0.TargetInRange:setAlpha(1)
				f8_arg0.TargetInRange:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.TargetInRange:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f8_arg0.TargetInRange:completeAnimation()
			f8_arg0.TargetInRange:setAlpha(0)
			f8_local0(f8_arg0.TargetInRange)
			f8_arg0.nextClip = "DefaultClip"
		end,
	},
}
