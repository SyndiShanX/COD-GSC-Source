CoD.ArenaKillcamAttackerRank = InheritFrom(LUI.UIElement)
CoD.ArenaKillcamAttackerRank.__defaultWidth = 147
CoD.ArenaKillcamAttackerRank.__defaultHeight = 40
CoD.ArenaKillcamAttackerRank.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaKillcamAttackerRank)
	self.id = "ArenaKillcamAttackerRank"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0.06, 0.06, 0.06)
	Backing:setAlpha(0.8)
	self:addElement(Backing)
	self.Backing = Backing
	local Rank = LUI.UIText.new(0.5, 0.5, -61, 0, 0.5, 0.5, -17, 19)
	Rank:setTTF("0arame_mono_stencil")
	Rank:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	Rank.__String_Reference = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			Rank:setText(CoD.ArenaLeaguePlayUtility.GetLeagueLadderPlayerRankFromXuid(f2_local0))
		end
	end
	Rank:subscribeToGlobalModel(f1_arg1, "Attacker", "xuid", Rank.__String_Reference)
	Rank.__String_Reference_FullPath = function()
		local f3_local0 = DataSources.Attacker.getModel(f1_arg1)
		f3_local0 = f3_local0.xuid
		if f3_local0 then
			Rank.__String_Reference(f3_local0)
		end
	end
	self:addElement(Rank)
	self.Rank = Rank
	local RankIcon = LUI.UIImage.new(0.5, 0.5, 0, 40, 0.5, 0.5, -20, 20)
	RankIcon.__Image = function(f4_arg0)
		local f4_local0 = f4_arg0:get()
		if f4_local0 ~= nil then
			RankIcon:setImage(RegisterImage(CoD.ArenaLeaguePlayUtility.GetLeagueLadderPlayerSmallRankIconFromXuid(f4_local0)))
		end
	end
	RankIcon:subscribeToGlobalModel(f1_arg1, "Attacker", "xuid", RankIcon.__Image)
	RankIcon.__Image_FullPath = function()
		local f5_local0 = DataSources.Attacker.getModel(f1_arg1)
		f5_local0 = f5_local0.xuid
		if f5_local0 then
			RankIcon.__Image(f5_local0)
		end
	end
	self:addElement(RankIcon)
	self.RankIcon = RankIcon
	local f1_local4 = Rank
	local f1_local5 = Rank.subscribeToModel
	local f1_local6 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6.lobbyNav, Rank.__String_Reference_FullPath)
	f1_local4 = Rank
	f1_local5 = Rank.subscribeToModel
	f1_local6 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6["privateClient.update"], Rank.__String_Reference_FullPath)
	f1_local4 = Rank
	f1_local5 = Rank.subscribeToModel
	f1_local6 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6["gameClient.update"], Rank.__String_Reference_FullPath)
	f1_local4 = Rank
	f1_local5 = Rank.subscribeToModel
	f1_local6 = Engine[@"getglobalmodel"]()
	f1_local5(f1_local4, f1_local6["PartyPrivacy.privacy"], Rank.__String_Reference_FullPath)
	f1_local4 = RankIcon
	f1_local5 = RankIcon.subscribeToModel
	f1_local6 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6.lobbyNav, RankIcon.__Image_FullPath)
	f1_local4 = RankIcon
	f1_local5 = RankIcon.subscribeToModel
	f1_local6 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6["privateClient.update"], RankIcon.__Image_FullPath)
	f1_local4 = RankIcon
	f1_local5 = RankIcon.subscribeToModel
	f1_local6 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6["gameClient.update"], RankIcon.__Image_FullPath)
	f1_local4 = RankIcon
	f1_local5 = RankIcon.subscribeToModel
	f1_local6 = Engine[@"getglobalmodel"]()
	f1_local5(f1_local4, f1_local6["PartyPrivacy.privacy"], RankIcon.__Image_FullPath)
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not IsLAN()
			end,
		},
	})
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getglobalmodel"]()
	f1_local5(f1_local4, f1_local6["lobbyRoot.lobbyNetworkMode"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "lobbyRoot.lobbyNetworkMode",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getglobalmodel"]()
	f1_local5(f1_local4, f1_local6["lobbyRoot.lobbyNav"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaKillcamAttackerRank.__resetProperties = function(f9_arg0)
	f9_arg0.RankIcon:completeAnimation()
	f9_arg0.Rank:completeAnimation()
	f9_arg0.Backing:completeAnimation()
	f9_arg0.RankIcon:setAlpha(1)
	f9_arg0.Rank:setAlpha(1)
	f9_arg0.Backing:setAlpha(0.8)
end
CoD.ArenaKillcamAttackerRank.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			f10_arg0.Backing:completeAnimation()
			f10_arg0.Backing:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Backing)
			f10_arg0.Rank:completeAnimation()
			f10_arg0.Rank:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Rank)
			f10_arg0.RankIcon:completeAnimation()
			f10_arg0.RankIcon:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.RankIcon)
		end,
	},
	Visible = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.ArenaKillcamAttackerRank.__onClose = function(f12_arg0)
	f12_arg0.Rank:close()
	f12_arg0.RankIcon:close()
end
