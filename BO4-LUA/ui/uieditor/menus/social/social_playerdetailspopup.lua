require("ui/uieditor/widgets/common/commoncenteredpopup")
require("ui/uieditor/widgets/social/social_friendinvitedlcnotification")
require("ui/uieditor/widgets/social/social_infopane_presence")
require("ui/uieditor/widgets/social/social_managepartyplayerbuttonrankdetailswithrubies")
require("ui/uieditor/widgets/social/social_optionsbuttonlist")
require("ui/uieditor/widgets/social/social_playercard")
require("ui/uieditor/widgets/social/social_playerdetailpopup_trial")
CoD.Social_PlayerDetailsPopup = InheritFrom(CoD.Menu)
LUI.createMenu.Social_PlayerDetailsPopup = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("Social_PlayerDetailsPopup", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	CoD.BaseUtility.CreateGlobalModel("lobbyPlaylist.name")
	self:setClass(CoD.Social_PlayerDetailsPopup)
	self.soundSet = "MultiplayerMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local CommomCenteredPopup = CoD.CommonCenteredPopup.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	CommomCenteredPopup.TitleText:setText(Engine[@"hash_4F9F1239CFD921FE"](0x57811D05DD35F12))
	self:addElement(CommomCenteredPopup)
	self.CommomCenteredPopup = CommomCenteredPopup
	local SocialManagePartyPlayerButton = CoD.Social_PlayerCard.new(f1_local1, f1_arg0, 0.5, 0.5, -205, 162, 0.5, 0.5, -331.5, -266.5)
	SocialManagePartyPlayerButton.clantag:setAlpha(0)
	SocialManagePartyPlayerButton.membername:setAlpha(0)
	SocialManagePartyPlayerButton:subscribeToGlobalModel(f1_arg0, "SocialPlayerInfo", "identityBadge", function(model)
		SocialManagePartyPlayerButton:setModel(model, f1_arg0)
	end)
	self:addElement(SocialManagePartyPlayerButton)
	self.SocialManagePartyPlayerButton = SocialManagePartyPlayerButton
	local title = LUI.UIText.new(0.5, 0.5, -280.5, 280.5, 0.5, 0.5, -414.5, -350.5)
	title.__Color = function()
		title:setRGB(CoD.DirectorUtility.LobbyPlayerColorByXUIDElseDefaultControllerModel(f1_arg0, "SocialPlayerInfo.identityBadge.xuid", ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b))
	end
	title.__Color()
	title:setTTF("notosans_regular")
	title:setLetterSpacing(2)
	title:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	title:subscribeToGlobalModel(f1_arg0, "SocialPlayerInfo", "identityBadge.gamertag", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			title:setText(CoD.SocialUtility.CleanGamerTag(f4_local0))
		end
	end)
	self:addElement(title)
	self.title = title
	local presence = CoD.Social_InfoPane_Presence.new(f1_local1, f1_arg0, 0.5, 0.5, -278.5, 282.5, 0.5, 0.5, -380.5, -348.5)
	presence:setAlpha(0)
	presence:subscribeToGlobalModel(f1_arg0, "SocialPlayerInfo", nil, function(model)
		presence:setModel(model, f1_arg0)
	end)
	self:addElement(presence)
	self.presence = presence
	local TrialText = CoD.Social_PlayerDetailPopup_Trial.new(f1_local1, f1_arg0, 0.5, 0.5, -158.5, 141.5, 0.5, 0.5, 390, 422)
	TrialText:setScale(1.5, 1.5)
	TrialText:subscribeToGlobalModel(f1_arg0, "SocialPlayerInfo", nil, function(model)
		TrialText:setModel(model, f1_arg0)
	end)
	self:addElement(TrialText)
	self.TrialText = TrialText
	local options = CoD.Social_OptionsButtonList.new(f1_local1, f1_arg0, 0.5, 0.5, -213, 353, 0.5, 0.5, -217.5, 343.5)
	self:addElement(options)
	self.options = options
	local optionTextBracketR = LUI.UIImage.new(0.5, 0.5, 220, 232, 0.5, 0.5, -304, -292)
	optionTextBracketR:setAlpha(0.5)
	optionTextBracketR:setImage(RegisterImage(@"hash_634B555F15CDD010"))
	optionTextBracketR:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	optionTextBracketR:setShaderVector(0, 3, 0, 0, 0)
	self:addElement(optionTextBracketR)
	self.optionTextBracketR = optionTextBracketR
	local optionTextBracketL = LUI.UIImage.new(0.5, 0.5, -232, -220, 0.5, 0.5, -304, -292)
	optionTextBracketL:setAlpha(0.5)
	optionTextBracketL:setZRot(180)
	optionTextBracketL:setImage(RegisterImage(@"hash_634B555F15CDD010"))
	optionTextBracketL:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	optionTextBracketL:setShaderVector(0, 3, 0, 0, 0)
	self:addElement(optionTextBracketL)
	self.optionTextBracketL = optionTextBracketL
	local cornerBracket = LUI.UIImage.new(0.5, 0.5, -229, -217, 0.5, 0.5, -343, -331)
	cornerBracket:setAlpha(0.5)
	cornerBracket:setZRot(180)
	cornerBracket:setImage(RegisterImage("uie_ui_menu_social_corner_bracket"))
	cornerBracket:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(cornerBracket)
	self.cornerBracket = cornerBracket
	local cornerBracket4 = LUI.UIImage.new(0.5, 0.5, -229, -217, 0.5, 0.5, -267, -255)
	cornerBracket4:setAlpha(0.5)
	cornerBracket4:setZRot(270)
	cornerBracket4:setImage(RegisterImage("uie_ui_menu_social_corner_bracket"))
	cornerBracket4:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(cornerBracket4)
	self.cornerBracket4 = cornerBracket4
	local cornerBracket2 = LUI.UIImage.new(0.5, 0.5, 216, 228, 0.5, 0.5, -343, -331)
	cornerBracket2:setAlpha(0.5)
	cornerBracket2:setZRot(90)
	cornerBracket2:setImage(RegisterImage("uie_ui_menu_social_corner_bracket"))
	cornerBracket2:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(cornerBracket2)
	self.cornerBracket2 = cornerBracket2
	local cornerBracket3 = LUI.UIImage.new(0.5, 0.5, 216, 228, 0.5, 0.5, -267, -255)
	cornerBracket3:setAlpha(0.5)
	cornerBracket3:setImage(RegisterImage("uie_ui_menu_social_corner_bracket"))
	cornerBracket3:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(cornerBracket3)
	self.cornerBracket3 = cornerBracket3
	local Image = LUI.UIImage.new(0.5, 0.5, -213, 213, 0.5, 0.5, -341, -339)
	Image:setAlpha(0.01)
	self:addElement(Image)
	self.Image = Image
	local Image2 = LUI.UIImage.new(0.5, 0.5, -213, 213, 0.5, 0.5, -259, -257)
	Image2:setAlpha(0.01)
	self:addElement(Image2)
	self.Image2 = Image2
	local SocialFriendInviteDLCNotification = CoD.Social_FriendInviteDLCNotification.new(f1_local1, f1_arg0, 0.5, 0.5, -303, 312, 0.5, 0.5, 332.5, 393.5)
	SocialFriendInviteDLCNotification:linkToElementModel(self, nil, false, function(model)
		SocialFriendInviteDLCNotification:setModel(model, f1_arg0)
	end)
	self:addElement(SocialFriendInviteDLCNotification)
	self.SocialFriendInviteDLCNotification = SocialFriendInviteDLCNotification
	local rankIcon = CoD.Social_ManagePartyPlayerButtonRankDetailsWithRubies.new(f1_local1, f1_arg0, 0.5, 0.5, 165.5, 205.5, 0.5, 0.5, -330, -268)
	rankIcon:subscribeToGlobalModel(f1_arg0, "SocialPlayerInfo", nil, function(model)
		rankIcon:setModel(model, f1_arg0)
	end)
	self:addElement(rankIcon)
	self.rankIcon = rankIcon
	local f1_local18 = title
	local f1_local19 = title.subscribeToModel
	local f1_local20 = Engine.GetModelForController(f1_arg0)
	f1_local19(f1_local18, f1_local20["SocialPlayerInfo.identityBadge.xuid"], title.__Color)
	self:mergeStateConditions({
		{
			stateName = "Arena",
			condition = function(menu, element, event)
				return IsArenaMode()
			end,
		},
	})
	f1_local18 = self
	f1_local19 = self.subscribeToModel
	f1_local20 = Engine.GetGlobalModel()
	f1_local19(f1_local18, f1_local20["lobbyRoot.lobbyNav"], function(f10_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f10_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_xbb_pscircle"], nil, function(f11_arg0, f11_arg1, f11_arg2, f11_arg3)
		GoBack(self, f11_arg2)
		ClearMenuSavedState(f11_arg1)
		return true
	end, function(f12_arg0, f12_arg1, f12_arg2)
		CoD.Menu.SetButtonLabel(f12_arg1, Enum.LUIButton[@"lui_key_xbb_pscircle"], @"mp/back", nil, nil)
		return true
	end, false)
	CommomCenteredPopup.buttons:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		CommomCenteredPopup.id = "CommomCenteredPopup"
	end
	SocialManagePartyPlayerButton.id = "SocialManagePartyPlayerButton"
	options.id = "options"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = options
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local19 = self
	CoD.BaseUtility.SetModelFromPropertyModel(f1_arg0, self, self)
	MakeNotFocusable(SocialManagePartyPlayerButton, f1_arg0)
	return self
end
CoD.Social_PlayerDetailsPopup.__onClose = function(f13_arg0)
	f13_arg0.CommomCenteredPopup:close()
	f13_arg0.SocialManagePartyPlayerButton:close()
	f13_arg0.title:close()
	f13_arg0.presence:close()
	f13_arg0.TrialText:close()
	f13_arg0.options:close()
	f13_arg0.SocialFriendInviteDLCNotification:close()
	f13_arg0.rankIcon:close()
end
