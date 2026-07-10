CoD.scavenger_icon = InheritFrom(CoD.Menu)
LUI.createMenu.scavenger_icon = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("scavenger_icon", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.scavenger_icon)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local image = LUI.UIImage.new(0.5, 0.5, -64, 64, 0.5, 0.5, 96, 224)
	image:setImage(RegisterImage(0xF91C2729FC1ACCA))
	self:addElement(image)
	self.image = image
	self:linkToElementModel(self, "pulse", true, function(model)
		local f2_local0 = self
		if MenuPropertyIsTrue(f1_local1, "__loaded") then
			PlayClip(self, "Pulse", f1_arg0)
		end
	end)
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.scavenger_icon.__resetProperties = function(f3_arg0)
	f3_arg0.image:completeAnimation()
	f3_arg0.image:setLeftRight(0.5, 0.5, -64, 64)
	f3_arg0.image:setTopBottom(0.5, 0.5, 96, 224)
	f3_arg0.image:setAlpha(1)
end
CoD.scavenger_icon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.image:completeAnimation()
			f4_arg0.image:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.image)
		end,
		Pulse = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				f5_arg0.image:beginAnimation(1000)
				f5_arg0.image:setAlpha(0)
				f5_arg0.image:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.image:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.image:completeAnimation()
			f5_arg0.image:setLeftRight(0.5, 0.5, -64, 64)
			f5_arg0.image:setTopBottom(0.5, 0.5, 95, 223)
			f5_arg0.image:setAlpha(1)
			f5_local0(f5_arg0.image)
		end,
	},
}
CoD.scavenger_icon.__onClose = function(f7_arg0) end
