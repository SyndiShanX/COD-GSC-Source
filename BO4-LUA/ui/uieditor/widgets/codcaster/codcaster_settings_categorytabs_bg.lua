CoD.CodCaster_Settings_CategoryTabs_BG = InheritFrom(LUI.UIElement)
CoD.CodCaster_Settings_CategoryTabs_BG.__defaultWidth = 1050
CoD.CodCaster_Settings_CategoryTabs_BG.__defaultHeight = 37
CoD.CodCaster_Settings_CategoryTabs_BG.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCaster_Settings_CategoryTabs_BG)
	self.id = "CodCaster_Settings_CategoryTabs_BG"
	self.soundSet = "default"
	local NoiseTiledBacking = LUI.UIImage.new(0.5, 0.5, -525, 525, 0.5, 0.5, -18.5, 18.5)
	NoiseTiledBacking:setAlpha(0.5)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local TabBackingTint = LUI.UIImage.new(0.5, 0.5, -410, 410, 0, 0, 0, 37)
	TabBackingTint:setRGB(0.05, 0.05, 0.05)
	TabBackingTint:setAlpha(0)
	self:addElement(TabBackingTint)
	self.TabBackingTint = TabBackingTint
	local TabBottomLine = LUI.UIImage.new(0.5, 0.5, -410, 410, 0, 0, 34, 38)
	TabBottomLine:setAlpha(0.08)
	TabBottomLine:setImage(RegisterImage(0x5526CF3733E24C4))
	self:addElement(TabBottomLine)
	self.TabBottomLine = TabBottomLine
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
