require("x64:5b49a25d663c403")
CoD.FreeCursor = InheritFrom(CoD.Menu)
LUI.createMenu.FreeCursor = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("FreeCursor", f1_arg0)
	local f1_local1 = self
	SetProperty(self, "ignoreCursor", true)
	self:setClass(CoD.FreeCursor)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local freeCursorWidget0 = CoD.freeCursorWidget.new(f1_local1, f1_arg0, 0, 0, 0, 140, 0, 0, 0, 140)
	freeCursorWidget0:subscribeToGlobalModel(f1_arg0, "FreeCursor", nil, function(model)
		freeCursorWidget0:setModel(model, f1_arg0)
	end)
	self:addElement(freeCursorWidget0)
	self.freeCursorWidget0 = freeCursorWidget0
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not IsFreeCursorActiveAndVisible(f1_arg0)
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = DataSources.FreeCursor.getModel(f1_arg0)
	f1_local4(f1_local3, f1_local5.usingCursorInput, function(f4_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f4_arg0:get(),
			modelName = "usingCursorInput",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = DataSources.FreeCursor.getModel(f1_arg0)
	f1_local4(f1_local3, f1_local5.hidden, function(f5_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f5_arg0:get(),
			modelName = "hidden",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local4(f1_local3, f1_local5.activeKeys, function(f6_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f6_arg0:get(),
			modelName = "activeKeys",
		})
	end, false)
	freeCursorWidget0.id = "freeCursorWidget0"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local4 = self
	CallCustomElementFunction_Self(self, "setPriority", 1000)
	SetProperty(self, "m_inputDisabled", true)
	return self
end
CoD.FreeCursor.__resetProperties = function(f7_arg0)
	f7_arg0.freeCursorWidget0:completeAnimation()
	f7_arg0.freeCursorWidget0:setAlpha(1)
end
CoD.FreeCursor.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.freeCursorWidget0:completeAnimation()
			f9_arg0.freeCursorWidget0:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.freeCursorWidget0)
		end,
	},
}
CoD.FreeCursor.__onClose = function(f10_arg0)
	f10_arg0.freeCursorWidget0:close()
end
