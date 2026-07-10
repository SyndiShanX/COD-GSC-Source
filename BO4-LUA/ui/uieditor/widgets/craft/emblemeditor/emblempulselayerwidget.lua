CoD.EmblemPulseLayerWidget = InheritFrom(LUI.UIElement)
CoD.EmblemPulseLayerWidget.__defaultWidth = 540
CoD.EmblemPulseLayerWidget.__defaultHeight = 540
CoD.EmblemPulseLayerWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmblemPulseLayerWidget)
	self.id = "EmblemPulseLayerWidget"
	self.soundSet = "CustomizationEditor"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local emblemHiddenPulseLayer = LUI.UIElement.new(0, 1, 0, 0, 0, 1, 0, 0)
	emblemHiddenPulseLayer:setAlpha(0)
	self:addElement(emblemHiddenPulseLayer)
	self.emblemHiddenPulseLayer = emblemHiddenPulseLayer
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EmblemPulseLayerWidget.__resetProperties = function(f2_arg0)
	f2_arg0.emblemHiddenPulseLayer:completeAnimation()
	f2_arg0.emblemHiddenPulseLayer:setRGB(1, 1, 1)
	f2_arg0.emblemHiddenPulseLayer:setAlpha(0)
end
CoD.EmblemPulseLayerWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(9)
					f5_arg0:setAlpha(0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.emblemHiddenPulseLayer:beginAnimation(200)
				f3_arg0.emblemHiddenPulseLayer:setRGB(0, 0, 1)
				f3_arg0.emblemHiddenPulseLayer:setAlpha(0.8)
				f3_arg0.emblemHiddenPulseLayer:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.emblemHiddenPulseLayer:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.emblemHiddenPulseLayer:completeAnimation()
			f3_arg0.emblemHiddenPulseLayer:setRGB(1, 1, 0)
			f3_arg0.emblemHiddenPulseLayer:setAlpha(1)
			f3_local0(f3_arg0.emblemHiddenPulseLayer)
		end,
	},
}
