require("x64:b178a9bdf017263")
require("x64:d6dc417b7bcb1f0")
CoD.WeaponPersonalizationOptionsContainer = InheritFrom(LUI.UIElement)
CoD.WeaponPersonalizationOptionsContainer.__defaultWidth = 1745
CoD.WeaponPersonalizationOptionsContainer.__defaultHeight = 270
CoD.WeaponPersonalizationOptionsContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 20, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.WeaponPersonalizationOptionsContainer)
	self.id = "WeaponPersonalizationOptionsContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PersonalizeSlotContainer = CoD.WeaponPersonalizeSlotContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -872.5, -742.5, 0, 0, 4, 272)
	PersonalizeSlotContainer:linkToElementModel(self, nil, false, function(model)
		PersonalizeSlotContainer:setModel(model, f1_arg1)
	end)
	self:addElement(PersonalizeSlotContainer)
	self.PersonalizeSlotContainer = PersonalizeSlotContainer
	local Linker2 = LUI.UIImage.new(0.5, 0.5, -737.5, -733.5, 0, 0, 0, 269)
	Linker2:setAlpha(0.05)
	Linker2:setImage(RegisterImage(0xC49B0C8991A541F))
	Linker2:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	Linker2:setShaderVector(0, 0, 0, 0, 0)
	Linker2:setupNineSliceShader(4, 8)
	self:addElement(Linker2)
	self.Linker2 = Linker2
	local CamoOptions = CoD.CamoFilterButtonList.new(f1_arg0, f1_arg1, 0.5, 0.5, -713.5, -463.5, 0, 0, 0, 233)
	CamoOptions:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	self:addElement(CamoOptions)
	self.CamoOptions = CamoOptions
	local Linker = LUI.UIImage.new(0.5, 0.5, -443.5, -439.5, 0, 0, 0, 269)
	Linker:setAlpha(0.05)
	Linker:setImage(RegisterImage(0xC49B0C8991A541F))
	Linker:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	Linker:setShaderVector(0, 0, 0, 0, 0)
	Linker:setupNineSliceShader(4, 8)
	self:addElement(Linker)
	self.Linker = Linker
	local CamoListFrame = LUI.UIFrame.new(f1_arg0, f1_arg1, 0, 0, false)
	CamoListFrame:setLeftRight(0.5, 0.5, -419.5, 872.5)
	CamoListFrame:setTopBottom(0, 0, -53, 269)
	self:addElement(CamoListFrame)
	self.CamoListFrame = CamoListFrame
	self:mergeStateConditions({
		{
			stateName = "AllVisible",
			condition = function(menu, element, event)
				local f4_local0 = CoD.BlackMarketUtility.IsCurrentLootSeasonAtLeast(4)
				if f4_local0 then
					f4_local0 = CoD.WeaponOptionsUtility.IsBlackMarketCamoFilter()
					if f4_local0 then
						f4_local0 = not CoD.WeaponOptionsUtility.ShouldHideBlackMarketCamoFilters(menu)
					end
				end
				return f4_local0
			end,
		},
		{
			stateName = "CamoOptionsVisible",
			condition = function(menu, element, event)
				return CoD.WeaponOptionsUtility.IsBlackMarketCamoFilter() and not CoD.WeaponOptionsUtility.ShouldHideBlackMarketCamoFilters(menu)
			end,
		},
		{
			stateName = "PersonalizeSlotsVisible",
			condition = function(menu, element, event)
				return CoD.BlackMarketUtility.IsCurrentLootSeasonAtLeast(4)
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = DataSources.AutoEvents.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.cycled, function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "cycled",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["WeaponPersonalization.listUpdate"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "WeaponPersonalization.listUpdate",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f9_arg2, f9_arg3, f9_arg4)
		if CoD.BaseUtility.IsSelfInEitherState(self, "AllVisible", "CamoOptionsVisible") then
			CoD.BaseUtility.SetDefaultFocusToElement(self, self.CamoOptions)
		elseif not CoD.BaseUtility.IsSelfInEitherState(self, "AllVisible", "CamoOptionsVisible") then
			CoD.BaseUtility.SetDefaultFocusToElement(self, self.CamoListFrame)
		end
	end)
	PersonalizeSlotContainer.id = "PersonalizeSlotContainer"
	CamoOptions.id = "CamoOptions"
	CamoListFrame.id = "CamoListFrame"
	self.__defaultFocus = CamoListFrame
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local7 = self
	f1_local7 = CamoListFrame
	if IsPC() then
		CoD.PCUtility.SetForceMouseEventDispatch(self, true)
	end
	return self
end
CoD.WeaponPersonalizationOptionsContainer.__resetProperties = function(f10_arg0)
	f10_arg0.Linker:completeAnimation()
	f10_arg0.CamoOptions:completeAnimation()
	f10_arg0.Linker2:completeAnimation()
	f10_arg0.PersonalizeSlotContainer:completeAnimation()
	f10_arg0.Linker:setAlpha(0.05)
	f10_arg0.CamoOptions:setAlpha(1)
	f10_arg0.Linker2:setAlpha(0.05)
	f10_arg0.PersonalizeSlotContainer:setAlpha(1)
end
CoD.WeaponPersonalizationOptionsContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(4)
			f11_arg0.PersonalizeSlotContainer:completeAnimation()
			f11_arg0.PersonalizeSlotContainer:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.PersonalizeSlotContainer)
			f11_arg0.Linker2:completeAnimation()
			f11_arg0.Linker2:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Linker2)
			f11_arg0.CamoOptions:completeAnimation()
			f11_arg0.CamoOptions:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.CamoOptions)
			f11_arg0.Linker:completeAnimation()
			f11_arg0.Linker:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Linker)
		end,
	},
	AllVisible = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
	CamoOptionsVisible = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.PersonalizeSlotContainer:completeAnimation()
			f13_arg0.PersonalizeSlotContainer:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.PersonalizeSlotContainer)
			f13_arg0.Linker2:completeAnimation()
			f13_arg0.Linker2:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Linker2)
		end,
	},
	PersonalizeSlotsVisible = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.CamoOptions:completeAnimation()
			f14_arg0.CamoOptions:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.CamoOptions)
			f14_arg0.Linker:completeAnimation()
			f14_arg0.Linker:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Linker)
		end,
	},
}
CoD.WeaponPersonalizationOptionsContainer.__onClose = function(f15_arg0)
	f15_arg0.PersonalizeSlotContainer:close()
	f15_arg0.CamoOptions:close()
	f15_arg0.CamoListFrame:close()
end
