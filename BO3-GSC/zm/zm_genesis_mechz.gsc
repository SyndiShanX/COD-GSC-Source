/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_genesis_mechz.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\mechz;
#using scripts\shared\ai\systems\animation_state_machine_mocomp;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_ai_mechz;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weap_idgun;
#using scripts\zm\zm_genesis_portals;
#using scripts\zm\zm_genesis_round_bosses;
#using scripts\zm\zm_genesis_vo;
#namespace zm_genesis_mechz;

function autoexec init() {
  function_24ed806f();
  level flag::init("can_spawn_mechz", 1);
  spawner::add_archetype_spawn_function("mechz", &function_d8d01032);
  spawner::add_archetype_spawn_function("mechz", &function_b7e11612);
  level thread function_76e7495b();
  level.mechz_should_stun_override = &function_f517cdd6;
  level.var_7f2a926d = &mechz_health_increases;
  level.mechz_damage_override = &mechz_damage_override;
  level.var_7d2a391d = &spawn_effect;
  if(ai::shouldregisterclientfieldforarchetype("mechz")) {
    clientfield::register("actor", "death_ray_shock_fx", 15000, 1, "int");
  }
  clientfield::register("actor", "mechz_fx_spawn", 15000, 1, "counter");
  level thread function_78e44cda();
}

function private function_24ed806f() {
  behaviortreenetworkutility::registerbehaviortreescriptapi("castleMechzTrapService", &function_b25360f);
  behaviortreenetworkutility::registerbehaviortreescriptapi("genesisVortexService", &function_8746ceea);
  behaviortreenetworkutility::registerbehaviortreescriptapi("genesisMechzOctobombService", &function_2ffb7337);
  behaviortreenetworkutility::registerbehaviortreescriptapi("castleMechzShouldMoveToTrap", &function_beb13c4b);
  behaviortreenetworkutility::registerbehaviortreescriptapi("castleMechzIsAtTrap", &function_fc277828);
  behaviortreenetworkutility::registerbehaviortreescriptapi("castleMechzShouldAttackTrap", &function_d1cb5cbc);
  behaviortreenetworkutility::registerbehaviortreescriptapi("genesisMechzShouldOctobombAttack", &function_4e06a982);
  behaviortreenetworkutility::registerbehaviortreescriptapi("casteMechzTrapMoveTerminate", &function_4210ca29);
  behaviortreenetworkutility::registerbehaviortreescriptapi("casteMechzTrapAttackTerminate", &function_910e57ee);
  behaviortreenetworkutility::registerbehaviortreescriptapi("genesisMechzDestoryOctobomb", &function_78198ba2);
  animationstatenetwork::registeranimationmocomp("mocomp_trap_attack@mechz", &function_45f397ee, undefined, &function_9da58a6f);
  animationstatenetwork::registeranimationmocomp("mocomp_teleport_traversal@mechz", &teleporttraversalmocompstart, undefined, undefined);
}

function private function_76e7495b() {
  wait(0.5);
  var_85129cef = getEntArray("zombie_trap", "targetname");
  foreach(e_trap in var_85129cef) {
    if(e_trap.script_noteworthy == "electric") {
      level.electric_trap = e_trap;
    }
  }
}

function private function_b25360f(entity) {
  if(isDefined(entity.var_d77404f7) && entity.var_d77404f7 || (isDefined(entity.var_72308ff2) && entity.var_72308ff2)) {
    return true;
  }
  if(level flag::get("masher_on")) {
    if(entity function_d8f5da34("masher_trap_switch")) {
      return true;
    }
  }
  if(isDefined(level.electric_trap)) {
    if(isDefined(level.electric_trap._trap_in_use) && level.electric_trap._trap_in_use && (!(isDefined(level.electric_trap._trap_cooling_down) && level.electric_trap._trap_cooling_down))) {
      if(entity function_d8f5da34("elec_trap_switch")) {
        return true;
      }
    }
  }
  return false;
}

