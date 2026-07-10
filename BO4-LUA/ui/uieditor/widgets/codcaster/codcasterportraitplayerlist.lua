require("x64:9d50734163c68d")
require("x64:9d4d734163c174")
CoD.CodCasterPortraitPlayerList = InheritFrom(LUI.UIElement)
CoD.CodCasterPortraitPlayerList.__defaultWidth = 1920
CoD.CodCasterPortraitPlayerList.__defaultHeight = 200
CoD.CodCasterPortraitPlayerList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterPortraitPlayerList)
	self.id = "CodCasterPortraitPlayerList"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Team2PortraitList = LUI.UIList.new(f1_arg0, f1_arg1, -3, 0, nil, false, false, false, false)
	Team2PortraitList:setLeftRight(0.93, 0.93, -614.5, 162.5)
	Team2PortraitList:setTopBottom(0.55, 0.55, -78, 78)
	Team2PortraitList:setWidgetType(CoD.codcaster_player_portraittop_team2)
	Team2PortraitList:setHorizontalCount(6)
	Team2PortraitList:setSpacing(-3)
	Team2PortraitList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Team2PortraitList:setDataSource("Clients")
	self:addElement(Team2PortraitList)
	self.Team2PortraitList = Team2PortraitList
	local Team1PortraitList = LUI.UIList.new(f1_arg0, f1_arg1, -3, 0, nil, false, false, false, false)
	Team1PortraitList:setLeftRight(0.02, 0.02, -54.5, 722.5)
	Team1PortraitList:setTopBottom(0.55, 0.55, -78, 78)
	Team1PortraitList:setWidgetType(CoD.codcaster_player_portraittop_team1)
	Team1PortraitList:setHorizontalCount(6)
	Team1PortraitList:setSpacing(-3)
	Team1PortraitList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Team1PortraitList:setDataSource("Clients")
	self:addElement(Team1PortraitList)
	self.Team1PortraitList = Team1PortraitList
	self.__on_menuOpened_self = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
		local f2_local0 = self
		UpdateDataSource(self, self.Team1PortraitList, f2_arg1)
		UpdateDataSource(self, self.Team2PortraitList, f2_arg1)
		CoD.CodCasterUtility.SetPortraitListIndexes(self, f2_arg1)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "Clients.clientChangedTeam", function(model)
		local f3_local0 = self
		UpdateDataSource(self, self.Team1PortraitList, f1_arg1)
		UpdateDataSource(self, self.Team2PortraitList, f1_arg1)
		CoD.CodCasterUtility.SetPortraitListIndexes(self, f1_arg1)
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "Clients.clientCount", function(model)
		local f4_local0 = self
		UpdateDataSource(self, self.Team1PortraitList, f1_arg1)
		UpdateDataSource(self, self.Team2PortraitList, f1_arg1)
		CoD.CodCasterUtility.SetPortraitListIndexes(self, f1_arg1)
	end)
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "scoreboard.team1.count", function(model)
		local f5_local0 = self
		UpdateDataSource(self, self.Team1PortraitList, f1_arg1)
		UpdateDataSource(self, self.Team2PortraitList, f1_arg1)
		CoD.CodCasterUtility.SetPortraitListIndexes(self, f1_arg1)
	end)
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "scoreboard.team2.count", function(model)
		local f6_local0 = self
		UpdateDataSource(self, self.Team1PortraitList, f1_arg1)
		UpdateDataSource(self, self.Team2PortraitList, f1_arg1)
		CoD.CodCasterUtility.SetPortraitListIndexes(self, f1_arg1)
	end)
	Team2PortraitList.id = "Team2PortraitList"
	Team1PortraitList.id = "Team1PortraitList"
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local3 = self
	SetElementProperty(Team2PortraitList, "enemyTeam", true)
	SetElementProperty(Team1PortraitList, "friendlyTeam", true)
	return self
end
CoD.CodCasterPortraitPlayerList.__resetProperties = function(f8_arg0)
	f8_arg0.Team1PortraitList:completeAnimation()
	f8_arg0.Team2PortraitList:completeAnimation()
	f8_arg0.Team1PortraitList:setAlpha(1)
	f8_arg0.Team2PortraitList:setAlpha(1)
end
CoD.CodCasterPortraitPlayerList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.Team2PortraitList:completeAnimation()
			f9_arg0.Team2PortraitList:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Team2PortraitList)
			f9_arg0.Team1PortraitList:completeAnimation()
			f9_arg0.Team1PortraitList:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Team1PortraitList)
		end,
	},
	Visible = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.CodCasterPortraitPlayerList.__onClose = function(f11_arg0)
	f11_arg0.__on_close_removeOverrides()
	f11_arg0.Team2PortraitList:close()
	f11_arg0.Team1PortraitList:close()
end
