CoD.bleedOutHealthWZ = InheritFrom(LUI.UIElement)
CoD.bleedOutHealthWZ.__defaultWidth = 210
CoD.bleedOutHealthWZ.__defaultHeight = 250
CoD.bleedOutHealthWZ.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.ResetInterpolationTimer(f1_arg1, "bleedingOutHealth")
	CoD.BaseUtility.ResetInterpolationTimer(f1_arg1, "revivingProgress")
	self:setClass(CoD.bleedOutHealthWZ)
	self.id = "bleedOutHealthWZ"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WaypointBackerBlur = LUI.UIImage.new(0.5, 0.5, -94, 94, 0.5, 0.5, -118, 70)
	WaypointBackerBlur:setImage(RegisterImage(@"uie_ui_hud_core_waypoint_domination_backer"))
	WaypointBackerBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	WaypointBackerBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(WaypointBackerBlur)
	self.WaypointBackerBlur = WaypointBackerBlur
	local WaypointBacker = LUI.UIImage.new(0.5, 0.5, -94, 94, 0.5, 0.5, -118, 70)
	WaypointBacker:setImage(RegisterImage(@"uie_ui_hud_core_waypoint_domination_backer"))
	self:addElement(WaypointBacker)
	self.WaypointBacker = WaypointBacker
	local WaypointProgressMeterEmpty = LUI.UIImage.new(0.5, 0.5, -94, 94, 0.5, 0.5, -118, 70)
	WaypointProgressMeterEmpty:setRGB(1, 0.98, 0.91)
	WaypointProgressMeterEmpty:setImage(RegisterImage(@"uie_ui_hud_core_waypoint_domination_empty"))
	self:addElement(WaypointProgressMeterEmpty)
	self.WaypointProgressMeterEmpty = WaypointProgressMeterEmpty
	local reviveiconBackplate = LUI.UIImage.new(0.5, 0.5, -60, 60, 0.5, 0.5, -84, 36)
	reviveiconBackplate:setRGB(0, 0, 0)
	reviveiconBackplate:setAlpha(0.66)
	reviveiconBackplate:setImage(RegisterImage(@"uie_ui_icon_bounty_hunter_revive"))
	self:addElement(reviveiconBackplate)
	self.reviveiconBackplate = reviveiconBackplate
	local CWOBacking = LUI.UIImage.new(0.5, 0.5, -66, 66, 0.5, 0.5, -90, 42)
	CWOBacking:setAlpha(0)
	CWOBacking:setImage(RegisterImage(@"uie_ui_menu_cac_selection_circle"))
	CWOBacking.__Color = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			CWOBacking:setRGB(CoD.WZUtility.TeamPlayerColorForClientNum(f1_arg1, f2_local0))
		end
	end
	CWOBacking:linkToElementModel(self, "clientnum", true, CWOBacking.__Color)
	CWOBacking.__Color_FullPath = function()
		local f3_local0 = self:getModel()
		if f3_local0 then
			f3_local0 = self:getModel()
			f3_local0 = f3_local0.clientnum
		end
		if f3_local0 then
			CWOBacking.__Color(f3_local0)
		end
	end
	self:addElement(CWOBacking)
	self.CWOBacking = CWOBacking
	local WaypointPattern = LUI.UIImage.new(0.5, 0.5, -80, 80, 0.5, 0.5, -104, 56)
	WaypointPattern:setAlpha(0.4)
	WaypointPattern:setImage(RegisterImage(@"uie_ui_hud_core_waypoint_led"))
	WaypointPattern:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	WaypointPattern:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(WaypointPattern)
	self.WaypointPattern = WaypointPattern
	local CWOicon = LUI.UIImage.new(0.5, 0.5, -60, 60, 0.5, 0.5, -88, 32)
	CWOicon:setAlpha(0)
	CWOicon:setImage(RegisterImage(@"uie_ui_hud_wz_hud_cwo_icon"))
	self:addElement(CWOicon)
	self.CWOicon = CWOicon
	local reviveicon = LUI.UIImage.new(0.5, 0.5, -64, 64, 0.5, 0.5, -87, 41)
	reviveicon:setImage(RegisterImage(@"uie_ui_hud_wz_hud_revive_plus_icon"))
	reviveicon:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	reviveicon:setShaderVector(0, 1.16, 0, 0, 0)
	reviveicon.__Color = function(f4_arg0)
		local f4_local0 = f4_arg0:get()
		if f4_local0 ~= nil then
			reviveicon:setRGB(CoD.WZUtility.TeamPlayerColorForClientNum(f1_arg1, f4_local0))
		end
	end
	reviveicon:linkToElementModel(self, "clientnum", true, reviveicon.__Color)
	reviveicon.__Color_FullPath = function()
		local f5_local0 = self:getModel()
		if f5_local0 then
			f5_local0 = self:getModel()
			f5_local0 = f5_local0.clientnum
		end
		if f5_local0 then
			reviveicon.__Color(f5_local0)
		end
	end
	self:addElement(reviveicon)
	self.reviveicon = reviveicon
	local bleedingOutRing = LUI.UIImage.new(0.5, 0.5, -87, 87, 0.5, 0.5, -111, 63)
	bleedingOutRing:setImage(RegisterImage(@"uie_ui_hud_core_waypoint_domination_fill_02"))
	bleedingOutRing:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_clock_normal"))
	bleedingOutRing:setShaderVector(1, 0.5, 0, 0, 0)
	bleedingOutRing:setShaderVector(2, 0.5, 0, 0, 0)
	bleedingOutRing:setShaderVector(3, 0, 0, 0, 0)
	bleedingOutRing:setShaderVector(4, 0, 0, 0, 0)
	bleedingOutRing:linkToElementModel(self, "health", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			bleedingOutRing:setShaderVector(0, CoD.GetVectorComponentFromString(f6_local0, 1), CoD.GetVectorComponentFromString(f6_local0, 2), CoD.GetVectorComponentFromString(f6_local0, 3), CoD.GetVectorComponentFromString(f6_local0, 4))
		end
	end)
	self:addElement(bleedingOutRing)
	self.bleedingOutRing = bleedingOutRing
	local revivingRing = LUI.UIImage.new(0.5, 0.5, -87, 87, 0.5, 0.5, -111, 63)
	revivingRing:setImage(RegisterImage(@"uie_ui_hud_core_waypoint_domination_fill_02"))
	revivingRing:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_clock_normal"))
	revivingRing:setShaderVector(1, 0.5, 0, 0, 0)
	revivingRing:setShaderVector(2, 0.5, 0, 0, 0)
	revivingRing:setShaderVector(3, 0, 0, 0, 0)
	revivingRing:setShaderVector(4, 0, 0, 0, 0)
	revivingRing:linkToElementModel(self, "reviveProgress", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			CoD.BaseUtility.SmoothLinearInterpolateClientTime(f1_arg1, "revivingProgress", model, f7_local0)
			revivingRing:setShaderVector(0, CoD.GetVectorComponentFromString(f7_local0, 1), CoD.GetVectorComponentFromString(f7_local0, 2), CoD.GetVectorComponentFromString(f7_local0, 3), CoD.GetVectorComponentFromString(f7_local0, 4))
		end
	end)
	self:addElement(revivingRing)
	self.revivingRing = revivingRing
	local PlayerNumber = LUI.UIText.new(0.5, 0.5, -100, 100, 0.5, 0.5, -44.5, 0.5)
	PlayerNumber:setTTF("ttmussels_demibold")
	PlayerNumber:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	PlayerNumber:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	PlayerNumber:linkToElementModel(self, "clientnum", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			PlayerNumber:setText(CoD.WZUtility.ShownPlayerIndexForClientNum(f1_arg1, f8_local0))
		end
	end)
	self:addElement(PlayerNumber)
	self.PlayerNumber = PlayerNumber
	CWOBacking:linkToElementModel(self, "team", true, CWOBacking.__Color_FullPath)
	local f1_local12 = CWOBacking
	local f1_local13 = CWOBacking.subscribeToModel
	local f1_local14 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local13(f1_local12, f1_local14["profile.colorblindMode"], CWOBacking.__Color_FullPath)
	reviveicon:linkToElementModel(self, "team", true, reviveicon.__Color_FullPath)
	f1_local12 = reviveicon
	f1_local13 = reviveicon.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local13(f1_local12, f1_local14["profile.colorblindMode"], reviveicon.__Color_FullPath)
	self:mergeStateConditions({
		{
			stateName = "Reviving",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "reviveProgress", 0)
			end,
		},
		{
			stateName = "CowardsWay",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "cowardsWay", 0)
			end,
		},
		{
			stateName = "BleedingOut_Low",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, f1_arg1, "health", 0.2)
			end,
		},
		{
			stateName = "BleedingOut",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	self:linkToElementModel(self, "reviveProgress", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "reviveProgress",
		})
	end)
	self:linkToElementModel(self, "cowardsWay", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "cowardsWay",
		})
	end)
	self:linkToElementModel(self, "health", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "health",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.bleedOutHealthWZ.__resetProperties = function(f16_arg0)
	f16_arg0.CWOicon:completeAnimation()
	f16_arg0.reviveicon:completeAnimation()
	f16_arg0.PlayerNumber:completeAnimation()
	f16_arg0.CWOBacking:completeAnimation()
	f16_arg0.CWOicon:setAlpha(0)
	f16_arg0.reviveicon:setAlpha(1)
	f16_arg0.PlayerNumber:setAlpha(1)
	f16_arg0.CWOBacking:setAlpha(0)
end
CoD.bleedOutHealthWZ.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(0)
		end,
	},
	Reviving = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(0)
		end,
	},
	CowardsWay = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(4)
			f19_arg0.CWOBacking:completeAnimation()
			f19_arg0.CWOBacking:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.CWOBacking)
			f19_arg0.CWOicon:completeAnimation()
			f19_arg0.CWOicon:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.CWOicon)
			f19_arg0.reviveicon:completeAnimation()
			f19_arg0.reviveicon:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.reviveicon)
			f19_arg0.PlayerNumber:completeAnimation()
			f19_arg0.PlayerNumber:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.PlayerNumber)
		end,
	},
	BleedingOut_Low = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(0)
		end,
	},
	BleedingOut = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.bleedOutHealthWZ.__onClose = function(f22_arg0)
	f22_arg0.CWOBacking:close()
	f22_arg0.reviveicon:close()
	f22_arg0.bleedingOutRing:close()
	f22_arg0.revivingRing:close()
	f22_arg0.PlayerNumber:close()
end
