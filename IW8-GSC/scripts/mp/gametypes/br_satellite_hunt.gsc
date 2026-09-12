/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_satellite_hunt.gsc
******************************************************/

function init() {
  if(getdvarint("scr_enable_br_satellite_hunt", 0) == 0) {
    return;
  }

  thread tracegroundheightexfil();
  thread tomastrike_watchgameend();
  tank_arrive_and_fire(level);
  scripts\engine\utility::add_fx("satellite_cache_impact", "vfx/iw8_br/equipment/vfx_satellite_crash_impact.vfx");
  level.setuptrain = getdvarint("scr_harp_radarViewTime", 90);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("harp", &scripts\cp_mp\killstreaks\uav::tryuseuavfromstruct);
  level.uavsettings["harp"] = spawnStruct();
  level.uavsettings["harp"].health = level.uavsettings["directional_uav"].health;
  level.uavsettings["harp"].maxhealth = level.uavsettings["directional_uav"].maxhealth;
  level.uavsettings["harp"].modelbase = level.uavsettings["directional_uav"].modelbase;
  level.uavsettings["harp"].modelbasealt = level.uavsettings["directional_uav"].modelbasealt;
  level.uavsettings["harp"].fxid_explode = level.uavsettings["directional_uav"].playerzombielaststandrevive;
  level.uavsettings["harp"].fx_leave_tag = level.uavsettings["directional_uav"].fx_leave_tag;
  level.uavsettings["harp"].fxid_contrail = level.uavsettings["directional_uav"].fxid_contrail;
  level.uavsettings["harp"].fx_contrail_tag = level.uavsettings["directional_uav"].fx_contrail_tag;
  level.uavsettings["harp"].sound_explode = level.uavsettings["directional_uav"].sound_explode;
  level.uavsettings["harp"].calloutdestroyed = level.uavsettings["directional_uav"].calloutdestroyed;
  level.uavsettings["harp"].addfunc = level.uavsettings["directional_uav"].addfunc;
  level.uavsettings["harp"].removefunc = level.uavsettings["directional_uav"].removefunc;
  level.uavsettings["harp"].streakname = "harp";
  level.uavsettings["harp"].teamsplash = "used_harp";
  level.uavsettings["harp"].votimeout = "harp_timeout";
  level.uavsettings["harp"].timeout = level.setuptrain;
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "harpSpawned", &setupweaponattachmentoverrides);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "harpTimeout", &setupx1timelimit);
  level.dialog_wait_ready_civ = 0;
  scripts\mp\gametypes\br_gametype_truckwar::stoppingpower_givehcrdata();
  level thread scripts\mp\gametypes\br_gametype_truckwar::ref_13DF8();
  thread deletecircle();
}

function tracegroundheightexfil() {
  game["dialog"]["satellite_located"] = "satellite_located";
  game["dialog"]["uplink_secured"] = "uplink_secured";
  game["dialog"]["harp_friendly_use"] = "harp_friendly_use";
  game["dialog"]["harp_timeout"] = "harp_timeout";
}

function setupweaponattachmentoverrides(var_0) {
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("harp_friendly_use", var_0.team, 1);
}

function setupx1timelimit(var_0) {
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback(level.uavsettings["harp"].votimeout, var_0.team, 1);
}

function deletecircle() {
  wait 5;
  scripts\mp\utility\sound::besttime("br_event_satellite_sfx");
}

function ref_12A17(var_0, var_1) {
  var_2 = scripts\engine\trace::ray_trace(var_0, var_1);
  var_3 = [];

  if(isDefined(var_2["entity"]) && var_3.size < 25) {
    GscBinSkip0(0x2e, var_3.size, var_2["entity"]);
  }

  return var_2;
}

function tank_arrive_and_fire() {
  var_0 = getDvar("scr_satellite_exclusive_items", "brloot_offhand_advancedvehicledrop,brloot_killstreak_harp,brloot_offhand_advancedsupplydrop");
  var_1 = getDvar("scr_satellite_exclusive_item_drop_chances", "20,40,40");
  var_2 = getDvar("scr_satellite_excusive_item_drop_limits", "4,999,999");
  var_0 = strtok(var_0, ",");
  var_1 = strtok(var_1, ",");
  var_2 = strtok(var_2, ",");
  var_3 = [];

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_5 = spawnStruct();
    var_5.type = var_0[var_4];
    var_5.ml_p2_fail_start = int(var_1[var_4]);
    var_5.modeiskillstreakallowed = int(var_2[var_4]);
    var_5.ml_p3_to_safehouse_transition = 0;
    var_3 = var_5;
  }

  level.ref_12EAA = var_3;
}

