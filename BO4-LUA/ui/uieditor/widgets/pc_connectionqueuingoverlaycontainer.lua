require("x64:c91014522ded74e")
CoD.PC_ConnectionQueuingOverlayContainer = InheritFrom(LUI.UIElement)
CoD.PC_ConnectionQueuingOverlayContainer.__defaultWidth = 1920
CoD.PC_ConnectionQueuingOverlayContainer.__defaultHeight = 1080
CoD.PC_ConnectionQueuingOverlayContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_ConnectionQueuingOverlayContainer)
	self.id = "PC_ConnectionQueuingOverlayContainer"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PCConnectionQueuingOverlayContainer = CoD.PC_ConnectionQueuingOverlay.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -142.5, 142.5)
	PCConnectionQueuingOverlayContainer:setAlpha(0)
	PCConnectionQueuingOverlayContainer:linkToElementModel(self, nil, false, function(model)
		PCConnectionQueuingOverlayContainer:setModel(model, f1_arg1)
	end)
	self:addElement(PCConnectionQueuingOverlayContainer)
	self.PCConnectionQueuingOverlayContainer = PCConnectionQueuingOverlayContainer
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "IsInConnectionQueue")
			end,
		},
	})
	self:linkToElementModel(self, "IsInConnectionQueue", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "IsInConnectionQueue",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_ConnectionQueuingOverlayContainer.__resetProperties = function(f5_arg0)
	f5_arg0.PCConnectionQueuingOverlayContainer:completeAnimation()
	f5_arg0.PCConnectionQueuingOverlayContainer:setAlpha(0)
end
CoD.PC_ConnectionQueuingOverlayContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.PCConnectionQueuingOverlayContainer:completeAnimation()
			f7_arg0.PCConnectionQueuingOverlayContainer:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.PCConnectionQueuingOverlayContainer)
		end,
	},
}
CoD.PC_ConnectionQueuingOverlayContainer.__onClose = function(f8_arg0)
	f8_arg0.PCConnectionQueuingOverlayContainer:close()
end
