require("x64:9f606d91eab9f64")
require("x64:acbf06924421e35")
CoD.ArenaDailyBonus = InheritFrom(LUI.UIElement)
CoD.ArenaDailyBonus.__defaultWidth = 200
CoD.ArenaDailyBonus.__defaultHeight = 70
CoD.ArenaDailyBonus.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaDailyBonus)
	self.id = "ArenaDailyBonus"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	bg:setRGB(0, 0, 0)
	bg:setAlpha(0.5)
	self:addElement(bg)
	self.bg = bg
	local CommonCornerPips = CoD.CommonCornerPips01.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(CommonCornerPips)
	self.CommonCornerPips = CommonCornerPips
	local RemainingTime = CoD.ArenaEventTimer.new(f1_arg0, f1_arg1, 0, 0, 0, 260, 0, 0, -14, 0)
	RemainingTime:mergeStateConditions({
		{
			stateName = "Event",
			condition = function(menu, element, event)
				local f2_local0 = CoD.ArenaUtility.CurrentArenaEventTypeEquals(self, Enum[@"hash_6C0EA92D04BC003B"][@"hash_5C32571741C5B730"])
				if f2_local0 then
					f2_local0 = CoD.ArenaLeaguePlayUtility.HasOneMatchPlayed(self, f1_arg1)
					if f2_local0 then
						f2_local0 = CoD.ArenaUtility.IsDailyPoolRemainingCompleteTimer(self, f1_arg1, element)
					end
				end
				return f2_local0
			end,
		},
	})
	local bonusnumber = RemainingTime
	local bonustext = RemainingTime.subscribeToModel
	local f1_local6 = Engine[@"getglobalmodel"]()
	bonustext(bonusnumber, f1_local6["lobbyPlaylist.name"], function(f3_arg0)
		f1_arg0:updateElementState(RemainingTime, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyPlaylist.name",
		})
	end, false)
	bonusnumber = RemainingTime
	bonustext = RemainingTime.subscribeToModel
	f1_local6 = Engine[@"getglobalmodel"]()
	bonustext(bonusnumber, f1_local6["lobbyRoot.lobbyNav"], function(f4_arg0)
		f1_arg0:updateElementState(RemainingTime, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	bonusnumber = RemainingTime
	bonustext = RemainingTime.subscribeToModel
	f1_local6 = Engine[@"getglobalmodel"]()
	bonustext(bonusnumber, f1_local6["LeaguePlayLadder.entityLadderRank"], function(f5_arg0)
		f1_arg0:updateElementState(RemainingTime, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "LeaguePlayLadder.entityLadderRank",
		})
	end, false)
	RemainingTime.EventEndsIn:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	RemainingTime:subscribeToGlobalModel(f1_arg1, "Arena", "arenaLeaguePlayDailyPoolTimer", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			RemainingTime.EventEndsIn:setText(f6_local0)
		end
	end)
	self:addElement(RemainingTime)
	self.RemainingTime = RemainingTime
	bonustext = LUI.UIText.new(0.5, 0.5, -100, 100, 0, 0, 43, 67)
	bonustext:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	bonustext:setText(LocalizeToUpperString(@"hash_4F15E6BF954D13D8"))
	bonustext:setTTF("ttmussels_regular")
	bonustext:setLetterSpacing(3)
	bonustext:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	bonustext:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(bonustext)
	self.bonustext = bonustext
	bonusnumber = LUI.UIText.new(0.5, 0.5, -100, 100, 0, 0, 2, 51)
	bonusnumber:setRGB(ColorSet.WarzoneTeammate3.r, ColorSet.WarzoneTeammate3.g, ColorSet.WarzoneTeammate3.b)
	bonusnumber:setTTF("0arame_mono_stencil")
	bonusnumber:setLetterSpacing(2)
	bonusnumber:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	bonusnumber:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	bonusnumber:subscribeToGlobalModel(f1_arg1, "LeaguePlay", "dailyBonusPool", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			bonusnumber:setText(f7_local0)
		end
	end)
	self:addElement(bonusnumber)
	self.bonusnumber = bonusnumber
	self:mergeStateConditions({
		{
			stateName = "LeaguePlay",
			condition = function(menu, element, event)
				return CoD.ArenaUtility.CurrentArenaEventTypeEquals(self, Enum[@"hash_6C0EA92D04BC003B"][@"hash_5C32571741C5B730"]) and CoD.ArenaLeaguePlayUtility.HasOneMatchPlayed(self, f1_arg1)
			end,
		},
	})
	local f1_local7 = self
	f1_local6 = self.subscribeToModel
	local f1_local8 = Engine[@"getglobalmodel"]()
	f1_local6(f1_local7, f1_local8["lobbyPlaylist.name"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "lobbyPlaylist.name",
		})
	end, false)
	f1_local7 = self
	f1_local6 = self.subscribeToModel
	f1_local8 = Engine[@"getglobalmodel"]()
	f1_local6(f1_local7, f1_local8["lobbyRoot.lobbyNav"], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local7 = self
	f1_local6 = self.subscribeToModel
	f1_local8 = Engine[@"getglobalmodel"]()
	f1_local6(f1_local7, f1_local8["LeaguePlayLadder.entityLadderRank"], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "LeaguePlayLadder.entityLadderRank",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaDailyBonus.__resetProperties = function(f12_arg0)
	f12_arg0.bonusnumber:completeAnimation()
	f12_arg0.bonustext:completeAnimation()
	f12_arg0.RemainingTime:completeAnimation()
	f12_arg0.CommonCornerPips:completeAnimation()
	f12_arg0.bg:completeAnimation()
	f12_arg0.bonusnumber:setAlpha(1)
	f12_arg0.bonustext:setAlpha(1)
	f12_arg0.RemainingTime:setLeftRight(0, 0, 0, 260)
	f12_arg0.RemainingTime:setTopBottom(0, 0, -14, 0)
	f12_arg0.RemainingTime:setAlpha(1)
	f12_arg0.CommonCornerPips:setAlpha(1)
	f12_arg0.bg:setAlpha(0.5)
end
CoD.ArenaDailyBonus.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(5)
			f13_arg0.bg:completeAnimation()
			f13_arg0.bg:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.bg)
			f13_arg0.CommonCornerPips:completeAnimation()
			f13_arg0.CommonCornerPips:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.CommonCornerPips)
			f13_arg0.RemainingTime:completeAnimation()
			f13_arg0.RemainingTime:setLeftRight(0, 1, 0, 0)
			f13_arg0.RemainingTime:setTopBottom(0, 0, -22, -8)
			f13_arg0.RemainingTime:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.RemainingTime)
			f13_arg0.bonustext:completeAnimation()
			f13_arg0.bonustext:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.bonustext)
			f13_arg0.bonusnumber:completeAnimation()
			f13_arg0.bonusnumber:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.bonusnumber)
		end,
	},
	LeaguePlay = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.RemainingTime:completeAnimation()
			f14_arg0.RemainingTime:setTopBottom(0, 0, -19, -5)
			f14_arg0.clipFinished(f14_arg0.RemainingTime)
		end,
	},
}
CoD.ArenaDailyBonus.__onClose = function(f15_arg0)
	f15_arg0.CommonCornerPips:close()
	f15_arg0.RemainingTime:close()
	f15_arg0.bonusnumber:close()
end
