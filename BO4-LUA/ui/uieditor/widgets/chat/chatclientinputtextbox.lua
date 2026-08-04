require("ui/uieditor/widgets/border")
require("ui/uieditor/widgets/chat/chatclientinputtextboxfield")
local f0_local0 = 14
local f0_local1 = 18
local PostLoadFunc = function(self, controller, menu)
	self.arrangeText = function(f2_arg0)
		local f2_local0, f2_local1, f2_local2, f2_local3 = f2_arg0:getLocalRect()
		local f2_local4, f2_local5, f2_local6, f2_local7 = nil
		f2_local7 = 4
		f2_local6 = f2_local7 + f2_arg0.channelText:getTextWidth()
		f2_arg0.channelText:setLeftRight(true, false, f2_local7, f2_local6)
		f2_local7 = f2_local6 + 6
		f2_local6 = f2_local2 - f2_local0 - 6
		f2_arg0.ChatClientInputTextBoxField:setLeftRight(true, false, f2_local7, f2_local6)
		f2_arg0.tabText:setLeftRight(true, false, f2_local7, f2_local6)
	end
	self:registerEventHandler("update_safe_area", function(element, event)
		element:arrangeText()
	end)
end
CoD.ChatClientInputTextBox = InheritFrom(LUI.UIElement)
CoD.ChatClientInputTextBox.__defaultWidth = 519
CoD.ChatClientInputTextBox.__defaultHeight = 48
CoD.ChatClientInputTextBox.new = function(f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4, f4_arg5, f4_arg6, f4_arg7, f4_arg8, f4_arg9)
	local self = LUI.UIElement.new(f4_arg2, f4_arg3, f4_arg4, f4_arg5, f4_arg6, f4_arg7, f4_arg8, f4_arg9)
	self:setClass(CoD.ChatClientInputTextBox)
	self.id = "ChatClientInputTextBox"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f4_arg0:addElementToPendingUpdateStateList(self)
	local tabText = LUI.UIText.new(0.25, 0.25, -125, 125, 0.54, 0.54, -10.5, 10.5)
	tabText:setRGB(0.42, 0.42, 0.42)
	tabText:setAlpha(0)
	tabText:setText(Engine[@"hash_4F9F1239CFD921FE"](0x986F6683C870870))
	tabText:setTTF("notosans_regular")
	tabText:setLetterSpacing(1)
	tabText:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	self:addElement(tabText)
	self.tabText = tabText
	local channelText = LUI.UIText.new(0.22, 0.22, -117, 117, 0.52, 0.52, -11.5, 9.5)
	channelText:setTTF("notosans_regular")
	channelText:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	channelText:setLetterSpacing(1)
	channelText:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	channelText:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	channelText:linkToElementModel(self, "InputChannel", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			channelText:setRGB(CoD.PCWidgetUtility.GetChatChannelColor(f5_local0))
		end
	end)
	channelText.__String_Reference = function(f6_arg0)
		local f6_local0 = f6_arg0:get()
		if f6_local0 ~= nil then
			channelText:setText(CoD.PCUtility.ChatChannelNameFromChatId(false, f4_arg1, f6_local0))
		end
	end
	channelText:linkToElementModel(self, "InputChannel", true, channelText.__String_Reference)
	channelText.__String_Reference_FullPath = function()
		local f7_local0 = self:getModel()
		if f7_local0 then
			f7_local0 = self:getModel()
			f7_local0 = f7_local0.InputChannel
		end
		if f7_local0 then
			channelText.__String_Reference(f7_local0)
		end
	end
	LUI.OverrideFunction_CallOriginalFirst(channelText, "setText", function(element, controller)
		ChatClientInputArrangeText(self, element, f4_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(channelText, "setWidth", function(element, controller)
		ChatClientInputArrangeText(self, element, f4_arg1)
	end)
	channelText:linkToElementModel(self, "Event", true, function(model)
		ChatClientInputArrangeText(self, channelText, f4_arg1)
	end)
	self:addElement(channelText)
	self.channelText = channelText
	local ChatClientInputTextBoxField = CoD.ChatClientInputTextBoxField.new(f4_arg0, f4_arg1, 0, 1, 0, 0, 0.17, 0.87, 0, 0)
	ChatClientInputTextBoxField:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return not ChatClientIsAvailable(self, element, f4_arg1)
			end,
		},
	})
	local LineLeft = ChatClientInputTextBoxField
	local Border = ChatClientInputTextBoxField.subscribeToModel
	local f4_local6 = Engine.GetModelForController(f4_arg1)
	Border(LineLeft, f4_local6["ChatGlobal.Event"], function(f12_arg0)
		f4_arg0:updateElementState(ChatClientInputTextBoxField, {
			name = "model_validation",
			menu = f4_arg0,
			controller = f4_arg1,
			modelValue = f12_arg0:get(),
			modelName = "ChatGlobal.Event",
		})
	end, false)
	LineLeft = ChatClientInputTextBoxField
	Border = ChatClientInputTextBoxField.subscribeToModel
	f4_local6 = Engine.GetModelForController(f4_arg1)
	Border(LineLeft, f4_local6["ChatGlobal.inGameChatActive"], function(f13_arg0)
		f4_arg0:updateElementState(ChatClientInputTextBoxField, {
			name = "model_validation",
			menu = f4_arg0,
			controller = f4_arg1,
			modelValue = f13_arg0:get(),
			modelName = "ChatGlobal.inGameChatActive",
		})
	end, false)
	ChatClientInputTextBoxField:setRGB(0.49, 0.49, 0.49)
	self:addElement(ChatClientInputTextBoxField)
	self.ChatClientInputTextBoxField = ChatClientInputTextBoxField
	Border = CoD.Border.new(f4_arg0, f4_arg1, 0.34, 0.34, -0.5, 342.5, 0, 1, 0, 0)
	Border:setRGB(ColorSet.Orange.r, ColorSet.Orange.g, ColorSet.Orange.b)
	Border:setAlpha(0)
	self:addElement(Border)
	self.Border = Border
	LineLeft = LUI.UIImage.new(0, 1, 0, 0, 0, 0, -3, 3)
	LineLeft:setAlpha(0)
	LineLeft:setImage(RegisterImage("uie_t7_menu_frontend_featuredframeum"))
	LineLeft:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(LineLeft)
	self.LineLeft = LineLeft
	local f4_local7 = channelText
	f4_local6 = channelText.subscribeToModel
	local f4_local8 = Engine.GetModelForController(f4_arg1)
	f4_local6(f4_local7, f4_local8["ChatGlobal.Event"], channelText.__String_Reference_FullPath)
	self:mergeStateConditions({
		{
			stateName = "ChattingEmptyAsian",
			condition = function(menu, element, event)
				local f14_local0 = ChatClientIsChattingButEmpty(f4_arg1)
				if f14_local0 then
					f14_local0 = ChatClientOnlineChannelsAvailable(f4_arg1)
					if f14_local0 then
						f14_local0 = CoD.BaseUtility.IsCurrentLanguageAsian()
					end
				end
				return f14_local0
			end,
		},
		{
			stateName = "ChattingAsian",
			condition = function(menu, element, event)
				return ChatClientIsChatting(f4_arg1) and CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
		{
			stateName = "DefaultStateAsian",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
		{
			stateName = "ChattingEmpty",
			condition = function(menu, element, event)
				return ChatClientIsChattingButEmpty(f4_arg1) and ChatClientOnlineChannelsAvailable(f4_arg1)
			end,
		},
		{
			stateName = "Chatting",
			condition = function(menu, element, event)
				return ChatClientIsChatting(f4_arg1)
			end,
		},
	})
	f4_local7 = self
	f4_local6 = self.subscribeToModel
	f4_local8 = Engine.GetModelForController(f4_arg1)
	f4_local6(f4_local7, f4_local8["ChatGlobal.fieldIsEmpty"], function(f19_arg0)
		f4_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f4_arg0,
			controller = f4_arg1,
			modelValue = f19_arg0:get(),
			modelName = "ChatGlobal.fieldIsEmpty",
		})
	end, false)
	f4_local7 = self
	f4_local6 = self.subscribeToModel
	f4_local8 = Engine.GetModelForController(f4_arg1)
	f4_local6(f4_local7, f4_local8["ChatGlobal.Event"], function(f20_arg0)
		f4_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f4_arg0,
			controller = f4_arg1,
			modelValue = f20_arg0:get(),
			modelName = "ChatGlobal.Event",
		})
	end, false)
	ChatClientInputTextBoxField.id = "ChatClientInputTextBoxField"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f4_arg1, f4_arg0)
	end
	return self
