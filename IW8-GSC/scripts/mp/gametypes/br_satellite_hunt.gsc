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
  level thread scripts\mp\gametypes\br_gametype_truckwar::ref_13df8();
  thread deletecircle();
}

function tracegroundheightexfil() {
  game["dialog"]["satellite_located"] = "satellite_located";
  game["dialog"]["uplink_secured"] = "uplink_secured";
  game["dialog"]["harp_friendly_use"] = "harp_friendly_use";
  game["dialog"]["harp_timeout"] = "harp_timeout";
}

function setupweaponattachmentoverrides(var0) {
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("harp_friendly_use", var0.team, 1);
}

function setupx1timelimit(var0) {
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback(level.uavsettings["harp"].votimeout, var0.team, 1);
}

function deletecircle() {
  wait 5;
  scripts\mp\utility\sound::besttime("br_event_satellite_sfx");
}

function ref_12a17(var0, var1) {
  var2 = scripts\engine\trace::ray_trace(var0, var1);
  var3 = [];

  if(isDefined(var2["entity"]) && var3.size < 25) {
    GscBinSkip0(0x2e, var3.size, var2["entity"]);
  }

  return var2;
}

function tank_arrive_and_fire() {
  var0 = getDvar("scr_satellite_exclusive_items", "brloot_offhand_advancedvehicledrop,brloot_killstreak_harp,brloot_offhand_advancedsupplydrop");
  var1 = getDvar("scr_satellite_exclusive_item_drop_chances", "20,40,40");
  var2 = getDvar("scr_satellite_excusive_item_drop_limits", "4,999,999");
  var0 = strtok(var0, ",");
  var1 = strtok(var1, ",");
  var2 = strtok(var2, ",");
  var3 = [];

  for(var4 = 0; var4 < var0.size; var4++) {
    var5 = spawnStruct();
    var5.type = var0[var4];
    var5.ml_p2_fail_start = int(var1[var4]);
    var5.modeiskillstreakallowed = int(var2[var4]);
    var5.ml_p3_to_safehouse_transition = 0;
    var3 = var5;
  }

  level.ref_12eaa = var3;
}

function minigun_manager(var0, var1, var2, var3) {
  if(!isDefined(var2)) {
    var2 = (0, 0, 0);
  }

  var4 = (0, 0, 500);
  var5 = ref_12a17(var1 + var4, var1 - var4);
  var6 = var5["position"] + (0, 0, 23);
  var7 = var2 + (0, -90, 110);
  lootstruct_offsets(var0, var3, var6);
  var8 = ref_135c6(var0, var6, var7);
  var8 radiusdamage(var6, 500, 1000, 50);
  var8 setscriptablepartstate("model", "crashed");
  var8 playSound("br_sat_sat_impact");
  playFX(scripts\engine\utility::getfx("satellite_cache_impact"), var6, anglesToForward((0, var2[1], 0)), (0, 0, 1));

  if(var0 != "none") {
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("satellite_located", var0, 1);
  }

  ref_11a93(var0, var8);
  thread ref_14482(level, var8);

  if(isDefined(level.modeupdateloadoutclass)) {
    level.modeupdateloadoutclass = scripts\engine\utility::array_add(level.modeupdateloadoutclass, var8);
    return;
  }
}

function lootstruct_offsets(var0, var1, var2) {
  var3 = var1 - var2;
  var4 = anglestoup(vectortoangles(var3));
  var5 = vectortoangles(var4);
  var6 = ref_13553(var1, var5);
  var6 endon("death");
  var6 setscriptablepartstate("model", "falling");
  var7 = distance(var1, var2);
  var8 = var7 / 3000;
  var9 = var8 * 0.75;
  var6 moveTo(var2, var8, var9, 0.05);
  var6 playLoopSound("br_sat_sat_lp");
  thread ref_12ea5(level);
  thread ref_12ea8(level);
  wait var8;
  var6 setscriptablepartstate("model", "impact");
  ref_12ea9(var2);
  var6 stoploopsound();
  var6 notify("stop_satellite_flight_rumble");
  var6 notify("stop_satellite_vehicle_crush");
  var6 delete();
}

function ref_12ea9(var0) {
  var1 = scripts\engine\trace::sphere_trace_get_all_results(var0, var0, 60);

  foreach(var3 in var1) {
    var4 = var3["entity"];
    ref_13dfd(var4, var0);
  }
}

function ref_12ea8(var0) {
  var0 endon("death");
  var0 endon("stop_satellite_vehicle_crush");

  for(;;) {
    var0 waittill("touch", var1);
    ref_13dfd(var1, var0.origin);
  }
}

