CoD.fail_screen = InheritFrom(CoD.Menu)
LUI.createMenu.fail_screen = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("fail_screen", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.fail_screen)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local text = LUI.UIText.new(0, 0, 349.5, 1570.5, 0, 0, 311.5, 448.5)
	text:setRGB(1, 0.35, 0.08)
	text:setText(Engine[0xF9F1239CFD921FE](0x1C454B7B06A0549))
	text:setTTF("default")
	text:setMaterial(LUI.UIImage.GetCachedMaterial(0xAE166D9BA8C6907))
	text:setShaderVector(0, 0.14, 0, 0, 0)
	text:setShaderVector(1, 0.43, 0, 0, 0)
	text:setShaderVector(2, 0.71, 0, 0, 0)
	text:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(text)
	self.text = text
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.fail_screen.__resetProperties = function(f2_arg0)
	f2_arg0.text:completeAnimation()
	f2_arg0.text:setScale(1, 1)
end
CoD.fail_screen.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				f3_arg0.text:beginAnimation(1500, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f3_arg0.text:setScale(1, 1)
				f3_arg0.text:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.text:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.text:completeAnimation()
			f3_arg0.text:setScale(0.01, 0.01)
			f3_local0(f3_arg0.text)
		end,
	},
}
CoD.fail_screen.__onClose = function(f5_arg0) end
