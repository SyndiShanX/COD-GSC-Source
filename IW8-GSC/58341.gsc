/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58341.gsc
***********************************************/

function get_ai_spawner(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 6;
  }

  var_3 = (0, 0, 1) * var_2;
  var_4 = var_0 + var_3;
  var_5 = var_1 + var_3;
  return capsuletracepassed(var_4, self.radius, self.height - var_2, self, 1, 0, 0, var_5);
}

function resetbreakertostate() {
  return 8;
}

function request_warning_level() {
  return 360 / resetbreakertostate();
}

function ref_11BCA(var_0, var_1, var_2) {
  var_3 = var_1 * request_warning_level() - 180;
  var_4 = var_0 + anglesToForward((0, var_3, 0)) * var_2;
  return var_4;
}

function requiredcardtype(var_0) {
  return self.ref_11BC9[var_0];
}

function ref_140D0(var_0) {
  if(!isDefined(self.ref_11BC9)) {
    self.ref_11BC9 = [];
  }

  if(!isDefined(self.ref_11BC9[var_0])) {
    self.ref_11BC9[var_0] = [];

    for(var_1 = 0; var_1 < resetbreakertostate(); var_1++) {
      self.ref_11BC9[var_0][var_1] = spawnStruct();
      self.ref_11BC9[var_0][var_1].timestamp = 0;
      self.ref_11BC9[var_0][var_1].claimer = undefined;
      self.ref_11BC9[var_0][var_1].origin = undefined;
      self.ref_11BC9[var_0][var_1].num = var_1;
    }

    return;
  }
}

function respawn_after_death(var_0) {
  var_1 = var_0.origin;

  if(isDefined(var_0.groundpos)) {
    var_1 = var_0.groundpos;

    if(isDefined(self.lootcachesopened) && var_0 == self.lootcachesopened && should_enter_combat_after_checking_gas_grenade()) {
      var_2 = reset_global_stealth_settings();

      if(isDefined(var_2)) {
        var_1 = var_2.origin;
      }
    }
  } else if(isPlayer(var_0) && (var_0 isjumping() || var_0 ishighjumping())) {
    if(!isDefined(var_0.ref_125BB)) {
      var_0.ref_125BB = 0;
    }

    if(gettime() > var_0.ref_125BB) {
      var_0.ref_125BA = getgroundposition(var_0.origin, 15);
      var_0.ref_125BB = gettime();
    }

    if(isDefined(var_0.ref_125BA)) {
      var_1 = var_0.ref_125BA;
    }
  }

  return var_1;
}

function show_deposit_hint(var_0, var_1) {
  for(var_2 = 0; var_2 < resetbreakertostate(); var_2++) {
    var_3 = requiredcardtype(var_0, var_1);
    var_4 = var_3[var_2];

    if(isDefined(var_4.origin)) {
      return true;
    }
  }

  return false;
}

function freefall_start() {
  var_0 = self getnearestnode();
}

function should_enter_combat_after_checking_gas_grenade() {
  var_0 = self getnearestnode();

  if(isDefined(var_0) && isDefined(self.lootcachesopened.ref_11E35)) {
    var_1 = self.lootcachesopened.ref_11E35["0"];

    if(isDefined(var_1)) {
      return true;
    }
  }

  return false;
}

function reset_global_stealth_settings() {
  var_0 = self getnearestnode();
  var_1 = self.lootcachesopened.ref_11E35["0"];

  if(!isnumber(var_1)) {
    return var_1;
  }

  return undefined;
}

function ref_1332A() {
  if(should_enter_combat_after_checking_gas_grenade()) {
    var_0 = reset_global_stealth_settings();

    if(!isDefined(var_0)) {
      return false;
    }
  }

  return true;
}

function unset_force_aitype_shotgun(var_0) {
  if(isDefined(self.lootcachesopened) && var_0 == self.lootcachesopened) {
    if(self.lootcachespawncontents > 5) {
      return true;
    }
  }

  return false;
}