function minigun_manager(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  var_4 = (0, 0, 500);
  var_5 = ref_12A17(var_1 + var_4, var_1 - var_4);
  var_6 = var_5["position"] + (0, 0, 23);
  var_7 = var_2 + (0, -90, 110);
  lootstruct_offsets(var_0, var_3, var_6);
  var_8 = ref_135C6(var_0, var_6, var_7);
  var_8 radiusdamage(var_6, 500, 1000, 50);
  var_8 setscriptablepartstate("model", "crashed");
  var_8 playSound("br_sat_sat_impact");
  playFX(scripts\engine\utility::getfx("satellite_cache_impact"), var_6, anglesToForward((0, var_2[1], 0)), (0, 0, 1));

  if(var_0 != "none") {
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("satellite_located", var_0, 1);
  }

  ref_11A93(var_0, var_8);
  thread ref_14482(level, var_8);

  if(isDefined(level.modeupdateloadoutclass)) {
    level.modeupdateloadoutclass = scripts\engine\utility::array_add(level.modeupdateloadoutclass, var_8);
    return;
  }
}

function lootstruct_offsets(var_0, var_1, var_2) {
  var_3 = var_1 - var_2;
  var_4 = anglestoup(vectortoangles(var_3));
  var_5 = vectortoangles(var_4);
  var_6 = ref_13553(var_1, var_5);
  var_6 endon("death");
  var_6 setscriptablepartstate("model", "falling");
  var_7 = distance(var_1, var_2);
  var_8 = var_7 / 3000;
  var_9 = var_8 * 0.75;
  var_6 moveTo(var_2, var_8, var_9, 0.05);
  var_6 playLoopSound("br_sat_sat_lp");
  thread ref_12EA5(level);
  thread ref_12EA8(level);
  wait var_8;
  var_6 setscriptablepartstate("model", "impact");
  ref_12EA9(var_2);
  var_6 stoploopsound();
  var_6 notify("stop_satellite_flight_rumble");
  var_6 notify("stop_satellite_vehicle_crush");
  var_6 delete();
}

function ref_12EA9(var_0) {
  var_1 = scripts\engine\trace::sphere_trace_get_all_results(var_0, var_0, 60);

  foreach(var_3 in var_1) {
    var_4 = var_3["entity"];
    ref_13DFD(var_4, var_0);
  }
}

function ref_12EA8(var_0) {
  var_0 endon("death");
  var_0 endon("stop_satellite_vehicle_crush");

  for(;;) {
    var_0 waittill("touch", var_1);
    ref_13DFD(var_1, var_0.origin);
  }
}

function ref_13DFD(var_0, var_1) {
  if(!isDefined(var_0) || !isalive(var_0)) {
    return;
  }

  if(!var_0 scripts\common\vehicle::isvehicle() && !isDefined(var_0.classname)) {
    return;
  }

  if(var_0.classname == "script_vehicle") {
    var_0 dodamage(10 * var_0.health, var_1);
    return;
  }
}

function ref_13553(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2.angles = var_1;
  var_2 setModel("p9_ang_satellite_recovery_unit_full");
  return var_2;
}

function ref_135C6(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_1);
  var_3.angles = var_2;
  var_3 setModel("p9_ang_satellite_recovery_unit_full_02");
  var_3.id = "care_package";
  var_3.use_vehicle_turret = 1;
  var_3.team = var_0;

  if(var_0 != "none") {
    var_4 = scripts\mp\utility\teams::getfriendlyplayers(var_0);

    if(var_4.size > 0) {
      var_3 setotherent(var_4[0]);
    }
  }

  return var_3;
}

function ref_12EA5(var_0) {
  var_0 endon("death");
  var_0 endon("stop_satellite_flight_rumble");
  var_1 = -10000;

  for(;;) {
    var_2 = (var_0.origin[0], var_0.origin[1], var_1);
    var_3 = physicstrace(var_0.origin, var_2);
    playrumbleonposition("artillery_rumble_heavy", var_0.origin);
    playrumbleonposition("artillery_rumble_heavy", var_3);
    wait 0.7;
  }
}

function ref_11A93(var_0, var_1) {
  var_1 makeusable();

  if(var_0 != "none") {
    foreach(var_3 in scripts\mp\utility\teams::getfriendlyplayers(var_0)) {
      var_1 setotherent(var_3);
      break;
    }

    var_1 setscriptablepartstate("objective", "active");
  } else {
    var_1 setscriptablepartstate("objective", "active_everyone");
  }

  var_1 setCursorHint("HINT_NOICON");
  var_1 sethintonobstruction("show");
  var_1 sethinttag("tag_use");
  var_1 sethintdisplayrange(128);
  var_1 sethintdisplayfov(180);
  var_1 setuserange(128);
  var_1 setusefov(180);
  var_1 setusepriority(-1);
  var_1 setuseholdduration("duration_none");
  var_1 setHintString(&"SATELLITE_HUNT/SATELLITE_CACHE_USE_HINT");
  var_1.userate = 1;
  var_1.usetime = 0;
}

