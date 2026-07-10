require("x64:fa3f15fd69b38b3")
require("x64:94acc3cb318e13b")
require("x64:8ffe7c4e01e7052")
require("x64:5f8cf56752aa71b")
require("x64:2d361ac3553c22a")
CoD.StickerSetItemInternal = InheritFrom(LUI.UIElement)
CoD.StickerSetItemInternal.__defaultWidth = 160
CoD.StickerSetItemInternal.__defaultHeight = 160
CoD.StickerSetItemInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StickerSetItemInternal)
	self.id = "StickerSetItemInternal"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.8)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
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
	local FrontendFrame = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrontendFrame:setAlpha(0.2)
	FrontendFrame:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrontendFrame:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrontendFrame:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrame)
	self.FrontendFrame = FrontendFrame
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	local BMGoldBar = CoD.BM_GoldBarMed.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0.5, 0.5, -15, 15)
	BMGoldBar:setAlpha(0)
	self:addElement(BMGoldBar)
	self.BMGoldBar = BMGoldBar
	local EquippedMarkerBG = LUI.UIImage.new(1, 1, -38, 6, 0, 0, -7, 37)
	EquippedMarkerBG:setAlpha(0)
	EquippedMarkerBG:setZoom(4)
	EquippedMarkerBG:setImage(RegisterImage(0x7AF532D84DE505A))
	EquippedMarkerBG:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(EquippedMarkerBG)
	self.EquippedMarkerBG = EquippedMarkerBG
	local EquippedMarkerTick = LUI.UIImage.new(1, 1, -38, 6, 0, 0, -7, 37)
	EquippedMarkerTick:setAlpha(0)
	EquippedMarkerTick:setZoom(4)
	EquippedMarkerTick:setImage(RegisterImage(0x9A8B26C9B001758))
	self:addElement(EquippedMarkerTick)
	self.EquippedMarkerTick = EquippedMarkerTick
	local BreadcrumbNew = CoD.ItemNewBreadcrumbWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -78, 78, 0.5, 0.5, -18, 18)
	BreadcrumbNew:setAlpha(0)
	self:addElement(BreadcrumbNew)
	self.BreadcrumbNew = BreadcrumbNew
	local LockIcon = CoD.BM_Lock.new(f1_arg0, f1_arg1, 0.5, 0.5, -24, 24, 0.5, 0.5, -24, 24)
	LockIcon:setAlpha(0)
	LockIcon:setScale(0.6, 0.6)
	self:addElement(LockIcon)
	self.LockIcon = LockIcon
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
	self.__defaultFocus = CommonButtonOutline
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StickerSetItemInternal.__resetProperties = function(f14_arg0)
	f14_arg0.itemImage:completeAnimation()
	f14_arg0.BMGoldBar:completeAnimation()
	f14_arg0.TrialWidget:completeAnimation()
	f14_arg0.LockIcon:completeAnimation()
	f14_arg0.BreadcrumbNew:completeAnimation()
	f14_arg0.EquippedMarkerTick:completeAnimation()
	f14_arg0.EquippedMarkerBG:completeAnimation()
	f14_arg0.itemImage:setRGB(0.92, 0.92, 0.92)
	f14_arg0.itemImage:setAlpha(1)
	f14_arg0.BMGoldBar:setAlpha(0)
	f14_arg0.TrialWidget:setAlpha(0)
	f14_arg0.LockIcon:setAlpha(0)
	f14_arg0.BreadcrumbNew:setAlpha(0)
	f14_arg0.EquippedMarkerTick:setAlpha(0)
	f14_arg0.EquippedMarkerBG:setAlpha(0)
