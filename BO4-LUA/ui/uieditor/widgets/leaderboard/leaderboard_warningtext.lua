local PostLoadFunc = function(self, controller, menu)
	local f1_local0 = DataSources.LeaderboardRows.getModel(controller)
	if not f1_local0 then
		return
	else
		self:subscribeToModel(f1_local0.status, function(model)
			local f2_local0 = CoD.perController[controller].leaderboardDurationFilter
			if not f2_local0 then
				f2_local0 = Enum[0x4AA9747C7FD29AA][0x55ACA16E2268D1A]
			end
			local f2_local1 = LuaEnum.LB_MP_GAMES_NEEDED.WEEKLY
			if f2_local0 == Enum[0x4AA9747C7FD29AA][0x55ACA16E2268D1A] then
				f2_local1 = LuaEnum.LB_MP_GAMES_NEEDED.ALLTIME
			elseif f2_local0 == Enum[0x4AA9747C7FD29AA][0x4ADDC81D8048FD] then
				f2_local1 = LuaEnum.LB_MP_GAMES_NEEDED.MONTHLY
			end
			self.Text:setText(Engine[0xF9F1239CFD921FE](0x33467BF1A6467C2, f2_local1))
		end)
	end
end
CoD.Leaderboard_WarningText = InheritFrom(LUI.UIElement)
CoD.Leaderboard_WarningText.__defaultWidth = 666
CoD.Leaderboard_WarningText.__defaultHeight = 54
CoD.Leaderboard_WarningText.new = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4, f3_arg5, f3_arg6, f3_arg7, f3_arg8, f3_arg9)
	local self = LUI.UIElement.new(f3_arg2, f3_arg3, f3_arg4, f3_arg5, f3_arg6, f3_arg7, f3_arg8, f3_arg9)
	self:setClass(CoD.Leaderboard_WarningText)
	self.id = "Leaderboard_WarningText"
	self.soundSet = "default"
	f3_arg0:addElementToPendingUpdateStateList(self)
	local Text = LUI.UIText.new(1, 1, -666, -51, 1, 1, -45, -15)
	Text:setRGB(1, 0.4, 0)
	Text:setText("")
	Text:setTTF("default")
	Text:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	Text:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Text)
	self.Text = Text
	if PostLoadFunc then
		PostLoadFunc(self, f3_arg1, f3_arg0)
	end
	return self
end
CoD.Leaderboard_WarningText.__resetProperties = function(f4_arg0)
	f4_arg0.Text:completeAnimation()
	f4_arg0.Text:setAlpha(1)
end
CoD.Leaderboard_WarningText.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	Visible = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Text:completeAnimation()
			f7_arg0.Text:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Text)
		end,
	},
}
