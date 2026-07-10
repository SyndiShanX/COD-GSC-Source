require("x64:62eee6f7ab7e3b3")
CoD.zm_red_challenges_widget_internal = InheritFrom(LUI.UIElement)
CoD.zm_red_challenges_widget_internal.__defaultWidth = 360
CoD.zm_red_challenges_widget_internal.__defaultHeight = 100
CoD.zm_red_challenges_widget_internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.zm_red_challenges_widget_internal)
	self.id = "zm_red_challenges_widget_internal"
	self.soundSet = "none"
	local SceneBlur = LUI.UIImage.new(-0.03, 1.03, 0, 0, 0, 1, 0, 0)
	SceneBlur:setRGB(0, 0, 0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_381EEB1F96D4BE0A"))
	SceneBlur:setShaderVector(0, 0, 0.6, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local SolidBase = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SolidBase:setRGB(0, 0, 0)
	SolidBase:setAlpha(0.5)
	self:addElement(SolidBase)
	self.SolidBase = SolidBase
	local BaseGradientL = LUI.UIImage.new(-0.03, 0.5, 0, 0, 0, 1, 0, 0)
	BaseGradientL:setRGB(0, 0, 0)
	BaseGradientL:setAlpha(0.1)
	BaseGradientL:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_gradient_normal"))
	BaseGradientL:setShaderVector(0, 0, 0, 0, 15)
	BaseGradientL:setShaderVector(1, 0, 0, 0, 0)
	BaseGradientL:setShaderVector(2, 0.5, 0, 0, 0)
	self:addElement(BaseGradientL)
	self.BaseGradientL = BaseGradientL
	local BaseGradientR = LUI.UIImage.new(0.5, 1.03, 0, 0, 0, 1, 0, 0)
	BaseGradientR:setRGB(0, 0, 0)
	BaseGradientR:setAlpha(0.1)
	BaseGradientR:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_gradient_normal"))
	BaseGradientR:setShaderVector(0, 0, 0, 0, 0)
	BaseGradientR:setShaderVector(1, 0, 0, 0, 15)
	BaseGradientR:setShaderVector(2, 0.5, 0, 0, 0)
	self:addElement(BaseGradientR)
	self.BaseGradientR = BaseGradientR
	local TextureMid = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TextureMid:setAlpha(0.8)
	TextureMid:setImage(RegisterImage(@"uie_zm_hud_inventory_backing_mid"))
	TextureMid:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1A02C44161370F6D"))
	TextureMid:setShaderVector(0, 1, 0, 0, 0)
	TextureMid:setShaderVector(1, 1, 0, 0, 0)
	TextureMid:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(TextureMid)
	self.TextureMid = TextureMid
	local Tip = CoD.ZMInventoryListBackingInternalTip.new(f1_arg0, f1_arg1, 0, 0, -100, 0, 0, 1, 0, 0)
	self:addElement(Tip)
	self.Tip = Tip
	local End = CoD.ZMInventoryListBackingInternalTip.new(f1_arg0, f1_arg1, 1, 1, 0, 100, 0, 1, 0, 0)
	End:setYRot(180)
	self:addElement(End)
	self.End = End
	local f1_local8 = nil
	self.CenterFade = LUI.UIElement.createFake()
	local CenterFadePC = nil
	CenterFadePC = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	CenterFadePC:setRGB(0, 0, 0)
	CenterFadePC:setAlpha(0)
	CenterFadePC:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_edges"))
	CenterFadePC:setShaderVector(0, 0.05, 0, 0.05, 0)
	self:addElement(CenterFadePC)
	self.CenterFadePC = CenterFadePC
	local DecoL = LUI.UIImage.new(0, 0, -110, 0, 0, 1, -21, 21)
	DecoL:setImage(RegisterImage(@"uie_zm_hud_inventory_framearrow"))
	self:addElement(DecoL)
	self.DecoL = DecoL
	local DecoR = LUI.UIImage.new(1, 1, 0, 110, 0, 1, -21, 21)
	DecoR:setXRot(180)
	DecoR:setZRot(180)
	DecoR:setImage(RegisterImage(@"uie_zm_hud_inventory_framearrow"))
	self:addElement(DecoR)
	self.DecoR = DecoR
	local CenterFrame = LUI.UIImage.new(0.5, 0.5, -90.5, 90.5, 0, 0, -25, 31)
	CenterFrame:setAlpha(0)
	CenterFrame:setImage(RegisterImage(@"uie_zm_hud_inventory_challengeframe"))
	self:addElement(CenterFrame)
	self.CenterFrame = CenterFrame
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.zm_red_challenges_widget_internal.__onClose = function(f2_arg0)
	f2_arg0.Tip:close()
	f2_arg0.End:close()
end
