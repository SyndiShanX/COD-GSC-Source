CoD.CallingCards_Asset_techGunner_Helicopter = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_techGunner_Helicopter.__defaultWidth = 960
CoD.CallingCards_Asset_techGunner_Helicopter.__defaultHeight = 240
CoD.CallingCards_Asset_techGunner_Helicopter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_techGunner_Helicopter)
	self.id = "CallingCards_Asset_techGunner_Helicopter"
	self.soundSet = "default"
	local helicopter = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 2.5, 242.5)
	helicopter:setScale(1.05, 1.05)
	helicopter:setImage(RegisterImage(0x909E37B3B87BC8F))
	self:addElement(helicopter)
	self.helicopter = helicopter
	local BulletUp = LUI.UIImage.new(0, 0, 571, 683, 0, 0, -85, 155)
	BulletUp:setScale(1.05, 1.05)
	BulletUp:setImage(RegisterImage(0x8BEE6ABB9E0675E))
	BulletUp:setMaterial(LUI.UIImage.GetCachedMaterial(0xD8EA9FE9B0BCF75))
	BulletUp:setShaderVector(0, 1, 1, 0, 0)
	BulletUp:setShaderVector(1, 0, 0.5, 0, 0)
	self:addElement(BulletUp)
	self.BulletUp = BulletUp
	local gunner = LUI.UIImage.new(0, 0, 360.5, 816.5, 0, 0, 2.5, 242.5)
	gunner:setScale(1.05, 1.05)
	gunner:setImage(RegisterImage(0xBA88367DA7BE39E))
	gunner:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD526D3FD71F281))
	gunner:setShaderVector(0, 0, 2, 0, 0)
	gunner:setShaderVector(1, 5, 0, 0, 0)
	self:addElement(gunner)
	self.gunner = gunner
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
