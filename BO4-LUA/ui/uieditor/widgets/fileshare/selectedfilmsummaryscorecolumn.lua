CoD.SelectedFilmSummaryScoreColumn = InheritFrom(LUI.UIElement)
CoD.SelectedFilmSummaryScoreColumn.__defaultWidth = 131
CoD.SelectedFilmSummaryScoreColumn.__defaultHeight = 65
CoD.SelectedFilmSummaryScoreColumn.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SelectedFilmSummaryScoreColumn)
	self.id = "SelectedFilmSummaryScoreColumn"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local HeaderText = LUI.UIText.new(0, 1, 0, 0, 0, 0, 0, 26)
	HeaderText:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	HeaderText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	HeaderText:setTTF("ttmussels_regular")
	HeaderText:setLetterSpacing(1)
	HeaderText:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	HeaderText:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(HeaderText)
	self.HeaderText = HeaderText
	local ValueText = LUI.UIText.new(0.5, 0.5, -99.5, 99.5, 1, 1, -34, -1)
	ValueText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	ValueText:setTTF("dinnext_regular")
	ValueText:setLetterSpacing(1)
	ValueText:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	self:addElement(ValueText)
	self.ValueText = ValueText
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isValid")
			end,
		},
	})
	self:linkToElementModel(self, "isValid", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isValid",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
