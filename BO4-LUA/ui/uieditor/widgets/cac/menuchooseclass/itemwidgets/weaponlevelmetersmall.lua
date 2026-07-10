CoD.WeaponLevelMeterSmall = InheritFrom(LUI.UIElement)
CoD.WeaponLevelMeterSmall.__defaultWidth = 1580
CoD.WeaponLevelMeterSmall.__defaultHeight = 12
CoD.WeaponLevelMeterSmall.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponLevelMeterSmall)
	self.id = "WeaponLevelMeterSmall"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local progressBarBg = LUI.UIImage.new(0, 0, 0, 1580, 0, 0, 0, 12)
	progressBarBg:setAlpha(0)
	progressBarBg:setImage(RegisterImage(0x45A18362FE3CA31))
	self:addElement(progressBarBg)
	self.progressBarBg = progressBarBg
	local progressBarGlow = LUI.UIImage.new(0, 0, 0, 1580, 0, 0, 0, 12)
	progressBarGlow:setRGB(1, 0.87, 0)
	progressBarGlow:setAlpha(0)
	progressBarGlow:setImage(RegisterImage(0xBCE1DB85F0A9))
	progressBarGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0x910274CA3518744))
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
	local progressBarGlow2 = LUI.UIImage.new(0, 0, 0, 1580, 0, 0, 0, 12)
	progressBarGlow2:setRGB(1, 0.87, 0)
	progressBarGlow2:setAlpha(0)
	progressBarGlow2:setImage(RegisterImage(0xBCE1DB85F0A9))
	progressBarGlow2:setMaterial(LUI.UIImage.GetCachedMaterial(0x910274CA3518744))
	progressBarGlow2:setShaderVector(1, 0, 0, 0, 0)
	progressBarGlow2:setShaderVector(2, 1, 0, 0, 0)
	progressBarGlow2:setShaderVector(3, 0, 0, 0, 0)
	progressBarGlow2:setShaderVector(4, 0, 0, 0, 0)
	progressBarGlow2:linkToElementModel(self, "itemIndex", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			progressBarGlow2:setShaderVector(0, CoD.CACUtility.GetCurrentWeaponXP(f1_arg0, f1_arg1, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4)))
		end
	end)
	self:addElement(progressBarGlow2)
	self.progressBarGlow2 = progressBarGlow2
	local progressBarColorless = LUI.UIImage.new(0, 0, 0, 271, 0, 0, 2, 10)
	progressBarColorless:setImage(RegisterImage(0xFE3BC2EF75DDD79))
	progressBarColorless:setMaterial(LUI.UIImage.GetCachedMaterial(0x316E67E1DF2198E))
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
	self:mergeStateConditions({
		{
			stateName = "DoubleWeaponXP",
			condition = function(menu, element, event)
				return IsDoubleWeaponXP(f1_arg1)
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponLevelMeterSmall.__resetProperties = function(f7_arg0, f7_arg1)
	f7_arg0.progressBarBg:completeAnimation()
	f7_arg0.progressBarColorless:completeAnimation()
	f7_arg0.progressBarGlow:completeAnimation()
	f7_arg0.progressBarBg:setAlpha(0)
	f7_arg0.progressBarColorless:setAlpha(1)
	f7_arg0.progressBarGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0x910274CA3518744))
	f7_arg0.progressBarGlow:setShaderVector(1, 0, 0, 0, 0)
	f7_arg0.progressBarGlow:setShaderVector(2, 1, 0, 0, 0)
	f7_arg0.progressBarGlow:setShaderVector(3, 0, 0, 0, 0)
	f7_arg0.progressBarGlow:setShaderVector(4, 0, 0, 0, 0)
end
CoD.WeaponLevelMeterSmall.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties(f8_arg1)
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.progressBarBg:completeAnimation()
			f8_arg0.progressBarBg:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.progressBarBg)
			f8_arg0.progressBarColorless:completeAnimation()
			f8_arg0.progressBarColorless:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.progressBarColorless)
		end,
	},
	DoubleWeaponXP = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties(f9_arg1)
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.progressBarGlow:completeAnimation()
			f9_arg0.progressBarGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0x910274CA3518744))
			f9_arg0.progressBarGlow:setShaderVector(1, 0, 0, 0, 0)
			f9_arg0.progressBarGlow:setShaderVector(2, 1, 0, 0, 0)
			f9_arg0.progressBarGlow:setShaderVector(3, 0, 0, 0, 0)
			f9_arg0.progressBarGlow:setShaderVector(4, 0, 0, 0, 0)
			f9_arg0.clipFinished(f9_arg0.progressBarGlow)
		end,
	},
	Visible = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties(f10_arg1)
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.progressBarGlow:completeAnimation()
			f10_arg0.progressBarGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0x910274CA3518744))
			f10_arg0.progressBarGlow:setShaderVector(1, 0, 0, 0, 0)
			f10_arg0.progressBarGlow:setShaderVector(2, 1, 0, 0, 0)
			f10_arg0.progressBarGlow:setShaderVector(3, 0, 0, 0, 0)
			f10_arg0.progressBarGlow:setShaderVector(4, 0, 0, 0, 0)
			f10_arg0.clipFinished(f10_arg0.progressBarGlow)
		end,
	},
}
CoD.WeaponLevelMeterSmall.__onClose = function(f11_arg0)
	f11_arg0.progressBarGlow:close()
	f11_arg0.progressBarGlow2:close()
	f11_arg0.progressBarColorless:close()
end
