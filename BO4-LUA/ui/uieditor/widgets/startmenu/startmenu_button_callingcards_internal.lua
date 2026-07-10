require("x64:eeba57f916954d1")
require("x64:228a7baa572b047")
require("x64:5f8cf56752aa71b")
require("x64:b9ad3e1e7c33125")
CoD.StartMenu_Button_CallingCards_Internal = InheritFrom(LUI.UIElement)
CoD.StartMenu_Button_CallingCards_Internal.__defaultWidth = 420
CoD.StartMenu_Button_CallingCards_Internal.__defaultHeight = 113
CoD.StartMenu_Button_CallingCards_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Button_CallingCards_Internal)
	self.id = "StartMenu_Button_CallingCards_Internal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NoiseTiledBacking2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking2:setAlpha(0.5)
	NoiseTiledBacking2:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking2:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking2:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking2:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking2)
	self.NoiseTiledBacking2 = NoiseTiledBacking2
	local NoiseTiledBackingAdd = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBackingAdd:setAlpha(0.2)
	NoiseTiledBackingAdd:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBackingAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	NoiseTiledBackingAdd:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBackingAdd:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBackingAdd)
	self.NoiseTiledBackingAdd = NoiseTiledBackingAdd
	local CallingCardsFrameWidget = CoD.CallingCards_FrameWidget.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CallingCardsFrameWidget:subscribeToGlobalModel(f1_arg1, "PerController", nil, function(model)
		CallingCardsFrameWidget:setModel(model, f1_arg1)
	end)
	self:addElement(CallingCardsFrameWidget)
	self.CallingCardsFrameWidget = CallingCardsFrameWidget
	local lockedIcon = CoD.cac_lock.new(f1_arg0, f1_arg1, 0.5, 0.5, -22, 22, 0.5, 0.5, -24, 24)
	lockedIcon.lockedIcon:setAlpha(0.5)
	self:addElement(lockedIcon)
	self.lockedIcon = lockedIcon
	local Spinner = LUI.UIImage.new(0.5, 0.5, -60, 60, 0.5, 0.5, -60, 60)
	Spinner:setAlpha(0)
	Spinner:setupSpinner()
	self:addElement(Spinner)
	self.Spinner = Spinner
	local Title = LUI.UIText.new(0, 0, 17.5, 326.5, 1, 1, -36.5, -3.5)
	Title:setText(Engine[0xF9F1239CFD921FE](0x55D96CC762EABDD))
	Title:setTTF("ttmussels_demibold")
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Title:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Title)
	self.Title = Title
	local Subtitle = CoD.StartMenu_Identity_SubTitle.new(f1_arg0, f1_arg1, 0, 0, 3, 551, 0, 0, 0.5, 39.5)
	Subtitle:mergeStateConditions({
		{
			stateName = "HasNew",
			condition = function(menu, element, event)
				return CoD.BreadcrumbUtility.IsAnyCallingCardsNew(menu, f1_arg1)
			end,
		},
	})
	Subtitle:linkToElementModel(Subtitle, "callingcards_general.breadcrumbCount", true, function(model)
		f1_arg0:updateElementState(Subtitle, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "callingcards_general.breadcrumbCount",
		})
	end)
	Subtitle:linkToElementModel(Subtitle, "callingcards_mp.breadcrumbCount", true, function(model)
		f1_arg0:updateElementState(Subtitle, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "callingcards_mp.breadcrumbCount",
		})
	end)
	Subtitle:linkToElementModel(Subtitle, "callingcards_zm.breadcrumbCount", true, function(model)
		f1_arg0:updateElementState(Subtitle, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "callingcards_zm.breadcrumbCount",
		})
	end)
	Subtitle:linkToElementModel(Subtitle, "callingcards_wz.breadcrumbCount", true, function(model)
		f1_arg0:updateElementState(Subtitle, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "callingcards_wz.breadcrumbCount",
		})
	end)
	Subtitle:linkToElementModel(Subtitle, "callingcards_masters.breadcrumbCount", true, function(model)
		f1_arg0:updateElementState(Subtitle, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "callingcards_masters.breadcrumbCount",
		})
	end)
	Subtitle:linkToElementModel(Subtitle, "callingcards_loot.breadcrumbCount", true, function(model)
		f1_arg0:updateElementState(Subtitle, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "callingcards_loot.breadcrumbCount",
		})
	end)
	Subtitle:linkToElementModel(Subtitle, "lootSingleSet.breadcrumbCount", true, function(model)
		f1_arg0:updateElementState(Subtitle, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "lootSingleSet.breadcrumbCount",
		})
	end)
	Subtitle:setRGB(0.92, 0.92, 0.92)
	Subtitle.SubtitleText:setText("")
	Subtitle:subscribeToGlobalModel(f1_arg1, "EmblemCallingCardBreadcrumbs", nil, function(model)
		Subtitle:setModel(model, f1_arg1)
	end)
	self:addElement(Subtitle)
	self.Subtitle = Subtitle
	local ImageText = LUI.UIText.new(0, 1, 0, 0, 0, 0, 3.5, 33.5)
	ImageText:setText("")
	ImageText:setTTF("default")
	ImageText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ImageText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(ImageText)
	self.ImageText = ImageText
	local BorderOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(BorderOutline)
	self.BorderOutline = BorderOutline
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0.92, 0.92, 0.92)
	Backing:setAlpha(0.04)
	Backing:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	Backing:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Backing)
	self.Backing = Backing
	CallingCardsFrameWidget.id = "CallingCardsFrameWidget"
	BorderOutline.id = "BorderOutline"
	self.__defaultFocus = BorderOutline
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Button_CallingCards_Internal.__resetProperties = function(f12_arg0)
	f12_arg0.lockedIcon:completeAnimation()
	f12_arg0.NoiseTiledBackingAdd:completeAnimation()
	f12_arg0.CallingCardsFrameWidget:completeAnimation()
	f12_arg0.Subtitle:completeAnimation()
	f12_arg0.Spinner:completeAnimation()
	f12_arg0.lockedIcon:setAlpha(1)
	f12_arg0.NoiseTiledBackingAdd:setAlpha(0.2)
	f12_arg0.CallingCardsFrameWidget:setRGB(1, 1, 1)
	f12_arg0.CallingCardsFrameWidget:setAlpha(1)
	f12_arg0.Subtitle:setAlpha(1)
	f12_arg0.Spinner:setAlpha(0)
