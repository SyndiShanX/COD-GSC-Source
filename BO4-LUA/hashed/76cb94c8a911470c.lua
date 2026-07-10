require("x64:d1abdd4f5f088b8")
require("x64:37b2f51af159fc1")
CoD.DupeMeter = InheritFrom(LUI.UIElement)
CoD.DupeMeter.__defaultWidth = 349
CoD.DupeMeter.__defaultHeight = 34
CoD.DupeMeter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DupeMeter)
	self.id = "DupeMeter"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backer = CoD.DupeMeterBacker.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Backer)
	self.Backer = Backer
	local Box = LUI.UIImage.new(0, 0, 171, 346, 0, 0, 3.5, 31.5)
	Box:setRGB(0.07, 0.07, 0.07)
	Box:setAlpha(0.05)
	self:addElement(Box)
	self.Box = Box
	local NoiseTiledBacking = LUI.UIImage.new(0, 0, 171, 346, 0.09, 0.09, 0.5, 28.5)
	NoiseTiledBacking:setAlpha(0.5)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local Label = LUI.UIText.new(0.5, 0.5, -168.5, -9.5, 0, 0, 11, 25)
	Label:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Label:setAlpha(0.5)
	Label:setText(LocalizeToUpperString(0x7A11286F9FD7520))
	Label:setTTF("ttmussels_demibold")
	Label:setLetterSpacing(2)
	Label:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Label:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(Label)
	self.Label = Label
	local DupeMeter = CoD.DupeMeterInternal.new(f1_arg0, f1_arg1, 0, 0, 176, 294, 0, 0, 4.5, 31.5)
	DupeMeter:linkToElementModel(self, nil, false, function(model)
		DupeMeter:setModel(model, f1_arg1)
	end)
	self:addElement(DupeMeter)
	self.DupeMeter = DupeMeter
	local Number = LUI.UIText.new(0, 0, 304, 343, 0, 0, 6, 28)
	Number:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Number:setAlpha(0)
	Number:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	Number:setTTF("ttmussels_regular")
	Number:setLetterSpacing(1)
	Number:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Number:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Number)
	self.Number = Number
	self:mergeStateConditions({
		{
			stateName = "AllRngUnlocked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsControllerModelValueTrue(f1_arg1, "LootStreamProgress.allRngUnlocked")
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["LootStreamProgress.allRngUnlocked"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "LootStreamProgress.allRngUnlocked",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DupeMeter.__resetProperties = function(f5_arg0)
	f5_arg0.Label:completeAnimation()
	f5_arg0.Number:completeAnimation()
	f5_arg0.DupeMeter:completeAnimation()
	f5_arg0.NoiseTiledBacking:completeAnimation()
	f5_arg0.Box:completeAnimation()
	f5_arg0.Backer:completeAnimation()
	f5_arg0.Label:setAlpha(0.5)
	f5_arg0.Number:setAlpha(0)
	f5_arg0.DupeMeter:setAlpha(1)
	f5_arg0.NoiseTiledBacking:setAlpha(0.5)
	f5_arg0.Box:setAlpha(0.05)
	f5_arg0.Backer:setAlpha(1)
end
CoD.DupeMeter.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	AllRngUnlocked = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(6)
			f7_arg0.Backer:completeAnimation()
			f7_arg0.Backer:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Backer)
			f7_arg0.Box:completeAnimation()
			f7_arg0.Box:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Box)
			f7_arg0.NoiseTiledBacking:completeAnimation()
			f7_arg0.NoiseTiledBacking:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.NoiseTiledBacking)
			f7_arg0.Label:completeAnimation()
			f7_arg0.Label:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Label)
			f7_arg0.DupeMeter:completeAnimation()
			f7_arg0.DupeMeter:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.DupeMeter)
			f7_arg0.Number:completeAnimation()
			f7_arg0.Number:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Number)
		end,
	},
}
CoD.DupeMeter.__onClose = function(f8_arg0)
	f8_arg0.Backer:close()
	f8_arg0.DupeMeter:close()
end
