require("x64:4e6143dbc749ffd")
CoD.DirectorInfoPanelBGZM = InheritFrom(LUI.UIElement)
CoD.DirectorInfoPanelBGZM.__defaultWidth = 380
CoD.DirectorInfoPanelBGZM.__defaultHeight = 182
CoD.DirectorInfoPanelBGZM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorInfoPanelBGZM)
	self.id = "DirectorInfoPanelBGZM"
	self.soundSet = "none"
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0.64, 0.24, 0.24)
	Backing:setAlpha(0.04)
	self:addElement(Backing)
	self.Backing = Backing
	local Corner = CoD.AARRewardBrackets.new(f1_arg0, f1_arg1, 0, 1.01, -1, -1, 0, 1.01, -1, -1)
	Corner:setAlpha(0.4)
	self:addElement(Corner)
	self.Corner = Corner
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorInfoPanelBGZM.__onClose = function(f2_arg0)
	f2_arg0.Corner:close()
end
