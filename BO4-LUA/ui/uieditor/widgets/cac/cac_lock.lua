CoD.cac_lock = InheritFrom(LUI.UIElement)
CoD.cac_lock.__defaultWidth = 48
CoD.cac_lock.__defaultHeight = 48
CoD.cac_lock.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.cac_lock)
	self.id = "cac_lock"
	self.soundSet = "FrontendMain"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local lockedIcon0 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	lockedIcon0:setImage(RegisterImage("uie_t7_menu_cac_iconlock"))
	self:addElement(lockedIcon0)
	self.lockedIcon0 = lockedIcon0
	local lockedIcon = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	lockedIcon:setAlpha(0.47)
	lockedIcon:setImage(RegisterImage("uie_t7_menu_cac_iconlock"))
	lockedIcon:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(lockedIcon)
	self.lockedIcon = lockedIcon
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.cac_lock.__resetProperties = function(f2_arg0)
	f2_arg0.lockedIcon:completeAnimation()
	f2_arg0.lockedIcon:setAlpha(0.47)
end
CoD.cac_lock.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.lockedIcon:completeAnimation()
			f3_arg0.lockedIcon:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.lockedIcon)
		end,
	},
}
