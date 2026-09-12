/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_event_soa_tower_helipad.gsc
***************************************************************/

function init() {
  scripts\mp\flags::gameflaginit("activate_cash_helis", 0);
  setDvar("scr_dmz_lc_active", 1);
  level.ref_14086 = 1;
  scripts\engine\scriptable::scriptable_addusedcallback(&scriptable_used);
  scripts\engine\scriptable::ref_12f58(&ref_12f5d);
  level scripts\mp\gametypes\br_lootchopper::init();
  level._effect["vfx_c4_red_light"] = loadfx("vfx/iw8_br/gameplay/vfx_br_soa_c4_volumetric_glow");
  tr_vis_radius_override_lod2();
  thread object_is_valid();
}

function tr_vis_radius_override_lod2() {
  level.ref_13460 = spawnStruct();
  level.ref_13460.time = getdvarint("scr_br_soa_tower_helipad_event_time", 120);
  level.ref_13460.chosencodephones = getdvarint("scr_br_soa_tower_base_jump_threshold", 800);
  level.ref_13460.ref_1345a = getdvarint("scr_br_soa_tower_helipad_event_chopper_health", 5000);
  level.ref_13460.ref_1345e = getdvarint("scr_br_soa_tower_helipad_event_chopper_speed", 100);
  level.ref_13460.ref_13458 = getdvarint("scr_br_soa_tower_helipad_event_chopper_acceleration", 50);
  level.ref_13460.ref_13459 = getdvarint("scr_br_soa_tower_helipad_event_chopper_accuracy", 35);
  level.ref_13460.ref_1345c = getdvarint("scr_br_soa_tower_helipad_event_chopper_min_wait_time", 6);
  level.ref_13460.ref_1345b = getdvarint("scr_br_soa_tower_helipad_event_chopper_max_wait_time", 11);
  level.ref_13460.ref_13466 = getdvarfloat("scr_br_soa_tower_skydive_challenge_complete_threshold", 3);
}

function object_is_valid() {
  waitframe();
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  level.ref_13460.active = 0;
  level.ref_13460.states = ["inactive", "active"];
  level.ref_13460.current_state = "inactive";
  level.ref_13460.cp_dntsk_raid_sound_load = 4;
  level.ref_13460.cpcpammoarmorcratecapturecallback = [];

  if(!isDefined(level.ref_13460.choppers)) {
    level.ref_13460.choppers = [];
  }

  level.ref_1345d = [];
  level.ref_13460.occupied_rpg_trig = getEnt("br_soa_tower_c4_event_vol", "targetname");
  level.ref_13460.ref_12d83 = (20213, -14849, 5000);
  level.ref_13460 scripts\mp\utility\trigger::makeenterexittrigger(level.ref_13460.occupied_rpg_trig, &ref_13dab, &ref_13dac, undefined, undefined, &ref_13da5);
  level.ref_13460.ref_12659 = [];
  level.ref_13460.ref_12662 = [];
  level.ref_13460.ref_12663 = [];
  level.ref_13460.ref_12660 = [];
  level.ref_13460.ref_13b97 = -1;
  level scripts\mp\gametypes\br_lootchopper::init();
  ref_131db(level.ref_13460);
}

function ref_131db() {
  var_0 = scripts\engine\utility::getStructArray("soa_tower_helipad_bomb", "targetname");
  var_1 = [];
  GscBinSkip0(0x2e, var_1.size, spawnStruct());
}

