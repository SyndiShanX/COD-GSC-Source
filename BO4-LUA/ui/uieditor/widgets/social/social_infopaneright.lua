require("x64:34cc6596da96a84")
require("x64:4e00e02e26a9da7")
require("x64:a9b9965f6f12714")
require("x64:f0a581682449185")
require("x64:d085ca092d117e3")
require("x64:a9255c570c68aa8")
CoD.Social_InfoPaneRight = InheritFrom(LUI.UIElement)
CoD.Social_InfoPaneRight.__defaultWidth = 303
CoD.Social_InfoPaneRight.__defaultHeight = 741
CoD.Social_InfoPaneRight.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_InfoPaneRight)
	self.id = "Social_InfoPaneRight"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TrialText = CoD.Social_InfoPane_Trial.new(f1_arg0, f1_arg1, 0, 0, 5, 180, 0, 0, 433, 465)
	TrialText:linkToElementModel(self, nil, false, function(model)
		TrialText:setModel(model, f1_arg1)
	end)
	self:addElement(TrialText)
	self.TrialText = TrialText
	local presence2 = CoD.Social_InfoPane_Presence.new(f1_arg0, f1_arg1, 0, 0, 4, 299, 0, 0, 272, 304)
	presence2:setAlpha(0.8)
	presence2:linkToElementModel(self, nil, false, function(model)
		presence2:setModel(model, f1_arg1)
	end)
	self:addElement(presence2)
	self.presence2 = presence2
	local party = CoD.Social_InfoPane_Party.new(f1_arg0, f1_arg1, 0, 0, 5, 295, 0, 0, 499, 668)
	party:linkToElementModel(self, "partySize", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			party:setAlpha(SocialShowPartyHeader(f4_local0))
		end
	end)
	party:linkToElementModel(self, nil, false, function(model)
		party:setModel(model, f1_arg1)
	end)
	self:addElement(party)
	self.party = party
	local SocialInfoPaneDLCStatus = CoD.Social_InfoPane_DLCStatus.new(f1_arg0, f1_arg1, 0, 0.92, 12.5, 12.5, 0, 0, 106, 148)
	SocialInfoPaneDLCStatus:linkToElementModel(self, nil, false, function(model)
		SocialInfoPaneDLCStatus:setModel(model, f1_arg1)
	end)
	self:addElement(SocialInfoPaneDLCStatus)
	self.SocialInfoPaneDLCStatus = SocialInfoPaneDLCStatus
	local SocialInfoPanePresenceJoinable = CoD.Social_InfoPane_Presence_Joinable.new(f1_arg0, f1_arg1, 0, 0, 4, 304, 0, 0, 43.5, 95.5)
	SocialInfoPanePresenceJoinable:linkToElementModel(self, nil, false, function(model)
		SocialInfoPanePresenceJoinable:setModel(model, f1_arg1)
	end)
	self:addElement(SocialInfoPanePresenceJoinable)
	self.SocialInfoPanePresenceJoinable = SocialInfoPanePresenceJoinable
	local FrameBot = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 0, 303, 1, 1, -245, -3)
	FrameBot:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	FrameBot:setAlpha(0.02)
	self:addElement(FrameBot)
	self.FrameBot = FrameBot
	local FrameMid = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 0, 303, 0, 0, 267, 485)
	FrameMid:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	FrameMid:setAlpha(0.02)
	self:addElement(FrameMid)
	self.FrameMid = FrameMid
	local FrameTop = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 0, 303, 0, 0, 39, 257)
	FrameTop:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	FrameTop:setAlpha(0.02)
	self:addElement(FrameTop)
	self.FrameTop = FrameTop
	self:mergeStateConditions({
		{
			stateName = "NoPlayer",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "identityBadge.xuid", LuaDefine.INVALID_XUID_X64)
			end,
		},
	})
	self:linkToElementModel(self, "identityBadge.xuid", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "identityBadge.xuid",
		})
	end)
	party.id = "party"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Social_InfoPaneRight.__resetProperties = function(f10_arg0)
	f10_arg0.presence2:completeAnimation()
	f10_arg0.presence2:setAlpha(0.8)
end
CoD.Social_InfoPaneRight.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
	NoPlayer = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.presence2:completeAnimation()
			f12_arg0.presence2:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.presence2)
		end,
	},
}
CoD.Social_InfoPaneRight.__onClose = function(f13_arg0)
	f13_arg0.TrialText:close()
	f13_arg0.presence2:close()
	f13_arg0.party:close()
	f13_arg0.SocialInfoPaneDLCStatus:close()
	f13_arg0.SocialInfoPanePresenceJoinable:close()
	f13_arg0.FrameBot:close()
	f13_arg0.FrameMid:close()
	f13_arg0.FrameTop:close()
end