function ref_11A92(var_0) {
  var_0 notify("satellite_cache_unusable");
  var_0 makeunusable();
  var_0 setscriptablepartstate("objective", "inactive");
}

function ref_14482(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("satellite_cache_unusable");

  for(;;) {
    var_0 waittill("trigger", var_2);
    var_3 = ref_13E08(var_0, var_2);

    if(var_3) {
      if(isDefined(var_1)) {
        GscBinSkip1(0x74, var_1, var_0, var_2);
      }
    }
  }
}

function ref_13E08(var_0, var_1) {
  var_0 endon("death");
  var_0.inuse = 0;
  var_0.playerusing = undefined;
  var_0.curprogress = 0;
  var_2 = 0;

  while(isDefined(var_1) && var_1 useButtonPressed()) {
    if(var_0.usetime <= 0) {
      return 1;
    }

    var_0.curprogress += level.framedurationseconds * var_0.userate;
    var_1 scripts\mp\gameobjects::updateuiprogress(var_0, 1);

    if(var_0.curprogress >= var_0.usetime) {
      var_2 = 1;
      break;
    }

    waitframe();
  }

  var_1 scripts\mp\gameobjects::updateuiprogress(var_0, 0);
  return var_2;
}

function ref_11FF4(var_0, var_1) {
  var_2 = ref_135C7(var_0);
  ref_11A92(var_0);
  var_0 setscriptablepartstate("model", "open");

  if(isDefined(var_1)) {
    var_1 scripts\cp\vehicles\vehicle_compass_cp::ref_12005();
    var_3 = [];

    for(var_4 = 0; var_4 < var_2.size; var_4++) {
      var_3 = "item" + var_4;
      var_3 = var_2[var_4].type;
    }

    var_3 = "time_msfrommatchstart";
    var_3 = scripts\mp\matchdata::gettimefrommatchstart(gettime());
    var_3 = "pos_x";
    var_3 = var_0.origin[0];
    var_3 = "pos_y";
    var_3 = var_0.origin[1];
    var_3 = "pos_z";
    var_3 = var_0.origin[2];
    var_1 dlog_recordplayerevent("dlog_event_br_crash_site_recovery", var_3);
    return;
  }
}

function ref_135C7(var_0) {
  var_1 = random_loot_override(var_0);

  if(!isDefined(var_1) || var_1.size <= 0) {
    return [];
  }

  var_2 = spawnStruct();
  var_3 = anglesToForward((0, var_0.angles[1] - -90, 0));
  var_2.origin = var_0.origin + var_3 * 45;
  var_2.angles = (0, var_0.angles[1], 0);
  var_2.itemsdropped = 0;
  var_4 = var_2 scripts\mp\gametypes\br_lootcache::ref_11A42(var_1, 1, undefined);
  ref_13C36(var_4);
  return var_4;
}

function random_loot_override(var_0) {
  var_1 = verifybunkercode("satellite_cache", 0);

  if(!isDefined(var_1)) {
    var_1 = [];
  }

  var_2 = gettruegroundposition();

  if(isDefined(var_2)) {
    var_1 = var_2;
  }

  return var_1;
}

function gettruegroundposition() {
  var_0 = 0;

  foreach(var_2 in level.ref_12EAA) {
    if(var_2.ml_p3_to_safehouse_transition >= var_2.modeiskillstreakallowed) {
      continue;
    }

    var_0 += var_2.ml_p2_fail_start;
  }

  if(var_0 <= 0) {
    return undefined;
  }

  var_4 = randomint(var_0);
  var_5 = 0;

  foreach(var_2 in level.ref_12EAA) {
    if(var_2.ml_p3_to_safehouse_transition >= var_2.modeiskillstreakallowed) {
      continue;
    }

    var_5 += var_2.ml_p2_fail_start;

    if(var_4 < var_5) {
      return var_2.type;
    }
  }

  return undefined;
}

function ref_13C36(var_0) {
  foreach(var_2 in var_0) {
    var_3 = level.ref_12EAA[var_2.type];

    if(!isDefined(var_3)) {
      continue;
    }

    var_3.ml_p3_to_safehouse_transition++;
  }
}

function tomastrike_watchgameend() {
  scripts\mp\flags::gameflagwait("prematch_done");
  level.player_get_carepackage_precision_airstrike = [];
  level.player_gassed_effects = [];
  level.ref_13641 = [];
  level.modeupdateloadoutclass = [];

  switch (level.mapname) {
    case "mp_br_mechanics":
      thread tire_repair_start_air_stop_sfx();
      break;
    case "mp_don4":
      thread tire_repair_start_exit_foley_sfx();
      break;
  }

  thread topteamsever();
  thread timevotrigger();
  thread ref_14015();
}

