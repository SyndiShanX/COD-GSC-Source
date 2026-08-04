require("ui/uieditor/widgets/chat/chatclientchatentryscrollviewcontainer")
require("ui/uieditor/widgets/chat/chatclientchatentrystaticview")
require("ui/uieditor/widgets/chat/chatclientfilterbutton")
require("ui/uieditor/widgets/chat/chatclientinputtextbox")
require("ui/uieditor/widgets/emptyfocusable")
local PostLoadFunc = function(self, controller, menu)
	self:setPriority(10000)
end
CoD.IngameChatClient = InheritFrom(LUI.UIElement)
CoD.IngameChatClient.__defaultWidth = 540
CoD.IngameChatClient.__defaultHeight = 290
CoD.IngameChatClient.new = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4, f2_arg5, f2_arg6, f2_arg7, f2_arg8, f2_arg9)
	local self = LUI.UIElement.new(f2_arg2, f2_arg3, f2_arg4, f2_arg5, f2_arg6, f2_arg7, f2_arg8, f2_arg9)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.IngameChatClient)
	self.id = "IngameChatClient"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f2_arg0:addElementToPendingUpdateStateList(self)
	local emptyFocusable = CoD.emptyFocusable.new(f2_arg0, f2_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	emptyFocusable:setAlpha(0)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local ChatEntriesBackground = LUI.UIImage.new(0.01, 0.99, 0, 0, 0.11, 0.85, 0, 0)
	ChatEntriesBackground:setRGB(0, 0, 0)
	ChatEntriesBackground:setAlpha(0)
	self:addElement(ChatEntriesBackground)
	self.ChatEntriesBackground = ChatEntriesBackground
	local ChatEntriesDotBLC = LUI.UIImage.new(0.01, 0.01, 0, 1, 0.85, 0.85, -1, 0)
	ChatEntriesDotBLC:setAlpha(0)
	self:addElement(ChatEntriesDotBLC)
	self.ChatEntriesDotBLC = ChatEntriesDotBLC
	local ChatEntriesDotBRC = LUI.UIImage.new(0.99, 0.99, -1, 0, 0.85, 0.85, -1, 0)
	ChatEntriesDotBRC:setAlpha(0)
	self:addElement(ChatEntriesDotBRC)
	self.ChatEntriesDotBRC = ChatEntriesDotBRC
	local ChatEntriesDotTLC = LUI.UIImage.new(0.01, 0.01, 0, 1, 0.11, 0.11, 0, 1)
	ChatEntriesDotTLC:setAlpha(0)
	self:addElement(ChatEntriesDotTLC)
	self.ChatEntriesDotTLC = ChatEntriesDotTLC
	local ChatEntriesDotTRC = LUI.UIImage.new(0.99, 0.99, -1, 0, 0.11, 0.11, 0, 1)
	ChatEntriesDotTRC:setAlpha(0)
	self:addElement(ChatEntriesDotTRC)
	self.ChatEntriesDotTRC = ChatEntriesDotTRC
	local ChatClientChatEntryStaticView = CoD.ChatClientChatEntryStaticView.new(f2_arg0, f2_arg1, 0, 0, 8, 518, 0.47, 0.47, -94, 94)
	self:addElement(ChatClientChatEntryStaticView)
	self.ChatClientChatEntryStaticView = ChatClientChatEntryStaticView
	local ChatClientChatEntryScrollViewContainer = CoD.ChatClientChatEntryScrollViewContainer.new(f2_arg0, f2_arg1, 0, 0, 8, 526, 0.47, 0.47, -94, 94)
	ChatClientChatEntryScrollViewContainer:setAlpha(0)
	self:addElement(ChatClientChatEntryScrollViewContainer)
	self.ChatClientChatEntryScrollViewContainer = ChatClientChatEntryScrollViewContainer
	local InputTextBackground = LUI.UIImage.new(0.01, 0.99, 0, 0, 0.98, 0.98, -35, 0)
	InputTextBackground:setRGB(0, 0, 0)
	InputTextBackground:setAlpha(0)
	self:addElement(InputTextBackground)
	self.InputTextBackground = InputTextBackground
	local InputTextDotLC = LUI.UIImage.new(0.01, 0.01, 0, 1, 0.86, 0.86, 0, 1)
	InputTextDotLC:setAlpha(0)
	self:addElement(InputTextDotLC)
	self.InputTextDotLC = InputTextDotLC
	local InputTextDotRC = LUI.UIImage.new(0.99, 0.99, -1, 0, 0.86, 0.86, 0, 1)
	InputTextDotRC:setAlpha(0)
	self:addElement(InputTextDotRC)
	self.InputTextDotRC = InputTextDotRC
	local InputTextLineDeco = LUI.UIImage.new(0.01, 0.99, 0, 0, 0.98, 0.98, -1, 0)
	InputTextLineDeco:setRGB(0.93, 0.75, 0.11)
	InputTextLineDeco:setAlpha(0)
	self:addElement(InputTextLineDeco)
	self.InputTextLineDeco = InputTextLineDeco
	local InputText = CoD.ChatClientInputTextBox.new(f2_arg0, f2_arg1, 0.5, 0.5, -255, 255, 0.92, 0.92, -15.5, 15.5)
	InputText:setAlpha(0)
	InputText:subscribeToGlobalModel(f2_arg1, "ChatGlobal", nil, function(model)
		InputText:setModel(model, f2_arg1)
	end)
	InputText:subscribeToGlobalModel(f2_arg1, "ChatGlobal", "Event", function(model)
		CoD.PCUtility.ChatClientInputTextFieldUpdatePrompt(self, InputText, f2_arg1)
		UpdateSelfState(self, f2_arg1)
	end)
	self:addElement(InputText)
	self.InputText = InputText
	local FiltersButton = CoD.ChatClientFilterButton.new(f2_arg0, f2_arg1, 0.99, 0.99, -126, 0, 0.01, 0.01, 0, 25)
	FiltersButton:setAlpha(0)
	self:addElement(FiltersButton)
	self.FiltersButton = FiltersButton
	self:mergeStateConditions({
		{
			stateName = "Chatting_PublicBeta",
			condition = function(menu, element, event)
				return ChatClientIsChatting(f2_arg1)
			end,
		},
		{
			stateName = "ChatActive_PublicBeta",
			condition = function(menu, element, event)
				return ChatClientInGameChatIsActive(f2_arg1)
			end,
		},
		{
			stateName = "InStartMenu_PublicBeta",
			condition = function(menu, element, event)
				local f7_local0
				if Engine.IsVisibilityBitSet(f2_arg1, Enum.UIVisibilityBit[@"bit_hud_visible"]) then
					f7_local0 = Engine.IsVisibilityBitSet(f2_arg1, Enum.UIVisibilityBit[@"bit_ui_active"])
				else
					f7_local0 = true
				end
				return f7_local0
			end,
		},
		{
			stateName = "Chatting",
			condition = function(menu, element, event)
				return ChatClientIsChatting(f2_arg1)
			end,
		},
		{
			stateName = "ChatActive",
			condition = function(menu, element, event)
				return ChatClientInGameChatIsActive(f2_arg1)
			end,
		},
		{
			stateName = "InStartMenu",
			condition = function(menu, element, event)
				local f10_local0
				if Engine.IsVisibilityBitSet(f2_arg1, Enum.UIVisibilityBit[@"bit_hud_visible"]) then
					f10_local0 = Engine.IsVisibilityBitSet(f2_arg1, Enum.UIVisibilityBit[@"bit_ui_active"])
				else
					f10_local0 = true
				end
				return f10_local0
			end,
		},
	})
	local f2_local15 = self
	local f2_local16 = self.subscribeToModel
	local f2_local17 = Engine.GetModelForController(f2_arg1)
	f2_local16(f2_local15, f2_local17["ChatGlobal.Event"], function(f11_arg0)
		f2_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f2_arg0,
			controller = f2_arg1,
			modelValue = f11_arg0:get(),
			modelName = "ChatGlobal.Event",
		})
	end, false)
	f2_local15 = self
	f2_local16 = self.subscribeToModel
	f2_local17 = Engine.GetModelForController(f2_arg1)
	f2_local16(f2_local15, f2_local17["ChatGlobal.inGameChatActive"], function(f12_arg0)
		f2_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f2_arg0,
			controller = f2_arg1,
			modelValue = f12_arg0:get(),
			modelName = "ChatGlobal.inGameChatActive",
		})
	end, false)
	f2_local15 = self
	f2_local16 = self.subscribeToModel
	f2_local17 = Engine.GetModelForController(f2_arg1)
	f2_local16(f2_local15, f2_local17["UIVisibilityBit." .. Enum.UIVisibilityBit[@"bit_hud_visible"]], function(f13_arg0)
		f2_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f2_arg0,
			controller = f2_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit[@"bit_hud_visible"],
		})
	end, false)
	f2_local15 = self
	f2_local16 = self.subscribeToModel
	f2_local17 = Engine.GetModelForController(f2_arg1)
	f2_local16(f2_local15, f2_local17["UIVisibilityBit." .. Enum.UIVisibilityBit[@"bit_ui_active"]], function(f14_arg0)
		f2_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f2_arg0,
			controller = f2_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit[@"bit_ui_active"],
		})
	end, false)
	emptyFocusable.id = "emptyFocusable"
	ChatClientChatEntryStaticView.id = "ChatClientChatEntryStaticView"
	ChatClientChatEntryScrollViewContainer.id = "ChatClientChatEntryScrollViewContainer"
	InputText.id = "InputText"
	FiltersButton.id = "FiltersButton"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f2_arg1, f2_arg0)
	end
	f2_local16 = self
	CoD.PCWidgetUtility.RegisterInGameChatEventActivated(f2_arg1, f2_arg0, self)
	return self
