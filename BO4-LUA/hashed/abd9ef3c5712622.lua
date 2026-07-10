CoD.TabletTak5_LinkAll = InheritFrom(LUI.UIElement)
CoD.TabletTak5_LinkAll.__defaultWidth = 263
CoD.TabletTak5_LinkAll.__defaultHeight = 195
CoD.TabletTak5_LinkAll.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabletTak5_LinkAll)
	self.id = "TabletTak5_LinkAll"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ModuleLink01 = LUI.UIImage.new(0, 0, 50.5, 240.5, 0, 0, 48, 70)
	ModuleLink01:setImage(RegisterImage(0x953E6C2D9953D06))
	self:addElement(ModuleLink01)
	self.ModuleLink01 = ModuleLink01
	local ModuleLink01Add = LUI.UIImage.new(0, 0, 50.5, 240.5, 0, 0, 48, 70)
	ModuleLink01Add:setAlpha(0.2)
	ModuleLink01Add:setImage(RegisterImage(0x953E6C2D9953D06))
	ModuleLink01Add:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	ModuleLink01Add:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(ModuleLink01Add)
	self.ModuleLink01Add = ModuleLink01Add
	local ModuleLink02 = LUI.UIImage.new(0, 0, 130, 244, 0, 0, 60.5, 188.5)
	ModuleLink02:setImage(RegisterImage(0x953E5C2D9953B53))
	self:addElement(ModuleLink02)
	self.ModuleLink02 = ModuleLink02
	local ModuleLink02Add = LUI.UIImage.new(0, 0, 130, 244, 0, 0, 60.5, 188.5)
	ModuleLink02Add:setAlpha(0.2)
	ModuleLink02Add:setImage(RegisterImage(0x953E5C2D9953B53))
	ModuleLink02Add:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	ModuleLink02Add:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(ModuleLink02Add)
	self.ModuleLink02Add = ModuleLink02Add
	local ModuleLink03 = LUI.UIImage.new(0, 0, 239.5, 253.5, 0, 0, 5, 59)
	ModuleLink03:setImage(RegisterImage(0x953E4C2D99539A0))
	self:addElement(ModuleLink03)
	self.ModuleLink03 = ModuleLink03
	local ModuleLink03Add = LUI.UIImage.new(0, 0, 239.5, 253.5, 0, 0, 5, 59)
	ModuleLink03Add:setAlpha(0.2)
	ModuleLink03Add:setImage(RegisterImage(0x953E4C2D99539A0))
	ModuleLink03Add:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	ModuleLink03Add:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(ModuleLink03Add)
	self.ModuleLink03Add = ModuleLink03Add
	local ModuleLink04 = LUI.UIImage.new(0, 0, 9.5, 33.5, 0, 0, 134.5, 188.5)
	ModuleLink04:setImage(RegisterImage(0x953EBC2D9954585))
	self:addElement(ModuleLink04)
	self.ModuleLink04 = ModuleLink04
	local ModuleLink04Add = LUI.UIImage.new(0, 0, 9.5, 33.5, 0, 0, 134.5, 188.5)
	ModuleLink04Add:setAlpha(0.2)
	ModuleLink04Add:setImage(RegisterImage(0x953EBC2D9954585))
	ModuleLink04Add:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	ModuleLink04Add:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(ModuleLink04Add)
	self.ModuleLink04Add = ModuleLink04Add
	local Connector01 = LUI.UIImage.new(0, 0, 235.5, 249.5, 0, 0, 52, 66)
	Connector01:setImage(RegisterImage(0xFA1D08EA1C385B0))
	Connector01:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	Connector01:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(Connector01)
	self.Connector01 = Connector01
	local Connector02 = LUI.UIImage.new(0, 0, 0, 14, 0, 0, 129, 143)
	Connector02:setImage(RegisterImage(0xFA1D38EA1C38AC9))
	Connector02:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	Connector02:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(Connector02)
	self.Connector02 = Connector02
	local Connector03 = LUI.UIImage.new(0, 0, 248.5, 262.5, 0, 0, -0.5, 13.5)
	Connector03:setImage(RegisterImage(0xFA1D38EA1C38AC9))
	Connector03:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	Connector03:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(Connector03)
	self.Connector03 = Connector03
	local Connector04 = LUI.UIImage.new(0, 0, 126.5, 140.5, 0, 0, 180, 194)
	Connector04:setImage(RegisterImage(0xFA1D38EA1C38AC9))
	Connector04:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	Connector04:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(Connector04)
	self.Connector04 = Connector04
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabletTak5_LinkAll.__resetProperties = function(f2_arg0)
	f2_arg0.ModuleLink01Add:completeAnimation()
	f2_arg0.ModuleLink02Add:completeAnimation()
	f2_arg0.ModuleLink03Add:completeAnimation()
	f2_arg0.ModuleLink04Add:completeAnimation()
	f2_arg0.ModuleLink01Add:setRGB(1, 1, 1)
	f2_arg0.ModuleLink01Add:setAlpha(0.2)
	f2_arg0.ModuleLink02Add:setRGB(1, 1, 1)
	f2_arg0.ModuleLink02Add:setAlpha(0.2)
	f2_arg0.ModuleLink03Add:setRGB(1, 1, 1)
	f2_arg0.ModuleLink03Add:setAlpha(0.2)
	f2_arg0.ModuleLink04Add:setRGB(1, 1, 1)
	f2_arg0.ModuleLink04Add:setAlpha(0.2)
