CoD.HealthUtility = {}
CoD.HealthUtility.GetSpawnHealthPerBar = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4)
	return math.ceil(f1_arg1 / Dvar.cg_healthperbar:get()), f1_arg0, 1, f1_arg4
end
CoD.HealthUtility.InitHealthBarLossPulse = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4)
	local f2_local0, f2_local1 = f2_arg1:getLocalSize()
	f2_arg1.__playHealthBarLossPulse = function(f3_arg0, f3_arg1, f3_arg2)
		if f2_arg0:getAlpha() > 0 and f2_arg0:getParent() then
			local f3_local0 = f2_arg0:getParent()
			if f3_local0:getAlpha() <= 0 then
				return
			end
			f3_local0 = f2_arg3.new(f2_arg4, f2_arg2, 0, 0, 0, f2_local0, 0, 0, 0, f2_local1)
			f3_local0:registerEventHandler("clip_over", function(element, event)
				element:close()
			end)
			f3_local0:setModel(f2_arg0:getModel(), f2_arg2)
			f3_local0:linkToElementModel(f3_local0, "cancelHealthBarAnim", true, function(model)
				if model:get() then
					f3_local0:close()
				end
			end)
			if f3_local0.PulseBar then
				f3_local0.PulseBar:setShaderVector(0, f3_arg0, 1, 0, 0)
				f3_local0.PulseBar:setShaderVector(1, f3_arg1, f3_arg2, 0, 1)
			end
			f3_local0:playClip("DefaultClip")
			f2_arg1:addElement(f3_local0)
			f2_arg4:sendInitializationEvents(f2_arg2, f3_local0)
		end
		return
	end
end
