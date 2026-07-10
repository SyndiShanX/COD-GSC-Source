require("x64:228a7baa572b047")
require("x64:5f8cf56752aa71b")
require("x64:ef2c4b77caab743")
require("x64:7610254bee05fe0")
require("x64:906749ab0d5bbee")
require("x64:d1d5f6e1edad2b9")
require("x64:93ba3c001655e44")
require("x64:d0dd4bae5f1fadb")
require("x64:81feaeb195cd2e0")
CoD.Social_ManagePartyPlayerButtonInternal = InheritFrom(LUI.UIElement)
CoD.Social_ManagePartyPlayerButtonInternal.__defaultWidth = 481
CoD.Social_ManagePartyPlayerButtonInternal.__defaultHeight = 76
CoD.Social_ManagePartyPlayerButtonInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_ManagePartyPlayerButtonInternal)
	self.id = "Social_ManagePartyPlayerButtonInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0, 0, 0)
	self:addElement(Backing)
	self.Backing = Backing
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.8)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local SelectorOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SelectorOverlay:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	SelectorOverlay:setAlpha(0.01)
	self:addElement(SelectorOverlay)
	self.SelectorOverlay = SelectorOverlay
	local emblem = LUI.UIImage.new(0, 0, 2.5, 76.5, 0.5, 0.5, -37, 37)
	emblem:linkToElementModel(self, "identityBadge.xuid", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			emblem:setupPlayerEmblemByXUID(f2_local0)
		end
	end)
	self:addElement(emblem)
	self.emblem = emblem
	local CallingCardsFrameWidget = CoD.CallingCards_FrameWidget.new(f1_arg0, f1_arg1, 0, 0, 77.5, 373.5, 0, 0, 1, 75)
	CallingCardsFrameWidget:setRGB(0.9, 0.9, 0.9)
	CallingCardsFrameWidget:linkToElementModel(self, nil, false, function(model)
		CallingCardsFrameWidget:setModel(model, f1_arg1)
	end)
	self:addElement(CallingCardsFrameWidget)
	self.CallingCardsFrameWidget = CallingCardsFrameWidget
	local SocialPartyLeaderIconLarge0 = CoD.Social_PartyLeaderIconLarge.new(f1_arg0, f1_arg1, 0, 0, 482.5, 505.5, 0.5, 0.5, -36.5, 36.5)
	SocialPartyLeaderIconLarge0:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	self:addElement(SocialPartyLeaderIconLarge0)
	self.SocialPartyLeaderIconLarge0 = SocialPartyLeaderIconLarge0
	local SocialPartyMemberIconLarge0 = CoD.Social_PartyMemberIconLarge.new(f1_arg0, f1_arg1, 1, 1, 3.5, 9.5, 0.5, 0.5, -35.5, 35.5)
	SocialPartyMemberIconLarge0:mergeStateConditions({
		{
			stateName = "PartyMemberTopOrMiddle",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isPartyMemberTopOrMiddle")
			end,
		},
		{
			stateName = "PartyMember",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "OtherPartyMemberTopOrMiddle",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isOtherMemberTopOrMiddle")
			end,
		},
		{
			stateName = "OtherPartyMember",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isOtherMember")
			end,
		},
	})
	SocialPartyMemberIconLarge0:linkToElementModel(SocialPartyMemberIconLarge0, "isPartyMemberTopOrMiddle", true, function(model)
		f1_arg0:updateElementState(SocialPartyMemberIconLarge0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isPartyMemberTopOrMiddle",
		})
	end)
	SocialPartyMemberIconLarge0:linkToElementModel(SocialPartyMemberIconLarge0, "isOtherMemberTopOrMiddle", true, function(model)
		f1_arg0:updateElementState(SocialPartyMemberIconLarge0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isOtherMemberTopOrMiddle",
		})
	end)
	SocialPartyMemberIconLarge0:linkToElementModel(SocialPartyMemberIconLarge0, "isOtherMember", true, function(model)
		f1_arg0:updateElementState(SocialPartyMemberIconLarge0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isOtherMember",
		})
	end)
	SocialPartyMemberIconLarge0:setAlpha(0)
	self:addElement(SocialPartyMemberIconLarge0)
	self.SocialPartyMemberIconLarge0 = SocialPartyMemberIconLarge0
	local playerName = LUI.UIText.new(0, 0, 82, 371, 0.5, 0.5, -35.5, -5.5)
	playerName.__Color = function()
		playerName:setRGB(CoD.DirectorUtility.LobbyPlayerColorByXUIDElseDefaultSelfModel(self:getModel(), "identityBadge.xuid", ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b))
	end
	playerName.__Color()
	playerName:setTTF("notosans_bold")
	playerName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	playerName:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	playerName:setBackingType(2)
	playerName:setBackingColor(0, 0, 0)
	playerName:setBackingAlpha(0.6)
	playerName:setBackingXPadding(3)
	playerName:linkToElementModel(self, "identityBadge.gamertag", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			playerName:setText(CoD.SocialUtility.CleanGamerTag(f13_local0))
		end
	end)
	self:addElement(playerName)
	self.playerName = playerName
	local f1_local9 = nil
	self.clanTag = LUI.UIElement.createFake()
	local clanTagPc = nil
	clanTagPc = CoD.Social_ManagePartyPlayerRealNameContainer.new(f1_arg0, f1_arg1, 0, 0, 82, 371, 0, 0, 34, 64)
	clanTagPc:linkToElementModel(self, nil, false, function(model)
		clanTagPc:setModel(model, f1_arg1)
	end)
	self:addElement(clanTagPc)
	self.clanTagPc = clanTagPc
	local RankIcon = CoD.Social_ManagePartyPlayerButtonRankDetails.new(f1_arg0, f1_arg1, 0, 0, 373, 432, 0, 0, 1, 75)
	RankIcon:linkToElementModel(self, nil, false, function(model)
		RankIcon:setModel(model, f1_arg1)
	end)
	self:addElement(RankIcon)
	self.RankIcon = RankIcon
	local DirectorPartyLeader = CoD.DirectorPartyLeader.new(f1_arg0, f1_arg1, 1, 1, 5, 25, 0.5, 0.5, -10, 10)
	DirectorPartyLeader:mergeStateConditions({
		{
			stateName = "IsLeader",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "isMemberLeader", 1)
			end,
		},
	})
	DirectorPartyLeader:linkToElementModel(DirectorPartyLeader, "isMemberLeader", true, function(model)
		f1_arg0:updateElementState(DirectorPartyLeader, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isMemberLeader",
		})
	end)
	DirectorPartyLeader:linkToElementModel(self, nil, false, function(model)
		DirectorPartyLeader:setModel(model, f1_arg1)
	end)
	self:addElement(DirectorPartyLeader)
	self.DirectorPartyLeader = DirectorPartyLeader
	local PartyBar = CoD.DirectorPartyBarInternal.new(f1_arg0, f1_arg1, 1, 1, 5, 10, 0, 0, 0, 76)
	PartyBar:mergeStateConditions({
		{
			stateName = "NoParty",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "isMemberLeader", 1)
			end,
		},
		{
			stateName = "PartyTopOrMiddle",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "PartyLast",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	PartyBar:linkToElementModel(PartyBar, "isMemberLeader", true, function(model)
		f1_arg0:updateElementState(PartyBar, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isMemberLeader",
		})
	end)
	PartyBar:linkToElementModel(self, nil, false, function(model)
		PartyBar:setModel(model, f1_arg1)
	end)
	self:addElement(PartyBar)
	self.PartyBar = PartyBar
	local FocusGlow = LUI.UIImage.new(-0.1, 1.09, -100, 100, 0.5, 0.5, -61, 61)
	FocusGlow:setAlpha(0)
	FocusGlow:setImage(RegisterImage(0x8E79E4E42B6714C))
	FocusGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0xDAB59B2CAE01851))
	FocusGlow:setShaderVector(0, 0, 0, 0.25, 0.25)
	FocusGlow:setShaderVector(1, 1.2, 0, 0, 0)
	FocusGlow:setupNineSliceShader(300, 300)
	self:addElement(FocusGlow)
	self.FocusGlow = FocusGlow
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	local trial = CoD.Social_PlayersListButton_Trial.new(f1_arg0, f1_arg1, 1, 1, -137, -110, 0.5, 0.5, 8.5, 35.5)
	trial:linkToElementModel(self, nil, false, function(model)
		trial:setModel(model, f1_arg1)
	end)
	self:addElement(trial)
	self.trial = trial
	playerName:linkToElementModel(self, "identityBadge.xuid", true, playerName.__Color)
	CallingCardsFrameWidget.id = "CallingCardsFrameWidget"
	CommonButtonOutline.id = "CommonButtonOutline"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Social_ManagePartyPlayerButtonInternal.__resetProperties = function(f25_arg0)
	f25_arg0.SelectorOverlay:completeAnimation()
	f25_arg0.FocusGlow:completeAnimation()
	f25_arg0.SelectorOverlay:setAlpha(0.01)
	f25_arg0.FocusGlow:setAlpha(0)
