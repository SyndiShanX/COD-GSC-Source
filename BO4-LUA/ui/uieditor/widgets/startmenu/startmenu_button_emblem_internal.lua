require("ui/uieditor/widgets/commonbuttonoutline")
require("ui/uieditor/widgets/startmenu/startmenu_identity_subtitle")
CoD.StartMenu_Button_Emblem_Internal = InheritFrom(LUI.UIElement)
CoD.StartMenu_Button_Emblem_Internal.__defaultWidth = 555
CoD.StartMenu_Button_Emblem_Internal.__defaultHeight = 211
CoD.StartMenu_Button_Emblem_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Button_Emblem_Internal)
	self.id = "StartMenu_Button_Emblem_Internal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NoiseTiledBacking2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking2:setAlpha(0.5)
	NoiseTiledBacking2:setImage(RegisterImage("uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking2:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking2:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking2)
	self.NoiseTiledBacking2 = NoiseTiledBacking2
	local BgGrid = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BgGrid:setImage(RegisterImage("uie_ui_menu_start_menu_grid"))
	BgGrid:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1A02C44161370F6D"))
	BgGrid:setShaderVector(0, 0, 0, 0, 0)
	BgGrid:setShaderVector(1, 1, 1, 0, 0)
	BgGrid:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(BgGrid)
	self.BgGrid = BgGrid
	local NoiseTiledBackingAdd = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBackingAdd:setAlpha(0.2)
	NoiseTiledBackingAdd:setImage(RegisterImage("uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBackingAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	NoiseTiledBackingAdd:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBackingAdd:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBackingAdd)
	self.NoiseTiledBackingAdd = NoiseTiledBackingAdd
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0.92, 0.92, 0.92)
	Background:setAlpha(0.04)
	self:addElement(Background)
	self.Background = Background
	local emblem0 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(emblem0)
	self.emblem0 = emblem0
	local Title = LUI.UIText.new(0, 0, 18, 327, 1, 1, -36.5, -3.5)
	Title:setText(Engine[@"hash_4F9F1239CFD921FE"]("menu/multiplayer"))
	Title:setTTF("ttmussels_demibold")
	Title:setLetterSpacing(2)
	Title:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	Title:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(Title)
	self.Title = Title
	local Subtitle = CoD.StartMenu_Identity_SubTitle.new(f1_arg0, f1_arg1, 0, 0, 6.5, 548.5, 0, 0, 0.5, 39.5)
	Subtitle:mergeStateConditions({
		{
			stateName = "HasNew",
			condition = function(menu, element, event)
				return CoD.BreadcrumbUtility.IsAnyEmblemStickerIconNew(menu, f1_arg1)
			end,
		},
	})
	Subtitle:linkToElementModel(Subtitle, "STICKER.breadcrumbCount", true, function(model)
		f1_arg0:updateElementState(Subtitle, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "STICKER.breadcrumbCount",
		})
	end)
	Subtitle:linkToElementModel(Subtitle, "STICKERSET.breadcrumbCount", true, function(model)
		f1_arg0:updateElementState(Subtitle, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "STICKERSET.breadcrumbCount",
		})
	end)
	Subtitle:setRGB(0.92, 0.92, 0.92)
	Subtitle.SubtitleText:setText("")
	Subtitle:subscribeToGlobalModel(f1_arg1, "EmblemCallingCardBreadcrumbs", nil, function(model)
		Subtitle:setModel(model, f1_arg1)
	end)
	self:addElement(Subtitle)
	self.Subtitle = Subtitle
	local BlackLine = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -25, 24)
	BlackLine:setRGB(0, 0, 0)
	BlackLine:setAlpha(0)
	self:addElement(BlackLine)
	self.BlackLine = BlackLine
	local ButtonStateText = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -19, 18)
	ButtonStateText:setRGB(0.92, 0.92, 0.92)
	ButtonStateText:setAlpha(0)
	ButtonStateText:setText(LocalizeToUpperString(@"hash_6D135324AE818CEE"))
	ButtonStateText:setTTF("ttmussels_regular")
	ButtonStateText:setLetterSpacing(4)
	ButtonStateText:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	self:addElement(ButtonStateText)
	self.ButtonStateText = ButtonStateText
	local ImageText = LUI.UIText.new(0, 1, 0, 0, 0, 0, 0, 30)
	ImageText:setText("")
	ImageText:setTTF("default")
	ImageText:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	ImageText:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(ImageText)
	self.ImageText = ImageText
	local ButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(ButtonOutline)
	self.ButtonOutline = ButtonOutline
	ButtonOutline.id = "ButtonOutline"
	self.__defaultFocus = ButtonOutline
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Button_Emblem_Internal.__resetProperties = function(f6_arg0)
	f6_arg0.ImageText:completeAnimation()
	f6_arg0.emblem0:completeAnimation()
	f6_arg0.NoiseTiledBackingAdd:completeAnimation()
	f6_arg0.ButtonStateText:completeAnimation()
	f6_arg0.BlackLine:completeAnimation()
	f6_arg0.ImageText:setAlpha(1)
	f6_arg0.emblem0:setRGB(1, 1, 1)
	f6_arg0.emblem0:setAlpha(1)
	f6_arg0.NoiseTiledBackingAdd:setAlpha(0.2)
	f6_arg0.ButtonStateText:setAlpha(0)
	f6_arg0.BlackLine:setAlpha(0)
