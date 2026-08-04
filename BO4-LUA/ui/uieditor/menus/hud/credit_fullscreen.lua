require("ui/uieditor/widgets/hud/fadingskipprompt")
CoD.Credit_Fullscreen = InheritFrom(CoD.Menu)
LUI.createMenu.Credit_Fullscreen = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("Credit_Fullscreen", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.InitControllerModel(f1_arg0, "CreditsFinished", false)
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	self:setClass(CoD.Credit_Fullscreen)
	self.soundSet = "HUD"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local ImageWithButtonPrompt = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ImageWithButtonPrompt:setRGB(0, 0, 0)
	self:addElement(ImageWithButtonPrompt)
	self.ImageWithButtonPrompt = ImageWithButtonPrompt
	local Credit0 = LUI.UIElement.new(0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Credit0)
	self.Credit0 = Credit0
	local skipPrompt = CoD.FadingSkipPrompt.new(f1_local1, f1_arg0, 1, 1, -1824, -96, 1, 1, -89, -51)
	self:addElement(skipPrompt)
	self.skipPrompt = skipPrompt
	local speedUpPrompt = CoD.FadingSkipPrompt.new(f1_local1, f1_arg0, 1, 1, -1824, -96, 1, 1, -126, -88)
	speedUpPrompt.pressXtext:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7E839A39F74BC0A2"))
	self:addElement(speedUpPrompt)
	self.speedUpPrompt = speedUpPrompt
	self:mergeStateConditions({
		{
			stateName = "KBMouse",
			condition = function(menu, element, event)
				local f2_local0
				if not IsGamepad(f1_arg0) then
					f2_local0 = IsPC()
				else
					f2_local0 = false
				end
				return f2_local0
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f3_arg0, f3_arg1)
		f3_arg1.menu = f3_arg1.menu or f1_local1
		f1_local1:updateElementState(self, f3_arg1)
	end)
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine.GetModelForController(f1_arg0)
	f1_local7(f1_local6, f1_local8.LastInput, function(f4_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f4_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self.__on_menuOpened_self = function(f5_arg0, f5_arg1, f5_arg2, f5_arg3)
		local f5_local0 = self
		CoD.BaseUtility.PlayMusic("credits")
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		ResetFrontendMusic(f1_arg0)
	end)
	self:subscribeToGlobalModel(f1_arg0, "PerController", "CreditsFinished", function(model)
		local f7_local0 = self
		if CoD.ModelUtility.IsParamModelEqualTo(model, true) then
			GoBack(self, f1_arg0)
		end
	end)
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__on_close_removeOverrides = function()
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local7 = self
	CoD.DirectorUtility.CreditsPostLoad(self, f1_arg0)
	return self
end
CoD.Credit_Fullscreen.__resetProperties = function(f9_arg0)
	f9_arg0.speedUpPrompt:completeAnimation()
	f9_arg0.skipPrompt:completeAnimation()
	f9_arg0.speedUpPrompt:setAlpha(1)
	f9_arg0.speedUpPrompt.pressXtext:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7E839A39F74BC0A2"))
	f9_arg0.skipPrompt.pressXtext:setText(Engine[@"hash_4F9F1239CFD921FE"](@"platform/skip"))
end
CoD.Credit_Fullscreen.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
	KBMouse = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.skipPrompt:completeAnimation()
			f11_arg0.skipPrompt.pressXtext:completeAnimation()
			f11_arg0.skipPrompt.pressXtext:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_CA29A669EA5CBCE"))
			f11_arg0.clipFinished(f11_arg0.skipPrompt)
			f11_arg0.speedUpPrompt:completeAnimation()
			f11_arg0.speedUpPrompt.pressXtext:completeAnimation()
			f11_arg0.speedUpPrompt:setAlpha(1)
			f11_arg0.speedUpPrompt.pressXtext:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6A926B4D0908C555"))
			f11_arg0.clipFinished(f11_arg0.speedUpPrompt)
		end,
	},
}
CoD.Credit_Fullscreen.__onClose = function(f12_arg0)
	f12_arg0.__on_close_removeOverrides()
	f12_arg0.skipPrompt:close()
	f12_arg0.speedUpPrompt:close()
end
