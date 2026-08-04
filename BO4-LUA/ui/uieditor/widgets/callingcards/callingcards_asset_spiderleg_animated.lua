CoD.CallingCards_Asset_spiderleg_animated = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_spiderleg_animated.__defaultWidth = 560
CoD.CallingCards_Asset_spiderleg_animated.__defaultHeight = 240
CoD.CallingCards_Asset_spiderleg_animated.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_spiderleg_animated)
	self.id = "CallingCards_Asset_spiderleg_animated"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local spiderLeg = LUI.UIImage.new(0, 0, 0, 280, 0, 0, 0, 240)
	spiderLeg:setImage(RegisterImage("uie_ui_icon_callingcards_zm_survivalist_spiderleg"))
	self:addElement(spiderLeg)
	self.spiderLeg = spiderLeg
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_spiderleg_animated.__resetProperties = function(f2_arg0)
	f2_arg0.spiderLeg:completeAnimation()
	f2_arg0.spiderLeg:setLeftRight(0, 0, 0, 280)
	f2_arg0.spiderLeg:setTopBottom(0, 0, 0, 240)
	f2_arg0.spiderLeg:setZRot(0)
end
CoD.CallingCards_Asset_spiderleg_animated.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:beginAnimation(200)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f5_arg0:beginAnimation(299)
					f5_arg0:setLeftRight(0, 0, 32, 312)
					f5_arg0:setTopBottom(0, 0, 0, 240)
					f5_arg0:setZRot(0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.spiderLeg:beginAnimation(290)
				f3_arg0.spiderLeg:setLeftRight(0, 0, 45, 325)
				f3_arg0.spiderLeg:setTopBottom(0, 0, -36, 204)
				f3_arg0.spiderLeg:setZRot(-23)
				f3_arg0.spiderLeg:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.spiderLeg:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.spiderLeg:completeAnimation()
			f3_arg0.spiderLeg:setLeftRight(0, 0, 32, 312)
			f3_arg0.spiderLeg:setTopBottom(0, 0, 0, 240)
			f3_arg0.spiderLeg:setZRot(0)
			f3_local0(f3_arg0.spiderLeg)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
