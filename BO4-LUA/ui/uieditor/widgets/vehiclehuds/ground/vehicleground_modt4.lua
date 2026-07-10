CoD.VehicleGround_ModT4 = InheritFrom(LUI.UIElement)
CoD.VehicleGround_ModT4.__defaultWidth = 216
CoD.VehicleGround_ModT4.__defaultHeight = 54
CoD.VehicleGround_ModT4.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VehicleGround_ModT4)
	self.id = "VehicleGround_ModT4"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image3 = LUI.UIImage.new(0, 0, 0, 216, 0, 0, 0, 54)
	Image3:setImage(RegisterImage(0xE96BE34BB09996F))
	Image3:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Image3)
	self.Image3 = Image3
	local Image0 = LUI.UIImage.new(0, 0, 171, 183, 0, 0, 32, 44)
	Image0:setImage(RegisterImage(0xB0113AB62B1A835))
	Image0:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
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
CoD.VehicleGround_ModT4.__resetProperties = function(f4_arg0)
	f4_arg0.Image0:completeAnimation()
	f4_arg0.Image0:setLeftRight(0, 0, 171, 183)
	f4_arg0.Image0:setTopBottom(0, 0, 32, 44)
end
CoD.VehicleGround_ModT4.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					local f7_local0 = function(f8_arg0)
						local f8_local0 = function(f9_arg0)
							f9_arg0:beginAnimation(1990, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
							f9_arg0:setLeftRight(0, 0, 196, 208)
							f9_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
						end
						f8_arg0:beginAnimation(1219)
						f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
					end
					f7_arg0:beginAnimation(2490, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f7_arg0:setLeftRight(0, 0, 45, 57)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
				end
				f5_arg0.Image0:beginAnimation(890)
				f5_arg0.Image0:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Image0:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f5_arg0.Image0:completeAnimation()
			f5_arg0.Image0:setLeftRight(0, 0, 196, 208)
			f5_arg0.Image0:setTopBottom(0, 0, 32, 44)
			f5_local0(f5_arg0.Image0)
			f5_arg0.nextClip = "DefaultClip"
		end,
	},
	Hidden = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
}
