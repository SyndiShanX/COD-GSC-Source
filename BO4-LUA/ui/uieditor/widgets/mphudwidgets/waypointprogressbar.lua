CoD.WaypointProgressBar = InheritFrom(LUI.UIElement)
CoD.WaypointProgressBar.__defaultWidth = 256
CoD.WaypointProgressBar.__defaultHeight = 32
CoD.WaypointProgressBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WaypointProgressBar)
	self.id = "WaypointProgressBar"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ProgressBarBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ProgressBarBacking:setRGB(0.47, 0.49, 0.53)
	ProgressBarBacking:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe_normal"))
	ProgressBarBacking:setShaderVector(0, 1, 0, 0, 0)
	ProgressBarBacking:setShaderVector(1, 0, 0, 0, 0)
	ProgressBarBacking:setShaderVector(2, 1, 0, 0, 0)
	ProgressBarBacking:setShaderVector(3, 0, 0, 0, 0)
	ProgressBarBacking:setShaderVector(4, 1, 0.03, 1, 0)
	self:addElement(ProgressBarBacking)
	self.ProgressBarBacking = ProgressBarBacking
	local ProgressBarWhite = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ProgressBarWhite:setScale(1, 1.8)
	ProgressBarWhite:setImage(RegisterImage("uie_ui_hud_core_capture_bar"))
	ProgressBarWhite:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe_normal"))
	ProgressBarWhite:setShaderVector(1, 0, 0, 0, 0)
	ProgressBarWhite:setShaderVector(2, 1, 0, 0, 0)
	ProgressBarWhite:setShaderVector(3, 0, 0, 0, 0)
	ProgressBarWhite:setShaderVector(4, 0, 0, 0, 0)
	ProgressBarWhite:linkToElementModel(self, "progress", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ProgressBarWhite:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(ProgressBarWhite)
	self.ProgressBarWhite = ProgressBarWhite
	local ProgressBarColor2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ProgressBarColor2:setAlpha(0)
	ProgressBarColor2:setScale(1, 1.9)
	ProgressBarColor2:setImage(RegisterImage("uie_ui_hud_core_capture_bar"))
	ProgressBarColor2:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe_normal"))
	ProgressBarColor2:setShaderVector(1, 0, 0, 0, 0)
	ProgressBarColor2:setShaderVector(2, 1, 0, 0, 0)
	ProgressBarColor2:setShaderVector(3, 0, 0, 0, 0)
	ProgressBarColor2:setShaderVector(4, 0, 0, 0, 0)
	ProgressBarColor2.__Color = function(f3_arg0)
		local f3_local0 = f3_arg0:get()
		if f3_local0 ~= nil then
			ProgressBarColor2:setRGB(CoD.HUDUtility.GetFriendlyOrEnemyBrightColorByObjId(f1_arg1, f3_local0))
		end
	end
	ProgressBarColor2:linkToElementModel(self, "objId", true, ProgressBarColor2.__Color)
	ProgressBarColor2.__Color_FullPath = function()
		local f4_local0 = self:getModel()
		if f4_local0 then
			f4_local0 = self:getModel()
			f4_local0 = f4_local0.objId
		end
		if f4_local0 then
			ProgressBarColor2.__Color(f4_local0)
		end
	end
	ProgressBarColor2:linkToElementModel(self, "progress", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			ProgressBarColor2:setShaderVector(0, CoD.GetVectorComponentFromString(f5_local0, 1), CoD.GetVectorComponentFromString(f5_local0, 2), CoD.GetVectorComponentFromString(f5_local0, 3), CoD.GetVectorComponentFromString(f5_local0, 4))
		end
	end)
	self:addElement(ProgressBarColor2)
	self.ProgressBarColor2 = ProgressBarColor2
	local ProgressBarColor = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ProgressBarColor:setAlpha(0)
	ProgressBarColor:setScale(1, 1.4)
	ProgressBarColor:setImage(RegisterImage("uie_ui_hud_core_capture_bar"))
	ProgressBarColor:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe_normal"))
	ProgressBarColor:setShaderVector(1, 0, 0, 0, 0)
	ProgressBarColor:setShaderVector(2, 1, 0, 0, 0)
	ProgressBarColor:setShaderVector(3, 0, 0, 0, 0)
	ProgressBarColor:setShaderVector(4, 0, 0, 0, 0)
	ProgressBarColor.__Color = function(f6_arg0)
		local f6_local0 = f6_arg0:get()
		if f6_local0 ~= nil then
			ProgressBarColor:setRGB(CoD.HUDUtility.GetFriendlyOrEnemyColorByObjId(f1_arg1, f6_local0))
		end
	end
	ProgressBarColor:linkToElementModel(self, "objId", true, ProgressBarColor.__Color)
	ProgressBarColor.__Color_FullPath = function()
		local f7_local0 = self:getModel()
		if f7_local0 then
			f7_local0 = self:getModel()
			f7_local0 = f7_local0.objId
		end
		if f7_local0 then
			ProgressBarColor.__Color(f7_local0)
		end
	end
	ProgressBarColor:linkToElementModel(self, "progress", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			ProgressBarColor:setShaderVector(0, CoD.GetVectorComponentFromString(f8_local0, 1), CoD.GetVectorComponentFromString(f8_local0, 2), CoD.GetVectorComponentFromString(f8_local0, 3), CoD.GetVectorComponentFromString(f8_local0, 4))
		end
	end)
	self:addElement(ProgressBarColor)
	self.ProgressBarColor = ProgressBarColor
	local ProgressBarColoByFlags2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ProgressBarColoByFlags2:setAlpha(0)
	ProgressBarColoByFlags2:setScale(1, 1.8)
	ProgressBarColoByFlags2:setImage(RegisterImage("uie_ui_hud_core_capture_bar"))
	ProgressBarColoByFlags2:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe_normal"))
	ProgressBarColoByFlags2:setShaderVector(1, 0, 0, 0, 0)
	ProgressBarColoByFlags2:setShaderVector(2, 1, 0, 0, 0)
	ProgressBarColoByFlags2:setShaderVector(3, 0, 0, 0, 0)
	ProgressBarColoByFlags2:setShaderVector(4, 0, 0, 0, 0)
	ProgressBarColoByFlags2.__Color = function(f9_arg0)
		local f9_local0 = f9_arg0:get()
		if f9_local0 ~= nil then
			ProgressBarColoByFlags2:setRGB(CoD.HUDUtility.GetFriendlyOrEnemyBrightColorByFlags(self:getModel(), f1_arg1, f9_local0))
		end
	end
	ProgressBarColoByFlags2:linkToElementModel(self, "gamemodeFlags", true, ProgressBarColoByFlags2.__Color)
	ProgressBarColoByFlags2.__Color_FullPath = function()
		local f10_local0 = self:getModel()
		if f10_local0 then
			f10_local0 = self:getModel()
			f10_local0 = f10_local0.gamemodeFlags
		end
		if f10_local0 then
			ProgressBarColoByFlags2.__Color(f10_local0)
		end
	end
	ProgressBarColoByFlags2:linkToElementModel(self, "progress", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			ProgressBarColoByFlags2:setShaderVector(0, CoD.GetVectorComponentFromString(f11_local0, 1), CoD.GetVectorComponentFromString(f11_local0, 2), CoD.GetVectorComponentFromString(f11_local0, 3), CoD.GetVectorComponentFromString(f11_local0, 4))
		end
	end)
	self:addElement(ProgressBarColoByFlags2)
	self.ProgressBarColoByFlags2 = ProgressBarColoByFlags2
	local ProgressBarColoByFlags = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ProgressBarColoByFlags:setAlpha(0)
	ProgressBarColoByFlags:setScale(1, 1.8)
	ProgressBarColoByFlags:setImage(RegisterImage("uie_ui_hud_core_capture_bar"))
	ProgressBarColoByFlags:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe_normal"))
	ProgressBarColoByFlags:setShaderVector(1, 0, 0, 0, 0)
	ProgressBarColoByFlags:setShaderVector(2, 1, 0, 0, 0)
	ProgressBarColoByFlags:setShaderVector(3, 0, 0, 0, 0)
	ProgressBarColoByFlags:setShaderVector(4, 0, 0, 0, 0)
	ProgressBarColoByFlags.__Color = function(f12_arg0)
		local f12_local0 = f12_arg0:get()
		if f12_local0 ~= nil then
			ProgressBarColoByFlags:setRGB(CoD.HUDUtility.GetFriendlyOrEnemyColorByFlags(self:getModel(), f1_arg1, f12_local0))
		end
	end
	ProgressBarColoByFlags:linkToElementModel(self, "gamemodeFlags", true, ProgressBarColoByFlags.__Color)
	ProgressBarColoByFlags.__Color_FullPath = function()
		local f13_local0 = self:getModel()
		if f13_local0 then
			f13_local0 = self:getModel()
			f13_local0 = f13_local0.gamemodeFlags
		end
		if f13_local0 then
			ProgressBarColoByFlags.__Color(f13_local0)
		end
	end
	ProgressBarColoByFlags:linkToElementModel(self, "progress", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			ProgressBarColoByFlags:setShaderVector(0, CoD.GetVectorComponentFromString(f14_local0, 1), CoD.GetVectorComponentFromString(f14_local0, 2), CoD.GetVectorComponentFromString(f14_local0, 3), CoD.GetVectorComponentFromString(f14_local0, 4))
		end
	end)
	self:addElement(ProgressBarColoByFlags)
	self.ProgressBarColoByFlags = ProgressBarColoByFlags
	local f1_local7 = ProgressBarColor2
	local f1_local8 = ProgressBarColor2.subscribeToModel
	local f1_local9 = Engine.GetModelForController(f1_arg1)
	f1_local8(f1_local7, f1_local9["factions.playerFactionTeamEnum"], ProgressBarColor2.__Color_FullPath)
	ProgressBarColor2:linkToElementModel(self, "clientUseMask", true, ProgressBarColor2.__Color_FullPath)
	f1_local7 = ProgressBarColor2
	f1_local8 = ProgressBarColor2.subscribeToModel
	f1_local9 = Engine.GetModelForController(f1_arg1)
	f1_local8(f1_local7, f1_local9["profile.colorblindMode"], ProgressBarColor2.__Color_FullPath)
	f1_local7 = ProgressBarColor
	f1_local8 = ProgressBarColor.subscribeToModel
	f1_local9 = Engine.GetModelForController(f1_arg1)
	f1_local8(f1_local7, f1_local9["factions.playerFactionTeamEnum"], ProgressBarColor.__Color_FullPath)
	ProgressBarColor:linkToElementModel(self, "clientUseMask", true, ProgressBarColor.__Color_FullPath)
	f1_local7 = ProgressBarColor
	f1_local8 = ProgressBarColor.subscribeToModel
	f1_local9 = Engine.GetModelForController(f1_arg1)
	f1_local8(f1_local7, f1_local9["profile.colorblindMode"], ProgressBarColor.__Color_FullPath)
	f1_local7 = ProgressBarColoByFlags2
	f1_local8 = ProgressBarColoByFlags2.subscribeToModel
	f1_local9 = Engine.GetModelForController(f1_arg1)
	f1_local8(f1_local7, f1_local9["profile.colorblindMode"], ProgressBarColoByFlags2.__Color_FullPath)
	f1_local7 = ProgressBarColoByFlags
	f1_local8 = ProgressBarColoByFlags.subscribeToModel
	f1_local9 = Engine.GetModelForController(f1_arg1)
	f1_local8(f1_local7, f1_local9["profile.colorblindMode"], ProgressBarColoByFlags.__Color_FullPath)
	self:mergeStateConditions({
		{
			stateName = "ColorBar",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsObjectiveXHashPropertyValueEqualTo(self, @"hash_531D5237C084FF4B", 1)
			end,
		},
		{
			stateName = "ColorBarByFlags",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "gamemodeFlags", 0)
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
	self:linkToElementModel(self, "gamemodeFlags", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "gamemodeFlags",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WaypointProgressBar.__resetProperties = function(f19_arg0)
	f19_arg0.ProgressBarWhite:completeAnimation()
	f19_arg0.ProgressBarColor:completeAnimation()
	f19_arg0.ProgressBarBacking:completeAnimation()
	f19_arg0.ProgressBarColor2:completeAnimation()
	f19_arg0.ProgressBarColoByFlags:completeAnimation()
	f19_arg0.ProgressBarColoByFlags2:completeAnimation()
	f19_arg0.ProgressBarWhite:setAlpha(1)
	f19_arg0.ProgressBarWhite:setScale(1, 1.8)
	f19_arg0.ProgressBarColor:setAlpha(0)
	f19_arg0.ProgressBarColor:setScale(1, 1.4)
	f19_arg0.ProgressBarBacking:setAlpha(1)
	f19_arg0.ProgressBarBacking:setScale(1, 1)
	f19_arg0.ProgressBarColor2:setAlpha(0)
	f19_arg0.ProgressBarColor2:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe_normal"))
	f19_arg0.ProgressBarColor2:setShaderVector(1, 0, 0, 0, 0)
	f19_arg0.ProgressBarColor2:setShaderVector(2, 1, 0, 0, 0)
	f19_arg0.ProgressBarColor2:setShaderVector(3, 0, 0, 0, 0)
	f19_arg0.ProgressBarColor2:setShaderVector(4, 0, 0, 0, 0)
	f19_arg0.ProgressBarColoByFlags:setAlpha(0)
	f19_arg0.ProgressBarColoByFlags2:setAlpha(0)
end
CoD.WaypointProgressBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(3)
			f20_arg0.ProgressBarBacking:completeAnimation()
			f20_arg0.ProgressBarBacking:setAlpha(0.5)
			f20_arg0.clipFinished(f20_arg0.ProgressBarBacking)
			f20_arg0.ProgressBarWhite:completeAnimation()
			f20_arg0.ProgressBarWhite:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.ProgressBarWhite)
			f20_arg0.ProgressBarColor:completeAnimation()
			f20_arg0.ProgressBarColor:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.ProgressBarColor)
		end,
		Pulsing = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			local f21_local0 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					f23_arg0:beginAnimation(880)
					f23_arg0:setScale(1, 1)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
				end
				f21_arg0.ProgressBarBacking:beginAnimation(120)
				f21_arg0.ProgressBarBacking:setScale(0.8, 0.8)
				f21_arg0.ProgressBarBacking:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.ProgressBarBacking:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f21_arg0.ProgressBarBacking:completeAnimation()
			f21_arg0.ProgressBarBacking:setScale(1, 1)
			f21_local0(f21_arg0.ProgressBarBacking)
			local f21_local1 = function(f24_arg0)
				local f24_local0 = function(f25_arg0)
					f25_arg0:beginAnimation(880)
					f25_arg0:setScale(1, 1)
					f25_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
				end
				f21_arg0.ProgressBarWhite:beginAnimation(120)
				f21_arg0.ProgressBarWhite:setScale(0.8, 0.8)
				f21_arg0.ProgressBarWhite:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.ProgressBarWhite:registerEventHandler("transition_complete_keyframe", f24_local0)
			end
			f21_arg0.ProgressBarWhite:completeAnimation()
			f21_arg0.ProgressBarWhite:setAlpha(1)
			f21_arg0.ProgressBarWhite:setScale(1, 1)
			f21_local1(f21_arg0.ProgressBarWhite)
			f21_arg0.ProgressBarColor:completeAnimation()
			f21_arg0.ProgressBarColor:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.ProgressBarColor)
			f21_arg0.nextClip = "Pulsing"
		end,
	},
	ColorBar = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(4)
			f26_arg0.ProgressBarBacking:completeAnimation()
			f26_arg0.ProgressBarBacking:setAlpha(0.5)
			f26_arg0.clipFinished(f26_arg0.ProgressBarBacking)
			f26_arg0.ProgressBarWhite:completeAnimation()
			f26_arg0.ProgressBarWhite:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.ProgressBarWhite)
			f26_arg0.ProgressBarColor2:completeAnimation()
			f26_arg0.ProgressBarColor2:setAlpha(1)
			f26_arg0.ProgressBarColor2:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
			f26_arg0.ProgressBarColor2:setShaderVector(1, 0, 0, 0, 0)
			f26_arg0.ProgressBarColor2:setShaderVector(2, 1, 0, 0, 0)
			f26_arg0.ProgressBarColor2:setShaderVector(3, 0, 0, 0, 0)
			f26_arg0.ProgressBarColor2:setShaderVector(4, 0, 0, 0, 0)
			f26_arg0.clipFinished(f26_arg0.ProgressBarColor2)
			f26_arg0.ProgressBarColor:completeAnimation()
			f26_arg0.ProgressBarColor:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.ProgressBarColor)
		end,
		Pulsing = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(3)
			local f27_local0 = function(f28_arg0)
				local f28_local0 = function(f29_arg0)
					f29_arg0:beginAnimation(880)
					f29_arg0:setScale(1, 1)
					f29_arg0:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
				end
				f27_arg0.ProgressBarBacking:beginAnimation(120)
				f27_arg0.ProgressBarBacking:setScale(0.8, 0.8)
				f27_arg0.ProgressBarBacking:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.ProgressBarBacking:registerEventHandler("transition_complete_keyframe", f28_local0)
			end
			f27_arg0.ProgressBarBacking:completeAnimation()
			f27_arg0.ProgressBarBacking:setScale(1, 1)
			f27_local0(f27_arg0.ProgressBarBacking)
			f27_arg0.ProgressBarWhite:completeAnimation()
			f27_arg0.ProgressBarWhite:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.ProgressBarWhite)
			local f27_local1 = function(f30_arg0)
				local f30_local0 = function(f31_arg0)
					f31_arg0:beginAnimation(880)
					f31_arg0:setScale(1, 1)
					f31_arg0:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
				end
				f27_arg0.ProgressBarColor:beginAnimation(120)
				f27_arg0.ProgressBarColor:setScale(0.8, 0.8)
				f27_arg0.ProgressBarColor:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.ProgressBarColor:registerEventHandler("transition_complete_keyframe", f30_local0)
			end
			f27_arg0.ProgressBarColor:completeAnimation()
			f27_arg0.ProgressBarColor:setAlpha(1)
			f27_arg0.ProgressBarColor:setScale(1, 1)
			f27_local1(f27_arg0.ProgressBarColor)
			f27_arg0.nextClip = "Pulsing"
		end,
	},
	ColorBarByFlags = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(2)
			f32_arg0.ProgressBarColoByFlags2:completeAnimation()
			f32_arg0.ProgressBarColoByFlags2:setAlpha(1)
			f32_arg0.clipFinished(f32_arg0.ProgressBarColoByFlags2)
			f32_arg0.ProgressBarColoByFlags:completeAnimation()
			f32_arg0.ProgressBarColoByFlags:setAlpha(1)
			f32_arg0.clipFinished(f32_arg0.ProgressBarColoByFlags)
		end,
	},
}
CoD.WaypointProgressBar.__onClose = function(f33_arg0)
	f33_arg0.ProgressBarWhite:close()
	f33_arg0.ProgressBarColor2:close()
	f33_arg0.ProgressBarColor:close()
	f33_arg0.ProgressBarColoByFlags2:close()
	f33_arg0.ProgressBarColoByFlags:close()
end
