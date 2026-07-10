require("x64:eeba57f916954d1")
require("x64:8ffe7c4e01e7052")
require("x64:acbf06924421e35")
require("x64:fd51e83e2e6dbd1")
require("x64:99814ce8a424f57")
CoD.SpecialistOutfitItemEntry_Internal = InheritFrom(LUI.UIElement)
CoD.SpecialistOutfitItemEntry_Internal.__defaultWidth = 69
CoD.SpecialistOutfitItemEntry_Internal.__defaultHeight = 69
CoD.SpecialistOutfitItemEntry_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialistOutfitItemEntry_Internal)
	self.id = "SpecialistOutfitItemEntry_Internal"
	self.soundSet = "FrontendMain"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FocusGlow = LUI.UIImage.new(0, 1, -34, 34, 0, 1, -34, 34)
	FocusGlow:setAlpha(0)
	FocusGlow:setImage(RegisterImage(0xB8F10D49D85E9C4))
	FocusGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FocusGlow:setShaderVector(0, 0, 0, 0, 0)
	FocusGlow:setupNineSliceShader(100, 100)
	self:addElement(FocusGlow)
	self.FocusGlow = FocusGlow
	local backing = CoD.SpecialistOutfitRowBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(backing)
	self.backing = backing
	local ItemImage = LUI.UIImage.new(0, 1, 2, -2, 0, 1, 2, -2)
	ItemImage:linkToElementModel(self, "icon", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ItemImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(ItemImage)
	self.ItemImage = ItemImage
	local EquippedMarkerTick = CoD.onOffImage.new(f1_arg0, f1_arg1, 1, 1, -34, 10, 0, 0, -9, 35)
	EquippedMarkerTick:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return CoD.PlayerRoleUtility.IsSelectedOutfitItemIndex(element, f1_arg1)
			end,
		},
	})
	local FrontendFrameThin = EquippedMarkerTick
	local CommonCornerPips = EquippedMarkerTick.subscribeToModel
	local FrontendFrameThinAdd = DataSources.MPSpecialistThemes.getModel(f1_arg1)
	CommonCornerPips(FrontendFrameThin, FrontendFrameThinAdd.update, function(f4_arg0)
		f1_arg0:updateElementState(EquippedMarkerTick, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "update",
		})
	end, false)
	EquippedMarkerTick:linkToElementModel(EquippedMarkerTick, "itemIndex", true, function(model)
		f1_arg0:updateElementState(EquippedMarkerTick, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	EquippedMarkerTick:setZoom(4)
	EquippedMarkerTick.image:setImage(RegisterImage(0x9A8B26C9B001758))
	EquippedMarkerTick:linkToElementModel(self, nil, false, function(model)
		EquippedMarkerTick:setModel(model, f1_arg1)
	end)
	self:addElement(EquippedMarkerTick)
	self.EquippedMarkerTick = EquippedMarkerTick
	CommonCornerPips = CoD.CommonCornerPips01.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CommonCornerPips:setAlpha(0)
	self:addElement(CommonCornerPips)
	self.CommonCornerPips = CommonCornerPips
	FrontendFrameThin = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrontendFrameThin:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrontendFrameThin:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrontendFrameThin:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrameThin:setupNineSliceShader(6, 6)
	FrontendFrameThin:linkToElementModel(self, "rarity", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			FrontendFrameThin:setRGB(CoD.BlackMarketUtility.LootRarityToColor(f7_local0))
		end
	end)
	self:addElement(FrontendFrameThin)
	self.FrontendFrameThin = FrontendFrameThin
	FrontendFrameThinAdd = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrontendFrameThinAdd:setAlpha(0)
	FrontendFrameThinAdd:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrontendFrameThinAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrontendFrameThinAdd:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrameThinAdd:setupNineSliceShader(6, 6)
	self:addElement(FrontendFrameThinAdd)
	self.FrontendFrameThinAdd = FrontendFrameThinAdd
	local FrontendFrameGlow = LUI.UIImage.new(0, 1, -2, 2, 0, 1, -2, 2)
	FrontendFrameGlow:setAlpha(0)
	FrontendFrameGlow:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrontendFrameGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrontendFrameGlow:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrameGlow:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrameGlow)
	self.FrontendFrameGlow = FrontendFrameGlow
	local caclock = CoD.cac_lock.new(f1_arg0, f1_arg1, 0.5, 0.5, -16, 16, 0.5, 0.5, -16, 16)
	caclock:setAlpha(0)
	self:addElement(caclock)
	self.caclock = caclock
	local BreadcrumbNew = CoD.ItemNewBreadcrumbWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -78, 78, 0.5, 0.5, -18, 18)
	BreadcrumbNew:setAlpha(0)
	self:addElement(BreadcrumbNew)
	self.BreadcrumbNew = BreadcrumbNew
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "hidden")
			end,
		},
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "available")
			end,
		},
		{
			stateName = "NotOwned",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "owned")
			end,
		},
		{
			stateName = "New",
			condition = function(menu, element, event)
				return CoD.BreadcrumbUtility.IsSpecialistOutfitItemNew(menu, element, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "hidden", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "hidden",
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
	self:linkToElementModel(self, "owned", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "owned",
		})
	end)
	self:linkToElementModel(self, "itemIndex", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	self:linkToElementModel(self, "presetIndex", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "presetIndex",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpecialistOutfitItemEntry_Internal.__resetProperties = function(f17_arg0)
	f17_arg0.FrontendFrameThin:completeAnimation()
	f17_arg0.FocusGlow:completeAnimation()
	f17_arg0.FrontendFrameGlow:completeAnimation()
	f17_arg0.EquippedMarkerTick:completeAnimation()
	f17_arg0.ItemImage:completeAnimation()
	f17_arg0.backing:completeAnimation()
	f17_arg0.caclock:completeAnimation()
	f17_arg0.BreadcrumbNew:completeAnimation()
	f17_arg0.FrontendFrameThin:setAlpha(1)
	f17_arg0.FocusGlow:setAlpha(0)
	f17_arg0.FrontendFrameGlow:setAlpha(0)
	f17_arg0.EquippedMarkerTick:setAlpha(1)
	f17_arg0.ItemImage:setAlpha(1)
	f17_arg0.backing:setAlpha(1)
	f17_arg0.caclock:setAlpha(0)
	f17_arg0.BreadcrumbNew:setAlpha(0)
end
CoD.SpecialistOutfitItemEntry_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.FrontendFrameThin:completeAnimation()
			f18_arg0.FrontendFrameThin:setAlpha(0.5)
			f18_arg0.clipFinished(f18_arg0.FrontendFrameThin)
		end,
		Focus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			f19_arg0.FocusGlow:completeAnimation()
			f19_arg0.FocusGlow:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.FocusGlow)
			f19_arg0.FrontendFrameGlow:completeAnimation()
			f19_arg0.FrontendFrameGlow:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.FrontendFrameGlow)
		end,
		GainFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(3)
			local f20_local0 = function(f21_arg0)
				f20_arg0.FocusGlow:beginAnimation(100)
				f20_arg0.FocusGlow:setAlpha(1)
				f20_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.FocusGlow:completeAnimation()
			f20_arg0.FocusGlow:setAlpha(0)
			f20_local0(f20_arg0.FocusGlow)
			local f20_local1 = function(f22_arg0)
				f20_arg0.FrontendFrameThin:beginAnimation(100)
				f20_arg0.FrontendFrameThin:setAlpha(1)
				f20_arg0.FrontendFrameThin:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.FrontendFrameThin:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.FrontendFrameThin:completeAnimation()
			f20_arg0.FrontendFrameThin:setAlpha(0.5)
			f20_local1(f20_arg0.FrontendFrameThin)
			local f20_local2 = function(f23_arg0)
				f20_arg0.FrontendFrameGlow:beginAnimation(150)
				f20_arg0.FrontendFrameGlow:setAlpha(1)
				f20_arg0.FrontendFrameGlow:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.FrontendFrameGlow:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.FrontendFrameGlow:completeAnimation()
			f20_arg0.FrontendFrameGlow:setAlpha(0)
			f20_local2(f20_arg0.FrontendFrameGlow)
		end,
		LoseFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(3)
			local f24_local0 = function(f25_arg0)
				f24_arg0.FocusGlow:beginAnimation(100)
				f24_arg0.FocusGlow:setAlpha(0)
				f24_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.FocusGlow:completeAnimation()
			f24_arg0.FocusGlow:setAlpha(1)
			f24_local0(f24_arg0.FocusGlow)
			local f24_local1 = function(f26_arg0)
				f24_arg0.FrontendFrameThin:beginAnimation(100)
				f24_arg0.FrontendFrameThin:setAlpha(0.5)
				f24_arg0.FrontendFrameThin:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.FrontendFrameThin:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.FrontendFrameThin:completeAnimation()
			f24_arg0.FrontendFrameThin:setAlpha(1)
			f24_local1(f24_arg0.FrontendFrameThin)
			local f24_local2 = function(f27_arg0)
				f24_arg0.FrontendFrameGlow:beginAnimation(100)
				f24_arg0.FrontendFrameGlow:setAlpha(0)
				f24_arg0.FrontendFrameGlow:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.FrontendFrameGlow:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.FrontendFrameGlow:completeAnimation()
			f24_arg0.FrontendFrameGlow:setAlpha(1)
			f24_local2(f24_arg0.FrontendFrameGlow)
		end,
	},
	Hidden = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(5)
			f28_arg0.FocusGlow:completeAnimation()
			f28_arg0.FocusGlow:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.FocusGlow)
			f28_arg0.backing:completeAnimation()
			f28_arg0.backing:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.backing)
			f28_arg0.ItemImage:completeAnimation()
			f28_arg0.ItemImage:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.ItemImage)
			f28_arg0.EquippedMarkerTick:completeAnimation()
			f28_arg0.EquippedMarkerTick:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.EquippedMarkerTick)
			f28_arg0.FrontendFrameThin:completeAnimation()
			f28_arg0.FrontendFrameThin:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.FrontendFrameThin)
		end,
	},
	Unavailable = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(3)
			f29_arg0.ItemImage:completeAnimation()
			f29_arg0.ItemImage:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.ItemImage)
			f29_arg0.EquippedMarkerTick:completeAnimation()
			f29_arg0.EquippedMarkerTick:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.EquippedMarkerTick)
			f29_arg0.FrontendFrameThin:completeAnimation()
			f29_arg0.FrontendFrameThin:setAlpha(0.5)
			f29_arg0.clipFinished(f29_arg0.FrontendFrameThin)
		end,
		Focus = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(4)
			f30_arg0.FocusGlow:completeAnimation()
			f30_arg0.FocusGlow:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.FocusGlow)
			f30_arg0.ItemImage:completeAnimation()
			f30_arg0.ItemImage:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.ItemImage)
			f30_arg0.EquippedMarkerTick:completeAnimation()
			f30_arg0.EquippedMarkerTick:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.EquippedMarkerTick)
			f30_arg0.FrontendFrameGlow:completeAnimation()
			f30_arg0.FrontendFrameGlow:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.FrontendFrameGlow)
		end,
		GainFocus = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(5)
			local f31_local0 = function(f32_arg0)
				f31_arg0.FocusGlow:beginAnimation(100)
				f31_arg0.FocusGlow:setAlpha(1)
				f31_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.FocusGlow:completeAnimation()
			f31_arg0.FocusGlow:setAlpha(0)
			f31_local0(f31_arg0.FocusGlow)
			f31_arg0.ItemImage:completeAnimation()
			f31_arg0.ItemImage:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.ItemImage)
			f31_arg0.EquippedMarkerTick:completeAnimation()
			f31_arg0.EquippedMarkerTick:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.EquippedMarkerTick)
			local f31_local1 = function(f33_arg0)
				f31_arg0.FrontendFrameThin:beginAnimation(100)
				f31_arg0.FrontendFrameThin:setAlpha(1)
				f31_arg0.FrontendFrameThin:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.FrontendFrameThin:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.FrontendFrameThin:completeAnimation()
			f31_arg0.FrontendFrameThin:setAlpha(0.5)
			f31_local1(f31_arg0.FrontendFrameThin)
			local f31_local2 = function(f34_arg0)
				f31_arg0.FrontendFrameGlow:beginAnimation(150)
				f31_arg0.FrontendFrameGlow:setAlpha(1)
				f31_arg0.FrontendFrameGlow:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.FrontendFrameGlow:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.FrontendFrameGlow:completeAnimation()
			f31_arg0.FrontendFrameGlow:setAlpha(0)
			f31_local2(f31_arg0.FrontendFrameGlow)
		end,
		LoseFocus = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(5)
			local f35_local0 = function(f36_arg0)
				f35_arg0.FocusGlow:beginAnimation(100)
				f35_arg0.FocusGlow:setAlpha(0)
				f35_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.FocusGlow:completeAnimation()
			f35_arg0.FocusGlow:setAlpha(1)
			f35_local0(f35_arg0.FocusGlow)
			f35_arg0.ItemImage:completeAnimation()
			f35_arg0.ItemImage:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.ItemImage)
			f35_arg0.EquippedMarkerTick:completeAnimation()
			f35_arg0.EquippedMarkerTick:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.EquippedMarkerTick)
			local f35_local1 = function(f37_arg0)
				f35_arg0.FrontendFrameThin:beginAnimation(100)
				f35_arg0.FrontendFrameThin:setAlpha(0.5)
				f35_arg0.FrontendFrameThin:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.FrontendFrameThin:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.FrontendFrameThin:completeAnimation()
			f35_arg0.FrontendFrameThin:setAlpha(1)
			f35_local1(f35_arg0.FrontendFrameThin)
			local f35_local2 = function(f38_arg0)
				f35_arg0.FrontendFrameGlow:beginAnimation(100)
				f35_arg0.FrontendFrameGlow:setAlpha(0)
				f35_arg0.FrontendFrameGlow:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.FrontendFrameGlow:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.FrontendFrameGlow:completeAnimation()
			f35_arg0.FrontendFrameGlow:setAlpha(1)
			f35_local2(f35_arg0.FrontendFrameGlow)
		end,
	},
	NotOwned = {
		DefaultClip = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(4)
			f39_arg0.ItemImage:completeAnimation()
			f39_arg0.ItemImage:setAlpha(0.7)
			f39_arg0.clipFinished(f39_arg0.ItemImage)
			f39_arg0.EquippedMarkerTick:completeAnimation()
			f39_arg0.EquippedMarkerTick:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.EquippedMarkerTick)
			f39_arg0.FrontendFrameThin:completeAnimation()
			f39_arg0.FrontendFrameThin:setAlpha(0.5)
			f39_arg0.clipFinished(f39_arg0.FrontendFrameThin)
			f39_arg0.caclock:completeAnimation()
			f39_arg0.caclock:setAlpha(1)
			f39_arg0.clipFinished(f39_arg0.caclock)
		end,
		Focus = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(5)
			f40_arg0.FocusGlow:completeAnimation()
			f40_arg0.FocusGlow:setAlpha(1)
			f40_arg0.clipFinished(f40_arg0.FocusGlow)
			f40_arg0.ItemImage:completeAnimation()
			f40_arg0.ItemImage:setAlpha(0.7)
			f40_arg0.clipFinished(f40_arg0.ItemImage)
			f40_arg0.EquippedMarkerTick:completeAnimation()
			f40_arg0.EquippedMarkerTick:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.EquippedMarkerTick)
			f40_arg0.FrontendFrameGlow:completeAnimation()
			f40_arg0.FrontendFrameGlow:setAlpha(1)
			f40_arg0.clipFinished(f40_arg0.FrontendFrameGlow)
			f40_arg0.caclock:completeAnimation()
			f40_arg0.caclock:setAlpha(1)
			f40_arg0.clipFinished(f40_arg0.caclock)
		end,
		GainFocus = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(6)
			local f41_local0 = function(f42_arg0)
				f41_arg0.FocusGlow:beginAnimation(100)
				f41_arg0.FocusGlow:setAlpha(1)
				f41_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f41_arg0.clipInterrupted)
				f41_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f41_arg0.clipFinished)
			end
			f41_arg0.FocusGlow:completeAnimation()
			f41_arg0.FocusGlow:setAlpha(0)
			f41_local0(f41_arg0.FocusGlow)
			f41_arg0.ItemImage:completeAnimation()
			f41_arg0.ItemImage:setAlpha(0.7)
			f41_arg0.clipFinished(f41_arg0.ItemImage)
			f41_arg0.EquippedMarkerTick:completeAnimation()
			f41_arg0.EquippedMarkerTick:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.EquippedMarkerTick)
			local f41_local1 = function(f43_arg0)
				f41_arg0.FrontendFrameThin:beginAnimation(100)
				f41_arg0.FrontendFrameThin:setAlpha(1)
				f41_arg0.FrontendFrameThin:registerEventHandler("interrupted_keyframe", f41_arg0.clipInterrupted)
				f41_arg0.FrontendFrameThin:registerEventHandler("transition_complete_keyframe", f41_arg0.clipFinished)
			end
			f41_arg0.FrontendFrameThin:completeAnimation()
			f41_arg0.FrontendFrameThin:setAlpha(0.5)
			f41_local1(f41_arg0.FrontendFrameThin)
			local f41_local2 = function(f44_arg0)
				f41_arg0.FrontendFrameGlow:beginAnimation(150)
				f41_arg0.FrontendFrameGlow:setAlpha(1)
				f41_arg0.FrontendFrameGlow:registerEventHandler("interrupted_keyframe", f41_arg0.clipInterrupted)
				f41_arg0.FrontendFrameGlow:registerEventHandler("transition_complete_keyframe", f41_arg0.clipFinished)
			end
			f41_arg0.FrontendFrameGlow:completeAnimation()
			f41_arg0.FrontendFrameGlow:setAlpha(0)
			f41_local2(f41_arg0.FrontendFrameGlow)
			f41_arg0.caclock:completeAnimation()
			f41_arg0.caclock:setAlpha(1)
			f41_arg0.clipFinished(f41_arg0.caclock)
		end,
		LoseFocus = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(6)
			local f45_local0 = function(f46_arg0)
				f45_arg0.FocusGlow:beginAnimation(100)
				f45_arg0.FocusGlow:setAlpha(0)
				f45_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f45_arg0.clipInterrupted)
				f45_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f45_arg0.clipFinished)
			end
			f45_arg0.FocusGlow:completeAnimation()
			f45_arg0.FocusGlow:setAlpha(1)
			f45_local0(f45_arg0.FocusGlow)
			f45_arg0.ItemImage:completeAnimation()
			f45_arg0.ItemImage:setAlpha(0.7)
			f45_arg0.clipFinished(f45_arg0.ItemImage)
			f45_arg0.EquippedMarkerTick:completeAnimation()
			f45_arg0.EquippedMarkerTick:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.EquippedMarkerTick)
			local f45_local1 = function(f47_arg0)
				f45_arg0.FrontendFrameThin:beginAnimation(100)
				f45_arg0.FrontendFrameThin:setAlpha(0.5)
				f45_arg0.FrontendFrameThin:registerEventHandler("interrupted_keyframe", f45_arg0.clipInterrupted)
				f45_arg0.FrontendFrameThin:registerEventHandler("transition_complete_keyframe", f45_arg0.clipFinished)
			end
			f45_arg0.FrontendFrameThin:completeAnimation()
			f45_arg0.FrontendFrameThin:setAlpha(1)
			f45_local1(f45_arg0.FrontendFrameThin)
			local f45_local2 = function(f48_arg0)
				f45_arg0.FrontendFrameGlow:beginAnimation(100)
				f45_arg0.FrontendFrameGlow:setAlpha(0)
				f45_arg0.FrontendFrameGlow:registerEventHandler("interrupted_keyframe", f45_arg0.clipInterrupted)
				f45_arg0.FrontendFrameGlow:registerEventHandler("transition_complete_keyframe", f45_arg0.clipFinished)
			end
			f45_arg0.FrontendFrameGlow:completeAnimation()
			f45_arg0.FrontendFrameGlow:setAlpha(1)
			f45_local2(f45_arg0.FrontendFrameGlow)
			f45_arg0.caclock:completeAnimation()
			f45_arg0.caclock:setAlpha(1)
			f45_arg0.clipFinished(f45_arg0.caclock)
		end,
	},
	New = {
		DefaultClip = function(f49_arg0, f49_arg1)
			f49_arg0:__resetProperties()
			f49_arg0:setupElementClipCounter(2)
			f49_arg0.FrontendFrameThin:completeAnimation()
			f49_arg0.FrontendFrameThin:setAlpha(0.5)
			f49_arg0.clipFinished(f49_arg0.FrontendFrameThin)
			f49_arg0.BreadcrumbNew:completeAnimation()
			f49_arg0.BreadcrumbNew:setAlpha(1)
			f49_arg0.clipFinished(f49_arg0.BreadcrumbNew)
		end,
		Focus = function(f50_arg0, f50_arg1)
			f50_arg0:__resetProperties()
			f50_arg0:setupElementClipCounter(3)
			f50_arg0.FocusGlow:completeAnimation()
			f50_arg0.FocusGlow:setAlpha(1)
			f50_arg0.clipFinished(f50_arg0.FocusGlow)
			f50_arg0.FrontendFrameGlow:completeAnimation()
			f50_arg0.FrontendFrameGlow:setAlpha(1)
			f50_arg0.clipFinished(f50_arg0.FrontendFrameGlow)
			local f50_local0 = function(f51_arg0)
				local f51_local0 = function(f52_arg0)
					f52_arg0:beginAnimation(200)
					f52_arg0:setAlpha(0)
					f52_arg0:registerEventHandler("transition_complete_keyframe", f50_arg0.clipFinished)
				end
				f50_arg0.BreadcrumbNew:beginAnimation(400)
				f50_arg0.BreadcrumbNew:registerEventHandler("interrupted_keyframe", f50_arg0.clipInterrupted)
				f50_arg0.BreadcrumbNew:registerEventHandler("transition_complete_keyframe", f51_local0)
			end
			f50_arg0.BreadcrumbNew:completeAnimation()
			f50_arg0.BreadcrumbNew:setAlpha(1)
			f50_local0(f50_arg0.BreadcrumbNew)
		end,
		GainFocus = function(f53_arg0, f53_arg1)
			f53_arg0:__resetProperties()
			f53_arg0:setupElementClipCounter(4)
			local f53_local0 = function(f54_arg0)
				f53_arg0.FocusGlow:beginAnimation(100)
				f53_arg0.FocusGlow:setAlpha(1)
				f53_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f53_arg0.clipInterrupted)
				f53_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f53_arg0.clipFinished)
			end
			f53_arg0.FocusGlow:completeAnimation()
			f53_arg0.FocusGlow:setAlpha(0)
			f53_local0(f53_arg0.FocusGlow)
			local f53_local1 = function(f55_arg0)
				f53_arg0.FrontendFrameThin:beginAnimation(100)
				f53_arg0.FrontendFrameThin:setAlpha(1)
				f53_arg0.FrontendFrameThin:registerEventHandler("interrupted_keyframe", f53_arg0.clipInterrupted)
				f53_arg0.FrontendFrameThin:registerEventHandler("transition_complete_keyframe", f53_arg0.clipFinished)
			end
			f53_arg0.FrontendFrameThin:completeAnimation()
			f53_arg0.FrontendFrameThin:setAlpha(0.5)
			f53_local1(f53_arg0.FrontendFrameThin)
			local f53_local2 = function(f56_arg0)
				f53_arg0.FrontendFrameGlow:beginAnimation(150)
				f53_arg0.FrontendFrameGlow:setAlpha(1)
				f53_arg0.FrontendFrameGlow:registerEventHandler("interrupted_keyframe", f53_arg0.clipInterrupted)
				f53_arg0.FrontendFrameGlow:registerEventHandler("transition_complete_keyframe", f53_arg0.clipFinished)
			end
			f53_arg0.FrontendFrameGlow:completeAnimation()
			f53_arg0.FrontendFrameGlow:setAlpha(0)
			f53_local2(f53_arg0.FrontendFrameGlow)
			f53_arg0.BreadcrumbNew:completeAnimation()
			f53_arg0.BreadcrumbNew:setAlpha(1)
			f53_arg0.clipFinished(f53_arg0.BreadcrumbNew)
		end,
		LoseFocus = function(f57_arg0, f57_arg1)
			f57_arg0:__resetProperties()
			f57_arg0:setupElementClipCounter(4)
			local f57_local0 = function(f58_arg0)
				f57_arg0.FocusGlow:beginAnimation(100)
				f57_arg0.FocusGlow:setAlpha(0)
				f57_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f57_arg0.clipInterrupted)
				f57_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f57_arg0.clipFinished)
			end
			f57_arg0.FocusGlow:completeAnimation()
			f57_arg0.FocusGlow:setAlpha(1)
			f57_local0(f57_arg0.FocusGlow)
			local f57_local1 = function(f59_arg0)
				f57_arg0.FrontendFrameThin:beginAnimation(100)
				f57_arg0.FrontendFrameThin:setAlpha(0.5)
				f57_arg0.FrontendFrameThin:registerEventHandler("interrupted_keyframe", f57_arg0.clipInterrupted)
				f57_arg0.FrontendFrameThin:registerEventHandler("transition_complete_keyframe", f57_arg0.clipFinished)
			end
			f57_arg0.FrontendFrameThin:completeAnimation()
			f57_arg0.FrontendFrameThin:setAlpha(1)
			f57_local1(f57_arg0.FrontendFrameThin)
			local f57_local2 = function(f60_arg0)
				f57_arg0.FrontendFrameGlow:beginAnimation(100)
				f57_arg0.FrontendFrameGlow:setAlpha(0)
				f57_arg0.FrontendFrameGlow:registerEventHandler("interrupted_keyframe", f57_arg0.clipInterrupted)
				f57_arg0.FrontendFrameGlow:registerEventHandler("transition_complete_keyframe", f57_arg0.clipFinished)
			end
			f57_arg0.FrontendFrameGlow:completeAnimation()
			f57_arg0.FrontendFrameGlow:setAlpha(1)
			f57_local2(f57_arg0.FrontendFrameGlow)
			f57_arg0.BreadcrumbNew:completeAnimation()
			f57_arg0.BreadcrumbNew:setAlpha(1)
			f57_arg0.clipFinished(f57_arg0.BreadcrumbNew)
		end,
	},
}
CoD.SpecialistOutfitItemEntry_Internal.__onClose = function(f61_arg0)
	f61_arg0.backing:close()
	f61_arg0.ItemImage:close()
	f61_arg0.EquippedMarkerTick:close()
	f61_arg0.CommonCornerPips:close()
	f61_arg0.FrontendFrameThin:close()
	f61_arg0.caclock:close()
	f61_arg0.BreadcrumbNew:close()
end