function private function_604404(entity) {
  if(isDefined(self.react)) {
    foreach(react in self.react) {
      if(react == entity) {
        return true;
      }
    }
  }
  return false;
}

function private function_e92d3bb1(entity) {
  if(!isDefined(self.react)) {
    self.react = [];
  }
  self.react[self.react.size] = entity;
}

function private function_8746ceea(entity) {
  if(!entity zm_ai_mechz::function_58655f2a()) {
    return false;
  }
  if(isDefined(level.vortex_manager) && isDefined(level.vortex_manager.a_active_vorticies)) {
    foreach(vortex in level.vortex_manager.a_active_vorticies) {
      if(!vortex function_604404(entity)) {
        dist_sq = distancesquared(vortex.origin, self.origin);
        if(dist_sq < 9216) {
          entity.stun = 1;
          entity.vortex = vortex;
          if(isDefined(vortex.weapon) && idgun::function_9b7ac6a9(vortex.weapon)) {
            blackboard::setblackboardattribute(entity, "_zombie_damageweapon_type", "packed");
          }
          vortex function_e92d3bb1(entity);
          return true;
        }
      }
    }
  }
  return false;
}

function private function_2ffb7337(entity) {
  if(isDefined(entity.destroy_octobomb)) {
    entity setgoal(entity.destroy_octobomb.origin);
    return true;
  }
  if(isDefined(level.octobombs)) {
    foreach(octobomb in level.octobombs) {
      if(isDefined(octobomb)) {
        dist_sq = distancesquared(octobomb.origin, self.origin);
        if(dist_sq < 360000) {
          entity.destroy_octobomb = octobomb;
          entity setgoal(octobomb.origin);
          return true;
        }
      }
    }
  }
  return false;
}

function private function_d8f5da34(var_2dba2212) {
  var_3a067a8d = struct::get_array(var_2dba2212, "script_noteworthy");
  self.s_trap = undefined;
  n_closest_dist_sq = 57600;
  foreach(s_trap in var_3a067a8d) {
    n_dist_sq = distancesquared(s_trap.origin, self.origin);
    if(n_dist_sq < n_closest_dist_sq) {
      n_closest_dist_sq = n_dist_sq;
      self.s_trap = s_trap;
    }
  }
  if(isDefined(self.s_trap)) {
    self.var_d77404f7 = 1;
    self.ignoreall = 1;
    self setgoal(self.s_trap.origin);
    self thread function_957c9419();
    return true;
  }
  return false;
}

function function_957c9419() {
  self endon("death");
  wait(60);
  if(isDefined(self.var_d77404f7) && self.var_d77404f7 || (isDefined(self.var_72308ff2) && self.var_72308ff2) || (isDefined(self.ignoreall) && self.ignoreall)) {
    self.var_d77404f7 = 0;
    self.var_72308ff2 = 0;
    self.ignoreall = 0;
    mechzbehavior::mechztargetservice(self);
  }
}

function function_beb13c4b(entity) {
  if(isDefined(entity.var_d77404f7) && entity.var_d77404f7) {
    return true;
  }
  return false;
}

function function_fc277828(entity) {
  if(entity isatgoal()) {
    return true;
  }
  return false;
}

function function_d1cb5cbc(entity) {
  if(isDefined(entity.var_72308ff2) && entity.var_72308ff2) {
    return true;
  }
  return false;
}

function private function_4e06a982(entity) {
  if(!isDefined(entity.destroy_octobomb)) {
    return false;
  }
  if(distancesquared(entity.origin, entity.destroy_octobomb.origin) > 16384) {
    return false;
  }
  yaw = abs(zombie_utility::getyawtospot(entity.destroy_octobomb.origin));
  if(yaw > 45) {
    return false;
  }
  return true;
}

function function_4210ca29(entity) {
  entity.var_d77404f7 = 0;
  entity.var_72308ff2 = 1;
}

