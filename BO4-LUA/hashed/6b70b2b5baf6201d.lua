CoD.Hud_ZM_LastStand_Bleedout_Perk_Bar_Item_Perk = InheritFrom(LUI.UIElement)
CoD.Hud_ZM_LastStand_Bleedout_Perk_Bar_Item_Perk.__defaultWidth = 64
CoD.Hud_ZM_LastStand_Bleedout_Perk_Bar_Item_Perk.__defaultHeight = 64
CoD.Hud_ZM_LastStand_Bleedout_Perk_Bar_Item_Perk.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Hud_ZM_LastStand_Bleedout_Perk_Bar_Item_Perk)
	self.id = "Hud_ZM_LastStand_Bleedout_Perk_Bar_Item_Perk"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StoneTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	StoneTiledBacking:setRGB(1, 0, 0)
	StoneTiledBacking:setAlpha(0.8)
	StoneTiledBacking:setImage(RegisterImage(0x33757173B476ACD))
	StoneTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	StoneTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	StoneTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(StoneTiledBacking)
	self.StoneTiledBacking = StoneTiledBacking
	local SkullImage = LUI.UIImage.new(0, 0, 7, 57, 0, 0, 7, 57)
	SkullImage:setAlpha(0)
	SkullImage:setImage(RegisterImage(0x46815DFE3BE2F29))
	self:addElement(SkullImage)
	self.SkullImage = SkullImage
	local PerkIcon = LUI.UIImage.new(0, 0, 7, 57, 0, 0, 7, 57)
	PerkIcon:setRGB(0.79, 0.79, 0.79)
	PerkIcon:setAlpha(0.5)
	PerkIcon:setMaterial(LUI.UIImage.GetCachedMaterial(0x67D1E3A3D2D1BF))
	PerkIcon:setShaderVector(0, 0, 0, 0, 0)
	PerkIcon:linkToElementModel(self, "itemIndex", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PerkIcon:setImage(RegisterImage(GetItemImageFromIndex(Enum[0x6EB546760F890D2][0x9AF82A21BAD026D], f2_local0)))
		end
	end)
	self:addElement(PerkIcon)
	self.PerkIcon = PerkIcon
	local PerkIcon2 = LUI.UIImage.new(0, 0, 7, 57, 0, 0, 7, 57)
	PerkIcon2:setMaterial(LUI.UIImage.GetCachedMaterial(0x316E67E1DF2198E))
	PerkIcon2:setShaderVector(1, 0, 0, 0, 0)
	PerkIcon2:setShaderVector(2, 1, 0, 0, 0)
	PerkIcon2:setShaderVector(3, 0, 0, 0, 0)
	PerkIcon2:setShaderVector(4, 0, 0, 0, 0)
	PerkIcon2:linkToElementModel(self, "itemIndex", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			PerkIcon2:setImage(RegisterImage(GetItemImageFromIndex(Enum[0x6EB546760F890D2][0x9AF82A21BAD026D], f3_local0)))
		end
	end)
	PerkIcon2:linkToElementModel(self, "bleedoutProgress", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			PerkIcon2:setShaderVector(0, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4))
		end
	end)
	self:addElement(PerkIcon2)
	self.PerkIcon2 = PerkIcon2
	self:mergeStateConditions({
		{
			stateName = "Skull",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isFirst")
			end,
		},
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnumEitherValue(element, f1_arg1, "state", CoD.ZMPerkUtility.PerkVaporStates.DEFAULT, CoD.ZMPerkUtility.PerkVaporStates.HIDDEN)
			end,
		},
		{
			stateName = "Perk",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "bleedoutProgress", 0)
			end,
		},
	})
	self:linkToElementModel(self, "isFirst", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isFirst",
		})
	end)
	self:linkToElementModel(self, "state", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "state",
		})
	end)
	self:linkToElementModel(self, "bleedoutProgress", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "bleedoutProgress",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Hud_ZM_LastStand_Bleedout_Perk_Bar_Item_Perk.__resetProperties = function(f11_arg0)
	f11_arg0.PerkIcon:completeAnimation()
	f11_arg0.SkullImage:completeAnimation()
	f11_arg0.PerkIcon2:completeAnimation()
	f11_arg0.PerkIcon:setAlpha(0.5)
	f11_arg0.SkullImage:setAlpha(0)
	f11_arg0.PerkIcon2:setAlpha(1)
end
CoD.Hud_ZM_LastStand_Bleedout_Perk_Bar_Item_Perk.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.SkullImage:completeAnimation()
			f12_arg0.SkullImage:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.SkullImage)
			f12_arg0.PerkIcon:completeAnimation()
			f12_arg0.PerkIcon:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.PerkIcon)
		end,
	},
	Skull = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			f13_arg0.SkullImage:completeAnimation()
			f13_arg0.SkullImage:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.SkullImage)
			f13_arg0.PerkIcon:completeAnimation()
			f13_arg0.PerkIcon:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.PerkIcon)
			f13_arg0.PerkIcon2:completeAnimation()
			f13_arg0.PerkIcon2:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.PerkIcon2)
		end,
	},
	Empty = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.PerkIcon:completeAnimation()
			f14_arg0.PerkIcon:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.PerkIcon)
			f14_arg0.PerkIcon2:completeAnimation()
			f14_arg0.PerkIcon2:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.PerkIcon2)
		end,
	},
	Perk = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.SkullImage:completeAnimation()
			f15_arg0.SkullImage:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.SkullImage)
			f15_arg0.PerkIcon:completeAnimation()
			f15_arg0.PerkIcon:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.PerkIcon)
		end,
	},
}
CoD.Hud_ZM_LastStand_Bleedout_Perk_Bar_Item_Perk.__onClose = function(f16_arg0)
	f16_arg0.PerkIcon:close()
	f16_arg0.PerkIcon2:close()
end
