require("x64:ea0c802d8aee12d")
CoD.LeaguePlayEndrankupAnimInternalRuby = InheritFrom(LUI.UIElement)
CoD.LeaguePlayEndrankupAnimInternalRuby.__defaultWidth = 343
CoD.LeaguePlayEndrankupAnimInternalRuby.__defaultHeight = 204
CoD.LeaguePlayEndrankupAnimInternalRuby.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LeaguePlayEndrankupAnimInternalRuby)
	self.id = "LeaguePlayEndrankupAnimInternalRuby"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Ruby1 = CoD.LeaguePlayEndRankUpRuby.new(f1_arg0, f1_arg1, 0.5, 0.5, -115, -75, 0.5, 0.5, -80, -40)
	Ruby1:setScale(1.5, 1.5)
	self:addElement(Ruby1)
	self.Ruby1 = Ruby1
	local Ruby2 = CoD.LeaguePlayEndRankUpRuby.new(f1_arg0, f1_arg1, 0.5, 0.5, -20, 20, 0.5, 0.5, -80, -40)
	Ruby2:setScale(1.5, 1.5)
	self:addElement(Ruby2)
	self.Ruby2 = Ruby2
	local Ruby3 = CoD.LeaguePlayEndRankUpRuby.new(f1_arg0, f1_arg1, 0.5, 0.5, 75, 115, 0.5, 0.5, -80, -40)
	Ruby3:setScale(1.5, 1.5)
	self:addElement(Ruby3)
	self.Ruby3 = Ruby3
	local Ruby4 = CoD.LeaguePlayEndRankUpRuby.new(f1_arg0, f1_arg1, 0.5, 0.5, -67.5, -27.5, 0.5, 0.5, -20, 20)
	Ruby4:setScale(1.5, 1.5)
	self:addElement(Ruby4)
	self.Ruby4 = Ruby4
	local Ruby5 = CoD.LeaguePlayEndRankUpRuby.new(f1_arg0, f1_arg1, 0.5, 0.5, 28, 68, 0.5, 0.5, -20, 20)
	Ruby5:setScale(1.5, 1.5)
	self:addElement(Ruby5)
	self.Ruby5 = Ruby5
	local Ruby6 = CoD.LeaguePlayEndRankUpRuby.new(f1_arg0, f1_arg1, 0.5, 0.5, 100, 140, 0.5, 0.5, -20, 20)
	Ruby6:setAlpha(0)
	Ruby6:setScale(1.5, 1.5)
	self:addElement(Ruby6)
	self.Ruby6 = Ruby6
	self:mergeStateConditions({
		{
			stateName = "FourRubies",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesCurrentRankRequireXPoints(self, f1_arg1, 4)
			end,
		},
		{
			stateName = "FiveRubies",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesCurrentRankRequireXPoints(self, f1_arg1, 5)
			end,
		},
	})
	self:linkToElementModel(self, "leaguePlayRank", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "leaguePlayRank",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LeaguePlayEndrankupAnimInternalRuby.__resetProperties = function(f5_arg0)
	f5_arg0.Ruby4:completeAnimation()
	f5_arg0.Ruby5:completeAnimation()
	f5_arg0.Ruby4:setAlpha(1)
	f5_arg0.Ruby5:setAlpha(1)
end
CoD.LeaguePlayEndrankupAnimInternalRuby.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.Ruby4:completeAnimation()
			f6_arg0.Ruby4:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Ruby4)
			f6_arg0.Ruby5:completeAnimation()
			f6_arg0.Ruby5:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Ruby5)
		end,
	},
	FourRubies = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.Ruby4:completeAnimation()
			f7_arg0.Ruby4:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.Ruby4)
			f7_arg0.Ruby5:completeAnimation()
			f7_arg0.Ruby5:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Ruby5)
		end,
	},
	FiveRubies = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.Ruby4:completeAnimation()
			f8_arg0.Ruby4:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.Ruby4)
			f8_arg0.Ruby5:completeAnimation()
			f8_arg0.Ruby5:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.Ruby5)
		end,
	},
}
CoD.LeaguePlayEndrankupAnimInternalRuby.__onClose = function(f9_arg0)
	f9_arg0.Ruby1:close()
	f9_arg0.Ruby2:close()
	f9_arg0.Ruby3:close()
	f9_arg0.Ruby4:close()
	f9_arg0.Ruby5:close()
	f9_arg0.Ruby6:close()
end