end
CoD.StickerSetItemInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.itemImage:completeAnimation()
			f15_arg0.itemImage:setRGB(0.92, 0.92, 0.92)
			f15_arg0.clipFinished(f15_arg0.itemImage)
		end,
		ChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.itemImage:completeAnimation()
			f16_arg0.itemImage:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.itemImage)
		end,
		GainChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.itemImage:completeAnimation()
			f17_arg0.itemImage:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.itemImage)
		end,
		LoseChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.itemImage:completeAnimation()
			f18_arg0.itemImage:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.itemImage)
		end,
	},
	Unavailable = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			f19_arg0.itemImage:completeAnimation()
			f19_arg0.itemImage:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.itemImage)
			f19_arg0.BMGoldBar:completeAnimation()
			f19_arg0.BMGoldBar:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.BMGoldBar)
		end,
		ChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.itemImage:completeAnimation()
			f20_arg0.itemImage:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.itemImage)
			f20_arg0.BMGoldBar:completeAnimation()
			f20_arg0.BMGoldBar:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.BMGoldBar)
		end,
		GainChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.itemImage:completeAnimation()
			f21_arg0.itemImage:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.itemImage)
			f21_arg0.BMGoldBar:completeAnimation()
			f21_arg0.BMGoldBar:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.BMGoldBar)
		end,
		LoseChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.itemImage:completeAnimation()
			f22_arg0.itemImage:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.itemImage)
			f22_arg0.BMGoldBar:completeAnimation()
			f22_arg0.BMGoldBar:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.BMGoldBar)
		end,
	},
	TrialLocked = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			f23_arg0.itemImage:completeAnimation()
			f23_arg0.itemImage:setRGB(0.92, 0.92, 0.92)
			f23_arg0.clipFinished(f23_arg0.itemImage)
			f23_arg0.TrialWidget:completeAnimation()
			f23_arg0.TrialWidget:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.TrialWidget)
		end,
		ChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.itemImage:completeAnimation()
			f24_arg0.itemImage:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.itemImage)
			f24_arg0.TrialWidget:completeAnimation()
			f24_arg0.TrialWidget:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.TrialWidget)
		end,
		GainChildFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(2)
			f25_arg0.itemImage:completeAnimation()
			f25_arg0.itemImage:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.itemImage)
			f25_arg0.TrialWidget:completeAnimation()
			f25_arg0.TrialWidget:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.TrialWidget)
		end,
		LoseChildFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(2)
			f26_arg0.itemImage:completeAnimation()
			f26_arg0.itemImage:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.itemImage)
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
			f29_arg0.LockIcon:completeAnimation()
			f29_arg0.LockIcon:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.LockIcon)
		end,
		LoseChildFocus = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(2)
			local f31_local0 = function(f32_arg0)
				f31_arg0.itemImage:beginAnimation(200)
				f31_arg0.itemImage:setRGB(0.29, 0.29, 0.29)
				f31_arg0.itemImage:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.itemImage:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.itemImage:completeAnimation()
			f31_arg0.itemImage:setRGB(0.49, 0.49, 0.49)
			f31_local0(f31_arg0.itemImage)
			f31_arg0.LockIcon:completeAnimation()
			f31_arg0.LockIcon:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.LockIcon)
		end,
	},
	New = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(1)
			f33_arg0.BreadcrumbNew:completeAnimation()
			f33_arg0.BreadcrumbNew:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.BreadcrumbNew)
		end,
		ChildFocus = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(2)
			f34_arg0.itemImage:completeAnimation()
			f34_arg0.itemImage:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.itemImage)
			local f34_local0 = function(f35_arg0)
				local f35_local0 = function(f36_arg0)
					f36_arg0:beginAnimation(200)
					f36_arg0:setAlpha(0)
					f36_arg0:registerEventHandler("transition_complete_keyframe", f34_arg0.clipFinished)
				end
				f34_arg0.BreadcrumbNew:beginAnimation(400)
				f34_arg0.BreadcrumbNew:registerEventHandler("interrupted_keyframe", f34_arg0.clipInterrupted)
				f34_arg0.BreadcrumbNew:registerEventHandler("transition_complete_keyframe", f35_local0)
			end
			f34_arg0.BreadcrumbNew:completeAnimation()
			f34_arg0.BreadcrumbNew:setAlpha(1)
			f34_local0(f34_arg0.BreadcrumbNew)
		end,
		GainChildFocus = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(2)
			f37_arg0.itemImage:completeAnimation()
			f37_arg0.itemImage:setAlpha(1)
			f37_arg0.clipFinished(f37_arg0.itemImage)
			f37_arg0.BreadcrumbNew:completeAnimation()
			f37_arg0.BreadcrumbNew:setAlpha(1)
			f37_arg0.clipFinished(f37_arg0.BreadcrumbNew)
		end,
		LoseChildFocus = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(2)
			f38_arg0.itemImage:completeAnimation()
			f38_arg0.itemImage:setAlpha(1)
			f38_arg0.clipFinished(f38_arg0.itemImage)
			f38_arg0.BreadcrumbNew:completeAnimation()
			f38_arg0.BreadcrumbNew:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.BreadcrumbNew)
		end,
	},
	Equipped = {
		DefaultClip = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(2)
			f39_arg0.EquippedMarkerBG:completeAnimation()
			f39_arg0.EquippedMarkerBG:setAlpha(1)
			f39_arg0.clipFinished(f39_arg0.EquippedMarkerBG)
			f39_arg0.EquippedMarkerTick:completeAnimation()
			f39_arg0.EquippedMarkerTick:setAlpha(1)
			f39_arg0.clipFinished(f39_arg0.EquippedMarkerTick)
		end,
		ChildFocus = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(2)
			f40_arg0.EquippedMarkerBG:completeAnimation()
			f40_arg0.EquippedMarkerBG:setAlpha(1)
			f40_arg0.clipFinished(f40_arg0.EquippedMarkerBG)
			f40_arg0.EquippedMarkerTick:completeAnimation()
			f40_arg0.EquippedMarkerTick:setAlpha(1)
			f40_arg0.clipFinished(f40_arg0.EquippedMarkerTick)
		end,
		GainChildFocus = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(2)
			f41_arg0.EquippedMarkerBG:completeAnimation()
			f41_arg0.EquippedMarkerBG:setAlpha(1)
			f41_arg0.clipFinished(f41_arg0.EquippedMarkerBG)
			f41_arg0.EquippedMarkerTick:completeAnimation()
			f41_arg0.EquippedMarkerTick:setAlpha(1)
			f41_arg0.clipFinished(f41_arg0.EquippedMarkerTick)
		end,
		LoseChildFocus = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(2)
			f42_arg0.EquippedMarkerBG:completeAnimation()
			f42_arg0.EquippedMarkerBG:setAlpha(1)
			f42_arg0.clipFinished(f42_arg0.EquippedMarkerBG)
			f42_arg0.EquippedMarkerTick:completeAnimation()
			f42_arg0.EquippedMarkerTick:setAlpha(1)
			f42_arg0.clipFinished(f42_arg0.EquippedMarkerTick)
		end,
	},
}
CoD.StickerSetItemInternal.__onClose = function(f43_arg0)
	f43_arg0.itemImage:close()
	f43_arg0.CommonButtonOutline:close()
	f43_arg0.BMGoldBar:close()
	f43_arg0.BreadcrumbNew:close()
	f43_arg0.LockIcon:close()
	f43_arg0.TrialWidget:close()
end
