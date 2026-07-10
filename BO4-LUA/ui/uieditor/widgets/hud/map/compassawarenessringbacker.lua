CoD.CompassAwarenessRingBacker = InheritFrom(LUI.UIElement)
CoD.CompassAwarenessRingBacker.__defaultWidth = 350
CoD.CompassAwarenessRingBacker.__defaultHeight = 350
CoD.CompassAwarenessRingBacker.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CompassAwarenessRingBacker)
	self.id = "CompassAwarenessRingBacker"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AwarenessBannerBlur = LUI.UIImage.new(0.5, 0.5, -175, 175, 0.5, 0.5, -175, 175)
	AwarenessBannerBlur:setImage(RegisterImage(0xBC3E9B04A60DE79))
	AwarenessBannerBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	AwarenessBannerBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(AwarenessBannerBlur)
	self.AwarenessBannerBlur = AwarenessBannerBlur
	local AwarenessBanner = LUI.UIImage.new(0.5, 0.5, -175, 175, 0.5, 0.5, -175, 175)
	AwarenessBanner:setAlpha(0.5)
	AwarenessBanner:setImage(RegisterImage(0xBC3E9B04A60DE79))
	self:addElement(AwarenessBanner)
	self.AwarenessBanner = AwarenessBanner
	local AwarenessPanel = LUI.UIImage.new(0.5, 0.5, -175, 175, 0.5, 0.5, -175, 175)
	AwarenessPanel:setRGB(0.06, 0.06, 0.06)
	AwarenessPanel:setAlpha(0.98)
	AwarenessPanel:setImage(RegisterImage(0xD1522FFA5C848A3))
	self:addElement(AwarenessPanel)
	self.AwarenessPanel = AwarenessPanel
	local RingPanelBlur = LUI.UIImage.new(0.5, 0.5, -175, 175, 0.5, 0.5, -175, 175)
	RingPanelBlur:setImage(RegisterImage(0x8A1C50744198A2B))
	RingPanelBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	RingPanelBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(RingPanelBlur)
	self.RingPanelBlur = RingPanelBlur
	local RingBanner = LUI.UIImage.new(0.5, 0.5, -175, 175, 0.5, 0.5, -175, 175)
	RingBanner:setAlpha(0.5)
	RingBanner:setImage(RegisterImage(0x8A1C50744198A2B))
	self:addElement(RingBanner)
	self.RingBanner = RingBanner
	local RingPanel = LUI.UIImage.new(0.5, 0.5, -175, 175, 0.5, 0.5, -175, 175)
	RingPanel:setImage(RegisterImage(0x7D623AC5A21228E))
	self:addElement(RingPanel)
	self.RingPanel = RingPanel
	self:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "huditems.awareness", 1)
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["huditems.awareness"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "huditems.awareness",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CompassAwarenessRingBacker.__resetProperties = function(f4_arg0)
	f4_arg0.RingPanelBlur:completeAnimation()
	f4_arg0.AwarenessBannerBlur:completeAnimation()
	f4_arg0.AwarenessBanner:completeAnimation()
	f4_arg0.AwarenessPanel:completeAnimation()
	f4_arg0.RingPanel:completeAnimation()
	f4_arg0.RingBanner:completeAnimation()
	f4_arg0.RingPanelBlur:setAlpha(1)
	f4_arg0.AwarenessBannerBlur:setAlpha(1)
	f4_arg0.AwarenessBanner:setAlpha(0.5)
	f4_arg0.AwarenessPanel:setAlpha(0.98)
	f4_arg0.RingPanel:setAlpha(1)
	f4_arg0.RingBanner:setAlpha(0.5)
end
CoD.CompassAwarenessRingBacker.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(6)
			f5_arg0.AwarenessBannerBlur:completeAnimation()
			f5_arg0.AwarenessBannerBlur:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.AwarenessBannerBlur)
			f5_arg0.AwarenessBanner:completeAnimation()
			f5_arg0.AwarenessBanner:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.AwarenessBanner)
			f5_arg0.AwarenessPanel:completeAnimation()
			f5_arg0.AwarenessPanel:setAlpha(0.98)
			f5_arg0.clipFinished(f5_arg0.AwarenessPanel)
			f5_arg0.RingPanelBlur:completeAnimation()
			f5_arg0.RingPanelBlur:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.RingPanelBlur)
			f5_arg0.RingBanner:completeAnimation()
			f5_arg0.RingBanner:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.RingBanner)
			f5_arg0.RingPanel:completeAnimation()
			f5_arg0.RingPanel:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.RingPanel)
		end,
	},
	Invisible = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(6)
			f6_arg0.AwarenessBannerBlur:completeAnimation()
			f6_arg0.AwarenessBannerBlur:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.AwarenessBannerBlur)
			f6_arg0.AwarenessBanner:completeAnimation()
			f6_arg0.AwarenessBanner:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.AwarenessBanner)
			f6_arg0.AwarenessPanel:completeAnimation()
			f6_arg0.AwarenessPanel:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.AwarenessPanel)
			f6_arg0.RingPanelBlur:completeAnimation()
			f6_arg0.RingPanelBlur:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.RingPanelBlur)
			f6_arg0.RingBanner:completeAnimation()
			f6_arg0.RingBanner:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.RingBanner)
			f6_arg0.RingPanel:completeAnimation()
			f6_arg0.RingPanel:setAlpha(0.98)
			f6_arg0.clipFinished(f6_arg0.RingPanel)
		end,
	},
}
