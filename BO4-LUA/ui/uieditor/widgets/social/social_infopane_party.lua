require("x64:39a75111725556")
CoD.Social_InfoPane_Party = InheritFrom(LUI.UIElement)
CoD.Social_InfoPane_Party.__defaultWidth = 290
CoD.Social_InfoPane_Party.__defaultHeight = 169
CoD.Social_InfoPane_Party.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_InfoPane_Party)
	self.id = "Social_InfoPane_Party"
	self.soundSet = "ChooseDecal"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local partyHeader = LUI.UIText.new(0, 0, 0, 290, 0, 0, 0, 18)
	partyHeader:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	partyHeader:setZoom(5)
	partyHeader:setText(LocalizeToUpperString(0xCF48FF8759D4662))
	partyHeader:setTTF("ttmussels_regular")
	partyHeader:setLetterSpacing(3)
	partyHeader:setLineSpacing(1)
	partyHeader:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(partyHeader)
	self.partyHeader = partyHeader
	local PlayerList = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, false, false, false, false)
	PlayerList:setLeftRight(0, 0, 20, 458)
	PlayerList:setTopBottom(0, 0, 23, 151)
	PlayerList:setWidgetType(CoD.Social_PartyList)
	PlayerList:setVerticalCount(5)
	PlayerList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	PlayerList:setDataSource("SocialPlayerPartyList")
	self:addElement(PlayerList)
	self.PlayerList = PlayerList
	self:mergeStateConditions({
		{
			stateName = "Hide",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("socialRoot.tab", "party")
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[0x8DF2E5447F384B9]()
	f1_local4(f1_local3, f1_local5["socialRoot.tab"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "socialRoot.tab",
		})
	end, false)
	PlayerList.id = "PlayerList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Social_InfoPane_Party.__resetProperties = function(f4_arg0)
	f4_arg0.partyHeader:completeAnimation()
	f4_arg0.PlayerList:completeAnimation()
	f4_arg0.partyHeader:setAlpha(1)
	f4_arg0.PlayerList:setAlpha(1)
end
CoD.Social_InfoPane_Party.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	Hide = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.partyHeader:completeAnimation()
			f6_arg0.partyHeader:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.partyHeader)
			f6_arg0.PlayerList:completeAnimation()
			f6_arg0.PlayerList:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.PlayerList)
		end,
	},
}
CoD.Social_InfoPane_Party.__onClose = function(f7_arg0)
	f7_arg0.PlayerList:close()
end
