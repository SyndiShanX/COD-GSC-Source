/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_fresno.gsc
**********************************************************/

function init() {
  var_0 = spawnStruct();
  var_0.ref_140CF = &ref_140CF;
  var_0.weight = getdvarfloat("scr_br_pe_fresno_weight", 100);
  var_0.ref_14382 = &ref_14382;
  var_0.attackerswaittime = &attackerswaittime;
  var_0.isfeaturedisabled = &players_approach_puzzle_monitor;
  var_0.postinitfunc = &postinitfunc;
  var_0.ref_11B78 = getdvarint("scr_br_pe_fresno_max_times", 2);
  var_0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx("fresno", "0951075100 0 0 0");
  var_0.pemetereventweights = scripts\mp\gametypes\br_publicevents_meter::getdvarpemetereventweights("fresno");
  scripts\mp\gametypes\br_publicevents::ref_12B35(16, var_0);
}

function postinitfunc() {
  var_0 = self;
  game["dialog"]["public_events_fresno_start"] = "gametype_desc_titans";
  game["dialog"]["public_events_fresno_top_reward"] = "oshkosh_reward";
  game["dialog"]["public_events_g_staggered"] = "greenbay_titan_retreat";
  game["dialog"]["public_events_k_staggered"] = "kenosha_titan_retreat";
  var_0.secondsbeforeplacementupdates = getdvarint("scr_br_pe_fresno_health_per", 2000);
  level.ref_11E18.playerredeploy = getdvarint("scr_br_pe_fresno_frenzy_radius", 11000);
  level.br_pe_grabbag_skipwait = 0;
  setdvarifuninitialized("scr_br_pe_fresno_hwc_fadestart", 5000);
  setdvarifuninitialized("scr_br_pe_fresno_hwc_fadeend", 7000);
  thread begineventcountdown();
  level.ref_11E18.frenzy_count = 0;
  level.ref_11E18.frenzy_trigger_index = getdvarint("scr_br_pe_fresno_screamer_trigger", 0);
  thread strip_node_flag_wait();
  init_reward_crates();
  thread monitor_circles();
  thread set_real_time();
}

function set_real_time() {
  level.ref_11E18.basetime = gettime();
  level waittill("prematch_done");
  level.ref_11E18.basetime = gettime();
}

function get_real_time() {
  return (gettime() - level.ref_11E18.basetime) / 1000;
}

function monitor_circles() {
  level endon("game_ended");

  for(;;) {
    level waittill("br_circle_set", var_0);
    var_1 = level.br_level.br_circledelaytimes[var_0 - 1];
    var_2 = level.br_level.br_circleclosetimes[var_0 - 1];
    var_3 = level.br_level.br_circledelaytimes[var_0];
    level.ref_11E18.safe_circle_end_time = gettime() + 1000 * (var_1 + var_2 + var_3);
  }
}

function begineventcountdown() {
  level endon("game_ended");
  level waittill("prematch_done");
  level.ref_11E18.eventstarttimes = tokenizefloatsfromstring(getDvar("scr_br_pe_fresno_activation_time", "140.0 290.0"));
  level.ref_11E18.eventwarningtimes = tokenizefloatsfromstring(getDvar("scr_br_pe_fresno_incoming_time", "30.0 30.0"));
  calculateeventcircles();
  eventcountdown_internal();
}

function tokenizefloatsfromstring(var_0) {
  var_1 = [];

  if(var_0 != "") {
    var_2 = strtok(var_0, " ");

    foreach(var_4 in var_2) {
      var_1 = float(var_4);
    }
  }

  return var_1;
}

function calculateeventcircles() {
  level.ref_11E18.event_circles = [];

  for(var_0 = 0; var_0 < level.ref_11E18.eventstarttimes.size; var_0++) {
    var_1 = level.ref_11E18.eventstarttimes[var_0];
    var_2 = 0;
    var_3 = -1;

    for(var_4 = 0; var_4 < level.br_level.br_circledelaytimes.size; var_4++) {
      var_2 += level.br_level.br_circledelaytimes[var_4] + level.br_level.br_circleclosetimes[var_4];

      if(var_1 <= var_2) {
        var_3 = var_4;
        break;
      }
    }

    level.ref_11E18.event_circles[var_0] = var_3;
  }
}

function eventcountdown_internal() {
  for(var_0 = 0; var_0 < level.ref_11E18.eventstarttimes.size; var_0++) {
    var_1 = level.ref_11E18.eventstarttimes[var_0];
    var_2 = level.ref_11E18.eventwarningtimes[var_0];
    var_1 -= var_2;
    wait var_1;
    launchevent(var_2);
  }
}

function launchevent(var_0) {
  if(!isDefined(level.ref_11E18)) {
    return;
  }

  if(isDefined(level.ref_11E18.fresno_ready))) {
  iprintln("Warning: Fresno is ignoring activation request, it is already running.");
  return;
}

if(isDefined(level.ref_11E18.setincomingremovedcallback) && isDefined(level.ref_11E18.setincomingremovedcallback.ref_12930) || isDefined(level.ref_11E18.wait_for_next_hack_complete) && isDefined(level.ref_11E18.wait_for_next_hack_complete.ref_12930)) {
  iprintln("Warning: Fresno is ignoring activation request, it is already running.");
  return;
}

scripts\mp\gametypes\br_publicevents::ref_13371("br_pe_fresno_inc");
level notify("fresno_start");
thread activatetomahs(var_0);
wait 8;
setomnvar("ui_publicevent_timer_type", 0);
setomnvar("ui_publicevent_timer_type", 11);
var_0 -= 8;
var_1 = gettime() + var_0 * 1000;
setomnvar("ui_publicevent_timer", var_1);
wait var_0;
thread activateevent();
}

function attackerswaittime() {
  launchevent(14);
}

function ref_140CF() {
  return scripts\mp\utility\game::round_vehicle_logic() == "mendota" && isDefined(level.ref_11E18);
}

function ref_14382() {}

