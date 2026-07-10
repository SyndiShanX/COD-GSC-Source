require("x64:46897811dbbcd6f")
CoD.PlayersListActionButton = InheritFrom(LUI.UIElement)
CoD.PlayersListActionButton.__defaultWidth = 151
CoD.PlayersListActionButton.__defaultHeight = 92
CoD.PlayersListActionButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PlayersListActionButton)
	self.id = "PlayersListActionButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ActionButton = CoD.CommonListButtonShort_Internal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	ActionButton.Title:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	self:addElement(ActionButton)
	self.ActionButton = ActionButton
	ActionButton.id = "ActionButton"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PlayersListActionButton.__resetProperties = function(f2_arg0)
	f2_arg0.ActionButton:completeAnimation()
	f2_arg0.ActionButton:setScale(1, 1)
	f2_arg0.ActionButton.Title:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
end
CoD.PlayersListActionButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	AddPlayers = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.ActionButton:completeAnimation()
			f4_arg0.ActionButton.Title:completeAnimation()
			f4_arg0.ActionButton.Title:setText(Engine[0xF9F1239CFD921FE](0x8560D39E3DABF67))
			f4_arg0.clipFinished(f4_arg0.ActionButton)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.ActionButton:completeAnimation()
			f5_arg0.ActionButton.Title:completeAnimation()
			f5_arg0.ActionButton:setScale(1.05, 1.05)
			f5_arg0.ActionButton.Title:setText(Engine[0xF9F1239CFD921FE](0x8560D39E3DABF67))
			f5_arg0.clipFinished(f5_arg0.ActionButton)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.ActionButton:beginAnimation(200)
				f6_arg0.ActionButton:setScale(1.05, 1.05)
				f6_arg0.ActionButton:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.ActionButton:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.ActionButton:completeAnimation()
			f6_arg0.ActionButton.Title:completeAnimation()
			f6_arg0.ActionButton:setScale(1, 1)
			f6_arg0.ActionButton.Title:setText(Engine[0xF9F1239CFD921FE](0x8560D39E3DABF67))
			f6_local0(f6_arg0.ActionButton)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.ActionButton:beginAnimation(200)
				f8_arg0.ActionButton:setScale(1, 1)
				f8_arg0.ActionButton:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.ActionButton:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.ActionButton:completeAnimation()
			f8_arg0.ActionButton.Title:completeAnimation()
			f8_arg0.ActionButton:setScale(1.05, 1.05)
			f8_arg0.ActionButton.Title:setText(Engine[0xF9F1239CFD921FE](0x8560D39E3DABF67))
			f8_local0(f8_arg0.ActionButton)
		end,
	},
	RemovePlayers = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.ActionButton:completeAnimation()
			f10_arg0.ActionButton.Title:completeAnimation()
			f10_arg0.ActionButton.Title:setText(Engine[0xF9F1239CFD921FE](0xA24DD815FB15C3E))
			f10_arg0.clipFinished(f10_arg0.ActionButton)
		end,
		ChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.ActionButton:completeAnimation()
			f11_arg0.ActionButton.Title:completeAnimation()
			f11_arg0.ActionButton:setScale(1.05, 1.05)
			f11_arg0.ActionButton.Title:setText(Engine[0xF9F1239CFD921FE](0xA24DD815FB15C3E))
			f11_arg0.clipFinished(f11_arg0.ActionButton)
		end,
		GainChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			local f12_local0 = function(f13_arg0)
				f12_arg0.ActionButton:beginAnimation(200)
				f12_arg0.ActionButton:setScale(1.05, 1.05)
				f12_arg0.ActionButton:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.ActionButton:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.ActionButton:completeAnimation()
			f12_arg0.ActionButton.Title:completeAnimation()
			f12_arg0.ActionButton:setScale(1, 1)
			f12_arg0.ActionButton.Title:setText(Engine[0xF9F1239CFD921FE](0xA24DD815FB15C3E))
			f12_local0(f12_arg0.ActionButton)
		end,
		LoseChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			local f14_local0 = function(f15_arg0)
				f14_arg0.ActionButton:beginAnimation(200)
				f14_arg0.ActionButton:setScale(1, 1)
				f14_arg0.ActionButton:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.ActionButton:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.ActionButton:completeAnimation()
			f14_arg0.ActionButton.Title:completeAnimation()
			f14_arg0.ActionButton:setScale(1.05, 1.05)
			f14_arg0.ActionButton.Title:setText(Engine[0xF9F1239CFD921FE](0xA24DD815FB15C3E))
			f14_local0(f14_arg0.ActionButton)
		end,
	},
}
CoD.PlayersListActionButton.__onClose = function(f16_arg0)
	f16_arg0.ActionButton:close()
end
