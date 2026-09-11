/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58341.gsc
***********************************************/

function get_ai_spawner(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 6;
  }

  var3 = (0, 0, 1) * var2;
  var4 = var0 + var3;
  var5 = var1 + var3;
  return capsuletracepassed(var4, self.radius, self.height - var2, self, 1, 0, 0, var5);
}

function resetbreakertostate() {
  return 8;
}

function request_warning_level() {
  return 360 / resetbreakertostate();
}

function ref_11bca(var0, var1, var2) {
  var3 = var1 * request_warning_level() - 180;
  var4 = var0 + anglesToForward((0, var3, 0)) * var2;
  return var4;
}

function requiredcardtype(var0) {
  return self.ref_11bc9[var0];
}

function ref_140d0(var0) {
  if(!isDefined(self.ref_11bc9)) {
    self.ref_11bc9 = [];
  }

  if(!isDefined(self.ref_11bc9[var0])) {
    self.ref_11bc9[var0] = [];

    for(var1 = 0; var1 < resetbreakertostate(); var1++) {
      self.ref_11bc9[var0][var1] = spawnStruct();
      self.ref_11bc9[var0][var1].timestamp = 0;
      self.ref_11bc9[var0][var1].claimer = undefined;
      self.ref_11bc9[var0][var1].origin = undefined;
      self.ref_11bc9[var0][var1].num = var1;
    }

    return;
  }
}

function respawn_after_death(var0) {
  var1 = var0.origin;

  if(isDefined(var0.groundpos)) {
    var1 = var0.groundpos;

    if(isDefined(self.lootcachesopened) && var0 == self.lootcachesopened && should_enter_combat_after_checking_gas_grenade()) {
      var2 = reset_global_stealth_settings();

      if(isDefined(var2)) {
        var1 = var2.origin;
      }
    }
  } else if(isPlayer(var0) && (var0 isjumping() || var0 ishighjumping())) {
    if(!isDefined(var0.ref_125bb)) {
      var0.ref_125bb = 0;
    }

    if(gettime() > var0.ref_125bb) {
      var0.ref_125ba = getgroundposition(var0.origin, 15);
      var0.ref_125bb = gettime();
    }

    if(isDefined(var0.ref_125ba)) {
      var1 = var0.ref_125ba;
    }
  }

  return var1;
}

function show_deposit_hint(var0, var1) {
  for(var2 = 0; var2 < resetbreakertostate(); var2++) {
    var3 = requiredcardtype(var0, var1);
    var4 = var3[var2];

    if(isDefined(var4.origin)) {
      return true;
    }
  }

  return false;
}

function freefall_start() {
  var0 = self getnearestnode();
}

function should_enter_combat_after_checking_gas_grenade() {
  var0 = self getnearestnode();

  if(isDefined(var0) && isDefined(self.lootcachesopened.ref_11e35)) {
    var1 = self.lootcachesopened.ref_11e35["0"];

    if(isDefined(var1)) {
      return true;
    }
  }

  return false;
}

function reset_global_stealth_settings() {
  var0 = self getnearestnode();
  var1 = self.lootcachesopened.ref_11e35["0"];

  if(!isnumber(var1)) {
    return var1;
  }

  return undefined;
}

function ref_1332a() {
  if(should_enter_combat_after_checking_gas_grenade()) {
    var0 = reset_global_stealth_settings();

    if(!isDefined(var0)) {
      return false;
    }
  }

  return true;
}

function unset_force_aitype_shotgun(var0) {
  if(isDefined(self.lootcachesopened) && var0 == self.lootcachesopened) {
    if(self.lootcachespawncontents > 5) {
      return true;
    }
  }

  return false;
}

function requiredplayercountoveride(var0, var1) {
  var2 = 0;

  if(var2) {
    return var0.origin;
  }

  if(getdvarint("scr_zombieDisableMeleeSectors", 0)) {
    return var0.origin;
  }

  ref_140d0(var0, self.ref_11bcb);
  var3 = requiredcardtype(var0, self.ref_11bcb);
  var4 = var1;
  var5 = self.origin - var4;
  var6 = lengthsquared(var5);
  jumpiffalse(var6 < 256) LOC_000000b4;
  var7 = -1;

  for(var8 = 0; var8 < resetbreakertostate(); var8++) {
    var9 = var3[var8];

    if(isDefined(var9.claimer) && var9.claimer == self) {
      var7 = var9.num;
    }
  }

  if(var7 < 0) {
    var7 = self getentitynumber() % resetbreakertostate();
  }

  var10 = var7;
  goto LOC_000000dd;
}

