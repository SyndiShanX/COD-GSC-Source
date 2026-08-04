CoD.CallingCards_Asset_ghost_spin = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_ghost_spin.__defaultWidth = 720
CoD.CallingCards_Asset_ghost_spin.__defaultHeight = 720
CoD.CallingCards_Asset_ghost_spin.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_ghost_spin)
	self.id = "CallingCards_Asset_ghost_spin"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ghostSpin = LUI.UIImage.new(0, 0, 0, 720, 0, 0, 0, 720)
	ghostSpin:setImage(RegisterImage("uie_ui_icon_callingcards_zm_darkops_light_ghost"))
	self:addElement(ghostSpin)
	self.ghostSpin = ghostSpin
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_ghost_spin.__resetProperties = function(f2_arg0)
	f2_arg0.ghostSpin:completeAnimation()
	f2_arg0.ghostSpin:setZRot(0)
end
CoD.CallingCards_Asset_ghost_spin.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				f3_arg0.ghostSpin:beginAnimation(4000)
				f3_arg0.ghostSpin:setZRot(-180)
				f3_arg0.ghostSpin:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.ghostSpin:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.ghostSpin:completeAnimation()
			f3_arg0.ghostSpin:setZRot(0)
			f3_local0(f3_arg0.ghostSpin)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