end
CoD.StartMenu_Button_CallingCards_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.lockedIcon:completeAnimation()
			f13_arg0.lockedIcon:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.lockedIcon)
		end,
		ChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.NoiseTiledBackingAdd:completeAnimation()
			f14_arg0.NoiseTiledBackingAdd:setAlpha(0.5)
			f14_arg0.clipFinished(f14_arg0.NoiseTiledBackingAdd)
			f14_arg0.lockedIcon:completeAnimation()
			f14_arg0.lockedIcon:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.lockedIcon)
		end,
		GainChildFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			local f15_local0 = function(f16_arg0)
				f15_arg0.NoiseTiledBackingAdd:beginAnimation(150)
				f15_arg0.NoiseTiledBackingAdd:setAlpha(0.5)
				f15_arg0.NoiseTiledBackingAdd:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.NoiseTiledBackingAdd:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.NoiseTiledBackingAdd:completeAnimation()
			f15_arg0.NoiseTiledBackingAdd:setAlpha(0.2)
			f15_local0(f15_arg0.NoiseTiledBackingAdd)
			f15_arg0.lockedIcon:completeAnimation()
			f15_arg0.lockedIcon:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.lockedIcon)
		end,
		LoseChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			local f17_local0 = function(f18_arg0)
				f17_arg0.NoiseTiledBackingAdd:beginAnimation(150)
				f17_arg0.NoiseTiledBackingAdd:setAlpha(0.2)
				f17_arg0.NoiseTiledBackingAdd:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.NoiseTiledBackingAdd:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.NoiseTiledBackingAdd:completeAnimation()
			f17_arg0.NoiseTiledBackingAdd:setAlpha(0.5)
			f17_local0(f17_arg0.NoiseTiledBackingAdd)
			f17_arg0.lockedIcon:completeAnimation()
			f17_arg0.lockedIcon:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.lockedIcon)
		end,
	},
	Disabled = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(3)
			f19_arg0.CallingCardsFrameWidget:completeAnimation()
			f19_arg0.CallingCardsFrameWidget:setRGB(0, 0, 0)
			f19_arg0.CallingCardsFrameWidget:setAlpha(0.05)
			f19_arg0.clipFinished(f19_arg0.CallingCardsFrameWidget)
			f19_arg0.lockedIcon:completeAnimation()
			f19_arg0.lockedIcon:setAlpha(0.5)
			f19_arg0.clipFinished(f19_arg0.lockedIcon)
			f19_arg0.Subtitle:completeAnimation()
			f19_arg0.Subtitle:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.Subtitle)
		end,
	},
	Spinning = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.lockedIcon:completeAnimation()
			f20_arg0.lockedIcon:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.lockedIcon)
			f20_arg0.Spinner:completeAnimation()
			f20_arg0.Spinner:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.Spinner)
		end,
		ChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			f21_arg0.NoiseTiledBackingAdd:completeAnimation()
			f21_arg0.NoiseTiledBackingAdd:setAlpha(0.5)
			f21_arg0.clipFinished(f21_arg0.NoiseTiledBackingAdd)
			f21_arg0.lockedIcon:completeAnimation()
			f21_arg0.lockedIcon:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.lockedIcon)
			f21_arg0.Spinner:completeAnimation()
			f21_arg0.Spinner:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.Spinner)
		end,
	},
}
CoD.StartMenu_Button_CallingCards_Internal.__onClose = function(f22_arg0)
	f22_arg0.CallingCardsFrameWidget:close()
	f22_arg0.lockedIcon:close()
	f22_arg0.Subtitle:close()
	f22_arg0.BorderOutline:close()
end