function getallextractspawninstances() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self.ref_133eb = spawnStruct();
  self.ref_133ec = 1;
  self.ref_133eb notify("stop_skydive_tracking");
  self.ref_133eb endon("stop_skydive_tracking");
  self.ref_133eb.states = ["soa_tower_top", "skydiving", "completed", "failed"];
  self.ref_133eb.current_state = "soa_tower_top";
  self.ref_133eb.loot_getitemcount = 0;
  self.ref_133eb.ref_1381c = 0;
  self.ref_133eb.initlocs_radio = 0;
  self.ref_133eb.ref_133f6 = 0;
  var_0 = level.ref_13460.ref_13466;

  for(;;) {
    if(self isonground() && objectiveids() && !self isparachuting()) {
      self.ref_133eb.current_state = "soa_tower_top";
      self.ref_133eb.ref_121cb = 0;
      self.ref_133eb.ref_1381c = 0;
      self.ref_133eb.initlocs_radio = 0;
      self.ref_133eb.ref_133f6 = 0;
    }

    if(!self isonground() && !objectiveids()) {
      if(self.ref_133eb.current_state != "failed") {
        if(self.ref_133eb.current_state == "soa_tower_top") {
          self.ref_133eb.ref_1381c = gettime() / 1000;
        }

        self.ref_133eb.current_state = "skydiving";
        self.ref_133eb.initlocs_radio = gettime() / 1000;
        self.ref_133eb.ref_133f6 = self.ref_133eb.initlocs_radio - self.ref_133eb.ref_1381c;
      }
    } else if(self isonground() && !objectiveids()) {
      var_1 = 4300;
      var_2 = 1500;
      var_3 = scripts\engine\utility::ter_op(var_1 - self.origin[2] > var_2, "completed", "failed");
      wait 0.1;

      if(scripts\mp\utility\player::unset_relic_trex(self) || !isalive(self)) {
        var_3 = "failed";
      }

      self.ref_133eb.current_state = var_3;

      switch (self.ref_133eb.current_state) {
        case "completed":
          self.ref_133ec = 0;

          if(getdvarint("MLNNMOPQOP", 0) == 6) {
            scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_ntower_jump_for_s3_5_event_wz", 1);
          }

          self.ref_133eb notify("stop_skydive_tracking");
          break;
        case "failed":
          self.ref_133ec = 0;
          self.ref_133eb.current_state = "failed";
          self.ref_133eb notify("stop_skydive_tracking");
          break;
      }

      self.ref_133ec = 0;
      self.ref_133eb notify("stop_skydive_tracking");
    }

    waitframe();
  }
}

function oceanrock() {
  level endon("game_ended");
  level.ref_13460 endon("stop_soa_tower_helipad_event");
  var_0 = gettime() / 1000;
  var_1 = gettime() / 1000;

  for(;;) {
    var_2 = gettime() / 1000;
    var_3 = 120 - var_2 - var_0;

    foreach(var_5 in level.ref_13460.ref_12662) {
      if(var_2 - var_1 > 1) {
        var_6 = obj_smuggler_killed_early(var_3);
        var_5 playlocalsound(var_6);
        var_1 = gettime() / 1000;
      }
    }

    wait 0.1;
  }
}

function obj_smuggler_killed_early(var_0) {
  if(var_0 > 20) {
    return "ui_mp_timer_countdown";
  }

  if(var_0 > 10) {
    return "ui_mp_timer_countdown_10";
  }

  if(var_0 > 5) {
    return "ui_mp_timer_countdown_half_sec";
  }

  if(var_0 > 1.5) {
    return "ui_mp_timer_countdown_quarter_sec";
  }

  return "ui_mp_timer_countdown_1";
}

function obj_room_fire_08(var_0) {
  if(isDefined(var_0.attacker)) {
    if(isPlayer(var_0.attacker)) {
      objective_show_for_mlg_spectator(var_0.attacker);
    }
  }

  return true;
}

