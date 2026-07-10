CoD.DirectorMapVoteRuleIcon = InheritFrom(LUI.UIElement)
CoD.DirectorMapVoteRuleIcon.__defaultWidth = 150
CoD.DirectorMapVoteRuleIcon.__defaultHeight = 150
CoD.DirectorMapVoteRuleIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorMapVoteRuleIcon)
	self.id = "DirectorMapVoteRuleIcon"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local officialIcon = LUI.UIImage.new(0.5, 0.5, -75, 75, 0.5, 0.5, -75, 75)
	officialIcon:setImage(RegisterImage(0xA92DF43D53DFABF))
	self:addElement(officialIcon)
	self.officialIcon = officialIcon
	local Custom = LUI.UIText.new(0, 0, -25, 175, 0, 0, 22, 263)
	Custom:setAlpha(0)
	Custom:setText(Engine[0xF9F1239CFD921FE](0xB53C6BDCB1662EB))
	Custom:setTTF("default")
	Custom:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Custom:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Custom)
	self.Custom = Custom
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return IsCustomMPLobby() and CoD.ModelUtility.IsGlobalModelValueTrue("MapVote.isOfficialVariant")
			end,
		},
		{
			stateName = "Custom",
			condition = function(menu, element, event)
				return IsCustomMPLobby()
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[0x8DF2E5447F384B9]()
	f1_local4(f1_local3, f1_local5["lobbyRoot.lobbyNav"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x8DF2E5447F384B9]()
	f1_local4(f1_local3, f1_local5["MapVote.isOfficialVariant"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "MapVote.isOfficialVariant",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorMapVoteRuleIcon.__resetProperties = function(f6_arg0)
	f6_arg0.officialIcon:completeAnimation()
	f6_arg0.Custom:completeAnimation()
	f6_arg0.officialIcon:setAlpha(1)
	f6_arg0.Custom:setRGB(1, 1, 1)
	f6_arg0.Custom:setAlpha(0)
end
CoD.DirectorMapVoteRuleIcon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.officialIcon:completeAnimation()
			f7_arg0.officialIcon:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.officialIcon)
		end,
	},
	Visible = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Custom = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.officialIcon:completeAnimation()
			f9_arg0.officialIcon:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.officialIcon)
			f9_arg0.Custom:completeAnimation()
			f9_arg0.Custom:setRGB(0.14, 0.73, 0.87)
			f9_arg0.Custom:setAlpha(0.6)
			f9_arg0.clipFinished(f9_arg0.Custom)
		end,
	},
}
