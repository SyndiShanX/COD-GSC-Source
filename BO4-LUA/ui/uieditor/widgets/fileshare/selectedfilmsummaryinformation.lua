require("x64:b249d12769c49e6")
require("x64:f55b4a9149c74df")
CoD.SelectedFilmSummaryInformation = InheritFrom(LUI.UIElement)
CoD.SelectedFilmSummaryInformation.__defaultWidth = 515
CoD.SelectedFilmSummaryInformation.__defaultHeight = 105
CoD.SelectedFilmSummaryInformation.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SelectedFilmSummaryInformation)
	self.id = "SelectedFilmSummaryInformation"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SelectedFilmSummaryGameResult = CoD.SelectedFilmSummaryGameResult.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 36)
	SelectedFilmSummaryGameResult:linkToElementModel(self, nil, false, function(model)
		SelectedFilmSummaryGameResult:setModel(model, f1_arg1)
	end)
	self:addElement(SelectedFilmSummaryGameResult)
	self.SelectedFilmSummaryGameResult = SelectedFilmSummaryGameResult
	local ScoreColumn1 = CoD.SelectedFilmSummaryScoreColumn.new(f1_arg0, f1_arg1, 0, 0, 384, 515, 0, 0, 39.5, 104.5)
	ScoreColumn1:linkToElementModel(self, "column1Header", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ScoreColumn1.HeaderText:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	ScoreColumn1:linkToElementModel(self, "column1Value", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ScoreColumn1.ValueText:setText(f4_local0)
		end
	end)
	self:addElement(ScoreColumn1)
	self.ScoreColumn1 = ScoreColumn1
	local ScoreColumn2 = CoD.SelectedFilmSummaryScoreColumn.new(f1_arg0, f1_arg1, 0, 0, 192, 323, 0, 0, 39.5, 104.5)
	ScoreColumn2:linkToElementModel(self, "column2Header", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			ScoreColumn2.HeaderText:setText(Engine[@"hash_4F9F1239CFD921FE"](f5_local0))
		end
	end)
	ScoreColumn2:linkToElementModel(self, "column2Value", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			ScoreColumn2.ValueText:setText(f6_local0)
		end
	end)
	self:addElement(ScoreColumn2)
	self.ScoreColumn2 = ScoreColumn2
	local ScoreColumn3 = CoD.SelectedFilmSummaryScoreColumn.new(f1_arg0, f1_arg1, 0, 0, 0, 131, 0, 0, 39.5, 104.5)
	ScoreColumn3:linkToElementModel(self, "column3Header", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			ScoreColumn3.HeaderText:setText(Engine[@"hash_4F9F1239CFD921FE"](f7_local0))
		end
	end)
	ScoreColumn3:linkToElementModel(self, "column3Value", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			ScoreColumn3.ValueText:setText(f8_local0)
		end
	end)
	self:addElement(ScoreColumn3)
	self.ScoreColumn3 = ScoreColumn3
	local ScoreColumn4 = CoD.SelectedFilmSummaryScoreColumn.new(f1_arg0, f1_arg1, 0, 0, 525, 656, 0, 0, 37, 102)
	ScoreColumn4:setAlpha(0)
	ScoreColumn4:linkToElementModel(self, "column4Header", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			ScoreColumn4.HeaderText:setText(Engine[@"hash_4F9F1239CFD921FE"](f9_local0))
		end
	end)
	ScoreColumn4:linkToElementModel(self, "column4Value", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			ScoreColumn4.ValueText:setText(f10_local0)
		end
	end)
	self:addElement(ScoreColumn4)
	self.ScoreColumn4 = ScoreColumn4
	local Divider1 = LUI.UIImage.new(0, 0, 161, 162, 1, 1, -65, 0)
	Divider1:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Divider1:setAlpha(0.15)
	self:addElement(Divider1)
	self.Divider1 = Divider1
	local Divider2 = LUI.UIImage.new(0, 0, 360, 361, 1, 1, -65, 0)
	Divider2:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Divider2:setAlpha(0.15)
	self:addElement(Divider2)
	self.Divider2 = Divider2
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
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SelectedFilmSummaryInformation.__resetProperties = function(f13_arg0)
	f13_arg0.SelectedFilmSummaryGameResult:completeAnimation()
	f13_arg0.Divider2:completeAnimation()
	f13_arg0.Divider1:completeAnimation()
	f13_arg0.ScoreColumn4:completeAnimation()
	f13_arg0.ScoreColumn3:completeAnimation()
	f13_arg0.ScoreColumn2:completeAnimation()
	f13_arg0.ScoreColumn1:completeAnimation()
	f13_arg0.SelectedFilmSummaryGameResult:setAlpha(1)
	f13_arg0.Divider2:setAlpha(0.15)
	f13_arg0.Divider1:setAlpha(0.15)
	f13_arg0.ScoreColumn4:setAlpha(0)
	f13_arg0.ScoreColumn3:setAlpha(1)
	f13_arg0.ScoreColumn2:setAlpha(1)
	f13_arg0.ScoreColumn1:setAlpha(1)
end
CoD.SelectedFilmSummaryInformation.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(7)
			f14_arg0.SelectedFilmSummaryGameResult:completeAnimation()
			f14_arg0.SelectedFilmSummaryGameResult:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.SelectedFilmSummaryGameResult)
			f14_arg0.ScoreColumn1:completeAnimation()
			f14_arg0.ScoreColumn1:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.ScoreColumn1)
			f14_arg0.ScoreColumn2:completeAnimation()
			f14_arg0.ScoreColumn2:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.ScoreColumn2)
			f14_arg0.ScoreColumn3:completeAnimation()
			f14_arg0.ScoreColumn3:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.ScoreColumn3)
			f14_arg0.ScoreColumn4:completeAnimation()
			f14_arg0.ScoreColumn4:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.ScoreColumn4)
			f14_arg0.Divider1:completeAnimation()
			f14_arg0.Divider1:setAlpha(0.15)
			f14_arg0.clipFinished(f14_arg0.Divider1)
			f14_arg0.Divider2:completeAnimation()
			f14_arg0.Divider2:setAlpha(0.15)
			f14_arg0.clipFinished(f14_arg0.Divider2)
		end,
	},
	Hidden = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(7)
			f15_arg0.SelectedFilmSummaryGameResult:completeAnimation()
			f15_arg0.SelectedFilmSummaryGameResult:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.SelectedFilmSummaryGameResult)
			f15_arg0.ScoreColumn1:completeAnimation()
			f15_arg0.ScoreColumn1:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.ScoreColumn1)
			f15_arg0.ScoreColumn2:completeAnimation()
			f15_arg0.ScoreColumn2:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.ScoreColumn2)
			f15_arg0.ScoreColumn3:completeAnimation()
			f15_arg0.ScoreColumn3:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.ScoreColumn3)
			f15_arg0.ScoreColumn4:completeAnimation()
			f15_arg0.ScoreColumn4:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.ScoreColumn4)
			f15_arg0.Divider1:completeAnimation()
			f15_arg0.Divider1:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Divider1)
			f15_arg0.Divider2:completeAnimation()
			f15_arg0.Divider2:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Divider2)
		end,
	},
}
CoD.SelectedFilmSummaryInformation.__onClose = function(f16_arg0)
	f16_arg0.SelectedFilmSummaryGameResult:close()
	f16_arg0.ScoreColumn1:close()
	f16_arg0.ScoreColumn2:close()
	f16_arg0.ScoreColumn3:close()
	f16_arg0.ScoreColumn4:close()
end
