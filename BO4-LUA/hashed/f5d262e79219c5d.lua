require("x64:1ff1c0d96dd8207")
require("x64:5c0334ae187f881")
CoD.SprintMeter = InheritFrom(LUI.UIElement)
CoD.SprintMeter.__defaultWidth = 255
CoD.SprintMeter.__defaultHeight = 60
CoD.SprintMeter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	SetProperty(self, "_lastScalableWidth", -1)
	self:setClass(CoD.SprintMeter)
	self.id = "SprintMeter"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Bg = LUI.UIImage.new(0.5, 0.5, -124, 120, 0.5, 0.5, -33, 40)
	Bg:setRGB(0, 0, 0)
	Bg:setAlpha(0.5)
	Bg:setYRot(180)
	Bg:setImage(RegisterImage(@"uie_hud_sprintmeter_bg"))
	self:addElement(Bg)
	self.Bg = Bg
	local sprintMeter = CoD.SprintMeterDots.new(f1_arg0, f1_arg1, 0.5, 0.5, -105.5, 101.5, 1, 1, -54, 0)
	sprintMeter:setYRot(180)
	self:addElement(sprintMeter)
	self.sprintMeter = sprintMeter
	local sprintArrows = CoD.SprintMeterArrows.new(f1_arg0, f1_arg1, 0.5, 0.5, -11, 11, 1, 1, -449, 1)
	sprintArrows.right1:setZRot(27)
	self:addElement(sprintArrows)
	self.sprintArrows = sprintArrows
	self:mergeStateConditions({
		{
			stateName = "SprintDecay",
			condition = function(menu, element, event)
				return IsUsingSprintDecay()
			end,
		},
		{
			stateName = "Exhausted",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg1, "playerAbilities.playerSprintExhausted")
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["playerAbilities.playerSprintExhausted"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "playerAbilities.playerSprintExhausted",
		})
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "PlayerAbilities", "playerSprintRatio", function(model)
		local f5_local0 = self
		CoD.HUDUtility.UpdateThrustMeter(self, self.sprintMeter, self.sprintArrows, f1_arg1, model)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SprintMeter.__resetProperties = function(f6_arg0)
	f6_arg0.sprintArrows:completeAnimation()
	f6_arg0.Bg:completeAnimation()
	f6_arg0.sprintMeter:completeAnimation()
	f6_arg0.sprintArrows:setAlpha(1)
	f6_arg0.Bg:setRGB(0, 0, 0)
	f6_arg0.Bg:setAlpha(0.5)
	f6_arg0.sprintMeter:setAlpha(1)
end
CoD.SprintMeter.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	SprintDecay = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.Bg:completeAnimation()
			f8_arg0.Bg:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Bg)
			f8_arg0.sprintArrows:completeAnimation()
			f8_arg0.sprintArrows:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.sprintArrows)
		end,
	},
	Exhausted = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			f9_arg0.Bg:completeAnimation()
			f9_arg0.Bg:setRGB(1, 0, 0)
			f9_arg0.Bg:setAlpha(0.3)
			f9_arg0.clipFinished(f9_arg0.Bg)
			f9_arg0.sprintMeter:completeAnimation()
			f9_arg0.sprintMeter:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.sprintMeter)
			f9_arg0.sprintArrows:completeAnimation()
			f9_arg0.sprintArrows:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.sprintArrows)
		end,
	},
}
CoD.SprintMeter.__onClose = function(f10_arg0)
	f10_arg0.sprintMeter:close()
	f10_arg0.sprintArrows:close()
end
