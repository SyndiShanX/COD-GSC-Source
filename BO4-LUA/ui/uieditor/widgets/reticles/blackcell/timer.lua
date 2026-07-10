CoD.Timer = InheritFrom(LUI.UIElement)
CoD.Timer.__defaultWidth = 178
CoD.Timer.__defaultHeight = 73
CoD.Timer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Timer)
	self.id = "Timer"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local timerbgshadow = LUI.UIImage.new(0.5, 0.5, -186, 192, 0.5, 0.5, -148, 140)
	timerbgshadow:setRGB(0, 0, 0)
	timerbgshadow:setAlpha(0.8)
	timerbgshadow:setImage(RegisterImage(@"uie_t7_hud_rocketlauncher_timer"))
	self:addElement(timerbgshadow)
	self.timerbgshadow = timerbgshadow
	local timerbg = LUI.UIImage.new(0.5, 0.5, -186, 192, 0.5, 0.5, -148, 140)
	timerbg:setImage(RegisterImage(@"uie_t7_hud_rocketlauncher_timer"))
	self:addElement(timerbg)
	self.timerbg = timerbg
	local TimerShadow = LUI.UIText.new(0.5, 0.5, -78, 72, 0.5, 0.5, -30, 30)
	TimerShadow:setRGB(0, 0, 0)
	TimerShadow:setAlpha(0.8)
	TimerShadow:setTTF("default")
	TimerShadow:setLetterSpacing(1)
	TimerShadow:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TimerShadow:subscribeToGlobalModel(f1_arg1, "CurrentWeapon", "lockedOnEnemyTimeRemaining", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TimerShadow:setText(NumberAsTime(f2_local0))
		end
	end)
	self:addElement(TimerShadow)
	self.TimerShadow = TimerShadow
	local Timer = LUI.UIText.new(0.5, 0.5, -78, 72, 0.5, 0.5, -30, 30)
	Timer:setTTF("default")
	Timer:setLetterSpacing(1)
	Timer:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Timer:subscribeToGlobalModel(f1_arg1, "CurrentWeapon", "lockedOnEnemyTimeRemaining", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Timer:setText(NumberAsTime(f3_local0))
		end
	end)
	self:addElement(Timer)
	self.Timer = Timer
	self:mergeStateConditions({
		{
			stateName = "Targetting",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEnumBitSet(f1_arg1, "CurrentWeapon", "lockedOnEnemy", Enum[@"rocketlaunchertargetstatesflags"][@"rocket_launcher_target_found"]) and CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "CurrentWeapon", "lockedOnEnemyTimeRemaining", 0)
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.lockedOnEnemy, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lockedOnEnemy",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.lockedOnEnemyTimeRemaining, function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lockedOnEnemyTimeRemaining",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Timer.__resetProperties = function(f7_arg0)
	f7_arg0.Timer:completeAnimation()
	f7_arg0.TimerShadow:completeAnimation()
	f7_arg0.timerbgshadow:completeAnimation()
	f7_arg0.timerbg:completeAnimation()
	f7_arg0.Timer:setAlpha(1)
	f7_arg0.TimerShadow:setAlpha(0.8)
	f7_arg0.timerbgshadow:setAlpha(0.8)
	f7_arg0.timerbg:setAlpha(1)
end
CoD.Timer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(4)
			f8_arg0.timerbgshadow:completeAnimation()
			f8_arg0.timerbgshadow:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.timerbgshadow)
			f8_arg0.timerbg:completeAnimation()
			f8_arg0.timerbg:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.timerbg)
			f8_arg0.TimerShadow:completeAnimation()
			f8_arg0.TimerShadow:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.TimerShadow)
			f8_arg0.Timer:completeAnimation()
			f8_arg0.Timer:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Timer)
		end,
	},
	Targetting = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.Timer.__onClose = function(f10_arg0)
	f10_arg0.TimerShadow:close()
	f10_arg0.Timer:close()
end
