require("x64:2dee1d9f1ec4c33")
require("x64:edf74c078d01a26")
CoD.ZMSignatureWeaponItemGridButton = InheritFrom(LUI.UIElement)
CoD.ZMSignatureWeaponItemGridButton.__defaultWidth = 292
CoD.ZMSignatureWeaponItemGridButton.__defaultHeight = 146
CoD.ZMSignatureWeaponItemGridButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMSignatureWeaponItemGridButton)
	self.id = "ZMSignatureWeaponItemGridButton"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ZMItem = CoD.ZMAttachmentSlot.new(f1_arg0, f1_arg1, 0, 0, 0, 292, 0, 0, 0, 146)
	ZMItem:mergeStateConditions({
		{
			stateName = "LootNotOwned",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "owned")
			end,
		},
		{
			stateName = "NotAvailable",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "selected")
			end,
		},
	})
	ZMItem:linkToElementModel(ZMItem, "owned", true, function(model)
		f1_arg0:updateElementState(ZMItem, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "owned",
		})
	end)
	ZMItem:linkToElementModel(ZMItem, "selected", true, function(model)
		f1_arg0:updateElementState(ZMItem, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "selected",
		})
	end)
	ZMItem:linkToElementModel(self, nil, false, function(model)
		ZMItem:setModel(model, f1_arg1)
	end)
	ZMItem:linkToElementModel(self, "displayImage", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			ZMItem.AttachmentImage:setImage(CoD.BaseUtility.AlreadyRegistered(f9_local0))
		end
	end)
	ZMItem:linkToElementModel(self, nil, false, function(model)
		ZMItem.ItemHintTextBreadcrumb:setModel(model, f1_arg1)
	end)
	ZMItem:linkToElementModel(self, "hintText", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			ZMItem.ItemHintTextBreadcrumb.textCenterAlign:setText(f11_local0)
		end
	end)
	ZMItem:linkToElementModel(self, nil, false, function(model)
		ZMItem.ItemHintTextBreadcrumb.Breadcrumb:setModel(model, f1_arg1)
	end)
	ZMItem:linkToElementModel(self, "displayName", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			ZMItem.AttachmentName:setText(LocalizeToUpperString(f13_local0))
		end
	end)
	self:addElement(ZMItem)
	self.ZMItem = ZMItem
	local MastercraftDetailsHintText = CoD.ItemHintText.new(f1_arg0, f1_arg1, 0.5, 0.5, -146, 146, 0, 0, -51, -6)
	MastercraftDetailsHintText:mergeStateConditions({
		{
			stateName = "NoHintText",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "ref")
			end,
		},
	})
	MastercraftDetailsHintText:appendEventHandler("input_source_changed", function(f15_arg0, f15_arg1)
		f15_arg1.menu = f15_arg1.menu or f1_arg0
		f1_arg0:updateElementState(MastercraftDetailsHintText, f15_arg1)
	end)
	local f1_local3 = MastercraftDetailsHintText
	local f1_local4 = MastercraftDetailsHintText.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5.LastInput, function(f16_arg0)
		f1_arg0:updateElementState(MastercraftDetailsHintText, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	MastercraftDetailsHintText:linkToElementModel(MastercraftDetailsHintText, "ref", true, function(model)
		f1_arg0:updateElementState(MastercraftDetailsHintText, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "ref",
		})
	end)
	MastercraftDetailsHintText:setAlpha(0)
	MastercraftDetailsHintText.textCenterAlign:setText(Engine[0xF9F1239CFD921FE](0xD087E4011D7527C))
	MastercraftDetailsHintText:linkToElementModel(self, nil, false, function(model)
		MastercraftDetailsHintText:setModel(model, f1_arg1)
	end)
	self:addElement(MastercraftDetailsHintText)
	self.MastercraftDetailsHintText = MastercraftDetailsHintText
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	ZMItem.id = "ZMItem"
	self.__defaultFocus = ZMItem
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMSignatureWeaponItemGridButton.__resetProperties = function(f20_arg0)
	f20_arg0.MastercraftDetailsHintText:completeAnimation()
	f20_arg0.MastercraftDetailsHintText:setAlpha(0)
end
CoD.ZMSignatureWeaponItemGridButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.MastercraftDetailsHintText:completeAnimation()
			f22_arg0.MastercraftDetailsHintText:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.MastercraftDetailsHintText)
		end,
		GainChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			local f23_local0 = function(f24_arg0)
				f23_arg0.MastercraftDetailsHintText:beginAnimation(200)
				f23_arg0.MastercraftDetailsHintText:setAlpha(1)
				f23_arg0.MastercraftDetailsHintText:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.MastercraftDetailsHintText:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.MastercraftDetailsHintText:completeAnimation()
			f23_arg0.MastercraftDetailsHintText:setAlpha(0)
			f23_local0(f23_arg0.MastercraftDetailsHintText)
		end,
		LoseChildFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			local f25_local0 = function(f26_arg0)
				f25_arg0.MastercraftDetailsHintText:beginAnimation(200)
				f25_arg0.MastercraftDetailsHintText:setAlpha(0)
				f25_arg0.MastercraftDetailsHintText:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.MastercraftDetailsHintText:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.MastercraftDetailsHintText:completeAnimation()
			f25_arg0.MastercraftDetailsHintText:setAlpha(1)
			f25_local0(f25_arg0.MastercraftDetailsHintText)
		end,
	},
	PC = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(1)
			f28_arg0.MastercraftDetailsHintText:completeAnimation()
			f28_arg0.MastercraftDetailsHintText:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.MastercraftDetailsHintText)
		end,
		GainChildFocus = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(1)
			local f29_local0 = function(f30_arg0)
				f29_arg0.MastercraftDetailsHintText:beginAnimation(200)
				f29_arg0.MastercraftDetailsHintText:setAlpha(1)
				f29_arg0.MastercraftDetailsHintText:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.MastercraftDetailsHintText:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.MastercraftDetailsHintText:completeAnimation()
			f29_arg0.MastercraftDetailsHintText:setAlpha(0)
			f29_local0(f29_arg0.MastercraftDetailsHintText)
		end,
		LoseChildFocus = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(1)
			local f31_local0 = function(f32_arg0)
				f31_arg0.MastercraftDetailsHintText:beginAnimation(200)
				f31_arg0.MastercraftDetailsHintText:setAlpha(0)
				f31_arg0.MastercraftDetailsHintText:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.MastercraftDetailsHintText:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.MastercraftDetailsHintText:completeAnimation()
			f31_arg0.MastercraftDetailsHintText:setAlpha(1)
			f31_local0(f31_arg0.MastercraftDetailsHintText)
		end,
	},
}
CoD.ZMSignatureWeaponItemGridButton.__onClose = function(f33_arg0)
	f33_arg0.ZMItem:close()
	f33_arg0.MastercraftDetailsHintText:close()
end
