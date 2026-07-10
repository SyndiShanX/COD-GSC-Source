require("x64:bffd00ef1fc082")
CoD.SpecialistOutfitCategory = InheritFrom(LUI.UIElement)
CoD.SpecialistOutfitCategory.__defaultWidth = 280
CoD.SpecialistOutfitCategory.__defaultHeight = 69
CoD.SpecialistOutfitCategory.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialistOutfitCategory)
	self.id = "SpecialistOutfitCategory"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local internal = CoD.SpecialistOutfitCategory_Internal.new(f1_arg0, f1_arg1, 0, 0, 0, 280, 0, 0, 0, 69)
	internal:linkToElementModel(self, nil, false, function(model)
		internal:setModel(model, f1_arg1)
	end)
	self:addElement(internal)
	self.internal = internal
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "disabled")
			end,
		},
	})
	self:linkToElementModel(self, "disabled", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "disabled",
		})
	end)
	internal.id = "internal"
	self.__defaultFocus = internal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpecialistOutfitCategory.__resetProperties = function(f5_arg0)
	f5_arg0.internal:completeAnimation()
	f5_arg0.internal:setScale(1, 1)
end
CoD.SpecialistOutfitCategory.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.internal:completeAnimation()
			f6_arg0.internal:setScale(0.97, 0.96)
			f6_arg0.clipFinished(f6_arg0.internal)
		end,
		ChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.internal:completeAnimation()
			f7_arg0.internal:setScale(1.02, 1.03)
			f7_arg0.clipFinished(f7_arg0.internal)
		end,
	},
	Disabled = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.internal:completeAnimation()
			f8_arg0.internal:setScale(0.97, 0.96)
			f8_arg0.clipFinished(f8_arg0.internal)
		end,
	},
}
CoD.SpecialistOutfitCategory.__onClose = function(f9_arg0)
	f9_arg0.internal:close()
end
