CoD.VerticalListSpacer = InheritFrom(LUI.UIElement)
CoD.VerticalListSpacer.__defaultWidth = 750
CoD.VerticalListSpacer.__defaultHeight = 51
CoD.VerticalListSpacer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VerticalListSpacer)
	self.id = "VerticalListSpacer"
	self.soundSet = "ChooseDecal"
	self:linkToElementModel(self, "height", true, function(model)
		local f2_local0 = self
		SetVerticaListSpacerHeight(self, model)
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
