require("ui/uieditor/widgets/common/commonrankiconandrankvertical")
CoD.Social_ManagePartyPlayerButtonRankDetails = InheritFrom(LUI.UIElement)
CoD.Social_ManagePartyPlayerButtonRankDetails.__defaultWidth = 57
CoD.Social_ManagePartyPlayerButtonRankDetails.__defaultHeight = 87
CoD.Social_ManagePartyPlayerButtonRankDetails.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_ManagePartyPlayerButtonRankDetails)
	self.id = "Social_ManagePartyPlayerButtonRankDetails"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local mpRankIcon = CoD.CommonRankIconAndRankVertical.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	mpRankIcon:linkToElementModel(self, "rankInfo", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			mpRankIcon:setModel(f2_local0, f1_arg1)
		end
	end)
	self:addElement(mpRankIcon)
	self.mpRankIcon = mpRankIcon
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Social_ManagePartyPlayerButtonRankDetails.__onClose = function(f3_arg0)
	f3_arg0.mpRankIcon:close()
end
