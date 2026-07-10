CoD.CodCasterSettingFooter = InheritFrom(LUI.UIElement)
CoD.CodCasterSettingFooter.__defaultWidth = 1066
CoD.CodCasterSettingFooter.__defaultHeight = 253
CoD.CodCasterSettingFooter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterSettingFooter)
	self.id = "CodCasterSettingFooter"
	self.soundSet = "default"
	local BackingBlack = LUI.UIImage.new(-0.14, 1.16, 149, 149, 1, 1, -253, -20)
	BackingBlack:setRGB(0.02, 0.02, 0.02)
	BackingBlack:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		if IsPC() then
			SizeToWidthOfScreen(element, f1_arg1)
		end
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(BackingBlack)
	self.BackingBlack = BackingBlack
	local GrainBG01 = LUI.UIImage.new(-0.14, 1.16, 149, 149, 1, 1, -253, 0)
	GrainBG01:setImage(RegisterImage(0x1FC25912CF54567))
	GrainBG01:setMaterial(LUI.UIImage.GetCachedMaterial(0x3C40D6180864128))
	GrainBG01:registerEventHandler("menu_loaded", function(element, event)
		local f3_local0 = nil
		if element.menuLoaded then
			f3_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f3_local0 = element.super:menuLoaded(event)
		end
		if IsPC() then
			SizeToWidthOfScreen(element, f1_arg1)
		end
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	self:addElement(GrainBG01)
	self.GrainBG01 = GrainBG01
	local BackingGraySmallTop = LUI.UIImage.new(-0.14, 1.16, 149, 149, 1, 1, -253, -251)
	BackingGraySmallTop:setRGB(0.15, 0.15, 0.15)
	BackingGraySmallTop:registerEventHandler("menu_loaded", function(element, event)
		local f4_local0 = nil
		if element.menuLoaded then
			f4_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f4_local0 = element.super:menuLoaded(event)
		end
		if IsPC() then
			SizeToWidthOfScreen(element, f1_arg1)
		end
		if not f4_local0 then
			f4_local0 = element:dispatchEventToChildren(event)
		end
		return f4_local0
	end)
	self:addElement(BackingGraySmallTop)
	self.BackingGraySmallTop = BackingGraySmallTop
	local BackingGrayMediumBottom = LUI.UIImage.new(-0.14, 1.16, 149, 149, 1, 1, -249, -241)
	BackingGrayMediumBottom:setRGB(0.15, 0.15, 0.15)
	BackingGrayMediumBottom:registerEventHandler("menu_loaded", function(element, event)
		local f5_local0 = nil
		if element.menuLoaded then
			f5_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f5_local0 = element.super:menuLoaded(event)
		end
		if IsPC() then
			SizeToWidthOfScreen(element, f1_arg1)
		end
		if not f5_local0 then
			f5_local0 = element:dispatchEventToChildren(event)
		end
		return f5_local0
	end)
	self:addElement(BackingGrayMediumBottom)
	self.BackingGrayMediumBottom = BackingGrayMediumBottom
	local BackingLeft = LUI.UIImage.new(-0.14, 1.16, 149, 149, 1, 1, -236, -20)
	BackingLeft:setRGB(0.08, 0.08, 0.08)
	BackingLeft:registerEventHandler("menu_loaded", function(element, event)
		local f6_local0 = nil
		if element.menuLoaded then
			f6_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f6_local0 = element.super:menuLoaded(event)
		end
		if IsPC() then
			SizeToWidthOfScreen(element, f1_arg1)
		end
		if not f6_local0 then
			f6_local0 = element:dispatchEventToChildren(event)
		end
		return f6_local0
	end)
	self:addElement(BackingLeft)
	self.BackingLeft = BackingLeft
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
