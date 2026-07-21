/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\vehicles\apc_rus.gsc
***********************************************/

apc_rus_init() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_86510C82737817CD40B38B720A15", 1);
  var_0._id_13FCA = ::c4_crate_player_at_max_ammo;
  var_0.destroycallback = ::apc_rus_explode;
  apc_rus_initoccupancy();
  apc_rus_initinteract();
  c130deliveriesinprogress();
  c130airdrop_startdelivery();
  c130airdrop_spawn();
  apc_rus_initfx();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_86510C82737817CD40B38B720A15", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_86510C82737817CD40B38B720A15", "_encstr_88C5055208731B")]]();

  apc_rus_initspawning();
  apc_rus_initlate();
}

apc_rus_initlate() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_86510C82737817CD40B38B720A15", "_encstr_BAF609D2739647C4853A2B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_86510C82737817CD40B38B720A15", "_encstr_BAF609D2739647C4853A2B")]]();
}

apc_rus_initoccupancy() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("_encstr_86510C82737817CD40B38B720A15", 1);
  var_0.enterendcallback = ::apc_rus_enterend;
  var_0.exitstartcallback = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = ::apc_rus_exitend;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getpassivepassengerrestrictions();
  var_0.exitextents["_encstr_AA5606FD1AF05085"] = 136;
  var_0.exitextents["_encstr_B69B0589C236B6"] = 129;
  var_0.exitextents["_encstr_A5AD056A019C63"] = 68;
  var_0.exitextents["_encstr_8253060E2B5FE330"] = 68;
  var_0.exitextents["_encstr_AC190479FF92"] = 87;
  var_0.exitextents["_encstr_A146078E65FB5158DD"] = 0;
  var_1 = "_encstr_AA5606FD1AF05085";
  var_0.exitoffsets[var_1] = (100, 0, 65);
  var_0.exitdirections[var_1] = "_encstr_8253060E2B5FE330";
  var_1 = "_encstr_AF610CB24855FB7558C7ECED5D38";
  var_0.exitoffsets[var_1] = (-31, 14, 65);
  var_0.exitdirections[var_1] = "_encstr_A5AD056A019C63";
  var_1 = "_encstr_91EC0DAD4B462363AC7D4E4BCE863A";
  var_0.exitoffsets[var_1] = (-31, -20, 65);
  var_0.exitdirections[var_1] = "_encstr_8253060E2B5FE330";
  var_1 = "_encstr_974E0A4CB0D85BAFD895998E";
  var_0.exitoffsets[var_1] = (-90, 35, 65);
  var_0.exitdirections[var_1] = "_encstr_B69B0589C236B6";
  var_1 = "_encstr_BE360B4C0B36B5FA4E5AB386A3";
  var_0.exitoffsets[var_1] = (-90, -35, 65);
  var_0.exitdirections[var_1] = "_encstr_B69B0589C236B6";
  var_0.damagemodifier = 0;
  var_0.hideoccupant = 1;
  var_0.camera = "_encstr_B84A15276B1151D6D05897DC5189184AF6A7A79BDF4DCB";
  var_0.damagefeedbackgrouplight = "_encstr_AF1904A7F929";
  var_0.damagefeedbackgroupheavy = "_encstr_AF1904A7F929";
  var_2 = ["_encstr_9AE307B956E345D0AB", "_encstr_8FEE0C6E10B7CB6067CD678F0CE3", "_encstr_BE360B4C0B36B5FA4E5AB386A3", "_encstr_B69B0589C236B6", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_AB0A0B99C9DBB98EAFC69533E8"];
  var_3 = "_encstr_9AE307B956E345D0AB";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_86510C82737817CD40B38B720A15", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_AF610CB24855FB7558C7ECED5D38", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_91EC0DAD4B462363AC7D4E4BCE863A", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (80, 14, 65);
  var_0.exitdirections[var_3] = "_encstr_A5AD056A019C63";
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_4.restrictions = scripts\engine\utility::array_remove(var_4.restrictions, "_encstr_88780599B4E495");
  var_4.viewclamps["_encstr_AC190479FF92"] = 30;
  var_4.viewclamps["_encstr_A146078E65FB5158DD"] = 10;
  var_4.viewclamps["_encstr_A5AD056A019C63"] = 180;
  var_4.viewclamps["_encstr_8253060E2B5FE330"] = 180;
  var_4.animtag = "_encstr_A10D0BA3B27F17C327D98568E0";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.spawnpriority = 10;
  var_4._id_13E8A = getcompleteweaponname("_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07");
  var_4._id_12023 = "_encstr_88F11407A573CEBED9B2A196D863ACD7329C5AB3CAC9";
  var_3 = "_encstr_AB0A0B99C9DBB98EAFC69533E8";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_86510C82737817CD40B38B720A15", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["_encstr_9AE307B956E345D0AB", "_encstr_AF610CB24855FB7558C7ECED5D38", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_91EC0DAD4B462363AC7D4E4BCE863A", "_encstr_AA5606FD1AF05085"];
  var_4.animtag = "_encstr_A70D0BFBD379B6D25977D3700A";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_3 = "_encstr_8FEE0C6E10B7CB6067CD678F0CE3";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_86510C82737817CD40B38B720A15", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["_encstr_91EC0DAD4B462363AC7D4E4BCE863A", "_encstr_BE360B4C0B36B5FA4E5AB386A3", "_encstr_AF610CB24855FB7558C7ECED5D38", "_encstr_AA5606FD1AF05085"];
  var_4.animtag = "_encstr_A30D0B30D3708180E951D37165";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_3 = "_encstr_974E0A4CB0D85BAFD895998E";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_86510C82737817CD40B38B720A15", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["_encstr_AF610CB24855FB7558C7ECED5D38", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_91EC0DAD4B462363AC7D4E4BCE863A", "_encstr_AA5606FD1AF05085"];
  var_4.animtag = "_encstr_930D0BB31F7F41CB11C81BAF42";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_3 = "_encstr_BE360B4C0B36B5FA4E5AB386A3";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_86510C82737817CD40B38B720A15", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["_encstr_91EC0DAD4B462363AC7D4E4BCE863A", "_encstr_BE360B4C0B36B5FA4E5AB386A3", "_encstr_AF610CB24855FB7558C7ECED5D38", "_encstr_AA5606FD1AF05085"];
  var_4.animtag = "_encstr_910D0BD951F7D19EB70A9BE647";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_3 = "_encstr_B69B0589C236B6";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_86510C82737817CD40B38B720A15", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["_encstr_974E0A4CB0D85BAFD895998E", "_encstr_BE360B4C0B36B5FA4E5AB386A3", "_encstr_AF610CB24855FB7558C7ECED5D38", "_encstr_91EC0DAD4B462363AC7D4E4BCE863A", "_encstr_AA5606FD1AF05085"];
  var_4.animtag = "_encstr_8F0D0BA3C2D9FA6EB216D1D7D4";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
}

