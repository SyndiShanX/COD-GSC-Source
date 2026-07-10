CoD.ct_crash_kill_remaining_enemy = InheritFrom(CoD.Menu)
LUI.createMenu.ct_crash_kill_remaining_enemy = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("ct_crash_kill_remaining_enemy", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.ct_crash_kill_remaining_enemy)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local TextBox = LUI.UIText.new(0.5, 0.5, -960, 960, 0.5, 0.5, -507, -462)
	TextBox:setRGB(0, 1, 0)
	TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7F341B796C609B"))
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
CoD.ct_crash_kill_remaining_enemy.__resetProperties = function(f2_arg0)
	f2_arg0.TextBox:completeAnimation()
	f2_arg0.TextBox:setLeftRight(0.5, 0.5, -960, 960)
	f2_arg0.TextBox:setRGB(0, 1, 0)
	f2_arg0.TextBox:setScale(1, 1)
	f2_arg0.TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7F341B796C609B"))
end
CoD.ct_crash_kill_remaining_enemy.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.TextBox:beginAnimation(1500, Enum[@"luitween"][@"luitween_bounce"])
			f3_arg0.TextBox:setLeftRight(0, 0, -0.5, 1919.5)
			f3_arg0.TextBox:setRGB(0, 1, 0)
			f3_arg0.TextBox:setScale(1, 1)
			f3_arg0.TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7F341B796C609B"))
			f3_arg0.TextBox:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.TextBox:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
		end,
	},
}
CoD.ct_crash_kill_remaining_enemy.__onClose = function(f4_arg0) end
