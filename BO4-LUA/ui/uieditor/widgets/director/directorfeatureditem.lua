require("x64:6cc64e6f5d65b77")
require("x64:dd720638a9c4700")
require("x64:39872a6aa619bf9")
CoD.DirectorFeaturedItem = InheritFrom(LUI.UIElement)
CoD.DirectorFeaturedItem.__defaultWidth = 541
CoD.DirectorFeaturedItem.__defaultHeight = 142
CoD.DirectorFeaturedItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorFeaturedItem)
	self.id = "DirectorFeaturedItem"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GamemodeBackground = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	GamemodeBackground:setImage(RegisterImage(0x42C6A5D3E653E02))
	GamemodeBackground:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	GamemodeBackground:setShaderVector(0, 0.35, 0.19, 0, 0)
	GamemodeBackground:setShaderVector(1, 1, 1, 0, 0)
	GamemodeBackground:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(GamemodeBackground)
	self.GamemodeBackground = GamemodeBackground
	local NotFocused = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NotFocused:setRGB(0, 0, 0)
	NotFocused:setAlpha(0.2)
	self:addElement(NotFocused)
	self.NotFocused = NotFocused
	local Header = LUI.UIText.new(0, 0, 13, 482, 0, 0, 7, 29)
	Header:setRGB(0.14, 0.14, 0.14)
	Header:setTTF("ttmussels_demibold")
	Header:setLetterSpacing(6)
	Header:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Header:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Header:setBackingType(2)
	Header:setBackingAlpha(0.7)
	Header:setBackingXPadding(10)
	Header:setBackingYPadding(3)
	Header:setBackingImage(RegisterImage(0xC229CEBABEEAB0E))
	Header:linkToElementModel(self, "name", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Header:setText(ToUpper(CoD.BaseUtility.LocalizeIfXHash(f2_local0)))
		end
	end)
	self:addElement(Header)
	self.Header = Header
	local DirectorFeatureInteractPrompt = CoD.DirectorFeatureInteractPrompt.new(f1_arg0, f1_arg1, 0, 0, 0, 550, 0, 0, 80.5, 120.5)
	DirectorFeatureInteractPrompt:linkToElementModel(self, nil, false, function(model)
		DirectorFeatureInteractPrompt:setModel(model, f1_arg1)
	end)
	self:addElement(DirectorFeatureInteractPrompt)
	self.DirectorFeatureInteractPrompt = DirectorFeatureInteractPrompt
	local PartyLeaderOnlyPrompt = CoD.DirectorPartyLeaderOnlyPrompt.new(f1_arg0, f1_arg1, 0.5, 0.5, -225, 225, 0, 0, -2, 22)
	PartyLeaderOnlyPrompt:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.ShowForAllClients(self, f1_arg1)
			end,
		},
	})
	local FrontendFrameSelected = PartyLeaderOnlyPrompt
	local DoubleXPCardIconsRightAligned = PartyLeaderOnlyPrompt.subscribeToModel
	local f1_local8 = Engine[0x8DF2E5447F384B9]()
	DoubleXPCardIconsRightAligned(FrontendFrameSelected, f1_local8["lobbyRoot.lobbyNav"], function(f5_arg0)
		f1_arg0:updateElementState(PartyLeaderOnlyPrompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	FrontendFrameSelected = PartyLeaderOnlyPrompt
	DoubleXPCardIconsRightAligned = PartyLeaderOnlyPrompt.subscribeToModel
	f1_local8 = Engine[0x8DF2E5447F384B9]()
	DoubleXPCardIconsRightAligned(FrontendFrameSelected, f1_local8["lobbyRoot.gameClient.update"], function(f6_arg0)
		f1_arg0:updateElementState(PartyLeaderOnlyPrompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lobbyRoot.gameClient.update",
		})
	end, false)
	FrontendFrameSelected = PartyLeaderOnlyPrompt
	DoubleXPCardIconsRightAligned = PartyLeaderOnlyPrompt.subscribeToModel
	f1_local8 = Engine[0x8DF2E5447F384B9]()
	DoubleXPCardIconsRightAligned(FrontendFrameSelected, f1_local8["lobbyRoot.privateClient.update"], function(f7_arg0)
		f1_arg0:updateElementState(PartyLeaderOnlyPrompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	PartyLeaderOnlyPrompt:linkToElementModel(PartyLeaderOnlyPrompt, "showForAllClients", true, function(model)
		f1_arg0:updateElementState(PartyLeaderOnlyPrompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "showForAllClients",
		})
	end)
	PartyLeaderOnlyPrompt:appendEventHandler("on_session_start", function(f9_arg0, f9_arg1)
		f9_arg1.menu = f9_arg1.menu or f1_arg0
		f1_arg0:updateElementState(PartyLeaderOnlyPrompt, f9_arg1)
	end)
	PartyLeaderOnlyPrompt:appendEventHandler("on_session_end", function(f10_arg0, f10_arg1)
		f10_arg1.menu = f10_arg1.menu or f1_arg0
		f1_arg0:updateElementState(PartyLeaderOnlyPrompt, f10_arg1)
	end)
	PartyLeaderOnlyPrompt:linkToElementModel(self, nil, false, function(model)
		PartyLeaderOnlyPrompt:setModel(model, f1_arg1)
	end)
	self:addElement(PartyLeaderOnlyPrompt)
	self.PartyLeaderOnlyPrompt = PartyLeaderOnlyPrompt
	DoubleXPCardIconsRightAligned = CoD.DoubleXPCardIconsRightAligned.new(f1_arg0, f1_arg1, 1, 1, -129, 0, 0, 0, 0, 43)
	DoubleXPCardIconsRightAligned:linkToElementModel(self, nil, false, function(model)
		DoubleXPCardIconsRightAligned:setModel(model, f1_arg1)
	end)
	self:addElement(DoubleXPCardIconsRightAligned)
	self.DoubleXPCardIconsRightAligned = DoubleXPCardIconsRightAligned
	FrontendFrameSelected = nil
	FrontendFrameSelected = LUI.UIImage.new(0, 1, -4, 4, 0, 1, -4, 4)
	FrontendFrameSelected:setRGB(0.96, 0.94, 0.78)
	FrontendFrameSelected:setAlpha(0)
	FrontendFrameSelected:setImage(RegisterImage(0xCB07CCC28498CB2))
	FrontendFrameSelected:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrontendFrameSelected:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrameSelected:setupNineSliceShader(10, 10)
	self:addElement(FrontendFrameSelected)
	self.FrontendFrameSelected = FrontendFrameSelected
	self:mergeStateConditions({
		{
			stateName = "Small",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "small")
			end,
		},
	})
	self:linkToElementModel(self, "small", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "small",
		})
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "LastInput", function(model)
		local f15_local0 = self
		if IsPC() and IsMouseOrKeyboard(f1_arg1) then
			HideWidget(self.DirectorFeatureInteractPrompt)
		elseif IsPC() and IsGamepad(f1_arg1) then
			ShowWidget(self.DirectorFeatureInteractPrompt)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorFeaturedItem.__resetProperties = function(f16_arg0)
	f16_arg0.Header:completeAnimation()
	f16_arg0.PartyLeaderOnlyPrompt:completeAnimation()
	f16_arg0.NotFocused:completeAnimation()
	f16_arg0.FrontendFrameSelected:completeAnimation()
	f16_arg0.Header:setRGB(0.14, 0.14, 0.14)
	f16_arg0.Header:setAlpha(1)
	f16_arg0.PartyLeaderOnlyPrompt:setAlpha(1)
	f16_arg0.NotFocused:setAlpha(0.2)
	f16_arg0.FrontendFrameSelected:setLeftRight(0, 1, -4, 4)
	f16_arg0.FrontendFrameSelected:setTopBottom(0, 1, -4, 4)
	f16_arg0.FrontendFrameSelected:setAlpha(0)