apc_rus_initinteract() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("_encstr_86510C82737817CD40B38B720A15", 1);
  scripts\cp_mp\vehicles\vehicle_interact::_id_1419D("_encstr_86510C82737817CD40B38B720A15", "_encstr_BDDC07EBCCB5CA4BED", ["_encstr_9AE307B956E345D0AB", "_encstr_8FEE0C6E10B7CB6067CD678F0CE3", "_encstr_BE360B4C0B36B5FA4E5AB386A3", "_encstr_B69B0589C236B6", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_AB0A0B99C9DBB98EAFC69533E8"]);
}

c130airdrop_spawn() {
  var_0 = _calloutmarkerping_predicted_log::_id_1410F("_encstr_86510C82737817CD40B38B720A15", 1);
  var_0.challengeevaluator = 2.33333;
  var_0.keycardlocs_chosen = 0.66666;
  var_0.is_using_stealth_debug = 350;
  var_0.is_valid_station_name = 525;
  var_0.is_two_hit_melee_weapon = 875;
  var_0.isakimbomeleeweapon = 2.5;
  var_0.isallowedweapon = 10;
  var_0.isakimbo = 20;
  var_0.isattachmentgrenadelauncher = 0;
  var_0.isattachmentselectfire = 0;
  var_0.isassaulting = 0;
}

c130deliveriesinprogress() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::_id_1427E("_encstr_86510C82737817CD40B38B720A15", 1);
  var_0.id = 15;
  var_0.seatids["_encstr_9AE307B956E345D0AB"] = 0;
  var_0.seatids["_encstr_AB0A0B99C9DBB98EAFC69533E8"] = 1;
  var_0.seatids["_encstr_8FEE0C6E10B7CB6067CD678F0CE3"] = 2;
  var_0.seatids["_encstr_BE360B4C0B36B5FA4E5AB386A3"] = 4;
  var_0.seatids["_encstr_974E0A4CB0D85BAFD895998E"] = 3;
  var_0.seatids["_encstr_B69B0589C236B6"] = 5;
  var_0.brtruck_initdialog["_encstr_853D0D7723201E3266F18783A5856B"] = 0;
  var_0._id_12DA2["_encstr_99710849BABEAB60B3A0"] = 0;
  var_0._id_12DA2["_encstr_A7AF07D1EF1B06683C"] = 1;
  var_0._id_12DA3["_encstr_9AE307B956E345D0AB"]["_encstr_92B90BC2C11BBEE4AE6ED7AD0E"] = "_encstr_99710849BABEAB60B3A0";
  var_0._id_12DA3["_encstr_9AE307B956E345D0AB"]["_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07"] = "_encstr_A7AF07D1EF1B06683C";
  var_0._id_12DA3["_encstr_AB0A0B99C9DBB98EAFC69533E8"]["_encstr_92B90BC2C11BBEE4AE6ED7AD0E"] = "_encstr_99710849BABEAB60B3A0";
  var_0._id_12DA3["_encstr_AB0A0B99C9DBB98EAFC69533E8"]["_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07"] = "_encstr_A7AF07D1EF1B06683C";
  var_0._id_12DA3["_encstr_8FEE0C6E10B7CB6067CD678F0CE3"]["_encstr_92B90BC2C11BBEE4AE6ED7AD0E"] = "_encstr_99710849BABEAB60B3A0";
  var_0._id_12DA3["_encstr_8FEE0C6E10B7CB6067CD678F0CE3"]["_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07"] = "_encstr_A7AF07D1EF1B06683C";
  var_0._id_12DA3["_encstr_BE360B4C0B36B5FA4E5AB386A3"]["_encstr_92B90BC2C11BBEE4AE6ED7AD0E"] = "_encstr_99710849BABEAB60B3A0";
  var_0._id_12DA3["_encstr_BE360B4C0B36B5FA4E5AB386A3"]["_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07"] = "_encstr_A7AF07D1EF1B06683C";
  var_0._id_12DA3["_encstr_974E0A4CB0D85BAFD895998E"]["_encstr_92B90BC2C11BBEE4AE6ED7AD0E"] = "_encstr_99710849BABEAB60B3A0";
  var_0._id_12DA3["_encstr_974E0A4CB0D85BAFD895998E"]["_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07"] = "_encstr_A7AF07D1EF1B06683C";
  var_0._id_12DA3["_encstr_B69B0589C236B6"]["_encstr_92B90BC2C11BBEE4AE6ED7AD0E"] = "_encstr_99710849BABEAB60B3A0";
  var_0._id_12DA3["_encstr_B69B0589C236B6"]["_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07"] = "_encstr_A7AF07D1EF1B06683C";
}

