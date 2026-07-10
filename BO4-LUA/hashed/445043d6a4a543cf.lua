require("x64:62407f124c5a6f8")
CoD.AARTierRewardTypeImageContainer = InheritFrom(LUI.UIElement)
CoD.AARTierRewardTypeImageContainer.__defaultWidth = 310
CoD.AARTierRewardTypeImageContainer.__defaultHeight = 632
CoD.AARTierRewardTypeImageContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARTierRewardTypeImageContainer)
	self.id = "AARTierRewardTypeImageContainer"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -146, 146, 0, 0, 28, 404)
	Image:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	Image:setShaderVector(0, 0.5, 0.5, 0, 0)
	Image:setShaderVector(1, 1, 1, 0, 0)
	Image:setShaderVector(2, 0, 0, 0, 0)
	Image:setStretchedDimension(4)
	Image:linkToElementModel(self, "primaryImage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Image:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Image)
	self.Image = Image
	local ContrabandImage = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -146, 146, 0, 0, 49.5, 382.5)
	ContrabandImage:setAlpha(0)
	ContrabandImage:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	ContrabandImage:setShaderVector(0, 0.5, 0.5, 0, 0)
	ContrabandImage:setShaderVector(1, 1, 1, 0, 0)
	ContrabandImage:setShaderVector(2, 0, 0, 0, 0)
	ContrabandImage:setStretchedDimension(4)
	ContrabandImage:linkToElementModel(self, "primaryImage", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ContrabandImage:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(ContrabandImage)
	self.ContrabandImage = ContrabandImage
	local CallingCardImage = CoD.CallingCardImage.new(f1_arg0, f1_arg1, 0.5, 0.5, -153.5, 153.5, 0.5, 0.5, -209.5, -9.5)
	CallingCardImage:setAlpha(0)
	CallingCardImage:linkToElementModel(self, nil, false, function(model)
		CallingCardImage:setModel(model, f1_arg1)
	end)
	CallingCardImage:linkToElementModel(self, "primaryImage", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			CallingCardImage.Image:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(CallingCardImage)
	self.CallingCardImage = CallingCardImage
	local CharacterImage = LUI.UIImage.new(0.5, 0.5, -146, 146, 0, 0, 28, 406)
	CharacterImage:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	CharacterImage:setShaderVector(0, 0, 0, 0, 0)
	CharacterImage:setShaderVector(1, 1, 1, 0, 0)
	CharacterImage:setShaderVector(2, 0, 0, 0, 0)
	CharacterImage:linkToElementModel(self, "primaryImage", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			CharacterImage:setImage(RegisterImage(f6_local0))
		end
	end)
	self:addElement(CharacterImage)
	self.CharacterImage = CharacterImage
	local WarPaint = LUI.UIImage.new(0.5, 0.5, -110, 110, 0, 0, 106, 326)
	WarPaint:setAlpha(0)
	WarPaint:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	WarPaint:setShaderVector(0, 0.5, 0.5, 0, 0)
	WarPaint:setShaderVector(1, 1.1, 1.1, 0, 0)
	WarPaint:setShaderVector(2, 0, 0, 0, 0)
	WarPaint:linkToElementModel(self, "primaryImage", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			WarPaint:setImage(RegisterImage(f7_local0))
		end
	end)
	self:addElement(WarPaint)
	self.WarPaint = WarPaint
	local Decal = LUI.UIImage.new(0.5, 0.5, -100, 100, 0, 0, 116, 316)
	Decal:setAlpha(0)
	Decal:linkToElementModel(self, "primaryImage", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			Decal:setImage(RegisterImage(f8_local0))
		end
	end)
	self:addElement(Decal)
	self.Decal = Decal
	self:mergeStateConditions({
		{
			stateName = "Contraband",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", 0x37934F15B706913)
			end,
		},
		{
			stateName = "CallingCard",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", 0xCA2BC08C1A6BCF6)
			end,
		},
		{
			stateName = "Character",
			condition = function(menu, element, event)
				return CoD.AARUtility.IsTierRewardCharacterType(self, f1_arg1)
			end,
		},
		{
			stateName = "WarPaint",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", 0xFB8B65946FBF7A2)
			end,
		},
		{
			stateName = "WarPaintBundle",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", 0x48B82A2276A1CAF)
			end,
		},
		{
			stateName = "Decal",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", 0x1FE4C75ACC7DF0E)
			end,
		},
	})
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
CoD.AARTierRewardTypeImageContainer.__resetProperties = function(f16_arg0)
	f16_arg0.CharacterImage:completeAnimation()
	f16_arg0.Image:completeAnimation()
	f16_arg0.ContrabandImage:completeAnimation()
	f16_arg0.CallingCardImage:completeAnimation()
	f16_arg0.WarPaint:completeAnimation()
	f16_arg0.Decal:completeAnimation()
	f16_arg0.CharacterImage:setAlpha(1)
	f16_arg0.Image:setAlpha(1)
	f16_arg0.ContrabandImage:setAlpha(0)
	f16_arg0.CallingCardImage:setAlpha(0)
	f16_arg0.WarPaint:setAlpha(0)
	f16_arg0.Decal:setAlpha(0)
end
CoD.AARTierRewardTypeImageContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.CharacterImage:completeAnimation()
			f17_arg0.CharacterImage:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.CharacterImage)
		end,
	},
	Contraband = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			f18_arg0.Image:completeAnimation()
			f18_arg0.Image:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.Image)
			f18_arg0.ContrabandImage:completeAnimation()
			f18_arg0.ContrabandImage:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.ContrabandImage)
			f18_arg0.CharacterImage:completeAnimation()
			f18_arg0.CharacterImage:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.CharacterImage)
		end,
	},
	CallingCard = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(3)
			f19_arg0.Image:completeAnimation()
			f19_arg0.Image:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.Image)
			f19_arg0.CallingCardImage:completeAnimation()
			f19_arg0.CallingCardImage:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.CallingCardImage)
			f19_arg0.CharacterImage:completeAnimation()
			f19_arg0.CharacterImage:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.CharacterImage)
		end,
	},
	Character = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.Image:completeAnimation()
			f20_arg0.Image:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Image)
		end,
	},
	WarPaint = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			f21_arg0.Image:completeAnimation()
			f21_arg0.Image:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Image)
			f21_arg0.CharacterImage:completeAnimation()
			f21_arg0.CharacterImage:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.CharacterImage)
			f21_arg0.WarPaint:completeAnimation()
			f21_arg0.WarPaint:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.WarPaint)
		end,
	},
	WarPaintBundle = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(3)
			f22_arg0.Image:completeAnimation()
			f22_arg0.Image:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.Image)
			f22_arg0.CharacterImage:completeAnimation()
			f22_arg0.CharacterImage:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.CharacterImage)
			f22_arg0.WarPaint:completeAnimation()
			f22_arg0.WarPaint:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.WarPaint)
		end,
	},
	Decal = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(3)
			f23_arg0.Image:completeAnimation()
			f23_arg0.Image:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.Image)
			f23_arg0.CharacterImage:completeAnimation()
			f23_arg0.CharacterImage:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.CharacterImage)
			f23_arg0.Decal:completeAnimation()
			f23_arg0.Decal:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.Decal)
		end,
	},
}
CoD.AARTierRewardTypeImageContainer.__onClose = function(f24_arg0)
	f24_arg0.Image:close()
	f24_arg0.ContrabandImage:close()
	f24_arg0.CallingCardImage:close()
	f24_arg0.CharacterImage:close()
	f24_arg0.WarPaint:close()
	f24_arg0.Decal:close()
end
