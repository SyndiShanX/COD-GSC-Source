CoD.callingcards_snakegods_asset_snakehead = InheritFrom(LUI.UIElement)
CoD.callingcards_snakegods_asset_snakehead.__defaultWidth = 10
CoD.callingcards_snakegods_asset_snakehead.__defaultHeight = 10
CoD.callingcards_snakegods_asset_snakehead.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_snakegods_asset_snakehead)
	self.id = "callingcards_snakegods_asset_snakehead"
	self.soundSet = "default"
	local snakehead = LUI.UIImage.new(0, 0, -11, 205, 0, 0, -56, 56)
	snakehead:setImage(RegisterImage(0x2DA9378FBE8C0E1))
	self:addElement(snakehead)
	self.snakehead = snakehead
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
