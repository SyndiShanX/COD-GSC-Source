require("x64:1985ceacbad6078")
CoD.Social_PartyList = InheritFrom(LUI.UIElement)
CoD.Social_PartyList.__defaultWidth = 438
CoD.Social_PartyList.__defaultHeight = 24
CoD.Social_PartyList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_PartyList)
	self.id = "Social_PartyList"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SocialMemberGamerTag = CoD.Social_MemberGamerTag.new(f1_arg0, f1_arg1, 0, 0, 1, 407, 0, 0, 4, 21)
	SocialMemberGamerTag:linkToElementModel(self, "gamertag", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			SocialMemberGamerTag.gamertag:setText(CoD.SocialUtility.CleanGamerTag(f2_local0))
		end
	end)
	self:addElement(SocialMemberGamerTag)
	self.SocialMemberGamerTag = SocialMemberGamerTag
	local PartyLeaderStar = LUI.UIImage.new(-0.19, -0.19, 65, 85, -2.39, -2.39, 58, 78)
	PartyLeaderStar:setRGB(ColorSet.PartyFriendlyBlue.r, ColorSet.PartyFriendlyBlue.g, ColorSet.PartyFriendlyBlue.b)
	PartyLeaderStar:setAlpha(0)
	PartyLeaderStar:setImage(RegisterImage(0xCC30C39E4A100F))
	self:addElement(PartyLeaderStar)
	self.PartyLeaderStar = PartyLeaderStar
	self:mergeStateConditions({
		{
			stateName = "Leader",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualToSelfModelValue(element, "socialRoot.party.leader", "gamertag")
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[0x8DF2E5447F384B9]()
	f1_local4(f1_local3, f1_local5["socialRoot.party.leader"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "socialRoot.party.leader",
		})
	end, false)
	self:linkToElementModel(self, "gamertag", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "gamertag",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Social_PartyList.__resetProperties = function(f6_arg0)
	f6_arg0.PartyLeaderStar:completeAnimation()
	f6_arg0.PartyLeaderStar:setAlpha(0)
end
CoD.Social_PartyList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	Leader = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.PartyLeaderStar:completeAnimation()
			f8_arg0.PartyLeaderStar:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.PartyLeaderStar)
		end,
	},
}
CoD.Social_PartyList.__onClose = function(f9_arg0)
	f9_arg0.SocialMemberGamerTag:close()
end
