require("x64:45111f049e24a81")
require("x64:ec94048bad1fbac")
require("x64:eb274d1dc908cc6")
require("x64:dd2fb2034a0f264")
CoD.BountyHunterPackagePreview = InheritFrom(LUI.UIElement)
CoD.BountyHunterPackagePreview.__defaultWidth = 380
CoD.BountyHunterPackagePreview.__defaultHeight = 765
CoD.BountyHunterPackagePreview.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BountyHunterPackagePreview)
	self.id = "BountyHunterPackagePreview"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setRGB(0.51, 0.51, 0.51)
	NoiseTiledBacking:setAlpha(0.5)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local GridTiled = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	GridTiled:setAlpha(0.14)
	GridTiled:setScale(1.01, 1.01)
	GridTiled:setImage(RegisterImage(0xCA386792563DE8))
	GridTiled:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	GridTiled:setShaderVector(0, 0, 0, 0, 0)
	GridTiled:setupNineSliceShader(64, 64)
	self:addElement(GridTiled)
	self.GridTiled = GridTiled
	local Type = LUI.UIText.new(0, 0, 12.5, 212.5, 0, 0, 14, 51)
	Type:setText("")
	Type:setTTF("default")
	Type:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Type:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Type)
	self.Type = Type
	local Cost = LUI.UIText.new(0, 0, 4.5, 373.5, 1, 1, -62, -45)
	Cost:setRGB(0.54, 0.55, 0.58)
	Cost:setText(Engine[0xF9F1239CFD921FE](0xE14C0D42B565C03))
	Cost:setTTF("ttmussels_demibold")
	Cost:setLetterSpacing(4)
	Cost:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(Cost)
	self.Cost = Cost
	local SingleItemDivider = CoD.DirectorDividerWithGradient.new(f1_arg0, f1_arg1, 0, 0, 19.5, 367.5, 0, 0, 283, 290)
	SingleItemDivider:setAlpha(0)
	self:addElement(SingleItemDivider)
	self.SingleItemDivider = SingleItemDivider
	local SingleItemName = LUI.UIText.new(0, 0, 17, 363, 0, 0, 248, 275)
	SingleItemName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	SingleItemName:setAlpha(0)
	SingleItemName:setTTF("ttmussels_regular")
	SingleItemName:setLetterSpacing(4)
	SingleItemName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	SingleItemName:linkToElementModel(self, "item1.displayName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			SingleItemName:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	self:addElement(SingleItemName)
	self.SingleItemName = SingleItemName
	local SingleItemDescription = LUI.UIText.new(0, 0, 17, 363, 0, 0, 290, 310)
	SingleItemDescription:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	SingleItemDescription:setAlpha(0)
	SingleItemDescription:setTTF("dinnext_regular")
	SingleItemDescription:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	SingleItemDescription:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	SingleItemDescription:linkToElementModel(self, "item1.description", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			SingleItemDescription:setText(Engine[0xF9F1239CFD921FE](f3_local0))
		end
	end)
	self:addElement(SingleItemDescription)
	self.SingleItemDescription = SingleItemDescription
	local CostSign = CoD.BountyHunterPreviewDollars.new(f1_arg0, f1_arg1, 0.5, 0.5, -182.5, -32.5, 1, 1, -41.5, -8.5)
	CostSign:linkToElementModel(self, nil, false, function(model)
		CostSign:setModel(model, f1_arg1)
	end)
	self:addElement(CostSign)
	self.CostSign = CostSign
	local SingleItemImage = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -190, 190, 0, 0, 21, 246)
	SingleItemImage:setAlpha(0)
	SingleItemImage:setStretchedDimension(6)
	SingleItemImage:linkToElementModel(self, "item1.imageLarge", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			SingleItemImage:setImage(CoD.BaseUtility.AlreadyRegisteredIfUserData(f5_local0))
		end
	end)
	self:addElement(SingleItemImage)
	self.SingleItemImage = SingleItemImage
	local Item1 = CoD.BountyHunterPreviewMultiItems.new(f1_arg0, f1_arg1, 0, 0, 25, 355, 0, 0, 32.5, 352.5)
	Item1:linkToElementModel(self, nil, false, function(model)
		Item1:setModel(model, f1_arg1)
	end)
	self:addElement(Item1)
	self.Item1 = Item1
	local VerticalAccentBL = LUI.UIImage.new(0, 0, -4, 4, 1, 1, -14, -6)
	VerticalAccentBL:setAlpha(0.2)
	VerticalAccentBL:setZRot(-90)
	VerticalAccentBL:setImage(RegisterImage(0xFE30A9AF719A400))
	VerticalAccentBL:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	VerticalAccentBL:setShaderVector(0, 0, 0, 0, 0)
	VerticalAccentBL:setupNineSliceShader(8, 4)
	self:addElement(VerticalAccentBL)
	self.VerticalAccentBL = VerticalAccentBL
	local VerticalAccentBR = LUI.UIImage.new(1, 1, -4, 4, 1, 1, -14, -6)
	VerticalAccentBR:setAlpha(0.2)
	VerticalAccentBR:setZRot(90)
	VerticalAccentBR:setImage(RegisterImage(0xFE30A9AF719A400))
	VerticalAccentBR:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	VerticalAccentBR:setShaderVector(0, 0, 0, 0, 0)
	VerticalAccentBR:setupNineSliceShader(8, 4)
	self:addElement(VerticalAccentBR)
	self.VerticalAccentBR = VerticalAccentBR
	local VerticalAccentBL2 = LUI.UIImage.new(0, 0, -4, 4, 0, 0, 6, 14)
	VerticalAccentBL2:setAlpha(0.2)
	VerticalAccentBL2:setZRot(-90)
	VerticalAccentBL2:setImage(RegisterImage(0xFE30A9AF719A400))
	VerticalAccentBL2:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	VerticalAccentBL2:setShaderVector(0, 0, 0, 0, 0)
	VerticalAccentBL2:setupNineSliceShader(8, 4)
	self:addElement(VerticalAccentBL2)
	self.VerticalAccentBL2 = VerticalAccentBL2
	local VerticalAccentBR2 = LUI.UIImage.new(1, 1, -4, 4, 0, 0, 6, 14)
	VerticalAccentBR2:setAlpha(0.2)
	VerticalAccentBR2:setZRot(90)
	VerticalAccentBR2:setImage(RegisterImage(0xFE30A9AF719A400))
	VerticalAccentBR2:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	VerticalAccentBR2:setShaderVector(0, 0, 0, 0, 0)
	VerticalAccentBR2:setupNineSliceShader(8, 4)
	self:addElement(VerticalAccentBR2)
	self.VerticalAccentBR2 = VerticalAccentBR2
	local CommonLineAccent01Btm = LUI.UIImage.new(-0.04, 1.04, 0, 0, 1, 1, -10, 6)
	CommonLineAccent01Btm:setAlpha(0.5)
	CommonLineAccent01Btm:setImage(RegisterImage(0xE1962E1E085D031))
	CommonLineAccent01Btm:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	CommonLineAccent01Btm:setShaderVector(0, 0, 0, 0, 0)
	CommonLineAccent01Btm:setupNineSliceShader(32, 16)
	self:addElement(CommonLineAccent01Btm)
	self.CommonLineAccent01Btm = CommonLineAccent01Btm
	local CommonLineAccent01Top = LUI.UIImage.new(-0.04, 1.04, 0, 0, 0, 0, -7, 9)
	CommonLineAccent01Top:setAlpha(0.5)
	CommonLineAccent01Top:setImage(RegisterImage(0xE1962E1E085D031))
	CommonLineAccent01Top:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	CommonLineAccent01Top:setShaderVector(0, 0, 0, 0, 0)
	CommonLineAccent01Top:setupNineSliceShader(32, 16)
	self:addElement(CommonLineAccent01Top)
	self.CommonLineAccent01Top = CommonLineAccent01Top
	local DirectorDividerWithGradient = CoD.DirectorDividerWithGradient.new(f1_arg0, f1_arg1, 0, 0, 17, 239, 0, 0, 282, 289)
	DirectorDividerWithGradient:setRGB(0.5, 0.5, 0.5)
	DirectorDividerWithGradient:setAlpha(0)
	self:addElement(DirectorDividerWithGradient)
	self.DirectorDividerWithGradient = DirectorDividerWithGradient
	local WeaponAttributes = CoD.WeaponAttributes.new(f1_arg0, f1_arg1, 0.5, 0.5, -223.5, 221.5, 0, 0, 421.5, 671.5)
	WeaponAttributes:setAlpha(0)
	WeaponAttributes:setScale(0.88, 0.88)
	WeaponAttributes:linkToElementModel(self, "item1.weaponAttributes", false, function(model)
		WeaponAttributes:setModel(model, f1_arg1)
	end)
	self:addElement(WeaponAttributes)
	self.WeaponAttributes = WeaponAttributes
	self:mergeStateConditions({
		{
			stateName = "NoItem",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathNil(self, f1_arg1, "item1")
			end,
		},
		{
			stateName = "WeaponNotSelected",
			condition = function(menu, element, event)
				return CoD.BountyHunterUtility.IsPreviewPackageWeaponNotSelected(self)
			end,
		},
		{
			stateName = "Weapon",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(self, f1_arg1, "item1.weaponAttributes.damage", 0)
			end,
		},
		{
			stateName = "SingleItem",
			condition = function(menu, element, event)
				return CoD.BountyHunterUtility.IsPreviewPackageSingleItem(self)
			end,
		},
	})
	self:linkToElementModel(self, "item1", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "item1",
		})
	end)
	self:linkToElementModel(self, "packageID", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "packageID",
		})
	end)
	self:linkToElementModel(self, "item1.weaponAttributes.damage", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "item1.weaponAttributes.damage",
		})
	end)
	self:linkToElementModel(self, "item2.displayName", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "item2.displayName",
		})
	end)
	self:linkToElementModel(self, "item2.trackTier", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "item2.trackTier",
		})
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "luielement.BountyHunterLoadout.currentPackage", function(model)
		local f17_local0 = self
		CoD.BountyHunterUtility.SetPreviewedPackageFromCurrentModel(self, model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BountyHunterPackagePreview.__resetProperties = function(f18_arg0)
	f18_arg0.SingleItemImage:completeAnimation()
	f18_arg0.CostSign:completeAnimation()
	f18_arg0.SingleItemDescription:completeAnimation()
	f18_arg0.SingleItemName:completeAnimation()
	f18_arg0.SingleItemDivider:completeAnimation()
	f18_arg0.Cost:completeAnimation()
	f18_arg0.Type:completeAnimation()
	f18_arg0.Item1:completeAnimation()
	f18_arg0.WeaponAttributes:completeAnimation()
	f18_arg0.DirectorDividerWithGradient:completeAnimation()
	f18_arg0.SingleItemImage:setAlpha(0)
	f18_arg0.CostSign:setAlpha(1)
	f18_arg0.SingleItemDescription:setAlpha(0)
	f18_arg0.SingleItemName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f18_arg0.SingleItemName:setAlpha(0)
	f18_arg0.SingleItemName:setZRot(0)
	f18_arg0.SingleItemDivider:setAlpha(0)
	f18_arg0.Cost:setAlpha(1)
	f18_arg0.Type:setAlpha(1)
	f18_arg0.Item1:setAlpha(1)
	f18_arg0.WeaponAttributes:setAlpha(0)
	f18_arg0.DirectorDividerWithGradient:setRGB(0.5, 0.5, 0.5)
end
CoD.BountyHunterPackagePreview.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(0)
		end,
	},
	NoItem = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(7)
			f20_arg0.Type:completeAnimation()
			f20_arg0.Type:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Type)
			f20_arg0.Cost:completeAnimation()
			f20_arg0.Cost:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Cost)
			f20_arg0.SingleItemDivider:completeAnimation()
			f20_arg0.SingleItemDivider:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.SingleItemDivider)
			f20_arg0.SingleItemName:completeAnimation()
			f20_arg0.SingleItemName:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.SingleItemName)
			f20_arg0.SingleItemDescription:completeAnimation()
			f20_arg0.SingleItemDescription:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.SingleItemDescription)
			f20_arg0.CostSign:completeAnimation()
			f20_arg0.CostSign:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.CostSign)
			f20_arg0.SingleItemImage:completeAnimation()
			f20_arg0.SingleItemImage:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.SingleItemImage)
		end,
	},
	WeaponNotSelected = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(6)
			f21_arg0.Cost:completeAnimation()
			f21_arg0.Cost:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Cost)
			f21_arg0.SingleItemDivider:completeAnimation()
			f21_arg0.SingleItemDivider:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.SingleItemDivider)
			f21_arg0.SingleItemName:completeAnimation()
			f21_arg0.SingleItemName:setAlpha(0)
			f21_arg0.SingleItemName:setZRot(90)
			f21_arg0.clipFinished(f21_arg0.SingleItemName)
			f21_arg0.SingleItemDescription:completeAnimation()
			f21_arg0.SingleItemDescription:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.SingleItemDescription)
			f21_arg0.CostSign:completeAnimation()
			f21_arg0.CostSign:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.CostSign)
			f21_arg0.Item1:completeAnimation()
			f21_arg0.Item1:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Item1)
		end,
	},
	Weapon = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(6)
			f22_arg0.SingleItemDivider:completeAnimation()
			f22_arg0.SingleItemDivider:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.SingleItemDivider)
			f22_arg0.SingleItemName:completeAnimation()
			f22_arg0.SingleItemName:setRGB(0.78, 0.78, 0.78)
			f22_arg0.SingleItemName:setAlpha(1)
			f22_arg0.SingleItemName:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
			f22_arg0.clipFinished(f22_arg0.SingleItemName)
			f22_arg0.SingleItemDescription:completeAnimation()
			f22_arg0.SingleItemDescription:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.SingleItemDescription)
			f22_arg0.SingleItemImage:completeAnimation()
			f22_arg0.SingleItemImage:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.SingleItemImage)
			f22_arg0.DirectorDividerWithGradient:completeAnimation()
			f22_arg0.DirectorDividerWithGradient:setRGB(0.5, 0.5, 0.5)
			f22_arg0.clipFinished(f22_arg0.DirectorDividerWithGradient)
			f22_arg0.WeaponAttributes:completeAnimation()
			f22_arg0.WeaponAttributes:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.WeaponAttributes)
		end,
	},
	SingleItem = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(5)
			f23_arg0.SingleItemDivider:completeAnimation()
			f23_arg0.SingleItemDivider:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.SingleItemDivider)
			f23_arg0.SingleItemName:completeAnimation()
			f23_arg0.SingleItemName:setRGB(0.78, 0.78, 0.78)
			f23_arg0.SingleItemName:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.SingleItemName)
			f23_arg0.SingleItemDescription:completeAnimation()
			f23_arg0.SingleItemDescription:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.SingleItemDescription)
			f23_arg0.SingleItemImage:completeAnimation()
			f23_arg0.SingleItemImage:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.SingleItemImage)
			f23_arg0.DirectorDividerWithGradient:completeAnimation()
			f23_arg0.DirectorDividerWithGradient:setRGB(0.5, 0.5, 0.5)
			f23_arg0.clipFinished(f23_arg0.DirectorDividerWithGradient)
		end,
	},
}
CoD.BountyHunterPackagePreview.__onClose = function(f24_arg0)
	f24_arg0.SingleItemDivider:close()
	f24_arg0.SingleItemName:close()
	f24_arg0.SingleItemDescription:close()
	f24_arg0.CostSign:close()
	f24_arg0.SingleItemImage:close()
	f24_arg0.Item1:close()
	f24_arg0.DirectorDividerWithGradient:close()
	f24_arg0.WeaponAttributes:close()
end
