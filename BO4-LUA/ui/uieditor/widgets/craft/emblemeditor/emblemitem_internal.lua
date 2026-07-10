require("x64:94acc3cb318e13b")
require("x64:eeba57f916954d1")
require("x64:8ffe7c4e01e7052")
require("x64:5f8cf56752aa71b")
require("x64:1d8e482adfc7305")
require("x64:2d361ac3553c22a")
CoD.EmblemItem_Internal = InheritFrom(LUI.UIElement)
CoD.EmblemItem_Internal.__defaultWidth = 152
CoD.EmblemItem_Internal.__defaultHeight = 152
CoD.EmblemItem_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmblemItem_Internal)
	self.id = "EmblemItem_Internal"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.8)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local itemImage = LUI.UIElement.new(0, 1, 5, -5, 0, 1, 5, -5)
	itemImage:setRGB(0.92, 0.92, 0.92)
	itemImage.__Emblem_Index = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			itemImage:setupEmblemByEmblemIndex(GetEmblemRenderInfo(f1_arg1, f2_local0))
		end
	end
	itemImage:linkToElementModel(self, "renderInfo", true, itemImage.__Emblem_Index)
	itemImage.__Emblem_Index_FullPath = function()
		local f3_local0 = self:getModel()
		if f3_local0 then
			f3_local0 = self:getModel()
			f3_local0 = f3_local0.renderInfo
		end
		if f3_local0 then
			itemImage.__Emblem_Index(f3_local0)
		end
	end
	self:addElement(itemImage)
	self.itemImage = itemImage
	local PlusIcon = LUI.UIImage.new(0.5, 0.5, -24, 24, 0.5, 0.5, -24, 24)
	PlusIcon:setAlpha(0)
	PlusIcon:setImage(RegisterImage(@"uie_ui_menu_common_add_plus"))
	self:addElement(PlusIcon)
	self.PlusIcon = PlusIcon
	local BreadcrumbNew = CoD.ItemNewBreadcrumbWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -81, 81, 0.5, 0.5, -17, 19)
	BreadcrumbNew:setAlpha(0)
	self:addElement(BreadcrumbNew)
	self.BreadcrumbNew = BreadcrumbNew
	local FrontendFrame = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrontendFrame:setAlpha(0.2)
	FrontendFrame:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	FrontendFrame:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFrame:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrame)
	self.FrontendFrame = FrontendFrame
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	local EquippedMarkerBG = LUI.UIImage.new(1, 1, -35, 9, 0, 0, -9, 35)
	EquippedMarkerBG:setAlpha(0)
	EquippedMarkerBG:setZoom(4)
	EquippedMarkerBG:setImage(RegisterImage(@"uie_ui_menu_cac_equipped_marker_bg"))
	EquippedMarkerBG:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(EquippedMarkerBG)
	self.EquippedMarkerBG = EquippedMarkerBG
	local EquippedMarkerTick = LUI.UIImage.new(1, 1, -35, 9, 0, 0, -9, 35)
	EquippedMarkerTick:setAlpha(0)
	EquippedMarkerTick:setZoom(4)
	EquippedMarkerTick:setImage(RegisterImage(@"uie_ui_menu_cac_equipped_marker_tick"))
	self:addElement(EquippedMarkerTick)
	self.EquippedMarkerTick = EquippedMarkerTick
	local itemName = LUI.UIText.new(0, 1, 8, -8, 1, 1, -21, -3)
	itemName:setRGB(0.58, 0.58, 0.58)
	itemName:setAlpha(0)
	itemName:setScale(LanguageOverrideNumber("german", 0.9, LanguageOverrideNumber("italian", 0.9, 1, 1)))
	itemName:setText("")
	itemName:setTTF("ttmussels_demibold")
	itemName:setLetterSpacing(1)
	itemName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	itemName:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	itemName:setBackingType(1)
	itemName:setBackingWidget(CoD.FE_PanelNoBlur, f1_arg0, f1_arg1)
	itemName:setBackingColor(0, 0, 0)
	itemName:setBackingAlpha(0.9)
	itemName:setBackingXPadding(3)
	self:addElement(itemName)
	self.itemName = itemName
	local caclock = CoD.cac_lock.new(f1_arg0, f1_arg1, 0.5, 0.5, -24, 24, 0.5, 0.5, -24, 24)
	caclock:setAlpha(0)
	caclock:setScale(0.6, 0.6)
	self:addElement(caclock)
	self.caclock = caclock
	local LockIcon = CoD.BM_Lock.new(f1_arg0, f1_arg1, 0.5, 0.5, -24, 24, 0.5, 0.5, -24, 24)
	LockIcon:setAlpha(0)
	LockIcon:setScale(0.6, 0.6)
	self:addElement(LockIcon)
	self.LockIcon = LockIcon
	local TrialWidget = CoD.TrialWidget.new(f1_arg0, f1_arg1, 0, 0, 5, 30, 0, 0, 5, 30)
	TrialWidget:setAlpha(0)
	self:addElement(TrialWidget)
	self.TrialWidget = TrialWidget
	itemImage:linkToElementModel(self, "renderInfo", true, itemImage.__Emblem_Index_FullPath)
	itemImage:linkToElementModel(self, "emblemIndex", true, itemImage.__Emblem_Index_FullPath)
	itemImage:linkToElementModel(self, "storageFileType", true, itemImage.__Emblem_Index_FullPath)
	self:mergeStateConditions({
		{
			stateName = "EmptySlot",
			condition = function(menu, element, event)
				return not CoD.CraftUtility.Emblem_IsOccupied(element, f1_arg1)
			end,
		},
		{
			stateName = "TrialLocked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "trialLocked")
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "owned")
			end,
		},
		{
			stateName = "New",
			condition = function(menu, element, event)
				return CoD.BreadcrumbUtility.IsEmblemStickerIconNew(menu, element, f1_arg1)
			end,
		},
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.CraftUtility.Emblems_IsDefaultEmblemEquipped(menu, self, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "emblemIndex", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "emblemIndex",
		})
	end)
	self:linkToElementModel(self, "storageFileType", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "storageFileType",
		})
	end)
	self:linkToElementModel(self, "trialLocked", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "trialLocked",
		})
	end)
	self:linkToElementModel(self, "owned", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "owned",
		})
	end)
	CommonButtonOutline.id = "CommonButtonOutline"
	self.__defaultFocus = CommonButtonOutline
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EmblemItem_Internal.__resetProperties = function(f13_arg0)
	f13_arg0.itemName:completeAnimation()
	f13_arg0.PlusIcon:completeAnimation()
	f13_arg0.TrialWidget:completeAnimation()
	f13_arg0.itemImage:completeAnimation()
	f13_arg0.LockIcon:completeAnimation()
	f13_arg0.BreadcrumbNew:completeAnimation()
	f13_arg0.EquippedMarkerTick:completeAnimation()
	f13_arg0.EquippedMarkerBG:completeAnimation()
	f13_arg0.itemName:setRGB(0.58, 0.58, 0.58)
	f13_arg0.PlusIcon:setRGB(1, 1, 1)
	f13_arg0.PlusIcon:setAlpha(0)
	f13_arg0.TrialWidget:setAlpha(0)
	f13_arg0.itemImage:setRGB(0.92, 0.92, 0.92)
	f13_arg0.itemImage:setAlpha(1)
	f13_arg0.LockIcon:setAlpha(0)
	f13_arg0.BreadcrumbNew:setAlpha(0)
	f13_arg0.EquippedMarkerTick:setAlpha(0)
	f13_arg0.EquippedMarkerBG:setAlpha(0)
