CoD.ZMSpecialWeapon_StageInfo = InheritFrom(LUI.UIElement)
CoD.ZMSpecialWeapon_StageInfo.__defaultWidth = 300
CoD.ZMSpecialWeapon_StageInfo.__defaultHeight = 100
CoD.ZMSpecialWeapon_StageInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMSpecialWeapon_StageInfo)
	self.id = "ZMSpecialWeapon_StageInfo"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 0, 50, 305, 0, 1, 0, 0)
	Backing:setRGB(0.27, 0.27, 0.27)
	Backing:setAlpha(0.3)
	self:addElement(Backing)
	self.Backing = Backing
	local CircleOFF = LUI.UIImage.new(0, 0, -11, 53, 0, 0, -12, 52)
	CircleOFF:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	CircleOFF:setImage(RegisterImage(0x9C20F78C21F507D))
	self:addElement(CircleOFF)
	self.CircleOFF = CircleOFF
	local CircleON = LUI.UIImage.new(0, 0, -11, 53, 0, 0, -12, 52)
	CircleON:setRGB(0.58, 0.85, 1)
	CircleON:setImage(RegisterImage(0xF061C994A027B01))
	CircleON:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(CircleON)
	self.CircleON = CircleON
	local Stage = LUI.UIText.new(0, 0, 54, 279, 0, 0, -1, 17)
	Stage:setRGB(0.92, 0.88, 0.72)
	Stage:setTTF("ttmussels_demibold")
	Stage:setLetterSpacing(6)
	Stage:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Stage:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Stage:linkToElementModel(self, "displayName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Stage:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(Stage)
	self.Stage = Stage
	local Name = LUI.UIText.new(0, 0, 54, 456, 0, 0, 25, 43)
	Name:setRGB(0.5, 0.5, 0.5)
	Name:setTTF("ttmussels_regular")
	Name:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	Name:setShaderVector(0, 0, 0, 0, 0)
	Name:setShaderVector(1, 0, 0, 0, 0)
	Name:setShaderVector(2, 1, 1, 1, 0)
	Name:setLetterSpacing(4)
	Name:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Name:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Name:linkToElementModel(self, "itemName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Name:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMSpecialWeapon_StageInfo.__resetProperties = function(f4_arg0)
	f4_arg0.Backing:completeAnimation()
	f4_arg0.CircleON:completeAnimation()
	f4_arg0.Name:completeAnimation()
	f4_arg0.Backing:setAlpha(0.3)
	f4_arg0.CircleON:setAlpha(1)
	f4_arg0.Name:setRGB(0.5, 0.5, 0.5)
	f4_arg0.Name:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	f4_arg0.Name:setShaderVector(0, 0, 0, 0, 0)
	f4_arg0.Name:setShaderVector(1, 0, 0, 0, 0)
	f4_arg0.Name:setShaderVector(2, 1, 1, 1, 0)
end
CoD.ZMSpecialWeapon_StageInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.Backing:completeAnimation()
			f5_arg0.Backing:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Backing)
			f5_arg0.CircleON:completeAnimation()
			f5_arg0.CircleON:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.CircleON)
		end,
		Focus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.Backing:completeAnimation()
			f6_arg0.Backing:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Backing)
			f6_arg0.Name:completeAnimation()
			f6_arg0.Name:setRGB(0.58, 0.85, 1)
			f6_arg0.Name:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
			f6_arg0.Name:setShaderVector(0, 1, 0, 0, 0)
			f6_arg0.Name:setShaderVector(1, 0, 0, 0, 0)
			f6_arg0.Name:setShaderVector(2, 0.2, 0.3, 1, 0.3)
			f6_arg0.clipFinished(f6_arg0.Name)
		end,
	},
}
CoD.ZMSpecialWeapon_StageInfo.__onClose = function(f7_arg0)
	f7_arg0.Stage:close()
	f7_arg0.Name:close()
end
