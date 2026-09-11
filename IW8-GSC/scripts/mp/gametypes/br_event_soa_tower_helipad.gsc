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
  var0 = scripts\engine\utility::getStructArray("soa_tower_helipad_bomb", "targetname");
  var1 = [];
  GscBinSkip0(0x2e, var1.size, spawnStruct());
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
  var0 = level.ref_13460.ref_13466;

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
      var1 = 4300;
      var2 = 1500;
      var3 = scripts\engine\utility::ter_op(var1 - self.origin[2] > var2, "completed", "failed");
      wait 0.1;

      if(scripts\mp\utility\player::unset_relic_trex(self) || !isalive(self)) {
        var3 = "failed";
      }

      self.ref_133eb.current_state = var3;

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
  var0 = gettime() / 1000;
  var1 = gettime() / 1000;

  for(;;) {
    var2 = gettime() / 1000;
    var3 = 120 - var2 - var0;

    foreach(var5 in level.ref_13460.ref_12662) {
      if(var2 - var1 > 1) {
        var6 = obj_smuggler_killed_early(var3);
        var5 playlocalsound(var6);
        var1 = gettime() / 1000;
      }
    }

    wait 0.1;
  }
}

function obj_smuggler_killed_early(var0) {
  if(var0 > 20) {
    return "ui_mp_timer_countdown";
  }

  if(var0 > 10) {
    return "ui_mp_timer_countdown_10";
  }

  if(var0 > 5) {
    return "ui_mp_timer_countdown_half_sec";
  }

  if(var0 > 1.5) {
    return "ui_mp_timer_countdown_quarter_sec";
  }

  return "ui_mp_timer_countdown_1";
}

function obj_room_fire_08(var0) {
  if(isDefined(var0.attacker)) {
    if(isPlayer(var0.attacker)) {
      objective_show_for_mlg_spectator(var0.attacker);
    }
  }

  return true;
}

