require("x64:41ad734fb8d6d92")
require("x64:a9255c570c68aa8")
CoD.DecalTypeButton = InheritFrom(LUI.UIElement)
CoD.DecalTypeButton.__defaultWidth = 306
CoD.DecalTypeButton.__defaultHeight = 63
CoD.DecalTypeButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DecalTypeButton)
	self.id = "DecalTypeButton"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BlackBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlackBacking:setRGB(0, 0, 0)
	BlackBacking:setAlpha(0.95)
	self:addElement(BlackBacking)
	self.BlackBacking = BlackBacking
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.8)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local SelectorOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SelectorOverlay:setAlpha(0.01)
	self:addElement(SelectorOverlay)
	self.SelectorOverlay = SelectorOverlay
	local DecalTypeName = LUI.UIText.new(0, 1, 10, -10, 0.5, 0.5, -12.5, 12.5)
	DecalTypeName:setTTF("ttmussels_regular")
	DecalTypeName:setLetterSpacing(2)
	DecalTypeName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	DecalTypeName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	DecalTypeName:linkToElementModel(self, "name", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			DecalTypeName:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(DecalTypeName)
	self.DecalTypeName = DecalTypeName
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setImage(RegisterImage(0x7615068F50B3D66))
	self:addElement(Background)
	self.Background = Background
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Frame:setAlpha(0.05)
	self:addElement(Frame)
	self.Frame = Frame
	local CommonButtonOutlineThin = CoD.CommonButtonOutlineThin.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(CommonButtonOutlineThin)
	self.CommonButtonOutlineThin = CommonButtonOutlineThin
	CommonButtonOutlineThin.id = "CommonButtonOutlineThin"
	self.__defaultFocus = CommonButtonOutlineThin
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DecalTypeButton.__resetProperties = function(f3_arg0)
	f3_arg0.SelectorOverlay:completeAnimation()
	f3_arg0.SelectorOverlay:setAlpha(0.01)
end
CoD.DecalTypeButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.SelectorOverlay:completeAnimation()
			f5_arg0.SelectorOverlay:setAlpha(0.07)
			f5_arg0.clipFinished(f5_arg0.SelectorOverlay)
		end,
	},
}
CoD.DecalTypeButton.__onClose = function(f6_arg0)
	f6_arg0.DecalTypeName:close()
	f6_arg0.Frame:close()
	f6_arg0.CommonButtonOutlineThin:close()
end
