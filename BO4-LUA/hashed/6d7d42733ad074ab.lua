require("x64:c895a4bfe820366")
CoD.CharacterSelection_FeaturedGamesList = InheritFrom(LUI.UIElement)
CoD.CharacterSelection_FeaturedGamesList.__defaultWidth = 320
CoD.CharacterSelection_FeaturedGamesList.__defaultHeight = 64
CoD.CharacterSelection_FeaturedGamesList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.CharacterSelection_FeaturedGamesList)
	self.id = "CharacterSelection_FeaturedGamesList"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local WaW = CoD.CharacterSelection_FeaturedGamesIcon.new(f1_arg0, f1_arg1, 0, 0, 0, 64, 0, 0, 0, 64)
	WaW:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "characterInT4")
			end,
		},
	})
	WaW:linkToElementModel(WaW, "characterInT4", true, function(model)
		f1_arg0:updateElementState(WaW, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "characterInT4",
		})
	end)
	WaW.GameIcon:setImage(RegisterImage(@"hash_3965E33060D4686"))
	WaW:linkToElementModel(self, nil, false, function(model)
		WaW:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(WaW, "setState", function(element, controller, f5_arg2, f5_arg3, f5_arg4)
		if IsElementInState(element, "Visible") then
			ShowWidget(element)
		else
			HideWidget(element)
		end
	end)
	self:addElement(WaW)
	self.WaW = WaW
	local BO1 = CoD.CharacterSelection_FeaturedGamesIcon.new(f1_arg0, f1_arg1, 0, 0, 64, 128, 0, 0, 0, 64)
	BO1:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "characterInT5")
			end,
		},
	})
	BO1:linkToElementModel(BO1, "characterInT5", true, function(model)
		f1_arg0:updateElementState(BO1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "characterInT5",
		})
	end)
	BO1.GameIcon:setImage(RegisterImage(@"hash_2534F132D0D9461D"))
	BO1:linkToElementModel(self, nil, false, function(model)
		BO1:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(BO1, "setState", function(element, controller, f9_arg2, f9_arg3, f9_arg4)
		if IsElementInState(element, "Visible") then
			ShowWidget(element)
		else
			HideWidget(element)
		end
	end)
	self:addElement(BO1)
	self.BO1 = BO1
	local BO2 = CoD.CharacterSelection_FeaturedGamesIcon.new(f1_arg0, f1_arg1, 0, 0, 128, 192, 0, 0, 0, 64)
	BO2:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "characterInT6")
			end,
		},
	})
	BO2:linkToElementModel(BO2, "characterInT6", true, function(model)
		f1_arg0:updateElementState(BO2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "characterInT6",
		})
	end)
	BO2.GameIcon:setImage(RegisterImage(@"hash_2534EE32D0D94104"))
	BO2:linkToElementModel(self, nil, false, function(model)
		BO2:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(BO2, "setState", function(element, controller, f13_arg2, f13_arg3, f13_arg4)
		if IsElementInState(element, "Visible") then
			ShowWidget(element)
		else
			HideWidget(element)
		end
	end)
	self:addElement(BO2)
	self.BO2 = BO2
	local BO3 = CoD.CharacterSelection_FeaturedGamesIcon.new(f1_arg0, f1_arg1, 0, 0, 192, 256, 0, 0, 0, 64)
	BO3:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "characterInT7")
			end,
		},
	})
	BO3:linkToElementModel(BO3, "characterInT7", true, function(model)
		f1_arg0:updateElementState(BO3, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "characterInT7",
		})
	end)
	BO3.GameIcon:setImage(RegisterImage(@"hash_2534EF32D0D942B7"))
	BO3:linkToElementModel(self, nil, false, function(model)
		BO3:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(BO3, "setState", function(element, controller, f17_arg2, f17_arg3, f17_arg4)
		if IsElementInState(element, "Visible") then
			ShowWidget(element)
		else
			HideWidget(element)
		end
	end)
	self:addElement(BO3)
	self.BO3 = BO3
	local BO4 = CoD.CharacterSelection_FeaturedGamesIcon.new(f1_arg0, f1_arg1, 0, 0, 256, 320, 0, 0, 0, 64)
	BO4:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "characterInT8")
			end,
		},
	})
	BO4:linkToElementModel(BO4, "characterInT8", true, function(model)
		f1_arg0:updateElementState(BO4, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "characterInT8",
		})
	end)
	BO4.GameIcon:setImage(RegisterImage(@"hash_2534EC32D0D93D9E"))
	BO4:linkToElementModel(self, nil, false, function(model)
		BO4:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(BO4, "setState", function(element, controller, f21_arg2, f21_arg3, f21_arg4)
		if IsElementInState(element, "Visible") then
			ShowWidget(element)
		else
			HideWidget(element)
		end
	end)
	self:addElement(BO4)
	self.BO4 = BO4
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CharacterSelection_FeaturedGamesList.__onClose = function(f22_arg0)
	f22_arg0.WaW:close()
	f22_arg0.BO1:close()
	f22_arg0.BO2:close()
	f22_arg0.BO3:close()
	f22_arg0.BO4:close()
end
