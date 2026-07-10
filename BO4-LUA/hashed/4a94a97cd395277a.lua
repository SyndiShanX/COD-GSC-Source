CoD.ZombiesPortrait = InheritFrom(LUI.UIElement)
CoD.ZombiesPortrait.__defaultWidth = 150
CoD.ZombiesPortrait.__defaultHeight = 150
CoD.ZombiesPortrait.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZombiesPortrait)
	self.id = "ZombiesPortrait"
	self.soundSet = "default"
	local Portrait = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Portrait:setImage(RegisterImage(@"ui_icon_hero_portrait_draft_stanton"))
	Portrait:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1A02C44161370F6D"))
	Portrait:setShaderVector(0, 0, 0, 0, 0)
	Portrait:setShaderVector(1, 1, 1, 0, 0)
	Portrait:setShaderVector(2, 0.2, 0, 0, 0)
	self:addElement(Portrait)
	self.Portrait = Portrait
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