function activatetomahs(var_0) {
  level endon("game_ended");
  self.active = 1;
  var_1 = gettime() + (var_0 + getdvarfloat("scr_br_pe_fresno_lifetime", 120)) * 1000;
  level.ref_11E18.pe_endtime = var_1;
  level.ref_1406F = 1;
  level.ref_11A1F = [];
  level.ref_1395A = [];
  scripts\mp\gametypes\br_gametype_truckwar::stoppingpower_givehcrdata();

  if(isDefined(level.ref_11E18.setincomingremovedcallback) && isDefined(level.ref_11E18.wait_for_next_hack_complete)) {
    var_2 = getDvar("scr_br_pe_fresno_die_roll");

    if(var_2.size == 0) {
      level.ref_11E18.setincomingremovedcallback.ref_12930 = &sentry_init_done;
      level.ref_11E18.wait_for_next_hack_complete.ref_12930 = &vehicle_rider_think;
      return;
    }

    var_3 = randomint(10);
    var_4 = int(var_2);

    if(var_4 > -1) {
      var_3 = var_4;
    }

    if(var_3 < 3 || var_3 >= 6) {
      level.ref_11E18.setincomingremovedcallback.ref_12930 = &sentry_init_done;
    }

    if(var_3 >= 3) {
      level.ref_11E18.wait_for_next_hack_complete.ref_12930 = &vehicle_rider_think;
      return;
    }

    return;
  }

  var_5 = "Both Fresno actors were unavailable!!";

  if(isDefined(level.ref_11E18.setincomingremovedcallback)) {
    level.ref_11E18.setincomingremovedcallback.ref_12930 = &sentry_init_done;
    return;
  }

  if(isDefined(level.ref_11E18.wait_for_next_hack_complete)) {
    level.ref_11E18.wait_for_next_hack_complete.ref_12930 = &vehicle_rider_think;
    return;
  }
}

function activateevent() {
  level endon("game_ended");
  level.ref_11E18.ref_12F14 = &lootleadermarksizedynamic;
  scripts\mp\gametypes\br_publicevents::ref_13371("br_pe_fresno_start");
  level thread scripts\mp\gametypes\br_public::brleaderdialog("public_events_fresno_start");
  setomnvar("ui_publicevent_minimap_pulse", 1);
  setomnvar("ui_publicevent_timer_type", 8);
  setomnvar("ui_publicevent_timer", level.ref_11E18.pe_endtime);
  thread ref_11CDC(level.ref_11E18.pe_endtime);
  var_0 = register_vehicle_spawn_override();
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(istrue(level.disable_super_in_turret.ref_12CA4)) {
      var_4 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_3);
    } else {
      var_4 = scripts\mp\gametypes\br_public::rotationrefsbyseatandweapon(var_3);
    }

    var_1 += var_4.size;
  }

  self.secondwindthink = var_1 * self.secondsbeforeplacementupdates;
  teamlist();
  totaldamage();
  thread ref_13FD0();
  level.ref_11E18.players_grenade_fire_monitor = 0;

  if(level.ref_11E18.frenzy_trigger_index != 0) {
    scripts\mp\gametypes\fresno\fresno_screamer::choosescreamertitan();
  }

  level.ref_11E18.frenzy_count++;
  level.ref_11E18.fresno_ready) = 1;
level waittill("fresno_end");
}

function attackerisinflictorforradiusexplosiveweapon(var_0, var_1) {
  if(getdvarint("scr_br_pe_fresno_disable_drops", 0)) {
    return;
  }

  var_2 = spawn("trigger_radius", var_0, 0, level.ref_11E18.playerredeploy, 50000);
  var_2.radius = level.ref_11E18.playerredeploy;
  var_1.cashtorefund = var_2;

  if(scripts\mp\outofbounds::unset_relic_rocket_kill_ammo(var_2.origin)) {
    ref_136B1(var_2);
    ref_136A3(var_2);
    addweaponvehicledropcircle(var_2);
    return;
  }
}

function activatescreamerdrop(var_0, var_1) {
  if(level.ref_11E18.frenzy_trigger_index < 0 || level.ref_11E18.frenzy_trigger_index > 0 && level.ref_11E18.frenzy_trigger_index == level.ref_11E18.frenzy_count) {
    if(var_1 < var_0.radius) {
      var_2 = var_1 / var_0.radius;
      var_3 = max(var_2, 0.95);
      var_4 = scripts\mp\gametypes\br_circle::getrandompointincircle(var_0.origin, var_0.radius, var_2, var_3, 0, 0);

      if(scripts\mp\gametypes\br_circle::getdangercircleradius() > 0) {
        if(scripts\mp\gametypes\br_circle::updateprestreamrespawn(var_4) == 0) {
          var_4 = (var_4[0] * -1, var_4[1], var_4[2]);

          if(scripts\mp\gametypes\br_circle::updateprestreamrespawn(var_4) == 0) {
            var_4 = (var_4[0], var_4[1] * -1, var_4[2]);

            if(scripts\mp\gametypes\br_circle::updateprestreamrespawn(var_4) == 0) {
              var_4 = (var_4[0] * -1, var_4[1], var_4[2]);

              if(scripts\mp\gametypes\br_circle::updateprestreamrespawn(var_4) == 0) {
                var_4 = undefined;
                iprintln("Failed to spawn screamer crate");
              }
            }
          }
        }
      }

      if(isDefined(var_4)) {
        var_4 = scripts\mp\gametypes\br_public::modifyplayer_damage(var_4);
        scripts\mp\gametypes\fresno\fresno_screamer::spawnmalfunctioningscreamerdevice(var_0.origin, var_4);
        return;
      }

      return;
    }

    return;
  }
}

function ref_136B1(var_0) {
  level.ref_11A1F[level.ref_11A1F.size] = var_0;
  scripts\mp\gametypes\br_publicevent_lootcratedrop::aud_breached_exit_wind();
}

function ref_136A3(var_0) {
  var_1 = getdvarint("scr_br_pe_fresno_aa", 5);

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = spawnStruct();
    var_3.origin = scripts\mp\gametypes\br_publicevent_lootcratedrop::return_same_module_as_next_module(var_0.origin, var_0.radius);
    var_3.origin = (var_3.origin[0], var_3.origin[1], var_3.origin[2] + getdvarfloat("scr_br_fresno_truck_height", 6000));
    var_3.angles = var_0.angles;
    var_4 = scripts\mp\gametypes\br_vehicles::tryspawnavehicle("cargo_truck_susp_aa", var_3, "alwaysSpawn", undefined);

    if(isDefined(var_4)) {
      level thread scripts\mp\gametypes\br_gametype_truckwar::ref_13DE4(var_4, var_3.origin, var_3.angles, 1);
    }
  }
}

