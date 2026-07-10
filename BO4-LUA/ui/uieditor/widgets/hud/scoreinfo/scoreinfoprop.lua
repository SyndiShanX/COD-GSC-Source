require("x64:fba4267ffde82d4")
require("x64:d9555af6faa42f8")
CoD.ScoreInfoProp = InheritFrom(LUI.UIElement)
CoD.ScoreInfoProp.__defaultWidth = 222
CoD.ScoreInfoProp.__defaultHeight = 122
CoD.ScoreInfoProp.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScoreInfoProp)
	self.id = "ScoreInfoProp"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FrameProp = LUI.UIImage.new(0, 0, 0, 221, 0, 0, 40, 118)
	FrameProp:setImage(RegisterImage(@"uie_ui_hud_prophunt_match_widget_frame"))
	self:addElement(FrameProp)
	self.FrameProp = FrameProp
	local FriendlyWinPips = CoD.ScoreInfo_RoundList.new(f1_arg0, f1_arg1, 0.5, 0.5, -104, -32, 0, 0, 34, 66)
	FriendlyWinPips.RoundPips:setDataSource("PlayerTeamRoundPips")
	FriendlyWinPips.RoundScoreText:setRGB(1, 0.99, 1)
	FriendlyWinPips:subscribeToGlobalModel(f1_arg1, "GameScore", "playerScore", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			FriendlyWinPips.RoundScoreText:setText(CoD.GameTypeUtility.RoundsWonOfRoundsTotal(f2_local0))
		end
	end)
	self:addElement(FriendlyWinPips)
	self.FriendlyWinPips = FriendlyWinPips
	local EnemyWinPips = CoD.ScoreInfo_RoundList.new(f1_arg0, f1_arg1, 0.5, 0.5, 29, 101, 0, 0, 34, 66)
	EnemyWinPips.RoundPips:setDataSource("EnemyTeamRoundPips")
	EnemyWinPips:subscribeToGlobalModel(f1_arg1, "HUDItems", "colorBlindSensitiveEnemyColor", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			EnemyWinPips.RoundPips:setRGB(f3_local0)
		end
	end)
	EnemyWinPips:subscribeToGlobalModel(f1_arg1, "HUDItems", "colorBlindSensitiveEnemyColor", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			EnemyWinPips.RoundScoreText:setRGB(f4_local0)
		end
	end)
	EnemyWinPips:subscribeToGlobalModel(f1_arg1, "GameScore", "enemyScore", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			EnemyWinPips.RoundScoreText:setText(CoD.GameTypeUtility.RoundsWonOfRoundsTotal(f5_local0))
		end
	end)
	self:addElement(EnemyWinPips)
	self.EnemyWinPips = EnemyWinPips
	local PropLivesEnemy = CoD.ScoreInfo_TicketSystemTeam.new(f1_arg0, f1_arg1, 0, 0, 76, 176, 0, 0, 82, 138)
	PropLivesEnemy.Container2:setAlpha(0)
	PropLivesEnemy.Container:setAlpha(0)
	PropLivesEnemy.PropLivesIcon:setRGB(ColorSet.EnemyOrange_Bright.r, ColorSet.EnemyOrange_Bright.g, ColorSet.EnemyOrange_Bright.b)
	PropLivesEnemy:subscribeToGlobalModel(f1_arg1, "HUDItems", "colorBlindSensitiveEnemyColor", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			PropLivesEnemy.TeamLivesIcon:setRGB(f6_local0)
		end
	end)
	PropLivesEnemy:subscribeToGlobalModel(f1_arg1, "HUDItems", "numPropsAlive", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			PropLivesEnemy.TeamLivesCount:setText(CoD.BaseUtility.AlreadyLocalized(f7_local0))
		end
	end)
	self:addElement(PropLivesEnemy)
	self.PropLivesEnemy = PropLivesEnemy
	local PropLivesFriendly = CoD.ScoreInfo_TicketSystemTeam.new(f1_arg0, f1_arg1, 0, 0, 76, 176, 0, 0, 82, 138)
	PropLivesFriendly.Container2:setAlpha(0)
	PropLivesFriendly.Container:setAlpha(0)
	PropLivesFriendly.PropLivesIcon:setRGB(ColorSet.PlayerCount.r, ColorSet.PlayerCount.g, ColorSet.PlayerCount.b)
	PropLivesFriendly:subscribeToGlobalModel(f1_arg1, "HUDItems", "colorBlindSensitiveFriendlyColor", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			PropLivesFriendly.TeamLivesIcon:setRGB(f8_local0)
		end
	end)
	PropLivesFriendly:subscribeToGlobalModel(f1_arg1, "HUDItems", "numPropsAlive", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			PropLivesFriendly.TeamLivesCount:setText(CoD.BaseUtility.AlreadyLocalized(f9_local0))
		end
	end)
	self:addElement(PropLivesFriendly)
	self.PropLivesFriendly = PropLivesFriendly
	self:mergeStateConditions({
		{
			stateName = "Props",
			condition = function(menu, element, event)
				return not IsAttackingTeam(f1_arg1)
			end,
		},
		{
			stateName = "Hunters",
			condition = function(menu, element, event)
				return IsAttackingTeam(f1_arg1)
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[@"getglobalmodel"]()
	f1_local7(f1_local6, f1_local8["hudItems.war.attackingTeam"], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "hudItems.war.attackingTeam",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = DataSources.CodCaster.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.profileSettingsUpdated, function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	FriendlyWinPips.id = "FriendlyWinPips"
	EnemyWinPips.id = "EnemyWinPips"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScoreInfoProp.__resetProperties = function(f14_arg0)
	f14_arg0.PropLivesEnemy:completeAnimation()
	f14_arg0.PropLivesFriendly:completeAnimation()
	f14_arg0.PropLivesEnemy:setAlpha(1)
	f14_arg0.PropLivesFriendly:setAlpha(1)
end
CoD.ScoreInfoProp.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
	},
	Props = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.PropLivesEnemy:completeAnimation()
			f16_arg0.PropLivesEnemy:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.PropLivesEnemy)
		end,
	},
	Hunters = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.PropLivesFriendly:completeAnimation()
			f17_arg0.PropLivesFriendly:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.PropLivesFriendly)
		end,
	},
}
CoD.ScoreInfoProp.__onClose = function(f18_arg0)
	f18_arg0.FriendlyWinPips:close()
	f18_arg0.EnemyWinPips:close()
	f18_arg0.PropLivesEnemy:close()
	f18_arg0.PropLivesFriendly:close()
end
