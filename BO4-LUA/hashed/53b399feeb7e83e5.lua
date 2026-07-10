require("x64:1cd7f68136f9cc0")
CoD.LaboratoryOffersHeader = InheritFrom(LUI.UIElement)
CoD.LaboratoryOffersHeader.__defaultWidth = 480
CoD.LaboratoryOffersHeader.__defaultHeight = 24
CoD.LaboratoryOffersHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LaboratoryOffersHeader)
	self.id = "LaboratoryOffersHeader"
	self.soundSet = "none"
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setRGB(0, 0, 0)
	SceneBlur:setAlpha(0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	SceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local Divider = CoD.zm_LaboratoryDescriptionDividerSecondary.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 1, 1, -14.5, 14.5)
	Divider.R:setScale(0.6, 0.6)
	Divider.L:setScale(0.6, 0.6)
	self:addElement(Divider)
	self.Divider = Divider
	local Smoke = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Smoke:setRGB(0.58, 0.85, 1)
	Smoke:setAlpha(0.2)
	Smoke:setImage(RegisterImage(0xF034C487614E57C))
	Smoke:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	Smoke:setShaderVector(0, 0.47, 0.36, 0, 0)
	Smoke:setShaderVector(1, 1, 1, 0, 0)
	Smoke:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(Smoke)
	self.Smoke = Smoke
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LaboratoryOffersHeader.__onClose = function(f2_arg0)
	f2_arg0.Divider:close()
end