end
CoD.IngameChatClient.__resetProperties = function(f15_arg0)
	f15_arg0.InputText:completeAnimation()
	f15_arg0.FiltersButton:completeAnimation()
	f15_arg0.ChatClientChatEntryScrollViewContainer:completeAnimation()
	f15_arg0.InputTextLineDeco:completeAnimation()
	f15_arg0.InputTextDotRC:completeAnimation()
	f15_arg0.InputTextDotLC:completeAnimation()
	f15_arg0.InputTextBackground:completeAnimation()
	f15_arg0.ChatClientChatEntryStaticView:completeAnimation()
	f15_arg0.ChatEntriesDotTRC:completeAnimation()
	f15_arg0.ChatEntriesDotTLC:completeAnimation()
	f15_arg0.ChatEntriesDotBRC:completeAnimation()
	f15_arg0.ChatEntriesDotBLC:completeAnimation()
	f15_arg0.ChatEntriesBackground:completeAnimation()
	f15_arg0.emptyFocusable:completeAnimation()
	f15_arg0.InputText:setLeftRight(0.5, 0.5, -255, 255)
	f15_arg0.InputText:setTopBottom(0.92, 0.92, -15.5, 15.5)
	f15_arg0.InputText:setAlpha(0)
	f15_arg0.FiltersButton:setAlpha(0)
	f15_arg0.ChatClientChatEntryScrollViewContainer:setAlpha(0)
	f15_arg0.InputTextLineDeco:setAlpha(0)
	f15_arg0.InputTextDotRC:setAlpha(0)
	f15_arg0.InputTextDotLC:setAlpha(0)
	f15_arg0.InputTextBackground:setRGB(0, 0, 0)
	f15_arg0.InputTextBackground:setAlpha(0)
	f15_arg0.ChatClientChatEntryStaticView:setAlpha(1)
	f15_arg0.ChatEntriesDotTRC:setAlpha(0)
	f15_arg0.ChatEntriesDotTLC:setAlpha(0)
	f15_arg0.ChatEntriesDotBRC:setAlpha(0)
	f15_arg0.ChatEntriesDotBLC:setAlpha(0)
	f15_arg0.ChatEntriesBackground:setRGB(0, 0, 0)
	f15_arg0.ChatEntriesBackground:setAlpha(0)
	f15_arg0.emptyFocusable:setTopBottom(0, 1, 0, 0)
	f15_arg0.emptyFocusable:setAlpha(0)
