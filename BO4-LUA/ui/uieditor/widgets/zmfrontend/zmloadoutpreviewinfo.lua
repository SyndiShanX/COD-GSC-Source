require("x64:76fa323de4745ba")
require("x64:341ce33d59fafd1")
require("x64:94dab3a4d2d79b2")
CoD.ZMLoadoutPreviewInfo = InheritFrom(LUI.UIElement)
CoD.ZMLoadoutPreviewInfo.__defaultWidth = 934
CoD.ZMLoadoutPreviewInfo.__defaultHeight = 126
CoD.ZMLoadoutPreviewInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMLoadoutPreviewInfo)
	self.id = "ZMLoadoutPreviewInfo"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Blur:setAlpha(0.7)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local Panel = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Panel:setRGB(0, 0, 0)
	Panel:setAlpha(0.02)
	self:addElement(Panel)
	self.Panel = Panel
	local TiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TiledBacking:setAlpha(0.4)
	TiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	TiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	TiledBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking:setupNineSliceShader(196, 88)
	self:addElement(TiledBacking)
	self.TiledBacking = TiledBacking
	local LinePattern = LUI.UIImage.new(0, 0, 0, 313, 0, 1, 0, 0)
	LinePattern:setAlpha(0.5)
	LinePattern:setImage(RegisterImage(0xB8CFFD5326CFE1B))
	LinePattern:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	LinePattern:setShaderVector(0, 0, 0, 0, 0)
	LinePattern:setupNineSliceShader(256, 256)
	self:addElement(LinePattern)
	self.LinePattern = LinePattern
	local itemImage = LUI.UIFixedAspectRatioImage.new(0, 0, 6.5, 306.5, 0.5, 0.5, -59, 61)
	itemImage:setScale(0.84, 0.84)
	itemImage:subscribeToGlobalModel(f1_arg1, "DirectorZMLoadoutPreview", "ZMLoadoutPreviewItemImage", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			itemImage:setImage(CoD.BaseUtility.AlreadyRegisteredIfUserData(f2_local0))
		end
	end)
	self:addElement(itemImage)
	self.itemImage = itemImage
	local detailedDesc = LUI.UIText.new(0, 0, 330, 922, 0.5, 0.5, -24, -8)
	detailedDesc:setRGB(0.92, 0.92, 0.92)
	detailedDesc:setTTF("dinnext_regular")
	detailedDesc:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	detailedDesc:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	detailedDesc:subscribeToGlobalModel(f1_arg1, "DirectorZMLoadoutPreview", "ZMLoadoutPreviewItemDesc", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			detailedDesc:setText(Engine[0xF9F1239CFD921FE](f3_local0))
		end
	end)
	self:addElement(detailedDesc)
	self.detailedDesc = detailedDesc
	local SubHeaderDivider = LUI.UIImage.new(0, 0, 331, 929, 0.5, 0.5, -33, -31)
	SubHeaderDivider:setRGB(0.92, 0.92, 0.92)
	SubHeaderDivider:setAlpha(0.25)
	SubHeaderDivider:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	SubHeaderDivider:setShaderVector(0, 0, 1, 0, 0)
	SubHeaderDivider:setShaderVector(1, 0, 1.24, 0, 0)
	SubHeaderDivider:setShaderVector(2, 0, 1, 0, 0)
	SubHeaderDivider:setShaderVector(3, 0, 0, 0, 0)
	SubHeaderDivider:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(SubHeaderDivider)
	self.SubHeaderDivider = SubHeaderDivider
	local name = LUI.UIText.new(0, 0, 330, 922, 0.5, 0.5, -58, -36)
	name:setRGB(0.58, 0.85, 1)
	name:setTTF("ttmussels_demibold")
	name:setLetterSpacing(10)
	name:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	name:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	name:subscribeToGlobalModel(f1_arg1, "DirectorZMLoadoutPreview", "ZMLoadoutPreviewItemName", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			name:setText(LocalizeToUpperString(f4_local0))
		end
	end)
	self:addElement(name)
	self.name = name
	local Corner9Slice2 = CoD.Corner9Slice.new(f1_arg0, f1_arg1, 0.01, 0.01, 302.5, 923.5, -0.01, 1.01, 1, -1)
	Corner9Slice2:setAlpha(0.6)
	Corner9Slice2:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Corner9Slice2)
	self.Corner9Slice2 = Corner9Slice2
	local Corner9Slice = CoD.Corner9Slice.new(f1_arg0, f1_arg1, 0.01, 0.01, -6, 308, 0.17, 1.19, -22, -24)
	Corner9Slice:setAlpha(0.6)
	Corner9Slice:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Corner9Slice)
	self.Corner9Slice = Corner9Slice
	local RestrictionIcon = CoD.RestrictedItemWarning.new(f1_arg0, f1_arg1, 0.5, 0.5, -460, -400, 0.5, 0.5, -56, -6)
	RestrictionIcon:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f5_local0
				if not CoD.DirectorUtility.ShowDirectorPregame(f1_arg1) and not IsPublicWZLobby() then
					f5_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "ZMLoadoutPreviewItemIsRestricted")
				else
					f5_local0 = false
				end
				return f5_local0
			end,
		},
	})
	local f1_local12 = RestrictionIcon
	local RestrictedText = RestrictionIcon.subscribeToModel
	local f1_local14 = Engine[0x8DF2E5447F384B9]()
	RestrictedText(f1_local12, f1_local14["lobbyRoot.lobbyNav"], function(f6_arg0)
		f1_arg0:updateElementState(RestrictionIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	RestrictionIcon:linkToElementModel(RestrictionIcon, "ZMLoadoutPreviewItemIsRestricted", true, function(model)
		f1_arg0:updateElementState(RestrictionIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "ZMLoadoutPreviewItemIsRestricted",
		})
	end)
	RestrictionIcon:subscribeToGlobalModel(f1_arg1, "DirectorZMLoadoutPreview", nil, function(model)
		RestrictionIcon:setModel(model, f1_arg1)
	end)
	self:addElement(RestrictionIcon)
	self.RestrictionIcon = RestrictionIcon
	RestrictedText = CoD.RestrictedItemWarningText.new(f1_arg0, f1_arg1, 0.5, 0.5, -27, 467, 0.5, 0.5, 69, 99)
	RestrictedText:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f9_local0
				if not CoD.DirectorUtility.ShowDirectorPregame(f1_arg1) and not IsPublicWZLobby() then
					f9_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "ZMLoadoutPreviewItemIsRestricted")
				else
					f9_local0 = false
				end
				return f9_local0
			end,
		},
	})
	f1_local14 = RestrictedText
	f1_local12 = RestrictedText.subscribeToModel
	local f1_local15 = Engine[0x8DF2E5447F384B9]()
	f1_local12(f1_local14, f1_local15["lobbyRoot.lobbyNav"], function(f10_arg0)
		f1_arg0:updateElementState(RestrictedText, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	RestrictedText:linkToElementModel(RestrictedText, "ZMLoadoutPreviewItemIsRestricted", true, function(model)
		f1_arg0:updateElementState(RestrictedText, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "ZMLoadoutPreviewItemIsRestricted",
		})
	end)
	RestrictedText:subscribeToGlobalModel(f1_arg1, "DirectorZMLoadoutPreview", nil, function(model)
		RestrictedText:setModel(model, f1_arg1)
	end)
	self:addElement(RestrictedText)
	self.RestrictedText = RestrictedText
	self:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "DirectorZMLoadoutPreview", "ZMLoadoutPreviewInfoShown")
			end,
		},
		{
			stateName = "DefaultState_TraditionalChinesePC",
			condition = function(menu, element, event)
				return IsPC() and IsCurrentLanguageTraditionalChinese()
			end,
		},
	})
	f1_local14 = self
	f1_local12 = self.subscribeToModel
	f1_local15 = DataSources.DirectorZMLoadoutPreview.getModel(f1_arg1)
	f1_local12(f1_local14, f1_local15.ZMLoadoutPreviewInfoShown, function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "ZMLoadoutPreviewInfoShown",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMLoadoutPreviewInfo.__resetProperties = function(f16_arg0)
	f16_arg0.name:completeAnimation()
	f16_arg0.SubHeaderDivider:completeAnimation()
	f16_arg0.detailedDesc:completeAnimation()
	f16_arg0.itemImage:completeAnimation()
	f16_arg0.Panel:completeAnimation()
	f16_arg0.Blur:completeAnimation()
	f16_arg0.TiledBacking:completeAnimation()
	f16_arg0.LinePattern:completeAnimation()
	f16_arg0.RestrictionIcon:completeAnimation()
	f16_arg0.RestrictedText:completeAnimation()
	f16_arg0.Corner9Slice2:completeAnimation()
	f16_arg0.Corner9Slice:completeAnimation()
	f16_arg0.name:setAlpha(1)
	f16_arg0.SubHeaderDivider:setAlpha(0.25)
	f16_arg0.detailedDesc:setAlpha(1)
	f16_arg0.itemImage:setTopBottom(0.5, 0.5, -59, 61)
	f16_arg0.itemImage:setAlpha(1)
	f16_arg0.Panel:setTopBottom(0, 1, 0, 0)
	f16_arg0.Panel:setAlpha(0.02)
	f16_arg0.Blur:setTopBottom(0, 1, 0, 0)
	f16_arg0.Blur:setAlpha(0.7)
	f16_arg0.TiledBacking:setTopBottom(0, 1, 0, 0)
	f16_arg0.TiledBacking:setAlpha(0.4)
	f16_arg0.LinePattern:setTopBottom(0, 1, 0, 0)
	f16_arg0.LinePattern:setAlpha(0.5)
	f16_arg0.RestrictionIcon:setAlpha(1)
	f16_arg0.RestrictedText:setAlpha(1)
	f16_arg0.Corner9Slice2:setTopBottom(-0.01, 1.01, 1, -1)
	f16_arg0.Corner9Slice2:setAlpha(0.6)
	f16_arg0.Corner9Slice:setTopBottom(0.17, 1.19, -22, -24)
	f16_arg0.Corner9Slice:setAlpha(0.6)
end
CoD.ZMLoadoutPreviewInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(0)
		end,
	},
	Invisible = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(12)
			f18_arg0.Blur:completeAnimation()
			f18_arg0.Blur:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.Blur)
			f18_arg0.Panel:completeAnimation()
			f18_arg0.Panel:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.Panel)
			f18_arg0.TiledBacking:completeAnimation()
			f18_arg0.TiledBacking:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.TiledBacking)
			f18_arg0.LinePattern:completeAnimation()
			f18_arg0.LinePattern:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.LinePattern)
			f18_arg0.itemImage:completeAnimation()
			f18_arg0.itemImage:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.itemImage)
			f18_arg0.detailedDesc:completeAnimation()
			f18_arg0.detailedDesc:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.detailedDesc)
			f18_arg0.SubHeaderDivider:completeAnimation()
			f18_arg0.SubHeaderDivider:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.SubHeaderDivider)
			f18_arg0.name:completeAnimation()
			f18_arg0.name:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.name)
			f18_arg0.Corner9Slice2:completeAnimation()
			f18_arg0.Corner9Slice2:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.Corner9Slice2)
			f18_arg0.Corner9Slice:completeAnimation()
			f18_arg0.Corner9Slice:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.Corner9Slice)
			f18_arg0.RestrictionIcon:completeAnimation()
			f18_arg0.RestrictionIcon:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.RestrictionIcon)
			f18_arg0.RestrictedText:completeAnimation()
			f18_arg0.RestrictedText:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.RestrictedText)
		end,
	},
	DefaultState_TraditionalChinesePC = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(7)
			f19_arg0.Blur:completeAnimation()
			f19_arg0.Blur:setTopBottom(0, 0, 0, 110)
			f19_arg0.clipFinished(f19_arg0.Blur)
			f19_arg0.Panel:completeAnimation()
			f19_arg0.Panel:setTopBottom(0, 0, 0, 110)
			f19_arg0.clipFinished(f19_arg0.Panel)
			f19_arg0.TiledBacking:completeAnimation()
			f19_arg0.TiledBacking:setTopBottom(0.21, 0.21, -36, 74)
			f19_arg0.clipFinished(f19_arg0.TiledBacking)
			f19_arg0.LinePattern:completeAnimation()
			f19_arg0.LinePattern:setTopBottom(0, 0, 0, 110)
			f19_arg0.clipFinished(f19_arg0.LinePattern)
			f19_arg0.itemImage:completeAnimation()
			f19_arg0.itemImage:setTopBottom(0.5, 0.5, -78, 12)
			f19_arg0.clipFinished(f19_arg0.itemImage)
			f19_arg0.Corner9Slice2:completeAnimation()
			f19_arg0.Corner9Slice2:setTopBottom(0.1, 0.73, -17, -19)
			f19_arg0.clipFinished(f19_arg0.Corner9Slice2)
			f19_arg0.Corner9Slice:completeAnimation()
			f19_arg0.Corner9Slice:setTopBottom(0.1, 0.73, -17, -19)
			f19_arg0.clipFinished(f19_arg0.Corner9Slice)
		end,
	},
}
if not CoD.isPC then
	CoD.ZMLoadoutPreviewInfo.__clipsPerState.DefaultState_TraditionalChinesePC.DefaultClip = nil
end
CoD.ZMLoadoutPreviewInfo.__onClose = function(f20_arg0)
	f20_arg0.itemImage:close()
	f20_arg0.detailedDesc:close()
	f20_arg0.name:close()
	f20_arg0.Corner9Slice2:close()
	f20_arg0.Corner9Slice:close()
	f20_arg0.RestrictionIcon:close()
	f20_arg0.RestrictedText:close()
end
