require("ui/uieditor/widgets/pc/hud/buttonprompt3d/pc_buttonprompt3dbind")
require("ui/uieditor/widgets/pc/hud/pc_progresscirclebacking")
local PostLoadFunc = function(self, controller, menu)
	self.progressMeter:setShaderVector(0, -0.05, 0, 0, 0)
	if CoD.isPC and self.ButtonPrompt3dBindUse and self.ButtonPrompt3dBindUse.promptKM then
		local f1_local0 = function(f2_arg0)
			if CoD.isPC and f2_arg0 and f2_arg0.promptKM then
				local f2_local0 = 39
				local f2_local1 = 26
				if f2_arg0 == nil then
					return
				end
				local f2_local2, f2_local3, f2_local4, f2_local5 = f2_arg0:getLocalLeftRight()
				if not IsGamepad(controller) and f2_local0 < math.max(f2_arg0.promptKM:getTextWidth() + f2_local1, f2_local0) then
					self.progressMeter:setAlpha(0)
				else
					self.progressMeter:setAlpha(1)
				end
			end
		end
		self:registerEventHandler("input_source_changed", function(element, event)
			f1_local0(element.ButtonPrompt3dBindUse)
		end)
		f1_local0(self.ButtonPrompt3dBindUse)
	end
end
CoD.ButtonPrompt3dcpzm_UseButtonIcon = InheritFrom(LUI.UIElement)
CoD.ButtonPrompt3dcpzm_UseButtonIcon.__defaultWidth = 58
CoD.ButtonPrompt3dcpzm_UseButtonIcon.__defaultHeight = 58
CoD.ButtonPrompt3dcpzm_UseButtonIcon.new = function(f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4, f4_arg5, f4_arg6, f4_arg7, f4_arg8, f4_arg9)
	local self = LUI.UIElement.new(f4_arg2, f4_arg3, f4_arg4, f4_arg5, f4_arg6, f4_arg7, f4_arg8, f4_arg9)
	self:setClass(CoD.ButtonPrompt3dcpzm_UseButtonIcon)
	self.id = "ButtonPrompt3dcpzm_UseButtonIcon"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f4_arg0:addElementToPendingUpdateStateList(self)
	local PCProgressCircleBacking = nil
	PCProgressCircleBacking = CoD.PC_ProgressCircleBacking.new(f4_arg0, f4_arg1, 0.5, 0.5, -30, 30, 0.5, 0.5, -30, 30)
	PCProgressCircleBacking:setAlpha(0)
	self:addElement(PCProgressCircleBacking)
	self.PCProgressCircleBacking = PCProgressCircleBacking
	local black = LUI.UIImage.new(0, 0, 0, 58, 0, 0, 0, 58)
	black:setRGB(0, 0, 0)
	black:setImage(RegisterImage("uie_t7_icons_blackcircle"))
	self:addElement(black)
	self.black = black
	local ButtonPrompt3dBindUse = nil
	ButtonPrompt3dBindUse = CoD.PC_ButtonPrompt3dBind.new(f4_arg0, f4_arg1, 0.5, 0.5, -44.5, 44.5, 0.5, 0.5, -11, 11)
	ButtonPrompt3dBindUse:setAlpha(0)
	ButtonPrompt3dBindUse:linkToElementModel(self, nil, false, function(model)
		ButtonPrompt3dBindUse:setModel(model, f4_arg1)
	end)
	self:addElement(ButtonPrompt3dBindUse)
	self.ButtonPrompt3dBindUse = ButtonPrompt3dBindUse
	local UseButtonIcon = LUI.UIImage.new(0, 0, 3, 55, 0, 0, 3, 55)
	UseButtonIcon:subscribeToGlobalModel(f4_arg1, "Controller", "alt1_button_image", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			UseButtonIcon:setImage(RegisterImage(f6_local0))
		end
	end)
	self:addElement(UseButtonIcon)
	self.UseButtonIcon = UseButtonIcon
	local progressMeter = LUI.UIImage.new(0, 0, -1.5, 58.5, 0, 0, -1.5, 58.5)
	progressMeter:setImage(RegisterImage("uie_t7_hud_interact_meter_thick"))
	progressMeter:setMaterial(LUI.UIImage.GetCachedMaterial("uie_clock_normal"))
	progressMeter:setShaderVector(1, 0.5, 0, 0, 0)
	progressMeter:setShaderVector(2, 0.5, 0, 0, 0)
	progressMeter:setShaderVector(3, 0, 0, 0, 0)
	progressMeter:setShaderVector(4, 0, 0, 0, 0)
	progressMeter:linkToElementModel(self, "progress", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			progressMeter:setShaderVector(0, CoD.GetVectorComponentFromString(f7_local0, 1), CoD.GetVectorComponentFromString(f7_local0, 2), CoD.GetVectorComponentFromString(f7_local0, 3), CoD.GetVectorComponentFromString(f7_local0, 4))
		end
	end)
	self:addElement(progressMeter)
	self.progressMeter = progressMeter
	local TextButton = LUI.UIText.new(0.5, 0.5, -30, 30, 0.5, 0.5, -26, 26)
	TextButton:setAlpha(0)
	TextButton:setTTF("default")
	TextButton:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	TextButton:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	TextButton:linkToElementModel(self, "id", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			TextButton:setText(Engine[@"hash_4F9F1239CFD921FE"](GetObjectiveProperty("buttonOverrideText", f8_local0)))
		end
	end)
	self:addElement(TextButton)
	self.TextButton = TextButton
	local carrot = LUI.UIImage.new(0, 0, 25, 31, 0, 0, -4, 6)
	carrot:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	carrot:setZRot(270)
	carrot:setImage(RegisterImage("uie_ui_hud_common_triangle"))
	self:addElement(carrot)
	self.carrot = carrot
	self:mergeStateConditions({
		{
			stateName = "TextButton",
			condition = function(menu, element, event)
				return not CoD.HUDUtility.IsObjectiveXHashPropertyValueEqualTo(self, "buttonoverridetext", nil)
			end,
		},
		{
			stateName = "KBMouse",
			condition = function(menu, element, event)
				local f10_local0
				if not IsGamepad(f4_arg1) then
					f10_local0 = IsPC()
				else
					f10_local0 = false
				end
				return f10_local0
			end,
		},
	})
	self:linkToElementModel(self, "id", true, function(model)
		f4_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f4_arg0,
			controller = f4_arg1,
			modelValue = model:get(),
			modelName = "id",
		})
	end)
	self:appendEventHandler("input_source_changed", function(f12_arg0, f12_arg1)
		f12_arg1.menu = f12_arg1.menu or f4_arg0
		f4_arg0:updateElementState(self, f12_arg1)
	end)
	local f4_local8 = self
	local f4_local9 = self.subscribeToModel
	local f4_local10 = Engine.GetModelForController(f4_arg1)
	f4_local9(f4_local8, f4_local10.LastInput, function(f13_arg0)
		f4_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f4_arg0,
			controller = f4_arg1,
			modelValue = f13_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f4_arg1, f4_arg0)
	end
	return self
