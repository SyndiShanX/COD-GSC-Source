CoD.ScrStk_CombatEfficiencyScrollFX = InheritFrom(LUI.UIElement)
CoD.ScrStk_CombatEfficiencyScrollFX.__defaultWidth = 28
CoD.ScrStk_CombatEfficiencyScrollFX.__defaultHeight = 180
CoD.ScrStk_CombatEfficiencyScrollFX.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScrStk_CombatEfficiencyScrollFX)
	self.id = "ScrStk_CombatEfficiencyScrollFX"
	self.soundSet = "HUD"
	local Image1 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image1:setImage(RegisterImage(0xAF40AF7C36D2FD))
	Image1:setMaterial(LUI.UIImage.GetCachedMaterial(0xD8EA9FE9B0BCF75))
	Image1:setShaderVector(0, 1, 1, 0, 0)
	Image1:setShaderVector(1, 2.4, 0, 0, 0)
	self:addElement(Image1)
	self.Image1 = Image1
	local Image0 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image0:setImage(RegisterImage(0x478CD87D4EF3E51))
	self:addElement(Image0)
	self.Image0 = Image0
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