function battle_tracks_playbattletrackswhenstandingonvehicle(var_0, var_1, var_2) {
  if(!isDefined(level.player_get_carepackage_precision_airstrike[var_0])) {
    level.player_get_carepackage_precision_airstrike[var_0] = [];
  }

  var_3 = level.player_get_carepackage_precision_airstrike[var_0].size;

  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  var_4 = spawnStruct();
  var_4.origin = var_1;
  var_4.angles = var_2;
  level.player_get_carepackage_precision_airstrike[var_0][var_3] = var_4;
}

function battle_tracks_playbattletrackstoplayer(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.crashorigin = var_1;
  var_3.spawnorigin = var_0;
  var_3.infectsetradaronnumsurvivors = var_2;
  level.player_gassed_effects[level.player_gassed_effects.size] = var_3;
}

function tire_repair_start_exit_foley_sfx() {
  battle_tracks_playbattletrackswhenstandingonvehicle("airport", (-23095, 15097, -6));
  battle_tracks_playbattletrackswhenstandingonvehicle("airport", (-14014, 20695, -390));
  battle_tracks_playbattletrackswhenstandingonvehicle("airport", (-8879, 17588, -262));
  battle_tracks_playbattletrackswhenstandingonvehicle("downtown", (24481, -17510, -150));
  battle_tracks_playbattletrackswhenstandingonvehicle("downtown", (28377, -15532, -180));
  battle_tracks_playbattletrackswhenstandingonvehicle("downtown", (30944, -9443, -366));
  battle_tracks_playbattletrackswhenstandingonvehicle("militarybase", (3026, 51369, 1094));
  battle_tracks_playbattletrackswhenstandingonvehicle("militarybase", (2222, 46081, 1466));
  battle_tracks_playbattletrackswhenstandingonvehicle("militarybase", (7569, 47423, 1079));
  battle_tracks_playbattletrackswhenstandingonvehicle("summit", (-31645, 45925, 3131));
  battle_tracks_playbattletrackswhenstandingonvehicle("summit", (-18635, 62607, 1968));
  battle_tracks_playbattletrackswhenstandingonvehicle("summit", (-22281, 53130, 2690));
  battle_tracks_playbattletrackswhenstandingonvehicle("saltmine", (33699, 38645, 770));
  battle_tracks_playbattletrackswhenstandingonvehicle("saltmine", (37949, 42069, 2059));
  battle_tracks_playbattletrackswhenstandingonvehicle("saltmine", (28480, 38949, 765));
  battle_tracks_playbattletrackswhenstandingonvehicle("array", (23659, 24841, 1358));
  battle_tracks_playbattletrackswhenstandingonvehicle("array", (29272, 18345, 1210));
  battle_tracks_playbattletrackswhenstandingonvehicle("stadium", (24237, 5066, -557));
  battle_tracks_playbattletrackswhenstandingonvehicle("stadium", (36604, 6026, -462));
  battle_tracks_playbattletrackswhenstandingonvehicle("stadium", (28682, 212, -526));
  battle_tracks_playbattletrackswhenstandingonvehicle("farmland", (51891, -17870, -332));
  battle_tracks_playbattletrackswhenstandingonvehicle("farmland", (46236, -13936, -17));
  battle_tracks_playbattletrackswhenstandingonvehicle("farmland", (43967, -4737, 337));
  battle_tracks_playbattletrackswhenstandingonvehicle("superfactory", (-14036, 9027, 226));
  battle_tracks_playbattletrackswhenstandingonvehicle("superfactory", (-14812, 4964, -342));
  battle_tracks_playbattletrackswhenstandingonvehicle("superfactory", (-7048, 7646, -269));
  battle_tracks_playbattletrackswhenstandingonvehicle("boneyard", (-25772, -9352, 9));
  battle_tracks_playbattletrackswhenstandingonvehicle("boneyard", (-28848, -18447, -176));
  battle_tracks_playbattletrackswhenstandingonvehicle("trainstation", (-15159, -14136, 258));
  battle_tracks_playbattletrackswhenstandingonvehicle("trainstation", (-8952, -15887, -310));
  battle_tracks_playbattletrackswhenstandingonvehicle("port", (38675, -27620, -512));
  battle_tracks_playbattletrackswhenstandingonvehicle("port", (33792, -24817, -508));
  battle_tracks_playbattletrackswhenstandingonvehicle("lumber", (50312, 2539, 78));
  battle_tracks_playbattletrackswhenstandingonvehicle("lumber", (53346, 5901, 88));
  battle_tracks_playbattletrackswhenstandingonvehicle("hillspromenade", (-4195, -29916, 334));
  battle_tracks_playbattletrackswhenstandingonvehicle("hillspromenade", (-6128, -21873, -226));
  battle_tracks_playbattletrackswhenstandingonvehicle("superfactory", (-28088, 9552, -262));
  battle_tracks_playbattletrackstoplayer((-42206, 30546, 15594), (-21206, 55546, 3258), (0, 63, 0));
  battle_tracks_playbattletrackstoplayer((-7587, 73408, 15594), (-28587, 48408, 2621), (0, 231, 0));
  battle_tracks_playbattletrackstoplayer((5434, 42408, 15594), (-15434, 62784, 1890), (0, 133, 0));
  battle_tracks_playbattletrackstoplayer((1358, 45734, 15594), (-19642, 20734, -390), (0, 238, 0));
  battle_tracks_playbattletrackstoplayer((-38950, -9330, 15594), (-17950, 15670, -267), (0, 57, 0));
  battle_tracks_playbattletrackstoplayer((15000, 40711, 15594), (-6147, 20711, -298), (0, 218, 0));
  battle_tracks_playbattletrackstoplayer((21050, 72623, 15594), (50, 47623, 1786), (0, 240, 0));
  battle_tracks_playbattletrackstoplayer((27637, 73473, 15594), (6637, 48473, 1082), (0, 226, 0));
  battle_tracks_playbattletrackstoplayer((25637, 73557, 15594), (3434, 53557, 1082), (0, 234, 0));
  battle_tracks_playbattletrackstoplayer((-1855, -41818, 15594), (22914, -16594, -158), (0, 49, 0));
  battle_tracks_playbattletrackstoplayer((48000, 15912, 15594), (26741, -5912, -398), (0, 233, 0));
  battle_tracks_playbattletrackstoplayer((-3944, -4366, 15594), (27516, -14650, -206), (0, 337, 0));
  battle_tracks_playbattletrackstoplayer((55974, 63705, 15594), (34974, 38705, 767), (0, 227, 0));
  battle_tracks_playbattletrackstoplayer((16974, 21705, 15594), (36216, 41247, 1382), (0, 55, 0));
  battle_tracks_playbattletrackstoplayer((9008, 10518, 15594), (30008, 35518, 639), (0, 54, 0));
  battle_tracks_playbattletrackstoplayer((710, -3670, 15594), (21710, 22670, 1658), (0, 45, 0));
  battle_tracks_playbattletrackstoplayer((51763, 46740, 15594), (30763, 21740, 728), (0, 230, 0));
  battle_tracks_playbattletrackstoplayer((39099, 28563, 15594), (28099, 3563, -520), (0, 246, 0));
  battle_tracks_playbattletrackstoplayer((10099, -14500, 15594), (33112, 6457, -539), (0, 42, 0));
  battle_tracks_playbattletrackstoplayer((13642, -25493, 15594), (34642, -493, -672), (0, 60, 0));
  battle_tracks_playbattletrackstoplayer((73223, 10097, 15594), (52223, -15097, -336), (0, 229, 0));
  battle_tracks_playbattletrackstoplayer((63223, 8097, 15594), (44410, -13675, -49), (0, 228, 0));
  battle_tracks_playbattletrackstoplayer((64356, 13848, 15594), (43356, -12848, -51), (0, 241, 0));
  battle_tracks_playbattletrackstoplayer((-28813, -21412, 15594), (-7813, 3588, -296), (0, 49, 0));
  battle_tracks_playbattletrackstoplayer((10603, 36659, 15594), (-11603, 11659, -249), (0, 230, 0));
  battle_tracks_playbattletrackstoplayer((4603, 26659, 15594), (-17047, 8088, -263), (0, 219, 0));
  battle_tracks_playbattletrackstoplayer((-49541, -35754, 15594), (-28541, -10754, -70), (0, 48, 0));
  battle_tracks_playbattletrackstoplayer((-2089, 12133, 15594), (-23089, -12867, -135), (0, 220, 0));
  battle_tracks_playbattletrackstoplayer((-34198, -43327, 15594), (-13198, -18327, -310), (0, 54, 0));
  battle_tracks_playbattletrackstoplayer((-26949, -33422, 15594), (-5949, -8422, -359), (0, 49, 0));
  battle_tracks_playbattletrackstoplayer((9586, -52505, 15594), (30586, -27505, -508), (0, 44, 0));
  battle_tracks_playbattletrackstoplayer((-15193, -45559, 15594), (36193, -20559, -508), (0, 25, 0));
  battle_tracks_playbattletrackstoplayer((30115, -26887, 15594), (51115, -1887, 156), (0, 50, 0));
  battle_tracks_playbattletrackstoplayer((69480, 32243, 15594), (48480, 7243, 35), (0, 237, 0));
  battle_tracks_playbattletrackstoplayer((-26000, -47000, 15594), (-6755, -29018, 90), (0, 49, 0));
  battle_tracks_playbattletrackstoplayer((-32000, 0, 15594), (-11306, -20228, -304), (0, 314, 0));
  battle_tracks_playbattletrackstoplayer((-43000, -12000, 15594), (-23028, 8447, -260), (0, 47, 0));
  battle_tracks_playbattletrackstoplayer((25000, -15642, 15594), (45195, 4358, -42), (0, 38, 0));
  battle_tracks_playbattletrackstoplayer((22000, -25000, 15594), (42167, -6352, 279), (0, 20, 0));
  battle_tracks_playbattletrackstoplayer((-47000, -39000, 15594), (-27520, -19542, -200), (0, 50, 0));
}

