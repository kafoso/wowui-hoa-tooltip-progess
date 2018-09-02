function HeartOfAzerothTooltip_NumberFormat(number, decimalCount)
	local multiplier = 10^(decimalCount or 0)
	return math.floor(number * multiplier + 0.5) / multiplier
end

function HeartOfAzerothTooltip_GetAzeriteProgressString()
	local azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem()
	local str = ""
	if (C_AzeriteItem.HasActiveAzeriteItem() and azeriteItemLocation) then
		local currentXP, totalLevelXP = C_AzeriteItem.GetAzeriteItemXPInfo(azeriteItemLocation)
		str = str .. HeartOfAzerothTooltip_NumberFormat(((currentXP / totalLevelXP) * 100), 2) .. "%"
		str = str .. " (" .. currentXP .. "/" .. totalLevelXP .. ")"
		return str
	end
	return nil
end

function HeartOfAzerothTooltip_OnTooltipSetItem(tooltip)
	if (tooltip:GetItem() == "Heart of Azeroth") then
		local progressString = HeartOfAzerothTooltip_GetAzeriteProgressString()
		if (progressString == nil) then
			return
		end
		GameTooltip:AddDoubleLine("Azerite Power:", progressString, 0.4, 0.7, 1, 0.4, 0.7, 1)
	end
end

if (UnitLevel("player") == 120) then
	GameTooltip:HookScript("OnTooltipSetItem", HeartOfAzerothTooltip_OnTooltipSetItem)
end
