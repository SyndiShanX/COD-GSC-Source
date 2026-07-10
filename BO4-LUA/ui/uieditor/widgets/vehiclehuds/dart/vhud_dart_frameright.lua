require("x64:cc4bfb2bbbc1344")
CoD.vhud_dart_frameRight = InheritFrom(LUI.UIElement)
CoD.vhud_dart_frameRight.__defaultWidth = 391
CoD.vhud_dart_frameRight.__defaultHeight = 484
CoD.vhud_dart_frameRight.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_dart_frameRight)
	self.id = "vhud_dart_frameRight"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DotR = LUI.UIImage.new(0.5, 0.5, 53.5, 37.5, 0.5, 0.5, -6, 6)
	DotR:setImage(RegisterImage(0x99A8C3E368A2195))
	DotR:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(DotR)
	self.DotR = DotR
	local FrameBoxesLeft = LUI.UIImage.new(0, 0, 390.5, 316.5, 0, 0, 224, 260)
	FrameBoxesLeft:setRGB(0, 0, 0)
	FrameBoxesLeft:setAlpha(0.7)
	FrameBoxesLeft:setImage(RegisterImage(0xC6FA7184B0307E7))
	self:addElement(FrameBoxesLeft)
	self.FrameBoxesLeft = FrameBoxesLeft
	local FrameBoxesLeftAdd = LUI.UIImage.new(0, 0, 390.5, 316.5, 0, 0, 224, 260)
	FrameBoxesLeftAdd:setAlpha(0)
	FrameBoxesLeftAdd:setImage(RegisterImage(0xC6FA7184B0307E7))
	FrameBoxesLeftAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	FrameBoxesLeftAdd:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(FrameBoxesLeftAdd)
	self.FrameBoxesLeftAdd = FrameBoxesLeftAdd
	local FrameEngineLeft = LUI.UIImage.new(0, 0, 229, 189, 0, 0, 236, 282)
	FrameEngineLeft:setImage(RegisterImage(0x5338AA8246DD618))
	FrameEngineLeft:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	FrameEngineLeft:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(FrameEngineLeft)
	self.FrameEngineLeft = FrameEngineLeft
	local FrameHlineLeft = LUI.UIImage.new(0, 0, 182, 0, 0, 0, 238, 246)
	FrameHlineLeft:setImage(RegisterImage(0x9F9F4F6492BE854))
	FrameHlineLeft:setMaterial(LUI.UIImage.GetCachedMaterial(0x2EEB1ECF1F211F5))
	FrameHlineLeft:setShaderVector(0, 0, 1, 0, 0)
	FrameHlineLeft:setShaderVector(1, 0, 0, 0, 0)
	FrameHlineLeft:setShaderVector(2, 0, 1, 0, 0)
	FrameHlineLeft:setShaderVector(3, 0, 0, 0, 0)
	FrameHlineLeft:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(FrameHlineLeft)
	self.FrameHlineLeft = FrameHlineLeft
	local FrameHlineLeft2 = LUI.UIImage.new(0, 0, 182, 0, 0, 0, 238, 246)
	FrameHlineLeft2:setImage(RegisterImage(0x9F9F4F6492BE854))
	FrameHlineLeft2:setMaterial(LUI.UIImage.GetCachedMaterial(0x2EEB1ECF1F211F5))
	FrameHlineLeft2:setShaderVector(0, 0, 1, 0, 0)
	FrameHlineLeft2:setShaderVector(1, 0, 0, 0, 0)
	FrameHlineLeft2:setShaderVector(2, 0, 1, 0, 0)
	FrameHlineLeft2:setShaderVector(3, 0, 0, 0, 0)
	FrameHlineLeft2:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(FrameHlineLeft2)
	self.FrameHlineLeft2 = FrameHlineLeft2
	local FrameGraphicLeft = LUI.UIImage.new(0, 0, 316.5, 280.5, 0, 0, 0, 484)
	FrameGraphicLeft:setAlpha(0.8)
	FrameGraphicLeft:setImage(RegisterImage(0xCCB3C262A05836A))
	FrameGraphicLeft:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	FrameGraphicLeft:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FrameGraphicLeft)
	self.FrameGraphicLeft = FrameGraphicLeft
	local MeterBracketR = CoD.vhudHellstormFrameAltitude.new(f1_arg0, f1_arg1, 0, 0, 239, 259, 0.5, 0.5, -224, 226)
	MeterBracketR:setYRot(180)
	self:addElement(MeterBracketR)
	self.MeterBracketR = MeterBracketR
	local StrokeR = LUI.UIImage.new(0.5, 0.5, -194.5, -14.5, 0.5, 0.5, -5, 23)
	StrokeR:setImage(RegisterImage(0xEFA29833AEF0480))
	StrokeR:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	StrokeR:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(StrokeR)
	self.StrokeR = StrokeR
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_dart_frameRight.__resetProperties = function(f2_arg0)
	f2_arg0.StrokeR:completeAnimation()
	f2_arg0.FrameEngineLeft:completeAnimation()
	f2_arg0.StrokeR:setAlpha(1)
	f2_arg0.StrokeR:setShaderVector(0, 1, 0, 0, 0)
	f2_arg0.FrameEngineLeft:setAlpha(1)
	f2_arg0.FrameEngineLeft:setShaderVector(0, 2, 0, 0, 0)
