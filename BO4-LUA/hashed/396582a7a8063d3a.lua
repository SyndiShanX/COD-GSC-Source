require("x64:94dab3a4d2d79b2")
CoD.WarzoneUseTimerRevivePlayerBG = InheritFrom(LUI.UIElement)
CoD.WarzoneUseTimerRevivePlayerBG.__defaultWidth = 612
CoD.WarzoneUseTimerRevivePlayerBG.__defaultHeight = 37
CoD.WarzoneUseTimerRevivePlayerBG.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneUseTimerRevivePlayerBG)
	self.id = "WarzoneUseTimerRevivePlayerBG"
	self.soundSet = "default"
	local Blur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local DotCorner9Slice = CoD.Corner9Slice.new(f1_arg0, f1_arg1, -0.02, 1.02, 0, 0, 0, 1, 0, 0)
	DotCorner9Slice:setAlpha(0.9)
	self:addElement(DotCorner9Slice)
	self.DotCorner9Slice = DotCorner9Slice
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneUseTimerRevivePlayerBG.__onClose = function(f2_arg0)
	f2_arg0.DotCorner9Slice:close()
end
