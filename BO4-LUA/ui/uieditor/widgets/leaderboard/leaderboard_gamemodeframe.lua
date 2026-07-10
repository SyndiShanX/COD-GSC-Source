require("x64:73ce00d1c7db4c5")
require("x64:3efa1e5ed22d588")
require("x64:eee4585000005bc")
CoD.Leaderboard_GameModeFrame = InheritFrom(LUI.UIElement)
CoD.Leaderboard_GameModeFrame.__defaultWidth = 1610
CoD.Leaderboard_GameModeFrame.__defaultHeight = 780
CoD.Leaderboard_GameModeFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Leaderboard_GameModeFrame)
	self.id = "Leaderboard_GameModeFrame"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Leaderboard = CoD.Leaderboard.new(f1_arg0, f1_arg1, 0, 0, 31, 1201, 0, 0, 0, 757)
	Leaderboard.LeaderboardEmptyText:setText(Engine[0xF9F1239CFD921FE](0x297DDF6F8B1ABCF))
	Leaderboard:subscribeToGlobalModel(f1_arg1, "LeaderboardHeader", nil, function(model)
		Leaderboard.LeaderboardHeader:setModel(model, f1_arg1)
	end)
	self:addElement(Leaderboard)
	self.Leaderboard = Leaderboard
	local PlayerProfileInfoWidget = CoD.Leaderboard_PlayerProfileInfoWidget.new(f1_arg0, f1_arg1, 0, 0, 1219, 1579, 0, 0, 0, 490)
	PlayerProfileInfoWidget:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "PCacheBuffer",
			condition = function(menu, element, event)
				local f4_local0
				if not CoD.LeaderboardUtility.IsLeaderboardUpdating() then
					f4_local0 = not CoD.LeaderboardUtility.IsLeaderboardEmpty()
				else
					f4_local0 = false
				end
				return f4_local0
			end,
		},
	})
	local f1_local3 = PlayerProfileInfoWidget
	local RankAndStatsWidget = PlayerProfileInfoWidget.subscribeToModel
	local f1_local5 = DataSources.LeaderboardRows.getModel(f1_arg1)
	RankAndStatsWidget(f1_local3, f1_local5.status, function(f5_arg0)
		f1_arg0:updateElementState(PlayerProfileInfoWidget, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "status",
		})
	end, false)
	f1_local3 = PlayerProfileInfoWidget
	RankAndStatsWidget = PlayerProfileInfoWidget.subscribeToModel
	f1_local5 = DataSources.LeaderboardRows.getModel(f1_arg1)
	RankAndStatsWidget(f1_local3, f1_local5.totalCount, function(f6_arg0)
		f1_arg0:updateElementState(PlayerProfileInfoWidget, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "totalCount",
		})
	end, false)
	PlayerProfileInfoWidget:linkToElementModel(self, "xuid", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			PlayerProfileInfoWidget.emblem:setupPlayerEmblemByXUID(f7_local0)
		end
	end)
	PlayerProfileInfoWidget:linkToElementModel(self, nil, false, function(model)
		PlayerProfileInfoWidget.GamerCard:setModel(model, f1_arg1)
	end)
	self:addElement(PlayerProfileInfoWidget)
	self.PlayerProfileInfoWidget = PlayerProfileInfoWidget
	RankAndStatsWidget = CoD.Leaderboard_RankAndStatsWidget.new(f1_arg0, f1_arg1, 0, 0, 1219, 1579, 0, 0, 495, 795)
	RankAndStatsWidget:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f9_local0
				if not CoD.LeaderboardUtility.IsLeaderboardUpdating() then
					f9_local0 = not CoD.LeaderboardUtility.IsLeaderboardEmpty()
				else
					f9_local0 = false
				end
				return f9_local0
			end,
		},
	})
	f1_local5 = RankAndStatsWidget
	f1_local3 = RankAndStatsWidget.subscribeToModel
	local f1_local6 = DataSources.LeaderboardRows.getModel(f1_arg1)
	f1_local3(f1_local5, f1_local6.status, function(f10_arg0)
		f1_arg0:updateElementState(RankAndStatsWidget, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "status",
		})
	end, false)
	f1_local5 = RankAndStatsWidget
	f1_local3 = RankAndStatsWidget.subscribeToModel
	f1_local6 = DataSources.LeaderboardRows.getModel(f1_arg1)
	f1_local3(f1_local5, f1_local6.totalCount, function(f11_arg0)
		f1_arg0:updateElementState(RankAndStatsWidget, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "totalCount",
		})
	end, false)
	self:addElement(RankAndStatsWidget)
	self.RankAndStatsWidget = RankAndStatsWidget
	PlayerProfileInfoWidget:linkToElementModel(Leaderboard.LeaderboardRows, nil, false, function(model)
		PlayerProfileInfoWidget:setModel(model, f1_arg1)
	end)
	RankAndStatsWidget:linkToElementModel(Leaderboard.LeaderboardRows, "rankIcon", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			RankAndStatsWidget.rankIcon.imgSolid:setImage(RegisterImage(GetRankIconLarge(f13_local0)))
		end
	end)
	RankAndStatsWidget:linkToElementModel(Leaderboard.LeaderboardRows, "rankIcon", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			RankAndStatsWidget.rankIcon.imgAdd:setImage(RegisterImage(GetRankIconLarge(f14_local0)))
		end
	end)
	RankAndStatsWidget:linkToElementModel(Leaderboard.LeaderboardRows, "plevel", true, function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			RankAndStatsWidget.rankText:setRGB(SetToParagonColorIfPrestigeMasterForLeaderboard(255, 255, 255, f15_local0))
		end
	end)
	RankAndStatsWidget:linkToElementModel(Leaderboard.LeaderboardRows, "rank", true, function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			RankAndStatsWidget.rankText.FELabelSubHeadingD0.Label0:setText(CoD.BaseUtility.AlreadyLocalized(PrependLevelTypeStringWithSeparator(" ", f16_local0)))
		end
	end)
	RankAndStatsWidget:linkToElementModel(Leaderboard.LeaderboardRows, "rankString", true, function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			RankAndStatsWidget.ListHeader0:setAlpha(HideIfEmptyString(f17_local0))
		end
	end)
	RankAndStatsWidget:linkToElementModel(Leaderboard.LeaderboardRows, "stat0color", true, function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			RankAndStatsWidget.StatWidget1.StatText:setRGB(f18_local0)
		end
	end)
	RankAndStatsWidget:linkToElementModel(Leaderboard.LeaderboardRows, "stat0", true, function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			RankAndStatsWidget.StatWidget1.StatText:setText(f19_local0)
		end
	end)
	RankAndStatsWidget:linkToElementModel(Leaderboard.LeaderboardRows, "stat0label", true, function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			RankAndStatsWidget.StatWidget1.btnDisplayTextStroke:setText(Engine[0xF9F1239CFD921FE](f20_local0))
		end
	end)
	RankAndStatsWidget:linkToElementModel(Leaderboard.LeaderboardRows, "stat1color", true, function(model)
		local f21_local0 = model:get()
		if f21_local0 ~= nil then
			RankAndStatsWidget.StatWidget2.StatText:setRGB(f21_local0)
		end
	end)
	RankAndStatsWidget:linkToElementModel(Leaderboard.LeaderboardRows, "stat1", true, function(model)
		local f22_local0 = model:get()
		if f22_local0 ~= nil then
			RankAndStatsWidget.StatWidget2.StatText:setText(f22_local0)
		end
	end)
	RankAndStatsWidget:linkToElementModel(Leaderboard.LeaderboardRows, "stat1label", true, function(model)
		local f23_local0 = model:get()
		if f23_local0 ~= nil then
			RankAndStatsWidget.StatWidget2.btnDisplayTextStroke:setText(Engine[0xF9F1239CFD921FE](f23_local0))
		end
	end)
	RankAndStatsWidget:linkToElementModel(Leaderboard.LeaderboardRows, "stat2color", true, function(model)
		local f24_local0 = model:get()
		if f24_local0 ~= nil then
			RankAndStatsWidget.StatWidget3.StatText:setRGB(f24_local0)
		end
	end)
	RankAndStatsWidget:linkToElementModel(Leaderboard.LeaderboardRows, "stat2", true, function(model)
		local f25_local0 = model:get()
		if f25_local0 ~= nil then
			RankAndStatsWidget.StatWidget3.StatText:setText(f25_local0)
		end
	end)
	RankAndStatsWidget:linkToElementModel(Leaderboard.LeaderboardRows, "stat2label", true, function(model)
		local f26_local0 = model:get()
		if f26_local0 ~= nil then
			RankAndStatsWidget.StatWidget3.btnDisplayTextStroke:setText(Engine[0xF9F1239CFD921FE](f26_local0))
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "ShowInfo",
			condition = function(menu, element, event)
				local f27_local0
				if not CoD.LeaderboardUtility.IsLeaderboardUpdating() then
					f27_local0 = not CoD.LeaderboardUtility.IsLeaderboardEmpty()
				else
					f27_local0 = false
				end
				return f27_local0
			end,
		},
	})
	f1_local5 = self
	f1_local3 = self.subscribeToModel
	f1_local6 = DataSources.LeaderboardRows.getModel(f1_arg1)
	f1_local3(f1_local5, f1_local6.status, function(f28_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "status",
		})
	end, false)
	f1_local5 = self
	f1_local3 = self.subscribeToModel
	f1_local6 = DataSources.LeaderboardRows.getModel(f1_arg1)
	f1_local3(f1_local5, f1_local6.totalCount, function(f29_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f29_arg0:get(),
			modelName = "totalCount",
		})
	end, false)
	Leaderboard.id = "Leaderboard"
	PlayerProfileInfoWidget.id = "PlayerProfileInfoWidget"
	self.__defaultFocus = Leaderboard
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Leaderboard_GameModeFrame.__resetProperties = function(f30_arg0)
	f30_arg0.RankAndStatsWidget:completeAnimation()
	f30_arg0.PlayerProfileInfoWidget:completeAnimation()
	f30_arg0.RankAndStatsWidget:setAlpha(1)
	f30_arg0.PlayerProfileInfoWidget:setAlpha(1)
end
CoD.Leaderboard_GameModeFrame.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(2)
			f31_arg0.PlayerProfileInfoWidget:completeAnimation()
			f31_arg0.PlayerProfileInfoWidget:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.PlayerProfileInfoWidget)
			f31_arg0.RankAndStatsWidget:completeAnimation()
			f31_arg0.RankAndStatsWidget:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.RankAndStatsWidget)
		end,
	},
	ShowInfo = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.Leaderboard_GameModeFrame.__onClose = function(f33_arg0)
	f33_arg0.PlayerProfileInfoWidget:close()
	f33_arg0.RankAndStatsWidget:close()
	f33_arg0.Leaderboard:close()
end
