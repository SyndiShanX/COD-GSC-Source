require("ui/uieditor/widgets/startmenu/options/startmenu_options_controllerlayout_durango")
require("ui/uieditor/widgets/startmenu/options/startmenu_options_controllerlayout_orbis")
require("ui/uieditor/widgets/startmenu/options/startmenu_options_controllerlayout_vita")
CoD.StartMenu_Options_ControllerLayout = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_ControllerLayout.__defaultWidth = 750
CoD.StartMenu_Options_ControllerLayout.__defaultHeight = 500
CoD.StartMenu_Options_ControllerLayout.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_ControllerLayout)
	self.id = "StartMenu_Options_ControllerLayout"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Orbis = CoD.StartMenu_Options_ControllerLayout_Orbis.new(f1_arg0, f1_arg1, 0, 0, 0, 750, 0, 0, 0, 500)
	self:addElement(Orbis)
	self.Orbis = Orbis
	local Durango = CoD.StartMenu_Options_ControllerLayout_Durango.new(f1_arg0, f1_arg1, 0, 0, 0, 750, 0, 0, 0, 500)
	self:addElement(Durango)
	self.Durango = Durango
	local Vita = CoD.StartMenu_Options_ControllerLayout_vita.new(f1_arg0, f1_arg1, 0, 0, -108, 970, 0, 0, 3, 533)
	self:addElement(Vita)
	self.Vita = Vita
	local f1_local4 = nil
	self.StartMenuOptionsMainFrame = LUI.UIElement.createFake()
	local f1_local5 = nil
	self.CornerDots = LUI.UIElement.createFake()
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_ControllerLayout.__resetProperties = function(f2_arg0)
	f2_arg0.Durango:completeAnimation()
	f2_arg0.Orbis:completeAnimation()
	f2_arg0.CornerDots:completeAnimation()
	f2_arg0.StartMenuOptionsMainFrame:completeAnimation()
	f2_arg0.Vita:completeAnimation()
	f2_arg0.Durango:setAlpha(1)
	f2_arg0.Orbis:setAlpha(1)
	f2_arg0.CornerDots:setAlpha(0.4)
	f2_arg0.StartMenuOptionsMainFrame:setAlpha(0.01)
	f2_arg0.Vita:setAlpha(1)
end
CoD.StartMenu_Options_ControllerLayout.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(3)
			f4_arg0.Orbis:completeAnimation()
			f4_arg0.Orbis:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Orbis)
			f4_arg0.Durango:completeAnimation()
			f4_arg0.Durango:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Durango)
			f4_arg0.Vita:completeAnimation()
			f4_arg0.Vita:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Vita)
			f4_arg0.StartMenuOptionsMainFrame:completeAnimation()
			f4_arg0.StartMenuOptionsMainFrame:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.StartMenuOptionsMainFrame)
			f4_arg0.CornerDots:completeAnimation()
			f4_arg0.CornerDots:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.CornerDots)
		end,
	},
}
CoD.StartMenu_Options_ControllerLayout.__onClose = function(f5_arg0)
	f5_arg0.Orbis:close()
	f5_arg0.Durango:close()
	f5_arg0.Vita:close()
	f5_arg0.StartMenuOptionsMainFrame:close()
	f5_arg0.CornerDots:close()
end
