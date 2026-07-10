require("x64:fa3f15fd69b38b3")
require("x64:94acc3cb318e13b")
require("x64:8ffe7c4e01e7052")
require("x64:5f8cf56752aa71b")
require("x64:2d361ac3553c22a")
CoD.StickerSetBonusItem_Internal = InheritFrom(LUI.UIElement)
CoD.StickerSetBonusItem_Internal.__defaultWidth = 144
CoD.StickerSetBonusItem_Internal.__defaultHeight = 144
CoD.StickerSetBonusItem_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StickerSetBonusItem_Internal)
	self.id = "StickerSetBonusItem_Internal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setRGB(1, 0.78, 0)
	NoiseTiledBacking:setAlpha(0.8)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local BGAdd = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGAdd:setRGB(0.77, 0.78, 0)
	BGAdd:setAlpha(0.02)
	BGAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(BGAdd)
	self.BGAdd = BGAdd
	local itemImage = LUI.UIElement.new(0, 1, 5, -5, 0, 1, 5, -5)
	itemImage:setRGB(0.92, 0.92, 0.92)
	itemImage.__Emblem_Index = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			itemImage:setupEmblemByEmblemIndex(GetEmblemIndexParams(f1_arg1, f2_local0))
		end
	end
	itemImage:linkToElementModel(self, "emblemIndex", true, itemImage.__Emblem_Index)
	itemImage.__Emblem_Index_FullPath = function()
		local f3_local0 = self:getModel()
		if f3_local0 then
			f3_local0 = self:getModel()
			f3_local0 = f3_local0.emblemIndex
		end
		if f3_local0 then
			itemImage.__Emblem_Index(f3_local0)
		end
	end
	self:addElement(itemImage)
	self.itemImage = itemImage
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CommonButtonOutline.Lines:setAlpha(0)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	local FrameBorder = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -2, 2)
	FrameBorder:setRGB(1, 0.58, 0)
	FrameBorder:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	FrameBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_6DAB59B2CAE01851"))
	FrameBorder:setShaderVector(0, 0, 0, 0, 0)
	FrameBorder:setShaderVector(1, 1, 0, 0, 0)
	FrameBorder:setupNineSliceShader(12, 12)
	self:addElement(FrameBorder)
	self.FrameBorder = FrameBorder
	local LockIcon = CoD.BM_Lock.new(f1_arg0, f1_arg1, 0.5, 0.5, -24, 24, 0.5, 0.5, -24, 24)
	LockIcon:setAlpha(0)
	LockIcon:setScale(0.6, 0.6)
	self:addElement(LockIcon)
	self.LockIcon = LockIcon
	local BMGoldBar = CoD.BM_GoldBarMed.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0.5, 0.5, -15, 15)
	BMGoldBar:setAlpha(0)
	self:addElement(BMGoldBar)
	self.BMGoldBar = BMGoldBar
	local EquippedMarkerBG = LUI.UIImage.new(1, 1, -38, 6, 0, 0, -6, 38)
	EquippedMarkerBG:setAlpha(0)
	EquippedMarkerBG:setZoom(4)
	EquippedMarkerBG:setImage(RegisterImage(@"uie_ui_menu_cac_equipped_marker_bg"))
	EquippedMarkerBG:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(EquippedMarkerBG)
	self.EquippedMarkerBG = EquippedMarkerBG
	local EquippedMarkerTick = LUI.UIImage.new(1, 1, -38, 6, 0, 0, -6, 38)
	EquippedMarkerTick:setAlpha(0)
	EquippedMarkerTick:setZoom(4)
	EquippedMarkerTick:setImage(RegisterImage(@"uie_ui_menu_cac_equipped_marker_tick"))
	self:addElement(EquippedMarkerTick)
	self.EquippedMarkerTick = EquippedMarkerTick
	local BreadcrumbNew = CoD.ItemNewBreadcrumbWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -78, 78, 0.5, 0.5, -18, 18)
	BreadcrumbNew:setAlpha(0)
	self:addElement(BreadcrumbNew)
	self.BreadcrumbNew = BreadcrumbNew
	local TrialWidget = CoD.TrialWidget.new(f1_arg0, f1_arg1, 0, 0, 5, 30, 0, 0, 5, 30)
	TrialWidget:setAlpha(0)
	self:addElement(TrialWidget)
	self.TrialWidget = TrialWidget
	itemImage:linkToElementModel(self, "storageFileType", true, itemImage.__Emblem_Index_FullPath)
	self:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return CoD.CraftUtility.IsCraftClassified(element, f1_arg1)
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
				return CoD.CraftUtility.Emblems_IsDefaultEmblemEquipped(menu, element, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "owned", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "owned",
		})
	end)
	self:linkToElementModel(self, "available", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "available",
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
	CommonButtonOutline.id = "CommonButtonOutline"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StickerSetBonusItem_Internal.__resetProperties = function(f14_arg0)
	f14_arg0.CommonButtonOutline:completeAnimation()
	f14_arg0.itemImage:completeAnimation()
	f14_arg0.BMGoldBar:completeAnimation()
	f14_arg0.TrialWidget:completeAnimation()
	f14_arg0.LockIcon:completeAnimation()
	f14_arg0.BreadcrumbNew:completeAnimation()
	f14_arg0.EquippedMarkerTick:completeAnimation()
	f14_arg0.EquippedMarkerBG:completeAnimation()
	f14_arg0.CommonButtonOutline:setRGB(1, 1, 1)
	f14_arg0.CommonButtonOutline.Lines:setAlpha(0)
	f14_arg0.itemImage:setRGB(0.92, 0.92, 0.92)
	f14_arg0.itemImage:setAlpha(1)
	f14_arg0.BMGoldBar:setAlpha(0)
	f14_arg0.TrialWidget:setAlpha(0)
	f14_arg0.LockIcon:setRGB(1, 1, 1)
	f14_arg0.LockIcon:setAlpha(0)
	f14_arg0.BreadcrumbNew:setAlpha(0)
	f14_arg0.EquippedMarkerTick:setAlpha(0)
	f14_arg0.EquippedMarkerBG:setAlpha(0)
end
CoD.StickerSetBonusItem_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.CommonButtonOutline:completeAnimation()
			f15_arg0.CommonButtonOutline:setRGB(1, 1, 1)
			f15_arg0.clipFinished(f15_arg0.CommonButtonOutline)
		end,
		ChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.CommonButtonOutline:completeAnimation()
			f16_arg0.CommonButtonOutline:setRGB(1, 1, 1)
			f16_arg0.clipFinished(f16_arg0.CommonButtonOutline)
		end,
		GainChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.CommonButtonOutline:completeAnimation()
			f17_arg0.CommonButtonOutline:setRGB(1, 1, 1)
			f17_arg0.clipFinished(f17_arg0.CommonButtonOutline)
		end,
		LoseChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.CommonButtonOutline:completeAnimation()
			f18_arg0.CommonButtonOutline:setRGB(1, 1, 1)
			f18_arg0.clipFinished(f18_arg0.CommonButtonOutline)
		end,
	},
	Unavailable = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(3)
			f19_arg0.itemImage:completeAnimation()
			f19_arg0.itemImage:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.itemImage)
			f19_arg0.CommonButtonOutline:completeAnimation()
			f19_arg0.CommonButtonOutline.Lines:completeAnimation()
			f19_arg0.CommonButtonOutline.Lines:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.CommonButtonOutline)
			f19_arg0.BMGoldBar:completeAnimation()
			f19_arg0.BMGoldBar:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.BMGoldBar)
		end,
		ChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(3)
			f20_arg0.itemImage:completeAnimation()
			f20_arg0.itemImage:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.itemImage)
			f20_arg0.CommonButtonOutline:completeAnimation()
			f20_arg0.CommonButtonOutline.Lines:completeAnimation()
			f20_arg0.CommonButtonOutline.Lines:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.CommonButtonOutline)
			f20_arg0.BMGoldBar:completeAnimation()
			f20_arg0.BMGoldBar:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.BMGoldBar)
		end,
		GainChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			f21_arg0.itemImage:completeAnimation()
			f21_arg0.itemImage:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.itemImage)
			f21_arg0.CommonButtonOutline:completeAnimation()
			f21_arg0.CommonButtonOutline.Lines:completeAnimation()
			f21_arg0.CommonButtonOutline.Lines:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.CommonButtonOutline)
			f21_arg0.BMGoldBar:completeAnimation()
			f21_arg0.BMGoldBar:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.BMGoldBar)
		end,
		LoseChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(3)
			f22_arg0.itemImage:completeAnimation()
			f22_arg0.itemImage:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.itemImage)
			f22_arg0.CommonButtonOutline:completeAnimation()
			f22_arg0.CommonButtonOutline.Lines:completeAnimation()
			f22_arg0.CommonButtonOutline.Lines:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.CommonButtonOutline)
			f22_arg0.BMGoldBar:completeAnimation()
			f22_arg0.BMGoldBar:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.BMGoldBar)
		end,
	},
	TrialLocked = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			f23_arg0.CommonButtonOutline:completeAnimation()
			f23_arg0.CommonButtonOutline:setRGB(1, 1, 1)
			f23_arg0.clipFinished(f23_arg0.CommonButtonOutline)
			f23_arg0.TrialWidget:completeAnimation()
			f23_arg0.TrialWidget:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.TrialWidget)
		end,
		ChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.CommonButtonOutline:completeAnimation()
			f24_arg0.CommonButtonOutline:setRGB(1, 1, 1)
			f24_arg0.clipFinished(f24_arg0.CommonButtonOutline)
			f24_arg0.TrialWidget:completeAnimation()
			f24_arg0.TrialWidget:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.TrialWidget)
		end,
		GainChildFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(2)
			f25_arg0.CommonButtonOutline:completeAnimation()
			f25_arg0.CommonButtonOutline:setRGB(1, 1, 1)
			f25_arg0.clipFinished(f25_arg0.CommonButtonOutline)
			f25_arg0.TrialWidget:completeAnimation()
			f25_arg0.TrialWidget:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.TrialWidget)
		end,
		LoseChildFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(2)
			f26_arg0.CommonButtonOutline:completeAnimation()
			f26_arg0.CommonButtonOutline:setRGB(1, 1, 1)
			f26_arg0.clipFinished(f26_arg0.CommonButtonOutline)
			f26_arg0.TrialWidget:completeAnimation()
			f26_arg0.TrialWidget:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.TrialWidget)
		end,
	},
	Locked = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(2)
			f27_arg0.itemImage:completeAnimation()
			f27_arg0.itemImage:setRGB(0.29, 0.29, 0.29)
			f27_arg0.clipFinished(f27_arg0.itemImage)
			f27_arg0.LockIcon:completeAnimation()
			f27_arg0.LockIcon:setRGB(0.92, 0.92, 0.92)
			f27_arg0.LockIcon:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.LockIcon)
		end,
		ChildFocus = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(2)
			f28_arg0.itemImage:completeAnimation()
			f28_arg0.itemImage:setRGB(0.49, 0.49, 0.49)
			f28_arg0.clipFinished(f28_arg0.itemImage)
			f28_arg0.LockIcon:completeAnimation()
			f28_arg0.LockIcon:setRGB(1, 1, 1)
			f28_arg0.LockIcon:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.LockIcon)
		end,
		GainChildFocus = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(2)
			local f29_local0 = function(f30_arg0)
				f29_arg0.itemImage:beginAnimation(200)
				f29_arg0.itemImage:setRGB(0.49, 0.49, 0.49)
				f29_arg0.itemImage:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.itemImage:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.itemImage:completeAnimation()
			f29_arg0.itemImage:setRGB(0.29, 0.29, 0.29)
			f29_local0(f29_arg0.itemImage)
			local f29_local1 = function(f31_arg0)
				f29_arg0.LockIcon:beginAnimation(200)
				f29_arg0.LockIcon:setRGB(1, 1, 1)
				f29_arg0.LockIcon:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.LockIcon:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.LockIcon:completeAnimation()
			f29_arg0.LockIcon:setRGB(0.92, 0.92, 0.92)
			f29_arg0.LockIcon:setAlpha(1)
			f29_local1(f29_arg0.LockIcon)
		end,
		LoseChildFocus = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(2)
			local f32_local0 = function(f33_arg0)
				f32_arg0.itemImage:beginAnimation(200)
				f32_arg0.itemImage:setRGB(0.29, 0.29, 0.29)
				f32_arg0.itemImage:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.itemImage:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.itemImage:completeAnimation()
			f32_arg0.itemImage:setRGB(0.49, 0.49, 0.49)
			f32_local0(f32_arg0.itemImage)
			local f32_local1 = function(f34_arg0)
				f32_arg0.LockIcon:beginAnimation(200)
				f32_arg0.LockIcon:setRGB(0.92, 0.92, 0.92)
				f32_arg0.LockIcon:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.LockIcon:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.LockIcon:completeAnimation()
			f32_arg0.LockIcon:setRGB(1, 1, 1)
			f32_arg0.LockIcon:setAlpha(1)
			f32_local1(f32_arg0.LockIcon)
		end,
	},
	New = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(1)
			f35_arg0.BreadcrumbNew:completeAnimation()
			f35_arg0.BreadcrumbNew:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.BreadcrumbNew)
		end,
		ChildFocus = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(2)
			f36_arg0.itemImage:completeAnimation()
			f36_arg0.itemImage:setAlpha(1)
			f36_arg0.clipFinished(f36_arg0.itemImage)
			local f36_local0 = function(f37_arg0)
				local f37_local0 = function(f38_arg0)
					f38_arg0:beginAnimation(200)
					f38_arg0:setAlpha(0)
					f38_arg0:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
				end
				f36_arg0.BreadcrumbNew:beginAnimation(400)
				f36_arg0.BreadcrumbNew:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.BreadcrumbNew:registerEventHandler("transition_complete_keyframe", f37_local0)
			end
			f36_arg0.BreadcrumbNew:completeAnimation()
			f36_arg0.BreadcrumbNew:setAlpha(1)
			f36_local0(f36_arg0.BreadcrumbNew)
		end,
		GainChildFocus = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(2)
			f39_arg0.itemImage:completeAnimation()
			f39_arg0.itemImage:setAlpha(1)
			f39_arg0.clipFinished(f39_arg0.itemImage)
			f39_arg0.BreadcrumbNew:completeAnimation()
			f39_arg0.BreadcrumbNew:setAlpha(1)
			f39_arg0.clipFinished(f39_arg0.BreadcrumbNew)
		end,
		LoseChildFocus = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(2)
			f40_arg0.itemImage:completeAnimation()
			f40_arg0.itemImage:setAlpha(1)
			f40_arg0.clipFinished(f40_arg0.itemImage)
			f40_arg0.BreadcrumbNew:completeAnimation()
			f40_arg0.BreadcrumbNew:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.BreadcrumbNew)
		end,
	},
	Equipped = {
		DefaultClip = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(1)
			f41_arg0.EquippedMarkerTick:completeAnimation()
			f41_arg0.EquippedMarkerTick:setAlpha(1)
			f41_arg0.clipFinished(f41_arg0.EquippedMarkerTick)
		end,
		ChildFocus = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(2)
			f42_arg0.EquippedMarkerBG:completeAnimation()
			f42_arg0.EquippedMarkerBG:setAlpha(1)
			f42_arg0.clipFinished(f42_arg0.EquippedMarkerBG)
			f42_arg0.EquippedMarkerTick:completeAnimation()
			f42_arg0.EquippedMarkerTick:setAlpha(1)
			f42_arg0.clipFinished(f42_arg0.EquippedMarkerTick)
		end,
		GainChildFocus = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(1)
			f43_arg0.EquippedMarkerTick:completeAnimation()
			f43_arg0.EquippedMarkerTick:setAlpha(1)
			f43_arg0.clipFinished(f43_arg0.EquippedMarkerTick)
		end,
		LoseChildFocus = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(1)
			f44_arg0.EquippedMarkerTick:completeAnimation()
			f44_arg0.EquippedMarkerTick:setAlpha(1)
			f44_arg0.clipFinished(f44_arg0.EquippedMarkerTick)
		end,
	},
}
CoD.StickerSetBonusItem_Internal.__onClose = function(f45_arg0)
	f45_arg0.itemImage:close()
	f45_arg0.CommonButtonOutline:close()
	f45_arg0.LockIcon:close()
	f45_arg0.BMGoldBar:close()
	f45_arg0.BreadcrumbNew:close()
	f45_arg0.TrialWidget:close()
end
