CoD.VehicleGround_ModT6 = InheritFrom(LUI.UIElement)
CoD.VehicleGround_ModT6.__defaultWidth = 156
CoD.VehicleGround_ModT6.__defaultHeight = 54
CoD.VehicleGround_ModT6.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VehicleGround_ModT6)
	self.id = "VehicleGround_ModT6"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image6 = LUI.UIImage.new(0, 0, 0, 156, 0, 0, 0, 54)
	Image6:setImage(RegisterImage(0xE96C034BB099CD5))
	Image6:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Image6)
	self.Image6 = Image6
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return HideVehicleReticle(self, f1_arg1, event)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = DataSources.VehicleInfo.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.vehicleType, function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "vehicleType",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