function ref_13e09(var0, var1, var2, var3) {
  if(gettime() - var0.timestamp >= 50) {
    var0.origin = ref_11bca(var1, var0.num, var2);
    var0.origin = modifybrgasdamage(var0.origin, var3, 55);
    var0.timestamp = gettime();
    return;
  }
}

function modifybrgasdamage(var0, var1, var2, var3) {
  if(!isDefined(var3)) {
    var3 = 18;
  }

  var4 = var0 + (0, 0, var3);
  var5 = var0 + (0, 0, var3 * -1);
  var6 = self aiphysicstrace(var4, var5, var1, var2, 1);

  if(abs(var6[2] - var4[2]) < 0.1) {
    return undefined;
  }

  if(abs(var6[2] - var5[2]) < 0.1) {
    return undefined;
  }

  return var6;
}

function uavdirectionalid() {
  return isDefined(self.dismember_crawl) && self.dismember_crawl;
}

function requestgamerprofile() {
  if(!isDefined(self.ref_11a67) || self.ref_11a67) {
    return self.ref_11bc4;
  }

  return self.ref_11bc5;
}

function required_tank_capacity() {
  if(!isDefined(self.ref_11a67) || self.ref_11a67) {
    return self.ref_11bc7;
  }

  return self.ref_11bc6;
}

function ref_11a68(var0, var1, var2, var3, var4, var5) {
  self.ref_11a61 = var0 * 1000;
  self.ref_11a62 = var3;
  self.ref_11a60 = isDefined(var4) && var4;
  self.ref_11a64 = var5;
  self.ref_11a69 = var2;
  self.ref_11a6a = squared(self.ref_11a69);
  ref_13171(var1);
}

function ref_11a66() {
  if(isDefined(self.load_laser_fx) && self.load_laser_fx > 0) {
    self.load_laser_fx--;

    if(self.load_laser_fx > 0) {
      return;
    }
  }

  self.ref_11a67 = 1;
}

function ref_11a65() {
  if(!isDefined(self.load_laser_fx)) {
    self.load_laser_fx = 0;
  }

  self.load_laser_fx++;
  self.ref_11a67 = 0;
}

