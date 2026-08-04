require("ui/uieditor/widgets/cplevels/cpholdtoskipscenetext")
require("ui/uieditor/widgets/cplevels/cphostskippingscene")
require("ui/uieditor/widgets/cplevels/cpvoteskippingscene")
CoD.cp_skip_scene_menu = InheritFrom(CoD.Menu)
LUI.createMenu.cp_skip_scene_menu = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("cp_skip_scene_menu", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.cp_skip_scene_menu)
	self.soundSet = "HUD"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local CPHostSkippingScene0 = CoD.CPHostSkippingScene.new(f1_local1, f1_arg0, 0.5, 0.5, -140, 140, 0, 0, 97, 136)
	CPHostSkippingScene0:setAlpha(0)
	self:addElement(CPHostSkippingScene0)
	self.CPHostSkippingScene0 = CPHostSkippingScene0
	local CPSkipSceneButton0 = CoD.CPHoldToSkipSceneText.new(f1_local1, f1_arg0, 1, 1, -394, -113, 1, 1, -104, -66)
	CPSkipSceneButton0:setAlpha(0)
	self:addElement(CPSkipSceneButton0)
	self.CPSkipSceneButton0 = CPSkipSceneButton0
	local CPVoteSkippingScene0 = CoD.CPVoteSkippingScene.new(f1_local1, f1_arg0, 0, 0, 1526, 1806, 0, 0, 976, 1013)
	CPVoteSkippingScene0:setAlpha(0)
	self:addElement(CPVoteSkippingScene0)
	self.CPVoteSkippingScene0 = CPVoteSkippingScene0
	self:mergeStateConditions({
		{
			stateName = "HostIsSkipping",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg0, "hostIsSkipping", 1)
			end,
		},
		{
			stateName = "ShowSkipButton_Newsroom",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg0, "showSkipButton", 1) and IsMapName("cp_newsroom")
			end,
		},
		{
			stateName = "ShowSkipButton",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg0, "showSkipButton", 1)
			end,
		},
		{
			stateName = "VotedToSkip",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg0, "votedToSkip", 1)
			end,
		},
	})
	self:linkToElementModel(self, "hostIsSkipping", true, function(model)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "hostIsSkipping",
		})
	end)
	self:linkToElementModel(self, "showSkipButton", true, function(model)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "showSkipButton",
		})
	end)
	self:linkToElementModel(self, "votedToSkip", true, function(model)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "votedToSkip",
		})
	end)
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.cp_skip_scene_menu.__resetProperties = function(f9_arg0)
	f9_arg0.CPHostSkippingScene0:completeAnimation()
	f9_arg0.CPSkipSceneButton0:completeAnimation()
	f9_arg0.CPVoteSkippingScene0:completeAnimation()
	f9_arg0.CPHostSkippingScene0:setAlpha(0)
	f9_arg0.CPSkipSceneButton0:setLeftRight(1, 1, -394, -113)
	f9_arg0.CPSkipSceneButton0:setTopBottom(1, 1, -104, -66)
	f9_arg0.CPSkipSceneButton0:setAlpha(0)
	f9_arg0.CPVoteSkippingScene0:setAlpha(0)
