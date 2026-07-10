require("x64:b0a49856f2dee8f")
CoD.DirectorLobbyMemberInternalNeverExpand = InheritFrom(LUI.UIElement)
CoD.DirectorLobbyMemberInternalNeverExpand.__defaultWidth = 68
CoD.DirectorLobbyMemberInternalNeverExpand.__defaultHeight = 68
CoD.DirectorLobbyMemberInternalNeverExpand.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorLobbyMemberInternalNeverExpand)
	self.id = "DirectorLobbyMemberInternalNeverExpand"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LobbyMember = CoD.DirectorLobbyMemberInternalCardNeverExpanded.new(f1_arg0, f1_arg1, 0, 0, 0, 68, 0, 0, 0, 68)
	LobbyMember:linkToElementModel(self, nil, false, function(model)
		LobbyMember:setModel(model, f1_arg1)
	end)
	self:addElement(LobbyMember)
	self.LobbyMember = LobbyMember
	self:mergeStateConditions({
		{
			stateName = "FirstEmpty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, f1_arg1, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY)
			end,
		},
	})
	self:linkToElementModel(self, "clientListFlags", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientListFlags",
		})
	end)
	LobbyMember.id = "LobbyMember"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorLobbyMemberInternalNeverExpand.__resetProperties = function(f5_arg0)
	f5_arg0.LobbyMember:completeAnimation()
	f5_arg0.LobbyMember:setAlpha(1)
	f5_arg0.LobbyMember:setScale(1, 1)
end
CoD.DirectorLobbyMemberInternalNeverExpand.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.LobbyMember:completeAnimation()
			f7_arg0.LobbyMember:setScale(1.05, 1.05)
			f7_arg0.clipFinished(f7_arg0.LobbyMember)
		end,
		GainChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.LobbyMember:beginAnimation(200)
				f8_arg0.LobbyMember:setScale(1.05, 1.05)
				f8_arg0.LobbyMember:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.LobbyMember:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.LobbyMember:completeAnimation()
			f8_arg0.LobbyMember:setScale(1, 1)
			f8_local0(f8_arg0.LobbyMember)
		end,
		LoseChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				f10_arg0.LobbyMember:beginAnimation(200)
				f10_arg0.LobbyMember:setScale(1, 1)
				f10_arg0.LobbyMember:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.LobbyMember:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.LobbyMember:completeAnimation()
			f10_arg0.LobbyMember:setScale(1.05, 1.05)
			f10_local0(f10_arg0.LobbyMember)
		end,
	},
	FirstEmpty = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.LobbyMember:completeAnimation()
			f12_arg0.LobbyMember:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.LobbyMember)
		end,
	},
}
CoD.DirectorLobbyMemberInternalNeverExpand.__onClose = function(f13_arg0)
	f13_arg0.LobbyMember:close()
end