function function_910e57ee(entity) {
  entity.var_72308ff2 = 0;
  entity.ignoreall = 0;
  if(isDefined(entity.s_trap)) {
    if(entity.s_trap.script_noteworthy == "masher_trap_switch") {
      level flag::clear("masher_on");
    } else {
      level.electric_trap notify("trap_deactivate");
    }
  }
  mechzbehavior::mechztargetservice(entity);
}

function function_78198ba2(entity) {
  if(isDefined(entity.destroy_octobomb)) {
    entity.destroy_octobomb detonate();
    entity.destroy_octobomb = undefined;
  }
  mechzbehavior::mechzstopflame(entity);
}

function function_45f397ee(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity orientmode("face angle", entity.s_trap.angles[1]);
  entity animmode("normal");
}

function function_9da58a6f(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity orientmode("face default");
}

function mechz_health_increases() {
  if(!isDefined(level.mechz_last_spawn_round) || level.round_number > level.mechz_last_spawn_round) {
    a_players = getplayers();
    n_player_modifier = 1;
    switch (a_players.size) {
      case 0:
      case 1: {
        n_player_modifier = 1;
        break;
      }
      case 2: {
        n_player_modifier = 1.33;
        break;
      }
      case 3: {
        n_player_modifier = 1.66;
        break;
      }
      case 4: {
        n_player_modifier = 2;
        break;
      }
    }
    var_485a2c2c = level.zombie_health / level.zombie_vars["zombie_health_start"];
    level.mechz_health = int(n_player_modifier * (level.mechz_base_health + (level.mechz_health_increase * var_485a2c2c)));
    level.mechz_faceplate_health = int(n_player_modifier * (level.var_fa14536d + (level.var_1a5bb9d8 * var_485a2c2c)));
    level.mechz_powercap_cover_health = int(n_player_modifier * (level.mechz_powercap_cover_health + (level.var_a1943286 * var_485a2c2c)));
    level.mechz_powercap_health = int(n_player_modifier * (level.mechz_powercap_health + (level.var_9684c99e * var_485a2c2c)));
    level.var_2cbc5b59 = int(n_player_modifier * (level.var_3f1bf221 + (level.var_158234c * var_485a2c2c)));
    level.mechz_health = function_26beb37e(level.mechz_health, 17500, n_player_modifier);
    level.mechz_faceplate_health = function_26beb37e(level.mechz_faceplate_health, 16000, n_player_modifier);
    level.mechz_powercap_cover_health = function_26beb37e(level.mechz_powercap_cover_health, 7500, n_player_modifier);
    level.mechz_powercap_health = function_26beb37e(level.mechz_powercap_health, 5000, n_player_modifier);
    level.var_2cbc5b59 = function_26beb37e(level.var_2cbc5b59, 3500, n_player_modifier);
    level.mechz_last_spawn_round = level.round_number;
  }
}

function function_26beb37e(n_value, n_limit, n_player_modifier) {
  if(n_value >= (n_limit * n_player_modifier)) {
    n_value = int(n_limit * n_player_modifier);
  }
  return n_value;
}

function function_d8d01032() {
  self.idgun_damage_cb = &function_5f2149bb;
  self.var_c732138b = &function_1df1ec14;
  self.traversalspeedboost = &function_40ef38f8;
  self thread function_a2a11991();
  self thread function_b2a1b297();
  self thread function_2a26e636();
  self thread zm::update_zone_name();
  self waittill("death");
  self thread function_2a2bfc25();
  if(isDefined(self.var_9b31a70d) && self.var_9b31a70d) {
    level.var_638dde56--;
  }
  level notify("hash_8f65ad3d");
}

function spawn_effect() {
  self function_1faf1646();
  util::wait_network_frame();
  self clientfield::increment("mechz_fx_spawn");
  wait(1);
  self function_ee090a93();
}

function function_b7e11612() {
  self waittill("death");
  self zm_genesis_vo::function_f7879c72(self.attacker);
}

function function_b2a1b297() {
  self waittill("actor_corpse", mechz);
  wait(60);
  if(isDefined(mechz)) {
    mechz delete();
  }
}