end
CoD.Social_ManagePartyPlayerButtonInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(2)
			f27_arg0.SelectorOverlay:completeAnimation()
			f27_arg0.SelectorOverlay:setAlpha(0.04)
			f27_arg0.clipFinished(f27_arg0.SelectorOverlay)
			f27_arg0.FocusGlow:completeAnimation()
			f27_arg0.FocusGlow:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.FocusGlow)
		end,
		GainChildFocus = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(2)
			local f28_local0 = function(f29_arg0)
				f28_arg0.SelectorOverlay:beginAnimation(200)
				f28_arg0.SelectorOverlay:setAlpha(0.04)
				f28_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.SelectorOverlay:completeAnimation()
			f28_arg0.SelectorOverlay:setAlpha(0.01)
			f28_local0(f28_arg0.SelectorOverlay)
			local f28_local1 = function(f30_arg0)
				f28_arg0.FocusGlow:beginAnimation(200)
				f28_arg0.FocusGlow:setAlpha(1)
				f28_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.FocusGlow:completeAnimation()
			f28_arg0.FocusGlow:setAlpha(0)
			f28_local1(f28_arg0.FocusGlow)
		end,
		LoseChildFocus = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(2)
			local f31_local0 = function(f32_arg0)
				f31_arg0.SelectorOverlay:beginAnimation(200)
				f31_arg0.SelectorOverlay:setAlpha(0.01)
				f31_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.SelectorOverlay:completeAnimation()
			f31_arg0.SelectorOverlay:setAlpha(0.04)
			f31_local0(f31_arg0.SelectorOverlay)
			local f31_local1 = function(f33_arg0)
				f31_arg0.FocusGlow:beginAnimation(200)
				f31_arg0.FocusGlow:setAlpha(0)
				f31_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.FocusGlow:completeAnimation()
			f31_arg0.FocusGlow:setAlpha(1)
			f31_local1(f31_arg0.FocusGlow)
		end,
	},
}
CoD.Social_ManagePartyPlayerButtonInternal.__onClose = function(f34_arg0)
	f34_arg0.emblem:close()
	f34_arg0.CallingCardsFrameWidget:close()
	f34_arg0.SocialPartyLeaderIconLarge0:close()
	f34_arg0.SocialPartyMemberIconLarge0:close()
	f34_arg0.playerName:close()
	f34_arg0.clanTag:close()
	f34_arg0.clanTagPc:close()
	f34_arg0.RankIcon:close()
	f34_arg0.DirectorPartyLeader:close()
	f34_arg0.PartyBar:close()
	f34_arg0.CommonButtonOutline:close()
	f34_arg0.trial:close()
end
