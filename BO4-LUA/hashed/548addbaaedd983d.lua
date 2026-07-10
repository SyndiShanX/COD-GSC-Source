require("x64:24cdc10be6c29c3")
CoD.PositionDraft_CountdownTimerFUI = InheritFrom(LUI.UIElement)
CoD.PositionDraft_CountdownTimerFUI.__defaultWidth = 800
CoD.PositionDraft_CountdownTimerFUI.__defaultHeight = 320
CoD.PositionDraft_CountdownTimerFUI.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PositionDraft_CountdownTimerFUI)
	self.id = "PositionDraft_CountdownTimerFUI"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local microtext = LUI.UIImage.new(0, 0, 669, 705, 0, 0, 150.5, 158.5)
	microtext:setRGB(ColorSet.T8__GREEN.r, ColorSet.T8__GREEN.g, ColorSet.T8__GREEN.b)
	microtext:setAlpha(0.2)
	microtext:setImage(RegisterImage(@"hash_116C3274D8031268"))
	self:addElement(microtext)
	self.microtext = microtext
	local microtext2 = LUI.UIImage.new(0, 0, 127, 91, 0, 0, 150.5, 158.5)
	microtext2:setRGB(ColorSet.T8__GREEN.r, ColorSet.T8__GREEN.g, ColorSet.T8__GREEN.b)
	microtext2:setAlpha(0.2)
	microtext2:setImage(RegisterImage(@"hash_116C3274D8031268"))
	self:addElement(microtext2)
	self.microtext2 = microtext2
	local ArrowRight = CoD.GameEndScoreCenterArrow.new(f1_arg0, f1_arg1, 0, 0, 482.5, 642.5, 0, 0, 118, 191)
	self:addElement(ArrowRight)
	self.ArrowRight = ArrowRight
	local ArrowRight2 = CoD.GameEndScoreCenterArrow.new(f1_arg0, f1_arg1, 0, 0, 153.5, 313.5, 0, 0, 118, 191)
	ArrowRight2:setZRot(180)
	self:addElement(ArrowRight2)
	self.ArrowRight2 = ArrowRight2
	local f1_local5 = nil
	self.BotArrow03 = LUI.UIElement.createFake()
	local f1_local6 = nil
	self.BotArrow02 = LUI.UIElement.createFake()
	local f1_local7 = nil
	self.BotArrow01 = LUI.UIElement.createFake()
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PositionDraft_CountdownTimerFUI.__resetProperties = function(f2_arg0)
	f2_arg0.ArrowRight2:completeAnimation()
	f2_arg0.ArrowRight:completeAnimation()
	f2_arg0.microtext2:completeAnimation()
	f2_arg0.microtext:completeAnimation()
	f2_arg0.BotArrow01:completeAnimation()
	f2_arg0.BotArrow03:completeAnimation()
	f2_arg0.BotArrow02:completeAnimation()
	f2_arg0.ArrowRight2:setRGB(1, 1, 1)
	f2_arg0.ArrowRight2:setAlpha(1)
	f2_arg0.ArrowRight:setRGB(1, 1, 1)
	f2_arg0.ArrowRight:setAlpha(1)
	f2_arg0.microtext2:setAlpha(0.2)
	f2_arg0.microtext:setAlpha(0.2)
	f2_arg0.BotArrow01:setRGB(0.92, 0.92, 0.92)
	f2_arg0.BotArrow01:setAlpha(1)
	f2_arg0.BotArrow03:setRGB(0.92, 0.92, 0.92)
	f2_arg0.BotArrow03:setAlpha(0.2)
	f2_arg0.BotArrow02:setRGB(0.92, 0.92, 0.92)
	f2_arg0.BotArrow02:setAlpha(0.5)
