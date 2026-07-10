require("x64:f2d4920f28ccd3c")
CoD.MultiItemPickupWaypoint_NavigationPrompt = InheritFrom(LUI.UIElement)
CoD.MultiItemPickupWaypoint_NavigationPrompt.__defaultWidth = 64
CoD.MultiItemPickupWaypoint_NavigationPrompt.__defaultHeight = 64
CoD.MultiItemPickupWaypoint_NavigationPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MultiItemPickupWaypoint_NavigationPrompt)
	self.id = "MultiItemPickupWaypoint_NavigationPrompt"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BackingImage = LUI.UIImage.new(0.5, 0.5, -32, 32, 0.5, 0.5, -32, 32)
	BackingImage:setAlpha(0)
	BackingImage:subscribeToGlobalModel(f1_arg1, "Controller", "dpad_all_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			BackingImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(BackingImage)
	self.BackingImage = BackingImage
	local Backer2 = LUI.UIImage.new(0, 0, 0, 64, 0, 0, 0, 64)
	Backer2:setRGB(0, 0, 0)
	Backer2:setAlpha(0.9)
	Backer2:setImage(RegisterImage(0x30BBCD6E666199B))
	self:addElement(Backer2)
	self.Backer2 = Backer2
	local Backer = LUI.UIImage.new(0, 0, 0, 64, 0, 0, 0, 64)
	Backer:setImage(RegisterImage(0xBE388304168E99F))
	self:addElement(Backer)
	self.Backer = Backer
	local LeftImage = CoD.WarzoneDpadButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -32, 32, 0.5, 0.5, -32, 32)
	LeftImage:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	LeftImage:setZRot(90)
	self:addElement(LeftImage)
	self.LeftImage = LeftImage
	local RightImage = CoD.WarzoneDpadButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -32, 32, 0.5, 0.5, -32, 32)
	RightImage:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	RightImage:setZRot(270)
	self:addElement(RightImage)
	self.RightImage = RightImage
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MultiItemPickupWaypoint_NavigationPrompt.__resetProperties = function(f5_arg0)
	f5_arg0.RightImage:completeAnimation()
	f5_arg0.LeftImage:completeAnimation()
	f5_arg0.RightImage:setAlpha(1)
	f5_arg0.LeftImage:setAlpha(1)
end
CoD.MultiItemPickupWaypoint_NavigationPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	AtLeftAndRight = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.LeftImage:completeAnimation()
			f7_arg0.LeftImage:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.LeftImage)
			f7_arg0.RightImage:completeAnimation()
			f7_arg0.RightImage:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.RightImage)
		end,
	},
	AtLeft = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.LeftImage:completeAnimation()
			f8_arg0.LeftImage:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.LeftImage)
		end,
	},
	AtRight = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.RightImage:completeAnimation()
			f9_arg0.RightImage:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.RightImage)
		end,
	},
}
CoD.MultiItemPickupWaypoint_NavigationPrompt.__onClose = function(f10_arg0)
	f10_arg0.BackingImage:close()
	f10_arg0.LeftImage:close()
	f10_arg0.RightImage:close()
end
