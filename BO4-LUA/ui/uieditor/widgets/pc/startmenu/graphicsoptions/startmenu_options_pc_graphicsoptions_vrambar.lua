require("x64:2675595fa323085")
require("x64:55aca670e9903a3")
CoD.StartMenu_Options_PC_GraphicsOptions_VRAMBar = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_PC_GraphicsOptions_VRAMBar.__defaultWidth = 366
CoD.StartMenu_Options_PC_GraphicsOptions_VRAMBar.__defaultHeight = 45
CoD.StartMenu_Options_PC_GraphicsOptions_VRAMBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_PC_GraphicsOptions_VRAMBar)
	self.id = "StartMenu_Options_PC_GraphicsOptions_VRAMBar"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Maximum = LUI.UIText.new(1, 1, -125, 0, 0.5, 0.5, 12.5, 27.5)
	Maximum:setRGB(0.76, 0.76, 0.76)
	Maximum:setAlpha(0.44)
	Maximum:setText(LocalizeToUpperString(0x4EF66575DDB929))
	Maximum:setTTF("dinnext_regular")
	Maximum:setLetterSpacing(1)
	Maximum:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	self:addElement(Maximum)
	self.Maximum = Maximum
	local FilledBarBackground = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -3, 5)
	FilledBarBackground:setAlpha(0.03)
	self:addElement(FilledBarBackground)
	self.FilledBarBackground = FilledBarBackground
	local FilledBar = LUI.UIImage.new(0, 0, 0, 166, 0.5, 0.5, -3, 5)
	FilledBar:setRGB(0.44, 0.44, 0.44)
	self:addElement(FilledBar)
	self.FilledBar = FilledBar
	local OverflowIndicator1 = LUI.UIImage.new(1, 1, 4, 9, 0.5, 0.5, -3, 5)
	OverflowIndicator1:setRGB(0.68, 0.14, 0.1)
	self:addElement(OverflowIndicator1)
	self.OverflowIndicator1 = OverflowIndicator1
	local OverflowIndicator3 = LUI.UIImage.new(1, 1, 22, 27, 0.5, 0.5, -3, 5)
	OverflowIndicator3:setRGB(0.68, 0.14, 0.1)
	self:addElement(OverflowIndicator3)
	self.OverflowIndicator3 = OverflowIndicator3
	local OverflowIndicator2 = LUI.UIImage.new(1, 1, 13, 18, 0.5, 0.5, -3, 5)
	OverflowIndicator2:setRGB(0.68, 0.14, 0.1)
	self:addElement(OverflowIndicator2)
	self.OverflowIndicator2 = OverflowIndicator2
	local OverflowIndicator4 = LUI.UIImage.new(1, 1, -4, 26, 0.5, 0.5, -32, -2)
	OverflowIndicator4:setRGB(0.76, 0.76, 0.76)
	OverflowIndicator4:setAlpha(0.44)
	OverflowIndicator4:setImage(RegisterImage(@"uie_warning_small"))
	self:addElement(OverflowIndicator4)
	self.OverflowIndicator4 = OverflowIndicator4
	local Corners = CoD.StartMenuOptionsMainCorners.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0.5, 0.5, -3, 5)
	Corners:setAlpha(0.5)
	self:addElement(Corners)
	self.Corners = Corners
	local TextBox = LUI.UIText.new(0, 1, 0, -180, 0.5, 0.5, -24.5, -7.5)
	TextBox:setRGB(0.76, 0.76, 0.76)
	TextBox:setAlpha(0.6)
	TextBox:setText(LocalizeToUpperString(@"hash_5CCC02F6B5D8DCE1"))
	TextBox:setTTF("dinnext_regular")
	TextBox:setLetterSpacing(1)
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(TextBox)
	self.TextBox = TextBox
	local MbUsage = LUI.UIText.new(1, 1, -125, 0, 0.5, 0.5, -24.5, -7.5)
	MbUsage:setRGB(0.76, 0.76, 0.76)
	MbUsage:setAlpha(0.44)
	MbUsage:setText(LocalizeToUpperString(@"hash_5BF86D864C077F3E"))
	MbUsage:setTTF("dinnext_regular")
	MbUsage:setLetterSpacing(1)
	MbUsage:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	self:addElement(MbUsage)
	self.MbUsage = MbUsage
	local RecommendedLimit = LUI.UIImage.new(0, 0, 284, 285, 0.5, 0.5, -3, 5)
	RecommendedLimit:setRGB(0.68, 0.14, 0.1)
	self:addElement(RecommendedLimit)
	self.RecommendedLimit = RecommendedLimit
	local TooltipFocus = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 0, 0, 366, 0, 0, 0, 62)
	TooltipFocus:subscribeToGlobalModel(f1_arg1, "PerController", "CurrentOptionTab", function(model)
		local f2_local0 = TooltipFocus
		if not CoD.PCOptionsUtility.IsGraphicsOptions(f1_arg1) then
			MakeNotFocusable(f2_local0, f1_arg1)
		elseif CoD.PCOptionsUtility.IsGraphicsOptions(f1_arg1) then
			MakeFocusable(f2_local0, f1_arg1)
		end
	end)
	self:addElement(TooltipFocus)
	self.TooltipFocus = TooltipFocus
	self:subscribeToGlobalModel(f1_arg1, "PerController", "PC.VRAMBar", function(model)
		local f3_local0 = self
		CoD.PCOptionsUtility.UpdateVRAMBar(f1_arg1, self, model)
	end)
	TooltipFocus.id = "TooltipFocus"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local13 = self
	f1_local13 = TooltipFocus
	CoD.PCWidgetUtility.SetupEmptyFocusableTooltip(f1_local13, f1_arg1, @"hash_5CCC02F6B5D8DCE1", 0xA669610927190D)
	DisableKeyboardNavigationByElement(f1_local13)
	return self
