require("x64:330e1ef77701a18")
CoD.mp_prop_timer = InheritFrom(CoD.Menu)
LUI.createMenu.mp_prop_timer = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("mp_prop_timer", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.mp_prop_timer)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local RadialTimer = CoD.RadialTimer.new(f1_local1, f1_arg0, 0.5, 0.5, -75, 75, 0.5, 0.5, -121, 29)
	RadialTimer:linkToElementModel(self, "timeRemaining", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			RadialTimer.Clock:setShaderVector(0, SetVectorComponent(0, 0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4)))
		end
	end)
	RadialTimer:linkToElementModel(self, "timeRemaining", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			RadialTimer.TimeText:setText(CoD.BaseUtility.AlreadyLocalized(f3_local0))
		end
	end)
	self:addElement(RadialTimer)
	self.RadialTimer = RadialTimer
	local TextBox = LUI.UIText.new(0.5, 0.5, -587, 587, 0.5, 0.5, -142, -100)
	TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2470E5C5DDEDDE54"))
	TextBox:setTTF("default")
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(TextBox)
	self.TextBox = TextBox
	self:mergeStateConditions({
		{
			stateName = "prop",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(self, f1_arg0, "isProp", 0)
			end,
		},
	})
	self:linkToElementModel(self, "isProp", true, function(model)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "isProp",
		})
	end)
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	SetElementPriority(self, -1)
	return self
end
CoD.mp_prop_timer.__resetProperties = function(f6_arg0)
	f6_arg0.TextBox:completeAnimation()
	f6_arg0.TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2470E5C5DDEDDE54"))
end
CoD.mp_prop_timer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.TextBox:completeAnimation()
			f7_arg0.TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1BB4BF1BB569F057"))
			f7_arg0.clipFinished(f7_arg0.TextBox)
		end,
	},
	prop = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.TextBox:completeAnimation()
			f8_arg0.TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2470E5C5DDEDDE54"))
			f8_arg0.clipFinished(f8_arg0.TextBox)
		end,
	},
}
CoD.mp_prop_timer.__onClose = function(f9_arg0)
	f9_arg0.RadialTimer:close()
end