end
CoD.TabletTak5_LinkAll.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		HealthBoost = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(4)
			local f4_local0 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					local f6_local0 = function(f7_arg0)
						f7_arg0:beginAnimation(300)
						f7_arg0:setAlpha(0.2)
						f7_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
					end
					f6_arg0:beginAnimation(399)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
				end
				f4_arg0.ModuleLink01Add:beginAnimation(300)
				f4_arg0.ModuleLink01Add:setAlpha(1)
				f4_arg0.ModuleLink01Add:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.ModuleLink01Add:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f4_arg0.ModuleLink01Add:completeAnimation()
			f4_arg0.ModuleLink01Add:setRGB(ColorSet.CleanseBar.r, ColorSet.CleanseBar.g, ColorSet.CleanseBar.b)
			f4_arg0.ModuleLink01Add:setAlpha(0.2)
			f4_local0(f4_arg0.ModuleLink01Add)
			local f4_local1 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					local f9_local0 = function(f10_arg0)
						f10_arg0:beginAnimation(300)
						f10_arg0:setAlpha(0.2)
						f10_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
					end
					f9_arg0:beginAnimation(399)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
				end
				f4_arg0.ModuleLink02Add:beginAnimation(300)
				f4_arg0.ModuleLink02Add:setAlpha(1)
				f4_arg0.ModuleLink02Add:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.ModuleLink02Add:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f4_arg0.ModuleLink02Add:completeAnimation()
			f4_arg0.ModuleLink02Add:setRGB(ColorSet.CleanseBar.r, ColorSet.CleanseBar.g, ColorSet.CleanseBar.b)
			f4_arg0.ModuleLink02Add:setAlpha(0.2)
			f4_local1(f4_arg0.ModuleLink02Add)
			local f4_local2 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					local f12_local0 = function(f13_arg0)
						f13_arg0:beginAnimation(300)
						f13_arg0:setAlpha(0.2)
						f13_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
					end
					f12_arg0:beginAnimation(399)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
				end
				f4_arg0.ModuleLink03Add:beginAnimation(300)
				f4_arg0.ModuleLink03Add:setAlpha(1)
				f4_arg0.ModuleLink03Add:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.ModuleLink03Add:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f4_arg0.ModuleLink03Add:completeAnimation()
			f4_arg0.ModuleLink03Add:setRGB(ColorSet.CleanseBar.r, ColorSet.CleanseBar.g, ColorSet.CleanseBar.b)
			f4_arg0.ModuleLink03Add:setAlpha(0.2)
			f4_local2(f4_arg0.ModuleLink03Add)
			local f4_local3 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					local f15_local0 = function(f16_arg0)
						f16_arg0:beginAnimation(300)
						f16_arg0:setAlpha(0.2)
						f16_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
					end
					f15_arg0:beginAnimation(399)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
				end
				f4_arg0.ModuleLink04Add:beginAnimation(300)
				f4_arg0.ModuleLink04Add:setAlpha(1)
				f4_arg0.ModuleLink04Add:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.ModuleLink04Add:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f4_arg0.ModuleLink04Add:completeAnimation()
			f4_arg0.ModuleLink04Add:setRGB(ColorSet.CleanseBar.r, ColorSet.CleanseBar.g, ColorSet.CleanseBar.b)
			f4_arg0.ModuleLink04Add:setAlpha(0.2)
			f4_local3(f4_arg0.ModuleLink04Add)
		end,
	},
}