c130airdrop_startdelivery() {
  var_0 = getdvarint("_encstr_82051B1F11A0DFE703E1AFCF71A90B4B79E93BB0CFAA2EC7437E4870CD", 4000);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1416C("_encstr_86510C82737817CD40B38B720A15", var_0);
  var_1 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("_encstr_86510C82737817CD40B38B720A15");
  var_1.class = "_encstr_81AC0C7BBD0B976247B0BAF26823";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1413D("_encstr_86510C82737817CD40B38B720A15");
  var_2 = getdvarint("_encstr_8DC91967E3E281C4AF99495362370B783B6BB7279E8F50963FC2C1", 18);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14178("_encstr_86510C82737817CD40B38B720A15", var_2);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14176("_encstr_86510C82737817CD40B38B720A15", ::apc_rus_premoddamagecallback);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14175("_encstr_86510C82737817CD40B38B720A15", ::c4_charge_detonate_think);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14171("_encstr_86510C82737817CD40B38B720A15", ::apc_rus_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1417B("_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07", 2);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1417B("_encstr_92B90BC2C11BBEE4AE6ED7AD0E", 5);
}

apc_rus_initfx() {
  level._effect["_encstr_8BF41062F0B7B9A3CBE607357B3383FDD120"] = loadfx("_encstr_A2932F6799F05EB4DD0EFAAD07CBD9560DA5C6C62BBCB3331ED739579B2C8336FAB6387D462B2C47867D2BC338713B660F");
  level._effect["_encstr_A5371487E14E098A58833187DA48AC429553F7FFB16D"] = loadfx("_encstr_8A5C3450A760E790CB9AF7608A808380BAA8D72939B00E557BC1A38D5FF988825F011B383DED4F4B49695B475AC549BB33ABD6EB26C3");
}

apc_rus_create(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  if(istrue(var_0.usealtmodel))
    var_0.modelname = "_encstr_8B782784220B586F5BF7CC8E63BAC33E1693888B48CB2133EA573845EB7CDF5FC4F1AF17AF0ACE67A0";
  else
    var_0.modelname = "_encstr_8E10221C7FA251F675B768F94B9E6967ABE498ADD46AD779715790B807BB80574381812F";

  var_0.targetname = "_encstr_86510C82737817CD40B38B720A15";
  var_0.vehicletype = "_encstr_95BD12672D73C8962C7D070D2F3796C637F56B38";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2))
    return undefined;

  var_3 = apc_rus_createturret(var_2, var_0);
  scripts\cp_mp\vehicles\vehicle::_id_14207(var_2, var_3, getcompleteweaponname("_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07"), 1);
  scripts\cp_mp\vehicles\vehicle::_id_14138(var_2, "_encstr_86510C82737817CD40B38B720A15", var_0);
  var_2.objweapon = getcompleteweaponname("_encstr_92B90BC2C11BBEE4AE6ED7AD0E");
  var_4 = scripts\cp_mp\vehicles\vehicle_damage::_id_1414C(var_2, 1);
  var_4.lb_mg_impulse_dmg_threshold_low = "_encstr_8BBA05185F8B99";
  var_4.lb_mg_dmg_factor_landing_gear = "_encstr_968B0DAD2DB11BBE2C1CB1D7275737";
  var_4.lb_mg_dmg_factor_main_rotor = 1;
  scripts\cp_mp\vehicles\vehicle::_id_14139(var_2, var_0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_2, undefined, scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);
  var_2 thread c130deliverydirection();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_86510C82737817CD40B38B720A15", "_encstr_8AEA073693CA16D12B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_86510C82737817CD40B38B720A15", "_encstr_8AEA073693CA16D12B")]](var_2);

  return var_2;
}

