require("x64:4b31e839f22a9f3")
require("x64:1bbde4283bb35f8")
require("x64:2d64ca9d3c705ce")
require("x64:131b51676141877")
require("x64:17d3422e33a0d58")
require("x64:ea788cab9c8c2f2")
require("x64:e25ce3fc750dc8f")
require("x64:72675e4fd5488ad")
require("x64:b4ca9804aae519a")
require("x64:24e2d03e4415acb")
require("x64:2675595fa323085")
require("x64:1f331b3b9d7ec0d")
require("x64:a830f5543072a43")
require("x64:d5a6dd418ced5")
CoD.directorSelect = InheritFrom(LUI.UIElement)
CoD.directorSelect.__defaultWidth = 1920
CoD.directorSelect.__defaultHeight = 1080
CoD.directorSelect.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.directorSelect)
	self.id = "directorSelect"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	backing:setRGB(0, 0, 0)
	backing:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	backing:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(backing)
	self.backing = backing
	local BackgroundImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackgroundImage:setAlpha(0.85)
	BackgroundImage:setImage(RegisterImage(@"uie_fe_cp_background"))
	self:addElement(BackgroundImage)
	self.BackgroundImage = BackgroundImage
	local FramingCornerBrackets = CoD.CommonCornerBrackets01.new(f1_arg0, f1_arg1, 0.5, 0.5, -516.5, 516.5, 0, 0, 222, 796)
	FramingCornerBrackets:setAlpha(0.1)
	self:addElement(FramingCornerBrackets)
	self.FramingCornerBrackets = FramingCornerBrackets
	local DotLineBottom = LUI.UIImage.new(0.5, 0.5, -474.5, 474.5, 0, 0, 777, 781)
	DotLineBottom:setAlpha(0.4)
	DotLineBottom:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline"))
	DotLineBottom:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	DotLineBottom:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(DotLineBottom)
	self.DotLineBottom = DotLineBottom
	local DotLineTop = LUI.UIImage.new(0.5, 0.5, -474.5, 474.5, 0, 0, 238, 242)
	DotLineTop:setAlpha(0.4)
	DotLineTop:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline"))
	DotLineTop:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	DotLineTop:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(DotLineTop)
	self.DotLineTop = DotLineTop
	local f1_local6 = nil
	self.Header = LUI.UIElement.createFake()
	local HeaderPC = nil
	HeaderPC = CoD.DirectorScreenHeader.new(f1_arg0, f1_arg1, 0.5, 0.5, -553, 81, 0.5, 0.5, -394, -297)
	HeaderPC:setAlpha(0)
	HeaderPC:setZoom(75)
	HeaderPC.Header:setText(LocalizeToUpperString(@"menu/local"))
	self:addElement(HeaderPC)
	self.HeaderPC = HeaderPC
	local DirectorLeaderActivitySelect = CoD.DirectorLeaderActivitySelect.new(f1_arg0, f1_arg1, 0.5, 0.5, -622.5, -322.5, 1, 1, -197, -147)
	DirectorLeaderActivitySelect:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	self:addElement(DirectorLeaderActivitySelect)
	self.DirectorLeaderActivitySelect = DirectorLeaderActivitySelect
	local pckeyboardNavigationRedirector2 = nil
	pckeyboardNavigationRedirector2 = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0.7, 1, 0, 0, 0.27, 0.32, -35, -35)
	self:addElement(pckeyboardNavigationRedirector2)
	self.pckeyboardNavigationRedirector2 = pckeyboardNavigationRedirector2
	local LogoBO4 = nil
	LogoBO4 = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -945, -641, 0.5, 0.5, -525, -373)
	LogoBO4:setAlpha(0)
	LogoBO4:setScale(0.8, 0.8)
	LogoBO4:setImage(RegisterImage(@"hash_3A921D8110F2D3BD"))
	self:addElement(LogoBO4)
	self.LogoBO4 = LogoBO4
	local ButtonListLeft = LUI.UIList.new(f1_arg0, f1_arg1, 15, 0, nil, false, false, false, false)
	ButtonListLeft:setLeftRight(0.5, 0.5, -725, -513)
	ButtonListLeft:setTopBottom(0, 0, 265, 510)
	ButtonListLeft:setWidgetType(CoD.DirectorPreGameButtonLeftJustified)
	ButtonListLeft:setVerticalCount(4)
	ButtonListLeft:setSpacing(15)
	ButtonListLeft:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ButtonListLeft:setFilter(function(f3_arg0)
		return f3_arg0.showOnLeft:get() == true
	end)
	ButtonListLeft:setDataSource("DirectorExtraHomeButtons")
	ButtonListLeft:linkToElementModel(ButtonListLeft, "trialLocked", true, function(model, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	ButtonListLeft:linkToElementModel(ButtonListLeft, "locked", true, function(model, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	local ButtonFeatured = ButtonListLeft
	local ButtonListRight = ButtonListLeft.subscribeToModel
	local ButtonModes = Engine[@"getglobalmodel"]()
	ButtonListRight(ButtonFeatured, ButtonModes["lobbyRoot.lobbyNav"], function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	ButtonFeatured = ButtonListLeft
	ButtonListRight = ButtonListLeft.subscribeToModel
	ButtonModes = Engine[@"getglobalmodel"]()
	ButtonListRight(ButtonFeatured, ButtonModes["lobbyRoot.gameClient.update"], function(f7_arg0, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	ButtonFeatured = ButtonListLeft
	ButtonListRight = ButtonListLeft.subscribeToModel
	ButtonModes = Engine[@"getglobalmodel"]()
	ButtonListRight(ButtonFeatured, ButtonModes["lobbyRoot.privateClient.update"], function(f8_arg0, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	ButtonListLeft:linkToElementModel(ButtonListLeft, "showForAllClients", true, function(model, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	ButtonListLeft:registerEventHandler("list_item_gain_focus", function(element, event)
		local f10_local0 = nil
		CoD.DirectorUtility.UpdateDescriptionTextFromSelectMenu(f1_arg1, element)
		return f10_local0
	end)
	ButtonListLeft:registerEventHandler("gain_focus", function(element, event)
		local f11_local0 = nil
		if element.gainFocus then
			f11_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f11_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f11_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ButtonListLeft, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "trialLocked") and AlwaysFalse() then
			OpenOverlay(self, "Store", controller)
			PlaySoundAlias("uin_toggle_generic")
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "locked") and CoD.DirectorUtility.ShowForAllClients(element, controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "trialLocked") then
			ProcessListAction(self, element, controller, menu)
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "trialLocked") and AlwaysFalse() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_4191CDDA584B4408", nil, "ui_confirm")
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "locked") and CoD.DirectorUtility.ShowForAllClients(element, controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "trialLocked") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(ButtonListLeft)
	self.ButtonListLeft = ButtonListLeft
	ButtonListRight = LUI.UIList.new(f1_arg0, f1_arg1, 15, 0, nil, false, false, false, false)
	ButtonListRight:setLeftRight(0.5, 0.5, 500, 712)
	ButtonListRight:setTopBottom(0, 0, 265, 510)
	ButtonListRight:setWidgetType(CoD.DirectorPreGameButtonLeftJustified)
	ButtonListRight:setVerticalCount(4)
	ButtonListRight:setSpacing(15)
	ButtonListRight:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ButtonListRight:setFilter(function(f14_arg0)
		return f14_arg0.showOnLeft:get() == false
	end)
	ButtonListRight:setDataSource("DirectorExtraHomeButtons")
	ButtonListRight:linkToElementModel(ButtonListRight, "locked", true, function(model, f15_arg1)
		CoD.Menu.UpdateButtonShownState(f15_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	ButtonModes = ButtonListRight
	ButtonFeatured = ButtonListRight.subscribeToModel
	local SafeAreaContainer = Engine[@"getglobalmodel"]()
	ButtonFeatured(ButtonModes, SafeAreaContainer["lobbyRoot.lobbyNav"], function(f16_arg0, f16_arg1)
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	ButtonModes = ButtonListRight
	ButtonFeatured = ButtonListRight.subscribeToModel
	SafeAreaContainer = Engine[@"getglobalmodel"]()
	ButtonFeatured(ButtonModes, SafeAreaContainer["lobbyRoot.gameClient.update"], function(f17_arg0, f17_arg1)
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	ButtonModes = ButtonListRight
	ButtonFeatured = ButtonListRight.subscribeToModel
	SafeAreaContainer = Engine[@"getglobalmodel"]()
	ButtonFeatured(ButtonModes, SafeAreaContainer["lobbyRoot.privateClient.update"], function(f18_arg0, f18_arg1)
		CoD.Menu.UpdateButtonShownState(f18_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	ButtonListRight:linkToElementModel(ButtonListRight, "showForAllClients", true, function(model, f19_arg1)
		CoD.Menu.UpdateButtonShownState(f19_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	ButtonListRight:registerEventHandler("list_item_gain_focus", function(element, event)
		local f20_local0 = nil
		CoD.DirectorUtility.UpdateDescriptionTextFromSelectMenu(f1_arg1, element)
		return f20_local0
	end)
	ButtonListRight:registerEventHandler("gain_focus", function(element, event)
		local f21_local0 = nil
		if element.gainFocus then
			f21_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f21_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f21_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ButtonListRight, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "locked") and CoD.DirectorUtility.ShowForAllClients(element, controller) then
			PlaySoundAlias("uin_toggle_generic")
			ProcessListAction(self, element, controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "locked") and CoD.DirectorUtility.ShowForAllClients(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(ButtonListRight)
	self.ButtonListRight = ButtonListRight
	ButtonFeatured = LUI.UIList.new(f1_arg0, f1_arg1, 25, 0, nil, false, false, false, false)
	ButtonFeatured:setLeftRight(0.5, 0.5, -475, 475)
	ButtonFeatured:setTopBottom(0, 0, 265, 659)
	ButtonFeatured:setWidgetType(CoD.DirectorSelectButton)
	ButtonFeatured:setHorizontalCount(3)
	ButtonFeatured:setSpacing(25)
	ButtonFeatured:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ButtonFeatured:setStaggeredIntroTime(100)
	ButtonFeatured:setDataSource("DirectorFeaturedButtons")
	ButtonFeatured:linkToElementModel(ButtonFeatured, "trialLocked", true, function(model, f24_arg1)
		CoD.Menu.UpdateButtonShownState(f24_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	SafeAreaContainer = ButtonFeatured
	ButtonModes = ButtonFeatured.subscribeToModel
	local IGRPerksDirectorButton = Engine[@"getglobalmodel"]()
	ButtonModes(SafeAreaContainer, IGRPerksDirectorButton["lobbyRoot.lobbyNav"], function(f25_arg0, f25_arg1)
		CoD.Menu.UpdateButtonShownState(f25_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	SafeAreaContainer = ButtonFeatured
	ButtonModes = ButtonFeatured.subscribeToModel
	IGRPerksDirectorButton = Engine[@"getglobalmodel"]()
	ButtonModes(SafeAreaContainer, IGRPerksDirectorButton["lobbyRoot.gameClient.update"], function(f26_arg0, f26_arg1)
		CoD.Menu.UpdateButtonShownState(f26_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	SafeAreaContainer = ButtonFeatured
	ButtonModes = ButtonFeatured.subscribeToModel
	IGRPerksDirectorButton = Engine[@"getglobalmodel"]()
	ButtonModes(SafeAreaContainer, IGRPerksDirectorButton["lobbyRoot.privateClient.update"], function(f27_arg0, f27_arg1)
		CoD.Menu.UpdateButtonShownState(f27_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	ButtonFeatured:linkToElementModel(ButtonFeatured, "showForAllClients", true, function(model, f28_arg1)
		CoD.Menu.UpdateButtonShownState(f28_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	ButtonFeatured:linkToElementModel(ButtonFeatured, "locked", true, function(model, f29_arg1)
		CoD.Menu.UpdateButtonShownState(f29_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	ButtonFeatured:linkToElementModel(ButtonFeatured, "lockState", true, function(model, f30_arg1)
		CoD.Menu.UpdateButtonShownState(f30_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	ButtonFeatured:linkToElementModel(ButtonFeatured, "mode", true, function(model, f31_arg1)
		CoD.Menu.UpdateButtonShownState(f31_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	ButtonFeatured:registerEventHandler("list_item_gain_focus", function(element, event)
		local f32_local0 = nil
		CoD.DirectorUtility.UpdateDescriptionTextFromSelectMenu(f1_arg1, element)
		CoD.BlackMarketUtility.ShowTierSkipNotification(f1_arg1, element, f1_arg0)
		return f32_local0
	end)
	ButtonFeatured:registerEventHandler("list_item_lose_focus", function(element, event)
		local f33_local0 = nil
		CoD.BlackMarketUtility.HideTierSkipNotification(f1_arg1, element, f1_arg0)
		return f33_local0
	end)
	ButtonFeatured:registerEventHandler("gain_focus", function(element, event)
		local f34_local0 = nil
		if element.gainFocus then
			f34_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f34_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f34_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ButtonFeatured, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "trialLocked") then
			OpenOverlay(self, "Store", controller)
			PlaySoundAlias("uin_toggle_generic")
			return true
		elseif CoD.DirectorUtility.ShowForAllClients(element, controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "locked") then
			ProcessListAction(self, element, controller, menu)
			PlaySoundAlias("uin_toggle_featured_playlist")
			return true
		elseif CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "lockState", Enum[@"playlistlockstate"][@"pls_required_dlc_not_available"]) then
			OpenSystemOverlay(self, menu, controller, "DownloadDLC", {
				_model = element:getModel(),
			})
			return true
		elseif CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "lockState", Enum[@"playlistlockstate"][@"hash_4BDEB566326AC98"]) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "mode", Enum[@"lobbymainmode"][@"lobby_mainmode_zm"]) then
			CoD.StoreUtility.OpenStoreToDLCPack(self, element, controller, "DirectorSelect", menu)
			return true
		elseif CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "lockState", Enum[@"playlistlockstate"][@"hash_4BDEB566326AC98"]) then
			OpenSystemOverlay(self, menu, controller, "SeasonPassUpsell", {
				_model = element:getModel(),
				_description = @"hash_475EE3FCE54AF260",
			})
			return true
		elseif CoD.DirectorUtility.ShowForAllClients(element, controller) and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "locked") then
			ProcessListLockedAction(self, element, controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "trialLocked") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_4191CDDA584B4408", nil, "ui_confirm")
			return true
		elseif CoD.DirectorUtility.ShowForAllClients(element, controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "locked") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		elseif CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "lockState", Enum[@"playlistlockstate"][@"pls_required_dlc_not_available"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		elseif CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "lockState", Enum[@"playlistlockstate"][@"hash_4BDEB566326AC98"]) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "mode", Enum[@"lobbymainmode"][@"lobby_mainmode_zm"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		elseif CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "lockState", Enum[@"playlistlockstate"][@"hash_4BDEB566326AC98"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		elseif CoD.DirectorUtility.ShowForAllClients(element, controller) and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "locked") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(ButtonFeatured)
	self.ButtonFeatured = ButtonFeatured
	ButtonModes = LUI.UIList.new(f1_arg0, f1_arg1, 25, 0, nil, false, false, false, false)
	ButtonModes:setLeftRight(0.5, 0.5, -475, 475)
	ButtonModes:setTopBottom(0, 0, 684, 754)
	ButtonModes:setWidgetType(CoD.DirectorSelectButtonGameType)
	ButtonModes:setHorizontalCount(3)
	ButtonModes:setSpacing(25)
	ButtonModes:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ButtonModes:setDataSource("DirectorPlayButtons")
	ButtonModes:linkToElementModel(ButtonModes, "trialLocked", true, function(model, f37_arg1)
		CoD.Menu.UpdateButtonShownState(f37_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	ButtonModes:linkToElementModel(ButtonModes, "locked", true, function(model, f38_arg1)
		CoD.Menu.UpdateButtonShownState(f38_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	IGRPerksDirectorButton = ButtonModes
	SafeAreaContainer = ButtonModes.subscribeToModel
	local selectionDescription = Engine[@"getglobalmodel"]()
	SafeAreaContainer(IGRPerksDirectorButton, selectionDescription["lobbyRoot.lobbyNav"], function(f39_arg0, f39_arg1)
		CoD.Menu.UpdateButtonShownState(f39_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	IGRPerksDirectorButton = ButtonModes
	SafeAreaContainer = ButtonModes.subscribeToModel
	selectionDescription = Engine[@"getglobalmodel"]()
	SafeAreaContainer(IGRPerksDirectorButton, selectionDescription["lobbyRoot.gameClient.update"], function(f40_arg0, f40_arg1)
		CoD.Menu.UpdateButtonShownState(f40_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	IGRPerksDirectorButton = ButtonModes
	SafeAreaContainer = ButtonModes.subscribeToModel
	selectionDescription = Engine[@"getglobalmodel"]()
	SafeAreaContainer(IGRPerksDirectorButton, selectionDescription["lobbyRoot.privateClient.update"], function(f41_arg0, f41_arg1)
		CoD.Menu.UpdateButtonShownState(f41_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	ButtonModes:linkToElementModel(ButtonModes, "showForAllClients", true, function(model, f42_arg1)
		CoD.Menu.UpdateButtonShownState(f42_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	ButtonModes:registerEventHandler("list_item_gain_focus", function(element, event)
		local f43_local0 = nil
		CoD.DirectorUtility.UpdateDescriptionTextFromSelectMenu(f1_arg1, element)
		CoD.BlackMarketUtility.ShowTierSkipNotification(f1_arg1, element, f1_arg0)
		return f43_local0
	end)
	ButtonModes:registerEventHandler("list_item_lose_focus", function(element, event)
		local f44_local0 = nil
		CoD.BlackMarketUtility.HideTierSkipNotification(f1_arg1, element, f1_arg0)
		return f44_local0
	end)
	ButtonModes:registerEventHandler("gain_focus", function(element, event)
		local f45_local0 = nil
		if element.gainFocus then
			f45_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f45_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f45_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ButtonModes, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "trialLocked") and AlwaysFalse() then
			OpenOverlay(self, "Store", controller)
			PlaySoundAlias("uin_toggle_generic")
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "locked") and CoD.DirectorUtility.ShowForAllClients(element, controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "trialLocked") then
			ProcessListAction(self, element, controller, menu)
			PlaySoundAlias("uin_toggle_generic")
			return true
		elseif IsPC() and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "locked") and CoD.DirectorUtility.ShowForAllClients(element, controller) then
			ProcessListLockedAction(self, element, controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "trialLocked") and AlwaysFalse() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_4191CDDA584B4408", nil, "ui_confirm")
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "locked") and CoD.DirectorUtility.ShowForAllClients(element, controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "trialLocked") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		elseif IsPC() and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "locked") and CoD.DirectorUtility.ShowForAllClients(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(ButtonModes)
	self.ButtonModes = ButtonModes
	SafeAreaContainer = CoD.DirectorSelectSafeAreaContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0, 0, 0, 1080)
	SafeAreaContainer:registerEventHandler("menu_loaded", function(element, event)
		local f48_local0 = nil
		if element.menuLoaded then
			f48_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f48_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg1)
		end
		if not f48_local0 then
			f48_local0 = element:dispatchEventToChildren(event)
		end
		return f48_local0
	end)
	self:addElement(SafeAreaContainer)
	self.SafeAreaContainer = SafeAreaContainer
	IGRPerksDirectorButton = nil
	IGRPerksDirectorButton = CoD.IGRPerksDirectorButton.new(f1_arg0, f1_arg1, 0.5, 0.5, 265, 985, 0.5, 0.5, 239, 303)
	IGRPerksDirectorButton:setScale(0.9, 0.9)
	self:addElement(IGRPerksDirectorButton)
	self.IGRPerksDirectorButton = IGRPerksDirectorButton
	selectionDescription = LUI.UIText.new(0.5, 0.5, -473, 473, 0, 0, 793, 823)
	selectionDescription:setTTF("dinnext_regular")
	selectionDescription:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	selectionDescription:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	selectionDescription:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "selectScreenDescription", function(model)
		local f49_local0 = model:get()
		if f49_local0 ~= nil then
			selectionDescription:setText(Engine[@"hash_4F9F1239CFD921FE"](f49_local0))
		end
	end)
	self:addElement(selectionDescription)
	self.selectionDescription = selectionDescription
	local PurchaseButton2 = nil
	PurchaseButton2 = CoD.PC_BnetStore_PurchaseButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -272.5, 273.5, 0, 0, 829, 890)
	PurchaseButton2:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return HideKoreaEventButton(f1_arg1)
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	PurchaseButton2:setAlpha(0)
	PurchaseButton2.ButtonTitle:setText(LocalizeToUpperString(@"hash_648B6358827FB817"))
	PurchaseButton2:registerEventHandler("gain_focus", function(element, event)
		local f52_local0 = nil
		if element.gainFocus then
			f52_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f52_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f52_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PurchaseButton2, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		OpenOverlay(self, "PC_Korea_Event_Menu", controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
		return false
	end, false)
	self:addElement(PurchaseButton2)
	self.PurchaseButton2 = PurchaseButton2
	local f1_local19 = nil
	self.DirectorTierSkipNotification = LUI.UIElement.createFake()
	local DirectorTierSkipNotification2 = nil
	DirectorTierSkipNotification2 = CoD.DirectorTierSkipNotification.new(f1_arg0, f1_arg1, 0.5, 0.5, -400, 400, 0, 0, 143, 233)
	self:addElement(DirectorTierSkipNotification2)
	self.DirectorTierSkipNotification2 = DirectorTierSkipNotification2
	local IGREventButton = nil
	IGREventButton = CoD.PC_Korea_Event_DirectorButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -225, 225, 0.5, 0.5, 293, 423)
	IGREventButton:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return HideKoreaEventButton(f1_arg1)
			end,
		},
	})
	IGREventButton.SpecialEvent:setText(LocalizeToUpperString(@"hash_648B6358827FB817"))
	IGREventButton.EventName:setText(LocalizeToUpperString(@"hash_47CD2396EF33FB1"))
	IGREventButton:registerEventHandler("gain_focus", function(element, event)
		local f56_local0 = nil
		if element.gainFocus then
			f56_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f56_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f56_local0
	end)
	f1_arg0:AddButtonCallbackFunction(IGREventButton, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if IsKoreaProgressionSpecialEventActive(controller) then
			PlaySoundAlias("uin_toggle_generic")
			OpenOverlay(self, "PC_Korea_Event_Menu", controller)
			return true
		elseif IsKoreaBonusXPSpecialEventActive(controller) then
			PlaySoundAlias("uin_toggle_generic")
			CoD.FTUEUtility.ShowFTUESequence(self, controller, "KoreaSpecialEvent")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsKoreaProgressionSpecialEventActive(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
			return false
		elseif IsKoreaBonusXPSpecialEventActive(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	self:addElement(IGREventButton)
	self.IGREventButton = IGREventButton
	local pckeyboardNavigationRedirector = nil
	pckeyboardNavigationRedirector = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0.7, 1, 0, 0, 0.74, 0.79, -35, -35)
	self:addElement(pckeyboardNavigationRedirector)
	self.pckeyboardNavigationRedirector = pckeyboardNavigationRedirector
	self:mergeStateConditions({
		{
			stateName = "OnlineOnlyDemo",
			condition = function(menu, element, event)
				return IsLobbyNetworkModeLive() and CoD.DirectorUtility.IsOnlineOnlyDemo()
			end,
		},
		{
			stateName = "OnlineWithArena",
			condition = function(menu, element, event)
				return IsLobbyNetworkModeLive() and CoD.DirectorUtility.HasArena()
			end,
		},
		{
			stateName = "Online",
			condition = function(menu, element, event)
				return IsLobbyNetworkModeLive()
			end,
		},
		{
			stateName = "OfflineRevealEvent",
			condition = function(menu, element, event)
				return IsLobbyNetworkModeLAN() and CoD.DirectorUtility.IsOfflineOnlyDemo()
			end,
		},
		{
			stateName = "OfflineWithArena",
			condition = function(menu, element, event)
				return IsLobbyNetworkModeLAN() and CoD.DirectorUtility.HasArena()
			end,
		},
		{
			stateName = "Offline",
			condition = function(menu, element, event)
				return IsLobbyNetworkModeLAN()
			end,
		},
	})
	local f1_local23 = self
	local f1_local24 = self.subscribeToModel
	local f1_local25 = Engine[@"getglobalmodel"]()
	f1_local24(f1_local23, f1_local25["lobbyRoot.lobbyNav"], function(f65_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f65_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f66_arg2, f66_arg3, f66_arg4)
		if IsPC() then
			ForceCheckDefaultPCFocus(element, f1_arg0, controller)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "childFocusLost", function(element)
		CoD.DirectorUtility.UpdateDescriptionTextFromSelectMenu(f1_arg1, element)
	end)
	if CoD.isPC then
		pckeyboardNavigationRedirector2.id = "pckeyboardNavigationRedirector2"
	end
	ButtonListLeft.id = "ButtonListLeft"
	ButtonListRight.id = "ButtonListRight"
	ButtonFeatured.id = "ButtonFeatured"
	ButtonModes.id = "ButtonModes"
	SafeAreaContainer.id = "SafeAreaContainer"
	if CoD.isPC then
		IGRPerksDirectorButton.id = "IGRPerksDirectorButton"
	end
	if CoD.isPC then
		PurchaseButton2.id = "PurchaseButton2"
	end
	if CoD.isPC then
		IGREventButton.id = "IGREventButton"
	end
	if CoD.isPC then
		pckeyboardNavigationRedirector.id = "pckeyboardNavigationRedirector"
	end
	self.__defaultFocus = ButtonFeatured
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local24 = self
	CoD.BaseUtility.SetUpPassCustomFunctionToChild(self, self.SafeAreaContainer, f1_arg1, f1_arg0, "_activateFeaturedWidget")
	CoD.CraftUtility.ValidateEquippedUGC(f1_arg1)
	CoD.WZUtility.PlayWZTrialVideo(f1_arg0, f1_arg1)
	f1_local24 = pckeyboardNavigationRedirector2
	if IsPC() then
		CoD.PCUtility.SetAsRedirectItem(f1_local24)
		CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.down, f1_local24, self.Loadouts)
	end
	f1_local24 = pckeyboardNavigationRedirector
	if IsPC() then
		CoD.PCUtility.SetAsRedirectItem(f1_local24)
		CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.up, f1_local24, self.Loadouts)
	end
	return self
end
CoD.directorSelect.__resetProperties = function(f68_arg0)
	f68_arg0.Header:completeAnimation()
	f68_arg0.HeaderPC:completeAnimation()
	f68_arg0.ButtonFeatured:completeAnimation()
	f68_arg0.ButtonModes:completeAnimation()
	f68_arg0.FramingCornerBrackets:completeAnimation()
	f68_arg0.ButtonListRight:completeAnimation()
	f68_arg0.ButtonListLeft:completeAnimation()
	f68_arg0.DotLineTop:completeAnimation()
	f68_arg0.DotLineBottom:completeAnimation()
	f68_arg0.Header:setLeftRight(0, 0, 407, 1050)
	f68_arg0.Header:setTopBottom(0, 0, 146, 246)
	f68_arg0.Header:setAlpha(0)
	f68_arg0.HeaderPC:setLeftRight(0.5, 0.5, -553, 81)
	f68_arg0.HeaderPC:setAlpha(0)
	f68_arg0.ButtonFeatured:setLeftRight(0.5, 0.5, -475, 475)
	f68_arg0.ButtonFeatured:setAlpha(1)
	f68_arg0.ButtonFeatured:setAutoScaleContent(false)
	f68_arg0.ButtonFeatured:setWidgetType(CoD.DirectorSelectButton)
	f68_arg0.ButtonFeatured:setHorizontalCount(3)
	f68_arg0.ButtonFeatured:setVerticalCount(1)
	f68_arg0.ButtonFeatured:setSpacing(25)
	f68_arg0.ButtonFeatured:setFirstElementXOffset(0)
	f68_arg0.ButtonFeatured:setFirstElementYOffset(0)
	f68_arg0.ButtonFeatured:setBalanceGridRows(false)
	f68_arg0.ButtonModes:setLeftRight(0.5, 0.5, -475, 475)
	f68_arg0.ButtonModes:setAutoScaleContent(false)
	f68_arg0.ButtonModes:setWidgetType(CoD.DirectorSelectButtonGameType)
	f68_arg0.ButtonModes:setHorizontalCount(3)
	f68_arg0.ButtonModes:setVerticalCount(1)
	f68_arg0.ButtonModes:setSpacing(25)
	f68_arg0.ButtonModes:setFirstElementXOffset(0)
	f68_arg0.ButtonModes:setFirstElementYOffset(0)
	f68_arg0.ButtonModes:setBalanceGridRows(false)
	f68_arg0.FramingCornerBrackets:setLeftRight(0.5, 0.5, -516.5, 516.5)
	f68_arg0.FramingCornerBrackets:setTopBottom(0, 0, 222, 796)
	f68_arg0.ButtonListRight:setLeftRight(0.5, 0.5, 500, 712)
	f68_arg0.ButtonListRight:setTopBottom(0, 0, 265, 510)
	f68_arg0.ButtonListLeft:setLeftRight(0.5, 0.5, -725, -513)
	f68_arg0.DotLineTop:setLeftRight(0.5, 0.5, -474.5, 474.5)
	f68_arg0.DotLineBottom:setLeftRight(0.5, 0.5, -474.5, 474.5)
end
CoD.directorSelect.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f69_arg0, f69_arg1)
			f69_arg0:__resetProperties()
			f69_arg0:setupElementClipCounter(0)
		end,
	},
	OnlineOnlyDemo = {
		DefaultClip = function(f70_arg0, f70_arg1)
			f70_arg0:__resetProperties()
			f70_arg0:setupElementClipCounter(1)
			f70_arg0.Header:completeAnimation()
			f70_arg0.Header:setAlpha(0)
			f70_arg0.clipFinished(f70_arg0.Header)
			f70_arg0.HeaderPC:completeAnimation()
			f70_arg0.HeaderPC:setAlpha(0)
			f70_arg0.clipFinished(f70_arg0.HeaderPC)
		end,
	},
	OnlineWithArena = {
		DefaultClip = function(f71_arg0, f71_arg1)
			f71_arg0:__resetProperties()
			f71_arg0:setupElementClipCounter(8)
			f71_arg0.FramingCornerBrackets:completeAnimation()
			f71_arg0.FramingCornerBrackets:setLeftRight(0.5, 0.5, -691.5, 689.5)
			f71_arg0.FramingCornerBrackets:setTopBottom(0, 0, 224, 796)
			f71_arg0.clipFinished(f71_arg0.FramingCornerBrackets)
			f71_arg0.DotLineBottom:completeAnimation()
			f71_arg0.DotLineBottom:setLeftRight(0.5, 0.5, -638, 638)
			f71_arg0.clipFinished(f71_arg0.DotLineBottom)
			f71_arg0.DotLineTop:completeAnimation()
			f71_arg0.DotLineTop:setLeftRight(0.5, 0.5, -638, 638)
			f71_arg0.clipFinished(f71_arg0.DotLineTop)
			f71_arg0.Header:completeAnimation()
			f71_arg0.Header:setLeftRight(0, 0, 186, 829)
			f71_arg0.clipFinished(f71_arg0.Header)
			f71_arg0.HeaderPC:completeAnimation()
			f71_arg0.HeaderPC:setLeftRight(0.5, 0.5, -765, -131)
			f71_arg0.clipFinished(f71_arg0.HeaderPC)
			f71_arg0.ButtonListLeft:completeAnimation()
			f71_arg0.ButtonListLeft:setLeftRight(0.5, 0.5, -887, -675)
			f71_arg0.clipFinished(f71_arg0.ButtonListLeft)
			f71_arg0.ButtonListRight:completeAnimation()
			f71_arg0.ButtonListRight:setLeftRight(0.5, 0.5, 674, 886)
			f71_arg0.ButtonListRight:setTopBottom(0, 0, 265, 510)
			f71_arg0.clipFinished(f71_arg0.ButtonListRight)
			f71_arg0.ButtonFeatured:completeAnimation()
			f71_arg0.ButtonFeatured:setLeftRight(0.5, 0.5, -637.5, 637.5)
			f71_arg0.ButtonFeatured:setAutoScaleContent(false)
			f71_arg0.ButtonFeatured:setWidgetType(CoD.DirectorSelectButton)
			f71_arg0.ButtonFeatured:setHorizontalCount(4)
			f71_arg0.ButtonFeatured:setVerticalCount(1)
			f71_arg0.ButtonFeatured:setSpacing(25)
			f71_arg0.ButtonFeatured:setFirstElementXOffset(0)
			f71_arg0.ButtonFeatured:setFirstElementYOffset(0)
			f71_arg0.ButtonFeatured:setBalanceGridRows(false)
			f71_arg0.clipFinished(f71_arg0.ButtonFeatured)
			f71_arg0.ButtonModes:completeAnimation()
			f71_arg0.ButtonModes:setLeftRight(0.5, 0.5, -637.5, 637.5)
			f71_arg0.ButtonModes:setAutoScaleContent(false)
			f71_arg0.ButtonModes:setWidgetType(CoD.DirectorSelectButtonGameType)
			f71_arg0.ButtonModes:setHorizontalCount(4)
			f71_arg0.ButtonModes:setVerticalCount(1)
			f71_arg0.ButtonModes:setSpacing(25)
			f71_arg0.ButtonModes:setFirstElementXOffset(0)
			f71_arg0.ButtonModes:setFirstElementYOffset(0)
			f71_arg0.ButtonModes:setBalanceGridRows(false)
			f71_arg0.clipFinished(f71_arg0.ButtonModes)
		end,
	},
	Online = {
		DefaultClip = function(f72_arg0, f72_arg1)
			f72_arg0:__resetProperties()
			f72_arg0:setupElementClipCounter(2)
			f72_arg0.Header:completeAnimation()
			f72_arg0.Header:setAlpha(0)
			f72_arg0.clipFinished(f72_arg0.Header)
			f72_arg0.HeaderPC:completeAnimation()
			f72_arg0.HeaderPC:setAlpha(0)
			f72_arg0.clipFinished(f72_arg0.HeaderPC)
			f72_arg0.ButtonFeatured:completeAnimation()
			f72_arg0.ButtonFeatured:setAlpha(1)
			f72_arg0.clipFinished(f72_arg0.ButtonFeatured)
		end,
	},
	OfflineRevealEvent = {
		DefaultClip = function(f73_arg0, f73_arg1)
			f73_arg0:__resetProperties()
			f73_arg0:setupElementClipCounter(1)
			f73_arg0.Header:completeAnimation()
			f73_arg0.Header:setLeftRight(0, 0, 360, 1003)
			f73_arg0.Header:setTopBottom(0, 0, 183, 283)
			f73_arg0.Header:setAlpha(0)
			f73_arg0.clipFinished(f73_arg0.Header)
			f73_arg0.HeaderPC:completeAnimation()
			f73_arg0.HeaderPC:setAlpha(1)
			f73_arg0.clipFinished(f73_arg0.HeaderPC)
		end,
	},
	OfflineWithArena = {
		DefaultClip = function(f74_arg0, f74_arg1)
			f74_arg0:__resetProperties()
			f74_arg0:setupElementClipCounter(8)
			f74_arg0.FramingCornerBrackets:completeAnimation()
			f74_arg0.FramingCornerBrackets:setLeftRight(0.5, 0.5, -691.5, 689.5)
			f74_arg0.FramingCornerBrackets:setTopBottom(0, 0, 224, 796)
			f74_arg0.clipFinished(f74_arg0.FramingCornerBrackets)
			f74_arg0.DotLineBottom:completeAnimation()
			f74_arg0.DotLineBottom:setLeftRight(0.5, 0.5, -637.5, 610.5)
			f74_arg0.clipFinished(f74_arg0.DotLineBottom)
			f74_arg0.DotLineTop:completeAnimation()
			f74_arg0.DotLineTop:setLeftRight(0.5, 0.5, -637, 637)
			f74_arg0.clipFinished(f74_arg0.DotLineTop)
			f74_arg0.Header:completeAnimation()
			f74_arg0.Header:setLeftRight(0, 0, 186, 829)
			f74_arg0.clipFinished(f74_arg0.Header)
			f74_arg0.HeaderPC:completeAnimation()
			f74_arg0.HeaderPC:setLeftRight(0.5, 0.5, -765, -131)
			f74_arg0.clipFinished(f74_arg0.HeaderPC)
			f74_arg0.ButtonListLeft:completeAnimation()
			f74_arg0.ButtonListLeft:setLeftRight(0.5, 0.5, -887, -675)
			f74_arg0.clipFinished(f74_arg0.ButtonListLeft)
			f74_arg0.ButtonListRight:completeAnimation()
			f74_arg0.ButtonListRight:setLeftRight(0.5, 0.5, 674, 886)
			f74_arg0.ButtonListRight:setTopBottom(0, 0, 265, 510)
			f74_arg0.clipFinished(f74_arg0.ButtonListRight)
			f74_arg0.ButtonFeatured:completeAnimation()
			f74_arg0.ButtonFeatured:setLeftRight(0.5, 0.5, -637.5, 637.5)
			f74_arg0.ButtonFeatured:setAutoScaleContent(false)
			f74_arg0.ButtonFeatured:setWidgetType(CoD.DirectorSelectButton)
			f74_arg0.ButtonFeatured:setHorizontalCount(4)
			f74_arg0.ButtonFeatured:setVerticalCount(1)
			f74_arg0.ButtonFeatured:setSpacing(25)
			f74_arg0.ButtonFeatured:setFirstElementXOffset(0)
			f74_arg0.ButtonFeatured:setFirstElementYOffset(0)
			f74_arg0.ButtonFeatured:setBalanceGridRows(false)
			f74_arg0.clipFinished(f74_arg0.ButtonFeatured)
			f74_arg0.ButtonModes:completeAnimation()
			f74_arg0.ButtonModes:setLeftRight(0.5, 0.5, -637.5, 637.5)
			f74_arg0.ButtonModes:setAutoScaleContent(false)
			f74_arg0.ButtonModes:setWidgetType(CoD.DirectorSelectButtonGameType)
			f74_arg0.ButtonModes:setHorizontalCount(4)
			f74_arg0.ButtonModes:setVerticalCount(1)
			f74_arg0.ButtonModes:setSpacing(25)
			f74_arg0.ButtonModes:setFirstElementXOffset(0)
			f74_arg0.ButtonModes:setFirstElementYOffset(0)
			f74_arg0.ButtonModes:setBalanceGridRows(false)
			f74_arg0.clipFinished(f74_arg0.ButtonModes)
		end,
	},
	Offline = {
		DefaultClip = function(f75_arg0, f75_arg1)
			f75_arg0:__resetProperties()
			f75_arg0:setupElementClipCounter(1)
			f75_arg0.Header:completeAnimation()
			f75_arg0.Header:setLeftRight(0, 0, 360, 1003)
			f75_arg0.Header:setTopBottom(0, 0, 183, 283)
			f75_arg0.Header:setAlpha(0)
			f75_arg0.clipFinished(f75_arg0.Header)
			f75_arg0.HeaderPC:completeAnimation()
			f75_arg0.HeaderPC:setAlpha(1)
			f75_arg0.clipFinished(f75_arg0.HeaderPC)
		end,
	},
}
CoD.directorSelect.__onClose = function(f76_arg0)
	f76_arg0.FramingCornerBrackets:close()
	f76_arg0.Header:close()
	f76_arg0.HeaderPC:close()
	f76_arg0.DirectorLeaderActivitySelect:close()
	f76_arg0.pckeyboardNavigationRedirector2:close()
	f76_arg0.ButtonListLeft:close()
	f76_arg0.ButtonListRight:close()
	f76_arg0.ButtonFeatured:close()
	f76_arg0.ButtonModes:close()
	f76_arg0.SafeAreaContainer:close()
	f76_arg0.IGRPerksDirectorButton:close()
	f76_arg0.selectionDescription:close()
	f76_arg0.PurchaseButton2:close()
	f76_arg0.DirectorTierSkipNotification:close()
	f76_arg0.DirectorTierSkipNotification2:close()
	f76_arg0.IGREventButton:close()
	f76_arg0.pckeyboardNavigationRedirector:close()
end
