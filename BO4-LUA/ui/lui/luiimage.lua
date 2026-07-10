LUI.UIImage = InheritFrom(LUI.UIElement)
LUI.UIImage.Materials = {}
LUI.UIImage.DefaultImage = RegisterImage("$white")
LUI.UIImage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7)
	local self = LUI.UIElement.new(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7)
	self:setClass(LUI.UIImage)
	self:setupUIImage()
	return self
end
LUI.UIImage.GetCachedMaterial = function(f2_arg0)
	local f2_local0 = LUI.UIImage.Materials[f2_arg0]
	if f2_local0 == nil then
		f2_local0 = RegisterMaterial(f2_arg0)
		LUI.UIImage.Materials[f2_arg0] = f2_local0
	end
	return f2_local0
end
LUI.UIImage.id = "LUIImage"
