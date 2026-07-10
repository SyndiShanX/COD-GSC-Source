require("x64:94acc3cb318e13b")
require("x64:eeba57f916954d1")
require("x64:8ffe7c4e01e7052")
require("x64:5f8cf56752aa71b")
CoD.EmblemIconNew_Internal = InheritFrom(LUI.UIElement)
CoD.EmblemIconNew_Internal.__defaultWidth = 144
CoD.EmblemIconNew_Internal.__defaultHeight = 144
CoD.EmblemIconNew_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmblemIconNew_Internal)
	self.id = "EmblemIconNew_Internal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BlackBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlackBacking:setRGB(0, 0, 0)
	BlackBacking:setAlpha(0.95)
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
	local SelectorOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SelectorOverlay:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	SelectorOverlay:setAlpha(0.01)
	self:addElement(SelectorOverlay)
	self.SelectorOverlay = SelectorOverlay
	local FrameBorder = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrameBorder:setAlpha(0.15)
	FrameBorder:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrameBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrameBorder:setShaderVector(0, 0, 0, 0, 0)
	FrameBorder:setupNineSliceShader(12, 12)
	self:addElement(FrameBorder)
	self.FrameBorder = FrameBorder
	local drawPaintshop = LUI.UIElement.new(0, 1, 6, -6, 0, 1, 6, -6)
	drawPaintshop:setAlpha(0)
	drawPaintshop:linkToElementModel(self, "iconID", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			drawPaintshop:setupDrawDecalById(f2_local0)
		end
	end)
	self:addElement(drawPaintshop)
	self.drawPaintshop = drawPaintshop
	local IconNew = CoD.ItemNewBreadcrumbWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -81, 81, 0.5, 0.5, -18, 18)
	IconNew:setAlpha(0)
	self:addElement(IconNew)
	self.IconNew = IconNew
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
	self.__defaultFocus = CommonButtonOutline
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EmblemIconNew_Internal.__resetProperties = function(f7_arg0)
	f7_arg0.drawPaintshop:completeAnimation()
	f7_arg0.SelectorOverlay:completeAnimation()
	f7_arg0.LockIcon:completeAnimation()
	f7_arg0.IconNew:completeAnimation()
	f7_arg0.drawPaintshop:setRGB(1, 1, 1)
	f7_arg0.drawPaintshop:setAlpha(0)
	f7_arg0.SelectorOverlay:setAlpha(0.01)
	f7_arg0.LockIcon:setAlpha(0)
	f7_arg0.IconNew:setAlpha(0)
