require("x64:1f8ea4e2ff1d11b")
CoD.CodCasterLoadoutWildcard = InheritFrom(LUI.UIElement)
CoD.CodCasterLoadoutWildcard.__defaultWidth = 25
CoD.CodCasterLoadoutWildcard.__defaultHeight = 60
CoD.CodCasterLoadoutWildcard.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterLoadoutWildcard)
	self.id = "CodCasterLoadoutWildcard"
	self.soundSet = "none"
	local WildcardImage = LUI.UIImage.new(0, 0, 0, 25, 0, 0, 0, 60)
	WildcardImage:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			WildcardImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(WildcardImage)
	self.WildcardImage = WildcardImage
	local CodCasterLoadoutSelection = CoD.CodCasterLoadoutSelectionWild.new(f1_arg0, f1_arg1, 0.5, 0.5, -16, 16, 0, 0, -5, 71)
	CodCasterLoadoutSelection:setAlpha(0)
	self:addElement(CodCasterLoadoutSelection)
	self.CodCasterLoadoutSelection = CodCasterLoadoutSelection
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterLoadoutWildcard.__onClose = function(f3_arg0)
	f3_arg0.WildcardImage:close()
	f3_arg0.CodCasterLoadoutSelection:close()
end
