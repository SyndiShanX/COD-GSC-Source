require("ui/uieditor/widgets/callingcards/callingcards_replacer_cars1")
require("ui/uieditor/widgets/callingcards/callingcards_replacer_cars2")
require("ui/uieditor/widgets/callingcards/callingcards_replacer_scooter")
CoD.callingcards_replacer = InheritFrom(LUI.UIElement)
CoD.callingcards_replacer.__defaultWidth = 960
CoD.callingcards_replacer.__defaultHeight = 240
CoD.callingcards_replacer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_replacer)
	self.id = "CallingCards_replacer"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local background = LUI.UIImage.new(0, 0, -3030, 1010, 0, 0, 0, 240)
	background:setAlpha(0.2)
	background:setImage(RegisterImage(@"hash_22120E883A5574C0"))
	self:addElement(background)
	self.background = background
	local cars3 = CoD.CallingCards_replacer_cars1.new(f1_arg0, f1_arg1, 0, 0, 0, 4416, 0, 0, 39, 335)
	cars3:setAlpha(0)
	self:addElement(cars3)
	self.cars3 = cars3
	local cars1 = CoD.CallingCards_replacer_cars1.new(f1_arg0, f1_arg1, 0, 0, 90, 4506, 0, 0, 39, 335)
	self:addElement(cars1)
	self.cars1 = cars1
	local cars2 = CoD.CallingCards_replacer_cars2.new(f1_arg0, f1_arg1, 0, 0, 960, 6752, 0, 0, 0, 384)
	self:addElement(cars2)
	self.cars2 = cars2
	local scooter = CoD.CallingCards_replacer_scooter.new(f1_arg0, f1_arg1, 0, 0, 408, 904, 0, 0, 0, 240)
	self:addElement(scooter)
	self.scooter = scooter
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.callingcards_replacer.__resetProperties = function(f2_arg0)
	f2_arg0.background:completeAnimation()
	f2_arg0.cars1:completeAnimation()
	f2_arg0.cars2:completeAnimation()
	f2_arg0.cars3:completeAnimation()
	f2_arg0.scooter:completeAnimation()
	f2_arg0.background:setLeftRight(0, 0, -3030, 1010)
	f2_arg0.background:setTopBottom(0, 0, 0, 240)
	f2_arg0.background:setAlpha(0.2)
	f2_arg0.cars1:setAlpha(1)
	f2_arg0.cars2:setLeftRight(0, 0, 960, 6752)
	f2_arg0.cars3:setAlpha(0)
	f2_arg0.scooter:setLeftRight(0, 0, 408, 904)
end
CoD.callingcards_replacer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(5)
			local f3_local0 = function(f4_arg0)
				f3_arg0.background:beginAnimation(5990)
				f3_arg0.background:setLeftRight(0, 0, -525, 3515)
				f3_arg0.background:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.background:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.background:completeAnimation()
			f3_arg0.background:setLeftRight(0, 0, -3030, 1010)
			f3_arg0.background:setTopBottom(0, 0, 0, 240)
			f3_arg0.background:setAlpha(1)
			f3_local0(f3_arg0.background)
			local f3_local1 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					f6_arg0:beginAnimation(9)
					f6_arg0:setAlpha(1)
					f6_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("DefaultClip")
						f3_arg0.clipFinished(element, event)
					end)
				end
				f3_arg0.cars3:beginAnimation(2990)
				f3_arg0.cars3:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.cars3:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f3_arg0.cars3:completeAnimation()
			f3_arg0.cars3:setAlpha(0)
			f3_local1(f3_arg0.cars3)
			local f3_local2 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					local f9_local0 = function(f10_arg0)
						f10_arg0:beginAnimation(2990)
						f10_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
							element:playClip("DefaultClip")
							f3_arg0.clipFinished(element, event)
						end)
					end
					f9_arg0:beginAnimation(9)
					f9_arg0:setAlpha(0)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
				end
				f3_arg0.cars1:playClip("DefaultClip")
				f3_arg0.cars1:beginAnimation(3000)
				f3_arg0.cars1:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.cars1:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f3_arg0.cars1:completeAnimation()
			f3_arg0.cars1:setAlpha(1)
			f3_local2(f3_arg0.cars1)
			f3_arg0.cars2:completeAnimation()
			f3_arg0.cars2:setLeftRight(0, 0, 0, 5792)
			f3_arg0.cars2:playClip("DefaultClip")
			f3_arg0.clipFinished(f3_arg0.cars2)
			local f3_local3 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					local f13_local0 = function(f14_arg0)
						local f14_local0 = function(f15_arg0)
							local f15_local0 = function(f16_arg0)
								local f16_local0 = function(f17_arg0)
									f17_arg0:beginAnimation(1349, Enum[@"luitween"][@"luitween_ease_in"])
									f17_arg0:setLeftRight(0, 0, 408, 904)
									f17_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
										element:playClip("DefaultClip")
										f3_arg0.clipFinished(element, event)
									end)
								end
								f16_arg0:beginAnimation(440, Enum[@"luitween"][@"luitween_ease_out"])
								f16_arg0:setLeftRight(0, 0, 251, 747)
								f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
							end
							f15_arg0:beginAnimation(610, Enum[@"luitween"][@"luitween_ease_out"])
							f15_arg0:setLeftRight(0, 0, 375, 871)
							f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
						end
						f14_arg0:beginAnimation(1099, Enum[@"luitween"][@"luitween_ease_out"])
						f14_arg0:setLeftRight(0, 0, 90, 586)
						f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
					end
					f13_arg0:beginAnimation(730, Enum[@"luitween"][@"luitween_ease_out"])
					f13_arg0:setLeftRight(0, 0, 174, 670)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
				end
				f3_arg0.scooter:playClip("DefaultClip")
				f3_arg0.scooter:beginAnimation(1770, Enum[@"luitween"][@"luitween_ease_out"])
				f3_arg0.scooter:setLeftRight(0, 0, 90, 586)
				f3_arg0.scooter:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.scooter:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f3_arg0.scooter:completeAnimation()
			f3_arg0.scooter:setLeftRight(0, 0, 408, 904)
			f3_local3(f3_arg0.scooter)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.callingcards_replacer.__onClose = function(f19_arg0)
	f19_arg0.cars3:close()
	f19_arg0.cars1:close()
	f19_arg0.cars2:close()
	f19_arg0.scooter:close()
end
