CoD.CODCasterTeamBaseGradient = InheritFrom(LUI.UIElement)
CoD.CODCasterTeamBaseGradient.__defaultWidth = 1920
CoD.CODCasterTeamBaseGradient.__defaultHeight = 155
CoD.CODCasterTeamBaseGradient.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CODCasterTeamBaseGradient)
	self.id = "CODCasterTeamBaseGradient"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GradientL = LUI.UIImage.new(0, 0, 0, 1250, 0, 1, 0, 0)
	GradientL:setAlpha(0)
	GradientL:setYRot(180)
	GradientL:setImage(RegisterImage(0x87AA9A2E0B5D9A6))
	GradientL:subscribeToGlobalModel(f1_arg1, "DeadSpectate", "playerIndex", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GradientL:setRGB(TeamColorFromPlayerIndex(f1_arg1, f2_local0))
		end
	end)
	self:addElement(GradientL)
	self.GradientL = GradientL
	self:mergeStateConditions({
		{
			stateName = "CODCaster",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg1)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["factions.isCoDCaster"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CODCasterTeamBaseGradient.__resetProperties = function(f5_arg0)
	f5_arg0.GradientL:completeAnimation()
	f5_arg0.GradientL:setAlpha(0)
end
CoD.CODCasterTeamBaseGradient.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	CODCaster = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.GradientL:completeAnimation()
			f7_arg0.GradientL:setAlpha(0.8)
			f7_arg0.clipFinished(f7_arg0.GradientL)
		end,
	},
}
CoD.CODCasterTeamBaseGradient.__onClose = function(f8_arg0)
	f8_arg0.GradientL:close()
end
