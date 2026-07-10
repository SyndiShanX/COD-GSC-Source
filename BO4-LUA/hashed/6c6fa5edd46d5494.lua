require("x64:1cd7f68136f9cc0")
require("x64:399e4fa6c394b1b")
CoD.Tcm_Pause_Rules = InheritFrom(LUI.UIElement)
CoD.Tcm_Pause_Rules.__defaultWidth = 1005
CoD.Tcm_Pause_Rules.__defaultHeight = 362
CoD.Tcm_Pause_Rules.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Tcm_Pause_Rules)
	self.id = "Tcm_Pause_Rules"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TcmText = LUI.UIText.new(0.5, 0.5, -318.5, 318.5, 0, 0, 25, 46)
	TcmText:setRGB(ColorSet.ZombiePlayerDown.r, ColorSet.ZombiePlayerDown.g, ColorSet.ZombiePlayerDown.b)
	TcmText:setText(Engine[0xF9F1239CFD921FE](0x2F7BDC1E839FE4F))
	TcmText:setTTF("skorzhen")
	TcmText:setLetterSpacing(2)
	TcmText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(TcmText)
	self.TcmText = TcmText
	local EnterTheArenaText = LUI.UIText.new(0.5, 0.5, -502.5, 502.5, 0, 0, 50, 90)
	EnterTheArenaText:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	EnterTheArenaText:setTTF("skorzhen")
	EnterTheArenaText:setLetterSpacing(4)
	EnterTheArenaText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	EnterTheArenaText:subscribeToGlobalModel(f1_arg1, "ZMHudGlobal", "tcm.active", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			EnterTheArenaText:setText(CoD.ZombieUtility.GetTcmTitle(f2_local0))
		end
	end)
	self:addElement(EnterTheArenaText)
	self.EnterTheArenaText = EnterTheArenaText
	local TcmRules = LUI.UIList.new(f1_arg0, f1_arg1, -2, 0, nil, false, false, false, false)
	TcmRules:setLeftRight(0.5, 0.5, -502.5, 495.5)
	TcmRules:setTopBottom(0, 0, 110, 364)
	TcmRules:setWidgetType(CoD.Tcm_Rule_Entry)
	TcmRules:setHorizontalCount(2)
	TcmRules:setVerticalCount(6)
	TcmRules:setSpacing(-2)
	TcmRules:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TcmRules:setDataSource("TcmRules")
	self:addElement(TcmRules)
	self.TcmRules = TcmRules
	local TopOrnament2 = CoD.zm_LaboratoryDescriptionDividerSecondary.new(f1_arg0, f1_arg1, 0.5, 0.5, -444, 444, 0, 0, 78, 102)
	TopOrnament2:setRGB(ColorSet.ZombiePlayerDown.r, ColorSet.ZombiePlayerDown.g, ColorSet.ZombiePlayerDown.b)
	TopOrnament2.R:setScale(0.5, 0.5)
	TopOrnament2.L:setScale(0.5, 0.5)
	self:addElement(TopOrnament2)
	self.TopOrnament2 = TopOrnament2
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueGreaterThan("ZMHudGlobal.tcm.active", 0)
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[0x8DF2E5447F384B9]()
	f1_local6(f1_local5, f1_local7["ZMHudGlobal.tcm.active"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "ZMHudGlobal.tcm.active",
		})
	end, false)
	TcmRules.id = "TcmRules"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Tcm_Pause_Rules.__resetProperties = function(f5_arg0)
	f5_arg0.TcmRules:completeAnimation()
	f5_arg0.EnterTheArenaText:completeAnimation()
	f5_arg0.TcmText:completeAnimation()
	f5_arg0.TopOrnament2:completeAnimation()
	f5_arg0.TcmRules:setAlpha(1)
	f5_arg0.EnterTheArenaText:setAlpha(1)
	f5_arg0.TcmText:setAlpha(1)
	f5_arg0.TopOrnament2:setAlpha(1)
end
CoD.Tcm_Pause_Rules.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(4)
			f6_arg0.TcmText:completeAnimation()
			f6_arg0.TcmText:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.TcmText)
			f6_arg0.EnterTheArenaText:completeAnimation()
			f6_arg0.EnterTheArenaText:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.EnterTheArenaText)
			f6_arg0.TcmRules:completeAnimation()
			f6_arg0.TcmRules:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.TcmRules)
			f6_arg0.TopOrnament2:completeAnimation()
			f6_arg0.TopOrnament2:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.TopOrnament2)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(4)
			f7_arg0.TcmText:completeAnimation()
			f7_arg0.TcmText:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.TcmText)
			f7_arg0.EnterTheArenaText:completeAnimation()
			f7_arg0.EnterTheArenaText:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.EnterTheArenaText)
			f7_arg0.TcmRules:completeAnimation()
			f7_arg0.TcmRules:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.TcmRules)
			f7_arg0.TopOrnament2:completeAnimation()
			f7_arg0.TopOrnament2:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.TopOrnament2)
		end,
	},
}
CoD.Tcm_Pause_Rules.__onClose = function(f8_arg0)
	f8_arg0.EnterTheArenaText:close()
	f8_arg0.TcmRules:close()
	f8_arg0.TopOrnament2:close()
end
