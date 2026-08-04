require("ui/uieditor/widgets/arena/arenaleagueplayrubiesfive")
require("ui/uieditor/widgets/arena/arenaleagueplayrubiesfour")
require("ui/uieditor/widgets/arena/arenaleagueplayrubiesthree")
CoD.ArenaProgressionRubies = InheritFrom(LUI.UIElement)
CoD.ArenaProgressionRubies.__defaultWidth = 140
CoD.ArenaProgressionRubies.__defaultHeight = 74
CoD.ArenaProgressionRubies.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaProgressionRubies)
	self.id = "ArenaProgressionRubies"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local threeRubyLayout = CoD.arenaLeaguePlayRubiesThree.new(f1_arg0, f1_arg1, 0, 0, 0, 140, 0, 0, 0, 74)
	threeRubyLayout:mergeStateConditions({
		{
			stateName = "oneruby",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyCountForModelEqualValue(self, f1_arg1, "rubiesUnlocked", 1)
			end,
		},
		{
			stateName = "tworubies",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyCountForModelEqualValue(self, f1_arg1, "rubiesUnlocked", 2)
			end,
		},
		{
			stateName = "treerubies",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyCountForModelEqualValue(self, f1_arg1, "rubiesUnlocked", 3)
			end,
		},
	})
	threeRubyLayout:linkToElementModel(self, nil, false, function(model)
		threeRubyLayout:setModel(model, f1_arg1)
	end)
	self:addElement(threeRubyLayout)
	self.threeRubyLayout = threeRubyLayout
	local fourRubyLayout = CoD.arenaLeaguePlayRubiesFour.new(f1_arg0, f1_arg1, 0, 0, 0, 140, 0, 0, 0, 74)
	fourRubyLayout:mergeStateConditions({
		{
			stateName = "oneruby",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyCountForModelEqualValue(self, f1_arg1, "rubiesUnlocked", 1)
			end,
		},
		{
			stateName = "tworubies",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyCountForModelEqualValue(self, f1_arg1, "rubiesUnlocked", 2)
			end,
		},
		{
			stateName = "treerubies",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyCountForModelEqualValue(self, f1_arg1, "rubiesUnlocked", 3)
			end,
		},
		{
			stateName = "fourrubies",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyCountForModelEqualValue(self, f1_arg1, "rubiesUnlocked", 4)
			end,
		},
	})
	fourRubyLayout:linkToElementModel(self, nil, false, function(model)
		fourRubyLayout:setModel(model, f1_arg1)
	end)
	self:addElement(fourRubyLayout)
	self.fourRubyLayout = fourRubyLayout
	local fiveRubyLayout = CoD.arenaLeaguePlayRubiesFive.new(f1_arg0, f1_arg1, 0, 0, 0, 140, 0, 0, 0, 74)
	fiveRubyLayout:mergeStateConditions({
		{
			stateName = "oneruby",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyCountForModelEqualValue(self, f1_arg1, "rubiesUnlocked", 1)
			end,
		},
		{
			stateName = "tworubies",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyCountForModelEqualValue(self, f1_arg1, "rubiesUnlocked", 2)
			end,
		},
		{
			stateName = "treerubies",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyCountForModelEqualValue(self, f1_arg1, "rubiesUnlocked", 3)
			end,
		},
		{
			stateName = "fourrubies",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyCountForModelEqualValue(self, f1_arg1, "rubiesUnlocked", 4)
			end,
		},
		{
			stateName = "fiverubies",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyCountForModelEqualValue(self, f1_arg1, "rubiesUnlocked", 5)
			end,
		},
	})
	fiveRubyLayout:linkToElementModel(self, nil, false, function(model)
		fiveRubyLayout:setModel(model, f1_arg1)
	end)
	self:addElement(fiveRubyLayout)
	self.fiveRubyLayout = fiveRubyLayout
	self:linkToElementModel(self, "rubiesUnlocked", true, function(model)
		local f17_local0 = self
		UpdateElementState(self, "fiveRubyLayout", f1_arg1)
		UpdateElementState(self, "fourRubyLayout", f1_arg1)
		UpdateElementState(self, "threeRubyLayout", f1_arg1)
	end)
	self:linkToElementModel(self, "leagueRank", true, function(model)
		local f18_local0 = self
		UpdateSelfElementState(f1_arg0, self, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaProgressionRubies.__resetProperties = function(f19_arg0)
	f19_arg0.fourRubyLayout:completeAnimation()
	f19_arg0.fiveRubyLayout:completeAnimation()
	f19_arg0.threeRubyLayout:completeAnimation()
	f19_arg0.fourRubyLayout:setAlpha(1)
	f19_arg0.fiveRubyLayout:setAlpha(1)
	f19_arg0.threeRubyLayout:setAlpha(1)
end
CoD.ArenaProgressionRubies.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.fourRubyLayout:completeAnimation()
			f20_arg0.fourRubyLayout:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.fourRubyLayout)
			f20_arg0.fiveRubyLayout:completeAnimation()
			f20_arg0.fiveRubyLayout:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.fiveRubyLayout)
		end,
	},
	FourRubies = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.threeRubyLayout:completeAnimation()
			f21_arg0.threeRubyLayout:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.threeRubyLayout)
			f21_arg0.fiveRubyLayout:completeAnimation()
			f21_arg0.fiveRubyLayout:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.fiveRubyLayout)
		end,
	},
	FiveRubies = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.threeRubyLayout:completeAnimation()
			f22_arg0.threeRubyLayout:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.threeRubyLayout)
			f22_arg0.fourRubyLayout:completeAnimation()
			f22_arg0.fourRubyLayout:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.fourRubyLayout)
		end,
	},
}
CoD.ArenaProgressionRubies.__onClose = function(f23_arg0)
	f23_arg0.threeRubyLayout:close()
	f23_arg0.fourRubyLayout:close()
	f23_arg0.fiveRubyLayout:close()
end
