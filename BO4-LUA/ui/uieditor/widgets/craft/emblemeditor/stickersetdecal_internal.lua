require("x64:fa3f15fd69b38b3")
require("x64:94acc3cb318e13b")
require("x64:eeba57f916954d1")
require("x64:8ffe7c4e01e7052")
require("x64:5f8cf56752aa71b")
CoD.StickerSetDecal_Internal = InheritFrom(LUI.UIElement)
CoD.StickerSetDecal_Internal.__defaultWidth = 144
CoD.StickerSetDecal_Internal.__defaultHeight = 144
CoD.StickerSetDecal_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StickerSetDecal_Internal)
	self.id = "StickerSetDecal_Internal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BlackBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlackBacking:setRGB(0, 0, 0)
	BlackBacking:setAlpha(0)
	self:addElement(BlackBacking)
	self.BlackBacking = BlackBacking
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.8)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local FrameBorder = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrameBorder:setAlpha(0.15)
	FrameBorder:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrameBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrameBorder:setShaderVector(0, 0, 0, 0, 0)
	FrameBorder:setupNineSliceShader(12, 12)
	self:addElement(FrameBorder)
	self.FrameBorder = FrameBorder
	local SelectorOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SelectorOverlay:setAlpha(0.01)
	self:addElement(SelectorOverlay)
	self.SelectorOverlay = SelectorOverlay
	local drawDecal = LUI.UIElement.new(0, 1, 6, -6, 0, 1, 6, -6)
	drawDecal:setRGB(0.92, 0.92, 0.92)
	drawDecal:linkToElementModel(self, "iconID", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			drawDecal:setupDrawDecalById(f2_local0)
		end
	end)
	self:addElement(drawDecal)
	self.drawDecal = drawDecal
	local equippedIcon = LUI.UIImage.new(1, 1, -27, -6, 0, 0, 6, 27)
	equippedIcon:setRGB(0.56, 0.68, 0.27)
	equippedIcon:setAlpha(0)
	equippedIcon:setImage(RegisterImage(0xB0337CBFC61A7A2))
	self:addElement(equippedIcon)
	self.equippedIcon = equippedIcon
	local BMGoldBar = CoD.BM_GoldBarMed.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0.5, 0.5, -15, 15)
	BMGoldBar:setAlpha(0)
	self:addElement(BMGoldBar)
	self.BMGoldBar = BMGoldBar
	local BreadcrumbNew = CoD.ItemNewBreadcrumbWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -78, 78, 0.5, 0.5, -18, 18)
	BreadcrumbNew:setAlpha(0)
	self:addElement(BreadcrumbNew)
	self.BreadcrumbNew = BreadcrumbNew
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
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
	self:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return CoD.CraftUtility.IsCraftClassified(element, f1_arg1)
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
				return CoD.BreadcrumbUtility.IsDecalStickerIconNew(menu, element, f1_arg1)
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
	self:linkToElementModel(self, "iconID", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "iconID",
		})
	end)
	CommonButtonOutline.id = "CommonButtonOutline"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StickerSetDecal_Internal.__resetProperties = function(f9_arg0)
	f9_arg0.BlackBacking:completeAnimation()
	f9_arg0.SelectorOverlay:completeAnimation()
	f9_arg0.drawDecal:completeAnimation()
	f9_arg0.BMGoldBar:completeAnimation()
	f9_arg0.LockIcon:completeAnimation()
	f9_arg0.BreadcrumbNew:completeAnimation()
	f9_arg0.BlackBacking:setAlpha(0)
	f9_arg0.SelectorOverlay:setAlpha(0.01)
	f9_arg0.drawDecal:setRGB(0.92, 0.92, 0.92)
	f9_arg0.drawDecal:setAlpha(1)
	f9_arg0.BMGoldBar:setAlpha(0)
	f9_arg0.LockIcon:setAlpha(0)
	f9_arg0.BreadcrumbNew:setAlpha(0)
