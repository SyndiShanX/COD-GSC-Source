require("x64:a7644ae9dd32e52")
CoD.ui_icon_callingcards_assassin_attackergroup = InheritFrom(LUI.UIElement)
CoD.ui_icon_callingcards_assassin_attackergroup.__defaultWidth = 969
CoD.ui_icon_callingcards_assassin_attackergroup.__defaultHeight = 312
CoD.ui_icon_callingcards_assassin_attackergroup.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ui_icon_callingcards_assassin_attackergroup)
	self.id = "ui_icon_callingcards_assassin_attackergroup"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local attacker = LUI.UIImage.new(0, 0, 464.5, 968.5, 0, 0, 0, 312)
	attacker:setImage(RegisterImage(0x1F8A50A29EF677D))
	self:addElement(attacker)
	self.attacker = attacker
	local hand = CoD.ui_icon_callingcards_assassin_attackerarmgroup.new(f1_arg0, f1_arg1, 0, 0, 542.5, 552.5, 0, 0, 108, 118)
	hand:setZRot(-20)
	self:addElement(hand)
	self.hand = hand
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ui_icon_callingcards_assassin_attackergroup.__resetProperties = function(f2_arg0)
	f2_arg0.hand:completeAnimation()
	f2_arg0.hand:setZRot(-20)
end
CoD.ui_icon_callingcards_assassin_attackergroup.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:beginAnimation(1700)
						f6_arg0:setZRot(-25)
						f6_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
							element:playClip("DefaultClip")
							f3_arg0.clipFinished(element, event)
						end)
					end
					f5_arg0:beginAnimation(299)
					f5_arg0:setZRot(-18)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.hand:playClip("DefaultClip")
				f3_arg0.hand:beginAnimation(1000)
				f3_arg0.hand:setZRot(2)
				f3_arg0.hand:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.hand:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.hand:completeAnimation()
			f3_arg0.hand:setZRot(-18)
			f3_local0(f3_arg0.hand)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.ui_icon_callingcards_assassin_attackergroup.__onClose = function(f8_arg0)
	f8_arg0.hand:close()
end
