require("x64:568c2d667b47916")
CoD.cac_IconTokenGrid = InheritFrom(LUI.UIElement)
CoD.cac_IconTokenGrid.__defaultWidth = 42
CoD.cac_IconTokenGrid.__defaultHeight = 42
CoD.cac_IconTokenGrid.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.cac_IconTokenGrid)
	self.id = "cac_IconTokenGrid"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local cacIconTokenStatic0 = CoD.cac_IconTokenStatic.new(f1_arg0, f1_arg1, 0, 0, 0, 42, 0, 0, 0, 42)
	self:addElement(cacIconTokenStatic0)
	self.cacIconTokenStatic0 = cacIconTokenStatic0
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.cac_IconTokenGrid.__resetProperties = function(f2_arg0)
	f2_arg0.cacIconTokenStatic0:completeAnimation()
	f2_arg0.cacIconTokenStatic0:setAlpha(1)
end
CoD.cac_IconTokenGrid.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.cacIconTokenStatic0:completeAnimation()
			f3_arg0.cacIconTokenStatic0:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.cacIconTokenStatic0)
		end,
	},
	Visible = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.cac_IconTokenGrid.__onClose = function(f5_arg0)
	f5_arg0.cacIconTokenStatic0:close()
end
