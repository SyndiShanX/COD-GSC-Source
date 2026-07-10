require("x64:228a7baa572b047")
require("x64:1d8e482adfc7305")
require("x64:8d3de31d16f3fdf")
CoD.PlayerCardMenu = InheritFrom(LUI.UIElement)
CoD.PlayerCardMenu.__defaultWidth = 458
CoD.PlayerCardMenu.__defaultHeight = 82
CoD.PlayerCardMenu.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PlayerCardMenu)
	self.id = "PlayerCardMenu"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CallingCardBacking = LUI.UIImage.new(0, 0, 140, 458, 0, 0, 0, 82)
	CallingCardBacking:setRGB(0.21, 0.21, 0.21)
	self:addElement(CallingCardBacking)
	self.CallingCardBacking = CallingCardBacking
	local EmblemBacking = LUI.UIImage.new(0, 0, 0, 136, 0, 0, 0, 82)
	EmblemBacking:setRGB(0.19, 0.19, 0.19)
	self:addElement(EmblemBacking)
	self.EmblemBacking = EmblemBacking
	local CallingCardsFrameWidget = CoD.CallingCards_FrameWidget.new(f1_arg0, f1_arg1, 0, 0, 140, 458, 0, 0, 0, 82)
	CallingCardsFrameWidget:linkToElementModel(self, nil, false, function(model)
		CallingCardsFrameWidget:setModel(model, f1_arg1)
	end)
	self:addElement(CallingCardsFrameWidget)
	self.CallingCardsFrameWidget = CallingCardsFrameWidget
	local Panel = CoD.FE_PanelNoBlur.new(f1_arg0, f1_arg1, 0, 0, 143, 209, 0, 0, 36, 66)
	Panel:setRGB(0, 0, 0)
	Panel:setAlpha(0.6)
	self:addElement(Panel)
	self.Panel = Panel
	local GamerTag = CoD.PlayerCard_Label.new(f1_arg0, f1_arg1, 0, 0, 143, 455, 0, 0, 3, 31)
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
	local TeamColor = GamerTag
	local ClanTag = GamerTag.subscribeToModel
	local RankIcon = Engine[0x4DF5CFBC1771947](f1_arg1)
	ClanTag(TeamColor, RankIcon["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f5_arg0)
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
			GamerTag.itemName:setText(f8_local0)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(GamerTag, "setText", function(element, controller)
		ScaleWidgetToLabel(self, element, 1)
	end)
	self:addElement(GamerTag)
	self.GamerTag = GamerTag
	ClanTag = CoD.PlayerCard_Label.new(f1_arg0, f1_arg1, 0, 0, 143, 214, 0, 0, 36, 64)
	ClanTag.Panel:setAlpha(0.6)
	ClanTag:linkToElementModel(self, "clanTag", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			ClanTag:setAlpha(HideIfEmptyString(f10_local0))
		end
	end)
	ClanTag:linkToElementModel(self, "clanTag", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			ClanTag.itemName:setText(StringAsClanTag(f11_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(ClanTag, "setText", function(element, controller)
		ScaleWidgetToLabel(self, element, 1)
	end)
	self:addElement(ClanTag)
	self.ClanTag = ClanTag
	TeamColor = LUI.UIImage.new(0, 0, 46, 142, 0, 0, 3, 73)
	TeamColor:setRGB(ColorSet.FriendlyBlue.r, ColorSet.FriendlyBlue.g, ColorSet.FriendlyBlue.b)
	TeamColor:setAlpha(0)
	TeamColor:setImage(RegisterImage(0x2D2C20F3D0B1D5D))
	TeamColor:setMaterial(LUI.UIImage.GetCachedMaterial(0xE8F55203998700A))
	self:addElement(TeamColor)
	self.TeamColor = TeamColor
	RankIcon = LUI.UIImage.new(0, 0, 177, 201, 0, 0, 39, 63)
	RankIcon:setAlpha(0)
	RankIcon:linkToElementModel(self, "rankIcon", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			RankIcon:setImage(RegisterImage(f13_local0))
		end
	end)
	self:addElement(RankIcon)
	self.RankIcon = RankIcon
	local Rank = LUI.UIText.new(0, 0, 146, 176, 0, 0, 34, 64)
	Rank:setAlpha(0)
	Rank:setTTF("dinnext_regular")
	Rank:setLetterSpacing(0.5)
	Rank:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Rank:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Rank:linkToElementModel(self, "rank", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			Rank:setText(f14_local0)
		end
	end)
	self:addElement(Rank)
	self.Rank = Rank
	local CalloutHeading = LUI.UIText.new(0, 0, 142, 483, 0, 0, -24, 3)
	CalloutHeading:setTTF("ttmussels_demibold")
	CalloutHeading:setLetterSpacing(0.5)
	CalloutHeading:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CalloutHeading:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	CalloutHeading:linkToElementModel(self, "heading", true, function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			CalloutHeading:setText(Engine[0xF9F1239CFD921FE](f15_local0))
		end
	end)
	self:addElement(CalloutHeading)
	self.CalloutHeading = CalloutHeading
	local PlayerEmblem = LUI.UIImage.new(0, 0, 0, 136, 0, 0, 0, 82)
	PlayerEmblem:linkToElementModel(self, "xuid", true, function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			PlayerEmblem:setupPlayerEmblemByXUID(f16_local0)
		end
	end)
	self:addElement(PlayerEmblem)
	self.PlayerEmblem = PlayerEmblem
	local IdentityCornerBottomRight = LUI.UIImage.new(0, 0, 452, 462, 0, 0, 75.5, 85.5)
	IdentityCornerBottomRight:setAlpha(0.25)
	IdentityCornerBottomRight:setZRot(-180)
	IdentityCornerBottomRight:setImage(RegisterImage(0xD7AC5089314462A))
	self:addElement(IdentityCornerBottomRight)
	self.IdentityCornerBottomRight = IdentityCornerBottomRight
	local IdentityCornerTopRight = LUI.UIImage.new(0, 0, 451.5, 461.5, 0, 0, -3, 7)
	IdentityCornerTopRight:setAlpha(0.25)
	IdentityCornerTopRight:setZRot(-90)
	IdentityCornerTopRight:setImage(RegisterImage(0xD7AC5089314462A))
	self:addElement(IdentityCornerTopRight)
	self.IdentityCornerTopRight = IdentityCornerTopRight
	local IdentitySeperatorTop = LUI.UIImage.new(0, 0, 133.5, 143.5, 0, 0, -3, 7)
	IdentitySeperatorTop:setAlpha(0.25)
	IdentitySeperatorTop:setImage(RegisterImage(0xCF8AB3892E52036))
	self:addElement(IdentitySeperatorTop)
	self.IdentitySeperatorTop = IdentitySeperatorTop
	local IdentitySeperatorBottom = LUI.UIImage.new(0, 0, 132.5, 142.5, 0, 0, 75.5, 85.5)
	IdentitySeperatorBottom:setAlpha(0.25)
	IdentitySeperatorBottom:setZRot(180)
	IdentitySeperatorBottom:setImage(RegisterImage(0xCF8AB3892E52036))
	self:addElement(IdentitySeperatorBottom)
	self.IdentitySeperatorBottom = IdentitySeperatorBottom
	local IdentityCornerBottomLeft = LUI.UIImage.new(0, 0, -3.5, 6.5, 0, 0, 75.5, 85.5)
	IdentityCornerBottomLeft:setAlpha(0.25)
	IdentityCornerBottomLeft:setZRot(90)
	IdentityCornerBottomLeft:setImage(RegisterImage(0xD7AC5089314462A))
	self:addElement(IdentityCornerBottomLeft)
	self.IdentityCornerBottomLeft = IdentityCornerBottomLeft
	local IdentityCornerTopLeft = LUI.UIImage.new(0, 0, -3, 7, 0, 0, -3, 7)
	IdentityCornerTopLeft:setAlpha(0.25)
	IdentityCornerTopLeft:setImage(RegisterImage(0xD7AC5089314462A))
	self:addElement(IdentityCornerTopLeft)
	self.IdentityCornerTopLeft = IdentityCornerTopLeft
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
	local f1_local18 = self
	local f1_local19 = self.subscribeToModel
	local f1_local20 = Engine[0x8DF2E5447F384B9]()
	f1_local19(f1_local18, f1_local20["lobbyRoot.lobbyNav"], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
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
CoD.PlayerCardMenu.__resetProperties = function(f20_arg0)
	f20_arg0.Panel:completeAnimation()
	f20_arg0.PlayerEmblem:completeAnimation()
	f20_arg0.TeamColor:completeAnimation()
	f20_arg0.Panel:setAlpha(0.6)
	f20_arg0.PlayerEmblem:setAlpha(1)
	f20_arg0.TeamColor:setLeftRight(0, 0, 46, 142)
	f20_arg0.TeamColor:setTopBottom(0, 0, 3, 73)
end
CoD.PlayerCardMenu.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(0)
		end,
	},
	Emblem = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.Panel:completeAnimation()
			f22_arg0.Panel:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.Panel)
		end,
	},
	Calingcard = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(3)
			f23_arg0.Panel:completeAnimation()
			f23_arg0.Panel:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.Panel)
			f23_arg0.TeamColor:completeAnimation()
			f23_arg0.TeamColor:setLeftRight(0, 0, 176, 272)
			f23_arg0.TeamColor:setTopBottom(0, 0, 3, 73)
			f23_arg0.clipFinished(f23_arg0.TeamColor)
			f23_arg0.PlayerEmblem:completeAnimation()
			f23_arg0.PlayerEmblem:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.PlayerEmblem)
		end,
	},
}
CoD.PlayerCardMenu.__onClose = function(f24_arg0)
	f24_arg0.CallingCardsFrameWidget:close()
	f24_arg0.Panel:close()
	f24_arg0.GamerTag:close()
	f24_arg0.ClanTag:close()
	f24_arg0.RankIcon:close()
	f24_arg0.Rank:close()
	f24_arg0.CalloutHeading:close()
	f24_arg0.PlayerEmblem:close()
end
