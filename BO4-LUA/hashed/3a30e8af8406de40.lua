require("x64:d019ee604df7ce4")
require("x64:cd8f1336652f81e")
CoD.KillcamFrame = InheritFrom(LUI.UIElement)
CoD.KillcamFrame.__defaultWidth = 1920
CoD.KillcamFrame.__defaultHeight = 1080
CoD.KillcamFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.KillcamFrame)
	self.id = "KillcamFrame"
	self.soundSet = "ChooseDecal"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Left = LUI.UIImage.new(0, 0, 0, 104, 0, 0, 0, 1080)
	Left:setRGB(0, 0, 0)
	self:addElement(Left)
	self.Left = Left
	local Top = LUI.UIImage.new(0, 0, 0, 1920, 0, 0, 0, 609)
	Top:setRGB(0, 0, 0)
	self:addElement(Top)
	self.Top = Top
	local Right = LUI.UIImage.new(0, 0, 512, 1920, 0, 0, 0, 1080)
	Right:setRGB(0, 0, 0)
	self:addElement(Right)
	self.Right = Right
	local Bottom = LUI.UIImage.new(0, 0, 0, 1920, 0, 0, 849, 1080)
	Bottom:setRGB(0, 0, 0)
	self:addElement(Bottom)
	self.Bottom = Bottom
	local KillcamCover = CoD.KillcamCover.new(f1_arg0, f1_arg1, 0, 0, 104, 512, 0, 0, 609, 849)
	self:addElement(KillcamCover)
	self.KillcamCover = KillcamCover
	local ButtonPrompt = CoD.buttonprompt.new(f1_arg0, f1_arg1, 0, 0, 229, 387, 0, 0, 621, 671)
	ButtonPrompt:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.killcamActive", 0)
			end,
		},
	})
	local f1_local7 = ButtonPrompt
	local f1_local8 = ButtonPrompt.subscribeToModel
	local f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["hudItems.killcamActive"], function(f3_arg0)
		f1_arg0:updateElementState(ButtonPrompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "hudItems.killcamActive",
		})
	end, false)
	ButtonPrompt:setAlpha(0)
	ButtonPrompt.label:setText(Engine[0xF9F1239CFD921FE](0x70675323ADAA7D6))
	ButtonPrompt:subscribeToGlobalModel(f1_arg1, "Controller", "alt1_button_image", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ButtonPrompt.buttonPromptImage:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(ButtonPrompt)
	self.ButtonPrompt = ButtonPrompt
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Killcam",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f7_arg2, f7_arg3, f7_arg4)
		if IsSelfInState(self, "DefaultState") then
			SetElementState(self, self.KillcamCover, controller, "InstantOn")
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local8 = self
	CoD.SpawnSelectionUtility.CalculateKillcamViewportSize(self, f1_arg1, f1_arg0, self.KillcamCover)
	return self
end
CoD.KillcamFrame.__resetProperties = function(f8_arg0)
	f8_arg0.Bottom:completeAnimation()
	f8_arg0.Right:completeAnimation()
	f8_arg0.Top:completeAnimation()
	f8_arg0.Left:completeAnimation()
	f8_arg0.KillcamCover:completeAnimation()
	f8_arg0.ButtonPrompt:completeAnimation()
	f8_arg0.Bottom:setAlpha(1)
	f8_arg0.Right:setAlpha(1)
	f8_arg0.Top:setAlpha(1)
	f8_arg0.Left:setAlpha(1)
	f8_arg0.KillcamCover:setAlpha(1)
	f8_arg0.ButtonPrompt:setAlpha(0)
end
CoD.KillcamFrame.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(6)
			f10_arg0.Left:completeAnimation()
			f10_arg0.Left:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Left)
			f10_arg0.Top:completeAnimation()
			f10_arg0.Top:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Top)
			f10_arg0.Right:completeAnimation()
			f10_arg0.Right:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Right)
			f10_arg0.Bottom:completeAnimation()
			f10_arg0.Bottom:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Bottom)
			f10_arg0.KillcamCover:completeAnimation()
			f10_arg0.KillcamCover:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.KillcamCover)
			f10_arg0.ButtonPrompt:completeAnimation()
			f10_arg0.ButtonPrompt:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.ButtonPrompt)
		end,
	},
	Killcam = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.KillcamFrame.__onClose = function(f12_arg0)
	f12_arg0.KillcamCover:close()
	f12_arg0.ButtonPrompt:close()
end
