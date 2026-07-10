require("x64:ce1e6b6549d478c")
CoD.AARPrestigeMasterOverlay = InheritFrom(CoD.Menu)
LUI.createMenu.AARPrestigeMasterOverlay = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("AARPrestigeMasterOverlay", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.AARPrestigeMasterOverlay)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local BlurBg = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlurBg:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	BlurBg:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlurBg)
	self.BlurBg = BlurBg
	local FractalGrid = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	FractalGrid:setAlpha(0.02)
	FractalGrid:setImage(RegisterImage(0x1DF4C930E69FFB0))
	FractalGrid:setMaterial(LUI.UIImage.GetCachedMaterial(0xD8EA9FE9B0BCF75))
	FractalGrid:setShaderVector(0, 1, 1, 0, 0)
	FractalGrid:setShaderVector(1, 0, 0, 0, 0)
	self:addElement(FractalGrid)
	self.FractalGrid = FractalGrid
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0, 0, 0)
	Backing:setAlpha(0.9)
	self:addElement(Backing)
	self.Backing = Backing
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local MasterPrestigeImage = LUI.UIImage.new(0.5, 0.5, -233.5, 233.5, 0.5, 0.5, -233.5, 233.5)
	MasterPrestigeImage:setImage(RegisterImage(0xCC0270C9E85AEDF))
	self:addElement(MasterPrestigeImage)
	self.MasterPrestigeImage = MasterPrestigeImage
	local MasterPrestigeTitle = LUI.UIText.new(0.5, 0.5, -500, 500, 0, 0, 210, 258)
	MasterPrestigeTitle:setText(Engine[0xF9F1239CFD921FE](0x2EB662C892747AB))
	MasterPrestigeTitle:setTTF("ttmussels_demibold")
	MasterPrestigeTitle:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	MasterPrestigeTitle:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(MasterPrestigeTitle)
	self.MasterPrestigeTitle = MasterPrestigeTitle
	local DescriptionText1 = LUI.UIText.new(0.5, 0.5, -500, 500, 0, 0, 784, 821)
	DescriptionText1:setText(Engine[0xF9F1239CFD921FE](0x122E59E4E76F889))
	DescriptionText1:setTTF("ttmussels_demibold")
	DescriptionText1:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	DescriptionText1:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(DescriptionText1)
	self.DescriptionText1 = DescriptionText1
	local DescriptionText2 = LUI.UIText.new(0.5, 0.5, -600, 600, 0, 0, 865, 895)
	DescriptionText2:setText(Engine[0xF9F1239CFD921FE](0x5684EEBE6F89B7C))
	DescriptionText2:setTTF("ttmussels_regular")
	DescriptionText2:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	DescriptionText2:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(DescriptionText2)
	self.DescriptionText2 = DescriptionText2
	self:mergeStateConditions({
		{
			stateName = "ZM",
			condition = function(menu, element, event)
				return IsZombies()
			end,
		},
		{
			stateName = "WZ",
			condition = function(menu, element, event)
				return IsWarzone()
			end,
		},
	})
	local f1_local10 = self
	local f1_local11 = self.subscribeToModel
	local f1_local12 = Engine[0x8DF2E5447F384B9]()
	f1_local11(f1_local10, f1_local12["lobbyRoot.lobbyNav"], function(f5_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		CoD.AARUtility.CloseLevelUpOverlay(menu, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x6393FF34EA56966, nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		if IsPC() then
			CoD.AARUtility.CloseLevelUpOverlay(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
			return true
		else
			return false
		end
	end, false)
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
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
CoD.AARPrestigeMasterOverlay.__resetProperties = function(f10_arg0)
	f10_arg0.DescriptionText2:completeAnimation()
	f10_arg0.DescriptionText1:completeAnimation()
	f10_arg0.MasterPrestigeTitle:completeAnimation()
	f10_arg0.MasterPrestigeImage:completeAnimation()
	f10_arg0.DescriptionText2:setAlpha(1)
	f10_arg0.DescriptionText1:setAlpha(1)
	f10_arg0.DescriptionText1:setText(Engine[0xF9F1239CFD921FE](0x122E59E4E76F889))
	f10_arg0.MasterPrestigeTitle:setAlpha(1)
	f10_arg0.MasterPrestigeImage:setAlpha(1)
	f10_arg0.MasterPrestigeImage:setImage(RegisterImage(0xCC0270C9E85AEDF))
end
CoD.AARPrestigeMasterOverlay.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(4)
			local f11_local0 = function(f12_arg0)
				f11_arg0.MasterPrestigeImage:beginAnimation(120)
				f11_arg0.MasterPrestigeImage:setAlpha(1)
				f11_arg0.MasterPrestigeImage:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.MasterPrestigeImage:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.MasterPrestigeImage:completeAnimation()
			f11_arg0.MasterPrestigeImage:setAlpha(0)
			f11_local0(f11_arg0.MasterPrestigeImage)
			local f11_local1 = function(f13_arg0)
				f11_arg0.MasterPrestigeTitle:beginAnimation(120)
				f11_arg0.MasterPrestigeTitle:setAlpha(1)
				f11_arg0.MasterPrestigeTitle:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.MasterPrestigeTitle:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.MasterPrestigeTitle:completeAnimation()
			f11_arg0.MasterPrestigeTitle:setAlpha(0)
			f11_local1(f11_arg0.MasterPrestigeTitle)
			local f11_local2 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					f15_arg0:beginAnimation(180)
					f15_arg0:setAlpha(1)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.DescriptionText1:beginAnimation(120)
				f11_arg0.DescriptionText1:setAlpha(0.01)
				f11_arg0.DescriptionText1:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.DescriptionText1:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f11_arg0.DescriptionText1:completeAnimation()
			f11_arg0.DescriptionText1:setAlpha(0)
			f11_local2(f11_arg0.DescriptionText1)
			local f11_local3 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					f17_arg0:beginAnimation(180)
					f17_arg0:setAlpha(1)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.DescriptionText2:beginAnimation(120)
				f11_arg0.DescriptionText2:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.DescriptionText2:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f11_arg0.DescriptionText2:completeAnimation()
			f11_arg0.DescriptionText2:setAlpha(0)
			f11_local3(f11_arg0.DescriptionText2)
		end,
	},
	ZM = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(4)
			local f18_local0 = function(f19_arg0)
				f18_arg0.MasterPrestigeImage:beginAnimation(120)
				f18_arg0.MasterPrestigeImage:setAlpha(1)
				f18_arg0.MasterPrestigeImage:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.MasterPrestigeImage:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.MasterPrestigeImage:completeAnimation()
			f18_arg0.MasterPrestigeImage:setAlpha(0)
			f18_arg0.MasterPrestigeImage:setImage(RegisterImage(0x3F48FBE7880AA60))
			f18_local0(f18_arg0.MasterPrestigeImage)
			local f18_local1 = function(f20_arg0)
				f18_arg0.MasterPrestigeTitle:beginAnimation(120)
				f18_arg0.MasterPrestigeTitle:setAlpha(1)
				f18_arg0.MasterPrestigeTitle:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.MasterPrestigeTitle:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.MasterPrestigeTitle:completeAnimation()
			f18_arg0.MasterPrestigeTitle:setAlpha(0)
			f18_local1(f18_arg0.MasterPrestigeTitle)
			local f18_local2 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					f22_arg0:beginAnimation(180)
					f22_arg0:setAlpha(1)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
				end
				f18_arg0.DescriptionText1:beginAnimation(120)
				f18_arg0.DescriptionText1:setAlpha(0.01)
				f18_arg0.DescriptionText1:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.DescriptionText1:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f18_arg0.DescriptionText1:completeAnimation()
			f18_arg0.DescriptionText1:setAlpha(0)
			f18_arg0.DescriptionText1:setText(Engine[0xF9F1239CFD921FE](0x2F1A76D4186CCC5))
			f18_local2(f18_arg0.DescriptionText1)
			local f18_local3 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					f24_arg0:beginAnimation(180)
					f24_arg0:setAlpha(1)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
				end
				f18_arg0.DescriptionText2:beginAnimation(120)
				f18_arg0.DescriptionText2:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.DescriptionText2:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f18_arg0.DescriptionText2:completeAnimation()
			f18_arg0.DescriptionText2:setAlpha(0)
			f18_local3(f18_arg0.DescriptionText2)
		end,
	},
	WZ = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(4)
			local f25_local0 = function(f26_arg0)
				f25_arg0.MasterPrestigeImage:beginAnimation(120)
				f25_arg0.MasterPrestigeImage:setAlpha(1)
				f25_arg0.MasterPrestigeImage:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.MasterPrestigeImage:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.MasterPrestigeImage:completeAnimation()
			f25_arg0.MasterPrestigeImage:setAlpha(0)
			f25_arg0.MasterPrestigeImage:setImage(RegisterImage(0xF502230396E02ED))
			f25_local0(f25_arg0.MasterPrestigeImage)
			local f25_local1 = function(f27_arg0)
				f25_arg0.MasterPrestigeTitle:beginAnimation(120)
				f25_arg0.MasterPrestigeTitle:setAlpha(1)
				f25_arg0.MasterPrestigeTitle:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.MasterPrestigeTitle:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.MasterPrestigeTitle:completeAnimation()
			f25_arg0.MasterPrestigeTitle:setAlpha(0)
			f25_local1(f25_arg0.MasterPrestigeTitle)
			local f25_local2 = function(f28_arg0)
				local f28_local0 = function(f29_arg0)
					f29_arg0:beginAnimation(180)
					f29_arg0:setAlpha(1)
					f29_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
				end
				f25_arg0.DescriptionText1:beginAnimation(120)
				f25_arg0.DescriptionText1:setAlpha(0.01)
				f25_arg0.DescriptionText1:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.DescriptionText1:registerEventHandler("transition_complete_keyframe", f28_local0)
			end
			f25_arg0.DescriptionText1:completeAnimation()
			f25_arg0.DescriptionText1:setAlpha(0)
			f25_local2(f25_arg0.DescriptionText1)
			local f25_local3 = function(f30_arg0)
				local f30_local0 = function(f31_arg0)
					f31_arg0:beginAnimation(180)
					f31_arg0:setAlpha(1)
					f31_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
				end
				f25_arg0.DescriptionText2:beginAnimation(120)
				f25_arg0.DescriptionText2:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.DescriptionText2:registerEventHandler("transition_complete_keyframe", f30_local0)
			end
			f25_arg0.DescriptionText2:completeAnimation()
			f25_arg0.DescriptionText2:setAlpha(0)
			f25_local3(f25_arg0.DescriptionText2)
		end,
	},
}
CoD.AARPrestigeMasterOverlay.__onClose = function(f32_arg0)
	f32_arg0.FooterContainerFrontendRight:close()
end
