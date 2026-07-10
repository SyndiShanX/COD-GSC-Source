require("x64:62407f124c5a6f8")
CoD.SupplyChainContentImage = InheritFrom(LUI.UIElement)
CoD.SupplyChainContentImage.__defaultWidth = 140
CoD.SupplyChainContentImage.__defaultHeight = 158
CoD.SupplyChainContentImage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SupplyChainContentImage)
	self.id = "SupplyChainContentImage"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FixedAspectRatioImage = LUI.UIFixedAspectRatioImage.new(0, 0, 0, 140, 0, 0, 0, 158)
	FixedAspectRatioImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_saturation_normal"))
	FixedAspectRatioImage:setShaderVector(0, 1, 0, 0, 0)
	FixedAspectRatioImage:setStretchedDimension(6)
	FixedAspectRatioImage:linkToElementModel(self, "primaryImage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			FixedAspectRatioImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(FixedAspectRatioImage)
	self.FixedAspectRatioImage = FixedAspectRatioImage
	local CallingCardImage = CoD.CallingCardImage.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CallingCardImage:setAlpha(0)
	CallingCardImage:linkToElementModel(self, nil, false, function(model)
		CallingCardImage:setModel(model, f1_arg1)
	end)
	CallingCardImage:linkToElementModel(self, "primaryImage", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			CallingCardImage.Image:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(CallingCardImage)
	self.CallingCardImage = CallingCardImage
	local OutfitPalette = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	OutfitPalette:setAlpha(0)
	OutfitPalette:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1A02C44161370F6D"))
	OutfitPalette:setShaderVector(0, 0.5, 0, 0, 0)
	OutfitPalette:setShaderVector(1, 1, 1, 0, 0)
	OutfitPalette:setShaderVector(2, 0, 0, 0, 0)
	OutfitPalette:linkToElementModel(self, "primaryImage", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			OutfitPalette:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(OutfitPalette)
	self.OutfitPalette = OutfitPalette
	local Character = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Character:setAlpha(0)
	Character:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1A02C44161370F6D"))
	Character:setShaderVector(0, 0.5, 1, 0, 0)
	Character:setShaderVector(1, 1, 1, 0, 0)
	Character:setShaderVector(2, 0, 0, 0, 0)
	Character:linkToElementModel(self, "primaryImage", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Character:setImage(RegisterImage(f6_local0))
		end
	end)
	self:addElement(Character)
	self.Character = Character
	local SignatureWeapon = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SignatureWeapon:setAlpha(0)
	SignatureWeapon:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1A02C44161370F6D"))
	SignatureWeapon:setShaderVector(0, 0.5, 0.5, 0, 0)
	SignatureWeapon:setShaderVector(1, 1, 1, 0, 0)
	SignatureWeapon:setShaderVector(2, 0, 0, 0, 0)
	SignatureWeapon:linkToElementModel(self, "primaryImage", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			SignatureWeapon:setImage(RegisterImage(f7_local0))
		end
	end)
	self:addElement(SignatureWeapon)
	self.SignatureWeapon = SignatureWeapon
	self:mergeStateConditions({
		{
			stateName = "CallingCard",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "category", @"hash_5A1163B4DB78960A")
			end,
		},
		{
			stateName = "OutfitPalette",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", @"palette")
			end,
		},
		{
			stateName = "OutfitWarpaint",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", @"war_paint")
			end,
		},
		{
			stateName = "SignatureWeapon",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", @"signature_weapon")
			end,
		},
		{
			stateName = "OutfitWarpaintBundle",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", @"hash_248B82A2276A1CAF")
			end,
		},
		{
			stateName = "OutfitBundle",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", @"outfit_bundle")
			end,
		},
		{
			stateName = "Character",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", @"character")
			end,
		},
	})
	self:linkToElementModel(self, "category", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "category",
		})
	end)
	self:linkToElementModel(self, "itemCategory", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemCategory",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SupplyChainContentImage.__resetProperties = function(f17_arg0)
	f17_arg0.CallingCardImage:completeAnimation()
	f17_arg0.FixedAspectRatioImage:completeAnimation()
	f17_arg0.OutfitPalette:completeAnimation()
	f17_arg0.SignatureWeapon:completeAnimation()
	f17_arg0.Character:completeAnimation()
	f17_arg0.CallingCardImage:setAlpha(0)
	f17_arg0.FixedAspectRatioImage:setAlpha(1)
	f17_arg0.OutfitPalette:setAlpha(0)
	f17_arg0.SignatureWeapon:setAlpha(0)
	f17_arg0.Character:setAlpha(0)
end
CoD.SupplyChainContentImage.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(0)
		end,
	},
	CallingCard = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			f19_arg0.FixedAspectRatioImage:completeAnimation()
			f19_arg0.FixedAspectRatioImage:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.FixedAspectRatioImage)
			f19_arg0.CallingCardImage:completeAnimation()
			f19_arg0.CallingCardImage:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.CallingCardImage)
		end,
	},
	OutfitPalette = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.FixedAspectRatioImage:completeAnimation()
			f20_arg0.FixedAspectRatioImage:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.FixedAspectRatioImage)
			f20_arg0.OutfitPalette:completeAnimation()
			f20_arg0.OutfitPalette:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.OutfitPalette)
		end,
	},
	OutfitWarpaint = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.FixedAspectRatioImage:completeAnimation()
			f21_arg0.FixedAspectRatioImage:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.FixedAspectRatioImage)
			f21_arg0.OutfitPalette:completeAnimation()
			f21_arg0.OutfitPalette:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.OutfitPalette)
		end,
	},
	SignatureWeapon = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.FixedAspectRatioImage:completeAnimation()
			f22_arg0.FixedAspectRatioImage:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.FixedAspectRatioImage)
			f22_arg0.SignatureWeapon:completeAnimation()
			f22_arg0.SignatureWeapon:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.SignatureWeapon)
		end,
	},
	OutfitWarpaintBundle = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			f23_arg0.FixedAspectRatioImage:completeAnimation()
			f23_arg0.FixedAspectRatioImage:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.FixedAspectRatioImage)
			f23_arg0.OutfitPalette:completeAnimation()
			f23_arg0.OutfitPalette:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.OutfitPalette)
		end,
	},
	OutfitBundle = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.FixedAspectRatioImage:completeAnimation()
			f24_arg0.FixedAspectRatioImage:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.FixedAspectRatioImage)
			f24_arg0.OutfitPalette:completeAnimation()
			f24_arg0.OutfitPalette:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.OutfitPalette)
		end,
	},
	Character = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(2)
			f25_arg0.FixedAspectRatioImage:completeAnimation()
			f25_arg0.FixedAspectRatioImage:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.FixedAspectRatioImage)
			f25_arg0.Character:completeAnimation()
			f25_arg0.Character:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.Character)
		end,
	},
}
CoD.SupplyChainContentImage.__onClose = function(f26_arg0)
	f26_arg0.FixedAspectRatioImage:close()
	f26_arg0.CallingCardImage:close()
	f26_arg0.OutfitPalette:close()
	f26_arg0.Character:close()
	f26_arg0.SignatureWeapon:close()
end
