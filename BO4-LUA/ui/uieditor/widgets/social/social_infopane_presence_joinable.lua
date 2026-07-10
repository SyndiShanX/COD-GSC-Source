require("x64:d81ae0388b79d50")
require("x64:5e73ce7b97371ae")
CoD.Social_InfoPane_Presence_Joinable = InheritFrom(LUI.UIElement)
CoD.Social_InfoPane_Presence_Joinable.__defaultWidth = 300
CoD.Social_InfoPane_Presence_Joinable.__defaultHeight = 52
CoD.Social_InfoPane_Presence_Joinable.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_InfoPane_Presence_Joinable)
	self.id = "Social_InfoPane_Presence_Joinable"
	self.soundSet = "ChooseDecal"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SocialJoinBtn = CoD.Social_JoinBtn.new(f1_arg0, f1_arg1, 0, 0, 165, 298, 0, 0, 0, 36)
	SocialJoinBtn:linkToElementModel(self, nil, false, function(model)
		SocialJoinBtn:setModel(model, f1_arg1)
	end)
	SocialJoinBtn:registerEventHandler("button_action", function(element, event)
		local f3_local0 = nil
		SendButtonPressToMenuEx(f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	self:addElement(SocialJoinBtn)
	self.SocialJoinBtn = SocialJoinBtn
	local joinableIcon = CoD.Social_InfoPane_Presence_JoinableIcon.new(f1_arg0, f1_arg1, 0, 0, 2, 240, 0, 0, 0, 36)
	joinableIcon:linkToElementModel(self, nil, false, function(model)
		joinableIcon:setModel(model, f1_arg1)
	end)
	self:addElement(joinableIcon)
	self.joinableIcon = joinableIcon
	local NotJoinableReason = LUI.UIText.new(0.5, 0.5, -142, 142, 0, 0, 36, 50)
	NotJoinableReason:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	NotJoinableReason:setTTF("dinnext_regular")
	NotJoinableReason:setLetterSpacing(1)
	NotJoinableReason:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	NotJoinableReason:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	NotJoinableReason:linkToElementModel(self, "joinable", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			NotJoinableReason:setText(Engine[@"hash_4F9F1239CFD921FE"](LobbyJoinableToString(f5_local0)))
		end
	end)
	self:addElement(NotJoinableReason)
	self.NotJoinableReason = NotJoinableReason
	self:mergeStateConditions({
		{
			stateName = "LobbyLocked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.lobbyLockedIn")
			end,
		},
		{
			stateName = "PartyTab",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("socialRoot.tab", "party")
			end,
		},
		{
			stateName = "HideJoinButton",
			condition = function(menu, element, event)
				return PropertyIsTrue(self, "hideJoinButton")
			end,
		},
		{
			stateName = "NotJoinable",
			condition = function(menu, element, event)
				return not IsJoinable(element, f1_arg1)
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[@"getglobalmodel"]()
	f1_local5(f1_local4, f1_local6["lobbyRoot.lobbyLockedIn"], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "lobbyRoot.lobbyLockedIn",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getglobalmodel"]()
	f1_local5(f1_local4, f1_local6["socialRoot.tab"], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "socialRoot.tab",
		})
	end, false)
	self:linkToElementModel(self, "joinable", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "joinable",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local5 = self
	if IsPC() then
		CoD.PCUtility.SetForceMouseEventDispatch(self, true)
	end
	return self
end
CoD.Social_InfoPane_Presence_Joinable.__resetProperties = function(f13_arg0)
	f13_arg0.SocialJoinBtn:completeAnimation()
	f13_arg0.joinableIcon:completeAnimation()
	f13_arg0.NotJoinableReason:completeAnimation()
	f13_arg0.SocialJoinBtn:setAlpha(1)
	f13_arg0.joinableIcon:setAlpha(1)
	f13_arg0.NotJoinableReason:setAlpha(1)
end
CoD.Social_InfoPane_Presence_Joinable.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.SocialJoinBtn:completeAnimation()
			f14_arg0.SocialJoinBtn:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.SocialJoinBtn)
			f14_arg0.joinableIcon:completeAnimation()
			f14_arg0.joinableIcon:setAlpha(0.8)
			f14_arg0.clipFinished(f14_arg0.joinableIcon)
		end,
	},
	LobbyLocked = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.SocialJoinBtn:completeAnimation()
			f15_arg0.SocialJoinBtn:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.SocialJoinBtn)
		end,
	},
	PartyTab = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.SocialJoinBtn:completeAnimation()
			f16_arg0.SocialJoinBtn:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.SocialJoinBtn)
			f16_arg0.joinableIcon:completeAnimation()
			f16_arg0.joinableIcon:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.joinableIcon)
		end,
	},
	HideJoinButton = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.SocialJoinBtn:completeAnimation()
			f17_arg0.SocialJoinBtn:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.SocialJoinBtn)
		end,
	},
	NotJoinable = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.SocialJoinBtn:completeAnimation()
			f18_arg0.SocialJoinBtn:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.SocialJoinBtn)
			f18_arg0.NotJoinableReason:completeAnimation()
			f18_arg0.NotJoinableReason:setAlpha(0.5)
			f18_arg0.clipFinished(f18_arg0.NotJoinableReason)
		end,
	},
}
CoD.Social_InfoPane_Presence_Joinable.__onClose = function(f19_arg0)
	f19_arg0.SocialJoinBtn:close()
	f19_arg0.joinableIcon:close()
	f19_arg0.NotJoinableReason:close()
end
