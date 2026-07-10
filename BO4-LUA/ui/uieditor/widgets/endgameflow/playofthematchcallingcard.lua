require("x64:f35eef72ee10697")
require("x64:662766a1c1ca1e")
require("x64:1ecbc1d1881ae6")
require("x64:2f376e3ba06d89e")
CoD.PlayOfTheMatchCallingCard = InheritFrom(LUI.UIElement)
CoD.PlayOfTheMatchCallingCard.__defaultWidth = 594
CoD.PlayOfTheMatchCallingCard.__defaultHeight = 180
CoD.PlayOfTheMatchCallingCard.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PlayOfTheMatchCallingCard)
	self.id = "PlayOfTheMatchCallingCard"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CallingCardPanelLeft = LUI.UIImage.new(0, 0, 0, 555, 0, 0, 0, 173)
	CallingCardPanelLeft:setImage(RegisterImage(0x2504876AAAB7FA7))
	self:addElement(CallingCardPanelLeft)
	self.CallingCardPanelLeft = CallingCardPanelLeft
	local AttackerPlayerCard = CoD.KillcamPlayerCard.new(f1_arg0, f1_arg1, 0, 0, 184, 531, 0, 0, 57, 145)
	AttackerPlayerCard:setScale(1.17, 1.17)
	AttackerPlayerCard:subscribeToGlobalModel(f1_arg1, "PerController", "predictedClientModel", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			AttackerPlayerCard:setModel(f2_local0, f1_arg1)
		end
	end)
	AttackerPlayerCard.NameAndClanTag.NameAndClanTag.PlayerName.__Player_Name = function(f3_arg0)
		local f3_local0 = f3_arg0:get()
		if f3_local0 ~= nil then
			AttackerPlayerCard.NameAndClanTag.NameAndClanTag.PlayerName:setText(CoD.SocialUtility.CleanGamerTag(f3_local0))
		end
	end
	AttackerPlayerCard:subscribeToGlobalModel(f1_arg1, "PerController", "predictedClientModel", function(model, f4_arg1)
		if f4_arg1["__AttackerPlayerCard.NameAndClanTag.NameAndClanTag.PlayerName.__Player_Name_predictedClientModel->playerName"] then
			f4_arg1:removeSubscription(f4_arg1["__AttackerPlayerCard.NameAndClanTag.NameAndClanTag.PlayerName.__Player_Name_predictedClientModel->playerName"])
			f4_arg1["__AttackerPlayerCard.NameAndClanTag.NameAndClanTag.PlayerName.__Player_Name_predictedClientModel->playerName"] = nil
		end
		if model then
			local f4_local0 = model:get()
			local f4_local1 = model:get()
			model = f4_local0 and f4_local1.playerName
		end
		if model then
			f4_arg1["__AttackerPlayerCard.NameAndClanTag.NameAndClanTag.PlayerName.__Player_Name_predictedClientModel->playerName"] = f4_arg1:subscribeToModel(model, AttackerPlayerCard.NameAndClanTag.NameAndClanTag.PlayerName.__Player_Name)
		end
	end)
	self:addElement(AttackerPlayerCard)
	self.AttackerPlayerCard = AttackerPlayerCard
	local AttackerRank = CoD.KillcamPlayerRank.new(f1_arg0, f1_arg1, 0, 0, 158, 245, 0, 0, 57, 87)
	AttackerRank:setScale(0.98, 0.98)
	AttackerRank.Rank.__Rank_Color = function(f5_arg0)
		local f5_local0 = f5_arg0:get()
		if f5_local0 ~= nil then
			AttackerRank.Rank:setRGB(CoD.RankUtility.GetInGameColorForRankTextByRank(f5_local0))
		end
	end
	AttackerRank:subscribeToGlobalModel(f1_arg1, "PerController", "predictedClientModel", function(model, f6_arg1)
		if f6_arg1["__AttackerRank.Rank.__Rank_Color_predictedClientModel->rank"] then
			f6_arg1:removeSubscription(f6_arg1["__AttackerRank.Rank.__Rank_Color_predictedClientModel->rank"])
			f6_arg1["__AttackerRank.Rank.__Rank_Color_predictedClientModel->rank"] = nil
		end
		if model then
			local f6_local0 = model:get()
			local f6_local1 = model:get()
			model = f6_local0 and f6_local1.rank
		end
		if model then
			f6_arg1["__AttackerRank.Rank.__Rank_Color_predictedClientModel->rank"] = f6_arg1:subscribeToModel(model, AttackerRank.Rank.__Rank_Color)
		end
	end)
	AttackerRank.Rank.__Rank_String_Reference = function(f7_arg0)
		local f7_local0 = f7_arg0:get()
		if f7_local0 ~= nil then
			AttackerRank.Rank:setText(f7_local0)
		end
	end
	AttackerRank:subscribeToGlobalModel(f1_arg1, "PerController", "predictedClientModel", function(model, f8_arg1)
		if f8_arg1["__AttackerRank.Rank.__Rank_String_Reference_predictedClientModel->rank"] then
			f8_arg1:removeSubscription(f8_arg1["__AttackerRank.Rank.__Rank_String_Reference_predictedClientModel->rank"])
			f8_arg1["__AttackerRank.Rank.__Rank_String_Reference_predictedClientModel->rank"] = nil
		end
		if model then
			local f8_local0 = model:get()
			local f8_local1 = model:get()
			model = f8_local0 and f8_local1.rank
		end
		if model then
			f8_arg1["__AttackerRank.Rank.__Rank_String_Reference_predictedClientModel->rank"] = f8_arg1:subscribeToModel(model, AttackerRank.Rank.__Rank_String_Reference)
		end
	end)
	AttackerRank.RankIcon.__RankIcon_Image = function(f9_arg0)
		local f9_local0 = f9_arg0:get()
		if f9_local0 ~= nil then
			AttackerRank.RankIcon:setImage(RegisterImage(f9_local0))
		end
	end
	AttackerRank:subscribeToGlobalModel(f1_arg1, "PerController", "predictedClientModel", function(model, f10_arg1)
		if f10_arg1["__AttackerRank.RankIcon.__RankIcon_Image_predictedClientModel->rankIcon"] then
			f10_arg1:removeSubscription(f10_arg1["__AttackerRank.RankIcon.__RankIcon_Image_predictedClientModel->rankIcon"])
			f10_arg1["__AttackerRank.RankIcon.__RankIcon_Image_predictedClientModel->rankIcon"] = nil
		end
		if model then
			local f10_local0 = model:get()
			local f10_local1 = model:get()
			model = f10_local0 and f10_local1.rankIcon
		end
		if model then
			f10_arg1["__AttackerRank.RankIcon.__RankIcon_Image_predictedClientModel->rankIcon"] = f10_arg1:subscribeToModel(model, AttackerRank.RankIcon.__RankIcon_Image)
		end
	end)
	self:addElement(AttackerRank)
	self.AttackerRank = AttackerRank
	local AttackerArenaRank = CoD.ArenaKillcamPlayerRank.new(f1_arg0, f1_arg1, 0, 0, 158, 245, 0, 0, 57, 87)
	AttackerArenaRank:setAlpha(0)
	AttackerArenaRank:setScale(0.98, 0.98)
	AttackerArenaRank:subscribeToGlobalModel(f1_arg1, "PerController", "predictedClientModel", function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			AttackerArenaRank:setModel(f11_local0, f1_arg1)
		end
	end)
	self:addElement(AttackerArenaRank)
	self.AttackerArenaRank = AttackerArenaRank
	local AttackerHealth = CoD.KillcamPlayerHealth.new(f1_arg0, f1_arg1, 0, 0, 137, 537, 0, 0, 10, 42)
	AttackerHealth:subscribeToGlobalModel(f1_arg1, "PerController", "predictedClientModel", function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			AttackerHealth:setModel(f12_local0, f1_arg1)
		end
	end)
	self:addElement(AttackerHealth)
	self.AttackerHealth = AttackerHealth
	local AttackerEmblem = LUI.UIImage.new(0, 0, 9.5, 145.5, 0, 0, 9, 145)
	AttackerEmblem.__XUID = function(f13_arg0)
		local f13_local0 = f13_arg0:get()
		if f13_local0 ~= nil then
			AttackerEmblem:setupPlayerEmblemByXUID(GetClientGameLobbyXUIDForClientNumString(f13_local0))
		end
	end
	AttackerEmblem:subscribeToGlobalModel(f1_arg1, "PerController", "predictedClientModel", function(model, f14_arg1)
		if f14_arg1["__AttackerEmblem.__XUID_predictedClientModel->clientNum"] then
			f14_arg1:removeSubscription(f14_arg1["__AttackerEmblem.__XUID_predictedClientModel->clientNum"])
			f14_arg1["__AttackerEmblem.__XUID_predictedClientModel->clientNum"] = nil
		end
		if model then
			local f14_local0 = model:get()
			local f14_local1 = model:get()
			model = f14_local0 and f14_local1.clientNum
		end
		if model then
			f14_arg1["__AttackerEmblem.__XUID_predictedClientModel->clientNum"] = f14_arg1:subscribeToModel(model, AttackerEmblem.__XUID)
		end
	end)
	self:addElement(AttackerEmblem)
	self.AttackerEmblem = AttackerEmblem
	self:mergeStateConditions({
		{
			stateName = "VisibleLeague",
			condition = function(menu, element, event)
				return IsArenaMode()
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[0x8DF2E5447F384B9]()
	f1_local8(f1_local7, f1_local9["lobbyRoot.lobbyNav"], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	AttackerPlayerCard.id = "AttackerPlayerCard"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PlayOfTheMatchCallingCard.__resetProperties = function(f17_arg0)
	f17_arg0.AttackerRank:completeAnimation()
	f17_arg0.AttackerArenaRank:completeAnimation()
	f17_arg0.AttackerRank:setAlpha(1)
	f17_arg0.AttackerArenaRank:setAlpha(0)
end
CoD.PlayOfTheMatchCallingCard.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(0)
		end,
	},
	VisibleLeague = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			f19_arg0.AttackerRank:completeAnimation()
			f19_arg0.AttackerRank:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.AttackerRank)
			f19_arg0.AttackerArenaRank:completeAnimation()
			f19_arg0.AttackerArenaRank:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.AttackerArenaRank)
		end,
	},
}
CoD.PlayOfTheMatchCallingCard.__onClose = function(f20_arg0)
	f20_arg0.AttackerPlayerCard:close()
	f20_arg0.AttackerRank:close()
	f20_arg0.AttackerArenaRank:close()
	f20_arg0.AttackerHealth:close()
	f20_arg0.AttackerEmblem:close()
end
