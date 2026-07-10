CoD.remoteMissileTarget = InheritFrom(LUI.UIElement)
CoD.remoteMissileTarget.__defaultWidth = 1920
CoD.remoteMissileTarget.__defaultHeight = 1080
CoD.remoteMissileTarget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.remoteMissileTarget)
	self.id = "remoteMissileTarget"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local target = LUI.UIImage.new(0, 0, 0, 116, 0, 0, 0, 96)
	target:setImage(RegisterImage(@"uie_t7_cp_hud_weakpoint_targethex"))
	target:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	target:setupRemoteMissileTarget(0)
	self:addElement(target)
	self.target = target
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.remoteMissileTarget.__resetProperties = function(f2_arg0)
	f2_arg0.target:completeAnimation()
	f2_arg0.target:setAlpha(1)
end
CoD.remoteMissileTarget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.target:completeAnimation()
			f3_arg0.target:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.target)
		end,
	},
	Visible = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
}
