require("x64:228a7baa572b047")
require("x64:174f2b412760fd3")
require("x64:891695c75906b3c")
require("x64:88882bece551bf0")
require("x64:e12ddba2d13fc72")
CoD.DirectorCODCasterMemberInfo = InheritFrom(LUI.UIElement)
CoD.DirectorCODCasterMemberInfo.__defaultWidth = 400
CoD.DirectorCODCasterMemberInfo.__defaultHeight = 85
CoD.DirectorCODCasterMemberInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorCODCasterMemberInfo)
	self.id = "DirectorCODCasterMemberInfo"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	SceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local BackingBorder = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackingBorder:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	BackingBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	BackingBorder:setShaderVector(0, 0, 0, 0, 0)
	BackingBorder:setupNineSliceShader(196, 88)
	self:addElement(BackingBorder)
	self.BackingBorder = BackingBorder
	local BackingBorder2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackingBorder2:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	BackingBorder2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	BackingBorder2:setShaderVector(0, 0, 0, 0, 0)
	BackingBorder2:setupNineSliceShader(196, 88)
	self:addElement(BackingBorder2)
	self.BackingBorder2 = BackingBorder2
	local BackingEmblem = LUI.UIImage.new(0, 0, 3, 82, 0, 0, 3, 82)
	BackingEmblem:setAlpha(0.7)
	BackingEmblem:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	BackingEmblem:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	BackingEmblem:setShaderVector(0, 0, 0, 0, 0)
	BackingEmblem:setupNineSliceShader(196, 88)
	self:addElement(BackingEmblem)
	self.BackingEmblem = BackingEmblem
	local BackingEmblemTint = LUI.UIImage.new(0, 0, 3, 82, 0, 0, 3, 82)
	BackingEmblemTint:setRGB(0.04, 0.04, 0.04)
	BackingEmblemTint:setAlpha(0.5)
	self:addElement(BackingEmblemTint)
	self.BackingEmblemTint = BackingEmblemTint
	local CallingCardsFrameWidget = CoD.CallingCards_FrameWidget.new(f1_arg0, f1_arg1, 0, 0, 86, 397, 0, 0, 3, 82)
	CallingCardsFrameWidget:setRGB(0.9, 0.9, 0.9)
	CallingCardsFrameWidget:linkToElementModel(self, nil, false, function(model)
		CallingCardsFrameWidget:setModel(model, f1_arg1)
	end)
	self:addElement(CallingCardsFrameWidget)
	self.CallingCardsFrameWidget = CallingCardsFrameWidget
	local PixelGrid = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	PixelGrid:setAlpha(0.05)
	PixelGrid:setImage(RegisterImage(@"uie_ui_hud_notifications_pixelpattern"))
	PixelGrid:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	PixelGrid:setShaderVector(0, 0, 0, 0, 0)
	PixelGrid:setupNineSliceShader(128, 128)
	self:addElement(PixelGrid)
	self.PixelGrid = PixelGrid
	local rankicon = LUI.UIImage.new(0, 0, 3, 82, 0.5, 0.5, -39.5, 39.5)
	rankicon:setAlpha(0)
	rankicon:linkToElementModel(self, "rankIcon", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			rankicon:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(rankicon)
	self.rankicon = rankicon
	local emblem = LUI.UIImage.new(0, 0, 3, 82, 0.5, 0.5, -39.5, 39.5)
	emblem:linkToElementModel(self, "xuid", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			emblem:setupPlayerEmblemByXUID(f4_local0)
		end
	end)
	self:addElement(emblem)
	self.emblem = emblem
	local LeaderBacking = CoD.DirectorLobbyLeader.new(f1_arg0, f1_arg1, 0, 0, 4, 18, 0.5, 1.41, -38.5, -38.5)
	LeaderBacking:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	LeaderBacking:linkToElementModel(self, nil, false, function(model)
		LeaderBacking:setModel(model, f1_arg1)
	end)
	self:addElement(LeaderBacking)
	self.LeaderBacking = LeaderBacking
	local VoipWaves = CoD.OnOffVoip.new(f1_arg0, f1_arg1, 0, 0, -55, 30, 0, 0, 34.5, 50.5)
	VoipWaves:setZRot(90)
	VoipWaves:linkToElementModel(self, "info", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			VoipWaves:setModel(f6_local0, f1_arg1)
		end
	end)
	self:addElement(VoipWaves)
	self.VoipWaves = VoipWaves
	local EmptyText = LUI.UIText.new(0, 0.5, 86, 86, 0.5, 0.5, -11, 11)
	EmptyText:setRGB(0.33, 0.3, 0.25)
	EmptyText:setAlpha(0)
	EmptyText:setText(Engine[@"hash_4F9F1239CFD921FE"](0x6ADB318F8178FC))
	EmptyText:setTTF("ttmussels_regular")
	EmptyText:setLetterSpacing(10)
	EmptyText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	EmptyText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(EmptyText)
	self.EmptyText = EmptyText
	local ButtonAddPlus = nil
	ButtonAddPlus = LUI.UIImage.new(1, 1, -64, -20, 0.5, 0.5, -22, 22)
	ButtonAddPlus:setAlpha(0)
	ButtonAddPlus:setImage(RegisterImage(@"uie_ui_menu_cac_button_add_plus"))
	self:addElement(ButtonAddPlus)
	self.ButtonAddPlus = ButtonAddPlus
	local ButtonAddPlusHighlighted = nil
	ButtonAddPlusHighlighted = LUI.UIImage.new(1, 1, -64, -20, 0.5, 0.5, -22, 22)
	ButtonAddPlusHighlighted:setAlpha(0)
	ButtonAddPlusHighlighted:setImage(RegisterImage(@"uie_ui_menu_cac_button_add_plus_highlighted"))
	ButtonAddPlusHighlighted:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(ButtonAddPlusHighlighted)
	self.ButtonAddPlusHighlighted = ButtonAddPlusHighlighted
	local membername = CoD.DirectorLobbyClanAndMemberName.new(f1_arg0, f1_arg1, 0, 0.55, 86, 86, 0.5, 0.5, -8, 8)
	membername:setAlpha(0)
	membername:linkToElementModel(self, "info", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			membername:setModel(f7_local0, f1_arg1)
		end
	end)
	self:addElement(membername)
	self.membername = membername
	local MemberName = CoD.DirectorLobbyMemberName.new(f1_arg0, f1_arg1, 0, 0, 94, 390, 0, 0, 11.5, 32.5)
	MemberName.__Color = function()
		MemberName:setRGB(CoD.DirectorUtility.LobbyPlayerColorByXUIDElseDefaultSelfModel(self:getModel(), "xuid", 1, 1, 1))
	end
	MemberName.__Color()
	MemberName:linkToElementModel(self, "info", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			MemberName:setModel(f9_local0, f1_arg1)
		end
	end)
	self:addElement(MemberName)
	self.MemberName = MemberName
	local SelectionOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SelectionOverlay:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	SelectionOverlay:setAlpha(0)
	self:addElement(SelectionOverlay)
	self.SelectionOverlay = SelectionOverlay
	local FrontendFrameSelected = LUI.UIImage.new(0, 1, -4, 4, 0, 1, -4, 4)
	FrontendFrameSelected:setAlpha(0)
	FrontendFrameSelected:setImage(RegisterImage(@"uie_ui_menu_store_focus_frame"))
	FrontendFrameSelected:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFrameSelected:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrameSelected:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrameSelected)
	self.FrontendFrameSelected = FrontendFrameSelected
	local FrontendFrameSelectedGlow = LUI.UIImage.new(0.01, 0.99, -8, 8, 0.05, 0.95, -8, 8)
	FrontendFrameSelectedGlow:setAlpha(0)
	FrontendFrameSelectedGlow:setImage(RegisterImage(@"uie_ui_menu_store_focus_frame"))
	FrontendFrameSelectedGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFrameSelectedGlow:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrameSelectedGlow:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrameSelectedGlow)
	self.FrontendFrameSelectedGlow = FrontendFrameSelectedGlow
	MemberName:linkToElementModel(self, "xuid", true, MemberName.__Color)
	self:mergeStateConditions({
		{
			stateName = "SelectedClient",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualToSelfModelValue(element, "lobbyRoot.selectedXuid", "xuid")
			end,
		},
	})
	local f1_local20 = self
	local f1_local21 = self.subscribeToModel
	local f1_local22 = Engine[@"getglobalmodel"]()
	f1_local21(f1_local20, f1_local22["lobbyRoot.selectedXuid"], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "lobbyRoot.selectedXuid",
		})
	end, false)
	self:linkToElementModel(self, "xuid", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "xuid",
		})
	end)
	CallingCardsFrameWidget.id = "CallingCardsFrameWidget"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorCODCasterMemberInfo.__resetProperties = function(f13_arg0)
	f13_arg0.SelectionOverlay:completeAnimation()
	f13_arg0.FrontendFrameSelected:completeAnimation()
	f13_arg0.FrontendFrameSelectedGlow:completeAnimation()
	f13_arg0.SelectionOverlay:setAlpha(0)
	f13_arg0.FrontendFrameSelected:setAlpha(0)
	f13_arg0.FrontendFrameSelectedGlow:setAlpha(0)
