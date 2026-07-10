CoD.ArenaTeamDisplay = InheritFrom(LUI.UIElement)
CoD.ArenaTeamDisplay.__defaultWidth = 250
CoD.ArenaTeamDisplay.__defaultHeight = 300
CoD.ArenaTeamDisplay.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaTeamDisplay)
	self.id = "ArenaTeamDisplay"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TeamName = LUI.UIText.new(0, 0, 2.5, 248.5, 0, 0, 0, 61)
	TeamName:setAlpha(0)
	TeamName:setTTF("default")
	TeamName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TeamName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	TeamName:subscribeToGlobalModel(f1_arg1, "Arena", "currentTeamName", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TeamName:setText(f2_local0)
		end
	end)
	self:addElement(TeamName)
	self.TeamName = TeamName
	local TeamEmblem = LUI.UIElement.new(0.27, 1.27, -64.5, -68.5, 0.48, 1.48, -84, -88)
	TeamEmblem:setRGB(0.92, 0.92, 0.92)
	TeamEmblem:setAlpha(0)
	TeamEmblem.__Emblem_Index = function(f3_arg0)
		local f3_local0 = f3_arg0:get()
		if f3_local0 ~= nil then
			TeamEmblem:setupEmblemByEmblemIndex(CoD.ClanUtility.GetClanEmblemSlotParams(f1_arg1, f3_local0))
		end
	end
	TeamEmblem:subscribeToGlobalModel(f1_arg1, "Arena", "currentTeamId", TeamEmblem.__Emblem_Index)
	TeamEmblem.__Emblem_Index_FullPath = function()
		local f4_local0 = DataSources.Arena.getModel(f1_arg1)
		f4_local0 = f4_local0.currentTeamId
		if f4_local0 then
			TeamEmblem.__Emblem_Index(f4_local0)
		end
	end
	self:addElement(TeamEmblem)
	self.TeamEmblem = TeamEmblem
	TeamEmblem:linkToElementModel(self, "storageFileType", true, TeamEmblem.__Emblem_Index_FullPath)
	self:mergeStateConditions({
		{
			stateName = "TeamComplete",
			condition = function(menu, element, event)
				return CoD.ArenaUtility.IsInTeam(f1_arg1)
			end,
		},
	})
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "Arena.currentTeamId", function(model)
		local f6_local0 = self
		UpdateSelfState(self, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaTeamDisplay.__resetProperties = function(f7_arg0)
	f7_arg0.TeamName:completeAnimation()
	f7_arg0.TeamEmblem:completeAnimation()
	f7_arg0.TeamName:setAlpha(0)
	f7_arg0.TeamEmblem:setAlpha(0)
end
CoD.ArenaTeamDisplay.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	TeamComplete = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.TeamName:completeAnimation()
			f9_arg0.TeamName:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.TeamName)
			f9_arg0.TeamEmblem:completeAnimation()
			f9_arg0.TeamEmblem:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.TeamEmblem)
		end,
	},
}
CoD.ArenaTeamDisplay.__onClose = function(f10_arg0)
	f10_arg0.TeamName:close()
	f10_arg0.TeamEmblem:close()
end
