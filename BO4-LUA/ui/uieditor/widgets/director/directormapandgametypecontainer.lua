require("x64:20b3eeae9b7d557")
CoD.DirectorMapAndGameTypeContainer = InheritFrom(LUI.UIElement)
CoD.DirectorMapAndGameTypeContainer.__defaultWidth = 356
CoD.DirectorMapAndGameTypeContainer.__defaultHeight = 200
CoD.DirectorMapAndGameTypeContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorMapAndGameTypeContainer)
	self.id = "DirectorMapAndGameTypeContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorMapAndGameInternal = CoD.DirectorMapAndGameTypeInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DirectorMapAndGameInternal:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return not IsPartyLeader(f1_arg1)
			end,
		},
	})
	local f1_local2 = DirectorMapAndGameInternal
	local f1_local3 = DirectorMapAndGameInternal.subscribeToModel
	local f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f3_arg0)
		f1_arg0:updateElementState(DirectorMapAndGameInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local2 = DirectorMapAndGameInternal
	f1_local3 = DirectorMapAndGameInternal.subscribeToModel
	f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.privateClient.isHost"], function(f4_arg0)
		f1_arg0:updateElementState(DirectorMapAndGameInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyRoot.privateClient.isHost",
		})
	end, false)
	f1_local2 = DirectorMapAndGameInternal
	f1_local3 = DirectorMapAndGameInternal.subscribeToModel
	f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.gameClient.isHost"], function(f5_arg0)
		f1_arg0:updateElementState(DirectorMapAndGameInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.gameClient.isHost",
		})
	end, false)
	self:addElement(DirectorMapAndGameInternal)
	self.DirectorMapAndGameInternal = DirectorMapAndGameInternal
	DirectorMapAndGameInternal.id = "DirectorMapAndGameInternal"
	self.__defaultFocus = DirectorMapAndGameInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorMapAndGameTypeContainer.__resetProperties = function(f6_arg0)
	f6_arg0.DirectorMapAndGameInternal:completeAnimation()
	f6_arg0.DirectorMapAndGameInternal:setScale(1, 1)
end
CoD.DirectorMapAndGameTypeContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.DirectorMapAndGameInternal:completeAnimation()
			f8_arg0.DirectorMapAndGameInternal:setScale(1.05, 1.05)
			f8_arg0.clipFinished(f8_arg0.DirectorMapAndGameInternal)
		end,
		GainChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.DirectorMapAndGameInternal:beginAnimation(200)
				f9_arg0.DirectorMapAndGameInternal:setScale(1.05, 1.05)
				f9_arg0.DirectorMapAndGameInternal:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.DirectorMapAndGameInternal:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.DirectorMapAndGameInternal:completeAnimation()
			f9_arg0.DirectorMapAndGameInternal:setScale(1, 1)
			f9_local0(f9_arg0.DirectorMapAndGameInternal)
		end,
		LoseChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.DirectorMapAndGameInternal:beginAnimation(200)
				f11_arg0.DirectorMapAndGameInternal:setScale(1, 1)
				f11_arg0.DirectorMapAndGameInternal:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.DirectorMapAndGameInternal:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.DirectorMapAndGameInternal:completeAnimation()
			f11_arg0.DirectorMapAndGameInternal:setScale(1.05, 1.05)
			f11_local0(f11_arg0.DirectorMapAndGameInternal)
		end,
	},
}
CoD.DirectorMapAndGameTypeContainer.__onClose = function(f13_arg0)
	f13_arg0.DirectorMapAndGameInternal:close()
end
