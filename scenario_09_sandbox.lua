-- Name: Sandbox
-- Description: GM controlled missions
--- Regions defined: Icarus and Kentar
--- Version 1
-- Type: GM Controlled missions

--Ideas
--	damage probe launch

require("utils.lua")
function init()
	updateDiagnostic = false
	healthDiagnostic = false
	change_enemy_order_diagnostic = true
	popupGMDebug = "once"
	setConstants()
	initialGMFunctions()
	createSkeletonUniverse()
	runAllTests()
--	testObject = Artifact():setPosition(100,100):setScanningParameters(1,1):setRadarSignatureInfo(1,.5,0):setModel("SensorArrayMKI"):setDescriptions("sensor","good sensor")
end
--Human navy stations that may always be reached by long range communication
--Fixed stellar features (black holes, worm holes, nebulae)
function createSkeletonUniverse()
	local icx = 11756
	local icy = 1254
	local nukeAvail = true
	local empAvail = true
	local mineAvail = true
	local homeAvail = true
	local hvliAvail = true
	local tradeFood = true
	local tradeMedicine = true
	local tradeLuxury = true
	skeleton_stations = {}
	station_names = {}
	--Icarus
	stationIcarus = SpaceStation():setTemplate("Large Station"):setFaction("Human Navy"):setPosition(icx,icy):setCallSign("Icarus"):setDescription("Shipyard, Naval Regional Headquarters"):setCommsScript(""):setCommsFunction(commsStation)
    stationIcarus.comms_data = {
    	friendlyness = 75,
        weapons = 			{Homing = "neutral",HVLI = "neutral", 		Mine = "neutral",		Nuke = "friend", 			EMP = "friend"},
        weapon_cost =		{Homing = 2, 		HVLI = 1,				Mine = math.random(2,4),Nuke = 15,					EMP = 10 },
        weapon_available = 	{Homing = homeAvail,HVLI = hvliAvail,		Mine = mineAvail,		Nuke = nukeAvail,			EMP = empAvail},
        service_cost = 		{supplydrop = math.random(90,110), reinforcements = math.random(140,160)},
        jump_overcharge =	true,
        sensor_boost = {value = 10000, cost = 0},
        reputation_cost_multipliers = {friend = 1.0, neutral = 2.0},
        max_weapon_refill_amount = {friend = 1.0, neutral = 0.5 },
        goods = {	food = 		{quantity = 10,		cost = 1},
        			medicine =	{quantity = 10,		cost = 5}	},
        trade = {	food = false, medicine = false, luxury = false },
        public_relations = true,
        general_information = "Shipyard for human navy ships. Regional headquarters. Development site for the Atlantis model ship",
    	history = "As humans ran up against more and more unfriendly races, this station became the nexus for research and development of new space ship building technologies. After a few experimental accidents involving militarily driven scientists and fabrication specialists, the station was renamed from Research-37 to Icarus referencing the mythical figure that flew too close to the sun"
	}
	station_names[stationIcarus:getCallSign()] = {stationIcarus:getSectorName(), stationIcarus}
	table.insert(skeleton_stations,stationIcarus)
	--Kentar
	kentar_x = 246000
	kentar_y = 247000
	--local kentarZone = squareZone(kentar_x,kentar_y, "Kentar 2")
	--kentarZone:setColor(0,128,0)
	stationKentar = SpaceStation():setTemplate("Large Station"):setFaction("Human Navy"):setPosition(kentar_x,kentar_y):setCallSign("Kentar 2"):setDescription("Naval Regional Headquarters"):setCommsScript(""):setCommsFunction(commsStation)
    stationKentar.comms_data = {
    	friendlyness = 68,
        weapons = 			{Homing = "neutral",HVLI = "neutral", 		Mine = "neutral",		Nuke = "friend", 			EMP = "friend"},
        weapon_cost =		{Homing = 2, 		HVLI = 1,				Mine = math.random(3,7),Nuke = 13,					EMP = 9 },
        weapon_available = 	{Homing = homeAvail,HVLI = hvliAvail,		Mine = mineAvail,		Nuke = nukeAvail,			EMP = empAvail},
        service_cost = 		{supplydrop = math.random(90,110), reinforcements = math.random(140,160)},
        jump_overcharge =	true,
        sensor_boost = {value = 10000, cost = 0},
        reputation_cost_multipliers = {friend = 1.0, neutral = 2.0},
        max_weapon_refill_amount = {friend = 1.0, neutral = 0.5 },
        goods = {	food = 		{quantity = 10,		cost = 1},
        			medicine =	{quantity = 10,		cost = 5},
        			luxury =	{quantity = 10,		cost = math.random(80,120)}	},
        trade = {	food = false, medicine = false, luxury = false },
        public_relations = true,
        general_information = "Regional headquarters. Jumping off point for actions against Kraylor activity",
    	history = "This used to be a scientific observation and research station. As the Kraylors have grown more agressive, it's been built up and serves as a strategic cornerstone for actions against the Kraylors. The name Kentar derives from Kentauros or Centaurus, after the nearby star's prominent position in the constellation Centaurus"
	}
	table.insert(skeleton_stations,stationKentar)
	station_names[stationKentar:getCallSign()] = {stationKentar:getSectorName(), stationKentar}
	createFleurNebula()
	BlackHole():setPosition(-12443,-23245)
    BlackHole():setPosition(87747, -3384)
    BlackHole():setPosition(80429, -10486)
    BlackHole():setPosition(75695, 2427)
    wormholeIcarus = WormHole():setPosition(-46716, 17958):setTargetPosition(19080, -19780)
    wormholeIcarus.exit = "default"
    wormholeIcarus.default_exit_point_x = 19080
    wormholeIcarus.default_exit_point_y = -19780
    wormholeIcarus.kentar_exit_point_x = 251000
    wormholeIcarus.kentar_exit_point_y = 250000
end
function createFleurNebula()
    Nebula():setPosition(22028, 25793):setCallSign("Fleur")
    Nebula():setPosition(13381, 37572)
    Nebula():setPosition(20835, 35783)
    Nebula():setPosition(15319, 24601)
    Nebula():setPosition(16363, 30415)
    Nebula():setPosition(22923, 17295)
    Nebula():setPosition(27843, 19680)
    Nebula():setPosition(31123, 16997)
    --Borlan area nebula
    Nebula():setPosition(88464, 45469)
    Nebula():setPosition(77847, 35928)
    Nebula():setPosition(79353, 42959)
    Nebula():setPosition(75264, 47622)
    Nebula():setPosition(86671, 36861)
    Nebula():setPosition(96857, 44322)
end
function setConstants()
	universe=universe()
	update_system=updateSystem()
	update_edit_object=nil
	universe:addAvailableRegion("Icarus (F5)",icarusSector,0,0)
	universe:addAvailableRegion("Kentar (R17)",kentarSector,250000,250000)
	universe:addAvailableRegion("Eris (WIP)",function() return erisSector(390000,210000) end,-390000, 210000)
	universe:addAvailableRegion("Ghost Nebula(U33)",function() return ghostNebulaSector() end, 586367, 296408) -- there was an alternate spawn location of 545336,292452, inital spawn location seems to not work eh I will look at it later - starry
	scenarioTime = 0
	playerSpawnX = 0
	playerSpawnY = 0
	startRegion = "Icarus (F5)"
	icarus_color = false
	kentar_color = false
	individual_ship = "Gnat"
	fleetSpawnFaction = "Exuari"
	fleetStrengthFixed = false
	fleetStrengthFixedValue = 250
	fleetStrengthByPlayerStrength = 1
	fleetComposition = "Random"
	fleetOrders = "Idle"
	fleetSpawnLocation = "At Click"
	fleetSpawnRelativeDirection = "Random Direction"
	fleetSpawnAwayDirection = "90"
	fleetSpawnAwayDistance = 60
	createDirection = 90
	createDistance = 30
	fleetAmbushDistance = 5
	fleetChange = "unmodified"
	fleetChangeChance = 20
	fleetList = {}
	existing_fleet_order = "Roaming"
	enemy_reverts = {}
	revert_timer_interval = 7
	revert_timer = revert_timer_interval
	plotRevert = revertWait
	
	ship_template = {	--ordered by relative strength
		["OClock Beam"] =		{strength = 1,	adder = false,	missiler = false,	beamer = false,	frigate = false,	chaser = false,	fighter = false,	drone = false,	unusual = true,		create = beamOverclocker},
		["OClock Engine"] = 	{strength = 1,	adder = false,	missiler = false,	beamer = false,	frigate = false,	chaser = false,	fighter = false,	drone = false,	unusual = true,		create = engineOverclocker},
		["OClock Shield"] =		{strength = 1,	adder = false,	missiler = false,	beamer = false,	frigate = false,	chaser = false,	fighter = false,	drone = false,	unusual = true,		create = shieldOverclocker},
--		["OClock Orbit"] =		{strength = 1,	adder = false,	missiler = false,	beamer = false,	frigate = false,	chaser = false,	fighter = false,	drone = false,	unusual = true,		create = orbiterOverclocker},
		["OClock Boss"] =		{strength = 1,	adder = false,	missiler = false,	beamer = false,	frigate = false,	chaser = false,	fighter = false,	drone = false,	unusual = true,		create = overclockOptimizer},
--		["Orbit Rock"] =		{strength = 20,	adder = false,	missiler = false,	beamer = false,	frigate = false,	chaser = false,	fighter = false,	drone = false,	unusual = true,		create = asteroidOrbiter},
--		["Orbit Mine"] = 		{strength = 30,	adder = false,	missiler = false,	beamer = false,	frigate = false,	chaser = false,	fighter = false,	drone = false,	unusual = true,		create = mineOrbiter},
		["Leech Sat"] =		 	{strength = 80,	adder = false,	missiler = false,	beamer = false,	frigate = false,	chaser = false,	fighter = false,	drone = false,	unusual = true,		create = leech},
		-- normal ships that are part of the fleet spawn process
		["Gnat"] =				{strength = 2,	adder = false,	missiler = false,	beamer = true,	frigate = false,	chaser = false,	fighter = true,		drone = true,	unusual = false,	create = gnat},
		["Lite Drone"] =		{strength = 3,	adder = false,	missiler = false,	beamer = true,	frigate = false,	chaser = false,	fighter = true, 	drone = true,	unusual = false,	create = droneLite},
		["Jacket Drone"] =		{strength = 4,	adder = false,	missiler = false,	beamer = true,	frigate = false,	chaser = false,	fighter = true, 	drone = true,	unusual = false,	create = droneJacket},
		["Ktlitan Drone"] =		{strength = 4,	adder = false,	missiler = false,	beamer = true,	frigate = false,	chaser = false,	fighter = true, 	drone = true,	unusual = false,	create = stockTemplate},
		["Heavy Drone"] =		{strength = 5,	adder = false,	missiler = false,	beamer = true,	frigate = false,	chaser = false,	fighter = true, 	drone = true,	unusual = false,	create = droneHeavy},
		["Adder MK3"] =			{strength = 5,	adder = true,	missiler = false,	beamer = false,	frigate = false,	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = adderMk3},
		["MT52 Hornet"] =		{strength = 5,	adder = false,	missiler = false,	beamer = true,	frigate = false,	chaser = false,	fighter = true, 	drone = false,	unusual = false,	create = stockTemplate},
		["MU52 Hornet"] =		{strength = 5,	adder = false,	missiler = false,	beamer = true,	frigate = false,	chaser = false,	fighter = true, 	drone = false,	unusual = false,	create = stockTemplate},
		["MV52 Hornet"] =		{strength = 6,	adder = false,	missiler = false,	beamer = true,	frigate = false,	chaser = false,	fighter = true, 	drone = false,	unusual = false,	create = hornetMV52},
		["Adder MK4"] =			{strength = 6,	adder = true,	missiler = false,	beamer = false,	frigate = false,	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = stockTemplate},
		["Fighter"] =			{strength = 6,	adder = false,	missiler = false,	beamer = true,	frigate = false,	chaser = false,	fighter = true, 	drone = false,	unusual = false,	create = stockTemplate},
		["Ktlitan Fighter"] =	{strength = 6,	adder = false,	missiler = false,	beamer = true,	frigate = false,	chaser = false,	fighter = true, 	drone = false,	unusual = false,	create = stockTemplate},
		["K2 Fighter"] =		{strength = 7,	adder = false,	missiler = false,	beamer = true,	frigate = false,	chaser = false,	fighter = true, 	drone = false,	unusual = false,	create = k2fighter},
		["Adder MK5"] =			{strength = 7,	adder = true,	missiler = false,	beamer = false,	frigate = false,	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = stockTemplate},
		["WX-Lindworm"] =		{strength = 7,	adder = false,	missiler = true,	beamer = false,	frigate = false,	chaser = false,	fighter = true, 	drone = false,	unusual = false,	create = stockTemplate},
		["K3 Fighter"] =		{strength = 8,	adder = false,	missiler = false,	beamer = true,	frigate = false,	chaser = false,	fighter = true, 	drone = false,	unusual = false,	create = k3fighter},
		["Adder MK6"] =			{strength = 8,	adder = true,	missiler = false,	beamer = false,	frigate = false,	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = stockTemplate},
		["Ktlitan Scout"] =		{strength = 8,	adder = false,	missiler = false,	beamer = true,	frigate = false,	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = stockTemplate},
		["WZ-Lindworm"] =		{strength = 9,	adder = false,	missiler = true,	beamer = false,	frigate = false,	chaser = false,	fighter = true, 	drone = false,	unusual = false,	create = wzLindworm},
		["Adder MK7"] =			{strength = 9,	adder = true,	missiler = false,	beamer = false,	frigate = false,	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = adderMk7},
		["Adder MK8"] =			{strength = 10,	adder = true,	missiler = false,	beamer = false,	frigate = false,	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = adderMk8},
		["Adder MK9"] =			{strength = 11,	adder = true,	missiler = false,	beamer = false,	frigate = false,	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = adderMk9},
		["Nirvana R3"] =		{strength = 12,	adder = false,	missiler = false,	beamer = true,	frigate = false,	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = nirvanaR3},
		["Phobos R2"] =			{strength = 13,	adder = false,	missiler = false,	beamer = false,	frigate = true, 	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = phobosR2},
		["Missile Cruiser"] =	{strength = 14,	adder = false,	missiler = true,	beamer = false,	frigate = true, 	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = stockTemplate},
		["Waddle 5"] =			{strength = 15,	adder = true,	missiler = false,	beamer = false,	frigate = false,	chaser = true,	fighter = false,	drone = false,	unusual = false,	create = waddle5},
		["Jade 5"] =			{strength = 15,	adder = true,	missiler = false,	beamer = false,	frigate = false,	chaser = true,	fighter = false,	drone = false,	unusual = false,	create = jade5},
		["Phobos T3"] =			{strength = 15,	adder = false,	missiler = false,	beamer = false,	frigate = true, 	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = stockTemplate},
		["Piranha F8"] =		{strength = 15,	adder = false,	missiler = true,	beamer = false,	frigate = true, 	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = stockTemplate},
		["Piranha F12"] =		{strength = 15,	adder = false,	missiler = true,	beamer = false,	frigate = true, 	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = stockTemplate},
		["Piranha F12.M"] =		{strength = 16,	adder = false,	missiler = true,	beamer = false,	frigate = true, 	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = stockTemplate},
		["Phobos M3"] =			{strength = 16,	adder = false,	missiler = false,	beamer = false,	frigate = true, 	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = stockTemplate},
		["Karnack"] =			{strength = 17,	adder = false,	missiler = false,	beamer = true,	frigate = true,		chaser = false,	fighter = false,	drone = false,	unusual = false,	create = stockTemplate},
		["Gunship"] =			{strength = 17,	adder = false,	missiler = false,	beamer = false,	frigate = true,		chaser = false,	fighter = false,	drone = false,	unusual = false,	create = stockTemplate},
		["Cruiser"] =			{strength = 18,	adder = true,	missiler = false,	beamer = true,	frigate = true, 	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = stockTemplate},
		["Nirvana R5"] =		{strength = 19,	adder = false,	missiler = false,	beamer = true,	frigate = true, 	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = stockTemplate},
		["Nirvana R5A"] =		{strength = 20,	adder = false,	missiler = false,	beamer = true,	frigate = true, 	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = stockTemplate},
		["Adv. Gunship"] =		{strength = 20,	adder = false,	missiler = false,	beamer = false,	frigate = true,		chaser = false,	fighter = false,	drone = false,	unusual = false,	create = stockTemplate},
		["Storm"] =				{strength = 22,	adder = false,	missiler = true,	beamer = false,	frigate = true, 	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = stockTemplate},
		["Stalker R5"] =		{strength = 22,	adder = false,	missiler = false,	beamer = true,	frigate = true, 	chaser = true,	fighter = false,	drone = false,	unusual = false,	create = stalkerR5},
		["Stalker Q5"] =		{strength = 22,	adder = false,	missiler = false,	beamer = true,	frigate = true, 	chaser = true,	fighter = false,	drone = false,	unusual = false,	create = stalkerQ5},
		["Ranus U"] =			{strength = 25,	adder = false,	missiler = true,	beamer = false,	frigate = true, 	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = stockTemplate},
		["Stalker Q7"] =		{strength = 25,	adder = false,	missiler = false,	beamer = true,	frigate = true, 	chaser = true,	fighter = false,	drone = false,	unusual = false,	create = stockTemplate},
		["Stalker R7"] =		{strength = 25,	adder = false,	missiler = false,	beamer = true,	frigate = true, 	chaser = true,	fighter = false,	drone = false,	unusual = false,	create = stockTemplate},
		["Adv. Striker"] =		{strength = 27,	adder = false,	missiler = false,	beamer = true,	frigate = true,		chaser = true,	fighter = false,	drone = false,	unusual = false,	create = stockTemplate},
		["Elara P2"] =			{strength = 28,	adder = false,	missiler = false,	beamer = false,	frigate = true, 	chaser = true,	fighter = false,	drone = false,	unusual = false,	create = elaraP2},
		["Tempest"] =			{strength = 30,	adder = false,	missiler = true,	beamer = false,	frigate = true, 	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = tempest},
		["Strikeship"] =		{strength = 30,	adder = false,	missiler = false,	beamer = true,	frigate = true, 	chaser = true,	fighter = false,	drone = false,	unusual = false,	create = stockTemplate},
		["Fiend G3"] =			{strength = 33,	adder = false,	missiler = false,	beamer = false,	frigate = true, 	chaser = true,	fighter = false,	drone = false,	unusual = false,	create = fiendG3},
		["Fiend G4"] =			{strength = 35,	adder = false,	missiler = false,	beamer = false,	frigate = true, 	chaser = true,	fighter = false,	drone = false,	unusual = false,	create = fiendG4},
		["Cucaracha"] =			{strength = 36,	adder = false,	missiler = false,	beamer = true,	frigate = false,	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = cucaracha},
		["Fiend G5"] =			{strength = 37,	adder = false,	missiler = false,	beamer = false,	frigate = true, 	chaser = true,	fighter = false,	drone = false,	unusual = false,	create = fiendG5},
		["Fiend G6"] =			{strength = 39,	adder = false,	missiler = false,	beamer = false,	frigate = true, 	chaser = true,	fighter = false,	drone = false,	unusual = false,	create = fiendG6},
		["Ktlitan Worker"] =	{strength = 40,	adder = false,	missiler = false,	beamer = true,	frigate = false,	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = stockTemplate},
		["Predator"] =			{strength = 42,	adder = false,	missiler = false,	beamer = false,	frigate = true, 	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = predator},
		["Ktlitan Breaker"] =	{strength = 45,	adder = false,	missiler = false,	beamer = false,	frigate = false,	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = stockTemplate},
		["Hurricane"] =			{strength = 46,	adder = false,	missiler = true,	beamer = false,	frigate = true, 	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = hurricane},
		["Ktlitan Feeder"] =	{strength = 48,	adder = false,	missiler = false,	beamer = true,	frigate = false,	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = stockTemplate},
		["Atlantis X23"] =		{strength = 50,	adder = false,	missiler = false,	beamer = false,	frigate = false,	chaser = true,	fighter = false,	drone = false,	unusual = false,	create = stockTemplate},
		["K2 Breaker"] =		{strength = 55,	adder = false,	missiler = false,	beamer = false,	frigate = false,	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = k2breaker},
		["Ktlitan Destroyer"] =	{strength = 50,	adder = false,	missiler = false,	beamer = false,	frigate = false,	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = stockTemplate},
		["Atlantis Y42"] =		{strength = 60,	adder = false,	missiler = false,	beamer = false,	frigate = false,	chaser = true,	fighter = false,	drone = false,	unusual = false,	create = atlantisY42},
		["Blockade Runner"] =	{strength = 65,	adder = false,	missiler = false,	beamer = true,	frigate = false,	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = stockTemplate},
		["Starhammer II"] =		{strength = 70,	adder = false,	missiler = false,	beamer = false,	frigate = false,	chaser = true,	fighter = false,	drone = false,	unusual = false,	create = stockTemplate},
		["Enforcer"] =			{strength = 75,	adder = false,	missiler = false,	beamer = false,	frigate = true, 	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = enforcer},
		["Dreadnought"] =		{strength = 80,	adder = false,	missiler = false,	beamer = true,	frigate = false,	chaser = false,	fighter = false,	drone = false,	unusual = false,	create = stockTemplate},
		["Starhammer III"] =	{strength = 85,	adder = false,	missiler = false,	beamer = false,	frigate = false,	chaser = true,	fighter = false,	drone = false,	unusual = false,	create = starhammerIII},
		["Starhammer V"] =		{strength = 90,	adder = false,	missiler = false,	beamer = false,	frigate = false,	chaser = true,	fighter = false,	drone = false,	unusual = false,	create = starhammerV},
		["Battlestation"] =		{strength = 100,adder = false,	missiler = false,	beamer = true,	frigate = false,	chaser = true,	fighter = false,	drone = false,	unusual = false,	create = stockTemplate},
		["Tyr"] =				{strength = 150,adder = false,	missiler = false,	beamer = true,	frigate = false,	chaser = true,	fighter = false,	drone = false,	unusual = false,	create = tyr},
		["Odin"] =				{strength = 250,adder = false,	missiler = false,	beamer = false,	frigate = false,	chaser = true,	fighter = false,	drone = false,	unusual = false,	create = stockTemplate},
	}
	fleet_group = {
		["adder"] = "Adders",
		["Adders"] = "adder",
		["missiler"] = "Missilers",
		["Missilers"] = "missiler",
		["beamer"] = "Beamers",
		["Beamers"] = "beamer",
		["frigate"] = "Frigates",
		["Frigates"] = "frigate",
		["chaser"] = "Chasers",
		["Chasers"] = "chaser",
		["fighter"] = "Fighters",
		["Fighters"] = "fighter",
		["drone"] = "Drones",
		["Drones"] = "drone",
	}
	pool_selectivity = "full"
	template_pool_size = 5
	formation_delta = {
		["square"] = {
			x = {0,1,0,-1, 0,1,-1, 1,-1,2,0,-2, 0,2,-2, 2,-2,2, 2,-2,-2,1,-1, 1,-1,0, 0,3,-3,1, 1,3,-3,-1,-1, 3,-3,2, 2,3,-3,-2,-2, 3,-3,3, 3,-3,-3,4,0,-4, 0,4,-4, 4,-4,-4,-4,-4,-4,-4,-4,4, 4,4, 4,4, 4, 1,-1, 2,-2, 3,-3,1,-1,2,-2,3,-3,5,-5,0, 0,5, 5,-5,-5,-5,-5,-5,-5,-5,-5,-5,-5,5, 5,5, 5,5, 5,5, 5, 1,-1, 2,-2, 3,-3, 4,-4,1,-1,2,-2,3,-3,4,-4},
			y = {0,0,1, 0,-1,1,-1,-1, 1,0,2, 0,-2,2,-2,-2, 2,1,-1, 1,-1,2, 2,-2,-2,3,-3,0, 0,3,-3,1, 1, 3,-3,-1,-1,3,-3,2, 2, 3,-3,-2,-2,3,-3, 3,-3,0,4, 0,-4,4,-4,-4, 4, 1,-1, 2,-2, 3,-3,1,-1,2,-2,3,-3,-4,-4,-4,-4,-4,-4,4, 4,4, 4,4, 4,0, 0,5,-5,5,-5, 5,-5, 1,-1, 2,-2, 3,-3, 4,-4,1,-1,2,-2,3,-3,4,-4,-5,-5,-5,-5,-5,-5,-5,-5,5, 5,5, 5,5, 5,5, 5},
		},
		["hexagonal"] = {
			x = {0,2,-2,1,-1, 1,-1,4,-4,0, 0,2,-2,-2, 2,3,-3, 3,-3,6,-6,1,-1, 1,-1,3,-3, 3,-3,4,-4, 4,-4,5,-5, 5,-5,8,-8,4,-4, 4,-4,5,5 ,-5,-5,2, 2,-2,-2,0, 0,6, 6,-6,-6,7, 7,-7,-7,10,-10,5, 5,-5,-5,6, 6,-6,-6,7, 7,-7,-7,8, 8,-8,-8,9, 9,-9,-9,3, 3,-3,-3,1, 1,-1,-1,12,-12,6,-6, 6,-6,7,-7, 7,-7,8,-8, 8,-8,9,-9, 9,-9,10,-10,10,-10,11,-11,11,-11,4,-4, 4,-4,2,-2, 2,-2,0, 0},
			y = {0,0, 0,1, 1,-1,-1,0, 0,2,-2,2,-2, 2,-2,1,-1,-1, 1,0, 0,3, 3,-3,-3,3,-3,-3, 3,2,-2,-2, 2,1,-1,-1, 1,0, 0,4,-4,-4, 4,3,-3, 3,-3,4,-4, 4,-4,4,-4,2,-2, 2,-2,1,-1, 1,-1, 0,  0,5,-5, 5,-5,4,-4, 4,-4,3,-3, 3,-7,2,-2, 2,-2,1,-1, 1,-1,5,-5, 5,-5,5,-5, 5,-5, 0,  0,6, 6,-6,-6,5, 5,-5,-5,4, 4,-4,-4,3, 3,-3,-3, 2,  2,-2, -2, 1,  1,-1, -1,6, 6,-6,-6,6, 6,-6,-6,6,-6},
		},
		["pyramid"] = {
			[1] = {
				{angle =  0, distance = 0},
			},
			[2] = {
				{angle = -1, distance = 1},
				{angle =  1, distance = 1},
			},
			[3] = {
				{angle =  0, distance = 0},
				{angle = -1, distance = 1},
				{angle =  1, distance = 1},				
			},
			[4] = {
				{angle =  0, distance = 0},
				{angle = -1, distance = 1},
				{angle =  1, distance = 1},
				{angle =  0, distance = 2},	
			},
			[5] = {
				{angle =  0, distance = 0},
				{angle = -1, distance = 1},
				{angle =  1, distance = 1},
				{angle = -2, distance = 2},
				{angle =  2, distance = 2},
			},
			[6] = {
				{angle =  0, distance = 0},
				{angle = -1, distance = 1},
				{angle =  1, distance = 1},
				{angle = -2, distance = 2},
				{angle =  2, distance = 2},
				{angle =  0, distance = 2},	
			},
			[7] = {
				{angle =  0, distance = 0},
				{angle = -1, distance = 1},
				{angle =  1, distance = 1},
				{angle = -2, distance = 2},
				{angle =  2, distance = 2},
				{angle = -3, distance = 3},
				{angle =  3, distance = 3},
			},
			[8] = {
				{angle =  0, distance = 0},
				{angle = -1, distance = 1},
				{angle =  1, distance = 1},
				{angle = -2, distance = 2},
				{angle =  2, distance = 2},
				{angle =  0, distance = 2},	
				{angle = -3, distance = 3},
				{angle =  3, distance = 3},
			},
			[9] = {
				{angle =  0, distance = 0},
				{angle = -1, distance = 1},
				{angle =  1, distance = 1},
				{angle = -2, distance = 2},
				{angle =  2, distance = 2},
				{angle = -3, distance = 3},
				{angle =  3, distance = 3},
				{angle = -4, distance = 4},
				{angle =  4, distance = 4},
			},
		},
	}
	max_pyramid_tier = 9
	-- square grid deployment	
	fleetPosDelta1x = {0,1,0,-1, 0,1,-1, 1,-1,2,0,-2, 0,2,-2, 2,-2,2, 2,-2,-2,1,-1, 1,-1,0, 0,3,-3,1, 1,3,-3,-1,-1, 3,-3,2, 2,3,-3,-2,-2, 3,-3,3, 3,-3,-3,4,0,-4, 0,4,-4, 4,-4,-4,-4,-4,-4,-4,-4,4, 4,4, 4,4, 4, 1,-1, 2,-2, 3,-3,1,-1,2,-2,3,-3,5,-5,0, 0,5, 5,-5,-5,-5,-5,-5,-5,-5,-5,-5,-5,5, 5,5, 5,5, 5,5, 5, 1,-1, 2,-2, 3,-3, 4,-4,1,-1,2,-2,3,-3,4,-4}
	fleetPosDelta1y = {0,0,1, 0,-1,1,-1,-1, 1,0,2, 0,-2,2,-2,-2, 2,1,-1, 1,-1,2, 2,-2,-2,3,-3,0, 0,3,-3,1, 1, 3,-3,-1,-1,3,-3,2, 2, 3,-3,-2,-2,3,-3, 3,-3,0,4, 0,-4,4,-4,-4, 4, 1,-1, 2,-2, 3,-3,1,-1,2,-2,3,-3,-4,-4,-4,-4,-4,-4,4, 4,4, 4,4, 4,0, 0,5,-5,5,-5, 5,-5, 1,-1, 2,-2, 3,-3, 4,-4,1,-1,2,-2,3,-3,4,-4,-5,-5,-5,-5,-5,-5,-5,-5,5, 5,5, 5,5, 5,5, 5}
	-- rough hexagonal deployment
	fleetPosDelta2x = {0,2,-2,1,-1, 1,-1,4,-4,0, 0,2,-2,-2, 2,3,-3, 3,-3,6,-6,1,-1, 1,-1,3,-3, 3,-3,4,-4, 4,-4,5,-5, 5,-5,8,-8,4,-4, 4,-4,5,5 ,-5,-5,2, 2,-2,-2,0, 0,6, 6,-6,-6,7, 7,-7,-7,10,-10,5, 5,-5,-5,6, 6,-6,-6,7, 7,-7,-7,8, 8,-8,-8,9, 9,-9,-9,3, 3,-3,-3,1, 1,-1,-1,12,-12,6,-6, 6,-6,7,-7, 7,-7,8,-8, 8,-8,9,-9, 9,-9,10,-10,10,-10,11,-11,11,-11,4,-4, 4,-4,2,-2, 2,-2,0, 0}
	fleetPosDelta2y = {0,0, 0,1, 1,-1,-1,0, 0,2,-2,2,-2, 2,-2,1,-1,-1, 1,0, 0,3, 3,-3,-3,3,-3,-3, 3,2,-2,-2, 2,1,-1,-1, 1,0, 0,4,-4,-4, 4,3,-3, 3,-3,4,-4, 4,-4,4,-4,2,-2, 2,-2,1,-1, 1,-1, 0,  0,5,-5, 5,-5,4,-4, 4,-4,3,-3, 3,-7,2,-2, 2,-2,1,-1, 1,-1,5,-5, 5,-5,5,-5, 5,-5, 0,  0,6, 6,-6,-6,5, 5,-5,-5,4, 4,-4,-4,3, 3,-3,-3, 2,  2,-2, -2, 1,  1,-1, -1,6, 6,-6,-6,6, 6,-6,-6,6,-6}

	fleet_exclusions = {
		["Nuke"]	= {letter = "N", exclude = false},
		["Warp"]	= {letter = "W", exclude = false},
		["Jump"]	= {letter = "J", exclude = false},
		["Unusual"]	= {letter = "U", exclude = true},
	}

	playerShipStats = {	
		["MP52 Hornet"] 		= { strength = 7, 	cargo = 3,	distance = 100,	long_range_radar = 18000, short_range_radar = 4000, tractor = false,	mining = false,	probes = 5,		pods = 1},
		["Piranha"]				= { strength = 16,	cargo = 8,	distance = 200,	long_range_radar = 25000, short_range_radar = 6000, tractor = false,	mining = false,	probes = 6,		pods = 2},
		["Flavia P.Falcon"]		= { strength = 13,	cargo = 15,	distance = 200,	long_range_radar = 40000, short_range_radar = 5000, tractor = true,		mining = true,	probes = 8,		pods = 4},
		["Phobos M3P"]			= { strength = 19,	cargo = 10,	distance = 200,	long_range_radar = 25000, short_range_radar = 5000, tractor = true,		mining = false,	probes = 6,		pods = 3},
		["Atlantis"]			= { strength = 52,	cargo = 6,	distance = 400,	long_range_radar = 30000, short_range_radar = 5000, tractor = true,		mining = true,	probes = 10,	pods = 2},
		["Player Cruiser"]		= { strength = 40,	cargo = 6,	distance = 400,	long_range_radar = 30000, short_range_radar = 5000, tractor = false,	mining = false,	probes = 10,	pods = 2},
		["Player Missile Cr."]	= { strength = 45,	cargo = 8,	distance = 200,	long_range_radar = 35000, short_range_radar = 6000, tractor = false,	mining = false,	probes = 9,		pods = 2},
		["Player Fighter"]		= { strength = 7,	cargo = 3,	distance = 100,	long_range_radar = 15000, short_range_radar = 4500, tractor = false,	mining = false,	probes = 4,		pods = 1},
		["Benedict"]			= { strength = 10,	cargo = 9,	distance = 400,	long_range_radar = 30000, short_range_radar = 5000, tractor = true,		mining = true,	probes = 10,	pods = 3},
		["Kiriya"]				= { strength = 10,	cargo = 9,	distance = 400,	long_range_radar = 35000, short_range_radar = 5000, tractor = true,		mining = true,	probes = 10,	pods = 3},
		["Striker"]				= { strength = 8,	cargo = 4,	distance = 200,	long_range_radar = 35000, short_range_radar = 5000, tractor = false,	mining = false,	probes = 6,		pods = 1},
		["ZX-Lindworm"]			= { strength = 8,	cargo = 3,	distance = 100,	long_range_radar = 18000, short_range_radar = 5500, tractor = false,	mining = false,	probes = 4,		pods = 1},
		["Repulse"]				= { strength = 14,	cargo = 12,	distance = 200,	long_range_radar = 38000, short_range_radar = 5000, tractor = true,		mining = false,	probes = 8,		pods = 5},
		["Ender"]				= { strength = 100,	cargo = 20,	distance = 2000,long_range_radar = 45000, short_range_radar = 7000, tractor = true,		mining = false,	probes = 12,	pods = 6},
		["Nautilus"]			= { strength = 12,	cargo = 7,	distance = 200,	long_range_radar = 22000, short_range_radar = 4000, tractor = false,	mining = false,	probes = 10,	pods = 2},
		["Hathcock"]			= { strength = 30,	cargo = 6,	distance = 200,	long_range_radar = 35000, short_range_radar = 6000, tractor = false,	mining = true,	probes = 8,		pods = 2},
		["Maverick"]			= { strength = 45,	cargo = 5,	distance = 200,	long_range_radar = 20000, short_range_radar = 4000, tractor = false,	mining = true,	probes = 9,		pods = 1},
		["Crucible"]			= { strength = 45,	cargo = 5,	distance = 200,	long_range_radar = 20000, short_range_radar = 6000, tractor = false,	mining = false,	probes = 9,		pods = 1},
		["Proto-Atlantis"]		= { strength = 40,	cargo = 4,	distance = 400,	long_range_radar = 30000, short_range_radar = 4500, tractor = false,	mining = true,	probes = 8,		pods = 1},
		["Surkov"]				= { strength = 35,	cargo = 6,	distance = 200,	long_range_radar = 35000, short_range_radar = 6000, tractor = false,	mining = false,	probes = 8,		pods = 2},
		["Redhook"]				= { strength = 11,	cargo = 8,	distance = 200,	long_range_radar = 20000, short_range_radar = 6000, tractor = false,	mining = false,	probes = 6,		pods = 2},
		["Pacu"]				= { strength = 18,	cargo = 7,	distance = 200,	long_range_radar = 20000, short_range_radar = 6000, tractor = false,	mining = false,	probes = 6,		pods = 2},
		["Phobos T2"]			= { strength = 19,	cargo = 9,	distance = 200,	long_range_radar = 25000, short_range_radar = 5000, tractor = true,		mining = false,	probes = 5,		pods = 3},
		["Wombat"]				= { strength = 17,	cargo = 3,	distance = 100,	long_range_radar = 18000, short_range_radar = 6000, tractor = false,	mining = false,	probes = 5,		pods = 1},
		["Holmes"]				= { strength = 35,	cargo = 6,	distance = 200,	long_range_radar = 35000, short_range_radar = 4000, tractor = true,		mining = false,	probes = 8,		pods = 2},
		["Focus"]				= { strength = 35,	cargo = 4,	distance = 200,	long_range_radar = 32000, short_range_radar = 5000, tractor = false,	mining = true,	probes = 8,		pods = 1},
		["Flavia 2C"]			= { strength = 25,	cargo = 12,	distance = 200,	long_range_radar = 30000, short_range_radar = 5000, tractor = false,	mining = true,	probes = 9,		pods = 3},
		["Destroyer IV"]		= { strength = 22,	cargo = 5,	distance = 400,	long_range_radar = 30000, short_range_radar = 5000, tractor = false,	mining = true,	probes = 8,		pods = 1},
		["Destroyer III"]		= { strength = 25,	cargo = 7,	distance = 200,	long_range_radar = 30000, short_range_radar = 5000, tractor = false,	mining = false,	probes = 8,		pods = 2},
		["MX-Lindworm"]			= { strength = 10,	cargo = 3,	distance = 100,	long_range_radar = 30000, short_range_radar = 5000, tractor = false,	mining = false,	probes = 5,		pods = 1},
		["Striker LX"]			= { strength = 16,	cargo = 4,	distance = 200,	long_range_radar = 20000, short_range_radar = 4000, tractor = false,	mining = false,	probes = 7,		pods = 1},
		["Maverick XP"]			= { strength = 23,	cargo = 5,	distance = 200,	long_range_radar = 25000, short_range_radar = 7000, tractor = true,		mining = false,	probes = 10,	pods = 1},
		["Era"]					= { strength = 14,	cargo = 14,	distance = 200,	long_range_radar = 50000, short_range_radar = 5000, tractor = true,		mining = true,	probes = 8,		pods = 4},
		["Squid"]				= { strength = 14,	cargo = 8,	distance = 200,	long_range_radar = 25000, short_range_radar = 5000, tractor = false,	mining = false,	probes = 7,		pods = 2},
		["Nusret"]				= { strength = 16,	cargo = 7,	distance = 200,	long_range_radar = 25000, short_range_radar = 4000, tractor = false,	mining = true,	probes = 10,	pods = 1},
		["XR-Lindworm"]			= { strength = 12,	cargo = 3,	distance = 100,	long_range_radar = 20000, short_range_radar = 6000, tractor = false,	mining = false,	probes = 5,		pods = 1},
		["Vermin"]				= { strength = 10,	cargo = 3,	distance = 100,	long_range_radar = 22000, short_range_radar = 4000, tractor = false,	mining = true,	probes = 4,		pods = 1},
		["Butler"]				= { strength = 20,	cargo = 6,	distance = 200,	long_range_radar = 30000, short_range_radar = 5500, tractor = true,		mining = false,	probes = 8,		pods = 2},
		["Glass Cannon"]		= { strength = 15,	cargo = 3,	distance = 100,	long_range_radar = 30000, short_range_radar = 5000, tractor = false,	mining = false,	probes = 8,		pods = 1},
		["Scatter"]				= { strength = 30,	cargo = 6,	distance = 200,	long_range_radar = 25000, short_range_radar = 5000, tractor = false,	mining = true,	probes = 8,		pods = 1},
		["Gull"]				= { strength = 14,	cargo = 14,	distance = 200,	long_range_radar = 40000, short_range_radar = 5000, tractor = true,		mining = true,	probes = 8,		pods = 4},
		["Eldridge"]			= { strength = 15,	cargo = 7,	distance = 200,	long_range_radar = 24000, short_range_radar = 8000, tractor = false,	mining = true,	probes = 10,	pods = 2},
		["Fray"]				= { strength = 22,	cargo = 5,	distance = 200,	long_range_radar = 23000, short_range_radar = 4500, tractor = true,		mining = false,	probes = 7,		pods = 1},
		["Kludge"]				= { strength = 22,	cargo = 9,	distance = 200,	long_range_radar = 35000, short_range_radar = 3500, tractor = false,	mining = true,	probes = 20,	pods = 5},
		["Noble"]				= { strength = 30,	cargo = 6,	distance = 400,	long_range_radar = 27000, short_range_radar = 5000, tractor = true,		mining = false,	probes = 8,		pods = 2},
		["Rook"]				= { strength = 15,	cargo = 12,	distance = 200,	long_range_radar = 41000, short_range_radar = 5500, tractor = false,	mining = true,	probes = 13,	pods = 3},
		["Crab"]				= { strength = 20,	cargo = 6,	distance = 200,	long_range_radar = 30000, short_range_radar = 5500, tractor = false,	mining = true,	probes = 13,	pods = 1},
		["Caretaker"]			= { strength = 23,	cargo = 6,	distance = 200,	long_range_radar = 35000, short_range_radar = 5000, tractor = true,		mining = false,	probes = 9,		pods = 2},
		["Safari"]				= { strength = 15,	cargo = 10,	distance = 200,	long_range_radar = 33000, short_range_radar = 4500, tractor = true,		mining = false,	probes = 9,		pods = 3},
		["Gadfly"]				= { strength = 9,	cargo = 3,	distance = 100,	long_range_radar = 15000, short_range_radar = 4500, tractor = false,	mining = false,	probes = 4,		pods = 1},
		["Atlantis II"]			= { strength = 60,	cargo = 6,	distance = 400,	long_range_radar = 30000, short_range_radar = 5000, tractor = true,		mining = true,	probes = 11,	pods = 3},
		["Skray"]				= { strength = 15,	cargo = 3,	distance = 200, long_range_radar = 30000, short_range_radar = 7500, tractor = false,	mining = false,	probes = 25,	pods = 1},
	}	
	--goodsList = {	{"food",0}, {"medicine",0},	{"nickel",0}, {"platinum",0}, {"gold",0}, {"dilithium",0}, {"tritanium",0}, {"luxury",0}, {"cobalt",0}, {"impulse",0}, {"warp",0}, {"shield",0}, {"tractor",0}, {"repulsor",0}, {"beam",0}, {"optic",0}, {"robotic",0}, {"filament",0}, {"transporter",0}, {"sensor",0}, {"communication",0}, {"autodoc",0}, {"lifter",0}, {"android",0}, {"nanites",0}, {"software",0}, {"circuit",0}, {"battery",0}	}
	attackFleetFunction = {orderFleetAttack1,orderFleetAttack2,orderFleetAttack3,orderFleetAttack4,orderFleetAttack5,orderFleetAttack6,orderFleetAttack7,orderFleetAttack8}
	defendFleetFunction = {orderFleetDefend1,orderFleetDefend2,orderFleetDefend3,orderFleetDefend4,orderFleetDefend5,orderFleetDefend6,orderFleetDefend7,orderFleetDefend8}
	flyFleetFunction = {orderFleetFly1,orderFleetFly2,orderFleetFly3,orderFleetFly4,orderFleetFly5,orderFleetFly6,orderFleetFly7,orderFleetFly8}
	flyBlindFleetFunction = {orderFleetFlyBlind1,orderFleetFlyBlind2,orderFleetFlyBlind3,orderFleetFlyBlind4,orderFleetFlyBlind5,orderFleetFlyBlind6,orderFleetFlyBlind7,orderFleetFlyBlind8}
	dockFleetFunction = {orderFleetDock1,orderFleetDock2,orderFleetDock3,orderFleetDock4,orderFleetDock5,orderFleetDock6,orderFleetDock7,orderFleetDock8}
	associatedTypeDistance = {	["PlayerSpaceship"] = 2000,
								["SpaceStation"] = 2000,
								["SupplyDrop"] = 50,
								["WarpJammer"] = 200,
								["Mine"] = 200,
								["Asteroid"] = 200,
								["BlackHole"] = 5200,
								["Nebula"] = 200, 
								["Artifact"] = 200, 
								["ScanProbe"] = 200, 
								["VisualAsteroid"] = 200, 
								["WormHole"] = 2625,
								["CpuShip"] = 2000}
	spaceStationDistance = {["Small Station"] = 400, ["Medium Station"] = 1200, ["Large Station"] = 1400, ["Huge Station"] = 2000}
	commonGoods = {"food","medicine","nickel","platinum","gold","dilithium","tritanium","luxury","cobalt","impulse","warp","shield","tractor","repulsor","beam","optic","robotic","filament","transporter","sensor","communication","autodoc","lifter","android","nanites","software","circuit","battery"}
	componentGoods = {"impulse","warp","shield","tractor","repulsor","beam","optic","robotic","filament","transporter","sensor","communication","autodoc","lifter","android","nanites","software","circuit","battery"}
	mineralGoods = {"nickel","platinum","gold","dilithium","tritanium","cobalt"}
	goods = {}					--overall tracking of goods
	tradeFood = {}				--stations that will trade food for other goods
	tradeLuxury = {}			--stations that will trade luxury for other goods
	tradeMedicine = {}			--stations that will trade medicine for other goods
	healthCheckTimerInterval = 10
	healthCheckTimer = healthCheckTimerInterval
	rendezvousPoints = {}
	escapePodList = {}
	drop_point_location = "At Click"
	scan_clue_location = "At Click"
	artifactCounter = 0
	artifactNumber = 0
	dropOrExtractAction = "Drop"
	marinePointList = {}
	engineerPointList = {}
	medicPointList = {}
	scanComplexity = 1
	scanDepth = 1
	--Default GM supply drop gives:
	--500 energy
	--4 Homing
	--1 Nuke
	--2 Mines
	--1 EMP
	supplyEnergy = 500
	supplyHoming = 4
	supplyNuke = 1
	supplyMine = 2
	supplyEMP = 1
	supplyHVLI = 0
	supplyRepairCrew = 0
	supplyCoolant = 0
	shipTemplateDistance = {	["MT52 Hornet"] =					100,
								["MU52 Hornet"] =					100,
								["Adder MK5"] =						100,
								["Adder MK4"] =						100,
								["Adder MK6"] =						100,
								["WX-Lindworm"] =					100,
								["Phobos T3"] =						200,
								["Phobos M3"] =						200,
								["Nirvana R5"] =					200,
								["Nirvana R5A"] =					200,
								["Storm"] =							200,
								["Piranha F12"] =					200,
								["Piranha F12.M"] =					200,
								["Piranha F8"] =					200,
								["Stalker Q7"] =					200,
								["Stalker R7"] =					200,
								["Ranus U"] =						200,
								["Flavia"] =						200,
								["Flavia Falcon"] =					200,
								["Tug"] =							200,
								["Fighter"] =						100,
								["Karnack"] =						200,
								["Cruiser"] =						200,
								["Missile Cruiser"] =				200,
								["Gunship"] =						400,
								["Adv. Gunship"] =					400,
								["Strikeship"] = 					200,
								["Adv. Striker"] = 					300,
								["Dreadnought"] =					400,
								["Battlestation"] =					2000,
								["Weapons platform"] =				200,
								["Blockade Runner"] =				400,
								["Ktlitan Fighter"] =				300,
								["Ktlitan Breaker"] =				300,
								["Ktlitan Worker"] =				300,
								["Ktlitan Drone"] =					300,
								["Ktlitan Feeder"] =				300,
								["Ktlitan Scout"] =					300,
								["Ktlitan Destroyer"] = 			500,
								["Ktlitan Queen"] =					500,
								["Transport1x1"] =					600,
								["Transport1x2"] =					600,
								["Transport1x3"] =					600,
								["Transport1x4"] =					800,
								["Transport1x5"] =					800,
								["Transport2x1"] =					600,
								["Transport2x2"] =					600,
								["Transport2x3"] =					600,
								["Transport2x4"] =					800,
								["Transport2x5"] =					800,
								["Transport3x1"] =					600,
								["Transport3x2"] =					600,
								["Transport3x3"] =					600,
								["Transport3x4"] =					800,
								["Transport3x5"] =					800,
								["Transport4x1"] =					600,
								["Transport4x2"] =					600,
								["Transport4x3"] =					600,
								["Transport4x4"] =					800,
								["Transport4x5"] =					800,
								["Transport5x1"] =					600,
								["Transport5x2"] =					600,
								["Transport5x3"] =					600,
								["Transport5x4"] =					800,
								["Transport5x5"] =					800,
								["Odin"] = 							1500,
								["Atlantis X23"] =					400,
								["Starhammer II"] =					400,
								["Defense platform"] =				800,
								["Personnel Freighter 1"] =			600,
								["Personnel Freighter 2"] =			600,
								["Personnel Freighter 3"] =			600,
								["Personnel Freighter 4"] =			800,
								["Personnel Freighter 5"] =			800,
								["Personnel Jump Freighter 3"] =	600,
								["Personnel Jump Freighter 4"] =	800,
								["Personnel Jump Freighter 5"] =	800,
								["Goods Freighter 1"] =				600,
								["Goods Freighter 2"] =				600,
								["Goods Freighter 3"] =				600,
								["Goods Freighter 4"] =				800,
								["Goods Freighter 5"] =				800,
								["Goods Jump Freighter 3"] =		600,
								["Goods Jump Freighter 4"] =		800,
								["Goods Jump Freighter 5"] =		800,
								["Garbage Freighter 1"] =			600,
								["Garbage Freighter 2"] =			600,
								["Garbage Freighter 3"] =			600,
								["Garbage Freighter 4"] =			800,
								["Garbage Freighter 5"] =			800,
								["Garbage Jump Freighter 3"] =		600,
								["Garbage Jump Freighter 4"] =		800,
								["Garbage Jump Freighter 5"] =		800,
								["Equipment Freighter 1"] =			600,
								["Equipment Freighter 2"] =			600,
								["Equipment Freighter 3"] =			600,
								["Equipment Freighter 4"] =			800,
								["Equipment Freighter 5"] =			800,
								["Equipment Jump Freighter 3"] =	600,
								["Equipment Jump Freighter 4"] =	800,
								["Equipment Jump Freighter 5"] =	800,
								["Fuel Freighter 1"] =				600,
								["Fuel Freighter 2"] =				600,
								["Fuel Freighter 3"] =				600,
								["Fuel Freighter 4"] =				800,
								["Fuel Freighter 5"] =				800,
								["Fuel Jump Freighter 3"] =			600,
								["Fuel Jump Freighter 4"] =			800,
								["Fuel Jump Freighter 5"] =			800,
								["Adder MK3"] =						100,
								["Adder MK7"] =						100,
								["Adder MK8"] =						100,
								["Adder MK9"] =						100,
								["Phobos R2"] =						200,
								["MV52 Hornet"] =					100,
								["Nirvana R3"] =					200,
								["Fiend G3"] =						400,
								["Fiend G4"] =						400,
								["Fiend G5"] =						400,
								["Fiend G6"] =						400,
								["K2 Fighter"] =					300,
								["K3 Fighter"] =					300,
								["Stalker Q5"] =					200,
								["Stalker R5"] =					200,
								["Jade 5"] =						100,
								["Waddle 5"] =						100,
								["Lite Drone"] = 					300,
								["Heavy Drone"] = 					300,
								["Jacket Drone"] =					300,
								["Elara P2"] =						200,
								["WZ-Lindworm"] =					100,
								["Tempest"] =						200,
								["Enforcer"] =						400,
								["Predator"] =						200,
								["Atlantis Y42"] =					400,
								["Starhammer V"] =					400,
								["Tyr"] =							2000,
								["Gnat"] =							300,
								["Jump Carrier"] =					800		}
	unscannedClues = {	["Energy Signature"] = "Energy signature",
						["Trace Elements"] = "Trace elements",
						["Warp Residue"] = "Warp residue",
						["STC Distortion"] = "Space time continuum distortion",
						["Jump Drive Ind"] = "Jump drive usage indicators",
						["Gas Anomaly"] = "Gaseous anomaly",
						["Chroniton Parts"] = "Chroniton particles",
						["Impulse Trail"] = "Impulse drive trail",
						["Ion Particles"] = "Ion particle trail",
						["Space Debris"] = "Space debris",
						["Energy Source"] = "Energy source",
						["Shielded Object"] = "Shielded object",
						["Unidentifiable Obj"] = "Unidentifiable object",
						["Container"] = "Container",
						["Sensor Reflect"] = "Sensor reflection" }
	unscannedClueKey = "Energy Signature"
	unscannedClueValue = unscannedClues[unscannedClueKey]
	scannedClues1 = {	["None"] = "None",
						["Kraylor"] = "Kraylor",
						["Independent"] = "Independent",
						["Ghosts"] = "Ghosts in the machine",
						["Arlenian"] = "Arlenian",
						["Human"] = "Human Navy",
						["Exuari"] = "Exuari",
						["Ktlitan"] = "Ktlitan",
						["Unknown"] = "Unknown",
						["Unusual"] = "Unusual",
						["Irregular"] = "Irregular",
						["Contains"] = "Contains",
						["Significant"] = "Significant" }
	scannedClueKey1 = "None"
	scannedClueValue1 = scannedClues1[scannedClueKey1]
	scannedClues2 = {	["None"] = "None",
						["Vessel"] = "Vessel",
						["Space Debris"] = "Space debris",
						["Ambassador"] = "Ambassador",
						["Pirate"] = "Pirate",
						["Delegate"] = "Delegate",
						["Officer"] = "Officer",
						["Spy"] = "Spy",
						["Agent"] = "Agent",
						["Scientist"] = "Scientist",
						["Miner"] = "Miner",
						["Adjunct"] = "Adjunct",
						["Minerals"] = "Minerals",
						["Components"] = "Components",
						["Contraband"] = "Contraband",
						["Food"] = "food",
						["medicine"] = "medicine",
						["luxury"] = "luxury",
						["gold"] = "gold",
						["platinum"] = "platinum",
						["dilithium"] = "dilithium",
						["tritanium"] = "tritanium",
						["nickel"] = "nickel",
						["cobalt"] = "cobalt",
						["impulse"] = "impulse",
						["warp"] = "warp",
						["shield"] = "shield",
						["tractor"] = "tractor",
						["repulsor"] = "repulsor",
						["beam"] = "beam",
						["optic"] = "optic",
						["robotic"] = "robotic",
						["filament"] = "filament",
						["transporter"] = "transporter",
						["sensor"] = "sensor",
						["communication"] = "communication",
						["autodoc"] = "autodoc",
						["lifter"] = "lifter",
						["android"] = "android",
						["nanites"] = "nanites",
						["software"] = "software",
						["circuit"] = "circuit",
						["battery"] = "battery",
						["amounts of"] = "amounts of" }
	scannedClueKey2 = "None"
	scannedClueValue2 = scannedClues2[scannedClueKey2]
	scannedClues3 = {	["None"] = "None",
						["Frigate"] = "Class Frigate",
						["Fighter"] = "Class Fighter",
						["Freighter"] = "Type Freighter",
						["Starhammer II"] = "Type Starhammer II",
						["Atlantis X23"] = "Type Atlantis X23",
						["Blockade Runner"] = "Type Blockade Runner",
						["Battlestation"] = "Type Battlestation",
						["Dreadnought"] = "Type Dreadnought",
						["Adv. Striker"] = "Type Advanced Striker",
						["Strikeship"] = "Type Strikeship",
						["Adv. Gunship"] = "Type Advanced Gunship",
						["Gunship"] = "Type Gunship",
						["Missile Cruiser"] = "Type Missile Cruiser",
						["Cruiser"] = "Type Cruiser",
						["Karnack"] = "Type Karnack",
						["Tug"] = "Type Tug",
						["Flavia Falcon"] = "Type Flavia Falcon",
						["Flavia"] = "Type Flavia",
						["Ranus U"] = "Type Ranus U",
						["Stalker R7"] = "Type Stalker R7",
						["Stalker Q7"] = "Type Stalker Q7",
						["Piranha"] = "Type Piranha",
						["Storm"] = "Type Storm",
						["Nirvana"] = "Type Nirvana",
						["Phobos"] = "Type Phobos",
						["Lindworm"] = "Type Lindworm",
						["Adder"] = "Type Adder",
						["Hornet"] = "Type Hornet",
						["Obsidian"] = "Of the Obsidian Order",
						["Council"] = "Of the High Council",
						["Kentar"] = "From Kentar",
						["Gold"] = "gold",
						["Platinum"] = "platinum",
						["Nickel"] = "nickel",
						["Dilithium"] = "dilithium",
						["Tritanium"] = "tritanium",
						["Cobalt"] = "cobalt"	}
	scannedClueKey3 = "None"
	scannedClueValue3 = scannedClues3[scannedClueKey3]
	scannedClues4 = {	["None"] = "None",
						["Was Here"] = "was here",
						["Destroyed"] = "was destroyed here",
						["Flew Thru"] = "flew through here",
						["Hid"] = "Hid here",
						["Chg course"] = "changed course here",
						["Disappeared"] = "disappeared here",
						["Lingered"] = "Lingered here",
						["Abducted"] = "was abducted here",
						["Detected"] = "detected",
						["Discovered"] = "discovered",
						["Observed"] = "observed"	}
	scannedClueKey4 = "None"
	scannedClueValue4 = scannedClues4[scannedClueKey4]
	scannedClues5 = {	["None"] = "None",
						["0"] = "Now heading ~0",
						["45"] = "Now heading ~45",
						["90"] = "Now heading ~90",
						["135"] = "Now heading ~135",
						["180"] = "Now heading ~180",
						["225"] = "Now heading ~225",
						["270"] = "Now heading ~270",
						["315"] = "Now heading ~315"	}
	scannedClueKey5 = "None"
	scannedClueValue5 = scannedClues5[scannedClueKey5]
	scan_clue_retrievable = false
	scan_clue_expire = true
	timer_display_helm = false
	timer_display_weapons = false
	timer_display_engineer = false
	timer_display_science = false
	timer_display_relay = true
	timer_start_length = 5
	timer_started = false
	timer_purpose = "Timer"
	timer_fudge = 0
	coolant_amount = 1
	jammer_range = 10000
	automated_station_danger_warning = true
	server_sensor = true
	station_sensor_range = 20000
	warning_includes_ship_type = true
	player_ship_log_message_color = "Magenta"
	color_list = {
		["Magenta"]		= "Magenta",
		["Yellow"]		= "Yellow",
		["Red"]			= "Red",
		["Blue"]		= "Blue",
		["Cyan"]		= "Cyan",
		["White"]		= "White",
		["Black"]		= "Black",
		["Green"]		= "Green",
		["186,85,211"]	= "Medium Orchid",
		["95,158,160"]	= "Cadet Blue",
		["55,55,55"]	= "Dark Gray",
		["255,69,0"]	= "Orange Red",
		["255,127,80"]	= "Coral",
		["65,105,225"]	= "Royal Blue",
		["160,82,45"]	= "Sienna",
		["85,107,47"]	= "Dark Olive Green",
		["34,139,34"]	= "Forest Green",
		["178,34,34"]	= "Firebrick Red",
	}
	jump_corridor = false
	station_defensive_fleet_speed_average = false
	inner_defense_platform_count = 3
	inner_defense_platform_orbit = "No"
	outer_defense_platform_count = 3
	outer_defense_platform_orbit = "No"
	orbit_increment = {
		["Orbit > Fast"] 	= 60,
		["Orbit > Normal"] 	= 120,
		["Orbit > Slow"]	= 600,
		["Orbit < Fast"]	= -60,
		["Orbit < Normal"]	= -120,
		["Orbit < Slow"]	= -600,
	} 
	outer_mines = "No"
	inline_mines = 0
	inside_mines = 0
	outside_mines = 0
	inline_mine_gap_count = 3
	inside_mine_gap_count = 3
	outside_mine_gap_count = 3
	inside_mine_orbit = "No"
	outside_mine_orbit = "No"
	mine_shape = "Arc"
	mine_width = 1
	mine_radius = 3
	zone_rectangle_width = 5
	zone_rectangle_height = 5
	zone_click_type = "rectangle"
	zone_point_count = 0
	zone_point_max = 3
	zone_color = "Red"
	zone_color_list = {
		["Red"]					= {r = 255, g =   0, b =   0},
		["Green"]				= {r =   0, g = 255, b =   0},
		["Blue"]				= {r =   0, g =   0, b = 255},
		["Medium Orchid"]		= {r = 186, g =  85, b = 211},
		["Cadet Blue"]			= {r =  95, g = 158, b = 160},
		["Dark Gray"]			= {r =  55, g =  55, b =  55},
		["Orange Red"]			= {r = 255, g =  69, b =   0},
		["Coral"]				= {r = 255, g = 127, b =  80},
		["Royal Blue"]			= {r =  65, g = 105, b = 255},
		["Sienna"]				= {r = 160, g =  82, b =  45},
		["Dark Olive Greeen"]	= {r =  85, g = 107, b =  47},
		["Forest Green"]		= {r =  34, g = 139, b =  34},
		["Firebrick Red"]		= {r = 178, g =  34, b =  34},
	}
	friendlyDefensiveFleetList = {}
	friendly_defensive_fleet_val = 65
	tractor_beam_string = {
		"beam_blue.png",
		"shield_hit_effect.png",
		"electric_sphere_texture.png"
	}
	tractor_drain = .000005
	mining_beam_string = {
		"beam_orange.png",
		"beam_yellow.png",
		"fire_sphere_texture.png"
	}
	mining_drain = .00025
	gm_names = {
		"Administrative Assistant",
		"General Manager",
		"Finnicky Flunky",
		"Vericose Veined VIP",
		"Operator",
		"Tempermental Technician",
	}
	gm_verbs = {
		"Contact",
		"Talk to",
		"Direct Message",
	}
end
function updateSystem()
	return {
		-- treat _update_objects as private to updateSystem
		-- my lack of lua knowledge is showing here
		-- _update_objects is an array, which probably is probably non optimal
		-- in particular random removal and checking if an item is within are slow
		-- this was not a issue with the few thousand entries tested with, but may need revisiting if performance issue surface
		_update_objects={},
		-- update should be called each time the main update is called
		-- it will run all updates on all objects
		-- it will also handle the case that objects are deleted
		-- TODO it should have a way to say "remove this update", but currently doesn't
		update = function(self,delta)
			assert(type(self)=="table")
			assert(type(delta)=="number")
			-- we iterate through the _update_objects in reverse order so removed entries don't result in skipped updates
			for index = #self._update_objects,1,-1 do
				if self._update_objects[index]:isValid() then
					local obj=self._update_objects[index]
					for index = #obj.update_list,1,-1 do
						obj.update_list[index]:update(obj,delta)
					end
				else
					table.remove(self._update_objects,index)
				end
			end
		end,
		-- mostly to assist in testing
		-- while it could easily be done inline it hopefully will make it easier to change data structures if needed
		_clear_update_list = function(self)
			assert(type(self)=="table")
			self._update_objects = {}
		end,
		-- treat _addToUpdateList as private to updateSystem
		-- this adds a object to the update list, while ensuring it isn't duplicated
		_addToUpdateList = function(self,obj)
			assert(type(self)=="table")
			assert(type(obj)=="table")
			for index = 0,#self._update_objects do
				assert(type(self)=="table")
				if self._update_objects[index]==obj then
					return
				end
			end
			table.insert(self._update_objects,obj)
		end,
		-- treat _eraseUpdateType as private
		-- remove updates of update_type
		_eraseUpdateType = function(obj,update_type)
			assert(type(obj)=="table")
			assert(type(update_type)=="string")
			if obj.update_list == nil then
				return
			end
			for index = #obj.update_list,1,-1 do
				if obj.update_list[index].type==update_type then
					table.remove(obj.update_list,index)
				end
			end
		end,
		-- this really wants to be merged into _eraseUpdateType
		-- however at this time they are used differently so its hard
		-- _eraseUpdateType removes a type, this removes a particular update
		-- types probably need work/thought sooner rather than later
		-- but the names probably can stay stable (at least after the periodic functions are fixed)
		-- thus this should work for a public facing function, _eraseUpdateType should be private
		removeUpdateNamed = function(self,obj,name)
			assert(type(self)=="table")
			assert(type(obj)=="table")
			assert(type(name)=="string")
			if obj.update_list ~= nil then
				for index = 1,#obj.update_list do
					assert(type(obj.update_list[index].name)=="string")
					if obj.update_list[index].name==name then
						table.remove(obj.update_list,index)
					end
				end
			end
		end,
		removeThisUpdate = function(self,obj,update)
			assert(type(self)=="table")
			assert(type(obj)=="table")
			assert(type(update)=="table")
			if obj.update_list ~= nil then
				for index = 1,#obj.update_list do
					if obj.update_list[index]==update then
						table.remove(obj.update_list,index)
						return
					end
				end
			end
		end,
		getUpdateNamed = function(self,obj,name)
			assert(type(self)=="table")
			assert(type(obj)=="table")
			assert(type(name)=="string")
			if obj.update_list ~= nil then
				for index = 1,#obj.update_list do
					if obj.update_list[index].name==name then
						return obj.update_list[index]
					end
				end
			end
			return nil
		end,
		-- there is only one update function of each update_type
		-- it is intended that the update_types are picked such that incompatible types aren't merged
		-- the obvious example is multiple functions setting a object x & y location
		-- update_type is a string which makes multiple incompatibles impossible to express
		-- in an ideal world that would be fixed, however as of writing this it sounds manageable  to do without
		-- update_data is a table with at a minimum a function called update which takes 3 arguments
		-- argument 1 - self (the table)
		-- argument 2 - delta - delta (as passed from the main update function)
		-- argument 3 - obj - the object being updated
		-- it is expected that data needed needed for the update function will be stored in the obj or the update_data table
		addUpdate = function(self,obj,update_type,update_data)
			assert(type(obj)=="table")
			assert(type(update_type)=="string")
			assert(type(update_data)=="table")
			assert(type(update_data.name)=="string")
			assert(type(update_data.update)=="function")
			self._eraseUpdateType(obj,update_type)
			if obj.update_list == nil then
				obj.update_list = {}
			end
			update_data.type=update_type
			table.insert(obj.update_list,update_data)
			self:_addToUpdateList(obj)
		end,
		getUpdateNamesOnObject = function(self, obj)
			assert(type(self)=="table")
			assert(type(obj)=="table")
			if obj.update_list == nil then
				return {}
			end
			local ret={}
			for index = 1,#obj.update_list do
				local update_name=obj.update_list[index].name
				assert(type(update_name)=="string")
				local edit={}
				for index2 = 1,#obj.update_list[index].edit do
					local name=obj.update_list[index].edit[index2].name
					local array_index=obj.update_list[index].edit[index2].index
					local fixedAdjAmount=obj.update_list[index].edit[index2].fixedAdjAmount
					assert(type(name)=="string")
					local display_name=name
					assert(array_index==nil or type(array_index)=="number")
					if array_index ~= nil then
						display_name = display_name .. "[" .. array_index .. "]"
					end
					table.insert(edit,{
						getter = function ()
							-- note the time that this is executed the number of updates and their order may of changed
							-- as such we have to fetch them from scratch
							-- this probably could use being tested better, ideally added into the testing code
							local ret=self:getUpdateNamed(obj,update_name)[name]
							if array_index ~= nil then
								ret=ret[array_index]
							end
							assert(type(ret)=="number")
							return ret
						end,
						setter = function (val)
							if array_index == nil then
								self:getUpdateNamed(obj,update_name)[name]=val
							else
								self:getUpdateNamed(obj,update_name)[name][array_index]=val
							end
						end,
						fixedAdjAmount=fixedAdjAmount,
						name=display_name
					})
				end
				table.insert(ret,{
					name=update_name,
					edit=edit
				})
			end
			return ret
		end,
		 -- addShieldDecayCurve and addEnergyDecayCurve are mostly the same, they probably should be merged in some way
		addEnergyDecayCurve = function (self, obj, total_time, curve_x, curve_y)
			assert(type(self)=="table")
			assert(type(obj)=="table")
			assert(type(total_time)=="number")
			assert(type(curve_x)=="table")
			assert(#curve_x==4)
			assert(type(curve_x[1])=="number")
			assert(type(curve_x[2])=="number")
			assert(type(curve_x[3])=="number")
			assert(type(curve_x[4])=="number")
			assert(type(curve_y)=="table")
			assert(#curve_y==4)
			assert(type(curve_y[1])=="number")
			assert(type(curve_y[2])=="number")
			assert(type(curve_y[3])=="number")
			assert(type(curve_y[4])=="number")
			local update_data = {
				name = "energy decay",
				total_time = total_time,
				curve_x = curve_x,
				curve_y = curve_y,
				elapsed_time = 0,
				edit = {
					{name = "total_time", fixedAdjAmount=1},
					{name = "elapsed_time", fixedAdjAmount=60},
					{name = "curve_x", index = 1, fixedAdjAmount=0.01},
					{name = "curve_x", index = 2, fixedAdjAmount=0.01},
					{name = "curve_x", index = 3, fixedAdjAmount=0.01},
					{name = "curve_x", index = 4, fixedAdjAmount=0.01},
					{name = "curve_y", index = 1, fixedAdjAmount=0.01},
					{name = "curve_y", index = 2, fixedAdjAmount=0.01},
					{name = "curve_y", index = 3, fixedAdjAmount=0.01},
					{name = "curve_y", index = 4, fixedAdjAmount=0.01}
				},
				update = function (self, obj, delta)
					self.elapsed_time = self.elapsed_time + delta
					local time_ratio = math.clamp(0,1,self.elapsed_time / self.total_time)
					local curve={-- bah this is bad but until the update edit is better its needed
						{x = self.curve_x[1], y = self.curve_y[1]},
						{x = self.curve_x[2], y = self.curve_y[2]},
						{x = self.curve_x[3], y = self.curve_y[3]},
						{x = self.curve_x[4], y = self.curve_y[4]}
					}
					local energy_drain_per_second=math.CosineInterpolateTable(curve,time_ratio)
					local new_energy=obj:getEnergy()+energy_drain_per_second*delta
					obj:setEnergy(math.clamp(0,obj:getMaxEnergy(),new_energy))
				end
			}
			self:addUpdate(obj,"energy decay",update_data)
		end,
		addShieldDecayCurve = function (self, obj, total_time, curve_x, curve_y)
			assert(type(self)=="table")
			assert(type(obj)=="table")
			assert(type(total_time)=="number")
			assert(type(curve_x)=="table")
			assert(#curve_x==4)
			assert(type(curve_x[1])=="number")
			assert(type(curve_x[2])=="number")
			assert(type(curve_x[3])=="number")
			assert(type(curve_x[4])=="number")
			assert(type(curve_y)=="table")
			assert(#curve_y==4)
			assert(type(curve_y[1])=="number")
			assert(type(curve_y[2])=="number")
			assert(type(curve_y[3])=="number")
			assert(type(curve_y[4])=="number")
			local update_data = {
				name = "shield decay",
				total_time = total_time,
				curve_x = curve_x,
				curve_y = curve_y,
				elapsed_time = 0,
				edit = {
					{name = "total_time", fixedAdjAmount=1},
					{name = "elapsed_time", fixedAdjAmount=60},
					{name = "curve_x", index = 1, fixedAdjAmount=0.01},
					{name = "curve_x", index = 2, fixedAdjAmount=0.01},
					{name = "curve_x", index = 3, fixedAdjAmount=0.01},
					{name = "curve_x", index = 4, fixedAdjAmount=0.01},
					{name = "curve_y", index = 1, fixedAdjAmount=0.01},
					{name = "curve_y", index = 2, fixedAdjAmount=0.01},
					{name = "curve_y", index = 3, fixedAdjAmount=0.01},
					{name = "curve_y", index = 4, fixedAdjAmount=0.01}
				},
				update = function (self, obj, delta)
					self.elapsed_time = self.elapsed_time + delta
					local time_ratio = math.clamp(0,1,self.elapsed_time / self.total_time)
					local curve={-- bah this is bad but until the update edit is better its needed
						{x = self.curve_x[1], y = self.curve_y[1]},
						{x = self.curve_x[2], y = self.curve_y[2]},
						{x = self.curve_x[3], y = self.curve_y[3]},
						{x = self.curve_x[4], y = self.curve_y[4]}
					}
					local maxShieldRatio=math.CosineInterpolateTable(curve,time_ratio)
					local shields = {}
					for i=0,obj:getShieldCount()-1 do
						table.insert(shields,math.min((obj:getShieldMax(i)*maxShieldRatio),obj:getShieldLevel(i)))
					end
					obj:setShields(table.unpack(shields))
				end
			}
			self:addUpdate(obj,"shield decay",update_data)
		end,
		_addGenericOverclock = function (self, obj, overboosted_time, boost_time, overclock_name, data_mirror ,add_extra_update_data, inner_update)
			assert(type(self)=="table")
			assert(type(obj)=="table")
			assert(type(overboosted_time)=="number")
			assert(type(boost_time)=="number")
			assert(type(overclock_name)=="string")
			assert(type(data_mirror)=="function")
			assert(type(inner_update)=="function")
			assert(type(add_extra_update_data)=="function")
			local update_self = self
			local update_data = {
				name = overclock_name,
				boost_time = boost_time,
				overboosted_time = overboosted_time,

				time = overboosted_time + boost_time,
				mirrored_data = data_mirror(self,obj),
				edit = {
					{name = "boost_time", fixedAdjAmount=1},
					{name = "overboosted_time", fixedAdjAmount=1},
					{name = "time", fixedAdjAmount=1}
					-- mirrored data would be nice to export but not realistic
					-- refresh would be nice as an exported button
				},
				refresh = function (self)
					assert(type(self)=="table")
					self.time = self.overboosted_time + self.boost_time
				end,
				update = function (self, obj, delta)
					assert(type(self)=="table")
					assert(type(obj)=="table")
					assert(type(delta)=="number")
					self.time = self.time - delta
					local scale = math.clamp(self.time/self.boost_time,0,1)
					inner_update(self, obj, scale)
					-- if scale == 0 inner_update has already been called with 0, resulting in overclocks being turned off
					if scale == 0 then
						update_self:removeThisUpdate(obj,self)
					end
				end,
			}
			add_extra_update_data(self,obj,update_data)
			self:addUpdate(obj,overclock_name,update_data)
		end,
		-- note calling this on a object that already has a boost enabled will probably not work as expected
		-- as it will pull the beam range/cycle time off of the boosted values rather than the default
		-- this should be fixed at some time
		addBeamBoostOverclock = function (self, obj, overboosted_time, boost_time, max_range_boosted, max_cycle_boosted)
			assert(type(self)=="table")
			assert(type(obj)=="table")
			assert(type(overboosted_time)=="number")
			assert(type(boost_time)=="number")
			assert(type(max_range_boosted)=="number")
			assert(type(max_cycle_boosted)=="number")

			self:_addGenericOverclock(obj,overboosted_time, boost_time,"beam overclock",
				-- 16 seems to be the max number of beams (seen via tweak menu)
				-- if the engine exports max number of beams it should be used rather than mirror all data
				function (self, obj)
					local mirrored_data={}
					for index=0,16 do
						table.insert(mirrored_data,
						{
							range = obj:getBeamWeaponRange(index),
							cycle_time = obj:getBeamWeaponCycleTime(index)
						})
					end
					return mirrored_data
				end,
				function (self, obj, update)
					update.max_range_boosted = max_range_boosted
					update.max_cycle_boosted = max_cycle_boosted
					table.insert(update.edit,{name = "max_range_boosted", fixedAdjAmount=0.1})
					table.insert(update.edit,{name = "max cycle_damage_boosted", fixedAdjAmount=0.1})
				end,
				function (self, obj, scale)
					assert(type(self)=="table")
					assert(type(obj)=="table")
					assert(type(scale)=="number")
						-- 16 seems to be the max number of beams (seen via tweak menu)
						-- if the engine exports max number of beams it should be used rather than mirror all data
					for index=0,16 do
						local beam_range = math.lerp(1,self.max_range_boosted,scale)*self.mirrored_data[index+1].range
						compatSetBeamWeaponRange(obj,index,beam_range)
						local beam_cycle = math.lerp(1,self.max_cycle_boosted,scale)*self.mirrored_data[index+1].cycle_time
						compatSetBeamWeaponCycleTime(obj,index,beam_cycle)
					end
				end
			)
		end,
		addEngineBoostUpdate = function (self, obj, overboosted_time, boost_time, max_impulse_boosted, max_turn_boosted)
			assert(type(self)=="table")
			assert(type(obj)=="table")
			assert(type(overboosted_time)=="number")
			assert(type(boost_time)=="number")
			assert(type(max_impulse_boosted)=="number")
			assert(type(max_turn_boosted)=="number")
			self:_addGenericOverclock(obj,overboosted_time, boost_time,"engine overclock",
				function (self, obj)
					return {
						impulse = obj:getImpulseMaxSpeed(index),
						turn_rate = obj:getRotationMaxSpeed(index)
					}
				end,
				function (self, obj, update)
					update.max_impulse_boosted = max_impulse_boosted
					update.max_turn_boosted = max_turn_boosted
					table.insert(update.edit,{name = "max_impulse_boosted", fixedAdjAmount=0.1})
					table.insert(update.edit,{name = "max max_turn_boosted", fixedAdjAmount=0.1})
				end,
				function (self, obj, scale)
					assert(type(self)=="table")
					assert(type(obj)=="table")
					assert(type(scale)=="number")
					obj:setImpulseMaxSpeed(math.lerp(1,self.max_impulse_boosted,scale)*self.mirrored_data.impulse)
					obj:setRotationMaxSpeed(math.lerp(1,self.max_turn_boosted,scale)*self.mirrored_data.turn_rate)
				end
			)
		end,
		-- this is horrifically specialized and I don't think there is any way around that
		addOverclockableTractor = function (self, obj, spawnFunc)
			assert(type(self)=="table")
			assert(type(obj)=="table")
			assert(type(spawnFunc)=="function")
			local update_self=self
			local max_dist=1500
			self:_addGenericOverclock(obj,5, 30, "overclockable tractor",
				function (self, obj)end,
				function (self, obj, update)
					assert(type(self)=="table")
					assert(type(obj)=="table")
					assert(type(update)=="table")
					update.orbitingObj= {}
					for i=1,12 do
						local spawned = spawnFunc()
						self:addOrbitTargetUpdate(spawned,obj, max_dist, 30, i*30)
						table.insert(update.orbitingObj,spawned)
					end
				end,
				function (self, obj, scale)
					assert(type(self)=="table")
					assert(type(obj)=="table")
					assert(type(scale)=="number")
					for i=#self.orbitingObj,1,-1 do
						local orbiting=self.orbitingObj[i]
						if orbiting:isValid() then
							local orbiting_update=update_self:getUpdateNamed(orbiting,"orbit target")
							if orbiting_update ~= nil then
								orbiting_update.distance=math.lerp(0,max_dist,scale)
							end
						else
							table.remove(self.orbitingObj,i)
						end
					end
				end
			)
		end,
		_addGenericOverclocker = function (self, obj, period, updateName, addUpdate, updateRange, filterFun)
			assert(type(self)=="table")
			assert(type(obj)=="table")
			assert(type(period)=="number")
			assert(type(updateName)=="string")
			assert(type(addUpdate)=="function")
			assert(type(updateRange)=="number")
			assert(filterFun==nil or type(filterFun)=="function")
			local callback = function(obj)
				assert(type(obj)=="table")
				local x,y=obj:getPosition()
				local objs=getObjectsInRadius(x,y,updateRange)
				-- filter to spaceShips that are our faction
				for index=#objs,1,-1 do
					if objs[index].typeName == "CpuShip" and objs[index]:getFaction() == obj:getFaction() and obj ~= objs[index] then
						if filterFun == nil or filterFun(objs[index]) then
							local art=Artifact():setPosition(x,y):setDescription("encrypted data")
							local callback=function (self, obj, target)
								assert(type(self)=="table")
								assert(type(obj)=="table")
								assert(type(target)=="table")
								local update = self:getUpdateNamed(target,updateName)
								if update == nil then
									addUpdate(target)
								else
									update:refresh()
								end
							end
							self:addChasingUpdate(art,objs[index],1000,callback)
						end
					end
				end
			end
			self:addPeriodicCallback(obj,callback,period)
		end,
		addBeamOverclocker = function (self, obj, period)
			assert(type(self)=="table")
			assert(type(obj)=="table")
			assert(type(period)=="number")
			local addUpdate = function (target)
				assert(type(target)=="table")
				self:addBeamBoostOverclock(target, 5, 10, 2, 0.75)
			end
			self:_addGenericOverclocker(obj, period, "beam overclock", addUpdate, 5000)
		end,
		addShieldOverclocker = function (self, obj, period)
			assert(type(self)=="table")
			assert(type(obj)=="table")
			assert(type(period)=="number")
			local addUpdate = function (target)
				assert(type(target)=="table")
				local shields = {}
				for i=0,target:getShieldCount()-1 do
					table.insert(shields,math.min(target:getShieldMax(i),target:getShieldLevel(i)+10))
				end
				target:setShields(table.unpack(shields))
			end
			self:_addGenericOverclocker(obj, period, "shield overclock", addUpdate, 5000)
		end,
		addEngineOverclocker = function (self, obj, period)
			assert(type(self)=="table")
			assert(type(obj)=="table")
			assert(type(period)=="number")
			local addUpdate = function (target)
				assert(type(target)=="table")
				self:addEngineBoostUpdate(target, 5, 10, 2, 2)
			end
			self:_addGenericOverclocker(obj, period, "engine overclock", addUpdate, 5000)
		end,
		addOrbitingOverclocker = function (self, obj, period)
			assert(type(self)=="table")
			assert(type(obj)=="table")
			assert(type(period)=="number")
			local addUpdate = function (target) end -- we are not adding updates, only refreshing existing ones
			local filterFun = function (possibleTarget)
				return self:getUpdateNamed(possibleTarget,"overclockable tractor") ~= nil
			end
			self:_addGenericOverclocker(obj, period, "overclockable tractor", addUpdate, 10000, filterFun)
		end,
		addOverclockOptimizer = function (self, obj, period)
			assert(type(self)=="table")
			assert(type(obj)=="table")
			assert(type(period)=="number")
			local callback = function (obj)
				assert(type(obj)=="table")
				local objs = getAllObjects()
				for index = #objs,1,-1 do
					if objs[index].typeName == "CpuShip" and objs[index]:getFaction() == obj:getFaction() and obj ~= objs[index] then
						-- this is mostly wrong, we really want to check if an overclocker
						-- callback was in the update function, however this is not exposed
						-- currently it is almost always correct to say if there is a periodic callback
						-- then it is an overclocker ship, this is possible to ensure via being aware of
						-- this fact and GMing around it, this is however sub optimal
						if self:getUpdateNamed(objs[index],"periodic callback") ~= nil then
							local x,y=obj:getPosition()
							local art=Artifact():setPosition(x,y)
							self:addChasingUpdate(art,objs[index],2000)
						end
					end
				end
			end
			self:addPeriodicCallback(obj,callback,period)
		end,
		addOrbitUpdate = function(self, obj, center_x, center_y, distance, orbit_time, initial_angle)
			assert(type(self)=="table")
			assert(type(obj)=="table")
			assert(type(center_x)=="number")
			assert(type(center_y)=="number")
			assert(type(distance)=="number")
			assert(type(orbit_time)=="number")
			assert(type(initial_angle)=="number" or initial_angle == nil)
			initial_angle = initial_angle or 0
			local update_data = {
				name = "orbit",
				center_x = center_x,
				center_y = center_y,
				distance = distance,
				orbit_time = orbit_time/(2*math.pi),
				initial_angle = initial_angle, -- this looks obsolete, test removal with proper testing
				start_offset = (initial_angle/360)*orbit_time,
				time = 0, -- this can be removed after getScenarioTime gets into the current version of EE
				edit = {
					-- center x and y should be added when it can be - it probably wants an onclick handler
					{name = "distance" , fixedAdjAmount=1000},
					{name = "orbit_time", fixedAdjAmount=1},
					{name = "start_offset", fixedAdjAmount=1}
				},
				update = function (self,obj,delta)
					assert(type(self)=="table")
					assert(type(obj)=="table")
					assert(type(delta)=="number")
					self.time = self.time + delta
					local orbit_pos=(self.time+self.start_offset)/self.orbit_time
					obj:setPosition(self.center_x+(math.cos(orbit_pos)*self.distance),self.center_y+(math.sin(orbit_pos)*self.distance))
				end
			}
			self:addUpdate(obj,"absolutePosition",update_data)
		end,
		addAttachedUpdate = function(self, obj, attach_target, relative_attach_x, relative_attach_y)
			assert(type(self)=="table")
			assert(type(obj)=="table")
			assert(type(attach_target)=="table")
			assert(type(relative_attach_x)=="number")
			assert(type(relative_attach_y)=="number")
			local update_data = {
				name = "attached",
				attach_target = attach_target,
				relative_attach_x = relative_attach_x,
				relative_attach_y = relative_attach_y,
				update = function (self,obj)
					assert(type(self)=="table")
					assert(type(obj)=="table")
					if self.attach_target ~= nil and self.attach_target:isValid() then
						local attach_x, attach_y = self.attach_target:getPosition()
						obj:setPosition(attach_x+self.relative_attach_x,attach_y+self.relative_attach_y)
					else
						self:removeUpdateNamed(obj,"attached")
					end
				end
			}
			self:addUpdate(obj,"absolutePosition",update_data)
		end,
		addChasingUpdate = function (self, obj, target, speed, callback_on_contact)
			assert(type(self)=="table")
			assert(type(obj)=="table")
			assert(type(target)=="table")
			assert(type(speed)=="number")
			assert(callback_on_contact==nil or type(callback_on_contact)=="function")
			local update_self = self -- this is so it can be captured for later
			local update_data = {
				name = "chasing",
				speed = speed,
				target = target,
				callback_on_contact = callback_on_contact,
				edit = {
					-- todo add target
					{name = "speed", fixedAdjAmount = 100}
				},
				update = function (self, obj, delta)
					assert(type(self)=="table")
					assert(type(obj)=="table")
					assert(type(delta)=="number")
					if target==nil or not target:isValid() then
						obj:destroy()
					else
						local update_speed=speed*delta
						local my_x, my_y = obj:getPosition()
						local target_x, target_y = target:getPosition()
						local dist=distance(my_x, my_y, target_x, target_y)
						if dist > update_speed then
							local dx=target_x-my_x
							local dy=target_y-my_y
							local angle=math.atan2(dx,dy)
							local ny=math.cos(angle)*update_speed
							local nx=math.sin(angle)*update_speed
							obj:setPosition(my_x+nx,my_y+ny)
						else
							if self.callback_on_contact ~= nil then
								self.callback_on_contact(update_self, obj, target)
							end
							obj:destroy()
						end
					end
				end
			}
			self:addUpdate(obj,"absolutePosition",update_data)
		end,
		addOrbitTargetUpdate = function (self, obj, orbit_target, distance, orbit_time, initial_angle)
			assert(type(self)=="table")
			assert(type(obj)=="table")
			assert(type(orbit_target)=="table")
			assert(type(distance)=="number")
			assert(type(orbit_time)=="number")
			assert(type(initial_angle)=="number" or initial_angle == nil)
			initial_angle = initial_angle or 0
			local update_data = {
				name = "orbit target",
				orbit_target = orbit_target,
				distance = distance,
				orbit_time = orbit_time/(2*math.pi),
				initial_angle = initial_angle, -- this looks obsolete, test removal with proper testing
				start_offset = (initial_angle/360)*orbit_time,
				time = 0, -- this can be removed after getScenarioTime gets into the current version of EE
				edit = {
					-- orbit target wants to be exposed when we have a object selection control
					{name = "distance" , fixedAdjAmount=1000},
					{name = "orbit_time", fixedAdjAmount=1},
					{name = "start_offset", fixedAdjAmount=1}
				},
				update = function (self,obj,delta)
					assert(type(self)=="table")
					assert(type(obj)=="table")
					assert(type(delta)=="number")
					self.time = self.time + delta
					local orbit_pos=(self.time+self.start_offset)/self.orbit_time
					if self.orbit_target ~= nil and self.orbit_target:isValid() then
						local orbit_target_x, orbit_target_y = self.orbit_target:getPosition()
						obj:setPosition(orbit_target_x+(math.cos(orbit_pos)*self.distance),orbit_target_y+(math.sin(orbit_pos)*self.distance))
					end
				end
			}
			self:addUpdate(obj,"absolutePosition",update_data)
		end,
		addPatrol = function (self, obj, patrol_points, patrol_point_index, patrol_check_timer_interval)
			assert(type(self)=="table")
			assert(type(obj)=="table")
			assert(type(patrol_points)=="table")
			assert(type(patrol_point_index)=="number")
			assert(type(patrol_check_timer_interval)=="number")
			local update_self = self
			obj.patrol_points = patrol_points
			obj.patrol_point_index = patrol_point_index
			obj.patrol_check_timer_interval = patrol_check_timer_interval
			obj.patrol_check_timer = patrol_check_timer_interval
			local update_data = {
				name = "patrol",
				update = function (self, obj, delta)
					assert(type(self)=="table")
					assert(type(obj)=="table")
					assert(type(delta)=="number")
					if obj.patrol_points == nil then
						obj.patrol_point_index = nil
						obj.patrol_check_timer_interval = nil
						obj.patrol_check_timer = nil
						update_self:removeThisUpdate(obj,self)
					else
						obj.patrol_check_timer = obj.patrol_check_timer - delta
						if obj.patrol_check_timer < 0 then
							if string.find(obj:getOrder(),"Defend") then
								obj.patrol_point_index = obj.patrol_point_index + 1
								if obj.patrol_point_index > #obj.patrol_points then
									obj.patrol_point_index = 1
								end
								obj:orderFlyTowards(obj.patrol_points[obj.patrol_point_index].x,obj.patrol_points[obj.patrol_point_index].y)
							end
							obj.patrol_check_timer = obj.patrol_check_timer_interval
						end
					end
				end
			}
			self:addUpdate(obj,"patrol",update_data)
		end,
		-- TODO - currently only one periodic function can be on a update object, this probably should be fixed
		-- the callback is called every period seconds, it can be called multiple times if delta is big or period is small
		-- it is undefined if called with an exact amount of delta == period as to if the callback is called that update or not
		addPeriodicCallback = function(self, obj, callback, period, accumulated_time)
			assert(type(self)=="table")
			assert(type(obj)=="table")
			assert(type(callback)=="function")
			assert(type(period)=="number")
			assert(accumulated_time==nil or type(accumulated_time)=="number")
			assert(period>0.0001) -- really just needs to be positive, but this is low enough to probably not be an issue
			local update_data = {
				name = "periodic callback", -- note this is kind of wrong, needs editing when multiple periodic callbacks are supported
				callback = callback,
				period = period,
				accumulated_time = accumulated_time or 0,
				edit = {
					-- orbit target wants to be exposed when we have a object selection control
					{name = "period" , fixedAdjAmount=1},
					{name = "accumulated_time", fixedAdjAmount=1}
				},
				update = function (self,obj,delta)
					assert(type(self)=="table")
					assert(type(obj)=="table")
					assert(type(delta)=="number")
					self.accumulated_time = self.accumulated_time + delta
					if self.accumulated_time > self.period then
						self.callback(obj)
						self.accumulated_time = self.accumulated_time - self.period
						-- we could do this via a loop
						-- or via calling back into this own function
						-- technically this is probably slower (as we will end up with calling a function and the assert logic)
						-- I am going to be surprised if that matters
						-- a callback is pretty easy to do, so we will do it that way
						self:update(obj,0)
					end
				end
			}
			self:addUpdate(obj,"periodic",update_data)
		end,
		addNameCycleUpdate = function(self, obj, period, nameTable, accumulated_time)
			assert(type(self)=="table")
			assert(type(obj)=="table")
			assert(type(period)=="number")
			assert(type(nameTable)=="table")
			assert(#nameTable~=0)
			assert(accumulated_time==nil or type(accumulated_time)=="number")
			obj.nameNum=0
			local callback = function(obj)
				obj.nameNum = (obj.nameNum + 1) % #nameTable
				obj:setCallSign(nameTable[obj.nameNum + 1])
			end
			self:addPeriodicCallback(obj,callback,period,accumulated_time)
		end,
		addTimeToLiveUpdate = function(self, obj, timeToLive)
			assert(type(self)=="table")
			assert(type(obj)=="table")
			assert(type(timeToLive)=="number" or TimeToLive==nil)
			timeToLive = timeToLive or 300
			local update_data = {
				name = "time to live",
				timeToLive = timeToLive,
				edit = {
					{name = "timeToLive", fixedAdjAmount=1}
				},
				update = function (self,obj,delta)
					assert(type(self)=="table")
					assert(type(obj)=="table")
					assert(type(delta)=="number")
					self.timeToLive = self.timeToLive - delta
					if self.timeToLive < 0 then
						obj:destroy()
					end
				end
			}
			self:addUpdate(obj,"timeToLive",update_data)
		end,
		_test = function(self)
			assert(type(self)=="table")
			---------------------------------------------------------------------------------------------------------------
			-- first up we are going to ensure that _addToUpdateList doesn't add the same element multiple times
			-- this likely would be annoying to debug (as things would run faster for no real reason) and hard to spot
			-- (as many of the ways it will fail would not result in errors)
			---------------------------------------------------------------------------------------------------------------
			local tmp1={}
			local tmp2={}
			-- starting
			assert(#self._update_objects==0)
			-- add the first element
			self:_addToUpdateList(tmp1)
			assert(#self._update_objects==1)
			-- ensure we cant add one more
			self:_addToUpdateList(tmp1)
			assert(#self._update_objects==1)
			-- add the second element
			self:_addToUpdateList(tmp2)
			assert(#self._update_objects==2)
			-- ensure both the first and last element are checked
			self:_addToUpdateList(tmp1)
			assert(#self._update_objects==2)
			self:_addToUpdateList(tmp2)
			assert(#self._update_objects==2)

			-- reset for next test
			self:_clear_update_list()
			assert(#self._update_objects==0)
			---------------------------------------------------------------------------------------------------------------
			-- now onto testing addUpdate
			-- we are going to ensure that multiple updates of the same type cant be added (as that will break in non obvious ways)
			-- note the testObj is not a spaceObject, which will break some functions like update
			-- if this blocks fails asserts later, it is possible that checks have been added to addUpdate to ensure that the object is a spaceObject
			---------------------------------------------------------------------------------------------------------------
			local testObj={}
			assert(testObj.update_list==nil)
			self:addUpdate(testObj,"test",{name="",update=function()end})
			assert(testObj.update_list~=nil)
			assert(#testObj.update_list==1)
			self:addUpdate(testObj,"test",{name="",update=function()end})
			assert(#testObj.update_list==1)
			self:addUpdate(testObj,"test2",{name="",update=function()end})
			assert(#testObj.update_list==2)
			self:addUpdate(testObj,"test",{name="",update=function()end})
			assert(#testObj.update_list==2)
			self:addUpdate(testObj,"test2",{name="",update=function()end})
			assert(#testObj.update_list==2)

			-- reset for next test
			self:_clear_update_list()
			assert(#self._update_objects==0)
			---------------------------------------------------------------------------------------------------------------
			-- addPeriodicCallback
			---------------------------------------------------------------------------------------------------------------
			-- phony spaceObject, probably needs to move to a testing library some day
			local testObj={
				isValid=function()
					return true
				end
			}
			local captured=0
			local captured_fun = function ()
				captured = captured + 1
			end
			self:addPeriodicCallback(testObj,captured_fun,1)
			assert(captured==0)
			-- insufficient to run the callback
			self:update(0.9)
			assert(captured==0)
			-- check that the callback being called once results in the callback running once
			self:update(1)
			assert(captured==1)
			-- check that the callback being overdue results in multiple calls
			self:update(2)
			assert(captured==3)
			-- TODO check with different periodic values
			--assert(captured==0)

			-- reset for next test
			self:_clear_update_list()
			assert(#self._update_objects==0)
		end
	}
end
function universe()
	return {
		-- each region has at least 1 function
		-- destroy(self) this destroys the sector
		active_regions = {},
		-- spawn a region already registered in the available_regions
		-- it is expected to be called like
		-- universe:spawnRegion(universe.available_regions[spawnIndex])
		-- rather than the region being built from scratch
		-- that allows addAvailableRegion to have validated the region rather than relying on outside validation
		spawnRegion = function (self,region)
			assert(type(self)=="table")
			assert(type(region)=="table")
			assert(type(region.name)=="string")
			assert(type(region.spawn)=="function")
			if region.name ~= "Icarus (F5)" then
				addGMMessage(region.name .. " created")
			end
			table.insert(self.active_regions,{name=region.name,region=region.spawn()})
		end,
		-- has the following region been spawned already
		-- expected use is like the spawnRegion above
		hasRegionSpawned = function (self,region)
			assert(type(self)=="table")
			assert(type(region)=="table")
			assert(type(region.name)=="string")
			for i = 1,#self.active_regions do
				if self.active_regions[i].name==region.name then
					return true
				end
			end
			return false
		end,
		-- remove the following region from the region
		-- expected use is much like spawnRegion above
		-- it is asserted that self:hasRegionSpawned(region)==true
		removeRegion = function (self,region)
			assert(type(self)=="table")
			assert(type(region)=="table")
			assert(type(region.name)=="string")
			addGMMessage(region.name .. " removed")
			for i = 1,#self.active_regions do
				if self.active_regions[i].name==region.name then
					self.active_regions[i].region:destroy()
					table.remove(self.active_regions,i)
					return
				end
			end
			-- if we reached this then we have been asked to remove an area that wasn't spawned
			-- this means the calling code is in error
			assert(false)
		end,
		-- add an available region to the internal list
		-- name is what will be shown to the gm
		-- spawn_function should create the region and return a table in the same form active_regions uses
		-- spawn_x and spawn_y are used for default location for new ships in this region (this is ensure outside of this class currently)
		addAvailableRegion = function (self, name, spawn_function, spawn_x, spawn_y)
			assert(type(self)=="table")
			assert(type(name)=="string")
			assert(type(spawn_function)=="function")
			assert(type(spawn_x)=="number")
			assert(type(spawn_y)=="number")
			table.insert(self.available_regions,{name=name,spawn=spawn_function,spawn_x=spawn_x,spawn_y=spawn_y})
		end,
		available_regions = {}
	}
end
--	*										   *  --
--	**										  **  --
--	********************************************  --
--	****			GM Buttons				****  --
--	********************************************  --
--	**										  **  --
--	*										   *  --
----------------------------
--  Main Menu of Buttons  --
----------------------------
-- 2nd column: F = Fixed text, D = Dynamic text, * = Fixed with asterisk indicating selection
-- Button Text		   FD*	Related Function(s)
-- +INITIAL SET UP		F	initialSetUp
-- +SPAWN SHIP(S)		F	spawnGMShips
-- +ORDER FLEET			F	orderFleet
-- +ORDER SHIP			F	orderShip
-- +DROP POINT			F	dropPoint
-- +SCAN CLUE			F	scanClue
-- +TWEAK TERRAIN		F	tweakTerrain
-- +COUNTDOWN TIMER		F	countdownTimer
-- +CUSTOM				F	customButtons
-- +END SESSION			F	endSession
function initialGMFunctions()
	clearGMFunctions()
	addGMFunction("+Initial Set Up",initialSetUp)
	addGMFunction("+Spawn Ship(s)",spawnGMShips)
	addGMFunction("+Order Fleet",orderFleet)
	addGMFunction("+Order Ship",orderShip)
	addGMFunction("+Drop Point",dropPoint)
	addGMFunction("+Scan Clue",scanClue)
	addGMFunction("+Tweak Terrain",tweakTerrain)
	addGMFunction("+Countdown Timer",countdownTimer)
	addGMFunction("+Custom",customButtons)
	addGMFunction("+End Session",endSession)
end
----------------------
--  Initial set up  --
----------------------
-- Button Text			   FD*	Related Function(s)
-- -MAIN FROM INITIAL		F	initialGMFunctions
-- +START REGION			F	setStartRegion
-- +PLAYER SHIPS 0/0		D	playerShip (inline calculation of values "current ships"/"total ships")
-- +WORMHOLES				F	setWormholes
-- +ZONES					F	changeZones
-- +WARN Y SHIP 30U S		D	autoStationWarn
function initialSetUp()
	clearGMFunctions()
	addGMFunction("-Main from Initial",initialGMFunctions)
	addGMFunction("+Start Region",setStartRegion)
	local playerShipCount = 0
	local highestPlayerIndex = 0
	for pidx=1,8 do
		local p = getPlayerShip(pidx)
		if p ~= nil then
			if p:isValid() then
				playerShipCount = playerShipCount + 1
			end
			highestPlayerIndex = pidx
		end
	end
	addGMFunction(string.format("+Player ships %i/%i",playerShipCount,highestPlayerIndex),playerShip)
	addGMFunction("+Wormholes",setWormholes)
	addGMFunction("+Zones",changeZones)
	local button_label = "+Warn"
	if automated_station_danger_warning then
		button_label = button_label .. " Y"
	else
		button_label = button_label .. " N"
	end
	if warning_includes_ship_type then
		button_label = button_label .. " Ship"
	else
		button_label = button_label .. " NoShip"
	end
	if server_sensor then
		button_label = string.format("%s %iU D",button_label,station_sensor_range/1000)
	else
		button_label = string.format("%s %iU",button_label,station_sensor_range/1000)
	end
	addGMFunction(button_label,autoStationWarn)
end
---------------------
--	Spawn Ship(s)  --
---------------------
-- Button Text			   FD*	Related Function(s)
-- -MAIN FROM SPAWN SHIPS	F	initialGMFunctions
-- +SPAWN FLEET				F	spawnGMFleet
-- +SPAWN A SHIP			F	spawnGMShip
function spawnGMShips()
	clearGMFunctions()
	addGMFunction("-Main From Spawn Ships",initialGMFunctions)
	addGMFunction("+Spawn Fleet",spawnGMFleet)
	addGMFunction("+Spawn a ship",spawnGMShip)
end
-------------------
--	Order fleet  --
-------------------
-- Button Text			   FD*	Related Function(s)
-- -MAIN FROM ORDER FLT		F	initialGMFunctions
-- +SELECT FLEET			D	selectOrderFleet
-- +REORGANIZE FLEET		F	orderFleetChange
-- +AVERAGE IMPULSE			F	averageImpulse
-- SET PLAYER FLEET			F	inline
--
-- after fleet selected
--
-- -MAIN FROM ORDER FLT		F	initialGMFunctions
-- +1 ship-in-fleet			D	selectOrderFleet
-- +ROAMING					D	changeFleetOrder
-- GIVE ORDER TO FLEET		F	inline
-- +REORGANIZE FLEET		F	orderFleetChange
-- +AVERAGE IMPULSE			F	averageImpulse
function orderFleet()
	clearGMFunctions()
	addGMFunction("-Main from Order Flt",initialGMFunctions)
	local select_fleet_label = "Select Fleet"
	if selected_fleet_representative ~= nil and selected_fleet_representative:isValid() then
		if selected_fleet_index ~= nil and fleetList[selected_fleet_index] ~= nil then
			local fl = fleetList[selected_fleet_index]
			if fl ~= nil then
				if selected_fleet_representative_index ~= nil then
					if selected_fleet_representative == fl[selected_fleet_representative_index] then
						select_fleet_label = string.format("%i %s",selected_fleet_index,selected_fleet_representative:getCallSign())
					end
				end
			end
		end
	end
	addGMFunction(string.format("+%s",select_fleet_label),selectOrderFleet)
	if select_fleet_label ~= "Select Fleet" then
		addGMFunction(string.format("+%s",existing_fleet_order),changeFleetOrder)
		addGMFunction("Give Order To Fleet",function()
			if existing_fleet_order == "Idle" then
				for _, fm in pairs(fleetList[selected_fleet_index]) do
					if fm ~= nil and fm:isValid() then
						fm:orderIdle()
					end
				end
				addGMMessage(string.format("Fleet %i which includes %s has been ordered to go idle",selected_fleet_index,selected_fleet_representative:getCallSign()))
			end
			if existing_fleet_order == "Roaming" then
				for _, fm in pairs(fleetList[selected_fleet_index]) do
					if fm ~= nil and fm:isValid() then
						fm:orderRoaming()
					end
				end	
				addGMMessage(string.format("Fleet %i which includes %s has been ordered to roam",selected_fleet_index,selected_fleet_representative:getCallSign()))
			end			
			if existing_fleet_order == "Stand Ground" then
				for _, fm in pairs(fleetList[selected_fleet_index]) do
					if fm ~= nil and fm:isValid() then
						fm:orderStandGround()
					end
				end	
			end			
			if existing_fleet_order == "Attack" then
				local objectList = getGMSelection()
				if #objectList ~= 1 then
					addGMMessage("Need to select a target for fleet to attack")
				else
					local fto = fleetList[selected_fleet_index]
					for _, fm in pairs(fto) do
						if fm ~= nil and fm:isValid() then
							fm:orderAttack(objectList[1])
						end
					end
					addGMMessage(string.format("Fleet %i which includes %s has been ordered to attack",selected_fleet_index,selected_fleet_representative:getCallSign()))		
				end
			end			
			if existing_fleet_order == "Defend" then
				local objectList = getGMSelection()
				if #objectList ~= 1 then
					addGMMessage("Need to select a target for fleet to defend")
				else
					local fto = fleetList[selected_fleet_index]
					for _, fm in pairs(fto) do
						if fm ~= nil and fm:isValid() then
							fm:orderDefendTarget(objectList[1])
						end
					end
					addGMMessage(string.format("Fleet %i which includes %s has been ordered to defend",selected_fleet_index,selected_fleet_representative:getCallSign()))
				end
			end			
			if existing_fleet_order == "Fly To" then
				local flyx = 0
				local flyy = 0
				local objectList = getGMSelection()
				if #objectList < 1 then
					addGMMessage("Need to select a target for fleet to fly to")
				else
					if #objectList == 1 then
						flyx, flyy = objectList[1]:getPosition()
					else
						flyx, flyy = centerOfSelected(objectList)
					end
					local fto = fleetList[selected_fleet_index]
					for _, fm in pairs(fto) do
						if fm ~= nil and fm:isValid() then
							fm:orderFlyTowards(flyx,flyy)
						end
					end
					addGMMessage(string.format("Fleet %i which includes %s has been ordered to fly towards %.1f, %.1f",selected_fleet_index,selected_fleet_representative:getCallSign(),flyx,flyy))
				end
			end			
			if existing_fleet_order == "Fly Blindly To" then
				local flyx = 0
				local flyy = 0
				local objectList = getGMSelection()
				if #objectList < 1 then
					addGMMessage("Need to select a target for fleet to fly blindly to")
				else
					if #objectList == 1 then
						flyx, flyy = objectList[1]:getPosition()
					else
						flyx, flyy = centerOfSelected(objectList)
					end
					local fto = fleetList[selected_fleet_index]
					for _, fm in pairs(fto) do
						if fm ~= nil and fm:isValid() then
							fm:orderFlyTowardsBlind(flyx,flyy)
						end
					end
					addGMMessage(string.format("Fleet %i which includes %s has been ordered to fly blindly towards %.1f, %.1f",selected_fleet_index,selected_fleet_representative:getCallSign(),flyx,flyy))
				end
			end
			if existing_fleet_order == "Dock" then
				local objectList = getGMSelection()
				if #objectList ~= 1 then
					addGMMessage("Need to select a target for fleet to dock")
				else
					local fto = fleetList[selected_fleet_index]
					for _, fm in pairs(fto) do
						if fm ~= nil and fm:isValid() then
							fm:orderDock(objectList[1])
						end
					end
					addGMMessage(string.format("Fleet %i which includes %s has been ordered to dock",selected_fleet_index,selected_fleet_representative:getCallSign()))
				end
			end
			if existing_fleet_order == "Fly Formation" then
				if formation_lead == nil then
					addGMMessage("choose a formation lead. no action taken")
					return
				end
				local fto = fleetList[selected_fleet_index]
				local found_formation_lead = false
				for _, fm in pairs(fto) do
					if fm == formation_lead then
						found_formation_lead = true
					end
				end
				if found_formation_lead then
					--Note: Formation only works when I force them all to be facing 0
					--      Unsuccessful at generalization to any angle. May try again later
					local formation_heading = 0
					formation_lead:setHeading(formation_heading)
					local formation_rotation = -90
					formation_lead:setRotation(formation_rotation)
					local fx, fy = formation_lead:getPosition()
					local formation_spacing_increment = 1000
					local formation_spacing = 0
					local position_index = 1
					if formation_type == "V" then
						local first_v_leg_place = formation_rotation + 120
						local first_v_leg_fly = formation_heading + 120
						if first_v_leg_place > 360 then
							first_v_leg_place = first_v_leg_place - 360
						end
						if first_v_leg_fly > 360 then
							first_v_leg_fly = first_v_leg_fly - 360
						end
						local second_v_leg_place = formation_rotation + 240
						local second_v_leg_fly = formation_heading + 240
						if second_v_leg_place > 360 then
							second_v_leg_place = second_v_leg_place - 360
						end
						if second_v_leg_fly > 360 then
							second_v_leg_fly = second_v_leg_fly - 360
						end
						--print("formation_heading: " .. formation_heading)
						--print("formation_rotation: " .. formation_rotation)
						--print("first_v_leg_place: " .. first_v_leg_place)
						--print("second_v_leg_place: " .. second_v_leg_place)
						--print(string.format("fx: %.1f, fy: %.1f",fx,fy))
						for _, fm in pairs(fto) do
							if fm ~= nil and fm:isValid() and fm ~= formation_lead then
								fm:setHeading(formation_heading)
								fm:setRotation(formation_rotation)
								local rpx = nil
								local rpy = nil
								local fpx = nil
								local fpy = nil
								if position_index % 2 ~= 0 then
									formation_spacing = formation_spacing + formation_spacing_increment
									rpx, rpy = vectorFromAngle(first_v_leg_place,formation_spacing)
									fpx, fpy = vectorFromAngle(first_v_leg_fly,formation_spacing)
								else
									rpx, rpy = vectorFromAngle(second_v_leg_place,formation_spacing)
									fpx, fpy = vectorFromAngle(second_v_leg_fly,formation_spacing)
								end--
								--print(string.format("rpx: %.1f, rpy: %.1f",rpx,rpy))
								--print(string.format("fx+rpx: %.1f, fy+rpy: %.1f",fx+rpx,fy+rpy))
								fm:setPosition(fx+rpx,fy+rpy)
								fm:orderFlyFormation(formation_lead,fpx,fpy)
								position_index = position_index + 1
							end
						end
					elseif formation_type == "A" then
						local first_A_leg_place = formation_rotation + 60
						local first_A_leg_fly = formation_heading + 60
						if first_A_leg_place > 360 then
							first_A_leg_place = first_A_leg_place - 360
						end
						if first_A_leg_fly > 360 then
							first_A_leg_fly = first_A_leg_fly - 360
						end
						local second_A_leg_place = formation_rotation + 300
						local second_A_leg_fly = formation_heading + 300
						if second_A_leg_place > 360 then
							second_A_leg_place = second_A_leg_place - 360
						end
						if second_A_leg_fly > 360 then
							second_A_leg_fly = second_A_leg_fly - 360
						end
						for _, fm in pairs(fto) do
							if fm ~= nil and fm:isValid() and fm ~= formation_lead then
								fm:setHeading(formation_heading)
								fm:setRotation(formation_rotation)
								local rpx = nil
								local rpy = nil
								local fpx = nil
								local fpy = nil
								if position_index % 2 ~= 0 then
									formation_spacing = formation_spacing + formation_spacing_increment
									rpx, rpy = vectorFromAngle(first_A_leg_place,formation_spacing)
									fpx, fpy = vectorFromAngle(first_A_leg_fly,formation_spacing)
								else
									rpx, rpy = vectorFromAngle(second_A_leg_place,formation_spacing)
									fpx, fpy = vectorFromAngle(second_A_leg_fly,formation_spacing)
								end--
								fm:setPosition(fx+rpx,fy+rpy)
								fm:orderFlyFormation(formation_lead,fpx,fpy)
								position_index = position_index + 1
							end
						end
					elseif formation_type == "circle" then
						local placement_angle = 30
						local circle_top_place = formation_rotation + placement_angle
						local circle_top_fly = formation_heading + placement_angle
						if circle_top_place > 360 then
							circle_top_place = circle_top_place - 360
						end
						if circle_top_fly > 360 then
							circle_top_fly = circle_top_fly - 360
						end
						local circle_count = 0
						for _, fm in pairs(fto) do
							if fm ~= nil and fm:isValid() and fm ~= formation_lead then
								circle_count = circle_count + 1
							end
						end
						local circle_radius = 1500
						if circle_count > 0 then
							local angle_increment = 360/circle_count
							for _, fm in pairs(fto) do
								if fm ~= nil and fm:isValid() and fm ~= formation_lead then
									fm:setHeading(formation_heading)
									fm:setRotation(formation_rotation)
									rpx, rpy = vectorFromAngle(circle_top_place,circle_radius)
									fpx, fpy = vectorFromAngle(circle_top_fly,circle_radius)
									fm:setPosition(fx+rpx,fy+rpy)
									fm:orderFlyFormation(formation_lead,fpx,fpy)
									circle_top_place = circle_top_place + angle_increment
									if circle_top_place > 360 then
										circle_top_place = circle_top_place - 360
									end
									circle_top_fly = circle_top_fly + angle_increment
									if circle_top_fly > 360 then
										circle_top_fly = circle_top_fly - 360
									end
								end
							end
						end
					elseif formation_type == "square" then
						local corner_spot = 1
						local edge_spot = 1
						local layer_count = 1
						local square_spacing = 1000
						local corner_x = {1,-1,1,-1}
						local corner_y = {1,-1,-1,1}
						local edge_x = {0,0,1,-1}
						local edge_y = {1,-1,0,0}
						local fly_corner_x = {-1,1,1,-1}
						local fly_corner_y = {1,-1,1,-1}
						local fly_edge_x = {-1,1,0,0}
						local fly_edge_y = {0,0,-1,1}
						for _, fm in pairs(fto) do
							if fm ~= nil and fm:isValid() and fm ~= formation_lead then
								fm:setHeading(formation_heading)
								fm:setRotation(formation_rotation)
								if corner_spot <= 4 then
									fm:setPosition(fx+layer_count*square_spacing*corner_x[corner_spot],fy+layer_count*square_spacing*corner_y[corner_spot])
									fm:orderFlyFormation(formation_lead,layer_count*square_spacing*fly_corner_x[corner_spot],layer_count*square_spacing*fly_corner_y[corner_spot])
									corner_spot = corner_spot + 1
								elseif edge_spot <= 4 then
									fm:setPosition(fx+layer_count*square_spacing*edge_x[edge_spot],fy+layer_count*square_spacing*edge_y[edge_spot])
									fm:orderFlyFormation(formation_lead,layer_count*square_spacing*fly_edge_x[edge_spot],layer_count*square_spacing*fly_edge_y[edge_spot])
									edge_spot = edge_spot + 1
								else
									corner_spot = 1
									edge_spot = 1
									layer_count = layer_count + 1
								end
							end
						end
					else
						addGMMessage("formation type unrecognized. no action taken")
					end
				else
					addGMMessage("formation lead not in fleet. no action taken")
				end
			end
		end)
	end
	addGMFunction("+Reorganize Fleet",orderFleetChange)
	addGMFunction("+Average Impulse",averageImpulse)
	addGMFunction("Set Player Fleet",function()
		local object_list = getGMSelection()
		local fleet = {}
		for _, temp_object in pairs(object_list) do
			if temp_object.typeName == "CpuShip" then
				if temp_object:getFaction() == "Human Navy" then
					table.insert(fleet,temp_object)
				end
			end
		end
		if #fleet > 0 then
			friendlyDefensiveFleetList[string.char(friendly_defensive_fleet_val)] = fleet
			local ship_names = ""
			for _, ship in ipairs(fleet) do
				ship.fleet = string.char(friendly_defensive_fleet_val)
				ship_names = ship_names .. ship:getCallSign() .. " "
			end
			addGMMessage(string.format("Fleet %s created with these ships:\n   %s\nDon't forget to add sandbox comms:\n   Select ship(s), Tweak Terrain > Sandbox Comms",string.char(friendly_defensive_fleet_val),ship_names))
			friendly_defensive_fleet_val = friendly_defensive_fleet_val + 1
			--no boundary check for more than 26 fleets		
		else
			addGMMessage("No Human Navy ships selected. No action taken")
		end
	end)
end
------------------
--	Order Ship  --
------------------
-- Button Text			   DF*	Related Function(s)
-- -MAIN FROM ORDER SHIP	F	initialGMFunctions
-- JAM RANGE 10 - 5 = 5U	D	inline
-- JAM RANGE 10 + 5 = 15U	D	inline
-- DROP JAMMER 10U			D	dropJammer
-- FIX SHIELD FREQ			F	inline
-- +ATTACH TO SHIP			F	attachAnythingToNPS
-- +DETACH					F	detachAnythingFromNPS
-- +PATROL					F	setPatrolPoints
function orderShip()
	clearGMFunctions()
	addGMFunction("-Main from order ship",initialGMFunctions)
	if jammer_range > 5000 then
		addGMFunction(string.format("Jam range %i - %i = %iU",jammer_range/1000,5,(jammer_range-5000)/1000),function()
			jammer_range = jammer_range - 5000
			orderShip()
		end)
	end
	if jammer_range < 50000 then
		addGMFunction(string.format("Jam range %i + %i = %iU",jammer_range/1000,5,(jammer_range+5000)/1000),function()
			jammer_range = jammer_range + 5000
			orderShip()
		end)
	end
	addGMFunction(string.format("Drop Jammer %iU",jammer_range/1000),dropJammer)
	addGMFunction("Fix Shield Freq",function()
		local object_list = getGMSelection()
		if #object_list ~= 1 then
			addGMMessage("You need to select a CPU ship. No action taken")
			return
		end
		local tempObject = object_list[1]
		local tempType = tempObject.typeName
		if tempType ~= "CpuShip" then
			addGMMessage("You need to select a CPU ship. No action taken")
			return
		end
		if tempObject.damage_instigator == nil then
			addGMMessage("No damage-instigating perpetrator found. No action taken")
			return
		end
		if tempObject.damage_instigator:getBeamFrequency() == nil then
			addGMMessage("Damage instigator has no beam frequency. No action taken")
			return
		end
		tempObject:setShieldsFrequency(tempObject.damage_instigator:getBeamFrequency())
		addGMMessage(string.format("shields of %s change to frequency %s",tempObject:getCallSign(),tempObject.damage_instigator:getBeamFrequency()))
	end)
	addGMFunction("+Attach To Ship",attachAnythingToNPS)
	addGMFunction("+Detach",detachAnythingFromNPS)
	addGMFunction("+Patrol",setPatrolPoints)	--currently broken
end
function setPatrolPoints()
	clearGMFunctions()
	addGMFunction("-Main from Patrol",initialGMFunctions)
	addGMFunction("-Order Ship",orderShip)
	local patrol_ship_selected = false
	local selection_label = "+Select ship"
	if patrol_ship ~= nil and patrol_ship:isValid() then
		patrol_ship_selected = true
	end
	if patrol_ship_selected then
		selection_label = string.format("+Change from %s",patrol_ship:getCallSign())
	end
	local object_list = getGMSelection()
	if #object_list == 1 then
		local temp_object = object_list[1]
		local temp_type = temp_object.typeName
		if temp_type == "CpuShip" then
			if patrol_ship_selected then
				if patrol_ship ~= temp_object then
					selection_label = string.format("+Chg %s to %s",patrol_ship:getCallSign(),temp_object:getCallSign())
				end
			else
				selection_label = string.format("+Select %s",temp_object:getCallSign())
			end
		end
	end
	addGMFunction(selection_label,changePatrolShip)
	if patrol_ship_selected then
		local add_point_label = "Add patrol point"
		if patrol_ship.patrol_points ~= nil then
			add_point_label = string.format("%s %i",add_point_label,#patrol_ship.patrol_points + 1)
		end
		if gm_click_mode == "add patrol point" then
			addGMFunction(string.format(">%s<",add_point_label),addPatrolPoint)
		else
			addGMFunction(string.format("%s",add_point_label),addPatrolPoint)
		end
		if patrol_ship.patrol_points ~= nil then
			addGMFunction("Del Patrol Points",function()
				patrol_ship.patrol_points = nil
				addGMMessage(string.format("All patrol points deleted from %s",patrol_ship:getCallSign()))
				setPatrolPoints()
			end)
		end
	end
end
function addPatrolPoint()
	if gm_click_mode == "add patrol point" then
		gm_click_mode = nil
		onGMClick(nil)
	else
		local prev_mode = gm_click_mode
		gm_click_mode = "add patrol point"
		onGMClick(gmClickAddPatrolPoint)
		if prev_mode ~= nil then
			addGMMessage(string.format("Cancelled current GM Click mode\n   %s\nIn favor of\n   add patrol point\nGM click mode.",prev_mode))
		end
	end
	setPatrolPoints()
end
function changePatrolShip()
	local object_list = getGMSelection()
	if #object_list == 1 then
		local temp_object = object_list[1]
		local temp_type = temp_object.typeName
		if temp_type == "CpuShip" then
			patrol_ship = temp_object
		else
			addGMMessage("Select CPU ship. No action taken")
		end
	else
		addGMMessage("Select one CPU ship. No action taken")
	end
	setPatrolPoints()
end
function gmClickAddPatrolPoint(x,y)
	if patrol_ship ~= nil and patrol_ship:isValid() then
		if patrol_ship.patrol_points ~= nil then
			table.insert(patrol_ship.patrol_points,{x = x, y = y})
		else
			local px, py = patrol_ship:getPosition()
			local patrol_points = {
				{x = px, y = py},
				{x = x, y = y},
			}
			--						obj,			patrol_points,	patrol_point_index,	patrol_check_timer_interval
			update_system:addPatrol(patrol_ship,	patrol_points,	2,					5)
			patrol_ship:orderFlyTowards(x,y)
		end
		setPatrolPoints()
	end
end
function detachAnythingFromNPS()
	clearGMFunctions()
	addGMFunction("-Main from detach",initialGMFunctions)
	addGMFunction("-Order Ship",orderShip)
	local object_list = getGMSelection()
	if #object_list < 1 or #object_list > 1 then
		addGMFunction("+Select object",detachAnythingFromNPS)
		return
	end
	local current_selected_object = object_list[1]
	local current_selected_object_type = current_selected_object.typeName
	update_system:removeUpdateNamed(current_selected_object,"attached")
end
function attachAnythingToNPS()
	clearGMFunctions()
	addGMFunction("-Main from attach",initialGMFunctions)
	addGMFunction("-Order Ship",orderShip)
	local object_list = getGMSelection()
	if #object_list < 1 or #object_list > 1 then
		addGMFunction("+Select object",attachAnythingToNPS)
		return
	end
	local current_selected_object = object_list[1]
	local current_selected_object_type = current_selected_object.typeName
	local pod_x, pod_y = current_selected_object:getPosition()
	local nearby_objects = getObjectsInRadius(pod_x, pod_y, 40000)
	cpu_ship_list = {}
	for i=1,#nearby_objects do
		local temp_object = nearby_objects[i]
		local temp_type = temp_object.typeName
		if temp_type == "CpuShip" and temp_object ~= current_selected_object then
			local ship_distance = distance(temp_object,current_selected_object)
			table.insert(cpu_ship_list,{distance = ship_distance, ship = temp_object})
		end
	end
	if #cpu_ship_list > 0 then
		table.sort(cpu_ship_list,function(a,b)
			return a.distance < b.distance
		end)
		if #cpu_ship_list >= 1 then
			addGMFunction(string.format("Attach to %s",cpu_ship_list[1].ship:getCallSign()), function()
				local attach_target_x, attach_target_y = cpu_ship_list[1].ship:getPosition()
				local relative_attach_x = pod_x - attach_target_x
				local relative_attach_y = pod_y - attach_target_y
				update_system:addAttachedUpdate(current_selected_object,cpu_ship_list[1].ship,relative_attach_x,relative_attach_y)
			end)
		end
		if #cpu_ship_list >= 2 then
			addGMFunction(string.format("Attach to %s",cpu_ship_list[2].ship:getCallSign()), function()
				local attach_target_x, attach_target_y = cpu_ship_list[2].ship:getPosition()
				local relative_attach_x = pod_x - attach_target_x
				local relative_attach_y = pod_y - attach_target_y
				update_system:addAttachedUpdate(current_selected_object,cpu_ship_list[2].ship,relative_attach_x,relative_attach_y)
			end)
		end
		if #cpu_ship_list >= 3 then
			addGMFunction(string.format("Attach to %s",cpu_ship_list[3].ship:getCallSign()), function()
				local attach_target_x, attach_target_y = cpu_ship_list[3].ship:getPosition()
				local relative_attach_x = pod_x - attach_target_x
				local relative_attach_y = pod_y - attach_target_y
				update_system:addAttachedUpdate(current_selected_object,cpu_ship_list[3],relative_attach_x,relative_attach_y)
			end)
		end
	else
		addGMMessage("No CPU Ships within 40 units of selected object")
		addGMFunction("+Select drop point",attachAnythingToNPS)
	end
end
function dropJammer()
	local object_list = getGMSelection()
	if #object_list < 1 then
		addGMMessage("Jammer drop failed - nothing selected for location determination") 
		return
	end
	local selected_matches_npc_ship = false
	for i=1,#object_list do
		local current_selected_object = object_list[i]
		if current_selected_object.typeName == "CpuShip" then
			local csox, csoy = current_selected_object:getPosition()
			local vx, vy = vectorFromAngle(current_selected_object:getHeading()+90,500)
			WarpJammer():setRange(jammer_range):setPosition(csox+vx,csoy+vy):setFaction(current_selected_object:getFaction())
		end
	end
end
-------------------
--	Drop Points  --
-------------------
-- Button Text			   FD*	Related Function(s)
-- -MAIN FROM DROP PNT		F	initialGMFunctions
-- +ESCAPE POD				F	setEscapePod
-- +MARINE POINT			F	setMarinePoint
-- +ENGINEER POINT			F	setEngineerPoint
-- +MEDICAL TEAM POINT		F	setMedicPoint
-- +CUSTOM SUPPLY			F	setCustomSupply
-- +ATTACH TO NPS			F	attachArtifact
-- +DETACH					F	detachArtifact
-- ARTIFACT TO POD			F	artifactToPod
function dropPoint()
	clearGMFunctions()
	addGMFunction("-Main from Drop Pnt",initialGMFunctions)
	addGMFunction("+Escape Pod",setEscapePod)
	addGMFunction("+Marine Point",setMarinePoint)
	addGMFunction("+Engineer Point",setEngineerPoint)
	addGMFunction("+Medical Team Point",setMedicPoint)
	addGMFunction("+Custom Supply",setCustomSupply)
	addGMFunction("+Attach to NPS",attachArtifact)
	addGMFunction("+Detach",detachArtifact)
	addGMFunction("Artifact To Pod",artifactToPod)
end
-----------------
--	Scan Clue  --
-----------------
-- Button Text			   FD*	Related Function(s)
-- -MAIN FROM SCAN CLUE		F	initialGMFunctions
-- +UNSCANNED DESC			F	setUnscannedDescription
-- +SCANNED DESC			F	setScannedDescription
-- SHOW DESCRIPTIONS		F	inline
-- +SCAN COMPLEX: 1			D	setScanComplexity
-- +SCAN DEPTH: 1			D	setScanDepth
-- UNRETRIEVABLE			D	inline (toggles between retrievable and unretrievable)
-- EXPIRING					F	inline (toggles between expiring and non-expiring)
-- +AT CLICK				D	setScanClueLocation
-- PLACE SCAN CLUE			D	placeScanClue
function scanClue()
	clearGMFunctions()
	addGMFunction("-Main from Scan Clue",initialGMFunctions)
	addGMFunction("+Unscanned Desc",setUnscannedDescription)
	addGMFunction("+Scanned Desc",setScannedDescription)
	addGMFunction("Show Descriptions",function()
		local unscannedDescription = unscannedClues[unscannedClueKey]
		local scannedDescription = ""
		if scannedClues1[scannedClueKey1] ~= nil and scannedClues1[scannedClueKey1] ~= "None" then
			scannedDescription = scannedDescription .. scannedClues1[scannedClueKey1] .. " "
		end
		if scannedClues2[scannedClueKey2] ~= nil and scannedClues2[scannedClueKey2] ~= "None" then
			scannedDescription = scannedDescription .. scannedClues2[scannedClueKey2] .. " "
		end
		if scannedClues3[scannedClueKey3] ~= nil and scannedClues3[scannedClueKey3] ~= "None" then
			scannedDescription = scannedDescription .. scannedClues3[scannedClueKey3] .. " "
		end
		if scannedClues4[scannedClueKey4] ~= nil and scannedClues4[scannedClueKey4] ~= "None" then
			scannedDescription = scannedDescription .. scannedClues4[scannedClueKey4] .. " "
		end
		if scannedClues5[scannedClueKey5] ~= nil and scannedClues5[scannedClueKey5] ~= "None" then
			scannedDescription = scannedDescription .. scannedClues5[scannedClueKey5] .. " "
		end
		addGMMessage(string.format("Unscanned description:\n%s\nScanned Description:\n%s",unscannedDescription,scannedDescription))
	end)
	local GMSetScanComplexity = "+Scan Complex: " .. scanComplexity
	addGMFunction(GMSetScanComplexity,setScanComplexity)
	local GMSetScanDepth = "+Scan Depth: " .. scanDepth
	addGMFunction(GMSetScanDepth,setScanDepth)
	if scan_clue_retrievable then
		addGMFunction("Retrievable",function()
			scan_clue_retrievable = false
			scanClue()
		end)
	else
		addGMFunction("Unretrievable",function()
			scan_clue_retrievable = true
			scanClue()
		end)
	end
	if scan_clue_expire then
		addGMFunction("Expiring",function()
			scan_clue_expire = false
			scanClue()
		end)
	else
		addGMFunction("Non-Expiring",function()
			scan_clue_expire = true
			scanClue()
		end)
	end
	addGMFunction(string.format("+%s",scan_clue_location),setScanClueLocation)
	if gm_click_mode == "place scan clue" then
		addGMFunction(">Place Scan Clue<",placeScanClue)
	else
		addGMFunction("Place Scan Clue",placeScanClue)
	end
end
function placeScanClue()
	if drop_point_location == "At Click" then
		if gm_click_mode == "place scan clue" then
			gm_click_mode = nil
			onGMClick(nil)
		else
			local prev_mode = gm_click_mode
			gm_click_mode = "place scan clue"
			onGMClick(gmClickPlaceScanClue)
			if prev_mode ~= nil then
				addGMMessage(string.format("Cancelled current GM Click mode\n   %s\nIn favor of\n   place scan clue\nGM click mode.",prev_mode))
			end
		end
		scanClue()
	elseif drop_point_location == "Near To" then
		scanClueNearTo()
	end
end
function gmClickPlaceScanClue(x,y)
	scanClueCreation(x, y, 0, 0)
end
function updateEditObjectValid()
	if update_edit_object == nil or not update_edit_object:isValid() then
		addGMMessage("the object being edited has been destroyed")
		updateEditor()
		return false
	else
		return true
	end
end
function numericEditControl(params)
	-- we need to be able to call the function that we are defining within itself
	-- there probably is a tidy way to do this, but I don't know it
	-- thus we are going to create a table which we will look up itself within
	local ret = {}
	ret.fun = function()
		assert(type(params)=="table")
		assert(type(params.closers)=="function")
		assert(type(params.getter)=="function")
		assert(type(params.setter)=="function")
		assert(type(params.name)=="string")
		assert(type(params.fixedAdjAmount)=="number")
		params.closers()
		addGMFunction(string.format("%.2f - %.2f",params.getter(),params.fixedAdjAmount),
			function ()
				params.setter(params.getter()-params.fixedAdjAmount)
				ret["fun"]()
			end)
		addGMFunction(string.format("%s = %.2f",params.name,params.getter()),nil)
		addGMFunction(string.format("%.2f + %.2f",params.getter(),params.fixedAdjAmount),
			function ()
				params.setter(params.getter()+params.fixedAdjAmount)
				ret["fun"]()
			end)
	end
	return ret.fun
end
---------------------
--	Tweak Terrain  --
---------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN				F	initialGMFunctions
-- +UPDATE EDITOR		F	updateEditor
-- EXPLODE SEL ART		F	explodeSelectedArtifact
-- PULSE ASTEROID		F	pulseAsteroid
-- JUMP CORRIDOR OFF	F	inline (toggles between ON and OFF)
-- SANDBOX COMMS		F	inline
-- +STATION OPERATIONS	F	stationOperations
-- +STATION DEFENSE		F	stationDefense
-- +MINEFIELD			F	mineField
function tweakTerrain()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("+Update Editor",updateEditor)
	addGMFunction("Explode Sel Art",explodeSelectedArtifact)
	addGMFunction("Pulse Asteroid",pulseAsteroid)
	if jump_corridor then
		addGMFunction("Jump Corridor On",function()
			jump_corridor = false
			tweakTerrain()
		end)
	else
		addGMFunction("Jump Corridor Off",function()
			jump_corridor = true
			tweakTerrain()
		end)
	end
	local objectList = getGMSelection()
	if #objectList == 1 then
		local tempObject = objectList[1]
		local tempType = tempObject.typeName
		if tempType == "SpaceStation" or tempType == "CpuShip" then
			addGMFunction("Sandbox Comms",function()
				local objectList = getGMSelection()
				if #objectList == 1 then
					local tempObject = objectList[1]
					local tempType = tempObject.typeName
					if tempType == "SpaceStation" then
						tempObject:setCommsScript(""):setCommsFunction(commsStation)
						tempObject.comms_data = {
							friendlyness = random(50,100),
							weapons = 			{Homing = "neutral",		HVLI = "neutral", 		Mine = "neutral",		Nuke = "friend", 			EMP = "friend"},
					        weapon_cost =		{Homing = math.random(2,5),	HVLI = math.random(1,4),Mine = math.random(3,8),Nuke = math.random(12,18),	EMP = math.random(12,18) },
							weapon_available = 	{Homing = random(1,10)<=9,	HVLI = random(1,10)<=8,	Mine = random(1,10)<=6,	Nuke = random(1,10)<=4,	EMP = random(1,10)<=5},
							service_cost = 		{supplydrop = math.random(80,120), reinforcements = math.random(125,175)},
							reputation_cost_multipliers = {friend = 1.0, neutral = 3.0},
							max_weapon_refill_amount = {friend = 1.0, neutral = 0.5 },
							goods = {	[componentGoods[math.random(1,#componentGoods)]]	=	{quantity = math.random(1,5),	cost = math.random(60,95)},
										[mineralGoods[math.random(1,#mineralGoods)]]		=	{quantity = math.random(1,5),	cost = math.random(30,60)} },
							trade = {	food = false, medicine = false, luxury = true },
							public_relations = false
						}
						addGMMessage(string.format("Station %s now has sandbox communications",tempObject:getCallSign()))
					elseif tempType == "CpuShip" then
						tempObject:setCommsScript(""):setCommsFunction(commsShip)
						local p = getPlayerShip(-1)
						if p ~= nil and not p:isEnemy(tempObject) then
							if region_ships == nil then
								region_ships = {}
							end
							table.insert(region_ships,tempObject)
						end
						addGMMessage(string.format("Ship %s now has sandbox communications",tempObject:getCallSign()))
					else
						addGMMessage("You can only add sandbox comms to stations or ships. No action taken")
					end
				else
					addGMMessage("Selecet a station or ship. No action taken")
				end
			end)
		end
	else
		if #objectList > 1 then
			addGMFunction("Sandbox Comms",function()
				local object_list = getGMSelection()
				if #object_list > 0 then
					local ship_names = ""
					for _, temp_object in ipairs(object_list) do
						if temp_object.typeName == "CpuShip" then
							temp_object:setCommsScript(""):setCommsFunction(commsShip)
							local p = getPlayerShip(-1)
							if p ~= nil and not p:isEnemy(temp_object) then
								if region_ships == nil then
									region_ships = {}
								end
								table.insert(region_ships,temp_object)
							end
							ship_names = ship_names .. temp_object:getCallSign() .. " "
						end
					end
					if ship_names ~= "" then
						addGMMessage(string.format("These ships now have sandbox communications:\n%s",ship_names))
					else
						addGMMessage("You can only add sandbox comms to stations or ships. No action taken")
					end
				else
					addGMMessage("Select at least one object. No action taken")
				end
			end)
		end
	end
	addGMFunction("+Station Operations",stationOperations)
	addGMFunction("+Station defense",stationDefense)
	addGMFunction("+Minefield",mineField)
end

function explodeSelectedArtifact()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		addGMMessage("You need to select an object. No action taken.")
		return
	end
	local tempObject = objectList[1]
	local tempType = tempObject.typeName
	if tempType ~= "Artifact" then
		addGMMessage("Only select an artifact since only artifacts explode. No action taken.")
		return
	end
	tempObject:explode()
end
function pulseAsteroid()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		addGMMessage("You need to select an object. No action taken.")
		return
	end
	local tempObject = objectList[1]
	local tempType = tempObject.typeName
	if tempType ~= "Asteroid" then
		addGMMessage("Only select an asteroid. No action taken.")
		return
	end
	local selected_in_list = false
	for i=1,#J4_to_L8_asteroids do
		if tempObject == J4_to_L8_asteroids[i] then
			selected_in_list = true
			break
		end
	end
	if selected_in_list then
		if tempObject.original_size == nil then
			addGMMessage("selected has a nil value where it should have an original_size. No action taken")
			return
		end
		if tempObject.original_size < 120 then
			tempObject.grow = true
			tempObject.max_size = 300
			tempObject.increment = (300 - tempObject.original_size)/10
			plotPulse = growAsteroid
		else
			tempObject.shrink = true
			tempObject.min_size = tempObject.original_size/2
			tempObject.increment = (tempObject.original_size - (tempObject.original_size/2))/10
			plotPulse = shrinkAsteroid
		end
		if pulse_asteroid_list == nil then
			pulse_asteroid_list = {}
		end
		table.insert(pulse_asteroid_list,tempObject)
	else
		addGMMessage("Only asteroids in J4 to L8 can pulse. No action taken")
		return
	end
end
function growAsteroid(delta)
	if pulse_asteroid_list ~= nil then
		if #pulse_asteroid_list > 0 then
			for i=1,#pulse_asteroid_list do
				local ta = pulse_asteroid_list[i]
				if ta ~= nil and ta:isValid() then
					if ta.grow_size == nil then
						ta.grow_size = ta.original_size
					end
					ta.grow_size = ta.grow_size + ta.increment
					ta:setSize(ta.grow_size)
					print(string.format("grow_size: %.1f, max_size: %.1f",ta.grow_size,ta.max_size))
					if ta.grow_size >= ta.max_size then
						--end of growth
						print("end of growth")
						resetPulsingAsteroid(ta)
					end
				end
			end
		end
	end
end
function resetPulsingAsteroid(ta)
	ta.grow = nil
	ta.shrink = nil
	ta.max_size = nil
	ta.min_size = nil
	ta.grow_size = nil
	ta.shrink_size = nil
	ta:setSize(ta.original_size)
	for i=1,#pulse_asteroid_list do
		if ta == pulse_asteroid_list[i] then
			table.remove(pulse_asteroid_list,i)
			break
		end
	end
	print("done resetting")
end
function shrinkAsteroid(delta)
	if pulse_asteroid_list ~= nil then
		if #pulse_asteroid_list > 0 then
			for i=1,#pulse_asteroid_list do
				local ta = pulse_asteroid_list[i]
				if ta ~= nil and ta:isValid() then
					if ta.shrink_size == nil then
						ta.shrink_size = ta.original_size
					end
					ta.shrink_size = ta.shrink_size - ta.increment
					ta:setSize(ta.shrink_size)
					print(string.format("shrink_size: %.1f, min_size: %.1f",ta.shrink_size,ta.min_size))
					if ta.shrink_size <= ta.min_size then
						--end of shrink
						print("end of shrink")
						resetPulsingAsteroid(ta)
					end
				end
			end
		end
	end
end
-----------------------
--	Countdown Timer  --
-----------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN FROM TIMER		F	initialGMFunctions
-- +DISPLAY: GM			D	GMTimerDisplay
-- +LENGTH: 5			D	GMTimerLength
-- +PURPOSE: TIMER		D	GMTimerPurpose
-- +ADD SECONDS			F	addSecondsToTimer		(only present after timer starts)
-- +DELETE SECONDS		F	deleteSecondsFromTimer	(only present after timer starts)
-- +CHANGE SPEED		F	changeTimerSpeed		(only present after timer starts)
-- SHOW CURRENT			F	inline					(only present after timer starts)
-- START TIMER			F	inline: toggles between START and STOP (related code in update)
function countdownTimer()
	clearGMFunctions()
	addGMFunction("-Main from Timer",initialGMFunctions)
	local timer_display = "+Display: GM"
	if timer_display_helm then
		timer_display = timer_display .. ",H"
	end
	if timer_display_weapons then
		timer_display = timer_display .. ",W"
	end
	if timer_display_engineer then
		timer_display = timer_display .. ",E"
	end
	if timer_display_science then
		timer_display = timer_display .. ",S"
	end
	if timer_display_relay then
		timer_display = timer_display .. ",R"
	end
	addGMFunction(timer_display,GMTimerDisplay)
	addGMFunction(string.format("+Length: %i",timer_start_length),GMTimerLength)
	addGMFunction(string.format("+Purpose: %s",timer_purpose),GMTimerPurpose)
	if timer_started then
		addGMFunction("+Add Seconds",addSecondsToTimer)
		addGMFunction("+Delete Seconds",deleteSecondsFromTimer)
		addGMFunction("+Change Speed",changeTimerSpeed)
		addGMFunction("Show Current",function()
			local timer_status = timer_purpose
			local timer_minutes = math.floor(timer_value / 60)
			local timer_seconds = math.floor(timer_value % 60)
			if timer_minutes <= 0 then
				timer_status = string.format("%s %i",timer_status,timer_seconds)
			else
				timer_status = string.format("%s %i:%.2i",timer_status,timer_minutes,timer_seconds)
			end
			if timer_fudge > 0 then
				timer_status = string.format("%s\n(slowed: %.3f)",timer_status,timer_fudge)
			elseif timer_fudge < 0 then
				timer_status = string.format("%s\n(sped up: %.3f)",timer_status,-timer_fudge)
			end
			addGMMessage(timer_status)
		end)
		addGMFunction("Stop Timer", function()
			timer_started = false
			countdownTimer()
		end)
	else
		addGMFunction("Start Timer", function()
			timer_started = true
			countdownTimer()
		end)
	end
end
-------------------
--	End Session  --
-------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN FROM END		F	initialGMFunctions
-- +REGION REPORT		F	regionReport
-- +FACTION VICTORY		F	endMission
function endSession()
	clearGMFunctions()
	addGMFunction("-Main From End",initialGMFunctions)
	addGMFunction("+Region Report",regionReport)
	addGMFunction("+Faction Victory",endMission)
end
--------------
--	Custom  --
--------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN FROM END		F	initialGMFunctions
-- +DEBUG				F	debugButtons
-- +SNIPPET				F	snippetButtons
-- +SCIENCE DB			F	scienceDatabase
function customButtons()
	clearGMFunctions()
	addGMFunction("-Main From Custom",initialGMFunctions)
	addGMFunction("+Debug",debugButtons)
	addGMFunction("+Snippet",snippetButtons)
	addGMFunction("+Science DB",scienceDatabase)
	addGMFunction("4k mine ring",singleObjectFunction(function (obj)
		local x,y = obj:getPosition()
			mineRingShim{x=x, y=y, dist=12000, segments=4, angle=0, gap_size=5, gap=1, speed=60}
		end))	-- this probably wants to be done properly with a nice fancy UI but today is not the day
	addGMFunction("ghost setup",function()
		CpuShip():setFaction("Ghosts"):setTemplate("Defense platform"):setCallSign("DP2"):setPosition(583206, 296210)
		CpuShip():setFaction("Ghosts"):setTemplate("Piranha F12.M"):setCallSign("NC9"):setPosition(586733, 288815):setWeaponStorage("Nuke", 0):setWeaponStorage("HVLI", 6)
		CpuShip():setFaction("Ghosts"):setTemplate("Piranha F12.M"):setCallSign("VS10"):setPosition(585369, 288737):setWeaponStorage("Nuke", 0):setWeaponStorage("HVLI", 6)
		CpuShip():setFaction("Ghosts"):setTemplate("Nirvana R5A"):setCallSign("SS11"):setPosition(585379, 289271)
		CpuShip():setFaction("Ghosts"):setTemplate("Nirvana R5A"):setCallSign("CV16"):setPosition(586718, 288183)
		CpuShip():setFaction("Ghosts"):setTemplate("Storm"):setCallSign("UTI20"):setPosition(586045, 288149):setWeaponStorage("Homing", 10)
		CpuShip():setFaction("Ghosts"):setTemplate("Nirvana R5A"):setCallSign("VK15"):setPosition(585369, 288257)
		CpuShip():setFaction("Ghosts"):setTemplate("Defense platform"):setCallSign("DP6"):setPosition(589491, 296139)
		CpuShip():setFaction("Ghosts"):setTemplate("Starhammer II"):setCallSign("terminus"):setPosition(586037, 289433):setWeaponStorage("Homing", 3):setWeaponStorage("EMP", 1)
		CpuShip():setFaction("Ghosts"):setTemplate("Nirvana R5A"):setCallSign("VS12"):setPosition(586289, 289313)
		CpuShip():setFaction("Ghosts"):setTemplate("Piranha F12.M"):setCallSign("S8"):setPosition(585402, 303565):setWeaponStorage("Nuke", 0):setWeaponStorage("HVLI", 6)
		CpuShip():setFaction("Ghosts"):setTemplate("Piranha F12.M"):setCallSign("BR7"):setPosition(586766, 303705):setWeaponStorage("Nuke", 0):setWeaponStorage("HVLI", 6)
		CpuShip():setFaction("Ghosts"):setTemplate("Nirvana R5A"):setCallSign("NC18"):setPosition(586766, 304106)
		CpuShip():setFaction("Ghosts"):setTemplate("Nirvana R5A"):setCallSign("SS13"):setPosition(585660, 303233)
		CpuShip():setFaction("Ghosts"):setTemplate("Starhammer II"):setCallSign("SCMODS"):setPosition(586067, 303113):setWeaponStorage("Homing", 3):setWeaponStorage("EMP", 1)
		CpuShip():setFaction("Ghosts"):setTemplate("Transport5x5"):setCallSign("talos"):setPosition(586469, 302949)
		CpuShip():setFaction("Ghosts"):setTemplate("Storm"):setCallSign("VK19"):setPosition(586033, 304397):setWeaponStorage("Homing", 10)
		CpuShip():setFaction("Ghosts"):setTemplate("Nirvana R5A"):setCallSign("CCN14"):setPosition(586733, 303249)
		CpuShip():setFaction("Ghosts"):setTemplate("Nirvana R5A"):setCallSign("CSS17"):setPosition(585402, 304253)
		CpuShip():setFaction("Ghosts"):setTemplate("Starhammer II"):setCallSign("CSS50"):setPosition(643734, 296415):orderRoaming():setWeaponStorage("Homing", 3):setWeaponStorage("EMP", 1)
		CpuShip():setFaction("Ghosts"):setTemplate("WX-Lindworm"):setCallSign("SS56"):setPosition(642146, 297017):orderRoaming():setJumpDrive(true):setWeaponStorage("Homing", 0):setWeaponStorage("HVLI", 4)
		CpuShip():setFaction("Ghosts"):setTemplate("Starhammer II"):setCallSign("UTI51"):setPosition(643661, 299810):orderRoaming():setWeaponStorage("Homing", 3):setWeaponStorage("EMP", 1)
		CpuShip():setFaction("Ghosts"):setTemplate("Piranha F12"):setCallSign("SS55"):setPosition(644829, 299901):orderRoaming():setJumpDrive(true):setWeaponStorage("Homing", 4):setWeaponStorage("HVLI", 16)
		CpuShip():setFaction("Ghosts"):setTemplate("Piranha F12"):setCallSign("S52"):setPosition(645157, 297255):orderRoaming():setJumpDrive(true):setWeaponStorage("Homing", 4):setWeaponStorage("HVLI", 16)
		CpuShip():setFaction("Ghosts"):setTemplate("Strikeship"):setCallSign("CSS58"):setPosition(642310, 297784):orderRoaming():setJumpDrive(true):setWarpDrive(false):setWarpSpeed(0.00)
		CpuShip():setFaction("Ghosts"):setTemplate("Strikeship"):setCallSign("CCN59"):setPosition(642182, 298496):orderRoaming():setJumpDrive(true):setWarpDrive(false):setWarpSpeed(0.00)
		CpuShip():setFaction("Ghosts"):setTemplate("WX-Lindworm"):setCallSign("VK57"):setPosition(642274, 299335):orderRoaming():setJumpDrive(true):setWeaponStorage("Homing", 0):setWeaponStorage("HVLI", 4)
		CpuShip():setFaction("Ghosts"):setTemplate("Piranha F12"):setCallSign("NC54"):setPosition(645522, 298989):orderRoaming():setJumpDrive(true):setWeaponStorage("Homing", 4):setWeaponStorage("HVLI", 16)
		CpuShip():setFaction("Ghosts"):setTemplate("Piranha F12"):setCallSign("CCN53"):setPosition(645522, 298039):orderRoaming():setJumpDrive(true):setWeaponStorage("Homing", 4):setWeaponStorage("HVLI", 16)
		CpuShip():setFaction("Ghosts"):setTemplate("Strikeship"):setCallSign("VK61"):setPosition(641251, 298623):orderRoaming():setJumpDrive(true):setWarpDrive(false):setWarpSpeed(0.00)
		CpuShip():setFaction("Ghosts"):setTemplate("Strikeship"):setCallSign("CV60"):setPosition(641233, 297912):orderRoaming():setJumpDrive(true):setWarpDrive(false):setWarpSpeed(0.00)
	end)
	addGMFunction("boss battle",function()
			CpuShip():setFaction("Kraylor"):setTemplate("Strikeship"):setCallSign("UTI44"):setPosition(601834, 599635):orderRoaming()
		CpuShip():setFaction("Kraylor"):setTemplate("Strikeship"):setCallSign("NC49"):setPosition(602814, 600718):orderRoaming()
		CpuShip():setFaction("Kraylor"):setTemplate("Strikeship"):setCallSign("UTI45"):setPosition(602824, 599604):orderRoaming()
		CpuShip():setFaction("Kraylor"):setTemplate("Strikeship"):setCallSign("CSS33"):setPosition(598977, 602372):orderRoaming()
		CpuShip():setFaction("Kraylor"):setTemplate("Strikeship"):setCallSign("SS46"):setPosition(596845, 600551):orderRoaming()
		CpuShip():setFaction("Kraylor"):setTemplate("Strikeship"):setCallSign("CV47"):setPosition(598084, 600739):orderRoaming()
		CpuShip():setFaction("Kraylor"):setTemplate("Strikeship"):setCallSign("CV43"):setPosition(597980, 599208):orderRoaming()
		CpuShip():setFaction("Kraylor"):setTemplate("Odin"):setCallSign("VS32"):setPosition(604980, 591314):orderRoaming():setWeaponStorage("Homing", 968)
		SpaceStation():setTemplate("Small Station"):setFaction("Kraylor"):setCallSign("DS3209"):setPosition(603890, 596151)
		CpuShip():setFaction("Kraylor"):setTemplate("Odin"):setCallSign("SS30"):setPosition(608741, 605018):orderRoaming():setWeaponStorage("Homing", 968)
		CpuShip():setFaction("Kraylor"):setTemplate("Odin"):setCallSign("NC31"):setPosition(609563, 597669):orderRoaming():setWeaponStorage("Homing", 968)
		SpaceStation():setTemplate("Small Station"):setFaction("Kraylor"):setCallSign("DS3210"):setPosition(603862, 603779)
		CpuShip():setFaction("Kraylor"):setTemplate("Odin"):setCallSign("NC29"):setPosition(602602, 609125):orderRoaming():setWeaponStorage("Homing", 968)
		CpuShip():setFaction("Kraylor"):setTemplate("Odin"):setCallSign("CV28"):setPosition(595034, 608656):orderRoaming():setWeaponStorage("Homing", 968)
		SpaceStation():setTemplate("Small Station"):setFaction("Kraylor"):setCallSign("DS3211"):setPosition(596356, 603757)
		CpuShip():setFaction("Kraylor"):setTemplate("Strikeship"):setCallSign("CSS35"):setPosition(601070, 602580):orderRoaming()
		CpuShip():setFaction("Kraylor"):setTemplate("Strikeship"):setCallSign("CSS39"):setPosition(601119, 603375):orderRoaming()
		CpuShip():setFaction("Kraylor"):setTemplate("Strikeship"):setCallSign("CV34"):setPosition(600103, 602433):orderRoaming()
		CpuShip():setFaction("Kraylor"):setTemplate("Strikeship"):setCallSign("NC48"):setPosition(601678, 600843):orderRoaming()
		CpuShip():setFaction("Kraylor"):setTemplate("Strikeship"):setCallSign("CSS40"):setPosition(600703, 597848):orderRoaming()
		CpuShip():setFaction("Kraylor"):setTemplate("Strikeship"):setCallSign("VK38"):setPosition(601706, 598411):orderRoaming()
		CpuShip():setFaction("Kraylor"):setTemplate("Strikeship"):setCallSign("SS41"):setPosition(599356, 597358):orderRoaming()
		CpuShip():setFaction("Kraylor"):setTemplate("Strikeship"):setCallSign("S42"):setPosition(597511, 599072):orderRoaming()
		CpuShip():setFaction("Kraylor"):setTemplate("Strikeship"):setCallSign("SS32"):setPosition(598331, 596825):orderRoaming()
		SpaceStation():setTemplate("Small Station"):setFaction("Kraylor"):setCallSign("DS3208"):setPosition(596308, 596165)
		SpaceStation():setTemplate("Large Station"):setFaction("Kraylor"):setCallSign("DS3206"):setPosition(600024, 600006)
		CpuShip():setFaction("Kraylor"):setTemplate("Odin"):setCallSign("BR27"):setPosition(597433, 590779):orderRoaming():setWeaponStorage("Homing", 968)
		CpuShip():setFaction("Kraylor"):setTemplate("Odin"):setCallSign("CCN25"):setPosition(590869, 602565):orderRoaming():setWeaponStorage("Homing", 968)
		CpuShip():setFaction("Kraylor"):setTemplate("Odin"):setCallSign("VS26"):setPosition(591360, 594996):orderRoaming():setWeaponStorage("Homing", 968)
	end)
end
-- eh this should live somewhere else, but let it be a reminder to simplify other code
-- there also should be some similar ones for playerships, spaceships etc
function singleObjectFunction(fn)
	return function ()
		local object_list = getGMSelection()
		if #object_list ~= 1 then
			addGMMessage("you must select one object")
			return
		end
		fn(object_list[1])
	end
end
function singleCPUShipFunction(fn)
	return singleObjectFunction(function (obj)
		if obj.typeName ~= "CpuShip" then
			addGMMessage("you must select one CPUship")
			return
		end
		fn(obj)
	end)
end
function GMmessageHackedStatus(ship)
	-- it might be nice if there was logic to see if the systems we print exist
	addGMMessage(
		string.format(
			"hacked amount\n" ..
			"%s = %f \n" ..
			"%s = %f \n" ..
			"%s = %f \n" ..
			"%s = %f \n" ..
			"%s = %f \n" ..
			"%s = %f \n" ..
			"%s = %f \n" ..
			"%s = %f \n" ..
			"%s = %f \n",
			"reactor",ship:getSystemHackedLevel("reactor"),
			"beamweapons",ship:getSystemHackedLevel("beamweapons"),
			"missilesystem",ship:getSystemHackedLevel("missilesystem"),
			"maneuver",ship:getSystemHackedLevel("maneuver"),
			"impulse",ship:getSystemHackedLevel("impulse"),
			"warp",ship:getSystemHackedLevel("warp"),
			"jumpdrive",ship:getSystemHackedLevel("jumpdrive"),
			"frontshield",ship:getSystemHackedLevel("frontshield"),
			"rearshield",ship:getSystemHackedLevel("rearshield")
	))
end
function shieldsDegrade()
	local object_list = getGMSelection()
	if #object_list ~= 1 then
		addGMMessage("Need to a ship to decay shields on")
		return
	end
	if object_list[1]:getShieldCount() == nil then
		addGMMessage("target has no shield")
		return
	end
	--addShieldDecayCurve = function (self, obj, total_time, curve_x, curve_y)
	--								  obj			,total_time	,curve_x			,curve_y
	--															 table of 4 numbers	 table of 4 numbers
	update_system:addShieldDecayCurve(object_list[1],2*60*60	,{0,0.33,0.66,1}	,{1.0,0.5,0.4,0.1})
end
function shieldsRegen()
	local object_list = getGMSelection()
	if #object_list ~= 1 then
		addGMMessage("Need to a ship to restore shields on")
		return
	end
	if object_list[1]:getShieldCount() == nil then
		addGMMessage("target has no shield")
		return
	end
	--addShieldDecayCurve = function (self, obj, total_time, curve_x, curve_y)
	--								  obj			,total_time	,curve_x			,curve_y
	--															 table of 4 numbers	 table of 4 numbers
	update_system:addShieldDecayCurve(object_list[1],60*60		,{0,0.33,0.66,1}	,{0.1,0.4,0.5,1.0})
end
function bleedEnergy()
	local object_list = getGMSelection()
	if #object_list ~= 1 then
		addGMMessage("Need to a ship to decay energy on")
		return
	end
	if object_list[1].getMaxEnergy == nil then
		addGMMessage("target has no energy")
		return
	end
	update_system:addEnergyDecayCurve(object_list[1],2*60*60,{0.0,0.33,0.66,1},{0.0,-0.4,-0.5,-1.0})
end
function restoreEnergy()
	local object_list = getGMSelection()
	if #object_list ~= 1 then
		addGMMessage("Need to a ship to restore energy on")
		return
	end
	if object_list[1].getMaxEnergy == nil then
		addGMMessage("target has no energy")
		return
	end
	update_system:addEnergyDecayCurve(object_list[1],60*60,{0.0,0.33,0.66,1},{-1.0,-0.5,-0.4,0.0})
end
--	*											   *  --
--	**											  **  --
--	************************************************  --
--	****			Initial Set Up				****  --
--	************************************************  --
--	**											  **  --
--	*											   *  --
-------------------------------------
--	Initial Set Up > Start Region  --
-------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN FROM REGION	F	initialGMFunctions
-- -SETUP				F	initialSetUp
-- +PLAYER SPAWN POINT	F	setDefaultPlayerSpawnPoint
-- +TERRAIN				F	changeTerrain
function setStartRegion()
	clearGMFunctions()
	addGMFunction("-Main From Region",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("+Player Spawn Point",setDefaultPlayerSpawnPoint)
	addGMFunction("+Terrain",changeTerrain)
end
-------------------------------------
--	Initial Set Up > Player Ships  --
-------------------------------------
-- Button text		   FD*	Related function(s)
-- -MAIN				F	initialGMFunctions
-- -SETUP				F	initialSetUp
-- +TWEAK PLAYER		F	tweakPlayerShip
-- +CURRENT				F	activePlayerShip
-- +SCRAPPED			F	inactivePlayerShip
-- +DESCRIPTIONS		F	describePlayerShips
-- +TELEPORT PLAYERS	F	teleportPlayers
function playerShip()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("+Tweak player",tweakPlayerShip)
	addGMFunction("+Current",activePlayerShip)
	addGMFunction("+Scrapped",inactivePlayerShip)
	addGMFunction("+Descriptions",describePlayerShips)
	addGMFunction("+Teleport Players",teleportPlayers)
	if playerShipInfo == nil then
		playerShipInfo={
			{"Ambition"		,"inactive"	,createPlayerShipAmbition	,"Phobos T2(Ambition): Frigate, Cruiser   Hull:150   Shield:100,100   Size:200   Repair Crew:5   Cargo:9   R.Strength:19\nFTL:Jump (2U - 25U)   Speeds: Impulse:80   Spin:20   Accelerate:20   C.Maneuver: Boost:400 Strafe:250\nBeams:2 Front Turreted Speed:0.2\n   Arc:90   Direction:-15   Range:1.2   Cycle:8   Damage:6\n   Arc:90   Direction: 15   Range:1.2   Cycle:8   Damage:6\nTubes:2   Load Speed:10   Front:1   Back:1\n   Direction:  0   Type:Exclude Mine\n   Direction:180   Type:Mine Only\n   Ordnance stock and type:\n      06 Homing\n      02 Nuke\n      03 Mine\n      03 EMP\n      10 HVLI\nBased on Phobos M3P: more repair crew, weaker hull, short jump drive, faster spin, slow turreted beams, only one tube in front, reduced homing and HVLI storage"},
			{"Argonaut"		,"inactive"	,createPlayerShipArgonaut	,"Nusret (Argonaut): Frigate, Mine Layer   Hull:100   Shield:60,60   Size:200   Repair Crew:4   Cargo:7   R.Strength:16\nFTL:Jump (2.5U - 25U   Speeds: Impulse:100   Spin:10   Accelerate:15   C.Maneuver: Boost:250 Strafe:150   LRS:25   SRS:4\nBeams:2 Front Turreted Speed:6\n   Arc:90   Direction: 35   Range:1   Cycle:6   Damage:6\n   Arc:90   Direction:-35   Range:1   Cycle:6   Damage:6\nTubes:3   Load Speed:10   Front Left, Front Right, Back\n   Direction:-60   Type:Homing Only\n   Direction: 60   Type:Homing Only\n   Direction:180   Type:Mine Only\n   Ordnance stock and type:\n      8 Homing\n      8 Mine\nBased on Nautilus: short jump drive, two of three mine tubes converted to angled front homing tubes, fewer mines, slightly longer sensors"},
			{"Arwine"		,"inactive"	,createPlayerShipArwine		,"Pacu(Arwine): Frigate, Cruiser: Light Artillery   Hull:150   Shield:100,100   Size:200   Repair Crew:5   Cargo:7   R.Strength:18\nFTL:Jump (2U - 25U)   Speeds: Impulse:70   Spin:10   Accelerate:8   C.Maneuver: Boost:200 Strafe:150\nBeam:1 Front Turreted Speed:0.2\n   Arc:80   Direction:0   Range:1.2   Cycle:4   Damage:4\nTubes:7   Load Speed:8   Side:6   Back:1\n   Direction:-90   Type:HVLI Only - Large\n   Direction:-90   Type:Exclude Mine\n   Direction:-90   Type:HVLI Only - Large\n   Direction: 90   Type:HVLI Only - Large\n   Direction: 90   Type:Exclude Mine\n   Direction: 90   Type:HVLI Only - Large\n   Direction:180   Type:Mine Only\n   Ordnance stock and type:\n      12 Homing\n      04 Nuke\n      04 Mine\n      04 EMP\n      20 HVLI\nBased on Piranha: more repair crew, shorter jump drive range, faster impulse, stronger hull, stronger shields, one turreted beam, one less mine tube, fewer mines and nukes, more EMPs"},
			{"Barracuda"	,"inactive"	,createPlayerShipBarracuda	,"Redhook (Barracuda), Frigate, Cruiser: Light Artillery    Hull:140   Shield:100,100   Size:200   Repair Crew:4    Cargo:8    R.Strength:11\nFTL:Jump (2U - 25U)   Speeds: Impulst:60   Spin:10   Accelerate:8   C.Maneuver: Boost:200 Strafe:150   LRS:20   SRS:6\nBeams:1 Turreted Speed:0.5\n   Arc:80   Direction:0   Range:1   Cycle:4   Damage:4\nTubes:7   Load Speed:8   Side:6   Back:1\n   Direction:-90   Type:HVLI or Homing - Large\n   Direction:-90   Type:HVLI or EMP\n   Direction:-90   Type:HVLI Only - Large\n   Direction: 90   Type:HVLI or Homing - Large\n   Direction: 90   Type:HVLI or EMP\n   Direction: 90   Type:HVLI Only - Large\n   Direction:180   Type:Mine Only\n   Ordnance stock and type:\n      12 Homing\n      04 Mine\n      04 EMP\n      20 HVLI\nBased on Piranha: more repair crew, shorter jump, add one turreted beam, one fewer rear facing tube, no nukes, added EMPs"},
			{"Blaire"		,"inactive"	,createPlayerShipBlaire		,"Kludge (Blaire), Corvette, Gunner... incomplete description"},
			{"Blazon"		,"inactive"	,createPlayerShipBlazon		},
			{"Cobra"		,"active"	,createPlayerShipCobra		,"Striker LX(Cobra): Starfighter, Patrol   Hull:100   Shield:100,100   Size:200   Repair Crew:3   Cargo:4   R.Strength:15\nFTL:Jump (2U - 20U)   Speeds: Impulse:65   Spin:15   Accelerate:30   C.Maneuver: Boost:250 Strafe:150   Energy:600   LRS:20   SRS:4\nBeams:2 Turreted Speed:0.2\n   Arc:100   Direction:-15   Range:1.1   Cycle:6   Damage:6.5\n   Arc:100   Direction: 15   Range:1   Cycle:6   Damage:6.5\nTubes:2 Rear:2\n   Direction:180   Type:Any\n   Direction:180   Type:Any\n   Ordnance stock and type:\n      4 Homing\n      2 Nuke\n      3 Mine\n      3 EMP\n      6 HVLI\nBased on Striker: stronger shields, more energy, jump drive (vs none), faster impulse, slower turret, two rear tubes (vs none)"},
			{"Darkstar"		,"inactive"	,createPlayerShipDarkstar	,"Destroyer IV (Darkstar) Cruiser   Hull:100   Shield:100,100   Size:400   Repair Crew:3   Cargo:5   R.Strength:25\nFTL:Jump (3U - 28U)   Speeds: Impulse:90   Spin:10   Accelerate:20   C.Maneuver: Boost:400 Strafe:250\nBeams:2 Front\n   Arc:40   Direction:-10   Range:1   Cycle:5   Damage:6\n   Arc:40   Direction: 10   Range:1   Cycle:5   Damage:6\nTubes:2   Load Speed:8  Angled Front\n   Direction:-60   Type:Exclude Mine\n   Direction: 60   Type:Exclude Mine\n   Direction:180   Type:Mine Only\n   Ordnance stock and type:\n      6 Homing\n      2 Nuke\n      4 Mine\n      3 EMP\n      6 HVLI\nBased on Player Cruiser: shorter jump drive, stronger shields, weaker hull, narrower, faster, weaker beams, angled tubes, fewer missiles, added HVLIs"},
			{"Eagle"		,"inactive"	,createPlayerShipEagle		,"Era(Eagle): Frigate, Light Transport   Hull:100   Shield:70,100   Size:200   Repair Crew:8   Cargo:14   R.Strength:14\nFTL:Warp (500)   Speeds: Impulse:60   Spin:15   Accelerate:10   C.Maneuver: Boost:250 Strafe:150   LRS:50   SRS:5\nBeams:2 1 Rear 1 Turreted Speed:0.5\n   Arc:40   Direction:180   Range:1.2   Cycle:6   Damage:6\n   Arc:270   Direction:180   Range:1.2   Cycle:6   Damage:6\nTubes:1   Load Speed:20   Rear\n   Direction:180   Type:Any\n   Ordnance stock and type:\n      3 Homing\n      1 Nuke\n      1 Mine\n      5 HVLI\nBased on Flavia P.Falcon: faster spin, 270 degree turreted beam, stronger rear shield, longer long range sensors"},
			{"Enola"		,"inactive"	,createPlayerShipEnola		,"Fray (Enola): Corvette, Popper   Hull:160   Shield:160,160   Size:200   Repair Crew:4   Cargo:5   R.Strength:22\nFTL:Jump (2U - 20U)   Speeds: Impulse:80   Spin:15   Accelerate:40   C.Maneuver: Boost:400 Strafe:250   LRS:23   SRS:4.5\nBeams:3 1 front, 2 sides Turreted speed:0.3\n   Arc:110   Direction:  0   Range:0.9   Cycle:6   Damage:4\n   Arc: 90   Direction:-90   Range:0.9   Cycle:6   Damage:4\n   Arc: 90   Direction: 90   Range:0.9   Cycle:6   Damage:4\nTubes:4 rear   Load Speed:8\n   Direction:180   Type:HVLI Only - small\n   Direction:180   Type:Homing or EMP\n   Direction:180   Type:Nuke only - Large\n   Ordnance stock and type:\n      05 Homing\n      03 Mine\n      02 Nuke\n      04 EMP\n      12 HVLI\nBased on Crucible: jump instead of warp, 3 turreted beams (weaker, more coverage), tubes facing rear, fewer missiles, large nukes, shorter sensors, fewer probes"},
			{"Falcon"		,"inactive"	,createPlayerShipFalcon		,"Eldridge (Falcon): Frigate, Mine Layer   Hull:100   Shield:100,100   Size:200   Repair Crew:4   Cargo:7   R.Strength:15\nFTL:Warp (400)   Speeds: Impulse:100   Spin:10   Accelerate:15   C.Maneuver: Boost:250 Strafe:150   LRS:24   SRS:8\nBeams:2 Broadside Turreted Speed:0.3\n   Arc:90   Direction:-90   Range:1.2   Cycle:6   Damage:6\n   Arc:90   Direction: 90   Range:1.2   Cycle:6   Damage:6\nTubes:3   Load Speed:10   2 Front, 1 Back\n   Direction:  0   Type:Homing Only\n   Direction:  0   Type:Homing Only\n   Direction:180   Type:Mine Only\n   Ordnance stock and type:\n      8 Homing\n      8 Mine\nBased on Nautilus: warp drive, two of three mine tubes converted to front homing tubes, broadside turreted beams, fewer mines, slightly longer sensors"},
			{"Gabble"		,"inactive"	,createPlayerShipGabble		,"Squid(Gabble): Frigate, Cruiser: Light Artillery   Hull:120   Shield:70,70   Size:200   Repair Crew:4   Cargo:8   R.Strength:14\nFTL:Jump (2U - 20U)   Speeds: Impulse:60   Spin:10   Accelerate:8   C.Maneuver: Boost:200 Strafe:150   LRS:25\nBeam:1 Front Turreted Speed:1\n   Arc:40   Direction:0   Range:1   Cycle:4   Damage:4\nTubes:8   Load Speed:8   Front:2   Side:4   Back:2\n   Direction:  0   Type:HVLI Only - Large\n   Direction:-90   Type:Exclude Mine\n   Direction:-90   Type:Homing Only - Large\n   Direction:  0   Type:HVLI Only - Large\n   Direction: 90   Type:Exclude Mine\n   Direction: 90   Type:Homing Only - Large\n   Direction:170   Type:Mine only\n   Direction:190   Type:Mine Only\n   Ordnance stock and type:\n      8 Homing\n      4 Nuke\n      4 Mine\n      4 EMP\n      8 HVLI\nBased on Piranha: more repair crew, shorter jump drive range, one turreted beam, two large tubes forward for HVLI, large side tubes for Homing, fewer missile type, added EMPs, shorter LRS"},
			{"Gadfly"		,"active"	,createPlayerShipGadfly		,"Gadfly: Fighter   Hull:100   Shield:80,80   Size:100   Repair Crew:3   Cargo:4   R.Strength:9\nFTL:Jump (2U - 15U)   Speeds: Impulse:110   Spin:20   Accelerate:40   C.Maneuver: Boost:600 Strafe:0   Energy:400   LRS:15   SRS:4.5\nBeams:1 Front\n   Arc:50   Direction:0   Range:0.9   Cycle:4   Damage:8\nTubes:3   2 Front, 1 Rear\n   Direction:  0   Load Speed:05   Type:HVLI Only - small\n   Direction:  0   Load Speed:10   Type:Nuke & EMP\n   Direction:180   Load Speed:15   Type:Homing Only - large\n   Ordnance stock and type:\n      4 Homing\n      1 Nuke\n      1 EMP\n      8 HVLI\nBased on Player Fighter: added jump drive, stronger hull, extra and stronger shields, fewer beams (wider, shorter, faster), missile tubes front and rear (no mines)"},
			{"Gorn"			,"inactive"	,createPlayerShipGorn		,"Proto-Atlantis(Gorn): Corvette, Destroyer   Hull:250   Shield:200,200   Size:400   Repair Crew:5   Cargo:4   R.Strength:40\nFTL:Jump (3U - 30U)   Speeds: Impulse:90   Spin:10   Accelerate:20   C.Maneuver: Boost:400 Strafe:250   LRS:28\nBeam:2 Front\n   Arc:100   Direction:-20   Range:1.5   Cycle:6   Damage:8\n   Arc:100   Direction: 20   Range:1.5   Cycle:6   Damage:8\nTubes:5   Load Speed:8   Side:4   Back:1\n   Direction:-90   Type:HVLI Only\n   Direction:-90   Type:Homing Only\n   Direction: 90   Type:HVLI Only\n   Direction: 90   Type:Homing Only\n   Direction:180   Type:Mine only\n   Ordnance stock and type:\n      12 Homing\n      08 Mine\n      20 HVLI\nBased on Atlantis: more repair crew, shorter jump drive range, hotter and more inefficient beams, fewer missile types, dedicated tubes for Homing and HVLI left and right, shorter LRS"},
			{"Guinevere"	,"inactive"	,createPlayerShipGuinevere	,"Caretaker (Guinevere): Corvette, Popper   Hull:160   Shield:100,100   Size:200   Repair Crew:4   Cargo Space:6   R.Strength:23\nFTL:Jump (4U - 40U)   Speeds: Impulse:80   Spin:15   Accelerate:40   C.Maneuver: Boost:400   Strafe:250   LRS:35   SRS:5\nBeams:2 Broadside\n   Arc:80   Direction:-90   Range:0.9   Cycle:5   Damage:6\n   Arc:80   Direction: 90   Range:0.9   Cycle:5   Damage:6\nTubes:4   Load Speed:8   Front:3   Back:1\n   Direction:  0   Type:HVLI Only - Small\n   Direction:  0   Type:EMP & Nuke & HVLI\n   Direction:  0   Type:Homing Only - Large\n   Direction:180   Type:Mine Only\n   Ordnance stock and type:\n      06 Homing\n      02 Nuke\n      03 Mine\n      03 EMP\n      24 HVLI\nBased on Crucible: jump, weaker shields, side beams, fewer tubes, fewer missiles, EMPs and Nukes in front middle tube, large homings"},
			{"Halberd"		,"inactive"	,createPlayerShipHalberd	},
			{"Headhunter"	,"inactive"	,createPlayerShipHeadhunter	},
			{"Hearken"		,"inactive"	,createPlayerShipHearken	,"Redhook (Hearken): Frigate, Cruiser: Light Artillery    Hull:120   Shield:70,70   Size:200   Repair Crew:4    Cargo:8    R.Strength:11\nFTL:Jump (2.5U - 25U)   Speeds: Impulst:60   Spin:10   Accelerate:8   C.Maneuver: Boost:200 Strafe:150   LRS:20   SRS:6\nBeams:1 Turreted Speed:0.5\n   Arc:80   Direction:0   Range:1   Cycle:4   Damage:4\nTubes:7   Load Speed:8   Side:6   Back:1\n   Direction:-90   Type:HVLI or Homing - Large\n   Direction:-90   Type:HVLI or EMP\n   Direction:-90   Type:HVLI Only - Large\n   Direction: 90   Type:HVLI or Homing - Large\n   Direction: 90   Type:HVLI or EMP\n   Direction: 90   Type:HVLI Only - Large\n   Direction:180   Type:Mine Only\n   Ordnance stock and type:\n      12 Homing\n      04 Mine\n      04 EMP\n      20 HVLI\nBased on Piranha: more repair crew, shorter jump, add one turreted beam, one fewer rear facing tube, no nukes, added EMPs"},
			{"Holmes"		,"inactive"	,createPlayerShipHolmes		,"Holmes: Corvette, Popper   Hull:160   Shield:160,160   Size:200   Repair Crew:4   Cargo Space:6   R.Strength:35\nFTL:Warp (750)   Speeds: Impulse:70   Spin:15   Accelerate:40   C.Maneuver: Boost:400 Strafe:250   LRS:35   SRS:4\nBeams:4 Broadside\n   Arc:60   Direction:-85   Range:1   Cycle:6   Damage:5\n   Arc:60   Direction:-95   Range:1   Cycle:6   Damage:5\n   Arc:60   Direction: 85   Range:1   Cycle:6   Damage:5\n   Arc:60   Direction: 95   Range:1   Cycle:6   Damage:5\nTubes:4   Load Speed:8   Front:3   Back:1\n   Direction:   0   Type:Homing Only - Small\n   Direction:   0   Type:Homing Only\n   Direction:   0   Type:Homing Only - Large\n   Direction:180   Type:Mine Only\n   Ordnance stock and type:\n      12 Homing\n      06 Mine\nBased on Crucible: Slower impulse, broadside beams, no side tubes, front tubes homing only"},
			{"Jarvis"		,"inactive"	,createPlayerShipJarvis		,"Butler (Jarvis): Corvette, Popper   Hull:100   Shield:100,100   Size:200   Repair Crew:4   Cargo Space:6   R.Strength:20\nFTL:Warp (400)   Speeds: Impulse:70   Spin:12   Accelerate:40   C.Maneuver: Boost:400   Strafe:250   LRS:30   SRS:5.5\nBeams:2 Front/Broadside\n   Arc:160   Direction:-80   Range:0.9   Cycle:6   Damage:6\n   Arc:160   Direction: 80   Range:0.9   Cycle:6   Damage:6\nTubes:4   Load Speed:8   Front:3   Back:1\n   Direction:  0   Type:HVLI Only - Small\n   Direction:  0   Type:EMP or Nuke Only\n   Direction:  0   Type:HVLI Only - Large\n   Direction:180   Type:Homing Only\n   Ordnance stock and type:\n      04 Homing\n      03 Nuke\n      04 EMP\n      24 HVLI\nBased on Crucible: Slower warp, weaker hull, weaker shields, front and side beams, fewer tubes, fewer missiles, no mines, Small Nukes, EMPs in front middle tube, large HVLI"},
			{"Jeeves"		,"inactive"	,createPlayerShipJeeves		,"Butler (Jeeves): Corvette, Popper   Hull:100   Shield:100,100   Size:200   Repair Crew:4   Cargo Space:6   R.Strength:20\nFTL:Warp (400)   Speeds: Impulse:80   Spin:15   Accelerate:40   C.Maneuver: Boost:400   Strafe:250   LRS:30   SRS:5.5\nBeams:2 Broadside\n   Arc:80   Direction:-90   Range:0.9   Cycle:6   Damage:6\n   Arc:80   Direction: 90   Range:0.9   Cycle:6   Damage:6\nTubes:4   Load Speed:8   Front:3   Back:1\n   Direction:  0   Type:Nuke Only - Small\n   Direction:  0   Type:EMP Only\n   Direction:  0   Type:Homing Only - Large\n   Direction:180   Type:Mine Only\n   Ordnance stock and type:\n      06 Homing\n      02 Nuke\n      03 Mine\n      03 EMP\n      24 HVLI\nBased on Crucible: Slower warp, weaker hull, weaker shields, side beams, fewer tubes, fewer missiles, EMPs and Nukes in front middle tube, large homings"},
			{"Knick"		,"inactive"	,createPlayerShipKnick		,"Experimental - not ready for use"},
			{"Lancelot"		,"inactive"	,createPlayerShipLancelot	,"Noble (Lancelot) Cruiser   Hull:200   Shield:80,80   Size:400   Repair Crew:5   Cargo:5   R.Strength:40   LRS:27\nFTL:Jump (3U - 30U)   Speeds: Impulse:90   Spin:10   Accelerate:20   C.Maneuver: Boost:200 Strafe:200   Energy:850\nBeams:4 NW, NE, SW, SE\n   Arc:40   Direction: -45   Range:1   Cycle:6   Damage:8\n   Arc:40   Direction:  45   Range:1   Cycle:6   Damage:8\n   Arc:40   Direction:-135   Range:1   Cycle:6   Damage:8\n   Arc:40   Direction:135   Range:1   Cycle:6   Damage:8\nTubes:4   Load Speed:8  Left, Right, Front, Rear\n   Direction:-90   Type:Exclude Mine & HVLI\n   Direction: 90   Type:Exclude Mine & HVLI\n   Direction:  0   Type:HVLI Only\n   Direction:180   Type:Mine Only\n   Ordnance stock and type:\n      8 Homing\n      4 Nuke\n      6 Mine\n      6 EMP\n      8 HVLI\nBased on Player Cruiser: shorter jump drive; less efficient, narrower, weaker, more, none overlapping beams; more tubes; fewer missiles; added HVLIs; reduced combat maneuver"},
			{"Magnum"		,"inactive"	,createPlayerShipMagnum		,"Focus (Magnum): Corvette, Popper   Hull:100   Shield:100:100   Size:200   Repair Crew:4   Cargo:4   R.Strength:35\nFTL:Jump (2.5U - 25U)   Speeds: Impulse:70   Spin:20   Accelerate:40   C.Maneuver: Boost:400 Strafe:250   LRS:32\nBeams:2 Front\n   Arc:60   Direction:-20   Range:1   Cycle:6   Damage:5\n   Arc:60   Direction: 20   Range:1   Cycle:6   Damage:5\nTubes:4   Load Speed:8 Front:3, Rear:1\n   Direction:  0   Type:HVLI only - small\n   Direction:  0   Type:HVLI only\n   Direction:  0   Type:Exclude Mine - large\n   Direction:180   Type:Mine only\n   Ordnance stock and type:\n      02 Homing\n      02 Nuke\n      02 Mine\n      02 EMP\n      24 HVLI\nBased on Crucible: short jump drive (no warp), faster impulse and spin, weaker shields and hull, narrower beams, fewer tubes, large tube accomodates nukes, EMPs and homing missiles"},
			{"Manxman"		,"inactive"	,createPlayerShipManxman	,"Nusret (Manxman): Frigate, Mine Layer   Hull:100   Shield:60,60   Size:200   Repair Crew:4   Cargo:7   R.Strength:15\nFTL:Jump (2.5U - 25U)   Speeds: Impulse:100   Spin:10   Accelerate:15   C.Maneuver: Boost:250 Strafe:150   LRS:25   SRS:4\nBeams:2 Front Turreted Speed:6\n   Arc:90   Direction: 35   Range:1   Cycle:6   Damage:6\n   Arc:90   Direction:-35   Range:1   Cycle:6   Damage:6\nTubes:3   Load Speed:10   Front Left, Front Right, Back\n   Direction:-60   Type:Homing Only\n   Direction: 60   Type:Homing Only\n   Direction:180   Type:Mine Only\n   Ordnance stock and type:\n      8 Homing\n      8 Mine\nBased on Nautilus: short jump drive, two of three mine tubes converted to angled front homing tubes, fewer mines, slightly longer sensors"},
			{"Narsil"		,"inactive"	,createPlayerShipNarsil		},
			{"Nimbus"		,"inactive"	,createPlayerShipNimbus		,"Phobos T2(Nimbus): Frigate, Cruiser   Hull:200   Shield:100,100   Size:200   Repair Crew:5   Cargo:9   R.Strength:19\nFTL:Jump (2U - 25U)   Speeds: Impulse:80   Spin:20   Accelerate:20   C.Maneuver: Boost:400 Strafe:250   LRS:25\nBeams:2 Front Turreted Speed:0.2\n   Arc:90   Direction:-15   Range:1.2   Cycle:8   Damage:6\n   Arc:90   Direction: 15   Range:1.2   Cycle:8   Damage:6\nTubes:2   Load Speed:10   Front:1   Back:1\n   Direction:  0   Type:Exclude Mine\n   Direction:180   Type:Mine Only\n   Ordnance stock and type:\n      06 Homing\n      02 Nuke\n      03 Mine\n      03 EMP\n      10 HVLI\nBased on Phobos M3P: more repair crew, short jump drive, faster spin, slow turreted beams, only one tube in front, reduced homing and HVLI storage"},
			{"Nusret"		,"active"	,createPlayerShipNusret		,"Nusret: Frigate, Mine Layer   Hull:100   Shield:100,100   Size:200   Repair Crew:6   Cargo:7   R.Strength:16\nFTL:Jump (2.5U - 25U)   Speeds: Impulse:100   Spin:10   Accelerate:15   C.Maneuver: Boost:250 Strafe:150   LRS:25   SRS:4\nBeams:3 Front 2 Turreted Speed:0.4 Front short, slow, strong\n   Arc:90   Direction: 35   Range:  1   Cycle:6   Damage:6\n   Arc:90   Direction:-35   Range:  1   Cycle:6   Damage:6\n   Arc:30   Direction:  0   Range:0.5   Cycle:8   Damage:9\nTubes:3   Front Angled Load Speed:10, Rear load speed:8\n   Direction:-60   Type:Homing Only\n   Direction: 60   Type:Homing Only\n   Direction:180   Type:Mine Only\n   Ordnance stock and type:\n      8 Homing\n      8 Mine\nBased on Nautilus: short jump drive, stronger shields, stronger hull, additional short, strong beam, two of three mine tubes converted to angled front homing tubes, fewer mines, slightly longer sensors"},
			{"Osprey"		,"inactive"	,createPlayerShipOsprey		,"Flavia 2C (Osprey): Frigate, Light Transport   Hull:100   Shield:120,120   Size:200   Repair Crew:8   Cargo:12   R.Strength:25\nFTL:Warp (500)   Speeds: Impulse:70   Spin:20   Accelerate:10   C.Maneuver: Boost:250 Strafe:150\nBeams:2 Front\n   Arc:40   Direction:-10   Range:1.2   Cycle:5.5   Damage:6.5\n   Arc:40   Direction: 10   Range:1.2   Cycle:5.5   Damage:6.5\nTubes:3   Load Speed:20   Broadside, Rear\n   Direction:-90   Type:Homing Only\n   Direction: 90   Type:Homing Only\n   Direction:180   Type:Any\n   Ordnance stock and type:\n      4 Homing\n      2 Nuke\n      2 Mine\n      2 EMP\nBased on Falvia Falcon: faster spin and impulse, stronger shields, stronger, faster forward beams, more tubes and missiles"},
			{"Outcast"		,"inactive"	,createPlayerShipOutcast	,"Scatter (Outcast): Frigate, Cruiser: Sniper   Hull:120   Shield:100,70   Size:200   Repair Crew:4   Cargo:6   R.Strength:30\nFTL:Jump (2.5U - 25U)   Speeds: Impulse:65   Spin:15   Accelerate:8   C.Maneuver: Boost:200 Strafe:150   LRS:25   SRS:5\nBeams:4   Front:3   Back:1 Turreted Speed:0.4\n   Arc: 10   Direction:0   Range:1.2   Cycle:6   Damage:4\n   Arc: 80   Direction:-20   Range:1.0   Cycle:6   Damage:4\n   Arc: 80   Direction: 20   Range:1.0   Cycle:6   Damage:4\n   Arc: 90   Direction:180   Range:1.0   Cycle:6   Damage:4\nTubes:2   Load Speed:15   Side:2\n   Direction:-90   Type:Any\n   Direction: 90   Type:Any\n   Ordnance stock and type:\n      4 Homing\n      1 Nuke\n      2 EMP\n      8 HVLI\nBased on Hathcock: shorter jump drive, more repair crew, stronger shields, faster impulse, change beams: 3 front, 1 rear"},
			{"Quicksilver"	,"inactive"	,createPlayerShipQuick		,"XR-Lindworm (Quicksilver): Starfighter, Bomber   Hull:75   Shield:90,30   Size:100   Repair Crew:2   Cargo:3   R.Strength:11\nFTL:Warp (400)   Speeds: Impulse:70   Spin:15   Accelerate:25   C.Maneuver: Boost:250 Strafe:150   Energy:400  LRS:20   SRS:6\nBeam:1 Turreted Speed:4\n   Arc:270   Direction:180   Range:0.7   Cycle:6   Damage:2\nTubes:3   Load Speed:10   Front:3 (small)\n   Direction: 0   Type:Any - small\n   Direction: 1   Type:HVLI Only - small\n   Direction:-1   Type:HVLI Only - small\n   Ordnance stock and type:\n      03 Homing\n      02 Nuke\n      03 EMP\n      12 HVLI\nBased on ZX-Lindworm: More repair crew, warp drive, nukes and EMPs, two shields: stronger in front, weaker in rear"},
			{"Raptor"		,"inactive"	,createPlayerShipRaptor		,"Destroyer IV (Raptor) Cruiser   Hull:100   Shield:100,100   Size:400   Repair Crew:3   Cargo:5   R.Strength:25\nFTL:Jump (2U - 20U)   Speeds: Impulse:90   Spin:10   Accelerate:20   C.Maneuver: Boost:400 Strafe:250\nBeams:2 Front\n   Arc:40   Direction:-10   Range:1   Cycle:5   Damage:6\n   Arc:40   Direction: 10   Range:1   Cycle:5   Damage:6\nTubes:2   Load Speed:8  Angled Front\n   Direction:-60   Type:Exclude Mine\n   Direction: 60   Type:Exclude Mine\n   Direction:180   Type:Mine Only\n   Ordnance stock and type:\n      6 Homing\n      2 Nuke\n      4 Mine\n      3 EMP\n      6 HVLI\nBased on Player Cruiser: shorter jump drive, stronger shields, weaker hull, narrower, faster, weaker beams, angled tubes, fewer missiles, added HVLIs"},
			{"Rattler"		,"inactive"	,createPlayerShipRattler	,"MX-Lindworm (Rattler): Starfighter, Bomber   Hull:75   Shield:40   Size:100   Repair Crew:2   Cargo:3   R.Strength:10\nFTL:Jump (3U - 20U)   Speeds: Impulse:85   Spin:15   Accelerate:25   C.Maneuver: Boost:250 Strafe:150   Energy:400   SRS:6\nBeam:1 Turreted Speed:1\n   Arc:270   Direction:180   Range:0.7   Cycle:6   Damage:2\nTubes:3   Load Speed:10   Front:3 (small)\n   Direction: 0   Type:Any - small\n   Direction: 1   Type:HVLI Only - small\n   Direction:-1   Type:HVLI Only - small\n   Ordnance stock and type:\n      03 Homing\n      12 HVLI\nBased on ZX-Lindworm: More repair crew, faster impulse, jump drive, slower turret"},
			{"Rogue"		,"inactive"	,createPlayerShipRogue		,"Maverick XP(Rogue): Corvette, Gunner   Hull:160   Shield:160,160   Size:200   Repair Crew:4   Cargo:5   R.Strength:23\nFTL:Jump (2U - 20U)   Speeds: Impulse:65   Spin:15   Accelerate:40   C.Maneuver: Boost:400 Strafe:250   LRS:25   SRS:6\nBeams:1 Turreted Speed:0.1   5X heat   5X energy\n   Arc:270   Direction:  0   Range:1.8   Cycle:18   Damage:18\nTubes:3   Load Speed:8   Side:2   Back:1\n   Direction:-90   Type:Exclude Mine\n   Direction: 90   Type:Exclude Mine\n   Direction:180   Type:Mine Only\n   Ordnance stock and type:\n      06 Homing\n      02 Nuke\n      02 Mine\n      04 EMP\n      10 HVLI\nBased on Maverick: slower impulse, jump (no warp), one heavy slow turreted beam (not 6 beams)"},
			{"Yorik"		,"inactive"	,createPlayerShipYorik		,"Rook (Yorik): Frigate, Armored Transport   Hull:200   Shield:200,100   Size:200   Repair Crew:8   Cargo:14   R.Strength:15\nFTL:Jump (3U-30U)   Speeds: Impulse:75   Spin:8   Accelerate:10   C.Maneuver: Boost:250 Strafe:150   LRS:41   SRS:5.5\nBeams:2 Front 1 Turreted Speed:0.15\n   Arc:90   Direction:0   Range:0.9   Cycle:6   Damage:4\n   Arc:30   Direction:0   Range:0.9   Cycle:6   Damage:4\nTubes:3   Load Speed:20   Broadside, Rear\n   Direction:-90   Type:Exclude Mine\n   Direction: 90   Type:Exclude Mine\n   Direction:180   Type:Mine only\n   Ordnance stock and type:\n      8 Homing\n      3 Nuke\n      5 Mine\n      6 EMP\n      6 HVLI\nBased on Repulse: slower spin, faster impiulse, 1 turreted beam, both beams forward, hull and shields stronger, relatively weaker rear shield, shorter and weaker beams, more missiles, stronger hull, shorter jump, longer long and short range sensors"},
			{"Simian"		,"inactive"	,createPlayerShipSimian		,"Destroyer III(Simian):   Hull:100   Shield:110,70   Size:200   Repair Crew:3   Cargo:7   R.Strength:25\nFTL:Jump (2U - 20U)   Speeds: Impulse:60   Spin:8   Accelerate:15   C.Maneuver: Boost:450 Strafe:150   LRS:20\nBeam:1 Turreted Speed:0.2\n   Arc:270   Direction:0   Range:0.8   Cycle:5   Damage:6\nTubes:5   Load Speed:8   Front:2   Side:2   Back:1\n   Direction:  0   Type:Exclude Mine\n   Direction:  0   Type:Exclude Mine\n   Direction:-90   Type:Homing Only\n   Direction: 90   Type:Homing Only\n   Direction:180   Type:Mine Only\n   Ordnance stock and type:\n      10 Homing\n      04 Nuke\n      06 Mine\n      05 EMP\n      10 HVLI\nBased on player missile cruiser: short jump drive (no warp), weaker hull, added one turreted beam, fewer tubes on side, fewer homing, nuke, EMP, mine and added HVLI"},
			{"Skray"		,"inactive"	,createplayerShipSneak      ,"Skray: Frigate, Armored Transport   Hull:120   Shield:80,80   Size:200   Repair Crew:8   Cargo:3   R.Strength:15\nFTL:Jump (5U - 50U)   Speeds: Impulse:55   Spin:9   Accelerate:10   C.Maneuver: Boost:250 Strafe:150   SRS:7.5\nBeams:2 Turreted Speed:5\n   Arc:30   Direction:-70   Range:1.2   Cycle:6   Damage:5\n   Arc:30   Direction: 70   Range:1.2   Cycle:6   Damage:5\nTubes:2   Load Speed:20   Front, Rear\n   Direction:  0   Type:Any\n   Direction:180   Type:Any\n   Ordnance stock and type:\n      10 Homing\n      10 HVLI\nBased on Repulse: more missiles, non-overlapping beams, longer short range sensors"},
			{"Sparrow"		,"inactive"	,createPlayerShipSparrow	,"Vermin (Sparrow):   Hull:60   Shield:100,60   Size:100   Repair Crew:4   Cargo:3   R.Strength:10   LRS:22   SRS:4\nFTL:Warp (400)   Speeds: Impulse:110   Spin:20   Accelerate:40   C.Maneuver: Boost:600   Energy:500   LRS:22   SRS:4\nBeam:3 Front\n   Arc:12   Direction:  0   Range:1.0   Cycle:6   Damage:4\n   Arc:40   Direction:-10   Range:0.8   Cycle:6   Damage:8\n   Arc:40   Direction: 10   Range:0.8   Cycle:6   Damage:6\nTubes:1   Load Speed:10   Rear\n   Direction:180   Type:Mine Only\n   Ordnance stock and type:\n      4 Mine\nBased on player fighter: more repair crew, more energy, warp drive, stronger shields, more beams, mine laying tube"},
			{"Phobos T2"	,"active"	,createPlayerShipPhobosT2	,"Phobos T2 (Terror)   Hull:200   Shield:120,80   Size:200   Repair Crew:4   Cargo:9   R.Strength:19   LRS:25U\nFTL:Jump (2U - 25U)   Speeds: Impulse:80   Spin:20   Accelerate:20   C.Maneuver: Boost:400 Strafe:250   Energy:800\nBeams:2 front Turreted Speed:0.2\n   Arc:40   Direction:-30   Range:1.2U   Cycle:4   Damage:6\n   Arc:40   Direction: 30   Range:1.2U   Cycle:4   Damage:6\nTubes:2   Load Speed:10   Front:1,   Rear:1\n   Direction:  0   Type:Any\n   Direction:180   Type:Mine Only\n   Ordnance stock and type:\n      08 Homing\n      02 Nuke\n      03 EMP\n      04 Mine\n      16 HVLI\nBased on Phobos M3P: More repair crew, jump drive, faster spin, stronger front shield, weaker rear shield, less maximum energy, turreted and faster beams, one fewer tube forward, fewer missiles"},
			{"Safari"		,"active"	,createPlayerShipSafari		,"Safari: Frigate, Light Transport   Hull:100   Shield:100,60   Size:200   Repair Crew:8   Cargo:10   R.Strength:15\nFTL:Warp (500)   Speeds: Impulse:60   Spin:10   Accelerate:10   C.Maneuver: Boost:250 Strafe:150   LRS:33   SRS:4.5\nBeams:2 Front 1 Turreted Speed:0.4\n   Arc:40   Direction:0   Range:1.2   Cycle:6   Damage:6\n   Arc:80   Direction:0   Range:0.6   Cycle:8   Damage:12\nTubes:3   2 small broadside load speed 8, 1 rear Load Speed:20\n   Direction:-90   Type:HVLI only - small\n   Direction: 90   Type:HVLI only - small\n   Direction:180   Type:Mine only\n   Ordnance stock and type:\n      03 Mine\n      20 HVLI\nBased on Flavia P.Falcon: front beams, one long and turreted, one short and strong, weaker rear shield, stronger front shield, small, fast broadside HVLI shooters, only mines in rear, longer long range sensors, shorter short range sensors"},
			{"Spyder"		,"inactive"	,createPlayerShipSpyder		},
			{"Stick"		,"inactive"	,createPlayerShipStick		,"Surkov (Stick): Frigate, Cruiser: Sniper   Hull:120   Shield:100,70   Size:200   Repair Crew:3   Cargo:6   R.Strength:35\nFTL:Warp (500)   Speeds: Impulse:60   Spin:15   Accelerate:8   C.Maneuver: Boost:200 Strafe:150   LRS:35   SRS:6\nBeams:4 Front\n   Arc: 4   Direction:0   Range:1.4   Cycle:6   Damage:4\n   Arc:20   Direction:0   Range:1.2   Cycle:6   Damage:4\n   Arc:60   Direction:0   Range:1.0   Cycle:6   Damage:4\n   Arc:90   Direction:0   Range:0.8   Cycle:6   Damage:4\nTubes:3   Load Speed:15   Side:2   Back:1\n   Direction:-90   Type:Homing and HVLI\n   Direction: 90   Type:Homing and HVLI\n   Direction:180   Type:Mine Only\n   Ordnance stock and type:\n      4 Homing\n      3 Mine\n      8 HVLI\nBased on Hathcock: Warp (not jump), more repair crew, stronger shields, faster impulse, add mine tube facing back, remove nukes and EMPs"},
			{"Sting"		,"inactive"	,createPlayerShipSting		,"Surkov (Sting): Frigate, Cruiser: Sniper   Hull:120   Shield:70,70   Size:200   Repair Crew:3   Cargo:6   R.Strength:35\nFTL:Warp (500)   Speeds: Impulse:60   Spin:15   Accelerate:8   C.Maneuver: Boost:200 Strafe:150   LRS:35   SRS:6\nBeams:4 Front\n   Arc: 4   Direction:0   Range:1.4   Cycle:6   Damage:4\n   Arc:20   Direction:0   Range:1.2   Cycle:6   Damage:4\n   Arc:60   Direction:0   Range:1.0   Cycle:6   Damage:4\n   Arc:90   Direction:0   Range:0.8   Cycle:6   Damage:4\nTubes:3   Load Speed:15   Side:2   Back:1\n   Direction:-90   Type:Homing and HVLI\n   Direction: 90   Type:Homing and HVLI\n   Direction:180   Type:Mine Only\n   Ordnance stock and type:\n      4 Homing\n      3 Mine\n      8 HVLI\nBased on Hathcock: Warp (not jump), more repair crew, faster impulse, add mine tube facing back, remove nukes and EMPs"},
			{"Thelonius"	,"inactive"	,createPlayerShipThelonius	,"Crab (Thelonius): Corvette, Popper   Hull:160   Shield:160,160   Size:200   Repair Crew:4   Cargo Space:6   R.Strength:20\nFTL:Warp (450)   Speeds: Impulse:80   Spin:15   Accelerate:40   C.Maneuver: Boost:400   Strafe:250   LRS:30   SRS:5.5\nBeams:2 Rear Turreted Speed:0.5\n   Arc:70   Direction:170   Range:1   Cycle:6   Damage:6\n   Arc:70   Direction:190   Range:1   Cycle:6   Damage:6\nTubes:5   Load Speed:8   Front:3   Side:2\n   Direction:  0   Type:HVLI Only - Large\n   Direction:-20   Type:Homing Only - Small\n   Direction: 20   Type:Homing Only - Small\n   Direction:-90   Type:Any\n   Direction: 90   Type:Any\n   Ordnance stock and type:\n      16 Homing\n      02 Nuke\n      03 EMP\n      10 HVLI\nBased on Crucible: Slower warp, rear turreted beams, fewer tubes, fewer missiles, except for more homing missiles, large HVLI in front, small homing in two of the front tubes"},
			{"Thunderbird"	,"inactive"	,createPlayerShipThunderbird,"Destroyer IV (Thunderbird) Cruiser   Hull:100   Shield:100,100   Size:400   Repair Crew:3   Cargo:5   R.Strength:25\nFTL:Jump (3U - 28U)   Speeds: Impulse:90   Spin:10   Accelerate:20   C.Maneuver: Boost:400 Strafe:250\nBeams:2 Front\n   Arc:40   Direction:-10   Range:1   Cycle:5   Damage:6\n   Arc:40   Direction: 10   Range:1   Cycle:5   Damage:6\nTubes:2   Load Speed:8  Angled Front\n   Direction:-60   Type:Exclude Mine\n   Direction: 60   Type:Exclude Mine\n   Direction:180   Type:Mine Only\n   Ordnance stock and type:\n      6 Homing\n      2 Nuke\n      4 Mine\n      3 EMP\n      6 HVLI\nBased on Player Cruiser: shorter jump drive, stronger shields, weaker hull, narrower, faster, weaker beams, angled tubes, fewer missiles, added HVLIs"},
			{"Vision"		,"inactive"	,createPlayerShipVision		,"Era(Vision): Frigate, Light Transport   Hull:100   Shield:70,100   Size:200   Repair Crew:8   Cargo:14   R.Strength:14\nFTL:Warp (500)   Speeds: Impulse:60   Spin:15   Accelerate:10   C.Maneuver: Boost:250 Strafe:150   LRS:50   SRS:5\nBeams:2 1 Rear 1 Turreted Speed:0.5\n   Arc:40   Direction:180   Range:1.2   Cycle:6   Damage:6\n   Arc:270   Direction:180   Range:1.2   Cycle:6   Damage:6\nTubes:1   Load Speed:20   Rear\n   Direction:180   Type:Any\n   Ordnance stock and type:\n      3 Homing\n      1 Nuke\n      1 Mine\n      5 HVLI\nBased on Flavia P.Falcon: faster spin, 270 degree turreted beam, stronger rear shield, longer long range sensors"},
			{"Wiggy"		,"inactive"	,createPlayerShipWiggy		,"Gull (Wiggy): Frigate, Light Transport   Hull:120   Shield:70,120   Size:200   Repair Crew:8   Cargo:14   R.Strength:14\nFTL:Jump (3U-30U)   Speeds: Impulse:60   Spin:12   Accelerate:10   C.Maneuver: Boost:250 Strafe:150   LRS:40   SRS:5\nBeams:2 1 Rear 1 Turreted Speed:0.5\n   Arc:40   Direction:180   Range:1.1   Cycle:6   Damage:6\n   Arc:270   Direction:180   Range:1.1   Cycle:6   Damage:6\nTubes:1   Load Speed:20   Rear\n   Direction:180   Type:Any\n   Ordnance stock and type:\n      3 Homing\n      1 Nuke\n      1 Mine\n      5 HVLI\nBased on Flavia P.Falcon: faster spin, 270 degree turreted beam, stronger rear shield, shorter beam, stronger hull, jump instead of warp, longer long range sensors"},
			{"Wombat"		,"active"	,createPlayerShipWombat		,"Wombat (Farrah): Starfighter, Bomber   Hull:100   Shield:80,80   Size:100   Repair Crew:4   Cargo:3   R.Strength:18\nFTL:Warp (400)   Speeds: Impulse:70   Spin:15   Accelerate:25   C.Maneuver: Boost:250 Strafe:150   Energy:400   LRS:18   SRS:6\nBeam:2 Turreted Speed:0.3\n   Arc:80   Direction:-20   Range:0.9   Cycle:4   Damage:3\n   Arc:80   Direction: 20   Range:0.9   Cycle:4   Damage:3\nTubes:5   Load Speed:10   Rear, 2 small, 1 large, 2 normal\n   Direction:180   Type:Only HVLI - small\n   Direction:180   Type:Only HVLI or Homing - small\n   Direction:180   Type:Only HVLI or Homing - large\n   Direction:180   Type:Only HVLI, EMP or Nuke\n   Direction:180   Type:Mine only\n   Ordnance stock and type:\n      08 Homing\n      01 Nuke\n      02 Mine\n      02 EMP\n      12 HVLI\nBased on Lindworm: stronger hull and shields, more repair crew, warp drive, stringer, longer, faster beam x2, more tubes including a large tube that fires homing and HVLI, 2 EMPs and 1 nuke added, more homing missiles"}
		}
	end
end
----------------------------------
--	Initial Set Up > Wormholes  --
----------------------------------
-- Button Text			   FD*	Related Function(s)
-- -MAIN FROM WORMHOLE		F	initialGMFunctions
-- -SETUP					F	initialSetUp
-- +ICARUS TO DEFAULT		D	setIcarusWormholeExit
function setWormholes()
	clearGMFunctions()
	addGMFunction("-Main From Wormhole",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("+Icarus to " .. wormholeIcarus.exit,setIcarusWormholeExit)
end
function setIcarusWormholeExit()
	clearGMFunctions()
	addGMFunction("-Wormhole",setWormholes)
	local icarus_label = "Default"
	if wormholeIcarus.exit == "default" then
		icarus_label = "Default*"
	end
	addGMFunction(icarus_label, function()
		wormholeIcarus.exit = "default"
		wormholeIcarus:setTargetPosition(wormholeIcarus.default_exit_point_x,wormholeIcarus.default_exit_point_y)
		setIcarusWormholeExit()
	end)
	icarus_label = "Kentar"
	if wormholeIcarus.exit == "kentar" then
		icarus_label = "Kentar*"
	end
	addGMFunction(icarus_label, function()
		wormholeIcarus.exit = "kentar"
		wormholeIcarus:setTargetPosition(wormholeIcarus.kentar_exit_point_x,wormholeIcarus.kentar_exit_point_y)
		setIcarusWormholeExit()
	end)
end
function throughWormhole(worm_hole,transportee)
	if worm_hole == wormholeIcarus then
		if worm_hole.exit == "default" then
			--exited near Icarus, near station Macassa
		end
		if worm_hole.exit == "kentar" then
			--exited near station Kentar
		end
	end
end
------------------------------
--	Initial Set Up > Zones  --
------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN FROM ZONES		F	initialGMFunctions
-- -SETUP				F	initialSetUp
-- +ADD ZONE			F	addZone
-- +DELETE ZONE			F	deleteZone (button only present if zones available to delete)
function changeZones()
	clearGMFunctions()
	addGMFunction("-Main From Zones",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("+Add Zone",addZone)
	if zone_list ~= nil and #zone_list > 0 then
		addGMFunction("+Delete Zone",deleteZone)
	end
end
--------------------------------------------------
--	Initial Set Up > Automated Station Warning  --
--------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN				F	initialGMFunctions
-- -INITIAL				F	initialSetUp
-- WARNING ON*			*	inline
-- WARNING OFF			*	inline
-- SHIP TYPE ON*		*	inline
-- SHIP TYPE OFF		*	inline
-- +PROXIMITY 30U DFLT	D	setStationSensorRange
function autoStationWarn()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Initial",initialSetUp)
	local button_label = "Warning On"
	if automated_station_danger_warning then
		button_label = string.format("%s*",button_label)
	end
	addGMFunction(button_label, function()
		automated_station_danger_warning = true
		autoStationWarn()
	end)
	button_label = "Warning Off"
	if not automated_station_danger_warning then
		button_label = string.format("%s*",button_label)
	end
	addGMFunction(button_label, function()
		automated_station_danger_warning = false
		autoStationWarn()
	end)
	button_label = "Ship Type On"
	if warning_includes_ship_type then
		button_label = string.format("%s*",button_label)
	end
	addGMFunction(button_label, function()
		warning_includes_ship_type = true
		autoStationWarn()
	end)
	button_label = "Ship Type Off"
	if not warning_includes_ship_type then
		button_label = string.format("%s*",button_label)
	end
	addGMFunction(button_label, function()
		warning_includes_ship_type = false
		autoStationWarn()
	end)
	button_label = "+Proximity"
	if server_sensor then
		--local long_range_server = getLongRangeRadarRange()
		local long_range_server = 30000
		button_label = string.format("%s %iU Dflt",button_label,long_range_server/1000)
	else
		button_label = string.format("%s %iU",button_label,station_sensor_range/1000)
	end
	addGMFunction(button_label,setStationSensorRange)
end
----------------------------------------------------------
--	Initial Set Up > Start Region > Player Spawn Point  --
----------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN				F	initialGMFunctions
-- -SETUP				F	initialSetUp
-- -FROM PLYR SPWN PT	F	setStartRegion
-- followed by all regions after that
function setDefaultPlayerSpawnPoint()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-From Plyr Spwn Pt",setStartRegion)
	for i=1,#universe.available_regions do
		local region=universe.available_regions[i]
		local has_been_created=universe:hasRegionSpawned(region)
		local button_name=region.name
		if startRegion==region.name then
			button_name=button_name .. "*"
		end
		addGMFunction(button_name, function()
			playerSpawnX=region.spawn_x
			playerSpawnY=region.spawn_y
			if not has_been_created then
				universe:spawnRegion(region)
			end
			startRegion=region.name
			setDefaultPlayerSpawnPoint()
		end)
	end
end
-----------------------------------------------
--	Initial Set Up > Start Region > Terrain  --
-----------------------------------------------
-- Button Text	   FD*	Related Function(s)
-- -MAIN			F	initialGMFunctions
-- -SETUP			F	initialSetUp
-- -FROM TERRAIN	F	setStartRegion
-- followed by all regions after that
function changeTerrain()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-From Terrain",setStartRegion)
	for i=1,#universe.available_regions do
		local region=universe.available_regions[i]
		local has_been_created=universe:hasRegionSpawned(region)
		if has_been_created then
			addGMFunction(region.name .. "*",function ()
				universe:removeRegion(region)
				changeTerrain()
			end)
		else
			addGMFunction(region.name,function ()
				universe:spawnRegion(region)
				changeTerrain()
			end)
		end
	end
end
-- Icarus area stations, asteroids, mines, etc. 
function icarusSector()
	createIcarusColor()
	local ret = {
		destroy = function(self)
			assert(type(self)=="table")
			removeIcarusColor()
			for index = #self.objects,1,-1 do
				self.objects[index]:destroy()
			end
		end,
		objects = {}
	}

	-- Ghost jump trace (from moons GM session @ 2020-07-18)
	local art=Artifact():setPosition(37333, 27778)
	update_system:addPeriodicCallback(art,
		function (self, obj)
			self:setCallSign(string.format("%.2f",450*(200*math.cos(getScenarioTimePreStandard()))))
		end
		,0.1)
	table.insert(ret.objects,art)

	return ret
end
function createIcarusColor()
	icarus_color = true
	icarusDefensePlatforms = {}
	icarusMines = {}
	icarus_artifacts = createIcarusArtifacts()
	macassaAsteroids = createMacassaAsteroids()
	aquariusAsteroids = createAquariusAsteroids()
	cindyFollyAsteroids = createCindyFollyAsteroids()
	H0_to_K2_asteroids = createH0toK2asteroids()
	H1_to_I2_mines = createH1toI2mines()
	J0_to_K0_nebulae = createJ0toK0nebulae()
	J4_to_L8_asteroids = createJ4toL8asteroids()
	J4_to_L8_nebulae = createJ4toL8nebulae()
	borlanFeatures = createBorlanFeatures()
	finneganFeatures = createFinneganFeatures()
	icarusStations = createIcarusStations()
	regionStations = icarusStations
	local icx, icy = stationIcarus:getPosition()
	local startAngle = 23
	for i=1,6 do
		local dpx, dpy = vectorFromAngle(startAngle,8000)
--		if i == 5 then
--			dp5Zone = squareZone(icx+dpx,icy+dpy,"dp5")
--			dp5Zone:setColor(0,128,0)
--		elseif i == 6 then
--			dp6Zone = squareZone(icx+dpx,icy+dpy,"dp6")
--			dp6Zone:setColor(0,128,0)
--		else		
			local dp = CpuShip():setTemplate("Defense platform"):setFaction("Human Navy"):setPosition(icx+dpx,icy+dpy):setScannedByFaction("Human Navy",true):setCallSign(string.format("DP%i",i)):setDescription(string.format("Icarus defense platform %i",i)):orderRoaming()
			station_names[dp:getCallSign()] = {dp:getSectorName(), dp}
			table.insert(icarusDefensePlatforms,dp)
--		end
		for j=1,5 do
			dpx, dpy = vectorFromAngle(startAngle+17+j*4,8000)
			local dm = Mine():setPosition(icx+dpx,icy+dpy)
			table.insert(icarusMines,dm)
		end
		startAngle = startAngle + 60
	end
	--planetBespin = Planet():setPosition(40000,5000):setPlanetRadius(3000):setDistanceFromMovementPlane(-2000):setCallSign("Donflist")
	--planetBespin:setPlanetSurfaceTexture("planets/gas-1.png"):setAxialRotationTime(300):setDescription("Mining and Gambling")
end
function removeIcarusColor()
	icarus_color = false
	if icarusDefensePlatforms ~= nil then
		for _,dp in pairs(icarusDefensePlatforms) do
			dp:destroy()
		end
	end
	icarusDefensePlatforms = nil
	if icarusMines ~= nil then
		for _,m in pairs(icarusMines) do
			m:destroy()
		end
	end
	icarusMines = nil
	if icarus_artifacts ~= nil then
		for _,ia in pairs(icarus_artifacts) do
			ia:destroy()
		end
	end
	if macassaAsteroids ~= nil then
		for _,a in pairs(macassaAsteroids) do
			a:destroy()
		end
	end
	macassaAsteroids = nil
	if aquariusAsteroids ~= nil then
		for _,a in pairs(aquariusAsteroids) do
			a:destroy()
		end
	end
	aquariusAsteroids = nil
	if cindyFollyAsteroids ~= nil then
		for _,a in pairs(cindyFollyAsteroids) do
			a:destroy()
		end
	end
	cindyFollyAsteroids = nil
	if H0_to_K2_asteroids ~= nil then
		for _,a in pairs(H0_to_K2_asteroids) do
			a:destroy()
		end
	end
	H0_to_K2_asteroids = nil
	if J4_to_L8_asteroids ~= nil then
		for _,a in pairs(J4_to_L8_asteroids) do
			a:destroy()
		end
	end
	J4_to_L8_asteroids = nil
	if H1_to_I2_mines ~= nil then
		for _,a in pairs(H1_to_I2_mines) do
			a:destroy()
		end
	end
	H1_to_I2_mines = nil
	if J0_to_K0_nebulae ~= nil then
		for _,a in pairs(J0_to_K0_nebulae) do
			a:destroy()
		end
	end
	J0_to_K0_nebulae = nil
	if J4_to_L8_nebulae ~= nil then
		for _,a in pairs(J4_to_L8_nebulae) do
			a:destroy()
		end
	end
	J4_to_L8_nebulae = nil
	if borlanFeatures ~= nil then
		for _,a in pairs(borlanFeatures) do
			a:destroy()
		end
	end
	borlanFeatures = nil
	if finneganFeatures ~= nil then
		for _,a in pairs(finneganFeatures) do
			a:destroy()
		end
	end
	finneganFeatures = nil
	if icarusStations ~= nil then
		for _,s in pairs(icarusStations) do
			s:destroy()
		end
	end
	icarusStations = nil
end
function squareZone(x,y,name)
	local zone = Zone():setPoints(x+500,y+500,x-500,y+500,x-500,y-500,x+500,y-500)
	zone.name = name
	if zone_list == nil then
		zone_list = {}
	end
	table.insert(zone_list,zone)
	return zone
end
function createIcarusStations()
	local stations = {}
	local nukeAvail = true
	local empAvail = true
	local mineAvail = true
	local homeAvail = true
	local hvliAvail = true
	local tradeFood = true
	local tradeMedicine = true
	local tradeLuxury = true
	--Aquarius F4m9 captured 11Jul2020
	local aquariusZone = squareZone(-4295, 14159, "Aquarius V F4.9")
	aquariusZone:setColor(51,153,255)
	--[[	Destroyed 5Sep2020
    stationAquarius = SpaceStation():setTemplate("Small Station"):setFaction("Independent"):setCallSign("Aquarius V"):setPosition(-4295, 14159):setDescription("Mining"):setCommsScript(""):setCommsFunction(commsStation)
    if random(1,100) <= 30 then nukeAvail = true else nukeAvail = false end
    if random(1,100) <= 50 then mineAvail = true else mineAvail = false end
    if random(1,100) <= 60 then homeAvail = true else homeAvail = false end
    if random(1,100) <= 39 then tradeMedicine = true else tradeMedicine = false end
    if random(1,100) <= 82 then tradeFood = true else tradeFood = false end
    stationAquarius.comms_data = {
    	friendlyness = 67,
        weapons = 			{Homing = "neutral",		HVLI = "neutral", 		Mine = "friend",		Nuke = "friend", 			EMP = "friend"},
        weapon_cost =		{Homing = 5,				HVLI = math.random(2,5),Mine = math.random(3,7),Nuke = math.random(12,18),	EMP = math.random(9,13) },
        weapon_available = 	{Homing = homeAvail,		HVLI = true,		Mine = mineAvail,		Nuke = nukeAvail,			EMP = true},
        service_cost = 		{supplydrop = math.random(80,120), reinforcements = math.random(123,175)},
        sensor_boost = {value = 10000, cost = 10},
        reputation_cost_multipliers = {friend = 1.0, neutral = 2.0},
        max_weapon_refill_amount = {friend = 1.0, neutral = 0.5 },
        goods = {	platinum = 	{quantity = math.random(4,8),	cost = math.random(50,80)},
        			nickel =	{quantity = math.random(6,12),	cost = math.random(45,65)}	},
        trade = {	food = tradeFood, medicine = tradeMedicine, luxury = false },
        public_relations = true,
        general_information = "Facilitate mining the nearby asteroids",
    	history = "Station named after the platinum mine on ancient Earth on the African continent"
	}
	if random(1,100) <= 72 then stationAquarius:setRestocksScanProbes(false) end
	if random(1,100) <= 61 then stationAquarius:setRepairDocked(false) end
	if random(1,100) <= 37 then stationAquarius:setSharesEnergyWithDocked(false) end
	station_names[stationAquarius:getCallSign()] = {stationAquarius:getSectorName(), stationAquarius}
	table.insert(stations,stationAquarius)
	--]]
	--Borlan
	--local borlanZone = squareZone(68808, 39300, "Borlan 2 G8")
	--borlanZone:setColor(51,153,255)
    stationBorlan = SpaceStation():setTemplate("Medium Station"):setFaction("Independent"):setCallSign("Borlan 2"):setPosition(68808, 39300):setDescription("Mining and Supply"):setCommsScript(""):setCommsFunction(commsStation)
    if random(1,100) <= 30 then nukeAvail = true else nukeAvail = false end
    if random(1,100) <= 40 then empAvail = true else empAvail = false end
    if random(1,100) <= 50 then mineAvail = true else mineAvail = false end
    if random(1,100) <= 80 then hvliAvail = true else hvliAvail = false end
    if random(1,100) <= 13 then tradeMedicine = true else tradeMedicine = false end
    stationBorlan.comms_data = {
    	friendlyness = 75,
        weapons = 			{Homing = "neutral",HVLI = "neutral", 		Mine = "neutral",		Nuke = "friend", 			EMP = "friend"},
        weapon_cost =		{Homing = 3, 		HVLI = math.random(1,2),Mine = math.random(2,5),Nuke = math.random(12,18),	EMP = math.random(9,21) },
        weapon_available = 	{Homing = true,		HVLI = hvliAvail,		Mine = mineAvail,		Nuke = nukeAvail,			EMP = empAvail},
        service_cost = 		{supplydrop = math.random(80,120), reinforcements = math.random(125,175)},
        sensor_boost = {value = 10000, cost = 5},
        reputation_cost_multipliers = {friend = 1.0, neutral = 3.0},
        max_weapon_refill_amount = {friend = 1.0, neutral = 1.0 },
        goods = {	gold = 	{quantity = math.random(1,10),	cost = math.random(60,70)},	
        			cobalt ={quantity = math.random(6,12),	cost = math.random(75,95)},
        			luxury ={quantity = math.random(2,8),	cost = math.random(55,95)} },
        trade = {	food = false, medicine = tradeMedicine, luxury = false },
        public_relations = true,
        general_information = "Mining and resupply, New and improved",
    	history = "Station success based on location and ingenuity of original builder to provide supplies for all the miners wanting to strike it rich"
	}
	if random(1,100) <= 42 then stationBorlan:setRestocksScanProbes(false) end
	if random(1,100) <= 21 then stationBorlan:setRepairDocked(false) end
	if random(1,100) <= 13 then stationBorlan:setSharesEnergyWithDocked(false) end
	station_names[stationBorlan:getCallSign()] = {stationBorlan:getSectorName(), stationBorlan}
	table.insert(stations,stationBorlan)
	--Cindy's Folly
	--local cindyZone = squareZone(81075, -1304, "Cindy's Folly 2 E9")
	--cindyZone:setColor(51,153,255)
    stationCindyFolly = SpaceStation():setTemplate("Small Station"):setFaction("Independent"):setCallSign("Cindy's Folly 2"):setPosition(81075, -1304):setDescription("Mining"):setCommsScript(""):setCommsFunction(commsStation)
    if random(1,100) <= 37 then homeAvail = true else homeAvail = false end
    if random(1,100) <= 44 then hvliAvail = true else hvliAvail = false end
    if random(1,100) <= 23 then mineAvail = true else mineAvail = false end
    if random(1,100) <= 13 then tradeLuxury = true else tradeLuxury = false end
    if random(1,100) <= 27 then tradeMedicine = true else tradeMedicine = false end
    stationCindyFolly.comms_data = {
    	friendlyness = 64,
        weapons = 			{Homing = "neutral",HVLI = "neutral", 		Mine = "neutral",		Nuke = "friend", 			EMP = "friend"},
        weapon_cost =		{Homing = 3, 		HVLI = math.random(1,4),Mine = math.random(2,7),Nuke = 30,					EMP = 20 },
        weapon_available = 	{Homing = homeAvail,HVLI = hvliAvail,		Mine = mineAvail,		Nuke = false,				EMP = false},
        service_cost = 		{supplydrop = math.random(80,120), reinforcements = math.random(125,175)},
        reputation_cost_multipliers = {friend = 1.0, neutral = 2.0},
        max_weapon_refill_amount = {friend = 1.0, neutral = 0.5 },
        goods = {	dilithium = {quantity = math.random(4,8),	cost = math.random(50,80)},
        			tritanium =	{quantity = math.random(6,12),	cost = math.random(45,65)},
        			platinum =	{quantity = math.random(6,12),	cost = math.random(45,65)}	},
        trade = {	food = false, medicine = tradeMedicine, luxury = tradeLuxury },
        public_relations = true,
        general_information = "Mine nearby asteroids",
    	history = "A mining operation often on the brink of failure due to the loss of spacecraft in the nearby black holes"
	}
	if random(1,100) <= 89 then stationCindyFolly:setRestocksScanProbes(false) end
	if random(1,100) <= 72 then stationCindyFolly:setRepairDocked(false) end
	if random(1,100) <= 13 then stationCindyFolly:setSharesEnergyWithDocked(false) end
	station_names[stationCindyFolly:getCallSign()] = {stationCindyFolly:getSectorName(), stationCindyFolly}
	table.insert(stations,stationCindyFolly)
	--Elysium F4m2.5 
	--local elysiumZone = squareZone(-7504, 1384, "Elysium 2 F4.3")
	--elysiumZone:setColor(51,153,255)
    stationElysium = SpaceStation():setTemplate("Small Station"):setFaction("Independent"):setCallSign("Elysium 2"):setPosition(-7504, 1384):setDescription("Commerce and luxury accomodations"):setCommsScript(""):setCommsFunction(commsStation)
    if random(1,100) <= 30 then nukeAvail = true else nukeAvail = false end
    if random(1,100) <= 40 then empAvail = true else empAvail = false end
    if random(1,100) <= 50 then mineAvail = true else mineAvail = false end
    if random(1,100) <= 13 then tradeLuxury = true else tradeLuxury = false end
    stationElysium.comms_data = {
    	friendlyness = 29,
        weapons = 			{Homing = "neutral",		HVLI = "neutral", 		Mine = "neutral",		Nuke = "friend", 			EMP = "neutral"},
        weapon_cost =		{Homing = math.random(3,7),	HVLI = math.random(2,5),Mine = math.random(3,7),Nuke = math.random(12,18),	EMP = math.random(9,13) },
        weapon_available = 	{Homing = true,				HVLI = true,			Mine = mineAvail,		Nuke = nukeAvail,			EMP = empAvail},
        service_cost = 		{supplydrop = math.random(80,120), reinforcements = math.random(123,175)},
        reputation_cost_multipliers = {friend = 1.0, neutral = 2.0},
        max_weapon_refill_amount = {friend = 1.0, neutral = 0.5 },
        goods = {	warp =		{quantity = math.random(2,4),	cost = math.random(80,120)},
        			cobalt =	{quantity = math.random(2,4),	cost = math.random(30,70)},	},
        trade = {	food = false, medicine = false, luxury = tradeLuxury },
        public_relations = true,
        general_information = "This is where all the wealthy species shop and stay when traveling",
    	history = "Named after a fictional station from early 21st century literature as a reminder of what can happen if people don't pay attention to what goes on in all levels of the society in which they live"
	}
	if random(1,100) <= 86 then stationElysium:setRestocksScanProbes(false) end
	if random(1,100) <= 35 then stationElysium:setRepairDocked(false) end
	if random(1,100) <= 27 then stationElysium:setSharesEnergyWithDocked(false) end
	station_names[stationElysium:getCallSign()] = {stationElysium:getSectorName(), stationElysium}
	table.insert(stations,stationElysium)
	--Finnegan
	local finneganZone = squareZone(114460, 95868, "Finnegan 2 J10")
	finneganZone:setColor(51,153,255)
	--[[	Destroyed 5Sep2020
	stationFinnegan = SpaceStation():setTemplate("Medium Station"):setFaction("Independent"):setCallSign("Finnegan 2"):setPosition(114460, 95868):setDescription("Trading, mining and manufacturing"):setCommsScript(""):setCommsFunction(commsStation)
    if random(1,100) <= 30 then nukeAvail = true else nukeAvail = false end
    if random(1,100) <= 40 then empAvail = true else empAvail = false end
    if random(1,100) <= 80 then hvliAvail = true else hvliAvail = false end
    if random(1,100) <= 63 then tradeMedicine = true else tradeMedicine = false end
    stationFinnegan.comms_data = {
    	friendlyness = 52,
        weapons = 			{Homing = "neutral",		HVLI = "neutral", 		Mine = "neutral",		Nuke = "friend", 			EMP = "friend"},
        weapon_cost =		{Homing = math.random(3,6),	HVLI = math.random(1,4),Mine = math.random(5,9),Nuke = math.random(12,18),	EMP = math.random(9,13) },
        weapon_available = 	{Homing = true,				HVLI = hvliAvail,		Mine = true,			Nuke = nukeAvail,			EMP = empAvail},
        service_cost = 		{supplydrop = math.random(80,120), reinforcements = math.random(123,175)},
        sensor_boost = {value = 10000, cost = 10},
        reputation_cost_multipliers = {friend = 1.0, neutral = 2.0},
        max_weapon_refill_amount = {friend = 1.0, neutral = 0.5 },
        goods = {	circuit = 	{quantity = math.random(4,8),	cost = math.random(40,80)},
        			nickel =	{quantity = math.random(6,12),	cost = math.random(45,65)}	},
        trade = {	food = true, medicine = tradeMedicine, luxury = false },
        public_relations = true,
        general_information = "We mine the asteroids and the nebula and use these to manufacture various specialized circuits",
    	history = "The Finnegan family set up this station here to take advantage of the readily available resources"
	}
	if random(1,100) <= 63 then stationFinnegan:setRestocksScanProbes(false) end
	if random(1,100) <= 46 then stationFinnegan:setRepairDocked(false) end
	if random(1,100) <= 25 then stationFinnegan:setSharesEnergyWithDocked(false) end
	station_names[stationFinnegan:getCallSign()] = {stationFinnegan:getSectorName(), stationFinnegan}
	table.insert(stations,stationFinnegan)
	--]]
	--Gagarin
	--local gagarinZone = squareZone(-60000, 62193, "Gagarin I2")
	--gagarinZone:setColor(0,128,0)
	stationGagarin = SpaceStation():setTemplate("Small Station"):setFaction("Human Navy"):setCallSign("Gagarin"):setPosition(-60000, 62193):setDescription("Mining and exploring"):setCommsScript(""):setCommsFunction(commsStation)
    if random(1,100) <= 30 then nukeAvail = true else nukeAvail = false end
    if random(1,100) <= 40 then empAvail = true else empAvail = false end
    if random(1,100) <= 50 then mineAvail = true else mineAvail = false end
    if random(1,100) <= 60 then homeAvail = true else homeAvail = false end
    if random(1,100) <= 80 then hvliAvail = true else hvliAvail = false end
    if random(1,100) <= 23 then tradeMedicine = true else tradeMedicine = false end
    stationGagarin.comms_data = {
    	friendlyness = 82,
        weapons = 			{Homing = "neutral",		HVLI = "neutral", 		Mine = "friend",		Nuke = "friend", 			EMP = "friend"},
        weapon_cost =		{Homing = math.random(2,6),	HVLI = math.random(2,5),Mine = math.random(3,7),Nuke = math.random(12,18),	EMP = math.random(9,13) },
        weapon_available = 	{Homing = true,				HVLI = hvliAvail,		Mine = mineAvail,		Nuke = nukeAvail,			EMP = true},
        service_cost = 		{supplydrop = math.random(80,120), reinforcements = math.random(123,175)},
        sensor_boost = {value = 10000, cost = 10},
        reputation_cost_multipliers = {friend = 1.0, neutral = 2.0},
        max_weapon_refill_amount = {friend = 1.0, neutral = 0.5 },
        goods = {	platinum = 	{quantity = math.random(4,8),	cost = math.random(50,80)},
        			nickel =	{quantity = math.random(6,12),	cost = math.random(45,65)}	},
        trade = {	food = true, medicine = tradeMedicine, luxury = false },
        public_relations = true,
        general_information = "Facilitate mining the nearby asteroids",
    	history = "Station named after the Cosmonaut from 20th century Earth"
	}
	if random(1,100) <= 16 then stationGagarin:setRestocksScanProbes(false) end
	if random(1,100) <= 25 then stationGagarin:setRepairDocked(false) end
	if random(1,100) <= 11 then stationGagarin:setSharesEnergyWithDocked(false) end
	station_names[stationGagarin:getCallSign()] = {stationGagarin:getSectorName(), stationGagarin}
	table.insert(stations,stationGagarin)
	--Macassa
	--local macassaZone = squareZone(16335, -18034, "Macassa 7 E5")
	--macassaZone:setColor(0,128,0)
    stationMacassa = SpaceStation():setTemplate("Small Station"):setFaction("Human Navy"):setPosition(16335, -18034):setCallSign("Macassa 7"):setDescription("Mining"):setCommsScript(""):setCommsFunction(commsStation)
    if random(1,100) <= 30 then nukeAvail = true else nukeAvail = false end
    if random(1,100) <= 40 then empAvail = true else empAvail = false end
    if random(1,100) <= 60 then homeAvail = true else homeAvail = false end
    if random(1,100) <= 80 then hvliAvail = true else hvliAvail = false end
    if random(1,100) <= 37 then tradeLuxury = true else tradeLuxury = false end
    if random(1,100) <= 12 then tradeFood = true else tradeFood = false end
    stationMacassa.comms_data = {
    	friendlyness = 55,
        weapons = 			{Homing = "neutral",		HVLI = "neutral", 		Mine = "friend",		Nuke = "friend", 			EMP = "friend"},
        weapon_cost =		{Homing = math.random(2,5), HVLI = math.random(1,3),Mine = math.random(2,3),Nuke = math.random(13,18),	EMP = math.random(9,13) },
        weapon_available = 	{Homing = homeAvail,		HVLI = hvliAvail,		Mine = true,			Nuke = nukeAvail,			EMP = empAvail},
        service_cost = 		{supplydrop = math.random(95,120), reinforcements = math.random(145,175)},
        sensor_boost = {value = 5000, cost = 5},
        reputation_cost_multipliers = {friend = 1.0, neutral = 2.0},
        max_weapon_refill_amount = {friend = 1.0, neutral = 0.5 },
        goods = {	gold = 	{quantity = math.random(4,8),	cost = math.random(60,70)},
        			dilithium = {quantity = math.random(2,11),	cost = math.random(55,85)}	},
        trade = {	food = tradeFood, medicine = false, luxury = tradeLuxury },
        public_relations = true,
        general_information = "Station location facilitates mining the nearby asteroids. This is the 5th time the staion has been rebuilt: 5 iterations, 9 plans, 3 years hence the name Macassa 17",
    	history = "The station was named in the hopes that the asteroids will be as productive as the Macassa mine was on Earth in the mid to late 1900s"
	}
	if random(1,100) <= 16 then stationMacassa:setRestocksScanProbes(false) end
	if random(1,100) <= 12 then stationMacassa:setRepairDocked(false) end
	if random(1,100) <= 9  then stationMacassa:setSharesEnergyWithDocked(false) end
	station_names[stationMacassa:getCallSign()] = {stationMacassa:getSectorName(), stationMacassa}
	table.insert(stations,stationMacassa)
	--Maximilian
	local maximilianZone = squareZone(-16565, -16446, "Maximilian Mark 4 E4")
	maximilianZone:setColor(51,153,255)
	--[[	Destroyed 29Aug2020
    stationMaximilian = SpaceStation():setTemplate("Small Station"):setFaction("Independent"):setCallSign("Maximilian Mark 4"):setPosition(-16565, -16446):setDescription("Black Hole Research"):setCommsScript(""):setCommsFunction(commsStation)
    if random(1,100) <= 30 then nukeAvail = true else nukeAvail = false end
    if random(1,100) <= 40 then empAvail = true else empAvail = false end
    if random(1,100) <= 50 then mineAvail = true else mineAvail = false end
    if random(1,100) <= 80 then hvliAvail = true else hvliAvail = false end
    if random(1,100) <= 39 then tradeMedicine = true else tradeMedicine = false end
    if random(1,100) <= 62 then tradeFood = true else tradeFood = false end
    stationMaximilian.comms_data = {
    	friendlyness = 43,
        weapons = 			{Homing = "neutral",		HVLI = "neutral", 		Mine = "friend",		Nuke = "friend", 			EMP = "friend"},
        weapon_cost =		{Homing = 2,				HVLI = math.random(2,3),Mine = math.random(2,3),Nuke = math.random(14,18),	EMP = math.random(9,13) },
        weapon_available = 	{Homing = true,				HVLI = hvliAvail,		Mine = mineAvail,		Nuke = nukeAvail,			EMP = empAvail},
        service_cost = 		{supplydrop = math.random(95,120), reinforcements = math.random(145,175)},
        sensor_boost = {value = 10000, cost = 10},
        reputation_cost_multipliers = {friend = 1.0, neutral = 2.0},
        max_weapon_refill_amount = {friend = 1.0, neutral = 0.5 },
        goods = {	filament = 	{quantity = math.random(4,8),	cost = math.random(50,80)}	},
        trade = {	food = tradeFood, medicine = tradeMedicine, luxury = true },
        public_relations = true,
        general_information = "Observe and measure black hole for scientific understanding purposes",
    	history = "One of the researchers also develops software and watches ancient films. He was put in charge of naming the station so he named it after a mute evil robot depicted in an old movie about a black hole from the late 1970s"
	}
	if random(1,100) <= 81 then stationMaximilian:setRestocksScanProbes(false) end
	if random(1,100) <= 68 then stationMaximilian:setRepairDocked(false) end
	if random(1,100) <= 16 then stationMaximilian:setSharesEnergyWithDocked(false) end
	station_names[stationMaximilian:getCallSign()] = {stationMaximilian:getSectorName(), stationMaximilian}
	table.insert(stations,stationMaximilian)
	--]]
	--Mermaid
	--local mermaidZone = squareZone(28889, -4417, "Mermaid 4 E6")
	--mermaidZone:setColor(51,153,255)
    stationMermaid = SpaceStation():setTemplate("Small Station"):setFaction("Independent"):setPosition(28889, -4417):setCallSign("Mermaid 4"):setDescription("Tavern and hotel"):setCommsScript(""):setCommsFunction(commsStation)
    if random(1,100) <= 30 then nukeAvail = true else nukeAvail = false end
    if random(1,100) <= 40 then empAvail = true else empAvail = false end
    if random(1,100) <= 50 then mineAvail = true else mineAvail = false end
    if random(1,100) <= 60 then homeAvail = true else homeAvail = false end
    if random(1,100) <= 80 then hvliAvail = true else hvliAvail = false end
    if random(1,100) <= 17 then tradeLuxury = true else tradeLuxury = false end
    stationMermaid.comms_data = {
    	friendlyness = 75,
        weapons = 			{Homing = "neutral",HVLI = "neutral", 		Mine = "friend",		Nuke = "friend", 			EMP = "friend"},
        weapon_cost =		{Homing = 3, 		HVLI = math.random(1,2),Mine = math.random(2,5),Nuke = math.random(12,18),	EMP = 10 },
        weapon_available = 	{Homing = homeAvail,HVLI = hvliAvail,		Mine = mineAvail,		Nuke = nukeAvail,			EMP = empAvail},
        service_cost = 		{supplydrop = math.random(80,120), reinforcements = math.random(125,175)},
        reputation_cost_multipliers = {friend = 1.0, neutral = 2.0},
        max_weapon_refill_amount = {friend = 1.0, neutral = 0.5 },
        goods = {	luxury = 	{quantity = math.random(5,10),	cost = math.random(60,70)},
        			gold = 		{quantity = 5,					cost = math.random(75,90)}	},
        trade = {	food = true, medicine = false, luxury = tradeLuxury },
        public_relations = true,
        general_information = "Rest stop, refueling and convenience shopping",
    	history = "In the tradition of taverns at crossroads on olde Earth in Kingston where the Millstone river and the Assunpink trail crossed and The Sign of the Mermaid tavern was built in the 1600s, the builders of this station speculated that this would be a good spot for space travelers to stop\n\nFree drinks for the crew of the freighter Gamma Hydra"
	}
	if random(1,100) <= 36 then stationMermaid:setRestocksScanProbes(false) end
	if random(1,100) <= 22 then stationMermaid:setRepairDocked(false) end
	if random(1,100) <= 5  then stationMermaid:setSharesEnergyWithDocked(false) end
	station_names[stationMermaid:getCallSign()] = {stationMermaid:getSectorName(), stationMermaid}
	table.insert(stations,stationMermaid)
	--Mos Espa
	--local mosEspaZone = squareZone(113941, -85822, "Mos Espa A10")
	--mosEspaZone:setColor(51,153,255)
	stationMosEspa = SpaceStation():setTemplate("Small Station"):setFaction("Independent"):setPosition(113941, -85822):setCallSign("Mos Espa"):setDescription("Resupply and Entertainment"):setCommsScript(""):setCommsFunction(commsStation)
    if random(1,100) <= 30 then nukeAvail = true else nukeAvail = false end
    if random(1,100) <= 40 then empAvail = true else empAvail = false end
    if random(1,100) <= 50 then mineAvail = true else mineAvail = false end
    if random(1,100) <= 60 then homeAvail = true else homeAvail = false end
    if random(1,100) <= 80 then hvliAvail = true else hvliAvail = false end
    if random(1,100) <= 26 then tradeFood = true else tradeFood = false end
    stationMosEspa.comms_data = {
    	friendlyness = 93,
        weapons = 			{Homing = "neutral",HVLI = "neutral", 		Mine = "neutral",		Nuke = "friend", 			EMP = "friend"},
        weapon_cost =		{Homing = 3, 		HVLI = math.random(1,2),Mine = math.random(2,5),Nuke = math.random(12,18),	EMP = 10 },
        weapon_available = 	{Homing = homeAvail,HVLI = hvliAvail,		Mine = mineAvail,		Nuke = nukeAvail,			EMP = empAvail},
        service_cost = 		{supplydrop = math.random(80,120), reinforcements = math.random(125,175)},
        reputation_cost_multipliers = {friend = 1.0, neutral = 2.0},
        max_weapon_refill_amount = {friend = 1.0, neutral = 0.5 },
        goods = {	impulse = 	{quantity = math.random(5,10),	cost = math.random(80,100)},
        			lifter = 	{quantity = 5,					cost = math.random(75,90)}	},
        trade = {	food = tradeFood, medicine = true, luxury = false },
        public_relations = true,
        general_information = "Relax, maybe observe a scheduled race",
    	history = "You will never find a more wretched hive of scum and villainy... except in Mos Eisley space port. Mos Espa is a much better place"
	}
	if random(1,100) <= 28 then stationMosEspa:setRestocksScanProbes(false) end
	if random(1,100) <= 15 then stationMosEspa:setRepairDocked(false) end
	if random(1,100) <= 12 then stationMosEspa:setSharesEnergyWithDocked(false) end
	station_names[stationMosEspa:getCallSign()] = {stationMosEspa:getSectorName(), stationMosEspa}
	table.insert(stations,stationMosEspa)
	--Nerva E4m8
	local nervaZone = squareZone(-9203, -2077, "Nerva 3 E4")
	nervaZone:setColor(51,153,255)
	--[[	Destroyed 5Sep2020
    stationNerva = SpaceStation():setTemplate("Small Station"):setFaction("Independent"):setCallSign("Nerva 3"):setPosition(-9203, -2077):setDescription("Observatory"):setCommsScript(""):setCommsFunction(commsStation)
    if random(1,100) <= 30 then nukeAvail = true else nukeAvail = false end
    if random(1,100) <= 40 then empAvail = true else empAvail = false end
    if random(1,100) <= 50 then mineAvail = true else mineAvail = false end
    if random(1,100) <= 60 then homeAvail = true else homeAvail = false end
    if random(1,100) <= 80 then hvliAvail = true else hvliAvail = false end
    if random(1,100) <= 17 then tradeLuxury = true else tradeLuxury = false end
    if random(1,100) <= 69 then tradeMedicine = true else tradeMedicine = false end
    stationNerva.comms_data = {
    	friendlyness = 75,
        weapons = 			{Homing = "neutral",HVLI = "neutral", 		Mine = "neutral",		Nuke = "friend", 			EMP = "friend"},
        weapon_cost =		{Homing = 3, 		HVLI = math.random(1,2),Mine = math.random(2,5),Nuke = math.random(12,18),	EMP = 10 },
        weapon_available = 	{Homing = homeAvail,HVLI = hvliAvail,		Mine = mineAvail,		Nuke = nukeAvail,			EMP = empAvail},
        service_cost = 		{supplydrop = math.random(80,120), reinforcements = math.random(125,175)},
        reputation_cost_multipliers = {friend = 1.0, neutral = 2.0},
        max_weapon_refill_amount = {friend = 1.0, neutral = 0.5 },
        goods = {	optic = 	{quantity = math.random(5,10),	cost = math.random(60,70)}	},
        trade = {	food = false, medicine = tradeMedicine, luxury = tradeLuxury },
        public_relations = true,
        general_information = "Observatory of stellar phenomena and space ship traffic",
    	history = "A combination of science and military staff share the various delicate instruments on this station. Originally designed to watch for incoming Kraylor and Exuari ships, other stations now share the early warning military purpose and these sensors double as research resources"
	}
	if random(1,100) <= 13 then stationNerva:setRestocksScanProbes(false) end
	if random(1,100) <= 42 then stationNerva:setRepairDocked(false) end
	if random(1,100) <= 23 then stationNerva:setSharesEnergyWithDocked(false) end
	station_names[stationNerva:getCallSign()] = {stationNerva:getSectorName(), stationNerva}
	table.insert(stations,stationNerva)
	--]]
	--Pistil
	local pistilZone = squareZone(24834, 20416, "Pistil 4 G6")
	pistilZone:setColor(0,128,0)
	--[[	Destroyed 5Sep2020
    stationPistil = SpaceStation():setTemplate("Small Station"):setFaction("Human Navy"):setPosition(24834, 20416):setCallSign("Pistil 4"):setDescription("Fleur nebula research"):setCommsScript(""):setCommsFunction(commsStation)
    if random(1,100) <= 30 then nukeAvail = true else nukeAvail = false end
    if random(1,100) <= 40 then empAvail = true else empAvail = false end
    if random(1,100) <= 60 then homeAvail = true else homeAvail = false end
    if random(1,100) <= 37 then tradeLuxury = true else tradeLuxury = false end
    stationPistil.comms_data = {
    	friendlyness = 55,
        weapons = 			{Homing = "neutral",		HVLI = "neutral", 		Mine = "friend",		Nuke = "friend", 			EMP = "friend"},
        weapon_cost =		{Homing = math.random(2,5), HVLI = math.random(1,3),Mine = math.random(2,3),Nuke = math.random(14,18),	EMP = math.random(9,13) },
        weapon_available = 	{Homing = homeAvail,		HVLI = true,			Mine = true,			Nuke = nukeAvail,			EMP = empAvail},
        service_cost = 		{supplydrop = math.random(95,120), reinforcements = math.random(145,175)},
        reputation_cost_multipliers = {friend = 1.0, neutral = 2.0},
        max_weapon_refill_amount = {friend = 1.0, neutral = 0.5 },
        goods = {	sensor = 	{quantity = math.random(4,8),	cost = math.random(60,70)}	},
        trade = {	food = false, medicine = true, luxury = tradeLuxury },
        buy =	{	robotic = math.random(40,200),
        			dilithium = math.random(40,200)	},
        public_relations = true,
        general_information = "Studying, observing, measuring the Fleur nebula",
    	history = "The station naming continued in the vein of the nebula which we study. Station personnel have started paying closer attention to readings indicating enemy vessels in the area after some stray Exuari got past the defensive patrols and destroyed the station."
	}
	if random(1,100) <= 4  then stationPistil:setRestocksScanProbes(false) end
	if random(1,100) <= 11 then stationPistil:setRepairDocked(false) end
	if random(1,100) <= 8  then stationPistil:setSharesEnergyWithDocked(false) end
	station_names[stationPistil:getCallSign()] = {stationPistil:getSectorName(), stationPistil}
	table.insert(stations,stationPistil)
	--]]
	--Relay-13
	local relay13Zone = squareZone(77918, 23876, "Relay-13 D G8")
	relay13Zone:setColor(0,255,0)
	--[[	Destroyed 29Aug2020
    stationRelay13 = SpaceStation():setTemplate("Small Station"):setFaction("Human Navy"):setCallSign("Relay-13 D"):setPosition(77918, 23876):setDescription("Communications Relay"):setCommsScript(""):setCommsFunction(commsStation)
    if random(1,100) <= 69 then tradeMedicine = true else tradeMedicine = false end
    stationRelay13.comms_data = {
    	friendlyness = 75,
        weapons = 			{Homing = "neutral",HVLI = "neutral", 		Mine = "neutral",		Nuke = "friend", 			EMP = "friend"},
        weapon_cost =		{Homing = 3, 		HVLI = math.random(1,5),Mine = math.random(2,5),Nuke = math.random(12,18),	EMP = 10 },
        weapon_available = 	{Homing = false,	HVLI = true,		Mine = false,			Nuke = false,				EMP = false},
        service_cost = 		{supplydrop = math.random(80,120), reinforcements = math.random(125,175)},
        sensor_boost = {value = 5000, cost = 5},
        reputation_cost_multipliers = {friend = 1.0, neutral = 2.0},
        max_weapon_refill_amount = {friend = 1.0, neutral = 0.5 },
        goods = {	communication = {quantity = math.random(5,10),	cost = math.random(40,70)}	},
        trade = {	food = false, medicine = tradeMedicine, luxury = false },
        public_relations = true,
        general_information = "Communication traffic relay and coordination"
	}
	if random(1,100) <= 22 then stationRelay13:setRestocksScanProbes(false) end
	if random(1,100) <= 11 then stationRelay13:setRepairDocked(false) end
	if random(1,100) <= 3  then stationRelay13:setSharesEnergyWithDocked(false) end
	station_names[stationRelay13:getCallSign()] = {stationRelay13:getSectorName(), stationRelay13}
	table.insert(stations,stationRelay13)
	--]]
	--Slurry
	--local slurryZone = squareZone(100342, 27871, "Slurry V G10")
	--slurryZone:setColor(51,153,255)
    stationSlurry = SpaceStation():setTemplate("Small Station"):setFaction("Independent"):setCallSign("Slurry V"):setPosition(100342, 27871):setDescription("Mining Research"):setCommsScript(""):setCommsFunction(commsStation)
    if random(1,100) <= 30 then nukeAvail = true else nukeAvail = false end
    if random(1,100) <= 40 then empAvail = true else empAvail = false end
    if random(1,100) <= 50 then mineAvail = true else mineAvail = false end
    if random(1,100) <= 60 then homeAvail = true else homeAvail = false end
    if random(1,100) <= 80 then hvliAvail = true else hvliAvail = false end
    if random(1,100) <= 17 then tradeLuxury = true else tradeLuxury = false end
    if random(1,100) <= 57 then tradeMedicine = true else tradeMedicine = false end
    stationSlurry.comms_data = {
    	friendlyness = 75,
        weapons = 			{Homing = "neutral",		HVLI = "neutral", 		Mine = "neutral",		Nuke = "friend", 			EMP = "friend"},
        weapon_cost =		{Homing = math.random(1,5),	HVLI = math.random(1,2),Mine = math.random(2,5),Nuke = math.random(12,18),	EMP = math.random(11,17) },
        weapon_available = 	{Homing = homeAvail,		HVLI = hvliAvail,		Mine = mineAvail,		Nuke = nukeAvail,			EMP = empAvail},
        service_cost = 		{supplydrop = math.random(80,120), reinforcements = math.random(125,175)},
        reputation_cost_multipliers = {friend = 1.0, neutral = 2.0},
        max_weapon_refill_amount = {friend = 1.0, neutral = 0.5 },
        goods = {	tractor = 	{quantity = math.random(5,10),	cost = math.random(60,70)}	},
        trade = {	food = false, medicine = tradeMedicine, luxury = tradeLuxury },
        public_relations = true,
        general_information = "Mining and research of neaby stellar phenomena",
    	history = "Joint effort between miners and scientists to establish station to research and to provide resources to support research"
	}
	if random(1,100) <= 43 then stationSlurry:setRestocksScanProbes(false) end
	if random(1,100) <= 34 then stationSlurry:setRepairDocked(false) end
	if random(1,100) <= 26 then stationSlurry:setSharesEnergyWithDocked(false) end
	station_names[stationSlurry:getCallSign()] = {stationSlurry:getSectorName(), stationSlurry}
	table.insert(stations,stationSlurry)
	--Sovinec
	--local sovinecZone = squareZone(134167, 104690, "Sovinec Two K11")
	--sovinecZone:setColor(51,153,255)
	stationSovinec = SpaceStation():setTemplate("Small Station"):setFaction("Independent"):setCallSign("Sovinec Two"):setPosition(134167, 104690):setDescription("Beam component research and manufacturing"):setCommsScript(""):setCommsFunction(commsStation)
    if random(1,100) <= 30 then nukeAvail = true else nukeAvail = false end
    if random(1,100) <= 60 then homeAvail = true else homeAvail = false end
    if random(1,100) <= 50 then mineAvail = true else mineAvail = false end
    if random(1,100) <= 40 then empAvail = true else empAvail = false end
    if random(1,100) <= 37 then tradeMedicine = true else tradeMedicine = false end
    if random(1,100) <= 37 then tradeLuxury = true else tradeLuxury = false end
    stationSovinec.comms_data = {
    	friendlyness = 62,
        weapons = 			{Homing = "neutral",		HVLI = "neutral", 		Mine = "friend",		Nuke = "friend", 			EMP = "friend"},
        weapon_cost =		{Homing = math.random(2,6),	HVLI = math.random(1,4),Mine = math.random(2,7),Nuke = math.random(12,18),	EMP = math.random(9,13) },
        weapon_available = 	{Homing = homeAvail,		HVLI = true,			Mine = mineAvail,		Nuke = nukeAvail,			EMP = empAvail},
        service_cost = 		{supplydrop = math.random(80,120), reinforcements = math.random(123,175)},
        reputation_cost_multipliers = {friend = 1.0, neutral = 2.0},
        max_weapon_refill_amount = {friend = 1.0, neutral = 0.5 },
        goods = {	beam =	 	{quantity = math.random(4,8),	cost = math.random(40,80)},
        			tritanium =	{quantity = math.random(6,12),	cost = math.random(45,65)}	},
        trade = {	food = false, medicine = tradeMedicine, luxury = tradeLuxury },
        public_relations = true,
        general_information = "We manufacture beam components from the resources gathered from the nearby asteroids. We specialize in plasma based beam systems",
    	history = "Our station recognizes Sovinec, an early computer simulation researcher in plasma based weaponry in the late 20th century on Earth"
	}
	if random(1,100) <= 63 then stationSovinec:setRestocksScanProbes(false) end
	if random(1,100) <= 34 then stationSovinec:setRepairDocked(false) end
	if random(1,100) <= 11 then stationSovinec:setSharesEnergyWithDocked(false) end
	station_names[stationSovinec:getCallSign()] = {stationSovinec:getSectorName(), stationSovinec}
	table.insert(stations,stationSovinec)	
	--Speculator
	--local speculatorZone = squareZone(55000,108000, "Speculator K7")
	--speculatorZone:setColor(51,153,255)
    stationSpeculator = SpaceStation():setTemplate("Small Station"):setFaction("Human Navy"):setCallSign("Speculator"):setPosition(55000,108000):setDescription("Mining and mobile nebula research"):setCommsScript(""):setCommsFunction(commsStation)
    if random(1,100) <= 30 then nukeAvail = true else nukeAvail = false end
    if random(1,100) <= 40 then empAvail = true else empAvail = false end
    if random(1,100) <= 50 then mineAvail = true else mineAvail = false end
    if random(1,100) <= 13 then tradeMedicine = true else tradeMedicine = false end
    stationSpeculator.comms_data = {
    	friendlyness = 82,
        weapons = 			{Homing = "neutral",HVLI = "neutral", 		Mine = "neutral",		Nuke = "friend", 			EMP = "friend"},
        weapon_cost =		{Homing = 2, 		HVLI = math.random(1,4),Mine = math.random(2,7),Nuke = math.random(10,18),	EMP = math.random(7,15) },
        weapon_available = 	{Homing = true,		HVLI = true,			Mine = mineAvail,		Nuke = nukeAvail,			EMP = empAvail},
        service_cost = 		{supplydrop = math.random(80,120), reinforcements = math.random(125,175)},
        sensor_boost = {value = 10000, cost = 20},
        reputation_cost_multipliers = {friend = 1.0, neutral = 3.0},
        max_weapon_refill_amount = {friend = 1.0, neutral = 1.0 },
        goods = {	nickel = 	{quantity = math.random(1,10),	cost = math.random(60,70)},	
        			dilithium =	{quantity = math.random(6,12),	cost = math.random(75,95)},
        			tritanium =	{quantity = math.random(2,8),	cost = math.random(45,85)} },
        trade = {	food = false, medicine = tradeMedicine, luxury = true },
        public_relations = true,
        general_information = "Mining operations are the primary purpose, but there are scientists here conducting research on the mobile nebula in the area",
    	history = "A consorium of mining interests and scientists banded together to create this station. It was considered a risk for both groups, but they undertook it anyway."
	}
	if random(1,100) <= 13 then stationSpeculator:setRestocksScanProbes(false) end
	if random(1,100) <= 24 then stationSpeculator:setRepairDocked(false) end
	if random(1,100) <= 11 then stationSpeculator:setSharesEnergyWithDocked(false) end
	station_names[stationSpeculator:getCallSign()] = {stationSpeculator:getSectorName(), stationSpeculator}
	table.insert(stations,stationSpeculator)
	--Stromboli
	--local stromboliZone = squareZone(109555, 12685, "Stromboli 3 F10")
	--stromboliZone:setColor(51,153,255)
    stationStromboli = SpaceStation():setTemplate("Small Station"):setFaction("Independent"):setCallSign("Stromboli 3"):setPosition(109555, 12685):setDescription("Vacation getaway for Stromboli family"):setCommsScript(""):setCommsFunction(commsStation)
    if random(1,100) <= 30 then nukeAvail = true else nukeAvail = false end
    if random(1,100) <= 40 then empAvail = true else empAvail = false end
    if random(1,100) <= 50 then mineAvail = true else mineAvail = false end
    if random(1,100) <= 60 then homeAvail = true else homeAvail = false end
    if random(1,100) <= 80 then hvliAvail = true else hvliAvail = false end
    if random(1,100) <= 23 then tradeMedicine = true else tradeMedicine = false end
    stationStromboli.comms_data = {
    	friendlyness = 35,
        weapons = 			{Homing = "neutral",HVLI = "neutral", 		Mine = "neutral",		Nuke = "friend", 			EMP = "friend"},
        weapon_cost =		{Homing = 3, 		HVLI = math.random(1,2),Mine = math.random(2,5),Nuke = math.random(12,18),	EMP = 10 },
        weapon_available = 	{Homing = homeAvail,HVLI = hvliAvail,		Mine = mineAvail,		Nuke = nukeAvail,			EMP = empAvail},
        service_cost = 		{supplydrop = math.random(80,120), reinforcements = math.random(125,175)},
        sensor_boost = {value = 5000, cost = 5},
        reputation_cost_multipliers = {friend = 2.0, neutral = 4.0},
        max_weapon_refill_amount = {friend = 1.0, neutral = 0.5 },
        goods = {	luxury = 	{quantity = math.random(5,10),	cost = math.random(60,70)}	},
        trade = {	food = false, medicine = tradeMedicine, luxury = false },
        public_relations = true,
        general_information = "A remote station location for the Stromboli family and gusts to get away from the pressures of modern life",
    	history = "The Stromboli family picked this station up cheap from the Human Navy when this sector was practically empty. Now it serves as a nice place for the family to escape to when they are stressed out"
	}
	if random(1,100) <= 53 then stationStromboli:setRestocksScanProbes(false) end
	if random(1,100) <= 17 then stationStromboli:setRepairDocked(false) end
	if random(1,100) <= 11 then stationStromboli:setSharesEnergyWithDocked(false) end
	station_names[stationStromboli:getCallSign()] = {stationStromboli:getSectorName(), stationStromboli}
	table.insert(stations,stationStromboli)
	--Transylvania
	--local transylvaniaZone = squareZone(-95000, 111000, "Transylvania K0")
	--transylvaniaZone:setColor(51,153,255)
    stationTransylvania = SpaceStation():setTemplate("Medium Station"):setFaction("Independent"):setCallSign("Transylvania"):setPosition(-95000, 111000):setDescription("Abandoned science station turned haven"):setCommsScript(""):setCommsFunction(commsStation)
    if random(1,100) <= 30 then nukeAvail = true else nukeAvail = false end
    if random(1,100) <= 40 then empAvail = true else empAvail = false end
    if random(1,100) <= 50 then mineAvail = true else mineAvail = false end
    if random(1,100) <= 60 then homeAvail = true else homeAvail = false end
    if random(1,100) <= 80 then hvliAvail = true else hvliAvail = false end
    if random(1,100) <= 23 then tradeFood = true else tradeFood = false end
    stationTransylvania.comms_data = {
    	friendlyness = 35,
        weapons = 			{Homing = "neutral",HVLI = "neutral", 		Mine = "neutral",		Nuke = "friend", 			EMP = "friend"},
        weapon_cost =		{Homing = 3, 		HVLI = math.random(1,2),Mine = math.random(2,5),Nuke = math.random(12,18),	EMP = 10 },
        weapon_available = 	{Homing = homeAvail,HVLI = hvliAvail,		Mine = mineAvail,		Nuke = nukeAvail,			EMP = empAvail},
        service_cost = 		{supplydrop = math.random(80,120), reinforcements = math.random(125,175)},
        sensor_boost = {value = 5000, cost = 5},
        reputation_cost_multipliers = {friend = 2.0, neutral = 4.0},
        max_weapon_refill_amount = {friend = 1.0, neutral = 0.5 },
        goods = {	luxury = 	{quantity = math.random(5,10),	cost = math.random(60,70)},
        			medicine =	{quantity = math.random(5,10),	cost = math.random(5,10)}	},
        trade = {	food = tradeFood, medicine = false, luxury = false },
        public_relations = true,
        general_information = "Transylvania is a refuge from those who would prejudge our cultural practices",
    	history = "Originally a science station, now it caters to a group of persecuted beings whose cultural practices offend a number of other species"
	}
	local leechAZone = squareZone(-93000,109000, "Leech A K0")
	leechAZone:setColor(51,153,255)
	local leechABZone = squareZone(-97000,109000, "Leech AB K0")
	leechABZone:setColor(51,153,255)
	local leechBZone = squareZone(-93000,113000, "Leech B K0")
	leechBZone:setColor(51,153,255)
	local leechOZone = squareZone(-97000,113000, "Leech O K0")
	leechOZone:setColor(51,153,255)
	--[[	Destroyed 29Aug2020
	leechA = leech("Independent")
	leechA:setPosition(-93000,109000):setScannedByFaction("Human Navy",true):setCallSign("A"):setDescription("Leech satellite A")
	leechAB = leech("Independent")
	leechAB:setPosition(-97000,109000):setScannedByFaction("Human Navy",true):setCallSign("AB"):setDescription("Leech satellite AB")
	leechB = leech("Independent")
	leechB:setPosition(-93000,113000):setScannedByFaction("Human Navy",true):setCallSign("B"):setDescription("Leech satellite B")
	leechO = leech("Independent")
	leechO:setPosition(-97000,113000):setScannedByFaction("Human Navy",true):setCallSign("O"):setDescription("Leech satellite O")
	table.insert(stations,leechA)
	table.insert(stations,leechAB)
	table.insert(stations,leechB)
	table.insert(stations,leechO)
	--]]
	if random(1,100) <= 43 then stationTransylvania:setRestocksScanProbes(false) end
	if random(1,100) <= 27 then stationTransylvania:setRepairDocked(false) end
	if random(1,100) <= 21 then stationTransylvania:setSharesEnergyWithDocked(false) end
	station_names[stationTransylvania:getCallSign()] = {stationTransylvania:getSectorName(), stationTransylvania}
	table.insert(stations,stationTransylvania)
	--Wookie F4m5 
	--local wookieZone = squareZone(-11280, 7425, "Wookie-oka F4")	-- -oka means 4
	--wookieZone:setColor(51,153,255)
    stationWookie = SpaceStation():setTemplate("Small Station"):setFaction("Independent"):setCallSign("Wookie-oka"):setPosition(-11280, 7425):setDescription("Esoteric Xenolinguistic Research"):setCommsScript(""):setCommsFunction(commsStation)
    if random(1,100) <= 30 then nukeAvail = true else nukeAvail = false end
    if random(1,100) <= 50 then mineAvail = true else mineAvail = false end
    if random(1,100) <= 60 then homeAvail = true else homeAvail = false end
    if random(1,100) <= 80 then hvliAvail = true else hvliAvail = false end
    if random(1,100) <= 39 then tradeMedicine = true else tradeMedicine = false end
    stationWookie.comms_data = {
    	friendlyness = 76,
        weapons = 			{Homing = "neutral",		HVLI = "neutral", 		Mine = "neutral",		Nuke = "friend", 			EMP = "friend"},
        weapon_cost =		{Homing = math.random(3,7),	HVLI = math.random(2,5),Mine = math.random(3,7),Nuke = math.random(12,18),	EMP = math.random(9,13) },
        weapon_available = 	{Homing = true,				HVLI = hvliAvail,		Mine = mineAvail,		Nuke = nukeAvail,			EMP = true},
        service_cost = 		{supplydrop = math.random(80,120), reinforcements = math.random(123,175)},
        reputation_cost_multipliers = {friend = 1.0, neutral = 2.0},
        max_weapon_refill_amount = {friend = 1.0, neutral = 0.5 },
        goods = {	software = 	{quantity = math.random(4,8),	cost = math.random(80,90)}	},
        trade = {	food = false, medicine = tradeMedicine, luxury = false },
        public_relations = true,
        general_information = "Researchers here study the Wookie language as well as several other languages of intelligent species. -Oka is a Wookie language suffix meaning 4",
    	history = "The first language studied when the station was founded was Wookie. Wookie language and culture is still a major focus of study"
	}
	if random(1,100) <= 83 then stationWookie:setRestocksScanProbes(false) end
	if random(1,100) <= 47 then stationWookie:setRepairDocked(false) end
	if random(1,100) <= 28 then stationWookie:setSharesEnergyWithDocked(false) end
	station_names[stationWookie:getCallSign()] = {stationWookie:getSectorName(), stationWookie}
	table.insert(stations,stationWookie)
	return stations
end
function createIcarusArtifacts()
	local artifact_list = {}
	local artifact_details = {
	--						Scan Parameters				Descriptions
	--		  x,		 y, complex, depth,	     model,				unscanned,	scanned
		{-47187,	112576,		  1,	 1,	"ammo_box",	"unusual mechanism",	"photonic radiation barrier"}	
	}
	for i=1,#artifact_details do
		local static_artifact = Artifact():setPosition(artifact_details[i][1],artifact_details[i][2]):setScanningParameters(artifact_details[i][3],artifact_details[i][4]):setModel(artifact_details[i][5]):setDescriptions(artifact_details[i][6],artifact_details[i][7])
		table.insert(artifact_list,static_artifact)
	end
	return artifact_list
end
function createAquariusAsteroids()
	local asteroidList = {}
	local asteroidCoordinates = {
    {-645, 12145, 120},
    {-79, 13907, 50},
    {-1274, 14914, 20},
    {-2722, 13026, 160},
    {-2848, 14536, 230},
    {-1778, 19256, 13},
    {-834, 16487, 34},
    {-3414, 16676, 65},
    {-5176, 15480, 176},
    {-10588, 4342, 310},
    {-11846, 2391, 450},
    {-8196, 7929, 23},
    {-8700, 5789, 65},
    {-5805, 9817, 87},
    {-5931, 6481, 150},
    {-9833, 2391, 240},
    {-3540, 11704, 140},
    {-4735, 8181, 120},
    {-7064, 10509, 25},
    {-5428, 12711, 18},
    {1494, 16424, 43},
    {1809, 13403, 98} }
    for i=1,#asteroidCoordinates do
    	local staticAsteroid = Asteroid():setPosition(asteroidCoordinates[i][1],asteroidCoordinates[i][2]):setSize(asteroidCoordinates[i][3])
    	table.insert(asteroidList,staticAsteroid)
    end
    return asteroidList
end
function createMacassaAsteroids()
	local asteroidList = {}
	local asteroidCoordinates = {
    {15070, -15621, 120},
    {14714, -16096, 87},
    {13923, -16175, 165},
    {14239, -18864, 109},
    {14833, -16610, 78},
    {16612, -18745, 12},
    {17245, -18508, 14},
    {17878, -17717, 44},
    {16850, -17361, 54},
    {9296,  -20011, 187},
    {11194, -19932, 177},
    {10997, -24005, 56},
    {13330, -23135, 77},
    {13448, -21870, 154},
    {8268,  -22819, 210},
    {10838, -22107, 165},
    {12302, -21118, 254},
    {13844, -17322, 143},
    {12381, -16926, 286},
    {14319, -15384, 23},
    {12658, -15582, 97},
    {14714, -20762, 144},
    {13607, -20248, 244},
    {12737, -19536, 344},
    {11432, -18310, 187},
    {12934, -18231, 266},
    {17087, -19615, 43},
    {15703, -19892, 32},
    {16019, -20723, 15},
    {14912, -19101, 33},
    {15505, -17954, 78},
    {15900, -16926, 88},
    {15980, -16373, 117},
    {16652, -16254, 376},
    {19776, -16214, 243},
    {19578, -17045, 333},
    {18629, -16728, 129},
    {17370, -16617, 32},
    {6844,  -19813, 44},
    {8070,  -17757, 23},
    {11590, -16214, 70},
    {16177, -14237, 188},
    {18352, -13406, 255},
    {10759, -17045, 123},
    {9494,  -17875, 438},
    {18036, -16056, 181},
    {17296, -15873, 65},
    {18985, -9293, 134},
    {19737, -10440, 223},
    {18273, -12418, 267},
    {18511, -11825, 312},
    {26737, -9768, 289},
    {27172, -10875, 165},
    {25076, -10084, 32},
    {25194, -8463, 43},
    {25392, -11825, 132},
    {25827, -13644, 412},
    {23968, -12892, 357},
    {24482, -14514, 120},
    {21991, -11666, 178},
    {23454, -14791, 31},
    {22544, -13486, 87},
    {23731, -10757, 98},
    {22979, -12022, 213},
    {19222, -12497, 27},
    {19776, -13367, 89},
    {20092, -15621, 278},
    {19737, -14276, 178},
    {23019, -8740, 112},
    {22070, -8898, 159},
    {20528, -8858, 329},
    {20923, -10164, 398},
    {21872, -10638, 12},
    {20607, -11825, 17},
    {21081, -13130, 24},
    {22149, -15265, 42},
    {21239, -14514, 32},
    {20923, -15582, 78},
    {17364, -14000, 31},
    {17799, -14632, 42},
    {17957, -15107, 67},
    {17047, -15265, 43},
    {18787, -15582, 158},
    {19104, -15107, 228},
    {17601, -12932, 143},
    {18867, -13802, 210},
    {17364, -15067, 132},
    {16929, -14791, 166},
    {16494, -14870, 187},
    {16254, -15724, 188},
    {15821, -15067, 32},
    {15584, -15948, 332}	}
    for i=1,#asteroidCoordinates do
    	local staticAsteroid = Asteroid():setPosition(asteroidCoordinates[i][1],asteroidCoordinates[i][2]):setSize(asteroidCoordinates[i][3])
    	table.insert(asteroidList,staticAsteroid)
    end
    return asteroidList
end
function createCindyFollyAsteroids()
	local asteroidList = {}
	local asteroidCoordinates = {
    {81362, 1207, 120},
    {83658, 2211, 32},
    {83801, 1351, 254},
    {81003, -3528, 160},
    {79497, -4604, 12},
    {82725, -586, 44},
    {81434, -371, 87},
    {82438, 1566, 378},
    {83012, 705, 221},
    {79999, -3026, 109},
    {78349, -3815, 387},
    {82008, -1806, 32},
    {80501, -2021, 21},
    {78851, -2380, 38},
    {77416, -3241, 23} }
    for i=1,#asteroidCoordinates do
    	local staticAsteroid = Asteroid():setPosition(asteroidCoordinates[i][1],asteroidCoordinates[i][2]):setSize(asteroidCoordinates[i][3])
    	table.insert(asteroidList,staticAsteroid)
    end
    return asteroidList
end
function createH0toK2asteroids()
	local asteroidList = {}
	local asteroidCoordinates = {
    {-55790, 57467, 120},
    {-55506, 51890, 220},
    {-58720, 50095, 160},
    {-57585, 53875, 110},
    {-45676, 57183, 180},
    {-49362, 52363, 20},
    {-51064, 45747, 40},
    {-53994, 41871, 270},
    {-57869, 44896, 190},
    {-52481, 49149, 140},
    {-55979, 47164, 180},
    {-47188, 49433, 260},
    {-44447, 53214, 60},
    {-51820, 58129, 335},
    {-53805, 58696, 25},
    {-53805, 56238, 165},
    {-48984, 56805, 185},
    {-50024, 59546, 195},
    {-48890, 61815, 115},
    {-51253, 60870, 45},
    {-41423, 61909, 55},
    {-42557, 64461, 95},
    {-42084, 69093, 15},
    {-42273, 58412, 245},
    {-53143, 54253, 355},
    {-55033, 54631, 155},
    {-51158, 55766, 165},
    {-57207, 55388, 45},
    {-47566, 59924, 75},
    {-45582, 61626, 25},
    {-47945, 64461, 35},
    {-45676, 66824, 85},
    {-48039, 67297, 145},
    {-50024, 65690, 175},
    {-59665, 57372, 225},
    {-61366, 57467, 325},
    {-52670, 63422, 425},
    {-51253, 63989, 225},
    {-61461, 40359, 175},
    {-65241, 41777, 165},
    {-62028, 44802, 145},
    {-66943, 45936, 15},
    {-73559, 41871, 45},
    {-69778, 43006, 25},
    {-69022, 40832, 45},
    {-64674, 49244, 35},
    {-62028, 48866, 175},
    {-65336, 51890, 175},
    {-63067, 52363, 185},
    {-61555, 58507, 185},
    {-55317, 59641, 220},
    {-53332, 60302, 230},
    {-52387, 65690, 270},
    {-57680, 58696, 260},
    {-59570, 54159, 270},
    {-60893, 52646, 210},
    {-61461, 55766, 200},
    {-61933, 53592, 250},
    {-62973, 54442, 263},
    {-58814, 56522, 323},
    {-62595, 57278, 123},
    {-71763, 68904, 283},
    {-71952, 65595, 293},
    {-69211, 65690, 133},
    {-67510, 67202, 183},
    {-69022, 67675, 263},
    {-67037, 64745, 233},
    {-65147, 65595, 153},
    {-64107, 63233, 23},
    {-62784, 63327, 53},
    {-69022, 58223, 63},
    {-68644, 60491, 323},
    {-69211, 63233, 83},
    {-66470, 62665, 23},
    {-61461, 64272, 43},
    {-63162, 60491, 93},
    {-60515, 58790, 223},
    {-71385, 62382, 363},
    {-71574, 59452, 43},
    {-73559, 53970, 83},
    {-72519, 56616, 173},
    {-66565, 55766, 153},
    {-70251, 56144, 133},
    {-68549, 55577, 193},
    {-66659, 57750, 283},
    {-67132, 60208, 313},
    {-65052, 54631, 383},
    {-63635, 57089, 123},
    {-63635, 58601, 143},
    {-65336, 62193, 173},
    {-64013, 61909, 73},
    {-64863, 57940, 43},
    {-64580, 56427, 23},
    {-65052, 60681, 53},
    {-78285, 50284, 283},
    {-75166, 46881, 13},
    {-72141, 47070, 13},
    {-70818, 50473, 12},
    {-74126, 50662, 23},
    {-68171, 50756, 20},
    {-69589, 53592, 50},
    {-67793, 53119, 320},
    {-53489, 115865, 158},
    {-49845, 116259, 248},
    {-47089, 112517, 258},
    {-53390, 111927, 228},
    {-51322, 108087, 248},
    {-58116, 110745, 158},
    {-56246, 106610, 58},
    {-62252, 104148, 318},
    {-49268, 78922, 167},
    {-47283, 83365, 137},
    {-46716, 79584, 127},
    {-46054, 75992, 197},
    {-40572, 73535, 67},
    {-44353, 73913, 47},
    {-48959, 88099, 16},
    {-50929, 91939, 137},
    {-53616, 86200, 267},
    {-48565, 99225, 237},
    {-53685, 102474, 32},
    {-52012, 97945, 212},
    {-46892, 94991, 112},
    {-53981, 93711, 12},
    {-53616, 80813, 312},
    {-51158, 81853, 262},
    {-43347, 101588, 137},
    {-44725, 108284, 37},
    {-47975, 104837, 237},
    {-57526, 97354, 146},
    {-60282, 93317, 46},
    {-57132, 89280, 246},
    {-58720, 85539, 136},
    {-58436, 81380, 166},
    {-56168, 81474, 186},
    {-61562, 99324, 126},
    {-66486, 98142, 136},
    {-69341, 92530, 46},
    {-64910, 93022, 56},
    {-64221, 88788, 16},
    {-66943, 85255, 146},
    {-69144, 87311, 166},
    {-62406, 85633, 148},
    {-63824, 81191, 14},
    {-61933, 81947, 166},
    {-68833, 76087, 186},
    {-69873, 82798, 196},
    {-66470, 79017, 246},
    {-66659, 81285, 346},
    {-73476, 88493, 246},
    {-72141, 84310, 216},
    {-76962, 81380, 336},
    {-74882, 78828, 106},
    {-70818, 78733, 116},
    {-46054, 71645, 246},
    {-48795, 73819, 216},
    {-48134, 76087, 326},
    {-51253, 75236, 446},
    {-59192, 70510, 346},
    {-58058, 72117, 446},
    {-54466, 70794, 136},
    {-51158, 72779, 46},
    {-61272, 71739, 16},
    {-60421, 72873, 14},
    {-56073, 72401, 46},
    {-55884, 69660, 446},
    {-49268, 68904, 46},
    {-49079, 70699, 66},
    {-52387, 69849, 86},
    {-59381, 65974, 36},
    {-58909, 64745, 56},
    {-60515, 65028, 136},
    {-60232, 64461, 176},
    {-60421, 63138, 196},
    {-51347, 68336, 246},
    {-54183, 67580, 346},
    {-55979, 68053, 46},
    {-58909, 68147, 146},
    {-54844, 65312, 246},
    {-55884, 66257, 246},
    {-56924, 67108, 156},
    {-58247, 66730, 166},
    {-53805, 73913, 176},
    {-57113, 74197, 186},
    {-59192, 74669, 196},
    {-55884, 78355, 246},
    {-60893, 76181, 246},
    {-60515, 79017, 226},
    {-58342, 77505, 216},
    {-52954, 77316, 266},
    {-55600, 76276, 266},
    {-63351, 78450, 646},
    {-66281, 77032, 246},
    {-64107, 75331, 16},
    {-65903, 73819, 46},
    {-64863, 72023, 66},
    {-62500, 73440, 46},
    {-58720, 62193, 76},
    {-58625, 63705, 26},
    {-61177, 60113, 26},
    {-61272, 63422, 46},
    {-61366, 62382, 76},
    {-61839, 60870, 246},
    {-62500, 64745, 246},
    {-62500, 62193, 346},
    {-54088, 62854, 446},
    {-53899, 64272, 446},
    {-82633, 53781, 16},
    {-84334, 58507, 14},
    {-80364, 56711, 46},
    {-85090, 69282, 146},
    {-85657, 65028, 146},
    {-81404, 59830, 146},
    {-81593, 65974, 346},
    {-77623, 53970, 246},
    {-76300, 58318, 176},
    {-74221, 59168, 276},
    {-78663, 65028, 376},
    {-75260, 65406, 76},
    {-76772, 61720, 76},
    {-73937, 62382, 76},
    {-79041, 68336, 17},
    {-75638, 68053, 17},
    {-74504, 70605, 17},
    {-80837, 76654, 276},
    {-81687, 71550, 276},
    {-77907, 70983, 376},
    {-71574, 73062, 376},
    {-76867, 74858, 176},
    {-73559, 74669, 176},
    {-68266, 74291, 33},
    {-69117, 71550, 133},
    {-67037, 70510, 153},
    {-65619, 67864, 163},
    {-64107, 69093, 233},
    {-62595, 70416, 333},
    {-57869, 69376, 233},
    {-61177, 69093, 433},
    {-63540, 65595, 153},
    {-60704, 66352, 163},
    {-56168, 60964, 173},
    {-57963, 60870, 13},
    {-59287, 60208, 13},
    {-60137, 61248, 33},
    {-62689, 67958, 33},
    {-61083, 67864, 153},
    {-61839, 66446, 183},
    {-59948, 67013, 113},
    {-57585, 65406, 123},
    {-56640, 64556, 183},
    {-55695, 63422, 233},
    {-55695, 61909, 433},
    {-57207, 62854, 33}
    }
    for i=1,#asteroidCoordinates do
    	local staticAsteroid = Asteroid():setPosition(asteroidCoordinates[i][1],asteroidCoordinates[i][2]):setSize(asteroidCoordinates[i][3])
    	table.insert(asteroidList,staticAsteroid)
    end
    return asteroidList
end
function createH1toI2mines()
	local mine_list = {}
	local mine_coordinates = {
    {-69684, 69565},
    {-63162, 50378},
    {-57396, 57089},
    {-52859, 61720},
    {-52765, 67486},
    {-71385, 54253},
    {-72992, 63894},
    {-65808, 59263},
    {-64296, 67202},
    {-60736, 54671},
    {-57869, 75898}
    }
    for i=1,#mine_coordinates do
    	local static_mine = Mine():setPosition(mine_coordinates[i][1],mine_coordinates[i][2])
    	table.insert(mine_list,static_mine)
    end
    return mine_list
end
function createJ0toK0nebulae()
	local nebula_list = {}
	local nebula_coordinates = {
		{-89306, 81682},
		{-89049, 90014},
		{-85717, 97192},
		{-86999, 109498},
		{-83409, 101294}
    }
    for i=1,#nebula_coordinates do
    	local static_nebula = Nebula():setPosition(nebula_coordinates[i][1],nebula_coordinates[i][2])
    	table.insert(nebula_list,static_nebula)
    end
    return nebula_list
end
function createJ4toL8nebulae()
	local nebula_list = {}
	local nebula_coordinates = {
    	{11830, 121981},
    	{49516, 123627},
    	{36680, 94663}
    }
    for i=1,#nebula_coordinates do
    	local static_nebula = Nebula():setPosition(nebula_coordinates[i][1],nebula_coordinates[i][2])
    	table.insert(nebula_list,static_nebula)
    end
    local neb_x = random(-5000,75000)
    local neb_y = random(80000,140000)
    icarus_mobile_nebula_1 = Nebula():setPosition(neb_x,neb_y)
    icarus_mobile_nebula_1.angle = random(0,360)
    icarus_mobile_nebula_1.increment = random(0,10)
	plotMobile = movingObjects
	table.insert(nebula_list,icarus_mobile_nebula_1)
    return nebula_list
end
function createJ4toL8asteroids()
	local asteroidList = {}
	local asteroidCoordinates = {
		{30127, 87524, 20},
		{37878, 91210, 160},
		{42982, 96692, 150},
		{61413, 84121, 12},
		{43832, 84972, 220},
		{52434, 86011, 320},
		{47897, 91777, 220},
		{25874, 92155, 420},
		{32301, 97543, 520},
		{34192, 106333, 10},
		{14815, 103592, 60},
		{22944, 102268, 90},
		{49882, 99338, 125},
		{49409, 107845, 160},
		{45534, 105198, 180},
		{39957, 110491, 250},
		{68596, 93573, 330},
		{61224, 93478, 30},
		{56025, 106522, 20},
		{63681, 107561, 60},
		{71999, 102363, 520},
		{56309, 98677, 40},
		{59900, 114178, 50},
		{51488, 115879, 160},
		{45817, 115406, 130},
		{37689, 115312, 100},
		{27764, 114650, 110},
		{13870, 115501, 220},
		{14343, 94140, 320},
		{11507, 108318, 220},
		{18691, 109641, 130},
		{26347, 106616, 140},
		{6592, 105860, 125},
		{2339, 106049, 17},
		{5458, 112004, 180},
		{21432, 128639, 320},
		{6687, 117486, 520},
		{30127, 129584, 620},
		{26536, 123062, 420},
		{51677, 131191, 320},
		{25496, 133743, 220},
		{61318, 127410, 12},
		{70676, 116730, 12},
		{-3143, 117675, 12},
		{-2765, 123724, 150},
		{24551, 128355, 60},
		{26158, 138847, 190},
		{33341, 132703, 220},
		{2623, 128450, 320},
		{11885, 135444, 420},
		{17651, 133176, 480},
		{31640, 124764, 160},
		{19825, 119282, 180},
		{12263, 125803, 260},
		{42226, 125803, 380},
		{43360, 134877, 470},
		{53662, 121267, 120}
	}
    for i=1,#asteroidCoordinates do
    	local staticAsteroid = Asteroid():setPosition(asteroidCoordinates[i][1],asteroidCoordinates[i][2]):setSize(asteroidCoordinates[i][3])
    	staticAsteroid.original_size = asteroidCoordinates[i][3]
    	table.insert(asteroidList,staticAsteroid)
    end
    return asteroidList
end
function createBorlanFeatures()
	local asteroidList = {}
	local asteroidCoordinates = {
		{94849, 47119, 120},
		{97216, 46689, 220},
		{97001, 47837, 320},
		{95710, 46689, 220},
		{95996, 46043, 320},
		{96212, 48841, 10},
		{97646, 49487, 12},
		{98436, 48698, 20},
		{98149, 47478, 220},
		{85523, 47909, 250},
		{85523, 49415, 30},
		{86671, 44896, 380},
		{82366, 44824, 420},
		{92338, 46187, 520},
		{91907, 44824, 120},
		{90903, 43676, 80},
		{90975, 46689, 60},
		{90616, 47550, 220},
		{94131, 45900, 320},
		{93270, 47550, 220},
		{95925, 47550, 70},
		{94275, 48267, 50},
		{88464, 47550, 20},
		{80071, 49056, 12},
		{83227, 47693, 280},
		{86742, 46402, 370},
		{84877, 47048, 120},
		{84590, 45685, 460},
		{88392, 45613, 40},
		{89038, 44680, 12},
		{89755, 45900, 60},
		{82151, 45828, 80},
		{79497, 45398, 20},
		{80358, 44250, 20},
		{73040, 35067, 12},
		{79712, 42887, 90},
		{83873, 50563, 110},
		{83514, 49272, 150},
		{82008, 48985, 170},
		{80716, 46904, 320},
		{76484, 50132, 370},
		{78636, 47191, 450},
		{76340, 48482, 320},
		{78062, 48482, 520},
		{77058, 45541, 70},
		{76555, 46474, 40},
		{75336, 40807, 12},
		{75695, 43676, 12},
		{75766, 45900, 12},
		{76699, 44967, 12},
		{74332, 47980, 12},
		{73614, 47478, 20},
		{74403, 46474, 20},
		{75336, 47550, 20},
		{73471, 45541, 20},
		{74619, 42959, 20},
		{74762, 41739, 70},
		{74690, 44680, 20},
		{73614, 44106, 20},
		{74762, 38080, 90},
		{73973, 39372, 220},
		{74403, 40663, 220},
		{74834, 39946, 320},
		{73542, 40376, 320},
		{72610, 39443, 420},
		{73829, 42170, 420},
		{72969, 41524, 120},
		{72108, 38224, 10},
		{72395, 37291, 160},
		{73327, 38511, 50},
		{74045, 37363, 40},
		{77345, 43030, 220},
		{78349, 43963, 70},
		{77201, 39443, 90},
		{78277, 40304, 160},
		{78492, 42241, 520},
		{76771, 40663, 10},
		{76197, 42026, 10},
		{75264, 39157, 12},
		{73040, 36215, 320},
		{71749, 35713, 120},
		{71677, 34350, 470}
    }
    for i=1,#asteroidCoordinates do
    	local staticAsteroid = Asteroid():setPosition(asteroidCoordinates[i][1],asteroidCoordinates[i][2])
    	staticAsteroid:setSize(asteroidCoordinates[i][3])
    	staticAsteroid.original_size = asteroidCoordinates[i][3]
    	table.insert(asteroidList,staticAsteroid)
    end
    return asteroidList
end
function createFinneganFeatures()
	local feature_list = {}
	local asteroidCoordinates = {
		{121621, 76465, 120},
		{117556, 76465, 15},
		{120581, 76654, 50},
		{121337, 77505, 320},
		{114532, 74953, 65},
		{116139, 76087, 12},
		{116328, 77505, 460},
		{116706, 79584, 120},
		{117651, 79962, 160},
		{118785, 79112, 195},
		{119636, 77694, 270},
		{117178, 80813, 333},
		{116611, 82231, 120},
		{118785, 77127, 10},
		{117178, 77694, 220},
		{117934, 78639, 250},
	
		{133814, 79206, 620},
		{133530, 77599, 20},
		{132112, 80246, 120},
		{137594, 81380, 12},
		{135326, 80435, 12},
		{136838, 80246, 12},
		{135893, 79206, 220},
		{135137, 78072, 320},
		{142415, 85728, 70},
		{138350, 82420, 80},
		{139012, 82798, 70},
		{137216, 82798, 80},
		{138256, 80624, 180},
		{140808, 85161, 190},
		{140241, 84216, 220},
		{139296, 81569, 20},
	
		{130694, 105009, 580},
		{130316, 103403, 12},
		{129088, 102363, 12},
		{128899, 101323, 20},
		{132963, 106238, 320},
		{130600, 109263, 220},
		{130883, 107467, 470},
		{133908, 107372, 80},
		{129655, 108034, 20},
		{132207, 104726, 12},
		{131356, 104348, 90},
		{133246, 103403, 220},
		{131545, 106144, 320},
		{134475, 101796, 270},
	
		{109995, 96597, 120},
		{107916, 92911, 220},
		{108483, 92250, 320},
		{106781, 90359, 420},
		{108766, 93478, 12},
		{108672, 94329, 20},
		{109239, 98015, 60},
		{108955, 95936, 70},
		{104513, 88280, 80},
		{103284, 89792, 90},
		{101961, 91777, 320},
		{105175, 89509, 380},
		{107727, 91021, 25},
		{106876, 89319, 70},
		{102055, 90548, 65},
		{102717, 88752, 120}
    }
    for i=1,#asteroidCoordinates do
    	local staticAsteroid = Asteroid():setPosition(asteroidCoordinates[i][1],asteroidCoordinates[i][2]):setSize(asteroidCoordinates[i][3])
    	staticAsteroid.original_size = asteroidCoordinates[i][3]
    	table.insert(feature_list,staticAsteroid)
    end
    local neb = Nebula():setPosition(108483, 93100)
    table.insert(feature_list,neb)
    local strat_x = 138000
    local strat_y = 138000
    local planet_strat = Planet():setPosition(strat_x,strat_y):setPlanetRadius(750):setDistanceFromMovementPlane(-1500):setPlanetAtmosphereTexture("planets/star-1.png"):setPlanetAtmosphereColor(1.0,.9,.9):setCallSign("Stratbik")
    table.insert(feature_list,planet_strat)
    local primus_angle = random(0,360)
    local primus_distance = 45000
    local primus_x, primus_y = vectorFromAngle(primus_angle,primus_distance)
    local planet_primus = Planet():setPosition(strat_x+primus_x,strat_y+primus_y):setPlanetRadius(1800):setDistanceFromMovementPlane(-600)
    planet_primus:setPlanetSurfaceTexture("planets/planet-2.png"):setPlanetAtmosphereTexture("planets/atmosphere.png"):setPlanetAtmosphereColor(0.1,0.6,0.1)
    planet_primus:setCallSign("Pillory"):setOrbit(planet_strat,2500)
    table.insert(feature_list,planet_primus)
    return feature_list
end
-- Kentar area stations, asteroids, mines, etc. 
function kentarSector()
	createKentarColor()
	return {
		destroy = function(self)
			assert(type(self)=="table")
			removeKentarColor()
		end
	}
end
function createKentarColor()
	kentar_color = true
	kentar_defense_platforms = {}
	kentar_planets = createKentarPlanets()
	kentar_asteroids = createKentarAsteroids()
	kentar_nebula = createKentarNebula()
	kentar_mines = createKentarMines()
	kentar_stations = createKentarStations()
	regionStations = kentar_stations
	local start_angle = 315
	for i=1,3 do
		local dpx, dpy = vectorFromAngle(start_angle,3500)
--		if i == 1 or i == 2 then
--			local kentar_zone = squareZone(kentar_x+dpx,kentar_y+dpy,string.format("Kentar DP%i",i))
--			kentar_zone:setColor(0,128,0)
--		else
			local dp = CpuShip():setTemplate("Defense platform"):setFaction("Human Navy"):setPosition(kentar_x+dpx,kentar_y+dpy):setScannedByFaction("Human Navy",true):setCallSign(string.format("DP%i",i)):setDescription(string.format("Kentar defense platform %i",i)):orderRoaming()
			station_names[dp:getCallSign()] = {dp:getSectorName(), dp}
			table.insert(kentar_defense_platforms,dp)
--		end
		start_angle = (start_angle + 120) % 360
	end
end
function createKentarStations()
	local stations = {}
	local nukeAvail = true
	local empAvail = true
	local mineAvail = true
	local homeAvail = true
	local hvliAvail = true
	local tradeFood = true
	local tradeMedicine = true
	local tradeLuxury = true
	--Gamma-3
	--local gamma3Zone = squareZone(266825, 314128, "Gamma-3 U18")
	--gamma3Zone:setColor(0,128,0)
    stationGamma3 = SpaceStation():setTemplate("Small Station"):setFaction("Human Navy"):setCallSign("Gamma-3"):setPosition(266825, 314128):setDescription("Observation Post Gamma 3"):setCommsScript(""):setCommsFunction(commsStation)
    if random(1,100) <= 30 then nukeAvail = true else nukeAvail = false end
    if random(1,100) <= 40 then empAvail = true else empAvail = false end
    if random(1,100) <= 50 then mineAvail = true else mineAvail = false end
    if random(1,100) <= 60 then homeAvail = true else homeAvail = false end
    if random(1,100) <= 80 then hvliAvail = true else hvliAvail = false end
    if random(1,100) <= 42 then tradeLuxury = true else tradeLuxury = false end
    if random(1,100) <= 42 then tradeMedicine = true else tradeMedicine = false end
    stationGamma3.comms_data = {
    	friendlyness = 68,
        weapons = 			{Homing = "neutral",		HVLI = "neutral", 		Mine = "friend",		Nuke = "friend", 			EMP = "friend"},
        weapon_cost =		{Homing = math.random(1,4), HVLI = math.random(2,4),Mine = math.random(2,5),Nuke = math.random(8,20),	EMP = math.random(12,15) },
        weapon_available = 	{Homing = homeAvail,		HVLI = hvliAvail,		Mine = mineAvail,		Nuke = nukeAvail,			EMP = empAvail},
        service_cost = 		{supplydrop = math.random(80,120), reinforcements = math.random(125,175)},
        sensor_boost = {value = 10000, cost = 10},
        reputation_cost_multipliers = {friend = 1.0, neutral = 2.0},
        max_weapon_refill_amount = {friend = 1.0, neutral = 0.5 },
        goods = {	tractor = 	{quantity = math.random(2,5),	cost = math.random(40,70)},
        			repulsor = 	{quantity = math.random(2,5),	cost = math.random(55,90)}	},
        trade = {	food = true, medicine = tradeMedicine, luxury = tradeLuxury },
        public_relations = true,
        general_information = "We watch and report on enemy vessel movement. We also run a small tractor and repulsor component machine shop",
    	history = "The Human Navy set this station up as a strategic observation post"
	}
	if random(1,100) <= 22 then stationGamma3:setRestocksScanProbes(false) end
	if random(1,100) <= 31 then stationGamma3:setRepairDocked(false) end
	if random(1,100) <= 17 then stationGamma3:setSharesEnergyWithDocked(false) end
	station_names[stationGamma3:getCallSign()] = {stationGamma3:getSectorName(), stationGamma3}
	table.insert(stations,stationGamma3)
	--Katanga
	--local katangaZone = squareZone(229513, 224048, "Katanga 2 Q16")
	--katangaZone:setColor(0,128,0)
    stationKatanga = SpaceStation():setTemplate("Small Station"):setFaction("Human Navy"):setPosition(229513, 224048):setCallSign("Katanga 2"):setDescription("Mining station for cobalt, gold and other minerals"):setCommsScript(""):setCommsFunction(commsStation)
    if random(1,100) <= 30 then nukeAvail = true else nukeAvail = false end
    if random(1,100) <= 40 then empAvail = true else empAvail = false end
    if random(1,100) <= 50 then mineAvail = true else mineAvail = false end
    if random(1,100) <= 60 then homeAvail = true else homeAvail = false end
    if random(1,100) <= 80 then hvliAvail = true else hvliAvail = false end
    if random(1,100) <= 67 then tradeLuxury = true else tradeLuxury = false end
    stationKatanga.comms_data = {
    	friendlyness = 75,
        weapons = 			{Homing = "neutral",HVLI = "neutral", 		Mine = "friend",		Nuke = "friend", 			EMP = "friend"},
        weapon_cost =		{Homing = 3, 		HVLI = math.random(2,4),Mine = math.random(2,5),Nuke = math.random(12,18),	EMP = 10 },
        weapon_available = 	{Homing = homeAvail,HVLI = hvliAvail,		Mine = mineAvail,		Nuke = nukeAvail,			EMP = empAvail},
        service_cost = 		{supplydrop = math.random(80,120), reinforcements = math.random(125,175)},
        sensor_boost = {value = 10000, cost = 5},
        reputation_cost_multipliers = {friend = 1.0, neutral = 2.0},
        max_weapon_refill_amount = {friend = 1.0, neutral = 0.5 },
        goods = {	cobalt = 	{quantity = math.random(5,10),	cost = math.random(60,70)},
        			gold = 		{quantity = math.random(5,10),	cost = math.random(55,90)}	},
        trade = {	food = true, medicine = false, luxury = tradeLuxury },
        public_relations = true,
        general_information = "Extracting minerals from these asteroids is our job",
    	history = "Based on the scans showing cobalt in many of these asteroids, we named this station after an ancient earth mining operation that was part of the Glencore Public Limited Comany"
	}
	if random(1,100) <= 22 then stationKatanga:setRestocksScanProbes(false) end
	if random(1,100) <= 38 then stationKatanga:setRepairDocked(false) end
	if random(1,100) <= 12 then stationKatanga:setSharesEnergyWithDocked(false) end
	station_names[stationKatanga:getCallSign()] = {stationKatanga:getSectorName(), stationKatanga}
	table.insert(stations,stationKatanga)
	--Keyhole-23 T15
	stationKeyhole23 = SpaceStation():setTemplate("Small Station"):setFaction("Human Navy"):setCallSign("Keyhole-23"):setPosition(213600,290000):setDescription("Gravitational lensing spy satellite"):setCommsScript(""):setCommsFunction(commsStation)
	stationKeyhole23.total_time = 0
    if random(1,100) <= 67 then tradeLuxury = true else tradeLuxury = false end
    stationKeyhole23.comms_data = {
    	friendlyness = 25,
        weapons = 			{Homing = "neutral",HVLI = "neutral", 		Mine = "friend",		Nuke = "friend", 			EMP = "friend"},
        weapon_cost =		{Homing = 3, 		HVLI = math.random(2,4),Mine = math.random(2,5),Nuke = math.random(32,58),	EMP = 20 },
        weapon_available = 	{Homing = false,	HVLI = false,			Mine = false,			Nuke = true,				EMP = true},
        service_cost = 		{supplydrop = math.random(180,320), reinforcements = math.random(225,375)},
        reputation_cost_multipliers = {friend = 1.0, neutral = 2.0},
        max_weapon_refill_amount = {friend = 1.0, neutral = 0.5 },
        goods = {	dilithium = 	{quantity = math.random(5,10),	cost = math.random(20,30)},
        			tritanium =		{quantity = math.random(5,10),	cost = math.random(25,40)}	},
        trade = {	food = true, medicine = false, luxury = tradeLuxury },
        public_relations = true,
        general_information = "Work here is classified, however, it involves research on this black hole",
    	history = "Reference classified archives at headquarters. Public access redacted"
	}
	if random(1,100) <= 42 then stationKeyhole23:setRestocksScanProbes(false) end
	if random(1,100) <= 28 then stationKeyhole23:setRepairDocked(false) end
	if random(1,100) <= 15 then stationKeyhole23:setSharesEnergyWithDocked(false) end
	station_names[stationKeyhole23:getCallSign()] = {stationKeyhole23:getSectorName(), stationKeyhole23}
	table.insert(stations,stationKeyhole23)
	update_system:addOrbitUpdate(stationKeyhole23,210000,290000,3600,15*2*math.pi)
	--Kolar
	--local kolarZone = squareZone(165481, 272311, "Kolar S13")
	--kolarZone:setColor(51,153,255)
    stationKolar = SpaceStation():setTemplate("Small Station"):setFaction("Independent"):setCallSign("Kolar"):setPosition(165481, 272311):setDescription("Mining"):setCommsScript(""):setCommsFunction(commsStation)
    if random(1,100) <= 30 then nukeAvail = true else nukeAvail = false end
    if random(1,100) <= 40 then empAvail = true else empAvail = false end
    if random(1,100) <= 50 then mineAvail = true else mineAvail = false end
    if random(1,100) <= 60 then homeAvail = true else homeAvail = false end
    if random(1,100) <= 80 then hvliAvail = true else hvliAvail = false end
    if random(1,100) <= 42 then tradeLuxury = true else tradeLuxury = false end
    if random(1,100) <= 42 then tradeFood = true else tradeFood = false end
    if random(1,100) <= 42 then tradeMedicine = true else tradeMedicine = false end
    stationKolar.comms_data = {
    	friendlyness = 85,
        weapons = 			{Homing = "neutral",		HVLI = "neutral", 		Mine = "neutral",		Nuke = "friend", 			EMP = "neutral"},
        weapon_cost =		{Homing = math.random(1,4), HVLI = math.random(1,4),Mine = math.random(1,4),Nuke = math.random(12,18),	EMP = math.random(13,17) },
        weapon_available = 	{Homing = homeAvail,		HVLI = hvliAvail,		Mine = mineAvail,		Nuke = nukeAvail,			EMP = empAvail},
        service_cost = 		{supplydrop = math.random(80,120), reinforcements = math.random(125,175)},
        sensor_boost = {value = 5000, cost = 10},
        reputation_cost_multipliers = {friend = 1.0, neutral = 2.0},
        max_weapon_refill_amount = {friend = 1.0, neutral = 0.5 },
        goods = {	circuit = 	{quantity = math.random(5,9),	cost = math.random(50,80)},
        			autodoc =	{quantity = math.random(5,9),	cost = math.random(63,70)},
        			gold =		{quantity = math.random(5,9),	cost = math.random(33,50)}	},
        trade = {	food = tradeFood, medicine = tradeMedicine, luxury = tradeLuxury },
        public_relations = true,
        general_information = "We mine gold, we make and sell autodoc and circuit",
    	history = "We said, 'thar's gold in them there rocks' and we just had to get some"
	}
	if random(1,100) <= 62 then stationKolar:setRestocksScanProbes(false) end
	if random(1,100) <= 48 then stationKolar:setRepairDocked(false) end
	if random(1,100) <= 35 then stationKolar:setSharesEnergyWithDocked(false) end
	station_names[stationKolar:getCallSign()] = {stationKolar:getSectorName(), stationKolar}
	table.insert(stations,stationKolar)
	--Locarno
	--local locarnoZone = squareZone(246819, 331779, "Locarno V17")
	--locarnoZone:setColor(51,153,255)
    stationLocarno = SpaceStation():setTemplate("Small Station"):setFaction("Independent"):setCallSign("Locarno"):setPosition(246819, 331779):setDescription("Mining and resupply"):setCommsScript(""):setCommsFunction(commsStation)
    if random(1,100) <= 30 then nukeAvail = true else nukeAvail = false end
    if random(1,100) <= 40 then empAvail = true else empAvail = false end
    if random(1,100) <= 50 then mineAvail = true else mineAvail = false end
    if random(1,100) <= 60 then homeAvail = true else homeAvail = false end
    if random(1,100) <= 80 then hvliAvail = true else hvliAvail = false end
    if random(1,100) <= 42 then tradeLuxury = true else tradeLuxury = false end
    if random(1,100) <= 42 then tradeFood = true else tradeFood = false end
    if random(1,100) <= 42 then tradeMedicine = true else tradeMedicine = false end
    stationLocarno.comms_data = {
    	friendlyness = 85,
        weapons = 			{Homing = "neutral",		HVLI = "neutral", 		Mine = "neutral",		Nuke = "neutral", 			EMP = "neutral"},
        weapon_cost =		{Homing = math.random(1,5), HVLI = math.random(2,4),Mine = math.random(2,4),Nuke = math.random(12,18),	EMP = math.random(9,15) },
        weapon_available = 	{Homing = homeAvail,		HVLI = hvliAvail,		Mine = mineAvail,		Nuke = nukeAvail,			EMP = empAvail},
        service_cost = 		{supplydrop = math.random(80,120), reinforcements = math.random(125,175)},
        sensor_boost = {value = 5000, cost = 5},
        reputation_cost_multipliers = {friend = 1.0, neutral = 2.0},
        max_weapon_refill_amount = {friend = 1.0, neutral = 0.5 },
        goods = {	nanites = 	{quantity = math.random(5,9),	cost = math.random(50,80)},
        			android =	{quantity = math.random(5,9),	cost = math.random(63,70)},
        			cobalt =	{quantity = math.random(5,9),	cost = math.random(33,50)}	},
        trade = {	food = tradeFood, medicine = tradeMedicine, luxury = tradeLuxury },
        public_relations = true,
        general_information = "We mine, we trade, we sell nanites and android components",
    	history = "It looked like a good location for resupply and mining and it's served us well"
	}
	if random(1,100) <= 32 then stationLocarno:setRestocksScanProbes(false) end
	if random(1,100) <= 28 then stationLocarno:setRepairDocked(false) end
	if random(1,100) <= 25 then stationLocarno:setSharesEnergyWithDocked(false) end
	station_names[stationLocarno:getCallSign()] = {stationLocarno:getSectorName(), stationLocarno}
	table.insert(stations,stationLocarno)
	--Nereus
	--local NereusZone = squareZone(174288, 321668, "Nereus B V13")
	--NereusZone:setColor(0,128,0)
    stationNereus = SpaceStation():setTemplate("Small Station"):setFaction("Human Navy"):setCallSign("Nereus B"):setPosition(174288, 321668):setDescription("Mining, observation and lifter manufacturing"):setCommsScript(""):setCommsFunction(commsStation)
    if random(1,100) <= 30 then nukeAvail = true else nukeAvail = false end
    if random(1,100) <= 40 then empAvail = true else empAvail = false end
    if random(1,100) <= 50 then mineAvail = true else mineAvail = false end
    if random(1,100) <= 60 then homeAvail = true else homeAvail = false end
    if random(1,100) <= 80 then hvliAvail = true else hvliAvail = false end
    if random(1,100) <= 42 then tradeLuxury = true else tradeLuxury = false end
    if random(1,100) <= 42 then tradeMedicine = true else tradeMedicine = false end
    stationNereus.comms_data = {
    	friendlyness = 58,
        weapons = 			{Homing = "neutral",		HVLI = "neutral", 		Mine = "friend",		Nuke = "friend", 			EMP = "friend"},
        weapon_cost =		{Homing = math.random(3,7), HVLI = math.random(1,3),Mine = math.random(1,6),Nuke = math.random(13,15),	EMP = math.random(12,15) },
        weapon_available = 	{Homing = homeAvail,		HVLI = hvliAvail,		Mine = mineAvail,		Nuke = nukeAvail,			EMP = empAvail},
        service_cost = 		{supplydrop = math.random(80,120), reinforcements = math.random(125,175)},
        reputation_cost_multipliers = {friend = 1.0, neutral = 2.0},
        max_weapon_refill_amount = {friend = 1.0, neutral = 0.5 },
        goods = {	nickel = 	{quantity = math.random(2,5),	cost = math.random(30,50)},
        			lifter = 	{quantity = math.random(2,5),	cost = math.random(55,90)}	},
        trade = {	food = true, medicine = tradeMedicine, luxury = tradeLuxury },
        public_relations = true,
        general_information = "We mine primarily for nickel, watch for enemy vessels and manufacture lifter components",
    	history = "These asteroids provide a good nearby source for nickel, so a station was placed to facilitate mining. One of the original station members had lifter experience and over time built up a lifter manufacturing facility"
	}
	if random(1,100) <= 12 then stationNereus:setRestocksScanProbes(false) end
	if random(1,100) <= 18 then stationNereus:setRepairDocked(false) end
	if random(1,100) <= 35 then stationNereus:setSharesEnergyWithDocked(false) end
	station_names[stationNereus:getCallSign()] = {stationNereus:getSectorName(), stationNereus}
	table.insert(stations,stationNereus)
	--Pastern (Orbiting Ergot which orbits Rigil in N25. Look in the square bounded by Q22, K22, K28 and Q28)
	local ergot_x, ergot_y = planet_primus:getPosition()
    stationPastern = SpaceStation():setTemplate("Small Station"):setFaction("Independent"):setCallSign("Pastern"):setPosition(ergot_x+1500, ergot_y):setDescription("Research"):setCommsScript(""):setCommsFunction(commsStation)
    if random(1,100) <= 30 then nukeAvail = true else nukeAvail = false end
    if random(1,100) <= 40 then empAvail = true else empAvail = false end
    if random(1,100) <= 50 then mineAvail = true else mineAvail = false end
    if random(1,100) <= 60 then homeAvail = true else homeAvail = false end
    if random(1,100) <= 80 then hvliAvail = true else hvliAvail = false end
    if random(1,100) <= 42 then tradeLuxury = true else tradeLuxury = false end
    if random(1,100) <= 42 then tradeMedicine = true else tradeMedicine = false end
    stationPastern.comms_data = {
    	friendlyness = 58,
        weapons = 			{Homing = "neutral",		HVLI = "neutral", 		Mine = "friend",		Nuke = "friend", 			EMP = "friend"},
        weapon_cost =		{Homing = math.random(3,7), HVLI = math.random(1,3),Mine = math.random(1,6),Nuke = math.random(13,15),	EMP = math.random(12,15) },
        weapon_available = 	{Homing = homeAvail,		HVLI = hvliAvail,		Mine = mineAvail,		Nuke = nukeAvail,			EMP = empAvail},
        service_cost = 		{supplydrop = math.random(80,120), reinforcements = math.random(125,175)},
        reputation_cost_multipliers = {friend = 1.0, neutral = 3.0},
        max_weapon_refill_amount = {friend = 1.0, neutral = 0.5 },
        goods = {	circuit = 	{quantity = math.random(2,5),	cost = math.random(30,50)},
        			battery = 	{quantity = math.random(2,5),	cost = math.random(55,90)}	},
        trade = {	food = true, medicine = tradeMedicine, luxury = tradeLuxury },
        public_relations = true,
        general_information = "We research the relationship between Rigil, Ergot and the cosmos",
    	history = "Continuing the equine anatomy nomenclature, the station builders named this station Pastern due to its proximity to Ergot"
	}
	update_system:addOrbitTargetUpdate(stationPastern,planet_primus,1500,23*2*math.pi,0)
	if random(1,100) <= 23 then stationPastern:setRestocksScanProbes(false) end
	if random(1,100) <= 18 then stationPastern:setRepairDocked(false) end
	if random(1,100) <= 15 then stationPastern:setSharesEnergyWithDocked(false) end
	station_names[stationPastern:getCallSign()] = {stationPastern:getSectorName(), stationPastern}
	table.insert(stations,stationPastern)
	--Talos
	--local talosZone = squareZone(124505, 317170, "Talos 2 U11")
	--talosZone:setColor(0,128,0)
	stationTalos = SpaceStation():setTemplate("Small Station"):setFaction("Human Navy"):setCallSign("Talos 2"):setPosition(124505, 317170):setDescription("Mining and observation"):setCommsScript(""):setCommsFunction(commsStation)
    if random(1,100) <= 30 then nukeAvail = true else nukeAvail = false end
    if random(1,100) <= 40 then empAvail = true else empAvail = false end
    if random(1,100) <= 50 then mineAvail = true else mineAvail = false end
    if random(1,100) <= 60 then homeAvail = true else homeAvail = false end
    if random(1,100) <= 80 then hvliAvail = true else hvliAvail = false end
    if random(1,100) <= 42 then tradeLuxury = true else tradeLuxury = false end
    if random(1,100) <= 42 then tradeFood = true else tradeFood = false end
    if random(1,100) <= 42 then tradeMedicine = true else tradeMedicine = false end
    stationTalos.comms_data = {
    	friendlyness = 35,
        weapons = 			{Homing = "neutral",		HVLI = "neutral", 		Mine = "friend",		Nuke = "friend", 			EMP = "friend"},
        weapon_cost =		{Homing = math.random(2,7), HVLI = math.random(2,4),Mine = math.random(2,4),Nuke = math.random(14,18),	EMP = math.random(8,12) },
        weapon_available = 	{Homing = homeAvail,		HVLI = hvliAvail,		Mine = mineAvail,		Nuke = nukeAvail,			EMP = empAvail},
        service_cost = 		{supplydrop = math.random(80,120), reinforcements = math.random(125,175)},
        reputation_cost_multipliers = {friend = 1.0, neutral = 2.0},
        max_weapon_refill_amount = {friend = 1.0, neutral = 0.5 },
        goods = {	platinum = 	{quantity = math.random(2,5),	cost = math.random(50,80)},
        			gold =	 	{quantity = math.random(2,5),	cost = math.random(43,70)}	},
        trade = {	food = tradeFood, medicine = tradeMedicine, luxury = tradeLuxury },
        public_relations = true,
        general_information = "We mine primarily for platinum and gold and watch for enemy vessels",
    	history = "These asteroids provide a good nearby source for gold and platinum, so a station was placed to facilitate mining. It also serves as a good early warning post for enemy vessels"
	}
	if random(1,100) <= 14 then stationTalos:setRestocksScanProbes(false) end
	if random(1,100) <= 11 then stationTalos:setRepairDocked(false) end
	if random(1,100) <= 12 then stationTalos:setSharesEnergyWithDocked(false) end
	station_names[stationTalos:getCallSign()] = {stationTalos:getSectorName(), stationTalos}
	table.insert(stations,stationTalos)
	--Sutter (T9)
    stationSutter = SpaceStation():setTemplate("Small Station"):setFaction("Human Navy"):setCallSign("Sutter"):setPosition(84609, 293172):setDescription("Mining and research"):setCommsScript(""):setCommsFunction(commsStation)
    if random(1,100) <= 30 then nukeAvail = true else nukeAvail = false end
    if random(1,100) <= 40 then empAvail = true else empAvail = false end
    if random(1,100) <= 50 then mineAvail = true else mineAvail = false end
    if random(1,100) <= 60 then homeAvail = true else homeAvail = false end
    if random(1,100) <= 80 then hvliAvail = true else hvliAvail = false end
    if random(1,100) <= 42 then tradeLuxury = true else tradeLuxury = false end
    if random(1,100) <= 42 then tradeFood = true else tradeFood = false end
    if random(1,100) <= 42 then tradeMedicine = true else tradeMedicine = false end
    stationSutter.comms_data = {
    	friendlyness = 45,
        weapons = 			{Homing = "neutral",		HVLI = "neutral", 		Mine = "friend",		Nuke = "friend", 			EMP = "friend"},
        weapon_cost =		{Homing = math.random(1,5), HVLI = math.random(2,4),Mine = math.random(2,4),Nuke = math.random(12,18),	EMP = math.random(9,15) },
        weapon_available = 	{Homing = homeAvail,		HVLI = hvliAvail,		Mine = mineAvail,		Nuke = nukeAvail,			EMP = empAvail},
        service_cost = 		{supplydrop = math.random(80,120), reinforcements = math.random(125,175)},
        reputation_cost_multipliers = {friend = 1.0, neutral = 2.0},
        max_weapon_refill_amount = {friend = 1.0, neutral = 0.5 },
        goods = {	nickel = 	{quantity = math.random(5,9),	cost = math.random(50,80)},
        			dilithium =	{quantity = math.random(5,9),	cost = math.random(43,70)},
        			cobalt =	{quantity = math.random(5,9),	cost = math.random(63,70)}	},
        trade = {	food = tradeFood, medicine = tradeMedicine, luxury = tradeLuxury },
        public_relations = true,
        general_information = "We mine for nickel, dilithium and cobalt. A science team researches some extraordinarily rare minerals found here",
    	history = "These asteroids provide a good nearby source for nickel, dilithium and cobalt, so a station was placed to facilitate mining. A scientific research team is also based herer to investigate unusual readings on some of the asteroids"
	}
	if random(1,100) <= 14 then stationSutter:setRestocksScanProbes(false) end
	if random(1,100) <= 11 then stationSutter:setRepairDocked(false) end
	if random(1,100) <= 12 then stationSutter:setSharesEnergyWithDocked(false) end
	station_names[stationSutter:getCallSign()] = {stationSutter:getSectorName(), stationSutter}
	table.insert(stations,stationSutter)
	return stations
end
function createKentarPlanets()
	local planet_list = {}
	rigil_x = 408742
	rigil_y = 169754
	planet_rigil = Planet():setPosition(rigil_x,rigil_y):setPlanetRadius(1000):setDistanceFromMovementPlane(-2000):setPlanetAtmosphereTexture("planets/star-1.png"):setPlanetAtmosphereColor(1.0,.9,.9):setCallSign("Rigil")
	table.insert(planet_list,planet_rigil)
	primus_angle = random(0,360)
	primus_distance = 60000
	primus_x, primus_y = vectorFromAngle(primus_angle,primus_distance)
	planet_primus = Planet():setPosition(rigil_x+primus_x,rigil_y+primus_y):setPlanetRadius(1000):setDistanceFromMovementPlane(-500)
	planet_primus:setPlanetSurfaceTexture("planets/planet-2.png"):setPlanetAtmosphereTexture("planets/atmosphere.png"):setPlanetAtmosphereColor(0.3,0.15,0.1)
	planet_primus:setCallSign("Ergot"):setOrbit(planet_rigil,3000)
	table.insert(planet_list,planet_primus)
	black_hole_k1 = BlackHole():setPosition(290000,210000)
	table.insert(planet_list,black_hole_k1)
	black_hole_k2 = BlackHole():setPosition(210000,290000)
	table.insert(planet_list,black_hole_k2)
	return planet_list
end
function createKentarMines()
	local mine_list = {}
	local mine_coordinates = {
		{82955, 295158},
		{86968, 293163},
		{86740, 294663},
		{83024, 294199},
		{84715, 295869},
		{85475, 292120},
		{83908, 294447},
		{83179, 292457},
		{83737, 291864},
		{84700, 291781},
		{82666, 292940}
	}
	for i=1,#mine_coordinates do
    	local static_mine = Mine():setPosition(mine_coordinates[i][1],mine_coordinates[i][2])
    	table.insert(mine_list,static_mine)
	end
	return mine_list
end
function createKentarAsteroids()
	local asteroid_list = {}
	local asteroid_coordinates = {
		{237355, 341175, 355},
		{242045, 341317, 255},
		{243466, 338901, 155},
		{244177, 336556, 455},
		{245669, 335774, 555},
		{246806, 334495, 655},
		{246593, 332932, 55},
		{247588, 333571, 55},
		{247375, 330871, 35},
		{248663, 329973, 15},
		{78851, 290391, 34},
		{80538, 292640, 23},
		{83249, 289135, 334},
		{83216, 290490, 24},
		{75710, 296906, 134},
		{78256, 295748, 274},
		{73395, 295451, 214},
		{127099, 315622, 134},
		{77727, 300014, 64},
		{78653, 298030, 134},
		{173839, 324127, 34},
		{73263, 292508, 34},
		{75611, 287217, 34},
		{150434, 325181, 24},
		{72304, 294426, 24},
		{201040, 304939, 534},
		{82786, 294988, 294},
		{173980, 318785, 334},
		{82423, 291582, 134},
		{195698, 306063, 244},
		{84010, 293599, 237},
		{127591, 318926, 94},
		{81067, 293367, 434},
		{79612, 297269, 134},
		{79050, 293863, 234},
		{74817, 293731, 234},
		{74189, 290722, 214},
		{121124, 314076, 254},
		{122038, 319207, 54},
		{81166, 296112, 4},
		{84804, 294822, 34},
		{76735, 289267, 534},
		{79876, 288506, 434},
		{77826, 287349, 134},
		{81993, 286688, 174},
		{79215, 285894, 84},
		{80207, 283745, 634},
		{77727, 285299, 34},
		{89202, 294855, 34},
		{86622, 289895, 24},
		{87482, 292508, 24},
		{90921, 293169, 44},
		{89764, 292078, 64},
		{91351, 291020, 54},
		{92773, 294558, 64},
		{86755, 287713, 34},
		{87052, 296343, 24},
		{90061, 299121, 84},
		{87118, 299121, 134},
		{85663, 300047, 164},
		{85366, 284836, 194},
		{85465, 286886, 234},
		{87879, 285001, 234},
		{90326, 287283, 44},
		{93401, 290490, 334},
		{93269, 292045, 434},
		{97634, 298559, 74},
		{95253, 295252, 84},
		{83316, 301502, 214},
		{81960, 300444, 204},
		{95749, 300279, 354},
		{94856, 301932, 394},
		{93699, 295847, 234},
		{94559, 297071, 234},
		{97270, 296509, 254},
		{92112, 300510, 274},
		{84043, 304379, 284},
		{80604, 301833, 234},
		{88540, 304048, 224},
		{92211, 304048, 214},
		{86325, 302527, 334},
		{86457, 304941, 334},
	--
		{169727, 259094, 334},
		{177727, 267520, 434},
		{166243, 250230, 534},
		{148395, 259612, 134},
		{149949, 254021, 24},
		{152708, 246528, 24},
		{143186, 262425, 34},
		{140056, 268814, 634},
		{144204, 271605, 434},
		{132887, 270315, 134},
		{137324, 255011, 264},
		{164706, 279692, 239},
		{165361, 284918, 254},
		{142007, 276720, 284},
		{127403, 256736, 294},
		{140631, 246240, 164},
		{148207, 286302, 184},
		{153997, 282920, 194},
		{168402, 266420, 164},
		{170658, 266600, 234},
		{167680, 271157, 234},
		{171786, 269217, 234},
		{164748, 274406, 334},
		{167184, 274677, 534},
		{169576, 276797, 634},
		{164703, 277925, 134},
		{137088, 280666, 264},
		{141341, 284662, 274},
		{173681, 275545, 284},
		{175121, 274484, 34},
		{176636, 275166, 34},
		{174969, 276379, 23},
		{177091, 277819, 23},
		{174060, 271075, 23},
		{172469, 272211, 14},
		{171256, 274636, 34},
		{170574, 274788, 134},
		{177697, 274181, 334},
		{175954, 273045, 334},
		{179137, 272439, 334},
		{173075, 267665, 434},
		{169437, 264482, 434},
		{162412, 271558, 434},
		{165203, 268814, 534},
		{164738, 264490, 534},
		{158753, 262663, 534},
		{155040, 266452, 734},
		{152994, 262057, 264},
		{148675, 266755, 264},
		{147538, 274484, 274},
		{154964, 269104, 274},
		{159208, 270393, 284},
		{161405, 267816, 294},
		{145038, 277212, 134},
		{147084, 278425, 134},
		{151251, 274257, 134},
		{151782, 278273, 154},
		{155116, 274181, 154},
		{155874, 277970, 164},
		{165800, 270393, 154},
		{162314, 277970, 174},
		{168452, 277970, 184},
		{172847, 278198, 254},
		{158980, 274257, 284},
		{162314, 274257, 284},
		{165952, 275015, 284},
		{169437, 274106, 284},
		{169589, 271984, 234},
		{169134, 269332, 234},
		{165270, 261527, 234},
		{160227, 260305, 234},
		{162845, 258723, 214},
		{156460, 254771, 214},
		{160875, 255237, 214},
		{155116, 257359, 234},
		{160117, 252358, 234},
		{223576, 220378, 20},
		{228043, 213831, 120},
		{231509, 219223, 220},
		{229352, 216758, 320},
		{222882, 239095, 180},
		{236054, 227079, 160},
		{232741, 219300, 190},
		{233897, 219300, 12},
		{227427, 220995, 20},
		{231432, 220840, 220},
		{225501, 231239, 320},
		{227966, 227465, 420},
		{230200, 227542, 520},
		{226425, 224461, 620},
		{221881, 227002, 320},
		{216720, 230854, 220},
		{224423, 216527, 170},
		{236439, 224615, 180},
		{238518, 222689, 20},
		{228813, 232317, 12},
		{224962, 234474, 50},
		{232664, 230931, 70},
		{235514, 228928, 80},
		{237594, 219146, 15},
		{232048, 223690, 25},
		{236747, 229698, 325},
		{240059, 230391, 725},
		{234051, 226925, 225},
		{234282, 232471, 225},
		{237671, 227465, 165},
		{240521, 226232, 165},
		{238826, 231470, 175},
		{239366, 228312, 195},
		{240752, 228389, 325},
		{241907, 228235, 425} 
	}
    for i=1,#asteroid_coordinates do
    	local static_asteroid = Asteroid():setPosition(asteroid_coordinates[i][1],asteroid_coordinates[i][2]):setSize(asteroid_coordinates[i][3])
    	table.insert(asteroid_list,static_asteroid)
    end
    return asteroid_list
end
function createKentarNebula()
	local nebula_list = {}
	local nebula_coordinates = {
		{120064, 312382},
		{120643, 319370},
		{115342, 316108},
		{114325, 308421},
		{126696, 314745},
		{131154, 317849},
		{92475, 300295},
		{125060, 321237},
		{136554, 319815},
		{192982, 308249},
		{87185, 295651},
		{198593, 301982},
		{182353, 316287},
		{198580, 308113},
		{187791, 312512},
		{131449, 322751},
		{150626, 322953},
		{97651, 297388},
		{85424, 302134},
		{93237, 293237},
		{143416, 321745},
		{176997, 318076},
		{176536, 323162},
		{101116, 306820},
		{104202, 300923},
		{108819, 305042},
		{173097, 326215},
		{87144, 287426},
		{164896, 322006},
		{170688, 319822},
		{78704, 287201},
		{150965, 326807},
		{80073, 298276},
		{82811, 291992},
		{156892, 322419},
		{205808, 295642},
		{75531, 293547},
		{203577, 305468},
		{214130, 197543},
		{225472, 200000},
		{228118, 191115},
		{219234, 192628},
		{194659, 189792},
		{201842, 190737},
		{209404, 193384},
		{235680, 188091}
	}
	for i=1,#nebula_coordinates do
    	local static_nebula = Nebula():setPosition(nebula_coordinates[i][1],nebula_coordinates[i][2])
    	table.insert(nebula_list,static_nebula)
	end
	local mobile_neb_dist = 56568.542495
	local nebula_start_angle = random(0,360)
	local snpx,snpy = vectorFromAngle(nebula_start_angle,mobile_neb_dist)
	kentar_mobile_nebula_1 = Nebula():setPosition(210000+snpx,290000+snpy)
	kentar_mobile_nebula_1.angle = nebula_start_angle
	kentar_mobile_nebula_1.mobile_neb_dist = mobile_neb_dist
	kentar_mobile_nebula_1.center_x = 210000
	kentar_mobile_nebula_1.center_y = 290000
	if kentar_mobile_nebula_1.angle >= 45 then
		kentar_mobile_nebula_1.ready = false
	else
		kentar_mobile_nebula_1.ready = true
	end
	kentar_mobile_nebula_1.lower_black_hole = true
	kentar_mobile_nebula_1.increment = .05
	plotMobile = movingObjects
	table.insert(nebula_list,kentar_mobile_nebula_1)
    return nebula_list
end
function removeKentarColor()
	kentar_color = false
	if kentar_planets ~= nil then
		for _,kp in pairs(kentar_planets) do
			kp:destroy()
		end
	end
	kentar_planets = nil
	
	if kentar_asteroids ~= nil then
		for _,ka in pairs(kentar_asteroids) do
			ka:destroy()
		end
	end
	kentar_asteroids = nil
	
	if kentar_nebula ~= nil then
		for _,kn in pairs(kentar_nebula) do
			kn:destroy()
		end
	end
	kentar_nebula = nil
	
	if kentar_stations ~= nil then
		for _,ks in pairs(kentar_stations) do
			ks:destroy()
		end
	end
	kentar_stations = nil
	
	if kentar_mines ~= nil then
		for _,km in pairs(kentar_mines) do
			km:destroy()
		end
	end
	kentar_mines = nil
	
	if kentar_defense_platforms ~= nil then
		for _,kdp in pairs(kentar_defense_platforms) do
			kdp:destroy()
		end
	end
	kentar_defense_platforms = nil
end
--	Eris area stations, asteroids, mines, etc.
function erisSector(x,y)
	assert(type(x)=="number")
	assert(type(y)=="number")
	local eris = {
		all_local_objects = {}, -- this may want to become another system maybe?
		destroy = function(self)
			assert(type(self)=="table")
			for i=1,#self.all_local_objects do
				local obj=self.all_local_objects[i]
				if obj:isValid() then
					obj:destroy()
				end
			end
		end
	}
	return eris
end
function ghostNebulaSector()
	local wip = {
		all_objects = {}, -- this may want to become another system maybe?
		asteroid_locations={{465336, 287674},
			{465338, 305555},
			{465408, 290326},
			{465542, 279592},
			{465623, 297779},
			{465828, 302571},
			{466033, 337365},
			{466033, 339532},
			{466196, 292977},
			{466196, 306291},
			{466401, 283967},
			{466401, 335607},
			{466605, 307518},
			{466687, 341577},
			{466770, 304587},
			{466851, 309153},
			{467055, 340882},
			{467200, 299785},
			{467260, 343662},
			{467271, 297850},
			{467341, 311607},
			{467341, 336997},
			{467414, 289108},
			{467423, 332622},
			{467558, 292332},
			{467668, 334830},
			{467791, 346238},
			{467844, 305447},
			{468131, 294912},
			{468131, 301505},
			{468159, 341822},
			{468363, 337733},
			{468486, 310421},
			{468609, 344602},
			{468650, 343049},
			{468691, 330823},
			{468763, 339367},
			{468776, 287244},
			{468895, 348446},
			{468936, 336548},
			{468977, 346033},
			{469018, 350122},
			{469063, 303440},
			{469134, 305949},
			{469140, 334940},
			{469278, 290182},
			{469278, 298925},
			{469304, 312261},
			{469421, 308528},
			{469467, 333481},
			{469590, 342108},
			{469708, 283016},
			{469708, 297062},
			{469708, 301362},
			{469713, 347628},
			{469825, 340809},
			{469835, 280573},
			{469958, 345011},
			{470203, 352821},
			{470244, 335853},
			{470285, 350817},
			{470326, 331151},
			{470326, 343989},
			{470367, 349018},
			{470408, 328820},
			{470424, 293192},
			{470490, 358054},
			{470496, 306235},
			{470735, 356255},
			{470854, 303369},
			{470858, 354947},
			{471021, 313610},
			{471141, 287746},
			{471226, 333031},
			{471226, 351676},
			{471284, 286528},
			{471307, 315164},
			{471348, 311770},
			{471389, 319620},
			{471389, 321624},
			{471428, 295987},
			{471499, 308600},
			{471553, 326530},
			{471570, 335118},
			{471571, 284019},
			{471643, 300430},
			{471675, 317780},
			{471757, 353475},
			{471757, 359444},
			{471858, 307382},
			{471873, 339216},
			{471921, 323832},
			{471921, 361325},
			{472001, 291329},
			{472002, 329188},
			{472025, 342023},
			{472166, 356255},
			{472216, 304874},
			{472248, 357850},
			{472480, 349307},
			{472575, 312997},
			{472575, 354742},
			{472616, 333195},
			{472738, 314264},
			{472943, 330455},
			{473012, 336332},
			{473012, 341719},
			{473065, 279388},
			{473071, 282098},
			{473163, 344982},
			{473188, 319620},
			{473188, 325999},
			{473188, 360712},
			{473229, 321297},
			{473229, 359117},
			{473363, 309890},
			{473474, 315900},
			{473474, 328288},
			{473515, 322850},
			{473556, 362388},
			{473578, 297779},
			{473649, 288319},
			{473664, 338541},
			{473679, 355846},
			{473721, 303010},
			{473760, 324813},
			{473791, 334622},
			{473883, 353270},
			{474008, 293121},
			{474151, 295486},
			{474223, 291401},
			{474294, 307167},
			{474377, 348244},
			{474653, 311897},
			{474681, 351204},
			{474683, 341217},
			{474811, 336629},
			{474824, 332336},
			{474864, 360712},
			{474864, 362225},
			{474868, 285739},
			{474946, 323505},
			{475011, 300144},
			{475028, 363533},
			{475226, 304730},
			{475441, 321930},
			{475441, 329956},
			{475480, 334271},
			{475513, 318060},
			{475515, 349914},
			{475543, 338349},
			{475591, 344072},
			{475667, 357349},
			{475723, 280696},
			{475735, 354916},
			{475871, 325799},
			{475943, 314907},
			{476046, 347182},
			{476086, 290684},
			{476229, 287889},
			{476229, 309532},
			{476244, 336183},
			{476301, 301649},
			{476582, 362797},
			{476602, 283760},
			{476659, 307167},
			{476659, 311897},
			{476659, 342905},
			{476803, 353605},
			{476850, 340643},
			{476874, 303942},
			{476874, 327591},
			{476874, 331819},
			{476881, 349155},
			{476946, 295199},
			{476946, 298782},
			{477018, 319780},
			{477089, 278716},
			{477184, 351583},
			{477184, 358336},
			{477264, 346059},
			{477376, 292906},
			{477522, 364678},
			{477582, 339433},
			{477591, 334112},
			{477806, 290756},
			{477901, 351284},
			{477949, 312972},
			{478092, 337648},
			{478124, 349213},
			{478164, 320066},
			{478171, 355225},
			{478195, 285491},
			{478236, 310822},
			{478307, 315695},
			{478379, 322073},
			{478451, 305519},
			{478451, 325154},
			{478522, 351957},
			{478602, 342937},
			{478666, 347589},
			{478793, 345008},
			{478809, 287889},
			{478809, 330959},
			{479016, 350743},
			{479144, 341312},
			{479233, 359018},
			{479239, 357618},
			{479382, 292619},
			{479454, 333754},
			{479462, 349182},
			{479526, 318060},
			{479526, 328594},
			{479526, 336549},
			{479597, 308457},
			{479597, 311610},
			{479741, 354178},
			{479812, 297062},
			{479812, 299785},
			{479812, 339129},
			{479884, 301792},
			{480027, 280078},
			{480027, 283016},
			{480027, 290827},
			{480219, 362812},
			{480242, 322001},
			{480272, 285560},
			{480314, 330601},
			{480386, 303870},
			{480386, 350094},
			{480457, 315265},
			{480529, 289108},
			{480601, 313115},
			{480705, 344817},
			{480737, 346601},
			{480816, 320640},
			{480928, 342873},
			{481031, 353032},
			{481102, 323578},
			{481282, 359625},
			{481317, 293909},
			{481389, 306235},
			{481532, 310822},
			{481532, 340849},
			{481676, 316483},
			{481747, 348875},
			{481819, 326803},
			{481819, 338556},
			{481891, 357833},
			{481947, 355808},
			{481962, 281869},
			{482034, 329383},
			{482034, 351598},
			{482142, 287499},
			{482177, 298066},
			{482177, 318203},
			{482249, 290326},
			{482321, 345650},
			{482392, 344217},
			{482751, 332464},
			{482822, 284091},
			{482822, 340706},
			{482894, 347155},
			{482894, 353533},
			{482966, 301434},
			{483181, 309747},
			{483252, 313473},
			{483252, 360055},
			{483324, 304587},
			{483324, 335546},
			{483324, 343429},
			{483539, 280723},
			{483539, 294626},
			{483611, 307740},
			{483611, 317701},
			{483682, 356042},
			{483826, 322861},
			{483897, 314548},
			{484041, 320496},
			{484184, 337696},
			{484184, 350595},
			{484256, 333252},
			{484327, 329024},
			{484399, 312183},
			{484614, 286169},
			{484614, 290182},
			{484686, 345579},
			{484686, 354107},
			{484829, 282586},
			{484829, 340992},
			{484829, 358048},
			{484972, 352315},
			{485044, 316483},
			{485187, 302652},
			{485259, 298639},
			{485259, 335904},
			{485474, 326086},
			{485546, 343572},
			{485689, 347800},
			{485904, 295199},
			{486119, 292332},
			{486119, 318920},
			{486190, 307955},
			{486190, 355182},
			{486262, 329383},
			{486406, 359697},
			{486692, 284019},
			{486692, 288176},
			{486692, 324151},
			{486764, 353247},
			{486835, 350810},
			{486907, 312470},
			{486979, 331748},
			{487337, 359697},
			{487337, 361130},
			{487409, 338842},
			{487409, 342139},
			{487409, 357905},
			{487695, 321141},
			{488054, 281368},
			{488269, 333754},
			{488269, 354035},
			{488484, 326444},
			{488484, 345005},
			{488524, 296704},
			{488956, 309996},
			{488985, 356185},
			{489344, 293694},
			{489415, 362635},
			{489559, 295486},
			{489605, 302647},
			{489702, 284378},
			{489702, 286384},
			{489702, 348875},
			{489702, 351814},
			{489845, 358837},
			{490060, 290111},
			{490562, 281583},
			{490634, 360772},
			{490685, 316155},
			{490920, 353748},
			{491010, 310968},
			{491010, 339713},
			{491135, 363065},
			{491279, 283804},
			{491874, 302972},
			{491924, 286958},
			{491995, 360843},
			{492090, 300054},
			{492198, 343603},
			{492210, 291902},
			{492354, 351384},
			{492630, 295839},
			{492712, 356973},
			{492955, 299622},
			{493063, 324800},
			{493063, 331933},
			{493285, 293981},
			{493357, 359338},
			{493500, 289179},
			{493644, 364211},
			{493859, 366003},
			{494074, 285739},
			{494145, 362061},
			{494288, 280723},
			{494359, 307402},
			{494684, 300594},
			{494792, 318857},
			{494900, 333337},
			{495005, 283804},
			{495008, 297136},
			{495292, 352673},
			{495292, 366218},
			{495332, 311076},
			{495548, 320586},
			{495578, 289108},
			{495650, 357332},
			{495764, 345116},
			{495872, 327502},
			{495937, 361488},
			{496295, 363638},
			{496367, 286958},
			{496725, 293049},
			{497061, 336687},
			{497169, 323504},
			{497227, 355898},
			{497277, 313454},
			{497493, 303404},
			{497513, 367795},
			{497728, 284593},
			{497800, 290326},
			{497943, 280006},
			{498445, 282371},
			{498517, 274201},
			{498947, 287459},
			{499222, 358624},
			{499546, 295839},
			{499547, 358624},
			{499655, 367053},
			{499763, 306970},
			{499763, 329663},
			{499878, 289968},
			{500087, 320046},
			{500195, 296056},
			{500308, 276208},
			{500380, 292834},
			{500519, 363271},
			{500843, 354842},
			{501059, 325017},
			{501168, 279361},
			{501384, 298865},
			{501384, 342415},
			{501492, 367486},
			{501600, 310428},
			{501600, 346413},
			{501813, 282156},
			{501816, 364892},
			{502032, 354626},
			{502243, 273413},
			{502356, 358624},
			{502464, 301675},
			{502602, 285524},
			{502680, 359381},
			{502788, 335823},
			{502888, 289609},
			{503004, 304592},
			{503113, 351816},
			{503221, 315075},
			{503329, 333013},
			{503462, 275778},
			{503462, 292834},
			{503545, 346845},
			{503653, 310320},
			{503820, 277713},
			{503977, 319721},
			{504393, 281153},
			{504517, 357220},
			{504734, 323288},
			{504950, 359381},
			{505166, 362731},
			{505253, 274846},
			{505382, 298973},
			{505382, 330528},
			{505382, 356139},
			{505396, 285524},
			{505598, 293786},
			{505598, 361542},
			{505611, 289968},
			{505706, 352897},
			{505814, 340794},
			{506185, 283374},
			{506328, 270117},
			{506354, 326746},
			{506463, 305889},
			{506571, 336255},
			{506571, 360245},
			{506615, 276065},
			{506787, 297568},
			{506895, 309347},
			{506901, 271980},
			{507331, 279648},
			{507759, 328150},
			{507975, 322639},
			{508048, 267895},
			{508048, 283159},
			{508048, 292117},
			{508192, 302539},
			{508192, 337012},
			{508263, 273771},
			{508406, 288606},
			{508516, 354734},
			{508516, 355166},
			{508732, 357436},
			{508840, 313994},
			{509051, 269830},
			{509164, 344792},
			{509410, 273915},
			{509488, 309239},
			{509488, 347602},
			{509704, 354302},
			{509768, 277498},
			{509840, 283446},
			{510245, 293354},
			{510413, 271622},
			{510461, 323396},
			{510556, 288176},
			{510700, 284951},
			{510785, 341442},
			{510893, 357003},
			{510986, 279863},
			{511109, 323071},
			{511217, 352357},
			{511433, 357760},
			{511758, 337120},
			{511918, 264957},
			{512082, 327070},
			{512276, 268397},
			{512276, 278573},
			{512298, 318749},
			{512348, 273628},
			{512622, 356247},
			{512838, 345441},
			{512921, 280866},
			{513271, 354302},
			{513487, 324908},
			{513595, 314102},
			{513703, 330096},
			{513703, 354086},
			{513811, 343495},
			{513924, 270905},
			{514211, 273556},
			{514283, 265315},
			{514283, 277068},
			{514641, 267250},
			{514675, 283412},
			{515108, 351168},
			{515501, 269328},
			{515573, 256142},
			{515648, 319613},
			{515648, 352357},
			{515648, 354734},
			{515788, 263309},
			{515859, 272052},
			{515972, 328258},
			{516080, 315723},
			{516188, 336471},
			{516296, 355490},
			{516648, 268182},
			{516791, 254422},
			{516791, 259582},
			{516863, 265673},
			{517161, 298541},
			{517269, 356139},
			{517579, 257934},
			{517593, 348466},
			{517723, 263094},
			{517794, 256214},
			{517809, 341550},
			{518025, 354302},
			{518224, 261015},
			{518350, 332257},
			{518350, 357003},
			{518583, 271693},
			{518674, 298541},
			{518890, 289356},
			{518890, 354626},
			{518998, 305997},
			{519084, 259224},
			{519228, 269113},
			{519430, 312805},
			{519586, 255282},
			{519646, 338633},
			{519658, 263954},
			{519754, 356787},
			{519862, 285789},
			{520079, 313454},
			{520079, 351816},
			{520088, 266175},
			{520303, 261804},
			{520511, 323071},
			{520619, 293138},
			{520619, 355274},
			{521483, 282331},
			{521521, 257432},
			{521521, 269185},
			{521700, 340145},
			{521700, 345441},
			{521879, 258865},
			{521879, 266748},
			{521951, 254996},
			{522166, 263810},
			{522240, 320910},
			{522348, 333878},
			{522348, 343279},
			{522452, 261230},
			{522456, 352681},
			{522672, 328367},
			{522739, 252057},
			{522780, 301026},
			{523212, 282764},
			{523320, 354086},
			{523384, 264240},
			{524185, 323828},
			{524185, 357544},
			{524244, 254351},
			{524244, 261302},
			{524244, 267035},
			{524293, 307510},
			{524293, 359921},
			{524401, 299405},
			{524401, 305889},
			{524617, 351708},
			{524674, 265745},
			{525050, 290112},
			{525050, 314967},
			{525247, 259295},
			{525374, 336255},
			{525374, 363379},
			{525482, 349655},
			{525590, 276280},
			{525606, 263954},
			{525677, 257289},
			{525749, 267393},
			{526130, 356247},
			{526179, 251699},
			{526454, 305781},
			{526670, 350736},
			{526752, 250767},
			{526778, 339929},
			{526887, 272390},
			{526887, 351168},
			{526896, 258937},
			{526967, 261302},
			{527039, 254279},
			{527103, 331608},
			{527103, 345657},
			{527397, 255712},
			{527535, 318857},
			{527751, 281899},
			{527751, 295191},
			{527827, 263667},
			{527859, 288491},
			{527967, 359165},
			{528042, 253921},
			{528042, 265673},
			{528075, 356031},
			{528257, 251699},
			{528399, 343820},
			{528399, 343820},
			{528724, 362190},
			{528759, 248331},
			{529117, 261660},
			{529260, 262592},
			{529332, 256859},
			{529480, 351168},
			{529588, 300810},
			{529696, 302431},
			{529906, 253992},
			{530128, 305133},
			{530264, 252272},
			{530336, 246826},
			{530336, 249262},
			{530453, 285573},
			{530550, 264742},
			{530561, 278549},
			{530561, 362731},
			{530669, 313562},
			{530669, 336255},
			{530909, 259725},
			{531267, 250194},
			{531317, 341118},
			{531317, 350412},
			{531317, 363487},
			{531533, 359057},
			{531641, 267635},
			{531697, 262592},
			{531857, 366729},
			{531966, 301243},
			{532055, 255497},
			{532055, 257647},
			{532074, 348034},
			{532074, 355923},
			{532182, 352681},
			{532182, 361758},
			{532342, 248187},
			{532414, 252917},
			{532614, 291949},
			{532772, 251484},
			{533130, 259009},
			{533154, 291517},
			{533154, 366621},
			{533370, 358624},
			{533478, 281035},
			{533775, 263380},
			{533911, 272822},
			{533919, 250122},
			{534019, 325233},
			{534019, 344144},
			{534205, 261159},
			{534235, 340254},
			{534235, 347170},
			{534277, 257145},
			{534420, 245536},
			{534451, 359165},
			{534451, 362407},
			{534492, 251627},
			{534559, 364892},
			{534635, 254279},
			{534667, 356247},
			{534775, 292165},
			{534775, 298649},
			{534775, 309023},
			{534850, 248402},
			{534991, 300162},
			{534991, 366945},
			{535316, 347494},
			{535532, 310860},
			{535532, 320262},
			{535710, 257074},
			{535748, 352681},
			{535925, 250266},
			{535997, 243529},
			{535997, 259224},
			{535997, 261947},
			{536140, 247184},
			{536499, 255282},
			{536612, 356463},
			{536612, 357544},
			{536828, 359921},
			{536857, 245608},
			{537144, 252487},
			{537215, 251484},
			{537261, 373537},
			{537369, 272390},
			{537369, 362515},
			{537477, 362623},
			{537574, 248761},
			{537585, 348574},
			{537585, 369755},
			{537645, 258077},
			{537693, 347494},
			{537801, 359381},
			{538017, 327826},
			{538075, 260012},
			{538125, 303728},
			{538233, 285249},
			{538290, 253777},
			{538341, 375482},
			{538434, 242454},
			{538434, 245966},
			{538449, 366405},
			{538449, 370079},
			{538577, 243959},
			{538774, 278441},
			{538882, 345332},
			{538882, 356787},
			{539007, 258507},
			{539150, 248402},
			{539150, 250767},
			{539150, 256285},
			{539314, 309888},
			{539314, 352681},
			{539638, 297028},
			{539854, 267743},
			{539962, 360569},
			{539962, 360569},
			{539962, 372240},
			{540070, 336471},
			{540297, 246969},
			{540368, 244748},
			{540368, 260084},
			{540440, 242669},
			{540503, 370511},
			{540583, 252631},
			{540935, 365648},
			{541085, 257719},
			{541443, 255497},
			{541475, 356355},
			{541583, 304701},
			{541945, 251054},
			{542017, 249979},
			{542088, 259080},
			{542160, 246468},
			{542340, 285789},
			{542448, 344684},
			{542664, 290004},
			{542664, 355382},
			{542664, 365432},
			{542988, 360569},
			{543096, 349547},
			{543096, 373861},
			{543235, 249621},
			{543312, 314967},
			{543312, 317236},
			{543420, 295191},
			{543450, 254207},
			{543528, 353329},
			{543636, 329987},
			{543636, 377860},
			{543665, 256429},
			{543744, 365216},
			{544023, 252774},
			{544177, 332905},
			{544501, 274767},
			{544717, 267851},
			{544717, 357544},
			{544717, 366189},
			{544740, 249907},
			{544933, 281575},
			{545149, 372564},
			{545365, 371052},
			{545474, 278225},
			{545743, 252559},
			{545906, 362947},
			{545958, 246539},
			{546014, 325125},
			{546014, 349115},
			{546030, 255067},
			{546338, 300270},
			{546446, 361542},
			{546532, 258507},
			{546890, 251699},
			{546986, 267094},
			{546986, 311509},
			{546986, 337012},
			{546986, 368350},
			{547094, 284709},
			{547094, 340578},
			{547094, 351276},
			{547202, 351060},
			{547311, 273038},
			{547419, 358516},
			{547527, 362839},
			{547527, 377319},
			{547606, 248474},
			{547678, 256500},
			{547893, 245464},
			{547959, 306862},
			{548067, 294759},
			{548067, 354302},
			{548067, 375806},
			{548252, 243099},
			{548283, 355815},
			{548391, 261259},
			{548391, 367486},
			{548607, 361650},
			{548682, 253491},
			{548715, 371268},
			{548823, 321883},
			{548896, 250982},
			{548932, 356355},
			{549148, 312697},
			{549183, 247041},
			{549364, 303188},
			{549364, 355923},
			{549472, 257261},
			{549685, 256142},
			{549688, 352249},
			{549904, 358732},
			{550115, 245464},
			{550115, 248546},
			{550444, 371160},
			{550877, 369971},
			{550877, 373213},
			{550985, 364892},
			{551046, 253777},
			{551093, 273254},
			{551093, 372240},
			{551201, 346413},
			{551309, 328799},
			{551417, 348790},
			{551417, 362515},
			{551525, 265257},
			{551525, 351060},
			{551835, 250696},
			{551978, 247256},
			{552173, 319505},
			{552498, 351816},
			{552498, 358732},
			{552498, 365432},
			{552498, 373213},
			{552930, 323936},
			{553038, 293246},
			{553146, 359597},
			{553362, 337768},
			{553794, 263961},
			{554010, 269040},
			{554227, 359597},
			{554271, 255067},
			{554443, 280710},
			{554551, 350952},
			{554551, 368458},
			{554659, 308915},
			{554659, 359597},
			{554701, 252487},
			{554767, 319829},
			{554845, 250122},
			{555199, 348682},
			{555523, 298217},
			{555523, 364352},
			{555740, 364460},
			{556064, 370295},
			{556379, 255243},
			{556496, 363703},
			{556636, 251556},
			{556712, 365648},
			{557036, 355707},
			{557144, 290328},
			{557144, 332797},
			{557353, 253276},
			{557469, 347602},
			{557926, 248187},
			{558117, 314750},
			{558225, 355598},
			{558333, 369106},
			{558549, 325557},
			{558765, 259098},
			{558765, 277577},
			{559306, 335931},
			{559414, 265906},
			{559431, 253276},
			{559522, 302431},
			{559630, 268824},
			{559630, 364568},
			{559738, 296920},
			{559861, 248546},
			{559861, 250552},
			{560006, 255871},
			{560170, 348142},
			{560710, 312373},
			{560710, 363379},
			{560927, 343063},
			{560927, 364676},
			{561035, 363055},
			{561251, 286438},
			{561359, 361542},
			{561791, 366729},
			{561899, 305673},
			{561899, 352140},
			{562115, 350628},
			{562369, 250051},
			{562448, 253709},
			{562656, 330744},
			{562764, 349655},
			{562764, 355058},
			{563145, 252663},
			{563304, 291949},
			{563844, 278981},
			{564168, 316588},
			{564168, 353978},
			{564277, 275307},
			{564385, 306538},
			{564385, 323504},
			{564680, 255174},
			{564709, 358192},
			{564709, 360029},
			{564817, 297785},
			{564889, 251058},
			{565033, 262340},
			{565141, 335066},
			{565465, 269040},
			{566006, 278009},
			{566006, 353978},
			{566114, 288491},
			{566144, 252663},
			{566330, 280819},
			{566330, 340362},
			{566762, 310428},
			{566978, 318641},
			{567194, 356679},
			{567330, 254197},
			{567518, 348358},
			{567749, 255732},
			{567818, 250500},
			{568167, 326097},
			{568725, 252663},
			{568815, 265041},
			{568815, 350412},
			{569074, 257057},
			{569139, 269796},
			{569247, 291949},
			{570112, 305025},
			{570190, 254058},
			{570328, 342631},
			{570469, 255522},
			{571193, 299514},
			{571306, 257057},
			{571517, 318100},
			{571733, 338308},
			{571934, 251616},
			{571949, 333121},
			{571949, 357976},
			{572381, 347494},
			{572492, 258661},
			{572840, 254825},
			{572884, 249082},
			{572910, 253011},
			{572922, 351924},
			{573084, 251650},
			{573138, 277252},
			{573138, 359597},
			{573354, 310968},
			{573678, 257336},
			{573852, 251884},
			{573952, 250249},
			{574002, 284709},
			{574326, 320910},
			{574434, 348466},
			{574514, 252942},
			{575083, 327394},
			{575119, 254686},
			{575153, 252051},
			{575191, 306862},
			{575299, 303296},
			{575407, 355166},
			{575623, 359381},
			{575720, 250416},
			{575720, 257522},
			{575731, 341010},
			{575979, 255871},
			{576220, 248815},
			{576272, 362298},
			{576380, 335931},
			{576596, 268824},
			{576754, 253919},
			{576812, 293786},
			{576854, 252184},
			{577028, 362407},
			{577088, 257956},
			{577455, 255687},
			{577755, 249615},
			{577788, 256688},
			{577888, 253519},
			{578001, 352249},
			{578001, 358948},
			{578109, 276928},
			{578433, 289248},
			{578689, 251884},
			{578757, 361326},
			{578865, 333337},
			{578889, 254920},
			{578973, 262664},
			{578973, 347386},
			{579081, 283196},
			{579223, 257222},
			{579405, 351816},
			{579890, 255687},
			{580054, 313021},
			{580162, 354950},
			{580390, 253018},
			{580490, 249949},
			{580810, 361326},
			{581242, 340037},
			{581458, 247180},
			{581458, 251784},
			{581459, 362623},
			{581675, 319613},
			{581783, 347818},
			{581891, 326529},
			{581891, 346629},
			{582025, 249982},
			{582215, 309023},
			{583026, 245278},
			{583080, 333986},
			{583080, 353113},
			{583193, 251584},
			{583226, 248114},
			{583404, 270228},
			{583404, 358840},
			{583944, 280710},
			{584484, 318641},
			{584484, 357003},
			{584761, 246313},
			{584828, 249615},
			{584917, 284925},
			{584917, 362623},
			{584928, 251584},
			{585228, 247814},
			{585349, 265906},
			{585673, 351492},
			{585889, 325989},
			{586213, 337228},
			{586430, 329987},
			{586430, 350952},
			{586796, 250149},
			{586862, 341442},
			{586996, 245312},
			{587186, 362623},
			{587294, 357976},
			{587618, 353005},
			{587726, 276496},
			{588050, 315291},
			{588097, 252651},
			{588230, 247514},
			{588431, 250216},
			{588483, 348466},
			{588915, 356787},
			{589780, 345549},
			{590104, 273794},
			{590320, 338524},
			{590320, 359165},
			{590320, 360894},
			{590536, 353761},
			{590752, 243537},
			{590860, 282115},
			{591292, 245590},
			{591400, 269472},
			{591725, 278009},
			{591941, 347278},
			{592265, 345657},
			{592481, 307942},
			{592589, 260395},
			{592805, 250993},
			{592913, 336904},
			{593130, 285465},
			{593130, 329555},
			{594102, 325449},
			{594102, 351384},
			{594318, 243429},
			{594750, 275415},
			{594967, 356031},
			{595183, 247535},
			{595831, 353870},
			{595831, 353870},
			{595831, 358192},
			{596047, 315615},
			{596804, 270877},
			{596912, 322531},
			{596912, 355274},
			{597020, 282656},
			{597236, 348899},
			{597560, 311401},
			{597776, 351384},
			{598208, 266122},
			{598208, 292057},
			{598208, 344360},
			{598425, 287627},
			{599181, 307942},
			{599613, 353005},
			{599721, 356139},
			{599938, 354086},
			{600046, 253911},
			{600046, 335823},
			{600370, 249696},
			{600478, 343603},
			{600586, 302431},
			{601126, 258233},
			{601234, 354518},
			{601342, 260178},
			{601342, 305565},
			{601342, 347386},
			{601775, 296704},
			{602639, 251425},
			{602639, 279954},
			{602747, 330204},
			{603179, 355274},
			{603396, 355490},
			{603828, 349979},
			{603936, 286438},
			{604044, 318857},
			{604152, 254235},
			{604260, 301243},
			{604692, 343603},
			{604800, 348358},
			{605016, 307294},
			{605125, 249048},
			{605233, 293786},
			{605557, 266878},
			{605665, 296704},
			{606529, 314210},
			{607070, 273254},
			{607070, 333662},
			{607934, 349547},
			{608150, 262772},
			{608366, 291301},
			{608366, 352681},
			{608474, 340902},
			{608475, 253046},
			{608691, 364352},
			{609339, 353221},
			{609447, 325341},
			{609555, 344360},
			{609555, 348142},
			{609771, 249912},
			{609771, 337228},
			{610095, 298757},
			{610204, 255316},
			{610312, 280170},
			{610420, 269796},
			{610420, 359165},
			{610528, 359597},
			{610852, 364676},
			{610960, 276928},
			{611068, 366189},
			{611176, 262988},
			{611176, 281791},
			{611176, 301675},
			{611392, 286438},
			{611500, 253154},
			{611608, 286978},
			{611608, 294867},
			{611608, 308699},
			{611608, 360353},
			{611608, 361434},
			{612041, 350412},
			{612257, 265906},
			{612473, 343603},
			{612905, 354518},
			{613013, 319505},
			{613337, 271633},
			{613337, 356571},
			{613445, 325665},
			{613554, 273686},
			{613554, 361866},
			{613770, 258557},
			{613878, 313994},
			{613878, 331392},
			{614202, 340037},
			{614634, 250669},
			{614742, 292381},
			{615823, 308591},
			{615931, 254667},
			{615931, 364352},
			{616039, 298433},
			{616363, 311833},
			{616687, 344468},
			{616687, 360461},
			{617012, 282007},
			{617120, 354626},
			{617228, 322423},
			{617336, 250561},
			{617336, 303296},
			{617444, 277577},
			{618092, 258125},
			{618849, 354734},
			{619281, 339065},
			{619605, 368458},
			{619821, 330204},
			{619821, 333445},
			{619929, 255208},
			{620253, 364136},
			{620254, 256937},
			{620578, 267419},
			{620794, 372132},
			{621226, 305025},
			{621226, 320478},
			{621226, 332149},
			{621550, 271633},
			{621550, 314642},
			{621550, 359381},
			{621874, 250993},
			{622523, 369971},
			{622631, 258990},
			{623279, 288491},
			{623603, 264501},
			{623603, 270228},
			{623711, 348899},
			{623820, 348899},
			{623928, 280602},
			{623928, 353870},
			{624144, 302323},
			{624360, 256720},
			{624576, 315723},
			{624684, 321775},
			{624900, 254451},
			{625008, 274659},
			{625116, 365108},
			{625116, 370619},
			{625440, 267743},
			{625440, 272498},
			{625549, 282223},
			{625549, 309239},
			{625657, 260178},
			{625873, 364784},
			{625981, 342199},
			{626197, 374942},
			{626305, 289896},
			{626305, 293894},
			{626305, 354302},
			{626305, 366945},
			{626521, 294002},
			{626629, 336687},
			{626737, 362947},
			{626845, 278009},
			{626953, 354302},
			{626953, 358192},
			{626953, 361110},
			{627278, 369971},
			{627494, 313454},
			{627494, 328691},
			{627710, 342523},
			{627818, 257693},
			{627818, 303512},
			{628250, 346845},
			{628682, 266446},
			{628682, 270444},
			{628790, 255316},
			{629007, 270444},
			{629331, 283952},
			{629439, 324368},
			{629547, 298973},
			{629763, 333770},
			{629763, 367486},
			{629871, 261043},
			{629979, 300486},
			{629979, 327394},
			{630195, 288059},
			{630303, 346953},
			{630519, 344684},
			{630628, 283196},
			{630736, 355815},
			{630844, 280494},
			{630952, 291301},
			{631060, 308807},
			{631060, 362839},
			{631384, 259746},
			{631492, 273794},
			{631708, 270444},
			{631924, 295407},
			{632032, 318100},
			{632032, 360786},
			{632140, 299405},
			{632140, 357760},
			{632357, 279306},
			{632357, 299297},
			{632357, 332041},
			{632573, 266338},
			{632573, 268607},
			{633113, 336579},
			{633221, 292489},
			{633437, 312913},
			{633437, 317776},
			{633545, 304917},
			{633653, 343603},
			{633761, 305133},
			{634086, 364352},
			{634194, 310428},
			{634518, 261907},
			{634734, 325449},
			{634842, 315615},
			{635274, 307726},
			{635382, 330744},
			{635923, 361434},
			{636031, 275523},
			{636031, 294326},
			{636139, 279522},
			{636895, 274335},
			{637003, 322315},
			{637219, 337228},
			{637328, 325665},
			{637436, 340902},
			{637544, 269148},
			{637652, 260611},
			{637868, 287735},
			{637976, 317452},
			{638084, 344144},
			{638192, 264393},
			{638300, 294651},
			{639056, 326205},
			{639273, 301783},
			{639381, 291301},
			{639381, 308915},
			{639381, 333013},
			{639597, 290220},
			{639705, 277577},
			{640353, 331716},
			{640786, 333445},
			{640894, 297028},
			{640894, 338957},
			{641326, 261043},
			{641326, 283412},
			{641434, 339929},
			{641542, 307186},
			{641650, 324368},
			{641866, 303296},
			{642190, 256828},
			{642190, 267959},
			{642190, 269040},
			{642190, 332905},
			{642298, 345657},
			{642406, 269796},
			{642839, 262124},
			{642839, 346629},
			{643595, 321667},
			{644027, 293030},
			{644135, 344792},
			{644352, 348142},
			{644460, 272714},
			{644568, 303296},
			{644676, 310104},
			{645000, 281791},
			{645108, 327286},
			{645324, 284601},
			{645324, 288167},
			{645432, 263636},
			{645864, 258341},
			{645973, 260070},
			{646621, 342631},
			{646729, 315183},
			{647053, 279090},
			{647702, 337444},
			{647918, 260503},
			{647918, 315399},
			{648026, 267094},
			{648134, 241700},
			{648134, 293678},
			{648134, 329987},
			{648242, 270120},
			{648350, 248291},
			{648350, 256396},
			{648350, 342199},
			{648674, 244833},
			{648674, 273794},
			{648674, 284169},
			{648674, 307402},
			{648782, 348466},
			{648890, 291733},
			{648890, 299189},
			{648998, 320154},
			{649323, 262772},
			{649647, 329987},
			{649755, 286546},
			{650187, 273038},
			{650187, 337444},
			{650295, 333337},
			{650727, 322855},
			{650727, 323179},
			{650835, 246130},
			{650944, 246779},
			{650944, 254235},
			{650944, 324044},
			{651052, 283952},
			{651052, 283952},
			{651052, 300162},
			{651052, 311833},
			{651052, 342307},
			{651160, 242996},
			{651160, 306970},
			{651268, 303512},
			{651376, 279306},
			{651376, 341118},
			{651484, 268607},
			{651592, 257153},
			{651808, 347062},
			{652348, 261691},
			{652348, 289464},
			{652564, 287843},
			{652781, 241700},
			{652781, 262124},
			{652889, 251209},
			{652889, 280494},
			{652889, 343712},
			{653105, 265365},
			{653537, 335931},
			{653645, 324152},
			{653969, 254559},
			{654185, 244077},
			{654293, 246779},
			{654293, 288491},
			{654402, 271201},
			{654618, 298217},
			{654726, 340686},
			{654834, 265365},
			{654942, 250020},
			{654942, 314967},
			{655050, 270661},
			{655050, 276604},
			{655374, 285249},
			{655590, 256937},
			{655590, 279738},
			{655914, 312373},
			{656022, 253478},
			{656022, 308051},
			{656022, 332581},
			{656347, 254235},
			{656455, 292381},
			{656779, 244293},
			{656779, 302539},
			{656887, 260503},
			{656887, 288383},
			{657211, 280170},
			{657427, 336255},
			{657860, 268824},
			{657860, 276604},
			{658076, 299946},
			{658076, 311292},
			{658292, 282331},
			{658292, 301134},
			{658616, 304917},
			{658616, 336795},
			{658724, 263096},
			{658832, 256720},
			{659048, 247535},
			{659156, 292597},
			{659264, 266122},
			{659372, 271957},
			{659589, 299622},
			{659913, 275199},
			{659913, 279306},
			{660021, 266230},
			{660021, 313454},
			{660129, 338416},
			{660237, 244185},
			{660237, 250453},
			{660345, 261475},
			{660345, 273146},
			{660561, 276604},
			{660669, 252182},
			{660993, 318749},
			{660993, 321234},
			{661210, 295839},
			{661318, 301891},
			{661426, 282007},
			{661426, 293030},
			{661642, 310752},
			{661750, 342091},
			{661858, 297568},
			{662074, 247859},
			{662398, 256072},
			{662398, 259314},
			{662614, 268824},
			{663155, 285898},
			{663155, 304701},
			{663263, 249804},
			{663263, 288167},
			{663371, 244185},
			{663479, 264501},
			{663479, 271741},
			{663587, 284709},
			{663803, 285681},
			{664560, 246670},
			{664884, 296380},
			{665100, 279198},
			{665208, 275523},
			{665640, 268067},
			{665748, 251425},
			{666072, 248400},
			{666180, 316371},
			{666288, 258233},
			{666288, 296704},
			{666397, 254019},
			{666505, 289031},
			{666505, 290652},
			{666613, 277793},
			{666937, 280602},
			{666937, 314102},
			{667153, 301891},
			{667693, 291193},
			{667909, 273254},
			{667909, 282980},
			{668018, 259314},
			{668018, 282223},
			{668990, 255964},
			{668990, 272498},
			{669530, 302215},
			{670395, 291841},
			{670395, 295623},
			{670611, 268175},
			{670611, 273146},
			{671259, 284925},
			{671368, 258666},
			{671476, 269796},
			{671692, 255099},
			{671800, 263420},
			{671908, 275848},
			{671908, 282115},
			{672016, 282223},
			{672556, 261259},
			{672556, 278657},
			{674285, 284277},
			{674393, 268499},
			{674393, 293678},
			{674501, 299730},
			{674609, 289788},
			{675042, 301675},
			{675150, 287518},
			{675150, 290868},
			{675690, 272714},
			{675690, 295083},
			{676446, 276496},
			{676663, 262340},
			{676771, 265149},
			{676879, 259098},
			{677527, 298217},
			{678824, 264825},
			{679256, 292814},
			{679364, 280170},
			{679580, 268499},
			{679904, 260935},
			{680121, 279522},
			{680229, 270877},
			{680445, 286114},
			{680553, 297244},
			{680769, 276820},
			{680877, 303728},
			{680985, 303728},
			{681417, 266986},
			{681742, 275740},
			{681850, 290977},
			{682714, 300594},
			{682714, 300594},
			{682822, 282980},
			{682930, 261691},
			{683363, 292706},
			{683363, 295191},
			{683579, 308591},
			{683795, 263961},
			{683903, 288707},
			{684011, 282115},
			{684984, 300486},
			{685524, 277793},
			{685524, 306213},
			{685632, 294975},
			{685632, 301567},
			{686064, 297676},
			{686172, 280386},
			{686280, 265149},
			{686388, 286438},
			{686388, 308267},
			{686496, 262880},
			{686496, 299622},
			{686712, 268607},
			{687145, 292381},
			{687361, 258449},
			{687361, 287410},
			{687577, 263420},
			{688226, 303944},
			{688333, 286546},
			{688658, 281683},
			{688766, 284385},
			{689522, 291193},
			{689738, 291409},
			{690171, 266554},
			{690927, 301351},
			{691143, 264393},
			{691359, 297676},
			{691575, 305889},
			{693304, 286978},
			{693953, 295623},
			{694709, 291841},
			{696114, 280386},
			{696438, 281899},
			{696438, 287302}},
		nebula_locations={},
		mine_locations={{455347, 291973},
			{457401, 293313},
			{457669, 291080},
			{459426, 292062},
			{460644, 290760},
			{460825, 293313},
			{462265, 290977},
			{463742, 287001},
			{463742, 288996},
			{464487, 292360},
			{465946, 290068},
			{466541, 286019},
			{466958, 287984},
			{469131, 285662},
			{470143, 287686},
			{470858, 283994},
			{471989, 282178},
			{472495, 285274},
			{472644, 280541},
			{473329, 282535},
			{473984, 283875},
			{475175, 282416},
			{475294, 280571},
			{476931, 281493},
			{478360, 280958},
			{478420, 279677},
			{479819, 281374},
			{480414, 279529},
			{481933, 278933},
			{481933, 280749},
			{482379, 281345},
			{483243, 279707},
			{483838, 281970},
			{484493, 280600},
			{485714, 282178},
			{487589, 280064},
			{487976, 282387},
			{488661, 280600},
			{489525, 283726},
			{489882, 282863},
			{490299, 280303},
			{491192, 281017},
			{491609, 282952},
			{492710, 282357},
			{493157, 280511},
			{493960, 283458},
			{495002, 281315},
			{496432, 283071},
			{497086, 281047},
			{498486, 283071},
			{499587, 278070},
			{500004, 279826},
			{500004, 281761},
			{501374, 274914},
			{501880, 277593},
			{502922, 279588},
			{502981, 274944},
			{503845, 272383},
			{505303, 275748},
			{506494, 268930},
			{506673, 273753},
			{506911, 270716},
			{508668, 275480},
			{509114, 272294},
			{510186, 268662},
			{511228, 267352},
			{511258, 270032},
			{511645, 271848},
			{513431, 265238},
			{513848, 268513},
			{515783, 262440},
			{516349, 266667},
			{516408, 264851},
			{516646, 256962},
			{517450, 259492},
			{518016, 254312},
			{518343, 262410},
			{518581, 264822},
			{519534, 256515},
			{519564, 261844},
			{519802, 259671},
			{520725, 263958},
			{521707, 253419},
			{522005, 263214},
			{522273, 256009},
			{522720, 258718},
			{523732, 250591},
			{524149, 255711},
			{524774, 252734},
			{526620, 256039},
			{528019, 250472},
			{528860, 253148},
			{529773, 248108},
			{530130, 251362},
			{531241, 254299},
			{531281, 248465},
			{532868, 246362},
			{532987, 251243},
			{534574, 248386},
			{536122, 244497},
			{536638, 249815},
			{537352, 246442},
			{539098, 245410},
			{539733, 242791},
			{540209, 249894},
			{540804, 247354},
			{542074, 245053},
			{544455, 251045},
			{544653, 248188},
			{546955, 244735},
			{547510, 252195},
			{548978, 250251},
			{549693, 253981},
			{550010, 247037},
			{552431, 251640},
			{553740, 254100},
			{556796, 253148},
			{557867, 247077},
			{557907, 250053},
			{560803, 249259},
			{561399, 251680},
			{562787, 255172},
			{565843, 253346},
			{566557, 250172},
			{567390, 257076},
			{568859, 253783},
			{570327, 257671},
			{571240, 255370},
			{572152, 249815},
			{573462, 253822},
			{573898, 259695},
			{574335, 255925},
			{576517, 250846},
			{577271, 254775},
			{579176, 250727},
			{579850, 253386},
			{581556, 248624},
			{582549, 250450},
			{583025, 245926},
			{584374, 252751},
			{585485, 248227},
			{587231, 246124},
			{587588, 251402},
			{588501, 249021},
			{589890, 247672},
			{591913, 247870},
			{592389, 243347},
			{593064, 244894},
			{593858, 249299},
			{596000, 245450},
			{596516, 250926},
			{598421, 248902},
			{601437, 252592},
			{601873, 248942},
			{604135, 251322},
			{605286, 257592},
			{606198, 253703},
			{607944, 250886},
			{608460, 255092},
			{610722, 250489},
			{613460, 251759},
			{613658, 255013},
			{616198, 252553},
			{616555, 256045},
			{618380, 249854},
			{618857, 255251},
			{621515, 253029},
			{623222, 255965},
			{624650, 252949},
			{625483, 250688},
			{625563, 261084},
			{627586, 256441},
			{627864, 261878},
			{630404, 259338},
			{630840, 262711},
			{633896, 264973},
			{635245, 261560},
			{636118, 259973},
			{637507, 263584},
			{638895, 259100},
			{639054, 261520},
			{640681, 266123},
			{641237, 262354},
			{642625, 259100},
			{643618, 264814},
			{644133, 256521},
			{644530, 260767},
			{648816, 258425},
			{649054, 262314},
			{650601, 255211},
			{651117, 251362},
			{653022, 260568},
			{653617, 256203},
			{655363, 250608},
			{656950, 252711},
			{659331, 251084},
			{659926, 258782},
			{661514, 254180},
			{663617, 250926},
			{665204, 257037},
			{666037, 259298},
			{668259, 254219},
			{669013, 262274},
			{669886, 258465},
			{673180, 259060},
			{673656, 264060},
			{674648, 275409},
			{675124, 268266},
			{676394, 260806},
			{677942, 265925},
			{678299, 269576},
			{678457, 277432},
			{678973, 272552},
			{679370, 263901},
			{679727, 282234},
			{679965, 260687},
			{680164, 267949},
			{681513, 273187},
			{682306, 264219},
			{683259, 277591},
			{683695, 267354},
			{684330, 281956},
			{685084, 263505},
			{685124, 279258},
			{686116, 266600},
			{687187, 260647},
			{687822, 279099},
			{688258, 267354},
			{688298, 281321},
			{689290, 277234},
			{689647, 263227},
			{690758, 281797},
			{690917, 284853},
			{693973, 282075},
			{694449, 284654},
			{694607, 278186},
			{696671, 283662},
			{699528, 283226}},
		nebula_locations={{458470, 294833},
			{463027, 289973},
			{467127, 295744},
			{468190, 289821},
			{469557, 298022},
			{472542, 305386},
			{472898, 281468},
			{473810, 289062},
			{474213, 339103},
			{475883, 347760},
			{478162, 358087},
			{478465, 310246},
			{479125, 297415},
			{479377, 327712},
			{479680, 317992},
			{479885, 288302},
			{481252, 279949},
			{481655, 350646},
			{483530, 297415},
			{483781, 336369},
			{484237, 343659},
			{485148, 307361},
			{487478, 288302},
			{487578, 329990},
			{488033, 350190},
			{488238, 297719},
			{489097, 359454},
			{489856, 319815},
			{489908, 280101},
			{490378, 349144},
			{490530, 338665},
			{490682, 312238},
			{490986, 332134},
			{491071, 340318},
			{491190, 283156},
			{491289, 305708},
			{491950, 291054},
			{493013, 297888},
			{493434, 326366},
			{494059, 322199},
			{495101, 333449},
			{495309, 299282},
			{495518, 341991},
			{495934, 310949},
			{496425, 364149},
			{497184, 284074},
			{498434, 271366},
			{498851, 354908},
			{500101, 326366},
			{500518, 291782},
			{500726, 305532},
			{501143, 347824},
			{501559, 315116},
			{502184, 279699},
			{502184, 336574},
			{502401, 362162},
			{503643, 298449},
			{505309, 289699},
			{506351, 321783},
			{507601, 331158},
			{507601, 342408},
			{508851, 270949},
			{508851, 281991},
			{509059, 311366},
			{509268, 355324},
			{510310, 302824},
			{510518, 294908},
			{512393, 345741},
			{513226, 336574},
			{515101, 267408},
			{515158, 327231},
			{515310, 317815},
			{515934, 289074},
			{516143, 277199},
			{516768, 282616},
			{517436, 301868},
			{517809, 256783},
			{517809, 352616},
			{518955, 309462},
			{519685, 262824},
			{520474, 332850},
			{520518, 343449},
			{521081, 295945},
			{523018, 270116},
			{523226, 283032},
			{524119, 322067},
			{524893, 253449},
			{525726, 264074},
			{525941, 315385},
			{526549, 289718},
			{526559, 276158},
			{526559, 349283},
			{526559, 357199},
			{526852, 359429},
			{527004, 305817},
			{527460, 339685},
			{528523, 331028},
			{528675, 297919},
			{530934, 249699},
			{531351, 256991},
			{531351, 269282},
			{531712, 283491},
			{531712, 365656},
			{532168, 319182},
			{533383, 310525},
			{533643, 353658},
			{533687, 326472},
			{535358, 345912},
			{535509, 302627},
			{535726, 275949},
			{535965, 362314},
			{536572, 336496},
			{536724, 293818},
			{536768, 263658},
			{537809, 245533},
			{538091, 321156},
			{538243, 373097},
			{539306, 314322},
			{539893, 269699},
			{540066, 283643},
			{541351, 260533},
			{542040, 303842},
			{542809, 350116},
			{543018, 251158},
			{543255, 329357},
			{543559, 339533},
			{544318, 277264},
			{544470, 359580},
			{544470, 366415},
			{544926, 322067},
			{545533, 292603},
			{546748, 374616},
			{546900, 312955},
			{547809, 269699},
			{548874, 353809},
			{549059, 247199},
			{549178, 283491},
			{549178, 300957},
			{549893, 346574},
			{550726, 260741},
			{550934, 253241},
			{551304, 330572},
			{552519, 275745},
			{552823, 316448},
			{553582, 337862},
			{553734, 360947},
			{554190, 323130},
			{554646, 290571},
			{554798, 309310},
			{555253, 369756},
			{555815, 297374},
			{556453, 283236},
			{556768, 348658},
			{557809, 268241},
			{558643, 250949},
			{558643, 355741},
			{558898, 318422},
			{559059, 261574},
			{560113, 330117},
			{560173, 303432},
			{561130, 294929},
			{561236, 275689},
			{561936, 363985},
			{562239, 341204},
			{563362, 286000},
			{564531, 310767},
			{565429, 323738},
			{565518, 253449},
			{566143, 264699},
			{566351, 355949},
			{568011, 349101},
			{568358, 279516},
			{568464, 270056},
			{568783, 294291},
			{569074, 334673},
			{569314, 302795},
			{570696, 318633},
			{570934, 257616},
			{571352, 341507},
			{572393, 283449},
			{572719, 327535},
			{573643, 358658},
			{574204, 311723},
			{575161, 273882},
			{575480, 266017},
			{576351, 252199},
			{576976, 293866},
			{577579, 349405},
			{578018, 361158},
			{578642, 332850},
			{578643, 303449},
			{578851, 287408},
			{579838, 321609},
			{580616, 340444},
			{580794, 279729},
			{580920, 259191},
			{581768, 355533},
			{582708, 315231},
			{583851, 286574},
			{584268, 307199},
			{584834, 270056},
			{585101, 248866},
			{585845, 296025},
			{586691, 330724},
			{586995, 347430},
			{588018, 359491},
			{588362, 264658},
			{588448, 279729},
			{589273, 339381},
			{589729, 254938},
			{589893, 301366},
			{590892, 311617},
			{591143, 287199},
			{591743, 321396},
			{593018, 246574},
			{593018, 353241},
			{594285, 346216},
			{594506, 271863},
			{594613, 282492},
			{595038, 305665},
			{595518, 294074},
			{595652, 330572},
			{596715, 336647},
			{596867, 256154},
			{597019, 264658},
			{597393, 299699},
			{597695, 315763},
			{598652, 288657},
			{600309, 351366},
			{600968, 343026},
			{600990, 278985},
			{601119, 272404},
			{602184, 251574},
			{602486, 323130},
			{602585, 298118},
			{603967, 308109},
			{604157, 317055},
			{605348, 284406},
			{605524, 259798},
			{605524, 268759},
			{606283, 335736},
			{606891, 328294},
			{606976, 351366},
			{608112, 292378},
			{608865, 275442},
			{609268, 252199},
			{609321, 363985},
			{609928, 345152},
			{610232, 316144},
			{612054, 356239},
			{612151, 301944},
			{612510, 268455},
			{612510, 282428},
			{612510, 309765},
			{612814, 322067},
			{613434, 351366},
			{613877, 339533},
			{614029, 330117},
			{615092, 261014},
			{615396, 291388},
			{616003, 360188},
			{616914, 274986},
			{617393, 252824},
			{617674, 284402},
			{619041, 313107},
			{619476, 349491},
			{620256, 297008},
			{620256, 368693},
			{621471, 305665},
			{621774, 338926},
			{622078, 265114},
			{622686, 277720},
			{622686, 329965},
			{623141, 271189},
			{623445, 321460},
			{623643, 253449},
			{624893, 346574},
			{625723, 371427},
			{626027, 314018},
			{626027, 358214},
			{626179, 284706},
			{626768, 257616},
			{627394, 291692},
			{627546, 354417},
			{629216, 273619},
			{629368, 362618},
			{629824, 334977},
			{630887, 264203},
			{631039, 300197},
			{631191, 326776},
			{631768, 343241},
			{632406, 307183},
			{632558, 317663},
			{633924, 360947},
			{634532, 280150},
			{635139, 272708},
			{636051, 287743},
			{637266, 325257},
			{637569, 307943},
			{637601, 262824},
			{637721, 334825},
			{638936, 296097},
			{640607, 317511},
			{640911, 270278},
			{640934, 344074},
			{641063, 278935},
			{642885, 301716},
			{643948, 327839},
			{644100, 284402},
			{645310, 260116},
			{646378, 318574},
			{646768, 309282},
			{646976, 349283},
			{647138, 292755},
			{647664, 276335},
			{647745, 266329},
			{647810, 328658},
			{648353, 303387},
			{648504, 275593},
			{648644, 339700},
			{648728, 294864},
			{649685, 347825},
			{651351, 244283},
			{651765, 301395},
			{652676, 261604},
			{652765, 319807},
			{652909, 285162},
			{653740, 283625},
			{653891, 254010},
			{654284, 328616},
			{654499, 276183},
			{654499, 292434},
			{654739, 341829},
			{655106, 269805},
			{655195, 311605},
			{657184, 245533},
			{658992, 335298},
			{659903, 321629},
			{660934, 254491},
			{661351, 301782},
			{661768, 260324},
			{662393, 248033},
			{662601, 264491},
			{662601, 272408},
			{662601, 283449},
			{662601, 290532},
			{664004, 310694},
			{667041, 318895},
			{668320, 257503},
			{668927, 276487},
			{668927, 302002},
			{669990, 269805},
			{671053, 294257},
			{671509, 263730},
			{672572, 285448},
			{676521, 278158},
			{677128, 270260},
			{677128, 290612},
			{677736, 300180},
			{678191, 263122},
			{680318, 277247},
			{681533, 286511},
			{683203, 294712},
			{684874, 307622},
			{686696, 264033},
			{686848, 280892},
			{689430, 302154},
			{689582, 288182},
			{693379, 293649},
			{694746, 281803}},
		destroy = function(self) -- sigh I am getting less convinced this is a good way, will look at it when I have time for eris
			assert(type(self)=="table")
			for i=1,#self.all_objects do
				local obj=self.all_objects[i]
				if obj:isValid() then
					obj:destroy()
				end
			end
		end
	}
	for i=1,#wip.asteroid_locations do
		table.insert(wip.all_objects,Asteroid():setPosition(wip.asteroid_locations[i][1],wip.asteroid_locations[i][2]))
	end
	for i=1,#wip.mine_locations do
		table.insert(wip.all_objects,Mine():setPosition(wip.mine_locations[i][1],wip.mine_locations[i][2]))
	end
	for i=1,#wip.nebula_locations do
		table.insert(wip.all_objects,Nebula():setPosition(wip.nebula_locations[i][1],wip.nebula_locations[i][2]))
	end
	table.insert(wip.all_objects,SpaceStation():setTemplate("Large Station"):setFaction("Ghosts"):setCallSign("hal 9000"):setPosition(643891, 298289))
	table.insert(wip.all_objects,SpaceStation():setTemplate("Medium Station"):setFaction("Ghosts"):setCallSign("A7M2"):setPosition(578512, 296192))
	table.insert(wip.all_objects,SpaceStation():setTemplate("Medium Station"):setFaction("Ghosts"):setCallSign("AM"):setPosition(586051, 288731))
	table.insert(wip.all_objects,SpaceStation():setTemplate("Medium Station"):setFaction("Ghosts"):setCallSign("Glados"):setPosition(586084, 303815))
	table.insert(wip.all_objects,SpaceStation():setTemplate("Medium Station"):setFaction("Ghosts"):setCallSign("dr. theopolis"):setPosition(593648, 296247))
	table.insert(wip.all_objects,SpaceStation():setTemplate("Small Station"):setFaction("Ghosts"):setCallSign("Astrolabe"):setPosition(581293, 291121))
	table.insert(wip.all_objects,SpaceStation():setTemplate("Small Station"):setFaction("Ghosts"):setCallSign("Sextant"):setPosition(591362, 291885))
	table.insert(wip.all_objects,SpaceStation():setTemplate("Small Station"):setFaction("Ghosts"):setCallSign("TAIRseach"):setPosition(591223, 301850))
	table.insert(wip.all_objects,SpaceStation():setTemplate("Small Station"):setFaction("Ghosts"):setCallSign("Wykres"):setPosition(581154, 301850))
	table.insert(wip.all_objects,SpaceStation():setTemplate("Small Station"):setFaction("Ghosts"):setCallSign("processing center delta"):setPosition(602274, 282095))
	table.insert(wip.all_objects,SpaceStation():setTemplate("Small Station"):setFaction("Ghosts"):setCallSign("resource processing Gamma"):setPosition(572772, 281978))
	table.insert(wip.all_objects,SpaceStation():setTemplate("Small Station"):setFaction("Ghosts"):setCallSign("resource processing alpha"):setPosition(603272, 309987))
	table.insert(wip.all_objects,SpaceStation():setTemplate("Small Station"):setFaction("Ghosts"):setCallSign("resource processing beta"):setPosition(573352, 309694))
	return wip
end
----------------------------------------------------
--	Initial Set Up > Player Ships > Tweak Player  --
----------------------------------------------------
-- Button Text	   FD*	Related Function(s)
-- -MAIN			F	initialGMFunctions
-- -SETUP			F	initialSetUp
-- -PLAYER SHIP		F	playerShip
-- +ENGINEERING		F	tweakEngineering
-- +CARGO			F	changePlayerCargo
-- +REPUTATION		F	changePlayerReputation
-- +PLAYER MESSAGE	F	playerMessage
function tweakPlayerShip()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Player Ship",playerShip)
	addGMFunction("+Engineering",tweakEngineering)
	addGMFunction("+Cargo",changePlayerCargo)
	addGMFunction("+Reputation",changePlayerReputation)
	addGMFunction("+Player Message",playerMessage)
	addGMFunction("get hacked status",singleCPUShipFunction(GMmessageHackedStatus))
end
-----------------------------------------------
--	Initial Set Up > Player Ships > Current  --
-----------------------------------------------
-- Button Text	   FD*	Related Function(s)
-- -MAIN			F	initialGMFunctions
-- -SETUP			F	initialSetUp
-- -PLAYER SHIP		F	playerShip
-- Button to spawn each currently active player ship name
function activePlayerShip()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Player Ship",playerShip)
	for shipNum = 1, #playerShipInfo do
		if playerShipInfo[shipNum][2] == "active" then
			addGMFunction(playerShipInfo[shipNum][1],playerShipInfo[shipNum][3])
		end
	end
end
------------------------------------------------
--	Initial Set Up > Player Ships > Scrapped  --
------------------------------------------------
-- Button Text	   FD*	Related Function(s)
-- -MAIN			F	initialGMFunctions
-- -SETUP			F	initialSetUp
-- -PLAYER SHIP		F	playerShip
-- Button to spawn each currently inactive or scrapped player ship name
function inactivePlayerShip()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Player Ship",playerShip)
	for shipNum = 1, #playerShipInfo do
		if playerShipInfo[shipNum][2] == "inactive" then
			addGMFunction(playerShipInfo[shipNum][1],playerShipInfo[shipNum][3])
		end
	end
end
----------------------------------------------------
--	Initial Set Up > Player Ships > Descriptions  --
----------------------------------------------------
-- -MAIN			   FD*	initialGMFunctions
-- -SETUP				F	initialSetUp
-- -PLAYER SHIPS		F	playerShip
-- +DESCRIBE CURRENT	F	describeCurrentSpecialPlayerShips
-- +DESCRIBE SCRAPPED	F	describeScrappedSpecialPlayerShips
-- +DESCRIBE STOCK		F	describeStockPlayerShips
function describePlayerShips()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Player Ships",playerShip)
	addGMFunction("+Describe Current",describeCurrentSpecialPlayerShips)
	addGMFunction("+Describe Scrapped",describeScrappedSpecialPlayerShips)
	addGMFunction("+Describe Stock",describeStockPlayerShips)
end
--------------------------------------------------------
--	Initial Set Up > Player Ships > Teleport Players  --
--------------------------------------------------------
-- -MAIN			   FD*	initialGMFunctions
-- -SETUP				F	initialSetUp
-- -PLAYER SHIPS		F	playerShip
-- TO ICARUS			F	inline
-- TO KENTAR			F	inline
function teleportPlayers()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Player Ships",playerShip)
	addGMFunction("To Icarus",function()
		for pidx=1,32 do
			local p = getPlayerShip(pidx)
			if p ~= nil and p:isValid() then
				p:setPosition(0,0)
			end
		end
		addGMMessage("Players teleported to Icarus")
	end)
	addGMFunction("To Kentar",function()
		for pidx=1,32 do
			local p = getPlayerShip(pidx)
			if p ~= nil and p:isValid() then
				p:setPosition(250000,250000)
			end
		end
		addGMMessage("Players teleported to Kentar")
	end)
end
------------------------------------------------------------------
--	Initial Set Up > Player Ships > Tweak Player > Engineering  --
------------------------------------------------------------------
-- Button Text	   FD*	Related Function(s)
-- -MAIN			F	initialGMFunctions
-- -SETUP			F	initialSetUp
-- -PLAYER SHIP		F	playerShip
-- -TWEAK PLAYER	F	tweakPlayerShip
-- +AUTO COOL		F	autoCool
-- +AUTO REPAIR		F	autoRepair
-- +COOLANT			F	changePlayerCoolant
-- +REPAIR CREW		F	changePlayerRepairCrew
-- +MAX SYSTEM		F	changePlayerMaxSystem
function tweakEngineering()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Player Ship",playerShip)
	addGMFunction("-Tweak Player",tweakPlayerShip)
	addGMFunction("+Auto Cool",autoCool)
	addGMFunction("+Auto Repair",autoRepair)
	addGMFunction("+Coolant",changePlayerCoolant)
	addGMFunction("+Repair Crew",changePlayerRepairCrew)
	addGMFunction("+Max System",changePlayerMaxSystem)
	addGMFunction("shields degrade",shieldsDegrade)
	addGMFunction("shields regen",shieldsRegen)
	addGMFunction("bleed energy",bleedEnergy)
	addGMFunction("restore energy",restoreEnergy)
end
-----------------------------------------------------------------------------
--	Initial Set Up > Player Ships > Tweak Player > Engineering > Auto Cool --
-----------------------------------------------------------------------------
-- Button Text	   FD*	Related Function(s)
-- -MAIN			F	initialGMFunctions
-- -SETUP			F	initialSetUp
-- -FROM AUTO COOL	F	tweakPlayerShip
-- Button to toggle auto cool for each player ship already spawned
function autoCool()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Tweak Player",tweakPlayerShip)
	addGMFunction("-From Auto Cool",tweakEngineering)
	for pidx=1,8 do
		local p = getPlayerShip(pidx)
		if p ~= nil and p:isValid() then
			if p.autoCoolant == nil then
				p.autoCoolant = false
			end
			local button_label = p:getCallSign()
			if p.autoCoolant then
				button_label = button_label .. " on"
			else
				button_label = button_label .. " off"
			end
			addGMFunction(button_label,function()
				if p.autoCoolant then
					p.autoCoolant = false
					p:setAutoCoolant(false)
				else
					p.autoCoolant = true
					p:setAutoCoolant(true)
				end
				autoCool()
			end)
		end
	end
end
-------------------------------------------------------------------------------
--	Initial Set Up > Player Ships > Tweak Player > Engineering > Auto Repair --
-------------------------------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN				F	initialGMFunctions
-- -SETUP				F	initialSetUp
-- -FROM AUTO REPAIR	F	tweakPlayerShip
-- Button to toggle auto cool for each player ship already spawned
function autoRepair()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Tweak Player",tweakPlayerShip)
	addGMFunction("-From Auto Repair",tweakEngineering)
	for pidx=1,8 do
		local p = getPlayerShip(pidx)
		if p ~= nil and p:isValid() then
			if p.auto_repair == nil then
				p.auto_repair = false
			end
			local button_label = p:getCallSign()
			if p.auto_repair then
				button_label = button_label .. " on"
			else
				button_label = button_label .. " off"
			end
			addGMFunction(button_label,function()
				if p.auto_repair then
					p.auto_repair = false
					p:commandSetAutoRepair(false)
				else
					p.auto_repair = true
					p:commandSetAutoRepair(true)
				end
				autoRepair()
			end)
		end
	end
end
----------------------------------------------------------------------------
--	Initial Set Up > Player Ships > Tweak Player > Engineering > Coolant  --
----------------------------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN				F	initialGMFunctions
-- -SETUP				F	initialSetUp
-- -TWEAK PLAYER		F	tweakPlayerShip
-- ADD 1.0 COOLANT		D	inline (add coolant to selected player ship)
-- REMOVE 1.0 COOLANT	D	inline (remove coolant from selected player ship)
-- 1.0 - 0.5 = 0.5		D	inline (decrease coolant change value)
-- 1.0 + 0.5 = 1.5		D	inline (increase coolant change value)
function changePlayerCoolant()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Tweak Player",tweakPlayerShip)
	addGMFunction("-Engineering",tweakEngineering)
	addGMFunction(string.format("Add %.1f coolant",coolant_amount), function()
		local p = playerShipSelected()
		if p ~= nil then
			local coolant_reason_given = false
			p:setMaxCoolant(p:getMaxCoolant() + coolant_amount)
			addGMMessage(string.format("%.1f coolant added to %s for a new total of %.1f coolant",coolant_amount,p:getCallSign(),p:getMaxCoolant()))
			for i=1,#regionStations do
				if p:isDocked(regionStations[i]) then
					if p:hasPlayerAtPosition("Engineering") then
						p:addCustomMessage("Engineering","coolant_bonus_message",string.format("A kind-hearted quartermaster on %s donated some coolant to your coolant supply",regionStations[i]:getCallSign()))
						coolant_reason_given = true
						break
					end
				end
			end
			if not coolant_reason_given then
				if p:hasPlayerAtPosition("Engineering") then
					p:addCustomMessage("Engineering","coolant_bonus_message","Additional coolant was added. It was missed during the last inventory cycle")
				end
			end
		else
			addGMMessage("No player selected. No action taken")
		end
		changePlayerCoolant()
	end)
	addGMFunction(string.format("Remove %.1f coolant",coolant_amount), function()
		local p = playerShipSelected()
		if p ~= nil then
			local coolant_reason_given = false
			p:setMaxCoolant(p:getMaxCoolant() - coolant_amount)
			addGMMessage(string.format("%.1f coolant removed from %s for a new total of %.1f coolant",coolant_amount,p:getCallSign(),p:getMaxCoolant()))
			for i=1,#regionStations do
				if p:isDocked(regionStations[i]) then
					if p:hasPlayerAtPosition("Engineering") then
						p:addCustomMessage("Engineering","coolant_loss_message",string.format("Station docking fees for %s were paid for in coolant",regionStations[i]:getCallSign()))
						coolant_reason_given = true
						break
					end
				end
			end
			if not coolant_reason_given then
				if p:hasPlayerAtPosition("Engineering") then
					p:addCustomMessage("Engineering","coolant_loss_message","Coolant was lost due to a malfunctioning system. You corrected the problem before it got any worse")
				end
			end
		else
			addGMMessage("No player selected. No action taken")
		end
		changePlayerCoolant()
	end)
	if coolant_amount > .5 then
		addGMFunction(string.format("%.1f - %.1f = %.1f",coolant_amount,.5,coolant_amount-.5),function()
			coolant_amount = coolant_amount - .5
			changePlayerCoolant()
		end)
	end
	if coolant_amount < 10 then
		addGMFunction(string.format("%.1f + %.1f = %.1f",coolant_amount,.5,coolant_amount+.5),function()
			coolant_amount = coolant_amount + .5
			changePlayerCoolant()
		end)
	end
end
--------------------------------------------------------------------------------
--	Initial Set Up > Player Ships > Tweak Player > Engineering > Repair Crew  --
--------------------------------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN				F	initialGMFunctions
-- -SETUP				F	initialSetUp
-- -TWEAK PLAYER		F	tweakPlayerShip
-- ADD REPAIR CREW		F	inline
-- REMOVE REPAIR CREW	F	inline
function changePlayerRepairCrew()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Tweak Player",tweakPlayerShip)
	addGMFunction("-Engineering",tweakEngineering)
	addGMFunction("Add repair crew", function()
		local p = playerShipSelected()
		if p ~= nil then
			local crew_reason_given = false
			p:setRepairCrewCount(p:getRepairCrewCount()+1)
			addGMMessage(string.format("1 repair crew added to %s for a new total of %i repair crew",p:getCallSign(),p:getRepairCrewCount()))
			for i=1,#regionStations do
				if p:isDocked(regionStations[i]) then
					if p:hasPlayerAtPosition("Engineering") then
						p:addCustomMessage("Engineering","added_repair_crew_message",string.format("A volunteer from station %s has boarded to work as one of your repair crew",regionStations[i]:getCallSign()))
						crew_reason_given = true
						break
					end
				end
			end
			if not crew_reason_given then
				if p:hasPlayerAtPosition("Engineering") then
					p:addCustomMessage("Engineering","added_repair_crew_message","A crew member from a different department has completed training and has transferred to your repair crew")
				end
			end
		else
			addGMMessage("No player selected. No action taken")
		end
		changePlayerRepairCrew()
	end)
	addGMFunction("Remove repair crew", function()
		local p = playerShipSelected()
		if p ~= nil then
			local crew_reason_given = false
			if p:getRepairCrewCount() > 0 then
				p:setRepairCrewCount(p:getRepairCrewCount()-1)
				addGMMessage(string.format("1 repair crew removed from %s for a new total of %i repair crew",p:getCallSign(),p:getRepairCrewCount()))
				for i=1,#regionStations do
					if p:isDocked(regionStations[i]) then
						if p:hasPlayerAtPosition("Engineering") then
							p:addCustomMessage("Engineering","removed_repair_crew_message",string.format("One of your repair crew has disembarked on to station %s claiming his work contract has been fulfilled",regionStations[i]:getCallSign()))
							crew_reason_given = true
							break
						end
					end
				end
				if not crew_reason_given then
					if p:hasPlayerAtPosition("Engineering") then
						p:addCustomMessage("Engineering","removed_repair_crew_message","One of your repair crew has become debilitatingly ill and can no longer conduct any repairs")
					end
				end
			end
		else
			addGMMessage("No player selected. No action taken")
		end
		changePlayerRepairCrew()
	end)
end
-------------------------------------------------------------------------------
--	Initial Set Up > Player Ships > Tweak Player > Engineering > Max System  --
-------------------------------------------------------------------------------
-- Button text		   FD*	Related Function(s)
-- -FROM MAX SYSTEM		F	tweakPlayerShip
-- +REACTOR 1.00		D	changePlayerMaxReactor
-- +BEAM 1.00			D	changePlayerMaxBeam
-- +MISSILE 1.00		D	changePlayerMaxMissile
-- +MANEUVER 1.00		D	changePlayerMaxManeuver
-- +IMPULSE 1.00		D	changePlayerMaxImpulse
-- +WARP 1.00			D	changePlayerMaxWarp
-- +JUMP 1.00			D	changePlayerMaxJump
-- +FRONT SHIELD 1.00	D	changePlayerMaxFrontShield
-- +REAR SHIELD 1.00	D	changePlayerMaxRearShield
function changePlayerMaxSystem()
	clearGMFunctions()
	addGMFunction("-From Max System",tweakEngineering)
	local p = playerShipSelected()
	if p ~= nil then
		string.format("")	--necessary to have global reference for Serious Proton engine
		addGMFunction(string.format("+Reactor %.2f",p.max_reactor),changePlayerMaxReactor)
		addGMFunction(string.format("+Beam %.2f",p.max_beam),changePlayerMaxBeam)
		addGMFunction(string.format("+Missile %.2f",p.max_missile),changePlayerMaxMissile)
		addGMFunction(string.format("+Maneuver %.2f",p.max_maneuver),changePlayerMaxManeuver)
		addGMFunction(string.format("+Impulse %.2f",p.max_impulse),changePlayerMaxImpulse)
		addGMFunction(string.format("+Warp %.2f",p.max_warp),changePlayerMaxWarp)
		addGMFunction(string.format("+Jump %.2f",p.max_jump),changePlayerMaxJump)
		addGMFunction(string.format("+Front Shield %.2f",p.max_front_shield),changePlayerMaxFrontShield)
		addGMFunction(string.format("+Rear Shield %.2f",p.max_rear_shield),changePlayerMaxRearShield)
	else
		addGMFunction("+Select Player",changePlayerMaxSystem)
	end
end
------------------------------------------------------------
--	Initial Set Up > Player Ships > Tweak Player > Cargo  --
------------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN FROM CARGO		F	initialGMFunctions
-- -SETUP				F	initialSetUp
-- -TWEAK PLAYER		F	tweakPlayerShip
-- +REMOVE CARGO		F	removeCargo
-- +ADD MINERAL			F	addMineralCargo
-- +ADD COMPONENT		F	addComponentCargo
function changePlayerCargo()
	clearGMFunctions()
	addGMFunction("-Main from Cargo",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Tweak Player",tweakPlayerShip)
	addGMFunction("+Remove Cargo",removeCargo)
	addGMFunction("+Add Mineral",addMineralCargo)
	addGMFunction("+Add Component",addComponentCargo)
end
function playerShipSelected()
	local p = getPlayerShip(-1)
	local object_list = getGMSelection()
	local selected_matches_player = false
	for i=1,#object_list do
		local current_selected_object = object_list[i]
		for pidx=1,8 do
			p = getPlayerShip(pidx)
			if p ~= nil and p:isValid() then
				if p == current_selected_object then
					selected_matches_player = true
					break
				end
			end
		end
		if selected_matches_player then
			break
		end
	end
	if selected_matches_player then
		return p
	end
	return nil
end
---------------------------------------------------------------------------
--	Initial Set Up > Player Ships > Tweak Player > Cargo > Remove Cargo  --
---------------------------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -CARGO FROM DEL		F	changePlayerCargo
-- One button for each type of cargo in the selected player ship
function removeCargo()
	clearGMFunctions()
	addGMFunction("-Cargo From Del",changePlayerCargo)
	local p = playerShipSelected()
	if p ~= nil then
		if p.goods ~= nil then
			local cargo_found = false
			for good, good_quantity in pairs(p.goods) do
				if good_quantity > 0 then
					cargo_found = true
					addGMFunction(good,function()
						p.goods[good] = p.goods[good] - 1
						p.cargo = p.cargo + 1
						addGMMessage(string.format("one %s removed",good))
						removeCargo()
					end)
				end
			end
			if not cargo_found then
				addGMMessage("selected player has no cargo to delete")
				changePlayerCargo()
			end
		else
			addGMMessage("selected player has no cargo to delete")
			changePlayerCargo()
		end
	else
		addGMMessage("No player selected. No action taken")
		changePlayerCargo()
	end
end
--------------------------------------------------------------------------------
--	Initial Set Up > Player Ships > Tweak Player > Cargo > Add Mineral Cargo  --
--------------------------------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -CARGO FROM ADD		F	changePlayerCargo
-- One button for each mineral cargo type
function addMineralCargo()
	clearGMFunctions()
	addGMFunction("-Cargo From Add",changePlayerCargo)
	local p = playerShipSelected()
	if p ~= nil then
		for _, good in pairs(mineralGoods) do
			addGMFunction(good,function()
				if p.cargo > 0 then
					if p.goods == nil then
						p.goods = {}
					end
					if p.goods[good] == nil then
						p.goods[good] = 0
					end
					p.goods[good] = p.goods[good] + 1
					p.cargo = p.cargo - 1
					addGMMessage(string.format("one %s added",good))
				else
					addGMMessage("Insufficient cargo space")
					changePlayerCargo()
					return
				end
				addMineralCargo()			
			end)
		end
	else
		addGMMessage("No player selected. No action taken")
		changePlayerCargo()
	end
end
----------------------------------------------------------------------------------
--	Initial Set Up > Player Ships > Tweak Player > Cargo > Add Component Cargo  --
----------------------------------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -CARGO FROM ADD		F	changePlayerCargo
-- One button for each component cargo type
function addComponentCargo()
	clearGMFunctions()
	addGMFunction("-Cargo From Add",changePlayerCargo)
	local p = playerShipSelected()
	if p ~= nil then
		for _, good in pairs(componentGoods) do
			addGMFunction(good,function()
				if p.cargo > 0 then
					if p.goods == nil then
						p.goods = {}
					end
					if p.goods[good] == nil then
						p.goods[good] = 0
					end
					p.goods[good] = p.goods[good] + 1
					p.cargo = p.cargo - 1
					addGMMessage(string.format("one %s added",good))
				else
					addGMMessage("Insufficient cargo space")
				end
				addComponentCargo()			
			end)
		end
	else
		addGMMessage("No player selected. No action taken")
	end
end
-----------------------------------------------------------------
--	Initial Set Up > Player Ships > Tweak Player > Reputation  --
-----------------------------------------------------------------
-- Button text	   FD*	Related Function(s)
-- -MAIN FROM REP	F	initialGMFunctions
-- -SETUP			F	initialSetUp
-- -TWEAK PLAYER	F	tweakPlayerShip
-- ADD ONE REP n	D	inline
-- ADD FIVE REP n	D	inline
-- ADD TEN REP n	D	inline
-- DEL ONE REP n	D	inline
-- DEL FIVE REP n	D	inline
-- DEL TEN REP n	D	inline
function changePlayerReputation()
	clearGMFunctions()
	addGMFunction("-Main From Rep",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Tweak Player",tweakPlayerShip)
	local p = playerShipSelected()
	if p ~= nil then
		local current_rep = math.floor(p:getReputationPoints())
		addGMFunction(string.format("Add one rep %i",current_rep),function()
			p:addReputationPoints(1)
			changePlayerReputation()
		end)
		addGMFunction(string.format("Add five rep %i",current_rep),function()
			p:addReputationPoints(5)
			changePlayerReputation()
		end)
		addGMFunction(string.format("Add ten rep %i",current_rep),function()
			p:addReputationPoints(10)
			changePlayerReputation()
		end)
		if current_rep > 0 then
			addGMFunction(string.format("Del one rep %i",current_rep),function()
				p:takeReputationPoints(1)
				changePlayerReputation()
			end)
		end
		if current_rep > 5 then
			addGMFunction(string.format("Del five rep %i",current_rep),function()
				p:takeReputationPoints(5)
				changePlayerReputation()
			end)
		end
		if current_rep > 10 then
			addGMFunction(string.format("Del ten rep %i",current_rep),function()
				p:takeReputationPoints(10)
				changePlayerReputation()
			end)
		end
	else
		addGMMessage("No player selected. No action taken. No reputation options presented")
		tweakPlayerShip()
	end
end
---------------------------------------------------------------------
--	Initial Set Up > Player Ships > Tweak Player > Player Message  --
---------------------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN FROM PLYR MSG	F	initialGMFunctions
-- -SETUP				F	initialSetUp
-- -PLAYER SHIP			F	playerShip
-- -TWEAK PLAYER		F	tweakPlayerShip
-- +CONSOLE MESSAGE		F	playerConsoleMessage
-- +SHIP LOG MSG		F	playerShipLogMessage
function playerMessage()
	clearGMFunctions()
	addGMFunction("-Main from plyr msg",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Player Ship",playerShip)
	addGMFunction("-Tweak player",tweakPlayerShip)
	addGMFunction("+Console Message",playerConsoleMessage)
	addGMFunction("+Ship Log Msg",playerShipLogMessage)
	addGMFunction("+Hail Message",playerHailMessage)
end
----------------------------------------------------------------------
--	Initial Set Up > Player Ships > Tweak Player > Console Message  --
----------------------------------------------------------------------
-- Button text	   FD*	Related Function(s)
-- -MAIN FROM CNSL MSG	F	initialGMFunctions
-- -SETUP				F	initialSetUp
-- -TWEAK PLAYER		F	tweakPlayerShip
-- +SELECT MSG OBJ		F	changeMessageObject
function playerConsoleMessage()
	clearGMFunctions()
	addGMFunction("-Main From Cnsl Msg",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Tweak Player",tweakPlayerShip)
	addGMFunction("-Player Message",playerMessage)
	if message_object == nil then
		addGMFunction("+Select Msg Obj",changeMessageObject)
	else
		addGMFunction("+Change Msg Obj",changeMessageObject)
		local p = playerShipSelected()
		if p ~= nil then
			addGMFunction("+Send to console",sendPlayerConsoleMessage)
		else
			addGMFunction("+Select Player",playerConsoleMessage)
		end
	end
end
function changeMessageObject()
	local object_list = getGMSelection()
	if object_list ~= nil then
		if #object_list == 1 then
			message_object = object_list[1]
			addGMMessage(string.format("Object in %s selected to pass messages to player console.\nplace message in description field",message_object:getSectorName()))
		else
			addGMMessage("Select only one object to use to pass messages via its description field. No action taken")
		end
	else
		addGMMessage("Select an object to use to pass messages via its description field. No action taken")
	end 
end
-----------------------------------------------------------------------
--	Initial Set Up > Player Ships > Tweak Player > Ship Log Message  --
-----------------------------------------------------------------------
-- Button text		   FD*	Related Function(s)
-- -MAIN FROM SHIP MSG	F	initialGMFunctions
-- -SETUP				F	initialSetUp
-- -TWEAK PLAYER		F	tweakPlayerShip
-- -PLAYER MESSAGE		F	playerMessage
-- +SRC:UNKNOWN			D	playerMessageSource
-- +SELECT MSG OBJ		D	changeMessageObject
-- +PSHIP:ALL			D	setPlayerShipMessageDestination
-- +COLOR:MAGENTA		D	setPlayerShipLogMessageColor
-- PREVIEW				F	inline
-- SEND					F	inline
function playerShipLogMessage()
	clearGMFunctions()
	addGMFunction("-Main From Ship Msg",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Tweak Player",tweakPlayerShip)
	addGMFunction("-Player Message",playerMessage)
	if player_message_source == nil then
		player_message_source = "Unknown"
	end
	if type(player_message_source) == "string" then
		addGMFunction(string.format("+Src:%s",player_message_source),playerMessageSource)
	else
		addGMFunction(string.format("+Src:%s",player_message_source:getCallSign()),playerMessageSource)
	end
	if message_object == nil then
		addGMFunction("+Select Msg Obj",changeMessageObject)
	else
		addGMFunction("+Change Msg Obj",changeMessageObject)
	end
	if player_ship_message_destination == nil then
		player_ship_message_destination = "All"
	end
	local button_label = "+pShip"
	if type(player_ship_message_destination) == "string" then
		button_label = button_label .. ":All"
	else
		button_label = string.format("%s:%s",button_label,player_ship_message_destination:getCallSign())
	end
	set_player_ship_message_destination_caller = playerShipLogMessage
	addGMFunction(button_label,setPlayerShipMessageDestination)
	addGMFunction(string.format("+Color:%s",color_list[player_ship_log_message_color]),setPlayerShipLogMessageColor)
	addGMFunction("Preview",function()
		local preview_message = "Clicking send will send the following message:"
		if message_object ~= nil then
			preview_message = string.format("%s\n%s",preview_message,message_object:getDescription())
			preview_message = preview_message .. "\nIdentified as coming from"
			if type(player_message_source) == "string" then
				if message_source_object ~= nil then
					local source = message_source_object:getDescription()
					if source ~= nil then
						player_message_source = source
					end
				end
				preview_message = string.format("%s\n%s",preview_message,player_message_source)
			else
				preview_message = string.format("%s\n%s in sector %s",preview_message,player_message_source:getCallSign(),player_message_source:getSectorName())
			end
			if type(player_ship_message_destination) == "string" then
				preview_message = string.format("%s\nTo all player ship logs",preview_message)
			else
				preview_message = string.format("%s\nTo %s's ship log",preview_message,player_ship_message_destination:getCallSign())
			end
			preview_message = string.format("%s\nIn this color: %s",preview_message,color_list[player_ship_log_message_color])
		else
			preview_message = preview_message .. "\nno message because no message object has been selected"
		end
		addGMMessage(preview_message)
	end)
	addGMFunction("Send",function()
		local ship_log_message = ""
		if type(player_message_source) == "string" then
			if message_source_object ~= nil then
				local source = message_source_object:getDescription()
				if source ~= nil then
					player_message_source = source
				end
			end
			ship_log_message = string.format("[%s] %s",player_message_source,message_object:getDescription())
		else
			ship_log_message = string.format("[%s in %s] %s",player_message_source:getCallSign(),player_message_source:getSectorName(),message_object:getDescription())
		end
		if type(player_ship_message_destination) == "string" then
			for pidx=1,32 do
				local p = getPlayerShip(pidx)
				if p ~= nil and p:isValid() then
					p:addToShipLog(ship_log_message,player_ship_log_message_color)
				end
			end
		else
			player_ship_message_destination:addToShipLog(ship_log_message,player_ship_log_message_color)
		end
		local confirmation_message = string.format("Message...\n%s\nsent to\n",ship_log_message)
		if type(player_ship_message_destination) == "string" then
			confirmation_message = string.format("%sAll player ships colored in %s",confirmation_message,color_list[player_ship_log_message_color])
		else
			confirmation_message = string.format("%s%s colored in %s",confirmation_message,player_ship_message_destination:getCallSign(),color_list[player_ship_log_message_color])
		end
		addGMMessage(confirmation_message)
	end)
end
function playerHailMessage()
	clearGMFunctions()
	addGMFunction("-Main From Hail Msg",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Tweak Player",tweakPlayerShip)
	addGMFunction("-Player Message",playerMessage)
	if player_message_source == nil or type(player_message_source) == "string" then
		addGMFunction("+Source",playerMessageObjectSource)
	else
		addGMFunction(string.format("+Src:%s",player_message_source:getCallSign()),playerMessageObjectSource)
	end
	if message_object == nil then
		addGMFunction("+Select Msg Obj",changeMessageObject)
	else
		addGMFunction("+Change Msg Obj",changeMessageObject)
	end
	if player_ship_message_destination == nil then
		player_ship_message_destination = "All"
	end
	local button_label = "+pShip"
	if type(player_ship_message_destination) == "string" then
		button_label = button_label .. ":All"
	else
		button_label = string.format("%s:%s",button_label,player_ship_message_destination:getCallSign())
	end
	set_player_ship_message_destination_caller = playerHailMessage
	addGMFunction(button_label,setPlayerShipMessageDestination)
	addGMFunction("Preview",function()
		local preview_message = "Clicking send will send the following message:"
		if message_object ~= nil then
			preview_message = string.format("%s\n%s",preview_message,message_object:getDescription())
			preview_message = preview_message .. "\nIdentified as coming from"
			if player_message_source == nil or type(player_message_source) == "string" then
				preview_message = preview_message .. "\nNobody (message will not go out). You need to select a message source"
			else
				preview_message = string.format("%s\n%s in sector %s",preview_message,player_message_source:getCallSign(),player_message_source:getSectorName())
			end
			if type(player_ship_message_destination) == "string" then
				preview_message = string.format("%s\nTo all player ships",preview_message)
			else
				preview_message = string.format("%s\nTo %s",preview_message,player_ship_message_destination:getCallSign())
			end
		else
			preview_message = preview_message .. "\nNo message because no message object has been selected"
		end
		addGMMessage(preview_message)
	end)
	addGMFunction("Send",function()
		local hail_message = ""
		if player_message_source == nil or type(player_message_source) == "string" then
			addGMMessage("You need to select a message source. No action taken")
			return
		else
			hail_message = string.format("[Sector %s] %s",player_message_source:getSectorName(),message_object:getDescription())
		end
		if type(player_ship_message_destination) == "string" then
			for pidx=1,32 do
				local p = getPlayerShip(pidx)
				if p ~= nil and p:isValid() then
					player_message_source:sendCommsMessage(p,hail_message)
				end
			end
		else
			player_message_source:sendCommsMessage(player_ship_message_destination,hail_message)
		end
		local confirmation_message = string.format("Message...\n%s\nsent to\n",hail_message)
		if type(player_ship_message_destination) == "string" then
			confirmation_message = string.format("%sAll player ships",confirmation_message)
		else
			confirmation_message = string.format("%s%s",confirmation_message,player_ship_message_destination:getCallSign())
		end
		addGMMessage(confirmation_message)
	end)
end
function playerMessageObjectSource()
	clearGMFunctions()
	addGMFunction("-Main Frm Msg Src",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Tweak Player",tweakPlayerShip)
	addGMFunction("-Player Message",playerMessage)
	addGMFunction("-Hail Message",playerHailMessage)
	local stations_and_ships = {}
	for _, station in pairs(regionStations) do
		if station ~= nil and station:isValid() then
			table.insert(stations_and_ships,{object=station,name=station:getCallSign()})
		end
	end
	if region_ships ~= nil then
		for _, ship in pairs(region_ships) do
			if ship ~= nil and ship:isValid() then
				table.insert(stations_and_ships,{object=ship,name=ship:getCallSign()})
			end
		end
	end
	for _, station in pairs(skeleton_stations) do
		if station ~= nil and station:isValid() then
			table.insert(stations_and_ships,{object=station,name=station:getCallSign()})
		end
	end
	table.sort(stations_and_ships,function(a,b)
		return a.name < b.name
	end)
	for _,item in ipairs(stations_and_ships) do
		button_label = item.name
		if type(player_message_source) == "table" and player_message_source == item.object then
			button_label = button_label .. "*"
		end
		addGMFunction(button_label,function()
			player_message_source = item.object
			playerMessageObjectSource()
		end)
	end
end
----------------------------------------------------------------------------------------
--	Initial Set Up > Player Ships > Tweak Player > Ship Log Message > Message Source  --
----------------------------------------------------------------------------------------
-- Button text		   FD*	Related Function(s)
-- -MAIN FROM SHIP MSG	F	initialGMFunctions
-- -SETUP				F	initialSetUp
-- -TWEAK PLAYER		F	tweakPlayerShip
-- -PLAYER MESSAGE		F	playerMessage
-- -SHIP LOG MSG		F	playerShipLogMessage
-- UNKNOWN				*	inline
-- +INPUT				D*	inputMessageSource
-- List of stations and ships, inline function for each
function playerMessageSource()
	clearGMFunctions()
	addGMFunction("-Main Frm Msg Src",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Tweak Player",tweakPlayerShip)
	addGMFunction("-Player Message",playerMessage)
	addGMFunction("-Ship Log Msg",playerShipLogMessage)
	local button_label = "Unknown"
	if type(player_message_source) == "string" and player_message_source == "Unknown" then
		button_label = button_label .. "*"
	end
	addGMFunction(button_label,function()
		player_message_source = "Unknown"
		playerMessageSource()
	end)
	button_label = "+Input"
	if type(player_message_source) == "string" and player_message_source ~= "Unknown" then
		button_label = string.format("+%s*",player_message_source)
	end
	addGMFunction(button_label,inputMessageSource)
	local stations_and_ships = {}
	for _, station in pairs(regionStations) do
		if station ~= nil and station:isValid() then
			table.insert(stations_and_ships,{object=station,name=station:getCallSign()})
		end
	end
	if region_ships ~= nil then
		for _, ship in pairs(region_ships) do
			if ship ~= nil and ship:isValid() then
				table.insert(stations_and_ships,{object=ship,name=ship:getCallSign()})
			end
		end
	end
	for _, station in pairs(skeleton_stations) do
		if station ~= nil and station:isValid() then
			table.insert(stations_and_ships,{object=station,name=station:getCallSign()})
		end
	end
	table.sort(stations_and_ships,function(a,b)
		return a.name < b.name
	end)
	for _,item in ipairs(stations_and_ships) do
		button_label = item.name
		if type(player_message_source) == "table" and player_message_source == item.object then
			button_label = button_label .. "*"
		end
		addGMFunction(button_label,function()
			player_message_source = item.object
			playerMessageSource()
		end)
	end
end
------------------------------------------------------------------------------------------------
--	Initial Set Up > Player Ships > Tweak Player > Ship Log Message > Message Source > Input  --
------------------------------------------------------------------------------------------------
-- Button text		   FD*	Related Function(s)
-- -MAIN FROM SHIP MSG	F	initialGMFunctions
-- -SETUP				F	initialSetUp
-- -TWEAK PLAYER		F	tweakPlayerShip
-- -PLAYER MESSAGE		F	playerMessage
-- -SHIP LOG MSG		F	playerShipLogMessage
-- -MSG SOURCE			F	playerMessageSource
-- +SEL SRC MSG OBJ		D	changeMessageSourceObject
function inputMessageSource()
	clearGMFunctions()
	addGMFunction("-Main Frm Input Src",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Tweak Player",tweakPlayerShip)
	addGMFunction("-Player Message",playerMessage)
	addGMFunction("-Ship Log Msg",playerShipLogMessage)
	addGMFunction("-Msg Source",playerMessageSource)
	if message_source_object == nil then
		addGMFunction("+Sel Src Msg Obj",changeMessageSourceObject)
	else
		addGMFunction("+Chg Src Msg Obj",changeMessageSourceObject)
	end
end
function changeMessageSourceObject()
	local object_list = getGMSelection()
	if object_list ~= nil then
		if #object_list == 1 then
			message_source_object = object_list[1]
			local source = message_source_object:getDescription()
			if source ~= nil then
				player_message_source = source
			end
			addGMMessage(string.format("Object in %s selected to identify message source.\nplace message source text in description field",message_source_object:getSectorName()))
		else
			addGMMessage("Select only one object to use to identify message source via its description field. No action taken")
		end
	else
		addGMMessage("Select an object to use to identify message source via its description field. No action taken")
	end 
end
-------------------------------------------------------------------------------
--	Initial Set Up > Player Ships > Tweak Player > Ship Log Message > Color  --
-------------------------------------------------------------------------------
-- Button text		   FD*	Related Function(s)
-- -MAIN FROM SHIP MSG	F	initialGMFunctions
-- -SETUP				F	initialSetUp
-- -TWEAK PLAYER		F	tweakPlayerShip
-- -PLAYER MESSAGE		F	playerMessage
-- -PLYR SHP LOG MSG	F	playerShipLogMessage
-- List of colors		D*	inline per color
function setPlayerShipLogMessageColor()
	clearGMFunctions()
	addGMFunction("-Main From Ship Msg",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Tweak Player",tweakPlayerShip)
	addGMFunction("-Player Message",playerMessage)
	addGMFunction("-Plyr Shp Log Msg",playerShipLogMessage)
	for id, name in pairs(color_list) do
		local button_label = name
		if id == player_ship_log_message_color then
			button_label = button_label .. "*"
		end
		addGMFunction(button_label,function()
			player_ship_log_message_color = id
			setPlayerShipLogMessageColor()
		end)
	end
end
-------------------------------------------------------------------------------------
--	Initial Set Up > Player Ships > Tweak Player > Ship Log Message > Destination  --
-------------------------------------------------------------------------------------
-- Button text		   FD*	Related Function(s)
-- -MAIN FROM SHIP MSG	F	initialGMFunctions
-- -SETUP				F	initialSetUp
-- -TWEAK PLAYER		F	tweakPlayerShip
-- -PLAYER MESSAGE		F	playerMessage
-- -PLYR SHIP LOG MSG	F	playerShipLogMessage
-- ALL					*	inline
-- Player ship list		*	inline per ship
function setPlayerShipMessageDestination()
	clearGMFunctions()
	addGMFunction("-Main Frm Msg Dstn",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Tweak Player",tweakPlayerShip)
	addGMFunction("-Player Message",playerMessage)
	if set_player_ship_message_destination_caller == playerShipLogMessage then
		addGMFunction("-Plyr Ship Log Msg",playerShipLogMessage)
	else
		addGMFunction("-Plyr Hail Msg",playerHailMessage)
	end
	local button_label = "All"
	if type(player_ship_message_destination) == "string" then
		button_label = button_label .. "*"
	end
	addGMFunction(button_label,function()
		player_ship_message_destination = "All"
		setPlayerShipMessageDestination()
	end)
	for pidx=1,32 do
		local p = getPlayerShip(pidx)
		if p ~= nil and p:isValid() then
			button_label = p:getCallSign()
			if type(player_ship_message_destination) == "table" and p == player_ship_message_destination then
				button_label = button_label .. "*"
			end
			addGMFunction(button_label,function()
				player_ship_message_destination = p
				setPlayerShipMessageDestination()
			end)
		end
	end
end
----------------------------------------------------------------------------------------
--	Initial Set Up > Player Ships > Tweak Player > Console Message > Send to console  --
----------------------------------------------------------------------------------------
-- Button text		   FD*	Related Function(s)
-- -MAIN FRM CONSOLE	F	initialGMFunctions
-- -SETUP				F	initialSetUp
-- -TWEAK PLAYER		F	tweakPlayerShip
-- -MESSAGE				F	playerConsoleMessage
-- HELM					F	inline
-- WEAPONS				F	inline
-- ENGINEERING			F	inline
-- SCIENCE				F	inline
-- RELAY				F	inline
function sendPlayerConsoleMessage()
	clearGMFunctions()
	addGMFunction("-Main Frm Console",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Tweak Player",tweakPlayerShip)
	addGMFunction("-Message",playerConsoleMessage)
	addGMFunction("Helm",function()
		local p = playerShipSelected()
		if p ~= nil then
			local console_message = "console_message"
			p:addCustomMessage("Helms",console_message,message_object:getDescription())
			addGMMessage(string.format("Message sent to helm console on %s:\n%s",p:getCallSign(),message_object:getDescription()))
		else
			addGMMessage("Player ship not selected. No action taken")
		end
		sendPlayerConsoleMessage()
	end)
	addGMFunction("Weapons",function()
		local p = playerShipSelected()
		if p ~= nil then
			local console_message = "console_message"
			p:addCustomMessage("Weapons",console_message,message_object:getDescription())
			addGMMessage(string.format("Message sent to weapons console on %s:\n%s",p:getCallSign(),message_object:getDescription()))
		else
			addGMMessage("Player ship not selected. No action taken")
		end
		sendPlayerConsoleMessage()
	end)
	addGMFunction("Engineering",function()
		local p = playerShipSelected()
		if p ~= nil then
			local console_message = "console_message"
			p:addCustomMessage("Engineering",console_message,message_object:getDescription())
			addGMMessage(string.format("Message sent to engineering console on %s:\n%s",p:getCallSign(),message_object:getDescription()))
		else
			addGMMessage("Player ship not selected. No action taken")
		end
		sendPlayerConsoleMessage()
	end)
	addGMFunction("Science",function()
		local p = playerShipSelected()
		if p ~= nil then
			local console_message = "console_message"
			p:addCustomMessage("Science",console_message,message_object:getDescription())
			addGMMessage(string.format("Message sent to science console on %s:\n%s",p:getCallSign(),message_object:getDescription()))
		else
			addGMMessage("Player ship not selected. No action taken")
		end
		sendPlayerConsoleMessage()
	end)
	addGMFunction("Relay",function()
		local p = playerShipSelected()
		if p ~= nil then
			local console_message = "console_message"
			p:addCustomMessage("Relay",console_message,message_object:getDescription())
			addGMMessage(string.format("Message sent to Relay console on %s:\n%s",p:getCallSign(),message_object:getDescription()))
		else
			addGMMessage("Player ship not selected. No action taken")
		end
		sendPlayerConsoleMessage()
	end)
end
----------------------------------------------------------------------------
--	Initial Set Up > Player Ships > Tweak Player > Max System  > Reactor  --
----------------------------------------------------------------------------
-- Button text		   FD*	Related Function(s)
-- -MAIN FRM REACTOR	F	initialGMFunctions
-- -SETUP				F	initialSetUp
-- -TWEAK PLAYER		F	tweakPlayerShip
-- -MAX SYSTEM			F	changePlayerMaxSystem
-- V FROM 1.00 TO 0.95	D	inline
function changePlayerMaxReactor()
	clearGMFunctions()
	addGMFunction("-Main Frm Reactor",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Tweak Player",tweakPlayerShip)
	addGMFunction("-Max System",changePlayerMaxSystem)
	local p = playerShipSelected()
	if p ~= nil then
		if p.max_reactor < 1 then
			addGMFunction(string.format("^ From %.2f to %.2f",p.max_reactor,p.max_reactor + .05),function()
				p.max_reactor = p.max_reactor + .05
				changePlayerMaxReactor()
			end)
		end
		if p.max_reactor > -1 then
			addGMFunction(string.format("V From %.2f to %.2f",p.max_reactor,p.max_reactor - .05),function()
				p.max_reactor = p.max_reactor - .05
				changePlayerMaxReactor()
			end)
		end
	else
		addGMFunction("+Select Player",changePlayerMaxReactor)
	end
end
-------------------------------------------------------------------------
--	Initial Set Up > Player Ships > Tweak Player > Max System  > Beam  --
-------------------------------------------------------------------------
-- Button text		   FD*	Related Function(s)
-- -MAIN FRM BEAM		F	initialGMFunctions
-- -SETUP				F	initialSetUp
-- -TWEAK PLAYER		F	tweakPlayerShip
-- -MAX SYSTEM			F	changePlayerMaxSystem
-- V FROM 1.00 TO 0.95	D	inline
function changePlayerMaxBeam()
	clearGMFunctions()
	addGMFunction("-Main Frm Beam",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Tweak Player",tweakPlayerShip)
	addGMFunction("-Max System",changePlayerMaxSystem)
	local p = playerShipSelected()
	if p ~= nil then
		if p.max_beam < 1 then
			addGMFunction(string.format("^ From %.2f to %.2f",p.max_beam,p.max_beam + .05),function()
				p.max_beam = p.max_beam + .05
				changePlayerMaxBeam()
			end)
		end
		if p.max_beam > -1 then
			addGMFunction(string.format("V From %.2f to %.2f",p.max_beam,p.max_beam - .05),function()
				p.max_beam = p.max_beam - .05
				changePlayerMaxBeam()
			end)
		end
	else
		addGMFunction("+Select Player",changePlayerMaxBeam)
	end
end
----------------------------------------------------------------------------
--	Initial Set Up > Player Ships > Tweak Player > Max System  > Missile  --
----------------------------------------------------------------------------
-- Button text		   FD*	Related Function(s)
-- -MAIN FRM MISSILE	F	initialGMFunctions
-- -SETUP				F	initialSetUp
-- -TWEAK PLAYER		F	tweakPlayerShip
-- -MAX SYSTEM			F	changePlayerMaxSystem
-- V FROM 1.00 TO 0.95	D	inline
function changePlayerMaxMissile()
	clearGMFunctions()
	addGMFunction("-Main Frm Missile",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Tweak Player",tweakPlayerShip)
	addGMFunction("-Max System",changePlayerMaxSystem)
	local p = playerShipSelected()
	if p ~= nil then
		if p.max_missile < 1 then
			addGMFunction(string.format("^ From %.2f to %.2f",p.max_missile,p.max_missile + .05),function()
				p.max_missile = p.max_missile + .05
				changePlayerMaxMissile()
			end)
		end
		if p.max_missile > -1 then
			addGMFunction(string.format("V From %.2f to %.2f",p.max_missile,p.max_missile - .05),function()
				p.max_missile = p.max_missile - .05
				changePlayerMaxMissile()
			end)
		end
	else
		addGMFunction("+Select Player",changePlayerMaxMissile)
	end
end
------------------------------------------------------------------------------
--	Initial Set Up > Player Ships > Tweak Player > Max System  > Maneuver  --
------------------------------------------------------------------------------
-- Button text		   FD*	Related Function(s)
-- -MAIN FRM MANEUVER	F	initialGMFunctions
-- -SETUP				F	initialSetUp
-- -TWEAK PLAYER		F	tweakPlayerShip
-- -MAX SYSTEM			F	changePlayerMaxSystem
-- V FROM 1.00 TO 0.95	D	inline
function changePlayerMaxManeuver()
	clearGMFunctions()
	addGMFunction("-Main Frm Maneuver",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Tweak Player",tweakPlayerShip)
	addGMFunction("-Max System",changePlayerMaxSystem)
	local p = playerShipSelected()
	if p ~= nil then
		if p.max_maneuver < 1 then
			addGMFunction(string.format("^ From %.2f to %.2f",p.max_maneuver,p.max_maneuver + .05),function()
				p.max_maneuver = p.max_maneuver + .05
				changePlayerMaxManeuver()
			end)
		end
		if p.max_maneuver > -1 then
			addGMFunction(string.format("V From %.2f to %.2f",p.max_maneuver,p.max_maneuver - .05),function()
				p.max_maneuver = p.max_maneuver - .05
				changePlayerMaxManeuver()
			end)
		end
	else
		addGMFunction("+Select Player",changePlayerMaxManeuver)
	end
end
----------------------------------------------------------------------------
--	Initial Set Up > Player Ships > Tweak Player > Max System  > Impulse  --
----------------------------------------------------------------------------
-- Button text		   FD*	Related Function(s)
-- -MAIN FRM IMPULSE	F	initialGMFunctions
-- -SETUP				F	initialSetUp
-- -TWEAK PLAYER		F	tweakPlayerShip
-- -MAX SYSTEM			F	changePlayerMaxSystem
-- V FROM 1.00 TO 0.95	D	inline
function changePlayerMaxImpulse()
	clearGMFunctions()
	addGMFunction("-Main Frm Impulse",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Tweak Player",tweakPlayerShip)
	addGMFunction("-Max System",changePlayerMaxSystem)
	local p = playerShipSelected()
	if p ~= nil then
		if p.max_impulse < 1 then
			addGMFunction(string.format("^ From %.2f to %.2f",p.max_impulse,p.max_impulse + .05),function()
				p.max_impulse = p.max_impulse + .05
				changePlayerMaxImpulse()
			end)
		end
		if p.max_impulse > -1 then
			addGMFunction(string.format("V From %.2f to %.2f",p.max_impulse,p.max_impulse - .05),function()
				p.max_impulse = p.max_impulse - .05
				changePlayerMaxImpulse()
			end)
		end
	else
		addGMFunction("+Select Player",changePlayerMaxImpulse)
	end
end
-------------------------------------------------------------------------
--	Initial Set Up > Player Ships > Tweak Player > Max System  > Warp  --
-------------------------------------------------------------------------
-- Button text		   FD*	Related Function(s)
-- -MAIN FRM WARP		F	initialGMFunctions
-- -SETUP				F	initialSetUp
-- -TWEAK PLAYER		F	tweakPlayerShip
-- -MAX SYSTEM			F	changePlayerMaxSystem
-- V FROM 1.00 TO 0.95	D	inline
function changePlayerMaxWarp()
	clearGMFunctions()
	addGMFunction("-Main Frm Warp",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Tweak Player",tweakPlayerShip)
	addGMFunction("-Max System",changePlayerMaxSystem)
	local p = playerShipSelected()
	if p ~= nil then
		if p.max_warp < 1 then
			addGMFunction(string.format("^ From %.2f to %.2f",p.max_warp,p.max_warp + .05),function()
				p.max_warp = p.max_warp + .05
				changePlayerMaxWarp()
			end)
		end
		if p.max_warp > -1 then
			addGMFunction(string.format("V From %.2f to %.2f",p.max_warp,p.max_warp - .05),function()
				p.max_warp = p.max_warp - .05
				changePlayerMaxWarp()
			end)
		end
	else
		addGMFunction("+Select Player",changePlayerMaxWarp)
	end
end
-------------------------------------------------------------------------
--	Initial Set Up > Player Ships > Tweak Player > Max System  > Jump  --
-------------------------------------------------------------------------
-- Button text		   FD*	Related Function(s)
-- -MAIN FRM JUMP		F	initialGMFunctions
-- -SETUP				F	initialSetUp
-- -TWEAK PLAYER		F	tweakPlayerShip
-- -MAX SYSTEM			F	changePlayerMaxSystem
-- V FROM 1.00 TO 0.95	D	inline
function changePlayerMaxJump()
	clearGMFunctions()
	addGMFunction("-Main Frm Jump",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Tweak Player",tweakPlayerShip)
	addGMFunction("-Max System",changePlayerMaxSystem)
	local p = playerShipSelected()
	if p ~= nil then
		if p.max_jump < 1 then
			addGMFunction(string.format("^ From %.2f to %.2f",p.max_jump,p.max_jump + .05),function()
				p.max_jump = p.max_jump + .05
				changePlayerMaxJump()
			end)
		end
		if p.max_jump > -1 then
			addGMFunction(string.format("V From %.2f to %.2f",p.max_jump,p.max_jump - .05),function()
				p.max_jump = p.max_jump - .05
				changePlayerMaxJump()
			end)
		end
	else
		addGMFunction("+Select Player",changePlayerMaxJump)
	end
end
---------------------------------------------------------------------------------
--	Initial Set Up > Player Ships > Tweak Player > Max System  > Front Shield  --
---------------------------------------------------------------------------------
-- Button text		   FD*	Related Function(s)
-- -MAIN FRM F.SHIELD	F	initialGMFunctions
-- -SETUP				F	initialSetUp
-- -TWEAK PLAYER		F	tweakPlayerShip
-- -MAX SYSTEM			F	changePlayerMaxSystem
-- V FROM 1.00 TO 0.95	D	inline
function changePlayerMaxFrontShield()
	clearGMFunctions()
	addGMFunction("-Main Frm F.Shield",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Tweak Player",tweakPlayerShip)
	addGMFunction("-Max System",changePlayerMaxSystem)
	local p = playerShipSelected()
	if p ~= nil then
		if p.max_front_shield < 1 then
			addGMFunction(string.format("^ From %.2f to %.2f",p.max_front_shield,p.max_front_shield + .05),function()
				p.max_front_shield = p.max_front_shield + .05
				changePlayerMaxFrontShield()
			end)
		end
		if p.max_front_shield > -1 then
			addGMFunction(string.format("V From %.2f to %.2f",p.max_front_shield,p.max_front_shield - .05),function()
				p.max_front_shield = p.max_front_shield - .05
				changePlayerMaxFrontShield()
			end)
		end
	else
		addGMFunction("+Select Player",changePlayerMaxFrontShield)
	end
end
--------------------------------------------------------------------------------
--	Initial Set Up > Player Ships > Tweak Player > Max System  > Rear Shield  --
--------------------------------------------------------------------------------
-- Button text		   FD*	Related Function(s)
-- -MAIN FRM R.SHIELD	F	initialGMFunctions
-- -SETUP				F	initialSetUp
-- -TWEAK PLAYER		F	tweakPlayerShip
-- -MAX SYSTEM			F	changePlayerMaxSystem
-- V FROM 1.00 TO 0.95	D	inline
function changePlayerMaxRearShield()
	clearGMFunctions()
	addGMFunction("-Main Frm R.Shield",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Tweak Player",tweakPlayerShip)
	addGMFunction("-Max System",changePlayerMaxSystem)
	local p = playerShipSelected()
	if p ~= nil then
		if p.max_rear_shield < 1 then
			addGMFunction(string.format("^ From %.2f to %.2f",p.max_rear_shield,p.max_rear_shield + .05),function()
				p.max_rear_shield = p.max_rear_shield + .05
				changePlayerMaxRearShield()
			end)
		end
		if p.max_rear_shield > -1 then
			addGMFunction(string.format("V From %.2f to %.2f",p.max_rear_shield,p.max_rear_shield - .05),function()
				p.max_rear_shield = p.max_rear_shield - .05
				changePlayerMaxRearShield()
			end)
		end
	else
		addGMFunction("+Select Player",changePlayerMaxRearShield)
	end
end
-----------------------------------------------------------------------
--	Initial Set Up > Player Ships > Descriptions > Describe Current  --
-----------------------------------------------------------------------
-- -BACK		F	describePlayerShips
-- Button to describe each currently active player ship name
function describeCurrentSpecialPlayerShips()
	clearGMFunctions()
	addGMFunction("-Back",describePlayerShips)
	for shipNum = 1, #playerShipInfo do
		if playerShipInfo[shipNum][4] ~= nil and playerShipInfo[shipNum][2] == "active" then
			addGMFunction(playerShipInfo[shipNum][1],function()
				addGMMessage(playerShipInfo[shipNum][4])
			end)
		end
	end
end
------------------------------------------------------------------------
--	Initial Set Up > Player Ships > Descriptions > Describe Scrapped  --
------------------------------------------------------------------------
-- -BACK		F	describePlayerShips
-- Button to describe each scrapped or inactive player ship name
function describeScrappedSpecialPlayerShips()
	clearGMFunctions()
	addGMFunction("-Back",describePlayerShips)
	for shipNum = 1, #playerShipInfo do
		if playerShipInfo[shipNum][4] ~= nil and playerShipInfo[shipNum][2] == "inactive" then
			addGMFunction(playerShipInfo[shipNum][1],function()
				addGMMessage(playerShipInfo[shipNum][4])
			end)
		end
	end
end
---------------------------------------------------------------------
--	Initial Set Up > Player Ships > Descriptions > Describe Stock  --
---------------------------------------------------------------------
-- -BACK		F	describePlayerShips
-- Button to describe each player ship that can be spawned from the standard spawn player ship screen
function describeStockPlayerShips()
	clearGMFunctions()
	addGMFunction("-Back",describePlayerShips)
	addGMFunction("Atlantis",function()
		addGMMessage("Atlantis: Corvette, Destroyer   Hull:250   Shield:200,200   Size:400   Repair Crew:3   Cargo:6   R.Strength:52\nDefault advanced engine:Jump   Speeds: Impulse:90   Spin:10   Accelerate:20   C.Maneuver: Boost:400 Strafe:250\nBeams:2\n   Arc:100   Direction:-20   Range:1.5   Cycle:6   Damage:8\n   Arc:100   Direction: 20   Range:1.5   Cycle:6   Damage:8\nTubes:5   Load Speed:10   Side:4   Back:1\n   Direction:-90   Type:Exclude Mine\n   Direction:-90   Type:Exclude Mine\n   Direction: 90   Type:Exclude Mine\n   Direction: 90   Type:Exclude Mine\n   Direction:180   Type:Mine Only\n   Ordnance stock and type:\n      12 Homing\n      04 Nuke\n      08 Mine\n      06 EMP\n      20 HVLI\nA refitted Atlantis X23 for more general tasks. The large shield system has been replaced with an advanced combat maneuvering systems and improved impulse engines. Its missile loadout is also more diverse. Mistaking the modified Atlantis for an Atlantis X23 would be a deadly mistake.")
	end)
	addGMFunction("Benedict",function()
		addGMMessage("Benedict: Corvette, Freighter/Carrier   Hull:200   Shield:70,70   Size:400   Repair Crew:3   Cargo Space:9   R.Strength:10\nShip classes that may dock with Benedict:Starfighter, Frigate, Corvette\nDefault advanced engine:Jump (5U - 90U)   Speeds: Impulse:60   Spin:6   Accelerate:8   C.Maneuver: Boost:400 Strafe:250\nBeams:2 Turreted Speed:6\n   Arc:90   Direction:  0   Range:1.5   Cycle:6   Damage:4\n   Arc:90   Direction:180   Range:1.5   Cycle:6   Damage:4\nBenedict is an improved version of the Jump Carrier")
	end)
	addGMFunction("Crucible",function()
		addGMMessage("Crucible: Corvette, Popper   Hull:160   Shield:160,160   Size:200   Repair Crew:4   Cargo Space:5   R.Strength:45\nDefault advanced engine:Warp (750)   Speeds: Impulse:80   Spin:15   Accelerate:40   C.Maneuver: Boost:400 Strafe:250\nBeams:2\n   Arc:70   Direction:-30   Range:1   Cycle:6   Damage:5\n   Arc:70   Direction: 30   Range:1   Cycle:6   Damage:5\nTubes:6   Load Speed:8   Front:3   Side:2   Back:1\n   Direction:   0   Type:HVLI Only - Small\n   Direction:   0   Type:HVLI Only\n   Direction:   0   Type:HVLI Only - Large\n   Direction:-90   Type:Exclude Mine\n   Direction: 90   Type:Exclude Mine\n   Direction:180   Type:Mine Only\n   Ordnance stock and type:\n      08 Homing\n      04 Nuke\n      06 Mine\n      06 EMP\n      24 HVLI\nA number of missile tubes range around this ship. Beams were deemed lower priority, though they are still present. Stronger defenses than a frigate, but not as strong as the Atlantis")
	end)
	addGMFunction("Ender",function()
		addGMMessage("Ender: Dreadnaught, Battlecruiser   Hull:100   Shield:1200,1200   Size:2000   Repair Crew:8   Cargo Space:20   R.Strength:100\nShip classes that may dock with Benedict:Starfighter, Frigate, Corvette   Energy:1200\nDefault advanced engine:Jump   Speeds: Impulse:30   Spin:2   Accelerate:6   C.Maneuver: Boost:800 Strafe:500\nBeams:12 6 left, 6 right turreted Speed:6\n   Arc:120   Direction:-90   Range:2.5   Cycle:6.1   Damage:4\n   Arc:120   Direction:-90   Range:2.5   Cycle:6.0   Damage:4\n   Arc:120   Direction: 90   Range:2.5   Cycle:5.8   Damage:4\n   Arc:120   Direction: 90   Range:2.5   Cycle:6.3   Damage:4\n   Arc:120   Direction:-90   Range:2.5   Cycle:5.9   Damage:4\n   Arc:120   Direction:-90   Range:2.5   Cycle:6.4   Damage:4\n   Arc:120   Direction: 90   Range:2.5   Cycle:5.7   Damage:4\n   Arc:120   Direction: 90   Range:2.5   Cycle:5.6   Damage:4\n   Arc:120   Direction:-90   Range:2.5   Cycle:6.6   Damage:4\n   Arc:120   Direction:-90   Range:2.5   Cycle:5.5   Damage:4\n   Arc:120   Direction: 90   Range:2.5   Cycle:6.5   Damage:4\n   Arc:120   Direction: 90   Range:2.5   Cycle:6.2   Damage:4\nTubes:2   Load Speed:8   Front:1   Back:1\n   Direction:   0   Type:Homing Only\n   Direction:180   Type:Mine Only\n   Ordnance stock and type:\n      6 Homing\n      6 Mine")
	end)
	addGMFunction("Flavia P.Falcon",function()
		addGMMessage("Flavia P.Falcon: Frigate, Light Transport   Hull:100   Shield:70,70   Size:200   Repair Crew:8   Cargo Space:15   R.Strength:13\nDefault advanced engine:Warp (500)   Speeds: Impulse:60   Spin:10   Accelerate:10   C.Maneuver: Boost:250 Strafe:150\nBeams:2 rear facing\n   Arc:40   Direction:170   Range:1.2   Cycle:6   Damage:6\n   Arc:40   Direction:190   Range:1.2   Cycle:6   Damage:6\nTubes:1   Load Speed:20   Back:1\n   Direction:180   Type:Any\n   Ordnance stock and type:\n      3 Homing\n      1 Nuke\n      1 Mine\n      5 HVLI\nThe Flavia P.Falcon has a nuclear-capable rear-facing weapon tube and a warp drive.")
	end)
	addGMFunction("Hathcock",function()
		addGMMessage("Hathcock: Frigate, Cruiser: Sniper   Hull:120   Shield:70,70   Size:200   Repair Crew:2   Cargo Space:6   R.Strength:30\nDefault advanced engine:Jump   Speeds: Impulse:50   Spin:15   Accelerate:8   C.Maneuver: Boost:200 Strafe:150\nBeams:4 front facing\n   Arc:04   Direction:0   Range:1.4   Cycle:6   Damage:4\n   Arc:20   Direction:0   Range:1.2   Cycle:6   Damage:4\n   Arc:60   Direction:0   Range:1.0   Cycle:6   Damage:4\n   Arc:90   Direction:0   Range:0.8   Cycle:6   Damage:4\nTubes:2   Load Speed:15   Side:2\n   Direction:-90   Type:Any\n   Direction: 90   Type:Any\n   Ordnance stock and type:\n      4 Homing\n      1 Nuke\n      2 EMP\n      8 HVLI\nLong range narrow beam and some point defense beams, broadside missiles. Agile for a frigate")
	end)
	addGMFunction("Kiriya",function()
		addGMMessage("Kiriya: Corvette, Freighter/Carrier   Hull:200   Shield:70,70   Size:400   Repair Crew:3   Cargo Space:9   R.Strength:10\nShip classes that may dock with Benedict:Starfighter, Frigate, Corvette\nDefault advanced engine:Warp (750)   Speeds: Impulse:60   Spin:6   Accelerate:8   C.Maneuver: Boost:400 Strafe:250\nBeams:2 Turreted Speed:6\n   Arc:90   Direction:  0   Range:1.5   Cycle:6   Damage:4\n   Arc:90   Direction:180   Range:1.5   Cycle:6   Damage:4\nKiriya is an improved warp drive version of the Jump Carrier")
	end)
	addGMFunction("MP52 Hornet",function()
		addGMMessage("MP52 Hornet: Starfighter, Interceptor   Hull:70   Shield:60   Size:100   Repair Crew:1   Cargo:3   R.Strength:7\nDefault advanced engine:None   Speeds: Impulse:125   Spin:32   Accelerate:40   C.Maneuver: Boost:600   Energy:400\nBeams:2\n   Arc:30   Direction: 5   Range:.9   Cycle:4   Damage:2.5\n   Arc:30   Direction:-5   Range:.9   Cycle:4   Damage:2.5\nThe MP52 Hornet is a significantly upgraded version of MU52 Hornet, with nearly twice the hull strength, nearly three times the shielding, better acceleration, impulse boosters, and a second laser cannon.")
	end)
	addGMFunction("Maverick",function()
		addGMMessage("Maverick: Corvette, Gunner   Hull:160   Shield:160,160   Size:200   Repair Crew:4   Cargo:5   R.Strength:45\nDefault advanced engine:Warp (800)   Speeds: Impulse:80   Spin:15   Accelerate:40   C.Maneuver: Boost:400 Strafe:250\nBeams:6   3 forward, 2 side, 1 back (turreted speed .5)\n   Arc:10   Direction:  0   Range:2.0   Cycle:6   Damage:6\n   Arc: 90   Direction:-20   Range:1.5   Cycle:6   Damage:8\n   Arc: 90   Direction: 20   Range:1.5   Cycle:6   Damage:8\n   Arc: 40   Direction:-70   Range:1.0   Cycle:4   Damage:6\n   Arc: 40   Direction: 70   Range:1.0   Cycle:4   Damage:6\n   Arc:180   Direction:180   Range:0.8   Cycle:6   Damage:4   (turreted speed: .5)\nTubes:3   Load Speed:8   Side:2   Back:1\n   Direction:-90   Type:Exclude Mine\n   Direction: 90   Type:Exclude Mine\n   Direction:180   Type:Mine Only\n   Ordnance stock and type:\n      06 Homing\n      02 Nuke\n      02 Mine\n      04 EMP\n      10 HVLI\nA number of beams bristle from various points on this gunner. Missiles were deemed lower priority, though they are still present. Stronger defenses than a frigate, but not as strong as the Atlantis")
	end)
	addGMFunction("Nautilus",function()
		addGMMessage("Nautilus: Frigate, Mine Layer   Hull:100   Shield:60,60   Size:200   Repair Crew:4   Cargo:7   R.Strength:12\nDefault advanced engine:Jump   Speeds: Impulse:100   Spin:10   Accelerate:15   C.Maneuver: Boost:250 Strafe:150\nBeams:2 Turreted Speed:6\n   Arc:90   Direction: 35   Range:1   Cycle:6   Damage:6\n   Arc:90   Direction:-35   Range:1   Cycle:6   Damage:6\nTubes:3   Load Speed:10   Back:3\n   Direction:180   Type:Mine Only\n   Direction:180   Type:Mine Only\n   Direction:180   Type:Mine Only\n   Ordnance stock and type:\n      12 Mine\nSmall mine laying vessel with minimal armament, shields and hull")
	end)
	addGMFunction("Phobos MP3",function()
		addGMMessage("Phobos MP3: Frigate, Cruiser   Hull:200   Shield:100,100   Size:200   Repair Crew:3   Cargo:10   R.Strength:19\nDefault advanced engine:None   Speeds: Impulse:80   Spin:10   Accelerate:20   C.Maneuver: Boost:400 Strafe:250\nBeams:2\n   Arc:90   Direction:-15   Range:1.2   Cycle:8   Damage:6\n   Arc:90   Direction: 15   Range:1.2   Cycle:8   Damage:6\nTubes:3   Load Speed:10   Front:2   Back:1\n   Direction: -1   Type:Exclude Mine\n   Direction:  1   Type:Exclude Mine\n   Direction:180   Type:Mine Only\n   Ordnance stock and type:\n      10 Homing\n      02 Nuke\n      04 Mine\n      03 EMP\n      20 HVLI\nPlayer variant of the Phobos M3, not as strong as the atlantis, but has front firing tubes, making it an easier to use ship in some scenarios.")
	end)
	addGMFunction("Piranha",function()
		addGMMessage("Piranha: Frigate, Cruiser: Light Artillery   Hull:120   Shield:70,70   Size:200   Repair Crew:2   Cargo:8   R.Strength:16\nDefault advanced engine:None   Speeds: Impulse:60   Spin:10   Accelerate:8   C.Maneuver: Boost:200 Strafe:150\nTubes:8   Load Speed:8   Side:6   Back:2\n   Direction:-90   Type:HVLI and Homing Only\n   Direction:-90   Type:Any\n   Direction:-90   Type:HVLI and Homing Only\n   Direction: 90   Type:HVLI and Homing Only\n   Direction: 90   Type:Any\n   Direction: 90   Type:HVLI and Homing Only\n   Direction:170   Type:Mine Only\n   Direction:190   Type:Mine Only\n   Ordnance stock and type:\n      12 Homing\n      06 Nuke\n      08 Mine\n      20 HVLI\nThis combat-specialized Piranha F12 adds mine-laying tubes, combat maneuvering systems, and a jump drive.")
	end)	
	addGMFunction("Player Cruiser",function()
		addGMMessage("Player Cruiser:   Hull:200   Shield:80,80   Size:400   Repair Crew:3   Cargo:6   R.Strength:40\nDefault advanced engine:Jump   Speeds: Impulse:90   Spin:10   Accelerate:20   C.Maneuver: Boost:400 Strafe:250\nBeams:2\n   Arc:90   Direction:-15   Range:1   Cycle:6   Damage:10\n   Arc:90   Direction: 15   Range:1   Cycle:6   Damage:10\nTubes:3   Load Speed:8   Front:2   Back:1\n   Direction: -5   Type:Exclude Mine\n   Direction:  5   Type:Exclude Mine\n   Direction:180   Type:Mine Only\n   Ordnance stock and type:\n      12 Homing\n      04 Nuke\n      08 Mine\n      06 EMP")
	end)
	addGMFunction("Player Fighter",function()
		addGMMessage("Player Fighter:   Hull:60   Shield:40   Size:100   Repair Crew:3   Cargo:3   R.Strength:7\nDefault advanced engine:None   Speeds: Impulse:110   Spin:20   Accelerate:40   C.Maneuver: Boost:600   Energy:400\nBeams:2\n   Arc:40   Direction:-10   Range:1   Cycle:6   Damage:8\n   Arc:40   Direction: 10   Range:1   Cycle:6   Damage:8\nTube:1   Load Speed:10   Front:1\n   Direction:0   Type:HVLI Only\n   Ordnance stock and type:\n      4 HVLI")
	end)
	addGMFunction("Player Missile Cr.",function()
		addGMMessage("Player Missile Cr.:   Hull:200   Shield:110,70   Size:200   Repair Crew:3   Cargo:8   R.Strength:45\nDefault advanced engine:Warp (800)   Speeds: Impulse:60   Spin:8   Accelerate:15   C.Maneuver: Boost:450 Strafe:150\nTubes:7   Load Speed:8   Front:2   Side:4   Back:1\n   Direction:  0   Type:Exclude Mine\n   Direction:  0   Type:Exclude Mine\n   Direction: 90   Type:Homing Only\n   Direction: 90   Type:Homing Only\n   Direction:-90   Type:Homing Only\n   Direction:-90   Type:Homing Only\n   Direction:180   Type:Mine Only\n   Ordnance stock and type:\n      30 Homing\n      08 Nuke\n      12 Mine\n      10 EMP")
	end)	
	addGMFunction("Repulse",function()
		addGMMessage("Repulse: Frigate, Armored Transport   Hull:120   Shield:80,80   Size:200   Repair Crew:8   Cargo:12   R.Strength:14\nDefault advanced engine:Jump   Speeds: Impulse:55   Spin:9   Accelerate:10   C.Maneuver: Boost:250 Strafe:150\nBeams:2 Turreted Speed:5\n   Arc:200   Direction: 90   Range:1.2   Cycle:6   Damage:5\n   Arc:200   Direction:-90   Range:1.2   Cycle:6   Damage:5\nTubes:2   Load Speed:20   Front:1   Back:1\n   Direction:  0   Type:Any\n   Direction:180   Type:Any\n   Ordnance stock and type:\n      4 Homing\n      6 HVLI\nJump/Turret version of Flavia Falcon")
	end)
	addGMFunction("Striker",function()
		addGMMessage("Striker: Starfighter, Patrol   Hull:120   Shield:50,30   Size:200   Repair Crew:2   Cargo:4   R.Strength:8\nDefault advanced engine:None   Speeds: Impulse:45   Spin:15   Accelerate:30   C.Maneuver: Boost:250 Strafe:150   Energy:500\nBeams:2 Turreted Speed:6\n   Arc:100   Direction:-15   Range:1   Cycle:6   Damage:6\n   Arc:100   Direction: 15   Range:1   Cycle:6   Damage:6\nThe Striker is the predecessor to the advanced striker, slow but agile, but does not do an extreme amount of damage, and lacks in shields")
	end)
	addGMFunction("ZX-Lindworm",function()
		addGMMessage("ZX-Lindworm: Starfighter, Bomber   Hull:75   Shield:40   Size:100   Repair Crew:1   Cargo:3   R.Strength:8\nDefault advanced engine:None   Speeds: Impulse:70   Spin:15   Accelerate:25   C.Maneuver: Boost:250 Strafe:150   Energy:400\nBeam:1 Turreted Speed:4\n   Arc:270   Direction:180   Range:0.7   Cycle:6   Damage:2\nTubes:3   Load Speed:10   Front:3 (small)\n   Direction: 0   Type:Any - small\n   Direction: 1   Type:HVLI Only - small\n   Direction:-1   Type:HVLI Only - small\n   Ordnance stock and type:\n      03 Homing\n      12 HVLI")
	end)
end
----------------------------------------------------
--	Support the creation of various player ships  --
----------------------------------------------------
function createPlayerShipAmbition()
	--first version destroyed 1Feb2020, version 2 reduced hull strength
	playerAmbition = PlayerSpaceship():setTemplate("Phobos M3P"):setFaction("Human Navy"):setCallSign("Ambition")
	playerAmbition:setTypeName("Phobos T2")
	playerAmbition:setRepairCrewCount(5)					--more repair crew (vs 3)
	playerAmbition:setHullMax(150)							--weaker hull (vs 200)
	playerAmbition:setHull(150)
	playerAmbition:setJumpDrive(true)						--jump drive (vs none)
	playerAmbition.max_jump_range = 25000					--shorter than typical (vs 50)
	playerAmbition.min_jump_range = 2000					--shorter than typical (vs 5)
	playerAmbition:setJumpDriveRange(playerAmbition.min_jump_range,playerAmbition.max_jump_range)
	playerAmbition:setJumpDriveCharge(playerAmbition.max_jump_range)
	playerAmbition:setRotationMaxSpeed(20)					--faster spin (vs 10)
--                 				   Arc, Dir, Range, CycleTime, Dmg
	playerAmbition:setBeamWeapon(0, 10, -15,  1200,         8, 6)
	playerAmbition:setBeamWeapon(1, 10,  15,  1200,        16, 6)
--										 Arc, Dir, Rotate speed
	playerAmbition:setBeamWeaponTurret(0, 90, -15, .2)		--slow turret beams
	playerAmbition:setBeamWeaponTurret(1, 90,  15, .2)
	playerAmbition:setWeaponTubeCount(2)					--one fewer tube (1 forward, 1 rear vs 2 forward, 1 rear)
	playerAmbition:setWeaponTubeDirection(0,0)				--first tube points straight forward
	playerAmbition:setWeaponTubeDirection(1,180)			--second tube points straight back
	playerAmbition:setWeaponTubeExclusiveFor(1,"Mine")
	playerAmbition:setWeaponStorageMax("Homing",6)			--reduce homing storage (vs 10)
	playerAmbition:setWeaponStorage("Homing",6)
	playerAmbition:setWeaponStorageMax("HVLI",10)			--reduce HVLI storage (vs 20)
	playerAmbition:setWeaponStorage("HVLI",10)
	playerAmbition:addReputationPoints(50)
end
function createPlayerShipArgonaut()
	playerArgonaut = PlayerSpaceship():setTemplate("Nautilus"):setFaction("Human Navy"):setCallSign("Argonaut")
	playerArgonaut:setTypeName("Nusret")
	playerArgonaut.max_jump_range = 25000					--shorter than typical (vs 50)
	playerArgonaut.min_jump_range = 2500					--shorter than typical (vs 5)
	playerArgonaut:setJumpDriveRange(playerArgonaut.min_jump_range,playerArgonaut.max_jump_range)
	playerArgonaut:setJumpDriveCharge(playerArgonaut.max_jump_range)
	playerArgonaut:setShieldsMax(100, 100)					--stronger shields (vs 60, 60)
	playerArgonaut:setShields(100, 100)
	playerArgonaut:setWeaponTubeDirection(0,-60)			--front left facing (vs back)
	playerArgonaut:setWeaponTubeDirection(1, 60)			--front right facing (vs back)
	playerArgonaut:setWeaponTubeExclusiveFor(0,"Homing")	--Homing only (vs Mine)
	playerArgonaut:setWeaponTubeExclusiveFor(1,"Homing")	--Homing only (vs Mine)
	playerArgonaut:setWeaponStorageMax("Homing",8)			--more homing (vs 0)
	playerArgonaut:setWeaponStorage("Homing", 8)				
	playerArgonaut:setWeaponStorageMax("Mine",8)			--fewer mines (vs 12)
	playerArgonaut:setWeaponStorage("Mine", 8)				
	playerArgonaut:addReputationPoints(50)
	playerShipSpawned("Argonaut")
end
function createPlayerShipArwine()
	--destroyed 14Dec2019
	playerArwine = PlayerSpaceship():setTemplate("Piranha"):setFaction("Human Navy"):setCallSign("Arwine")
	playerArwine:setTypeName("Pacu")
	playerArwine:setRepairCrewCount(5)						--more repair crew (vs 2)
	playerArwine.max_jump_range = 25000						--shorter than typical (vs 50)
	playerArwine.min_jump_range = 2000						--shorter than typical (vs 5)
	playerArwine:setJumpDriveRange(playerArwine.min_jump_range,playerArwine.max_jump_range)
	playerArwine:setJumpDriveCharge(playerArwine.max_jump_range)
	playerArwine:setImpulseMaxSpeed(70)						--faster impulse max (vs 40)
	playerArwine:setHullMax(150)							--stronger hull (vs 120)
	playerArwine:setHull(150)
	playerArwine:setShieldsMax(100,100)						--stronger shields (vs 70, 70)
	playerArwine:setShields(100,100)
	playerArwine:setBeamWeapon(0, 10, 0, 1200.0, 4.0, 4)	--one beam (vs 0)
	playerArwine:setBeamWeaponTurret(0, 80, 0, .2)			--slow turret
	playerArwine:setWeaponTubeCount(7)						--one fewer mine tube, but EMPs added
	playerArwine:setWeaponTubeDirection(6, 180)				--mine tube points straight back
	playerArwine:setWeaponTubeExclusiveFor(0,"HVLI")
	playerArwine:setWeaponTubeExclusiveFor(1,"HVLI")
	playerArwine:setWeaponTubeExclusiveFor(2,"HVLI")
	playerArwine:setWeaponTubeExclusiveFor(3,"HVLI")
	playerArwine:setWeaponTubeExclusiveFor(4,"HVLI")
	playerArwine:setWeaponTubeExclusiveFor(5,"HVLI")
	playerArwine:setWeaponTubeExclusiveFor(6,"Mine")
	playerArwine:weaponTubeAllowMissle(1,"Homing")
	playerArwine:weaponTubeAllowMissle(1,"EMP")
	playerArwine:weaponTubeAllowMissle(1,"Nuke")
	playerArwine:weaponTubeAllowMissle(4,"Homing")
	playerArwine:weaponTubeAllowMissle(4,"EMP")
	playerArwine:weaponTubeAllowMissle(4,"Nuke")
	playerArwine:setWeaponStorageMax("Mine",4)				--fewer mines (vs 8)
	playerArwine:setWeaponStorage("Mine", 4)				
	playerArwine:setWeaponStorageMax("EMP",4)				--more EMPs (vs 0)
	playerArwine:setWeaponStorage("EMP", 4)					
	playerArwine:setWeaponStorageMax("Nuke",4)				--fewer Nukes (vs 6)
	playerArwine:setWeaponStorage("Nuke", 4)				
	playerArwine:addReputationPoints(50)
	playerShipSpawned("Arwine")
end
function createPlayerShipBarracuda()
	--destroyed 8feb2020
	--clone of Headhunter
	playerBarracuda = PlayerSpaceship():setTemplate("Piranha"):setFaction("Human Navy"):setCallSign("Barracuda")
	playerBarracuda:setTypeName("Redhook")
	playerBarracuda:setRepairCrewCount(4)						--more repair crew (vs 2)
	playerBarracuda.max_jump_range = 25000						--shorter than typical (vs 50)
	playerBarracuda.min_jump_range = 2000						--shorter than typical (vs 5)
	playerBarracuda:setJumpDriveRange(playerBarracuda.min_jump_range,playerBarracuda.max_jump_range)
	playerBarracuda:setJumpDriveCharge(playerBarracuda.max_jump_range)
	playerBarracuda:setHullMax(140)								--stronger hull (vs 120)
	playerBarracuda:setHull(140)
	playerBarracuda:setShieldsMax(100, 100)						--stronger shields (vs 70, 70)
	playerBarracuda:setShields(100, 100)
	playerBarracuda:setBeamWeapon(0, 10, 0, 1000.0, 4.0, 4)		--one beam (vs 0)
	playerBarracuda:setBeamWeaponTurret(0, 80, 0, .5)			--slow turret 
	playerBarracuda:setWeaponTubeCount(7)						--one fewer mine tube, but EMPs added
	playerBarracuda:setWeaponTubeDirection(6, 180)				--mine tube points straight back
	playerBarracuda:setWeaponTubeExclusiveFor(0,"HVLI")
	playerBarracuda:setWeaponTubeExclusiveFor(1,"HVLI")
	playerBarracuda:setWeaponTubeExclusiveFor(2,"HVLI")
	playerBarracuda:setWeaponTubeExclusiveFor(3,"HVLI")
	playerBarracuda:setWeaponTubeExclusiveFor(4,"HVLI")
	playerBarracuda:setWeaponTubeExclusiveFor(5,"HVLI")
	playerBarracuda:setWeaponTubeExclusiveFor(6,"Mine")
	playerBarracuda:weaponTubeAllowMissle(1,"Homing")
	playerBarracuda:weaponTubeAllowMissle(1,"EMP")
	playerBarracuda:weaponTubeAllowMissle(1,"Nuke")
	playerBarracuda:weaponTubeAllowMissle(4,"Homing")
	playerBarracuda:weaponTubeAllowMissle(4,"EMP")
	playerBarracuda:weaponTubeAllowMissle(4,"Nuke")
	playerBarracuda:setWeaponStorageMax("Mine",4)				--fewer mines (vs 8)
	playerBarracuda:setWeaponStorage("Mine", 4)				
	playerBarracuda:setWeaponStorageMax("EMP",4)				--more EMPs (vs 0)
	playerBarracuda:setWeaponStorage("EMP", 4)					
	playerBarracuda:setWeaponStorageMax("Nuke",4)				--fewer Nukes (vs 6)
	playerBarracuda:setWeaponStorage("Nuke", 4)				
	playerBarracuda:addReputationPoints(50)
	playerShipSpawned("Barracuda")
end
function createPlayerShipBlaire()
	playerBlaire = PlayerSpaceship():setTemplate("Maverick"):setFaction("Human Navy"):setCallSign("Blaire")
	playerBlaire:setTypeName("Kludge")
	playerBlaire:setMaxEnergy(1130)						--more maximum energy (vs 1000)
	playerBlaire:setEnergy(1130)							
	playerBlaire:setShieldsMax(160, 80)					--weaker shields (vs 160, 160)
	playerBlaire:setShields(100, 100)
	playerBlaire:setWarpSpeed(250)						--slower (vs 800)
	playerBlaire:setJumpDrive(true)						--jump drive (vs none)
	playerBlaire.max_jump_range = 18000					--shorter than typical (vs 50)
	playerBlaire.min_jump_range = 2000					--shorter than typical (vs 5)
	playerBlaire:setJumpDriveRange(playerBlaire.min_jump_range,playerBlaire.max_jump_range)
	playerBlaire:setJumpDriveCharge(playerBlaire.max_jump_range)
	playerBlaire:setRepairCrewCount(7)					--more repair crew (vs 4)
--                  		    Arc,   Dir,  Range, CycleTime, Dmg
	playerBlaire:setBeamWeapon(0, 10,   25, 1000.0,       6.0, 6)	--shorter (vs 2000), turreted, angled (vs 0)
	playerBlaire:setBeamWeapon(1, 34,   55,  500.0,       4.0, 8)	--shorter (vs 1500), angled (vs -20), faster (vs 6)
	playerBlaire:setBeamWeapon(2, 70, -120,  800.0,       6.0, 6)	--shorter (vs 1500), angled (vs 20), weaker (vs 8)
	playerBlaire:setBeamWeapon(3, 0, 0, 0, 0, 0)					--remove beams			
	playerBlaire:setBeamWeapon(4, 0, 0, 0, 0, 0)	
	playerBlaire:setBeamWeapon(5, 0, 0, 0, 0, 0)	
--									   Arc, Dir, Rotate speed
	playerBlaire:setBeamWeaponTurret(0, 50,  20, .2)
	playerBlaire:setWeaponTubeDirection(0, -11)			--angled (vs-90)
	playerBlaire:setWeaponTubeDirection(1,-23)			--angled (vs 90)
	playerBlaire:setWeaponTubeDirection(2,174)			--angled (vs 180)
	playerBlaire:setWeaponStorageMax("Homing", 1)		--less (vs 6)
	playerBlaire:setWeaponStorage("Homing", 1)				
	playerBlaire:setWeaponStorageMax("Nuke", 0)			--less (vs 2)
	playerBlaire:setWeaponStorage("Nuke", 0)				
	playerBlaire:setWeaponStorageMax("HVLI", 17)		--more (vs 10)
	playerBlaire:setWeaponStorage("HVLI", 17)				
	playerBlaire:addReputationPoints(50)
	playerShipSpawned("Blaire")
end
function createPlayerShipBlazon()
	--ship destroyed 24Aug2019
	playerBlazon = PlayerSpaceship():setTemplate("Striker"):setFaction("Human Navy"):setCallSign("Blazon")
	playerBlazon:setTypeName("Stricken")
	playerBlazon:setRepairCrewCount(2)
	playerBlazon:setImpulseMaxSpeed(105)					-- up from default of 45
	playerBlazon:setRotationMaxSpeed(35)					-- up from default of 15
	playerBlazon:setShieldsMax(80,50)						-- up from 50, 30
	playerBlazon:setShields(80,50)							-- up from 50, 30
	playerBlazon:setBeamWeaponTurret(0,60,-15,2)			-- 60: narrower than default 100, 
	playerBlazon:setBeamWeaponTurret(1,60, 15,2)			-- 2: slower than default 6
	playerBlazon:setBeamWeapon(2,20,0,1200,6,5)				-- add forward facing beam
	playerBlazon:setWeaponTubeCount(3)						-- add tubes
	playerBlazon:setWeaponTubeDirection(0,-60)
	playerBlazon:setWeaponTubeDirection(1,60)
	playerBlazon:setWeaponTubeDirection(2,180)
	playerBlazon:weaponTubeDisallowMissle(0,"Mine")
	playerBlazon:weaponTubeDisallowMissle(1,"Mine")
	playerBlazon:setWeaponTubeExclusiveFor(2,"Mine")
	playerBlazon:setWeaponStorageMax("Homing",6)
	playerBlazon:setWeaponStorage("Homing",6)
	playerBlazon:setWeaponStorageMax("EMP",2)
	playerBlazon:setWeaponStorage("EMP",2)
	playerBlazon:setWeaponStorageMax("Nuke",2)
	playerBlazon:setWeaponStorage("Nuke",2)
	playerBlazon:setWeaponStorageMax("Mine",4)
	playerBlazon:setWeaponStorage("Mine",4)
	playerBlazon:addReputationPoints(50)
	playerShipSpawned("Blazon")
end
function createPlayerShipCobra()
	playerCobra = PlayerSpaceship():setTemplate("Striker"):setFaction("Human Navy"):setCallSign("Cobra")
	playerCobra:setTypeName("Striker LX")
	playerCobra:setRepairCrewCount(3)						--more (vs 2)
	playerCobra:setShieldsMax(100,100)						--stronger shields (vs 50, 30)
	playerCobra:setShields(100,100)
	playerCobra:setHullMax(100)								--weaker hull (vs 120)
	playerCobra:setHull(100)
	playerCobra:setMaxEnergy(600)							--more maximum energy (vs 500)
	playerCobra:setEnergy(600)
	playerCobra:setJumpDrive(true)
	playerCobra.max_jump_range = 20000						--shorter than typical (vs 50)
	playerCobra.min_jump_range = 2000						--shorter than typical (vs 5)
	playerCobra:setJumpDriveRange(playerCobra.min_jump_range,playerCobra.max_jump_range)
	playerCobra:setJumpDriveCharge(playerCobra.max_jump_range)
	playerCobra:setImpulseMaxSpeed(65)						--faster impulse max (vs 45)
--                 				 Arc, Dir, Range, CycleTime, Damage
	playerCobra:setBeamWeapon(0,  10, -15,	1100, 		6.0, 	6.5)	--shorter (vs 1200) more damage (vs 6.0)
	playerCobra:setBeamWeapon(1,  10,  15,	1100, 		6.0,	6.5)
--									   Arc, Dir, Rotate speed
	playerCobra:setBeamWeaponTurret(0, 100, -15, .2)		--slower turret speed (vs 6)
	playerCobra:setBeamWeaponTurret(1, 100,  15, .2)
	playerCobra:setWeaponTubeCount(2)						--more tubes (vs 0)
	playerCobra:setWeaponTubeDirection(0,180)				
	playerCobra:setWeaponTubeDirection(1,180)
	playerCobra:setWeaponStorageMax("Homing",4)
	playerCobra:setWeaponStorage("Homing", 4)	
	playerCobra:setWeaponStorageMax("Nuke",2)	
	playerCobra:setWeaponStorage("Nuke", 2)	
	playerCobra:setWeaponStorageMax("EMP",3)	
	playerCobra:setWeaponStorage("EMP", 3)		
	playerCobra:setWeaponStorageMax("Mine",3)	
	playerCobra:setWeaponStorage("Mine", 3)	
	playerCobra:setWeaponStorageMax("HVLI",6)	
	playerCobra:setWeaponStorage("HVLI", 6)	
	playerCobra:setLongRangeRadarRange(20000)				--shorter longer range sensors (vs 30000)
	playerCobra.normal_long_range_radar = 20000
	playerCobra:setShortRangeRadarRange(4000)				--shorter short range sensors (vs 5000)
	playerCobra:addReputationPoints(50)
	playerShipSpawned("Cobra")
end
function createPlayerShipDarkstar()
	playerDarkstar = PlayerSpaceship():setTemplate("Player Cruiser"):setFaction("Human Navy"):setCallSign("Darkstar")
	playerDarkstar:setTypeName("Destroyer IV")
	playerDarkstar:setJumpDriveRange(3000,28000)			--shorter jump drive range (vs 5-50)
	playerDarkstar:setShieldsMax(100, 100)					--stronger shields (vs 80, 80)
	playerDarkstar:setShields(100, 100)
	playerDarkstar:setHullMax(100)							--weaker hull (vs 200)
	playerDarkstar:setHull(100)
	playerDarkstar:setBeamWeapon(0, 40, -10, 1000.0, 5, 6)	--narrower (40 vs 90), faster (5 vs 6), weaker (6 vs 10)
	playerDarkstar:setBeamWeapon(1, 40,  10, 1000.0, 5, 6)
	playerDarkstar:setWeaponTubeDirection(0,-60)			--left -60 (vs -5)
	playerDarkstar:setWeaponTubeDirection(1, 60)			--right 60 (vs 5)
	playerDarkstar:setWeaponStorageMax("Homing",6)			--less (vs 12)
	playerDarkstar:setWeaponStorage("Homing", 6)				
	playerDarkstar:setWeaponStorageMax("Nuke",2)			--fewer (vs 4)
	playerDarkstar:setWeaponStorage("Nuke", 2)				
	playerDarkstar:setWeaponStorageMax("EMP",3)				--fewer (vs 6)
	playerDarkstar:setWeaponStorage("EMP", 3)				
	playerDarkstar:setWeaponStorageMax("Mine",4)			--fewer (vs 8)
	playerDarkstar:setWeaponStorage("Mine", 4)				
	playerDarkstar:setWeaponStorageMax("HVLI",6)			--more (vs 0)
	playerDarkstar:setWeaponStorage("HVLI", 6)				
	playerDarkstar:addReputationPoints(50)
	playerShipSpawned("Darkstar")
end
function createPlayerShipEagle()
	playerEagle = PlayerSpaceship():setTemplate("Flavia P.Falcon"):setFaction("Human Navy"):setCallSign("Eagle")
	playerEagle:setTypeName("Era")
	playerEagle:setRotationMaxSpeed(15)									--faster spin (vs 10)
--                 				 Arc, Dir, Range, CycleTime, Damage
	playerEagle:setBeamWeapon(0,  10,   0,	1200, 		6.0, 	6.0)	--1 turret, 1 rear (vs 2 rear)
	playerEagle:setBeamWeapon(1,  80, 180,	1200, 		6.0,	6.0)
--										Arc,  Dir, Rotate speed
	playerEagle:setBeamWeaponTurret(0,	300,    0,			 .5)		--slow turret
	playerEagle:setShieldsMax(70, 100)									--stronger rear shields (vs 70, 70)
	playerEagle:setShields(70, 100)
	playerEagle:setLongRangeRadarRange(50000)							--longer long range sensors (vs 30000)
	playerEagle.normal_long_range_radar = 50000
	playerEagle:addReputationPoints(50)
	playerShipSpawned("Eagle")
end
function createPlayerShipEnola()
	playerEnola = PlayerSpaceship():setTemplate("Crucible"):setFaction("Human Navy"):setCallSign("Enola")
	playerEnola:setTypeName("Fray")
	playerEnola:setWarpDrive(false)						--no warp drive (vs warp)
	playerEnola:setShieldsMax(100, 200)					--stronger rear shields (vs 160, 160)
	playerEnola:setShields(100, 200)
	playerEnola:setJumpDrive(true)						--jump drive (vs warp)
	playerEnola.max_jump_range = 20000					--shorter than typical (vs 50)
	playerEnola.min_jump_range = 2000					--shorter than typical (vs 5)
	playerEnola:setJumpDriveRange(playerEnola.min_jump_range,playerEnola.max_jump_range)
	playerEnola:setJumpDriveCharge(playerEnola.max_jump_range)
--                  			Arc, Dir, Range, CycleTime, Dmg
	playerEnola:setBeamWeapon(0, 10,   0, 900.0, 	   6.0,   4)	--3 beams (vs 2), shorter (vs 1000)
	playerEnola:setBeamWeapon(1, 10, -90, 900.0, 	   6.0,   4)	--less damage (vs 5)
	playerEnola:setBeamWeapon(2, 10,  90, 900.0, 	   6.0,   4)	--wider overall coverage, split overlap
--										Arc,  Dir, Rotate speed
	playerEnola:setBeamWeaponTurret(0,	110,    0,			 .3)	--slow turret
	playerEnola:setBeamWeaponTurret(1,	 90,  -90,			 .3)		
	playerEnola:setBeamWeaponTurret(2,	 90,   90,			 .3)		
	playerEnola:setWeaponTubeCount(4)					--fewer (vs 6)
	playerEnola:setWeaponTubeDirection(0, 180)			--all tubes face back (vs 3 front, 2 sides and 1 back)
	playerEnola:setWeaponTubeDirection(1, 180)
	playerEnola:setWeaponTubeDirection(2, 180)
	playerEnola:setWeaponTubeDirection(3, 180)
	playerEnola:setWeaponTubeExclusiveFor(1,"Homing")	
	playerEnola:weaponTubeAllowMissle(1,"EMP")			--Medium tube only for Homing or EMP (vs HVLI)
	playerEnola:setWeaponTubeExclusiveFor(2,"Nuke")		--Large tube only for nuke (vs HVLI)
	playerEnola:setWeaponTubeExclusiveFor(3,"Mine")
	playerEnola:setWeaponStorageMax("HVLI", 12)			--fewer (vs 24)
	playerEnola:setWeaponStorage("HVLI", 12)				
	playerEnola:setWeaponStorageMax("Homing",5)			--fewer (vs 8)
	playerEnola:setWeaponStorage("Homing", 5)				
	playerEnola:setWeaponStorageMax("EMP", 4)			--fewer (vs 6)
	playerEnola:setWeaponStorage("EMP", 4)				
	playerEnola:setWeaponStorageMax("Nuke", 2)			--fewer (vs 4)
	playerEnola:setWeaponStorage("Nuke", 2)				
	playerEnola:setWeaponStorageMax("Mine", 3)			--fewer (vs 6)
	playerEnola:setWeaponStorage("Mine", 3)				
	playerEnola:addReputationPoints(50)
	playerShipSpawned("Enola")
end
function createPlayerShipFalcon()
	playerFalcon = PlayerSpaceship():setTemplate("Nautilus"):setFaction("Human Navy"):setCallSign("Falcon")
	playerFalcon:setTypeName("Eldridge")
	playerFalcon:setShieldsMax(100, 100)				--stronger shields (vs 60, 60)
	playerFalcon:setShields(100, 100)
	playerFalcon:setJumpDrive(false)					--no jump drive
	playerFalcon:setWarpDrive(true)						--warp drive (vs jump)
	playerFalcon:setWarpSpeed(400)						
	playerFalcon:setWeaponTubeDirection(0,0)			--front facing (vs back)
	playerFalcon:setWeaponTubeDirection(1,0)			--front facing (vs back)
	playerFalcon:setWeaponTubeExclusiveFor(0,"Homing")	--Homing only (vs Mine)
	playerFalcon:setWeaponTubeExclusiveFor(1,"Homing")	--Homing only (vs Mine)
	playerFalcon:setWeaponTubeExclusiveFor(2,"Mine")	--Mine only (vs any)
	playerFalcon:setWeaponStorageMax("Homing",8)		--more homing (vs 0)
	playerFalcon:setWeaponStorage("Homing", 8)				
	playerFalcon:setWeaponStorageMax("Mine",8)			--fewer mines (vs 12)
	playerFalcon:setWeaponStorage("Mine", 8)				
--                 				 Arc, Dir, Range, CycleTime, Damage
	playerFalcon:setBeamWeapon(0,  10, -90,	1200, 		6.0, 	6.0)	--broadside beams (vs forward, overlapping)	
	playerFalcon:setBeamWeapon(1,  10,  90,	1200, 		6.0,	6.0)
--										Arc,  Dir, Rotate speed
	playerFalcon:setBeamWeaponTurret(0,	 90,  -90,			 .3)		--slow turret
	playerFalcon:setBeamWeaponTurret(1,	 90,   90,			 .3)
	playerFalcon:addReputationPoints(50)
	playerShipSpawned("Falcon")
end
function createPlayerShipGabble()
	playerGabble = PlayerSpaceship():setTemplate("Piranha"):setFaction("Human Navy"):setCallSign("Gabble")
	playerGabble:setTypeName("Squid")
	playerGabble:setRepairCrewCount(4)							--more repair crew (vs 2)
	playerGabble.max_jump_range = 20000					--shorter than typical (vs 50)
	playerGabble.min_jump_range = 2000					--shorter than typical (vs 5)
	playerGabble:setJumpDriveRange(playerGabble.min_jump_range,playerGabble.max_jump_range)
	playerGabble:setJumpDriveCharge(playerGabble.max_jump_range)
	playerGabble:setBeamWeapon(0, 10, 0, 1000.0, 4.0, 4)		--one beam (vs 0)
	playerGabble:setBeamWeaponTurret(0, 80, 0, 1)				--slow turret 
	playerGabble:setWeaponTubeDirection(0,0)					--forward facing (vs left)
	playerGabble:setWeaponTubeDirection(3,0)					--forward facing (vs right)
	playerGabble:setWeaponTubeExclusiveFor(2,"Homing")			--homing only (vs HVLI)
	playerGabble:setWeaponTubeExclusiveFor(5,"Homing")			--homing only (vs HVLI)
	playerGabble:setWeaponTubeExclusiveFor(0,"HVLI")			--HVLI only (vs Homing + HVLI)
	playerGabble:setWeaponTubeExclusiveFor(3,"HVLI")			--HVLI only (vs Homing + HVLI)
	playerGabble:weaponTubeDisallowMissle(1,"Mine")				--no sideways mines
	playerGabble:weaponTubeDisallowMissle(4,"Mine")				--no sideways mines
	playerGabble:setWeaponStorageMax("HVLI",8)					--fewer HVLI (vs 20)
	playerGabble:setWeaponStorage("HVLI", 8)				
	playerGabble:setWeaponStorageMax("Homing",8)				--fewer Homing (vs 12)
	playerGabble:setWeaponStorage("Homing", 8)				
	playerGabble:setWeaponStorageMax("Mine",4)					--fewer mines (vs 8)
	playerGabble:setWeaponStorage("Mine", 4)				
	playerGabble:setWeaponStorageMax("EMP",4)					--more EMPs (vs 0)
	playerGabble:setWeaponStorage("EMP", 4)					
	playerGabble:setWeaponStorageMax("Nuke",4)					--fewer Nukes (vs 6)
	playerGabble:setWeaponStorage("Nuke", 4)				
	playerGabble:setLongRangeRadarRange(25000)					--shorter long range sensors (vs 30000)
	playerGabble.normal_long_range_radar = 25000
	playerGabble:addReputationPoints(50)
	playerShipSpawned("Gabble")
end
function createPlayerShipGadfly()
	playerGadfly = PlayerSpaceship():setTemplate("Player Fighter"):setFaction("Human Navy"):setCallSign("Bling")
	playerGadfly:setTypeName("Gadfly")
	playerGadfly:setHullMax(100)						--stronger (vs 60)
	playerGadfly:setHull(100)
	playerGadfly:setShieldsMax(80,80)					--stronger shields (vs 40)
	playerGadfly:setShields(80,80)
	playerGadfly:setJumpDrive(true)						--jump drive (vs none)
	playerGadfly.max_jump_range = 15000					--shorter than typical (vs 50)
	playerGadfly.min_jump_range = 2000					--shorter than typical (vs 5)
	playerGadfly:setJumpDriveRange(playerGadfly.min_jump_range,playerGadfly.max_jump_range)
	playerGadfly:setJumpDriveCharge(playerGadfly.max_jump_range)
--                  			 Arc, Dir, Range, CycleTime, Dmg
	playerGadfly:setBeamWeapon(0, 50, 	0, 900.0, 		4.0, 8)		--wider (vs 40), shorter (vs 1), faster (vs 6)
	playerGadfly:setBeamWeapon(1,  0,	0,	   0,		  0, 0)		--fewer (vs 2)
	playerGadfly:setWeaponTubeCount(3)					--more (vs 0)
	playerGadfly:setWeaponTubeDirection(2, 180)
	playerGadfly:setTubeSize(0,"small")
	playerGadfly:setTubeLoadTime(0,5)
	playerGadfly:setWeaponTubeExclusiveFor(0,"HVLI")
	playerGadfly:setTubeLoadTime(1,10)
	playerGadfly:setWeaponTubeExclusiveFor(1,"Nuke")
	playerGadfly:weaponTubeAllowMissle(1,"EMP")
	playerGadfly:setTubeSize(2,"large")
	playerGadfly:setTubeLoadTime(2,15)
	playerGadfly:setWeaponTubeExclusiveFor(2,"Homing")
	playerGadfly:setWeaponStorageMax("Homing", 4)		--more (vs 0)
	playerGadfly:setWeaponStorage("Homing", 4)				
	playerGadfly:setWeaponStorageMax("Nuke", 1)			--more (vs 0)
	playerGadfly:setWeaponStorage("Nuke", 1)				
	playerGadfly:setWeaponStorageMax("EMP", 1)			--more (vs 0)
	playerGadfly:setWeaponStorage("EMP", 1)				
	playerGadfly:setWeaponStorageMax("HVLI", 8)			--more (vs 0)
	playerGadfly:setWeaponStorage("HVLI", 8)				
	playerGadfly:addReputationPoints(50)
	playerShipSpawned("Gadfly")
end
function createPlayerShipGorn()
	playerGorn = PlayerSpaceship():setTemplate("Atlantis"):setFaction("Human Navy"):setCallSign("Gorn")
	playerGorn:setTypeName("Proto-Atlantis")
	playerGorn:setRepairCrewCount(5)					--more repair crew (vs 3)
	playerGorn.max_jump_range = 30000					--shorter than typical (vs 50)
	playerGorn.min_jump_range = 3000					--shorter than typical (vs 5)
	playerGorn:setJumpDriveRange(playerGorn.min_jump_range,playerGorn.max_jump_range)
	playerGorn:setJumpDriveCharge(playerGorn.max_jump_range)
	playerGorn:setBeamWeaponEnergyPerFire(0,playerGorn:getBeamWeaponEnergyPerFire(0)*3)		--triple power use
	playerGorn:setBeamWeaponHeatPerFire(0,playerGorn:getBeamWeaponHeatPerFire(0)*3)			--triple heat
	playerGorn:setBeamWeaponEnergyPerFire(1,playerGorn:getBeamWeaponEnergyPerFire(1)*3)		--triple power use
	playerGorn:setBeamWeaponHeatPerFire(1,playerGorn:getBeamWeaponHeatPerFire(1)*3)			--triple heat
	playerGorn:setWeaponTubeExclusiveFor(0,"HVLI")		--HVLI only (vs all but Mine)
	playerGorn:setWeaponTubeExclusiveFor(1,"Homing")	--Homing only (vs all but Mine)
	playerGorn:setWeaponTubeExclusiveFor(2,"HVLI")		--HVLI only (vs all but Mine)
	playerGorn:setWeaponTubeExclusiveFor(3,"Homing")	--Homing only (vs all but Mine)
	playerGorn:setWeaponStorageMax("EMP",0)				--fewer (vs 6)
	playerGorn:setWeaponStorage("EMP", 0)				
	playerGorn:setWeaponStorageMax("Nuke",0)			--fewer (vs 4)
	playerGorn:setWeaponStorage("Nuke", 0)	
	playerGorn:setLongRangeRadarRange(28000)			--shorter longer range sensors (vs 30000)
	playerGorn.normal_long_range_radar = 28000
	playerGorn:addReputationPoints(50)
	playerShipSpawned("Gorn")
end
function createPlayerShipGuinevere()
	playerGuinevere = PlayerSpaceship():setTemplate("Crucible"):setFaction("Human Navy"):setCallSign("Guinevere")
	playerGuinevere:setTypeName("Caretaker")
	playerGuinevere:setWarpDrive(false)						--no warp drive (vs warp)
	playerGuinevere:setJumpDrive(true)						--jump drive (vs warp)
	playerGuinevere.max_jump_range = 40000					--shorter than typical (vs 50)
	playerGuinevere.min_jump_range = 4000					--shorter than typical (vs 5)
	playerGuinevere:setJumpDriveRange(playerGuinevere.min_jump_range,playerGuinevere.max_jump_range)
	playerGuinevere:setJumpDriveCharge(playerGuinevere.max_jump_range)
	playerGuinevere:setShieldsMax(100, 100)					--weaker shields (vs 160, 160)
--                  			 Arc, Dir, Range, CycleTime, Dmg
	playerGuinevere:setBeamWeapon(0, 80, -90, 900.0, 		5.0,   6)	--side beams (vs forward), faster (vs 6)
	playerGuinevere:setBeamWeapon(1, 80,  90, 900.0, 		5.0,   6)	
	playerGuinevere:setWeaponTubeCount(4)					--fewer (vs 6)
	playerGuinevere:setWeaponTubeExclusiveFor(1,"EMP")		--normal sized tube allow EMPs and Nukes (vs HVLI)
	playerGuinevere:weaponTubeAllowMissle(1,"Nuke")
	playerGuinevere:setWeaponTubeExclusiveFor(2,"Homing")	--large tube for homing (vs HVLI)
	playerGuinevere:setWeaponTubeExclusiveFor(3,"Mine")
	playerGuinevere:setWeaponTubeDirection(3, 180)
	playerGuinevere:setWeaponStorageMax("Homing",6)			--fewer (vs 8)
	playerGuinevere:setWeaponStorage("Homing", 6)				
	playerGuinevere:setWeaponStorageMax("EMP",3)			--fewer (vs 6)
	playerGuinevere:setWeaponStorage("EMP", 3)				
	playerGuinevere:setWeaponStorageMax("Nuke",2)			--fewer (vs 4)
	playerGuinevere:setWeaponStorage("Nuke", 2)				
	playerGuinevere:setWeaponStorageMax("Mine",3)			--fewer (vs 6)
	playerGuinevere:setWeaponStorage("Mine", 3)				
	playerGuinevere:addReputationPoints(50)
	playerShipSpawned("Guinevere")
end
function createPlayerShipHalberd()
	--destroyed 29Feb2020
	playerHalberd = PlayerSpaceship():setTemplate("Atlantis"):setFaction("Human Navy"):setCallSign("Halberd")
	playerHalberd:setTypeName("Proto-Atlantis")
	playerHalberd:setRepairCrewCount(4)					--more repair crew (vs 3)
	playerHalberd:setImpulseMaxSpeed(70)				--slower impulse max (vs 90)
	playerHalberd:setRotationMaxSpeed(14)				--faster spin (vs 10)
	playerHalberd.max_jump_range = 30000				--shorter than typical (vs 50)
	playerHalberd.min_jump_range = 3000					--shorter than typical (vs 5)
	playerHalberd:setJumpDriveRange(playerHalberd.min_jump_range,playerHalberd.max_jump_range)
	playerHalberd:setJumpDriveCharge(playerHalberd.max_jump_range)
	playerHalberd:setHullMax(200)						--weaker hull (vs 250)
	playerHalberd:setHull(200)							
	playerHalberd:setShieldsMax(150,150)				--weaker shields (vs 200)
	playerHalberd:setShields(150,150)
	
--                 				 Arc, Dir, Range, CycleTime, Dmg
	playerHalberd:setBeamWeapon(0, 5, -10,  1500,       6.0, 8)		--narrower turreted beams
	playerHalberd:setBeamWeapon(1, 5,  10,  1500,       6.0, 8)		--vs arc:100, dir:-20
--									    Arc, Dir, Rotate speed
	playerHalberd:setBeamWeaponTurret(0, 70, -10, .25)
	playerHalberd:setBeamWeaponTurret(1, 70,  10, .25)

	playerHalberd:setWeaponTubeDirection(0,-90)			--front left facing (vs left)
	playerHalberd:setWeaponTubeDirection(1,-60)			--front left facing (vs left)
	playerHalberd:setWeaponTubeDirection(2, 60)			--front right facing (vs right)
	playerHalberd:setWeaponTubeDirection(3, 90)			--front right facing (vs right)
	playerHalberd:setWeaponTubeExclusiveFor(0,"Nuke")	--HVLI only (vs all but Mine)
	playerHalberd:setWeaponTubeExclusiveFor(1,"HVLI")	--Nuke only (vs all but Mine)
	playerHalberd:setWeaponTubeExclusiveFor(2,"Homing")	--Homing only (vs all but Mine)
	playerHalberd:setWeaponTubeExclusiveFor(3,"EMP")	--EMP only (vs all but Mine)
	playerHalberd:addReputationPoints(50)
	playerShipSpawned("Halberd")
end
function createPlayerShipHeadhunter()
	playerHeadhunter = PlayerSpaceship():setTemplate("Piranha"):setFaction("Human Navy"):setCallSign("Headhunter")
	playerHeadhunter:setTypeName("Redhook")
	playerHeadhunter:setRepairCrewCount(4)						--more repair crew (vs 2)
	playerHeadhunter.max_jump_range = 25000				--shorter than typical (vs 50)
	playerHeadhunter.min_jump_range = 2000					--shorter than typical (vs 5)
	playerHeadhunter:setJumpDriveRange(playerHeadhunter.min_jump_range,playerHeadhunter.max_jump_range)
	playerHeadhunter:setJumpDriveCharge(playerHeadhunter.max_jump_range)
	playerHeadhunter:setHullMax(140)							--stronger hull (vs 120)
	playerHeadhunter:setHull(140)
	playerHeadhunter:setShieldsMax(100, 100)					--stronger shields (vs 70, 70)
	playerHeadhunter:setShields(100, 100)
	playerHeadhunter:setBeamWeapon(0, 10, 0, 1200.0, 4.0, 4)	--one beam (vs 0)
	playerHeadhunter:setBeamWeaponTurret(0, 80, 0, 1)			--slow turret 
	playerHeadhunter:setWeaponTubeCount(7)						--one fewer mine tube, but EMPs added
	playerHeadhunter:setWeaponTubeDirection(6, 180)				--mine tube points straight back
	playerHeadhunter:setWeaponTubeExclusiveFor(0,"HVLI")
	playerHeadhunter:setWeaponTubeExclusiveFor(1,"HVLI")
	playerHeadhunter:setWeaponTubeExclusiveFor(2,"HVLI")
	playerHeadhunter:setWeaponTubeExclusiveFor(3,"HVLI")
	playerHeadhunter:setWeaponTubeExclusiveFor(4,"HVLI")
	playerHeadhunter:setWeaponTubeExclusiveFor(5,"HVLI")
	playerHeadhunter:setWeaponTubeExclusiveFor(6,"Mine")
	playerHeadhunter:weaponTubeAllowMissle(1,"Homing")
	playerHeadhunter:weaponTubeAllowMissle(1,"EMP")
	playerHeadhunter:weaponTubeAllowMissle(1,"Nuke")
	playerHeadhunter:weaponTubeAllowMissle(4,"Homing")
	playerHeadhunter:weaponTubeAllowMissle(4,"EMP")
	playerHeadhunter:weaponTubeAllowMissle(4,"Nuke")
	playerHeadhunter:setWeaponStorageMax("Mine",4)				--fewer mines (vs 8)
	playerHeadhunter:setWeaponStorage("Mine", 4)				
	playerHeadhunter:setWeaponStorageMax("EMP",4)				--more EMPs (vs 0)
	playerHeadhunter:setWeaponStorage("EMP", 4)					
	playerHeadhunter:setWeaponStorageMax("Nuke",4)				--fewer Nukes (vs 6)
	playerHeadhunter:setWeaponStorage("Nuke", 4)				
	playerHeadhunter:addReputationPoints(50)
	playerShipSpawned("Headhunter")
end
function createPlayerShipHearken()
	playerHearken = PlayerSpaceship():setTemplate("Piranha"):setFaction("Human Navy"):setCallSign("Hearken")
	playerHearken:setTypeName("Redhook")
	playerHearken:setRepairCrewCount(4)						--more repair crew (vs 2)
	playerHearken.max_jump_range = 30000					--shorter than typical (vs 50)
	playerHearken.min_jump_range = 3000						--shorter than typical (vs 5)
	playerHearken:setJumpDriveRange(playerHearken.min_jump_range,playerHearken.max_jump_range)
	playerHearken:setJumpDriveCharge(playerHearken.max_jump_range)
	playerHearken:setBeamWeapon(0, 10, 0, 1000.0, 4.0, 4)	--one beam (vs 0)
	playerHearken:setBeamWeaponTurret(0, 80, 0, .5)			--slow turret 
	playerHearken:setWeaponTubeCount(7)						--one fewer mine tube, but EMPs added
	playerHearken:setWeaponTubeDirection(6, 180)			--mine tube points straight back
	playerHearken:setWeaponTubeExclusiveFor(0,"HVLI")
	playerHearken:setWeaponTubeExclusiveFor(1,"HVLI")
	playerHearken:setWeaponTubeExclusiveFor(2,"HVLI")
	playerHearken:setWeaponTubeExclusiveFor(3,"HVLI")
	playerHearken:setWeaponTubeExclusiveFor(4,"HVLI")
	playerHearken:setWeaponTubeExclusiveFor(5,"HVLI")
	playerHearken:setWeaponTubeExclusiveFor(6,"Mine")
	playerHearken:weaponTubeAllowMissle(0,"Homing")
	playerHearken:weaponTubeAllowMissle(3,"Homing")
	playerHearken:weaponTubeAllowMissle(1,"EMP")
	playerHearken:weaponTubeAllowMissle(4,"EMP")
	playerHearken:setWeaponStorageMax("Mine",4)				--fewer mines (vs 8)
	playerHearken:setWeaponStorage("Mine", 4)				
	playerHearken:setWeaponStorageMax("EMP",4)				--more EMPs (vs 0)
	playerHearken:setWeaponStorage("EMP", 4)					
	playerHearken:setWeaponStorageMax("Nuke",0)				--fewer Nukes (vs 6)
	playerHearken:setWeaponStorage("Nuke", 0)				
	playerHearken:addReputationPoints(50)
	playerShipSpawned("Hearken")
end
function createPlayerShipHolmes()
	playerHolmes = PlayerSpaceship():setTemplate("Crucible"):setFaction("Human Navy"):setCallSign("Watson")
	playerHolmes:setTypeName("Holmes")
	playerHolmes:setImpulseMaxSpeed(70)						--slower (vs 80)
--                  			 Arc, Dir, Range, CycleTime, Dmg
	playerHolmes:setBeamWeapon(0, 50, -85, 900.0, 		6.0, 5)	--broadside beams, narrower (vs 70)
	playerHolmes:setBeamWeapon(1, 50, -95, 900.0, 		6.0, 5)	
	playerHolmes:setBeamWeapon(2, 50,  85, 900.0, 		6.0, 5)	
	playerHolmes:setBeamWeapon(3, 50,  95, 900.0, 		6.0, 5)	
	playerHolmes:setWeaponTubeCount(4)						--fewer (vs 6)
	playerHolmes:setWeaponTubeExclusiveFor(0,"Homing")		--tubes only shoot homing missiles (vs more options)
	playerHolmes:setWeaponTubeExclusiveFor(1,"Homing")
	playerHolmes:setWeaponTubeExclusiveFor(2,"Homing")
	playerHolmes:setWeaponTubeExclusiveFor(3,"Mine")
	playerHolmes:setWeaponTubeDirection(3, 180)
	playerHolmes:setWeaponStorageMax("Homing",10)			--more (vs 8)
	playerHolmes:setWeaponStorage("Homing", 10)				
	playerHolmes:setWeaponStorageMax("HVLI",0)				--fewer
	playerHolmes:setWeaponStorage("HVLI", 0)				
	playerHolmes:setWeaponStorageMax("EMP",0)				--fewer
	playerHolmes:setWeaponStorage("EMP", 0)				
	playerHolmes:setWeaponStorageMax("Nuke",0)				--fewer
	playerHolmes:setWeaponStorage("Nuke", 0)	
	playerHolmes:setLongRangeRadarRange(35000)				--longer longer range sensors (vs 30000)
	playerHolmes.normal_long_range_radar = 35000
	playerHolmes:setShortRangeRadarRange(4000)				--shorter short range sensors (vs 5000)
	playerHolmes:addReputationPoints(50)
	playerShipSpawned("Holmes")
end
function createPlayerShipJarvis()
	playerJarvis = PlayerSpaceship():setTemplate("Crucible"):setFaction("Human Navy"):setCallSign("Jarvis")
	playerJarvis:setTypeName("Butler")
	playerJarvis:setImpulseMaxSpeed(70)						--slower impulse max (vs 80)
	playerJarvis:setRotationMaxSpeed(12)					--slower spin (vs 15)
	playerJarvis:setWarpSpeed(400)							--slower (vs 750)
	playerJarvis:setHullMax(100)							--weaker hull (vs 160)
	playerJarvis:setHull(100)
	playerJarvis:setShieldsMax(100, 100)					--weaker shields (vs 160, 160)
--                  			 Arc, Dir, Range, CycleTime, Dmg
	playerJarvis:setBeamWeapon(0, 10, -60, 900.0, 		6.0,   6)	--left, right, overlap beams (vs forward)
	playerJarvis:setBeamWeapon(1, 10,  60, 900.0, 		6.0,   6)	
--										Arc, Dir, Rotate speed
	playerJarvis:setBeamWeaponTurret(0, 140, -60, .6)		--slow turret beams
	playerJarvis:setBeamWeaponTurret(1, 140,  60, .6)
	playerJarvis:setWeaponTubeCount(4)						--fewer (vs 6)
	playerJarvis:setWeaponTubeExclusiveFor(0,"Nuke")		--small sized tube nuke only (vs HVLI)
	playerJarvis:setWeaponTubeExclusiveFor(1,"EMP")			--normal sized tube EMP only (vs HVLI)
	playerJarvis:setWeaponTubeExclusiveFor(3,"Homing")		--homing only
	playerJarvis:setWeaponTubeDirection(3, 180)				--on rear tube
	playerJarvis:setWeaponStorageMax("Homing",4)			--fewer (vs 8)
	playerJarvis:setWeaponStorage("Homing", 4)				
	playerJarvis:setWeaponStorageMax("EMP",4)				--fewer (vs 6)
	playerJarvis:setWeaponStorage("EMP", 4)				
	playerJarvis:setWeaponStorageMax("Nuke",3)				--fewer (vs 4)
	playerJarvis:setWeaponStorage("Nuke", 3)				
	playerJarvis:setWeaponStorageMax("Mine",0)				--fewer (vs 6)
	playerJarvis:setWeaponStorage("Mine", 0)				
	playerJarvis:addReputationPoints(50)
	playerShipSpawned("Jarvis")
end
function createPlayerShipJeeves()
	playerJeeves = PlayerSpaceship():setTemplate("Crucible"):setFaction("Human Navy"):setCallSign("Jeeves")
	playerJeeves:setTypeName("Butler")
	playerJeeves:setWarpSpeed(400)							--slower (vs 750)
	playerJeeves:setHullMax(100)							--weaker hull (vs 160)
	playerJeeves:setHull(100)
	playerJeeves:setShieldsMax(100, 100)					--weaker shields (vs 160, 160)
--                  			 Arc, Dir, Range, CycleTime, Dmg
	playerJeeves:setBeamWeapon(0, 80, -90, 900.0, 		6.0,   6)	--side beams (vs forward)
	playerJeeves:setBeamWeapon(1, 80,  90, 900.0, 		6.0,   6)	
	playerJeeves:setWeaponTubeCount(4)								--fewer (vs 6)
	playerJeeves:setWeaponTubeExclusiveFor(1,"EMP")					--normal sized tube allow EMPs and Nukes (vs HVLI)
	playerJeeves:weaponTubeAllowMissle(1,"Nuke")
	playerJeeves:setWeaponTubeExclusiveFor(2,"Homing")				--large tube for homing (vs HVLI)
	playerJeeves:setWeaponTubeExclusiveFor(3,"Mine")
	playerJeeves:setWeaponTubeDirection(3, 180)
	playerJeeves:setWeaponStorageMax("Homing",6)			--fewer (vs 8)
	playerJeeves:setWeaponStorage("Homing", 6)				
	playerJeeves:setWeaponStorageMax("EMP",3)				--fewer (vs 6)
	playerJeeves:setWeaponStorage("EMP", 3)				
	playerJeeves:setWeaponStorageMax("Nuke",2)				--fewer (vs 4)
	playerJeeves:setWeaponStorage("Nuke", 2)				
	playerJeeves:setWeaponStorageMax("Mine",3)				--fewer (vs 6)
	playerJeeves:setWeaponStorage("Mine", 3)				
	playerJeeves:addReputationPoints(50)
	playerShipSpawned("Jeeves")
end
function createPlayerShipKnick()
	playerKnick = PlayerSpaceship():setTemplate("ZX-Lindworm"):setFaction("Human Navy"):setCallSign("Knick")
	playerKnick:setTypeName("Glass Cannon")
	playerKnick:setTubeSize(0, "large")
	playerKnick:setTubeSize(1, "large")
	playerKnick:setTubeSize(2, "large")
	playerKnick:addReputationPoints(50)
	playerShipSpawned("Knick")
end
function createPlayerShipLancelot()
	playerLancelot = PlayerSpaceship():setTemplate("Player Cruiser"):setFaction("Human Navy"):setCallSign("Lancelot")
	playerLancelot:setTypeName("Noble")
	playerLancelot:setRepairCrewCount(5)							--more repair crew (vs 3)
	playerLancelot:setMaxEnergy(850)								--less maximum energy (vs 1000)
	playerLancelot:setEnergy(850)							
	playerLancelot.max_jump_range = 30000					--shorter than typical (vs 50)
	playerLancelot.min_jump_range = 3000						--shorter than typical (vs 5)
	playerLancelot:setJumpDriveRange(playerLancelot.min_jump_range,playerLancelot.max_jump_range)
	playerLancelot:setJumpDriveCharge(playerLancelot.max_jump_range)
--                 				   Arc, Dir, Range, CycleTime, Dmg
	playerLancelot:setBeamWeapon(0, 40, -45,  1000,         6, 8)	--4 beams (vs 2)
	playerLancelot:setBeamWeapon(1, 40,  45,  1000,         6, 8)	--weaker (vs 10 dmg)
	playerLancelot:setBeamWeapon(2, 40,-135,  1000,         6, 8)	--4 angles (vs overlapping in front)
	playerLancelot:setBeamWeapon(3, 40, 135,  1000,         6, 8)	--narrower (vs 90 degrees)
	playerLancelot:setBeamWeaponEnergyPerFire(0,playerLancelot:getBeamWeaponEnergyPerFire(0)*3)
	playerLancelot:setBeamWeaponHeatPerFire(0,playerLancelot:getBeamWeaponHeatPerFire(0)*3)
	playerLancelot:setBeamWeaponEnergyPerFire(1,playerLancelot:getBeamWeaponEnergyPerFire(1)*3)
	playerLancelot:setBeamWeaponHeatPerFire(1,playerLancelot:getBeamWeaponHeatPerFire(1)*3)
	playerLancelot:setBeamWeaponEnergyPerFire(2,playerLancelot:getBeamWeaponEnergyPerFire(2)*3)
	playerLancelot:setBeamWeaponHeatPerFire(2,playerLancelot:getBeamWeaponHeatPerFire(2)*3)
	playerLancelot:setBeamWeaponEnergyPerFire(3,playerLancelot:getBeamWeaponEnergyPerFire(3)*3)
	playerLancelot:setBeamWeaponHeatPerFire(3,playerLancelot:getBeamWeaponHeatPerFire(3)*3)
	playerLancelot:setWeaponTubeCount(4)							--more (vs 2)
	playerLancelot:setWeaponTubeDirection(0,-90)					--first tube points left (vs -5)
	playerLancelot:setWeaponTubeDirection(1, 90)					--second tube points right (vs 5)
	playerLancelot:setWeaponTubeDirection(2,  0)					--third tube points forward (vs rear)
	playerLancelot:setWeaponTubeDirection(3,180)					--fourth tube points to the rear (vs none)
	playerLancelot:weaponTubeDisallowMissle(0,"HVLI")				--no HVLI (vs all but mine)
	playerLancelot:setWeaponTubeExclusiveFor(1,"Homing")			--only Homing, EMP, nuke (vs only mine)
	playerLancelot:weaponTubeAllowMissle(1,"EMP")
	playerLancelot:weaponTubeAllowMissle(1,"Nuke")
	playerLancelot:setWeaponTubeExclusiveFor(2,"HVLI")				--only HVLI (vs all but mine)
	playerLancelot:setWeaponTubeExclusiveFor(3,"Mine")				--only mine
	playerLancelot:setWeaponStorageMax("Homing", 8)					--less (vs 12)
	playerLancelot:setWeaponStorage("Homing", 8)				
	playerLancelot:setWeaponStorageMax("Mine", 6)					--less (vs 8)
	playerLancelot:setWeaponStorage("Mine", 6)				
	playerLancelot:setWeaponStorageMax("HVLI", 8)					--more (vs 0)
	playerLancelot:setWeaponStorage("HVLI", 8)				
	playerLancelot:setCombatManeuver(200,200)						--less (vs 400,250)
	playerLancelot:addReputationPoints(50)
	playerShipSpawned("Lancelot")
end
function createPlayerShipMagnum()
	playerMagnum = PlayerSpaceship():setTemplate("Crucible"):setFaction("Human Navy"):setCallSign("Magnum")
	playerMagnum:setTypeName("Focus")
	playerMagnum:setImpulseMaxSpeed(70)						--slower (vs 80)
	playerMagnum:setRotationMaxSpeed(20)					--faster spin (vs 15)
	playerMagnum:setWarpDrive(false)						--no warp
	playerMagnum:setJumpDrive(true)							--jump drive
	playerMagnum.max_jump_range = 25000					--shorter than typical (vs 50)
	playerMagnum.min_jump_range = 2500						--shorter than typical (vs 5)
	playerMagnum:setJumpDriveRange(playerMagnum.min_jump_range,playerMagnum.max_jump_range)
	playerMagnum:setJumpDriveCharge(playerMagnum.max_jump_range)
	playerMagnum:setHullMax(100)							--weaker hull (vs 160)
	playerMagnum:setHull(100)
	playerMagnum:setShieldsMax(100, 100)					--weaker shields (vs 160, 160)
	playerMagnum:setShields(100, 100)
	playerMagnum:setBeamWeapon(0, 60, -20, 1000.0, 6.0, 5)	--narrower (vs 70)
	playerMagnum:setBeamWeapon(1, 60,  20, 1000.0, 6.0, 5)	
	playerMagnum:setWeaponTubeCount(4)						--fewer (vs 6)
	playerMagnum:weaponTubeAllowMissle(2,"Homing")
	playerMagnum:weaponTubeAllowMissle(2,"EMP")
	playerMagnum:weaponTubeAllowMissle(2,"Nuke")
	playerMagnum:setWeaponTubeExclusiveFor(3,"Mine")
	playerMagnum:setWeaponTubeDirection(3, 180)
	playerMagnum:setWeaponStorageMax("EMP",2)				--fewer (vs 6)
	playerMagnum:setWeaponStorage("EMP", 2)				
	playerMagnum:setWeaponStorageMax("Nuke",1)				--fewer (vs 4)
	playerMagnum:setWeaponStorage("Nuke", 1)	
	playerMagnum:addReputationPoints(50)
	playerShipSpawned("Magnum")
end
function createPlayerShipManxman()
	playerManxman = PlayerSpaceship():setTemplate("Nautilus"):setFaction("Human Navy"):setCallSign("Manxman")
	playerManxman:setTypeName("Nusret")
	playerManxman.max_jump_range = 25000					--shorter than typical (vs 50)
	playerManxman.min_jump_range = 2500						--shorter than typical (vs 5)
	playerManxman:setJumpDriveRange(playerManxman.min_jump_range,playerManxman.max_jump_range)
	playerManxman:setJumpDriveCharge(playerManxman.max_jump_range)
	playerManxman:setWeaponTubeDirection(0,-60)			--front left facing (vs back)
	playerManxman:setWeaponTubeDirection(1, 60)			--front right facing (vs back)
	playerManxman:setWeaponTubeExclusiveFor(0,"Homing")	--Homing only (vs Mine)
	playerManxman:setWeaponTubeExclusiveFor(1,"Homing")	--Homing only (vs Mine)
	playerManxman:setWeaponStorageMax("Homing",8)		--more homing (vs 0)
	playerManxman:setWeaponStorage("Homing", 8)				
	playerManxman:setWeaponStorageMax("Mine",8)			--fewer mines (vs 12)
	playerManxman:setWeaponStorage("Mine", 8)				
	playerManxman:addReputationPoints(50)
	playerShipSpawned("Manxman")
end
function createPlayerShipNarsil()
	--experimental
	playerNarsil = PlayerSpaceship():setTemplate("Atlantis"):setFaction("Human Navy"):setCallSign("Narsil")
	playerNarsil:setTypeName("Proto-Atlantis")
	playerNarsil:setRepairCrewCount(4)					--more repair crew (vs 3)
	playerNarsil:setImpulseMaxSpeed(70)					--slower impulse max (vs 90)
	playerNarsil:setRotationMaxSpeed(14)				--faster spin (vs 10)
	playerNarsil:setJumpDrive(false)					--no Jump
	playerNarsil:setWarpDrive(true)						--add warp
	playerNarsil:setHullMax(200)						--weaker hull (vs 250)
	playerNarsil:setHull(200)							
	playerNarsil:setShieldsMax(150,150)					--weaker shields (vs 200)
	playerNarsil:setShields(150,150)
	playerNarsil:setWeaponTubeCount(6)					--one more forward tube, less flexible ordnance
	playerNarsil:setWeaponTubeDirection(0,0)			--front facing
	playerNarsil:setWeaponTubeExclusiveFor(0,"HVLI")	--HVLI only
	playerNarsil:setWeaponTubeDirection(1,-90)			--left facing
	playerNarsil:weaponTubeDisallowMissle(1,"Mine")		--all but mine
	playerNarsil:setWeaponTubeDirection(2,-90)			--left facing
	playerNarsil:setWeaponTubeExclusiveFor(2,"HVLI")	--HVLI only
	playerNarsil:setWeaponTubeDirection(3,90)			--right facing
	playerNarsil:weaponTubeDisallowMissle(3,"Mine")		--all but mine
	playerNarsil:setWeaponTubeDirection(4,90)			--right facing
	playerNarsil:setWeaponTubeExclusiveFor(4,"HVLI")	--HVLI only
	playerNarsil:setWeaponTubeDirection(5,180)			--rear facing
	playerNarsil:setWeaponTubeExclusiveFor(5,"Mine")	--Mine only
	playerNarsil:addReputationPoints(50)
	playerShipSpawned("Narsil")
end
function createPlayerShipNimbus()
	playerNimbus = PlayerSpaceship():setTemplate("Phobos M3P"):setFaction("Human Navy"):setCallSign("Nimbus")
	playerNimbus:setTypeName("Phobos T2")
	playerNimbus:setRepairCrewCount(5)					--more repair crew (vs 3)
	playerNimbus:setJumpDrive(true)						--jump drive (vs none)
	playerNimbus.max_jump_range = 25000					--shorter than typical (vs 50)
	playerNimbus.min_jump_range = 2000						--shorter than typical (vs 5)
	playerNimbus:setJumpDriveRange(playerNimbus.min_jump_range,playerNimbus.max_jump_range)
	playerNimbus:setJumpDriveCharge(playerNimbus.max_jump_range)
	playerNimbus:setRotationMaxSpeed(20)				--faster spin (vs 10)
--                 				 Arc, Dir, Range, CycleTime, Dmg
	playerNimbus:setBeamWeapon(0, 10, -15,  1200,         8, 6)
	playerNimbus:setBeamWeapon(1, 10,  15,  1200,         8, 6)
--									   Arc, Dir, Rotate speed
	playerNimbus:setBeamWeaponTurret(0, 90, -15, .2)	--slow turret beams
	playerNimbus:setBeamWeaponTurret(1, 90,  15, .2)
	playerNimbus:setWeaponTubeCount(2)					--one fewer tube (1 forward, 1 rear vs 2 forward, 1 rear)
	playerNimbus:setWeaponTubeDirection(0,0)			--first tube points straight forward
	playerNimbus:setWeaponTubeDirection(1,180)			--second tube points straight back
	playerNimbus:setWeaponTubeExclusiveFor(1,"Mine")
	playerNimbus:setWeaponStorageMax("Homing",6)		--reduce homing storage (vs 10)
	playerNimbus:setWeaponStorage("Homing",6)
	playerNimbus:setWeaponStorageMax("HVLI",10)			--reduce HVLI storage (vs 20)
	playerNimbus:setWeaponStorage("HVLI",10)
	playerNimbus:addReputationPoints(50)
	playerShipSpawned("Nimbus")
end
function createPlayerShipNusret()
	playerNusret = PlayerSpaceship():setTemplate("Nautilus"):setFaction("Human Navy"):setCallSign("Beowulf")
	playerNusret:setTypeName("Nusret")
	playerNusret:setHullMax(150)						--stronger hull (vs 100)
	playerNusret:setHull(150)
	playerNusret:setShieldsMax(100, 100)				--stronger shields (vs 60, 60)
	playerNusret:setShields(100, 100)
	playerNusret:setRepairCrewCount(6)					--more repair crew (vs 4)
	playerNusret.max_jump_range = 25000					--shorter than typical (vs 50)
	playerNusret.min_jump_range = 2500						--shorter than typical (vs 5)
	playerNusret:setJumpDriveRange(playerNusret.min_jump_range,playerNusret.max_jump_range)
	playerNusret:setJumpDriveCharge(playerNusret.max_jump_range)
--                 			      Arc, Dir, Range, CycleTime, Damage
	playerNusret:setBeamWeapon(0,  10, -35,	1000, 		6.0, 	6.0)	
	playerNusret:setBeamWeapon(1,  10,  35,	1000, 		6.0,    6.0)	
	playerNusret:setBeamWeapon(2,  40,	 0,	 500,		8.0,	9.0)	--additional short, slow, stronger beam
--										Arc,  Dir, Rotate speed
	playerNusret:setBeamWeaponTurret(0,	 90,  -35,			 .4)		--slow turret
	playerNusret:setBeamWeaponTurret(1,	 90,   35,			 .4)
	playerNusret:setTubeLoadTime(2,8)					--faster (vs 10)
	playerNusret:setWeaponTubeDirection(0,-60)			--front left facing (vs back)
	playerNusret:setWeaponTubeDirection(1, 60)			--front right facing (vs back)
	playerNusret:setWeaponTubeExclusiveFor(0,"Homing")	--Homing only (vs Mine)
	playerNusret:setWeaponTubeExclusiveFor(1,"Homing")	--Homing only (vs Mine)
	playerNusret:setWeaponStorageMax("Homing",8)		--more homing (vs 0)
	playerNusret:setWeaponStorage("Homing", 8)				
	playerNusret:setWeaponStorageMax("Mine",8)			--fewer mines (vs 12)
	playerNusret:setWeaponStorage("Mine", 8)				
	playerNusret:addReputationPoints(50)
	playerShipSpawned("Nusret")
end
function createPlayerShipOsprey()
	--destroyed 29Feb2020
	playerOsprey = PlayerSpaceship():setTemplate("Flavia P.Falcon"):setFaction("Human Navy"):setCallSign("Osprey")
	playerOsprey:setTypeName("Flavia 2C")
	playerOsprey:setRotationMaxSpeed(20)					--faster spin (vs 10)
	playerOsprey:setImpulseMaxSpeed(70)						--faster (vs 60)
	playerOsprey:setShieldsMax(120, 120)					--stronger shields (vs 70, 70)
	playerOsprey:setShields(120, 120)
	playerOsprey:setBeamWeapon(0, 40, -10, 1200.0, 5.5, 6.5)	--two forward (vs rear)
	playerOsprey:setBeamWeapon(1, 40,  10, 1200.0, 5.5, 6.5)	--faster (vs 6.0) and stronger (vs 6.0)
	playerOsprey:setWeaponTubeCount(3)						--more (vs 1)
	playerOsprey:setWeaponTubeDirection(0,-90)				--left facing (vs none)
	playerOsprey:setWeaponTubeDirection(1, 90)				--right facing (vs none)
	playerOsprey:setWeaponTubeDirection(2, 180)				--rear facing
	playerOsprey:setWeaponTubeExclusiveFor(0,"Homing")		
	playerOsprey:setWeaponTubeExclusiveFor(1,"Homing")
	playerOsprey:setWeaponStorageMax("EMP",2)				--more (vs 0)
	playerOsprey:setWeaponStorage("EMP", 2)				
	playerOsprey:setWeaponStorageMax("Nuke",2)				--more (vs 1)
	playerOsprey:setWeaponStorage("Nuke", 2)				
	playerOsprey:setWeaponStorageMax("Mine",2)				--more (vs 1)
	playerOsprey:setWeaponStorage("Mine", 2)				
	playerOsprey:setWeaponStorageMax("Homing",4)			--more (vs 3)
	playerOsprey:setWeaponStorage("Homing", 4)				
	playerOsprey:addReputationPoints(50)
	playerShipSpawned("Osprey")
end
function createPlayerShipOutcast()
	playerOutcast = PlayerSpaceship():setTemplate("Hathcock"):setFaction("Human Navy"):setCallSign("Outcast")
	playerOutcast:setTypeName("Scatter")
	playerOutcast:setRepairCrewCount(4)				--more repair crew (vs 2)
	playerOutcast:setImpulseMaxSpeed(65)			--faster impulse max (vs 50)
	playerOutcast.max_jump_range = 25000					--shorter than typical (vs 50)
	playerOutcast.min_jump_range = 2500						--shorter than typical (vs 5)
	playerOutcast:setJumpDriveRange(playerOutcast.min_jump_range,playerOutcast.max_jump_range)
	playerOutcast:setJumpDriveCharge(playerOutcast.max_jump_range)
	playerOutcast:setShieldsMax(100,70)				--stronger (vs 70,70)
	playerOutcast:setShields(100,70)
--                 				   Arc, Dir, Range, CycleTime, Damage
	playerOutcast:setBeamWeapon(0,  10,   0,  1200,			6,	4)	--3 front, 1 rear turret (vs 4 front)
	playerOutcast:setBeamWeapon(1,  80, -20,  1000, 		6,	4)	--shorter (vs 1400, 1200, 1000, 800)
	playerOutcast:setBeamWeapon(2,  80,  20,  1000, 		6,	4)
	playerOutcast:setBeamWeapon(3,  10, 180,  1000, 		6,	4)
--										   Arc, Dir, Rotate speed
	playerOutcast:setBeamWeaponTurret(3,	90,	180,	 .4)		--slow turret
	playerOutcast:addReputationPoints(50)
	playerShipSpawned("Outcast")
end
function createPlayerShipPhobosT2()
	playerPhobosT2 = PlayerSpaceship():setTemplate("Phobos M3P"):setFaction("Human Navy"):setCallSign("Terror")
	playerPhobosT2:setTypeName("Phobos T2")
	playerPhobosT2:setRepairCrewCount(4)					--more repair crew (vs 3)
	playerPhobosT2:setJumpDrive(true)						--jump drive (vs none)
	playerPhobosT2.max_jump_range = 25000					--shorter than typical (vs 50)
	playerPhobosT2.min_jump_range = 2000						--shorter than typical (vs 5)
	playerPhobosT2:setJumpDriveRange(playerPhobosT2.min_jump_range,playerPhobosT2.max_jump_range)
	playerPhobosT2:setJumpDriveCharge(playerPhobosT2.max_jump_range)
	playerPhobosT2:setRotationMaxSpeed(20)					--faster spin (vs 10)
	playerPhobosT2:setShieldsMax(120,80)					--stronger front, weaker rear (vs 100,100)
	playerPhobosT2:setShields(120,80)
	playerPhobosT2:setMaxEnergy(800)						--less maximum energy (vs 1000)
	playerPhobosT2:setEnergy(800)
--                 				   Arc, Dir, Range, CycleTime, Dmg
	playerPhobosT2:setBeamWeapon(0, 10, -30,  1200,         4, 6)	--split direction (30 vs 15)
	playerPhobosT2:setBeamWeapon(1, 10,  30,  1200,         4, 6)	--reduced cycle time (4 vs 8)
--										 Arc, Dir, Rotate speed
	playerPhobosT2:setBeamWeaponTurret(0, 40, -30, .2)		--slow turret beams
	playerPhobosT2:setBeamWeaponTurret(1, 40,  30, .2)
	playerPhobosT2:setWeaponTubeCount(2)					--one fewer tube (1 forward, 1 rear vs 2 forward, 1 rear)
	playerPhobosT2:setWeaponTubeDirection(0,0)				--first tube points straight forward
	playerPhobosT2:setWeaponTubeDirection(1,180)			--second tube points straight back
	playerPhobosT2:setWeaponTubeExclusiveFor(1,"Mine")
	playerPhobosT2:setWeaponStorageMax("Homing",8)			--reduce homing storage (vs 10)
	playerPhobosT2:setWeaponStorage("Homing",8)
	playerPhobosT2:setWeaponStorageMax("HVLI",16)			--reduce HVLI storage (vs 20)
	playerPhobosT2:setWeaponStorage("HVLI",16)
	playerPhobosT2:addReputationPoints(50)
	playerShipSpawned("Phobos T2")
end
function createPlayerShipQuick()
	playerQuick = PlayerSpaceship():setTemplate("ZX-Lindworm"):setFaction("Human Navy"):setCallSign("Quicksilver")
	playerQuick:setTypeName("XR-Lindworm")
	playerQuick:setRepairCrewCount(2)			--more repair crew (vs 1)
	playerQuick:setWarpDrive(true)				--warp drive (vs none)
	playerQuick:setWarpSpeed(400)
	playerQuick:setShieldsMax(90,30)			--stronger front, weaker rear (vs 40)
	playerQuick:setShields(90,30)
	playerQuick:setWeaponStorageMax("Nuke",2)	--more Nukes (vs 0)
	playerQuick:setWeaponStorage("Nuke", 2)				
	playerQuick:setWeaponStorageMax("EMP",3)	--more EMPs (vs 0)
	playerQuick:setWeaponStorage("EMP", 3)				
	playerQuick:addReputationPoints(50)
	playerShipSpawned("Quicksilver")
end
function createPlayerShipRaptor()
	playerRaptor = PlayerSpaceship():setTemplate("Player Cruiser"):setFaction("Human Navy"):setCallSign("Raptor")
	playerRaptor:setTypeName("Destroyer IV")
	playerRaptor.max_jump_range = 25000					--shorter than typical (vs 50)
	playerRaptor.min_jump_range = 2000						--shorter than typical (vs 5)
	playerRaptor:setJumpDriveRange(playerRaptor.min_jump_range,playerRaptor.max_jump_range)
	playerRaptor:setJumpDriveCharge(playerRaptor.max_jump_range)
	playerRaptor:setShieldsMax(100, 100)					--stronger shields (vs 80, 80)
	playerRaptor:setShields(100, 100)
	playerRaptor:setHullMax(100)							--weaker hull (vs 200)
	playerRaptor:setHull(100)
	playerRaptor:setBeamWeapon(0, 40, -10, 1000.0, 5, 6)	--narrower (40 vs 90), faster (5 vs 6), weaker (6 vs 10)
	playerRaptor:setBeamWeapon(1, 40,  10, 1000.0, 5, 6)
	playerRaptor:setWeaponTubeDirection(0,-60)				--left -60 (vs -5)
	playerRaptor:setWeaponTubeDirection(1, 60)				--right 60 (vs 5)
	playerRaptor:setWeaponStorageMax("Homing",6)			--less (vs 12)
	playerRaptor:setWeaponStorage("Homing", 6)				
	playerRaptor:setWeaponStorageMax("Nuke",2)				--fewer (vs 4)
	playerRaptor:setWeaponStorage("Nuke", 2)				
	playerRaptor:setWeaponStorageMax("EMP",3)				--fewer (vs 6)
	playerRaptor:setWeaponStorage("EMP", 3)				
	playerRaptor:setWeaponStorageMax("Mine",4)				--fewer (vs 8)
	playerRaptor:setWeaponStorage("Mine", 4)				
	playerRaptor:setWeaponStorageMax("HVLI",6)				--more (vs 0)
	playerRaptor:setWeaponStorage("HVLI", 6)				
	playerRaptor:addReputationPoints(50)
	playerShipSpawned("Raptor")
end
function createPlayerShipRattler()
	playerRattler = PlayerSpaceship():setTemplate("ZX-Lindworm"):setFaction("Human Navy"):setCallSign("Rattler")
	playerRattler:setTypeName("MX-Lindworm")
	playerRattler:setRepairCrewCount(2)
	playerRattler:setJumpDrive(true)
	playerRattler.max_jump_range = 20000					--shorter than typical (vs 50)
	playerRattler.min_jump_range = 3000						--shorter than typical (vs 5)
	playerRattler:setJumpDriveRange(playerRattler.min_jump_range,playerRattler.max_jump_range)
	playerRattler:setJumpDriveCharge(playerRattler.max_jump_range)
	playerRattler:setImpulseMaxSpeed(85)
	playerRattler:setBeamWeaponTurret( 0, 270, 180, 1)
	playerRattler:setShortRangeRadarRange(6000)				--longer short range sensors (vs 5000)
	playerRattler:addReputationPoints(50)
	playerShipSpawned("Rattler")
end
function createPlayerShipRogue()
	playerRogue = PlayerSpaceship():setTemplate("Maverick"):setFaction("Human Navy"):setCallSign("Rogue")
	playerRogue:setTypeName("Maverick XP")
	playerRogue:setImpulseMaxSpeed(65)						--slower impulse max (vs 80)
	playerRogue:setWarpDrive(false)							--no warp
	playerRogue:setJumpDrive(true)
	playerRogue.max_jump_range = 20000					--shorter than typical (vs 50)
	playerRogue.min_jump_range = 2000						--shorter than typical (vs 5)
	playerRogue:setJumpDriveRange(playerRogue.min_jump_range,playerRogue.max_jump_range)
	playerRogue:setJumpDriveCharge(playerRogue.max_jump_range)
--                  		    Arc, Dir,  Range, CycleTime, Dmg
	playerRogue:setBeamWeapon(0, 10,   0, 1000.0,      20.0, 20)
--									   Arc, Dir, Rotate speed
	playerRogue:setBeamWeaponTurret(0, 270,   0, .2)
	playerRogue:setBeamWeaponEnergyPerFire(0,playerRogue:getBeamWeaponEnergyPerFire(0)*6)
	playerRogue:setBeamWeaponHeatPerFire(0,playerRogue:getBeamWeaponHeatPerFire(0)*5)
	playerRogue:setBeamWeapon(1, 0, 0, 0, 0, 0)				--eliminate 5 beams
	playerRogue:setBeamWeapon(2, 0, 0, 0, 0, 0)				
	playerRogue:setBeamWeapon(3, 0, 0, 0, 0, 0)				
	playerRogue:setBeamWeapon(4, 0, 0, 0, 0, 0)	
	playerRogue:setBeamWeapon(5, 0, 0, 0, 0, 0)	
	playerRogue:setLongRangeRadarRange(25000)				--shorter longer range sensors (vs 30000)
	playerRogue.normal_long_range_radar = 25000
	playerRogue:setShortRangeRadarRange(6000)				--longer short range sensors (vs 5000)
	playerRogue:addReputationPoints(50)
	playerShipSpawned("Rogue")
end
function createPlayerShipSafari()
	playerSafari = PlayerSpaceship():setTemplate("Flavia P.Falcon"):setFaction("Human Navy"):setCallSign("Florentine")
	playerSafari:setTypeName("Safari")
	playerSafari:setShieldsMax(100, 60)					--stronger front, weaker rear (vs 70, 70)
	playerSafari:setShields(100, 60)
--                 			      Arc, Dir, Range, CycleTime, Damage
	playerSafari:setBeamWeapon(0,  10,   0,	1200, 		6.0, 	6.0)	--1 forward, 1 turret (vs 2 rear)
	playerSafari:setBeamWeapon(1,  40,   0,	 600, 		8.0,   12.0)	--shorter (vs 1200), 1 more damage (vs 6), 1 slower (vs 6)
--										Arc,  Dir, Rotate speed
	playerSafari:setBeamWeaponTurret(0,	 80,    0,			 .4)		--slow turret
	playerSafari:setWeaponTubeCount(3)									--more (vs 1)
	playerSafari:setWeaponTubeDirection(0, -90)							--left (vs rear)
	playerSafari:setWeaponTubeDirection(1,  90)							--right (vs none)
	playerSafari:setWeaponTubeDirection(2, 180)							--rear (vs none)
	playerSafari:setWeaponTubeExclusiveFor(0,"HVLI")					--HVLI only (vs any)
	playerSafari:setWeaponTubeExclusiveFor(1,"HVLI")					--HVLI only (vs none)
	playerSafari:setWeaponTubeExclusiveFor(2,"Mine")					--Mine only (vs none)
	playerSafari:setTubeSize(0,"small")									--small (vs medium)
	playerSafari:setTubeSize(1,"small")									--small (vs none)
	playerSafari:setTubeLoadTime(0,8)									--faster (vs 20)
	playerSafari:setTubeLoadTime(1,8)									--faster (vs none)
	playerSafari:setWeaponStorageMax("Homing", 0)						--less (vs 3)
	playerSafari:setWeaponStorage("Homing", 0)
	playerSafari:setWeaponStorageMax("Nuke", 0)							--less (vs 1)
	playerSafari:setWeaponStorage("Nuke", 0)
	playerSafari:setWeaponStorageMax("HVLI", 20)						--more (vs 5)
	playerSafari:setWeaponStorage("HVLI", 20)
	playerSafari:setWeaponStorageMax("Mine", 3)							--more (vs 1)
	playerSafari:setWeaponStorage("Mine", 3)
	playerSafari:addReputationPoints(50)
	playerShipSpawned("Safari")
end
function createPlayerShipSimian()
	playerSimian = PlayerSpaceship():setTemplate("Player Missile Cr."):setFaction("Human Navy"):setCallSign("Simian")
	playerSimian:setTypeName("Destroyer III")
	playerSimian:setWarpDrive(false)
	playerSimian:setJumpDrive(true)
	playerSimian.max_jump_range = 20000					--shorter than typical (vs 50)
	playerSimian.min_jump_range = 2000						--shorter than typical (vs 5)
	playerSimian:setJumpDriveRange(playerSimian.min_jump_range,playerSimian.max_jump_range)
	playerSimian:setJumpDriveCharge(playerSimian.max_jump_range)
	playerSimian:setHullMax(100)									--weaker hull (vs 200)
	playerSimian:setHull(100)
--                 				 Arc, Dir, Range, CycleTime, Damage
	playerSimian:setBeamWeapon(0,  8,   0, 900.0,         5, 6)		--turreted beam (vs none)
--									    Arc, Dir, Rotate speed
	playerSimian:setBeamWeaponTurret(0, 270,   0, .4)				--slow turret
	playerSimian:setWeaponTubeCount(5)								--fewer (vs 7)
	playerSimian:setWeaponTubeDirection(2, -90)						--left (vs right)
	playerSimian:setWeaponTubeDirection(4, 180)						--rear (vs left)
	playerSimian:setWeaponTubeExclusiveFor(4,"Mine")
	playerSimian:setWeaponStorageMax("Homing",10)					--less (vs 30)
	playerSimian:setWeaponStorage("Homing", 10)				
	playerSimian:setWeaponStorageMax("Nuke",4)						--less (vs 8)
	playerSimian:setWeaponStorage("Nuke", 4)				
	playerSimian:setWeaponStorageMax("EMP",5)						--less (vs 10)
	playerSimian:setWeaponStorage("EMP", 5)				
	playerSimian:setWeaponStorageMax("Mine",6)						--less (vs 12)
	playerSimian:setWeaponStorage("Mine", 6)				
	playerSimian:setWeaponStorageMax("HVLI",10)						--more (vs 0)
	playerSimian:setWeaponStorage("HVLI", 10)				
	playerSimian:setLongRangeRadarRange(20000)				--shorter longer range sensors (vs 30000)
	playerSimian:addReputationPoints(50)
	playerShipSpawned("Simian")
end
function createplayerShipSneak()
	playerSneak = PlayerSpaceship():setTemplate("Repulse"):setTypeName("Skray"):setFaction("Human Navy"):setCallSign("5N3AK-E")
	playerSneak:setWeaponStorageMax("Homing", 10)
	playerSneak:setWeaponStorage("Homing", 10)
	playerSneak:setWeaponStorageMax("HVLI", 10)
	playerSneak:setWeaponStorage("HVLI", 10)
--                 				 Arc, Dir, Range, CycleTime, Damage
	playerSneak:setBeamWeapon(0,  10, -70,	1200, 		6.0, 	5.0)
	playerSneak:setBeamWeapon(1,  10,  70,	1200, 		6.0,	5.0)
--										Arc,  Dir, Rotate speed
	playerSneak:setBeamWeaponTurret(0,	 30,  -70,			5)
	playerSneak:setBeamWeaponTurret(1,	 30,   70,			5)
	playerSneak:setShortRangeRadarRange(7500)
	playerSneak:addReputationPoints(50)
	playerShipSpawned("Skray")
end
function createPlayerShipSparrow()
	playerSparrow = PlayerSpaceship():setTemplate("Player Fighter"):setFaction("Human Navy"):setCallSign("Sparrow")
	playerSparrow:setTypeName("Vermin")
	playerSparrow:setRepairCrewCount(4)						--more repair crew (vs 3)
	playerSparrow:setMaxEnergy(500)							--more maximum energy (vs 400)
	playerSparrow:setEnergy(500)							
	playerSparrow:setWarpDrive(true)						--warp drive (vs none)
	playerSparrow:setWarpSpeed(400)
	playerSparrow:setShieldsMax(100,60)						--stronger shields (vs 40)
	playerSparrow:setShields(100,60)
	playerSparrow:setBeamWeapon(0, 12,   0, 1000, 6, 4)		--3 beams (vs 2)
	playerSparrow:setBeamWeapon(1, 40, -10,  800, 6, 6)	
	playerSparrow:setBeamWeapon(2, 40,  10,  800, 6, 6)	
	playerSparrow:setWeaponTubeDirection(0,180)				--tube points backwards (vs forward)
	playerSparrow:setWeaponTubeExclusiveFor(0,"Mine")		--and only lays mines (vs HVLI)
	playerSparrow:setWeaponStorageMax("HVLI",0)				--fewer HVLIs (vs 4)
	playerSparrow:setWeaponStorage("HVLI",0)
	playerSparrow:setWeaponStorageMax("Mine",4)				--more Mines (vs 0)
	playerSparrow:setWeaponStorage("Mine",4)
	playerSparrow:addReputationPoints(50)
	playerShipSpawned("Sparrow")
end
function createPlayerShipSpyder()
	--experimental
	playerSpyder = PlayerSpaceship():setTemplate("Atlantis"):setFaction("Human Navy"):setCallSign("Spyder")
	playerSpyder:setTypeName("Atlantis II")
	playerSpyder:setRepairCrewCount(4)					--more repair crew (vs 3)
	playerSpyder:setImpulseMaxSpeed(80)					--slower impulse max (vs 90)
	playerSpyder:setWeaponTubeCount(6)					--one more tube
	playerSpyder:setWeaponTubeDirection(5,0)			--front facing
	playerSpyder:weaponTubeDisallowMissle(5,"Mine")		--no Mine
	playerSpyder:weaponTubeDisallowMissle(5,"EMP")		--no EMP
	playerSpyder:weaponTubeDisallowMissle(5,"Nuke")		--no Nuke
	playerSpyder:setWeaponTubeDirection(0,-60)			--left front facing
	playerSpyder:setWeaponTubeDirection(1,-120)			--left rear facing
	playerSpyder:setWeaponTubeDirection(2,60)			--right front facing
	playerSpyder:setWeaponTubeDirection(3,120)			--right rear facing
	playerSpyder:addReputationPoints(50)
	playerShipSpawned("Spyder")
end
function createPlayerShipStick()
	playerStick = PlayerSpaceship():setTemplate("Hathcock"):setFaction("Human Navy"):setCallSign("Stick")
	playerStick:setTypeName("Surkov")
	playerStick:setRepairCrewCount(3)	--more repair crew (vs 2)
	playerStick:setImpulseMaxSpeed(60)	--faster impulse max (vs 50)
	playerStick:setJumpDrive(false)		--no jump
	playerStick:setWarpDrive(true)		--add warp
	playerStick:setWarpSpeed(500)
	playerStick:setShieldsMax(100,70)	--stronger (vs 70,70)
	playerStick:setShields(100,70)
	playerStick:setWeaponTubeCount(3)	--one more tube for mines, no other splash ordnance
	playerStick:setWeaponTubeDirection(0, -90)
	playerStick:weaponTubeDisallowMissle(0,"Mine")
	playerStick:weaponTubeDisallowMissle(0,"Nuke")
	playerStick:weaponTubeDisallowMissle(0,"EMP")
	playerStick:setWeaponStorageMax("Mine",3)		--more (vs 0)
	playerStick:setWeaponStorage("Mine",3)
	playerStick:setWeaponStorageMax("Nuke",0)		--less
	playerStick:setWeaponStorage("Nuke",0)
	playerStick:setWeaponStorageMax("EMP",0)		--less
	playerStick:setWeaponStorage("EMP",0)
	playerStick:setWeaponTubeDirection(1, 90)
	playerStick:weaponTubeDisallowMissle(1,"Mine")
	playerStick:weaponTubeDisallowMissle(1,"Nuke")
	playerStick:weaponTubeDisallowMissle(1,"EMP")
	playerStick:setWeaponTubeDirection(2,180)
	playerStick:setWeaponTubeExclusiveFor(2,"Mine")
	playerStick:addReputationPoints(50)
	playerShipSpawned("Stick")
end
function createPlayerShipSting()
	--sent to Kraylor war front. May return later
	playerSting = PlayerSpaceship():setTemplate("Hathcock"):setFaction("Human Navy"):setCallSign("Sting")
	playerSting:setTypeName("Surkov")
	playerSting:setRepairCrewCount(4)	--more repair crew (vs 2)
	playerSting:setImpulseMaxSpeed(60)	--faster impulse max (vs 50)
	playerSting:setRotationMaxSpeed(20)					--faster spin (vs 15)
	playerSting:setJumpDrive(false)		--no jump
	playerSting:setWarpDrive(true)		--add warp
	playerSting:setWarpSpeed(400)
	playerSting:setWeaponTubeCount(3)	--one more tube for mines, no other splash ordnance
	playerSting:setWeaponTubeDirection(0, -90)
	playerSting:weaponTubeDisallowMissle(0,"Mine")
	playerSting:weaponTubeDisallowMissle(0,"Nuke")
	playerSting:weaponTubeDisallowMissle(0,"EMP")
	playerSting:setWeaponStorageMax("Mine",3)
	playerSting:setWeaponStorage("Mine",3)
	playerSting:setWeaponStorageMax("Nuke",0)
	playerSting:setWeaponStorage("Nuke",0)
	playerSting:setWeaponStorageMax("EMP",0)
	playerSting:setWeaponStorage("EMP",0)
	playerSting:setWeaponTubeDirection(1, 90)
	playerSting:weaponTubeDisallowMissle(1,"Mine")
	playerSting:weaponTubeDisallowMissle(1,"Nuke")
	playerSting:weaponTubeDisallowMissle(1,"EMP")
	playerSting:setWeaponTubeDirection(2,180)
	playerSting:setWeaponTubeExclusiveFor(2,"Mine")
	playerSting:addReputationPoints(50)
	playerShipSpawned("Sting")
end
function createPlayerShipThelonius()
	playerThelonius = PlayerSpaceship():setTemplate("Crucible"):setFaction("Human Navy"):setCallSign("Thelonius")
	playerThelonius:setTypeName("Crab")
	playerThelonius:setWarpSpeed(450)						--slower (vs 750)
--                 				 	Arc, Dir,  Range, CycleTime, Damage
	playerThelonius:setBeamWeapon(0, 10, 165,	1000, 		6.0, 	6.0)	--turreted, stronger (vs fixed, 5 Dmg)
	playerThelonius:setBeamWeapon(1, 10, 195,	1000, 		6.0,	6.0)	--rear facing
--										   Arc, Dir, Rotate speed
	playerThelonius:setBeamWeaponTurret(0,	70,	165,		 .5)		--slow turret
	playerThelonius:setBeamWeaponTurret(1,	70,	195,		 .5)		--slow turret
	playerThelonius:setWeaponTubeCount(5)					--fewer (vs 6), no mine tube or mines
	playerThelonius:setTubeSize(0,"large")					--large (vs small)
	playerThelonius:setTubeSize(1,"small")					--small (vs normal)
	playerThelonius:setWeaponTubeDirection(1,-20)			--angled (vs zero degrees)
	playerThelonius:setWeaponTubeExclusiveFor(1,"Homing")	--homing only (vs HVLI)
	playerThelonius:setTubeSize(2,"small")					--medium (vs large)
	playerThelonius:setWeaponTubeDirection(2, 20)			--angled (vs zero degrees)
	playerThelonius:setWeaponTubeExclusiveFor(2,"Homing")	--homing only (vs HVLI)
	playerThelonius:setWeaponStorageMax("Homing",16)		--more (vs 8)
	playerThelonius:setWeaponStorage("Homing", 16)				
	playerThelonius:setWeaponStorageMax("EMP",3)			--fewer (vs 6)
	playerThelonius:setWeaponStorage("EMP", 3)				
	playerThelonius:setWeaponStorageMax("Nuke",2)			--fewer (vs 4)
	playerThelonius:setWeaponStorage("Nuke", 2)				
	playerThelonius:setWeaponStorageMax("Mine",0)			--fewer (vs 6)
	playerThelonius:setWeaponStorage("Mine", 0)				
	playerThelonius:setWeaponStorageMax("HVLI",10)			--fewer (vs 24)
	playerThelonius:setWeaponStorage("HVLI", 10)				
	playerThelonius:addReputationPoints(50)
	playerShipSpawned("Thelonius")
end
function createPlayerShipThunderbird()
	--destroyed 29Feb2020
	playerThunderbird = PlayerSpaceship():setTemplate("Player Cruiser"):setFaction("Human Navy"):setCallSign("Thunderbird")
	playerThunderbird:setTypeName("Destroyer IV")
	playerThunderbird.max_jump_range = 28000					--shorter than typical (vs 50)
	playerThunderbird.min_jump_range = 3000						--shorter than typical (vs 5)
	playerThunderbird:setJumpDriveRange(playerThunderbird.min_jump_range,playerThunderbird.max_jump_range)
	playerThunderbird:setJumpDriveCharge(playerThunderbird.max_jump_range)
	playerThunderbird:setShieldsMax(100, 100)					--stronger shields (vs 80, 80)
	playerThunderbird:setShields(100, 100)
	playerThunderbird:setHullMax(100)							--weaker hull (vs 200)
	playerThunderbird:setHull(100)
	playerThunderbird:setBeamWeapon(0, 40, -10, 1000.0, 5, 6)	--narrower (40 vs 90), faster (5 vs 6), weaker (6 vs 10)
	playerThunderbird:setBeamWeapon(1, 40,  10, 1000.0, 5, 6)
	playerThunderbird:setWeaponTubeDirection(0,-60)				--left -60 (vs -5)
	playerThunderbird:setWeaponTubeDirection(1, 60)				--right 60 (vs 5)
	playerThunderbird:setWeaponStorageMax("Homing",6)			--less (vs 12)
	playerThunderbird:setWeaponStorage("Homing", 6)				
	playerThunderbird:setWeaponStorageMax("Nuke",2)				--fewer (vs 4)
	playerThunderbird:setWeaponStorage("Nuke", 2)				
	playerThunderbird:setWeaponStorageMax("EMP",3)				--fewer (vs 6)
	playerThunderbird:setWeaponStorage("EMP", 3)				
	playerThunderbird:setWeaponStorageMax("Mine",4)				--fewer (vs 8)
	playerThunderbird:setWeaponStorage("Mine", 4)				
	playerThunderbird:setWeaponStorageMax("HVLI",6)				--more (vs 0)
	playerThunderbird:setWeaponStorage("HVLI", 6)				
	playerThunderbird:addReputationPoints(50)
	playerShipSpawned("Thunderbird")
end
function createPlayerShipVision()
	playerVision = PlayerSpaceship():setTemplate("Flavia P.Falcon"):setFaction("Human Navy"):setCallSign("Vision")
	playerVision:setTypeName("Era")
	playerVision:setRotationMaxSpeed(15)									--faster spin (vs 10)
--                 				 Arc, Dir, Range, CycleTime, Damage
	playerVision:setBeamWeapon(0,  10,   0,	1200, 		6.0, 	6.0)	--1 turret, 1 rear (vs 2 rear)
	playerVision:setBeamWeapon(1,  80, 180,	1200, 		6.0,	6.0)
--										Arc,  Dir, Rotate speed
	playerVision:setBeamWeaponTurret(0,	300,    0,			 .5)		--slow turret
	playerVision:setShieldsMax(70, 100)									--stronger rear shields (vs 70, 70)
	playerVision:setShields(70, 100)
	playerVision:setLongRangeRadarRange(50000)							--longer long range sensors (vs 30000)
	playerVision.normal_long_range_radar = 50000
	playerVision:addReputationPoints(50)
	playerShipSpawned("Vision")
end
function createPlayerShipWiggy()
	playerWiggy = PlayerSpaceship():setTemplate("Flavia P.Falcon"):setFaction("Human Navy"):setCallSign("Wiggy")
	playerWiggy:setTypeName("Gull")
	playerWiggy:setRotationMaxSpeed(12)									--faster spin (vs 10)
--                 				 Arc, Dir, Range, CycleTime, Damage
	playerWiggy:setBeamWeapon(0,  10,   0,	1100, 		6.0, 	6.0)	--1 turret, 1 rear (vs 2 rear)
	playerWiggy:setBeamWeapon(1,  80, 180,	1100, 		6.0,	6.0)	--shorter (vs 1200)
--										Arc,  Dir, Rotate speed
	playerWiggy:setBeamWeaponTurret(0,	300,    0,			 .5)		--slow turret
	playerWiggy:setWarpDrive(false)						--no warp drive (vs warp)
	playerWiggy:setJumpDrive(true)						--jump drive (vs warp)
	playerWiggy.max_jump_range = 30000					--shorter than typical (vs 50)
	playerWiggy.min_jump_range = 3000						--shorter than typical (vs 5)
	playerWiggy:setJumpDriveRange(playerWiggy.min_jump_range,playerWiggy.max_jump_range)
	playerWiggy:setJumpDriveCharge(playerWiggy.max_jump_range)
	playerWiggy:setHullMax(120)							--stronger hull (vs 100)
	playerWiggy:setHull(120)
	playerWiggy:setShieldsMax(70, 120)					--stronger rear shields (vs 70, 70)
	playerWiggy:setShields(70, 120)
	playerWiggy:setLongRangeRadarRange(40000)			--longer long range sensors (vs 30000)
	playerWiggy.normal_long_range_radar = 40000
	playerWiggy:addReputationPoints(50)
	playerShipSpawned("Wiggy")
end
function createPlayerShipWombat()
	playerWombat = PlayerSpaceship():setTemplate("ZX-Lindworm"):setFaction("Human Navy"):setCallSign("Farrah")
	playerWombat:setTypeName("Wombat")
	playerWombat:setHullMax(100)							--stronger hull (vs 75)
	playerWombat:setHull(100)
	playerWombat:setShieldsMax(80, 80)						--stronger shields (vs 40)
	playerWombat:setShields(80, 80)
	playerWombat:setRepairCrewCount(4)						--more repair crew (vs 1)
	playerWombat:setWarpDrive(true)							--add warp (vs none)
	playerWombat:setWarpSpeed(400)
	playerWombat:setBeamWeapon(0, 10, 0, 900.0, 4.0, 3)		--extra beam (vs 1@ 700 6.0, 2)
	playerWombat:setBeamWeapon(1, 10, 0, 900.0, 4.0, 3)	
	playerWombat:setBeamWeaponTurret( 0, 80, -20, .3)
	playerWombat:setBeamWeaponTurret( 1, 80,  20, .3)
	playerWombat:setWeaponTubeCount(5)						--more (vs 3)
	playerWombat:setWeaponTubeDirection(0, 180)				
	playerWombat:setWeaponTubeDirection(1, 180)				
	playerWombat:setWeaponTubeDirection(2, 180)				
	playerWombat:setWeaponTubeDirection(3, 180)
	playerWombat:setWeaponTubeDirection(4, 180)
	playerWombat:setWeaponTubeExclusiveFor(0,"HVLI")
	playerWombat:setWeaponTubeExclusiveFor(1,"HVLI")
	playerWombat:weaponTubeAllowMissle(1,"Homing")
	playerWombat:setTubeSize(2,"large")						--large (vs small)
	playerWombat:setWeaponTubeExclusiveFor(2,"HVLI")
	playerWombat:weaponTubeAllowMissle(2,"Homing")
	playerWombat:setWeaponTubeExclusiveFor(3,"HVLI")
	playerWombat:weaponTubeAllowMissle(3,"EMP")
	playerWombat:weaponTubeAllowMissle(3,"Nuke")
	playerWombat:setWeaponTubeExclusiveFor(4,"Mine")
	playerWombat:setWeaponStorageMax("Mine",2)				--more (vs 0)
	playerWombat:setWeaponStorage("Mine",   2)				
	playerWombat:setWeaponStorageMax("EMP",2)				--more (vs 0)
	playerWombat:setWeaponStorage("EMP",   2)				
	playerWombat:setWeaponStorageMax("Nuke",1)				--more (vs 0)
	playerWombat:setWeaponStorage("Nuke",   1)				
	playerWombat:setWeaponStorageMax("Homing",8)			--more (vs 3)
	playerWombat:setWeaponStorage("Homing",   8)				
	playerShipSpawned("Wombat")
end
function createPlayerShipYorik()
	playerYorik = PlayerSpaceship():setTemplate("Repulse"):setFaction("Human Navy"):setCallSign("Yorik")
	playerYorik:setTypeName("Rook")
	playerYorik.max_jump_range = 30000					--shorter than typical (vs 50)
	playerYorik.min_jump_range = 3000						--shorter than typical (vs 5)
	playerYorik:setJumpDriveRange(playerYorik.min_jump_range,playerYorik.max_jump_range)
	playerYorik:setJumpDriveCharge(playerYorik.max_jump_range)
	playerYorik:setImpulseMaxSpeed(75)					--faster impulse max (vs 55)
	playerYorik:setRotationMaxSpeed(8)					--slower spin (vs 9)
	playerYorik:setHullMax(200)							--stronger hull (vs 120)
	playerYorik:setHull(200)
	playerYorik:setShieldsMax(200, 100)					--stronger shields (vs 80, 80)
	playerYorik:setShields(200, 100)
--                 				 Arc, Dir, Range, CycleTime, Damage
	playerYorik:setBeamWeapon(0,  10, -25,	1000, 		6.0, 	4.0)	--front facing (vs left/right with overlap in front and back
	playerYorik:setBeamWeapon(1,  10,  25,	1000, 		6.0,	4.0)	--shorter (vs 1200), weaker (vs 5)
--										Arc,  Dir, Rotate speed
	playerYorik:setBeamWeaponTurret(0,	 60,  -25,			.15)		--slow turret, narrower arc (vs 200)
	playerYorik:setBeamWeaponTurret(1,	 60,   25,			.15)		--slow turret, narrower arc (vs 200)
	playerYorik:setWeaponTubeCount(3)					--more (vs 2)
	playerYorik:setWeaponTubeDirection(0,-90)			--first tube points left (vs forward)
	playerYorik:setWeaponTubeDirection(1, 90)			--second tube points right (vs rear)
	playerYorik:setWeaponTubeDirection(2,180)			--third tube points rear (vs none)
	playerYorik:weaponTubeDisallowMissle(0,"Mine")		--no Mine (vs any)
	playerYorik:weaponTubeDisallowMissle(1,"Mine")		--no Mine (vs any)
	playerYorik:setWeaponTubeExclusiveFor(2,"Mine")		--only mine
	playerYorik:setWeaponStorageMax("Homing", 8)		--more (vs 4)
	playerYorik:setWeaponStorage("Homing", 8)				
	playerYorik:setWeaponStorageMax("EMP", 6)			--more (vs 0)
	playerYorik:setWeaponStorage("EMP", 6)				
	playerYorik:setWeaponStorageMax("Nuke", 3)			--more (vs 0)
	playerYorik:setWeaponStorage("Nuke", 3)				
	playerYorik:setWeaponStorageMax("Mine", 5)			--more (vs 0)
	playerYorik:setWeaponStorage("Mine", 5)				
end
function playerShipSpawned(shipName)
	for shipNum = 1, #playerShipInfo do
		if playerShipInfo[shipNum][1] == shipName then
			if playerShipInfo[shipNum][2] == "active" then
				playerShipInfo[shipNum][2] = "inactive"
				activePlayerShip()
				return
			else
				inactivePlayerShip()
				return
			end
		end
	end
end
-----------------------------------------
--	Initial Set Up > Zones > Add Zone  --
-----------------------------------------
-- Button Text	   FD*	Related Function(s)
-- -MAIN			F	initialGMFunctions
-- -SETUP			F	initialSetUp
-- -ZONES FROM ADD	F	changeZones
-- +RED				D	setZoneColor
-- +VIA OBJECT		F	addZoneByObject
-- +VIA CLICK		F	addZoneByClick
function addZone()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Zones from add",changeZones)
	addGMFunction(string.format("+%s",zone_color),setZoneColor)
	addGMFunction("+Via Object",addZoneByObject)
	addGMFunction("+Via Click",addZoneByClick)
end
-------------------------------------------------
--	Initial Set Up > Zones > Add Zone > Color  --
-------------------------------------------------
-- Button Text	   FD*	Related Function(s)
-- -ADD ZONE		F	addZone
-- List of colors for zones, selected has asterisk
function setZoneColor()
	clearGMFunctions()
	addGMFunction("-Add Zone",addZone)
	for color, rgb in pairs(zone_color_list) do
		local button_label = color
		if color == zone_color then
			button_label = button_label .. "*"
		end
		addGMFunction(button_label,function()
			zone_color = color
			setZoneColor()
		end)
	end
end
------------------------------------------------------
--	Initial Set Up > Zones > Add Zone > Via Object  --
------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN FRM VIA OBJ	F	initialGMFunctions
-- -SETUP				F	initialSetUp
-- -ZONES				F	changeZones
-- -ADD ZONE			F	addZone
-- SECTOR				F	inline
-- SMALL SQUARE			F	inline
function addZoneByObject()
	clearGMFunctions()
	addGMFunction("-Main Frm Via Obj",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Zones",changeZones)
	addGMFunction("-Add Zone",addZone)
	addGMFunction("Sector", function()
		local object_list = getGMSelection()
		if #object_list ~= nil and #object_list == 1 then
			local ox, oy = object_list[1]:getPosition()
			ox = math.floor(ox / 20000)
			ox = ox * 20000
			oy = math.floor(oy / 20000)
			oy = oy * 20000
			local zone = Zone():setPoints(ox,oy,ox+20000,oy,ox+20000,oy+20000,ox,oy+20000)
			--zone:setColor(64,64,64)
			zone:setColor(zone_color_list[zone_color].r,zone_color_list[zone_color].g,zone_color_list[zone_color].b)
			zone.name = object_list[1]:getSectorName()
			if zone_list == nil then
				zone_list = {}
			end
			table.insert(zone_list,zone)
		else
			addGMMessage("You must select an object in the sector where you want the zone to appear. No action taken")
		end
	end)
	addGMFunction("Small Square",function()
		local object_list = getGMSelection()
		if #object_list ~= nil and #object_list == 1 then
			local ox, oy = object_list[1]:getPosition()
			local zone = Zone():setPoints(ox+500,oy+500,ox-500,oy+500,ox-500,oy-500,ox+500,oy-500)
			--zone:setColor(255,255,128)
			zone:setColor(zone_color_list[zone_color].r,zone_color_list[zone_color].g,zone_color_list[zone_color].b)
			if square_zone_char_val == nil then
				square_zone_char_val = 65
			end
			zone.name = string.char(square_zone_char_val)
			square_zone_char_val = square_zone_char_val + 1
			zone.sector_name = object_list[1]:getSectorName()
			if zone_list == nil then
				zone_list = {}
			end
			table.insert(zone_list,zone)
			addGMMessage(string.format("Added small square zone %s in %s",zone.name,zone.sector_name))
		else
			addGMMessage("You must select an object in the sector where you want the zone to appear. No action taken")
		end
	end)
end
-----------------------------------------------------
--	Initial Set Up > Zones > Add Zone > Via Click  --
-----------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN FRM VIA CLICK	F	initialGMFunctions
-- -SETUP				F	initialSetUp
-- -ZONES				F	changeZones
-- -ADD ZONE			F	addZone
-- +RECTANGLE W5 X H5	D	setZoneRectangleSize
-- +POLYGON 3			D	setZonePolygonPointMax
-- PUT RECT ZONE		D	putRectangleZone
function addZoneByClick()
	clearGMFunctions()
	addGMFunction("-Main Frm Via Click",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Zones",changeZones)
	addGMFunction("-Add Zone",addZone)
	local button_label = string.format("+Rectangle W%i x H%i",zone_rectangle_width,zone_rectangle_height)
	if zone_click_type == "rectangle" then
		button_label = button_label .. "*"
	end
	addGMFunction(button_label,setZoneRectangleSize)
	button_label = string.format("+Polygon %i",zone_point_max)
	if zone_click_type == "polygon" then
		button_label = button_label .. "*"
	end
	addGMFunction(button_label,setZonePolygonPointMax)
	if zone_click_type == "rectangle" then
		if gm_click_mode == "zone rectangle" then
			addGMFunction(">Put Rect Zone<",putRectangleZone)
		else
			addGMFunction("Put Rect Zone",putRectangleZone)
		end
	end
	if zone_click_type == "polygon" then
		if gm_click_mode == "zone polygon" then
			if zone_point_count == 0 then
				addGMFunction(">Set First Point<",putPolygonZone)
			elseif zone_point_count == (zone_point_max - 1) then
				addGMFunction(">Set Last Point<",putPolygonZone)
			else
				addGMFunction(string.format(">Set Point %i<",zone_point_count + 1),putPolygonZone)
			end
		else
			addGMFunction("Set First Point",putPolygonZone)
		end
	end
end
function putRectangleZone()
	if gm_click_mode == "zone rectangle" then
		gm_click_mode = nil
		onGMClick(nil)
	else
		local prev_mode = gm_click_mode
		gm_click_mode = "zone rectangle"
		onGMClick(gmClickZoneRectangle)
		if prev_mode ~= nil then
			addGMMessage(string.format("Cancelled current GM Click mode\n   %s\nIn favor of\n   zone rectangle\nGM click mode.",prev_mode))
		end
	end
	addZoneByClick()
end
function gmClickZoneRectangle(x,y)
	local half_width = zone_rectangle_width*1000/2
	local half_height = zone_rectangle_height*1000/2
	local zone = Zone():setPoints(x - half_width, y - half_height, x + half_width, y - half_height, x + half_width, y + half_height, x - half_width, y + half_height)
	zone:setColor(zone_color_list[zone_color].r,zone_color_list[zone_color].g,zone_color_list[zone_color].b)
	if rectangle_zone_char_val == nil then
		rectangle_zone_char_val = 65
	end
	zone.name = string.format("Rect %s",string.char(rectangle_zone_char_val))
	rectangle_zone_char_val = rectangle_zone_char_val + 1
	zone.sector_name = zone:getSectorName()
	if zone_list == nil then
		zone_list = {}
	end
	table.insert(zone_list,zone)
	addGMMessage(string.format("Added rectangle zone %s in %s",zone.name,zone.sector_name))
end
function putPolygonZone()
	if gm_click_mode == "zone polygon" then
		gm_click_mode = nil
		onGMClick(nil)
		zone_point_count = 0	
	else
		local prev_mode = gm_click_mode
		gm_click_mode = "zone polygon"
		onGMClick(gmClickZonePolygon)
		if prev_mode ~= nil then
			addGMMessage(string.format("Cancelled current GM Click mode\n   %s\nIn favor of\n   zone polygon\nGM click mode.",prev_mode))
		end
	end
	addZoneByClick()
end
function gmClickZonePolygon(x,y)
	if zone_polygon_point_list_x == nil then
		zone_polygon_point_list_x = {}
		zone_polygon_point_list_y = {}
	end
	table.insert(zone_polygon_point_list_x,x)
	table.insert(zone_polygon_point_list_y,y)
	zone_point_count = zone_point_count + 1
	if zone_point_count == zone_point_max then
		local zone = Zone()
		if zone_point_count == 3 then
			zone:setPoints(
				zone_polygon_point_list_x[1],zone_polygon_point_list_y[1],
				zone_polygon_point_list_x[2],zone_polygon_point_list_y[2],
				zone_polygon_point_list_x[3],zone_polygon_point_list_y[3]
			)
		elseif zone_point_count == 4 then
			zone:setPoints(
				zone_polygon_point_list_x[1],zone_polygon_point_list_y[1],
				zone_polygon_point_list_x[2],zone_polygon_point_list_y[2],
				zone_polygon_point_list_x[3],zone_polygon_point_list_y[3],
				zone_polygon_point_list_x[4],zone_polygon_point_list_y[4]
			)
		elseif zone_point_count == 5 then
			zone:setPoints(
				zone_polygon_point_list_x[1],zone_polygon_point_list_y[1],
				zone_polygon_point_list_x[2],zone_polygon_point_list_y[2],
				zone_polygon_point_list_x[3],zone_polygon_point_list_y[3],
				zone_polygon_point_list_x[4],zone_polygon_point_list_y[4],
				zone_polygon_point_list_x[5],zone_polygon_point_list_y[5]
			)
		elseif zone_point_count == 6 then
			zone:setPoints(
				zone_polygon_point_list_x[1],zone_polygon_point_list_y[1],
				zone_polygon_point_list_x[2],zone_polygon_point_list_y[2],
				zone_polygon_point_list_x[3],zone_polygon_point_list_y[3],
				zone_polygon_point_list_x[4],zone_polygon_point_list_y[4],
				zone_polygon_point_list_x[5],zone_polygon_point_list_y[5],
				zone_polygon_point_list_x[6],zone_polygon_point_list_y[6]
			)
		elseif zone_point_count == 7 then
			zone:setPoints(
				zone_polygon_point_list_x[1],zone_polygon_point_list_y[1],
				zone_polygon_point_list_x[2],zone_polygon_point_list_y[2],
				zone_polygon_point_list_x[3],zone_polygon_point_list_y[3],
				zone_polygon_point_list_x[4],zone_polygon_point_list_y[4],
				zone_polygon_point_list_x[5],zone_polygon_point_list_y[5],
				zone_polygon_point_list_x[6],zone_polygon_point_list_y[6],
				zone_polygon_point_list_x[7],zone_polygon_point_list_y[7]
			)
		elseif zone_point_count == 8 then
			zone:setPoints(
				zone_polygon_point_list_x[1],zone_polygon_point_list_y[1],
				zone_polygon_point_list_x[2],zone_polygon_point_list_y[2],
				zone_polygon_point_list_x[3],zone_polygon_point_list_y[3],
				zone_polygon_point_list_x[4],zone_polygon_point_list_y[4],
				zone_polygon_point_list_x[5],zone_polygon_point_list_y[5],
				zone_polygon_point_list_x[6],zone_polygon_point_list_y[6],
				zone_polygon_point_list_x[7],zone_polygon_point_list_y[7],
				zone_polygon_point_list_x[8],zone_polygon_point_list_y[8]
			)
		end
		zone:setColor(zone_color_list[zone_color].r,zone_color_list[zone_color].g,zone_color_list[zone_color].b)
		if polygon_zone_char_val == nil then
			polygon_zone_char_val = 65
		end
		zone.name = string.format("Poly %s %i",string.char(polygon_zone_char_val),zone_point_count)
		polygon_zone_char_val = polygon_zone_char_val + 1
		local mid_x = 0
		for i=1,#zone_polygon_point_list_x do
			mid_x = mid_x + zone_polygon_point_list_x[i]
		end
		mid_x = mid_x/#zone_polygon_point_list_x
		local mid_y = 0
		for i=1,#zone_polygon_point_list_y do
			mid_y = mid_y + zone_polygon_point_list_y[i]
		end
		mid_y = mid_y/#zone_polygon_point_list_y
		local reference_asteroid = VisualAsteroid():setPosition(mid_x,mid_y)
		zone.sector_name = reference_asteroid:getSectorName()
		reference_asteroid:destroy()
		if zone_list == nil then
			zone_list = {}
		end
		table.insert(zone_list,zone)
		zone_point_count = 0
		zone_polygon_point_list_x = nil
		zone_polygon_point_list_y = nil
		addGMMessage(string.format("Added polygon zone %s in %s",zone.name,zone.sector_name))
	end
	addZoneByClick()
end
-----------------------------------------------------------------
--	Initial Set Up > Zones > Add Zone > Via Click > Rectangle  --
-----------------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN FRM RECT SIZE	F	initialGMFunctions
-- -SETUP				F	initialSetUp
-- -ZONES				F	changeZones
-- -ADD ZONE			F	addZone
-- -VIA CLICK			F	addZoneByClick
-- WIDER 5 -> 6			D	inline
-- NARROWER 5 -> 4		D	inline
-- TALLER 5 -> 6		D	inline
-- SHORTER 5 -> 4		D	inline
function setZoneRectangleSize()
	clearGMFunctions()
	addGMFunction("-Main Frm Rect Size",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Zones",changeZones)
	addGMFunction("-Add Zone",addZone)
	addGMFunction("-Via Click",addZoneByClick)
	zone_click_type = "rectangle"
	if zone_rectangle_width < 9 then
		addGMFunction(string.format("Wider %i -> %i",zone_rectangle_width,zone_rectangle_width + 1),function()
			zone_rectangle_width = zone_rectangle_width + 1
			setZoneRectangleSize()
		end)
	end
	if zone_rectangle_width > 1 then
		addGMFunction(string.format("Narrower %i -> %i",zone_rectangle_width,zone_rectangle_width - 1),function()
			zone_rectangle_width = zone_rectangle_width - 1
			setZoneRectangleSize()
		end)
	end
	if zone_rectangle_height < 9 then
		addGMFunction(string.format("Taller %i -> %i",zone_rectangle_height,zone_rectangle_height + 1),function()
			zone_rectangle_height = zone_rectangle_height + 1
			setZoneRectangleSize()
		end)
	end
	if zone_rectangle_height > 1 then
		addGMFunction(string.format("Shorter %i -> %i",zone_rectangle_height,zone_rectangle_height - 1),function()
			zone_rectangle_height = zone_rectangle_height - 1
			setZoneRectangleSize()
		end)
	end
end
---------------------------------------------------------------
--	Initial Set Up > Zones > Add Zone > Via Click > Polygon  --
---------------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN FRM POLY MAX	F	initialGMFunctions
-- -SETUP				F	initialSetUp
-- -ZONES				F	changeZones
-- -ADD ZONE			F	addZone
-- -VIA CLICK			F	addZoneByClick
-- MORE 3 -> 4			D	inline
function setZonePolygonPointMax()
	clearGMFunctions()
	addGMFunction("-Main Frm Poly Max",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Zones",changeZones)
	addGMFunction("-Add Zone",addZone)
	addGMFunction("-Via Click",addZoneByClick)
	zone_click_type = "polygon"
	if zone_point_max < 8 then
		addGMFunction(string.format("More %i -> %i",zone_point_max,zone_point_max + 1),function()
			zone_point_max = zone_point_max + 1
			setZonePolygonPointMax()
		end)
	end
	if zone_point_max > 3 then
		addGMFunction(string.format("Less %i -> %i",zone_point_max,zone_point_max - 1),function()
			zone_point_max = zone_point_max - 1
			setZonePolygonPointMax()
		end)
	end
end
--------------------------------------------
--	Initial Set Up > Zones > Delete Zone  --
--------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN				F	initialGMFunctions
-- -SETUP				F	initialSetUp
-- -ZONES FROM DELETE	F	changeZones
-- Button for each existing zone
function deleteZone()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Setup",initialSetUp)
	addGMFunction("-Zones from delete",changeZones)
	if selected_zone_index == nil then
		selected_zone_index = 1
	end
	if #zone_list > 0 then
		local zone_delete_label = string.format("Del %s",zone_list[selected_zone_index].name)
		if zone_list[selected_zone_index].sector_name ~= nil then
			zone_delete_label = string.format("%s in %s",zone_delete_label,zone_list[selected_zone_index].sector_name)
		end
		addGMFunction(zone_delete_label,function()
			local zone_to_delete = zone_list[selected_zone_index]
			table.remove(zone_list,selected_zone_index)
			zone_to_delete:destroy()
			selected_zone_index = nil
			deleteZone()
		end)
		addGMFunction("Select Next Zone",function()
			selected_zone_index = selected_zone_index + 1
			if selected_zone_index > #zone_list then
				selected_zone_index = 1
			end
			deleteZone()
		end)
	else
		changeZones()
	end
end
-----------------------------------------------------------------------------------
--	Initial Set Up > Automated Station Warning > Set Warning Proximity Distance  --
-----------------------------------------------------------------------------------
-- Button Text FD*	Related Function(s)
-- DEFAULT 30U	D	inline	
-- ZERO			F	inline
-- 5U			F	inline
-- 10U			F	inline
-- 20U			F	inline
-- 30U			F	inline
function setStationSensorRange()
	clearGMFunctions()
	--local long_range_server = getLongRangeRadarRange()
	local long_range_server = 30000
	addGMFunction(string.format("Default %iU",long_range_server/1000),function()
		station_sensor_range = long_range_server
		server_sensor = true
		autoStationWarn()
	end)
	addGMFunction("Zero",function()
		station_sensor_range = 0
		server_sensor = false
		autoStationWarn()
	end)
	addGMFunction("5U",function()
		station_sensor_range = 5000
		server_sensor = false
		autoStationWarn()
	end)
	addGMFunction("10U",function()
		station_sensor_range = 10000
		server_sensor = false
		autoStationWarn()
	end)
	addGMFunction("20U",function()
		station_sensor_range = 20000
		server_sensor = false
		autoStationWarn()
	end)
	addGMFunction("30U",function()
		station_sensor_range = 30000
		server_sensor = false
		autoStationWarn()
	end)
end
--	*												   *  --
--	**												  **  --
--	****************************************************  --
--	****				Spawn Ship(s)				****  --
--	****************************************************  --
--	**												  **  --
--	*												   *  --
------------------------------------
--	Spawn Ship(s) > Spawn a Ship  --
------------------------------------
-- Button Text			   FD*	Related Function(s)
-- -MAIN FROM SHIP SPAWN	F	initialGMFunctions
-- -FLEET OR SHIP			F	spawnGMShips
-- +AT CLICK				D	setFleetSpawnLocation
-- SPAWN GNAT				D	parmSpawnShip
-- List of ships unique to sandbox, sorted by unusual first then alphabetically
function spawnGMShip()
	clearGMFunctions()
	addGMFunction("-Main From Ship Spawn",initialGMFunctions)
	addGMFunction("-Fleet or Ship",spawnGMShips)
	returnFromFleetSpawnLocation = spawnGMShip
	addGMFunction(string.format("+%s",fleetSpawnLocation),setFleetSpawnLocation)
	if gm_click_mode == "ship spawn" then
		addGMFunction(string.format(">Spawn %s<",individual_ship),parmSpawnShip)
	else
		addGMFunction(string.format("Spawn %s",individual_ship),parmSpawnShip)
	end
	sandbox_templates = {}
	for name, details in pairs(ship_template) do
		if details.create ~= stockTemplate then
			local sort_name = name
			if details.unusual then
				sort_name = "a" .. name
			else
				sort_name = "b" .. name
			end
			table.insert(sandbox_templates,sort_name)
		end
	end
	table.sort(sandbox_templates)
	for _, name in ipairs(sandbox_templates) do
		local short_name = string.sub(name,2)
		local button_label = short_name
		if string.sub(name,1,1) == "a" then
			button_label = "U-" .. short_name
		end
		if short_name == individual_ship then
			button_label = button_label .. "*"
		end
		addGMFunction(button_label,function()
			individual_ship = short_name
			spawnGMShip()
		end)
	end
end
-----------------------------------
--	Spawn Ship(s) > Spawn fleet  --
-----------------------------------
-- Button Text			   FD*	Explanation							Related Function(s)
-- -MAIN FROM FLT SPWN		F										initialGMFunctions
-- -SHIP SPAWN				F										spawnGMShips
-- +EXUARI					D	(faction)							setGMFleetFaction
-- +1 PLAYER STRENGTH: n*	D	/Asterisk on selection between		setGMFleetStrength
-- +SET FIXED STRENGTH		D	\relative and fixed strength		setFixedFleetStrength
-- +RANDOM-U				D	(composition)						setFleetComposition
-- +UNMODIFIED				D	(random tweaking)					setFleetChange
-- +IDLE					D	(orders)							setFleetOrders
-- +AT CLICK				D	(position)							setFleetSpawnLocation
-- SPAWN					F										parmSpawnFleet
function spawnGMFleet()
	clearGMFunctions()
	addGMFunction("-Main From Flt Spwn",initialGMFunctions)
	addGMFunction("-Fleet or Ship",spawnGMShips)
	addGMFunction(string.format("+%s",fleetSpawnFaction),setGMFleetFaction)
	if fleetStrengthFixed then
		addGMFunction("+Set Relative Strength",setGMFleetStrength)
		addGMFunction(string.format("+Strength %i*",fleetStrengthFixedValue),setFixedFleetStrength)
	else
		local calcStr = math.floor(playerPower()*fleetStrengthByPlayerStrength)
		local GMSetGMFleetStrength = fleetStrengthByPlayerStrength .. " player strength: " .. calcStr
		addGMFunction("+" .. GMSetGMFleetStrength .. "*",setGMFleetStrength)
		addGMFunction("+Set Fixed Strength",setFixedFleetStrength)
	end
	local exclusion_string = ""
	for name, details in pairs(fleet_exclusions) do
		if details.exclude then
			if exclusion_string == "" then
				exclusion_string = "-"
			end
			exclusion_string = exclusion_string .. details.letter
		end
	end
	addGMFunction(string.format("+%s%s",fleetComposition,exclusion_string),function()
		setFleetComposition(spawnGMFleet)
	end)
	addGMFunction(string.format("+%s",fleetChange),setFleetChange)
	addGMFunction(string.format("+%s",fleetOrders),setFleetOrders)
	returnFromFleetSpawnLocation = spawnGMFleet
	addGMFunction(string.format("+%s",fleetSpawnLocation),setFleetSpawnLocation)
	if gm_click_mode == "fleet spawn" then
		addGMFunction(">Spawn<",parmSpawnFleet)
	else
		addGMFunction("Spawn",parmSpawnFleet)
	end
end
--General use functions for spawning fleets
function playerPower()
	local playerShipScore = 0
	for pidx=1,8 do
		local p = getPlayerShip(pidx)
		if p ~= nil and p:isValid() then
			playerShipScore = playerShipScore + p.shipScore
		end
	end
	return playerShipScore
end
function assignPlayerShipScore(p)
	local spawn_x,spawn_y=p:getPosition()
	if spawn_x<200 and spawn_x>-200 and spawn_y<200 and spawn_y>-200 then-- if the player ship was spawned by the server ship selection screen
		p:setPosition(playerSpawnX,playerSpawnY)	--put player in the correct region when spawned
	end
	local tempTypeName = p:getTypeName()
	if tempTypeName ~= nil then
		local shipScore = playerShipStats[tempTypeName].strength
		if shipScore ~= nil and shipScore > 0 then
			p.shipScore = shipScore
			p.maxCargo = playerShipStats[tempTypeName].cargo
			p.cargo = p.maxCargo
			p:setLongRangeRadarRange(playerShipStats[tempTypeName].long_range_radar)
			p:setShortRangeRadarRange(playerShipStats[tempTypeName].short_range_radar)
			p:setMaxScanProbeCount(playerShipStats[tempTypeName].probes)
			p:setScanProbeCount(p:getMaxScanProbeCount())
			p.tractor = playerShipStats[tempTypeName].tractor
			p.tractor_target_lock = false
			p.mining = playerShipStats[tempTypeName].mining
			p.mining_target_lock = false
			p.mining_in_progress = false
			p.max_pods = playerShipStats[tempTypeName].pods
			p.pods = p.max_pods
			p.max_reactor = 1
			p.max_beam = 1
			p.max_missile = 1
			p.max_maneuver = 1
			p.max_impulse = 1
			p.max_warp = 1
			p.max_jump = 1
			p.max_front_shield = 1
			p.max_rear_shield = 1
		else
			p.shipScore = 24
			p.maxCargo = 5
			p.cargo = p.maxCargo
			p.tractor = false
			p.mining = false
		end
	else
		p.shipScore = 24
		p.maxCargo = 5
		p.cargo = p.maxCargo
	end
	p.maxRepairCrew = p:getRepairCrewCount()
	p.healthyShield = 1.0
	p.prevShield = 1.0
	p.healthyReactor = 1.0
	p.prevReactor = 1.0
	p.healthyManeuver = 1.0
	p.prevManeuver = 1.0
	p.healthyImpulse = 1.0
	p.prevImpulse = 1.0
	if p:getBeamWeaponRange(0) > 0 then
		p.healthyBeam = 1.0
		p.prevBeam = 1.0
	end
	if p:getWeaponTubeCount() > 0 then
		p.healthyMissile = 1.0
		p.prevMissile = 1.0
	end
	if p:hasWarpDrive() then
		p.healthyWarp = 1.0
		p.prevWarp = 1.0
	end
	if p:hasJumpDrive() then
		p.healthyJump = 1.0
		p.prevJump = 1.0
	end
	p.initialCoolant = p:getMaxCoolant()
end
--------------------------------------------
--	Spawn Ship(s) > Spawn Fleet > Exuari  --
--------------------------------------------
-- Select faction for fleet being spawned. Button for each faction. Asterisk = current choice
function setGMFleetFaction()
	clearGMFunctions()
	local GMSetFleetFactionArlenians = "Arlenians"
	if fleetSpawnFaction == "Arlenians" then
		GMSetFleetFactionArlenians = "Arlenians*"
	end
	addGMFunction(GMSetFleetFactionArlenians,function()
		fleetSpawnFaction = "Arlenians"
		spawnGMFleet()
	end)
	local GMSetFleetFactionExuari = "Exuari"
	if fleetSpawnFaction == "Exuari" then
		GMSetFleetFactionExuari = "Exuari*"
	end
	addGMFunction(GMSetFleetFactionExuari,function()
		fleetSpawnFaction = "Exuari"
		spawnGMFleet()
	end)
	local GMSetFleetFactionGhosts = "Ghosts"
	if fleetSpawnFaction == "Ghosts" then
		GMSetFleetFactionGhosts = "Ghosts*"
	end
	addGMFunction(GMSetFleetFactionGhosts,function()
		fleetSpawnFaction = "Ghosts"
		spawnGMFleet()
	end)
	local GMSetFleetFactionHuman = "Human Navy"
	if fleetSpawnFaction == "Human Navy" then
		GMSetFleetFactionHuman = "Human Navy*"
	end
	addGMFunction(GMSetFleetFactionHuman,function()
		fleetSpawnFaction = "Human Navy"
		spawnGMFleet()
	end)
	local GMSetFleetFactionKraylor = "Kraylor"
	if fleetSpawnFaction == "Kraylor" then
		GMSetFleetFactionKraylor = "Kraylor*"
	end
	addGMFunction(GMSetFleetFactionKraylor,function()
		fleetSpawnFaction = "Kraylor"
		spawnGMFleet()
	end)
	local GMSetFleetFactionKtlitans = "Ktlitans"
	if fleetSpawnFaction == "Ktlitans" then
		GMSetFleetFactionKtlitans = "Ktlitans*"
	end
	addGMFunction(GMSetFleetFactionKtlitans,function()
		fleetSpawnFaction = "Ktlitans"
		spawnGMFleet()
	end)
	local GMSetFleetFactionIndependent = "Independent"
	if fleetSpawnFaction == "Independent" then
		GMSetFleetFactionIndependent = "Independent*"
	end
	addGMFunction(GMSetFleetFactionIndependent,function()
		fleetSpawnFaction = "Independent"
		spawnGMFleet()
	end)
	local GMSetFleetFactionTSN = "TSN"
	if fleetSpawnFaction == "TSN" then
		GMSetFleetFactionTSN = "TSN*"
	end
	addGMFunction(GMSetFleetFactionTSN,function()
		fleetSpawnFaction = "TSN"
		spawnGMFleet()
	end)
	local GMSetFleetFactionUSN = "USN"
	if fleetSpawnFaction == "USN" then
		GMSetFleetFactionUSN = "USN*"
	end
	addGMFunction(GMSetFleetFactionUSN,function()
		fleetSpawnFaction = "USN"
		spawnGMFleet()
	end)
	local GMSetFleetFactionCUF = "CUF"
	if fleetSpawnFaction == "CUF" then
		GMSetFleetFactionCUF = "CUF*"
	end
	addGMFunction(GMSetFleetFactionCUF,function()
		fleetSpawnFaction = "CUF"
		spawnGMFleet()
	end)
end
-------------------------------------------------------------
--  Spawn Ship(s) > Spawn Fleet > Relative Fleet Strength  --
-------------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN FROM REL STR	F	initialGMFunctions
-- -FLEET SPAWN			F	spawnGMFleet		
-- .5					*	inline
-- 1*					*	inline		asterisk = current selection
-- 2					*	inline
-- 3					*	inline
-- 4					*	inline
-- 5					*	inline
function setGMFleetStrength()
	clearGMFunctions()
	addGMFunction("-Main from Rel Str",initialGMFunctions)
	addGMFunction("-Fleet or Ship",spawnGMShips)
	addGMFunction("-Fleet Spawn",spawnGMFleet)
	setFleetStrength(setGMFleetStrength)
end
function setFleetStrength(caller)
	local GMSetFleetStrengthByPlayerStrengthHalf = ".5"
	if fleetStrengthByPlayerStrength == .5 then
		GMSetFleetStrengthByPlayerStrengthHalf = ".5*"
	end
	addGMFunction(GMSetFleetStrengthByPlayerStrengthHalf,function()
		fleetStrengthByPlayerStrength = .5
		caller()
	end)
	local GMSetFleetStrengthByPlayerStrength1 = "1"
	if fleetStrengthByPlayerStrength == 1 then
		GMSetFleetStrengthByPlayerStrength1 = "1*"
	end
	addGMFunction(GMSetFleetStrengthByPlayerStrength1,function()
		fleetStrengthByPlayerStrength = 1
		caller()
	end)
	local GMSetFleetStrengthByPlayerStrength2 = "2"
	if fleetStrengthByPlayerStrength == 2 then
		GMSetFleetStrengthByPlayerStrength2 = "2*"
	end
	addGMFunction(GMSetFleetStrengthByPlayerStrength2,function()
		fleetStrengthByPlayerStrength = 2
		caller()
	end)
	local GMSetFleetStrengthByPlayerStrength3 = "3"
	if fleetStrengthByPlayerStrength == 3 then
		GMSetFleetStrengthByPlayerStrength3 = "3*"
	end
	addGMFunction(GMSetFleetStrengthByPlayerStrength3,function()
		fleetStrengthByPlayerStrength = 3
		caller()
	end)
	local GMSetFleetStrengthByPlayerStrength4 = "4"
	if fleetStrengthByPlayerStrength == 4 then
		GMSetFleetStrengthByPlayerStrength4 = "4*"
	end
	addGMFunction(GMSetFleetStrengthByPlayerStrength4,function()
		fleetStrengthByPlayerStrength = 4
		caller()
	end)
	local GMSetFleetStrengthByPlayerStrength5 = "5"
	if fleetStrengthByPlayerStrength == 5 then
		GMSetFleetStrengthByPlayerStrength5 = "5*"
	end
	addGMFunction(GMSetFleetStrengthByPlayerStrength5,function()
		fleetStrengthByPlayerStrength = 5
		caller()
	end)
	fleetStrengthFixed = false
end
--------------------------------------------------------
--	Spawn Ship(s) > Spawn Fleet > Set Fixed Strength  --
--------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN FROM FIX STR	F	initialGMFunctions
-- -FLEET SPAWN			F	spawnGMFleet
-- -FIXED STRENGTH 250	D	spawnGMFleet
-- 250 - 50 = 200		D	inline
-- 250 + 50 = 250		D	inline
function setFixedFleetStrength()
	clearGMFunctions()
	addGMFunction("-Main from Fix Str",initialGMFunctions)
	addGMFunction("-Fleet or Ship",spawnGMShips)
	addGMFunction("-Fleet Spawn",spawnGMFleet)
	addGMFunction("-Fixed Strength " .. fleetStrengthFixedValue,spawnGMFleet)
	fixFleetStrength(setFixedFleetStrength)
end
function fixFleetStrength(caller)
	if fleetStrengthFixedValue > 50 then
		addGMFunction(string.format("%i - %i = %i",fleetStrengthFixedValue,50,fleetStrengthFixedValue-50),function()
			fleetStrengthFixedValue = fleetStrengthFixedValue - 50
			caller()
		end)
	end
	if fleetStrengthFixedValue < 2000 then
		addGMFunction(string.format("%i + %i = %i",fleetStrengthFixedValue,50,fleetStrengthFixedValue+50),function()
			fleetStrengthFixedValue = fleetStrengthFixedValue + 50
			caller()
		end)
	end	
	fleetStrengthFixed = true
end
--------------------------------------------
--	Spawn Ship(s) > Spawn Fleet > Random  --
--------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -FROM COMPOSITION	F	inline
-- +GROUP RANDOM		D	SetFleetGroupComposition
-- +EXCLUDE				D	SetFleetExclusions
function setFleetComposition(caller)
	clearGMFunctions()
	addGMFunction("-From composition",function()
		string.format("")	--necessary to have global reference for Serious Proton engine
		caller()
	end)
	addGMFunction(string.format("+Group %s",fleetComposition),function()
		setFleetGroupComposition(caller)
	end)
	local exclusion_string = ""
	for name, details in pairs(fleet_exclusions) do
		if details.exclude then
			if exclusion_string == "" then
				exclusion_string = "-"
			end
			exclusion_string = exclusion_string .. details.letter
		end
	end
	addGMFunction(string.format("+Exclude%s",exclusion_string),function()
		setFleetExclusions(caller)
	end)
	addGMFunction(string.format("selectivity: %s",pool_selectivity),function()
		if pool_selectivity == "full" then
			pool_selectivity = "less/heavy"
		elseif pool_selectivity == "less/heavy" then
			pool_selectivity = "more/light"
		elseif pool_selectivity == "more/light" then
			pool_selectivity = "full"
		end
		setFleetComposition(caller)
	end)
	if pool_selectivity ~= "full" then
		addGMFunction(string.format("Increase Pool: %i",template_pool_size),function()
			if template_pool_size < 20 then
				template_pool_size = template_pool_size + 1
			else
				addGMMessage("Reached maximum ship template selection pool size of 20")
			end
			setFleetComposition(caller)
		end)
		addGMFunction(string.format("Decrease Pool: %i",template_pool_size),function()
			if template_pool_size > 1 then
				template_pool_size = template_pool_size - 1
			else
				addGMMessage("Reached minimum ship template selection pool size of 1")
			end
			setFleetComposition(caller)
		end)
	end
end
------------------------------------------------------
--	Spawn Ship(s) > Spawn Fleet > Random > Exclude  --
------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -FROM COMPOSITION	F	inline
-- -FROM EXCLUSIONS		F	setFleetComposition
-- -WARP				*	asterisk = included in exclusions, list order varies, items not mutually exclusive
-- -JUMP				*
-- -NUKE				*
function setFleetExclusions(caller)
	clearGMFunctions()
	addGMFunction("-From composition",function()
		string.format("")	--necessary to have global reference for Serious Proton engine
		caller()
	end)
	addGMFunction("-From Exclusions",function()
		string.format("")	--necessary to have global reference for Serious Proton engine
		setFleetComposition(caller)
	end)
	for name, details in pairs(fleet_exclusions) do
		local button_label = name
		if details.exclude then
			button_label = button_label .. "*"
		end
		addGMFunction(button_label,function()
			if details.exclude then
				details.exclude = false
			else
				details.exclude = true
			end
			setFleetExclusions(caller)
		end)
	end
end
-----------------------------------------------------------
--	Spawn Ship(s) > Spawn Fleet > Random > Group Random  --
-----------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -FROM COMPOSITION GROUP	F	spawnGMFleet
-- RANDOM*					*	inline		asterisk = current selection
-- FIGHTERS					*	inline
-- CHASERS					*	inline
-- FRIGATES					*	inline
-- BEAMERS					*	inline
-- MISSILERS				*	inline
-- ADDERS					*	inline
-- NON-DB					*	inline
-- DRONES					*	inline
function setFleetGroupComposition(caller)
	clearGMFunctions()
	addGMFunction("-From composition group",function()
		string.format("")	--necessary to have global reference for Serious Proton engine
		setFleetComposition(caller)
	end)
	local GMSetFleetCompositionRandom = "Random"
	if fleetComposition == "Random" then
		GMSetFleetCompositionRandom = "Random*"
	end
	addGMFunction(GMSetFleetCompositionRandom,function()
		fleetComposition = "Random"
		caller()
	end)
	local GMSetFleetCompositionFighters = "Fighters"
	if fleetComposition == "Fighters" then
		GMSetFleetCompositionFighters = "Fighters*"
	end
	addGMFunction(GMSetFleetCompositionFighters,function()
		fleetComposition = "Fighters"
		caller()
	end)
	local GMSetFleetCompositionChasers = "Chasers"
	if fleetComposition == "Chasers" then
		GMSetFleetCompositionChasers = "Chasers*"
	end
	addGMFunction(GMSetFleetCompositionChasers,function()
		fleetComposition = "Chasers"
		caller()
	end)
	local GMSetFleetCompositionFrigates = "Frigates"
	if fleetComposition == "Frigates" then
		GMSetFleetCompositionFrigates = "Frigates*"
	end
	addGMFunction(GMSetFleetCompositionFrigates,function()
		fleetComposition = "Frigates"
		caller()
	end)
	local GMSetFleetCompositionBeamers = "Beamers"
	if fleetComposition == "Beamers" then
		GMSetFleetCompositionBeamers = "Beamers*"
	end
	addGMFunction(GMSetFleetCompositionBeamers,function()
		fleetComposition = "Beamers"
		caller()
	end)
	local GMSetFleetCompositionMissilers = "Missilers"
	if fleetComposition == "Missilers" then
		GMSetFleetCompositionMissilers = "Missilers*"
	end
	addGMFunction(GMSetFleetCompositionMissilers,function()
		fleetComposition = "Missilers"
		caller()
	end)
	local GMSetFleetCompositionAdders = "Adders"
	if fleetComposition == "Adders" then
		GMSetFleetCompositionAdders = "Adders*"
	end
	addGMFunction(GMSetFleetCompositionAdders,function()
		fleetComposition = "Adders"
		caller()
	end)		
	local GMSetFleetCompositionNonDB = "Non-DB"
	if fleetComposition == "Non-DB" then
		GMSetFleetCompositionNonDB = "Non-DB*"
	end
	addGMFunction(GMSetFleetCompositionNonDB,function()
		fleetComposition = "Non-DB"
		caller()
	end)		
	local GMSetFleetCompositionDrone = "Drones"
	if fleetComposition == "Drones" then
		GMSetFleetCompositionDrone = "Drones*"
	end
	addGMFunction(GMSetFleetCompositionDrone,function()
		fleetComposition = "Drones"
		caller()
	end)
end
----------------------------------------------------------------------------------
--	Spawn Ship(s) > Spawn Fleet > Unmodified (Random Tweaking or Fleet Change)  --
----------------------------------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN FROM FLT CHNG	F	initialGMFunctions
-- -FLEET SPAWN			F	spawnGMFleet
-- UNMODIFIED*			*	inline		asterisk = current selection
-- IMPROVED				*	inline
-- DEGRADED				*	inline
-- TINKERED				*	inline
-- CHANGE CHANCE: 20	D	inline
-- SET TO 10			D	inline
-- SET TO 30			D	inline
function setFleetChange()
	clearGMFunctions()
	addGMFunction("-Main from Flt Chng",initialGMFunctions)
	addGMFunction("-Fleet Spawn",spawnGMFleet)
	local GMSetFleetChangeUnmodified = "Unmodified"
	if fleetChange == "unmodified" then
		GMSetFleetChangeUnmodified = "Unmodified*"
	end
	addGMFunction(GMSetFleetChangeUnmodified,function()
		fleetChange = "unmodified"
		setFleetChange()
	end)
	local GMSetFleetChangeImproved = "Improved"
	if fleetChange == "improved" then
		GMSetFleetChangeImproved = "Improved*"
	end
	addGMFunction(GMSetFleetChangeImproved,function()
		fleetChange = "improved"
		setFleetChange()
	end)
	local GMSetFleetChangeDegraded = "Degraded"
	if fleetChange == "degraded" then
		GMSetFleetChangeDegraded = "Degraded*"
	end
	addGMFunction(GMSetFleetChangeDegraded,function()
		fleetChange = "degraded"
		setFleetChange()
	end)
	local GMSetFleetChangeTinkered = "Tinkered"
	if fleetChange == "tinkered" then
		GMSetFleetChangeTinkered = "Tinkered*"
	end
	addGMFunction(GMSetFleetChangeTinkered,function()
		fleetChange = "tinkered"
		setFleetChange()
	end)
	if fleetChange ~= "unmodified" then
		addGMFunction("Change Chance: " .. fleetChangeChance,setFleetChange)
		if fleetChangeChance == 10 then
			addGMFunction("Set to 20",function()
				fleetChangeChance = 20
				setFleetChange()
			end)
		end
		if fleetChangeChance == 20 then
			addGMFunction("Set to 10", function()
				fleetChangeChance = 10
				setFleetChange()
			end)
			addGMFunction("Set to 30", function()
				fleetChangeChance = 30
				setFleetChange()
			end)
		end
		if fleetChangeChance == 30 then
			addGMFunction("Set to 20", function()
				fleetChangeChance = 20
				setFleetChange()
			end)
			addGMFunction("Set to 50", function()
				fleetChangeChance = 50
				setFleetChange()
			end)
		end
		if fleetChangeChance == 50 then
			addGMFunction("Set to 30", function()
				fleetChangeChance = 30
				setFleetChange()
			end)
			addGMFunction("Set to 70", function()
				fleetChangeChance = 70
				setFleetChange()
			end)
		end
		if fleetChangeChance == 70 then
			addGMFunction("Set to 50", function()
				fleetChangeChance = 50
				setFleetChange()
			end)
			addGMFunction("Set to 80", function()
				fleetChangeChance = 80
				setFleetChange()
			end)
		end
		if fleetChangeChance == 80 then
			addGMFunction("Set to 70", function()
				fleetChangeChance = 70
				setFleetChange()
			end)
			addGMFunction("Set to 90", function()
				fleetChangeChance = 90
				setFleetChange()
			end)
		end
		if fleetChangeChance == 90 then
			addGMFunction("Set to 80", function()
				fleetChangeChance = 80
				setFleetChange()
			end)
			addGMFunction("Set to 100", function()
				fleetChangeChance = 100
				setFleetChange()
			end)
		end
		if fleetChangeChance == 100 then
			addGMFunction("Set to 90",function()
				fleetChangeChance = 90
				setFleetChange()
			end)
		end
	end
end
----------------------------------------------------------------------
--	Spawn Ship(s) > Spawn Fleet > Idle (Fleet Orders When Spawned)  --
----------------------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN FROM FLT ORD	F	initialGMFunctions
-- -FLEET SPAWN			F	spawnGMFleet
-- ROAMING				*	inline
-- IDLE*				*	inline		asterisk = current selection
-- STAND GROUND			*	inline
function setFleetOrders()
	clearGMFunctions()
	addGMFunction("-Main from Flt Ord",initialGMFunctions)
	addGMFunction("-Fleet or Ship",spawnGMShips)
	addGMFunction("-Fleet Spawn",spawnGMFleet)
	local GMSetFleetOrdersRoaming = "Roaming"
	if fleetOrders == "Roaming" then
		GMSetFleetOrdersRoaming = "Roaming*"
	end
	addGMFunction(GMSetFleetOrdersRoaming,function()
		fleetOrders = "Roaming"
		setFleetOrders()
	end)
	local GMSetFleetOrdersIdle = "Idle"
	if fleetOrders == "Idle" then
		GMSetFleetOrdersIdle = "Idle*"
	end
	addGMFunction(GMSetFleetOrdersIdle,function()
		fleetOrders = "Idle"
		setFleetOrders()
	end)
	local GMSetFleetOrdersStandGround = "Stand Ground"
	if fleetOrders == "Stand Ground" then
		GMSetFleetOrdersStandGround = "Stand Ground*"
	end
	addGMFunction(GMSetFleetOrdersStandGround,function()
		fleetOrders = "Stand Ground"
		setFleetOrders()
	end)
end
---------------------------------------------------------------------
--	Spawn Ship(s) > Spawn Fleet > At Click (Fleet Spawn Location)  --
---------------------------------------------------------------------
-- Button Text			   FD*	Related Function(s)
-- -MAIN FROM FLT LOCTN		F	initialGMFunctions
-- -FLEET SPAWN				F	spawnGMFleet
-- AT SELECTION				*	inline
-- SENSOR EDGE				*	inline 
-- BEYOND SENSORS			*	inline
-- +RANDOM DIRECTION		D	setFleetSpawnRelativeDirection (button only appears for SENSOR EDGE and BEYOND SENSORS selections)
-- +AT CLICK*				D*	setSpawnLocationAway
-- +AMBUSH 5				D*	inline, setFleetAmbushDistance
function setFleetSpawnLocation()
	clearGMFunctions()
	addGMFunction("-Main from Flt Loctn",initialGMFunctions)
	addGMFunction("-Fleet or Ship",spawnGMShips)
	addGMFunction("-Fleet Spawn",returnFromFleetSpawnLocation)
	local button_label = "At Selection"
	if fleetSpawnLocation == "At Selection" then
		button_label = "At Selection*"
	end
	addGMFunction(button_label,function()
		fleetSpawnLocation = "At Selection"
		setFleetSpawnLocation()
	end)
	button_label = "Sensor Edge"
	if fleetSpawnLocation == "Sensor Edge" then
		button_label = "Sensor Edge*"
	end
	addGMFunction(button_label,function()
		fleetSpawnLocation = "Sensor Edge"
		setFleetSpawnLocation()
	end)
	button_label = "Beyond Sensors"
	if fleetSpawnLocation == "Beyond Sensors" then
		button_label = "Beyond Sensors*"
	end
	addGMFunction(button_label,function()
		fleetSpawnLocation = "Beyond Sensors"
		setFleetSpawnLocation()
	end)
	if fleetSpawnLocation == "Sensor Edge" or fleetSpawnLocation == "Beyond Sensors" then
		addGMFunction(string.format("+%s",fleetSpawnRelativeDirection),setFleetSpawnRelativeDirection)
	end
	button_label = "Away"
	if string.find(fleetSpawnLocation,"Away") then
		button_label = fleetSpawnLocation .. "*"
	end
	addGMFunction(string.format("+%s",button_label),setSpawnLocationAway)
	button_label = string.format("Ambush %i",fleetAmbushDistance)
	if fleetSpawnLocation == "Ambush" then
		button_label = string.format("Ambush* %i",fleetAmbushDistance)
	end
	addGMFunction(string.format("+%s",button_label),function()
		fleetSpawnLocation = "Ambush"
		setFleetAmbushDistance()
	end)
	button_label = "At Click"
	if fleetSpawnLocation == "At Click" then
		button_label = button_label .. "*"
	end
	addGMFunction(button_label,function()
		fleetSpawnLocation = "At Click"
		setFleetSpawnLocation()
	end)
end
--------------------------------------------------------
--	Spawn Ship(s) > Spawn Fleet > Ambush (Set Fleet Ambush Distance)  --
--------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -FROM AMBUSH DIST  	F	setFleetSpawnLocation
-- 3					*	inline
-- 4					*	inline
-- 5*					*	inline		asterisk = current selection
-- 6					*	inline
-- 7					*	inline
function setFleetAmbushDistance()
	clearGMFunctions()
	addGMFunction("-From Ambush Dist",setFleetSpawnLocation)
	local GMSetFleetAmbushDistance3 = "3"
	if fleetAmbushDistance == 3 then
		GMSetFleetAmbushDistance3 = "3*"
	end
	addGMFunction(GMSetFleetAmbushDistance3,function()
		fleetAmbushDistance = 3
		setFleetAmbushDistance()
	end)
	local GMSetFleetAmbushDistance4 = "4"
	if fleetAmbushDistance == 4 then
		GMSetFleetAmbushDistance4 = "4*"
	end
	addGMFunction(GMSetFleetAmbushDistance4,function()
		fleetAmbushDistance = 4
		setFleetAmbushDistance()
	end)
	local GMSetFleetAmbushDistance5 = "5"
	if fleetAmbushDistance == 5 then
		GMSetFleetAmbushDistance5 = "5*"
	end
	addGMFunction(GMSetFleetAmbushDistance5,function()
		fleetAmbushDistance = 5
		setFleetAmbushDistance()
	end)
	local GMSetFleetAmbushDistance6 = "6"
	if fleetAmbushDistance == 6 then
		GMSetFleetAmbushDistance6 = "6*"
	end
	addGMFunction(GMSetFleetAmbushDistance6,function()
		fleetAmbushDistance = 6
		setFleetAmbushDistance()
	end)
	local GMSetFleetAmbushDistance7 = "7"
	if fleetAmbushDistance == 7 then
		GMSetFleetAmbushDistance7 = "7*"
	end
	addGMFunction(GMSetFleetAmbushDistance7,function()
		fleetAmbushDistance = 7
		setFleetAmbushDistance()
	end)
end
-----------------------------------------------------------------------------------------------------------------
--	Spawn Ship(s) > Spawn Fleet > Away (Fleet Spawn Location) > Random Direction (Fleet Spawn Relative Direction From Player)  --
-----------------------------------------------------------------------------------------------------------------
-- Button Text			   DF*	Related Function(s)
-- -FROM SPWN DIRECTION		F	setFleetSpawnLocation
-- RANDOM DIRECTION*		*	inline		asterisk = current selection
-- 0						*	inline
-- 45						*	inline
-- 90						*	inline
-- 135						*	inline
-- 180						*	inline
-- 225						*	inline
-- 270						*	inline
-- 315						*	inline
function setFleetSpawnRelativeDirection()
	clearGMFunctions()
	addGMFunction("-From Spwn Direction",setFleetSpawnLocation)
	local GMSetFleetSpawnRelativeDirectionRandom = "Random Direction"
	if fleetSpawnRelativeDirection == "Random Direction" then
		GMSetFleetSpawnRelativeDirectionRandom = "Random Direction*"
	end
	addGMFunction(GMSetFleetSpawnRelativeDirectionRandom,function()
		fleetSpawnRelativeDirection = "Random Direction"
		setFleetSpawnRelativeDirection()
	end)
	local GMSetFleetSpawnRelativeDirection0 = "0"
	if fleetSpawnRelativeDirection == 0 then
		GMSetFleetSpawnRelativeDirection0 = "0*"
	end
	addGMFunction(GMSetFleetSpawnRelativeDirection0,function()
		fleetSpawnRelativeDirection = 0
		setFleetSpawnRelativeDirection()
	end)
	local GMSetFleetSpawnRelativeDirection45 = "45"
	if fleetSpawnRelativeDirection == 45 then
		GMSetFleetSpawnRelativeDirection45 = "45*"
	end
	addGMFunction(GMSetFleetSpawnRelativeDirection45,function()
		fleetSpawnRelativeDirection = 45
		setFleetSpawnRelativeDirection()
	end)
	local GMSetFleetSpawnRelativeDirection90 = "90"
	if fleetSpawnRelativeDirection == 90 then
		GMSetFleetSpawnRelativeDirection90 = "90*"
	end
	addGMFunction(GMSetFleetSpawnRelativeDirection90,function()
		fleetSpawnRelativeDirection = 90
		setFleetSpawnRelativeDirection()
	end)
	local GMSetFleetSpawnRelativeDirection135 = "135"
	if fleetSpawnRelativeDirection == 135 then
		GMSetFleetSpawnRelativeDirection135 = "135*"
	end
	addGMFunction(GMSetFleetSpawnRelativeDirection135,function()
		fleetSpawnRelativeDirection = 135
		setFleetSpawnRelativeDirection()
	end)
	local GMSetFleetSpawnRelativeDirection180 = "180"
	if fleetSpawnRelativeDirection == 180 then
		GMSetFleetSpawnRelativeDirection180 = "180*"
	end
	addGMFunction(GMSetFleetSpawnRelativeDirection180,function()
		fleetSpawnRelativeDirection = 180
		setFleetSpawnRelativeDirection()
	end)
	local GMSetFleetSpawnRelativeDirection225 = "225"
	if fleetSpawnRelativeDirection == 225 then
		GMSetFleetSpawnRelativeDirection225 = "225*"
	end
	addGMFunction(GMSetFleetSpawnRelativeDirection225,function()
		fleetSpawnRelativeDirection = 225
		setFleetSpawnRelativeDirection()
	end)
	local GMSetFleetSpawnRelativeDirection270 = "270"
	if fleetSpawnRelativeDirection == 270 then
		GMSetFleetSpawnRelativeDirection270 = "270*"
	end
	addGMFunction(GMSetFleetSpawnRelativeDirection270,function()
		fleetSpawnRelativeDirection = 270
		setFleetSpawnRelativeDirection()
	end)
	local GMSetFleetSpawnRelativeDirection315 = "315"
	if fleetSpawnRelativeDirection == 315 then
		GMSetFleetSpawnRelativeDirection315 = "315*"
	end
	addGMFunction(GMSetFleetSpawnRelativeDirection315,function()
		fleetSpawnRelativeDirection = 315
		setFleetSpawnRelativeDirection()
	end)
end
---------------------------------------------------------------------------------------------------
--	Spawn Ship(s) > Spawn Fleet > Away (Fleet Spawn Location) > Away (Set Spawn Location Away from GM Selection) --
---------------------------------------------------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN FROM SPWN AWY	F	initialGMFunctions
-- -FLEET SPAWN			F	spawnGMFleet
-- -FROM SPAWN AWAY		F	setFleetSpawnLocation
-- +90 DEGREES			D	setFleetSpawnAwayDirection
-- +60U					D	setFleetSpawnAwayDistance
function setSpawnLocationAway()
	clearGMFunctions()
	addGMFunction("-Main from Spwn Awy",initialGMFunctions)
	addGMFunction("-Fleet or Ship",spawnGMShips)
	addGMFunction("-Fleet Spawn",spawnGMFleet)
	addGMFunction("-From Spawn Away",setFleetSpawnLocation)
	local GMSetFleetSpawnAwayDirection = fleetSpawnAwayDirection .. " Degrees"
	addGMFunction(string.format("+%s",GMSetFleetSpawnAwayDirection),setFleetSpawnAwayDirection)
	local GMSetFleetSpawnAwayDistance = fleetSpawnAwayDistance .. "U"
	addGMFunction(string.format("+%s",GMSetFleetSpawnAwayDistance),setFleetSpawnAwayDistance)
	fleetSpawnLocation = string.format("%s Deg Away %iU",fleetSpawnAwayDirection,fleetSpawnAwayDistance)
end
-------------------------------------------------------------------------------------------------
--	Spawn Ship(s) > Spawn Fleet > Away > Away > 90 Degrees (Set Fleet Spawn Away Direction From GM Selection)  --
-------------------------------------------------------------------------------------------------
-- Button Text	   FD*	Related Function(s)
-- -SPAWN AWAY		F	setSpawnLocationAway
-- RANDOM			*	inline
-- 0				*	inline
-- 45				*	inline
-- 90*				*	inline		asterisk = current selection
-- 135				*	inline
-- 180				*	inline
-- 225				*	inline
-- 270				*	inline
-- 315				*	inline
function setFleetSpawnAwayDirection()
	clearGMFunctions()
	addGMFunction("-Spawn Away",setSpawnLocationAway)
	local GMSetFleetSpawnLocationAwayDirectionRandom = "Random"
	if fleetSpawnAwayDirection == "Random" then
		GMSetFleetSpawnLocationAwayDirectionRandom = "Random*"
	end
	addGMFunction(GMSetFleetSpawnLocationAwayDirectionRandom,function()
		fleetSpawnAwayDirection = "Random"
		setFleetSpawnAwayDirection()
	end)
	local GMSetFleetSpawnLocationAwayDirection0 = "0"
	if fleetSpawnAwayDirection == 0 then
		GMSetFleetSpawnLocationAwayDirection0 = "0*"
	end
	addGMFunction(GMSetFleetSpawnLocationAwayDirection0,function()
		fleetSpawnAwayDirection = 0
		setFleetSpawnAwayDirection()
	end)
	local GMSetFleetSpawnLocationAwayDirection45 = "45"
	if fleetSpawnAwayDirection == 45 then
		GMSetFleetSpawnLocationAwayDirection45 = "45*"
	end
	addGMFunction(GMSetFleetSpawnLocationAwayDirection45,function()
		fleetSpawnAwayDirection = 45
		setFleetSpawnAwayDirection()
	end)
	local GMSetFleetSpawnLocationAwayDirection90 = "90"
	if fleetSpawnAwayDirection == 90 then
		GMSetFleetSpawnLocationAwayDirection90 = "90*"
	end
	addGMFunction(GMSetFleetSpawnLocationAwayDirection90,function()
		fleetSpawnAwayDirection = 90
		setFleetSpawnAwayDirection()
	end)
	local GMSetFleetSpawnLocationAwayDirection135 = "135"
	if fleetSpawnAwayDirection == 135 then
		GMSetFleetSpawnLocationAwayDirection135 = "135*"
	end
	addGMFunction(GMSetFleetSpawnLocationAwayDirection135,function()
		fleetSpawnAwayDirection = 135
		setFleetSpawnAwayDirection()
	end)
	local GMSetFleetSpawnLocationAwayDirection180 = "180"
	if fleetSpawnAwayDirection == 180 then
		GMSetFleetSpawnLocationAwayDirection180 = "180*"
	end
	addGMFunction(GMSetFleetSpawnLocationAwayDirection180,function()
		fleetSpawnAwayDirection = 180
		setFleetSpawnAwayDirection()
	end)
	local GMSetFleetSpawnLocationAwayDirection225 = "225"
	if fleetSpawnAwayDirection == 225 then
		GMSetFleetSpawnLocationAwayDirection225 = "225*"
	end
	addGMFunction(GMSetFleetSpawnLocationAwayDirection225,function()
		fleetSpawnAwayDirection = 225
		setFleetSpawnAwayDirection()
	end)
	local GMSetFleetSpawnLocationAwayDirection270 = "270"
	if fleetSpawnAwayDirection == 270 then
		GMSetFleetSpawnLocationAwayDirection270 = "270*"
	end
	addGMFunction(GMSetFleetSpawnLocationAwayDirection270,function()
		fleetSpawnAwayDirection = 270
		setFleetSpawnAwayDirection()
	end)
	local GMSetFleetSpawnLocationAwayDirection315 = "315"
	if fleetSpawnAwayDirection == 315 then
		GMSetFleetSpawnLocationAwayDirection315 = "315*"
	end
	addGMFunction(GMSetFleetSpawnLocationAwayDirection315,function()
		fleetSpawnAwayDirection = 315
		setFleetSpawnAwayDirection()
	end)
end
----------------------------------------------------------------------------------------
--	Spawn Ship(s) > Spawn Fleet > Away > Away > 60U (Set Fleet Spawn Away Distance From GM Selection) --
----------------------------------------------------------------------------------------
-- Button Text	   FD*	Related Function(s)
-- -SPAWN AWAY		F	setSpawnLocationAway
-- 5U				*	inline
-- 10U				*	inline
-- 20U				*	inline
-- 30U				*	inline
-- 40U				*	inline
-- 50U				*	inline
-- 60U*				*	inline		asterisk = current selection
function setFleetSpawnAwayDistance()
	clearGMFunctions()
	addGMFunction("-Spawn Away",setSpawnLocationAway)
	local GMSetFleetSpawnLocationAwayDistance5 = "5U"
	if fleetSpawnAwayDistance == 5 then
		GMSetFleetSpawnLocationAwayDistance5 = "5U*"
	end
	addGMFunction(GMSetFleetSpawnLocationAwayDistance5,function()
		fleetSpawnAwayDistance = 5
		setFleetSpawnAwayDistance()
	end)
	local GMSetFleetSpawnLocationAwayDistance10 = "10U"
	if fleetSpawnAwayDistance == 10 then
		GMSetFleetSpawnLocationAwayDistance10 = "10U*"
	end
	addGMFunction(GMSetFleetSpawnLocationAwayDistance10,function()
		fleetSpawnAwayDistance = 10
		setFleetSpawnAwayDistance()
	end)
	local GMSetFleetSpawnLocationAwayDistance20 = "20U"
	if fleetSpawnAwayDistance == 20 then
		GMSetFleetSpawnLocationAwayDistance20 = "20U*"
	end
	addGMFunction(GMSetFleetSpawnLocationAwayDistance20,function()
		fleetSpawnAwayDistance = 20
		setFleetSpawnAwayDistance()
	end)
	local GMSetFleetSpawnLocationAwayDistance30 = "30U"
	if fleetSpawnAwayDistance == 30 then
		GMSetFleetSpawnLocationAwayDistance30 = "30U*"
	end
	addGMFunction(GMSetFleetSpawnLocationAwayDistance30,function()
		fleetSpawnAwayDistance = 30
		setFleetSpawnAwayDistance()
	end)
	local GMSetFleetSpawnLocationAwayDistance40 = "40U"
	if fleetSpawnAwayDistance == 40 then
		GMSetFleetSpawnLocationAwayDistance40 = "40U*"
	end
	addGMFunction(GMSetFleetSpawnLocationAwayDistance40,function()
		fleetSpawnAwayDistance = 40
		setFleetSpawnAwayDistance()
	end)
	local GMSetFleetSpawnLocationAwayDistance50 = "50U"
	if fleetSpawnAwayDistance == 50 then
		GMSetFleetSpawnLocationAwayDistance50 = "50U*"
	end
	addGMFunction(GMSetFleetSpawnLocationAwayDistance50,function()
		fleetSpawnAwayDistance = 50
		setFleetSpawnAwayDistance()
	end)
	local GMSetFleetSpawnLocationAwayDistance60 = "60U"
	if fleetSpawnAwayDistance == 60 then
		GMSetFleetSpawnLocationAwayDistance60 = "60U*"
	end
	addGMFunction(GMSetFleetSpawnLocationAwayDistance60,function()
		fleetSpawnAwayDistance = 60
		setFleetSpawnAwayDistance()
	end)
end
---------------------------------------
--	Spawn Ship(s) > Spawn fleet based on parameters  --
---------------------------------------
function centerOfSelected(objectList)
	local xSum = 0
	local ySum = 0
	for i=1,#objectList do
		local x, y = objectList[i]:getPosition()
		xSum = xSum + x
		ySum = ySum + y
	end
	local fsx = xSum/#objectList
	local fsy = ySum/#objectList
	return fsx, fsy
end
function gmClickShipSpawn(x,y)
	local ship = ship_template[individual_ship].create(fleetSpawnFaction,individual_ship)
	ship:setPosition(x,y)
	if fleetOrders == "Roaming" then
		ship:orderRoaming()
	elseif fleetOrders == "Idle" then
		ship:orderIdle()
	elseif fleetOrders == "Stand Ground" then
		ship:orderStandGround()
	end
	if fleetChange ~= "unmodified" then
		modifyShip(ship)
	end
end
function parmSpawnShip()
	local fsx = 0
	local fsy = 0
	if fleetSpawnLocation == "At Click" then
		if gm_click_mode == nil then
			gm_click_mode = "ship spawn"
			onGMClick(gmClickShipSpawn)
		elseif gm_click_mode == "ship spawn" then
			gm_click_mode = nil
			onGMClick(nil)
		else
			local prev_mode = gm_click_mode
			gm_click_mode = "ship spawn"
			onGMClick(gmClickShipSpawn)
			addGMMessage(string.format("Cancelled current GM Click mode\n   %s\nIn favor of\n   ship spawn\nGM click mode.",prev_mode))
		end
		spawnGMShip()
	else
		local object_list = getGMSelection()
		if #object_list < 1 then
			addGMMessage("Fleet spawn failed: nothing selected for spawn location determination")
			return
		end 
		if fleetSpawnLocation == "At Selection" then
			fsx, fsy = centerOfSelected(object_list)
		elseif fleetSpawnLocation == "Sensor Edge" or fleetSpawnLocation == "Beyond Sensors" or fleetSpawnLocation == "Ambush" then
			local selectedMatchesPlayer = false
			local selected_player = nil
			for i=1,#object_list do
				local curSelObj = object_list[i]
				for pidx=1,8 do
					local p = getPlayerShip(pidx)
					if p ~= nil and p:isValid() then
						if p == curSelObj then
							selectedMatchesPlayer = true
							fsx, fsy = p:getPosition()
							selected_player = p
							break
						end
					end
				end
				if selectedMatchesPlayer then
					break
				end
			end
			if selectedMatchesPlayer then
				local spawnAngle = fleetSpawnRelativeDirection
				if fleetSpawnRelativeDirection == "Random Direction" then
					spawnAngle = random(0,360)
				else
					spawnAngle = spawnAngle + 270
					if spawnAngle > 360 then 
						spawnAngle = spawnAngle - 360
					end
				end
				if fleetSpawnLocation ~= "Ambush" then
					local tvx = 0
					local tvy = 0
					if fleetSpawnLocation == "Sensor Edge" then
						--tvx, tvy = vectorFromAngle(spawnAngle,getLongRangeRadarRange())
						tvx, tvy = vectorFromAngle(spawnAngle,selected_player:getLongRangeRadarRange())
					else	--beyond sensors
						--tvx, tvy = vectorFromAngle(spawnAngle,getLongRangeRadarRange() + 10000)
						tvx, tvy = vectorFromAngle(spawnAngle,selected_player:getLongRangeRadarRange() + 10000)
					end
					fsx = fsx + tvx
					fsy = fsy + tvy
				end
			else
				addGMMessage("Fleet spawn failed: no valid player ship found amongst selected items")
				return
			end
		elseif string.find(fleetSpawnLocation,"Away") then
			fsx, fsy = centerOfSelected(object_list)
			spawnAngle = fleetSpawnAwayDirection
			if fleetSpawnAwayDirection == "Random" then
				spawnAngle = random(0,360)
			else
				spawnAngle = spawnAngle + 270
				if spawnAngle > 360 then 
					spawnAngle = spawnAngle - 360
				end
			end
			tvx, tvy = vectorFromAngle(spawnAngle,fleetSpawnAwayDistance*1000)
			fsx = fsx + tvx
			fsy = fsy + tvy
		end
		local ship = ship_template[individual_ship].create(fleetSpawnFaction,individual_ship)
		if fleetOrders == "Roaming" then
			ship:orderRoaming()
		elseif fleetOrders == "Idle" then
			ship:orderIdle()
		elseif fleetOrders == "Stand Ground" then
			ship:orderStandGround()
		end
		if fleetChange ~= "unmodified" then
			modifyShip(ship)
		end
		if fleetSpawnLocation == "Ambush" then
			local dex, dey = vectorFromAngle(random(0,360),fleetAmbushDistance*1000)
			ship:setPosition(fsx+dex,fsy+dey)
		else
			ship:setPosition(fsx,fsy)
		end
	end
end
function gmClickFleetSpawn(x,y)
	table.insert(fleetList,spawnRandomArmed(x, y, #fleetList + 1))
end
function parmSpawnFleet()
	local fsx = 0
	local fsy = 0
	local fleet = nil
	if fleetSpawnLocation == "At Click" then
		if gm_click_mode == nil then
			gm_click_mode = "fleet spawn"
			onGMClick(gmClickFleetSpawn)
		elseif gm_click_mode == "fleet spawn" then
			gm_click_mode = nil
			onGMClick(nil)
		else
			local prev_mode = gm_click_mode
			gm_click_mode = "fleet spawn"
			onGMClick(gmClickFleetSpawn)
			addGMMessage(string.format("Cancelled current GM Click mode\n   %s\nIn favor of\n   fleet spawn\nGM click mode.",prev_mode))
		end
		spawnGMFleet()
	else
		local objectList = getGMSelection()
		if #objectList < 1 and (fleetSpawnLocation ~= "Click" and fleetSpawnLocation ~= "AtCachedLocation") then
			addGMMessage("Fleet spawn failed: nothing selected for spawn location determination")
			return
		end
		if fleetSpawnLocation == "At Selection" then
			fsx, fsy = centerOfSelected(objectList)
		elseif fleetSpawnLocation == "Sensor Edge" or fleetSpawnLocation == "Beyond Sensors" or fleetSpawnLocation == "Ambush" then
			local selectedMatchesPlayer = false
			local selected_player = nil
			for i=1,#objectList do
				local curSelObj = objectList[i]
				for pidx=1,8 do
					local p = getPlayerShip(pidx)
					if p ~= nil and p:isValid() then
						if p == curSelObj then
							selectedMatchesPlayer = true
							fsx, fsy = p:getPosition()
							selected_player = p
							break
						end
					end
				end
				if selectedMatchesPlayer then
					break
				end
			end
			if selectedMatchesPlayer then
				local spawnAngle = fleetSpawnRelativeDirection
				if fleetSpawnRelativeDirection == "Random Direction" then
					spawnAngle = random(0,360)
				else
					spawnAngle = spawnAngle + 270
					if spawnAngle > 360 then 
						spawnAngle = spawnAngle - 360
					end
				end
				if fleetSpawnLocation ~= "Ambush" then
					local tvx = 0
					local tvy = 0
					if fleetSpawnLocation == "Sensor Edge" then
						--tvx, tvy = vectorFromAngle(spawnAngle,getLongRangeRadarRange())
						tvx, tvy = vectorFromAngle(spawnAngle,selected_player:getLongRangeRadarRange())
					else	--beyond sensors
						--tvx, tvy = vectorFromAngle(spawnAngle,getLongRangeRadarRange() + 10000)
						tvx, tvy = vectorFromAngle(spawnAngle,selected_player:getLongRangeRadarRange() + 10000)
					end
					fsx = fsx + tvx
					fsy = fsy + tvy
				end
			else
				addGMMessage("Fleet spawn failed: no valid player ship found amongst selected items")
				return
			end
		elseif string.find(fleetSpawnLocation,"Away") then
			fsx, fsy = centerOfSelected(objectList)
			spawnAngle = fleetSpawnAwayDirection
			if fleetSpawnAwayDirection == "Random" then
				spawnAngle = random(0,360)
			else
				spawnAngle = spawnAngle + 270
				if spawnAngle > 360 then 
					spawnAngle = spawnAngle - 360
				end
			end
			tvx, tvy = vectorFromAngle(spawnAngle,fleetSpawnAwayDistance*1000)
			fsx = fsx + tvx
			fsy = fsy + tvy
		elseif fleetSpawnLocation == "Click" then
			onGMClick(function (x,y) -- this probably could be made simpler, but I lack the understanding and time to make it neater at this time
				cached_x = x
				cached_y = y
				fleetSpawnLocation = "AtCachedLocation"
				parmSpawnFleet()
				fleetSpawnLocation = "Click"
			end)
			return
		elseif fleetSpawnLocation == "AtCachedLocation" then
			fsx = cached_x
			fsy = cached_y
		end
		if fleetSpawnLocation == "Ambush" then
			fleet = spawnRandomArmed(fsx, fsy, #fleetList + 1, "ambush", fleetAmbushDistance, spawnAngle)
		else
			fleet = spawnRandomArmed(fsx, fsy, #fleetList + 1)
		end
		table.insert(fleetList,fleet)
	end
end
function excludeShip(current_ship_template)
	assert(type(current_ship_template)=="string") -- the template name we are spawning from ship_template	
	local ship = nil
	ship = ship_template[current_ship_template].create("Independent",current_ship_template)
	ship:orderIdle()
	local exclude = false
	for name, details in pairs(fleet_exclusions) do
		if details.exclude then
			if name == "Unusual" then
				if ship_template[current_ship_template].unusual == true then
					exclude = true
				end
			end
			if name == "Nuke" then
				if ship:getWeaponStorageMax("Nuke") > 0 then
					exclude = true
				end
			end
			if name == "Warp" then
				if ship:hasWarpDrive() then
					exclude = true
				end
			end
			if name == "Jump" then
				if ship:hasJumpDrive() then
					exclude = true
				end
			end
		end
	end
	ship:destroy()
	return exclude
end
function getTemplatePool(max_strength)
	local function getStrengthSort(tbl, sortFunction)
		local keys = {}
		for key in pairs(tbl) do
			table.insert(keys,key)
		end
		table.sort(keys, function(a,b)
			return sortFunction(tbl[a], tbl[b])
		end)
		return keys
	end
	local ship_template_by_strength = getStrengthSort(ship_template, function(a,b)
		return a.strength > b.strength
	end)
	local template_pool = {}
	if pool_selectivity == "less/heavy" then
		for _, current_ship_template in ipairs(ship_template_by_strength) do
			if not excludeShip(current_ship_template) then
				if ship_template[current_ship_template].strength <= max_strength then
					if fleetComposition == "Non-DB" then
						if ship_template[current_ship_template].create ~= stockTemplate then
							table.insert(template_pool,current_ship_template)
						end
					elseif fleetComposition == "Random" then
						table.insert(template_pool,current_ship_template)
					else
						if ship_template[current_ship_template].fleet_group[fleetComposition] then
							table.insert(template_pool,current_ship_template)							
						end
					end
				end
			end
			if #template_pool >= template_pool_size then
				break
			end
		end
	elseif pool_selectivity == "more/light" then
		for i=#ship_template_by_strength,1,-1 do
			local current_ship_template = ship_template_by_strength[i]
			if not excludeShip(current_ship_template) then
				if ship_template[current_ship_template].strength <= max_strength then
					if fleetComposition == "Non-DB" then
						if ship_template[current_ship_template].create ~= stockTemplate then
							table.insert(template_pool,current_ship_template)
						end
					elseif fleetComposition == "Random" then
						table.insert(template_pool,current_ship_template)
					else
						if ship_template[current_ship_template].fleet_group[fleetComposition] then
							table.insert(template_pool,current_ship_template)							
						end
					end
				end
			end
			if #template_pool >= template_pool_size then
				break
			end
		end
	else	--full
		for current_ship_template, details in pairs(ship_template) do
			if not excludeShip(current_ship_template) then
				if details.strength <= max_strength then
					if fleetComposition == "Non-DB" then
						if ship_template[current_ship_template].create ~= stockTemplate then
							table.insert(template_pool,current_ship_template)
						end
					elseif fleetComposition == "Random" then
						table.insert(template_pool,current_ship_template)
					else
						if ship_template[current_ship_template][fleet_group[fleetComposition]] then
							table.insert(template_pool,current_ship_template)							
						end
					end
				end
			end
		end
	end
	--print("returning template pool containing these templates:")
	--for _, template in ipairs(template_pool) do
	--	print(template)
	--end
	return template_pool
end
function modifyShip(ship)
	local modVal = modifiedValue()
	if modVal ~= 1 then
		ship:setHullMax(ship:getHullMax()*modVal)
		ship:setHull(ship:getHullMax())
	end
	modVal = modifiedValue()
	if modVal ~= 1 then
		local shieldCount = ship:getShieldCount()
		if shieldCount > 0 then
			if shieldCount == 1 then
				ship:setShieldsMax(ship:getShieldMax(0)*modVal)
				ship:setShields(ship:getShieldMax(0))
			elseif shieldCount == 2 then
				ship:setShieldsMax(ship:getShieldMax(0)*modVal,ship:getShieldMax(1)*modVal)
				ship:setShields(ship:getShieldMax(0),ship:getShieldMax(1))
			elseif shieldCount == 3 then
				ship:setShieldsMax(ship:getShieldMax(0)*modVal,ship:getShieldMax(1)*modVal,ship:getShieldMax(2)*modVal)
				ship:setShields(ship:getShieldMax(0),ship:getShieldMax(1),ship:getShieldMax(2))
			elseif shieldCount == 4 then
				ship:setShieldsMax(ship:getShieldMax(0)*modVal,ship:getShieldMax(1)*modVal,ship:getShieldMax(2)*modVal,ship:getShieldMax(3)*modVal)
				ship:setShields(ship:getShieldMax(0),ship:getShieldMax(1),ship:getShieldMax(2),ship:getShieldMax(3))
			elseif shieldCount == 5 then
				ship:setShieldsMax(ship:getShieldMax(0)*modVal,ship:getShieldMax(1)*modVal,ship:getShieldMax(2)*modVal,ship:getShieldMax(3)*modVal,ship:getShieldMax(4)*modVal)
				ship:setShields(ship:getShieldMax(0),ship:getShieldMax(1),ship:getShieldMax(2),ship:getShieldMax(3),ship:getShieldMax(4))
			elseif shieldCount == 6 then
				ship:setShieldsMax(ship:getShieldMax(0)*modVal,ship:getShieldMax(1)*modVal,ship:getShieldMax(2)*modVal,ship:getShieldMax(3)*modVal,ship:getShieldMax(4)*modVal,ship:getShieldMax(5)*modVal)
				ship:setShields(ship:getShieldMax(0),ship:getShieldMax(1),ship:getShieldMax(2),ship:getShieldMax(3),ship:getShieldMax(4),ship:getShieldMax(5))
			elseif shieldCount == 7 then
				ship:setShieldsMax(ship:getShieldMax(0)*modVal,ship:getShieldMax(1)*modVal,ship:getShieldMax(2)*modVal,ship:getShieldMax(3)*modVal,ship:getShieldMax(4)*modVal,ship:getShieldMax(5)*modVal,ship:getShieldMax(6)*modVal)
				ship:setShields(ship:getShieldMax(0),ship:getShieldMax(1),ship:getShieldMax(2),ship:getShieldMax(3),ship:getShieldMax(4),ship:getShieldMax(5),ship:getShieldMax(6))
			elseif shieldCount == 8 then
				ship:setShieldsMax(ship:getShieldMax(0)*modVal,ship:getShieldMax(1)*modVal,ship:getShieldMax(2)*modVal,ship:getShieldMax(3)*modVal,ship:getShieldMax(4)*modVal,ship:getShieldMax(5)*modVal,ship:getShieldMax(6)*modVal,ship:getShieldMax(7)*modVal)
				ship:setShields(ship:getShieldMax(0),ship:getShieldMax(1),ship:getShieldMax(2),ship:getShieldMax(3),ship:getShieldMax(4),ship:getShieldMax(5),ship:getShieldMax(6),ship:getShieldMax(7))
			end
		end
	end
	local maxNuke = ship:getWeaponStorageMax("Nuke")
	if maxNuke > 0 then
		modVal = modifiedValue()
		if modVal ~= 1 then
			if modVal > 1 then
				ship:setWeaponStorageMax("Nuke",math.ceil(maxNuke*modVal))
			else
				ship:setWeaponStorageMax("Nuke",math.floor(maxNuke*modVal))
			end
			ship:setWeaponStorage("Nuke",ship:getWeaponStorageMax("Nuke"))
		end
	end
	local maxEMP = ship:getWeaponStorageMax("EMP")
	if maxEMP > 0 then
		modVal = modifiedValue()
		if modVal ~= 1 then
			if modVal > 1 then
				ship:setWeaponStorageMax("EMP",math.ceil(maxEMP*modVal))
			else
				ship:setWeaponStorageMax("EMP",math.floor(maxEMP*modVal))
			end
			ship:setWeaponStorage("EMP",ship:getWeaponStorageMax("EMP"))
		end
	end
	local maxMine = ship:getWeaponStorageMax("Mine")
	if maxMine > 0 then
		modVal = modifiedValue()
		if modVal ~= 1 then
			if modVal > 1 then
				ship:setWeaponStorageMax("Mine",math.ceil(maxMine*modVal))
			else
				ship:setWeaponStorageMax("Mine",math.floor(maxMine*modVal))
			end
			ship:setWeaponStorage("Mine",ship:getWeaponStorageMax("Mine"))
		end
	end
	local maxHoming = ship:getWeaponStorageMax("Homing")
	if maxHoming > 0 then
		modVal = modifiedValue()
		if modVal ~= 1 then
			if modVal > 1 then
				ship:setWeaponStorageMax("Homing",math.ceil(maxHoming*modVal))
			else
				ship:setWeaponStorageMax("Homing",math.floor(maxHoming*modVal))
			end
			ship:setWeaponStorage("Homing",ship:getWeaponStorageMax("Homing"))
		end
	end
	local maxHVLI = ship:getWeaponStorageMax("HVLI")
	if maxHVLI > 0 then
		modVal = modifiedValue()
		if modVal ~= 1 then
			if modVal > 1 then
				maxHVLI = math.ceil(maxHVLI*modVal)
			else
				maxHVLI = math.floor(maxHVLI*modVal)
			end
			ship:setWeaponStorageMax("HVLI",maxHVLI)
			ship:setWeaponStorage("HVLI",maxHVLI)
		end
	end
	modVal = modifiedValue()
	if modVal ~= 1 then
		ship:setImpulseMaxSpeed(ship:getImpulseMaxSpeed()*modVal)
	end
	modVal = modifiedValue()
	if modVal ~= 1 then
		ship:setRotationMaxSpeed(ship:getRotationMaxSpeed()*modVal)
	end
	if ship:getBeamWeaponRange(0) > 0 then
		local beamIndex = 0
		local modArc = modifiedValue()
		local modDirection = modifiedValue()
		local modRange = modifiedValue()
		local modCycle = 1/modifiedValue()
		local modDamage = modifiedValue()
		local modEnergy = 1/modifiedValue()
		local modHeat = 1/modifiedValue()
		repeat
			local beamArc = ship:getBeamWeaponArc(beamIndex)
			local beamDirection = ship:getBeamWeaponDirection(beamIndex)
			local beamRange = ship:getBeamWeaponRange(beamIndex)
			local beamCycle = ship:getBeamWeaponCycleTime(beamIndex)
			local beamDamage = ship:getBeamWeaponDamage(beamIndex)
			ship:setBeamWeapon(beamIndex,beamArc*modArc,beamDirection*modDirection,beamRange*modRange,beamCycle*modCycle,beamDamage*modDamage)
			ship:setBeamWeaponEnergyPerFire(beamIndex,ship:getBeamWeaponEnergyPerFire(beamIndex)*modEnergy)
			ship:setBeamWeaponHeatPerFire(beamIndex,ship:getBeamWeaponHeatPerFire(beamIndex)*modHeat)
			beamIndex = beamIndex + 1
		until(ship:getBeamWeaponRange(beamIndex) < 1)
	end
end
--function spawnRandomArmed(x, y, fleetIndex, sl, nl, bl, ambush_distance, spawn_angle)
function spawnRandomArmed(x, y, fleetIndex, shape, spawn_distance, spawn_angle, px, py)
--x and y are central spawn coordinates
--fleetIndex is the number of the fleet to be spawned
--sl (was) the score list, nl is the name list, bl is the boolean list
--spawn_distance optional - used for ambush or pyramid
--spawn_angle optional - used for ambush or pyramid
--px and py are the player coordinates or the pyramid fly towards point coordinates
	local enemyStrength = math.max(fleetStrengthByPlayerStrength * playerPower(),5)
	if fleetStrengthFixed then
		enemyStrength = fleetStrengthFixedValue
	end
	local enemyPosition = 0
	local sp = irandom(500,1000)			--random spacing of spawned group
	if shape == nil then
		shape = "square"
		if random(1,100) < 50 then
			shape = "hexagonal"
		end
	end
	local enemy_position = 0
	local enemyList = {}
	--print("in spawn random armed function about to call get template pool function")
	local template_pool = getTemplatePool(enemyStrength)
	if #template_pool < 1 then
		addGMMessage("Empty Template pool: fix excludes or other criteria")
		return enemyList
	end
	while enemyStrength > 0 do
		local selected_template = template_pool[math.random(1,#template_pool)]
		--print("selected template:",selected_template)
		local ship = ship_template[selected_template].create(fleetSpawnFaction,selected_template)
		ship:setCommsScript(""):setCommsFunction(commsShip):orderRoaming()
		if fleetOrders == "Roaming" then
			ship:orderRoaming()
		elseif fleetOrders == "Idle" then
			ship:orderIdle()
		elseif fleetOrders == "Stand Ground" then
			ship:orderStandGround()
		end
		enemy_position = enemy_position + 1
		if shape == "none" or shape == "pyramid" or shape == "ambush" then
			ship:setPosition(x,y)
		else
			ship:setPosition(x + formation_delta[shape].x[enemy_position] * sp, y + formation_delta[shape].y[enemy_position] * sp)
		end
		ship.fleetIndex = fleetIndex
		if fleetChange ~= "unmodified" then
			modifyShip(ship)
		end
		table.insert(enemyList, ship)
		enemyStrength = enemyStrength - ship_template[selected_template].strength
	end
	if shape == "pyramid" then
		if spawn_distance == nil then
			spawn_distance = 30
		end
		if spawn_angle == nil then
			spawn_angle = random(0,360)
		end
		if px == nil then
			px = 0
		end
		if py == nil then
			py = 0
		end
		local pyramid_tier = math.min(#enemyList,max_pyramid_tier)
		for index, ship in ipairs(enemyList) do
			if index <= max_pyramid_tier then
				local pyramid_angle = spawn_angle + formation_delta.pyramid[pyramid_tier][index].angle
				if pyramid_angle < 0 then 
					pyramid_angle = pyramid_angle + 360
				end
				pyramid_angle = pyramid_angle % 360
				rx, ry = vectorFromAngle(pyramid_angle,radius + formation_delta.pyramid[pyramid_tier][index].distance * 800)
				ship:setPosition(px+rx,py+ry)
			else
				ship:setPosition(px+vx,py+vy)
			end
			ship:setHeading((spawn_angle + 270) % 360)
			ship:orderFlyTowards(px,py)
		end
	end
	if shape == "ambush" then
		if spawn_distance ~= nil then
			spawn_distance = 5
		end
		if spawn_angle == nil then
			spawn_angle = random(0,360)
		end
		local circle_increment = 360/#enemyList
		for _, enemy in ipairs(enemyList) do
			local dex, dey = vectorFromAngle(spawn_angle,spawn_distance*1000)
			enemy:setPosition(x+dex,y+dey)
			spawn_angle = spawn_angle + circle_increment
		end
	end
	return enemyList
end
function modifiedValue()
	local modChance = random(1,100)
	local modValue = 1
	if fleetChange == "improved" then
		if modChance <= fleetChangeChance then
			modValue = modValue + random(10,25)/100
		end
	elseif fleetChange == "degraded" then
		if modChance <= fleetChangeChance then
			modValue = modValue - random(10,25)/100
		end
	else	--tinkered
		if modChance <= fleetChangeChance then
			if random(1,100) <= 50 then
				modValue = modValue + random(10,25)/100
			else
				modValue = modValue - random(10,25)/100
			end
		end
	end
	return modValue
end
function stockTemplate(enemyFaction,template)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate(template):orderRoaming()
	ship:onTakingDamage(function(self,instigator)
		string.format("")	--serious proton needs a global context
		if instigator ~= nil then
			self.damage_instigator = instigator
		end
	end)
	return ship
end
--------------------------------------------------------------------------------------------
--	Additional enemy ships with some modifications from the original template parameters  --
--------------------------------------------------------------------------------------------
function adderMk3(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("Adder MK4"):orderRoaming()
	ship:onTakingDamage(function(self,instigator)
		string.format("")	--serious proton needs a global context
		if instigator ~= nil then
			self.damage_instigator = instigator
		end
	end)
	ship:setTypeName("Adder MK3")
	ship:setHullMax(35)		--weaker hull (vs 40)
	ship:setHull(35)
	ship:setShieldsMax(15)	--weaker shield (vs 20)
	ship:setShields(15)
	ship:setRotationMaxSpeed(35)	--faster maneuver (vs 20)
	local adder_mk3_db = queryScienceDatabase("Ships","Starfighter","Adder MK3")
	if adder_mk3_db == nil then
		local starfighter_db = queryScienceDatabase("Ships","Starfighter")
		starfighter_db:addEntry("Adder MK3")
		adder_mk3_db = queryScienceDatabase("Ships","Starfighter","Adder MK3")
		addShipToDatabase(
			queryScienceDatabase("Ships","Starfighter","Adder MK4"),	--base ship database entry
			adder_mk3_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"The Adder MK3 is one of the first of the Adder line to meet with some success. A large number of them were made before the manufacturer went through its first bankruptcy. There has been a recent surge of purchases of the Adder MK3 in the secondary market due to its low price and its similarity to subsequent models. Compared to the Adder MK4, the Adder MK3 has weaker shields and hull, but a faster turn speed",
			{
				{key = "Small tube 0", value = "20 sec"},	--torpedo tube direction and load speed
			},
			nil
		)
		--[[
		adder_mk3_db:setLongDescription("One of the first of the Adder line to meet with some success. A large number of them were made before the manufacturer went through its first bankruptcy. There has been a recent surge of purchases in the secondary market due to its low price and its similarity to subsequent models")
		adder_mk3_db:setKeyValue("Class","Starfighter")
		adder_mk3_db:setKeyValue("Sub-class","Gunship")
		adder_mk3_db:setKeyValue("Size","30")
		adder_mk3_db:setKeyValue("Shield","15")
		adder_mk3_db:setKeyValue("Hull","35")
		adder_mk3_db:setKeyValue("Move speed","3.6 U/min")
		adder_mk3_db:setKeyValue("Turn speed","35 deg/sec")
		adder_mk3_db:setKeyValue("Beam weapon 0:30","2.0 Dmg / 5.0 sec")
		adder_mk3_db:setKeyValue("Small tube 0","20 sec")
		adder_mk3_db:setKeyValue("Storage HVLI","2")
		adder_mk3_db:setImage("radar_fighter.png")
		--]]
	end
	return ship
end
function adderMk7(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("Adder MK6"):orderRoaming()
	ship:onTakingDamage(function(self,instigator)
		string.format("")	--serious proton needs a global context
		if instigator ~= nil then
			self.damage_instigator = instigator
		end
	end)
	ship:setTypeName("Adder MK7")
	ship:setShieldsMax(40)	--stronger shields (vs 30)
	ship:setShields(40)
--				   Index,  Arc,	  Dir, Range, Cycle,	Damage
	ship:setBeamWeapon(0,	30,		0,	 900,	5.0,	2.0)	--narrower (30 vs 35) but longer (900 vs 800) beam
	ship:setBeamWeapon(2,	70,	  -30,	 900,	5.0,	2.0)	--adjust beam direction to match starboard side (vs -35)
	local adder_mk7_db = queryScienceDatabase("Ships","Starfighter","Adder MK7")
	if adder_mk7_db == nil then
		local starfighter_db = queryScienceDatabase("Ships","Starfighter")
		starfighter_db:addEntry("Adder MK7")
		adder_mk7_db = queryScienceDatabase("Ships","Starfighter","Adder MK7")
		addShipToDatabase(
			queryScienceDatabase("Ships","Starfighter","Adder MK6"),	--base ship database entry
			adder_mk7_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"The release of the Adder Mark 7 sent the manufacturer into a second bankruptcy. They made improvements to the Mark 7 over the Mark 6 like stronger shields and longer beams, but the popularity of their previous models, especially the Mark 5, prevented them from raising the purchase price enough to recoup the development and manufacturing costs of the Mark 7",
			{
				{key = "Small tube 0", value = "15 sec"},	--torpedo tube direction and load speed
			},
			nil
		)
		--[[
		adder_mk7_db:setLongDescription("The release of the Adder Mark 7 sent the manufacturer into a second bankruptcy. They made improvements over the Mark 6 like stronger shields and longer beams, but the popularity of their previous models prevented them from raising the purchase price enough to recoup the development and manufacturing costs of the Mark 7")
		adder_mk7_db:setKeyValue("Class","Starfighter")
		adder_mk7_db:setKeyValue("Sub-class","Gunship")
		adder_mk7_db:setKeyValue("Size","30")
		adder_mk7_db:setKeyValue("Shield","40")
		adder_mk7_db:setKeyValue("Hull","50")
		adder_mk7_db:setKeyValue("Move speed","4.8 U/min")
		adder_mk7_db:setKeyValue("Turn speed","28.0 deg/sec")
		adder_mk7_db:setKeyValue("Beam weapon 0:30","2.0 Dmg / 5.0 sec")
		adder_mk7_db:setKeyValue("Beam weapon 30:70","2.0 Dmg / 5.0 sec")
		adder_mk7_db:setKeyValue("Beam weapon -35:70","2.0 Dmg / 5.0 sec")
		adder_mk7_db:setKeyValue("Beam weapon 180:35","2.0 Dmg / 6.0 sec")
		adder_mk7_db:setKeyValue("Front small tube","15 sec")
		adder_mk7_db:setKeyValue("Storage HVLI","8")
		adder_mk7_db:setImage("radar_fighter.png")
		--]]
	end
	return ship
end
function adderMk8(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("Adder MK5"):orderRoaming()
	ship:onTakingDamage(function(self,instigator)
		string.format("")	--serious proton needs a global context
		if instigator ~= nil then
			self.damage_instigator = instigator
		end
	end)
	ship:setTypeName("Adder MK8")
	ship:setShieldsMax(50)					--stronger shields (vs 30)
	ship:setShields(50)
--				   Index,  Arc,	  Dir, Range, Cycle,	Damage
	ship:setBeamWeapon(0,	30,		0,	 900,	5.0,	2.3)	--narrower (30 vs 35) but longer (900 vs 800) and stronger (2.3 vs 2.0) beam
	ship:setBeamWeapon(2,	70,	  -30,	 900,	5.0,	2.0)	--adjust beam direction to match starboard side (vs -35)
	ship:setRotationMaxSpeed(30)			--faster maneuver (vs 25)
	local adder_mk8_db = queryScienceDatabase("Ships","Starfighter","Adder MK8")
	if adder_mk8_db == nil then
		local starfighter_db = queryScienceDatabase("Ships","Starfighter")
		starfighter_db:addEntry("Adder MK8")
		adder_mk8_db = queryScienceDatabase("Ships","Starfighter","Adder MK8")
		addShipToDatabase(
			queryScienceDatabase("Ships","Starfighter","Adder MK5"),	--base ship database entry
			adder_mk8_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"New management after bankruptcy revisited their most popular Adder Mark 5 model with improvements: stronger shields, longer and stronger beams and a faster turn speed. Thus was born the Adder Mark 8 model. Targeted to the practical but nostalgic buyer who must purchase replacements for their Adder Mark 5 fleet",
			{
				{key = "Small tube 0", value = "15 sec"},	--torpedo tube direction and load speed
			},
			nil
		)
		--[[
		adder_mk8_db:setLongDescription("New management after bankruptcy revisited their most popular Adder Mark 5 model with improvements: stronger shields, longer and stronger beams and a faster turn speed. Thus was born the Adder Mark 8 model. Targeted to the practical but nostalgic buyer who must purchase replacements for their Adder Mark 5 fleet")
		adder_mk8_db:setKeyValue("Class","Starfighter")
		adder_mk8_db:setKeyValue("Sub-class","Gunship")
		adder_mk8_db:setKeyValue("Size","30")
		adder_mk8_db:setKeyValue("Shield","50")
		adder_mk8_db:setKeyValue("Hull","50")
		adder_mk8_db:setKeyValue("Move speed","4.8 U/min")
		adder_mk8_db:setKeyValue("Turn speed","30.0 deg/sec")
		adder_mk8_db:setKeyValue("Beam weapon 0:30","2.3 Dmg / 5.0 sec")
		adder_mk8_db:setKeyValue("Beam weapon 30:70","2.0 Dmg / 5.0 sec")
		adder_mk8_db:setKeyValue("Beam weapon -35:70","2.0 Dmg / 5.0 sec")
		adder_mk8_db:setKeyValue("Small tube 0","15 sec")
		adder_mk8_db:setKeyValue("Storage HVLI","4")
		adder_mk8_db:setImage("radar_fighter.png")
		--]]
	end
	return ship
end
function adderMk9(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("Adder MK5"):orderRoaming()
	ship:onTakingDamage(function(self,instigator)
		string.format("")	--serious proton needs a global context
		if instigator ~= nil then
			self.damage_instigator = instigator
		end
	end)
	ship:setTypeName("Adder MK9")
	ship:setShieldsMax(50)					--stronger shields (vs 30)
	ship:setShields(50)
--				   Index,  Arc,	  Dir, Range, Cycle,	Damage
	ship:setBeamWeapon(0,	30,		0,	 900,	4.5,	2.5)	--narrower (30 vs 35) but longer (900 vs 800), faster (4.5 vs 5.0) and stronger (2.5 vs 2.0) beam
	ship:setBeamWeapon(2,	70,	  -30,	 900,	5.0,	2.0)	--adjust beam direction to match starboard side (vs -35)
	ship:setRotationMaxSpeed(30)			--faster maneuver (vs 25)
	ship:setWeaponStorageMax("Nuke",2)		--more nukes (vs 0)
	ship:setWeaponStorage("Nuke",2)
	local adder_mk9_db = queryScienceDatabase("Ships","Starfighter","Adder MK9")
	if adder_mk9_db == nil then
		local starfighter_db = queryScienceDatabase("Ships","Starfighter")
		starfighter_db:addEntry("Adder MK9")
		adder_mk9_db = queryScienceDatabase("Ships","Starfighter","Adder MK9")
		addShipToDatabase(
			queryScienceDatabase("Ships","Starfighter","Adder MK5"),	--base ship database entry
			adder_mk9_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"Hot on the heels of the Adder Mark 8 comes the Adder Mark 9. Still using the Adder Mark 5 as a base, the designers provided stronger shields, stronger, longer and faster beams, faster turn speed and for that extra special touch, two nuclear missiles. As their ad says, 'You'll feel better in an Adder Mark 9.'",
			{
				{key = "Small tube 0", value = "15 sec"},	--torpedo tube direction and load speed
			},
			nil
		)
		--[[
		adder_mk9_db:setLongDescription("Hot on the heels of the Adder Mark 8 comes the Adder Mark 9. Still using the Adder Mark 5 as a base, the designers provided stronger shields, stronger, longer and faster beams, faster turn speed and for that extra special touch, two nuclear missiles. As their ad says, 'You'll feel better in an Adder Mark 9.'")
		adder_mk9_db:setKeyValue("Class","Starfighter")
		adder_mk9_db:setKeyValue("Sub-class","Gunship")
		adder_mk9_db:setKeyValue("Size","30")
		adder_mk9_db:setKeyValue("Shield","50")
		adder_mk9_db:setKeyValue("Hull","50")
		adder_mk9_db:setKeyValue("Move speed","4.8 U/min")
		adder_mk9_db:setKeyValue("Turn speed","30.0 deg/sec")
		adder_mk8_db:setKeyValue("Beam weapon 0:30","2.5 Dmg / 4.5 sec")
		adder_mk8_db:setKeyValue("Beam weapon 30:70","2.0 Dmg / 5.0 sec")
		adder_mk8_db:setKeyValue("Beam weapon -35:70","2.0 Dmg / 5.0 sec")
		adder_mk9_db:setKeyValue("Front small tube","15 sec")
		adder_mk9_db:setKeyValue("Storage HVLI","4")
		adder_mk9_db:setKeyValue("Storage Nuke","2")
		adder_mk9_db:setImage("radar_fighter.png")
		--]]
	end
	return ship
end
function phobosR2(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("Phobos T3"):orderRoaming()
	ship:onTakingDamage(function(self,instigator)
		string.format("")	--serious proton needs a global context
		if instigator ~= nil then
			self.damage_instigator = instigator
		end
	end)
	ship:setTypeName("Phobos R2")
	ship:setWeaponTubeCount(1)			--one tube (vs 2)
	ship:setWeaponTubeDirection(0,0)	
	ship:setImpulseMaxSpeed(55)			--slower impulse (vs 60)
	ship:setRotationMaxSpeed(15)		--faster maneuver (vs 10)
	local phobos_r2_db = queryScienceDatabase("Ships","Frigate","Phobos R2")
	if phobos_r2_db == nil then
		local frigate_db = queryScienceDatabase("Ships","Frigate")
		frigate_db:addEntry("Phobos R2")
		phobos_r2_db = queryScienceDatabase("Ships","Frigate","Phobos R2")
		addShipToDatabase(
			queryScienceDatabase("Ships","Frigate","Phobos T3"),	--base ship database entry
			phobos_r2_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"The Phobos R2 model is very similar to the Phobos T3. It's got a faster turn speed, but only one missile tube",
			{
				{key = "Tube 0", value = "60 sec"},	--torpedo tube direction and load speed
			},
			nil
		)
		--[[
		phobos_r2_db:setLongDescription("The Phobos R2 model is very similar to the Phobos T3. It's got a faster turn speed, but only one missile tube")
		phobos_r2_db:setKeyValue("Class","Frigate")
		phobos_r2_db:setKeyValue("Sub-class","Cruiser")
		phobos_r2_db:setKeyValue("Size","80")
		phobos_r2_db:setKeyValue("Shield","50/40")
		phobos_r2_db:setKeyValue("Hull","70")
		phobos_r2_db:setKeyValue("Move speed","3.3 U/min")
		phobos_r2_db:setKeyValue("Turn speed","15.0 deg/sec")
		phobos_r2_db:setKeyValue("Beam weapon -15:90","6.0 Dmg / 8.0 sec")
		phobos_r2_db:setKeyValue("Beam weapon 15:90","6.0 Dmg / 8.0 sec")
		phobos_r2_db:setKeyValue("Tube 0","60 sec")
		phobos_r2_db:setKeyValue("Storage Homing","6")
		phobos_r2_db:setKeyValue("Storage HVLI","20")
		phobos_r2_db:setImage("radar_cruiser.png")
		--]]
	end
	return ship
end
function hornetMV52(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("MT52 Hornet"):orderRoaming()
	ship:onTakingDamage(function(self,instigator)
		string.format("")	--serious proton needs a global context
		if instigator ~= nil then
			self.damage_instigator = instigator
		end
	end)
	ship:setTypeName("MV52 Hornet")
	ship:setBeamWeapon(0, 30, 0, 1000.0, 4.0, 3.0)	--longer and stronger beam (vs 700 & 3)
	ship:setRotationMaxSpeed(31)					--faster maneuver (vs 30)
	ship:setImpulseMaxSpeed(130)					--faster impulse (vs 120)
	local hornet_mv52_db = queryScienceDatabase("Ships","Starfighter","MV52 Hornet")
	if hornet_mv52_db == nil then
		local starfighter_db = queryScienceDatabase("Ships","Starfighter")
		starfighter_db:addEntry("MV52 Hornet")
		hornet_mv52_db = queryScienceDatabase("Ships","Starfighter","MV52 Hornet")
		addShipToDatabase(
			queryScienceDatabase("Ships","Starfighter","MT52 Hornet"),	--base ship database entry
			hornet_mv52_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"The MV52 Hornet is very similar to the MT52 and MU52 models. The beam does more damage than both of the other Hornet models, it's max impulse speed is faster than both of the other Hornet models, it turns faster than the MT52, but slower than the MU52",
			nil,
			nil
		)
		--[[
		hornet_mv52_db:setLongDescription("The MV52 Hornet is very similar to the MT52 and MU52 models. The beam does more damage than both of the other Hornet models, it's max impulse speed is faster than both of the other Hornet models, it turns faster than the MT52, but slower than the MU52")
		hornet_mv52_db:setKeyValue("Class","Starfighter")
		hornet_mv52_db:setKeyValue("Sub-class","Interceptor")
		hornet_mv52_db:setKeyValue("Size","30")
		hornet_mv52_db:setKeyValue("Shield","20")
		hornet_mv52_db:setKeyValue("Hull","30")
		hornet_mv52_db:setKeyValue("Move speed","7.8 U/min")
		hornet_mv52_db:setKeyValue("Turn speed","31.0 deg/sec")
		hornet_mv52_db:setKeyValue("Beam weapon 0:30","3.0 Dmg / 4.0 sec")
		hornet_mv52_db:setImage("radar_fighter.png")
		--]]
	end
	return ship
end
function nirvanaR3(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("Nirvana R5"):orderRoaming()
	ship:onTakingDamage(function(self,instigator)
		string.format("")	--serious proton needs a global context
		if instigator ~= nil then
			self.damage_instigator = instigator
		end
	end)
	ship:setTypeName("Nirvana R3")
	ship:setBeamWeapon(0, 90, -15, 1000.0, 3, 1)	--shorter beams (vs 1200)
	ship:setBeamWeapon(1, 90,  15, 1000.0, 3, 1)	--shorter beams
	ship:setBeamWeapon(2, 90, -50, 1000.0, 3, 1)	--shorter beams
	ship:setBeamWeapon(3, 90,  50, 1000.0, 3, 1)	--shorter beams
	ship:setHullMax(60)								--weaker hull (vs 70)
	ship:setHull(60)
	ship:setShields(40,30)							--weaker shields (vs 50,40)
	ship:setImpulseMaxSpeed(65)						--slower impulse (vs 70)
	local nirvana_r3_db = queryScienceDatabase("Ships","Frigate","Nirvana R3")
	if nirvana_r3_db == nil then
		local frigate_db = queryScienceDatabase("Ships","Frigate")
		frigate_db:addEntry("Nirvana R3")
		nirvana_r3_db = queryScienceDatabase("Ships","Frigate","Nirvana R3")
		addShipToDatabase(
			queryScienceDatabase("Ships","Frigate","Nirvana R5"),	--base ship database entry
			nirvana_r3_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"One of the earliest mass produced Nirvana models, the Nirvana R3 is designed to be used against fighters. It's got several fast, low damage, point defense beam weapons. Compared to the later, more common Nirvana R5, it has shorter beams, weaker shields and hull and a slower impulse drive.",
			nil,
			nil
		)
	end
	return ship
end
function fiendG3(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("Gunship"):orderRoaming()
	ship:onTakingDamage(function(self,instigator)
		string.format("")	--serious proton needs a global context
		if instigator ~= nil then
			self.damage_instigator = instigator
		end
	end)
	ship:setTypeName("Fiend G3")
	ship:setJumpDrive(true)
	ship:setJumpDriveRange(5000,35000)
	local fiend_g3_db = queryScienceDatabase("Ships","Frigate","Fiend G3")
	if fiend_g3_db == nil then
		local frigate_db = queryScienceDatabase("Ships","Frigate")
		frigate_db:addEntry("Fiend G3")
		fiend_g3_db = queryScienceDatabase("Ships","Frigate","Fiend G3")
		addShipToDatabase(
			queryScienceDatabase("Ships","Frigate","Gunship"),	--base ship database entry
			fiend_g3_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"The Fiend G3 was the first model produced by Conversions R Us. They got a good deal on a number of used Gunships. They added a cheap jump drive to the Gunship and viola! they made the Fiend G3. Like the Gunship, it has a homing missile tube and beams to readily take down weaker ships. With the jump drive, it becomes quite a bit more dangerous than the stock Gunship.",
			{
				{key = "Tube 0", value = "8 sec"},	--torpedo tube direction and load speed
			},
			"5 - 35 U"		--jump range
		)
		--[[
		fiend_g3_db:setLongDescription("The Fiend G3 was the first model produced by Conversions R Us. They got a good deal on a number of used Gunships. They added a cheap jump drive to the Gunship and viola! they made the Fiend G3. Like the Gunship, it has a homing missile tube and beams to readily take down weaker ships. With the jump drive, it becomes quite a bit more dangerous than the stock Gunship.")
		fiend_g3_db:setKeyValue("Class","Frigate")
		fiend_g3_db:setKeyValue("Sub-class","Gunship")
		fiend_g3_db:setKeyValue("Size","200")
		fiend_g3_db:setKeyValue("Shield","100/80/80")
		fiend_g3_db:setKeyValue("Hull","100")
		fiend_g3_db:setKeyValue("Move speed","3.6 U/min")
		fiend_g3_db:setKeyValue("Turn speed","5.0 deg/sec")
		fiend_g3_db:setKeyValue("Jump Range","5 - 35 U")
		fiend_g3_db:setKeyValue("Beam weapon -15:50","8.0 Dmg / 6.0 sec")
		fiend_g3_db:setKeyValue("Beam weapon 15:50","8.0 Dmg / 6.0 sec")
		fiend_g3_db:setKeyValue("Tube 0","8 sec")
		fiend_g3_db:setKeyValue("Storage Homing","4")
		fiend_g3_db:setImage("radar_adv_gunship.png")
		--]]
	end
	return ship
end
function fiendG4(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("Gunship"):orderRoaming()
	ship:onTakingDamage(function(self,instigator)
		string.format("")	--serious proton needs a global context
		if instigator ~= nil then
			self.damage_instigator = instigator
		end
	end)
	ship:setTypeName("Fiend G4")
	ship:setWarpDrive(true)
	ship:setWarpSpeed(800)
	local fiend_g4_db = queryScienceDatabase("Ships","Frigate","Fiend G4")
	if fiend_g4_db == nil then
		local frigate_db = queryScienceDatabase("Ships","Frigate")
		frigate_db:addEntry("Fiend G4")
		fiend_g4_db = queryScienceDatabase("Ships","Frigate","Fiend G4")
		addShipToDatabase(
			queryScienceDatabase("Ships","Frigate","Gunship"),	--base ship database entry
			fiend_g4_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"The Fiend G4 was among the first models produced by Conversions R Us. They got a good deal on a number of used Gunships. They added a cheap warp drive to the Gunship and viola! they made the Fiend G4. Like the Gunship, it has a homing missile tube and beams to readily take down weaker ships. With the warp drive, it becomes quite a bit more dangerous than the stock Gunship.",
			{
				{key = "Tube 0", value = "8 sec"},	--torpedo tube direction and load speed
			},
			nil		--jump range
		)
		--[[
		fiend_g4_db:setLongDescription("The Fiend G4 was among the first models produced by Conversions R Us. They got a good deal on a number of used Gunships. They added a cheap warp drive to the Gunship and viola! they made the Fiend G4. Like the Gunship, it has a homing missile tube and beams to readily take down weaker ships. With the warp drive, it becomes quite a bit more dangerous than the stock Gunship.")
		fiend_g4_db:setKeyValue("Class","Frigate")
		fiend_g4_db:setKeyValue("Sub-class","Gunship")
		fiend_g4_db:setKeyValue("Size","200")
		fiend_g4_db:setKeyValue("Shield","100/80/80")
		fiend_g4_db:setKeyValue("Hull","100")
		fiend_g4_db:setKeyValue("Move speed","3.6 U/min")
		fiend_g4_db:setKeyValue("Turn speed","5.0 deg/sec")
		fiend_g4_db:setKeyValue("Warp Speed","48.0 U/min")
		fiend_g4_db:setKeyValue("Beam weapon -15:50","8.0 Dmg / 6.0 sec")
		fiend_g4_db:setKeyValue("Beam weapon 15:50","8.0 Dmg / 6.0 sec")
		fiend_g4_db:setKeyValue("Tube 0","8 sec")
		fiend_g4_db:setKeyValue("Storage Homing","4")
		fiend_g4_db:setImage("radar_adv_gunship.png")
		--]]
	end
	return ship
end
function fiendG5(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("Adv. Gunship"):orderRoaming()
	ship:onTakingDamage(function(self,instigator)
		string.format("")	--serious proton needs a global context
		if instigator ~= nil then
			self.damage_instigator = instigator
		end
	end)
	ship:setTypeName("Fiend G5")
	ship:setJumpDrive(true)
	ship:setJumpDriveRange(5000,35000)
	local fiend_g5_db = queryScienceDatabase("Ships","Frigate","Fiend G5")
	if fiend_g5_db == nil then
		local frigate_db = queryScienceDatabase("Ships","Frigate")
		frigate_db:addEntry("Fiend G5")
		fiend_g5_db = queryScienceDatabase("Ships","Frigate","Fiend G5")
		addShipToDatabase(
			queryScienceDatabase("Ships","Frigate","Gunship"),	--base ship database entry
			fiend_g5_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"With the success of the Fiend G3 and G4 models, Conversions R Us continued their streak with the Fiend G5. They acquired some used Advanced Gunships and added cheap jump drives to them and made the Fiend G5. Like the Advanced Gunship, it has two homing missile tubes and beams to readily take down weaker ships. The jump drive makes it all the more dangerous.",
			{
				{key = "Tube 0", value = "8 sec"},	--torpedo tube direction and load speed
				{key = " Tube 0", value = "8 sec"},	--torpedo tube direction and load speed
			},
			"5 - 35 U"		--jump range
		)
		--[[
		fiend_g5_db:setLongDescription("With the success of the Fiend G3 and G4 models, Conversions R Us continued their streak with the Fiend G5. They acquired some used Advanced Gunships and added cheap jump drives to them and made the Fiend G5. Like the Advanced Gunship, it has two homing missile tubes and beams to readily take down weaker ships. The jump drive makes it all the more dangerous.")
		fiend_g5_db:setKeyValue("Class","Frigate")
		fiend_g5_db:setKeyValue("Sub-class","Gunship")
		fiend_g5_db:setKeyValue("Size","200")
		fiend_g5_db:setKeyValue("Shield","100/80/80")
		fiend_g5_db:setKeyValue("Hull","100")
		fiend_g5_db:setKeyValue("Move speed","3.6 U/min")
		fiend_g5_db:setKeyValue("Turn speed","5.0 deg/sec")
		fiend_g5_db:setKeyValue("Jump Range","5 - 35 U")
		fiend_g5_db:setKeyValue("Beam weapon -15:50","8.0 Dmg / 6.0 sec")
		fiend_g5_db:setKeyValue("Beam weapon 15:50","8.0 Dmg / 6.0 sec")
		fiend_g5_db:setKeyValue("Tube 0","8 sec")
		fiend_g5_db:setKeyValue(" Tube 0","8 sec")
		fiend_g5_db:setKeyValue("Storage Homing","4")
		fiend_g5_db:setImage("radar_adv_gunship.png")
		--]]
	end
	return ship
end
function fiendG6(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("Adv. Gunship"):orderRoaming()
	ship:onTakingDamage(function(self,instigator)
		string.format("")	--serious proton needs a global context
		if instigator ~= nil then
			self.damage_instigator = instigator
		end
	end)
	ship:setTypeName("Fiend G6")
	ship:setWarpDrive(true)
	ship:setWarpSpeed(800)
	local fiend_g6_db = queryScienceDatabase("Ships","Frigate","Fiend G6")
	if fiend_g6_db == nil then
		local frigate_db = queryScienceDatabase("Ships","Frigate")
		frigate_db:addEntry("Fiend G6")
		fiend_g6_db = queryScienceDatabase("Ships","Frigate","Fiend G6")
		addShipToDatabase(
			queryScienceDatabase("Ships","Frigate","Gunship"),	--base ship database entry
			fiend_g6_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"With the success of the Fiend G3 and G4 models, Conversions R Us continued their streak with the Fiend G6. They acquired some used Advanced Gunships and added cheap warp drives to them and made the Fiend G6. Like the Advanced Gunship, it has two homing missile tubes and beams to readily take down weaker ships. The warp drive makes it all the more dangerous.",
			{
				{key = "Tube 0", value = "8 sec"},	--torpedo tube direction and load speed
				{key = " Tube 0", value = "8 sec"},	--torpedo tube direction and load speed
			},
			nil		--jump range
		)
		--[[
		fiend_g6_db:setLongDescription("With the success of the Fiend G3 and G4 models, Conversions R Us continued their streak with the Fiend G6. They acquired some used Advanced Gunships and added cheap warp drives to them and made the Fiend G6. Like the Advanced Gunship, it has two homing missile tubes and beams to readily take down weaker ships. The warp drive makes it all the more dangerous.")
		fiend_g6_db:setKeyValue("Class","Frigate")
		fiend_g6_db:setKeyValue("Sub-class","Gunship")
		fiend_g6_db:setKeyValue("Size","200")
		fiend_g6_db:setKeyValue("Shield","100/80/80")
		fiend_g6_db:setKeyValue("Hull","100")
		fiend_g6_db:setKeyValue("Move speed","3.6 U/min")
		fiend_g6_db:setKeyValue("Turn speed","5.0 deg/sec")
		fiend_g6_db:setKeyValue("Warp Speed","48.0 U/min")
		fiend_g6_db:setKeyValue("Beam weapon -15:50","8.0 Dmg / 6.0 sec")
		fiend_g6_db:setKeyValue("Beam weapon 15:50","8.0 Dmg / 6.0 sec")
		fiend_g6_db:setKeyValue("Tube 0","8 sec")
		fiend_g6_db:setKeyValue(" Tube 0","8 sec")
		fiend_g6_db:setKeyValue("Storage Homing","4")
		fiend_g6_db:setImage("radar_adv_gunship.png")
		--]]
	end
	return ship
end
function k2fighter(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("Ktlitan Fighter"):orderRoaming()
	ship:setTypeName("K2 Fighter")
	ship:setBeamWeapon(0, 60, 0, 1200.0, 2.5, 6)	--beams cycle faster (vs 4.0)
	ship:setHullMax(65)								--weaker hull (vs 70)
	ship:setHull(65)
	local k2_fighter_db = queryScienceDatabase("Ships","No Class","K2 Fighter")
	if k2_fighter_db == nil then
		local no_class_db = queryScienceDatabase("Ships","No Class")
		no_class_db:addEntry("K2 Fighter")
		k2_fighter_db = queryScienceDatabase("Ships","No Class","K2 Fighter")
		addShipToDatabase(
			queryScienceDatabase("Ships","No Class","Ktlitan Fighter"),	--base ship database entry
			k2_fighter_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"Enterprising designers published this design specification based on salvaged Ktlitan Fighters. Comparatively, it's got beams that cycle faster, but the hull is a bit weaker.",
			nil,
			nil		--jump range
		)
		--[[
		k2_fighter_db:setLongDescription("Enterprising designers published this design specification based on salvaged Ktlitan Fighters. Comparatively, it's got beams that cycle faster, but the hull is a bit weaker.")
		k2_fighter_db:setKeyValue("Class","No Class")
		k2_fighter_db:setKeyValue("Sub-class","No Sub-Class")
		k2_fighter_db:setKeyValue("Size","180")
		k2_fighter_db:setKeyValue("Hull","65")
		k2_fighter_db:setKeyValue("Move speed","8.4 U/min")
		k2_fighter_db:setKeyValue("Turn speed","30.0 deg/sec")
		k2_fighter_db:setKeyValue("Beam weapon 0:60","6.0 Dmg / 2.5 sec")
		k2_fighter_db:setImage("radar_ktlitan_fighter.png")
		--]]
	end
	return ship
end	
function k3fighter(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("Ktlitan Fighter"):orderRoaming()
	ship:setTypeName("K3 Fighter")
	ship:setBeamWeapon(0, 60, 0, 1200.0, 2.5, 9)	--beams cycle faster and damage more (vs 4.0 & 6)
	ship:setHullMax(60)								--weaker hull (vs 70)
	ship:setHull(60)
	local k3_fighter_db = queryScienceDatabase("Ships","No Class","K3 Fighter")
	if k3_fighter_db == nil then
		local no_class_db = queryScienceDatabase("Ships","No Class")
		no_class_db:addEntry("K3 Fighter")
		k3_fighter_db = queryScienceDatabase("Ships","No Class","K3 Fighter")
		addShipToDatabase(
			queryScienceDatabase("Ships","No Class","Ktlitan Fighter"),	--base ship database entry
			k3_fighter_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"Enterprising designers published this design specification based on salvaged Ktlitan Fighters. Comparatively, it's got beams that are stronger and that cycle faster, but the hull is weaker.",
			nil,
			nil		--jump range
		)
		--[[
		k3_fighter_db:setLongDescription("Enterprising designers published this design specification based on salvaged Ktlitan Fighters. Comparatively, it's got beams that cycle faster, but the hull is weaker.")
		k3_fighter_db:setKeyValue("Class","No Class")
		k3_fighter_db:setKeyValue("Sub-class","No Sub-Class")
		k3_fighter_db:setKeyValue("Size","180")
		k3_fighter_db:setKeyValue("Hull","60")
		k3_fighter_db:setKeyValue("Move speed","8.4 U/min")
		k3_fighter_db:setKeyValue("Turn speed","30.0 deg/sec")
		k3_fighter_db:setKeyValue("Beam weapon 0:60","9.0 Dmg / 2.5 sec")
		k3_fighter_db:setImage("radar_ktlitan_fighter.png")
		--]]
	end
	return ship
end	
function stalkerQ5(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("Stalker Q7"):orderRoaming()
	ship:onTakingDamage(function(self,instigator)
		string.format("")	--serious proton needs a global context
		if instigator ~= nil then
			self.damage_instigator = instigator
		end
	end)
	ship:setTypeName("Stalker Q5")
	ship:setShieldsMax(50,50)		--weaker shields (vs 80,30,30,30)
	ship:setShields(50,50)
	ship:setHullMax(45)				--weaker hull (vs 50)
	ship:setHull(45)
	ship:setRotationMaxSpeed(15)	--faster maneuver (vs 12)
	local stalker_q5_db = queryScienceDatabase("Ships","Frigate","Stalker Q5")
	if stalker_q5_db == nil then
		local frigate_db = queryScienceDatabase("Ships","Frigate")
		frigate_db:addEntry("Stalker Q5")
		stalker_q5_db = queryScienceDatabase("Ships","Frigate","Stalker Q5")
		addShipToDatabase(
			queryScienceDatabase("Ships","Frigate","Stalker Q7"),	--base ship database entry
			stalker_q5_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"The stalker Q5 predates the Stalker Q7. Like the Q7, the Q5 is designed to swoop into battle, deal damage quickly and retreat. Compared to the Q7, the Q5 has weaker shields and hull, but a faster turn speed",
			nil,
			nil		--jump range
		)
		--[[
		stalker_q5_db:setLongDescription("The stalker Q5 predates the Stalker Q7. Like the Q7, the Q5 is designed to swoop into battle, deal damage quickly and retreat. Compared to the Q7, the Q5 has weaker shields and hull, but a faster turn speed")
		stalker_q5_db:setKeyValue("Class","Frigate")
		stalker_q5_db:setKeyValue("Sub-class","Cruiser: Strike Ship")
		stalker_q5_db:setKeyValue("Size","80")
		stalker_q5_db:setKeyValue("Shield","50/50")
		stalker_q5_db:setKeyValue("Hull","45")
		stalker_q5_db:setKeyValue("Move speed","4.2 U/min")
		stalker_q5_db:setKeyValue("Turn speed","15.0 deg/sec")
		stalker_q5_db:setKeyValue("Warp Speed","42.0 U/min")
		stalker_q5_db:setKeyValue("Beam weapon -5:40","6.0 Dmg / 6.0 sec")
		stalker_q5_db:setKeyValue("Beam weapon 5:40","6.0 Dmg / 6.0 sec")
		stalker_q5_db:setImage("radar_cruiser.png")
		--]]
	end
	return ship
end
function stalkerR5(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("Stalker R7"):orderRoaming()
	ship:onTakingDamage(function(self,instigator)
		string.format("")	--serious proton needs a global context
		if instigator ~= nil then
			self.damage_instigator = instigator
		end
	end)
	ship:setTypeName("Stalker R5")
	ship:setShieldsMax(50,50)		--weaker shields (vs 80,30,30,30)
	ship:setShields(50,50)
	ship:setHullMax(45)				--weaker hull (vs 50)
	ship:setHull(45)
	ship:setRotationMaxSpeed(15)	--faster maneuver (vs 12)
	local stalker_r5_db = queryScienceDatabase("Ships","Frigate","Stalker R5")
	if stalker_r5_db == nil then
		local frigate_db = queryScienceDatabase("Ships","Frigate")
		frigate_db:addEntry("Stalker R5")
		stalker_r5_db = queryScienceDatabase("Ships","Frigate","Stalker R5")
		addShipToDatabase(
			queryScienceDatabase("Ships","Frigate","Stalker R7"),	--base ship database entry
			stalker_r5_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"The stalker R5 predates the Stalker R7. Like the R7, the R5 is designed to swoop into battle, deal damage quickly and retreat. Compared to the R7, the R5 has weaker shields and hull, but a faster turn speed",
			nil,
			nil		--jump range
		)
		--[[
		stalker_r5_db:setLongDescription("The stalker R5 predates the Stalker R7. Like the R7, the R5 is designed to swoop into battle, deal damage quickly and retreat. Compared to the R7, the R5 has weaker shields and hull, but a faster turn speed")
		stalker_r5_db:setKeyValue("Class","Frigate")
		stalker_r5_db:setKeyValue("Sub-class","Cruiser: Strike Ship")
		stalker_r5_db:setKeyValue("Size","80")
		stalker_r5_db:setKeyValue("Shield","50/50")
		stalker_r5_db:setKeyValue("Hull","45")
		stalker_r5_db:setKeyValue("Move speed","4.2 U/min")
		stalker_r5_db:setKeyValue("Turn speed","15.0 deg/sec")
		stalker_r5_db:setKeyValue("Jump Range","5 - 50 U")
		stalker_r5_db:setKeyValue("Beam weapon -5:40","6.0 Dmg / 6.0 sec")
		stalker_r5_db:setKeyValue("Beam weapon 5:40","6.0 Dmg / 6.0 sec")
		stalker_r5_db:setImage("radar_cruiser.png")
		--]]
	end
	return ship
end
function waddle5(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("Adder MK5"):orderRoaming()
	ship:onTakingDamage(function(self,instigator)
		string.format("")	--serious proton needs a global context
		if instigator ~= nil then
			self.damage_instigator = instigator
		end
	end)
	ship:setTypeName("Waddle 5")
	ship:setWarpDrive(true)
--				   Index,  Arc,	  Dir, Range, Cycle,	Damage
	ship:setBeamWeapon(2,	70,	  -30,	 900,	5.0,	2.0)	--adjust beam direction to match starboard side (vs -35)
	local waddle_5_db = queryScienceDatabase("Ships","Starfighter","Waddle 5")
	if waddle_5_db == nil then
		local starfighter_db = queryScienceDatabase("Ships","Starfighter")
		starfighter_db:addEntry("Waddle 5")
		waddle_5_db = queryScienceDatabase("Ships","Starfighter","Waddle 5")
		addShipToDatabase(
			queryScienceDatabase("Ships","Starfighter","Adder MK5"),	--base ship database entry
			waddle_5_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"Conversions R Us purchased a number of Adder MK 5 ships at auction and added warp drives to them to produce the Waddle 5",
			{
				{key = "Small tube 0", value = "15 sec"},	--torpedo tube direction and load speed
			},
			nil		--jump range
		)
		--[[
		waddle_5_db:setLongDescription("Conversions R Us purchased a number of Adder MK 5 ships at auction and added warp drives to them to produce the Waddle 5")
		waddle_5_db:setKeyValue("Class","Starfighter")
		waddle_5_db:setKeyValue("Sub-class","Gunship")
		waddle_5_db:setKeyValue("Size","80")
		waddle_5_db:setKeyValue("Shield","30")
		waddle_5_db:setKeyValue("Hull","50")
		waddle_5_db:setKeyValue("Move speed","4.8 U/min")
		waddle_5_db:setKeyValue("Turn speed","28.0 deg/sec")
		waddle_5_db:setKeyValue("Warp Speed","60.0 U/min")
		waddle_5_db:setKeyValue("Beam weapon 0:35","2.0 Dmg / 5.0 sec")
		waddle_5_db:setKeyValue("Beam weapon 30:70","2.0 Dmg / 5.0 sec")
		waddle_5_db:setKeyValue("Beam weapon -35:70","2.0 Dmg / 5.0 sec")
		waddle_5_db:setImage("radar_fighter.png")
		--]]
	end
	return ship
end
function jade5(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("Adder MK5"):orderRoaming()
	ship:onTakingDamage(function(self,instigator)
		string.format("")	--serious proton needs a global context
		if instigator ~= nil then
			self.damage_instigator = instigator
		end
	end)
	ship:setTypeName("Jade 5")
	ship:setJumpDrive(true)
	ship:setJumpDriveRange(5000,35000)
--				   Index,  Arc,	  Dir, Range, Cycle,	Damage
	ship:setBeamWeapon(2,	70,	  -30,	 900,	5.0,	2.0)	--adjust beam direction to match starboard side (vs -35)
	local jade_5_db = queryScienceDatabase("Ships","Starfighter","Jade 5")
	if jade_5_db == nil then
		local starfighter_db = queryScienceDatabase("Ships","Starfighter")
		starfighter_db:addEntry("Jade 5")
		jade_5_db = queryScienceDatabase("Ships","Starfighter","Jade 5")
		addShipToDatabase(
			queryScienceDatabase("Ships","Starfighter","Adder MK5"),	--base ship database entry
			jade_5_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"Conversions R Us purchased a number of Adder MK 5 ships at auction and added jump drives to them to produce the Jade 5",
			{
				{key = "Small tube 0", value = "15 sec"},	--torpedo tube direction and load speed
			},
			"5 - 35 U"		--jump range
		)
		--[[
		jade_5_db:setLongDescription("Conversions R Us purchased a number of Adder MK 5 ships at auction and added jump drives to them to produce the Jade 5")
		jade_5_db:setKeyValue("Class","Starfighter")
		jade_5_db:setKeyValue("Sub-class","Gunship")
		jade_5_db:setKeyValue("Size","80")
		jade_5_db:setKeyValue("Shield","30")
		jade_5_db:setKeyValue("Hull","50")
		jade_5_db:setKeyValue("Move speed","4.8 U/min")
		jade_5_db:setKeyValue("Turn speed","28.0 deg/sec")
		jade_5_db:setKeyValue("Jump Range","5 - 35 U")
		jade_5_db:setKeyValue("Beam weapon 0:35","2.0 Dmg / 5.0 sec")
		jade_5_db:setKeyValue("Beam weapon 30:70","2.0 Dmg / 5.0 sec")
		jade_5_db:setKeyValue("Beam weapon -35:70","2.0 Dmg / 5.0 sec")
		jade_5_db:setImage("radar_fighter.png")
		--]]
	end
	return ship
end
function droneLite(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("Ktlitan Drone"):orderRoaming()
	ship:setTypeName("Lite Drone")
	ship:setHullMax(20)					--weaker hull (vs 30)
	ship:setHull(20)
	ship:setImpulseMaxSpeed(130)		--faster impulse (vs 120)
	ship:setRotationMaxSpeed(20)		--faster maneuver (vs 10)
	ship:setBeamWeapon(0,40,0,600,4,4)	--weaker (vs 6) beam
	local drone_lite_db = queryScienceDatabase("Ships","No Class","Lite Drone")
	if drone_lite_db == nil then
		local no_class_db = queryScienceDatabase("Ships","No Class")
		no_class_db:addEntry("Lite Drone")
		drone_lite_db = queryScienceDatabase("Ships","No Class","Lite Drone")
		addShipToDatabase(
			queryScienceDatabase("Ships","No Class","Ktlitan Drone"),	--base ship database entry
			drone_lite_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"The light drone was pieced together from scavenged parts of various damaged Ktlitan drones. Compared to the Ktlitan drone, the lite drone has a weaker hull, and a weaker beam, but a faster turn and impulse speed",
			nil,
			nil
		)
		--[[
		drone_lite_db:setLongDescription("The light drone was pieced together from scavenged parts of various damaged Ktlitan drones. Compared to the Ktlitan drone, the lite drone has a weaker hull, and a weaker beam, but a faster turn and impulse speed")
		drone_lite_db:setKeyValue("Class","No Class")
		drone_lite_db:setKeyValue("Sub-class","No Sub-Class")
		drone_lite_db:setKeyValue("Size","150")
		drone_lite_db:setKeyValue("Hull","20")
		drone_lite_db:setKeyValue("Move speed","7.8 U/min")
		drone_lite_db:setKeyValue("Turn speed","20 deg/sec")
		drone_lite_db:setKeyValue("Beam weapon 0:40","4.0 Dmg / 4.0 sec")
		drone_lite_db:setImage("radar_ktlitan_drone.png")
		--]]
	end
	return ship
end
function droneHeavy(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("Ktlitan Drone"):orderRoaming()
	ship:setTypeName("Heavy Drone")
	ship:setHullMax(40)					--stronger hull (vs 30)
	ship:setHull(40)
	ship:setImpulseMaxSpeed(110)		--slower impulse (vs 120)
	ship:setBeamWeapon(0,40,0,600,4,8)	--stronger (vs 6) beam
	local drone_heavy_db = queryScienceDatabase("Ships","No Class","Heavy Drone")
	if drone_heavy_db == nil then
		local no_class_db = queryScienceDatabase("Ships","No Class")
		no_class_db:addEntry("Heavy Drone")
		drone_heavy_db = queryScienceDatabase("Ships","No Class","Heavy Drone")
		addShipToDatabase(
			queryScienceDatabase("Ships","No Class","Ktlitan Drone"),	--base ship database entry
			drone_heavy_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"The heavy drone has a stronger hull and a stronger beam than the normal Ktlitan Drone, but it also moves slower",
			nil,
			nil
		)
		--[[
		drone_heavy_db:setLongDescription("The heavy drone has a stronger hull and a stronger beam than the normal Ktlitan Drone, but it also moves slower")
		drone_heavy_db:setKeyValue("Class","No Class")
		drone_heavy_db:setKeyValue("Sub-class","No Sub-Class")
		drone_heavy_db:setKeyValue("Size","150")
		drone_heavy_db:setKeyValue("Hull","40")
		drone_heavy_db:setKeyValue("Move speed","6.6 U/min")
		drone_heavy_db:setKeyValue("Turn speed","10 deg/sec")
		drone_heavy_db:setKeyValue("Beam weapon 0:40","8.0 Dmg / 4.0 sec")
		drone_heavy_db:setImage("radar_ktlitan_drone.png")
		--]]
	end
	return ship
end
function droneJacket(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("Ktlitan Drone"):orderRoaming()
	ship:onTakingDamage(function(self,instigator)
		string.format("")	--serious proton needs a global context
		if instigator ~= nil then
			self.damage_instigator = instigator
		end
	end)
	ship:setTypeName("Jacket Drone")
	ship:setShieldsMax(20)				--stronger shields (vs none)
	ship:setShields(20)
	ship:setImpulseMaxSpeed(110)		--slower impulse (vs 120)
	ship:setBeamWeapon(0,40,0,600,4,4)	--weaker (vs 6) beam
	local drone_jacket_db = queryScienceDatabase("Ships","No Class","Jacket Drone")
	if drone_jacket_db == nil then
		local no_class_db = queryScienceDatabase("Ships","No Class")
		no_class_db:addEntry("Jacket Drone")
		drone_jacket_db = queryScienceDatabase("Ships","No Class","Jacket Drone")
		addShipToDatabase(
			queryScienceDatabase("Ships","No Class","Ktlitan Drone"),	--base ship database entry
			drone_jacket_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"The Jacket Drone is a Ktlitan Drone with a shield. It's also slightly slower and has a slightly weaker beam due to the energy requirements of the added shield",
			nil,
			nil
		)
		--[[
		drone_jacket_db:setLongDescription("The Jacket Drone is a Ktlitan Drone with a shield. It's also slightly slower and has a slightly weaker beam due to the energy requirements of the added shield")
		drone_jacket_db:setKeyValue("Class","No Class")
		drone_jacket_db:setKeyValue("Sub-class","No Sub-Class")
		drone_jacket_db:setKeyValue("Size","150")
		drone_jacket_db:setKeyValue("Shield","20")
		drone_jacket_db:setKeyValue("Hull","40")
		drone_jacket_db:setKeyValue("Move speed","6.6 U/min")
		drone_jacket_db:setKeyValue("Turn speed","10 deg/sec")
		drone_jacket_db:setKeyValue("Beam weapon 0:40","4.0 Dmg / 4.0 sec")
		drone_jacket_db:setImage("radar_ktlitan_drone.png")
		--]]
	end
	return ship
end
function elaraP2(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("Phobos T3"):orderRoaming()
	ship:setTypeName("Elara P2")
	ship:setWarpDrive(true)			--warp drive (vs none)
	ship:setWarpSpeed(800)
	ship:setShieldsMax(70,40)		--stronger front shield (vs 50,40)
	ship:setShields(70,40)
	local elara_p2_db = queryScienceDatabase("Ships","Frigate","Elara P2")
	if elara_p2_db == nil then
		local frigate_db = queryScienceDatabase("Ships","Frigate")
		frigate_db:addEntry("Elara P2")
		elara_p2_db = queryScienceDatabase("Ships","Frigate","Elara P2")
		addShipToDatabase(
			queryScienceDatabase("Ships","Frigate","Phobos T3"),	--base ship database entry
			elara_p2_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"Inspired by the Phobos T3, the Elara P2 is nearly identical. With the addition of a warp drive and stronger front shields, the Elara P2 poses a greater threat than the Phobos",
			{
				{key = "Tube -1", value = "60 sec"},	--torpedo tube direction and load speed
				{key = "Tube 1", value = "60 sec"},		--torpedo tube direction and load speed
			},
			nil
		)
		--[[
		elara_p2_db:setLongDescription("Inspired by the Phobos T3, the Elara P2 is nearly identical. With the addition of a warp drive and stronger front shields, the Elara P2 poses a greater threat than the Phobos")
		elara_p2_db:setKeyValue("Class","Frigate")
		elara_p2_db:setKeyValue("Sub-class","Cruiser")
		elara_p2_db:setKeyValue("Size","80")
		elara_p2_db:setKeyValue("Shield","70/40")
		elara_p2_db:setKeyValue("Hull","70")
		elara_p2_db:setKeyValue("Move speed","3.6 U/min")
		elara_p2_db:setKeyValue("Turn speed","10.0 deg/sec")
		elara_p2_db:setKeyValue("Warp Speed","48.0 U/min")
		elara_p2_db:setKeyValue("Beam weapon -15:90","6.0 Dmg / 8.0 sec")
		elara_p2_db:setKeyValue("Beam weapon 15:90","6.0 Dmg / 8.0 sec")
		elara_p2_db:setKeyValue("Tube -1","60 sec")
		elara_p2_db:setKeyValue("Tube 1","60 sec")
		elara_p2_db:setKeyValue("Storage Homing","6")
		elara_p2_db:setKeyValue("Storage HVLI","20")
		elara_p2_db:setImage("radar_cruiser.png")
		--]]
	end
	return ship
end
function wzLindworm(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("WX-Lindworm"):orderRoaming()
	ship:setTypeName("WZ-Lindworm")
	ship:setWeaponStorageMax("Nuke",2)		--more nukes (vs 0)
	ship:setWeaponStorage("Nuke",2)
	ship:setWeaponStorageMax("Homing",4)	--more homing (vs 1)
	ship:setWeaponStorage("Homing",4)
	ship:setWeaponStorageMax("HVLI",12)		--more HVLI (vs 6)
	ship:setWeaponStorage("HVLI",12)
	ship:setRotationMaxSpeed(12)			--slower maneuver (vs 15)
	ship:setHullMax(45)						--weaker hull (vs 50)
	ship:setHull(45)
	local wz_lindworm_db = queryScienceDatabase("Ships","Starfighter","WZ-Lindworm")
	if wz_lindworm_db == nil then
		local starfighter_db = queryScienceDatabase("Ships","Starfighter")
		starfighter_db:addEntry("WZ-Lindworm")
		wz_lindworm_db = queryScienceDatabase("Ships","Starfighter","WZ-Lindworm")
		addShipToDatabase(
			queryScienceDatabase("Ships","Starfighter","WX-Lindworm"),	--base ship database entry
			wz_lindworm_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"The WZ-Lindworm is essentially the stock WX-Lindworm with more HVLIs, more homing missiles and added nukes. They had to remove some of the armor to get the additional missiles to fit, so the hull is weaker. Also, the WZ turns a little more slowly than the WX. This little bomber packs quite a whallop.",
			{
				{key = "Small tube 0", value = "15 sec"},	--torpedo tube direction and load speed
				{key = "Small tube 1", value = "15 sec"},	--torpedo tube direction and load speed
				{key = "Small tube -1", value = "15 sec"},	--torpedo tube direction and load speed
			},
			nil
		)
		--[[
		wz_lindworm_db:setLongDescription("The WZ-Lindworm is essentially the stock WX-Lindworm with more HVLIs, more homing missiles and added nukes. They had to remove some of the armor to get the additional missiles to fit, so the hull is weaker. Also, the WZ turns a little more slowly than the WX. This little bomber packs quite a whallop.")
		wz_lindworm_db:setKeyValue("Class","Starfighter")
		wz_lindworm_db:setKeyValue("Sub-class","Bomber")
		wz_lindworm_db:setKeyValue("Size","30")
		wz_lindworm_db:setKeyValue("Shield","20")
		wz_lindworm_db:setKeyValue("Hull","45")
		wz_lindworm_db:setKeyValue("Move speed","3.0 U/min")
		wz_lindworm_db:setKeyValue("Turn speed","12 deg/sec")
		wz_lindworm_db:setKeyValue("Small tube 0","15 sec")
		wz_lindworm_db:setKeyValue("Small tube 1","15 sec")
		wz_lindworm_db:setKeyValue("Small tube -1","15 sec")
		wz_lindworm_db:setKeyValue("Storage Homing","4")
		wz_lindworm_db:setKeyValue("Storage Nuke","2")
		wz_lindworm_db:setKeyValue("Storage HVLI","12")
		wz_lindworm_db:setImage("radar_fighter.png")
		--]]
	end
	return ship
end
function tempest(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("Piranha F12"):orderRoaming()
	ship:onTakingDamage(function(self,instigator)
		string.format("")	--serious proton needs a global context
		if instigator ~= nil then
			self.damage_instigator = instigator
		end
	end)
	ship:setTypeName("Tempest")
	ship:setWeaponTubeCount(10)						--four more tubes (vs 6)
	ship:setWeaponTubeDirection(0, -88)				--5 per side
	ship:setWeaponTubeDirection(1, -89)				--slight angle spread
	ship:setWeaponTubeDirection(3,  88)				--3 for HVLI each side
	ship:setWeaponTubeDirection(4,  89)				--2 for homing and nuke each side
	ship:setWeaponTubeDirection(6, -91)				
	ship:setWeaponTubeDirection(7, -92)				
	ship:setWeaponTubeDirection(8,  91)				
	ship:setWeaponTubeDirection(9,  92)				
	ship:setWeaponTubeExclusiveFor(7,"HVLI")
	ship:setWeaponTubeExclusiveFor(9,"HVLI")
	ship:setWeaponStorageMax("Homing",16)			--more (vs 6)
	ship:setWeaponStorage("Homing", 16)				
	ship:setWeaponStorageMax("Nuke",8)				--more (vs 0)
	ship:setWeaponStorage("Nuke", 8)				
	ship:setWeaponStorageMax("HVLI",34)				--more (vs 20)
	ship:setWeaponStorage("HVLI", 34)
	local tempest_db = queryScienceDatabase("Ships","Frigate","Tempest")
	if tempest_db == nil then
		local frigate_db = queryScienceDatabase("Ships","Frigate")
		frigate_db:addEntry("Tempest")
		tempest_db = queryScienceDatabase("Ships","Frigate","Tempest")
		addShipToDatabase(
			queryScienceDatabase("Ships","Frigate","Piranha F12"),	--base ship database entry
			tempest_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"Loosely based on the Piranha F12 model, the Tempest adds four more broadside tubes (two on each side), more HVLIs, more Homing missiles and 8 Nukes. The Tempest can strike fear into the hearts of your enemies. Get yourself one today!",
			{
				{key = "Large tube -88", value = "15 sec"},	--torpedo tube direction and load speed
				{key = "Tube -89", value = "15 sec"},		--torpedo tube direction and load speed
				{key = "Large tube -90", value = "15 sec"},	--torpedo tube direction and load speed
				{key = "Large tube 88", value = "15 sec"},	--torpedo tube direction and load speed
				{key = "Tube 89", value = "15 sec"},		--torpedo tube direction and load speed
				{key = "Large tube 90", value = "15 sec"},	--torpedo tube direction and load speed
				{key = "Tube -91", value = "15 sec"},		--torpedo tube direction and load speed
				{key = "Tube -92", value = "15 sec"},		--torpedo tube direction and load speed
				{key = "Tube 91", value = "15 sec"},		--torpedo tube direction and load speed
				{key = "Tube 92", value = "15 sec"},		--torpedo tube direction and load speed
			},
			nil
		)
		--[[
		tempest_db:setLongDescription("Loosely based on the Piranha F12 model, the Tempest adds four more broadside tubes (two on each side), more HVLIs, more Homing missiles and 8 Nukes. The Tempest can strike fear into the hearts of your enemies. Get yourself one today!")
		tempest_db:setKeyValue("Class","Frigate")
		tempest_db:setKeyValue("Sub-class","Cruiser: Light Artillery")
		tempest_db:setKeyValue("Size","80")
		tempest_db:setKeyValue("Shield","30/30")
		tempest_db:setKeyValue("Hull","70")
		tempest_db:setKeyValue("Move speed","2.4 U/min")
		tempest_db:setKeyValue("Turn speed","6.0 deg/sec")
		tempest_db:setKeyValue("Large Tube -88","15 sec")
		tempest_db:setKeyValue("Tube -89","15 sec")
		tempest_db:setKeyValue("Large Tube -90","15 sec")
		tempest_db:setKeyValue("Large Tube 88","15 sec")
		tempest_db:setKeyValue("Tube 89","15 sec")
		tempest_db:setKeyValue("Large Tube 90","15 sec")
		tempest_db:setKeyValue("Tube -91","15 sec")
		tempest_db:setKeyValue("Tube -92","15 sec")
		tempest_db:setKeyValue("Tube 91","15 sec")
		tempest_db:setKeyValue("Tube 92","15 sec")
		tempest_db:setKeyValue("Storage Homing","16")
		tempest_db:setKeyValue("Storage Nuke","8")
		tempest_db:setKeyValue("Storage HVLI","34")
		tempest_db:setImage("radar_piranha.png")
		--]]
	end
	return ship
end
function enforcer(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("Blockade Runner"):orderRoaming()
	ship:onTakingDamage(function(self,instigator)
		string.format("")	--serious proton needs a global context
		if instigator ~= nil then
			self.damage_instigator = instigator
		end
	end)
	ship:setTypeName("Enforcer")
	ship:setRadarTrace("radar_ktlitan_destroyer.png")			--different radar trace
	ship:setWarpDrive(true)										--warp (vs none)
	ship:setWarpSpeed(600)
	ship:setImpulseMaxSpeed(100)								--faster impulse (vs 60)
	ship:setRotationMaxSpeed(20)								--faster maneuver (vs 15)
	ship:setShieldsMax(200,100,100)								--stronger shields (vs 100,150)
	ship:setShields(200,100,100)					
	ship:setHullMax(100)										--stronger hull (vs 70)
	ship:setHull(100)
--				   Index,  Arc,	  Dir, Range,	Cycle,	Damage
	ship:setBeamWeapon(0,	30,	  -15,	1500,		6,		10)	--narrower (vs 60), longer (vs 1000), stronger (vs 8)
	ship:setBeamWeapon(1,	30,	   15,	1500,		6,		10)
	ship:setBeamWeapon(2,	 0,	    0,	   0,		0,		 0)	--fewer (vs 4)
	ship:setBeamWeapon(3,	 0,	    0,	   0,		0,		 0)
	ship:setWeaponTubeCount(3)									--more (vs 0)
	ship:setTubeSize(0,"large")									--large (vs normal)
	ship:setWeaponTubeDirection(1,-30)				
	ship:setWeaponTubeDirection(2, 30)				
	ship:setWeaponStorageMax("Homing",18)						--more (vs 0)
	ship:setWeaponStorage("Homing", 18)
	local enforcer_db = queryScienceDatabase("Ships","Frigate","Enforcer")
	if enforcer_db == nil then
		local frigate_db = queryScienceDatabase("Ships","Frigate")
		frigate_db:addEntry("Enforcer")
		enforcer_db = queryScienceDatabase("Ships","Frigate","Enforcer")
		addShipToDatabase(
			queryScienceDatabase("Ships","Frigate","Blockade Runner"),	--base ship database entry
			enforcer_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"The Enforcer is a highly modified Blockade Runner. A warp drive was added and impulse engines boosted along with turning speed. Three missile tubes were added to shoot homing missiles, large ones straight ahead. Stronger shields and hull. Removed rear facing beams and strengthened front beams.",
			{
				{key = "Large tube 0", value = "20 sec"},	--torpedo tube direction and load speed
				{key = "Tube -30", value = "20 sec"},		--torpedo tube direction and load speed
				{key = "Tube 30", value = "20 sec"},		--torpedo tube direction and load speed
			},
			nil
		)
		--[[
		enforcer_db:setLongDescription("The Enforcer is a highly modified Blockade Runner. A warp drive was added and impulse engines boosted along with turning speed. Three missile tubes were added to shoot homing missiles, large ones straight ahead. Stronger shields and hull. Removed rear facing beams and stengthened front beams.")
		enforcer_db:setKeyValue("Class","Frigate")
		enforcer_db:setKeyValue("Sub-class","High Punch")
		enforcer_db:setKeyValue("Size","200")
		enforcer_db:setKeyValue("Shield","200/100/100")
		enforcer_db:setKeyValue("Hull","100")
		enforcer_db:setKeyValue("Move speed","6.0 U/min")
		enforcer_db:setKeyValue("Turn speed","20.0 deg/sec")
		enforcer_db:setKeyValue("Warp Speed","36.0 U/min")
		enforcer_db:setKeyValue("Beam weapon -15:30","10.0 Dmg / 6.0 sec")
		enforcer_db:setKeyValue("Beam weapon 15:30","10.0 Dmg / 6.0 sec")
		enforcer_db:setKeyValue("Large Tube 0","20 sec")
		enforcer_db:setKeyValue("Tube -30","20 sec")
		enforcer_db:setKeyValue("Tube 30","20 sec")
		enforcer_db:setKeyValue("Storage Homing","18")
		--]]
		enforcer_db:setImage("radar_ktlitan_destroyer.png")		--override default radar image
	end
	return ship		
end
function predator(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("Piranha F8"):orderRoaming()
	ship:onTakingDamage(function(self,instigator)
		string.format("")	--serious proton needs a global context
		if instigator ~= nil then
			self.damage_instigator = instigator
		end
	end)
	ship:setTypeName("Predator")
	ship:setShieldsMax(100,100)									--stronger shields (vs 30,30)
	ship:setShields(100,100)					
	ship:setHullMax(80)											--stronger hull (vs 70)
	ship:setHull(80)
	ship:setImpulseMaxSpeed(65)									--faster impulse (vs 40)
	ship:setRotationMaxSpeed(15)								--faster maneuver (vs 6)
	ship:setJumpDrive(true)
	ship:setJumpDriveRange(5000,35000)			
--				   Index,  Arc,	  Dir, Range,	Cycle,	Damage
	ship:setBeamWeapon(0,	90,	    0,	1000,		6,		 4)	--more (vs 0)
	ship:setBeamWeapon(1,	90,	  180,	1000,		6,		 4)	
	ship:setWeaponTubeCount(8)									--more (vs 3)
	ship:setWeaponTubeDirection(0,-60)				
	ship:setWeaponTubeDirection(1,-90)				
	ship:setWeaponTubeDirection(2,-90)				
	ship:setWeaponTubeDirection(3, 60)				
	ship:setWeaponTubeDirection(4, 90)				
	ship:setWeaponTubeDirection(5, 90)				
	ship:setWeaponTubeDirection(6,-120)				
	ship:setWeaponTubeDirection(7, 120)				
	ship:setWeaponTubeExclusiveFor(0,"Homing")
	ship:setWeaponTubeExclusiveFor(1,"Homing")
	ship:setWeaponTubeExclusiveFor(2,"Homing")
	ship:setWeaponTubeExclusiveFor(3,"Homing")
	ship:setWeaponTubeExclusiveFor(4,"Homing")
	ship:setWeaponTubeExclusiveFor(5,"Homing")
	ship:setWeaponTubeExclusiveFor(6,"Homing")
	ship:setWeaponTubeExclusiveFor(7,"Homing")
	ship:setWeaponStorageMax("Homing",32)						--more (vs 5)
	ship:setWeaponStorage("Homing", 32)		
	ship:setWeaponStorageMax("HVLI",0)							--less (vs 10)
	ship:setWeaponStorage("HVLI", 0)
	ship:setRadarTrace("radar_missile_cruiser.png")				--different radar trace
	local predator_db = queryScienceDatabase("Ships","Frigate","Predator")
	if predator_db == nil then
		local frigate_db = queryScienceDatabase("Ships","Frigate")
		frigate_db:addEntry("Predator")
		predator_db = queryScienceDatabase("Ships","Frigate","Predator")
		addShipToDatabase(
			queryScienceDatabase("Ships","Frigate","Piranha F8"),	--base ship database entry
			predator_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"The Predator is a significantly improved Piranha F8. Stronger shields and hull, faster impulse and turning speeds, a jump drive, beam weapons, eight missile tubes pointing in six directions and a large number of homing missiles to shoot.",
			{
				{key = "Large tube -60", value = "12 sec"},	--torpedo tube direction and load speed
				{key = "Tube -90", value = "12 sec"},		--torpedo tube direction and load speed
				{key = "Large tube -90", value = "12 sec"},	--torpedo tube direction and load speed
				{key = "Large tube 60", value = "12 sec"},	--torpedo tube direction and load speed
				{key = "Tube 90", value = "12 sec"},		--torpedo tube direction and load speed
				{key = "Large tube 90", value = "12 sec"},	--torpedo tube direction and load speed
				{key = "Tube -120", value = "12 sec"},		--torpedo tube direction and load speed
				{key = "Tube 120", value = "12 sec"},		--torpedo tube direction and load speed
			},
			"5 - 35 U"		--jump range
		)
		--[[
		predator_db:setLongDescription("The Predator is a significantly improved Piranha F8. Stronger shields and hull, faster impulse and turning speeds, a jump drive, beam weapons, eight missile tubes pointing in six directions and a large number of homing missiles to shoot.")
		predator_db:setKeyValue("Class","Frigate")
		predator_db:setKeyValue("Sub-class","Cruiser: Light Artillery")
		predator_db:setKeyValue("Size","80")
		predator_db:setKeyValue("Shield","100/100")
		predator_db:setKeyValue("Hull","80")
		predator_db:setKeyValue("Move speed","3.9 U/min")
		predator_db:setKeyValue("Turn speed","15.0 deg/sec")
		predator_db:setKeyValue("Jump Range","5 - 35 U")
		predator_db:setKeyValue("Beam weapon 0:90","4.0 Dmg / 6.0 sec")
		predator_db:setKeyValue("Beam weapon 180:90","4.0 Dmg / 6.0 sec")
		predator_db:setKeyValue("Large Tube -60","12 sec")
		predator_db:setKeyValue("Tube -90","12 sec")
		predator_db:setKeyValue("Large Tube -90","12 sec")
		predator_db:setKeyValue("Large Tube 60","12 sec")
		predator_db:setKeyValue("Tube 90","12 sec")
		predator_db:setKeyValue("Large Tube 90","12 sec")
		predator_db:setKeyValue("Tube -120","12 sec")
		predator_db:setKeyValue("Tube 120","12 sec")
		predator_db:setKeyValue("Storage Homing","32")
		--]]
		predator_db:setImage("radar_missile_cruiser.png")		--override default radar image
	end
	return ship		
end
function atlantisY42(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("Atlantis X23"):orderRoaming()
	ship:onTakingDamage(function(self,instigator)
		string.format("")	--serious proton needs a global context
		if instigator ~= nil then
			self.damage_instigator = instigator
		end
	end)
	ship:setTypeName("Atlantis Y42")
	ship:setShieldsMax(300,200,300,200)							--stronger shields (vs 200,200,200,200)
	ship:setShields(300,200,300,200)					
	ship:setImpulseMaxSpeed(65)									--faster impulse (vs 30)
	ship:setRotationMaxSpeed(15)								--faster maneuver (vs 3.5)
--				   Index,  Arc,	  Dir, Range,	Cycle,	Damage
	ship:setBeamWeapon(2,	80,	  190,	1500,		6,		 8)	--narrower (vs 100)
	ship:setBeamWeapon(3,	80,	  170,	1500,		6,		 8)	--extra (vs 3 beams)
	ship:setWeaponStorageMax("Homing",16)						--more (vs 4)
	ship:setWeaponStorage("Homing", 16)
	local atlantis_y42_db = queryScienceDatabase("Ships","Corvette","Atlantis Y42")
	if atlantis_y42_db == nil then
		local corvette_db = queryScienceDatabase("Ships","Corvette")
		corvette_db:addEntry("Atlantis Y42")
		atlantis_y42_db = queryScienceDatabase("Ships","Corvette","Atlantis Y42")
		addShipToDatabase(
			queryScienceDatabase("Ships","Corvette","Atlantis X23"),	--base ship database entry
			atlantis_y42_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"The Atlantis Y42 improves on the Atlantis X23 with stronger shields, faster impulse and turn speeds, an extra beam in back and a larger missile stock",
			{
				{key = "Tube -90", value = "10 sec"},	--torpedo tube direction and load speed
				{key = " Tube -90", value = "10 sec"},	--torpedo tube direction and load speed
				{key = "Tube 90", value = "10 sec"},	--torpedo tube direction and load speed
				{key = " Tube 90", value = "10 sec"},	--torpedo tube direction and load speed
			},
			"5 - 50 U"		--jump range
		)
		--[[
		atlantis_y42_db:setLongDescription("The Atlantis Y42 improves on the Atlantis X23 with stronger shields, faster impulse and turn speeds, an extra beam in back and a larger missile stock")
		atlantis_y42_db:setKeyValue("Class","Corvette")
		atlantis_y42_db:setKeyValue("Sub-class","Destroyer")
		atlantis_y42_db:setKeyValue("Size","200")
		atlantis_y42_db:setKeyValue("Shield","300/200/300/200")
		atlantis_y42_db:setKeyValue("Hull","100")
		atlantis_y42_db:setKeyValue("Move speed","3.9 U/min")
		atlantis_y42_db:setKeyValue("Turn speed","15.0 deg/sec")
		atlantis_y42_db:setKeyValue("Jump Range","5 - 50 U")
		atlantis_y42_db:setKeyValue("Beam weapon -20:100","8.0 Dmg / 6.0 sec")
		atlantis_y42_db:setKeyValue("Beam weapon 20:100","8.0 Dmg / 6.0 sec")
		atlantis_y42_db:setKeyValue("Beam weapon 190:100","8.0 Dmg / 6.0 sec")
		atlantis_y42_db:setKeyValue("Beam weapon 170:100","8.0 Dmg / 6.0 sec")
		atlantis_y42_db:setKeyValue("Tube -90","10 sec")
		atlantis_y42_db:setKeyValue(" Tube -90","10 sec")
		atlantis_y42_db:setKeyValue("Tube 90","10 sec")
		atlantis_y42_db:setKeyValue(" Tube 90","10 sec")
		atlantis_y42_db:setKeyValue("Storage Homing","4")
		atlantis_y42_db:setKeyValue("Storage HVLI","20")
		atlantis_y42_db:setImage("radar_dread.png")
		--]]
	end
	return ship		
end
function starhammerV(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("Starhammer II"):orderRoaming()
	ship:onTakingDamage(function(self,instigator)
		string.format("")	--serious proton needs a global context
		if instigator ~= nil then
			self.damage_instigator = instigator
		end
	end)
	ship:setTypeName("Starhammer V")
	ship:setImpulseMaxSpeed(65)									--faster impulse (vs 35)
	ship:setRotationMaxSpeed(15)								--faster maneuver (vs 6)
	ship:setShieldsMax(450, 350, 250, 250, 350)					--stronger shields (vs 450, 350, 150, 150, 350)
	ship:setShields(450, 350, 250, 250, 350)					
--				   Index,  Arc,	  Dir, Range,	Cycle,	Damage
	ship:setBeamWeapon(4,	60,	  180,	1500,		8,		11)	--extra rear facing beam
	ship:setWeaponStorageMax("Homing",16)						--more (vs 4)
	ship:setWeaponStorage("Homing", 16)		
	ship:setWeaponStorageMax("HVLI",36)							--more (vs 20)
	ship:setWeaponStorage("HVLI", 36)
	local starhammer_v_db = queryScienceDatabase("Ships","Corvette","Starhammer V")
	if starhammer_v_db == nil then
		local corvette_db = queryScienceDatabase("Ships","Corvette")
		corvette_db:addEntry("Starhammer V")
		starhammer_v_db = queryScienceDatabase("Ships","Corvette","Starhammer V")
		addShipToDatabase(
			queryScienceDatabase("Ships","Corvette","Starhammer II"),	--base ship database entry
			starhammer_v_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"The Starhammer V recognizes common modifications made in the field to the Starhammer II: stronger shields, faster impulse and turning speeds, additional rear beam and more missiles to shoot. These changes make the Starhammer V a force to be reckoned with.",
			{
				{key = "Tube 0", value = "10 sec"},	--torpedo tube direction and load speed
				{key = " Tube 0", value = "10 sec"},	--torpedo tube direction and load speed
			},
			"5 - 50 U"		--jump range
		)
		--[[
		starhammer_v_db:setLongDescription("The Starhammer V recognizes common modifications made in the field to the Starhammer II: stronger shields, faster impulse and turning speeds, additional rear beam and more missiles to shoot. These changes make the Starhammer V a force to be reckoned with.")
		starhammer_v_db:setKeyValue("Class","Corvette")
		starhammer_v_db:setKeyValue("Sub-class","Destroyer")
		starhammer_v_db:setKeyValue("Size","200")
		starhammer_v_db:setKeyValue("Shield","450/350/250/250/350")
		starhammer_v_db:setKeyValue("Hull","200")
		starhammer_v_db:setKeyValue("Move speed","3.9 U/min")
		starhammer_v_db:setKeyValue("Turn speed","15.0 deg/sec")
		starhammer_v_db:setKeyValue("Jump Range","5 - 50 U")
		starhammer_v_db:setKeyValue("Beam weapon -10:60","11.0 Dmg / 8.0 sec")
		starhammer_v_db:setKeyValue("Beam weapon 10:60","11.0 Dmg / 8.0 sec")
		starhammer_v_db:setKeyValue("Beam weapon -20:60","11.0 Dmg / 8.0 sec")
		starhammer_v_db:setKeyValue("Beam weapon 20:60","11.0 Dmg / 8.0 sec")
		starhammer_v_db:setKeyValue("Beam weapon 180:60","11.0 Dmg / 8.0 sec")
		starhammer_v_db:setKeyValue("Tube 0","10 sec")
		starhammer_v_db:setKeyValue(" Tube 0","10 sec")
		starhammer_v_db:setKeyValue("Storage Homing","16")
		starhammer_v_db:setKeyValue("Storage EMP","2")
		starhammer_v_db:setKeyValue("Storage HVLI","36")
		starhammer_v_db:setImage("radar_dread.png")
		--]]
	end
	return ship		
end
function tyr(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("Battlestation"):orderRoaming()
	ship:onTakingDamage(function(self,instigator)
		string.format("")	--serious proton needs a global context
		if instigator ~= nil then
			self.damage_instigator = instigator
		end
	end)
	ship:setTypeName("Tyr")
	ship:setImpulseMaxSpeed(50)									--faster impulse (vs 30)
	ship:setRotationMaxSpeed(10)								--faster maneuver (vs 1.5)
	ship:setShieldsMax(400, 300, 300, 400, 300, 300)			--stronger shields (vs 300, 300, 300, 300, 300)
	ship:setShields(400, 300, 300, 400, 300, 300)					
	ship:setHullMax(100)										--stronger hull (vs 70)
	ship:setHull(100)
--				   Index,  Arc,	  Dir, Range,	Cycle,	Damage
	ship:setBeamWeapon(0,	90,	  -60,	2500,		6,		 8)	--stronger beams, broader coverage
	ship:setBeamWeapon(1,	90,	 -120,	2500,		6,		 8)
	ship:setBeamWeapon(2,	90,	   60,	2500,		6,		 8)
	ship:setBeamWeapon(3,	90,	  120,	2500,		6,		 8)
	ship:setBeamWeapon(4,	90,	  -60,	2500,		6,		 8)
	ship:setBeamWeapon(5,	90,	 -120,	2500,		6,		 8)
	ship:setBeamWeapon(6,	90,	   60,	2500,		6,		 8)
	ship:setBeamWeapon(7,	90,	  120,	2500,		6,		 8)
	ship:setBeamWeapon(8,	90,	  -60,	2500,		6,		 8)
	ship:setBeamWeapon(9,	90,	 -120,	2500,		6,		 8)
	ship:setBeamWeapon(10,	90,	   60,	2500,		6,		 8)
	ship:setBeamWeapon(11,	90,	  120,	2500,		6,		 8)
	local tyr_db = queryScienceDatabase("Ships","Dreadnought","Tyr")
	if tyr_db == nil then
		local corvette_db = queryScienceDatabase("Ships","Dreadnought")
		corvette_db:addEntry("Tyr")
		tyr_db = queryScienceDatabase("Ships","Dreadnought","Tyr")
		addShipToDatabase(
			queryScienceDatabase("Ships","Dreadnought","Battlestation"),	--base ship database entry
			tyr_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"The Tyr is the shipyard's answer to admiral konstatz' casual statement that the Battlestation model was too slow to be effective. The shipyards improved on the Battlestation by fitting the Tyr with more than twice the impulse speed and more than six times the turn speed. They threw in stronger shields and hull and wider beam coverage just to show that they could",
			nil,
			"5 - 50 U"		--jump range
		)
		--[[
		tyr_db:setLongDescription("The Tyr is the shipyard's answer to admiral konstatz' casual statement that the Battlestation model was too slow to be effective. The shipyards improved on the Battlestation by fitting the Tyr with more than twice the impulse speed and more than six times the turn speed. They threw in stronger shields and hull and wider beam coverage just to show that they could")
		tyr_db:setKeyValue("Class","Dreadnought")
		tyr_db:setKeyValue("Sub-class","Assault")
		tyr_db:setKeyValue("Size","200")
		tyr_db:setKeyValue("Shield","400/300/300/400/300/300")
		tyr_db:setKeyValue("Hull","100")
		tyr_db:setKeyValue("Move speed","3.0 U/min")
		tyr_db:setKeyValue("Turn speed","10.0 deg/sec")
		tyr_db:setKeyValue("Jump Range","5 - 50 U")
		tyr_db:setKeyValue("Beam weapon -60:90","8.0 Dmg / 6.0 sec")
		tyr_db:setKeyValue("Beam weapon -120:90","8.0 Dmg / 6.0 sec")
		tyr_db:setKeyValue("Beam weapon 60:90","8.0 Dmg / 6.0 sec")
		tyr_db:setKeyValue("Beam weapon 120:90","8.0 Dmg / 6.0 sec")
		tyr_db:setKeyValue(" Beam weapon -60:90","8.0 Dmg / 6.0 sec")
		tyr_db:setKeyValue(" Beam weapon -120:90","8.0 Dmg / 6.0 sec")
		tyr_db:setKeyValue(" Beam weapon 60:90","8.0 Dmg / 6.0 sec")
		tyr_db:setKeyValue(" Beam weapon 120:90","8.0 Dmg / 6.0 sec")
		tyr_db:setKeyValue("  Beam weapon -60:90","8.0 Dmg / 6.0 sec")
		tyr_db:setKeyValue("  Beam weapon -120:90","8.0 Dmg / 6.0 sec")
		tyr_db:setKeyValue("  Beam weapon 60:90","8.0 Dmg / 6.0 sec")
		tyr_db:setKeyValue("  Beam weapon 120:90","8.0 Dmg / 6.0 sec")
		tyr_db:setImage("radar_battleship.png")
		--]]
	end
	return ship
end
function gnat(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("Ktlitan Drone"):orderRoaming()
	ship:setTypeName("Gnat")
	ship:setHullMax(15)					--weaker hull (vs 30)
	ship:setHull(15)
	ship:setImpulseMaxSpeed(140)		--faster impulse (vs 120)
	ship:setRotationMaxSpeed(25)		--faster maneuver (vs 10)
--				   Index,  Arc,	  Dir, Range,	Cycle,	Damage
	ship:setBeamWeapon(0,   40,		0,	 600,		4,		 3)	--weaker (vs 6) beam
	local gnat_db = queryScienceDatabase("Ships","No Class","Gnat")
	if gnat_db == nil then
		local no_class_db = queryScienceDatabase("Ships","No Class")
		no_class_db:addEntry("Gnat")
		gnat_db = queryScienceDatabase("Ships","No Class","Gnat")
		addShipToDatabase(
			queryScienceDatabase("Ships","No Class","Gnat"),	--base ship database entry
			gnat_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"The Gnat is a nimbler version of the Ktlitan Drone. It's got half the hull, but it moves and turns faster",
			nil,
			nil		--jump range
		)
	end
	return ship
end
function cucaracha(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("Tug"):orderRoaming()
	ship:onTakingDamage(function(self,instigator)
		string.format("")	--serious proton needs a global context
		if instigator ~= nil then
			self.damage_instigator = instigator
		end
	end)
	ship:setTypeName("Cucaracha")
	ship:setShieldsMax(200, 50, 50, 50, 50, 50)		--stronger shields (vs 20)
	ship:setShields(200, 50, 50, 50, 50, 50)					
	ship:setHullMax(100)							--stronger hull (vs 50)
	ship:setHull(100)
	ship:setRotationMaxSpeed(20)					--faster maneuver (vs 10)
	ship:setAcceleration(30)						--faster acceleration (vs 15)
--				   Index,  Arc,	  Dir, Range,	Cycle,	Damage
	ship:setBeamWeapon(0,	60,	    0,	1500,		6,		10)	--extra rear facing beam
	local cucaracha_db = queryScienceDatabase("Ships","No Class","Cucaracha")
	if cucaracha_db == nil then
		local no_class_db = queryScienceDatabase("Ships","No Class")
		no_class_db:addEntry("Cucaracha")
		cucaracha_db = queryScienceDatabase("Ships","No Class","Cucaracha")
		addShipToDatabase(
			queryScienceDatabase("Ships","No Class","Cucaracha"),	--base ship database entry
			cucaracha_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"The Cucaracha is a quick ship built around the Tug model with heavy shields and a heavy beam designed to be difficult to squash",
			nil,
			nil		--jump range
		)
	end
	return ship
end
function starhammerIII(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("Starhammer II"):orderRoaming()
	ship:onTakingDamage(function(self,instigator)
		string.format("")	--serious proton needs a global context
		if instigator ~= nil then
			self.damage_instigator = instigator
		end
	end)
	ship:setTypeName("Starhammer III")
--				   Index,  Arc,	  Dir, Range,	Cycle,	Damage
	ship:setBeamWeapon(4,	60,	  180,	1500,		8,		11)	--extra rear facing beam
	ship:setTubeSize(0,"large")
	ship:setWeaponStorageMax("Homing",16)						--more (vs 4)
	ship:setWeaponStorage("Homing", 16)		
	ship:setWeaponStorageMax("HVLI",36)							--more (vs 20)
	ship:setWeaponStorage("HVLI", 36)
	local starhammer_iii_db = queryScienceDatabase("Ships","Corvette","Starhammer III")
	if starhammer_iii_db == nil then
		local corvette_db = queryScienceDatabase("Ships","Corvette")
		corvette_db:addEntry("Starhammer III")
		starhammer_iii_db = queryScienceDatabase("Ships","Corvette","Starhammer III")
		addShipToDatabase(
			queryScienceDatabase("Ships","Corvette","Starhammer III"),	--base ship database entry
			starhammer_iii_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"The designers of the Starhammer III took the Starhammer II and added a rear facing beam, enlarged one of the missile tubes and added more missiles to fire",
			{
				{key = "Large tube 0", value = "10 sec"},	--torpedo tube direction and load speed
				{key = "Tube 0", value = "10 sec"},			--torpedo tube direction and load speed
			},
			"5 - 50 U"		--jump range
		)
	end
	return ship
end
function k2breaker(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("Ktlitan Breaker"):orderRoaming()
	ship:onTakingDamage(function(self,instigator)
		string.format("")	--serious proton needs a global context
		if instigator ~= nil then
			self.damage_instigator = instigator
		end
	end)
	ship:setTypeName("K2 Breaker")
	ship:setHullMax(200)							--stronger hull (vs 120)
	ship:setHull(200)
	ship:setWeaponTubeCount(3)						--more (vs 1)
	ship:setTubeSize(0,"large")						--large (vs normal)
	ship:setWeaponTubeDirection(1,-30)				
	ship:setWeaponTubeDirection(2, 30)
	ship:setWeaponTubeExclusiveFor(0,"HVLI")		--only HVLI (vs any)
	ship:setWeaponStorageMax("Homing",16)			--more (vs 0)
	ship:setWeaponStorage("Homing", 16)
	ship:setWeaponStorageMax("HVLI",8)				--more (vs 5)
	ship:setWeaponStorage("HVLI", 8)
	local k2_breaker_db = queryScienceDatabase("Ships","No Class","K2 Breaker")
	if k2_breaker_db == nil then
		local no_class_db = queryScienceDatabase("Ships","No Class")
		no_class_db:addEntry("K2 Breaker")
		k2_breaker_db = queryScienceDatabase("Ships","No Class","K2 Breaker")
		addShipToDatabase(
			queryScienceDatabase("Ships","No Class","K2 Breaker"),	--base ship database entry
			k2_breaker_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"The K2 Breaker designers took the Ktlitan Breaker and beefed up the hull, added two bracketing tubes, enlarged the center tube and added more missiles to shoot. Should be good for a couple of enemy ships",
			{
				{key = "Large tube 0", value = "13 sec"},	--torpedo tube direction and load speed
				{key = "Tube -30", value = "13 sec"},		--torpedo tube direction and load speed
				{key = "Tube 30", value = "13 sec"},		--torpedo tube direction and load speed
			},
			nil
		)
	end
	return ship
end
function hurricane(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("Piranha F8"):orderRoaming()
	ship:onTakingDamage(function(self,instigator)
		string.format("")	--serious proton needs a global context
		if instigator ~= nil then
			self.damage_instigator = instigator
		end
	end)
	ship:setTypeName("Hurricane")
	ship:setJumpDrive(true)
	ship:setJumpDriveRange(5000,40000)			
	ship:setWeaponTubeCount(8)						--more (vs 3)
	ship:setWeaponTubeExclusiveFor(1,"HVLI")		--only HVLI (vs any)
	ship:setWeaponTubeDirection(1,  0)				--forward (vs -90)
	ship:setTubeSize(3,"large")						
	ship:setWeaponTubeDirection(3,-90)
	ship:setTubeSize(4,"small")
	ship:setWeaponTubeExclusiveFor(4,"Homing")
	ship:setWeaponTubeDirection(4,-15)
	ship:setTubeSize(5,"small")
	ship:setWeaponTubeExclusiveFor(5,"Homing")
	ship:setWeaponTubeDirection(5, 15)
	ship:setWeaponTubeExclusiveFor(6,"Homing")
	ship:setWeaponTubeDirection(6,-30)
	ship:setWeaponTubeExclusiveFor(7,"Homing")
	ship:setWeaponTubeDirection(7, 30)
	ship:setWeaponStorageMax("Homing",24)			--more (vs 5)
	ship:setWeaponStorage("Homing", 24)
	local hurricane_db = queryScienceDatabase("Ships","Frigate","Hurricane")
	if hurricane_db == nil then
		local frigate_db = queryScienceDatabase("Ships","Frigate")
		frigate_db:addEntry("Hurricane")
		hurricane_db = queryScienceDatabase("Ships","Frigate","Hurricane")
		addShipToDatabase(
			queryScienceDatabase("Ships","Frigate","Hurricane"),	--base ship database entry
			hurricane_db,	--modified ship database entry
			ship,			--ship just created, long description on the next line
			"The Hurricane is designed to jump in and shower the target with missiles. It is based on the Piranha F8, but with a jump drive, five more tubes in various directions and sizes and lots more missiles to shoot",
			{
				{key = "Large tube 0", value = "12 sec"},	--torpedo tube direction and load speed
				{key = "Tube 0", value = "12 sec"},			--torpedo tube direction and load speed
				{key = "Large tube 90", value = "12 sec"},	--torpedo tube direction and load speed
				{key = "Large tube -90", value = "12 sec"},	--torpedo tube direction and load speed
				{key = "Small tube -15", value = "12 sec"},	--torpedo tube direction and load speed
				{key = "Small tube 15", value = "12 sec"},	--torpedo tube direction and load speed
				{key = "Tube -30", value = "12 sec"},		--torpedo tube direction and load speed
				{key = "Tube 30", value = "12 sec"},		--torpedo tube direction and load speed
			},
			"5 - 40 U"		--jump range
		)
	end
	return ship
end
function addShipToDatabase(base_db,modified_db,ship,description,tube_directions,jump_range)
	modified_db:setLongDescription(description)
	modified_db:setImage(base_db:getImage())
	modified_db:setKeyValue("Class",base_db:getKeyValue("Class"))
	modified_db:setKeyValue("Sub-class",base_db:getKeyValue("Sub-class"))
	modified_db:setKeyValue("Size",base_db:getKeyValue("Size"))
	local shields = ship:getShieldCount()
	if shields > 0 then
		local shield_string = ""
		for i=1,shields do
			if shield_string == "" then
				shield_string = string.format("%i",math.floor(ship:getShieldMax(i-1)))
			else
				shield_string = string.format("%s/%i",shield_string,math.floor(ship:getShieldMax(i-1)))
			end
		end
		modified_db:setKeyValue("Shield",shield_string)
	end
	modified_db:setKeyValue("Hull",string.format("%i",math.floor(ship:getHullMax())))
	modified_db:setKeyValue("Move speed",string.format("%.1f u/min",ship:getImpulseMaxSpeed()*60/1000))
	modified_db:setKeyValue("Turn speed",string.format("%.1f deg/sec",ship:getRotationMaxSpeed()))
	if ship:hasJumpDrive() then
		if jump_range == nil then
			local base_jump_range = base_db:getKeyValue("Jump range")
			if base_jump_range ~= nil and base_jump_range ~= "" then
				modified_db:setKeyValue("Jump range",base_jump_range)
			else
				modified_db:setKeyValue("Jump range","5 - 50 u")
			end
		else
			modified_db:setKeyValue("Jump range",jump_range)
		end
	end
	if ship:hasWarpDrive() then
		modified_db:setKeyValue("Warp Speed",string.format("%.1f u/min",ship:getWarpSpeed()*60/1000))
	end
	local key = ""
	if ship:getBeamWeaponRange(0) > 0 then
		local bi = 0
		repeat
			local beam_direction = ship:getBeamWeaponDirection(bi)
			if beam_direction > 315 and beam_direction < 360 then
				beam_direction = beam_direction - 360
			end
			key = string.format("Beam weapon %i:%i",ship:getBeamWeaponDirection(bi),ship:getBeamWeaponArc(bi))
			while(modified_db:getKeyValue(key) ~= "") do
				key = " " .. key
			end
			modified_db:setKeyValue(key,string.format("%.1f Dmg / %.1f sec",ship:getBeamWeaponDamage(bi),ship:getBeamWeaponCycleTime(bi)))
			bi = bi + 1
		until(ship:getBeamWeaponRange(bi) < 1)
	end
	local tubes = ship:getWeaponTubeCount()
	if tubes > 0 then
		if tube_directions ~= nil then
			for i=1,#tube_directions do
				modified_db:setKeyValue(tube_directions[i].key,tube_directions[i].value)
			end
		end
		local missile_types = {'Homing', 'Nuke', 'Mine', 'EMP', 'HVLI'}
		for _, missile_type in ipairs(missile_types) do
			local max_storage = ship:getWeaponStorageMax(missile_type)
			if max_storage > 0 then
				modified_db:setKeyValue(string.format("Storage %s",missile_type),string.format("%i",max_storage))
			end
		end
	end
end
--not included in random fleet spawn lists
function leech(enemyFaction)
	local ship = CpuShip():setTemplate("Defense platform"):setFaction(enemyFaction):orderRoaming()
	ship:setTypeName("Leech")
--               			Arc,  Dir, Range,   CycleTime, Dmg
	ship:setBeamWeapon(0,	 30,	0,	4000,			2,	20)	--slower cycle time  (2,4,4,4,6) vs 1.5
	ship:setBeamWeapon(1,	120,    0,	2000,			4,	10)	--wider arc (120,120,120,330) vs 30
	ship:setBeamWeapon(1,	120,  -60,	2000,			4,	10)	--shorter range (2k,2k,2k, 1k) vs 4k
	ship:setBeamWeapon(2,	120,   60,	2000,			4,	10)	--different directions (-60, 180) vs evenly spaced
	ship:setBeamWeapon(3,	330,  180,	1000,			6,	10)	--less damage (10, 10, 10, 10) vs 20
	ship:setBeamWeapon(4,	  0,    0,	   0,			0,	 0)	--missing vs present
	ship:setBeamWeapon(5,	  0,    0,	   0,			0,	 0)	--missing vs present
	ship:setRotationMaxSpeed(10)								--faster turn speed (vs .5)
	ship:setShieldsMax(300,100)									--fewer shields (2) vs 120,120,120,120,120,120
	ship:setShields(300,100)									--shield strength variance
	return ship
end
function overclocker(enemyFaction)
	local ship = CpuShip():setFaction(enemyFaction):setTemplate("Equipment Freighter 1"):orderRoaming()
	ship:setTypeName("overclocker")
	ship:setShieldsMax(150,150,150)
	ship:setShields(150,150,150) -- high shields, slightly unusual number of arcs (3)
	ship:setRotationMaxSpeed(20)
	ship:setImpulseMaxSpeed(100)
	return ship
end
function beamOverclocker(enemyFaction)
	local ship = overclocker(enemyFaction)
	ship:setDescription("beam overclocker")-- there seems to be some sort of bug with descriptions - the fully scanned is not showing with setDescriptions, this is a work around, it should be fixed in EE at some point
	ship:setDescriptions("sending encrypted data","sending encrypted data to boost beams of nearby ships")
	update_system:addBeamOverclocker(ship,10)
	return ship
end
function engineOverclocker(enemyFaction)
	local ship = overclocker(enemyFaction)
	ship:setDescription("engine overclocker")-- there seems to be some sort of bug with descriptions - the fully scanned is not showing with setDescriptions, this is a work around, it should be fixed in EE at some point
	ship:setDescriptions("sending encrypted data","sending encrypted data to boost engines of nearby ships")
	update_system:addEngineOverclocker(ship,10)
	return ship
end
function shieldOverclocker(enemyFaction)
	local ship = overclocker(enemyFaction)
	ship:setDescription("shield overclocker")-- there seems to be some sort of bug with descriptions - the fully scanned is not showing with setDescriptions, this is a work around, it should be fixed in EE at some point
	ship:setDescriptions("sending encrypted data","sending encrypted data to boost shields of nearby ships")
	update_system:addShieldOverclocker(ship,10)
	return ship
end
function overclockOptimizer(enemyFaction)
	-- the boost is only cosmetic / only GM controlled at this time
	local ship = overclocker(enemyFaction)
	ship:setDescription("overclocker optimizer")-- there seems to be some sort of bug with descriptions - the fully scanned is not showing with setDescriptions, this is a work around, it should be fixed in EE at some point
	ship:setDescriptions("sending encrypted data","sending encrypted data to boost overclockers of allied ships")
	ship:setTypeName("unshackled mind")
	ship:setShieldsMax(300,300,300)
	ship:setShields(300,300,300)
	update_system:addOverclockOptimizer(ship,20)
	return ship
end
function orbiterOverclocker(enemyFaction)
	-- internally these are marked as orbiter overclockers
	-- externally they are marked as tractor overlockers
	-- this is as the only tractor ship supported are the orbiting craft
	local ship = overclocker(enemyFaction)
	ship:setDescription("tractor overclocker")-- there seems to be some sort of bug with descriptions - the fully scanned is not showing with setDescriptions, this is a work around, it should be fixed in EE at some point
	ship:setDescriptions("sending encrypted data","sending encrypted data to boost tractor beams of nearby ships")
	update_system:addOrbitingOverclocker(ship,10)
	return ship
end
function orbiter(enemyFaction)
	local ship  = CpuShip():setFaction(enemyFaction):setTemplate("Tug"):orderRoaming()
	ship:setDescription("A large number of tractor beams are detected aboard")
	ship:setShieldsMax(50,50)
	ship:setShields(50,50)
	ship:setRotationMaxSpeed(10)
	ship:setImpulseMaxSpeed(50)
	return ship
end
function mineOrbiter(enemyFaction)
	print("in mine orbiter function")
	local ship = orbiter(enemyFaction)
	update_system:addOverclockableTractor(ship,Mine)
	return ship
end
function asteroidOrbiter(enemyFaction)
	print("in asteroid orbiter function")
	local ship = orbiter(enemyFaction)
	update_system:addOverclockableTractor(ship,Asteroid)
	return ship
end
--	*											   *  --
--	**											  **  --
--	************************************************  --
--	****				Order Fleet				****  --
--	************************************************  --
--	**											  **  --
--	*											   *  --
------------------------------------------------------------------
--	Order Fleet > Select Fleet (Select Fleet To Give Order To)  --
------------------------------------------------------------------
-- -ORDER FLEET		F	orderFleet
-- Button for each fleet, numbered and with a representative ship name
function selectOrderFleet()
	clearGMFunctions()
	addGMFunction("-Order Fleet",orderFleet)
	for i=1,8 do
		local fl = fleetList[i]
		if fl ~= nil then
			local sample_name = ""
			local fleet_member = nil
			local member_index = 0
			for j=1,#fl do
				fleet_member = fl[j]
				member_index = j
				if fleet_member ~= nil and fleet_member:isValid() then
					sample_name = fleet_member:getCallSign()
					break
				end
			end
			addGMFunction(string.format("%i %s",i,sample_name),function()
				selected_fleet_representative = fleet_member
				selected_fleet_index = i
				selected_fleet_representative_index = member_index
				orderFleet()
			end)
		end
	end
end
------------------------------------------------------------
--	Order Fleet > Roaming (Set Order For Selected Fleet)  --
------------------------------------------------------------
-- Button Text	   FD*	Related Function(s)
-- ROAMING*			*	inline, orderFleet		asterisk = current selection
-- IDLE 			*	inline, orderFleet		
-- STAND GROUND		*	inline, orderFleet
-- ATTACK			*	inline, orderFleet
-- DEFEND			*	inline, orderFleet
-- FLY TO			*	inline, orderFleet
-- FLY BLINDLY TO	*	inline, orderFleet
-- DOCK				*	inline, orderFleet
-- +FLY FORMATION	*	inline, orderFlyFormation
function changeFleetOrder()
	clearGMFunctions()
	--addGMFunction("-Order Fleet",orderFleet)
	local order_roaming = "Roaming"
	if existing_fleet_order == "Roaming" then
		order_roaming = "Roaming*"
	end
	addGMFunction(order_roaming,function()
		existing_fleet_order = "Roaming"
		orderFleet()
	end)
	local order_idle = "Idle"
	if existing_fleet_order == "Idle" then
		order_idle = "Idle*"
	end
	addGMFunction(order_idle,function()
		existing_fleet_order = "Idle"
		orderFleet()
	end)
	local order_stand_ground = "Stand Ground"
	if existing_fleet_order == "Stand Ground" then
		order_stand_ground = "Stand Ground*"
	end
	addGMFunction(order_stand_ground,function()
		existing_fleet_order = "Stand Ground"
		orderFleet()
	end)
	local order_attack = "Attack"
	if existing_fleet_order == "Attack" then
		order_attack = "Attack*"
	end
	addGMFunction(order_attack,function()
		existing_fleet_order = "Attack"
		orderFleet()
	end)
	local order_defend = "Defend"
	if existing_fleet_order == "Defend" then
		order_defend = "Defend*"
	end
	addGMFunction(order_defend,function()
		existing_fleet_order = "Defend"
		orderFleet()
	end)
	local order_fly_to = "Fly To"
	if existing_fleet_order == "Fly To" then
		order_fly_to = "Fly To*"
	end
	addGMFunction(order_fly_to,function()
		existing_fleet_order = "Fly To"
		orderFleet()
	end)
	local order_fly_blindly_to = "Fly Blindly To"
	if existing_fleet_order == "Fly Blindly To" then
		order_fly_blindly_to = "Fly Blindly To*"
	end
	addGMFunction(order_fly_blindly_to,function()
		existing_fleet_order = "Fly Blindly To"
		orderFleet()
	end)
	local order_dock = "Dock"
	if existing_fleet_order == "Dock" then
		order_dock = "Dock*"
	end
	addGMFunction(order_dock,function()
		existing_fleet_order = "Dock"
		orderFleet()
	end)
	local order_fly_formation = "Fly Formation"
	if existing_fleet_order == "Fly Formation" then
		order_fly_formation = "Fly Formation*"
	end
	addGMFunction(string.format("+%s",order_fly_formation),flyFormationParameters)
end
----------------------------------------------------------------------------
--	Order Fleet > Roaming (Set Order For Selected Fleet) > Fly Formation  --
----------------------------------------------------------------------------
-- Button Text	   FD*	Related Function(s)
-- -MAIN			F	initialGMFunctions
-- -ORDER FLEET		F	orderFleet
-- +FORMATION V		D	changeFormation
-- +LEAD shipname	D	changeFormationLead
function flyFormationParameters()
	existing_fleet_order = "Fly Formation"
	if formation_type == nil then
		formation_type = "V"
	end
	if formation_lead == nil then
		formation_lead = selected_fleet_representative
		formation_lead_index = selected_fleet_representative_index
	end
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Order Fleet",orderFleet)
	addGMFunction(string.format("+Formation %s",formation_type),changeFormation)
	if formation_lead ~= nil then
		addGMFunction(string.format("+Lead %s",formation_lead:getCallSign()),changeFormationLead)
	end
end
----------------------------------------------------------------------------------------
--	Order Fleet > Roaming (Set Order For Selected Fleet) > Fly Formation > Formation  --
----------------------------------------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- FORMATION V*			*	inline, flyFormationParameters		asterisk = current selection
-- FORMATION A			*	inline, flyFormationParameters
-- FORMATION CIRCLE		*	inline, flyFormationParameters
-- FORMATION SQUARE		*	inline, flyFormationParameters
function changeFormation()
	clearGMFunctions()
	local formation_v = "V"
	if formation_type == "V" then
		formation_v = "V*"
	end
	addGMFunction(string.format("Formation %s",formation_v),function()
		formation_type = "V"
		flyFormationParameters()
	end)
	local formation_a = "A"
	if formation_type == "A" then
		formation_a = "A*"
	end
	addGMFunction(string.format("Formation %s",formation_a),function()
		formation_type = "A"
		flyFormationParameters()
	end)
	local formation_circle = "circle"
	if formation_type == "circle" then
		formation_circle = "circle*"
	end
	addGMFunction(string.format("Formation %s",formation_circle),function()
		formation_type = "circle"
		flyFormationParameters()
	end)
	local formation_square = "square"
	if formation_type == "square" then
		formation_square = "square*"
	end
	addGMFunction(string.format("Formation %s",formation_square),function()
		formation_type = "square"
		flyFormationParameters()
	end)
end
----------------------------------------------------------------------------------------
--	Order Fleet > Roaming (Set Order For Selected Fleet) > Fly Formation > Lead Ship  --
----------------------------------------------------------------------------------------
-- Button for each ship in the selected fleet including ship name.
function changeFormationLead()
	clearGMFunctions()
	if fleetList ~= nil and #fleetList > 0 then
		if selected_fleet_index ~= nil and selected_fleet_index > 0 then
			local fl = fleetList[selected_fleet_index]
			if fl ~= nil then
				local fleet_member = nil
				local fleet_member_count = 0
				--local member_index = 0
				for j=1,#fl do
					fleet_member = fl[j]
					--member_index = j
					if fleet_member ~= nil and fleet_member:isValid() then
						fleet_member_count = fleet_member_count + 1
						addGMFunction(fleet_member:getCallSign(),function()
							formation_lead = fleet_member
							flyFormationParameters()
						end)
					end
				end
				if fleet_member_count < 1 then
					addGMMessage("No valid members in selected fleet")
				end
			else
				addGMMessage("selected fleet is nil")
			end
		else
			addGMMessage("No selected fleet")
		end
	else
		addGMMessage("No fleets spawned")
	end
end
------------------------------------------------------------------------------------------------------
--	Order Fleet > Reorganize Fleet (Take Elements From Existing Fleets and Combine Into New Fleet)  --
------------------------------------------------------------------------------------------------------
-- Incomplete 
function orderFleetChange()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-From Reorg Flt",orderFleet)
	local object_list = getGMSelection()
	local cpu_ship_count = 0
	local cpu_ship_faction = nil
	local factions_match = true
	local new_fleet = {}
	for i=1,#object_list do
		local current_selected_object = object_list[i]
		if current_selected_object.typeName == "CpuShip" then
			cpu_ship_count = cpu_ship_count + 1
			local current_faction = current_selected_object:getFaction()
			if cpu_ship_faction == nil then
				cpu_ship_faction = current_faction
			else
				if current_faction ~= cpu_ship_faction then
					factions_match = false
				end
			end
			table.insert(new_fleet,current_selected_object)
		end
	end
	if cpu_ship_count < 1 then
		addGMMessage("no ships selected")
	elseif not factions_match then
		addGMMessage("Ships selected are not all the same faction")
	end
	addGMMessage("incomplete function. Need to complete later")
end
-------------------------------------
--	Order fleet > Average Impulse  --
-------------------------------------
-- Button Text			   FD*	Related Function(s)
-- -MAIN FROM AVG IMP		F	initialGMFunctions
-- -ORDER FLEET				F	orderFleet
-- SELECTED SHIPS			F	inline
-- 1 ship-in-fleet			D	inline
function averageImpulse()
	clearGMFunctions()
	addGMFunction("-Main from Avg Imp",initialGMFunctions)
	addGMFunction("-Order Fleet",orderFleet)
	addGMFunction("Selected ships",function()
		local object_list = getGMSelection()
		if #object_list < 1 then
			addGMMessage("Average impulse failed - nothing selected. No action taken") 
			return
		end
		local selected_matches_npc_ship = true
		for i=1,#object_list do
			local current_selected_object = object_list[i]
			if current_selected_object.typeName ~= "CpuShip" then
				selected_matches_npc_ship = false
				break
			end
		end
		if selected_matches_npc_ship then
			local avg_impulse = 0
			for i=1,#object_list do
				avg_impulse = avg_impulse + object_list[i]:getImpulseMaxSpeed()
			end
			avg_impulse = avg_impulse/#object_list
			for i=1,#object_list do
				object_list[i]:setImpulseMaxSpeed(avg_impulse)
			end
			addGMMessage(string.format("Changed %i selected ships' max impulse to %.1f",#object_list,avg_impulse))
		else
			addGMMessage("Something other than a CpuShip was selected. No action taken")
		end
	end)
	local select_fleet_label = "Select Fleet"
	if selected_fleet_representative ~= nil and selected_fleet_representative:isValid() then
		if selected_fleet_index ~= nil and fleetList[selected_fleet_index] ~= nil then
			local fl = fleetList[selected_fleet_index]
			if fl ~= nil then
				if selected_fleet_representative_index ~= nil then
					if selected_fleet_representative == fl[selected_fleet_representative_index] then
						select_fleet_label = string.format("%i %s",selected_fleet_index,selected_fleet_representative:getCallSign())
					end
				end
			end
		end
	end
	if select_fleet_label ~= "Select Fleet" then
		addGMFunction(string.format("%s",select_fleet_label),function()
			local avg_impulse = 0
			local ship_count = 0
			for _, fm in pairs(fleetList[selected_fleet_index]) do
				if fm ~= nil and fm:isValid() then
					avg_impulse = avg_impulse + fm:getImpulseMaxSpeed()
					ship_count = ship_count + 1
				end
			end
			avg_impulse = avg_impulse/ship_count
			for _, fm in pairs(fleetList[selected_fleet_index]) do
				if fm ~= nil and fm:isValid() then
					fm:setImpulseMaxSpeed(avg_impulse)
				end
			end
			addGMMessage(string.format("Changed max impulse of %i ships in fleet %i to %.1f",ship_count,selected_fleet_index,avg_impulse))
		end)
	end
end
--Order fleet to be idle - do nothing
function orderFleetIdle()
	clearGMFunctions()
	addGMFunction("-Main from Ord Idle",initialGMFunctions)
	addGMFunction("-Order Fleet",orderFleet)
	for i=1,8 do
		local fl = fleetList[i]
		if fl ~= nil then
			local sampleName = ""
			for j=1,#fl do
				local fm = fl[j]
				if fm ~= nil and fm:isValid() then
					sampleName = fm:getCallSign()
					break
				end
			end
			local GMOrderFleetIdle = string.format("%i %s",i,sampleName)
			addGMFunction(GMOrderFleetIdle, function () orderFleetIdleGivenFleet(fleetList[i]) end)
		else
			break
		end
	end
end
function orderFleetIdleGivenFleet(fto)
	for _, fm in pairs(fto) do
		if fm ~= nil and fm:isValid() then
			fm:orderIdle()
		end
	end	
end
--Order fleet to roam, attack any and all enemies
function orderFleetRoaming()
	clearGMFunctions()
	addGMFunction("-Main from Ord Roam",initialGMFunctions)
	addGMFunction("-Order Fleet",orderFleet)
	for i=1,8 do
		local fl = fleetList[i]
		if fl ~= nil then
			local sampleName = ""
			for j=1,#fl do
				local fm = fl[j]
				if fm ~= nil and fm:isValid() then
					sampleName = fm:getCallSign()
					break
				end
			end
			GMOrderFleetRoaming = string.format("%i %s",i,sampleName)
			addGMFunction(GMOrderFleetRoaming,function () orderFleetRoamingGivenFleet(fleetList[i]) end)
		else
			break
		end
	end
end
function orderFleetRoamingGivenFleet(fto)
	for _, fm in pairs(fto) do
		if fm ~= nil and fm:isValid() then
			fm:orderRoaming()	--set fleet member order
		end
	end
end
--Order fleet to stand ground, attacking nearby enemies
function orderFleetStandGround()
	clearGMFunctions()
	addGMFunction("-Main from Ord Stnd",initialGMFunctions)
	addGMFunction("-Order Fleet",orderFleet)
	for i=1,8 do
		local fl = fleetList[i]
		if fl ~= nil then
			local sampleName = ""
			for j=1,#fl do
				local fm = fl[j]
				if fm ~= nil and fm:isValid() then
					sampleName = fm:getCallSign()
					break
				end
			end
			GMOrderFleetStandGround = string.format("%i %s",i,sampleName)
			addGMFunction(GMOrderFleetStandGround,function () orderFleetStandGroundGivenFleet(fleetList[i]) end)
		else
			break
		end
	end
end
function orderFleetStandGroundGivenFleet(fto)
	for _, fm in pairs(fto) do
		if fm ~= nil and fm:isValid() then
			fm:orderStandGround()
		end
	end	
end
--Order fleet to attack GM selected object
function orderFleetAttack()
	clearGMFunctions()
	addGMFunction("-Main from Ord Attk",initialGMFunctions)
	addGMFunction("-Order Fleet",orderFleet)
	for i=1,8 do
		local fl = fleetList[i]
		if fl ~= nil then
			local sampleName = ""
			for j=1,#fl do
				local fm = fl[j]
				if fm ~= nil and fm:isValid() then
					sampleName = fm:getCallSign()
					break
				end
			end
			GMOrderFleetAttack = string.format("%i %s",i,sampleName)
			addGMFunction(GMOrderFleetAttack,attackFleetFunction[i])
		else
			break
		end
	end
end
function orderFleetAttack1()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		print("Need to select a target for fleet to attack")
		return
	end
	local fto = fleetList[1]
	for _, fm in pairs(fto) do
		if fm ~= nil and fm:isValid() then
			fm:orderAttack(objectList[1])
		end
	end
end
function orderFleetAttack2()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		print("Need to select a target for fleet to attack")
		return
	end
	local fto = fleetList[2]
	for _, fm in pairs(fto) do
		if fm ~= nil and fm:isValid() then
			fm:orderAttack(objectList[1])
		end
	end
end
function orderFleetAttack3()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		print("Need to select a target for fleet to attack")
		return
	end
	local fto = fleetList[3]
	for _, fm in pairs(fto) do
		if fm ~= nil and fm:isValid() then
			fm:orderAttack(objectList[1])
		end
	end
end
function orderFleetAttack4()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		print("Need to select a target for fleet to attack")
		return
	end
	local fto = fleetList[4]
	for _, fm in pairs(fto) do
		if fm ~= nil and fm:isValid() then
			fm:orderAttack(objectList[1])
		end
	end
end
function orderFleetAttack5()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		print("Need to select a target for fleet to attack")
		return
	end
	local fto = fleetList[5]
	for _, fm in pairs(fto) do
		if fm ~= nil and fm:isValid() then
			fm:orderAttack(objectList[1])
		end
	end
end
function orderFleetAttack6()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		print("Need to select a target for fleet to attack")
		return
	end
	local fto = fleetList[6]
	for _, fm in pairs(fto) do
		if fm ~= nil and fm:isValid() then
			fm:orderAttack(objectList[1])
		end
	end
end
function orderFleetAttack7()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		print("Need to select a target for fleet to attack")
		return
	end
	local fto = fleetList[7]
	for _, fm in pairs(fto) do
		if fm ~= nil and fm:isValid() then
			fm:orderAttack(objectList[1])
		end
	end
end
function orderFleetAttack8()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		print("Need to select a target for fleet to attack")
		return
	end
	local fto = fleetList[8]
	for _, fm in pairs(fto) do
		if fm ~= nil and fm:isValid() then
			fm:orderAttack(objectList[1])
		end
	end
end
--Order fleet to defend GM selected object
function orderFleetDefend()
	clearGMFunctions()
	addGMFunction("Bk2Main from Order Flt",initialGMFunctions)
	addGMFunction("Back to Order Fleet",orderFleet)
	for i=1,8 do
		local fl = fleetList[i]
		if fl ~= nil then
			local sampleName = ""
			for j=1,#fl do
				local fm = fl[j]
				if fm ~= nil and fm:isValid() then
					sampleName = fm:getCallSign()
					break
				end
			end
			GMOrderFleetDefend = string.format("%i %s",i,sampleName)
			addGMFunction(GMOrderFleetDefend,defendFleetFunction[i])
		else
			break
		end
	end
end
function orderFleetDefend1()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		print("Need to select a target for fleet to defend")
		return
	end
	local fto = fleetList[1]
	for _, fm in pairs(fto) do
		if fm ~= nil and fm:isValid() then
			fm:orderDefendTarget(objectList[1])
		end
	end
end
function orderFleetDefend2()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		print("Need to select a target for fleet to defend")
		return
	end
	local fto = fleetList[2]
	for _, fm in pairs(fto) do
		if fm ~= nil and fm:isValid() then
			fm:orderDefendTarget(objectList[1])
		end
	end
end
function orderFleetDefend3()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		print("Need to select a target for fleet to defend")
		return
	end
	local fto = fleetList[3]
	for _, fm in pairs(fto) do
		if fm ~= nil and fm:isValid() then
			fm:orderDefendTarget(objectList[1])
		end
	end
end
function orderFleetDefend4()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		print("Need to select a target for fleet to defend")
		return
	end
	local fto = fleetList[4]
	for _, fm in pairs(fto) do
		if fm ~= nil and fm:isValid() then
			fm:orderDefendTarget(objectList[1])
		end
	end
end
function orderFleetDefend5()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		print("Need to select a target for fleet to defend")
		return
	end
	local fto = fleetList[5]
	for _, fm in pairs(fto) do
		if fm ~= nil and fm:isValid() then
			fm:orderDefendTarget(objectList[1])
		end
	end
end
function orderFleetDefend6()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		print("Need to select a target for fleet to defend")
		return
	end
	local fto = fleetList[6]
	for _, fm in pairs(fto) do
		if fm ~= nil and fm:isValid() then
			fm:orderDefendTarget(objectList[1])
		end
	end
end
function orderFleetDefend7()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		print("Need to select a target for fleet to defend")
		return
	end
	local fto = fleetList[7]
	for _, fm in pairs(fto) do
		if fm ~= nil and fm:isValid() then
			fm:orderDefendTarget(objectList[1])
		end
	end
end
function orderFleetDefend8()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		print("Need to select a target for fleet to defend")
		return
	end
	local fto = fleetList[8]
	for _, fm in pairs(fto) do
		if fm ~= nil and fm:isValid() then
			fm:orderDefendTarget(objectList[1])
		end
	end
end
--Order fleet to fly to selected object(s)
function orderFleetFly()
	clearGMFunctions()
	addGMFunction("Bk2Main from Order Flt",initialGMFunctions)
	addGMFunction("Back to Order Fleet",orderFleet)
	for i=1,8 do
		local fl = fleetList[i]
		if fl ~= nil then
			local sampleName = ""
			for j=1,#fl do
				local fm = fl[j]
				if fm ~= nil and fm:isValid() then
					sampleName = fm:getCallSign()
					break
				end
			end
			GMOrderFleetFly = string.format("%i %s",i,sampleName)
			addGMFunction(GMOrderFleetFly,flyFleetFunction[i])
		else
			break
		end
	end
end
function orderGivenFleetToFly(fto)
	local flyx = 0
	local flyy = 0
	local objectList = getGMSelection()
	if #objectList == 1 then
		flyx, flyy = objectList[1]:getPosition()
	else
		flyx, flyy = centerOfSelected(objectList)
	end
	for _, fm in pairs(fto) do
		if fm ~= nil and fm:isValid() then
			fm:orderFlyTowards(flyx,flyy)
		end
	end
end
function orderFleetFly1()
	local objectList = getGMSelection()
	if #objectList < 1 then
		print("Need to select something for fleet to fly to")
		return
	end
	local fto = fleetList[1]
	orderGivenFleetToFly(fto)
end
function orderFleetFly2()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		print("Need to select something for fleet to fly to")
		return
	end
	local fto = fleetList[2]
	orderGivenFleetToFly(fto)
end
function orderFleetFly3()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		print("Need to select something for fleet to fly to")
		return
	end
	local fto = fleetList[3]
	orderGivenFleetToFly(fto)
end
function orderFleetFly4()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		print("Need to select something for fleet to fly to")
		return
	end
	local fto = fleetList[4]
	orderGivenFleetToFly(fto)
end
function orderFleetFly5()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		print("Need to select something for fleet to fly to")
		return
	end
	local fto = fleetList[5]
	orderGivenFleetToFly(fto)
end
function orderFleetFly6()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		print("Need to select something for fleet to fly to")
		return
	end
	local fto = fleetList[6]
	orderGivenFleetToFly(fto)
end
function orderFleetFly7()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		print("Need to select something for fleet to fly to")
		return
	end
	local fto = fleetList[7]
	orderGivenFleetToFly(fto)
end
function orderFleetFly8()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		print("Need to select something for fleet to fly to")
		return
	end
	local fto = fleetList[8]
	orderGivenFleetToFly(fto)
end
--Order fleet to fly blind to selected object(s)
function orderFleetFlyBlind()
	clearGMFunctions()
	addGMFunction("Bk2Main from Order Flt",initialGMFunctions)
	addGMFunction("Back to Order Fleet",orderFleet)
	for i=1,8 do
		local fl = fleetList[i]
		if fl ~= nil then
			local sampleName = ""
			for j=1,#fl do
				local fm = fl[j]
				if fm ~= nil and fm:isValid() then
					sampleName = fm:getCallSign()
					break
				end
			end
			GMOrderFleetFlyBlind = string.format("%i %s",i,sampleName)
			addGMFunction(GMOrderFleetFlyBlind,flyBlindFleetFunction[i])
		else
			break
		end
	end
end
function orderGivenFleetToFlyBlind(fto)
	local flyx = 0
	local flyy = 0
	local objectList = getGMSelection()
	if #objectList == 1 then
		flyx, flyy = objectList[1]:getPosition()
	else
		flyx, flyy = centerOfSelected(objectList)
	end
	for _, fm in pairs(fto) do
		if fm ~= nil and fm:isValid() then
			fm:orderFlyTowardsBlind(flyx,flyy)
		end
	end
end
function orderFleetFlyBlind1()
	local objectList = getGMSelection()
	if #objectList < 1 then
		print("Need to select something for fleet to fly blind to")
		return
	end
	local fto = fleetList[1]
	orderGivenFleetToFlyBlind(fto)
end
function orderFleetFlyBlind2()
	local objectList = getGMSelection()
	if #objectList < 1 then
		print("Need to select something for fleet to fly blind to")
		return
	end
	local fto = fleetList[2]
	orderGivenFleetToFlyBlind(fto)
end
function orderFleetFlyBlind3()
	local objectList = getGMSelection()
	if #objectList < 1 then
		print("Need to select something for fleet to fly blind to")
		return
	end
	local fto = fleetList[3]
	orderGivenFleetToFlyBlind(fto)
end
function orderFleetFlyBlind4()
	local objectList = getGMSelection()
	if #objectList < 1 then
		print("Need to select something for fleet to fly blind to")
		return
	end
	local fto = fleetList[4]
	orderGivenFleetToFlyBlind(fto)
end
function orderFleetFlyBlind5()
	local objectList = getGMSelection()
	if #objectList < 1 then
		print("Need to select something for fleet to fly blind to")
		return
	end
	local fto = fleetList[5]
	orderGivenFleetToFlyBlind(fto)
end
function orderFleetFlyBlind6()
	local objectList = getGMSelection()
	if #objectList < 1 then
		print("Need to select something for fleet to fly blind to")
		return
	end
	local fto = fleetList[6]
	orderGivenFleetToFlyBlind(fto)
end
function orderFleetFlyBlind7()
	local objectList = getGMSelection()
	if #objectList < 1 then
		print("Need to select something for fleet to fly blind to")
		return
	end
	local fto = fleetList[7]
	orderGivenFleetToFlyBlind(fto)
end
function orderFleetFlyBlind8()
	local objectList = getGMSelection()
	if #objectList < 1 then
		print("Need to select something for fleet to fly blind to")
		return
	end
	local fto = fleetList[8]
	orderGivenFleetToFlyBlind(fto)
end
--Order fleet to dock at selected object
function orderFleetDock()
	clearGMFunctions()
	addGMFunction("Bk2Main from Order Flt",initialGMFunctions)
	addGMFunction("Back to Order Fleet",orderFleet)
	for i=1,8 do
		local fl = fleetList[i]
		if fl ~= nil then
			local sampleName = ""
			for j=1,#fl do
				local fm = fl[j]
				if fm ~= nil and fm:isValid() then
					sampleName = fm:getCallSign()
					break
				end
			end
			GMOrderFleetDock = string.format("%i %s",i,sampleName)
			addGMFunction(GMOrderFleetDock,dockFleetFunction[i])
		else
			break
		end
	end
end
function orderFleetDock1()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		print("Need to select a docking target for fleet")
		return
	end
	local fto = fleetList[1]
	for _, fm in pairs(fto) do
		if fm ~= nil and fm:isValid() then
			fm:orderDock(objectList[1])
		end
	end
end
function orderFleetDock2()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		print("Need to select a docking target for fleet")
		return
	end
	local fto = fleetList[2]
	for _, fm in pairs(fto) do
		if fm ~= nil and fm:isValid() then
			fm:orderDock(objectList[1])
		end
	end
end
function orderFleetDock3()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		print("Need to select a docking target for fleet")
		return
	end
	local fto = fleetList[3]
	for _, fm in pairs(fto) do
		if fm ~= nil and fm:isValid() then
			fm:orderDock(objectList[1])
		end
	end
end
function orderFleetDock4()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		print("Need to select a docking target for fleet")
		return
	end
	local fto = fleetList[4]
	for _, fm in pairs(fto) do
		if fm ~= nil and fm:isValid() then
			fm:orderDock(objectList[1])
		end
	end
end
function orderFleetDock5()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		print("Need to select a docking target for fleet")
		return
	end
	local fto = fleetList[5]
	for _, fm in pairs(fto) do
		if fm ~= nil and fm:isValid() then
			fm:orderDock(objectList[1])
		end
	end
end
function orderFleetDock6()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		print("Need to select a docking target for fleet")
		return
	end
	local fto = fleetList[6]
	for _, fm in pairs(fto) do
		if fm ~= nil and fm:isValid() then
			fm:orderDock(objectList[1])
		end
	end
end
function orderFleetDock7()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		print("Need to select a docking target for fleet")
		return
	end
	local fto = fleetList[7]
	for _, fm in pairs(fto) do
		if fm ~= nil and fm:isValid() then
			fm:orderDock(objectList[1])
		end
	end
end
function orderFleetDock8()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		print("Need to select a docking target for fleet")
		return
	end
	local fto = fleetList[8]
	for _, fm in pairs(fto) do
		if fm ~= nil and fm:isValid() then
			fm:orderDock(objectList[1])
		end
	end
end
--	*											   *  --
--	**											  **  --
--	************************************************  --
--	****				Drop Point				****  --
--	************************************************  --
--	**											  **  --
--	*											   *  --
-------------------------------
--	Drop Point > Escape Pod  --
-------------------------------
-- Button Text		   DF*	Related Function(s)
-- -MAIN FROM ESC POD	F	initialGMFunctions
-- -FROM ESCAPE POD		F	dropPoint
-- +AT CLICK			D	setDropPointLocation
-- PLACE POD			D	placePod
function setEscapePod()
	clearGMFunctions()
	addGMFunction("-Main from Esc Pod",initialGMFunctions)
	addGMFunction("-From Escape Pod",dropPoint)
	addGMFunction(string.format("+%s",drop_point_location),function()
		set_drop_point_location_caller = setEscapePod
		setDropPointLocation()
	end)
	if gm_click_mode == "escape pod" then
		addGMFunction(">Place Pod<",placePod)
	else
		addGMFunction("Place Pod",placePod)
	end
end
function placePod()
	if drop_point_location == "At Click" then
		if gm_click_mode == "escape pod" then
			gm_click_mode = nil
			onGMClick(nil)
		else
			local prev_mode = gm_click_mode
			gm_click_mode = "escape pod"
			onGMClick(gmClickDropPoint)
			if prev_mode ~= nil then
				addGMMessage(string.format("Cancelled current GM Click mode\n   %s\nIn favor of\n   escape pod\nGM click mode.",prev_mode))
			end
		end
		setEscapePod()
	elseif drop_point_location == "Associated" then
		podAssociatedTo()
	elseif drop_point_location == "Near To" then
		podNearTo()
	end
end
function gmClickDropPoint(x,y)
	podCreation(x,y,0,0)
end
--------------------------------------------------------------------
--	Drop Point > Escape Pod > At Click (set drop point location)  --
--------------------------------------------------------------------
-- Button Text		   DF*	Related Function(s)
-- -MAIN FRM DROP LOC	F	initialGMFunctions
-- -TO DROP POINT		F	dropPoint
-- AT CLICK*			*	inline
-- ASSOCIATED			*	inline
-- NEAR TO				*	inline
function setDropPointLocation()
	clearGMFunctions()
	addGMFunction("-Main frm Drop Loc",initialGMFunctions)
	addGMFunction("-To Drop Point",dropPoint)
	local button_label = "At Click"
	if drop_point_location == "At Click" then
		button_label = button_label .. "*"
	end
	addGMFunction(button_label,function()
		drop_point_location = "At Click"
		set_drop_point_location_caller()
	end)
	button_label = "Associated"
	if drop_point_location == "Associated" then
		button_label = button_label .. "*"
	end
	addGMFunction(button_label,function()
		drop_point_location = "Associated"
		set_drop_point_location_caller()
	end)
	button_label = "Near To"
	if drop_point_location == "Near To" then
		button_label = button_label .. "*"
	end
	addGMFunction(button_label,function()
		drop_point_location = "Near To"
		set_drop_point_location_caller()
	end)
end
--------------------------------------------
--	Drop Point > Escape Pod > Associated  --
--------------------------------------------
--Create escape pod associated to selected object
--If selected object is a black hole, add these two buttons
-- NEAR RADIUS BUT SAFE		F	nearButSafe
-- EDGE BUT IN DANGER		F	edgeButDanger
--If selected object is a wormhole, add these two buttons
-- NEAR RADIUS BUT OUTSIDE	F	nearButOutside
-- EDGE BUT INSIDE			F	edgeButInside
function podAssociatedTo()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		addGMMessage("No action taken. Selct one object for association")
		return
	end
	local tempObject = objectList[1]
	local tempType = tempObject.typeName
	local podDistance = associatedTypeDistance[tempType]
	if podDistance == nil then
		addGMMessage(tempType .. ": not type which can be associated")
		return
	end
	local aox, aoy = tempObject:getPosition()
	--size of player spaceships vary, so use the values set in setConstants to determine
	if tempType == "PlayerSpaceship" then
		local tempShipType = tempObject:getTypeName()
		--local psd = playerShipDistance[tempShipType]
		local psd = playerShipStats[tempShipType].distance
		if psd ~= nil then
			podDistance = psd
		end
	end
	--size of space stations vary so use the values set in setConstants to determine
	if tempType == "SpaceStation" then
		local tempStationType = tempObject:getTypeName()
		local sd = spaceStationDistance[tempStationType]
		if sd ~= nil then
			podDistance = sd
		end
	end
	if tempType == "BlackHole" then
		addGMFunction("Near radius but safe",nearButSafe)
		addGMFunction("Edge but in danger",edgeButDanger)
		--podDistance = 5000
	elseif tempType == "WormHole" then
		addGMFunction("Near radius but outside",nearButOutside)
		addGMFunction("Edge but inside",edgeButInside)
	else
		local sox, soy = vectorFromAngle(random(0,360),podDistance)
		podCreation(aox, aoy, sox, soy)
	end
end
--Black hole special cases
function nearButSafe()
	local objectList = getGMSelection()
	local podDistance = associatedTypeDistance["BlackHole"]
	local sox, soy = vectorFromAngle(random(0,360),podDistance)
	local aox, aoy = objectList[1]:getPosition()
	podCreation(aox, aoy, sox, soy)
end
function edgeButDanger()
	local objectList = getGMSelection()
	local podDistance = 5100
	local sox, soy = vectorFromAngle(random(0,360),podDistance)
	local aox, aoy = objectList[1]:getPosition()
	podCreation(aox, aoy, sox, soy)
end
--Worm hole special cases
function nearButOutside()
	local objectList = getGMSelection()
	local podDistance = associatedTypeDistance["WormHole"]
	local sox, soy = vectorFromAngle(random(0,360),podDistance)
	local aox, aoy = objectList[1]:getPosition()
	podCreation(aox, aoy, sox, soy)
end
function edgeButInside()
	local objectList = getGMSelection()
	local podDistance = 2600
	local sox, soy = vectorFromAngle(random(0,360),podDistance)
	local aox, aoy = objectList[1]:getPosition()
	podCreation(aox, aoy, sox, soy)
end
function podPickupProcess(self,retriever)
	local podCallSign = self:getCallSign()
	local podPrepped = false
	for epCallSign, ep in pairs(escapePodList) do
		if epCallSign == podCallSign then
			escapePodList[epCallSign] = nil
		end
	end
	for rpi, rp in pairs(rendezvousPoints) do
		if rp:getCallSign() == podCallSign then
			table.remove(rendezvousPoints,rpi)
		end
	end
	for pidx=1,8 do
		p = getPlayerShip(pidx)
		if p ~= nil and p:isValid() then
			for pb, enabled in pairs(p.podButton) do
				if pb == podCallSign then
					if not enabled then
						podPrepped = true
						break
					end
				end
			end
			if podPrepped then
				p:removeCustom(podCallSign)
			end
			if podPrepped and p == retriever and p.pods > 0 then
				p.pods = p.pods - 1
				retriever:addToShipLog(string.format("Escape pod %s retrieved. %s can carry %i more. Unload escape pods at any friendly station",podCallSign,retriever:getCallSign(),p.pods),"Green")
				if retriever:getEnergy() > 50 then
					retriever:setEnergy(retriever:getEnergy() - 50)
				else
					retriever:setEnergy(0)
				end
			else
				local rpx, rpy = self:getPosition()
				if escapePodList[podCallSign] == nil then
					local redoPod = Artifact():setPosition(rpx,rpy):setScanningParameters(1,1):setRadarSignatureInfo(1,.5,0):setModel("ammo_box"):setDescriptions("Escape Pod",string.format("Escape Pod %s, life forms detected",podCallSign)):setCallSign(podCallSign)
					redoPod:onPickUp(podPickupProcess)
					escapePodList[podCallSign] = redoPod
					table.insert(rendezvousPoints,redoPod)
				end
			end
		end
	end
end
-----------------------------------------
--	Drop Point > Escape Pod > Near To  --
-----------------------------------------
--Create escape pod near to selected object(s)
-- Button Text			   FD*	Related Function(s)
-- -MAIN FROM NEAR TO		F	initialGMFunctions
-- -DROP POINT				F	dropPoint
-- -SET ESCAPE POD			F	setEscapePod
-- Up to 3 buttons of nearby CpuShips for association
-- +90 DEGREES				D	setCreateDirection
-- +30 UNITS				D	setCreateDistance
-- CREATE AT 90 DEG, 30U	D	createPodAway
function podNearTo()
	clearGMFunctions()
	addGMFunction("-Main from Near To",initialGMFunctions)
	addGMFunction("-Drop Point",dropPoint)
	addGMFunction("-Set Escape Pod",setEscapePod)
	local objectList = getGMSelection()
	if #objectList < 1 then
		addGMMessage("Select an object. No action taken")
		return
	end
	--print("got something in selection list")
	nearx = 0
	neary = 0
	if #objectList > 1 then
		nearx, neary = centerOfSelected(objectList)
	else
		nearx, neary = objectList[1]:getPosition()	
	end
	--print(string.format("nearx: %.1f, neary: %.1f",nearx,neary))
	local nearbyObjects = getObjectsInRadius(nearx, neary, 20000)
	cpuShipList = {}
	for i=1,#nearbyObjects do
		local tempObject = nearbyObjects[i]
		local tempType = tempObject.typeName
		if tempType == "CpuShip" then
			table.insert(cpuShipList,tempObject)
		end
		if #cpuShipList >= 3 then
			break
		end
	end
	if #cpuShipList > 0 then
		if #cpuShipList >= 1 then
			local GMPodAssociatedToCpuShip1 = string.format("Associate to %s",cpuShipList[1]:getCallSign())
			addGMFunction(GMPodAssociatedToCpuShip1,function () podAssociatedToGivenCpuShip(cpuShipList[1]) end)
		end
		if #cpuShipList >= 2 then
			local GMPodAssociatedToCpuShip2 = string.format("Associate to %s",cpuShipList[2]:getCallSign())
			addGMFunction(GMPodAssociatedToCpuShip2,function () podAssociatedToGivenCpuShip(cpuShipList[2]) end)
		end
		if #cpuShipList >= 3 then
			local GMPodAssociatedToCpuShip3 = string.format("Associate to %s",cpuShipList[3]:getCallSign())
			addGMFunction(GMPodAssociatedToCpuShip3,function () podAssociatedToGivenCpuShip(cpuShipList[3]) end)
		end
	end
	callingNearTo = podNearTo
	local GMSetCreateDirection = createDirection .. " Degrees"
	addGMFunction(string.format("+%s",GMSetCreateDirection),setCreateDirection)
	local GMSetCreateDistance = createDistance .. " Units"
	addGMFunction(string.format("+%s",GMSetCreateDistance),setCreateDistance)
	local GMCreatePodAway = "Create at " .. createDirection .. " Deg, " .. createDistance .. "U"
	addGMFunction(GMCreatePodAway,createPodAway)
end
function podAssociatedToGivenCpuShip(tempObject)
	local podDistance = associatedTypeDistance["CpuShip"]
	local aox, aoy = tempObject:getPosition()
	local tempShipType = tempObject:getTypeName()
	local csd = shipTemplateDistance[tempShipType]
	if csd ~= nil then
		podDistance = csd
	end
	local sox, soy = vectorFromAngle(random(0,360),podDistance)
	podCreation(aox, aoy, sox, soy)
end
----------------------------------------------------------------------------------------------------------
--	Drop Point > Escape Pod (or other drop point type) > Near To > +30 Units (Set Pod Create Distance)  --
----------------------------------------------------------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -FROM CREATE DIST	F	callingNearTo (set prior to invocation)
-- .5U					*	inline
-- 1U					*	inline
-- 2U					*	inline
-- 3U					*	inline
-- 5U					*	inline
-- 10U					*	inline
-- 20U					*	inline
-- 30U*					*	inline	asterisk = current selection		
function setCreateDistance()
	clearGMFunctions()
	addGMFunction("-From Create Dist",callingNearTo)
	local button_label = ".5U"
	if createDistance == .5 then
		button_label = ".5U*"
	end
	addGMFunction(button_label,function()
		createDistance = .5
		setCreateDistance()
	end)
	button_label = "1U"
	if createDistance == 1 then
		button_label = "1U*"
	end
	addGMFunction(button_label,function()
		createDistance = 1
		setCreateDistance()
	end)
	button_label = "2U"
	if createDistance == 2 then
		button_label = "2U*"
	end
	addGMFunction(button_label,function()
		createDistance = 2
		setCreateDistance()
	end)
	button_label = "3U"
	if createDistance == 3 then
		button_label = "3U*"
	end
	addGMFunction(button_label,function()
		createDistance = 3
		setCreateDistance()
	end)
	button_label = "5U"
	if createDistance == 5 then
		button_label = "5U*"
	end
	addGMFunction(button_label,function()
		createDistance = 5
		setCreateDistance()
	end)
	button_label = "10U"
	if createDistance == 10 then
		button_label = "10U*"
	end
	addGMFunction(button_label,function()
		createDistance = 10
		setCreateDistance()
	end)
	button_label = "20U"
	if createDistance == 20 then
		button_label = "20U*"
	end
	addGMFunction(button_label,function()
		createDistance = 20
		setCreateDistance()
	end)
	button_label = "30U"
	if createDistance == 30 then
		button_label = "30U*"
	end
	addGMFunction(button_label,function()
		createDistance = 30
		setCreateDistance()
	end)
end
-------------------------------------------------------------------------------------------------------------
--	Drop Point > Escape Pod (or other drop point type) > Near To > +90 Degrees (Set Pod Create Direction)  --
-------------------------------------------------------------------------------------------------------------
-- Button Text		   DF*	Related Function(s)
-- -FROM CREATE DIR		F	callingNearTo (set prior to invocation)
-- 0					*	inline, setCreateDirection0
-- 45					*	inline, setCreateDirection45
-- 90*					*	inline, setCreateDirection90		asterisk = current selection
-- 135					*	inline, setCreateDirection135
-- 180					*	inline, setCreateDirection180
-- 225					*	inline, setCreateDirection225
-- 270					*	inline, setCreateDirection270
-- 315					*	inline, setCreateDirection315
function setCreateDirection()
	clearGMFunctions()
	addGMFunction("-From Create Dir",callingNearTo)
	local GMSetCreateDirection0 = "0"
	if createDirection == 0 then
		GMSetCreateDirection0 = "0*"
	end
	addGMFunction(GMSetCreateDirection0,setCreateDirection0)
	local GMSetCreateDirection45 = "45"
	if createDirection == 45 then
		GMSetCreateDirection45 = "45*"
	end
	addGMFunction(GMSetCreateDirection45,setCreateDirection45)
	local GMSetCreateDirection90 = "90"
	if createDirection == 90 then
		GMSetCreateDirection90 = "90*"
	end
	addGMFunction(GMSetCreateDirection90,setCreateDirection90)
	local GMSetCreateDirection135 = "135"
	if createDirection == 135 then
		GMSetCreateDirection135 = "135*"
	end
	addGMFunction(GMSetCreateDirection135,setCreateDirection135)
	local GMSetCreateDirection180 = "180"
	if createDirection == 180 then
		GMSetCreateDirection180 = "180*"
	end
	addGMFunction(GMSetCreateDirection180,setCreateDirection180)
	local GMSetCreateDirection225 = "225"
	if createDirection == 225 then
		GMSetCreateDirection225 = "225*"
	end
	addGMFunction(GMSetCreateDirection225,setCreateDirection225)
	local GMSetCreateDirection270 = "270"
	if createDirection == 270 then
		GMSetCreateDirection270 = "270*"
	end
	addGMFunction(GMSetCreateDirection270,setCreateDirection270)
	local GMSetCreateDirection315 = "315"
	if createDirection == 315 then
		GMSetCreateDirection315 = "315*"
	end
	addGMFunction(GMSetCreateDirection315,setCreateDirection315)
end
function setCreateDirection0()
	createDirection = 0
	setCreateDirection()
end
function setCreateDirection45()
	createDirection = 45
	setCreateDirection()
end
function setCreateDirection90()
	createDirection = 90
	setCreateDirection()
end
function setCreateDirection135()
	createDirection = 135
	setCreateDirection()
end
function setCreateDirection180()
	createDirection = 180
	setCreateDirection()
end
function setCreateDirection225()
	createDirection = 225
	setCreateDirection()
end
function setCreateDirection270()
	createDirection = 270
	setCreateDirection()
end
function setCreateDirection315()
	createDirection = 315
	setCreateDirection()
end
--Pod creation after distance and direction parameters set
function createPodAway()
	local angle = createDirection + 270
	if angle > 360 then 
		angle = angle - 360
	end
	local sox, soy = vectorFromAngle(angle,createDistance*1000)
	podCreation(nearx, neary, sox, soy)
end
function artifactToPod()
-- ideally this would convert to any type of pickup
-- however I do not currently have the time to ensure it works for any
-- I think there are slight tweaks needed for each
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		addGMMessage("Select one object. No action taken")
		return
	end
	local pod=objectList[1]
	if pod.typeName ~= "Artifact" then
		addGMMessage("must select an artifact to convert. No action taken")
	end
	local podCallSign = pod:getCallSign()
	pod:onPickUp(podPickupProcess)
	escapePodList[podCallSign] = pod
	table.insert(rendezvousPoints,pod)
	for pidx=1,8 do
		p = getPlayerShip(pidx)
		if p ~= nil and p:isValid() then
			if p.podButton == nil then
				p.podButton = {}
			end
			p.podButton[podCallSign] = true
			local tempButton = podCallSign
			p:addCustomButton("Engineering",tempButton,string.format("Prepare to get %s",podCallSign),function()
				for pidx=1,8 do
					p = getPlayerShip(pidx)
					if p ~= nil and p:isValid() then
						for pb, enabled in pairs(p.podButton) do
							if enabled then
								p:removeCustom(pb)
								p:addCustomMessage("Engineering","pbgone",string.format("Transporters ready for pickup of %s",pb))
								p.podButton[pb] = false
							end
						end
					end
				end
			end)
		end
	end
end
function podCreation(originx, originy, vectorx, vectory)
	artifactCounter = artifactCounter + 1
	artifactNumber = artifactNumber + math.random(1,4)
	local randomSuffix = string.char(math.random(65,90))
	local podCallSign = string.format("Pod%i%s",artifactNumber,randomSuffix)
	local pod = Artifact():setPosition(originx+vectorx,originy+vectory):setScanningParameters(1,1):setRadarSignatureInfo(1,.5,0):setModel("ammo_box"):setDescriptions("Escape Pod",string.format("Escape Pod %s, life forms detected",podCallSign)):setCallSign(podCallSign)
	pod:onPickUp(podPickupProcess)
	escapePodList[podCallSign] = pod
	table.insert(rendezvousPoints,pod)
	for pidx=1,8 do
		p = getPlayerShip(pidx)
		if p ~= nil and p:isValid() then
			if p.podButton == nil then
				p.podButton = {}
			end
			p.podButton[podCallSign] = true
			local tempButton = podCallSign
			p:addCustomButton("Engineering",tempButton,string.format("Prepare to get %s",podCallSign),function()
				for pidx=1,8 do
					p = getPlayerShip(pidx)
					if p ~= nil and p:isValid() then
						for pb, enabled in pairs(p.podButton) do
							if enabled then
								p:removeCustom(pb)
								p:addCustomMessage("Engineering","pbgone",string.format("Transporters ready for pickup of %s",pb))
								p.podButton[pb] = false
							end
						end
					end
				end
			end)
		end
	end
end
---------------------------------
--	Drop Point > Marine Point  --
---------------------------------
-- Button Text		   DF*	Related Function(s)
-- -MAIN				F	initialGMFunctions
-- -FROM MARINE POINT	F	dropPoint
-- DROP MARINES*		*	setDropAction		asterisk = current selection
-- EXTRACT MARINES		*	setExtractAction
-- +AT CLICK			F	setDropPointLocation
-- SET MARINE POINT		F	placeMarinePoint
function setMarinePoint()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-From Marine Point",dropPoint)
	dropExtractActionReturn = setMarinePoint	--tell callback function to return to this function
	local button_label = "Drop marines"
	if dropOrExtractAction == "Drop" then
		button_label = button_label .. "*"
	end
	addGMFunction(button_label,setDropAction)
	button_label = "Extract marines"
	if dropOrExtractAction == "Extract" then
		button_label = button_label .. "*"
	end
	addGMFunction(button_label,setExtractAction)
	addGMFunction(string.format("+%s",drop_point_location),function()
		set_drop_point_location_caller = setMarinePoint
		setDropPointLocation()
	end)
	if gm_click_mode == "marine point" then
		addGMFunction(">Set Marine Point<",placeMarinePoint)
	else
		addGMFunction("Set Marine Point",placeMarinePoint)
	end	
end
function placeMarinePoint()
	if drop_point_location == "At Click" then
		if gm_click_mode == "marine point" then
			gm_click_mode = nil
			onGMClick(nil)
		else
			local prev_mode = gm_click_mode
			gm_click_mode = "marine point"
			onGMClick(gmClickMarinePoint)
			if prev_mode ~= nil then
				addGMMessage(string.format("Cancelled current GM Click mode\n   %s\nIn favor of\n   marine point\nGM click mode.",prev_mode))
			end
		end
		setMarinePoint()
	elseif drop_point_location == "Associated" then
		marineAssociatedTo()
	elseif drop_point_location == "Near To" then
		marineNearTo()
	end
end
function gmClickMarinePoint(x,y)
	marineCreation(x,y,0,0)
end
function setDropAction()
	dropOrExtractAction = "Drop"
	dropExtractActionReturn()
end
function setExtractAction()
	dropOrExtractAction = "Extract"
	dropExtractActionReturn()
end
--Create marine point associated to selected object
function marineAssociatedTo()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		addGMMessage("Select one object. No action taken")
		return
	end
	local tempObject = objectList[1]
	local tempType = tempObject.typeName
	local marineDistance = associatedTypeDistance[tempType]
	if marineDistance == nil then
		addGMMessage(tempType .. ": not type which can be associated. No action taken.")
		--print(tempType .. ": not type which can be associated")
		return
	end
	local aox, aoy = tempObject:getPosition()
	--size of player spaceships vary, so use the values set in setConstants to determine
	if tempType == "PlayerSpaceship" then
		local tempShipType = tempObject:getTypeName()
		--local psd = playerShipDistance[tempShipType]
		local psd = playerShipStats[tempShipType].distance
		if psd ~= nil then
			marineDistance = psd
		end
	end
	--size of space stations vary so use the values set in setConstants to determine
	if tempType == "SpaceStation" then
		local tempStationType = tempObject:getTypeName()
		local sd = spaceStationDistance[tempStationType]
		if sd ~= nil then
			marineDistance = sd
		end
	end
	local sox, soy = vectorFromAngle(random(0,360),marineDistance)
	local associatedObjectName = tempObject:getCallSign()
	marineCreation(aox, aoy, sox, soy, associatedObjectName)
end
function marineCreation(originx, originy, vectorx, vectory, associatedObjectName)
	artifactCounter = artifactCounter + 1
	artifactNumber = artifactNumber + math.random(1,5)
	local randomSuffix = string.char(math.random(65,90))
	local marineCallSign = string.format("Mrn%i%s",artifactNumber,randomSuffix)
	local unscannedDescription = string.format("Marine %s Point",dropOrExtractAction)
	local scannedDescription = string.format("Marine %s Point %s, standing by for marine transport",dropOrExtractAction,marineCallSign)
	if associatedObjectName ~= nil then
		scannedDescription = scannedDescription .. ": " .. associatedObjectName
	end
	local marinePoint = Artifact():setPosition(originx+vectorx,originy+vectory):setScanningParameters(1,1):setRadarSignatureInfo(1,.5,0):setModel("SensorBuoyMKI"):setDescriptions(unscannedDescription,scannedDescription):setCallSign(marineCallSign)
	marinePoint:onPickUp(marinePointPickupProcess)
	marinePoint.action = dropOrExtractAction
	marinePoint.associatedObjectName = associatedObjectName
	marinePointList[marineCallSign] = marinePoint
	--table.insert(marinePointList,marinePoint)
	table.insert(rendezvousPoints,marinePoint)
	for pidx=1,8 do
		p = getPlayerShip(pidx)
		if p ~= nil and p:isValid() then
			if p.marinePointButton == nil then
				p.marinePointButton = {}
			end
			p.marinePointButton[marineCallSign] = true
			p:addCustomButton("Engineering",marineCallSign,string.format("Prep to %s via %s",dropOrExtractAction,marineCallSign),function()
				for pidx=1,8 do
					p = getPlayerShip(pidx)
					if p ~= nil and p:isValid() then
						for mpb, enabled in pairs(p.marinePointButton) do
							if enabled then
								p:removeCustom(mpb)
								p:addCustomMessage("Engineering","mpbgone",string.format("Transporters ready for marines via %s",mpb))
								p.marinePointButton[mpb] = false
							end
						end
					end
				end
			end)
		end
	end
end
function marinePointPickupProcess(self,retriever)
	local marineCallSign = self:getCallSign()
	local marinePointPrepped = false
	for mpCallSign, mp in pairs(marinePointList) do
		if mpCallSign == marineCallSign then
			marinePointList[mpCallSign] = nil
		end
	end
	for rpi, rp in pairs(rendezvousPoints) do
		if rp:getCallSign() == marineCallSign then
			table.remove(rendezvousPoints,rpi)
		end
	end
	for pidx=1,8 do
		p = getPlayerShip(pidx)
		if p ~= nil and p:isValid() then
			for mpb, enabled in pairs(p.marinePointButton) do
				if mpb == marineCallSign then
					if not enabled then
						marinePointPrepped = true
						break
					end
				end
			end
			if marinePointPrepped then
				p:removeCustom(marineCallSign)
			end
			local successful_action = false
			local completionMessage = ""
			if marinePointPrepped and p == retriever then
				completionMessage = string.format("Marine %s action successful via %s",self.action,marineCallSign)
				if self.action == "Drop" then
					if p:getRepairCrewCount() > 0 then
						successful_action = true
						p:setRepairCrewCount(p:getRepairCrewCount() - 1)
					end
					if self.associatedObjectName ~= nil then
						completionMessage = string.format("Marine drop action on %s successful via %s",self.associatedObjectName,marineCallSign)
					end
				else
					successful_action = true
					p:setRepairCrewCount(p:getRepairCrewCount() + 1)
					if self.associatedObjectName ~= nil then
						completionMessage = string.format("Marine extract action from %s successful via %s",self.associatedObjectName,marineCallSign)
					end
				end
			end
			if successful_action then
				retriever:addToShipLog(completionMessage,"Green")
				if self.action == "Drop" then
					if retriever:hasPlayerAtPosition("Engineering") then
						retriever:addCustomMessage("Engineering","mprcd","One of your repair crew deployed with the marine team. They will return when the marines are picked up")
					end
					if retriever:hasPlayerAtPosition("Engineering+") then
						retriever:addCustomMessage("Engineering+","mprcd_plus","One of your repair crew deployed with the marine team. They will return when the marines are picked up")
					end
				end
				if retriever:getEnergy() > 50 then
					retriever:setEnergy(retriever:getEnergy() - 50)
				else
					retriever:setEnergy(0)
				end
			else
				local rpx, rpy = self:getPosition()
				local unscannedDescription = string.format("Marine %s Point",self.action)
				local scannedDescription = string.format("Marine %s Point %s, standing by for marine transport",self.action,marineCallSign)
				if self.associatedObjectName ~= nil then
					scannedDescription = scannedDescription .. ": " .. self.associatedObjectName
				end
				if marinePointList[marineCallSign] == nil then
					local redoMarinePoint = Artifact():setPosition(rpx,rpy):setScanningParameters(1,1):setRadarSignatureInfo(1,.5,0):setModel("SensorBuoyMKI"):setDescriptions(unscannedDescription,scannedDescription):setCallSign(marineCallSign)
					redoMarinePoint:onPickUp(marinePointPickupProcess)
					redoMarinePoint.action = self.action
					redoMarinePoint.associatedObjectName = self.associatedObjectName
					marinePointList[marineCallSign] = redoMarinePoint
					table.insert(rendezvousPoints,redoMarinePoint)
				end
			end
		end
	end
end
-------------------------------------------
--	Drop Point > Marine Point > Near To  --
-------------------------------------------
--Create marine point near to selected object(s)
-- Button Text			   FD*	Related Function(s)
-- -MAIN					F	initialGMFunctions
-- -DROP POINT				F	dropPoint
-- -FROM NEAR TO			F	setMarinePoint
-- Up to 3 buttons of nearby CpuShips for association
-- +90 DEGREES				D	setCreateDirection
-- +30 UNITS				D	setCreateDistance
-- CREATE AT 90 DEG, 30U	D	createMarineAway
function marineNearTo()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Drop Point",dropPoint)
	addGMFunction("-From Near To",setMarinePoint)
	local objectList = getGMSelection()
	if #objectList < 1 then
		addGMMessage("Select object. No action taken")
		return
	end
	--print("got something in selection list")
	nearx = 0
	neary = 0
	if #objectList > 1 then
		nearx, neary = centerOfSelected(objectList)
	else
		nearx, neary = objectList[1]:getPosition()	
	end
	print(string.format("nearx: %.1f, neary: %.1f",nearx,neary))
	local nearbyObjects = getObjectsInRadius(nearx, neary, 20000)
	cpuShipList = {}
	for i=1,#nearbyObjects do
		local tempObject = nearbyObjects[i]
		local tempType = tempObject.typeName
		if tempType == "CpuShip" then
			table.insert(cpuShipList,tempObject)
		end
		if #cpuShipList >= 3 then
			break
		end
	end
	if #cpuShipList > 0 then
		if #cpuShipList >= 1 then
			GMMarineAssociatedToCpuShip1 = string.format("Associate to %s",cpuShipList[1]:getCallSign())
			addGMFunction(GMMarineAssociatedToCpuShip1,function () marineAssociatedToGivenCpuShip(cpuShipList[1]) end)
		end
		if #cpuShipList >= 2 then
			GMMarineAssociatedToCpuShip2 = string.format("Associate to %s",cpuShipList[2]:getCallSign())
			addGMFunction(GMMarineAssociatedToCpuShip2,function () marineAssociatedToGivenCpuShip(cpuShipList[2]) end)
		end
		if #cpuShipList >= 3 then
			GMMarineAssociatedToCpuShip3 = string.format("Associate to %s",cpuShipList[3]:getCallSign())
			addGMFunction(GMMarineAssociatedToCpuShip3,function () marineAssociatedToGivenCpuShip(cpuShipList[3]) end)
		end
	end
	callingNearTo = marineNearTo
	GMSetCreateDirection = createDirection .. " Degrees"
	addGMFunction(GMSetCreateDirection,setCreateDirection)
	GMSetCreateDistance = createDistance .. " Units"
	addGMFunction(GMSetCreateDistance,setCreateDistance)
	GMCreateMarineAway = "Create at " .. createDirection .. " Deg, " .. createDistance .. "U"
	addGMFunction(GMCreateMarineAway,createMarineAway)
end
function marineAssociatedToGivenCpuShip(tempObject)
	local marineDistance = associatedTypeDistance["CpuShip"]
	local aox, aoy = tempObject:getPosition()
	local tempShipType = tempObject:getTypeName()
	local csd = shipTemplateDistance[tempShipType]
	if csd ~= nil then
		marineDistance = csd
	end
	local sox, soy = vectorFromAngle(random(0,360),marineDistance)
	marineCreation(aox, aoy, sox, soy)
end
--Marine point creation after distance and direction parameters set
function createMarineAway()
	local angle = createDirection + 270
	if angle > 360 then 
		angle = angle - 360
	end
	local sox, soy = vectorFromAngle(angle,createDistance*1000)
	marineCreation(nearx, neary, sox, soy)
end
-----------------------------------
--	Drop Point > Engineer Point  --
-----------------------------------
-- Button Text			   DF*	Related Function(s)
-- -MAIN					F	initialGMFunctions
-- -FROM ENGINEER POINT		F	dropPoint
-- DROP ENGINEERS*			*	setDropAction		asterisk = current selection
-- EXTRACT ENGINEERS		*	setExtractAction
-- +AT CLICK				D	setDropPointLocation
-- SET ENGINEER POINT		D	placeEngineerPoint
function setEngineerPoint()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-From Engineer Point",dropPoint)
	dropExtractActionReturn = setEngineerPoint
	local GMEngineerDrop = "Drop engineers"
	if dropOrExtractAction == "Drop" then
		GMEngineerDrop = "Drop engineers*"
	end
	addGMFunction(GMEngineerDrop,setDropAction)
	local GMEngineerExtract = "Extract engineers"
	if dropOrExtractAction == "Extract" then
		GMEngineerExtract = "Extract engineers*"
	end
	addGMFunction(GMEngineerExtract,setExtractAction)
	addGMFunction(string.format("+%s",drop_point_location),function()
		set_drop_point_location_caller = setEngineerPoint
		setDropPointLocation()
	end)
	if gm_click_mode == "engineer point" then
		addGMFunction(">Set Engineer Point<",placeEngineerPoint)
	else
		addGMFunction("Set Engineer Point",placeEngineerPoint)
	end	
end
function placeEngineerPoint()
	if drop_point_location == "At Click" then
		if gm_click_mode == "engineer point" then
			gm_click_mode = nil
			onGMClick(nil)
		else
			local prev_mode = gm_click_mode
			gm_click_mode = "engineer point"
			onGMClick(gmClickEngineerPoint)
			if prev_mode ~= nil then
				addGMMessage(string.format("Cancelled current GM Click mode\n   %s\nIn favor of\n   engineer point\nGM click mode.",prev_mode))
			end
		end
		setEngineerPoint()
	elseif drop_point_location == "Associated" then
		engineerAssociatedTo()
	elseif drop_point_location == "Near To" then
		engineerNearTo()
	end
end
function gmClickEngineerPoint(x,y)
	engineerCreation(x,y,0,0)
end
--Create engineer point associated to selected object(s)
function engineerAssociatedTo()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		addGMMessage("You need to select an object. No action taken")
		return
	end
	local tempObject = objectList[1]
	local tempType = tempObject.typeName
	local engineerDistance = associatedTypeDistance[tempType]
	if engineerDistance == nil then
		addGMMessage(string.format("The type of the object selected (%s) is not a type that can be associate. No action taken",tempType))
		--print(tempType .. ": not type which can be associated")
		return
	end
	local aox, aoy = tempObject:getPosition()
	--size of player spaceships vary, so use the values set in setConstants to determine
	if tempType == "PlayerSpaceship" then
		local tempShipType = tempObject:getTypeName()
		--local psd = playerShipDistance[tempShipType]
		local psd = playerShipStats[tempShipType].distance
		if psd ~= nil then
			engineerDistance = psd
		end
	end
	--size of space stations vary so use the values set in setConstants to determine
	if tempType == "SpaceStation" then
		local tempStationType = tempObject:getTypeName()
		local sd = spaceStationDistance[tempStationType]
		if sd ~= nil then
			engineerDistance = sd
		end
	end
	local sox, soy = vectorFromAngle(random(0,360),engineerDistance)
	local associatedObjectName = tempObject:getCallSign()
	engineerCreation(aox, aoy, sox, soy, associatedObjectName)
end
function engineerCreation(originx, originy, vectorx, vectory, associatedObjectName)
	artifactCounter = artifactCounter + 1
	artifactNumber = artifactNumber + math.random(1,5)
	local randomSuffix = string.char(math.random(65,90))
	local engineerCallSign = string.format("Eng%i%s",artifactNumber,randomSuffix)
	local unscannedDescription = string.format("Engineer %s Point",dropOrExtractAction)
	local scannedDescription = string.format("Engineer %s Point %s, standing by for engineer transport",dropOrExtractAction,engineerCallSign)
	if associatedObjectName ~= nil then
		scannedDescription = scannedDescription .. ": " .. associatedObjectName
	end
	local engineerPoint = Artifact():setPosition(originx+vectorx,originy+vectory):setScanningParameters(1,1):setRadarSignatureInfo(1,.5,0):setModel("SensorBuoyMKI"):setDescriptions(unscannedDescription,scannedDescription):setCallSign(engineerCallSign)
	engineerPoint:onPickUp(engineerPointPickupProcess)
	engineerPoint.action = dropOrExtractAction
	engineerPoint.associatedObjectName = associatedObjectName
	engineerPointList[engineerCallSign] = engineerPoint
	table.insert(rendezvousPoints,engineerPoint)
	for pidx=1,8 do
		p = getPlayerShip(pidx)
		if p ~= nil and p:isValid() then
			if p.engineerPointButton == nil then
				p.engineerPointButton = {}
			end
			p.engineerPointButton[engineerCallSign] = true
			local tempButton = engineerCallSign
			p:addCustomButton("Engineering",tempButton,string.format("Prep to %s via %s",dropOrExtractAction,engineerCallSign),function()
				for pidx=1,8 do
					p = getPlayerShip(pidx)
					if p ~= nil and p:isValid() then
						for epb, enabled in pairs(p.engineerPointButton) do
							if enabled then
								p:removeCustom(epb)
								p:addCustomMessage("Engineering","epbgone",string.format("Transporters ready for engineers via %s",epb))
								p.engineerPointButton[epb] = false
							end
						end
					end
				end
			end)
		end
	end
end
function engineerPointPickupProcess(self,retriever)
	local engineerCallSign = self:getCallSign()
	local engineerPointPrepped = false
	for epCallSign, ep in pairs(engineerPointList) do
		if epCallSign == engineerCallSign then
			engineerPointList[epCallSign] = nil
		end
	end
	for rpi, rp in pairs(rendezvousPoints) do
		if rp:getCallSign() == engineerCallSign then
			table.remove(rendezvousPoints,rpi)
		end
	end
	for pidx=1,8 do
		p = getPlayerShip(pidx)
		if p ~= nil and p:isValid() then
			for epb, enabled in pairs(p.engineerPointButton) do
				if epb == engineerCallSign then
					if not enabled then
						engineerPointPrepped = true
						break
					end
				end
			end
			if engineerPointPrepped then
				p:removeCustom(engineerCallSign)
			end
			local successful_action = false
			local completionMessage = ""
			if engineerPointPrepped and p == retriever then
				completionMessage = string.format("Engineer %s action successful via %s",self.action,engineerCallSign)
				if self.action == "Drop" then
					if p:getRepairCrewCount() > 0 then
						successful_action = true
						p:setRepairCrewCount(p:getRepairCrewCount() - 1)
					end
					if self.associatedObjectName ~= nil then
						completionMessage = string.format("Engineer drop action on %s successful via %s",self.associatedObjectName,engineerCallSign)
					end
				else
					successful_action = true
					p:setRepairCrewCount(p:getRepairCrewCount() + 1)
					if self.associatedObjectName ~= nil then
						completionMessage = string.format("Engineer extract action from %s successful via %s",self.associatedObjectName,engineerCallSign)
					end
				end
			end
			if successful_action then
				retriever:addToShipLog(completionMessage,"Green")
				if self.action == "Drop" then
					if retriever:hasPlayerAtPosition("Engineering") then
						retriever:addCustomMessage("Engineering","eprcd","One of your repair crew deployed with the engineering team. They will return when the engineers are picked up")
					end
					if retriever:hasPlayerAtPosition("Engineering+") then
						retriever:addCustomMessage("Engineering+","eprcd_plus","One of your repair crew deployed with the engineering team. They will return when the engineers are picked up")
					end
				end
				if retriever:getEnergy() > 50 then
					retriever:setEnergy(retriever:getEnergy() - 50)
				else
					retriever:setEnergy(0)
				end
			else
				local rpx, rpy = self:getPosition()
				local unscannedDescription = string.format("Engineer %s Point",self.action)
				local scannedDescription = string.format("Engineer %s Point %s, standing by for engineer transport",self.action,engineerCallSign)
				if self.associatedObjectName ~= nil then
					scannedDescription = scannedDescription .. ": " .. self.associatedObjectName
				end
				if engineerPointList[engineerCallSign] == nil then
					local redoEngineerPoint = Artifact():setPosition(rpx,rpy):setScanningParameters(1,1):setRadarSignatureInfo(1,.5,0):setModel("SensorBuoyMKI"):setDescriptions(unscannedDescription,scannedDescription):setCallSign(engineerCallSign)
					redoEngineerPoint:onPickUp(engineerPointPickupProcess)
					redoEngineerPoint.action = self.action
					redoEngineerPoint.associatedObjectName = self.associatedObjectName
					engineerPointList[engineerCallSign] = redoEngineerPoint
					table.insert(rendezvousPoints,redoEngineerPoint)
				end
			end
		end
	end
end
---------------------------------------------
--	Drop Point > Engineer Point > Near To  --
---------------------------------------------
--Create engineer point near to selected object(s)
-- Button Text			   FD*	Related Function(s)
-- -MAIN					F	initialGMFunctions
-- -DROP POINT				F	dropPoint
-- -FROM ENG NEAR TO		F	setEngineerPoint
-- Up to 3 buttons of nearby CpuShips for association
-- +90 DEGREES				D	setCreateDirection
-- +30 UNITS				D	setCreateDistance
-- CREATE AT 90 DEG, 30U	D	createEngineerAway
function engineerNearTo()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Drop Point",dropPoint)
	addGMFunction("-From Eng Near To",setEngineerPoint)
	local objectList = getGMSelection()
	if #objectList < 1 then
		addGMMessage("You need to select something. No action taken")
		return
	end
	nearx = 0
	neary = 0
	if #objectList > 1 then
		nearx, neary = centerOfSelected(objectList)
	else
		nearx, neary = objectList[1]:getPosition()	
	end
	print(string.format("nearx: %.1f, neary: %.1f",nearx,neary))
	local nearbyObjects = getObjectsInRadius(nearx, neary, 20000)
	cpuShipList = {}
	for i=1,#nearbyObjects do
		local tempObject = nearbyObjects[i]
		local tempType = tempObject.typeName
		if tempType == "CpuShip" then
			table.insert(cpuShipList,tempObject)
		end
		if #cpuShipList >= 3 then
			break
		end
	end
	if #cpuShipList > 0 then
		if #cpuShipList >= 1 then
			GMEngineerAssociatedToCpuShip1 = string.format("Associate to %s",cpuShipList[1]:getCallSign())
			addGMFunction(GMEngineerAssociatedToCpuShip1,function () engineerAssociatedToGivenCpuShip(cpuShipList[1]) end)
		end
		if #cpuShipList >= 2 then
			GMEngineerAssociatedToCpuShip2 = string.format("Associate to %s",cpuShipList[2]:getCallSign())
			addGMFunction(GMEngineerAssociatedToCpuShip2,function () engineerAssociatedToGivenCpuShip(cpuShipList[2]) end)
		end
		if #cpuShipList >= 3 then
			GMEngineerAssociatedToCpuShip3 = string.format("Associate to %s",cpuShipList[3]:getCallSign())
			addGMFunction(GMEngineerAssociatedToCpuShip3,function () engineerAssociatedToGivenCpuShip(cpuShipList[3]) end)
		end
	end
	callingNearTo = engineerNearTo
	GMSetCreateDirection = createDirection .. " Degrees"
	addGMFunction(string.format("+%s",GMSetCreateDirection),setCreateDirection)
	GMSetCreateDistance = createDistance .. " Units"
	addGMFunction(string.format("+%s",GMSetCreateDistance),setCreateDistance)
	GMCreateEngineerAway = "Create at " .. createDirection .. " Deg, " .. createDistance .. "U"
	addGMFunction(GMCreateEngineerAway,createEngineerAway)
end
function engineerAssociatedToGivenCpuShip(tempObject)
	local engineerDistance = associatedTypeDistance["CpuShip"]
	local aox, aoy = tempObject:getPosition()
	local tempShipType = tempObject:getTypeName()
	local csd = shipTemplateDistance[tempShipType]
	if csd ~= nil then
		engineerDistance = csd
	end
	local sox, soy = vectorFromAngle(random(0,360),engineerDistance)
	engineerCreation(aox, aoy, sox, soy)
end
--Engineer point creation after distance and direction parameters set
function createEngineerAway()
	local angle = createDirection + 270
	if angle > 360 then 
		angle = angle - 360
	end
	local sox, soy = vectorFromAngle(angle,createDistance*1000)
	engineerCreation(nearx, neary, sox, soy)
end
---------------------------------------
--	Drop Point > Medical Team Point  --
---------------------------------------
-- Button Text			   DF*	Related Function(s)
-- -MAIN					F	initialGMFunctions
-- -FROM MEDIC POINT		F	dropPoint
-- DROP MEDICAL TEAM*		F	setDropAction		asterisk = current selection
-- EXTRACT MEDICAL TEAM		F	setExtractAction
-- +AT CLICK				D	setDropPointLocation
-- SET MEDIC POINT			D	placeMedicPoint
function setMedicPoint()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-From Medic Point",dropPoint)
	dropExtractActionReturn = setMedicPoint
	local GMMedicDrop = "Drop Medical Team"
	if dropOrExtractAction == "Drop" then
		GMMedicDrop = "Drop Medical Team*"
	end
	addGMFunction(GMMedicDrop,setDropAction)
	local GMMedicExtract = "Extract medical team"
	if dropOrExtractAction == "Extract" then
		GMMedicExtract = "Extract medical team*"
	end
	addGMFunction(GMMedicExtract,setExtractAction)
	addGMFunction(string.format("+%s",drop_point_location),function()
		set_drop_point_location_caller = setMedicPoint
		setDropPointLocation()
	end)
	if gm_click_mode == "medic point" then
		addGMFunction(">Set Medic Point<",placeMedicPoint)
	else
		addGMFunction("Set Medic Point",placeMedicPoint)
	end	
end
function placeMedicPoint()
	if drop_point_location == "At Click" then
		if gm_click_mode == "medic point" then
			gm_click_mode = nil
			onGMClick(nil)
		else
			local prev_mode = gm_click_mode
			gm_click_mode = "medic point"
			onGMClick(gmClickMedicPoint)
			if prev_mode ~= nil then
				addGMMessage(string.format("Cancelled current GM Click mode\n   %s\nIn favor of\n   medic point\nGM click mode.",prev_mode))
			end
		end
		setMedicPoint()
	elseif drop_point_location == "Associated" then
		medicAssociatedTo()
	elseif drop_point_location == "Near To" then
		medicNearTo()
	end
end
function gmClickMedicPoint(x,y)
	medicCreation(x,y,0,0)
end
--Create medical team point associated to selected object(s)
function medicAssociatedTo()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		addGMMessage("You need to select an object. No action taken")
		return
	end
	local tempObject = objectList[1]
	local tempType = tempObject.typeName
	local medicDistance = associatedTypeDistance[tempType]
	if medicDistance == nil then
		addGMMessage(string.format("Type of object selected (%s) cannot be associated. No action taken",tempType))
		--print(tempType .. ": not type which can be associated")
		return
	end
	local aox, aoy = tempObject:getPosition()
	--size of player spaceships vary, so use the values set in setConstants to determine
	if tempType == "PlayerSpaceship" then
		local tempShipType = tempObject:getTypeName()
		--local psd = playerShipDistance[tempShipType]
		local psd = playerShipStats[tempShipType].distance
		if psd ~= nil then
			medicDistance = psd
		end
	end
	--size of space stations vary so use the values set in setConstants to determine
	if tempType == "SpaceStation" then
		local tempStationType = tempObject:getTypeName()
		local sd = spaceStationDistance[tempStationType]
		if sd ~= nil then
			medicDistance = sd
		end
	end
	local sox, soy = vectorFromAngle(random(0,360),medicDistance)
	local associatedObjectName = tempObject:getCallSign()
	medicCreation(aox, aoy, sox, soy, associatedObjectName)
end
function medicCreation(originx, originy, vectorx, vectory, associatedObjectName)
	artifactCounter = artifactCounter + 1
	artifactNumber = artifactNumber + math.random(1,5)
	local randomSuffix = string.char(math.random(65,90))
	local medicCallSign = string.format("Med%i%s",artifactNumber,randomSuffix)
	local unscannedDescription = string.format("Medical Team %s Point",dropOrExtractAction)
	local scannedDescription = string.format("Medical Team %s Point %s, standing by for medical team transport",dropOrExtractAction,medicCallSign)
	if associatedObjectName ~= nil then
		scannedDescription = scannedDescription .. ": " .. associatedObjectName
	end
	local medicPoint = Artifact():setPosition(originx+vectorx,originy+vectory):setScanningParameters(1,1):setRadarSignatureInfo(1,.5,0):setModel("SensorBuoyMKI"):setDescriptions(unscannedDescription,scannedDescription):setCallSign(medicCallSign)
	medicPoint:onPickUp(medicPointPickupProcess)
	medicPoint.action = dropOrExtractAction
	medicPoint.associatedObjectName = associatedObjectName
	medicPointList[medicCallSign] = medicPoint
	table.insert(rendezvousPoints,medicPoint)
	for pidx=1,8 do
		p = getPlayerShip(pidx)
		if p ~= nil and p:isValid() then
			if p.medicPointButton == nil then
				p.medicPointButton = {}
			end
			p.medicPointButton[medicCallSign] = true
			local tempButton = medicCallSign
			p:addCustomButton("Engineering",tempButton,string.format("Prep to %s via %s",dropOrExtractAction,medicCallSign),function()
				for pidx=1,8 do
					p = getPlayerShip(pidx)
					if p ~= nil and p:isValid() then
						for mpb, enabled in pairs(p.medicPointButton) do
							if enabled then
								p:removeCustom(mpb)
								p:addCustomMessage("Engineering","mtpbgone",string.format("Transporters ready for medical team via %s",mpb))
								p.medicPointButton[mpb] = false
							end
						end
					end
				end
			end)
		end
	end
end
function medicPointPickupProcess(self,retriever)
	local medicCallSign = self:getCallSign()
	local medicPointPrepped = false
	for mpCallSign, mp in pairs(medicPointList) do
		if mpCallSign == medicCallSign then
			medicPointList[medicCallSign] = nil
		end
	end
	for rpi, rp in pairs(rendezvousPoints) do
		if rp:getCallSign() == medicCallSign then
			table.remove(rendezvousPoints,rpi)
		end
	end
	for pidx=1,8 do
		p = getPlayerShip(pidx)
		if p ~= nil and p:isValid() then
			for mpb, enabled in pairs(p.medicPointButton) do
				if mpb == medicCallSign then
					if not enabled then
						medicPointPrepped = true
						break
					end
				end
			end
			if medicPointPrepped then
				p:removeCustom(medicCallSign)
			end
			local successful_action = false
			local completionMessage = ""
			if medicPointPrepped and p == retriever then
				completionMessage = string.format("Medical team %s action successful via %s",self.action,medicCallSign)
				if self.action == "Drop" then
					if p:getRepairCrewCount() > 0 then
						successful_action = true
						p:setRepairCrewCount(p:getRepairCrewCount() - 1)
					end
					if self.associatedObjectName ~= nil then
						completionMessage = string.format("Medical team drop action on %s successful via %s",self.associatedObjectName,medicCallSign)
					end
				else
					successful_action = true
					p:setRepairCrewCount(p:getRepairCrewCount() + 1)
					if self.associatedObjectName ~= nil then
						completionMessage = string.format("Medical team extract action from %s successful via %s",self.associatedObjectName,medicCallSign)
					end
				end
			end			
			if successful_action then
				retriever:addToShipLog(completionMessage,"Green")
				if self.action == "Drop" then
					if retriever:hasPlayerAtPosition("Engineering") then
						retriever:addCustomMessage("Engineering","mdprcd","One of your repair crew deployed with the medical team. They will return when the medical team is picked up")
					end
					if retriever:hasPlayerAtPosition("Engineering+") then
						retriever:addCustomMessage("Engineering+","mdprcd_plus","One of your repair crew deployed with the medical team. They will return when the medical team is picked up")
					end
				end
				if retriever:getEnergy() > 50 then
					retriever:setEnergy(retriever:getEnergy() - 50)
				else
					retriever:setEnergy(0)
				end
			else
				local rpx, rpy = self:getPosition()
				local unscannedDescription = string.format("Medical team %s Point",self.action)
				local scannedDescription = string.format("Medical team %s Point %s, standing by for medical team transport",self.action,medicCallSign)
				if self.associatedObjectName ~= nil then
					scannedDescription = scannedDescription .. ": " .. self.associatedObjectName
				end
				if medicPointList[medicCallSign] == nil then
					local redoMedicalPoint = Artifact():setPosition(rpx,rpy):setScanningParameters(1,1):setRadarSignatureInfo(1,.5,0):setModel("SensorBuoyMKI"):setDescriptions(unscannedDescription,scannedDescription):setCallSign(medicCallSign)
					redoMedicalPoint:onPickUp(medicPointPickupProcess)
					redoMedicalPoint.action = self.action
					redoMedicalPoint.associatedObjectName = self.associatedObjectName
					medicPointList[medicCallSign] = redoMedicalPoint
					table.insert(rendezvousPoints,redoMedicalPoint)
				end
			end
		end
	end
end
-------------------------------------------------
--	Drop Point > Medical Team Point > Near To  --
-------------------------------------------------
--Create medical team point near to selected object(s)
-- Button Text			   FD*	Related Function(s)
-- -MAIN					F	initialGMFunctions
-- -DROP POINT				F	dropPoint
-- -FROM ENG NEAR TO		F	setMedicPoint
-- Up to 3 buttons of nearby CpuShips for association
-- +90 DEGREES				D	setCreateDirection
-- +30 UNITS				D	setCreateDistance
-- CREATE AT 90 DEG, 30U	D	createMedicAway
function medicNearTo()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Drop Point",dropPoint)
	addGMFunction("-From Medic Near To",setMedicPoint)
	local objectList = getGMSelection()
	if #objectList < 1 then
		addGMMessage("Nothing selected. No action taken.")
		return
	end
	--print("got something in selection list")
	nearx = 0
	neary = 0
	if #objectList > 1 then
		nearx, neary = centerOfSelected(objectList)
	else
		nearx, neary = objectList[1]:getPosition()	
	end
	--print(string.format("nearx: %.1f, neary: %.1f",nearx,neary))
	local nearbyObjects = getObjectsInRadius(nearx, neary, 20000)
	cpuShipList = {}
	for i=1,#nearbyObjects do
		local tempObject = nearbyObjects[i]
		local tempType = tempObject.typeName
		if tempType == "CpuShip" then
			table.insert(cpuShipList,tempObject)
		end
		if #cpuShipList >= 3 then
			break
		end
	end
	if #cpuShipList > 0 then
		if #cpuShipList >= 1 then
			GMMedicAssociatedToCpuShip1 = string.format("Associate to %s",cpuShipList[1]:getCallSign())
			addGMFunction(GMMedicAssociatedToCpuShip1,function () medicAssociatedToGivenCpuShip(cpuShipList[1]) end)
		end
		if #cpuShipList >= 2 then
			GMMedicAssociatedToCpuShip2 = string.format("Associate to %s",cpuShipList[2]:getCallSign())
			addGMFunction(GMMedicAssociatedToCpuShip2,function () medicAssociatedToGivenCpuShip(cpuShipList[2]) end)
		end
		if #cpuShipList >= 3 then
			GMMedicAssociatedToCpuShip3 = string.format("Associate to %s",cpuShipList[3]:getCallSign())
			addGMFunction(GMMedicAssociatedToCpuShip3,function () medicAssociatedToGivenCpuShip(cpuShipList[3]) end)
		end
	end
	callingNearTo = medicNearTo
	GMSetCreateDirection = createDirection .. " Degrees"
	addGMFunction(string.format("+%s",GMSetCreateDirection),setCreateDirection)
	GMSetCreateDistance = createDistance .. " Units"
	addGMFunction(string.format("+%s",GMSetCreateDistance),setCreateDistance)
	GMCreateMedicAway = "Create at " .. createDirection .. " Deg, " .. createDistance .. "U"
	addGMFunction(GMCreateMedicAway,createMedicAway)
end
function medicAssociatedToGivenCpuShip(tempObject)
	local medicDistance = associatedTypeDistance["CpuShip"]
	local aox, aoy = tempObject:getPosition()
	local tempShipType = tempObject:getTypeName()
	local csd = shipTemplateDistance[tempShipType]
	if csd ~= nil then
		medicDistance = csd
	end
	local sox, soy = vectorFromAngle(random(0,360),medicDistance)
	medicCreation(aox, aoy, sox, soy)
end
--Medical team point creation after distance and direction parameters set
function createMedicAway()
	local angle = createDirection + 270
	if angle > 360 then 
		angle = angle - 360
	end
	local sox, soy = vectorFromAngle(angle,createDistance*1000)
	medicCreation(nearx, neary, sox, soy)
end
----------------------------------------
--	Drop Point > Custom Supply Point  --
----------------------------------------
-- Button Text	   FD*	Related Function(s)
-- -FROM SUPPLY			F	dropPoint
-- +MISSILES N1E1M2H4	D	setCustomMissiles
-- +ENERGY 500			D	setSupplyEnergy
-- +REPAIR CREW 0		D	setSupplyRepairCrew
-- +COOLANT 0			D	setSupplyCoolant
-- +NEAR TO				F	supplyNearTo
function setCustomSupply()
	--Default supply drop gives:
	--500 energy
	--4 Homing
	--1 Nuke
	--2 Mines
	--1 EMP
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-From Supply",dropPoint)
	local missile_label = ""
	if supplyNuke > 0 then
		missile_label = string.format("%sN%i",missile_label,supplyNuke)
	end
	if supplyEMP > 0 then
		missile_label = string.format("%sE%i",missile_label,supplyEMP)
	end
	if supplyMine > 0 then
		missile_label = string.format("%sM%i",missile_label,supplyMine)
	end
	if supplyHoming > 0 then
		missile_label = string.format("%sH%i",missile_label,supplyHoming)
	end
	if supplyHVLI > 0 then
		missile_label = string.format("%sL%i",missile_label,supplyHVLI)
	end
	missile_label = string.format("+Missiles %s",missile_label)
	addGMFunction(missile_label,setCustomMissiles)
	addGMFunction(string.format("+Energy %i",supplyEnergy),setSupplyEnergy)
	addGMFunction(string.format("+Repair Crew %i",supplyRepairCrew),setSupplyRepairCrew)
	addGMFunction(string.format("+Coolant %i",supplyCoolant),setSupplyCoolant)
	if drop_point_location == "Associated" then
		drop_point_location = "At Click"
	end
	addGMFunction(string.format("+%s",drop_point_location),setSupplyDropLocation)
	if gm_click_mode == "supply drop" then
		addGMFunction(">Set Supply Drop<",placeSupplyDrop)
	else
		addGMFunction("Set Supply Drop",placeSupplyDrop)
	end	
--	addGMFunction("+Near to",supplyNearTo)	
end
function placeSupplyDrop()
	if drop_point_location == "At Click" then
		if gm_click_mode == "supply drop" then
			gm_click_mode = nil
			onGMClick(nil)
		else
			local prev_mode = gm_click_mode
			gm_click_mode = "supply drop"
			onGMClick(gmClickSupplyDrop)
			if prev_mode ~= nil then
				addGMMessage(string.format("Cancelled current GM Click mode\n   %s\nIn favor of\n   supply drop\nGM click mode.",prev_mode))
			end
		end
		setCustomSupply()
	elseif drop_point_location == "Near To" then
		supplyNearTo()
	end
end
function gmClickSupplyDrop(x,y)
	supplyCreation(x,y,0,0)
end
---------------------------------------------------
--	Drop Point > Custom Supply Point > Missiles  --
---------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN FROM MISSILES	F	initialGMFunctions
-- -DROP POINT			F	dropPoint
-- -SUPPLY				F	setCustomSupply
-- +NUKE 1				D	setSupplyNuke
-- +EMP 1				D	setSupplyEMP
-- +MINE 2				D	setSupplyMine
-- +HOMING 4			D	setSupplyHoming
-- +HVLI 0				D	setSupplyHVLI
function setCustomMissiles()
	clearGMFunctions()
	addGMFunction("-Main From Missiles",initialGMFunctions)
	addGMFunction("-Drop Point",dropPoint)
	addGMFunction("-Supply",setCustomSupply)
	addGMFunction(string.format("+Nuke %i",supplyNuke),setSupplyNuke)
	addGMFunction(string.format("+EMP %i",supplyEMP),setSupplyEMP)
	addGMFunction(string.format("+Mine %i",supplyMine),setSupplyMine)
	addGMFunction(string.format("+Homing %i",supplyHoming),setSupplyHoming)
	addGMFunction(string.format("+HVLI %i",supplyHVLI),setSupplyHVLI)
end
-------------------------------------------------------------------------
--	Drop Point > Custom Supply Point > At Click (drop point location)  --
-------------------------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN FRM DROP LOC	F	initialGMFunctions
-- -TO DROP POINT		F	dropPoint
-- -SUPPLY				F	setCustomSupply
-- AT CLICK*			*	inline
-- NEAR TO				*	inline
function setSupplyDropLocation()
	clearGMFunctions()
	addGMFunction("-Main frm Drop Loc",initialGMFunctions)
	addGMFunction("-To Drop Point",dropPoint)
	addGMFunction("-Supply",setCustomSupply)
	local button_label = "At Click"
	if drop_point_location == "At Click" then
		button_label = button_label .. "*"
	end
	addGMFunction(button_label,function()
		drop_point_location = "At Click"
		setCustomSupply()
	end)
	button_label = "Near To"
	if drop_point_location == "Near To" then
		button_label = button_label .. "*"
	end
	addGMFunction(button_label,function()
		drop_point_location = "Near To"
		setCustomSupply()
	end)
end
-------------------------------------------------
--	Drop Point > Custom Supply Point > Energy  --
-------------------------------------------------
-- Button Text	   FD*	Related Function(s)
-- -MAIN			F	initialGMFunctions
-- -DROP POINT		F	dropPoint
-- -FROM ENERGY		F	setCustomSupply
-- 500-100=400		D	subtract100Energy
-- 500+100=600		D	add100Energy
function setSupplyEnergy()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Drop Point",dropPoint)
	addGMFunction("-From Energy",setCustomSupply)
	if supplyEnergy > 0 then
		local GMSubtract100Energy = string.format("%i-100=%i",supplyEnergy,supplyEnergy - 100)
		addGMFunction(GMSubtract100Energy,subtract100Energy)
	end
	if supplyEnergy < 1000 then
		local GMAdd100Energy = string.format("%i+100=%i",supplyEnergy,supplyEnergy + 100)
		addGMFunction(GMAdd100Energy,add100Energy)
	end
end
function subtract100Energy()
	supplyEnergy = supplyEnergy - 100
	setSupplyEnergy()
end
function add100Energy()
	supplyEnergy = supplyEnergy + 100
	setSupplyEnergy()
end
-----------------------------------------------
--	Drop Point > Custom Supply Point > Nuke  --
-----------------------------------------------
-- Button Text	   FD*	Related Function(s)
-- -MAIN			F	initialGMFunctions
-- -DROP POINT		F	dropPoint
-- -CUSTOM SUPPLY	F	setCustomSupply
-- -FROM NUKE		F	setCustomMissiles
-- 1-1=0			D	subtractANuke
-- 1+1=2			D	addANuke
function setSupplyNuke()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Drop Point",dropPoint)
	addGMFunction("-Custom Supply",setCustomSupply)
	addGMFunction("-From Nuke",setCustomMissiles)
	if supplyNuke > 0 then
		local GMSubtractANuke = string.format("%i-1=%i",supplyNuke,supplyNuke - 1)
		addGMFunction(GMSubtractANuke,subtractANuke)
	end
	if supplyNuke < 20 then
		local GMAddANuke = string.format("%i+1=%i",supplyNuke,supplyNuke + 1)
		addGMFunction(GMAddANuke,addANuke)
	end
end
function subtractANuke()
	supplyNuke = supplyNuke - 1
	setSupplyNuke()
end
function addANuke()
	supplyNuke = supplyNuke + 1
	setSupplyNuke()
end
----------------------------------------------
--	Drop Point > Custom Supply Point > EMP  --
----------------------------------------------
-- Button Text	   FD*	Related Function(s)
-- -MAIN			F	initialGMFunctions
-- -DROP POINT		F	dropPoint
-- -CUSTOM SUPPLY	F	setCustomSupply
-- -FROM EMP		F	setCustomMissiles
-- 1-1=0			D	subtractAnEMP
-- 1+1=2			D	addAnEMP
function setSupplyEMP()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Drop Point",dropPoint)
	addGMFunction("-Custom Supply",setCustomSupply)
	addGMFunction("-From EMP",setCustomMissiles)
	if supplyEMP > 0 then
		local GMSubtractAnEMP = string.format("%i-1=%i",supplyEMP,supplyEMP - 1)
		addGMFunction(GMSubtractAnEMP,subtractAnEMP)
	end
	if supplyEMP < 20 then
		local GMAddAnEMP = string.format("%i+1=%i",supplyEMP,supplyEMP + 1)
		addGMFunction(GMAddAnEMP,addAnEMP)
	end
end
function subtractAnEMP()
	supplyEMP = supplyEMP - 1
	setSupplyEMP()
end
function addAnEMP()
	supplyEMP = supplyEMP + 1
	setSupplyEMP()
end
-----------------------------------------------
--	Drop Point > Custom Supply Point > Mine  --
-----------------------------------------------
-- Button Text	   FD*	Related Function(s)
-- -MAIN			F	initialGMFunctions
-- -DROP POINT		F	dropPoint
-- -CUSTOM SUPPLY	F	setCustomSupply
-- -FROM MINE		F	setCustomMissiles
-- 2-1=1			D	subtractAMine
-- 2+1=3			D	addAMine
function setSupplyMine()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Drop Point",dropPoint)
	addGMFunction("-Custom Supply",setCustomSupply)
	addGMFunction("-From Mine",setCustomMissiles)
	if supplyMine > 0 then
		local GMSubtractAMine = string.format("%i-1=%i",supplyMine,supplyMine - 1)
		addGMFunction(GMSubtractAMine,subtractAMine)
	end
	if supplyMine < 20 then
		local GMAddAMine = string.format("%i+1=%i",supplyMine,supplyMine + 1)
		addGMFunction(GMAddAMine,addAMine)
	end
end
function subtractAMine()
	supplyMine = supplyMine - 1
	setSupplyMine()
end
function addAMine()
	supplyMine = supplyMine + 1
	setSupplyMine()
end
-------------------------------------------------
--	Drop Point > Custom Supply Point > Homing  --
-------------------------------------------------
-- Button Text	   FD*	Related Function(s)
-- -MAIN			F	initialGMFunctions
-- -DROP POINT		F	dropPoint
-- -CUSTOM SUPPLY	F	setCustomSupply
-- -FROM HOMING		F	setCustomMissiles
-- 4-1=3			D	subtractAHoming
-- 4+1=5			D	addAHoming
function setSupplyHoming()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Drop Point",dropPoint)
	addGMFunction("-Custom Supply",setCustomSupply)
	addGMFunction("-From Homing",setCustomMissiles)
	if supplyHoming > 0 then
		local GMSubtractAHoming = string.format("%i-1=%i",supplyHoming,supplyHoming - 1)
		addGMFunction(GMSubtractAHoming,subtractAHoming)
	end
	if supplyHoming < 20 then
		local GMAddAHoming = string.format("%i+1=%i",supplyHoming,supplyHoming + 1)
		addGMFunction(GMAddAHoming,addAHoming)
	end
end
function subtractAHoming()
	supplyHoming = supplyHoming - 1
	setSupplyHoming()
end
function addAHoming()
	supplyHoming = supplyHoming + 1
	setSupplyHoming()
end
-----------------------------------------------
--	Drop Point > Custom Supply Point > HVLI  --
-----------------------------------------------
-- Button Text	   FD*	Related Function(s)
-- -MAIN			F	initialGMFunctions
-- -DROP POINT		F	dropPoint
-- -CUSTOM SUPPLY	F	setCustomSupply
-- -FROM HVLI		F	setCustomMissiles
-- 0+1=1			D	addAnHVLI
function setSupplyHVLI()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Drop Point",dropPoint)
	addGMFunction("-Custom Supply",setCustomSupply)
	addGMFunction("-From HVLI",setCustomMissiles)
	if supplyHVLI > 0 then
		local GMSubtractAnHVLI = string.format("%i-1=%i",supplyHVLI,supplyHVLI - 1)
		addGMFunction(GMSubtractAnHVLI,subtractAnHVLI)
	end
	if supplyHVLI < 20 then
		local GMAddAnHVLI = string.format("%i+1=%i",supplyHVLI,supplyHVLI + 1)
		addGMFunction(GMAddAnHVLI,addAnHVLI)
	end
end
function subtractAnHVLI()
	supplyHVLI = supplyHVLI - 1
	setSupplyHVLI()
end
function addAnHVLI()
	supplyHVLI = supplyHVLI + 1
	setSupplyHVLI()
end
------------------------------------------------------
--	Drop Point > Custom Supply Point > Repair Crew  --
------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN				F	initialGMFunctions
-- -DROP POINT			F	dropPoint
-- -FROM REPAIR CREW	F	setCustomSupply
-- 0+1=1				D	addARepairCrew
function setSupplyRepairCrew()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Drop Point",dropPoint)
	addGMFunction("-From Repair Crew",setCustomSupply)
	if supplyRepairCrew > 0 then
		local GMSubtractARepairCrew = string.format("%i-1=%i",supplyRepairCrew,supplyRepairCrew - 1)
		addGMFunction(GMSubtractARepairCrew,subtractARepairCrew)
	end
	if supplyRepairCrew < 3 then
		local GMAddARepairCrew = string.format("%i+1=%i",supplyRepairCrew,supplyRepairCrew + 1)
		addGMFunction(GMAddARepairCrew,addARepairCrew)
	end
end
function subtractARepairCrew()
	supplyRepairCrew = supplyRepairCrew - 1
	setSupplyRepairCrew()
end
function addARepairCrew()
	supplyRepairCrew = supplyRepairCrew + 1
	setSupplyRepairCrew()
end
--------------------------------------------------
--	Drop Point > Custom Supply Point > Coolant  --
--------------------------------------------------
-- Button Text	   FD*	Related Function(s)
-- -MAIN			F	initialGMFunctions
-- -DROP POINT		F	dropPoint
-- -FROM COOLANT	F	setCustomSupply
-- 0+1=1			D	addCoolant
function setSupplyCoolant()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Drop Point",dropPoint)
	addGMFunction("-From Coolant",setCustomSupply)
	if supplyCoolant > 0 then
		local GMSubtractCoolant = string.format("%i-1=%i",supplyCoolant,supplyCoolant - 1)
		addGMFunction(GMSubtractCoolant,subtractCoolant)
	end
	if supplyCoolant < 5 then
		local GMAddCoolant = string.format("%i+1=%i",supplyCoolant,supplyCoolant + 1)
		addGMFunction(GMAddCoolant,addCoolant)
	end
end
function subtractCoolant()
	supplyCoolant = supplyCoolant - 1
	setSupplyCoolant()
end
function addCoolant()
	supplyCoolant = supplyCoolant + 1
	setSupplyCoolant()
end
--------------------------------------------------
--	Drop Point > Custom Supply Point > Near To  --
--------------------------------------------------
-- Button Text			   FD*	Related Function(s)
-- -MAIN					F	initialGMFunctions
-- -DROP POINT				F	dropPoint
-- -FROM SUPPLY NEAR TO		F	setCustomSupply
-- +90 DEGREES				D	setCreateDirection
-- +30 UNITS				D	setCreateDistance
-- CREATE AT 90 DEG, 30U	D	createSupplyAway
function supplyNearTo()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Drop Point",dropPoint)
	addGMFunction("-From Supply Near To",setCustomSupply)
	local objectList = getGMSelection()
	if #objectList < 1 then
		addGMMessage("Nothing selected to relate to supply drop. No action taken")
		return
	end
	nearx = 0
	neary = 0
	if #objectList > 1 then
		nearx, neary = centerOfSelected(objectList)
	else
		nearx, neary = objectList[1]:getPosition()	
	end
	local nearbyObjects = getObjectsInRadius(nearx, neary, 20000)
	callingNearTo = supplyNearTo
	GMSetCreateDirection = createDirection .. " Degrees"
	addGMFunction(string.format("+%s",GMSetCreateDirection),setCreateDirection)
	GMSetCreateDistance = createDistance .. " Units"
	addGMFunction(string.format("+%s",GMSetCreateDistance),setCreateDistance)
	GMCreateSupplyAway = "Create at " .. createDirection .. " Deg, " .. createDistance .. "U"
	addGMFunction(GMCreateSupplyAway,createSupplyAway)
end
function createSupplyAway()
	local angle = createDirection + 270
	if angle > 360 then 
		angle = angle - 360
	end
	local sox, soy = vectorFromAngle(angle,createDistance*1000)
	supplyCreation(nearx, neary, sox, soy)
end
function supplyCreation(originx, originy, vectorx, vectory)
	local customSupplyDrop = SupplyDrop():setEnergy(supplyEnergy):setFaction("Human Navy"):setPosition(originx+vectorx,originy+vectory)
	customSupplyDrop:setWeaponStorage("Nuke",supplyNuke)
	customSupplyDrop:setWeaponStorage("EMP",supplyEMP)
	customSupplyDrop:setWeaponStorage("Homing",supplyHoming)
	customSupplyDrop:setWeaponStorage("Mine",supplyMine)
	customSupplyDrop:setWeaponStorage("HVLI",supplyHVLI)
	if supplyRepairCrew > 0 then
		customSupplyDrop.repairCrew = supplyRepairCrew
	end
	if supplyCoolant > 0 then
		customSupplyDrop.coolant = supplyCoolant
	end
	local supplyLabel = ""
	if supplyEnergy > 0 then
		supplyLabel = supplyLabel .. string.format("B%i ",supplyEnergy)
	end
	if supplyNuke > 0 then
		supplyLabel = supplyLabel .. string.format("N%i ",supplyNuke)
	end
	if supplyEMP > 0 then
		supplyLabel = supplyLabel .. string.format("E%i ",supplyEMP)
	end
	if supplyMine > 0 then
		supplyLabel = supplyLabel .. string.format("M%i ",supplyMine)
	end
	if supplyHoming > 0 then
		supplyLabel = supplyLabel .. string.format("H%i ",supplyHoming)
	end
	if supplyHVLI > 0 then
		supplyLabel = supplyLabel .. string.format("L%i ",supplyHVLI)
	end
	if supplyRepairCrew > 0 then
		supplyLabel = supplyLabel .. string.format("R%i ",supplyRepairCrew)
	end
	if supplyCoolant > 0 then
		supplyLabel = supplyLabel .. string.format("C%i ",supplyCoolant)
	end
	customSupplyDrop:setCallSign(supplyLabel)
	customSupplyDrop:onPickUp(supplyPickupProcess)
end
function supplyPickupProcess(self, player)
	string.format("")	--necessary to have global reference for Serious Proton engine
	if self.repairCrew ~= nil then
		player:setRepairCrewCount(player:getRepairCrewCount() + self.repairCrew)
	end
	if self.coolant ~= nil then
		player:setMaxCoolant(player:getMaxCoolant() + self.coolant)
	end
end
----------------------------
--	Drop Points > Attach  --
----------------------------
-- Button Text			   FD*	Related Function(s)
-- -MAIN FROM ATTACH		F	initialGMFunctions
-- -DROP POINT				F	dropPoint
-- +SELECT DROP POINT		F	attachArtifact
-- or list of CCPU Ships to attach
function attachArtifact()
	clearGMFunctions()
	addGMFunction("-Main from attach",initialGMFunctions)
	addGMFunction("-Drop point",dropPoint)
	local object_list = getGMSelection()
	if #object_list < 1 or #object_list > 1 then
		addGMFunction("+Select drop point",attachArtifact)
		return
	end
	local current_selected_object = object_list[1]
	local current_selected_object_type = current_selected_object.typeName
	if current_selected_object_type ~= "Artifact" and current_selected_object_type ~= "SupplyDrop" then
		addGMFunction("+Select drop point",attachArtifact)
	else
		if current_selected_object_type == "Artifact" then
			if escapePodList[current_selected_object:getCallSign()] == nil then
				addGMFunction("+Select drop point",attachArtifact)
				return
			end
		else	--supply drop
			if current_selected_object:getCallSign() == nil then
				addGMFunction("+Select drop point",attachArtifact)
				return
			end
		end
		local pod_x, pod_y = current_selected_object:getPosition()
		local nearby_objects = getObjectsInRadius(pod_x, pod_y, 40000)
		cpu_ship_list = {}
		for i=1,#nearby_objects do
			local temp_object = nearby_objects[i]
			local temp_type = temp_object.typeName
			if temp_type == "CpuShip" then
				local ship_distance = distance(temp_object,current_selected_object)
				table.insert(cpu_ship_list,{distance = ship_distance, ship = temp_object})
			end
		end
		if #cpu_ship_list > 0 then
			table.sort(cpu_ship_list,function(a,b)
				return a.distance < b.distance
			end)
			if #cpu_ship_list >= 1 then
				addGMFunction(string.format("Attach to %s",cpu_ship_list[1].ship:getCallSign()), function()
					local attach_target_x, attach_target_y = cpu_ship_list[1].ship:getPosition()
					local relative_attach_x = pod_x - attach_target_x
					local relative_attach_y = pod_y - attach_target_y
					update_system:addAttachedUpdate(current_selected_object,cpu_ship_list[1].ship,relative_attach_x,relative_attach_y)
				end)
			end
			if #cpu_ship_list >= 2 then
				addGMFunction(string.format("Attach to %s",cpu_ship_list[2].ship:getCallSign()), function()
					local attach_target_x, attach_target_y = cpu_ship_list[2].ship:getPosition()
					local relative_attach_x = pod_x - attach_target_x
					local relative_attach_y = pod_y - attach_target_y
					update_system:addAttachedUpdate(current_selected_object,cpu_ship_list[2].ship,relative_attach_x,relative_attach_y)
				end)
			end
			if #cpu_ship_list >= 3 then
				addGMFunction(string.format("Attach to %s",cpu_ship_list[3].ship:getCallSign()), function()
					local attach_target_x, attach_target_y = cpu_ship_list[3].ship:getPosition()
					local relative_attach_x = pod_x - attach_target_x
					local relative_attach_y = pod_y - attach_target_y
					update_system:addAttachedUpdate(current_selected_object,cpu_ship_list[3],relative_attach_x,relative_attach_y)
				end)
			end
		else
			if current_selected_object_type == "Artifact" then
				addGMMessage("No CPU Ships within 40 units of selected escape pod")
			else
				addGMMessage("No CPU Ships within 40 units of selected supply drop")
			end
			addGMFunction("+Select drop point",attachArtifact)
		end
	end
end
----------------------------
--	Drop Points > Detach  --
----------------------------
-- Button Text			   FD*	Related Function(s)
-- -MAIN FROM DETACH		F	initialGMFunctions
-- -DROP POINT				F	dropPoint
-- +SELECT DROP POINT		F	detachArtifact
function detachArtifact()
	clearGMFunctions()
	addGMFunction("-Main from detach",initialGMFunctions)
	addGMFunction("-Drop point",dropPoint)
	local object_list = getGMSelection()
	if #object_list < 1 or #object_list > 1 then
		addGMFunction("+Select drop point",detachArtifact)
		return
	end
	local current_selected_object = object_list[1]
	local current_selected_object_type = current_selected_object.typeName
	if current_selected_object_type ~= "Artifact" and current_selected_object_type ~= "SupplyDrop" then
		addGMFunction("+Select drop point",detachArtifact)
	else
		if current_selected_object_type == "Artifact" then
			if escapePodList[current_selected_object:getCallSign()] == nil then
				addGMFunction("+Select drop point",detachArtifact)
				return
			end
		else	--supply drop
			if current_selected_object:getCallSign() == nil then
				addGMFunction("+Select drop point",detachArtifact)
				return
			end
		end
		update_system:removeUpdateNamed(current_selected_object,"attached")
	end
end
--	*											   *  --
--	**											  **  --
--	************************************************  --
--	****				Scan Clue				****  --
--	************************************************  --
--	**											  **  --
--	*											   *  --
-----------------------------------------
--  Scan Clue > Unscanned Description  --
-----------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN				F	initialGMFunctions
-- -FROM UNSCAN DESC	F	scanClue
-- Buttons listing unscanned choices in table unscannedClues defined in constants
function setUnscannedDescription()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-From Unscan Desc",scanClue)
	for uck, ucv in pairs(unscannedClues) do
		local GMShortUnscannedClue = uck
		if uck == unscannedClueKey then
			GMShortUnscannedClue = uck .. "*"
		end
		addGMFunction(GMShortUnscannedClue,function()
			unscannedClueKey = uck
			setUnscannedDescription()
		end)
	end
end
---------------------------------------
--	Scan Clue > Scanned Description  --
---------------------------------------
-- -MAIN			F	initialGMFunctions
-- -FROM SCAN DESC	F	scanClue
-- +NONE			D	scannedClue1
-- +NONE			D	scannedClue2
-- +NONE			D	scannedClue3
-- +NONE			D	scannedClue4
-- +NONE			D	scannedClue5
function setScannedDescription()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-From Scan Desc",scanClue)
	addGMFunction(string.format("+%s",scannedClueKey1),scannedClue1)
	addGMFunction(string.format("+%s",scannedClueKey2),scannedClue2)
	addGMFunction(string.format("+%s",scannedClueKey3),scannedClue3)
	addGMFunction(string.format("+%s",scannedClueKey4),scannedClue4)
	addGMFunction(string.format("+%s",scannedClueKey5),scannedClue5)
end
------------------------------------------------------------
--	Scan Clue > Scan Complexity (Set How Many Scan Bars)  --
------------------------------------------------------------
-- Button Text	   FD*	Related Function(s)
-- -MAIN			F	initialGMFunctions
-- -SCAN			F	scanClue
-- COMPLEXITY: 1*	*	inline		asterisk = current selection
-- COMPLEXITY: 2	*	inline
-- COMPLEXITY: 3	*	inline
-- COMPLEXITY: 4	*	inline
function setScanComplexity()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Scan",scanClue)
	for i=1,4 do
		local GMSetScanComplexityIndex = "Complexity: " .. i
		if scanComplexity == i then
			GMSetScanComplexityIndex = "Complexity: " .. i .. "*"
		end
		addGMFunction(GMSetScanComplexityIndex, function()
			scanComplexity = i
			setScanComplexity()
		end)
	end
end
------------------------------------------------------------
--	Scan Clue > Scan Depth (Set How Many Scan Screens)  --
------------------------------------------------------------
-- Button Text	   FD*	Related Function(s)
-- -MAIN			F	initialGMFunctions
-- -SCAN			F	scanClue
-- DEPTH: 1*		*	inline		asterisk = current selection
-- DEPTH: 2			*	inline
-- DEPTH: 3			*	inline
-- DEPTH: 4			*	inline
function setScanDepth()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Scan",scanClue)
	for i=1,8 do
		local GMSetScanDepthIndex = "Depth: " .. i
		if scanDepth == i then
			GMSetScanDepthIndex = "Depth: " .. i .. "*"
		end
		addGMFunction(GMSetScanDepthIndex, function()
			scanDepth = i
			setScanDepth()
		end)
	end
end
-------------------------------------------------------
--	Scan Clue > Scanned Descriptions > None (first)  --
-------------------------------------------------------
-- Button Text	   FD*	Related Function(s)
-- -MAIN			F	initialGMFunctions
-- -SCAN			F	scanClue
-- -FROM DESC 1		F	setScannedDescription
-- Button for each item in table scannedClues1 defined in constants
function scannedClue1()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Scan",scanClue)
	addGMFunction("-From Desc 1",setScannedDescription)
	for sck, scv in pairs(scannedClues1) do
		local GMShortScannedClue = sck
		if sck == scannedClueKey1 then
			GMShortScannedClue = sck .. "*"
		end
		addGMFunction(GMShortScannedClue, function()
			scannedClueKey1 = sck
			scannedClue1()
		end)
	end
end
--------------------------------------------------------
--	Scan Clue > Scanned Descriptions > None (second)  --
--------------------------------------------------------
-- Button Text	   FD*	Related Function(s)
-- -MAIN			F	initialGMFunctions
-- -SCAN			F	scanClue
-- -FROM DESC 2		F	setScannedDescription
-- Button for each item in table scannedClues2 defined in constants
function scannedClue2()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Scan",scanClue)
	addGMFunction("-From Desc 2",setScannedDescription)
	for sck, scv in pairs(scannedClues2) do
		local GMShortScannedClue = sck
		if sck == scannedClueKey2 then
			GMShortScannedClue = sck .. "*"
		end
		addGMFunction(GMShortScannedClue, function()
			scannedClueKey2 = sck
			scannedClue2()
		end)
	end
end
-------------------------------------------------------
--	Scan Clue > Scanned Descriptions > None (third)  --
-------------------------------------------------------
-- Button Text	   FD*	Related Function(s)
-- -MAIN			F	initialGMFunctions
-- -SCAN			F	scanClue
-- -FROM DESC 3		F	setScannedDescription
-- Button for each item in table scannedClues3 defined in constants
function scannedClue3()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Scan",scanClue)
	addGMFunction("-From Desc 3",setScannedDescription)
	for sck, scv in pairs(scannedClues3) do
		local GMShortScannedClue = sck
		if sck == scannedClueKey3 then
			GMShortScannedClue = sck .. "*"
		end
		addGMFunction(GMShortScannedClue, function()
			scannedClueKey3 = sck
			scannedClue3()
		end)
	end
end
--------------------------------------------------------
--	Scan Clue > Scanned Descriptions > None (fourth)  --
--------------------------------------------------------
-- Button Text	   FD*	Related Function(s)
-- -MAIN			F	initialGMFunctions
-- -SCAN			F	scanClue
-- -FROM DESC 4		F	setScannedDescription
-- Button for each item in table scannedClues4 defined in constants
function scannedClue4()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Scan",scanClue)
	addGMFunction("-From Desc 4",setScannedDescription)
	for sck, scv in pairs(scannedClues4) do
		local GMShortScannedClue = sck
		if sck == scannedClueKey4 then
			GMShortScannedClue = sck .. "*"
		end
		addGMFunction(GMShortScannedClue, function()
			scannedClueKey4 = sck
			scannedClue4()
		end)
	end
end
-------------------------------------------------------
--	Scan Clue > Scanned Descriptions > None (fifth)  --
-------------------------------------------------------
-- Button Text	   FD*	Related Function(s)
-- -MAIN			F	initialGMFunctions
-- -SCAN			F	scanClue
-- -FROM DESC 5		F	setScannedDescription
-- Button for each item in table scannedClues5 defined in constants
function scannedClue5()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Scan",scanClue)
	addGMFunction("-From Desc 5",setScannedDescription)
	for sck, scv in pairs(scannedClues5) do
		local GMShortScannedClue = sck
		if sck == scannedClueKey5 then
			GMShortScannedClue = sck .. "*"
		end
		addGMFunction(GMShortScannedClue, function()
			scannedClueKey5 = sck
			scannedClue5()
		end)
	end
end
-----------------------------------------------------
--	Scan Clue > At Click (Set scan clue location)  --
-----------------------------------------------------
-- Button Text			   FD*	Related Function(s)
-- -MAIN FRM CLUE LOC		F	initialGMFunctions
-- -TO SCAN CLUE			F	scanClue
-- AT CLICK*				*	inline
-- NEAR TO					*	inline
function setScanClueLocation()
	clearGMFunctions()
	addGMFunction("-Main frm Clue Loc",initialGMFunctions)
	addGMFunction("-To Scan Clue",scanClue)
	local button_label = "At Click"
	if scan_clue_location == "At Click" then
		button_label = button_label .. "*"
	end
	addGMFunction(button_label,function()
		scan_clue_location = "At Click"
		scanClue()
	end)
	button_label = "Near To"
	if scan_clue_location == "Near To" then
		button_label = button_label .. "*"
	end
	addGMFunction(button_label,function()
		scan_clue_location = "Near To"
		scanClue()
	end)
end
----------------------------
--	Scan Clue >  Near To  --
----------------------------
-- Button Text			   FD*	Related Function(s)
-- -MAIN					F	initialGMFunctions
-- -FROM SCAN NEAR TO		F	scanClue
-- +90 DEGREES				D	setCreateDirection
-- +30 UNITS				D	setCreateDistance
-- CREATE AT 90 DEG, 30U	D	createScanClueAway
function scanClueNearTo()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-From Scan Near To",scanClue)
	local objectList = getGMSelection()
	if #objectList < 1 then
		addGMMessage("You need to select something. No action taken")
		return
	end
	nearx = 0
	neary = 0
	if #objectList > 1 then
		nearx, neary = centerOfSelected(objectList)
	else
		nearx, neary = objectList[1]:getPosition()	
	end
	--print(string.format("nearx: %.1f, neary: %.1f",nearx,neary))
	callingNearTo = scanClueNearTo
	GMSetCreateDirection = createDirection .. " Degrees"
	addGMFunction(string.format("+%s",GMSetCreateDirection),setCreateDirection)
	GMSetCreateDistance = createDistance .. " Units"
	addGMFunction(string.format("+%s",GMSetCreateDistance),setCreateDistance)
	GMCreateScanClueAway = "Create at " .. createDirection .. " Deg, " .. createDistance .. "U"
	addGMFunction(GMCreateScanClueAway,createScanClueAway)
end
function createScanClueAway()
	local angle = createDirection + 270
	if angle > 360 then 
		angle = angle - 360
	end
	local sox, soy = vectorFromAngle(angle,createDistance*1000)
	scanClueCreation(nearx, neary, sox, soy)
end
function scanClueCreation(originx, originy, vectorx, vectory, associatedObjectName)
	artifactCounter = artifactCounter + 1
	artifactNumber = artifactNumber + math.random(1,5)
	local randomPrefix = string.char(math.random(65,90))
	local medicCallSign = string.format("%s%i",randomPrefix,artifactNumber)
	local unscannedDescription = unscannedClues[unscannedClueKey]
	local scannedDescription = ""
	if scannedClues1[scannedClueKey1] ~= nil and scannedClues1[scannedClueKey1] ~= "None" then
		scannedDescription = scannedDescription .. scannedClues1[scannedClueKey1] .. " "
	end
	if scannedClues2[scannedClueKey2] ~= nil and scannedClues2[scannedClueKey2] ~= "None" then
		scannedDescription = scannedDescription .. scannedClues2[scannedClueKey2] .. " "
	end
	if scannedClues3[scannedClueKey3] ~= nil and scannedClues3[scannedClueKey3] ~= "None" then
		scannedDescription = scannedDescription .. scannedClues3[scannedClueKey3] .. " "
	end
	if scannedClues4[scannedClueKey4] ~= nil and scannedClues4[scannedClueKey4] ~= "None" then
		scannedDescription = scannedDescription .. scannedClues4[scannedClueKey4] .. " "
	end
	if scannedClues5[scannedClueKey5] ~= nil and scannedClues5[scannedClueKey5] ~= "None" then
		scannedDescription = scannedDescription .. scannedClues5[scannedClueKey5] .. " "
	end
	local scanCluePoint = Artifact():setPosition(originx+vectorx,originy+vectory):setScanningParameters(scanComplexity,scanDepth):setRadarSignatureInfo(random(0,1),random(0,1),random(0,1)):setDescriptions(unscannedDescription,scannedDescription)
	if scan_clue_retrievable then
		scanCluePoint:allowPickup(true)
	else
		scanCluePoint:allowPickup(false)
	end
	if scan_clue_expire then
		update_system:addTimeToLiveUpdate(scanCluePoint)
	end
end
--	*												   *  --
--	**												  **  --
--	****************************************************  --
--	****				Tweak Terrain				****  --
--	****************************************************  --
--	**												  **  --
--	*												   *  --
-----------------------------------
-- Tweak Terrain > Update editor --
-----------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN				F	initialGMFunctions
-- -TWEAK				F	tweakTerrain
-- +EDIT SELECTED		F	editSelected
function updateEditor()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Tweak",tweakTerrain)
	addGMFunction("+Edit Selected",function()
		local objectList = getGMSelection()
		if #objectList ~= 1 then
			addGMMessage("to edit select one (and only one) object before selecting the edit button")
			return
		end
		update_edit_object=objectList[1]
		editSelected()
	end)
end
------------------------------------------------------------------------
-- Tweak Terrain > Update editor > List of edits for selected object  --
------------------------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN				F	initialGMFunctions
-- -TWEAK				F	tweakTerrain
-- -UPDATE EDITOR		F	updateEditor
-- ---OBJECT EDIT---	F	none - UI element
-- followed by a dynamically generated list of updates on the object
function editSelected()
	if updateEditObjectValid() then
		clearGMFunctions()
		addGMFunction("-Main",initialGMFunctions)
		addGMFunction("-Tweak",tweakTerrain)
		addGMFunction("-update editor",updateEditor)
		addGMFunction("---object edit---",nil)
		local updateTypes = update_system:getUpdateNamesOnObject(update_edit_object)
		for index=1,#updateTypes do
			local name="+"..updateTypes[index].name
			local editElements=updateTypes[index].edit
			assert(editElements ~= nil)
			assert(type(editElements)=="table")
			addGMFunction(name,editUpdate(updateTypes[index].name,editElements))
		end
	end
end
--------------------------------------------------------------------
-- Tweak Terrain > Update editor > Selected object > edit update  --
--------------------------------------------------------------------
-- captures a name for the update type and then returns a function like
-- Button Text		   FD*	Related Function(s)
-- -MAIN				F	initialGMFunctions
-- -TWEAK				F	tweakTerrain
-- -UPDATE EDITOR		F	updateEditor
-- -EDIT				F	editSelected
-- ---NAME EDIT---		D	none - UI element
-- REMOVE				F	inline
-- followed by a list of dynamically created edit buttons
function editUpdate(name,editElements)
	assert(type(name)=="string")
	assert(type(editElements)=="table")
	return function()
		if updateEditObjectValid() then
			clearGMFunctions()
			addGMFunction("-Main",initialGMFunctions)
			addGMFunction("-Tweak",tweakTerrain)
			addGMFunction("-update editor",updateEditor)
			addGMFunction("-edit",editSelected)
			addGMFunction("---"..name.." edit---",nil)
			addGMFunction("remove",function()
				if updateEditObjectValid() then
					update_system:removeUpdateNamed(update_edit_object,name)
					editSelected()
				end
			end)
			for index=1,#editElements do
				assert(type(editElements[index].name)=="string")
				local edit=editElements[index]
				edit.closers=function()
					clearGMFunctions()
					addGMFunction("-Main",initialGMFunctions)
					addGMFunction("-Tweak",tweakTerrain)
					addGMFunction("-update editor",updateEditor)
					addGMFunction("-edit",editSelected)
					addGMFunction("-"..name,editUpdate(name,editElements))
				end
				addGMFunction(editElements[index].name,numericEditControl(edit))
			end
		end
	end
end
------------------------------------------
--	Tweak Terrain > Station Operations  --
------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN				F	initialGMFunctions
-- -TWEAK TERRAIN		F	tweakTerrain
-- PROBES ON			D	inline
-- REPAIR ON			D	inline
-- ENERGY ON			D	inline
function stationOperations()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Tweak Terrain",tweakTerrain)
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		addGMFunction("+Select Station",stationOperations)
	else
		local first_object = objectList[1]
		local object_type = first_object.typeName
		if object_type ~= "SpaceStation" then
			addGMFunction("+Select Station",stationDefense)
		else
			local button_label = "Probes"
			if first_object:getRestocksScanProbes() then
				button_label = string.format("%s On",button_label)
			else
				button_label = string.format("%s Off",button_label)
			end
			addGMFunction(button_label,function()
				local objectList = getGMSelection()
				if #objectList == 1 then
					local first_object = objectList[1]
					local object_type = first_object.typeName
					if object_type == "SpaceStation" then
						if first_object:getRestocksScanProbes() then
							first_object:setRestocksScanProbes(false)
						else
							first_object:setRestocksScanProbes(true)
						end
						stationOperations()
					else
						addGMMessage("Station not selected. No action taken")
					end
				else
					addGMMessage("Select only one object. No action taken")
				end
			end)
			if first_object:getRepairDocked() then
				button_label = "Repair On"
			else
				button_label = "Repair Off"
			end
			addGMFunction(button_label,function()
				local objectList = getGMSelection()
				if #objectList == 1 then
					local first_object = objectList[1]
					local object_type = first_object.typeName
					if object_type == "SpaceStation" then
						if first_object:getRepairDocked() then
							first_object:setRepairDocked(false)
						else
							first_object:setRepairDocked(true)
						end
						stationOperations()
					else
						addGMMessage("Station not selected. No action taken")
					end
				else
					addGMMessage("Select only one object. No action taken")
				end
			end)
			if first_object:getSharesEnergyWithDocked() then
				button_label = "Energy On"
			else
				button_label = "Energy Off"
			end
			addGMFunction(button_label,function()
				local objectList = getGMSelection()
				if #objectList == 1 then
					local first_object = objectList[1]
					local object_type = first_object.typeName
					if object_type == "SpaceStation" then
						if first_object:getSharesEnergyWithDocked() then
							first_object:setSharesEnergyWithDocked(false)
						else
							first_object:setSharesEnergyWithDocked(true)
						end
						stationOperations()
					else
						addGMMessage("Station not selected. No action taken")
					end
				else
					addGMMessage("Select only one object. No action taken")
				end
			end)
		end
	end
end
---------------------------------------
--	Tweak Terrain > Station Defense  --
---------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN				F	initialGMFunctions
-- -TWEAK TERRAIN		F	tweakTerrain
-- +DEFENSIVE FLEET		F	stationDefensiveFleet
-- +INNER RING			F	stationDefensiveInnerRing
-- +OUTER RING			F	stationDefensiveOuterRing
-- AUTOROTATE NO		D	inline
function stationDefense()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Tweak Terrain",tweakTerrain)
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		addGMFunction("+Select Station",stationDefense)
	else
		local first_object = objectList[1]
		local object_type = first_object.typeName
		if object_type ~= "SpaceStation" then
			addGMFunction("+Select Station",stationDefense)
		else
			addGMFunction("+Defensive Fleet",stationDefensiveFleet)
			addGMFunction("+Inner Ring",stationDefensiveInnerRing)
			addGMFunction("+Outer Ring",stationDefensiveOuterRing)
			if rotate_station == nil then
				rotate_station = {}
			end
			local found_rotate_station = false
			for i=1,#rotate_station do
				if rotate_station[i] == first_object then
					found_rotate_station = true
					break
				end
			end
			local button_label = "Autorotate No"
			if found_rotate_station then
				button_label = "Autorotate Yes"
			end
			addGMFunction(button_label,function()
				local objectList = getGMSelection()
				if #objectList == 1 then
					local first_object = objectList[1]
					local object_type = first_object.typeName
					if object_type == "SpaceStation" then
						local found_rotate_station = false
						local found_station_index = 0
						for i=1,#rotate_station do
							if rotate_station[i] == first_object then
								found_rotate_station = true
								found_station_index = i
								break
							end
						end
						if found_rotate_station then
							table.remove(rotate_station,found_station_index)
						else
							table.insert(rotate_station,first_object)
						end
					else
						addGMMessage("Station not selected. No action taken")
					end
				else
					addGMMessage("No object selected. No action taken")
				end
				stationDefense()
			end)
		end
	end
end
---------------------------------
--	Tweak Terrain > Minefield  --
---------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN FROM MINEFIELD	F	initialGMFunctions
-- -TWEAK TERRAIN		F	tweakTerrain
-- +SHAPE: ARC			D	setMineShape
-- +WIDTH: 1			D	setMineWidth
-- CENTER POINT			D	mineArcCenterPoint
function mineField()
	clearGMFunctions()
	addGMFunction("-Main From Minefield",initialGMFunctions)
	addGMFunction("-Tweak Terrain",tweakTerrain)
	addGMFunction(string.format("+Shape: %s",mine_shape),setMineShape)
	addGMFunction(string.format("+Width: %i",mine_width),setMineWidth)
	if mine_shape == "Circle" then
		addGMFunction(string.format("+Radius: %i",mine_radius),setMineRadius)
	end
	if mine_shape == "Line" then
		if gm_click_mode == "mine line start" then
			addGMFunction(">Start Point<",mineLineStartPoint)
		elseif gm_click_mode == "mine line end" then
			addGMFunction(">End Point<",mineLineEndPoint)
		else
			addGMFunction("Start Point",mineLineStartPoint)
		end
	elseif mine_shape == "Arc" then
		if gm_click_mode == "mine arc center" then
			addGMFunction(">Center Point<",mineArcCenterPoint)
		elseif gm_click_mode == "mine arc start" then
			addGMFunction(">Start Arc<",mineArcStartPoint)
		elseif gm_click_mode == "mine arc end" then
			addGMFunction(">End Arc<",mineArcEndPoint)
		else
			addGMFunction("Center Point",mineArcCenterPoint)
		end
	elseif mine_shape == "Circle" then
		if gm_click_mode == "mine circle" then
			addGMFunction(">Center of Circle<",mineCircle)
		else
			addGMFunction("Center of Circle",mineCircle)
		end
	end
end
---------------------------------------------------------
--	Tweak Terrain > Station Defense > Defensive Fleet  --
---------------------------------------------------------
-- Button Text			   FD*	Related Function(s)
-- -MAIN					F	initialGMFunctions
-- -TWEAK TERRAIN			F	tweakTerrain
-- -STATION DEFENSE			F	stationDefense
-- AVG SPEED OFF			D	inline
-- +1 PLAYER STRENGTH: n*	D	/Asterisk on selection between		setDefensiveFleetStrength
-- +SET FIXED STRENGTH		D	\relative and fixed strength		setDefensiveFleetFixedStrength
-- +RANDOM					D	(composition)						setFleetComposition
-- SPAWN DEF FLEET			F	spawnDefensiveFleet
function stationDefensiveFleet()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Tweak Terrain",tweakTerrain)
	addGMFunction("-Station Defense",stationDefense)
	local button_label = "off"
	if station_defensive_fleet_speed_average then
		button_label = "on"
	end
	addGMFunction(string.format("Avg Speed %s",button_label),function()
		if station_defensive_fleet_speed_average then
			station_defensive_fleet_speed_average = false
			stationDefensiveFleet()
		else
			station_defensive_fleet_speed_average = true
			stationDefensiveFleet()
		end
	end)
	if fleetStrengthFixed then
		addGMFunction("+Set Relative Strength",setDefensiveFleetStrength)
		addGMFunction(string.format("+Strength %i*",fleetStrengthFixedValue),setDefensiveFleetFixedStrength)
	else
		local calcStr = math.floor(playerPower()*fleetStrengthByPlayerStrength)
		local GMSetGMFleetStrength = fleetStrengthByPlayerStrength .. " player strength: " .. calcStr
		addGMFunction("+" .. GMSetGMFleetStrength .. "*",setDefensiveFleetStrength)
		addGMFunction("+Set Fixed Strength",setDefensiveFleetFixedStrength)
	end
	local exclusion_string = ""
	for name, details in pairs(fleet_exclusions) do
		if details.exclude then
			if exclusion_string == "" then
				exclusion_string = "-"
			end
			exclusion_string = exclusion_string .. details.letter
		end
	end
	addGMFunction(string.format("+%s%s",fleetComposition,exclusion_string),function()
		setFleetComposition(stationDefensiveFleet)
	end)
	addGMFunction("Spawn Def Fleet",spawnDefensiveFleet)
end
function spawnDefensiveFleet()
	local objectList = getGMSelection()
	if #objectList ~= 1 then
		addGMMessage("You need to select a station. No action taken")
		return
	end
	local station = objectList[1]
	local temp_type = station.typeName
	if temp_type ~= "SpaceStation" then
		addGMMessage("You need to select a station. No action taken")
		return		
	end
	local fsx, fsy = station:getPosition()
	local fleet = nil
	local fleet_distance = {
		["Small Station"]	= 2,
		["Medium Station"]	= 3,
		["Large Station"]	= 4,
		["Huge Station"]	= 4,
	}
	local station_type = station:getTypeName()
	if station_type == nil then
		station_type = "Small Station"
	end
	fleet = spawnRandomArmed(fsx, fsy, #fleetList + 1, "ambush", fleet_distance[station_type])
	local total_speed = 0
	local average_speed = 0
	if station_defensive_fleet_speed_average then
		for i=1,#fleet do
			total_speed = total_speed + fleet[i]:getImpulseMaxSpeed()
		end
		average_speed = total_speed/#fleet
	end
	for i=1,#fleet do
		local ship = fleet[i]
		ship:orderDefendTarget(station)
		if station_defensive_fleet_speed_average then
			ship:setImpulseMaxSpeed(average_speed)
		end
	end
	table.insert(fleetList,fleet)
end
----------------------------------------------------
--	Tweak Terrain > Station Defense > Inner Ring  --
----------------------------------------------------
-- Button Text			   FD*	Related Function(s)
-- -MAIN FRM IN RING		F	initialGMFunctions
-- -TWEAK TERRAIN			F	tweakTerrain
-- -STATION DEFENSE			F	stationDefense
-- +PLATFORMS: 3			D	setInnerPlatformCount
-- +ORBIT: NO				D	setInnerPlatformOrbit
-- SPAWN DEF PLATFORMS		D	inline
function stationDefensiveInnerRing()
	clearGMFunctions()
	addGMFunction("-Main Frm In Ring",initialGMFunctions)
	addGMFunction("-Tweak Terrain",tweakTerrain)
	addGMFunction("-Station Defense",stationDefense)
	addGMFunction(string.format("+Platforms: %i",inner_defense_platform_count),setInnerPlatformCount)
	addGMFunction(string.format("+Orbit: %s",inner_defense_platform_orbit),setInnerPlatformOrbit)
	local button_label = "Spawn Def Platform"
	if inner_defense_platform_count > 1 then
		button_label = string.format("%ss",button_label)
	end
	addGMFunction(button_label,function()
		local objectList = getGMSelection()
		if #objectList ~= 1 then
			addGMMessage("You need to select a station. No action taken")
			return
		end
		local station = objectList[1]
		local temp_type = station.typeName
		if temp_type ~= "SpaceStation" then
			addGMMessage("You need to select a station. No action taken")
			return		
		end
		local fsx, fsy = station:getPosition()
		local faction = station:getFaction()
		local angle = random(0,360)
		local increment = 360/inner_defense_platform_count
		local station_type = station:getTypeName()
		local platform_distance = spaceStationDistance[station_type] * 2
		local fleet = {}
		for i=1,inner_defense_platform_count do
			local ax, ay = vectorFromAngle(angle,platform_distance)
			local dp = CpuShip():setTemplate("Defense platform"):setFaction(faction):setPosition(fsx+ax,fsy+ay):orderRoaming()
			if inner_defense_platform_orbit ~= "No" then
				update_system:addOrbitUpdate(dp,fsx,fsy,platform_distance,orbit_increment[inner_defense_platform_orbit],angle)
			end
			angle = angle + increment
			if angle > 360 then
				angle = angle - 360
			end
			table.insert(fleet,dp)
		end
		table.insert(fleetList,fleet)
	end)
end
function createOrbitingObject(obj,travel_angle,orbit_speed,origin_x,origin_y,distance)
	local mx, my = vectorFromAngle(travel_angle,distance)
	obj:setPosition(origin_x+mx,origin_y+my)
	if  orbit_speed ~= nil then
		update_system:addOrbitUpdate(obj,origin_x,origin_y,distance,orbit_speed,travel_angle)
	end
end
----------------------------------------------------
--	Tweak Terrain > Station Defense > Outer Ring  --
----------------------------------------------------
-- Button Text			   FD*	Related Function(s)
-- -MAIN FRM OUT RING		F	initialGMFunctions
-- -TWEAK TERRAIN			F	tweakTerrain
-- -STATION DEFENSE			F	stationDefense
-- +PLATFORMS: 3			D	setInnerPlatformCount
-- +MINES: NO				D	setOuterMines
-- +DP ORBIT: NO			D	setOuterPlatformOrbit
-- SPAWN OUTER DEFENSE		F	inline
function stationDefensiveOuterRing()
	clearGMFunctions()
	addGMFunction("-Main Frm Out Ring",initialGMFunctions)
	addGMFunction("-Tweak Terrain",tweakTerrain)
	addGMFunction("-Station Defense",stationDefense)
	addGMFunction(string.format("+Platforms: %i",outer_defense_platform_count),setOuterPlatformCount)
	addGMFunction(string.format("+Mines: %s",outer_mines,setOuterMines),setOuterMines)
	addGMFunction(string.format("+DP Orbit: %s",outer_defense_platform_orbit),setOuterPlatformOrbit)
	if outer_defense_platform_count > 0 or outer_mines ~= "No" then
		addGMFunction("Spawn outer defense",function()
			local objectList = getGMSelection()
			if #objectList ~= 1 then
				addGMMessage("You need to select a station. No action taken")
				return
			end
			local station = objectList[1]
			local temp_type = station.typeName
			if temp_type ~= "SpaceStation" then
				addGMMessage("You need to select a station. No action taken")
				return		
			end
			local fsx, fsy = station:getPosition()
			local faction = station:getFaction()
			local angle = random(0,360)
			local station_type = station:getTypeName()
			local outer_platform_distance = {
					["Small Station"] 	= 7500,
					["Medium Station"]	= 9100,
					["Large Station"]	= 9700,
					["Huge Station"]	= 10100,
				}
			--local platform_distance = spaceStationDistance[station_type] * 4
			local platform_distance = outer_platform_distance[station_type]
			--print(string.format("outer defense platform count: %i, platform distance: %i",outer_defense_platform_count,platform_distance))
			local inline_num_gaps
			if outer_defense_platform_count > 0 then
				local increment = 360/outer_defense_platform_count
				local fleet = {}
				for i=1,outer_defense_platform_count do
					local dp = CpuShip():setTemplate("Defense platform"):setFaction(faction):orderRoaming()
					createOrbitingObject(dp,angle,orbit_increment[outer_defense_platform_orbit], fsx, fsy, platform_distance)
					angle = (angle + increment) % 360
					table.insert(fleet,dp)
				end
				table.insert(fleetList,fleet)
				inline_num_gaps = outer_defense_platform_count
			else
				inline_num_gaps = inline_mine_gap_count
			end
			mineRingShim{
				speed=orbit_increment[outer_defense_platform_orbit],
				x=fsx,
				y=fsy,
				dist=platform_distance-((inline_mines-1)*250),
				num_rows=inline_mines,
				segments=inline_num_gaps,
				angle=angle
			}
			mineRingShim{
				speed=orbit_increment[inside_mine_orbit],
				x=fsx,
				y=fsy,
				dist=platform_distance-2000-((inside_mines-1)*250),
				num_rows=inside_mines,
				segments=inside_mine_gap_count
			}
			mineRingShim {
				speed=orbit_increment[outside_mine_orbit],
				x=fsx,
				y=fsy,
				dist=platform_distance+3000-((outside_mines-1)*250),
				num_rows=outside_mines,
				segments=outside_mine_gap_count
			}
		end)
	end
end
-----------------------------------------------------------------------------
--	Tweak Terrain > Station Defense > Defensive Fleet > Relative Strength  --
-----------------------------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN FROM REL STR	F	initialGMFunctions
-- -STATION DEF FLT		F	stationDefensiveFleet
-- .5					*	inline
-- 1*					*	inline		asterisk = current selection
-- 2					*	inline
-- 3					*	inline
-- 4					*	inline
-- 5					*	inline
function setDefensiveFleetStrength()
	clearGMFunctions()
	addGMFunction("-Main from Rel Str",initialGMFunctions)
	addGMFunction("-Station Def Flt",stationDefensiveFleet)
	setFleetStrength(setDefensiveFleetStrength)
end
--------------------------------------------------------------------------
--	Tweak Terrain > Station Defense > Defensive Fleet > Fixed Strength  --
--------------------------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN FROM REL STR	F	initialGMFunctions
-- -STATION DEF FLT		F	stationDefensiveFleet
-- -FIXED STRENGTH 250	D	spawnGMFleet
-- 250 - 50 = 200		D	inline
-- 250 + 50 = 250		D	inline
function setDefensiveFleetFixedStrength()
	clearGMFunctions()
	addGMFunction("-Main from Fix Str",initialGMFunctions)
	addGMFunction("-Station Def Flt",stationDefensiveFleet)
	addGMFunction("-Fixed Strength " .. fleetStrengthFixedValue,stationDefensiveFleet)
	fixFleetStrength(setDefensiveFleetFixedStrength)
end
---------------------------------------------------------------------
--	Tweak Terrain > Station Defense > Inner Ring > Platform Count  --
---------------------------------------------------------------------
-- Button Text			   FD*	Related Function(s)
-- -MAIN FRM DP NO.			F	initialGMFunctions
-- -TWEAK TERRAIN			F	tweakTerrain
-- -STATION DEFENSE			F	stationDefense
-- -INNER RING				F	stationDefensiveInnerRing
-- V FROM 3 TO 2			D	inline
-- ^ FROM 3 TO 4			D	inline 
function setInnerPlatformCount()
	clearGMFunctions()
	addGMFunction("-Main Frm DP No.",initialGMFunctions)
	addGMFunction("-Tweak Terrain",tweakTerrain)
	addGMFunction("-Station Defense",stationDefense)
	addGMFunction("-Inner Ring",stationDefensiveInnerRing)
	if inner_defense_platform_count > 1 then
		addGMFunction(string.format("v from %i to %i",inner_defense_platform_count,inner_defense_platform_count - 1), function()
			inner_defense_platform_count = inner_defense_platform_count - 1
			setInnerPlatformCount()
		end)
	end
	if inner_defense_platform_count < 6 then
		addGMFunction(string.format("^ from %i to %i",inner_defense_platform_count,inner_defense_platform_count + 1), function()
			inner_defense_platform_count = inner_defense_platform_count + 1
			setInnerPlatformCount()
		end)
	end
end
------------------------------------------------------------
--	Tweak Terrain > Station Defense > Inner Ring > Orbit  --
------------------------------------------------------------
-- Button Text	   FD*	Related Function(s)
-- -INNER RING		F	stationDefensiveInnerRing
-- ORBIT > FAST		*	inline
-- ORBIT > NORMAL	*	inline
-- ORBIT > SLOW		*	inline
-- NO				*	inline
-- ORBIT < FAST		*	inline
-- ORBIT < NORMAL	*	inline
-- ORBIT < SLOW		*	inline
function setInnerPlatformOrbit()
	clearGMFunctions()
	addGMFunction("-Inner Ring",stationDefensiveInnerRing)
	local button_label = "Orbit > Fast"
	if inner_defense_platform_orbit == "Orbit > Fast" then
		button_label = string.format("%s*",button_label)
	end
	addGMFunction(button_label,function()
		inner_defense_platform_orbit = "Orbit > Fast"
		setInnerPlatformOrbit()
	end)
	button_label = "Orbit > Normal"
	if inner_defense_platform_orbit == "Orbit > Normal" then
		button_label = string.format("%s*",button_label)
	end
	addGMFunction(button_label,function()
		inner_defense_platform_orbit = "Orbit > Normal"
		setInnerPlatformOrbit()
	end)
	button_label = "Orbit > Slow"
	if inner_defense_platform_orbit == "Orbit > Slow" then
		button_label = string.format("%s*",button_label)
	end
	addGMFunction(button_label,function()
		inner_defense_platform_orbit = "Orbit > Slow"
		setInnerPlatformOrbit()
	end)
	button_label = "No"
	if inner_defense_platform_orbit == "No" then
		button_label = string.format("%s*",button_label)
	end
	addGMFunction(button_label,function()
		inner_defense_platform_orbit = "No"
		setInnerPlatformOrbit()
	end)
	button_label = "Orbit < Fast"
	if inner_defense_platform_orbit == "Orbit < Fast" then
		button_label = string.format("%s*",button_label)
	end
	addGMFunction(button_label,function()
		inner_defense_platform_orbit = "Orbit < Fast"
		setInnerPlatformOrbit()
	end)
	button_label = "Orbit < Normal"
	if inner_defense_platform_orbit == "Orbit < Normal" then
		button_label = string.format("%s*",button_label)
	end
	addGMFunction(button_label,function()
		inner_defense_platform_orbit = "Orbit < Normal"
		setInnerPlatformOrbit()
	end)
	button_label = "Orbit < Slow"
	if inner_defense_platform_orbit == "Orbit < Slow" then
		button_label = string.format("%s*",button_label)
	end
	addGMFunction(button_label,function()
		inner_defense_platform_orbit = "Orbit < Slow"
		setInnerPlatformOrbit()
	end)
end
---------------------------------------------------------------------
--	Tweak Terrain > Station Defense > Outer Ring > Platform Count  --
---------------------------------------------------------------------
-- Button Text			   FD*	Related Function(s)
-- -MAIN FRM OUT RING		F	initialGMFunctions
-- -TWEAK TERRAIN			F	tweakTerrain
-- -STATION DEFENSE			F	stationDefense
-- -OUTER RING				F	stationDefensiveOuterRing
-- V FROM 3 TO 2			D	inline
-- A FROM 3 TO 4			D	inline 
function setOuterPlatformCount()
	clearGMFunctions()
	addGMFunction("-Main Frm Out Ring",initialGMFunctions)
	addGMFunction("-Tweak Terrain",tweakTerrain)
	addGMFunction("-Station Defense",stationDefense)
	addGMFunction("-Outer Ring",stationDefensiveOuterRing)
	if outer_defense_platform_count > 0 then
		addGMFunction(string.format("v from %i to %i",outer_defense_platform_count,outer_defense_platform_count - 1), function()
			outer_defense_platform_count = outer_defense_platform_count - 1
			setOuterPlatformCount()
		end)
	end
	if outer_defense_platform_count < 6 then
		addGMFunction(string.format("^ from %i to %i",outer_defense_platform_count,outer_defense_platform_count + 1), function()
			outer_defense_platform_count = outer_defense_platform_count + 1
			setOuterPlatformCount()
		end)
	end
end
------------------------------------------------------------
--	Tweak Terrain > Station Defense > Outer Ring > Mines  --
------------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN FROM MINES		F	initialGMFunctions
-- -TWEAK TERRAIN		F	tweakTerrain
-- -STATION DEFENSE		F	stationDefense
-- -OUTER RING			F	stationDefensiveOuterRing
-- +INLINE 0			D	setInlineMines
-- +INSIDE: 0			D	setInsideMines
-- +OUTSIDE: 0			D	setOutsideMines
function setOuterMines()
	clearGMFunctions()
	addGMFunction("-Main From Mines",initialGMFunctions)
	addGMFunction("-Tweak Terrain",tweakTerrain)
	addGMFunction("-Station Defense",stationDefense)
	addGMFunction("-Outer Ring",stationDefensiveOuterRing)
	addGMFunction(string.format("+Inline: %i",inline_mines),setInlineMines)
	addGMFunction(string.format("+Inside: %i",inside_mines),setInsideMines)
	addGMFunction(string.format("+Outside: %i",outside_mines),setOutsideMines)
end
---------------------------------------------------------------------
--	Tweak Terrain > Station Defense > Outer Ring > Platform Orbit  --
---------------------------------------------------------------------
-- -OUTER FRM DP ORBIT
-- ORBIT > FAST		*	inline
-- ORBIT > NORMAL	*	inline
-- ORBIT > SLOW		*	inline
-- NO				*	inline
-- ORBIT < FAST		*	inline
-- ORBIT < NORMAL	*	inline
-- ORBIT < SLOW		*	inline
function setOuterPlatformOrbit()
	clearGMFunctions()
	addGMFunction("-Outer Frm DP Orbit",stationDefensiveOuterRing)
	setCommonOuterOrbit(setOuterPlatformOrbit)
end
---------------------------------------------------------------------
--	Tweak Terrain > Station Defense > Outer Ring > Mines > Inline  --
---------------------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -FROM INLINE MINE	F	setOuterMines
-- ^ FROM 0 TO 1		D	inline
-- +ORBIT: NO			D	setOuterMineOrbit
-- V GAPS FROM 3 TO 2	D	inline
-- ^ GAPS FROM 3 TO 4	D	inline
function setInlineMines()
	clearGMFunctions()
	addGMFunction("-From Inline Mine",setOuterMines)
	if inline_mines > 0 then
		addGMFunction(string.format("V From %i to %i",inline_mines,inline_mines - 1),function()
			inline_mines = inline_mines - 1
			setInlineMines()
		end)
	end
	if inline_mines < 3 then
		addGMFunction(string.format("^ From %i to %i",inline_mines,inline_mines + 1),function()
			inline_mines = inline_mines + 1
			setInlineMines()
		end)
	end
	if inline_mines == 0 and inside_mines == 0 and outside_mines == 0 then
		outer_mines = "No"
	else
		outer_mines = "Yes"
	end
	addGMFunction(string.format("+Orbit: %s",outer_defense_platform_orbit),setOuterMineOrbit)
	if outer_defense_platform_count == 0 then
		if inline_mine_gap_count > 1 then
			addGMFunction(string.format("V Gaps from %i to %i",inline_mine_gap_count,inline_mine_gap_count - 1),function()
				inline_mine_gap_count = inline_mine_gap_count - 1
				setInlineMines()
			end)
		end
		if inline_mine_gap_count < 6 then
			addGMFunction(string.format("^ Gaps from %i to %i",inline_mine_gap_count,inline_mine_gap_count + 1),function()
				inline_mine_gap_count = inline_mine_gap_count + 1
				setInlineMines()
			end)
		end
	end
end
---------------------------------------------------------------------
--	Tweak Terrain > Station Defense > Outer Ring > Mines > Inside  --
---------------------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN FROM INSIDE	F	initialGMFunctions
-- -TWEAK TERRAIN		F	tweakTerrain
-- -STATION DEFENSE		F	stationDefense
-- -OUTER RING			F	stationDefensiveOuterRing
-- -MINES				F	setOuterMines
-- ^ FROM 0 TO 1		D	inline
-- +ORBIT: NO			D	setOuterInnerMineOrbit
-- V GAPS FROM 3 TO 2	D	inline
-- ^ GAPS FROM 3 TO 4	D	inline
function setInsideMines()
	clearGMFunctions()
	addGMFunction("-Main From Inside",initialGMFunctions)
	addGMFunction("-Tweak Terrain",tweakTerrain)
	addGMFunction("-Station Defense",stationDefense)
	addGMFunction("-Outer Ring",stationDefensiveOuterRing)
	addGMFunction("-Mines",setOuterMines)
	if inside_mines > 0 then
		addGMFunction(string.format("V From %i to %i",inside_mines,inside_mines - 1),function()
			inside_mines = inside_mines - 1
			setInsideMines()
		end)
	end
	if inside_mines < 3 then
		addGMFunction(string.format("^ From %i to %i",inside_mines,inside_mines + 1),function()
			inside_mines = inside_mines + 1
			setInsideMines()
		end)
	end
	if inline_mines == 0 and inside_mines == 0 and outside_mines == 0 then
		outer_mines = "No"
	else
		outer_mines = "Yes"
	end
	addGMFunction(string.format("+Orbit: %s",inside_mine_orbit),setOuterInnerMineOrbit)
	if inside_mine_gap_count > 1 then
		addGMFunction(string.format("V Gaps from %i to %i",inside_mine_gap_count,inside_mine_gap_count - 1),function()
			inside_mine_gap_count = inside_mine_gap_count - 1
			setInsideMines()
		end)
	end
	if inside_mine_gap_count < 6 then
		addGMFunction(string.format("^ Gaps from %i to %i",inside_mine_gap_count,inside_mine_gap_count + 1),function()
			inside_mine_gap_count = inside_mine_gap_count + 1
			setInsideMines()
		end)
	end
end
----------------------------------------------------------------------
--	Tweak Terrain > Station Defense > Outer Ring > Mines > Outside  --
----------------------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN FROM OUTSIDE	F	initialGMFunctions
-- -TWEAK TERRAIN		F	tweakTerrain
-- -STATION DEFENSE		F	stationDefense
-- -OUTER RING			F	stationDefensiveOuterRing
-- -MINES				F	setOuterMines
-- ^ FROM 0 TO 1		D	inline
-- +ORBIT: NO			D	setOuterInnerMineOrbit
-- V GAPS FROM 3 TO 2	D	inline
-- ^ GAPS FROM 3 TO 4	D	inline
function setOutsideMines()
	clearGMFunctions()
	addGMFunction("-Main From Outside",initialGMFunctions)
	addGMFunction("-Tweak Terrain",tweakTerrain)
	addGMFunction("-Station Defense",stationDefense)
	addGMFunction("-Outer Ring",stationDefensiveOuterRing)
	addGMFunction("-Mines",setOuterMines)
	if outside_mines > 0 then
		addGMFunction(string.format("V From %i to %i",outside_mines,outside_mines - 1),function()
			outside_mines = outside_mines - 1
			setOutsideMines()
		end)
	end
	if outside_mines < 3 then
		addGMFunction(string.format("^ From %i to %i",outside_mines,outside_mines + 1),function()
			outside_mines = outside_mines + 1
			setOutsideMines()
		end)
	end
	if inline_mines == 0 and inside_mines == 0 and outside_mines == 0 then
		outer_mines = "No"
	else
		outer_mines = "Yes"
	end
	addGMFunction(string.format("+Orbit: %s",outside_mine_orbit),setOuterOuterMineOrbit)
	if outside_mine_gap_count > 1 then
		addGMFunction(string.format("V Gaps from %i to %i",outside_mine_gap_count,outside_mine_gap_count - 1),function()
			outside_mine_gap_count = outside_mine_gap_count - 1
			setOutsideMines()
		end)
	end
	if outside_mine_gap_count < 6 then
		addGMFunction(string.format("^ Gaps from %i to %i",outside_mine_gap_count,outside_mine_gap_count + 1),function()
			outside_mine_gap_count = outside_mine_gap_count + 1
			setOutsideMines()
		end)
	end
end
-----------------------------------------------------------------------------
--	Tweak Terrain > Station Defense > Outer Ring > Mines > Inline > Orbit  --
-----------------------------------------------------------------------------
-- Button Text	   FD*	Related Function(s)
-- -Outer RING		F	stationDefensiveOuterRing
-- ORBIT > FAST		*	inline
-- ORBIT > NORMAL	*	inline
-- ORBIT > SLOW		*	inline
-- NO				*	inline
-- ORBIT < FAST		*	inline
-- ORBIT < NORMAL	*	inline
-- ORBIT < SLOW		*	inline
function setOuterMineOrbit()
	clearGMFunctions()
	addGMFunction("-Inline Mine",setInlineMines)
	setCommonOuterOrbit(setOuterMineOrbit)
end
function setCommonOuterOrbit(caller)
	local button_label = "Orbit > Fast"
	if outer_defense_platform_orbit == "Orbit > Fast" then
		button_label = string.format("%s*",button_label)
	end
	addGMFunction(button_label,function()
		outer_defense_platform_orbit = "Orbit > Fast"
		caller()
	end)
	button_label = "Orbit > Normal"
	if outer_defense_platform_orbit == "Orbit > Normal" then
		button_label = string.format("%s*",button_label)
	end
	addGMFunction(button_label,function()
		outer_defense_platform_orbit = "Orbit > Normal"
		caller()
	end)
	button_label = "Orbit > Slow"
	if outer_defense_platform_orbit == "Orbit > Slow" then
		button_label = string.format("%s*",button_label)
	end
	addGMFunction(button_label,function()
		outer_defense_platform_orbit = "Orbit > Slow"
		caller()
	end)
	button_label = "No"
	if outer_defense_platform_orbit == "No" then
		button_label = string.format("%s*",button_label)
	end
	addGMFunction(button_label,function()
		outer_defense_platform_orbit = "No"
		caller()
	end)
	button_label = "Orbit < Fast"
	if outer_defense_platform_orbit == "Orbit < Fast" then
		button_label = string.format("%s*",button_label)
	end
	addGMFunction(button_label,function()
		outer_defense_platform_orbit = "Orbit < Fast"
		caller()
	end)
	button_label = "Orbit < Normal"
	if outer_defense_platform_orbit == "Orbit < Normal" then
		button_label = string.format("%s*",button_label)
	end
	addGMFunction(button_label,function()
		outer_defense_platform_orbit = "Orbit < Normal"
		caller()
	end)
	button_label = "Orbit < Slow"
	if outer_defense_platform_orbit == "Orbit < Slow" then
		button_label = string.format("%s*",button_label)
	end
	addGMFunction(button_label,function()
		outer_defense_platform_orbit = "Orbit < Slow"
		caller()
	end)
end
-----------------------------------------------------------------------------
--	Tweak Terrain > Station Defense > Outer Ring > Mines > Inside > Orbit  --
-----------------------------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -OUTER MINES INSIDE	F	setInsideMines
-- ORBIT > FAST			*	inline
-- ORBIT > NORMAL		*	inline
-- ORBIT > SLOW			*	inline
-- NO					*	inline
-- ORBIT < FAST			*	inline
-- ORBIT < NORMAL		*	inline
-- ORBIT < SLOW			*	inline
function setOuterInnerMineOrbit()
	clearGMFunctions()
	addGMFunction("-Outer Mines Inside",setInsideMines)
	local button_label = "Orbit > Fast"
	if inside_mine_orbit == "Orbit > Fast" then
		button_label = string.format("%s*",button_label)
	end
	addGMFunction(button_label,function()
		inside_mine_orbit = "Orbit > Fast"
		setOuterInnerMineOrbit()
	end)
	button_label = "Orbit > Normal"
	if inside_mine_orbit == "Orbit > Normal" then
		button_label = string.format("%s*",button_label)
	end
	addGMFunction(button_label,function()
		inside_mine_orbit = "Orbit > Normal"
		setOuterInnerMineOrbit()
	end)
	button_label = "Orbit > Slow"
	if inside_mine_orbit == "Orbit > Slow" then
		button_label = string.format("%s*",button_label)
	end
	addGMFunction(button_label,function()
		inside_mine_orbit = "Orbit > Slow"
		setOuterInnerMineOrbit()
	end)
	button_label = "No"
	if inside_mine_orbit == "No" then
		button_label = string.format("%s*",button_label)
	end
	addGMFunction(button_label,function()
		inside_mine_orbit = "No"
		setOuterInnerMineOrbit()
	end)
	button_label = "Orbit < Fast"
	if inside_mine_orbit == "Orbit < Fast" then
		button_label = string.format("%s*",button_label)
	end
	addGMFunction(button_label,function()
		inside_mine_orbit = "Orbit < Fast"
		setOuterInnerMineOrbit()
	end)
	button_label = "Orbit < Normal"
	if inside_mine_orbit == "Orbit < Normal" then
		button_label = string.format("%s*",button_label)
	end
	addGMFunction(button_label,function()
		inside_mine_orbit = "Orbit < Normal"
		setOuterInnerMineOrbit()
	end)
	button_label = "Orbit < Slow"
	if inside_mine_orbit == "Orbit < Slow" then
		button_label = string.format("%s*",button_label)
	end
	addGMFunction(button_label,function()
		inside_mine_orbit = "Orbit < Slow"
		setOuterInnerMineOrbit()
	end)
end
------------------------------------------------------------------------------
--	Tweak Terrain > Station Defense > Outer Ring > Mines > Outside > Orbit  --
------------------------------------------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -OUTER MINES OUTSIDE	F	setOutsideMines
-- ORBIT > FAST			*	inline
-- ORBIT > NORMAL		*	inline
-- ORBIT > SLOW			*	inline
-- NO					*	inline
-- ORBIT < FAST			*	inline
-- ORBIT < NORMAL		*	inline
-- ORBIT < SLOW			*	inline
function setOuterOuterMineOrbit()
	clearGMFunctions()
	addGMFunction("-Outer Mines Outside",setOutsideMines)
	local button_label = "Orbit > Fast"
	if outside_mine_orbit == "Orbit > Fast" then
		button_label = string.format("%s*",button_label)
	end
	addGMFunction(button_label,function()
		outside_mine_orbit = "Orbit > Fast"
		setOuterOuterMineOrbit()
	end)
	button_label = "Orbit > Normal"
	if outside_mine_orbit == "Orbit > Normal" then
		button_label = string.format("%s*",button_label)
	end
	addGMFunction(button_label,function()
		outside_mine_orbit = "Orbit > Normal"
		setOuterOuterMineOrbit()
	end)
	button_label = "Orbit > Slow"
	if outside_mine_orbit == "Orbit > Slow" then
		button_label = string.format("%s*",button_label)
	end
	addGMFunction(button_label,function()
		outside_mine_orbit = "Orbit > Slow"
		setOuterOuterMineOrbit()
	end)
	button_label = "No"
	if outside_mine_orbit == "No" then
		button_label = string.format("%s*",button_label)
	end
	addGMFunction(button_label,function()
		outside_mine_orbit = "No"
		setOuterOuterMineOrbit()
	end)
	button_label = "Orbit < Fast"
	if outside_mine_orbit == "Orbit < Fast" then
		button_label = string.format("%s*",button_label)
	end
	addGMFunction(button_label,function()
		outside_mine_orbit = "Orbit < Fast"
		setOuterOuterMineOrbit()
	end)
	button_label = "Orbit < Normal"
	if outside_mine_orbit == "Orbit < Normal" then
		button_label = string.format("%s*",button_label)
	end
	addGMFunction(button_label,function()
		outside_mine_orbit = "Orbit < Normal"
		setOuterOuterMineOrbit()
	end)
	button_label = "Orbit < Slow"
	if outside_mine_orbit == "Orbit < Slow" then
		button_label = string.format("%s*",button_label)
	end
	addGMFunction(button_label,function()
		outside_mine_orbit = "Orbit < Slow"
		setOuterOuterMineOrbit()
	end)
end
-----------------------------------------
--	Tweak Terrain > Minefield > Shape  --
-----------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN FROM SHAPE		F	initialGMFunctions
-- -TWEAK TERRAIN		F	tweakTerrain
-- -MINEFIELD			F	mineField
-- ARC*					*	inline
-- LINE					*	inline
-- CIRCLE				*	inline
function setMineShape()
	clearGMFunctions()
	addGMFunction("-Main From Shape",initialGMFunctions)
	addGMFunction("-Tweak Terrain",tweakTerrain)
	addGMFunction("-Minefield",mineField)
	local button_label = "Arc"
	if mine_shape == "Arc" then
		button_label = button_label .. "*"
	end
	addGMFunction(button_label,function()
		mine_shape = "Arc"
		if  gm_click_mode ~= nil and gm_click_mode:sub(1,4) == "mine" and gm_click_mode:sub(1,8) ~= "mine arc" then
			gm_click_mode = nil
			onGMClick(nil)
		end
		setMineShape()
	end)
	button_label = "Line"
	if mine_shape == "Line" then
		button_label = button_label .. "*"
	end
	addGMFunction(button_label,function()
		mine_shape = "Line"
		if gm_click_mode ~= nil and gm_click_mode:sub(1,4) == "mine" and gm_click_mode:sub(1,9) ~= "mine line" then
			gm_click_mode = nil
			onGMClick(nil)
		end
		setMineShape()
	end)
	button_label = "Circle"
	if mine_shape == "Circle" then
		button_label = button_label .. "*"
	end
	addGMFunction(button_label,function()
		mine_shape = "Circle"
		if  gm_click_mode ~= nil and gm_click_mode:sub(1,4) == "mine" and gm_click_mode:sub(1,11) ~= "mine circle" then
			gm_click_mode = nil
			onGMClick(nil)
		end
		setMineShape()
	end)
end
-----------------------------------------
--	Tweak Terrain > Minefield > Width  --
-----------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN FROM WIDTH		F	initialGMFunctions
-- -TWEAK TERRAIN		F	tweakTerrain
-- -MINEFIELD			F	mineField
-- WIDTH 1*				*	inline
-- WIDTH 2				*	inline
-- WIDTH 3				*	inline
function setMineWidth()
	clearGMFunctions()
	addGMFunction("-Main From Width",initialGMFunctions)
	addGMFunction("-Tweak Terrain",tweakTerrain)
	addGMFunction("-Minefield",mineField)
	for i=1,3 do
		local button_label = string.format("Width %i",i)
		if mine_width == i then
			button_label = button_label .. "*"
		end
		addGMFunction(button_label,function()
			mine_width = i
			setMineWidth()
		end)
	end
end
------------------------------------------
--	Tweak Terrain > Minefield > Radius  --
------------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN FROM RADIUS	F	initialGMFunctions
-- -TWEAK TERRAIN		F	tweakTerrain
-- -MINEFIELD			F	mineField
-- RADIUS 1				*	inline
-- RADIUS 2				*	inline
-- RADIUS 3*			*	inline
-- RADIUS 4				*	inline
-- RADIUS 5				*	inline
function setMineRadius()
	clearGMFunctions()
	addGMFunction("-Main From Radius",initialGMFunctions)
	addGMFunction("-Tweak Terrain",tweakTerrain)
	addGMFunction("-Minefield",mineField)
	for i=1,5 do
		local button_label = string.format("Radius %i",i)
		if mine_radius == i then
			button_label = button_label .. "*"
		end
		addGMFunction(button_label,function()
			mine_radius = i
			setMineRadius()
		end)
	end
end
--	Minefield functions
function angleFromVectorNorth(p1x,p1y,p2x,p2y)
	TWOPI = 6.2831853071795865
	RAD2DEG = 57.2957795130823209
	atan2parm1 = p2x - p1x
	atan2parm2 = p2y - p1y
	theta = math.atan2(atan2parm1, atan2parm2)
	if theta < 0 then
		theta = theta + TWOPI
	end
	return (360 - (RAD2DEG * theta)) % 360
end
function vectorFromAngleNorth(angle,distance)
--	print("input angle to vectorFromAngleNorth:")
--	print(angle)
	angle = (angle + 270) % 360
	local x, y = vectorFromAngle(angle,distance)
	return x, y
end
--	Line shaped minefield functions
function mineLineStartPoint()
	if gm_click_mode == "mine line start" then
		gm_click_mode = nil
		onGMClick(nil)	
	else
		local prev_mode = gm_click_mode
		gm_click_mode = "mine line start"
		onGMClick(gmClickMineLineStart)
		if prev_mode ~= nil then
			addGMMessage(string.format("Cancelled current GM Click mode\n   %s\nIn favor of\n   mine line start\nGM click mode.",prev_mode))
		end
	end
	mineField()
end
function mineLineEndPoint()
	if gm_click_mode == "mine end point" then
		gm_click_mode = nil
		onGMClick(nil)
		if mine_line_start_marker ~= nil and mine_line_start_marker:isValid() then
			mine_line_start_marker:destroy()
		end
	end
	mineField()
end
function gmClickMineLineStart(x,y)
	mine_line_start_x = x
	mine_line_start_y = y
	mine_line_start_marker = Asteroid():setPosition(x,y)
	gm_click_mode = "mine line end"
	onGMClick(gmClickMineLineEnd)
	mineField()
end
function gmClickMineLineEnd(x,y)
	mine_line_start_marker:destroy()
	local line_length = distance(mine_line_start_x,mine_line_start_y,x,y)
	local angle = angleFromVectorNorth(x,y,mine_line_start_x,mine_line_start_y)
	local mine_count = 0
	local placed_mine = Mine():setPosition(mine_line_start_x,mine_line_start_y)
	local mx, my = vectorFromAngleNorth(angle,mine_count*1200)
	local line_angle = 0
	repeat
		mine_count = mine_count + 1
		mx, my = vectorFromAngleNorth(angle,mine_count*1200)
		placed_mine = Mine():setPosition(mine_line_start_x+mx,mine_line_start_y+my)
	until(distance(placed_mine,mine_line_start_x,mine_line_start_y) > line_length)
	if mine_width > 1 then
		line_angle = (angle + 90) % 360
		mx, my = vectorFromAngleNorth(line_angle,1200)
		local start_line_2_x = mine_line_start_x + mx
		local start_line_2_y = mine_line_start_y + my
		placed_mine = Mine():setPosition(start_line_2_x,start_line_2_y)
		mine_count = 0
		repeat
			mine_count = mine_count + 1
			mx, my = vectorFromAngleNorth(angle,mine_count*1200)
			placed_mine = Mine():setPosition(start_line_2_x + mx,start_line_2_y + my)
		until(distance(placed_mine,start_line_2_x,start_line_2_y) > line_length)
	end
	if mine_width > 2 then
		line_angle = (angle + 270) % 360
		mx, my = vectorFromAngleNorth(line_angle,1200)
		local start_line_3_x = mine_line_start_x + mx
		local start_line_3_y = mine_line_start_y + my
		placed_mine = Mine():setPosition(start_line_3_x,start_line_3_y)
		mine_count = 0
		repeat
			mine_count = mine_count + 1
			mx, my = vectorFromAngleNorth(angle,mine_count*1200)
			placed_mine = Mine():setPosition(start_line_3_x + mx,start_line_3_y + my)
		until(distance(placed_mine,start_line_3_x,start_line_3_y) > line_length)
	end
	onGMClick(gmClickMineLineStart)
	gm_click_mode = "mine line start"
	mineField()
end
--	Arc shaped minefield functions
function mineArcCenterPoint()
	if gm_click_mode == "mine arc center" then
		gm_click_mode = nil
		onGMClick(nil)
	else
		local prev_mode = gm_click_mode
		gm_click_mode = "mine arc center"
		onGMClick(gmClickMineArcCenter)
		if prev_mode ~= nil then
			addGMMessage(string.format("Cancelled current GM Click mode\n   %s\nIn favor of\n   mine arc center\nGM click mode.",prev_mode))
		end
	end
	mineField()
end
function mineArcStartPoint()
	if gm_click_mode == "mine arc start" then
		gm_click_mode = nil
		onGMClick(nil)
		if mine_arc_center_marker ~= nil and mine_arc_center_marker:isValid() then
			mine_arc_center_marker:destroy()
		end
	end
	mineField()
end
function mineArcEndPoint()
	if gm_click_mode == "mine arc end" then
		gm_click_mode = nil
		onGMClick(nil)
		if mine_arc_center_marker ~= nil and mine_arc_center_marker:isValid() then
			mine_arc_center_marker:destroy()
		end
		if mine_arc_start_marker ~= nil and mine_arc_start_marker:isValid() then
			mine_arc_start_marker:destroy()
		end
	end
	mineField()
end
function gmClickMineArcCenter(x,y)
	mine_arc_center_x = x
	mine_arc_center_y = y
	mine_arc_center_marker = Asteroid():setPosition(x,y)
	gm_click_mode = "mine arc start"
	onGMClick(gmClickMineArcStart)
	mineField()
end
function gmClickMineArcStart(x,y)
	mine_arc_start_x = x
	mine_arc_start_y = y
	mine_arc_center_marker:setSize(1000)
	mine_arc_start_marker = Asteroid():setPosition(x,y)
	gm_click_mode = "mine arc end"
	onGMClick(gmClickMineArcEnd)
	mineField()
end
function gmClickMineArcEnd(x,y)
	mine_arc_start_marker:destroy()
	mine_arc_center_marker:destroy()
	local arc_radius = distance(mine_arc_center_x,mine_arc_center_y,mine_arc_start_x,mine_arc_start_y)
	local angle = angleFromVectorNorth(mine_arc_start_x,mine_arc_start_y,mine_arc_center_x,mine_arc_center_y)
	local final_angle = angleFromVectorNorth(x,y,mine_arc_center_x,mine_arc_center_y)
	local mine_count = 0
	local mx, my = vectorFromAngleNorth(angle,arc_radius)
	local placed_mine = Mine():setPosition(mine_arc_center_x+mx,mine_arc_center_y+my)
	local angle_increment = 0
	repeat
		angle_increment = angle_increment + 0.1
		mx, my = vectorFromAngleNorth(angle + angle_increment,arc_radius)
	until(distance(placed_mine,mine_arc_center_x+mx,mine_arc_center_y+my) > 1200)
	if final_angle <= angle then
		final_angle = final_angle + 360
	end
	local start_angle = angle
	repeat
		angle = angle + angle_increment
		mx, my = vectorFromAngleNorth(angle,arc_radius)
		placed_mine = Mine():setPosition(mine_arc_center_x+mx,mine_arc_center_y+my)
	until(angle > final_angle)
	if mine_width > 1 then
		angle = start_angle
		mx, my = vectorFromAngleNorth(angle,arc_radius+1200)
		placed_mine = Mine():setPosition(mine_arc_center_x+mx,mine_arc_center_y+my)
		repeat
			angle_increment = angle_increment + 0.1
			mx, my = vectorFromAngleNorth(angle + angle_increment,arc_radius + 1200)
		until(distance(placed_mine,mine_arc_center_x+mx,mine_arc_center_y+my) > 1200)
		repeat
			angle = angle + angle_increment
			mx, my = vectorFromAngleNorth(angle,arc_radius + 1200)
			placed_mine = Mine():setPosition(mine_arc_center_x+mx,mine_arc_center_y+my)
		until(angle > final_angle)
	end
	if mine_width > 2 then
		angle = start_angle
		mx, my = vectorFromAngleNorth(angle,arc_radius+2400)
		placed_mine = Mine():setPosition(mine_arc_center_x+mx,mine_arc_center_y+my)
		repeat
			angle_increment = angle_increment + 0.1
			mx, my = vectorFromAngleNorth(angle + angle_increment,arc_radius + 2400)
		until(distance(placed_mine,mine_arc_center_x+mx,mine_arc_center_y+my) > 1200)
		repeat
			angle = angle + angle_increment
			mx, my = vectorFromAngleNorth(angle,arc_radius + 2400)
			placed_mine = Mine():setPosition(mine_arc_center_x+mx,mine_arc_center_y+my)
		until(angle > final_angle)
	end
	onGMClick(gmClickMineArcCenter)
	gm_click_mode = "mine arc center"
	mineField()
end
--	Circle shaped minefield functions
function mineCircle()
	if gm_click_mode == "mine circle" then
		gm_click_mode = nil
		onGMClick(nil)
	else
		local prev_mode = gm_click_mode
		gm_click_mode = "mine circle"
		onGMClick(gmClickMineCircle)
		if prev_mode ~= nil then
			addGMMessage(string.format("Cancelled current GM Click mode\n   %s\nIn favor of\n   mine circle\nGM click mode.",prev_mode))
		end
	end
	mineField()
end
function gmClickMineCircle(x,y)
	local angle = random(0,360)
	local mx = 0
	local my = 0
	if mine_radius == 1 then
		for i=1,4 do
			mx, my = vectorFromAngle(angle,mine_radius*1000)
			Mine():setPosition(x+mx,y+my)
			angle = (angle + 90) % 360
		end
		if mine_width > 1 then
			for i=1,10 do
				mx, my = vectorFromAngle(angle,mine_radius*1000 + 1200)
				Mine():setPosition(x+mx,y+my)
				angle = (angle + 36) % 360
			end
		end
		if mine_width > 2 then
			for i=1,15 do
				mx, my = vectorFromAngle(angle,mine_radius*1000 + 2400)
				Mine():setPosition(x+mx,y+my)
				angle = (angle + 24) % 360
			end
		end
	end
	if mine_radius == 2 then
		for i=1,9 do
			mx, my = vectorFromAngle(angle,mine_radius*1000)
			Mine():setPosition(x+mx,y+my)
			angle = (angle + 40) % 360
		end
		if mine_width > 1 then
			for i=1,15 do
				mx, my = vectorFromAngle(angle,mine_radius*1000 + 1200)
				Mine():setPosition(x+mx,y+my)
				angle = (angle + 24) % 360
			end
		end
		if mine_width > 2 then
			for i=1,20 do
				mx, my = vectorFromAngle(angle,mine_radius*1000 + 2400)
				Mine():setPosition(x+mx,y+my)
				angle = (angle + 18) % 360
			end
		end
	end
	if mine_radius == 3 then
		for i=1,15 do
			mx, my = vectorFromAngle(angle,mine_radius*1000)
			Mine():setPosition(x+mx,y+my)
			angle = (angle + 24) % 360
		end
		if mine_width > 1 then
			for i=1,20 do
				mx, my = vectorFromAngle(angle,mine_radius*1000 + 1200)
				Mine():setPosition(x+mx,y+my)
				angle = (angle + 18) % 360
			end
		end
		if mine_width > 2 then
			for i=1,25 do
				mx, my = vectorFromAngle(angle,mine_radius*1000 + 2400)
				Mine():setPosition(x+mx,y+my)
				angle = angle + 14.4
			end
		end
	end
	if mine_radius == 4 then
		for i=1,20 do
			mx, my = vectorFromAngle(angle,mine_radius*1000)
			Mine():setPosition(x+mx,y+my)
			angle = (angle + 18) % 360
		end
		if mine_width > 1 then
			for i=1,25 do
				mx, my = vectorFromAngle(angle,mine_radius*1000 + 1200)
				Mine():setPosition(x+mx,y+my)
				angle = angle + 14.4
			end
		end
		if mine_width > 2 then
			for i=1,30 do
				mx, my = vectorFromAngle(angle,mine_radius*1000 + 2400)
				Mine():setPosition(x+mx,y+my)
				angle = angle + 12
			end
		end
	end
	if mine_radius == 5 then
		for i=1,25 do
			mx, my = vectorFromAngle(angle,mine_radius*1000)
			Mine():setPosition(x+mx,y+my)
			angle = angle + 14.4
		end
		if mine_width > 1 then
			for i=1,30 do
				mx, my = vectorFromAngle(angle,mine_radius*1000 + 1200)
				Mine():setPosition(x+mx,y+my)
				angle = angle + 12
			end
		end
		if mine_width > 2 then
			for i=1,36 do
				mx, my = vectorFromAngle(angle,mine_radius*1000 + 2400)
				Mine():setPosition(x+mx,y+my)
				angle = angle + 10
			end
		end
	end
end
--	*												   *  --
--	**												  **  --
--	****************************************************  --
--	****				Countdown Timer				****  --
--	****************************************************  --
--	**												  **  --
--	*												   *  --
---------------------------------
--	Countdown Timer > Display  --
---------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN FROM TIMER		F	initialGMFunctions
-- -FROM DISPLAY		F	countdownTimer
-- HELM					*	inline	(choices are not mutually exclusive)
-- WEAPONS				*	inline
-- ENGINEER				*	inline
-- SCIENCE				*	inline
-- RELAY				*	inline
function GMTimerDisplay()
	clearGMFunctions()
	addGMFunction("-Main from Timer",initialGMFunctions)
	addGMFunction("-From Display",countdownTimer)
	local timer_label = "Helm"
	if timer_display_helm then
		timer_label = timer_label .. "*"
	end
	addGMFunction(timer_label, function()
		if timer_display_helm then
			timer_display_helm = false
		else
			timer_display_helm = true
		end
		GMTimerDisplay()
	end)
	timer_label = "Weapons"
	if timer_display_weapons then
		timer_label = timer_label .. "*"
	end
	addGMFunction(timer_label, function()
		if timer_display_weapons then
			timer_display_weapons = false
		else
			timer_display_weapons = true
		end
		GMTimerDisplay()
	end)
	timer_label = "Engineer"
	if timer_display_engineer then
		timer_label = timer_label .. "*"
	end
	addGMFunction(timer_label, function()
		if timer_display_engineer then
			timer_display_engineer = false
		else
			timer_display_engineer = true
		end
		GMTimerDisplay()
	end)
	timer_label = "Science"
	if timer_display_science then
		timer_label = timer_label .. "*"
	end
	addGMFunction(timer_label, function()
		if timer_display_science then
			timer_display_science = false
		else
			timer_display_science = true
		end
		GMTimerDisplay()
	end)
	timer_label = "Relay"
	if timer_display_relay then
		timer_label = timer_label .. "*"
	end
	addGMFunction(timer_label, function()
		if timer_display_relay then
			timer_display_relay = false
		else
			timer_display_relay = true
		end
		GMTimerDisplay()
	end)
end
--------------------------------
--	Countdown Timer > Length  --
--------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN FROM TIMER		F	initialGMFunctions
-- -FROM LENGTH			F	countdownTimer
-- 1 MINUTE				*	inline
-- 3 MINUTES			*	inline
-- 5 MINUTES*			*	inline		asterisk = current selection
-- 10 MINUTES			*	inline
-- 15 MINUTES			*	inline
-- 20 MINUTES			*	inline
-- 30 MINUTES			*	inline
-- 45 MINUTES			*	inline
function GMTimerLength()
	clearGMFunctions()
	addGMFunction("-Main from Timer",initialGMFunctions)
	addGMFunction("-From Length",countdownTimer)
	local length_label = ""
	if timer_start_length == 1 then
		length_label = "1 Minute*"
	else
		length_label = "1 Minute"
	end
	addGMFunction(length_label, function()
		timer_start_length = 1
		GMTimerLength()
	end)
	if timer_start_length == 3 then
		length_label = "3 Minutes*"
	else
		length_label = "3 Minutes"
	end
	addGMFunction(length_label, function()
		timer_start_length = 3
		GMTimerLength()
	end)
	if timer_start_length == 5 then
		length_label = "5 Minutes*"
	else
		length_label = "5 Minutes"
	end
	addGMFunction(length_label, function()
		timer_start_length = 5
		GMTimerLength()
	end)
	if timer_start_length == 10 then
		length_label = "10 Minutes*"
	else
		length_label = "10 Minutes"
	end
	addGMFunction(length_label, function()
		timer_start_length = 10
		GMTimerLength()
	end)
	if timer_start_length == 15 then
		length_label = "15 Minutes*"
	else
		length_label = "15 Minutes"
	end
	addGMFunction(length_label, function()
		timer_start_length = 15
		GMTimerLength()
	end)
	if timer_start_length == 20 then
		length_label = "20 Minutes*"
	else
		length_label = "20 Minutes"
	end
	addGMFunction(length_label, function()
		timer_start_length = 20
		GMTimerLength()
	end)
	if timer_start_length == 30 then
		length_label = "30 Minutes*"
	else
		length_label = "30 Minutes"
	end
	addGMFunction(length_label, function()
		timer_start_length = 30
		GMTimerLength()
	end)
	if timer_start_length == 45 then
		length_label = "45 Minutes*"
	else
		length_label = "45 Minutes"
	end
	addGMFunction(length_label, function()
		timer_start_length = 45
		GMTimerLength()
	end)
end
---------------------------------
--	Countdown Timer > Purpose  --
---------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN FROM TIMER		F	initialGMFunctions
-- -FROM PURPOSE		F	countdownTimer
-- TIMER*				*	inline		asterisk = current selection
-- DEATH				*	inline
-- BREAKDOWN			*	inline
-- MISSION				*	inline
-- DEPARTURE			*	inline
-- DESTRUCTION			*	inline
-- DISCOVERY			*	inline
function GMTimerPurpose()
	clearGMFunctions()
	addGMFunction("-Main from Timer",initialGMFunctions)
	addGMFunction("-From Purpose",countdownTimer)
	if purpose_label == nil then
		purpose_label = {
			"Timer"				,
			"Death"				,
			"Breakdown"			,
			"Mission"			,
			"Departure"			,
			"Destruction"		,
			"Discovery"			,
			"Decompression"		
		}
	end
	local button_label = nil
	for i=1,#purpose_label do
		local current_purpose = purpose_label[i]
		if timer_purpose == current_purpose then
			button_label = string.format("%s*",current_purpose)
		else
			button_label = current_purpose
		end
		addGMFunction(button_label,function()
			timer_purpose = current_purpose
			GMTimerPurpose()
		end)
	end
end
-------------------------------------
--	Countdown Timer > Add Seconds  --
-------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN				F	initialGMFunctions
-- -FROM ADD SECONDS	F	countdownTimer
-- ADD 1 SECONDS		F	inline
-- ADD 3 SECONDS		F	inline
-- ADD 5 SECONDS		F	inline
-- ADD 10 SECONDS		F	inline
function addSecondsToTimer()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-From Add Seconds",countdownTimer)
	addGMFunction("Add 1 second",function()
		local prev_timer_value = timer_value
		timer_value = timer_value + 1
		addGMMessage(string.format("Timer changed from %.1f to %.1f",prev_timer_value,timer_value))
	end)
	addGMFunction("Add 3 seconds",function()
		local prev_timer_value = timer_value
		timer_value = timer_value + 3
		addGMMessage(string.format("Timer changed from %.1f to %.1f",prev_timer_value,timer_value))
	end)
	addGMFunction("Add 5 seconds",function()
		local prev_timer_value = timer_value
		timer_value = timer_value + 5
		addGMMessage(string.format("Timer changed from %.1f to %.1f",prev_timer_value,timer_value))
	end)
	addGMFunction("Add 10 seconds",function()
		local prev_timer_value = timer_value
		timer_value = timer_value + 10
		addGMMessage(string.format("Timer changed from %.1f to %.1f",prev_timer_value,timer_value))
	end)
end
----------------------------------------
--	Countdown Timer > Delete Seconds  --
----------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN				F	initialGMFunctions
-- -FROM DEL SECONDS	F	countdownTimer
-- DEL 1 SECONDS		F	inline
-- DEL 3 SECONDS		F	inline
-- DEL 5 SECONDS		F	inline
-- DEL 10 SECONDS		F	inline
function deleteSecondsFromTimer()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-From Del Seconds",countdownTimer)
	addGMFunction("Del 1 second",function()
		local prev_timer_value = timer_value
		timer_value = timer_value - 1
		addGMMessage(string.format("Timer changed from %.1f to %.1f",prev_timer_value,timer_value))
	end)
	addGMFunction("Del 3 seconds",function()
		local prev_timer_value = timer_value
		timer_value = timer_value - 3
		addGMMessage(string.format("Timer changed from %.1f to %.1f",prev_timer_value,timer_value))
	end)
	addGMFunction("Del 5 seconds",function()
		local prev_timer_value = timer_value
		timer_value = timer_value - 5
		addGMMessage(string.format("Timer changed from %.1f to %.1f",prev_timer_value,timer_value))
	end)
	addGMFunction("Del 10 seconds",function()
		local prev_timer_value = timer_value
		timer_value = timer_value - 10
		addGMMessage(string.format("Timer changed from %.1f to %.1f",prev_timer_value,timer_value))
	end)
end
--------------------------------------
--	Countdown Timer > Change Speed  --
--------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN				F	initialGMFunctions
-- -FROM CHANGE SPEED	F	countdownTimer
-- SLOW DOWN			D	inline
-- NORMALIZE			F	inline
-- SPEED UP				D	inline
function changeTimerSpeed()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-From Change Speed",countdownTimer)
	local button_label = "Slow Down"
	if timer_fudge > 0 then
		button_label = string.format("%s %.3f",button_label,timer_fudge)
	end
	addGMFunction(button_label,function()
		timer_fudge = timer_fudge + .005
		changeTimerSpeed()
	end)
	addGMFunction("Normalize",function()
		timer_fudge = 0
		changeTimerSpeed()
	end)
	button_label = "Spped Up"
	if timer_fudge < 0 then
		button_label = string.format("%s %.3f",button_label,-timer_fudge)
	end
	addGMFunction(button_label,function()
		timer_fudge = timer_fudge - .005
		changeTimerSpeed()
	end)
end
--	*											   *  --
--	**											  **  --
--	************************************************  --
--	****				End Session				****  --
--	************************************************  --
--	**											  **  --
--	*											   *  --
-----------------------------------
--	End Session > Region Report  --
-----------------------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN FROM REGION	F	initialGMFunctions
-- -END SESSION			F	endSession
-- ICARUS REPORT		F	inline
function regionReport()
	clearGMFunctions()
	addGMFunction("-Main From Region",initialGMFunctions)
	addGMFunction("-End Session",endSession)
	if icarus_color then
		addGMFunction("Icarus Report",function()
			local icarus_report = "Icarus Region Report:"
			local stations_destroyed = ""
			local all_survived = true
			for name, station in pairs(station_names) do
				if station[2] == nil or not station[2]:isValid() then
					all_survived = false
					stations_destroyed = string.format("%s\n    %s %s",stations_destroyed,station[1],name)
				end
			end
			if all_survived then
				icarus_report = icarus_report .. "\n  All stations survived"
			else
				icarus_report = string.format("%s\n  Stations Destroyed:%s",icarus_report,stations_destroyed)
			end
			addGMMessage(icarus_report)
			print(icarus_report)
		end)
	end
	if kentar_color then
		addGMFunction("Kentar Report",function()
			local kentar_report = "Kentar Region Report:"
			local stations_destroyed = ""
			local all_survived = true
			for name, station in pairs(station_names) do
				if station[2] == nil or not station[2]:isValid() then
					all_survived = false
					stations_destroyed = string.format("%s\n    %s %s",stations_destroyed,station[1],name)
				end
			end
			if all_survived then
				kentar_report = kentar_report .. "\n  All stations survived"
			else
				kentar_report = string.format("%s\n  Stations Destroyed:%s",kentar_report,stations_destroyed)
			end
			addGMMessage(kentar_report)
			print(kentar_report)
		end)
	end
end
-------------------------------------
--	End Session > Faction Victory  --
-------------------------------------
-- Button Text		   FD*	Related Function(s)
-- -FROM VICTORY		F	inline
-- HUMAN VICTORY		F	inline
-- KRAYLOR VICTORY		F	inline
-- EXUARI VICTORY		F	inline
-- GHOST VICTORY		F	inline
-- ARLENIAN VICTORY		F	inline
-- INDEPENDENT VICTORY	F	inline
-- KTLITAN VICTORY		F	inline
-- TSN VICTORY			F	inline
-- USN VICTORY			F	inline
-- CUF VICTORY			F	inline
function endMission()
	clearGMFunctions()
	addGMFunction("-from Victory",endSession)
	addGMFunction("Human Victory",function()
		victory("Human Navy")
	end)
	addGMFunction("Kraylor Victory",function()
		victory("Kraylor")
	end)
	addGMFunction("Exuari Victory",function() 
		victory("Exuari")
	end)
	addGMFunction("Ghost Victory",function() 
		victory("Ghosts")
	end)
	addGMFunction("Arlenian Victory",function() 
		victory("Arlenians")	
	end)
	addGMFunction("Independent Victory",function() 
		victory("Independent")
	end)
	addGMFunction("Ktlitan Victory",function() 
		victory("Ktlitans")
	end)
	addGMFunction("TSN Victory",function()
		victory("TSN")
	end)
	addGMFunction("USN Victory",function()
		victory("USN")
	end)
	addGMFunction("CUF Victory",function()
		victory("CUF")
	end)
end
--	*										   *  --
--	**										  **  --
--	********************************************  --
--	****				Custom				****  --
--	********************************************  --
--	**										  **  --
--	*										   *  --
----------------------
--  Custom > Debug  --
----------------------
-- Button Text		   FD*	Related Function(s)
-- -MAIN FROM END		F	initialGMFunctions
-- -CUSTOM				F	customButtons
-- OBJECT COUNTS		F	inline
-- ALWAYS POPUP DEBUG	F	inline
-- ONCE POPUP DEBUG		F	inline
-- NEVER POPUP DEBUG	F	inline
function debugButtons()
	clearGMFunctions()
	addGMFunction("-Main From Debug",initialGMFunctions)
	addGMFunction("-Custom",customButtons)
	addGMFunction("Object Counts",function()
		addGMMessage(getNumberOfObjectsString())
	end)
	addGMFunction("always popup debug",function()
		popupGMDebug = "always"
	end)
	addGMFunction("once popup debug",function()
		popupGMDebug = "once"
	end)
	addGMFunction("never popup debug",function()
		popupGMDebug = "never"
	end)
end
-------------------------
--	Custom > Snippets  --
-------------------------
--Due to the intent of this being high churn I am skipping the customary list of buttons

-- these are fragments of code which may be of use as is
-- they currently don't live in a menu that they should eventually
-- and they may lack being generic enough to be part of the sandbox proper
-- note to people adding to them
-- please put a reason as to at least one of
-- 1) why they exist
-- 2) why they aren't in a menu
-- 3) why they aren't generic enough to be in a menu
function snippetButtons()
	clearGMFunctions()
	addGMFunction("-Main From snippet",initialGMFunctions)
	addGMFunction("-Custom",customButtons)
	-- set up for moons game for 2020-07-18
	-- there are parameters in there that where tunned for that game
	-- it detestably should be moved elsewhere
	-- ideally it would be made so the tunned parameters could be set at run time
	addGMFunction("+callsign cycle",callsignCycle)
	-- starry suggested replacement for scan points menu
	-- currently the stock EE build lacks onGMClick and tweak menu additions
	addGMFunction("Expire Selected", function ()
		for k,v in pairs(getGMSelection()) do
			update_system:addTimeToLiveUpdate(v)
		end
	end)
	-- spawn the research base used on 2020-06-06
	-- the location is fixed, the design is fixed
	-- with both of those being fixed it is hard to make it generic
	-- and we aren't (probably) going back there making it not applicable for the sandbox
	-- but the code is something that could be edited into generic code for circular base designs in time
	addGMFunction("base", function ()
		local cx=27200
		local cy=227000
		local inner_ring_speed=90
		local i_rad=8200
		local i_1=21000
		local i_2=math.sqrt(2)*i_1/2
		mineRingShim{dist=30000	,x=cx		,y=cy		,gap=1,gap_size=10,speed=900,segments=6}--outer ring, easy to get in with 60 impluse boosted
		mineRingShim{dist=9000	,x=cx		,y=cy		,gap=6,gap_size=20,speed=60 ,segments=8} -- inner ring, expected method of breaching is probes
		mineRingShim{dist=i_rad ,x=cx		,y=cy+-i_1	,gap=3,gap_size=20,speed= inner_ring_speed,segments=2} -- test traversing
		mineRingShim{dist=i_rad ,x=cx		,y=cy+ i_1	,gap=3,gap_size=20,speed= inner_ring_speed,segments=2}
		mineRingShim{dist=i_rad ,x=cx+ i_1	,y=cy		,gap=3,gap_size=20,speed= inner_ring_speed,segments=2}
		mineRingShim{dist=i_rad ,x=cx+-i_1	,y=cy		,gap=3,gap_size=20,speed= inner_ring_speed,segments=2}
		mineRingShim{dist=i_rad ,x=cx+-i_2	,y=cy+-i_2	,gap=3,gap_size=20,speed=-inner_ring_speed,segments=2}
		mineRingShim{dist=i_rad ,x=cx+ i_2	,y=cy+-i_2	,gap=3,gap_size=20,speed=-inner_ring_speed,segments=2}
		mineRingShim{dist=i_rad ,x=cx+-i_2	,y=cy+ i_2	,gap=3,gap_size=20,speed=-inner_ring_speed,segments=2}
		mineRingShim{dist=i_rad ,x=cx+ i_2	,y=cy+ i_2	,gap=3,gap_size=20,speed=-inner_ring_speed,segments=2}
		createObjectCircle{radius=i_1,x=cx	,y=cy	,number=8,	callback=function() return SpaceStation():setTemplate("Small Station"):setFaction("Kraylor"):setCallSign("Control Station") end}
		createObjectCircle{radius=i_1-i_rad,	start_angle=(360/16)	,x=cx	,y=cy	,number=8,callback=function() return WarpJammer():setFaction("Kraylor") end}
		createObjectCircle{radius=27000,	start_angle=(360/16)	,x=cx	,y=cy	,number=8,callback=function() return WarpJammer():setFaction("Kraylor") end}
		createObjectCircle{radius=2000,x=cx	,y=cy	,number=4,callback=function() return WarpJammer():setFaction("Kraylor"):setRange(6000) end}
		leech("Kraylor"):setPosition(cx+2000,cy+2000):setDescription("weapons satellite"):setCallSign("WP-1")
		leech("Kraylor"):setPosition(cx+2000,cy-2000):setDescription("weapons satellite"):setCallSign("WP-2")
		leech("Kraylor"):setPosition(cx-2000,cy+2000):setDescription("weapons satellite"):setCallSign("WP-3")
		leech("Kraylor"):setPosition(cx-2000,cy-2000):setDescription("weapons satellite"):setCallSign("WP-4")
		SpaceStation():setTemplate("Small Station"):setFaction("Kraylor"):setCallSign("Research 6"):setPosition(cx+6000,cy+0)
		SpaceStation():setTemplate("Small Station"):setFaction("Kraylor"):setCallSign("Research 15"):setPosition(cx-6000,cy+0)
		SpaceStation():setTemplate("Small Station"):setFaction("Kraylor"):setCallSign("Research 35"):setPosition(cx+0,cy+6000)
		SpaceStation():setTemplate("Small Station"):setFaction("Kraylor"):setCallSign("Research 27"):setPosition(cx+0,cy-6000)
		Artifact():setPosition(cx+0,cy+0):setDescription("Contains long range jumpNav calculation"):setCallSign("computer core")
	end)
	-- continuation of the above, whatever happens to base should happen to this
	-- debatably they should be merged into one function as they are both for reference
	addGMFunction("Jammer Ring",function ()
		local cx=27200
		local cy=227000
		local i_1=21500
		local i_2=math.sqrt(2)*i_1/2
		WarpJammer():setFaction("Kraylor"):setPosition(cx+i_1,cy+0)
		WarpJammer():setFaction("Kraylor"):setPosition(cx-i_1,cy+0)
		WarpJammer():setFaction("Kraylor"):setPosition(cx+0,cy+i_1)
		WarpJammer():setFaction("Kraylor"):setPosition(cx+0,cy-i_1)
		WarpJammer():setFaction("Kraylor"):setPosition(cx+i_2,cy+i_2)
		WarpJammer():setFaction("Kraylor"):setPosition(cx+i_2,cy-i_2)
		WarpJammer():setFaction("Kraylor"):setPosition(cx-i_2,cy+i_2)
		WarpJammer():setFaction("Kraylor"):setPosition(cx-i_2,cy-i_2)
	end)
end
-----------------------------
--	Object creation utils  --
-----------------------------
-- these may want to be considered to merge into utils.lua

-- all of these functions take a table of function parameters
-- this is to mimic named arguments
-- defaults that are "sensible" will be picked for all
-- however I fear to say my definition of sensible and yours may clash
-- each function takes one argument as a callback
-- which is called for each point created
-- this callback function should return a EmptyEpsilon spaceObject
-- it also has parameters put into a table
-- currently this is the count parameter
-- all the standard EE spaceObject constructors should ignore this table, thus allowing them to be used
function createObjectCircle(args)
	-- just a circle with no gaps
	assert(type(args)=="table")
	local x=args.x or 0
	local y=args.y or 0
	local radius=args.radius or 1000
	local number=args.number or 360
	local start_angle=args.start_angle or 0
	local callback=args.callback or Artifact
	assert(type(x)=="number")
	assert(type(y)=="number")
	assert(type(radius)=="number")
	assert(type(number)=="number")
	assert(type(start_angle)=="number")
	assert(type(callback)=="function")
	for i=1,number do
		setCirclePos(callback{count=i},x,y,(360/number*i)+start_angle,radius)
	end
end
function mineRingShim(args)
	local angle=args.angle or random(0,360)
	local speed=args.speed -- if not set it will remain nil - this is because nil means no orbit to createOrbitingObject
	local x=args.x or 0
	local y=args.y or 0
	local min_dist=args.dist or 1000
	local num_rows=args.num_rows or 1
	local row_gap=args.row_gap or 500
	local segments=args.segments or 1
	local half_gap_size=args.gap_size or 20
	half_gap_size=half_gap_size/2
	local gap=args.gap or 3
	local increment=(360/segments)
	if segments == 0 then
		segments=1
		half_gap_size=0
	end
	for i=1,segments do
		for j=angle+half_gap_size,angle+increment-half_gap_size,gap do
			for row=0,num_rows-1 do
				local dist=min_dist+row_gap*row
				createOrbitingObject(Mine(),j,speed,x,y,dist)
			end
		end
		angle=angle+increment
	end
end
function callsignCycle()
	clearGMFunctions()
	addGMFunction("-Main",initialGMFunctions)
	addGMFunction("-Custom",customButtons)
	addGMFunction("-Snippets",snippetButtons)
	local params = {
		{"setup",450,200,1,2,0},
		{"drone",75,60,1,2,200},
		{"fighter",50,60,1,2,100},
		{"beam",100,150,1,2,400},
		{"missile",100,150,1,2,600},
		{"chaser",50,30,1,2,500},
		{"adder",75,60,1,2,350}
	}
	for param_index=1,#params do
		local param = params[param_index]
		addGMFunction(param[1],function()
			local objectList = getGMSelection()
			if #objectList == 0 then
				addGMMessage("Need to select a target(s) for this to apply to")
				return
			end
			for index = 1,#objectList do
				local callbackFunction = function(self,obj)
					local num=param[2]*(param[3]*math.cos(getScenarioTimePreStandard()*param[4])/getScenarioTimePreStandard()*param[5])+param[6]
					local str=string.format("%.2f",num)
					self:setCallSign(str)
				end
				update_system:addPeriodicCallback(objectList[index],callbackFunction,0.1);
			end
		end)
	end
end
-- in several places it would be nice to get more errors reported
-- this is to assist with that
-- the popupGMDebug may want to go in the next version of EE
-- currently popups are stored between script reloads
-- which means without that if there is an error in update
-- you can end with hundreds of popups which need to be closed
-- for the next sim

function scienceDatabase()
	clearGMFunctions()
	addGMFunction("-Main From Science DB",initialGMFunctions)
	addGMFunction("-Custom",customButtons)
	addGMFunction("Traverse",function()
		local function printDb(entry, indent)
			indent = indent or 0
			local pad = ""
			for _=1,indent do 
				pad = pad .. " " 
			end
			print(pad .. "* " .. entry:getName())
			if (entry:hasEntries()) then
				for _, child in pairs(entry:getEntries()) do
					printDb(child, indent + 2)
				end
			end
		end
		for _, entry in pairs(getScienceDatabases()) do
			printDb(entry)
		end
	end)
	addGMFunction("Dump",function()
		local dump_db = queryScienceDatabase("Ships", "Corvette", "Atlantis X23")
		print(dump_db:getName() .. "\n\n" .. dump_db:getLongDescription())
		local extracted_image = dump_db:getImage()
		print(extracted_image)
		for key, value in pairs(dump_db:getKeyValues()) do
			print(string.format("%20s: %25s", key, value))
		end
	end)
end

function wrapFunctionInPcall(fun, ...)
	assert(type(fun)=="function")
    local status,error=pcall(fun, ...)
    if not status then
		print("script error : - ")
		print(error)
		if popupGMDebug == "once" or popupGMDebug == "always" then
			if popupGMDebug == "once" then
				popupGMDebug = "never"
			end
			addGMMessage("script error - \n"..error)
		end
    end
end
-- currently EE doesn't make it easy to see if there are errors in GMbuttons
-- this saves the old addGMFunction, and makes it so all calls to addGMFunction
-- wraps the callback in the pcall logic elsewhere
addGMFunctionReal=addGMFunction
function addGMFunction(msg, fun)
	return addGMFunctionReal(msg,function () wrapFunctionInPcall(fun) end)
end
function getNumberOfObjectsString(all_objects)
	-- get a multi-line string for the number of objects at the current time
	-- intended to be used via addGMMessage or print, but there may be other uses
	-- it may be worth considering adding a function which would return an array rather than a string
	-- all_objects is passed in (as an optional argument) mostly to assist testing
	assert(all_objects==nil or type(all_objects)=="table")
	if all_objects == nil then
		all_objects=getAllObjects()
	end
	local object_counts={}
	--first up we accumulate the number of each type of object
	for i=1,#all_objects do
		local object_type=all_objects[i].typeName
		local current_count=object_counts[object_type]
		if current_count==nil then
			current_count=0
		end
		object_counts[object_type]=current_count+1
	end
	-- we want the ordering to be stable so we build a key list
	local sorted_counts={}
	for type in pairs(object_counts) do
		table.insert(sorted_counts, type)
	end
	table.sort(sorted_counts)
	--lastly we build the output
	local output=""
	for _,object_type in ipairs(sorted_counts) do
		output=output..string.format("%s: %i\n",object_type,object_counts[object_type])
	end
	return output..string.format("\nTotal: %i",#all_objects)
end
function getNumberOfObjectsStringTest()
	-- ideally we would have something to ensure the tables we pass in are close to getAllObjects tables
	assert(getNumberOfObjectsString({})=="\nTotal: 0")
	assert(getNumberOfObjectsString({{typeName ="test"}})=="test: 1\n\nTotal: 1")
	assert(getNumberOfObjectsString({{typeName ="test"},{typeName ="test"}})=="test: 2\n\nTotal: 2")
	assert(getNumberOfObjectsString({{typeName ="testA"},{typeName ="testB"}})=="testA: 1\ntestB: 1\n\nTotal: 2")
	assert(getNumberOfObjectsString({{typeName ="testA"},{typeName ="testB"},{typeName ="testB"}})=="testA: 1\ntestB: 2\n\nTotal: 3")
end
------------------------------
--	Time related functions  --
------------------------------
-- these 2 functions and variable be removed in the next version of EE
function getScenarioTimePreStandard()
	return scenarioTime
end
function getScenarioTimePreStandardAddDelta(delta)
	scenarioTime = scenarioTime + delta
end
------------------------------
--	Math related functions  --
------------------------------
function math.lerp (a,b,t)
	-- intended to mirror C++ lerp
	-- linear interpolation
	assert(type(a)=="number")
	assert(type(b)=="number")
	assert(type(t)=="number")
	return a + t * (b - a)
end
function math.CosineInterpolate(y1,y2,mu)
	-- see http://paulbourke.net/miscellaneous/interpolation/
	assert(type(y1)=="number")
	assert(type(y2)=="number")
	assert(type(mu)=="number")
	local mu2 = (1-math.cos(mu*math.pi))/2
	assert(type(mu2)=="number")
	return (y1*(1-mu2)+y2*mu2)
end
function math._CosineInterpolateTableInner(tbl,elmt,t)
	assert(type(tbl)=="table")
	assert(type(t)=="number")
	assert(type(elmt)=="number")
	assert(elmt<#tbl)
	local x_delta=tbl[elmt+1].x-tbl[elmt].x
	if x_delta == 0 then
		return tbl[elmt].y
	end
	local t_scaled=(t-tbl[elmt].x)*(1/x_delta)
--	print(math.CosineInterpolate(tbl[elmt].y,tbl[elmt+1].y,t_scaled))
	return math.CosineInterpolate(tbl[elmt].y,tbl[elmt+1].y,t_scaled)
end
function math.CosineInterpolateTable(tbl,t)
	assert(type(tbl)=="table")
	assert(type(t)=="number")
	assert(#tbl>1)
	for i=1,#tbl-1 do
		if tbl[i+1].x>t then
			return math._CosineInterpolateTableInner(tbl,i,t)
		end
	end
	return math._CosineInterpolateTableInner(tbl,#tbl-1,t)
end
function math.lerpTest()
	assert(math.lerp(1,2,0)==1)
	assert(math.lerp(1,2,1)==2)
	assert(math.lerp(2,1,0)==2)
	assert(math.lerp(2,1,1)==1)
	assert(math.lerp(2,1,.5)==1.5)
	-- extrapolation
	assert(math.lerp(1,2,-1)==0)
	assert(math.lerp(1,2,2)==3)
end
function math.clamp(value,lo,hi)
	-- intended to mirror C++ clamp
	-- clamps value within the range of low and high
	assert(type(value)=="number")
	assert(type(lo)=="number")
	assert(type(hi)=="number")
	if value < lo then
		value = lo
	end
	if value > hi then
		return hi
	end
	return value
end
function math.clampTest()
	assert(math.clamp(0,1,2)==1)
	assert(math.clamp(3,1,2)==2)
	assert(math.clamp(1.5,1,2)==1.5)

	assert(math.clamp(0,2,3)==2)
	assert(math.clamp(4,2,3)==3)
	assert(math.clamp(2.5,2,3)==2.5)
end
function math.extraTests()
	math.lerpTest()
	math.clampTest()
end
------------------------------------------------------
--	Individual beam weapon parameter set functions  --
------------------------------------------------------
-- I (starry) will at some point soon add a similar function to these in a pull request to EE core
-- they will be added to each spaceship
-- if it is accepted, then on the version after that which is release we can use that
-- if not then we should probably find a nice location for these functions to live long term
function compatSetBeamWeaponArc(obj,index,val)
	obj:setBeamWeapon(
		index,
		val,
		obj:getBeamWeaponDirection(index),
		obj:getBeamWeaponRange(index),
		obj:getBeamWeaponCycleTime(index),
		obj:getBeamWeaponDamage(index)
	)
end
function compatSetBeamWeaponDirection(obj,index,val)
	obj:setBeamWeapon(
		index,
		obj:getBeamWeaponArc(index),
		val,
		obj:getBeamWeaponRange(index),
		obj:getBeamWeaponCycleTime(index),
		obj:getBeamWeaponDamage(index)
	)
end
function compatSetBeamWeaponRange(obj,index,val)
	obj:setBeamWeapon(
		index,
		obj:getBeamWeaponArc(index),
		obj:getBeamWeaponDirection(index),
		val,
		obj:getBeamWeaponCycleTime(index),
		obj:getBeamWeaponDamage(index)
	)
end
function compatSetBeamWeaponCycleTime(obj,index,val)
	obj:setBeamWeapon(
		index,
		obj:getBeamWeaponArc(index),
		obj:getBeamWeaponDirection(index),
		obj:getBeamWeaponRange(index),
		val,
		obj:getBeamWeaponDamage(index)
	)
end
function compatSetBeamWeaponDamage(obj,index,val)
	obj:setBeamWeapon(
		index,
		obj:getBeamWeaponArc(index),
		obj:getBeamWeaponDirection(index),
		obj:getBeamWeaponRange(index),
		obj:getBeamWeaponCycleTime(index),
		val
	)
end

--------------------------
--	Ship communication  --
--------------------------
function commsShip()
	if comms_target.comms_data == nil then
		comms_target.comms_data = {friendlyness = random(0.0, 100.0)}
	end
	comms_data = comms_target.comms_data
	if comms_data.goods == nil then
		comms_data.goods = {}
		comms_data.goods[commonGoods[math.random(1,#commonGoods)]] = {quantity = 1, cost = random(20,80)}
		local shipType = comms_target:getTypeName()
		if shipType:find("Freighter") ~= nil then
			if shipType:find("Goods") ~= nil or shipType:find("Equipment") ~= nil then
				repeat
					comms_data.goods[commonGoods[math.random(1,#commonGoods)]] = {quantity = 1, cost = random(20,80)}
					local goodCount = 0
					for good, goodData in pairs(comms_data.goods) do
						goodCount = goodCount + 1
					end
				until(goodCount >= 3)
			end
		end
	end
	if comms_source:isFriendly(comms_target) then
		return friendlyComms(comms_data)
	end
	if comms_source:isEnemy(comms_target) and comms_target:isFriendOrFoeIdentifiedBy(comms_source) then
		return enemyComms(comms_data)
	end
	return neutralComms(comms_data)
end
function friendlyComms(comms_data)
	if comms_data.friendlyness < 20 then
		setCommsMessage("What do you want?");
	else
		setCommsMessage("Sir, how can we assist?");
	end
	addCommsReply("Defend a waypoint", function()
		if comms_source:getWaypointCount() == 0 then
			setCommsMessage("No waypoints set. Please set a waypoint first.");
			addCommsReply("Back", commsShip)
		else
			setCommsMessage("Which waypoint should we defend?");
			for n=1,comms_source:getWaypointCount() do
				addCommsReply("Defend WP" .. n, function()
					comms_target:orderDefendLocation(comms_source:getWaypoint(n))
					setCommsMessage("We are heading to assist at WP" .. n ..".");
					addCommsReply("Back", commsShip)
				end)
			end
		end
	end)
	if comms_data.friendlyness > 0.2 then
		addCommsReply("Assist me", function()
			setCommsMessage("Heading toward you to assist.");
			comms_target:orderDefendTarget(comms_source)
			addCommsReply("Back", commsShip)
		end)
	end
	addCommsReply("Report status", function()
		msg = "Hull: " .. math.floor(comms_target:getHull() / comms_target:getHullMax() * 100) .. "%\n"
		local shields = comms_target:getShieldCount()
		if shields == 1 then
			msg = msg .. "Shield: " .. math.floor(comms_target:getShieldLevel(0) / comms_target:getShieldMax(0) * 100) .. "%\n"
		elseif shields == 2 then
			msg = msg .. "Front Shield: " .. math.floor(comms_target:getShieldLevel(0) / comms_target:getShieldMax(0) * 100) .. "%\n"
			msg = msg .. "Rear Shield: " .. math.floor(comms_target:getShieldLevel(1) / comms_target:getShieldMax(1) * 100) .. "%\n"
		else
			for n=0,shields-1 do
				msg = msg .. "Shield " .. n .. ": " .. math.floor(comms_target:getShieldLevel(n) / comms_target:getShieldMax(n) * 100) .. "%\n"
			end
		end
		local missile_types = {'Homing', 'Nuke', 'Mine', 'EMP', 'HVLI'}
		for i, missile_type in ipairs(missile_types) do
			if comms_target:getWeaponStorageMax(missile_type) > 0 then
					msg = msg .. missile_type .. " Missiles: " .. math.floor(comms_target:getWeaponStorage(missile_type)) .. "/" .. math.floor(comms_target:getWeaponStorageMax(missile_type)) .. "\n"
			end
		end
		setCommsMessage(msg);
		addCommsReply("Back", commsShip)
	end)
	for _, obj in ipairs(comms_target:getObjectsInRange(5000)) do
		if obj.typeName == "SpaceStation" and not comms_target:isEnemy(obj) then
			addCommsReply("Dock at " .. obj:getCallSign(), function()
				setCommsMessage("Docking at " .. obj:getCallSign() .. ".");
				comms_target:orderDock(obj)
				addCommsReply("Back", commsShip)
			end)
		end
	end
	if comms_target.fleet ~= nil then
		--not used since there are not friendly fleets (yet)
		addCommsReply(string.format("Direct %s",comms_target.fleet), function()
			setCommsMessage(string.format("What command should be given to %s?",comms_target.fleet))
			addCommsReply("Report hull and shield status", function()
				msg = "Fleet status:"
				for _, fleetShip in ipairs(friendlyDefensiveFleetList[comms_target.fleet]) do
					if fleetShip ~= nil and fleetShip:isValid() then
						msg = msg .. "\n  " .. fleetShip:getCallSign() .. ":"
						msg = msg .. "\n    Hull: " .. math.floor(fleetShip:getHull() / fleetShip:getHullMax() * 100) .. "%"
						local shields = fleetShip:getShieldCount()
						if shields == 1 then
							msg = msg .. "\n    Shield: " .. math.floor(fleetShip:getShieldLevel(0) / fleetShip:getShieldMax(0) * 100) .. "%"
						else
							msg = msg .. "\n    Shields: "
							if shields == 2 then
								msg = msg .. "Front:" .. math.floor(fleetShip:getShieldLevel(0) / fleetShip:getShieldMax(0) * 100) .. "% Rear:" .. math.floor(fleetShip:getShieldLevel(1) / fleetShip:getShieldMax(1) * 100) .. "%"
							else
								for n=0,shields-1 do
									msg = msg .. " " .. n .. ":" .. math.floor(fleetShip:getShieldLevel(n) / fleetShip:getShieldMax(n) * 100) .. "%"
								end
							end
						end
					end
				end
				setCommsMessage(msg)
				addCommsReply("Back", commsShip)
			end)
			addCommsReply("Report missile status", function()
				msg = "Fleet missile status:"
				for _, fleetShip in ipairs(friendlyDefensiveFleetList[comms_target.fleet]) do
					if fleetShip ~= nil and fleetShip:isValid() then
						msg = msg .. "\n  " .. fleetShip:getCallSign() .. ":"
						local missile_types = {'Homing', 'Nuke', 'Mine', 'EMP', 'HVLI'}
						missileMsg = ""
						for _, missile_type in ipairs(missile_types) do
							if fleetShip:getWeaponStorageMax(missile_type) > 0 then
								missileMsg = missileMsg .. "\n      " .. missile_type .. ": " .. math.floor(fleetShip:getWeaponStorage(missile_type)) .. "/" .. math.floor(fleetShip:getWeaponStorageMax(missile_type))
							end
						end
						if missileMsg ~= "" then
							msg = msg .. "\n    Missiles: " .. missileMsg
						end
					end
				end
				setCommsMessage(msg)
				addCommsReply("Back", commsShip)
			end)
			addCommsReply("Assist me", function()
				for _, fleetShip in ipairs(friendlyDefensiveFleetList[comms_target.fleet]) do
					if fleetShip ~= nil and fleetShip:isValid() then
						fleetShip:orderDefendTarget(comms_source)
					end
				end
				setCommsMessage(string.format("%s heading toward you to assist",comms_target.fleet))
				addCommsReply("Back", commsShip)
			end)
			addCommsReply("Defend a waypoint", function()
				if comms_source:getWaypointCount() == 0 then
					setCommsMessage("No waypoints set. Please set a waypoint first.");
					addCommsReply("Back", commsShip)
				else
					setCommsMessage("Which waypoint should we defend?");
					for n=1,comms_source:getWaypointCount() do
						addCommsReply("Defend WP" .. n, function()
							for _, fleetShip in ipairs(friendlyDefensiveFleetList[comms_target.fleet]) do
								if fleetShip ~= nil and fleetShip:isValid() then
									fleetShip:orderDefendLocation(comms_source:getWaypoint(n))
								end
							end
							setCommsMessage("We are heading to assist at WP" .. n ..".");
							addCommsReply("Back", commsShip)
						end)
					end
				end
			end)
			addCommsReply("Go offensive, attack all enemy targets", function()
				for _, fleetShip in ipairs(friendlyDefensiveFleetList[comms_target.fleet]) do
					if fleetShip ~= nil and fleetShip:isValid() then
						fleetShip:orderRoaming()
					end
				end
				setCommsMessage(string.format("%s is on an offensive rampage",comms_target.fleet))
				addCommsReply("Back", commsShip)
			end)
		end)
	end
	local shipType = comms_target:getTypeName()
	if shipType:find("Freighter") ~= nil then
		if distance(comms_source, comms_target) < 5000 then
			if comms_data.friendlyness > 66 then
				if shipType:find("Goods") ~= nil or shipType:find("Equipment") ~= nil then
					if comms_source.goods ~= nil and comms_source.goods.luxury ~= nil and comms_source.goods.luxury > 0 then
						for good, goodData in pairs(comms_data.goods) do
							if goodData.quantity > 0 and good ~= "luxury" then
								addCommsReply(string.format("Trade luxury for %s",good), function()
									goodData.quantity = goodData.quantity - 1
									if comms_source.goods == nil then
										comms_source.goods = {}
									end
									if comms_source.goods[good] == nil then
										comms_source.goods[good] = 0
									end
									comms_source.goods[good] = comms_source.goods[good] + 1
									comms_source.goods.luxury = comms_source.goods.luxury - 1
									setCommsMessage(string.format("Traded your luxury for %s from %s",good,comms_target:getCallSign()))
									addCommsReply("Back", commsShip)
								end)
							end
						end	--freighter goods loop
					end	--player has luxury branch
				end	--goods or equipment freighter
				if comms_source.cargo > 0 then
					for good, goodData in pairs(comms_data.goods) do
						if goodData.quantity > 0 then
							addCommsReply(string.format("Buy one %s for %i reputation",good,math.floor(goodData.cost)), function()
								if comms_source:takeReputationPoints(goodData.cost) then
									goodData.quantity = goodData.quantity - 1
									if comms_source.goods == nil then
										comms_source.goods = {}
									end
									if comms_source.goods[good] == nil then
										comms_source.goods[good] = 0
									end
									comms_source.goods[good] = comms_source.goods[good] + 1
									comms_source.cargo = comms_source.cargo - 1
									setCommsMessage(string.format("Purchased %s from %s",good,comms_target:getCallSign()))
								else
									setCommsMessage("Insufficient reputation for purchase")
								end
								addCommsReply("Back", commsShip)
							end)
						end
					end	--freighter goods loop
				end	--player has cargo space branch
			elseif comms_data.friendlyness > 33 then
				if comms_source.cargo > 0 then
					if shipType:find("Goods") ~= nil or shipType:find("Equipment") ~= nil then
						for good, goodData in pairs(comms_data.goods) do
							if goodData.quantity > 0 then
								addCommsReply(string.format("Buy one %s for %i reputation",good,math.floor(goodData.cost)), function()
									if comms_source:takeReputationPoints(goodData.cost) then
										goodData.quantity = goodData.quantity - 1
										if comms_source.goods == nil then
											comms_source.goods = {}
										end
										if comms_source.goods[good] == nil then
											comms_source.goods[good] = 0
										end
										comms_source.goods[good] = comms_source.goods[good] + 1
										comms_source.cargo = comms_source.cargo - 1
										setCommsMessage(string.format("Purchased %s from %s",good,comms_target:getCallSign()))
									else
										setCommsMessage("Insufficient reputation for purchase")
									end
									addCommsReply("Back", commsShip)
								end)
							end	--freighter has something to sell branch
						end	--freighter goods loop
					else	--not goods or equipment freighter
						for good, goodData in pairs(comms_data.goods) do
							if goodData.quantity > 0 then
								addCommsReply(string.format("Buy one %s for %i reputation",good,math.floor(goodData.cost*2)), function()
									if comms_source:takeReputationPoints(goodData.cost*2) then
										goodData.quantity = goodData.quantity - 1
										if comms_source.goods == nil then
											comms_source.goods = {}
										end
										if comms_source.goods[good] == nil then
											comms_source.goods[good] = 0
										end
										comms_source.goods[good] = comms_source.goods[good] + 1
										comms_source.cargo = comms_source.cargo - 1
										setCommsMessage(string.format("Purchased %s from %s",good,comms_target:getCallSign()))
									else
										setCommsMessage("Insufficient reputation for purchase")
									end
									addCommsReply("Back", commsShip)
								end)
							end	--freighter has something to sell branch
						end	--freighter goods loop
					end
				end	--player has room for cargo branch
			else	--least friendly
				if comms_source.cargo > 0 then
					if shipType:find("Goods") ~= nil or shipType:find("Equipment") ~= nil then
						for good, goodData in pairs(comms_data.goods) do
							if goodData.quantity > 0 then
								addCommsReply(string.format("Buy one %s for %i reputation",good,math.floor(goodData.cost*2)), function()
									if comms_source:takeReputationPoints(goodData.cost*2) then
										goodData.quantity = goodData.quantity - 1
										if comms_source.goods == nil then
											comms_source.goods = {}
										end
										if comms_source.goods[good] == nil then
											comms_source.goods[good] = 0
										end
										comms_source.goods[good] = comms_source.goods[good] + 1
										comms_source.cargo = comms_source.cargo - 1
										setCommsMessage(string.format("Purchased %s from %s",good,comms_target:getCallSign()))
									else
										setCommsMessage("Insufficient reputation for purchase")
									end
									addCommsReply("Back", commsShip)
								end)
							end	--freighter has something to sell branch
						end	--freighter goods loop
					end	--goods or equipment freighter
				end	--player has room to get goods
			end	--various friendliness choices
		else	--not close enough to sell
			addCommsReply("Do you have cargo you might sell?", function()
				local goodCount = 0
				local cargoMsg = "We've got "
				for good, goodData in pairs(comms_data.goods) do
					if goodData.quantity > 0 then
						if goodCount > 0 then
							cargoMsg = cargoMsg .. ", " .. good
						else
							cargoMsg = cargoMsg .. good
						end
					end
					goodCount = goodCount + goodData.quantity
				end
				if goodCount == 0 then
					cargoMsg = cargoMsg .. "nothing"
				end
				setCommsMessage(cargoMsg)
				addCommsReply("Back", commsShip)
			end)
		end
	end
	return true
end
function enemyComms(comms_data)
	local faction = comms_target:getFaction()
	local tauntable = false
	local amenable = false
	if comms_data.friendlyness >= 33 then	--final: 33
		--taunt logic
		local taunt_option = "We will see to your destruction!"
		local taunt_success_reply = "Your bloodline will end here!"
		local taunt_failed_reply = "Your feeble threats are meaningless."
		local taunt_threshold = 30	--base chance of being taunted
		if faction == "Kraylor" then
			taunt_threshold = 35
			setCommsMessage("Ktzzzsss.\nYou will DIEEee weaklingsss!");
			local kraylorTauntChoice = math.random(1,3)
			if kraylorTauntChoice == 1 then
				taunt_option = "We will destroy you"
				taunt_success_reply = "We think not. It is you who will experience destruction!"
			elseif kraylorTauntChoice == 2 then
				taunt_option = "You have no honor"
				taunt_success_reply = "Your insult has brought our wrath upon you. Prepare to die."
				taunt_failed_reply = "Your comments about honor have no meaning to us"
			else
				taunt_option = "We pity your pathetic race"
				taunt_success_reply = "Pathetic? You will regret your disparagement!"
				taunt_failed_reply = "We don't care what you think of us"
			end
		elseif faction == "Arlenians" then
			taunt_threshold = 25
			setCommsMessage("We wish you no harm, but will harm you if we must.\nEnd of transmission.");
		elseif faction == "Exuari" then
			taunt_threshold = 40
			setCommsMessage("Stay out of our way, or your death will amuse us extremely!");
		elseif faction == "Ghosts" then
			taunt_threshold = 20
			setCommsMessage("One zero one.\nNo binary communication detected.\nSwitching to universal speech.\nGenerating appropriate response for target from human language archives.\n:Do not cross us:\nCommunication halted.");
			taunt_option = "EXECUTE: SELFDESTRUCT"
			taunt_success_reply = "Rogue command received. Targeting source."
			taunt_failed_reply = "External command ignored."
		elseif faction == "Ktlitans" then
			setCommsMessage("The hive suffers no threats. Opposition to any of us is opposition to us all.\nStand down or prepare to donate your corpses toward our nutrition.");
			taunt_option = "<Transmit 'The Itsy-Bitsy Spider' on all wavelengths>"
			taunt_success_reply = "We do not need permission to pluck apart such an insignificant threat."
			taunt_failed_reply = "The hive has greater priorities than exterminating pests."
		elseif faction == "TSN" then
			taunt_threshold = 15
			setCommsMessage("State your business")
		elseif faction == "USN" then
			taunt_threshold = 15
			setCommsMessage("What do you want? (not that we care)")
		elseif faction == "CUF" then
			taunt_threshold = 15
			setCommsMessage("Don't waste our time")
		else
			setCommsMessage("Mind your own business!");
		end
		comms_data.friendlyness = comms_data.friendlyness - random(0, 10)	--reduce friendlyness after each interaction
		addCommsReply(taunt_option, function()
			if random(0, 100) <= taunt_threshold then	--final: 30
				local current_order = comms_target:getOrder()
				print("order: " .. current_order)
				--Possible order strings returned:
				--Roaming
				--Fly towards
				--Attack
				--Stand Ground
				--Idle
				--Defend Location
				--Defend Target
				--Fly Formation (?)
				--Fly towards (ignore all)
				--Dock
				if comms_target.original_order == nil then
					comms_target.original_faction = faction
					comms_target.original_order = current_order
					if current_order == "Fly towards" or current_order == "Defend Location" or current_order == "Fly towards (ignore all)" then
						comms_target.original_target_x, comms_target.original_target_y = comms_target:getOrderTargetLocation()
						--print(string.format("Target_x: %f, Target_y: %f",comms_target.original_target_x,comms_target.original_target_y))
					end
					if current_order == "Attack" or current_order == "Dock" or current_order == "Defend Target" then
						local original_target = comms_target:getOrderTarget()
						--print("target:")
						--print(original_target)
						--print(original_target:getCallSign())
						comms_target.original_target = original_target
					end
					comms_target.taunt_may_expire = true	--change to conditional in future refactoring
					table.insert(enemy_reverts,comms_target)
				end
				comms_target:orderAttack(comms_source)	--consider alternative options besides attack in future refactoring
				setCommsMessage(taunt_success_reply);
			else
				setCommsMessage(taunt_failed_reply);
			end
		end)
		tauntable = true
	end
	local enemy_health = getEnemyHealth(comms_target)
	if change_enemy_order_diagnostic then print(string.format("   enemy health:    %.2f",enemy_health)) end
	if change_enemy_order_diagnostic then print(string.format("   friendliness:    %.1f",comms_data.friendlyness)) end
	if comms_data.friendlyness >= 66 or enemy_health < .5 then	--final: 66, .5
		--amenable logic
		local amenable_chance = comms_data.friendlyness/3 + (1 - enemy_health)*30
		if change_enemy_order_diagnostic then print(string.format("   amenability:     %.1f",amenable_chance)) end
		addCommsReply("Stop your actions",function()
			local amenable_roll = random(0,100)
			if change_enemy_order_diagnostic then print(string.format("   amenable roll:   %.1f",amenable_roll)) end
			if amenable_roll < amenable_chance then
				local current_order = comms_target:getOrder()
				if comms_target.original_order == nil then
					comms_target.original_order = current_order
					comms_target.original_faction = faction
					if current_order == "Fly towards" or current_order == "Defend Location" or current_order == "Fly towards (ignore all)" then
						comms_target.original_target_x, comms_target.original_target_y = comms_target:getOrderTargetLocation()
						--print(string.format("Target_x: %f, Target_y: %f",comms_target.original_target_x,comms_target.original_target_y))
					end
					if current_order == "Attack" or current_order == "Dock" or current_order == "Defend Target" then
						local original_target = comms_target:getOrderTarget()
						--print("target:")
						--print(original_target)
						--print(original_target:getCallSign())
						comms_target.original_target = original_target
					end
					table.insert(enemy_reverts,comms_target)
				end
				comms_target.amenability_may_expire = true
				comms_target:orderIdle()
				comms_target:setFaction("Independent")
				setCommsMessage("Just this once, we'll take your advice")
			else
				setCommsMessage("No")
			end
		end)
		comms_data.friendlyness = comms_data.friendlyness - random(0, 10)	--reduce friendlyness after each interaction
		amenable = true
	end
	if tauntable or amenable then
		return true
	else
		return false
	end
end
function neutralComms(comms_data)
	local shipType = comms_target:getTypeName()
	if shipType:find("Freighter") ~= nil then
		setCommsMessage("Yes?")
		addCommsReply("Do you have cargo you might sell?", function()
			local goodCount = 0
			local cargoMsg = "We've got "
			for good, goodData in pairs(comms_data.goods) do
				if goodData.quantity > 0 then
					if goodCount > 0 then
						cargoMsg = cargoMsg .. ", " .. good
					else
						cargoMsg = cargoMsg .. good
					end
				end
				goodCount = goodCount + goodData.quantity
			end
			if goodCount == 0 then
				cargoMsg = cargoMsg .. "nothing"
			end
			setCommsMessage(cargoMsg)
		end)
		if distance(comms_source,comms_target) < 5000 then
			if comms_source.cargo > 0 then
				if comms_data.friendlyness > 66 then
					if shipType:find("Goods") ~= nil or shipType:find("Equipment") ~= nil then
						for good, goodData in pairs(comms_data.goods) do
							if goodData.quantity > 0 then
								addCommsReply(string.format("Buy one %s for %i reputation",good,math.floor(goodData.cost)), function()
									if comms_source:takeReputationPoints(goodData.cost) then
										goodData.quantity = goodData.quantity - 1
										if comms_source.goods == nil then
											comms_source.goods = {}
										end
										if comms_source.goods[good] == nil then
											comms_source.goods[good] = 0
										end
										comms_source.goods[good] = comms_source.goods[good] + 1
										comms_source.cargo = comms_source.cargo - 1
										setCommsMessage(string.format("Purchased %s from %s",good,comms_target:getCallSign()))
									else
										setCommsMessage("Insufficient reputation for purchase")
									end
									addCommsReply("Back", commsShip)
								end)
							end
						end	--freighter goods loop
					else
						for good, goodData in pairs(comms_data.goods) do
							if goodData.quantity > 0 then
								addCommsReply(string.format("Buy one %s for %i reputation",good,math.floor(goodData.cost*2)), function()
									if comms_source:takeReputationPoints(goodData.cost*2) then
										goodData.quantity = goodData.quantity - 1
										if comms_source.goods == nil then
											comms_source.goods = {}
										end
										if comms_source.goods[good] == nil then
											comms_source.goods[good] = 0
										end
										comms_source.goods[good] = comms_source.goods[good] + 1
										comms_source.cargo = comms_source.cargo - 1
										setCommsMessage(string.format("Purchased %s from %s",good,comms_target:getCallSign()))
									else
										setCommsMessage("Insufficient reputation for purchase")
									end
									addCommsReply("Back", commsShip)
								end)
							end
						end	--freighter goods loop
					end
				elseif comms_data.friendlyness > 33 then
					if shipType:find("Goods") ~= nil or shipType:find("Equipment") ~= nil then
						for good, goodData in pairs(comms_data.goods) do
							if goodData.quantity > 0 then
								addCommsReply(string.format("Buy one %s for %i reputation",good,math.floor(goodData.cost*2)), function()
									if comms_source:takeReputationPoints(goodData.cost*2) then
										goodData.quantity = goodData.quantity - 1
										if comms_source.goods == nil then
											comms_source.goods = {}
										end
										if comms_source.goods[good] == nil then
											comms_source.goods[good] = 0
										end
										comms_source.goods[good] = comms_source.goods[good] + 1
										comms_source.cargo = comms_source.cargo - 1
										setCommsMessage(string.format("Purchased %s from %s",good,comms_target:getCallSign()))
									else
										setCommsMessage("Insufficient reputation for purchase")
									end
									addCommsReply("Back", commsShip)
								end)
							end
						end	--freighter goods loop
					else
						for good, goodData in pairs(comms_data.goods) do
							if goodData.quantity > 0 then
								addCommsReply(string.format("Buy one %s for %i reputation",good,math.floor(goodData.cost*3)), function()
									if comms_source:takeReputationPoints(goodData.cost*3) then
										goodData.quantity = goodData.quantity - 1
										if comms_source.goods == nil then
											comms_source.goods = {}
										end
										if comms_source.goods[good] == nil then
											comms_source.goods[good] = 0
										end
										comms_source.goods[good] = comms_source.goods[good] + 1
										comms_source.cargo = comms_source.cargo - 1
										setCommsMessage(string.format("Purchased %s from %s",good,comms_target:getCallSign()))
									else
										setCommsMessage("Insufficient reputation for purchase")
									end
									addCommsReply("Back", commsShip)
								end)
							end
						end	--freighter goods loop
					end
				else	--least friendly
					if shipType:find("Goods") ~= nil or shipType:find("Equipment") ~= nil then
						for good, goodData in pairs(comms_data.goods) do
							if goodData.quantity > 0 then
								addCommsReply(string.format("Buy one %s for %i reputation",good,math.floor(goodData.cost*3)), function()
									if comms_source:takeReputationPoints(goodData.cost*3) then
										goodData.quantity = goodData.quantity - 1
										if comms_source.goods == nil then
											comms_source.goods = {}
										end
										if comms_source.goods[good] == nil then
											comms_source.goods[good] = 0
										end
										comms_source.goods[good] = comms_source.goods[good] + 1
										comms_source.cargo = comms_source.cargo - 1
										setCommsMessage(string.format("Purchased %s from %s",good,comms_target:getCallSign()))
									else
										setCommsMessage("Insufficient reputation for purchase")
									end
									addCommsReply("Back", commsShip)
								end)
							end
						end	--freighter goods loop
					end
				end	--end friendly branches
			end	--player has room for cargo
		end	--close enough to sell
	else	--not a freighter
		if comms_data.friendlyness > 50 then
			setCommsMessage("Sorry, we have no time to chat with you.\nWe are on an important mission.");
		else
			setCommsMessage("We have nothing for you.\nGood day.");
		end
	end	--end non-freighter communications else branch
	return true
end	--end neutral communications function
function getEnemyHealth(enemy)
	local enemy_health = 0
	local enemy_shield = 0
	local enemy_shield_count = enemy:getShieldCount()
	local faction = enemy:getFaction()
	if change_enemy_order_diagnostic then print(string.format("%s statistics:",enemy:getCallSign())) end
	if change_enemy_order_diagnostic then print(string.format("   shield count:    %i",enemy_shield_count)) end
	if enemy_shield_count > 0 then
		local total_shield_level = 0
		local max_shield_level = 0
		for i=1,enemy_shield_count do
			total_shield_level = total_shield_level + enemy:getShieldLevel(i-1)
			max_shield_level = max_shield_level + enemy:getShieldMax(i-1)
		end
		enemy_shield = total_shield_level/max_shield_level
	else
		enemy_shield = 1
	end
	if change_enemy_order_diagnostic then print(string.format("   shield health:   %.1f",enemy_shield)) end
	local enemy_hull = enemy:getHull()/enemy:getHullMax()
	if change_enemy_order_diagnostic then print(string.format("   hull health:     %.1f",enemy_hull)) end
	local enemy_reactor = enemy:getSystemHealth("reactor")
	if change_enemy_order_diagnostic then print(string.format("   reactor health:  %.1f",enemy_reactor)) end
	local enemy_maneuver = enemy:getSystemHealth("maneuver")
	if change_enemy_order_diagnostic then print(string.format("   maneuver health: %.1f",enemy_maneuver)) end
	local enemy_impulse = enemy:getSystemHealth("impulse")
	if change_enemy_order_diagnostic then print(string.format("   impulse health:  %.1f",enemy_impulse)) end
	local enemy_beam = 0
	if enemy:getBeamWeaponRange(0) > 0 then
		enemy_beam = enemy:getSystemHealth("beamweapons")
		if change_enemy_order_diagnostic then print(string.format("   beam health:     %.1f",enemy_beam)) end
	else
		enemy_beam = 1
		if change_enemy_order_diagnostic then print(string.format("   beam health:     %.1f (no beams)",enemy_beam)) end
	end
	local enemy_missile = 0
	if enemy:getWeaponTubeCount() > 0 then
		enemy_missile = enemy:getSystemHealth("missilesystem")
		if change_enemy_order_diagnostic then print(string.format("   missile health:  %.1f",enemy_missile)) end
	else
		enemy_missile = 1
		if change_enemy_order_diagnostic then print(string.format("   missile health:  %.1f (no missile system)",enemy_missile)) end
	end
	local enemy_warp = 0
	if enemy:hasWarpDrive() then
		enemy_warp = enemy:getSystemHealth("warp")
		if change_enemy_order_diagnostic then print(string.format("   warp health:     %.1f",enemy_warp)) end
	else
		enemy_warp = 1
		if change_enemy_order_diagnostic then print(string.format("   warp health:     %.1f (no warp drive)",enemy_warp)) end
	end
	local enemy_jump = 0
	if enemy:hasJumpDrive() then
		enemy_jump = enemy:getSystemHealth("jumpdrive")
		if change_enemy_order_diagnostic then print(string.format("   jump health:     %.1f",enemy_jump)) end
	else
		enemy_jump = 1
		if change_enemy_order_diagnostic then print(string.format("   jump health:     %.1f (no jump drive)",enemy_jump)) end
	end
	if change_enemy_order_diagnostic then print(string.format("   faction:         %s",faction)) end
	if faction == "Kraylor" then
		enemy_health = 
			enemy_shield 	* .3	+
			enemy_hull		* .4	+
			enemy_reactor	* .1 	+
			enemy_maneuver	* .03	+
			enemy_impulse	* .03	+
			enemy_beam		* .04	+
			enemy_missile	* .04	+
			enemy_warp		* .03	+
			enemy_jump		* .03
	elseif faction == "Arlenians" then
		enemy_health = 
			enemy_shield 	* .35	+
			enemy_hull		* .45	+
			enemy_reactor	* .05 	+
			enemy_maneuver	* .03	+
			enemy_impulse	* .04	+
			enemy_beam		* .02	+
			enemy_missile	* .02	+
			enemy_warp		* .02	+
			enemy_jump		* .02	
	elseif faction == "Exuari" then
		enemy_health = 
			enemy_shield 	* .2	+
			enemy_hull		* .3	+
			enemy_reactor	* .2 	+
			enemy_maneuver	* .05	+
			enemy_impulse	* .05	+
			enemy_beam		* .05	+
			enemy_missile	* .05	+
			enemy_warp		* .05	+
			enemy_jump		* .05	
	elseif faction == "Ghosts" then
		enemy_health = 
			enemy_shield 	* .25	+
			enemy_hull		* .25	+
			enemy_reactor	* .25 	+
			enemy_maneuver	* .04	+
			enemy_impulse	* .05	+
			enemy_beam		* .04	+
			enemy_missile	* .04	+
			enemy_warp		* .04	+
			enemy_jump		* .04	
	elseif faction == "Ktlitans" then
		enemy_health = 
			enemy_shield 	* .2	+
			enemy_hull		* .3	+
			enemy_reactor	* .1 	+
			enemy_maneuver	* .05	+
			enemy_impulse	* .05	+
			enemy_beam		* .05	+
			enemy_missile	* .05	+
			enemy_warp		* .1	+
			enemy_jump		* .1	
	elseif faction == "TSN" then
		enemy_health = 
			enemy_shield 	* .35	+
			enemy_hull		* .35	+
			enemy_reactor	* .08 	+
			enemy_maneuver	* .01	+
			enemy_impulse	* .02	+
			enemy_beam		* .02	+
			enemy_missile	* .01	+
			enemy_warp		* .08	+
			enemy_jump		* .08	
	elseif faction == "USN" then
		enemy_health = 
			enemy_shield 	* .38	+
			enemy_hull		* .38	+
			enemy_reactor	* .05 	+
			enemy_maneuver	* .02	+
			enemy_impulse	* .03	+
			enemy_beam		* .02	+
			enemy_missile	* .02	+
			enemy_warp		* .05	+
			enemy_jump		* .05	
	elseif faction == "CUF" then
		enemy_health = 
			enemy_shield 	* .35	+
			enemy_hull		* .38	+
			enemy_reactor	* .05 	+
			enemy_maneuver	* .03	+
			enemy_impulse	* .03	+
			enemy_beam		* .03	+
			enemy_missile	* .03	+
			enemy_warp		* .06	+
			enemy_jump		* .04	
	else
		enemy_health = 
			enemy_shield 	* .3	+
			enemy_hull		* .4	+
			enemy_reactor	* .06 	+
			enemy_maneuver	* .03	+
			enemy_impulse	* .05	+
			enemy_beam		* .03	+
			enemy_missile	* .03	+
			enemy_warp		* .05	+
			enemy_jump		* .05	
	end
	return enemy_health
end
function revertWait(delta)
	revert_timer = revert_timer - delta
	if revert_timer < 0 then
		revert_timer = delta + revert_timer_interval
		plotRevert = revertCheck
	end
end
function revertCheck(delta)
	if enemy_reverts ~= nil then
		for _, enemy in ipairs(enemy_reverts) do
			if enemy ~= nil and enemy:isValid() then
				local expiration_chance = 0
				local enemy_faction = enemy:getFaction()
				if enemy.taunt_may_expire then
					if enemy_faction == "Kraylor" then
						expiration_chance = 4.5
					elseif enemy_faction == "Arlenians" then
						expiration_chance = 7
					elseif enemy_faction == "Exuari" then
						expiration_chance = 2.5
					elseif enemy_faction == "Ghosts" then
						expiration_chance = 8.5
					elseif enemy_faction == "Ktlitans" then
						expiration_chance = 5.5
					elseif enemy_faction == "TSN" then
						expiration_chance = 3
					elseif enemy_faction == "USN" then
						expiration_chance = 3.5
					elseif enemy_faction == "CUF" then
						expiration_chance = 4
					else
						expiration_chance = 6
					end
				elseif enemy.amenability_may_expire then
					local enemy_health = getEnemyHealth(enemy)
					if enemy_faction == "Kraylor" then
						expiration_chance = 2.5
					elseif enemy_faction == "Arlenians" then
						expiration_chance = 3.25
					elseif enemy_faction == "Exuari" then
						expiration_chance = 6.6
					elseif enemy_faction == "Ghosts" then
						expiration_chance = 3.2
					elseif enemy_faction == "Ktlitans" then
						expiration_chance = 4.8
					elseif enemy_faction == "TSN" then
						expiration_chance = 3.5
					elseif enemy_faction == "USN" then
						expiration_chance = 2.8
					elseif enemy_faction == "CUF" then
						expiration_chance = 3
					else
						expiration_chance = 4
					end
					expiration_chance = expiration_chance + enemy_health*5
				end
				local expiration_roll = random(1,100)
				if expiration_roll < expiration_chance then
					local oo = enemy.original_order
					local otx = enemy.original_target_x
					local oty = enemy.original_target_y
					local ot = enemy.original_target
					if oo ~= nil then
						if oo == "Attack" then
							if ot ~= nil and ot:isValid() then
								enemy:orderAttack(ot)
							else
								enemy:orderRoaming()
							end
						elseif oo == "Dock" then
							if ot ~= nil and ot:isValid() then
								enemy:orderDock(ot)
							else
								enemy:orderRoaming()
							end
						elseif oo == "Defend Target" then
							if ot ~= nil and ot:isValid() then
								enemy:orderDefendTarget(ot)
							else
								enemy:orderRoaming()
							end
						elseif oo == "Fly towards" then
							if otx ~= nil and oty ~= nil then
								enemy:orderFlyTowards(otx,oty)
							else
								enemy:orderRoaming()
							end
						elseif oo == "Defend Location" then
							if otx ~= nil and oty ~= nil then
								enemy:orderDefendLocation(otx,oty)
							else
								enemy:orderRoaming()
							end
						elseif oo == "Fly towards (ignore all)" then
							if otx ~= nil and oty ~= nil then
								enemy:orderFlyTowardsBlind(otx,oty)
							else
								enemy:orderRoaming()
							end
						else
							enemy:orderRoaming()
						end
					else
						enemy:orderRoaming()
					end
					if enemy.original_faction ~= nil then
						enemy:setFaction(enemy.original_faction)
					end
					enemy.taunt_may_expire = false
					enemy.amenability_may_expire = false
				end
			end
		end
	end
	plotRevert = revertWait
end
-----------------------------
--	Station communication  --
-----------------------------
function commsStation()
    if comms_target.comms_data == nil then
        comms_target.comms_data = {}
    end
    mergeTables(comms_target.comms_data, {
        friendlyness = random(0.0, 100.0),
        weapons = {
            Homing = "neutral",
            HVLI = "neutral",
            Mine = "neutral",
            Nuke = "friend",
            EMP = "friend"
        },
        weapon_cost = {
            Homing = math.random(1,4),
            HVLI = math.random(1,3),
            Mine = math.random(2,5),
            Nuke = math.random(12,18),
            EMP = math.random(7,13)
        },
        services = {
            supplydrop = "friend",
            reinforcements = "friend",
            sensor_boost = "neutral",
			preorder = "friend"
        },
        service_cost = {
            supplydrop = math.random(80,120),
            reinforcements = math.random(125,175)
        },
        reputation_cost_multipliers = {
            friend = 1.0,
            neutral = 3.0
        },
        max_weapon_refill_amount = {
            friend = 1.0,
            neutral = 0.5
        }
    })
    comms_data = comms_target.comms_data
    if comms_source:isEnemy(comms_target) then
        return false
    end
    if comms_target:areEnemiesInRange(5000) then
        setCommsMessage("We are under attack! No time for chatting!");
        return true
    end
    if not comms_source:isDocked(comms_target) then
        handleUndockedState()
    else
        handleDockedState()
    end
    return true
end
function handleDockedState()
	local ctd = comms_target.comms_data
    if comms_source:isFriendly(comms_target) then
		oMsg = "Good day, officer!\nWhat can we do for you today?\n"
    else
		oMsg = "Welcome to our lovely station.\n"
    end
    if comms_target:areEnemiesInRange(20000) then
		oMsg = oMsg .. "Forgive us if we seem a little distracted. We are carefully monitoring the enemies nearby."
	end
	setCommsMessage(oMsg)
	local gm_verb = gm_verbs[math.random(1,#gm_verbs)]
	local gm_name = gm_names[math.random(1,#gm_names)]
	addCommsReply(string.format("%s %s",gm_verb,gm_name),function()
		commsSwitchToGM()
		addCommsReply("Back", commsStation)
	end)
	local missilePresence = 0
	local missile_types = {'Homing', 'Nuke', 'Mine', 'EMP', 'HVLI'}
	for _, missile_type in ipairs(missile_types) do
		missilePresence = missilePresence + comms_source:getWeaponStorageMax(missile_type)
	end
	if missilePresence > 0 then
		if 	(ctd.weapon_available.Nuke   and comms_source:getWeaponStorageMax("Nuke") > 0)   or 
			(ctd.weapon_available.EMP    and comms_source:getWeaponStorageMax("EMP") > 0)    or 
			(ctd.weapon_available.Homing and comms_source:getWeaponStorageMax("Homing") > 0) or 
			(ctd.weapon_available.Mine   and comms_source:getWeaponStorageMax("Mine") > 0)   or 
			(ctd.weapon_available.HVLI   and comms_source:getWeaponStorageMax("HVLI") > 0)   then
			addCommsReply("I need ordnance restocked", function()
				setCommsMessage("What type of ordnance?")
				if comms_source:getWeaponStorageMax("Nuke") > 0 then
					if ctd.weapon_available.Nuke then
						if math.random(1,10) <= 5 then
							nukePrompt = "Can you supply us with some nukes? ("
						else
							nukePrompt = "We really need some nukes ("
						end
						addCommsReply(nukePrompt .. getWeaponCost("Nuke") .. " rep each)", function()
							handleWeaponRestock("Nuke")
						end)
					end	--end station has nuke available if branch
				end	--end player can accept nuke if branch
				if comms_source:getWeaponStorageMax("EMP") > 0 then
					if ctd.weapon_available.EMP then
						if math.random(1,10) <= 5 then
							empPrompt = "Please re-stock our EMP missiles. ("
						else
							empPrompt = "Got any EMPs? ("
						end
						addCommsReply(empPrompt .. getWeaponCost("EMP") .. " rep each)", function()
							handleWeaponRestock("EMP")
						end)
					end	--end station has EMP available if branch
				end	--end player can accept EMP if branch
				if comms_source:getWeaponStorageMax("Homing") > 0 then
					if ctd.weapon_available.Homing then
						if math.random(1,10) <= 5 then
							homePrompt = "Do you have spare homing missiles for us? ("
						else
							homePrompt = "Do you have extra homing missiles? ("
						end
						addCommsReply(homePrompt .. getWeaponCost("Homing") .. " rep each)", function()
							handleWeaponRestock("Homing")
						end)
					end	--end station has homing for player if branch
				end	--end player can accept homing if branch
				if comms_source:getWeaponStorageMax("Mine") > 0 then
					if ctd.weapon_available.Mine then
						if math.random(1,10) <= 5 then
							minePrompt = "We could use some mines. ("
						else
							minePrompt = "How about mines? ("
						end
						addCommsReply(minePrompt .. getWeaponCost("Mine") .. " rep each)", function()
							handleWeaponRestock("Mine")
						end)
					end	--end station has mine for player if branch
				end	--end player can accept mine if branch
				if comms_source:getWeaponStorageMax("HVLI") > 0 then
					if ctd.weapon_available.HVLI then
						if math.random(1,10) <= 5 then
							hvliPrompt = "What about HVLI? ("
						else
							hvliPrompt = "Could you provide HVLI? ("
						end
						addCommsReply(hvliPrompt .. getWeaponCost("HVLI") .. " rep each)", function()
							handleWeaponRestock("HVLI")
						end)
					end	--end station has HVLI for player if branch
				end	--end player can accept HVLI if branch
			end)	--end player requests secondary ordnance comms reply branch
		end	--end secondary ordnance available from station if branch
	end	--end missles used on player ship if branch
	addCommsReply("Docking services status", function()
		local service_status = string.format("Station %s docking services status:",comms_target:getCallSign())
		if comms_target:getRestocksScanProbes() then
			service_status = string.format("%s\nReplenish scan probes.",service_status)
		else
			if comms_target.probe_fail_reason == nil then
				local reason_list = {
					"Cannot replenish scan probes due to fabrication unit failure.",
					"Parts shortage prevents scan probe replenishment.",
					"Station management has curtailed scan probe replenishment for cost cutting reasons.",
				}
				comms_target.probe_fail_reason = reason_list[math.random(1,#reason_list)]
			end
			service_status = string.format("%s\n%s",service_status,comms_target.probe_fail_reason)
		end
		if comms_target:getRepairDocked() then
			service_status = string.format("%s\nShip hull repair.",service_status)
		else
			if comms_target.repair_fail_reason == nil then
				reason_list = {
					"We're out of the necessary materials and supplies for hull repair.",
					"Hull repair automation unavailable while it is undergoing maintenance.",
					"All hull repair technicians quarantined to quarters due to illness.",
				}
				comms_target.repair_fail_reason = reason_list[math.random(1,#reason_list)]
			end
			service_status = string.format("%s\n%s",service_status,comms_target.repair_fail_reason)
		end
		if comms_target:getSharesEnergyWithDocked() then
			service_status = string.format("%s\nRecharge ship energy stores.",service_status)
		else
			if comms_target.energy_fail_reason == nil then
				reason_list = {
					"A recent reactor failure has put us on auxiliary power, so we cannot recharge ships.",
					"A damaged power coupling makes it too dangerous to recharge ships.",
					"An asteroid strike damaged our solar cells and we are short on power, so we can't recharge ships right now.",
				}
				comms_target.energy_fail_reason = reason_list[math.random(1,#reason_list)]
			end
			service_status = string.format("%s\n%s",service_status,comms_target.energy_fail_reason)
		end
		if ctd.jump_overcharge then
			service_status = string.format("%s\nMay overcharge jump drive",service_status)
		end
		setCommsMessage(service_status)
		addCommsReply("Back", commsStation)
	end)
	if ctd.sensor_boost ~= nil then
		if ctd.sensor_boost.cost > 0 then
			addCommsReply(string.format("Augment scan range with station sensors while docked (%i rep)",ctd.sensor_boost.cost),function()
				if comms_source:takeReputationPoints(ctd.sensor_boost.cost) then
					if comms_source.normal_long_range_radar == nil then
						comms_source.normal_long_range_radar = comms_source:getLongRangeRadarRange()
					end
					comms_source:setLongRangeRadarRange(comms_source.normal_long_range_radar + ctd.sensor_boost.value)
					setCommsMessage(string.format("sensors increased by %i units",ctd.sensor_boost.value/1000))
				else
					setCommsMessage("Insufficient reputation")
				end
				addCommsReply("Back", commsStation)
			end)
		end
	end
	if ctd.jump_overcharge then
		if comms_source:hasJumpDrive() then
			local max_charge = comms_source.max_jump_range
			if max_charge == nil then
				max_charge = 50000
			end
			if comms_source:getJumpDriveCharge() >= max_charge then
				addCommsReply("Overcharge Jump Drive (10 Rep)",function()
					if comms_source:takeReputationPoints(10) then
						comms_source:setJumpDriveCharge(comms_source:getJumpDriveCharge() + max_charge)
						setCommsMessage(string.format("Your jump drive has been overcharged to %ik",math.floor(comms_source:getJumpDriveCharge()/1000)))
					else
						setCommsMessage("Insufficient reputation")
					end
					addCommsReply("Back", commsStation)
				end)
			end
		end
	end
	if ctd.public_relations then
		addCommsReply("Tell me more about your station", function()
			setCommsMessage("What would you like to know?")
			addCommsReply("General information", function()
				setCommsMessage(ctd.general_information)
				addCommsReply("Back", commsStation)
			end)
			if ctd.history ~= nil then
				addCommsReply("Station history", function()
					setCommsMessage(ctd.history)
					addCommsReply("Back", commsStation)
				end)
			end
			if comms_source:isFriendly(comms_target) then
				if ctd.gossip ~= nil then
					if random(1,100) < 70 then
						addCommsReply("Gossip", function()
							setCommsMessage(ctd.gossip)
							addCommsReply("Back", commsStation)
						end)
					end
				end
			end
		end)	--end station info comms reply branch
	end	--end public relations if branch
	if ctd.character ~= nil then
		addCommsReply(string.format("Tell me about %s",ctd.character), function()
			if ctd.characterDescription ~= nil then
				setCommsMessage(ctd.characterDescription)
			else
				if ctd.characterDeadEnd == nil then
					local deadEndChoice = math.random(1,5)
					if deadEndChoice == 1 then
						ctd.characterDeadEnd = "Never heard of " .. ctd.character
					elseif deadEndChoice == 2 then
						ctd.characterDeadEnd = ctd.character .. " died last week. The funeral was yesterday"
					elseif deadEndChoice == 3 then
						ctd.characterDeadEnd = string.format("%s? Who's %s? There's nobody here named %s",ctd.character,ctd.character,ctd.character)
					elseif deadEndChoice == 4 then
						ctd.characterDeadEnd = string.format("We don't talk about %s. They are gone and good riddance",ctd.character)
					else
						ctd.characterDeadEnd = string.format("I think %s moved away",ctd.character)
					end
				end
				setCommsMessage(ctd.characterDeadEnd)
			end
			addCommsReply("Back", commsStation)
		end)
	end
	if comms_source:isFriendly(comms_target) then
		if comms_source.pods ~= comms_source.max_pods then
			addCommsReply("Unload retrieved escape pods",function()
				comms_source.pods = comms_source.max_pods
				if comms_source.pods > 1 then
					setCommsMessage(string.format("Escape pods unloaded and placed in the care of station %s. %s may now retrieve up to %i escape pods",comms_target:getCallSign(),comms_source:getCallSign(),comms_source.pods))
				else
					setCommsMessage(string.format("Escape pod unloaded and placed in the care of station %s. %s may now retrieve one escape pod",comms_target:getCallSign(),comms_source:getCallSign()))
				end
			end)
		end
		if random(1,100) <= 20 then
			if comms_source:getRepairCrewCount() < comms_source.maxRepairCrew then
				hireCost = math.random(30,60)
			else
				hireCost = math.random(45,90)
			end
			addCommsReply(string.format("Recruit repair crew member for %i reputation",hireCost), function()
				if not comms_source:takeReputationPoints(hireCost) then
					setCommsMessage("Insufficient reputation")
				else
					comms_source:setRepairCrewCount(comms_source:getRepairCrewCount() + 1)
					resetPreviousSystemHealth(comms_source)
					setCommsMessage("Repair crew member hired")
				end
				addCommsReply("Back", commsStation)
			end)
		end
		if comms_source.initialCoolant ~= nil then
			if math.random(1,100) <= 20 then
				local coolantCost = math.random(45,90)
				if comms_source:getMaxCoolant() < comms_source.initialCoolant then
					coolantCost = math.random(30,60)
				end
				addCommsReply(string.format("Purchase coolant for %i reputation",coolantCost), function()
					if not comms_source:takeReputationPoints(coolantCost) then
						setCommsMessage("Insufficient reputation")
					else
						comms_source:setMaxCoolant(comms_source:getMaxCoolant() + 2)
						setCommsMessage("Additional coolant purchased")
					end
					addCommsReply("Back", commsStation)
				end)
			end
		end
	else
		if random(1,100) <= 20 then
			if comms_source:getRepairCrewCount() < comms_source.maxRepairCrew then
				hireCost = math.random(45,90)
			else
				hireCost = math.random(60,120)
			end
			addCommsReply(string.format("Recruit repair crew member for %i reputation",hireCost), function()
				if not comms_source:takeReputationPoints(hireCost) then
					setCommsMessage("Insufficient reputation")
				else
					comms_source:setRepairCrewCount(comms_source:getRepairCrewCount() + 1)
					resetPreviousSystemHealth(comms_source)
					setCommsMessage("Repair crew member hired")
				end
				addCommsReply("Back", commsStation)
			end)
		end
		if comms_source.initialCoolant ~= nil then
			if math.random(1,100) <= 20 then
				local coolantCost = math.random(60,120)
				if comms_source:getMaxCoolant() < comms_source.initialCoolant then
					coolantCost = math.random(45,90)
				end
				addCommsReply(string.format("Purchase coolant for %i reputation",coolantCost), function()
					if not comms_source:takeReputationPoints(coolantCost) then
						setCommsMessage("Insufficient reputation")
					else
						comms_source:setMaxCoolant(comms_source:getMaxCoolant() + 2)
						setCommsMessage("Additional coolant purchased")
					end
					addCommsReply("Back", commsStation)
				end)
			end
		end
	end
	local goodCount = 0
	for good, goodData in pairs(ctd.goods) do
		goodCount = goodCount + 1
	end
	if goodCount > 0 then
		addCommsReply("Buy, sell, trade", function()
			local ctd = comms_target.comms_data
			local goodsReport = string.format("Station %s:\nGoods or components available for sale: quantity, cost in reputation\n",comms_target:getCallSign())
			for good, goodData in pairs(ctd.goods) do
				goodsReport = goodsReport .. string.format("     %s: %i, %i\n",good,goodData["quantity"],goodData["cost"])
			end
			if ctd.buy ~= nil then
				goodsReport = goodsReport .. "Goods or components station will buy: price in reputation\n"
				for good, price in pairs(ctd.buy) do
					goodsReport = goodsReport .. string.format("     %s: %i\n",good,price)
				end
			end
			goodsReport = goodsReport .. string.format("Current cargo aboard %s:\n",comms_source:getCallSign())
			local cargoHoldEmpty = true
			local goodCount = 0
			if comms_source.goods ~= nil then
				for good, goodQuantity in pairs(comms_source.goods) do
					goodCount = goodCount + 1
					goodsReport = goodsReport .. string.format("     %s: %i\n",good,goodQuantity)
				end
			end
			if goodCount < 1 then
				goodsReport = goodsReport .. "     Empty\n"
			end
			goodsReport = goodsReport .. string.format("Available Space: %i, Available Reputation: %i\n",comms_source.cargo,math.floor(comms_source:getReputationPoints()))
			setCommsMessage(goodsReport)
			for good, goodData in pairs(ctd.goods) do
				addCommsReply(string.format("Buy one %s for %i reputation",good,goodData["cost"]), function()
					local goodTransactionMessage = string.format("Type: %s, Quantity: %i, Rep: %i",good,goodData["quantity"],goodData["cost"])
					if comms_source.cargo < 1 then
						goodTransactionMessage = goodTransactionMessage .. "\nInsufficient cargo space for purchase"
					elseif goodData["cost"] > math.floor(comms_source:getReputationPoints()) then
						goodTransactionMessage = goodTransactionMessage .. "\nInsufficient reputation for purchase"
					elseif goodData["quantity"] < 1 then
						goodTransactionMessage = goodTransactionMessage .. "\nInsufficient station inventory"
					else
						if comms_source:takeReputationPoints(goodData["cost"]) then
							comms_source.cargo = comms_source.cargo - 1
							goodData["quantity"] = goodData["quantity"] - 1
							if comms_source.goods == nil then
								comms_source.goods = {}
							end
							if comms_source.goods[good] == nil then
								comms_source.goods[good] = 0
							end
							comms_source.goods[good] = comms_source.goods[good] + 1
							goodTransactionMessage = goodTransactionMessage .. "\npurchased"
						else
							goodTransactionMessage = goodTransactionMessage .. "\nInsufficient reputation for purchase"
						end
					end
					setCommsMessage(goodTransactionMessage)
					addCommsReply("Back", commsStation)
				end)
			end
			if ctd.buy ~= nil then
				for good, price in pairs(ctd.buy) do
					if comms_source.goods[good] ~= nil and comms_source.goods[good] > 0 then
						addCommsReply(string.format("Sell one %s for %i reputation",good,price), function()
							local goodTransactionMessage = string.format("Type: %s,  Reputation price: %i",good,price)
							comms_source.goods[good] = comms_source.goods[good] - 1
							comms_source:addReputationPoints(price)
							goodTransactionMessage = goodTransactionMessage .. "\nOne sold"
							comms_source.cargo = comms_source.cargo + 1
							setCommsMessage(goodTransactionMessage)
							addCommsReply("Back", commsStation)
						end)
					end
				end
			end
			if ctd.trade.food and comms_source.goods["food"] > 0 then
				for good, goodData in pairs(ctd.goods) do
					addCommsReply(string.format("Trade food for %s",good), function()
						local goodTransactionMessage = string.format("Type: %s,  Quantity: %i",good,goodData["quantity"])
						if goodData["quantity"] < 1 then
							goodTransactionMessage = goodTransactionMessage .. "\nInsufficient station inventory"
						else
							goodData["quantity"] = goodData["quantity"] - 1
							if comms_source.goods == nil then
								comms_source.goods = {}
							end
							if comms_source.goods[good] == nil then
								comms_source.goods[good] = 0
							end
							comms_source.goods[good] = comms_source.goods[good] + 1
							comms_source.goods["food"] = comms_source.goods["food"] - 1
							goodTransactionMessage = goodTransactionMessage .. "\nTraded"
						end
						setCommsMessage(goodTransactionMessage)
						addCommsReply("Back", commsStation)
					end)
				end
			end
			if ctd.trade.medicine and comms_source.goods["medicine"] > 0 then
				for good, goodData in pairs(ctd.goods) do
					addCommsReply(string.format("Trade medicine for %s",good), function()
						local goodTransactionMessage = string.format("Type: %s,  Quantity: %i",good,goodData["quantity"])
						if goodData["quantity"] < 1 then
							goodTransactionMessage = goodTransactionMessage .. "\nInsufficient station inventory"
						else
							goodData["quantity"] = goodData["quantity"] - 1
							if comms_source.goods == nil then
								comms_source.goods = {}
							end
							if comms_source.goods[good] == nil then
								comms_source.goods[good] = 0
							end
							comms_source.goods[good] = comms_source.goods[good] + 1
							comms_source.goods["medicine"] = comms_source.goods["medicine"] - 1
							goodTransactionMessage = goodTransactionMessage .. "\nTraded"
						end
						setCommsMessage(goodTransactionMessage)
						addCommsReply("Back", commsStation)
					end)
				end
			end
			if ctd.trade.luxury and comms_source.goods["luxury"] > 0 then
				for good, goodData in pairs(ctd.goods) do
					addCommsReply(string.format("Trade luxury for %s",good), function()
						local goodTransactionMessage = string.format("Type: %s,  Quantity: %i",good,goodData["quantity"])
						if goodData[quantity] < 1 then
							goodTransactionMessage = goodTransactionMessage .. "\nInsufficient station inventory"
						else
							goodData["quantity"] = goodData["quantity"] - 1
							if comms_source.goods == nil then
								comms_source.goods = {}
							end
							if comms_source.goods[good] == nil then
								comms_source.goods[good] = 0
							end
							comms_source.goods[good] = comms_source.goods[good] + 1
							comms_source.goods["luxury"] = comms_source.goods["luxury"] - 1
							goodTransactionMessage = goodTransactionMessage .. "\nTraded"
						end
						setCommsMessage(goodTransactionMessage)
						addCommsReply("Back", commsStation)
					end)
				end
			end
			addCommsReply("Back", commsStation)
		end)
	end
	if jump_corridor then
		if comms_target == stationIcarus or comms_target == stationKentar then
			local all_docked = true
			for pidx=1,8 do
				local p = getPlayerShip(pidx)
				if p ~= nil and p:isValid() then
					if not p:isDocked(comms_target) then
						all_docked = false
						break
					end
				end
			end
			if all_docked then
				if comms_target == stationIcarus then
					addCommsReply("Take jump corridor to Kentar",function()
						playerSpawnX = 250000
						playerSpawnY = 250000
						for pidx=1,8 do
							local p = getPlayerShip(pidx)
							if p ~= nil and p:isValid() then
								p:commandUndock()
								p:setPosition(playerSpawnX,playerSpawnY)
							end
						end
						startRegion = "Kentar (R17)"
						if not kentar_color then
							createKentarColor()
						end
						removeIcarusColor()
						setCommsMessage("Transferred to Kentar")
					end)
				elseif comms_target == stationKentar then
					addCommsReply("Take jump corridor to Icarus", function()
						playerSpawnX = 0
						playerSpawnY = 0
						for pidx=1,8 do
							local p = getPlayerShip(pidx)
							if p ~= nil and p:isValid() then
								p:commandUndock()
								p:setPosition(playerSpawnX,playerSpawnY)
							end
						end
						startRegion = "Icarus (F5)"
						if not icarus_color then
							createIcarusColor()
						end
						removeKentarColor()
						setCommsMessage("Transferred to Icarus")
					end)
				end
			end
		end
	end
end	--end of handleDockedState function
function isAllowedTo(state)
    if state == "friend" and comms_source:isFriendly(comms_target) then
        return true
    end
    if state == "neutral" and not comms_source:isEnemy(comms_target) then
        return true
    end
    return false
end
function handleWeaponRestock(weapon)
    if not comms_source:isDocked(comms_target) then 
		setCommsMessage("You need to stay docked for that action.")
		return
	end
    if not isAllowedTo(comms_data.weapons[weapon]) then
        if weapon == "Nuke" then setCommsMessage("We do not deal in weapons of mass destruction.")
        elseif weapon == "EMP" then setCommsMessage("We do not deal in weapons of mass disruption.")
        else setCommsMessage("We do not deal in those weapons.") end
        return
    end
    local points_per_item = getWeaponCost(weapon)
    local item_amount = math.floor(comms_source:getWeaponStorageMax(weapon) * comms_data.max_weapon_refill_amount[getFriendStatus()]) - comms_source:getWeaponStorage(weapon)
    if item_amount <= 0 then
        if weapon == "Nuke" then
            setCommsMessage("All nukes are charged and primed for destruction.");
        else
            setCommsMessage("Sorry, sir, but you are as fully stocked as I can allow.");
        end
        addCommsReply("Back", commsStation)
    else
		if comms_source:getReputationPoints() > points_per_item * item_amount then
			if comms_source:takeReputationPoints(points_per_item * item_amount) then
				comms_source:setWeaponStorage(weapon, comms_source:getWeaponStorage(weapon) + item_amount)
				if comms_source:getWeaponStorage(weapon) == comms_source:getWeaponStorageMax(weapon) then
					setCommsMessage("You are fully loaded and ready to explode things.")
				else
					setCommsMessage("We generously resupplied you with some weapon charges.\nPut them to good use.")
				end
			else
				setCommsMessage("Not enough reputation.")
				return
			end
		else
			if comms_source:getReputationPoints() > points_per_item then
				setCommsMessage("You can't afford as much as I'd like to give you")
				addCommsReply("Get just one", function()
					if comms_source:takeReputationPoints(points_per_item) then
						comms_source:setWeaponStorage(weapon, comms_source:getWeaponStorage(weapon) + 1)
						if comms_source:getWeaponStorage(weapon) == comms_source:getWeaponStorageMax(weapon) then
							setCommsMessage("You are fully loaded and ready to explode things.")
						else
							setCommsMessage("We generously resupplied you with one weapon charge.\nPut it to good use.")
						end
					else
						setCommsMessage("Not enough reputation.")
					end
					return
				end)
			else
				setCommsMessage("Not enough reputation.")
				return				
			end
		end
        addCommsReply("Back", commsStation)
    end
end
function getWeaponCost(weapon)
    return math.ceil(comms_data.weapon_cost[weapon] * comms_data.reputation_cost_multipliers[getFriendStatus()])
end
function preOrderOrdnance()
	setCommsMessage(preorder_message)
	local ctd = comms_target.comms_data
	local hvli_count = math.floor(comms_source:getWeaponStorageMax("HVLI") * ctd.max_weapon_refill_amount[getFriendStatus()]) - comms_source:getWeaponStorage("HVLI")
	if ctd.weapon_available.HVLI and isAllowedTo(ctd.weapons["HVLI"]) and hvli_count > 0 then
		local hvli_prompt = ""
		local hvli_cost = getWeaponCost("HVLI")
		if hvli_count > 1 then
			hvli_prompt = string.format("%i HVLIs * %i Rep = %i Rep",hvli_count,hvli_cost,hvli_count*hvli_cost)
		else
			hvli_prompt = string.format("%i HVLI * %i Rep = %i Rep",hvli_count,hvli_cost,hvli_count*hvli_cost)
		end
		addCommsReply(hvli_prompt,function()
			if comms_source:takeReputationPoints(hvli_count*hvli_cost) then
				comms_source.preorder_hvli = hvli_count
				if hvli_count > 1 then
					setCommsMessage(string.format("%i HVLIs preordered",hvli_count))
				else
					setCommsMessage(string.format("%i HVLI preordered",hvli_count))
				end
			else
				setCommsMessage("Insufficient reputation")
			end
			preorder_message = "Docking crew is standing by. Would you like to pre-order anything?"
			addCommsReply("Back",preOrderOrdnance)
		end)
	end
	local homing_count = math.floor(comms_source:getWeaponStorageMax("Homing") * ctd.max_weapon_refill_amount[getFriendStatus()]) - comms_source:getWeaponStorage("Homing")
	if ctd.weapon_available.Homing and isAllowedTo(ctd.weapons["Homing"]) and homing_count > 0 then
		local homing_prompt = ""
		local homing_cost = getWeaponCost("Homing")
		if homing_count > 1 then
			homing_prompt = string.format("%i Homings * %i Rep = %i Rep",homing_count,homing_cost,homing_count*homing_cost)
		else
			homing_prompt = string.format("%i Homing * %i Rep = %i Rep",homing_count,homing_cost,homing_count*homing_cost)
		end
		addCommsReply(homing_prompt,function()
			if comms_source:takeReputationPoints(homing_count*homing_cost) then
				comms_source.preorder_homing = homing_count
				if homing_count > 1 then
					setCommsMessage(string.format("%i Homings preordered",homing_count))
				else
					setCommsMessage(string.format("%i Homing preordered",homing_count))
				end
			else
				setCommsMessage("Insufficient reputation")
			end
			preorder_message = "Docking crew is standing by. Would you like to pre-order anything?"
			addCommsReply("Back",preOrderOrdnance)
		end)
	end
	local mine_count = math.floor(comms_source:getWeaponStorageMax("Mine") * ctd.max_weapon_refill_amount[getFriendStatus()]) - comms_source:getWeaponStorage("Mine")
	if ctd.weapon_available.Mine and isAllowedTo(ctd.weapons["Mine"]) and mine_count > 0 then
		local mine_prompt = ""
		local mine_cost = getWeaponCost("Mine")
		if mine_count > 1 then
			mine_prompt = string.format("%i Mines * %i Rep = %i Rep",mine_count,mine_cost,mine_count*mine_cost)
		else
			mine_prompt = string.format("%i Mine * %i Rep = %i Rep",mine_count,mine_cost,mine_count*mine_cost)
		end
		addCommsReply(mine_prompt,function()
			if comms_source:takeReputationPoints(mine_count*mine_cost) then
				comms_source.preorder_mine = mine_count
				if mine_count > 1 then
					setCommsMessage(string.format("%i Mines preordered",mine_count))
				else
					setCommsMessage(string.format("%i Mine preordered",mine_count))
				end
			else
				setCommsMessage("Insufficient reputation")
			end
			preorder_message = "Docking crew is standing by. Would you like to pre-order anything?"
			addCommsReply("Back",preOrderOrdnance)
		end)
	end
	local emp_count = math.floor(comms_source:getWeaponStorageMax("EMP") * ctd.max_weapon_refill_amount[getFriendStatus()]) - comms_source:getWeaponStorage("EMP")
	if ctd.weapon_available.EMP and isAllowedTo(ctd.weapons["EMP"]) and emp_count > 0 then
		local emp_prompt = ""
		local emp_cost = getWeaponCost("EMP")
		if emp_count > 1 then
			emp_prompt = string.format("%i EMPs * %i Rep = %i Rep",emp_count,emp_cost,emp_count*emp_cost)
		else
			emp_prompt = string.format("%i EMP * %i Rep = %i Rep",emp_count,emp_cost,emp_count*emp_cost)
		end
		addCommsReply(emp_prompt,function()
			if comms_source:takeReputationPoints(emp_count*emp_cost) then
				comms_source.preorder_emp = emp_count
				if emp_count > 1 then
					setCommsMessage(string.format("%i EMPs preordered",emp_count))
				else
					setCommsMessage(string.format("%i EMP preordered",emp_count))
				end
			else
				setCommsMessage("Insufficient reputation")
			end
			preorder_message = "Docking crew is standing by. Would you like to pre-order anything?"
			addCommsReply("Back",preOrderOrdnance)
		end)
	end
	local nuke_count = math.floor(comms_source:getWeaponStorageMax("Nuke") * ctd.max_weapon_refill_amount[getFriendStatus()]) - comms_source:getWeaponStorage("Nuke")
	if ctd.weapon_available.Nuke and isAllowedTo(ctd.weapons["Nuke"]) and nuke_count > 0 then
		local nuke_prompt = ""
		local nuke_cost = getWeaponCost("Nuke")
		if nuke_count > 1 then
			nuke_prompt = string.format("%i Nukes * %i Rep = %i Rep",nuke_count,nuke_cost,nuke_count*nuke_cost)
		else
			nuke_prompt = string.format("%i Nuke * %i Rep = %i Rep",nuke_count,nuke_cost,nuke_count*nuke_cost)
		end
		addCommsReply(nuke_prompt,function()
			if comms_source:takeReputationPoints(nuke_count*nuke_cost) then
				comms_source.preorder_nuke = nuke_count
				if nuke_count > 1 then
					setCommsMessage(string.format("%i Nukes preordered",nuke_count))
				else
					setCommsMessage(string.format("%i Nuke preordered",nuke_count))
				end
			else
				setCommsMessage("Insufficient reputation")
			end
			preorder_message = "Docking crew is standing by. Would you like to pre-order anything?"
			addCommsReply("Back",preOrderOrdnance)
		end)
	end
	if comms_source.preorder_repair_crew == nil then
		if random(1,100) <= 20 then
			if comms_source:isFriendly(comms_target) then
				if comms_source:getRepairCrewCount() < comms_source.maxRepairCrew then
					hireCost = math.random(30,60)
				else
					hireCost = math.random(45,90)
				end
				addCommsReply(string.format("Recruit repair crew member for %i reputation",hireCost), function()
					if not comms_source:takeReputationPoints(hireCost) then
						setCommsMessage("Insufficient reputation")
					else
						comms_source.preorder_repair_crew = 1
						setCommsMessage("Repair crew hired on your behalf. They will board when you dock")
					end				
					preorder_message = "Docking crew is standing by. Would you like to pre-order anything?"
					addCommsReply("Back",preOrderOrdnance)
				end)
			end
		end
	end
	if comms_source.preorder_coolant == nil then
		if random(1,100) <= 20 then
			if comms_source:isFriendly(comms_target) then
				if comms_source.initialCoolant ~= nil then
					local coolant_cost = math.random(45,90)
					if comms_source:getMaxCoolant() < comms_source.initialCoolant then
						coolant_cost = math.random(30,60)
					end
					addCommsReply(string.format("Set aside coolant for %i reputation",coolant_cost), function()
						if comms_source:takeReputationPoints(coolant_cost) then
							comms_source.preorder_coolant = 2
							setCommsMessage("Coolant set aside for you. It will be loaded when you dock")
						else
							setCommsMessage("Insufficient reputation")
						end
						preorder_message = "Docking crew is standing by. Would you like to pre-order anything?"
						addCommsReply("Back",preOrderOrdnance)
					end)
				end
			end
		end
	end
end
function handleUndockedState()
    --Handle communications when we are not docked with the station.
    local ctd = comms_target.comms_data
    if comms_source:isFriendly(comms_target) then
        oMsg = "Good day, officer.\nIf you need supplies, please dock with us first."
    else
        oMsg = "Greetings.\nIf you want to do business, please dock with us first."
    end
    if comms_target:areEnemiesInRange(20000) then
		oMsg = oMsg .. "\nBe aware that if enemies in the area get much closer, we will be too busy to conduct business with you."
	end
	setCommsMessage(oMsg)
	local gm_verb = gm_verbs[math.random(1,#gm_verbs)]
	local gm_name = gm_names[math.random(1,#gm_names)]
	addCommsReply(string.format("%s %s",gm_verb,gm_name),function()
		commsSwitchToGM()
		addCommsReply("Back", commsStation)
	end)
	if isAllowedTo(ctd.services.preorder) then
		addCommsReply("Expedite Dock",function()
			if comms_source.expedite_dock == nil then
				comms_source.expedite_dock = false
			end
			if comms_source.expedite_dock then
				--handle expedite request already present
				local existing_expedite = "Docking crew is standing by"
				if comms_target == comms_source.expedite_dock_station then
					existing_expedite = existing_expedite .. ". Current preorders:"
					local preorders_identified = false
					if comms_source.preorder_hvli ~= nil then
						preorders_identified = true
						existing_expedite = existing_expedite .. string.format("\n   HVLIs: %i",comms_source.preorder_hvli)
					end
					if comms_source.preorder_homing ~= nil then
						preorders_identified = true
						existing_expedite = existing_expedite .. string.format("\n   Homings: %i",comms_source.preorder_homing)						
					end
					if comms_source.preorder_mine ~= nil then
						preorders_identified = true
						existing_expedite = existing_expedite .. string.format("\n   Mines: %i",comms_source.preorder_mine)						
					end
					if comms_source.preorder_emp ~= nil then
						preorders_identified = true
						existing_expedite = existing_expedite .. string.format("\n   EMPs: %i",comms_source.preorder_emp)						
					end
					if comms_source.preorder_nuke ~= nil then
						preorders_identified = true
						existing_expedite = existing_expedite .. string.format("\n   Nukes: %i",comms_source.preorder_nuke)						
					end
					if comms_source.preorder_repair_crew ~= nil then
						preorders_identified = true
						existing_expedite = existing_expedite .. "\n   One repair crew"						
					end
					if comms_source.preorder_coolant ~= nil then
						preorders_identified = true
						existing_expedite = existing_expedite .. "\n   Coolant"						
					end
					if preorders_identified then
						existing_expedite = existing_expedite .. "\nWould you like to preorder anything else?"
					else
						existing_expedite = existing_expedite .. " none.\nWould you like to preorder anything?"						
					end
					preorder_message = existing_expedite
					preOrderOrdnance()
				else
					existing_expedite = existing_expedite .. string.format(" on station %s (not this station, %s).",comms_source.expedite_dock_station:getCallSign(),comms_target:getCallSign())
					setCommsMessage(existing_expedite)
				end
				addCommsReply("Back",commsStation)
			else
				setCommsMessage("If you would like to speed up the addition of resources such as energy, ordnance, etc., please provide a time frame for your arrival. A docking crew will stand by until that time, after which they will return to their normal duties")
				preorder_message = "Docking crew is standing by. Would you like to pre-order anything?"
				addCommsReply("One minute (5 rep)", function()
					if comms_source:takeReputationPoints(5) then
						comms_source.expedite_dock = true
						comms_source.expedite_dock_station = comms_target
						comms_source.expedite_dock_timer_max = 60
						preOrderOrdnance()
					else
						setCommsMessage("Insufficient reputation")
					end
					addCommsReply("Back", commsStation)
				end)
				addCommsReply("Two minutes (10 Rep)", function()
					if comms_source:takeReputationPoints(10) then
						comms_source.expedite_dock = true
						comms_source.expedite_dock_station = comms_target
						comms_source.expedite_dock_timer_max = 120
						preOrderOrdnance()
					else
						setCommsMessage("Insufficient reputation")
					end
					addCommsReply("Back", commsStation)
				end)
				addCommsReply("Three minutes (15 Rep)", function()
					if comms_source:takeReputationPoints(15) then
						comms_source.expedite_dock = true
						comms_source.expedite_dock_station = comms_target
						comms_source.expedite_dock_timer_max = 180
						preOrderOrdnance()
					else
						setCommsMessage("Insufficient reputation")
					end
					addCommsReply("Back", commsStation)
				end)
			end
			addCommsReply("Back", commsStation)
		end)
	end
 	addCommsReply("I need information", function()
 		local ctd = comms_target.comms_data
		setCommsMessage("What kind of information do you need?")
		addCommsReply("What ordnance do you have available for restock?", function()
			local ctd = comms_target.comms_data
			local missileTypeAvailableCount = 0
			local ordnanceListMsg = ""
			if ctd.weapon_available.Nuke then
				missileTypeAvailableCount = missileTypeAvailableCount + 1
				ordnanceListMsg = ordnanceListMsg .. "\n   Nuke"
			end
			if ctd.weapon_available.EMP then
				missileTypeAvailableCount = missileTypeAvailableCount + 1
				ordnanceListMsg = ordnanceListMsg .. "\n   EMP"
			end
			if ctd.weapon_available.Homing then
				missileTypeAvailableCount = missileTypeAvailableCount + 1
				ordnanceListMsg = ordnanceListMsg .. "\n   Homing"
			end
			if ctd.weapon_available.Mine then
				missileTypeAvailableCount = missileTypeAvailableCount + 1
				ordnanceListMsg = ordnanceListMsg .. "\n   Mine"
			end
			if ctd.weapon_available.HVLI then
				missileTypeAvailableCount = missileTypeAvailableCount + 1
				ordnanceListMsg = ordnanceListMsg .. "\n   HVLI"
			end
			if missileTypeAvailableCount == 0 then
				ordnanceListMsg = "We have no ordnance available for restock"
			elseif missileTypeAvailableCount == 1 then
				ordnanceListMsg = "We have the following type of ordnance available for restock:" .. ordnanceListMsg
			else
				ordnanceListMsg = "We have the following types of ordnance available for restock:" .. ordnanceListMsg
			end
			setCommsMessage(ordnanceListMsg)
			addCommsReply("Back", commsStation)
		end)
		local goodsAvailable = false
		if ctd.goods ~= nil then
			for good, goodData in pairs(ctd.goods) do
				if goodData["quantity"] > 0 then
					goodsAvailable = true
				end
			end
		end
		if goodsAvailable then
			addCommsReply("What goods do you have available for sale or trade?", function()
				local ctd = comms_target.comms_data
				local goodsAvailableMsg = string.format("Station %s:\nGoods or components available: quantity, cost in reputation",comms_target:getCallSign())
				for good, goodData in pairs(ctd.goods) do
					goodsAvailableMsg = goodsAvailableMsg .. string.format("\n   %14s: %2i, %3i",good,goodData["quantity"],goodData["cost"])
				end
				setCommsMessage(goodsAvailableMsg)
				addCommsReply("Back", commsStation)
			end)
		end
		addCommsReply("Docking services status", function()
	 		local ctd = comms_target.comms_data
			local service_status = string.format("Station %s docking services status:",comms_target:getCallSign())
			if comms_target:getRestocksScanProbes() then
				service_status = string.format("%s\nReplenish scan probes.",service_status)
			else
				if comms_target.probe_fail_reason == nil then
					local reason_list = {
						"Cannot replenish scan probes due to fabrication unit failure.",
						"Parts shortage prevents scan probe replenishment.",
						"Station management has curtailed scan probe replenishment for cost cutting reasons.",
					}
					comms_target.probe_fail_reason = reason_list[math.random(1,#reason_list)]
				end
				service_status = string.format("%s\n%s",service_status,comms_target.probe_fail_reason)
			end
			if comms_target:getRepairDocked() then
				service_status = string.format("%s\nShip hull repair.",service_status)
			else
				if comms_target.repair_fail_reason == nil then
					reason_list = {
						"We're out of the necessary materials and supplies for hull repair.",
						"Hull repair automation unavailable whie it is undergoing maintenance.",
						"All hull repair technicians quarantined to quarters due to illness.",
					}
					comms_target.repair_fail_reason = reason_list[math.random(1,#reason_list)]
				end
				service_status = string.format("%s\n%s",service_status,comms_target.repair_fail_reason)
			end
			if comms_target:getSharesEnergyWithDocked() then
				service_status = string.format("%s\nRecharge ship energy stores.",service_status)
			else
				if comms_target.energy_fail_reason == nil then
					reason_list = {
						"A recent reactor failure has put us on auxiliary power, so we cannot recharge ships.",
						"A damaged power coupling makes it too dangerous to recharge ships.",
						"An asteroid strike damaged our solar cells and we are short on power, so we can't recharge ships right now.",
					}
					comms_target.energy_fail_reason = reason_list[math.random(1,#reason_list)]
				end
				service_status = string.format("%s\n%s",service_status,comms_target.energy_fail_reason)
			end
			if ctd.jump_overcharge then
				service_status = string.format("%s\nMay overcharge jump drive",service_status)
			end
			setCommsMessage(service_status)
			addCommsReply("Back", commsStation)
		end)
		addCommsReply("Where can I find particular goods?", function()
			local ctd = comms_target.comms_data
			gkMsg = "Friendly stations often have food or medicine or both. Neutral stations may trade their goods for food, medicine or luxury."
			if ctd.goodsKnowledge == nil then
				ctd.goodsKnowledge = {}
				local knowledgeCount = 0
				local knowledgeMax = 10
				for i=1,#regionStations do
					local station = regionStations[i]
					if station ~= nil and station:isValid() then
						local brainCheckChance = 60
						if distance(comms_target,station) > 75000 then
							brainCheckChance = 20
						end
						for good, goodData in pairs(ctd.goods) do
							if random(1,100) <= brainCheckChance then
								local stationCallSign = station:getCallSign()
								local stationSector = station:getSectorName()
								ctd.goodsKnowledge[good] =	{	station = stationCallSign,
																sector = stationSector,
																cost = goodData["cost"] }
								knowledgeCount = knowledgeCount + 1
								if knowledgeCount >= knowledgeMax then
									break
								end
							end
						end
					end
					if knowledgeCount >= knowledgeMax then
						break
					end
				end
			end
			local goodsKnowledgeCount = 0
			for good, goodKnowledge in pairs(ctd.goodsKnowledge) do
				goodsKnowledgeCount = goodsKnowledgeCount + 1
				addCommsReply(good, function()
					local ctd = comms_target.comms_data
					local stationName = ctd.goodsKnowledge[good]["station"]
					local sectorName = ctd.goodsKnowledge[good]["sector"]
					local goodName = good
					local goodCost = ctd.goodsKnowledge[good]["cost"]
					setCommsMessage(string.format("Station %s in sector %s has %s for %i reputation",stationName,sectorName,goodName,goodCost))
					addCommsReply("Back", commsStation)
				end)
			end
			if goodsKnowledgeCount > 0 then
				gkMsg = gkMsg .. "\n\nWhat goods are you interested in?\nI've heard about these:"
			else
				gkMsg = gkMsg .. " Beyond that, I have no knowledge of specific stations"
			end
			setCommsMessage(gkMsg)
			addCommsReply("Back", commsStation)
		end)
		if ctd.public_relations then
			addCommsReply("Tell me more about your station", function()
				local ctd = comms_target.comms_data
				setCommsMessage("What would you like to know?")
				addCommsReply("General information", function()
					local ctd = comms_target.comms_data
					setCommsMessage(ctd.general_information)
					addCommsReply("Back", commsStation)
				end)
				if ctd.history ~= nil then
					addCommsReply("Station history", function()
						local ctd = comms_target.comms_data
						setCommsMessage(ctd.history)
						addCommsReply("Back", commsStation)
					end)
				end
				if comms_source:isFriendly(comms_target) then
					if ctd.gossip ~= nil then
						if random(1,100) < 50 then
							addCommsReply("Gossip", function()
								local ctd = comms_target.comms_data
								setCommsMessage(ctd.gossip)
								addCommsReply("Back", commsStation)
							end)
						end
					end
				end
			end)	--end station info comms reply branch
		end	--end public relations if branch
		addCommsReply("Report status", function()
			msg = "Hull: " .. math.floor(comms_target:getHull() / comms_target:getHullMax() * 100) .. "%\n"
			local shields = comms_target:getShieldCount()
			if shields == 1 then
				msg = msg .. "Shield: " .. math.floor(comms_target:getShieldLevel(0) / comms_target:getShieldMax(0) * 100) .. "%\n"
			else
				for n=0,shields-1 do
					msg = msg .. "Shield " .. n .. ": " .. math.floor(comms_target:getShieldLevel(n) / comms_target:getShieldMax(n) * 100) .. "%\n"
				end
			end			
			setCommsMessage(msg);
			addCommsReply("Back", commsStation)
		end)
	end)
	if isAllowedTo(ctd.services.supplydrop) then
        addCommsReply("Can you send a supply drop? ("..getServiceCost("supplydrop").."rep)", function()
            if comms_source:getWaypointCount() < 1 then
                setCommsMessage("You need to set a waypoint before you can request backup.");
            else
                setCommsMessage("To which waypoint should we deliver your supplies?");
                for n=1,comms_source:getWaypointCount() do
                    addCommsReply("WP" .. n, function()
						if comms_source:takeReputationPoints(getServiceCost("supplydrop")) then
							local position_x, position_y = comms_target:getPosition()
							local target_x, target_y = comms_source:getWaypoint(n)
							local script = Script()
							script:setVariable("position_x", position_x):setVariable("position_y", position_y)
							script:setVariable("target_x", target_x):setVariable("target_y", target_y)
							script:setVariable("faction_id", comms_target:getFactionId()):run("supply_drop.lua")
							setCommsMessage("We have dispatched a supply ship toward WP" .. n);
						else
							setCommsMessage("Not enough reputation!");
						end
                        addCommsReply("Back", commsStation)
                    end)
                end
            end
            addCommsReply("Back", commsStation)
        end)
    end
    if isAllowedTo(ctd.services.reinforcements) then
        addCommsReply("Please send reinforcements! ("..getServiceCost("reinforcements").."rep)", function()
            if comms_source:getWaypointCount() < 1 then
                setCommsMessage("You need to set a waypoint before you can request reinforcements.");
            else
                setCommsMessage("To which waypoint should we dispatch the reinforcements?");
                for n=1,comms_source:getWaypointCount() do
                    addCommsReply("WP" .. n, function()
						if comms_source:takeReputationPoints(getServiceCost("reinforcements")) then
							ship = CpuShip():setFactionId(comms_target:getFactionId()):setPosition(comms_target:getPosition()):setTemplate("Adder MK5"):setScanned(true):orderDefendLocation(comms_source:getWaypoint(n))
							ship:setCommsScript(""):setCommsFunction(commsShip)
							setCommsMessage("We have dispatched " .. ship:getCallSign() .. " to assist at WP" .. n);
						else
							setCommsMessage("Not enough reputation!");
						end
                        addCommsReply("Back", commsStation)
                    end)
                end
            end
            addCommsReply("Back", commsStation)
        end)
    end
end
function getServiceCost(service)
    return math.ceil(comms_data.service_cost[service])
end
function getFriendStatus()
    if comms_source:isFriendly(comms_target) then
        return "friend"
    else
        return "neutral"
    end
end
function playerShipCargoInventory(p)
	p:addToShipLog(string.format("%s Current cargo:",p:getCallSign()),"Yellow")
	local goodCount = 0
	if p.goods ~= nil then
		for good, goodQuantity in pairs(p.goods) do
			goodCount = goodCount + 1
			p:addToShipLog(string.format("     %s: %i",good,goodQuantity),"Yellow")
		end
	end
	if goodCount < 1 then
		p:addToShipLog("     Empty","Yellow")
	end
	p:addToShipLog(string.format("Available space: %i",p.cargo),"Yellow")
end
---------------------------------------------------
--	Dynamic functions linked to update function  --
---------------------------------------------------
function resetPreviousSystemHealth(p)
	if healthDiagnostic then print("reset previous system health") end
	if p == nil then
		p = comms_source
		if healthDiagnostic then print("set p to comms source") end
	end
	if healthDiagnostic then print("reset shield") end
	local currentShield = 0
	if p:getShieldCount() > 1 then
		currentShield = (p:getSystemHealth("frontshield") + p:getSystemHealth("rearshield"))/2
	else
		currentShield = p:getSystemHealth("frontshield")
	end
	p.prevShield = currentShield
	if healthDiagnostic then print("reset reactor") end
	p.prevReactor = p:getSystemHealth("reactor")
	if healthDiagnostic then print("reset maneuver") end
	p.prevManeuver = p:getSystemHealth("maneuver")
	if healthDiagnostic then print("reset impulse") end
	p.prevImpulse = p:getSystemHealth("impulse")
	if healthDiagnostic then print("reset beam") end
	if p:getBeamWeaponRange(0) > 0 then
		if p.healthyBeam == nil then
			p.healthyBeam = 1.0
			p.prevBeam = 1.0
		end
		p.prevBeam = p:getSystemHealth("beamweapons")
	end
	if healthDiagnostic then print("reset missile") end
	if p:getWeaponTubeCount() > 0 then
		if p.healthyMissile == nil then
			p.healthyMissile = 1.0
			p.prevMissile = 1.0
		end
		p.prevMissile = p:getSystemHealth("missilesystem")
	end
	if healthDiagnostic then print("reset warp") end
	if p:hasWarpDrive() then
		if p.healthyWarp == nil then
			p.healthyWarp = 1.0
			p.prevWarp = 1.0
		end
		p.prevWarp = p:getSystemHealth("warp")
	end
	if healthDiagnostic then print("reset jump") end
	if p:hasJumpDrive() then
		if p.healthyJump == nil then
			p.healthyJump = 1.0
			p.prevJump = 1.0
		end
		p.prevJump = p:getSystemHealth("jumpdrive")
	end
	if healthDiagnostic then print("end of reset previous system health function") end
end
--	Tractor functions (called from update loop
function removeTractorObjectButtons(p)
	if p.tractor_next_target_button ~= nil then
		p:removeCustom(p.tractor_next_target_button)
		p.tractor_next_target_button = nil
	end
	if p.tractor_target_button ~= nil then
		p:removeCustom(p.tractor_target_button)
		p.tractor_target_button = nil
	end
	if p.tractor_lock_button ~= nil then
		p:removeCustom(p.tractor_lock_button)
		p.tractor_lock_button = nil
	end
end
function addTractorObjectButtons(p,tractor_objects)
	local cpx, cpy = p:getPosition()
	local tpx, tpy = p.tractor_target:getPosition()
	if p.tractor_lock_button == nil then
		if p:hasPlayerAtPosition("Engineering") then
			p.tractor_lock_button = "tractor_lock_button"
			p:addCustomButton("Engineering",p.tractor_lock_button,"Lock on Tractor",function()
				local cpx, cpy = p:getPosition()
				local tpx, tpy = p.tractor_target:getPosition()
				local tractor_object_distance = distance(cpx,cpy,tpx,tpy)
				if tractor_object_distance < 1000 then
					p.tractor_target_lock = true
					p.tractor_vector_x = tpx - cpx
					p.tractor_vector_y = tpy - cpy
					local locked_message = "locked_message"
					p:addCustomMessage("Engineering",locked_message,"Tractor locked on target")
				else
					local lock_fail_message = "lock_fail_message"
					p:addCustomMessage("Engineering",lock_fail_message,string.format("Tractor lock failed\nObject distance is %.4fU\nMaximum range of tractor is 1U",tractor_object_distance/1000))
					p.tractor_target = nil
				end
				removeTractorObjectButtons(p)
			end)
		end
	end
	if p.tractor_target_button == nil then
		if p:hasPlayerAtPosition("Engineering") then
			p.tractor_target_button = "tractor_target_button"
			local label_type = p.tractor_target.typeName
			if label_type == "CpuShip" or label_type == "PlayerSpaceship" then
				label_type = p.tractor_target:getCallSign()
			elseif label_type == "VisualAsteroid" then
				label_type = "Asteroid"
			end
			p:addCustomButton("Engineering",p.tractor_target_button,string.format("Target %s",label_type),function()
				string.format("")	--necessary to have global reference for Serious Proton engine
				tpx, tpy = p.tractor_target:getPosition()
				local target_distance = distance(cpx, cpy, tpx, tpy)/1000
				local theta = math.atan(tpy - cpy,tpx - cpx)
				if theta < 0 then
					theta = theta + 6.2831853071795865
				end
				local angle = theta * 57.2957795130823209
				angle = angle + 90
				if angle > 360 then
					angle = angle - 360
				end
				local target_description = "target_description"
				p:addCustomMessage("Engineering",target_description,string.format("Distance: %.1fU\nBearing: %.1f",target_distance,angle))
			end)
		end
	end
	if #tractor_objects > 1 then
		if p.tractor_next_target_button == nil then
			if p:hasPlayerAtPosition("Engineering") then
				p.tractor_next_target_button = "tractor_next_target_button"
				p:addCustomButton("Engineering",p.tractor_next_target_button,"Other tractor target",function()
					local nearby_objects = p:getObjectsInRange(1000)
					local tractor_objects = {}
					if nearby_objects ~= nil and #nearby_objects > 1 then
						for _, obj in ipairs(nearby_objects) do
							if p ~= obj then
								local object_type = obj.typeName
								if object_type ~= nil then
									if object_type == "Asteroid" or object_type == "CpuShip" or object_type == "Artifact" or object_type == "PlayerSpaceship" or object_type == "WarpJammer" or object_type == "Mine" or object_type == "ScanProbe" or object_type == "VisualAsteroid" then
										table.insert(tractor_objects,obj)
									end
								end
							end
						end		--end of nearby object list loop
						if #tractor_objects > 0 then
							--print(string.format("%i tractorable objects under 1 unit away",#tractor_objects))
							if p.tractor_target ~= nil and p.tractor_target:isValid() then
								local target_in_list = false
								local matching_index = 0
								for i=1,#tractor_objects do
									if tractor_objects[i] == p.tractor_target then
										target_in_list = true
										matching_index = i
										break
									end
								end		--end of check for the current target in list loop
								if target_in_list then
									if #tractor_objects > 1 then
										if #tractor_objects > 2 then
											local new_index = matching_index
											repeat
												new_index = math.random(1,#tractor_objects)
											until(new_index ~= matching_index)
											p.tractor_target = tractor_objects[new_index]
										else
											if matching_index == 1 then
												p.tractor_target = tractor_objects[2]
											else
												p.tractor_target = tractor_objects[1]
											end
										end
										removeTractorObjectButtons(p)
										addTractorObjectButtons(p,tractor_objects)
									end
								else
									p.tractor_target = tractor_objects[1]
									removeTractorObjectButtons(p)
									addTractorObjectButtons(p,tractor_objects)
								end
							else
								p.tractor_target = tractor_objects[1]
								addTractorObjectButtons(p,tractor_objects)
							end
						else	--no nearby tractorable objects
							if p.tractor_target ~= nil then
								removeTractorObjectButtons(p)
								p.tractor_target = nil
							end
						end
					else	--no nearby objects
						if p.tractor_target ~= nil then
							removeTractorObjectButtons(p)
							p.tractor_target = nil
						end
					end
				end)
			end
		end
	else
		if p.tractor_next_target_button ~= nil then
			p:removeCustom(p.tractor_next_target_button)
			p.tractor_next_target_button = nil
		end
	end
end
-- Mining functions (called from update loop)
function removeMiningButtons(p)
	if p.mining_next_target_button ~= nil then
		p:removeCustom(p.mining_next_target_button)
		p.mining_next_target_button = nil
	end
	if p.mining_target_button ~= nil then
		p:removeCustom(p.mining_target_button)
		p.mining_target_button = nil
	end
	if p.mining_lock_button ~= nil then
		p:removeCustom(p.mining_lock_button)
		p.mining_lock_button = nil
	end
end
function addMiningButtons(p,mining_objects)
	local cpx, cpy = p:getPosition()
	local tpx, tpy = p.mining_target:getPosition()
	if p.mining_lock_button == nil then
		if p:hasPlayerAtPosition("Science") then
			p.mining_lock_button = "mining_lock_button"
			p:addCustomButton("Science",p.mining_lock_button,"Lock for Mining",function()
				local cpx, cpy = p:getPosition()
				local tpx, tpy = p.mining_target:getPosition()
				local asteroid_distance = distance(cpx,cpy,tpx,tpy)
				if asteroid_distance < 1000 then
					p.mining_target_lock = true
					local mining_locked_message = "mining_locked_message"
					p:addCustomMessage("Science",mining_locked_message,"Mining target locked\nWeapons may trigger the mining beam")
				else
					local mining_lock_fail_message = "mining_lock_fail_message"
					p:addCustomMessage("Engineering",mining_lock_fail_message,string.format("Mining target lock failed\nAsteroid distance is %.4fU\nMaximum range for mining is 1U",asteroid_distance/1000))
					p.mining_target = nil
				end
				removeMiningButtons(p)
			end)
		end
	end
	if p.mining_target_button == nil then
		if p:hasPlayerAtPosition("Science") then
			p.mining_target_button = "mining_target_button"
			p:addCustomButton("Science",p.mining_target_button,"Target Asteroid",function()
				string.format("")	--necessary to have global reference for Serious Proton engine
				tpx, tpy = p.mining_target:getPosition()
				local target_distance = distance(cpx, cpy, tpx, tpy)/1000
				local theta = math.atan(tpy - cpy,tpx - cpx)
				if theta < 0 then
					theta = theta + 6.2831853071795865
				end
				local angle = theta * 57.2957795130823209
				angle = angle + 90
				if angle > 360 then
					angle = angle - 360
				end
				if p.mining_target.trace_minerals == nil then
					p.mining_target.trace_minerals = {}
					for i=1,#mineralGoods do
						if random(1,100) < 26 then
							table.insert(p.mining_target.trace_minerals,mineralGoods[i])
						end
					end
				end
				local minerals = ""
				for i=1,#p.mining_target.trace_minerals do
					if minerals == "" then
						minerals = minerals .. p.mining_target.trace_minerals[i]
					else
						minerals = minerals .. ", " .. p.mining_target.trace_minerals[i]
					end
				end
				if minerals == "" then
					minerals = "none"
				end
				local target_description = "target_description"
				p:addCustomMessage("Science",target_description,string.format("Distance: %.1fU\nBearing: %.1f\nMineral traces detected: %s",target_distance,angle,minerals))
			end)
		end
	end
	if #mining_objects > 1 then
		if p.mining_next_target_button == nil then
			if p:hasPlayerAtPosition("Science") then
				p.mining_next_target_button = "mining_next_target_button"
				p:addCustomButton("Science",p.mining_next_target_button,"Other mining target",function()
					local nearby_objects = p:getObjectsInRange(1000)
					local mining_objects = {}
					if nearby_objects ~= nil and #nearby_objects > 1 then
						for _, obj in ipairs(nearby_objects) do
							if p ~= obj then
								local object_type = obj.typeName
								if object_type ~= nil then
									if object_type == "Asteroid" or object_type == "VisualAsteroid" then
										table.insert(mining_objects,obj)
									end
								end
							end
						end		--end of nearby object list loop
						if #mining_objects > 0 then
							--print(string.format("%i tractorable objects under 1 unit away",#tractor_objects))
							if p.mining_target ~= nil and p.mining_target:isValid() then
								local target_in_list = false
								local matching_index = 0
								for i=1,#mining_objects do
									if mining_objects[i] == p.mining_target then
										target_in_list = true
										matching_index = i
										break
									end
								end		--end of check for the current target in list loop
								if target_in_list then
									if #mining_objects > 1 then
										if #mining_objects > 2 then
											local new_index = matching_index
											repeat
												new_index = math.random(1,#mining_objects)
											until(new_index ~= matching_index)
											p.mining_target = mining_objects[new_index]
										else
											if matching_index == 1 then
												p.mining_target = mining_objects[2]
											else
												p.mining_target = mining_objects[1]
											end
										end
										removeMiningButtons(p)
										addMiningButtons(p,mining_objects)
									end
								else
									p.mining_target = mining_objects[1]
									removeMiningButtons(p)
									addMiningButtons(p,mining_objects)
								end
							else
								p.mining_target = mining_objects[1]
								addMiningButtons(p,mining_objects)
							end
						else	--no nearby tractorable objects
							if p.mining_target ~= nil then
								removeMiningButtons(p)
								p.mining_target = nil
							end
						end
					else	--no nearby objects
						if p.mining_target ~= nil then
							removeMiningButtons(p)
							p.mining_target = nil
						end
					end
				end)
			end
		end
	else
		if p.mining_next_target_button ~= nil then
			p:removeCustom(p.mining_next_target_button)
			p.mining_next_target_button = nil
		end
	end
end
function movingObjects(delta)
	if icarus_mobile_nebula_1 ~= nil and icarus_mobile_nebula_1:isValid() then
		local neb_x, neb_y = icarus_mobile_nebula_1:getPosition()
		if neb_x < -10000 then
			neb_x = -10000
		    icarus_mobile_nebula_1.increment = random(0,10)
			if neb_y > 110000 then
				--icarus_mobile_nebula_1.angle = random(1,89)
				icarus_mobile_nebula_1.angle = random(271,359)
			else
				--icarus_mobile_nebula_1.angle = random(91,179)
				icarus_mobile_nebula_1.angle = random(1,89)
			end
		end
		if neb_x > 80000 then
			neb_x = 80000
		    icarus_mobile_nebula_1.increment = random(0,10)
			if neb_y > 110000 then
				--icarus_mobile_nebula_1.angle = random(271,359)
				icarus_mobile_nebula_1.angle = random(181,269)
			else
				--icarus_mobile_nebula_1.angle = random(181,269)
				icarus_mobile_nebula_1.angle = random(91,179)
			end
		end
		if neb_y < 80000 then
			neb_y = 80000
		    icarus_mobile_nebula_1.increment = random(0,10)
			if neb_x > 45000 then
				--icarus_mobile_nebula_1.angle = random(181,269)
				icarus_mobile_nebula_1.angle = random(91,179)
			else
				--icarus_mobile_nebula_1.angle = random(91,179)
				icarus_mobile_nebula_1.angle = random(1,89)
			end
		end
		if neb_y > 140000 then
			neb_y = 140000
		    icarus_mobile_nebula_1.increment = random(0,10)
			if neb_x > 45000 then
				--icarus_mobile_nebula_1.angle = random(271,359)
				icarus_mobile_nebula_1.angle = random(181,269)
			else
				--icarus_mobile_nebula_1.angle = random(1,89)
				icarus_mobile_nebula_1.angle = random(271,359)
			end
		end
		local dx, dy = vectorFromAngle(icarus_mobile_nebula_1.angle,icarus_mobile_nebula_1.increment)
		icarus_mobile_nebula_1:setPosition(neb_x+dx,neb_y+dy)
		local nr = icarus_mobile_nebula_1:getRotation()
		nr = nr + .01
		if nr > 360 then 
			nr = nr - 360
		end
		icarus_mobile_nebula_1:setRotation(nr)
	end
	if kentar_mobile_nebula_1 ~= nil and kentar_mobile_nebula_1:isValid() then
		if kentar_mobile_nebula_1.lower_black_hole then
			--print(string.format("Lower start angle: %f, ready: %s",kentar_mobile_nebula_1.angle,tostring(kentar_mobile_nebula_1.ready)))
			kentar_mobile_nebula_1.angle = kentar_mobile_nebula_1.angle + kentar_mobile_nebula_1.increment
			if kentar_mobile_nebula_1.angle > 360 then
				kentar_mobile_nebula_1.angle = kentar_mobile_nebula_1.angle - 360
			end
			--print(string.format("Lower mod 1 angle: %f, ready: %s",kentar_mobile_nebula_1.angle,tostring(kentar_mobile_nebula_1.ready)))
			if kentar_mobile_nebula_1.ready then
				if kentar_mobile_nebula_1.angle >= 315 then
					--switch
					kentar_mobile_nebula_1.lower_black_hole = false
					kentar_mobile_nebula_1.angle = 135 - (kentar_mobile_nebula_1.angle - 315)
					kentar_mobile_nebula_1.center_x = 290000
					kentar_mobile_nebula_1.center_y = 210000
					kentar_mobile_nebula_1.ready = false
				end
			else
				if kentar_mobile_nebula_1.angle < 315 then
					kentar_mobile_nebula_1.ready = true
				end
			end
			--print(string.format("Lower mod 2 angle: %f, ready: %s",kentar_mobile_nebula_1.angle,tostring(kentar_mobile_nebula_1.ready)))
		else
			--print(string.format("Upper start angle: %f, ready: %s",kentar_mobile_nebula_1.angle,tostring(kentar_mobile_nebula_1.ready)))
			kentar_mobile_nebula_1.angle = kentar_mobile_nebula_1.angle - kentar_mobile_nebula_1.increment
			if kentar_mobile_nebula_1.angle < 0 then
				kentar_mobile_nebula_1.angle = kentar_mobile_nebula_1.angle + 360
			end
			--print(string.format("Upper mod 1 angle: %f, ready: %s",kentar_mobile_nebula_1.angle,tostring(kentar_mobile_nebula_1.ready)))
			if kentar_mobile_nebula_1.ready then
				if kentar_mobile_nebula_1.angle <= 135 then
					--switch
					kentar_mobile_nebula_1.lower_black_hole = true
					kentar_mobile_nebula_1.angle = 315 + (135 - kentar_mobile_nebula_1.angle)
					kentar_mobile_nebula_1.center_x = 210000
					kentar_mobile_nebula_1.center_y = 290000
					kentar_mobile_nebula_1.ready = false
				end
			else
				if kentar_mobile_nebula_1.angle > 135 then
					kentar_mobile_nebula_1.ready = true
				end
			end
			--print(string.format("Upper mod 2 angle: %f, ready: %s",kentar_mobile_nebula_1.angle,tostring(kentar_mobile_nebula_1.ready)))
		end
		local px,py = vectorFromAngle(kentar_mobile_nebula_1.angle,kentar_mobile_nebula_1.mobile_neb_dist)
		kentar_mobile_nebula_1:setPosition(kentar_mobile_nebula_1.center_x+px,kentar_mobile_nebula_1.center_y+py)
	end
	if rotate_station ~= nil and #rotate_station > 0 then
		for i=1,#rotate_station do
			local current_station = rotate_station[i]
			if current_station ~= nil and current_station:isValid() then
				current_station:setRotation(current_station:getRotation()+.1)
				if current_station:getRotation() >= 360 then
					current_station:setRotation(0)
				end
			end
		end
	end
end
-------------------------
--	Testing functions  --
-------------------------
function runAllTests()
	getNumberOfObjectsStringTest()
	math.extraTests()
	updateSystem():_test()
end

function updateInner(delta)
	getScenarioTimePreStandardAddDelta(delta) -- this can be removed in the next version of EE
	if updateDiagnostic then print("update: top of update function") end
	--generic sandbox items
	if timer_started then
		if timer_value == nil then
			timer_value = delta + timer_start_length*60
		end
		timer_value = timer_value - delta + timer_fudge
	end
	healthCheckTimer = healthCheckTimer - delta
	local warning_message = nil
	local warning_station = nil
	if automated_station_danger_warning and regionStations ~= nil then
		for station_index=1,#regionStations do
			local current_station = regionStations[station_index]
			if current_station ~= nil and current_station:isValid() then
				if current_station.proximity_warning == nil then
					for _, obj in ipairs(current_station:getObjectsInRange(station_sensor_range)) do
						if obj ~= nil and obj:isValid() then
							if obj:isEnemy(current_station) then
								local detected_enemy_ship = false
								local obj_type_name = obj.typeName
								if obj_type_name ~= nil then
									if string.find(obj_type_name,"CpuShip") then
										detected_enemy_ship = true
									end
								end
								if detected_enemy_ship then
									warning_station = current_station
									warning_message = string.format("[%s in %s] We detect one or more enemies nearby",current_station:getCallSign(),current_station:getSectorName())
									if warning_includes_ship_type then
										warning_message = string.format("%s. At least one is of type %s",warning_message,obj:getTypeName())
									end
									current_station.proximity_warning = warning_message
									current_station.proximity_warning_timer = delta + 300
									break
								end
							end
						end
					end
					if warning_station ~= nil then
						break
					end
				else
					current_station.proximity_warning_timer = current_station.proximity_warning_timer - delta
					if current_station.proximity_warning_timer < 0 then
						current_station.proximity_warning = nil
					end
				end
				if warning_station == nil then
					if current_station.shield_damage_warning == nil then
						for i=1,current_station:getShieldCount() do
							if current_station:getShieldLevel(i-1) < current_station:getShieldMax(i-1) then
								warning_station = current_station
								warning_message = string.format("[%s in %s] Our shields have taken damage",current_station:getCallSign(),current_station:getSectorName())
								current_station.shield_damage_warning = warning_message
								current_station.shield_damage_warning_timer = delta + 300
								break
							end
						end
						if warning_station ~= nil then
							break
						end
					else
						current_station.shield_damage_warning_timer = current_station.shield_damage_warning_timer - delta
						if current_station.shield_damage_warning_timer < 0 then
							current_station.shield_damage_warning = nil
						end
					end
				end
				if warning_station == nil then
					if current_station.severe_shield_warning == nil then
						local current_station_shield_count = current_station:getShieldCount()
						for i=1,current_station_shield_count do
							if current_station:getShieldLevel(i-1) < current_station:getShieldMax(i-1)*.1 then
								warning_station = current_station
								if current_station_shield_count == 1 then
									warning_message = string.format("[%s in %s] Our shields are nearly gone",current_station:getCallSign(),current_station:getSectorName())
								else
									warning_message = string.format("[%s in %s] One or more of our shields are nearly gone",current_station:getCallSign(),current_station:getSectorName())
								end
								current_station.severe_shield_warning = warning_message
								current_station.severe_shield_warning_timer = delta + 300
								break
							end
						end
						if warning_station ~= nil then
							break
						end
					else
						current_station.severe_shield_warning_timer = current_station.severe_shield_warning_timer - delta
						if current_station.severe_shield_warning_timer < 0 then
							current_station.severe_shield_warning = nil
						end
					end
				end
				if warning_station == nil then
					if current_station.hull_warning == nil then
						if current_station:getHull() < current_station:getHullMax() then
							warning_station = current_station
							warning_message = string.format("[%s in %s] Our hull has been damaged",current_station:getCallSign(),current_station:getSectorName())
							current_station.hull_warning = warning_message
							break
						end
					end
				end
				if warning_station == nil then
					if current_station.severe_hull_warning == nil then
						if current_station:getHull() < current_station:getHullMax()*.1 then
							warning_station = current_station
							warning_message = string.format("[%s in %s] We are on the brink of destruction",current_station:getCallSign(),current_station:getSectorName())
							current_station.severe_hull_warning = warning_message
						end
					end
				end
			end
		end
	end
	local ship_warning_message = nil
	local warning_ship = nil
	if automated_station_danger_warning and region_ships ~= nil then
		for ship_index=1,#region_ships do
			local current_ship = region_ships[ship_index]
			if current_ship ~= nil and current_ship:isValid() then
				if current_ship.proximity_warning == nil then
					for _, obj in ipairs(current_ship:getObjectsInRange(station_sensor_range)) do
						if obj ~= nil and obj:isValid() then
							if obj:isEnemy(current_ship) then
								local detected_enemy_ship = false
								local obj_type_name = obj.typeName
								if obj_type_name ~= nil then
									if string.find(obj_type_name,"CpuShip") then
										detected_enemy_ship = true
									end
								end
								if detected_enemy_ship then
									warning_ship = current_ship
									ship_warning_message = string.format("[%s in %s] We detect one or more enemies nearby",current_ship:getCallSign(),current_ship:getSectorName())
									if warning_includes_ship_type then
										ship_warning_message = string.format("%s. At least one is of type %s",ship_warning_message,obj:getTypeName())
									end
									current_ship.proximity_warning = ship_warning_message
									current_ship.proximity_warning_timer = delta + 300
									break
								end
							end
						end
					end
					if warning_ship ~= nil then
						break
					end
				else
					current_ship.proximity_warning_timer = current_ship.proximity_warning_timer - delta
					if current_ship.proximity_warning_timer < 0 then
						current_ship.proximity_warning = nil
					end
				end
			end
		end
	end
	if updateDiagnostic then print("update: universe update") end
	update_system:update(delta)
	for pidx=1,8 do
		if updateDiagnostic then print("update: pidx: " .. pidx) end
		local p = getPlayerShip(pidx)
		if p ~= nil and p:isValid() then
			if updateDiagnostic then print("update: valid player: adjust spawn point") end
			local player_name = p:getCallSign()
			if warning_station ~= nil then
				p:addToShipLog(warning_message,"Red")
			end
			if warning_ship ~= nil then
				p:addToShipLog(ship_warning_message,"Red")
			end
			local name_tag_text = string.format("%s in %s",player_name,p:getSectorName())
			if p:hasPlayerAtPosition("Relay") then
				p.name_tag = "name_tag"
				p:addCustomInfo("Relay",p.name_tag,name_tag_text)
			end
			if p:hasPlayerAtPosition("Operations") then
				p.name_tag_ops = "name_tag_ops"
				p:addCustomInfo("Operations",p.name_tag_ops,name_tag_text)
			end
			if p:hasPlayerAtPosition("ShipLog") then
				p.name_tag_log = "name_tag_log"
				p:addCustomInfo("ShipLog",p.name_tag_log,name_tag_text)
			end
			if p:hasPlayerAtPosition("Helms") then
				p.name_tag_helm = "name_tag_helm"
				p:addCustomInfo("Helms",p.name_tag_helm,name_tag_text)
			end
			if p:hasPlayerAtPosition("Tactical") then
				p.name_tag_tac = "name_tag_tac"
				p:addCustomInfo("Tactical",p.name_tag_tac,name_tag_text)
			end
			if updateDiagnostic then print("update: valid player: inventory button") end
			if p.inventoryButton == nil then
				local goodCount = 0
				if p.goods ~= nil then
					for good, goodQuantity in pairs(p.goods) do
						goodCount = goodCount + 1
					end
				end
				if goodCount > 0 then		--add inventory button when cargo acquired
					if p:hasPlayerAtPosition("Relay") then
						if p.inventoryButton == nil then
							local tbi = "inventory" .. player_name
							p:addCustomButton("Relay",tbi,"Inventory",function () playerShipCargoInventory(p) end)
							p.inventoryButton = true
						end
					end
					if p:hasPlayerAtPosition("Operations") then
						if p.inventoryButton == nil then
							local tbi = "inventoryOp" .. player_name
							p:addCustomButton("Operations",tbi,"Inventory", function () playerShipCargoInventory(p) end)
							p.inventoryButton = true
						end
					end
					
				end
			end
			if updateDiagnostic then print("update: valid player: rendezvous point message") end
			if #rendezvousPoints > 0 then
				for _,rp in pairs(rendezvousPoints) do	--send rendezvous point message when applicable
					if rp.message == nil then
						rp.message = "sent"
						if p.rpMessage == nil then
							p.rpMessage = {}
						end
						rpCallSign = rp:getCallSign()
						if p.rpMessage[rpCallSign] == nil then
							p:addToShipLog(string.format("Coordinates for %s saved and ready for Engineering and Helm to transport",rpCallSign),"Green")
							p.rpMessage[rpCallSign] = "sent"
						end
					end
				end
			end
			if p:getSystemHealth("reactor") > p.max_reactor then
				p:setSystemHealth("reactor",p.max_reactor)
			end
			if p:getSystemHealth("beamweapons") > p.max_beam then
				p:setSystemHealth("beamweapons",p.max_beam)
			end
			if p:getSystemHealth("missilesystem") > p.max_missile then
				p:setSystemHealth("missilesystem",p.max_missile)
			end
			if p:getSystemHealth("maneuver") > p.max_maneuver then
				p:setSystemHealth("maneuver",p.max_maneuver)
			end
			if p:getSystemHealth("impulse") > p.max_impulse then
				p:setSystemHealth("impulse",p.max_impulse)
			end
			if p:getSystemHealth("warp") > p.max_warp then
				p:setSystemHealth("warp",p.max_warp)
			end
			if p:getSystemHealth("jumpdrive") > p.max_jump then
				p:setSystemHealth("jumpdrive",p.max_jump)
			end
			if p:getSystemHealth("frontshield") > p.max_front_shield then
				p:setSystemHealth("frontshield",p.max_front_shield)
			end
			if p:getSystemHealth("rearshield") > p.max_rear_shield then
				p:setSystemHealth("rearshield",p.max_rear_shield)
			end
			if updateDiagnostic then print("update: valid player: mortal repair crew") end
			if healthCheckTimer < 0 then	--check to see if any crew perish due to excessive damage
				if p:getRepairCrewCount() > 0 then
					local fatalityChance = 0
					local currentShield = 0
					if p:getShieldCount() > 1 then
						currentShield = (p:getSystemHealth("frontshield") + p:getSystemHealth("rearshield"))/2
					else
						currentShield = p:getSystemHealth("frontshield")
					end
					fatalityChance = fatalityChance + (p.prevShield - currentShield)
					p.prevShield = currentShield
					local currentReactor = p:getSystemHealth("reactor")
					fatalityChance = fatalityChance + (p.prevReactor - currentReactor)
					p.prevReactor = currentReactor
					local currentManeuver = p:getSystemHealth("maneuver")
					fatalityChance = fatalityChance + (p.prevManeuver - currentManeuver)
					p.prevManeuver = currentManeuver
					local currentImpulse = p:getSystemHealth("impulse")
					fatalityChance = fatalityChance + (p.prevImpulse - currentImpulse)
					p.prevImpulse = currentImpulse
					if p:getBeamWeaponRange(0) > 0 then
						if p.healthyBeam == nil then
							p.healthyBeam = 1.0
							p.prevBeam = 1.0
						end
						local currentBeam = p:getSystemHealth("beamweapons")
						fatalityChance = fatalityChance + (p.prevBeam - currentBeam)
						p.prevBeam = currentBeam
					end
					if p:getWeaponTubeCount() > 0 then
						if p.healthyMissile == nil then
							p.healthyMissile = 1.0
							p.prevMissile = 1.0
						end
						local currentMissile = p:getSystemHealth("missilesystem")
						fatalityChance = fatalityChance + (p.prevMissile - currentMissile)
						p.prevMissile = currentMissile
					end
					if p:hasWarpDrive() then
						if p.healthyWarp == nil then
							p.healthyWarp = 1.0
							p.prevWarp = 1.0
						end
						local currentWarp = p:getSystemHealth("warp")
						fatalityChance = fatalityChance + (p.prevWarp - currentWarp)
						p.prevWarp = currentWarp
					end
					if p:hasJumpDrive() then
						if p.healthyJump == nil then
							p.healthyJump = 1.0
							p.prevJump = 1.0
						end
						local currentJump = p:getSystemHealth("jumpdrive")
						fatalityChance = fatalityChance + (p.prevJump - currentJump)
						p.prevJump = currentJump
					end
					if p:getRepairCrewCount() == 1 then
						fatalityChance = fatalityChance/2	-- increase survival chances of last repair crew standing
					end
					if fatalityChance > 0 then
						if math.random() < (fatalityChance) then
							if p.initialCoolant == nil then
								p:setRepairCrewCount(p:getRepairCrewCount() - 1)
								if p:hasPlayerAtPosition("Engineering") then
									local repairCrewFatality = "repairCrewFatality"
									p:addCustomMessage("Engineering",repairCrewFatality,"One of your repair crew has perished")
								end
								if p:hasPlayerAtPosition("Engineering+") then
									local repairCrewFatalityPlus = "repairCrewFatalityPlus"
									p:addCustomMessage("Engineering+",repairCrewFatalityPlus,"One of your repair crew has perished")
								end
							else
								if random(1,100) < 50 then
									p:setRepairCrewCount(p:getRepairCrewCount() - 1)
									if p:hasPlayerAtPosition("Engineering") then
										local repairCrewFatality = "repairCrewFatality"
										p:addCustomMessage("Engineering",repairCrewFatality,"One of your repair crew has perished")
									end
									if p:hasPlayerAtPosition("Engineering+") then
										local repairCrewFatalityPlus = "repairCrewFatalityPlus"
										p:addCustomMessage("Engineering+",repairCrewFatalityPlus,"One of your repair crew has perished")
									end
								else
									local current_coolant = p:getMaxCoolant()
									local lost_coolant = 0
									if current_coolant >= 10 then
										lost_coolant = current_coolant*random(.25,.5)	--lose between 25 and 50 percent
									else
										lost_coolant = current_coolant*random(.15,.35)	--lose between 15 and 35 percent
									end
									p:setMaxCoolant(current_coolant - lost_coolant)
									if p.reclaimable_coolant == nil then
										p.reclaimable_coolant = 0
									end
									p.reclaimable_coolant = math.min(20,p.reclaimable_coolant + lost_coolant*random(.8,1))
									if p:hasPlayerAtPosition("Engineering") then
										local coolantLoss = "coolantLoss"
										p:addCustomMessage("Engineering",coolantLoss,"Damage has caused a loss of coolant")
									end
									if p:hasPlayerAtPosition("Engineering+") then
										local coolantLossPlus = "coolantLossPlus"
										p:addCustomMessage("Engineering+",coolantLossPlus,"Damage has caused a loss of coolant")
									end
								end	--coolant loss branch
							end	--could lose coolant branch
						end	--bad consequences of damage branch
					end	--possible chance of bad consequences branch
				else	--no repair crew left
					if random(1,100) <= 4 then
						p:setRepairCrewCount(1)
						if p:hasPlayerAtPosition("Engineering") then
							local repairCrewRecovery = "repairCrewRecovery"
							p:addCustomMessage("Engineering",repairCrewRecovery,"Medical team has revived one of your repair crew")
						end
						if p:hasPlayerAtPosition("Engineering+") then
							local repairCrewRecoveryPlus = "repairCrewRecoveryPlus"
							p:addCustomMessage("Engineering+",repairCrewRecoveryPlus,"Medical team has revived one of your repair crew")
						end
						resetPreviousSystemHealth(p)
					end	--medical science triumph branch
				end	--no repair crew left
				if p.initialCoolant ~= nil then
					current_coolant = p:getMaxCoolant()
					if current_coolant < 20 then
						if random(1,100) <= 4 then
							local reclaimed_coolant = 0
							if p.reclaimable_coolant ~= nil and p.reclaimable_coolant > 0 then
								reclaimed_coolant = p.reclaimable_coolant*random(.1,.5)	--get back 10 to 50 percent of reclaimable coolant
								p:setMaxCoolant(math.min(20,current_coolant + reclaimed_coolant))
								p.reclaimable_coolant = p.reclaimable_coolant - reclaimed_coolant
							end
							if reclaimed_coolant > 0 then
								if p:hasPlayerAtPosition("Engineering") then
									local coolant_recovery = "coolant_recovery"
									p:addCustomMessage("Engineering",coolant_recovery,"Automated systems have recovered some coolant")
								end
								if p:hasPlayerAtPosition("Engineering+") then
									local coolant_recovery_plus = "coolant_recovery_plus"
									p:addCustomMessage("Engineering+",coolant_recovery_plus,"Automated systems have recovered some coolant")
								end
							end
							resetPreviousSystemHealth(p)
						end
					end
				end
			end	--health check branch
			if p.expedite_dock then
				if p.expedite_dock_timer == nil then
					p.expedite_dock_timer = p.expedite_dock_timer_max + delta
				end
				p.expedite_dock_timer = p.expedite_dock_timer - delta
				if p.expedite_dock_timer < 0 then
					if p.expedite_dock_timer < -1 then
						if p.expedite_dock_timer_info ~= nil then
							p:removeCustom(p.expedite_dock_timer_info)
							p.expedite_dock_timer_info = nil
						end
						if p.expedite_dock_timer_info_ops ~= nil then
							p:removeCustom(p.expedite_dock_timer_info_ops)
							p.expedite_dock_timer_info_ops = nil
						end
--						p:addToShipLog(string.format("Docking crew of station %s returned to their normal duties",p.expedite_doc_station:getCallSign()),"Yellow")
						p:addToShipLog("Docking crew of station returned to their normal duties","Yellow")
						p.expedite_dock = nil
						p.expedite_timer = nil
						p.expedite_dock_station = nil
						p.preorder_hvli = nil
						p.preorder_homing = nil
						p.preorder_emp = nil
						p.preorder_nuke = nil
						p.preorder_repair_crew = nil
						p.preorder_coolant = nil
					else
						if p:hasPlayerAtPosition("Relay") then
							p.expedite_dock_timer_info = "expedite_dock_timer_info"
							p:addCustomInfo("Relay",p.expedite_dock_timer_info,"Fast Dock Expired")						
						end
						if p:hasPlayerAtPosition("Operations") then
							p.expedite_dock_timer_info_ops = "expedite_dock_timer_info_ops"
							p:addCustomInfo("Relay",p.expedite_dock_timer_info_ops,"Fast Dock Expired")						
						end
					end
				else	--timer not expired
					local expedite_dock_timer_status = "Fast Dock"
					local expedite_dock_timer_minutes = math.floor(p.expedite_dock_timer / 60)
					local expedite_dock_timer_seconds = math.floor(p.expedite_dock_timer % 60)
					if expedite_dock_timer_minutes <= 0 then
						expedite_dock_timer_status = string.format("%s %i",expedite_dock_timer_status,expedite_dock_timer_seconds)
					else
						expedite_dock_timer_status = string.format("%s %i:%.2i",expedite_dock_timer_status,expedite_dock_timer_minutes,expedite_dock_timer_seconds)
					end
					if p:hasPlayerAtPosition("Relay") then
						p.expedite_dock_timer_info = "expedite_dock_timer_info"
						p:addCustomInfo("Relay",p.expedite_dock_timer_info,expedite_dock_timer_status)
					end
					if p:hasPlayerAtPosition("Operations") then
						p.expedite_dock_timer_info_ops = "expedite_dock_timer_info_ops"
						p:addCustomInfo("Operations",p.expedite_dock_timer_info_ops,expedite_dock_timer_status)
					end					
				end
				if p.expedite_dock_station ~= nil and p.expedite_dock_station:isValid() then
					if p:isDocked(p.expedite_dock_station) then
						p:setEnergy(p:getMaxEnergy())
						p:setScanProbeCount(p:getMaxScanProbeCount())
						if p.preorder_hvli ~= nil then
							local new_amount = math.min(p:getWeaponStorage("HVLI") + p.preorder_hvli,p:getWeaponStorageMax("HVLI"))
							p:setWeaponStorage("HVLI",new_amount)
						end
						if p.preorder_homing ~= nil then
							new_amount = math.min(p:getWeaponStorage("Homing") + p.preorder_homing,p:getWeaponStorageMax("Homing"))
							p:setWeaponStorage("Homing",new_amount)
						end
						if p.preorder_mine ~= nil then
							new_amount = math.min(p:getWeaponStorage("Mine") + p.preorder_mine,p:getWeaponStorageMax("Mine"))
							p:setWeaponStorage("Mine",new_amount)
						end
						if p.preorder_emp ~= nil then
							new_amount = math.min(p:getWeaponStorage("EMP") + p.preorder_emp,p:getWeaponStorageMax("EMP"))
							p:setWeaponStorage("EMP",new_amount)
						end
						if p.preorder_nuke ~= nil then
							new_amount = math.min(p:getWeaponStorage("Nuke") + p.preorder_nuke,p:getWeaponStorageMax("Nuke"))
							p:setWeaponStorage("Nuke",new_amount)
						end
						if p.preorder_repair_crew ~= nil then
							p:setRepairCrewCount(p:getRepairCrewCount() + 1)
							resetPreviousSystemHealth(p)
						end
						if p.preorder_coolant ~= nil then
							p:setMaxCoolant(p:getMaxCoolant() + 2)
						end
						if p.expedite_dock_timer_info ~= nil then
							p:removeCustom(p.expedite_dock_timer_info)
							p.expedite_dock_timer_info = nil
						end
						if p.expedite_dock_timer_info_ops ~= nil then
							p:removeCustom(p.expedite_dock_timer_info_ops)
							p.expedite_dock_timer_info_ops = nil
						end
						p:addToShipLog(string.format("Docking crew at station %s completed replenishment as requested",p.expedite_dock_station:getCallSign()),"Yellow")
						p.expedite_dock = nil
						p.expedite_timer = nil
						p.expedite_dock_station = nil
						p.preorder_hvli = nil
						p.preorder_homing = nil
						p.preorder_emp = nil
						p.preorder_nuke = nil
						p.preorder_repair_crew = nil
						p.preorder_coolant = nil
					end
				end
			end
			if timer_started then
				if timer_value < 0 then	--timer expired
					if timer_value < -1 then	--timer expired condition expired
						if p.timer_helm ~= nil then
							p:removeCustom(p.timer_helm)
							p.timer_helm = nil
						end
						if p.timer_weapons ~= nil then
							p:removeCustom(p.timer_weapons)
							p.timer_weapons = nil
						end
						if p.timer_engineer ~= nil then
							p:removeCustom(p.timer_engineer)
							p.timer_engineer = nil
						end
						if p.timer_science ~= nil then
							p:removeCustom(p.timer_science)
							p.timer_science = nil
						end
						if p.timer_relay ~= nil then
							p:removeCustom(p.timer_relay)
							p.timer_relay = nil
						end
						if p.timer_tactical ~= nil then
							p:removeCustom(p.timer_tactical)
							p.timer_tactical = nil
						end
						if p.timer_operations ~= nil then
							p:removeCustom(p.timer_operations)
							p.timer_operations = nil
						end
						if p.timer_engineer_plus ~= nil then
							p:removeCustom(p.timer_engineer_plus)
							p.timer_engineer_plus = nil
						end
						timer_started = false
						timer_value = nil
						timer_gm_message = nil
					else	--timer expired (less than 0 but not less than -1)
						local final_status = timer_purpose .. " Expired"
						if timer_gm_message == nil then
							timer_gm_message = "sent"
							addGMMessage(final_status)
						end
						if timer_display_helm then
							if p:hasPlayerAtPosition("Helms") then
								p.timer_helm = "timer_helm"
								p:addCustomInfo("Helms",p.timer_helm,final_status)
							end
							if p:hasPlayerAtPosition("Tactical") then
								p.timer_tactical = "timer_tactical"
								p:addCustomInfo("Tactical",p.timer_tactical,final_status)
							end
						end
						if timer_display_weapons then
							if p:hasPlayerAtPosition("Weapons") then
								p.timer_weapons = "timer_weapons"
								p:addCustomInfo("Weapons",p.timer_weapons,final_status)
							end
							if p:hasPlayerAtPosition("Tactical") and p.timer_tactical == nil then
								p.timer_tactical = "timer_tactical"
								p:addCustomInfo("Tactical",p.timer_tactical,final_status)
							end
						end
						if timer_display_engineer then
							if p:hasPlayerAtPosition("Engineering") then
								p.timer_engineer = "timer_engineer"
								p:addCustomInfo("Engineering",p.timer_engineer,final_status)
							end
							if p:hasPlayerAtPosition("Engineering+") then
								p.timer_engineer_plus = "timer_engineer_plus"
								p:addCustomInfo("Engineering+",p.timer_engineer_plus,final_status)
							end
						end
						if timer_display_science then
							if p:hasPlayerAtPosition("Science") then
								p.timer_science = "timer_science"
								p:addCustomInfo("Science",p.timer_science,final_status)
							end
							if p:hasPlayerAtPosition("Operations") then
								p.timer_operations = "timer_operations"
								p:addCustomInfo("Operations",p.timer_operations,final_status)
							end
						end
						if timer_display_relay then
							if p:hasPlayerAtPosition("Relay") then
								p.timer_relay = "timer_relay"
								p:addCustomInfo("Relay",p.timer_relay,final_status)
							end
							if p:hasPlayerAtPosition("Operations") and p.timer_operations == nil then
								p.timer_operations = "timer_operations"
								p:addCustomInfo("Operations",p.timer_operations,final_status)
							end
						end	--relay timer display final status
					end	--end of timer value less than -1 checks
				else	--time has not yet expired
					local timer_status = timer_purpose
					local timer_minutes = math.floor(timer_value / 60)
					local timer_seconds = math.floor(timer_value % 60)
					if timer_minutes <= 0 then
						timer_status = string.format("%s %i",timer_status,timer_seconds)
					else
						timer_status = string.format("%s %i:%.2i",timer_status,timer_minutes,timer_seconds)
					end
					if timer_display_helm then
						if p:hasPlayerAtPosition("Helms") then
							p.timer_helm = "timer_helm"
							p:addCustomInfo("Helms",p.timer_helm,timer_status)
						end
						if p:hasPlayerAtPosition("Tactical") then
							p.timer_tactical = "timer_tactical"
							p:addCustomInfo("Tactical",p.timer_tactical,timer_status)
						end
					end
					if timer_display_weapons then
						if p:hasPlayerAtPosition("Weapons") then
							p.timer_weapons = "timer_weapons"
							p:addCustomInfo("Weapons",p.timer_weapons,timer_status)
						end
						if p:hasPlayerAtPosition("Tactical") and p.timer_tactical == nil then
							p.timer_tactical = "timer_tactical"
							p:addCustomInfo("Tactical",p.timer_tactical,timer_status)
						end
					end
					if timer_display_engineer then
						if p:hasPlayerAtPosition("Engineering") then
							p.timer_engineer = "timer_engineer"
							p:addCustomInfo("Engineering",p.timer_engineer,timer_status)
						end
						if p:hasPlayerAtPosition("Engineering+") then
							p.timer_engineer_plus = "timer_engineer_plus"
							p:addCustomInfo("Engineering+",p.timer_engineer_plus,timer_status)
						end
					end
					if timer_display_science then
						if p:hasPlayerAtPosition("Science") then
							p.timer_science = "timer_science"
							p:addCustomInfo("Science",p.timer_science,timer_status)
						end
						if p:hasPlayerAtPosition("Operations") then
							p.timer_operations = "timer_operations"
							p:addCustomInfo("Operations",p.timer_operations,timer_status)
						end
					end
					if timer_display_relay then
						if p:hasPlayerAtPosition("Relay") then
							p.timer_relay = "timer_relay"
							p:addCustomInfo("Relay",p.timer_relay,timer_status)
						end
						if p:hasPlayerAtPosition("Operations") and p.timer_operations == nil then
							p.timer_operations = "timer_operations"
							p:addCustomInfo("Operations",p.timer_operations,timer_status)
						end
					end	--end relay timer display
				end	--end of timer started boolean checks
			else	--timer started boolean is false
				if p.timer_helm ~= nil then
					p:removeCustom(p.timer_helm)
					p.timer_helm = nil
				end
				if p.timer_weapons ~= nil then
					p:removeCustom(p.timer_weapons)
					p.timer_weapons = nil
				end
				if p.timer_engineer ~= nil then
					p:removeCustom(p.timer_engineer)
					p.timer_engineer = nil
				end
				if p.timer_science ~= nil then
					p:removeCustom(p.timer_science)
					p.timer_science = nil
				end
				if p.timer_relay ~= nil then
					p:removeCustom(p.timer_relay)
					p.timer_relay = nil
				end
				if p.timer_tactical ~= nil then
					p:removeCustom(p.timer_tactical)
					p.timer_tactical = nil
				end
				if p.timer_operations ~= nil then
					p:removeCustom(p.timer_operations)
					p.timer_operations = nil
				end
				if p.timer_engineer_plus ~= nil then
					p:removeCustom(p.timer_engineer_plus)
					p.timer_engineer_plus = nil
				end
				timer_value = nil
				timer_gm_message = nil
			end	--end of timer started boolean checks
			if p.normal_long_range_radar == nil then
				p.normal_long_range_radar = p:getLongRangeRadarRange()
			end
			if regionStations ~= nil then
				local free_sensor_boost = false
				local sensor_boost_present = false
				local sensor_boost_amount = 0
				for i=1,#regionStations do
					local sensor_station = regionStations[i]
					if p:isDocked(sensor_station) then
						if sensor_station.comms_data.sensor_boost ~= nil then
							sensor_boost_present = true
							if sensor_station.comms_data.sensor_boost.cost < 1 then
								free_sensor_boost = true
							end
							sensor_boost_amount = sensor_station.comms_data.sensor_boost.value
						end
					end
				end
				if p:isDocked(stationIcarus) then
					free_sensor_boost = true
					sensor_boost_amount = stationIcarus.comms_data.sensor_boost.value
				end
				if stationKentar ~= nil then
					if p:isDocked(stationKentar) then
						free_sensor_boost = true
						sensor_boost_amount = stationKentar.comms_data.sensor_boost.value
					end
				end
				local boosted_range = p.normal_long_range_radar + sensor_boost_amount
				if sensor_boost_present or free_sensor_boost then
					if free_sensor_boost then
						if p:getLongRangeRadarRange() < boosted_range then
							p:setLongRangeRadarRange(boosted_range)
						end
					end
				else
					if p:getLongRangeRadarRange() > p.normal_long_range_radar then
						local temp_player = PlayerSpaceship():setTemplate("Atlantis"):setFaction("Human Navy")
						local science_swap = false
						if p:hasPlayerAtPosition("Science") then
							science_swap = true
							p:transferPlayersAtPositionToShip("Science",temp_player)
						end
						p:setLongRangeRadarRange(p.normal_long_range_radar)
						if science_swap then
							temp_player:transferPlayersAtPositionToShip("Science",p)
						end
						temp_player:destroy()
					end
				end
			end
			local vx, vy = p:getVelocity()
			local dx=math.abs(vx)
			local dy=math.abs(vy)
			local player_velocity = math.sqrt((dx*dx)+(dy*dy))
			local cpx, cpy = p:getPosition()
			local nearby_objects = p:getObjectsInRange(1000)
			if p.tractor then
				if player_velocity < 1 then
					--print(string.format("%s velocity: %.1f slow enough to establish tractor",player_name,player_velocity))
					if p.tractor_target_lock then
						if p.tractor_target ~= nil and p.tractor_target:isValid() then
							p.tractor_target:setPosition(cpx+p.tractor_vector_x,cpy+p.tractor_vector_y)
							p:setEnergy(p:getEnergy() - p:getMaxEnergy()*tractor_drain)
							if random(1,100) < 27 then
								BeamEffect():setSource(p,0,0,0):setTarget(p.tractor_target,0,0):setDuration(1):setRing(false):setTexture(tractor_beam_string[math.random(1,#tractor_beam_string)])
							end
							if p.disengage_tractor_button == nil then
								p.disengage_tractor_button = "disengage_tractor_button"
								p:addCustomButton("Engineering",p.disengage_tractor_button,"Disengage Tractor",function()
									p.tractor_target_lock = false
									p:removeCustom(p.disengage_tractor_button)
									p.disengage_tractor_button = nil
								end)
							end
						else
							p.tractor_target_lock = false
							p:removeCustom(p.disengage_tractor_button)
							p.disengage_tractor_button = nil
						end
					else	--tractor not locked on target
						local tractor_objects = {}
						if nearby_objects ~= nil and #nearby_objects > 1 then
							for _, obj in ipairs(nearby_objects) do
								if p ~= obj then
									local object_type = obj.typeName
									if object_type ~= nil then
										if object_type == "Asteroid" or object_type == "CpuShip" or object_type == "Artifact" or object_type == "PlayerSpaceship" or object_type == "WarpJammer" or object_type == "Mine" or object_type == "ScanProbe" or object_type == "VisualAsteroid" then
											table.insert(tractor_objects,obj)
										end
									end
								end
							end		--end of nearby object list loop
							if #tractor_objects > 0 then
								--print(string.format("%i tractorable objects under 1 unit away",#tractor_objects))
								if p.tractor_target ~= nil and p.tractor_target:isValid() then
									local target_in_list = false
									for i=1,#tractor_objects do
										if tractor_objects[i] == p.tractor_target then
											target_in_list = true
											break
										end
									end		--end of check for the current target in list loop
									if not target_in_list then
										p.tractor_target = tractor_objects[1]
										removeTractorObjectButtons(p)
									end
								else
									p.tractor_target = tractor_objects[1]
								end
								addTractorObjectButtons(p,tractor_objects)
							else	--no nearby tractorable objects
								if p.tractor_target ~= nil then
									removeTractorObjectButtons(p)
									p.tractor_target = nil
								end
							end
						else	--no nearby objects
							if p.tractor_target ~= nil then
								removeTractorObjectButtons(p)
								p.tractor_target = nil
							end
						end
					end
				else	--not moving slowly enough to establish tractor
					removeTractorObjectButtons(p)
					--print(string.format("%s velocity: %.1f too fast to establish tractor",player_name,player_velocity))
					if player_velocity > 50 then
						--print(string.format("%s velocity: %.1f too fast to continue tractor",player_name,player_velocity))
						p.tractor_target_lock = false
						if p.disengage_tractor_button ~= nil then
							p:removeCustom(p.disengage_tractor_button)
							p.disengage_tractor_button = nil
						end
					else
						if p.tractor_target_lock then
							if p.tractor_target ~= nil and p.tractor_target:isValid() then
								p.tractor_target:setPosition(cpx+p.tractor_vector_x,cpy+p.tractor_vector_y)
								p:setEnergy(p:getEnergy() - p:getMaxEnergy()*tractor_drain)
								if random(1,100) < 27 then
									BeamEffect():setSource(p,0,0,0):setTarget(p.tractor_target,0,0):setDuration(1):setRing(false):setTexture(tractor_beam_string[math.random(1,#tractor_beam_string)])
								end
								if p.disengage_tractor_button == nil then
									p.disengage_tractor_button = "disengage_tractor_button"
									p:addCustomButton("Engineering",p.disengage_tractor_button,"Disengage Tractor",function()
										p.tractor_target_lock = false
										p:removeCustom(p.disengage_tractor_button)
										p.disengage_tractor_button = nil
									end)
								end
							else	--invalid tractor target
								p.tractor_target_lock = false
								p:removeCustom(p.disengage_tractor_button)
								p.disengage_tractor_button = nil
							end
						end		--end of tractor lock processing				
					end		--end of player moving slow enough to tractor branch
				end		--end of speed checks for tractoring
			end		--end of tractor checks
			if p.mining and p.cargo > 0 then
				if player_velocity < 10 then
					if p.mining_target_lock then
						if p.mining_target ~= nil and p.mining_target:isValid() then
							if p.mining_in_progress then
								p.mining_timer = p.mining_timer - delta
								if p.mining_timer < 0 then
									p.mining_in_progress = false
									if p.mining_timer_info ~= nil then
										p:removeCustom(p.mining_timer_info)
										p.mining_timer_info = nil
									end
									p.mining_target_lock = false
									p.mining_timer = nil
									if #p.mining_target.trace_minerals > 0 then
										local good = p.mining_target.trace_minerals[math.random(1,#p.mining_target.trace_minerals)]
										if p.goods == nil then
											p.goods = {}
										end
										if p.goods[good] == nil then
											p.goods[good] = 0
										end
										p.goods[good] = p.goods[good] + 1
										p.cargo = p.cargo - 1
										if p:hasPlayerAtPosition("Science") then
											local mined_mineral_message = "mined_mineral_message"
											p:addCustomMessage("Science",mined_mineral_message,string.format("Mining obtained %s which has been stored in the cargo hold",good))
										end
									else	--no minerals in asteroid
										if p:hasPlayerAtPosition("Science") then
											local mined_mineral_message = "mined_mineral_message"
											p:addCustomMessage("Science",mined_mineral_message,"mining failed to extract any minerals")
										end										
									end
								else	--still mining, update timer display, energy and heat
									p:setEnergy(p:getEnergy() - p:getMaxEnergy()*mining_drain)
									p:setSystemHeat("beamweapons",p:getSystemHeat("beamweapons") + .0025)
									local mining_seconds = math.floor(p.mining_timer % 60)
									if random(1,100) < 38 then
										BeamEffect():setSource(p,0,0,0):setTarget(p.mining_target,0,0):setRing(false):setDuration(1):setTexture(mining_beam_string[math.random(1,#mining_beam_string)])
									end
									if p:hasPlayerAtPosition("Weapons") then
										p.mining_timer_info = "mining_timer_info"
										p:addCustomInfo("Weapons",p.mining_timer_info,string.format("Mining %i",mining_seconds))
									end
								end
							else	--mining not in progress
								if p.trigger_mine_beam_button == nil then
									if p:hasPlayerAtPosition("Weapons") then
										p.trigger_mine_beam_button = "trigger_mine_beam_button"
										p:addCustomButton("Weapons",p.trigger_mine_beam_button,"Start Mining",function()
											p.mining_in_progress = true
											p.mining_timer = delta + 5
											p:removeCustom(p.trigger_mine_beam_button)
											p.trigger_mine_beam_button = nil
										end)
									end
								end
							end
						else	--no mining target or mining target invalid
							p.mining_target_lock = false
							if p.mining_timer_info ~= nil then
								p:removeCustom(p.mining_timer_info)
								p.mining_timer_info = nil
							end
						end
					else	--not locked
						local mining_objects = {}
						if nearby_objects ~= nil and #nearby_objects > 1 then
							for _, obj in ipairs(nearby_objects) do
								if p ~= obj then
									local object_type = obj.typeName
									if object_type ~= nil then
										if object_type == "Asteroid" or object_type == "VisualAsteroid" then
											table.insert(mining_objects,obj)
										end
									end
								end
							end		--end of nearby object list loop
							if #mining_objects > 0 then
								if p.mining_target ~= nil and p.mining_target:isValid() then
									local target_in_list = false
									for i=1,#mining_objects do
										if mining_objects[i] == p.mining_target then
											target_in_list = true
											break
										end
									end		--end of check for the current target in list loop
									if not target_in_list then
										p.mining_target = mining_objects[1]
										removeMiningButtons(p)
									end
								else
									p.mining_target = mining_objects[1]
								end
								addMiningButtons(p,mining_objects)
							else	--no mining objects
								if p.mining_target ~= nil then
									removeMiningButtons(p)
									p.mining_target = nil
								end
							end
						else	--no nearby objects
							if p.mining_target ~= nil then
								removeMiningButtons(p)
								p.mining_target = nil
							end
						end
					end
				else	--not moving slowly enough to mine
					removeMiningButtons(p)
					if p.mining_timer_info ~= nil then
						p:removeCustom(p.mining_timer_info)
						p.mining_timer_info = nil
					end
					if p.trigger_mine_beam_button then
						p:removeCustom(p.trigger_mine_beam_button)
						p.trigger_mine_beam_button = nil
					end
					p.mining_target_lock = false
					p.mining_in_progress = false
					p.mining_timer = nil
				end
			end
			if updateDiagnostic then print("update: end of player loop") end
		end	--player loop
	end
	if updateDiagnostic then print("update: outside player loop") end
	if healthCheckTimer < 0 then
		healthCheckTimer = delta + healthCheckTimerInterval
	end
	if plotRevert ~= nil then
		plotRevert(delta)
	end
	if plotMobile ~= nil then
		plotMobile(delta)
	end
	if plotPulse ~= nil then
		plotPulse(delta)
	end
	if updateDiagnostic then print("update: end of update function") end
end
function update(delta)
	wrapFunctionInPcall(updateInner,delta)
end
onNewPlayerShip(assignPlayerShipScore)