end
CoD.cp_skip_scene_menu.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
	HostIsSkipping = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.CPHostSkippingScene0:beginAnimation(500)
				f11_arg0.CPHostSkippingScene0:setAlpha(1)
				f11_arg0.CPHostSkippingScene0:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.CPHostSkippingScene0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.CPHostSkippingScene0:completeAnimation()
			f11_arg0.CPHostSkippingScene0:setAlpha(0)
			f11_local0(f11_arg0.CPHostSkippingScene0)
		end,
		DefaultState = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			local f13_local0 = function(f14_arg0)
				f13_arg0.CPHostSkippingScene0:beginAnimation(500)
				f13_arg0.CPHostSkippingScene0:setAlpha(0)
				f13_arg0.CPHostSkippingScene0:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.CPHostSkippingScene0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.CPHostSkippingScene0:completeAnimation()
			f13_arg0.CPHostSkippingScene0:setAlpha(1)
			f13_local0(f13_arg0.CPHostSkippingScene0)
			f13_arg0.CPSkipSceneButton0:beginAnimation(500)
			f13_arg0.CPSkipSceneButton0:setAlpha(0)
			f13_arg0.CPSkipSceneButton0:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
			f13_arg0.CPSkipSceneButton0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
		end,
	},
	ShowSkipButton_Newsroom = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			local f15_local0 = function(f16_arg0)
				f15_arg0.CPSkipSceneButton0:beginAnimation(500)
				f15_arg0.CPSkipSceneButton0:setLeftRight(1, 1, -1903, -1622)
				f15_arg0.CPSkipSceneButton0:setAlpha(1)
				f15_arg0.CPSkipSceneButton0:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.CPSkipSceneButton0:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.CPSkipSceneButton0:completeAnimation()
			f15_arg0.CPSkipSceneButton0:setLeftRight(1, 1, -1903.5, -1622.5)
			f15_arg0.CPSkipSceneButton0:setTopBottom(1, 1, -941, -903)
			f15_arg0.CPSkipSceneButton0:setAlpha(0)
			f15_local0(f15_arg0.CPSkipSceneButton0)
		end,
		DefaultState = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			f17_arg0.CPHostSkippingScene0:beginAnimation(500)
			f17_arg0.CPHostSkippingScene0:setAlpha(0)
			f17_arg0.CPHostSkippingScene0:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
			f17_arg0.CPHostSkippingScene0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			local f17_local0 = function(f18_arg0)
				f17_arg0.CPSkipSceneButton0:beginAnimation(490)
				f17_arg0.CPSkipSceneButton0:setAlpha(0)
				f17_arg0.CPSkipSceneButton0:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.CPSkipSceneButton0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.CPSkipSceneButton0:completeAnimation()
			f17_arg0.CPSkipSceneButton0:setAlpha(1)
			f17_local0(f17_arg0.CPSkipSceneButton0)
		end,
	},
	ShowSkipButton = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			local f19_local0 = function(f20_arg0)
				f19_arg0.CPSkipSceneButton0:beginAnimation(500)
				f19_arg0.CPSkipSceneButton0:setAlpha(1)
				f19_arg0.CPSkipSceneButton0:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.CPSkipSceneButton0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.CPSkipSceneButton0:completeAnimation()
			f19_arg0.CPSkipSceneButton0:setAlpha(0)
			f19_local0(f19_arg0.CPSkipSceneButton0)
		end,
		DefaultState = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.CPHostSkippingScene0:beginAnimation(500)
			f21_arg0.CPHostSkippingScene0:setAlpha(0)
			f21_arg0.CPHostSkippingScene0:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
			f21_arg0.CPHostSkippingScene0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			local f21_local0 = function(f22_arg0)
				f21_arg0.CPSkipSceneButton0:beginAnimation(490)
				f21_arg0.CPSkipSceneButton0:setAlpha(0)
				f21_arg0.CPSkipSceneButton0:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.CPSkipSceneButton0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.CPSkipSceneButton0:completeAnimation()
			f21_arg0.CPSkipSceneButton0:setAlpha(1)
			f21_local0(f21_arg0.CPSkipSceneButton0)
		end,
	},
	VotedToSkip = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			local f23_local0 = function(f24_arg0)
				f23_arg0.CPVoteSkippingScene0:beginAnimation(250)
				f23_arg0.CPVoteSkippingScene0:setAlpha(1)
				f23_arg0.CPVoteSkippingScene0:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.CPVoteSkippingScene0:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.CPVoteSkippingScene0:completeAnimation()
			f23_arg0.CPVoteSkippingScene0:setAlpha(0)
			f23_local0(f23_arg0.CPVoteSkippingScene0)
		end,
	},
}
CoD.cp_skip_scene_menu.__onClose = function(f25_arg0)
	f25_arg0.CPHostSkippingScene0:close()
	f25_arg0.CPSkipSceneButton0:close()
	f25_arg0.CPVoteSkippingScene0:close()
end