function function_2a26e636() {
  self endon("death");
  while(true) {
    if(!isDefined(self.zone_name)) {
      wait(0.1);
      continue;
    }
    var_225b5e15 = 1;
    var_e01c8f74 = 1;
    players = getplayers();
    foreach(player in players) {
      if(isDefined(player.var_5aef0317) && player.var_5aef0317 || (isDefined(player.var_a393601c) && player.var_a393601c)) {
        var_225b5e15 = 0;
        var_e01c8f74 = 0;
        break;
        continue;
      }
      if(isDefined(player.am_i_valid) && player.am_i_valid) {
        if(!isDefined(player.zone_name)) {
          var_225b5e15 = 0;
          var_e01c8f74 = 0;
          break;
        }
        if(isDefined(player.zone_name)) {
          if(player.zone_name == "apothicon_interior_zone") {
            var_e01c8f74 = 0;
            continue;
          }
          var_225b5e15 = 0;
        }
      }
    }
    var_9626d5b6 = 0;
    if(self.zone_name == "apothicon_interior_zone") {
      var_9626d5b6 = 1;
    }
    if(var_225b5e15 && !var_9626d5b6 || (var_e01c8f74 && var_9626d5b6)) {
      break;
    }
    wait(0.5);
  }
  self thread function_17da3db2();
}

function function_17da3db2() {
  wait(0.05);
  if(isDefined(self)) {
    self delete();
  }
  wait(1.1);
  level thread zm_genesis_round_bosses::spawn_boss("mechz");
}

function function_a2a11991() {
  self endon("death");
  while(!isDefined(self.zombie_lift_override)) {
    wait(0.05);
  }
  self.zombie_lift_override = &function_2d571578;
}

function function_2a2bfc25() {
  self waittill("hash_46c1e51d");
  if(level flag::get("zombie_drop_powerups") && (!(isDefined(self.no_powerups) && self.no_powerups))) {
    a_bonus_types = array("double_points", "insta_kill", "full_ammo", "nuke");
    str_type = array::random(a_bonus_types);
    zm_powerups::specific_powerup_drop(str_type, self.origin);
  }
}

function function_f517cdd6(inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {}

function teleporttraversalmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity.is_teleporting = 1;
  entity orientmode("face angle", entity.angles[1]);
  entity animmode("normal");
  if(isDefined(entity.traversestartnode)) {
    portal_trig = entity.traversestartnode.portal_trig;
    portal_trig thread zm_genesis_portals::portal_teleport_ai(entity);
  }
}

function function_2d571578(e_player, v_attack_source, n_push_away, n_lift_height, v_lift_offset, n_lift_speed) {
  self endon("death");
  if(isDefined(self.in_gravity_trap) && self.in_gravity_trap && e_player.gravityspikes_state === 3) {
    if(isDefined(self.var_1f5fe943) && self.var_1f5fe943) {
      return;
    }
    self.var_bcecff1d = 1;
    self.var_1f5fe943 = 1;
    self dodamage(10, self.origin);
    self.var_ab0efcf6 = self.origin;
    self thread scene::play("cin_zm_dlc1_mechz_dth_deathray_01", self);
    self clientfield::set("sparky_beam_fx", 1);
    self clientfield::set("death_ray_shock_fx", 1);
    self playSound("zmb_talon_electrocute");
    n_start_time = gettime();
    n_total_time = 0;
    while(10 > n_total_time && e_player.gravityspikes_state === 3) {
      util::wait_network_frame();
      n_total_time = (gettime() - n_start_time) / 1000;
    }
    self scene::stop("cin_zm_dlc1_mechz_dth_deathray_01");
    self thread function_a0b6d6b9(self);
    self clientfield::set("sparky_beam_fx", 0);
    self clientfield::set("death_ray_shock_fx", 0);
    self.var_bcecff1d = undefined;
    while(e_player.gravityspikes_state === 3) {
      util::wait_network_frame();
    }
    self.var_1f5fe943 = undefined;
    self.in_gravity_trap = undefined;
  } else {
    self dodamage(10, self.origin);
    if(!(isDefined(self.stun) && self.stun)) {
      self.stun = 1;
    }
  }
}

