CoD.GameEndScoreEnemyBacker = InheritFrom(LUI.UIElement)
CoD.GameEndScoreEnemyBacker.__defaultWidth = 960
CoD.GameEndScoreEnemyBacker.__defaultHeight = 168
CoD.GameEndScoreEnemyBacker.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameEndScoreEnemyBacker)
	self.id = "GameEndScoreEnemyBacker"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BgBlur = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 168)
	BgBlur:setZRot(180)
	BgBlur:setImage(RegisterImage(@"hash_7136CAB682831EF3"))
	BgBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BgBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BgBlur)
	self.BgBlur = BgBlur
	local BgTint = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 168)
	BgTint:setZRot(180)
	BgTint:setImage(RegisterImage(@"hash_7136CAB682831EF3"))
	self:addElement(BgTint)
	self.BgTint = BgTint
	local PixelGridTiledBacking = LUI.UIImage.new(0.02, 0.02, -16, 940, 0.31, 0.31, -44.5, 107.5)
	PixelGridTiledBacking:setAlpha(0.05)
	PixelGridTiledBacking:setImage(RegisterImage(@"uie_ui_hud_notifications_pixelpattern"))
	PixelGridTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	PixelGridTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking)
	self.PixelGridTiledBacking = PixelGridTiledBacking
	local BaseBacking = LUI.UIImage.new(0, 0, 265, 725, 0, 0, 36, 132)
	BaseBacking:setAlpha(0.4)
	BaseBacking:setImage(RegisterImage(@"hash_150D844945517BE"))
	self:addElement(BaseBacking)
	self.BaseBacking = BaseBacking
	local Base = LUI.UIImage.new(0, 0, 265, 725, 0, 0, 36, 132)
	Base:setAlpha(0.6)
	Base:setYRot(180)
	Base:setImage(RegisterImage(@"hash_63A7D3CD626132BD"))
	Base:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	Base:setShaderVector(0, 1, 0, 0, 0)
	Base:subscribeToGlobalModel(f1_arg1, "Factions", "axisFactionColor", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Base:setRGB(f2_local0)
		end
	end)
	self:addElement(Base)
	self.Base = Base
	local StripBase = LUI.UIImage.new(0, 0, 265, 725, 0, 0, 122, 130)
	StripBase:setAlpha(0.17)
	StripBase:setYRot(180)
	StripBase:setImage(RegisterImage(@"hash_BB009EEABED5079"))
	StripBase:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	StripBase:subscribeToGlobalModel(f1_arg1, "Factions", "axisFactionColor", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			StripBase:setRGB(f3_local0)
		end
	end)
	self:addElement(StripBase)
	self.StripBase = StripBase
	local StripGlow = LUI.UIImage.new(0, 0, 265, 725, 0, 0, 122, 130)
	StripGlow:setYRot(180)
	StripGlow:setImage(RegisterImage(@"hash_770FECC2924AE8EC"))
	StripGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	StripGlow:setShaderVector(0, 1, 0, 0, 0)
	StripGlow:subscribeToGlobalModel(f1_arg1, "Factions", "axisFactionColor", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			StripGlow:setRGB(f4_local0)
		end
	end)
	self:addElement(StripGlow)
	self.StripGlow = StripGlow
	local triangle = LUI.UIImage.new(0, 0, 897, 905, 0.5, 0.5, -7, 7)
	triangle:setRGB(0, 0, 0)
	triangle:setAlpha(0.94)
	triangle:setZRot(180)
	triangle:setImage(RegisterImage(@"uie_ui_hud_common_triangle"))
	self:addElement(triangle)
	self.triangle = triangle
	local FrameInnerTop = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 84)
	FrameInnerTop:setYRot(180)
	FrameInnerTop:setImage(RegisterImage(@"hash_4E4D07998F51061E"))
	self:addElement(FrameInnerTop)
	self.FrameInnerTop = FrameInnerTop
	local FrameInnerBot = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 84, 168)
	FrameInnerBot:setZRot(180)
	FrameInnerBot:setImage(RegisterImage(@"hash_4E4D07998F51061E"))
	self:addElement(FrameInnerBot)
	self.FrameInnerBot = FrameInnerBot
	local FrameOuterBot = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 157, 173)
	FrameOuterBot:setYRot(180)
	FrameOuterBot:setImage(RegisterImage(@"hash_59A6CE40ADA52B7F"))
	self:addElement(FrameOuterBot)
	self.FrameOuterBot = FrameOuterBot
	local FrameOuterTop = LUI.UIImage.new(0, 0, 0, 960, 0, 0, -3, 13)
	FrameOuterTop:setImage(RegisterImage(@"hash_615E16C12DDE7014"))
	self:addElement(FrameOuterTop)
	self.FrameOuterTop = FrameOuterTop
	local microtext = LUI.UIImage.new(0, 0, 915, 933, 0, 0, 3.5, 7.5)
	microtext:setAlpha(0.18)
	microtext:setZRot(180)
	microtext:setImage(RegisterImage(@"hash_116C3274D8031268"))
	self:addElement(microtext)
	self.microtext = microtext
	local microtext5 = LUI.UIImage.new(0, 0, 915, 933, 0, 0, 159.5, 163.5)
	microtext5:setAlpha(0.18)
	microtext5:setZRot(180)
	microtext5:setImage(RegisterImage(@"hash_116C3274D8031268"))
	self:addElement(microtext5)
	self.microtext5 = microtext5
	local microtext2 = LUI.UIImage.new(0, 0, 904, 922, 0, 0, 4, 8)
	microtext2:setAlpha(0.18)
	microtext2:setImage(RegisterImage(@"hash_116C3274D8031268"))
	microtext2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	microtext2:setShaderVector(0, 0, 0.38, 0, 0)
	microtext2:setShaderVector(1, 0, 0, 0, 0)
	microtext2:setShaderVector(2, 0, 1, 0, 0)
	microtext2:setShaderVector(3, 0, 0, 0, 0)
	microtext2:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(microtext2)
	self.microtext2 = microtext2
	local microtext6 = LUI.UIImage.new(0, 0, 904, 922, 0, 0, 160, 164)
	microtext6:setAlpha(0.18)
	microtext6:setImage(RegisterImage(@"hash_116C3274D8031268"))
	microtext6:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	microtext6:setShaderVector(0, 0, 0.38, 0, 0)
	microtext6:setShaderVector(1, 0, 0, 0, 0)
	microtext6:setShaderVector(2, 0, 1, 0, 0)
	microtext6:setShaderVector(3, 0, 0, 0, 0)
	microtext6:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(microtext6)
	self.microtext6 = microtext6
	local microtext3 = LUI.UIImage.new(0, 0, 201, 219, 0, 0, 4, 8)
	microtext3:setAlpha(0.18)
	microtext3:setZRot(180)
	microtext3:setImage(RegisterImage(@"hash_116C3274D8031268"))
	self:addElement(microtext3)
	self.microtext3 = microtext3
	local microtext7 = LUI.UIImage.new(0, 0, 201, 219, 0, 0, 160, 164)
	microtext7:setAlpha(0.18)
	microtext7:setZRot(180)
	microtext7:setImage(RegisterImage(@"hash_116C3274D8031268"))
	self:addElement(microtext7)
	self.microtext7 = microtext7
	local microtext4 = LUI.UIImage.new(0, 0, 192, 210, 0, 0, 4.5, 8.5)
	microtext4:setAlpha(0.18)
	microtext4:setImage(RegisterImage(@"hash_116C3274D8031268"))
	microtext4:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	microtext4:setShaderVector(0, 0, 0.38, 0, 0)
	microtext4:setShaderVector(1, 0, 0, 0, 0)
	microtext4:setShaderVector(2, 0, 1, 0, 0)
	microtext4:setShaderVector(3, 0, 0, 0, 0)
	microtext4:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(microtext4)
	self.microtext4 = microtext4
	local microtext8 = LUI.UIImage.new(0, 0, 192, 210, 0, 0, 160.5, 164.5)
	microtext8:setAlpha(0.18)
	microtext8:setImage(RegisterImage(@"hash_116C3274D8031268"))
	microtext8:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	microtext8:setShaderVector(0, 0, 0.38, 0, 0)
	microtext8:setShaderVector(1, 0, 0, 0, 0)
	microtext8:setShaderVector(2, 0, 1, 0, 0)
	microtext8:setShaderVector(3, 0, 0, 0, 0)
	microtext8:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(microtext8)
	self.microtext8 = microtext8
	local FrameLight = LUI.UIImage.new(0, 0, 948, 956, 0, 0, 74, 94)
	FrameLight:setYRot(180)
	FrameLight:setImage(RegisterImage(@"hash_7C25F7556E987B80"))
	FrameLight:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	FrameLight:setShaderVector(0, 1, 0, 0, 0)
	FrameLight:subscribeToGlobalModel(f1_arg1, "Factions", "axisFactionColor", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			FrameLight:setRGB(f5_local0)
		end
	end)
	self:addElement(FrameLight)
	self.FrameLight = FrameLight
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameEndScoreEnemyBacker.__resetProperties = function(f6_arg0)
	f6_arg0.Base:completeAnimation()
	f6_arg0.StripGlow:completeAnimation()
	f6_arg0.FrameLight:completeAnimation()
	f6_arg0.Base:setAlpha(0.6)
	f6_arg0.StripGlow:setAlpha(1)
	f6_arg0.StripGlow:setShaderVector(0, 1, 0, 0, 0)
	f6_arg0.FrameLight:setShaderVector(0, 1, 0, 0, 0)
