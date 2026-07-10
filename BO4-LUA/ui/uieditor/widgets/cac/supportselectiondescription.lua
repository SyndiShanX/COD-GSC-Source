CoD.SupportSelectionDescription = InheritFrom(LUI.UIElement)
CoD.SupportSelectionDescription.__defaultWidth = 519
CoD.SupportSelectionDescription.__defaultHeight = 18
CoD.SupportSelectionDescription.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 6, false)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.SupportSelectionDescription)
	self.id = "SupportSelectionDescription"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SelectedDescription = LUI.UIText.new(0, 0, 0, 614, 0, 0, 0, 18)
	SelectedDescription:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	SelectedDescription:setZoom(90)
	SelectedDescription:setTTF("ttmussels_regular")
	SelectedDescription:setLetterSpacing(2)
	SelectedDescription:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	SelectedDescription:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	SelectedDescription:linkToElementModel(self, "desc", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			SelectedDescription:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(SelectedDescription)
	self.SelectedDescription = SelectedDescription
	local UnlockRequirements = LUI.UIText.new(0, 1, -1, -1, 0, 0, 24, 42)
	UnlockRequirements:setRGB(0.39, 0.39, 0.39)
	UnlockRequirements:setZoom(90)
	UnlockRequirements:setTTF("dinnext_regular")
	UnlockRequirements:setLetterSpacing(3)
	UnlockRequirements:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	UnlockRequirements:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	UnlockRequirements:linkToElementModel(self, "itemIndex", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			UnlockRequirements:setText(CoD.CACUtility.GetUnlockDescription(f1_arg0, f1_arg1, f3_local0))
		end
	end)
	self:addElement(UnlockRequirements)
	self.UnlockRequirements = UnlockRequirements
	self:mergeStateConditions({
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.ScorestreakSelectUtility.IsScorestreakLocked(element, menu, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "itemIndex", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SupportSelectionDescription.__resetProperties = function(f6_arg0)
	f6_arg0.UnlockRequirements:completeAnimation()
	f6_arg0.UnlockRequirements:setAlpha(1)
end
CoD.SupportSelectionDescription.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.UnlockRequirements:completeAnimation()
			f7_arg0.UnlockRequirements:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.UnlockRequirements)
		end,
	},
	Locked = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.SupportSelectionDescription.__onClose = function(f9_arg0)
	f9_arg0.SelectedDescription:close()
	f9_arg0.UnlockRequirements:close()
end
