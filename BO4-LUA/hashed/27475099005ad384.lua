require("x64:acbf06924421e35")
require("x64:19c1945d2e472b0")
CoD.DupeMeterBacker = InheritFrom(LUI.UIElement)
CoD.DupeMeterBacker.__defaultWidth = 160
CoD.DupeMeterBacker.__defaultHeight = 34
CoD.DupeMeterBacker.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DupeMeterBacker)
	self.id = "DupeMeterBacker"
	self.soundSet = "default"
	local Blur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local Box = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Box:setAlpha(0.02)
	self:addElement(Box)
	self.Box = Box
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DotTiledBacking:setAlpha(0.15)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local CommonCornerPips = CoD.CommonCornerPips01.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CommonCornerPips:setAlpha(0.5)
	self:addElement(CommonCornerPips)
	self.CommonCornerPips = CommonCornerPips
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DupeMeterBacker.__onClose = function(f2_arg0)
	f2_arg0.DotTiledBacking:close()
	f2_arg0.CommonCornerPips:close()
end
