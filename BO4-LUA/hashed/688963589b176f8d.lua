require("x64:d409a987481e19b")
CoD.Prestige_PrestigeButton = InheritFrom(LUI.UIElement)
CoD.Prestige_PrestigeButton.__defaultWidth = 400
CoD.Prestige_PrestigeButton.__defaultHeight = 94
CoD.Prestige_PrestigeButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Prestige_PrestigeButton)
	self.id = "Prestige_PrestigeButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FrontendFrameSelected = CoD.Prestige_PrestigeButton_Internal.new(f1_arg0, f1_arg1, 0, 0, 0, 400, 0, 0, 0, 94)
	self:addElement(FrontendFrameSelected)
	self.FrontendFrameSelected = FrontendFrameSelected
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.PrestigeUtility.ShouldHidePrestigeButton(f1_arg1)
			end,
		},
		{
			stateName = "PrestigeReady",
			condition = function(menu, element, event)
				return IsAtXPCap(f1_arg1) and not IsMaxPrestigeLevel(f1_arg1)
			end,
		},
		{
			stateName = "MasterPrestige",
			condition = function(menu, element, event)
				return IsMaxPrestigeLevel(f1_arg1) and not IsArenaMode()
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	FrontendFrameSelected.id = "FrontendFrameSelected"
	self.__defaultFocus = FrontendFrameSelected
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Prestige_PrestigeButton.__resetProperties = function(f6_arg0)
	f6_arg0.FrontendFrameSelected:completeAnimation()
	f6_arg0.FrontendFrameSelected:setAlpha(1)
	f6_arg0.FrontendFrameSelected:setScale(1, 1)
end
CoD.Prestige_PrestigeButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.FrontendFrameSelected:completeAnimation()
			f8_arg0.FrontendFrameSelected:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.FrontendFrameSelected)
		end,
	},
	PrestigeReady = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.FrontendFrameSelected:completeAnimation()
			f9_arg0.FrontendFrameSelected:setScale(1, 1)
			f9_arg0.clipFinished(f9_arg0.FrontendFrameSelected)
		end,
		ChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.FrontendFrameSelected:completeAnimation()
			f10_arg0.FrontendFrameSelected:setScale(1.04, 1.08)
			f10_arg0.clipFinished(f10_arg0.FrontendFrameSelected)
		end,
		GainChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.FrontendFrameSelected:beginAnimation(150)
				f11_arg0.FrontendFrameSelected:setScale(1.04, 1.08)
				f11_arg0.FrontendFrameSelected:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.FrontendFrameSelected:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.FrontendFrameSelected:completeAnimation()
			f11_arg0.FrontendFrameSelected:setScale(1, 1)
			f11_local0(f11_arg0.FrontendFrameSelected)
		end,
		LoseChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			local f13_local0 = function(f14_arg0)
				f13_arg0.FrontendFrameSelected:beginAnimation(100)
				f13_arg0.FrontendFrameSelected:setScale(1, 1)
				f13_arg0.FrontendFrameSelected:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.FrontendFrameSelected:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.FrontendFrameSelected:completeAnimation()
			f13_arg0.FrontendFrameSelected:setScale(1.04, 1.08)
			f13_local0(f13_arg0.FrontendFrameSelected)
		end,
	},
	MasterPrestige = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.Prestige_PrestigeButton.__onClose = function(f16_arg0)
	f16_arg0.FrontendFrameSelected:close()
end
