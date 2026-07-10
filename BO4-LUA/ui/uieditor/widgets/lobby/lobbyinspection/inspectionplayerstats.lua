CoD.InspectionPlayerStats = InheritFrom(LUI.UIElement)
CoD.InspectionPlayerStats.__defaultWidth = 200
CoD.InspectionPlayerStats.__defaultHeight = 89
CoD.InspectionPlayerStats.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.InspectionPlayerStats)
	self.id = "InspectionPlayerStats"
	self.soundSet = "default"
	local TotalKill = LUI.UIText.new(0, 0, 0, 200, 0, 0, 6, 27)
	TotalKill:setAlpha(0.1)
	TotalKill:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	TotalKill:setTTF("ttmussels_regular")
	TotalKill:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TotalKill:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(TotalKill)
	self.TotalKill = TotalKill
	local TextBox = LUI.UIText.new(0, 0, 0, 200, 0, 0, 30.5, 78.5)
	TextBox:setRGB(0.9, 0.89, 0.78)
	TextBox:setAlpha(0.5)
	TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	TextBox:setTTF("dinnext_regular")
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(TextBox)
	self.TextBox = TextBox
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
