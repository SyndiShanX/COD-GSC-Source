require("x64:5be072bd539a5e")
CoD.WZAAR_MeritProgressBar = InheritFrom(LUI.UIElement)
CoD.WZAAR_MeritProgressBar.__defaultWidth = 368
CoD.WZAAR_MeritProgressBar.__defaultHeight = 20
CoD.WZAAR_MeritProgressBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZAAR_MeritProgressBar)
	self.id = "WZAAR_MeritProgressBar"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LevelMeterBg = LUI.UIImage.new(0, 1, 0, 0, 0.5, 1.7, 3, -27)
	LevelMeterBg:setRGB(0, 0, 0)
	self:addElement(LevelMeterBg)
	self.LevelMeterBg = LevelMeterBg
	local FrontendFrame02 = LUI.UIImage.new(0, 1, -1, 1, 0, 1, 6, -6)
	FrontendFrame02:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	FrontendFrame02:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFrame02:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame02:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrame02)
	self.FrontendFrame02 = FrontendFrame02
	local FrontendFrameSelected = LUI.UIImage.new(0, 1, -1, 1, 0, 1, 5, -5)
	FrontendFrameSelected:setAlpha(0.3)
	FrontendFrameSelected:setImage(RegisterImage(@"uie_ui_menu_store_focus_frame"))
	FrontendFrameSelected:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFrameSelected:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrameSelected:setupNineSliceShader(4, 4)
	self:addElement(FrontendFrameSelected)
	self.FrontendFrameSelected = FrontendFrameSelected
	local EarnedXP = CoD.CommonWipeMeterWithGlow.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0.5, 1.7, -12, -12)
	EarnedXP:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	EarnedXP.Meter:setRGB(1, 0.63, 0)
	EarnedXP.Meter:setImage(RegisterImage(@"uie_ui_menu_aar_levelup_bar"))
	EarnedXP.Meter:setShaderVector(0, 0.75, 0, 0, 0)
	EarnedXP.MeterAdd:setRGB(0.79, 0.1, 0.1)
	EarnedXP.MeterAdd:setAlpha(0)
	EarnedXP.MeterAdd:setImage(RegisterImage(@"uie_ui_menu_aar_levelup_bar"))
	EarnedXP.MeterAdd:setShaderVector(0, 0.75, 0, 0, 0)
	EarnedXP.MeterGlow:setRGB(1, 0.63, 0)
	EarnedXP.MeterGlow:setImage(RegisterImage(@"uie_ui_menu_aar_levelup_bar_glow"))
	EarnedXP.MeterGlow:setShaderVector(0, 0.75, 0, 0, 0)
	self:addElement(EarnedXP)
	self.EarnedXP = EarnedXP
	local PreviousXP = CoD.CommonWipeMeterWithGlow.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0.6, 1.6, -8, -16)
	PreviousXP.Meter:setRGB(1, 0, 0)
	PreviousXP.Meter:setImage(RegisterImage(@"uie_ui_menu_aar_levelup_bar_wz_aar"))
	PreviousXP.MeterAdd:setAlpha(0)
	PreviousXP.MeterAdd:setImage(RegisterImage(@"uie_ui_menu_aar_levelup_bar_wz_aar"))
	PreviousXP.MeterGlow:setRGB(ColorSet.Orange.r, ColorSet.Orange.g, ColorSet.Orange.b)
	PreviousXP.MeterGlow:setAlpha(0.5)
	PreviousXP.MeterGlow:setImage(RegisterImage(@"uie_ui_menu_aar_levelup_bar_wz_aar"))
	PreviousXP:linkToElementModel(self, "previousXpProgress", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PreviousXP.Meter:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	PreviousXP:linkToElementModel(self, "previousXpProgress", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			PreviousXP.MeterAdd:setShaderVector(0, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4))
		end
	end)
	PreviousXP:linkToElementModel(self, "previousXpProgress", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			PreviousXP.MeterGlow:setShaderVector(0, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4))
		end
	end)
	self:addElement(PreviousXP)
	self.PreviousXP = PreviousXP
	local BGDotPatternLarge = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 6, -6)
	BGDotPatternLarge:setRGB(1, 0.73, 0)
	BGDotPatternLarge:setAlpha(0.2)
	BGDotPatternLarge:setImage(RegisterImage(@"hash_7FC21A8215EA012B"))
	BGDotPatternLarge:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	BGDotPatternLarge:setShaderVector(0, 0, 0, 0, 0)
	BGDotPatternLarge:setupNineSliceShader(4, 4)
	self:addElement(BGDotPatternLarge)
	self.BGDotPatternLarge = BGDotPatternLarge
	self:subscribeToGlobalModel(f1_arg1, "PerController", "hudItems.warzone.aarVisible", function(model)
		local f5_local0 = self
		if CoD.ModelUtility.IsControllerModelValueTrue(f1_arg1, "hudItems.warzone.aarVisible") then
			CoD.WZUtility.WZAARDelayThenAnimateProgress(self, f1_arg1, self.EarnedXP, 500)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZAAR_MeritProgressBar.__resetProperties = function(f6_arg0)
	f6_arg0.LevelMeterBg:completeAnimation()
	f6_arg0.LevelMeterBg:setAlpha(1)
end
CoD.WZAAR_MeritProgressBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.LevelMeterBg:completeAnimation()
			f8_arg0.LevelMeterBg:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.LevelMeterBg)
		end,
	},
	MaxRank = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.WZAAR_MeritProgressBar.__onClose = function(f10_arg0)
	f10_arg0.EarnedXP:close()
	f10_arg0.PreviousXP:close()
end
