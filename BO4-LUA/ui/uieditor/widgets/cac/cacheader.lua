require("x64:90a34f5358801a")
require("x64:ce70b402442139b")
require("x64:19c1945d2e472b0")
CoD.CACHeader = InheritFrom(LUI.UIElement)
CoD.CACHeader.__defaultWidth = 1920
CoD.CACHeader.__defaultHeight = 67
CoD.CACHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CACHeader)
	self.id = "CACHeader"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BGSceneBlur = LUI.UIImage.new(-0.1, 1.1, 0, 0, 0, 0, -15, 52)
	BGSceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	BGSceneBlur:setShaderVector(0, 0, 0, 0, 0)
	BGSceneBlur:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		if IsPC() then
			SizeToWidthOfScreen(element, f1_arg1)
		end
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(BGSceneBlur)
	self.BGSceneBlur = BGSceneBlur
	local f1_local2 = nil
	self.background2 = LUI.UIElement.createFake()
	local ingamePCBacking = nil
	ingamePCBacking = LUI.UIImage.new(-0.1, 1.1, 0, 0, 0, 0, -15, 52)
	ingamePCBacking:setRGB(0.09, 0.09, 0.09)
	ingamePCBacking:setAlpha(0.5)
	ingamePCBacking:registerEventHandler("menu_loaded", function(element, event)
		local f3_local0 = nil
		if element.menuLoaded then
			f3_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f3_local0 = element.super:menuLoaded(event)
		end
		if InFrontend() then
			HideWidget(element)
		else
			SizeToWidthOfScreen(element, f1_arg1)
		end
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	self:addElement(ingamePCBacking)
	self.ingamePCBacking = ingamePCBacking
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, -0.2, 2.3, -1344, -1344, 0, 0, 10, 52)
	DotTiledBacking:setAlpha(0.5)
	DotTiledBacking.NoiseBacking:setAlpha(0)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local allocation = CoD.ClassAllocation.new(f1_arg0, f1_arg1, 0.5, 0.5, 513, 960, 0, 0, 21.5, 45.5)
	allocation:linkToElementModel(self, nil, false, function(model)
		allocation:setModel(model, f1_arg1)
	end)
	allocation:registerEventHandler("update_class", function(element, event)
		local f5_local0 = nil
		UpdateAllocationBar(self, element, f1_arg1)
		if not f5_local0 then
			f5_local0 = element:dispatchEventToChildren(event)
		end
		return f5_local0
	end)
	self:addElement(allocation)
	self.allocation = allocation
	local TopBar2 = LUI.UIImage.new(-0.65, 1.85, -192, -192, 0, 0, 50, 53)
	TopBar2:setRGB(0.46, 0.46, 0.51)
	TopBar2:setAlpha(0.8)
	TopBar2:setImage(RegisterImage(0x42BCCF45B82FBED))
	TopBar2:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	TopBar2:setShaderVector(0, 2, 0, 0, 0)
	TopBar2:registerEventHandler("menu_loaded", function(element, event)
		local f6_local0 = nil
		if element.menuLoaded then
			f6_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f6_local0 = element.super:menuLoaded(event)
		end
		if IsPC() then
			SizeToWidthOfScreen(element, f1_arg1)
		end
		if not f6_local0 then
			f6_local0 = element:dispatchEventToChildren(event)
		end
		return f6_local0
	end)
	self:addElement(TopBar2)
	self.TopBar2 = TopBar2
	local subtitle = CoD.CommonHeaderText.new(f1_arg0, f1_arg1, 0.5, 0.5, -926.5, 107.5, 0, 0, 16, 46)
	subtitle.StageTitle:setText(LocalizeToUpperString(0xEEF90B1483C4C23))
	subtitle:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyTitle", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f7_local0))
		end
	end)
	self:addElement(subtitle)
	self.subtitle = subtitle
	self:mergeStateConditions({
		{
			stateName = "MultiplayerPC",
			condition = function(menu, element, event)
				return IsPC() and IsMultiplayer()
			end,
		},
		{
			stateName = "ZombiesPC",
			condition = function(menu, element, event)
				return IsPC() and IsZombies()
			end,
		},
		{
			stateName = "WarzonePC",
			condition = function(menu, element, event)
				return IsPC() and IsWarzone()
			end,
		},
		{
			stateName = "ArenaPC",
			condition = function(menu, element, event)
				return IsPC() and IsArenaMode()
			end,
		},
		{
			stateName = "DefaultPC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
		{
			stateName = "Arena",
			condition = function(menu, element, event)
				return IsArenaMode()
			end,
		},
		{
			stateName = "Warzone",
			condition = function(menu, element, event)
				return IsWarzone()
			end,
		},
		{
			stateName = "Zombies",
			condition = function(menu, element, event)
				return IsZombies()
			end,
		},
		{
			stateName = "Multiplayer",
			condition = function(menu, element, event)
				return IsMultiplayer()
			end,
		},
	})
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[0x8DF2E5447F384B9]()
	f1_local9(f1_local8, f1_local10["lobbyRoot.lobbyNav"], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CACHeader.__resetProperties = function(f18_arg0)
	f18_arg0.allocation:completeAnimation()
	f18_arg0.TopBar2:completeAnimation()
	f18_arg0.allocation:setAlpha(1)
	f18_arg0.TopBar2:setRGB(0.46, 0.46, 0.51)
	f18_arg0.TopBar2:setAlpha(0.8)
	f18_arg0.TopBar2:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	f18_arg0.TopBar2:setShaderVector(0, 2, 0, 0, 0)
end
CoD.CACHeader.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.allocation:completeAnimation()
			f19_arg0.allocation:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.allocation)
		end,
	},
	MultiplayerPC = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(0)
		end,
	},
	ZombiesPC = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.TopBar2:completeAnimation()
			f21_arg0.TopBar2:setRGB(0.83, 0.11, 0.01)
			f21_arg0.TopBar2:setAlpha(1)
			f21_arg0.TopBar2:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
			f21_arg0.TopBar2:setShaderVector(0, 2, 0, 0, 0)
			f21_arg0.clipFinished(f21_arg0.TopBar2)
		end,
	},
	WarzonePC = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(0)
		end,
	},
	ArenaPC = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(0)
		end,
	},
	DefaultPC = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(0)
		end,
	},
	Arena = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(0)
		end,
	},
	Warzone = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(0)
		end,
	},
	Zombies = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(2)
			f27_arg0.allocation:completeAnimation()
			f27_arg0.allocation:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.allocation)
			f27_arg0.TopBar2:completeAnimation()
			f27_arg0.TopBar2:setRGB(0.83, 0.11, 0.01)
			f27_arg0.TopBar2:setAlpha(1)
			f27_arg0.TopBar2:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
			f27_arg0.TopBar2:setShaderVector(0, 2, 0, 0, 0)
			f27_arg0.clipFinished(f27_arg0.TopBar2)
		end,
	},
	Multiplayer = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.CACHeader.__onClose = function(f29_arg0)
	f29_arg0.DotTiledBacking:close()
	f29_arg0.allocation:close()
	f29_arg0.subtitle:close()
end
