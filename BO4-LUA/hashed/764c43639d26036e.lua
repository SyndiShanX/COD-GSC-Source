CoD.WarzoneCastTimeContainer = InheritFrom(LUI.UIElement)
CoD.WarzoneCastTimeContainer.__defaultWidth = 32
CoD.WarzoneCastTimeContainer.__defaultHeight = 32
CoD.WarzoneCastTimeContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneCastTimeContainer)
	self.id = "WarzoneCastTimeContainer"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = nil
	Backing = LUI.UIImage.new(0.5, 0.5, -36, 32, 0.5, 0.5, -30, 30)
	Backing:setRGB(0.34, 0.32, 0.2)
	Backing:setAlpha(0)
	Backing:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_player_widget_ability_backer"))
	self:addElement(Backing)
	self.Backing = Backing
	local ClockMeterAdd = nil
	ClockMeterAdd = LUI.UIImage.new(0.5, 0.5, -35, 31, 0.5, 0.5, -29, 29)
	ClockMeterAdd:setRGB(0, 0, 0)
	ClockMeterAdd:setAlpha(0.8)
	ClockMeterAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_clock_normal"))
	ClockMeterAdd:setShaderVector(1, 0.5, 0, 0, 0)
	ClockMeterAdd:setShaderVector(2, 0.5, 0, 0, 0)
	ClockMeterAdd:setShaderVector(3, 0, 0, 0, 0)
	ClockMeterAdd:setShaderVector(4, 0, 0, 0, 0)
	ClockMeterAdd:linkToElementModel(self, "castTimeFraction", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ClockMeterAdd:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(ClockMeterAdd)
	self.ClockMeterAdd = ClockMeterAdd
	self:mergeStateConditions({
		{
			stateName = "InUse",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(self, f1_arg1, "castTimeFraction", 0)
			end,
		},
	})
	self:linkToElementModel(self, "castTimeFraction", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "castTimeFraction",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneCastTimeContainer.__resetProperties = function(f5_arg0)
	f5_arg0.Backing:completeAnimation()
	f5_arg0.Backing:setAlpha(0)
end
CoD.WarzoneCastTimeContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	InUse = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Backing:completeAnimation()
			f7_arg0.Backing:setAlpha(0.85)
			f7_arg0.clipFinished(f7_arg0.Backing)
		end,
	},
}
CoD.WarzoneCastTimeContainer.__onClose = function(f8_arg0)
	f8_arg0.ClockMeterAdd:close()
end