function objectiveachievementkillcount() {
  level endon("game_ended");
  level.ref_13460 endon("stop_soa_tower_helipad_event");

  for(;;) {
    var0 = scripts\engine\utility::array_combine_unique(level.ref_13460.ref_12659, level.ref_13460.ref_12662);

    foreach(var2 in var0) {
      var3 = objective_set_hot(var2);

      if(!var3 && objectiveids(var2)) {
        objective_timers_reset_both(var2);
      } else if(isalive(var2)) {
        objectiveicon(var2);
      } else {
        objectivedescription(var2);
      }

      var4 = gettime() / 1000;

      foreach(var2 in level.ref_13460.ref_12663) {
        var6 = gettime() / 1000 - var2.ref_13462 / 1000;
        var7 = var2.soldier_agent_lwfn6;

        if(isDefined(var7)) {
          if(var7.hidden) {
            var7 scripts\mp\hud_util::showelem();
          }

          var7 setvalue(ceil(10 - var6));
        }

        if(objectiveids(var2)) {
          objective_timers_reset_both(var2);

          if(isDefined(var7)) {
            var7 scripts\mp\hud_util::hideelem();
          }

          continue;
        }

        if(var6 >= 10) {
          objectivedescription(var2);
          objective_locations_logic(var2, "br_soa_tower_event_helipad_unsubscribe");
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

function objective_minimapupdate(var0, var1) {
  var2 = undefined;

  if(isDefined(var1)) {
    var2 = spawnStruct();
    var2.intvar = var1;
  }

  foreach(var4 in level.ref_13460.ref_12662) {
    scripts\mp\gametypes\br_quest_util::displayplayersplash(var4, var0, var2);
  }
}

function objective_locations_logic(var0, var1, var2) {
  var3 = undefined;

  if(isDefined(var2)) {
    var3 = spawnStruct();
    var3.intvar = var2;
  }

  scripts\mp\gametypes\br_quest_util::displayplayersplash(var0, var1, var3);
}

function ref_13dab(var0, var1) {
  if(!isDefined(var0)) {
    return;
  }

  if(isPlayer(var0) && level.ref_13460.chosencodephones > 0) {
    thread chosen_airlock_door();
  }

  if(isPlayer(var0) && !scripts\engine\utility::array_contains(level.ref_13460.ref_12659, var0)) {
    level.ref_13460.ref_12659 = scripts\engine\utility::array_add(level.ref_13460.ref_12659, var0);
  }

  if(isPlayer(var0) && (!isDefined(var0.ref_133ec) || !var0.ref_133ec)) {
    thread getallextractspawninstances();
    return;
  }
}

function ref_13dac(var0, var1) {
  if(!isDefined(var0)) {
    return;
  }

  if(isPlayer(var0) && scripts\engine\utility::array_contains(level.ref_13460.ref_12659, var0)) {
    level.ref_13460.ref_12659 = scripts\engine\utility::array_remove(level.ref_13460.ref_12659, var0);
    return;
  }
}

function ref_13da5(var0, var1) {
  if(!isDefined(var0)) {
    return true;
  }

  if(!isPlayer(var0)) {
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
  var0 = [];
  GscBinSkip0(0x2e, 0, self);
}

function scriptable_used(var0, var1, var2, var3, var4) {
  if(isDefined(var0) && var0.type == "soa_tower_bomb") {
    if(!level.ref_13460.active) {
      thread start_event();
      level.ref_13460.active = 1;
    }

    thread location_tracker(var0);
    return;
  }
}

function ref_12f5d(var0, var1, var2, var3, var4) {
  if(isDefined(var0) && var0.type == "soa_tower_bomb") {
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

  var0 = scripts\engine\utility::getStruct("patrol_zone", "targetname");
  var1 = ref_1345f();
  var2 = scripts\mp\gametypes\br_lootchopper::ref_11a18(var0, undefined, 1, var1);
  var2 thread scripts\mp\gametypes\br_publicevent_tower::connectedplayercount();
  var2.intro_driver_logic = &ref_13450;
  var2.intro_enemy_respawner = &ref_13450;
  var2.lootfunc = &soldier_agent_lwfn3;
  var2.interaction_is_floor_is_lava_client = &ref_1344d;
  var2.intermissionspawntime = &ref_1344f;
  var2.updateteamscoreplacements = 1;
  var2.usefuncoverride = 1;
  var2.health = level.ref_13460.ref_1345a;
  var2.speed = level.ref_13460.ref_1345e;
  var2.accel = level.ref_13460.ref_13458;
  var2.ref_13768 = level.ref_13460.ref_13459;
  thread ref_13450(var2);
  level.ref_13460.choppers = scripts\engine\utility::array_add(level.ref_13460.choppers, var2);
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
  var0 = undefined;
  var1 = undefined;
  var2 = undefined;
  var3 = undefined;
  var4 = undefined;

  if(level.mapname == "mp_don4") {
    var0 = (19077, -17718, 5550);
    var1 = (17866, -15627, 5550);
    var2 = (19309, -13691, 5550);
    var3 = (21973, -13971, 5550);
    var4 = (22573, -15691, 5550);
  } else {
    var0 = (1132.5, 2841.5, 5550.5);
    var1 = (2337, 746.5, 5551);
    var2 = (902, -1193.5, 5548.5);
    var3 = (-1763.5, -912, 5549);
    var4 = (-2366, 811.5, 5549.5);
  }

  var5 = [var0, var1, var2, var3, var4];
  return var5;
}

function hidetimedrunhudfromplayer(var0) {
  level notify("stop_soa_tower_helipad_timer");
  ref_13546(var0);
  objective_minimapupdate("br_soa_tower_event_helipad_complete_full_splash");

  foreach(var2 in level.ref_13460.ref_12660) {
    var2 scripts\mp\gametypes\br_publicevent_tower::ref_12d23("c4_event_participant");

    if(getdvarint("MLNNMOPQOP", 0) == 6) {
      var2 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_complete_side_mission_for_s3_5_event_wz", 1);
    }
  }

  handlematchscoreboardinfo();
}

function patchoutofboundstrigger() {
  objective_minimapupdate("br_soa_tower_event_helipad_timer_expired");

  foreach(var1 in level.ref_13460.cpcpammoarmorcratecapturecallback) {
    if(isDefined(var1)) {
      thread lbravo_spawner_jammer4b();
    }
  }

  handlematchscoreboardinfo();
}

function handlematchscoreboardinfo() {
  level endon("game_ended");
  level.ref_13460.current_state = "inactive";

  foreach(var1 in level.ref_13460.choppers) {
    if(isDefined(var1)) {}
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
  var0 = self.origin + anglestoup(self.angles) * 2.5;

  for(;;) {
    playFX(scripts\engine\utility::getfx("vfx_c4_red_light"), var0);
    playsoundatpos(self.origin, "scn_soa_c4_beep");
    wait 1;
  }
}

function location_tracker(var0) {
  var1 = self.entity;
  var1 notify("disable_bomb_idle_fx");
  level.ref_13460.cp_dntsk_raid_sound_load--;
  ref_13eeb();

  if(level.ref_13460.cp_dntsk_raid_sound_load < 1) {
    hidetimedrunhudfromplayer(var1);
  }

  playsoundatpos(var1.origin, "scn_soa_c4_remove");
  var0 thread scripts\mp\gametypes\br_public::ref_12616("iw8_ges_plyr_loot_pickup", 1.17);
  objective_show_for_mlg_spectator(var0);
  var0 scripts\mp\gametypes\br_publicevent_tower::ref_12d23("disarm_c4");
  var2 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  var3 = vectorNormalize(var1.origin - (var1.ref_140b8.origin[0], var1.ref_140b8.origin[1], var1.origin[2])) * 5;
  var4 = var1.origin - var3;
  var5 = vectortoangles(var1.origin - var4) + (0, 45, 0);
  scripts\mp\gametypes\br_lootcache::ref_11a41("brloot_offhand_c4", var2, var4, var5, 1, 0, 0);
  level.ref_13460.cpcpammoarmorcratecapturecallback = scripts\engine\utility::array_remove(level.ref_13460.cpcpammoarmorcratecapturecallback, var1);
  var1 scripts\mp\gameobjects::releaseid();
  var1 notify("deleted");
  var1 delete();
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
  var0 = [];
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

function ref_13450(var0) {
  self endon("death");

  for(;;) {
    if(!isDefined(var0)) {
      self setvehgoalpos(self.ref_1220e[0], 1);
      self.pathgoal = self.ref_1220e[0];
    } else {
      self setvehgoalpos(var0, 1);
      self.pathgoal = var0;
    }

    if(isDefined(self.currenttarget) && self.currentaction == "attacking") {
      self setlookatent(self.currenttarget);
    } else {
      self clearlookatent();
    }

    scripts\engine\utility::ref_143a5("near_goal", "begin_evasive_maneuvers");
    var1 = randomintrange(level.ref_13460.ref_1345c, level.ref_13460.ref_1345b);
    var2 = randomint(10);
    wait var1;

    if(var2 > 5) {
      self.updateteamscoreplacements = !self.updateteamscoreplacements;
    }

    ref_11a17();
    var0 = self.ref_1220e[self.ref_12200];
  }
}

function ref_1344d() {
  var0 = undefined;

  if(level.mapname == "mp_don4") {
    var0 = (20213, -14849, 5141);
  } else {
    var0 = (-479, 909, 5141);
  }

  return var0;
}

function ref_1344f() {
  playsoundatpos(self.origin, "veh_lbravo_explode");
  earthquake(1, 3, self.origin, 1000);
  playrumbleonposition("grenade_rumble", self.origin);
  physicsexplosionsphere(self.origin, 1000, 100, 2);
}

function ref_11a16(var0) {
  if(self.currentaction != "patrol") {
    self.currentaction = "patrol";
  } else if(self.currentaction == "patrol" && !istrue(var0)) {
    return;
  }

  self clearlookatent();
  self setneargoalnotifydist(500);
  var1 = 0;
  var2 = 0;

  for(;;) {
    foreach(var4 in self.ref_1220e) {}

    if(self.currentaction == "attacking") {
      if(!istrue(var1)) {
        var1 = 1;
      }

      waitframe();
      continue;
    }

    if(!istrue(var0) && istrue(var1)) {
      var1 = 0;
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

  foreach(var1 in self.ref_13461) {
    var1 scripts\mp\hud_util::destroyelem();
    self.ref_13461 = scripts\engine\utility::array_remove(self.ref_13461, var1);
    var1 = undefined;
  }

  self.ref_13461 = undefined;
}

function ref_13ef5() {
  if(!isDefined(self.ref_13461)) {
    return;
  }

  foreach(var1 in self.ref_13461) {
    var1 scripts\mp\hud_util::hideelem();
  }
}

function ref_13eea(var0) {
  foreach(var2 in level.ref_13460.ref_12662) {
    ref_13ef6(var2, var0);
  }
}

function ref_13ee8() {
  foreach(var1 in level.ref_13460.ref_12662) {
    ref_13ef3(var1);
  }
}

function ref_13ee9() {
  foreach(var1 in level.ref_13460.ref_12662) {
    ref_13ef4(var1);
  }
}

function ref_13ef6(var0) {
  ref_13ef5();

  switch (var0) {
    case "inactive":
      break;
    case "active":
      self.soldier_agent_lwfn4 setvalue(4 - level.ref_13460.cp_dntsk_raid_sound_load);
      self.soldier_agent_lwfn4 scripts\mp\hud_util::showelem();
      var1 = undefined;

      if(level.ref_13460.ref_13b97 <= 0) {
        var1 = 120;
      } else {
        var2 = level.ref_13460.ref_13b97 / 1000;
        var3 = gettime() / 1000;
        var4 = var3 - var2;
        var1 = 120 - var4;
      }

      self.soldier_agent_lwfn5 settimer(var1);
      self.soldier_agent_lwfn5 scripts\mp\hud_util::showelem();
      break;
  }
}

function ref_13eeb() {
  foreach(var1 in level.ref_13460.ref_12662) {
    var1.soldier_agent_lwfn4 setvalue(4 - level.ref_13460.cp_dntsk_raid_sound_load);
  }
}

function ref_13edf(var0) {
  if(!isDefined(self.ref_13461)) {
    self.ref_13461 = [];
  }

  self.ref_13461 = scripts\engine\utility::array_add(self.ref_13461, var0);
}

function ref_13ee0(var0, var1, var2, var3, var4, var5, var6) {
  if(!isDefined(var6)) {
    var6 = "TOPLEFT";
  }

  var7 = scripts\mp\hud_util::createfontstring("default", var2);
  var8 = 40;
  var9 = (1 - getdvarfloat("LQORTPMNLL", 0)) * var8;
  var10 = (1 - getdvarfloat("NPLKLQMNPL", 0)) * var8 / 2;
  var7 scripts\mp\hud_util::setpoint(var6, var6, 143 + var9, var5 + var10);
  var7.color = var3;
  var7.label = var0;
  var7 setvalue(var1);
  ref_13edf(var7);
  return var7;
}

function ref_13ee1() {
  var0 = newclienthudelem(self);
  var0.elemtype = "timer";
  var0.font = "default";
  var0.fontscale = 1.25;
  var0.basefontscale = 1.25;
  var0.width = 0;
  var0.height = 10;
  var1 = 40;
  var2 = (1 - getdvarfloat("LQORTPMNLL", 0)) * var1;
  var3 = (1 - getdvarfloat("NPLKLQMNPL", 0)) * var1 / 2;
  var0.x = 65 + var2;
  var0.y = 60 + var3;
  var0.xoffset = 25;
  var0.yoffset = 0;
  var0.children = [];
  var0.hidden = 0;
  ref_13edf(var0);
  return var0;
}

function ref_13291(var0) {
  foreach(var2 in level.ref_13460.ref_12662) {
    var2 playlocalsound(var0, undefined, undefined, 1);
  }
}