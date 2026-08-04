require("ui/uieditor/widgets/scrollbars/verticalcounter")
require("ui/uieditor/widgets/social/social_emptyframe")
require("ui/uieditor/widgets/social/social_infopane")
require("ui/uieditor/widgets/social/social_nofriends")
require("ui/uieditor/widgets/social/social_playerslistbutton")
require("ui/uieditor/widgets/startmenu/options/startmenuoptionsbackground")
require("ui/uieditor/widgets/pc/socialmenu/pc_socialmenu_sortbutton")
require("ui/uieditor/widgets/pc_vscrolllist")
CoD.Social_Friends = InheritFrom(LUI.UIElement)
CoD.Social_Friends.__defaultWidth = 1920
CoD.Social_Friends.__defaultHeight = 1080
CoD.Social_Friends.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_Friends)
	self.id = "Social_Friends"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = CoD.StartMenuOptionsBackground.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local EmptyFrame = CoD.Social_EmptyFrame.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	EmptyFrame:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	EmptyFrame:setAlpha(0)
	self:addElement(EmptyFrame)
	self.EmptyFrame = EmptyFrame
	local SocialNoFriends = CoD.Social_NoFriends.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0, 0, 0, 1080)
	SocialNoFriends:setAlpha(0)
	self:addElement(SocialNoFriends)
	self.SocialNoFriends = SocialNoFriends
	local f1_local4 = nil
	f1_local4 = LUI.UIElement.createFake()
	self.onlineList = f1_local4
	local playerInfo = CoD.Social_InfoPane.new(f1_arg0, f1_arg1, 0.5, 0.5, 39, 763, 0, 0, 197, 877)
	self:addElement(playerInfo)
	self.playerInfo = playerInfo
	local Title2 = LUI.UIText.new(0.5, 0.5, -479, 4, 0, 0, 175, 209)
	Title2:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Title2:setAlpha(0.8)
	Title2:setText(Engine[@"hash_4F9F1239CFD921FE"]("menu/friends_caps"))
	Title2:setTTF("ttmussels_regular")
	Title2:setLetterSpacing(2)
	Title2:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	self:addElement(Title2)
	self.Title2 = Title2
	local PCSimpleVScrollList = nil
	PCSimpleVScrollList = CoD.PC_VScrollList.new(f1_arg0, f1_arg1, 0.5, 0.5, -488, -14, 0, 0, 274, 834)
	PCSimpleVScrollList.ScrollView.View:setWidgetType(CoD.Social_PlayersListButton)
	PCSimpleVScrollList.ScrollView.View:setVerticalCount(AddWithoutPreview(0, 12))
	PCSimpleVScrollList.ScrollView.View:setVerticalCounter(CoD.verticalCounter)
	PCSimpleVScrollList.ScrollView.View:setDataSource("SocialAvailableFriendsList")
	self.__on_menuOpened_PCSimpleVScrollList = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
		local f2_local0 = PCSimpleVScrollList
		if IsElementReceivingMenuOpenEventForTheFirstTime(self.PCSimpleVScrollList) then
			CoD.PCWidgetUtility.SetFocusToFirstSelectableItemInPCScrollView(self.PCSimpleVScrollList)
			CopyScrollViewActiveModelToElementAndCacheSocialData(self, f2_arg1, f2_local0, self.playerInfo)
			CoD.PCWidgetUtility.AddScrollWheels(f2_arg2, f2_arg1, self.PCSimpleVScrollList)
		end
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_PCSimpleVScrollList)
	self:addElement(PCSimpleVScrollList)
	self.PCSimpleVScrollList = PCSimpleVScrollList
	local SortButton = nil
	SortButton = CoD.PC_SocialMenu_SortButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -228, -15, 0, 0, 223, 249)
	self:addElement(SortButton)
	self.SortButton = SortButton
	local infoBracketBot = LUI.UIImage.new(0.5, 0.5, -479, 4, 0, 0, 222, 230)
	infoBracketBot:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	infoBracketBot:setAlpha(0.1)
	infoBracketBot:setZRot(180)
	infoBracketBot:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	infoBracketBot:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_add"))
	infoBracketBot:setShaderVector(0, 0, 0, 0, 0)
	infoBracketBot:setupNineSliceShader(16, 4)
	self:addElement(infoBracketBot)
	self.infoBracketBot = infoBracketBot
	playerInfo:linkToElementModel(f1_local4, nil, false, function(model)
		playerInfo:setModel(model, f1_arg1)
	end)
	self:mergeStateConditions({
		{
			stateName = "NoFriendsPC",
			condition = function(menu, element, event)
				return IsPC() and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "SocialRoot", "visibleCount", 0)
			end,
		},
		{
			stateName = "NoFriends",
			condition = function(menu, element, event)
				return not HasFriends(f1_arg1)
			end,
		},
	})
	local f1_local10 = self
	local f1_local11 = self.subscribeToModel
	local f1_local12 = DataSources.SocialRoot.getModel(f1_arg1)
	f1_local11(f1_local10, f1_local12.visibleCount, function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "visibleCount",
		})
	end, false)
	f1_local4.id = "onlineList"
	playerInfo.id = "playerInfo"
	if CoD.isPC then
		PCSimpleVScrollList.id = "PCSimpleVScrollList"
	end
	if CoD.isPC then
		SortButton.id = "SortButton"
	end
	self.__defaultFocus = f1_local4
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_PCSimpleVScrollList)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local11 = self
	MenuHidesFreeCursor(f1_arg0, f1_arg1)
	return self
