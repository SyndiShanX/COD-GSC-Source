require("x64:54cc215844d78e6")
CoD.MOTD_ImageText_Tiles = InheritFrom(LUI.UIElement)
CoD.MOTD_ImageText_Tiles.__defaultWidth = 1380
CoD.MOTD_ImageText_Tiles.__defaultHeight = 680
CoD.MOTD_ImageText_Tiles.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MOTD_ImageText_Tiles)
	self.id = "MOTD_ImageText_Tiles"
	self.soundSet = "none"
	local spacer = LUI.UIImage.new(0, 0, 0, 63, 0, 0, 64, 67)
	spacer:setAlpha(0)
	self:addElement(spacer)
	self.spacer = spacer
	local MOTDImageTextTile = CoD.MOTD_ImageTextTile.new(f1_arg0, f1_arg1, 0, 0, 20, 376, 0, 0, 76, 356)
	MOTDImageTextTile:linkToElementModel(self, nil, false, function(model)
		MOTDImageTextTile:setModel(model, f1_arg1)
	end)
	self:addElement(MOTDImageTextTile)
	self.MOTDImageTextTile = MOTDImageTextTile
	local MOTDImageTextTile5 = CoD.MOTD_ImageTextTile.new(f1_arg0, f1_arg1, 0, 0, 1004, 1360, 0, 0, 76, 356)
	MOTDImageTextTile5:linkToElementModel(self, nil, false, function(model)
		MOTDImageTextTile5:setModel(model, f1_arg1)
	end)
	self:addElement(MOTDImageTextTile5)
	self.MOTDImageTextTile5 = MOTDImageTextTile5
	local MOTDImageTextTile3 = CoD.MOTD_ImageTextTile.new(f1_arg0, f1_arg1, 0, 0, 518, 874, 0, 0, 76, 356)
	MOTDImageTextTile3:linkToElementModel(self, nil, false, function(model)
		MOTDImageTextTile3:setModel(model, f1_arg1)
	end)
	self:addElement(MOTDImageTextTile3)
	self.MOTDImageTextTile3 = MOTDImageTextTile3
	local MOTDImageTextTile2 = CoD.MOTD_ImageTextTile.new(f1_arg0, f1_arg1, 0, 0, 20, 376, 0, 0, 400, 680)
	MOTDImageTextTile2:linkToElementModel(self, nil, false, function(model)
		MOTDImageTextTile2:setModel(model, f1_arg1)
	end)
	self:addElement(MOTDImageTextTile2)
	self.MOTDImageTextTile2 = MOTDImageTextTile2
	local MOTDImageTextTile6 = CoD.MOTD_ImageTextTile.new(f1_arg0, f1_arg1, 0, 0, 1004, 1360, 0, 0, 400, 680)
	MOTDImageTextTile6:linkToElementModel(self, nil, false, function(model)
		MOTDImageTextTile6:setModel(model, f1_arg1)
	end)
	self:addElement(MOTDImageTextTile6)
	self.MOTDImageTextTile6 = MOTDImageTextTile6
	local MOTDImageTextTile4 = CoD.MOTD_ImageTextTile.new(f1_arg0, f1_arg1, 0, 0, 518, 874, 0, 0, 400, 680)
	MOTDImageTextTile4:linkToElementModel(self, nil, false, function(model)
		MOTDImageTextTile4:setModel(model, f1_arg1)
	end)
	self:addElement(MOTDImageTextTile4)
	self.MOTDImageTextTile4 = MOTDImageTextTile4
	local TitleLbl = LUI.UIText.new(0, 0, 18, 658, 0, 0, 19.5, 64.5)
	TitleLbl:setRGB(0.86, 0.74, 0.25)
	TitleLbl:setAlpha(0.1)
	TitleLbl:setTTF("ttmussels_demibold")
	TitleLbl:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	TitleLbl:setShaderVector(0, 0, 0, 0, 0)
	TitleLbl:setShaderVector(1, 0, 0, 0, 0)
	TitleLbl:setShaderVector(2, 1, 1, 1, 0)
	TitleLbl:setLetterSpacing(10)
	TitleLbl:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0x58C8A85F2048829]))
	TitleLbl:linkToElementModel(self, "title", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			TitleLbl:setText(ConvertToUpperString(f8_local0))
		end
	end)
	self:addElement(TitleLbl)
	self.TitleLbl = TitleLbl
	local TitleLbl0 = LUI.UIText.new(0, 0, 20, 660, 0, 0, 17.5, 62.5)
	TitleLbl0:setRGB(0.86, 0.74, 0.25)
	TitleLbl0:setTTF("ttmussels_demibold")
	TitleLbl0:setLetterSpacing(10)
	TitleLbl0:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0x58C8A85F2048829]))
	TitleLbl0:linkToElementModel(self, "title", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			TitleLbl0:setText(ConvertToUpperString(f9_local0))
		end
	end)
	self:addElement(TitleLbl0)
	self.TitleLbl0 = TitleLbl0
	local ItemFrame = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	ItemFrame:setImage(RegisterImage(0x185E11D74ECA3D7))
	ItemFrame:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	ItemFrame:setShaderVector(0, 0, 0, 0, 0)
	ItemFrame:setupNineSliceShader(12, 12)
	self:addElement(ItemFrame)
	self.ItemFrame = ItemFrame
	local ItemFrameAdd = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	ItemFrameAdd:setAlpha(0)
	ItemFrameAdd:setImage(RegisterImage(0x185E11D74ECA3D7))
	ItemFrameAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	ItemFrameAdd:setShaderVector(0, 0, 0, 0, 0)
	ItemFrameAdd:setupNineSliceShader(12, 12)
	self:addElement(ItemFrameAdd)
	self.ItemFrameAdd = ItemFrameAdd
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MOTD_ImageText_Tiles.__onClose = function(f10_arg0)
	f10_arg0.MOTDImageTextTile:close()
	f10_arg0.MOTDImageTextTile5:close()
	f10_arg0.MOTDImageTextTile3:close()
	f10_arg0.MOTDImageTextTile2:close()
	f10_arg0.MOTDImageTextTile6:close()
	f10_arg0.MOTDImageTextTile4:close()
	f10_arg0.TitleLbl:close()
	f10_arg0.TitleLbl0:close()
end
