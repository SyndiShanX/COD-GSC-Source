CoD.HUD_KeyPromptFrame_Ultimate = InheritFrom(LUI.UIElement)
CoD.HUD_KeyPromptFrame_Ultimate.__defaultWidth = 73
CoD.HUD_KeyPromptFrame_Ultimate.__defaultHeight = 52
CoD.HUD_KeyPromptFrame_Ultimate.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setUseCylinderMapping(true)
	self:setClass(CoD.HUD_KeyPromptFrame_Ultimate)
	self.id = "HUD_KeyPromptFrame_Ultimate"
	self.soundSet = "default"
	local UltimateBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	UltimateBlur:setImage(RegisterImage(0xD63841A71A238E7))
	UltimateBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	UltimateBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(UltimateBlur)
	self.UltimateBlur = UltimateBlur
	local UltimatePanel = LUI.UIImage.new(-0.02, 1.02, 0, 0, -0.04, 1.04, 0, 0)
	UltimatePanel:setRGB(0.11, 0.11, 0.11)
	UltimatePanel:setAlpha(0.88)
	UltimatePanel:setScale(0.96, 0.96)
	UltimatePanel:setImage(RegisterImage(0xD63841A71A238E7))
	self:addElement(UltimatePanel)
	self.UltimatePanel = UltimatePanel
	local UltimatePanel2 = LUI.UIImage.new(-0.02, 1.02, 0, 0, -0.04, 1.04, 0, 0)
	UltimatePanel2:setRGB(0, 0, 0)
	UltimatePanel2:setAlpha(0.85)
	UltimatePanel2:setScale(0.96, 0.96)
	UltimatePanel2:setImage(RegisterImage(0xD63841A71A238E7))
	UltimatePanel2:setMaterial(LUI.UIImage.GetCachedMaterial("uie_feather_edges"))
	UltimatePanel2:setShaderVector(0, 0, 0.96, 0, 0)
	self:addElement(UltimatePanel2)
	self.UltimatePanel2 = UltimatePanel2
	local UltimateLED = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	UltimateLED:setRGB(0, 0, 0)
	UltimateLED:setAlpha(0.3)
	UltimateLED:setScale(0.96, 0.96)
	UltimateLED:setImage(RegisterImage(0x45635678969B61E))
	self:addElement(UltimateLED)
	self.UltimateLED = UltimateLED
	local UltimateFrame = LUI.UIImage.new(-0.04, 1.04, 0, 0, -0.08, 1.08, -2, -2)
	UltimateFrame:setImage(RegisterImage(0xB17A13306BBF9A4))
	self:addElement(UltimateFrame)
	self.UltimateFrame = UltimateFrame
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
