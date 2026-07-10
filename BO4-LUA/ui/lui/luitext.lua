LUI.UIText = InheritFrom(LUI.UIElement)
LUI.UIText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7)
	local self = LUI.UIElement.new(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7)
	self:setClass(LUI.UIText)
	self:setupUIText()
	return self
end
LUI.UIText.BackingTypes = LuaEnum.createEnum("None", "Widget", "Image", "NineSliceImage")
LUI.UIText.removeCurrentBackingWidget = function(f2_arg0)
	if f2_arg0._backingElement then
		f2_arg0._backingElement:close()
		f2_arg0._backingElement = nil
	end
end
LUI.UIText.setBackingWidget = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
	f3_arg0:removeCurrentBackingWidget()
	f3_arg0._backingXPadding = f3_arg0._backingXPadding or 0
	f3_arg0._backingYPadding = f3_arg0._backingYPadding or 0
	if f3_arg1 and f3_arg1.new then
		f3_arg0._backingElement = f3_arg1.new(f3_arg2, f3_arg3)
		f3_arg0._backingElement:setLeftRight(0, 1, -f3_arg0._backingXPadding, f3_arg0._backingXPadding)
		f3_arg0._backingElement:setTopBottom(0, 1, -f3_arg0._backingYPadding, f3_arg0._backingYPadding)
		f3_arg0:addElement(f3_arg0._backingElement)
	end
end
LUI.UIText.setBackingModel = function(f4_arg0, f4_arg1, f4_arg2)
	return f4_arg0._backingElement and f4_arg0._backingElement:setModel(f4_arg1, f4_arg2)
end
LUI.UIText.setBackingColor = function(f5_arg0, f5_arg1, f5_arg2, f5_arg3)
	return f5_arg0._backingElement and f5_arg0._backingElement:setRGB(f5_arg1, f5_arg2, f5_arg3)
end
LUI.UIText.setBackingAlpha = function(f6_arg0, f6_arg1)
	return f6_arg0._backingElement and f6_arg0._backingElement:setAlpha(f6_arg1)
end
LUI.UIText.setBackingXPadding = function(f7_arg0, f7_arg1)
	f7_arg0._backingXPadding = f7_arg1
	if f7_arg0._backingElement then
		f7_arg0._backingElement:setLeftRight(0, 1, -f7_arg0._backingXPadding, f7_arg0._backingXPadding)
	end
end
LUI.UIText.setBackingYPadding = function(f8_arg0, f8_arg1)
	f8_arg0._backingYPadding = f8_arg1
	if f8_arg0._backingElement then
		f8_arg0._backingElement:setTopBottom(0, 1, -f8_arg0._backingYPadding, f8_arg0._backingYPadding)
	end
end
LUI.UIText.setBackingImage = function(f9_arg0, f9_arg1)
	return f9_arg0._backingElement and f9_arg0._backingElement:setImage(f9_arg1)
end
LUI.UIText.setBackingMaterial = function(f10_arg0, f10_arg1)
	return f10_arg0._backingElement and f10_arg0._backingElement:setMaterial(f10_arg1)
end
LUI.UIText.setBackingShaderVector = function(f11_arg0, f11_arg1, f11_arg2, f11_arg3, f11_arg4, f11_arg5)
	local f11_local0 = f11_arg0._backingElement
	if f11_local0 then
		f11_local0 = f11_arg0._backingElement
		if f11_local0 then
			f11_local0 = f11_arg0._backingElement:setShaderVector(f11_arg1, f11_arg2, f11_arg3, f11_arg4, f11_arg5)
		end
	end
	return f11_local0
end
LUI.UIText.setBackingType = function(f12_arg0, f12_arg1)
	if f12_arg1 ~= LUI.UIText.BackingTypes.NineSliceImage and f12_arg1 ~= LUI.UIText.BackingTypes.Image then
		return
	elseif f12_arg0._backingElement then
		f12_arg0._backingElement:close()
		f12_arg0._backingElement = nil
	end
	f12_arg0._backingElement = LUI.UIImage.new()
	f12_arg0._backingXPadding = f12_arg0._backingXPadding or 0
	f12_arg0._backingYPadding = f12_arg0._backingYPadding or 0
	f12_arg0._backingElement:setLeftRight(0, 1, -f12_arg0._backingXPadding, f12_arg0._backingXPadding)
	f12_arg0._backingElement:setTopBottom(0, 1, -f12_arg0._backingYPadding, f12_arg0._backingYPadding)
	f12_arg0:addElement(f12_arg0._backingElement)
	if f12_arg1 == LUI.UIText.BackingTypes.NineSliceImage then
	else
	end
end
LUI.UIText.setupBackingNineSliceShader = function(f13_arg0, f13_arg1, f13_arg2)
	local f13_local0 = f13_arg0._backingElement
	if f13_local0 then
		f13_local0 = f13_arg0._backingElement
		if f13_local0 then
			f13_local0 = f13_arg0._backingElement:setupNineSliceShader(f13_arg1, f13_arg2)
		end
	end
	return f13_local0
end
LUI.UIText.close = function(f14_arg0)
	f14_arg0:removeCurrentBackingWidget()
	LUI.UIText.super.close(f14_arg0)
end
LUI.UIText.id = "LUIText"
