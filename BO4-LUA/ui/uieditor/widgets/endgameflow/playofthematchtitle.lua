require("x64:f7470f1be342d92")
require("x64:e6cc0e76ed868e0")
CoD.PLayOfTheMatchTitle = InheritFrom(LUI.UIElement)
CoD.PLayOfTheMatchTitle.__defaultWidth = 782
CoD.PLayOfTheMatchTitle.__defaultHeight = 100
CoD.PLayOfTheMatchTitle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PLayOfTheMatchTitle)
	self.id = "PLayOfTheMatchTitle"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local KIllcamTitleBacking = CoD.KIllcam_Title.new(f1_arg0, f1_arg1, 0, 0, -16, 469, 0, 0, -12, 88)
	self:addElement(KIllcamTitleBacking)
	self.KIllcamTitleBacking = KIllcamTitleBacking
	local CODCasterMatchTitleText = CoD.CODCasterMatchTitleText.new(f1_arg0, f1_arg1, 0, 0, 61, 917, 0, 0, 6, 70)
	self:addElement(CODCasterMatchTitleText)
	self.CODCasterMatchTitleText = CODCasterMatchTitleText
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PLayOfTheMatchTitle.__resetProperties = function(f2_arg0)
	f2_arg0.CODCasterMatchTitleText:completeAnimation()
	f2_arg0.KIllcamTitleBacking:completeAnimation()
	f2_arg0.CODCasterMatchTitleText:setAlpha(1)
	f2_arg0.KIllcamTitleBacking:setAlpha(1)
end
CoD.PLayOfTheMatchTitle.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.KIllcamTitleBacking:completeAnimation()
			f3_arg0.KIllcamTitleBacking:setAlpha(1)
			f3_arg0.clipFinished(f3_arg0.KIllcamTitleBacking)
			f3_arg0.CODCasterMatchTitleText:completeAnimation()
			f3_arg0.CODCasterMatchTitleText:setAlpha(1)
			f3_arg0.clipFinished(f3_arg0.CODCasterMatchTitleText)
		end,
	},
	FinalKillcam = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.PLayOfTheMatchTitle.__onClose = function(f5_arg0)
	f5_arg0.KIllcamTitleBacking:close()
	f5_arg0.CODCasterMatchTitleText:close()
end
