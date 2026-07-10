CoD.ArenaKillcamPlayerRank = InheritFrom(LUI.UIElement)
CoD.ArenaKillcamPlayerRank.__defaultWidth = 147
CoD.ArenaKillcamPlayerRank.__defaultHeight = 40
CoD.ArenaKillcamPlayerRank.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaKillcamPlayerRank)
	self.id = "ArenaKillcamPlayerRank"
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
	Rank:subscribeToGlobalModel(f1_arg1, "PerController", "predictedClientModel", function(model, f3_arg1)
		if f3_arg1["__Rank.__String_Reference_predictedClientModel->xuid"] then
			f3_arg1:removeSubscription(f3_arg1["__Rank.__String_Reference_predictedClientModel->xuid"])
			f3_arg1["__Rank.__String_Reference_predictedClientModel->xuid"] = nil
		end
		if model then
			local f3_local0 = model:get()
			local f3_local1 = model:get()
			model = f3_local0 and f3_local1.xuid
		end
		if model then
			f3_arg1["__Rank.__String_Reference_predictedClientModel->xuid"] = f3_arg1:subscribeToModel(model, Rank.__String_Reference)
		end
	end)
	Rank.__String_Reference_FullPath = function()
		local f4_local0 = DataSources.PerController.getModel(f1_arg1)
		f4_local0 = f4_local0.predictedClientModel
		if f4_local0 then
			f4_local0 = f4_local0:get()
		end
		if f4_local0 then
			f4_local0 = f4_local0.xuid
		end
		if f4_local0 then
			Rank.__String_Reference(f4_local0)
		end
	end
	self:addElement(Rank)
	self.Rank = Rank
	local RankIcon = LUI.UIImage.new(0.5, 0.5, 0, 40, 0.5, 0.5, -20, 20)
	RankIcon.__Image = function(f5_arg0)
		local f5_local0 = f5_arg0:get()
		if f5_local0 ~= nil then
			RankIcon:setImage(RegisterImage(CoD.ArenaLeaguePlayUtility.GetLeagueLadderPlayerSmallRankIconFromXuid(f5_local0)))
		end
	end
	RankIcon:subscribeToGlobalModel(f1_arg1, "PerController", "predictedClientModel", function(model, f6_arg1)
		if f6_arg1["__RankIcon.__Image_predictedClientModel->xuid"] then
			f6_arg1:removeSubscription(f6_arg1["__RankIcon.__Image_predictedClientModel->xuid"])
			f6_arg1["__RankIcon.__Image_predictedClientModel->xuid"] = nil
		end
		if model then
			local f6_local0 = model:get()
			local f6_local1 = model:get()
			model = f6_local0 and f6_local1.xuid
		end
		if model then
			f6_arg1["__RankIcon.__Image_predictedClientModel->xuid"] = f6_arg1:subscribeToModel(model, RankIcon.__Image)
		end
	end)
	RankIcon.__Image_FullPath = function()
		local f7_local0 = DataSources.PerController.getModel(f1_arg1)
		f7_local0 = f7_local0.predictedClientModel
		if f7_local0 then
			f7_local0 = f7_local0:get()
		end
		if f7_local0 then
			f7_local0 = f7_local0.xuid
		end
		if f7_local0 then
			RankIcon.__Image(f7_local0)
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
	f1_local5(f1_local4, f1_local6["lobbyRoot.lobbyNetworkMode"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "lobbyRoot.lobbyNetworkMode",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getglobalmodel"]()
	f1_local5(f1_local4, f1_local6["lobbyRoot.lobbyNav"], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaKillcamPlayerRank.__resetProperties = function(f11_arg0)
	f11_arg0.RankIcon:completeAnimation()
	f11_arg0.Rank:completeAnimation()
	f11_arg0.Backing:completeAnimation()
	f11_arg0.RankIcon:setAlpha(1)
	f11_arg0.Rank:setAlpha(1)
	f11_arg0.Backing:setAlpha(0.8)
end
CoD.ArenaKillcamPlayerRank.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			f12_arg0.Backing:completeAnimation()
			f12_arg0.Backing:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Backing)
			f12_arg0.Rank:completeAnimation()
			f12_arg0.Rank:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Rank)
			f12_arg0.RankIcon:completeAnimation()
			f12_arg0.RankIcon:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.RankIcon)
		end,
	},
	Visible = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.ArenaKillcamPlayerRank.__onClose = function(f14_arg0)
	f14_arg0.Rank:close()
	f14_arg0.RankIcon:close()
end
