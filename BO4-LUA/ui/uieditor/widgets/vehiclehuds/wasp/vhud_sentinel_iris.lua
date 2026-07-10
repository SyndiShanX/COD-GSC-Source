require("x64:3f31dd4f77d0b44")
require("x64:2592480ec6fb20")
CoD.vhud_sentinel_iris = InheritFrom(LUI.UIElement)
CoD.vhud_sentinel_iris.__defaultWidth = 2527
CoD.vhud_sentinel_iris.__defaultHeight = 1425
CoD.vhud_sentinel_iris.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_sentinel_iris)
	self.id = "vhud_sentinel_iris"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local vignetteCenter = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	vignetteCenter:setAlpha(0.3)
	vignetteCenter:setImage(RegisterImage(0xEE4980C2A8CEA50))
	self:addElement(vignetteCenter)
	self.vignetteCenter = vignetteCenter
	local VignetteR1 = LUI.UIImage.new(1, 1, -870, -383, 0.5, 0.5, -540, 540)
	VignetteR1:setAlpha(0.15)
	VignetteR1:setImage(RegisterImage(0x3F022F57715FF56))
	self:addElement(VignetteR1)
	self.VignetteR1 = VignetteR1
	local VignetteL1 = LUI.UIImage.new(0, 0, 379, 866, 0.5, 0.5, -540, 540)
	VignetteL1:setAlpha(0.15)
	VignetteL1:setZRot(180)
	VignetteL1:setImage(RegisterImage(0x3F022F57715FF56))
	self:addElement(VignetteL1)
	self.VignetteL1 = VignetteL1
	local VignetteR2 = LUI.UIImage.new(1, 1, -835, -228, 0.5, 0.5, -673.5, 673.5)
	VignetteR2:setAlpha(0.5)
	VignetteR2:setImage(RegisterImage(0x3F022F57715FF56))
	self:addElement(VignetteR2)
	self.VignetteR2 = VignetteR2
	local VignetteL2 = LUI.UIImage.new(0, 0, 226, 833, 0.5, 0.5, -673.5, 673.5)
	VignetteL2:setAlpha(0.5)
	VignetteL2:setZRot(180)
	VignetteL2:setImage(RegisterImage(0x3F022F57715FF56))
	self:addElement(VignetteL2)
	self.VignetteL2 = VignetteL2
	local VignetteContainer = CoD.VehicleGround_VignetteContainer.new(f1_arg0, f1_arg1, 0, 1, 304, -304, 0, 1, 172, -172)
	VignetteContainer:setAlpha(0)
	self:addElement(VignetteContainer)
	self.VignetteContainer = VignetteContainer
	local VehicleGroundIris = CoD.VehicleGround_Iris.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	VehicleGroundIris:mergeStateConditions({
		{
			stateName = "Zoom",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "zoomed")
			end,
		},
	})
	VehicleGroundIris:linkToElementModel(VehicleGroundIris, "zoomed", true, function(model)
		f1_arg0:updateElementState(VehicleGroundIris, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "zoomed",
		})
	end)
	VehicleGroundIris:setRGB(1, 0.35, 0.35)
	VehicleGroundIris:setAlpha(0)
	VehicleGroundIris:linkToElementModel(self, nil, false, function(model)
		VehicleGroundIris:setModel(model, f1_arg1)
	end)
	VehicleGroundIris:registerEventHandler("menu_loaded", function(element, event)
		local f5_local0 = nil
		if element.menuLoaded then
			f5_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f5_local0 = element.super:menuLoaded(event)
		end
		PlayClipOnElement(self, {
			elementName = "VehicleGroundIris",
			clipName = "StartUp",
		}, f1_arg1)
		if not f5_local0 then
			f5_local0 = element:dispatchEventToChildren(event)
		end
		return f5_local0
	end)
	self:addElement(VehicleGroundIris)
	self.VehicleGroundIris = VehicleGroundIris
	self:mergeStateConditions({
		{
			stateName = "LeavingOperationZone_CP",
			condition = function(menu, element, event)
				return IsCampaign() and CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "outOfRange")
			end,
		},
		{
			stateName = "Campaign",
			condition = function(menu, element, event)
				return IsCampaign()
			end,
		},
	})
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[0x8DF2E5447F384B9]()
	f1_local9(f1_local8, f1_local10["lobbyRoot.lobbyNav"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	self:linkToElementModel(self, "outOfRange", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "outOfRange",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_sentinel_iris.__resetProperties = function(f10_arg0)
	f10_arg0.VehicleGroundIris:completeAnimation()
	f10_arg0.VignetteContainer:completeAnimation()
	f10_arg0.VignetteL2:completeAnimation()
	f10_arg0.VignetteR2:completeAnimation()
	f10_arg0.VignetteL1:completeAnimation()
	f10_arg0.VignetteR1:completeAnimation()
	f10_arg0.vignetteCenter:completeAnimation()
	f10_arg0.VehicleGroundIris:setAlpha(0)
	f10_arg0.VignetteContainer:setAlpha(0)
	f10_arg0.VignetteL2:setAlpha(0.5)
	f10_arg0.VignetteR2:setAlpha(0.5)
	f10_arg0.VignetteL1:setAlpha(0.15)
	f10_arg0.VignetteR1:setAlpha(0.15)
	f10_arg0.vignetteCenter:setAlpha(0.3)
end
CoD.vhud_sentinel_iris.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
	LeavingOperationZone_CP = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			local f12_local0 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					local f14_local0 = function(f15_arg0)
						f15_arg0:beginAnimation(590)
						f15_arg0:setAlpha(0.7)
						f15_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
					end
					f14_arg0:beginAnimation(919)
					f14_arg0:setAlpha(0.63)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
				end
				f12_arg0.VignetteContainer:beginAnimation(490)
				f12_arg0.VignetteContainer:setAlpha(0.8)
				f12_arg0.VignetteContainer:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.VignetteContainer:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f12_arg0.VignetteContainer:completeAnimation()
			f12_arg0.VignetteContainer:setAlpha(0.7)
			f12_local0(f12_arg0.VignetteContainer)
			local f12_local1 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					local f17_local0 = function(f18_arg0)
						local f18_local0 = function(f19_arg0)
							local f19_local0 = function(f20_arg0)
								local f20_local0 = function(f21_arg0)
									local f21_local0 = function(f22_arg0)
										f22_arg0:beginAnimation(460)
										f22_arg0:setAlpha(0.8)
										f22_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
									end
									f21_arg0:beginAnimation(49)
									f21_arg0:setAlpha(0.58)
									f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
								end
								f20_arg0:beginAnimation(180)
								f20_arg0:setAlpha(0.52)
								f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
							end
							f19_arg0:beginAnimation(209)
							f19_arg0:setAlpha(0.67)
							f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
						end
						f18_arg0:beginAnimation(420)
						f18_arg0:setAlpha(0.92)
						f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
					end
					f17_arg0:beginAnimation(60)
					f17_arg0:setAlpha(0.86)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
				end
				f12_arg0.VehicleGroundIris:beginAnimation(620)
				f12_arg0.VehicleGroundIris:setAlpha(0.59)
				f12_arg0.VehicleGroundIris:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.VehicleGroundIris:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f12_arg0.VehicleGroundIris:completeAnimation()
			f12_arg0.VehicleGroundIris:setAlpha(0.8)
			f12_local1(f12_arg0.VehicleGroundIris)
			f12_arg0.nextClip = "DefaultClip"
		end,
	},
	Campaign = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(7)
			f23_arg0.vignetteCenter:completeAnimation()
			f23_arg0.vignetteCenter:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.vignetteCenter)
			f23_arg0.VignetteR1:completeAnimation()
			f23_arg0.VignetteR1:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.VignetteR1)
			f23_arg0.VignetteL1:completeAnimation()
			f23_arg0.VignetteL1:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.VignetteL1)
			f23_arg0.VignetteR2:completeAnimation()
			f23_arg0.VignetteR2:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.VignetteR2)
			f23_arg0.VignetteL2:completeAnimation()
			f23_arg0.VignetteL2:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.VignetteL2)
			f23_arg0.VignetteContainer:completeAnimation()
			f23_arg0.VignetteContainer:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.VignetteContainer)
			f23_arg0.VehicleGroundIris:completeAnimation()
			f23_arg0.VehicleGroundIris:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.VehicleGroundIris)
		end,
	},
}
CoD.vhud_sentinel_iris.__onClose = function(f24_arg0)
	f24_arg0.VignetteContainer:close()
	f24_arg0.VehicleGroundIris:close()
end