end
CoD.Social_Friends.__resetProperties = function(f8_arg0)
	f8_arg0.playerInfo:completeAnimation()
	f8_arg0.SocialNoFriends:completeAnimation()
	f8_arg0.onlineList:completeAnimation()
	f8_arg0.PCSimpleVScrollList:completeAnimation()
	f8_arg0.SortButton:completeAnimation()
	f8_arg0.EmptyFrame:completeAnimation()
	f8_arg0.Title2:completeAnimation()
	f8_arg0.infoBracketBot:completeAnimation()
	f8_arg0.playerInfo:setAlpha(1)
	f8_arg0.SocialNoFriends:setAlpha(0)
	f8_arg0.SocialNoFriends.noFriends:setText(Engine[@"hash_4F9F1239CFD921FE"]("menu/there_are_no_friends"))
	f8_arg0.onlineList:setAlpha(1)
	f8_arg0.PCSimpleVScrollList:setAlpha(1)
	f8_arg0.SortButton:setLeftRight(0.5, 0.5, -228, -15)
	f8_arg0.SortButton:setTopBottom(0, 0, 223, 249)
	f8_arg0.SortButton:setAlpha(1)
	f8_arg0.EmptyFrame:setAlpha(0)
	f8_arg0.Title2:setAlpha(0.8)
	f8_arg0.infoBracketBot:setAlpha(0.1)
end
CoD.Social_Friends.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	NoFriendsPC = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(5)
			f10_arg0.EmptyFrame:completeAnimation()
			f10_arg0.EmptyFrame:setAlpha(0.08)
			f10_arg0.clipFinished(f10_arg0.EmptyFrame)
			f10_arg0.SocialNoFriends:completeAnimation()
			f10_arg0.SocialNoFriends.noFriends:completeAnimation()
			f10_arg0.SocialNoFriends:setAlpha(1)
			f10_arg0.SocialNoFriends.noFriends:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_765A2CB730C7F61D"))
			f10_arg0.clipFinished(f10_arg0.SocialNoFriends)
			f10_arg0.onlineList:completeAnimation()
			f10_arg0.onlineList:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.onlineList)
			f10_arg0.playerInfo:completeAnimation()
			f10_arg0.playerInfo:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.playerInfo)
			f10_arg0.PCSimpleVScrollList:completeAnimation()
			f10_arg0.PCSimpleVScrollList:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.PCSimpleVScrollList)
			f10_arg0.SortButton:completeAnimation()
			f10_arg0.SortButton:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.SortButton)
		end,
	},
	NoFriends = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(7)
			f11_arg0.EmptyFrame:completeAnimation()
			f11_arg0.EmptyFrame:setAlpha(0.05)
			f11_arg0.clipFinished(f11_arg0.EmptyFrame)
			f11_arg0.SocialNoFriends:completeAnimation()
			f11_arg0.SocialNoFriends:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.SocialNoFriends)
			f11_arg0.onlineList:completeAnimation()
			f11_arg0.onlineList:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.onlineList)
			f11_arg0.playerInfo:completeAnimation()
			f11_arg0.playerInfo:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.playerInfo)
			f11_arg0.Title2:completeAnimation()
			f11_arg0.Title2:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Title2)
			f11_arg0.PCSimpleVScrollList:completeAnimation()
			f11_arg0.PCSimpleVScrollList:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.PCSimpleVScrollList)
			f11_arg0.SortButton:completeAnimation()
			f11_arg0.SortButton:setLeftRight(0.5, 0.5, -227, -14)
			f11_arg0.SortButton:setTopBottom(0, 0, 221.5, 247.5)
			f11_arg0.SortButton:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.SortButton)
			f11_arg0.infoBracketBot:completeAnimation()
			f11_arg0.infoBracketBot:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.infoBracketBot)
		end,
	},
}
CoD.Social_Friends.__onClose = function(f12_arg0)
	f12_arg0.__on_close_removeOverrides()
	f12_arg0.playerInfo:close()
	f12_arg0.Background:close()
	f12_arg0.EmptyFrame:close()
	f12_arg0.SocialNoFriends:close()
	f12_arg0.onlineList:close()
	f12_arg0.PCSimpleVScrollList:close()
	f12_arg0.SortButton:close()
end
