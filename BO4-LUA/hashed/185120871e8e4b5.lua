CoD.MountablePoint = InheritFrom(LUI.UIElement)
CoD.MountablePoint.__defaultWidth = 128
CoD.MountablePoint.__defaultHeight = 150
CoD.MountablePoint.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MountablePoint)
	self.id = "MountablePoint"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BracketRight = LUI.UIImage.new(0.5, 0.5, 48.5, 66.5, 0.5, 0.5, -47, 43)
	BracketRight:setScale(1.21, 1.21)
	BracketRight:setImage(RegisterImage(@"uie_hud_core_score_bracketright"))
	BracketRight:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(BracketRight)
	self.BracketRight = BracketRight
	local BracketLeft = LUI.UIImage.new(0.5, 0.5, -66.5, -48.5, 0.5, 0.5, -47, 43)
	BracketLeft:setScale(1.21, 1.21)
	BracketLeft:setImage(RegisterImage(@"uie_hud_core_score_bracketleft"))
	BracketLeft:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(BracketLeft)
	self.BracketLeft = BracketLeft
	local Backing = LUI.UIImage.new(0.5, 0.5, -60, 60, 0.5, 0.5, -30, 30)
	Backing:setRGB(0, 0, 0)
	Backing:setAlpha(0.5)
	self:addElement(Backing)
	self.Backing = Backing
	local Icon = LUI.UIImage.new(0.5, 0.5, -60, 60, 0.5, 0.5, -30, 30)
	Icon:linkToElementModel(self, "icon", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Icon:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Icon)
	self.Icon = Icon
	local Arrow = LUI.UIImage.new(0.5, 0.5, -14, 14, 0.5, 0.5, -51, -27)
	Arrow:setImage(RegisterImage(@"uie_img_t7_menu_arrow"))
	self:addElement(Arrow)
	self.Arrow = Arrow
	local Text = LUI.UIText.new(0.5, 0.5, -100, 100, 0.5, 0.5, 30, 80)
	Text:setTTF("default")
	Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Text:linkToElementModel(self, "text", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Text:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	self:addElement(Text)
	self.Text = Text
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MountablePoint.__resetProperties = function(f4_arg0)
	f4_arg0.Backing:completeAnimation()
	f4_arg0.Arrow:completeAnimation()
	f4_arg0.BracketLeft:completeAnimation()
	f4_arg0.BracketRight:completeAnimation()
	f4_arg0.Icon:completeAnimation()
	f4_arg0.Backing:setLeftRight(0.5, 0.5, -60, 60)
	f4_arg0.Backing:setTopBottom(0.5, 0.5, -30, 30)
	f4_arg0.Backing:setScale(1, 1)
	f4_arg0.Arrow:setLeftRight(0.5, 0.5, -14, 14)
	f4_arg0.Arrow:setTopBottom(0.5, 0.5, -51, -27)
	f4_arg0.BracketLeft:setLeftRight(0.5, 0.5, -66.5, -48.5)
	f4_arg0.BracketLeft:setTopBottom(0.5, 0.5, -47, 43)
	f4_arg0.BracketRight:setLeftRight(0.5, 0.5, 48.5, 66.5)
	f4_arg0.BracketRight:setTopBottom(0.5, 0.5, -47, 43)
	f4_arg0.Icon:setLeftRight(0.5, 0.5, -60, 60)
	f4_arg0.Icon:setTopBottom(0.5, 0.5, -30, 30)
	f4_arg0.Icon:setScale(1, 1)
end
CoD.MountablePoint.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(5)
			f5_arg0.BracketRight:completeAnimation()
			f5_arg0.BracketRight:setLeftRight(0.5, 0.5, 59, 77)
			f5_arg0.BracketRight:setTopBottom(0.5, 0.5, -47, 43)
			f5_arg0.clipFinished(f5_arg0.BracketRight)
			f5_arg0.BracketLeft:completeAnimation()
			f5_arg0.BracketLeft:setLeftRight(0.5, 0.5, -76, -58)
			f5_arg0.BracketLeft:setTopBottom(0.5, 0.5, -47, 43)
			f5_arg0.clipFinished(f5_arg0.BracketLeft)
			f5_arg0.Backing:completeAnimation()
			f5_arg0.Backing:setLeftRight(0.5, 0.5, -70, 70)
			f5_arg0.Backing:setTopBottom(0.5, 0.5, -38, 38)
			f5_arg0.Backing:setScale(1.3, 1.3)
			f5_arg0.Backing:setImage(RegisterImage(@"uie_hud_core_score_panelscore"))
			f5_arg0.clipFinished(f5_arg0.Backing)
			f5_arg0.Icon:completeAnimation()
			f5_arg0.Icon:setLeftRight(0.5, 0.5, -60, 60)
			f5_arg0.Icon:setTopBottom(0.5, 0.5, -30, 30)
			f5_arg0.Icon:setScale(1, 1)
			f5_arg0.clipFinished(f5_arg0.Icon)
			f5_arg0.Arrow:completeAnimation()
			f5_arg0.Arrow:setLeftRight(0.5, 0.5, -14, 14)
			f5_arg0.Arrow:setTopBottom(0.5, 0.5, -56, -32)
			f5_arg0.clipFinished(f5_arg0.Arrow)
		end,
	},
}
CoD.MountablePoint.__onClose = function(f6_arg0)
	f6_arg0.Icon:close()
	f6_arg0.Text:close()
end