end
CoD.IngameChatClient.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(13)
			f16_arg0.ChatEntriesBackground:completeAnimation()
			f16_arg0.ChatEntriesBackground:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ChatEntriesBackground)
			f16_arg0.ChatEntriesDotBLC:completeAnimation()
			f16_arg0.ChatEntriesDotBLC:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ChatEntriesDotBLC)
			f16_arg0.ChatEntriesDotBRC:completeAnimation()
			f16_arg0.ChatEntriesDotBRC:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ChatEntriesDotBRC)
			f16_arg0.ChatEntriesDotTLC:completeAnimation()
			f16_arg0.ChatEntriesDotTLC:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ChatEntriesDotTLC)
			f16_arg0.ChatEntriesDotTRC:completeAnimation()
			f16_arg0.ChatEntriesDotTRC:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ChatEntriesDotTRC)
			f16_arg0.ChatClientChatEntryStaticView:completeAnimation()
			f16_arg0.ChatClientChatEntryStaticView:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.ChatClientChatEntryStaticView)
			f16_arg0.ChatClientChatEntryScrollViewContainer:completeAnimation()
			f16_arg0.ChatClientChatEntryScrollViewContainer:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ChatClientChatEntryScrollViewContainer)
			f16_arg0.InputTextBackground:completeAnimation()
			f16_arg0.InputTextBackground:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.InputTextBackground)
			f16_arg0.InputTextDotLC:completeAnimation()
			f16_arg0.InputTextDotLC:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.InputTextDotLC)
			f16_arg0.InputTextDotRC:completeAnimation()
			f16_arg0.InputTextDotRC:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.InputTextDotRC)
			f16_arg0.InputTextLineDeco:completeAnimation()
			f16_arg0.InputTextLineDeco:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.InputTextLineDeco)
			f16_arg0.InputText:completeAnimation()
			f16_arg0.InputText:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.InputText)
			f16_arg0.FiltersButton:completeAnimation()
			f16_arg0.FiltersButton:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.FiltersButton)
		end,
	},
	Chatting_PublicBeta = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(13)
			f17_arg0.emptyFocusable:completeAnimation()
			f17_arg0.emptyFocusable:setTopBottom(0.08, 1, 0, 0)
			f17_arg0.emptyFocusable:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.emptyFocusable)
			f17_arg0.ChatEntriesBackground:completeAnimation()
			f17_arg0.ChatEntriesBackground:setRGB(0, 0, 0)
			f17_arg0.ChatEntriesBackground:setAlpha(0.8)
			f17_arg0.clipFinished(f17_arg0.ChatEntriesBackground)
			f17_arg0.ChatEntriesDotBLC:completeAnimation()
			f17_arg0.ChatEntriesDotBLC:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.ChatEntriesDotBLC)
			f17_arg0.ChatEntriesDotBRC:completeAnimation()
			f17_arg0.ChatEntriesDotBRC:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.ChatEntriesDotBRC)
			f17_arg0.ChatEntriesDotTLC:completeAnimation()
			f17_arg0.ChatEntriesDotTLC:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.ChatEntriesDotTLC)
			f17_arg0.ChatEntriesDotTRC:completeAnimation()
			f17_arg0.ChatEntriesDotTRC:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.ChatEntriesDotTRC)
			f17_arg0.ChatClientChatEntryStaticView:completeAnimation()
			f17_arg0.ChatClientChatEntryStaticView:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.ChatClientChatEntryStaticView)
			f17_arg0.ChatClientChatEntryScrollViewContainer:completeAnimation()
			f17_arg0.ChatClientChatEntryScrollViewContainer:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.ChatClientChatEntryScrollViewContainer)
			f17_arg0.InputTextBackground:completeAnimation()
			f17_arg0.InputTextBackground:setRGB(0, 0, 0)
			f17_arg0.InputTextBackground:setAlpha(0.8)
			f17_arg0.clipFinished(f17_arg0.InputTextBackground)
			f17_arg0.InputTextDotLC:completeAnimation()
			f17_arg0.InputTextDotLC:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.InputTextDotLC)
			f17_arg0.InputTextDotRC:completeAnimation()
			f17_arg0.InputTextDotRC:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.InputTextDotRC)
			f17_arg0.InputTextLineDeco:completeAnimation()
			f17_arg0.InputTextLineDeco:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.InputTextLineDeco)
			f17_arg0.InputText:completeAnimation()
			f17_arg0.InputText:setLeftRight(0.45, 0.45, -234.5, 234.5)
			f17_arg0.InputText:setTopBottom(0.92, 0.92, -18, 18)
			f17_arg0.InputText:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.InputText)
		end,
	},
	ChatActive_PublicBeta = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(13)
			f18_arg0.emptyFocusable:completeAnimation()
			f18_arg0.emptyFocusable:setTopBottom(0.08, 1, 0, 0)
			f18_arg0.emptyFocusable:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.emptyFocusable)
			f18_arg0.ChatEntriesBackground:completeAnimation()
			f18_arg0.ChatEntriesBackground:setRGB(0, 0, 0)
			f18_arg0.ChatEntriesBackground:setAlpha(0.8)
			f18_arg0.clipFinished(f18_arg0.ChatEntriesBackground)
			f18_arg0.ChatEntriesDotBLC:completeAnimation()
			f18_arg0.ChatEntriesDotBLC:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.ChatEntriesDotBLC)
			f18_arg0.ChatEntriesDotBRC:completeAnimation()
			f18_arg0.ChatEntriesDotBRC:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.ChatEntriesDotBRC)
			f18_arg0.ChatEntriesDotTLC:completeAnimation()
			f18_arg0.ChatEntriesDotTLC:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.ChatEntriesDotTLC)
			f18_arg0.ChatEntriesDotTRC:completeAnimation()
			f18_arg0.ChatEntriesDotTRC:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.ChatEntriesDotTRC)
			f18_arg0.ChatClientChatEntryStaticView:completeAnimation()
			f18_arg0.ChatClientChatEntryStaticView:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.ChatClientChatEntryStaticView)
			f18_arg0.ChatClientChatEntryScrollViewContainer:completeAnimation()
			f18_arg0.ChatClientChatEntryScrollViewContainer:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.ChatClientChatEntryScrollViewContainer)
			f18_arg0.InputTextBackground:completeAnimation()
			f18_arg0.InputTextBackground:setRGB(0, 0, 0)
			f18_arg0.InputTextBackground:setAlpha(0.8)
			f18_arg0.clipFinished(f18_arg0.InputTextBackground)
			f18_arg0.InputTextDotLC:completeAnimation()
			f18_arg0.InputTextDotLC:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.InputTextDotLC)
			f18_arg0.InputTextDotRC:completeAnimation()
			f18_arg0.InputTextDotRC:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.InputTextDotRC)
			f18_arg0.InputTextLineDeco:completeAnimation()
			f18_arg0.InputTextLineDeco:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.InputTextLineDeco)
			f18_arg0.InputText:completeAnimation()
			f18_arg0.InputText:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.InputText)
		end,
	},
	InStartMenu_PublicBeta = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(5)
			f19_arg0.ChatClientChatEntryStaticView:completeAnimation()
			f19_arg0.ChatClientChatEntryStaticView:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.ChatClientChatEntryStaticView)
			f19_arg0.ChatClientChatEntryScrollViewContainer:completeAnimation()
			f19_arg0.ChatClientChatEntryScrollViewContainer:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.ChatClientChatEntryScrollViewContainer)
			f19_arg0.InputTextBackground:completeAnimation()
			f19_arg0.InputTextBackground:setRGB(1, 0, 0)
			f19_arg0.clipFinished(f19_arg0.InputTextBackground)
			f19_arg0.InputText:completeAnimation()
			f19_arg0.InputText:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.InputText)
			f19_arg0.FiltersButton:completeAnimation()
			f19_arg0.FiltersButton:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.FiltersButton)
		end,
	},
	Chatting = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(14)
			f20_arg0.emptyFocusable:completeAnimation()
			f20_arg0.emptyFocusable:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.emptyFocusable)
			f20_arg0.ChatEntriesBackground:completeAnimation()
			f20_arg0.ChatEntriesBackground:setRGB(0, 0, 0)
			f20_arg0.ChatEntriesBackground:setAlpha(0.8)
			f20_arg0.clipFinished(f20_arg0.ChatEntriesBackground)
			f20_arg0.ChatEntriesDotBLC:completeAnimation()
			f20_arg0.ChatEntriesDotBLC:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.ChatEntriesDotBLC)
			f20_arg0.ChatEntriesDotBRC:completeAnimation()
			f20_arg0.ChatEntriesDotBRC:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.ChatEntriesDotBRC)
			f20_arg0.ChatEntriesDotTLC:completeAnimation()
			f20_arg0.ChatEntriesDotTLC:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.ChatEntriesDotTLC)
			f20_arg0.ChatEntriesDotTRC:completeAnimation()
			f20_arg0.ChatEntriesDotTRC:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.ChatEntriesDotTRC)
			f20_arg0.ChatClientChatEntryStaticView:completeAnimation()
			f20_arg0.ChatClientChatEntryStaticView:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.ChatClientChatEntryStaticView)
			f20_arg0.ChatClientChatEntryScrollViewContainer:completeAnimation()
			f20_arg0.ChatClientChatEntryScrollViewContainer:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.ChatClientChatEntryScrollViewContainer)
			f20_arg0.InputTextBackground:completeAnimation()
			f20_arg0.InputTextBackground:setRGB(0, 0, 0)
			f20_arg0.InputTextBackground:setAlpha(0.8)
			f20_arg0.clipFinished(f20_arg0.InputTextBackground)
			f20_arg0.InputTextDotLC:completeAnimation()
			f20_arg0.InputTextDotLC:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.InputTextDotLC)
			f20_arg0.InputTextDotRC:completeAnimation()
			f20_arg0.InputTextDotRC:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.InputTextDotRC)
			f20_arg0.InputTextLineDeco:completeAnimation()
			f20_arg0.InputTextLineDeco:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.InputTextLineDeco)
			f20_arg0.InputText:completeAnimation()
			f20_arg0.InputText:setLeftRight(0.45, 0.45, -234.5, 234.5)
			f20_arg0.InputText:setTopBottom(0.92, 0.92, -18, 18)
			f20_arg0.InputText:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.InputText)
			f20_arg0.FiltersButton:completeAnimation()
			f20_arg0.FiltersButton:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.FiltersButton)
		end,
	},
	ChatActive = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(14)
			f21_arg0.emptyFocusable:completeAnimation()
			f21_arg0.emptyFocusable:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.emptyFocusable)
			f21_arg0.ChatEntriesBackground:completeAnimation()
			f21_arg0.ChatEntriesBackground:setRGB(0, 0, 0)
			f21_arg0.ChatEntriesBackground:setAlpha(0.8)
			f21_arg0.clipFinished(f21_arg0.ChatEntriesBackground)
			f21_arg0.ChatEntriesDotBLC:completeAnimation()
			f21_arg0.ChatEntriesDotBLC:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.ChatEntriesDotBLC)
			f21_arg0.ChatEntriesDotBRC:completeAnimation()
			f21_arg0.ChatEntriesDotBRC:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.ChatEntriesDotBRC)
			f21_arg0.ChatEntriesDotTLC:completeAnimation()
			f21_arg0.ChatEntriesDotTLC:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.ChatEntriesDotTLC)
			f21_arg0.ChatEntriesDotTRC:completeAnimation()
			f21_arg0.ChatEntriesDotTRC:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.ChatEntriesDotTRC)
			f21_arg0.ChatClientChatEntryStaticView:completeAnimation()
			f21_arg0.ChatClientChatEntryStaticView:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.ChatClientChatEntryStaticView)
			f21_arg0.ChatClientChatEntryScrollViewContainer:completeAnimation()
			f21_arg0.ChatClientChatEntryScrollViewContainer:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.ChatClientChatEntryScrollViewContainer)
			f21_arg0.InputTextBackground:completeAnimation()
			f21_arg0.InputTextBackground:setRGB(0, 0, 0)
			f21_arg0.InputTextBackground:setAlpha(0.8)
			f21_arg0.clipFinished(f21_arg0.InputTextBackground)
			f21_arg0.InputTextDotLC:completeAnimation()
			f21_arg0.InputTextDotLC:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.InputTextDotLC)
			f21_arg0.InputTextDotRC:completeAnimation()
			f21_arg0.InputTextDotRC:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.InputTextDotRC)
			f21_arg0.InputTextLineDeco:completeAnimation()
			f21_arg0.InputTextLineDeco:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.InputTextLineDeco)
			f21_arg0.InputText:completeAnimation()
			f21_arg0.InputText:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.InputText)
			f21_arg0.FiltersButton:completeAnimation()
			f21_arg0.FiltersButton:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.FiltersButton)
		end,
	},
	InStartMenu = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(5)
			f22_arg0.ChatClientChatEntryStaticView:completeAnimation()
			f22_arg0.ChatClientChatEntryStaticView:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.ChatClientChatEntryStaticView)
			f22_arg0.ChatClientChatEntryScrollViewContainer:completeAnimation()
			f22_arg0.ChatClientChatEntryScrollViewContainer:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.ChatClientChatEntryScrollViewContainer)
			f22_arg0.InputTextBackground:completeAnimation()
			f22_arg0.InputTextBackground:setRGB(1, 0, 0)
			f22_arg0.clipFinished(f22_arg0.InputTextBackground)
			f22_arg0.InputText:completeAnimation()
			f22_arg0.InputText:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.InputText)
			f22_arg0.FiltersButton:completeAnimation()
			f22_arg0.FiltersButton:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.FiltersButton)
		end,
	},
}
CoD.IngameChatClient.__onClose = function(f23_arg0)
	f23_arg0.emptyFocusable:close()
	f23_arg0.ChatClientChatEntryStaticView:close()
	f23_arg0.ChatClientChatEntryScrollViewContainer:close()
	f23_arg0.InputText:close()
	f23_arg0.FiltersButton:close()
end
