require("x64:e4fee79c080ccb9")
CoD.ChatClientPassiveEntryDisplay = InheritFrom(LUI.UIElement)
CoD.ChatClientPassiveEntryDisplay.__defaultWidth = 540
CoD.ChatClientPassiveEntryDisplay.__defaultHeight = 290
CoD.ChatClientPassiveEntryDisplay.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChatClientPassiveEntryDisplay)
	self.id = "ChatClientPassiveEntryDisplay"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ChatBackground = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ChatBackground:setAlpha(0)
	ChatBackground:setImage(RegisterImage(@"hash_6FECB0E0003975BA"))
	self:addElement(ChatBackground)
	self.ChatBackground = ChatBackground
	local ChatClientChatEntryStaticView = CoD.ChatClientChatEntryStaticView.new(f1_arg0, f1_arg1, 0.03, 0.03, -2, 516, 0.07, 0.07, 2.5, 213.5)
	ChatClientChatEntryStaticView:setAlpha(0.5)
	self:addElement(ChatClientChatEntryStaticView)
	self.ChatClientChatEntryStaticView = ChatClientChatEntryStaticView
	self:mergeStateConditions({
		{
			stateName = "Active",
			condition = function(menu, element, event)
				local f2_local0
				if not CoD.PCUtility.MenuChatIsActive(f1_arg1) then
					f2_local0 = CoD.PCUtility.IsBGSEnabled()
				else
					f2_local0 = false
				end
				return f2_local0
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["ChatGlobal.ChatAvailableInMenuEvent"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "ChatGlobal.ChatAvailableInMenuEvent",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["ChatGlobal.MenuChatInActiveMode"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "ChatGlobal.MenuChatInActiveMode",
		})
	end, false)
	ChatClientChatEntryStaticView.id = "ChatClientChatEntryStaticView"
	self.__defaultFocus = ChatClientChatEntryStaticView
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local4 = self
	DisableKeyboardNavigationByElement(self)
	CoD.PCUtility.PreSetupPassiveChat(self, f1_arg0, f1_arg1)
	return self
end
CoD.ChatClientPassiveEntryDisplay.__resetProperties = function(f5_arg0)
	f5_arg0.ChatClientChatEntryStaticView:completeAnimation()
	f5_arg0.ChatBackground:completeAnimation()
	f5_arg0.ChatClientChatEntryStaticView:setTopBottom(0.07, 0.07, 2.5, 213.5)
	f5_arg0.ChatClientChatEntryStaticView:setAlpha(0.5)
	f5_arg0.ChatBackground:setTopBottom(0, 1, 0, 0)
	f5_arg0.ChatBackground:setAlpha(0)
end
CoD.ChatClientPassiveEntryDisplay.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.ChatClientChatEntryStaticView:completeAnimation()
			f6_arg0.ChatClientChatEntryStaticView:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.ChatClientChatEntryStaticView)
		end,
	},
	Active = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			local f7_local0 = function(f8_arg0)
				f7_arg0.ChatBackground:beginAnimation(180)
				f7_arg0.ChatBackground:setTopBottom(0.64, 1.12, 0, 0)
				f7_arg0.ChatBackground:setAlpha(0)
				f7_arg0.ChatBackground:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.ChatBackground:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.ChatBackground:completeAnimation()
			f7_arg0.ChatBackground:setTopBottom(0, 1, 0, 0)
			f7_arg0.ChatBackground:setAlpha(1)
			f7_local0(f7_arg0.ChatBackground)
			local f7_local1 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(20)
					f10_arg0:setTopBottom(0.07, 0.07, 150.5, 213.5)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f7_arg0.ChatClientChatEntryStaticView:beginAnimation(80)
				f7_arg0.ChatClientChatEntryStaticView:setTopBottom(0.07, 0.07, 117.5, 213.5)
				f7_arg0.ChatClientChatEntryStaticView:setAlpha(1)
				f7_arg0.ChatClientChatEntryStaticView:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.ChatClientChatEntryStaticView:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f7_arg0.ChatClientChatEntryStaticView:completeAnimation()
			f7_arg0.ChatClientChatEntryStaticView:setTopBottom(0.07, 0.07, 2.5, 213.5)
			f7_arg0.ChatClientChatEntryStaticView:setAlpha(0)
			f7_local1(f7_arg0.ChatClientChatEntryStaticView)
		end,
	},
}
CoD.ChatClientPassiveEntryDisplay.__onClose = function(f11_arg0)
	f11_arg0.ChatClientChatEntryStaticView:close()
end
