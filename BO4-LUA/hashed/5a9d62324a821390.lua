require("x64:62407f124c5a6f8")
CoD.PurchaseItemShopContentImage = InheritFrom(LUI.UIElement)
CoD.PurchaseItemShopContentImage.__defaultWidth = 832
CoD.PurchaseItemShopContentImage.__defaultHeight = 376
CoD.PurchaseItemShopContentImage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PurchaseItemShopContentImage)
	self.id = "PurchaseItemShopContentImage"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WarpaintBundle = LUI.UIFixedAspectRatioImage.new(0, 0, 418, 780, 0, 0, -8, 376)
	WarpaintBundle:setAlpha(0)
	WarpaintBundle:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	WarpaintBundle:setShaderVector(0, 0, 1, 0, 0)
	WarpaintBundle:setShaderVector(1, 0.52, 0.39, 0, 0)
	WarpaintBundle:setShaderVector(2, 0, 1, 0, 0)
	WarpaintBundle:setShaderVector(3, 0, 0, 0, 0)
	WarpaintBundle:setShaderVector(4, 0, 0, 0, 0)
	WarpaintBundle:linkToElementModel(self, "primaryImage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			WarpaintBundle:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(WarpaintBundle)
	self.WarpaintBundle = WarpaintBundle
	local CallingCardImage = CoD.CallingCardImage.new(f1_arg0, f1_arg1, 0.46, 0.46, -12, 423, 0.47, 0.47, -145, 173)
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
	local OutfitBundle = LUI.UIImage.new(0, 0, 478, 716, 0, 0, 76, 584)
	OutfitBundle:setAlpha(0)
	OutfitBundle:setScale(1.34, 1.34)
	OutfitBundle:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	OutfitBundle:setShaderVector(0, 0, 1, 0, 0)
	OutfitBundle:setShaderVector(1, 0.17, 0.16, 0, 0)
	OutfitBundle:setShaderVector(2, 0.08, 0.5, 0, 0)
	OutfitBundle:setShaderVector(3, 0.1, 0.09, 0, 0)
	OutfitBundle:setShaderVector(4, 0, 0, 0, 0)
	OutfitBundle:linkToElementModel(self, "primaryImage", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			OutfitBundle:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(OutfitBundle)
	self.OutfitBundle = OutfitBundle
	local OutfitPalette = LUI.UIImage.new(0, 0, 478, 716, 0, 0, 76, 313)
	OutfitPalette:setAlpha(0)
	OutfitPalette:setScale(1.34, 1.34)
	OutfitPalette:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1A02C44161370F6D"))
	OutfitPalette:setShaderVector(0, 0, 0.1, 0, 0)
	OutfitPalette:setShaderVector(1, 1, 1, 0, 0)
	OutfitPalette:setShaderVector(2, 0.2, 0.2, 0, 0)
	OutfitPalette:linkToElementModel(self, "primaryImage", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			OutfitPalette:setImage(RegisterImage(f6_local0))
		end
	end)
	self:addElement(OutfitPalette)
	self.OutfitPalette = OutfitPalette
	local Character = LUI.UIImage.new(0, 0, 478, 716, 0, 0, 76, 584)
	Character:setAlpha(0)
	Character:setScale(1.34, 1.34)
	Character:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	Character:setShaderVector(0, 0, 1, 0, 0)
	Character:setShaderVector(1, 0.17, 0.16, 0, 0)
	Character:setShaderVector(2, 0.08, 0.5, 0, 0)
	Character:setShaderVector(3, 0.1, 0.09, 0, 0)
	Character:setShaderVector(4, 0, 0, 0, 0)
	Character:linkToElementModel(self, "primaryImage", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			Character:setImage(RegisterImage(f7_local0))
		end
	end)
	self:addElement(Character)
	self.Character = Character
	local SignatureWeapon = LUI.UIImage.new(0.46, 0.46, -9.5, 238.5, 0.41, 0.41, -62.5, 185.5)
	SignatureWeapon:setAlpha(0)
	SignatureWeapon:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1A02C44161370F6D"))
	SignatureWeapon:setShaderVector(0, 0.5, 0.5, 0, 0)
	SignatureWeapon:setShaderVector(1, 1, 1, 0, 0)
	SignatureWeapon:setShaderVector(2, 0, 0, 0, 0)
	SignatureWeapon:linkToElementModel(self, "primaryImage", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			SignatureWeapon:setImage(RegisterImage(f8_local0))
		end
	end)
	self:addElement(SignatureWeapon)
	self.SignatureWeapon = SignatureWeapon
	local Default = LUI.UIFixedAspectRatioImage.new(0, 0, 407, 805, 0, 0, 16, 357)
	Default:setAlpha(0)
	Default:setStretchedDimension(6)
	Default:linkToElementModel(self, "primaryImage", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			Default:setImage(RegisterImage(f9_local0))
		end
	end)
	self:addElement(Default)
	self.Default = Default
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
		{
			stateName = "TriplePlay",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", @"special_bundle")
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
CoD.PurchaseItemShopContentImage.__resetProperties = function(f20_arg0)
	f20_arg0.OutfitBundle:completeAnimation()
	f20_arg0.Default:completeAnimation()
	f20_arg0.CallingCardImage:completeAnimation()
	f20_arg0.OutfitPalette:completeAnimation()
	f20_arg0.WarpaintBundle:completeAnimation()
	f20_arg0.SignatureWeapon:completeAnimation()
	f20_arg0.Character:completeAnimation()
	f20_arg0.OutfitBundle:setAlpha(0)
	f20_arg0.Default:setAlpha(0)
	f20_arg0.CallingCardImage:setAlpha(0)
	f20_arg0.OutfitPalette:setAlpha(0)
	f20_arg0.WarpaintBundle:setAlpha(0)
	f20_arg0.SignatureWeapon:setAlpha(0)
	f20_arg0.Character:setAlpha(0)
end
CoD.PurchaseItemShopContentImage.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.OutfitBundle:completeAnimation()
			f21_arg0.OutfitBundle:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.OutfitBundle)
			f21_arg0.Default:completeAnimation()
			f21_arg0.Default:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.Default)
		end,
	},
	CallingCard = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.CallingCardImage:completeAnimation()
			f22_arg0.CallingCardImage:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.CallingCardImage)
		end,
	},
	OutfitPalette = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			f23_arg0.OutfitPalette:completeAnimation()
			f23_arg0.OutfitPalette:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.OutfitPalette)
		end,
	},
	OutfitWarpaint = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			f24_arg0.WarpaintBundle:completeAnimation()
			f24_arg0.WarpaintBundle:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.WarpaintBundle)
		end,
	},
	SignatureWeapon = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			f25_arg0.SignatureWeapon:completeAnimation()
			f25_arg0.SignatureWeapon:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.SignatureWeapon)
		end,
	},
	OutfitWarpaintBundle = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			f26_arg0.WarpaintBundle:completeAnimation()
			f26_arg0.WarpaintBundle:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.WarpaintBundle)
		end,
	},
	OutfitBundle = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(1)
			f27_arg0.OutfitBundle:completeAnimation()
			f27_arg0.OutfitBundle:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.OutfitBundle)
		end,
	},
	Character = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(1)
			f28_arg0.Character:completeAnimation()
			f28_arg0.Character:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.Character)
		end,
	},
	TriplePlay = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(2)
			f29_arg0.OutfitBundle:completeAnimation()
			f29_arg0.OutfitBundle:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.OutfitBundle)
			f29_arg0.Default:completeAnimation()
			f29_arg0.Default:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.Default)
		end,
	},
}
CoD.PurchaseItemShopContentImage.__onClose = function(f30_arg0)
	f30_arg0.WarpaintBundle:close()
	f30_arg0.CallingCardImage:close()
	f30_arg0.OutfitBundle:close()
	f30_arg0.OutfitPalette:close()
	f30_arg0.Character:close()
	f30_arg0.SignatureWeapon:close()
	f30_arg0.Default:close()
end
