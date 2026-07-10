require("x64:f78acfcbc465bba")
require("x64:46840c675b6e9ca")
require("x64:828993443a76418")
require("x64:7f9b72b8dc0d9f0")
CoD.InspectionSelectedPlayerInfo = InheritFrom(LUI.UIElement)
CoD.InspectionSelectedPlayerInfo.__defaultWidth = 348
CoD.InspectionSelectedPlayerInfo.__defaultHeight = 448
CoD.InspectionSelectedPlayerInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.InspectionSelectedPlayerInfo)
	self.id = "InspectionSelectedPlayerInfo"
	self.soundSet = "ModeSelection"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local IdentityTiledBg = LUI.UIImage.new(0, 0, 0, 348, 0, 0, 0, 448)
	IdentityTiledBg:setAlpha(0.5)
	IdentityTiledBg:setImage(RegisterImage(0x34839E8065B1E53))
	IdentityTiledBg:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	IdentityTiledBg:setShaderVector(0, 0, 0, 0, 0)
	IdentityTiledBg:setupNineSliceShader(196, 88)
	self:addElement(IdentityTiledBg)
	self.IdentityTiledBg = IdentityTiledBg
	local DividerDotLine = LUI.UIImage.new(0, 0, -1.5, 350.5, 0, 0, 353, 357)
	DividerDotLine:setAlpha(0.2)
	DividerDotLine:setImage(RegisterImage(0xACCC46C0F9F0C21))
	DividerDotLine:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(DividerDotLine)
	self.DividerDotLine = DividerDotLine
	local IdentityText = LUI.UIImage.new(0, 0, 102, 246, 0, 0, 168, 180)
	IdentityText:setAlpha(0.1)
	IdentityText:setImage(RegisterImage(0x30DC6EA083B9801))
	self:addElement(IdentityText)
	self.IdentityText = IdentityText
	local InspectionEmblemWidget = CoD.InspectionEmblemWidget.new(f1_arg0, f1_arg1, 0, 0, 0, 348, 0, 0, 0, 348)
	InspectionEmblemWidget:linkToElementModel(self, nil, false, function(model)
		InspectionEmblemWidget:setModel(model, f1_arg1)
	end)
	self:addElement(InspectionEmblemWidget)
	self.InspectionEmblemWidget = InspectionEmblemWidget
	local playercard = CoD.InspectionGamerCardWidget.new(f1_arg0, f1_arg1, 1, 1, -347.5, 0.5, 0, 0, 361, 448)
	playercard:linkToElementModel(self, nil, false, function(model)
		playercard:setModel(model, f1_arg1)
	end)
	self:addElement(playercard)
	self.playercard = playercard
	local EmblemCornerBlurBL = LUI.UIImage.new(0, 0, -4, 16, 0, 0, 330, 350)
	EmblemCornerBlurBL:setAlpha(0)
	EmblemCornerBlurBL:setZRot(90)
	EmblemCornerBlurBL:setImage(RegisterImage(0xD904D19448C50F7))
	EmblemCornerBlurBL:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	EmblemCornerBlurBL:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(EmblemCornerBlurBL)
	self.EmblemCornerBlurBL = EmblemCornerBlurBL
	local EmblemCornerBL = LUI.UIImage.new(0, 0, -1, 11, 0, 0, 337, 349)
	EmblemCornerBL:setAlpha(0)
	EmblemCornerBL:setZRot(-90)
	EmblemCornerBL:setImage(RegisterImage(0x2764FF85084B3A4))
	EmblemCornerBL:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	EmblemCornerBL:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(EmblemCornerBL)
	self.EmblemCornerBL = EmblemCornerBL
	local EmblemCornerBlurTL = LUI.UIImage.new(0, 0, -1.5, 18.5, 0, 0, -3, 17)
	EmblemCornerBlurTL:setAlpha(0)
	EmblemCornerBlurTL:setImage(RegisterImage(0xD904D19448C50F7))
	EmblemCornerBlurTL:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	EmblemCornerBlurTL:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(EmblemCornerBlurTL)
	self.EmblemCornerBlurTL = EmblemCornerBlurTL
	local EmblemCornerTL = LUI.UIImage.new(0, 0, -1, 11, 0, 0, -1, 11)
	EmblemCornerTL:setAlpha(0)
	EmblemCornerTL:setZRot(180)
	EmblemCornerTL:setImage(RegisterImage(0x2764FF85084B3A4))
	EmblemCornerTL:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	EmblemCornerTL:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(EmblemCornerTL)
	self.EmblemCornerTL = EmblemCornerTL
	local EmblemCornerBlurBR = LUI.UIImage.new(0, 0, 331, 351, 0, 0, 331, 351)
	EmblemCornerBlurBR:setAlpha(0)
	EmblemCornerBlurBR:setZRot(180)
	EmblemCornerBlurBR:setImage(RegisterImage(0xD904D19448C50F7))
	EmblemCornerBlurBR:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	EmblemCornerBlurBR:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(EmblemCornerBlurBR)
	self.EmblemCornerBlurBR = EmblemCornerBlurBR
	local EmblemCornerBR = LUI.UIImage.new(0, 0, 337, 349, 0, 0, 337, 349)
	EmblemCornerBR:setAlpha(0)
	EmblemCornerBR:setImage(RegisterImage(0x2764FF85084B3A4))
	EmblemCornerBR:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	EmblemCornerBR:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(EmblemCornerBR)
	self.EmblemCornerBR = EmblemCornerBR
	local EmblemCornerBlurTR = LUI.UIImage.new(0, 0, 329, 349, 0, 0, -3, 17)
	EmblemCornerBlurTR:setAlpha(0)
	EmblemCornerBlurTR:setYRot(180)
	EmblemCornerBlurTR:setImage(RegisterImage(0xD904D19448C50F7))
	EmblemCornerBlurTR:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	EmblemCornerBlurTR:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(EmblemCornerBlurTR)
	self.EmblemCornerBlurTR = EmblemCornerBlurTR
	local EmblemCornerTR = LUI.UIImage.new(0, 0, 337, 349, 0, 0, -1, 11)
	EmblemCornerTR:setAlpha(0)
	EmblemCornerTR:setZRot(90)
	EmblemCornerTR:setImage(RegisterImage(0x2764FF85084B3A4))
	EmblemCornerTR:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	EmblemCornerTR:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(EmblemCornerTR)
	self.EmblemCornerTR = EmblemCornerTR
	local CommonStripeBar = CoD.CommonStripeBarStencil.new(f1_arg0, f1_arg1, 0, 0, -1, 347, 0, 0, -14, 2)
	self:addElement(CommonStripeBar)
	self.CommonStripeBar = CommonStripeBar
	local Lines = CoD.DirectorSelectButtonLines.new(f1_arg0, f1_arg1, 0, 0, 0, 348, 0, 0, 0, 448)
	Lines:setRGB(ColorSet.T8__SILVER.r, ColorSet.T8__SILVER.g, ColorSet.T8__SILVER.b)
	self:addElement(Lines)
	self.Lines = Lines
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "FnF",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.DisableForCurrentMilestone(f1_arg1)
			end,
		},
		{
			stateName = "RankInfoHidden",
			condition = function(menu, element, event)
				return not CoD.RankUtility.HasElementByXUIDEverPlayedCurrentMode(self)
			end,
		},
		{
			stateName = "Lan",
			condition = function(menu, element, event)
				return not IsLive()
			end,
		},
		{
			stateName = "Arena",
			condition = function(menu, element, event)
				return IsArenaMode()
			end,
		},
		{
			stateName = "Custom",
			condition = function(menu, element, event)
				return IsCustomLobby()
			end,
		},
		{
			stateName = "FreeRun",
			condition = function(menu, element, event)
				return IsFreeRunLobby()
			end,
		},
		{
			stateName = "Theater",
			condition = function(menu, element, event)
				return LobbyModeTheater()
			end,
		},
	})
	self:linkToElementModel(self, "xuid", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "xuid",
		})
	end)
	local f1_local16 = self
	local f1_local17 = self.subscribeToModel
	local f1_local18 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local17(f1_local16, f1_local18.lobbyNav, function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "lobbyNav",
		})
	end, false)
	f1_local16 = self
	f1_local17 = self.subscribeToModel
	f1_local18 = Engine[0x8DF2E5447F384B9]()
	f1_local17(f1_local16, f1_local18["lobbyRoot.lobbyNetworkMode"], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "lobbyRoot.lobbyNetworkMode",
		})
	end, false)
	f1_local16 = self
	f1_local17 = self.subscribeToModel
	f1_local18 = Engine[0x8DF2E5447F384B9]()
	f1_local17(f1_local16, f1_local18["lobbyRoot.lobbyNav"], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	playercard.id = "playercard"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local17 = self
	f1_local17 = playercard
	if IsPC() then
		CoD.PCWidgetUtility.SetupRightClickableContextualPlayerMenu(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.InspectionSelectedPlayerInfo.__resetProperties = function(f16_arg0)
	f16_arg0.playercard:completeAnimation()
	f16_arg0.InspectionEmblemWidget:completeAnimation()
	f16_arg0.playercard:setAlpha(1)
	f16_arg0.InspectionEmblemWidget:setAlpha(1)
end
CoD.InspectionSelectedPlayerInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(0)
		end,
		Intro = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			local f18_local0 = function(f19_arg0)
				f18_arg0.InspectionEmblemWidget:beginAnimation(300, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735])
				f18_arg0.InspectionEmblemWidget:setAlpha(1)
				f18_arg0.InspectionEmblemWidget:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.InspectionEmblemWidget:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.InspectionEmblemWidget:completeAnimation()
			f18_arg0.InspectionEmblemWidget:setAlpha(0)
			f18_local0(f18_arg0.InspectionEmblemWidget)
			local f18_local1 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					f21_arg0:beginAnimation(310, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735])
					f21_arg0:setAlpha(1)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
				end
				f18_arg0.playercard:beginAnimation(90)
				f18_arg0.playercard:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.playercard:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f18_arg0.playercard:completeAnimation()
			f18_arg0.playercard:setAlpha(0)
			f18_local1(f18_arg0.playercard)
		end,
		Outro = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			local f22_local0 = function(f23_arg0)
				f22_arg0.InspectionEmblemWidget:beginAnimation(300, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735])
				f22_arg0.InspectionEmblemWidget:setAlpha(0)
				f22_arg0.InspectionEmblemWidget:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.InspectionEmblemWidget:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.InspectionEmblemWidget:completeAnimation()
			f22_arg0.InspectionEmblemWidget:setAlpha(1)
			f22_local0(f22_arg0.InspectionEmblemWidget)
			local f22_local1 = function(f24_arg0)
				local f24_local0 = function(f25_arg0)
					f25_arg0:beginAnimation(309, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735])
					f25_arg0:setAlpha(0)
					f25_arg0:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
				end
				f22_arg0.playercard:beginAnimation(280)
				f22_arg0.playercard:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.playercard:registerEventHandler("transition_complete_keyframe", f24_local0)
			end
			f22_arg0.playercard:completeAnimation()
			f22_arg0.playercard:setAlpha(1)
			f22_local1(f22_arg0.playercard)
		end,
	},
	Hidden = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(2)
			f26_arg0.InspectionEmblemWidget:completeAnimation()
			f26_arg0.InspectionEmblemWidget:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.InspectionEmblemWidget)
			f26_arg0.playercard:completeAnimation()
			f26_arg0.playercard:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.playercard)
		end,
	},
	FnF = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(0)
		end,
	},
	RankInfoHidden = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(0)
		end,
	},
	Lan = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(0)
		end,
	},
	Arena = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(0)
		end,
		Intro = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(2)
			local f31_local0 = function(f32_arg0)
				f31_arg0.InspectionEmblemWidget:beginAnimation(300)
				f31_arg0.InspectionEmblemWidget:setAlpha(1)
				f31_arg0.InspectionEmblemWidget:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.InspectionEmblemWidget:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.InspectionEmblemWidget:completeAnimation()
			f31_arg0.InspectionEmblemWidget:setAlpha(0)
			f31_local0(f31_arg0.InspectionEmblemWidget)
			local f31_local1 = function(f33_arg0)
				local f33_local0 = function(f34_arg0)
					f34_arg0:beginAnimation(310)
					f34_arg0:setAlpha(1)
					f34_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
				end
				f31_arg0.playercard:beginAnimation(90)
				f31_arg0.playercard:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.playercard:registerEventHandler("transition_complete_keyframe", f33_local0)
			end
			f31_arg0.playercard:completeAnimation()
			f31_arg0.playercard:setAlpha(0)
			f31_local1(f31_arg0.playercard)
		end,
	},
	Custom = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(0)
		end,
	},
	FreeRun = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(0)
		end,
	},
	Theater = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.InspectionSelectedPlayerInfo.__onClose = function(f38_arg0)
	f38_arg0.InspectionEmblemWidget:close()
	f38_arg0.playercard:close()
	f38_arg0.CommonStripeBar:close()
	f38_arg0.Lines:close()
end