end
CoD.StartMenu_Options_PC_GraphicsOptions_VRAMBar.__resetProperties = function(f4_arg0)
	f4_arg0.OverflowIndicator4:completeAnimation()
	f4_arg0.OverflowIndicator3:completeAnimation()
	f4_arg0.OverflowIndicator2:completeAnimation()
	f4_arg0.OverflowIndicator1:completeAnimation()
	f4_arg0.Maximum:completeAnimation()
	f4_arg0.RecommendedLimit:completeAnimation()
	f4_arg0.MbUsage:completeAnimation()
	f4_arg0.TextBox:completeAnimation()
	f4_arg0.Corners:completeAnimation()
	f4_arg0.FilledBar:completeAnimation()
	f4_arg0.FilledBarBackground:completeAnimation()
	f4_arg0.OverflowIndicator4:setRGB(0.76, 0.76, 0.76)
	f4_arg0.OverflowIndicator4:setAlpha(0.44)
	f4_arg0.OverflowIndicator3:setAlpha(1)
	f4_arg0.OverflowIndicator2:setAlpha(1)
	f4_arg0.OverflowIndicator1:setAlpha(1)
	f4_arg0.Maximum:setAlpha(0.44)
	f4_arg0.RecommendedLimit:setRGB(0.68, 0.14, 0.1)
	f4_arg0.RecommendedLimit:setAlpha(1)
	f4_arg0.MbUsage:setAlpha(0.44)
	f4_arg0.TextBox:setAlpha(0.6)
	f4_arg0.Corners:setAlpha(0.5)
	f4_arg0.FilledBar:setRGB(0.44, 0.44, 0.44)
	f4_arg0.FilledBar:setAlpha(1)
	f4_arg0.FilledBarBackground:setAlpha(0.03)
