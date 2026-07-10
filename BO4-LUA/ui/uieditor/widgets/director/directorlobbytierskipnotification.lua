require("x64:7dacefed967e3df")
require("x64:a88f2d181325438")
CoD.DirectorLobbyTierSkipNotification = InheritFrom(LUI.UIElement)
CoD.DirectorLobbyTierSkipNotification.__defaultWidth = 510
CoD.DirectorLobbyTierSkipNotification.__defaultHeight = 94
CoD.DirectorLobbyTierSkipNotification.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BlackMarketUtility.SetupTierSkipModels(f1_arg1, f1_arg0)
	self:setClass(CoD.DirectorLobbyTierSkipNotification)
	self.id = "DirectorLobbyTierSkipNotification"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = CoD.CommonBackingWithBrackets.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Backing)
	self.Backing = Backing
	local TierSkipIcon = LUI.UIImage.new(0, 0, -49, 49, 0.5, 0.5, -49, 49)
	TierSkipIcon:setImage(RegisterImage(0x3162CFF8BC56A18))
	self:addElement(TierSkipIcon)
	self.TierSkipIcon = TierSkipIcon
	local Header = LUI.UIText.new(0, 0, 58, 500, 0.38, 0.38, -25, -4)
	Header:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Header:setText(LocalizeToUpperString(0x7AA3CA056EF6DC5))
	Header:setTTF("ttmussels_regular")
	Header:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	Header:setLetterSpacing(3)
	Header:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Header:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(Header)
	self.Header = Header
	local Description = LUI.UIText.new(0, 0.87, 58, 58, 0.36, 0.36, -2, 14)
	Description:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Description:setText(Engine[0xF9F1239CFD921FE](0x9CE6992DBC67BA7))
	Description:setTTF("dinnext_regular")
	Description:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Description:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Description)
	self.Description = Description
	local RefreshTimer = LUI.UIText.new(0, 0, 58, 500, 0, 0, 33, 49)
	RefreshTimer:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	RefreshTimer:setAlpha(0)
	RefreshTimer:setTTF("dinnext_regular")
	RefreshTimer:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	RefreshTimer:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	RefreshTimer:subscribeToGlobalModel(f1_arg1, "TierSkip", "remainingTimeString", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			RefreshTimer:setText(LocalizeIntoStringIfNotEmpty(0x235B6BD10DA7135, f2_local0))
		end
	end)
	self:addElement(RefreshTimer)
	self.RefreshTimer = RefreshTimer
	local AmbientGlowAnim = CoD.TierBoostAmbientGlow.new(f1_arg0, f1_arg1, 0, 0, -36, 36, 0.5, 0.5, -36, 36)
	AmbientGlowAnim:setScale(0.7, 0.7)
	self:addElement(AmbientGlowAnim)
	self.AmbientGlowAnim = AmbientGlowAnim
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.BaseUtility.IsDvarEnabled("loot_tier_skips_enabled")
			end,
		},
		{
			stateName = "AvailableContracts",
			condition = function(menu, element, event)
				return CoD.BlackMarketUtility.IsDailyTierSkipAvailable(f1_arg1, element) and CoD.BaseUtility.IsDvarEnabled("lootcontracts_daily_tier_skip")
			end,
		},
		{
			stateName = "Zombies",
			condition = function(menu, element, event)
				return IsZombies() and CoD.BlackMarketUtility.IsDailyTierSkipAvailable(f1_arg1, element)
			end,
		},
		{
			stateName = "AvailableMP",
			condition = function(menu, element, event)
				return IsMultiplayer() and CoD.BlackMarketUtility.IsDailyTierSkipAvailable(f1_arg1, element)
			end,
		},
		{
			stateName = "AvailableWZ",
			condition = function(menu, element, event)
				return IsWarzone() and CoD.BlackMarketUtility.IsDailyTierSkipAvailable(f1_arg1, element)
			end,
		},
		{
			stateName = "Completed",
			condition = function(menu, element, event)
				return CoD.BlackMarketUtility.IsDailyTierSkipComplete(f1_arg1, element)
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[0x8DF2E5447F384B9]()
	f1_local8(f1_local7, f1_local9["lobbyRoot.lobbyNav"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorLobbyTierSkipNotification.__resetProperties = function(f10_arg0)
	f10_arg0.RefreshTimer:completeAnimation()
	f10_arg0.Description:completeAnimation()
	f10_arg0.Header:completeAnimation()
	f10_arg0.TierSkipIcon:completeAnimation()
	f10_arg0.AmbientGlowAnim:completeAnimation()
	f10_arg0.Backing:completeAnimation()
	f10_arg0.RefreshTimer:setAlpha(0)
	f10_arg0.Description:setAlpha(1)
	f10_arg0.Description:setText(Engine[0xF9F1239CFD921FE](0x9CE6992DBC67BA7))
	f10_arg0.Header:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	f10_arg0.Header:setAlpha(1)
	f10_arg0.Header:setText(LocalizeToUpperString(0x7AA3CA056EF6DC5))
	f10_arg0.TierSkipIcon:setAlpha(1)
	f10_arg0.AmbientGlowAnim:setAlpha(1)
	f10_arg0.Backing:setAlpha(1)
end
CoD.DirectorLobbyTierSkipNotification.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(6)
			f11_arg0.Backing:completeAnimation()
			f11_arg0.Backing:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Backing)
			f11_arg0.TierSkipIcon:completeAnimation()
			f11_arg0.TierSkipIcon:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.TierSkipIcon)
			f11_arg0.Header:completeAnimation()
			f11_arg0.Header:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Header)
			f11_arg0.Description:completeAnimation()
			f11_arg0.Description:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Description)
			f11_arg0.RefreshTimer:completeAnimation()
			f11_arg0.RefreshTimer:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.RefreshTimer)
			f11_arg0.AmbientGlowAnim:completeAnimation()
			f11_arg0.AmbientGlowAnim:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.AmbientGlowAnim)
		end,
	},
	Hidden = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(6)
			f12_arg0.Backing:completeAnimation()
			f12_arg0.Backing:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Backing)
			f12_arg0.TierSkipIcon:completeAnimation()
			f12_arg0.TierSkipIcon:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.TierSkipIcon)
			f12_arg0.Header:completeAnimation()
			f12_arg0.Header:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Header)
			f12_arg0.Description:completeAnimation()
			f12_arg0.Description:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Description)
			f12_arg0.RefreshTimer:completeAnimation()
			f12_arg0.RefreshTimer:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.RefreshTimer)
			f12_arg0.AmbientGlowAnim:completeAnimation()
			f12_arg0.AmbientGlowAnim:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.AmbientGlowAnim)
		end,
	},
	AvailableContracts = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(4)
			f13_arg0.TierSkipIcon:completeAnimation()
			f13_arg0.TierSkipIcon:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.TierSkipIcon)
			f13_arg0.Header:completeAnimation()
			f13_arg0.Header:setAlpha(1)
			f13_arg0.Header:setText(LocalizeToUpperString(0x7AA3CA056EF6DC5))
			f13_arg0.clipFinished(f13_arg0.Header)
			f13_arg0.Description:completeAnimation()
			f13_arg0.Description:setAlpha(1)
			f13_arg0.Description:setText(Engine[0xF9F1239CFD921FE](0x20765F8B6C184AA))
			f13_arg0.clipFinished(f13_arg0.Description)
			f13_arg0.RefreshTimer:completeAnimation()
			f13_arg0.RefreshTimer:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.RefreshTimer)
		end,
	},
	Zombies = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(4)
			f14_arg0.TierSkipIcon:completeAnimation()
			f14_arg0.TierSkipIcon:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.TierSkipIcon)
			f14_arg0.Header:completeAnimation()
			f14_arg0.Header:setAlpha(1)
			f14_arg0.Header:setText(LocalizeToUpperString(0x7AA3CA056EF6DC5))
			f14_arg0.clipFinished(f14_arg0.Header)
			f14_arg0.Description:completeAnimation()
			f14_arg0.Description:setAlpha(1)
			f14_arg0.Description:setText(Engine[0xF9F1239CFD921FE](0x69546B0160438DB))
			f14_arg0.clipFinished(f14_arg0.Description)
			f14_arg0.RefreshTimer:completeAnimation()
			f14_arg0.RefreshTimer:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.RefreshTimer)
		end,
	},
	AvailableMP = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(4)
			f15_arg0.TierSkipIcon:completeAnimation()
			f15_arg0.TierSkipIcon:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.TierSkipIcon)
			f15_arg0.Header:completeAnimation()
			f15_arg0.Header:setAlpha(1)
			f15_arg0.Header:setText(LocalizeToUpperString(0x7AA3CA056EF6DC5))
			f15_arg0.clipFinished(f15_arg0.Header)
			f15_arg0.Description:completeAnimation()
			f15_arg0.Description:setAlpha(1)
			f15_arg0.Description:setText(Engine[0xF9F1239CFD921FE](0x9CE6992DBC67BA7))
			f15_arg0.clipFinished(f15_arg0.Description)
			f15_arg0.RefreshTimer:completeAnimation()
			f15_arg0.RefreshTimer:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.RefreshTimer)
		end,
	},
	AvailableWZ = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(4)
			f16_arg0.TierSkipIcon:completeAnimation()
			f16_arg0.TierSkipIcon:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.TierSkipIcon)
			f16_arg0.Header:completeAnimation()
			f16_arg0.Header:setAlpha(1)
			f16_arg0.Header:setText(LocalizeToUpperString(0x7AA3CA056EF6DC5))
			f16_arg0.clipFinished(f16_arg0.Header)
			f16_arg0.Description:completeAnimation()
			f16_arg0.Description:setAlpha(1)
			f16_arg0.Description:setText(Engine[0xF9F1239CFD921FE](0xF7364A936C6E65F))
			f16_arg0.clipFinished(f16_arg0.Description)
			f16_arg0.RefreshTimer:completeAnimation()
			f16_arg0.RefreshTimer:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.RefreshTimer)
		end,
	},
	Completed = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(4)
			f17_arg0.TierSkipIcon:completeAnimation()
			f17_arg0.TierSkipIcon:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.TierSkipIcon)
			f17_arg0.Header:completeAnimation()
			f17_arg0.Header:setRGB(ColorSet.T8__GREEN.r, ColorSet.T8__GREEN.g, ColorSet.T8__GREEN.b)
			f17_arg0.Header:setAlpha(1)
			f17_arg0.Header:setText(LocalizeToUpperString(0x96A987582D607F8))
			f17_arg0.clipFinished(f17_arg0.Header)
			f17_arg0.Description:completeAnimation()
			f17_arg0.Description:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.Description)
			f17_arg0.RefreshTimer:completeAnimation()
			f17_arg0.RefreshTimer:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.RefreshTimer)
		end,
	},
}
CoD.DirectorLobbyTierSkipNotification.__onClose = function(f18_arg0)
	f18_arg0.Backing:close()
	f18_arg0.RefreshTimer:close()
	f18_arg0.AmbientGlowAnim:close()
end