apc_rus_createturret(var_0, var_1) {
  var_2 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_0 gettagorigin("_encstr_99FE0B2B19086F6B9DC5D387E1"), "_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07", 0);
  var_2.angles = var_0 gettagangles("_encstr_99FE0B2B19086F6B9DC5D387E1");
  var_2 linkTo(var_0, "_encstr_99FE0B2B19086F6B9DC5D387E1", (0, 0, 0), (0, 0, 0));

  if(istrue(var_1.usealtmodel))
    var_2 setModel("_encstr_8389269BB5D98F4FB850935750F02CA18DDBE5972B7331B9CBF9CBE7D82BE5DB076CAFCA0DE7AAD0");
  else
    var_2 setModel("_encstr_864421D9951A70FAB64B36FA363719D767B437462DB0BE8513BE47AEC9C95947EBB5E0");

  var_2 setmode("_encstr_84FD0F03BB736BB3C36E7AF251911725E0");
  var_2 setsentryowner(undefined);
  var_2 makeunusable();
  var_2 setdefaultdroppitch(0);
  var_2 setturretmodechangewait(1);
  var_2.vehicle = var_0;
  return var_2;
}

apc_rus_explode(var_0, var_1) {
  if(isDefined(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8D85132BDECDEFA83B1EBF78435B6B4D630FB11BE3"))
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8D85132BDECDEFA83B1EBF78435B6B4D630FB11BE3")]](var_0.attacker);
  } else {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "_encstr_92B90BC2C11BBEE4AE6ED7AD0E";
    var_0.meansofdeath = "_encstr_B45C0E2DFF41B17F437FB870E733FBFF";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread apc_rus_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker) && isent(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_92B90BC2C11BBEE4AE6ED7AD0E");
    var_4 = scripts\engine\utility::ter_op(istrue(self.spawndata.usealtmodel), "_encstr_A5371487E14E098A58833187DA48AC429553F7FFB16D", "_encstr_8BF41062F0B7B9A3CBE607357B3383FDD120");
    playFX(scripts\engine\utility::getfx(var_4), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "_encstr_845C17E37758C9061BC78189CFF3C050F08A285EDFBD70C533");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

apc_rus_deletenextframe() {
  scripts\cp_mp\vehicles\vehicle::_id_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_86510C82737817CD40B38B720A15", "_encstr_A25F0710622DF3B3D7"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_86510C82737817CD40B38B720A15", "_encstr_A25F0710622DF3B3D7")]](self);

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_14186(self);
}

