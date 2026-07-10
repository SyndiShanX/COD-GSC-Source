require("x64:a9255c570c68aa8")
CoD.WeaponPickupPrompt_Backing = InheritFrom(LUI.UIElement)
CoD.WeaponPickupPrompt_Backing.__defaultWidth = 60
CoD.WeaponPickupPrompt_Backing.__defaultHeight = 60
CoD.WeaponPickupPrompt_Backing.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponPickupPrompt_Backing)
	self.id = "WeaponPickupPrompt_Backing"
	self.soundSet = "default"
	local Blur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local Base = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Base:setRGB(0, 0, 0)
	Base:setAlpha(0.7)
	self:addElement(Base)
	self.Base = Base
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Frame:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Frame:setAlpha(0.06)
	self:addElement(Frame)
	self.Frame = Frame
	local Corner1 = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 0, 1)
	self:addElement(Corner1)
	self.Corner1 = Corner1
	local Image = LUI.UIImage.new(1, 1, -1, 0, 0, 0, 0, 1)
	self:addElement(Image)
	self.Image = Image
	local Image2 = LUI.UIImage.new(1, 1, -1, 0, 1, 1, -1, 0)
	self:addElement(Image2)
	self.Image2 = Image2
	local Image3 = LUI.UIImage.new(0, 0, 0, 1, 1, 1, -1, 0)
	self:addElement(Image3)
	self.Image3 = Image3
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponPickupPrompt_Backing.__onClose = function(f2_arg0)
	f2_arg0.Frame:close()
end