end
CoD.StartMenu_Options_PC_GraphicsOptions_VRAMBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(4)
			f5_arg0.OverflowIndicator1:completeAnimation()
			f5_arg0.OverflowIndicator1:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.OverflowIndicator1)
			f5_arg0.OverflowIndicator3:completeAnimation()
			f5_arg0.OverflowIndicator3:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.OverflowIndicator3)
			f5_arg0.OverflowIndicator2:completeAnimation()
			f5_arg0.OverflowIndicator2:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.OverflowIndicator2)
			f5_arg0.OverflowIndicator4:completeAnimation()
			f5_arg0.OverflowIndicator4:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.OverflowIndicator4)
		end,
	},
	Hidden = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(11)
			f6_arg0.Maximum:completeAnimation()
			f6_arg0.Maximum:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Maximum)
			f6_arg0.FilledBarBackground:completeAnimation()
			f6_arg0.FilledBarBackground:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.FilledBarBackground)
			f6_arg0.FilledBar:completeAnimation()
			f6_arg0.FilledBar:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.FilledBar)
			f6_arg0.OverflowIndicator1:completeAnimation()
			f6_arg0.OverflowIndicator1:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.OverflowIndicator1)
			f6_arg0.OverflowIndicator3:completeAnimation()
			f6_arg0.OverflowIndicator3:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.OverflowIndicator3)
			f6_arg0.OverflowIndicator2:completeAnimation()
			f6_arg0.OverflowIndicator2:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.OverflowIndicator2)
			f6_arg0.OverflowIndicator4:completeAnimation()
			f6_arg0.OverflowIndicator4:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.OverflowIndicator4)
			f6_arg0.Corners:completeAnimation()
			f6_arg0.Corners:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Corners)
			f6_arg0.TextBox:completeAnimation()
			f6_arg0.TextBox:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.TextBox)
			f6_arg0.MbUsage:completeAnimation()
			f6_arg0.MbUsage:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.MbUsage)
			f6_arg0.RecommendedLimit:completeAnimation()
			f6_arg0.RecommendedLimit:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.RecommendedLimit)
		end,
	},
	Overflow = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(3)
			f7_arg0.FilledBar:completeAnimation()
			f7_arg0.FilledBar:setRGB(0.68, 0.14, 0.1)
			f7_arg0.clipFinished(f7_arg0.FilledBar)
			local f7_local0 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					f9_arg0:beginAnimation(280)
					f9_arg0:setRGB(0.76, 0.76, 0.76)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f7_arg0.OverflowIndicator4:beginAnimation(220)
				f7_arg0.OverflowIndicator4:setRGB(1, 0, 0)
				f7_arg0.OverflowIndicator4:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.OverflowIndicator4:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f7_arg0.OverflowIndicator4:completeAnimation()
			f7_arg0.OverflowIndicator4:setRGB(0.76, 0.76, 0.76)
			f7_local0(f7_arg0.OverflowIndicator4)
			f7_arg0.RecommendedLimit:completeAnimation()
			f7_arg0.RecommendedLimit:setRGB(0.44, 0.44, 0.44)
			f7_arg0.clipFinished(f7_arg0.RecommendedLimit)
			f7_arg0.nextClip = "DefaultClip"
		end,
	},
	OverRecommended = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(6)
			f10_arg0.FilledBar:completeAnimation()
			f10_arg0.FilledBar:setRGB(0.68, 0.14, 0.1)
			f10_arg0.clipFinished(f10_arg0.FilledBar)
			f10_arg0.OverflowIndicator1:completeAnimation()
			f10_arg0.OverflowIndicator1:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.OverflowIndicator1)
			f10_arg0.OverflowIndicator3:completeAnimation()
			f10_arg0.OverflowIndicator3:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.OverflowIndicator3)
			f10_arg0.OverflowIndicator2:completeAnimation()
			f10_arg0.OverflowIndicator2:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.OverflowIndicator2)
			f10_arg0.OverflowIndicator4:completeAnimation()
			f10_arg0.OverflowIndicator4:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.OverflowIndicator4)
			f10_arg0.RecommendedLimit:completeAnimation()
			f10_arg0.RecommendedLimit:setRGB(0.44, 0.44, 0.44)
			f10_arg0.clipFinished(f10_arg0.RecommendedLimit)
		end,
	},
}
CoD.StartMenu_Options_PC_GraphicsOptions_VRAMBar.__onClose = function(f11_arg0)
	f11_arg0.Corners:close()
	f11_arg0.TooltipFocus:close()
end
