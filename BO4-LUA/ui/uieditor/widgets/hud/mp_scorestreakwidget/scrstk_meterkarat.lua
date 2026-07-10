require("x64:cba35583c7c9038")
CoD.ScrStk_MeterKarat = InheritFrom(LUI.UIElement)
CoD.ScrStk_MeterKarat.__defaultWidth = 12
CoD.ScrStk_MeterKarat.__defaultHeight = 12
CoD.ScrStk_MeterKarat.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScrStk_MeterKarat)
	self.id = "ScrStk_MeterKarat"
	self.soundSet = "HUD"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FocusMeterFillWhite0 = LUI.UIImage.new(0.5, 0.5, -6, 6, 0.5, 0.5, -3, 3)
	FocusMeterFillWhite0:setImage(RegisterImage(0xF20585D14FA19A4))
	self:addElement(FocusMeterFillWhite0)
	self.FocusMeterFillWhite0 = FocusMeterFillWhite0
	local ScrStkMeterKaratInner0 = CoD.ScrStk_MeterKaratInner.new(f1_arg0, f1_arg1, 0.5, 0.5, -8, 10, 0.5, 0.5, -19, 21)
	ScrStkMeterKaratInner0:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(ScrStkMeterKaratInner0)
	self.ScrStkMeterKaratInner0 = ScrStkMeterKaratInner0
	local ScrStkMeterKaratInner00 = CoD.ScrStk_MeterKaratInner.new(f1_arg0, f1_arg1, 0.5, 0.5, -8, 10, 0.5, 0.5, -20, 20)
	ScrStkMeterKaratInner00:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(ScrStkMeterKaratInner00)
	self.ScrStkMeterKaratInner00 = ScrStkMeterKaratInner00
	local Image0 = LUI.UIImage.new(0.5, 0.5, -17, 19, 0.5, 0.5, -3, 3)
	Image0:setAlpha(0)
	Image0:setImage(RegisterImage(0x5BE416E17DAB33B))
	Image0:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Image0)
	self.Image0 = Image0
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScrStk_MeterKarat.__resetProperties = function(f2_arg0)
	f2_arg0.Image0:completeAnimation()
	f2_arg0.Image0:setLeftRight(0.5, 0.5, -17, 19)
	f2_arg0.Image0:setTopBottom(0.5, 0.5, -3, 3)
	f2_arg0.Image0:setAlpha(0)
end
CoD.ScrStk_MeterKarat.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		ScoreAdded = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			local f4_local0 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					local f6_local0 = function(f7_arg0)
						local f7_local0 = function(f8_arg0)
							f8_arg0:beginAnimation(410, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735])
							f8_arg0:setLeftRight(0.5, 0.5, -95, 103)
							f8_arg0:setTopBottom(0.5, 0.5, -3, 3)
							f8_arg0:setAlpha(0)
							f8_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
						end
						f7_arg0:beginAnimation(30)
						f7_arg0:setLeftRight(0.5, 0.5, -86.49, 88.81)
						f7_arg0:setTopBottom(0.5, 0.5, -5.13, 5.13)
						f7_arg0:setAlpha(1)
						f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
					end
					f6_arg0:beginAnimation(40)
					f6_arg0:setLeftRight(0.5, 0.5, -84.71, 85.85)
					f6_arg0:setTopBottom(0.5, 0.5, -5.57, 5.58)
					f6_arg0:setAlpha(0.49)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
				end
				f4_arg0.Image0:beginAnimation(30)
				f4_arg0.Image0:setLeftRight(0.5, 0.5, -83.31, 83.53)
				f4_arg0.Image0:setTopBottom(0.5, 0.5, -5.92, 5.92)
				f4_arg0.Image0:setAlpha(1)
				f4_arg0.Image0:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.Image0:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f4_arg0.Image0:completeAnimation()
			f4_arg0.Image0:setLeftRight(0.5, 0.5, -83, 83)
			f4_arg0.Image0:setTopBottom(0.5, 0.5, -6, 6)
			f4_arg0.Image0:setAlpha(0)
			f4_local0(f4_arg0.Image0)
		end,
	},
}
CoD.ScrStk_MeterKarat.__onClose = function(f9_arg0)
	f9_arg0.ScrStkMeterKaratInner0:close()
	f9_arg0.ScrStkMeterKaratInner00:close()
end
