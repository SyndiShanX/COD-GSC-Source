require("x64:2beee84909edb17")
CoD.ReservesContentImage = InheritFrom(LUI.UIElement)
CoD.ReservesContentImage.__defaultWidth = 292
CoD.ReservesContentImage.__defaultHeight = 351
CoD.ReservesContentImage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReservesContentImage)
	self.id = "ReservesContentImage"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -146, 146, 0, 0, 0, 378)
	Image:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1A02C44161370F6D"))
	Image:setShaderVector(0, 0, 0, 0, 0)
	Image:setShaderVector(1, 1, 1, 0, 0)
	Image:setShaderVector(2, 0, 0, 0, 0)
	Image:setStretchedDimension(6)
	Image:linkToElementModel(self, "primaryImage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Image:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Image)
	self.Image = Image
	local Camo = LUI.UIImage.new(0, 0, 0, 292, 0, 0, 81.5, 296.5)
	Camo:setAlpha(0)
	Camo:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1A02C44161370F6D"))
	Camo:setShaderVector(0, 0.65, 0, 0, 0)
	Camo:setShaderVector(1, 1, 1, 0, 0)
	Camo:setShaderVector(2, 0, 0, 0, 0)
	Camo:linkToElementModel(self, "primaryImage", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Camo:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(Camo)
	self.Camo = Camo
	local BMReservesCharm = CoD.BM_Reserves_Charm.new(f1_arg0, f1_arg1, 0.5, 0.5, -146, 146, 0, 0, 11, 362)
	BMReservesCharm:linkToElementModel(self, nil, false, function(model)
		BMReservesCharm:setModel(model, f1_arg1)
	end)
	self:addElement(BMReservesCharm)
	self.BMReservesCharm = BMReservesCharm
	self:mergeStateConditions({
		{
			stateName = "CamoImage",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", @"single_camo")
			end,
		},
		{
			stateName = "CharmOrDeathFX",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEitherValue(self, f1_arg1, "itemCategory", @"single_weapon_charm", @"hash_1AD68520D53FDBFB")
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
CoD.ReservesContentImage.__resetProperties = function(f8_arg0)
	f8_arg0.BMReservesCharm:completeAnimation()
	f8_arg0.Image:completeAnimation()
	f8_arg0.Camo:completeAnimation()
	f8_arg0.BMReservesCharm:setAlpha(1)
	f8_arg0.Image:setAlpha(1)
	f8_arg0.Camo:setAlpha(0)
end
CoD.ReservesContentImage.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.BMReservesCharm:completeAnimation()
			f9_arg0.BMReservesCharm:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.BMReservesCharm)
		end,
	},
	CamoImage = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			f10_arg0.Image:completeAnimation()
			f10_arg0.Image:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Image)
			f10_arg0.Camo:completeAnimation()
			f10_arg0.Camo:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.Camo)
			f10_arg0.BMReservesCharm:completeAnimation()
			f10_arg0.BMReservesCharm:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.BMReservesCharm)
		end,
	},
	CharmOrDeathFX = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.Image:completeAnimation()
			f11_arg0.Image:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Image)
		end,
	},
}
CoD.ReservesContentImage.__onClose = function(f12_arg0)
	f12_arg0.Image:close()
	f12_arg0.Camo:close()
	f12_arg0.BMReservesCharm:close()
end
