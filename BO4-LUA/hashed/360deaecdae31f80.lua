require("x64:94acc3cb318e13b")
require("x64:5f4d99916f6c43")
require("x64:5f8cf56752aa71b")
require("x64:1a4e34b4805b325")
CoD.SignatureCamoInternal = InheritFrom(LUI.UIElement)
CoD.SignatureCamoInternal.__defaultWidth = 165
CoD.SignatureCamoInternal.__defaultHeight = 82
CoD.SignatureCamoInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SignatureCamoInternal)
	self.id = "SignatureCamoInternal"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	Image:setShaderVector(0, 0, 0, 0, 0)
	Image:setShaderVector(1, 1, 1, 0, 0)
	Image:setShaderVector(2, 0, 0, 0, 0)
	Image:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Image:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Image)
	self.Image = Image
	local ProgressBarBG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 1, 1)
	ProgressBarBG:setRGB(ColorSet.Title.r, ColorSet.Title.g, ColorSet.Title.b)
	ProgressBarBG:setAlpha(0)
	ProgressBarBG:setImage(RegisterImage(0x136CEF79E2CB178))
	self:addElement(ProgressBarBG)
	self.ProgressBarBG = ProgressBarBG
	local ProgressBar = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -79, 1)
	ProgressBar:setAlpha(0)
	ProgressBar:setImage(RegisterImage(0xF090ADEC8D52EF0))
	ProgressBar:setMaterial(LUI.UIImage.GetCachedMaterial(0x316E67E1DF2198E))
	ProgressBar:setShaderVector(1, 0, 0, 0, 0)
	ProgressBar:setShaderVector(2, 1, 0, 0, 0)
	ProgressBar:setShaderVector(3, 0, 0, 0, 0)
	ProgressBar:setShaderVector(4, 0, 0, 0, 0)
	ProgressBar:linkToElementModel(self, "unlockProgressAndTarget", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ProgressBar:setShaderVector(0, CoD.WeaponOptionsUtility.GetWeaponOptionProgress(f1_arg0, f1_arg1, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4)))
		end
	end)
	self:addElement(ProgressBar)
	self.ProgressBar = ProgressBar
	local CommonButtonOutlineLocked = CoD.CommonButtonOutlineLocked.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CommonButtonOutlineLocked:setAlpha(0)
	self:addElement(CommonButtonOutlineLocked)
	self.CommonButtonOutlineLocked = CommonButtonOutlineLocked
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, -1, 1, 0, 1, 0, 0)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(ColorSet.Title.r, ColorSet.Title.g, ColorSet.Title.b)
	Backing:setAlpha(0)
	Backing:setImage(RegisterImage(0xCE50842B84CCD5D))
	self:addElement(Backing)
	self.Backing = Backing
	local BMLock = CoD.BM_Lock.new(f1_arg0, f1_arg1, 0.5, 0.5, -24, 24, 0.5, 0.5, -24, 24)
	BMLock:setAlpha(0)
	BMLock:setScale(0.6, 0.6)
	self:addElement(BMLock)
	self.BMLock = BMLock
	local EquippedMarkerTick = CoD.EquippedMarker.new(f1_arg0, f1_arg1, 1, 1, -34, 10, 0, 0, -10, 34)
	EquippedMarkerTick:mergeStateConditions({
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.WeaponOptionsUtility.IsWeaponSignatureThemeEquipped(menu, self, f1_arg1, "camoIndex")
			end,
		},
	})
	self:addElement(EquippedMarkerTick)
	self.EquippedMarkerTick = EquippedMarkerTick
	CommonButtonOutlineLocked.id = "CommonButtonOutlineLocked"
	CommonButtonOutline.id = "CommonButtonOutline"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SignatureCamoInternal.__resetProperties = function(f5_arg0)
	f5_arg0.CommonButtonOutline:completeAnimation()
	f5_arg0.Backing:completeAnimation()
	f5_arg0.BMLock:completeAnimation()
	f5_arg0.CommonButtonOutlineLocked:completeAnimation()
	f5_arg0.Image:completeAnimation()
	f5_arg0.CommonButtonOutline:setRGB(1, 1, 1)
	f5_arg0.CommonButtonOutline:setAlpha(1)
	f5_arg0.Backing:setAlpha(0)
	f5_arg0.BMLock:setAlpha(0)
	f5_arg0.CommonButtonOutlineLocked:setAlpha(0)
	f5_arg0.Image:setRGB(1, 1, 1)
