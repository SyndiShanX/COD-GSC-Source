CoD.VehicleGround_IrisOutterDigi = InheritFrom(LUI.UIElement)
CoD.VehicleGround_IrisOutterDigi.__defaultWidth = 1920
CoD.VehicleGround_IrisOutterDigi.__defaultHeight = 1080
CoD.VehicleGround_IrisOutterDigi.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VehicleGround_IrisOutterDigi)
	self.id = "VehicleGround_IrisOutterDigi"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local IrisOutterDigiL = LUI.UIImage.new(0, 0, 0, 600, 0, 1, 0, 0)
	IrisOutterDigiL:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_ground_irisoutterdigil"))
	IrisOutterDigiL:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(IrisOutterDigiL)
	self.IrisOutterDigiL = IrisOutterDigiL
	local IrisOutterDigiR = LUI.UIImage.new(1, 1, -540, 0, 0, 1, 0, 0)
	IrisOutterDigiR:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_ground_irisoutterdigir"))
	IrisOutterDigiR:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(IrisOutterDigiR)
	self.IrisOutterDigiR = IrisOutterDigiR
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
