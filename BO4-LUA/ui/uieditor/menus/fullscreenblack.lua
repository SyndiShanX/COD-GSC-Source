require("x64:e813280582af4f1")
local f0_local0 = function(f1_arg0)
	if f1_arg0.red and f1_arg0.green and f1_arg0.blue then
		f1_arg0.Fullscreen:setRGB(f1_arg0.red, f1_arg0.green, f1_arg0.blue)
	end
end
local PostLoadFunc = function(f2_arg0)
	local f2_local0 = f2_arg0:getModel(Engine[@"getprimarycontroller"](), "fadeOverTime")
	local f2_local1 = f2_arg0:getModel(Engine[@"getprimarycontroller"](), "red")
	local f2_local2 = f2_arg0:getModel(Engine[@"getprimarycontroller"](), "green")
	local f2_local3 = f2_arg0:getModel(Engine[@"getprimarycontroller"](), "blue")
	if f2_local1 then
		f2_arg0:subscribeToModel(f2_local1, function(model)
			local f3_local0 = Engine[@"getmodelvalue"](model)
			if f3_local0 then
				f2_arg0.red = f3_local0
				f0_local0(f2_arg0)
			end
		end)
	end
	if f2_local2 then
		f2_arg0:subscribeToModel(f2_local2, function(model)
			local f4_local0 = Engine[@"getmodelvalue"](model)
			if f4_local0 then
				f2_arg0.green = f4_local0
				f0_local0(f2_arg0)
			end
		end)
	end
	if f2_local3 then
		f2_arg0:subscribeToModel(f2_local3, function(model)
			local f5_local0 = Engine[@"getmodelvalue"](model)
			if f5_local0 then
				f2_arg0.blue = f5_local0
				f0_local0(f2_arg0)
			end
		end)
	end
	if f2_local0 then
		f2_arg0:subscribeToModel(f2_local0, function(model)
			local f6_local0 = Engine[@"getmodelvalue"](model)
			local f6_local1 = f2_arg0:getModel(Engine[@"getprimarycontroller"](), "startAlpha")
			local f6_local2 = f2_arg0:getModel(Engine[@"getprimarycontroller"](), "endAlpha")
			local f6_local3 = 0
			local f6_local4 = 0
			if f6_local1 then
				f6_local3 = Engine[@"getmodelvalue"](f6_local1)
			end
			if f6_local2 then
				f6_local4 = Engine[@"getmodelvalue"](f6_local2)
			end
			if f6_local0 then
				if f6_local4 == 0 then
					if f6_local3 == 0 or f6_local0 == 0 then
						CoD.Menu.RemoveFromCurrMenuNameList(f2_arg0.menuName)
					else
						f2_arg0.Fullscreen:registerEventHandler("clip_over", function(element, event)
							element.Fullscreen:registerEventHandler("clip_over", CoD.NullFunction)
							CoD.Menu.RemoveFromCurrMenuNameList(element.menuName)
						end)
					end
				else
					CoD.Menu.AddToCurrMenuNameList(f2_arg0.menuName)
				end
				if f6_local3 >= 0 then
					f2_arg0.Fullscreen:setAlpha(f6_local3)
				end
				f2_arg0.Fullscreen:beginAnimation("fadeOverTime", f6_local0)
				f2_arg0.Fullscreen:setAlpha(f6_local4)
			end
		end)
	end
end
CoD.FullScreenBlack = InheritFrom(CoD.Menu)
LUI.createMenu.FullScreenBlack = function(f8_arg0, f8_arg1)
	local self = CoD.Menu.NewForUIEditor("FullScreenBlack", f8_arg0)
	local f8_local1 = self
	SetProperty(self, "disableInputLock", true)
	self:setClass(CoD.FullScreenBlack)
	self.soundSet = "none"
	self:setOwner(f8_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f8_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	local Fullscreen = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Fullscreen)
	self.Fullscreen = Fullscreen
	local InGameTalkersWidget = CoD.InGameTalkersWidget.new(f8_local1, f8_arg0, 0, 0, 95.5, 380.5, 0, 0, 54, 184)
	InGameTalkersWidget:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not IsMultiplayer()
			end,
		},
	})
	local f8_local4 = InGameTalkersWidget
	local f8_local5 = InGameTalkersWidget.subscribeToModel
	local f8_local6 = Engine[@"getglobalmodel"]()
	f8_local5(f8_local4, f8_local6["lobbyRoot.lobbyNav"], function(f10_arg0)
		f8_local1:updateElementState(InGameTalkersWidget, {
			name = "model_validation",
			menu = f8_local1,
			controller = f8_arg0,
			modelValue = f10_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	self:addElement(InGameTalkersWidget)
	self.InGameTalkersWidget = InGameTalkersWidget
	self.Fullscreen:linkToElementModel(self, "color", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			Fullscreen:setRGB(f11_local0)
		end
	end)
	InGameTalkersWidget.id = "InGameTalkersWidget"
	self:processEvent({
		name = "menu_loaded",
		controller = f8_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f8_arg0)
	end
	return self
end
CoD.FullScreenBlack.__onClose = function(f12_arg0)
	f12_arg0.Fullscreen:close()
	f12_arg0.InGameTalkersWidget:close()
end
