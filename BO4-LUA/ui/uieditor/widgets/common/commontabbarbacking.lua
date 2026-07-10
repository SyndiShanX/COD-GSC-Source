CoD.CommonTabBarBacking = InheritFrom(LUI.UIElement)
CoD.CommonTabBarBacking.__defaultWidth = 2304
CoD.CommonTabBarBacking.__defaultHeight = 37
CoD.CommonTabBarBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonTabBarBacking)
	self.id = "CommonTabBarBacking"
	self.soundSet = "default"
	local TabBackingBlur = LUI.UIImage.new(-2, 3, 0, 0, 0, 0, 0, 37)
	TabBackingBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	TabBackingBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(TabBackingBlur)
	self.TabBackingBlur = TabBackingBlur
	local TabBackingTint = LUI.UIImage.new(-2, 3, 0, 0, 0, 0, 0, 37)
	TabBackingTint:setRGB(0.05, 0.05, 0.05)
	TabBackingTint:setAlpha(0)
	self:addElement(TabBackingTint)
	self.TabBackingTint = TabBackingTint
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 37)
	NoiseTiledBacking:setAlpha(0.5)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local TabBottomLine = LUI.UIImage.new(0.5, 0.5, -960, 960, 0, 0, 34, 38)
	TabBottomLine:setAlpha(0.08)
	TabBottomLine:setImage(RegisterImage(0x5526CF3733E24C4))
	self:addElement(TabBottomLine)
	self.TabBottomLine = TabBottomLine
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local5 = self
	f1_local5 = TabBackingBlur
	if IsPC() then
		SizeToWidthOfScreen(f1_local5, f1_arg1)
	end
	f1_local5 = TabBackingTint
	if IsPC() then
		SizeToWidthOfScreen(f1_local5, f1_arg1)
	end
	f1_local5 = NoiseTiledBacking
	if IsPC() then
		SizeToWidthOfScreen(f1_local5, f1_arg1)
	end
	f1_local5 = TabBottomLine
	if IsPC() then
		SizeToWidthOfScreen(f1_local5, f1_arg1)
	end
	return self
end
CoD.CommonTabBarBacking.__onClose = function(f2_arg0)
	f2_arg0.TabBackingBlur:close()
	f2_arg0.TabBackingTint:close()
	f2_arg0.NoiseTiledBacking:close()
	f2_arg0.TabBottomLine:close()
end
