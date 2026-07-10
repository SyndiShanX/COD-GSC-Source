require("x64:f6482b855bfca9f")
require("x64:5f8cf56752aa71b")
require("x64:19c1945d2e472b0")
CoD.CamoFilterButton = InheritFrom(LUI.UIElement)
CoD.CamoFilterButton.__defaultWidth = 250
CoD.CamoFilterButton.__defaultHeight = 69
CoD.CamoFilterButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CamoFilterButton)
	self.id = "CamoFilterButton"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setRGB(0, 0, 0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	SceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local BlackBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlackBacking:setRGB(0, 0, 0)
	BlackBacking:setAlpha(0.9)
	self:addElement(BlackBacking)
	self.BlackBacking = BlackBacking
	local TiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TiledBacking:setAlpha(0.5)
	TiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	TiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking:setupNineSliceShader(196, 88)
	self:addElement(TiledBacking)
	self.TiledBacking = TiledBacking
	local TiledBackingAdd = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TiledBackingAdd:setAlpha(0)
	TiledBackingAdd:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	TiledBackingAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	TiledBackingAdd:setShaderVector(0, 0, 0, 0, 0)
	TiledBackingAdd:setupNineSliceShader(196, 88)
	self:addElement(TiledBackingAdd)
	self.TiledBackingAdd = TiledBackingAdd
	local StoreCommonTextBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 6, -4, 0, 1, 7, -5)
	StoreCommonTextBacking:setAlpha(0.4)
	StoreCommonTextBacking.TiledShaderImage:setupNineSliceShader(42, 42)
	self:addElement(StoreCommonTextBacking)
	self.StoreCommonTextBacking = StoreCommonTextBacking
	local SelectionOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SelectionOverlay:setAlpha(0.01)
	self:addElement(SelectionOverlay)
	self.SelectionOverlay = SelectionOverlay
	local BracketL = LUI.UIImage.new(1, 1, -105.5, -97.5, 0.5, 0.5, -10.5, 13.5)
	BracketL:setAlpha(0)
	BracketL:setImage(RegisterImage(@"hash_6AA0A70F33D3978"))
	BracketL:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(BracketL)
	self.BracketL = BracketL
	local BracketR = LUI.UIImage.new(1, 1, -29.5, -21.5, 0.5, 0.5, -11.5, 12.5)
	BracketR:setAlpha(0)
	BracketR:setZRot(180)
	BracketR:setImage(RegisterImage(@"hash_6AA0A70F33D3978"))
	BracketR:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(BracketR)
	self.BracketR = BracketR
	local ItemName = LUI.UIText.new(0, 0, 20, 243, 0.5, 0.5, -12, 12)
	ItemName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ItemName:setTTF("ttmussels_demibold")
	ItemName:setLetterSpacing(4)
	ItemName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ItemName:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	ItemName:linkToElementModel(self, "name", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ItemName:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	self:addElement(ItemName)
	self.ItemName = ItemName
	local ButtonFrame = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(ButtonFrame)
	self.ButtonFrame = ButtonFrame
	local NewBreadcrumb = CoD.NewBreadcrumb.new(f1_arg0, f1_arg1, 0, 0, 250, 280, 0, 0, 20, 50)
	NewBreadcrumb:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "breadcrumbCount", 0) and CoD.CACUtility.IsProgressionWithWarzoneEnabledForMenu(menu)
			end,
		},
	})
	NewBreadcrumb:linkToElementModel(NewBreadcrumb, "breadcrumbCount", true, function(model)
		f1_arg0:updateElementState(NewBreadcrumb, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "breadcrumbCount",
		})
	end)
	NewBreadcrumb:linkToElementModel(self, "breadcrumb", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			NewBreadcrumb:setModel(f5_local0, f1_arg1)
		end
	end)
	self:addElement(NewBreadcrumb)
	self.NewBreadcrumb = NewBreadcrumb
	ButtonFrame.id = "ButtonFrame"
	self.__defaultFocus = ButtonFrame
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CamoFilterButton.__resetProperties = function(f6_arg0)
	f6_arg0.ItemName:completeAnimation()
	f6_arg0.SelectionOverlay:completeAnimation()
	f6_arg0.StoreCommonTextBacking:completeAnimation()
	f6_arg0.ButtonFrame:completeAnimation()
	f6_arg0.ItemName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f6_arg0.SelectionOverlay:setAlpha(0.01)
	f6_arg0.StoreCommonTextBacking:setRGB(1, 1, 1)
	f6_arg0.StoreCommonTextBacking:setAlpha(0.4)
	f6_arg0.ButtonFrame:setAlpha(1)
