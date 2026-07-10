require("x64:d9107537d9e5739")
CoD.Leaderboard_GameModeButton = InheritFrom(LUI.UIElement)
CoD.Leaderboard_GameModeButton.__defaultWidth = 303
CoD.Leaderboard_GameModeButton.__defaultHeight = 202
CoD.Leaderboard_GameModeButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Leaderboard_GameModeButton)
	self.id = "Leaderboard_GameModeButton"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LeaderboardGameModeButtonInternal = CoD.Leaderboard_GameModeButton_Internal.new(f1_arg0, f1_arg1, 0.5, 0.5, -151.5, 151.5, 0.5, 0.5, -101, 101)
	LeaderboardGameModeButtonInternal:linkToElementModel(self, "icon", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			LeaderboardGameModeButtonInternal.CategoryIconFull:setImage(RegisterImage(f2_local0))
		end
	end)
	LeaderboardGameModeButtonInternal:linkToElementModel(self, "icon", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			LeaderboardGameModeButtonInternal.CategoryIcon:setImage(RegisterImage(f3_local0))
		end
	end)
	LeaderboardGameModeButtonInternal:linkToElementModel(self, "title", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			LeaderboardGameModeButtonInternal.ButtonTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f4_local0))
		end
	end)
	self:addElement(LeaderboardGameModeButtonInternal)
	self.LeaderboardGameModeButtonInternal = LeaderboardGameModeButtonInternal
	LUI.OverrideFunction_CallOriginalFirst(self, "setModel", function(element, controller)
		UpdateSelfElementState(f1_arg0, self.LeaderboardGameModeButtonInternal, f1_arg1)
	end)
	LeaderboardGameModeButtonInternal.id = "LeaderboardGameModeButtonInternal"
	self.__defaultFocus = LeaderboardGameModeButtonInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Leaderboard_GameModeButton.__resetProperties = function(f6_arg0)
	f6_arg0.LeaderboardGameModeButtonInternal:completeAnimation()
	f6_arg0.LeaderboardGameModeButtonInternal:setScale(1, 1)
end
CoD.Leaderboard_GameModeButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.LeaderboardGameModeButtonInternal:completeAnimation()
			f8_arg0.LeaderboardGameModeButtonInternal:setScale(1.05, 1.05)
			f8_arg0.clipFinished(f8_arg0.LeaderboardGameModeButtonInternal)
		end,
		GainChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.LeaderboardGameModeButtonInternal:beginAnimation(200)
				f9_arg0.LeaderboardGameModeButtonInternal:setScale(1.05, 1.05)
				f9_arg0.LeaderboardGameModeButtonInternal:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.LeaderboardGameModeButtonInternal:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.LeaderboardGameModeButtonInternal:completeAnimation()
			f9_arg0.LeaderboardGameModeButtonInternal:setScale(1, 1)
			f9_local0(f9_arg0.LeaderboardGameModeButtonInternal)
		end,
		LoseChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.LeaderboardGameModeButtonInternal:beginAnimation(200)
				f11_arg0.LeaderboardGameModeButtonInternal:setScale(1, 1)
				f11_arg0.LeaderboardGameModeButtonInternal:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.LeaderboardGameModeButtonInternal:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.LeaderboardGameModeButtonInternal:completeAnimation()
			f11_arg0.LeaderboardGameModeButtonInternal:setScale(1.05, 1.05)
			f11_local0(f11_arg0.LeaderboardGameModeButtonInternal)
		end,
	},
}
CoD.Leaderboard_GameModeButton.__onClose = function(f13_arg0)
	f13_arg0.LeaderboardGameModeButtonInternal:close()
end