end
CoD.DirectorFeaturedItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			f17_arg0.NotFocused:completeAnimation()
			f17_arg0.NotFocused:setAlpha(0.5)
			f17_arg0.clipFinished(f17_arg0.NotFocused)
			f17_arg0.Header:completeAnimation()
			f17_arg0.Header:setRGB(0.14, 0.14, 0.14)
			f17_arg0.clipFinished(f17_arg0.Header)
			f17_arg0.PartyLeaderOnlyPrompt:completeAnimation()
			f17_arg0.PartyLeaderOnlyPrompt:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.PartyLeaderOnlyPrompt)
		end,
		Active = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.Header:completeAnimation()
			f18_arg0.Header:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.Header)
		end,
		ActiveAndFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.NotFocused:completeAnimation()
			f19_arg0.NotFocused:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.NotFocused)
		end,
		GainActiveAndFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			local f20_local0 = function(f21_arg0)
				f20_arg0.NotFocused:beginAnimation(200)
				f20_arg0.NotFocused:setAlpha(0)
				f20_arg0.NotFocused:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.NotFocused:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.NotFocused:completeAnimation()
			f20_arg0.NotFocused:setAlpha(0.5)
			f20_local0(f20_arg0.NotFocused)
			f20_arg0.Header:completeAnimation()
			f20_arg0.Header:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.Header)
		end,
		Focus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.NotFocused:completeAnimation()
			f22_arg0.NotFocused:setAlpha(0.2)
			f22_arg0.clipFinished(f22_arg0.NotFocused)
			f22_arg0.FrontendFrameSelected:completeAnimation()
			f22_arg0.FrontendFrameSelected:setLeftRight(-0, 1, -4, 4)
			f22_arg0.FrontendFrameSelected:setTopBottom(-0, 1, -4, 4)
			f22_arg0.FrontendFrameSelected:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.FrontendFrameSelected)
		end,
	},
	Small = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			f23_arg0.Header:completeAnimation()
			f23_arg0.Header:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.Header)
		end,
	},
}
if not CoD.isPC then
	CoD.DirectorFeaturedItem.__clipsPerState.DefaultState.Focus = nil
end
CoD.DirectorFeaturedItem.__onClose = function(f24_arg0)
	f24_arg0.Header:close()
	f24_arg0.DirectorFeatureInteractPrompt:close()
	f24_arg0.PartyLeaderOnlyPrompt:close()
	f24_arg0.DoubleXPCardIconsRightAligned:close()
end