function requiredplayercountoveride(var_0, var_1) {
  var_2 = 0;

  if(var_2) {
    return var_0.origin;
  }

  if(getdvarint("scr_zombieDisableMeleeSectors", 0)) {
    return var_0.origin;
  }

  ref_140D0(var_0, self.ref_11BCB);
  var_3 = requiredcardtype(var_0, self.ref_11BCB);
  var_4 = var_1;
  var_5 = self.origin - var_4;
  var_6 = lengthsquared(var_5);
  jumpiffalse(var_6 < 256) LOC_000000b4;
  var_7 = -1;

  for(var_8 = 0; var_8 < resetbreakertostate(); var_8++) {
    var_9 = var_3[var_8];

    if(isDefined(var_9.claimer) && var_9.claimer == self) {
      var_7 = var_9.num;
    }
  }

  if(var_7 < 0) {
    var_7 = self getentitynumber() % resetbreakertostate();
  }

  var_10 = var_7;
  goto LOC_000000dd;
}

function ref_13E09(var_0, var_1, var_2, var_3) {
  if(gettime() - var_0.timestamp >= 50) {
    var_0.origin = ref_11BCA(var_1, var_0.num, var_2);
    var_0.origin = modifybrgasdamage(var_0.origin, var_3, 55);
    var_0.timestamp = gettime();
    return;
  }
}

function modifybrgasdamage(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 18;
  }

  var_4 = var_0 + (0, 0, var_3);
  var_5 = var_0 + (0, 0, var_3 * -1);
  var_6 = self aiphysicstrace(var_4, var_5, var_1, var_2, 1);

  if(abs(var_6[2] - var_4[2]) < 0.1) {
    return undefined;
  }

  if(abs(var_6[2] - var_5[2]) < 0.1) {
    return undefined;
  }

  return var_6;
}

function uavdirectionalid() {
  return isDefined(self.dismember_crawl) && self.dismember_crawl;
}

function requestgamerprofile() {
  if(!isDefined(self.ref_11A67) || self.ref_11A67) {
    return self.ref_11BC4;
  }

  return self.ref_11BC5;
}

function required_tank_capacity() {
  if(!isDefined(self.ref_11A67) || self.ref_11A67) {
    return self.ref_11BC7;
  }

  return self.ref_11BC6;
}

function ref_11A68(var_0, var_1, var_2, var_3, var_4, var_5) {
  self.ref_11A61 = var_0 * 1000;
  self.ref_11A62 = var_3;
  self.ref_11A60 = isDefined(var_4) && var_4;
  self.ref_11A64 = var_5;
  self.ref_11A69 = var_2;
  self.ref_11A6A = squared(self.ref_11A69);
  ref_13171(var_1);
}

function ref_11A66() {
  if(isDefined(self.load_laser_fx) && self.load_laser_fx > 0) {
    self.load_laser_fx--;

    if(self.load_laser_fx > 0) {
      return;
    }
  }

  self.ref_11A67 = 1;
}

function ref_11A65() {
  if(!isDefined(self.load_laser_fx)) {
    self.load_laser_fx = 0;
  }

  self.load_laser_fx++;
  self.ref_11A67 = 0;
}

function make_all_oscilloscopes_usable(var_0, var_1, var_2, var_3) {
  self.magic_shield_fake = var_0 * 1000;
  self.magic_rpg_ending = var_1;
  self.maderecentkill = var_2;
  self.lowpopstart = ["back", "right", "left"];
  self.lumberyard_suicide_truck_speed_manager = [];

  foreach(var_5 in self.lowpopstart) {
    self.lumberyard_suicide_truck_speed_manager[var_6] = level._effect[var_3 + var_5];
  }
}

function make_airlock_interactions_usable() {
  if(isDefined(self.little_bird_trail) && self.little_bird_trail > 0) {
    self.little_bird_trail--;

    if(self.little_bird_trail > 0) {
      return;
    }
  }

  self.make_all_doors_solid = 1;
}

function mainhouse_intel_sequence() {
  if(!isDefined(self.little_bird_trail)) {
    self.little_bird_trail = 0;
  }

  self.little_bird_trail++;
  self.make_all_doors_solid = 0;
}