end
CoD.vhud_dart_frameRight.__clipsPerState = {
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
														local f14_local0 = function(f15_arg0)
															local f15_local0 = function(f16_arg0)
																f16_arg0:beginAnimation(19)
																f16_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
															end
															f15_arg0:beginAnimation(19)
															f15_arg0:setShaderVector(0, 1, 0, 0, 0)
															f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
														end
														f14_arg0:beginAnimation(20)
														f14_arg0:setShaderVector(0, 2.5, 0, 0, 0)
														f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
													end
													f13_arg0:beginAnimation(19)
													f13_arg0:setShaderVector(0, 1, 0, 0, 0)
													f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
												end
												f12_arg0:beginAnimation(0)
												f12_arg0:setShaderVector(0, 2, 0, 0, 0)
												f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
											end
											f11_arg0:beginAnimation(19)
											f11_arg0:setShaderVector(0, 2, 0, 0, 0)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
										end
										f10_arg0:beginAnimation(20)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(19)
									f9_arg0:setShaderVector(0, 1, 0, 0, 0)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(19)
								f8_arg0:setShaderVector(0, 2.5, 0, 0, 0)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(19)
							f7_arg0:setShaderVector(0, 1, 0, 0, 0)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(20)
						f6_arg0:setShaderVector(0, 2, 0, 0, 0)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(399)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.FrameEngineLeft:beginAnimation(300)
				f3_arg0.FrameEngineLeft:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.FrameEngineLeft:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.FrameEngineLeft:completeAnimation()
			f3_arg0.FrameEngineLeft:setAlpha(1)
			f3_arg0.FrameEngineLeft:setShaderVector(0, 1, 0, 0, 0)
			f3_local0(f3_arg0.FrameEngineLeft)
			local f3_local1 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					local f18_local0 = function(f19_arg0)
						f19_arg0:beginAnimation(100)
						f19_arg0:setAlpha(1)
						f19_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f18_arg0:beginAnimation(399)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
				end
				f3_arg0.StrokeR:beginAnimation(300)
				f3_arg0.StrokeR:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.StrokeR:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f3_arg0.StrokeR:completeAnimation()
			f3_arg0.StrokeR:setAlpha(0)
			f3_arg0.StrokeR:setShaderVector(0, 1, 0, 0, 0)
			f3_local1(f3_arg0.StrokeR)
		end,
	},
}
CoD.vhud_dart_frameRight.__onClose = function(f20_arg0)
	f20_arg0.MeterBracketR:close()
end
