require("x64:7c5a5334738ad1e")
CoD.MPHintText = InheritFrom(CoD.Menu)
LUI.createMenu.MPHintText = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("MPHintText", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.MPHintText)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local MPHintTextContainer = CoD.MPHintTextContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -864, 864, 1, 1, -272, -233)
	self:addElement(MPHintTextContainer)
	self.MPHintTextContainer = MPHintTextContainer
	self.MPHintTextContainer:linkToElementModel(self, "hint_text_line", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MPHintTextContainer.MPHintText:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
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
CoD.MPHintText.__onClose = function(f3_arg0)
	f3_arg0.MPHintTextContainer:close()
end
