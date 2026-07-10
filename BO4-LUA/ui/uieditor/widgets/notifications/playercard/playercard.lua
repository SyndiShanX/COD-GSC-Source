require("x64:228a7baa572b047")
require("x64:8d3de31d16f3fdf")
CoD.PlayerCard = InheritFrom(LUI.UIElement)
CoD.PlayerCard.__defaultWidth = 556
CoD.PlayerCard.__defaultHeight = 178
CoD.PlayerCard.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PlayerCard)
	self.id = "PlayerCard"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CallingCardsFrameWidget = CoD.CallingCards_FrameWidget.new(f1_arg0, f1_arg1, 0, 0, 43, 361, 0, 0, 60, 142)
	CallingCardsFrameWidget:setScale(1.2, 1.2)
	CallingCardsFrameWidget:linkToElementModel(self, nil, false, function(model)
		CallingCardsFrameWidget:setModel(model, f1_arg1)
	end)
	self:addElement(CallingCardsFrameWidget)
	self.CallingCardsFrameWidget = CallingCardsFrameWidget
	local GamerTag = CoD.PlayerCard_Label.new(f1_arg0, f1_arg1, 0, 0, 12, 324, 0, 0, 121, 149)
	GamerTag:mergeStateConditions({
		{
			stateName = "PlayerYellow",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueMyXuidOrAnyLocalPlayerOnGameOver(element, f1_arg1, "xuid")
			end,
		},
	})
	GamerTag:linkToElementModel(GamerTag, "xuid", true, function(model)
		f1_arg0:updateElementState(GamerTag, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "xuid",
		})
	end)
	local HeroBacking = GamerTag
	local ClanTag = GamerTag.subscribeToModel
	local TeamColor = Engine[0x4DF5CFBC1771947](f1_arg1)
	ClanTag(HeroBacking, TeamColor["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f5_arg0)
		f1_arg0:updateElementState(GamerTag, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	GamerTag.Panel:setAlpha(0.6)
	GamerTag:linkToElementModel(self, "playerName", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			GamerTag:setAlpha(HideIfEmptyString(f6_local0))
		end
	end)
	GamerTag:linkToElementModel(self, nil, false, function(model)
		GamerTag:setModel(model, f1_arg1)
	end)
	GamerTag:linkToElementModel(self, "playerName", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			GamerTag.itemName:setText(CoD.BaseUtility.AlreadyLocalized(f8_local0))
		end
	end)
	self:addElement(GamerTag)
	self.GamerTag = GamerTag
	ClanTag = CoD.PlayerCard_Label.new(f1_arg0, f1_arg1, 0, 0, 12, 83, 0, 0, 90, 118)
	ClanTag.Panel:setAlpha(0.6)
	ClanTag:linkToElementModel(self, "clanTag", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			ClanTag:setAlpha(HideIfEmptyString(f9_local0))
		end
	end)
	ClanTag:linkToElementModel(self, "clanTag", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			ClanTag.itemName:setText(StringAsClanTag(CoD.BaseUtility.AlreadyLocalized(f10_local0)))
		end
	end)
	self:addElement(ClanTag)
	self.ClanTag = ClanTag
	HeroBacking = LUI.UIImage.new(0, 0, -3, 93, 0, 0, -12, 96)
	HeroBacking:setAlpha(0)
	HeroBacking:setImage(RegisterImage(0x5FA309EA9D3CE14))
	HeroBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0xE8F55203998700A))
	self:addElement(HeroBacking)
	self.HeroBacking = HeroBacking
	TeamColor = LUI.UIImage.new(0, 0, 46, 142, 0, 0, 3, 73)
	TeamColor:setRGB(ColorSet.FriendlyBlue.r, ColorSet.FriendlyBlue.g, ColorSet.FriendlyBlue.b)
	TeamColor:setAlpha(0)
	TeamColor:setImage(RegisterImage(0x2D2C20F3D0B1D5D))
	TeamColor:setMaterial(LUI.UIImage.GetCachedMaterial(0xE8F55203998700A))
	self:addElement(TeamColor)
	self.TeamColor = TeamColor
	local RankIcon = LUI.UIImage.new(0, 0, 173, 197, 0, 0, 44, 68)
	RankIcon:setAlpha(0)
	RankIcon:linkToElementModel(self, "rankIcon", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			RankIcon:setImage(RegisterImage(f11_local0))
		end
	end)
	self:addElement(RankIcon)
	self.RankIcon = RankIcon
	local Rank = LUI.UIText.new(0, 0, 142, 172, 0, 0, 39, 69)
	Rank:setAlpha(0)
	Rank:setTTF("0arame_mono_stencil")
	Rank:setLetterSpacing(0.5)
	Rank:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Rank:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Rank:linkToElementModel(self, "rank", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			Rank:setText(f12_local0)
		end
	end)
	self:addElement(Rank)
	self.Rank = Rank
	self:mergeStateConditions({
		{
			stateName = "Emblem",
			condition = function(menu, element, event)
				return not IsLobbyNetworkModeLAN()
			end,
		},
		{
			stateName = "Calingcard",
			condition = function(menu, element, event)
				return IsLobbyNetworkModeLAN()
			end,
		},
	})
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[0x8DF2E5447F384B9]()
	f1_local9(f1_local8, f1_local10["lobbyRoot.lobbyNav"], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	CallingCardsFrameWidget.id = "CallingCardsFrameWidget"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PlayerCard.__resetProperties = function(f16_arg0)
	f16_arg0.Rank:completeAnimation()
	f16_arg0.CallingCardsFrameWidget:completeAnimation()
	f16_arg0.RankIcon:completeAnimation()
	f16_arg0.TeamColor:completeAnimation()
	f16_arg0.HeroBacking:completeAnimation()
	f16_arg0.Rank:setLeftRight(0, 0, 142, 172)
	f16_arg0.Rank:setTopBottom(0, 0, 39, 69)
	f16_arg0.CallingCardsFrameWidget:setLeftRight(0, 0, 43, 361)
	f16_arg0.CallingCardsFrameWidget:setTopBottom(0, 0, 60, 142)
	f16_arg0.RankIcon:setLeftRight(0, 0, 173, 197)
	f16_arg0.RankIcon:setTopBottom(0, 0, 44, 68)
	f16_arg0.TeamColor:setLeftRight(0, 0, 46, 142)
	f16_arg0.TeamColor:setTopBottom(0, 0, 3, 73)
	f16_arg0.HeroBacking:setLeftRight(0, 0, -3, 93)
	f16_arg0.HeroBacking:setTopBottom(0, 0, -12, 96)
end
CoD.PlayerCard.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(0)
		end,
	},
	Emblem = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(0)
		end,
	},
	Calingcard = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(5)
			f19_arg0.CallingCardsFrameWidget:completeAnimation()
			f19_arg0.CallingCardsFrameWidget:setLeftRight(0, 0, 43, 361)
			f19_arg0.CallingCardsFrameWidget:setTopBottom(0, 0, 60, 142)
			f19_arg0.clipFinished(f19_arg0.CallingCardsFrameWidget)
			f19_arg0.HeroBacking:completeAnimation()
			f19_arg0.HeroBacking:setLeftRight(0, 0, 127, 223)
			f19_arg0.HeroBacking:setTopBottom(0, 0, -12, 96)
			f19_arg0.clipFinished(f19_arg0.HeroBacking)
			f19_arg0.TeamColor:completeAnimation()
			f19_arg0.TeamColor:setLeftRight(0, 0, 176, 272)
			f19_arg0.TeamColor:setTopBottom(0, 0, 3, 73)
			f19_arg0.clipFinished(f19_arg0.TeamColor)
			f19_arg0.RankIcon:completeAnimation()
			f19_arg0.RankIcon:setLeftRight(0, 0, 303, 327)
			f19_arg0.RankIcon:setTopBottom(0, 0, 44, 68)
			f19_arg0.clipFinished(f19_arg0.RankIcon)
			f19_arg0.Rank:completeAnimation()
			f19_arg0.Rank:setLeftRight(0, 0, 139, 169)
			f19_arg0.Rank:setTopBottom(0, 0, 39, 69)
			f19_arg0.clipFinished(f19_arg0.Rank)
		end,
	},
}
CoD.PlayerCard.__onClose = function(f20_arg0)
	f20_arg0.CallingCardsFrameWidget:close()
	f20_arg0.GamerTag:close()
	f20_arg0.ClanTag:close()
	f20_arg0.RankIcon:close()
	f20_arg0.Rank:close()
end
