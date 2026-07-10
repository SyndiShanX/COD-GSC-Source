CoD.ArenaGauntletTierProgressBacking = InheritFrom(LUI.UIElement)
CoD.ArenaGauntletTierProgressBacking.__defaultWidth = 150
CoD.ArenaGauntletTierProgressBacking.__defaultHeight = 200
CoD.ArenaGauntletTierProgressBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaGauntletTierProgressBacking)
	self.id = "ArenaGauntletTierProgressBacking"
	self.soundSet = "none"
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(ColorSet.BlackMarketCommon.r, ColorSet.BlackMarketCommon.g, ColorSet.BlackMarketCommon.b)
	self:addElement(Backing)
	self.Backing = Backing
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