end
CoD.EmblemIconNew_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.drawPaintshop:completeAnimation()
			f8_arg0.drawPaintshop:setAlpha(0.8)
			f8_arg0.clipFinished(f8_arg0.drawPaintshop)
		end,
		ChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.SelectorOverlay:completeAnimation()
			f9_arg0.SelectorOverlay:setAlpha(0.04)
			f9_arg0.clipFinished(f9_arg0.SelectorOverlay)
			f9_arg0.drawPaintshop:completeAnimation()
			f9_arg0.drawPaintshop:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.drawPaintshop)
		end,
		GainChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			local f10_local0 = function(f11_arg0)
				f10_arg0.SelectorOverlay:beginAnimation(200)
				f10_arg0.SelectorOverlay:setAlpha(0.04)
				f10_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.SelectorOverlay:completeAnimation()
			f10_arg0.SelectorOverlay:setAlpha(0.01)
			f10_local0(f10_arg0.SelectorOverlay)
			local f10_local1 = function(f12_arg0)
				f10_arg0.drawPaintshop:beginAnimation(200)
				f10_arg0.drawPaintshop:setAlpha(1)
				f10_arg0.drawPaintshop:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.drawPaintshop:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.drawPaintshop:completeAnimation()
			f10_arg0.drawPaintshop:setAlpha(0.8)
			f10_local1(f10_arg0.drawPaintshop)
		end,
		LoseChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			local f13_local0 = function(f14_arg0)
				f13_arg0.SelectorOverlay:beginAnimation(200)
				f13_arg0.SelectorOverlay:setAlpha(0.01)
				f13_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.SelectorOverlay:completeAnimation()
			f13_arg0.SelectorOverlay:setAlpha(0.04)
			f13_local0(f13_arg0.SelectorOverlay)
			local f13_local1 = function(f15_arg0)
				f13_arg0.drawPaintshop:beginAnimation(200)
				f13_arg0.drawPaintshop:setAlpha(0.8)
				f13_arg0.drawPaintshop:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.drawPaintshop:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.drawPaintshop:completeAnimation()
			f13_arg0.drawPaintshop:setAlpha(1)
			f13_local1(f13_arg0.drawPaintshop)
		end,
	},
	Locked = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.drawPaintshop:completeAnimation()
			f16_arg0.drawPaintshop:setRGB(0.29, 0.29, 0.29)
			f16_arg0.drawPaintshop:setAlpha(0.5)
			f16_arg0.clipFinished(f16_arg0.drawPaintshop)
			f16_arg0.LockIcon:completeAnimation()
			f16_arg0.LockIcon:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.LockIcon)
		end,
		ChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			f17_arg0.SelectorOverlay:completeAnimation()
			f17_arg0.SelectorOverlay:setAlpha(0.04)
			f17_arg0.clipFinished(f17_arg0.SelectorOverlay)
			f17_arg0.drawPaintshop:completeAnimation()
			f17_arg0.drawPaintshop:setRGB(0.49, 0.49, 0.49)
			f17_arg0.drawPaintshop:setAlpha(0.8)
			f17_arg0.clipFinished(f17_arg0.drawPaintshop)
			f17_arg0.LockIcon:completeAnimation()
			f17_arg0.LockIcon:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.LockIcon)
		end,
		GainChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			local f18_local0 = function(f19_arg0)
				f18_arg0.SelectorOverlay:beginAnimation(200)
				f18_arg0.SelectorOverlay:setAlpha(0.04)
				f18_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.SelectorOverlay:completeAnimation()
			f18_arg0.SelectorOverlay:setAlpha(0.01)
			f18_local0(f18_arg0.SelectorOverlay)
			local f18_local1 = function(f20_arg0)
				f18_arg0.drawPaintshop:beginAnimation(200)
				f18_arg0.drawPaintshop:setRGB(0.49, 0.49, 0.49)
				f18_arg0.drawPaintshop:setAlpha(1)
				f18_arg0.drawPaintshop:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.drawPaintshop:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.drawPaintshop:completeAnimation()
			f18_arg0.drawPaintshop:setRGB(0.29, 0.29, 0.29)
			f18_arg0.drawPaintshop:setAlpha(0.8)
			f18_local1(f18_arg0.drawPaintshop)
			f18_arg0.LockIcon:completeAnimation()
			f18_arg0.LockIcon:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.LockIcon)
		end,
		LoseChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			local f21_local0 = function(f22_arg0)
				f21_arg0.SelectorOverlay:beginAnimation(200)
				f21_arg0.SelectorOverlay:setAlpha(0.01)
				f21_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.SelectorOverlay:completeAnimation()
			f21_arg0.SelectorOverlay:setAlpha(0.04)
			f21_local0(f21_arg0.SelectorOverlay)
			local f21_local1 = function(f23_arg0)
				f21_arg0.drawPaintshop:beginAnimation(200)
				f21_arg0.drawPaintshop:setRGB(0.29, 0.29, 0.29)
				f21_arg0.drawPaintshop:setAlpha(0.8)
				f21_arg0.drawPaintshop:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.drawPaintshop:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.drawPaintshop:completeAnimation()
			f21_arg0.drawPaintshop:setRGB(0.49, 0.49, 0.49)
			f21_arg0.drawPaintshop:setAlpha(0.5)
			f21_local1(f21_arg0.drawPaintshop)
			f21_arg0.LockIcon:completeAnimation()
			f21_arg0.LockIcon:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.LockIcon)
		end,
	},
	New = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.drawPaintshop:completeAnimation()
			f24_arg0.drawPaintshop:setAlpha(0.8)
			f24_arg0.clipFinished(f24_arg0.drawPaintshop)
			f24_arg0.IconNew:completeAnimation()
			f24_arg0.IconNew:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.IconNew)
		end,
		ChildFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(3)
			f25_arg0.SelectorOverlay:completeAnimation()
			f25_arg0.SelectorOverlay:setAlpha(0.04)
			f25_arg0.clipFinished(f25_arg0.SelectorOverlay)
			f25_arg0.drawPaintshop:completeAnimation()
			f25_arg0.drawPaintshop:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.drawPaintshop)
			local f25_local0 = function(f26_arg0)
				local f26_local0 = function(f27_arg0)
					f27_arg0:beginAnimation(200)
					f27_arg0:setAlpha(0)
					f27_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
				end
				f25_arg0.IconNew:beginAnimation(400)
				f25_arg0.IconNew:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.IconNew:registerEventHandler("transition_complete_keyframe", f26_local0)
			end
			f25_arg0.IconNew:completeAnimation()
			f25_arg0.IconNew:setAlpha(1)
			f25_local0(f25_arg0.IconNew)
		end,
		LoseChildFocus = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(3)
			local f28_local0 = function(f29_arg0)
				f28_arg0.SelectorOverlay:beginAnimation(200)
				f28_arg0.SelectorOverlay:setAlpha(0.01)
				f28_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.SelectorOverlay:completeAnimation()
			f28_arg0.SelectorOverlay:setAlpha(0.04)
			f28_local0(f28_arg0.SelectorOverlay)
			f28_arg0.drawPaintshop:completeAnimation()
			f28_arg0.drawPaintshop:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.drawPaintshop)
			f28_arg0.IconNew:completeAnimation()
			f28_arg0.IconNew:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.IconNew)
		end,
		GainChildFocus = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(3)
			local f30_local0 = function(f31_arg0)
				f30_arg0.SelectorOverlay:beginAnimation(200)
				f30_arg0.SelectorOverlay:setAlpha(0.04)
				f30_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.SelectorOverlay:completeAnimation()
			f30_arg0.SelectorOverlay:setAlpha(0.01)
			f30_local0(f30_arg0.SelectorOverlay)
			f30_arg0.drawPaintshop:completeAnimation()
			f30_arg0.drawPaintshop:setAlpha(0.8)
			f30_arg0.clipFinished(f30_arg0.drawPaintshop)
			f30_arg0.IconNew:completeAnimation()
			f30_arg0.IconNew:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.IconNew)
		end,
	},
}
CoD.EmblemIconNew_Internal.__onClose = function(f32_arg0)
	f32_arg0.drawPaintshop:close()
	f32_arg0.IconNew:close()
	f32_arg0.CommonButtonOutline:close()
	f32_arg0.caclock:close()
	f32_arg0.LockIcon:close()
end
