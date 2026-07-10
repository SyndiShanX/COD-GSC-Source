CoD.HubWeaponVideoButtonGrid = InheritFrom(LUI.UIElement)
CoD.HubWeaponVideoButtonGrid.__defaultWidth = 460
CoD.HubWeaponVideoButtonGrid.__defaultHeight = 260
CoD.HubWeaponVideoButtonGrid.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HubWeaponVideoButtonGrid)
	self.id = "HubWeaponVideoButtonGrid"
	self.soundSet = "default"
	local GridOutlineBot = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -1, 1)
	GridOutlineBot:setAlpha(0.7)
	GridOutlineBot:setImage(RegisterImage(0x84B43D5B04D263A))
	GridOutlineBot:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	GridOutlineBot:setShaderVector(0, 0, 0, 0, 0)
	GridOutlineBot:setupNineSliceShader(4, 2)
	self:addElement(GridOutlineBot)
	self.GridOutlineBot = GridOutlineBot
	local GridOutlineTop = LUI.UIImage.new(0, 1, 0, 0, 0, 0, -1, 1)
	GridOutlineTop:setAlpha(0.7)
	GridOutlineTop:setImage(RegisterImage(0x84B43D5B04D263A))
	GridOutlineTop:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	GridOutlineTop:setShaderVector(0, 0, 0, 0, 0)
	GridOutlineTop:setupNineSliceShader(4, 2)
	self:addElement(GridOutlineTop)
	self.GridOutlineTop = GridOutlineTop
	local GridOutlineLeft = LUI.UIImage.new(0, 0, -130, 130, 0, 0, 129, 131)
	GridOutlineLeft:setAlpha(0.7)
	GridOutlineLeft:setZRot(90)
	GridOutlineLeft:setImage(RegisterImage(0x84B43D5B04D263A))
	GridOutlineLeft:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	GridOutlineLeft:setShaderVector(0, 0, 0, 0, 0)
	GridOutlineLeft:setupNineSliceShader(4, 2)
	self:addElement(GridOutlineLeft)
	self.GridOutlineLeft = GridOutlineLeft
	local GridOutlineRight = LUI.UIImage.new(1, 1, -130, 130, 0, 0, 129, 131)
	GridOutlineRight:setAlpha(0.7)
	GridOutlineRight:setZRot(90)
	GridOutlineRight:setImage(RegisterImage(0x84B43D5B04D263A))
	GridOutlineRight:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	GridOutlineRight:setShaderVector(0, 0, 0, 0, 0)
	GridOutlineRight:setupNineSliceShader(4, 2)
	self:addElement(GridOutlineRight)
	self.GridOutlineRight = GridOutlineRight
	local GridTiled = LUI.UIImage.new(0, 1, 1.5, -2.5, 0, 1, 2, -2)
	GridTiled:setAlpha(0.5)
	GridTiled:setScale(1.01, 1.01)
	GridTiled:setImage(RegisterImage(0xCA386792563DE8))
	GridTiled:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	GridTiled:setShaderVector(0, 0, 0, 0, 0)
	GridTiled:setupNineSliceShader(128, 128)
	self:addElement(GridTiled)
	self.GridTiled = GridTiled
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
