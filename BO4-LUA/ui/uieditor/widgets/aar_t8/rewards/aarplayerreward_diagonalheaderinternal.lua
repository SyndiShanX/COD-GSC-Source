CoD.AARPlayerReward_DiagonalHeaderInternal = InheritFrom(LUI.UIElement)
CoD.AARPlayerReward_DiagonalHeaderInternal.__defaultWidth = 300
CoD.AARPlayerReward_DiagonalHeaderInternal.__defaultHeight = 8
CoD.AARPlayerReward_DiagonalHeaderInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARPlayerReward_DiagonalHeaderInternal)
	self.id = "AARPlayerReward_DiagonalHeaderInternal"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NineSliceShaderImage = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0.5, 7.5)
	NineSliceShaderImage:setAlpha(0.2)
	NineSliceShaderImage:setImage(RegisterImage(@"hash_7C995977EE51C6E2"))
	NineSliceShaderImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	NineSliceShaderImage:setShaderVector(0, 0, 0, 0, 0)
	NineSliceShaderImage:setupNineSliceShader(3, 3)
	self:addElement(NineSliceShaderImage)
	self.NineSliceShaderImage = NineSliceShaderImage
	local TopStripeDiagonal = LUI.UIImage.new(-0, 1, 0, 0, 0, 0, 0, 8)
	TopStripeDiagonal:setRGB(0, 0, 0)
	TopStripeDiagonal:setImage(RegisterImage(@"uie_ui_menu_inspection_window_loading_stripe"))
	TopStripeDiagonal:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll_normal"))
	TopStripeDiagonal:setShaderVector(0, 1, 1, 0, 0)
	TopStripeDiagonal:setShaderVector(1, 0, 0, 0, 0)
	self:addElement(TopStripeDiagonal)
	self.TopStripeDiagonal = TopStripeDiagonal
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARPlayerReward_DiagonalHeaderInternal.__resetProperties = function(f2_arg0)
	f2_arg0.NineSliceShaderImage:completeAnimation()
	f2_arg0.NineSliceShaderImage:setAlpha(0.2)
end
CoD.AARPlayerReward_DiagonalHeaderInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_both"])
					f5_arg0:setAlpha(0.2)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.NineSliceShaderImage:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_both"])
				f3_arg0.NineSliceShaderImage:setAlpha(0.1)
				f3_arg0.NineSliceShaderImage:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.NineSliceShaderImage:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.NineSliceShaderImage:completeAnimation()
			f3_arg0.NineSliceShaderImage:setAlpha(0.2)
			f3_local0(f3_arg0.NineSliceShaderImage)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
