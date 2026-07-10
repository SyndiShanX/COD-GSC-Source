require("x64:228a7baa572b047")
require("x64:acbf06924421e35")
require("x64:3e426332d66c91e")
require("x64:6d513f0593e71df")
require("x64:9d7456f2e3445f3")
require("x64:556f545189e42ad")
require("x64:88882bece551bf0")
require("x64:e12ddba2d13fc72")
require("x64:ea71cc10a0bd874")
CoD.DirectorExpandedLobbyMemberInternal = InheritFrom(LUI.UIElement)
CoD.DirectorExpandedLobbyMemberInternal.__defaultWidth = 425
CoD.DirectorExpandedLobbyMemberInternal.__defaultHeight = 65
CoD.DirectorExpandedLobbyMemberInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateGlobalModel("lobbyPlaylist.name")
	self:setClass(CoD.DirectorExpandedLobbyMemberInternal)
	self.id = "DirectorExpandedLobbyMemberInternal"
	self.soundSet = "FrontendMain"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BackingBlur = LUI.UIImage.new(0, 0, 2, 427, 0, 0, -2, 67)
	BackingBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	BackingBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BackingBlur)
	self.BackingBlur = BackingBlur
	local FocusBrackets = CoD.CommonFocusBrackets.new(f1_arg0, f1_arg1, 0, 1, -8, 12, 0, 1, -12, 12)
	FocusBrackets:setAlpha(0)
	self:addElement(FocusBrackets)
	self.FocusBrackets = FocusBrackets
	local FocusGlow = LUI.UIImage.new(0.5, 0.5, -260.5, 264.5, 0.5, 0.5, -69, 69)
	FocusGlow:setAlpha(0)
	FocusGlow:setImage(RegisterImage(0xB8F10D49D85E9C4))
	FocusGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0xDAB59B2CAE01851))
	FocusGlow:setShaderVector(0, 0, 0, 0.24, 0.25)
	FocusGlow:setShaderVector(1, 1, 0, 0, 0)
	FocusGlow:setupNineSliceShader(100, 100)
	self:addElement(FocusGlow)
	self.FocusGlow = FocusGlow
	local BackingBorder = LUI.UIImage.new(0, 0, 2, 427, 0, 0, -2, 67)
	BackingBorder:setImage(RegisterImage(0x34839E8065B1E53))
	BackingBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	BackingBorder:setShaderVector(0, 0, 0, 0, 0)
	BackingBorder:setupNineSliceShader(196, 88)
	self:addElement(BackingBorder)
	self.BackingBorder = BackingBorder
	local BackingBorder2 = LUI.UIImage.new(0, 0, 2, 427, 0, 0, -2, 67)
	BackingBorder2:setImage(RegisterImage(0x34839E8065B1E53))
	BackingBorder2:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	BackingBorder2:setShaderVector(0, 0, 0, 0, 0)
	BackingBorder2:setupNineSliceShader(196, 88)
	self:addElement(BackingBorder2)
	self.BackingBorder2 = BackingBorder2
	local BackingRank = LUI.UIImage.new(0, 0, 334, 425, 0, 0, 0, 65)
	BackingRank:setAlpha(0.7)
	BackingRank:setImage(RegisterImage(0x34839E8065B1E53))
	BackingRank:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	BackingRank:setShaderVector(0, 0, 0, 0, 0)
	BackingRank:setupNineSliceShader(196, 88)
	self:addElement(BackingRank)
	self.BackingRank = BackingRank
	local BackingEmblem = LUI.UIImage.new(0, 0, 4, 69, 0, 0, 0, 65)
	BackingEmblem:setAlpha(0.7)
	BackingEmblem:setImage(RegisterImage(0x34839E8065B1E53))
	BackingEmblem:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	BackingEmblem:setShaderVector(0, 0, 0, 0, 0)
	BackingEmblem:setupNineSliceShader(196, 88)
	self:addElement(BackingEmblem)
	self.BackingEmblem = BackingEmblem
	local BackingEmblemTint = LUI.UIImage.new(0, 0, 4, 69, 0, 0, 0, 65)
	BackingEmblemTint:setRGB(0.04, 0.04, 0.04)
	BackingEmblemTint:setAlpha(0.5)
	self:addElement(BackingEmblemTint)
	self.BackingEmblemTint = BackingEmblemTint
	local CallingCardsFrameWidget = CoD.CallingCards_FrameWidget.new(f1_arg0, f1_arg1, 0, 0, 71.5, 331.5, 0, 0, 0, 65)
	CallingCardsFrameWidget:setRGB(0.9, 0.9, 0.9)
	CallingCardsFrameWidget:linkToElementModel(self, nil, false, function(model)
		CallingCardsFrameWidget:setModel(model, f1_arg1)
	end)
	self:addElement(CallingCardsFrameWidget)
	self.CallingCardsFrameWidget = CallingCardsFrameWidget
	local clantag = LUI.UIText.new(0, 0, 77, 319, 0, 0, 26, 42)
	clantag.__Color = function()
		clantag:setRGB(CoD.DirectorUtility.LobbyPlayerColorByXUIDElseDefaultSelfModel(self:getModel(), "xuid", 1, 1, 1))
	end
	clantag.__Color()
	clantag:setTTF("notosans_regular")
	clantag:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	clantag:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	clantag:setBackingType(2)
	clantag:setBackingColor(0, 0, 0)
	clantag:setBackingAlpha(0.9)
	clantag:setBackingXPadding(2)
	clantag:linkToElementModel(self, "clantag", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			clantag:setText(StringAsClanTag(f4_local0))
		end
	end)
	self:addElement(clantag)
	self.clantag = clantag
	local emblem = LUI.UIImage.new(0, 0, 4, 69, 0, 0, 0, 65)
	emblem:linkToElementModel(self, "xuid", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			emblem:setupPlayerEmblemByXUID(f5_local0)
		end
	end)
	self:addElement(emblem)
	self.emblem = emblem
	local TeamEmblem = LUI.UIElement.new(0, 0, 4, 69, 0, 0, 0, 65)
	TeamEmblem:setRGB(0.92, 0.92, 0.92)
	TeamEmblem:setAlpha(0)
	TeamEmblem.__Emblem_Index = function(f6_arg0)
		local f6_local0 = f6_arg0:get()
		if f6_local0 ~= nil then
			TeamEmblem:setupEmblemByEmblemIndex(CoD.ClanUtility.GetClanEmblemSlotParams(f1_arg1, f6_local0))
		end
	end
	TeamEmblem:subscribeToGlobalModel(f1_arg1, "Arena", "currentTeamId", TeamEmblem.__Emblem_Index)
	TeamEmblem.__Emblem_Index_FullPath = function()
		local f7_local0 = DataSources.Arena.getModel(f1_arg1)
		f7_local0 = f7_local0.currentTeamId
		if f7_local0 then
			TeamEmblem.__Emblem_Index(f7_local0)
		end
	end
	self:addElement(TeamEmblem)
	self.TeamEmblem = TeamEmblem
	local membername = CoD.DirectorLobbyMemberName.new(f1_arg0, f1_arg1, 0, 0, 77, 327, 0, 0, 4.5, 25.5)
	membername:linkToElementModel(self, nil, false, function(model)
		membername:setModel(model, f1_arg1)
	end)
	self:addElement(membername)
	self.membername = membername
	local BackingRankTint = LUI.UIImage.new(0, 0, 334, 425, 0, 0, 0, 65)
	BackingRankTint:setRGB(0.04, 0.04, 0.04)
	BackingRankTint:setAlpha(0.5)
	self:addElement(BackingRankTint)
	self.BackingRankTint = BackingRankTint
	local CornerDotBRAnim = LUI.UIImage.new(0, 0, 373, 374, 0, 0, 63.5, 64.5)
	CornerDotBRAnim:setAlpha(0)
	self:addElement(CornerDotBRAnim)
	self.CornerDotBRAnim = CornerDotBRAnim
	local CornerLineBRAnim = LUI.UIImage.new(0, 0, 373, 374, 0, 0, 0.5, 1.5)
	CornerLineBRAnim:setAlpha(0)
	self:addElement(CornerLineBRAnim)
	self.CornerLineBRAnim = CornerLineBRAnim
	local CornerDotBRAnim2 = LUI.UIImage.new(0, 0, 114, 115, 0, 0, 63.5, 64.5)
	CornerDotBRAnim2:setAlpha(0)
	self:addElement(CornerDotBRAnim2)
	self.CornerDotBRAnim2 = CornerDotBRAnim2
	local CornerLineBRAnim4 = LUI.UIImage.new(0, 0, 114, 115, 0, 0, 0.5, 1.5)
	CornerLineBRAnim4:setAlpha(0)
	self:addElement(CornerLineBRAnim4)
	self.CornerLineBRAnim4 = CornerLineBRAnim4
	local VoipWaves = CoD.OnOffVoip.new(f1_arg0, f1_arg1, 0, 0, -53, 11, 0, 0, 15, 50)
	VoipWaves:setZRot(90)
	VoipWaves:linkToElementModel(self, nil, false, function(model)
		VoipWaves:setModel(model, f1_arg1)
	end)
	self:addElement(VoipWaves)
	self.VoipWaves = VoipWaves
	local CommonRankIconAndRankVertical = CoD.CommonRankIconAndRankVertical.new(f1_arg0, f1_arg1, 0, 0, 334, 425, 0, 0, 0.5, 64.5)
	CommonRankIconAndRankVertical:linkToElementModel(self, "rankInfo", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			CommonRankIconAndRankVertical:setModel(f10_local0, f1_arg1)
		end
	end)
	self:addElement(CommonRankIconAndRankVertical)
	self.CommonRankIconAndRankVertical = CommonRankIconAndRankVertical
	local CommonCornerPips = CoD.CommonCornerPips01.new(f1_arg0, f1_arg1, 0, 0, 4, 69, 0, 0, 0, 65)
	CommonCornerPips:setAlpha(0.7)
	self:addElement(CommonCornerPips)
	self.CommonCornerPips = CommonCornerPips
	local SelectionOverlay = LUI.UIImage.new(0, 0, 2, 427, 0, 0, -2, 67)
	SelectionOverlay:setAlpha(0)
	SelectionOverlay:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(SelectionOverlay)
	self.SelectionOverlay = SelectionOverlay
	local FocusBorder = LUI.UIImage.new(0, 1, 0, 4, 0, 1, -4, 4)
	FocusBorder:setRGB(0.96, 0.94, 0.78)
	FocusBorder:setAlpha(0)
	FocusBorder:setImage(RegisterImage(0xCB07CCC28498CB2))
	FocusBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FocusBorder:setShaderVector(0, 0, 0, 0, 0)
	FocusBorder:setupNineSliceShader(5, 5)
	self:addElement(FocusBorder)
	self.FocusBorder = FocusBorder
	local FrontendFrame = LUI.UIImage.new(0, 0, 1, 428, 0, 0, -3, 68)
	FrontendFrame:setAlpha(0.2)
	FrontendFrame:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrontendFrame:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrontendFrame:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrame)
	self.FrontendFrame = FrontendFrame
	local SocialMissingDLCNotification = CoD.Social_MissingDLCNotification.new(f1_arg0, f1_arg1, 0, 0, -61, -21, 0, 0, 16, 56)
	SocialMissingDLCNotification:setScale(0.68, 0.68)
	SocialMissingDLCNotification:linkToElementModel(self, nil, false, function(model)
		SocialMissingDLCNotification:setModel(model, f1_arg1)
	end)
	self:addElement(SocialMissingDLCNotification)
	self.SocialMissingDLCNotification = SocialMissingDLCNotification
	local Warnings = CoD.DirectorExpandedLobbyMemberWarnings.new(f1_arg0, f1_arg1, 0, 0, -52, -2, 0, 0, 8, 58)
	Warnings:setScale(0.68, 0.68)
	Warnings:linkToElementModel(self, nil, false, function(model)
		Warnings:setModel(model, f1_arg1)
	end)
	self:addElement(Warnings)
	self.Warnings = Warnings
	local TrialMemberIcon = CoD.DirectoExpandedLobbyMember_Trial.new(f1_arg0, f1_arg1, 0, 0, 299.5, 331.5, 0, 0, 31.5, 63.5)
	TrialMemberIcon:linkToElementModel(self, nil, false, function(model)
		TrialMemberIcon:setModel(model, f1_arg1)
	end)
	self:addElement(TrialMemberIcon)
	self.TrialMemberIcon = TrialMemberIcon
	clantag:linkToElementModel(self, "xuid", true, clantag.__Color)
	TeamEmblem:linkToElementModel(self, "storageFileType", true, TeamEmblem.__Emblem_Index_FullPath)
	self:mergeStateConditions({
		{
			stateName = "ArenaTeam",
			condition = function(menu, element, event)
				return IsArenaMode() and CoD.ArenaUtility.IsInTeam(f1_arg1)
			end,
		},
	})
	local f1_local28 = self
	local f1_local29 = self.subscribeToModel
	local f1_local30 = Engine[0x8DF2E5447F384B9]()
	f1_local29(f1_local28, f1_local30["lobbyRoot.lobbyNav"], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "Arena.currentTeamId", function(model)
		local f16_local0 = self
		UpdateSelfState(self, f1_arg1)
	end)
	CallingCardsFrameWidget.id = "CallingCardsFrameWidget"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorExpandedLobbyMemberInternal.__resetProperties = function(f17_arg0)
	f17_arg0.SelectionOverlay:completeAnimation()
	f17_arg0.FocusBrackets:completeAnimation()
	f17_arg0.FocusBorder:completeAnimation()
	f17_arg0.FocusGlow:completeAnimation()
	f17_arg0.CommonRankIconAndRankVertical:completeAnimation()
	f17_arg0.TeamEmblem:completeAnimation()
	f17_arg0.emblem:completeAnimation()
	f17_arg0.SelectionOverlay:setAlpha(0)
	f17_arg0.FocusBrackets:setLeftRight(0, 1, -8, 12)
	f17_arg0.FocusBrackets:setTopBottom(0, 1, -12, 12)
	f17_arg0.FocusBrackets:setAlpha(0)
	f17_arg0.FocusBorder:setAlpha(0)
	f17_arg0.FocusGlow:setAlpha(0)
	f17_arg0.CommonRankIconAndRankVertical:setAlpha(1)
	f17_arg0.TeamEmblem:setAlpha(0)
	f17_arg0.emblem:setAlpha(1)