function tire_repair_start_air_stop_sfx() {
  battle_tracks_playbattletrackswhenstandingonvehicle("test", (5100, -583, 58), (0, randomintrange(0, 360), 0));
  battle_tracks_playbattletrackswhenstandingonvehicle("test", (5300, -583, 58), (0, randomintrange(0, 360), 0));
  battle_tracks_playbattletrackswhenstandingonvehicle("test", (5500, -583, 58), (0, randomintrange(0, 360), 0));
  battle_tracks_playbattletrackswhenstandingonvehicle("test", (5700, -583, 58), (0, randomintrange(0, 360), 0));
  battle_tracks_playbattletrackswhenstandingonvehicle("test", (5900, -583, 58), (0, randomintrange(0, 360), 0));
  battle_tracks_playbattletrackstoplayer((-10000, -376, 8178), (5100, -450, 58));
  battle_tracks_playbattletrackstoplayer((-10000, -376, 8178), (5300, -450, 58));
  battle_tracks_playbattletrackstoplayer((-10000, -376, 8178), (5500, -450, 58));
  battle_tracks_playbattletrackstoplayer((-10000, -376, 8178), (5700, -450, 58));
  battle_tracks_playbattletrackstoplayer((-10000, -376, 8178), (5900, -450, 58));
}

