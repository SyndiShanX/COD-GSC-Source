require("x64:fb98cebe86f4aa7")
require("x64:5415c2f3330b8c9")
CoD.WZ_AARChallengeContainerInternal = InheritFrom(LUI.UIElement)
CoD.WZ_AARChallengeContainerInternal.__defaultWidth = 540
CoD.WZ_AARChallengeContainerInternal.__defaultHeight = 628
CoD.WZ_AARChallengeContainerInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZ_AARChallengeContainerInternal)
	self.id = "WZ_AARChallengeContainerInternal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local IGRbg = CoD.WZAAR_IGR_background.new(f1_arg0, f1_arg1, 0, 0, 0, 540, 0, 0, 0, 628)
	self:addElement(IGRbg)
	self.IGRbg = IGRbg
	local NearCompletionList = LUI.UIList.new(f1_arg0, f1_arg1, 14, 0, nil, false, false, false, false)
	NearCompletionList:setLeftRight(0, 0, 35, 506)
	NearCompletionList:setTopBottom(0, 0, 76.5, 590.5)
	NearCompletionList:setWidgetType(CoD.WZAAR_Challenge)
	NearCompletionList:setVerticalCount(3)
	NearCompletionList:setSpacing(14)
	NearCompletionList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	NearCompletionList:setDataSource("WZAARChallengeContainerList")
	self:addElement(NearCompletionList)
	self.NearCompletionList = NearCompletionList
	local Title = LUI.UIText.new(0.5, 0.5, -248, 248, 0, 0, 19, 51)
	Title:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Title:setText(LocalizeToUpperString(@"hash_562F747C8FDEBB6A"))
	Title:setTTF("ttmussels_demibold")
	Title:setLetterSpacing(4)
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Title:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(Title)
	self.Title = Title
	self:subscribeToGlobalModel(f1_arg1, "PerController", "gameScore.currentState", function(model)
		local f2_local0 = self
		if IsInGame() then
			CoD.GridAndListUtility.UpdateDataSource(self.NearCompletionList, false, true, true)
		end
	end)
	NearCompletionList.id = "NearCompletionList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZ_AARChallengeContainerInternal.__onClose = function(f3_arg0)
	f3_arg0.IGRbg:close()
	f3_arg0.NearCompletionList:close()
end