function table_parseweaponvariantidvalue() {
  if(istrue(level.ref_11E18.players_grenade_fire_monitor)) {
    return;
  }

  level.ref_11E18.players_grenade_fire_monitor = 1;
  var_0 = gettime() + getdvarfloat("scr_br_pe_fresno_lifetime", 120) * 1000;
  level.ref_11E18.playerregenhealthadd = var_0;
  clearweaponvehicledropcircles();
}

function strip_node_flag_wait() {
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  waittillframeend();
  var_0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("heavy_weapon_crate");
  var_0.disablecratedropvfx = 1;
  var_0.disablesplash = 1;
  var_0.objectiveiconoverride = "heavy_weapon_mendota";
  level.br_pe_crate_usetimeoverride = var_0.ownerusetime;
  level.delaystreamtomovingplane = 1;
  level.shrink_poi_into_the_bank.besttimestate = 0;
  level.shrink_poi_into_the_bank.ref_13EFF = [["brloot_weapon_lm_dblmg_lege", "brloot_ammo_762"], ["brloot_weapon_rebirth_lm_iw8", "brloot_ammo_762"], ["brloot_weapon_rebirth_lm_t9", "brloot_ammo_762"]];
  level.shrink_poi_into_the_bank.chopper_gunner = [["brloot_weapon_s4_la_palpha42_epic", "brloot_ammo_rocket"], ["brloot_weapon_s4_la_palpha_epic", "brloot_ammo_rocket"], ["brloot_weapon_s4_la_m1bravo_rare", "brloot_ammo_rocket"]];
  level.shrink_poi_into_the_bank.waypoints = [["brloot_weapon_s4_mg_dpapa27_lege", "brloot_ammo_762"], ["brloot_weapon_s4_mg_mgolf42_lege", "brloot_ammo_762"], ["brloot_weapon_s4_mg_tyankee11_lege", "brloot_ammo_762"], ["brloot_weapon_s4_mg_bromeo37_lege", "brloot_ammo_762"], ["brloot_weapon_mendota_sn_xmike109", "brloot_ammo_50cal"], ["brloot_weapon_mendota_mr_ptango41", "brloot_ammo_50cal"]];
  level.shrink_poi_into_the_bank.waypoint_icon = level.shrink_poi_into_the_bank.waypoints;
  level.shrink_poi_into_the_bank.weapon_xp_iw8_pi_mike1911 = [["brloot_offhand_molotov", 2], ["brloot_offhand_thermite", 2], ["brloot_offhand_frag", 2]];
}

function tac_cover_spawn_with_door() {
  game["dialog"]["match_start"] = "gametype_resurgence";
  game["dialog"]["match_desc"] = "gametype_desc_resurgence";
  game["dialog"]["last_man_standing"] = "rsrg_squad_last_alive";
  game["dialog"]["rebirth_avenge_teammate"] = "rebirth_avenge_teammate";
  game["dialog"]["rebirth_redeploy"] = "rebirth_redeploy";
  game["dialog"]["rebirth_disabled"] = "rebirth_reinforcement_disabled";
  game["dialog"]["rebirth_ending"] = "rebirth_reinforcement_ending";
  game["dialog"]["rebirth_teammate_respawn"] = "rebirth_teammate_respawn";
}

function ref_11CDC(var_0) {
  level endon("game_ended");
  level endon("fresno_end");

  for(;;) {
    var_1 = gettime();

    if(var_1 >= var_0) {
      break;
    }

    waitframe();
  }

  thread playerrespawncleanup();
}

function vehicle_rider_think(var_0) {
  scripts\mp\gametypes\fresno\fresno_state_machines::kheadtofrenzypoint(var_0);
  var_0 thread scripts\mp\gametypes\fresno\fresno_state_machines::trunidlewait("s4_mp_kenosha_idle_lookaround_01");

  while(!istrue(level.ref_11E18.fresno_ready))) {
  waitframe();
}

table_parseweaponvariantidvalue();

if(!isDefined(var_0.cashtorefund)) {
  var_1 = spawn("trigger_radius", var_0.origin, 0, level.ref_11E18.playerredeploy, 50000);
  var_1.radius = level.ref_11E18.playerredeploy;
  var_0.cashtorefund = var_1;
} else {
  var_1 = var_1.cashtorefund;
}

var_1.subdued = undefined;

if(isDefined(level.ref_11E18.screamerkk)) {
  thread activatescreamerdrop(level, var_1);
}

var_1 setscriptablepartstate("objective", "objective_enable_danger", 0);
scripts\mp\gametypes\fresno\fresno_state_machines::wait_juggernaut_announce(var_1);

while(scripts\mp\gametypes\fresno\fresno_state_machines::vehicle_occupancy_showcashbag(var_1)) {
  scripts\mp\gametypes\fresno\fresno_state_machines::wait_for_tank_death(var_1);

  if(scripts\mp\gametypes\fresno\fresno_state_machines::vehicle_occupancy_showcashbag(var_1)) {
    scripts\mp\gametypes\fresno\fresno_state_machines::wait_for_tanks_almost_gone(var_1);
  }
}

var_1 setscriptablepartstate("objective", "objective_enable", 0);
scripts\mp\gametypes\fresno\fresno_state_machines::kreturntonormal(var_1);

if(isDefined(level.ref_11E18.screamerkk)) {
  level.ref_11E18.screamerkk = undefined;
  level thread scripts\mp\gametypes\fresno\fresno_screamer::destroyscreamer();
}

var_1.ref_11EA7 = 1;
var_1.cashtorefund = undefined;
level.ref_11E18.wait_for_next_hack_complete.ref_12930 = undefined;

if(!isDefined(level.ref_11E18.setincomingremovedcallback.ref_12930)) {
  thread playerrespawncleanup();
  return;
}
}

function sentry_init_done(var_0) {
  var_1 = getdvarfloat("scr_br_pe_fresno_gz_offset", 1.16667);
  var_2 = vectorNormalize(scripts\mp\gametypes\br_circle::getsafecircleorigin() - var_0.origin);
  var_3 = level.ref_11E18.playerredeploy * var_1;
  var_4 = var_0.origin + var_2 * var_3;
  level.ref_11E18.score_event_headshot = undefined;
  scripts\mp\gametypes\fresno\fresno_state_machines::gheadtofrenzypoint(var_0);
  var_0 thread scripts\mp\gametypes\fresno\fresno_state_machines::trunidlewait("s4_mp_greenbay_idle_lookaround_01");

  while(!istrue(level.ref_11E18.fresno_ready)) && scripts\mp\gametypes\br_publicevents::upload_station_interact_used_think(16)) {
  waitframe();
}

