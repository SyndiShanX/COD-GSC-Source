CoD.ChatClientChatEntryLineOfText = InheritFrom(LUI.UIElement)
CoD.ChatClientChatEntryLineOfText.__defaultWidth = 508
CoD.ChatClientChatEntryLineOfText.__defaultHeight = 21
CoD.ChatClientChatEntryLineOfText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChatClientChatEntryLineOfText)
	self.id = "ChatClientChatEntryLineOfText"
	self.soundSet = "default"
	local entryBodyText = LUI.UIText.new(0, 0, 0, 508, 0, 0, 0, 21)
	entryBodyText:setTTF("notosans_regular")
	entryBodyText:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	entryBodyText:setShaderVector(0, 0.22, 0, 0, 0)
	entryBodyText:setShaderVector(1, 0.99, 0, 0, 0)
	entryBodyText:setShaderVector(2, 0, 0, 0, 0.8)
	entryBodyText:setLetterSpacing(1)
	entryBodyText:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	entryBodyText:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	entryBodyText:linkToElementModel(self, "chColor", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			entryBodyText:setRGB(f2_local0)
		end
	end)
	entryBodyText:linkToElementModel(self, "fullLineOfText", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			entryBodyText:setText(CoD.PCUtility.ReplaceCircumflex(f3_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(entryBodyText, "setText", function(element, controller)
		if not ChatClientCurrentChatIsActive(f1_arg1) then
			CoD.PCWidgetUtility.UpdateChatEntryState(self, f1_arg1, "FadeOut")
			CoD.PCWidgetUtility.UpdateChatEntryPositions(self, f1_arg1)
		else
			CoD.PCWidgetUtility.UpdateChatEntryPositions(self, f1_arg1)
		end
	end)
	self:addElement(entryBodyText)
	self.entryBodyText = entryBodyText
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	f1_local2 = entryBodyText
	ActivateTextStencilCulling(f1_local2)
	DisableModelStringReplacement(f1_local2)
	return self
end
CoD.ChatClientChatEntryLineOfText.__onClose = function(f5_arg0)
	f5_arg0.entryBodyText:close()
end
