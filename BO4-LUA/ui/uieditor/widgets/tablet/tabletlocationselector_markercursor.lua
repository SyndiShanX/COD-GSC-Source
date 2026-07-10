CoD.TabletLocationSelector_MarkerCursor = InheritFrom(LUI.UIElement)
CoD.TabletLocationSelector_MarkerCursor.__defaultWidth = 50
CoD.TabletLocationSelector_MarkerCursor.__defaultHeight = 50
CoD.TabletLocationSelector_MarkerCursor.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabletLocationSelector_MarkerCursor)
	self.id = "TabletLocationSelector_MarkerCursor"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Crosshair = LUI.UIImage.new(0.5, 0.5, -50, 50, 0.5, 0.5, -50, 50)
	Crosshair:setImage(RegisterImage(@"uie_ui_hud_cp_hud_tacmode_crosshair"))
	self:addElement(Crosshair)
	self.Crosshair = Crosshair
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabletLocationSelector_MarkerCursor.__resetProperties = function(f2_arg0)
	f2_arg0.Crosshair:completeAnimation()
	f2_arg0.Crosshair:setRGB(1, 1, 1)
	f2_arg0.Crosshair:setAlpha(1)
	f2_arg0.Crosshair:setScale(1, 1)
end
CoD.TabletLocationSelector_MarkerCursor.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Release = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			local f4_local0 = function(f5_arg0)
				f4_arg0.Crosshair:beginAnimation(150)
				f4_arg0.Crosshair:setScale(8, 8)
				f4_arg0.Crosshair:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.Crosshair:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.Crosshair:completeAnimation()
			f4_arg0.Crosshair:setAlpha(0)
			f4_arg0.Crosshair:setScale(1, 1)
			f4_local0(f4_arg0.Crosshair)
		end,
		Acquire = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.Crosshair:beginAnimation(150)
				f6_arg0.Crosshair:setAlpha(1)
				f6_arg0.Crosshair:setScale(1, 1)
				f6_arg0.Crosshair:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.Crosshair:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.Crosshair:completeAnimation()
			f6_arg0.Crosshair:setRGB(1, 0.82, 0)
			f6_arg0.Crosshair:setAlpha(0)
			f6_arg0.Crosshair:setScale(8, 8)
			f6_local0(f6_arg0.Crosshair)
		end,
	},
}