table_parseweaponvariantidvalue();
var_0 setscriptablepartstate("objective", "objective_enable_danger", 0);

if(!isDefined(var_0.cashtorefund)) {
  var_5 = spawn("trigger_radius", var_4, 0, level.ref_11E18.playerredeploy, 50000);
  var_5.radius = level.ref_11E18.playerredeploy;
  var_0.cashtorefund = var_5;
} else {
  var_5 = var_1.cashtorefund;
}

var_1.subdued = undefined;

if(isDefined(level.ref_11E18.screamergg)) {
  thread activatescreamerdrop(level, var_5);
}

scripts\mp\gametypes\fresno\fresno_state_machines::set_dvars(var_1);

while(scripts\mp\gametypes\fresno\fresno_state_machines::post_blockade_breadcrumb_struct(var_1)) {
  scripts\mp\gametypes\fresno\fresno_state_machines::select_woods_two_spawners(var_1);

  if(scripts\mp\gametypes\fresno\fresno_state_machines::post_blockade_breadcrumb_struct(var_1)) {
    scripts\mp\gametypes\fresno\fresno_state_machines::send_munition_used_notify(var_1);
  }
}

var_1 setscriptablepartstate("objective", "objective_enable", 0);
scripts\mp\gametypes\fresno\fresno_state_machines::set_door_open(var_1);

if(isDefined(level.ref_11E18.screamergg)) {
  level.ref_11E18.screamergg = undefined;
  level thread scripts\mp\gametypes\fresno\fresno_screamer::destroyscreamer();
}

var_1.ref_11EA7 = 1;
var_1.cashtorefund = undefined;
level.ref_11E18.setincomingremovedcallback.ref_12930 = undefined;

if(!isDefined(level.ref_11E18.wait_for_next_hack_complete.ref_12930)) {
  thread playerrespawncleanup();
  return;
}
}

function playerrespawncleanup() {
  ref_11EC4();
  level.ref_11E18.pe_endtime = undefined;
  scripts\mp\gametypes\br_publicevents::neurotoxin_mask_monitor(16);
}

function players_approach_puzzle_monitor() {
  setomnvar("ui_publicevent_minimap_pulse", 0);
  setomnvar("ui_publicevent_timer_type", 0);
  wait 0.1;
  mp_port2_gw_patch();
  scripts\mp\gametypes\fresno\fresno_screamer::endevent_malfunctioningscreamerdevice();
  recordeventendanalytics();
  print_event_logs();
  level.ref_11E18.fresno_ready) = undefined;
}

function ref_11EC4() {
  level notify("fresno_end");
}

function post_safeges_weapon() {
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, (-6969, -62217, -628));
}

function teamlist() {
  var_0 = getDvar("scr_be_fresno_attack_odds_table", "30 50 70");
  var_1 = strtok(var_0, " ");

  if(var_1.size != 3) {
    var_1 = strtok("30 50 70", " ");
  }

  level.ref_11E18.cave_barrels = [];
  level.ref_11E18.cave_barrels["best_team"] = int(var_1[0]);
  level.ref_11E18.cave_barrels["random_team"] = int(var_1[1]);
  level.ref_11E18.cave_barrels["tomah_anger"] = int(var_1[2]);
}

function propspectating(var_0, var_1) {
  if(!isDefined(level.ref_11E18.cave_barrels)) {
    return undefined;
  }

  level.ref_11E18.ref_12F14 = &lootleadermarksizedynamic;
  var_2 = undefined;
  var_3 = randomint(100);
  var_3 = getdvarint("scr_br_pe_fresno_attack_die_roll", var_3);

  if(var_3 < level.ref_11E18.cave_barrels["random_team"]) {
    var_4 = scripts\mp\gametypes\_mxp_target::recharge_equipment_init(var_3 < level.ref_11E18.cave_barrels["best_team"]);

    if(isDefined(var_4)) {
      var_5 = self.cashtorefund scripts\mp\gametypes\_mxp_target::quarry2_ambient_sound_load(var_4);

      if(isDefined(var_1)) {
        var_6 = var_1.team;
        var_7 = var_1 getsquadindex();
        var_8 = var_5;
        var_5 = [];

        foreach(var_10 in var_8) {
          if(var_10.team != var_6 || var_10 getsquadindex() != var_7) {
            var_5 = var_10;
          }
        }
      }

      if(var_5.size > 0) {
        var_12 = randomint(var_5.size);
        var_2 = var_5[var_12];
      }
    }
  }

  if(!isDefined(var_2) && var_3 < level.ref_11E18.cave_barrels["tomah_anger"]) {
    var_2 = scripts\mp\gametypes\br_alt_mode_mxp::tgetnextangertarget(self);

    if(isDefined(var_2)) {}
  }

  if(!isDefined(var_2)) {
    var_2 = self.cashtorefund scripts\mp\gametypes\_mxp_target::printspawnmessage(var_0, level.ref_11E18.playerredeploy, var_1);

    if(isDefined(var_2)) {}
  }

  if(!isDefined(var_2)) {
    var_2 = self.cashtorefund scripts\mp\gametypes\_mxp_target::pristinestatehealthadd(var_0, level.ref_11E18.playerredeploy);
  }

  return var_2;
}

function totaldamage() {
  level.ref_13AAA = [];

  foreach(var_1 in level.teamnamelist) {
    if(isDefined(level.teamdata[var_1]) && isDefined(level.teamdata[var_1]["aliveCount"]) && level.teamdata[var_1]["aliveCount"] > 0) {
      level.ref_13AAA[var_1] = 0;
    }
  }

  foreach(var_4 in level.players) {
    if(isDefined(var_4)) {
      var_5 = spawnStruct();
      var_5.ref_13BEE = 0;
      var_5.ref_14239 = 0;
      var_5.open_cac_slot = 0;
      var_5.ref_1457E = 0;
      var_4.ref_12532 = var_5;
    }
  }

  level.ref_11E18.ref_13BEF = [];
  level.ref_11E18.ref_13BEF["actor_kenosha"] = 0;
  level.ref_11E18.ref_13BEF["actor_greenbay"] = 0;
}

