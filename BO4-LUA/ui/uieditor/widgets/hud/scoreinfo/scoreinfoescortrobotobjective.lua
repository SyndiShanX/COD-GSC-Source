require("x64:27411b1d207dbc8")
CoD.ScoreInfoEscortRobotObjective = InheritFrom(LUI.UIElement)
CoD.ScoreInfoEscortRobotObjective.__defaultWidth = 76
CoD.ScoreInfoEscortRobotObjective.__defaultHeight = 76
CoD.ScoreInfoEscortRobotObjective.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScoreInfoEscortRobotObjective)
	self.id = "ScoreInfoEscortRobotObjective"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local HealthBacking = LUI.UIImage.new(0.5, 0.5, -20, 20, 0.5, 0.5, -19, 21)
	HealthBacking:setRGB(1, 0.98, 0.91)
	HealthBacking:linkToElementModel(self, "waypointBacking02", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			HealthBacking:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(HealthBacking)
	self.HealthBacking = HealthBacking
	local Health = LUI.UIImage.new(0, 0, 18, 58, 0, 0, 19, 59)
	Health:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_clock_normal"))
	Health:setShaderVector(1, 0.5, 0, 0, 0)
	Health:setShaderVector(2, 0.5, 0, 0, 0)
	Health:setShaderVector(3, 0, 0, 0, 0)
	Health:setShaderVector(4, 0, 0, 0, 0)
	Health.__Color = function(f3_arg0)
		local f3_local0 = f3_arg0:get()
		if f3_local0 ~= nil then
			Health:setRGB(CoD.HUDUtility.GetFriendlyOrEnemyColorByFlags(self:getModel(), f1_arg1, f3_local0))
		end
	end
	Health:linkToElementModel(self, "gamemodeFlags", true, Health.__Color)
	Health.__Color_FullPath = function()
		local f4_local0 = self:getModel()
		if f4_local0 then
			f4_local0 = self:getModel()
			f4_local0 = f4_local0.gamemodeFlags
		end
		if f4_local0 then
			Health.__Color(f4_local0)
		end
	end
	Health:linkToElementModel(self, "waypointBacking01", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Health:setImage(RegisterImage(f5_local0))
		end
	end)
	Health:linkToElementModel(self, "progress", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Health:setShaderVector(0, CoD.GetVectorComponentFromString(f6_local0, 1), CoD.GetVectorComponentFromString(f6_local0, 2), CoD.GetVectorComponentFromString(f6_local0, 3), CoD.GetVectorComponentFromString(f6_local0, 4))
		end
	end)
	self:addElement(Health)
	self.Health = Health
	local WaypointCenter = CoD.WaypointCenter.new(f1_arg0, f1_arg1, 0.5, 0.5, -38, 38, 0, 0, 1, 77)
	WaypointCenter:setScale(0.55, 0.55)
	WaypointCenter:linkToElementModel(self, nil, false, function(model)
		WaypointCenter:setModel(model, f1_arg1)
	end)
	self:addElement(WaypointCenter)
	self.WaypointCenter = WaypointCenter
	local WaypointCenterCodcaster = LUI.UIImage.new(0, 0, 27, 49, 0, 0, 28, 50)
	WaypointCenterCodcaster:setImage(RegisterImage(@"uie_t7_hud_waypoints_baseglow"))
	WaypointCenterCodcaster:linkToElementModel(self, "color", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			WaypointCenterCodcaster:setRGB(CoD.WaypointUtility.ConvertToBaseColor(f8_local0))
		end
	end)
	self:addElement(WaypointCenterCodcaster)
	self.WaypointCenterCodcaster = WaypointCenterCodcaster
	local f1_local5 = Health
	local f1_local6 = Health.subscribeToModel
	local f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["profile.colorblindMode"], Health.__Color_FullPath)
	self:mergeStateConditions({
		{
			stateName = "CodCaster",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg1) and CoD.HUDUtility.IsGameTypeEqualToString("escort")
			end,
		},
	})
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["factions.isCoDCaster"], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScoreInfoEscortRobotObjective.__resetProperties = function(f11_arg0)
	f11_arg0.WaypointCenterCodcaster:completeAnimation()
	f11_arg0.WaypointCenter:completeAnimation()
	f11_arg0.WaypointCenterCodcaster:setAlpha(1)
	f11_arg0.WaypointCenter:setAlpha(1)
end
CoD.ScoreInfoEscortRobotObjective.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.WaypointCenterCodcaster:completeAnimation()
			f12_arg0.WaypointCenterCodcaster:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.WaypointCenterCodcaster)
		end,
	},
	CodCaster = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.WaypointCenter:completeAnimation()
			f13_arg0.WaypointCenter:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.WaypointCenter)
			f13_arg0.WaypointCenterCodcaster:completeAnimation()
			f13_arg0.WaypointCenterCodcaster:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.WaypointCenterCodcaster)
		end,
	},
}
CoD.ScoreInfoEscortRobotObjective.__onClose = function(f14_arg0)
	f14_arg0.HealthBacking:close()
	f14_arg0.Health:close()
	f14_arg0.WaypointCenter:close()
	f14_arg0.WaypointCenterCodcaster:close()
end
