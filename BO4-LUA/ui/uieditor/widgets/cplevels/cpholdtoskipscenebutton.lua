local PostLoadFunc = function(self, controller, menu)
	self:registerEventHandler("update_scene_skip_progress", function(element)
		self.progressMeter:setShaderVector(0, (Engine[@"currentgametime"]() - self._progressStartTime) / (self._progressEndTime - self._progressStartTime), 0, 0, 0)
	end)
	self:linkToElementModel(menu, "sceneSkipEndTime", true, function(model)
		local f3_local0 = Engine[@"getmodelvalue"](model)
		if f3_local0 == 0 then
			if self._sceneSkipUpdateTimer then
				self._sceneSkipUpdateTimer:close()
				self._sceneSkipUpdateTimer = nil
			end
			self.progressMeter:setShaderVector(0, -0.05, 0, 0, 0)
		else
			self._progressStartTime = Engine[@"currentgametime"]()
			self._progressEndTime = f3_local0
			if not self._sceneSkipUpdateTimer then
				self._sceneSkipUpdateTimer = LUI.UITimer.new(1, "update_scene_skip_progress", false)
				self:addElement(self._sceneSkipUpdateTimer)
			end
		end
	end)
end
CoD.CPHoldToSkipSceneButton = InheritFrom(LUI.UIElement)
CoD.CPHoldToSkipSceneButton.__defaultWidth = 30
CoD.CPHoldToSkipSceneButton.__defaultHeight = 30
CoD.CPHoldToSkipSceneButton.new = function(f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4, f4_arg5, f4_arg6, f4_arg7, f4_arg8, f4_arg9)
	local self = LUI.UIElement.new(f4_arg2, f4_arg3, f4_arg4, f4_arg5, f4_arg6, f4_arg7, f4_arg8, f4_arg9)
	self:setClass(CoD.CPHoldToSkipSceneButton)
	self.id = "CPHoldToSkipSceneButton"
	self.soundSet = "default"
	f4_arg0:addElementToPendingUpdateStateList(self)
	local progressMeter = LUI.UIImage.new(0.5, 0.5, -17, 17, 0.5, 0.5, -17, 17)
	progressMeter:setImage(RegisterImage(@"uie_t7_hud_interact_meter_thick"))
	progressMeter:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_clock_normal"))
	progressMeter:setShaderVector(0, -0.05, 0, 0, 0)
	progressMeter:setShaderVector(1, 0.5, 0, 0, 0)
	progressMeter:setShaderVector(2, 0.5, 0, 0, 0)
	progressMeter:setShaderVector(3, 0, 0, 0, 0)
	progressMeter:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(progressMeter)
	self.progressMeter = progressMeter
	local Button = LUI.UIImage.new(0.5, 0.5, -15, 15, 0.5, 0.5, -15, 15)
	Button:subscribeToGlobalModel(f4_arg1, "Controller", "primary_button_image", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Button:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(Button)
	self.Button = Button
	local Mouse = nil
	Mouse = LUI.UIImage.new(0.5, 0.5, -15, 15, 0.5, 0.5, -15, 15)
	Mouse:setAlpha(0)
	Mouse:subscribeToGlobalModel(f4_arg1, "Controller", "mouse_left_button_image", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Mouse:setImage(RegisterImage(f6_local0))
		end
	end)
	self:addElement(Mouse)
	self.Mouse = Mouse
	self:mergeStateConditions({
		{
			stateName = "KBMouse",
			condition = function(menu, element, event)
				local f7_local0
				if not IsGamepad(f4_arg1) then
					f7_local0 = IsPC()
				else
					f7_local0 = false
				end
				return f7_local0
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f8_arg0, f8_arg1)
		f8_arg1.menu = f8_arg1.menu or f4_arg0
		f4_arg0:updateElementState(self, f8_arg1)
	end)
	local f4_local4 = self
	local f4_local5 = self.subscribeToModel
	local f4_local6 = Engine[@"getmodelforcontroller"](f4_arg1)
	f4_local5(f4_local4, f4_local6.LastInput, function(f9_arg0)
		f4_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f4_arg0,
			controller = f4_arg1,
			modelValue = f9_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f4_arg1, f4_arg0)
	end
	return self
end
CoD.CPHoldToSkipSceneButton.__resetProperties = function(f10_arg0)
	f10_arg0.Button:completeAnimation()
	f10_arg0.Mouse:completeAnimation()
	f10_arg0.Button:setAlpha(1)
	f10_arg0.Mouse:setAlpha(0)
end
CoD.CPHoldToSkipSceneButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
	KBMouse = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.Button:completeAnimation()
			f12_arg0.Button:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Button)
			f12_arg0.Mouse:completeAnimation()
			f12_arg0.Mouse:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.Mouse)
		end,
	},
}
CoD.CPHoldToSkipSceneButton.__onClose = function(f13_arg0)
	f13_arg0.Button:close()
	f13_arg0.Mouse:close()
end