function ref_13FD0() {
  level endon("game_ended");
  level endon("cancel_public_event");
  level endon("fresno_end");
  var_0 = 0.1;
  var_1 = level.delayedeventtypes[16].secondwindthink * 2;
  var_2 = 1;

  for(;;) {
    var_3 = relic_mythic_should_do_pain();
    var_4 = var_3[0][0];
    var_5 = var_3[0][1];
    var_6 = var_3[1][0];
    var_7 = var_3[1][1];
    var_8 = level.ref_11E18.ref_13BEF["actor_greenbay"] + level.ref_11E18.ref_13BEF["actor_kenosha"];
    var_9 = var_8 / var_1;
    setomnvar("ui_pe_fresno_total_damage", var_9);
    var_2 = var_5 / var_1;
    setomnvar("ui_pe_fresno_first_place_squad_damage", var_2);

    foreach(var_11 in level.players) {
      var_12 = updateplayerandteamcountui(var_11);
      var_11 setclientomnvar("ui_pe_fresno_is_in_range", 1);
      var_2 = 0;
      var_13 = level.ref_13AAA[var_11.team];

      if(isDefined(var_13)) {
        var_2 = var_13 / var_1;
      }

      var_11 setclientomnvar("ui_pe_fresno_player_squad_damage", var_2);
    }

    wait var_0;
  }
}

function sec_sys_struct_3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  var_14 = var_1;

  if(isDefined(var_1.classname) && (var_1.classname == "script_vehicle" || var_1.classname == "misc_turret")) {
    if(isDefined(var_1.owner)) {
      var_14 = var_1.owner;
    }
  }

  if(isPlayer(var_14)) {
    var_14 scripts\mp\gametypes\br_alt_mode_mxp::playerupdatetomahdamage(self, var_2, var_4, var_5, 1);

    if(!istrue(level.ref_11E18.fresno_ready)) || level.ref_11E18.ref_13BEF[self.agent_type] >= level.delayedeventtypes[16].secondwindthink) {
    return;
  }

  if(!isDefined(level.ref_13AAA[var_14.team])) {
    level.ref_13AAA[var_14.team] = 0;
  }

  if(!isDefined(var_14.ref_12532)) {
    var_15 = spawnStruct();
    var_15.ref_13BEE = 0;
    var_15.ref_14239 = 0;
    var_15.open_cac_slot = 0;
    var_15.ref_1457E = 0;
    var_14.ref_12532 = var_15;
  }

  if(vault_assault_infil(var_0, var_1)) {
    var_2 = ref_11CA1(var_2, var_0, var_1);
    var_2 = clampdamageforhealth(var_2);
    var_14.ref_12532.ref_14239 += var_2;
  } else if(isexplosivedamage(var_4)) {
    var_2 *= getdvarfloat("scr_br_pe_fresno_expl_dmgmult", 5);
    var_2 = clampdamageforhealth(var_2);
    var_14.ref_12532.open_cac_slot += var_2;
  } else {
    var_2 *= getdvarfloat("scr_br_pe_fresno_weap_dmgmult", 1);
    var_2 = clampdamageforhealth(var_2);
    var_14.ref_12532.ref_1457E += var_2;
  }

  level.ref_13AAA[var_14.team] += var_2;
  var_14.ref_12532.ref_13BEE += var_2;
  var_14 scripts\mp\damagefeedback::updatedamagefeedback("standard", 0, 0, "standard", 0, 1);
  var_14.players_in_aggro = self.agent_type;
  level.ref_11E18.ref_13BEF[self.agent_type] += var_2;

  if(level.ref_11E18.ref_13BEF[self.agent_type] > level.delayedeventtypes[16].secondwindthink) {
    self notify("gk_driven_off");
  }

  var_16 = level.ref_11E18.ref_13BEF[self.agent_type] / level.delayedeventtypes[16].secondwindthink;

  if(self.agent_type == "actor_kenosha") {
    setomnvar("ui_pe_fresno_progress_kenosha", var_16);
    return;
  }

  if(self.agent_type == "actor_greenbay") {
    setomnvar("ui_pe_fresno_progress_greenbay", var_16);
    return;
  }

  return;
}
}

function secondaryweaponbackup(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {}

function relic_mythic_should_do_pain() {
  if(!isDefined(self.is_wave_exist)) {
    self.is_wave_exist = [["none", -1], ["none", -1], ["none", -1], ["none", -1]];
  }

  foreach(var_5, var_1 in level.ref_13AAA) {
    for(var_2 = 0; var_2 < self.is_wave_exist.size; var_2++) {
      var_3 = self.is_wave_exist[var_2][0];
      var_4 = self.is_wave_exist[var_2][1];

      if(var_1 > var_4 || var_3 == var_5) {
        if(var_5 != var_3 && var_2 + 1 < self.is_wave_exist.size) {
          self.is_wave_exist[var_2 + 1] = self.is_wave_exist[var_2];
        }

        self.is_wave_exist[var_2][0] = var_5;
        self.is_wave_exist[var_2][1] = var_1;
        break;
      }
    }
  }

  return self.is_wave_exist;
}

function ref_11CA1(var_0, var_1, var_2) {
  if(var_1.classname == "script_model" && var_1.model == "lm_ach_gp_bomb_600lb_01_gameplay") {
    var_0 = getdvarfloat("scr_br_pe_fresno_bt_dmg", 5000);
  } else if(var_1.classname == "misc_turret" && var_1.model == "veh_s4_mil_lnd_turret_quad_aa_wz") {
    var_0 = getdvarfloat("scr_br_pe_fresno_flak_dmg", 100);
  } else {
    var_0 *= getdvarfloat("scr_br_pe_fresno_veh_dmgmult", 1);
  }

  return var_0;
}

function clampdamageforhealth(var_0) {
  var_1 = level.delayedeventtypes[16].secondwindthink;
  var_2 = level.ref_11E18.ref_13BEF[self.agent_type];

  if(var_0 + var_2 > var_1) {
    return (var_1 - var_2);
  }

  return var_0;
}

function mp_port2_gw_patch() {
  var_0 = relic_mythic_should_do_pain();
  var_1 = ["br_pe_1st_place", "br_pe_2nd_place", "br_pe_3rd_place", "br_pe_4th_place"];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2][0];

    if(var_3 == "none") {
      continue;
    }

    var_4 = scripts\mp\utility\teams::getfriendlyplayers(var_3, 0);

    foreach(var_6 in var_4) {
      var_6 scripts\cp\vehicles\vehicle_compass_cp::ref_12004("mv_event_intel_12");
    }

    showsplashtoteam(var_3, var_1[var_2]);

    if(var_2 == 0) {
      level thread scripts\mp\gametypes\br_public::dmztut_luicallback("public_events_fresno_top_reward", var_3);
      thread endevent_spawnrewardcache(level, "fresno_reward_lege");

      foreach(var_6 in var_4) {
        var_6 scripts\cp\vehicles\vehicle_compass_cp::ref_12004("mv_event_intel_7");
      }

      continue;
    }

    thread endevent_spawnrewardcache(level, "fresno_reward_rare");
  }

  foreach(var_6 in level.players) {
    if(isDefined(var_6) && isalive(var_6)) {
      var_11 = 0;

      for(var_2 = 0; var_2 < var_0.size; var_2++) {
        if(var_6.team == var_0[var_2][0]) {
          var_11 = 1;
          break;
        }
      }

      if(!var_11) {
        var_6 thread scripts\mp\hud_message::showsplash("br_pe_unranked");
      }
    }
  }
}

