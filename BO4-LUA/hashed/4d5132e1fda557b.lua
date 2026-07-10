require("x64:a48e8c806a4abe4")
require("x64:9b6351e62cb72af")
require("x64:2be41bd29828143")
require("x64:5fc8921e999f842")
require("x64:8280a5b50aa1f9a")
CoD.SpecialistHeadquartersSelectSpecialistInternal = InheritFrom(LUI.UIElement)
CoD.SpecialistHeadquartersSelectSpecialistInternal.__defaultWidth = 1920
CoD.SpecialistHeadquartersSelectSpecialistInternal.__defaultHeight = 1080
CoD.SpecialistHeadquartersSelectSpecialistInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialistHeadquartersSelectSpecialistInternal)
	self.id = "SpecialistHeadquartersSelectSpecialistInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Specialists = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, false, false, false, false)
	Specialists:setLeftRight(0.5, 0.5, -710, 90)
	Specialists:setTopBottom(0.5, 0.5, -395, -39)
	Specialists:setWidgetType(CoD.SpecialistHeadquartersSpecialist)
	Specialists:setHorizontalCount(5)
	Specialists:setVerticalCount(2)
	Specialists:setSpacing(10)
	Specialists:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Specialists:setDataSource("SpecialistHeadquartersLoadoutList")
	local SpecialistInfoSelected = Specialists
	local SpecialistInfo = Specialists.subscribeToModel
	local DossierProgress = Engine[0x8DF2E5447F384B9]()
	SpecialistInfo(SpecialistInfoSelected, DossierProgress["MapVote.timerActive"], function(f2_arg0, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	Specialists:registerEventHandler("gain_list_focus", function(element, event)
		local f3_local0 = nil
		CoD.CTUtility.SetShowChosenSpecialistListModel(f1_arg1, false)
		return f3_local0
	end)
	Specialists:registerEventHandler("lose_list_focus", function(element, event)
		local f4_local0 = nil
		CoD.CTUtility.UpdatedChosenSpecialistListModel(f1_arg1, element)
		CoD.CTUtility.SetShowChosenSpecialistListModel(f1_arg1, true)
		return f4_local0
	end)
	Specialists:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Specialists, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ENTER", function(element, menu, controller, model)
		if not CoD.LobbyUtility.MapVoteTimerActive() then
			CoD.CTUtility.SetChosenSpecialist(controller, element)
			PlaySoundAlias("uin_start_char_select")
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.LobbyUtility.MapVoteTimerActive() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xAC3B80C833B60E1, nil, "ENTER")
			return true
		else
			return false
		end
	end, false)
	self:addElement(Specialists)
	self.Specialists = Specialists
	SpecialistInfo = CoD.SpecialistHeadquartersSpecialistInfo.new(f1_arg0, f1_arg1, 0.5, 0.5, 324, 811, 0.5, 0.5, -406, 444)
	SpecialistInfo:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "SpecialistHeadquarters", "ShowChosenSpecialistList")
			end,
		},
	})
	DossierProgress = SpecialistInfo
	SpecialistInfoSelected = SpecialistInfo.subscribeToModel
	local DossierProgressSelected = DataSources.SpecialistHeadquarters.getModel(f1_arg1)
	SpecialistInfoSelected(DossierProgress, DossierProgressSelected.ShowChosenSpecialistList, function(f9_arg0)
		f1_arg0:updateElementState(SpecialistInfo, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "ShowChosenSpecialistList",
		})
	end, false)
	self:addElement(SpecialistInfo)
	self.SpecialistInfo = SpecialistInfo
	SpecialistInfoSelected = CoD.SpecialistHeadquartersSpecialistInfo.new(f1_arg0, f1_arg1, 0.5, 0.5, 324, 811, 0.5, 0.5, -406, 444)
	SpecialistInfoSelected:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "SpecialistHeadquarters", "ShowChosenSpecialistList")
			end,
		},
	})
	DossierProgressSelected = SpecialistInfoSelected
	DossierProgress = SpecialistInfoSelected.subscribeToModel
	local ShowPlayButtonHint = DataSources.SpecialistHeadquarters.getModel(f1_arg1)
	DossierProgress(DossierProgressSelected, ShowPlayButtonHint.ShowChosenSpecialistList, function(f11_arg0)
		f1_arg0:updateElementState(SpecialistInfoSelected, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "ShowChosenSpecialistList",
		})
	end, false)
	SpecialistInfoSelected:subscribeToGlobalModel(f1_arg1, "SpecialistHeadquarters", "ChosenSpecialistListModel", function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			SpecialistInfoSelected:setModel(f12_local0, f1_arg1)
		end
	end)
	self:addElement(SpecialistInfoSelected)
	self.SpecialistInfoSelected = SpecialistInfoSelected
	DossierProgress = CoD.SpecialistHeadquartersDossierProgress.new(f1_arg0, f1_arg1, 0.5, 0.5, -710, 90, 0.5, 0.5, 225, 425)
	DossierProgress:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "SpecialistHeadquarters", "ShowChosenSpecialistList")
			end,
		},
	})
	ShowPlayButtonHint = DossierProgress
	DossierProgressSelected = DossierProgress.subscribeToModel
	local PlayButton = DataSources.SpecialistHeadquarters.getModel(f1_arg1)
	DossierProgressSelected(ShowPlayButtonHint, PlayButton.ShowChosenSpecialistList, function(f14_arg0)
		f1_arg0:updateElementState(DossierProgress, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "ShowChosenSpecialistList",
		})
	end, false)
	DossierProgress:linkToElementModel(DossierProgress, "complete", true, function(model)
		f1_arg0:updateElementState(DossierProgress, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "complete",
		})
	end)
	DossierProgress:linkToElementModel(DossierProgress, "finishedTutorial", true, function(model)
		f1_arg0:updateElementState(DossierProgress, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "finishedTutorial",
		})
	end)
	self:addElement(DossierProgress)
	self.DossierProgress = DossierProgress
	DossierProgressSelected = CoD.SpecialistHeadquartersDossierProgress.new(f1_arg0, f1_arg1, 0.5, 0.5, -710, 90, 0.5, 0.5, 225, 425)
	DossierProgressSelected:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "SpecialistHeadquarters", "ShowChosenSpecialistList")
			end,
		},
	})
	PlayButton = DossierProgressSelected
	ShowPlayButtonHint = DossierProgressSelected.subscribeToModel
	local ReplayTutorial = DataSources.SpecialistHeadquarters.getModel(f1_arg1)
	ShowPlayButtonHint(PlayButton, ReplayTutorial.ShowChosenSpecialistList, function(f18_arg0)
		f1_arg0:updateElementState(DossierProgressSelected, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "ShowChosenSpecialistList",
		})
	end, false)
	DossierProgressSelected:linkToElementModel(DossierProgressSelected, "complete", true, function(model)
		f1_arg0:updateElementState(DossierProgressSelected, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "complete",
		})
	end)
	DossierProgressSelected:linkToElementModel(DossierProgressSelected, "finishedTutorial", true, function(model)
		f1_arg0:updateElementState(DossierProgressSelected, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "finishedTutorial",
		})
	end)
	DossierProgressSelected:subscribeToGlobalModel(f1_arg1, "SpecialistHeadquarters", "ChosenSpecialistListModel", function(model)
		local f21_local0 = model:get()
		if f21_local0 ~= nil then
			DossierProgressSelected:setModel(f21_local0, f1_arg1)
		end
	end)
	self:addElement(DossierProgressSelected)
	self.DossierProgressSelected = DossierProgressSelected
	ShowPlayButtonHint = CoD.ShowPlayButtonHintText.new(f1_arg0, f1_arg1, 0.5, 0.5, -710, 90, 0.5, 0.5, -425, -395)
	ShowPlayButtonHint:setAlpha(0)
	self:addElement(ShowPlayButtonHint)
	self.ShowPlayButtonHint = ShowPlayButtonHint
	PlayButton = CoD.SpecialistHeadquartersButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -510, -110, 0.5, 0.5, -9.5, 90.5)
	PlayButton:setAlpha(0)
	PlayButton:subscribeToGlobalModel(f1_arg1, "SpecialistHeadquarters", "ChosenSpecialistID", function(model)
		local f22_local0 = model:get()
		if f22_local0 ~= nil then
			PlayButton.Header:setText(LocalizeToUpperString(CoD.CTUtility.GetChosenSpecialistIDLocString(f1_arg1, f22_local0)))
		end
	end)
	PlayButton:appendEventHandler("on_session_start", function(f23_arg0, f23_arg1)
		f23_arg1.menu = f23_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f23_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	PlayButton:appendEventHandler("on_session_end", function(f24_arg0, f24_arg1)
		f24_arg1.menu = f24_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f24_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	local f1_local9 = PlayButton
	ReplayTutorial = PlayButton.subscribeToModel
	local f1_local10 = Engine[0x8DF2E5447F384B9]()
	ReplayTutorial(f1_local9, f1_local10["lobbyRoot.lobbyNav"], function(f25_arg0, f25_arg1)
		CoD.Menu.UpdateButtonShownState(f25_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local9 = PlayButton
	ReplayTutorial = PlayButton.subscribeToModel
	f1_local10 = Engine[0x8DF2E5447F384B9]()
	ReplayTutorial(f1_local9, f1_local10["lobbyRoot.gameClient.update"], function(f26_arg0, f26_arg1)
		CoD.Menu.UpdateButtonShownState(f26_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local9 = PlayButton
	ReplayTutorial = PlayButton.subscribeToModel
	f1_local10 = Engine[0x8DF2E5447F384B9]()
	ReplayTutorial(f1_local9, f1_local10["lobbyRoot.privateClient.update"], function(f27_arg0, f27_arg1)
		CoD.Menu.UpdateButtonShownState(f27_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local9 = PlayButton
	ReplayTutorial = PlayButton.subscribeToModel
	f1_local10 = Engine[0x8DF2E5447F384B9]()
	ReplayTutorial(f1_local9, f1_local10["MapVote.timerActive"], function(f28_arg0, f28_arg1)
		CoD.Menu.UpdateButtonShownState(f28_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	PlayButton:registerEventHandler("gain_focus", function(element, event)
		local f29_local0 = nil
		if element.gainFocus then
			f29_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f29_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f29_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PlayButton, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsLobbyHostOfCurrentMenu() and not CoD.LobbyUtility.MapVoteTimerActive() then
			CoD.CTUtility.RefreshChosenSpecialistParams(controller)
			CoD.CTUtility.LaunchGame(menu, self, element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsLobbyHostOfCurrentMenu() and not CoD.LobbyUtility.MapVoteTimerActive() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(PlayButton)
	self.PlayButton = PlayButton
	ReplayTutorial = CoD.SpecialistHeadquartersButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -510, -110, 0.5, 0.5, 68, 138)
	ReplayTutorial:setAlpha(0)
	ReplayTutorial.Header:setText(LocalizeToUpperString(0xEDF0CD4F8E56F3B))
	ReplayTutorial:appendEventHandler("on_session_start", function(f32_arg0, f32_arg1)
		f32_arg1.menu = f32_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f32_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	ReplayTutorial:appendEventHandler("on_session_end", function(f33_arg0, f33_arg1)
		f33_arg1.menu = f33_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f33_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	f1_local10 = ReplayTutorial
	f1_local9 = ReplayTutorial.subscribeToModel
	local f1_local11 = Engine[0x8DF2E5447F384B9]()
	f1_local9(f1_local10, f1_local11["lobbyRoot.lobbyNav"], function(f34_arg0, f34_arg1)
		CoD.Menu.UpdateButtonShownState(f34_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local10 = ReplayTutorial
	f1_local9 = ReplayTutorial.subscribeToModel
	f1_local11 = Engine[0x8DF2E5447F384B9]()
	f1_local9(f1_local10, f1_local11["lobbyRoot.gameClient.update"], function(f35_arg0, f35_arg1)
		CoD.Menu.UpdateButtonShownState(f35_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local10 = ReplayTutorial
	f1_local9 = ReplayTutorial.subscribeToModel
	f1_local11 = Engine[0x8DF2E5447F384B9]()
	f1_local9(f1_local10, f1_local11["lobbyRoot.privateClient.update"], function(f36_arg0, f36_arg1)
		CoD.Menu.UpdateButtonShownState(f36_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local10 = ReplayTutorial
	f1_local9 = ReplayTutorial.subscribeToModel
	f1_local11 = Engine[0x8DF2E5447F384B9]()
	f1_local9(f1_local10, f1_local11["MapVote.timerActive"], function(f37_arg0, f37_arg1)
		CoD.Menu.UpdateButtonShownState(f37_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	ReplayTutorial:registerEventHandler("gain_focus", function(element, event)
		local f38_local0 = nil
		if element.gainFocus then
			f38_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f38_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f38_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ReplayTutorial, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsLobbyHostOfCurrentMenu() and not CoD.LobbyUtility.MapVoteTimerActive() then
			CoD.CTUtility.SetReplayTutorial(controller)
			CoD.CTUtility.LaunchGame(menu, self, element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsLobbyHostOfCurrentMenu() and not CoD.LobbyUtility.MapVoteTimerActive() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(ReplayTutorial)
	self.ReplayTutorial = ReplayTutorial
	f1_local9 = nil
	f1_local9 = LUI.UIElement.createFake()
	self.QuitButton = f1_local9
	SpecialistInfo:linkToElementModel(Specialists, nil, false, function(model)
		SpecialistInfo:setModel(model, f1_arg1)
	end)
	DossierProgress:linkToElementModel(Specialists, nil, false, function(model)
		DossierProgress:setModel(model, f1_arg1)
	end)
	self:mergeStateConditions({
		{
			stateName = "ShowReplayTutorialButton",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "SpecialistHeadquarters", "ShowPlayButtonInSpecialistSelect") and CoD.CTUtility.ShowReplayTutorial(f1_arg1)
			end,
		},
		{
			stateName = "ShowPlayButton",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "SpecialistHeadquarters", "ShowPlayButtonInSpecialistSelect")
			end,
		},
	})
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	local f1_local12 = DataSources.SpecialistHeadquarters.getModel(f1_arg1)
	f1_local10(f1_local11, f1_local12.ShowPlayButtonInSpecialistSelect, function(f45_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f45_arg0:get(),
			modelName = "ShowPlayButtonInSpecialistSelect",
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = DataSources.SpecialistHeadquarters.getModel(f1_arg1)
	f1_local10(f1_local11, f1_local12.ChosenSpecialistID, function(f46_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f46_arg0:get(),
			modelName = "ChosenSpecialistID",
		})
	end, false)
	Specialists.id = "Specialists"
	PlayButton.id = "PlayButton"
	ReplayTutorial.id = "ReplayTutorial"
	f1_local9.id = "QuitButton"
	self.__defaultFocus = Specialists
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local10 = self
	CoD.CTUtility.UpdatedChosenSpecialistListModel(f1_arg1, Specialists)
	return self
end
CoD.SpecialistHeadquartersSelectSpecialistInternal.__resetProperties = function(f47_arg0)
	f47_arg0.ShowPlayButtonHint:completeAnimation()
	f47_arg0.PlayButton:completeAnimation()
	f47_arg0.QuitButton:completeAnimation()
	f47_arg0.ReplayTutorial:completeAnimation()
	f47_arg0.ShowPlayButtonHint:setAlpha(0)
	f47_arg0.PlayButton:setTopBottom(0.5, 0.5, -9.5, 90.5)
	f47_arg0.PlayButton:setAlpha(0)
	f47_arg0.QuitButton:setTopBottom(0.5, 0.5, 115.5, 215.5)
	f47_arg0.QuitButton:setAlpha(0)
	f47_arg0.ReplayTutorial:setTopBottom(0.5, 0.5, 68, 138)
	f47_arg0.ReplayTutorial:setAlpha(0)
end
CoD.SpecialistHeadquartersSelectSpecialistInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(0)
		end,
	},
	ShowReplayTutorialButton = {
		DefaultClip = function(f49_arg0, f49_arg1)
			f49_arg0:__resetProperties()
			f49_arg0:setupElementClipCounter(3)
			f49_arg0.ShowPlayButtonHint:completeAnimation()
			f49_arg0.ShowPlayButtonHint:setAlpha(1)
			f49_arg0.clipFinished(f49_arg0.ShowPlayButtonHint)
			f49_arg0.PlayButton:completeAnimation()
			f49_arg0.PlayButton:setTopBottom(0.5, 0.5, 5.5, 55.5)
			f49_arg0.PlayButton:setAlpha(1)
			f49_arg0.clipFinished(f49_arg0.PlayButton)
			f49_arg0.ReplayTutorial:completeAnimation()
			f49_arg0.ReplayTutorial:setTopBottom(0.5, 0.5, 78, 128)
			f49_arg0.ReplayTutorial:setAlpha(1)
			f49_arg0.clipFinished(f49_arg0.ReplayTutorial)
			f49_arg0.QuitButton:completeAnimation()
			f49_arg0.QuitButton:setTopBottom(0.5, 0.5, 150.5, 200.5)
			f49_arg0.QuitButton:setAlpha(1)
			f49_arg0.clipFinished(f49_arg0.QuitButton)
		end,
	},
	ShowPlayButton = {
		DefaultClip = function(f50_arg0, f50_arg1)
			f50_arg0:__resetProperties()
			f50_arg0:setupElementClipCounter(2)
			f50_arg0.ShowPlayButtonHint:completeAnimation()
			f50_arg0.ShowPlayButtonHint:setAlpha(1)
			f50_arg0.clipFinished(f50_arg0.ShowPlayButtonHint)
			f50_arg0.PlayButton:completeAnimation()
			f50_arg0.PlayButton:setTopBottom(0.5, 0.5, 20.5, 90.5)
			f50_arg0.PlayButton:setAlpha(1)
			f50_arg0.clipFinished(f50_arg0.PlayButton)
			f50_arg0.QuitButton:completeAnimation()
			f50_arg0.QuitButton:setTopBottom(0.5, 0.5, 125.5, 195.5)
			f50_arg0.QuitButton:setAlpha(1)
			f50_arg0.clipFinished(f50_arg0.QuitButton)
		end,
	},
}
CoD.SpecialistHeadquartersSelectSpecialistInternal.__onClose = function(f51_arg0)
	f51_arg0.SpecialistInfo:close()
	f51_arg0.DossierProgress:close()
	f51_arg0.Specialists:close()
	f51_arg0.SpecialistInfoSelected:close()
	f51_arg0.DossierProgressSelected:close()
	f51_arg0.ShowPlayButtonHint:close()
	f51_arg0.PlayButton:close()
	f51_arg0.ReplayTutorial:close()
	f51_arg0.QuitButton:close()
end
