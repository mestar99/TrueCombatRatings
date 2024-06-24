local name, addon = ...;


--[[----------------------------------------------------------------------------
	Stat conversion factors (data taken from simc)
	https:--https://github.com/simulationcraft/simc/blob/dragonflight/engine/dbc/generated/sc_scale_data.inc
------------------------------------------------------------------------------]]
local hst_cnv =   {
    2.602257204,	2.602257204,	2.602257204,	2.602257204,	2.602257204,	--    5
    2.602257204,	2.602257204,	2.602257204,	2.602257204,	2.602257204,	--   10
    2.602257204,	2.732370064,	2.862482924,	2.992595784,	3.122708644,	--   15
    3.252821504,	3.382934365,	3.513047225,	3.643160085,	3.773272945,	--   20
    3.926373495,	4.087943764,	4.258513218,	4.438648327,	4.628955374,	--   25
    4.830083485,	5.04272791,	5.267633575,	5.505598922,	5.757480073,	--   30
    6.024195337,	6.306730098,	6.60614211,	6.923567238,	7.260225695,	--   35
    7.617428799,	7.996586318,	8.399214439,	8.826944434,	9.281532073,	--   40
    9.764867855,	10.27898815,	10.82608729,	11.40853079,	12.02886965,	--   45
    12.68985604,	13.39446029,	14.14588952,	14.9476078,	15.80335835,	--   50
    16.80575161,	17.8717258,	19.0053138,	20.2108043,	21.49275802,	--   55
    22.85602494,	24.3057627,	25.84745605,	27.48693768,	33.0561305,	--   60
    37.8893756,	43.42930529,	49.77924624,	57.05763286,	65.40021622,	--   65
    74.96259601,	85.92312267,	98.48622383,	112.8862171,	169.9954204,	--   70
  };
	
local crt_cnv =  {
    2.755331157,	2.755331157,	2.755331157,	2.755331157,	2.755331157,	--    5
    2.755331157,	2.755331157,	2.755331157,	2.755331157,	2.755331157,	--   10
    2.755331157,	2.893097715,	3.030864272,	3.16863083,	3.306397388,	--   15
    3.444163946,	3.581930504,	3.719697062,	3.857463619,	3.995230177,	--   20
    4.157336642,	4.328411045,	4.509013995,	4.699745287,	4.901246867,	--   25
    5.114206043,	5.339358964,	5.577494374,	5.829457682,	6.096155371,	--   30
    6.378559769,	6.677714222,	6.994738704,	7.330835899,	7.687297795,	--   35
    8.065512846,	8.466973748,	8.893285876,	9.34617646,	9.827504547,	--   40
    10.33927185,	10.88363451,	11.46291596,	12.07962083,	12.73645022,	--   45
    13.43631816,	14.18236972,	14.97800066,	15.82687885,	16.73296767,	--   50
    17.79432523,	18.92300378,	20.12327343,	21.39967514,	22.7570379,	--   55
    24.20049699,	25.73551344,	27.36789465,	29.10381637,	35.00060877,	--   60
    40.1181624,	45.98397031,	52.7074372,	60.4139642,	69.24728776,	--   65
    79.37216048,	90.977424,	104.2795311,	119.5265829,	179.995151,	--   70
};

local mst_cnv =  {
    2.755331157,	2.755331157,	2.755331157,	2.755331157,	2.755331157,	--    5
    2.755331157,	2.755331157,	2.755331157,	2.755331157,	2.755331157,	--   10
    2.755331157,	2.893097715,	3.030864272,	3.16863083,	3.306397388,	--   15
    3.444163946,	3.581930504,	3.719697062,	3.857463619,	3.995230177,	--   20
    4.157336642,	4.328411045,	4.509013995,	4.699745287,	4.901246867,	--   25
    5.114206043,	5.339358964,	5.577494374,	5.829457682,	6.096155371,	--   30
    6.378559769,	6.677714222,	6.994738704,	7.330835899,	7.687297795,	--   35
    8.065512846,	8.466973748,	8.893285876,	9.34617646,	9.827504547,	--   40
    10.33927185,	10.88363451,	11.46291596,	12.07962083,	12.73645022,	--   45
    13.43631816,	14.18236972,	14.97800066,	15.82687885,	16.73296767,	--   50
    17.79432523,	18.92300378,	20.12327343,	21.39967514,	22.7570379,	--   55
    24.20049699,	25.73551344,	27.36789465,	29.10381637,	35.00060877,	--   60
    40.1181624,	45.98397031,	52.7074372,	60.4139642,	69.24728776,	--   65
    79.37216048,	90.977424,	104.2795311,	119.5265829,	179.995151,	--   70
  };

