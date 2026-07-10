require("x64:dfd115b8bbb2cbc")
require("x64:5efe05d5e26c932")
require("x64:389aed84d504e5f")
CoD.StartMenu_Options_PC_Audio_TabContent = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_PC_Audio_TabContent.__defaultWidth = 1885
CoD.StartMenu_Options_PC_Audio_TabContent.__defaultHeight = 812
CoD.StartMenu_Options_PC_Audio_TabContent.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_PC_Audio_TabContent)
	self.id = "StartMenu_Options_PC_Audio_TabContent"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SubOptionsNavigation1 = CoD.StartMenu_Options_PC_AudioOptions_SubOptionsNavigation.new(f1_arg0, f1_arg1, 0, 0, 422, 1885, 0, 0, 0, 716)
	self:addElement(SubOptionsNavigation1)
	self.SubOptionsNavigation1 = SubOptionsNavigation1
	local Global = CoD.GlobalDropdown.new(f1_arg0, f1_arg1, 0.5, 0.5, -220, 204, 0, 0, 0, 45)
	Global:setAlpha(0)
	self:addElement(Global)
	self.Global = Global
	local List = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, false, false, false, false)
	List:mergeStateConditions({
		{
			stateName = "Expanded",
			condition = function(menu, element, event)
				return IsSelfInState(self, "CategoryButtons")
			end,
		},
		{
			stateName = "Collapsed",
			condition = function(menu, element, event)
				return AlwaysFalse() and IsSelfInState(self, "SubOptions")
			end,
		},
	})
	local f1_local4 = List
	local f1_local5 = List.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["PC.CurrentCategory"], function(f4_arg0)
		f1_arg0:updateElementState(List, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "PC.CurrentCategory",
		})
	end, false)
	List:linkToElementModel(List, "categoryId", true, function(model)
		f1_arg0:updateElementState(List, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "categoryId",
		})
	end)
	List:setLeftRight(0, 0, 0, 245)
	List:setTopBottom(0, 0, 66, 648)
	List:setWidgetType(CoD.CategoryExpendableButton)
	List:setVerticalCount(8)
	List:setSpacing(10)
	List:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	List:setDataSource("OptionAudioCategories")
	self:addElement(List)
	self.List = List
	self:mergeStateConditions({
		{
			stateName = "SubOptions",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "CategoryButtons",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
		{
			stateName = "CategoryButtonsTEMP",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f9_arg2, f9_arg3, f9_arg4)
		UpdateElementState(self, "List", controller)
	end)
	SubOptionsNavigation1.id = "SubOptionsNavigation1"
	Global.id = "Global"
	List.id = "List"
	self.__defaultFocus = SubOptionsNavigation1
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local5 = self
	CoD.PCUtility.SetForceMouseEventDispatch(self, true)
	return self
end
CoD.StartMenu_Options_PC_Audio_TabContent.__resetProperties = function(f10_arg0)
	f10_arg0.Global:completeAnimation()
	f10_arg0.List:completeAnimation()
	f10_arg0.SubOptionsNavigation1:completeAnimation()
	f10_arg0.Global:setLeftRight(0.5, 0.5, -220, 204)
	f10_arg0.Global:setTopBottom(0, 0, 0, 45)
	f10_arg0.List:setLeftRight(0, 0, 0, 245)
	f10_arg0.SubOptionsNavigation1:setLeftRight(0, 0, 422, 1885)
end
CoD.StartMenu_Options_PC_Audio_TabContent.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
	SubOptions = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			local f12_local0 = function(f13_arg0)
				f12_arg0.SubOptionsNavigation1:beginAnimation(350, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f12_arg0.SubOptionsNavigation1:setLeftRight(0.5, 0.5, -688, 712)
				f12_arg0.SubOptionsNavigation1:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.SubOptionsNavigation1:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.SubOptionsNavigation1:completeAnimation()
			f12_arg0.SubOptionsNavigation1:setLeftRight(0.5, 0.5, -488, 912)
			f12_local0(f12_arg0.SubOptionsNavigation1)
			local f12_local1 = function(f14_arg0)
				f12_arg0.Global:beginAnimation(350, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f12_arg0.Global:setLeftRight(0.5, 0.5, -424, 0)
				f12_arg0.Global:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.Global:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.Global:completeAnimation()
			f12_arg0.Global:setLeftRight(0.5, 0.5, -220, 204)
			f12_arg0.Global:setTopBottom(0, 0, 0, 45)
			f12_local1(f12_arg0.Global)
			local f12_local2 = function(f15_arg0)
				f12_arg0.List:beginAnimation(350, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f12_arg0.List:setLeftRight(0, 0, 81, 471)
				f12_arg0.List:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.List:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.List:completeAnimation()
			f12_arg0.List:setLeftRight(0, 0, 0, 390)
			f12_local2(f12_arg0.List)
		end,
	},
	CategoryButtons = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
	},
	CategoryButtonsTEMP = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			local f17_local0 = function(f18_arg0)
				f17_arg0.SubOptionsNavigation1:beginAnimation(350)
				f17_arg0.SubOptionsNavigation1:setLeftRight(0.5, 0.5, -488, 912)
				f17_arg0.SubOptionsNavigation1:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.SubOptionsNavigation1:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.SubOptionsNavigation1:completeAnimation()
			f17_arg0.SubOptionsNavigation1:setLeftRight(0.5, 0.5, -688, 712)
			f17_local0(f17_arg0.SubOptionsNavigation1)
			local f17_local1 = function(f19_arg0)
				f17_arg0.Global:beginAnimation(350)
				f17_arg0.Global:setLeftRight(0.5, 0.5, -220, 204)
				f17_arg0.Global:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.Global:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.Global:completeAnimation()
			f17_arg0.Global:setLeftRight(0.5, 0.5, -424, 0)
			f17_arg0.Global:setTopBottom(0, 0, 0, 45)
			f17_local1(f17_arg0.Global)
			local f17_local2 = function(f20_arg0)
				f17_arg0.List:beginAnimation(350)
				f17_arg0.List:setLeftRight(0, 0, 0, 390)
				f17_arg0.List:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.List:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.List:completeAnimation()
			f17_arg0.List:setLeftRight(0, 0, 81, 471)
			f17_local2(f17_arg0.List)
		end,
	},
}
CoD.StartMenu_Options_PC_Audio_TabContent.__onClose = function(f21_arg0)
	f21_arg0.SubOptionsNavigation1:close()
	f21_arg0.Global:close()
	f21_arg0.List:close()
end
