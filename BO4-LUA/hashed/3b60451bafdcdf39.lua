require("x64:f01a3e1dd9d2c5c")
require("x64:9b854af2f368571")
CoD.vhud_attack_helicopter_button_layout = InheritFrom(LUI.UIElement)
CoD.vhud_attack_helicopter_button_layout.__defaultWidth = 1920
CoD.vhud_attack_helicopter_button_layout.__defaultHeight = 1080
CoD.vhud_attack_helicopter_button_layout.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_attack_helicopter_button_layout)
	self.id = "vhud_attack_helicopter_button_layout"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local vhudHellstormBGFrame = CoD.vhud_HellstormBGFrame.new(f1_arg0, f1_arg1, 0.5, 0.5, -959, 961, 0.5, 0.5, -540, 540)
	self:addElement(vhudHellstormBGFrame)
	self.vhudHellstormBGFrame = vhudHellstormBGFrame
	local RightStick = CoD.vhud_ButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 89, 218, 0, 0, 879.5, 1008.5)
	RightStick:subscribeToGlobalModel(f1_arg1, "VehicleController", "right_stick_move_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			RightStick.button0:setImage(RegisterImage(f2_local0))
		end
	end)
	RightStick:subscribeToGlobalModel(f1_arg1, "VehicleController", "right_stick_move_image", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			RightStick.button1:setImage(RegisterImage(f3_local0))
		end
	end)
	RightStick:subscribeToGlobalModel(f1_arg1, "VehicleController", "right_stick_move_image", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			RightStick.button:setImage(RegisterImage(f4_local0))
		end
	end)
	RightStick:linkToElementModel(self, "R_STICK", false, function(model)
		RightStick:setModel(model, f1_arg1)
	end)
	RightStick:linkToElementModel(self, "R_STICK.text", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			RightStick.prompt:setText(Engine[0xF9F1239CFD921FE](f6_local0))
		end
	end)
	self:addElement(RightStick)
	self.RightStick = RightStick
	local RightBumper = CoD.vhud_ButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 1116.5, 1245.5, 0, 0, 750.5, 879.5)
	RightBumper:subscribeToGlobalModel(f1_arg1, "VehicleController", "right_shoulder_button_image", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			RightBumper.button0:setImage(RegisterImage(f7_local0))
		end
	end)
	RightBumper:subscribeToGlobalModel(f1_arg1, "VehicleController", "right_shoulder_button_image", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			RightBumper.button1:setImage(RegisterImage(f8_local0))
		end
	end)
	RightBumper:subscribeToGlobalModel(f1_arg1, "VehicleController", "right_shoulder_button_image", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			RightBumper.button:setImage(RegisterImage(f9_local0))
		end
	end)
	RightBumper:linkToElementModel(self, "BUTTON_RSHLDR", false, function(model)
		RightBumper:setModel(model, f1_arg1)
	end)
	RightBumper:linkToElementModel(self, "BUTTON_RSHLDR.text", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			RightBumper.prompt:setText(Engine[0xF9F1239CFD921FE](f11_local0))
		end
	end)
	self:addElement(RightBumper)
	self.RightBumper = RightBumper
	local LeftTrigger = CoD.vhud_ButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 687, 816, 0, 0, 879.5, 1008.5)
	LeftTrigger:subscribeToGlobalModel(f1_arg1, "VehicleController", "left_trigger_button_image", function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			LeftTrigger.button0:setImage(RegisterImage(f12_local0))
		end
	end)
	LeftTrigger:subscribeToGlobalModel(f1_arg1, "VehicleController", "left_trigger_button_image", function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			LeftTrigger.button1:setImage(RegisterImage(f13_local0))
		end
	end)
	LeftTrigger:subscribeToGlobalModel(f1_arg1, "VehicleController", "left_trigger_button_image", function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			LeftTrigger.button:setImage(RegisterImage(f14_local0))
		end
	end)
	LeftTrigger:linkToElementModel(self, "BUTTON_LTRIG", false, function(model)
		LeftTrigger:setModel(model, f1_arg1)
	end)
	LeftTrigger:linkToElementModel(self, "BUTTON_LTRIG.text", true, function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			LeftTrigger.prompt:setText(Engine[0xF9F1239CFD921FE](f16_local0))
		end
	end)
	self:addElement(LeftTrigger)
	self.LeftTrigger = LeftTrigger
	local LeftBumper = CoD.vhud_ButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 687, 816, 0, 0, 750.5, 879.5)
	LeftBumper:subscribeToGlobalModel(f1_arg1, "VehicleController", "left_shoulder_button_image", function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			LeftBumper.button0:setImage(RegisterImage(f17_local0))
		end
	end)
	LeftBumper:subscribeToGlobalModel(f1_arg1, "VehicleController", "left_shoulder_button_image", function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			LeftBumper.button1:setImage(RegisterImage(f18_local0))
		end
	end)
	LeftBumper:subscribeToGlobalModel(f1_arg1, "VehicleController", "left_shoulder_button_image", function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			LeftBumper.button:setImage(RegisterImage(f19_local0))
		end
	end)
	LeftBumper:linkToElementModel(self, "BUTTON_LSHLDR", false, function(model)
		LeftBumper:setModel(model, f1_arg1)
	end)
	LeftBumper:linkToElementModel(self, "BUTTON_LSHLDR.text", true, function(model)
		local f21_local0 = model:get()
		if f21_local0 ~= nil then
			LeftBumper.prompt:setText(Engine[0xF9F1239CFD921FE](f21_local0))
		end
	end)
	self:addElement(LeftBumper)
	self.LeftBumper = LeftBumper
	local L3Button = CoD.vhud_ButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 89, 218, 0, 0, 759.5, 888.5)
	L3Button:subscribeToGlobalModel(f1_arg1, "VehicleController", "left_stick_button_image", function(model)
		local f22_local0 = model:get()
		if f22_local0 ~= nil then
			L3Button.button0:setImage(RegisterImage(f22_local0))
		end
	end)
	L3Button:subscribeToGlobalModel(f1_arg1, "VehicleController", "left_stick_button_image", function(model)
		local f23_local0 = model:get()
		if f23_local0 ~= nil then
			L3Button.button1:setImage(RegisterImage(f23_local0))
		end
	end)
	L3Button:subscribeToGlobalModel(f1_arg1, "VehicleController", "left_stick_button_image", function(model)
		local f24_local0 = model:get()
		if f24_local0 ~= nil then
			L3Button.button:setImage(RegisterImage(f24_local0))
		end
	end)
	L3Button:linkToElementModel(self, "BUTTON_LSTICK", false, function(model)
		L3Button:setModel(model, f1_arg1)
	end)
	L3Button:linkToElementModel(self, "BUTTON_LSTICK.text", true, function(model)
		local f26_local0 = model:get()
		if f26_local0 ~= nil then
			L3Button.prompt:setText(Engine[0xF9F1239CFD921FE](f26_local0))
		end
	end)
	self:addElement(L3Button)
	self.L3Button = L3Button
	local RightTrigger = CoD.vhud_ButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 1116.5, 1245.5, 0, 0, 879.5, 1008.5)
	RightTrigger:subscribeToGlobalModel(f1_arg1, "VehicleController", "right_trigger_button_image", function(model)
		local f27_local0 = model:get()
		if f27_local0 ~= nil then
			RightTrigger.button0:setImage(RegisterImage(f27_local0))
		end
	end)
	RightTrigger:subscribeToGlobalModel(f1_arg1, "VehicleController", "right_trigger_button_image", function(model)
		local f28_local0 = model:get()
		if f28_local0 ~= nil then
			RightTrigger.button1:setImage(RegisterImage(f28_local0))
		end
	end)
	RightTrigger:subscribeToGlobalModel(f1_arg1, "VehicleController", "right_trigger_button_image", function(model)
		local f29_local0 = model:get()
		if f29_local0 ~= nil then
			RightTrigger.button:setImage(RegisterImage(f29_local0))
		end
	end)
	RightTrigger:linkToElementModel(self, "BUTTON_RTRIG", false, function(model)
		RightTrigger:setModel(model, f1_arg1)
	end)
	RightTrigger:linkToElementModel(self, "BUTTON_RTRIG.text", true, function(model)
		local f31_local0 = model:get()
		if f31_local0 ~= nil then
			RightTrigger.prompt:setText(Engine[0xF9F1239CFD921FE](f31_local0))
		end
	end)
	self:addElement(RightTrigger)
	self.RightTrigger = RightTrigger
	local LeftBumper2 = CoD.vhud_ButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 895.5, 1024.5, 0, 0, 815, 944)
	LeftBumper2:subscribeToGlobalModel(f1_arg1, "VehicleController", "alt1_button_image", function(model)
		local f32_local0 = model:get()
		if f32_local0 ~= nil then
			LeftBumper2.button0:setImage(RegisterImage(f32_local0))
		end
	end)
	LeftBumper2:subscribeToGlobalModel(f1_arg1, "VehicleController", "alt1_button_image", function(model)
		local f33_local0 = model:get()
		if f33_local0 ~= nil then
			LeftBumper2.button1:setImage(RegisterImage(f33_local0))
		end
	end)
	LeftBumper2:subscribeToGlobalModel(f1_arg1, "VehicleController", "alt1_button_image", function(model)
		local f34_local0 = model:get()
		if f34_local0 ~= nil then
			LeftBumper2.button:setImage(RegisterImage(f34_local0))
		end
	end)
	LeftBumper2:linkToElementModel(self, "BUTTON_X", false, function(model)
		LeftBumper2:setModel(model, f1_arg1)
	end)
	LeftBumper2:linkToElementModel(self, "BUTTON_X.text", true, function(model)
		local f36_local0 = model:get()
		if f36_local0 ~= nil then
			LeftBumper2.prompt:setText(Engine[0xF9F1239CFD921FE](f36_local0))
		end
	end)
	self:addElement(LeftBumper2)
	self.LeftBumper2 = LeftBumper2
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_attack_helicopter_button_layout.__resetProperties = function(f37_arg0)
	f37_arg0.RightStick:completeAnimation()
	f37_arg0.RightTrigger:completeAnimation()
	f37_arg0.LeftTrigger:completeAnimation()
	f37_arg0.RightBumper:completeAnimation()
	f37_arg0.L3Button:completeAnimation()
	f37_arg0.LeftBumper:completeAnimation()
	f37_arg0.LeftBumper2:completeAnimation()
	f37_arg0.RightStick:setLeftRight(0, 0, 89, 218)
	f37_arg0.RightStick:setTopBottom(0, 0, 879.5, 1008.5)
	f37_arg0.RightTrigger:setLeftRight(0, 0, 1116.5, 1245.5)
	f37_arg0.RightTrigger:setTopBottom(0, 0, 879.5, 1008.5)
	f37_arg0.LeftTrigger:setLeftRight(0, 0, 687, 816)
	f37_arg0.LeftTrigger:setTopBottom(0, 0, 879.5, 1008.5)
	f37_arg0.RightBumper:setLeftRight(0, 0, 1116.5, 1245.5)
	f37_arg0.RightBumper:setTopBottom(0, 0, 750.5, 879.5)
	f37_arg0.L3Button:setLeftRight(0, 0, 89, 218)
	f37_arg0.L3Button:setTopBottom(0, 0, 759.5, 888.5)
	f37_arg0.LeftBumper:setLeftRight(0, 0, 687, 816)
	f37_arg0.LeftBumper:setTopBottom(0, 0, 750.5, 879.5)
	f37_arg0.LeftBumper2:setLeftRight(0, 0, 895.5, 1024.5)
	f37_arg0.LeftBumper2:setTopBottom(0, 0, 815, 944)
