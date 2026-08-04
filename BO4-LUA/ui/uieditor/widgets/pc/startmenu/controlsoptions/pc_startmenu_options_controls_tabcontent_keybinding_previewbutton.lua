require("ui/uieditor/widgets/emptyfocusable")
require("ui/uieditor/widgets/pc/startmenu/pc_highlightborder")
CoD.PC_StartMenu_Options_Controls_TabContent_KeyBinding_PreviewButton = InheritFrom(LUI.UIElement)
CoD.PC_StartMenu_Options_Controls_TabContent_KeyBinding_PreviewButton.__defaultWidth = 200
CoD.PC_StartMenu_Options_Controls_TabContent_KeyBinding_PreviewButton.__defaultHeight = 65
CoD.PC_StartMenu_Options_Controls_TabContent_KeyBinding_PreviewButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_StartMenu_Options_Controls_TabContent_KeyBinding_PreviewButton)
	self.id = "PC_StartMenu_Options_Controls_TabContent_KeyBinding_PreviewButton"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image:setRGB(0.09, 0.09, 0.09)
	Image:setAlpha(0.9)
	self:addElement(Image)
	self.Image = Image
	local BtnText = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -9, 9)
	BtnText:setRGB(0.76, 0.76, 0.76)
	BtnText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_3A1720478353F60"))
	BtnText:setTTF("ttmussels_regular")
	BtnText:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	BtnText:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(BtnText)
	self.BtnText = BtnText
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 0, 0.5, 199.5, 0, 0, 1, 59)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local PCHighlightBorder = CoD.PC_HighlightBorder.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(PCHighlightBorder)
	self.PCHighlightBorder = PCHighlightBorder
	emptyFocusable.id = "emptyFocusable"
	self.__defaultFocus = emptyFocusable
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_StartMenu_Options_Controls_TabContent_KeyBinding_PreviewButton.__resetProperties = function(f2_arg0)
	f2_arg0.BtnText:completeAnimation()
	f2_arg0.PCHighlightBorder:completeAnimation()
	f2_arg0.Image:completeAnimation()
	f2_arg0.emptyFocusable:completeAnimation()
	f2_arg0.BtnText:setRGB(0.76, 0.76, 0.76)
	f2_arg0.BtnText:setAlpha(1)
	f2_arg0.PCHighlightBorder:setAlpha(1)
	f2_arg0.Image:setAlpha(0.9)
	f2_arg0.emptyFocusable:setAlpha(1)
end
CoD.PC_StartMenu_Options_Controls_TabContent_KeyBinding_PreviewButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.BtnText:completeAnimation()
			f4_arg0.BtnText:setRGB(1, 1, 1)
			f4_arg0.clipFinished(f4_arg0.BtnText)
			f4_arg0.PCHighlightBorder:completeAnimation()
			f4_arg0.PCHighlightBorder:playClip("cFocus")
			f4_arg0.clipFinished(f4_arg0.PCHighlightBorder)
		end,
		LoseChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			local f5_local0 = function(f6_arg0)
				f5_arg0.BtnText:beginAnimation(150)
				f5_arg0.BtnText:setRGB(0.76, 0.76, 0.76)
				f5_arg0.BtnText:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.BtnText:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.BtnText:completeAnimation()
			f5_arg0.BtnText:setRGB(1, 1, 1)
			f5_local0(f5_arg0.BtnText)
			f5_arg0.PCHighlightBorder:completeAnimation()
			f5_arg0.PCHighlightBorder:playClip("cLoseFocus")
			f5_arg0.clipFinished(f5_arg0.PCHighlightBorder)
		end,
		GainChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			local f7_local0 = function(f8_arg0)
				f7_arg0.BtnText:beginAnimation(150)
				f7_arg0.BtnText:setRGB(1, 1, 1)
				f7_arg0.BtnText:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.BtnText:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.BtnText:completeAnimation()
			f7_arg0.BtnText:setRGB(0.76, 0.76, 0.76)
			f7_local0(f7_arg0.BtnText)
			f7_arg0.PCHighlightBorder:completeAnimation()
			f7_arg0.PCHighlightBorder:playClip("cGainFocus")
			f7_arg0.clipFinished(f7_arg0.PCHighlightBorder)
		end,
	},
	Hidden = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(4)
			f9_arg0.Image:completeAnimation()
			f9_arg0.Image:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Image)
			f9_arg0.BtnText:completeAnimation()
			f9_arg0.BtnText:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.BtnText)
			f9_arg0.emptyFocusable:completeAnimation()
			f9_arg0.emptyFocusable:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.emptyFocusable)
			f9_arg0.PCHighlightBorder:completeAnimation()
			f9_arg0.PCHighlightBorder:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.PCHighlightBorder)
		end,
	},
}
CoD.PC_StartMenu_Options_Controls_TabContent_KeyBinding_PreviewButton.__onClose = function(f10_arg0)
	f10_arg0.emptyFocusable:close()
	f10_arg0.PCHighlightBorder:close()
end
