require("x64:170db364cb58ba9")
CoD.CallingCards_Asset_truck = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_truck.__defaultWidth = 816
CoD.CallingCards_Asset_truck.__defaultHeight = 320
CoD.CallingCards_Asset_truck.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_truck)
	self.id = "CallingCards_Asset_truck"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local truck = LUI.UIImage.new(0, 0, 0, 816, 0, 0, 0, 320)
	truck:setImage(RegisterImage(0xD68A9E6AB7EB3DC))
	self:addElement(truck)
	self.truck = truck
	local wheel = CoD.CallingCards_Asset_TruckWheelAnimation.new(f1_arg0, f1_arg1, 0, 0, 131.5, 299.5, 0, 0, 222.5, 390.5)
	self:addElement(wheel)
	self.wheel = wheel
	local wheel2 = CoD.CallingCards_Asset_TruckWheelAnimation.new(f1_arg0, f1_arg1, 0, 0, 347.5, 515.5, 0, 0, 223.5, 391.5)
	self:addElement(wheel2)
	self.wheel2 = wheel2
	local wheel3 = CoD.CallingCards_Asset_TruckWheelAnimation.new(f1_arg0, f1_arg1, 0, 0, 697.5, 865.5, 0, 0, 229, 397)
	self:addElement(wheel3)
	self.wheel3 = wheel3
	local wheelShadow = LUI.UIImage.new(0, 0, 698.5, 866.5, 0, 0, 223.5, 391.5)
	wheelShadow:setImage(RegisterImage(0x84C1F7887EE61CF))
	wheelShadow:setMaterial(LUI.UIImage.GetCachedMaterial(0x655565C7B387234))
	self:addElement(wheelShadow)
	self.wheelShadow = wheelShadow
	local wheelShadow3 = LUI.UIImage.new(0, 0, 131.5, 299.5, 0, 0, 222.5, 390.5)
	wheelShadow3:setImage(RegisterImage(0x84C1F7887EE61CF))
	wheelShadow3:setMaterial(LUI.UIImage.GetCachedMaterial(0x655565C7B387234))
	self:addElement(wheelShadow3)
	self.wheelShadow3 = wheelShadow3
	local wheelShadow2 = LUI.UIImage.new(0, 0, 347.5, 515.5, 0, 0, 222.5, 390.5)
	wheelShadow2:setImage(RegisterImage(0x84C1F7887EE61CF))
	wheelShadow2:setMaterial(LUI.UIImage.GetCachedMaterial(0x655565C7B387234))
	self:addElement(wheelShadow2)
	self.wheelShadow2 = wheelShadow2
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_truck.__resetProperties = function(f2_arg0)
	f2_arg0.truck:completeAnimation()
	f2_arg0.wheel2:completeAnimation()
	f2_arg0.wheel3:completeAnimation()
	f2_arg0.wheel:completeAnimation()
	f2_arg0.wheelShadow:completeAnimation()
	f2_arg0.wheelShadow3:completeAnimation()
	f2_arg0.wheelShadow2:completeAnimation()
	f2_arg0.truck:setTopBottom(0, 0, 0, 320)
	f2_arg0.wheel2:setTopBottom(0, 0, 223.5, 391.5)
	f2_arg0.wheel3:setLeftRight(0, 0, 697.5, 865.5)
	f2_arg0.wheel3:setTopBottom(0, 0, 229, 397)
	f2_arg0.wheel:setTopBottom(0, 0, 222.5, 390.5)
	f2_arg0.wheelShadow:setLeftRight(0, 0, 698.5, 866.5)
	f2_arg0.wheelShadow:setTopBottom(0, 0, 223.5, 391.5)
	f2_arg0.wheelShadow3:setLeftRight(0, 0, 131.5, 299.5)
	f2_arg0.wheelShadow3:setTopBottom(0, 0, 222.5, 390.5)
	f2_arg0.wheelShadow2:setLeftRight(0, 0, 347.5, 515.5)
	f2_arg0.wheelShadow2:setTopBottom(0, 0, 222.5, 390.5)
end
CoD.CallingCards_Asset_truck.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(7)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(139)
					f5_arg0:setTopBottom(0, 0, 0, 320)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.truck:beginAnimation(150)
				f3_arg0.truck:setTopBottom(0, 0, 2, 322)
				f3_arg0.truck:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.truck:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.truck:completeAnimation()
			f3_arg0.truck:setTopBottom(0, 0, 0, 320)
			f3_local0(f3_arg0.truck)
			local f3_local1 = function(f6_arg0)
				f3_arg0.wheel:playClip("DefaultClip")
				f3_arg0.wheel:beginAnimation(160)
				f3_arg0.wheel:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.wheel:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("DefaultClip")
					f3_arg0.clipFinished(element, event)
				end)
			end
			f3_arg0.wheel:completeAnimation()
			f3_arg0.wheel:setTopBottom(0, 0, 230.5, 314.5)
			f3_local1(f3_arg0.wheel)
			local f3_local2 = function(f8_arg0)
				f3_arg0.wheel2:playClip("DefaultClip")
				f3_arg0.wheel2:beginAnimation(160)
				f3_arg0.wheel2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.wheel2:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("DefaultClip")
					f3_arg0.clipFinished(element, event)
				end)
			end
			f3_arg0.wheel2:completeAnimation()
			f3_arg0.wheel2:setTopBottom(0, 0, 230.5, 314.5)
			f3_local2(f3_arg0.wheel2)
			local f3_local3 = function(f10_arg0)
				f3_arg0.wheel3:playClip("DefaultClip")
				f3_arg0.wheel3:beginAnimation(160)
				f3_arg0.wheel3:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.wheel3:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("DefaultClip")
					f3_arg0.clipFinished(element, event)
				end)
			end
			f3_arg0.wheel3:completeAnimation()
			f3_arg0.wheel3:setLeftRight(0, 0, 660.5, 744.5)
			f3_arg0.wheel3:setTopBottom(0, 0, 228, 312)
			f3_local3(f3_arg0.wheel3)
			f3_arg0.wheelShadow:completeAnimation()
			f3_arg0.wheelShadow:setLeftRight(0, 0, 131.5, 299.5)
			f3_arg0.wheelShadow:setTopBottom(0, 0, 230.5, 398.5)
			f3_arg0.clipFinished(f3_arg0.wheelShadow)
			f3_arg0.wheelShadow3:completeAnimation()
			f3_arg0.wheelShadow3:setLeftRight(0, 0, 347.5, 515.5)
			f3_arg0.wheelShadow3:setTopBottom(0, 0, 228, 396)
			f3_arg0.clipFinished(f3_arg0.wheelShadow3)
			f3_arg0.wheelShadow2:completeAnimation()
			f3_arg0.wheelShadow2:setLeftRight(0, 0, 660.5, 828.5)
			f3_arg0.wheelShadow2:setTopBottom(0, 0, 228, 396)
			f3_arg0.clipFinished(f3_arg0.wheelShadow2)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.CallingCards_Asset_truck.__onClose = function(f12_arg0)
	f12_arg0.wheel:close()
	f12_arg0.wheel2:close()
	f12_arg0.wheel3:close()
end
