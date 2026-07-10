require("x64:52d762cffa4834e")
CoD.WeaponAttributeStat = InheritFrom(LUI.UIElement)
CoD.WeaponAttributeStat.__defaultWidth = 437
CoD.WeaponAttributeStat.__defaultHeight = 18
CoD.WeaponAttributeStat.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponAttributeStat)
	self.id = "WeaponAttributeStat"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local attributeName = LUI.UIText.new(0, 0, -5, 139, 0, 0, 0, 18)
	attributeName:setRGB(0.39, 0.39, 0.39)
	attributeName:setText(LocalizeToUpperString(0xF669512DF581896))
	attributeName:setTTF("ttmussels_regular")
	attributeName:setLetterSpacing(6)
	attributeName:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	attributeName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(attributeName)
	self.attributeName = attributeName
	local EmptyAttributesBar = CoD.WeaponAttributesBar.new(f1_arg0, f1_arg1, 0, 0, 150, 393, 0, 0, 0.5, 16.5)
	self:addElement(EmptyAttributesBar)
	self.EmptyAttributesBar = EmptyAttributesBar
	local weaponAttribute = LUI.UIImage.new(0, 0, 151.5, 401.5, 0, 0, 6.5, 11.5)
	weaponAttribute:setRGB(0.69, 0.67, 0.6)
	weaponAttribute:setImage(RegisterImage(0xC5E891775405697))
	weaponAttribute:setMaterial(LUI.UIImage.GetCachedMaterial(0x316E67E1DF2198E))
	weaponAttribute:setShaderVector(0, 0, 0, 0, 0)
	weaponAttribute:setShaderVector(1, 0, 0, 0, 0)
	weaponAttribute:setShaderVector(2, 1, 0, 0, 0)
	weaponAttribute:setShaderVector(3, 0, 0, 0, 0)
	weaponAttribute:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(weaponAttribute)
	self.weaponAttribute = weaponAttribute
	local attachmentAttribute = LUI.UIImage.new(0, 0, 151.5, 401.5, 0, 0, 6.5, 11.5)
	attachmentAttribute:setImage(RegisterImage(0xC5E891775405697))
	attachmentAttribute:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	attachmentAttribute:setShaderVector(0, 0, 0, 0, 0)
	attachmentAttribute:setShaderVector(1, 0, 0, 0, 0)
	attachmentAttribute:setShaderVector(2, 0, 1, 0, 0)
	attachmentAttribute:setShaderVector(3, 0, 0, 0, 0)
	attachmentAttribute:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(attachmentAttribute)
	self.attachmentAttribute = attachmentAttribute
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponAttributeStat.__resetProperties = function(f2_arg0)
	f2_arg0.attachmentAttribute:completeAnimation()
	f2_arg0.attachmentAttribute:setRGB(1, 1, 1)
end
CoD.WeaponAttributeStat.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.attachmentAttribute:completeAnimation()
			f3_arg0.attachmentAttribute:setRGB(1, 0, 0)
			f3_arg0.clipFinished(f3_arg0.attachmentAttribute)
		end,
	},
	Increase = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.attachmentAttribute:completeAnimation()
			f4_arg0.attachmentAttribute:setRGB(0, 1, 0)
			f4_arg0.clipFinished(f4_arg0.attachmentAttribute)
		end,
	},
}
CoD.WeaponAttributeStat.__onClose = function(f5_arg0)
	f5_arg0.EmptyAttributesBar:close()
end
