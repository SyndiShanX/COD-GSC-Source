CoD.WarzoneSplitInventory_PC_ButtonContainer = InheritFrom(LUI.UIElement)
CoD.WarzoneSplitInventory_PC_ButtonContainer.__defaultWidth = 50
CoD.WarzoneSplitInventory_PC_ButtonContainer.__defaultHeight = 20
CoD.WarzoneSplitInventory_PC_ButtonContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneSplitInventory_PC_ButtonContainer)
	self.id = "WarzoneSplitInventory_PC_ButtonContainer"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0.02, 0.98, 0, 0, 0.02, 0.98, 0, 0)
	Backing:setRGB(0.11, 0.11, 0.11)
	Backing:setAlpha(0.9)
	self:addElement(Backing)
	self.Backing = Backing
	local TiledBacking = LUI.UIImage.new(0.02, 0.98, 0, 0, 0.02, 0.98, 0, 0)
	TiledBacking:setAlpha(0.5)
	TiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	TiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking:setupNineSliceShader(196, 88)
	self:addElement(TiledBacking)
	self.TiledBacking = TiledBacking
	local FrameSelected = LUI.UIImage.new(0, 1, -2, 2, 0, 1, -2, 2)
	FrameSelected:setAlpha(0)
	FrameSelected:setScale(0.96, 0.96)
	FrameSelected:setImage(RegisterImage(@"uie_ui_menu_store_focus_frame"))
	FrameSelected:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrameSelected:setShaderVector(0, 0, 0, 0, 0)
	FrameSelected:setupNineSliceShader(4, 4)
	self:addElement(FrameSelected)
	self.FrameSelected = FrameSelected
	local FrontendFrame = LUI.UIImage.new(0.02, 0.98, -1, 1, 0.02, 0.98, -1, 1)
	FrontendFrame:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	FrontendFrame:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFrame:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrame)
	self.FrontendFrame = FrontendFrame
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneSplitInventory_PC_ButtonContainer.__resetProperties = function(f2_arg0)
	f2_arg0.FrameSelected:completeAnimation()
	f2_arg0.FrameSelected:setAlpha(0)
end
CoD.WarzoneSplitInventory_PC_ButtonContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.FrameSelected:completeAnimation()
			f4_arg0.FrameSelected:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.FrameSelected)
		end,
		GainFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				f5_arg0.FrameSelected:beginAnimation(140)
				f5_arg0.FrameSelected:setAlpha(1)
				f5_arg0.FrameSelected:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.FrameSelected:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.FrameSelected:completeAnimation()
			f5_arg0.FrameSelected:setAlpha(0)
			f5_local0(f5_arg0.FrameSelected)
		end,
		LoseFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.FrameSelected:beginAnimation(140)
				f7_arg0.FrameSelected:setAlpha(0)
				f7_arg0.FrameSelected:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.FrameSelected:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.FrameSelected:completeAnimation()
			f7_arg0.FrameSelected:setAlpha(1)
			f7_local0(f7_arg0.FrameSelected)
		end,
	},
	Disabled = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
}
