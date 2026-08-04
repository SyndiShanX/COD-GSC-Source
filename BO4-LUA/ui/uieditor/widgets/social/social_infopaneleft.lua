require("ui/uieditor/widgets/callingcards/callingcards_framewidget")
require("ui/uieditor/widgets/challenges/challenges_framewidget_titlebackground")
require("ui/uieditor/widgets/common/commonsocialarrow")
require("ui/uieditor/widgets/social/social_rankiconandranklargecontainer")
require("ui/uieditor/widgets/startmenu/options/startmenuoptionsmainframe")
require("ui/uieditor/widgets/emptyfocusable")
CoD.Social_InfoPaneLeft = InheritFrom(LUI.UIElement)
CoD.Social_InfoPaneLeft.__defaultWidth = 460
CoD.Social_InfoPaneLeft.__defaultHeight = 741
CoD.Social_InfoPaneLeft.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_InfoPaneLeft)
	self.id = "Social_InfoPaneLeft"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TitleBG = CoD.Challenges_FrameWidget_TitleBackground.new(f1_arg0, f1_arg1, -0, -0, -10, 450, 0, 0, 15, 755)
	TitleBG:setAlpha(0)
	self:addElement(TitleBG)
	self.TitleBG = TitleBG
	local Background = LUI.UIImage.new(0, 0, 0, 460, 0, 0, 25.5, 740.5)
	Background:setRGB(0.09, 0.09, 0.09)
	Background:setAlpha(0.9)
	self:addElement(Background)
	self.Background = Background
	local RankFrame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 6.5, 136.5, 0, 0, 602, 732)
	RankFrame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	RankFrame:setAlpha(0.02)
	self:addElement(RankFrame)
	self.RankFrame = RankFrame
	local TiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 26, 740)
	TiledBacking:setAlpha(0.25)
	TiledBacking:setImage(RegisterImage("uie_ui_menu_specialist_hub_repeat_bg"))
	TiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking:setupNineSliceShader(196, 88)
	self:addElement(TiledBacking)
	self.TiledBacking = TiledBacking
	local EmblemFrame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0.5, 0.5, -223, 223, 0, 0, 39, 485)
	EmblemFrame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	EmblemFrame:setAlpha(0.02)
	self:addElement(EmblemFrame)
	self.EmblemFrame = EmblemFrame
	local Emblem = LUI.UIImage.new(0, 0, 7, 453, -0.06, -0.06, 82, 528)
	Emblem:setScale(0.98, 0.98)
	Emblem:linkToElementModel(self, "identityBadge.xuid", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Emblem:setupPlayerEmblemByXUID(f2_local0)
		end
	end)
	self:addElement(Emblem)
	self.Emblem = Emblem
	local CallingCardFrame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 6.5, 452.5, 1, 1, -248.5, -146.5)
	CallingCardFrame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	CallingCardFrame:setAlpha(0.02)
	self:addElement(CallingCardFrame)
	self.CallingCardFrame = CallingCardFrame
	local CallingCard = CoD.CallingCards_FrameWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -223, 223, 0.58, 0.58, 60, 162)
	CallingCard:linkToElementModel(self, "identityBadge", false, function(model)
		CallingCard:setModel(model, f1_arg1)
	end)
	self:addElement(CallingCard)
	self.CallingCard = CallingCard
	local SocialArrow = CoD.CommonSocialArrow.new(f1_arg0, f1_arg1, 0, 0, 429, 453, 0, 0, 28, 41)
	self:addElement(SocialArrow)
	self.SocialArrow = SocialArrow
	local RankIconAndRank = CoD.Social_RankIconAndRankLargeContainer.new(f1_arg0, f1_arg1, 0, 0, 6.5, 452.5, 0, 0, 600, 735)
	RankIconAndRank:linkToElementModel(self, nil, false, function(model)
		RankIconAndRank:setModel(model, f1_arg1)
	end)
	self:addElement(RankIconAndRank)
	self.RankIconAndRank = RankIconAndRank
	local emptyFocusable = nil
	emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 0, 0, 473, 0, 0, -55, 21)
	emptyFocusable:linkToElementModel(self, "identityBadge", false, function(model)
		emptyFocusable:setModel(model, f1_arg1)
	end)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local infoBracketBot = LUI.UIImage.new(0, 0, 0, 460, 0, 0, 25, 33)
	infoBracketBot:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	infoBracketBot:setAlpha(0.1)
	infoBracketBot:setZRot(180)
	infoBracketBot:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	infoBracketBot:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_add"))
	infoBracketBot:setShaderVector(0, 0, 0, 0, 0)
	infoBracketBot:setupNineSliceShader(16, 4)
	self:addElement(infoBracketBot)
	self.infoBracketBot = infoBracketBot
	local primaryPresence = LUI.UIText.new(0.5, 0.5, -230, 230, 0, 0, -40, -22)
	primaryPresence:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	primaryPresence:setTTF("dinnext_regular")
	primaryPresence:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	primaryPresence:setLetterSpacing(1)
	primaryPresence:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	primaryPresence:linkToElementModel(self, "primaryPresence", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			primaryPresence:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.SocialUtility.PrimaryPresenceToLocalizedStringDependingOnPlatform(f6_local0)))
		end
	end)
	self:addElement(primaryPresence)
	self.primaryPresence = primaryPresence
	local gamertag = LUI.UIText.new(0, 0, 0, 460, 0.5, 0.5, -392.5, -358.5)
	gamertag.__Color = function()
		gamertag:setRGB(CoD.DirectorUtility.LobbyPlayerColorByXUIDElseDefaultSelfModel(self:getModel(), "identityBadge.xuid", ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b))
	end
	gamertag.__Color()
	gamertag:setTTF("notosans_regular")
	gamertag:setLetterSpacing(2)
	gamertag:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	gamertag:setAlignment(Enum.LUIAlignment[@"hash_E821F0ECFF8D1C7"])
	gamertag:linkToElementModel(self, "gamertag", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			gamertag:setText(CoD.SocialUtility.CleanGamerTag(f8_local0))
		end
	end)
	self:addElement(gamertag)
	self.gamertag = gamertag
	gamertag:linkToElementModel(self, "identityBadge.xuid", true, gamertag.__Color)
	self:mergeStateConditions({
		{
			stateName = "NoPlayer",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "identityBadge.xuid", LuaDefine.INVALID_XUID_X64)
			end,
		},
	})
	self:linkToElementModel(self, "identityBadge.xuid", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "identityBadge.xuid",
		})
	end)
	CallingCard.id = "CallingCard"
	if CoD.isPC then
		emptyFocusable.id = "emptyFocusable"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local15 = self
	f1_local15 = gamertag
	if IsPC() then
		CoD.PCWidgetUtility.SetupRightClickableContextualPlayerMenu(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Social_InfoPaneLeft.__resetProperties = function(f11_arg0)
	f11_arg0.Emblem:completeAnimation()
	f11_arg0.CallingCard:completeAnimation()
	f11_arg0.RankIconAndRank:completeAnimation()
	f11_arg0.Emblem:setAlpha(1)
	f11_arg0.CallingCard:setAlpha(1)
	f11_arg0.RankIconAndRank:setAlpha(1)
end
CoD.Social_InfoPaneLeft.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
	NoPlayer = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			f13_arg0.Emblem:completeAnimation()
			f13_arg0.Emblem:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Emblem)
			f13_arg0.CallingCard:completeAnimation()
			f13_arg0.CallingCard:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.CallingCard)
			f13_arg0.RankIconAndRank:completeAnimation()
			f13_arg0.RankIconAndRank:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.RankIconAndRank)
		end,
	},
}
CoD.Social_InfoPaneLeft.__onClose = function(f14_arg0)
	f14_arg0.TitleBG:close()
	f14_arg0.RankFrame:close()
	f14_arg0.EmblemFrame:close()
	f14_arg0.Emblem:close()
	f14_arg0.CallingCardFrame:close()
	f14_arg0.CallingCard:close()
	f14_arg0.SocialArrow:close()
	f14_arg0.RankIconAndRank:close()
	f14_arg0.emptyFocusable:close()
	f14_arg0.primaryPresence:close()
	f14_arg0.gamertag:close()
end
