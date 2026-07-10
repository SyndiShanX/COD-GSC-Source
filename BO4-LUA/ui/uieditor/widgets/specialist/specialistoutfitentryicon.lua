CoD.SpecialistOutfitEntryIcon = InheritFrom(LUI.UIElement)
CoD.SpecialistOutfitEntryIcon.__defaultWidth = 121
CoD.SpecialistOutfitEntryIcon.__defaultHeight = 146
CoD.SpecialistOutfitEntryIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialistOutfitEntryIcon)
	self.id = "SpecialistOutfitEntryIcon"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Warpaint = LUI.UIImage.new(0, 1, 2, -2, 0, 1, 2, -2)
	Warpaint:setAlpha(0)
	Warpaint:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	Warpaint:setShaderVector(0, 0.5, 0, 0, 0)
	Warpaint:setShaderVector(1, 1, 1, 0, 0)
	Warpaint:setShaderVector(2, 0, 0, 0, 0)
	Warpaint:linkToElementModel(self, "icon", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Warpaint:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Warpaint)
	self.Warpaint = Warpaint
	local Outfit = LUI.UIImage.new(0, 1, 2, -2, 0, 1, 2, -2)
	Outfit:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	Outfit:setShaderVector(0, 0.5, 0, 0, 0)
	Outfit:setShaderVector(1, 1.05, 1.05, 0, 0)
	Outfit:setShaderVector(2, 0.04, 0, 0, 0)
	Outfit:linkToElementModel(self, "icon", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Outfit:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(Outfit)
	self.Outfit = Outfit
	self:mergeStateConditions({
		{
			stateName = "Warpaint",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "itemType", Enum[0xFCC6A2D2EB0FDA7][0x8E3A65D78229DC1])
			end,
		},
	})
	self:linkToElementModel(self, "itemType", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemType",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpecialistOutfitEntryIcon.__resetProperties = function(f6_arg0)
	f6_arg0.Outfit:completeAnimation()
	f6_arg0.Warpaint:completeAnimation()
	f6_arg0.Outfit:setAlpha(1)
	f6_arg0.Warpaint:setAlpha(0)
end
CoD.SpecialistOutfitEntryIcon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	Warpaint = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.Warpaint:completeAnimation()
			f8_arg0.Warpaint:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.Warpaint)
			f8_arg0.Outfit:completeAnimation()
			f8_arg0.Outfit:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Outfit)
		end,
	},
}
CoD.SpecialistOutfitEntryIcon.__onClose = function(f9_arg0)
	f9_arg0.Warpaint:close()
	f9_arg0.Outfit:close()
end
