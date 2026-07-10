CoD.VehicleGround_IrisInner = InheritFrom(LUI.UIElement)
CoD.VehicleGround_IrisInner.__defaultWidth = 192
CoD.VehicleGround_IrisInner.__defaultHeight = 192
CoD.VehicleGround_IrisInner.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VehicleGround_IrisInner)
	self.id = "VehicleGround_IrisInner"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local IrisInner1 = LUI.UIImage.new(0.5, 0.5, -946, -754, 0.5, 0.5, -476, 460)
	IrisInner1:setImage(RegisterImage(0x83704B1DB4579A3))
	IrisInner1:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(IrisInner1)
	self.IrisInner1 = IrisInner1
	local IrisInner2 = LUI.UIImage.new(0.5, 0.5, 751, 943, 0.5, 0.5, -440, 496)
	IrisInner2:setZRot(-180)
	IrisInner2:setImage(RegisterImage(0x83704B1DB4579A3))
	IrisInner2:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(IrisInner2)
	self.IrisInner2 = IrisInner2
	local IrisInner3 = LUI.UIImage.new(0.5, 0.5, -491, -299, 0.5, 0.5, -1212, -276)
	IrisInner3:setZRot(-61)
	IrisInner3:setImage(RegisterImage(0x83704B1DB4579A3))
	IrisInner3:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(IrisInner3)
	self.IrisInner3 = IrisInner3
	local IrisInner4 = LUI.UIImage.new(0.5, 0.5, 395, 587, 0.5, 0.5, -1152, -216)
	IrisInner4:setZRot(-124)
	IrisInner4:setImage(RegisterImage(0x83704B1DB4579A3))
	IrisInner4:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(IrisInner4)
	self.IrisInner4 = IrisInner4
	local IrisInner5 = LUI.UIImage.new(0.5, 0.5, -491, -299, 0.5, 0.5, 279, 1215)
	IrisInner5:setXRot(-180)
	IrisInner5:setZRot(-61)
	IrisInner5:setImage(RegisterImage(0x83704B1DB4579A3))
	IrisInner5:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(IrisInner5)
	self.IrisInner5 = IrisInner5
	local IrisInner6 = LUI.UIImage.new(0.5, 0.5, 397, 589, 0.5, 0.5, 222, 1158)
	IrisInner6:setXRot(-180)
	IrisInner6:setZRot(-124)
	IrisInner6:setImage(RegisterImage(0x83704B1DB4579A3))
	IrisInner6:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(IrisInner6)
	self.IrisInner6 = IrisInner6
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return HideVehicleReticle(self, f1_arg1, event)
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = DataSources.VehicleInfo.getModel(f1_arg1)
	f1_local8(f1_local7, f1_local9.vehicleType, function(f3_arg0)
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
