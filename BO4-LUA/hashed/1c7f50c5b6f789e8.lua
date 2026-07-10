require("x64:62eee6f7ab7e3b3")
CoD.ZMInventoryQuestBackingInternal = InheritFrom(LUI.UIElement)
CoD.ZMInventoryQuestBackingInternal.__defaultWidth = 400
CoD.ZMInventoryQuestBackingInternal.__defaultHeight = 80
CoD.ZMInventoryQuestBackingInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMInventoryQuestBackingInternal)
	self.id = "ZMInventoryQuestBackingInternal"
	self.soundSet = "default"
	local SceneBlur = LUI.UIImage.new(-0.11, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setRGB(0, 0, 0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0x81EEB1F96D4BE0A))
	SceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local SolidBase = LUI.UIImage.new(0, 1, 0, 0, -0, 1, 0, 0)
	SolidBase:setRGB(0, 0, 0)
	SolidBase:setAlpha(0.25)
	self:addElement(SolidBase)
	self.SolidBase = SolidBase
	local BaseGradient = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BaseGradient:setAlpha(0.4)
	BaseGradient:setMaterial(LUI.UIImage.GetCachedMaterial(0xDE760AC0E801E57))
	BaseGradient:setShaderVector(0, 0, 0, 0, 0)
	BaseGradient:setShaderVector(1, 0, 0, 0, 2.5)
	BaseGradient:setShaderVector(2, 0.02, 0, 0, 0)
	self:addElement(BaseGradient)
	self.BaseGradient = BaseGradient
	local BGMid = LUI.UIImage.new(-0.11, 1, 0, 0, 0.5, 0.5, -40, 40)
	BGMid:setAlpha(0.8)
	BGMid:setImage(RegisterImage(0xBB35BC5D2F0269C))
	BGMid:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	BGMid:setShaderVector(0, 0, 0, 0, 0)
	BGMid:setShaderVector(1, 1, 0, 0, 0)
	BGMid:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(BGMid)
	self.BGMid = BGMid
	local Tip = CoD.ZMInventoryListBackingInternalTip.new(f1_arg0, f1_arg1, 0, 0, -100, 0, 0.5, 0.5, -40, 40)
	Tip:setAlpha(0.9)
	self:addElement(Tip)
	self.Tip = Tip
	local BGTip = LUI.UIImage.new(0, 0, -100, 0, 0, 0, -10, 90)
	BGTip:setAlpha(0.08)
	BGTip:setImage(RegisterImage(0x95EE339800F1644))
	self:addElement(BGTip)
	self.BGTip = BGTip
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMInventoryQuestBackingInternal.__onClose = function(f2_arg0)
	f2_arg0.Tip:close()
end
