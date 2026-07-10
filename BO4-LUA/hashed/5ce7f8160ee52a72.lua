require("x64:5f8cf56752aa71b")
require("x64:1a4e34b4805b325")
CoD.ReticleSlotInternal = InheritFrom(LUI.UIElement)
CoD.ReticleSlotInternal.__defaultWidth = 110
CoD.ReticleSlotInternal.__defaultHeight = 80
CoD.ReticleSlotInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReticleSlotInternal)
	self.id = "ReticleSlotInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0, 0, 0)
	Backing:setAlpha(0.2)
	self:addElement(Backing)
	self.Backing = Backing
	local Image = LUI.UIImage.new(0, 0, 15, 95, 0, 0, 0, 80)
	Image:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Image:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Image)
	self.Image = Image
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, -1, 1, 0, 1, 0, 0)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	local CommonButtonOutlineLocked = CoD.CommonButtonOutlineLocked.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CommonButtonOutlineLocked:setAlpha(0)
	self:addElement(CommonButtonOutlineLocked)
	self.CommonButtonOutlineLocked = CommonButtonOutlineLocked
	local EquippedMarkerBG = LUI.UIImage.new(1, 1, -35, 9, 0, 0, -9, 35)
	EquippedMarkerBG:setAlpha(0)
	EquippedMarkerBG:setZoom(4)
	EquippedMarkerBG:setImage(RegisterImage(@"uie_ui_menu_cac_equipped_marker_bg"))
	EquippedMarkerBG:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(EquippedMarkerBG)
	self.EquippedMarkerBG = EquippedMarkerBG
	local EquippedMarkerTick = LUI.UIImage.new(1, 1, -35, 9, 0, 0, -9, 35)
	EquippedMarkerTick:setAlpha(0)
	EquippedMarkerTick:setZoom(4)
	EquippedMarkerTick:setImage(RegisterImage(@"uie_ui_menu_cac_equipped_marker_tick"))
	self:addElement(EquippedMarkerTick)
	self.EquippedMarkerTick = EquippedMarkerTick
	local LockedX = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	LockedX:setRGB(ColorSet.Title.r, ColorSet.Title.g, ColorSet.Title.b)
	LockedX:setAlpha(0)
	LockedX:setImage(RegisterImage(@"uie_spawnselect_crosshair_auto"))
	self:addElement(LockedX)
	self.LockedX = LockedX
	local LockedIcon = LUI.UIImage.new(0.5, 0.5, -15, 15, 0.5, 0.5, -15, 15)
	LockedIcon:setAlpha(0)
	LockedIcon:setImage(RegisterImage(@"uie_icon_locks_lock_01"))
	self:addElement(LockedIcon)
	self.LockedIcon = LockedIcon
	local ProgressBarBG = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -61, 2)
	ProgressBarBG:setRGB(ColorSet.Title.r, ColorSet.Title.g, ColorSet.Title.b)
	ProgressBarBG:setImage(RegisterImage(@"uie_ui_menu_cac_weapon_select_button_bar"))
	self:addElement(ProgressBarBG)
	self.ProgressBarBG = ProgressBarBG
	local ProgressBar = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -61, 2)
	ProgressBar:setImage(RegisterImage(@"uie_ui_menu_cac_button_bottom_line_lvl"))
	ProgressBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_normal"))
	ProgressBar:setShaderVector(1, 0, 0, 0, 0)
	ProgressBar:setShaderVector(2, 1, 0, 0, 0)
	ProgressBar:setShaderVector(3, 0, 0, 0, 0)
	ProgressBar:setShaderVector(4, 0, 0, 0, 0)
	ProgressBar:linkToElementModel(self, "unlockProgressAndTarget", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ProgressBar:setShaderVector(0, CoD.WeaponOptionsUtility.GetWeaponOptionProgress(f1_arg0, f1_arg1, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4)))
		end
	end)
	self:addElement(ProgressBar)
	self.ProgressBar = ProgressBar
	local Name = LUI.UIText.new(0, 0, 6, 108, 1, 1, -21, -5)
	Name:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Name:setTTF("ttmussels_regular")
	Name:setLetterSpacing(1)
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Name:setBackingType(2)
	Name:setBackingColor(0, 0, 0)
	Name:setBackingAlpha(0.8)
	Name:setBackingXPadding(3)
	Name:linkToElementModel(self, "name", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Name:setText(Engine[@"hash_4F9F1239CFD921FE"](f4_local0))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	CommonButtonOutline.id = "CommonButtonOutline"
	CommonButtonOutlineLocked.id = "CommonButtonOutlineLocked"
	self.__defaultFocus = CommonButtonOutline
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ReticleSlotInternal.__resetProperties = function(f5_arg0)
	f5_arg0.Image:completeAnimation()
	f5_arg0.Image:setAlpha(1)
end
CoD.ReticleSlotInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Image:completeAnimation()
			f7_arg0.Image:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.Image)
		end,
		GainChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.Image:completeAnimation()
			f8_arg0.Image:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.Image)
		end,
		LoseChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.Image:completeAnimation()
			f9_arg0.Image:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.Image)
		end,
	},
}
CoD.ReticleSlotInternal.__onClose = function(f10_arg0)
	f10_arg0.Image:close()
	f10_arg0.CommonButtonOutline:close()
	f10_arg0.CommonButtonOutlineLocked:close()
	f10_arg0.ProgressBar:close()
	f10_arg0.Name:close()
end