end
CoD.SignatureCamoInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.CommonButtonOutline:completeAnimation()
			f6_arg0.CommonButtonOutline:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.CommonButtonOutline)
		end,
		ChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.CommonButtonOutline:completeAnimation()
			f7_arg0.CommonButtonOutline:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.CommonButtonOutline)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.CommonButtonOutline:completeAnimation()
			f8_arg0.CommonButtonOutline:setRGB(1, 1, 1)
			f8_arg0.clipFinished(f8_arg0.CommonButtonOutline)
		end,
	},
	Locked = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(4)
			f9_arg0.Image:completeAnimation()
			f9_arg0.Image:setRGB(0.29, 0.29, 0.29)
			f9_arg0.clipFinished(f9_arg0.Image)
			f9_arg0.CommonButtonOutlineLocked:completeAnimation()
			f9_arg0.CommonButtonOutlineLocked:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.CommonButtonOutlineLocked)
			f9_arg0.Backing:completeAnimation()
			f9_arg0.Backing:setAlpha(0.66)
			f9_arg0.clipFinished(f9_arg0.Backing)
			f9_arg0.BMLock:completeAnimation()
			f9_arg0.BMLock:setAlpha(0.8)
			f9_arg0.clipFinished(f9_arg0.BMLock)
		end,
		ChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(4)
			f10_arg0.Image:completeAnimation()
			f10_arg0.Image:setRGB(0.29, 0.29, 0.29)
			f10_arg0.clipFinished(f10_arg0.Image)
			f10_arg0.CommonButtonOutlineLocked:completeAnimation()
			f10_arg0.CommonButtonOutlineLocked:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.CommonButtonOutlineLocked)
			f10_arg0.Backing:completeAnimation()
			f10_arg0.Backing:setAlpha(0.66)
			f10_arg0.clipFinished(f10_arg0.Backing)
			f10_arg0.BMLock:completeAnimation()
			f10_arg0.BMLock:setAlpha(0.8)
			f10_arg0.clipFinished(f10_arg0.BMLock)
		end,
		GainChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(4)
			f11_arg0.Image:completeAnimation()
			f11_arg0.Image:setRGB(0.29, 0.29, 0.29)
			f11_arg0.clipFinished(f11_arg0.Image)
			f11_arg0.CommonButtonOutlineLocked:completeAnimation()
			f11_arg0.CommonButtonOutlineLocked:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.CommonButtonOutlineLocked)
			f11_arg0.Backing:completeAnimation()
			f11_arg0.Backing:setAlpha(0.66)
			f11_arg0.clipFinished(f11_arg0.Backing)
			f11_arg0.BMLock:completeAnimation()
			f11_arg0.BMLock:setAlpha(0.8)
			f11_arg0.clipFinished(f11_arg0.BMLock)
		end,
		LoseChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(4)
			f12_arg0.Image:completeAnimation()
			f12_arg0.Image:setRGB(0.29, 0.29, 0.29)
			f12_arg0.clipFinished(f12_arg0.Image)
			f12_arg0.CommonButtonOutlineLocked:completeAnimation()
			f12_arg0.CommonButtonOutlineLocked:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.CommonButtonOutlineLocked)
			f12_arg0.Backing:completeAnimation()
			f12_arg0.Backing:setAlpha(0.66)
			f12_arg0.clipFinished(f12_arg0.Backing)
			f12_arg0.BMLock:completeAnimation()
			f12_arg0.BMLock:setAlpha(0.8)
			f12_arg0.clipFinished(f12_arg0.BMLock)
		end,
	},
}
CoD.SignatureCamoInternal.__onClose = function(f13_arg0)
	f13_arg0.Image:close()
	f13_arg0.ProgressBar:close()
	f13_arg0.CommonButtonOutlineLocked:close()
	f13_arg0.CommonButtonOutline:close()
	f13_arg0.BMLock:close()
	f13_arg0.EquippedMarkerTick:close()
end
