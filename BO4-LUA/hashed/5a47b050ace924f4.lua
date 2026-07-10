require("x64:5f8cf56752aa71b")
CoD.InspectionTrophyBackground = InheritFrom(LUI.UIElement)
CoD.InspectionTrophyBackground.__defaultWidth = 250
CoD.InspectionTrophyBackground.__defaultHeight = 290
CoD.InspectionTrophyBackground.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.InspectionTrophyBackground)
	self.id = "InspectionTrophyBackground"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TiledBackingImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TiledBackingImage:setAlpha(0.5)
	TiledBackingImage:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	TiledBackingImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledBackingImage:setShaderVector(0, 0, 0, 0, 0)
	TiledBackingImage:setupNineSliceShader(64, 64)
	self:addElement(TiledBackingImage)
	self.TiledBackingImage = TiledBackingImage
	local ButtonPlusImage = LUI.UIImage.new(0.5, 0.5, -22, 22, 0.5, 0.5, -22, 22)
	ButtonPlusImage:setImage(RegisterImage(@"uie_ui_menu_cac_button_add_plus"))
	self:addElement(ButtonPlusImage)
	self.ButtonPlusImage = ButtonPlusImage
	local ButtonPlusImageFocused = LUI.UIImage.new(0.5, 0.5, -22, 22, 0.5, 0.5, -22, 22)
	ButtonPlusImageFocused:setAlpha(0)
	ButtonPlusImageFocused:setImage(RegisterImage(@"uie_ui_menu_cac_button_add_plus_highlighted"))
	ButtonPlusImageFocused:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	ButtonPlusImageFocused:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(ButtonPlusImageFocused)
	self.ButtonPlusImageFocused = ButtonPlusImageFocused
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	CommonButtonOutline.id = "CommonButtonOutline"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.InspectionTrophyBackground.__resetProperties = function(f2_arg0)
	f2_arg0.ButtonPlusImageFocused:completeAnimation()
	f2_arg0.ButtonPlusImage:completeAnimation()
	f2_arg0.ButtonPlusImageFocused:setAlpha(0)
	f2_arg0.ButtonPlusImage:setAlpha(1)
end
CoD.InspectionTrophyBackground.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.ButtonPlusImage:completeAnimation()
			f3_arg0.ButtonPlusImage:setAlpha(1)
			f3_arg0.clipFinished(f3_arg0.ButtonPlusImage)
			f3_arg0.ButtonPlusImageFocused:completeAnimation()
			f3_arg0.ButtonPlusImageFocused:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.ButtonPlusImageFocused)
		end,
		ChildFocus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.ButtonPlusImage:completeAnimation()
			f4_arg0.ButtonPlusImage:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.ButtonPlusImage)
			f4_arg0.ButtonPlusImageFocused:completeAnimation()
			f4_arg0.ButtonPlusImageFocused:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.ButtonPlusImageFocused)
		end,
	},
}
CoD.InspectionTrophyBackground.__onClose = function(f5_arg0)
	f5_arg0.CommonButtonOutline:close()
end
