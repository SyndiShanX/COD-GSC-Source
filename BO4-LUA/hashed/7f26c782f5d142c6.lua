require("x64:d6ecdf7755aeddc")
require("x64:6fee26b35f63189")
require("x64:a18635bdb515a39")
CoD.DirectorTheater = InheritFrom(LUI.UIElement)
CoD.DirectorTheater.__defaultWidth = 1920
CoD.DirectorTheater.__defaultHeight = 1080
CoD.DirectorTheater.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.FileshareUtility.InitModels()
	self:setClass(CoD.DirectorTheater)
	self.id = "DirectorTheater"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local BGBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGBlur:setRGB(0.08, 0.08, 0.08)
	BGBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	BGBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BGBlur)
	self.BGBlur = BGBlur
	local BGBlack = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGBlack:setAlpha(0.9)
	BGBlack:setImage(RegisterImage(0x4BF88A437F4C579))
	self:addElement(BGBlack)
	self.BGBlack = BGBlack
	local CommonHeader = CoD.CommonHeader.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0, 0, 0, 67)
	CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0x60E17AB37AB4874))
	CommonHeader.subtitle.subtitle:setAlpha(0)
	CommonHeader:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	CommonHeader:registerEventHandler("menu_loaded", function(element, event)
		local f3_local0 = nil
		if element.menuLoaded then
			f3_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f3_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg1)
		end
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	local ButtonModes = LUI.UIList.new(f1_arg0, f1_arg1, 25, 0, nil, false, false, false, false)
	ButtonModes:setLeftRight(0.5, 0.5, -717.5, 917.5)
	ButtonModes:setTopBottom(0.5, 0.5, -378.5, -98.5)
	ButtonModes:setWidgetType(CoD.DirectorTheaterModeSelectButton)
	ButtonModes:setHorizontalCount(4)
	ButtonModes:setSpacing(25)
	ButtonModes:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ButtonModes:setDataSource("DirectorTheaterLandingPageModes")
	ButtonModes:linkToElementModel(ButtonModes, "locked", true, function(model, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	ButtonModes:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ButtonModes, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "locked") then
			ProcessListAction(self, element, controller, menu)
			PlaySoundAlias("uin_press_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "locked") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(ButtonModes)
	self.ButtonModes = ButtonModes
	local RecentGames = CoD.FileshareCategoryContentListMini.new(f1_arg0, f1_arg1, 0.5, 0.5, -717.5, -39.5, 0.5, 0.5, -52.5, 377.5)
	RecentGames.MiddleText:setText(LocalizeToUpperString(0xC61974356EAE960))
	self:addElement(RecentGames)
	self.RecentGames = RecentGames
	local BookmarkedGames = CoD.FileshareCategoryContentListMini.new(f1_arg0, f1_arg1, 0.5, 0.5, 40, 718, 0.5, 0.5, -52.5, 377.5)
	BookmarkedGames.MiddleText:setText(LocalizeToUpperString(0x770599226B0553A))
	BookmarkedGames.contentList:setDataSource("FilesharePublishedList")
	self:addElement(BookmarkedGames)
	self.BookmarkedGames = BookmarkedGames
	ButtonModes.id = "ButtonModes"
	RecentGames.id = "RecentGames"
	BookmarkedGames.id = "BookmarkedGames"
	self.__defaultFocus = ButtonModes
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local7 = self
	if IsInTheaterMode() then
		CoD.FileshareUtility.SetupFileshareForTheater(f1_arg1)
		CoD.FileshareUtility.SetFilterOnFileshareContentList(self.BookmarkedGames, Enum[0xA8E3D76FFA84DE1][0x9DD15D8811C2E4], 1)
	else
		CoD.FileshareUtility.SetFilterOnFileshareContentList(self.BookmarkedGames, Enum[0xA8E3D76FFA84DE1][0x9DD15D8811C2E4], 1)
	end
	return self
end
CoD.DirectorTheater.__onClose = function(f8_arg0)
	f8_arg0.CommonHeader:close()
	f8_arg0.ButtonModes:close()
	f8_arg0.RecentGames:close()
	f8_arg0.BookmarkedGames:close()
end
