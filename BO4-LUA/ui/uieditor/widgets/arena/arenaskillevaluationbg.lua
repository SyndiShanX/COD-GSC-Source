require("x64:c7393046816f760")
CoD.ArenaSkillEvaluationBg = InheritFrom(LUI.UIElement)
CoD.ArenaSkillEvaluationBg.__defaultWidth = 1202
CoD.ArenaSkillEvaluationBg.__defaultHeight = 602
CoD.ArenaSkillEvaluationBg.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaSkillEvaluationBg)
	self.id = "ArenaSkillEvaluationBg"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local BGDotPatternLarge = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGDotPatternLarge:setAlpha(0.05)
	BGDotPatternLarge:setImage(RegisterImage(@"hash_7FC21A8215EA012B"))
	BGDotPatternLarge:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	BGDotPatternLarge:setShaderVector(0, 0, 0, 0, 0)
	BGDotPatternLarge:setupNineSliceShader(4, 4)
	self:addElement(BGDotPatternLarge)
	self.BGDotPatternLarge = BGDotPatternLarge
	local AnalysingBackingL = LUI.UIImage.new(0, 0, 249, 1, 1, 1, -28, 0)
	AnalysingBackingL:setAlpha(0.1)
	AnalysingBackingL:setImage(RegisterImage(@"uie_ui_menu_inspection_analysing_stripe"))
	self:addElement(AnalysingBackingL)
	self.AnalysingBackingL = AnalysingBackingL
	local AnalysingBackingR = LUI.UIImage.new(1, 1, -248, 0, 1, 1, -28, 0)
	AnalysingBackingR:setAlpha(0.1)
	AnalysingBackingR:setImage(RegisterImage(@"uie_ui_menu_inspection_analysing_stripe"))
	self:addElement(AnalysingBackingR)
	self.AnalysingBackingR = AnalysingBackingR
	local AARLevelCommonBoxes = CoD.AARLevelCommonBoxes.new(f1_arg0, f1_arg1, 1, 1, -68, -20, 0, 0, 16, 29)
	AARLevelCommonBoxes:setAlpha(0.2)
	self:addElement(AARLevelCommonBoxes)
	self.AARLevelCommonBoxes = AARLevelCommonBoxes
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.05)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local TiledwhiteNoiseBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TiledwhiteNoiseBacking:setAlpha(0.02)
	TiledwhiteNoiseBacking:setImage(RegisterImage(@"uie_ui_menu_aar_repeat_white_bg"))
	TiledwhiteNoiseBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledwhiteNoiseBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledwhiteNoiseBacking:setupNineSliceShader(64, 64)
	self:addElement(TiledwhiteNoiseBacking)
	self.TiledwhiteNoiseBacking = TiledwhiteNoiseBacking
	local infoBracketBot = LUI.UIImage.new(0, 0, -0.5, 1202.5, 1, 1, -7, 1)
	infoBracketBot:setAlpha(0.2)
	infoBracketBot:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	infoBracketBot:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	infoBracketBot:setShaderVector(0, 0, 0, 0, 0)
	infoBracketBot:setupNineSliceShader(16, 4)
	self:addElement(infoBracketBot)
	self.infoBracketBot = infoBracketBot
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaSkillEvaluationBg.__onClose = function(f2_arg0)
	f2_arg0.AARLevelCommonBoxes:close()
end
