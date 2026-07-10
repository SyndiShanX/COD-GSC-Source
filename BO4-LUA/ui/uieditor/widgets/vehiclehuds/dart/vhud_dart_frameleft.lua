require("x64:cc4bfb2bbbc1344")
CoD.vhud_dart_frameLeft = InheritFrom(LUI.UIElement)
CoD.vhud_dart_frameLeft.__defaultWidth = 391
CoD.vhud_dart_frameLeft.__defaultHeight = 484
CoD.vhud_dart_frameLeft.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_dart_frameLeft)
	self.id = "vhud_dart_frameLeft"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FrameGraphicLeft = LUI.UIImage.new(0, 0, 74, 110, 0, 0, 0, 484)
	FrameGraphicLeft:setAlpha(0.8)
	FrameGraphicLeft:setImage(RegisterImage(0xCCB3C262A05836A))
	FrameGraphicLeft:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	FrameGraphicLeft:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FrameGraphicLeft)
	self.FrameGraphicLeft = FrameGraphicLeft
	local FrameHlineLeft = LUI.UIImage.new(0, 0, 209, 391, 0, 0, 238, 246)
	FrameHlineLeft:setImage(RegisterImage(0x9F9F4F6492BE854))
	FrameHlineLeft:setMaterial(LUI.UIImage.GetCachedMaterial(0x2EEB1ECF1F211F5))
	FrameHlineLeft:setShaderVector(0, 0, 1, 0, 0)
	FrameHlineLeft:setShaderVector(1, 0, 0, 0, 0)
	FrameHlineLeft:setShaderVector(2, 0, 1, 0, 0)
	FrameHlineLeft:setShaderVector(3, 0, 0, 0, 0)
	FrameHlineLeft:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(FrameHlineLeft)
	self.FrameHlineLeft = FrameHlineLeft
	local FrameHlineLeft2 = LUI.UIImage.new(0, 0, 209, 391, 0, 0, 238, 246)
	FrameHlineLeft2:setImage(RegisterImage(0x9F9F4F6492BE854))
	FrameHlineLeft2:setMaterial(LUI.UIImage.GetCachedMaterial(0x2EEB1ECF1F211F5))
	FrameHlineLeft2:setShaderVector(0, 0, 1, 0, 0)
	FrameHlineLeft2:setShaderVector(1, 0, 0, 0, 0)
	FrameHlineLeft2:setShaderVector(2, 0, 1, 0, 0)
	FrameHlineLeft2:setShaderVector(3, 0, 0, 0, 0)
	FrameHlineLeft2:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(FrameHlineLeft2)
	self.FrameHlineLeft2 = FrameHlineLeft2
	local FrameBoxesLeft = LUI.UIImage.new(0, 0, 0, 74, 0, 0, 224, 260)
	FrameBoxesLeft:setRGB(0, 0, 0)
	FrameBoxesLeft:setAlpha(0.7)
	FrameBoxesLeft:setImage(RegisterImage(0xC6FA7184B0307E7))
	self:addElement(FrameBoxesLeft)
	self.FrameBoxesLeft = FrameBoxesLeft
	local FrameEngineLeft = LUI.UIImage.new(0, 0, 161, 201, 0, 0, 235, 281)
	FrameEngineLeft:setImage(RegisterImage(0x5338AA8246DD618))
	FrameEngineLeft:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	FrameEngineLeft:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(FrameEngineLeft)
	self.FrameEngineLeft = FrameEngineLeft
	local FrameBoxesLeftAdd = LUI.UIImage.new(0, 0, 0, 74, 0, 0, 224, 260)
	FrameBoxesLeftAdd:setAlpha(0)
	FrameBoxesLeftAdd:setImage(RegisterImage(0xC6FA7184B0307E7))
	FrameBoxesLeftAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	FrameBoxesLeftAdd:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(FrameBoxesLeftAdd)
	self.FrameBoxesLeftAdd = FrameBoxesLeftAdd
	local DotL = LUI.UIImage.new(0.5, 0.5, -53.5, -37.5, 0.5, 0.5, -6, 6)
	DotL:setImage(RegisterImage(0x99A8C3E368A2195))
	DotL:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(DotL)
	self.DotL = DotL
	local MeterBracketL = CoD.vhudHellstormFrameAltitude.new(f1_arg0, f1_arg1, 0, 0, 131, 151, 0.5, 0.5, -224, 226)
	self:addElement(MeterBracketL)
	self.MeterBracketL = MeterBracketL
	local StrokeL = LUI.UIImage.new(0.5, 0.5, 14.5, 194.5, 0.5, 0.5, -5.5, 22.5)
	StrokeL:setImage(RegisterImage(0xEFA29833AEF0480))
	StrokeL:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	StrokeL:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(StrokeL)
	self.StrokeL = StrokeL
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_dart_frameLeft.__resetProperties = function(f2_arg0)
	f2_arg0.StrokeL:completeAnimation()
	f2_arg0.FrameEngineLeft:completeAnimation()
	f2_arg0.StrokeL:setAlpha(1)
	f2_arg0.StrokeL:setShaderVector(0, 1, 0, 0, 0)
	f2_arg0.FrameEngineLeft:setAlpha(1)
	f2_arg0.FrameEngineLeft:setShaderVector(0, 2, 0, 0, 0)
end
CoD.vhud_dart_frameLeft.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							local f7_local0 = function(f8_arg0)
								local f8_local0 = function(f9_arg0)
									local f9_local0 = function(f10_arg0)
										local f10_local0 = function(f11_arg0)
											local f11_local0 = function(f12_arg0)
												local f12_local0 = function(f13_arg0)
													local f13_local0 = function(f14_arg0)
														f14_arg0:beginAnimation(19)
														f14_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
													end
													f13_arg0:beginAnimation(19)
													f13_arg0:setShaderVector(0, 1, 0, 0, 0)
													f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
												end
												f12_arg0:beginAnimation(20)
												f12_arg0:setShaderVector(0, 2.5, 0, 0, 0)
												f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
											end
											f11_arg0:beginAnimation(19)
											f11_arg0:setShaderVector(0, 1, 0, 0, 0)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
										end
										f10_arg0:beginAnimation(19)
										f10_arg0:setShaderVector(0, 2, 0, 0, 0)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(20)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(19)
								f8_arg0:setShaderVector(0, 1, 0, 0, 0)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(19)
							f7_arg0:setShaderVector(0, 2.5, 0, 0, 0)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(19)
						f6_arg0:setShaderVector(0, 1, 0, 0, 0)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(20)
					f5_arg0:setShaderVector(0, 2, 0, 0, 0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.FrameEngineLeft:beginAnimation(700)
				f3_arg0.FrameEngineLeft:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.FrameEngineLeft:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.FrameEngineLeft:completeAnimation()
			f3_arg0.FrameEngineLeft:setAlpha(1)
			f3_arg0.FrameEngineLeft:setShaderVector(0, 1, 0, 0, 0)
			f3_local0(f3_arg0.FrameEngineLeft)
			local f3_local1 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					f16_arg0:beginAnimation(100)
					f16_arg0:setAlpha(1)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.StrokeL:beginAnimation(700)
				f3_arg0.StrokeL:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.StrokeL:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f3_arg0.StrokeL:completeAnimation()
			f3_arg0.StrokeL:setAlpha(0)
			f3_arg0.StrokeL:setShaderVector(0, 1, 0, 0, 0)
			f3_local1(f3_arg0.StrokeL)
		end,
	},
}
CoD.vhud_dart_frameLeft.__onClose = function(f17_arg0)
	f17_arg0.MeterBracketL:close()
end
