CoD.vhud_sentinel_CenterReticle = InheritFrom(LUI.UIElement)
CoD.vhud_sentinel_CenterReticle.__defaultWidth = 60
CoD.vhud_sentinel_CenterReticle.__defaultHeight = 36
CoD.vhud_sentinel_CenterReticle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_sentinel_CenterReticle)
	self.id = "vhud_sentinel_CenterReticle"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CenterReticle = LUI.UIImage.new(0.5, 0.5, -30, 30, 0.5, 0.5, -18, 18)
	CenterReticle:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_wasp_centerreticlecircle"))
	CenterReticle:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(CenterReticle)
	self.CenterReticle = CenterReticle
	local CenterReticle0 = LUI.UIImage.new(0.5, 0.5, -30, 30, 0.5, 0.5, -18, 18)
	CenterReticle0:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_wasp_centerreticlecircle"))
	CenterReticle0:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(CenterReticle0)
	self.CenterReticle0 = CenterReticle0
	self:mergeStateConditions({
		{
			stateName = "RAPS",
			condition = function(menu, element, event)
				return IsCampaign() and IsVehicleOfType(f1_arg1, "raps")
			end,
		},
		{
			stateName = "Zoom",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "zoomed")
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[@"getglobalmodel"]()
	f1_local4(f1_local3, f1_local5["lobbyRoot.lobbyNav"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = DataSources.VehicleInfo.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.vehicleType, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "vehicleType",
		})
	end, false)
	self:linkToElementModel(self, "zoomed", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "zoomed",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_sentinel_CenterReticle.__resetProperties = function(f7_arg0)
	f7_arg0.CenterReticle:completeAnimation()
	f7_arg0.CenterReticle0:completeAnimation()
	f7_arg0.CenterReticle:setLeftRight(0.5, 0.5, -30, 30)
	f7_arg0.CenterReticle:setTopBottom(0.5, 0.5, -18, 18)
	f7_arg0.CenterReticle:setAlpha(1)
	f7_arg0.CenterReticle:setZoom(0)
	f7_arg0.CenterReticle0:setLeftRight(0.5, 0.5, -30, 30)
	f7_arg0.CenterReticle0:setTopBottom(0.5, 0.5, -18, 18)
	f7_arg0.CenterReticle0:setAlpha(1)
	f7_arg0.CenterReticle0:setZoom(0)
	f7_arg0.CenterReticle0:setScale(1, 1)
end
CoD.vhud_sentinel_CenterReticle.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
		StartUp = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			local f9_local0 = function(f10_arg0)
				f10_arg0:beginAnimation(99)
				f10_arg0:setAlpha(1)
				f10_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.CenterReticle:beginAnimation(400)
			f9_arg0.CenterReticle:setAlpha(0)
			f9_arg0.CenterReticle:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
			f9_arg0.CenterReticle:registerEventHandler("transition_complete_keyframe", f9_local0)
			local f9_local1 = function(f11_arg0)
				f11_arg0:beginAnimation(99)
				f11_arg0:setAlpha(1)
				f11_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.CenterReticle0:beginAnimation(400)
			f9_arg0.CenterReticle0:setAlpha(0)
			f9_arg0.CenterReticle0:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
			f9_arg0.CenterReticle0:registerEventHandler("transition_complete_keyframe", f9_local1)
		end,
		Zoom = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			local f12_local0 = function(f13_arg0)
				f12_arg0.CenterReticle:beginAnimation(200)
				f12_arg0.CenterReticle:setZoom(-400)
				f12_arg0.CenterReticle:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.CenterReticle:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.CenterReticle:completeAnimation()
			f12_arg0.CenterReticle:setZoom(0)
			f12_local0(f12_arg0.CenterReticle)
			local f12_local1 = function(f14_arg0)
				f12_arg0.CenterReticle0:beginAnimation(200)
				f12_arg0.CenterReticle0:setZoom(-400)
				f12_arg0.CenterReticle0:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.CenterReticle0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.CenterReticle0:completeAnimation()
			f12_arg0.CenterReticle0:setZoom(0)
			f12_local1(f12_arg0.CenterReticle0)
		end,
	},
	RAPS = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.CenterReticle:completeAnimation()
			f15_arg0.CenterReticle:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.CenterReticle)
			f15_arg0.CenterReticle0:completeAnimation()
			f15_arg0.CenterReticle0:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.CenterReticle0)
		end,
	},
	Zoom = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.CenterReticle:completeAnimation()
			f16_arg0.CenterReticle:setLeftRight(0.5, 0.5, -29, 31)
			f16_arg0.CenterReticle:setTopBottom(0.5, 0.5, -18, 18)
			f16_arg0.CenterReticle:setZoom(-400)
			f16_arg0.clipFinished(f16_arg0.CenterReticle)
			f16_arg0.CenterReticle0:completeAnimation()
			f16_arg0.CenterReticle0:setLeftRight(0.5, 0.5, -29, 31)
			f16_arg0.CenterReticle0:setTopBottom(0.5, 0.5, -18, 18)
			f16_arg0.CenterReticle0:setZoom(-400)
			f16_arg0.clipFinished(f16_arg0.CenterReticle0)
		end,
		DefaultState = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			local f17_local0 = function(f18_arg0)
				f17_arg0.CenterReticle:beginAnimation(200)
				f17_arg0.CenterReticle:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.CenterReticle:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.CenterReticle:completeAnimation()
			f17_arg0.CenterReticle:setLeftRight(0.5, 0.5, -29, 31)
			f17_arg0.CenterReticle:setTopBottom(0.5, 0.5, -18, 18)
			f17_arg0.CenterReticle:setZoom(-400)
			f17_local0(f17_arg0.CenterReticle)
			local f17_local1 = function(f19_arg0)
				f17_arg0.CenterReticle0:beginAnimation(200)
				f17_arg0.CenterReticle0:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.CenterReticle0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.CenterReticle0:completeAnimation()
			f17_arg0.CenterReticle0:setLeftRight(0.5, 0.5, -29, 31)
			f17_arg0.CenterReticle0:setTopBottom(0.5, 0.5, -18, 18)
			f17_arg0.CenterReticle0:setZoom(-400)
			f17_arg0.CenterReticle0:setScale(1, 1)
			f17_local1(f17_arg0.CenterReticle0)
		end,
	},
}
