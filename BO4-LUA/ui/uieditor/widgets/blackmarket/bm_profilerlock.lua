require("x64:94acc3cb318e13b")
require("x64:8361a8d6fe55653")
CoD.BM_ProfilerLock = InheritFrom(LUI.UIElement)
CoD.BM_ProfilerLock.__defaultWidth = 52
CoD.BM_ProfilerLock.__defaultHeight = 45
CoD.BM_ProfilerLock.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BM_ProfilerLock)
	self.id = "BM_ProfilerLock"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local PixelGridTiledBacking = CoD.Challenges_ProfilerLockBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(PixelGridTiledBacking)
	self.PixelGridTiledBacking = PixelGridTiledBacking
	local LockedIcon = CoD.BM_Lock.new(f1_arg0, f1_arg1, 0.5, 0.5, -18, 18, 0.5, 0.5, -18, 18)
	self:addElement(LockedIcon)
	self.LockedIcon = LockedIcon
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BM_ProfilerLock.__onClose = function(f2_arg0)
	f2_arg0.PixelGridTiledBacking:close()
	f2_arg0.LockedIcon:close()
end
