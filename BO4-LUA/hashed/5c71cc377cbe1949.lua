require("x64:62eee6f7ab7e3b3")
CoD.ZMInvChallengesBackingInternal = InheritFrom(LUI.UIElement)
CoD.ZMInvChallengesBackingInternal.__defaultWidth = 360
CoD.ZMInvChallengesBackingInternal.__defaultHeight = 70
CoD.ZMInvChallengesBackingInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMInvChallengesBackingInternal)
	self.id = "ZMInvChallengesBackingInternal"
	self.soundSet = "none"
	local SceneBlur = LUI.UIImage.new(-0.03, 1.03, 0, 0, 0, 1, 0, 0)
	SceneBlur:setRGB(0, 0, 0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0x81EEB1F96D4BE0A))
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
	BaseGradientL:setMaterial(LUI.UIImage.GetCachedMaterial(0xDE760AC0E801E57))
	BaseGradientL:setShaderVector(0, 0, 0, 0, 15)
	BaseGradientL:setShaderVector(1, 0, 0, 0, 0)
	BaseGradientL:setShaderVector(2, 0.5, 0, 0, 0)
	self:addElement(BaseGradientL)
	self.BaseGradientL = BaseGradientL
	local BaseGradientR = LUI.UIImage.new(0.5, 1.03, 0, 0, 0, 1, 0, 0)
	BaseGradientR:setRGB(0, 0, 0)
	BaseGradientR:setAlpha(0.1)
	BaseGradientR:setMaterial(LUI.UIImage.GetCachedMaterial(0xDE760AC0E801E57))
	BaseGradientR:setShaderVector(0, 0, 0, 0, 0)
	BaseGradientR:setShaderVector(1, 0, 0, 0, 15)
	BaseGradientR:setShaderVector(2, 0.5, 0, 0, 0)
	self:addElement(BaseGradientR)
	self.BaseGradientR = BaseGradientR
	local TextureMid = LUI.UIImage.new(0, 1, 0, 0, 0.5, 1.5, -35, -35)
	TextureMid:setAlpha(0.8)
	TextureMid:setImage(RegisterImage(0xBB35BC5D2F0269C))
	TextureMid:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	TextureMid:setShaderVector(0, 1, 0, 0, 0)
	TextureMid:setShaderVector(1, 1, 0, 0, 0)
	TextureMid:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(TextureMid)
	self.TextureMid = TextureMid
	local Tip = CoD.ZMInventoryListBackingInternalTip.new(f1_arg0, f1_arg1, 0, 0, -100, 0, 0, 0, 0, 70)
	self:addElement(Tip)
	self.Tip = Tip
	local End = CoD.ZMInventoryListBackingInternalTip.new(f1_arg0, f1_arg1, 1, 1, 0, 100, 0, 0, 0, 70)
	End:setYRot(180)
	self:addElement(End)
	self.End = End
	local CenterFade = LUI.UIImage.new(0.5, 0.5, -130, 130, 0, 1, 0, 0)
	CenterFade:setRGB(0, 0, 0)
	CenterFade:setAlpha(0.95)
	CenterFade:setMaterial(LUI.UIImage.GetCachedMaterial(0xE125638BF94665F))
	CenterFade:setShaderVector(0, 0.05, 0, 0.05, 0)
	self:addElement(CenterFade)
	self.CenterFade = CenterFade
	local DecoL = LUI.UIImage.new(0, 0, -102, -6, 0, 0, -11, 81)
	DecoL:setAlpha(0.08)
	DecoL:setImage(RegisterImage(0x95EE339800F1644))
	self:addElement(DecoL)
	self.DecoL = DecoL
	local DecoR = LUI.UIImage.new(1, 1, 6, 102, 0, 0, -11, 81)
	DecoR:setAlpha(0.08)
	DecoR:setYRot(180)
	DecoR:setImage(RegisterImage(0x95EE339800F1644))
	self:addElement(DecoR)
	self.DecoR = DecoR
	local CenterFrame = LUI.UIImage.new(0.5, 0.5, -90.5, 90.5, 0, 0, -25, 31)
	CenterFrame:setImage(RegisterImage(0x67D2BCC05F51442))
	self:addElement(CenterFrame)
	self.CenterFrame = CenterFrame
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMInvChallengesBackingInternal.__onClose = function(f2_arg0)
	f2_arg0.Tip:close()
	f2_arg0.End:close()
end
