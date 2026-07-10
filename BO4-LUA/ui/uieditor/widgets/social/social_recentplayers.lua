require("x64:f315f285d876794")
require("x64:38c11a77e96e48c")
require("x64:53e6f1dc36a47c8")
require("x64:d288f163475f28")
require("x64:bf523a632054d42")
require("x64:8b8054dd7e46390")
require("x64:7889ce1e3e2e8a")
require("x64:d93d55bb6418607")
CoD.Social_RecentPlayers = InheritFrom(LUI.UIElement)
CoD.Social_RecentPlayers.__defaultWidth = 1920
CoD.Social_RecentPlayers.__defaultHeight = 1080
CoD.Social_RecentPlayers.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_RecentPlayers)
	self.id = "Social_RecentPlayers"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = CoD.StartMenuOptionsBackground.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local SocialNoFriends = CoD.Social_NoFriends.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0, 0, 0, 1080)
	SocialNoFriends:setAlpha(0)
	SocialNoFriends.noFriends:setText(Engine[0xF9F1239CFD921FE](0x575DC659C9D5D27))
	self:addElement(SocialNoFriends)
	self.SocialNoFriends = SocialNoFriends
	local f1_local3 = nil
	f1_local3 = LUI.UIElement.createFake()
	self.onlineList = f1_local3
	local playerInfo = CoD.Social_InfoPane.new(f1_arg0, f1_arg1, 0.5, 0.5, 39, 763, 0, 0, 197, 877)
	self:addElement(playerInfo)
	self.playerInfo = playerInfo
	local Title = LUI.UIText.new(0.5, 0.5, -479, 4, 0, 0, 175, 209)
	Title:setAlpha(0.8)
	Title:setText(LocalizeToUpperString(0x5F155722E34DA5C))
	Title:setTTF("ttmussels_regular")
	Title:setLetterSpacing(6)
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(Title)
	self.Title = Title
	local PCSimpleVScrollList = nil
	PCSimpleVScrollList = CoD.PC_VScrollList.new(f1_arg0, f1_arg1, 0.5, 0.5, -488, -14, 0, 0, 274, 834)
	PCSimpleVScrollList.ScrollView.View:setWidgetType(CoD.Social_PlayersListButton)
	PCSimpleVScrollList.ScrollView.View:setVerticalCount(AddWithoutPreview(0, 12))
	PCSimpleVScrollList.ScrollView.View:setVerticalCounter(CoD.verticalCounter)
	PCSimpleVScrollList.ScrollView.View:setDataSource("SocialRecentPlayersList")
	self.__on_menuOpened_PCSimpleVScrollList = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
		local f2_local0 = PCSimpleVScrollList
		if IsElementReceivingMenuOpenEventForTheFirstTime(self.PCSimpleVScrollList) then
			CoD.PCWidgetUtility.SetFocusToFirstSelectableItemInPCScrollView(self.PCSimpleVScrollList)
			CopyScrollViewActiveModelToElementAndCacheSocialData(self, f2_arg1, self.PCSimpleVScrollList, self.playerInfo)
			CoD.PCWidgetUtility.AddScrollWheels(f2_arg2, f2_arg1, self.PCSimpleVScrollList)
		end
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_PCSimpleVScrollList)
	self:addElement(PCSimpleVScrollList)
	self.PCSimpleVScrollList = PCSimpleVScrollList
	local infoBracketBot = LUI.UIImage.new(0.5, 0.5, -479, 4, 0, 0, 222, 230)
	infoBracketBot:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	infoBracketBot:setAlpha(0.1)
	infoBracketBot:setZRot(180)
	infoBracketBot:setImage(RegisterImage(0xC325BED3F226657))
	infoBracketBot:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	infoBracketBot:setShaderVector(0, 0, 0, 0, 0)
	infoBracketBot:setupNineSliceShader(16, 4)
	self:addElement(infoBracketBot)
	self.infoBracketBot = infoBracketBot
	local EmptyFrame = CoD.Social_EmptyFrame.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	EmptyFrame:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	EmptyFrame:setAlpha(0)
	self:addElement(EmptyFrame)
	self.EmptyFrame = EmptyFrame
	playerInfo:linkToElementModel(f1_local3, nil, false, function(model)
		playerInfo:setModel(model, f1_arg1)
	end)
	self:mergeStateConditions({
		{
			stateName = "NoRecentPlayers",
			condition = function(menu, element, event)
				return not HasRecentPlayers(f1_arg1)
			end,
		},
	})
	f1_local3.id = "onlineList"
	playerInfo.id = "playerInfo"
	if CoD.isPC then
		PCSimpleVScrollList.id = "PCSimpleVScrollList"
	end
	self.__defaultFocus = f1_local3
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_PCSimpleVScrollList)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local9 = self
	MenuHidesFreeCursor(f1_arg0, f1_arg1)
	return self
end
CoD.Social_RecentPlayers.__resetProperties = function(f6_arg0)
	f6_arg0.playerInfo:completeAnimation()
	f6_arg0.SocialNoFriends:completeAnimation()
	f6_arg0.onlineList:completeAnimation()
	f6_arg0.Title:completeAnimation()
	f6_arg0.infoBracketBot:completeAnimation()
	f6_arg0.EmptyFrame:completeAnimation()
	f6_arg0.playerInfo:setAlpha(1)
	f6_arg0.SocialNoFriends:setAlpha(0)
	f6_arg0.onlineList:setAlpha(1)
	f6_arg0.Title:setAlpha(0.8)
	f6_arg0.infoBracketBot:setAlpha(0.1)
	f6_arg0.EmptyFrame:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	f6_arg0.EmptyFrame:setAlpha(0)
end
CoD.Social_RecentPlayers.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	NoRecentPlayers = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(5)
			f8_arg0.SocialNoFriends:completeAnimation()
			f8_arg0.SocialNoFriends:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.SocialNoFriends)
			f8_arg0.onlineList:completeAnimation()
			f8_arg0.onlineList:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.onlineList)
			f8_arg0.playerInfo:completeAnimation()
			f8_arg0.playerInfo:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.playerInfo)
			f8_arg0.Title:completeAnimation()
			f8_arg0.Title:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Title)
			f8_arg0.infoBracketBot:completeAnimation()
			f8_arg0.infoBracketBot:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.infoBracketBot)
			f8_arg0.EmptyFrame:completeAnimation()
			f8_arg0.EmptyFrame:setRGB(0.63, 0.62, 0.61)
			f8_arg0.EmptyFrame:setAlpha(0.05)
			f8_arg0.clipFinished(f8_arg0.EmptyFrame)
		end,
	},
}
CoD.Social_RecentPlayers.__onClose = function(f9_arg0)
	f9_arg0.__on_close_removeOverrides()
	f9_arg0.playerInfo:close()
	f9_arg0.Background:close()
	f9_arg0.SocialNoFriends:close()
	f9_arg0.onlineList:close()
	f9_arg0.PCSimpleVScrollList:close()
	f9_arg0.EmptyFrame:close()
end
