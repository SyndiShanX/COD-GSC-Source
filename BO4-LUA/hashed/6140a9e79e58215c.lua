require("x64:a9255c570c68aa8")
CoD.ContractActiveBannerBacker = InheritFrom(LUI.UIElement)
CoD.ContractActiveBannerBacker.__defaultWidth = 150
CoD.ContractActiveBannerBacker.__defaultHeight = 25
CoD.ContractActiveBannerBacker.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContractActiveBannerBacker)
	self.id = "ContractActiveBannerBacker"
	self.soundSet = "default"
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0, 0, 0)
	Background:setAlpha(0.92)
	self:addElement(Background)
	self.Background = Background
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Frame:setRGB(0, 0.55, 0.33)
	self:addElement(Frame)
	self.Frame = Frame
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ContractActiveBannerBacker.__onClose = function(f2_arg0)
	f2_arg0.Frame:close()
end