function wave_spawn_selector(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self.wave_ai_spawned = var_0 * 1000;
  self.wave_ai_killed = var_1 * 1000;
  self.wave_ai_debug = var_2;
  self.wave_goto_on_spawn = var_3;
  self.wave_paused = squared(self.wave_goto_on_spawn);
  self.wave_progression = var_4;
  self.wave_revive = squared(self.wave_progression);
  self.wave_default_internal = var_6;
  self.wave_aggro_monitor = var_5;
  self.wave_enemies_remaining = 0;
  self.wave_failsafe_end = 0;
}

function wave_cooldown_sounds() {
  if(isDefined(self.load_airfield) && self.load_airfield > 0) {
    self.load_airfield--;

    if(self.load_airfield > 0) {
      return;
    }
  }

  self.wave_default = 1;
}

function wave_airstrikes_allowed() {
  if(!isDefined(self.load_airfield)) {
    self.load_airfield = 0;
  }

  self.load_airfield++;
  self.wave_default = 0;
}

function getbestspectatecandidate(var_0, var_1) {
  self endon("death");
  self scragentsetscripted(1);
  scripts\mp\agents\scriptedagents::setstatelocked(1, "ChangeAnimClass");
  self.trackcratemantlingexploit = 1;
  self scragentsetorientmode("face angle abs", (0, self.angles[1], 0));
  self scragentsetanimmode("anim deltas");
  self scragentsetanimscale(1, 1);
  scripts\mp\agents\scriptedagents::playanimnuntilnotetrack_safe(var_1, randomint(self getanimentrycount(var_1)), "change_anim_class");
  self setanimclass(var_0);
  scripts\mp\agents\scriptedagents::setstatelocked(0, "ChangeAnimClass");
  self.trackcratemantlingexploit = 0;
  self scragentsetscripted(0);
}

function rungwperif_flak(var_0) {
  var_1 = 50;
  var_2 = 32;
  var_3 = 72;
  var_4 = getmovedelta(var_0);
  var_4 = rotatevector(var_4, self.angles);
  var_5 = self.origin + var_4;
  var_6 = (0, 0, var_1);
  var_7 = self aiphysicstrace(var_5 + var_6, var_5 - var_6, var_2, var_3);
  var_8 = var_7 - var_5;
  return var_8[2];
}

function return_num_if_under_vehicle_cap(var_0, var_1, var_2, var_3) {
  var_4 = getanimlength(var_0);
  var_5 = getmovedelta(var_0, 0, var_3 / var_4);
  var_6 = rotatevector(var_5, var_2);
  return var_1 + var_6;
}

function removeleadobjective(var_0) {
  var_1 = 0.2;
  var_2 = getanimlength(var_0);
  return min(var_1, var_2);
}

function ref_122F9(var_0, var_1) {
  self endon("death");
  level endon("game_ended");
  self scragentdoanimlerp(self.origin, var_0, var_1);
  wait var_1;
  self scragentsetanimmode("anim deltas");
}

function respawn_waits(var_0, var_1) {
  var_2 = 0;

  if(var_1 > 1) {
    var_3 = int(var_1 * 0.5);
    var_4 = var_3 + var_1 % 2;

    if(var_0 < 0) {
      var_2 = randomint(var_4);
    } else {
      var_2 = var_3 + randomint(var_4);
    }
  }

  return var_2;
}

function unset_force_aitype_rpg(var_0) {
  var_1 = self.origin[2] + self.height;

  if(var_0.origin[2] < var_1) {
    return false;
  }

  var_2 = self.origin[2] + self.height + 2 * self.radius;

  if(var_0.origin[2] > var_2) {
    return false;
  }

  if(isPlayer(var_0)) {
    var_3 = var_0 getvelocity()[2];

    if(abs(var_3) > 12) {
      return false;
    }
  }

  var_4 = 15;

  if(isDefined(var_0.radius)) {
    var_4 = var_0.radius;
  }

  var_5 = self.radius + var_4;
  var_5 *= var_5;

  if(distance2dsquared(self.origin, var_0.origin) > var_5) {
    return false;
  }

  return true;
}

function ref_1314E(var_0) {
  self.favoriteenemy = var_0;
}

function is_vandalize_attack_available(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0)) {
    var_3 = var_0 - self gettagorigin("J_SpineLower");
    var_3 = (var_3[0], var_3[1], 0);
    var_4 = vectortoangles(vectorNormalize(var_3));
    var_2 = var_4[1];
  } else if(isDefined(var_1)) {
    var_4 = vectortoangles(var_1);
    var_2 = var_4[1] - 180;
  }

  return var_2;
}

