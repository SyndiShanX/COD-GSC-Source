require("x64:e539eb3c3e1e639")
require("x64:909a1c8890f8571")
CoD.ZMInvChallengesInternal = InheritFrom(LUI.UIElement)
CoD.ZMInvChallengesInternal.__defaultWidth = 320
CoD.ZMInvChallengesInternal.__defaultHeight = 40
CoD.ZMInvChallengesInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 2, true)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.ZMInvChallengesInternal)
	self.id = "ZMInvChallengesInternal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local Backing = CoD.ZMInvChallengesBackingInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -137.5, 137.5, 0.5, 0.5, -35, 35)
	self:addElement(Backing)
	self.Backing = Backing
	local ZMInvChallenges2 = CoD.ZMInvChallengeProgress.new(f1_arg0, f1_arg1, 0, 0, 9, 329, 0, 0, 0, 19)
	ZMInvChallenges2:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ZMInvChallenges2:linkToElementModel(self, nil, false, function(model)
		ZMInvChallenges2:setModel(model, f1_arg1)
	end)
	self:addElement(ZMInvChallenges2)
	self.ZMInvChallenges2 = ZMInvChallenges2
	local ZMInvChallenges = LUI.UIText.new(-0.06, 1.07, 0, 0, 0, 0, 21, 40)
	ZMInvChallenges:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ZMInvChallenges:setTTF("dinnext_regular")
	ZMInvChallenges:setLetterSpacing(1)
	ZMInvChallenges:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ZMInvChallenges:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	ZMInvChallenges:linkToElementModel(self, "description", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ZMInvChallenges:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	self:addElement(ZMInvChallenges)
	self.ZMInvChallenges = ZMInvChallenges
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMInvChallengesInternal.__onClose = function(f4_arg0)
	f4_arg0.Backing:close()
	f4_arg0.ZMInvChallenges2:close()
	f4_arg0.ZMInvChallenges:close()
end
