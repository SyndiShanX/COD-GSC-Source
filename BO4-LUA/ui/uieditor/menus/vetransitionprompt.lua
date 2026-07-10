CoD.veTransitionPrompt = InheritFrom(CoD.Menu)
LUI.createMenu.veTransitionPrompt = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("veTransitionPrompt", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.veTransitionPrompt)
	self.soundSet = "HUD"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local Prompt = LUI.UIText.new(0, 0, 612, 1307, 0, 0, 926, 970)
	Prompt:setText("")
	Prompt:setTTF("default")
	Prompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Prompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Prompt)
	self.Prompt = Prompt
	local Prompt2 = LUI.UIText.new(0, 0, 612, 1307, 0, 0, 926, 970)
	Prompt2:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_73524F3946846790"))
	Prompt2:setTTF("default")
	Prompt2:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Prompt2:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Prompt2)
	self.Prompt2 = Prompt2
	self:mergeStateConditions({
		{
			stateName = "exterior",
			condition = function(menu, element, event)
				return IsMenuModelValueEqualTo(menu, "isExterior", 1)
			end,
		},
		{
			stateName = "interior",
			condition = function(menu, element, event)
				return IsMenuModelValueEqualTo(menu, "isInterior", 1)
			end,
		},
	})
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.veTransitionPrompt.__resetProperties = function(f4_arg0)
	f4_arg0.Prompt2:completeAnimation()
	f4_arg0.Prompt2:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_73524F3946846790"))
end
CoD.veTransitionPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	exterior = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	interior = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Prompt2:completeAnimation()
			f7_arg0.Prompt2:setText(Engine[@"hash_4F9F1239CFD921FE"](0x7DA41F4105CA4E))
			f7_arg0.clipFinished(f7_arg0.Prompt2)
		end,
	},
}
CoD.veTransitionPrompt.__onClose = function(f8_arg0) end