function little_bird_initomnvars() {
  if(!isDefined(self.lmg_too_far_away)) {
    self.lmg_too_far_away = 0;
  }

  self.lmg_too_far_away++;
  little_bird_mg_collision_damage_watcher();
  little_bird_mg_cp_create();
}

function sg_think() {
  return istrue(self.should_skip_info_loop);
}

function mortars() {
  if(isDefined(level.little_bird_mg_initlate) && level.little_bird_mg_initlate) {
    return;
  }

  if(isDefined(self.lmg_too_far_away) && self.lmg_too_far_away > 0) {
    self.lmg_too_far_away--;

    if(self.lmg_too_far_away > 0) {
      return;
    }
  }

  self.should_skip_info_loop = 1;
  mortars_fire_projectile();
  ref_131F2();
  mortars_fire_logic();
}

function mortars_fire_projectile() {}

function little_bird_mg_cp_create() {}

function ref_131F2() {
  var_0 = clamp(level.ref_1452A / 20, 0, 1);
  var_1 = lerp(var_0, 0.35, 0.55);
  var_2 = lerp(var_0, 0.06, 0.12);
  ref_11A68(5, self.ref_11BC5 * 2, self.ref_11BC5 * 1.5, "attack_lunge_boost", level._effect["boost_lunge"]);
  make_all_oscilloscopes_usable(5, var_1, "dodge_boost", "boost_dodge_");
  wave_spawn_selector(10, 2, var_2, 550, 350, "leap_boost", level._effect["boost_jump"]);
}

function mortars_fire_logic() {
  ref_11A66();
  make_airlock_interactions_usable();
  wave_cooldown_sounds();
}

function lerp(var_0, var_1, var_2) {
  var_3 = var_2 - var_1;
  var_4 = var_0 * var_3;
  var_5 = var_1 + var_4;
  return var_5;
}

function little_bird_mg_collision_damage_watcher() {
  ref_11A65();
  mainhouse_intel_sequence();
  wave_airstrikes_allowed();
}

function ref_123CD(var_0) {
  if(!isDefined(self.currentdebugweaponindex)) {
    return;
  }

  if(self.currentdebugweaponindex != "no_boost_fx") {
    playFXOnTag(var_0, self, self.currentdebugweaponindex);
    return;
  }
}

function player_in_laststand(var_0) {
  return var_0.inlaststand;
}

function play_pullout_sequence(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(player_in_laststand(var_3)) {
      var_1 = var_3;
    }
  }

  var_5 = [];

  foreach(var_7 in var_0) {
    if(ref_11EA6(var_7)) {
      continue;
    }

    var_8 = 0;

    foreach(var_3 in var_1) {
      if(distancesquared(var_7.origin, var_3.origin) < 65536) {
        var_8 = 1;
        break;
      }
    }

    if(var_8) {
      continue;
    }

    var_5 = var_7;
  }

  return var_5;
}

function updateteamplunderhud(var_0, var_1) {
  var_2 = self.ref_11BC8 * self.ref_11BC8;
  return distancesquared(var_0, var_1) <= var_2;
}

function ref_145D8() {
  return updateteamplunderhud(self.origin, self.initial_forward.origin);
}

function ref_145D6() {
  if(requestgamerprofile() == self.ref_11BC5) {
    return ref_145D7();
  }

  var_0 = distancesquared(self.origin, self.initial_forward.origin) <= required_tank_capacity();
  return var_0;
}

function ref_145D7() {
  var_0 = distancesquared(self.origin, self.initial_forward.origin) <= self.ref_11BC6;

  if(!var_0 && (isPlayer(self.initial_forward) || isagent(self.initial_forward))) {
    var_1 = undefined;
    var_1 = self.initial_forward getgroundentity();

    if(isDefined(var_1) && isDefined(var_1.targetname) && var_1.targetname == "care_package") {
      var_0 = distancesquared(self.origin, self.initial_forward.origin) <= self.ref_11BC6 * 4;
    }
  }

  if(!var_0 && isPlayer(self.initial_forward) && istrue(self.initial_forward.unset_relic_squadlink)) {
    if(length(self getvelocity()) < 5) {
      var_0 = distancesquared(self.origin, self.initial_forward.origin) <= self.ref_11BC6 * 4;
    }
  }

  return var_0;
}

