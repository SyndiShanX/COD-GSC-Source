require("x64:dab8c3a6f5b136c")
require("x64:f78acfcbc465bba")
require("x64:1f846296f1a1b81")
CoD.DirectorPreGameButtonOption = InheritFrom(LUI.UIElement)
CoD.DirectorPreGameButtonOption.__defaultWidth = 250
CoD.DirectorPreGameButtonOption.__defaultHeight = 92
CoD.DirectorPreGameButtonOption.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorPreGameButtonOption)
	self.id = "DirectorPreGameButtonOption"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorSelectButtonMiniInternal = CoD.DirectorSelectButtonMiniInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DirectorSelectButtonMiniInternal:mergeStateConditions({
		{
			stateName = "TrialLocked",
			condition = function(menu, element, event)
				return IsSelfInState(self, "VisibleTrialLocked")
			end,
		},
		{
			stateName = "ArenaSuspended",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsSelfInState(self, "ArenaSuspended")
			end,
		},
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
	DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString(@"hash_A43B10D9DA121A"))
	DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString(@"hash_A43B10D9DA121A"))
	self:addElement(DirectorSelectButtonMiniInternal)
	self.DirectorSelectButtonMiniInternal = DirectorSelectButtonMiniInternal
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setRGB(0, 0, 0)
	SceneBlur:setAlpha(0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	SceneBlur:setShaderVector(0, 0, 0.4, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local Tint = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Tint:setRGB(0, 0, 0)
	Tint:setAlpha(0)
	self:addElement(Tint)
	self.Tint = Tint
	local DotTiledBacking = CoD.CommonPixelBacking.new(f1_arg0, f1_arg1, 0, 1, 4, -4, 0, 1, 4, -4)
	DotTiledBacking:setAlpha(0)
	DotTiledBacking:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	DotTiledBacking.NoiseBacking:setAlpha(1)
	DotTiledBacking.TiledShaderImage:setRGB(0.22, 0.22, 0.22)
	DotTiledBacking.TiledShaderImage:setAlpha(0.15)
	DotTiledBacking.TiledShaderImage:setupNineSliceShader(36, 36)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local FrameBorder = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrameBorder:setAlpha(0)
	FrameBorder:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	FrameBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrameBorder:setShaderVector(0, 0, 0, 0, 0)
	FrameBorder:setupNineSliceShader(12, 12)
	self:addElement(FrameBorder)
	self.FrameBorder = FrameBorder
	local Lines = CoD.DirectorSelectButtonLines.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 1, -1)
	Lines:setRGB(0.64, 0.71, 0.78)
	Lines:setAlpha(0)
	self:addElement(Lines)
	self.Lines = Lines
	local SuspendedTxt = LUI.UIText.new(0, 1, 24, -24, 0.5, 0.5, -12, 12)
	SuspendedTxt:setRGB(0.92, 0.92, 0.92)
	SuspendedTxt:setAlpha(0)
	SuspendedTxt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_3B58CF470802AA10"))
	SuspendedTxt:setTTF("ttmussels_regular")
	SuspendedTxt:setLetterSpacing(3)
	SuspendedTxt:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	SuspendedTxt:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(SuspendedTxt)
	self.SuspendedTxt = SuspendedTxt
	local Timer = LUI.UIText.new(0.5, 0.5, -130, 130, 0.5, 0.5, 15, 29)
	Timer:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	Timer:setAlpha(0)
	Timer:setTTF("dinnext_regular")
	Timer:setLetterSpacing(1)
	Timer:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Timer:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Timer:subscribeToGlobalModel(f1_arg1, "Arena", "lockoutTimeRemaining", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Timer:setText(f6_local0)
		end
	end)
	self:addElement(Timer)
	self.Timer = Timer
	self:mergeStateConditions({
		{
			stateName = "VisibleTrialLocked",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "ArenaSuspended",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Unselectable",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "VisibleZmOffline",
			condition = function(menu, element, event)
				local f10_local0 = AlwaysFalse()
				if f10_local0 then
					f10_local0 = IsLobbyHostOfCurrentMenu()
					if f10_local0 then
						if not IsPublicOrLeagueGame(f1_arg1) then
							f10_local0 = IsZombies()
							if f10_local0 then
								f10_local0 = IsLobbyNetworkModeLAN()
								if f10_local0 then
									f10_local0 = not CoD.DirectorUtility.IsOfflineScreenStateCustomGame()
								end
							end
						else
							f10_local0 = false
						end
					end
				end
				return f10_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	self:appendEventHandler("on_session_start", function(f12_arg0, f12_arg1)
		f12_arg1.menu = f12_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f12_arg1)
	end)
	self:appendEventHandler("on_session_end", function(f13_arg0, f13_arg1)
		f13_arg1.menu = f13_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f13_arg1)
	end)
	local f1_local10 = self
	local f1_local11 = self.subscribeToModel
	local f1_local12 = Engine[@"getglobalmodel"]()
	f1_local11(f1_local10, f1_local12["lobbyRoot.lobbyNav"], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[@"getglobalmodel"]()
	f1_local11(f1_local10, f1_local12["lobbyRoot.gameClient.update"], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "lobbyRoot.gameClient.update",
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[@"getglobalmodel"]()
	f1_local11(f1_local10, f1_local12["lobbyRoot.privateClient.update"], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[@"getglobalmodel"]()
	f1_local11(f1_local10, f1_local12.offlineScreenState, function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "offlineScreenState",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f18_arg2, f18_arg3, f18_arg4)
		UpdateElementState(self, "DirectorSelectButtonMiniInternal", controller)
	end)
	DirectorSelectButtonMiniInternal.id = "DirectorSelectButtonMiniInternal"
	self.__defaultFocus = DirectorSelectButtonMiniInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorPreGameButtonOption.__resetProperties = function(f19_arg0)
	f19_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
	f19_arg0.Lines:completeAnimation()
	f19_arg0.FrameBorder:completeAnimation()
	f19_arg0.DotTiledBacking:completeAnimation()
	f19_arg0.Tint:completeAnimation()
	f19_arg0.NoiseTiledBacking:completeAnimation()
	f19_arg0.SceneBlur:completeAnimation()
	f19_arg0.SuspendedTxt:completeAnimation()
	f19_arg0.Timer:completeAnimation()
	f19_arg0.DirectorSelectButtonMiniInternal:setAlpha(1)
	f19_arg0.DirectorSelectButtonMiniInternal:setScale(1, 1)
	f19_arg0.DirectorSelectButtonMiniInternal.Tint:setRGB(0, 0, 0)
	f19_arg0.Lines:setAlpha(0)
	f19_arg0.FrameBorder:setAlpha(0)
	f19_arg0.DotTiledBacking:setRGB(1, 1, 1)
	f19_arg0.DotTiledBacking:setAlpha(0)
	f19_arg0.DotTiledBacking.TiledShaderImage:setRGB(0.22, 0.22, 0.22)
	f19_arg0.DotTiledBacking.TiledShaderImage:setAlpha(0.15)
	f19_arg0.Tint:setRGB(0, 0, 0)
	f19_arg0.Tint:setAlpha(0)
	f19_arg0.NoiseTiledBacking:setAlpha(0)
	f19_arg0.SceneBlur:setAlpha(0)
	f19_arg0.SuspendedTxt:setRGB(0.92, 0.92, 0.92)
	f19_arg0.SuspendedTxt:setAlpha(0)
	f19_arg0.Timer:setAlpha(0)
end
CoD.DirectorPreGameButtonOption.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f20_arg0.DirectorSelectButtonMiniInternal:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.DirectorSelectButtonMiniInternal)
		end,
	},
	VisibleTrialLocked = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f22_arg0.DirectorSelectButtonMiniInternal:setScale(1.05, 1.05)
			f22_arg0.clipFinished(f22_arg0.DirectorSelectButtonMiniInternal)
		end,
		GainChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			local f23_local0 = function(f24_arg0)
				f23_arg0.DirectorSelectButtonMiniInternal:beginAnimation(200)
				f23_arg0.DirectorSelectButtonMiniInternal:setScale(1.05, 1.05)
				f23_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f23_arg0.DirectorSelectButtonMiniInternal:setScale(1, 1)
			f23_local0(f23_arg0.DirectorSelectButtonMiniInternal)
		end,
		LoseChildFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			local f25_local0 = function(f26_arg0)
				f25_arg0.DirectorSelectButtonMiniInternal:beginAnimation(200)
				f25_arg0.DirectorSelectButtonMiniInternal:setScale(1, 1)
				f25_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f25_arg0.DirectorSelectButtonMiniInternal:setScale(1.05, 1.05)
			f25_local0(f25_arg0.DirectorSelectButtonMiniInternal)
		end,
	},
	ArenaSuspended = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(9)
			f27_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f27_arg0.DirectorSelectButtonMiniInternal.Tint:completeAnimation()
			f27_arg0.DirectorSelectButtonMiniInternal:setAlpha(0)
			f27_arg0.DirectorSelectButtonMiniInternal.Tint:setRGB(0.27, 0.06, 0.06)
			f27_arg0.clipFinished(f27_arg0.DirectorSelectButtonMiniInternal)
			f27_arg0.SceneBlur:completeAnimation()
			f27_arg0.SceneBlur:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.SceneBlur)
			f27_arg0.NoiseTiledBacking:completeAnimation()
			f27_arg0.NoiseTiledBacking:setAlpha(0.95)
			f27_arg0.clipFinished(f27_arg0.NoiseTiledBacking)
			f27_arg0.Tint:completeAnimation()
			f27_arg0.Tint:setRGB(0.27, 0.06, 0.06)
			f27_arg0.Tint:setAlpha(0.75)
			f27_arg0.clipFinished(f27_arg0.Tint)
			f27_arg0.DotTiledBacking:completeAnimation()
			f27_arg0.DotTiledBacking.TiledShaderImage:completeAnimation()
			f27_arg0.DotTiledBacking:setRGB(1, 1, 1)
			f27_arg0.DotTiledBacking:setAlpha(1)
			f27_arg0.DotTiledBacking.TiledShaderImage:setRGB(0.39, 0.11, 0.11)
			f27_arg0.DotTiledBacking.TiledShaderImage:setAlpha(0.15)
			f27_arg0.clipFinished(f27_arg0.DotTiledBacking)
			f27_arg0.FrameBorder:completeAnimation()
			f27_arg0.FrameBorder:setAlpha(0.1)
			f27_arg0.clipFinished(f27_arg0.FrameBorder)
			f27_arg0.Lines:completeAnimation()
			f27_arg0.Lines:setAlpha(0.2)
			f27_arg0.clipFinished(f27_arg0.Lines)
			f27_arg0.SuspendedTxt:completeAnimation()
			f27_arg0.SuspendedTxt:setRGB(1, 0, 0)
			f27_arg0.SuspendedTxt:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.SuspendedTxt)
			f27_arg0.Timer:completeAnimation()
			f27_arg0.Timer:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.Timer)
		end,
	},
	Unselectable = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(0)
		end,
	},
	VisibleZmOffline = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(0)
		end,
	},
	Visible = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(1)
			f31_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f31_arg0.DirectorSelectButtonMiniInternal:setScale(1.05, 1.05)
			f31_arg0.clipFinished(f31_arg0.DirectorSelectButtonMiniInternal)
		end,
		GainChildFocus = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(1)
			local f32_local0 = function(f33_arg0)
				f32_arg0.DirectorSelectButtonMiniInternal:beginAnimation(200)
				f32_arg0.DirectorSelectButtonMiniInternal:setScale(1.05, 1.05)
				f32_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f32_arg0.DirectorSelectButtonMiniInternal:setScale(1, 1)
			f32_local0(f32_arg0.DirectorSelectButtonMiniInternal)
		end,
		LoseChildFocus = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(1)
			local f34_local0 = function(f35_arg0)
				f34_arg0.DirectorSelectButtonMiniInternal:beginAnimation(200)
				f34_arg0.DirectorSelectButtonMiniInternal:setScale(1, 1)
				f34_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("interrupted_keyframe", f34_arg0.clipInterrupted)
				f34_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("transition_complete_keyframe", f34_arg0.clipFinished)
			end
			f34_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f34_arg0.DirectorSelectButtonMiniInternal:setScale(1.05, 1.05)
			f34_local0(f34_arg0.DirectorSelectButtonMiniInternal)
		end,
	},
}
CoD.DirectorPreGameButtonOption.__onClose = function(f36_arg0)
	f36_arg0.DirectorSelectButtonMiniInternal:close()
	f36_arg0.DotTiledBacking:close()
	f36_arg0.Lines:close()
	f36_arg0.Timer:close()
end
