require("x64:dfd115b8bbb2cbc")
require("x64:5efe05d5e26c932")
require("x64:6f134078184861")
require("x64:8b075f4e512e795")
require("x64:6ecfe9d4da6fd92")
CoD.StartMenu_Options_PC_Graphics_TabContent = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_PC_Graphics_TabContent.__defaultWidth = 1920
CoD.StartMenu_Options_PC_Graphics_TabContent.__defaultHeight = 802
CoD.StartMenu_Options_PC_Graphics_TabContent.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_PC_Graphics_TabContent)
	self.id = "StartMenu_Options_PC_Graphics_TabContent"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SubOptionsNavigation = CoD.StartMenu_Options_PC_GraphicsOptions_SubOptionsNavigation.new(f1_arg0, f1_arg1, 0, 0, 297, 1920, 0, 1, 0, 0)
	self:addElement(SubOptionsNavigation)
	self.SubOptionsNavigation = SubOptionsNavigation
	local VRAM = CoD.StartMenu_Options_PC_GraphicsOptions_VRAMBar.new(f1_arg0, f1_arg1, 0, 0, 1351, 1723, 0, 0, -58, -13)
	self:addElement(VRAM)
	self.VRAM = VRAM
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
	local f1_local5 = List
	local SeparationLineVertical = List.subscribeToModel
	local f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	SeparationLineVertical(f1_local5, f1_local7["PC.CurrentCategory"], function(f4_arg0)
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
	List:setLeftRight(0, 0, 67, 312)
	List:setTopBottom(0.5, 0.5, -143, 143)
	List:setAutoScaleContent(true)
	List:setWidgetType(CoD.CategoryExpendableButton)
	List:setVerticalCount(4)
	List:setSpacing(10)
	List:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	List:setDataSource("OptionGraphicsCategories")
	self:addElement(List)
	self.List = List
	SeparationLineVertical = CoD.SeparationLine_Vertical.new(f1_arg0, f1_arg1, 0, 0, 297, 298, 0.5, 0.5, -285, 285)
	self:addElement(SeparationLineVertical)
	self.SeparationLineVertical = SeparationLineVertical
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
	SubOptionsNavigation.id = "SubOptionsNavigation"
	VRAM.id = "VRAM"
	Global.id = "Global"
	List.id = "List"
	self.__defaultFocus = SubOptionsNavigation
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_PC_Graphics_TabContent.__resetProperties = function(f10_arg0)
	f10_arg0.Global:completeAnimation()
	f10_arg0.List:completeAnimation()
	f10_arg0.VRAM:completeAnimation()
	f10_arg0.SubOptionsNavigation:completeAnimation()
	f10_arg0.SeparationLineVertical:completeAnimation()
	f10_arg0.Global:setLeftRight(0.5, 0.5, -220, 204)
	f10_arg0.Global:setTopBottom(0, 0, 0, 45)
	f10_arg0.List:setLeftRight(0, 0, 67, 312)
	f10_arg0.VRAM:setLeftRight(0, 0, 1351, 1723)
	f10_arg0.VRAM:setTopBottom(0, 0, -58, -13)
	f10_arg0.SubOptionsNavigation:setLeftRight(0, 0, 297, 1920)
	f10_arg0.SeparationLineVertical:setLeftRight(0, 0, 297, 298)
end
CoD.StartMenu_Options_PC_Graphics_TabContent.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
	SubOptions = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(4)
			local f12_local0 = function(f13_arg0)
				f12_arg0.SubOptionsNavigation:beginAnimation(350, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f12_arg0.SubOptionsNavigation:setLeftRight(0.5, 0.5, -688, 712)
				f12_arg0.SubOptionsNavigation:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.SubOptionsNavigation:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.SubOptionsNavigation:completeAnimation()
			f12_arg0.SubOptionsNavigation:setLeftRight(0.5, 0.5, -488, 912)
			f12_local0(f12_arg0.SubOptionsNavigation)
			local f12_local1 = function(f14_arg0)
				f12_arg0.VRAM:beginAnimation(350, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f12_arg0.VRAM:setLeftRight(0.5, 0.5, 42, 712)
				f12_arg0.VRAM:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.VRAM:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.VRAM:completeAnimation()
			f12_arg0.VRAM:setLeftRight(0.5, 0.5, 242, 912)
			f12_arg0.VRAM:setTopBottom(0, 0, 0, 45)
			f12_local1(f12_arg0.VRAM)
			local f12_local2 = function(f15_arg0)
				f12_arg0.Global:beginAnimation(350, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f12_arg0.Global:setLeftRight(0.5, 0.5, -424, 0)
				f12_arg0.Global:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.Global:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.Global:completeAnimation()
			f12_arg0.Global:setLeftRight(0.5, 0.5, -220, 204)
			f12_arg0.Global:setTopBottom(0, 0, 0, 45)
			f12_local2(f12_arg0.Global)
			local f12_local3 = function(f16_arg0)
				f12_arg0.List:beginAnimation(350, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f12_arg0.List:setLeftRight(0, 0, 81, 471)
				f12_arg0.List:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.List:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.List:completeAnimation()
			f12_arg0.List:setLeftRight(0, 0, 0, 390)
			f12_local3(f12_arg0.List)
		end,
	},
	CategoryButtons = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.SeparationLineVertical:completeAnimation()
			f17_arg0.SeparationLineVertical:setLeftRight(0, 0, 298, 301)
			f17_arg0.clipFinished(f17_arg0.SeparationLineVertical)
		end,
	},
	CategoryButtonsTEMP = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(4)
			local f18_local0 = function(f19_arg0)
				f18_arg0.SubOptionsNavigation:beginAnimation(350)
				f18_arg0.SubOptionsNavigation:setLeftRight(0.5, 0.5, -488, 912)
				f18_arg0.SubOptionsNavigation:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.SubOptionsNavigation:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.SubOptionsNavigation:completeAnimation()
			f18_arg0.SubOptionsNavigation:setLeftRight(0.5, 0.5, -688, 712)
			f18_local0(f18_arg0.SubOptionsNavigation)
			local f18_local1 = function(f20_arg0)
				f18_arg0.VRAM:beginAnimation(350)
				f18_arg0.VRAM:setLeftRight(0.5, 0.5, 242, 912)
				f18_arg0.VRAM:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.VRAM:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.VRAM:completeAnimation()
			f18_arg0.VRAM:setLeftRight(0.5, 0.5, 42, 712)
			f18_arg0.VRAM:setTopBottom(0, 0, 0, 45)
			f18_local1(f18_arg0.VRAM)
			local f18_local2 = function(f21_arg0)
				f18_arg0.Global:beginAnimation(350)
				f18_arg0.Global:setLeftRight(0.5, 0.5, -220, 204)
				f18_arg0.Global:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.Global:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.Global:completeAnimation()
			f18_arg0.Global:setLeftRight(0.5, 0.5, -424, 0)
			f18_arg0.Global:setTopBottom(0, 0, 0, 45)
			f18_local2(f18_arg0.Global)
			local f18_local3 = function(f22_arg0)
				f18_arg0.List:beginAnimation(350)
				f18_arg0.List:setLeftRight(0, 0, 0, 390)
				f18_arg0.List:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.List:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.List:completeAnimation()
			f18_arg0.List:setLeftRight(0, 0, 81, 471)
			f18_local3(f18_arg0.List)
		end,
	},
}
CoD.StartMenu_Options_PC_Graphics_TabContent.__onClose = function(f23_arg0)
	f23_arg0.SubOptionsNavigation:close()
	f23_arg0.VRAM:close()
	f23_arg0.Global:close()
	f23_arg0.List:close()
	f23_arg0.SeparationLineVertical:close()
end
