require("x64:a0123492fc86d33")
require("x64:c2f9487384df3fe")
require("x64:2614187a845d0b9")
CoD.MeritOverlayManualHeader = InheritFrom(LUI.UIElement)
CoD.MeritOverlayManualHeader.__defaultWidth = 1920
CoD.MeritOverlayManualHeader.__defaultHeight = 1080
CoD.MeritOverlayManualHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.MeritOverlayManualHeader)
	self.id = "MeritOverlayManualHeader"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BarMiddle = CoD.GameEndScore_HeaderBarMid.new(f1_arg0, f1_arg1, 0.5, 0.5, -829, 829, 0.5, 0.5, -441, -361)
	self:addElement(BarMiddle)
	self.BarMiddle = BarMiddle
	local BarLeft = CoD.GameEndScore_HeaderBarTip.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, -830, 0.5, 0.5, -441, -361)
	self:addElement(BarLeft)
	self.BarLeft = BarLeft
	local BarRight = CoD.GameEndScore_HeaderBarTip.new(f1_arg0, f1_arg1, 0.5, 0.5, 830, 960, 0.5, 0.5, -441, -361)
	BarRight:setYRot(180)
	self:addElement(BarRight)
	self.BarRight = BarRight
	local PlaceLabel = CoD.MeritReportHeaderText.new(f1_arg0, f1_arg1, 0, 0, 147, 763, 0, 0, 81.5, 201.5)
	PlaceLabel:linkToElementModel(self, nil, false, function(model)
		PlaceLabel:setModel(model, f1_arg1)
	end)
	self:addElement(PlaceLabel)
	self.PlaceLabel = PlaceLabel
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MeritOverlayManualHeader.__resetProperties = function(f3_arg0)
	f3_arg0.BarLeft:completeAnimation()
	f3_arg0.BarRight:completeAnimation()
	f3_arg0.BarMiddle:completeAnimation()
	f3_arg0.PlaceLabel:completeAnimation()
	f3_arg0.BarLeft:setLeftRight(0.5, 0.5, -960, -830)
	f3_arg0.BarLeft:setAlpha(1)
	f3_arg0.BarRight:setLeftRight(0.5, 0.5, 830, 960)
	f3_arg0.BarRight:setAlpha(1)
	f3_arg0.BarMiddle:setTopBottom(0.5, 0.5, -441, -361)
	f3_arg0.BarMiddle:setAlpha(1)
	f3_arg0.PlaceLabel:setAlpha(1)
