require("x64:2d64ca9d3c705ce")
require("x64:c9a3c9eb5d5ac59")
CoD.ReservesButtonLayoutBacking = InheritFrom(LUI.UIElement)
CoD.ReservesButtonLayoutBacking.__defaultWidth = 750
CoD.ReservesButtonLayoutBacking.__defaultHeight = 528
CoD.ReservesButtonLayoutBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReservesButtonLayoutBacking)
	self.id = "ReservesButtonLayoutBacking"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local Blur = LUI.UIImage.new(0.03, 0.97, 0, 0, 0.5, 0.5, -243, 243)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local Backer = LUI.UIImage.new(0.03, 0.97, 0, 0, 0.5, 0.5, -243, 243)
	Backer:setRGB(0.67, 0.67, 0.67)
	Backer:setAlpha(0.02)
	self:addElement(Backer)
	self.Backer = Backer
	local TiledBacking = LUI.UIImage.new(0.03, 0.97, 0, 0, 0.5, 0.5, -243, 243)
	TiledBacking:setAlpha(0.12)
	TiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	TiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking:setupNineSliceShader(196, 88)
	self:addElement(TiledBacking)
	self.TiledBacking = TiledBacking
	local FramingCornerBrackets2 = CoD.CommonCornerBrackets01.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0.5, 0.5, -264, 264)
	FramingCornerBrackets2:setAlpha(0.1)
	self:addElement(FramingCornerBrackets2)
	self.FramingCornerBrackets2 = FramingCornerBrackets2
	local CommonSearchingBar = CoD.CommonSearchingBar.new(f1_arg0, f1_arg1, 0, 0, 4.5, 126.5, 0.5, 0.5, -260.5, -238.5)
	CommonSearchingBar:setAlpha(0.2)
	self:addElement(CommonSearchingBar)
	self.CommonSearchingBar = CommonSearchingBar
	local DotLineBottom = LUI.UIImage.new(0.02, 0.98, 0, 0, 0.5, 0.5, 241, 245)
	DotLineBottom:setAlpha(0.4)
	DotLineBottom:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline"))
	DotLineBottom:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	DotLineBottom:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(DotLineBottom)
	self.DotLineBottom = DotLineBottom
	local DotLineTop = LUI.UIImage.new(0.02, 0.98, 0, 0, 0.5, 0.5, -245, -241)
	DotLineTop:setAlpha(0.4)
	DotLineTop:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline"))
	DotLineTop:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	DotLineTop:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(DotLineTop)
	self.DotLineTop = DotLineTop
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ReservesButtonLayoutBacking.__onClose = function(f2_arg0)
	f2_arg0.FramingCornerBrackets2:close()
	f2_arg0.CommonSearchingBar:close()
end
