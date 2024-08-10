local name, addon = ...;



--[[----------------------------------------------------------------------------
    PLAYER_SPECIALIZATION_CHANGED
------------------------------------------------------------------------------]]
function addon.tcr:PLAYER_SPECIALIZATION_CHANGED()
	self:RecalculateTrueCombatRatings();
end



--[[----------------------------------------------------------------------------
	PLAYER_ENTERING_WORLD
------------------------------------------------------------------------------]]
function addon.tcr:PLAYER_ENTERING_WORLD()
	self:SetupConversionFactors();
    self:RecalculateTrueCombatRatings();
end



--[[----------------------------------------------------------------------------
	COMBAT_RATING_UPDATE
------------------------------------------------------------------------------]]
function addon.tcr:COMBAT_RATING_UPDATE()
    self:RecalculateTrueCombatRatings();
end



--[[----------------------------------------------------------------------------
	PLAYER_LEVEL_UP
------------------------------------------------------------------------------]]
function addon.tcr:PLAYER_LEVEL_UP()
    self:RecalculateTrueCombatRatings();
end



--[[----------------------------------------------------------------------------
	Events
------------------------------------------------------------------------------]]
addon.tcr:RegisterEvent("PLAYER_LEVEL_UP");
addon.tcr:RegisterEvent("COMBAT_RATING_UPDATE");
addon.tcr:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED");
addon.tcr:RegisterEvent("PLAYER_ENTERING_WORLD");
