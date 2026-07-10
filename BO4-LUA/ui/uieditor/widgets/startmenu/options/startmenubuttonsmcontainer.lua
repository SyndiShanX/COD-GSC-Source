require("x64:5f8cf56752aa71b")
require("x64:31a49b4e793f7de")
require("x64:19c1945d2e472b0")
CoD.StartMenuButtonSmContainer = InheritFrom(LUI.UIElement)
CoD.StartMenuButtonSmContainer.__defaultWidth = 500
CoD.StartMenuButtonSmContainer.__defaultHeight = 500
CoD.StartMenuButtonSmContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenuButtonSmContainer)
	self.id = "StartMenuButtonSmContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0, 0, 0)
	Backing:setAlpha(0.9)
	self:addElement(Backing)
	self.Backing = Backing
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.5)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local StoreCommonTextBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0.2, 0, 0)
	StoreCommonTextBacking:setAlpha(0.5)
	self:addElement(StoreCommonTextBacking)
	self.StoreCommonTextBacking = StoreCommonTextBacking
	local SelectorOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SelectorOverlay:setAlpha(0.01)
	self:addElement(SelectorOverlay)
	self.SelectorOverlay = SelectorOverlay
	local ImageContainer = CoD.StartMenu_ImageContainer.new(f1_arg0, f1_arg1, 0.18, 0.82, 0, 0, 0.18, 0.82, 0, 0)
	ImageContainer:setAlpha(0.3)
	self:addElement(ImageContainer)
	self.ImageContainer = ImageContainer
	local ButtonText = LUI.UIText.new(0, 0, 7, 493, 0.08, 0.08, -7.5, 17.5)
	ButtonText:setRGB(0.78, 0.74, 0.67)
	ButtonText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	ButtonText:setTTF("ttmussels_regular")
	ButtonText:setLetterSpacing(1)
	ButtonText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ButtonText:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(ButtonText)
	self.ButtonText = ButtonText
	local ButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(ButtonOutline)
	self.ButtonOutline = ButtonOutline
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "OnlineOnly",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "ComingSoon",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	ButtonOutline.id = "ButtonOutline"
	self.__defaultFocus = ButtonOutline
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenuButtonSmContainer.__resetProperties = function(f6_arg0)
	f6_arg0.ImageContainer:completeAnimation()
	f6_arg0.SelectorOverlay:completeAnimation()
	f6_arg0.ImageContainer:setRGB(1, 1, 1)
	f6_arg0.ImageContainer:setAlpha(0.3)
	f6_arg0.ImageContainer.ImageContainer:setAlpha(1)
	f6_arg0.SelectorOverlay:setAlpha(0.01)
end
CoD.StartMenuButtonSmContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.ImageContainer:completeAnimation()
			f7_arg0.ImageContainer.ImageContainer:completeAnimation()
			f7_arg0.ImageContainer.ImageContainer:setAlpha(0.79)
			f7_arg0.clipFinished(f7_arg0.ImageContainer)
		end,
		ChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.SelectorOverlay:completeAnimation()
			f8_arg0.SelectorOverlay:setAlpha(0.04)
			f8_arg0.clipFinished(f8_arg0.SelectorOverlay)
		end,
		GainChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.SelectorOverlay:beginAnimation(200)
			f9_arg0.SelectorOverlay:setAlpha(0.04)
			f9_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
			f9_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
		end,
		LoseChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.SelectorOverlay:beginAnimation(200)
			f10_arg0.SelectorOverlay:setAlpha(0.01)
			f10_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
			f10_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
		end,
	},
	Disabled = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.ImageContainer:completeAnimation()
			f11_arg0.ImageContainer:setRGB(0, 0, 0)
			f11_arg0.ImageContainer:setAlpha(0.8)
			f11_arg0.clipFinished(f11_arg0.ImageContainer)
		end,
	},
	OnlineOnly = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.ImageContainer:completeAnimation()
			f12_arg0.ImageContainer.ImageContainer:completeAnimation()
			f12_arg0.ImageContainer.ImageContainer:setAlpha(0.79)
			f12_arg0.clipFinished(f12_arg0.ImageContainer)
		end,
	},
	Hidden = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.ImageContainer:completeAnimation()
			f13_arg0.ImageContainer:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.ImageContainer)
		end,
	},
	ComingSoon = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.ImageContainer:completeAnimation()
			f14_arg0.ImageContainer.ImageContainer:completeAnimation()
			f14_arg0.ImageContainer.ImageContainer:setAlpha(0.79)
			f14_arg0.clipFinished(f14_arg0.ImageContainer)
		end,
	},
}
CoD.StartMenuButtonSmContainer.__onClose = function(f15_arg0)
	f15_arg0.StoreCommonTextBacking:close()
	f15_arg0.ImageContainer:close()
	f15_arg0.ButtonOutline:close()
end
