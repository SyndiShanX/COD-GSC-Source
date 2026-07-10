require("x64:dbf8e26e700cf9")
require("x64:67d0ddbbd0a1724")
CoD.DirectorTeamMember = InheritFrom(LUI.UIElement)
CoD.DirectorTeamMember.__defaultWidth = 400
CoD.DirectorTeamMember.__defaultHeight = 85
CoD.DirectorTeamMember.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorTeamMember)
	self.id = "DirectorTeamMember"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local EmptyText = CoD.DirectorTeamMemberEmpty.new(f1_arg0, f1_arg1, 0, 0, 0, 400, 0, 0, 0, 85)
	EmptyText:linkToElementModel(self, nil, false, function(model)
		EmptyText:setModel(model, f1_arg1)
	end)
	self:addElement(EmptyText)
	self.EmptyText = EmptyText
	local TeamMemberInfo = CoD.DirectorTeamMemberInfo.new(f1_arg0, f1_arg1, 0, 0, 0, 400, 0, 0, 0, 85)
	TeamMemberInfo:linkToElementModel(self, nil, false, function(model)
		TeamMemberInfo:setModel(model, f1_arg1)
	end)
	self:addElement(TeamMemberInfo)
	self.TeamMemberInfo = TeamMemberInfo
	self:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.IsClientEmpty(f1_arg1, element)
			end,
		},
		{
			stateName = "Selected",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualToSelfModelValue(element, "lobbyRoot.selectedXuid", "xuid")
			end,
		},
	})
	self:linkToElementModel(self, "xuid", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "xuid",
		})
	end)
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[@"getglobalmodel"]()
	f1_local4(f1_local3, f1_local5["lobbyRoot.selectedXuid"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "lobbyRoot.selectedXuid",
		})
	end, false)
	EmptyText.id = "EmptyText"
	TeamMemberInfo.id = "TeamMemberInfo"
	self.__defaultFocus = TeamMemberInfo
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local4 = self
	if IsPC() then
		CoD.PCWidgetUtility.SetupRightClickableContextualPlayerMenu(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorTeamMember.__resetProperties = function(f8_arg0)
	f8_arg0.EmptyText:completeAnimation()
	f8_arg0.TeamMemberInfo:completeAnimation()
	f8_arg0.EmptyText:setAlpha(1)
	f8_arg0.EmptyText:setScale(1, 1)
	f8_arg0.TeamMemberInfo:setAlpha(1)
	f8_arg0.TeamMemberInfo:setScale(1, 1)
end
CoD.DirectorTeamMember.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.EmptyText:completeAnimation()
			f9_arg0.EmptyText:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.EmptyText)
		end,
		ChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.EmptyText:completeAnimation()
			f10_arg0.EmptyText:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.EmptyText)
			f10_arg0.TeamMemberInfo:completeAnimation()
			f10_arg0.TeamMemberInfo:setScale(1.05, 1.05)
			f10_arg0.clipFinished(f10_arg0.TeamMemberInfo)
		end,
		LoseChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.EmptyText:completeAnimation()
			f11_arg0.EmptyText:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.EmptyText)
			local f11_local0 = function(f12_arg0)
				f11_arg0.TeamMemberInfo:beginAnimation(200)
				f11_arg0.TeamMemberInfo:setScale(1.02, 1.02)
				f11_arg0.TeamMemberInfo:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.TeamMemberInfo:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.TeamMemberInfo:completeAnimation()
			f11_arg0.TeamMemberInfo:setScale(1.05, 1.05)
			f11_local0(f11_arg0.TeamMemberInfo)
		end,
		GainChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.EmptyText:completeAnimation()
			f13_arg0.EmptyText:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.EmptyText)
			local f13_local0 = function(f14_arg0)
				f13_arg0.TeamMemberInfo:beginAnimation(200)
				f13_arg0.TeamMemberInfo:setScale(1.05, 1.05)
				f13_arg0.TeamMemberInfo:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.TeamMemberInfo:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.TeamMemberInfo:completeAnimation()
			f13_arg0.TeamMemberInfo:setScale(1.02, 1.02)
			f13_local0(f13_arg0.TeamMemberInfo)
		end,
	},
	Empty = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.TeamMemberInfo:completeAnimation()
			f15_arg0.TeamMemberInfo:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.TeamMemberInfo)
		end,
		ChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.EmptyText:completeAnimation()
			f16_arg0.EmptyText:setScale(1.05, 1.05)
			f16_arg0.clipFinished(f16_arg0.EmptyText)
			f16_arg0.TeamMemberInfo:completeAnimation()
			f16_arg0.TeamMemberInfo:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.TeamMemberInfo)
		end,
		GainChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			local f17_local0 = function(f18_arg0)
				f17_arg0.EmptyText:beginAnimation(200)
				f17_arg0.EmptyText:setScale(1.05, 1.05)
				f17_arg0.EmptyText:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.EmptyText:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.EmptyText:completeAnimation()
			f17_arg0.EmptyText:setScale(1, 1)
			f17_local0(f17_arg0.EmptyText)
			f17_arg0.TeamMemberInfo:completeAnimation()
			f17_arg0.TeamMemberInfo:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.TeamMemberInfo)
		end,
		LoseChildFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			local f19_local0 = function(f20_arg0)
				f19_arg0.EmptyText:beginAnimation(200)
				f19_arg0.EmptyText:setScale(1, 1)
				f19_arg0.EmptyText:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.EmptyText:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.EmptyText:completeAnimation()
			f19_arg0.EmptyText:setScale(1.05, 1.05)
			f19_local0(f19_arg0.EmptyText)
			f19_arg0.TeamMemberInfo:completeAnimation()
			f19_arg0.TeamMemberInfo:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.TeamMemberInfo)
		end,
	},
	Selected = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.TeamMemberInfo:completeAnimation()
			f21_arg0.TeamMemberInfo:setScale(1.05, 1.05)
			f21_arg0.clipFinished(f21_arg0.TeamMemberInfo)
		end,
	},
}
CoD.DirectorTeamMember.__onClose = function(f22_arg0)
	f22_arg0.EmptyText:close()
	f22_arg0.TeamMemberInfo:close()
end