end
CoD.PositionDraft_CountdownTimerFUI.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(4)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:beginAnimation(500)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f5_arg0:beginAnimation(300)
					f5_arg0:setAlpha(0.5)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.microtext:beginAnimation(200)
				f3_arg0.microtext:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.microtext:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.microtext:completeAnimation()
			f3_arg0.microtext:setAlpha(0)
			f3_local0(f3_arg0.microtext)
			local f3_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					local f8_local0 = function(f9_arg0)
						f9_arg0:beginAnimation(500)
						f9_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f8_arg0:beginAnimation(300)
					f8_arg0:setAlpha(0.5)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
				end
				f3_arg0.microtext2:beginAnimation(200)
				f3_arg0.microtext2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.microtext2:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f3_arg0.microtext2:completeAnimation()
			f3_arg0.microtext2:setAlpha(0)
			f3_local1(f3_arg0.microtext2)
			local f3_local2 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					f11_arg0:beginAnimation(700)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.ArrowRight:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
				f3_arg0.ArrowRight:setAlpha(1)
				f3_arg0.ArrowRight:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.ArrowRight:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f3_arg0.ArrowRight:completeAnimation()
			f3_arg0.ArrowRight:setRGB(ColorSet.T8__GREEN.r, ColorSet.T8__GREEN.g, ColorSet.T8__GREEN.b)
			f3_arg0.ArrowRight:setAlpha(0)
			f3_local2(f3_arg0.ArrowRight)
			local f3_local3 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					f13_arg0:beginAnimation(700)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.ArrowRight2:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
				f3_arg0.ArrowRight2:setAlpha(1)
				f3_arg0.ArrowRight2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.ArrowRight2:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f3_arg0.ArrowRight2:completeAnimation()
			f3_arg0.ArrowRight2:setRGB(ColorSet.T8__GREEN.r, ColorSet.T8__GREEN.g, ColorSet.T8__GREEN.b)
			f3_arg0.ArrowRight2:setAlpha(0)
			f3_local3(f3_arg0.ArrowRight2)
			local f3_local4 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					f15_arg0:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
					f15_arg0:setAlpha(0.4)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.BotArrow03:beginAnimation(100)
				f3_arg0.BotArrow03:setAlpha(0.2)
				f3_arg0.BotArrow03:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.BotArrow03:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f3_arg0.BotArrow03:completeAnimation()
			f3_arg0.BotArrow03:setRGB(ColorSet.T8__GREEN.r, ColorSet.T8__GREEN.g, ColorSet.T8__GREEN.b)
			f3_arg0.BotArrow03:setAlpha(0)
			f3_local4(f3_arg0.BotArrow03)
			local f3_local5 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					local f17_local0 = function(f18_arg0)
						local f18_local0 = function(f19_arg0)
							f19_arg0:beginAnimation(199)
							f19_arg0:setAlpha(0.6)
							f19_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f18_arg0:beginAnimation(199, Enum[@"luitween"][@"luitween_ease_in"])
						f18_arg0:setAlpha(0.7)
						f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
					end
					f17_arg0:beginAnimation(200)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
				end
				f3_arg0.BotArrow02:beginAnimation(100)
				f3_arg0.BotArrow02:setAlpha(0.2)
				f3_arg0.BotArrow02:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.BotArrow02:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f3_arg0.BotArrow02:completeAnimation()
			f3_arg0.BotArrow02:setRGB(ColorSet.T8__GREEN.r, ColorSet.T8__GREEN.g, ColorSet.T8__GREEN.b)
			f3_arg0.BotArrow02:setAlpha(0)
			f3_local5(f3_arg0.BotArrow02)
			local f3_local6 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					local f21_local0 = function(f22_arg0)
						f22_arg0:beginAnimation(199, Enum[@"luitween"][@"luitween_ease_in"])
						f22_arg0:setAlpha(1)
						f22_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f21_arg0:beginAnimation(400)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
				end
				f3_arg0.BotArrow01:beginAnimation(100)
				f3_arg0.BotArrow01:setAlpha(0.2)
				f3_arg0.BotArrow01:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.BotArrow01:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f3_arg0.BotArrow01:completeAnimation()
			f3_arg0.BotArrow01:setRGB(ColorSet.T8__GREEN.r, ColorSet.T8__GREEN.g, ColorSet.T8__GREEN.b)
			f3_arg0.BotArrow01:setAlpha(0)
			f3_local6(f3_arg0.BotArrow01)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.PositionDraft_CountdownTimerFUI.__onClose = function(f23_arg0)
	f23_arg0.ArrowRight:close()
	f23_arg0.ArrowRight2:close()
end
