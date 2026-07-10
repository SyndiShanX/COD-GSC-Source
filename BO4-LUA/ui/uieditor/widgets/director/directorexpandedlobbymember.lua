require("x64:acbf06924421e35")
require("x64:235c8e60fecf1a")
require("x64:61730f9c061ba21")
require("x64:50279cd666ce7ee")
require("x64:f315f285d876794")
CoD.DirectorExpandedLobbyMember = InheritFrom(LUI.UIElement)
CoD.DirectorExpandedLobbyMember.__defaultWidth = 425
CoD.DirectorExpandedLobbyMember.__defaultHeight = 70
CoD.DirectorExpandedLobbyMember.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorExpandedLobbyMember)
	self.id = "DirectorExpandedLobbyMember"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorPartyBar = CoD.DirectorPartyBar.new(f1_arg0, f1_arg1, 0, 0, 429.5, 434.5, 0, 0, 3, 67)
	DirectorPartyBar:linkToElementModel(self, "info", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			DirectorPartyBar:setModel(f2_local0, f1_arg1)
		end
	end)
	self:addElement(DirectorPartyBar)
	self.DirectorPartyBar = DirectorPartyBar
	local DirectorExpandedLobbyMemberInternal = CoD.DirectorExpandedLobbyMemberInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 425, 0, 0, 2, 67)
	DirectorExpandedLobbyMemberInternal:linkToElementModel(self, "info", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			DirectorExpandedLobbyMemberInternal:setModel(f3_local0, f1_arg1)
		end
	end)
	self:addElement(DirectorExpandedLobbyMemberInternal)
	self.DirectorExpandedLobbyMemberInternal = DirectorExpandedLobbyMemberInternal
	local DirectorCustomStartButton = CoD.DirectorButtonAdd.new(f1_arg0, f1_arg1, 0, 0, 2, 427, 0, 0, 0, 69)
	DirectorCustomStartButton:setAlpha(0)
	self:addElement(DirectorCustomStartButton)
	self.DirectorCustomStartButton = DirectorCustomStartButton
	local SearchingBacking = LUI.UIImage.new(0, 0, 2, 427, 0, 0, 0, 69)
	SearchingBacking:setAlpha(0)
	SearchingBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	SearchingBacking:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SearchingBacking)
	self.SearchingBacking = SearchingBacking
	local NoiseTiledBacking = LUI.UIImage.new(0, 0, 2, 427, 0.09, 0.09, -6, 63)
	NoiseTiledBacking:setAlpha(0)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local CommonCornerPips = CoD.CommonCornerPips01.new(f1_arg0, f1_arg1, 0, 0, 4, 425, 0, 0, 2, 67)
	CommonCornerPips:setAlpha(0)
	self:addElement(CommonCornerPips)
	self.CommonCornerPips = CommonCornerPips
	local SearchingLeft = LUI.UIText.new(0, 0, 2.5, 182.5, 0.5, 0.5, -10, 10)
	SearchingLeft:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	SearchingLeft:setAlpha(0)
	SearchingLeft:setText(LocalizeToUpperString(0xE91C8C702197ED8))
	SearchingLeft:setTTF("ttmussels_regular")
	SearchingLeft:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	SearchingLeft:setShaderVector(0, 0.2, 0, 0, 0)
	SearchingLeft:setShaderVector(1, 0, 0, 0, 0)
	SearchingLeft:setShaderVector(2, 0, 0, 0, 1)
	SearchingLeft:setLetterSpacing(2)
	SearchingLeft:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	SearchingLeft:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(SearchingLeft)
	self.SearchingLeft = SearchingLeft
	local SearchingRight = LUI.UIText.new(0, 0, 243.5, 425.5, 0.5, 0.5, -10, 10)
	SearchingRight:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	SearchingRight:setAlpha(0)
	SearchingRight:setText(LocalizeToUpperString(0x20B566D0856BB8D))
	SearchingRight:setTTF("ttmussels_regular")
	SearchingRight:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	SearchingRight:setShaderVector(0, 0.2, 0, 0, 0)
	SearchingRight:setShaderVector(1, 0, 0, 0, 0)
	SearchingRight:setShaderVector(2, 0, 0, 0, 1)
	SearchingRight:setLetterSpacing(2)
	SearchingRight:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	SearchingRight:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(SearchingRight)
	self.SearchingRight = SearchingRight
	local Spinner = LUI.UIImage.new(0, 0, 195.5, 229.5, 0, 0, 18, 52)
	Spinner:setAlpha(0)
	Spinner:setImage(RegisterImage(0xC96F6285B1D996C))
	Spinner:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	Spinner:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(Spinner)
	self.Spinner = Spinner
	local PlayerFound = LUI.UIText.new(0.5, 0.5, -90, 90, 0.5, 0.5, -10, 10)
	PlayerFound:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	PlayerFound:setAlpha(0)
	PlayerFound:setText(LocalizeToUpperString(0xEB699BFD0440905))
	PlayerFound:setTTF("ttmussels_regular")
	PlayerFound:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	PlayerFound:setShaderVector(0, 0.2, 0, 0, 0)
	PlayerFound:setShaderVector(1, 0, 0, 0, 0)
	PlayerFound:setShaderVector(2, 0, 0, 0, 1)
	PlayerFound:setLetterSpacing(2)
	PlayerFound:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	PlayerFound:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(PlayerFound)
	self.PlayerFound = PlayerFound
	self:mergeStateConditions({
		{
			stateName = "FirstEmpty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, f1_arg1, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY) and AlwaysFalse()
			end,
		},
		{
			stateName = "EmptySearching",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, f1_arg1, "info->xuid", Engine[0x9073FBE2D48C156]("0"))
			end,
		},
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, f1_arg1, "info->xuid", Engine[0x9073FBE2D48C156]("0"))
			end,
		},
		{
			stateName = "PlayerFound",
			condition = function(menu, element, event)
				local f7_local0
				if not CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, f1_arg1, "info->isPartyMember", true) and not CoD.ArenaUtility.ArenaMatchSet(self) then
					f7_local0 = IsArenaMode()
				else
					f7_local0 = false
				end
				return f7_local0
			end,
		},
	})
	self:linkToElementModel(self, "clientListFlags", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientListFlags",
		})
	end)
	self:linkToElementModel(self, "info", true, function(model)
		if self["__stateValidation_info->xuid"] then
			self:removeSubscription(self["__stateValidation_info->xuid"])
			self["__stateValidation_info->xuid"] = nil
		end
		if model then
			local f9_local0 = model:get()
			local f9_local1 = model:get()
			model = f9_local0 and f9_local1.xuid
		end
		if model then
			self["__stateValidation_info->xuid"] = self:subscribeToModel(model, function(model)
				f1_arg0:updateElementState(self, {
					name = "model_validation",
					menu = f1_arg0,
					controller = f1_arg1,
					modelValue = model:get(),
					modelName = "info->xuid",
				})
			end)
		end
	end)
	self:linkToElementModel(self, "info", true, function(model)
		if self["__stateValidation_info->isPartyMember"] then
			self:removeSubscription(self["__stateValidation_info->isPartyMember"])
			self["__stateValidation_info->isPartyMember"] = nil
		end
		if model then
			local f11_local0 = model:get()
			local f11_local1 = model:get()
			model = f11_local0 and f11_local1.isPartyMember
		end
		if model then
			self["__stateValidation_info->isPartyMember"] = self:subscribeToModel(model, function(model)
				f1_arg0:updateElementState(self, {
					name = "model_validation",
					menu = f1_arg0,
					controller = f1_arg1,
					modelValue = model:get(),
					modelName = "info->isPartyMember",
				})
			end)
		end
	end)
	local f1_local11 = self
	local f1_local12 = self.subscribeToModel
	local f1_local13 = Engine[0x8DF2E5447F384B9]()
	f1_local12(f1_local11, f1_local13["lobbyRoot.publicLobby.stage"], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "lobbyRoot.publicLobby.stage",
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[0x8DF2E5447F384B9]()
	f1_local12(f1_local11, f1_local13["lobbyRoot.lobbyNav"], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f15_arg0, f15_arg1)
		f15_arg1.menu = f15_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f15_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local12(f1_local11, f1_local13.LastInput, function(f16_arg0, f16_arg1)
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end, false)
	self:linkToElementModel(self, "info", true, function(model, f17_arg1)
		if self["__buttonPrompt_info->xuid"] then
			self:removeSubscription(self["__buttonPrompt_info->xuid"])
			self["__buttonPrompt_info->xuid"] = nil
		end
		if model then
			local f17_local0 = model:get()
			local f17_local1 = model:get()
			model = f17_local0 and f17_local1.xuid
		end
		if model then
			self["__buttonPrompt_info->xuid"] = self:subscribeToModel(model, function(model)
				CoD.Menu.UpdateButtonShownState(f17_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
			end)
		end
	end)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
		if IsPC() and IsGamepad(controller) and not CoD.ModelUtility.IsSelfModelPathValueEqualTo(self, controller, "info->xuid", Engine[0x9073FBE2D48C156]("0")) then
			SetSelectedFriendXUID(self, element, controller)
			OpenOverlay(self, "Social_PlayerDetailsPopup", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() and IsGamepad(controller) and not CoD.ModelUtility.IsSelfModelPathValueEqualTo(self, controller, "info->xuid", Engine[0x9073FBE2D48C156]("0")) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0xE0254269ED8FFD3, nil, nil)
			return true
		else
			return false
		end
	end, false)
	DirectorExpandedLobbyMemberInternal.id = "DirectorExpandedLobbyMemberInternal"
	DirectorCustomStartButton.id = "DirectorCustomStartButton"
	self.__defaultFocus = DirectorCustomStartButton
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local12 = self
	if IsPC() then
		CoD.PCWidgetUtility.SetupRightClickableContextualPlayerMenu(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorExpandedLobbyMember.__resetProperties = function(f21_arg0)
	f21_arg0.DirectorCustomStartButton:completeAnimation()
	f21_arg0.DirectorExpandedLobbyMemberInternal:completeAnimation()
	f21_arg0.SearchingLeft:completeAnimation()
	f21_arg0.SearchingRight:completeAnimation()
	f21_arg0.Spinner:completeAnimation()
	f21_arg0.NoiseTiledBacking:completeAnimation()
	f21_arg0.CommonCornerPips:completeAnimation()
	f21_arg0.SearchingBacking:completeAnimation()
	f21_arg0.PlayerFound:completeAnimation()
	f21_arg0.DirectorPartyBar:completeAnimation()
	f21_arg0.DirectorCustomStartButton:setLeftRight(0, 0, 2, 427)
	f21_arg0.DirectorCustomStartButton:setTopBottom(0, 0, 0, 69)
	f21_arg0.DirectorCustomStartButton:setAlpha(0)
	f21_arg0.DirectorCustomStartButton:setScale(1, 1)
	f21_arg0.DirectorExpandedLobbyMemberInternal:setAlpha(1)
	f21_arg0.DirectorExpandedLobbyMemberInternal:setScale(1, 1)
	f21_arg0.SearchingLeft:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	f21_arg0.SearchingLeft:setAlpha(0)
	f21_arg0.SearchingRight:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	f21_arg0.SearchingRight:setAlpha(0)
	f21_arg0.Spinner:setAlpha(0)
	f21_arg0.Spinner:setZRot(0)
	f21_arg0.Spinner:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	f21_arg0.Spinner:setShaderVector(0, 1, 0, 0, 0)
	f21_arg0.NoiseTiledBacking:setAlpha(0)
	f21_arg0.CommonCornerPips:setAlpha(0)
	f21_arg0.SearchingBacking:setAlpha(0)
	f21_arg0.PlayerFound:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	f21_arg0.PlayerFound:setAlpha(0)
	f21_arg0.DirectorPartyBar:setAlpha(1)
end
CoD.DirectorExpandedLobbyMember.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.DirectorCustomStartButton:completeAnimation()
			f22_arg0.DirectorCustomStartButton:setLeftRight(-0.01, -0.01, 6, 431)
			f22_arg0.DirectorCustomStartButton:setTopBottom(0, 0, 0, 69)
			f22_arg0.clipFinished(f22_arg0.DirectorCustomStartButton)
		end,
		ChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			f23_arg0.DirectorExpandedLobbyMemberInternal:completeAnimation()
			f23_arg0.DirectorExpandedLobbyMemberInternal:setScale(1.05, 1.05)
			f23_arg0.clipFinished(f23_arg0.DirectorExpandedLobbyMemberInternal)
		end,
		GainChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			local f24_local0 = function(f25_arg0)
				f24_arg0.DirectorExpandedLobbyMemberInternal:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f24_arg0.DirectorExpandedLobbyMemberInternal:setScale(1.05, 1.05)
				f24_arg0.DirectorExpandedLobbyMemberInternal:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.DirectorExpandedLobbyMemberInternal:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.DirectorExpandedLobbyMemberInternal:completeAnimation()
			f24_arg0.DirectorExpandedLobbyMemberInternal:setScale(1, 1)
			f24_local0(f24_arg0.DirectorExpandedLobbyMemberInternal)
		end,
		LoseChildFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			local f26_local0 = function(f27_arg0)
				f26_arg0.DirectorExpandedLobbyMemberInternal:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f26_arg0.DirectorExpandedLobbyMemberInternal:setScale(1, 1)
				f26_arg0.DirectorExpandedLobbyMemberInternal:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.DirectorExpandedLobbyMemberInternal:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.DirectorExpandedLobbyMemberInternal:completeAnimation()
			f26_arg0.DirectorExpandedLobbyMemberInternal:setScale(1.05, 1.05)
			f26_local0(f26_arg0.DirectorExpandedLobbyMemberInternal)
		end,
	},
	FirstEmpty = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(2)
			f28_arg0.DirectorExpandedLobbyMemberInternal:completeAnimation()
			f28_arg0.DirectorExpandedLobbyMemberInternal:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.DirectorExpandedLobbyMemberInternal)
			f28_arg0.DirectorCustomStartButton:completeAnimation()
			f28_arg0.DirectorCustomStartButton:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.DirectorCustomStartButton)
		end,
		ChildFocus = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(2)
			f29_arg0.DirectorExpandedLobbyMemberInternal:completeAnimation()
			f29_arg0.DirectorExpandedLobbyMemberInternal:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.DirectorExpandedLobbyMemberInternal)
			f29_arg0.DirectorCustomStartButton:completeAnimation()
			f29_arg0.DirectorCustomStartButton:setAlpha(1)
			f29_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f29_arg0.clipFinished(f29_arg0.DirectorCustomStartButton)
		end,
		GainChildFocus = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(2)
			f30_arg0.DirectorExpandedLobbyMemberInternal:completeAnimation()
			f30_arg0.DirectorExpandedLobbyMemberInternal:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.DirectorExpandedLobbyMemberInternal)
			local f30_local0 = function(f31_arg0)
				f30_arg0.DirectorCustomStartButton:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f30_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
				f30_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.DirectorCustomStartButton:completeAnimation()
			f30_arg0.DirectorCustomStartButton:setAlpha(1)
			f30_arg0.DirectorCustomStartButton:setScale(1, 1)
			f30_local0(f30_arg0.DirectorCustomStartButton)
		end,
		LoseChildFocus = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(2)
			f32_arg0.DirectorExpandedLobbyMemberInternal:completeAnimation()
			f32_arg0.DirectorExpandedLobbyMemberInternal:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.DirectorExpandedLobbyMemberInternal)
			local f32_local0 = function(f33_arg0)
				f32_arg0.DirectorCustomStartButton:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f32_arg0.DirectorCustomStartButton:setScale(1, 1)
				f32_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.DirectorCustomStartButton:completeAnimation()
			f32_arg0.DirectorCustomStartButton:setAlpha(1)
			f32_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f32_local0(f32_arg0.DirectorCustomStartButton)
		end,
	},
	EmptySearching = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(7)
			f34_arg0.DirectorExpandedLobbyMemberInternal:completeAnimation()
			f34_arg0.DirectorExpandedLobbyMemberInternal:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.DirectorExpandedLobbyMemberInternal)
			f34_arg0.SearchingBacking:completeAnimation()
			f34_arg0.SearchingBacking:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.SearchingBacking)
			f34_arg0.NoiseTiledBacking:completeAnimation()
			f34_arg0.NoiseTiledBacking:setAlpha(0.7)
			f34_arg0.clipFinished(f34_arg0.NoiseTiledBacking)
			f34_arg0.CommonCornerPips:completeAnimation()
			f34_arg0.CommonCornerPips:setAlpha(0.5)
			f34_arg0.clipFinished(f34_arg0.CommonCornerPips)
			f34_arg0.SearchingLeft:completeAnimation()
			f34_arg0.SearchingLeft:setRGB(0.29, 0.29, 0.29)
			f34_arg0.SearchingLeft:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.SearchingLeft)
			f34_arg0.SearchingRight:completeAnimation()
			f34_arg0.SearchingRight:setRGB(0.29, 0.29, 0.29)
			f34_arg0.SearchingRight:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.SearchingRight)
			local f34_local0 = function(f35_arg0)
				f34_arg0.Spinner:beginAnimation(1400)
				f34_arg0.Spinner:setZRot(-359)
				f34_arg0.Spinner:registerEventHandler("interrupted_keyframe", f34_arg0.clipInterrupted)
				f34_arg0.Spinner:registerEventHandler("transition_complete_keyframe", f34_arg0.clipFinished)
			end
			f34_arg0.Spinner:completeAnimation()
			f34_arg0.Spinner:setAlpha(0.02)
			f34_arg0.Spinner:setZRot(0)
			f34_arg0.Spinner:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
			f34_arg0.Spinner:setShaderVector(0, 2, 0, 0, 0)
			f34_local0(f34_arg0.Spinner)
			f34_arg0.nextClip = "DefaultClip"
		end,
	},
	Empty = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(1)
			f36_arg0.DirectorExpandedLobbyMemberInternal:completeAnimation()
			f36_arg0.DirectorExpandedLobbyMemberInternal:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.DirectorExpandedLobbyMemberInternal)
		end,
	},
	PlayerFound = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(6)
			f37_arg0.DirectorPartyBar:completeAnimation()
			f37_arg0.DirectorPartyBar:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.DirectorPartyBar)
			f37_arg0.DirectorExpandedLobbyMemberInternal:completeAnimation()
			f37_arg0.DirectorExpandedLobbyMemberInternal:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.DirectorExpandedLobbyMemberInternal)
			f37_arg0.SearchingBacking:completeAnimation()
			f37_arg0.SearchingBacking:setAlpha(1)
			f37_arg0.clipFinished(f37_arg0.SearchingBacking)
			f37_arg0.NoiseTiledBacking:completeAnimation()
			f37_arg0.NoiseTiledBacking:setAlpha(0.7)
			f37_arg0.clipFinished(f37_arg0.NoiseTiledBacking)
			f37_arg0.CommonCornerPips:completeAnimation()
			f37_arg0.CommonCornerPips:setAlpha(0.5)
			f37_arg0.clipFinished(f37_arg0.CommonCornerPips)
			local f37_local0 = function(f38_arg0)
				local f38_local0 = function(f39_arg0)
					f39_arg0:beginAnimation(100)
					f39_arg0:setAlpha(0.8)
					f39_arg0:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
				end
				f37_arg0.PlayerFound:beginAnimation(200, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f37_arg0.PlayerFound:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
				f37_arg0.PlayerFound:setAlpha(1)
				f37_arg0.PlayerFound:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.PlayerFound:registerEventHandler("transition_complete_keyframe", f38_local0)
			end
			f37_arg0.PlayerFound:completeAnimation()
			f37_arg0.PlayerFound:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
			f37_arg0.PlayerFound:setAlpha(0)
			f37_local0(f37_arg0.PlayerFound)
		end,
	},
}
CoD.DirectorExpandedLobbyMember.__onClose = function(f40_arg0)
	f40_arg0.DirectorPartyBar:close()
	f40_arg0.DirectorExpandedLobbyMemberInternal:close()
	f40_arg0.DirectorCustomStartButton:close()
	f40_arg0.CommonCornerPips:close()
end
