require("x64:5dc196423ca9dab")
require("x64:df022301c770a0b")
CoD.genericVHUD3MissileCounter = InheritFrom(LUI.UIElement)
CoD.genericVHUD3MissileCounter.__defaultWidth = 190
CoD.genericVHUD3MissileCounter.__defaultHeight = 140
CoD.genericVHUD3MissileCounter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.genericVHUD3MissileCounter)
	self.id = "genericVHUD3MissileCounter"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local vhudagrNotificationMissiles = CoD.vhud_agr_NotificationMissiles.new(f1_arg0, f1_arg1, 0.5, 0.5, -95, 95, 0, 0, -25, 110)
	vhudagrNotificationMissiles:linkToElementModel(self, nil, false, function(model)
		vhudagrNotificationMissiles:setModel(model, f1_arg1)
	end)
	self:addElement(vhudagrNotificationMissiles)
	self.vhudagrNotificationMissiles = vhudagrNotificationMissiles
	local vhudagrNotificationBox0 = CoD.vhud_agr_NotificationBox.new(f1_arg0, f1_arg1, 0.5, 0.5, -61, 61, 0, 0, 92.5, 137.5)
	vhudagrNotificationBox0:setYRot(-50)
	vhudagrNotificationBox0:linkToElementModel(self, "rocketTitle", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			vhudagrNotificationBox0.text:setText(f3_local0)
		end
	end)
	self:addElement(vhudagrNotificationBox0)
	self.vhudagrNotificationBox0 = vhudagrNotificationBox0
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f4_arg2, f4_arg3, f4_arg4)
		if IsSelfInState(self, "Invisible") then
			SetHeight(self, 0)
		else
			RestoreWidgetHeight(self)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.genericVHUD3MissileCounter.__resetProperties = function(f5_arg0)
	f5_arg0.vhudagrNotificationBox0:completeAnimation()
	f5_arg0.vhudagrNotificationMissiles:completeAnimation()
	f5_arg0.vhudagrNotificationBox0:setAlpha(1)
	f5_arg0.vhudagrNotificationMissiles:setAlpha(1)
end
CoD.genericVHUD3MissileCounter.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	Invisible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.vhudagrNotificationMissiles:completeAnimation()
			f7_arg0.vhudagrNotificationMissiles:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.vhudagrNotificationMissiles)
			f7_arg0.vhudagrNotificationBox0:completeAnimation()
			f7_arg0.vhudagrNotificationBox0:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.vhudagrNotificationBox0)
		end,
	},
}
CoD.genericVHUD3MissileCounter.__onClose = function(f8_arg0)
	f8_arg0.vhudagrNotificationMissiles:close()
	f8_arg0.vhudagrNotificationBox0:close()
end
