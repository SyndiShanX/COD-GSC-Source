CoD.KillcamNemesisArrow = InheritFrom(LUI.UIElement)
CoD.KillcamNemesisArrow.__defaultWidth = 150
CoD.KillcamNemesisArrow.__defaultHeight = 58
CoD.KillcamNemesisArrow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.KillcamNemesisArrow)
	self.id = "KillcamNemesisArrow"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local arrowTopR01 = LUI.UIImage.new(0, 0, 126, 147, 0, 0, 7, 52)
	arrowTopR01:setAlpha(0.5)
	arrowTopR01:setScale(1, 0.6)
	arrowTopR01:setImage(RegisterImage(@"hash_4C0988BF8D5576A0"))
	self:addElement(arrowTopR01)
	self.arrowTopR01 = arrowTopR01
	local arrowTopR02 = LUI.UIImage.new(0, 0, 143, 164, 0, 0, 7, 52)
	arrowTopR02:setAlpha(0.2)
	arrowTopR02:setScale(1, 0.6)
	arrowTopR02:setImage(RegisterImage(@"hash_4C0988BF8D5576A0"))
	self:addElement(arrowTopR02)
	self.arrowTopR02 = arrowTopR02
	local arrowTopR03 = LUI.UIImage.new(0, 0, 160, 181, 0, 0, 7, 52)
	arrowTopR03:setAlpha(0.1)
	arrowTopR03:setScale(1, 0.6)
	arrowTopR03:setImage(RegisterImage(@"hash_4C0988BF8D5576A0"))
	self:addElement(arrowTopR03)
	self.arrowTopR03 = arrowTopR03
	local arrowTopL01 = LUI.UIImage.new(0, 0, 2, 23, 0, 0, 7, 52)
	arrowTopL01:setAlpha(0.5)
	arrowTopL01:setZRot(180)
	arrowTopL01:setScale(1, 0.6)
	arrowTopL01:setImage(RegisterImage(@"hash_4C0988BF8D5576A0"))
	self:addElement(arrowTopL01)
	self.arrowTopL01 = arrowTopL01
	local arrowTopL02 = LUI.UIImage.new(0, 0, -15, 6, 0, 0, 7, 52)
	arrowTopL02:setAlpha(0.2)
	arrowTopL02:setZRot(180)
	arrowTopL02:setScale(1, 0.6)
	arrowTopL02:setImage(RegisterImage(@"hash_4C0988BF8D5576A0"))
	self:addElement(arrowTopL02)
	self.arrowTopL02 = arrowTopL02
	local arrowTopL03 = LUI.UIImage.new(0, 0, -32, -11, 0, 0, 7, 52)
	arrowTopL03:setAlpha(0.1)
	arrowTopL03:setZRot(180)
	arrowTopL03:setScale(1, 0.6)
	arrowTopL03:setImage(RegisterImage(@"hash_4C0988BF8D5576A0"))
	self:addElement(arrowTopL03)
	self.arrowTopL03 = arrowTopL03
	self:mergeStateConditions({
		{
			stateName = "Killcam",
			condition = function(menu, element, event)
				local f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
				if f2_local0 then
					if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_final_killcam"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_round_end_killcam"]) then
						f2_local0 = not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
					else
						f2_local0 = false
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "FinalKillcam",
			condition = function(menu, element, event)
				local f3_local0
				if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"]) then
					f3_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_final_killcam"])
					if f3_local0 then
						if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_round_end_killcam"]) then
							f3_local0 = not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
						else
							f3_local0 = false
						end
					end
				else
					f3_local0 = false
				end
				return f3_local0
			end,
		},
		{
			stateName = "RoundEndingKillcam",
			condition = function(menu, element, event)
				local f4_local0
				if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_final_killcam"]) then
					f4_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_round_end_killcam"])
					if f4_local0 then
						f4_local0 = not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
					end
				else
					f4_local0 = false
				end
				return f4_local0
			end,
		},
		{
			stateName = "NemesisKillcam",
			condition = function(menu, element, event)
				local f5_local0
				if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"]) then
					f5_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"])
					if f5_local0 then
						if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_final_killcam"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_round_end_killcam"]) then
							f5_local0 = not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
						else
							f5_local0 = false
						end
					end
				else
					f5_local0 = false
				end
				return f5_local0
			end,
		},
		{
			stateName = "PlayOfTheMatch",
			condition = function(menu, element, event)
				local f6_local0
				if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_final_killcam"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_round_end_killcam"]) then
					f6_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
				else
					f6_local0 = false
				end
				return f6_local0
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"]], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_final_killcam"]], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_final_killcam"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_round_end_killcam"]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_round_end_killcam"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.KillcamNemesisArrow.__resetProperties = function(f12_arg0)
	f12_arg0.arrowTopR01:completeAnimation()
	f12_arg0.arrowTopL01:completeAnimation()
	f12_arg0.arrowTopL03:completeAnimation()
	f12_arg0.arrowTopL02:completeAnimation()
	f12_arg0.arrowTopR03:completeAnimation()
	f12_arg0.arrowTopR02:completeAnimation()
	f12_arg0.arrowTopR01:setAlpha(0.5)
	f12_arg0.arrowTopL01:setAlpha(0.5)
	f12_arg0.arrowTopL03:setAlpha(0.1)
	f12_arg0.arrowTopL02:setAlpha(0.2)
	f12_arg0.arrowTopR03:setAlpha(0.1)
	f12_arg0.arrowTopR02:setAlpha(0.2)
