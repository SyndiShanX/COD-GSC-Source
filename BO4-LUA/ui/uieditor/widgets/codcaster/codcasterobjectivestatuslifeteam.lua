require("x64:1738bb1b8ba5b93")
require("x64:53a9daa62b22793")
CoD.CodCasterObjectiveStatusLifeTeam = InheritFrom(LUI.UIElement)
CoD.CodCasterObjectiveStatusLifeTeam.__defaultWidth = 412
CoD.CodCasterObjectiveStatusLifeTeam.__defaultHeight = 20
CoD.CodCasterObjectiveStatusLifeTeam.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterObjectiveStatusLifeTeam)
	self.id = "CodCasterObjectiveStatusLifeTeam"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local teamLivesCount = CoD.CodCasterLivesCount.new(f1_arg0, f1_arg1, 0, 0, 294.5, 394.5, 0, 0, 1, 19)
	teamLivesCount:setAlpha(0)
	self:addElement(teamLivesCount)
	self.teamLivesCount = teamLivesCount
	local LifeList = CoD.ScoreInfo_TicketSystemLifeList.new(f1_arg0, f1_arg1, 1, 1, -85, 0, -0.3, -0.3, 0, 32)
	LifeList:setZRot(1)
	LifeList:subscribeToGlobalModel(f1_arg1, "PlayerTeamLastLivesData", nil, function(model)
		LifeList:setModel(model, f1_arg1)
	end)
	self:addElement(LifeList)
	self.LifeList = LifeList
	local LifeIcon = LUI.UIImage.new(1, 1, -74, 54, -0.3, -0.3, -48.5, 79.5)
	LifeIcon:setScale(0.25, 0.25)
	LifeIcon:setImage(RegisterImage(@"hash_6EE751109854B314"))
	LifeIcon:subscribeToGlobalModel(f1_arg1, "Scoreboard", "team1FactionColor", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			LifeIcon:setRGB(f3_local0)
		end
	end)
	self:addElement(LifeIcon)
	self.LifeIcon = LifeIcon
	self:mergeStateConditions({
		{
			stateName = "NoIcons",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "noRespawnsLeft")
			end,
		},
	})
	self:linkToElementModel(self, "noRespawnsLeft", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "noRespawnsLeft",
		})
	end)
	self.__on_menuOpened_self = function(f6_arg0, f6_arg1, f6_arg2, f6_arg3)
		UpdateSelfElementState(f6_arg2, self, f6_arg1)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterObjectiveStatusLifeTeam.__resetProperties = function(f8_arg0)
	f8_arg0.LifeIcon:completeAnimation()
	f8_arg0.LifeList:completeAnimation()
	f8_arg0.teamLivesCount:completeAnimation()
	f8_arg0.LifeIcon:setAlpha(1)
	f8_arg0.LifeList:setAlpha(1)
	f8_arg0.teamLivesCount:setAlpha(0)
end
CoD.CodCasterObjectiveStatusLifeTeam.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.LifeIcon:completeAnimation()
			f9_arg0.LifeIcon:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.LifeIcon)
		end,
	},
	NoIcons = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.teamLivesCount:completeAnimation()
			f10_arg0.teamLivesCount:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.teamLivesCount)
			f10_arg0.LifeList:completeAnimation()
			f10_arg0.LifeList:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.LifeList)
		end,
	},
}
CoD.CodCasterObjectiveStatusLifeTeam.__onClose = function(f11_arg0)
	f11_arg0.__on_close_removeOverrides()
	f11_arg0.teamLivesCount:close()
	f11_arg0.LifeList:close()
	f11_arg0.LifeIcon:close()
end
