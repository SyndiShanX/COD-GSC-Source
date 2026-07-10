require("x64:acbf06924421e35")
CoD.CommonBackingWithBrackets = InheritFrom(LUI.UIElement)
CoD.CommonBackingWithBrackets.__defaultWidth = 200
CoD.CommonBackingWithBrackets.__defaultHeight = 100
CoD.CommonBackingWithBrackets.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonBackingWithBrackets)
	self.id = "CommonBackingWithBrackets"
	self.soundSet = "none"
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local CommonCornerPips = CoD.CommonCornerPips01.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(CommonCornerPips)
	self.CommonCornerPips = CommonCornerPips
	local BGDotPatternLarge = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGDotPatternLarge:setAlpha(0.02)
	BGDotPatternLarge:setImage(RegisterImage(@"hash_7FC21A8215EA012B"))
	BGDotPatternLarge:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	BGDotPatternLarge:setShaderVector(0, 0, 0, 0, 0)
	BGDotPatternLarge:setupNineSliceShader(4, 4)
	self:addElement(BGDotPatternLarge)
	self.BGDotPatternLarge = BGDotPatternLarge
	local FrameBorder = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrameBorder:setAlpha(0.05)
	FrameBorder:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	FrameBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrameBorder:setShaderVector(0, 0, 0, 0, 0)
	FrameBorder:setupNineSliceShader(12, 12)
	self:addElement(FrameBorder)
	self.FrameBorder = FrameBorder
	local infoBracketTop = LUI.UIImage.new(0, 1, -1, 1, 0, 0, -1, 7)
	infoBracketTop:setAlpha(0.08)
	infoBracketTop:setZRot(180)
	infoBracketTop:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	infoBracketTop:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	infoBracketTop:setShaderVector(0, 0, 0, 0, 0)
	infoBracketTop:setupNineSliceShader(16, 4)
	self:addElement(infoBracketTop)
	self.infoBracketTop = infoBracketTop
	local infoBracketBot = LUI.UIImage.new(0, 1, -1, 1, 1, 1, -7, 1)
	infoBracketBot:setAlpha(0.08)
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
CoD.CommonBackingWithBrackets.__onClose = function(f2_arg0)
	f2_arg0.CommonCornerPips:close()
end
