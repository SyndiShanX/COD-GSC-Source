CoD.vhud_layoutFuiElements = InheritFrom(LUI.UIElement)
CoD.vhud_layoutFuiElements.__defaultWidth = 1868
CoD.vhud_layoutFuiElements.__defaultHeight = 882
CoD.vhud_layoutFuiElements.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_layoutFuiElements)
	self.id = "vhud_layoutFuiElements"
	self.soundSet = "default"
	local FuiArrowLeft = LUI.UIImage.new(0, 0, 35, 61, 0.5, 0.5, 52, 78)
	FuiArrowLeft:setZRot(90)
	FuiArrowLeft:setImage(RegisterImage(0x3213403D5FE9F16))
	FuiArrowLeft:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(FuiArrowLeft)
	self.FuiArrowLeft = FuiArrowLeft
	local FuiArrowRight = LUI.UIImage.new(1, 1, -58, -32, 0.5, 0.5, 52, 78)
	FuiArrowRight:setZRot(-90)
	FuiArrowRight:setImage(RegisterImage(0x3213403D5FE9F16))
	FuiArrowRight:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(FuiArrowRight)
	self.FuiArrowRight = FuiArrowRight
	local FuiBox01Left = LUI.UIImage.new(0.5, 0.5, -350, -316, 1, 1, -34, 0)
	FuiBox01Left:setYRot(180)
	FuiBox01Left:setImage(RegisterImage(0x811A80C0AADA825))
	FuiBox01Left:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	FuiBox01Left:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FuiBox01Left)
	self.FuiBox01Left = FuiBox01Left
	local FuiBox01Right = LUI.UIImage.new(0.5, 0.5, 318, 352, 1, 1, -34, 0)
	FuiBox01Right:setImage(RegisterImage(0x811A80C0AADA825))
	FuiBox01Right:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	FuiBox01Right:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FuiBox01Right)
	self.FuiBox01Right = FuiBox01Right
	local FuiBox02Left = LUI.UIImage.new(0, 0, 0, 48, 0, 0, 46, 214)
	FuiBox02Left:setYRot(180)
	FuiBox02Left:setImage(RegisterImage(0x5D1D97DECDC39A5))
	FuiBox02Left:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	FuiBox02Left:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FuiBox02Left)
	self.FuiBox02Left = FuiBox02Left
	local FuiBox02Right = LUI.UIImage.new(1, 1, -45, 3, 0, 0, 46, 214)
	FuiBox02Right:setImage(RegisterImage(0x5D1D97DECDC39A5))
	FuiBox02Right:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	FuiBox02Right:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FuiBox02Right)
	self.FuiBox02Right = FuiBox02Right
	local FuiLayoutTopLeft = LUI.UIImage.new(0, 0, 56.5, 342.5, 0, 0, 4, 54)
	FuiLayoutTopLeft:setImage(RegisterImage(0xEA9BC796A122B04))
	FuiLayoutTopLeft:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	FuiLayoutTopLeft:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FuiLayoutTopLeft)
	self.FuiLayoutTopLeft = FuiLayoutTopLeft
	local FuiLayoutTopRight = LUI.UIImage.new(1, 1, -340, -18, 0, 0, 4, 54)
	FuiLayoutTopRight:setImage(RegisterImage(0x942AD27197A6929))
	FuiLayoutTopRight:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	FuiLayoutTopRight:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FuiLayoutTopRight)
	self.FuiLayoutTopRight = FuiLayoutTopRight
	local FuiTextTop = LUI.UIImage.new(0.5, 0.5, -237, 209, 0, 0, 0, 40)
	FuiTextTop:setImage(RegisterImage(0x3A85A202C70C0EC))
	FuiTextTop:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	FuiTextTop:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FuiTextTop)
	self.FuiTextTop = FuiTextTop
	local FuiTextTopLeft = LUI.UIImage.new(0, 0, 8, 146, 0, 0, 23, 179)
	FuiTextTopLeft:setImage(RegisterImage(0xF76E0892AF9A77E))
	FuiTextTopLeft:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	FuiTextTopLeft:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FuiTextTopLeft)
	self.FuiTextTopLeft = FuiTextTopLeft
	local FuiTextTopRight = LUI.UIImage.new(1, 1, -179, -5, 0, 0, 22, 190)
	FuiTextTopRight:setImage(RegisterImage(0xEE4176E30934623))
	FuiTextTopRight:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	FuiTextTopRight:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FuiTextTopRight)
	self.FuiTextTopRight = FuiTextTopRight
	local MapName = LUI.UIText.new(0, 0, 50, 250, 0, 0, 26, 36)
	MapName:setAlpha(0.5)
	MapName:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	MapName:setTTF("dinnext_regular")
	MapName:setMaterial(LUI.UIImage.GetCachedMaterial(0xAE166D9BA8C6907))
	MapName:setShaderVector(0, 0.6, 0, 0, 0)
	MapName:setShaderVector(1, -0.44, 0, 0, 0)
	MapName:setShaderVector(2, 0.7, 0, 0, 0)
	MapName:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	MapName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	MapName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(MapName)
	self.MapName = MapName
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local13 = self
	if IsPC() then
		SizeToHudArea(f1_local13, f1_arg1)
	end
	return self
end