function function_a0b6d6b9(mechz) {
  mechz endon("death");
  if(isDefined(mechz)) {
    mechz scene::play("cin_zm_dlc1_mechz_dth_deathray_02", mechz);
  }
  if(isDefined(mechz) && isalive(mechz) && isDefined(mechz.var_ab0efcf6)) {
    v_eye_pos = mechz gettagorigin("tag_eye");
    recordline(mechz.origin, v_eye_pos, vectorscale((0, 1, 0), 255), "", mechz);
    trace = bulletTrace(v_eye_pos, mechz.origin, 0, mechz);
    if(trace["position"] !== mechz.origin) {
      point = getclosestpointonnavmesh(trace["position"], 64, 30);
      if(!isDefined(point)) {
        point = mechz.var_ab0efcf6;
      }
      mechz forceteleport(point);
    }
  }
}

function function_5f2149bb(inflictor, attacker) {
  var_3bb42832 = level.mechz_health;
  n_damage = (var_3bb42832 * 0.25) / 0.2;
  self dodamage(n_damage, self getcentroid(), inflictor, attacker, undefined, "MOD_PROJECTILE_SPLASH", 0, getweapon("none"));
}

function private function_1df1ec14() {
  if(self zm_ai_mechz::function_58655f2a()) {
    self.stun = 1;
    return true;
  }
  return false;
}

function private function_40ef38f8() {
  traversal = self.traversal;
  speedboost = 0;
  if(traversal.abslengthtoend > 200) {
    speedboost = 48;
  } else {
    if(traversal.abslengthtoend > 120) {
      speedboost = 24;
    } else if(traversal.abslengthtoend > 80 || traversal.absheighttoend > 80) {
      speedboost = 12;
    }
  }
  return speedboost;
}

function mechz_damage_override(attacker, damage) {
  if(isDefined(attacker.var_bbd3efb8)) {
    damage = damage * attacker.var_bbd3efb8;
  }
  return damage;
}

function private function_1faf1646() {
  self.candamage = 0;
  self.isfrozen = 1;
  self ghost();
  self notsolid();
  self pathmode("dont move");
}

function private function_ee090a93() {
  self.isfrozen = 0;
  self show();
  self solid();
  wait(0.5);
  self pathmode("move allowed");
  self.candamage = 1;
}

function function_78e44cda() {
  wait(0.05);
  level waittill("start_zombie_round_logic");
  wait(0.05);
  setDvar("", 0);
  adddebugcommand("");
  while(true) {
    if(getdvarint("")) {
      setDvar("", 0);
      level thread function_eac1444a();
    }
    wait(0.5);
  }
}

function function_eac1444a() {
  var_10b176f0 = getaiarchetypearray("");
  foreach(ai_mechz in var_10b176f0) {
    var_efe3c52f = level.activeplayers[0] gettagorigin("") + vectorscale((0, 0, 1), 20);
    var_7ddc55f4 = level.activeplayers[0] gettagorigin("") + (5, 0, 20);
    var_a3ded05d = level.activeplayers[0] gettagorigin("") + (-5, 0, 20);
    var_31d76122 = level.activeplayers[0] gettagorigin("") + vectorscale((0, 0, 1), 15);
    magicbullet(level.var_e106fba5, var_efe3c52f, ai_mechz getcentroid(), level.activeplayers[0]);
    magicbullet(level.var_791ba87b, var_7ddc55f4, ai_mechz getcentroid(), level.activeplayers[0]);
    magicbullet(level.var_5d4538da, var_a3ded05d, ai_mechz getcentroid(), level.activeplayers[0]);
    magicbullet(level.var_30611368, var_31d76122, ai_mechz getcentroid(), level.activeplayers[0]);
  }
}

function function_22cf3e9f(str_weapon_name, v_source, ai_mechz) {
  magicbullet(level.var_791ba87b, v_source, ai_mechz getcentroid(), level.activeplayers[0]);
}