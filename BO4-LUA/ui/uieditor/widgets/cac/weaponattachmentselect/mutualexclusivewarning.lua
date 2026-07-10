CoD.MutualExclusiveWarning = InheritFrom(LUI.UIElement)
CoD.MutualExclusiveWarning.__defaultWidth = 375
CoD.MutualExclusiveWarning.__defaultHeight = 37
CoD.MutualExclusiveWarning.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 11, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.MutualExclusiveWarning)
	self.id = "MutualExclusiveWarning"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Icon = LUI.UIImage.new(0, 0, 0, 18, 0.5, 0.5, -9, 9)
	Icon:setRGB(1, 0.41, 0)
	Icon:setImage(RegisterImage(@"hash_111D4E13C821CCE3"))
	self:addElement(Icon)
	self.Icon = Icon
	local WarningText = LUI.UIText.new(0, 0, 29, 229, 0.5, 0.5, -10.5, 10.5)
	WarningText:setRGB(1, 0.41, 0)
	WarningText:setTTF("ttmussels_demibold")
	WarningText:setLetterSpacing(3)
	WarningText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	WarningText:linkToElementModel(self, "cautionText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			WarningText:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(WarningText)
	self.WarningText = WarningText
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "cautionText")
			end,
		},
	})
	self:linkToElementModel(self, "cautionText", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "cautionText",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MutualExclusiveWarning.__resetProperties = function(f5_arg0)
	f5_arg0.Icon:completeAnimation()
	f5_arg0.WarningText:completeAnimation()
	f5_arg0.Icon:setAlpha(1)
	f5_arg0.WarningText:setAlpha(1)
end
CoD.MutualExclusiveWarning.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.Icon:completeAnimation()
			f6_arg0.Icon:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Icon)
			f6_arg0.WarningText:completeAnimation()
			f6_arg0.WarningText:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.WarningText)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.MutualExclusiveWarning.__onClose = function(f8_arg0)
	f8_arg0.WarningText:close()
end
