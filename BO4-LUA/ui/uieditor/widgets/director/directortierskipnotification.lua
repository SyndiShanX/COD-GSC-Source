require("x64:48f0ec6d3fba24f")
require("x64:69ba5b942796499")
require("x64:a3bfabf4c0510c9")
require("x64:a88f2d181325438")
CoD.DirectorTierSkipNotification = InheritFrom(LUI.UIElement)
CoD.DirectorTierSkipNotification.__defaultWidth = 800
CoD.DirectorTierSkipNotification.__defaultHeight = 90
CoD.DirectorTierSkipNotification.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BlackMarketUtility.SetupTierSkipModels(f1_arg1, f1_arg0)
	self:setClass(CoD.DirectorTierSkipNotification)
	self.id = "DirectorTierSkipNotification"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TierSkipContractAvailable = CoD.DirectorTierSkipNotificationContractAvailableInternal.new(f1_arg0, f1_arg1, 0, 0, 86, 736, 0, 0, 0, 90)
	TierSkipContractAvailable:setAlpha(0)
	self:addElement(TierSkipContractAvailable)
	self.TierSkipContractAvailable = TierSkipContractAvailable
	local TierSkipAvailable = CoD.DirectorTierSkipNotificationAvailableInternal.new(f1_arg0, f1_arg1, 0, 0, 86, 736, 0, 0, 0, 90)
	self:addElement(TierSkipAvailable)
	self.TierSkipAvailable = TierSkipAvailable
	local TierSkipComplete = CoD.DirectorTierSkipNotificationCompleteInternal.new(f1_arg0, f1_arg1, 0, 0, 196.5, 646.5, 0, 0, 0, 90)
	TierSkipComplete:setAlpha(0)
	self:addElement(TierSkipComplete)
	self.TierSkipComplete = TierSkipComplete
	local TierSkipIcon = LUI.UIImage.new(0, 0, 36, 136, 0.5, 0.5, -48, 52)
	TierSkipIcon:setImage(RegisterImage(@"ui_icon_blackmarket_tier_token"))
	self:addElement(TierSkipIcon)
	self.TierSkipIcon = TierSkipIcon
	local TierSkipIconComplete = LUI.UIImage.new(0, 0, 146.5, 246.5, 0.5, 0.5, -48, 52)
	TierSkipIconComplete:setAlpha(0)
	TierSkipIconComplete:setImage(RegisterImage(@"ui_icon_blackmarket_tier_token"))
	self:addElement(TierSkipIconComplete)
	self.TierSkipIconComplete = TierSkipIconComplete
	local AmbientGlowAnim = CoD.TierBoostAmbientGlow.new(f1_arg0, f1_arg1, 0, 0, 50, 122, 0.5, 0.5, -34, 38)
	self:addElement(AmbientGlowAnim)
	self.AmbientGlowAnim = AmbientGlowAnim
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsModelValueTrue(f1_arg1, "TierSkip.notifyVisible")
			end,
		},
		{
			stateName = "TierSkipContractAvailable",
			condition = function(menu, element, event)
				return CoD.BlackMarketUtility.IsDailyTierSkipAvailable(f1_arg1, element) and CoD.BaseUtility.IsDvarEnabled("lootcontracts_daily_tier_skip")
			end,
		},
		{
			stateName = "TierSkipAvailable",
			condition = function(menu, element, event)
				return CoD.BlackMarketUtility.IsDailyTierSkipAvailable(f1_arg1, element)
			end,
		},
		{
			stateName = "TierSkipComplete",
			condition = function(menu, element, event)
				return CoD.BlackMarketUtility.IsDailyTierSkipComplete(f1_arg1, element)
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["TierSkip.notifyVisible"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "TierSkip.notifyVisible",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorTierSkipNotification.__resetProperties = function(f7_arg0)
	f7_arg0.TierSkipIcon:completeAnimation()
	f7_arg0.TierSkipComplete:completeAnimation()
	f7_arg0.TierSkipAvailable:completeAnimation()
	f7_arg0.AmbientGlowAnim:completeAnimation()
	f7_arg0.TierSkipContractAvailable:completeAnimation()
	f7_arg0.TierSkipIconComplete:completeAnimation()
	f7_arg0.TierSkipIcon:setLeftRight(0, 0, 36, 136)
	f7_arg0.TierSkipIcon:setAlpha(1)
	f7_arg0.TierSkipComplete:setAlpha(0)
	f7_arg0.TierSkipAvailable:setAlpha(1)
	f7_arg0.AmbientGlowAnim:setLeftRight(0, 0, 50, 122)
	f7_arg0.AmbientGlowAnim:setAlpha(1)
	f7_arg0.TierSkipContractAvailable:setAlpha(0)
	f7_arg0.TierSkipIconComplete:setAlpha(0)
end
CoD.DirectorTierSkipNotification.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(4)
			f8_arg0.TierSkipAvailable:completeAnimation()
			f8_arg0.TierSkipAvailable:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.TierSkipAvailable)
			f8_arg0.TierSkipComplete:completeAnimation()
			f8_arg0.TierSkipComplete:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.TierSkipComplete)
			f8_arg0.TierSkipIcon:completeAnimation()
			f8_arg0.TierSkipIcon:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.TierSkipIcon)
			f8_arg0.AmbientGlowAnim:completeAnimation()
			f8_arg0.AmbientGlowAnim:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.AmbientGlowAnim)
		end,
	},
	Hidden = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(5)
			f9_arg0.TierSkipContractAvailable:completeAnimation()
			f9_arg0.TierSkipContractAvailable:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.TierSkipContractAvailable)
			f9_arg0.TierSkipAvailable:completeAnimation()
			f9_arg0.TierSkipAvailable:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.TierSkipAvailable)
			f9_arg0.TierSkipComplete:completeAnimation()
			f9_arg0.TierSkipComplete:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.TierSkipComplete)
			f9_arg0.TierSkipIcon:completeAnimation()
			f9_arg0.TierSkipIcon:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.TierSkipIcon)
			f9_arg0.AmbientGlowAnim:completeAnimation()
			f9_arg0.AmbientGlowAnim:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.AmbientGlowAnim)
		end,
	},
	TierSkipContractAvailable = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			f10_arg0.TierSkipContractAvailable:completeAnimation()
			f10_arg0.TierSkipContractAvailable:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.TierSkipContractAvailable)
			f10_arg0.TierSkipAvailable:completeAnimation()
			f10_arg0.TierSkipAvailable:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.TierSkipAvailable)
			f10_arg0.TierSkipComplete:completeAnimation()
			f10_arg0.TierSkipComplete:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.TierSkipComplete)
		end,
	},
	TierSkipAvailable = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.TierSkipContractAvailable:completeAnimation()
			f11_arg0.TierSkipContractAvailable:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.TierSkipContractAvailable)
			f11_arg0.TierSkipAvailable:completeAnimation()
			f11_arg0.TierSkipAvailable:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.TierSkipAvailable)
			f11_arg0.TierSkipComplete:completeAnimation()
			f11_arg0.TierSkipComplete:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.TierSkipComplete)
		end,
	},
	TierSkipComplete = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(6)
			f12_arg0.TierSkipContractAvailable:completeAnimation()
			f12_arg0.TierSkipContractAvailable:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.TierSkipContractAvailable)
			f12_arg0.TierSkipAvailable:completeAnimation()
			f12_arg0.TierSkipAvailable:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.TierSkipAvailable)
			f12_arg0.TierSkipComplete:completeAnimation()
			f12_arg0.TierSkipComplete:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.TierSkipComplete)
			f12_arg0.TierSkipIcon:completeAnimation()
			f12_arg0.TierSkipIcon:setLeftRight(0, 0, 146.5, 246.5)
			f12_arg0.TierSkipIcon:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.TierSkipIcon)
			f12_arg0.TierSkipIconComplete:completeAnimation()
			f12_arg0.TierSkipIconComplete:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.TierSkipIconComplete)
			f12_arg0.AmbientGlowAnim:completeAnimation()
			f12_arg0.AmbientGlowAnim:setLeftRight(0, 0, 161, 233)
			f12_arg0.clipFinished(f12_arg0.AmbientGlowAnim)
		end,
	},
}
CoD.DirectorTierSkipNotification.__onClose = function(f13_arg0)
	f13_arg0.TierSkipContractAvailable:close()
	f13_arg0.TierSkipAvailable:close()
	f13_arg0.TierSkipComplete:close()
	f13_arg0.AmbientGlowAnim:close()
end