function objectiveachievementkillcount() {
  level endon("game_ended");
  level.ref_13460 endon("stop_soa_tower_helipad_event");

  for(;;) {
    var_0 = scripts\engine\utility::array_combine_unique(level.ref_13460.ref_12659, level.ref_13460.ref_12662);

    foreach(var_2 in var_0) {
      var_3 = objective_set_hot(var_2);

      if(!var_3 && objectiveids(var_2)) {
        objective_timers_reset_both(var_2);
      } else if(isalive(var_2)) {
        objectiveicon(var_2);
      } else {
        objectivedescription(var_2);
      }

      var_4 = gettime() / 1000;

      foreach(var_2 in level.ref_13460.ref_12663) {
        var_6 = gettime() / 1000 - var_2.ref_13462 / 1000;
        var_7 = var_2.soldier_agent_lwfn6;

        if(isDefined(var_7)) {
          if(var_7.hidden) {
            var_7 scripts\mp\hud_util::showelem();
          }

          var_7 setvalue(ceil(10 - var_6));
        }

        if(objectiveids(var_2)) {
          objective_timers_reset_both(var_2);

          if(isDefined(var_7)) {
            var_7 scripts\mp\hud_util::hideelem();
          }

          continue;
        }

        if(var_6 >= 10) {
          objectivedescription(var_2);
          objective_locations_logic(var_2, "br_soa_tower_event_helipad_unsubscribe");
        }
      }
    }

    wait 0.1;
  }
}

function objective_timers_reset_both() {
  if(!isDefined(self)) {
    return;
  }

  if(!objective_set_hot()) {
    level.ref_13460.ref_12662 = scripts\engine\utility::array_add(level.ref_13460.ref_12662, self);
    ref_13ef3();

    if(level.ref_13460.current_state == "active") {
      objective_locations_logic(self, "br_soa_tower_event_helipad_explosives");
      return;
    }

    return;
  }

  if(objective_origin()) {
    self.ref_13462 = undefined;
    level.ref_13460.ref_12663 = scripts\engine\utility::array_remove(level.ref_13460.ref_12663, self);
    return;
  }
}

function objectivedescription() {
  if(!isDefined(self)) {
    return;
  }

  if(objective_set_hot()) {
    ref_13ef4();
    level.ref_13460.ref_12662 = scripts\engine\utility::array_remove(level.ref_13460.ref_12662, self);
    level.ref_13460.ref_12663 = scripts\engine\utility::array_remove(level.ref_13460.ref_12663, self);
    return;
  }
}

function objectiveicon() {
  if(!isDefined(self)) {
    return;
  }

  if(objective_set_hot() && !objective_origin()) {
    self.ref_13462 = gettime();
    level.ref_13460.ref_12663 = scripts\engine\utility::array_add(level.ref_13460.ref_12663, self);
    return;
  }
}

function objectiveids() {
  if(!isDefined(self)) {
    return false;
  }

  if(scripts\engine\utility::array_contains(level.ref_13460.ref_12659, self)) {
    return true;
  }

  return false;
}

function objective_set_hot() {
  if(!isDefined(self)) {
    return 0;
  }

  return scripts\engine\utility::array_contains(level.ref_13460.ref_12662, self);
}

function objective_origin() {
  if(!isDefined(self)) {
    return 0;
  }

  return scripts\engine\utility::array_contains(level.ref_13460.ref_12663, self);
}

function objective_show_for_mlg_spectator() {
  if(!isDefined(self)) {
    return 0;
  }

  if(!scripts\engine\utility::array_contains(level.ref_13460.ref_12660, self) && objective_set_hot()) {
    level.ref_13460.ref_12660 = scripts\engine\utility::array_add(level.ref_13460.ref_12660, self);
    return;
  }
}

function objective_minimapupdate(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_1)) {
    var_2 = spawnStruct();
    var_2.intvar = var_1;
  }

  foreach(var_4 in level.ref_13460.ref_12662) {
    scripts\mp\gametypes\br_quest_util::displayplayersplash(var_4, var_0, var_2);
  }
}

function objective_locations_logic(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(var_2)) {
    var_3 = spawnStruct();
    var_3.intvar = var_2;
  }

  scripts\mp\gametypes\br_quest_util::displayplayersplash(var_0, var_1, var_3);
}

function ref_13dab(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  if(isPlayer(var_0) && level.ref_13460.chosencodephones > 0) {
    thread chosen_airlock_door();
  }

  if(isPlayer(var_0) && !scripts\engine\utility::array_contains(level.ref_13460.ref_12659, var_0)) {
    level.ref_13460.ref_12659 = scripts\engine\utility::array_add(level.ref_13460.ref_12659, var_0);
  }

  if(isPlayer(var_0) && (!isDefined(var_0.ref_133ec) || !var_0.ref_133ec)) {
    thread getallextractspawninstances();
    return;
  }
}

