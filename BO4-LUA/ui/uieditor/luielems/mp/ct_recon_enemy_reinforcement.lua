CoD.ct_recon_enemy_reinforcement = InheritFrom(CoD.Menu)
LUI.createMenu.ct_recon_enemy_reinforcement = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("ct_recon_enemy_reinforcement", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.ct_recon_enemy_reinforcement)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local TextBox = LUI.UIText.new(0.5, 0.5, -619.5, 601.5, 0.5, 0.5, 65, 202)
	TextBox:setText(Engine[0xF9F1239CFD921FE](0xB5629E04C712BB1))
	TextBox:setTTF("default")
	TextBox:setMaterial(LUI.UIImage.GetCachedMaterial(0xAE166D9BA8C6907))
	TextBox:setShaderVector(0, 0.14, 0, 0, 0)
	TextBox:setShaderVector(1, 0.43, 0, 0, 0)
	TextBox:setShaderVector(2, 0.71, 0, 0, 0)
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
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
CoD.ct_recon_enemy_reinforcement.__resetProperties = function(f2_arg0)
	f2_arg0.TextBox:completeAnimation()
	f2_arg0.TextBox:setRGB(1, 1, 1)
	f2_arg0.TextBox:setScale(1, 1)
end
CoD.ct_recon_enemy_reinforcement.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				f3_arg0.TextBox:beginAnimation(1500, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735])
				f3_arg0.TextBox:setScale(1, 1)
				f3_arg0.TextBox:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.TextBox:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.TextBox:completeAnimation()
			f3_arg0.TextBox:setRGB(1, 0, 0)
			f3_arg0.TextBox:setScale(0.01, 0.01)
			f3_local0(f3_arg0.TextBox)
		end,
	},
}
CoD.ct_recon_enemy_reinforcement.__onClose = function(f5_arg0) end
