CoD.LeaguePlayEndRankPosition = InheritFrom(LUI.UIElement)
CoD.LeaguePlayEndRankPosition.__defaultWidth = 604
CoD.LeaguePlayEndRankPosition.__defaultHeight = 209
CoD.LeaguePlayEndRankPosition.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LeaguePlayEndRankPosition)
	self.id = "LeaguePlayEndRankPosition"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Position = LUI.UIText.new(0.5, 0.5, -150, 150, 0.5, 0.5, -45.5, 104.5)
	Position:setTTF("0arame_mono_stencil")
	Position:setLetterSpacing(2)
	Position:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Position:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Position:subscribeToGlobalModel(f1_arg1, "LeaguePlay", "lastLadderRank", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Position:setText(LocalizeStringWithParameter(@"hash_6E8DFC210924D670", f2_local0))
		end
	end)
	self:addElement(Position)
	self.Position = Position
	local YouPlacedText = LUI.UIText.new(0.5, 0.5, -302, 302, 0, 0, 37, 62)
	YouPlacedText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_53D5F1A3853D382D"))
	YouPlacedText:setTTF("ttmussels_regular")
	YouPlacedText:setLetterSpacing(4)
	YouPlacedText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	YouPlacedText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(YouPlacedText)
	self.YouPlacedText = YouPlacedText
	local PlacementResult = LUI.UIText.new(0.5, 0.5, -302, 302, 0, 0, 0, 33)
	PlacementResult:setTTF("ttmussels_demibold")
	PlacementResult:setLetterSpacing(4)
	PlacementResult:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	PlacementResult:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	PlacementResult:subscribeToGlobalModel(f1_arg1, "LeaguePlay", "lastLadderRank", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			PlacementResult:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.ArenaUtility.GetLadderPositionResult(f3_local0)))
		end
	end)
	self:addElement(PlacementResult)
	self.PlacementResult = PlacementResult
	self:mergeStateConditions({
		{
			stateName = "FirstPlace",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "LeaguePlay", "lastLadderRank", LuaUtils.GetPositionForLeaguePlacementTier(1))
			end,
		},
		{
			stateName = "Top50",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "LeaguePlay", "lastLadderRank", LuaUtils.GetPositionForLeaguePlacementTier(3))
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = DataSources.LeaguePlay.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6.lastLadderRank, function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lastLadderRank",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LeaguePlayEndRankPosition.__resetProperties = function(f7_arg0)
	f7_arg0.YouPlacedText:completeAnimation()
	f7_arg0.PlacementResult:completeAnimation()
	f7_arg0.YouPlacedText:setAlpha(1)
	f7_arg0.PlacementResult:setTopBottom(0, 0, 0, 33)
	f7_arg0.PlacementResult:setAlpha(1)
end
CoD.LeaguePlayEndRankPosition.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	FirstPlace = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.YouPlacedText:completeAnimation()
			f9_arg0.YouPlacedText:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.YouPlacedText)
			f9_arg0.PlacementResult:completeAnimation()
			f9_arg0.PlacementResult:setTopBottom(0, 0, 40, 73)
			f9_arg0.clipFinished(f9_arg0.PlacementResult)
		end,
	},
	Top50 = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.PlacementResult:completeAnimation()
			f10_arg0.PlacementResult:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.PlacementResult)
		end,
	},
}
CoD.LeaguePlayEndRankPosition.__onClose = function(f11_arg0)
	f11_arg0.Position:close()
	f11_arg0.PlacementResult:close()
end