end
CoD.StickerSetDecal_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.BlackBacking:completeAnimation()
			f10_arg0.BlackBacking:setAlpha(0.95)
			f10_arg0.clipFinished(f10_arg0.BlackBacking)
		end,
		ChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.BlackBacking:completeAnimation()
			f11_arg0.BlackBacking:setAlpha(0.95)
			f11_arg0.clipFinished(f11_arg0.BlackBacking)
			f11_arg0.SelectorOverlay:completeAnimation()
			f11_arg0.SelectorOverlay:setAlpha(0.04)
			f11_arg0.clipFinished(f11_arg0.SelectorOverlay)
		end,
		GainChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.BlackBacking:completeAnimation()
			f12_arg0.BlackBacking:setAlpha(0.95)
			f12_arg0.clipFinished(f12_arg0.BlackBacking)
			local f12_local0 = function(f13_arg0)
				f12_arg0.SelectorOverlay:beginAnimation(200)
				f12_arg0.SelectorOverlay:setAlpha(0.04)
				f12_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.SelectorOverlay:completeAnimation()
			f12_arg0.SelectorOverlay:setAlpha(0.01)
			f12_local0(f12_arg0.SelectorOverlay)
		end,
		LoseChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.BlackBacking:completeAnimation()
			f14_arg0.BlackBacking:setAlpha(0.95)
			f14_arg0.clipFinished(f14_arg0.BlackBacking)
			local f14_local0 = function(f15_arg0)
				f14_arg0.SelectorOverlay:beginAnimation(200)
				f14_arg0.SelectorOverlay:setAlpha(0.01)
				f14_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.SelectorOverlay:completeAnimation()
			f14_arg0.SelectorOverlay:setAlpha(0.04)
			f14_local0(f14_arg0.SelectorOverlay)
		end,
	},
	Unavailable = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			f16_arg0.BlackBacking:completeAnimation()
			f16_arg0.BlackBacking:setAlpha(0.95)
			f16_arg0.clipFinished(f16_arg0.BlackBacking)
			f16_arg0.drawDecal:completeAnimation()
			f16_arg0.drawDecal:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.drawDecal)
			f16_arg0.BMGoldBar:completeAnimation()
			f16_arg0.BMGoldBar:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.BMGoldBar)
		end,
		ChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			f17_arg0.BlackBacking:completeAnimation()
			f17_arg0.BlackBacking:setAlpha(0.95)
			f17_arg0.clipFinished(f17_arg0.BlackBacking)
			f17_arg0.drawDecal:completeAnimation()
			f17_arg0.drawDecal:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.drawDecal)
			f17_arg0.BMGoldBar:completeAnimation()
			f17_arg0.BMGoldBar:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.BMGoldBar)
		end,
		GainChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			f18_arg0.BlackBacking:completeAnimation()
			f18_arg0.BlackBacking:setAlpha(0.95)
			f18_arg0.clipFinished(f18_arg0.BlackBacking)
			f18_arg0.drawDecal:completeAnimation()
			f18_arg0.drawDecal:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.drawDecal)
			f18_arg0.BMGoldBar:completeAnimation()
			f18_arg0.BMGoldBar:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.BMGoldBar)
		end,
		LoseChildFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(3)
			f19_arg0.BlackBacking:completeAnimation()
			f19_arg0.BlackBacking:setAlpha(0.95)
			f19_arg0.clipFinished(f19_arg0.BlackBacking)
			f19_arg0.drawDecal:completeAnimation()
			f19_arg0.drawDecal:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.drawDecal)
			f19_arg0.BMGoldBar:completeAnimation()
			f19_arg0.BMGoldBar:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.BMGoldBar)
		end,
	},
	Locked = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(3)
			f20_arg0.BlackBacking:completeAnimation()
			f20_arg0.BlackBacking:setAlpha(0.95)
			f20_arg0.clipFinished(f20_arg0.BlackBacking)
			f20_arg0.drawDecal:completeAnimation()
			f20_arg0.drawDecal:setRGB(0.29, 0.29, 0.29)
			f20_arg0.clipFinished(f20_arg0.drawDecal)
			f20_arg0.LockIcon:completeAnimation()
			f20_arg0.LockIcon:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.LockIcon)
		end,
		ChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			f21_arg0.BlackBacking:completeAnimation()
			f21_arg0.BlackBacking:setAlpha(0.95)
			f21_arg0.clipFinished(f21_arg0.BlackBacking)
			f21_arg0.drawDecal:completeAnimation()
			f21_arg0.drawDecal:setRGB(0.49, 0.49, 0.49)
			f21_arg0.clipFinished(f21_arg0.drawDecal)
			f21_arg0.LockIcon:completeAnimation()
			f21_arg0.LockIcon:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.LockIcon)
		end,
		GainChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(3)
			f22_arg0.BlackBacking:completeAnimation()
			f22_arg0.BlackBacking:setAlpha(0.95)
			f22_arg0.clipFinished(f22_arg0.BlackBacking)
			local f22_local0 = function(f23_arg0)
				f22_arg0.drawDecal:beginAnimation(200)
				f22_arg0.drawDecal:setRGB(0.49, 0.49, 0.49)
				f22_arg0.drawDecal:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.drawDecal:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.drawDecal:completeAnimation()
			f22_arg0.drawDecal:setRGB(0.29, 0.29, 0.29)
			f22_local0(f22_arg0.drawDecal)
			f22_arg0.LockIcon:completeAnimation()
			f22_arg0.LockIcon:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.LockIcon)
		end,
		LoseChildFoucs = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(3)
			f24_arg0.BlackBacking:completeAnimation()
			f24_arg0.BlackBacking:setAlpha(0.95)
			f24_arg0.clipFinished(f24_arg0.BlackBacking)
			local f24_local0 = function(f25_arg0)
				f24_arg0.drawDecal:beginAnimation(200)
				f24_arg0.drawDecal:setRGB(0.29, 0.29, 0.29)
				f24_arg0.drawDecal:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.drawDecal:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.drawDecal:completeAnimation()
			f24_arg0.drawDecal:setRGB(0.49, 0.49, 0.49)
			f24_local0(f24_arg0.drawDecal)
			f24_arg0.LockIcon:completeAnimation()
			f24_arg0.LockIcon:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.LockIcon)
		end,
	},
	New = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(2)
			f26_arg0.BlackBacking:completeAnimation()
			f26_arg0.BlackBacking:setAlpha(0.95)
			f26_arg0.clipFinished(f26_arg0.BlackBacking)
			f26_arg0.BreadcrumbNew:completeAnimation()
			f26_arg0.BreadcrumbNew:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.BreadcrumbNew)
		end,
		ChildFocus = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(3)
			f27_arg0.BlackBacking:completeAnimation()
			f27_arg0.BlackBacking:setAlpha(0.95)
			f27_arg0.clipFinished(f27_arg0.BlackBacking)
			f27_arg0.SelectorOverlay:completeAnimation()
			f27_arg0.SelectorOverlay:setAlpha(0.04)
			f27_arg0.clipFinished(f27_arg0.SelectorOverlay)
			local f27_local0 = function(f28_arg0)
				local f28_local0 = function(f29_arg0)
					f29_arg0:beginAnimation(200)
					f29_arg0:setAlpha(0)
					f29_arg0:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
				end
				f27_arg0.BreadcrumbNew:beginAnimation(400)
				f27_arg0.BreadcrumbNew:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.BreadcrumbNew:registerEventHandler("transition_complete_keyframe", f28_local0)
			end
			f27_arg0.BreadcrumbNew:completeAnimation()
			f27_arg0.BreadcrumbNew:setAlpha(1)
			f27_local0(f27_arg0.BreadcrumbNew)
		end,
		GainChildFocus = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(3)
			f30_arg0.BlackBacking:completeAnimation()
			f30_arg0.BlackBacking:setAlpha(0.95)
			f30_arg0.clipFinished(f30_arg0.BlackBacking)
			local f30_local0 = function(f31_arg0)
				f30_arg0.SelectorOverlay:beginAnimation(200)
				f30_arg0.SelectorOverlay:setAlpha(0.04)
				f30_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.SelectorOverlay:completeAnimation()
			f30_arg0.SelectorOverlay:setAlpha(0.01)
			f30_local0(f30_arg0.SelectorOverlay)
			f30_arg0.BreadcrumbNew:completeAnimation()
			f30_arg0.BreadcrumbNew:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.BreadcrumbNew)
		end,
		LoseChildFocus = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(2)
			f32_arg0.BlackBacking:completeAnimation()
			f32_arg0.BlackBacking:setAlpha(0.95)
			f32_arg0.clipFinished(f32_arg0.BlackBacking)
			local f32_local0 = function(f33_arg0)
				f32_arg0.SelectorOverlay:beginAnimation(200)
				f32_arg0.SelectorOverlay:setAlpha(0.01)
				f32_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.SelectorOverlay:completeAnimation()
			f32_arg0.SelectorOverlay:setAlpha(0.04)
			f32_local0(f32_arg0.SelectorOverlay)
		end,
	},
}
CoD.StickerSetDecal_Internal.__onClose = function(f34_arg0)
	f34_arg0.drawDecal:close()
	f34_arg0.BMGoldBar:close()
	f34_arg0.BreadcrumbNew:close()
	f34_arg0.CommonButtonOutline:close()
	f34_arg0.caclock:close()
	f34_arg0.LockIcon:close()
end
