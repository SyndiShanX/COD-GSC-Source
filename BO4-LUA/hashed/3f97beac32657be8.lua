require("x64:29187ea00d726c3")
require("x64:12d199c0b6f6540")
require("x64:246178cf189051b")
CoD.SupplyChainDetails_ButtonPrompt = InheritFrom(LUI.UIElement)
CoD.SupplyChainDetails_ButtonPrompt.__defaultWidth = 100
CoD.SupplyChainDetails_ButtonPrompt.__defaultHeight = 39
CoD.SupplyChainDetails_ButtonPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.SupplyChainDetails_ButtonPrompt)
	self.id = "SupplyChainDetails_ButtonPrompt"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local togglePreviewButton = CoD.JoinButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 0, 39, 0.5, 0.5, -19.5, 19.5)
	togglePreviewButton:setScale(0.8, 0.8)
	togglePreviewButton.KMprompt:setText(CoD.BaseUtility.AlreadyLocalized("T"))
	togglePreviewButton:registerEventHandler("input_source_changed", function(element, event)
		local f2_local0 = nil
		togglePreviewButton:updateState(togglePreviewButton, {
			name = "update_state",
			controller = f1_arg1,
			menu = f1_arg0,
		})
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(togglePreviewButton)
	self.togglePreviewButton = togglePreviewButton
	local KeyPrompt = nil
	KeyPrompt = CoD.KeyPrompt.new(f1_arg0, f1_arg1, 0, 0, 39, 78, 0.5, 0.5, -18, 18)
	KeyPrompt:setAlpha(0)
	self:addElement(KeyPrompt)
	self.KeyPrompt = KeyPrompt
	local VerticalListSpacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 78, 86, 0, 0, -6, 45)
	VerticalListSpacer:setAlpha(0)
	self:addElement(VerticalListSpacer)
	self.VerticalListSpacer = VerticalListSpacer
	local togglePreviewLabel = LUI.UIText.new(0, 0, 95, 143, 0.5, 0.5, -7, 11)
	togglePreviewLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	togglePreviewLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/toggle_preview"))
	togglePreviewLabel:setTTF("dinnext_regular")
	togglePreviewLabel:setLetterSpacing(2)
	togglePreviewLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(togglePreviewLabel)
	self.togglePreviewLabel = togglePreviewLabel
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f3_arg2, f3_arg3, f3_arg4)
		if IsSelfInState(self, "DefaultState") then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SupplyChainDetails_ButtonPrompt.__resetProperties = function(f4_arg0)
	f4_arg0.togglePreviewLabel:completeAnimation()
	f4_arg0.togglePreviewButton:completeAnimation()
	f4_arg0.VerticalListSpacer:completeAnimation()
	f4_arg0.KeyPrompt:completeAnimation()
	f4_arg0.togglePreviewLabel:setAlpha(1)
	f4_arg0.togglePreviewButton:setAlpha(1)
	f4_arg0.VerticalListSpacer:setLeftRight(0, 0, 78, 86)
	f4_arg0.VerticalListSpacer:setAlpha(0)
	f4_arg0.KeyPrompt:setAlpha(0)
end
CoD.SupplyChainDetails_ButtonPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(3)
			f5_arg0.togglePreviewButton:completeAnimation()
			f5_arg0.togglePreviewButton:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.togglePreviewButton)
			f5_arg0.VerticalListSpacer:completeAnimation()
			f5_arg0.VerticalListSpacer:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.VerticalListSpacer)
			f5_arg0.togglePreviewLabel:completeAnimation()
			f5_arg0.togglePreviewLabel:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.togglePreviewLabel)
		end,
	},
	KBM = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.togglePreviewButton:completeAnimation()
			f6_arg0.togglePreviewButton:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.togglePreviewButton)
			f6_arg0.KeyPrompt:completeAnimation()
			f6_arg0.KeyPrompt:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.KeyPrompt)
			f6_arg0.VerticalListSpacer:completeAnimation()
			f6_arg0.VerticalListSpacer:setLeftRight(0, 0, 78, 90)
			f6_arg0.VerticalListSpacer:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.VerticalListSpacer)
		end,
	},
	VisibleNag = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.VerticalListSpacer:completeAnimation()
			f7_arg0.VerticalListSpacer:setAlpha(0.01)
			f7_arg0.clipFinished(f7_arg0.VerticalListSpacer)
		end,
	},
	Visible = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.VerticalListSpacer:completeAnimation()
			f8_arg0.VerticalListSpacer:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.VerticalListSpacer)
		end,
	},
}
CoD.SupplyChainDetails_ButtonPrompt.__onClose = function(f9_arg0)
	f9_arg0.togglePreviewButton:close()
	f9_arg0.KeyPrompt:close()
	f9_arg0.VerticalListSpacer:close()
end
