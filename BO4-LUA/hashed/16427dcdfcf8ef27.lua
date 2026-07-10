require("x64:5f8cf56752aa71b")
CoD.PaintjobPersonalizationSlotInternal = InheritFrom(LUI.UIElement)
CoD.PaintjobPersonalizationSlotInternal.__defaultWidth = 112
CoD.PaintjobPersonalizationSlotInternal.__defaultHeight = 80
CoD.PaintjobPersonalizationSlotInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PaintjobPersonalizationSlotInternal)
	self.id = "PaintjobPersonalizationSlotInternal"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0.25, 0.25, 0.25)
	self:addElement(Backing)
	self.Backing = Backing
	local DrawPaintjob = LUI.UIElement.new(0, 1, 0, 0, 0, 1, 0, 0)
	DrawPaintjob:setAlpha(0)
	DrawPaintjob:setupPaintjobCustomizationType(Enum[0x63E5ADF9D95FC86][0x4E4802F1ABF1844])
	self:addElement(DrawPaintjob)
	self.DrawPaintjob = DrawPaintjob
	local PlusIcon = LUI.UIImage.new(0.5, 0.5, -12, 12, 0.5, 0.5, -12, 12)
	PlusIcon:setAlpha(0)
	PlusIcon:setImage(RegisterImage(0x1B97A54D41F4B80))
	self:addElement(PlusIcon)
	self.PlusIcon = PlusIcon
	local NoneText = LUI.UIText.new(0, 0, 0, 112, 0, 0, 28, 52)
	NoneText:setAlpha(0)
	NoneText:setText(Engine[0xF9F1239CFD921FE](0x1EFDF7772FC1BF1))
	NoneText:setTTF("default")
	NoneText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	NoneText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(NoneText)
	self.NoneText = NoneText
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, -1, 1, 0, 1, 0, 0)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	local EquippedMarkerBG = LUI.UIImage.new(1, 1, -35, 9, 0, 0, -8, 36)
	EquippedMarkerBG:setAlpha(0)
	EquippedMarkerBG:setZoom(4)
	EquippedMarkerBG:setImage(RegisterImage(0x7AF532D84DE505A))
	EquippedMarkerBG:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(EquippedMarkerBG)
	self.EquippedMarkerBG = EquippedMarkerBG
	local EquippedMarkerTick = LUI.UIImage.new(1, 1, -35, 9, 0, 0, -8, 36)
	EquippedMarkerTick:setAlpha(0)
	EquippedMarkerTick:setZoom(4)
	EquippedMarkerTick:setImage(RegisterImage(0x9A8B26C9B001758))
	self:addElement(EquippedMarkerTick)
	self.EquippedMarkerTick = EquippedMarkerTick
	self.DrawPaintjob:linkToElementModel(self, "paintjobSlot", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			DrawPaintjob:setupPaintjobSlot(f2_local0)
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "CreateNew",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "ref", "paintjob_create")
			end,
		},
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.WeaponOptionsUtility.IsWeaponOptionEquipped(menu, element, f1_arg1, "paintjobSlot")
			end,
		},
		{
			stateName = "Paintjob",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "paintjobSlot", Enum[0xCA3F54D92F45B45][0x60CAA8D66ED63A5])
			end,
		},
		{
			stateName = "None",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "ref", "paintjob_none")
			end,
		},
	})
	self:linkToElementModel(self, "ref", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "ref",
		})
	end)
	self:linkToElementModel(self, "paintjobSlot", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "paintjobSlot",
		})
	end)
	CommonButtonOutline.id = "CommonButtonOutline"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PaintjobPersonalizationSlotInternal.__resetProperties = function(f9_arg0)
	f9_arg0.CommonButtonOutline:completeAnimation()
	f9_arg0.PlusIcon:completeAnimation()
	f9_arg0.DrawPaintjob:completeAnimation()
	f9_arg0.EquippedMarkerBG:completeAnimation()
	f9_arg0.EquippedMarkerTick:completeAnimation()
	f9_arg0.NoneText:completeAnimation()
	f9_arg0.CommonButtonOutline:setAlpha(1)
	f9_arg0.PlusIcon:setAlpha(0)
	f9_arg0.DrawPaintjob:setAlpha(0)
	f9_arg0.EquippedMarkerBG:setAlpha(0)
	f9_arg0.EquippedMarkerTick:setAlpha(0)
	f9_arg0.NoneText:setAlpha(0)
