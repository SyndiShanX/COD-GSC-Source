require("x64:af3f0ec34713d92")
CoD.ui_icon_callingcards_assassin_attackerarmgroup = InheritFrom(LUI.UIElement)
CoD.ui_icon_callingcards_assassin_attackerarmgroup.__defaultWidth = 10
CoD.ui_icon_callingcards_assassin_attackerarmgroup.__defaultHeight = 10
CoD.ui_icon_callingcards_assassin_attackerarmgroup.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ui_icon_callingcards_assassin_attackerarmgroup)
	self.id = "ui_icon_callingcards_assassin_attackerarmgroup"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local arm = LUI.UIImage.new(0, 0, -330, 46, 0, 0, -47, 57)
	arm:setImage(RegisterImage(0xC3012BDC2E18E30))
	self:addElement(arm)
	self.arm = arm
	local hand = CoD.ui_icon_callingcards_assassin_attackerhand.new(f1_arg0, f1_arg1, 0, 0, -322.5, -312.5, 0, 0, 0, 10)
	hand:setZRot(14)
	self:addElement(hand)
	self.hand = hand
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ui_icon_callingcards_assassin_attackerarmgroup.__resetProperties = function(f2_arg0)
	f2_arg0.hand:completeAnimation()
	f2_arg0.hand:setZRot(14)
end
CoD.ui_icon_callingcards_assassin_attackerarmgroup.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(2000)
					f5_arg0:setZRot(35)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.hand:beginAnimation(1000)
				f3_arg0.hand:setZRot(58)
				f3_arg0.hand:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.hand:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.hand:completeAnimation()
			f3_arg0.hand:setZRot(35)
			f3_local0(f3_arg0.hand)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.ui_icon_callingcards_assassin_attackerarmgroup.__onClose = function(f6_arg0)
	f6_arg0.hand:close()
end
