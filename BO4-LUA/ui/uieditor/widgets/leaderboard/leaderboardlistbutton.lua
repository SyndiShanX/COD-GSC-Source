require("x64:46897811dbbcd6f")
CoD.LeaderboardListButton = InheritFrom(LUI.UIElement)
CoD.LeaderboardListButton.__defaultWidth = 303
CoD.LeaderboardListButton.__defaultHeight = 92
CoD.LeaderboardListButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LeaderboardListButton)
	self.id = "LeaderboardListButton"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonListButtonShortInternal = CoD.CommonListButtonShort_Internal.new(f1_arg0, f1_arg1, 0.5, 0.5, -151.5, 151.5, 0.5, 0.5, -46, 46)
	CommonListButtonShortInternal.Title:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	self:addElement(CommonListButtonShortInternal)
	self.CommonListButtonShortInternal = CommonListButtonShortInternal
	CommonListButtonShortInternal.id = "CommonListButtonShortInternal"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LeaderboardListButton.__resetProperties = function(f2_arg0)
	f2_arg0.CommonListButtonShortInternal:completeAnimation()
	f2_arg0.CommonListButtonShortInternal:setScale(1, 1)
end
CoD.LeaderboardListButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.CommonListButtonShortInternal:completeAnimation()
			f4_arg0.CommonListButtonShortInternal:setScale(1.05, 1.05)
			f4_arg0.clipFinished(f4_arg0.CommonListButtonShortInternal)
		end,
		GainChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				f5_arg0.CommonListButtonShortInternal:beginAnimation(200)
				f5_arg0.CommonListButtonShortInternal:setScale(1.05, 1.05)
				f5_arg0.CommonListButtonShortInternal:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.CommonListButtonShortInternal:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.CommonListButtonShortInternal:completeAnimation()
			f5_arg0.CommonListButtonShortInternal:setScale(1, 1)
			f5_local0(f5_arg0.CommonListButtonShortInternal)
		end,
		LoseChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.CommonListButtonShortInternal:beginAnimation(200)
				f7_arg0.CommonListButtonShortInternal:setScale(1, 1)
				f7_arg0.CommonListButtonShortInternal:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.CommonListButtonShortInternal:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.CommonListButtonShortInternal:completeAnimation()
			f7_arg0.CommonListButtonShortInternal:setScale(1.05, 1.05)
			f7_local0(f7_arg0.CommonListButtonShortInternal)
		end,
	},
}
CoD.LeaderboardListButton.__onClose = function(f9_arg0)
	f9_arg0.CommonListButtonShortInternal:close()
end