function topteamsever() {
  var_0 = getdvarint("scr_satellite_link_per_zone", 1);

  if(var_0 <= 0) {
    return;
  }

  if(!isDefined(level.player_get_carepackage_precision_airstrike)) {
    return;
  }

  var_1 = getdvarint("scr_satellite_link_total_zones", 15);

  if(var_1 <= 0) {
    return;
  }

  var_2 = getarraykeys(level.player_get_carepackage_precision_airstrike);
  var_2 = scripts\engine\utility::array_randomize(var_2);
  var_3 = [];
  var_4 = 0;

  for(var_5 = 0; var_4 < var_1 && var_5 < var_2.size; var_5++) {
    var_6 = var_2[var_5 % var_2.size];
    var_7 = int(min(level.player_get_carepackage_precision_airstrike[var_6].size, var_0));

    if(var_7 <= 0) {
      continue;
    }

    var_8 = randomintrange(0, var_7 + 1);
    var_9 = int(min(var_1 - var_4, var_8));
    var_3 = var_9;
    var_4 += var_9;
  }

  for(var_5 = 0; var_4 < var_1 && var_5 < var_2.size; var_5++) {
    var_6 = var_2[var_5 % var_2.size];

    if(var_3[var_6] < level.player_get_carepackage_precision_airstrike[var_6].size) {
      var_9 = int(min(var_1 - var_4, level.player_get_carepackage_precision_airstrike[var_6].size - var_3[var_6]));
      var_3 = var_3[var_6] + var_9;
      var_4 += var_9;
    }
  }

  foreach(var_11 in var_3) {
    var_12 = level.player_get_carepackage_precision_airstrike[var_14];

    if(!isarray(var_12)) {
      continue;
    }

    var_13 = scripts\engine\utility::array_randomize(var_12);

    for(var_5 = 0; var_5 < var_13.size && var_5 < var_0; var_5++) {
      ref_13696(var_13[var_5].origin, var_13[var_5].angles, 1);
    }
  }
}

function timevotrigger() {
  var_0 = getdvarint("scr_satellite_link_per_zone", 1);

  if(var_0 <= 0) {
    return;
  }

  var_1 = level.struct_class_names["targetname"]["satellite_link_station"];

  if(!isDefined(var_1)) {
    return;
  }

  foreach(var_3 in var_1) {
    var_4 = level.struct_class_names["targetname"][var_3.target];

    if(!isarray(var_4)) {
      continue;
    }

    var_4 = scripts\engine\utility::array_randomize(var_4);

    for(var_5 = 0; var_5 < var_4.size && var_5 < var_0; var_5++) {
      var_6 = var_4[var_5];

      if(!isDefined(var_6)) {
        continue;
      }

      ref_13696(var_6.origin, var_6.angles);
    }
  }
}