function ref_13dfd(var0, var1) {
  if(!isDefined(var0) || !isalive(var0)) {
    return;
  }

  if(!var0 scripts\common\vehicle::isvehicle() && !isDefined(var0.classname)) {
    return;
  }

  if(var0.classname == "script_vehicle") {
    var0 dodamage(10 * var0.health, var1);
    return;
  }
}

function ref_13553(var0, var1) {
  var2 = spawn("script_model", var0);
  var2.angles = var1;
  var2 setModel("p9_ang_satellite_recovery_unit_full");
  return var2;
}

function ref_135c6(var0, var1, var2) {
  var3 = spawn("script_model", var1);
  var3.angles = var2;
  var3 setModel("p9_ang_satellite_recovery_unit_full_02");
  var3.id = "care_package";
  var3.use_vehicle_turret = 1;
  var3.team = var0;

  if(var0 != "none") {
    var4 = scripts\mp\utility\teams::getfriendlyplayers(var0);

    if(var4.size > 0) {
      var3 setotherent(var4[0]);
    }
  }

  return var3;
}

function ref_12ea5(var0) {
  var0 endon("death");
  var0 endon("stop_satellite_flight_rumble");
  var1 = -10000;

  for(;;) {
    var2 = (var0.origin[0], var0.origin[1], var1);
    var3 = physicstrace(var0.origin, var2);
    playrumbleonposition("artillery_rumble_heavy", var0.origin);
    playrumbleonposition("artillery_rumble_heavy", var3);
    wait 0.7;
  }
}

function ref_11a93(var0, var1) {
  var1 makeusable();

  if(var0 != "none") {
    foreach(var3 in scripts\mp\utility\teams::getfriendlyplayers(var0)) {
      var1 setotherent(var3);
      break;
    }

    var1 setscriptablepartstate("objective", "active");
  } else {
    var1 setscriptablepartstate("objective", "active_everyone");
  }

  var1 setCursorHint("HINT_NOICON");
  var1 sethintonobstruction("show");
  var1 sethinttag("tag_use");
  var1 sethintdisplayrange(128);
  var1 sethintdisplayfov(180);
  var1 setuserange(128);
  var1 setusefov(180);
  var1 setusepriority(-1);
  var1 setuseholdduration("duration_none");
  var1 setHintString(&"SATELLITE_HUNT/SATELLITE_CACHE_USE_HINT");
  var1.userate = 1;
  var1.usetime = 0;
}

function ref_11a92(var0) {
  var0 notify("satellite_cache_unusable");
  var0 makeunusable();
  var0 setscriptablepartstate("objective", "inactive");
}

function ref_14482(var0, var1) {
  var0 endon("death");
  var0 endon("satellite_cache_unusable");

  for(;;) {
    var0 waittill("trigger", var2);
    var3 = ref_13e08(var0, var2);

    if(var3) {
      if(isDefined(var1)) {
        GscBinSkip1(0x74, var1, var0, var2);
      }
    }
  }
}

function ref_13e08(var0, var1) {
  var0 endon("death");
  var0.inuse = 0;
  var0.playerusing = undefined;
  var0.curprogress = 0;
  var2 = 0;

  while(isDefined(var1) && var1 useButtonPressed()) {
    if(var0.usetime <= 0) {
      return 1;
    }

    var0.curprogress += level.framedurationseconds * var0.userate;
    var1 scripts\mp\gameobjects::updateuiprogress(var0, 1);

    if(var0.curprogress >= var0.usetime) {
      var2 = 1;
      break;
    }

    waitframe();
  }

  var1 scripts\mp\gameobjects::updateuiprogress(var0, 0);
  return var2;
}

function ref_11ff4(var0, var1) {
  var2 = ref_135c7(var0);
  ref_11a92(var0);
  var0 setscriptablepartstate("model", "open");

  if(isDefined(var1)) {
    var1 scripts\cp\vehicles\vehicle_compass_cp::ref_12005();
    var3 = [];

    for(var4 = 0; var4 < var2.size; var4++) {
      var3 = "item" + var4;
      var3 = var2[var4].type;
    }

    var3 = "time_msfrommatchstart";
    var3 = scripts\mp\matchdata::gettimefrommatchstart(gettime());
    var3 = "pos_x";
    var3 = var0.origin[0];
    var3 = "pos_y";
    var3 = var0.origin[1];
    var3 = "pos_z";
    var3 = var0.origin[2];
    var1 dlog_recordplayerevent("dlog_event_br_crash_site_recovery", var3);
    return;
  }
}

