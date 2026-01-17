/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_genesis_keeper.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\aat_shared;
#using scripts\shared\ai\archetype_locomotion_utility;
#using scripts\shared\ai\archetype_mocomps_utility;
#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\systems\ai_blackboard;
#using scripts\shared\ai\systems\ai_interface;
#using scripts\shared\ai\systems\animation_state_machine_mocomp;
#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\systems\debug;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie;
#using scripts\shared\ai\zombie_death;
#using scripts\shared\ai\zombie_shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_behavior;
#using scripts\zm\_zm_devgui;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\zm_genesis_portals;
#namespace zm_genesis_keeper;

function autoexec __init__sytem__() {
  system::register("zm_genesis_keeper", &__init__, undefined, undefined);
}

function __init__() {
  function_cf48298e();
  if(ai::shouldregisterclientfieldforarchetype("keeper")) {
    clientfield::register("actor", "keeper_death", 15000, 2, "int");
  }
  adddebugcommand("");
  thread function_85d4833b();
}

function private function_cf48298e() {
  behaviortreenetworkutility::registerbehaviortreescriptapi("genesisKeeperDeathStart", &function_9d655978);
}

function function_9d655978(entity) {
  if(entity.model == "c_zom_dlc4_keeper_hooded_body") {
    entity setModel("c_zom_dlc4_keeper_hooded_dissolve");
  } else {
    entity setModel("c_zom_dlc4_keeper_dissolve");
  }
  entity clientfield::set("keeper_death", 2);
  entity notsolid();
}

function function_f8c7a969(inflictor, attacker, damage, meansofdeath, weapon, dir, hitloc, offsettimes) {
  self clientfield::set("keeper_death", 1);
  self notsolid();
  return damage;
}

function function_51dd865c() {
  spawner::add_archetype_spawn_function("keeper", &function_cb6b3469);
  spawner::add_archetype_spawn_function("keeper", &function_6ded398b);
  spawner::add_archetype_spawn_function("keeper", &function_e5e94978);
  spawner::add_archetype_spawn_function("keeper", &function_1dcdd145);
  level thread aat::register_immunity("zm_aat_turned", "keeper", 1, 1, 1);
}

function private function_85d4833b() {
  level flagsys::wait_till("start_zombie_round_logic");
  zm_devgui::add_custom_devgui_callback(&function_e361808);
}

function keeper_death() {
  self waittill("death", e_attacker);
  if(isDefined(e_attacker) && isDefined(e_attacker.var_4d307aef)) {
    e_attacker.var_4d307aef++;
  }
  if(isDefined(e_attacker) && isDefined(e_attacker.var_8b5008fe)) {
    e_attacker.var_8b5008fe++;
  }
}

function private function_e361808(cmd) {
  switch (cmd) {
    case "genesis_keeper_spawn": {
      queryresult = positionquery_source_navigation(level.players[0].origin, 128, 256, 128, 20);
      if(isDefined(queryresult) && queryresult.data.size > 0) {
        origin = queryresult.data[0].origin;
        angles = level.players[0].angles;
        entity = spawnactor("spawner_zm_genesis_keeper", origin, level.players[0].angles, undefined, 1, 1);
        if(isDefined(entity)) {
          entity thread function_dfdf3fc1();
        }
      }
      break;
    }
  }
}

function private function_dfdf3fc1() {
  self endon("death");
  self.spawn_time = gettime();
  self thread keeper_death();
  self.heroweapon_kill_power = 2;
  self.voiceprefix = "keeper";
  self.animname = "keeper";
  self thread zm_spawner::play_ambient_zombie_vocals();
  self thread zm_audio::zmbaivox_notifyconvert();
  self pushactors(1);
  wait(1);
  self.zombie_think_done = 1;
}

function function_6ded398b() {
  aiutility::addaioverridedamagecallback(self, &function_7085a2e4);
  self thread zm::update_zone_name();
  self aat::aat_cooldown_init();
  self thread zm_spawner::enemy_death_detection();
  self.completed_emerging_into_playable_area = 1;
  self.is_zombie = 1;
}

