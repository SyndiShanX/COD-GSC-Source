require("x64:9fc49de026d9299")
CoD[0x6E6DDD790C76F5E] = InheritFrom(LUI.UIElement)
CoD[0x6E6DDD790C76F5E].__defaultWidth = 720
CoD[0x6E6DDD790C76F5E].__defaultHeight = 180
CoD[0x6E6DDD790C76F5E].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[0x6E6DDD790C76F5E])
	self.id = "CallingCards_loot_CuteAnimals"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image0 = LUI.UIImage.new(0, 0, 0, 720, 0, 0, 0, 180)
	Image0:setImage(RegisterImage(0xA0922EE446FF0DC))
	self:addElement(Image0)
	self.Image0 = Image0
	local Image1 = LUI.UIImage.new(0, 0, 0, 720, 0, 0, 0, 180)
	Image1:setImage(RegisterImage(0xC88813FE9210D5A))
	self:addElement(Image1)
	self.Image1 = Image1
	local Image2 = LUI.UIImage.new(0, 0, 0, 720, 0, 0, 0, 180)
	Image2:setImage(RegisterImage(0x7BEA97DC20CDCA6))
	self:addElement(Image2)
	self.Image2 = Image2
	local Image20 = LUI.UIImage.new(0, 0, 0, 720, 0, 0, 0, 180)
	Image20:setAlpha(0)
	Image20:setImage(RegisterImage(0x5D694B0BBDACF7C))
	self:addElement(Image20)
	self.Image20 = Image20
	local CallingCardsGoldFrame = CoD.CallingCards_GoldFrame.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(CallingCardsGoldFrame)
	self.CallingCardsGoldFrame = CallingCardsGoldFrame
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[0x6E6DDD790C76F5E].__resetProperties = function(f2_arg0)
	f2_arg0.Image0:completeAnimation()
	f2_arg0.Image2:completeAnimation()
	f2_arg0.Image20:completeAnimation()
	f2_arg0.Image0:setRGB(1, 1, 1)
	f2_arg0.Image2:setScale(1, 1)
	f2_arg0.Image20:setAlpha(0)
	f2_arg0.Image20:setScale(1, 1)
end
CoD[0x6E6DDD790C76F5E].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:beginAnimation(360)
						f6_arg0:setRGB(1, 1, 1)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f5_arg0:beginAnimation(329)
					f5_arg0:setRGB(1, 0.61, 0.79)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.Image0:beginAnimation(310)
				f3_arg0.Image0:setRGB(0, 1, 0.59)
				f3_arg0.Image0:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Image0:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.Image0:completeAnimation()
			f3_arg0.Image0:setRGB(1, 1, 1)
			f3_local0(f3_arg0.Image0)
			local f3_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(690)
					f8_arg0:setScale(1, 1)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.Image2:beginAnimation(310)
				f3_arg0.Image2:setScale(1.1, 1.1)
				f3_arg0.Image2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Image2:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f3_arg0.Image2:completeAnimation()
			f3_arg0.Image2:setScale(1, 1)
			f3_local1(f3_arg0.Image2)
			local f3_local2 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					local f10_local0 = function(f11_arg0)
						local f11_local0 = function(f12_arg0)
							local f12_local0 = function(f13_arg0)
								local f13_local0 = function(f14_arg0)
									local f14_local0 = function(f15_arg0)
										local f15_local0 = function(f16_arg0)
											local f16_local0 = function(f17_arg0)
												f17_arg0:beginAnimation(50)
												f17_arg0:setScale(1, 1)
												f17_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
											end
											f16_arg0:beginAnimation(130)
											f16_arg0:setAlpha(0)
											f16_arg0:setScale(1.01, 1.01)
											f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
										end
										f15_arg0:beginAnimation(40)
										f15_arg0:setAlpha(1)
										f15_arg0:setScale(1.03, 1.03)
										f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
									end
									f14_arg0:beginAnimation(289)
									f14_arg0:setScale(1.03, 1.03)
									f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
								end
								f13_arg0:beginAnimation(90)
								f13_arg0:setAlpha(0)
								f13_arg0:setScale(1.07, 1.07)
								f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
							end
							f12_arg0:beginAnimation(39)
							f12_arg0:setAlpha(1)
							f12_arg0:setScale(1.09, 1.09)
							f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
						end
						f11_arg0:beginAnimation(50)
						f11_arg0:setAlpha(0)
						f11_arg0:setScale(1.09, 1.09)
						f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
					end
					f10_arg0:beginAnimation(60)
					f10_arg0:setAlpha(1)
					f10_arg0:setScale(1.1, 1.1)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
				end
				f3_arg0.Image20:beginAnimation(250)
				f3_arg0.Image20:setScale(1.08, 1.08)
				f3_arg0.Image20:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Image20:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f3_arg0.Image20:completeAnimation()
			f3_arg0.Image20:setAlpha(0)
			f3_arg0.Image20:setScale(1, 1)
			f3_local2(f3_arg0.Image20)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD[0x6E6DDD790C76F5E].__onClose = function(f18_arg0)
	f18_arg0.CallingCardsGoldFrame:close()
end