function ref_13dac(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  if(isPlayer(var_0) && scripts\engine\utility::array_contains(level.ref_13460.ref_12659, var_0)) {
    level.ref_13460.ref_12659 = scripts\engine\utility::array_remove(level.ref_13460.ref_12659, var_0);
    return;
  }
}

function ref_13da5(var_0, var_1) {
  if(!isDefined(var_0)) {
    return true;
  }

  if(!isPlayer(var_0)) {
    return true;
  }

  return false;
}

function chosen_airlock_door() {
  self endon("out_of_range");
  self endon("death_or_disconnect");

  while(!self isonground()) {
    waitframe();
  }

  self skydive_setbasejumpingstatus(0);

  for(;;) {
    if(level.ref_13460.ref_12d83[2] - self.origin[2] > level.ref_13460.chosencodephones) {
      break;
    }

    wait 0.1;
  }

  self skydive_setbasejumpingstatus(1);
  var_0 = [];
  GscBinSkip0(0x2e, 0, self);
}

function scriptable_used(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0) && var_0.type == "soa_tower_bomb") {
    if(!level.ref_13460.active) {
      thread start_event();
      level.ref_13460.active = 1;
    }

    thread location_tracker(var_0);
    return;
  }
}

function ref_12f5d(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0) && var_0.type == "soa_tower_bomb") {
    if(!level.ref_13460.active) {
      thread start_event();
      level.ref_13460.active = 1;
      return;
    }

    return;
  }
}

function start_event() {
  thread objectiveachievementkillcount();
  waitframe();
  level.ref_13460.current_state = "active";
  level.ref_13460.cp_dntsk_raid_sound_load = 4;
  level.ref_13460.ref_13b97 = gettime();
  ref_13ee8();
  objective_minimapupdate("br_soa_tower_event_helipad_explosives");
  thread ref_13291(level.ref_13460);
  thread ref_137aa();
  ref_13467(level.ref_13460);
  ref_13eea("active");
}

function soldier_agent_lwfn3() {
  thread scripts\mp\gametypes\br_publicevent_tower::ref_1344e();
}

function ref_13467() {
  if(level.ref_13460.choppers.size == 0) {
    level.ref_13460.choppers = [];
  }

  var_0 = scripts\engine\utility::getStruct("patrol_zone", "targetname");
  var_1 = ref_1345f();
  var_2 = scripts\mp\gametypes\br_lootchopper::ref_11a18(var_0, undefined, 1, var_1);
  var_2 thread scripts\mp\gametypes\br_publicevent_tower::connectedplayercount();
  var_2.intro_driver_logic = &ref_13450;
  var_2.intro_enemy_respawner = &ref_13450;
  var_2.lootfunc = &soldier_agent_lwfn3;
  var_2.interaction_is_floor_is_lava_client = &ref_1344d;
  var_2.intermissionspawntime = &ref_1344f;
  var_2.updateteamscoreplacements = 1;
  var_2.usefuncoverride = 1;
  var_2.health = level.ref_13460.ref_1345a;
  var_2.speed = level.ref_13460.ref_1345e;
  var_2.accel = level.ref_13460.ref_13458;
  var_2.ref_13768 = level.ref_13460.ref_13459;
  thread ref_13450(var_2);
  level.ref_13460.choppers = scripts\engine\utility::array_add(level.ref_13460.choppers, var_2);
  waitframe();
  scripts\mp\vehicles\damage::set_post_mod_damage_callback("loot_chopper", &obj_room_fire_08);
  scripts\mp\flags::gameflagset("activate_cash_helis");
  waitframe();
  scripts\mp\flags::gameflagclear("activate_cash_helis");

  if(!isDefined(level.shutdownattractionicontrigger)) {
    level thread scripts\mp\gametypes\br_heavy_weapon_drop::init();
    return;
  }
}

