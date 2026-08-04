CoD.HUD_KeyPromptFrame = InheritFrom(LUI.UIElement)
CoD.HUD_KeyPromptFrame.__defaultWidth = 65
CoD.HUD_KeyPromptFrame.__defaultHeight = 36
CoD.HUD_KeyPromptFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HUD_KeyPromptFrame)
	self.id = "HUD_KeyPromptFrame"
	self.soundSet = "default"
	local AbilityBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	AbilityBlur:setScale(0.96, 0.96)
	AbilityBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	AbilityBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(AbilityBlur)
	self.AbilityBlur = AbilityBlur
	local AbilityPanel = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	AbilityPanel:setRGB(0.11, 0.11, 0.11)
	AbilityPanel:setAlpha(0.88)
	AbilityPanel:setScale(0.94, 0.94)
	self:addElement(AbilityPanel)
	self.AbilityPanel = AbilityPanel
	local AbilityLED = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	AbilityLED:setRGB(0, 0, 0)
	AbilityLED:setAlpha(0.3)
	AbilityLED:setScale(0.98, 0.88)
	AbilityLED:setImage(RegisterImage(0xC89391EC58A5A89))
	self:addElement(AbilityLED)
	self.AbilityLED = AbilityLED
	local AbilityFrame = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	AbilityFrame:setScale(1.2, 1.5)
	AbilityFrame:setImage(RegisterImage(0xEDA1CE2141038BA))
	self:addElement(AbilityFrame)
	self.AbilityFrame = AbilityFrame
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
