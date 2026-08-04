CoD.WaypointProgressRing = InheritFrom(LUI.UIElement)
CoD.WaypointProgressRing.__defaultWidth = 70
CoD.WaypointProgressRing.__defaultHeight = 70
CoD.WaypointProgressRing.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WaypointProgressRing)
	self.id = "WaypointProgressRing"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local progressMeter = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	progressMeter:setAlpha(0.9)
	progressMeter:setImage(RegisterImage("uie_ui_hud_core_waypoint_domination_fill_02"))
	progressMeter:setMaterial(LUI.UIImage.GetCachedMaterial("uie_clock_normal"))
	progressMeter:setShaderVector(0, 0.6, 0, 0, 0)
	progressMeter:setShaderVector(1, 0.5, 0, 0, 0)
	progressMeter:setShaderVector(2, 0.5, 0, 0, 0)
	progressMeter:setShaderVector(3, 0, 0, 0, 0)
	progressMeter:linkToElementModel(self, "progress", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			progressMeter:setShaderVector(4, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(progressMeter)
	self.progressMeter = progressMeter
	local progressMeterColoredByUsing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	progressMeterColoredByUsing:setImage(RegisterImage("uie_ui_hud_core_waypoint_domination_fill_02"))
	progressMeterColoredByUsing:setMaterial(LUI.UIImage.GetCachedMaterial("uie_clock_normal"))
	progressMeterColoredByUsing:setShaderVector(1, 0.5, 0, 0, 0)
	progressMeterColoredByUsing:setShaderVector(2, 0.5, 0, 0, 0)
	progressMeterColoredByUsing:setShaderVector(3, 0, 0, 0, 0)
	progressMeterColoredByUsing:setShaderVector(4, 0, 0, 0, 0)
	progressMeterColoredByUsing.__Color = function(f3_arg0)
		local f3_local0 = f3_arg0:get()
		if f3_local0 ~= nil then
			progressMeterColoredByUsing:setRGB(CoD.HUDUtility.GetFriendlyOrEnemyColorByObjId(f1_arg1, f3_local0))
		end
	end
	progressMeterColoredByUsing:linkToElementModel(self, "objId", true, progressMeterColoredByUsing.__Color)
	progressMeterColoredByUsing.__Color_FullPath = function()
		local f4_local0 = self:getModel()
		if f4_local0 then
			f4_local0 = self:getModel()
			f4_local0 = f4_local0.objId
		end
		if f4_local0 then
			progressMeterColoredByUsing.__Color(f4_local0)
		end
	end
	progressMeterColoredByUsing:linkToElementModel(self, "progress", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			progressMeterColoredByUsing:setShaderVector(0, CoD.GetVectorComponentFromString(f5_local0, 1), CoD.GetVectorComponentFromString(f5_local0, 2), CoD.GetVectorComponentFromString(f5_local0, 3), CoD.GetVectorComponentFromString(f5_local0, 4))
		end
	end)
	self:addElement(progressMeterColoredByUsing)
	self.progressMeterColoredByUsing = progressMeterColoredByUsing
	local progressMeterColoredByUsing2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	progressMeterColoredByUsing2:setImage(RegisterImage("uie_ui_hud_core_waypoint_domination_fill_02"))
	progressMeterColoredByUsing2:setMaterial(LUI.UIImage.GetCachedMaterial("uie_clock_add"))
	progressMeterColoredByUsing2:setShaderVector(1, 0.5, 0, 0, 0)
	progressMeterColoredByUsing2:setShaderVector(2, 0.5, 0, 0, 0)
	progressMeterColoredByUsing2:setShaderVector(3, 0, 0, 0, 0)
	progressMeterColoredByUsing2:setShaderVector(4, 0, 0, 0, 0)
	progressMeterColoredByUsing2.__Color = function(f6_arg0)
		local f6_local0 = f6_arg0:get()
		if f6_local0 ~= nil then
			progressMeterColoredByUsing2:setRGB(CoD.HUDUtility.GetFriendlyOrEnemyMutedColorByObjId(f1_arg1, f6_local0))
		end
	end
	progressMeterColoredByUsing2:linkToElementModel(self, "objId", true, progressMeterColoredByUsing2.__Color)
	progressMeterColoredByUsing2.__Color_FullPath = function()
		local f7_local0 = self:getModel()
		if f7_local0 then
			f7_local0 = self:getModel()
			f7_local0 = f7_local0.objId
		end
		if f7_local0 then
			progressMeterColoredByUsing2.__Color(f7_local0)
		end
	end
	progressMeterColoredByUsing2:linkToElementModel(self, "progress", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			progressMeterColoredByUsing2:setShaderVector(0, CoD.GetVectorComponentFromString(f8_local0, 1), CoD.GetVectorComponentFromString(f8_local0, 2), CoD.GetVectorComponentFromString(f8_local0, 3), CoD.GetVectorComponentFromString(f8_local0, 4))
		end
	end)
	self:addElement(progressMeterColoredByUsing2)
	self.progressMeterColoredByUsing2 = progressMeterColoredByUsing2
	local progressMeterColoredByUsing3 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	progressMeterColoredByUsing3:setImage(RegisterImage("uie_ui_hud_core_waypoint_domination_fill_02"))
	progressMeterColoredByUsing3:setMaterial(LUI.UIImage.GetCachedMaterial("uie_clock_normal"))
	progressMeterColoredByUsing3:setShaderVector(1, 0.5, 0, 0, 0)
	progressMeterColoredByUsing3:setShaderVector(2, 0.5, 0, 0, 0)
	progressMeterColoredByUsing3:setShaderVector(3, 0, 0, 0, 0)
	progressMeterColoredByUsing3:setShaderVector(4, 0, 0, 0, 0)
	progressMeterColoredByUsing3.__Color = function(f9_arg0)
		local f9_local0 = f9_arg0:get()
		if f9_local0 ~= nil then
			progressMeterColoredByUsing3:setRGB(CoD.HUDUtility.GetFriendlyOrEnemyBrightColorByObjId(f1_arg1, f9_local0))
		end
	end
	progressMeterColoredByUsing3:linkToElementModel(self, "objId", true, progressMeterColoredByUsing3.__Color)
	progressMeterColoredByUsing3.__Color_FullPath = function()
		local f10_local0 = self:getModel()
		if f10_local0 then
			f10_local0 = self:getModel()
			f10_local0 = f10_local0.objId
		end
		if f10_local0 then
			progressMeterColoredByUsing3.__Color(f10_local0)
		end
	end
	progressMeterColoredByUsing3:linkToElementModel(self, "progress", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			progressMeterColoredByUsing3:setShaderVector(0, CoD.GetVectorComponentFromString(f11_local0, 1), CoD.GetVectorComponentFromString(f11_local0, 2), CoD.GetVectorComponentFromString(f11_local0, 3), CoD.GetVectorComponentFromString(f11_local0, 4))
		end
	end)
	self:addElement(progressMeterColoredByUsing3)
	self.progressMeterColoredByUsing3 = progressMeterColoredByUsing3
	local progressMeterColoredByFlags = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	progressMeterColoredByFlags:setImage(RegisterImage("uie_ui_hud_core_waypoint_domination_fill_02"))
	progressMeterColoredByFlags:setMaterial(LUI.UIImage.GetCachedMaterial("uie_clock_normal"))
	progressMeterColoredByFlags:setShaderVector(1, 0.5, 0, 0, 0)
	progressMeterColoredByFlags:setShaderVector(2, 0.5, 0, 0, 0)
	progressMeterColoredByFlags:setShaderVector(3, 0, 0, 0, 0)
	progressMeterColoredByFlags:setShaderVector(4, 0, 0, 0, 0)
	progressMeterColoredByFlags.__Color = function(f12_arg0)
		local f12_local0 = f12_arg0:get()
		if f12_local0 ~= nil then
			progressMeterColoredByFlags:setRGB(CoD.HUDUtility.GetFriendlyOrEnemyColorByFlags(self:getModel(), f1_arg1, f12_local0))
		end
	end
	progressMeterColoredByFlags:linkToElementModel(self, "gamemodeFlags", true, progressMeterColoredByFlags.__Color)
	progressMeterColoredByFlags.__Color_FullPath = function()
		local f13_local0 = self:getModel()
		if f13_local0 then
			f13_local0 = self:getModel()
			f13_local0 = f13_local0.gamemodeFlags
		end
		if f13_local0 then
			progressMeterColoredByFlags.__Color(f13_local0)
		end
	end
	progressMeterColoredByFlags:linkToElementModel(self, "progress", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			progressMeterColoredByFlags:setShaderVector(0, CoD.GetVectorComponentFromString(f14_local0, 1), CoD.GetVectorComponentFromString(f14_local0, 2), CoD.GetVectorComponentFromString(f14_local0, 3), CoD.GetVectorComponentFromString(f14_local0, 4))
		end
	end)
	self:addElement(progressMeterColoredByFlags)
	self.progressMeterColoredByFlags = progressMeterColoredByFlags
	local progressMeterColoredByFlags2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	progressMeterColoredByFlags2:setAlpha(0.4)
	progressMeterColoredByFlags2:setImage(RegisterImage("uie_ui_hud_core_waypoint_domination_fill_02"))
	progressMeterColoredByFlags2:setMaterial(LUI.UIImage.GetCachedMaterial("uie_clock_normal"))
	progressMeterColoredByFlags2:setShaderVector(1, 0.5, 0, 0, 0)
	progressMeterColoredByFlags2:setShaderVector(2, 0.5, 0, 0, 0)
	progressMeterColoredByFlags2:setShaderVector(3, 0, 0, 0, 0)
	progressMeterColoredByFlags2:setShaderVector(4, 0, 0, 0, 0)
	progressMeterColoredByFlags2.__Color = function(f15_arg0)
		local f15_local0 = f15_arg0:get()
		if f15_local0 ~= nil then
			progressMeterColoredByFlags2:setRGB(CoD.HUDUtility.GetFriendlyOrEnemyMutedColorByFlags(self:getModel(), f1_arg1, f15_local0))
		end
	end
	progressMeterColoredByFlags2:linkToElementModel(self, "gamemodeFlags", true, progressMeterColoredByFlags2.__Color)
	progressMeterColoredByFlags2.__Color_FullPath = function()
		local f16_local0 = self:getModel()
		if f16_local0 then
			f16_local0 = self:getModel()
			f16_local0 = f16_local0.gamemodeFlags
		end
		if f16_local0 then
			progressMeterColoredByFlags2.__Color(f16_local0)
		end
	end
	progressMeterColoredByFlags2:linkToElementModel(self, "progress", true, function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			progressMeterColoredByFlags2:setShaderVector(0, CoD.GetVectorComponentFromString(f17_local0, 1), CoD.GetVectorComponentFromString(f17_local0, 2), CoD.GetVectorComponentFromString(f17_local0, 3), CoD.GetVectorComponentFromString(f17_local0, 4))
		end
	end)
	self:addElement(progressMeterColoredByFlags2)
	self.progressMeterColoredByFlags2 = progressMeterColoredByFlags2
	local progressMeterColoredByFlags3 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	progressMeterColoredByFlags3:setAlpha(0.5)
	progressMeterColoredByFlags3:setImage(RegisterImage("uie_ui_hud_core_waypoint_domination_fill_02"))
	progressMeterColoredByFlags3:setMaterial(LUI.UIImage.GetCachedMaterial("uie_clock_add"))
	progressMeterColoredByFlags3:setShaderVector(1, 0.5, 0, 0, 0)
	progressMeterColoredByFlags3:setShaderVector(2, 0.5, 0, 0, 0)
	progressMeterColoredByFlags3:setShaderVector(3, 0, 0, 0, 0)
	progressMeterColoredByFlags3:setShaderVector(4, 0, 0, 0, 0)
	progressMeterColoredByFlags3.__Color = function(f18_arg0)
		local f18_local0 = f18_arg0:get()
		if f18_local0 ~= nil then
			progressMeterColoredByFlags3:setRGB(CoD.HUDUtility.GetFriendlyOrEnemyBrightColorByFlags(self:getModel(), f1_arg1, f18_local0))
		end
	end
	progressMeterColoredByFlags3:linkToElementModel(self, "gamemodeFlags", true, progressMeterColoredByFlags3.__Color)
	progressMeterColoredByFlags3.__Color_FullPath = function()
		local f19_local0 = self:getModel()
		if f19_local0 then
			f19_local0 = self:getModel()
			f19_local0 = f19_local0.gamemodeFlags
		end
		if f19_local0 then
			progressMeterColoredByFlags3.__Color(f19_local0)
		end
	end
	progressMeterColoredByFlags3:linkToElementModel(self, "progress", true, function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			progressMeterColoredByFlags3:setShaderVector(0, CoD.GetVectorComponentFromString(f20_local0, 1), CoD.GetVectorComponentFromString(f20_local0, 2), CoD.GetVectorComponentFromString(f20_local0, 3), CoD.GetVectorComponentFromString(f20_local0, 4))
		end
	end)
	self:addElement(progressMeterColoredByFlags3)
	self.progressMeterColoredByFlags3 = progressMeterColoredByFlags3
	local f1_local8 = progressMeterColoredByUsing
	local f1_local9 = progressMeterColoredByUsing.subscribeToModel
	local f1_local10 = Engine.GetModelForController(f1_arg1)
	f1_local9(f1_local8, f1_local10["factions.playerFactionTeamEnum"], progressMeterColoredByUsing.__Color_FullPath)
	progressMeterColoredByUsing:linkToElementModel(self, "clientUseMask", true, progressMeterColoredByUsing.__Color_FullPath)
	f1_local8 = progressMeterColoredByUsing
	f1_local9 = progressMeterColoredByUsing.subscribeToModel
	f1_local10 = Engine.GetModelForController(f1_arg1)
	f1_local9(f1_local8, f1_local10["profile.colorblindMode"], progressMeterColoredByUsing.__Color_FullPath)
	f1_local8 = progressMeterColoredByUsing2
	f1_local9 = progressMeterColoredByUsing2.subscribeToModel
	f1_local10 = Engine.GetModelForController(f1_arg1)
	f1_local9(f1_local8, f1_local10["factions.playerFactionTeamEnum"], progressMeterColoredByUsing2.__Color_FullPath)
	progressMeterColoredByUsing2:linkToElementModel(self, "clientUseMask", true, progressMeterColoredByUsing2.__Color_FullPath)
	f1_local8 = progressMeterColoredByUsing2
	f1_local9 = progressMeterColoredByUsing2.subscribeToModel
	f1_local10 = Engine.GetModelForController(f1_arg1)
	f1_local9(f1_local8, f1_local10["profile.colorblindMode"], progressMeterColoredByUsing2.__Color_FullPath)
	f1_local8 = progressMeterColoredByUsing3
	f1_local9 = progressMeterColoredByUsing3.subscribeToModel
	f1_local10 = Engine.GetModelForController(f1_arg1)
	f1_local9(f1_local8, f1_local10["factions.playerFactionTeamEnum"], progressMeterColoredByUsing3.__Color_FullPath)
	progressMeterColoredByUsing3:linkToElementModel(self, "clientUseMask", true, progressMeterColoredByUsing3.__Color_FullPath)
	f1_local8 = progressMeterColoredByUsing3
	f1_local9 = progressMeterColoredByUsing3.subscribeToModel
	f1_local10 = Engine.GetModelForController(f1_arg1)
	f1_local9(f1_local8, f1_local10["profile.colorblindMode"], progressMeterColoredByUsing3.__Color_FullPath)
	f1_local8 = progressMeterColoredByFlags
	f1_local9 = progressMeterColoredByFlags.subscribeToModel
	f1_local10 = Engine.GetModelForController(f1_arg1)
	f1_local9(f1_local8, f1_local10["profile.colorblindMode"], progressMeterColoredByFlags.__Color_FullPath)
	f1_local8 = progressMeterColoredByFlags2
	f1_local9 = progressMeterColoredByFlags2.subscribeToModel
	f1_local10 = Engine.GetModelForController(f1_arg1)
	f1_local9(f1_local8, f1_local10["profile.colorblindMode"], progressMeterColoredByFlags2.__Color_FullPath)
	f1_local8 = progressMeterColoredByFlags3
	f1_local9 = progressMeterColoredByFlags3.subscribeToModel
	f1_local10 = Engine.GetModelForController(f1_arg1)
	f1_local9(f1_local8, f1_local10["profile.colorblindMode"], progressMeterColoredByFlags3.__Color_FullPath)
	self:mergeStateConditions({
		{
			stateName = "ColorByTeamUsingWaypoint",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsObjectiveXHashPropertyValueEqualTo(self, @"hash_531D5237C084FF4B", 1)
			end,
		},
		{
			stateName = "ColorByFlags",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	self:linkToElementModel(self, "id", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "id",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WaypointProgressRing.__resetProperties = function(f24_arg0)
	f24_arg0.progressMeterColoredByUsing:completeAnimation()
	f24_arg0.progressMeter:completeAnimation()
	f24_arg0.progressMeterColoredByFlags:completeAnimation()
	f24_arg0.progressMeterColoredByUsing3:completeAnimation()
	f24_arg0.progressMeterColoredByUsing2:completeAnimation()
	f24_arg0.progressMeterColoredByFlags3:completeAnimation()
	f24_arg0.progressMeterColoredByFlags2:completeAnimation()
	f24_arg0.progressMeterColoredByUsing:setAlpha(1)
	f24_arg0.progressMeterColoredByUsing:setMaterial(LUI.UIImage.GetCachedMaterial("uie_clock_normal"))
	f24_arg0.progressMeterColoredByUsing:setShaderVector(1, 0.5, 0, 0, 0)
	f24_arg0.progressMeterColoredByUsing:setShaderVector(2, 0.5, 0, 0, 0)
	f24_arg0.progressMeterColoredByUsing:setShaderVector(3, 0, 0, 0, 0)
	f24_arg0.progressMeterColoredByUsing:setShaderVector(4, 0, 0, 0, 0)
	f24_arg0.progressMeter:setAlpha(0.9)
	f24_arg0.progressMeterColoredByFlags:setAlpha(1)
	f24_arg0.progressMeterColoredByUsing3:setAlpha(1)
	f24_arg0.progressMeterColoredByUsing3:setMaterial(LUI.UIImage.GetCachedMaterial("uie_clock_normal"))
	f24_arg0.progressMeterColoredByUsing3:setShaderVector(1, 0.5, 0, 0, 0)
	f24_arg0.progressMeterColoredByUsing3:setShaderVector(2, 0.5, 0, 0, 0)
	f24_arg0.progressMeterColoredByUsing3:setShaderVector(3, 0, 0, 0, 0)
	f24_arg0.progressMeterColoredByUsing3:setShaderVector(4, 0, 0, 0, 0)
	f24_arg0.progressMeterColoredByUsing2:setAlpha(1)
	f24_arg0.progressMeterColoredByFlags3:setAlpha(0.5)
	f24_arg0.progressMeterColoredByFlags2:setAlpha(0.4)
	f24_arg0.progressMeterColoredByFlags2:setMaterial(LUI.UIImage.GetCachedMaterial("uie_clock_normal"))
	f24_arg0.progressMeterColoredByFlags2:setShaderVector(1, 0.5, 0, 0, 0)
	f24_arg0.progressMeterColoredByFlags2:setShaderVector(2, 0.5, 0, 0, 0)
	f24_arg0.progressMeterColoredByFlags2:setShaderVector(3, 0, 0, 0, 0)
	f24_arg0.progressMeterColoredByFlags2:setShaderVector(4, 0, 0, 0, 0)
end
CoD.WaypointProgressRing.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(7)
			f25_arg0.progressMeter:completeAnimation()
			f25_arg0.progressMeter:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.progressMeter)
			f25_arg0.progressMeterColoredByUsing:completeAnimation()
			f25_arg0.progressMeterColoredByUsing:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.progressMeterColoredByUsing)
			f25_arg0.progressMeterColoredByUsing2:completeAnimation()
			f25_arg0.progressMeterColoredByUsing2:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.progressMeterColoredByUsing2)
			f25_arg0.progressMeterColoredByUsing3:completeAnimation()
			f25_arg0.progressMeterColoredByUsing3:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.progressMeterColoredByUsing3)
			f25_arg0.progressMeterColoredByFlags:completeAnimation()
			f25_arg0.progressMeterColoredByFlags:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.progressMeterColoredByFlags)
			f25_arg0.progressMeterColoredByFlags2:completeAnimation()
			f25_arg0.progressMeterColoredByFlags2:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.progressMeterColoredByFlags2)
			f25_arg0.progressMeterColoredByFlags3:completeAnimation()
			f25_arg0.progressMeterColoredByFlags3:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.progressMeterColoredByFlags3)
		end,
	},
	ColorByTeamUsingWaypoint = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(7)
			f26_arg0.progressMeter:completeAnimation()
			f26_arg0.progressMeter:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.progressMeter)
			f26_arg0.progressMeterColoredByUsing:completeAnimation()
			f26_arg0.progressMeterColoredByUsing:setAlpha(1)
			f26_arg0.progressMeterColoredByUsing:setMaterial(LUI.UIImage.GetCachedMaterial("uie_clock_normal"))
			f26_arg0.progressMeterColoredByUsing:setShaderVector(1, 0.5, 0, 0, 0)
			f26_arg0.progressMeterColoredByUsing:setShaderVector(2, 0.5, 0, 0, 0)
			f26_arg0.progressMeterColoredByUsing:setShaderVector(3, 0, 0, 0, 0)
			f26_arg0.progressMeterColoredByUsing:setShaderVector(4, 0, 0, 0, 0)
			f26_arg0.clipFinished(f26_arg0.progressMeterColoredByUsing)
			f26_arg0.progressMeterColoredByUsing2:completeAnimation()
			f26_arg0.progressMeterColoredByUsing2:setAlpha(0.25)
			f26_arg0.clipFinished(f26_arg0.progressMeterColoredByUsing2)
			f26_arg0.progressMeterColoredByUsing3:completeAnimation()
			f26_arg0.progressMeterColoredByUsing3:setAlpha(1)
			f26_arg0.progressMeterColoredByUsing3:setMaterial(LUI.UIImage.GetCachedMaterial("uie_clock_add"))
			f26_arg0.progressMeterColoredByUsing3:setShaderVector(1, 0.5, 0, 0, 0)
			f26_arg0.progressMeterColoredByUsing3:setShaderVector(2, 0.5, 0, 0, 0)
			f26_arg0.progressMeterColoredByUsing3:setShaderVector(3, 0, 0, 0, 0)
			f26_arg0.progressMeterColoredByUsing3:setShaderVector(4, 0, 0, 0, 0)
			f26_arg0.clipFinished(f26_arg0.progressMeterColoredByUsing3)
			f26_arg0.progressMeterColoredByFlags:completeAnimation()
			f26_arg0.progressMeterColoredByFlags:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.progressMeterColoredByFlags)
			f26_arg0.progressMeterColoredByFlags2:completeAnimation()
			f26_arg0.progressMeterColoredByFlags2:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.progressMeterColoredByFlags2)
			f26_arg0.progressMeterColoredByFlags3:completeAnimation()
			f26_arg0.progressMeterColoredByFlags3:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.progressMeterColoredByFlags3)
		end,
	},
	ColorByFlags = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(7)
			f27_arg0.progressMeter:completeAnimation()
			f27_arg0.progressMeter:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.progressMeter)
			f27_arg0.progressMeterColoredByUsing:completeAnimation()
			f27_arg0.progressMeterColoredByUsing:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.progressMeterColoredByUsing)
			f27_arg0.progressMeterColoredByUsing2:completeAnimation()
			f27_arg0.progressMeterColoredByUsing2:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.progressMeterColoredByUsing2)
			f27_arg0.progressMeterColoredByUsing3:completeAnimation()
			f27_arg0.progressMeterColoredByUsing3:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.progressMeterColoredByUsing3)
			f27_arg0.progressMeterColoredByFlags:completeAnimation()
			f27_arg0.progressMeterColoredByFlags:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.progressMeterColoredByFlags)
			f27_arg0.progressMeterColoredByFlags2:completeAnimation()
			f27_arg0.progressMeterColoredByFlags2:setAlpha(0.75)
			f27_arg0.progressMeterColoredByFlags2:setMaterial(LUI.UIImage.GetCachedMaterial("uie_clock_add"))
			f27_arg0.progressMeterColoredByFlags2:setShaderVector(1, 0.5, 0, 0, 0)
			f27_arg0.progressMeterColoredByFlags2:setShaderVector(2, 0.5, 0, 0, 0)
			f27_arg0.progressMeterColoredByFlags2:setShaderVector(3, 0, 0, 0, 0)
			f27_arg0.progressMeterColoredByFlags2:setShaderVector(4, 0, 0, 0, 0)
			f27_arg0.clipFinished(f27_arg0.progressMeterColoredByFlags2)
			f27_arg0.progressMeterColoredByFlags3:completeAnimation()
			f27_arg0.progressMeterColoredByFlags3:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.progressMeterColoredByFlags3)
		end,
	},
}
CoD.WaypointProgressRing.__onClose = function(f28_arg0)
	f28_arg0.progressMeter:close()
	f28_arg0.progressMeterColoredByUsing:close()
	f28_arg0.progressMeterColoredByUsing2:close()
	f28_arg0.progressMeterColoredByUsing3:close()
	f28_arg0.progressMeterColoredByFlags:close()
	f28_arg0.progressMeterColoredByFlags2:close()
	f28_arg0.progressMeterColoredByFlags3:close()
end
