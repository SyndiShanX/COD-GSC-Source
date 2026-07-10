CoD.CodCasterPortraitPlayerListEntryExtra = InheritFrom(LUI.UIElement)
CoD.CodCasterPortraitPlayerListEntryExtra.__defaultWidth = 134
CoD.CodCasterPortraitPlayerListEntryExtra.__defaultHeight = 33
CoD.CodCasterPortraitPlayerListEntryExtra.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterPortraitPlayerListEntryExtra)
	self.id = "CodCasterPortraitPlayerListEntryExtra"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PlayerListEntryStreak = LUI.UIText.new(0.38, 0.62, 1, 1, 0, 0, 14, 30)
	PlayerListEntryStreak:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	PlayerListEntryStreak:setTTF("ttmussels_demibold")
	PlayerListEntryStreak:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	PlayerListEntryStreak:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(PlayerListEntryStreak)
	self.PlayerListEntryStreak = PlayerListEntryStreak
	local PlayerListEntryKD = LUI.UIText.new(0.01, 0.63, -16, -16, 0, 0, 14, 30)
	PlayerListEntryKD:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	PlayerListEntryKD:setTTF("ttmussels_demibold")
	PlayerListEntryKD:setLetterSpacing(1)
	PlayerListEntryKD:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	PlayerListEntryKD:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(PlayerListEntryKD)
	self.PlayerListEntryKD = PlayerListEntryKD
	local PlayerListEntryObjective = LUI.UIText.new(0.7, 0.95, -7, -7, 0, 0, 13.5, 29.5)
	PlayerListEntryObjective:setTTF("ttmussels_demibold")
	PlayerListEntryObjective:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	PlayerListEntryObjective:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	PlayerListEntryObjective:linkToElementModel(self, "clientNumScoreInfoUpdated", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PlayerListEntryObjective:setText(CoD.CodCasterUtility.ScoreByGametype(f1_arg1, f2_local0))
		end
	end)
	self:addElement(PlayerListEntryObjective)
	self.PlayerListEntryObjective = PlayerListEntryObjective
	local PlayerListEntryKillIcon = LUI.UIImage.new(0.05, 0.05, 4, 16, 0.21, 0.21, -7, 5)
	PlayerListEntryKillIcon:setImage(RegisterImage(@"hash_6D6EA61A12AEADCE"))
	PlayerListEntryKillIcon:setupUIStreamedImage(0)
	self:addElement(PlayerListEntryKillIcon)
	self.PlayerListEntryKillIcon = PlayerListEntryKillIcon
	local PlayerListEntryDeathIcon = LUI.UIImage.new(0.24, 0.24, 2, 14, 0.18, 0.18, -5, 5)
	PlayerListEntryDeathIcon:setImage(RegisterImage(@"hash_39E55E6818C34348"))
	PlayerListEntryDeathIcon:setupUIStreamedImage(0)
	self:addElement(PlayerListEntryDeathIcon)
	self.PlayerListEntryDeathIcon = PlayerListEntryDeathIcon
	local PlayerListEntryStreakIcon = LUI.UIImage.new(0.5, 0.5, -7, 9, 0.21, 0.21, -6, 4)
	PlayerListEntryStreakIcon:setImage(RegisterImage(@"uie_codcaster_player_list_entry_streak"))
	PlayerListEntryStreakIcon:setupUIStreamedImage(0)
	self:addElement(PlayerListEntryStreakIcon)
	self.PlayerListEntryStreakIcon = PlayerListEntryStreakIcon
	local PlayerListEntryObjectiveIcon = LUI.UIImage.new(0.82, 0.82, -12, -2, 0.21, 0.21, -6.5, 3.5)
	PlayerListEntryObjectiveIcon:setScale(1.2, 1.2)
	PlayerListEntryObjectiveIcon:setImage(RegisterImage(@"uie_ui_hud_core_waypoint_led"))
	PlayerListEntryObjectiveIcon:setupUIStreamedImage(0)
	self:addElement(PlayerListEntryObjectiveIcon)
	self.PlayerListEntryObjectiveIcon = PlayerListEntryObjectiveIcon
	local PlayerListEntryObjectiveIcon2 = LUI.UIImage.new(0.82, 0.82, -11, -1, 0.21, 0.21, -6.5, 3.5)
	PlayerListEntryObjectiveIcon2:setScale(1.2, 1.2)
	PlayerListEntryObjectiveIcon2:setImage(RegisterImage(@"uie_ui_hud_core_waypoint_domination_fill_02"))
	PlayerListEntryObjectiveIcon2:setupUIStreamedImage(0)
	self:addElement(PlayerListEntryObjectiveIcon2)
	self.PlayerListEntryObjectiveIcon2 = PlayerListEntryObjectiveIcon2
	self:mergeStateConditions({
		{
			stateName = "PlayerDead",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "health.healthValue", 0)
			end,
		},
	})
	self:linkToElementModel(self, "health.healthValue", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "health.healthValue",
		})
	end)
	self.__on_menuOpened_self = function(f5_arg0, f5_arg1, f5_arg2, f5_arg3)
		local f5_local0 = self
		CoD.CodCasterUtility.ScoreByGametypeInit(self.PlayerListEntryObjective)
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
CoD.CodCasterPortraitPlayerListEntryExtra.__resetProperties = function(f7_arg0)
	f7_arg0.PlayerListEntryKillIcon:completeAnimation()
	f7_arg0.PlayerListEntryDeathIcon:completeAnimation()
	f7_arg0.PlayerListEntryStreakIcon:completeAnimation()
	f7_arg0.PlayerListEntryObjectiveIcon2:completeAnimation()
	f7_arg0.PlayerListEntryObjectiveIcon:completeAnimation()
	f7_arg0.PlayerListEntryKD:completeAnimation()
	f7_arg0.PlayerListEntryStreak:completeAnimation()
	f7_arg0.PlayerListEntryObjective:completeAnimation()
	f7_arg0.PlayerListEntryKillIcon:setAlpha(1)
	f7_arg0.PlayerListEntryDeathIcon:setAlpha(1)
	f7_arg0.PlayerListEntryStreakIcon:setAlpha(1)
	f7_arg0.PlayerListEntryObjectiveIcon2:setAlpha(1)
	f7_arg0.PlayerListEntryObjectiveIcon:setAlpha(1)
	f7_arg0.PlayerListEntryKD:setAlpha(1)
	f7_arg0.PlayerListEntryStreak:setAlpha(1)
	f7_arg0.PlayerListEntryObjective:setAlpha(1)