function ref_1345f() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  if(level.mapname == "mp_don4") {
    var_0 = (19077, -17718, 5550);
    var_1 = (17866, -15627, 5550);
    var_2 = (19309, -13691, 5550);
    var_3 = (21973, -13971, 5550);
    var_4 = (22573, -15691, 5550);
  } else {
    var_0 = (1132.5, 2841.5, 5550.5);
    var_1 = (2337, 746.5, 5551);
    var_2 = (902, -1193.5, 5548.5);
    var_3 = (-1763.5, -912, 5549);
    var_4 = (-2366, 811.5, 5549.5);
  }

  var_5 = [var_0, var_1, var_2, var_3, var_4];
  return var_5;
}

function hidetimedrunhudfromplayer(var_0) {
  level notify("stop_soa_tower_helipad_timer");
  ref_13546(var_0);
  objective_minimapupdate("br_soa_tower_event_helipad_complete_full_splash");

  foreach(var_2 in level.ref_13460.ref_12660) {
    var_2 scripts\mp\gametypes\br_publicevent_tower::ref_12d23("c4_event_participant");

    if(getdvarint("MLNNMOPQOP", 0) == 6) {
      var_2 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_complete_side_mission_for_s3_5_event_wz", 1);
    }
  }

  handlematchscoreboardinfo();
}

function patchoutofboundstrigger() {
  objective_minimapupdate("br_soa_tower_event_helipad_timer_expired");

  foreach(var_1 in level.ref_13460.cpcpammoarmorcratecapturecallback) {
    if(isDefined(var_1)) {
      thread lbravo_spawner_jammer4b();
    }
  }

  handlematchscoreboardinfo();
}

function handlematchscoreboardinfo() {
  level endon("game_ended");
  level.ref_13460.current_state = "inactive";

  foreach(var_1 in level.ref_13460.choppers) {
    if(isDefined(var_1)) {}
  }

  level.ref_13460 notify("stop_soa_tower_helipad_event");
  level.ref_13460.active = 0;
  ref_13ee9();
}

function ref_137aa() {
  level endon("stop_soa_tower_helipad_timer");
  level endon("game_ended");
  wait 120;
  patchoutofboundstrigger();
}

function cp_raid_complex_behavior() {
  self endon("death");
  self endon("disable_bomb_idle_fx");
  var_0 = self.origin + anglestoup(self.angles) * 2.5;

  for(;;) {
    playFX(scripts\engine\utility::getfx("vfx_c4_red_light"), var_0);
    playsoundatpos(self.origin, "scn_soa_c4_beep");
    wait 1;
  }
}

function location_tracker(var_0) {
  var_1 = self.entity;
  var_1 notify("disable_bomb_idle_fx");
  level.ref_13460.cp_dntsk_raid_sound_load--;
  ref_13eeb();

  if(level.ref_13460.cp_dntsk_raid_sound_load < 1) {
    hidetimedrunhudfromplayer(var_1);
  }

  playsoundatpos(var_1.origin, "scn_soa_c4_remove");
  var_0 thread scripts\mp\gametypes\br_public::ref_12616("iw8_ges_plyr_loot_pickup", 1.17);
  objective_show_for_mlg_spectator(var_0);
  var_0 scripts\mp\gametypes\br_publicevent_tower::ref_12d23("disarm_c4");
  var_2 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  var_3 = vectorNormalize(var_1.origin - (var_1.ref_140b8.origin[0], var_1.ref_140b8.origin[1], var_1.origin[2])) * 5;
  var_4 = var_1.origin - var_3;
  var_5 = vectortoangles(var_1.origin - var_4) + (0, 45, 0);
  scripts\mp\gametypes\br_lootcache::ref_11a41("brloot_offhand_c4", var_2, var_4, var_5, 1, 0, 0);
  level.ref_13460.cpcpammoarmorcratecapturecallback = scripts\engine\utility::array_remove(level.ref_13460.cpcpammoarmorcratecapturecallback, var_1);
  var_1 scripts\mp\gameobjects::releaseid();
  var_1 notify("deleted");
  var_1 delete();
  waitframe();
}

