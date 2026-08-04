require("ui/uieditor/widgets/cac/newbreadcrumb")
CoD.NewBreadcrumbCount = InheritFrom(LUI.UIElement)
CoD.NewBreadcrumbCount.__defaultWidth = 27
CoD.NewBreadcrumbCount.__defaultHeight = 27
CoD.NewBreadcrumbCount.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.NewBreadcrumbCount)
	self.id = "NewBreadcrumbCount"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local breadcrumb = CoD.NewBreadcrumb.new(f1_arg0, f1_arg1, 0.5, 0.5, -13.5, 13.5, 0.5, 0.5, -13.5, 13.5)
	self:addElement(breadcrumb)
	self.breadcrumb = breadcrumb
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.NewBreadcrumbCount.__resetProperties = function(f2_arg0)
	f2_arg0.breadcrumb:completeAnimation()
	f2_arg0.breadcrumb:setAlpha(1)
end
CoD.NewBreadcrumbCount.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.breadcrumb:completeAnimation()
			f3_arg0.breadcrumb:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.breadcrumb)
		end,
	},
	Visible = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			local f4_local0 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					f6_arg0:beginAnimation(150)
					f6_arg0:setAlpha(1)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
				end
				f4_arg0.breadcrumb:beginAnimation(50)
				f4_arg0.breadcrumb:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.breadcrumb:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f4_arg0.breadcrumb:completeAnimation()
			f4_arg0.breadcrumb:setAlpha(0)
			f4_local0(f4_arg0.breadcrumb)
		end,
	},
}
CoD.NewBreadcrumbCount.__onClose = function(f7_arg0)
	f7_arg0.breadcrumb:close()
end
