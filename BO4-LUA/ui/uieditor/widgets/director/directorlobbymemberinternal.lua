require("x64:e19582705aab870")
CoD.DirectorLobbyMemberInternal = InheritFrom(LUI.UIElement)
CoD.DirectorLobbyMemberInternal.__defaultWidth = 68
CoD.DirectorLobbyMemberInternal.__defaultHeight = 68
CoD.DirectorLobbyMemberInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorLobbyMemberInternal)
	self.id = "DirectorLobbyMemberInternal"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LobbyMember = CoD.DirectorLobbyMemberInternalCard.new(f1_arg0, f1_arg1, 0, 0, 0, 326, 0, 0, 0, 68)
	LobbyMember:linkToElementModel(self, nil, false, function(model)
		LobbyMember:setModel(model, f1_arg1)
	end)
	self:addElement(LobbyMember)
	self.LobbyMember = LobbyMember
	self:mergeStateConditions({
		{
			stateName = "SpecialistHeadqauarters",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.ShowDirectorTraining(f1_arg1)
			end,
		},
		{
			stateName = "FirstEmpty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, f1_arg1, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY)
			end,
		},
		{
			stateName = "AlwaysExpand",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, f1_arg1, "clientListFlags", CoD.DirectorUtility.ClientListFlags.SHOW_EXPANDED)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
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
CoD.DirectorLobbyMemberInternal.__resetProperties = function(f8_arg0)
	f8_arg0.LobbyMember:completeAnimation()
	f8_arg0.LobbyMember:setLeftRight(0, 0, 0, 326)
	f8_arg0.LobbyMember:setAlpha(1)
	f8_arg0.LobbyMember:setScale(1, 1)
end
CoD.DirectorLobbyMemberInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.LobbyMember:completeAnimation()
			f9_arg0.LobbyMember:setLeftRight(0, 0, 0, 68)
			f9_arg0.clipFinished(f9_arg0.LobbyMember)
		end,
		ChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.LobbyMember:completeAnimation()
			f10_arg0.LobbyMember:setLeftRight(0, 0, 0, 68)
			f10_arg0.LobbyMember:setScale(1.05, 1.05)
			f10_arg0.clipFinished(f10_arg0.LobbyMember)
		end,
		GainChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.LobbyMember:beginAnimation(200)
				f11_arg0.LobbyMember:setScale(1.05, 1.05)
				f11_arg0.LobbyMember:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.LobbyMember:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.LobbyMember:completeAnimation()
			f11_arg0.LobbyMember:setLeftRight(0, 0, 0, 68)
			f11_arg0.LobbyMember:setScale(1, 1)
			f11_local0(f11_arg0.LobbyMember)
		end,
		LoseChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			local f13_local0 = function(f14_arg0)
				f13_arg0.LobbyMember:beginAnimation(200)
				f13_arg0.LobbyMember:setScale(1, 1)
				f13_arg0.LobbyMember:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.LobbyMember:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.LobbyMember:completeAnimation()
			f13_arg0.LobbyMember:setLeftRight(0, 0, 0, 68)
			f13_arg0.LobbyMember:setScale(1.05, 1.05)
			f13_local0(f13_arg0.LobbyMember)
		end,
	},
	SpecialistHeadqauarters = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.LobbyMember:completeAnimation()
			f16_arg0.LobbyMember:setScale(1.05, 1.05)
			f16_arg0.clipFinished(f16_arg0.LobbyMember)
		end,
	},
	FirstEmpty = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.LobbyMember:completeAnimation()
			f17_arg0.LobbyMember:setLeftRight(0, 0, 0, 68)
			f17_arg0.LobbyMember:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.LobbyMember)
		end,
	},
	AlwaysExpand = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.LobbyMember:completeAnimation()
			f19_arg0.LobbyMember:setScale(1.05, 1.05)
			f19_arg0.clipFinished(f19_arg0.LobbyMember)
		end,
		GainChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			local f20_local0 = function(f21_arg0)
				f20_arg0.LobbyMember:beginAnimation(200)
				f20_arg0.LobbyMember:setScale(1.05, 1.05)
				f20_arg0.LobbyMember:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.LobbyMember:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.LobbyMember:completeAnimation()
			f20_arg0.LobbyMember:setScale(1, 1)
			f20_local0(f20_arg0.LobbyMember)
		end,
		LoseChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			local f22_local0 = function(f23_arg0)
				f22_arg0.LobbyMember:beginAnimation(200)
				f22_arg0.LobbyMember:setScale(1, 1)
				f22_arg0.LobbyMember:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.LobbyMember:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.LobbyMember:completeAnimation()
			f22_arg0.LobbyMember:setScale(1.05, 1.05)
			f22_local0(f22_arg0.LobbyMember)
		end,
	},
}
CoD.DirectorLobbyMemberInternal.__onClose = function(f24_arg0)
	f24_arg0.LobbyMember:close()
end
