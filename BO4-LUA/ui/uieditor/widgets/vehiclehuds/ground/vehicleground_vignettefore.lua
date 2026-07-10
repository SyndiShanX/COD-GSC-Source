CoD.VehicleGround_VignetteFore = InheritFrom(LUI.UIElement)
CoD.VehicleGround_VignetteFore.__defaultWidth = 1920
CoD.VehicleGround_VignetteFore.__defaultHeight = 1080
CoD.VehicleGround_VignetteFore.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VehicleGround_VignetteFore)
	self.id = "VehicleGround_VignetteFore"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image0 = LUI.UIImage.new(0, 0, 0, 600, 1, 1, -516, 0)
	Image0:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_ground_vignette"))
	self:addElement(Image0)
	self.Image0 = Image0
	local Image1 = LUI.UIImage.new(1, 1, -600, 0, 1, 1, -516, 0)
	Image1:setYRot(-180)
	Image1:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_ground_vignette"))
	self:addElement(Image1)
	self.Image1 = Image1
	local Image2 = LUI.UIImage.new(0, 0, 0, 600, 0, 0, 0, 516)
	Image2:setXRot(-180)
	Image2:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_ground_vignette"))
	self:addElement(Image2)
	self.Image2 = Image2
	local Image3 = LUI.UIImage.new(1, 1, -600, 0, 0, 0, 0, 516)
	Image3:setXRot(-180)
	Image3:setYRot(-180)
	Image3:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_ground_vignette"))
	self:addElement(Image3)
	self.Image3 = Image3
	self:mergeStateConditions({
		{
			stateName = "LeavingOperationalZone",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "outOfRange")
			end,
		},
	})
	self:linkToElementModel(self, "outOfRange", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "outOfRange",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
