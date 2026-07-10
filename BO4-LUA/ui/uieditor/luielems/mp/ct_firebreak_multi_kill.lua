CoD.ct_firebreak_multi_kill = InheritFrom(CoD.Menu)
LUI.createMenu.ct_firebreak_multi_kill = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("ct_firebreak_multi_kill", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.ct_firebreak_multi_kill)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local TextBox = LUI.UIText.new(0.5, 0.5, -960, 960, 0.5, 0.5, -320, -275)
	TextBox:setRGB(0, 1, 0)
	TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_543A5A1C6EED9669"))
	TextBox:setTTF("ttmussels_regular")
	TextBox:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TextBox:setBackingType(2)
	TextBox:setBackingColor(0, 0, 0)
	self:addElement(TextBox)
	self.TextBox = TextBox
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
CoD.ct_firebreak_multi_kill.__resetProperties = function(f2_arg0)
	f2_arg0.TextBox:completeAnimation()
	f2_arg0.TextBox:setLeftRight(0.5, 0.5, -960, 960)
	f2_arg0.TextBox:setRGB(0, 1, 0)
	f2_arg0.TextBox:setScale(1, 1)
	f2_arg0.TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_543A5A1C6EED9669"))
end
CoD.ct_firebreak_multi_kill.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				f3_arg0.TextBox:beginAnimation(1500, Enum[@"luitween"][@"luitween_bounce"])
				f3_arg0.TextBox:setScale(1, 1)
				f3_arg0.TextBox:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.TextBox:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.TextBox:completeAnimation()
			f3_arg0.TextBox:setLeftRight(0, 0, -0.5, 1919.5)
			f3_arg0.TextBox:setRGB(0, 1, 0)
			f3_arg0.TextBox:setScale(0.01, 0.01)
			f3_arg0.TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_543A5A1C6EED9669"))
			f3_local0(f3_arg0.TextBox)
		end,
	},
}
CoD.ct_firebreak_multi_kill.__onClose = function(f5_arg0) end