local vrs_cnv =     {
    3.13801604,	3.13801604,	3.13801604,	3.13801604,	3.13801604,	--    5
    3.13801604,	3.13801604,	3.13801604,	3.13801604,	3.13801604,	--   10
    3.13801604,	3.294916842,	3.451817644,	3.608718446,	3.765619248,	--   15
    3.92252005,	4.079420852,	4.236321654,	4.393222455,	4.550123257,	--   20
    4.734744509,	4.929579245,	5.135265939,	5.352487688,	5.581975598,	--   25
    5.824512438,	6.080936598,	6.35214637,	6.639104582,	6.942843617,	--   30
    7.264470848,	7.60517453,	7.966230191,	8.349007552,	8.754978044,	--   35
    9.185722964,	9.642942324,	10.12846447,	10.64425652,	11.19243573,	--   40
    11.77528183,	12.39525041,	13.05498762,	13.75734595,	14.50540164,	--   45
    15.30247346,	16.1521433,	17.05827853,	18.02505647,	19.05699095,	--   50
    20.26575929,	21.55119875,	22.91817252,	24.37185225,	25.91773761,	--   55
    27.56167713,	29.30989031,	31.16899113,	33.14601309,	39.86180443,	--   60
    45.6901294,	52.37063285,	60.02791459,	68.80479256,	78.86496662,	--   65
    90.39607166,	103.6131773,	118.7627993,	136.1274971,	204.9944775,	--   70
  };

local lee_cnv =    {
    2.265494507,	2.265494507,	2.265494507,	2.265494507,	2.265494507,	--    5
    2.265494507,	2.265494507,	2.265494507,	2.265494507,	2.265494507,	--   10
    2.265494507,	2.378769232,	2.492043957,	2.605318683,	2.718593408,	--   15
    2.831868133,	2.945142859,	3.058417584,	3.171692309,	3.284967035,	--   20
    3.418254572,	3.558915748,	3.707411507,	3.864235014,	4.02991409,	--   25
    4.205013858,	4.390139593,	4.585939818,	4.79310965,	5.012394416,	--   30
    5.244593588,	5.490565027,	5.751229601,	6.027576184,	6.320667076,	--   35
    6.631643896,	6.961733971,	7.312257276,	7.684633978,	8.080392628,	--   40
    8.501179074,	8.948766152,	9.425064231,	9.932132686,	10.4721924,	--   45
    11.04763937,	11.66105955,	12.31524499,	13.0132115,	13.75821786,	--   50
    14.63088964,	15.55891422,	16.5458026,	17.59528845,	18.71134227,	--   55
    19.89818642,	21.16031105,	22.50249115,	23.92980457,	28.77827832,	--   60
    32.98604464,	37.80904225,	43.33722614,	49.6737039,	56.93665882,	--   65
    65.26155417,	74.80365974,	85.7409478,	98.27741257,	147.996013,	--   70
  };
  
local avd_cnv =    {
	1.102132463,	1.102132463,	1.102132463,	1.102132463,	1.102132463,	--    5
    1.102132463,	1.102132463,	1.102132463,	1.102132463,	1.102132463,	--   10
    1.102132463,	1.157239086,	1.212345709,	1.267452332,	1.322558955,	--   15
    1.377665578,	1.432772202,	1.487878825,	1.542985448,	1.598092071,	--   20
    1.662934657,	1.731364418,	1.803605598,	1.879898115,	1.960498747,	--   25
    2.045682417,	2.135743586,	2.23099775,	2.331783073,	2.438462148,	--   30
    2.551423907,	2.671085689,	2.797895482,	2.93233436,	3.074919118,	--   35
    3.226205139,	3.386789499,	3.557314351,	3.738470584,	3.931001819,	--   40
    4.135708739,	4.353453804,	4.585166382,	4.831848334,	5.094580087,	--   45
    5.374527263,	5.672947889,	5.991200266,	6.330751541,	6.693187066,	--   50
    7.117730093,	7.569201514,	8.049309374,	8.559870057,	9.10281516,	--   55
    9.680198798,	10.29420538,	10.94715786,	11.64152655,	14.00024351,	--   60
    16.04726496,	18.39358812,	21.08297488,	24.16558568,	27.6989151,	--   65
    31.74886419,	36.3909696,	41.71181244,	47.81063314,	71.9980604,	--   70
};