function ref_13696(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  var_3 = (0, 0, 500);
  var_4 = scripts\engine\trace::ray_trace(var_0 + var_3, var_0 - var_3);
  var_5 = spawn("trigger_radius", var_4["position"], 0, int(128), int(72));
  var_6 = scripts\mp\gametypes\obj_dom::setupobjective(var_5);
  var_6 scripts\mp\gameobjects::allowuse("any");
  var_6 scripts\mp\gameobjects::cancontestclaim(1);
  var_6 scripts\mp\gameobjects::setusetime(10);
  var_6.usecondition = &mark_loot;
  var_6.onbeginuse = &mark_danger_timeout;
  var_6.onenduse = &domflag_onenduse;
  var_6.onuse = &domflag_onuse;
  var_6.onuseupdate = &domflag_onuseupdate;
  var_6.lockupdatingicons = 1;
  var_6.getrandompointincirclewithindistance = 1;
  var_6.ref_12F83 = var_2;
  getbnetigrbattlepassxpmultiplier(var_6.objidnum, 450, 500);
  objective_setshowoncompass(var_6.objidnum, 0);
  objective_state(var_6.objidnum, "invisible");
  objective_icon(var_6.objidnum, "ui_mp_br_mapmenu_icon_uplink_objective");
  var_6.flagmodel setModel("p9_wz_sat_link_objective_satellite_01");
  var_6.flagmodel.angles = (var_4["normal"][0], var_1[1], var_4["normal"][2]);
  var_6.flagmodel playLoopSound("br_sat_uplink_inactive_loop");
  level.ref_13641[level.ref_13641.size] = var_6;
}

function ref_14015() {
  level endon("game_ended");

  if(getdvarint("satellite_link_objective_pruning", 0) == 0) {
    return;
  }

  var_0 = 1;
  var_1 = 1;
  var_2 = 25;
  var_3 = 5000;
  var_4 = var_3 * var_3;

  for(;;) {
    if(isDefined(level.players) && level.players.size > 0 && isDefined(level.ref_13641) && level.ref_13641.size > 0) {
      for(var_5 = 0; var_5 < level.ref_13641.size; var_5++) {
        var_6 = level.ref_13641[var_5];

        if(istrue(var_6.trigger.trigger_off)) {
          continue;
        }

        objective_removeallfrommask(var_6.objidnum);
        var_7 = level.players;

        for(var_8 = 0; var_8 < var_7.size; var_8++) {
          var_9 = var_7[var_8];

          if(isDefined(var_9)) {
            var_10 = distance2dsquared(var_9.origin, var_6.flagmodel.origin);

            if(var_10 <= var_4) {
              objective_addclienttomask(var_6.objidnum, var_9);
            }
          }

          if(var_8 % var_2 == 0) {
            waitframe();
          }
        }

        if(istrue(var_6.trigger.trigger_off)) {
          continue;
        }

        objective_showtoplayersinmask(var_6.objidnum);

        if(var_5 % var_1 == 0) {
          waitframe();
        }
      }
    }

    wait var_0;
  }
}

function mark_loot(var_0) {
  return true;
}

function mark_danger_timeout(var_0) {
  self.flagmodel playLoopSound("br_sat_uplink_loop");
}

function domflag_onuseupdate(var_0, var_1, var_2, var_3) {
  if(var_1 > 0.05 && var_2 && !istrue(self.didstatusnotify)) {
    self.didstatusnotify = 1;
    return;
  }
}

function domflag_onuse(var_0) {
  self.flagmodel endon("death");
  thread mark_phone_guy_once_all_spawned();
  var_1 = "none";

  if(isDefined(var_0.team)) {
    var_1 = var_0.team;
  }

  var_2 = ["time_msfrommatchstart", scripts\mp\matchdata::gettimefrommatchstart(gettime()), "pos_x", self.flagmodel.origin[0], "pos_y", self.flagmodel.origin[1], "pos_z", self.flagmodel.origin[2]];
  var_0 dlog_recordplayerevent("dlog_event_br_sat_link_secure", var_2);
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("uplink_secured", var_1, 1);
  self.flagmodel playSound("br_sat_uplink_connect");
  self.flagmodel setscriptablepartstate("model", "open");
  scripts\mp\gameobjects::disableobject();

  foreach(var_4 in scripts\mp\utility\teams::getfriendlyplayers(var_1)) {
    if(!var_4 scripts\mp\gametypes\br_public::isplayeringulag() && var_4 scripts\cp_mp\utility\player_utility::_isalive()) {
      var_4 scripts\mp\gametypes\br_plunder::ref_12627(25);
      var_4 thread scripts\mp\hud_message::showsplash("br_satlink_satellite_incoming");
    }
  }

  while(self.flagmodel getscriptablepartstate("model") != "captured") {
    waitframe();
  }

  wait randomfloatrange(1, 2);

  if(!self.ref_12F83) {
    thread modifyakimboburstrenettidamagehack(level, var_1);
    return;
  }

  thread mlp2_front_truck(level, var_1);
}

