CoD.WarzoneInventoryLineArrow = InheritFrom(LUI.UIElement)
CoD.WarzoneInventoryLineArrow.__defaultWidth = 44
CoD.WarzoneInventoryLineArrow.__defaultHeight = 28
CoD.WarzoneInventoryLineArrow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneInventoryLineArrow)
	self.id = "WarzoneInventoryLineArrow"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Pointer = LUI.UIImage.new(0, 0, 0, 44, 0, 0, 0, 28)
	Pointer:setRGB(0, 0, 0)
	Pointer:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_qe_pointer"))
	self:addElement(Pointer)
	self.Pointer = Pointer
	local Pointer2 = LUI.UIImage.new(0, 0, 0, 44, 0, 0, 0, 28)
	Pointer2:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_qe_pointer_lit"))
	Pointer2:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Pointer2)
	self.Pointer2 = Pointer2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneInventoryLineArrow.__resetProperties = function(f2_arg0)
	f2_arg0.Pointer2:completeAnimation()
	f2_arg0.Pointer:completeAnimation()
	f2_arg0.Pointer2:setAlpha(1)
	f2_arg0.Pointer:setAlpha(1)
end
CoD.WarzoneInventoryLineArrow.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.Pointer:completeAnimation()
			f3_arg0.Pointer:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.Pointer)
			f3_arg0.Pointer2:completeAnimation()
			f3_arg0.Pointer2:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.Pointer2)
		end,
	},
	Visible = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
}