function ref_135c7(var0) {
  var1 = random_loot_override(var0);

  if(!isDefined(var1) || var1.size <= 0) {
    return [];
  }

  var2 = spawnStruct();
  var3 = anglesToForward((0, var0.angles[1] - -90, 0));
  var2.origin = var0.origin + var3 * 45;
  var2.angles = (0, var0.angles[1], 0);
  var2.itemsdropped = 0;
  var4 = var2 scripts\mp\gametypes\br_lootcache::ref_11a42(var1, 1, undefined);
  ref_13c36(var4);
  return var4;
}

function random_loot_override(var0) {
  var1 = verifybunkercode("satellite_cache", 0);

  if(!isDefined(var1)) {
    var1 = [];
  }

  var2 = gettruegroundposition();

  if(isDefined(var2)) {
    var1 = var2;
  }

  return var1;
}

function gettruegroundposition() {
  var0 = 0;

  foreach(var2 in level.ref_12eaa) {
    if(var2.ml_p3_to_safehouse_transition >= var2.modeiskillstreakallowed) {
      continue;
    }

    var0 += var2.ml_p2_fail_start;
  }

  if(var0 <= 0) {
    return undefined;
  }

  var4 = randomint(var0);
  var5 = 0;

  foreach(var2 in level.ref_12eaa) {
    if(var2.ml_p3_to_safehouse_transition >= var2.modeiskillstreakallowed) {
      continue;
    }

    var5 += var2.ml_p2_fail_start;

    if(var4 < var5) {
      return var2.type;
    }
  }

  return undefined;
}

