CoD.lmgInfiniteReticle_Status = InheritFrom(LUI.UIElement)
CoD.lmgInfiniteReticle_Status.__defaultWidth = 199
CoD.lmgInfiniteReticle_Status.__defaultHeight = 33
CoD.lmgInfiniteReticle_Status.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.lmgInfiniteReticle_Status)
	self.id = "lmgInfiniteReticle_Status"
	self.soundSet = "default"
	local FrameTop = LUI.UIImage.new(0, 1, 0, 0, 0, 0, -2, 11)
	FrameTop:setImage(RegisterImage(@"uie_t7_weapon_lmg_screen_frame"))
	FrameTop:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(FrameTop)
	self.FrameTop = FrameTop
	local FrameBottom = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 22, 35)
	FrameBottom:setXRot(180)
	FrameBottom:setImage(RegisterImage(@"uie_t7_weapon_lmg_screen_frame"))
	FrameBottom:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(FrameBottom)
	self.FrameBottom = FrameBottom
	local Status = LUI.UIText.new(0, 0, 13, 183, 0, 0, 5, 28)
	Status:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5E20BF67125A4903"))
	Status:setTTF("default")
	Status:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Status:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Status)
	self.Status = Status
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