function endevent_spawnrewardcache(var_0, var_1) {
  wait 2;
  var_2 = undefined;
  var_3 = scripts\mp\utility\teams::getfriendlyplayers(var_1, 1);

  foreach(var_5 in var_3) {
    if(!isDefined(var_2) || var_5.ref_12532.ref_13BEE > var_2.ref_12532.ref_13BEE && scripts\mp\gametypes\br_circle::vandalize_minigun_speed(var_5.origin)) {
      var_2 = var_5;
    }
  }

  if(isDefined(var_2)) {
    var_7 = getdvarfloat("scr_br_pe_fresno_reward_offset", 2000);
    var_8 = vectorNormalize(scripts\mp\gametypes\br_circle::getsafecircleorigin() - var_2.origin);
    var_9 = var_2.origin + var_8 * var_7;
    var_10 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent(var_9, 500, 0.5, 0.9, 1);
    var_10 = getclosestpointonnavmesh(var_10, var_2);
    var_11 = (var_10[0], var_10[1], var_10[2] + 2000);
    var_12 = scripts\cp_mp\killstreaks\airdrop::dropcrate(undefined, undefined, "fresno_crate", var_11, (0, randomint(360), 0), var_10);
    var_13 = getdvarfloat("scr_br_pe_fresno_reward_duration", 90);
    var_12.expiretime = gettime() + var_13 * 1000;
    var_12.rewardtable = var_0;
    thread reward_crate_fx();
    thread reward_crate_icon();
    thread reward_crate_cleanup();
    return;
  }
}

function gz_onkilled() {
  if(istrue(self.subdued)) {
    return;
  }

  self.subdued = 1;
  scripts\mp\gametypes\br_publicevents::ref_13371("br_pe_fresno_greenbay_down");
  level thread scripts\mp\gametypes\br_public::brleaderdialog("public_events_g_staggered");
  wait 1;
  thread tdownchallenges("gz");
  thread spawnintelcrates();
}

function kk_onkilled() {
  if(istrue(self.subdued)) {
    return;
  }

  self.subdued = 1;
  scripts\mp\gametypes\br_publicevents::ref_13371("br_pe_fresno_kenosha_down");
  level thread scripts\mp\gametypes\br_public::brleaderdialog("public_events_k_staggered");
  wait 1;
  thread tdownchallenges("kk");
  thread spawnintelcrates();
}

function tdownchallenges(var_0) {
  var_1 = "mv_event_intel_10";

  if(var_0 == "kk") {
    var_1 = "mv_event_intel_11";
  }

  foreach(var_3 in level.ref_13AAA) {
    var_4 = scripts\mp\utility\teams::getfriendlyplayers(var_8, 0);

    if(isDefined(var_4) && var_4.size > 0) {
      foreach(var_6 in var_4) {
        var_6 scripts\cp\vehicles\vehicle_compass_cp::ref_12004(var_1);
      }
    }
  }
}

function spawnintelcrates() {
  var_0 = [];
  var_1 = getdvarint("scr_br_pe_fresno_num_intel_crate", 5);
  var_2 = undefined;

  if(isDefined(self.agent_type) && self.agent_type == "actor_kenosha") {
    var_2 = "k";
    var_3 = level.ref_11E18.wait_for_open;
  } else if(isDefined(self.agent_type) && self.agent_type == "actor_greenbay") {
    var_3 = "g";
    var_3 = level.ref_11E18.setlastdroppableweaponobj;
  } else {
    return;
  }

  if(isDefined(self.cashtorefund)) {
    var_4 = self.cashtorefund.origin;
  } else {
    var_4 = self.origin;
  }

  for(var_5 = 0; var_5 < var_3; var_5++) {
    var_6 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent(var_4, level.ref_11E18.playerredeploy, 0.1, 0.9, 1);
    var_7 = spawnStruct();
    var_7.origin = var_6;
    var_7.type = var_3;
    var_7.index = var_4;
    var_2 = var_7;
  }

  for(var_8 = 0; var_8 < var_2.size; var_8++) {
    var_9 = randomint(360);

    for(var_10 = 0; var_10 < level.ref_11BCE.ref_11F1E; var_10++) {
      var_11 = var_9 + 90;
      var_12 = 0;
      var_13 = undefined;
      var_14 = 0;

      while(var_14 < 360) {
        var_15 = (0, var_11 + var_14, 0);
        var_16 = anglesToForward(var_15);
        var_7 = var_2[var_8];
        var_13 = var_7.origin + var_16 * level.ref_11BCE.train_get_num_of_anim_ents[var_7.type];

        if(!scripts\mp\gametypes\br_circle::vandalize_minigun_speed(var_13) || scripts\mp\gametypes\br_gametype_mendota::updatesquadleaderpassstateforteam(var_13)) {} else if(!isDefined(level.br_circle.dangercircleent) || scripts\mp\gametypes\br_circle::updateprestreamrespawn(var_13)) {
          var_12 = 1;
          break;
        }

        var_14 += 10;
      }

      if(!var_12) {
        break;
      }

      var_9 = var_11;
      var_17 = scripts\mp\gametypes\br_public::modifyplayer_damage(var_13);
      var_17 += (0, 0, 2000);
      var_18 = scripts\cp_mp\killstreaks\airdrop::dropcrate(undefined, undefined, "intel_crate", var_17, (0, randomint(360), 0));
      var_18.trial_flares = var_2[var_8];
      var_19 = randomfloatrange(level.ref_11BCE.trial_fetch_mission_table, level.ref_11BCE.trial_explosive_clear) * 1000;
      var_18.trial_flares.expiretime = gettime() + var_19;
      level.train_hurt_damage_watcher[level.train_hurt_damage_watcher.size] = var_18;
      var_18 thread scripts\mp\gametypes\br_gametype_mendota::train_handle_collide_mines();
      var_18 thread scripts\mp\gametypes\br_gametype_mendota::train_horn_sfx();
    }
  }
}

