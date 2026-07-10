require("x64:12cacdcc0738161")
require("x64:c118f1e6b2011b2")
require("x64:aed1e0f58da868f")
require("x64:ac124c9aed21bc2")
CoD.CodCasterButtons = InheritFrom(LUI.UIElement)
CoD.CodCasterButtons.__defaultWidth = 1800
CoD.CodCasterButtons.__defaultHeight = 100
CoD.CodCasterButtons.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterButtons)
	self.id = "CodCasterButtons"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CodCasterButtonsBG = CoD.FooterContainer_Frontend_Right_BG.new(f1_arg0, f1_arg1, -0.5, 1.54, -50, -50, 0, 0, 54, 215)
	self:addElement(CodCasterButtonsBG)
	self.CodCasterButtonsBG = CodCasterButtonsBG
	local ToggleList1 = CoD.CodCasterButtonPromptContainer.new(f1_arg0, f1_arg1, 0, 0, 856, 1120, 0, 0, 45, 83)
	ToggleList1.Prompt.KeyPrompt.keybind:setText(Engine[0xF9F1239CFD921FE](0xB5C6FCB5ACEAB52))
	ToggleList1.Text:setText(Engine[0xF9F1239CFD921FE](0x1C66D706E4682A))
	ToggleList1:subscribeToGlobalModel(f1_arg1, "Controller", "dpad_down_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ToggleList1.Prompt.buttonPromptImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(ToggleList1)
	self.ToggleList1 = ToggleList1
	local SelectPlayer1 = CoD.CodCasterButtonPromptContainer.new(f1_arg0, f1_arg1, 0, 0, 35, 299, 0, 0, -5, 33)
	SelectPlayer1.Prompt.KeyPrompt.keybind:setText(Engine[0xF9F1239CFD921FE](0xEA7793F2DAF4059))
	SelectPlayer1.Text:setText(Engine[0xF9F1239CFD921FE](0xE528282EC1246D5))
	SelectPlayer1:subscribeToGlobalModel(f1_arg1, "Controller", "primary_button_image", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			SelectPlayer1.Prompt.buttonPromptImage:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(SelectPlayer1)
	self.SelectPlayer1 = SelectPlayer1
	local FullsreenMap = CoD.CodCasterButtonPromptContainer.new(f1_arg0, f1_arg1, 0, 0, 35, 299, 0, 0, 45, 83)
	FullsreenMap.Prompt.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("M"))
	FullsreenMap.Text:setText(Engine[0xF9F1239CFD921FE](0xD9622B4FC02DFBA))
	FullsreenMap:subscribeToGlobalModel(f1_arg1, "Controller", "alt2_button_image", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			FullsreenMap.Prompt.buttonPromptImage:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(FullsreenMap)
	self.FullsreenMap = FullsreenMap
	local SelectCentralPlayer = CoD.CodCasterButtonPromptContainer.new(f1_arg0, f1_arg1, 0, 0, 35, 299, 0, 0, 45, 83)
	SelectCentralPlayer:setAlpha(0)
	SelectCentralPlayer.Prompt.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("`"))
	SelectCentralPlayer.Text:setText(Engine[0xF9F1239CFD921FE](0x2EB128302A523CF))
	SelectCentralPlayer:subscribeToGlobalModel(f1_arg1, "Controller", "alt2_button_image", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			SelectCentralPlayer.Prompt.buttonPromptImage:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(SelectCentralPlayer)
	self.SelectCentralPlayer = SelectCentralPlayer
	local ChangeCamera = CoD.CodCasterButtonPromptContainer.new(f1_arg0, f1_arg1, 0, 0, 308, 572, 0, 0, -5, 33)
	ChangeCamera.Prompt.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("C"))
	ChangeCamera.Text:setText(Engine[0xF9F1239CFD921FE](0xF4695A8C0A844EF))
	ChangeCamera:subscribeToGlobalModel(f1_arg1, "Controller", "alt1_button_image", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			ChangeCamera.Prompt.buttonPromptImage:setImage(RegisterImage(f6_local0))
		end
	end)
	self:addElement(ChangeCamera)
	self.ChangeCamera = ChangeCamera
	local Toolbar1 = CoD.CodCasterButtonPromptContainer.new(f1_arg0, f1_arg1, 0, 0, 308, 572, 0, 0, 45, 83)
	Toolbar1.Prompt.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("T"))
	Toolbar1.Text:setText(Engine[0xF9F1239CFD921FE](0xEF1D244CD091910))
	Toolbar1:subscribeToGlobalModel(f1_arg1, "Controller", "secondary_button_image", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			Toolbar1.Prompt.buttonPromptImage:setImage(RegisterImage(f7_local0))
		end
	end)
	self:addElement(Toolbar1)
	self.Toolbar1 = Toolbar1
	local NavigatePortrait1 = CoD.CodCasterButtonPromptContainer.new(f1_arg0, f1_arg1, 0, 0, 581, 845, 0, 0, -5, 33)
	NavigatePortrait1.Prompt.KeyPrompt.keybind:setText(Engine[0xF9F1239CFD921FE](0x9F8D4988D934149))
	NavigatePortrait1.Text:setText(Engine[0xF9F1239CFD921FE](0x11D93615BDAC5C3))
	NavigatePortrait1:subscribeToGlobalModel(f1_arg1, "Controller", "dpad_lr_button_image", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			NavigatePortrait1.Prompt.buttonPromptImage:setImage(RegisterImage(f8_local0))
		end
	end)
	self:addElement(NavigatePortrait1)
	self.NavigatePortrait1 = NavigatePortrait1
	local KeyboardShortcuts1 = CoD.CodCasterButtonPromptContainer_OnlyKeyboardKey.new(f1_arg0, f1_arg1, 0, 0, 581, 845, 0, 0, 45, 83)
	KeyboardShortcuts1.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("V"))
	KeyboardShortcuts1.Text:setText(Engine[0xF9F1239CFD921FE](0x93AC596F9C2A96C))
	self:addElement(KeyboardShortcuts1)
	self.KeyboardShortcuts1 = KeyboardShortcuts1
	local TogglePortraits = CoD.CodCasterButtonPromptContainer.new(f1_arg0, f1_arg1, 0, 0, 856, 1120, 0, 0, -5, 33)
	TogglePortraits.Prompt.KeyPrompt.keybind:setText(Engine[0xF9F1239CFD921FE](0x1F4945715AA4BFD))
	TogglePortraits:subscribeToGlobalModel(f1_arg1, "Controller", "dpad_up_button_image", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			TogglePortraits.Prompt.buttonPromptImage:setImage(RegisterImage(f9_local0))
		end
	end)
	self:addElement(TogglePortraits)
	self.TogglePortraits = TogglePortraits
	local CyclePlayers = CoD.CodCasterButtonDoublePromptContainer.new(f1_arg0, f1_arg1, 0, 0, 1131, 1395, 0, 0, -5, 33)
	CyclePlayers.Prompt.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized(","))
	CyclePlayers.Prompt2.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("."))
	CyclePlayers.Text:setText(Engine[0xF9F1239CFD921FE](0xCCA4488F17F1D0B))
	CyclePlayers:subscribeToGlobalModel(f1_arg1, "Controller", "left_shoulder_button_image", function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			CyclePlayers.Prompt.buttonPromptImage:setImage(RegisterImage(f10_local0))
		end
	end)
	CyclePlayers:subscribeToGlobalModel(f1_arg1, "Controller", "right_shoulder_button_image", function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			CyclePlayers.Prompt2.buttonPromptImage:setImage(RegisterImage(f11_local0))
		end
	end)
	self:addElement(CyclePlayers)
	self.CyclePlayers = CyclePlayers
	local SettingPanelsNEW = CoD.CodCasterButtonDoublePromptContainer.new(f1_arg0, f1_arg1, 0, 0, 1131, 1395, 0, 0, 45, 83)
	SettingPanelsNEW.Prompt.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("R"))
	SettingPanelsNEW.Prompt2.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("Y"))
	SettingPanelsNEW.Text:setText(Engine[0xF9F1239CFD921FE](0x2A1BD37927EB1CA))
	SettingPanelsNEW:subscribeToGlobalModel(f1_arg1, "Controller", "left_trigger_button_image", function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			SettingPanelsNEW.Prompt.buttonPromptImage:setImage(RegisterImage(f12_local0))
		end
	end)
	SettingPanelsNEW:subscribeToGlobalModel(f1_arg1, "Controller", "right_trigger_button_image", function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			SettingPanelsNEW.Prompt2.buttonPromptImage:setImage(RegisterImage(f13_local0))
		end
	end)
	self:addElement(SettingPanelsNEW)
	self.SettingPanelsNEW = SettingPanelsNEW
	local AerialCameraZoom = CoD.CodCasterButtonPromptContainer.new(f1_arg0, f1_arg1, 0, 0, 1406, 1670, 0, 0, -5, 33)
	AerialCameraZoom:setAlpha(0)
	AerialCameraZoom.Prompt.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("[ ]"))
	AerialCameraZoom.Text:setText(Engine[0xF9F1239CFD921FE](0x82758552FB3DD94))
	AerialCameraZoom:subscribeToGlobalModel(f1_arg1, "Controller", "left_stick_move_image", function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			AerialCameraZoom.Prompt.buttonPromptImage:setImage(RegisterImage(f14_local0))
		end
	end)
	self:addElement(AerialCameraZoom)
	self.AerialCameraZoom = AerialCameraZoom
	local NavigateLoadout = CoD.CodCasterButtonPromptContainer.new(f1_arg0, f1_arg1, 0, 0, 1406, 1670, 0, 0, -5, 33)
	NavigateLoadout.Prompt.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("[ ]"))
	NavigateLoadout.Text:setText(Engine[0xF9F1239CFD921FE](0xCC03F6E4651CC85))
	NavigateLoadout:subscribeToGlobalModel(f1_arg1, "Controller", "left_stick_move_image", function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			NavigateLoadout.Prompt.buttonPromptImage:setImage(RegisterImage(f15_local0))
		end
	end)
	self:addElement(NavigateLoadout)
	self.NavigateLoadout = NavigateLoadout
	local AerialCameraControl = CoD.CodCasterButtonPromptContainer.new(f1_arg0, f1_arg1, 0, 0, 1406, 1670, 0, 0, 45, 83)
	AerialCameraControl:setAlpha(0)
	AerialCameraControl.Prompt.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("W A S D"))
	AerialCameraControl.Text:setText(Engine[0xF9F1239CFD921FE](0xFC19E4BB0DB2DBC))
	AerialCameraControl:subscribeToGlobalModel(f1_arg1, "Controller", "right_stick_move_image", function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			AerialCameraControl.Prompt.buttonPromptImage:setImage(RegisterImage(f16_local0))
		end
	end)
	self:addElement(AerialCameraControl)
	self.AerialCameraControl = AerialCameraControl
	local ThirdPersonCam = CoD.CodCasterButtonPromptContainer.new(f1_arg0, f1_arg1, 0, 0, 1406, 1670, 0, 0, 45, 83)
	ThirdPersonCam.Prompt.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("W A S D"))
	ThirdPersonCam.Text:setText(Engine[0xF9F1239CFD921FE](0xEB3AD01F256685B))
	ThirdPersonCam:subscribeToGlobalModel(f1_arg1, "Controller", "right_stick_move_image", function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			ThirdPersonCam.Prompt.buttonPromptImage:setImage(RegisterImage(f17_local0))
		end
	end)
	self:addElement(ThirdPersonCam)
	self.ThirdPersonCam = ThirdPersonCam
	local LoadoutToggle = CoD.CodCasterButtonPromptContainer.new(f1_arg0, f1_arg1, 0, 0, 1678.5, 1942.5, 0, 0, 45, 83)
	LoadoutToggle.Prompt.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("H"))
	LoadoutToggle.Text:setText(Engine[0xF9F1239CFD921FE](0xD51F53F712CEE78))
	LoadoutToggle:subscribeToGlobalModel(f1_arg1, "Controller", "right_stick_button_image", function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			LoadoutToggle.Prompt.buttonPromptImage:setImage(RegisterImage(f18_local0))
		end
	end)
	self:addElement(LoadoutToggle)
	self.LoadoutToggle = LoadoutToggle
	local LockUnlockStickCamera = CoD.CodCasterButtonPromptContainer.new(f1_arg0, f1_arg1, 0, 0, 1678.5, 1942.5, 0, 0, 45, 83)
	LockUnlockStickCamera:setAlpha(0)
	LockUnlockStickCamera.Prompt.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("L"))
	LockUnlockStickCamera.Text:setText(Engine[0xF9F1239CFD921FE](0xDBD347CE6E79536))
	LockUnlockStickCamera:subscribeToGlobalModel(f1_arg1, "Controller", "right_stick_button_image", function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			LockUnlockStickCamera.Prompt.buttonPromptImage:setImage(RegisterImage(f19_local0))
		end
	end)
	self:addElement(LockUnlockStickCamera)
	self.LockUnlockStickCamera = LockUnlockStickCamera
	local FocusSpectatedPlayer = CoD.CodCasterButtonPromptContainer.new(f1_arg0, f1_arg1, 0, 0, 1678.5, 1942.5, 0, 0, -5, 33)
	FocusSpectatedPlayer:setAlpha(0)
	FocusSpectatedPlayer.Prompt.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized(";"))
	FocusSpectatedPlayer.Text:setText(Engine[0xF9F1239CFD921FE](0x24B92E40440B5ED))
	FocusSpectatedPlayer:subscribeToGlobalModel(f1_arg1, "Controller", "left_stick_button_image", function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			FocusSpectatedPlayer.Prompt.buttonPromptImage:setImage(RegisterImage(f20_local0))
		end
	end)
	self:addElement(FocusSpectatedPlayer)
	self.FocusSpectatedPlayer = FocusSpectatedPlayer
	self:mergeStateConditions({
		{
			stateName = "ToolbarAerialConsole",
			condition = function(menu, element, event)
				return CoD.CodCasterUtility.CodCasterIsInAerialCam(f1_arg1) and IsCodCaster(f1_arg1)
			end,
		},
		{
			stateName = "ToolbarAerialPC",
			condition = function(menu, element, event)
				local f22_local0 = CoD.CodCasterUtility.CodCasterIsInAerialCam(f1_arg1)
				if f22_local0 then
					f22_local0 = IsPC()
					if f22_local0 then
						f22_local0 = IsCodCaster(f1_arg1)
					end
				end
				return f22_local0
			end,
		},
		{
			stateName = "PCKeyboard",
			condition = function(menu, element, event)
				local f23_local0 = IsPC()
				if f23_local0 then
					if not CoD.CodCasterUtility.CodCasterIsInAerialCam(f1_arg1) then
						f23_local0 = IsCodCaster(f1_arg1)
					else
						f23_local0 = false
					end
				end
				return f23_local0
			end,
		},
	})
	local f1_local20 = self
	local f1_local21 = self.subscribeToModel
	local f1_local22 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local21(f1_local20, f1_local22["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7EAF988DDEB83EA]], function(f24_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7EAF988DDEB83EA],
		})
	end, false)
	f1_local20 = self
	f1_local21 = self.subscribeToModel
	f1_local22 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local21(f1_local20, f1_local22["factions.isCoDCaster"], function(f25_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	if CoD.isPC then
		ToggleList1.id = "ToggleList1"
	end
	if CoD.isPC then
		SelectPlayer1.id = "SelectPlayer1"
	end
	if CoD.isPC then
		FullsreenMap.id = "FullsreenMap"
	end
	if CoD.isPC then
		SelectCentralPlayer.id = "SelectCentralPlayer"
	end
	if CoD.isPC then
		ChangeCamera.id = "ChangeCamera"
	end
	if CoD.isPC then
		Toolbar1.id = "Toolbar1"
	end
	if CoD.isPC then
		NavigatePortrait1.id = "NavigatePortrait1"
	end
	if CoD.isPC then
		TogglePortraits.id = "TogglePortraits"
	end
	if CoD.isPC then
		CyclePlayers.id = "CyclePlayers"
	end
	if CoD.isPC then
		SettingPanelsNEW.id = "SettingPanelsNEW"
	end
	if CoD.isPC then
		AerialCameraZoom.id = "AerialCameraZoom"
	end
	if CoD.isPC then
		NavigateLoadout.id = "NavigateLoadout"
	end
	if CoD.isPC then
		AerialCameraControl.id = "AerialCameraControl"
	end
	if CoD.isPC then
		ThirdPersonCam.id = "ThirdPersonCam"
	end
	if CoD.isPC then
		LoadoutToggle.id = "LoadoutToggle"
	end
	if CoD.isPC then
		LockUnlockStickCamera.id = "LockUnlockStickCamera"
	end
	if CoD.isPC then
		FocusSpectatedPlayer.id = "FocusSpectatedPlayer"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterButtons.__resetProperties = function(f26_arg0)
	f26_arg0.SelectPlayer1:completeAnimation()
	f26_arg0.FullsreenMap:completeAnimation()
	f26_arg0.SelectCentralPlayer:completeAnimation()
	f26_arg0.NavigateLoadout:completeAnimation()
	f26_arg0.AerialCameraControl:completeAnimation()
	f26_arg0.AerialCameraZoom:completeAnimation()
	f26_arg0.LockUnlockStickCamera:completeAnimation()
	f26_arg0.LoadoutToggle:completeAnimation()
	f26_arg0.FocusSpectatedPlayer:completeAnimation()
	f26_arg0.ThirdPersonCam:completeAnimation()
	f26_arg0.SelectPlayer1:setRGB(1, 1, 1)
	f26_arg0.FullsreenMap:setAlpha(1)
	f26_arg0.FullsreenMap.Prompt.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("M"))
	f26_arg0.SelectCentralPlayer:setAlpha(0)
	f26_arg0.NavigateLoadout:setTopBottom(0, 0, -5, 33)
	f26_arg0.NavigateLoadout:setAlpha(1)
	f26_arg0.AerialCameraControl:setAlpha(0)
	f26_arg0.AerialCameraZoom:setAlpha(0)
	f26_arg0.LockUnlockStickCamera:setAlpha(0)
	f26_arg0.LoadoutToggle:setAlpha(1)
	f26_arg0.FocusSpectatedPlayer:setAlpha(0)
	f26_arg0.ThirdPersonCam:setAlpha(1)
end
CoD.CodCasterButtons.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(1)
			f27_arg0.SelectPlayer1:completeAnimation()
			f27_arg0.SelectPlayer1:setRGB(1, 1, 1)
			f27_arg0.clipFinished(f27_arg0.SelectPlayer1)
		end,
	},
	ToolbarAerialConsole = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(10)
			f28_arg0.SelectPlayer1:completeAnimation()
			f28_arg0.SelectPlayer1:setRGB(1, 1, 1)
			f28_arg0.clipFinished(f28_arg0.SelectPlayer1)
			f28_arg0.FullsreenMap:completeAnimation()
			f28_arg0.FullsreenMap:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.FullsreenMap)
			f28_arg0.SelectCentralPlayer:completeAnimation()
			f28_arg0.SelectCentralPlayer:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.SelectCentralPlayer)
			f28_arg0.AerialCameraZoom:completeAnimation()
			f28_arg0.AerialCameraZoom:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.AerialCameraZoom)
			f28_arg0.NavigateLoadout:completeAnimation()
			f28_arg0.NavigateLoadout:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.NavigateLoadout)
			f28_arg0.AerialCameraControl:completeAnimation()
			f28_arg0.AerialCameraControl:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.AerialCameraControl)
			f28_arg0.ThirdPersonCam:completeAnimation()
			f28_arg0.ThirdPersonCam:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.ThirdPersonCam)
			f28_arg0.LoadoutToggle:completeAnimation()
			f28_arg0.LoadoutToggle:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.LoadoutToggle)
			f28_arg0.LockUnlockStickCamera:completeAnimation()
			f28_arg0.LockUnlockStickCamera:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.LockUnlockStickCamera)
			f28_arg0.FocusSpectatedPlayer:completeAnimation()
			f28_arg0.FocusSpectatedPlayer:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.FocusSpectatedPlayer)
		end,
	},
	ToolbarAerialPC = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(2)
			f29_arg0.SelectPlayer1:completeAnimation()
			f29_arg0.SelectPlayer1:setRGB(1, 1, 1)
			f29_arg0.clipFinished(f29_arg0.SelectPlayer1)
			f29_arg0.FullsreenMap:completeAnimation()
			f29_arg0.FullsreenMap.Prompt.KeyPrompt.keybind:completeAnimation()
			f29_arg0.FullsreenMap:setAlpha(1)
			f29_arg0.FullsreenMap.Prompt.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("`"))
			f29_arg0.clipFinished(f29_arg0.FullsreenMap)
		end,
	},
	PCKeyboard = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(3)
			f30_arg0.SelectPlayer1:completeAnimation()
			f30_arg0.SelectPlayer1:setRGB(1, 1, 1)
			f30_arg0.clipFinished(f30_arg0.SelectPlayer1)
			f30_arg0.NavigateLoadout:completeAnimation()
			f30_arg0.NavigateLoadout:setTopBottom(0, 0, 45, 83)
			f30_arg0.clipFinished(f30_arg0.NavigateLoadout)
			f30_arg0.ThirdPersonCam:completeAnimation()
			f30_arg0.ThirdPersonCam:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.ThirdPersonCam)
		end,
	},
}
CoD.CodCasterButtons.__onClose = function(f31_arg0)
	f31_arg0.CodCasterButtonsBG:close()
	f31_arg0.ToggleList1:close()
	f31_arg0.SelectPlayer1:close()
	f31_arg0.FullsreenMap:close()
	f31_arg0.SelectCentralPlayer:close()
	f31_arg0.ChangeCamera:close()
	f31_arg0.Toolbar1:close()
	f31_arg0.NavigatePortrait1:close()
	f31_arg0.KeyboardShortcuts1:close()
	f31_arg0.TogglePortraits:close()
	f31_arg0.CyclePlayers:close()
	f31_arg0.SettingPanelsNEW:close()
	f31_arg0.AerialCameraZoom:close()
	f31_arg0.NavigateLoadout:close()
	f31_arg0.AerialCameraControl:close()
	f31_arg0.ThirdPersonCam:close()
	f31_arg0.LoadoutToggle:close()
	f31_arg0.LockUnlockStickCamera:close()
	f31_arg0.FocusSpectatedPlayer:close()
end
