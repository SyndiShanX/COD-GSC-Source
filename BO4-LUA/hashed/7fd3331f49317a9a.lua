CoD.WZAAR_UnlockedCharacter = InheritFrom(LUI.UIElement)
CoD.WZAAR_UnlockedCharacter.__defaultWidth = 425
CoD.WZAAR_UnlockedCharacter.__defaultHeight = 485
CoD.WZAAR_UnlockedCharacter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZAAR_UnlockedCharacter)
	self.id = "WZAAR_UnlockedCharacter"
	self.soundSet = "default"
	local ImageBacker = LUI.UIImage.new(0.5, 0.5, -216, 216, 0, 0, 27, 367)
	ImageBacker:setImage(RegisterImage(0x1376FA0DA8EADA4))
	self:addElement(ImageBacker)
	self.ImageBacker = ImageBacker
	local FixedAspectRatioImage = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -168, 168, 0, 0, 48, 344)
	FixedAspectRatioImage:linkToElementModel(self, "portrait", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			FixedAspectRatioImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(FixedAspectRatioImage)
	self.FixedAspectRatioImage = FixedAspectRatioImage
	local Box = LUI.UIImage.new(0.5, 0.5, -214, 214, 0, 0, 331, 487)
	Box:setImage(RegisterImage(0xE8A304F1D38AD4C))
	self:addElement(Box)
	self.Box = Box
	local Desc = LUI.UIText.new(0, 0, 13, 412, 0, 0, 409, 427)
	Desc:setRGB(0.81, 0.81, 0.81)
	Desc:setTTF("dinnext_regular")
	Desc:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Desc:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Desc:linkToElementModel(self, "unlockDesc", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Desc:setText(Engine[0xF9F1239CFD921FE](f3_local0))
		end
	end)
	self:addElement(Desc)
	self.Desc = Desc
	local Name = LUI.UIText.new(0.04, 0.96, 0, 0, 0, 0, 360.5, 384.5)
	Name:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Name:setTTF("ttmussels_regular")
	Name:setLetterSpacing(2)
	Name:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Name:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Name:linkToElementModel(self, "name", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Name:setText(Engine[0xF9F1239CFD921FE](f4_local0))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	local Title = LUI.UIText.new(0.5, 0.5, -257.5, 257.5, 0, 0, 0, 24)
	Title:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Title:setTTF("ttmussels_regular")
	Title:setLetterSpacing(2)
	Title:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Title:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	Title:linkToElementModel(self, "unlockTitle", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Title:setText(LocalizeToUpperString(f5_local0))
		end
	end)
	self:addElement(Title)
	self.Title = Title
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZAAR_UnlockedCharacter.__onClose = function(f6_arg0)
	f6_arg0.FixedAspectRatioImage:close()
	f6_arg0.Desc:close()
	f6_arg0.Name:close()
	f6_arg0.Title:close()
end
