require("x64:42702cd396663a8")
CoD.Social_RankIconAndRankLargeContainer = InheritFrom(LUI.UIElement)
CoD.Social_RankIconAndRankLargeContainer.__defaultWidth = 349
CoD.Social_RankIconAndRankLargeContainer.__defaultHeight = 135
CoD.Social_RankIconAndRankLargeContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_RankIconAndRankLargeContainer)
	self.id = "Social_RankIconAndRankLargeContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local CommonRankIconAndRankLarge = CoD.CommonRankIconAndRankLarge.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CommonRankIconAndRankLarge:linkToElementModel(self, "rankInfo", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CommonRankIconAndRankLarge:setModel(f2_local0, f1_arg1)
		end
	end)
	CommonRankIconAndRankLarge:linkToElementModel(self, nil, false, function(model)
		CommonRankIconAndRankLarge.arenaRubiesUnlocked:setModel(model, f1_arg1)
	end)
	self:addElement(CommonRankIconAndRankLarge)
	self.CommonRankIconAndRankLarge = CommonRankIconAndRankLarge
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Social_RankIconAndRankLargeContainer.__onClose = function(f4_arg0)
	f4_arg0.CommonRankIconAndRankLarge:close()
end
