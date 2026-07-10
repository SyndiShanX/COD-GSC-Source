require("x64:444e1eea954887")
CoD.SpawnSelectTeamStatus = InheritFrom(LUI.UIElement)
CoD.SpawnSelectTeamStatus.__defaultWidth = 259
CoD.SpawnSelectTeamStatus.__defaultHeight = 50
CoD.SpawnSelectTeamStatus.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpawnSelectTeamStatus)
	self.id = "SpawnSelectTeamStatus"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local TeamStatusList = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, false, false, false, false)
	TeamStatusList:setLeftRight(0, 1, 1, 1)
	TeamStatusList:setTopBottom(0, 1, 0, 0)
	TeamStatusList:setWidgetType(CoD.SpawnSelectTeamStatusItem)
	TeamStatusList:setHorizontalCount(5)
	TeamStatusList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TeamStatusList:setDataSource("Clients")
	self:addElement(TeamStatusList)
	self.TeamStatusList = TeamStatusList
	self:subscribeToGlobalModel(f1_arg1, "PerController", "Clients.clientCount", function(model)
		local f2_local0 = self
		CoD.GridAndListUtility.UpdateDataSource(self.TeamStatusList, true, true, true)
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "hudItems.showSpawnSelect", function(model)
		local f3_local0 = self
		CoD.GridAndListUtility.UpdateDataSource(self.TeamStatusList, true, true, true)
	end)
	TeamStatusList.id = "TeamStatusList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	SetElementProperty(self.TeamStatusList, "friendlyTeam", true)
	return self
end
CoD.SpawnSelectTeamStatus.__onClose = function(f4_arg0)
	f4_arg0.TeamStatusList:close()
end
