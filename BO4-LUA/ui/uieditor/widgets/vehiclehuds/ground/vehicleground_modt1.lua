CoD.VehicleGround_ModT1 = InheritFrom(LUI.UIElement)
CoD.VehicleGround_ModT1.__defaultWidth = 72
CoD.VehicleGround_ModT1.__defaultHeight = 54
CoD.VehicleGround_ModT1.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VehicleGround_ModT1)
	self.id = "VehicleGround_ModT1"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image4 = LUI.UIImage.new(0, 0, 0, 72, 0, 0, 0, 54)
	Image4:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_ground_modulest1"))
	Image4:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Image4)
	self.Image4 = Image4
	local Image0 = LUI.UIImage.new(0, 0, 18, 30, 0, 0, 32, 44)
	Image0:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_ground_modulespixel"))
	Image0:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Image0)
	self.Image0 = Image0
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return HideVehicleReticle(self, f1_arg1, event)
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = DataSources.VehicleInfo.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.vehicleType, function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "vehicleType",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.VehicleGround_ModT1.__resetProperties = function(f4_arg0)
	f4_arg0.Image0:completeAnimation()
	f4_arg0.Image0:setAlpha(1)
end
CoD.VehicleGround_ModT1.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					local f7_local0 = function(f8_arg0)
						f8_arg0:beginAnimation(90)
						f8_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
					end
					f7_arg0:beginAnimation(9)
					f7_arg0:setAlpha(0)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
				end
				f5_arg0.Image0:beginAnimation(100)
				f5_arg0.Image0:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Image0:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f5_arg0.Image0:completeAnimation()
			f5_arg0.Image0:setAlpha(1)
			f5_local0(f5_arg0.Image0)
			f5_arg0.nextClip = "DefaultClip"
		end,
	},
	Hidden = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
}
