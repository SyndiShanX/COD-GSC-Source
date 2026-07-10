CoD.ai_tank_health_bar = InheritFrom(LUI.UIElement)
CoD.ai_tank_health_bar.__defaultWidth = 409
CoD.ai_tank_health_bar.__defaultHeight = 45
CoD.ai_tank_health_bar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ai_tank_health_bar)
	self.id = "ai_tank_health_bar"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 0, 0, 409, 0, 0, 0, 45)
	Background:setAlpha(0)
	self:addElement(Background)
	self.Background = Background
	local EmptyBars = LUI.UIImage.new(0, 0, 15.5, 393.5, 1, 1, -26, 0)
	EmptyBars:setRGB(0, 0, 0)
	EmptyBars:setImage(RegisterImage(0x3354D87301C3D8D))
	EmptyBars:setMaterial(LUI.UIImage.GetCachedMaterial(0x6E9593DF28749F2))
	EmptyBars:setShaderVector(0, 20, 1, 0, 0)
	EmptyBars:setShaderVector(1, SetVectorComponent(4, 1, SetVectorComponent(2, 1, 0, 1, 0, 1)))
	self:addElement(EmptyBars)
	self.EmptyBars = EmptyBars
	local LowHealthGlow = LUI.UIImage.new(0, 0, 15.5, 393.5, 1, 1, -26, 0)
	LowHealthGlow:setAlpha(0)
	LowHealthGlow:setImage(RegisterImage(0x5BE416E17DAB33B))
	self:addElement(LowHealthGlow)
	self.LowHealthGlow = LowHealthGlow
	local FillBars = LUI.UIImage.new(0, 0, 15.5, 393.5, 1, 1, -26, 0)
	FillBars:setImage(RegisterImage(0x3354D87301C3D8D))
	FillBars:setMaterial(LUI.UIImage.GetCachedMaterial(0x6E9593DF28749F2))
	FillBars:setShaderVector(0, 20, 1, 0, 0)
	FillBars:setShaderVector(1, SetVectorComponent(4, 1, SetVectorComponent(2, 1, 0, 1, 0, 1)))
	self:addElement(FillBars)
	self.FillBars = FillBars
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showPooledHealthBar")
			end,
		},
		{
			stateName = "LowHealth",
			condition = function(menu, element, event)
				return CoD.VehicleUtility.VehicleLowHealth(self, 0.2)
			end,
		},
	})
	self:linkToElementModel(self, "showPooledHealthBar", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "showPooledHealthBar",
		})
	end)
	self:linkToElementModel(self, "damage", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "damage",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local5 = self
	f1_local5 = FillBars
	CoD.VehicleUtility.SetupTankWipeValue(self, f1_arg1)
	return self
end
CoD.ai_tank_health_bar.__resetProperties = function(f6_arg0)
	f6_arg0.LowHealthGlow:completeAnimation()
	f6_arg0.FillBars:completeAnimation()
	f6_arg0.EmptyBars:completeAnimation()
	f6_arg0.Background:completeAnimation()
	f6_arg0.LowHealthGlow:setLeftRight(0, 0, 15.5, 393.5)
	f6_arg0.LowHealthGlow:setTopBottom(1, 1, -26, 0)
	f6_arg0.LowHealthGlow:setRGB(1, 1, 1)
	f6_arg0.LowHealthGlow:setAlpha(0)
	f6_arg0.FillBars:setAlpha(1)
	f6_arg0.EmptyBars:setAlpha(1)
	f6_arg0.Background:setAlpha(0)
end
CoD.ai_tank_health_bar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
		LowHealth = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.LowHealthGlow:beginAnimation(200)
				f8_arg0.LowHealthGlow:setAlpha(1)
				f8_arg0.LowHealthGlow:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.LowHealthGlow:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.LowHealthGlow:completeAnimation()
			f8_arg0.LowHealthGlow:setAlpha(0)
			f8_local0(f8_arg0.LowHealthGlow)
		end,
	},
	Hidden = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(4)
			f10_arg0.Background:completeAnimation()
			f10_arg0.Background:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Background)
			f10_arg0.EmptyBars:completeAnimation()
			f10_arg0.EmptyBars:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.EmptyBars)
			f10_arg0.LowHealthGlow:completeAnimation()
			f10_arg0.LowHealthGlow:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.LowHealthGlow)
			f10_arg0.FillBars:completeAnimation()
			f10_arg0.FillBars:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.FillBars)
		end,
		LowHealth = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.LowHealthGlow:beginAnimation(200)
				f11_arg0.LowHealthGlow:setAlpha(1)
				f11_arg0.LowHealthGlow:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.LowHealthGlow:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.LowHealthGlow:completeAnimation()
			f11_arg0.LowHealthGlow:setAlpha(0)
			f11_local0(f11_arg0.LowHealthGlow)
		end,
	},
	LowHealth = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.LowHealthGlow:completeAnimation()
			f13_arg0.LowHealthGlow:setLeftRight(0, 0, -123, 532)
			f13_arg0.LowHealthGlow:setTopBottom(1, 1, -28, 2)
			f13_arg0.LowHealthGlow:setRGB(0.99, 0.11, 0.11)
			f13_arg0.LowHealthGlow:setAlpha(0.7)
			f13_arg0.clipFinished(f13_arg0.LowHealthGlow)
		end,
	},
}
CoD.ai_tank_health_bar.__onClose = function(f14_arg0)
	f14_arg0.FillBars:close()
end
