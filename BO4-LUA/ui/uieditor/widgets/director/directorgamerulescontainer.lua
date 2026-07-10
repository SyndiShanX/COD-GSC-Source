require("x64:68bf3a99a7a58d4")
require("x64:399eb2033b1feff")
CoD.DirectorGameRulesContainer = InheritFrom(LUI.UIElement)
CoD.DirectorGameRulesContainer.__defaultWidth = 356
CoD.DirectorGameRulesContainer.__defaultHeight = 200
CoD.DirectorGameRulesContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorGameRulesContainer)
	self.id = "DirectorGameRulesContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 1, 2, -2, 0, 1, 2, -2)
	Background:setRGB(0.13, 0.12, 0.12)
	Background:setAlpha(0.9)
	self:addElement(Background)
	self.Background = Background
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setAlpha(0.01)
	self:addElement(Backing)
	self.Backing = Backing
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.4)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local NoiseTiledBackingAdd = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBackingAdd:setAlpha(0.35)
	NoiseTiledBackingAdd:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBackingAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	NoiseTiledBackingAdd:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBackingAdd:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBackingAdd)
	self.NoiseTiledBackingAdd = NoiseTiledBackingAdd
	local FrontendFrameSelected = LUI.UIImage.new(0, 1, -4, 4, 0, 1, -4, 4)
	FrontendFrameSelected:setAlpha(0)
	FrontendFrameSelected:setImage(RegisterImage(@"uie_ui_menu_store_focus_frame"))
	FrontendFrameSelected:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFrameSelected:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrameSelected:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrameSelected)
	self.FrontendFrameSelected = FrontendFrameSelected
	local FrontendFrameSelectedGlow = LUI.UIImage.new(0, 1, -8, 8, 0, 1, -8, 8)
	FrontendFrameSelectedGlow:setAlpha(0)
	FrontendFrameSelectedGlow:setImage(RegisterImage(@"uie_ui_menu_store_focus_frame"))
	FrontendFrameSelectedGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFrameSelectedGlow:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrameSelectedGlow:setupNineSliceShader(28, 28)
	self:addElement(FrontendFrameSelectedGlow)
	self.FrontendFrameSelectedGlow = FrontendFrameSelectedGlow
	local FrontendFocusPip = LUI.UIImage.new(0, 1, -6, 6, 0, 1, -6, 6)
	FrontendFocusPip:setImage(RegisterImage(@"uie_ui_menu_store_focus_pips"))
	FrontendFocusPip:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFocusPip:setShaderVector(0, 0, 0, 0, 0)
	FrontendFocusPip:setupNineSliceShader(40, 40)
	self:addElement(FrontendFocusPip)
	self.FrontendFocusPip = FrontendFocusPip
	local FrontendFrame = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrontendFrame:setAlpha(0.2)
	FrontendFrame:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	FrontendFrame:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFrame:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrame)
	self.FrontendFrame = FrontendFrame
	local RulesImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	RulesImage:setRGB(0.78, 0.78, 0.78)
	RulesImage:setAlpha(0)
	RulesImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_blend"))
	self:addElement(RulesImage)
	self.RulesImage = RulesImage
	local Official = CoD.MapVoteOfficial.new(f1_arg0, f1_arg1, 0.5, 0.5, -170, 170, 0, 0, 38, 60)
	self:addElement(Official)
	self.Official = Official
	local SubTitle = LUI.UIText.new(0.5, 0.5, -170, 170, 0, 0, 8, 38)
	SubTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_64168F7749B756F7"))
	SubTitle:setTTF("ttmussels_regular")
	SubTitle:setLetterSpacing(6)
	SubTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	LUI.OverrideFunction_CallOriginalFirst(SubTitle, "setText", function(element, controller)
		ScaleWidgetToLabelLeftJustify(self, element, 2)
	end)
	self:addElement(SubTitle)
	self.SubTitle = SubTitle
	local DirectorMapVoteRuleIcon = CoD.DirectorMapVoteRuleIcon.new(f1_arg0, f1_arg1, 0.5, 0.5, -75, 75, 0.5, 0.5, -75, 75)
	self:addElement(DirectorMapVoteRuleIcon)
	self.DirectorMapVoteRuleIcon = DirectorMapVoteRuleIcon
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return not IsLobbyHostOfCurrentMenu()
			end,
		},
	})
	self:appendEventHandler("on_session_start", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f4_arg1)
	end)
	self:appendEventHandler("on_session_end", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f5_arg1)
	end)
	local f1_local13 = self
	local f1_local14 = self.subscribeToModel
	local f1_local15 = Engine[@"getglobalmodel"]()
	f1_local14(f1_local13, f1_local15["lobbyRoot.lobbyNav"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local13 = self
	f1_local14 = self.subscribeToModel
	f1_local15 = Engine[@"getglobalmodel"]()
	f1_local14(f1_local13, f1_local15["lobbyRoot.gameClient.update"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "lobbyRoot.gameClient.update",
		})
	end, false)
	f1_local13 = self
	f1_local14 = self.subscribeToModel
	f1_local15 = Engine[@"getglobalmodel"]()
	f1_local14(f1_local13, f1_local15["lobbyRoot.privateClient.update"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorGameRulesContainer.__resetProperties = function(f9_arg0)
	f9_arg0.FrontendFocusPip:completeAnimation()
	f9_arg0.FrontendFrameSelected:completeAnimation()
	f9_arg0.SubTitle:completeAnimation()
	f9_arg0.Official:completeAnimation()
	f9_arg0.FrontendFrameSelectedGlow:completeAnimation()
	f9_arg0.NoiseTiledBackingAdd:completeAnimation()
	f9_arg0.Backing:completeAnimation()
	f9_arg0.RulesImage:completeAnimation()
	f9_arg0.DirectorMapVoteRuleIcon:completeAnimation()
	f9_arg0.Background:completeAnimation()
	f9_arg0.FrontendFocusPip:setAlpha(1)
	f9_arg0.FrontendFocusPip:setScale(1, 1)
	f9_arg0.FrontendFrameSelected:setAlpha(0)
	f9_arg0.SubTitle:setRGB(1, 1, 1)
	f9_arg0.SubTitle:setAlpha(1)
	f9_arg0.Official:setRGB(1, 1, 1)
	f9_arg0.Official:setAlpha(1)
	f9_arg0.FrontendFrameSelectedGlow:setAlpha(0)
	f9_arg0.NoiseTiledBackingAdd:setAlpha(0.35)
	f9_arg0.Backing:setAlpha(0.01)
	f9_arg0.RulesImage:setRGB(0.78, 0.78, 0.78)
	f9_arg0.RulesImage:setAlpha(0)
	f9_arg0.DirectorMapVoteRuleIcon:setAlpha(1)
	f9_arg0.Background:setAlpha(0.9)
end
CoD.DirectorGameRulesContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.FrontendFrameSelected:completeAnimation()
			f10_arg0.FrontendFrameSelected:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.FrontendFrameSelected)
			f10_arg0.FrontendFocusPip:completeAnimation()
			f10_arg0.FrontendFocusPip:setAlpha(0)
			f10_arg0.FrontendFocusPip:setScale(1.06, 1.09)
			f10_arg0.clipFinished(f10_arg0.FrontendFocusPip)
		end,
		Focus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(7)
			f11_arg0.Backing:completeAnimation()
			f11_arg0.Backing:setAlpha(0.02)
			f11_arg0.clipFinished(f11_arg0.Backing)
			f11_arg0.NoiseTiledBackingAdd:completeAnimation()
			f11_arg0.NoiseTiledBackingAdd:setAlpha(0.65)
			f11_arg0.clipFinished(f11_arg0.NoiseTiledBackingAdd)
			f11_arg0.FrontendFrameSelected:completeAnimation()
			f11_arg0.FrontendFrameSelected:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.FrontendFrameSelected)
			f11_arg0.FrontendFrameSelectedGlow:completeAnimation()
			f11_arg0.FrontendFrameSelectedGlow:setAlpha(0.05)
			f11_arg0.clipFinished(f11_arg0.FrontendFrameSelectedGlow)
			f11_arg0.FrontendFocusPip:completeAnimation()
			f11_arg0.FrontendFocusPip:setAlpha(0.3)
			f11_arg0.clipFinished(f11_arg0.FrontendFocusPip)
			f11_arg0.Official:completeAnimation()
			f11_arg0.Official:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f11_arg0.clipFinished(f11_arg0.Official)
			f11_arg0.SubTitle:completeAnimation()
			f11_arg0.SubTitle:setRGB(0.92, 0.89, 0.72)
			f11_arg0.clipFinished(f11_arg0.SubTitle)
		end,
		GainFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(7)
			local f12_local0 = function(f13_arg0)
				f12_arg0.Backing:beginAnimation(150)
				f12_arg0.Backing:setAlpha(0.02)
				f12_arg0.Backing:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.Backing:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.Backing:completeAnimation()
			f12_arg0.Backing:setAlpha(0.01)
			f12_local0(f12_arg0.Backing)
			local f12_local1 = function(f14_arg0)
				f12_arg0.NoiseTiledBackingAdd:beginAnimation(150)
				f12_arg0.NoiseTiledBackingAdd:setAlpha(0.65)
				f12_arg0.NoiseTiledBackingAdd:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.NoiseTiledBackingAdd:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.NoiseTiledBackingAdd:completeAnimation()
			f12_arg0.NoiseTiledBackingAdd:setAlpha(0.35)
			f12_local1(f12_arg0.NoiseTiledBackingAdd)
			local f12_local2 = function(f15_arg0)
				f12_arg0.FrontendFrameSelected:beginAnimation(150)
				f12_arg0.FrontendFrameSelected:setAlpha(1)
				f12_arg0.FrontendFrameSelected:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.FrontendFrameSelected:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.FrontendFrameSelected:completeAnimation()
			f12_arg0.FrontendFrameSelected:setAlpha(0)
			f12_local2(f12_arg0.FrontendFrameSelected)
			local f12_local3 = function(f16_arg0)
				f12_arg0.FrontendFrameSelectedGlow:beginAnimation(150)
				f12_arg0.FrontendFrameSelectedGlow:setAlpha(0.05)
				f12_arg0.FrontendFrameSelectedGlow:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.FrontendFrameSelectedGlow:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.FrontendFrameSelectedGlow:completeAnimation()
			f12_arg0.FrontendFrameSelectedGlow:setAlpha(0)
			f12_local3(f12_arg0.FrontendFrameSelectedGlow)
			local f12_local4 = function(f17_arg0)
				f12_arg0.FrontendFocusPip:beginAnimation(150)
				f12_arg0.FrontendFocusPip:setAlpha(0.3)
				f12_arg0.FrontendFocusPip:setScale(1, 1)
				f12_arg0.FrontendFocusPip:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.FrontendFocusPip:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.FrontendFocusPip:completeAnimation()
			f12_arg0.FrontendFocusPip:setAlpha(0)
			f12_arg0.FrontendFocusPip:setScale(1.06, 1.09)
			f12_local4(f12_arg0.FrontendFocusPip)
			f12_arg0.Official:completeAnimation()
			f12_arg0.Official:setRGB(1, 1, 1)
			f12_arg0.clipFinished(f12_arg0.Official)
			f12_arg0.SubTitle:completeAnimation()
			f12_arg0.SubTitle:setRGB(1, 1, 1)
			f12_arg0.clipFinished(f12_arg0.SubTitle)
		end,
		LoseFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(7)
			local f18_local0 = function(f19_arg0)
				f18_arg0.Backing:beginAnimation(150)
				f18_arg0.Backing:setAlpha(0.01)
				f18_arg0.Backing:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.Backing:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.Backing:completeAnimation()
			f18_arg0.Backing:setAlpha(0.02)
			f18_local0(f18_arg0.Backing)
			local f18_local1 = function(f20_arg0)
				f18_arg0.NoiseTiledBackingAdd:beginAnimation(150)
				f18_arg0.NoiseTiledBackingAdd:setAlpha(0.35)
				f18_arg0.NoiseTiledBackingAdd:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.NoiseTiledBackingAdd:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.NoiseTiledBackingAdd:completeAnimation()
			f18_arg0.NoiseTiledBackingAdd:setAlpha(0.65)
			f18_local1(f18_arg0.NoiseTiledBackingAdd)
			local f18_local2 = function(f21_arg0)
				f18_arg0.FrontendFrameSelected:beginAnimation(150)
				f18_arg0.FrontendFrameSelected:setAlpha(0)
				f18_arg0.FrontendFrameSelected:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.FrontendFrameSelected:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.FrontendFrameSelected:completeAnimation()
			f18_arg0.FrontendFrameSelected:setAlpha(1)
			f18_local2(f18_arg0.FrontendFrameSelected)
			local f18_local3 = function(f22_arg0)
				f18_arg0.FrontendFrameSelectedGlow:beginAnimation(150)
				f18_arg0.FrontendFrameSelectedGlow:setAlpha(0)
				f18_arg0.FrontendFrameSelectedGlow:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.FrontendFrameSelectedGlow:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.FrontendFrameSelectedGlow:completeAnimation()
			f18_arg0.FrontendFrameSelectedGlow:setAlpha(0.05)
			f18_local3(f18_arg0.FrontendFrameSelectedGlow)
			local f18_local4 = function(f23_arg0)
				f18_arg0.FrontendFocusPip:beginAnimation(150)
				f18_arg0.FrontendFocusPip:setAlpha(0)
				f18_arg0.FrontendFocusPip:setScale(1.06, 1.09)
				f18_arg0.FrontendFocusPip:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.FrontendFocusPip:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.FrontendFocusPip:completeAnimation()
			f18_arg0.FrontendFocusPip:setAlpha(0.3)
			f18_arg0.FrontendFocusPip:setScale(1, 1)
			f18_local4(f18_arg0.FrontendFocusPip)
			f18_arg0.Official:completeAnimation()
			f18_arg0.Official:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f18_arg0.clipFinished(f18_arg0.Official)
			f18_arg0.SubTitle:completeAnimation()
			f18_arg0.SubTitle:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f18_arg0.clipFinished(f18_arg0.SubTitle)
		end,
	},
	Disabled = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(6)
			f24_arg0.Background:completeAnimation()
			f24_arg0.Background:setAlpha(0.2)
			f24_arg0.clipFinished(f24_arg0.Background)
			f24_arg0.FrontendFocusPip:completeAnimation()
			f24_arg0.FrontendFocusPip:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.FrontendFocusPip)
			f24_arg0.RulesImage:completeAnimation()
			f24_arg0.RulesImage:setRGB(0.17, 0.17, 0.17)
			f24_arg0.RulesImage:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.RulesImage)
			f24_arg0.Official:completeAnimation()
			f24_arg0.Official:setAlpha(0.1)
			f24_arg0.clipFinished(f24_arg0.Official)
			f24_arg0.SubTitle:completeAnimation()
			f24_arg0.SubTitle:setAlpha(0.1)
			f24_arg0.clipFinished(f24_arg0.SubTitle)
			f24_arg0.DirectorMapVoteRuleIcon:completeAnimation()
			f24_arg0.DirectorMapVoteRuleIcon:setAlpha(0.1)
			f24_arg0.clipFinished(f24_arg0.DirectorMapVoteRuleIcon)
		end,
	},
}
CoD.DirectorGameRulesContainer.__onClose = function(f25_arg0)
	f25_arg0.Official:close()
	f25_arg0.DirectorMapVoteRuleIcon:close()
end
