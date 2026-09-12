/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_satellite.gsc
*************************************************************/

function init() {
  var_0 = spawnStruct();
  var_0.weight = getdvarfloat("scr_br_pe_satellite_weight", 0);
  var_0.ref_140cf = &ref_140cf;
  var_0.ref_14382 = &ref_14382;
  var_0.attackerswaittime = &attackerswaittime;
  var_0.isfeaturedisabled = &isfeaturedisabled;
  var_0.postinitfunc = &postinitfunc;
  var_0.ref_11b78 = getdvarint("scr_br_pe_satellite_max_times", 1);
  var_0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx("satellite", "20 2020205 0 0 0");
  var_0.pemetereventweights = scripts\mp\gametypes\br_publicevents_meter::getdvarpemetereventweights("satellite");
  scripts\mp\gametypes\br_publicevents::ref_12b35(7, var_0);
}

function postinitfunc() {
  game["dialog"]["satellite_located"] = "satellite_located";
  thread deletecircle();
}

function ref_140cf() {
  return true;
}

function ref_14382() {
  level endon("game_ended");
  level endon("cancel_public_event");
}

function attackerswaittime() {
  level endon("game_ended");
  scripts\mp\gametypes\br_publicevents::ref_13371("br_pe_satellite_start");
  scripts\mp\gametypes\br_public::brleaderdialog("satellite_located", 1);
  level scripts\mp\gametypes\br_satellite_hunt::tank_arrive_and_fire();
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
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "harpSpawned", &scripts\mp\gametypes\br_satellite_hunt::setupweaponattachmentoverrides);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "harpTimeout", &scripts\mp\gametypes\br_satellite_hunt::setupx1timelimit);
  terminateriotshield();
  level scripts\mp\gametypes\br_satellite_hunt::tank_arrive_and_fire();
  level thread scripts\mp\gametypes\br_satellite_hunt::deletecircle();
  level.delete_corpses = 1;
  level.modeupdateloadoutclass = [];
  modifybrfalldamage();
}

function isfeaturedisabled() {}

function terminateriotshield() {
  level.player_gassed_effects = [];
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((-42206, 30546, 15594), (-21206, 55546, 3258), (0, 63, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((-7587, 73408, 15594), (-28587, 48408, 2621), (0, 231, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((5434, 42408, 15594), (-15434, 62784, 1890), (0, 133, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((1358, 45734, 15594), (-19642, 20734, -390), (0, 238, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((-38950, -9330, 15594), (-17950, 15670, -267), (0, 57, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((15000, 40711, 15594), (-6147, 20711, -298), (0, 218, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((21050, 72623, 15594), (50, 47623, 1786), (0, 240, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((27637, 73473, 15594), (6637, 48473, 1082), (0, 226, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((25637, 73557, 15594), (3434, 53557, 1082), (0, 234, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((-1855, -41818, 15594), (22914, -16594, -158), (0, 49, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((48000, 15912, 15594), (26741, -5912, -398), (0, 233, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((-3944, -4366, 15594), (27516, -14650, -206), (0, 337, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((55974, 63705, 15594), (34974, 38705, 767), (0, 227, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((16974, 21705, 15594), (36216, 41247, 1382), (0, 55, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((9008, 10518, 15594), (30008, 35518, 639), (0, 54, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((710, -3670, 15594), (21710, 22670, 1658), (0, 45, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((51763, 46740, 15594), (30763, 21740, 728), (0, 230, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((39099, 28563, 15594), (28099, 3563, -520), (0, 246, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((10099, -14500, 15594), (33112, 6457, -539), (0, 42, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((13642, -25493, 15594), (34642, -493, -672), (0, 60, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((73223, 10097, 15594), (52223, -15097, -336), (0, 229, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((63223, 8097, 15594), (44410, -13675, -49), (0, 228, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((64356, 13848, 15594), (43356, -12848, -51), (0, 241, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((-28813, -21412, 15594), (-7813, 3588, -296), (0, 49, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((10603, 36659, 15594), (-11603, 11659, -249), (0, 230, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((4603, 26659, 15594), (-17047, 8088, -263), (0, 219, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((-49541, -35754, 15594), (-28541, -10754, -70), (0, 48, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((-2089, 12133, 15594), (-23089, -12867, -135), (0, 220, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((-34198, -43327, 15594), (-13198, -18327, -310), (0, 54, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((-26949, -33422, 15594), (-5949, -8422, -359), (0, 49, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((9586, -52505, 15594), (30586, -27505, -508), (0, 44, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((-15193, -45559, 15594), (36193, -20559, -508), (0, 25, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((30115, -26887, 15594), (51115, -1887, 156), (0, 50, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((69480, 32243, 15594), (48480, 7243, 35), (0, 237, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((-26000, -47000, 15594), (-6755, -29018, 90), (0, 49, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((-32000, 0, 15594), (-11306, -20228, -304), (0, 314, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((-43000, -12000, 15594), (-23028, 8447, -260), (0, 47, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((25000, -15642, 15594), (45195, 4358, -42), (0, 38, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((22000, -25000, 15594), (42167, -6352, 279), (0, 20, 0));
  scripts\mp\gametypes\br_satellite_hunt::battle_tracks_playbattletrackstoplayer((-47000, -39000, 15594), (-27520, -19542, -200), (0, 50, 0));
}

function modifybrfalldamage() {
  var_0 = scripts\engine\utility::array_randomize(level.player_gassed_effects);
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isDefined(level.br_circle.dangercircleent) || scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(var_3.crashorigin)) {
      var_1 = var_3;
    }
  }

  var_5 = getdvarint("scr_br_pe_satellite_num_falling", 12);

  if(var_1.size < var_5) {
    var_5 = var_1.size;
  }

  for(var_6 = 0; var_6 < var_5; var_6++) {
    var_3 = var_1[var_6];
    var_3.used = 1;
    level scripts\mp\gametypes\br_satellite_hunt::minigun_manager("none", var_3.crashorigin, var_3.infectsetradaronnumsurvivors, var_3.spawnorigin);
  }
}

function deletecircle() {
  wait 5;
  scripts\mp\utility\sound::besttime("br_event_satellite_sfx");
}