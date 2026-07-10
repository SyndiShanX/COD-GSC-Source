require("x64:41f1de05d25d54")
require("x64:f3f161a118c1f4e")
CoD.VHUDHawkWeakSignal = InheritFrom(LUI.UIElement)
CoD.VHUDHawkWeakSignal.__defaultWidth = 195
CoD.VHUDHawkWeakSignal.__defaultHeight = 98
CoD.VHUDHawkWeakSignal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VHUDHawkWeakSignal)
	self.id = "VHUDHawkWeakSignal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local Background = LUI.UIImage.new(0.5, 0.5, -97.5, 97.5, 0.5, 0.5, -49, 49)
	Background:setAlpha(0)
	self:addElement(Background)
	self.Background = Background
	local Black = LUI.UIImage.new(0, 0, 4, 191, 0, 0, 3, 58)
	Black:setRGB(0.09, 0.04, 0.04)
	Black:setAlpha(0)
	self:addElement(Black)
	self.Black = Black
	local WeakSignal = LUI.UIText.new(0.5, 0.5, -90, 90, 0, 0, 8, 53)
	WeakSignal:setAlpha(0)
	WeakSignal:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_67536F24E4E34704"))
	WeakSignal:setTTF("default")
	WeakSignal:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	WeakSignal:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(WeakSignal)
	self.WeakSignal = WeakSignal
	local Gray = LUI.UIImage.new(0, 0, 4, 191, 0, 0, 61, 95)
	Gray:setRGB(0.41, 0.41, 0.41)
	Gray:setAlpha(0)
	self:addElement(Gray)
	self.Gray = Gray
	local TargetingOffline = LUI.UIText.new(0.5, 0.5, -93.5, 93.5, 0, 0, 67.5, 88.5)
	TargetingOffline:setAlpha(0)
	TargetingOffline:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_747EC12E7417444E"))
	TargetingOffline:setTTF("default")
	TargetingOffline:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TargetingOffline:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(TargetingOffline)
	self.TargetingOffline = TargetingOffline
	local MessageBox = CoD.VHUDHawkWeakSignalBox.new(f1_arg0, f1_arg1, 0.5, 0.5, -251, 251, 1, 1, -103, 155)
	self:addElement(MessageBox)
	self.MessageBox = MessageBox
	local VHUDHawkWeakSignalWarningText = CoD.VHUDHawkWeakSignalWarningText.new(f1_arg0, f1_arg1, 0, 0, 5.5, 187.5, 0, 0, 8, 53)
	self:addElement(VHUDHawkWeakSignalWarningText)
	self.VHUDHawkWeakSignalWarningText = VHUDHawkWeakSignalWarningText
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.VHUDHawkWeakSignal.__onClose = function(f2_arg0)
	f2_arg0.MessageBox:close()
	f2_arg0.VHUDHawkWeakSignalWarningText:close()
end