end
CoD.ButtonPrompt3dcpzm_UseButtonIcon.__resetProperties = function(f14_arg0)
	f14_arg0.ButtonPrompt3dBindUse:completeAnimation()
	f14_arg0.UseButtonIcon:completeAnimation()
	f14_arg0.TextButton:completeAnimation()
	f14_arg0.black:completeAnimation()
	f14_arg0.progressMeter:completeAnimation()
	f14_arg0.carrot:completeAnimation()
	f14_arg0.PCProgressCircleBacking:completeAnimation()
	f14_arg0.ButtonPrompt3dBindUse:setTopBottom(0.5, 0.5, -11, 11)
	f14_arg0.ButtonPrompt3dBindUse:setAlpha(0)
	f14_arg0.UseButtonIcon:setAlpha(1)
	f14_arg0.TextButton:setAlpha(0)
	f14_arg0.black:setAlpha(1)
	f14_arg0.progressMeter:setLeftRight(0, 0, -1.5, 58.5)
	f14_arg0.progressMeter:setTopBottom(0, 0, -1.5, 58.5)
	f14_arg0.progressMeter:setAlpha(1)
	f14_arg0.carrot:setAlpha(1)
	f14_arg0.PCProgressCircleBacking:setLeftRight(0.5, 0.5, -30, 30)
	f14_arg0.PCProgressCircleBacking:setTopBottom(0.5, 0.5, -30, 30)
	f14_arg0.PCProgressCircleBacking:setAlpha(0)
end
CoD.ButtonPrompt3dcpzm_UseButtonIcon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.ButtonPrompt3dBindUse:completeAnimation()
			f15_arg0.ButtonPrompt3dBindUse:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.ButtonPrompt3dBindUse)
		end,
	},
	TextButton = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(4)
			f16_arg0.black:completeAnimation()
			f16_arg0.black:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.black)
			f16_arg0.ButtonPrompt3dBindUse:completeAnimation()
			f16_arg0.ButtonPrompt3dBindUse:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ButtonPrompt3dBindUse)
			f16_arg0.UseButtonIcon:completeAnimation()
			f16_arg0.UseButtonIcon:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.UseButtonIcon)
			f16_arg0.TextButton:completeAnimation()
			f16_arg0.TextButton:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.TextButton)
		end,
	},
	KBMouse = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(6)
			f17_arg0.PCProgressCircleBacking:completeAnimation()
			f17_arg0.PCProgressCircleBacking:setLeftRight(0.5, 0.5, -33, 33)
			f17_arg0.PCProgressCircleBacking:setTopBottom(0, 0, -3.5, 62.5)
			f17_arg0.PCProgressCircleBacking:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.PCProgressCircleBacking)
			f17_arg0.black:completeAnimation()
			f17_arg0.black:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.black)
			f17_arg0.ButtonPrompt3dBindUse:completeAnimation()
			f17_arg0.ButtonPrompt3dBindUse:setTopBottom(0.5, 0.5, 50, 72)
			f17_arg0.ButtonPrompt3dBindUse:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.ButtonPrompt3dBindUse)
			f17_arg0.UseButtonIcon:completeAnimation()
			f17_arg0.UseButtonIcon:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.UseButtonIcon)
			f17_arg0.progressMeter:completeAnimation()
			f17_arg0.progressMeter:setLeftRight(0.5, 0.5, -22, 22)
			f17_arg0.progressMeter:setTopBottom(0.5, 0.5, -22, 22)
			f17_arg0.progressMeter:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.progressMeter)
			f17_arg0.carrot:completeAnimation()
			f17_arg0.carrot:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.carrot)
		end,
	},
}
CoD.ButtonPrompt3dcpzm_UseButtonIcon.__onClose = function(f18_arg0)
	f18_arg0.PCProgressCircleBacking:close()
	f18_arg0.ButtonPrompt3dBindUse:close()
	f18_arg0.UseButtonIcon:close()
	f18_arg0.progressMeter:close()
	f18_arg0.TextButton:close()
end
