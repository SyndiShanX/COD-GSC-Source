CoD.WeaponLevelMeter = InheritFrom(LUI.UIElement)
CoD.WeaponLevelMeter.__defaultWidth = 1580
CoD.WeaponLevelMeter.__defaultHeight = 12
CoD.WeaponLevelMeter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponLevelMeter)
	self.id = "WeaponLevelMeter"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local progressBarBg = LUI.UIImage.new(0, 0, 0, 1580, 0, 0, 2, 10)
	progressBarBg:setImage(RegisterImage(0x45A18362FE3CA31))
	self:addElement(progressBarBg)
	self.progressBarBg = progressBarBg
	local progressBarColorless = LUI.UIImage.new(0, 0, -5, 1585, 0, 0, 2, 10)
	progressBarColorless:setImage(RegisterImage(0xFE3BC2EF75DDD79))
	progressBarColorless:setMaterial(LUI.UIImage.GetCachedMaterial(0x316E67E1DF2198E))
	progressBarColorless:setShaderVector(1, 0, 0, 0, 0)
	progressBarColorless:setShaderVector(2, 1, 0, 0, 0)
	progressBarColorless:setShaderVector(3, 0, 0, 0, 0)
	progressBarColorless:setShaderVector(4, 0, 0, 0, 0)
	progressBarColorless:linkToElementModel(self, "itemIndex", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			progressBarColorless:setShaderVector(0, CoD.CACUtility.GetCurrentWeaponXP(f1_arg0, f1_arg1, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4)))
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
CoD.WeaponLevelMeter.__resetProperties = function(f5_arg0)
	f5_arg0.progressBarBg:completeAnimation()
	f5_arg0.progressBarBg:setAlpha(1)
end
CoD.WeaponLevelMeter.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.progressBarBg:completeAnimation()
			f6_arg0.progressBarBg:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.progressBarBg)
		end,
	},
	DoubleWeaponXP = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	Visible = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.WeaponLevelMeter.__onClose = function(f9_arg0)
	f9_arg0.progressBarColorless:close()
end
