require("ui/uieditor/widgets/common/commonheadertext")
require("ui/uieditor/widgets/store/storecommontextbacking")
CoD.CommonHeader = InheritFrom(LUI.UIElement)
CoD.CommonHeader.__defaultWidth = 1920
CoD.CommonHeader.__defaultHeight = 67
CoD.CommonHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonHeader)
	self.id = "CommonHeader"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BGSceneBlur = LUI.UIImage.new(-0.1, 1.1, 0, 0, 0, 0, -15, 52)
	BGSceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
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
	local background2 = LUI.UIImage.new(-0.1, 1.1, 0, 0, 0, 0, -15, 52)
	background2:setRGB(0.13, 0.13, 0.13)
	background2:setAlpha(0.9)
	background2:registerEventHandler("menu_loaded", function(element, event)
		local f3_local0 = nil
		if element.menuLoaded then
			f3_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f3_local0 = element.super:menuLoaded(event)
		end
		if IsPC() then
			SizeToWidthOfScreen(element, f1_arg1)
		end
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	self:addElement(background2)
	self.background2 = background2
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, -0.2, 2.3, -1344, -1344, 0, 0, 10, 52)
	DotTiledBacking:setAlpha(0.5)
	DotTiledBacking.NoiseBacking:setAlpha(0)
	DotTiledBacking:registerEventHandler("menu_loaded", function(element, event)
		local f4_local0 = nil
		if element.menuLoaded then
			f4_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f4_local0 = element.super:menuLoaded(event)
		end
		if IsPC() then
			SizeToWidthOfScreen(element, f1_arg1)
		end
		if not f4_local0 then
			f4_local0 = element:dispatchEventToChildren(event)
		end
		return f4_local0
	end)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local TopBar2 = LUI.UIImage.new(-0.65, 1.85, -192, -192, 0, 0, 50, 53)
	TopBar2:setRGB(0.46, 0.46, 0.51)
	TopBar2:setAlpha(0.8)
	TopBar2:setImage(RegisterImage("uie_ui_menu_cac_primary_button_top_bar"))
	TopBar2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	TopBar2:setShaderVector(0, 2, 0, 0, 0)
	TopBar2:registerEventHandler("menu_loaded", function(element, event)
		local f5_local0 = nil
		if element.menuLoaded then
			f5_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f5_local0 = element.super:menuLoaded(event)
		end
		if IsPC() then
			SizeToWidthOfScreen(element, f1_arg1)
		end
		if not f5_local0 then
			f5_local0 = element:dispatchEventToChildren(event)
		end
		return f5_local0
	end)
	self:addElement(TopBar2)
	self.TopBar2 = TopBar2
	local subtitle = CoD.CommonHeaderText.new(f1_arg0, f1_arg1, 0, 0, 25, 1059, 0, 0, 18, 46)
	subtitle.StageTitle:setText(LocalizeToUpperString("mpui/aar_caps"))
	subtitle:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyTitle", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f6_local0))
		end
	end)
	self:addElement(subtitle)
	self.subtitle = subtitle
	self:mergeStateConditions({
		{
			stateName = "ZombiesPC",
			condition = function(menu, element, event)
				return IsPC() and IsZombies()
			end,
		},
		{
			stateName = "DefaultPC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
		{
			stateName = "Zombies",
			condition = function(menu, element, event)
				return IsZombies()
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine.GetGlobalModel()
	f1_local7(f1_local6, f1_local8["lobbyRoot.lobbyNav"], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CommonHeader.__resetProperties = function(f11_arg0)
	f11_arg0.TopBar2:completeAnimation()
	f11_arg0.subtitle:completeAnimation()
	f11_arg0.TopBar2:setRGB(0.46, 0.46, 0.51)
	f11_arg0.TopBar2:setAlpha(0.8)
	f11_arg0.TopBar2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	f11_arg0.TopBar2:setShaderVector(0, 2, 0, 0, 0)
	f11_arg0.subtitle:setLeftRight(0, 0, 25, 1059)
end
CoD.CommonHeader.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
	ZombiesPC = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.TopBar2:completeAnimation()
			f13_arg0.TopBar2:setRGB(0.83, 0.11, 0.01)
			f13_arg0.TopBar2:setAlpha(1)
			f13_arg0.TopBar2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
			f13_arg0.TopBar2:setShaderVector(0, 2, 0, 0, 0)
			f13_arg0.clipFinished(f13_arg0.TopBar2)
			f13_arg0.subtitle:completeAnimation()
			f13_arg0.subtitle:setLeftRight(0.5, 0.5, -935, 99)
			f13_arg0.clipFinished(f13_arg0.subtitle)
		end,
	},
	DefaultPC = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.subtitle:completeAnimation()
			f14_arg0.subtitle:setLeftRight(0.5, 0.5, -935, 99)
			f14_arg0.clipFinished(f14_arg0.subtitle)
		end,
	},
	Zombies = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.TopBar2:completeAnimation()
			f15_arg0.TopBar2:setRGB(0.83, 0.11, 0.01)
			f15_arg0.TopBar2:setAlpha(1)
			f15_arg0.TopBar2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
			f15_arg0.TopBar2:setShaderVector(0, 2, 0, 0, 0)
			f15_arg0.clipFinished(f15_arg0.TopBar2)
		end,
	},
}
CoD.CommonHeader.__onClose = function(f16_arg0)
	f16_arg0.DotTiledBacking:close()
	f16_arg0.subtitle:close()
end
