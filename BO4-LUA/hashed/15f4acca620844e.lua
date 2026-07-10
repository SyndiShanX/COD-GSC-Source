CoD.WeaponPickupPrompt_BackingStash = InheritFrom(LUI.UIElement)
CoD.WeaponPickupPrompt_BackingStash.__defaultWidth = 60
CoD.WeaponPickupPrompt_BackingStash.__defaultHeight = 60
CoD.WeaponPickupPrompt_BackingStash.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponPickupPrompt_BackingStash)
	self.id = "WeaponPickupPrompt_BackingStash"
	self.soundSet = "default"
	local Base = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Base:setRGB(0.21, 0.21, 0.21)
	Base:setMaterial(LUI.UIImage.GetCachedMaterial(0xE125638BF94665F))
	Base:setShaderVector(0, 0.01, 0.01, 0.01, 0.01)
	self:addElement(Base)
	self.Base = Base
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
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
