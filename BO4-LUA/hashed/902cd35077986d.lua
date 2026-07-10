CoD.CamoDetailsSwatch = InheritFrom(LUI.UIElement)
CoD.CamoDetailsSwatch.__defaultWidth = 210
CoD.CamoDetailsSwatch.__defaultHeight = 331
CoD.CamoDetailsSwatch.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CamoDetailsSwatch)
	self.id = "CamoDetailsSwatch"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CamoSwatch = LUI.UIImage.new(0, 0, 0, 210, 0, 0, 0, 331)
	CamoSwatch:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CamoSwatch:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(CamoSwatch)
	self.CamoSwatch = CamoSwatch
	self:mergeStateConditions({
		{
			stateName = "ReactiveCamo",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "weaponOptionCategory", "active")
			end,
		},
		{
			stateName = "MastercraftCamo",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "weaponOptionCategory", "theme")
			end,
		},
		{
			stateName = "MasteryCamo",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "weaponOptionCategory", "mstr")
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
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CamoDetailsSwatch.__resetProperties = function(f7_arg0)
	f7_arg0.CamoSwatch:completeAnimation()
	f7_arg0.CamoSwatch:setLeftRight(0, 0, 0, 210)
	f7_arg0.CamoSwatch:setTopBottom(0, 0, 0, 331)
	f7_arg0.CamoSwatch:setAlpha(1)
end
CoD.CamoDetailsSwatch.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.CamoSwatch:completeAnimation()
			f8_arg0.CamoSwatch:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.CamoSwatch)
		end,
	},
	ReactiveCamo = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.CamoSwatch:completeAnimation()
			f9_arg0.CamoSwatch:setLeftRight(0, 0, 65, 210)
			f9_arg0.CamoSwatch:setTopBottom(0, 0, 0, 331)
			f9_arg0.clipFinished(f9_arg0.CamoSwatch)
		end,
	},
	MastercraftCamo = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.CamoSwatch:completeAnimation()
			f10_arg0.CamoSwatch:setLeftRight(0, 0, 0, 210)
			f10_arg0.CamoSwatch:setTopBottom(0, 0, 0, 331)
			f10_arg0.clipFinished(f10_arg0.CamoSwatch)
		end,
	},
	MasteryCamo = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.CamoSwatch:completeAnimation()
			f11_arg0.CamoSwatch:setLeftRight(0, 0, 45, 210)
			f11_arg0.CamoSwatch:setTopBottom(0, 0, 0, 80)
			f11_arg0.clipFinished(f11_arg0.CamoSwatch)
		end,
	},
}
CoD.CamoDetailsSwatch.__onClose = function(f12_arg0)
	f12_arg0.CamoSwatch:close()
end
