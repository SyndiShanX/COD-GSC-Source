require("x64:7dacefed967e3df")
require("x64:a88f2d181325438")
CoD.DirectorLobbyPartyTierBoost = InheritFrom(LUI.UIElement)
CoD.DirectorLobbyPartyTierBoost.__defaultWidth = 500
CoD.DirectorLobbyPartyTierBoost.__defaultHeight = 55
CoD.DirectorLobbyPartyTierBoost.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BlackMarketUtility.SetupTierSkipModels(f1_arg1, f1_arg0)
	self:setClass(CoD.DirectorLobbyPartyTierBoost)
	self.id = "DirectorLobbyPartyTierBoost"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = CoD.CommonBackingWithBrackets.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Backing)
	self.Backing = Backing
	local TierSkipIcon = LUI.UIImage.new(0, 0, -29, 31, 0.5, 0.5, -30, 30)
	TierSkipIcon:setImage(RegisterImage(0x6EC674D21C5C218))
	self:addElement(TierSkipIcon)
	self.TierSkipIcon = TierSkipIcon
	local Header = LUI.UIText.new(0, 0, 37, 369, 0.5, 0.5, -22, -1)
	Header:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Header:setText(LocalizeToUpperString(0x687BCA25FDF9F2B))
	Header:setTTF("ttmussels_regular")
	Header:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	Header:setLetterSpacing(3)
	Header:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Header:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(Header)
	self.Header = Header
	local Description = LUI.UIText.new(0, 0, 37, 369, 0, 0, 33, 49)
	Description:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Description:setText(Engine[0xF9F1239CFD921FE](0xE1464E83FBCB490))
	Description:setTTF("dinnext_regular")
	Description:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Description:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(Description)
	self.Description = Description
	local AmbientGlowAnim = CoD.TierBoostAmbientGlow.new(f1_arg0, f1_arg1, 0, 0, -36, 36, 0.5, 0.5, -36, 36)
	AmbientGlowAnim:setScale(0.7, 0.7)
	self:addElement(AmbientGlowAnim)
	self.AmbientGlowAnim = AmbientGlowAnim
	self:mergeStateConditions({
		{
			stateName = "VisibleYouOwnPass",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.ShowBonusForYourBOPass(f1_arg1)
			end,
		},
		{
			stateName = "VisiblePartyMemberOwnsPass",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.ShowBonusForPartyMemberBOPass(f1_arg1)
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = DataSources.AutoEvents.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.cycled, function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "cycled",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x8DF2E5447F384B9]()
	f1_local7(f1_local6, f1_local8["lobbyRoot.lobbyList.playerCount"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.lobbyList.playerCount",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x8DF2E5447F384B9]()
	f1_local7(f1_local6, f1_local8["lobbyRoot.lobbyMainMode"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lobbyRoot.lobbyMainMode",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorLobbyPartyTierBoost.__resetProperties = function(f7_arg0)
	f7_arg0.Description:completeAnimation()
	f7_arg0.Header:completeAnimation()
	f7_arg0.TierSkipIcon:completeAnimation()
	f7_arg0.AmbientGlowAnim:completeAnimation()
	f7_arg0.Backing:completeAnimation()
	f7_arg0.Description:setAlpha(1)
	f7_arg0.Description:setText(Engine[0xF9F1239CFD921FE](0xE1464E83FBCB490))
	f7_arg0.Header:setAlpha(1)
	f7_arg0.TierSkipIcon:setAlpha(1)
	f7_arg0.AmbientGlowAnim:setAlpha(1)
	f7_arg0.Backing:setAlpha(1)
end
CoD.DirectorLobbyPartyTierBoost.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(5)
			f8_arg0.Backing:completeAnimation()
			f8_arg0.Backing:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Backing)
			f8_arg0.TierSkipIcon:completeAnimation()
			f8_arg0.TierSkipIcon:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.TierSkipIcon)
			f8_arg0.Header:completeAnimation()
			f8_arg0.Header:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Header)
			f8_arg0.Description:completeAnimation()
			f8_arg0.Description:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Description)
			f8_arg0.AmbientGlowAnim:completeAnimation()
			f8_arg0.AmbientGlowAnim:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.AmbientGlowAnim)
		end,
	},
	VisibleYouOwnPass = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(5)
			f9_arg0.Backing:completeAnimation()
			f9_arg0.Backing:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.Backing)
			f9_arg0.TierSkipIcon:completeAnimation()
			f9_arg0.TierSkipIcon:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.TierSkipIcon)
			f9_arg0.Header:completeAnimation()
			f9_arg0.Header:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.Header)
			f9_arg0.Description:completeAnimation()
			f9_arg0.Description:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.Description)
			f9_arg0.AmbientGlowAnim:completeAnimation()
			f9_arg0.AmbientGlowAnim:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.AmbientGlowAnim)
		end,
	},
	VisiblePartyMemberOwnsPass = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(5)
			f10_arg0.Backing:completeAnimation()
			f10_arg0.Backing:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.Backing)
			f10_arg0.TierSkipIcon:completeAnimation()
			f10_arg0.TierSkipIcon:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.TierSkipIcon)
			f10_arg0.Header:completeAnimation()
			f10_arg0.Header:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.Header)
			f10_arg0.Description:completeAnimation()
			f10_arg0.Description:setAlpha(1)
			f10_arg0.Description:setText(Engine[0xF9F1239CFD921FE](0xFB8EDEED471C115))
			f10_arg0.clipFinished(f10_arg0.Description)
			f10_arg0.AmbientGlowAnim:completeAnimation()
			f10_arg0.AmbientGlowAnim:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.AmbientGlowAnim)
		end,
	},
}
CoD.DirectorLobbyPartyTierBoost.__onClose = function(f11_arg0)
	f11_arg0.Backing:close()
	f11_arg0.AmbientGlowAnim:close()
end
