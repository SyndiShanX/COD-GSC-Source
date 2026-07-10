require("x64:2675595fa323085")
CoD.WarzoneContextualExtraItemsArrow = InheritFrom(LUI.UIElement)
CoD.WarzoneContextualExtraItemsArrow.__defaultWidth = 32
CoD.WarzoneContextualExtraItemsArrow.__defaultHeight = 32
CoD.WarzoneContextualExtraItemsArrow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneContextualExtraItemsArrow)
	self.id = "WarzoneContextualExtraItemsArrow"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local emptyFocusable = nil
	emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, -1.25, 2.25, 0, 0, -0.75, 1.75, 0, 0)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local Arrow = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Arrow:setZRot(90)
	Arrow:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_qe_pointer"))
	self:addElement(Arrow)
	self.Arrow = Arrow
	local Arrow2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Arrow2:setZRot(90)
	Arrow2:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_qe_pointer"))
	self:addElement(Arrow2)
	self.Arrow2 = Arrow2
	if CoD.isPC then
		emptyFocusable.id = "emptyFocusable"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneContextualExtraItemsArrow.__resetProperties = function(f2_arg0)
	f2_arg0.Arrow2:completeAnimation()
	f2_arg0.Arrow:completeAnimation()
	f2_arg0.Arrow2:setAlpha(1)
	f2_arg0.Arrow2:setScale(1, 1)
	f2_arg0.Arrow:setAlpha(1)
	f2_arg0.Arrow:setScale(1, 1)
end
CoD.WarzoneContextualExtraItemsArrow.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.Arrow:completeAnimation()
			f3_arg0.Arrow:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.Arrow)
			f3_arg0.Arrow2:completeAnimation()
			f3_arg0.Arrow2:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.Arrow2)
		end,
	},
	Visible = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			local f5_local0 = function(f6_arg0)
				f5_arg0.Arrow:beginAnimation(200)
				f5_arg0.Arrow:setScale(1.2, 1.2)
				f5_arg0.Arrow:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Arrow:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.Arrow:completeAnimation()
			f5_arg0.Arrow:setScale(1, 1)
			f5_local0(f5_arg0.Arrow)
			local f5_local1 = function(f7_arg0)
				f5_arg0.Arrow2:beginAnimation(200)
				f5_arg0.Arrow2:setScale(1.2, 1.2)
				f5_arg0.Arrow2:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Arrow2:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.Arrow2:completeAnimation()
			f5_arg0.Arrow2:setScale(1, 1)
			f5_local1(f5_arg0.Arrow2)
		end,
	},
}
if not CoD.isPC then
	CoD.WarzoneContextualExtraItemsArrow.__clipsPerState.Visible.ChildFocus = nil
end
CoD.WarzoneContextualExtraItemsArrow.__onClose = function(f8_arg0)
	f8_arg0.emptyFocusable:close()
end
