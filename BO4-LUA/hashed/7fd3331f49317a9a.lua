CoD.WZAAR_UnlockedCharacter = InheritFrom(LUI.UIElement)
CoD.WZAAR_UnlockedCharacter.__defaultWidth = 425
CoD.WZAAR_UnlockedCharacter.__defaultHeight = 485
CoD.WZAAR_UnlockedCharacter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZAAR_UnlockedCharacter)
	self.id = "WZAAR_UnlockedCharacter"
	self.soundSet = "default"
	local ImageBacker = LUI.UIImage.new(0.5, 0.5, -216, 216, 0, 0, 27, 367)
	ImageBacker:setImage(RegisterImage(@"uie_ui_hud_wz_hud_aar_reward_bg"))
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
	Box:setImage(RegisterImage(@"uie_ui_hud_wz_hud_aar_box_reward"))
	self:addElement(Box)
	self.Box = Box
	local Desc = LUI.UIText.new(0, 0, 13, 412, 0, 0, 409, 427)
	Desc:setRGB(0.81, 0.81, 0.81)
	Desc:setTTF("dinnext_regular")
	Desc:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Desc:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Desc:linkToElementModel(self, "unlockDesc", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Desc:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	self:addElement(Desc)
	self.Desc = Desc
	local Name = LUI.UIText.new(0.04, 0.96, 0, 0, 0, 0, 360.5, 384.5)
	Name:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Name:setTTF("ttmussels_regular")
	Name:setLetterSpacing(2)
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Name:linkToElementModel(self, "name", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Name:setText(Engine[@"hash_4F9F1239CFD921FE"](f4_local0))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	local Title = LUI.UIText.new(0.5, 0.5, -257.5, 257.5, 0, 0, 0, 24)
	Title:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Title:setTTF("ttmussels_regular")
	Title:setLetterSpacing(2)
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
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
