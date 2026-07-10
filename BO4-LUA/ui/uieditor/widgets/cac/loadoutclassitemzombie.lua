require("x64:3ad37e78efb57cc")
CoD.LoadoutClassItemZombie = InheritFrom(LUI.UIElement)
CoD.LoadoutClassItemZombie.__defaultWidth = 300
CoD.LoadoutClassItemZombie.__defaultHeight = 200
CoD.LoadoutClassItemZombie.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LoadoutClassItemZombie)
	self.id = "LoadoutClassItemZombie"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LoadoutClassItemContainerZombie = CoD.LoadoutClassItemContainerZombie.new(f1_arg0, f1_arg1, 0, 0, 0, 300, 0, 1, 0, 0)
	LoadoutClassItemContainerZombie.loadoutName:setAlpha(0.6)
	LoadoutClassItemContainerZombie:linkToElementModel(self, nil, false, function(model)
		LoadoutClassItemContainerZombie:setModel(model, f1_arg1)
	end)
	self:addElement(LoadoutClassItemContainerZombie)
	self.LoadoutClassItemContainerZombie = LoadoutClassItemContainerZombie
	LoadoutClassItemContainerZombie.id = "LoadoutClassItemContainerZombie"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LoadoutClassItemZombie.__resetProperties = function(f3_arg0)
	f3_arg0.LoadoutClassItemContainerZombie:completeAnimation()
	f3_arg0.LoadoutClassItemContainerZombie:setScale(1, 1)
end
CoD.LoadoutClassItemZombie.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.LoadoutClassItemContainerZombie:completeAnimation()
			f5_arg0.LoadoutClassItemContainerZombie:setScale(1.02, 1.02)
			f5_arg0.clipFinished(f5_arg0.LoadoutClassItemContainerZombie)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.LoadoutClassItemContainerZombie:beginAnimation(100)
				f6_arg0.LoadoutClassItemContainerZombie:setScale(1.02, 1.02)
				f6_arg0.LoadoutClassItemContainerZombie:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.LoadoutClassItemContainerZombie:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.LoadoutClassItemContainerZombie:completeAnimation()
			f6_arg0.LoadoutClassItemContainerZombie:setScale(1, 1)
			f6_local0(f6_arg0.LoadoutClassItemContainerZombie)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.LoadoutClassItemContainerZombie:beginAnimation(100)
				f8_arg0.LoadoutClassItemContainerZombie:setScale(1, 1)
				f8_arg0.LoadoutClassItemContainerZombie:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.LoadoutClassItemContainerZombie:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.LoadoutClassItemContainerZombie:completeAnimation()
			f8_arg0.LoadoutClassItemContainerZombie:setScale(1.02, 1.02)
			f8_local0(f8_arg0.LoadoutClassItemContainerZombie)
		end,
	},
}
CoD.LoadoutClassItemZombie.__onClose = function(f10_arg0)
	f10_arg0.LoadoutClassItemContainerZombie:close()
end
