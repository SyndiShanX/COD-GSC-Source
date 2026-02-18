/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_35b8a6927c851193.gsc
***********************************************/

#using script_1940fc077a028a81;
#using script_2c5daa95f8fec03c;
#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using script_3751b21462a54a7d;
#using script_3a88f428c6d8ef90;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\globallogic\globallogic_vehicle;
#using scripts\core_common\math_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_behavior;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#namespace namespace_98decc78;

function private autoexec __init__system__() {
  system::register(#"hash_5cb28995c23c44a", &preinit, &main, undefined, undefined);
}

function private preinit() {
  gametype = util::get_game_type();

  if(gametype == # "zsurvival") {
    level.var_9ee73630 = [];
    level.var_9ee73630[# "walk"] = [];
    level.var_9ee73630[# "run"] = [];
    level.var_9ee73630[# "sprint"] = [];
    level.var_9ee73630[# "super_sprint"] = [];
    level.var_9ee73630[# "walk"][# "down"] = 14;
    level.var_9ee73630[# "walk"][# "up"] = 16;
    level.var_9ee73630[# "run"][# "down"] = 13;
    level.var_9ee73630[# "run"][# "up"] = 12;
    level.var_9ee73630[# "sprint"][# "down"] = 9;
    level.var_9ee73630[# "sprint"][# "up"] = 8;
    level.var_9ee73630[# "super_sprint"][# "down"] = 1;
    level.var_9ee73630[# "super_sprint"][# "up"] = 1;
    level.var_9ee73630[# "super_super_sprint"][# "down"] = 8;
    level.var_9ee73630[# "super_super_sprint"][# "up"] = 8;
    spawner::add_archetype_spawn_function(#"zombie", &function_42151b1b);
    spawner::add_archetype_spawn_function(#"zombie", &function_1bc8ecf1);
    spawner::function_89a2cd87(#"zombie", &function_95d1bec9);
  }

  clientfield::register("toplayer", "" + # "hash_3a86c740229275b7", 1, 3, "counter");
  initzombiebehaviors();
}

function private main() {
  level.custom_melee_fire = &namespace_85745671::custom_melee_fire;

  if(isDefined(getgametypesetting(#"hash_4ac1f31d592e3f3d")) ? getgametypesetting(#"hash_4ac1f31d592e3f3d") : 0) {
    callback::add_callback(#"hash_70eeb7d813f149b2", &namespace_85745671::function_cf065988);
    callback::add_callback(#"hash_15858698313c5f32", &namespace_85745671::function_b0503d98);
    turretweapon = getweapon(#"gun_ultimate_turret");

    if(isDefined(turretweapon)) {
      turretweapon = turretweapon.rootweapon;
    }

    if(isDefined(turretweapon) && !isinarray(level.var_7fc48a1a, turretweapon)) {
      level.var_7fc48a1a[level.var_7fc48a1a.size] = turretweapon;
    }

    if(isDefined(level.smartcoversettings) && !isinarray(level.var_7fc48a1a, level.smartcoversettings.smartcoverweapon)) {
      level.var_7fc48a1a[level.var_7fc48a1a.size] = level.smartcoversettings.smartcoverweapon;
    }
  }
}

function initzombiebehaviors() {
  assert(isscriptfunctionptr(&function_197fdaee));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2e71bc334e0009ba", &function_197fdaee);
  assert(isscriptfunctionptr(&function_20a45305));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_37d4dfdcc2dcf48b", &function_20a45305);
  assert(isscriptfunctionptr(&function_c142ffd7));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_40014132d9127d48", &function_c142ffd7);
  animationstatenetwork::registernotetrackhandlerfunction("show_projectile", &function_a7d522bd);
  animationstatenetwork::registernotetrackhandlerfunction("fire_projectile", &function_f45f4725);
}

function private function_42151b1b() {
  self.ai.var_870d0893 = 1;
  self callback::function_d8abfc3d(#"on_ai_damage", &zombie_gib_on_damage);
  self callback::function_d8abfc3d(#"on_ai_melee", &namespace_85745671::zombie_on_melee);
  self callback::function_d8abfc3d(#"hash_3bb51ce51020d0eb", &namespace_85745671::function_16e2f075);
  self callback::function_d8abfc3d(#"on_ai_killed", &function_bf21203e);
  aiutility::addaioverridedamagecallback(self, &function_853cd0f0);
  self.ai.var_a5dabb8b = 1;
  self.var_65e57a10 = 1;
  self.ignorepathenemyfightdist = 1;
  self.var_1c0eb62a = 180;
  self.var_737e8510 = 64;
  self.var_b8c61fc5 = 1;
  self.var_20e07206 = 1;
  self.var_16dd87ad = 0.1;
  self.var_90d0c0ff = "anim_spawn_from_ground";
  self.clamptonavmesh = 1;
  self.var_958e7ee4 = 10;
  self.var_eb3258b = 15;
  self.completed_emerging_into_playable_area = 1;
  self.zombie_think_done = 1;
  self.var_28621cf4 = "j_neck";
  self.var_e5365d8a = (0, 0, 6);
  self.var_cbc65493 = 0.25;
  self setavoidancemask("avoid actor");
  self namespace_85745671::function_9758722("walk");
  self thread namespace_85745671::function_6c308e81();
  self callback::function_d8abfc3d(#"hash_10ab46b52df7967a", &namespace_85745671::function_5cb3181e);
  self thread zombie_utility::hide_pop();
}

function function_1bc8ecf1() {
  self.var_b3c613a7 = [1, 1, 1, 1, 1];
  self.var_414bc881 = 1;
}

function private function_95d1bec9() {
  self.var_48915943 = 1;
  setup_awareness(self);
  self thread awareness::function_fa6e010d();
}

function private function_bf21203e(params) {
  if(params.smeansofdeath === "MOD_CRUSH") {
    self globallogic_vehicle::function_621234f9(params.eattacker, params.einflictor);
  }

  if(isvehicle(params.einflictor) && params.smeansofdeath === "MOD_CRUSH") {
    namespace_81245006::function_76e239dc(self, undefined);
  }

  if(!isPlayer(params.eattacker)) {
    return;
  }
}

function private function_853cd0f0(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  self.var_67f98db0 = 0;

  if(isactor(vpoint) && vpoint.team == self.team && vpoint.archetype !== # "abom") {
    return 0;
  }

  if(isDefined(damagefromunderneath) && psoffsettime !== "MOD_DOT") {
    dot_params = function_f74d2943(damagefromunderneath, 7);

    if(isDefined(dot_params)) {
      status_effect::status_effect_apply(dot_params, damagefromunderneath, var_fd90b0bb);
    }
  }

  var_3b037158 = isDefined(damagefromunderneath) && isarray(level.var_7fc48a1a) && isinarray(level.var_7fc48a1a, damagefromunderneath);

  if(var_3b037158 && isDefined(var_fd90b0bb)) {
    if(!isDefined(self.attackable) && isDefined(var_fd90b0bb.var_b79a8ac7)) {
      if(var_fd90b0bb namespace_85745671::get_attackable_slot(self)) {
        self.attackable = var_fd90b0bb;
      }
    }

    if(isDefined(var_fd90b0bb.var_d83d7db3)) {
      if(isDefined(self.var_1b3acc36) && gettime() < self.var_1b3acc36) {
        return 0;
      } else {
        self.var_1b3acc36 = gettime() + var_fd90b0bb.var_d83d7db3;
      }
    }

    vdir = isDefined(var_fd90b0bb.var_ba721a2c) ? var_fd90b0bb.var_ba721a2c : vdir;
  }

  if(!isDefined(self.enemy_override) && !isDefined(self.favoriteenemy) && isDefined(vpoint) && isPlayer(vpoint)) {
    if(isDefined(psoffsettime) && (psoffsettime == "MOD_MELEE" || psoffsettime == "MOD_MELEE_WEAPON_BUTT") || isDefined(damagefromunderneath) && damagefromunderneath.statname === # "hatchet") {
      n_radius = 128;
    } else {
      n_radius = 512;
    }

    awareness::function_e732359c(1, self.origin, n_radius, self, {
      #position: vpoint.origin
    });
  }

  if(var_fd90b0bb.classname === "script_vehicle" && psoffsettime == "MOD_CRUSH" && isDefined(self.var_5ace757d)) {
    foreach(bundle in self.var_5ace757d) {
      foreach(hitloc in bundle.hitlocs) {
        modelindex = hitloc;

        if(isDefined(self.var_318a0ac8)) {
          self[[self.var_318a0ac8]](var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, undefined, undefined, modelindex, partname);
        }
      }
    }
  }

  if(is_true(level.var_85a39c96)) {
    vdir = self.health + 1;
  }

  return vdir;
}

function private zombie_gib_on_damage(params) {
  zombie_utility::zombie_gib(params.idamage, params.eattacker, params.vdir, params.vpoint, params.smeansofdeath, undefined, undefined, undefined, params.weapon);
}

function private function_197fdaee(entity) {
  if(entity asmgetstatus() != "asm_status_complete" && isDefined(entity.projectile_model) && isDefined(entity.var_1087b4ab) && entity isattached(entity.projectile_model, entity.var_1087b4ab)) {
    entity detach(entity.projectile_model, entity.var_1087b4ab);
    entity.var_1087b4ab = undefined;
    entity.projectile_model = undefined;
  }

  entity.var_205ab08b = undefined;
}

function private function_20a45305(entity) {
  entity.var_205ab08b = 1;
}

function private function_c142ffd7(entity) {
  entity.var_205ab08b = 1;
}

function private function_a7d522bd(entity) {
  model = array::random(array("c_t9_gore_chunk_03", "c_t9_gore_chunk_03_a", "c_t9_gore_chunk_03_b", "c_t9_gore_chunk_03_c", "c_t9_gore_chunk_03_d"));
  entity.projectile_model = model;
  entity.var_1087b4ab = "tag_weapon_left";

  if(!entity haspart(entity.var_1087b4ab)) {
    entity.var_1087b4ab = "j_indexbase_le";
  }

  if(gibserverutils::isgibbed(self, 32) || is_true(entity.missinglegs)) {
    entity.var_1087b4ab = "tag_weapon_right";

    if(!entity haspart(entity.var_1087b4ab)) {
      entity.var_1087b4ab = "j_indexbase_ri";
    }
  }

  if(entity isattached(entity.projectile_model, entity.var_1087b4ab)) {
    entity detach(entity.projectile_model, entity.var_1087b4ab);
  }

  entity attach(entity.projectile_model, entity.var_1087b4ab);
}

function function_be5f206(start_pos, target_pos, var_22041b45) {
  if(!isPlayer(self) || !self isinvehicle()) {
    return undefined;
  }

  vehicle = self getvehicleoccupied();
  velocity = vehicle getvelocity();
  var_8a263da1 = vectornormalize(velocity);
  var_1e74aaf8 = length(velocity);
  var_e42cca13 = var_1e74aaf8;
  velocity = var_8a263da1 * var_e42cca13;

  if(velocity !== (0, 0, 0)) {
    predicted_pos = target_pos + velocity * var_22041b45;
    to_target = predicted_pos - start_pos;
    time = length((to_target[0], to_target[1], 0)) / 700;
    time = min(time, var_22041b45);
    predicted_pos = target_pos + velocity * time;
    return predicted_pos;
  }
}

function private function_f45f4725(entity) {
  if(isDefined(entity.var_1087b4ab) && isDefined(entity.projectile_model)) {
    entity detach(entity.projectile_model, entity.var_1087b4ab);
  }

  if(isDefined(entity.var_1087b4ab) && namespace_85745671::is_player_valid(entity.enemy) && entity haspart(entity.var_1087b4ab) && entity.enemy haspart("j_spine4")) {
    start_pos = entity gettagorigin(entity.var_1087b4ab);
    target_pos = entity.enemy gettagorigin("j_spine4");

    if(isDefined(level.var_83869c31)) {
      target_pos = [[level.var_83869c31]](entity, entity.enemy, target_pos);
    }

    to_target = target_pos - start_pos;
    time = length((to_target[0], to_target[1], 0)) / 700;
    var_64b12059 = entity.enemy function_be5f206(start_pos, target_pos, time);

    if(isDefined(var_64b12059)) {
      if(getdvarint(#"hash_1e6f0ddc05647984", 0)) {
        recordline(target_pos, var_64b12059, (1, 0, 0));
        debugstar(var_64b12059, 100, (0, 0, 1));
      }

      if(var_64b12059 !== start_pos) {
        to_target = var_64b12059 - start_pos;
        time = length((to_target[0], to_target[1], 0)) / 700;
      }
    }

    launch_speed = (0.5 * getdvarfloat(#"bg_lowgravity", 400) * sqr(time) + to_target[2]) / time;
    to_target = vectornormalize((to_target[0], to_target[1], 0));
    grenade = entity magicgrenademanual(start_pos, (to_target[0] * 700, to_target[1] * 700, launch_speed), 6);
    grenade.angles = entity gettagangles(entity.var_1087b4ab);
    grenade thread function_6f78caa9();

    if(isDefined(entity.projectile_model)) {
      grenade setModel(entity.projectile_model);
    }

    entity.zombie_projectile = grenade;
    entity.var_42ecd9f3 = gettime() + int(1.5 * 1000);
  }

  entity.projectile_model = undefined;
  entity.var_1087b4ab = undefined;
  entity.var_8c4d3e5d = undefined;
}

function private function_6f78caa9() {
  if(isDefined(self.owner)) {
    attacker = self.owner;
    start_pos = self.owner.origin;
  }

  waitresult = self waittilltimeout(5, #"projectile_impact_player", #"death");

  if(waitresult._notify == # "projectile_impact_player" && isDefined(waitresult.player)) {
    player = waitresult.player;
    player playSound(#"hash_7531b73b4b99b19d");
    player dodamage(self.weapon.damagevalues[0], start_pos, attacker, self);
    var_622f0175 = player.origin - self.origin;
    var_f1ff3ca1 = vectornormalize((var_622f0175[0], var_622f0175[1], 0));
    player_forward = anglesToForward(player.angles);
    var_d885fce5 = vectornormalize((player_forward[0], player_forward[1], 0));
    player_right = anglestoright(player.angles);
    var_f39d8ba7 = vectornormalize((player_right[0], player_right[1], 0));
    dot = vectordot(var_f1ff3ca1, var_d885fce5);

    if(dot >= 0.5) {
      direction = 1;
    } else if(dot < 0.5 && dot > -0.5) {
      dot = vectordot(var_f1ff3ca1, var_f39d8ba7);

      if(dot > 0) {
        direction = 3;
      } else {
        direction = 4;
      }
    } else {
      direction = 2;
    }

    player clientfield::increment_to_player(isDefined(attacker.var_22492afd) ? attacker.var_22492afd : "" + # "hash_3a86c740229275b7", direction);
  } else if(isDefined(self)) {
    vehicles = getentitiesinradius(self.origin, 1, 12);

    foreach(vehicle in vehicles) {
      if(isvehicle(vehicle) && namespace_85745671::function_7243fef2(vehicle)) {
        vehicle dodamage(self.weapon.damagevalues[0] * 2, start_pos, attacker, self);
      }
    }
  }

  if(isDefined(self)) {
    self deletedelay();
  }
}

function private setup_awareness(entity) {
  if(is_true(entity.ai.var_870d0893)) {
    entity.has_awareness = 1;
    entity.ignorelaststandplayers = 1;
    entity callback::function_d8abfc3d(#"on_ai_damage", &awareness::function_5f511313);
    awareness::register_state(entity, #"wander", &function_962ec972, &function_2e07b113, &awareness::function_b264a0bc, undefined, &awareness::function_555d960b);
    awareness::register_state(entity, #"investigate", &function_18cf0569, &function_a5b3ad4c, &function_60856c6d, undefined, &awareness::function_a360dd00);
    awareness::register_state(entity, #"chase", &function_88586098, &function_e85f22b3, &function_5b3d00f3, &awareness::function_5c40e824, &function_1ae9512e);
    awareness::set_state(entity, #"wander");
    return;
  }

  entity.has_awareness = 0;
}

function function_962ec972(entity) {
  entity.fovcosine = 0.5;
  entity.maxsightdistsqrd = sqr(900);
  entity namespace_85745671::function_9758722("walk");
  entity.var_1267fdea = 0;
  awareness::function_9c9d96b5(entity);
}

function function_2e07b113(entity) {
  if(is_true(entity.interdimensional_gun_kill)) {
    awareness::set_state(entity, #"chase");
    return;
  }

  awareness::function_4ebe4a6d(entity);
}

function function_18cf0569(entity) {
  self.fovcosine = 0;
  self.maxsightdistsqrd = sqr(1100);
  self.var_1267fdea = 0;
  entity namespace_85745671::function_9758722("run");
  awareness::function_b41f0471(entity);
}

function function_a5b3ad4c(entity) {
  if(is_true(entity.interdimensional_gun_kill)) {
    awareness::set_state(entity, #"chase");
    return;
  }

  awareness::function_9eefc327(entity);
}

function function_60856c6d(entity) {
  awareness::function_34162a25(entity);
}

function function_88586098(entity) {
  self.fovcosine = 0;
  self.maxsightdistsqrd = sqr(3000);
  self.var_1267fdea = 0;

  if(isDefined(self.aat_turned)) {} else if(isDefined(self.var_9602c8b2)) {
    [[self.var_9602c8b2]]();
  } else if(isDefined(level.var_9602c8b2)) {
    [[level.var_9602c8b2]]();
  } else {
    n_random = randomint(100);

    if(n_random < 33 || is_true(self.var_4a44f930)) {
      entity namespace_85745671::function_9758722("sprint");
    } else {
      entity namespace_85745671::function_9758722("super_sprint");
    }
  }

  awareness::function_978025e4(entity);
}

function function_e85f22b3(entity) {
  if(isDefined(entity.enemy) && distancesquared(entity.enemy.origin, entity.origin) < entity.maxsightdistsqrd) {
    zm_behavior::function_483766be(entity);
  }

  if(is_true(entity.interdimensional_gun_kill) && isDefined(entity.damageorigin)) {
    entity setgoal(entity.damageorigin);
    return;
  }

  awareness::function_39da6c3c(entity);
}

function function_5b3d00f3(entity) {
  self.var_6ca50f69 = undefined;
  awareness::function_b9f81e8b(entity);
}

function function_1ae9512e(entity) {
  if(is_true(entity.var_1fa24724)) {
    record3dtext("<dev string:x38>", entity.origin, (1, 0.5, 0), "<dev string:x51>", entity);
  }
}