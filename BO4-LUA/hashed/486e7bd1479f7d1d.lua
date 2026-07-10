require("x64:d1729e9d65fd99a")
require("x64:1bb87fb6a851b76")
require("x64:ec94048bad1fbac")
require("x64:19c1945d2e472b0")
CoD.WeaponOptionInfoInternal = InheritFrom(LUI.UIElement)
CoD.WeaponOptionInfoInternal.__defaultWidth = 480
CoD.WeaponOptionInfoInternal.__defaultHeight = 130
CoD.WeaponOptionInfoInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "paintCanCount")
	self:setClass(CoD.WeaponOptionInfoInternal)
	self.id = "WeaponOptionInfoInternal"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 1, 1, -12, 14)
	DotTiledBacking:setAlpha(0.33)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local UnlockProgressBarBG = LUI.UIImage.new(0, 0, -53, 447, 1, 1, -144, -16)
	UnlockProgressBarBG:setScale(0.8, 1.5)
	UnlockProgressBarBG:setImage(RegisterImage(0x136CEF79E2CB178))
	self:addElement(UnlockProgressBarBG)
	self.UnlockProgressBarBG = UnlockProgressBarBG
	local UnlockProgressBar = LUI.UIImage.new(0, 0, -52, 448, 1, 1, -144, -16)
	UnlockProgressBar:setScale(0.8, 1.5)
	UnlockProgressBar:setImage(RegisterImage(0xF090ADEC8D52EF0))
	UnlockProgressBar:setMaterial(LUI.UIImage.GetCachedMaterial(0x316E67E1DF2198E))
	UnlockProgressBar:setShaderVector(1, 0, 0, 0, 0)
	UnlockProgressBar:setShaderVector(2, 1, 0, 0, 0)
	UnlockProgressBar:setShaderVector(3, 0, 0, 0, 0)
	UnlockProgressBar:setShaderVector(4, 0, 0, 0, 0)
	UnlockProgressBar:linkToElementModel(self, "unlockProgressAndTarget", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			UnlockProgressBar:setShaderVector(0, CoD.WeaponOptionsUtility.GetWeaponOptionProgress(f1_arg0, f1_arg1, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4)))
		end
	end)
	self:addElement(UnlockProgressBar)
	self.UnlockProgressBar = UnlockProgressBar
	local UnlockProgress = LUI.UIText.new(0, 0, 392, 592, 1, 1, -8, 10)
	UnlockProgress:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	UnlockProgress:setTTF("ttmussels_regular")
	UnlockProgress:setLetterSpacing(2)
	UnlockProgress:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	UnlockProgress:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	UnlockProgress:linkToElementModel(self, "unlockProgressAndTarget", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			UnlockProgress:setText(CoD.WeaponOptionsUtility.GetWeaponOptionProgressString(f1_arg0, f1_arg1, f3_local0))
		end
	end)
	self:addElement(UnlockProgress)
	self.UnlockProgress = UnlockProgress
	local Description = LUI.UIText.new(0, 0, 0, 481, 0.5, 0.5, 9, 27)
	Description:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Description:setAlpha(0)
	Description:setTTF("ttmussels_regular")
	Description:setLetterSpacing(2)
	Description:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Description:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Description:linkToElementModel(self, "description", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Description:setText(Engine[0xF9F1239CFD921FE](f4_local0))
		end
	end)
	self:addElement(Description)
	self.Description = Description
	local UnlockDescription = LUI.UIText.new(0, 0, 0, 481, 0.5, 0.5, 9, 27)
	UnlockDescription:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	UnlockDescription:setTTF("ttmussels_regular")
	UnlockDescription:setLetterSpacing(2)
	UnlockDescription:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	UnlockDescription:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	UnlockDescription:linkToElementModel(self, "unlockDescription", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			UnlockDescription:setText(f5_local0)
		end
	end)
	self:addElement(UnlockDescription)
	self.UnlockDescription = UnlockDescription
	local InsufficientFundsDesc = LUI.UIText.new(0, 0, 0, 481, 0.5, 0.5, 61, 79)
	InsufficientFundsDesc:setRGB(ColorSet.InsufficientFunds.r, ColorSet.InsufficientFunds.g, ColorSet.InsufficientFunds.b)
	InsufficientFundsDesc:setAlpha(0)
	InsufficientFundsDesc:setText(Engine[0xF9F1239CFD921FE](0x693FA85E8E2E0DE))
	InsufficientFundsDesc:setTTF("ttmussels_regular")
	InsufficientFundsDesc:setLetterSpacing(2)
	InsufficientFundsDesc:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	InsufficientFundsDesc:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(InsufficientFundsDesc)
	self.InsufficientFundsDesc = InsufficientFundsDesc
	local UnlockBonusAndXPIcon = CoD.NameAndXPBonus.new(f1_arg0, f1_arg1, 0, 0, 0, 500, 0, 0, 8, 64)
	UnlockBonusAndXPIcon:linkToElementModel(self, nil, false, function(model)
		UnlockBonusAndXPIcon:setModel(model, f1_arg1)
	end)
	self:addElement(UnlockBonusAndXPIcon)
	self.UnlockBonusAndXPIcon = UnlockBonusAndXPIcon
	local FramePlaceLeft = LUI.UIImage.new(0, 0, -2, 22, 1, 1, -14, 16)
	FramePlaceLeft:setAlpha(0.04)
	FramePlaceLeft:setImage(RegisterImage(0x4AEBE97B7C64301))
	FramePlaceLeft:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FramePlaceLeft:setShaderVector(0, 0, 0, 0, 0)
	FramePlaceLeft:setupNineSliceShader(24, 24)
	self:addElement(FramePlaceLeft)
	self.FramePlaceLeft = FramePlaceLeft
	local FramePlaceRight = LUI.UIImage.new(1, 1, -22, 2, 1, 1, -14, 16)
	FramePlaceRight:setAlpha(0.04)
	FramePlaceRight:setYRot(180)
	FramePlaceRight:setImage(RegisterImage(0x4AEBE97B7C64301))
	FramePlaceRight:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FramePlaceRight:setShaderVector(0, 0, 0, 0, 0)
	FramePlaceRight:setupNineSliceShader(24, 24)
	self:addElement(FramePlaceRight)
	self.FramePlaceRight = FramePlaceRight
	local Divider = CoD.DirectorDividerWithGradient.new(f1_arg0, f1_arg1, 0, 0, 0, 400, 0, 0, 69, 70)
	Divider:setAlpha(0.25)
	self:addElement(Divider)
	self.Divider = Divider
	local PaintCanCost = CoD.PaintCanCost.new(f1_arg0, f1_arg1, 0, 0, 0, 480, 0, 0, 80, 107)
	PaintCanCost:setAlpha(0)
	PaintCanCost:linkToElementModel(self, nil, false, function(model)
		PaintCanCost:setModel(model, f1_arg1)
	end)
	self:addElement(PaintCanCost)
	self.PaintCanCost = PaintCanCost
	self:mergeStateConditions({
		{
			stateName = "HideProgressDesc",
			condition = function(menu, element, event)
				return CoD.WeaponOptionsUtility.ShouldHideWeaponOptionDescAndProgress(menu, element, f1_arg1)
			end,
		},
		{
			stateName = "HideProgress",
			condition = function(menu, element, event)
				return CoD.WeaponOptionsUtility.ShouldHideWeaponOptionProgress(menu, self, f1_arg1) and not CoD.WeaponOptionsUtility.IsCamoBuyable(menu, self, f1_arg1)
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "weaponOptionCategory", "active") and CoD.WeaponOptionsUtility.IsItemWeaponOptionLocked(menu, element, f1_arg1)
			end,
		},
		{
			stateName = "UnlockedReveal",
			condition = function(menu, element, event)
				return CoD.WeaponOptionsUtility.IsWeaponOptionInfoUnlockedAndRevealed(menu, element, f1_arg1)
			end,
		},
		{
			stateName = "Unlocked",
			condition = function(menu, element, event)
				local f12_local0
				if not CoD.WeaponOptionsUtility.IsItemWeaponOptionLocked(menu, self, f1_arg1) then
					f12_local0 = not CoD.WeaponOptionsUtility.IsItemWeaponOptionCamoWrapped(menu, element, f1_arg1)
				else
					f12_local0 = false
				end
				return f12_local0
			end,
		},
		{
			stateName = "BuyableHideProgress",
			condition = function(menu, element, event)
				return CoD.WeaponOptionsUtility.ShouldHideWeaponOptionProgress(menu, self, f1_arg1) and CoD.WeaponOptionsUtility.IsCamoBuyable(menu, self, f1_arg1)
			end,
		},
		{
			stateName = "BuyableInsufficientFunds",
			condition = function(menu, element, event)
				return CoD.WeaponOptionsUtility.IsWarzoneCamoFilter(menu, self, f1_arg1) and not CoD.WeaponOptionsUtility.CanPurchasePaintCanCamo(element, f1_arg1)
			end,
		},
		{
			stateName = "Buyable",
			condition = function(menu, element, event)
				return CoD.WeaponOptionsUtility.IsWarzoneCamoFilter(menu, self, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "weaponOptionCategory", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "weaponOptionCategory",
		})
	end)
	self:linkToElementModel(self, "itemIndex", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	local f1_local13 = self
	local f1_local14 = self.subscribeToModel
	local f1_local15 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local14(f1_local13, f1_local15["WeaponPersonalization.listUpdate"], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "WeaponPersonalization.listUpdate",
		})
	end, false)
	self:linkToElementModel(self, "unlockProgressAndTarget", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "unlockProgressAndTarget",
		})
	end)
	f1_local13 = self
	f1_local14 = self.subscribeToModel
	f1_local15 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local14(f1_local13, f1_local15.paintCanCount, function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "paintCanCount",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponOptionInfoInternal.__resetProperties = function(f21_arg0)
	f21_arg0.UnlockProgress:completeAnimation()
	f21_arg0.UnlockProgressBar:completeAnimation()
	f21_arg0.UnlockProgressBarBG:completeAnimation()
	f21_arg0.DotTiledBacking:completeAnimation()
	f21_arg0.FramePlaceLeft:completeAnimation()
	f21_arg0.FramePlaceRight:completeAnimation()
	f21_arg0.UnlockBonusAndXPIcon:completeAnimation()
	f21_arg0.UnlockDescription:completeAnimation()
	f21_arg0.Description:completeAnimation()
	f21_arg0.PaintCanCost:completeAnimation()
	f21_arg0.InsufficientFundsDesc:completeAnimation()
	f21_arg0.UnlockProgress:setAlpha(1)
	f21_arg0.UnlockProgressBar:setAlpha(1)
	f21_arg0.UnlockProgressBarBG:setAlpha(1)
	f21_arg0.DotTiledBacking:setAlpha(0.33)
	f21_arg0.FramePlaceLeft:setAlpha(0.04)
	f21_arg0.FramePlaceRight:setAlpha(0.04)
	f21_arg0.UnlockBonusAndXPIcon.XPIcon:setAlpha(1)
	f21_arg0.UnlockDescription:setLeftRight(0, 0, 0, 481)
	f21_arg0.UnlockDescription:setTopBottom(0.5, 0.5, 9, 27)
	f21_arg0.UnlockDescription:setAlpha(1)
	f21_arg0.Description:setAlpha(0)
	f21_arg0.PaintCanCost:setAlpha(0)
	f21_arg0.InsufficientFundsDesc:setAlpha(0)
end
CoD.WeaponOptionInfoInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(0)
		end,
	},
	HideProgressDesc = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(8)
			f23_arg0.DotTiledBacking:completeAnimation()
			f23_arg0.DotTiledBacking:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.DotTiledBacking)
			f23_arg0.UnlockProgressBarBG:completeAnimation()
			f23_arg0.UnlockProgressBarBG:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.UnlockProgressBarBG)
			f23_arg0.UnlockProgressBar:completeAnimation()
			f23_arg0.UnlockProgressBar:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.UnlockProgressBar)
			f23_arg0.UnlockProgress:completeAnimation()
			f23_arg0.UnlockProgress:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.UnlockProgress)
			f23_arg0.UnlockDescription:completeAnimation()
			f23_arg0.UnlockDescription:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.UnlockDescription)
			f23_arg0.UnlockBonusAndXPIcon:completeAnimation()
			f23_arg0.UnlockBonusAndXPIcon.XPIcon:completeAnimation()
			f23_arg0.UnlockBonusAndXPIcon.XPIcon:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.UnlockBonusAndXPIcon)
			f23_arg0.FramePlaceLeft:completeAnimation()
			f23_arg0.FramePlaceLeft:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.FramePlaceLeft)
			f23_arg0.FramePlaceRight:completeAnimation()
			f23_arg0.FramePlaceRight:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.FramePlaceRight)
		end,
	},
	HideProgress = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(7)
			f24_arg0.DotTiledBacking:completeAnimation()
			f24_arg0.DotTiledBacking:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.DotTiledBacking)
			f24_arg0.UnlockProgressBarBG:completeAnimation()
			f24_arg0.UnlockProgressBarBG:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.UnlockProgressBarBG)
			f24_arg0.UnlockProgressBar:completeAnimation()
			f24_arg0.UnlockProgressBar:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.UnlockProgressBar)
			f24_arg0.UnlockProgress:completeAnimation()
			f24_arg0.UnlockProgress:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.UnlockProgress)
			f24_arg0.UnlockBonusAndXPIcon:completeAnimation()
			f24_arg0.UnlockBonusAndXPIcon.XPIcon:completeAnimation()
			f24_arg0.UnlockBonusAndXPIcon.XPIcon:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.UnlockBonusAndXPIcon)
			f24_arg0.FramePlaceLeft:completeAnimation()
			f24_arg0.FramePlaceLeft:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.FramePlaceLeft)
			f24_arg0.FramePlaceRight:completeAnimation()
			f24_arg0.FramePlaceRight:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.FramePlaceRight)
		end,
	},
	Locked = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(8)
			f25_arg0.DotTiledBacking:completeAnimation()
			f25_arg0.DotTiledBacking:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.DotTiledBacking)
			f25_arg0.UnlockProgressBarBG:completeAnimation()
			f25_arg0.UnlockProgressBarBG:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.UnlockProgressBarBG)
			f25_arg0.UnlockProgressBar:completeAnimation()
			f25_arg0.UnlockProgressBar:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.UnlockProgressBar)
			f25_arg0.UnlockProgress:completeAnimation()
			f25_arg0.UnlockProgress:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.UnlockProgress)
			f25_arg0.UnlockDescription:completeAnimation()
			f25_arg0.UnlockDescription:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.UnlockDescription)
			f25_arg0.UnlockBonusAndXPIcon:completeAnimation()
			f25_arg0.UnlockBonusAndXPIcon.XPIcon:completeAnimation()
			f25_arg0.UnlockBonusAndXPIcon.XPIcon:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.UnlockBonusAndXPIcon)
			f25_arg0.FramePlaceLeft:completeAnimation()
			f25_arg0.FramePlaceLeft:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.FramePlaceLeft)
			f25_arg0.FramePlaceRight:completeAnimation()
			f25_arg0.FramePlaceRight:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.FramePlaceRight)
		end,
	},
	UnlockedReveal = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(9)
			f26_arg0.DotTiledBacking:completeAnimation()
			f26_arg0.DotTiledBacking:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.DotTiledBacking)
			f26_arg0.UnlockProgressBarBG:completeAnimation()
			f26_arg0.UnlockProgressBarBG:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.UnlockProgressBarBG)
			f26_arg0.UnlockProgressBar:completeAnimation()
			f26_arg0.UnlockProgressBar:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.UnlockProgressBar)
			f26_arg0.UnlockProgress:completeAnimation()
			f26_arg0.UnlockProgress:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.UnlockProgress)
			f26_arg0.Description:completeAnimation()
			f26_arg0.Description:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.Description)
			f26_arg0.UnlockDescription:completeAnimation()
			f26_arg0.UnlockDescription:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.UnlockDescription)
			f26_arg0.UnlockBonusAndXPIcon:completeAnimation()
			f26_arg0.UnlockBonusAndXPIcon.XPIcon:completeAnimation()
			f26_arg0.UnlockBonusAndXPIcon.XPIcon:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.UnlockBonusAndXPIcon)
			f26_arg0.FramePlaceLeft:completeAnimation()
			f26_arg0.FramePlaceLeft:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.FramePlaceLeft)
			f26_arg0.FramePlaceRight:completeAnimation()
			f26_arg0.FramePlaceRight:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.FramePlaceRight)
		end,
	},
	Unlocked = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(9)
			f27_arg0.DotTiledBacking:completeAnimation()
			f27_arg0.DotTiledBacking:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.DotTiledBacking)
			f27_arg0.UnlockProgressBarBG:completeAnimation()
			f27_arg0.UnlockProgressBarBG:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.UnlockProgressBarBG)
			f27_arg0.UnlockProgressBar:completeAnimation()
			f27_arg0.UnlockProgressBar:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.UnlockProgressBar)
			f27_arg0.UnlockProgress:completeAnimation()
			f27_arg0.UnlockProgress:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.UnlockProgress)
			f27_arg0.Description:completeAnimation()
			f27_arg0.Description:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.Description)
			f27_arg0.UnlockDescription:completeAnimation()
			f27_arg0.UnlockDescription:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.UnlockDescription)
			f27_arg0.UnlockBonusAndXPIcon:completeAnimation()
			f27_arg0.UnlockBonusAndXPIcon.XPIcon:completeAnimation()
			f27_arg0.UnlockBonusAndXPIcon.XPIcon:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.UnlockBonusAndXPIcon)
			f27_arg0.FramePlaceLeft:completeAnimation()
			f27_arg0.FramePlaceLeft:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.FramePlaceLeft)
			f27_arg0.FramePlaceRight:completeAnimation()
			f27_arg0.FramePlaceRight:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.FramePlaceRight)
		end,
	},
	BuyableHideProgress = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(9)
			f28_arg0.DotTiledBacking:completeAnimation()
			f28_arg0.DotTiledBacking:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.DotTiledBacking)
			f28_arg0.UnlockProgressBarBG:completeAnimation()
			f28_arg0.UnlockProgressBarBG:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.UnlockProgressBarBG)
			f28_arg0.UnlockProgressBar:completeAnimation()
			f28_arg0.UnlockProgressBar:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.UnlockProgressBar)
			f28_arg0.UnlockProgress:completeAnimation()
			f28_arg0.UnlockProgress:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.UnlockProgress)
			f28_arg0.UnlockDescription:completeAnimation()
			f28_arg0.UnlockDescription:setLeftRight(0, 0, 0, 481)
			f28_arg0.UnlockDescription:setTopBottom(0.5, 0.5, 33, 51)
			f28_arg0.clipFinished(f28_arg0.UnlockDescription)
			f28_arg0.UnlockBonusAndXPIcon:completeAnimation()
			f28_arg0.UnlockBonusAndXPIcon.XPIcon:completeAnimation()
			f28_arg0.UnlockBonusAndXPIcon.XPIcon:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.UnlockBonusAndXPIcon)
			f28_arg0.FramePlaceLeft:completeAnimation()
			f28_arg0.FramePlaceLeft:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.FramePlaceLeft)
			f28_arg0.FramePlaceRight:completeAnimation()
			f28_arg0.FramePlaceRight:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.FramePlaceRight)
			f28_arg0.PaintCanCost:completeAnimation()
			f28_arg0.PaintCanCost:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.PaintCanCost)
		end,
	},
	BuyableInsufficientFunds = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(10)
			f29_arg0.DotTiledBacking:completeAnimation()
			f29_arg0.DotTiledBacking:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.DotTiledBacking)
			f29_arg0.UnlockProgressBarBG:completeAnimation()
			f29_arg0.UnlockProgressBarBG:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.UnlockProgressBarBG)
			f29_arg0.UnlockProgressBar:completeAnimation()
			f29_arg0.UnlockProgressBar:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.UnlockProgressBar)
			f29_arg0.UnlockProgress:completeAnimation()
			f29_arg0.UnlockProgress:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.UnlockProgress)
			f29_arg0.UnlockDescription:completeAnimation()
			f29_arg0.UnlockDescription:setTopBottom(0.5, 0.5, 33, 51)
			f29_arg0.UnlockDescription:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.UnlockDescription)
			f29_arg0.InsufficientFundsDesc:completeAnimation()
			f29_arg0.InsufficientFundsDesc:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.InsufficientFundsDesc)
			f29_arg0.UnlockBonusAndXPIcon:completeAnimation()
			f29_arg0.UnlockBonusAndXPIcon.XPIcon:completeAnimation()
			f29_arg0.UnlockBonusAndXPIcon.XPIcon:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.UnlockBonusAndXPIcon)
			f29_arg0.FramePlaceLeft:completeAnimation()
			f29_arg0.FramePlaceLeft:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.FramePlaceLeft)
			f29_arg0.FramePlaceRight:completeAnimation()
			f29_arg0.FramePlaceRight:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.FramePlaceRight)
			f29_arg0.PaintCanCost:completeAnimation()
			f29_arg0.PaintCanCost:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.PaintCanCost)
		end,
	},
	Buyable = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(9)
			f30_arg0.DotTiledBacking:completeAnimation()
			f30_arg0.DotTiledBacking:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.DotTiledBacking)
			f30_arg0.UnlockProgressBarBG:completeAnimation()
			f30_arg0.UnlockProgressBarBG:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.UnlockProgressBarBG)
			f30_arg0.UnlockProgressBar:completeAnimation()
			f30_arg0.UnlockProgressBar:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.UnlockProgressBar)
			f30_arg0.UnlockProgress:completeAnimation()
			f30_arg0.UnlockProgress:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.UnlockProgress)
			f30_arg0.UnlockDescription:completeAnimation()
			f30_arg0.UnlockDescription:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.UnlockDescription)
			f30_arg0.UnlockBonusAndXPIcon:completeAnimation()
			f30_arg0.UnlockBonusAndXPIcon.XPIcon:completeAnimation()
			f30_arg0.UnlockBonusAndXPIcon.XPIcon:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.UnlockBonusAndXPIcon)
			f30_arg0.FramePlaceLeft:completeAnimation()
			f30_arg0.FramePlaceLeft:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.FramePlaceLeft)
			f30_arg0.FramePlaceRight:completeAnimation()
			f30_arg0.FramePlaceRight:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.FramePlaceRight)
			f30_arg0.PaintCanCost:completeAnimation()
			f30_arg0.PaintCanCost:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.PaintCanCost)
		end,
	},
}
CoD.WeaponOptionInfoInternal.__onClose = function(f31_arg0)
	f31_arg0.DotTiledBacking:close()
	f31_arg0.UnlockProgressBar:close()
	f31_arg0.UnlockProgress:close()
	f31_arg0.Description:close()
	f31_arg0.UnlockDescription:close()
	f31_arg0.UnlockBonusAndXPIcon:close()
	f31_arg0.Divider:close()
	f31_arg0.PaintCanCost:close()
end
