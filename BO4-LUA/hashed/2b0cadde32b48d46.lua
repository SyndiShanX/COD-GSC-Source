require("x64:2dee1d9f1ec4c33")
require("x64:1d705f17744825c")
CoD.ThemeSlot = InheritFrom(LUI.UIElement)
CoD.ThemeSlot.__defaultWidth = 165
CoD.ThemeSlot.__defaultHeight = 260
CoD.ThemeSlot.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ThemeSlot)
	self.id = "ThemeSlot"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SignatureCamoInternal = CoD.SignatureCamoInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	SignatureCamoInternal:mergeStateConditions({
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return not CoD.WeaponOptionsUtility.IsWeaponSignatureThemeUnlocked(menu, element, f1_arg1)
			end,
		},
	})
	SignatureCamoInternal:linkToElementModel(self, nil, false, function(model)
		SignatureCamoInternal:setModel(model, f1_arg1)
	end)
	self:addElement(SignatureCamoInternal)
	self.SignatureCamoInternal = SignatureCamoInternal
	local ItemHintText = CoD.ItemHintText.new(f1_arg0, f1_arg1, 0.5, 0.5, -146, 146, 0, 0, -90, -45)
	ItemHintText:mergeStateConditions({
		{
			stateName = "NoHintText",
			condition = function(menu, element, event)
				return not CoD.WeaponOptionsUtility.IsWeaponSignatureThemeUnlocked(menu, self, f1_arg1)
			end,
		},
	})
	ItemHintText:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		f1_arg0:updateElementState(ItemHintText, f5_arg1)
	end)
	local f1_local3 = ItemHintText
	local f1_local4 = ItemHintText.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5.LastInput, function(f6_arg0)
		f1_arg0:updateElementState(ItemHintText, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	ItemHintText:setAlpha(0)
	ItemHintText.textCenterAlign:setText(Engine[0xF9F1239CFD921FE](0xD087E4011D7527C))
	self:addElement(ItemHintText)
	self.ItemHintText = ItemHintText
	SignatureCamoInternal.id = "SignatureCamoInternal"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ThemeSlot.__resetProperties = function(f7_arg0)
	f7_arg0.SignatureCamoInternal:completeAnimation()
	f7_arg0.ItemHintText:completeAnimation()
	f7_arg0.SignatureCamoInternal:setScale(1, 1)
	f7_arg0.ItemHintText:setAlpha(0)
end
CoD.ThemeSlot.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.SignatureCamoInternal:completeAnimation()
			f9_arg0.SignatureCamoInternal:setScale(1.05, 1.05)
			f9_arg0.clipFinished(f9_arg0.SignatureCamoInternal)
			f9_arg0.ItemHintText:completeAnimation()
			f9_arg0.ItemHintText:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.ItemHintText)
		end,
		GainChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			local f10_local0 = function(f11_arg0)
				f10_arg0.SignatureCamoInternal:beginAnimation(200)
				f10_arg0.SignatureCamoInternal:setScale(1.05, 1.05)
				f10_arg0.SignatureCamoInternal:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.SignatureCamoInternal:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.SignatureCamoInternal:completeAnimation()
			f10_arg0.SignatureCamoInternal:setScale(1, 1)
			f10_local0(f10_arg0.SignatureCamoInternal)
			local f10_local1 = function(f12_arg0)
				f10_arg0.ItemHintText:beginAnimation(200)
				f10_arg0.ItemHintText:setAlpha(1)
				f10_arg0.ItemHintText:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.ItemHintText:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.ItemHintText:completeAnimation()
			f10_arg0.ItemHintText:setAlpha(0)
			f10_local1(f10_arg0.ItemHintText)
		end,
		LoseChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			local f13_local0 = function(f14_arg0)
				f13_arg0.SignatureCamoInternal:beginAnimation(200)
				f13_arg0.SignatureCamoInternal:setScale(1, 1)
				f13_arg0.SignatureCamoInternal:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.SignatureCamoInternal:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.SignatureCamoInternal:completeAnimation()
			f13_arg0.SignatureCamoInternal:setScale(1.05, 1.05)
			f13_local0(f13_arg0.SignatureCamoInternal)
			f13_arg0.ItemHintText:completeAnimation()
			f13_arg0.ItemHintText:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.ItemHintText)
		end,
	},
}
CoD.ThemeSlot.__onClose = function(f15_arg0)
	f15_arg0.SignatureCamoInternal:close()
	f15_arg0.ItemHintText:close()
end
