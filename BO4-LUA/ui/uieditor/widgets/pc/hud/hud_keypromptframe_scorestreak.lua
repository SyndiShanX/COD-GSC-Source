CoD.HUD_KeyPromptFrame_ScoreStreak = InheritFrom(LUI.UIElement)
CoD.HUD_KeyPromptFrame_ScoreStreak.__defaultWidth = 77
CoD.HUD_KeyPromptFrame_ScoreStreak.__defaultHeight = 36
CoD.HUD_KeyPromptFrame_ScoreStreak.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HUD_KeyPromptFrame_ScoreStreak)
	self.id = "HUD_KeyPromptFrame_ScoreStreak"
	self.soundSet = "default"
	local ScoreStreakBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ScoreStreakBlur:setScale(0.95, 0.96)
	ScoreStreakBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	ScoreStreakBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(ScoreStreakBlur)
	self.ScoreStreakBlur = ScoreStreakBlur
	local ScoreStreakPanel = LUI.UIImage.new(0, 1, -1, -1, 0, 1, 0, 0)
	ScoreStreakPanel:setRGB(0.11, 0.11, 0.11)
	ScoreStreakPanel:setAlpha(0.88)
	ScoreStreakPanel:setScale(0.95, 0.96)
	ScoreStreakPanel:setMaterial(LUI.UIImage.GetCachedMaterial("uie_feather_edges"))
	ScoreStreakPanel:setShaderVector(0, 0.7, 0.05, 0, 0.05)
	self:addElement(ScoreStreakPanel)
	self.ScoreStreakPanel = ScoreStreakPanel
	local ScoreStreakLED = LUI.UIImage.new(0, 1, -1, -1, 0, 1, 0, 0)
	ScoreStreakLED:setRGB(0, 0, 0)
	ScoreStreakLED:setAlpha(0.5)
	ScoreStreakLED:setScale(0.95, 0.95)
	ScoreStreakLED:setImage(RegisterImage(0xC89391EC58A5A89))
	ScoreStreakLED:setMaterial(LUI.UIImage.GetCachedMaterial("uie_feather_edges"))
	ScoreStreakLED:setShaderVector(0, 0.7, 0.05, 0, 0.05)
	self:addElement(ScoreStreakLED)
	self.ScoreStreakLED = ScoreStreakLED
	local ScoreStreakFrame = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ScoreStreakFrame:setScale(1.22, 1.43)
	ScoreStreakFrame:setImage(RegisterImage(0x1675DD2BCF8BCBD))
	ScoreStreakFrame:setMaterial(LUI.UIImage.GetCachedMaterial("uie_feather_edges"))
	ScoreStreakFrame:setShaderVector(0, 0.7, 0.05, 0, 0.05)
	self:addElement(ScoreStreakFrame)
	self.ScoreStreakFrame = ScoreStreakFrame
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