function make_all_oscilloscopes_usable(var0, var1, var2, var3) {
  self.magic_shield_fake = var0 * 1000;
  self.magic_rpg_ending = var1;
  self.maderecentkill = var2;
  self.lowpopstart = ["back", "right", "left"];
  self.lumberyard_suicide_truck_speed_manager = [];

  foreach(var5 in self.lowpopstart) {
    self.lumberyard_suicide_truck_speed_manager[var6] = level._effect[var3 + var5];
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

function wave_spawn_selector(var0, var1, var2, var3, var4, var5, var6) {
  self.wave_ai_spawned = var0 * 1000;
  self.wave_ai_killed = var1 * 1000;
  self.wave_ai_debug = var2;
  self.wave_goto_on_spawn = var3;
  self.wave_paused = squared(self.wave_goto_on_spawn);
  self.wave_progression = var4;
  self.wave_revive = squared(self.wave_progression);
  self.wave_default_internal = var6;
  self.wave_aggro_monitor = var5;
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

function getbestspectatecandidate(var0, var1) {
  self endon("death");
  self scragentsetscripted(1);
  scripts\mp\agents\scriptedagents::setstatelocked(1, "ChangeAnimClass");
  self.trackcratemantlingexploit = 1;
  self scragentsetorientmode("face angle abs", (0, self.angles[1], 0));
  self scragentsetanimmode("anim deltas");
  self scragentsetanimscale(1, 1);
  scripts\mp\agents\scriptedagents::playanimnuntilnotetrack_safe(var1, randomint(self getanimentrycount(var1)), "change_anim_class");
  self setanimclass(var0);
  scripts\mp\agents\scriptedagents::setstatelocked(0, "ChangeAnimClass");
  self.trackcratemantlingexploit = 0;
  self scragentsetscripted(0);
}

function rungwperif_flak(var0) {
  var1 = 50;
  var2 = 32;
  var3 = 72;
  var4 = getmovedelta(var0);
  var4 = rotatevector(var4, self.angles);
  var5 = self.origin + var4;
  var6 = (0, 0, var1);
  var7 = self aiphysicstrace(var5 + var6, var5 - var6, var2, var3);
  var8 = var7 - var5;
  return var8[2];
}

function return_num_if_under_vehicle_cap(var0, var1, var2, var3) {
  var4 = getanimlength(var0);
  var5 = getmovedelta(var0, 0, var3 / var4);
  var6 = rotatevector(var5, var2);
  return var1 + var6;
}

function removeleadobjective(var0) {
  var1 = 0.2;
  var2 = getanimlength(var0);
  return min(var1, var2);
}

function ref_122f9(var0, var1) {
  self endon("death");
  level endon("game_ended");
  self scragentdoanimlerp(self.origin, var0, var1);
  wait var1;
  self scragentsetanimmode("anim deltas");
}

function respawn_waits(var0, var1) {
  var2 = 0;

  if(var1 > 1) {
    var3 = int(var1 * 0.5);
    var4 = var3 + var1 % 2;

    if(var0 < 0) {
      var2 = randomint(var4);
    } else {
      var2 = var3 + randomint(var4);
    }
  }

  return var2;
}

function unset_force_aitype_rpg(var0) {
  var1 = self.origin[2] + self.height;

  if(var0.origin[2] < var1) {
    return false;
  }

  var2 = self.origin[2] + self.height + 2 * self.radius;

  if(var0.origin[2] > var2) {
    return false;
  }

  if(isPlayer(var0)) {
    var3 = var0 getvelocity()[2];

    if(abs(var3) > 12) {
      return false;
    }
  }

  var4 = 15;

  if(isDefined(var0.radius)) {
    var4 = var0.radius;
  }

  var5 = self.radius + var4;
  var5 *= var5;

  if(distance2dsquared(self.origin, var0.origin) > var5) {
    return false;
  }

  return true;
}

function ref_1314e(var0) {
  self.favoriteenemy = var0;
}

function is_vandalize_attack_available(var0, var1) {
  var2 = 0;

  if(isDefined(var0)) {
    var3 = var0 - self gettagorigin("J_SpineLower");
    var3 = (var3[0], var3[1], 0);
    var4 = vectortoangles(vectorNormalize(var3));
    var2 = var4[1];
  } else if(isDefined(var1)) {
    var4 = vectortoangles(var1);
    var2 = var4[1] - 180;
  }

  return var2;
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
  ref_131f2();
  mortars_fire_logic();
}

function mortars_fire_projectile() {}

function little_bird_mg_cp_create() {}

function ref_131f2() {
  var0 = clamp(level.ref_1452a / 20, 0, 1);
  var1 = lerp(var0, 0.35, 0.55);
  var2 = lerp(var0, 0.06, 0.12);
  ref_11a68(5, self.ref_11bc5 * 2, self.ref_11bc5 * 1.5, "attack_lunge_boost", level._effect["boost_lunge"]);
  make_all_oscilloscopes_usable(5, var1, "dodge_boost", "boost_dodge_");
  wave_spawn_selector(10, 2, var2, 550, 350, "leap_boost", level._effect["boost_jump"]);
}

function mortars_fire_logic() {
  ref_11a66();
  make_airlock_interactions_usable();
  wave_cooldown_sounds();
}

function lerp(var0, var1, var2) {
  var3 = var2 - var1;
  var4 = var0 * var3;
  var5 = var1 + var4;
  return var5;
}

function little_bird_mg_collision_damage_watcher() {
  ref_11a65();
  mainhouse_intel_sequence();
  wave_airstrikes_allowed();
}

function ref_123cd(var0) {
  if(!isDefined(self.currentdebugweaponindex)) {
    return;
  }

  if(self.currentdebugweaponindex != "no_boost_fx") {
    playFXOnTag(var0, self, self.currentdebugweaponindex);
    return;
  }
}

function player_in_laststand(var0) {
  return var0.inlaststand;
}

function play_pullout_sequence(var0) {
  var1 = [];

  foreach(var3 in level.players) {
    if(player_in_laststand(var3)) {
      var1 = var3;
    }
  }

  var5 = [];

  foreach(var7 in var0) {
    if(ref_11ea6(var7)) {
      continue;
    }

    var8 = 0;

    foreach(var3 in var1) {
      if(distancesquared(var7.origin, var3.origin) < 65536) {
        var8 = 1;
        break;
      }
    }

    if(var8) {
      continue;
    }

    var5 = var7;
  }

  return var5;
}

function updateteamplunderhud(var0, var1) {
  var2 = self.ref_11bc8 * self.ref_11bc8;
  return distancesquared(var0, var1) <= var2;
}

function ref_145d8() {
  return updateteamplunderhud(self.origin, self.initial_forward.origin);
}

function ref_145d6() {
  if(requestgamerprofile() == self.ref_11bc5) {
    return ref_145d7();
  }

  var0 = distancesquared(self.origin, self.initial_forward.origin) <= required_tank_capacity();
  return var0;
}

function ref_145d7() {
  var0 = distancesquared(self.origin, self.initial_forward.origin) <= self.ref_11bc6;

  if(!var0 && (isPlayer(self.initial_forward) || isagent(self.initial_forward))) {
    var1 = undefined;
    var1 = self.initial_forward getgroundentity();

    if(isDefined(var1) && isDefined(var1.targetname) && var1.targetname == "care_package") {
      var0 = distancesquared(self.origin, self.initial_forward.origin) <= self.ref_11bc6 * 4;
    }
  }

  if(!var0 && isPlayer(self.initial_forward) && istrue(self.initial_forward.unset_relic_squadlink)) {
    if(length(self getvelocity()) < 5) {
      var0 = distancesquared(self.origin, self.initial_forward.origin) <= self.ref_11bc6 * 4;
    }
  }

  return var0;
}

function ref_13171(var0) {
  self.ref_11bc4 = var0;
  self.ref_11bc7 = var0 * var0;
}

function ref_11ea6(var0) {
  return !isDefined(var0.ref_14700);
}

function safehouse_vo_start() {
  if(!isDefined(level.ref_146b1)) {
    return 1;
  }

  return level.ref_146b1;
}

function ref_1436e() {
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

function updatesuperuiprogress(var0, var1) {
  var2 = 0;
  var3 = var1[2] - var0[2];
  var2 = var3 <= self.change_stealth_state_to_combat_warpper && var3 >= self.change_yaw_angle;

  if(!var2 && isPlayer(self.initial_forward) && istrue(self.initial_forward.unset_relic_squadlink)) {
    if(length(self getvelocity()) < 5) {
      var2 = var3 <= self.change_stealth_state_to_combat_warpper * 2 && var3 >= self.change_yaw_angle;
    }
  }

  return var2;
}

function vehicle_collision_dvarinit(var0) {
  return updatesuperuiprogress(self.origin, var0);
}

function updateteambettermissionrewardsui(var0, var1) {
  return distance2dsquared(var0, var1) < required_tank_capacity() * 0.75 * 0.75;
}

function vehicle_collision_dvarupdate(var0) {
  return updateteambettermissionrewardsui(self.origin, var0);
}

function ref_1441e() {
  if(unset_force_aitype_rpg(self.initial_forward)) {
    return false;
  }

  return !vehicle_collision_dvarinit(self.initial_forward.origin) && vehicle_collision_dvarupdate(self.initial_forward.origin);
}

function update_hack_objective_marker() {
  var0 = self.origin + (0, 0, self.ref_11bbb);
  var1 = self.initial_forward.origin + (0, 0, self.ref_11bbb);

  if(!isPlayer(self.initial_forward) && !isai(self.initial_forward)) {
    return false;
  }

  var2 = scripts\engine\trace::create_default_contents(1);

  if(scripts\engine\trace::ray_trace_passed(var0, var1, self.initial_forward, var2)) {
    return false;
  }

  return true;
}

function isreallyalive(var0) {
  if(isalive(var0) && !isDefined(var0.fauxdead)) {
    return true;
  }

  return false;
}

function ref_12a48(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 1;
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

    if(var0 == "offmesh" && !ref_145d8()) {
      return false;
    }

    if(var0 == "normal" && !ref_145d6()) {
      return false;
    } else if(var0 == "base" && !ref_145d7()) {
      return false;
    }
  }

  self.wam_failure_threshold = undefined;

  if(var1 && update_hack_objective_marker()) {
    self.wam_failure_threshold = 1;
    return false;
  }

  return true;
}

function requested_veh_spawners(var0) {
  if(!isDefined(self.ref_11bba)) {
    self.ref_11bba = spawnStruct();
  }

  if(unset_force_aitype_shotgun(var0) && !should_enter_combat_after_checking_gas_grenade()) {
    freefall_start();
  }

  var1 = respawn_after_death(var0);
  self.ref_11bba.nuke_addteamrankxpmultiplier = var1;
  var2 = requiredplayercountoveride(var0, var1);

  if(isDefined(var2)) {
    self.ref_11bba.ref_140c0 = 1;
    self.ref_11bba.origin = var2;
  } else {
    self.ref_11bba.ref_140c0 = 0;
    self.ref_11bba.origin = var1;

    if(isDefined(self.lootcachesopened)) {
      if(!isDefined(modifybrgasdamage(self.ref_11bba.origin, 15, 55))) {
        if(!isDefined(self.ref_129fa)) {
          self.ref_129fa = [];

          for(var3 = 0; var3 < resetbreakertostate(); var3++) {
            self.ref_129fa[self.ref_129fa.size] = var3;
          }

          self.ref_129fa = scripts\engine\utility::array_randomize(self.ref_129fa);
        }

        foreach(var5 in self.ref_129fa) {
          var6 = requiredcardtype(var0, self.ref_11bcb);
          var7 = var6[var5];

          if(isDefined(var7.origin)) {
            self.ref_11bba.origin = var7.origin;
            break;
          }
        }
      }
    }
  }

  return self.ref_11bba;
}

function ref_13303(var0, var1) {
  if(istrue(player_in_laststand(var0))) {
    return true;
  }

  if(isDefined(var0.team) && isDefined(self.team) && self.team == var0.team) {
    return true;
  }

  if(updateondamagepredamagemodrelics(var0)) {
    return true;
  }

  if(isDefined(var0.killing_time)) {
    return true;
  }

  if(istrue(var0.notarget)) {
    return true;
  }

  if(istrue(var0.ignoreme)) {
    return true;
  }

  if(!isalive(var0)) {
    return true;
  }

  if(!istrue(var1) && !istrue(self.ref_13305)) {
    if(isDefined(var0.trial_targs) && !var0.trial_targs) {
      return true;
    }
  }

  if(isDefined(level.ref_13304)) {
    if([[level.ref_13304]](var0)) {
      return true;
    }
  }

  return false;
}

function updateondamagepredamagemodrelics(var0) {
  return isDefined(var0.trial_flare_watcher) && var0.trial_flare_watcher;
}

function get_all_doors_ai_should_open(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 6;
  }

  var3 = (0, 0, 1) * var2;
  var4 = var0 + var3;
  var5 = var1 + var3;
  return capsuletracepassed(var4, self.radius, self.height - var2, self, 1, 0, 0, var5);
}

function ishost(var0) {
  return level.brclampstepdamage.iskillstreakdeployweapon["hitLoc"][var0];
}

function ishotjoiningplayer(var0) {
  var1 = scripts\mp\agents\scriptedagents::getangleindexfromselfyaw(var0);
  return level.brclampstepdamage.iskillstreakdeployweapon["hitDirection"][var1];
}

function respawncircleinterppct(var0, var1, var2, var3) {
  if(isDefined(var2)) {
    var4 = var3[var0][var1][var2];
  } else {
    var4 = var4[var1][var2];
  }

  return var4[randomint(var4.size)];
}

function ref_13173(var0) {
  self.legacy.movemode = var0;
  scripts\asm\asm_bb::bb_requestmovetype(self.legacy.movemode);

  if(var0 == "walk") {
    self.ref_11eb2 = 0.8;
    return;
  }

  if(var0 == "run") {
    self.ref_11eb2 = 1;
    return;
  }

  if(var0 == "sprint") {
    self.ref_11eb2 = 1.2;
    return;
  }
}

function ref_131bb(var0) {
  GscBinSkip1(0x45, "walk", [0.65, 1.2]);
}