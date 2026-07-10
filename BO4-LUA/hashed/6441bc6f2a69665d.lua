CoD.LaboratoryOfferNameAndDescriptionBackground = InheritFrom(LUI.UIElement)
CoD.LaboratoryOfferNameAndDescriptionBackground.__defaultWidth = 480
CoD.LaboratoryOfferNameAndDescriptionBackground.__defaultHeight = 60
CoD.LaboratoryOfferNameAndDescriptionBackground.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LaboratoryOfferNameAndDescriptionBackground)
	self.id = "LaboratoryOfferNameAndDescriptionBackground"
	self.soundSet = "default"
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setRGB(0, 0, 0)
	SceneBlur:setAlpha(0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0x81EEB1F96D4BE0A))
	SceneBlur:setShaderVector(0, 0, 0.4, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local BGFeather = LUI.UIImage.new(-0.08, 1.08, 0, 0, -0.1, 1.1, 0, 0)
	BGFeather:setRGB(0, 0, 0)
	BGFeather:setAlpha(0.95)
	BGFeather:setMaterial(LUI.UIImage.GetCachedMaterial(0xE125638BF94665F))
	BGFeather:setShaderVector(0, 0.1, 0.1, 0.1, 0.1)
	self:addElement(BGFeather)
	self.BGFeather = BGFeather
	local BGBlack = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGBlack:setRGB(0, 0, 0)
	BGBlack:setAlpha(0.95)
	BGBlack:setMaterial(LUI.UIImage.GetCachedMaterial(0xE125638BF94665F))
	BGBlack:setShaderVector(0, 0.03, 0.03, 0.03, 0.03)
	self:addElement(BGBlack)
	self.BGBlack = BGBlack
	local BGRed = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGRed:setRGB(0.89, 0.12, 0.12)
	BGRed:setAlpha(0.01)
	BGRed:setMaterial(LUI.UIImage.GetCachedMaterial(0xE125638BF94665F))
	BGRed:setShaderVector(0, 0.03, 0.03, 0.03, 0.03)
	self:addElement(BGRed)
	self.BGRed = BGRed
	local BGLight = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGLight:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	BGLight:setAlpha(0.01)
	BGLight:setMaterial(LUI.UIImage.GetCachedMaterial(0xE125638BF94665F))
	BGLight:setShaderVector(0, 0.03, 0.03, 0.03, 0.03)
	self:addElement(BGLight)
	self.BGLight = BGLight
	local RedSmoke = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	RedSmoke:setRGB(ColorSet.ZombiePlayerDown.r, ColorSet.ZombiePlayerDown.g, ColorSet.ZombiePlayerDown.b)
	RedSmoke:setAlpha(0.1)
	RedSmoke:setImage(RegisterImage(0xF034C487614E57C))
	RedSmoke:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	RedSmoke:setShaderVector(0, 0, 0.52, 0, 0)
	RedSmoke:setShaderVector(1, 1.16, 1.32, 0, 0)
	RedSmoke:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(RedSmoke)
	self.RedSmoke = RedSmoke
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
