require("x64:809a0a8e6f85f74")
CoD.VehicleSeatConfig = InheritFrom(LUI.UIElement)
CoD.VehicleSeatConfig.__defaultWidth = 150
CoD.VehicleSeatConfig.__defaultHeight = 300
CoD.VehicleSeatConfig.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VehicleSeatConfig)
	self.id = "VehicleSeatConfig"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local VehicleSeatConfigInternal = CoD.VehicleSeatConfig_Internal.new(f1_arg0, f1_arg1, 0, 0, 0, 150, 0, 0, 0, 300)
	VehicleSeatConfigInternal:linkToElementModel(self, nil, false, function(model)
		VehicleSeatConfigInternal:setModel(model, f1_arg1)
	end)
	self:addElement(VehicleSeatConfigInternal)
	self.VehicleSeatConfigInternal = VehicleSeatConfigInternal
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showSeatMap")
			end,
		},
	})
	self:linkToElementModel(self, "showSeatMap", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "showSeatMap",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.VehicleSeatConfig.__resetProperties = function(f5_arg0)
	f5_arg0.VehicleSeatConfigInternal:completeAnimation()
	f5_arg0.VehicleSeatConfigInternal:setAlpha(1)
end
CoD.VehicleSeatConfig.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.VehicleSeatConfigInternal:completeAnimation()
			f6_arg0.VehicleSeatConfigInternal:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.VehicleSeatConfigInternal)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.VehicleSeatConfig.__onClose = function(f8_arg0)
	f8_arg0.VehicleSeatConfigInternal:close()
end
