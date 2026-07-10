CoD.Target = InheritFrom(LUI.UIElement)
CoD.Target.__defaultWidth = 166
CoD.Target.__defaultHeight = 78
CoD.Target.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Target)
	self.id = "Target"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local timerbgshadow = LUI.UIImage.new(0.5, 0.5, -175, 203, 0.5, 0.5, -152, 136)
	timerbgshadow:setRGB(0, 0, 0)
	timerbgshadow:setAlpha(0.8)
	timerbgshadow:setImage(RegisterImage(@"uie_t7_hud_rocketlauncher_timer"))
	self:addElement(timerbgshadow)
	self.timerbgshadow = timerbgshadow
	local timerbg = LUI.UIImage.new(0.5, 0.5, -175, 203, 0.5, 0.5, -152, 136)
	timerbg:setImage(RegisterImage(@"uie_t7_hud_rocketlauncher_timer"))
	self:addElement(timerbg)
	self.timerbg = timerbg
	local iconshadow = LUI.UIImage.new(0.5, 0.5, -114, 66, 0.5, 0.5, -103, 95)
	iconshadow:setRGB(0, 0, 0)
	iconshadow:setImage(RegisterImage(@"uie_t7_hud_rocketlauncher_targetreticle"))
	self:addElement(iconshadow)
	self.iconshadow = iconshadow
	local icon = LUI.UIImage.new(0.5, 0.5, -114, 66, 0.5, 0.5, -103, 95)
	icon:setImage(RegisterImage(@"uie_t7_hud_rocketlauncher_targetreticle"))
	self:addElement(icon)
	self.icon = icon
	local TimerShadow = LUI.UIText.new(0.5, 0.5, 29, 95, 0.5, 0.5, -30, 30)
	TimerShadow:setRGB(0, 0, 0)
	TimerShadow:setTTF("default")
	TimerShadow:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TimerShadow:subscribeToGlobalModel(f1_arg1, "CurrentWeapon", "lockedOnEnemyMissilesRemaining", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TimerShadow:setText(f2_local0)
		end
	end)
	self:addElement(TimerShadow)
	self.TimerShadow = TimerShadow
	local Timer0 = LUI.UIText.new(0.5, 0.5, 29, 95, 0.5, 0.5, -30, 30)
	Timer0:setTTF("default")
	Timer0:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Timer0:subscribeToGlobalModel(f1_arg1, "CurrentWeapon", "lockedOnEnemyMissilesRemaining", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Timer0:setText(f3_local0)
		end
	end)
	self:addElement(Timer0)
	self.Timer0 = Timer0
	self:mergeStateConditions({
		{
			stateName = "LockedOn",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEnumBitSet(f1_arg1, "CurrentWeapon", "lockedOnEnemy", Enum[@"rocketlaunchertargetstatesflags"][@"rocket_launcher_target_found"])
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local8(f1_local7, f1_local9.lockedOnEnemy, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lockedOnEnemy",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Target.__resetProperties = function(f6_arg0)
	f6_arg0.Timer0:completeAnimation()
	f6_arg0.icon:completeAnimation()
	f6_arg0.timerbg:completeAnimation()
	f6_arg0.TimerShadow:completeAnimation()
	f6_arg0.iconshadow:completeAnimation()
	f6_arg0.timerbgshadow:completeAnimation()
	f6_arg0.Timer0:setAlpha(1)
	f6_arg0.icon:setAlpha(1)
	f6_arg0.timerbg:setAlpha(1)
	f6_arg0.TimerShadow:setAlpha(1)
	f6_arg0.iconshadow:setAlpha(1)
	f6_arg0.timerbgshadow:setAlpha(0.8)
end
CoD.Target.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(6)
			f7_arg0.timerbgshadow:completeAnimation()
			f7_arg0.timerbgshadow:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.timerbgshadow)
			f7_arg0.timerbg:completeAnimation()
			f7_arg0.timerbg:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.timerbg)
			f7_arg0.iconshadow:completeAnimation()
			f7_arg0.iconshadow:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.iconshadow)
			f7_arg0.icon:completeAnimation()
			f7_arg0.icon:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.icon)
			f7_arg0.TimerShadow:completeAnimation()
			f7_arg0.TimerShadow:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.TimerShadow)
			f7_arg0.Timer0:completeAnimation()
			f7_arg0.Timer0:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Timer0)
		end,
	},
	LockedOn = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.iconshadow:completeAnimation()
			f8_arg0.iconshadow:setAlpha(0.8)
			f8_arg0.clipFinished(f8_arg0.iconshadow)
			f8_arg0.TimerShadow:completeAnimation()
			f8_arg0.TimerShadow:setAlpha(0.8)
			f8_arg0.clipFinished(f8_arg0.TimerShadow)
		end,
	},
}
CoD.Target.__onClose = function(f9_arg0)
	f9_arg0.TimerShadow:close()
	f9_arg0.Timer0:close()
end