apc_rus_premoddamagecallback(var_0) {
  if(scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_isselfdamage(self, var_0))
    return 0;

  var_1 = self.origin - var_0.point;
  var_2 = anglestoup(self.angles);
  var_3 = vectordot(var_1, var_2);
  var_4 = var_0.point + var_2 * var_3;
  var_5 = vectorNormalize(var_4 - self.origin);
  var_6 = anglesToForward(self.angles);
  var_7 = anglestoright(self.angles);
  var_8 = getdvarfloat("_encstr_93DD1B373627AF3BCA0D5A8DD8CAA1C9968E4B1B586392AC2CC9117B47", -0.892);

  if(vectordot(var_5, var_6) < var_8)
    var_0.use_aitype = c130airdrop_managedrop(var_0);

  return 1;
}

c4_charge_detonate_think(var_0) {
  if(istrue(var_0.use_aitype))
    var_0.damage = int(var_0.damage * 1.6);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8CFC16C55190EE6B0DAFFAF3F1DFF72290CB5B4CC1507307"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8CFC16C55190EE6B0DAFFAF3F1DFF72290CB5B4CC1507307")]](var_0.attacker, var_0.damage);

  return 1;
}

apc_rus_deathcallback(var_0) {
  thread apc_rus_explode(var_0);
  return 1;
}

