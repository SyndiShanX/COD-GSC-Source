require("x64:f6482b855bfca9f")
require("x64:acbed692442191c")
require("x64:29187ea00d726c3")
CoD.ItemHintTextBreadcrumb = InheritFrom(LUI.UIElement)
CoD.ItemHintTextBreadcrumb.__defaultWidth = 346
CoD.ItemHintTextBreadcrumb.__defaultHeight = 34
CoD.ItemHintTextBreadcrumb.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, true)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.ItemHintTextBreadcrumb)
	self.id = "ItemHintTextBreadcrumb"
	self.soundSet = "FrontendMain"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonCornerPips = CoD.CommonCornerPips02.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CommonCornerPips.Bg:setAlpha(1)
	CommonCornerPips.TiledBacking:setAlpha(1)
	self:addElement(CommonCornerPips)
	self.CommonCornerPips = CommonCornerPips
	local Spacer01 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 2.5, 11.5, 0, 0, -8.5, 42.5)
	self:addElement(Spacer01)
	self.Spacer01 = Spacer01
	local textCenterAlign = LUI.UIText.new(0, 0, 11.5, 307.5, 0.5, 0.5, -10, 10)
	textCenterAlign:setText("")
	textCenterAlign:setTTF("dinnext_regular")
	textCenterAlign:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	textCenterAlign:setBackingType(1)
	textCenterAlign:setBackingXPadding(15)
	textCenterAlign:setBackingYPadding(7)
	self:addElement(textCenterAlign)
	self.textCenterAlign = textCenterAlign
	local Spacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 307.5, 316.5, 0, 0, -8.5, 42.5)
	self:addElement(Spacer)
	self.Spacer = Spacer
	local Breadcrumb = CoD.NewBreadcrumb.new(f1_arg0, f1_arg1, 0, 0, 316.5, 334.5, 0.5, 0.5, -11, 7)
	Breadcrumb:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f2_local0 = IsLive()
				if f2_local0 then
					if not IsInGame() then
						f2_local0 = CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "breadcrumbCount", 0)
					else
						f2_local0 = false
					end
				end
				return f2_local0
			end,
		},
	})
	local f1_local6 = Breadcrumb
	local Spacer2 = Breadcrumb.subscribeToModel
	local f1_local8 = Engine[@"getglobalmodel"]()
	Spacer2(f1_local6, f1_local8["lobbyRoot.lobbyNetworkMode"], function(f3_arg0)
		f1_arg0:updateElementState(Breadcrumb, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.lobbyNetworkMode",
		})
	end, false)
	f1_local6 = Breadcrumb
	Spacer2 = Breadcrumb.subscribeToModel
	f1_local8 = Engine[@"getglobalmodel"]()
	Spacer2(f1_local6, f1_local8["lobbyRoot.lobbyNav"], function(f4_arg0)
		f1_arg0:updateElementState(Breadcrumb, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	Breadcrumb:linkToElementModel(Breadcrumb, "breadcrumbCount", true, function(model)
		f1_arg0:updateElementState(Breadcrumb, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "breadcrumbCount",
		})
	end)
	self:addElement(Breadcrumb)
	self.Breadcrumb = Breadcrumb
	Spacer2 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 334.5, 343.5, 0, 0, -8.5, 42.5)
	self:addElement(Spacer2)
	self.Spacer2 = Spacer2
	self:mergeStateConditions({
		{
			stateName = "Mouse",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "NoHintText",
			condition = function(menu, element, event)
				return not HasHintText(element)
			end,
		},
		{
			stateName = "CenterAlign",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f9_arg0, f9_arg1)
		f9_arg1.menu = f9_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f9_arg1)
	end)
	f1_local8 = self
	f1_local6 = self.subscribeToModel
	local f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local8, f1_local9.LastInput, function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:linkToElementModel(self, nil, true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = nil,
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ItemHintTextBreadcrumb.__resetProperties = function(f12_arg0)
	f12_arg0.textCenterAlign:completeAnimation()
	f12_arg0.Breadcrumb:completeAnimation()
	f12_arg0.CommonCornerPips:completeAnimation()
	f12_arg0.textCenterAlign:setAlpha(1)
	f12_arg0.Breadcrumb:setAlpha(1)
	f12_arg0.CommonCornerPips:setAlpha(1)
end
CoD.ItemHintTextBreadcrumb.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
	Mouse = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(3)
			f14_arg0.CommonCornerPips:completeAnimation()
			f14_arg0.CommonCornerPips:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.CommonCornerPips)
			f14_arg0.textCenterAlign:completeAnimation()
			f14_arg0.textCenterAlign:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.textCenterAlign)
			f14_arg0.Breadcrumb:completeAnimation()
			f14_arg0.Breadcrumb:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Breadcrumb)
		end,
	},
	NoHintText = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(3)
			f15_arg0.CommonCornerPips:completeAnimation()
			f15_arg0.CommonCornerPips:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.CommonCornerPips)
			f15_arg0.textCenterAlign:completeAnimation()
			f15_arg0.textCenterAlign:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.textCenterAlign)
			f15_arg0.Breadcrumb:completeAnimation()
			f15_arg0.Breadcrumb:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Breadcrumb)
		end,
	},
	CenterAlign = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.ItemHintTextBreadcrumb.__onClose = function(f17_arg0)
	f17_arg0.CommonCornerPips:close()
	f17_arg0.Spacer01:close()
	f17_arg0.Spacer:close()
	f17_arg0.Breadcrumb:close()
	f17_arg0.Spacer2:close()
end
