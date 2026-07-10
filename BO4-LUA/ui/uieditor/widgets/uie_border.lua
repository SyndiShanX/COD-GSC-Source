CoD.uie_Border = InheritFrom(LUI.UIElement)
CoD.uie_Border.__defaultWidth = 686
CoD.uie_Border.__defaultHeight = 56
CoD.uie_Border.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.uie_Border)
	self.id = "uie_Border"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local right = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	right:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	right:setImage(RegisterImage(@"uie_ui_menu_mp_scoreboard_list_indicator_bg"))
	self:addElement(right)
	self.right = right
	local right2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	right2:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	right2:setImage(RegisterImage(@"uie_ui_menu_mp_scoreboard_list_indicator_bg"))
	right2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	right2:setShaderVector(0, 3, 0, 0, 0)
	self:addElement(right2)
	self.right2 = right2
	local rightPC = nil
	rightPC = LUI.UIImage.new(0, 0, 0, 686, 0, 1, 0, 0)
	rightPC:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	rightPC:setAlpha(0)
	rightPC:setImage(RegisterImage(@"hash_6B7CDF731D0F3F6"))
	self:addElement(rightPC)
	self.rightPC = rightPC
	local right2PC = nil
	right2PC = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	right2PC:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	right2PC:setAlpha(0)
	right2PC:setImage(RegisterImage(@"hash_6B7CDF731D0F3F6"))
	right2PC:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	right2PC:setShaderVector(0, 5, 0, 0, 0)
	self:addElement(right2PC)
	self.right2PC = right2PC
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.uie_Border.__resetProperties = function(f3_arg0)
	f3_arg0.rightPC:completeAnimation()
	f3_arg0.right2PC:completeAnimation()
	f3_arg0.right2:completeAnimation()
	f3_arg0.right:completeAnimation()
	f3_arg0.rightPC:setLeftRight(0, 0, 0, 686)
	f3_arg0.rightPC:setAlpha(0)
	f3_arg0.right2PC:setLeftRight(0, 1, 0, 0)
	f3_arg0.right2PC:setAlpha(0)
	f3_arg0.right2PC:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	f3_arg0.right2PC:setShaderVector(0, 5, 0, 0, 0)
	f3_arg0.right2:setAlpha(1)
	f3_arg0.right:setAlpha(1)
end
CoD.uie_Border.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	PC = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(4)
			f5_arg0.right:completeAnimation()
			f5_arg0.right:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.right)
			f5_arg0.right2:completeAnimation()
			f5_arg0.right2:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.right2)
			f5_arg0.rightPC:completeAnimation()
			f5_arg0.rightPC:setLeftRight(0, 0, -1, 685)
			f5_arg0.rightPC:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.rightPC)
			f5_arg0.right2PC:completeAnimation()
			f5_arg0.right2PC:setLeftRight(0, 1, -1, -1)
			f5_arg0.right2PC:setAlpha(0.05)
			f5_arg0.right2PC:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
			f5_arg0.right2PC:setShaderVector(0, 10, 0, 0, 0)
			f5_arg0.clipFinished(f5_arg0.right2PC)
		end,
	},
}