function domflag_onenduse(var_0, var_1, var_2) {
  scripts\mp\gametypes\obj_dom::dompoint_onuseend(var_0, var_1, var_2);
  self.flagmodel stoploopsound();

  if(!var_2) {
    self.flagmodel playLoopSound("br_sat_uplink_inactive_loop");
    return;
  }

  if(isDefined(var_1)) {
    var_1 scripts\cp\vehicles\vehicle_compass_cp::ref_12083();
    return;
  }
}

function mark_phone_guy_once_all_spawned() {
  self endon("removed");
  waittillframeend();
  domflagupdateicons();
}

function domflagupdateicons() {
  objective_showtoplayersinmask(self.objidnum);
  objective_removeallfrommask(self.objidnum);
}

function mlp2_front_truck(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 7500;
  }

  var_3 = level.player_gassed_effects;
  var_4 = [];
  var_5 = var_2 * var_2;

  foreach(var_7 in var_3) {
    if(isDefined(var_7.used)) {
      continue;
    }

    if(distance2dsquared(var_1, var_7.crashorigin) > var_5) {
      continue;
    }

    var_4 = var_7;
  }

  if(var_4.size <= 0) {
    return;
  }

  var_4 = scripts\engine\utility::array_randomize(var_4);
  var_9 = [];

  foreach(var_11 in var_4) {
    if(!isDefined(level.br_circle.dangercircleent) || scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(var_11.crashorigin)) {
      var_9 = var_11;
    }
  }

  if(var_9.size > 0) {
    var_4 = var_9;
  }

  var_7 = var_4[0];
  var_7.used = 1;
  minigun_manager(level, var_0, var_7.crashorigin, var_7.infectsetradaronnumsurvivors, var_7.spawnorigin);
}

function modifyakimboburstrenettidamagehack(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 7500;
  }

  var_3 = level.struct_class_names["targetname"]["satellite_fall_location"];

  if(!isDefined(var_3)) {
    return;
  }

  var_4 = [];
  var_5 = var_2 * var_2;

  foreach(var_7 in var_3) {
    if(isDefined(var_7.used)) {
      continue;
    }

    if(distance2dsquared(var_1, var_7.origin) > var_5) {
      continue;
    }

    var_4 = var_7;
  }

  if(var_4.size <= 0) {
    return;
  }

  var_4 = scripts\engine\utility::array_randomize(var_4);
  var_7 = var_4[0];
  var_7.used = 1;
  var_9 = level.struct_class_names["targetname"][var_7.target];

  if(!isDefined(var_9) || !isDefined(var_9[0])) {
    return;
  }

  minigun_manager(level, var_0, var_7.origin, var_7.angles, var_9[0].origin);
}

function dangercircletick(var_0, var_1) {
  if(getdvarint("scr_enable_br_satellite_hunt", 0) == 0 && !istrue(level.delete_corpses)) {
    return;
  }

  var_2 = var_1 + 3000;
  var_3 = var_2 * var_2;

  if(isDefined(level.ref_13641)) {
    foreach(var_5 in level.ref_13641) {
      if(distance2dsquared(var_5.curorigin, var_0) > var_3) {
        loadoutdefaultcost(var_5);
      }
    }
  }

  var_7 = var_1 + 3000;
  var_8 = var_7 * var_7;

  if(isDefined(level.modeupdateloadoutclass)) {
    for(var_9 = level.modeupdateloadoutclass.size - 1; var_9 >= 0; var_9--) {
      var_10 = level.modeupdateloadoutclass[var_9];

      if(distance2dsquared(var_10.origin, var_0) > var_8) {
        var_10 delete();
        level.modeupdateloadoutclass = scripts\engine\utility::array_remove_index(level.modeupdateloadoutclass, var_9, 0);
      }
    }

    return;
  }
}

function loadoutdefaultcost(var_0) {
  if(!isDefined(var_0) || istrue(var_0.disabled)) {
    return;
  }

  var_0.trigger triggerdisable();
  var_0.disabled = 1;
  var_0.flagmodel stoploopsound();
  var_0 scripts\mp\gameobjects::disableobject();
}