end
CoD.DirectorCODCasterMemberInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.SelectionOverlay:completeAnimation()
			f15_arg0.SelectionOverlay:setAlpha(0.04)
			f15_arg0.clipFinished(f15_arg0.SelectionOverlay)
		end,
		GainFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			local f16_local0 = function(f17_arg0)
				f16_arg0.SelectionOverlay:beginAnimation(200)
				f16_arg0.SelectionOverlay:setAlpha(0.04)
				f16_arg0.SelectionOverlay:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.SelectionOverlay:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.SelectionOverlay:completeAnimation()
			f16_arg0.SelectionOverlay:setAlpha(0)
			f16_local0(f16_arg0.SelectionOverlay)
		end,
		LoseFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			local f18_local0 = function(f19_arg0)
				f18_arg0.SelectionOverlay:beginAnimation(200)
				f18_arg0.SelectionOverlay:setAlpha(0)
				f18_arg0.SelectionOverlay:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.SelectionOverlay:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.SelectionOverlay:completeAnimation()
			f18_arg0.SelectionOverlay:setAlpha(0.04)
			f18_local0(f18_arg0.SelectionOverlay)
		end,
	},
	SelectedClient = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.FrontendFrameSelected:completeAnimation()
			f20_arg0.FrontendFrameSelected:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.FrontendFrameSelected)
			f20_arg0.FrontendFrameSelectedGlow:completeAnimation()
			f20_arg0.FrontendFrameSelectedGlow:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.FrontendFrameSelectedGlow)
		end,
	},
}
CoD.DirectorCODCasterMemberInfo.__onClose = function(f21_arg0)
	f21_arg0.CallingCardsFrameWidget:close()
	f21_arg0.rankicon:close()
	f21_arg0.emblem:close()
	f21_arg0.LeaderBacking:close()
	f21_arg0.VoipWaves:close()
	f21_arg0.membername:close()
	f21_arg0.MemberName:close()
end