local spd_cnv =     {
	0.765369766,	0.765369766,	0.765369766,	0.765369766,	0.765369766,	--    5
    0.765369766,	0.765369766,	0.765369766,	0.765369766,	0.765369766,	--   10
    0.765369766,	0.803638254,	0.841906742,	0.880175231,	0.918443719,	--   15
    0.956712207,	0.994980695,	1.033249184,	1.071517672,	1.10978616,	--   20
    1.154815734,	1.202336401,	1.252503888,	1.305484802,	1.361457463,	--   25
    1.42061279,	1.483155268,	1.549303993,	1.619293801,	1.693376492,	--   30
    1.771822158,	1.854920617,	1.942982973,	2.036343305,	2.135360499,	--   35
    2.240420235,	2.351937152,	2.470357188,	2.596160128,	2.729862374,	--   40
    2.872019957,	3.023231808,	3.184143321,	3.355450232,	3.537902838,	--   45
    3.732310599,	3.939547145,	4.16055574,	4.396355237,	4.648046574,	--   50
    4.94286812,	5.25638994,	5.589798176,	5.944354206,	6.321399417,	--   55
    6.722360276,	7.148753734,	7.602192957,	8.084393436,	9.722391324,	--   60
    11.143934,	12.77332508,	14.64095478,	16.78165672,	19.23535771,	--   65
    22.04782236,	25.27150667,	28.96653642,	33.20182857,	49.99865305,	--   70
};

function addon.tsv:SetupConversionFactors()
	local level = UnitLevel("Player");
    level = math.max(level,1);
    
	addon.CritConv 		= crt_cnv[level];
	addon.HasteConv 	= hst_cnv[level];
	addon.VersConv 		= vrs_cnv[level];
	addon.MasteryConv 	= mst_cnv[level];
	addon.LeechConv		= lee_cnv[level];
	addon.AvoidConv     = avd_cnv[level];
	addon.SpeedConv     = spd_cnv[level];
end

local statIdMap = {
    [CR_CRIT_SPELL]={["conversionFactor"]="CritConv",["rating"]="BaseCritRating",["bracket"]="StatBrackets"},
    [CR_HASTE_SPELL]={["conversionFactor"]="HasteConv",["rating"]="BaseHasteRating",["bracket"]="StatBrackets"},
    [CR_MASTERY]={["conversionFactor"]="MasteryConv",["rating"]="BaseMasteryRating",["bracket"]="StatBrackets"},
    [CR_VERSATILITY_DAMAGE_DONE]={["conversionFactor"]="VersConv",["rating"]="BaseVersatilityRating",["bracket"]="StatBrackets"},
	[CR_LIFESTEAL]={["conversionFactor"]="LeechConv",["rating"]="BaseLeechRating",["bracket"]="TertiaryStatBrackets"},
	[CR_AVOIDANCE]={["conversionFactor"]="AvoidConv",["rating"]="BaseAvoidanceRating",["bracket"]="TertiaryStatBrackets"},
	[CR_SPEED]={["conversionFactor"]="SpeedConv",["rating"]="BaseSpeedRating",["bracket"]="TertiaryStatBrackets"},
}


--[[
    https://www.wowhead.com/news=318435/update-on-diminishing-returns-for-secondary-stats-in-shadowlands-new-thresholds-

    From 0 to 30%, there's no penalty.
    From 30% to 39%, there's a 10% penalty.
    From 39% to 47%, there's a 20% penalty.
    From 47% to 54%, there's a 30% penalty.
    From 54% to 66%, there's a 40% penalty.
    From 66% to 126%, there's a 50% penalty.
    You can't get more than 126% from gear rating.
]]
addon.tsv.StatBrackets = {
    {["size"]=30,["penalty"]=0},
    {["size"]=10,["penalty"]=0.1},
    {["size"]=10,["penalty"]=0.2},
    {["size"]=10,["penalty"]=0.3},
    {["size"]=20,["penalty"]=0.4},
    {["size"]=120,["penalty"]=0.5},
    {["size"]=100000,["penalty"]=1.0},
}

