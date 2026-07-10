require("x64:246178cf189051b")
CoD.CodCasterButtonPromptContainer_OnlyKeyboardKey = InheritFrom(LUI.UIElement)
CoD.CodCasterButtonPromptContainer_OnlyKeyboardKey.__defaultWidth = 264
CoD.CodCasterButtonPromptContainer_OnlyKeyboardKey.__defaultHeight = 38
CoD.CodCasterButtonPromptContainer_OnlyKeyboardKey.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 10, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.CodCasterButtonPromptContainer_OnlyKeyboardKey)
	self.id = "CodCasterButtonPromptContainer_OnlyKeyboardKey"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local KeyPrompt = CoD.KeyPrompt.new(f1_arg0, f1_arg1, 0, 0, 0, 36, 0.5, 0.5, -18, 18)
	self:addElement(KeyPrompt)
	self.KeyPrompt = KeyPrompt
	local Text = LUI.UIText.new(0, 0, 46, 212, 0.5, 0.5, -8, 8)
	Text:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5A61241CD7E3DE2B"))
	Text:setTTF("default")
	Text:setLineSpacing(2)
	Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(Text)
	self.Text = Text
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local3 = self
	f1_local3 = Text
	if IsPC() then
		CoD.PCWidgetUtility.EnableShrinkToFit(f1_local3)
	end
	return self
end
CoD.CodCasterButtonPromptContainer_OnlyKeyboardKey.__resetProperties = function(f3_arg0)
	f3_arg0.Text:completeAnimation()
	f3_arg0.Text:setAlpha(1)
end
CoD.CodCasterButtonPromptContainer_OnlyKeyboardKey.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Text:completeAnimation()
			f5_arg0.Text:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Text)
		end,
	},
}
CoD.CodCasterButtonPromptContainer_OnlyKeyboardKey.__onClose = function(f6_arg0)
	f6_arg0.KeyPrompt:close()
	f6_arg0.Text:close()
end
