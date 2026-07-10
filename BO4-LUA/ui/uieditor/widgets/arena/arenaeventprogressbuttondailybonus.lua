require("x64:bceefc58a6d5969")
require("x64:c61bd4bc39f552b")
CoD.ArenaEventProgressButtonDailyBonus = InheritFrom(LUI.UIElement)
CoD.ArenaEventProgressButtonDailyBonus.__defaultWidth = 144
CoD.ArenaEventProgressButtonDailyBonus.__defaultHeight = 70
CoD.ArenaEventProgressButtonDailyBonus.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaEventProgressButtonDailyBonus)
	self.id = "ArenaEventProgressButtonDailyBonus"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DailyBonusNoise = LUI.UIImage.new(0, 0, 0, 140, 0.09, 0.09, -2, 60)
	DailyBonusNoise:setAlpha(0)
	DailyBonusNoise:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	DailyBonusNoise:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	DailyBonusNoise:setShaderVector(0, 0, 0, 0, 0)
	DailyBonusNoise:setupNineSliceShader(196, 88)
	self:addElement(DailyBonusNoise)
	self.DailyBonusNoise = DailyBonusNoise
	local DailyBonusBg = LUI.UIImage.new(0, 0, 0, 140, 0.5, 0.5, -31, 31)
	DailyBonusBg:setRGB(0.67, 0.81, 0.15)
	DailyBonusBg:setAlpha(0)
	self:addElement(DailyBonusBg)
	self.DailyBonusBg = DailyBonusBg
	local DailyBonusArrow = LUI.UIImage.new(0, 0, 1, 9, 0, 0, 27, 43)
	DailyBonusArrow:setRGB(0.55, 0.77, 0.26)
	DailyBonusArrow:setAlpha(0)
	DailyBonusArrow:setImage(RegisterImage(@"uie_ui_hud_common_triangle"))
	self:addElement(DailyBonusArrow)
	self.DailyBonusArrow = DailyBonusArrow
	local DailyBonusBar = LUI.UIImage.new(0, 0, 0, 2, 0, 0, 4, 66)
	DailyBonusBar:setRGB(0.55, 0.77, 0.26)
	DailyBonusBar:setAlpha(0)
	self:addElement(DailyBonusBar)
	self.DailyBonusBar = DailyBonusBar
	local DailyBonusLabel = CoD.ArenaDailyBonusLabel.new(f1_arg0, f1_arg1, 0, 0, 4.5, 137.5, 0, 0, 48.5, 64.5)
	DailyBonusLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	DailyBonusLabel:setAlpha(0)
	DailyBonusLabel.DailyBonusLabel:setText(LocalizeToUpperString(@"hash_1193C2AA115E0307"))
	self:addElement(DailyBonusLabel)
	self.DailyBonusLabel = DailyBonusLabel
	local DailyBonus = LUI.UIText.new(0, 0, 10, 136, 0, 0, 11.5, 48.5)
	DailyBonus:setRGB(ColorSet.SelectedGreen.r, ColorSet.SelectedGreen.g, ColorSet.SelectedGreen.b)
	DailyBonus:setAlpha(0)
	DailyBonus:setTTF("0arame_mono_stencil")
	DailyBonus:setLetterSpacing(2)
	DailyBonus:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	DailyBonus:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	DailyBonus:subscribeToGlobalModel(f1_arg1, "LeaguePlay", "dailyBonusPool", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			DailyBonus:setText(f2_local0)
		end
	end)
	self:addElement(DailyBonus)
	self.DailyBonus = DailyBonus
	local DailyBonusAdd = LUI.UIText.new(0, 0, 10, 136, 0, 0, 11.5, 48.5)
	DailyBonusAdd:setRGB(ColorSet.SelectedGreen.r, ColorSet.SelectedGreen.g, ColorSet.SelectedGreen.b)
	DailyBonusAdd:setAlpha(0)
	DailyBonusAdd:setTTF("0arame_mono_stencil")
	DailyBonusAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_3336C1AE82B1520A"))
	DailyBonusAdd:setLetterSpacing(2)
	DailyBonusAdd:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	DailyBonusAdd:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	DailyBonusAdd:subscribeToGlobalModel(f1_arg1, "LeaguePlay", "dailyBonusPool", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			DailyBonusAdd:setText(f3_local0)
		end
	end)
	self:addElement(DailyBonusAdd)
	self.DailyBonusAdd = DailyBonusAdd
	local TimerHeader = LUI.UIText.new(0, 0, 5, 141, 0, 0, 12, 30)
	TimerHeader:setAlpha(0)
	TimerHeader:setText(LocalizeToUpperString(@"hash_633F6B8CAEF2F672"))
	TimerHeader:setTTF("ttmussels_regular")
	TimerHeader:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TimerHeader:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(TimerHeader)
	self.TimerHeader = TimerHeader
	local OverlayPattern = LUI.UIImage.new(0.5, 0.5, -67.5, 69.5, 0.5, 0.5, -30, 30)
	OverlayPattern:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	OverlayPattern:setAlpha(0)
	OverlayPattern:setImage(RegisterImage(@"hash_7FC21A8215EA012B"))
	OverlayPattern:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	OverlayPattern:setShaderVector(0, 0, 0, 0, 0)
	OverlayPattern:setupNineSliceShader(4, 4)
	self:addElement(OverlayPattern)
	self.OverlayPattern = OverlayPattern
	local ArenaEventTimerSmall = CoD.ArenaEventTimerSmall.new(f1_arg0, f1_arg1, 0.5, 0.5, -73, 67, 0, 0, 48, 62)
	ArenaEventTimerSmall:mergeStateConditions({
		{
			stateName = "Event",
			condition = function(menu, element, event)
				local f4_local0 = CoD.ArenaUtility.CurrentArenaEventTypeEquals(self, Enum[@"hash_6C0EA92D04BC003B"][@"hash_5C32571741C5B730"])
				if f4_local0 then
					f4_local0 = CoD.ArenaLeaguePlayUtility.HasOneMatchPlayed(self, f1_arg1)
					if f4_local0 then
						f4_local0 = CoD.ArenaUtility.IsDailyPoolRemainingCompleteTimer(self, f1_arg1, element)
					end
				end
				return f4_local0
			end,
		},
	})
	local f1_local11 = ArenaEventTimerSmall
	local ArenaDailyBonusLabel = ArenaEventTimerSmall.subscribeToModel
	local f1_local13 = Engine[@"getglobalmodel"]()
	ArenaDailyBonusLabel(f1_local11, f1_local13["lobbyPlaylist.name"], function(f5_arg0)
		f1_arg0:updateElementState(ArenaEventTimerSmall, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyPlaylist.name",
		})
	end, false)
	f1_local11 = ArenaEventTimerSmall
	ArenaDailyBonusLabel = ArenaEventTimerSmall.subscribeToModel
	f1_local13 = Engine[@"getglobalmodel"]()
	ArenaDailyBonusLabel(f1_local11, f1_local13["lobbyRoot.lobbyNav"], function(f6_arg0)
		f1_arg0:updateElementState(ArenaEventTimerSmall, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local11 = ArenaEventTimerSmall
	ArenaDailyBonusLabel = ArenaEventTimerSmall.subscribeToModel
	f1_local13 = Engine[@"getglobalmodel"]()
	ArenaDailyBonusLabel(f1_local11, f1_local13["LeaguePlayLadder.entityLadderRank"], function(f7_arg0)
		f1_arg0:updateElementState(ArenaEventTimerSmall, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "LeaguePlayLadder.entityLadderRank",
		})
	end, false)
	ArenaEventTimerSmall:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	ArenaEventTimerSmall:setAlpha(0)
	ArenaEventTimerSmall:subscribeToGlobalModel(f1_arg1, "Arena", "arenaLeaguePlayDailyPoolTimer", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			ArenaEventTimerSmall.EventEndsIn.EventEndsIn:setText(f8_local0)
		end
	end)
	self:addElement(ArenaEventTimerSmall)
	self.ArenaEventTimerSmall = ArenaEventTimerSmall
	ArenaDailyBonusLabel = CoD.ArenaDailyBonusLabel.new(f1_arg0, f1_arg1, 0, 0, 5, 141, 0, 0, 12, 30)
	ArenaDailyBonusLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ArenaDailyBonusLabel:setAlpha(0)
	ArenaDailyBonusLabel.DailyBonusLabel:setText(LocalizeToUpperString(@"hash_633F6B8CAEF2F672"))
	self:addElement(ArenaDailyBonusLabel)
	self.ArenaDailyBonusLabel = ArenaDailyBonusLabel
	self:mergeStateConditions({
		{
			stateName = "DailyBonusAvailable",
			condition = function(menu, element, event)
				local f9_local0 = CoD.ArenaUtility.CurrentArenaEventTypeEquals(self, Enum[@"hash_6C0EA92D04BC003B"][@"hash_5C32571741C5B730"])
				if f9_local0 then
					f9_local0 = CoD.ArenaLeaguePlayUtility.HasOneMatchPlayed(self, f1_arg1)
					if f9_local0 then
						f9_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "LeaguePlay", "dailyBonusPool", 0)
					end
				end
				return f9_local0
			end,
		},
		{
			stateName = "DailyBonusDepleted",
			condition = function(menu, element, event)
				return CoD.ArenaUtility.CurrentArenaEventTypeEquals(self, Enum[@"hash_6C0EA92D04BC003B"][@"hash_5C32571741C5B730"]) and not CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "LeaguePlay", "dailyBonusPool", 0)
			end,
		},
	})
	f1_local13 = self
	f1_local11 = self.subscribeToModel
	local f1_local14 = Engine[@"getglobalmodel"]()
	f1_local11(f1_local13, f1_local14["lobbyPlaylist.name"], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "lobbyPlaylist.name",
		})
	end, false)
	f1_local13 = self
	f1_local11 = self.subscribeToModel
	f1_local14 = Engine[@"getglobalmodel"]()
	f1_local11(f1_local13, f1_local14["lobbyRoot.lobbyNav"], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local13 = self
	f1_local11 = self.subscribeToModel
	f1_local14 = Engine[@"getglobalmodel"]()
	f1_local11(f1_local13, f1_local14["LeaguePlayLadder.entityLadderRank"], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "LeaguePlayLadder.entityLadderRank",
		})
	end, false)
	f1_local13 = self
	f1_local11 = self.subscribeToModel
	f1_local14 = DataSources.LeaguePlay.getModel(f1_arg1)
	f1_local11(f1_local13, f1_local14.dailyBonusPool, function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "dailyBonusPool",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaEventProgressButtonDailyBonus.__resetProperties = function(f15_arg0)
	f15_arg0.DailyBonusAdd:completeAnimation()
	f15_arg0.DailyBonus:completeAnimation()
	f15_arg0.DailyBonusBar:completeAnimation()
	f15_arg0.DailyBonusArrow:completeAnimation()
	f15_arg0.DailyBonusBg:completeAnimation()
	f15_arg0.DailyBonusNoise:completeAnimation()
	f15_arg0.OverlayPattern:completeAnimation()
	f15_arg0.DailyBonusLabel:completeAnimation()
	f15_arg0.ArenaEventTimerSmall:completeAnimation()
	f15_arg0.TimerHeader:completeAnimation()
	f15_arg0.ArenaDailyBonusLabel:completeAnimation()
	f15_arg0.DailyBonusAdd:setAlpha(0)
	f15_arg0.DailyBonus:setAlpha(0)
	f15_arg0.DailyBonusBar:setRGB(0.55, 0.77, 0.26)
	f15_arg0.DailyBonusBar:setAlpha(0)
	f15_arg0.DailyBonusArrow:setAlpha(0)
	f15_arg0.DailyBonusBg:setRGB(0.67, 0.81, 0.15)
	f15_arg0.DailyBonusBg:setAlpha(0)
	f15_arg0.DailyBonusNoise:setAlpha(0)
	f15_arg0.OverlayPattern:setAlpha(0)
	f15_arg0.DailyBonusLabel:setAlpha(0)
	f15_arg0.ArenaEventTimerSmall:setAlpha(0)
	f15_arg0.TimerHeader:setAlpha(0)
	f15_arg0.ArenaDailyBonusLabel:setAlpha(0)
end
CoD.ArenaEventProgressButtonDailyBonus.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
	},
	DailyBonusAvailable = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(9)
			f17_arg0.DailyBonusNoise:completeAnimation()
			f17_arg0.DailyBonusNoise:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.DailyBonusNoise)
			f17_arg0.DailyBonusBg:completeAnimation()
			f17_arg0.DailyBonusBg:setAlpha(0.15)
			f17_arg0.clipFinished(f17_arg0.DailyBonusBg)
			f17_arg0.DailyBonusArrow:completeAnimation()
			f17_arg0.DailyBonusArrow:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.DailyBonusArrow)
			f17_arg0.DailyBonusBar:completeAnimation()
			f17_arg0.DailyBonusBar:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.DailyBonusBar)
			f17_arg0.DailyBonusLabel:completeAnimation()
			f17_arg0.DailyBonusLabel:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.DailyBonusLabel)
			f17_arg0.DailyBonus:completeAnimation()
			f17_arg0.DailyBonus:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.DailyBonus)
			f17_arg0.DailyBonusAdd:completeAnimation()
			f17_arg0.DailyBonusAdd:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.DailyBonusAdd)
			f17_arg0.OverlayPattern:completeAnimation()
			f17_arg0.OverlayPattern:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.OverlayPattern)
			f17_arg0.ArenaEventTimerSmall:completeAnimation()
			f17_arg0.ArenaEventTimerSmall:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.ArenaEventTimerSmall)
		end,
	},
	DailyBonusDepleted = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(8)
			f18_arg0.DailyBonusNoise:completeAnimation()
			f18_arg0.DailyBonusNoise:setAlpha(0.5)
			f18_arg0.clipFinished(f18_arg0.DailyBonusNoise)
			f18_arg0.DailyBonusBg:completeAnimation()
			f18_arg0.DailyBonusBg:setRGB(0, 0, 0)
			f18_arg0.DailyBonusBg:setAlpha(0.1)
			f18_arg0.clipFinished(f18_arg0.DailyBonusBg)
			f18_arg0.DailyBonusArrow:completeAnimation()
			f18_arg0.DailyBonusArrow:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.DailyBonusArrow)
			f18_arg0.DailyBonusBar:completeAnimation()
			f18_arg0.DailyBonusBar:setRGB(1, 1, 1)
			f18_arg0.DailyBonusBar:setAlpha(0.05)
			f18_arg0.clipFinished(f18_arg0.DailyBonusBar)
			f18_arg0.TimerHeader:completeAnimation()
			f18_arg0.TimerHeader:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.TimerHeader)
			f18_arg0.OverlayPattern:completeAnimation()
			f18_arg0.OverlayPattern:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.OverlayPattern)
			f18_arg0.ArenaEventTimerSmall:completeAnimation()
			f18_arg0.ArenaEventTimerSmall:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.ArenaEventTimerSmall)
			f18_arg0.ArenaDailyBonusLabel:completeAnimation()
			f18_arg0.ArenaDailyBonusLabel:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.ArenaDailyBonusLabel)
		end,
	},
}
CoD.ArenaEventProgressButtonDailyBonus.__onClose = function(f19_arg0)
	f19_arg0.DailyBonusLabel:close()
	f19_arg0.DailyBonus:close()
	f19_arg0.DailyBonusAdd:close()
	f19_arg0.ArenaEventTimerSmall:close()
	f19_arg0.ArenaDailyBonusLabel:close()
end
