CoD.ui_icon_callingcards_fairytales_flame1 = InheritFrom(LUI.UIElement)
CoD.ui_icon_callingcards_fairytales_flame1.__defaultWidth = 20
CoD.ui_icon_callingcards_fairytales_flame1.__defaultHeight = 20
CoD.ui_icon_callingcards_fairytales_flame1.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ui_icon_callingcards_fairytales_flame1)
	self.id = "ui_icon_callingcards_fairytales_flame1"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local fire = LUI.UIImage.new(0, 0, -220, 20, 0, 0, -92, 84)
	fire:setImage(RegisterImage(@"uie_ui_icon_callingcards_fairytale_fire"))
	fire:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(fire)
	self.fire = fire
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ui_icon_callingcards_fairytales_flame1.__resetProperties = function(f2_arg0)
	f2_arg0.fire:completeAnimation()
	f2_arg0.fire:setScale(1, 1)
end
CoD.ui_icon_callingcards_fairytales_flame1.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.fire:completeAnimation()
			f3_arg0.fire:setScale(1, 1)
			f3_arg0.clipFinished(f3_arg0.fire)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
