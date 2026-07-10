require("x64:61a4811b8d5e2a3")
CoD.DirectorDraftSelectLoadout = InheritFrom(LUI.UIElement)
CoD.DirectorDraftSelectLoadout.__defaultWidth = 75
CoD.DirectorDraftSelectLoadout.__defaultHeight = 75
CoD.DirectorDraftSelectLoadout.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorDraftSelectLoadout)
	self.id = "DirectorDraftSelectLoadout"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorDraftSelectLoadoutInternal = CoD.DirectorDraftSelectLoadoutInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 75, 0, 0, 0, 75)
	self:addElement(DirectorDraftSelectLoadoutInternal)
	self.DirectorDraftSelectLoadoutInternal = DirectorDraftSelectLoadoutInternal
	DirectorDraftSelectLoadoutInternal.id = "DirectorDraftSelectLoadoutInternal"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorDraftSelectLoadout.__resetProperties = function(f2_arg0)
	f2_arg0.DirectorDraftSelectLoadoutInternal:completeAnimation()
	f2_arg0.DirectorDraftSelectLoadoutInternal:setScale(1, 1)
end
CoD.DirectorDraftSelectLoadout.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.DirectorDraftSelectLoadoutInternal:completeAnimation()
			f4_arg0.DirectorDraftSelectLoadoutInternal:setScale(1.12, 1.12)
			f4_arg0.clipFinished(f4_arg0.DirectorDraftSelectLoadoutInternal)
		end,
		GainChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				f5_arg0.DirectorDraftSelectLoadoutInternal:beginAnimation(200)
				f5_arg0.DirectorDraftSelectLoadoutInternal:setScale(1.12, 1.12)
				f5_arg0.DirectorDraftSelectLoadoutInternal:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.DirectorDraftSelectLoadoutInternal:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.DirectorDraftSelectLoadoutInternal:completeAnimation()
			f5_arg0.DirectorDraftSelectLoadoutInternal:setScale(1, 1)
			f5_local0(f5_arg0.DirectorDraftSelectLoadoutInternal)
		end,
		LoseChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.DirectorDraftSelectLoadoutInternal:beginAnimation(200)
				f7_arg0.DirectorDraftSelectLoadoutInternal:setScale(1, 1)
				f7_arg0.DirectorDraftSelectLoadoutInternal:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.DirectorDraftSelectLoadoutInternal:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.DirectorDraftSelectLoadoutInternal:completeAnimation()
			f7_arg0.DirectorDraftSelectLoadoutInternal:setScale(1.12, 1.12)
			f7_local0(f7_arg0.DirectorDraftSelectLoadoutInternal)
		end,
	},
}
CoD.DirectorDraftSelectLoadout.__onClose = function(f9_arg0)
	f9_arg0.DirectorDraftSelectLoadoutInternal:close()
end
