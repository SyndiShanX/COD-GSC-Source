require("x64:228a7baa572b047")
require("x64:acbf06924421e35")
require("x64:8293fdfde8af5f3")
CoD.ObituaryKillerIdentity = InheritFrom(LUI.UIElement)
CoD.ObituaryKillerIdentity.__defaultWidth = 800
CoD.ObituaryKillerIdentity.__defaultHeight = 80
CoD.ObituaryKillerIdentity.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.ObituaryKillerIdentity)
	self.id = "ObituaryKillerIdentity"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SceneBlur = LUI.UIImage.new(0.5, 0.5, -253, 253, 0.5, 0.5, -40, 40)
	SceneBlur:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	SceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local BackingBorder = LUI.UIImage.new(0.5, 0.5, -253, 253, 0.5, 0.5, -40, 40)
	BackingBorder:setImage(RegisterImage(0x34839E8065B1E53))
	BackingBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	BackingBorder:setShaderVector(0, 0, 0, 0, 0)
	BackingBorder:setupNineSliceShader(196, 88)
	self:addElement(BackingBorder)
	self.BackingBorder = BackingBorder
	local BackingBorder2 = LUI.UIImage.new(0.5, 0.5, -253, 253, 0.5, 0.5, -40, 40)
	BackingBorder2:setImage(RegisterImage(0x34839E8065B1E53))
	BackingBorder2:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	BackingBorder2:setShaderVector(0, 0, 0, 0, 0)
	BackingBorder2:setupNineSliceShader(196, 88)
	self:addElement(BackingBorder2)
	self.BackingBorder2 = BackingBorder2
	local BackingEmblem = LUI.UIImage.new(0, 0, 149, 225, 0, 0, 2, 78)
	BackingEmblem:setAlpha(0.7)
	BackingEmblem:setImage(RegisterImage(0x34839E8065B1E53))
	BackingEmblem:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	BackingEmblem:setShaderVector(0, 0, 0, 0, 0)
	BackingEmblem:setupNineSliceShader(196, 88)
	self:addElement(BackingEmblem)
	self.BackingEmblem = BackingEmblem
	local BackingEmblemTint = LUI.UIImage.new(0, 0, 149, 225, 0, 0, 2, 78)
	BackingEmblemTint:setRGB(0.04, 0.04, 0.04)
	BackingEmblemTint:setAlpha(0.5)
	self:addElement(BackingEmblemTint)
	self.BackingEmblemTint = BackingEmblemTint
	local AttackerEmblem = LUI.UIImage.new(0, 0, 149, 225, 0, 0, 2, 78)
	self:addElement(AttackerEmblem)
	self.AttackerEmblem = AttackerEmblem
	local KillerLabel = LUI.UIText.new(0.5, 0.5, -253, 253, 0, 0, -22, -1)
	KillerLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	KillerLabel:setAlpha(0)
	KillerLabel:setText(LocalizeToUpperString(0x98E1E885ED068B4))
	KillerLabel:setTTF("ttmussels_regular")
	KillerLabel:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	KillerLabel:setShaderVector(0, 1, 0, 0, 0)
	KillerLabel:setShaderVector(1, 0, 0, 0, 0)
	KillerLabel:setShaderVector(2, 0, 0, 0, 0.35)
	KillerLabel:setLetterSpacing(2)
	KillerLabel:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	KillerLabel:setBackingType(1)
	KillerLabel:setBackingWidget(CoD.ObituaryBlurBacking, f1_arg0, f1_arg1)
	KillerLabel:setBackingColor(0, 0, 0)
	KillerLabel:setBackingXPadding(14)
	self:addElement(KillerLabel)
	self.KillerLabel = KillerLabel
	local CallingCardsFrameWidget = CoD.CallingCards_FrameWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -173.5, 145.5, 0.5, 0.5, -38, 38)
	CallingCardsFrameWidget:linkToElementModel(self, nil, false, function(model)
		CallingCardsFrameWidget:setModel(model, f1_arg1)
	end)
	self:addElement(CallingCardsFrameWidget)
	self.CallingCardsFrameWidget = CallingCardsFrameWidget
	local PlayerName = LUI.UIText.new(0.5, 0.5, -163, 137, 0.5, 0.5, -31, -9)
	PlayerName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	PlayerName:setText("")
	PlayerName:setTTF("notosans_regular")
	PlayerName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	PlayerName:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	PlayerName:setBackingType(2)
	PlayerName:setBackingColor(0, 0, 0)
	PlayerName:setBackingAlpha(0.9)
	PlayerName:setBackingXPadding(5)
	PlayerName:setBackingYPadding(2)
	self:addElement(PlayerName)
	self.PlayerName = PlayerName
	local ClanName = LUI.UIText.new(0, 0, 237, 537, 0, 0, 40, 58)
	ClanName:setRGB(0.92, 0.92, 0.92)
	ClanName:setText("")
	ClanName:setTTF("notosans_regular")
	ClanName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ClanName:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	ClanName:setBackingType(2)
	ClanName:setBackingColor(0, 0, 0)
	ClanName:setBackingAlpha(0.9)
	ClanName:setBackingXPadding(5)
	ClanName:setBackingYPadding(2)
	self:addElement(ClanName)
	self.ClanName = ClanName
	local BackingRankTint = LUI.UIImage.new(0, 0, 547.5, 651.5, 0, 0, 2, 78)
	BackingRankTint:setRGB(0.04, 0.04, 0.04)
	BackingRankTint:setAlpha(0.5)
	self:addElement(BackingRankTint)
	self.BackingRankTint = BackingRankTint
	local BackingRank = LUI.UIImage.new(0, 0, 547, 651, 0, 0, 2, 78)
	BackingRank:setAlpha(0.7)
	BackingRank:setImage(RegisterImage(0x34839E8065B1E53))
	BackingRank:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	BackingRank:setShaderVector(0, 0, 0, 0, 0)
	BackingRank:setupNineSliceShader(196, 88)
	self:addElement(BackingRank)
	self.BackingRank = BackingRank
	local Rank = LUI.UIText.new(0.5, 0.5, 205, 251, 0.5, 0.5, -15, 15)
	Rank:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Rank:setText("")
	Rank:setTTF("0arame_mono_stencil")
	Rank:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Rank:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(Rank)
	self.Rank = Rank
	local RankIcon = LUI.UIImage.new(0.5, 0.5, 160, 206, 0.5, 0.5, -23, 23)
	self:addElement(RankIcon)
	self.RankIcon = RankIcon
	local ArenaRank = LUI.UIText.new(0.5, 0.5, 205, 251, 0.5, 0.5, -15, 15)
	ArenaRank:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ArenaRank:setTTF("0arame_mono_stencil")
	ArenaRank:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ArenaRank:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	ArenaRank.__String_Reference = function(f3_arg0)
		local f3_local0 = f3_arg0:get()
		if f3_local0 ~= nil then
			ArenaRank:setText(CoD.ArenaLeaguePlayUtility.GetLeagueLadderPlayerRankFromXuid(f3_local0))
		end
	end
	ArenaRank:linkToElementModel(self, "xuid", true, ArenaRank.__String_Reference)
	ArenaRank.__String_Reference_FullPath = function()
		local f4_local0 = self:getModel()
		if f4_local0 then
			f4_local0 = self:getModel()
			f4_local0 = f4_local0.xuid
		end
		if f4_local0 then
			ArenaRank.__String_Reference(f4_local0)
		end
	end
	self:addElement(ArenaRank)
	self.ArenaRank = ArenaRank
	local ArenaRankIcon = LUI.UIImage.new(0.5, 0.5, 160, 206, 0.5, 0.5, -23, 23)
	ArenaRankIcon.__Image = function(f5_arg0)
		local f5_local0 = f5_arg0:get()
		if f5_local0 ~= nil then
			ArenaRankIcon:setImage(RegisterImage(CoD.ArenaLeaguePlayUtility.GetLeagueLadderPlayerSmallRankIconFromXuid(f5_local0)))
		end
	end
	ArenaRankIcon:linkToElementModel(self, "xuid", true, ArenaRankIcon.__Image)
	ArenaRankIcon.__Image_FullPath = function()
		local f6_local0 = self:getModel()
		if f6_local0 then
			f6_local0 = self:getModel()
			f6_local0 = f6_local0.xuid
		end
		if f6_local0 then
			ArenaRankIcon.__Image(f6_local0)
		end
	end
	self:addElement(ArenaRankIcon)
	self.ArenaRankIcon = ArenaRankIcon
	local CommonCornerPips = CoD.CommonCornerPips01.new(f1_arg0, f1_arg1, 0, 0, 150, 224, 0, 0, 3, 77)
	CommonCornerPips:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	CommonCornerPips:setAlpha(0.7)
	self:addElement(CommonCornerPips)
	self.CommonCornerPips = CommonCornerPips
	local FrontendFrame = LUI.UIImage.new(0, 0, 146, 654, 0, 0, -1, 81)
	FrontendFrame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	FrontendFrame:setAlpha(0.2)
	FrontendFrame:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrontendFrame:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrontendFrame:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrame)
	self.FrontendFrame = FrontendFrame
	local f1_local19 = ArenaRank
	local f1_local20 = ArenaRank.subscribeToModel
	local f1_local21 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local20(f1_local19, f1_local21.lobbyNav, ArenaRank.__String_Reference_FullPath)
	f1_local19 = ArenaRank
	f1_local20 = ArenaRank.subscribeToModel
	f1_local21 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local20(f1_local19, f1_local21["privateClient.update"], ArenaRank.__String_Reference_FullPath)
	f1_local19 = ArenaRank
	f1_local20 = ArenaRank.subscribeToModel
	f1_local21 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local20(f1_local19, f1_local21["gameClient.update"], ArenaRank.__String_Reference_FullPath)
	f1_local19 = ArenaRank
	f1_local20 = ArenaRank.subscribeToModel
	f1_local21 = Engine[0x8DF2E5447F384B9]()
	f1_local20(f1_local19, f1_local21["PartyPrivacy.privacy"], ArenaRank.__String_Reference_FullPath)
	f1_local19 = ArenaRankIcon
	f1_local20 = ArenaRankIcon.subscribeToModel
	f1_local21 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local20(f1_local19, f1_local21.lobbyNav, ArenaRankIcon.__Image_FullPath)
	f1_local19 = ArenaRankIcon
	f1_local20 = ArenaRankIcon.subscribeToModel
	f1_local21 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local20(f1_local19, f1_local21["privateClient.update"], ArenaRankIcon.__Image_FullPath)
	f1_local19 = ArenaRankIcon
	f1_local20 = ArenaRankIcon.subscribeToModel
	f1_local21 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local20(f1_local19, f1_local21["gameClient.update"], ArenaRankIcon.__Image_FullPath)
	f1_local19 = ArenaRankIcon
	f1_local20 = ArenaRankIcon.subscribeToModel
	f1_local21 = Engine[0x8DF2E5447F384B9]()
	f1_local20(f1_local19, f1_local21["PartyPrivacy.privacy"], ArenaRankIcon.__Image_FullPath)
	self:mergeStateConditions({
		{
			stateName = "NoRank",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Arena",
			condition = function(menu, element, event)
				return IsArenaMode()
			end,
		},
	})
	f1_local19 = self
	f1_local20 = self.subscribeToModel
	f1_local21 = Engine[0x8DF2E5447F384B9]()
	f1_local20(f1_local19, f1_local21["lobbyRoot.lobbyNav"], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
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
CoD.ObituaryKillerIdentity.__resetProperties = function(f11_arg0)
	f11_arg0.KillerLabel:completeAnimation()
	f11_arg0.ArenaRankIcon:completeAnimation()
	f11_arg0.ArenaRank:completeAnimation()
	f11_arg0.Rank:completeAnimation()
	f11_arg0.RankIcon:completeAnimation()
	f11_arg0.AttackerEmblem:completeAnimation()
	f11_arg0.CallingCardsFrameWidget:completeAnimation()
	f11_arg0.PlayerName:completeAnimation()
	f11_arg0.ClanName:completeAnimation()
	f11_arg0.SceneBlur:completeAnimation()
	f11_arg0.BackingBorder:completeAnimation()
	f11_arg0.BackingBorder2:completeAnimation()
	f11_arg0.BackingEmblem:completeAnimation()
	f11_arg0.BackingEmblemTint:completeAnimation()
	f11_arg0.BackingRankTint:completeAnimation()
	f11_arg0.BackingRank:completeAnimation()
	f11_arg0.CommonCornerPips:completeAnimation()
	f11_arg0.FrontendFrame:completeAnimation()
	f11_arg0.KillerLabel:setAlpha(0)
	f11_arg0.ArenaRankIcon:setAlpha(1)
	f11_arg0.ArenaRank:setAlpha(1)
	f11_arg0.Rank:setAlpha(1)
	f11_arg0.RankIcon:setAlpha(1)
	f11_arg0.AttackerEmblem:setAlpha(1)
	f11_arg0.CallingCardsFrameWidget:setAlpha(1)
	f11_arg0.PlayerName:setAlpha(1)
	f11_arg0.ClanName:setAlpha(1)
	f11_arg0.SceneBlur:setAlpha(1)
	f11_arg0.BackingBorder:setAlpha(1)
	f11_arg0.BackingBorder2:setAlpha(1)
	f11_arg0.BackingEmblem:setAlpha(0.7)
	f11_arg0.BackingEmblemTint:setAlpha(0.5)
	f11_arg0.BackingRankTint:setAlpha(0.5)
	f11_arg0.BackingRank:setAlpha(0.7)
	f11_arg0.CommonCornerPips:setAlpha(0.7)
	f11_arg0.FrontendFrame:setAlpha(0.2)
end
CoD.ObituaryKillerIdentity.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			f12_arg0.KillerLabel:completeAnimation()
			f12_arg0.KillerLabel:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.KillerLabel)
			f12_arg0.ArenaRank:completeAnimation()
			f12_arg0.ArenaRank:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.ArenaRank)
			f12_arg0.ArenaRankIcon:completeAnimation()
			f12_arg0.ArenaRankIcon:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.ArenaRankIcon)
		end,
	},
	NoRank = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(4)
			f13_arg0.Rank:completeAnimation()
			f13_arg0.Rank:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Rank)
			f13_arg0.RankIcon:completeAnimation()
			f13_arg0.RankIcon:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.RankIcon)
			f13_arg0.ArenaRank:completeAnimation()
			f13_arg0.ArenaRank:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.ArenaRank)
			f13_arg0.ArenaRankIcon:completeAnimation()
			f13_arg0.ArenaRankIcon:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.ArenaRankIcon)
		end,
	},
	Hidden = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(18)
			f14_arg0.SceneBlur:completeAnimation()
			f14_arg0.SceneBlur:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.SceneBlur)
			f14_arg0.BackingBorder:completeAnimation()
			f14_arg0.BackingBorder:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.BackingBorder)
			f14_arg0.BackingBorder2:completeAnimation()
			f14_arg0.BackingBorder2:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.BackingBorder2)
			f14_arg0.BackingEmblem:completeAnimation()
			f14_arg0.BackingEmblem:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.BackingEmblem)
			f14_arg0.BackingEmblemTint:completeAnimation()
			f14_arg0.BackingEmblemTint:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.BackingEmblemTint)
			f14_arg0.AttackerEmblem:completeAnimation()
			f14_arg0.AttackerEmblem:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.AttackerEmblem)
			f14_arg0.KillerLabel:completeAnimation()
			f14_arg0.KillerLabel:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.KillerLabel)
			f14_arg0.CallingCardsFrameWidget:completeAnimation()
			f14_arg0.CallingCardsFrameWidget:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.CallingCardsFrameWidget)
			f14_arg0.PlayerName:completeAnimation()
			f14_arg0.PlayerName:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.PlayerName)
			f14_arg0.ClanName:completeAnimation()
			f14_arg0.ClanName:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.ClanName)
			f14_arg0.BackingRankTint:completeAnimation()
			f14_arg0.BackingRankTint:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.BackingRankTint)
			f14_arg0.BackingRank:completeAnimation()
			f14_arg0.BackingRank:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.BackingRank)
			f14_arg0.Rank:completeAnimation()
			f14_arg0.Rank:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Rank)
			f14_arg0.RankIcon:completeAnimation()
			f14_arg0.RankIcon:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.RankIcon)
			f14_arg0.ArenaRank:completeAnimation()
			f14_arg0.ArenaRank:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.ArenaRank)
			f14_arg0.ArenaRankIcon:completeAnimation()
			f14_arg0.ArenaRankIcon:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.ArenaRankIcon)
			f14_arg0.CommonCornerPips:completeAnimation()
			f14_arg0.CommonCornerPips:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.CommonCornerPips)
			f14_arg0.FrontendFrame:completeAnimation()
			f14_arg0.FrontendFrame:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.FrontendFrame)
		end,
	},
	Arena = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.Rank:completeAnimation()
			f15_arg0.Rank:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Rank)
			f15_arg0.RankIcon:completeAnimation()
			f15_arg0.RankIcon:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.RankIcon)
		end,
	},
}
CoD.ObituaryKillerIdentity.__onClose = function(f16_arg0)
	f16_arg0.CallingCardsFrameWidget:close()
	f16_arg0.ArenaRank:close()
	f16_arg0.ArenaRankIcon:close()
	f16_arg0.CommonCornerPips:close()
end
