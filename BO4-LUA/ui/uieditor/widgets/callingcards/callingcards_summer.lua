require("x64:61905ce88d4fbc5")
CoD[@"hash_7D8E26CF160AEA12"] = InheritFrom(LUI.UIElement)
CoD[@"hash_7D8E26CF160AEA12"].__defaultWidth = 960
CoD[@"hash_7D8E26CF160AEA12"].__defaultHeight = 240
CoD[@"hash_7D8E26CF160AEA12"].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[@"hash_7D8E26CF160AEA12"])
	self.id = "CallingCards_Summer"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local background = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	background:setImage(RegisterImage(@"uie_ui_icon_callingcards_summer_background"))
	self:addElement(background)
	self.background = background
	local ruin = LUI.UIImage.new(0, 0, 127, 767, 0, 0, 7, 327)
	ruin:setImage(RegisterImage(@"uie_ui_icon_callingcards_summer_ruin"))
	self:addElement(ruin)
	self.ruin = ruin
	local duck = LUI.UIImage.new(0, 0, 416, 480, 0, 0, 130, 226)
	duck:setImage(RegisterImage(@"uie_ui_icon_callingcards_summer_duck"))
	self:addElement(duck)
	self.duck = duck
	local legs = LUI.UIImage.new(0, 0, 87, 663, 0, 0, 53, 357)
	legs:setImage(RegisterImage(@"uie_ui_icon_callingcards_summer_legs"))
	self:addElement(legs)
	self.legs = legs
	local drink = LUI.UIImage.new(0, 0, 682, 986, 0, 0, 26, 330)
	drink:setImage(RegisterImage(@"uie_ui_icon_callingcards_summer_drink"))
	self:addElement(drink)
	self.drink = drink
	local lenseflare = CoD.CallingCards_Summer_lenseflare.new(f1_arg0, f1_arg1, 0, 0, 342, 352, 0, 0, 7, 17)
	self:addElement(lenseflare)
	self.lenseflare = lenseflare
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[@"hash_7D8E26CF160AEA12"].__resetProperties = function(f2_arg0)
	f2_arg0.ruin:completeAnimation()
	f2_arg0.duck:completeAnimation()
	f2_arg0.legs:completeAnimation()
	f2_arg0.drink:completeAnimation()
	f2_arg0.lenseflare:completeAnimation()
	f2_arg0.ruin:setLeftRight(0, 0, 127, 767)
	f2_arg0.ruin:setTopBottom(0, 0, 7, 327)
	f2_arg0.duck:setLeftRight(0, 0, 416, 480)
	f2_arg0.duck:setTopBottom(0, 0, 130, 226)
	f2_arg0.legs:setLeftRight(0, 0, 87, 663)
	f2_arg0.legs:setTopBottom(0, 0, 53, 357)
	f2_arg0.drink:setLeftRight(0, 0, 682, 986)
	f2_arg0.drink:setTopBottom(0, 0, 26, 330)
	f2_arg0.lenseflare:setLeftRight(0, 0, 342, 352)
	f2_arg0.lenseflare:setAlpha(1)
	f2_arg0.lenseflare:setZRot(0)
	f2_arg0.lenseflare:setScale(1, 1)
end
CoD[@"hash_7D8E26CF160AEA12"].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(5)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_out"])
					f5_arg0:setLeftRight(0, 0, 127, 767)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.ruin:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_in"])
				f3_arg0.ruin:setLeftRight(0, 0, 204, 844)
				f3_arg0.ruin:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.ruin:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.ruin:completeAnimation()
			f3_arg0.ruin:setLeftRight(0, 0, 127, 767)
			f3_arg0.ruin:setTopBottom(0, 0, 7, 327)
			f3_local0(f3_arg0.ruin)
			local f3_local1 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_out"])
					f7_arg0:setLeftRight(0, 0, 431, 495)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.duck:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_in"])
				f3_arg0.duck:setLeftRight(0, 0, 460, 524)
				f3_arg0.duck:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.duck:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f3_arg0.duck:completeAnimation()
			f3_arg0.duck:setLeftRight(0, 0, 431, 495)
			f3_arg0.duck:setTopBottom(0, 0, 130, 226)
			f3_local1(f3_arg0.duck)
			local f3_local2 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					f9_arg0:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_out"])
					f9_arg0:setLeftRight(0, 0, 87, 663)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.legs:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_in"])
				f3_arg0.legs:setLeftRight(0, 0, 134, 710)
				f3_arg0.legs:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.legs:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f3_arg0.legs:completeAnimation()
			f3_arg0.legs:setLeftRight(0, 0, 87, 663)
			f3_arg0.legs:setTopBottom(0, 0, 53, 357)
			f3_local2(f3_arg0.legs)
			local f3_local3 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					f11_arg0:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_out"])
					f11_arg0:setLeftRight(0, 0, 656, 960)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.drink:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_in"])
				f3_arg0.drink:setLeftRight(0, 0, 775, 1079)
				f3_arg0.drink:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.drink:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f3_arg0.drink:completeAnimation()
			f3_arg0.drink:setLeftRight(0, 0, 656, 960)
			f3_arg0.drink:setTopBottom(0, 0, 26, 330)
			f3_local3(f3_arg0.drink)
			local f3_local4 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					f13_arg0:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_out"])
					f13_arg0:setLeftRight(0, 0, 312, 322)
					f13_arg0:setAlpha(0.5)
					f13_arg0:setZRot(0)
					f13_arg0:setScale(1.2, 1.2)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.lenseflare:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_in"])
				f3_arg0.lenseflare:setLeftRight(0, 0, 329, 339)
				f3_arg0.lenseflare:setAlpha(0.7)
				f3_arg0.lenseflare:setZRot(-21)
				f3_arg0.lenseflare:setScale(0.95, 0.95)
				f3_arg0.lenseflare:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.lenseflare:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f3_arg0.lenseflare:completeAnimation()
			f3_arg0.lenseflare:setLeftRight(0, 0, 312, 322)
			f3_arg0.lenseflare:setAlpha(0.5)
			f3_arg0.lenseflare:setZRot(0)
			f3_arg0.lenseflare:setScale(1.2, 1.2)
			f3_local4(f3_arg0.lenseflare)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD[@"hash_7D8E26CF160AEA12"].__onClose = function(f14_arg0)
	f14_arg0.lenseflare:close()
end
