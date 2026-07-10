require("x64:9c229ee624f5b47")
CoD.AARLevelOverlay_LevelUpDisplay = InheritFrom(LUI.UIElement)
CoD.AARLevelOverlay_LevelUpDisplay.__defaultWidth = 537
CoD.AARLevelOverlay_LevelUpDisplay.__defaultHeight = 53
CoD.AARLevelOverlay_LevelUpDisplay.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARLevelOverlay_LevelUpDisplay)
	self.id = "AARLevelOverlay_LevelUpDisplay"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local LevelUpText = CoD.AARLevelUpOverlay_LevelUpTextInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -268.5, 131.5, 0.5, 0.5, -26.5, 33.5)
	LevelUpText:mergeStateConditions({
		{
			stateName = "CurrentRank",
			condition = function(menu, element, event)
				return CoD.AARUtility.IsCurrentRankStartingRank(self, f1_arg1)
			end,
		},
	})
	LevelUpText:linkToElementModel(LevelUpText, "rank", true, function(model)
		f1_arg0:updateElementState(LevelUpText, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rank",
		})
	end)
	LevelUpText:linkToElementModel(self, nil, false, function(model)
		LevelUpText:setModel(model, f1_arg1)
	end)
	self:addElement(LevelUpText)
	self.LevelUpText = LevelUpText
	local Flash = LUI.UIImage.new(0, 0, -162, -34, 0, 0, -18.5, 109.5)
	self:addElement(Flash)
	self.Flash = Flash
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARLevelOverlay_LevelUpDisplay.__onClose = function(f5_arg0)
	f5_arg0.LevelUpText:close()
end
