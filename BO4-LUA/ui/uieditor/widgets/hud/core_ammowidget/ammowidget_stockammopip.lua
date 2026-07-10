require("x64:fd51e83e2e6dbd1")
CoD.AmmoWidget_StockAmmoPip = InheritFrom(LUI.UIElement)
CoD.AmmoWidget_StockAmmoPip.__defaultWidth = 20
CoD.AmmoWidget_StockAmmoPip.__defaultHeight = 60
CoD.AmmoWidget_StockAmmoPip.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidget_StockAmmoPip)
	self.id = "AmmoWidget_StockAmmoPip"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GlowLeak = LUI.UIImage.new(0, 0, -1, 20, 0, 0, 20, 92)
	GlowLeak:setRGB(0.76, 0.76, 0.73)
	GlowLeak:setAlpha(0.2)
	GlowLeak:setImage(RegisterImage(@"hash_1DA3FD465AC2534"))
	GlowLeak:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta"))
	GlowLeak:setShaderVector(0, 0, 1, 0, 0)
	GlowLeak:setShaderVector(1, 0, 0, 0, 0)
	GlowLeak:setShaderVector(2, 0, 1, 0, 0)
	GlowLeak:setShaderVector(3, 0, 0, 0, 0)
	GlowLeak:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(GlowLeak)
	self.GlowLeak = GlowLeak
	local base = LUI.UIImage.new(0, 0, -2, 22, 1, 1, -29, 3)
	base:setRGB(0.81, 0.79, 0.69)
	base:setImage(RegisterImage(@"hash_7CEDA89781162E4B"))
	base:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	base:setShaderVector(0, 0, 1, 0, 0)
	base:setShaderVector(1, 0, 0, 0, 0)
	base:setShaderVector(3, 0, 0, 0, 0)
	base:setShaderVector(4, 0, 0, 0, 0)
	base:linkToElementModel(self, "percentage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			base:setShaderVector(2, AddToVector(0.12, 1, 0, 0, ScaleVector(0.7, SubtractVectorComponentFrom(1, 1, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4)))))
		end
	end)
	self:addElement(base)
	self.base = base
	local GlowOuter = LUI.UIImage.new(0, 0, -2, 22, 0, 0, 31, 63)
	GlowOuter:setRGB(0.76, 0.76, 0.73)
	GlowOuter:setAlpha(0)
	GlowOuter:setImage(RegisterImage(@"hash_5E48B57FD16FAD2D"))
	GlowOuter:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta"))
	GlowOuter:setShaderVector(0, 0, 1, 0, 0)
	GlowOuter:setShaderVector(1, 0, 0, 0, 0)
	GlowOuter:setShaderVector(2, 0, 1, 0, 0)
	GlowOuter:setShaderVector(3, 0, 0, 0, 0)
	GlowOuter:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(GlowOuter)
	self.GlowOuter = GlowOuter
	local plusIcon = CoD.onOffImage.new(f1_arg0, f1_arg1, 0, 0, 16, 32, 0, 0, 38.5, 55.5)
	plusIcon:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "hasExtra")
			end,
		},
	})
	plusIcon:linkToElementModel(plusIcon, "hasExtra", true, function(model)
		f1_arg0:updateElementState(plusIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "hasExtra",
		})
	end)
	plusIcon:setScale(2, 2)
	plusIcon:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"uie_saturation_normal"))
	plusIcon:setShaderVector(0, 0, 0, 0, 0)
	plusIcon.image:setImage(RegisterImage(0x1CCD6B7B2BDAC2))
	plusIcon:linkToElementModel(self, nil, false, function(model)
		plusIcon:setModel(model, f1_arg1)
	end)
	self:addElement(plusIcon)
	self.plusIcon = plusIcon
	self:mergeStateConditions({
		{
			stateName = "Dropped",
			condition = function(menu, element, event)
				return CoD.HUDUtility.EnterClipDropState(self, f1_arg1)
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.weaponReloadState, function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "weaponReloadState",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidget_StockAmmoPip.__resetProperties = function(f8_arg0)
	f8_arg0.GlowOuter:completeAnimation()
	f8_arg0.base:completeAnimation()
	f8_arg0.GlowLeak:completeAnimation()
	f8_arg0.GlowOuter:setTopBottom(0, 0, 31, 63)
	f8_arg0.GlowOuter:setAlpha(0)
	f8_arg0.base:setTopBottom(1, 1, -29, 3)
	f8_arg0.base:setAlpha(1)
	f8_arg0.GlowLeak:setTopBottom(0, 0, 20, 92)
	f8_arg0.GlowLeak:setAlpha(0.2)
end
CoD.AmmoWidget_StockAmmoPip.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
		Dropped = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			local f10_local0 = function(f11_arg0)
				f10_arg0.GlowLeak:beginAnimation(200)
				f10_arg0.GlowLeak:setTopBottom(0, 0, 72, 144)
				f10_arg0.GlowLeak:setAlpha(0)
				f10_arg0.GlowLeak:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.GlowLeak:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.GlowLeak:completeAnimation()
			f10_arg0.GlowLeak:setTopBottom(0, 0, 20, 92)
			f10_arg0.GlowLeak:setAlpha(0.42)
			f10_local0(f10_arg0.GlowLeak)
			local f10_local1 = function(f12_arg0)
				f10_arg0.base:beginAnimation(200)
				f10_arg0.base:setTopBottom(1, 1, 23, 55)
				f10_arg0.base:setAlpha(0)
				f10_arg0.base:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.base:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.base:completeAnimation()
			f10_arg0.base:setTopBottom(1, 1, -29, 3)
			f10_arg0.base:setAlpha(1)
			f10_local1(f10_arg0.base)
			local f10_local2 = function(f13_arg0)
				f10_arg0.GlowOuter:beginAnimation(200)
				f10_arg0.GlowOuter:setTopBottom(0, 0, 83, 115)
				f10_arg0.GlowOuter:setAlpha(0)
				f10_arg0.GlowOuter:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.GlowOuter:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.GlowOuter:completeAnimation()
			f10_arg0.GlowOuter:setTopBottom(0, 0, 31, 63)
			f10_arg0.GlowOuter:setAlpha(0.7)
			f10_local2(f10_arg0.GlowOuter)
		end,
	},
	Dropped = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(3)
			f14_arg0.GlowLeak:completeAnimation()
			f14_arg0.GlowLeak:setTopBottom(0, 0, 72, 144)
			f14_arg0.GlowLeak:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.GlowLeak)
			f14_arg0.base:completeAnimation()
			f14_arg0.base:setTopBottom(1, 1, 23, 55)
			f14_arg0.base:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.base)
			f14_arg0.GlowOuter:completeAnimation()
			f14_arg0.GlowOuter:setTopBottom(0, 0, 83, 115)
			f14_arg0.GlowOuter:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.GlowOuter)
		end,
		DefaultState = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(3)
			local f15_local0 = function(f16_arg0)
				f15_arg0.GlowLeak:beginAnimation(200)
				f15_arg0.GlowLeak:setTopBottom(0, 0, 20, 92)
				f15_arg0.GlowLeak:setAlpha(0.42)
				f15_arg0.GlowLeak:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.GlowLeak:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.GlowLeak:completeAnimation()
			f15_arg0.GlowLeak:setTopBottom(0, 0, 72, 144)
			f15_arg0.GlowLeak:setAlpha(0)
			f15_local0(f15_arg0.GlowLeak)
			local f15_local1 = function(f17_arg0)
				f15_arg0.base:beginAnimation(200)
				f15_arg0.base:setTopBottom(1, 1, -29, 3)
				f15_arg0.base:setAlpha(1)
				f15_arg0.base:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.base:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.base:completeAnimation()
			f15_arg0.base:setTopBottom(1, 1, 23, 55)
			f15_arg0.base:setAlpha(0)
			f15_local1(f15_arg0.base)
			local f15_local2 = function(f18_arg0)
				f15_arg0.GlowOuter:beginAnimation(200)
				f15_arg0.GlowOuter:setTopBottom(0, 0, 31, 63)
				f15_arg0.GlowOuter:setAlpha(0.7)
				f15_arg0.GlowOuter:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.GlowOuter:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.GlowOuter:completeAnimation()
			f15_arg0.GlowOuter:setTopBottom(0, 0, 83, 115)
			f15_arg0.GlowOuter:setAlpha(0)
			f15_local2(f15_arg0.GlowOuter)
		end,
	},
}
CoD.AmmoWidget_StockAmmoPip.__onClose = function(f19_arg0)
	f19_arg0.base:close()
	f19_arg0.plusIcon:close()
end
