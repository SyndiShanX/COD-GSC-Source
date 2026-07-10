CoD.TrialWidget = InheritFrom(LUI.UIElement)
CoD.TrialWidget.__defaultWidth = 25
CoD.TrialWidget.__defaultHeight = 25
CoD.TrialWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TrialWidget)
	self.id = "TrialWidget"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WZTrialImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	WZTrialImage:setImage(RegisterImage(@"uie_ui_icon_wz_frontend_gameicon_trial"))
	self:addElement(WZTrialImage)
	self.WZTrialImage = WZTrialImage
	self:mergeStateConditions({
		{
			stateName = "Shown",
			condition = function(menu, element, event)
				return IsGameTrial()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TrialWidget.__resetProperties = function(f3_arg0)
	f3_arg0.WZTrialImage:completeAnimation()
	f3_arg0.WZTrialImage:setAlpha(1)
end
CoD.TrialWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.WZTrialImage:completeAnimation()
			f4_arg0.WZTrialImage:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.WZTrialImage)
		end,
	},
	Shown = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
}
