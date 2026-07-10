require("x64:c8a82e63a9de148")
CoD.CodcasterNonTeamBasedPlayerListInternal = InheritFrom(LUI.UIElement)
CoD.CodcasterNonTeamBasedPlayerListInternal.__defaultWidth = 408
CoD.CodcasterNonTeamBasedPlayerListInternal.__defaultHeight = 420
CoD.CodcasterNonTeamBasedPlayerListInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.CodcasterNonTeamBasedPlayerListInternal)
	self.id = "CodcasterNonTeamBasedPlayerListInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FreeTeam = LUI.UIList.new(f1_arg0, f1_arg1, 0, 0, nil, false, false, false, false)
	FreeTeam:setLeftRight(0, 0, 4, 408)
	FreeTeam:setTopBottom(0, 0, 0, 324)
	FreeTeam:setWidgetType(CoD.CodCasterPlayerListRowWidget)
	FreeTeam:setVerticalCount(18)
	FreeTeam:setSpacing(0)
	FreeTeam:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	FreeTeam:setDataSource("Clients")
	self:addElement(FreeTeam)
	self.FreeTeam = FreeTeam
	self.__on_menuOpened_self = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
		local f2_local0 = self
		UpdateDataSource(self, self.FreeTeam, f2_arg1)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "Clients.clientCount", function(model)
		local f3_local0 = self
		CoD.GridAndListUtility.UpdateDataSource(self.FreeTeam, false, false, false)
	end)
	self:subscribeToGlobalModel(f1_arg1, "", "GlobalModel.scoreboard.FreeTeam.count", function(model)
		local f4_local0 = self
		CoD.GridAndListUtility.UpdateDataSource(self.FreeTeam, true, true, true)
	end)
	FreeTeam.id = "FreeTeam"
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	SetElementProperty(self.FreeTeam, "ffaTeam", true)
	DisableNavigation(self, "FreeTeam")
	f1_local2 = FreeTeam
	if not IsGametypeTeambased() then
		SetElementProperty(f1_local2, "ffaTeam", true)
		SetControllerModelValue(f1_arg1, "codcaster.showPlayerList", true)
	end
	return self
end
CoD.CodcasterNonTeamBasedPlayerListInternal.__onClose = function(f6_arg0)
	f6_arg0.__on_close_removeOverrides()
	f6_arg0.FreeTeam:close()
end
