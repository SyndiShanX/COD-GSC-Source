CoD.AtviCopy = InheritFrom(LUI.UIElement)
CoD.AtviCopy.__defaultWidth = 1920
CoD.AtviCopy.__defaultHeight = 1080
CoD.AtviCopy.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AtviCopy)
	self.id = "AtviCopy"
	self.soundSet = "FrontendMain"
	local ActivisionIncDurango = LUI.UIImage.new(1, 1, -291, -15, 0, 0, 45, 87)
	ActivisionIncDurango:setRGB(0.31, 0.34, 0.37)
	ActivisionIncDurango:setAlpha(0.9)
	ActivisionIncDurango:setImage(RegisterImage(@"hash_4F52811A5826066C"))
	self:addElement(ActivisionIncDurango)
	self.ActivisionIncDurango = ActivisionIncDurango
	local BuildInfo2 = LUI.UIText.new(1, 1, -215, -15, 0, 0, 76, 90)
	BuildInfo2:setRGB(0.31, 0.34, 0.37)
	BuildInfo2:setAlpha(0.7)
	BuildInfo2:setTTF("0arame_mono_stencil")
	BuildInfo2:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	BuildInfo2:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	BuildInfo2:linkToElementModel(self, "buildInfo", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			BuildInfo2:setText(f2_local0)
		end
	end)
	self:addElement(BuildInfo2)
	self.BuildInfo2 = BuildInfo2
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local3 = self
	SetModelToGlobalDataSource(f1_arg1, self, "GlobalModel")
	return self
end
CoD.AtviCopy.__onClose = function(f3_arg0)
	f3_arg0.BuildInfo2:close()
end