end
CoD.KillcamNemesisArrow.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(6)
			f13_arg0.arrowTopR01:completeAnimation()
			f13_arg0.arrowTopR01:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.arrowTopR01)
			f13_arg0.arrowTopR02:completeAnimation()
			f13_arg0.arrowTopR02:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.arrowTopR02)
			f13_arg0.arrowTopR03:completeAnimation()
			f13_arg0.arrowTopR03:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.arrowTopR03)
			f13_arg0.arrowTopL01:completeAnimation()
			f13_arg0.arrowTopL01:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.arrowTopL01)
			f13_arg0.arrowTopL02:completeAnimation()
			f13_arg0.arrowTopL02:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.arrowTopL02)
			f13_arg0.arrowTopL03:completeAnimation()
			f13_arg0.arrowTopL03:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.arrowTopL03)
		end,
	},
	Killcam = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(6)
			local f14_local0 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					f16_arg0:beginAnimation(299, Enum[@"luitween"][@"luitween_ease_in"])
					f16_arg0:setAlpha(0.5)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
				end
				f14_arg0.arrowTopR01:beginAnimation(600)
				f14_arg0.arrowTopR01:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.arrowTopR01:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f14_arg0.arrowTopR01:completeAnimation()
			f14_arg0.arrowTopR01:setAlpha(0)
			f14_local0(f14_arg0.arrowTopR01)
			local f14_local1 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					f18_arg0:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
					f18_arg0:setAlpha(0.2)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
				end
				f14_arg0.arrowTopR02:beginAnimation(300)
				f14_arg0.arrowTopR02:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.arrowTopR02:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f14_arg0.arrowTopR02:completeAnimation()
			f14_arg0.arrowTopR02:setAlpha(0)
			f14_local1(f14_arg0.arrowTopR02)
			local f14_local2 = function(f19_arg0)
				f14_arg0.arrowTopR03:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
				f14_arg0.arrowTopR03:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.arrowTopR03:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.arrowTopR03:completeAnimation()
			f14_arg0.arrowTopR03:setAlpha(0.1)
			f14_local2(f14_arg0.arrowTopR03)
			local f14_local3 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					f21_arg0:beginAnimation(299, Enum[@"luitween"][@"luitween_ease_in"])
					f21_arg0:setAlpha(0.5)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
				end
				f14_arg0.arrowTopL01:beginAnimation(600)
				f14_arg0.arrowTopL01:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.arrowTopL01:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f14_arg0.arrowTopL01:completeAnimation()
			f14_arg0.arrowTopL01:setAlpha(0)
			f14_local3(f14_arg0.arrowTopL01)
			local f14_local4 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					f23_arg0:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
					f23_arg0:setAlpha(0.2)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
				end
				f14_arg0.arrowTopL02:beginAnimation(300)
				f14_arg0.arrowTopL02:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.arrowTopL02:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f14_arg0.arrowTopL02:completeAnimation()
			f14_arg0.arrowTopL02:setAlpha(0)
			f14_local4(f14_arg0.arrowTopL02)
			local f14_local5 = function(f24_arg0)
				f14_arg0.arrowTopL03:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
				f14_arg0.arrowTopL03:setAlpha(0.1)
				f14_arg0.arrowTopL03:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.arrowTopL03:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.arrowTopL03:completeAnimation()
			f14_arg0.arrowTopL03:setAlpha(0)
			f14_local5(f14_arg0.arrowTopL03)
			f14_arg0.nextClip = "DefaultClip"
		end,
	},
	FinalKillcam = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(6)
			local f25_local0 = function(f26_arg0)
				local f26_local0 = function(f27_arg0)
					f27_arg0:beginAnimation(299, Enum[@"luitween"][@"luitween_ease_in"])
					f27_arg0:setAlpha(0.5)
					f27_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
				end
				f25_arg0.arrowTopR01:beginAnimation(600)
				f25_arg0.arrowTopR01:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.arrowTopR01:registerEventHandler("transition_complete_keyframe", f26_local0)
			end
			f25_arg0.arrowTopR01:completeAnimation()
			f25_arg0.arrowTopR01:setAlpha(0)
			f25_local0(f25_arg0.arrowTopR01)
			local f25_local1 = function(f28_arg0)
				local f28_local0 = function(f29_arg0)
					f29_arg0:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
					f29_arg0:setAlpha(0.2)
					f29_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
				end
				f25_arg0.arrowTopR02:beginAnimation(300)
				f25_arg0.arrowTopR02:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.arrowTopR02:registerEventHandler("transition_complete_keyframe", f28_local0)
			end
			f25_arg0.arrowTopR02:completeAnimation()
			f25_arg0.arrowTopR02:setAlpha(0)
			f25_local1(f25_arg0.arrowTopR02)
			local f25_local2 = function(f30_arg0)
				f25_arg0.arrowTopR03:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
				f25_arg0.arrowTopR03:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.arrowTopR03:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.arrowTopR03:completeAnimation()
			f25_arg0.arrowTopR03:setAlpha(0.1)
			f25_local2(f25_arg0.arrowTopR03)
			local f25_local3 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					f32_arg0:beginAnimation(299, Enum[@"luitween"][@"luitween_ease_in"])
					f32_arg0:setAlpha(0.5)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
				end
				f25_arg0.arrowTopL01:beginAnimation(600)
				f25_arg0.arrowTopL01:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.arrowTopL01:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f25_arg0.arrowTopL01:completeAnimation()
			f25_arg0.arrowTopL01:setAlpha(0)
			f25_local3(f25_arg0.arrowTopL01)
			local f25_local4 = function(f33_arg0)
				local f33_local0 = function(f34_arg0)
					f34_arg0:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
					f34_arg0:setAlpha(0.2)
					f34_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
				end
				f25_arg0.arrowTopL02:beginAnimation(300)
				f25_arg0.arrowTopL02:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.arrowTopL02:registerEventHandler("transition_complete_keyframe", f33_local0)
			end
			f25_arg0.arrowTopL02:completeAnimation()
			f25_arg0.arrowTopL02:setAlpha(0)
			f25_local4(f25_arg0.arrowTopL02)
			local f25_local5 = function(f35_arg0)
				f25_arg0.arrowTopL03:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
				f25_arg0.arrowTopL03:setAlpha(0.1)
				f25_arg0.arrowTopL03:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.arrowTopL03:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.arrowTopL03:completeAnimation()
			f25_arg0.arrowTopL03:setAlpha(0)
			f25_local5(f25_arg0.arrowTopL03)
		end,
	},
	RoundEndingKillcam = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(6)
			local f36_local0 = function(f37_arg0)
				local f37_local0 = function(f38_arg0)
					f38_arg0:beginAnimation(299, Enum[@"luitween"][@"luitween_ease_in"])
					f38_arg0:setAlpha(0.5)
					f38_arg0:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
				end
				f36_arg0.arrowTopR01:beginAnimation(600)
				f36_arg0.arrowTopR01:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.arrowTopR01:registerEventHandler("transition_complete_keyframe", f37_local0)
			end
			f36_arg0.arrowTopR01:completeAnimation()
			f36_arg0.arrowTopR01:setAlpha(0)
			f36_local0(f36_arg0.arrowTopR01)
			local f36_local1 = function(f39_arg0)
				local f39_local0 = function(f40_arg0)
					f40_arg0:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
					f40_arg0:setAlpha(0.2)
					f40_arg0:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
				end
				f36_arg0.arrowTopR02:beginAnimation(300)
				f36_arg0.arrowTopR02:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.arrowTopR02:registerEventHandler("transition_complete_keyframe", f39_local0)
			end
			f36_arg0.arrowTopR02:completeAnimation()
			f36_arg0.arrowTopR02:setAlpha(0)
			f36_local1(f36_arg0.arrowTopR02)
			local f36_local2 = function(f41_arg0)
				f36_arg0.arrowTopR03:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
				f36_arg0.arrowTopR03:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.arrowTopR03:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
			end
			f36_arg0.arrowTopR03:completeAnimation()
			f36_arg0.arrowTopR03:setAlpha(0.1)
			f36_local2(f36_arg0.arrowTopR03)
			local f36_local3 = function(f42_arg0)
				local f42_local0 = function(f43_arg0)
					f43_arg0:beginAnimation(299, Enum[@"luitween"][@"luitween_ease_in"])
					f43_arg0:setAlpha(0.5)
					f43_arg0:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
				end
				f36_arg0.arrowTopL01:beginAnimation(600)
				f36_arg0.arrowTopL01:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.arrowTopL01:registerEventHandler("transition_complete_keyframe", f42_local0)
			end
			f36_arg0.arrowTopL01:completeAnimation()
			f36_arg0.arrowTopL01:setAlpha(0)
			f36_local3(f36_arg0.arrowTopL01)
			local f36_local4 = function(f44_arg0)
				local f44_local0 = function(f45_arg0)
					f45_arg0:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
					f45_arg0:setAlpha(0.2)
					f45_arg0:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
				end
				f36_arg0.arrowTopL02:beginAnimation(300)
				f36_arg0.arrowTopL02:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.arrowTopL02:registerEventHandler("transition_complete_keyframe", f44_local0)
			end
			f36_arg0.arrowTopL02:completeAnimation()
			f36_arg0.arrowTopL02:setAlpha(0)
			f36_local4(f36_arg0.arrowTopL02)
			local f36_local5 = function(f46_arg0)
				f36_arg0.arrowTopL03:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
				f36_arg0.arrowTopL03:setAlpha(0.1)
				f36_arg0.arrowTopL03:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.arrowTopL03:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
			end
			f36_arg0.arrowTopL03:completeAnimation()
			f36_arg0.arrowTopL03:setAlpha(0)
			f36_local5(f36_arg0.arrowTopL03)
		end,
	},
	NemesisKillcam = {
		DefaultClip = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(6)
			local f47_local0 = function(f48_arg0)
				local f48_local0 = function(f49_arg0)
					f49_arg0:beginAnimation(299, Enum[@"luitween"][@"luitween_ease_in"])
					f49_arg0:setAlpha(0.5)
					f49_arg0:registerEventHandler("transition_complete_keyframe", f47_arg0.clipFinished)
				end
				f47_arg0.arrowTopR01:beginAnimation(600)
				f47_arg0.arrowTopR01:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.arrowTopR01:registerEventHandler("transition_complete_keyframe", f48_local0)
			end
			f47_arg0.arrowTopR01:completeAnimation()
			f47_arg0.arrowTopR01:setAlpha(0)
			f47_local0(f47_arg0.arrowTopR01)
			local f47_local1 = function(f50_arg0)
				local f50_local0 = function(f51_arg0)
					f51_arg0:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
					f51_arg0:setAlpha(0.2)
					f51_arg0:registerEventHandler("transition_complete_keyframe", f47_arg0.clipFinished)
				end
				f47_arg0.arrowTopR02:beginAnimation(300)
				f47_arg0.arrowTopR02:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.arrowTopR02:registerEventHandler("transition_complete_keyframe", f50_local0)
			end
			f47_arg0.arrowTopR02:completeAnimation()
			f47_arg0.arrowTopR02:setAlpha(0)
			f47_local1(f47_arg0.arrowTopR02)
			local f47_local2 = function(f52_arg0)
				f47_arg0.arrowTopR03:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
				f47_arg0.arrowTopR03:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.arrowTopR03:registerEventHandler("transition_complete_keyframe", f47_arg0.clipFinished)
			end
			f47_arg0.arrowTopR03:completeAnimation()
			f47_arg0.arrowTopR03:setAlpha(0.1)
			f47_local2(f47_arg0.arrowTopR03)
			local f47_local3 = function(f53_arg0)
				local f53_local0 = function(f54_arg0)
					f54_arg0:beginAnimation(299, Enum[@"luitween"][@"luitween_ease_in"])
					f54_arg0:setAlpha(0.5)
					f54_arg0:registerEventHandler("transition_complete_keyframe", f47_arg0.clipFinished)
				end
				f47_arg0.arrowTopL01:beginAnimation(600)
				f47_arg0.arrowTopL01:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.arrowTopL01:registerEventHandler("transition_complete_keyframe", f53_local0)
			end
			f47_arg0.arrowTopL01:completeAnimation()
			f47_arg0.arrowTopL01:setAlpha(0)
			f47_local3(f47_arg0.arrowTopL01)
			local f47_local4 = function(f55_arg0)
				local f55_local0 = function(f56_arg0)
					f56_arg0:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
					f56_arg0:setAlpha(0.2)
					f56_arg0:registerEventHandler("transition_complete_keyframe", f47_arg0.clipFinished)
				end
				f47_arg0.arrowTopL02:beginAnimation(300)
				f47_arg0.arrowTopL02:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.arrowTopL02:registerEventHandler("transition_complete_keyframe", f55_local0)
			end
			f47_arg0.arrowTopL02:completeAnimation()
			f47_arg0.arrowTopL02:setAlpha(0)
			f47_local4(f47_arg0.arrowTopL02)
			local f47_local5 = function(f57_arg0)
				f47_arg0.arrowTopL03:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
				f47_arg0.arrowTopL03:setAlpha(0.1)
				f47_arg0.arrowTopL03:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.arrowTopL03:registerEventHandler("transition_complete_keyframe", f47_arg0.clipFinished)
			end
			f47_arg0.arrowTopL03:completeAnimation()
			f47_arg0.arrowTopL03:setAlpha(0)
			f47_local5(f47_arg0.arrowTopL03)
		end,
	},
	PlayOfTheMatch = {
		DefaultClip = function(f58_arg0, f58_arg1)
			f58_arg0:__resetProperties()
			f58_arg0:setupElementClipCounter(6)
			local f58_local0 = function(f59_arg0)
				local f59_local0 = function(f60_arg0)
					f60_arg0:beginAnimation(299, Enum[@"luitween"][@"luitween_ease_in"])
					f60_arg0:setAlpha(0.5)
					f60_arg0:registerEventHandler("transition_complete_keyframe", f58_arg0.clipFinished)
				end
				f58_arg0.arrowTopR01:beginAnimation(600)
				f58_arg0.arrowTopR01:registerEventHandler("interrupted_keyframe", f58_arg0.clipInterrupted)
				f58_arg0.arrowTopR01:registerEventHandler("transition_complete_keyframe", f59_local0)
			end
			f58_arg0.arrowTopR01:completeAnimation()
			f58_arg0.arrowTopR01:setAlpha(0)
			f58_local0(f58_arg0.arrowTopR01)
			local f58_local1 = function(f61_arg0)
				local f61_local0 = function(f62_arg0)
					f62_arg0:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
					f62_arg0:setAlpha(0.2)
					f62_arg0:registerEventHandler("transition_complete_keyframe", f58_arg0.clipFinished)
				end
				f58_arg0.arrowTopR02:beginAnimation(300)
				f58_arg0.arrowTopR02:registerEventHandler("interrupted_keyframe", f58_arg0.clipInterrupted)
				f58_arg0.arrowTopR02:registerEventHandler("transition_complete_keyframe", f61_local0)
			end
			f58_arg0.arrowTopR02:completeAnimation()
			f58_arg0.arrowTopR02:setAlpha(0)
			f58_local1(f58_arg0.arrowTopR02)
			local f58_local2 = function(f63_arg0)
				f58_arg0.arrowTopR03:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
				f58_arg0.arrowTopR03:registerEventHandler("interrupted_keyframe", f58_arg0.clipInterrupted)
				f58_arg0.arrowTopR03:registerEventHandler("transition_complete_keyframe", f58_arg0.clipFinished)
			end
			f58_arg0.arrowTopR03:completeAnimation()
			f58_arg0.arrowTopR03:setAlpha(0.1)
			f58_local2(f58_arg0.arrowTopR03)
			local f58_local3 = function(f64_arg0)
				local f64_local0 = function(f65_arg0)
					f65_arg0:beginAnimation(299, Enum[@"luitween"][@"luitween_ease_in"])
					f65_arg0:setAlpha(0.5)
					f65_arg0:registerEventHandler("transition_complete_keyframe", f58_arg0.clipFinished)
				end
				f58_arg0.arrowTopL01:beginAnimation(600)
				f58_arg0.arrowTopL01:registerEventHandler("interrupted_keyframe", f58_arg0.clipInterrupted)
				f58_arg0.arrowTopL01:registerEventHandler("transition_complete_keyframe", f64_local0)
			end
			f58_arg0.arrowTopL01:completeAnimation()
			f58_arg0.arrowTopL01:setAlpha(0)
			f58_local3(f58_arg0.arrowTopL01)
			local f58_local4 = function(f66_arg0)
				local f66_local0 = function(f67_arg0)
					f67_arg0:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
					f67_arg0:setAlpha(0.2)
					f67_arg0:registerEventHandler("transition_complete_keyframe", f58_arg0.clipFinished)
				end
				f58_arg0.arrowTopL02:beginAnimation(300)
				f58_arg0.arrowTopL02:registerEventHandler("interrupted_keyframe", f58_arg0.clipInterrupted)
				f58_arg0.arrowTopL02:registerEventHandler("transition_complete_keyframe", f66_local0)
			end
			f58_arg0.arrowTopL02:completeAnimation()
			f58_arg0.arrowTopL02:setAlpha(0)
			f58_local4(f58_arg0.arrowTopL02)
			local f58_local5 = function(f68_arg0)
				f58_arg0.arrowTopL03:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
				f58_arg0.arrowTopL03:setAlpha(0.1)
				f58_arg0.arrowTopL03:registerEventHandler("interrupted_keyframe", f58_arg0.clipInterrupted)
				f58_arg0.arrowTopL03:registerEventHandler("transition_complete_keyframe", f58_arg0.clipFinished)
			end
			f58_arg0.arrowTopL03:completeAnimation()
			f58_arg0.arrowTopL03:setAlpha(0)
			f58_local5(f58_arg0.arrowTopL03)
		end,
	},
}
