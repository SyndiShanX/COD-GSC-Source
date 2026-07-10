CoD.DoubleLoot = InheritFrom(LUI.UIElement)
CoD.DoubleLoot.__defaultWidth = 120
CoD.DoubleLoot.__defaultHeight = 120
CoD.DoubleLoot.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DoubleLoot)
	self.id = "DoubleLoot"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local cryptokeyBack = LUI.UIImage.new(0.5, 0.5, -58, 62, 0, 0, 3, 123)
	cryptokeyBack:setImage(RegisterImage(0x2F4FC7FBD0C778C))
	self:addElement(cryptokeyBack)
	self.cryptokeyBack = cryptokeyBack
	self:mergeStateConditions({
		{
			stateName = "DoubleLoot",
			condition = function(menu, element, event)
				return IsDoubleLootXP(f1_arg1)
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DoubleLoot.__resetProperties = function(f3_arg0)
	f3_arg0.cryptokeyBack:completeAnimation()
	f3_arg0.cryptokeyBack:setAlpha(1)
end
CoD.DoubleLoot.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.cryptokeyBack:completeAnimation()
			f4_arg0.cryptokeyBack:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.cryptokeyBack)
		end,
	},
	DoubleLoot = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
}
