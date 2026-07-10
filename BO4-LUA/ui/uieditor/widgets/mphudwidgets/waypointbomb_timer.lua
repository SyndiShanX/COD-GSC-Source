CoD.WaypointBomb_Timer = InheritFrom(LUI.UIElement)
CoD.WaypointBomb_Timer.__defaultWidth = 114
CoD.WaypointBomb_Timer.__defaultHeight = 27
CoD.WaypointBomb_Timer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WaypointBomb_Timer)
	self.id = "WaypointBomb_Timer"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GameTimerMinutes = LUI.UIText.new(0, 0, 15, 46, 0, 0, 1, 27)
	GameTimerMinutes:setTTF("0arame_mono_stencil")
	GameTimerMinutes:setLetterSpacing(1)
	GameTimerMinutes:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	GameTimerMinutes:setupGameTimerMinutes()
	GameTimerMinutes:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	self:addElement(GameTimerMinutes)
	self.GameTimerMinutes = GameTimerMinutes
	local GameTimerSeconds = LUI.UIText.new(0, 0, 58.5, 112.5, 0, 0, 1, 27)
	GameTimerSeconds:setTTF("0arame_mono_stencil")
	GameTimerSeconds:setLetterSpacing(1)
	GameTimerSeconds:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	GameTimerSeconds:setupGameTimerSeconds()
	GameTimerSeconds:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(GameTimerSeconds)
	self.GameTimerSeconds = GameTimerSeconds
	local ring3 = LUI.UIImage.new(0, 0, 48, 51, 0, 0, 13, 16)
	ring3:setImage(RegisterImage(@"hash_1C64E99F5F757CB"))
	ring3:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(ring3)
	self.ring3 = ring3
	local line = LUI.UIImage.new(0, 0, 49, 50, 0, 0, 17, 23)
	line:setAlpha(0.2)
	self:addElement(line)
	self.line = line
	local line2 = LUI.UIImage.new(0, 0, 49, 50, 0, 0, 5, 11)
	line2:setAlpha(0.2)
	self:addElement(line2)
	self.line2 = line2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WaypointBomb_Timer.__resetProperties = function(f2_arg0)
	f2_arg0.GameTimerSeconds:completeAnimation()
	f2_arg0.GameTimerMinutes:completeAnimation()
	f2_arg0.line2:completeAnimation()
	f2_arg0.line:completeAnimation()
	f2_arg0.ring3:completeAnimation()
	f2_arg0.GameTimerSeconds:setLeftRight(0, 0, 58.5, 112.5)
	f2_arg0.GameTimerSeconds:setRGB(1, 1, 1)
	f2_arg0.GameTimerSeconds:setAlpha(1)
	f2_arg0.GameTimerMinutes:setAlpha(1)
	f2_arg0.line2:setAlpha(0.2)
	f2_arg0.line:setAlpha(0.2)
	f2_arg0.ring3:setAlpha(1)
end
CoD.WaypointBomb_Timer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(5)
			f3_arg0.GameTimerMinutes:completeAnimation()
			f3_arg0.GameTimerMinutes:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.GameTimerMinutes)
			f3_arg0.GameTimerSeconds:completeAnimation()
			f3_arg0.GameTimerSeconds:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.GameTimerSeconds)
			f3_arg0.ring3:completeAnimation()
			f3_arg0.ring3:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.ring3)
			f3_arg0.line:completeAnimation()
			f3_arg0.line:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.line)
			f3_arg0.line2:completeAnimation()
			f3_arg0.line2:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.line2)
		end,
	},
	TimeLow = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(5)
			f4_arg0.GameTimerMinutes:completeAnimation()
			f4_arg0.GameTimerMinutes:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.GameTimerMinutes)
			local f4_local0 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					f6_arg0:beginAnimation(500)
					f6_arg0:setRGB(1, 1, 1)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
				end
				f4_arg0.GameTimerSeconds:beginAnimation(500)
				f4_arg0.GameTimerSeconds:setRGB(1, 0, 0)
				f4_arg0.GameTimerSeconds:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.GameTimerSeconds:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f4_arg0.GameTimerSeconds:completeAnimation()
			f4_arg0.GameTimerSeconds:setLeftRight(0, 0, 26, 80)
			f4_arg0.GameTimerSeconds:setRGB(1, 1, 1)
			f4_local0(f4_arg0.GameTimerSeconds)
			f4_arg0.ring3:completeAnimation()
			f4_arg0.ring3:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.ring3)
			f4_arg0.line:completeAnimation()
			f4_arg0.line:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.line)
			f4_arg0.line2:completeAnimation()
			f4_arg0.line2:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.line2)
			f4_arg0.nextClip = "DefaultClip"
		end,
	},
	Active = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
}