function ref_13171(var_0) {
  self.ref_11BC4 = var_0;
  self.ref_11BC7 = var_0 * var_0;
}

function ref_11EA6(var_0) {
  return !isDefined(var_0.ref_14700);
}

function safehouse_vo_start() {
  if(!isDefined(level.ref_146B1)) {
    return 1;
  }

  return level.ref_146B1;
}

function ref_1436E() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("bad_path");
    self.clearsoundsubmixmpbrinfilac130 = 1;

    if(isDefined(self.lootcachesopened)) {
      self.lootcachespawncontents++;
    }
  }
}

function sfx_misc_field_expl() {
  return true;
}

function lightsfloor01() {
  if(isDefined(self.wam_interaction_activate) && isDefined(self.wam_first_node) && distance2dsquared(self.initial_forward.origin, self.wam_interaction_activate) < 4 && distancesquared(self.origin, self.wam_first_node) < 2500) {
    return true;
  }

  return false;
}

function lightscriptable() {
  if(isDefined(self.walla_lab_civ_scientists) && isDefined(self.wake_on_objective_b) && distance2dsquared(self.initial_forward.origin, self.walla_lab_civ_scientists) < 4 && distancesquared(self.origin, self.wake_on_objective_b) < 2500) {
    return true;
  }

  return false;
}

function updatesuperuiprogress(var_0, var_1) {
  var_2 = 0;
  var_3 = var_1[2] - var_0[2];
  var_2 = var_3 <= self.change_stealth_state_to_combat_warpper && var_3 >= self.change_yaw_angle;

  if(!var_2 && isPlayer(self.initial_forward) && istrue(self.initial_forward.unset_relic_squadlink)) {
    if(length(self getvelocity()) < 5) {
      var_2 = var_3 <= self.change_stealth_state_to_combat_warpper * 2 && var_3 >= self.change_yaw_angle;
    }
  }

  return var_2;
}

function vehicle_collision_dvarinit(var_0) {
  return updatesuperuiprogress(self.origin, var_0);
}

function updateteambettermissionrewardsui(var_0, var_1) {
  return distance2dsquared(var_0, var_1) < required_tank_capacity() * 0.75 * 0.75;
}

function vehicle_collision_dvarupdate(var_0) {
  return updateteambettermissionrewardsui(self.origin, var_0);
}

function ref_1441E() {
  if(unset_force_aitype_rpg(self.initial_forward)) {
    return false;
  }

  return !vehicle_collision_dvarinit(self.initial_forward.origin) && vehicle_collision_dvarupdate(self.initial_forward.origin);
}

function update_hack_objective_marker() {
  var_0 = self.origin + (0, 0, self.ref_11BBB);
  var_1 = self.initial_forward.origin + (0, 0, self.ref_11BBB);

  if(!isPlayer(self.initial_forward) && !isai(self.initial_forward)) {
    return false;
  }

  var_2 = scripts\engine\trace::create_default_contents(1);

  if(scripts\engine\trace::ray_trace_passed(var_0, var_1, self.initial_forward, var_2)) {
    return false;
  }

  return true;
}

function isreallyalive(var_0) {
  if(isalive(var_0) && !isDefined(var_0.fauxdead)) {
    return true;
  }

  return false;
}

function ref_12A48(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(self.initial_forward)) {
    return false;
  }

  if(!isreallyalive(self.initial_forward)) {
    return false;
  }

  if(self.aistate == "traverse") {
    return false;
  }

  if(!unset_force_aitype_rpg(self.initial_forward)) {
    if(!vehicle_collision_dvarinit(self.initial_forward.origin)) {
      return false;
    }

    if(var_0 == "offmesh" && !ref_145D8()) {
      return false;
    }

    if(var_0 == "normal" && !ref_145D6()) {
      return false;
    } else if(var_0 == "base" && !ref_145D7()) {
      return false;
    }
  }

  self.wam_failure_threshold = undefined;

  if(var_1 && update_hack_objective_marker()) {
    self.wam_failure_threshold = 1;
    return false;
  }

  return true;
}

