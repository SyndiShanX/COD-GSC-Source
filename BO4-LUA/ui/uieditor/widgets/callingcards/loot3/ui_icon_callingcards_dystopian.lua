require("x64:2f2a70c58600680")
CoD[@"hash_6720E7CB0E9CFA73"] = InheritFrom(LUI.UIElement)
CoD[@"hash_6720E7CB0E9CFA73"].__defaultWidth = 960
CoD[@"hash_6720E7CB0E9CFA73"].__defaultHeight = 240
CoD[@"hash_6720E7CB0E9CFA73"].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[@"hash_6720E7CB0E9CFA73"])
	self.id = "ui_icon_callingcards_dystopian"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local background = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	background:setImage(RegisterImage(@"uie_ui_icon_callingcards_dystopian_bg"))
	self:addElement(background)
	self.background = background
	local background2 = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	background2:setAlpha(0.55)
	background2:setImage(RegisterImage(@"uie_ui_icon_callingcards_dystopian_bgglow"))
	self:addElement(background2)
	self.background2 = background2
	local characer = CoD.ui_icon_callingcards_dystopian_character.new(f1_arg0, f1_arg1, 0, 0, 564, 836, 0, 0, -13.5, 247.5)
	self:addElement(characer)
	self.characer = characer
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[@"hash_6720E7CB0E9CFA73"].__resetProperties = function(f2_arg0)
	f2_arg0.characer:completeAnimation()
	f2_arg0.background2:completeAnimation()
	f2_arg0.characer:setLeftRight(0, 0, 564, 836)
	f2_arg0.characer:setTopBottom(0, 0, -13.5, 247.5)
	f2_arg0.characer:setAlpha(1)
	f2_arg0.characer:setZRot(0)
	f2_arg0.background2:setAlpha(0.55)
	f2_arg0.background2:setImage(RegisterImage(@"uie_ui_icon_callingcards_dystopian_bgglow"))
end
CoD[@"hash_6720E7CB0E9CFA73"].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							local f7_local0 = function(f8_arg0)
								f8_arg0:beginAnimation(349)
								f8_arg0:setAlpha(1)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
							end
							f7_arg0:beginAnimation(360)
							f7_arg0:setAlpha(0)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(719)
						f6_arg0:setAlpha(1)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(820)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.background2:beginAnimation(750)
				f3_arg0.background2:setAlpha(0)
				f3_arg0.background2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.background2:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.background2:completeAnimation()
			f3_arg0.background2:setAlpha(1)
			f3_arg0.background2:setImage(RegisterImage(@"uie_ui_icon_callingcards_dystopian_bgglow"))
			f3_local0(f3_arg0.background2)
			local f3_local1 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(1400, Enum[@"luitween"][@"luitween_ease_both"])
					f10_arg0:setLeftRight(0, 0, 608, 880)
					f10_arg0:setTopBottom(0, 0, 0, 261)
					f10_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("DefaultClip")
						f3_arg0.clipFinished(element, event)
					end)
				end
				f3_arg0.characer:playClip("DefaultClip")
				f3_arg0.characer:beginAnimation(1600, Enum[@"luitween"][@"luitween_back"] | Enum[@"luitween"][@"luitween_ease_both"])
				f3_arg0.characer:setLeftRight(0, 0, 549, 821)
				f3_arg0.characer:setTopBottom(0, 0, -6.5, 254.5)
				f3_arg0.characer:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.characer:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f3_arg0.characer:completeAnimation()
			f3_arg0.characer:setLeftRight(0, 0, 608, 880)
			f3_arg0.characer:setTopBottom(0, 0, 0, 261)
			f3_arg0.characer:setAlpha(1)
			f3_arg0.characer:setZRot(0)
			f3_local1(f3_arg0.characer)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD[@"hash_6720E7CB0E9CFA73"].__onClose = function(f12_arg0)
	f12_arg0.characer:close()
end
