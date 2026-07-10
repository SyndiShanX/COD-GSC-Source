CoD.WeaponBribePreview = InheritFrom(LUI.UIElement)
CoD.WeaponBribePreview.__defaultWidth = 400
CoD.WeaponBribePreview.__defaultHeight = 32
CoD.WeaponBribePreview.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponBribePreview)
	self.id = "WeaponBribePreview"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local f1_local1 = nil
	self.Title = LUI.UIElement.createFake()
	local TitlePC = nil
	TitlePC = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -12, 12)
	TitlePC:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	TitlePC:setText(Engine[0xF9F1239CFD921FE](0xBAB331BCEF6175C))
	TitlePC:setTTF("ttmussels_regular")
	TitlePC:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	TitlePC:setLetterSpacing(1)
	TitlePC:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	TitlePC:setBackingType(2)
	TitlePC:setBackingColor(0, 0, 0)
	TitlePC:setBackingAlpha(0.8)
	TitlePC:setBackingXPadding(6)
	TitlePC:setBackingYPadding(2)
	TitlePC:setBackingMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	TitlePC:setBackingShaderVector(0, 0, 0, 0, 0)
	self:addElement(TitlePC)
	self.TitlePC = TitlePC
	self:mergeStateConditions({
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f3_arg0, f3_arg1)
		f3_arg1.menu = f3_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f3_arg1)
	end)
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5.LastInput, function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponBribePreview.__resetProperties = function(f5_arg0)
	f5_arg0.TitlePC:completeAnimation()
	f5_arg0.TitlePC:setText(Engine[0xF9F1239CFD921FE](0xBAB331BCEF6175C))
end
CoD.WeaponBribePreview.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	KBM = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.TitlePC:completeAnimation()
			f7_arg0.TitlePC:setText(Engine[0xF9F1239CFD921FE](0xA2F6B846CE688A3))
			f7_arg0.clipFinished(f7_arg0.TitlePC)
		end,
	},
}
