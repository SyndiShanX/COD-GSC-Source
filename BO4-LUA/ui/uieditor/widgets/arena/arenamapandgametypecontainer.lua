require("x64:7fd9d2ec206e221")
CoD.ArenaMapAndGameTypeContainer = InheritFrom(LUI.UIElement)
CoD.ArenaMapAndGameTypeContainer.__defaultWidth = 356
CoD.ArenaMapAndGameTypeContainer.__defaultHeight = 150
CoD.ArenaMapAndGameTypeContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaMapAndGameTypeContainer)
	self.id = "ArenaMapAndGameTypeContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ArenaMapAndGameTypeInternal = CoD.ArenaMapAndGameTypeInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	ArenaMapAndGameTypeInternal.PlaylistHeaderBacking:setAlpha(0.8)
	ArenaMapAndGameTypeInternal.PlaylistHeader:setAlpha(1)
	ArenaMapAndGameTypeInternal.PlaylistHeaderNonHost:setAlpha(1)
	self:addElement(ArenaMapAndGameTypeInternal)
	self.ArenaMapAndGameTypeInternal = ArenaMapAndGameTypeInternal
	ArenaMapAndGameTypeInternal.id = "ArenaMapAndGameTypeInternal"
	self.__defaultFocus = ArenaMapAndGameTypeInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaMapAndGameTypeContainer.__resetProperties = function(f2_arg0)
	f2_arg0.ArenaMapAndGameTypeInternal:completeAnimation()
	f2_arg0.ArenaMapAndGameTypeInternal:setScale(1, 1)
end
CoD.ArenaMapAndGameTypeContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.ArenaMapAndGameTypeInternal:completeAnimation()
			f4_arg0.ArenaMapAndGameTypeInternal:setScale(1.05, 1.05)
			f4_arg0.clipFinished(f4_arg0.ArenaMapAndGameTypeInternal)
		end,
		GainChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				f5_arg0.ArenaMapAndGameTypeInternal:beginAnimation(200)
				f5_arg0.ArenaMapAndGameTypeInternal:setScale(1.05, 1.05)
				f5_arg0.ArenaMapAndGameTypeInternal:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.ArenaMapAndGameTypeInternal:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.ArenaMapAndGameTypeInternal:completeAnimation()
			f5_arg0.ArenaMapAndGameTypeInternal:setScale(1, 1)
			f5_local0(f5_arg0.ArenaMapAndGameTypeInternal)
		end,
		LoseChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.ArenaMapAndGameTypeInternal:beginAnimation(200)
				f7_arg0.ArenaMapAndGameTypeInternal:setScale(1, 1)
				f7_arg0.ArenaMapAndGameTypeInternal:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.ArenaMapAndGameTypeInternal:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.ArenaMapAndGameTypeInternal:completeAnimation()
			f7_arg0.ArenaMapAndGameTypeInternal:setScale(1.05, 1.05)
			f7_local0(f7_arg0.ArenaMapAndGameTypeInternal)
		end,
	},
}
CoD.ArenaMapAndGameTypeContainer.__onClose = function(f9_arg0)
	f9_arg0.ArenaMapAndGameTypeInternal:close()
end
