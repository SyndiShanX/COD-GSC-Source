require("ui/uieditor/widgets/chat/ingame/ingamechatclient")
CoD.IngameChatClientContainer = InheritFrom(LUI.UIElement)
CoD.IngameChatClientContainer.__defaultWidth = 540
CoD.IngameChatClientContainer.__defaultHeight = 290
CoD.IngameChatClientContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.PCUtility.StartAddingSticky(f1_arg0, self)
	CoD.PCUtility.PreSetupMenuChat(self, f1_arg0, f1_arg1)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.IngameChatClientContainer)
	self.id = "IngameChatClientContainer"
	self.soundSet = "HUD"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ChatClient = CoD.IngameChatClient.new(f1_arg0, f1_arg1, 0, 0, 0, 540, 0.5, 0.5, -144.5, 145.5)
	ChatClient:subscribeToGlobalModel(f1_arg1, "ChatGlobal", nil, function(model)
		ChatClient:setModel(model, f1_arg1)
	end)
	self:addElement(ChatClient)
	self.ChatClient = ChatClient
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not ChatClientShow(f1_arg1)
			end,
		},
		{
			stateName = "StartMenu",
			condition = function(menu, element, event)
				local f4_local0
				if Engine.IsVisibilityBitSet(f1_arg1, Enum.UIVisibilityBit[@"bit_hud_visible"]) then
					f4_local0 = Engine.IsVisibilityBitSet(f1_arg1, Enum.UIVisibilityBit[@"bit_ui_active"])
				else
					f4_local0 = true
				end
				return f4_local0
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine.GetModelForController(f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum.UIVisibilityBit[@"bit_hud_visible"]], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit[@"bit_hud_visible"],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine.GetModelForController(f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum.UIVisibilityBit[@"bit_ui_active"]], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit[@"bit_ui_active"],
		})
	end, false)
	ChatClient.id = "ChatClient"
	self.__defaultFocus = ChatClient
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	CoD.PCUtility.StopAddingSticky(f1_arg0)
	return self
end
CoD.IngameChatClientContainer.__resetProperties = function(f7_arg0)
	f7_arg0.ChatClient:completeAnimation()
	f7_arg0.ChatClient:setAlpha(1)
end
CoD.IngameChatClientContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.ChatClient:completeAnimation()
			f9_arg0.ChatClient:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.ChatClient)
		end,
	},
	StartMenu = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.IngameChatClientContainer.__onClose = function(f11_arg0)
	f11_arg0.ChatClient:close()
end
