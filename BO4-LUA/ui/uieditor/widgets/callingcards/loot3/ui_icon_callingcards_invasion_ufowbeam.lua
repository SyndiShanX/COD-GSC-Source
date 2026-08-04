require("ui/uieditor/widgets/callingcards/loot3/ui_icon_callingcards_invasion_beam")
require("ui/uieditor/widgets/callingcards/loot3/ui_icon_callingcards_invasion_lamb3")
CoD.ui_icon_callingcards_invasion_ufowbeam = InheritFrom(LUI.UIElement)
CoD.ui_icon_callingcards_invasion_ufowbeam.__defaultWidth = 224
CoD.ui_icon_callingcards_invasion_ufowbeam.__defaultHeight = 88
CoD.ui_icon_callingcards_invasion_ufowbeam.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ui_icon_callingcards_invasion_ufowbeam)
	self.id = "ui_icon_callingcards_invasion_ufowbeam"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ufo = LUI.UIImage.new(0, 0, 0, 224, 0, 0, 0, 88)
	ufo:setImage(RegisterImage("uie_ui_menu_callingcards_invasion_ufo"))
	self:addElement(ufo)
	self.ufo = ufo
	local beam = CoD.ui_icon_callingcards_invasion_beam.new(f1_arg0, f1_arg1, 0, 0, 64.5, 144.5, 0, 0, 49, 193)
	self:addElement(beam)
	self.beam = beam
	local lamb3 = CoD.ui_icon_callingcards_invasion_lamb3.new(f1_arg0, f1_arg1, 0, 0, 80.5, 128.5, 0, 0, 105, 153)
	self:addElement(lamb3)
	self.lamb3 = lamb3
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ui_icon_callingcards_invasion_ufowbeam.__resetProperties = function(f2_arg0)
	f2_arg0.beam:completeAnimation()
	f2_arg0.lamb3:completeAnimation()
end
CoD.ui_icon_callingcards_invasion_ufowbeam.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.beam:completeAnimation()
			f3_arg0.beam:playClip("DefaultClip")
			f3_arg0.clipFinished(f3_arg0.beam)
			f3_arg0.lamb3:completeAnimation()
			f3_arg0.lamb3:playClip("DefaultClip")
			f3_arg0.clipFinished(f3_arg0.lamb3)
		end,
	},
}
CoD.ui_icon_callingcards_invasion_ufowbeam.__onClose = function(f4_arg0)
	f4_arg0.beam:close()
	f4_arg0.lamb3:close()
end
