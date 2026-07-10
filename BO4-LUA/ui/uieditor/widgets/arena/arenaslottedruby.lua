CoD.ArenaSlottedRuby = InheritFrom(LUI.UIElement)
CoD.ArenaSlottedRuby.__defaultWidth = 40
CoD.ArenaSlottedRuby.__defaultHeight = 40
CoD.ArenaSlottedRuby.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaSlottedRuby)
	self.id = "ArenaSlottedRuby"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local RubySlot = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	RubySlot:setImage(RegisterImage(0x81EAB9F8F5950E7))
	self:addElement(RubySlot)
	self.RubySlot = RubySlot
	local Ruby = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Ruby:setImage(RegisterImage(0x17ED8E3A9A3FC36))
	self:addElement(Ruby)
	self.Ruby = Ruby
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaSlottedRuby.__resetProperties = function(f2_arg0)
	f2_arg0.Ruby:completeAnimation()
	f2_arg0.RubySlot:completeAnimation()
	f2_arg0.Ruby:setAlpha(1)
	f2_arg0.RubySlot:setAlpha(1)
end
CoD.ArenaSlottedRuby.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.RubySlot:completeAnimation()
			f3_arg0.RubySlot:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.RubySlot)
			f3_arg0.Ruby:completeAnimation()
			f3_arg0.Ruby:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.Ruby)
		end,
	},
	Filled = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.RubySlot:completeAnimation()
			f4_arg0.RubySlot:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.RubySlot)
			f4_arg0.Ruby:completeAnimation()
			f4_arg0.Ruby:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.Ruby)
		end,
	},
	Empty = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Ruby:completeAnimation()
			f5_arg0.Ruby:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Ruby)
		end,
	},
}
