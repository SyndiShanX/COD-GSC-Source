require("x64:5609625e0a9984a")
require("x64:27411b1d207dbc8")
require("x64:76c14e1bc07cd98")
CoD.ScoreNotificationWaypoint = InheritFrom(LUI.UIElement)
CoD.ScoreNotificationWaypoint.__defaultWidth = 80
CoD.ScoreNotificationWaypoint.__defaultHeight = 78
CoD.ScoreNotificationWaypoint.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScoreNotificationWaypoint)
	self.id = "ScoreNotificationWaypoint"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local baseglow = LUI.UIImage.new(0.5, 0.5, -32, 32, 0.5, 0.5, -32, 32)
	baseglow:setAlpha(0)
	baseglow:setImage(RegisterImage(@"uie_t7_hud_waypoints_baseglow"))
	baseglow.__Color = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			baseglow:setRGB(CoD.HUDUtility.GetFriendlyOrEnemyColorByObjId(f1_arg1, f2_local0))
		end
	end
	baseglow:linkToElementModel(self, "objId", true, baseglow.__Color)
	baseglow.__Color_FullPath = function()
		local f3_local0 = self:getModel()
		if f3_local0 then
			f3_local0 = self:getModel()
			f3_local0 = f3_local0.objId
		end
		if f3_local0 then
			baseglow.__Color(f3_local0)
		end
	end
	self:addElement(baseglow)
	self.baseglow = baseglow
	local WaypointBacker = LUI.UIImage.new(0.5, 0.5, -25, 27, 0.5, 0.5, -27, 25)
	WaypointBacker:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	WaypointBacker:setAlpha(0)
	WaypointBacker:linkToElementModel(self, "waypointBacking01", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			WaypointBacker:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(WaypointBacker)
	self.WaypointBacker = WaypointBacker
	local WaypointPattern = LUI.UIImage.new(0.5, 0.5, -37, 39, 0.5, 0.5, -38.5, 37.5)
	WaypointPattern:setAlpha(0.7)
	WaypointPattern:setImage(RegisterImage(@"uie_ui_hud_core_waypoint_led_small"))
	WaypointPattern:linkToElementModel(self, "color", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			WaypointPattern:setRGB(CoD.WaypointUtility.ConvertToBaseColor(f5_local0))
		end
	end)
	self:addElement(WaypointPattern)
	self.WaypointPattern = WaypointPattern
	local ProgressMeterBacking = LUI.UIImage.new(0.5, 0.5, -25, 27, 0.5, 0.5, -27, 25)
	ProgressMeterBacking:setRGB(1, 0.98, 0.91)
	ProgressMeterBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_clock_normal"))
	ProgressMeterBacking:setShaderVector(0, 1.13, 0, 0, 0)
	ProgressMeterBacking:setShaderVector(1, 0.5, 0, 0, 0)
	ProgressMeterBacking:setShaderVector(2, 0.5, 0, 0, 0)
	ProgressMeterBacking:setShaderVector(3, 0, 0, 0, 0)
	ProgressMeterBacking:linkToElementModel(self, "waypointBacking02", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			ProgressMeterBacking:setImage(RegisterImage(f6_local0))
		end
	end)
	ProgressMeterBacking:linkToElementModel(self, "objId", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			ProgressMeterBacking:setShaderVector(4, CoD.WaypointUtility.SetProgressMeterSegmentationIfNeeded(f1_arg1, 0.07, CoD.GetVectorComponentFromString(f7_local0, 1), CoD.GetVectorComponentFromString(f7_local0, 2), CoD.GetVectorComponentFromString(f7_local0, 3), CoD.GetVectorComponentFromString(f7_local0, 4)))
		end
	end)
	self:addElement(ProgressMeterBacking)
	self.ProgressMeterBacking = ProgressMeterBacking
	local ProgressMeterBackingFill = LUI.UIImage.new(0.5, 0.5, -25, 27, 0.5, 0.5, -27, 25)
	ProgressMeterBackingFill:setImage(RegisterImage(@"uie_ui_hud_core_waypoint_domination_fill_02"))
	ProgressMeterBackingFill:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_clock_normal"))
	ProgressMeterBackingFill:setShaderVector(1, 0.5, 0, 0, 0)
	ProgressMeterBackingFill:setShaderVector(2, 0.5, 0, 0, 0)
	ProgressMeterBackingFill:setShaderVector(3, 0, 0, 0, 0)
	ProgressMeterBackingFill:linkToElementModel(self, "progress", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			ProgressMeterBackingFill:setShaderVector(0, CoD.GetVectorComponentFromString(f8_local0, 1), CoD.GetVectorComponentFromString(f8_local0, 2), CoD.GetVectorComponentFromString(f8_local0, 3), CoD.GetVectorComponentFromString(f8_local0, 4))
		end
	end)
	ProgressMeterBackingFill:linkToElementModel(self, "objId", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			ProgressMeterBackingFill:setShaderVector(4, CoD.WaypointUtility.SetProgressMeterSegmentationIfNeeded(f1_arg1, 0.07, CoD.GetVectorComponentFromString(f9_local0, 1), CoD.GetVectorComponentFromString(f9_local0, 2), CoD.GetVectorComponentFromString(f9_local0, 3), CoD.GetVectorComponentFromString(f9_local0, 4)))
		end
	end)
	self:addElement(ProgressMeterBackingFill)
	self.ProgressMeterBackingFill = ProgressMeterBackingFill
	local progressMeter = CoD.WaypointProgressRing.new(f1_arg0, f1_arg1, 0.5, 0.5, -25, 27, 0.5, 0.5, -27, 25)
	progressMeter:linkToElementModel(self, nil, false, function(model)
		progressMeter:setModel(model, f1_arg1)
	end)
	progressMeter:linkToElementModel(self, "objId", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			progressMeter.progressMeter:setShaderVector(4, CoD.WaypointUtility.SetProgressMeterSegmentationIfNeeded(f1_arg1, 0.07, CoD.GetVectorComponentFromString(f11_local0, 1), CoD.GetVectorComponentFromString(f11_local0, 2), CoD.GetVectorComponentFromString(f11_local0, 3), CoD.GetVectorComponentFromString(f11_local0, 4)))
		end
	end)
	progressMeter:linkToElementModel(self, "objId", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			progressMeter.progressMeterColoredByUsing:setShaderVector(4, CoD.WaypointUtility.SetProgressMeterSegmentationIfNeeded(f1_arg1, 0.07, CoD.GetVectorComponentFromString(f12_local0, 1), CoD.GetVectorComponentFromString(f12_local0, 2), CoD.GetVectorComponentFromString(f12_local0, 3), CoD.GetVectorComponentFromString(f12_local0, 4)))
		end
	end)
	self:addElement(progressMeter)
	self.progressMeter = progressMeter
	local CaptureIcon = CoD.ScoreNotificationWaypoint_Capture.new(f1_arg0, f1_arg1, 0.5, 0.5, -18.5, 19.5, 0.5, 0.5, -19.5, 18.5)
	CaptureIcon:mergeStateConditions({
		{
			stateName = "AttackTeam",
			condition = function(menu, element, event)
				return IsAttackingTeam(f1_arg1)
			end,
		},
		{
			stateName = "DefendTeam",
			condition = function(menu, element, event)
				return not IsAttackingTeam(f1_arg1)
			end,
		},
	})
	local f1_local8 = CaptureIcon
	local WaypointCenter = CaptureIcon.subscribeToModel
	local f1_local10 = Engine[@"getglobalmodel"]()
	WaypointCenter(f1_local8, f1_local10["hudItems.war.attackingTeam"], function(f15_arg0)
		f1_arg0:updateElementState(CaptureIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "hudItems.war.attackingTeam",
		})
	end, false)
	f1_local8 = CaptureIcon
	WaypointCenter = CaptureIcon.subscribeToModel
	f1_local10 = DataSources.CodCaster.getModel(f1_arg1)
	WaypointCenter(f1_local8, f1_local10.profileSettingsUpdated, function(f16_arg0)
		f1_arg0:updateElementState(CaptureIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	CaptureIcon:setAlpha(0)
	self:addElement(CaptureIcon)
	self.CaptureIcon = CaptureIcon
	WaypointCenter = CoD.WaypointCenter.new(f1_arg0, f1_arg1, 0.5, 0.5, -37, 39, 0.5, 0.5, -39, 37)
	WaypointCenter:setAlpha(0.95)
	WaypointCenter:setScale(0.7, 0.7)
	WaypointCenter:linkToElementModel(self, nil, false, function(model)
		WaypointCenter:setModel(model, f1_arg1)
	end)
	self:addElement(WaypointCenter)
	self.WaypointCenter = WaypointCenter
	f1_local10 = baseglow
	f1_local8 = baseglow.subscribeToModel
	local f1_local11 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local10, f1_local11["factions.playerFactionTeamEnum"], baseglow.__Color_FullPath)
	baseglow:linkToElementModel(self, "clientUseMask", true, baseglow.__Color_FullPath)
	f1_local10 = baseglow
	f1_local8 = baseglow.subscribeToModel
	f1_local11 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local10, f1_local11["profile.colorblindMode"], baseglow.__Color_FullPath)
	self:mergeStateConditions({
		{
			stateName = "Captured",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("control") and CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "state", Enum[@"objectivestate_t"][@"objst_done"])
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "NoFrame",
			condition = function(menu, element, event)
				return CoD.WaypointUtility.ShouldShowProgressOnIcon(f1_arg1, self)
			end,
		},
	})
	self:linkToElementModel(self, "state", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "state",
		})
	end)
	self:linkToElementModel(self, "objId", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "objId",
		})
	end)
	self:linkToElementModel(self, "objectiveModel", true, function(model)
		local f23_local0 = self
		SetElementModelToSelfModelValue(self, self, f1_arg1, "objectiveModel")
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScoreNotificationWaypoint.__resetProperties = function(f24_arg0)
	f24_arg0.WaypointCenter:completeAnimation()
	f24_arg0.progressMeter:completeAnimation()
	f24_arg0.ProgressMeterBacking:completeAnimation()
	f24_arg0.CaptureIcon:completeAnimation()
	f24_arg0.baseglow:completeAnimation()
	f24_arg0.WaypointPattern:completeAnimation()
	f24_arg0.ProgressMeterBackingFill:completeAnimation()
	f24_arg0.WaypointBacker:completeAnimation()
	f24_arg0.WaypointCenter:setAlpha(0.95)
	f24_arg0.WaypointCenter:setScale(0.7, 0.7)
	f24_arg0.progressMeter:setAlpha(1)
	f24_arg0.ProgressMeterBacking:setAlpha(1)
	f24_arg0.CaptureIcon:setLeftRight(0.5, 0.5, -18.5, 19.5)
	f24_arg0.CaptureIcon:setTopBottom(0.5, 0.5, -19.5, 18.5)
	f24_arg0.CaptureIcon:setAlpha(0)
	f24_arg0.baseglow:setAlpha(0)
	f24_arg0.baseglow:setScale(1, 1)
	f24_arg0.WaypointPattern:setAlpha(0.7)
	f24_arg0.ProgressMeterBackingFill:setAlpha(1)
	f24_arg0.WaypointBacker:setAlpha(0)
end
CoD.ScoreNotificationWaypoint.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(4)
			f25_arg0.ProgressMeterBacking:completeAnimation()
			f25_arg0.ProgressMeterBacking:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.ProgressMeterBacking)
			f25_arg0.progressMeter:completeAnimation()
			f25_arg0.progressMeter:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.progressMeter)
			f25_arg0.CaptureIcon:completeAnimation()
			f25_arg0.CaptureIcon:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.CaptureIcon)
			f25_arg0.WaypointCenter:completeAnimation()
			f25_arg0.WaypointCenter:setAlpha(0.95)
			f25_arg0.clipFinished(f25_arg0.WaypointCenter)
		end,
		Captured = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			local f26_local0 = function(f27_arg0)
				local f27_local0 = function(f28_arg0)
					local f28_local0 = function(f29_arg0)
						f29_arg0:beginAnimation(560)
						f29_arg0:setAlpha(0)
						f29_arg0:setScale(1.7, 1.7)
						f29_arg0:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
					end
					f28_arg0:beginAnimation(230)
					f28_arg0:setAlpha(0.62)
					f28_arg0:setScale(1.2, 1.2)
					f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
				end
				f26_arg0.baseglow:beginAnimation(20)
				f26_arg0.baseglow:setAlpha(1)
				f26_arg0.baseglow:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.baseglow:registerEventHandler("transition_complete_keyframe", f27_local0)
			end
			f26_arg0.baseglow:completeAnimation()
			f26_arg0.baseglow:setAlpha(0)
			f26_arg0.baseglow:setScale(1, 1)
			f26_local0(f26_arg0.baseglow)
		end,
	},
	Captured = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(5)
			f30_arg0.WaypointPattern:completeAnimation()
			f30_arg0.WaypointPattern:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.WaypointPattern)
			f30_arg0.ProgressMeterBacking:completeAnimation()
			f30_arg0.ProgressMeterBacking:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.ProgressMeterBacking)
			f30_arg0.progressMeter:completeAnimation()
			f30_arg0.progressMeter:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.progressMeter)
			f30_arg0.CaptureIcon:completeAnimation()
			f30_arg0.CaptureIcon:setLeftRight(0.5, 0.5, -17.5, 20.5)
			f30_arg0.CaptureIcon:setTopBottom(0.5, 0.5, -20, 18)
			f30_arg0.CaptureIcon:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.CaptureIcon)
			f30_arg0.WaypointCenter:completeAnimation()
			f30_arg0.WaypointCenter:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.WaypointCenter)
		end,
	},
	Hidden = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(6)
			f31_arg0.WaypointBacker:completeAnimation()
			f31_arg0.WaypointBacker:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.WaypointBacker)
			f31_arg0.WaypointPattern:completeAnimation()
			f31_arg0.WaypointPattern:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.WaypointPattern)
			f31_arg0.ProgressMeterBacking:completeAnimation()
			f31_arg0.ProgressMeterBacking:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.ProgressMeterBacking)
			f31_arg0.ProgressMeterBackingFill:completeAnimation()
			f31_arg0.ProgressMeterBackingFill:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.ProgressMeterBackingFill)
			f31_arg0.progressMeter:completeAnimation()
			f31_arg0.progressMeter:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.progressMeter)
			f31_arg0.WaypointCenter:completeAnimation()
			f31_arg0.WaypointCenter:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.WaypointCenter)
		end,
	},
	NoFrame = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(5)
			f32_arg0.ProgressMeterBacking:completeAnimation()
			f32_arg0.ProgressMeterBacking:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.ProgressMeterBacking)
			f32_arg0.ProgressMeterBackingFill:completeAnimation()
			f32_arg0.ProgressMeterBackingFill:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.ProgressMeterBackingFill)
			f32_arg0.progressMeter:completeAnimation()
			f32_arg0.progressMeter:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.progressMeter)
			f32_arg0.CaptureIcon:completeAnimation()
			f32_arg0.CaptureIcon:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.CaptureIcon)
			f32_arg0.WaypointCenter:completeAnimation()
			f32_arg0.WaypointCenter:setAlpha(0.95)
			f32_arg0.WaypointCenter:setScale(1.2, 1.2)
			f32_arg0.clipFinished(f32_arg0.WaypointCenter)
		end,
	},
}
CoD.ScoreNotificationWaypoint.__onClose = function(f33_arg0)
	f33_arg0.baseglow:close()
	f33_arg0.WaypointBacker:close()
	f33_arg0.WaypointPattern:close()
	f33_arg0.ProgressMeterBacking:close()
	f33_arg0.ProgressMeterBackingFill:close()
	f33_arg0.progressMeter:close()
	f33_arg0.CaptureIcon:close()
	f33_arg0.WaypointCenter:close()
end
