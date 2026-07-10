CoD.MapVoteOfficial = InheritFrom(LUI.UIElement)
CoD.MapVoteOfficial.__defaultWidth = 195
CoD.MapVoteOfficial.__defaultHeight = 22
CoD.MapVoteOfficial.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MapVoteOfficial)
	self.id = "MapVoteOfficial"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Official = LUI.UIText.new(0, 1, 0, 0, 0, 1, 0, 0)
	Official:setRGB(0.63, 0.62, 0.61)
	Official:setText(Engine[0xF9F1239CFD921FE](0x3428A4FD23FDA2A))
	Official:setTTF("ttmussels_regular")
	Official:setLetterSpacing(4)
	Official:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Official:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Official)
	self.Official = Official
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueTrue("MapVote.isOfficialVariant") and IsLobbyMode(Enum[0x8409AA0F01B5DBC][0xF5EE25D311E5223])
			end,
		},
		{
			stateName = "Custom",
			condition = function(menu, element, event)
				return IsLobbyMode(Enum[0x8409AA0F01B5DBC][0xF5EE25D311E5223])
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["MapVote.isOfficialVariant"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "MapVote.isOfficialVariant",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "GametypeSettings", "Update", function(model)
		local f6_local0 = self
		CoD.LobbyUtility.UpdateOfficialCustomGame(f1_arg1, Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], false)
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MapVoteOfficial.__resetProperties = function(f7_arg0)
	f7_arg0.Official:completeAnimation()
	f7_arg0.Official:setAlpha(1)
	f7_arg0.Official:setText(Engine[0xF9F1239CFD921FE](0x3428A4FD23FDA2A))
end
CoD.MapVoteOfficial.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.Official:completeAnimation()
			f8_arg0.Official:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Official)
		end,
	},
	Visible = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	Custom = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.Official:completeAnimation()
			f10_arg0.Official:setText(Engine[0xF9F1239CFD921FE](0xDD2BE2574C9D2CC))
			f10_arg0.clipFinished(f10_arg0.Official)
		end,
	},
}
