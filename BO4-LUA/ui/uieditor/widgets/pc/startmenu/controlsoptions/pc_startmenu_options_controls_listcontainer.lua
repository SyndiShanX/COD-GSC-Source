require("ui/uieditor/widgets/emptyfocusable")
require("ui/uieditor/widgets/pc/startmenu/controlsoptions/pc_startmenu_options_controls_list")
CoD.PC_StartMenu_Options_Controls_ListContainer = InheritFrom(LUI.UIElement)
CoD.PC_StartMenu_Options_Controls_ListContainer.__defaultWidth = 694
CoD.PC_StartMenu_Options_Controls_ListContainer.__defaultHeight = 633
CoD.PC_StartMenu_Options_Controls_ListContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_StartMenu_Options_Controls_ListContainer)
	self.id = "PC_StartMenu_Options_Controls_ListContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SubOptionsList = CoD.PC_StartMenu_Options_Controls_List.new(f1_arg0, f1_arg1, 0, 0, 0, 695, 0, 0, 0, 633)
	SubOptionsList:setAlpha(0.5)
	self:addElement(SubOptionsList)
	self.SubOptionsList = SubOptionsList
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	SubOptionsList.id = "SubOptionsList"
	emptyFocusable.id = "emptyFocusable"
	self.__defaultFocus = SubOptionsList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_StartMenu_Options_Controls_ListContainer.__resetProperties = function(f2_arg0)
	f2_arg0.SubOptionsList:completeAnimation()
	f2_arg0.SubOptionsList:setLeftRight(0, 0, 0, 695)
	f2_arg0.SubOptionsList:setTopBottom(0, 0, 0, 633)
	f2_arg0.SubOptionsList:setAlpha(0.5)
end
CoD.PC_StartMenu_Options_Controls_ListContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.SubOptionsList:completeAnimation()
			f4_arg0.SubOptionsList:setLeftRight(0, 0, 0, 674)
			f4_arg0.SubOptionsList:setTopBottom(0, 0, 0, 545)
			f4_arg0.SubOptionsList:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.SubOptionsList)
		end,
		GainChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				f5_arg0.SubOptionsList:beginAnimation(150)
				f5_arg0.SubOptionsList:setAlpha(1)
				f5_arg0.SubOptionsList:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.SubOptionsList:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.SubOptionsList:completeAnimation()
			f5_arg0.SubOptionsList:setLeftRight(0, 0, 0, 674)
			f5_arg0.SubOptionsList:setTopBottom(0, 0, 0, 545)
			f5_arg0.SubOptionsList:setAlpha(0.5)
			f5_local0(f5_arg0.SubOptionsList)
		end,
		LoseChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.SubOptionsList:beginAnimation(150)
				f7_arg0.SubOptionsList:setAlpha(0.5)
				f7_arg0.SubOptionsList:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.SubOptionsList:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.SubOptionsList:completeAnimation()
			f7_arg0.SubOptionsList:setLeftRight(0, 0, 0, 674)
			f7_arg0.SubOptionsList:setTopBottom(0, 0, 0, 545)
			f7_arg0.SubOptionsList:setAlpha(1)
			f7_local0(f7_arg0.SubOptionsList)
		end,
	},
}
CoD.PC_StartMenu_Options_Controls_ListContainer.__onClose = function(f9_arg0)
	f9_arg0.SubOptionsList:close()
	f9_arg0.emptyFocusable:close()
end