function lbravo_spawner_jammer4b() {
  self endon("death");
  wait randomfloatrange(0, 1.25);
  self setscriptablepartstate("soa_tower_bomb", "explode", 0);
  playsoundatpos(self.origin, "c4_expl_trans");
  self notify("disable_bomb_idle_fx");
  level.ref_13460.cpcpammoarmorcratecapturecallback = scripts\engine\utility::array_remove(level.ref_13460.cpcpammoarmorcratecapturecallback, self);
  scripts\mp\gameobjects::releaseid();
  self notify("deleted");
  wait 10;
  self delete();
}

function ref_13546() {
  var_0 = [];
  GscBinSkip0(0x2e, 0, "brloot_plunder_cash_epic_1");
}

function ref_11a17() {
  if(istrue(self.updateteamscoreplacements)) {
    if(self.ref_12200 + 1 >= self.ref_1220e.size) {
      self.updateteamscoreplacements = 0;
      return;
    }

    self.ref_12200 += 1;
    return;
  }

  if(self.ref_12200 - 1 < 0) {
    self.updateteamscoreplacements = 1;
    return;
  }

  self.ref_12200 -= 1;
}

function ref_13450(var_0) {
  self endon("death");

  for(;;) {
    if(!isDefined(var_0)) {
      self setvehgoalpos(self.ref_1220e[0], 1);
      self.pathgoal = self.ref_1220e[0];
    } else {
      self setvehgoalpos(var_0, 1);
      self.pathgoal = var_0;
    }

    if(isDefined(self.currenttarget) && self.currentaction == "attacking") {
      self setlookatent(self.currenttarget);
    } else {
      self clearlookatent();
    }

    scripts\engine\utility::ref_143a5("near_goal", "begin_evasive_maneuvers");
    var_1 = randomintrange(level.ref_13460.ref_1345c, level.ref_13460.ref_1345b);
    var_2 = randomint(10);
    wait var_1;

    if(var_2 > 5) {
      self.updateteamscoreplacements = !self.updateteamscoreplacements;
    }

    ref_11a17();
    var_0 = self.ref_1220e[self.ref_12200];
  }
}

function ref_1344d() {
  var_0 = undefined;

  if(level.mapname == "mp_don4") {
    var_0 = (20213, -14849, 5141);
  } else {
    var_0 = (-479, 909, 5141);
  }

  return var_0;
}

function ref_1344f() {
  playsoundatpos(self.origin, "veh_lbravo_explode");
  earthquake(1, 3, self.origin, 1000);
  playrumbleonposition("grenade_rumble", self.origin);
  physicsexplosionsphere(self.origin, 1000, 100, 2);
}

function ref_11a16(var_0) {
  if(self.currentaction != "patrol") {
    self.currentaction = "patrol";
  } else if(self.currentaction == "patrol" && !istrue(var_0)) {
    return;
  }

  self clearlookatent();
  self setneargoalnotifydist(500);
  var_1 = 0;
  var_2 = 0;

  for(;;) {
    foreach(var_4 in self.ref_1220e) {}

    if(self.currentaction == "attacking") {
      if(!istrue(var_1)) {
        var_1 = 1;
      }

      waitframe();
      continue;
    }

    if(!istrue(var_0) && istrue(var_1)) {
      var_1 = 0;
    }

    scripts\cp_mp\killstreaks\chopper_support::debugtimedelta(self.ref_1220e[0], 1);
    ref_11a17();
    wait 0.5;
  }
}

function ref_13ef3() {
  self.soldier_agent_lwfn4 = ref_13ee0(&"BR_SOA_EVENT/DISARM_COUNT", -1, 1, (1, 1, 1), 0, 50);
  self.soldier_agent_lwfn5 = ref_13ee1();
  self.soldier_agent_lwfn6 = ref_13ee0(&"SPLASHES/HELIPAD_EXPLOSIVES_UNSUBSCRIBING", -1, 1.2, (1, 1, 1), -300, 85);
  ref_13ef5();
  ref_13ef6(level.ref_13460.current_state);
}

