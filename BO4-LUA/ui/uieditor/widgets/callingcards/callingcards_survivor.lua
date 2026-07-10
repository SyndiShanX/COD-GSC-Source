CoD[@"hash_B68C32A1ECE956D"] = InheritFrom(LUI.UIElement)
CoD[@"hash_B68C32A1ECE956D"].__defaultWidth = 960
CoD[@"hash_B68C32A1ECE956D"].__defaultHeight = 240
CoD[@"hash_B68C32A1ECE956D"].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[@"hash_B68C32A1ECE956D"])
	self.id = "CallingCards_survivor"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	Background:setImage(RegisterImage(@"hash_2A2FD1F0875C7195"))
	self:addElement(Background)
	self.Background = Background
	local boat1 = LUI.UIImage.new(0, 0, 101.5, 349.5, 0, 0, 48, 240)
	boat1:setImage(RegisterImage(@"hash_6D45AD6C3F292AF3"))
	self:addElement(boat1)
	self.boat1 = boat1
	local boat2 = LUI.UIImage.new(0, 0, 842.5, 890.5, 0, 0, 96, 144)
	boat2:setImage(RegisterImage(@"hash_6D45AE6C3F292CA6"))
	self:addElement(boat2)
	self.boat2 = boat2
	local boy = LUI.UIImage.new(0, 0, 11.5, 515.5, 0, 0, 0, 240)
	boy:setImage(RegisterImage(@"hash_BCEA7B6022C5BBC"))
	self:addElement(boy)
	self.boy = boy
	local girl = LUI.UIImage.new(0, 0, 501, 781, 0, 0, 0, 240)
	girl:setImage(RegisterImage(@"hash_C2F806EEA645E44"))
	self:addElement(girl)
	self.girl = girl
	local pole = LUI.UIImage.new(0, 0, 633.5, 857.5, 0, 0, -121.5, 230.5)
	pole:setImage(RegisterImage(@"hash_6A4D82D334289820"))
	self:addElement(pole)
	self.pole = pole
	local arm = LUI.UIImage.new(0, 0, 757, 901, 0, 0, -97.5, 206.5)
	arm:setImage(RegisterImage(@"hash_28620EB61317D384"))
	self:addElement(arm)
	self.arm = arm
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[@"hash_B68C32A1ECE956D"].__resetProperties = function(f2_arg0)
	f2_arg0.boat1:completeAnimation()
	f2_arg0.boat2:completeAnimation()
	f2_arg0.boy:completeAnimation()
	f2_arg0.girl:completeAnimation()
	f2_arg0.pole:completeAnimation()
	f2_arg0.arm:completeAnimation()
	f2_arg0.boat1:setLeftRight(0, 0, 101.5, 349.5)
	f2_arg0.boat2:setLeftRight(0, 0, 842.5, 890.5)
	f2_arg0.boy:setLeftRight(0, 0, 11.5, 515.5)
	f2_arg0.girl:setLeftRight(0, 0, 501, 781)
	f2_arg0.pole:setLeftRight(0, 0, 633.5, 857.5)
	f2_arg0.pole:setZRot(0)
	f2_arg0.arm:setLeftRight(0, 0, 757, 901)
	f2_arg0.arm:setZRot(0)
end
CoD[@"hash_B68C32A1ECE956D"].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(6)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_out"])
					f5_arg0:setLeftRight(0, 0, 101.5, 349.5)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.boat1:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_out"])
				f3_arg0.boat1:setLeftRight(0, 0, 147.5, 395.5)
				f3_arg0.boat1:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.boat1:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.boat1:completeAnimation()
			f3_arg0.boat1:setLeftRight(0, 0, 101.5, 349.5)
			f3_local0(f3_arg0.boat1)
			local f3_local1 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_out"])
					f7_arg0:setLeftRight(0, 0, 793.5, 841.5)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.boat2:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_out"])
				f3_arg0.boat2:setLeftRight(0, 0, 770.5, 818.5)
				f3_arg0.boat2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.boat2:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f3_arg0.boat2:completeAnimation()
			f3_arg0.boat2:setLeftRight(0, 0, 793.5, 841.5)
			f3_local1(f3_arg0.boat2)
			local f3_local2 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					local f9_local0 = function(f10_arg0)
						f10_arg0:beginAnimation(2300, Enum[@"luitween"][@"luitween_ease_out"])
						f10_arg0:setLeftRight(0, 0, 11.5, 515.5)
						f10_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f9_arg0:beginAnimation(490, Enum[@"luitween"][@"luitween_ease_in"])
					f9_arg0:setLeftRight(0, 0, -38.5, 465.5)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
				end
				f3_arg0.boy:beginAnimation(210, Enum[@"luitween"][@"luitween_ease_out"])
				f3_arg0.boy:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.boy:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f3_arg0.boy:completeAnimation()
			f3_arg0.boy:setLeftRight(0, 0, 11.5, 515.5)
			f3_local2(f3_arg0.boy)
			local f3_local3 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					f12_arg0:beginAnimation(2700)
					f12_arg0:setLeftRight(0, 0, 501, 781)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.girl:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_out"])
				f3_arg0.girl:setLeftRight(0, 0, 454, 734)
				f3_arg0.girl:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.girl:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f3_arg0.girl:completeAnimation()
			f3_arg0.girl:setLeftRight(0, 0, 501, 781)
			f3_local3(f3_arg0.girl)
			local f3_local4 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					local f14_local0 = function(f15_arg0)
						f15_arg0:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_out"])
						f15_arg0:setZRot(0)
						f15_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f14_arg0:beginAnimation(1000)
					f14_arg0:setZRot(-11)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
				end
				f3_arg0.pole:beginAnimation(500, Enum[@"luitween"][@"luitween_ease_out"])
				f3_arg0.pole:setZRot(-19)
				f3_arg0.pole:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.pole:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f3_arg0.pole:completeAnimation()
			f3_arg0.pole:setLeftRight(0, 0, 633.5, 857.5)
			f3_arg0.pole:setZRot(0)
			f3_local4(f3_arg0.pole)
			local f3_local5 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					f17_arg0:beginAnimation(2300, Enum[@"luitween"][@"luitween_ease_out"])
					f17_arg0:setZRot(0)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.arm:beginAnimation(700, Enum[@"luitween"][@"luitween_ease_out"])
				f3_arg0.arm:setZRot(47)
				f3_arg0.arm:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.arm:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f3_arg0.arm:completeAnimation()
			f3_arg0.arm:setLeftRight(0, 0, 757, 901)
			f3_arg0.arm:setZRot(0)
			f3_local5(f3_arg0.arm)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