end
CoD.vhud_attack_helicopter_button_layout.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(7)
			f38_arg0.RightStick:completeAnimation()
			f38_arg0.RightStick:setLeftRight(0, 0, 95.5, 224.5)
			f38_arg0.RightStick:setTopBottom(0, 0, 888.5, 1017.5)
			f38_arg0.clipFinished(f38_arg0.RightStick)
			f38_arg0.RightBumper:completeAnimation()
			f38_arg0.RightBumper:setLeftRight(0, 0, 1160, 1289)
			f38_arg0.RightBumper:setTopBottom(0, 0, 759.5, 888.5)
			f38_arg0.clipFinished(f38_arg0.RightBumper)
			f38_arg0.LeftTrigger:completeAnimation()
			f38_arg0.LeftTrigger:setLeftRight(0, 0, 618.5, 747.5)
			f38_arg0.LeftTrigger:setTopBottom(0, 0, 888.5, 1017.5)
			f38_arg0.clipFinished(f38_arg0.LeftTrigger)
			f38_arg0.LeftBumper:completeAnimation()
			f38_arg0.LeftBumper:setLeftRight(0, 0, 618.5, 747.5)
			f38_arg0.LeftBumper:setTopBottom(0, 0, 759.5, 888.5)
			f38_arg0.clipFinished(f38_arg0.LeftBumper)
			f38_arg0.L3Button:completeAnimation()
			f38_arg0.L3Button:setLeftRight(0, 0, 95.5, 224.5)
			f38_arg0.L3Button:setTopBottom(0, 0, 759.5, 888.5)
			f38_arg0.clipFinished(f38_arg0.L3Button)
			f38_arg0.RightTrigger:completeAnimation()
			f38_arg0.RightTrigger:setLeftRight(0, 0, 1160, 1289)
			f38_arg0.RightTrigger:setTopBottom(0, 0, 888.5, 1017.5)
			f38_arg0.clipFinished(f38_arg0.RightTrigger)
			f38_arg0.LeftBumper2:completeAnimation()
			f38_arg0.LeftBumper2:setLeftRight(0, 0, 895.5, 1024.5)
			f38_arg0.LeftBumper2:setTopBottom(0, 0, 824, 953)
			f38_arg0.clipFinished(f38_arg0.LeftBumper2)
		end,
	},
}
CoD.vhud_attack_helicopter_button_layout.__onClose = function(f39_arg0)
	f39_arg0.vhudHellstormBGFrame:close()
	f39_arg0.RightStick:close()
	f39_arg0.RightBumper:close()
	f39_arg0.LeftTrigger:close()
	f39_arg0.LeftBumper:close()
	f39_arg0.L3Button:close()
	f39_arg0.RightTrigger:close()
	f39_arg0.LeftBumper2:close()
end
