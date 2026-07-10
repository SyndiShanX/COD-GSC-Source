require("x64:d2ef4b4071bcd0a")
CoD.ArenaLeaguePlayRubiesDynamic = InheritFrom(LUI.UIElement)
CoD.ArenaLeaguePlayRubiesDynamic.__defaultWidth = 140
CoD.ArenaLeaguePlayRubiesDynamic.__defaultHeight = 40
CoD.ArenaLeaguePlayRubiesDynamic.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaLeaguePlayRubiesDynamic)
	self.id = "ArenaLeaguePlayRubiesDynamic"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Rubies = CoD.arenaLeaguePlayRubies.new(f1_arg0, f1_arg1, 0.5, 0.5, -70, 70, 0.5, 0.5, -20, 20)
	Rubies:mergeStateConditions({
		{
			stateName = "OneRuby",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "LeaguePlay", "leaguePlayRubiesCount", 1)
			end,
		},
		{
			stateName = "TwoRubies",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "LeaguePlay", "leaguePlayRubiesCount", 2)
			end,
		},
		{
			stateName = "ThreeRubies",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "LeaguePlay", "leaguePlayRubiesCount", 3)
			end,
		},
	})
	local f1_local2 = Rubies
	local f1_local3 = Rubies.subscribeToModel
	local f1_local4 = DataSources.LeaguePlay.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.leaguePlayRubiesCount, function(f5_arg0)
		f1_arg0:updateElementState(Rubies, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "leaguePlayRubiesCount",
		})
	end, false)
	self:addElement(Rubies)
	self.Rubies = Rubies
	self:mergeStateConditions({
		{
			stateName = "lobby",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaLeaguePlayRubiesDynamic.__resetProperties = function(f7_arg0)
	f7_arg0.Rubies:completeAnimation()
	f7_arg0.Rubies:setTopBottom(0.5, 0.5, -20, 20)
end
CoD.ArenaLeaguePlayRubiesDynamic.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	lobby = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.Rubies:completeAnimation()
			f9_arg0.Rubies:setTopBottom(0.5, 0.5, -399, -359)
			f9_arg0.clipFinished(f9_arg0.Rubies)
		end,
	},
}
CoD.ArenaLeaguePlayRubiesDynamic.__onClose = function(f10_arg0)
	f10_arg0.Rubies:close()
end
