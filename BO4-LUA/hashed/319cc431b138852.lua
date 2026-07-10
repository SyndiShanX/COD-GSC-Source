require("x64:9e7be51d884ab71")
CoD.WarzoneDBNORedeploying = InheritFrom(LUI.UIElement)
CoD.WarzoneDBNORedeploying.__defaultWidth = 1919
CoD.WarzoneDBNORedeploying.__defaultHeight = 48
CoD.WarzoneDBNORedeploying.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneDBNORedeploying)
	self.id = "WarzoneDBNORedeploying"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local MatchText = CoD.PrematchCountdown_BeginsIn.new(f1_arg0, f1_arg1, 0.5, 0.5, -959.5, 959.5, 0.5, 0.5, -24, 24)
	MatchText.MatchText:setAlpha(1)
	MatchText.MatchText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2968D3B043BAE7EA"))
	MatchText.MatchText:setLetterSpacing(1.7)
	MatchText.MatchText:setBackingColor(1, 0.16, 0.16)
	MatchText.MatchText:setBackingAlpha(0.9)
	self:addElement(MatchText)
	self.MatchText = MatchText
	self:mergeStateConditions({
		{
			stateName = "Pandemic",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("warzone_pandemic_quad")
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneDBNORedeploying.__resetProperties = function(f3_arg0)
	f3_arg0.MatchText:completeAnimation()
	f3_arg0.MatchText.MatchText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2968D3B043BAE7EA"))
end
CoD.WarzoneDBNORedeploying.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	Pandemic = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.MatchText:beginAnimation(80)
			f5_arg0.MatchText.MatchText:beginAnimation(80)
			f5_arg0.MatchText.MatchText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_68B6A7A86C45442F"))
			f5_arg0.MatchText:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
			f5_arg0.MatchText:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
		end,
	},
}
CoD.WarzoneDBNORedeploying.__onClose = function(f6_arg0)
	f6_arg0.MatchText:close()
end
