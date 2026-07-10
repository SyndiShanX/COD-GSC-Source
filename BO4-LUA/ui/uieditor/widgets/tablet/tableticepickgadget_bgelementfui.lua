require("x64:c7393046816f760")
CoD.TabletIcePickGadget_BgElementFui = InheritFrom(LUI.UIElement)
CoD.TabletIcePickGadget_BgElementFui.__defaultWidth = 120
CoD.TabletIcePickGadget_BgElementFui.__defaultHeight = 72
CoD.TabletIcePickGadget_BgElementFui.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabletIcePickGadget_BgElementFui)
	self.id = "TabletIcePickGadget_BgElementFui"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SquareOthers = CoD.AARLevelCommonBoxes.new(f1_arg0, f1_arg1, 0, 0, 36, 84, 0, 0, 50, 63)
	SquareOthers:setRGB(0, 1, 0.92)
	SquareOthers:setAlpha(0.5)
	self:addElement(SquareOthers)
	self.SquareOthers = SquareOthers
	local FuiR01 = LUI.UIImage.new(0, 0, 0, 120, 0, 0, 0, 72)
	FuiR01:setAlpha(0.5)
	FuiR01:setImage(RegisterImage(@"hash_7ED037F889559729"))
	FuiR01:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	FuiR01:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FuiR01)
	self.FuiR01 = FuiR01
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabletIcePickGadget_BgElementFui.__resetProperties = function(f2_arg0)
	f2_arg0.FuiR01:completeAnimation()
	f2_arg0.FuiR01:setAlpha(0.5)
end
CoD.TabletIcePickGadget_BgElementFui.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(2000)
					f5_arg0:setAlpha(0.2)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.FuiR01:beginAnimation(2000)
				f3_arg0.FuiR01:setAlpha(0.6)
				f3_arg0.FuiR01:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.FuiR01:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.FuiR01:completeAnimation()
			f3_arg0.FuiR01:setAlpha(0.2)
			f3_local0(f3_arg0.FuiR01)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.TabletIcePickGadget_BgElementFui.__onClose = function(f6_arg0)
	f6_arg0.SquareOthers:close()
end
