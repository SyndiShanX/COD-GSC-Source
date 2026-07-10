CoD.ClassMiniPreviewGearItem = InheritFrom(LUI.UIElement)
CoD.ClassMiniPreviewGearItem.__defaultWidth = 80
CoD.ClassMiniPreviewGearItem.__defaultHeight = 70
CoD.ClassMiniPreviewGearItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ClassMiniPreviewGearItem)
	self.id = "ClassMiniPreviewGearItem"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WeaponImage = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -45, 45, 0.5, 0.5, -45, 45)
	WeaponImage:setStretchedDimension(4)
	WeaponImage:linkToElementModel(self, "imageLarge", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			WeaponImage:setImage(CoD.BaseUtility.AlreadyRegistered(f2_local0))
		end
	end)
	self:addElement(WeaponImage)
	self.WeaponImage = WeaponImage
	local noslotIcon = LUI.UIImage.new(0.5, 0.5, -25, 25, 0.5, 0.5, -25, 25)
	noslotIcon:setAlpha(0.02)
	noslotIcon:setScale(0.4, 0.4)
	noslotIcon:setImage(RegisterImage(@"uie_ui_menu_draft_attachment_noslot"))
	self:addElement(noslotIcon)
	self.noslotIcon = noslotIcon
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ClassMiniPreviewGearItem.__resetProperties = function(f3_arg0)
	f3_arg0.noslotIcon:completeAnimation()
	f3_arg0.WeaponImage:completeAnimation()
	f3_arg0.noslotIcon:setAlpha(0.02)
	f3_arg0.WeaponImage:setAlpha(1)
end
CoD.ClassMiniPreviewGearItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.noslotIcon:completeAnimation()
			f4_arg0.noslotIcon:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.noslotIcon)
		end,
	},
	Unavailable = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.WeaponImage:completeAnimation()
			f5_arg0.WeaponImage:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.WeaponImage)
			f5_arg0.noslotIcon:completeAnimation()
			f5_arg0.noslotIcon:setAlpha(0.02)
			f5_arg0.clipFinished(f5_arg0.noslotIcon)
		end,
	},
}
CoD.ClassMiniPreviewGearItem.__onClose = function(f6_arg0)
	f6_arg0.WeaponImage:close()
end
