local f0_local0 = function(f1_arg0)
	if f1_arg0.red and f1_arg0.green and f1_arg0.blue then
		f1_arg0:setRGB(f1_arg0.red, f1_arg0.green, f1_arg0.blue)
	end
end
local PostLoadFunc = function(self, controller)
	local f2_local0 = self:getModel()
	self.red = 1
	self.green = 1
	self.blue = 1
	if f2_local0.alpha then
		self:subscribeToModel(f2_local0.alpha, function(model)
			local modelValue = Engine.GetModelValue(model)
			if modelValue then
				self.alpha = modelValue
				self.Text:beginAnimation(f2_local0.fadeOverTime:get() * 100)
				self.Text:setAlpha(self.alpha)
			end
		end)
	end
	if f2_local0.height then
		self:subscribeToModel(f2_local0.height, function(model)
			local modelValue = Engine.GetModelValue(model)
			if modelValue then
				self.Text:setHeight(CoD.setTextSizeFromHeightEnum(modelValue))
			end
		end)
	end
	if f2_local0.red then
		self:subscribeToModel(f2_local0.red, function(model)
			local modelValue = Engine.GetModelValue(model)
			if modelValue then
				self.red = modelValue
				f0_local0(self)
			end
		end)
	end
	if f2_local0.green then
		self:subscribeToModel(f2_local0.green, function(model)
			local modelValue = Engine.GetModelValue(model)
			if modelValue then
				self.green = modelValue
				f0_local0(self)
			end
		end)
	end
	if f2_local0.blue then
		self:subscribeToModel(f2_local0.blue, function(model)
			local modelValue = Engine.GetModelValue(model)
			if modelValue then
				self.blue = modelValue
				f0_local0(self)
			end
		end)
	end
	if f2_local0.horizontal_alignment then
		self:subscribeToModel(f2_local0.horizontal_alignment, function(model)
			local modelValue = Engine.GetModelValue(model)
			self.Text:setAlignment(modelValue)
			if modelValue == 1 then
				self.Text:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
			elseif modelValue == 2 then
				self.Text:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
			elseif modelValue == 3 then
				self.Text:setAlignment(Enum.LUIAlignment[@"lui_alignment_right"])
			end
		end)
	end
end
CoD.LUIelemText = InheritFrom(CoD.Menu)
LUI.createMenu.LUIelemText = function(f9_arg0, f9_arg1)
	local self = CoD.Menu.NewForUIEditor("LUIelemText", f9_arg0)
	local f9_local1 = self
	self:setClass(CoD.LUIelemText)
	self.soundSet = "default"
	self:setOwner(f9_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f9_arg0)
	self.ignoreCursor = true
	local Text = LUI.UIText.new(0, 1, 30, 30, 0, 0, 30, 67)
	Text:setTTF("default")
	Text:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	Text:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	Text:linkToElementModel(self, "x", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			Text:setLeftPx(Multiple(15, f10_local0))
		end
	end)
	Text:linkToElementModel(self, "y", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			Text:setTopPx(Multiple(15, f11_local0))
		end
	end)
	Text:linkToElementModel(self, "text", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			Text:setText(Engine[@"hash_4F9F1239CFD921FE"](f12_local0))
		end
	end)
	self:addElement(Text)
	self.Text = Text
	self:registerEventHandler("menu_loaded", function(element, event)
		local f13_local0 = nil
		if element.menuLoaded then
			f13_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f13_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(self, f9_arg0)
		if not f13_local0 then
			f13_local0 = element:dispatchEventToChildren(event)
		end
		return f13_local0
	end)
	self:processEvent({
		name = "menu_loaded",
		controller = f9_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f9_arg0)
	end
	return self
end
CoD.LUIelemText.__onClose = function(f14_arg0)
	f14_arg0.Text:close()
end