end
CoD.GameEndScoreEnemyBacker.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(3)
			local f7_local0 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					f9_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f9_arg0:setAlpha(0.6)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f7_arg0.Base:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
				f7_arg0.Base:setAlpha(0.8)
				f7_arg0.Base:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Base:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f7_arg0.Base:completeAnimation()
			f7_arg0.Base:setAlpha(0.6)
			f7_local0(f7_arg0.Base)
			local f7_local1 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					f11_arg0:beginAnimation(1000)
					f11_arg0:setShaderVector(0, 1, 0, 0, 0)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f7_arg0.StripGlow:beginAnimation(1000)
				f7_arg0.StripGlow:setShaderVector(0, 2, 0, 0, 0)
				f7_arg0.StripGlow:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.StripGlow:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f7_arg0.StripGlow:completeAnimation()
			f7_arg0.StripGlow:setAlpha(1)
			f7_arg0.StripGlow:setShaderVector(0, 1, 0, 0, 0)
			f7_local1(f7_arg0.StripGlow)
			local f7_local2 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					local f13_local0 = function(f14_arg0)
						local f14_local0 = function(f15_arg0)
							local f15_local0 = function(f16_arg0)
								local f16_local0 = function(f17_arg0)
									f17_arg0:beginAnimation(600)
									f17_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
								end
								f16_arg0:beginAnimation(199, Enum[@"luitween"][@"luitween_ease_both"])
								f16_arg0:setShaderVector(0, 1, 0, 0, 0)
								f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
							end
							f15_arg0:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
							f15_arg0:setShaderVector(0, 2, 0, 0, 0)
							f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
						end
						f14_arg0:beginAnimation(600)
						f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
					end
					f13_arg0:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
					f13_arg0:setShaderVector(0, 1, 0, 0, 0)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
				end
				f7_arg0.FrameLight:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f7_arg0.FrameLight:setShaderVector(0, 2, 0, 0, 0)
				f7_arg0.FrameLight:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.FrameLight:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f7_arg0.FrameLight:completeAnimation()
			f7_arg0.FrameLight:setShaderVector(0, 1, 0, 0, 0)
			f7_local2(f7_arg0.FrameLight)
			f7_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.GameEndScoreEnemyBacker.__onClose = function(f18_arg0)
	f18_arg0.Base:close()
	f18_arg0.StripBase:close()
	f18_arg0.StripGlow:close()
	f18_arg0.FrameLight:close()
end
