require("x64:def16d91ad53261")
CoD.CPHoldToSkipSceneText = InheritFrom(LUI.UIElement)
CoD.CPHoldToSkipSceneText.__defaultWidth = 280
CoD.CPHoldToSkipSceneText.__defaultHeight = 37
CoD.CPHoldToSkipSceneText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Right)
	self:setClass(CoD.CPHoldToSkipSceneText)
	self.id = "CPHoldToSkipSceneText"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local Hold = LUI.UIText.new(0, 1, 121, -115, 0, 1, 0.5, 0.5)
	Hold:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7C08CC61C226C4F5"))
	Hold:setTTF("default")
	Hold:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(Hold)
	self.Hold = Hold
	local CPHoldToSkipSceneButton = CoD.CPHoldToSkipSceneButton.new(f1_arg0, f1_arg1, 0, 0, 165, 210, 0, 0, 5, 35)
	self:addElement(CPHoldToSkipSceneButton)
	self.CPHoldToSkipSceneButton = CPHoldToSkipSceneButton
	local ToSkip = LUI.UIText.new(0, 1, 210, 0, 0, 1, 0.5, 0.5)
	ToSkip:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5ECE1C7E3530500E"))
	ToSkip:setTTF("default")
	ToSkip:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(ToSkip)
	self.ToSkip = ToSkip
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CPHoldToSkipSceneText.__onClose = function(f2_arg0)
	f2_arg0.CPHoldToSkipSceneButton:close()
end
