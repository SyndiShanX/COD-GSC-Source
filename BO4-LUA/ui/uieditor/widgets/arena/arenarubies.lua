require("x64:af5ac56443a5fe2")
require("x64:8e85b5639cc87ba")
require("x64:397f0051aed4aca")
CoD.ArenaRubies = InheritFrom(LUI.UIElement)
CoD.ArenaRubies.__defaultWidth = 140
CoD.ArenaRubies.__defaultHeight = 74
CoD.ArenaRubies.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaRubies)
	self.id = "ArenaRubies"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local threeRubyLayout = CoD.arenaLeaguePlayRubiesThree.new(f1_arg0, f1_arg1, 0, 0, 0, 140, 0, 0, 0, 74)
	self:addElement(threeRubyLayout)
	self.threeRubyLayout = threeRubyLayout
	local fourRubyLayout = CoD.arenaLeaguePlayRubiesFour.new(f1_arg0, f1_arg1, 0, 0, 0, 140, 0, 0, 0, 74)
	self:addElement(fourRubyLayout)
	self.fourRubyLayout = fourRubyLayout
	local fiveRubyLayout = CoD.arenaLeaguePlayRubiesFive.new(f1_arg0, f1_arg1, 0, 0, 0, 140, 0, 0, 0, 74)
	self:addElement(fiveRubyLayout)
	self.fiveRubyLayout = fiveRubyLayout
	self:mergeStateConditions({
		{
			stateName = "FourRubies",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyRequirementEqualValue(f1_arg1, 4)
			end,
		},
		{
			stateName = "FiveRubies",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyRequirementEqualValue(f1_arg1, 5)
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local5(f1_local4, f1_local6["lobbyRoot.lobbyNav"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaRubies.__resetProperties = function(f5_arg0)
	f5_arg0.fourRubyLayout:completeAnimation()
	f5_arg0.fiveRubyLayout:completeAnimation()
	f5_arg0.threeRubyLayout:completeAnimation()
	f5_arg0.fourRubyLayout:setAlpha(1)
	f5_arg0.fiveRubyLayout:setAlpha(1)
	f5_arg0.threeRubyLayout:setAlpha(1)
end
CoD.ArenaRubies.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.fourRubyLayout:completeAnimation()
			f6_arg0.fourRubyLayout:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.fourRubyLayout)
			f6_arg0.fiveRubyLayout:completeAnimation()
			f6_arg0.fiveRubyLayout:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.fiveRubyLayout)
		end,
	},
	FourRubies = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.threeRubyLayout:completeAnimation()
			f7_arg0.threeRubyLayout:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.threeRubyLayout)
			f7_arg0.fiveRubyLayout:completeAnimation()
			f7_arg0.fiveRubyLayout:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.fiveRubyLayout)
		end,
	},
	FiveRubies = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.threeRubyLayout:completeAnimation()
			f8_arg0.threeRubyLayout:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.threeRubyLayout)
			f8_arg0.fourRubyLayout:completeAnimation()
			f8_arg0.fourRubyLayout:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.fourRubyLayout)
		end,
	},
}
CoD.ArenaRubies.__onClose = function(f9_arg0)
	f9_arg0.threeRubyLayout:close()
	f9_arg0.fourRubyLayout:close()
	f9_arg0.fiveRubyLayout:close()
end