end
CoD.EmblemItem_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.itemName:completeAnimation()
			f15_arg0.itemName:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f15_arg0.clipFinished(f15_arg0.itemName)
		end,
		GainChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			local f16_local0 = function(f17_arg0)
				f16_arg0.itemName:beginAnimation(200)
				f16_arg0.itemName:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
				f16_arg0.itemName:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.itemName:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.itemName:completeAnimation()
			f16_arg0.itemName:setRGB(0.58, 0.58, 0.58)
			f16_local0(f16_arg0.itemName)
		end,
		LoseChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			local f18_local0 = function(f19_arg0)
				f18_arg0.itemName:beginAnimation(200)
				f18_arg0.itemName:setRGB(0.58, 0.58, 0.58)
				f18_arg0.itemName:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.itemName:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.itemName:completeAnimation()
			f18_arg0.itemName:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f18_local0(f18_arg0.itemName)
		end,
	},
	EmptySlot = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.PlusIcon:completeAnimation()
			f20_arg0.PlusIcon:setRGB(1, 1, 1)
			f20_arg0.PlusIcon:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.PlusIcon)
		end,
		ChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.PlusIcon:completeAnimation()
			f21_arg0.PlusIcon:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.PlusIcon)
		end,
		GainChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.PlusIcon:completeAnimation()
			f22_arg0.PlusIcon:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.PlusIcon)
		end,
		LoseChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			f23_arg0.PlusIcon:completeAnimation()
			f23_arg0.PlusIcon:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.PlusIcon)
		end,
	},
	TrialLocked = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			f24_arg0.TrialWidget:completeAnimation()
			f24_arg0.TrialWidget:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.TrialWidget)
		end,
		ChildFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(2)
			f25_arg0.itemName:completeAnimation()
			f25_arg0.itemName:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f25_arg0.clipFinished(f25_arg0.itemName)
			f25_arg0.TrialWidget:completeAnimation()
			f25_arg0.TrialWidget:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.TrialWidget)
		end,
		GainChildFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(2)
			local f26_local0 = function(f27_arg0)
				f26_arg0.itemName:beginAnimation(200)
				f26_arg0.itemName:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
				f26_arg0.itemName:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.itemName:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.itemName:completeAnimation()
			f26_arg0.itemName:setRGB(0.58, 0.58, 0.58)
			f26_local0(f26_arg0.itemName)
			f26_arg0.TrialWidget:completeAnimation()
			f26_arg0.TrialWidget:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.TrialWidget)
		end,
		LoseChildFocus = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(2)
			local f28_local0 = function(f29_arg0)
				f28_arg0.itemName:beginAnimation(200)
				f28_arg0.itemName:setRGB(0.58, 0.58, 0.58)
				f28_arg0.itemName:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.itemName:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.itemName:completeAnimation()
			f28_arg0.itemName:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f28_local0(f28_arg0.itemName)
			f28_arg0.TrialWidget:completeAnimation()
			f28_arg0.TrialWidget:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.TrialWidget)
		end,
	},
	Locked = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(3)
			f30_arg0.itemImage:completeAnimation()
			f30_arg0.itemImage:setRGB(0.29, 0.29, 0.29)
			f30_arg0.itemImage:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.itemImage)
			f30_arg0.itemName:completeAnimation()
			f30_arg0.itemName:setRGB(0.39, 0.39, 0.39)
			f30_arg0.clipFinished(f30_arg0.itemName)
			f30_arg0.LockIcon:completeAnimation()
			f30_arg0.LockIcon:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.LockIcon)
		end,
		ChildFocus = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(3)
			f31_arg0.itemImage:completeAnimation()
			f31_arg0.itemImage:setRGB(0.49, 0.49, 0.49)
			f31_arg0.itemImage:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.itemImage)
			f31_arg0.itemName:completeAnimation()
			f31_arg0.itemName:setRGB(0.92, 0.92, 0.92)
			f31_arg0.clipFinished(f31_arg0.itemName)
			f31_arg0.LockIcon:completeAnimation()
			f31_arg0.LockIcon:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.LockIcon)
		end,
		GainChildFocus = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(3)
			local f32_local0 = function(f33_arg0)
				f32_arg0.itemImage:beginAnimation(200)
				f32_arg0.itemImage:setRGB(0.49, 0.49, 0.49)
				f32_arg0.itemImage:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.itemImage:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.itemImage:completeAnimation()
			f32_arg0.itemImage:setRGB(0.29, 0.29, 0.29)
			f32_arg0.itemImage:setAlpha(1)
			f32_local0(f32_arg0.itemImage)
			local f32_local1 = function(f34_arg0)
				f32_arg0.itemName:beginAnimation(200)
				f32_arg0.itemName:setRGB(0.92, 0.92, 0.92)
				f32_arg0.itemName:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.itemName:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.itemName:completeAnimation()
			f32_arg0.itemName:setRGB(0.39, 0.39, 0.39)
			f32_local1(f32_arg0.itemName)
			f32_arg0.LockIcon:completeAnimation()
			f32_arg0.LockIcon:setAlpha(1)
			f32_arg0.clipFinished(f32_arg0.LockIcon)
		end,
		LoseChildFocus = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(3)
			local f35_local0 = function(f36_arg0)
				f35_arg0.itemImage:beginAnimation(200)
				f35_arg0.itemImage:setRGB(0.29, 0.29, 0.29)
				f35_arg0.itemImage:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.itemImage:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.itemImage:completeAnimation()
			f35_arg0.itemImage:setRGB(0.49, 0.49, 0.49)
			f35_arg0.itemImage:setAlpha(1)
			f35_local0(f35_arg0.itemImage)
			local f35_local1 = function(f37_arg0)
				f35_arg0.itemName:beginAnimation(200)
				f35_arg0.itemName:setRGB(0.39, 0.39, 0.39)
				f35_arg0.itemName:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.itemName:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.itemName:completeAnimation()
			f35_arg0.itemName:setRGB(0.92, 0.92, 0.92)
			f35_local1(f35_arg0.itemName)
			f35_arg0.LockIcon:completeAnimation()
			f35_arg0.LockIcon:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.LockIcon)
		end,
	},
	New = {
		DefaultClip = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(1)
			f38_arg0.BreadcrumbNew:completeAnimation()
			f38_arg0.BreadcrumbNew:setAlpha(1)
			f38_arg0.clipFinished(f38_arg0.BreadcrumbNew)
		end,
		ChildFocus = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(1)
			local f39_local0 = function(f40_arg0)
				local f40_local0 = function(f41_arg0)
					f41_arg0:beginAnimation(200)
					f41_arg0:setAlpha(0)
					f41_arg0:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
				end
				f39_arg0.BreadcrumbNew:beginAnimation(400)
				f39_arg0.BreadcrumbNew:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.BreadcrumbNew:registerEventHandler("transition_complete_keyframe", f40_local0)
			end
			f39_arg0.BreadcrumbNew:completeAnimation()
			f39_arg0.BreadcrumbNew:setAlpha(1)
			f39_local0(f39_arg0.BreadcrumbNew)
		end,
		GainChildFocus = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(1)
			f42_arg0.BreadcrumbNew:completeAnimation()
			f42_arg0.BreadcrumbNew:setAlpha(1)
			f42_arg0.clipFinished(f42_arg0.BreadcrumbNew)
		end,
		LoseChildFocus = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(1)
			f43_arg0.BreadcrumbNew:completeAnimation()
			f43_arg0.BreadcrumbNew:setAlpha(1)
			f43_arg0.clipFinished(f43_arg0.BreadcrumbNew)
		end,
	},
	Equipped = {
		DefaultClip = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(2)
			f44_arg0.EquippedMarkerBG:completeAnimation()
			f44_arg0.EquippedMarkerBG:setAlpha(1)
			f44_arg0.clipFinished(f44_arg0.EquippedMarkerBG)
			f44_arg0.EquippedMarkerTick:completeAnimation()
			f44_arg0.EquippedMarkerTick:setAlpha(1)
			f44_arg0.clipFinished(f44_arg0.EquippedMarkerTick)
		end,
		ChildFocus = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(2)
			f45_arg0.EquippedMarkerBG:completeAnimation()
			f45_arg0.EquippedMarkerBG:setAlpha(1)
			f45_arg0.clipFinished(f45_arg0.EquippedMarkerBG)
			f45_arg0.EquippedMarkerTick:completeAnimation()
			f45_arg0.EquippedMarkerTick:setAlpha(1)
			f45_arg0.clipFinished(f45_arg0.EquippedMarkerTick)
		end,
		GainChildFocus = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter(2)
			f46_arg0.EquippedMarkerBG:completeAnimation()
			f46_arg0.EquippedMarkerBG:setAlpha(1)
			f46_arg0.clipFinished(f46_arg0.EquippedMarkerBG)
			f46_arg0.EquippedMarkerTick:completeAnimation()
			f46_arg0.EquippedMarkerTick:setAlpha(1)
			f46_arg0.clipFinished(f46_arg0.EquippedMarkerTick)
		end,
		LoseChildFocus = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(2)
			f47_arg0.EquippedMarkerBG:completeAnimation()
			f47_arg0.EquippedMarkerBG:setAlpha(1)
			f47_arg0.clipFinished(f47_arg0.EquippedMarkerBG)
			f47_arg0.EquippedMarkerTick:completeAnimation()
			f47_arg0.EquippedMarkerTick:setAlpha(1)
			f47_arg0.clipFinished(f47_arg0.EquippedMarkerTick)
		end,
	},
}
CoD.EmblemItem_Internal.__onClose = function(f48_arg0)
	f48_arg0.itemImage:close()
	f48_arg0.BreadcrumbNew:close()
	f48_arg0.CommonButtonOutline:close()
	f48_arg0.caclock:close()
	f48_arg0.LockIcon:close()
	f48_arg0.TrialWidget:close()
end
