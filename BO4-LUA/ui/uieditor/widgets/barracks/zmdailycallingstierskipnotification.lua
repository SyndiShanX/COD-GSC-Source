require("x64:a88f2d181325438")
CoD.ZMDailyCallingsTierSkipNotification = InheritFrom(LUI.UIElement)
CoD.ZMDailyCallingsTierSkipNotification.__defaultWidth = 190
CoD.ZMDailyCallingsTierSkipNotification.__defaultHeight = 56
CoD.ZMDailyCallingsTierSkipNotification.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 2, true)
	self:setAlignment(LUI.Alignment.Left)
	CoD.BlackMarketUtility.SetupTierSkipModels(f1_arg1, f1_arg0)
	self:setClass(CoD.ZMDailyCallingsTierSkipNotification)
	self.id = "ZMDailyCallingsTierSkipNotification"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AmbientGlowAnim = CoD.TierBoostAmbientGlow.new(f1_arg0, f1_arg1, 0, 0, -8.5, 63.5, 0.5, 0.5, -36, 36)
	AmbientGlowAnim:setScale(0.7, 0.7)
	self:addElement(AmbientGlowAnim)
	self.AmbientGlowAnim = AmbientGlowAnim
	local TierSkipIcon = LUI.UIImage.new(0, 0, 0, 55, 0.5, 0.5, -27.5, 27.5)
	TierSkipIcon:setImage(RegisterImage(0x3162CFF8BC56A18))
	self:addElement(TierSkipIcon)
	self.TierSkipIcon = TierSkipIcon
	local Header = LUI.UIText.new(0, 0, 57, 190, 0.5, 0.5, -7, 7)
	Header:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Header:setText(LocalizeToUpperString(0x59AB2B00A337CBE))
	Header:setTTF("dinnext_regular")
	Header:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	Header:setLetterSpacing(3)
	Header:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Header:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(Header)
	self.Header = Header
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.BaseUtility.IsDvarEnabled("loot_tier_skips_enabled")
			end,
		},
		{
			stateName = "Zombies",
			condition = function(menu, element, event)
				return IsZombies()
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local5(f1_local4, f1_local6["lobbyRoot.lobbyNav"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMDailyCallingsTierSkipNotification.__resetProperties = function(f5_arg0)
	f5_arg0.Header:completeAnimation()
	f5_arg0.TierSkipIcon:completeAnimation()
	f5_arg0.AmbientGlowAnim:completeAnimation()
	f5_arg0.Header:setAlpha(1)
	f5_arg0.TierSkipIcon:setAlpha(1)
	f5_arg0.AmbientGlowAnim:setAlpha(1)
end
CoD.ZMDailyCallingsTierSkipNotification.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.AmbientGlowAnim:completeAnimation()
			f6_arg0.AmbientGlowAnim:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.AmbientGlowAnim)
			f6_arg0.TierSkipIcon:completeAnimation()
			f6_arg0.TierSkipIcon:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.TierSkipIcon)
			f6_arg0.Header:completeAnimation()
			f6_arg0.Header:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Header)
		end,
	},
	Hidden = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(3)
			f7_arg0.AmbientGlowAnim:completeAnimation()
			f7_arg0.AmbientGlowAnim:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.AmbientGlowAnim)
			f7_arg0.TierSkipIcon:completeAnimation()
			f7_arg0.TierSkipIcon:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.TierSkipIcon)
			f7_arg0.Header:completeAnimation()
			f7_arg0.Header:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Header)
		end,
	},
	Zombies = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.TierSkipIcon:completeAnimation()
			f8_arg0.TierSkipIcon:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.TierSkipIcon)
			f8_arg0.Header:completeAnimation()
			f8_arg0.Header:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.Header)
		end,
	},
}
CoD.ZMDailyCallingsTierSkipNotification.__onClose = function(f9_arg0)
	f9_arg0.AmbientGlowAnim:close()
end
