CoD.PC_Achievement_CompletedTick = InheritFrom(LUI.UIElement)
CoD.PC_Achievement_CompletedTick.__defaultWidth = 20
CoD.PC_Achievement_CompletedTick.__defaultHeight = 40
CoD.PC_Achievement_CompletedTick.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Achievement_CompletedTick)
	self.id = "PC_Achievement_CompletedTick"
	self.soundSet = "default"
	local BGGoldFlat = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGGoldFlat:setRGB(0.86, 0.74, 0.25)
	self:addElement(BGGoldFlat)
	self.BGGoldFlat = BGGoldFlat
	local BG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BG:setRGB(0.31, 0.13, 0.01)
	self:addElement(BG)
	self.BG = BG
	local TabBackingGlow = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TabBackingGlow:setZRot(90)
	TabBackingGlow:setScale(3, 4)
	TabBackingGlow:setImage(RegisterImage(0x223AD1B40A93955))
	TabBackingGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	TabBackingGlow:setShaderVector(0, 1.36, 0, 0, 0)
	self:addElement(TabBackingGlow)
	self.TabBackingGlow = TabBackingGlow
	local TabBacking = LUI.UIImage.new(-0.25, 1.25, 0, 0, -0.75, 1.75, 0, 0)
	TabBacking:setAlpha(0.7)
	TabBacking:setYRot(9)
	TabBacking:setImage(RegisterImage(0x3F09D20CA138B49))
	TabBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	TabBacking:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(TabBacking)
	self.TabBacking = TabBacking
	local CheckmarkIcon = LUI.UIImage.new(0.5, 0.5, -13, 13, 0.5, 0.5, -13, 13)
	CheckmarkIcon:setRGB(0, 0, 0)
	CheckmarkIcon:setImage(RegisterImage(0xF82DBBC93FD9A06))
	self:addElement(CheckmarkIcon)
	self.CheckmarkIcon = CheckmarkIcon
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
