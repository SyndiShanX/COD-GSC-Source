require("x64:20b3eeae9b7d557")
CoD.DirectorMapGameTypeAndDifficulty = InheritFrom(LUI.UIElement)
CoD.DirectorMapGameTypeAndDifficulty.__defaultWidth = 382
CoD.DirectorMapGameTypeAndDifficulty.__defaultHeight = 180
CoD.DirectorMapGameTypeAndDifficulty.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorMapGameTypeAndDifficulty)
	self.id = "DirectorMapGameTypeAndDifficulty"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorMapAndGameInternal = CoD.DirectorMapAndGameTypeInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DirectorMapAndGameInternal:mergeStateConditions({
		{
			stateName = "Unselectable",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsSelfInState(self, "Unselectable")
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return not IsPartyLeader(f1_arg1)
			end,
		},
	})
	local f1_local2 = DirectorMapAndGameInternal
	local f1_local3 = DirectorMapAndGameInternal.subscribeToModel
	local f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f4_arg0)
		f1_arg0:updateElementState(DirectorMapAndGameInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local2 = DirectorMapAndGameInternal
	f1_local3 = DirectorMapAndGameInternal.subscribeToModel
	f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.privateClient.isHost"], function(f5_arg0)
		f1_arg0:updateElementState(DirectorMapAndGameInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.privateClient.isHost",
		})
	end, false)
	f1_local2 = DirectorMapAndGameInternal
	f1_local3 = DirectorMapAndGameInternal.subscribeToModel
	f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.gameClient.isHost"], function(f6_arg0)
		f1_arg0:updateElementState(DirectorMapAndGameInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lobbyRoot.gameClient.isHost",
		})
	end, false)
	DirectorMapAndGameInternal.GamemodeIcon:setScale(0.8, 0.8)
	self:addElement(DirectorMapAndGameInternal)
	self.DirectorMapAndGameInternal = DirectorMapAndGameInternal
	self:mergeStateConditions({
		{
			stateName = "Unselectable",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f8_arg2, f8_arg3, f8_arg4)
		UpdateElementState(self, "DirectorMapAndGameInternal", controller)
	end)
	DirectorMapAndGameInternal.id = "DirectorMapAndGameInternal"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorMapGameTypeAndDifficulty.__resetProperties = function(f9_arg0)
	f9_arg0.DirectorMapAndGameInternal:completeAnimation()
	f9_arg0.DirectorMapAndGameInternal:setScale(1, 1)
end
CoD.DirectorMapGameTypeAndDifficulty.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.DirectorMapAndGameInternal:completeAnimation()
			f11_arg0.DirectorMapAndGameInternal:setScale(1.05, 1.05)
			f11_arg0.clipFinished(f11_arg0.DirectorMapAndGameInternal)
		end,
		GainChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			local f12_local0 = function(f13_arg0)
				f12_arg0.DirectorMapAndGameInternal:beginAnimation(200)
				f12_arg0.DirectorMapAndGameInternal:setScale(1.05, 1.05)
				f12_arg0.DirectorMapAndGameInternal:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.DirectorMapAndGameInternal:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.DirectorMapAndGameInternal:completeAnimation()
			f12_arg0.DirectorMapAndGameInternal:setScale(1, 1)
			f12_local0(f12_arg0.DirectorMapAndGameInternal)
		end,
		LoseChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			local f14_local0 = function(f15_arg0)
				f14_arg0.DirectorMapAndGameInternal:beginAnimation(200)
				f14_arg0.DirectorMapAndGameInternal:setScale(1, 1)
				f14_arg0.DirectorMapAndGameInternal:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.DirectorMapAndGameInternal:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.DirectorMapAndGameInternal:completeAnimation()
			f14_arg0.DirectorMapAndGameInternal:setScale(1.05, 1.05)
			f14_local0(f14_arg0.DirectorMapAndGameInternal)
		end,
	},
	Unselectable = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.DirectorMapGameTypeAndDifficulty.__onClose = function(f17_arg0)
	f17_arg0.DirectorMapAndGameInternal:close()
end
