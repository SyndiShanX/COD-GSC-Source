require("x64:f1ba750269f9d18")
require("x64:c8a82e63a9de148")
local PostLoadFunc = function(self, controller)
	if Engine[@"getcurrentteamcount"]() < 2 then
		self.Team2Header:close()
		self.Team2:close()
	end
end
CoD.CodcasterPlayerlistInternal = InheritFrom(LUI.UIElement)
CoD.CodcasterPlayerlistInternal.__defaultWidth = 408
CoD.CodcasterPlayerlistInternal.__defaultHeight = 736
CoD.CodcasterPlayerlistInternal.new = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4, f2_arg5, f2_arg6, f2_arg7, f2_arg8, f2_arg9)
	local self = LUI.UIVerticalList.new(f2_arg2, f2_arg3, f2_arg4, f2_arg5, f2_arg6, f2_arg7, f2_arg8, f2_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.CodcasterPlayerlistInternal)
	self.id = "CodcasterPlayerlistInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f2_arg0:addElementToPendingUpdateStateList(self)
	local Team1Header = CoD.CodCasterPlayerListHeaderWidgetContainer.new(f2_arg0, f2_arg1, 1, 1, -408, 0, 0, 0, 0, 8)
	Team1Header:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueGreaterThan("scoreboard.team1.count", 0) and not CoD.ModelUtility.IsGlobalModelValueTrue("scoreboard.team1.shoutcasterListenInActive")
			end,
		},
		{
			stateName = "VisibleWithListenIn",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueGreaterThan("scoreboard.team1.count", 0) and CoD.ModelUtility.IsGlobalModelValueTrue("scoreboard.team1.shoutcasterListenInActive")
			end,
		},
	})
	local spacer = Team1Header
	local Team1 = Team1Header.subscribeToModel
	local Team2Header = Engine[@"getglobalmodel"]()
	Team1(spacer, Team2Header["scoreboard.team1.count"], function(f5_arg0)
		f2_arg0:updateElementState(Team1Header, {
			name = "model_validation",
			menu = f2_arg0,
			controller = f2_arg1,
			modelValue = f5_arg0:get(),
			modelName = "scoreboard.team1.count",
		})
	end, false)
	spacer = Team1Header
	Team1 = Team1Header.subscribeToModel
	Team2Header = Engine[@"getglobalmodel"]()
	Team1(spacer, Team2Header["scoreboard.team1.shoutcasterListenInActive"], function(f6_arg0)
		f2_arg0:updateElementState(Team1Header, {
			name = "model_validation",
			menu = f2_arg0,
			controller = f2_arg1,
			modelValue = f6_arg0:get(),
			modelName = "scoreboard.team1.shoutcasterListenInActive",
		})
	end, false)
	Team1Header:subscribeToGlobalModel(f2_arg1, "Factions", "alliesFactionDisplayName", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			Team1Header.Header.TeamName:setText(f7_local0)
		end
	end)
	Team1Header:subscribeToGlobalModel(f2_arg1, "Factions", "alliesFactionColor", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			Team1Header.Header.TeamColor:setRGB(f8_local0)
		end
	end)
	self:addElement(Team1Header)
	self.Team1Header = Team1Header
	Team1 = LUI.UIList.new(f2_arg0, f2_arg1, 0, 0, nil, false, false, false, false)
	Team1:setLeftRight(1, 1, -404, 0)
	Team1:setTopBottom(0.05, 0.05, -29, 295)
	Team1:setWidgetType(CoD.CodCasterPlayerListRowWidget)
	Team1:setVerticalCount(18)
	Team1:setSpacing(0)
	Team1:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Team1:setDataSource("Clients")
	self:addElement(Team1)
	self.Team1 = Team1
	spacer = LUI.UIImage.new(1, 1, -193, 0, 0.5, 0.5, -36, -20)
	spacer:setRGB(0, 0, 0)
	self:addElement(spacer)
	self.spacer = spacer
	Team2Header = CoD.CodCasterPlayerListHeaderWidgetContainer.new(f2_arg0, f2_arg1, 1, 1, -408, 0, 0, 0, 348, 356)
	Team2Header:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueGreaterThan("scoreboard.team2.count", 0) and not CoD.ModelUtility.IsGlobalModelValueTrue("scoreboard.team2.shoutcasterListenInActive")
			end,
		},
		{
			stateName = "VisibleWithListenIn",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueGreaterThan("scoreboard.team2.count", 0) and CoD.ModelUtility.IsGlobalModelValueTrue("scoreboard.team2.shoutcasterListenInActive")
			end,
		},
	})
	local f2_local5 = Team2Header
	local Team2 = Team2Header.subscribeToModel
	local f2_local7 = Engine[@"getglobalmodel"]()
	Team2(f2_local5, f2_local7["scoreboard.team2.count"], function(f11_arg0)
		f2_arg0:updateElementState(Team2Header, {
			name = "model_validation",
			menu = f2_arg0,
			controller = f2_arg1,
			modelValue = f11_arg0:get(),
			modelName = "scoreboard.team2.count",
		})
	end, false)
	f2_local5 = Team2Header
	Team2 = Team2Header.subscribeToModel
	f2_local7 = Engine[@"getglobalmodel"]()
	Team2(f2_local5, f2_local7["scoreboard.team2.shoutcasterListenInActive"], function(f12_arg0)
		f2_arg0:updateElementState(Team2Header, {
			name = "model_validation",
			menu = f2_arg0,
			controller = f2_arg1,
			modelValue = f12_arg0:get(),
			modelName = "scoreboard.team2.shoutcasterListenInActive",
		})
	end, false)
	Team2Header:subscribeToGlobalModel(f2_arg1, "Factions", "axisFactionDisplayName", function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			Team2Header.Header.TeamName:setText(f13_local0)
		end
	end)
	Team2Header:subscribeToGlobalModel(f2_arg1, "Factions", "axisFactionColor", function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			Team2Header.Header.TeamColor:setRGB(f14_local0)
		end
	end)
	self:addElement(Team2Header)
	self.Team2Header = Team2Header
	Team2 = LUI.UIList.new(f2_arg0, f2_arg1, 0, 0, nil, false, false, false, false)
	Team2:setLeftRight(1, 1, -404, 0)
	Team2:setTopBottom(0, 0, 356, 680)
	Team2:setWidgetType(CoD.CodCasterPlayerListRowWidget)
	Team2:setVerticalCount(18)
	Team2:setSpacing(0)
	Team2:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Team2:setDataSource("Clients")
	self:addElement(Team2)
	self.Team2 = Team2
	self.__on_menuOpened_self = function(f15_arg0, f15_arg1, f15_arg2, f15_arg3)
		local f15_local0 = self
		UpdateDataSource(self, self.Team1, f15_arg1)
		UpdateDataSource(self, self.Team2, f15_arg1)
	end
	f2_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	self:subscribeToGlobalModel(f2_arg1, "PerController", "Clients.clientChangedTeam", function(model)
		local f16_local0 = self
		CoD.GridAndListUtility.UpdateDataSource(self.Team1, false, false, false)
		CoD.GridAndListUtility.UpdateDataSource(self.Team2, false, false, false)
	end)
	self:subscribeToGlobalModel(f2_arg1, "PerController", "Clients.clientCount", function(model)
		local f17_local0 = self
		CoD.GridAndListUtility.UpdateDataSource(self.Team1, false, false, false)
		CoD.GridAndListUtility.UpdateDataSource(self.Team2, false, false, false)
	end)
	self:subscribeToGlobalModel(f2_arg1, "GlobalModel", "scoreboard.team1.count", function(model)
		local f18_local0 = self
		CoD.GridAndListUtility.UpdateDataSource(self.Team1, false, false, false)
		CoD.GridAndListUtility.UpdateDataSource(self.Team2, false, false, false)
	end)
	self:subscribeToGlobalModel(f2_arg1, "GlobalModel", "scoreboard.team2.count", function(model)
		local f19_local0 = self
		CoD.GridAndListUtility.UpdateDataSource(self.Team1, true, true, true)
		CoD.GridAndListUtility.UpdateDataSource(self.Team2, true, true, true)
	end)
	Team1.id = "Team1"
	Team2.id = "Team2"
	self.__on_close_removeOverrides = function()
		f2_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f2_arg1, f2_arg0)
	end
	f2_local5 = self
	SetElementProperty(self.Team1, "friendlyTeam", true)
	SetElementProperty(self.Team2, "enemyTeam", true)
	DisableNavigation(self, "Team1")
	DisableNavigation(self, "Team2")
	return self