addon.tsv.TertiaryStatBrackets = {
	{["size"]=10,["penalty"]=0},
	{["size"]=5,["penalty"]=0.2},
	{["size"]=5,["penalty"]=0.4},
	{["size"]=80,["penalty"]=0.6},
	{["size"]=100000,["penalty"]=1.0},
}

--penatly is the % penalty currently
--trueRating is how much stat you effectively have after accounting for diminishes
--bracketRating is how far into the current bracket you are.
--bracketMaxRating is the total rating in your current bracket
function addon.tsv:GetStatDiminishBracket(statId,amount)
    local stat = statIdMap[statId];
    if ( not stat ) then
        return;
    end

    local rating = addon[stat.rating];
    local conversionFactor = addon[stat.conversionFactor];
	local stat_bracket = addon.tsv[stat.bracket];
    local amount = amount or 0;

    local percent = (rating+amount) / conversionFactor;
    local bracket_rating = 0;
    local bracket_max_rating = 0;
    local bracket_penalty = 0;
    local bracket_next_penalty = 0.1;
    local true_rating = 0;

    for i,bracket in ipairs(stat_bracket) do
        if ( percent < bracket.size ) then
            bracket_rating = math.floor(0.5+percent * conversionFactor);
            bracket_max_rating = math.floor(0.5+bracket.size * conversionFactor);
            bracket_penalty = bracket.penalty;
            bracket_next_penalty = stat_bracket[i+1] and stat_bracket[i+1].penalty or 1;
            true_rating = true_rating + (percent * conversionFactor * (1.0 - bracket.penalty) );
            break;
        else
            true_rating = true_rating + (bracket.size * conversionFactor * (1.0 - bracket.penalty) );
        end
        percent = percent - bracket.size;
    end

    true_rating = math.floor(0.005+100*true_rating)/100;
    return true_rating, bracket_penalty, bracket_next_penalty, bracket_rating, bracket_max_rating
end


function addon.tsv:RecalculateTrueStatRatings() 
    addon.BaseCritRating = GetCombatRating(CR_CRIT_SPELL);
    addon.BaseHasteRating = GetCombatRating(CR_HASTE_SPELL);
    addon.BaseMasteryRating = GetCombatRating(CR_MASTERY);
    addon.BaseVersatilityRating = GetCombatRating(CR_VERSATILITY_DAMAGE_DONE);
	addon.BaseLeechRating = GetCombatRating(CR_LIFESTEAL);
	addon.BaseAvoidanceRating = GetCombatRating(CR_AVOIDANCE);
	addon.BaseSpeedRating = GetCombatRating(CR_SPEED);

    addon.TrueStatInfo = addon.TrueStatInfo or {};
    for statId,stat in pairs(statIdMap) do 
        local true_rating, bracket_penalty, bracket_next_penalty, bracket_rating, bracket_max_rating = self:GetStatDiminishBracket(statId);
        addon.TrueStatInfo[statId] = {
            bracketPenalty = bracket_penalty,
            bracketNextPenalty = bracket_next_penalty,
            bracketRating = bracket_rating,
            bracketMaxRating = bracket_max_rating,
            trueRating = true_rating,
            baseRating = addon[stat.rating],
            conversionFactor = addon[stat.conversionFactor]
        };
    end
end

function addon.tsv:GetTrueStatRatingAdded(statId,amountStr)
    local amountStr = amountStr:gsub(",",""); --numbers are big enough to have commas now
    local amount = tonumber(amountStr);
    local currentTrueRating = addon.TrueStatInfo[statId].trueRating;
    local addedTrueRating = self:GetStatDiminishBracket(statId,amount);
    local diff = addedTrueRating - currentTrueRating;
    diff = math.floor(0.005+100*diff)/100;
    return diff;
end