end
CoD.MeritOverlayManualHeader.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(4)
			local f4_local0 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					local f6_local0 = function(f7_arg0)
						local f7_local0 = function(f8_arg0)
							local f8_local0 = function(f9_arg0)
								local f9_local0 = function(f10_arg0)
									local f10_local0 = function(f11_arg0)
										local f11_local0 = function(f12_arg0)
											local f12_local0 = function(f13_arg0)
												f13_arg0:beginAnimation(19)
												f13_arg0:setAlpha(1)
												f13_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
											end
											f12_arg0:beginAnimation(20)
											f12_arg0:setAlpha(0.2)
											f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
										end
										f11_arg0:beginAnimation(19)
										f11_arg0:setAlpha(1)
										f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
									end
									f10_arg0:beginAnimation(30)
									f10_arg0:setAlpha(0)
									f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
								end
								f9_arg0:beginAnimation(40)
								f9_arg0:setTopBottom(0.5, 0.5, -441, -361)
								f9_arg0:setAlpha(1)
								f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
							end
							f8_arg0:beginAnimation(49)
							f8_arg0:setTopBottom(0.5, 0.5, -431, -351)
							f8_arg0:setAlpha(0.85)
							f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
						end
						f7_arg0:beginAnimation(59)
						f7_arg0:setTopBottom(0.5, 0.5, -441, -361)
						f7_arg0:setAlpha(0.67)
						f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
					end
					f6_arg0:beginAnimation(120)
					f6_arg0:setTopBottom(0.5, 0.5, -421, -341)
					f6_arg0:setAlpha(0.44)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
				end
				f4_arg0.BarMiddle:beginAnimation(30)
				f4_arg0.BarMiddle:setTopBottom(0.5, 0.5, -671.4, -591.4)
				f4_arg0.BarMiddle:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.BarMiddle:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f4_arg0.BarMiddle:completeAnimation()
			f4_arg0.BarMiddle:setTopBottom(0.5, 0.5, -734, -654)
			f4_arg0.BarMiddle:setAlpha(0)
			f4_local0(f4_arg0.BarMiddle)
			local f4_local1 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					local f15_local0 = function(f16_arg0)
						local f16_local0 = function(f17_arg0)
							f17_arg0:beginAnimation(60)
							f17_arg0:setLeftRight(0.5, 0.5, -960, -830)
							f17_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
						end
						f16_arg0:beginAnimation(80)
						f16_arg0:setLeftRight(0.5, 0.5, -970, -840)
						f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
					end
					f15_arg0:beginAnimation(99)
					f15_arg0:setLeftRight(0.5, 0.5, -960, -830)
					f15_arg0:setAlpha(1)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
				end
				f4_arg0.BarLeft:beginAnimation(420)
				f4_arg0.BarLeft:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.BarLeft:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f4_arg0.BarLeft:completeAnimation()
			f4_arg0.BarLeft:setLeftRight(0.5, 0.5, -1090, -960)
			f4_arg0.BarLeft:setAlpha(0)
			f4_local1(f4_arg0.BarLeft)
			local f4_local2 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					local f19_local0 = function(f20_arg0)
						local f20_local0 = function(f21_arg0)
							f21_arg0:beginAnimation(60)
							f21_arg0:setLeftRight(0.5, 0.5, 830, 960)
							f21_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
						end
						f20_arg0:beginAnimation(80)
						f20_arg0:setLeftRight(0.5, 0.5, 840, 970)
						f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
					end
					f19_arg0:beginAnimation(99)
					f19_arg0:setLeftRight(0.5, 0.5, 830, 960)
					f19_arg0:setAlpha(1)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
				end
				f4_arg0.BarRight:beginAnimation(420)
				f4_arg0.BarRight:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.BarRight:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f4_arg0.BarRight:completeAnimation()
			f4_arg0.BarRight:setLeftRight(0.5, 0.5, 960, 1090)
			f4_arg0.BarRight:setAlpha(0)
			f4_local2(f4_arg0.BarRight)
			local f4_local3 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					f23_arg0:beginAnimation(199)
					f23_arg0:setAlpha(1)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
				end
				f4_arg0.PlaceLabel:beginAnimation(660)
				f4_arg0.PlaceLabel:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.PlaceLabel:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f4_arg0.PlaceLabel:completeAnimation()
			f4_arg0.PlaceLabel:setAlpha(0)
			f4_local3(f4_arg0.PlaceLabel)
		end,
	},
	NoIntro = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(4)
			f24_arg0.BarMiddle:completeAnimation()
			f24_arg0.BarMiddle:setTopBottom(0.5, 0.5, -441, -361)
			f24_arg0.BarMiddle:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.BarMiddle)
			f24_arg0.BarLeft:completeAnimation()
			f24_arg0.BarLeft:setLeftRight(0.5, 0.5, -960, -830)
			f24_arg0.BarLeft:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.BarLeft)
			f24_arg0.BarRight:completeAnimation()
			f24_arg0.BarRight:setLeftRight(0.5, 0.5, 830, 960)
			f24_arg0.BarRight:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.BarRight)
			f24_arg0.PlaceLabel:completeAnimation()
			f24_arg0.PlaceLabel:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.PlaceLabel)
		end,
	},
}
CoD.MeritOverlayManualHeader.__onClose = function(f25_arg0)
	f25_arg0.BarMiddle:close()
	f25_arg0.BarLeft:close()
	f25_arg0.BarRight:close()
	f25_arg0.PlaceLabel:close()
end
