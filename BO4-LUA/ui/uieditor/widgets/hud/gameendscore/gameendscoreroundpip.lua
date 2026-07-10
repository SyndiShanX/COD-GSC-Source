CoD.GameEndScoreRoundPip = InheritFrom(LUI.UIElement)
CoD.GameEndScoreRoundPip.__defaultWidth = 48
CoD.GameEndScoreRoundPip.__defaultHeight = 48
CoD.GameEndScoreRoundPip.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameEndScoreRoundPip)
	self.id = "GameEndScoreRoundPip"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Sound = LUI.UIElement.new(0, 0, -28, 4, 0, 0, 74, 106)
	Sound:setPlaySoundDirect(true)
	self:addElement(Sound)
	self.Sound = Sound
	local BG = LUI.UIImage.new(0, 1, 1, -1, 0, 1, 1, -1)
	BG:setRGB(0, 0, 0)
	BG:setAlpha(0.15)
	self:addElement(BG)
	self.BG = BG
	local InnerShadow = LUI.UIImage.new(0, 1, 1, -1, 0, 1, 1, -1)
	InnerShadow:setAlpha(0.85)
	InnerShadow:setImage(RegisterImage(0x96ACD5A9B6E5230))
	self:addElement(InnerShadow)
	self.InnerShadow = InnerShadow
	local GlowOver = LUI.UIImage.new(0.5, 0.5, -2, 2, 0.5, 0.5, -35, 36)
	GlowOver:setAlpha(0)
	GlowOver:setZRot(90)
	GlowOver:setScale(3.2, 3.2)
	GlowOver:setImage(RegisterImage(0x5BE416E17DAB33B))
	GlowOver:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(GlowOver)
	self.GlowOver = GlowOver
	local Glow = LUI.UIImage.new(-0.25, 1.25, 0, 0, -0.25, 1.25, 0, 0)
	Glow:setAlpha(0)
	Glow:setImage(RegisterImage(0x69CF640F22433BA))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	Glow:linkToElementModel(self, "teamColor", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Glow:setRGB(f2_local0)
		end
	end)
	self:addElement(Glow)
	self.Glow = Glow
	local Glow2 = LUI.UIImage.new(-0.05, 1.05, 0, 0, -0.05, 1.05, 0, 0)
	Glow2:setAlpha(0)
	Glow2:setImage(RegisterImage(0x69CF640F22433BA))
	Glow2:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	Glow2:setShaderVector(0, 1, 0, 0, 0)
	Glow2:linkToElementModel(self, "teamColor", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Glow2:setRGB(f3_local0)
		end
	end)
	self:addElement(Glow2)
	self.Glow2 = Glow2
	local SquarePip = LUI.UIImage.new(0.5, 1.5, -16, -32, 0.5, 1.5, -16, -32)
	SquarePip:linkToElementModel(self, "teamColor", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			SquarePip:setRGB(f4_local0)
		end
	end)
	self:addElement(SquarePip)
	self.SquarePip = SquarePip
	local BoxLine = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BoxLine:setAlpha(0.7)
	BoxLine:setMaterial(LUI.UIImage.GetCachedMaterial(0xE7BDCB879A5176D))
	BoxLine:setShaderVector(0, 0, 0, 0, 0)
	BoxLine:setShaderVector(1, 0.5, 0.5, 0.5, 0)
	BoxLine:setupNineSliceShader(1, 1)
	self:addElement(BoxLine)
	self.BoxLine = BoxLine
	local Corner1 = LUI.UIImage.new(0, 0, 0, 2, 0, 0, 0, 2)
	Corner1:setRGB(0.92, 0.92, 0.92)
	Corner1:setAlpha(0.9)
	self:addElement(Corner1)
	self.Corner1 = Corner1
	local Corner2 = LUI.UIImage.new(1, 1, -2, 0, 0, 0, 0, 2)
	Corner2:setRGB(0.92, 0.92, 0.92)
	Corner2:setAlpha(0.9)
	self:addElement(Corner2)
	self.Corner2 = Corner2
	local Corner3 = LUI.UIImage.new(1, 1, -2, 0, 1, 1, -2, 0)
	Corner3:setRGB(0.92, 0.92, 0.92)
	Corner3:setAlpha(0.9)
	self:addElement(Corner3)
	self.Corner3 = Corner3
	local Corner4 = LUI.UIImage.new(0, 0, 0, 2, 1, 1, -2, 0)
	Corner4:setRGB(0.92, 0.92, 0.92)
	Corner4:setAlpha(0.9)
	self:addElement(Corner4)
	self.Corner4 = Corner4
	local Pattern = LUI.UIImage.new(0.67, 1.67, -31, -33, 0.67, 1.67, -31, -33)
	Pattern:setAlpha(0.25)
	Pattern:setImage(RegisterImage(0x891DC3183D8B5AF))
	Pattern:setMaterial(LUI.UIImage.GetCachedMaterial(0xD8EA9FE9B0BCF75))
	Pattern:setShaderVector(0, 1, 1, 0, 0)
	Pattern:setShaderVector(1, 0, 0, 0, 0)
	self:addElement(Pattern)
	self.Pattern = Pattern
	self:mergeStateConditions({
		{
			stateName = "JustComplete",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "justComplete")
			end,
		},
		{
			stateName = "Complete",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isComplete")
			end,
		},
	})
	self:linkToElementModel(self, "justComplete", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "justComplete",
		})
	end)
	self:linkToElementModel(self, "isComplete", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isComplete",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameEndScoreRoundPip.__resetProperties = function(f9_arg0)
	f9_arg0.Pattern:completeAnimation()
	f9_arg0.SquarePip:completeAnimation()
	f9_arg0.Glow2:completeAnimation()
	f9_arg0.Sound:completeAnimation()
	f9_arg0.Corner4:completeAnimation()
	f9_arg0.Corner2:completeAnimation()
	f9_arg0.Corner3:completeAnimation()
	f9_arg0.Corner1:completeAnimation()
	f9_arg0.BoxLine:completeAnimation()
	f9_arg0.GlowOver:completeAnimation()
	f9_arg0.Glow:completeAnimation()
	f9_arg0.BG:completeAnimation()
	f9_arg0.Pattern:setAlpha(0.25)
	f9_arg0.SquarePip:setAlpha(1)
	f9_arg0.SquarePip:setScale(1, 1)
	f9_arg0.Glow2:setAlpha(0)
	f9_arg0.Corner4:setAlpha(0.9)
	f9_arg0.Corner2:setAlpha(0.9)
	f9_arg0.Corner3:setAlpha(0.9)
	f9_arg0.Corner1:setAlpha(0.9)
	f9_arg0.BoxLine:setAlpha(0.7)
	f9_arg0.GlowOver:setAlpha(0)
	f9_arg0.GlowOver:setScale(3.2, 3.2)
	f9_arg0.Glow:setAlpha(0)
	f9_arg0.Glow:setScale(1, 1)
	f9_arg0.Glow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	f9_arg0.BG:setAlpha(0.15)
end
CoD.GameEndScoreRoundPip.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			f10_arg0.Glow2:completeAnimation()
			f10_arg0.Glow2:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Glow2)
			f10_arg0.SquarePip:completeAnimation()
			f10_arg0.SquarePip:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.SquarePip)
			f10_arg0.Pattern:completeAnimation()
			f10_arg0.Pattern:setAlpha(0.02)
			f10_arg0.clipFinished(f10_arg0.Pattern)
		end,
	},
	JustComplete = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(11)
			local f11_local0 = function(f12_arg0)
				f11_arg0.Sound:playSound("uin_round_end_pip_1", f11_arg1)
				f11_arg0.Sound:beginAnimation(400)
				f11_arg0.Sound:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Sound:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playSound("uin_round_end_pip_2", f11_arg1)
					f11_arg0.clipFinished(element, event)
				end)
			end
			f11_arg0.Sound:completeAnimation()
			f11_local0(f11_arg0.Sound)
			local f11_local1 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					local f15_local0 = function(f16_arg0)
						f16_arg0:beginAnimation(20)
						f16_arg0:setAlpha(0)
						f16_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
					end
					f15_arg0:beginAnimation(220)
					f15_arg0:setAlpha(0.08)
					f15_arg0:setScale(5, 0)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
				end
				f11_arg0.GlowOver:beginAnimation(60)
				f11_arg0.GlowOver:setScale(5, 8)
				f11_arg0.GlowOver:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.GlowOver:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f11_arg0.GlowOver:completeAnimation()
			f11_arg0.GlowOver:setAlpha(1)
			f11_arg0.GlowOver:setScale(0, 0)
			f11_local1(f11_arg0.GlowOver)
			local f11_local2 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					local f18_local0 = function(f19_arg0)
						local f19_local0 = function(f20_arg0)
							f20_arg0:beginAnimation(9)
							f20_arg0:setAlpha(0)
							f20_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
						end
						f19_arg0:beginAnimation(130)
						f19_arg0:setAlpha(0.07)
						f19_arg0:setScale(0, 0)
						f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
					end
					f18_arg0:beginAnimation(10)
					f18_arg0:setScale(1.21, 1.21)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
				end
				f11_arg0.Glow:beginAnimation(60)
				f11_arg0.Glow:setScale(1.3, 1.3)
				f11_arg0.Glow:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Glow:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f11_arg0.Glow:completeAnimation()
			f11_arg0.Glow:setAlpha(1)
			f11_arg0.Glow:setScale(0, 0)
			f11_local2(f11_arg0.Glow)
			local f11_local3 = function(f21_arg0)
				f11_arg0.Glow2:beginAnimation(700)
				f11_arg0.Glow2:setAlpha(0.4)
				f11_arg0.Glow2:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Glow2:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.Glow2:completeAnimation()
			f11_arg0.Glow2:setAlpha(0)
			f11_local3(f11_arg0.Glow2)
			local f11_local4 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					local f23_local0 = function(f24_arg0)
						local f24_local0 = function(f25_arg0)
							f25_arg0:beginAnimation(9)
							f25_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
						end
						f24_arg0:beginAnimation(110)
						f24_arg0:setAlpha(0.96)
						f24_arg0:setScale(1, 1)
						f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
					end
					f23_arg0:beginAnimation(10)
					f23_arg0:setAlpha(1)
					f23_arg0:setScale(1.18, 1.18)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
				end
				f11_arg0.SquarePip:beginAnimation(30)
				f11_arg0.SquarePip:setAlpha(0.75)
				f11_arg0.SquarePip:setScale(1.2, 1.2)
				f11_arg0.SquarePip:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.SquarePip:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f11_arg0.SquarePip:completeAnimation()
			f11_arg0.SquarePip:setAlpha(0)
			f11_arg0.SquarePip:setScale(0, 0)
			f11_local4(f11_arg0.SquarePip)
			f11_arg0.BoxLine:completeAnimation()
			f11_arg0.BoxLine:setAlpha(0.5)
			f11_arg0.clipFinished(f11_arg0.BoxLine)
			f11_arg0.Corner1:completeAnimation()
			f11_arg0.Corner1:setAlpha(0.5)
			f11_arg0.clipFinished(f11_arg0.Corner1)
			f11_arg0.Corner2:completeAnimation()
			f11_arg0.Corner2:setAlpha(0.5)
			f11_arg0.clipFinished(f11_arg0.Corner2)
			f11_arg0.Corner3:completeAnimation()
			f11_arg0.Corner3:setAlpha(0.5)
			f11_arg0.clipFinished(f11_arg0.Corner3)
			f11_arg0.Corner4:completeAnimation()
			f11_arg0.Corner4:setAlpha(0.5)
			f11_arg0.clipFinished(f11_arg0.Corner4)
			local f11_local5 = function(f26_arg0)
				local f26_local0 = function(f27_arg0)
					local f27_local0 = function(f28_arg0)
						f28_arg0:beginAnimation(140)
						f28_arg0:setAlpha(0.05)
						f28_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
					end
					f27_arg0:beginAnimation(99, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f27_arg0:setAlpha(0.25)
					f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
				end
				f11_arg0.Pattern:beginAnimation(60)
				f11_arg0.Pattern:setAlpha(0.05)
				f11_arg0.Pattern:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Pattern:registerEventHandler("transition_complete_keyframe", f26_local0)
			end
			f11_arg0.Pattern:completeAnimation()
			f11_arg0.Pattern:setAlpha(0.02)
			f11_local5(f11_arg0.Pattern)
		end,
	},
	Complete = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(7)
			f29_arg0.BG:completeAnimation()
			f29_arg0.BG:setAlpha(0.5)
			f29_arg0.clipFinished(f29_arg0.BG)
			f29_arg0.GlowOver:completeAnimation()
			f29_arg0.GlowOver:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.GlowOver)
			f29_arg0.Glow:completeAnimation()
			f29_arg0.Glow:setAlpha(0)
			f29_arg0.Glow:setScale(1.1, 1.1)
			f29_arg0.Glow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
			f29_arg0.clipFinished(f29_arg0.Glow)
			local f29_local0 = function(f30_arg0)
				local f30_local0 = function(f31_arg0)
					f31_arg0:beginAnimation(500)
					f31_arg0:setAlpha(0.4)
					f31_arg0:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
				end
				f29_arg0.Glow2:beginAnimation(500)
				f29_arg0.Glow2:setAlpha(0.5)
				f29_arg0.Glow2:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.Glow2:registerEventHandler("transition_complete_keyframe", f30_local0)
			end
			f29_arg0.Glow2:completeAnimation()
			f29_arg0.Glow2:setAlpha(0.4)
			f29_local0(f29_arg0.Glow2)
			f29_arg0.SquarePip:completeAnimation()
			f29_arg0.SquarePip:setAlpha(0.96)
			f29_arg0.clipFinished(f29_arg0.SquarePip)
			f29_arg0.BoxLine:completeAnimation()
			f29_arg0.BoxLine:setAlpha(0.5)
			f29_arg0.clipFinished(f29_arg0.BoxLine)
			local f29_local1 = function(f32_arg0)
				local f32_local0 = function(f33_arg0)
					f33_arg0:beginAnimation(500)
					f33_arg0:setAlpha(0.05)
					f33_arg0:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
				end
				f29_arg0.Pattern:beginAnimation(500)
				f29_arg0.Pattern:setAlpha(0.1)
				f29_arg0.Pattern:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.Pattern:registerEventHandler("transition_complete_keyframe", f32_local0)
			end
			f29_arg0.Pattern:completeAnimation()
			f29_arg0.Pattern:setAlpha(0.05)
			f29_local1(f29_arg0.Pattern)
		end,
	},
}
CoD.GameEndScoreRoundPip.__onClose = function(f34_arg0)
	f34_arg0.Glow:close()
	f34_arg0.Glow2:close()
	f34_arg0.SquarePip:close()
end