end
CoD.ChatClientInputTextBox.__resetProperties = function(f21_arg0)
	f21_arg0.tabText:completeAnimation()
	f21_arg0.ChatClientInputTextBoxField:completeAnimation()
	f21_arg0.tabText:setAlpha(0)
	f21_arg0.ChatClientInputTextBoxField:setTopBottom(0.17, 0.87, 0, 0)
	f21_arg0.ChatClientInputTextBoxField:setRGB(0.49, 0.49, 0.49)
end
CoD.ChatClientInputTextBox.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.tabText:completeAnimation()
			f22_arg0.tabText:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.tabText)
			f22_arg0.ChatClientInputTextBoxField:completeAnimation()
			f22_arg0.ChatClientInputTextBoxField:setRGB(0.49, 0.49, 0.49)
			f22_arg0.clipFinished(f22_arg0.ChatClientInputTextBoxField)
		end,
	},
	ChattingEmptyAsian = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			f23_arg0.tabText:completeAnimation()
			f23_arg0.tabText:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.tabText)
			f23_arg0.ChatClientInputTextBoxField:completeAnimation()
			f23_arg0.ChatClientInputTextBoxField:setTopBottom(0, 1, 0, 0)
			f23_arg0.ChatClientInputTextBoxField:setRGB(0.49, 0.49, 0.49)
			f23_arg0.clipFinished(f23_arg0.ChatClientInputTextBoxField)
		end,
	},
	ChattingAsian = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.tabText:completeAnimation()
			f24_arg0.tabText:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.tabText)
			f24_arg0.ChatClientInputTextBoxField:completeAnimation()
			f24_arg0.ChatClientInputTextBoxField:setTopBottom(0, 1, 0, 0)
			f24_arg0.ChatClientInputTextBoxField:setRGB(0.49, 0.49, 0.49)
			f24_arg0.clipFinished(f24_arg0.ChatClientInputTextBoxField)
		end,
	},
	DefaultStateAsian = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(2)
			f25_arg0.tabText:completeAnimation()
			f25_arg0.tabText:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.tabText)
			f25_arg0.ChatClientInputTextBoxField:completeAnimation()
			f25_arg0.ChatClientInputTextBoxField:setTopBottom(0, 1, 0, 0)
			f25_arg0.ChatClientInputTextBoxField:setRGB(0.49, 0.49, 0.49)
			f25_arg0.clipFinished(f25_arg0.ChatClientInputTextBoxField)
		end,
	},
	ChattingEmpty = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(2)
			f26_arg0.tabText:completeAnimation()
			f26_arg0.tabText:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.tabText)
			f26_arg0.ChatClientInputTextBoxField:completeAnimation()
			f26_arg0.ChatClientInputTextBoxField:setRGB(1, 1, 1)
			f26_arg0.clipFinished(f26_arg0.ChatClientInputTextBoxField)
		end,
	},
	Chatting = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(2)
			f27_arg0.tabText:completeAnimation()
			f27_arg0.tabText:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.tabText)
			f27_arg0.ChatClientInputTextBoxField:completeAnimation()
			f27_arg0.ChatClientInputTextBoxField:setRGB(1, 1, 1)
			f27_arg0.clipFinished(f27_arg0.ChatClientInputTextBoxField)
		end,
	},
}
CoD.ChatClientInputTextBox.__onClose = function(f28_arg0)
	f28_arg0.channelText:close()
	f28_arg0.ChatClientInputTextBoxField:close()
	f28_arg0.Border:close()
end
