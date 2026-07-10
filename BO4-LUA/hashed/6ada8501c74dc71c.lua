CoD.DeathMarker = InheritFrom(LUI.UIElement)
CoD.DeathMarker.__defaultWidth = 40
CoD.DeathMarker.__defaultHeight = 40
CoD.DeathMarker.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DeathMarker)
	self.id = "DeathMarker"
	self.soundSet = "ChooseDecal"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DeathIcon = LUI.UIImage.new(0, 0, 0, 40, 0, 0, 0, 40)
	DeathIcon:setImage(RegisterImage(@"uie_t7_headicon_dead"))
	self:addElement(DeathIcon)
	self.DeathIcon = DeathIcon
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DeathMarker.__resetProperties = function(f2_arg0)
	f2_arg0.DeathIcon:completeAnimation()
	f2_arg0.DeathIcon:setAlpha(1)
end
CoD.DeathMarker.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.DeathIcon:completeAnimation()
			f3_arg0.DeathIcon:setAlpha(1)
			f3_arg0.clipFinished(f3_arg0.DeathIcon)
		end,
	},
	Hidden = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.DeathIcon:completeAnimation()
			f4_arg0.DeathIcon:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.DeathIcon)
		end,
	},
}
