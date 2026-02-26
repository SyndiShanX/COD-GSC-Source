/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\zombie.gsc
***********************************************/

#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\archetype_locomotion_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\archetype_zombie_interface;
#using scripts\core_common\ai\systems\ai_blackboard;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\util_shared;
#namespace zombiebehavior;

function autoexec init() {
  initzombiebehaviorsandasm();
  spawner::add_archetype_spawn_function(#"zombie", &archetypezombieblackboardinit);
  spawner::add_archetype_spawn_function(#"zombie", &zombie_utility::zombiespawnsetup);
  spawner::add_archetype_spawn_function(#"zombie", &archetypezombiedeathoverrideinit);
  spawner::add_archetype_spawn_function(#"zombie", &function_eb55349f);
  spawner::function_89a2cd87(#"zombie", &function_9668f61f);

  spawner::add_archetype_spawn_function(#"zombie", &zombie_utility::updateanimationrate);

  clientfield::register("actor", "zombie", 1, 1, "int");
  clientfield::register("actor", "pustule_pulse_cf", 1, 2, "int");
  clientfield::register("actor", "stunned_head_fx", 1, 1, "int");
  zombieinterface::registerzombieinterfaceattributes();
}

function private initzombiebehaviorsandasm() {
  assert(!isDefined(&zombiemoveactionstart) || isscriptfunctionptr(&zombiemoveactionstart));
  assert(!isDefined(&zombiemoveactionupdate) || isscriptfunctionptr(&zombiemoveactionupdate));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  behaviortreenetworkutility::registerbehaviortreeaction(#"zombiemoveaction", &zombiemoveactionstart, &zombiemoveactionupdate, undefined);
  assert(!isDefined(&function_9b6830c9) || isscriptfunctionptr(&function_9b6830c9));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&function_fbdc2cc4) || isscriptfunctionptr(&function_fbdc2cc4));
  behaviortreenetworkutility::registerbehaviortreeaction(#"zombiemeleeaction", &function_9b6830c9, undefined, &function_fbdc2cc4);
  assert(isscriptfunctionptr(&zombietargetservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombietargetservice", &zombietargetservice);
  assert(isscriptfunctionptr(&zombiecrawlercollision));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiecrawlercollisionservice", &zombiecrawlercollision);
  assert(isscriptfunctionptr(&zombietraversalservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombietraversalservice", &zombietraversalservice);
  assert(isscriptfunctionptr(&zombieisatattackobject));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieisatattackobject", &zombieisatattackobject);
  assert(isscriptfunctionptr(&zombieshouldattackobject));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldattackobject", &zombieshouldattackobject);
  assert(isscriptfunctionptr(&zombieshouldmeleecondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldmelee", &zombieshouldmeleecondition);
  assert(isscriptfunctionptr(&zombieshouldjumpmeleecondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldjumpmelee", &zombieshouldjumpmeleecondition);
  assert(isscriptfunctionptr(&zombieshouldjumpunderwatermelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldjumpunderwatermelee", &zombieshouldjumpunderwatermelee);
  assert(isscriptfunctionptr(&zombiegiblegscondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiegiblegscondition", &zombiegiblegscondition);
  assert(isscriptfunctionptr(&zombieshoulddisplaypain));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshoulddisplaypain", &zombieshoulddisplaypain);
  assert(isscriptfunctionptr(&iszombiewalking));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"iszombiewalking", &iszombiewalking);
  assert(isscriptfunctionptr(&zombieshouldmovelowg));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldmovelowg", &zombieshouldmovelowg);
  assert(isscriptfunctionptr(&zombieshouldturn));
  behaviorstatemachine::registerbsmscriptapiinternal(#"zombieshouldturn", &zombieshouldturn);
  assert(isscriptfunctionptr(&function_a716a3af));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_4ba5bc2aba9e7670", &function_a716a3af);
  assert(isscriptfunctionptr(&function_ce53cb2e));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_27d8ceabf090b1aa", &function_ce53cb2e);
  assert(isscriptfunctionptr(&function_30373e53));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2d1a9c2809fc0d28", &function_30373e53);
  assert(isscriptfunctionptr(&function_1b8c9407));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4136381d29600bc", &function_1b8c9407);
  assert(isscriptfunctionptr(&function_ecba5a44));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1732367c7f780c76", &function_ecba5a44);
  assert(isscriptfunctionptr(&function_97aec83a));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7e8590f0e7d32865", &function_97aec83a);
  assert(isscriptfunctionptr(&function_eb4b29ab));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_781acbf9eb317aa9", &function_eb4b29ab);
  assert(isscriptfunctionptr(&zombieshouldmeleesuicide));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldmeleesuicide", &zombieshouldmeleesuicide);
  assert(isscriptfunctionptr(&zombiemeleesuicidestart));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiemeleesuicidestart", &zombiemeleesuicidestart);
  assert(isscriptfunctionptr(&zombiemeleesuicideupdate));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiemeleesuicideupdate", &zombiemeleesuicideupdate);
  assert(isscriptfunctionptr(&zombiemeleesuicideterminate));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiemeleesuicideterminate", &zombiemeleesuicideterminate);
  assert(isscriptfunctionptr(&zombieshouldjukecondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldjuke", &zombieshouldjukecondition);
  assert(isscriptfunctionptr(&zombiejukeactionstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiejukeactionstart", &zombiejukeactionstart);
  assert(isscriptfunctionptr(&zombiejukeactionterminate));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiejukeactionterminate", &zombiejukeactionterminate);
  assert(isscriptfunctionptr(&zombiedeathaction));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiedeathaction", &zombiedeathaction);
  assert(isscriptfunctionptr(&zombiejuke));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiejukeservice", &zombiejuke);
  assert(isscriptfunctionptr(&zombiestumble));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiestumbleservice", &zombiestumble);
  assert(isscriptfunctionptr(&zombieshouldstumblecondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiestumblecondition", &zombieshouldstumblecondition);
  assert(isscriptfunctionptr(&zombiestumbleactionstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiestumbleactionstart", &zombiestumbleactionstart);
  assert(isscriptfunctionptr(&zombieattackobjectstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieattackobjectstart", &zombieattackobjectstart);
  assert(isscriptfunctionptr(&zombieattackobjectterminate));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieattackobjectterminate", &zombieattackobjectterminate);
  assert(isscriptfunctionptr(&waskilledbyinterdimensionalguncondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"waskilledbyinterdimensionalgun", &waskilledbyinterdimensionalguncondition);
  assert(isscriptfunctionptr(&wascrushedbyinterdimensionalgunblackholecondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"wascrushedbyinterdimensionalgunblackhole", &wascrushedbyinterdimensionalgunblackholecondition);
  assert(isscriptfunctionptr(&zombieidgundeathupdate));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieidgundeathupdate", &zombieidgundeathupdate);
  assert(isscriptfunctionptr(&zombieidgundeathupdate));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombievortexpullupdate", &zombieidgundeathupdate);
  assert(isscriptfunctionptr(&zombiehaslegs));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiehaslegs", &zombiehaslegs);
  assert(isscriptfunctionptr(&zombieshouldproceduraltraverse));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldproceduraltraverse", &zombieshouldproceduraltraverse);
  assert(isscriptfunctionptr(&zombiemissinglegs));
  behaviorstatemachine::registerbsmscriptapiinternal(#"zombiemissinglegs", &zombiemissinglegs);
  assert(isscriptfunctionptr(&function_f937377));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_31cc70f275702cf6", &function_f937377);
  assert(isscriptfunctionptr(&function_a82068d7));
  behaviorstatemachine::registerbsmscriptapiinternal(#"zombiemoveactionstart", &function_a82068d7);
  assert(isscriptfunctionptr(&function_626edd6b));
  behaviorstatemachine::registerbsmscriptapiinternal(#"zombiemoveactionupdate", &function_626edd6b);
  assert(isscriptfunctionptr(&function_71f7975f));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5544244cbada6a61", &function_71f7975f);
  animationstatenetwork::registernotetrackhandlerfunction("explode", &function_85a1a8d4);
  animationstatenetwork::registernotetrackhandlerfunction("zombie_melee", &zombienotetrackmeleefire);
  animationstatenetwork::registernotetrackhandlerfunction("crushed", &zombienotetrackcrushfire);
  animationstatenetwork::registeranimationmocomp("mocomp_death_idgun@zombie", &zombieidgundeathmocompstart, undefined, undefined);
  animationstatenetwork::registeranimationmocomp("mocomp_vortex_pull@zombie", &zombieidgundeathmocompstart, undefined, undefined);
  animationstatenetwork::registeranimationmocomp("mocomp_death_idgun_hole@zombie", &zombieidgunholedeathmocompstart, undefined, &zombieidgunholedeathmocompterminate);
  animationstatenetwork::registeranimationmocomp("mocomp_turn@zombie", &zombieturnmocompstart, &zombieturnmocompupdate, &zombieturnmocompterminate);
  animationstatenetwork::registeranimationmocomp("mocomp_melee_jump@zombie", &zombiemeleejumpmocompstart, &zombiemeleejumpmocompupdate, &zombiemeleejumpmocompterminate);
  animationstatenetwork::registeranimationmocomp("mocomp_zombie_idle@zombie", &zombiezombieidlemocompstart, undefined, undefined);
  animationstatenetwork::registeranimationmocomp("mocomp_attack_object@zombie", &zombieattackobjectmocompstart, &zombieattackobjectmocompupdate, undefined);
  animationstatenetwork::registeranimationmocomp("mocomp_teleport_traversal@zombie", &function_cbbae5cb, undefined, undefined);
  animationstatenetwork::registeranimationmocomp("mocomp_zombie_melee@zombie", &function_54d75299, &function_d1474842, &function_b6d297bb);
}

function archetypezombieblackboardinit() {
  blackboard::createblackboardforentity(self);
  ai::createinterfaceforentity(self);
  self.___archetypeonanimscriptedcallback = &archetypezombieonanimscriptedcallback;
}

function private archetypezombieonanimscriptedcallback(entity) {
  entity.__blackboard = undefined;
  entity archetypezombieblackboardinit();
}

function function_eb55349f() {
  var_1690db4a = [#"c_t9_zmb_ndu_zombie_shirtless2", #"hash_16837b6c9b7a1881", #"hash_50fdc172aee097e6", #"hash_ef041655f01ad34", #"hash_502c60e0a94ba04b"];

  if(self.model === # "c_t9_zmb_zombie_light_body2" || isDefined(self.model) && isinarray(var_1690db4a, self.model)) {
    self clientfield::set("pustule_pulse_cf", 1);
    self callback::function_d8abfc3d(#"on_ai_killed", &function_5b8201e0);
  }

  self callback::function_d8abfc3d(#"on_actor_damage", &function_f771a3f8);
  self callback::function_d8abfc3d(#"hash_7f690ab86160d4f6", &function_5d873c56);
  self callback::function_d8abfc3d(#"hash_40f6b51ae82126a4", &function_d8235fb0);
}

function function_9668f61f() {
  self.stumble = 0;
  self.var_b1c7a59d = gettime();
  self.var_eabe8c08 = gettime();
  self.var_4db55459 = 0;
  self.var_8198a38c = function_4a33fa36();
  self.var_b91eb4e5 = function_9ec512e6();
}

function function_4a33fa36() {
  if(isDefined(self.health)) {
    return (0.15 * self.health);
  }

  return 30;
}

function function_9ec512e6() {
  if(isDefined(self.health)) {
    return (0.075 * self.health);
  }

  return 15;
}

function function_5b8201e0(params) {
  self clientfield::set("pustule_pulse_cf", 0);
}

function function_5d873c56(params) {
  self clientfield::set("pustule_pulse_cf", 2);
}

function function_d8235fb0(params) {
  self clientfield::set("pustule_pulse_cf", 1);
}

function function_f771a3f8(params) {
  switch (params.smeansofdeath) {
    case # "mod_explosive":
    case # "mod_grenade":
    case # "mod_projectile":
    case # "mod_grenade_splash":
    case # "mod_projectile_splash":
      if(!is_true(params.weapon.dostun) && function_84b43711(params.weapon)) {
        self zombie_utility::setup_zombie_knockdown(params.vdamageorigin);
      }

      break;
  }

  if(isDefined(self.var_b1c7a59d) && !is_true(self.missinglegs)) {
    if(self.var_b1c7a59d < gettime()) {
      self.var_b1c7a59d = gettime() + 5000;
      self.var_4db55459 = 0;
      self.stumble = 0;
    }

    self.var_4db55459 += params.idamage;

    if(isDefined(params.shitloc)) {
      if(isinarray(array("helmet", "head", "neck"), params.shitloc)) {
        function_da30b556(self);
      } else if(isinarray(array("right_leg_upper", "left_leg_upper", "right_leg_lower", "left_leg_lower", "right_foot", "left_foot"), params.shitloc)) {
        if(self.var_4db55459 >= self.var_b91eb4e5 && self.var_eabe8c08 < gettime()) {
          function_da30b556(self);
        }
      } else if(self.var_4db55459 >= self.var_8198a38c && self.var_eabe8c08 < gettime()) {
        function_da30b556(self);
      }

      return;
    }

    if(self.var_4db55459 >= self.var_8198a38c && self.var_eabe8c08 < gettime()) {
      function_da30b556(self);
    }
  }
}

function function_84b43711(weapon) {
  if(weapon.name === # "ray_gun" || weapon.name === # "ray_gun_upgraded") {
    return false;
  }

  return true;
}

function function_da30b556(entity) {
  entity.stumble = 1;
  entity.var_b1c7a59d = gettime() + 5000;
  entity.var_eabe8c08 = gettime() + 1000;
  entity.var_4db55459 = 0;
}

function private function_ce53cb2e(entity) {
  if(entity.stumble === 1 && is_false(entity.var_67f98db0)) {
    return 1;
  }

  return 0;
}

function private function_30373e53(entity) {
  entity.stumble = 0;
  entity.var_b1c7a59d = gettime() + 5000;
  entity.var_eabe8c08 = gettime() + 1000;
  entity.var_4db55459 = 0;
}

function bb_getvarianttype() {
  if(isDefined(self.variant_type)) {
    return self.variant_type;
  }

  return 0;
}

function bb_getlowgravityvariant() {
  if(isDefined(self.low_gravity_variant)) {
    return self.low_gravity_variant;
  }

  return 0;
}

function private function_a95e9277() {
  assert(self.archetype == # "zombie");
  speed = self function_28e7d252();
  return speed;
}

function iszombiewalking(entity) {
  return !is_true(entity.missinglegs);
}

function zombieshoulddisplaypain(entity) {
  if(is_true(entity.suicidaldeath)) {
    return false;
  }

  if(!hasasm(entity) || entity function_ebbebf56() < 1) {
    return false;
  }

  return !is_true(entity.missinglegs);
}

function zombieshouldjukecondition(entity) {
  if(isDefined(entity.juke) && (entity.juke == "left" || entity.juke == "right")) {
    return true;
  }

  return false;
}

function zombieshouldstumblecondition(entity) {
  if(isDefined(entity.stumble)) {
    return true;
  }

  return false;
}

function private zombiejukeactionstart(entity) {
  entity setblackboardattribute("_juke_direction", entity.juke);

  if(isDefined(entity.jukedistance)) {
    entity setblackboardattribute("_juke_distance", entity.jukedistance);
  } else {
    entity setblackboardattribute("_juke_distance", "short");
  }

  entity.jukedistance = undefined;
  entity.juke = undefined;
}

function private zombiejukeactionterminate(entity) {
  entity clearpath();
}

function private zombiestumbleactionstart(entity) {
  entity.stumble = undefined;
}

function private zombieattackobjectstart(entity) {
  entity.is_inert = 1;
}

function private zombieattackobjectterminate(entity) {
  entity.is_inert = 0;
}

function zombiegiblegscondition(entity) {
  return gibserverutils::isgibbed(entity, 256) || gibserverutils::isgibbed(entity, 128);
}

function function_f937377(entity) {
  entity.ai.var_80045105 = gettime();
}

function zombienotetrackmeleefire(entity) {
  if(is_true(entity.marked_for_death)) {
    return;
  }

  entity.melee_cooldown = gettime() + getdvarfloat(#"scr_zombiemeleecooldown", 1) * 1000 * (isDefined(entity.var_ce2dd587) ? entity.var_ce2dd587 : 1);

  if(is_true(entity.aat_turned)) {
    if(isDefined(entity.enemy) && isalive(entity.enemy) && !isPlayer(entity.enemy)) {
      if(isDefined(entity.melee_distance_check)) {
        if(!entity[[entity.melee_distance_check]](entity.enemy)) {
          return;
        }
      }

      if(isDefined(entity.var_16d0eb06) && is_true(entity.enemy.var_6d23c054)) {
        if(isDefined(entity.var_443d78cc)) {
          e_attacker = entity.var_443d78cc;
        } else {
          e_attacker = entity;
        }

        entity.enemy dodamage(entity.var_16d0eb06, entity.origin, e_attacker, entity);

        if(!isalive(entity.enemy)) {
          gibserverutils::gibhead(entity.enemy, 0);
          entity.enemy zombie_utility::gib_random_parts();
          entity.enemy.var_7105092c = 1;
          entity.n_aat_turned_zombie_kills++;
        }
      } else if(is_true(entity.enemy.var_6d23c054) && is_true(entity.enemy.allowdeath)) {
        if(isDefined(entity.var_443d78cc)) {
          e_attacker = entity.var_443d78cc;
        } else {
          e_attacker = entity;
        }

        gibserverutils::gibhead(entity.enemy, 0);
        entity.enemy zombie_utility::gib_random_parts();
        entity.enemy.var_7105092c = 1;
        entity.enemy kill(entity.enemy.origin, e_attacker, entity, undefined, undefined, 1);
        entity.n_aat_turned_zombie_kills++;
      } else if(is_true(entity.enemy.canbetargetedbyturnedzombies)) {
        entity melee();
      }

      entity callback::callback(#"on_ai_melee");
    }

    return;
  }

  if(isDefined(entity.enemy) && is_true(entity.enemy.ignoreme) && !isDefined(entity.attackable)) {
    return;
  }

  if(isDefined(entity.ai.var_80045105)) {
    record3dtext("<dev string:x38>" + gettime() - entity.ai.var_80045105, self.origin, (1, 0, 0), "<dev string:x46>", entity);
  }

  if(isDefined(entity.custom_melee_fire)) {
    entity[[entity.custom_melee_fire]]();
  } else if(isDefined(level.custom_melee_fire)) {
    entity[[level.custom_melee_fire]]();
  } else {
    entity melee();
  }

  record3dtext("<dev string:x50>", entity.origin, (1, 0, 0), "<dev string:x46>", entity);

  if(isDefined(entity.enemy)) {
    eyepos = entity getEye();
    record3dtext("<dev string:x59>" + distance2d(eyepos, entity.enemy.origin), entity.origin, (1, 0, 0), "<dev string:x46>", entity);
  }

  if(zombieshouldattackobject(entity)) {
    if(isDefined(level.attackablecallback)) {
      entity.attackable[[level.attackablecallback]](entity);
    }
  }

  entity callback::callback(#"on_ai_melee");
}

function zombienotetrackcrushfire(entity) {
  entity delete();
}

function zombietargetservice(entity) {
  if(isDefined(entity.enablepushtime)) {
    if(gettime() >= entity.enablepushtime) {
      entity collidewithactors(1);
      entity.enablepushtime = undefined;
    }
  }

  if(is_true(entity.disabletargetservice)) {
    return 0;
  }

  if(is_true(entity.ignoreall)) {
    return 0;
  }

  specifictarget = undefined;

  if(isDefined(level.zombielevelspecifictargetcallback)) {
    specifictarget = [[level.zombielevelspecifictargetcallback]]();
  }

  if(isDefined(specifictarget)) {
    entity setgoal(specifictarget.origin);
    return;
  }

  player = zombie_utility::get_closest_valid_player(self.origin, self.ignore_player);

  if(!isDefined(player)) {
    if(isDefined(self.ignore_player)) {
      if(isDefined(level._should_skip_ignore_player_logic) && [[level._should_skip_ignore_player_logic]]()) {
        return 0;
      }

      self.ignore_player = [];
    }

    self setgoal(self.origin);
    return 0;
  }

  if(isDefined(player.last_valid_position)) {
    if(!is_true(self.zombie_do_not_update_goal)) {
      if(is_true(level.zombie_use_zigzag_path)) {
        entity zombieupdatezigzaggoal();
      } else {
        entity setgoal(player.last_valid_position);
      }
    }

    return 1;
  }

  if(!is_true(self.zombie_do_not_update_goal)) {
    entity setgoal(entity.origin);
  }

  return 0;
}

function zombieupdatezigzaggoal() {
  aiprofile_beginentry("zombieUpdateZigZagGoal");
  shouldrepath = 0;

  if(!shouldrepath && isDefined(self.favoriteenemy)) {
    if(!isDefined(self.nextgoalupdate) || self.nextgoalupdate <= gettime()) {
      shouldrepath = 1;
    } else if(distancesquared(self.origin, self.favoriteenemy.origin) <= sqr(250)) {
      shouldrepath = 1;
    } else if(isDefined(self.pathgoalpos)) {
      distancetogoalsqr = distancesquared(self.origin, self.pathgoalpos);
      shouldrepath = distancetogoalsqr < sqr(72);
    }
  }

  if(is_true(self.keep_moving)) {
    if(gettime() > self.keep_moving_time) {
      self.keep_moving = 0;
    }
  }

  if(shouldrepath) {
    goalpos = self.favoriteenemy.origin;

    if(isDefined(self.favoriteenemy.last_valid_position)) {
      goalpos = self.favoriteenemy.last_valid_position;
    }

    self setgoal(goalpos);

    if(distancesquared(self.origin, goalpos) > sqr(250)) {
      self.keep_moving = 1;
      self.keep_moving_time = gettime() + 250;
      path = self calcapproximatepathtoposition(goalpos, 0);

      if(getdvarint(#"ai_debugzigzag", 0)) {
        for(index = 1; index < path.size; index++) {
          recordline(path[index - 1], path[index], (1, 0.5, 0), "<dev string:x68>", self);
        }
      }

      if(isDefined(level._zombiezigzagdistancemin) && isDefined(level._zombiezigzagdistancemax)) {
        min = level._zombiezigzagdistancemin;
        max = level._zombiezigzagdistancemax;
      } else {
        min = 240;
        max = 600;
      }

      deviationdistance = randomintrange(min, max);
      segmentlength = 0;

      for(index = 1; index < path.size; index++) {
        currentseglength = distance(path[index - 1], path[index]);

        if(segmentlength + currentseglength > deviationdistance) {
          remaininglength = deviationdistance - segmentlength;
          seedposition = path[index - 1] + vectornormalize(path[index] - path[index - 1]) * remaininglength;

          recordcircle(seedposition, 2, (1, 0.5, 0), "<dev string:x68>", self);

          innerzigzagradius = 0;
          outerzigzagradius = 96;
          queryresult = positionquery_source_navigation(seedposition, innerzigzagradius, outerzigzagradius, 0.5 * 72, 16, self, 16);
          positionquery_filter_inclaimedlocation(queryresult, self);

          if(queryresult.data.size > 0) {
            point = queryresult.data[randomint(queryresult.data.size)];
            self setgoal(point.origin);
          }

          break;
        }

        segmentlength += currentseglength;
      }
    }

    if(isDefined(level._zombiezigzagtimemin) && isDefined(level._zombiezigzagtimemax)) {
      mintime = level._zombiezigzagtimemin;
      maxtime = level._zombiezigzagtimemax;
    } else {
      mintime = 2500;
      maxtime = 3500;
    }

    self.nextgoalupdate = gettime() + randomintrange(mintime, maxtime);
  }

  aiprofile_endentry();
}

function zombiecrawlercollision(entity) {
  if(!is_true(entity.missinglegs) && !is_true(entity.knockdown)) {
    return false;
  }

  if(isDefined(entity.dontpushtime)) {
    if(gettime() < entity.dontpushtime) {
      return true;
    }
  }

  if(!isDefined(level.zombie_team)) {
    return false;
  }

  zombies = getaiteamarray(level.zombie_team);

  foreach(zombie in zombies) {
    if(zombie == entity) {
      continue;
    }

    if(is_true(zombie.missinglegs) || is_true(zombie.knockdown)) {
      continue;
    }

    dist_sq = distancesquared(entity.origin, zombie.origin);

    if(dist_sq < 14400) {
      entity collidewithactors(0);
      entity.dontpushtime = gettime() + 2000;
      return true;
    }
  }

  entity collidewithactors(1);
  return false;
}

function zombietraversalservice(entity) {
  if(isDefined(entity.traversestartnode)) {
    entity collidewithactors(0);
    return true;
  }

  return false;
}

function zombieisatattackobject(entity) {
  if(is_true(entity.missinglegs)) {
    return false;
  }

  if(isDefined(entity.enemy_override)) {
    return false;
  }

  if(isDefined(entity.favoriteenemy) && is_true(entity.favoriteenemy.b_is_designated_target)) {
    return false;
  }

  if(is_true(entity.aat_turned)) {
    return false;
  }

  if(isDefined(entity.attackable) && is_true(entity.attackable.is_active)) {
    if(!isDefined(entity.attackable_slot)) {
      return false;
    }

    dist = distance2dsquared(entity.origin, entity.attackable_slot.origin);

    if(dist < 256) {
      height_offset = abs(entity.origin[2] - entity.attackable_slot.origin[2]);

      if(height_offset < 32) {
        entity.is_at_attackable = 1;
        return true;
      }
    }
  }

  return false;
}

function zombieshouldattackobject(entity) {
  if(is_true(entity.missinglegs)) {
    return false;
  }

  if(isDefined(entity.enemy_override)) {
    return false;
  }

  if(isDefined(entity.favoriteenemy) && is_true(entity.favoriteenemy.b_is_designated_target)) {
    return false;
  }

  if(is_true(entity.aat_turned)) {
    return false;
  }

  if(isDefined(entity.attackable) && is_true(entity.attackable.is_active)) {
    if(is_true(entity.is_at_attackable)) {
      return true;
    }
  }

  return false;
}

function function_997f1224(entity) {
  var_ac8727d2 = 0;
  var_b0027f10 = 0;
  var_565fd664 = 0;

  if(isDefined(entity.var_46fc9994.time) && gettime() - self.var_46fc9994.time < int(3 * 1000)) {
    var_ac8727d2 = !isDefined(entity.var_46fc9994.hit_ent);
    var_b0027f10 = isDefined(entity.var_46fc9994.var_7befcf25) && entity.var_46fc9994.var_7befcf25 > sqr(entity.meleeweapon.aimeleerange);
    var_565fd664 = isDefined(entity.var_46fc9994.position) && distance2dsquared(entity.origin, entity.var_46fc9994.position) < sqr(entity getpathfindingradius());
  }

  if(entity.archetype == # "zombie" && !isDefined(entity.subarchetype) && !is_true(self.missinglegs) && !(var_ac8727d2 && var_b0027f10 && var_565fd664)) {
    if(entity.zombie_move_speed == "walk") {
      return sqr(100);
    } else if(entity.zombie_move_speed == "run") {
      return sqr(120);
    }

    return sqr(90);
  }

  if(isDefined(entity.meleeweapon) && entity.meleeweapon !== level.weaponnone) {
    meleedistsq = entity.meleeweapon.aimeleerange * entity.meleeweapon.aimeleerange;
  }

  if(!isDefined(meleedistsq)) {
    return sqr(100);
  }

  return meleedistsq;
}

function zombieshouldmeleecondition(entity) {
  if(isDefined(entity.enemy_override)) {
    return false;
  }

  if(!isDefined(entity.enemy)) {
    return false;
  }

  if(is_true(entity.marked_for_death)) {
    return false;
  }

  if(is_true(entity.ignoremelee)) {
    return false;
  }

  if(abs(entity.origin[2] - entity.enemy.origin[2]) > (isDefined(entity.var_737e8510) ? entity.var_737e8510 : 64)) {
    return false;
  }

  meleedistsq = function_997f1224(entity);
  test_origin = entity.enemy.origin;

  if(isDefined(level.var_ee27c905) && isPlayer(entity.enemy) && entity.enemy isinvehicle()) {
    enemy_vehicle = entity.enemy getvehicleoccupied();
    test_origin = [[level.var_ee27c905]](enemy_vehicle, entity.enemy);

    if(!isDefined(test_origin)) {
      test_origin = entity.enemy.origin;
    }
  }

  if(distancesquared(entity.origin, test_origin) > meleedistsq) {
    return false;
  }

  yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);

  if(abs(yawtoenemy) > (isDefined(entity.var_1c0eb62a) ? entity.var_1c0eb62a : 60)) {
    return false;
  }

  if(!entity cansee(entity.enemy)) {
    return false;
  }

  if(distancesquared(entity.origin, entity.enemy.origin) < sqr(40)) {
    return true;
  }

  if(!tracepassedonnavmesh(entity.origin, isDefined(entity.enemy.last_valid_position) ? entity.enemy.last_valid_position : entity.enemy.origin, entity.enemy getpathfindingradius())) {
    return false;
  }

  return true;
}

function function_1b8c9407(entity) {
  if(getdvarint(#"hash_1a5939d8c37a2e07", 0)) {
    return false;
  }

  var_9fce1294 = blackboard::getblackboardevents("zombie_full_pain");

  if(isDefined(var_9fce1294) && var_9fce1294.size) {
    return false;
  }

  if(is_true(self.var_67f98db0)) {
    return false;
  }

  if(isDefined(level.var_eeb66e64) && ![[level.var_eeb66e64]](entity)) {
    return false;
  }

  return true;
}

function private function_ecba5a44(entity) {
  var_1e466fbb = spawnStruct();
  var_1e466fbb.enemy = entity.enemy;
  blackboard::addblackboardevent("zombie_full_pain", var_1e466fbb, randomintrange(6000, 9000));
}

function private function_97aec83a(entity) {
  if(getdvarint(#"hash_30c850c9bcd873bb", 0)) {
    return true;
  }

  return false;
}

function private function_eb4b29ab(entity) {
  if(getdvarint(#"hash_174d05033246950b", 1)) {
    return true;
  }

  return false;
}

function private zombieshouldmovelowg(entity) {
  return is_true(entity.low_gravity);
}

function private zombieshouldturn(entity) {
  return !isDefined(entity.turn_cooldown) || entity.turn_cooldown < gettime();
}

function private function_a716a3af(entity) {
  entity.turn_cooldown = gettime() + 1000;
  return true;
}

function zombieshouldjumpmeleecondition(entity) {
  if(!is_true(entity.low_gravity)) {
    return false;
  }

  if(isDefined(entity.enemy_override)) {
    return false;
  }

  if(!isDefined(entity.enemy)) {
    return false;
  }

  if(isDefined(entity.marked_for_death)) {
    return false;
  }

  if(is_true(entity.ignoremelee)) {
    return false;
  }

  if(entity.enemy isonground()) {
    if(isPlayer(entity.enemy) && entity.enemy isplayerswimming()) {
      waterheight = getwaterheight(entity.enemy.origin);

      if(waterheight - entity.enemy.origin[2] < 24) {
        return false;
      }
    } else {
      return false;
    }
  }

  jumpchance = getdvarfloat(#"zmmeleejumpchance", 0.5);

  if(entity getentitynumber() % 10 / 10 > jumpchance) {
    return false;
  }

  predictedposition = entity.enemy.origin + entity.enemy getvelocity() * float(function_60d95f53()) / 1000 * 2;
  jumpdistancesq = pow(getdvarint(#"zmmeleejumpdistance", 180), 2);

  if(distance2dsquared(entity.origin, predictedposition) > jumpdistancesq) {
    return false;
  }

  yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);

  if(abs(yawtoenemy) > 60) {
    return false;
  }

  heighttoenemy = entity.enemy.origin[2] - entity.origin[2];

  if(heighttoenemy <= getdvarint(#"zmmeleejumpheightdifference", 60)) {
    return false;
  }

  return true;
}

function zombieshouldjumpunderwatermelee(entity) {
  if(isDefined(entity.enemy_override)) {
    return false;
  }

  if(is_true(entity.ignoreall)) {
    return false;
  }

  if(!isDefined(entity.enemy)) {
    return false;
  }

  if(isDefined(entity.marked_for_death)) {
    return false;
  }

  if(is_true(entity.ignoremelee)) {
    return false;
  }

  if(entity.enemy isonground()) {
    return false;
  }

  if(entity depthinwater() < 48) {
    return false;
  }

  jumpdistancesq = pow(getdvarint(#"zmmeleewaterjumpdistance", 64), 2);

  if(distance2dsquared(entity.origin, entity.enemy.origin) > jumpdistancesq) {
    return false;
  }

  yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);

  if(abs(yawtoenemy) > 60) {
    return false;
  }

  heighttoenemy = entity.enemy.origin[2] - entity.origin[2];

  if(heighttoenemy <= getdvarint(#"zmmeleejumpunderwaterheightdifference", 48)) {
    return false;
  }

  return true;
}

function zombiestumble(entity) {
  if(is_true(entity.missinglegs)) {
    return false;
  }

  if(!is_true(entity.canstumble)) {
    return false;
  }

  if(!isDefined(entity.zombie_move_speed) || entity.zombie_move_speed != "sprint") {
    return false;
  }

  if(isDefined(entity.stumble)) {
    return false;
  }

  if(!isDefined(entity.next_stumble_time)) {
    entity.next_stumble_time = gettime() + randomintrange(9000, 12000);
  }

  if(gettime() > entity.next_stumble_time) {
    if(randomint(100) < 5) {
      closestplayer = arraygetclosest(entity.origin, level.players);

      if(distancesquared(closestplayer.origin, entity.origin) > 50000) {
        if(isDefined(entity.next_juke_time)) {
          entity.next_juke_time = undefined;
        }

        entity.next_stumble_time = undefined;
        entity.stumble = 1;
        return true;
      }
    }
  }

  return false;
}

function zombiejuke(entity) {
  if(!entity ai::has_behavior_attribute("can_juke")) {
    return 0;
  }

  if(!entity ai::get_behavior_attribute("can_juke")) {
    return 0;
  }

  if(is_true(entity.missinglegs)) {
    return 0;
  }

  if(entity aiutility::function_cc26899f() != "locomotion_speed_walk") {
    if(entity ai::has_behavior_attribute("spark_behavior") && !entity ai::get_behavior_attribute("spark_behavior")) {
      return 0;
    }
  }

  if(isDefined(entity.juke)) {
    return 0;
  }

  if(!isDefined(entity.next_juke_time)) {
    entity.next_juke_time = gettime() + randomintrange(7500, 9500);
  }

  if(gettime() > entity.next_juke_time) {
    entity.next_juke_time = undefined;

    if(randomint(100) < 25 || entity ai::has_behavior_attribute("spark_behavior") && entity ai::get_behavior_attribute("spark_behavior")) {
      if(isDefined(entity.next_stumble_time)) {
        entity.next_stumble_time = undefined;
      }

      forwardoffset = 15;
      entity.ignorebackwardposition = 1;

      if(math::cointoss()) {
        jukedistance = 101;
        entity.jukedistance = "long";

        switch (entity aiutility::function_cc26899f()) {
          case # "locomotion_speed_run":
          case # "locomotion_speed_walk":
            forwardoffset = 122;
            break;
          case # "locomotion_speed_sprint":
            forwardoffset = 129;
            break;
        }

        entity.juke = aiutility::calculatejukedirection(entity, forwardoffset, jukedistance);
      }

      if(!isDefined(entity.juke) || entity.juke == "forward") {
        jukedistance = 69;
        entity.jukedistance = "short";

        switch (entity aiutility::function_cc26899f()) {
          case # "locomotion_speed_run":
          case # "locomotion_speed_walk":
            forwardoffset = 127;
            break;
          case # "locomotion_speed_sprint":
            forwardoffset = 148;
            break;
        }

        entity.juke = aiutility::calculatejukedirection(entity, forwardoffset, jukedistance);

        if(entity.juke == "forward") {
          entity.juke = undefined;
          entity.jukedistance = undefined;
          return 0;
        }
      }
    }
  }
}

function zombiedeathaction(entity) {
  return undefined;
}

function waskilledbyinterdimensionalguncondition(entity) {
  if(isDefined(entity.interdimensional_gun_kill) && !isDefined(entity.killby_interdimensional_gun_hole) && isalive(entity)) {
    return true;
  }

  return false;
}

function wascrushedbyinterdimensionalgunblackholecondition(entity) {
  if(isDefined(entity.killby_interdimensional_gun_hole)) {
    return true;
  }

  return false;
}

function zombieidgundeathmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  mocompduration orientmode("face angle", mocompduration.angles[1]);
  mocompduration animmode("noclip");
  mocompduration.pushable = 0;
  mocompduration.blockingpain = 1;
  mocompduration pathmode("dont move");
  mocompduration.hole_pull_speed = 0;
}

function zombiemeleejumpmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  mocompduration orientmode("face enemy");
  mocompduration animmode("noclip", 0);
  mocompduration.pushable = 0;
  mocompduration.blockingpain = 1;
  mocompduration.clamptonavmesh = 0;
  mocompduration collidewithactors(0);
  mocompduration.jumpstartposition = mocompduration.origin;
}

function zombiemeleejumpmocompupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  normalizedtime = (mocompanim getanimtime(mocompanimblendouttime) * getanimlength(mocompanimblendouttime) + mocompanimflag) / mocompduration;

  if(normalizedtime > 0.5) {
    mocompanim orientmode("face angle", mocompanim.angles[1]);
  }

  speed = 5;

  if(isDefined(mocompanim.zombie_move_speed)) {
    switch (mocompanim.zombie_move_speed) {
      case # "walk":
        speed = 5;
        break;
      case # "run":
        speed = 6;
        break;
      case # "sprint":
        speed = 7;
        break;
    }
  }

  newposition = mocompanim.origin + anglesToForward(mocompanim.angles) * speed;
  newtestposition = (newposition[0], newposition[1], mocompanim.jumpstartposition[2]);
  newvalidposition = getclosestpointonnavmesh(newtestposition, 12, 20);

  if(isDefined(newvalidposition)) {
    newvalidposition = (newvalidposition[0], newvalidposition[1], mocompanim.origin[2]);
  } else {
    newvalidposition = mocompanim.origin;
  }

  if(!is_true(mocompanim.var_7c16e514)) {
    waterheight = getwaterheight(mocompanim.origin);

    if(newvalidposition[2] + mocompanim function_6a9ae71() > waterheight) {
      newvalidposition = (newvalidposition[0], newvalidposition[1], waterheight - mocompanim function_6a9ae71());
    }
  }

  groundpoint = getclosestpointonnavmesh(newvalidposition, 12, 20);

  if(isDefined(groundpoint) && groundpoint[2] > newvalidposition[2]) {
    newvalidposition = (newvalidposition[0], newvalidposition[1], groundpoint[2]);
  }

  mocompanim forceteleport(newvalidposition);
}

function zombiemeleejumpmocompterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  mocompduration.pushable = 1;
  mocompduration.blockingpain = 0;
  mocompduration.clamptonavmesh = 1;
  mocompduration collidewithactors(1);
  groundpoint = getclosestpointonnavmesh(mocompduration.origin, 12);

  if(isDefined(groundpoint)) {
    mocompduration forceteleport(groundpoint);
  }
}

function zombieidgundeathupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(!isDefined(mocompduration.killby_interdimensional_gun_hole)) {
    entity_eye = mocompduration getEye();

    if(mocompduration.b_vortex_repositioned !== 1) {
      mocompduration.b_vortex_repositioned = 1;
      v_nearest_navmesh_point = getclosestpointonnavmesh(mocompduration.damageorigin, 36, 15);

      if(isDefined(v_nearest_navmesh_point)) {
        f_distance = distance(mocompduration.damageorigin, v_nearest_navmesh_point);

        if(f_distance < 41) {
          mocompduration.damageorigin += (0, 0, 36);
        }
      }
    }

    entity_center = mocompduration.origin + (entity_eye - mocompduration.origin) / 2;
    flyingdir = mocompduration.damageorigin - entity_center;
    lengthfromhole = length(flyingdir);

    if(lengthfromhole < mocompduration.hole_pull_speed) {
      if(!is_true(mocompduration.var_6581b296)) {
        mocompduration thread function_1ad2970();
        mocompduration.var_6581b296 = 1;
      }

      return;
    }

    if(mocompduration.hole_pull_speed < 12) {
      mocompduration.hole_pull_speed += 0.5;

      if(mocompduration.hole_pull_speed > 12) {
        mocompduration.hole_pull_speed = 12;
      }
    }

    flyingdir = vectornormalize(flyingdir);
    mocompduration forceteleport(mocompduration.origin + flyingdir * mocompduration.hole_pull_speed);
  }
}

function function_1ad2970() {
  waitframe(1);

  if(!isDefined(self)) {
    return;
  }

  self.killby_interdimensional_gun_hole = 1;
  self.allowdeath = 1;
  self.takedamage = 1;
  self.aioverridedamage = undefined;
  self.magic_bullet_shield = 0;
  level notify(#"interdimensional_kill", {
    #entity: self
  });

  if(isDefined(self.interdimensional_gun_weapon) && isDefined(self.interdimensional_gun_attacker)) {
    self kill(self.origin, self.interdimensional_gun_attacker, self.interdimensional_gun_attacker, self.interdimensional_gun_weapon);
    return;
  }

  self kill(self.origin);
}

function zombieidgunholedeathmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  mocompduration orientmode("face angle", mocompduration.angles[1]);
  mocompduration animmode("noclip");
  mocompduration.pushable = 0;
}

function zombieidgunholedeathmocompterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(!is_true(mocompduration.interdimensional_gun_kill_vortex_explosion)) {
    mocompduration hide();
  }
}

function private zombieturnmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  mocompduration orientmode("face angle", mocompduration.angles[1]);
  mocompduration animmode("angle deltas", 0);
}

function private zombieturnmocompupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  normalizedtime = (mocompanim getanimtime(mocompanimblendouttime) + mocompanimflag) / mocompduration;

  if(normalizedtime > 0.25) {
    mocompanim orientmode("face motion");
    mocompanim animmode("normal", 0);
  }
}

function private zombieturnmocompterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  mocompduration orientmode("face motion");
  mocompduration animmode("normal", 0);
}

function zombiehaslegs(entity) {
  if(entity.missinglegs === 1) {
    return false;
  }

  return true;
}

function zombiemissinglegs(entity) {
  return !zombiehaslegs(entity);
}

function zombieshouldproceduraltraverse(entity) {
  return isDefined(entity.traversestartnode) && isDefined(entity.traverseendnode) && entity.traversestartnode.spawnflags & 1024 && entity.traverseendnode.spawnflags & 1024;
}

function zombieshouldmeleesuicide(entity) {
  if(!entity ai::get_behavior_attribute("suicidal_behavior")) {
    return false;
  }

  if(is_true(entity.magic_bullet_shield)) {
    return false;
  }

  if(!isDefined(entity.enemy)) {
    return false;
  }

  if(isDefined(entity.marked_for_death)) {
    return false;
  }

  if(distancesquared(entity.origin, entity.enemy.origin) > 40000) {
    return false;
  }

  return true;
}

function zombiemeleesuicidestart(entity) {
  entity.blockingpain = 1;

  if(isDefined(level.zombiemeleesuicidecallback)) {
    entity thread[[level.zombiemeleesuicidecallback]](entity);
  }
}

function zombiemeleesuicideupdate(entity) {}

function zombiemeleesuicideterminate(entity) {
  if(isalive(entity) && zombieshouldmeleesuicide(entity)) {
    entity.takedamage = 1;
    entity.allowdeath = 1;

    if(isDefined(level.zombiemeleesuicidedonecallback)) {
      entity thread[[level.zombiemeleesuicidedonecallback]](entity);
    }
  }
}

function zombiemoveactionstart(entity, asmstatename) {
  function_ec25b529(entity);
  animationstatenetworkutility::requeststate(entity, asmstatename);

  if(is_true(entity.stumble) && !isDefined(entity.move_anim_end_time)) {
    stumbleactionresult = entity astsearch(asmstatename);
    stumbleactionanimation = animationstatenetworkutility::searchanimationmap(entity, stumbleactionresult[#"animation"]);
    entity.move_anim_end_time = entity.movetime + getanimlength(stumbleactionanimation);
  }

  entity.movetime = gettime();
  entity.moveorigin = entity.origin;
  entity.var_13138acf = 0;
  return 5;
}

function function_a82068d7(entity) {
  function_ec25b529(entity);
  return true;
}

function function_ec25b529(entity) {
  entity.movetime = gettime();
  entity.moveorigin = entity.origin;
}

function zombiemoveactionupdate(entity, asmstatename) {
  if(isDefined(entity.move_anim_end_time) && gettime() >= entity.move_anim_end_time) {
    entity.move_anim_end_time = undefined;
    return 4;
  }

  function_26f9b8b1(entity);

  if(entity asmgetstatus() == "asm_status_complete") {
    if(entity iscurrentbtactionlooping()) {
      return zombiemoveactionstart(entity, asmstatename);
    } else {
      return 4;
    }
  }

  return 5;
}

function function_626edd6b(entity) {
  function_26f9b8b1(entity);
  return true;
}

function function_26f9b8b1(entity) {
  if(!is_true(entity.missinglegs) && gettime() - entity.movetime > 1000) {
    distsq = distance2dsquared(entity.origin, entity.moveorigin);

    if(distsq < 144 && !is_true(entity.cant_move)) {
      entity.cant_move = 1;
      entity setavoidancemask("avoid all");

      record3dtext("<dev string:x76>", entity.origin, (0, 0, 1), "<dev string:x46>", entity);

      if(isDefined(entity.cant_move_cb)) {
        entity thread[[entity.cant_move_cb]]();
      }
    } else if(is_true(entity.cant_move)) {
      entity.cant_move = 0;
      entity setavoidancemask("avoid none");

      if(isDefined(entity.var_63d2fce2)) {
        entity thread[[entity.var_63d2fce2]]();
      }
    }

    entity.movetime = gettime();
    entity.moveorigin = entity.origin;
  }
}

function zombiemoveactionterminate(entity, asmstatename) {
  if(!is_true(asmstatename.missinglegs)) {
    asmstatename setavoidancemask("avoid none");
  }

  return 4;
}

function function_79fe956f() {
  self notify("333983529c7de063");
  self endon("333983529c7de063");
  self endon(#"death");

  if(!isDefined(self.var_9ed3cc11)) {
    self.var_9ed3cc11 = self function_e827fc0e();
  }

  self pushplayer(1);
  wait 2;

  if(isDefined(self.var_9ed3cc11)) {
    self pushplayer(self.var_9ed3cc11);
    self.var_9ed3cc11 = undefined;
  }
}

function function_22762653() {
  self notify("607a97be6c5daf6d");
  self endon("607a97be6c5daf6d");
  self endon(#"death");

  if(isDefined(self.enemy_override)) {
    self.enemy_override callback::callback(#"cant_move", self);
    return;
  }

  if(util::get_game_type() === # "zsurvival" && getDvar(#"hash_fb0f3afcdafbdf3", 1)) {
    if(!isDefined(self.var_1f2c0ce1)) {
      self.var_1f2c0ce1 = self.origin;
    } else if(distancesquared(self.var_1f2c0ce1, self.origin) < sqr(self getpathfindingradius())) {
      self clearpath();
      self.var_1f2c0ce1 = undefined;
    } else {
      self.var_1f2c0ce1 = self.origin;
    }
  }

  var_159fa617 = 0;

  foreach(player in getplayers()) {
    if(player laststand::player_is_in_laststand()) {
      if(distancesquared(self.origin, player.origin) < 14400) {
        var_159fa617 = 1;
        break;
      }
    }
  }

  if(!var_159fa617) {
    self collidewithactors(0);
    wait 2;
    self collidewithactors(1);
    return;
  }

  if(!isDefined(self.var_9ed3cc11)) {
    self.var_9ed3cc11 = self function_e827fc0e();
  }

  self pushplayer(1);
  wait 2;

  if(isDefined(self.var_9ed3cc11)) {
    self pushplayer(self.var_9ed3cc11);
    self.var_9ed3cc11 = undefined;
  }
}

function function_9b6830c9(entity, asmstatename) {
  animationstatenetworkutility::requeststate(entity, asmstatename);
  entity pathmode("dont move");
  return 5;
}

function function_fbdc2cc4(entity, asmstatename) {
  asmstatename pathmode("move allowed");
  return 4;
}

function function_71f7975f(entity) {
  if(is_true(self.var_78f17f6b)) {
    if(isDefined(entity.favoriteenemy) && distance(entity.favoriteenemy.origin, entity.origin) < 64) {
      return true;
    } else if(!isalive(entity)) {
      return true;
    }
  }

  return false;
}

function function_85a1a8d4(entity) {
  radiusdamage(entity.origin, 128, 75, 75, entity, "MOD_EXPLOSIVE");
  entity hide();
  entity notsolid();

  if(isalive(entity)) {
    entity.allowdeath = 1;
    entity kill(undefined, entity, entity, undefined, 0, 1);
  }

  entity.takedamage = 0;
  entity thread util::delayed_delete(1);
}

function archetypezombiedeathoverrideinit() {
  aiutility::addaioverridekilledcallback(self, &zombiegibkilledanhilateoverride);
}

function private zombiegibkilledanhilateoverride(inflictor, attacker, damage, meansofdeath, weapon, var_fd90b0bb, dir, hitloc, offsettime) {
  if(!is_true(level.zombieanhilationenabled)) {
    return dir;
  }

  if(is_true(self.forceanhilateondeath)) {
    self zombie_utility::gib_random_parts();
    gibserverutils::annihilate(self);
    return dir;
  }

  if(isDefined(var_fd90b0bb) && isPlayer(var_fd90b0bb) && (is_true(var_fd90b0bb.forceanhilateondeath) || is_true(level.forceanhilateondeath))) {
    self zombie_utility::gib_random_parts();
    gibserverutils::annihilate(self);
    return dir;
  }

  attackerdistance = 0;

  if(isDefined(var_fd90b0bb)) {
    attackerdistance = distancesquared(var_fd90b0bb.origin, self.origin);
  }

  isexplosive = isinarray(array("MOD_CRUSH", "MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), hitloc);

  if(isDefined(offsettime.weapclass) && offsettime.weapclass == "turret") {
    if(isDefined(weapon)) {
      isdirectexplosive = isinarray(array("MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), hitloc);
      iscloseexplosive = distancesquared(weapon.origin, self.origin) <= sqr(60);

      if(isdirectexplosive && iscloseexplosive) {
        self zombie_utility::gib_random_parts();
        gibserverutils::annihilate(self);
      }
    }
  }

  return dir;
}

function private zombiezombieidlemocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(isDefined(mocompduration.enemy_override) && mocompduration != mocompduration.enemy_override) {
    mocompduration orientmode("face direction", mocompduration.enemy_override.origin - mocompduration.origin);
    mocompduration animmode("zonly_physics", 0);
    return;
  }

  mocompduration orientmode("face current");
  mocompduration animmode("zonly_physics", 0);
}

function private zombieattackobjectmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(isDefined(mocompduration.attackable_slot)) {
    mocompduration orientmode("face angle", mocompduration.attackable_slot.angles[1]);
    mocompduration animmode("zonly_physics", 0);
    return;
  }

  mocompduration orientmode("face current");
  mocompduration animmode("zonly_physics", 0);
}

function private zombieattackobjectmocompupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(isDefined(mocompduration.attackable_slot)) {
    mocompduration forceteleport(mocompduration.attackable_slot.origin);
  }
}

function private function_54d75299(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(isDefined(mocompanimflag.enemy)) {
    mocompanimflag orientmode("face enemy");
  }

  mocompanimflag animmode("zonly_physics", 1);
  mocompanimflag pathmode("dont move");
  localdeltahalfvector = getmovedelta(mocompduration, 0, 0.9);
  endpoint = mocompanimflag localtoworldcoords(localdeltahalfvector);

  recordcircle(endpoint, 3, (1, 0, 0), "<dev string:x9e>");
  recordline(mocompanimflag.origin, endpoint, (1, 0, 0), "<dev string:x9e>");
  record3dtext("<dev string:xa8>" + distance(mocompanimflag.origin, endpoint) + "<dev string:xb1>" + function_9e72a96(mocompduration), endpoint, (1, 0, 0), "<dev string:x46>");
}

function private function_d1474842(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  mocompduration pathmode("dont move");
}

function private function_b6d297bb(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  mocompduration pathmode("move allowed");
}

function private function_cbbae5cb(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  mocompduration orientmode("face angle", mocompduration.angles[1]);
  mocompduration animmode("normal");

  if(isDefined(mocompduration.traverseendnode)) {
    print3d(mocompduration.traversestartnode.origin, "<dev string:xbb>", (1, 0, 0), 1, 1, 60);
    print3d(mocompduration.traverseendnode.origin, "<dev string:xbb>", (0, 1, 0), 1, 1, 60);
    line(mocompduration.traversestartnode.origin, mocompduration.traverseendnode.origin, (0, 1, 0), 1, 0, 60);

    mocompduration forceteleport(mocompduration.traverseendnode.origin, mocompduration.traverseendnode.angles, 0);
  }
}

function zombiegravity(entity, attribute, oldvalue, value) {
  if(value == "low") {
    self.low_gravity = 1;

    if(!isDefined(self.low_gravity_variant) && isDefined(level.var_d9ffddf4)) {
      if(is_true(self.missinglegs)) {
        self.low_gravity_variant = randomint(level.var_d9ffddf4[#"crawl"]);
      } else {
        self.low_gravity_variant = randomint(level.var_d9ffddf4[self.zombie_move_speed]);
      }
    }
  } else if(value == "normal") {
    self.low_gravity = 0;
  }

  oldvalue setblackboardattribute("_low_gravity", value);
}