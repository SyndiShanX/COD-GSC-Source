require("x64:d7e092479c7b82c")
CoD.vehicleCollisionWarning = InheritFrom(LUI.UIElement)
CoD.vehicleCollisionWarning.__defaultWidth = 250
CoD.vehicleCollisionWarning.__defaultHeight = 41
CoD.vehicleCollisionWarning.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vehicleCollisionWarning)
	self.id = "vehicleCollisionWarning"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Border = CoD.Border.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Border:setRGB(1, 0.52, 0)
	self:addElement(Border)
	self.Border = Border
	local text = LUI.UIText.new(0.5, 0.5, -125, 125, 0.5, 0.5, -18.5, 18.5)
	text:setRGB(1, 0.52, 0)
	text:setText(Engine[0xF9F1239CFD921FE](0x991968E9BE6C1EA))
	text:setTTF("default")
	text:setMaterial(LUI.UIImage.GetCachedMaterial(0x6250C6FCAC36BD4))
	text:setShaderVector(0, 0, 0, 0, 0)
	text:setShaderVector(1, 1, 0, 0, 1)
	text:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	LUI.OverrideFunction_CallOriginalFirst(text, "setText", function(element, controller)
		ScaleWidgetToLabel(self, element, 12)
	end)
	self:addElement(text)
	self.text = text
	self:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "showCollisionWarning") and CoD.ModelUtility.IsSelfModelValueGreaterThan(self, f1_arg1, "collisionWarning", 0)
			end,
		},
	})
	self:linkToElementModel(self, "showCollisionWarning", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "showCollisionWarning",
		})
	end)
	self:linkToElementModel(self, "collisionWarning", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "collisionWarning",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vehicleCollisionWarning.__resetProperties = function(f6_arg0)
	f6_arg0.text:completeAnimation()
	f6_arg0.Border:completeAnimation()
	f6_arg0.text:setAlpha(1)
	f6_arg0.text:setScale(1, 1)
	f6_arg0.text:setMaterial(LUI.UIImage.GetCachedMaterial(0x6250C6FCAC36BD4))
	f6_arg0.text:setShaderVector(0, 0, 0, 0, 0)
	f6_arg0.text:setShaderVector(1, 1, 0, 0, 1)
	f6_arg0.text:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x6B34AA3F39208EF))
	f6_arg0.Border:setAlpha(1)
end
CoD.vehicleCollisionWarning.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.Border:completeAnimation()
			f7_arg0.Border:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Border)
			f7_arg0.text:completeAnimation()
			f7_arg0.text:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.text)
		end,
	},
	On = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.Border:completeAnimation()
			f8_arg0.Border:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.Border)
			local f8_local0 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(500)
					f10_arg0:setScale(1, 1)
					f10_arg0:setShaderVector(0, 0, 0, 0, 0)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
				end
				f8_arg0.text:beginAnimation(500)
				f8_arg0.text:setScale(1.15, 1.15)
				f8_arg0.text:setShaderVector(0, 0.11, 0, 0, 0)
				f8_arg0.text:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.text:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f8_arg0.text:completeAnimation()
			f8_arg0.text:setAlpha(1)
			f8_arg0.text:setScale(1, 1)
			f8_arg0.text:setMaterial(LUI.UIImage.GetCachedMaterial(0x6250C6FCAC36BD4))
			f8_arg0.text:setShaderVector(0, 0, 0, 0, 0)
			f8_arg0.text:setShaderVector(1, 1, 0.46, 0, 1)
			f8_arg0.text:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x6B34AA3F39208EF))
			f8_local0(f8_arg0.text)
			f8_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.vehicleCollisionWarning.__onClose = function(f11_arg0)
	f11_arg0.Border:close()
end