c130airdrop_managedrop(var_0) {
  if(isDefined(var_0.inflictor) && isDefined(var_0.inflictor.weapon_name) && var_0.inflictor.weapon_name == "_encstr_8A07035972")
    return isDefined(var_0.meansofdeath) && var_0.meansofdeath == "_encstr_911B0C7DA090E9A7F799FD50DD48";

  if(isDefined(var_0.objweapon) && isDefined(var_0.objweapon.basename)) {
    switch (var_0.objweapon.basename) {
      case "_encstr_B107148D23571AD42BA00B173943ADC34F4AD2C999A1":
      case "_encstr_81D911B12DB386D14716DC6DBE8EABE4F5ADE0":
        return isDefined(var_0.meansofdeath) && (var_0.meansofdeath == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F" || var_0.meansofdeath == "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9");
      case "_encstr_BE3E15E34720D111A7E99B2A62335DC84FA15D63C7DDF0":
      case "_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07":
      case "_encstr_B2C0155057B3262F92258D96F869792B0AA370E847451B":
      case "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8":
      case "_encstr_9B69114A571F8EBD17484FBA87220987C71A97":
      case "_encstr_8ABB134AEB113F41C8C180B2C79AB2FF83E7E7E51B":
      case "_encstr_8BD015B08BF0BF888F4F2D835BE311954F72E0A061FD59":
        return isDefined(var_0.meansofdeath) && var_0.meansofdeath == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F";
      case "_encstr_AD5210B0D388CF9573E1A8CF58B33C4120CA":
        return isDefined(var_0.meansofdeath) && var_0.meansofdeath == "_encstr_911B0C7DA090E9A7F799FD50DD48";
    }
  }

  return 0;
}

apc_rus_enterend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    apc_rus_enterendinternal(var_0, var_1, var_2, var_3, var_4);

  if(istrue(var_0.israllypointvehicle)) {
    foreach(var_6 in level.players) {
      if(istrue(var_0.revealed) || var_6.team == var_0.team)
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_0.marker.objidnum, var_6);
    }

    foreach(var_9 in var_0.occupants)
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_0.marker.objidnum, var_9);

    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_0.marker.objidnum, var_3);
  }
}

apc_rus_enterendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "_encstr_9AE307B956E345D0AB") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 cameradefault();
    var_3 controlslinkTo(var_0);
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(var_3, 0.1);
    var_5 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_0, "_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07");

    if(isDefined(var_5)) {
      var_5.owner = var_3;
      var_5 setotherent(var_3);
      var_5 setentityowner(var_3);
      var_5 setsentryowner(var_3);
      var_3 remotecontrolturret(var_5);
    }
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
  apc_rus_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);

  if(var_1 == "_encstr_9AE307B956E345D0AB")
    var_0 thread c130successfulairdrops(var_3);
}

apc_rus_exitend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    apc_rus_exitendinternal(var_0, var_1, var_2, var_3, var_4);
}

apc_rus_exitendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "_encstr_9AE307B956E345D0AB") {
    var_5 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_0, "_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07");

    if(isDefined(var_5))
      var_5.owner = undefined;

    var_0 setotherent(undefined);
    var_0 setentityowner(undefined);

    if(!istrue(var_4.playerdisconnect)) {
      if(isDefined(var_5)) {
        var_5 setturretdismountorg(var_3.origin);
        var_3 remotecontrolturretoff(var_5);
      }

      var_3 controlsunlink();
    }

    if(isDefined(var_5)) {
      var_5 setotherent(undefined);
      var_5 setentityowner(undefined);
      var_5 setsentryowner(undefined);
    }
  }

  if(!istrue(var_4.playerdisconnect)) {
    var_3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_stopanimatingplayer();
    var_6 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit(var_3, var_2, var_4);

    if(!var_6) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_AB651A9BD10B3961E7F16098EABC3951136A90811ECF60534E6AE840"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_AB651A9BD10B3961E7F16098EABC3951136A90811ECF60534E6AE840")]](var_3);
      else
        var_3 suicide();
    } else if(istrue(var_0.israllypointvehicle))
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_0.marker.objidnum, var_3);
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(var_0, var_1, var_2, var_3);
}

apc_rus_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_86510C82737817CD40B38B720A15", 1);
  var_0.maxinstancecount = 30;
  var_0.priority = 50;
  var_0.getspawnstructscallback = ::apc_rus_getspawnstructscallback;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_86510C82737817CD40B38B720A15", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784");
  var_0.clearancecheckradius = 150;
  var_0.clearancecheckheight = 135;
  var_0.clearancecheckminradius = 150;
}

apc_rus_getspawnstructscallback() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_92C211580E8D275DDCE62D2C73EB6EE00BBBB9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1)
      var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  return var_0;
}

