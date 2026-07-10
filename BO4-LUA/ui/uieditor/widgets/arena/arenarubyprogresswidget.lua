require("x64:760aff07f0f7242")
require("x64:d6a3fb5a763b9aa")
require("x64:9d7b2edcc3435f2")
CoD.ArenaRubyProgressWidget = InheritFrom(LUI.UIElement)
CoD.ArenaRubyProgressWidget.__defaultWidth = 926
CoD.ArenaRubyProgressWidget.__defaultHeight = 40
CoD.ArenaRubyProgressWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaRubyProgressWidget)
	self.id = "ArenaRubyProgressWidget"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ArenaRubyProgressThreeWidget = CoD.ArenaRubyProgressThreeWidget.new(f1_arg0, f1_arg1, 0, 0, 0, 926, 0, 0, 0, 40)
	ArenaRubyProgressThreeWidget:mergeStateConditions({
		{
			stateName = "OneRuby",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyCountEqualValue(f1_arg1, 1)
			end,
		},
		{
			stateName = "TwoRubies",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyCountEqualValue(f1_arg1, 2)
			end,
		},
		{
			stateName = "ThreeRubies",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyCountEqualValue(f1_arg1, 3)
			end,
		},
	})
	self:addElement(ArenaRubyProgressThreeWidget)
	self.ArenaRubyProgressThreeWidget = ArenaRubyProgressThreeWidget
	local ArenaRubyProgressFourWidget = CoD.ArenaRubyProgressFourWidget.new(f1_arg0, f1_arg1, 0, 0, 0, 926, 0, 0, 0, 40)
	ArenaRubyProgressFourWidget:mergeStateConditions({
		{
			stateName = "OneRuby",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyCountEqualValue(f1_arg1, 1)
			end,
		},
		{
			stateName = "TwoRubies",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyCountEqualValue(f1_arg1, 2)
			end,
		},
		{
			stateName = "ThreeRubies",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyCountEqualValue(f1_arg1, 3)
			end,
		},
		{
			stateName = "FourRubies",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyCountEqualValue(f1_arg1, 4)
			end,
		},
	})
	self:addElement(ArenaRubyProgressFourWidget)
	self.ArenaRubyProgressFourWidget = ArenaRubyProgressFourWidget
	local ArenaRubyProgressFiveWidget = CoD.ArenaRubyProgressFiveWidget.new(f1_arg0, f1_arg1, 0, 0, 0, 926, 0, 0, 0, 40)
	ArenaRubyProgressFiveWidget:mergeStateConditions({
		{
			stateName = "OneRuby",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyCountEqualValue(f1_arg1, 1)
			end,
		},
		{
			stateName = "TwoRubies",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyCountEqualValue(f1_arg1, 2)
			end,
		},
		{
			stateName = "ThreeRubies",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyCountEqualValue(f1_arg1, 3)
			end,
		},
		{
			stateName = "FourRubies",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyCountEqualValue(f1_arg1, 4)
			end,
		},
	})
	self:addElement(ArenaRubyProgressFiveWidget)
	self.ArenaRubyProgressFiveWidget = ArenaRubyProgressFiveWidget
	self:mergeStateConditions({
		{
			stateName = "FourRubies",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyRequirementEqualValue(f1_arg1, 4)
			end,
		},
		{
			stateName = "FiveRubies",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyRequirementEqualValue(f1_arg1, 5)
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local5(f1_local4, f1_local6["lobbyRoot.lobbyNav"], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaRubyProgressWidget.__resetProperties = function(f16_arg0)
	f16_arg0.ArenaRubyProgressFiveWidget:completeAnimation()
	f16_arg0.ArenaRubyProgressFourWidget:completeAnimation()
	f16_arg0.ArenaRubyProgressThreeWidget:completeAnimation()
	f16_arg0.ArenaRubyProgressFiveWidget:setAlpha(1)
	f16_arg0.ArenaRubyProgressFourWidget:setAlpha(1)
	f16_arg0.ArenaRubyProgressThreeWidget:setAlpha(1)
end
CoD.ArenaRubyProgressWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			f17_arg0.ArenaRubyProgressFourWidget:completeAnimation()
			f17_arg0.ArenaRubyProgressFourWidget:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.ArenaRubyProgressFourWidget)
			f17_arg0.ArenaRubyProgressFiveWidget:completeAnimation()
			f17_arg0.ArenaRubyProgressFiveWidget:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.ArenaRubyProgressFiveWidget)
		end,
	},
	FourRubies = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.ArenaRubyProgressThreeWidget:completeAnimation()
			f18_arg0.ArenaRubyProgressThreeWidget:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.ArenaRubyProgressThreeWidget)
			f18_arg0.ArenaRubyProgressFiveWidget:completeAnimation()
			f18_arg0.ArenaRubyProgressFiveWidget:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.ArenaRubyProgressFiveWidget)
		end,
	},
	FiveRubies = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			f19_arg0.ArenaRubyProgressThreeWidget:completeAnimation()
			f19_arg0.ArenaRubyProgressThreeWidget:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.ArenaRubyProgressThreeWidget)
			f19_arg0.ArenaRubyProgressFourWidget:completeAnimation()
			f19_arg0.ArenaRubyProgressFourWidget:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.ArenaRubyProgressFourWidget)
		end,
	},
}
CoD.ArenaRubyProgressWidget.__onClose = function(f20_arg0)
	f20_arg0.ArenaRubyProgressThreeWidget:close()
	f20_arg0.ArenaRubyProgressFourWidget:close()
	f20_arg0.ArenaRubyProgressFiveWidget:close()
end
