CoD.QuarterMasterTab_CaseBreadcrumb = InheritFrom(LUI.UIElement)
CoD.QuarterMasterTab_CaseBreadcrumb.__defaultWidth = 36
CoD.QuarterMasterTab_CaseBreadcrumb.__defaultHeight = 18
CoD.QuarterMasterTab_CaseBreadcrumb.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "updateLootCaseBreadcrumb", nil)
	self:setClass(CoD.QuarterMasterTab_CaseBreadcrumb)
	self.id = "QuarterMasterTab_CaseBreadcrumb"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image:setImage(RegisterImage(0xF47F2A53FD6CD6E))
	self:addElement(Image)
	self.Image = Image
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.QuarterMasterTab_CaseBreadcrumb.__resetProperties = function(f2_arg0)
	f2_arg0.Image:completeAnimation()
	f2_arg0.Image:setAlpha(1)
end
CoD.QuarterMasterTab_CaseBreadcrumb.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.Image:completeAnimation()
			f3_arg0.Image:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.Image)
		end,
	},
	Visible = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
}
