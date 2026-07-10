require("x64:db806626fb64f10")
require("x64:b157ebcd8b4adcc")
local PostLoadFunc = function(f1_arg0, f1_arg1)
	f1_arg0.disablePopupOpenCloseAnim = true
end
CoD.Challenges = InheritFrom(CoD.Menu)
LUI.createMenu.Challenges = function(f2_arg0, f2_arg1)
	local self = CoD.Menu.NewForUIEditor("Challenges", f2_arg0)
	local f2_local1 = self
	self:setClass(CoD.Challenges)
	self.soundSet = "ChooseDecal"
	self:setOwner(f2_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f2_arg0)
	self.anyChildUsesUpdateState = true
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setRGB(0, 0, 0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	SceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local BGEnhancement = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGEnhancement:setRGB(0, 0, 0)
	BGEnhancement:setAlpha(0.9)
	self:addElement(BGEnhancement)
	self.BGEnhancement = BGEnhancement
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local TabFrame = LUI.UIFrame.new(f2_local1, f2_arg0, 0, 0, false)
	TabFrame:setLeftRight(0.5, 0.5, -780, 780)
	TabFrame:setTopBottom(0.5, 0.5, -380, 400)
	self:addElement(TabFrame)
	self.TabFrame = TabFrame
	local MenuFrame = CoD.GenericMenuFrameIdentity.new(f2_local1, f2_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	MenuFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_99CD580A52B2E53"))
	MenuFrame:subscribeToGlobalModel(f2_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			MenuFrame.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	self:addElement(MenuFrame)
	self.MenuFrame = MenuFrame
	local SafeAreaWidget = CoD.Challenges_SafeAreaWidget.new(f2_local1, f2_arg0, 0, 0, 0, 1920, 0, 0, 0, 1080)
	SafeAreaWidget:registerEventHandler("menu_loaded", function(element, event)
		local f4_local0 = nil
		if element.menuLoaded then
			f4_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f4_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f2_arg0)
		if not f4_local0 then
			f4_local0 = element:dispatchEventToChildren(event)
		end
		return f4_local0
	end)
	self:addElement(SafeAreaWidget)
	self.SafeAreaWidget = SafeAreaWidget
	TabFrame:linkToElementModel(SafeAreaWidget.FETabBar.Tabs.grid, "tabWidget", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			TabFrame:changeFrameWidget(f5_local0)
		end
	end)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		PlaySoundSetSound(self, "list_action")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		CoD.ChallengesUtility.SetTotalMasterInfo(f2_arg0)
	end)
	TabFrame.id = "TabFrame"
	MenuFrame:setModel(self.buttonModel, f2_arg0)
	MenuFrame.id = "MenuFrame"
	SafeAreaWidget.id = "SafeAreaWidget"
	self:processEvent({
		name = "menu_loaded",
		controller = f2_arg0,
	})
	self.__defaultFocus = TabFrame
	if CoD.isPC and (IsKeyboard(f2_arg0) or self.ignoreCursor) then
		self:restoreState(f2_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f2_arg0)
	end
	return self
end
CoD.Challenges.__onClose = function(f11_arg0)
	f11_arg0.TabFrame:close()
	f11_arg0.MenuFrame:close()
	f11_arg0.SafeAreaWidget:close()
end