end
CoD.CamoFilterButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			f8_arg0.StoreCommonTextBacking:completeAnimation()
			f8_arg0.StoreCommonTextBacking:setRGB(1, 0.68, 0.12)
			f8_arg0.StoreCommonTextBacking:setAlpha(0.6)
			f8_arg0.clipFinished(f8_arg0.StoreCommonTextBacking)
			f8_arg0.SelectionOverlay:completeAnimation()
			f8_arg0.SelectionOverlay:setAlpha(0.03)
			f8_arg0.clipFinished(f8_arg0.SelectionOverlay)
			f8_arg0.ItemName:completeAnimation()
			f8_arg0.ItemName:setRGB(0.92, 0.89, 0.72)
			f8_arg0.clipFinished(f8_arg0.ItemName)
		end,
		GainChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			local f9_local0 = function(f10_arg0)
				f9_arg0.StoreCommonTextBacking:beginAnimation(100)
				f9_arg0.StoreCommonTextBacking:setRGB(0.92, 0.61, 0.08)
				f9_arg0.StoreCommonTextBacking:setAlpha(0.6)
				f9_arg0.StoreCommonTextBacking:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.StoreCommonTextBacking:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.StoreCommonTextBacking:completeAnimation()
			f9_arg0.StoreCommonTextBacking:setRGB(1, 1, 1)
			f9_arg0.StoreCommonTextBacking:setAlpha(0.4)
			f9_local0(f9_arg0.StoreCommonTextBacking)
			local f9_local1 = function(f11_arg0)
				f9_arg0.SelectionOverlay:beginAnimation(100)
				f9_arg0.SelectionOverlay:setAlpha(0.03)
				f9_arg0.SelectionOverlay:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.SelectionOverlay:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.SelectionOverlay:completeAnimation()
			f9_arg0.SelectionOverlay:setAlpha(0.01)
			f9_local1(f9_arg0.SelectionOverlay)
			local f9_local2 = function(f12_arg0)
				f9_arg0.ItemName:beginAnimation(100)
				f9_arg0.ItemName:setRGB(0.92, 0.89, 0.72)
				f9_arg0.ItemName:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.ItemName:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.ItemName:completeAnimation()
			f9_arg0.ItemName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f9_local2(f9_arg0.ItemName)
		end,
		LoseChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			local f13_local0 = function(f14_arg0)
				f13_arg0.StoreCommonTextBacking:beginAnimation(100)
				f13_arg0.StoreCommonTextBacking:setRGB(1, 1, 1)
				f13_arg0.StoreCommonTextBacking:setAlpha(0.4)
				f13_arg0.StoreCommonTextBacking:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.StoreCommonTextBacking:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.StoreCommonTextBacking:completeAnimation()
			f13_arg0.StoreCommonTextBacking:setRGB(0.92, 0.61, 0.08)
			f13_arg0.StoreCommonTextBacking:setAlpha(0.6)
			f13_local0(f13_arg0.StoreCommonTextBacking)
			local f13_local1 = function(f15_arg0)
				f13_arg0.SelectionOverlay:beginAnimation(100)
				f13_arg0.SelectionOverlay:setAlpha(0.01)
				f13_arg0.SelectionOverlay:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.SelectionOverlay:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.SelectionOverlay:completeAnimation()
			f13_arg0.SelectionOverlay:setAlpha(0.03)
			f13_local1(f13_arg0.SelectionOverlay)
			local f13_local2 = function(f16_arg0)
				f13_arg0.ItemName:beginAnimation(100)
				f13_arg0.ItemName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
				f13_arg0.ItemName:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.ItemName:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.ItemName:completeAnimation()
			f13_arg0.ItemName:setRGB(0.92, 0.89, 0.72)
			f13_local2(f13_arg0.ItemName)
		end,
		Active = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.ButtonFrame:completeAnimation()
			f17_arg0.ButtonFrame:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.ButtonFrame)
		end,
		ActiveAndChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			f18_arg0.StoreCommonTextBacking:completeAnimation()
			f18_arg0.StoreCommonTextBacking:setRGB(1, 0.68, 0.12)
			f18_arg0.StoreCommonTextBacking:setAlpha(0.6)
			f18_arg0.clipFinished(f18_arg0.StoreCommonTextBacking)
			f18_arg0.SelectionOverlay:completeAnimation()
			f18_arg0.SelectionOverlay:setAlpha(0.03)
			f18_arg0.clipFinished(f18_arg0.SelectionOverlay)
			f18_arg0.ItemName:completeAnimation()
			f18_arg0.ItemName:setRGB(0.92, 0.89, 0.72)
			f18_arg0.clipFinished(f18_arg0.ItemName)
		end,
		ActiveToActiveAndChildFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(4)
			local f19_local0 = function(f20_arg0)
				f19_arg0.StoreCommonTextBacking:beginAnimation(100)
				f19_arg0.StoreCommonTextBacking:setRGB(1, 0.68, 0.12)
				f19_arg0.StoreCommonTextBacking:setAlpha(0.6)
				f19_arg0.StoreCommonTextBacking:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.StoreCommonTextBacking:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.StoreCommonTextBacking:completeAnimation()
			f19_arg0.StoreCommonTextBacking:setRGB(1, 1, 1)
			f19_arg0.StoreCommonTextBacking:setAlpha(0.4)
			f19_local0(f19_arg0.StoreCommonTextBacking)
			local f19_local1 = function(f21_arg0)
				f19_arg0.SelectionOverlay:beginAnimation(100)
				f19_arg0.SelectionOverlay:setAlpha(0.03)
				f19_arg0.SelectionOverlay:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.SelectionOverlay:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.SelectionOverlay:completeAnimation()
			f19_arg0.SelectionOverlay:setAlpha(0.01)
			f19_local1(f19_arg0.SelectionOverlay)
			local f19_local2 = function(f22_arg0)
				f19_arg0.ItemName:beginAnimation(100)
				f19_arg0.ItemName:setRGB(0.92, 0.89, 0.72)
				f19_arg0.ItemName:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.ItemName:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.ItemName:completeAnimation()
			f19_arg0.ItemName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f19_local2(f19_arg0.ItemName)
			f19_arg0.ButtonFrame:completeAnimation()
			f19_arg0.ButtonFrame:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.ButtonFrame)
		end,
		ActiveAndChildFocusToActive = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(4)
			local f23_local0 = function(f24_arg0)
				f23_arg0.StoreCommonTextBacking:beginAnimation(100)
				f23_arg0.StoreCommonTextBacking:setRGB(1, 1, 1)
				f23_arg0.StoreCommonTextBacking:setAlpha(0.4)
				f23_arg0.StoreCommonTextBacking:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.StoreCommonTextBacking:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.StoreCommonTextBacking:completeAnimation()
			f23_arg0.StoreCommonTextBacking:setRGB(1, 0.68, 0.12)
			f23_arg0.StoreCommonTextBacking:setAlpha(0.6)
			f23_local0(f23_arg0.StoreCommonTextBacking)
			local f23_local1 = function(f25_arg0)
				f23_arg0.SelectionOverlay:beginAnimation(100)
				f23_arg0.SelectionOverlay:setAlpha(0.01)
				f23_arg0.SelectionOverlay:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.SelectionOverlay:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.SelectionOverlay:completeAnimation()
			f23_arg0.SelectionOverlay:setAlpha(0.03)
			f23_local1(f23_arg0.SelectionOverlay)
			local f23_local2 = function(f26_arg0)
				f23_arg0.ItemName:beginAnimation(100)
				f23_arg0.ItemName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
				f23_arg0.ItemName:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.ItemName:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.ItemName:completeAnimation()
			f23_arg0.ItemName:setRGB(0.92, 0.89, 0.72)
			f23_local2(f23_arg0.ItemName)
			f23_arg0.ButtonFrame:completeAnimation()
			f23_arg0.ButtonFrame:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.ButtonFrame)
		end,
	},
}
if not CoD.isPC then
	CoD.CamoFilterButton.__clipsPerState.DefaultState.Active = nil
	CoD.CamoFilterButton.__clipsPerState.DefaultState.ActiveAndChildFocus = nil
	CoD.CamoFilterButton.__clipsPerState.DefaultState.ActiveToActiveAndChildFocus = nil
	CoD.CamoFilterButton.__clipsPerState.DefaultState.ActiveAndChildFocusToActive = nil
end
CoD.CamoFilterButton.__onClose = function(f27_arg0)
	f27_arg0.StoreCommonTextBacking:close()
	f27_arg0.ItemName:close()
	f27_arg0.ButtonFrame:close()
	f27_arg0.NewBreadcrumb:close()
end