end
CoD.StartMenu_Button_Emblem_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.emblem0:completeAnimation()
			f7_arg0.emblem0:setRGB(0.78, 0.78, 0.78)
			f7_arg0.clipFinished(f7_arg0.emblem0)
			f7_arg0.ImageText:completeAnimation()
			f7_arg0.ImageText:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.ImageText)
		end,
		ChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.NoiseTiledBackingAdd:completeAnimation()
			f8_arg0.NoiseTiledBackingAdd:setAlpha(0.5)
			f8_arg0.clipFinished(f8_arg0.NoiseTiledBackingAdd)
		end,
		GainChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			local f9_local0 = function(f10_arg0)
				f9_arg0.NoiseTiledBackingAdd:beginAnimation(150)
				f9_arg0.NoiseTiledBackingAdd:setAlpha(0.5)
				f9_arg0.NoiseTiledBackingAdd:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.NoiseTiledBackingAdd:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.NoiseTiledBackingAdd:completeAnimation()
			f9_arg0.NoiseTiledBackingAdd:setAlpha(0.2)
			f9_local0(f9_arg0.NoiseTiledBackingAdd)
			local f9_local1 = function(f11_arg0)
				f9_arg0.emblem0:beginAnimation(150)
				f9_arg0.emblem0:setRGB(1, 1, 1)
				f9_arg0.emblem0:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.emblem0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.emblem0:completeAnimation()
			f9_arg0.emblem0:setRGB(0.78, 0.78, 0.78)
			f9_local1(f9_arg0.emblem0)
			local f9_local2 = function(f12_arg0)
				f9_arg0.ImageText:beginAnimation(150)
				f9_arg0.ImageText:setAlpha(1)
				f9_arg0.ImageText:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.ImageText:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.ImageText:completeAnimation()
			f9_arg0.ImageText:setAlpha(0)
			f9_local2(f9_arg0.ImageText)
		end,
		LoseChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			local f13_local0 = function(f14_arg0)
				f13_arg0.NoiseTiledBackingAdd:beginAnimation(150)
				f13_arg0.NoiseTiledBackingAdd:setAlpha(0.2)
				f13_arg0.NoiseTiledBackingAdd:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.NoiseTiledBackingAdd:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.NoiseTiledBackingAdd:completeAnimation()
			f13_arg0.NoiseTiledBackingAdd:setAlpha(0.5)
			f13_local0(f13_arg0.NoiseTiledBackingAdd)
			local f13_local1 = function(f15_arg0)
				f13_arg0.emblem0:beginAnimation(150)
				f13_arg0.emblem0:setRGB(0.78, 0.78, 0.78)
				f13_arg0.emblem0:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.emblem0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.emblem0:completeAnimation()
			f13_arg0.emblem0:setRGB(1, 1, 1)
			f13_local1(f13_arg0.emblem0)
			local f13_local2 = function(f16_arg0)
				f13_arg0.ImageText:beginAnimation(150)
				f13_arg0.ImageText:setAlpha(0)
				f13_arg0.ImageText:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.ImageText:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.ImageText:completeAnimation()
			f13_arg0.ImageText:setAlpha(1)
			f13_local2(f13_arg0.ImageText)
		end,
	},
	UGCDisabled = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(4)
			f17_arg0.emblem0:completeAnimation()
			f17_arg0.emblem0:setRGB(0.78, 0.78, 0.78)
			f17_arg0.emblem0:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.emblem0)
			f17_arg0.BlackLine:completeAnimation()
			f17_arg0.BlackLine:setAlpha(0.5)
			f17_arg0.clipFinished(f17_arg0.BlackLine)
			f17_arg0.ButtonStateText:completeAnimation()
			f17_arg0.ButtonStateText:setAlpha(0.5)
			f17_arg0.clipFinished(f17_arg0.ButtonStateText)
			f17_arg0.ImageText:completeAnimation()
			f17_arg0.ImageText:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.ImageText)
		end,
		ChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(4)
			f18_arg0.NoiseTiledBackingAdd:completeAnimation()
			f18_arg0.NoiseTiledBackingAdd:setAlpha(0.5)
			f18_arg0.clipFinished(f18_arg0.NoiseTiledBackingAdd)
			f18_arg0.emblem0:completeAnimation()
			f18_arg0.emblem0:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.emblem0)
			f18_arg0.BlackLine:completeAnimation()
			f18_arg0.BlackLine:setAlpha(0.5)
			f18_arg0.clipFinished(f18_arg0.BlackLine)
			f18_arg0.ButtonStateText:completeAnimation()
			f18_arg0.ButtonStateText:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.ButtonStateText)
		end,
		GainChildFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(5)
			local f19_local0 = function(f20_arg0)
				f19_arg0.NoiseTiledBackingAdd:beginAnimation(150)
				f19_arg0.NoiseTiledBackingAdd:setAlpha(0.5)
				f19_arg0.NoiseTiledBackingAdd:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.NoiseTiledBackingAdd:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.NoiseTiledBackingAdd:completeAnimation()
			f19_arg0.NoiseTiledBackingAdd:setAlpha(0.2)
			f19_local0(f19_arg0.NoiseTiledBackingAdd)
			local f19_local1 = function(f21_arg0)
				f19_arg0.emblem0:beginAnimation(150)
				f19_arg0.emblem0:setRGB(1, 1, 1)
				f19_arg0.emblem0:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.emblem0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.emblem0:completeAnimation()
			f19_arg0.emblem0:setRGB(0.78, 0.78, 0.78)
			f19_arg0.emblem0:setAlpha(0)
			f19_local1(f19_arg0.emblem0)
			f19_arg0.BlackLine:completeAnimation()
			f19_arg0.BlackLine:setAlpha(0.5)
			f19_arg0.clipFinished(f19_arg0.BlackLine)
			f19_arg0.ButtonStateText:completeAnimation()
			f19_arg0.ButtonStateText:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.ButtonStateText)
			local f19_local2 = function(f22_arg0)
				f19_arg0.ImageText:beginAnimation(150)
				f19_arg0.ImageText:setAlpha(1)
				f19_arg0.ImageText:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.ImageText:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.ImageText:completeAnimation()
			f19_arg0.ImageText:setAlpha(0)
			f19_local2(f19_arg0.ImageText)
		end,
		LoseChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(5)
			local f23_local0 = function(f24_arg0)
				f23_arg0.NoiseTiledBackingAdd:beginAnimation(150)
				f23_arg0.NoiseTiledBackingAdd:setAlpha(0.2)
				f23_arg0.NoiseTiledBackingAdd:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.NoiseTiledBackingAdd:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.NoiseTiledBackingAdd:completeAnimation()
			f23_arg0.NoiseTiledBackingAdd:setAlpha(0.5)
			f23_local0(f23_arg0.NoiseTiledBackingAdd)
			local f23_local1 = function(f25_arg0)
				f23_arg0.emblem0:beginAnimation(150)
				f23_arg0.emblem0:setRGB(0.78, 0.78, 0.78)
				f23_arg0.emblem0:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.emblem0:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.emblem0:completeAnimation()
			f23_arg0.emblem0:setRGB(1, 1, 1)
			f23_arg0.emblem0:setAlpha(0)
			f23_local1(f23_arg0.emblem0)
			f23_arg0.BlackLine:completeAnimation()
			f23_arg0.BlackLine:setAlpha(0.5)
			f23_arg0.clipFinished(f23_arg0.BlackLine)
			f23_arg0.ButtonStateText:completeAnimation()
			f23_arg0.ButtonStateText:setAlpha(0.5)
			f23_arg0.clipFinished(f23_arg0.ButtonStateText)
			local f23_local2 = function(f26_arg0)
				f23_arg0.ImageText:beginAnimation(150)
				f23_arg0.ImageText:setAlpha(0)
				f23_arg0.ImageText:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.ImageText:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.ImageText:completeAnimation()
			f23_arg0.ImageText:setAlpha(1)
			f23_local2(f23_arg0.ImageText)
		end,
	},
}
CoD.StartMenu_Button_Emblem_Internal.__onClose = function(f27_arg0)
	f27_arg0.Subtitle:close()
	f27_arg0.ButtonOutline:close()
end
