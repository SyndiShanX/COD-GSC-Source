require("x64:29a6d5c6da0dd3d")
CoD.GameEndScore_DeathCam = InheritFrom(LUI.UIElement)
CoD.GameEndScore_DeathCam.__defaultWidth = 1920
CoD.GameEndScore_DeathCam.__defaultHeight = 1080
CoD.GameEndScore_DeathCam.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameEndScore_DeathCam)
	self.id = "GameEndScore_DeathCam"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local f1_local1 = nil
	self.Prompt = LUI.UIElement.createFake()
	local f1_local2 = nil
	self.PromptAlt = LUI.UIElement.createFake()
	local PromptPC = nil
	PromptPC = CoD.GameEndScore_DeathCamPrompt.new(f1_arg0, f1_arg1, 0.5, 0.5, -878.5, -676.5, 1, 1, -241, -118)
	PromptPC:subscribeToGlobalModel(f1_arg1, "Controller", "primary_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PromptPC.ButtonIcon.buttonImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(PromptPC)
	self.PromptPC = PromptPC
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameEndScore_DeathCam.__onClose = function(f3_arg0)
	f3_arg0.Prompt:close()
	f3_arg0.PromptAlt:close()
	f3_arg0.PromptPC:close()
end
