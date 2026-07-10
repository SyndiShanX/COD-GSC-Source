require("x64:246178cf189051b")
CoD.UpsellBanner_Internal = InheritFrom(LUI.UIElement)
CoD.UpsellBanner_Internal.__defaultWidth = 540
CoD.UpsellBanner_Internal.__defaultHeight = 150
CoD.UpsellBanner_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.UpsellBanner_Internal)
	self.id = "UpsellBanner_Internal"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local Image = LUI.UIImage.new(0, 0, 0, 540, 0, 0, 0, 150)
	Image:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1A02C44161370F6D"))
	Image:setShaderVector(0, 0, 0.2, 0, 0)
	Image:setShaderVector(1, 1, 1, 0, 0)
	Image:setShaderVector(2, 0, 0, 0, 0)
	Image:linkToElementModel(self, "playlist", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Image:setImage(RegisterImage(CoD.StoreUtility.GetDLCImageFromPlaylist(f1_arg1, f2_local0)))
		end
	end)
	self:addElement(Image)
	self.Image = Image
	local buttonPromptImage = LUI.UIImage.new(0, 0, 5, 41, 0, 0, 109, 145)
	buttonPromptImage:subscribeToGlobalModel(f1_arg1, "Controller", "alt1_button_image", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			buttonPromptImage:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(buttonPromptImage)
	self.buttonPromptImage = buttonPromptImage
	local Description = LUI.UIText.new(0, 0, 47, 385, 1, 1, -31.5, -11.5)
	Description:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Description:setText(LocalizeToUpperString(@"menu/purchase"))
	Description:setTTF("ttmussels_demibold")
	Description:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	Description:setShaderVector(0, 0, 0, 0, 0)
	Description:setShaderVector(1, 0, 0, 0, 0)
	Description:setShaderVector(2, 1, 1, 1, 0)
	Description:setLetterSpacing(2)
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	Description:setBackingType(2)
	Description:setBackingColor(0, 0, 0)
	Description:setBackingAlpha(0.85)
	Description:setBackingXPadding(6)
	Description:setBackingYPadding(4)
	Description:setBackingImage(RegisterImage(@"hash_7C229CEBABEEAB0E"))
	self:addElement(Description)
	self.Description = Description
	local upsellIcon = LUI.UIText.new(0, 0, -51, 149, 0, 0, 10.5, 82.5)
	upsellIcon:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/purchase_icon"))
	upsellIcon:setTTF("default")
	upsellIcon:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	upsellIcon:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(upsellIcon)
	self.upsellIcon = upsellIcon
	local downloadIcon = LUI.UIImage.new(0, 0, 26.5, 106.5, 0, 0, 10.5, 90.5)
	downloadIcon:setImage(RegisterImage(@"t7_icon_menu_options_download"))
	self:addElement(downloadIcon)
	self.downloadIcon = downloadIcon
	local KeyPrompt = nil
	KeyPrompt = CoD.KeyPrompt.new(f1_arg0, f1_arg1, 0, 0, 5, 41, 0, 0, 109, 145)
	KeyPrompt:setAlpha(0)
	KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("[{ui_contextual_1}]"))
	self:addElement(KeyPrompt)
	self.KeyPrompt = KeyPrompt
	local BraketBottom = LUI.UIImage.new(0, 1, -2, 2, 1, 1, -28, 1)
	BraketBottom:setZRot(180)
	BraketBottom:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_info_bracket"))
	BraketBottom:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	BraketBottom:setShaderVector(0, 0, 0, 0, 0)
	BraketBottom:setupNineSliceShader(200, 100)
	self:addElement(BraketBottom)
	self.BraketBottom = BraketBottom
	local BraketTop = LUI.UIImage.new(0, 1, -2, 2, 0, 0, -1, 28)
	BraketTop:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_info_bracket"))
	BraketTop:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	BraketTop:setShaderVector(0, 0, 0, 0, 0)
	BraketTop:setupNineSliceShader(200, 100)
	self:addElement(BraketTop)
	self.BraketTop = BraketTop
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.StoreUtility.ShouldUpsellOrDownloadPlaylist(f1_arg1, element)
			end,
		},
		{
			stateName = "Download",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "lockState", Enum[@"playlistlockstate"][@"pls_required_dlc_not_available"]) and not IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "DownloadKBM",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "lockState", Enum[@"playlistlockstate"][@"pls_required_dlc_not_available"]) and IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "DefaultStateKBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "lockState", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "lockState",
		})
	end)
	self:appendEventHandler("input_source_changed", function(f9_arg0, f9_arg1)
		f9_arg1.menu = f9_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f9_arg1)
	end)
	local f1_local10 = self
	local f1_local11 = self.subscribeToModel
	local f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local11(f1_local10, f1_local12.LastInput, function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.UpsellBanner_Internal.__resetProperties = function(f11_arg0)
	f11_arg0.downloadIcon:completeAnimation()
	f11_arg0.Image:completeAnimation()
	f11_arg0.Description:completeAnimation()
	f11_arg0.buttonPromptImage:completeAnimation()
	f11_arg0.upsellIcon:completeAnimation()
	f11_arg0.BraketTop:completeAnimation()
	f11_arg0.BraketBottom:completeAnimation()
	f11_arg0.NoiseTiledBacking:completeAnimation()
	f11_arg0.KeyPrompt:completeAnimation()
	f11_arg0.downloadIcon:setAlpha(1)
	f11_arg0.Image:setAlpha(1)
	f11_arg0.Description:setLeftRight(0, 0, 47, 385)
	f11_arg0.Description:setAlpha(1)
	f11_arg0.Description:setText(LocalizeToUpperString(@"menu/purchase"))
	f11_arg0.Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	f11_arg0.buttonPromptImage:setAlpha(1)
	f11_arg0.upsellIcon:setAlpha(1)
	f11_arg0.BraketTop:setAlpha(1)
	f11_arg0.BraketBottom:setAlpha(1)
	f11_arg0.NoiseTiledBacking:setAlpha(1)
	f11_arg0.KeyPrompt:setAlpha(0)
end
CoD.UpsellBanner_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.downloadIcon:completeAnimation()
			f12_arg0.downloadIcon:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.downloadIcon)
		end,
	},
	Hidden = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(8)
			f13_arg0.NoiseTiledBacking:completeAnimation()
			f13_arg0.NoiseTiledBacking:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.NoiseTiledBacking)
			f13_arg0.Image:completeAnimation()
			f13_arg0.Image:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Image)
			f13_arg0.buttonPromptImage:completeAnimation()
			f13_arg0.buttonPromptImage:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.buttonPromptImage)
			f13_arg0.Description:completeAnimation()
			f13_arg0.Description:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Description)
			f13_arg0.upsellIcon:completeAnimation()
			f13_arg0.upsellIcon:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.upsellIcon)
			f13_arg0.downloadIcon:completeAnimation()
			f13_arg0.downloadIcon:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.downloadIcon)
			f13_arg0.BraketBottom:completeAnimation()
			f13_arg0.BraketBottom:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.BraketBottom)
			f13_arg0.BraketTop:completeAnimation()
			f13_arg0.BraketTop:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.BraketTop)
		end,
	},
	Download = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(3)
			f14_arg0.Description:completeAnimation()
			f14_arg0.Description:setText(LocalizeToUpperString(@"menu/download"))
			f14_arg0.clipFinished(f14_arg0.Description)
			f14_arg0.upsellIcon:completeAnimation()
			f14_arg0.upsellIcon:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.upsellIcon)
			f14_arg0.downloadIcon:completeAnimation()
			f14_arg0.downloadIcon:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.downloadIcon)
		end,
	},
	DownloadKBM = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(4)
			f15_arg0.buttonPromptImage:completeAnimation()
			f15_arg0.buttonPromptImage:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.buttonPromptImage)
			f15_arg0.Description:completeAnimation()
			f15_arg0.Description:setLeftRight(0, 0, 9, 392)
			f15_arg0.Description:setText(LocalizeToUpperString(@"menu/download_pc"))
			f15_arg0.Description:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
			f15_arg0.clipFinished(f15_arg0.Description)
			f15_arg0.upsellIcon:completeAnimation()
			f15_arg0.upsellIcon:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.upsellIcon)
			f15_arg0.KeyPrompt:completeAnimation()
			f15_arg0.KeyPrompt:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.KeyPrompt)
		end,
	},
	DefaultStateKBM = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(4)
			f16_arg0.buttonPromptImage:completeAnimation()
			f16_arg0.buttonPromptImage:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.buttonPromptImage)
			f16_arg0.Description:completeAnimation()
			f16_arg0.Description:setLeftRight(0, 0, 10, 389)
			f16_arg0.Description:setText(LocalizeToUpperString(@"menu/purchase_pc"))
			f16_arg0.Description:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
			f16_arg0.clipFinished(f16_arg0.Description)
			f16_arg0.downloadIcon:completeAnimation()
			f16_arg0.downloadIcon:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.downloadIcon)
			f16_arg0.KeyPrompt:completeAnimation()
			f16_arg0.KeyPrompt:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.KeyPrompt)
		end,
	},
}
CoD.UpsellBanner_Internal.__onClose = function(f17_arg0)
	f17_arg0.Image:close()
	f17_arg0.buttonPromptImage:close()
	f17_arg0.KeyPrompt:close()
end