function players_camera_fly_to_start_pos(var_0, var_1, var_2) {
  var_3 = getdvarint("scr_br_pe_fresno_intel_min", 3);
  var_4 = getdvarint("scr_br_pe_fresno_intel_max", 6);
  var_5 = getdvarint("scr_br_pe_fresno_intel_stack_min", 3);
  var_6 = getdvarint("scr_br_pe_fresno_intel_stack_max", 5);
  var_7 = randomintrange(var_3, var_4);
  var_8 = randomintrange(var_5, var_6);

  for(var_9 = 0; var_9 < var_8; var_9++) {
    var_10 = scripts\mp\gametypes\br_lootcache::ref_11A41("brloot_mendota_intel", var_0, var_1, var_2, 0, 0);
    var_10.count = var_7;
  }
}

function init_reward_crates() {
  var_0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("fresno_crate");
  var_0.capturestring = &"MP/GENERIC_LOOT_CRATE_CAPTURE";
  var_0.dummymodel = "military_carepackage_02_br";
  var_0.friendlymodel = undefined;
  var_0.enemymodel = undefined;
  var_0.mountmantlemodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = undefined;
  var_0.minimapicon = undefined;
  var_0.usepriority = -1;
  var_0.usefov = 180;
  var_0.timeout = undefined;
  var_0.friendlyuseonly = 0;
  var_0.ownerusetime = 0.5;
  var_0.otherusetime = 0.5;
  var_0.activatecallback = &rewardcrateactivatecallback;
  var_0.capturecallback = &rewardcratecapturecallback;
  var_0.destroyoncapture = 1;
}

function rewardcrateactivatecallback(var_0) {
  if(istrue(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "registerCrateForCleanup")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "registerCrateForCleanup")]](self);
      return;
    }

    return;
  }
}

function rewardcratecapturecallback(var_0) {
  self notify("captured");
  var_1 = randomint(10);
  var_2 = verifybunkercode(self.rewardtable, var_1);
  var_3 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  var_3.fromrewardcrate = 1;

  foreach(var_5 in var_2) {
    var_6 = scripts\mp\gametypes\br_lootcache::ref_11A41(var_5, var_3, self.origin, self.angles, 0, 1);
  }

  if(isDefined(self.objectiveiconid)) {
    objective_delete(self.objectiveiconid);
  }

  playFX(level.conf_fx["vanish"], self.molotov_delete_oldest_trigger.origin);
  self.molotov_delete_oldest_trigger delete();
}

function reward_crate_fx() {
  var_0 = scripts\mp\gametypes\br_public::modifyplayer_damage(self.origin, 50, -3000);
  self.molotov_delete_oldest_trigger = spawn("script_model", var_0 + (0, 0, 3));
  self.molotov_delete_oldest_trigger setModel("scr_smoke_grenade");
  wait 1;
  self.molotov_delete_oldest_trigger playLoopSound("mp_flare_burn_lp");
  self.molotov_delete_oldest_trigger setscriptablepartstate("smoke", "on");
}

function reward_crate_icon() {
  self setscriptablepartstate("objective_map", "pe_chopper_crate", 0);
}

function reward_crate_cleanup() {
  self endon("captured");
  level endon("game_ended");

  while(isDefined(self) && !istrue(self.isdestroyed) && gettime() < self.expiretime) {
    waitframe();
  }

  if(isDefined(self) && !istrue(self.isdestroyed)) {
    self.molotov_delete_oldest_trigger delete();
    playFX(level.conf_fx["vanish"], self.origin);
    scripts\cp_mp\killstreaks\airdrop::lastactivateinstruct();
    return;
  }
}

function redeployspawns(var_0) {
  var_1 = gettime();
  var_2 = 1;

  if(!isDefined(level.ref_11E18.waittill_player_collects_death_cash) || var_1 - level.ref_11E18.waittill_player_collects_death_cash >= 1000) {
    var_2 = 0;
  }

  if(!isDefined(level.ref_11E18.ref_140C2)) {
    level.ref_11E18.ref_140C2 = [];
    var_2 = 0;
  }

  if(!var_2 || istrue(var_0)) {
    var_3 = self.origin;

    if(isDefined(self.cashtorefund)) {
      var_3 = self.cashtorefund.origin;
    }

    level.ref_11E18.ref_140C2 = getentarrayinradius("player", "classname", var_3, level.ref_11E18.playerredeploy);
    level.ref_11E18.waittill_player_collects_death_cash = var_1;
  }

  return level.ref_11E18.ref_140C2;
}

function sec_sys_struct_2(var_0) {
  var_1 = redeployspawns();
  var_2 = scripts\engine\utility::array_contains(var_1, var_0);

  if(!var_2 && getdvarint("scr_br_pe_fresno_distance_check_fallback", 1)) {
    var_3 = self.origin;

    if(isDefined(self.cashtorefund)) {
      var_3 = self.cashtorefund.origin;
    }

    var_2 = distance2d(var_0.origin, var_3) <= level.ref_11E18.playerredeploy;

    if(var_2) {
      level.ref_11E18.ref_140C2 = scripts\engine\utility::array_add(level.ref_11E18.ref_140C2, var_0);
    }
  }

  if(var_2) {
    var_0.players_in_aggro = self.agent_type;
  } else {
    var_0.players_in_aggro = undefined;
  }

  return var_2;
}

function updateplayerandteamcountui(var_0) {
  var_1 = 0;

  if(isDefined(level.ref_11E18.setincomingremovedcallback)) {
    var_1 = var_1 || sec_sys_struct_2(level.ref_11E18.setincomingremovedcallback, var_0);
  }

  if(isDefined(level.ref_11E18.wait_for_next_hack_complete)) {
    var_1 = var_1 || sec_sys_struct_2(level.ref_11E18.wait_for_next_hack_complete, var_0);
  }

  return var_1;
}