function ref_13c36(var0) {
  foreach(var2 in var0) {
    var3 = level.ref_12eaa[var2.type];

    if(!isDefined(var3)) {
      continue;
    }

    var3.ml_p3_to_safehouse_transition++;
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

function battle_tracks_playbattletrackswhenstandingonvehicle(var0, var1, var2) {
  if(!isDefined(level.player_get_carepackage_precision_airstrike[var0])) {
    level.player_get_carepackage_precision_airstrike[var0] = [];
  }

  var3 = level.player_get_carepackage_precision_airstrike[var0].size;

  if(!isDefined(var2)) {
    var2 = (0, 0, 0);
  }

  var4 = spawnStruct();
  var4.origin = var1;
  var4.angles = var2;
  level.player_get_carepackage_precision_airstrike[var0][var3] = var4;
}

function battle_tracks_playbattletrackstoplayer(var0, var1, var2) {
  var3 = spawnStruct();
  var3.crashorigin = var1;
  var3.spawnorigin = var0;
  var3.infectsetradaronnumsurvivors = var2;
  level.player_gassed_effects[level.player_gassed_effects.size] = var3;
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
  var0 = getdvarint("scr_satellite_link_per_zone", 1);

  if(var0 <= 0) {
    return;
  }

  if(!isDefined(level.player_get_carepackage_precision_airstrike)) {
    return;
  }

  var1 = getdvarint("scr_satellite_link_total_zones", 15);

  if(var1 <= 0) {
    return;
  }

  var2 = getarraykeys(level.player_get_carepackage_precision_airstrike);
  var2 = scripts\engine\utility::array_randomize(var2);
  var3 = [];
  var4 = 0;

  for(var5 = 0; var4 < var1 && var5 < var2.size; var5++) {
    var6 = var2[var5 % var2.size];
    var7 = int(min(level.player_get_carepackage_precision_airstrike[var6].size, var0));

    if(var7 <= 0) {
      continue;
    }

    var8 = randomintrange(0, var7 + 1);
    var9 = int(min(var1 - var4, var8));
    var3 = var9;
    var4 += var9;
  }

  for(var5 = 0; var4 < var1 && var5 < var2.size; var5++) {
    var6 = var2[var5 % var2.size];

    if(var3[var6] < level.player_get_carepackage_precision_airstrike[var6].size) {
      var9 = int(min(var1 - var4, level.player_get_carepackage_precision_airstrike[var6].size - var3[var6]));
      var3 = var3[var6] + var9;
      var4 += var9;
    }
  }

  foreach(var11 in var3) {
    var12 = level.player_get_carepackage_precision_airstrike[var14];

    if(!isarray(var12)) {
      continue;
    }

    var13 = scripts\engine\utility::array_randomize(var12);

    for(var5 = 0; var5 < var13.size && var5 < var0; var5++) {
      ref_13696(var13[var5].origin, var13[var5].angles, 1);
    }
  }
}

function timevotrigger() {
  var0 = getdvarint("scr_satellite_link_per_zone", 1);

  if(var0 <= 0) {
    return;
  }

  var1 = level.struct_class_names["targetname"]["satellite_link_station"];

  if(!isDefined(var1)) {
    return;
  }

  foreach(var3 in var1) {
    var4 = level.struct_class_names["targetname"][var3.target];

    if(!isarray(var4)) {
      continue;
    }

    var4 = scripts\engine\utility::array_randomize(var4);

    for(var5 = 0; var5 < var4.size && var5 < var0; var5++) {
      var6 = var4[var5];

      if(!isDefined(var6)) {
        continue;
      }

      ref_13696(var6.origin, var6.angles);
    }
  }
}

function ref_13696(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 0;
  }

  if(!isDefined(var1)) {
    var1 = (0, 0, 0);
  }

  var3 = (0, 0, 500);
  var4 = scripts\engine\trace::ray_trace(var0 + var3, var0 - var3);
  var5 = spawn("trigger_radius", var4["position"], 0, int(128), int(72));
  var6 = scripts\mp\gametypes\obj_dom::setupobjective(var5);
  var6 scripts\mp\gameobjects::allowuse("any");
  var6 scripts\mp\gameobjects::cancontestclaim(1);
  var6 scripts\mp\gameobjects::setusetime(10);
  var6.usecondition = &mark_loot;
  var6.onbeginuse = &mark_danger_timeout;
  var6.onenduse = &domflag_onenduse;
  var6.onuse = &domflag_onuse;
  var6.onuseupdate = &domflag_onuseupdate;
  var6.lockupdatingicons = 1;
  var6.getrandompointincirclewithindistance = 1;
  var6.ref_12f83 = var2;
  getbnetigrbattlepassxpmultiplier(var6.objidnum, 450, 500);
  objective_setshowoncompass(var6.objidnum, 0);
  objective_state(var6.objidnum, "invisible");
  objective_icon(var6.objidnum, "ui_mp_br_mapmenu_icon_uplink_objective");
  var6.flagmodel setModel("p9_wz_sat_link_objective_satellite_01");
  var6.flagmodel.angles = (var4["normal"][0], var1[1], var4["normal"][2]);
  var6.flagmodel playLoopSound("br_sat_uplink_inactive_loop");
  level.ref_13641[level.ref_13641.size] = var6;
}

function ref_14015() {
  level endon("game_ended");

  if(getdvarint("satellite_link_objective_pruning", 0) == 0) {
    return;
  }

  var0 = 1;
  var1 = 1;
  var2 = 25;
  var3 = 5000;
  var4 = var3 * var3;

  for(;;) {
    if(isDefined(level.players) && level.players.size > 0 && isDefined(level.ref_13641) && level.ref_13641.size > 0) {
      for(var5 = 0; var5 < level.ref_13641.size; var5++) {
        var6 = level.ref_13641[var5];

        if(istrue(var6.trigger.trigger_off)) {
          continue;
        }

        objective_removeallfrommask(var6.objidnum);
        var7 = level.players;

        for(var8 = 0; var8 < var7.size; var8++) {
          var9 = var7[var8];

          if(isDefined(var9)) {
            var10 = distance2dsquared(var9.origin, var6.flagmodel.origin);

            if(var10 <= var4) {
              objective_addclienttomask(var6.objidnum, var9);
            }
          }

          if(var8 % var2 == 0) {
            waitframe();
          }
        }

        if(istrue(var6.trigger.trigger_off)) {
          continue;
        }

        objective_showtoplayersinmask(var6.objidnum);

        if(var5 % var1 == 0) {
          waitframe();
        }
      }
    }

    wait var0;
  }
}

function mark_loot(var0) {
  return true;
}

function mark_danger_timeout(var0) {
  self.flagmodel playLoopSound("br_sat_uplink_loop");
}

function domflag_onuseupdate(var0, var1, var2, var3) {
  if(var1 > 0.05 && var2 && !istrue(self.didstatusnotify)) {
    self.didstatusnotify = 1;
    return;
  }
}

function domflag_onuse(var0) {
  self.flagmodel endon("death");
  thread mark_phone_guy_once_all_spawned();
  var1 = "none";

  if(isDefined(var0.team)) {
    var1 = var0.team;
  }

  var2 = ["time_msfrommatchstart", scripts\mp\matchdata::gettimefrommatchstart(gettime()), "pos_x", self.flagmodel.origin[0], "pos_y", self.flagmodel.origin[1], "pos_z", self.flagmodel.origin[2]];
  var0 dlog_recordplayerevent("dlog_event_br_sat_link_secure", var2);
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("uplink_secured", var1, 1);
  self.flagmodel playSound("br_sat_uplink_connect");
  self.flagmodel setscriptablepartstate("model", "open");
  scripts\mp\gameobjects::disableobject();

  foreach(var4 in scripts\mp\utility\teams::getfriendlyplayers(var1)) {
    if(!var4 scripts\mp\gametypes\br_public::isplayeringulag() && var4 scripts\cp_mp\utility\player_utility::_isalive()) {
      var4 scripts\mp\gametypes\br_plunder::ref_12627(25);
      var4 thread scripts\mp\hud_message::showsplash("br_satlink_satellite_incoming");
    }
  }

  while(self.flagmodel getscriptablepartstate("model") != "captured") {
    waitframe();
  }

  wait randomfloatrange(1, 2);

  if(!self.ref_12f83) {
    thread modifyakimboburstrenettidamagehack(level, var1);
    return;
  }

  thread mlp2_front_truck(level, var1);
}

function domflag_onenduse(var0, var1, var2) {
  scripts\mp\gametypes\obj_dom::dompoint_onuseend(var0, var1, var2);
  self.flagmodel stoploopsound();

  if(!var2) {
    self.flagmodel playLoopSound("br_sat_uplink_inactive_loop");
    return;
  }

  if(isDefined(var1)) {
    var1 scripts\cp\vehicles\vehicle_compass_cp::ref_12083();
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

function mlp2_front_truck(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 7500;
  }

  var3 = level.player_gassed_effects;
  var4 = [];
  var5 = var2 * var2;

  foreach(var7 in var3) {
    if(isDefined(var7.used)) {
      continue;
    }

    if(distance2dsquared(var1, var7.crashorigin) > var5) {
      continue;
    }

    var4 = var7;
  }

  if(var4.size <= 0) {
    return;
  }

  var4 = scripts\engine\utility::array_randomize(var4);
  var9 = [];

  foreach(var11 in var4) {
    if(!isDefined(level.br_circle.dangercircleent) || scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(var11.crashorigin)) {
      var9 = var11;
    }
  }

  if(var9.size > 0) {
    var4 = var9;
  }

  var7 = var4[0];
  var7.used = 1;
  minigun_manager(level, var0, var7.crashorigin, var7.infectsetradaronnumsurvivors, var7.spawnorigin);
}

function modifyakimboburstrenettidamagehack(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 7500;
  }

  var3 = level.struct_class_names["targetname"]["satellite_fall_location"];

  if(!isDefined(var3)) {
    return;
  }

  var4 = [];
  var5 = var2 * var2;

  foreach(var7 in var3) {
    if(isDefined(var7.used)) {
      continue;
    }

    if(distance2dsquared(var1, var7.origin) > var5) {
      continue;
    }

    var4 = var7;
  }

  if(var4.size <= 0) {
    return;
  }

  var4 = scripts\engine\utility::array_randomize(var4);
  var7 = var4[0];
  var7.used = 1;
  var9 = level.struct_class_names["targetname"][var7.target];

  if(!isDefined(var9) || !isDefined(var9[0])) {
    return;
  }

  minigun_manager(level, var0, var7.origin, var7.angles, var9[0].origin);
}

function dangercircletick(var0, var1) {
  if(getdvarint("scr_enable_br_satellite_hunt", 0) == 0 && !istrue(level.delete_corpses)) {
    return;
  }

  var2 = var1 + 3000;
  var3 = var2 * var2;

  if(isDefined(level.ref_13641)) {
    foreach(var5 in level.ref_13641) {
      if(distance2dsquared(var5.curorigin, var0) > var3) {
        loadoutdefaultcost(var5);
      }
    }
  }

  var7 = var1 + 3000;
  var8 = var7 * var7;

  if(isDefined(level.modeupdateloadoutclass)) {
    for(var9 = level.modeupdateloadoutclass.size - 1; var9 >= 0; var9--) {
      var10 = level.modeupdateloadoutclass[var9];

      if(distance2dsquared(var10.origin, var0) > var8) {
        var10 delete();
        level.modeupdateloadoutclass = scripts\engine\utility::array_remove_index(level.modeupdateloadoutclass, var9, 0);
      }
    }

    return;
  }
}

function loadoutdefaultcost(var0) {
  if(!isDefined(var0) || istrue(var0.disabled)) {
    return;
  }

  var0.trigger triggerdisable();
  var0.disabled = 1;
  var0.flagmodel stoploopsound();
  var0 scripts\mp\gameobjects::disableobject();
}