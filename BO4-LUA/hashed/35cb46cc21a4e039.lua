CoD.WarScoreInfo_RoundPip = InheritFrom(LUI.UIElement)
CoD.WarScoreInfo_RoundPip.__defaultWidth = 32
CoD.WarScoreInfo_RoundPip.__defaultHeight = 32
CoD.WarScoreInfo_RoundPip.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarScoreInfo_RoundPip)
	self.id = "WarScoreInfo_RoundPip"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 0, 5, 27, 0, 0, 12, 20)
	Backing:setAlpha(0.15)
	Backing:setImage(RegisterImage(0x90EA5DD0D52C921))
	self:addElement(Backing)
	self.Backing = Backing
	local RoundFill = LUI.UIImage.new(0, 0, 5, 27, 0, 0, 9, 25)
	RoundFill:setImage(RegisterImage(0x62CBF3EB8A7E651))
	RoundFill.__Color = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			RoundFill:setRGB(CoD.HUDUtility.GetFriendlyOrEnemyColorByTeamId(f1_arg1, f2_local0))
		end
	end
	RoundFill:linkToElementModel(self, "teamId", true, RoundFill.__Color)
	RoundFill.__Color_FullPath = function()
		local f3_local0 = self:getModel()
		if f3_local0 then
			f3_local0 = self:getModel()
			f3_local0 = f3_local0.teamId
		end
		if f3_local0 then
			RoundFill.__Color(f3_local0)
		end
	end
	self:addElement(RoundFill)
	self.RoundFill = RoundFill
	local f1_local3 = RoundFill
	local f1_local4 = RoundFill.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["factions.actualTeam"], RoundFill.__Color_FullPath)
	f1_local3 = RoundFill
	f1_local4 = RoundFill.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["profile.colorblindMode"], RoundFill.__Color_FullPath)
	self:mergeStateConditions({
		{
			stateName = "Complete",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isComplete")
			end,
		},
	})
	self:linkToElementModel(self, "isComplete", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isComplete",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarScoreInfo_RoundPip.__resetProperties = function(f6_arg0)
	f6_arg0.RoundFill:completeAnimation()
	f6_arg0.RoundFill:setAlpha(1)
end
CoD.WarScoreInfo_RoundPip.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.RoundFill:completeAnimation()
			f7_arg0.RoundFill:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.RoundFill)
		end,
	},
	Complete = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.RoundFill:completeAnimation()
			f8_arg0.RoundFill:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.RoundFill)
		end,
	},
}
CoD.WarScoreInfo_RoundPip.__onClose = function(f9_arg0)
	f9_arg0.RoundFill:close()
end
