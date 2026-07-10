require("x64:d94fe7d3f94ed62")
CoD.SpecialistOutfitEntry = InheritFrom(LUI.UIElement)
CoD.SpecialistOutfitEntry.__defaultWidth = 125
CoD.SpecialistOutfitEntry.__defaultHeight = 150
CoD.SpecialistOutfitEntry.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialistOutfitEntry)
	self.id = "SpecialistOutfitEntry"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local internal = CoD.SpecialistOutfitEntry_Internal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	internal:linkToElementModel(self, nil, false, function(model)
		internal:setModel(model, f1_arg1)
	end)
	self:addElement(internal)
	self.internal = internal
	internal.id = "internal"
	self.__defaultFocus = internal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpecialistOutfitEntry.__resetProperties = function(f3_arg0)
	f3_arg0.internal:completeAnimation()
	f3_arg0.internal:setScale(1, 1)
end
CoD.SpecialistOutfitEntry.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.internal:completeAnimation()
			f4_arg0.internal:setScale(0.97, 0.95)
			f4_arg0.clipFinished(f4_arg0.internal)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.internal:completeAnimation()
			f5_arg0.internal:setScale(1.02, 1.04)
			f5_arg0.clipFinished(f5_arg0.internal)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.internal:beginAnimation(150)
				f6_arg0.internal:setScale(1.02, 1.04)
				f6_arg0.internal:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.internal:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.internal:completeAnimation()
			f6_arg0.internal:setScale(0.97, 0.95)
			f6_local0(f6_arg0.internal)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.internal:beginAnimation(100)
				f8_arg0.internal:setScale(0.97, 0.95)
				f8_arg0.internal:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.internal:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.internal:completeAnimation()
			f8_arg0.internal:setScale(1.02, 1.04)
			f8_local0(f8_arg0.internal)
		end,
	},
}
CoD.SpecialistOutfitEntry.__onClose = function(f10_arg0)
	f10_arg0.internal:close()
end
