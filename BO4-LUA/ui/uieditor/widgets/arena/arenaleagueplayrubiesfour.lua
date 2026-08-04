require("ui/uieditor/widgets/arena/leagueplayruby")
CoD.arenaLeaguePlayRubiesFour = InheritFrom(LUI.UIElement)
CoD.arenaLeaguePlayRubiesFour.__defaultWidth = 140
CoD.arenaLeaguePlayRubiesFour.__defaultHeight = 74
CoD.arenaLeaguePlayRubiesFour.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.arenaLeaguePlayRubiesFour)
	self.id = "arenaLeaguePlayRubiesFour"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Ruby1 = CoD.LeaguePlayRuby.new(f1_arg0, f1_arg1, 0.5, 0.5, -57, -17, 0.5, 0.5, -35, 5)
	Ruby1.Ruby:setAlpha(0)
	Ruby1.RubyAnim:setAlpha(0)
	self:addElement(Ruby1)
	self.Ruby1 = Ruby1
	local Ruby3 = CoD.LeaguePlayRuby.new(f1_arg0, f1_arg1, 0.5, 0.5, -57, -17, 0.5, 0.5, 0, 40)
	Ruby3.Ruby:setAlpha(0)
	Ruby3.RubyAnim:setAlpha(0)
	self:addElement(Ruby3)
	self.Ruby3 = Ruby3
	local Ruby2 = CoD.LeaguePlayRuby.new(f1_arg0, f1_arg1, 0.5, 0.5, 17, 57, 0.5, 0.5, -35, 5)
	Ruby2.Ruby:setAlpha(0)
	Ruby2.RubyAnim:setAlpha(0)
	self:addElement(Ruby2)
	self.Ruby2 = Ruby2
	local Ruby4 = CoD.LeaguePlayRuby.new(f1_arg0, f1_arg1, 0.5, 0.5, 17, 57, 0.5, 0.5, 0, 40)
	Ruby4.Ruby:setAlpha(0)
	Ruby4.RubyAnim:setAlpha(0)
	self:addElement(Ruby4)
	self.Ruby4 = Ruby4
	self:mergeStateConditions({
		{
			stateName = "oneruby",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyCountEqualValue(f1_arg1, 1)
			end,
		},
		{
			stateName = "tworubies",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyCountEqualValue(f1_arg1, 2)
			end,
		},
		{
			stateName = "treerubies",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyCountEqualValue(f1_arg1, 3)
			end,
		},
		{
			stateName = "fourrubies",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyCountEqualValue(f1_arg1, 4)
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.arenaLeaguePlayRubiesFour.__resetProperties = function(f6_arg0)
	f6_arg0.Ruby1:completeAnimation()
	f6_arg0.Ruby2:completeAnimation()
	f6_arg0.Ruby3:completeAnimation()
	f6_arg0.Ruby4:completeAnimation()
	f6_arg0.Ruby1.Ruby:setAlpha(0)
	f6_arg0.Ruby1.RubyAnim:setAlpha(0)
	f6_arg0.Ruby2.Ruby:setAlpha(0)
	f6_arg0.Ruby2.RubyAnim:setAlpha(0)
	f6_arg0.Ruby3.Ruby:setAlpha(0)
	f6_arg0.Ruby3.RubyAnim:setAlpha(0)
	f6_arg0.Ruby4.Ruby:setAlpha(0)
	f6_arg0.Ruby4.RubyAnim:setAlpha(0)
end
CoD.arenaLeaguePlayRubiesFour.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	oneruby = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.Ruby1:completeAnimation()
			f8_arg0.Ruby1.Ruby:completeAnimation()
			f8_arg0.Ruby1.RubyAnim:completeAnimation()
			f8_arg0.Ruby1.Ruby:setAlpha(0.2)
			f8_arg0.Ruby1.RubyAnim:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.Ruby1)
		end,
	},
	tworubies = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.Ruby1:completeAnimation()
			f9_arg0.Ruby1.Ruby:completeAnimation()
			f9_arg0.Ruby1.RubyAnim:completeAnimation()
			f9_arg0.Ruby1.Ruby:setAlpha(0.2)
			f9_arg0.Ruby1.RubyAnim:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.Ruby1)
			f9_arg0.Ruby2:completeAnimation()
			f9_arg0.Ruby2.Ruby:completeAnimation()
			f9_arg0.Ruby2.RubyAnim:completeAnimation()
			f9_arg0.Ruby2.Ruby:setAlpha(0.2)
			f9_arg0.Ruby2.RubyAnim:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.Ruby2)
		end,
	},
	treerubies = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			f10_arg0.Ruby1:completeAnimation()
			f10_arg0.Ruby1.Ruby:completeAnimation()
			f10_arg0.Ruby1.RubyAnim:completeAnimation()
			f10_arg0.Ruby1.Ruby:setAlpha(0.2)
			f10_arg0.Ruby1.RubyAnim:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.Ruby1)
			f10_arg0.Ruby3:completeAnimation()
			f10_arg0.Ruby3.Ruby:completeAnimation()
			f10_arg0.Ruby3.RubyAnim:completeAnimation()
			f10_arg0.Ruby3.Ruby:setAlpha(0.2)
			f10_arg0.Ruby3.RubyAnim:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.Ruby3)
			f10_arg0.Ruby2:completeAnimation()
			f10_arg0.Ruby2.Ruby:completeAnimation()
			f10_arg0.Ruby2.RubyAnim:completeAnimation()
			f10_arg0.Ruby2.Ruby:setAlpha(0.2)
			f10_arg0.Ruby2.RubyAnim:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.Ruby2)
		end,
	},
	fourrubies = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(4)
			f11_arg0.Ruby1:completeAnimation()
			f11_arg0.Ruby1.Ruby:completeAnimation()
			f11_arg0.Ruby1.RubyAnim:completeAnimation()
			f11_arg0.Ruby1.Ruby:setAlpha(0.2)
			f11_arg0.Ruby1.RubyAnim:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.Ruby1)
			f11_arg0.Ruby3:completeAnimation()
			f11_arg0.Ruby3.Ruby:completeAnimation()
			f11_arg0.Ruby3.RubyAnim:completeAnimation()
			f11_arg0.Ruby3.Ruby:setAlpha(0.2)
			f11_arg0.Ruby3.RubyAnim:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.Ruby3)
			f11_arg0.Ruby2:completeAnimation()
			f11_arg0.Ruby2.Ruby:completeAnimation()
			f11_arg0.Ruby2.RubyAnim:completeAnimation()
			f11_arg0.Ruby2.Ruby:setAlpha(0.2)
			f11_arg0.Ruby2.RubyAnim:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.Ruby2)
			f11_arg0.Ruby4:completeAnimation()
			f11_arg0.Ruby4.Ruby:completeAnimation()
			f11_arg0.Ruby4.RubyAnim:completeAnimation()
			f11_arg0.Ruby4.Ruby:setAlpha(0.2)
			f11_arg0.Ruby4.RubyAnim:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.Ruby4)
		end,
	},
}
CoD.arenaLeaguePlayRubiesFour.__onClose = function(f12_arg0)
	f12_arg0.Ruby1:close()
	f12_arg0.Ruby3:close()
	f12_arg0.Ruby2:close()
	f12_arg0.Ruby4:close()
end
