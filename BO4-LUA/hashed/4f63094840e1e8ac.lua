require("x64:5be072bd539a5e")
CoD.ButtonFrame_XPMeterInfo = InheritFrom(LUI.UIElement)
CoD.ButtonFrame_XPMeterInfo.__defaultWidth = 500
CoD.ButtonFrame_XPMeterInfo.__defaultHeight = 51
CoD.ButtonFrame_XPMeterInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ButtonFrame_XPMeterInfo)
	self.id = "ButtonFrame_XPMeterInfo"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LevelMeterBgTint = LUI.UIImage.new(0, 1, 0, -54, 0.5, 0.5, -7.5, 0.5)
	LevelMeterBgTint:setRGB(0.92, 0.92, 0.92)
	LevelMeterBgTint:setAlpha(0.05)
	self:addElement(LevelMeterBgTint)
	self.LevelMeterBgTint = LevelMeterBgTint
	local LevelMeterBg = LUI.UIImage.new(0, 1, -2, -54, 0.5, 0.5, -12.5, 5.5)
	LevelMeterBg:setImage(RegisterImage(0x61E8EB53DFEF82B))
	LevelMeterBg:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	LevelMeterBg:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(LevelMeterBg)
	self.LevelMeterBg = LevelMeterBg
	local CurrentXPMeter = CoD.CommonWipeMeterWithGlow.new(f1_arg0, f1_arg1, 0, 1, 0, -56, 0, 0, 16, 28)
	CurrentXPMeter.Meter:setRGB(1, 0.73, 0)
	CurrentXPMeter.Meter:setImage(RegisterImage(0x6D2FBF31F53910C))
	CurrentXPMeter.Meter:setShaderVector(0, 0.25, 0, 0, 0)
	CurrentXPMeter.MeterAdd:setAlpha(0.3)
	CurrentXPMeter.MeterAdd:setImage(RegisterImage(0x6D2FBF31F53910C))
	CurrentXPMeter.MeterGlow:setRGB(0.39, 0.18, 0)
	CurrentXPMeter.MeterGlow:setImage(RegisterImage(0xA7D61A3302B55D0))
	CurrentXPMeter.MeterGlow:setShaderVector(0, 0.25, 0, 0, 0)
	self:addElement(CurrentXPMeter)
	self.CurrentXPMeter = CurrentXPMeter
	local CurrentXPText = LUI.UIText.new(0, 0, 0, 110, 0, 0, 29.5, 50.5)
	CurrentXPText:setText("")
	CurrentXPText:setTTF("ttmussels_demibold")
	CurrentXPText:setLetterSpacing(1)
	CurrentXPText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(CurrentXPText)
	self.CurrentXPText = CurrentXPText
	local NeededXPText = LUI.UIText.new(1, 1, -167, -57, 0, 0, 29.5, 50.5)
	NeededXPText:setRGB(0.92, 0.92, 0.92)
	NeededXPText:setText("")
	NeededXPText:setTTF("ttmussels_demibold")
	NeededXPText:setLetterSpacing(1)
	NeededXPText:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	self:addElement(NeededXPText)
	self.NeededXPText = NeededXPText
	local RankIcon = LUI.UIImage.new(1, 1, -48, 0, 0, 0, -2, 46)
	self:addElement(RankIcon)
	self.RankIcon = RankIcon
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ButtonFrame_XPMeterInfo.__resetProperties = function(f2_arg0)
	f2_arg0.CurrentXPMeter:completeAnimation()
	f2_arg0.CurrentXPText:completeAnimation()
	f2_arg0.NeededXPText:completeAnimation()
	f2_arg0.CurrentXPMeter:setRGB(1, 1, 1)
	f2_arg0.CurrentXPMeter.Meter:setRGB(1, 0.73, 0)
	f2_arg0.CurrentXPMeter.MeterGlow:setRGB(0.39, 0.18, 0)
	f2_arg0.CurrentXPText:setRGB(1, 1, 1)
	f2_arg0.CurrentXPText:setAlpha(1)
	f2_arg0.NeededXPText:setRGB(0.92, 0.92, 0.92)
end
CoD.ButtonFrame_XPMeterInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			f3_arg0.CurrentXPMeter:completeAnimation()
			f3_arg0.CurrentXPMeter.Meter:completeAnimation()
			f3_arg0.CurrentXPMeter.MeterGlow:completeAnimation()
			f3_arg0.CurrentXPMeter.Meter:setRGB(ColorSet.Orange.r, ColorSet.Orange.g, ColorSet.Orange.b)
			f3_arg0.CurrentXPMeter.MeterGlow:setRGB(ColorSet.Orange.r, ColorSet.Orange.g, ColorSet.Orange.b)
			f3_arg0.clipFinished(f3_arg0.CurrentXPMeter)
			f3_arg0.CurrentXPText:completeAnimation()
			f3_arg0.CurrentXPText:setRGB(0.69, 0.56, 0.04)
			f3_arg0.clipFinished(f3_arg0.CurrentXPText)
			f3_arg0.NeededXPText:completeAnimation()
			f3_arg0.NeededXPText:setRGB(0.92, 0.92, 0.92)
			f3_arg0.clipFinished(f3_arg0.NeededXPText)
		end,
	},
	Prestige = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(3)
			f4_arg0.CurrentXPMeter:completeAnimation()
			f4_arg0.CurrentXPMeter.Meter:completeAnimation()
			f4_arg0.CurrentXPMeter.MeterGlow:completeAnimation()
			f4_arg0.CurrentXPMeter:setRGB(1, 1, 1)
			f4_arg0.CurrentXPMeter.Meter:setRGB(0.23, 0.51, 0.68)
			f4_arg0.CurrentXPMeter.MeterGlow:setRGB(0.05, 0.25, 0.36)
			f4_arg0.clipFinished(f4_arg0.CurrentXPMeter)
			f4_arg0.CurrentXPText:completeAnimation()
			f4_arg0.CurrentXPText:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.CurrentXPText)
			f4_arg0.NeededXPText:completeAnimation()
			f4_arg0.NeededXPText:setRGB(0.35, 0.52, 0.62)
			f4_arg0.clipFinished(f4_arg0.NeededXPText)
		end,
	},
}
CoD.ButtonFrame_XPMeterInfo.__onClose = function(f5_arg0)
	f5_arg0.CurrentXPMeter:close()
end
