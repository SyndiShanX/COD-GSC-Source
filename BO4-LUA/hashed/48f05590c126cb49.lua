require("x64:a063599cd5a5103")
CoD.WarzoneSplitInventory_PC_ImageButton = InheritFrom(LUI.UIElement)
CoD.WarzoneSplitInventory_PC_ImageButton.__defaultWidth = 50
CoD.WarzoneSplitInventory_PC_ImageButton.__defaultHeight = 24
CoD.WarzoneSplitInventory_PC_ImageButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneSplitInventory_PC_ImageButton)
	self.id = "WarzoneSplitInventory_PC_ImageButton"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Container = CoD.WarzoneSplitInventory_PC_ButtonContainer.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Container:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsSelfInState(self, "Disabled")
			end,
		},
	})
	self:addElement(Container)
	self.Container = Container
	local Image = LUI.UIImage.new(0.5, 0.5, -10, 10, 0.5, 0.5, -10, 10)
	Image:setRGB(0.93, 0.91, 0.81)
	Image:setImage(RegisterImage(@"uie_ui_menu_common_add_plus"))
	self:addElement(Image)
	self.Image = Image
	local add = LUI.UIImage.new(0.5, 0.5, -10, 10, 0.5, 0.5, -10, 10)
	add:setRGB(0.93, 0.91, 0.81)
	add:setAlpha(0)
	add:setImage(RegisterImage(@"uie_ui_menu_common_add_plus"))
	add:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(add)
	self.add = add
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f3_arg2, f3_arg3, f3_arg4)
		UpdateElementState(self, "Container", controller)
	end)
	Container.id = "Container"
	self.__defaultFocus = Container
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneSplitInventory_PC_ImageButton.__resetProperties = function(f4_arg0)
	f4_arg0.add:completeAnimation()
	f4_arg0.Image:completeAnimation()
	f4_arg0.Container:completeAnimation()
	f4_arg0.add:setAlpha(0)
	f4_arg0.Image:setRGB(0.93, 0.91, 0.81)
	f4_arg0.Container:setRGB(1, 1, 1)
end
CoD.WarzoneSplitInventory_PC_ImageButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.add:completeAnimation()
			f6_arg0.add:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.add)
		end,
		GainChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.add:beginAnimation(140)
				f7_arg0.add:setAlpha(1)
				f7_arg0.add:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.add:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.add:completeAnimation()
			f7_arg0.add:setAlpha(0)
			f7_local0(f7_arg0.add)
		end,
		LoseChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.add:beginAnimation(140)
				f9_arg0.add:setAlpha(0)
				f9_arg0.add:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.add:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.add:completeAnimation()
			f9_arg0.add:setAlpha(1)
			f9_local0(f9_arg0.add)
		end,
	},
	Disabled = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.Container:completeAnimation()
			f11_arg0.Container:setRGB(0.73, 0.73, 0.73)
			f11_arg0.clipFinished(f11_arg0.Container)
			f11_arg0.Image:completeAnimation()
			f11_arg0.Image:setRGB(0.55, 0.54, 0.49)
			f11_arg0.clipFinished(f11_arg0.Image)
		end,
	},
}
CoD.WarzoneSplitInventory_PC_ImageButton.__onClose = function(f12_arg0)
	f12_arg0.Container:close()
end
