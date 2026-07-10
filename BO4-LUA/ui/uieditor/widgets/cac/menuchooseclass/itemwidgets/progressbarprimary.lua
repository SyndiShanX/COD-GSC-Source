CoD.progressBarPrimary = InheritFrom(LUI.UIElement)
CoD.progressBarPrimary.__defaultWidth = 1580
CoD.progressBarPrimary.__defaultHeight = 12
CoD.progressBarPrimary.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.progressBarPrimary)
	self.id = "progressBarPrimary"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local progressBarBgExtraOpacity = LUI.UIImage.new(0, 0, 7, 332, 0, 0, -9, -6)
	progressBarBgExtraOpacity:setRGB(0, 0, 0)
	progressBarBgExtraOpacity:setAlpha(0.5)
	self:addElement(progressBarBgExtraOpacity)
	self.progressBarBgExtraOpacity = progressBarBgExtraOpacity
	local progressBarBg = LUI.UIImage.new(0, 0, 13, 328, 0, 0, -109, -4)
	progressBarBg:setRGB(0, 0, 0)
	progressBarBg:setScale(1.1, 1.1)
	progressBarBg:setImage(RegisterImage(@"uie_ui_menu_cac_weapon_select_button_bar"))
	self:addElement(progressBarBg)
	self.progressBarBg = progressBarBg
	local progressBarGlow = LUI.UIImage.new(0, 0, 0, 1580, 0, 0, 0, 12)
	progressBarGlow:setRGB(1, 0.87, 0)
	progressBarGlow:setAlpha(0)
	progressBarGlow:setImage(RegisterImage(@"uie_ui_menu_cac_attachment_meter_glow"))
	progressBarGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	progressBarGlow:setShaderVector(1, 0, 0, 0, 0)
	progressBarGlow:setShaderVector(2, 1, 0, 0, 0)
	progressBarGlow:setShaderVector(3, 0, 0, 0, 0)
	progressBarGlow:setShaderVector(4, 0, 0, 0, 0)
	progressBarGlow:linkToElementModel(self, "itemIndex", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			progressBarGlow:setShaderVector(0, CoD.CACUtility.GetCurrentWeaponXP(f1_arg0, f1_arg1, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4)))
		end
	end)
	self:addElement(progressBarGlow)
	self.progressBarGlow = progressBarGlow
	local progressBar = LUI.UIImage.new(0, 0, 28, 313, 0, 0, -146, -8)
	progressBar:setAlpha(0)
	progressBar:setScale(1.2, 1.2)
	progressBar:setImage(RegisterImage(@"uie_ui_menu_cac_button_bottom_line_lvl"))
	progressBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_normal"))
	progressBar:setShaderVector(1, 0, 0, 0, 0)
	progressBar:setShaderVector(2, 1, 0, 0, 0)
	progressBar:setShaderVector(3, 0, 0, 0, 0)
	progressBar:setShaderVector(4, 0, 0, 0, 0)
	progressBar:linkToElementModel(self, "itemIndex", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			progressBar:setShaderVector(0, CoD.CACUtility.GetCurrentWeaponXP(f1_arg0, f1_arg1, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4)))
		end
	end)
	self:addElement(progressBar)
	self.progressBar = progressBar
	local progressBarColorless = LUI.UIImage.new(0, 0, 7, 331, 0, 0, -11, -3)
	progressBarColorless:setImage(RegisterImage(@"uie_ui_menu_cac_button_bottom_line_lvl_colorless"))
	progressBarColorless:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_normal"))
	progressBarColorless:setShaderVector(1, 0, 0, 0, 0)
	progressBarColorless:setShaderVector(2, 1, 0, 0, 0)
	progressBarColorless:setShaderVector(3, 0, 0, 0, 0)
	progressBarColorless:setShaderVector(4, 0, 0, 0, 0)
	progressBarColorless:linkToElementModel(self, "itemIndex", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			progressBarColorless:setShaderVector(0, CoD.CACUtility.GetCurrentWeaponXP(f1_arg0, f1_arg1, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4)))
		end
	end)
	self:addElement(progressBarColorless)
	self.progressBarColorless = progressBarColorless
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.progressBarPrimary.__resetProperties = function(f5_arg0, f5_arg1)
	f5_arg0.progressBarBg:completeAnimation()
	f5_arg0.progressBar:completeAnimation()
	f5_arg0.progressBarColorless:completeAnimation()
	f5_arg0.progressBarGlow:completeAnimation()
	f5_arg0.progressBarBg:setAlpha(1)
	f5_arg0.progressBar:setAlpha(0)
	f5_arg0.progressBarColorless:setAlpha(1)
	f5_arg0.progressBarGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	f5_arg0.progressBarGlow:setShaderVector(1, 0, 0, 0, 0)
	f5_arg0.progressBarGlow:setShaderVector(2, 1, 0, 0, 0)
	f5_arg0.progressBarGlow:setShaderVector(3, 0, 0, 0, 0)
	f5_arg0.progressBarGlow:setShaderVector(4, 0, 0, 0, 0)
end
CoD.progressBarPrimary.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties(f6_arg1)
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.progressBarBg:completeAnimation()
			f6_arg0.progressBarBg:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.progressBarBg)
			f6_arg0.progressBar:completeAnimation()
			f6_arg0.progressBar:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.progressBar)
			f6_arg0.progressBarColorless:completeAnimation()
			f6_arg0.progressBarColorless:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.progressBarColorless)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties(f7_arg1)
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.progressBarGlow:completeAnimation()
			f7_arg0.progressBarGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
			f7_arg0.progressBarGlow:setShaderVector(1, 0, 0, 0, 0)
			f7_arg0.progressBarGlow:setShaderVector(2, 1, 0, 0, 0)
			f7_arg0.progressBarGlow:setShaderVector(3, 0, 0, 0, 0)
			f7_arg0.progressBarGlow:setShaderVector(4, 0, 0, 0, 0)
			f7_arg0.clipFinished(f7_arg0.progressBarGlow)
			f7_arg0.progressBar:completeAnimation()
			f7_arg0.progressBar:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.progressBar)
		end,
	},
}
CoD.progressBarPrimary.__onClose = function(f8_arg0)
	f8_arg0.progressBarGlow:close()
	f8_arg0.progressBar:close()
	f8_arg0.progressBarColorless:close()
end