c4_crate_player_at_max_ammo(var_0) {
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_updatemovefeedback("_encstr_9AE307B956E345D0AB");
}

c130deliverydirection() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_14192(self, "_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.shotsleft = 14;
  c4_crate_spawn();

  for(;;) {
    var_1 = var_0 scripts\engine\utility::_id_143AD("_encstr_BDBA0C4757C927CA477DCC5A4EAC", "_encstr_88BE0EEC1B3B5D9D6886F837997067AC");

    if(var_1 == "_encstr_88BE0EEC1B3B5D9D6886F837997067AC") {
      var_0.shotsleft = 0;
      c4_crate_spawn();
      c130airdrop_oncrateuse();
      continue;
    }

    c130airdrop_isnearotherdrop(-1);
    var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "_encstr_9AE307B956E345D0AB");

    if(var_0.shotsleft <= 0)
      c130airdrop_oncrateuse();
  }
}

c130airdrop_oncrateuse() {
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_14192(self, "_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07");
  var_0 turretfiredisable();
  var_1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "_encstr_9AE307B956E345D0AB");

  if(isDefined(var_1))
    var_1 playlocalsound("_encstr_8F8B188F054F9B19CAC533C45A0F19C773CAAABF217CFE3BECA8");

  foreach(var_3 in level.teamnamelist)
  self playsoundtoteam("_encstr_B48C184B3998E079B665FFE3B1EDC317A88105D5D1C88722975F", var_3, var_1);

  wait 2.7;
  c130airdrop_isnearotherdrop(14);
  wait 0.15;
  var_0 turretfireenable();
}

c130successfulairdrops(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = scripts\cp_mp\vehicles\vehicle::_id_14192(self, "_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07");

  if(isDefined(var_0)) {
    var_0 endon("_encstr_A68614E329B32F56F053FFCB61B05D4F6D06CB5A3115");
    var_0 endon("_encstr_939D1243D0687BBE49BDDFE381D6D34F7508A01B");
    var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

    while(var_0 isbnetkr15player())
      waitframe();

    var_2 = getdvarint("_encstr_923D0BEB217B114153E83CC451", 250) / 1000;

    for(;;) {
      var_3 = 0.0;
      var_4 = var_0 ismlgfreecamenabled();

      while(var_0 isbnetkr15player()) {
        if(!var_0 usinggamepad() && var_1.shotsleft < 14) {
          var_1 notify("_encstr_88BE0EEC1B3B5D9D6886F837997067AC");
          break;
        } else {
          if(var_1.shotsleft < 14 && var_4 > 0 && var_3 >= var_2)
            var_1 notify("_encstr_88BE0EEC1B3B5D9D6886F837997067AC");

          var_3 = var_3 + level.framedurationseconds;
          waitframe();
        }
      }

      if(var_0 usinggamepad() && var_1.shotsleft < 14 && (var_4 == 0 && var_3 > 0.0 && var_3 < 0.2 || var_4 > 0 && var_3 >= var_2))
        var_1 notify("_encstr_88BE0EEC1B3B5D9D6886F837997067AC");

      waitframe();
    }
  }
}

c130airdrop_isnearotherdrop(var_0) {
  var_1 = scripts\cp_mp\vehicles\vehicle::_id_14192(self, "_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07");
  var_1.shotsleft = var_1.shotsleft + var_0;
  var_1.shotsleft = int(clamp(var_1.shotsleft, 0, 14));
  c4_crate_spawn();
}

apc_rus_updateomnvarsonseatenter(var_0, var_1, var_2, var_3) {
  if(var_2 == "_encstr_9AE307B956E345D0AB")
    var_0 c4_crate_spawn();
}

c4_crate_spawn() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "_encstr_9AE307B956E345D0AB");

  if(isDefined(var_0)) {
    var_1 = scripts\cp_mp\vehicles\vehicle::_id_14192(self, "_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07");
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("_encstr_86510C82737817CD40B38B720A15", "_encstr_853D0D7723201E3266F18783A5856B", var_1.shotsleft, var_0);
  }
}