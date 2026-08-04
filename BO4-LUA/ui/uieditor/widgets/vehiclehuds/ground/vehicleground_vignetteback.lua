CoD.VehicleGround_VignetteBack = InheritFrom(LUI.UIElement)
CoD.VehicleGround_VignetteBack.__defaultWidth = 1920
CoD.VehicleGround_VignetteBack.__defaultHeight = 1080
CoD.VehicleGround_VignetteBack.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VehicleGround_VignetteBack)
	self.id = "VehicleGround_VignetteBack"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local VignetteLL = LUI.UIImage.new(0, 0.5, 0, 0, 0.5, 1, 0, 0)
	VignetteLL:setImage(RegisterImage("uie_t7_cp_hud_vehicle_ground_vignette2"))
	VignetteLL:setMaterial(LUI.UIImage.GetCachedMaterial("ui_multiplyinverse"))
	self:addElement(VignetteLL)
	self.VignetteLL = VignetteLL
	local VignetteLR = LUI.UIImage.new(0.5, 1, 0, 0, 0.5, 1, 0, 0)
	VignetteLR:setYRot(-180)
	VignetteLR:setImage(RegisterImage("uie_t7_cp_hud_vehicle_ground_vignette2"))
	VignetteLR:setMaterial(LUI.UIImage.GetCachedMaterial("ui_multiplyinverse"))
	self:addElement(VignetteLR)
	self.VignetteLR = VignetteLR
	local VignetteUL = LUI.UIImage.new(0, 0.5, 0, 0, 0, 0.5, 0, 0)
	VignetteUL:setXRot(-180)
	VignetteUL:setImage(RegisterImage("uie_t7_cp_hud_vehicle_ground_vignette2"))
	VignetteUL:setMaterial(LUI.UIImage.GetCachedMaterial("ui_multiplyinverse"))
	self:addElement(VignetteUL)
	self.VignetteUL = VignetteUL
	local VignetteUR = LUI.UIImage.new(0.5, 1, 0, 0, 0, 0.5, 0, 0)
	VignetteUR:setXRot(-180)
	VignetteUR:setYRot(-180)
	VignetteUR:setImage(RegisterImage("uie_t7_cp_hud_vehicle_ground_vignette2"))
	VignetteUR:setMaterial(LUI.UIImage.GetCachedMaterial("ui_multiplyinverse"))
	self:addElement(VignetteUR)
	self.VignetteUR = VignetteUR
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
