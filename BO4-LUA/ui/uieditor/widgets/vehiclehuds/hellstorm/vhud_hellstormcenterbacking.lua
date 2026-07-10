require("x64:6ee653ade3452f5")
CoD.vhud_HellstormCenterBacking = InheritFrom(LUI.UIElement)
CoD.vhud_HellstormCenterBacking.__defaultWidth = 1920
CoD.vhud_HellstormCenterBacking.__defaultHeight = 1080
CoD.vhud_HellstormCenterBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_HellstormCenterBacking)
	self.id = "vhud_HellstormCenterBacking"
	self.soundSet = "default"
	local ScorestreakAspectRatioFix = CoD.Scorestreak_AspectRatioFix.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	ScorestreakAspectRatioFix:setAlpha(0.9)
	ScorestreakAspectRatioFix:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() and not IsSplitscreenAndInGame(f1_arg1) then
			HideWidget(element)
		elseif IsPC() then
			HideWidget(element)
		end
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(ScorestreakAspectRatioFix)
	self.ScorestreakAspectRatioFix = ScorestreakAspectRatioFix
	local vignette = LUI.UIImage.new(0.5, 0.5, -960, 960, 0, 1, 0, 0)
	vignette:setRGB(0, 0, 0)
	vignette:setAlpha(0.5)
	vignette:setImage(RegisterImage(0xB8D7548F3591A70))
	self:addElement(vignette)
	self.vignette = vignette
	local R1Depth = LUI.UIImage.new(0.5, 0.5, 369, 1, 0, 0, 172, 908)
	R1Depth:setAlpha(0.05)
	R1Depth:setImage(RegisterImage(0xCAB86BB52B74C56))
	R1Depth:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(R1Depth)
	self.R1Depth = R1Depth
	local L1Depth = LUI.UIImage.new(0.5, 0.5, -367, 1, 0, 0, 172, 908)
	L1Depth:setAlpha(0.05)
	L1Depth:setImage(RegisterImage(0xCAB86BB52B74C56))
	L1Depth:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(L1Depth)
	self.L1Depth = L1Depth
	local halfCircleRight = LUI.UIImage.new(0.5, 0.5, 408, 0, 0.5, 0.5, -408, 0)
	halfCircleRight:setAlpha(0.05)
	halfCircleRight:setImage(RegisterImage(0xF13D40449AE7486))
	halfCircleRight:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(halfCircleRight)
	self.halfCircleRight = halfCircleRight
	local halfCircleLeft = LUI.UIImage.new(0.5, 0.5, -408, 0, 0.5, 0.5, -408, 0)
	halfCircleLeft:setAlpha(0.05)
	halfCircleLeft:setImage(RegisterImage(0xF13D40449AE7486))
	halfCircleLeft:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(halfCircleLeft)
	self.halfCircleLeft = halfCircleLeft
	local L1 = LUI.UIImage.new(0.5, 0.5, -420, 0, 0.5, 0.5, -420, 0)
	L1:setAlpha(0)
	L1:setImage(RegisterImage(0xFCF12476EF3C999))
	self:addElement(L1)
	self.L1 = L1
	local L2 = LUI.UIImage.new(0.5, 0.5, -420, 0, 0.5, 0.5, 420, 0)
	L2:setAlpha(0)
	L2:setImage(RegisterImage(0xFCF12476EF3C999))
	self:addElement(L2)
	self.L2 = L2
	local R1 = LUI.UIImage.new(0.5, 0.5, 420, 0, 0.5, 0.5, -420, 0)
	R1:setAlpha(0)
	R1:setImage(RegisterImage(0xFCF12476EF3C999))
	self:addElement(R1)
	self.R1 = R1
	local R2 = LUI.UIImage.new(0.5, 0.5, 420, 0, 0.5, 0.5, 420, 0)
	R2:setAlpha(0)
	R2:setImage(RegisterImage(0xFCF12476EF3C999))
	self:addElement(R2)
	self.R2 = R2
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_HellstormCenterBacking.__onClose = function(f3_arg0)
	f3_arg0.ScorestreakAspectRatioFix:close()
end
