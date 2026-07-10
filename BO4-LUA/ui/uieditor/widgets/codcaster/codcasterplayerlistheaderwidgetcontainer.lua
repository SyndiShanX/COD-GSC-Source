require("x64:66d015f705d5485")
CoD.CodCasterPlayerListHeaderWidgetContainer = InheritFrom(LUI.UIElement)
CoD.CodCasterPlayerListHeaderWidgetContainer.__defaultWidth = 408
CoD.CodCasterPlayerListHeaderWidgetContainer.__defaultHeight = 8
CoD.CodCasterPlayerListHeaderWidgetContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterPlayerListHeaderWidgetContainer)
	self.id = "CodCasterPlayerListHeaderWidgetContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(1, 1, -193, 0, 1, 1, -4, 0)
	bg:setRGB(0, 0, 0)
	self:addElement(bg)
	self.bg = bg
	local Header = CoD.CodCasterPlayerListHeaderWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -203, 201, 0, 0, 0, 4)
	self:addElement(Header)
	self.Header = Header
	local ListenIn = LUI.UIImage.new(1.15, 1.15, -493, -472, 0, 0, 27, 48)
	ListenIn:setImage(RegisterImage(0x985CBF5844BD821))
	self:addElement(ListenIn)
	self.ListenIn = ListenIn
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterPlayerListHeaderWidgetContainer.__resetProperties = function(f2_arg0)
	f2_arg0.Header:completeAnimation()
	f2_arg0.ListenIn:completeAnimation()
	f2_arg0.Header:setAlpha(1)
	f2_arg0.ListenIn:setAlpha(1)
end
CoD.CodCasterPlayerListHeaderWidgetContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.Header:completeAnimation()
			f3_arg0.Header:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.Header)
			f3_arg0.ListenIn:completeAnimation()
			f3_arg0.ListenIn:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.ListenIn)
		end,
	},
	Visible = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.ListenIn:completeAnimation()
			f4_arg0.ListenIn:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.ListenIn)
		end,
	},
	VisibleWithListenIn = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.CodCasterPlayerListHeaderWidgetContainer.__onClose = function(f6_arg0)
	f6_arg0.Header:close()
end
