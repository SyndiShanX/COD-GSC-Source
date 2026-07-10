require("x64:246178cf189051b")
CoD.ReticleCycleColorPrompt = InheritFrom(LUI.UIElement)
CoD.ReticleCycleColorPrompt.__defaultWidth = 200
CoD.ReticleCycleColorPrompt.__defaultHeight = 50
CoD.ReticleCycleColorPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReticleCycleColorPrompt)
	self.id = "ReticleCycleColorPrompt"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Label = LUI.UIText.new(0, 1, 0, 0, 0, 0, 32, 50)
	Label:setRGB(0.39, 0.39, 0.39)
	Label:setText(LocalizeToUpperString(0x708A65BE0D25597))
	Label:setTTF("default")
	Label:setLetterSpacing(4)
	Label:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Label:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Label)
	self.Label = Label
	local Prompt = LUI.UIImage.new(0, 0, 85, 115, 0, 0, 0, 30)
	Prompt:subscribeToGlobalModel(f1_arg1, "Controller", "alt2_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Prompt:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Prompt)
	self.Prompt = Prompt
	local KeyPrompt = nil
	KeyPrompt = CoD.KeyPrompt.new(f1_arg0, f1_arg1, 0.5, 0.5, -18, 18, 0, 0, -11, 25)
	KeyPrompt:setAlpha(0)
	KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("[{ui_remove}]"))
	self:addElement(KeyPrompt)
	self.KeyPrompt = KeyPrompt
	local BGGray = LUI.UIImage.new(0, 0, -174, 374, 0, 0, -92.5, -4.5)
	BGGray:setRGB(0.2, 0.2, 0.2)
	BGGray:setAlpha(0.85)
	self:addElement(BGGray)
	self.BGGray = BGGray
	local FrameBorder = LUI.UIImage.new(0, 0, -174, 374, 0, 0, -92.5, -4.5)
	FrameBorder:setAlpha(0.15)
	FrameBorder:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrameBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrameBorder:setShaderVector(0, 0, 0, 0, 0)
	FrameBorder:setupNineSliceShader(12, 12)
	self:addElement(FrameBorder)
	self.FrameBorder = FrameBorder
	local NoiseTiledBacking = LUI.UIImage.new(0, 0, -174, 374, 0, 0, -92.5, -4.5)
	NoiseTiledBacking:setAlpha(0.5)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ReticleCycleColorPrompt.__resetProperties = function(f3_arg0)
	f3_arg0.Prompt:completeAnimation()
	f3_arg0.Label:completeAnimation()
	f3_arg0.BGGray:completeAnimation()
	f3_arg0.FrameBorder:completeAnimation()
	f3_arg0.NoiseTiledBacking:completeAnimation()
	f3_arg0.KeyPrompt:completeAnimation()
	f3_arg0.Prompt:setAlpha(1)
	f3_arg0.Label:setAlpha(1)
	f3_arg0.BGGray:setAlpha(0.85)
	f3_arg0.FrameBorder:setAlpha(0.15)
	f3_arg0.NoiseTiledBacking:setAlpha(0.5)
	f3_arg0.KeyPrompt:setAlpha(0)
end
CoD.ReticleCycleColorPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(5)
			f5_arg0.Label:completeAnimation()
			f5_arg0.Label:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Label)
			f5_arg0.Prompt:completeAnimation()
			f5_arg0.Prompt:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Prompt)
			f5_arg0.BGGray:completeAnimation()
			f5_arg0.BGGray:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.BGGray)
			f5_arg0.FrameBorder:completeAnimation()
			f5_arg0.FrameBorder:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.FrameBorder)
			f5_arg0.NoiseTiledBacking:completeAnimation()
			f5_arg0.NoiseTiledBacking:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.NoiseTiledBacking)
		end,
	},
	KBM = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.Label:completeAnimation()
			f6_arg0.Label:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.Label)
			f6_arg0.Prompt:completeAnimation()
			f6_arg0.Prompt:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Prompt)
			f6_arg0.KeyPrompt:completeAnimation()
			f6_arg0.KeyPrompt:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.KeyPrompt)
		end,
	},
}
CoD.ReticleCycleColorPrompt.__onClose = function(f7_arg0)
	f7_arg0.Prompt:close()
	f7_arg0.KeyPrompt:close()
end