function ref_13ef4() {
  if(!isDefined(self.ref_13461)) {
    return;
  }

  foreach(var_1 in self.ref_13461) {
    var_1 scripts\mp\hud_util::destroyelem();
    self.ref_13461 = scripts\engine\utility::array_remove(self.ref_13461, var_1);
    var_1 = undefined;
  }

  self.ref_13461 = undefined;
}

function ref_13ef5() {
  if(!isDefined(self.ref_13461)) {
    return;
  }

  foreach(var_1 in self.ref_13461) {
    var_1 scripts\mp\hud_util::hideelem();
  }
}

function ref_13eea(var_0) {
  foreach(var_2 in level.ref_13460.ref_12662) {
    ref_13ef6(var_2, var_0);
  }
}

function ref_13ee8() {
  foreach(var_1 in level.ref_13460.ref_12662) {
    ref_13ef3(var_1);
  }
}

function ref_13ee9() {
  foreach(var_1 in level.ref_13460.ref_12662) {
    ref_13ef4(var_1);
  }
}

function ref_13ef6(var_0) {
  ref_13ef5();

  switch (var_0) {
    case "inactive":
      break;
    case "active":
      self.soldier_agent_lwfn4 setvalue(4 - level.ref_13460.cp_dntsk_raid_sound_load);
      self.soldier_agent_lwfn4 scripts\mp\hud_util::showelem();
      var_1 = undefined;

      if(level.ref_13460.ref_13b97 <= 0) {
        var_1 = 120;
      } else {
        var_2 = level.ref_13460.ref_13b97 / 1000;
        var_3 = gettime() / 1000;
        var_4 = var_3 - var_2;
        var_1 = 120 - var_4;
      }

      self.soldier_agent_lwfn5 settimer(var_1);
      self.soldier_agent_lwfn5 scripts\mp\hud_util::showelem();
      break;
  }
}

function ref_13eeb() {
  foreach(var_1 in level.ref_13460.ref_12662) {
    var_1.soldier_agent_lwfn4 setvalue(4 - level.ref_13460.cp_dntsk_raid_sound_load);
  }
}

function ref_13edf(var_0) {
  if(!isDefined(self.ref_13461)) {
    self.ref_13461 = [];
  }

  self.ref_13461 = scripts\engine\utility::array_add(self.ref_13461, var_0);
}

function ref_13ee0(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_6)) {
    var_6 = "TOPLEFT";
  }

  var_7 = scripts\mp\hud_util::createfontstring("default", var_2);
  var_8 = 40;
  var_9 = (1 - getdvarfloat("hudBounds_adjusted_horizontal", 0)) * var_8;
  var_10 = (1 - getdvarfloat("hudBounds_adjusted_vertical", 0)) * var_8 / 2;
  var_7 scripts\mp\hud_util::setpoint(var_6, var_6, 143 + var_9, var_5 + var_10);
  var_7.color = var_3;
  var_7.label = var_0;
  var_7 setvalue(var_1);
  ref_13edf(var_7);
  return var_7;
}

function ref_13ee1() {
  var_0 = newclienthudelem(self);
  var_0.elemtype = "timer";
  var_0.font = "default";
  var_0.fontscale = 1.25;
  var_0.basefontscale = 1.25;
  var_0.width = 0;
  var_0.height = 10;
  var_1 = 40;
  var_2 = (1 - getdvarfloat("hudBounds_adjusted_horizontal", 0)) * var_1;
  var_3 = (1 - getdvarfloat("hudBounds_adjusted_vertical", 0)) * var_1 / 2;
  var_0.x = 65 + var_2;
  var_0.y = 60 + var_3;
  var_0.xoffset = 25;
  var_0.yoffset = 0;
  var_0.children = [];
  var_0.hidden = 0;
  ref_13edf(var_0);
  return var_0;
}

function ref_13291(var_0) {
  foreach(var_2 in level.ref_13460.ref_12662) {
    var_2 playlocalsound(var_0, undefined, undefined, 1);
  }
}