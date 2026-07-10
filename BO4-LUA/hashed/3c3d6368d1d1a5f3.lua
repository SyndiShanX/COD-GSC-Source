require("x64:22274b778e2450e")
CoD.BM_BountyBundleItem = InheritFrom(LUI.UIElement)
CoD.BM_BountyBundleItem.__defaultWidth = 100
CoD.BM_BountyBundleItem.__defaultHeight = 112
CoD.BM_BountyBundleItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BM_BountyBundleItem)
	self.id = "BM_BountyBundleItem"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BMBountyBundleItemInternal = CoD.BM_BountyBundleItemInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -50, 50, 0.5, 0.5, -56, 56)
	BMBountyBundleItemInternal:linkToElementModel(self, nil, false, function(model)
		BMBountyBundleItemInternal:setModel(model, f1_arg1)
	end)
	self:addElement(BMBountyBundleItemInternal)
	self.BMBountyBundleItemInternal = BMBountyBundleItemInternal
	local FrontendFrame01 = LUI.UIImage.new(0, 1, -3, 3, 0, 1, -1, 1)
	FrontendFrame01:setAlpha(0.4)
	FrontendFrame01:setImage(RegisterImage(@"uie_ui_menu_store_element_frame"))
	FrontendFrame01:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	FrontendFrame01:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame01:setupNineSliceShader(12, 164)
	self:addElement(FrontendFrame01)
	self.FrontendFrame01 = FrontendFrame01
	BMBountyBundleItemInternal.id = "BMBountyBundleItemInternal"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BM_BountyBundleItem.__resetProperties = function(f3_arg0)
	f3_arg0.FrontendFrame01:completeAnimation()
	f3_arg0.BMBountyBundleItemInternal:completeAnimation()
	f3_arg0.FrontendFrame01:setScale(1, 1)
	f3_arg0.BMBountyBundleItemInternal:setScale(1, 1)
end
CoD.BM_BountyBundleItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.BMBountyBundleItemInternal:completeAnimation()
			f5_arg0.BMBountyBundleItemInternal:setScale(1.06, 1.06)
			f5_arg0.clipFinished(f5_arg0.BMBountyBundleItemInternal)
			f5_arg0.FrontendFrame01:completeAnimation()
			f5_arg0.FrontendFrame01:setScale(1.06, 1.06)
			f5_arg0.clipFinished(f5_arg0.FrontendFrame01)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			local f6_local0 = function(f7_arg0)
				f6_arg0.BMBountyBundleItemInternal:beginAnimation(200)
				f6_arg0.BMBountyBundleItemInternal:setScale(1.06, 1.06)
				f6_arg0.BMBountyBundleItemInternal:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.BMBountyBundleItemInternal:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.BMBountyBundleItemInternal:completeAnimation()
			f6_arg0.BMBountyBundleItemInternal:setScale(1, 1)
			f6_local0(f6_arg0.BMBountyBundleItemInternal)
			local f6_local1 = function(f8_arg0)
				f6_arg0.FrontendFrame01:beginAnimation(200)
				f6_arg0.FrontendFrame01:setScale(1.06, 1.06)
				f6_arg0.FrontendFrame01:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.FrontendFrame01:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.FrontendFrame01:completeAnimation()
			f6_arg0.FrontendFrame01:setScale(1, 1)
			f6_local1(f6_arg0.FrontendFrame01)
		end,
		LoseChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			local f9_local0 = function(f10_arg0)
				f9_arg0.BMBountyBundleItemInternal:beginAnimation(200)
				f9_arg0.BMBountyBundleItemInternal:setScale(1, 1)
				f9_arg0.BMBountyBundleItemInternal:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.BMBountyBundleItemInternal:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.BMBountyBundleItemInternal:completeAnimation()
			f9_arg0.BMBountyBundleItemInternal:setScale(1.06, 1.06)
			f9_local0(f9_arg0.BMBountyBundleItemInternal)
			local f9_local1 = function(f11_arg0)
				f9_arg0.FrontendFrame01:beginAnimation(200)
				f9_arg0.FrontendFrame01:setScale(1, 1)
				f9_arg0.FrontendFrame01:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.FrontendFrame01:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.FrontendFrame01:completeAnimation()
			f9_arg0.FrontendFrame01:setScale(1.06, 1.06)
			f9_local1(f9_arg0.FrontendFrame01)
		end,
	},
}
CoD.BM_BountyBundleItem.__onClose = function(f12_arg0)
	f12_arg0.BMBountyBundleItemInternal:close()
end