function vault_assault_infil(var_0, var_1) {
  if(isDefined(var_1.classname) && (var_1.classname == "script_vehicle" || var_1.classname == "misc_turret")) {
    return true;
  }

  if(isDefined(var_0) && var_0 != var_1 && isDefined(var_0.classname)) {
    if(var_0.classname == "misc_turret") {
      return true;
    }

    if(var_0.classname == "script_model" && var_0.model == "lm_ach_gp_bomb_600lb_01_gameplay") {
      return true;
    }
  }

  return false;
}

function isexplosivedamage(var_0) {
  return var_0 == "MOD_GRENADE" || var_0 == "MOD_EXPLOSIVE" || var_0 == "MOD_GRENADE_SPLASH" || var_0 == "MOD_EXPLOSIVE_BULLET" || var_0 == "MOD_PROJECTILE" || var_0 == "MOD_PROJECTILE_SPLASH";
}

function unset_relic_nobulletdamage(var_0) {
  var_1 = createheadicon(var_0);
  var_2 = level.br_pickups.br_weapontoscriptable[var_1];

  if(isDefined(var_2)) {
    if(can_be_seen_by_any_player(level.shrink_poi_into_the_bank.ref_13EFF, var_2)) {
      return true;
    }

    if(can_be_seen_by_any_player(level.shrink_poi_into_the_bank.chopper_gunner, var_2)) {
      return true;
    }

    if(can_be_seen_by_any_player(level.shrink_poi_into_the_bank.waypoints, var_2)) {
      return true;
    }
  }

  if(scripts\mp\utility\weapon::getweapongroup(var_0.basename) == "weapon_lmg") {
    return true;
  }

  return false;
}

function can_be_seen_by_any_player(var_0, var_1) {
  if(var_0.size <= 0) {
    return false;
  }

  foreach(var_3 in var_0) {
    if(isarray(var_3)) {
      if(var_3[0] == var_1) {
        return true;
      }

      continue;
    }

    if(var_3 == var_1) {
      return true;
    }
  }

  return false;
}

function lootleadermarksizedynamic(var_0, var_1, var_2, var_3, var_4) {
  var_5 = randomfloatrange(0.5, 1);

  if(istrue(var_4)) {
    var_5 *= 1.5;
  }

  return var_0 * var_5;
}

function showsplashtoteam(var_0, var_1) {
  var_2 = scripts\mp\utility\teams::getfriendlyplayers(var_0, 1);

  foreach(var_4 in var_2) {
    var_4 thread scripts\mp\hud_message::showsplash(var_1);
  }
}

function register_vehicle_spawn_override() {
  var_0 = [];

  foreach(var_2 in level.teamnamelist) {
    if(isDefined(level.teamdata[var_2]) && isDefined(level.teamdata[var_2]["aliveCount"]) && level.teamdata[var_2]["aliveCount"] > 0) {
      var_0 = var_2;
    }
  }

  return var_0;
}

function isfresnoactive() {
  return isDefined(level.ref_11E18.setincomingremovedcallback.ref_12930) || isDefined(level.ref_11E18.wait_for_next_hack_complete.ref_12930);
}

function getfresnotimeremaining() {
  if(!isDefined(level.ref_11E18.pe_endtime)) {
    return 0;
  }

  var_0 = gettime();
  return (level.ref_11E18.pe_endtime - var_0) / 1000;
}

function clearweaponvehicledropcircles() {
  if(isDefined(level.ref_11E18.weaponvehicledropcircles)) {
    foreach(var_1 in level.ref_11E18.weaponvehicledropcircles) {
      var_1 scripts\mp\gametypes\br_quest_util::lastdirtyscore();
    }
  }

  level.ref_11E18.weaponvehicledropcircles = [];
}

function addweaponvehicledropcircle(var_0) {
  if(!isDefined(level.ref_11E18.weaponvehicledropcircles)) {
    level.ref_11E18.weaponvehicledropcircles = [];
  }

  var_0 scripts\mp\gametypes\br_quest_util::init_tactical_boxes(3, 0, 0, var_0.origin);
  var_0 scripts\mp\gametypes\br_quest_util::ref_1316F(var_0.radius);
  var_0 scripts\mp\gametypes\br_quest_util::ref_13369();
  level.ref_11E18.weaponvehicledropcircles[level.ref_11E18.weaponvehicledropcircles.size] = var_0;
}

function recordeventendanalytics() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;

  foreach(var_4 in level.players) {
    if(isDefined(var_4) && isDefined(var_4.ref_12532)) {
      var_0 += var_4.ref_12532.ref_14239;
      var_1 += var_4.ref_12532.open_cac_slot;
      var_2 += var_4.ref_12532.ref_1457E;
    }
  }

  getentitylessscriptablearray("dlog_event_br_pe_fresno_end", ["gk_maxhealth", level.delayedeventtypes[16].secondwindthink, "g_totaldamage", int(level.ref_11E18.ref_13BEF["actor_greenbay"]), "k_totaldamage", int(level.ref_11E18.ref_13BEF["actor_kenosha"]), "expl_damage", int(var_1), "veh_damage", int(var_0), "weap_damage", int(var_2)]);
}

function print_event_logs() {
  if(getdvarint("fresno_debug_logs", 0) == 0) {
    return;
  }

  var_0 = "===================================\n";
  var_1 = level.delayedeventtypes[16].secondwindthink;
  var_0 += "gkMaxHealth: " + var_1 + "\n";
  var_0 += "gDamage: " + level.ref_11E18.ref_13BEF["actor_greenbay"] + "\n";
  var_0 += "kDamage: " + level.ref_11E18.ref_13BEF["actor_kenosha"] + "\n";
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;

  foreach(var_6 in level.players) {
    if(isDefined(var_6) && isDefined(var_6.ref_12532)) {
      var_2 += var_6.ref_12532.ref_14239;
      var_3 += var_6.ref_12532.open_cac_slot;
      var_4 += var_6.ref_12532.ref_1457E;
    }
  }

  var_0 += "Total Vehicle Damage: " + var_2 + "\n";
  var_0 += "Total Explosive Damage: " + var_3 + "\n";
  var_0 += "Total Weapon Damage: " + var_4 + "\n";
  var_8 = level.delayedeventtypes[16].is_wave_exist;

  for(var_9 = 0; var_9 < var_8.size; var_9++) {
    var_0 += "Damage Leader " + var_9 + 1 + " Total: " + var_8[var_9][1] + "\n";
  }

  println_wrapper(var_0 + "===================================");
}

function println_wrapper(var_0) {
  logstring("FRESNO DEBUG:: " + var_0);
}