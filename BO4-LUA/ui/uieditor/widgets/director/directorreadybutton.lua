require("x64:d7e092479c7b82c")
require("x64:acbed692442191c")
require("x64:30c1a62ca1c0f66")
require("x64:1f846296f1a1b81")
CoD.DirectorReadyButton = InheritFrom(LUI.UIElement)
CoD.DirectorReadyButton.__defaultWidth = 374
CoD.DirectorReadyButton.__defaultHeight = 80
CoD.DirectorReadyButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorReadyButton)
	self.id = "DirectorReadyButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0, 0, 0)
	Backing:setAlpha(0)
	Backing:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Backing:setShaderVector(0, 0, 0.5, 0, 0)
	self:addElement(Backing)
	self.Backing = Backing
	local DirectorSelectButtonMiniInternal = CoD.DirectorSelectButtonMiniInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DirectorSelectButtonMiniInternal:mergeStateConditions({
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsSelfInState(self, "Unselectable")
			end,
		},
	})
	DirectorSelectButtonMiniInternal:setAlpha(0)
	DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString(@"menu/ready_up"))
	DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString(@"menu/ready_up"))
	self:addElement(DirectorSelectButtonMiniInternal)
	self.DirectorSelectButtonMiniInternal = DirectorSelectButtonMiniInternal
	local DirectorCustomStartButton = CoD.DirectorSelectButtonInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, -0.16, 1, 0, 0)
	DirectorCustomStartButton:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsSelfInState(self, "Disabled")
			end,
		},
	})
	DirectorCustomStartButton.LeaderActivityText:setAlpha(0)
	DirectorCustomStartButton.LeaderActivityText:setText("")
	DirectorCustomStartButton.Header:setAlpha(0)
	DirectorCustomStartButton.Header:setText(LocalizeToUpperString(0x0))
	DirectorCustomStartButton.MiddleText:setAlpha(0)
	DirectorCustomStartButton.MiddleText:setText("")
	DirectorCustomStartButton:linkToElementModel(self, "iconBackground", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			DirectorCustomStartButton.ImageNotFocus:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(DirectorCustomStartButton)
	self.DirectorCustomStartButton = DirectorCustomStartButton
	local Border01 = CoD.CommonCornerPips02.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Border01:setAlpha(0)
	self:addElement(Border01)
	self.Border01 = Border01
	local FrontendFrame = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrontendFrame:setAlpha(0)
	FrontendFrame:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	FrontendFrame:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFrame:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrame)
	self.FrontendFrame = FrontendFrame
	local Border = CoD.Border.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Border:setAlpha(0)
	self:addElement(Border)
	self.Border = Border
	local circle = LUI.UIImage.new(0, 0, 59, 119, 0.5, 0.5, -30, 30)
	circle:setRGB(0.19, 0.19, 0.19)
	circle:setAlpha(0)
	circle:setZRot(180)
	circle:setScale(1.05, 1.05)
	circle:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_elliptical_ring_normal"))
	circle:setShaderVector(0, 4.66, 0, 0, 0)
	circle:setShaderVector(1, 80, 80, 0, 0)
	circle:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(circle)
	self.circle = circle
	local CountdownText = LUI.UIText.new(0, 0, 129.5, 184.5, 0.5, 0.5, -12, 12)
	CountdownText:setAlpha(0)
	CountdownText:setTTF("ttmussels_regular")
	CountdownText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CountdownText:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyStatus", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			CountdownText:setText(ToUpper(f6_local0))
		end
	end)
	self:addElement(CountdownText)
	self.CountdownText = CountdownText
	local timer = LUI.UIText.new(0, 0, 50, 130, 0.5, 0.5, -22.5, 22.5)
	timer:setAlpha(0)
	timer:setTTF("ttmussels_demibold")
	timer:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	timer:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	timer:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyTimeRemaining", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			timer:setText(f7_local0)
		end
	end)
	self:addElement(timer)
	self.timer = timer
	local Fill = LUI.UIImage.new(0, 1, -105, 105, 0, 1, -65, 65)
	Fill:setAlpha(0)
	Fill:setImage(RegisterImage(@"uie_ui_menu_common_tab_backing"))
	Fill:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	Fill:setShaderVector(1, 0, 0, 0, 0)
	Fill:setShaderVector(2, 1, 0, 0, 0)
	Fill:setShaderVector(3, 0, 0, 0, 0)
	Fill:setShaderVector(4, 0, 0, 0, 0)
	Fill:linkToElementModel(self, "progress", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			Fill:setShaderVector(0, AdjustStartEnd(0.16, 0.85, CoD.GetVectorComponentFromString(f8_local0, 1), CoD.GetVectorComponentFromString(f8_local0, 2), CoD.GetVectorComponentFromString(f8_local0, 3), CoD.GetVectorComponentFromString(f8_local0, 4)))
		end
	end)
	self:addElement(Fill)
	self.Fill = Fill
	local Fill2 = LUI.UIImage.new(0, 1, -105, 105, 0, 1, -65, 65)
	Fill2:setAlpha(0)
	Fill2:setImage(RegisterImage(@"uie_ui_menu_common_tab_backing"))
	Fill2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	Fill2:setShaderVector(1, 0, 0, 0, 0)
	Fill2:setShaderVector(2, 1, 0, 0, 0)
	Fill2:setShaderVector(3, 0, 0, 0, 0)
	Fill2:setShaderVector(4, 0, 0, 0, 0)
	Fill2:linkToElementModel(self, "progress", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			Fill2:setShaderVector(0, AdjustStartEnd(0.16, 0.85, CoD.GetVectorComponentFromString(f9_local0, 1), CoD.GetVectorComponentFromString(f9_local0, 2), CoD.GetVectorComponentFromString(f9_local0, 3), CoD.GetVectorComponentFromString(f9_local0, 4)))
		end
	end)
	self:addElement(Fill2)
	self.Fill2 = Fill2
	local PlayText = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -12, 12)
	PlayText:setText(LocalizeToUpperString(@"menu/ready_up"))
	PlayText:setTTF("ttmussels_demibold")
	PlayText:setLetterSpacing(6)
	PlayText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	PlayText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(PlayText)
	self.PlayText = PlayText
	local WaitingText = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -12, 12)
	WaitingText:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	WaitingText:setAlpha(0)
	WaitingText:setText(LocalizeToUpperString(@"hash_4EAC4945DCDC2806"))
	WaitingText:setTTF("default")
	WaitingText:setLetterSpacing(3)
	WaitingText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	WaitingText:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(WaitingText)
	self.WaitingText = WaitingText
	self:mergeStateConditions({
		{
			stateName = "MatchStartHide",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "LobbyRoot", "hideMenusForGameStart", 1)
			end,
		},
		{
			stateName = "MatchStarting",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.lobbyTimeRemaining", 0)
			end,
		},
		{
			stateName = "WaitingForMorePlayers",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.WaitingForMorePlayers()
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				local f13_local0
				if not CoD.DirectorUtility.CanReadyUp(f1_arg1) then
					f13_local0 = not CoD.DirectorUtility.CanReadyDown(f1_arg1)
				else
					f13_local0 = false
				end
				return f13_local0
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Ready",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.CanReadyDown(f1_arg1)
			end,
		},
	})
	local f1_local14 = self
	local f1_local15 = self.subscribeToModel
	local f1_local16 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local15(f1_local14, f1_local16.hideMenusForGameStart, function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "hideMenusForGameStart",
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[@"getglobalmodel"]()
	f1_local15(f1_local14, f1_local16["lobbyRoot.lobbyTimeRemaining"], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "lobbyRoot.lobbyTimeRemaining",
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[@"getglobalmodel"]()
	f1_local15(f1_local14, f1_local16["lobbyRoot.lobbyList.playerCount"], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "lobbyRoot.lobbyList.playerCount",
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[@"getglobalmodel"]()
	f1_local15(f1_local14, f1_local16["lobbyRoot.lobbyNav"], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[@"getglobalmodel"]()
	f1_local15(f1_local14, f1_local16["lobbyRoot.publicLobby.stage"], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "lobbyRoot.publicLobby.stage",
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f21_arg0, f21_arg1)
		f21_arg1.menu = f21_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f21_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
		CoD.Menu.UpdateButtonShownState(f21_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
	end)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local15(f1_local14, f1_local16.LastInput, function(f22_arg0, f22_arg1)
		CoD.Menu.UpdateButtonShownState(f22_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
		CoD.Menu.UpdateButtonShownState(f22_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[@"getglobalmodel"]()
	f1_local15(f1_local14, f1_local16["lobbyRoot.lobbyNav"], function(f23_arg0, f23_arg1)
		CoD.Menu.UpdateButtonShownState(f23_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
		CoD.Menu.UpdateButtonShownState(f23_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[@"getglobalmodel"]()
	f1_local15(f1_local14, f1_local16["lobbyRoot.publicLobby.stage"], function(f24_arg0, f24_arg1)
		CoD.Menu.UpdateButtonShownState(f24_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
		CoD.Menu.UpdateButtonShownState(f24_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[@"getglobalmodel"]()
	f1_local15(f1_local14, f1_local16["lobbyRoot.playlistId"], function(f25_arg0, f25_arg1)
		CoD.Menu.UpdateButtonShownState(f25_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
		CoD.Menu.UpdateButtonShownState(f25_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[@"getglobalmodel"]()
	f1_local15(f1_local14, f1_local16["lobbyRoot.lobbyList.playerCount"], function(f26_arg0, f26_arg1)
		CoD.Menu.UpdateButtonShownState(f26_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
		CoD.Menu.UpdateButtonShownState(f26_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], "ESCAPE", function(element, menu, controller, model)
		if IsGamepad(controller) and CoD.DirectorUtility.CanReadyDown(controller) and not CoD.DirectorUtility.IsNumClientsExceeded(controller) and CoD.DirectorUtility.AllClientsOwnDLCForPlaylist(controller) then
			SetState(self, "DefaultState", controller)
			CoD.DirectorUtility.SetLocalClientsReady()
			return true
		elseif IsGamepad(controller) and CoD.DirectorUtility.CanReadyDown(controller) and CoD.DirectorUtility.IsNumClientsExceeded(controller) then
			CoD.DirectorUtility.OpenTooManyClientsPopup(self, controller)
			return true
		elseif IsGamepad(controller) and CoD.DirectorUtility.CanReadyDown(controller) and not CoD.DirectorUtility.AllClientsOwnDLCForPlaylist(controller) then
			CoD.DirectorUtility.OpenMapsNotEnabledPopup(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) and CoD.DirectorUtility.CanReadyDown(controller) and not CoD.DirectorUtility.IsNumClientsExceeded(controller) and CoD.DirectorUtility.AllClientsOwnDLCForPlaylist(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"hash_26DA4540B4705513", nil, "ESCAPE")
			return true
		elseif IsGamepad(controller) and CoD.DirectorUtility.CanReadyDown(controller) and CoD.DirectorUtility.IsNumClientsExceeded(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"hash_26DA4540B4705513", nil, "ESCAPE")
			return true
		elseif IsGamepad(controller) and CoD.DirectorUtility.CanReadyDown(controller) and not CoD.DirectorUtility.AllClientsOwnDLCForPlaylist(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"hash_26DA4540B4705513", nil, "ESCAPE")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "MOUSE1", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and CoD.DirectorUtility.CanReadyUp(controller) and not CoD.DirectorUtility.IsNumClientsExceeded(controller) and CoD.DirectorUtility.AllClientsOwnDLCForPlaylist(controller) then
			CoD.BaseUtility.StopPlayOnceSound(element, "uin_ready_bar_fill_1shot")
			PlaySoundAlias("uin_ready_bar_done")
			SetState(self, "Ready", controller)
			CoD.DirectorUtility.SetLocalClientsReady()
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.CanReadyDown(controller) and not CoD.DirectorUtility.IsNumClientsExceeded(controller) and CoD.DirectorUtility.AllClientsOwnDLCForPlaylist(controller) then
			SetState(self, "DefaultState", controller)
			CoD.DirectorUtility.SetLocalClientsReady()
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.CanReadyUp(controller) and CoD.DirectorUtility.IsNumClientsExceeded(controller) then
			CoD.BaseUtility.StopPlayOnceSound(element, "uin_ready_bar_fill_1shot")
			PlaySoundAlias("uin_ready_bar_done")
			CoD.DirectorUtility.OpenTooManyClientsPopup(self, controller)
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.CanReadyDown(controller) and CoD.DirectorUtility.IsNumClientsExceeded(controller) then
			CoD.DirectorUtility.OpenTooManyClientsPopup(self, controller)
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.CanReadyUp(controller) and not CoD.DirectorUtility.AllClientsOwnDLCForPlaylist(controller) then
			CoD.BaseUtility.StopPlayOnceSound(element, "uin_ready_bar_fill_1shot")
			PlaySoundAlias("uin_ready_bar_done")
			CoD.DirectorUtility.OpenMapsNotEnabledPopup(self, controller)
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.CanReadyDown(controller) and not CoD.DirectorUtility.AllClientsOwnDLCForPlaylist(controller) then
			CoD.DirectorUtility.OpenMapsNotEnabledPopup(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and CoD.DirectorUtility.CanReadyUp(controller) and not CoD.DirectorUtility.IsNumClientsExceeded(controller) and CoD.DirectorUtility.AllClientsOwnDLCForPlaylist(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MOUSE1")
			return false
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.CanReadyDown(controller) and not CoD.DirectorUtility.IsNumClientsExceeded(controller) and CoD.DirectorUtility.AllClientsOwnDLCForPlaylist(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MOUSE1")
			return false
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.CanReadyUp(controller) and CoD.DirectorUtility.IsNumClientsExceeded(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MOUSE1")
			return false
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.CanReadyDown(controller) and CoD.DirectorUtility.IsNumClientsExceeded(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MOUSE1")
			return false
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.CanReadyUp(controller) and not CoD.DirectorUtility.AllClientsOwnDLCForPlaylist(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MOUSE1")
			return false
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.CanReadyDown(controller) and not CoD.DirectorUtility.AllClientsOwnDLCForPlaylist(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MOUSE1")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "ui_confirm", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and CoD.DirectorUtility.CanReadyUp(controller) and not CoD.DirectorUtility.IsNumClientsExceeded(controller) and CoD.DirectorUtility.AllClientsOwnDLCForPlaylist(controller) then
			CoD.BaseUtility.StopPlayOnceSound(element, "uin_ready_bar_fill_1shot")
			PlaySoundAlias("uin_ready_bar_done")
			SetState(self, "Ready", controller)
			CoD.DirectorUtility.SetLocalClientsReady()
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.CanReadyUp(controller) and CoD.DirectorUtility.IsNumClientsExceeded(controller) then
			CoD.BaseUtility.StopPlayOnceSound(element, "uin_ready_bar_fill_1shot")
			PlaySoundAlias("uin_ready_bar_done")
			CoD.DirectorUtility.OpenTooManyClientsPopup(self, controller)
			return true
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.CanReadyUp(controller) and not CoD.DirectorUtility.AllClientsOwnDLCForPlaylist(controller) then
			CoD.BaseUtility.StopPlayOnceSound(element, "uin_ready_bar_fill_1shot")
			PlaySoundAlias("uin_ready_bar_done")
			CoD.DirectorUtility.OpenMapsNotEnabledPopup(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and CoD.DirectorUtility.CanReadyUp(controller) and not CoD.DirectorUtility.IsNumClientsExceeded(controller) and CoD.DirectorUtility.AllClientsOwnDLCForPlaylist(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "ui_confirm")
			return false
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.CanReadyUp(controller) and CoD.DirectorUtility.IsNumClientsExceeded(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "ui_confirm")
			return false
		elseif IsMouseOrKeyboard(controller) and CoD.DirectorUtility.CanReadyUp(controller) and not CoD.DirectorUtility.AllClientsOwnDLCForPlaylist(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f33_arg2, f33_arg3, f33_arg4)
		UpdateElementState(self, "DirectorCustomStartButton", controller)
	end)
	self:linkToElementModel(self, "progress", true, function(model)
		local f34_local0 = self
		if CoD.ModelUtility.IsParamModelEqualTo(model, 0) and IsElementInFocus(self.DirectorCustomStartButton) then
			CoD.BaseUtility.StopPlayOnceSound(f34_local0, "uin_ready_bar_fill_1shot")
		elseif IsElementInFocus(self.DirectorCustomStartButton) and not IsElementInState(self, "Ready") then
			CoD.BaseUtility.PlaySoundOnce(f34_local0, "uin_ready_bar_fill_1shot")
		end
	end)
	self:linkToElementModel(self, nil, true, function(model)
		local f35_local0 = self
		if CoD.ModelUtility.IsParamModelEqualTo(model, Enum[@"luibuttonflags"][@"hash_4715085B24AAB606"] | Enum[@"luibuttonflags"][@"flag_down"]) and IsElementInFocus(self.DirectorCustomStartButton) and CoD.DirectorUtility.CanReadyUp(f1_arg1) and not CoD.DirectorUtility.IsNumClientsExceeded(f1_arg1) and CoD.DirectorUtility.AllClientsOwnDLCForPlaylist(f1_arg1) then
			CoD.BaseUtility.StopPlayOnceSound(f35_local0, "uin_ready_bar_fill_1shot")
			PlaySoundAlias("uin_ready_bar_done")
			SetState(self, "Ready", f1_arg1)
			CoD.DirectorUtility.SetLocalClientsReady()
		elseif CoD.ModelUtility.IsParamModelEqualTo(model, Enum[@"luibuttonflags"][@"hash_4715085B24AAB606"] | Enum[@"luibuttonflags"][@"flag_down"]) and IsElementInFocus(self.DirectorCustomStartButton) and CoD.DirectorUtility.CanReadyUp(f1_arg1) and CoD.DirectorUtility.IsNumClientsExceeded(f1_arg1) then
			CoD.BaseUtility.StopPlayOnceSound(f35_local0, "uin_ready_bar_fill_1shot")
			PlaySoundAlias("uin_ready_bar_done")
			CoD.DirectorUtility.OpenTooManyClientsPopup(self, f1_arg1)
		elseif CoD.ModelUtility.IsParamModelEqualTo(model, Enum[@"luibuttonflags"][@"hash_4715085B24AAB606"] | Enum[@"luibuttonflags"][@"flag_down"]) and IsElementInFocus(self.DirectorCustomStartButton) and CoD.DirectorUtility.CanReadyUp(f1_arg1) and not CoD.DirectorUtility.AllClientsOwnDLCForPlaylist(f1_arg1) then
			CoD.BaseUtility.StopPlayOnceSound(f35_local0, "uin_ready_bar_fill_1shot")
			PlaySoundAlias("uin_ready_bar_done")
			CoD.DirectorUtility.OpenMapsNotEnabledPopup(self, f1_arg1)
		end
	end)
	DirectorSelectButtonMiniInternal.id = "DirectorSelectButtonMiniInternal"
	DirectorCustomStartButton.id = "DirectorCustomStartButton"
	self.__defaultFocus = DirectorCustomStartButton
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorReadyButton.__resetProperties = function(f36_arg0)
	f36_arg0.Fill:completeAnimation()
	f36_arg0.DirectorCustomStartButton:completeAnimation()
	f36_arg0.PlayText:completeAnimation()
	f36_arg0.Fill2:completeAnimation()
	f36_arg0.timer:completeAnimation()
	f36_arg0.CountdownText:completeAnimation()
	f36_arg0.circle:completeAnimation()
	f36_arg0.Border:completeAnimation()
	f36_arg0.WaitingText:completeAnimation()
	f36_arg0.Backing:completeAnimation()
	f36_arg0.Border01:completeAnimation()
	f36_arg0.FrontendFrame:completeAnimation()
	f36_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
	f36_arg0.Fill:setAlpha(0)
	f36_arg0.Fill:setScale(1, 1)
	f36_arg0.Fill:setImage(RegisterImage(@"uie_ui_menu_common_tab_backing"))
	f36_arg0.DirectorCustomStartButton:setRGB(1, 1, 1)
	f36_arg0.DirectorCustomStartButton:setAlpha(1)
	f36_arg0.DirectorCustomStartButton:setScale(1, 1)
	f36_arg0.PlayText:setRGB(1, 1, 1)
	f36_arg0.PlayText:setAlpha(1)
	f36_arg0.PlayText:setScale(1, 1)
	f36_arg0.PlayText:setText(LocalizeToUpperString(@"menu/ready_up"))
	f36_arg0.Fill2:setAlpha(0)
	f36_arg0.Fill2:setScale(1, 1)
	f36_arg0.timer:setLeftRight(0, 0, 50, 130)
	f36_arg0.timer:setAlpha(0)
	f36_arg0.timer:setScale(1, 1)
	f36_arg0.timer:setLetterSpacing(0)
	f36_arg0.CountdownText:setAlpha(0)
	f36_arg0.CountdownText:setScale(1, 1)
	f36_arg0.circle:setLeftRight(0, 0, 59, 119)
	f36_arg0.circle:setAlpha(0)
	f36_arg0.circle:setScale(1.05, 1.05)
	f36_arg0.Border:setAlpha(0)
	f36_arg0.WaitingText:setAlpha(0)
	f36_arg0.Backing:setAlpha(0)
	f36_arg0.Border01:setAlpha(0)
	f36_arg0.FrontendFrame:setAlpha(0)
	f36_arg0.DirectorSelectButtonMiniInternal:setAlpha(0)
	f36_arg0.DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString(@"menu/ready_up"))
	f36_arg0.DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString(@"menu/ready_up"))
end
CoD.DirectorReadyButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(1)
			f37_arg0.Fill:completeAnimation()
			f37_arg0.Fill:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.Fill)
		end,
		ChildFocus = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(4)
			f38_arg0.DirectorCustomStartButton:completeAnimation()
			f38_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f38_arg0.clipFinished(f38_arg0.DirectorCustomStartButton)
			f38_arg0.Fill:completeAnimation()
			f38_arg0.Fill:setAlpha(0.35)
			f38_arg0.Fill:setScale(1.05, 1.05)
			f38_arg0.Fill:setImage(RegisterImage(@"uie_ui_menu_common_tab_backing"))
			f38_arg0.clipFinished(f38_arg0.Fill)
			f38_arg0.Fill2:completeAnimation()
			f38_arg0.Fill2:setAlpha(0.35)
			f38_arg0.Fill2:setScale(1.05, 1.05)
			f38_arg0.clipFinished(f38_arg0.Fill2)
			f38_arg0.PlayText:completeAnimation()
			f38_arg0.PlayText:setScale(1.05, 1.05)
			f38_arg0.clipFinished(f38_arg0.PlayText)
		end,
		GainChildFocus = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(4)
			local f39_local0 = function(f40_arg0)
				f39_arg0.DirectorCustomStartButton:beginAnimation(200)
				f39_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
				f39_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.DirectorCustomStartButton:completeAnimation()
			f39_arg0.DirectorCustomStartButton:setScale(1, 1)
			f39_local0(f39_arg0.DirectorCustomStartButton)
			local f39_local1 = function(f41_arg0)
				f39_arg0.Fill:beginAnimation(200)
				f39_arg0.Fill:setAlpha(0.35)
				f39_arg0.Fill:setScale(1.05, 1.05)
				f39_arg0.Fill:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.Fill:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.Fill:completeAnimation()
			f39_arg0.Fill:setAlpha(0)
			f39_arg0.Fill:setScale(1, 1)
			f39_local1(f39_arg0.Fill)
			local f39_local2 = function(f42_arg0)
				f39_arg0.Fill2:beginAnimation(200)
				f39_arg0.Fill2:setAlpha(0.35)
				f39_arg0.Fill2:setScale(1.05, 1.05)
				f39_arg0.Fill2:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.Fill2:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.Fill2:completeAnimation()
			f39_arg0.Fill2:setAlpha(0)
			f39_arg0.Fill2:setScale(1, 1)
			f39_local2(f39_arg0.Fill2)
			local f39_local3 = function(f43_arg0)
				f39_arg0.PlayText:beginAnimation(200)
				f39_arg0.PlayText:setScale(1.05, 1.05)
				f39_arg0.PlayText:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.PlayText:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.PlayText:completeAnimation()
			f39_arg0.PlayText:setScale(1, 1)
			f39_local3(f39_arg0.PlayText)
		end,
		LoseChildFocus = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(4)
			local f44_local0 = function(f45_arg0)
				f44_arg0.DirectorCustomStartButton:beginAnimation(200)
				f44_arg0.DirectorCustomStartButton:setScale(1, 1)
				f44_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
			end
			f44_arg0.DirectorCustomStartButton:completeAnimation()
			f44_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f44_local0(f44_arg0.DirectorCustomStartButton)
			local f44_local1 = function(f46_arg0)
				f44_arg0.Fill:beginAnimation(200)
				f44_arg0.Fill:setAlpha(0)
				f44_arg0.Fill:setScale(1, 1)
				f44_arg0.Fill:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.Fill:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
			end
			f44_arg0.Fill:completeAnimation()
			f44_arg0.Fill:setAlpha(0.35)
			f44_arg0.Fill:setScale(1.05, 1.05)
			f44_local1(f44_arg0.Fill)
			local f44_local2 = function(f47_arg0)
				f44_arg0.Fill2:beginAnimation(200)
				f44_arg0.Fill2:setAlpha(0)
				f44_arg0.Fill2:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.Fill2:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
			end
			f44_arg0.Fill2:completeAnimation()
			f44_arg0.Fill2:setAlpha(0.35)
			f44_arg0.Fill2:setScale(1.05, 1.05)
			f44_local2(f44_arg0.Fill2)
			local f44_local3 = function(f48_arg0)
				f44_arg0.PlayText:beginAnimation(200)
				f44_arg0.PlayText:setScale(1, 1)
				f44_arg0.PlayText:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.PlayText:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
			end
			f44_arg0.PlayText:completeAnimation()
			f44_arg0.PlayText:setScale(1.05, 1.05)
			f44_local3(f44_arg0.PlayText)
		end,
	},
	MatchStartHide = {
		DefaultClip = function(f49_arg0, f49_arg1)
			f49_arg0:__resetProperties()
			f49_arg0:setupElementClipCounter(4)
			f49_arg0.circle:completeAnimation()
			f49_arg0.circle:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.circle)
			f49_arg0.CountdownText:completeAnimation()
			f49_arg0.CountdownText:setAlpha(1)
			f49_arg0.clipFinished(f49_arg0.CountdownText)
			f49_arg0.timer:completeAnimation()
			f49_arg0.timer:setAlpha(0)
			f49_arg0.timer:setLetterSpacing(0)
			f49_arg0.clipFinished(f49_arg0.timer)
			f49_arg0.PlayText:completeAnimation()
			f49_arg0.PlayText:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.PlayText)
		end,
		ChildFocus = function(f50_arg0, f50_arg1)
			f50_arg0:__resetProperties()
			f50_arg0:setupElementClipCounter(5)
			f50_arg0.DirectorCustomStartButton:completeAnimation()
			f50_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f50_arg0.clipFinished(f50_arg0.DirectorCustomStartButton)
			f50_arg0.circle:completeAnimation()
			f50_arg0.circle:setAlpha(0)
			f50_arg0.circle:setScale(1.05, 1.05)
			f50_arg0.clipFinished(f50_arg0.circle)
			f50_arg0.CountdownText:completeAnimation()
			f50_arg0.CountdownText:setAlpha(1)
			f50_arg0.CountdownText:setScale(1.05, 1.05)
			f50_arg0.clipFinished(f50_arg0.CountdownText)
			f50_arg0.timer:completeAnimation()
			f50_arg0.timer:setAlpha(0)
			f50_arg0.timer:setScale(1.05, 1.05)
			f50_arg0.timer:setLetterSpacing(0)
			f50_arg0.clipFinished(f50_arg0.timer)
			f50_arg0.PlayText:completeAnimation()
			f50_arg0.PlayText:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.PlayText)
		end,
		GainChildFocus = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties()
			f51_arg0:setupElementClipCounter(5)
			local f51_local0 = function(f52_arg0)
				f51_arg0.DirectorCustomStartButton:beginAnimation(200)
				f51_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
				f51_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f51_arg0.clipInterrupted)
				f51_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f51_arg0.clipFinished)
			end
			f51_arg0.DirectorCustomStartButton:completeAnimation()
			f51_arg0.DirectorCustomStartButton:setScale(1, 1)
			f51_local0(f51_arg0.DirectorCustomStartButton)
			f51_arg0.circle:completeAnimation()
			f51_arg0.circle:setAlpha(0)
			f51_arg0.circle:setScale(1.05, 1.05)
			f51_arg0.clipFinished(f51_arg0.circle)
			local f51_local1 = function(f53_arg0)
				f51_arg0.CountdownText:beginAnimation(200)
				f51_arg0.CountdownText:setScale(1.05, 1.05)
				f51_arg0.CountdownText:registerEventHandler("interrupted_keyframe", f51_arg0.clipInterrupted)
				f51_arg0.CountdownText:registerEventHandler("transition_complete_keyframe", f51_arg0.clipFinished)
			end
			f51_arg0.CountdownText:completeAnimation()
			f51_arg0.CountdownText:setAlpha(1)
			f51_arg0.CountdownText:setScale(1, 1)
			f51_local1(f51_arg0.CountdownText)
			local f51_local2 = function(f54_arg0)
				f51_arg0.timer:beginAnimation(200)
				f51_arg0.timer:setScale(1.05, 1.05)
				f51_arg0.timer:registerEventHandler("interrupted_keyframe", f51_arg0.clipInterrupted)
				f51_arg0.timer:registerEventHandler("transition_complete_keyframe", f51_arg0.clipFinished)
			end
			f51_arg0.timer:completeAnimation()
			f51_arg0.timer:setAlpha(0)
			f51_arg0.timer:setScale(1, 1)
			f51_arg0.timer:setLetterSpacing(0)
			f51_local2(f51_arg0.timer)
			f51_arg0.PlayText:completeAnimation()
			f51_arg0.PlayText:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.PlayText)
		end,
		LoseChildFocus = function(f55_arg0, f55_arg1)
			f55_arg0:__resetProperties()
			f55_arg0:setupElementClipCounter(5)
			local f55_local0 = function(f56_arg0)
				f55_arg0.DirectorCustomStartButton:beginAnimation(200)
				f55_arg0.DirectorCustomStartButton:setScale(1, 1)
				f55_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f55_arg0.clipInterrupted)
				f55_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f55_arg0.clipFinished)
			end
			f55_arg0.DirectorCustomStartButton:completeAnimation()
			f55_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f55_local0(f55_arg0.DirectorCustomStartButton)
			f55_arg0.circle:completeAnimation()
			f55_arg0.circle:setAlpha(0)
			f55_arg0.circle:setScale(1.05, 1.05)
			f55_arg0.clipFinished(f55_arg0.circle)
			local f55_local1 = function(f57_arg0)
				f55_arg0.CountdownText:beginAnimation(200)
				f55_arg0.CountdownText:setScale(1, 1)
				f55_arg0.CountdownText:registerEventHandler("interrupted_keyframe", f55_arg0.clipInterrupted)
				f55_arg0.CountdownText:registerEventHandler("transition_complete_keyframe", f55_arg0.clipFinished)
			end
			f55_arg0.CountdownText:completeAnimation()
			f55_arg0.CountdownText:setAlpha(1)
			f55_arg0.CountdownText:setScale(1.05, 1.05)
			f55_local1(f55_arg0.CountdownText)
			local f55_local2 = function(f58_arg0)
				f55_arg0.timer:beginAnimation(200)
				f55_arg0.timer:setScale(1, 1)
				f55_arg0.timer:registerEventHandler("interrupted_keyframe", f55_arg0.clipInterrupted)
				f55_arg0.timer:registerEventHandler("transition_complete_keyframe", f55_arg0.clipFinished)
			end
			f55_arg0.timer:completeAnimation()
			f55_arg0.timer:setAlpha(0)
			f55_arg0.timer:setScale(1.05, 1.05)
			f55_arg0.timer:setLetterSpacing(0)
			f55_local2(f55_arg0.timer)
			f55_arg0.PlayText:completeAnimation()
			f55_arg0.PlayText:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.PlayText)
		end,
	},
	MatchStarting = {
		DefaultClip = function(f59_arg0, f59_arg1)
			f59_arg0:__resetProperties()
			f59_arg0:setupElementClipCounter(4)
			f59_arg0.circle:completeAnimation()
			f59_arg0.circle:setAlpha(1)
			f59_arg0.clipFinished(f59_arg0.circle)
			f59_arg0.CountdownText:completeAnimation()
			f59_arg0.CountdownText:setAlpha(1)
			f59_arg0.clipFinished(f59_arg0.CountdownText)
			f59_arg0.timer:completeAnimation()
			f59_arg0.timer:setAlpha(1)
			f59_arg0.timer:setLetterSpacing(0)
			f59_arg0.clipFinished(f59_arg0.timer)
			f59_arg0.PlayText:completeAnimation()
			f59_arg0.PlayText:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.PlayText)
		end,
		ChildFocus = function(f60_arg0, f60_arg1)
			f60_arg0:__resetProperties()
			f60_arg0:setupElementClipCounter(5)
			f60_arg0.DirectorCustomStartButton:completeAnimation()
			f60_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f60_arg0.clipFinished(f60_arg0.DirectorCustomStartButton)
			f60_arg0.circle:completeAnimation()
			f60_arg0.circle:setLeftRight(0, 0, 57, 117)
			f60_arg0.circle:setAlpha(1)
			f60_arg0.circle:setScale(1.1, 1.1)
			f60_arg0.clipFinished(f60_arg0.circle)
			f60_arg0.CountdownText:completeAnimation()
			f60_arg0.CountdownText:setAlpha(1)
			f60_arg0.CountdownText:setScale(1.05, 1.05)
			f60_arg0.clipFinished(f60_arg0.CountdownText)
			f60_arg0.timer:completeAnimation()
			f60_arg0.timer:setLeftRight(0, 0, 48, 128)
			f60_arg0.timer:setAlpha(1)
			f60_arg0.timer:setScale(1.05, 1.05)
			f60_arg0.timer:setLetterSpacing(0)
			f60_arg0.clipFinished(f60_arg0.timer)
			f60_arg0.PlayText:completeAnimation()
			f60_arg0.PlayText:setAlpha(0)
			f60_arg0.PlayText:setScale(1, 1.05)
			f60_arg0.clipFinished(f60_arg0.PlayText)
		end,
		GainChildFocus = function(f61_arg0, f61_arg1)
			f61_arg0:__resetProperties()
			f61_arg0:setupElementClipCounter(5)
			local f61_local0 = function(f62_arg0)
				f61_arg0.DirectorCustomStartButton:beginAnimation(200)
				f61_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
				f61_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f61_arg0.clipInterrupted)
				f61_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f61_arg0.clipFinished)
			end
			f61_arg0.DirectorCustomStartButton:completeAnimation()
			f61_arg0.DirectorCustomStartButton:setScale(1, 1)
			f61_local0(f61_arg0.DirectorCustomStartButton)
			local f61_local1 = function(f63_arg0)
				f61_arg0.circle:beginAnimation(200)
				f61_arg0.circle:setLeftRight(0, 0, 57, 117)
				f61_arg0.circle:setScale(1.1, 1.1)
				f61_arg0.circle:registerEventHandler("interrupted_keyframe", f61_arg0.clipInterrupted)
				f61_arg0.circle:registerEventHandler("transition_complete_keyframe", f61_arg0.clipFinished)
			end
			f61_arg0.circle:completeAnimation()
			f61_arg0.circle:setLeftRight(0, 0, 59, 119)
			f61_arg0.circle:setAlpha(1)
			f61_arg0.circle:setScale(1.05, 1.05)
			f61_local1(f61_arg0.circle)
			local f61_local2 = function(f64_arg0)
				f61_arg0.CountdownText:beginAnimation(200)
				f61_arg0.CountdownText:setScale(1.05, 1.05)
				f61_arg0.CountdownText:registerEventHandler("interrupted_keyframe", f61_arg0.clipInterrupted)
				f61_arg0.CountdownText:registerEventHandler("transition_complete_keyframe", f61_arg0.clipFinished)
			end
			f61_arg0.CountdownText:completeAnimation()
			f61_arg0.CountdownText:setAlpha(1)
			f61_arg0.CountdownText:setScale(1, 1)
			f61_local2(f61_arg0.CountdownText)
			local f61_local3 = function(f65_arg0)
				f61_arg0.timer:beginAnimation(200)
				f61_arg0.timer:setLeftRight(0, 0, 48, 128)
				f61_arg0.timer:setScale(1.05, 1.05)
				f61_arg0.timer:registerEventHandler("interrupted_keyframe", f61_arg0.clipInterrupted)
				f61_arg0.timer:registerEventHandler("transition_complete_keyframe", f61_arg0.clipFinished)
			end
			f61_arg0.timer:completeAnimation()
			f61_arg0.timer:setLeftRight(0, 0, 50, 130)
			f61_arg0.timer:setAlpha(1)
			f61_arg0.timer:setScale(1, 1)
			f61_arg0.timer:setLetterSpacing(0)
			f61_local3(f61_arg0.timer)
			local f61_local4 = function(f66_arg0)
				f61_arg0.PlayText:beginAnimation(200)
				f61_arg0.PlayText:setScale(1, 1.05)
				f61_arg0.PlayText:registerEventHandler("interrupted_keyframe", f61_arg0.clipInterrupted)
				f61_arg0.PlayText:registerEventHandler("transition_complete_keyframe", f61_arg0.clipFinished)
			end
			f61_arg0.PlayText:completeAnimation()
			f61_arg0.PlayText:setAlpha(0)
			f61_arg0.PlayText:setScale(1, 1)
			f61_local4(f61_arg0.PlayText)
		end,
		LoseChildFocus = function(f67_arg0, f67_arg1)
			f67_arg0:__resetProperties()
			f67_arg0:setupElementClipCounter(5)
			local f67_local0 = function(f68_arg0)
				f67_arg0.DirectorCustomStartButton:beginAnimation(200)
				f67_arg0.DirectorCustomStartButton:setScale(1, 1)
				f67_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f67_arg0.clipInterrupted)
				f67_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f67_arg0.clipFinished)
			end
			f67_arg0.DirectorCustomStartButton:completeAnimation()
			f67_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f67_local0(f67_arg0.DirectorCustomStartButton)
			local f67_local1 = function(f69_arg0)
				f67_arg0.circle:beginAnimation(200)
				f67_arg0.circle:setLeftRight(0, 0, 59, 119)
				f67_arg0.circle:setScale(1.05, 1.05)
				f67_arg0.circle:registerEventHandler("interrupted_keyframe", f67_arg0.clipInterrupted)
				f67_arg0.circle:registerEventHandler("transition_complete_keyframe", f67_arg0.clipFinished)
			end
			f67_arg0.circle:completeAnimation()
			f67_arg0.circle:setLeftRight(0, 0, 57, 117)
			f67_arg0.circle:setAlpha(1)
			f67_arg0.circle:setScale(1.1, 1.1)
			f67_local1(f67_arg0.circle)
			local f67_local2 = function(f70_arg0)
				f67_arg0.CountdownText:beginAnimation(200)
				f67_arg0.CountdownText:setScale(1, 1)
				f67_arg0.CountdownText:registerEventHandler("interrupted_keyframe", f67_arg0.clipInterrupted)
				f67_arg0.CountdownText:registerEventHandler("transition_complete_keyframe", f67_arg0.clipFinished)
			end
			f67_arg0.CountdownText:completeAnimation()
			f67_arg0.CountdownText:setAlpha(1)
			f67_arg0.CountdownText:setScale(1.05, 1.05)
			f67_local2(f67_arg0.CountdownText)
			local f67_local3 = function(f71_arg0)
				f67_arg0.timer:beginAnimation(200)
				f67_arg0.timer:setLeftRight(0, 0, 50, 130)
				f67_arg0.timer:setScale(1, 1)
				f67_arg0.timer:registerEventHandler("interrupted_keyframe", f67_arg0.clipInterrupted)
				f67_arg0.timer:registerEventHandler("transition_complete_keyframe", f67_arg0.clipFinished)
			end
			f67_arg0.timer:completeAnimation()
			f67_arg0.timer:setLeftRight(0, 0, 48, 128)
			f67_arg0.timer:setAlpha(1)
			f67_arg0.timer:setScale(1.05, 1.05)
			f67_arg0.timer:setLetterSpacing(0)
			f67_local3(f67_arg0.timer)
			local f67_local4 = function(f72_arg0)
				f67_arg0.PlayText:beginAnimation(200)
				f67_arg0.PlayText:setScale(1, 1)
				f67_arg0.PlayText:registerEventHandler("interrupted_keyframe", f67_arg0.clipInterrupted)
				f67_arg0.PlayText:registerEventHandler("transition_complete_keyframe", f67_arg0.clipFinished)
			end
			f67_arg0.PlayText:completeAnimation()
			f67_arg0.PlayText:setAlpha(0)
			f67_arg0.PlayText:setScale(1, 1.05)
			f67_local4(f67_arg0.PlayText)
		end,
	},
	WaitingForMorePlayers = {
		DefaultClip = function(f73_arg0, f73_arg1)
			f73_arg0:__resetProperties()
			f73_arg0:setupElementClipCounter(7)
			f73_arg0.Backing:completeAnimation()
			f73_arg0.Backing:setAlpha(1)
			f73_arg0.clipFinished(f73_arg0.Backing)
			f73_arg0.DirectorCustomStartButton:completeAnimation()
			f73_arg0.DirectorCustomStartButton:setAlpha(0)
			f73_arg0.clipFinished(f73_arg0.DirectorCustomStartButton)
			f73_arg0.Border01:completeAnimation()
			f73_arg0.Border01:setAlpha(1)
			f73_arg0.clipFinished(f73_arg0.Border01)
			f73_arg0.FrontendFrame:completeAnimation()
			f73_arg0.FrontendFrame:setAlpha(0.1)
			f73_arg0.clipFinished(f73_arg0.FrontendFrame)
			f73_arg0.Border:completeAnimation()
			f73_arg0.Border:setAlpha(0)
			f73_arg0.clipFinished(f73_arg0.Border)
			f73_arg0.PlayText:completeAnimation()
			f73_arg0.PlayText:setAlpha(0)
			f73_arg0.clipFinished(f73_arg0.PlayText)
			f73_arg0.WaitingText:completeAnimation()
			f73_arg0.WaitingText:setAlpha(1)
			f73_arg0.clipFinished(f73_arg0.WaitingText)
		end,
	},
	Disabled = {
		DefaultClip = function(f74_arg0, f74_arg1)
			f74_arg0:__resetProperties()
			f74_arg0:setupElementClipCounter(2)
			f74_arg0.DirectorCustomStartButton:completeAnimation()
			f74_arg0.DirectorCustomStartButton:setRGB(0.58, 0.58, 0.58)
			f74_arg0.clipFinished(f74_arg0.DirectorCustomStartButton)
			f74_arg0.PlayText:completeAnimation()
			f74_arg0.PlayText:setRGB(0.59, 0.59, 0.59)
			f74_arg0.PlayText:setAlpha(0.15)
			f74_arg0.clipFinished(f74_arg0.PlayText)
		end,
	},
	Hidden = {
		DefaultClip = function(f75_arg0, f75_arg1)
			f75_arg0:__resetProperties()
			f75_arg0:setupElementClipCounter(6)
			f75_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f75_arg0.DirectorSelectButtonMiniInternal:setAlpha(0)
			f75_arg0.clipFinished(f75_arg0.DirectorSelectButtonMiniInternal)
			f75_arg0.DirectorCustomStartButton:completeAnimation()
			f75_arg0.DirectorCustomStartButton:setAlpha(0)
			f75_arg0.clipFinished(f75_arg0.DirectorCustomStartButton)
			f75_arg0.circle:completeAnimation()
			f75_arg0.circle:setAlpha(0)
			f75_arg0.clipFinished(f75_arg0.circle)
			f75_arg0.CountdownText:completeAnimation()
			f75_arg0.CountdownText:setAlpha(0)
			f75_arg0.clipFinished(f75_arg0.CountdownText)
			f75_arg0.timer:completeAnimation()
			f75_arg0.timer:setAlpha(0)
			f75_arg0.clipFinished(f75_arg0.timer)
			f75_arg0.PlayText:completeAnimation()
			f75_arg0.PlayText:setAlpha(0)
			f75_arg0.clipFinished(f75_arg0.PlayText)
		end,
	},
	Ready = {
		DefaultClip = function(f76_arg0, f76_arg1)
			f76_arg0:__resetProperties()
			f76_arg0:setupElementClipCounter(2)
			f76_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f76_arg0.DirectorSelectButtonMiniInternal.MiddleText:completeAnimation()
			f76_arg0.DirectorSelectButtonMiniInternal.MiddleTextFocus:completeAnimation()
			f76_arg0.DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString(@"menu/ready"))
			f76_arg0.DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString(@"menu/ready"))
			f76_arg0.clipFinished(f76_arg0.DirectorSelectButtonMiniInternal)
			f76_arg0.PlayText:completeAnimation()
			f76_arg0.PlayText:setText(LocalizeToUpperString(@"menu/ready"))
			f76_arg0.clipFinished(f76_arg0.PlayText)
		end,
		ChildFocus = function(f77_arg0, f77_arg1)
			f77_arg0:__resetProperties()
			f77_arg0:setupElementClipCounter(2)
			f77_arg0.DirectorCustomStartButton:completeAnimation()
			f77_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f77_arg0.clipFinished(f77_arg0.DirectorCustomStartButton)
			f77_arg0.PlayText:completeAnimation()
			f77_arg0.PlayText:setScale(1.05, 1.05)
			f77_arg0.PlayText:setText(LocalizeToUpperString(@"menu/ready"))
			f77_arg0.clipFinished(f77_arg0.PlayText)
		end,
		GainChildFocus = function(f78_arg0, f78_arg1)
			f78_arg0:__resetProperties()
			f78_arg0:setupElementClipCounter(2)
			local f78_local0 = function(f79_arg0)
				f78_arg0.DirectorCustomStartButton:beginAnimation(200)
				f78_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
				f78_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f78_arg0.clipInterrupted)
				f78_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f78_arg0.clipFinished)
			end
			f78_arg0.DirectorCustomStartButton:completeAnimation()
			f78_arg0.DirectorCustomStartButton:setScale(1, 1)
			f78_local0(f78_arg0.DirectorCustomStartButton)
			local f78_local1 = function(f80_arg0)
				f78_arg0.PlayText:beginAnimation(200)
				f78_arg0.PlayText:setScale(1.05, 1.05)
				f78_arg0.PlayText:registerEventHandler("interrupted_keyframe", f78_arg0.clipInterrupted)
				f78_arg0.PlayText:registerEventHandler("transition_complete_keyframe", f78_arg0.clipFinished)
			end
			f78_arg0.PlayText:completeAnimation()
			f78_arg0.PlayText:setScale(1, 1)
			f78_arg0.PlayText:setText(LocalizeToUpperString(@"menu/ready"))
			f78_local1(f78_arg0.PlayText)
		end,
		LoseChildFocus = function(f81_arg0, f81_arg1)
			f81_arg0:__resetProperties()
			f81_arg0:setupElementClipCounter(2)
			local f81_local0 = function(f82_arg0)
				f81_arg0.DirectorCustomStartButton:beginAnimation(200)
				f81_arg0.DirectorCustomStartButton:setScale(1, 1)
				f81_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f81_arg0.clipInterrupted)
				f81_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f81_arg0.clipFinished)
			end
			f81_arg0.DirectorCustomStartButton:completeAnimation()
			f81_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f81_local0(f81_arg0.DirectorCustomStartButton)
			local f81_local1 = function(f83_arg0)
				f81_arg0.PlayText:beginAnimation(200)
				f81_arg0.PlayText:setScale(1, 1)
				f81_arg0.PlayText:registerEventHandler("interrupted_keyframe", f81_arg0.clipInterrupted)
				f81_arg0.PlayText:registerEventHandler("transition_complete_keyframe", f81_arg0.clipFinished)
			end
			f81_arg0.PlayText:completeAnimation()
			f81_arg0.PlayText:setScale(1.05, 1.05)
			f81_arg0.PlayText:setText(LocalizeToUpperString(@"menu/ready"))
			f81_local1(f81_arg0.PlayText)
		end,
	},
}
CoD.DirectorReadyButton.__onClose = function(f84_arg0)
	f84_arg0.DirectorSelectButtonMiniInternal:close()
	f84_arg0.DirectorCustomStartButton:close()
	f84_arg0.Border01:close()
	f84_arg0.Border:close()
	f84_arg0.CountdownText:close()
	f84_arg0.timer:close()
	f84_arg0.Fill:close()
	f84_arg0.Fill2:close()
end