end
CoD.CodCasterPortraitPlayerListEntryExtra.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	PlayerDead = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(8)
			f9_arg0.PlayerListEntryStreak:completeAnimation()
			f9_arg0.PlayerListEntryStreak:setAlpha(0.03)
			f9_arg0.clipFinished(f9_arg0.PlayerListEntryStreak)
			f9_arg0.PlayerListEntryKD:completeAnimation()
			f9_arg0.PlayerListEntryKD:setAlpha(0.03)
			f9_arg0.clipFinished(f9_arg0.PlayerListEntryKD)
			f9_arg0.PlayerListEntryObjective:completeAnimation()
			f9_arg0.PlayerListEntryObjective:setAlpha(0.03)
			f9_arg0.clipFinished(f9_arg0.PlayerListEntryObjective)
			f9_arg0.PlayerListEntryKillIcon:completeAnimation()
			f9_arg0.PlayerListEntryKillIcon:setAlpha(0.03)
			f9_arg0.clipFinished(f9_arg0.PlayerListEntryKillIcon)
			f9_arg0.PlayerListEntryDeathIcon:completeAnimation()
			f9_arg0.PlayerListEntryDeathIcon:setAlpha(0.03)
			f9_arg0.clipFinished(f9_arg0.PlayerListEntryDeathIcon)
			f9_arg0.PlayerListEntryStreakIcon:completeAnimation()
			f9_arg0.PlayerListEntryStreakIcon:setAlpha(0.03)
			f9_arg0.clipFinished(f9_arg0.PlayerListEntryStreakIcon)
			f9_arg0.PlayerListEntryObjectiveIcon:completeAnimation()
			f9_arg0.PlayerListEntryObjectiveIcon:setAlpha(0.03)
			f9_arg0.clipFinished(f9_arg0.PlayerListEntryObjectiveIcon)
			f9_arg0.PlayerListEntryObjectiveIcon2:completeAnimation()
			f9_arg0.PlayerListEntryObjectiveIcon2:setAlpha(0.03)
			f9_arg0.clipFinished(f9_arg0.PlayerListEntryObjectiveIcon2)
		end,
	},
}
CoD.CodCasterPortraitPlayerListEntryExtra.__onClose = function(f10_arg0)
	f10_arg0.__on_close_removeOverrides()
	f10_arg0.PlayerListEntryObjective:close()
end
