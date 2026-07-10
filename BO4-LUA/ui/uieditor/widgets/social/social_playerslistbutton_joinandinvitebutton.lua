CoD.Social_PlayersListButton_JoinAndInviteButton = InheritFrom(LUI.UIElement)
CoD.Social_PlayersListButton_JoinAndInviteButton.__defaultWidth = 35
CoD.Social_PlayersListButton_JoinAndInviteButton.__defaultHeight = 36
CoD.Social_PlayersListButton_JoinAndInviteButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_PlayersListButton_JoinAndInviteButton)
	self.id = "Social_PlayersListButton_JoinAndInviteButton"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local joinableIcon = LUI.UIImage.new(1, 1, -24, 0, 0.5, 0.5, -18, 18)
	joinableIcon:setRGB(0.87, 0.9, 0.9)
	joinableIcon:setImage(RegisterImage(0xD3145ED87B4F77F))
	joinableIcon:setMaterial(LUI.UIImage.GetCachedMaterial(0xE8F55203998700A))
	self:addElement(joinableIcon)
	self.joinableIcon = joinableIcon
	self:mergeStateConditions({
		{
			stateName = "InviteToPartyPending",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "partyInviteStatus", CoD.PCWidgetUtility.SocialInviteStatus.PENDING)
			end,
		},
		{
			stateName = "JoinableLimited",
			condition = function(menu, element, event)
				local f3_local0 = CoD.SocialUtility.IsPartyMissingDLCFriendUsing(f1_arg1, element)
				if f3_local0 then
					f3_local0 = IsPC()
					if f3_local0 then
						f3_local0 = not CoD.SocialUtility.IsPartyMissingDLCFriendRequires(f1_arg1, element)
					end
				end
				return f3_local0
			end,
		},
		{
			stateName = "Joinable",
			condition = function(menu, element, event)
				return IsJoinable(element, f1_arg1)
			end,
		},
		{
			stateName = "InviteToParty",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "primaryPresence", Enum[0x5904C991C9847C2][0xDB6E2B269A58541])
			end,
		},
	})
	self:linkToElementModel(self, "partyInviteStatus", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "partyInviteStatus",
		})
	end)
	self:linkToElementModel(self, " playlist", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = " playlist",
		})
	end)
	self:linkToElementModel(self, "mapId", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "mapId",
		})
	end)
	self:linkToElementModel(self, "lobbyDLCBits", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "lobbyDLCBits",
		})
	end)
	self:linkToElementModel(self, "joinable", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "joinable",
		})
	end)
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyLockedIn"], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "lobbyRoot.lobbyLockedIn",
		})
	end, false)
	self:linkToElementModel(self, "primaryPresence", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "primaryPresence",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Social_PlayersListButton_JoinAndInviteButton.__resetProperties = function(f13_arg0)
	f13_arg0.joinableIcon:completeAnimation()
	f13_arg0.joinableIcon:setLeftRight(1, 1, -24, 0)
	f13_arg0.joinableIcon:setTopBottom(0.5, 0.5, -18, 18)
	f13_arg0.joinableIcon:setAlpha(1)
end
CoD.Social_PlayersListButton_JoinAndInviteButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.joinableIcon:completeAnimation()
			f14_arg0.joinableIcon:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.joinableIcon)
		end,
	},
	InviteToPartyPending = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.joinableIcon:completeAnimation()
			f15_arg0.joinableIcon:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.joinableIcon)
		end,
		Focus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.joinableIcon:completeAnimation()
			f16_arg0.joinableIcon:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.joinableIcon)
		end,
	},
	JoinableLimited = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.joinableIcon:completeAnimation()
			f17_arg0.joinableIcon:setLeftRight(1, 1, -29.5, -5.5)
			f17_arg0.joinableIcon:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.joinableIcon)
		end,
		Focus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.joinableIcon:completeAnimation()
			f18_arg0.joinableIcon:setLeftRight(1, 1, -31, -4)
			f18_arg0.joinableIcon:setTopBottom(0.5, 0.5, -20.5, 20.5)
			f18_arg0.joinableIcon:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.joinableIcon)
		end,
	},
	Joinable = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.joinableIcon:completeAnimation()
			f19_arg0.joinableIcon:setLeftRight(1, 1, -29.5, -5.5)
			f19_arg0.joinableIcon:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.joinableIcon)
		end,
		Focus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.joinableIcon:completeAnimation()
			f20_arg0.joinableIcon:setLeftRight(1, 1, -31, -4)
			f20_arg0.joinableIcon:setTopBottom(0.5, 0.5, -20.5, 20.5)
			f20_arg0.joinableIcon:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.joinableIcon)
		end,
	},
	InviteToParty = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.joinableIcon:completeAnimation()
			f21_arg0.joinableIcon:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.joinableIcon)
		end,
		Focus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.joinableIcon:completeAnimation()
			f22_arg0.joinableIcon:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.joinableIcon)
		end,
	},
}
