CoD.ChatClientChatEntryChannel = InheritFrom(LUI.UIElement)
CoD.ChatClientChatEntryChannel.__defaultWidth = 57
CoD.ChatClientChatEntryChannel.__defaultHeight = 27
CoD.ChatClientChatEntryChannel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChatClientChatEntryChannel)
	self.id = "ChatClientChatEntryChannel"
	self.soundSet = "HUD"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local entryChannelText = LUI.UIText.new(0, 1, 0, 0, 0, 0, 0, 21)
	entryChannelText:setTTF("notosans_light")
	entryChannelText:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	entryChannelText:setShaderVector(0, 0.25, 0, 0, 0)
	entryChannelText:setShaderVector(1, 0.05, 0, 0, 0)
	entryChannelText:setShaderVector(2, 0, 0, 0, 0.67)
	entryChannelText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	entryChannelText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(entryChannelText)
	self.entryChannelText = entryChannelText
	self.entryChannelText:linkToElementModel(self, "chColor", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			entryChannelText:setRGB(f2_local0)
		end
	end)
	self.entryChannelText:linkToElementModel(self, "chText", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			entryChannelText:setText(f3_local0)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.PCWidgetUtility.SetupClickableChatChannel(self, f1_arg1)
	return self
end
CoD.ChatClientChatEntryChannel.__resetProperties = function(f4_arg0)
	f4_arg0.entryChannelText:completeAnimation()
	f4_arg0.entryChannelText:setBackingType(0)
	f4_arg0.entryChannelText:setBackingAlpha(0)
end
CoD.ChatClientChatEntryChannel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.entryChannelText:completeAnimation()
			f5_arg0.entryChannelText:setBackingType(2)
			f5_arg0.entryChannelText:setBackingAlpha(0)
			f5_arg0.clipFinished(f5_arg0.entryChannelText)
		end,
		Over = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.entryChannelText:completeAnimation()
			f6_arg0.entryChannelText:setBackingType(2)
			f6_arg0.entryChannelText:setBackingAlpha(0.3)
			f6_arg0.clipFinished(f6_arg0.entryChannelText)
		end,
		Focus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.entryChannelText:completeAnimation()
			f7_arg0.entryChannelText:setBackingType(2)
			f7_arg0.entryChannelText:setBackingAlpha(0.3)
			f7_arg0.clipFinished(f7_arg0.entryChannelText)
		end,
	},
}
CoD.ChatClientChatEntryChannel.__onClose = function(f8_arg0)
	f8_arg0.entryChannelText:close()
end
