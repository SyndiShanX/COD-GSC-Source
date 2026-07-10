require("x64:f13acb26eff999c")
CoD.ui_icon_callingcards_dystopian_armmove = InheritFrom(LUI.UIElement)
CoD.ui_icon_callingcards_dystopian_armmove.__defaultWidth = 10
CoD.ui_icon_callingcards_dystopian_armmove.__defaultHeight = 10
CoD.ui_icon_callingcards_dystopian_armmove.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ui_icon_callingcards_dystopian_armmove)
	self.id = "ui_icon_callingcards_dystopian_armmove"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local arm = CoD.ui_icon_callingcards_dystopian_armglow.new(f1_arg0, f1_arg1, 0, 0, 0, 352, 0, 0, 0, 176)
	self:addElement(arm)
	self.arm = arm
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ui_icon_callingcards_dystopian_armmove.__resetProperties = function(f2_arg0)
	f2_arg0.arm:completeAnimation()
	f2_arg0.arm:setLeftRight(0, 0, 0, 352)
	f2_arg0.arm:setTopBottom(0, 0, 0, 176)
end
CoD.ui_icon_callingcards_dystopian_armmove.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.arm:completeAnimation()
			f3_arg0.arm:setLeftRight(0, 0, -327, 25)
			f3_arg0.arm:setTopBottom(0, 0, -67, 109)
			f3_arg0.arm:playClip("DefaultClip")
			f3_arg0.clipFinished(f3_arg0.arm)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.ui_icon_callingcards_dystopian_armmove.__onClose = function(f4_arg0)
	f4_arg0.arm:close()
end
