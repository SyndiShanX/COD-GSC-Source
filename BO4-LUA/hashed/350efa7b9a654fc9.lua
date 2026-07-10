CoD.WarzoneStreamHider = InheritFrom(LUI.UIElement)
CoD.WarzoneStreamHider.__defaultWidth = 1920
CoD.WarzoneStreamHider.__defaultHeight = 1080
CoD.WarzoneStreamHider.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneStreamHider)
	self.id = "WarzoneStreamHider"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ObscuringBackground = LUI.UIImage.new(-0.1, 1.1, 0, 0, -0.1, 1.1, 0, 0)
	ObscuringBackground:setRGB(0, 0, 0)
	ObscuringBackground:setAlpha(0)
	self:addElement(ObscuringBackground)
	self.ObscuringBackground = ObscuringBackground
	self:mergeStateConditions({
		{
			stateName = "Obscuring",
			condition = function(menu, element, event)
				return IsSelfInState(self, "Obscuring")
			end,
		},
	})
	self:subscribeToGlobalModel(f1_arg1, "PerController", "deadSpectator.playerIndex", function(model)
		local f3_local0 = self
		if IsControllerPlayerDead(f1_arg1) then
			CoD.HUDUtility.StartStreamHiding(self, f1_arg1, 3, 50, 2000, 0.9, 0.8)
		end
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneStreamHider.__resetProperties = function(f4_arg0)
	f4_arg0.ObscuringBackground:completeAnimation()
	f4_arg0.ObscuringBackground:setAlpha(0)
end
CoD.WarzoneStreamHider.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	Obscuring = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.ObscuringBackground:completeAnimation()
			f6_arg0.ObscuringBackground:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.ObscuringBackground)
		end,
		DefaultState = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.ObscuringBackground:beginAnimation(100)
				f7_arg0.ObscuringBackground:setAlpha(0)
				f7_arg0.ObscuringBackground:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.ObscuringBackground:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.ObscuringBackground:completeAnimation()
			f7_arg0.ObscuringBackground:setAlpha(1)
			f7_local0(f7_arg0.ObscuringBackground)
		end,
	},
}
