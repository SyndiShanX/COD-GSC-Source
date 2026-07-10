require("x64:3903ffd36e44858")
require("x64:111ec5f37f9e18f")
require("x64:d3212b8860dc27e")
require("x64:5f2055353ec042b")
require("x64:a9255c570c68aa8")
CoD.Leaderboard_RankAndStatsWidget = InheritFrom(LUI.UIElement)
CoD.Leaderboard_RankAndStatsWidget.__defaultWidth = 360
CoD.Leaderboard_RankAndStatsWidget.__defaultHeight = 300
CoD.Leaderboard_RankAndStatsWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Leaderboard_RankAndStatsWidget)
	self.id = "Leaderboard_RankAndStatsWidget"
	self.soundSet = "CAC_PrimaryWeapon"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local rankIcon = CoD.FE_ImageA.new(f1_arg0, f1_arg1, 0, 0, 6, 132, 0, 0, 5, 131)
	self:addElement(rankIcon)
	self.rankIcon = rankIcon
	local rankText = CoD.FE_SlideSubHeader.new(f1_arg0, f1_arg1, 0, 0, 141.5, 359.5, 0, 0, 47, 89)
	rankText.FELabelSubHeadingD0.Label0:setText(Engine[@"hash_4F9F1239CFD921FE"](PrependLocalizedStringWithSeparator(@"hash_499A97D1A6F94031", " ", "LEVEL 53")))
	self:addElement(rankText)
	self.rankText = rankText
	local ListHeader0 = CoD.FE_ListHeader.new(f1_arg0, f1_arg1, 0, 0, 141, 360, 0, 0, 5, 47)
	ListHeader0:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	ListHeader0.Label:setText("")
	self:addElement(ListHeader0)
	self.ListHeader0 = ListHeader0
	local StatWidget1 = CoD.Leaderboard_StatWidget.new(f1_arg0, f1_arg1, 0, 0, 0, 119, 0, 0, 150, 278)
	StatWidget1:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	StatWidget1.StatText:setText("")
	self:addElement(StatWidget1)
	self.StatWidget1 = StatWidget1
	local StatWidget2 = CoD.Leaderboard_StatWidget.new(f1_arg0, f1_arg1, 0, 0, 120.5, 239.5, 0, 0, 150, 278)
	StatWidget2:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueLessThan(f1_arg1, "LeaderboardHeader", "numDataColumns", 2)
			end,
		},
	})
	local Frame = StatWidget2
	local StatWidget3 = StatWidget2.subscribeToModel
	local f1_local8 = DataSources.LeaderboardHeader.getModel(f1_arg1)
	StatWidget3(Frame, f1_local8.numDataColumns, function(f4_arg0)
		f1_arg0:updateElementState(StatWidget2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "numDataColumns",
		})
	end, false)
	StatWidget2.StatText:setText("")
	self:addElement(StatWidget2)
	self.StatWidget2 = StatWidget2
	StatWidget3 = CoD.Leaderboard_StatWidget.new(f1_arg0, f1_arg1, 0, 0, 241, 360, 0, 0, 150, 278)
	StatWidget3:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueLessThan(f1_arg1, "LeaderboardHeader", "numDataColumns", 3)
			end,
		},
	})
	f1_local8 = StatWidget3
	Frame = StatWidget3.subscribeToModel
	local f1_local9 = DataSources.LeaderboardHeader.getModel(f1_arg1)
	Frame(f1_local8, f1_local9.numDataColumns, function(f6_arg0)
		f1_arg0:updateElementState(StatWidget3, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "numDataColumns",
		})
	end, false)
	StatWidget3.StatText:setText("")
	self:addElement(StatWidget3)
	self.StatWidget3 = StatWidget3
	Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 6, 132, 0, 0, 5, 131)
	Frame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Frame:setAlpha(0)
	self:addElement(Frame)
	self.Frame = Frame
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Leaderboard_RankAndStatsWidget.__resetProperties = function(f7_arg0)
	f7_arg0.rankText:completeAnimation()
	f7_arg0.ListHeader0:completeAnimation()
	f7_arg0.rankIcon:completeAnimation()
	f7_arg0.StatWidget1:completeAnimation()
	f7_arg0.StatWidget2:completeAnimation()
	f7_arg0.StatWidget3:completeAnimation()
	f7_arg0.rankText:setAlpha(1)
	f7_arg0.ListHeader0:setAlpha(1)
	f7_arg0.rankIcon:setAlpha(1)
	f7_arg0.StatWidget1:setAlpha(1)
	f7_arg0.StatWidget2:setAlpha(1)
	f7_arg0.StatWidget3:setAlpha(1)
end
CoD.Leaderboard_RankAndStatsWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(6)
			f8_arg0.rankIcon:completeAnimation()
			f8_arg0.rankIcon:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.rankIcon)
			f8_arg0.rankText:completeAnimation()
			f8_arg0.rankText:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.rankText)
			f8_arg0.ListHeader0:completeAnimation()
			f8_arg0.ListHeader0:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.ListHeader0)
			f8_arg0.StatWidget1:completeAnimation()
			f8_arg0.StatWidget1:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.StatWidget1)
			f8_arg0.StatWidget2:completeAnimation()
			f8_arg0.StatWidget2:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.StatWidget2)
			f8_arg0.StatWidget3:completeAnimation()
			f8_arg0.StatWidget3:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.StatWidget3)
		end,
	},
	Visible = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.Leaderboard_RankAndStatsWidget.__onClose = function(f10_arg0)
	f10_arg0.rankIcon:close()
	f10_arg0.rankText:close()
	f10_arg0.ListHeader0:close()
	f10_arg0.StatWidget1:close()
	f10_arg0.StatWidget2:close()
	f10_arg0.StatWidget3:close()
	f10_arg0.Frame:close()
end
