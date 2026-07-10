require("x64:228a7baa572b047")
require("x64:acbf06924421e35")
require("x64:891695c75906b3c")
require("x64:88882bece551bf0")
require("x64:e12ddba2d13fc72")
CoD.DirectorTeamMemberInfo = InheritFrom(LUI.UIElement)
CoD.DirectorTeamMemberInfo.__defaultWidth = 400
CoD.DirectorTeamMemberInfo.__defaultHeight = 85
CoD.DirectorTeamMemberInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorTeamMemberInfo)
	self.id = "DirectorTeamMemberInfo"
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
	local PixelGrid = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	PixelGrid:setAlpha(0.05)
	PixelGrid:setImage(RegisterImage(@"uie_ui_hud_notifications_pixelpattern"))
	PixelGrid:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	PixelGrid:setShaderVector(0, 0, 0, 0, 0)
	PixelGrid:setupNineSliceShader(128, 128)
	self:addElement(PixelGrid)
	self.PixelGrid = PixelGrid
	local CallingCardsFrameWidget = CoD.CallingCards_FrameWidget.new(f1_arg0, f1_arg1, 0, 0, 86, 397, 0, 0, 3, 82)
	CallingCardsFrameWidget:setRGB(0.9, 0.9, 0.9)
	CallingCardsFrameWidget:linkToElementModel(self, "info", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CallingCardsFrameWidget:setModel(f2_local0, f1_arg1)
		end
	end)
	self:addElement(CallingCardsFrameWidget)
	self.CallingCardsFrameWidget = CallingCardsFrameWidget
	local Image = LUI.UIImage.new(0, 0, 3, 82, 0, 0, 3, 82)
	Image:setRGB(0, 0, 0)
	Image:setAlpha(0)
	self:addElement(Image)
	self.Image = Image
	local emblem = LUI.UIImage.new(0, 0, 3, 82, 0, 0, 3, 82)
	emblem:setRGB(0.9, 0.9, 0.9)
	emblem.__XUID = function(f3_arg0)
		local f3_local0 = f3_arg0:get()
		if f3_local0 ~= nil then
			emblem:setupPlayerEmblemByXUID(f3_local0)
		end
	end
	emblem:linkToElementModel(self, "info", true, function(model, f4_arg1)
		if f4_arg1["__emblem.__XUID_info->xuid"] then
			f4_arg1:removeSubscription(f4_arg1["__emblem.__XUID_info->xuid"])
			f4_arg1["__emblem.__XUID_info->xuid"] = nil
		end
		if model then
			local f4_local0 = model:get()
			local f4_local1 = model:get()
			model = f4_local0 and f4_local1.xuid
		end
		if model then
			f4_arg1["__emblem.__XUID_info->xuid"] = f4_arg1:subscribeToModel(model, emblem.__XUID)
		end
	end)
	self:addElement(emblem)
	self.emblem = emblem
	local clantag = LUI.UIText.new(0, 0, 94, 390, 0, 0, 39, 55)
	clantag:setTTF("ttmussels_regular")
	clantag:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	clantag:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	clantag:setBackingType(2)
	clantag:setBackingColor(0.22, 0.22, 0.22)
	clantag:setBackingAlpha(0.5)
	clantag.__String_Reference = function(f5_arg0)
		local f5_local0 = f5_arg0:get()
		if f5_local0 ~= nil then
			clantag:setText(StringAsClanTag(f5_local0))
		end
	end
	clantag:linkToElementModel(self, "info", true, function(model, f6_arg1)
		if f6_arg1["__clantag.__String_Reference_info->clanTag"] then
			f6_arg1:removeSubscription(f6_arg1["__clantag.__String_Reference_info->clanTag"])
			f6_arg1["__clantag.__String_Reference_info->clanTag"] = nil
		end
		if model then
			local f6_local0 = model:get()
			local f6_local1 = model:get()
			model = f6_local0 and f6_local1.clanTag
		end
		if model then
			f6_arg1["__clantag.__String_Reference_info->clanTag"] = f6_arg1:subscribeToModel(model, clantag.__String_Reference)
		end
	end)
	self:addElement(clantag)
	self.clantag = clantag
	local LeaderBacking = CoD.DirectorLobbyLeader.new(f1_arg0, f1_arg1, 0, 0, 4, 18, 0.5, 1.41, -38.5, -38.5)
	LeaderBacking:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	LeaderBacking:linkToElementModel(self, "info", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			LeaderBacking:setModel(f7_local0, f1_arg1)
		end
	end)
	self:addElement(LeaderBacking)
	self.LeaderBacking = LeaderBacking
	local VoipWaves = CoD.OnOffVoip.new(f1_arg0, f1_arg1, 0, 0, -62, 18, 0.5, 0.5, -17.5, 17.5)
	VoipWaves:setZRot(90)
	VoipWaves:linkToElementModel(self, "info", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			VoipWaves:setModel(f8_local0, f1_arg1)
		end
	end)
	self:addElement(VoipWaves)
	self.VoipWaves = VoipWaves
	local CommonCornerPips = CoD.CommonCornerPips01.new(f1_arg0, f1_arg1, 0, 0, 3, 82, 0, 0, 3, 82)
	CommonCornerPips:setAlpha(0.5)
	self:addElement(CommonCornerPips)
	self.CommonCornerPips = CommonCornerPips
	local MemberName = CoD.DirectorLobbyMemberName.new(f1_arg0, f1_arg1, 0, 0, 94, 390, 0, 0, 11.5, 32.5)
	MemberName.__Color = function()
		MemberName:setRGB(CoD.DirectorUtility.LobbyPlayerColorByXUIDElseDefaultSelfModel(self:getModel(), "xuid", 1, 1, 1))
	end
	MemberName.__Color()
	MemberName:linkToElementModel(self, "info", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			MemberName:setModel(f10_local0, f1_arg1)
		end
	end)
	self:addElement(MemberName)
	self.MemberName = MemberName
	local SelectionOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SelectionOverlay:setAlpha(0)
	SelectionOverlay:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
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
		{
			stateName = "CannotFocus",
			condition = function(menu, element, event)
				return not CoD.DirectorUtility.ShouldClientBeActionable(f1_arg1, self)
			end,
		},
	})
	local f1_local18 = self
	local f1_local19 = self.subscribeToModel
	local f1_local20 = Engine[@"getglobalmodel"]()
	f1_local19(f1_local18, f1_local20["lobbyRoot.selectedXuid"], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
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
	self:linkToElementModel(self, "team", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "team",
		})
	end)
	f1_local18 = self
	f1_local19 = self.subscribeToModel
	f1_local20 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local19(f1_local18, f1_local20.selectedXuid, function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "selectedXuid",
		})
	end, false)
	f1_local18 = self
	f1_local19 = self.subscribeToModel
	f1_local20 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local19(f1_local18, f1_local20.selectedXuidTeam, function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "selectedXuidTeam",
		})
	end, false)
	CallingCardsFrameWidget.id = "CallingCardsFrameWidget"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local19 = self
	if IsPC() then
		CoD.PCWidgetUtility.SetupRightClickableContextualPlayerMenu(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorTeamMemberInfo.__resetProperties = function(f18_arg0)
	f18_arg0.emblem:completeAnimation()
	f18_arg0.SelectionOverlay:completeAnimation()
	f18_arg0.FrontendFrameSelected:completeAnimation()
	f18_arg0.FrontendFrameSelectedGlow:completeAnimation()
	f18_arg0.emblem:setRGB(0.9, 0.9, 0.9)
	f18_arg0.SelectionOverlay:setAlpha(0)
	f18_arg0.FrontendFrameSelected:setAlpha(0)
	f18_arg0.FrontendFrameSelectedGlow:setAlpha(0)
end
CoD.DirectorTeamMemberInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.emblem:completeAnimation()
			f20_arg0.emblem:setRGB(1, 1, 1)
			f20_arg0.clipFinished(f20_arg0.emblem)
			f20_arg0.SelectionOverlay:completeAnimation()
			f20_arg0.SelectionOverlay:setAlpha(0.04)
			f20_arg0.clipFinished(f20_arg0.SelectionOverlay)
		end,
		GainFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			local f21_local0 = function(f22_arg0)
				f21_arg0.emblem:beginAnimation(200)
				f21_arg0.emblem:setRGB(1, 1, 1)
				f21_arg0.emblem:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.emblem:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.emblem:completeAnimation()
			f21_arg0.emblem:setRGB(0.9, 0.9, 0.9)
			f21_local0(f21_arg0.emblem)
			local f21_local1 = function(f23_arg0)
				f21_arg0.SelectionOverlay:beginAnimation(200)
				f21_arg0.SelectionOverlay:setAlpha(0.04)
				f21_arg0.SelectionOverlay:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.SelectionOverlay:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.SelectionOverlay:completeAnimation()
			f21_arg0.SelectionOverlay:setAlpha(0)
			f21_local1(f21_arg0.SelectionOverlay)
		end,
		LoseFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			local f24_local0 = function(f25_arg0)
				f24_arg0.emblem:beginAnimation(200)
				f24_arg0.emblem:setRGB(0.9, 0.9, 0.9)
				f24_arg0.emblem:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.emblem:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.emblem:completeAnimation()
			f24_arg0.emblem:setRGB(1, 1, 1)
			f24_local0(f24_arg0.emblem)
			local f24_local1 = function(f26_arg0)
				f24_arg0.SelectionOverlay:beginAnimation(200)
				f24_arg0.SelectionOverlay:setAlpha(0)
				f24_arg0.SelectionOverlay:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.SelectionOverlay:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.SelectionOverlay:completeAnimation()
			f24_arg0.SelectionOverlay:setAlpha(0.04)
			f24_local1(f24_arg0.SelectionOverlay)
		end,
	},
	SelectedClient = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(4)
			f27_arg0.emblem:completeAnimation()
			f27_arg0.emblem:setRGB(1, 1, 1)
			f27_arg0.clipFinished(f27_arg0.emblem)
			f27_arg0.SelectionOverlay:completeAnimation()
			f27_arg0.SelectionOverlay:setAlpha(0.04)
			f27_arg0.clipFinished(f27_arg0.SelectionOverlay)
			f27_arg0.FrontendFrameSelected:completeAnimation()
			f27_arg0.FrontendFrameSelected:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.FrontendFrameSelected)
			f27_arg0.FrontendFrameSelectedGlow:completeAnimation()
			f27_arg0.FrontendFrameSelectedGlow:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.FrontendFrameSelectedGlow)
		end,
	},
	CannotFocus = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.DirectorTeamMemberInfo.__onClose = function(f29_arg0)
	f29_arg0.CallingCardsFrameWidget:close()
	f29_arg0.emblem:close()
	f29_arg0.clantag:close()
	f29_arg0.LeaderBacking:close()
	f29_arg0.VoipWaves:close()
	f29_arg0.CommonCornerPips:close()
	f29_arg0.MemberName:close()
end
