require("x64:cb2c9edcb6bdc3")
CoD.TrialUpsellMessage = InheritFrom(LUI.UIElement)
CoD.TrialUpsellMessage.__defaultWidth = 500
CoD.TrialUpsellMessage.__defaultHeight = 40
CoD.TrialUpsellMessage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TrialUpsellMessage)
	self.id = "TrialUpsellMessage"
	self.soundSet = "none"
	local Message = LUI.UIText.new(0, 0, 50, 799, 0.5, 0.5, -10, 10)
	Message:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_262486486346EC3F"))
	Message:setTTF("dinnext_regular")
	Message:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Message:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(Message)
	self.Message = Message
	local UpsellWidget = CoD.UpsellWidget.new(f1_arg0, f1_arg1, 0, 0, 0, 40, 0.5, 0.5, -20, 20)
	self:addElement(UpsellWidget)
	self.UpsellWidget = UpsellWidget
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TrialUpsellMessage.__onClose = function(f2_arg0)
	f2_arg0.UpsellWidget:close()
end