end
CoD.CodcasterPlayerlistInternal.__resetProperties = function(f21_arg0)
	f21_arg0.Team2:completeAnimation()
	f21_arg0.Team1:completeAnimation()
	f21_arg0.Team1Header:completeAnimation()
	f21_arg0.Team2Header:completeAnimation()
	f21_arg0.spacer:completeAnimation()
	f21_arg0.Team2:setAlpha(1)
	f21_arg0.Team1:setAlpha(1)
	f21_arg0.Team1Header:setAlpha(1)
	f21_arg0.Team2Header:setAlpha(1)
	f21_arg0.spacer:setAlpha(1)
end
CoD.CodcasterPlayerlistInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(5)
			f22_arg0.Team1Header:completeAnimation()
			f22_arg0.Team1Header:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.Team1Header)
			f22_arg0.Team1:completeAnimation()
			f22_arg0.Team1:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.Team1)
			f22_arg0.spacer:completeAnimation()
			f22_arg0.spacer:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.spacer)
			f22_arg0.Team2Header:completeAnimation()
			f22_arg0.Team2Header:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.Team2Header)
			f22_arg0.Team2:completeAnimation()
			f22_arg0.Team2:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.Team2)
		end,
	},
	Visible = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.CodcasterPlayerlistInternal.__onClose = function(f24_arg0)
	f24_arg0.__on_close_removeOverrides()
	f24_arg0.Team1Header:close()
	f24_arg0.Team1:close()
	f24_arg0.Team2Header:close()
	f24_arg0.Team2:close()
end