end
CoD.PaintjobPersonalizationSlotInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.CommonButtonOutline:completeAnimation()
			f10_arg0.CommonButtonOutline:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.CommonButtonOutline)
		end,
		ChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.CommonButtonOutline:completeAnimation()
			f11_arg0.CommonButtonOutline:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.CommonButtonOutline)
		end,
		GainChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.CommonButtonOutline:completeAnimation()
			f12_arg0.CommonButtonOutline:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.CommonButtonOutline)
		end,
		LoseChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.CommonButtonOutline:completeAnimation()
			f13_arg0.CommonButtonOutline:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.CommonButtonOutline)
		end,
	},
	CreateNew = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.PlusIcon:completeAnimation()
			f14_arg0.PlusIcon:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.PlusIcon)
			f14_arg0.CommonButtonOutline:completeAnimation()
			f14_arg0.CommonButtonOutline:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.CommonButtonOutline)
		end,
		ChildFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.PlusIcon:completeAnimation()
			f15_arg0.PlusIcon:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.PlusIcon)
			f15_arg0.CommonButtonOutline:completeAnimation()
			f15_arg0.CommonButtonOutline:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.CommonButtonOutline)
		end,
		GainChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.PlusIcon:completeAnimation()
			f16_arg0.PlusIcon:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.PlusIcon)
			f16_arg0.CommonButtonOutline:completeAnimation()
			f16_arg0.CommonButtonOutline:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.CommonButtonOutline)
		end,
		LoseChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			f17_arg0.PlusIcon:completeAnimation()
			f17_arg0.PlusIcon:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.PlusIcon)
			f17_arg0.CommonButtonOutline:completeAnimation()
			f17_arg0.CommonButtonOutline:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.CommonButtonOutline)
		end,
	},
	Equipped = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(4)
			f18_arg0.DrawPaintjob:completeAnimation()
			f18_arg0.DrawPaintjob:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.DrawPaintjob)
			f18_arg0.CommonButtonOutline:completeAnimation()
			f18_arg0.CommonButtonOutline:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.CommonButtonOutline)
			f18_arg0.EquippedMarkerBG:completeAnimation()
			f18_arg0.EquippedMarkerBG:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.EquippedMarkerBG)
			f18_arg0.EquippedMarkerTick:completeAnimation()
			f18_arg0.EquippedMarkerTick:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.EquippedMarkerTick)
		end,
		ChildFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(4)
			f19_arg0.DrawPaintjob:completeAnimation()
			f19_arg0.DrawPaintjob:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.DrawPaintjob)
			f19_arg0.CommonButtonOutline:completeAnimation()
			f19_arg0.CommonButtonOutline:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.CommonButtonOutline)
			f19_arg0.EquippedMarkerBG:completeAnimation()
			f19_arg0.EquippedMarkerBG:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.EquippedMarkerBG)
			f19_arg0.EquippedMarkerTick:completeAnimation()
			f19_arg0.EquippedMarkerTick:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.EquippedMarkerTick)
		end,
		GainChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(4)
			f20_arg0.DrawPaintjob:completeAnimation()
			f20_arg0.DrawPaintjob:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.DrawPaintjob)
			f20_arg0.CommonButtonOutline:completeAnimation()
			f20_arg0.CommonButtonOutline:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.CommonButtonOutline)
			f20_arg0.EquippedMarkerBG:completeAnimation()
			f20_arg0.EquippedMarkerBG:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.EquippedMarkerBG)
			f20_arg0.EquippedMarkerTick:completeAnimation()
			f20_arg0.EquippedMarkerTick:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.EquippedMarkerTick)
		end,
		LoseChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(4)
			f21_arg0.DrawPaintjob:completeAnimation()
			f21_arg0.DrawPaintjob:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.DrawPaintjob)
			f21_arg0.CommonButtonOutline:completeAnimation()
			f21_arg0.CommonButtonOutline:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.CommonButtonOutline)
			f21_arg0.EquippedMarkerBG:completeAnimation()
			f21_arg0.EquippedMarkerBG:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.EquippedMarkerBG)
			f21_arg0.EquippedMarkerTick:completeAnimation()
			f21_arg0.EquippedMarkerTick:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.EquippedMarkerTick)
		end,
	},
	Paintjob = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.DrawPaintjob:completeAnimation()
			f22_arg0.DrawPaintjob:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.DrawPaintjob)
			f22_arg0.CommonButtonOutline:completeAnimation()
			f22_arg0.CommonButtonOutline:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.CommonButtonOutline)
		end,
		ChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			f23_arg0.DrawPaintjob:completeAnimation()
			f23_arg0.DrawPaintjob:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.DrawPaintjob)
			f23_arg0.CommonButtonOutline:completeAnimation()
			f23_arg0.CommonButtonOutline:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.CommonButtonOutline)
		end,
		GainChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.DrawPaintjob:completeAnimation()
			f24_arg0.DrawPaintjob:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.DrawPaintjob)
			f24_arg0.CommonButtonOutline:completeAnimation()
			f24_arg0.CommonButtonOutline:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.CommonButtonOutline)
		end,
		LoseChildFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(2)
			f25_arg0.DrawPaintjob:completeAnimation()
			f25_arg0.DrawPaintjob:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.DrawPaintjob)
			f25_arg0.CommonButtonOutline:completeAnimation()
			f25_arg0.CommonButtonOutline:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.CommonButtonOutline)
		end,
	},
	None = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(2)
			f26_arg0.NoneText:completeAnimation()
			f26_arg0.NoneText:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.NoneText)
			f26_arg0.CommonButtonOutline:completeAnimation()
			f26_arg0.CommonButtonOutline:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.CommonButtonOutline)
		end,
		ChildFocus = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(2)
			f27_arg0.NoneText:completeAnimation()
			f27_arg0.NoneText:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.NoneText)
			f27_arg0.CommonButtonOutline:completeAnimation()
			f27_arg0.CommonButtonOutline:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.CommonButtonOutline)
		end,
		GainChildFocus = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(2)
			f28_arg0.NoneText:completeAnimation()
			f28_arg0.NoneText:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.NoneText)
			f28_arg0.CommonButtonOutline:completeAnimation()
			f28_arg0.CommonButtonOutline:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.CommonButtonOutline)
		end,
		LoseChildFocus = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(2)
			f29_arg0.NoneText:completeAnimation()
			f29_arg0.NoneText:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.NoneText)
			f29_arg0.CommonButtonOutline:completeAnimation()
			f29_arg0.CommonButtonOutline:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.CommonButtonOutline)
		end,
	},
}
CoD.PaintjobPersonalizationSlotInternal.__onClose = function(f30_arg0)
	f30_arg0.DrawPaintjob:close()
	f30_arg0.CommonButtonOutline:close()
end
