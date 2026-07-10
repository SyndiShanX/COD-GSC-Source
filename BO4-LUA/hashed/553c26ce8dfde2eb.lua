require("x64:a063599cd5a5103")
CoD.WarzoneSplitInventory_PC_TextButton = InheritFrom(LUI.UIElement)
CoD.WarzoneSplitInventory_PC_TextButton.__defaultWidth = 100
CoD.WarzoneSplitInventory_PC_TextButton.__defaultHeight = 35
CoD.WarzoneSplitInventory_PC_TextButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneSplitInventory_PC_TextButton)
	self.id = "WarzoneSplitInventory_PC_TextButton"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Container = CoD.WarzoneSplitInventory_PC_ButtonContainer.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Container)
	self.Container = Container
	local Label = LUI.UIText.new(0.05, 0.95, 0, 0, 0.5, 0.5, -10, 10)
	Label:setRGB(0.55, 0.54, 0.49)
	Label:setAlpha(0.9)
	Label:setText(LocalizeToUpperString(@"hash_67D14DF1D6CBE990"))
	Label:setTTF("ttmussels_regular")
	Label:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Label:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(Label)
	self.Label = Label
	Container.id = "Container"
	self.__defaultFocus = Container
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneSplitInventory_PC_TextButton.__resetProperties = function(f2_arg0)
	f2_arg0.Label:completeAnimation()
	f2_arg0.Label:setRGB(0.55, 0.54, 0.49)
	f2_arg0.Label:setAlpha(0.9)
end
CoD.WarzoneSplitInventory_PC_TextButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Label:completeAnimation()
			f4_arg0.Label:setRGB(0.93, 0.91, 0.81)
			f4_arg0.Label:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.Label)
		end,
		GainChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				f5_arg0.Label:beginAnimation(140)
				f5_arg0.Label:setRGB(0.93, 0.91, 0.81)
				f5_arg0.Label:setAlpha(1)
				f5_arg0.Label:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Label:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.Label:completeAnimation()
			f5_arg0.Label:setRGB(0.55, 0.54, 0.49)
			f5_arg0.Label:setAlpha(0.9)
			f5_local0(f5_arg0.Label)
		end,
		LoseChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.Label:beginAnimation(140)
				f7_arg0.Label:setRGB(0.55, 0.54, 0.49)
				f7_arg0.Label:setAlpha(0.9)
				f7_arg0.Label:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Label:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.Label:completeAnimation()
			f7_arg0.Label:setRGB(0.93, 0.91, 0.81)
			f7_arg0.Label:setAlpha(1)
			f7_local0(f7_arg0.Label)
		end,
	},
}
CoD.WarzoneSplitInventory_PC_TextButton.__onClose = function(f9_arg0)
	f9_arg0.Container:close()
end