function function_e5e94978() {
  self endon("death");
  while(isalive(self)) {
    self waittill("damage");
    if(isplayer(self.attacker)) {
      if(zm_spawner::player_using_hi_score_weapon(self.attacker)) {
        str_notify = "damage";
      } else {
        str_notify = "damage_light";
      }
      if(!(isDefined(self.deathpoints_already_given) && self.deathpoints_already_given)) {
        self.attacker zm_score::player_add_points(str_notify, self.damagemod, self.damagelocation, undefined, self.team, self.damageweapon);
      }
      if(isDefined(level.hero_power_update)) {
        [[level.hero_power_update]](self.attacker, self);
      }
      self.attacker.use_weapon_type = self.damagemod;
      self thread zm_powerups::check_for_instakill(self.attacker, self.damagemod, self.damagelocation);
    }
    util::wait_network_frame();
  }
}

function function_1dcdd145() {
  self waittill("death");
  self zm_spawner::check_zombie_death_event_callbacks(self.attacker);
  if(isplayer(self.attacker)) {
    if(!(isDefined(self.deathpoints_already_given) && self.deathpoints_already_given)) {
      self.attacker zm_score::player_add_points("death", self.damagemod, self.damagelocation, undefined, self.team, self.damageweapon);
    }
    if(isDefined(level.hero_power_update)) {
      [
        [level.hero_power_update]
      ](self.attacker, self);
    }
  }
}

function function_7085a2e4(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex) {
  if(isplayer(eattacker) && (isDefined(eattacker.var_74fe492b) && eattacker.var_74fe492b)) {
    idamage = int(idamage * 1.33);
  }
  if(isplayer(eattacker) && (isDefined(eattacker.var_e8e8daad) && eattacker.var_e8e8daad)) {
    idamage = int(idamage * 1.5);
  }
  return idamage;
}

function bb_getarmsposition() {
  if(isDefined(self.zombie_arms_position)) {
    if(self.zombie_arms_position == "up") {
      return "arms_up";
    }
    return "arms_down";
  }
  return "arms_up";
}

function bb_getlocomotionspeedtype() {
  if(isDefined(self.zombie_move_speed)) {
    if(self.zombie_move_speed == "walk") {
      return "locomotion_speed_walk";
    }
    if(self.zombie_move_speed == "run") {
      return "locomotion_speed_run";
    }
    if(self.zombie_move_speed == "sprint") {
      return "locomotion_speed_sprint";
    }
    if(self.zombie_move_speed == "super_sprint") {
      return "locomotion_speed_super_sprint";
    }
  }
  return "locomotion_speed_walk";
}

function bb_getvarianttype() {
  if(isDefined(self.variant_type)) {
    return self.variant_type;
  }
  return 0;
}

function bb_gethaslegsstatus() {
  if(self.missinglegs) {
    return "has_legs_no";
  }
  return "has_legs_yes";
}

function bb_getshouldturn() {
  if(isDefined(self.should_turn) && self.should_turn) {
    return "should_turn";
  }
  return "should_not_turn";
}

function bb_idgungetdamagedirection() {
  if(isDefined(self.damage_direction)) {
    return self.damage_direction;
  }
  return self aiutility::bb_getdamagedirection();
}

function bb_getlowgravityvariant() {
  if(isDefined(self.low_gravity_variant)) {
    return self.low_gravity_variant;
  }
  return 0;
}

function function_cb6b3469() {
  blackboard::createblackboardforentity(self);
  self aiutility::registerutilityblackboardattributes();
  ai::createinterfaceforentity(self);
  blackboard::registerblackboardattribute(self, "_arms_position", "arms_up", &bb_getarmsposition);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_locomotion_speed", "locomotion_speed_walk", &bb_getlocomotionspeedtype);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_has_legs", "has_legs_yes", &bb_gethaslegsstatus);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_variant_type", 0, &bb_getvarianttype);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_which_board_pull", undefined, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_board_attack_spot", undefined, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_grapple_direction", undefined, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_locomotion_should_turn", "should_not_turn", &bb_getshouldturn);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_idgun_damage_direction", "back", &bb_idgungetdamagedirection);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_low_gravity_variant", 0, &bb_getlowgravityvariant);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_knockdown_direction", undefined, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_knockdown_type", undefined, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  self.___archetypeonanimscriptedcallback = &archetypezombieonanimscriptedcallback;
  self finalizetrackedblackboardattributes();
}

function private archetypezombieonanimscriptedcallback(entity) {
  entity.__blackboard = undefined;
  entity function_cb6b3469();
}