end
CoD.DirectorExpandedLobbyMemberInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(4)
			f19_arg0.FocusBrackets:completeAnimation()
			f19_arg0.FocusBrackets:setLeftRight(0, 1, -8, 12)
			f19_arg0.FocusBrackets:setTopBottom(0, 1, -12, 12)
			f19_arg0.FocusBrackets:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.FocusBrackets)
			f19_arg0.FocusGlow:completeAnimation()
			f19_arg0.FocusGlow:setAlpha(0.6)
			f19_arg0.clipFinished(f19_arg0.FocusGlow)
			f19_arg0.SelectionOverlay:completeAnimation()
			f19_arg0.SelectionOverlay:setAlpha(0.01)
			f19_arg0.clipFinished(f19_arg0.SelectionOverlay)
			f19_arg0.FocusBorder:completeAnimation()
			f19_arg0.FocusBorder:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.FocusBorder)
		end,
		GainFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(4)
			local f20_local0 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					f22_arg0:beginAnimation(50, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f22_arg0:setLeftRight(0, 1, -8, 12)
					f22_arg0:setTopBottom(0, 1, -12, 12)
					f22_arg0:setAlpha(1)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
				end
				f20_arg0.FocusBrackets:beginAnimation(100)
				f20_arg0.FocusBrackets:setLeftRight(0, 1, -6, 10)
				f20_arg0.FocusBrackets:setTopBottom(0, 1, -10, 10)
				f20_arg0.FocusBrackets:setAlpha(0.75)
				f20_arg0.FocusBrackets:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.FocusBrackets:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f20_arg0.FocusBrackets:completeAnimation()
			f20_arg0.FocusBrackets:setLeftRight(0, 1, -38, 42)
			f20_arg0.FocusBrackets:setTopBottom(0, 1, -42, 42)
			f20_arg0.FocusBrackets:setAlpha(0)
			f20_local0(f20_arg0.FocusBrackets)
			local f20_local1 = function(f23_arg0)
				f20_arg0.FocusGlow:beginAnimation(200)
				f20_arg0.FocusGlow:setAlpha(0.6)
				f20_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.FocusGlow:completeAnimation()
			f20_arg0.FocusGlow:setAlpha(0)
			f20_local1(f20_arg0.FocusGlow)
			local f20_local2 = function(f24_arg0)
				f20_arg0.SelectionOverlay:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f20_arg0.SelectionOverlay:setAlpha(0.01)
				f20_arg0.SelectionOverlay:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.SelectionOverlay:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.SelectionOverlay:completeAnimation()
			f20_arg0.SelectionOverlay:setAlpha(0)
			f20_local2(f20_arg0.SelectionOverlay)
			local f20_local3 = function(f25_arg0)
				f20_arg0.FocusBorder:beginAnimation(200)
				f20_arg0.FocusBorder:setAlpha(1)
				f20_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.FocusBorder:completeAnimation()
			f20_arg0.FocusBorder:setAlpha(0)
			f20_local3(f20_arg0.FocusBorder)
		end,
		LoseFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(2)
			local f26_local0 = function(f27_arg0)
				f26_arg0.FocusBrackets:beginAnimation(60)
				f26_arg0.FocusBrackets:setAlpha(0)
				f26_arg0.FocusBrackets:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.FocusBrackets:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.FocusBrackets:completeAnimation()
			f26_arg0.FocusBrackets:setAlpha(1)
			f26_local0(f26_arg0.FocusBrackets)
			local f26_local1 = function(f28_arg0)
				f26_arg0.SelectionOverlay:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f26_arg0.SelectionOverlay:setAlpha(0)
				f26_arg0.SelectionOverlay:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.SelectionOverlay:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.SelectionOverlay:completeAnimation()
			f26_arg0.SelectionOverlay:setAlpha(0.01)
			f26_local1(f26_arg0.SelectionOverlay)
		end,
	},
	ArenaTeam = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(3)
			f29_arg0.emblem:completeAnimation()
			f29_arg0.emblem:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.emblem)
			f29_arg0.TeamEmblem:completeAnimation()
			f29_arg0.TeamEmblem:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.TeamEmblem)
			f29_arg0.CommonRankIconAndRankVertical:completeAnimation()
			f29_arg0.CommonRankIconAndRankVertical:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.CommonRankIconAndRankVertical)
		end,
	},
}
CoD.DirectorExpandedLobbyMemberInternal.__onClose = function(f30_arg0)
	f30_arg0.FocusBrackets:close()
	f30_arg0.CallingCardsFrameWidget:close()
	f30_arg0.clantag:close()
	f30_arg0.emblem:close()
	f30_arg0.TeamEmblem:close()
	f30_arg0.membername:close()
	f30_arg0.VoipWaves:close()
	f30_arg0.CommonRankIconAndRankVertical:close()
	f30_arg0.CommonCornerPips:close()
	f30_arg0.SocialMissingDLCNotification:close()
	f30_arg0.Warnings:close()
	f30_arg0.TrialMemberIcon:close()
end
