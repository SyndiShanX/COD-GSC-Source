require("x64:8e1fa9bac20125e")
require("x64:8e1fb9bac201411")
require("x64:8e1fc9bac2015c4")
require("x64:8e1fd9bac201777")
CoD.ui_icon_callingcards_fairytales_wristgroup = InheritFrom(LUI.UIElement)
CoD.ui_icon_callingcards_fairytales_wristgroup.__defaultWidth = 10
CoD.ui_icon_callingcards_fairytales_wristgroup.__defaultHeight = 10
CoD.ui_icon_callingcards_fairytales_wristgroup.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ui_icon_callingcards_fairytales_wristgroup)
	self.id = "ui_icon_callingcards_fairytales_wristgroup"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local wrist = LUI.UIImage.new(0, 0, -91, 21, 0, 0, -43.5, 28.5)
	wrist:setImage(RegisterImage(@"uie_ui_icon_callingcards_fairytale_wrist"))
	self:addElement(wrist)
	self.wrist = wrist
	local finger2 = CoD.ui_icon_callingcards_fairytales_finger2.new(f1_arg0, f1_arg1, 0, 0, -81, -71, 0, 0, -36, -26)
	self:addElement(finger2)
	self.finger2 = finger2
	local finger3 = CoD.ui_icon_callingcards_fairytales_finger3.new(f1_arg0, f1_arg1, 0, 0, -73, -63, 0, 0, -17.5, -7.5)
	self:addElement(finger3)
	self.finger3 = finger3
	local finger4 = CoD.ui_icon_callingcards_fairytales_finger4.new(f1_arg0, f1_arg1, 0, 0, -61, -51, 0, 0, -5, 5)
	self:addElement(finger4)
	self.finger4 = finger4
	local finger5 = CoD.ui_icon_callingcards_fairytales_finger5.new(f1_arg0, f1_arg1, 0, 0, -51, -41, 0, 0, 11.5, 21.5)
	self:addElement(finger5)
	self.finger5 = finger5
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ui_icon_callingcards_fairytales_wristgroup.__resetProperties = function(f2_arg0)
	f2_arg0.finger3:completeAnimation()
	f2_arg0.finger4:completeAnimation()
	f2_arg0.finger5:completeAnimation()
	f2_arg0.finger2:completeAnimation()
	f2_arg0.finger3:setZRot(0)
	f2_arg0.finger4:setZRot(0)
	f2_arg0.finger5:setZRot(0)
	f2_arg0.finger2:setZRot(0)
end
CoD.ui_icon_callingcards_fairytales_wristgroup.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(4)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:beginAnimation(1100, Enum[@"luitween"][@"luitween_ease_out"])
						f6_arg0:setZRot(-20)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f5_arg0:beginAnimation(1200, Enum[@"luitween"][@"luitween_ease_out"])
					f5_arg0:setZRot(18)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f4_arg0:beginAnimation(690)
				f4_arg0:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.finger2:beginAnimation(10)
			f3_arg0.finger2:setZRot(-20)
			f3_arg0.finger2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.finger2:registerEventHandler("transition_complete_keyframe", f3_local0)
			local f3_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					local f8_local0 = function(f9_arg0)
						f9_arg0:beginAnimation(1400, Enum[@"luitween"][@"luitween_ease_out"])
						f9_arg0:setZRot(-30)
						f9_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f8_arg0:beginAnimation(1100, Enum[@"luitween"][@"luitween_ease_out"])
					f8_arg0:setZRot(15)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
				end
				f3_arg0.finger3:beginAnimation(500)
				f3_arg0.finger3:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.finger3:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f3_arg0.finger3:completeAnimation()
			f3_arg0.finger3:setZRot(-30)
			f3_local1(f3_arg0.finger3)
			local f3_local2 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					local f11_local0 = function(f12_arg0)
						f12_arg0:beginAnimation(1700, Enum[@"luitween"][@"luitween_ease_out"])
						f12_arg0:setZRot(-40)
						f12_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f11_arg0:beginAnimation(999, Enum[@"luitween"][@"luitween_ease_out"])
					f11_arg0:setZRot(14)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
				end
				f3_arg0.finger4:beginAnimation(300)
				f3_arg0.finger4:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.finger4:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f3_arg0.finger4:completeAnimation()
			f3_arg0.finger4:setZRot(-40)
			f3_local2(f3_arg0.finger4)
			local f3_local3 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					local f14_local0 = function(f15_arg0)
						f15_arg0:beginAnimation(2000, Enum[@"luitween"][@"luitween_ease_out"])
						f15_arg0:setZRot(-40)
						f15_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f14_arg0:beginAnimation(900, Enum[@"luitween"][@"luitween_ease_out"])
					f14_arg0:setZRot(20)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
				end
				f3_arg0.finger5:beginAnimation(100)
				f3_arg0.finger5:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.finger5:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f3_arg0.finger5:completeAnimation()
			f3_arg0.finger5:setZRot(-40)
			f3_local3(f3_arg0.finger5)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.ui_icon_callingcards_fairytales_wristgroup.__onClose = function(f16_arg0)
	f16_arg0.finger2:close()
	f16_arg0.finger3:close()
	f16_arg0.finger4:close()
	f16_arg0.finger5:close()
end
