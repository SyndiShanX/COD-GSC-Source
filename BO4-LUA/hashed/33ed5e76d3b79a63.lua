CoD.PositionDraft_BannerFUI = InheritFrom(LUI.UIElement)
CoD.PositionDraft_BannerFUI.__defaultWidth = 64
CoD.PositionDraft_BannerFUI.__defaultHeight = 64
CoD.PositionDraft_BannerFUI.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PositionDraft_BannerFUI)
	self.id = "PositionDraft_BannerFUI"
	self.soundSet = "default"
	local Background = LUI.UIImage.new(0, 0, 28, 46, 0, 0, 28, 46)
	Background:setRGB(0, 0, 0)
	Background:setAlpha(0.3)
	self:addElement(Background)
	self.Background = Background
	local border01 = LUI.UIImage.new(0, 0, 28, 46, 0, 0, 27, 28)
	self:addElement(border01)
	self.border01 = border01
	local border = LUI.UIImage.new(0, 0, 46, 47, 0, 0, 27, 47)
	self:addElement(border)
	self.border = border
	local border2 = LUI.UIImage.new(0, 0, 27, 46, 0, 0, 46, 47)
	self:addElement(border2)
	self.border2 = border2
	local border3 = LUI.UIImage.new(0, 0, 27, 28, 0, 0, 27, 46)
	self:addElement(border3)
	self.border3 = border3
	local microtext = LUI.UIImage.new(0, 0, 11, 29, 0, 0, 22.5, 26.5)
	microtext:setZRot(45)
	microtext:setImage(RegisterImage(@"hash_116C3274D8031268"))
	microtext:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	microtext:setShaderVector(0, 0.19, 1, 0, 0)
	microtext:setShaderVector(1, 0, 0, 0, 0)
	microtext:setShaderVector(2, 0, 1, 0, 0)
	microtext:setShaderVector(3, 0, 0, 0, 0)
	microtext:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(microtext)
	self.microtext = microtext
	local arrow = LUI.UIImage.new(0, 0, 29.5, 44.5, 0, 0, 29, 44)
	arrow:setZRot(45)
	arrow:setImage(RegisterImage(@"uie_ui_hud_common_objective_icon"))
	self:addElement(arrow)
	self.arrow = arrow
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
