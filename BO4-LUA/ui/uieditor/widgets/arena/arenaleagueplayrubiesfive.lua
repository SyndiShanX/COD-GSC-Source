require("ui/uieditor/widgets/arena/leagueplayruby")
CoD.arenaLeaguePlayRubiesFive = InheritFrom(LUI.UIElement)
CoD.arenaLeaguePlayRubiesFive.__defaultWidth = 140
CoD.arenaLeaguePlayRubiesFive.__defaultHeight = 74
CoD.arenaLeaguePlayRubiesFive.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.arenaLeaguePlayRubiesFive)
	self.id = "arenaLeaguePlayRubiesFive"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Ruby2 = CoD.LeaguePlayRuby.new(f1_arg0, f1_arg1, 0.5, 0.5, 17, 57, 0.5, 0.5, -35, 5)
	Ruby2.Ruby:setAlpha(0)
	Ruby2.RubyAnim:setAlpha(0)
	self:addElement(Ruby2)
	self.Ruby2 = Ruby2
	local Ruby3 = CoD.LeaguePlayRuby.new(f1_arg0, f1_arg1, 0.5, 0.5, -57, -17, 0.5, 0.5, 0, 40)
	Ruby3.Ruby:setAlpha(0)
	Ruby3.RubyAnim:setAlpha(0)
	self:addElement(Ruby3)
	self.Ruby3 = Ruby3
	local Ruby5 = CoD.LeaguePlayRuby.new(f1_arg0, f1_arg1, 0.5, 0.5, -20, 20, 0.5, 0.5, -18, 22)
	Ruby5.Ruby:setAlpha(0)
	Ruby5.RubyAnim:setAlpha(0)
	self:addElement(Ruby5)
	self.Ruby5 = Ruby5
	local Ruby4 = CoD.LeaguePlayRuby.new(f1_arg0, f1_arg1, 0.5, 0.5, 17, 57, 0.5, 0.5, 0, 40)
	Ruby4.Ruby:setAlpha(0)
	Ruby4.RubyAnim:setAlpha(0)
	self:addElement(Ruby4)
	self.Ruby4 = Ruby4
	local Ruby1 = CoD.LeaguePlayRuby.new(f1_arg0, f1_arg1, 0.5, 0.5, -57, -17, 0.5, 0.5, -35, 5)
	Ruby1.Ruby:setAlpha(0)
	Ruby1.RubyAnim:setAlpha(0)
	self:addElement(Ruby1)
	self.Ruby1 = Ruby1
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
		{
			stateName = "fiverubies",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyCountEqualValue(f1_arg1, 5)
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.arenaLeaguePlayRubiesFive.__resetProperties = function(f7_arg0)
	f7_arg0.Ruby1:completeAnimation()
	f7_arg0.Ruby2:completeAnimation()
	f7_arg0.Ruby3:completeAnimation()
	f7_arg0.Ruby5:completeAnimation()
	f7_arg0.Ruby4:completeAnimation()
	f7_arg0.Ruby1.Ruby:setAlpha(0)
	f7_arg0.Ruby1.RubyAnim:setAlpha(0)
	f7_arg0.Ruby2.Ruby:setAlpha(0)
	f7_arg0.Ruby2.RubyAnim:setAlpha(0)
	f7_arg0.Ruby3.Ruby:setAlpha(0)
	f7_arg0.Ruby3.RubyAnim:setAlpha(0)
	f7_arg0.Ruby5.Ruby:setAlpha(0)
	f7_arg0.Ruby5.RubyAnim:setAlpha(0)
	f7_arg0.Ruby4.Ruby:setAlpha(0)
	f7_arg0.Ruby4.RubyAnim:setAlpha(0)
end
CoD.arenaLeaguePlayRubiesFive.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	oneruby = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.Ruby1:completeAnimation()
			f9_arg0.Ruby1.Ruby:completeAnimation()
			f9_arg0.Ruby1.RubyAnim:completeAnimation()
			f9_arg0.Ruby1.Ruby:setAlpha(0.2)
			f9_arg0.Ruby1.RubyAnim:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.Ruby1)
		end,
	},
	tworubies = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.Ruby2:completeAnimation()
			f10_arg0.Ruby2.Ruby:completeAnimation()
			f10_arg0.Ruby2.RubyAnim:completeAnimation()
			f10_arg0.Ruby2.Ruby:setAlpha(0.2)
			f10_arg0.Ruby2.RubyAnim:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.Ruby2)
			f10_arg0.Ruby1:completeAnimation()
			f10_arg0.Ruby1.Ruby:completeAnimation()
			f10_arg0.Ruby1.RubyAnim:completeAnimation()
			f10_arg0.Ruby1.Ruby:setAlpha(0.2)
			f10_arg0.Ruby1.RubyAnim:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.Ruby1)
		end,
	},
	treerubies = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(4)
			f11_arg0.Ruby2:completeAnimation()
			f11_arg0.Ruby2.Ruby:completeAnimation()
			f11_arg0.Ruby2.RubyAnim:completeAnimation()
			f11_arg0.Ruby2.Ruby:setAlpha(0.2)
			f11_arg0.Ruby2.RubyAnim:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.Ruby2)
			f11_arg0.Ruby3:completeAnimation()
			f11_arg0.Ruby3.Ruby:completeAnimation()
			f11_arg0.Ruby3.RubyAnim:completeAnimation()
			f11_arg0.Ruby3.Ruby:setAlpha(0)
			f11_arg0.Ruby3.RubyAnim:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Ruby3)
			f11_arg0.Ruby5:completeAnimation()
			f11_arg0.Ruby5.Ruby:completeAnimation()
			f11_arg0.Ruby5.RubyAnim:completeAnimation()
			f11_arg0.Ruby5.Ruby:setAlpha(0.2)
			f11_arg0.Ruby5.RubyAnim:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.Ruby5)
			f11_arg0.Ruby1:completeAnimation()
			f11_arg0.Ruby1.Ruby:completeAnimation()
			f11_arg0.Ruby1.RubyAnim:completeAnimation()
			f11_arg0.Ruby1.Ruby:setAlpha(0.2)
			f11_arg0.Ruby1.RubyAnim:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.Ruby1)
		end,
	},
	fourrubies = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(4)
			f12_arg0.Ruby2:completeAnimation()
			f12_arg0.Ruby2.Ruby:completeAnimation()
			f12_arg0.Ruby2.RubyAnim:completeAnimation()
			f12_arg0.Ruby2.Ruby:setAlpha(0.2)
			f12_arg0.Ruby2.RubyAnim:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.Ruby2)
			f12_arg0.Ruby3:completeAnimation()
			f12_arg0.Ruby3.Ruby:completeAnimation()
			f12_arg0.Ruby3.RubyAnim:completeAnimation()
			f12_arg0.Ruby3.Ruby:setAlpha(0.2)
			f12_arg0.Ruby3.RubyAnim:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.Ruby3)
			f12_arg0.Ruby5:completeAnimation()
			f12_arg0.Ruby5.Ruby:completeAnimation()
			f12_arg0.Ruby5.RubyAnim:completeAnimation()
			f12_arg0.Ruby5.Ruby:setAlpha(0.2)
			f12_arg0.Ruby5.RubyAnim:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.Ruby5)
			f12_arg0.Ruby1:completeAnimation()
			f12_arg0.Ruby1.Ruby:completeAnimation()
			f12_arg0.Ruby1.RubyAnim:completeAnimation()
			f12_arg0.Ruby1.Ruby:setAlpha(0.2)
			f12_arg0.Ruby1.RubyAnim:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.Ruby1)
		end,
	},
	fiverubies = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(5)
			f13_arg0.Ruby2:completeAnimation()
			f13_arg0.Ruby2.Ruby:completeAnimation()
			f13_arg0.Ruby2.RubyAnim:completeAnimation()
			f13_arg0.Ruby2.Ruby:setAlpha(0.2)
			f13_arg0.Ruby2.RubyAnim:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.Ruby2)
			f13_arg0.Ruby3:completeAnimation()
			f13_arg0.Ruby3.Ruby:completeAnimation()
			f13_arg0.Ruby3.RubyAnim:completeAnimation()
			f13_arg0.Ruby3.Ruby:setAlpha(0.2)
			f13_arg0.Ruby3.RubyAnim:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.Ruby3)
			f13_arg0.Ruby5:completeAnimation()
			f13_arg0.Ruby5.Ruby:completeAnimation()
			f13_arg0.Ruby5.RubyAnim:completeAnimation()
			f13_arg0.Ruby5.Ruby:setAlpha(0.2)
			f13_arg0.Ruby5.RubyAnim:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.Ruby5)
			f13_arg0.Ruby4:completeAnimation()
			f13_arg0.Ruby4.Ruby:completeAnimation()
			f13_arg0.Ruby4.RubyAnim:completeAnimation()
			f13_arg0.Ruby4.Ruby:setAlpha(0.2)
			f13_arg0.Ruby4.RubyAnim:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.Ruby4)
			f13_arg0.Ruby1:completeAnimation()
			f13_arg0.Ruby1.Ruby:completeAnimation()
			f13_arg0.Ruby1.RubyAnim:completeAnimation()
			f13_arg0.Ruby1.Ruby:setAlpha(0.2)
			f13_arg0.Ruby1.RubyAnim:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.Ruby1)
		end,
	},
}
CoD.arenaLeaguePlayRubiesFive.__onClose = function(f14_arg0)
	f14_arg0.Ruby2:close()
	f14_arg0.Ruby3:close()
	f14_arg0.Ruby5:close()
	f14_arg0.Ruby4:close()
	f14_arg0.Ruby1:close()
end
