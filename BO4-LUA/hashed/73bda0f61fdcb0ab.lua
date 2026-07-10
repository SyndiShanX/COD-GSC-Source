CoD.ZMConsumableItemCountInGame = InheritFrom(LUI.UIElement)
CoD.ZMConsumableItemCountInGame.__defaultWidth = 76
CoD.ZMConsumableItemCountInGame.__defaultHeight = 80
CoD.ZMConsumableItemCountInGame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMConsumableItemCountInGame)
	self.id = "ZMConsumableItemCountInGame"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	bg:setImage(RegisterImage(0x6E5BECCF89F9216))
	self:addElement(bg)
	self.bg = bg
	local Count = LUI.UIText.new(0.1, 0.9, 0, 0, 0.25, 0.75, 0, 0)
	Count:setText(888)
	Count:setTTF("skorzhen")
	Count:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	Count:setLetterSpacing(1)
	Count:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Count:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Count)
	self.Count = Count
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMConsumableItemCountInGame.__resetProperties = function(f2_arg0)
	f2_arg0.Count:completeAnimation()
	f2_arg0.bg:completeAnimation()
	f2_arg0.Count:setAlpha(1)
	f2_arg0.bg:setAlpha(1)
end
CoD.ZMConsumableItemCountInGame.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.bg:completeAnimation()
			f4_arg0.bg:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.bg)
			f4_arg0.Count:completeAnimation()
			f4_arg0.Count:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Count)
		end,
	},
	Spectator = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.bg:completeAnimation()
			f5_arg0.bg:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.bg)
			f5_arg0.Count:completeAnimation()
			f5_arg0.Count:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Count)
		end,
	},
}
