require("x64:eb5f71d1692cef1")
require("x64:f1590e4ff8f5c5e")
require("x64:a7a38124f34a3d3")
require("x64:2721154d8bc6b19")
CoD.TabbedScoreboardScores = InheritFrom(LUI.UIElement)
CoD.TabbedScoreboardScores.__defaultWidth = 1920
CoD.TabbedScoreboardScores.__defaultHeight = 793
CoD.TabbedScoreboardScores.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "Clients.clientChangedTeam")
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "Clients.clientCount")
	CoD.ScoreboardUtility.InitScoreboardSortKey(f1_arg1)
	self:setClass(CoD.TabbedScoreboardScores)
	self.id = "TabbedScoreboardScores"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(0, 0, 235, 1685, 0, 0, 177, 676)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local TintBody03 = LUI.UIImage.new(0, 0, 235, 1685, 0, 0, 668.5, 676.5)
	TintBody03:setRGB(0, 0, 0)
	TintBody03:setAlpha(0.15)
	self:addElement(TintBody03)
	self.TintBody03 = TintBody03
	local TintBody02 = LUI.UIImage.new(0, 0, 233, 1687, 0, 0, 174.5, 678.5)
	TintBody02:setRGB(0.87, 0.87, 0.87)
	TintBody02:setAlpha(0.9)
	TintBody02:setImage(RegisterImage(0xDEEBB22EE3BB003))
	self:addElement(TintBody02)
	self.TintBody02 = TintBody02
	local TintBody01 = LUI.UIImage.new(0, 0, 235, 1685, 0, 0, 177, 185)
	TintBody01:setRGB(0, 0, 0)
	TintBody01:setAlpha(0.15)
	self:addElement(TintBody01)
	self.TintBody01 = TintBody01
	local YourTeamScores = LUI.UIList.new(f1_arg0, f1_arg1, 6, 0, nil, false, false, false, false)
	YourTeamScores:setLeftRight(0, 0, 253, 937)
	YourTeamScores:setTopBottom(0, 0, 230, 620)
	YourTeamScores:setWidgetType(CoD.TabbedScoreboardRowLeft)
	YourTeamScores:setVerticalCount(6)
	YourTeamScores:setSpacing(6)
	YourTeamScores:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	YourTeamScores:setDataSource("Clients")
	local TopBarLeft01 = YourTeamScores
	local EnemyTeamScores = YourTeamScores.subscribeToModel
	local TopBarRight01 = Engine[0x4DF5CFBC1771947](f1_arg1)
	EnemyTeamScores(TopBarLeft01, TopBarRight01.forceScoreboard, function(f2_arg0, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end, false)
	TopBarLeft01 = YourTeamScores
	EnemyTeamScores = YourTeamScores.subscribeToModel
	TopBarRight01 = Engine[0x4DF5CFBC1771947](f1_arg1)
	EnemyTeamScores(TopBarLeft01, TopBarRight01["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end, false)
	TopBarLeft01 = YourTeamScores
	EnemyTeamScores = YourTeamScores.subscribeToModel
	TopBarRight01 = Engine[0x4DF5CFBC1771947](f1_arg1)
	EnemyTeamScores(TopBarLeft01, TopBarRight01["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f4_arg0, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end, false)
	YourTeamScores:registerEventHandler("list_item_gain_focus", function(element, event)
		local f5_local0 = nil
		CoD.ScoreboardUtility.SetCurrentFocusedClient(element, f1_arg1)
		return f5_local0
	end)
	YourTeamScores:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.ScoreboardUtility.SetSavedActiveItemToLocalPlayer(element, f1_arg1)
		CoD.CodCasterUtility.ScoreboardSetFocus(self, f1_arg1)
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(YourTeamScores, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if ScoreboardVisible(controller) then
			CoD.ScoreboardUtility.ToggleClientMute(element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if ScoreboardVisible(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(YourTeamScores, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
		if ScoreboardVisible(controller) and IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]) then
			BlockGameFromKeyEvent(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if ScoreboardVisible(controller) and IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	self:addElement(YourTeamScores)
	self.YourTeamScores = YourTeamScores
	EnemyTeamScores = LUI.UIList.new(f1_arg0, f1_arg1, 6, 0, nil, false, false, false, false)
	EnemyTeamScores:setLeftRight(0, 0, 984, 1668)
	EnemyTeamScores:setTopBottom(0, 0, 230, 620)
	EnemyTeamScores:setWidgetType(CoD.TabbedScoreboardRowRight)
	EnemyTeamScores:setVerticalCount(6)
	EnemyTeamScores:setSpacing(6)
	EnemyTeamScores:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	EnemyTeamScores:setDataSource("Clients")
	TopBarRight01 = EnemyTeamScores
	TopBarLeft01 = EnemyTeamScores.subscribeToModel
	local RankHashtagLeft = Engine[0x4DF5CFBC1771947](f1_arg1)
	TopBarLeft01(TopBarRight01, RankHashtagLeft.forceScoreboard, function(f11_arg0, f11_arg1)
		CoD.Menu.UpdateButtonShownState(f11_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f11_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end, false)
	TopBarRight01 = EnemyTeamScores
	TopBarLeft01 = EnemyTeamScores.subscribeToModel
	RankHashtagLeft = Engine[0x4DF5CFBC1771947](f1_arg1)
	TopBarLeft01(TopBarRight01, RankHashtagLeft["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f12_arg0, f12_arg1)
		CoD.Menu.UpdateButtonShownState(f12_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f12_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end, false)
	TopBarRight01 = EnemyTeamScores
	TopBarLeft01 = EnemyTeamScores.subscribeToModel
	RankHashtagLeft = Engine[0x4DF5CFBC1771947](f1_arg1)
	TopBarLeft01(TopBarRight01, RankHashtagLeft["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f13_arg0, f13_arg1)
		CoD.Menu.UpdateButtonShownState(f13_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end, false)
	EnemyTeamScores:registerEventHandler("list_item_gain_focus", function(element, event)
		local f14_local0 = nil
		CoD.ScoreboardUtility.SetCurrentFocusedClient(element, f1_arg1)
		return f14_local0
	end)
	EnemyTeamScores:registerEventHandler("gain_focus", function(element, event)
		local f15_local0 = nil
		if element.gainFocus then
			f15_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f15_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		return f15_local0
	end)
	f1_arg0:AddButtonCallbackFunction(EnemyTeamScores, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if ScoreboardVisible(controller) then
			CoD.ScoreboardUtility.ToggleClientMute(element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if ScoreboardVisible(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(EnemyTeamScores, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
		if ScoreboardVisible(controller) and IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]) then
			BlockGameFromKeyEvent(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if ScoreboardVisible(controller) and IsVisibilityBitSet(controller, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	self:addElement(EnemyTeamScores)
	self.EnemyTeamScores = EnemyTeamScores
	TopBarLeft01 = LUI.UIImage.new(0, 0, 251, 943, 0, 0, 220, 232)
	TopBarLeft01:setImage(RegisterImage(0xD8E206A00473587))
	TopBarLeft01:subscribeToGlobalModel(f1_arg1, "Factions", "alliesFactionColor", function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			TopBarLeft01:setRGB(f20_local0)
		end
	end)
	self:addElement(TopBarLeft01)
	self.TopBarLeft01 = TopBarLeft01
	TopBarRight01 = LUI.UIImage.new(0, 0, 981, 1673, 0, 0, 220, 232)
	TopBarRight01:setImage(RegisterImage(0xD8E206A00473587))
	TopBarRight01:subscribeToGlobalModel(f1_arg1, "Factions", "axisFactionColor", function(model)
		local f21_local0 = model:get()
		if f21_local0 ~= nil then
			TopBarRight01:setRGB(f21_local0)
		end
	end)
	self:addElement(TopBarRight01)
	self.TopBarRight01 = TopBarRight01
	RankHashtagLeft = LUI.UIText.new(0, 0, 253, 295, 0, 0, 197.5, 212.5)
	RankHashtagLeft:setRGB(0.7, 0.7, 0.7)
	RankHashtagLeft:setText(Engine[0xF9F1239CFD921FE](0x1F2CC836CC2EF55))
	RankHashtagLeft:setTTF("0arame_mono_stencil")
	RankHashtagLeft:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	RankHashtagLeft:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(RankHashtagLeft)
	self.RankHashtagLeft = RankHashtagLeft
	local SpecialistLeft = LUI.UIText.new(0, 0, 295.5, 684.5, 0, 0, 197.5, 212.5)
	SpecialistLeft:setRGB(0.7, 0.7, 0.7)
	SpecialistLeft:setText(Engine[0xF9F1239CFD921FE](0xE5960B3E0AF9188))
	SpecialistLeft:setTTF("0arame_mono_stencil")
	SpecialistLeft:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	SpecialistLeft:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(SpecialistLeft)
	self.SpecialistLeft = SpecialistLeft
	local SpecialistRight = LUI.UIText.new(0, 0, 1026, 1414, 0, 0, 197.5, 212.5)
	SpecialistRight:setRGB(0.7, 0.7, 0.7)
	SpecialistRight:setText(Engine[0xF9F1239CFD921FE](0xE5960B3E0AF9188))
	SpecialistRight:setTTF("0arame_mono_stencil")
	SpecialistRight:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	SpecialistRight:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(SpecialistRight)
	self.SpecialistRight = SpecialistRight
	local RankHashtagRight = LUI.UIText.new(0, 0, 986, 1028, 0, 0, 197.5, 212.5)
	RankHashtagRight:setRGB(0.7, 0.7, 0.7)
	RankHashtagRight:setText(Engine[0xF9F1239CFD921FE](0x1F2CC836CC2EF55))
	RankHashtagRight:setTTF("0arame_mono_stencil")
	RankHashtagRight:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	RankHashtagRight:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(RankHashtagRight)
	self.RankHashtagRight = RankHashtagRight
	local FriendlyHeaders = CoD.TabbedScoreboardColHeaders.new(f1_arg0, f1_arg1, 0, 0, 691, 937, 0, 0, 185, 225)
	self:addElement(FriendlyHeaders)
	self.FriendlyHeaders = FriendlyHeaders
	local EnemyHeaders = CoD.TabbedScoreboardColHeaders.new(f1_arg0, f1_arg1, 0, 0, 1422, 1668, 0, 0, 185, 225)
	self:addElement(EnemyHeaders)
	self.EnemyHeaders = EnemyHeaders
	local TabbedScoreboardScoresFFA = CoD.TabbedScoreboardScoresFFA.new(f1_arg0, f1_arg1, 0, 0, 0, 1454, 0, 0, -164.5, 453.5)
	TabbedScoreboardScoresFFA:setAlpha(0)
	self:addElement(TabbedScoreboardScoresFFA)
	self.TabbedScoreboardScoresFFA = TabbedScoreboardScoresFFA
	self:mergeStateConditions({
		{
			stateName = "VisibleFFA",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "scoreboardInfo.activeTab", CoD.HUDUtility.GameStatusMode.MODE_SHOW_SCORES) and not IsGametypeTeambased()
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "scoreboardInfo.activeTab", CoD.HUDUtility.GameStatusMode.MODE_SHOW_SCORES)
			end,
		},
	})
	local f1_local16 = self
	local f1_local17 = self.subscribeToModel
	local f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local17(f1_local16, f1_local18["scoreboardInfo.activeTab"], function(f24_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "scoreboardInfo.activeTab",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f25_arg2, f25_arg3, f25_arg4)
		if IsSelfInState(self, "Visible") then
			CoD.BaseUtility.EnableNavigation(self)
			CoD.BaseUtility.EnableNavigation(self.YourTeamScores)
			CoD.BaseUtility.EnableNavigation(self.EnemyTeamScores)
		elseif IsSelfInState(self, "PC") then
			CoD.BaseUtility.EnableNavigation(self)
			CoD.BaseUtility.EnableNavigation(self.YourTeamScores)
			CoD.BaseUtility.EnableNavigation(self.EnemyTeamScores)
		else
			CoD.BaseUtility.DisableNavigation(self)
			CoD.BaseUtility.DisableNavigation(self.YourTeamScores)
			CoD.BaseUtility.DisableNavigation(self.EnemyTeamScores)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "Clients.clientChangedTeam", function(model)
		local f26_local0 = self
		CoD.GridAndListUtility.UpdateDataSourceNextFrame(self.YourTeamScores, 0)
		CoD.GridAndListUtility.UpdateDataSourceNextFrame(self.EnemyTeamScores, 50)
	end)
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "scoreboard.team1.count", function(model)
		local f27_local0 = self
		CoD.GridAndListUtility.UpdateDataSourceNextFrame(self.YourTeamScores, 0)
		CoD.GridAndListUtility.UpdateDataSourceNextFrame(self.EnemyTeamScores, 50)
	end)
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "scoreboard.team2.count", function(model)
		local f28_local0 = self
		CoD.GridAndListUtility.UpdateDataSourceNextFrame(self.YourTeamScores, 0)
		CoD.GridAndListUtility.UpdateDataSourceNextFrame(self.EnemyTeamScores, 50)
	end)
	YourTeamScores.id = "YourTeamScores"
	EnemyTeamScores.id = "EnemyTeamScores"
	TabbedScoreboardScoresFFA.id = "TabbedScoreboardScoresFFA"
	self.__defaultFocus = YourTeamScores
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local17 = self
	CoD.GridAndListUtility.KeepSelectedItemsInSync(self, "YourTeamScores", "EnemyTeamScores")
	SetFocusToElement(self, "YourTeamScores", f1_arg1)
	CoD.HUDUtility.AddCustomGainFocusWidget(self, self.EnemyTeamScores)
	CoD.HUDUtility.AddCustomGainFocusWidget(self, self.YourTeamScores)
	CoD.ScoreboardUtility.SetupResetToLocalPlayerSubscription(self, self.YourTeamScores, f1_arg1)
	f1_local17 = YourTeamScores
	if not IsInGame() then
		SetElementProperty(f1_local17, "showHealthBar", false)
		SetElementProperty(f1_local17, "friendlyTeam", true)
		CoD.FreeCursorUtility.SetListFocusIgnoresFreeCursor(f1_local17, f1_arg1)
		CoD.GridAndListUtility.SortListByControllerModelKeys(f1_arg1, f1_local17, "scoreboardInfo.sortKey0", "scoreboardInfo.sortKey1", "scoreboardInfo.sortKey2")
	else
		SetElementProperty(f1_local17, "showHealthBar", false)
		SetElementProperty(f1_local17, "friendlyTeam", true)
		CoD.GridAndListUtility.AddListUpDownNavigation(f1_arg0, self.YourTeamScores, f1_arg1)
		CoD.FreeCursorUtility.SetListFocusIgnoresFreeCursor(f1_local17, f1_arg1)
		CoD.GridAndListUtility.SortListByControllerModelKeys(f1_arg1, f1_local17, "scoreboardInfo.sortKey0", "scoreboardInfo.sortKey1", "scoreboardInfo.sortKey2")
	end
	f1_local17 = EnemyTeamScores
	if not IsInGame() then
		SetElementProperty(f1_local17, "showHealthBar", false)
		SetElementProperty(f1_local17, "enemyTeam", true)
		CoD.FreeCursorUtility.SetListFocusIgnoresFreeCursor(f1_local17, f1_arg1)
		CoD.GridAndListUtility.SortListByControllerModelKeys(f1_arg1, f1_local17, "scoreboardInfo.sortKey0", "scoreboardInfo.sortKey1", "scoreboardInfo.sortKey2")
	else
		SetElementProperty(f1_local17, "showHealthBar", false)
		SetElementProperty(f1_local17, "enemyTeam", true)
		CoD.GridAndListUtility.AddListUpDownNavigation(f1_arg0, self.EnemyTeamScores, f1_arg1)
		CoD.FreeCursorUtility.SetListFocusIgnoresFreeCursor(f1_local17, f1_arg1)
		CoD.GridAndListUtility.SortListByControllerModelKeys(f1_arg1, f1_local17, "scoreboardInfo.sortKey0", "scoreboardInfo.sortKey1", "scoreboardInfo.sortKey2")
	end
	return self
end
CoD.TabbedScoreboardScores.__resetProperties = function(f29_arg0)
	f29_arg0.YourTeamScores:completeAnimation()
	f29_arg0.EnemyTeamScores:completeAnimation()
	f29_arg0.Blur:completeAnimation()
	f29_arg0.TintBody03:completeAnimation()
	f29_arg0.TintBody02:completeAnimation()
	f29_arg0.TintBody01:completeAnimation()
	f29_arg0.TopBarLeft01:completeAnimation()
	f29_arg0.TopBarRight01:completeAnimation()
	f29_arg0.RankHashtagLeft:completeAnimation()
	f29_arg0.FriendlyHeaders:completeAnimation()
	f29_arg0.EnemyHeaders:completeAnimation()
	f29_arg0.SpecialistLeft:completeAnimation()
	f29_arg0.RankHashtagRight:completeAnimation()
	f29_arg0.SpecialistRight:completeAnimation()
	f29_arg0.TabbedScoreboardScoresFFA:completeAnimation()
	f29_arg0.YourTeamScores:setAlpha(1)
	f29_arg0.EnemyTeamScores:setAlpha(1)
	f29_arg0.Blur:setAlpha(1)
	f29_arg0.TintBody03:setAlpha(0.15)
	f29_arg0.TintBody02:setAlpha(0.9)
	f29_arg0.TintBody01:setAlpha(0.15)
	f29_arg0.TopBarLeft01:setAlpha(1)
	f29_arg0.TopBarRight01:setAlpha(1)
	f29_arg0.RankHashtagLeft:setLeftRight(0, 0, 253, 295)
	f29_arg0.RankHashtagLeft:setTopBottom(0, 0, 197.5, 212.5)
	f29_arg0.RankHashtagLeft:setAlpha(1)
	f29_arg0.FriendlyHeaders:setAlpha(1)
	f29_arg0.EnemyHeaders:setAlpha(1)
	f29_arg0.SpecialistLeft:setLeftRight(0, 0, 295.5, 684.5)
	f29_arg0.SpecialistLeft:setTopBottom(0, 0, 197.5, 212.5)
	f29_arg0.SpecialistLeft:setAlpha(1)
	f29_arg0.RankHashtagRight:setAlpha(1)
	f29_arg0.SpecialistRight:setAlpha(1)
	f29_arg0.TabbedScoreboardScoresFFA:setLeftRight(0, 0, 0, 1454)
	f29_arg0.TabbedScoreboardScoresFFA:setTopBottom(0, 0, -164.5, 453.5)
	f29_arg0.TabbedScoreboardScoresFFA:setAlpha(0)
end
CoD.TabbedScoreboardScores.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(14)
			f30_arg0.Blur:completeAnimation()
			f30_arg0.Blur:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.Blur)
			f30_arg0.TintBody03:completeAnimation()
			f30_arg0.TintBody03:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.TintBody03)
			f30_arg0.TintBody02:completeAnimation()
			f30_arg0.TintBody02:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.TintBody02)
			f30_arg0.TintBody01:completeAnimation()
			f30_arg0.TintBody01:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.TintBody01)
			f30_arg0.YourTeamScores:completeAnimation()
			f30_arg0.YourTeamScores:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.YourTeamScores)
			f30_arg0.EnemyTeamScores:completeAnimation()
			f30_arg0.EnemyTeamScores:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.EnemyTeamScores)
			f30_arg0.TopBarLeft01:completeAnimation()
			f30_arg0.TopBarLeft01:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.TopBarLeft01)
			f30_arg0.TopBarRight01:completeAnimation()
			f30_arg0.TopBarRight01:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.TopBarRight01)
			f30_arg0.RankHashtagLeft:completeAnimation()
			f30_arg0.RankHashtagLeft:setLeftRight(0, 0, 253, 295)
			f30_arg0.RankHashtagLeft:setTopBottom(0, 0, 197.5, 218.5)
			f30_arg0.RankHashtagLeft:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.RankHashtagLeft)
			f30_arg0.SpecialistLeft:completeAnimation()
			f30_arg0.SpecialistLeft:setLeftRight(0, 0, 297, 383)
			f30_arg0.SpecialistLeft:setTopBottom(0, 0, 197.5, 218.5)
			f30_arg0.SpecialistLeft:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.SpecialistLeft)
			f30_arg0.SpecialistRight:completeAnimation()
			f30_arg0.SpecialistRight:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.SpecialistRight)
			f30_arg0.RankHashtagRight:completeAnimation()
			f30_arg0.RankHashtagRight:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.RankHashtagRight)
			f30_arg0.FriendlyHeaders:completeAnimation()
			f30_arg0.FriendlyHeaders:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.FriendlyHeaders)
			f30_arg0.EnemyHeaders:completeAnimation()
			f30_arg0.EnemyHeaders:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.EnemyHeaders)
		end,
	},
	VisibleFFA = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(15)
			f31_arg0.Blur:completeAnimation()
			f31_arg0.Blur:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.Blur)
			f31_arg0.TintBody03:completeAnimation()
			f31_arg0.TintBody03:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.TintBody03)
			f31_arg0.TintBody02:completeAnimation()
			f31_arg0.TintBody02:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.TintBody02)
			f31_arg0.TintBody01:completeAnimation()
			f31_arg0.TintBody01:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.TintBody01)
			f31_arg0.YourTeamScores:completeAnimation()
			f31_arg0.YourTeamScores:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.YourTeamScores)
			f31_arg0.EnemyTeamScores:completeAnimation()
			f31_arg0.EnemyTeamScores:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.EnemyTeamScores)
			f31_arg0.TopBarLeft01:completeAnimation()
			f31_arg0.TopBarLeft01:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.TopBarLeft01)
			f31_arg0.TopBarRight01:completeAnimation()
			f31_arg0.TopBarRight01:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.TopBarRight01)
			f31_arg0.RankHashtagLeft:completeAnimation()
			f31_arg0.RankHashtagLeft:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.RankHashtagLeft)
			f31_arg0.SpecialistLeft:completeAnimation()
			f31_arg0.SpecialistLeft:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.SpecialistLeft)
			f31_arg0.SpecialistRight:completeAnimation()
			f31_arg0.SpecialistRight:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.SpecialistRight)
			f31_arg0.RankHashtagRight:completeAnimation()
			f31_arg0.RankHashtagRight:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.RankHashtagRight)
			f31_arg0.FriendlyHeaders:completeAnimation()
			f31_arg0.FriendlyHeaders:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.FriendlyHeaders)
			f31_arg0.EnemyHeaders:completeAnimation()
			f31_arg0.EnemyHeaders:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.EnemyHeaders)
			f31_arg0.TabbedScoreboardScoresFFA:completeAnimation()
			f31_arg0.TabbedScoreboardScoresFFA:setLeftRight(0.5, 0.5, -727, 727)
			f31_arg0.TabbedScoreboardScoresFFA:setTopBottom(0, 0, 92, 710)
			f31_arg0.TabbedScoreboardScoresFFA:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.TabbedScoreboardScoresFFA)
		end,
	},
	Visible = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.TabbedScoreboardScores.__onClose = function(f33_arg0)
	f33_arg0.YourTeamScores:close()
	f33_arg0.EnemyTeamScores:close()
	f33_arg0.TopBarLeft01:close()
	f33_arg0.TopBarRight01:close()
	f33_arg0.FriendlyHeaders:close()
	f33_arg0.EnemyHeaders:close()
	f33_arg0.TabbedScoreboardScoresFFA:close()
end
