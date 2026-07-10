require("x64:78d9663be3f826")
require("x64:81a24c5340caa1e")
CoD.Leaderboard_SafeAreaTabs = InheritFrom(LUI.UIElement)
CoD.Leaderboard_SafeAreaTabs.__defaultWidth = 1920
CoD.Leaderboard_SafeAreaTabs.__defaultHeight = 1080
CoD.Leaderboard_SafeAreaTabs.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Leaderboard_SafeAreaTabs)
	self.id = "Leaderboard_SafeAreaTabs"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local TabBacking = CoD.CommonTabBarBacking.new(f1_arg0, f1_arg1, -0.25, 1.25, 0, 0, 0, 0, 52, 89)
	TabBacking.TabBackingBlur:setAlpha(0)
	self:addElement(TabBacking)
	self.TabBacking = TabBacking
	local LeaderboardTabs = CoD.Common_Tabbar_Center.new(f1_arg0, f1_arg1, 0.5, 0.5, -1650, 1650, 0, 0, 34, 95)
	LeaderboardTabs:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.IsOfflineOnlyDemo() and InFrontend()
			end,
		},
	})
	LeaderboardTabs:appendEventHandler("grid_updated", function(f3_arg0, f3_arg1)
		f3_arg1.menu = f3_arg1.menu or f1_arg0
		f1_arg0:updateElementState(LeaderboardTabs, f3_arg1)
	end)
	LeaderboardTabs:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState(LeaderboardTabs, f4_arg1)
	end)
	local f1_local3 = LeaderboardTabs
	local f1_local4 = LeaderboardTabs.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5.LastInput, function(f5_arg0)
		f1_arg0:updateElementState(LeaderboardTabs, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LeaderboardTabs.Tabs.grid:setDataSource("LeaderboardTabType")
	self:addElement(LeaderboardTabs)
	self.LeaderboardTabs = LeaderboardTabs
	LeaderboardTabs.id = "LeaderboardTabs"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Leaderboard_SafeAreaTabs.__onClose = function(f6_arg0)
	f6_arg0.TabBacking:close()
	f6_arg0.LeaderboardTabs:close()
end