function requested_veh_spawners(var_0) {
  if(!isDefined(self.ref_11BBA)) {
    self.ref_11BBA = spawnStruct();
  }

  if(unset_force_aitype_shotgun(var_0) && !should_enter_combat_after_checking_gas_grenade()) {
    freefall_start();
  }

  var_1 = respawn_after_death(var_0);
  self.ref_11BBA.nuke_addteamrankxpmultiplier = var_1;
  var_2 = requiredplayercountoveride(var_0, var_1);

  if(isDefined(var_2)) {
    self.ref_11BBA.ref_140C0 = 1;
    self.ref_11BBA.origin = var_2;
  } else {
    self.ref_11BBA.ref_140C0 = 0;
    self.ref_11BBA.origin = var_1;

    if(isDefined(self.lootcachesopened)) {
      if(!isDefined(modifybrgasdamage(self.ref_11BBA.origin, 15, 55))) {
        if(!isDefined(self.ref_129FA)) {
          self.ref_129FA = [];

          for(var_3 = 0; var_3 < resetbreakertostate(); var_3++) {
            self.ref_129FA[self.ref_129FA.size] = var_3;
          }

          self.ref_129FA = scripts\engine\utility::array_randomize(self.ref_129FA);
        }

        foreach(var_5 in self.ref_129FA) {
          var_6 = requiredcardtype(var_0, self.ref_11BCB);
          var_7 = var_6[var_5];

          if(isDefined(var_7.origin)) {
            self.ref_11BBA.origin = var_7.origin;
            break;
          }
        }
      }
    }
  }

  return self.ref_11BBA;
}

function ref_13303(var_0, var_1) {
  if(istrue(player_in_laststand(var_0))) {
    return true;
  }

  if(isDefined(var_0.team) && isDefined(self.team) && self.team == var_0.team) {
    return true;
  }

  if(updateondamagepredamagemodrelics(var_0)) {
    return true;
  }

  if(isDefined(var_0.killing_time)) {
    return true;
  }

  if(istrue(var_0.notarget)) {
    return true;
  }

  if(istrue(var_0.ignoreme)) {
    return true;
  }

  if(!isalive(var_0)) {
    return true;
  }

  if(!istrue(var_1) && !istrue(self.ref_13305)) {
    if(isDefined(var_0.trial_targs) && !var_0.trial_targs) {
      return true;
    }
  }

  if(isDefined(level.ref_13304)) {
    if([[level.ref_13304]](var_0)) {
      return true;
    }
  }

  return false;
}

function updateondamagepredamagemodrelics(var_0) {
  return isDefined(var_0.trial_flare_watcher) && var_0.trial_flare_watcher;
}

function get_all_doors_ai_should_open(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 6;
  }

  var_3 = (0, 0, 1) * var_2;
  var_4 = var_0 + var_3;
  var_5 = var_1 + var_3;
  return capsuletracepassed(var_4, self.radius, self.height - var_2, self, 1, 0, 0, var_5);
}

function ishost(var_0) {
  return level.brclampstepdamage.iskillstreakdeployweapon["hitLoc"][var_0];
}

function ishotjoiningplayer(var_0) {
  var_1 = scripts\mp\agents\scriptedagents::getangleindexfromselfyaw(var_0);
  return level.brclampstepdamage.iskillstreakdeployweapon["hitDirection"][var_1];
}

function respawncircleinterppct(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2)) {
    var_4 = var_3[var_0][var_1][var_2];
  } else {
    var_4 = var_4[var_1][var_2];
  }

  return var_4[randomint(var_4.size)];
}

function ref_13173(var_0) {
  self.legacy.movemode = var_0;
  scripts\asm\asm_bb::bb_requestmovetype(self.legacy.movemode);

  if(var_0 == "walk") {
    self.ref_11EB2 = 0.8;
    return;
  }

  if(var_0 == "run") {
    self.ref_11EB2 = 1;
    return;
  }

  if(var_0 == "sprint") {
    self.ref_11EB2 = 1.2;
    return;
  }
}

function ref_131BB(var_0) {
  GscBinSkip1(0x45, "walk", [0.65, 1.2]);
}