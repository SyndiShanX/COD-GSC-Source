require("x64:5f8cf56752aa71b")
CoD.WeaponPersonalizeSlotInternal = InheritFrom(LUI.UIElement)
CoD.WeaponPersonalizeSlotInternal.__defaultWidth = 152
CoD.WeaponPersonalizeSlotInternal.__defaultHeight = 152
CoD.WeaponPersonalizeSlotInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponPersonalizeSlotInternal)
	self.id = "WeaponPersonalizeSlotInternal"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.8)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local ItemImage = LUI.UIImage.new(0, 1, 5, -5, 0, 1, 5, -5)
	self:addElement(ItemImage)
	self.ItemImage = ItemImage
	local PlusIcon = LUI.UIImage.new(0.5, 0.5, -24, 24, 0.5, 0.5, -24, 24)
	PlusIcon:setAlpha(0)
	PlusIcon:setImage(RegisterImage(@"uie_ui_menu_common_add_plus"))
	self:addElement(PlusIcon)
	self.PlusIcon = PlusIcon
	local FrontendFrame = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrontendFrame:setAlpha(0.2)
	FrontendFrame:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	FrontendFrame:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFrame:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrame)
	self.FrontendFrame = FrontendFrame
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	CommonButtonOutline.id = "CommonButtonOutline"
	self.__defaultFocus = CommonButtonOutline
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponPersonalizeSlotInternal.__resetProperties = function(f2_arg0)
	f2_arg0.PlusIcon:completeAnimation()
	f2_arg0.PlusIcon:setRGB(1, 1, 1)
	f2_arg0.PlusIcon:setAlpha(0)
end
CoD.WeaponPersonalizeSlotInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Add = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.PlusIcon:completeAnimation()
			f4_arg0.PlusIcon:setRGB(1, 1, 1)
			f4_arg0.PlusIcon:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.PlusIcon)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.PlusIcon:completeAnimation()
			f5_arg0.PlusIcon:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.PlusIcon)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.PlusIcon:completeAnimation()
			f6_arg0.PlusIcon:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.PlusIcon)
		end,
		LoseChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.PlusIcon:completeAnimation()
			f7_arg0.PlusIcon:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.PlusIcon)
		end,
	},
}
CoD.WeaponPersonalizeSlotInternal.__onClose = function(f8_arg0)
	f8_arg0.CommonButtonOutline:close()
end
