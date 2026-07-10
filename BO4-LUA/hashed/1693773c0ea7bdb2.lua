CoD.WZStatusIcon = InheritFrom(LUI.UIElement)
CoD.WZStatusIcon.__defaultWidth = 44
CoD.WZStatusIcon.__defaultHeight = 44
CoD.WZStatusIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZStatusIcon)
	self.id = "WZStatusIcon"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StatusIcon = LUI.UIImage.new(0.5, 0.5, -24, 24, 0.5, 0.5, -24, 24)
	StatusIcon:setScale(0.7, 0.7)
	StatusIcon:linkToElementModel(self, "inGamePlayerStatus", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			StatusIcon:setImage(RegisterImage(CoD.WZUtility.GetTeamPlayerStatusImage(f2_local0)))
		end
	end)
	self:addElement(StatusIcon)
	self.StatusIcon = StatusIcon
	local VehicleBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	VehicleBacking:setAlpha(0)
	VehicleBacking:setScale(0.98, 0.98)
	VehicleBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_edges"))
	VehicleBacking:setShaderVector(0, 0.05, 0.05, 0.05, 0.05)
	VehicleBacking.__Color = function(f3_arg0)
		local f3_local0 = f3_arg0:get()
		if f3_local0 ~= nil then
			VehicleBacking:setRGB(CoD.WZUtility.TeamPlayerColorForTeammateIndex(f1_arg1, f3_local0))
		end
	end
	VehicleBacking:linkToElementModel(self, "teammateIndex", true, VehicleBacking.__Color)
	VehicleBacking.__Color_FullPath = function()
		local f4_local0 = self:getModel()
		if f4_local0 then
			f4_local0 = self:getModel()
			f4_local0 = f4_local0.teammateIndex
		end
		if f4_local0 then
			VehicleBacking.__Color(f4_local0)
		end
	end
	self:addElement(VehicleBacking)
	self.VehicleBacking = VehicleBacking
	local VehicleIcon = LUI.UIImage.new(-0, 1, 0, 0, 0, 1, 0, 0)
	VehicleIcon:setAlpha(0)
	VehicleIcon:linkToElementModel(self, "usingVehicleIcon", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			VehicleIcon:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(VehicleIcon)
	self.VehicleIcon = VehicleIcon
	local ParachuteClientIcon = LUI.UIImage.new(0, 0, 0, 44, 0, 0, 0, 44)
	ParachuteClientIcon:setImage(RegisterImage(@"hash_2A912D9E22E33B69"))
	ParachuteClientIcon.__Color = function(f6_arg0)
		local f6_local0 = f6_arg0:get()
		if f6_local0 ~= nil then
			ParachuteClientIcon:setRGB(CoD.WZUtility.TeamPlayerColorForTeammateIndex(f1_arg1, f6_local0))
		end
	end
	ParachuteClientIcon:linkToElementModel(self, "teammateIndex", true, ParachuteClientIcon.__Color)
	ParachuteClientIcon.__Color_FullPath = function()
		local f7_local0 = self:getModel()
		if f7_local0 then
			f7_local0 = self:getModel()
			f7_local0 = f7_local0.teammateIndex
		end
		if f7_local0 then
			ParachuteClientIcon.__Color(f7_local0)
		end
	end
	ParachuteClientIcon:linkToElementModel(self, "clientNum", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			ParachuteClientIcon:setupParachuteClientIcon(f8_local0)
		end
	end)
	self:addElement(ParachuteClientIcon)
	self.ParachuteClientIcon = ParachuteClientIcon
	local WingsuitIcon = LUI.UIImage.new(0, 0, -2, 42, 0, 0, 0, 44)
	WingsuitIcon:setImage(RegisterImage(@"hash_19D3717D7C3A9ECC"))
	WingsuitIcon.__Color = function(f9_arg0)
		local f9_local0 = f9_arg0:get()
		if f9_local0 ~= nil then
			WingsuitIcon:setRGB(CoD.WZUtility.TeamPlayerColorForTeammateIndex(f1_arg1, f9_local0))
		end
	end
	WingsuitIcon:linkToElementModel(self, "teammateIndex", true, WingsuitIcon.__Color)
	WingsuitIcon.__Color_FullPath = function()
		local f10_local0 = self:getModel()
		if f10_local0 then
			f10_local0 = self:getModel()
			f10_local0 = f10_local0.teammateIndex
		end
		if f10_local0 then
			WingsuitIcon.__Color(f10_local0)
		end
	end
	WingsuitIcon:linkToElementModel(self, "clientNum", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			WingsuitIcon:setupWingsuitClientIcon(f11_local0)
		end
	end)
	self:addElement(WingsuitIcon)
	self.WingsuitIcon = WingsuitIcon
	VehicleBacking:linkToElementModel(self, "team", true, VehicleBacking.__Color_FullPath)
	local f1_local6 = VehicleBacking
	local f1_local7 = VehicleBacking.subscribeToModel
	local f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8["profile.colorblindMode"], VehicleBacking.__Color_FullPath)
	ParachuteClientIcon:linkToElementModel(self, "team", true, ParachuteClientIcon.__Color_FullPath)
	f1_local6 = ParachuteClientIcon
	f1_local7 = ParachuteClientIcon.subscribeToModel
	f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8["profile.colorblindMode"], ParachuteClientIcon.__Color_FullPath)
	WingsuitIcon:linkToElementModel(self, "team", true, WingsuitIcon.__Color_FullPath)
	f1_local6 = WingsuitIcon
	f1_local7 = WingsuitIcon.subscribeToModel
	f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8["profile.colorblindMode"], WingsuitIcon.__Color_FullPath)
	self:mergeStateConditions({
		{
			stateName = "InVehicle",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "inGamePlayerStatus", Enum[@"hash_14A07561A78E340B"][@"hash_7751743BBF671EDC"])
			end,
		},
	})
	self:linkToElementModel(self, "inGamePlayerStatus", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "inGamePlayerStatus",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZStatusIcon.__resetProperties = function(f14_arg0)
	f14_arg0.StatusIcon:completeAnimation()
	f14_arg0.VehicleIcon:completeAnimation()
	f14_arg0.VehicleBacking:completeAnimation()
	f14_arg0.StatusIcon:setAlpha(1)
	f14_arg0.VehicleIcon:setAlpha(0)
	f14_arg0.VehicleBacking:setAlpha(0)
end
CoD.WZStatusIcon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
	},
	InVehicle = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			f16_arg0.StatusIcon:completeAnimation()
			f16_arg0.StatusIcon:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.StatusIcon)
			f16_arg0.VehicleBacking:completeAnimation()
			f16_arg0.VehicleBacking:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.VehicleBacking)
			f16_arg0.VehicleIcon:completeAnimation()
			f16_arg0.VehicleIcon:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.VehicleIcon)
		end,
	},
}
CoD.WZStatusIcon.__onClose = function(f17_arg0)
	f17_arg0.StatusIcon:close()
	f17_arg0.VehicleBacking:close()
	f17_arg0.VehicleIcon:close()
	f17_arg0.ParachuteClientIcon:close()
	f17_arg0.WingsuitIcon:close()
end
