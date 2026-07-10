require("x64:f26a29f79cd73a1")
require("x64:c19e7fbf81b62c9")
CoD.CodCasterObjectiveStatusLifeCount = InheritFrom(LUI.UIElement)
CoD.CodCasterObjectiveStatusLifeCount.__defaultWidth = 520
CoD.CodCasterObjectiveStatusLifeCount.__defaultHeight = 32
CoD.CodCasterObjectiveStatusLifeCount.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterObjectiveStatusLifeCount)
	self.id = "CodCasterObjectiveStatusLifeCount"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(0.5, 0.5, -205, 205, 0.5, 0.5, -13.5, 11.5)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local TeamLeft = LUI.UIImage.new(0, 0, 49, 206, 0.5, 0.5, -14, 11)
	TeamLeft:setAlpha(0.5)
	TeamLeft:subscribeToGlobalModel(f1_arg1, "Factions", "alliesFactionColor", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TeamLeft:setRGB(f2_local0)
		end
	end)
	self:addElement(TeamLeft)
	self.TeamLeft = TeamLeft
	local DarkBackingLeft = LUI.UIImage.new(0.5, 0.5, -205, -54, 0.5, 0.5, -14, 11)
	DarkBackingLeft:setRGB(0, 0, 0)
	DarkBackingLeft:setAlpha(0.9)
	self:addElement(DarkBackingLeft)
	self.DarkBackingLeft = DarkBackingLeft
	local TeamRight = LUI.UIImage.new(0, 0, 315, 472, 0.5, 0.5, -14, 11)
	TeamRight:setAlpha(0.5)
	TeamRight:subscribeToGlobalModel(f1_arg1, "FactionsGlobal", "axisFactionColor", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			TeamRight:setRGB(f3_local0)
		end
	end)
	self:addElement(TeamRight)
	self.TeamRight = TeamRight
	local DarkBackingRight = LUI.UIImage.new(0.5, 0.5, 55, 212, 0.5, 0.5, -14, 11)
	DarkBackingRight:setRGB(0, 0, 0)
	DarkBackingRight:setAlpha(0.9)
	self:addElement(DarkBackingRight)
	self.DarkBackingRight = DarkBackingRight
	local objectiveStatusBackground = LUI.UIImage.new(0.5, 0.5, -260, 260, 0.5, 0.5, -16, 16)
	objectiveStatusBackground:setImage(RegisterImage(@"uie_ui_codcaster_scoreboard_livebg"))
	self:addElement(objectiveStatusBackground)
	self.objectiveStatusBackground = objectiveStatusBackground
	local RoundCount = LUI.UIText.new(0.5, 0.5, -49, 51, 0.08, 0.08, 1, 19)
	RoundCount:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_44583E7C93D5801E"))
	RoundCount:setTTF("ttmussels_demibold")
	RoundCount:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	RoundCount:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(RoundCount)
	self.RoundCount = RoundCount
	local CodCasterObjectiveStatusLifeTeam1 = CoD.CodCasterObjectiveStatusLifeTeam.new(f1_arg0, f1_arg1, 0.39, 0.39, -412, 0, 0.4, 0.4, -10, 10)
	CodCasterObjectiveStatusLifeTeam1.LifeList:setYRot(180)
	CodCasterObjectiveStatusLifeTeam1:subscribeToGlobalModel(f1_arg1, "PlayerTeamLastLivesData", nil, function(model)
		CodCasterObjectiveStatusLifeTeam1:setModel(model, f1_arg1)
	end)
	CodCasterObjectiveStatusLifeTeam1.teamLivesCount.teamLivesCount.__teamLivesCount_teamLivesCount_String_Reference = function(f5_arg0)
		local f5_local0 = f5_arg0:get()
		if f5_local0 ~= nil then
			CodCasterObjectiveStatusLifeTeam1.teamLivesCount.teamLivesCount:setText(CoD.HUDUtility.AddTeamSize(f1_arg1, 0, f5_local0))
		end
	end
	CodCasterObjectiveStatusLifeTeam1:subscribeToGlobalModel(f1_arg1, "TeamLivesData", "playerTeamLives", CodCasterObjectiveStatusLifeTeam1.teamLivesCount.teamLivesCount.__teamLivesCount_teamLivesCount_String_Reference)
	CodCasterObjectiveStatusLifeTeam1.teamLivesCount.teamLivesCount.__teamLivesCount_teamLivesCount_String_Reference_FullPath = function()
		local f6_local0 = DataSources.TeamLivesData.getModel(f1_arg1)
		f6_local0 = f6_local0.playerTeamLives
		if f6_local0 then
			CodCasterObjectiveStatusLifeTeam1.teamLivesCount.teamLivesCount.__teamLivesCount_teamLivesCount_String_Reference(f6_local0)
		end
	end
	CodCasterObjectiveStatusLifeTeam1:subscribeToGlobalModel(f1_arg1, "PlayerTeamLastLivesData", nil, function(model)
		CodCasterObjectiveStatusLifeTeam1.LifeList:setModel(model, f1_arg1)
	end)
	self:addElement(CodCasterObjectiveStatusLifeTeam1)
	self.CodCasterObjectiveStatusLifeTeam1 = CodCasterObjectiveStatusLifeTeam1
	local CodCasterObjectiveStatusLifeTeam2 = CoD.CodCasterObjectiveStatusLifeTeam2.new(f1_arg0, f1_arg1, 0.61, 0.61, -268, 144, 0.4, 0.4, -10, 10)
	CodCasterObjectiveStatusLifeTeam2:subscribeToGlobalModel(f1_arg1, "EnemyTeamLastLivesData", nil, function(model)
		CodCasterObjectiveStatusLifeTeam2:setModel(model, f1_arg1)
	end)
	CodCasterObjectiveStatusLifeTeam2.teamLivesCount.teamLivesCount.__teamLivesCount_teamLivesCount_String_Reference = function(f9_arg0)
		local f9_local0 = f9_arg0:get()
		if f9_local0 ~= nil then
			CodCasterObjectiveStatusLifeTeam2.teamLivesCount.teamLivesCount:setText(CoD.HUDUtility.AddTeamSize(f1_arg1, 1, f9_local0))
		end
	end
	CodCasterObjectiveStatusLifeTeam2:subscribeToGlobalModel(f1_arg1, "TeamLivesData", "enemyTeamLives", CodCasterObjectiveStatusLifeTeam2.teamLivesCount.teamLivesCount.__teamLivesCount_teamLivesCount_String_Reference)
	CodCasterObjectiveStatusLifeTeam2.teamLivesCount.teamLivesCount.__teamLivesCount_teamLivesCount_String_Reference_FullPath = function()
		local f10_local0 = DataSources.TeamLivesData.getModel(f1_arg1)
		f10_local0 = f10_local0.enemyTeamLives
		if f10_local0 then
			CodCasterObjectiveStatusLifeTeam2.teamLivesCount.teamLivesCount.__teamLivesCount_teamLivesCount_String_Reference(f10_local0)
		end
	end
	CodCasterObjectiveStatusLifeTeam2:subscribeToGlobalModel(f1_arg1, "EnemyTeamLastLivesData", nil, function(model)
		CodCasterObjectiveStatusLifeTeam2.LifeList:setModel(model, f1_arg1)
	end)
	self:addElement(CodCasterObjectiveStatusLifeTeam2)
	self.CodCasterObjectiveStatusLifeTeam2 = CodCasterObjectiveStatusLifeTeam2
	local f1_local10 = CodCasterObjectiveStatusLifeTeam1
	local f1_local11 = CodCasterObjectiveStatusLifeTeam1.subscribeToModel
	local f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local11(f1_local10, f1_local12["PlayerTeamLastLivesData.teamSize"], CodCasterObjectiveStatusLifeTeam1.teamLivesCount.teamLivesCount.__teamLivesCount_teamLivesCount_String_Reference_FullPath)
	f1_local10 = CodCasterObjectiveStatusLifeTeam1
	f1_local11 = CodCasterObjectiveStatusLifeTeam1.subscribeToModel
	f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local11(f1_local10, f1_local12["EnemyTeamLastLivesData.teamSize"], CodCasterObjectiveStatusLifeTeam1.teamLivesCount.teamLivesCount.__teamLivesCount_teamLivesCount_String_Reference_FullPath)
	f1_local10 = CodCasterObjectiveStatusLifeTeam2
	f1_local11 = CodCasterObjectiveStatusLifeTeam2.subscribeToModel
	f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local11(f1_local10, f1_local12["PlayerTeamLastLivesData.teamSize"], CodCasterObjectiveStatusLifeTeam2.teamLivesCount.teamLivesCount.__teamLivesCount_teamLivesCount_String_Reference_FullPath)
	f1_local10 = CodCasterObjectiveStatusLifeTeam2
	f1_local11 = CodCasterObjectiveStatusLifeTeam2.subscribeToModel
	f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local11(f1_local10, f1_local12["EnemyTeamLastLivesData.teamSize"], CodCasterObjectiveStatusLifeTeam2.teamLivesCount.teamLivesCount.__teamLivesCount_teamLivesCount_String_Reference_FullPath)
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f12_local0
				if not CoD.HUDUtility.ShouldShowTeamLives(f1_arg1) then
					f12_local0 = not CoD.HUDUtility.IsGameTypeEqualToString("ctf")
				else
					f12_local0 = false
				end
				return f12_local0
			end,
		},
		{
			stateName = "RoundOnly",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("ctf")
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterObjectiveStatusLifeCount.__resetProperties = function(f14_arg0)
	f14_arg0.RoundCount:completeAnimation()
	f14_arg0.objectiveStatusBackground:completeAnimation()
	f14_arg0.CodCasterObjectiveStatusLifeTeam1:completeAnimation()
	f14_arg0.CodCasterObjectiveStatusLifeTeam2:completeAnimation()
	f14_arg0.Blur:completeAnimation()
	f14_arg0.TeamRight:completeAnimation()
	f14_arg0.TeamLeft:completeAnimation()
	f14_arg0.DarkBackingLeft:completeAnimation()
	f14_arg0.DarkBackingRight:completeAnimation()
	f14_arg0.RoundCount:setAlpha(1)
	f14_arg0.objectiveStatusBackground:setAlpha(1)
	f14_arg0.CodCasterObjectiveStatusLifeTeam1:setAlpha(1)
	f14_arg0.CodCasterObjectiveStatusLifeTeam2:setAlpha(1)
	f14_arg0.Blur:setAlpha(1)
	f14_arg0.TeamRight:setAlpha(0.5)
	f14_arg0.TeamLeft:setAlpha(0.5)
	f14_arg0.DarkBackingLeft:setAlpha(0.9)
	f14_arg0.DarkBackingRight:setAlpha(0.9)
end
CoD.CodCasterObjectiveStatusLifeCount.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(9)
			f16_arg0.Blur:completeAnimation()
			f16_arg0.Blur:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.Blur)
			f16_arg0.TeamLeft:completeAnimation()
			f16_arg0.TeamLeft:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.TeamLeft)
			f16_arg0.DarkBackingLeft:completeAnimation()
			f16_arg0.DarkBackingLeft:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.DarkBackingLeft)
			f16_arg0.TeamRight:completeAnimation()
			f16_arg0.TeamRight:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.TeamRight)
			f16_arg0.DarkBackingRight:completeAnimation()
			f16_arg0.DarkBackingRight:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.DarkBackingRight)
			f16_arg0.objectiveStatusBackground:completeAnimation()
			f16_arg0.objectiveStatusBackground:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.objectiveStatusBackground)
			f16_arg0.RoundCount:completeAnimation()
			f16_arg0.RoundCount:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.RoundCount)
			f16_arg0.CodCasterObjectiveStatusLifeTeam1:completeAnimation()
			f16_arg0.CodCasterObjectiveStatusLifeTeam1:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.CodCasterObjectiveStatusLifeTeam1)
			f16_arg0.CodCasterObjectiveStatusLifeTeam2:completeAnimation()
			f16_arg0.CodCasterObjectiveStatusLifeTeam2:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.CodCasterObjectiveStatusLifeTeam2)
		end,
	},
	RoundOnly = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(6)
			f17_arg0.TeamLeft:completeAnimation()
			f17_arg0.TeamLeft:setAlpha(0.5)
			f17_arg0.clipFinished(f17_arg0.TeamLeft)
			f17_arg0.DarkBackingLeft:completeAnimation()
			f17_arg0.DarkBackingLeft:setAlpha(0.5)
			f17_arg0.clipFinished(f17_arg0.DarkBackingLeft)
			f17_arg0.TeamRight:completeAnimation()
			f17_arg0.TeamRight:setAlpha(0.5)
			f17_arg0.clipFinished(f17_arg0.TeamRight)
			f17_arg0.DarkBackingRight:completeAnimation()
			f17_arg0.DarkBackingRight:setAlpha(0.5)
			f17_arg0.clipFinished(f17_arg0.DarkBackingRight)
			f17_arg0.CodCasterObjectiveStatusLifeTeam1:completeAnimation()
			f17_arg0.CodCasterObjectiveStatusLifeTeam1:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.CodCasterObjectiveStatusLifeTeam1)
			f17_arg0.CodCasterObjectiveStatusLifeTeam2:completeAnimation()
			f17_arg0.CodCasterObjectiveStatusLifeTeam2:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.CodCasterObjectiveStatusLifeTeam2)
		end,
	},
}
CoD.CodCasterObjectiveStatusLifeCount.__onClose = function(f18_arg0)
	f18_arg0.TeamLeft:close()
	f18_arg0.TeamRight:close()
	f18_arg0.CodCasterObjectiveStatusLifeTeam1:close()
	f18_arg0.CodCasterObjectiveStatusLifeTeam2:close()
end
