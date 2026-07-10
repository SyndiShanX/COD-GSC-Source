require("x64:fa3f15fd69b38b3")
require("x64:94acc3cb318e13b")
require("x64:eeba57f916954d1")
require("x64:8ffe7c4e01e7052")
require("x64:5f8cf56752aa71b")
CoD.StickerSetBonusDecal_Internal = InheritFrom(LUI.UIElement)
CoD.StickerSetBonusDecal_Internal.__defaultWidth = 144
CoD.StickerSetBonusDecal_Internal.__defaultHeight = 144
CoD.StickerSetBonusDecal_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StickerSetBonusDecal_Internal)
	self.id = "StickerSetBonusDecal_Internal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setRGB(1, 0.78, 0)
	NoiseTiledBacking:setAlpha(0.8)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local BGAdd = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGAdd:setRGB(0.77, 0.78, 0)
	BGAdd:setAlpha(0.02)
	BGAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(BGAdd)
	self.BGAdd = BGAdd
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
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CommonButtonOutline.Lines:setAlpha(0)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	local FrameBorder = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -2, 2)
	FrameBorder:setRGB(1, 0.58, 0)
	FrameBorder:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrameBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xDAB59B2CAE01851))
	FrameBorder:setShaderVector(0, 0, 0, 0, 0)
	FrameBorder:setShaderVector(1, 1, 0, 0, 0)
	FrameBorder:setupNineSliceShader(12, 12)
	self:addElement(FrameBorder)
	self.FrameBorder = FrameBorder
	local BGGoldBar = CoD.BM_GoldBarMed.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0.5, 0.5, -15, 15)
	BGGoldBar:setAlpha(0)
	self:addElement(BGGoldBar)
	self.BGGoldBar = BGGoldBar
	local equippedIcon = LUI.UIImage.new(1, 1, -27, -6, 0, 0, 6, 27)
	equippedIcon:setRGB(0.56, 0.68, 0.27)
	equippedIcon:setAlpha(0)
	equippedIcon:setImage(RegisterImage(0xB0337CBFC61A7A2))
	self:addElement(equippedIcon)
	self.equippedIcon = equippedIcon
	local BreadcrumbNew = CoD.ItemNewBreadcrumbWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -78, 78, 0.5, 0.5, -18, 18)
	BreadcrumbNew:setAlpha(0)
	self:addElement(BreadcrumbNew)
	self.BreadcrumbNew = BreadcrumbNew
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
CoD.StickerSetBonusDecal_Internal.__resetProperties = function(f9_arg0)
	f9_arg0.drawDecal:completeAnimation()
	f9_arg0.BGGoldBar:completeAnimation()
	f9_arg0.LockIcon:completeAnimation()
	f9_arg0.BreadcrumbNew:completeAnimation()
	f9_arg0.drawDecal:setRGB(0.92, 0.92, 0.92)
	f9_arg0.drawDecal:setAlpha(1)
	f9_arg0.BGGoldBar:setAlpha(0)
	f9_arg0.LockIcon:setAlpha(0)
	f9_arg0.BreadcrumbNew:setAlpha(0)
end
CoD.StickerSetBonusDecal_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.drawDecal:completeAnimation()
			f10_arg0.drawDecal:setRGB(0.92, 0.92, 0.92)
			f10_arg0.clipFinished(f10_arg0.drawDecal)
		end,
	},
	Unavailable = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.drawDecal:completeAnimation()
			f11_arg0.drawDecal:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.drawDecal)
			f11_arg0.BGGoldBar:completeAnimation()
			f11_arg0.BGGoldBar:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.BGGoldBar)
		end,
		ChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.drawDecal:completeAnimation()
			f12_arg0.drawDecal:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.drawDecal)
			f12_arg0.BGGoldBar:completeAnimation()
			f12_arg0.BGGoldBar:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.BGGoldBar)
		end,
		GainChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.drawDecal:completeAnimation()
			f13_arg0.drawDecal:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.drawDecal)
			f13_arg0.BGGoldBar:completeAnimation()
			f13_arg0.BGGoldBar:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.BGGoldBar)
		end,
		LoseChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.drawDecal:completeAnimation()
			f14_arg0.drawDecal:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.drawDecal)
			f14_arg0.BGGoldBar:completeAnimation()
			f14_arg0.BGGoldBar:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.BGGoldBar)
		end,
	},
	Locked = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.drawDecal:completeAnimation()
			f15_arg0.drawDecal:setRGB(0.29, 0.29, 0.29)
			f15_arg0.clipFinished(f15_arg0.drawDecal)
			f15_arg0.LockIcon:completeAnimation()
			f15_arg0.LockIcon:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.LockIcon)
		end,
		ChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.drawDecal:completeAnimation()
			f16_arg0.drawDecal:setRGB(0.49, 0.49, 0.49)
			f16_arg0.clipFinished(f16_arg0.drawDecal)
			f16_arg0.LockIcon:completeAnimation()
			f16_arg0.LockIcon:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.LockIcon)
		end,
		GainChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			local f17_local0 = function(f18_arg0)
				f17_arg0.drawDecal:beginAnimation(200)
				f17_arg0.drawDecal:setRGB(0.49, 0.49, 0.49)
				f17_arg0.drawDecal:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.drawDecal:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.drawDecal:completeAnimation()
			f17_arg0.drawDecal:setRGB(0.29, 0.29, 0.29)
			f17_local0(f17_arg0.drawDecal)
			f17_arg0.LockIcon:completeAnimation()
			f17_arg0.LockIcon:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.LockIcon)
		end,
		LoseChildFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			local f19_local0 = function(f20_arg0)
				f19_arg0.drawDecal:beginAnimation(200)
				f19_arg0.drawDecal:setRGB(0.29, 0.29, 0.29)
				f19_arg0.drawDecal:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.drawDecal:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.drawDecal:completeAnimation()
			f19_arg0.drawDecal:setRGB(0.49, 0.49, 0.49)
			f19_local0(f19_arg0.drawDecal)
			f19_arg0.LockIcon:completeAnimation()
			f19_arg0.LockIcon:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.LockIcon)
		end,
	},
	New = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.BreadcrumbNew:completeAnimation()
			f21_arg0.BreadcrumbNew:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.BreadcrumbNew)
		end,
		ChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			local f22_local0 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					f24_arg0:beginAnimation(200)
					f24_arg0:setAlpha(0)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
				end
				f22_arg0.BreadcrumbNew:beginAnimation(400)
				f22_arg0.BreadcrumbNew:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.BreadcrumbNew:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f22_arg0.BreadcrumbNew:completeAnimation()
			f22_arg0.BreadcrumbNew:setAlpha(1)
			f22_local0(f22_arg0.BreadcrumbNew)
		end,
		GainChildFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			f25_arg0.BreadcrumbNew:completeAnimation()
			f25_arg0.BreadcrumbNew:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.BreadcrumbNew)
		end,
		LoseChildFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			f26_arg0.BreadcrumbNew:completeAnimation()
			f26_arg0.BreadcrumbNew:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.BreadcrumbNew)
		end,
	},
}
CoD.StickerSetBonusDecal_Internal.__onClose = function(f27_arg0)
	f27_arg0.drawDecal:close()
	f27_arg0.CommonButtonOutline:close()
	f27_arg0.BGGoldBar:close()
	f27_arg0.BreadcrumbNew:close()
	f27_arg0.caclock:close()
	f27_arg0.LockIcon:close()
end
