require("x64:4a46c5eb417fe54")
CoD.PaintjobEditorSafeAreaContainer = InheritFrom(LUI.UIElement)
CoD.PaintjobEditorSafeAreaContainer.__defaultWidth = 1920
CoD.PaintjobEditorSafeAreaContainer.__defaultHeight = 1080
CoD.PaintjobEditorSafeAreaContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PaintjobEditorSafeAreaContainer)
	self.id = "PaintjobEditorSafeAreaContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local layerProperties = CoD.EmblemEditorLayerProperties.new(f1_arg0, f1_arg1, 0.5, 0.5, -347.5, 347.5, 0, 0, 51, 335)
	layerProperties:mergeStateConditions({
		{
			stateName = "KBMEditMode",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "Emblem.EmblemProperties.editorMode", Enum[0x3ED85BA45B1D650][0xE2FFAEFF67F59AD])
			end,
		},
		{
			stateName = "EditModeLayerProperties",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "Emblem.EmblemProperties.editorMode", Enum[0x3ED85BA45B1D650][0xE2FFAEFF67F59AD])
			end,
		},
	})
	layerProperties:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState(layerProperties, f4_arg1)
	end)
	local f1_local2 = layerProperties
	local f1_local3 = layerProperties.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4.LastInput, function(f5_arg0)
		f1_arg0:updateElementState(layerProperties, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	f1_local2 = layerProperties
	f1_local3 = layerProperties.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["Emblem.EmblemProperties.editorMode"], function(f6_arg0)
		f1_arg0:updateElementState(layerProperties, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "Emblem.EmblemProperties.editorMode",
		})
	end, false)
	layerProperties:subscribeToGlobalModel(f1_arg1, "EmblemSelectedLayerProperties", nil, function(model)
		layerProperties:setModel(model, f1_arg1)
	end)
	self:addElement(layerProperties)
	self.layerProperties = layerProperties
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PaintjobEditorSafeAreaContainer.__onClose = function(f8_arg0)
	f8_arg0.layerProperties:close()
end
