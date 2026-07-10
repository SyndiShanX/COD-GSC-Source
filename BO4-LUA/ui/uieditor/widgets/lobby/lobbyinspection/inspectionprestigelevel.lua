CoD.InspectionPrestigeLevel = InheritFrom(LUI.UIElement)
CoD.InspectionPrestigeLevel.__defaultWidth = 400
CoD.InspectionPrestigeLevel.__defaultHeight = 21
CoD.InspectionPrestigeLevel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.InspectionPrestigeLevel)
	self.id = "InspectionPrestigeLevel"
	self.soundSet = "default"
	local PrestigeText = LUI.UIText.new(0, 0, 0, 200, 0, 0, 0, 21)
	PrestigeText:setRGB(0.13, 0.78, 1)
	PrestigeText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	PrestigeText:setTTF("dinnext_regular")
	PrestigeText:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	PrestigeText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(PrestigeText)
	self.PrestigeText = PrestigeText
	local PrestigeLevelNum = LUI.UIText.new(0, 0, 200, 400, 0, 0, 0, 21)
	PrestigeLevelNum:setRGB(0.13, 0.78, 1)
	PrestigeLevelNum:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	PrestigeLevelNum:setTTF("dinnext_regular")
	PrestigeLevelNum:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PrestigeLevelNum:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(PrestigeLevelNum)
	self.PrestigeLevelNum = PrestigeLevelNum
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
