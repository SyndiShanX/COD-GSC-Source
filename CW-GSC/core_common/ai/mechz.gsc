/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\mechz.gsc
***********************************************/

#using script_2c5daa95f8fec03c;
#using script_ed50e9299d3e143;
#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\archetype_mocomps_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\debug;
#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\burnplayer;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\weapons\mechz_firebomb;
#using scripts\weapons\weaponobjects;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_spawner;
#namespace mechzbehavior;

function private autoexec __init__system__() {
  system::register(#"mechz", &init, undefined, &finalize, undefined);
}

function init() {
  initmechzbehaviorsandasm();
  spawner::add_archetype_spawn_function(#"mechz", &archetypemechzblackboardinit);
  spawner::add_archetype_spawn_function(#"mechz", &mechzserverutils::mechzspawnsetup);
  spawner::function_89a2cd87(#"mechz", &mechzserverutils::function_5d873f78);
  clientfield::register("actor", "mechz_ft", 1, 1, "int");
  clientfield::register("actor", "mechz_faceplate_detached", 1, 1, "int");
  clientfield::register("actor", "mechz_powercap_detached", 1, 1, "int");
  clientfield::register("actor", "mechz_claw_detached", 1, 1, "int");
  clientfield::register("actor", "mechz_115_gun_firing", 1, 1, "int");
  clientfield::register("actor", "mechz_headlamp_off", 1, 2, "int");
  clientfield::register("actor", "mechz_long_jump", 1, 1, "counter");
  clientfield::register("actor", "mechz_jetpack_explosion", 1, 1, "int");
  clientfield::register("actor", "mechz_face", 1, 3, "int");
  level.var_92e56a0f[#"mechz"] = &mechzserverutils::function_669e8e27;
}

function finalize() {
  level thread aat::register_immunity("ammomod_brainrot", #"mechz", 1, 1, 1);
  level thread aat::register_immunity("ammomod_cryofreeze", #"mechz", 1, 1, 1);
  level thread aat::register_immunity("ammomod_deadwire", #"mechz", 1, 1, 1);
  level thread aat::register_immunity("ammomod_napalmburst", #"mechz", 1, 1, 1);
}

function private initmechzbehaviorsandasm() {
  assert(isscriptfunctionptr(&mechztargetservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzTargetService", &mechztargetservice);
  assert(isscriptfunctionptr(&mechzgrenadeservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzGrenadeService", &mechzgrenadeservice);
  assert(isscriptfunctionptr(&mechzberserkknockdownservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzBerserkKnockdownService", &mechzberserkknockdownservice);
  assert(isscriptfunctionptr(&mechzshouldmelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldMelee", &mechzshouldmelee);
  assert(isscriptfunctionptr(&mechzshouldshowpain));
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldShowPain", &mechzshouldshowpain);
  assert(isscriptfunctionptr(&mechzshouldshowjetpackpain));
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldShowJetpackPain", &mechzshouldshowjetpackpain);
  assert(isscriptfunctionptr(&mechzenemyinaim));
  behaviorstatemachine::registerbsmscriptapiinternal("mechzEnemyInAim", &mechzenemyinaim);
  assert(isscriptfunctionptr(&mechzenemynotinaim));
  behaviorstatemachine::registerbsmscriptapiinternal("mechzEnemyNotInAim", &mechzenemynotinaim);
  assert(isscriptfunctionptr(&mechzshouldshootgrenade));
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldShootGrenade", &mechzshouldshootgrenade);
  assert(isscriptfunctionptr(&mechzshouldshootflame));
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldShootFlame", &mechzshouldshootflame);
  assert(isscriptfunctionptr(&mechzshouldshootflamesweep));
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldShootFlameSweep", &mechzshouldshootflamesweep);
  assert(isscriptfunctionptr(&mechzshouldturnberserk));
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldTurnBerserk", &mechzshouldturnberserk);
  assert(isscriptfunctionptr(&mechzshouldstumble));
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldStumble", &mechzshouldstumble);
  assert(isscriptfunctionptr(&mechzisinsafezone));
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzIsInSafeZone", &mechzisinsafezone);
  assert(isscriptfunctionptr(&mechzshouldturninplacebeforeidle));
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldTurnInPlaceBeforeIdle", &mechzshouldturninplacebeforeidle);
  assert(!isDefined(&mechzstumblestart) || isscriptfunctionptr(&mechzstumblestart));
  assert(!isDefined(&mechzstumbleupdate) || isscriptfunctionptr(&mechzstumbleupdate));
  assert(!isDefined(&mechzstumbleend) || isscriptfunctionptr(&mechzstumbleend));
  behaviortreenetworkutility::registerbehaviortreeaction("mechzStumbleLoop", &mechzstumblestart, &mechzstumbleupdate, &mechzstumbleend);
  assert(!isDefined(&mechzshootflameactionstart) || isscriptfunctionptr(&mechzshootflameactionstart));
  assert(!isDefined(&mechzshootflameactionupdate) || isscriptfunctionptr(&mechzshootflameactionupdate));
  assert(!isDefined(&mechzshootflameactionend) || isscriptfunctionptr(&mechzshootflameactionend));
  behaviortreenetworkutility::registerbehaviortreeaction("mechzShootFlameAction", &mechzshootflameactionstart, &mechzshootflameactionupdate, &mechzshootflameactionend);
  assert(isscriptfunctionptr(&mechzpreptoshootgrenadestart));
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzPrepToShootGrenadeStart", &mechzpreptoshootgrenadestart);
  assert(isscriptfunctionptr(&mechzpreptoshootgrenadestart));
  behaviorstatemachine::registerbsmscriptapiinternal("mechzPrepToShootGrenadeStart", &mechzpreptoshootgrenadestart);
  assert(isscriptfunctionptr(&mechzpreptoshootgrenadesterminate));
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzPrepToShootGrenadesTerminate", &mechzpreptoshootgrenadesterminate);
  assert(isscriptfunctionptr(&mechzpreptoshootgrenadesterminate));
  behaviorstatemachine::registerbsmscriptapiinternal("mechzPrepToShootGrenadesTerminate", &mechzpreptoshootgrenadesterminate);
  assert(isscriptfunctionptr(&mechzshootgrenadestart));
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShootGrenadeStart", &mechzshootgrenadestart);
  assert(isscriptfunctionptr(&mechzshootgrenadestart));
  behaviorstatemachine::registerbsmscriptapiinternal("mechzShootGrenadeStart", &mechzshootgrenadestart);
  assert(isscriptfunctionptr(&mechzshootgrenadeterminate));
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShootGrenadeTerminate", &mechzshootgrenadeterminate);
  assert(isscriptfunctionptr(&mechzshootgrenadeterminate));
  behaviorstatemachine::registerbsmscriptapiinternal("mechzShootGrenadeTerminate", &mechzshootgrenadeterminate);
  assert(isscriptfunctionptr(&mechzsetspeedwalk));
  behaviorstatemachine::registerbsmscriptapiinternal("mechzSetSpeedWalk", &mechzsetspeedwalk);
  assert(isscriptfunctionptr(&mechzsetspeedrun));
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzSetSpeedRun", &mechzsetspeedrun);
  assert(isscriptfunctionptr(&mechzshootflame));
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShootFlame", &mechzshootflame);
  assert(isscriptfunctionptr(&mechzupdateflame));
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzUpdateFlame", &mechzupdateflame);
  assert(isscriptfunctionptr(&mechzstopflame));
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzStopFlame", &mechzstopflame);
  assert(isscriptfunctionptr(&mechzplayedberserkintro));
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzPlayedBerserkIntro", &mechzplayedberserkintro);
  assert(isscriptfunctionptr(&mechzattackstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzAttackStart", &mechzattackstart);
  assert(isscriptfunctionptr(&mechzdeathstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzDeathStart", &mechzdeathstart);
  assert(isscriptfunctionptr(&mechzidlestart));
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzIdleStart", &mechzidlestart);
  assert(isscriptfunctionptr(&mechzpainstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzPainStart", &mechzpainstart);
  assert(isscriptfunctionptr(&mechzpainterminate));
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzPainTerminate", &mechzpainterminate);
  assert(isscriptfunctionptr(&mechzjetpackpainterminate));
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzJetpackPainTerminate", &mechzjetpackpainterminate);
  animationstatenetwork::registernotetrackhandlerfunction("melee_soldat", &mechznotetrackmelee);
  animationstatenetwork::registernotetrackhandlerfunction("fire_chaingun", &mechznotetrackshootgrenade);
  animationstatenetwork::registernotetrackhandlerfunction("jump_shake", &function_4e89924a);
}

function private archetypemechzblackboardinit() {
  blackboard::createblackboardforentity(self);
  self.___archetypeonanimscriptedcallback = &archetypemechzonanimscriptedcallback;
}

function private archetypemechzonanimscriptedcallback(entity) {
  entity.__blackboard = undefined;
  entity archetypemechzblackboardinit();
}

function private mechznotetrackmelee(entity) {
  if(isDefined(entity.mechz_melee_knockdown_function)) {
    entity thread[[entity.mechz_melee_knockdown_function]]();
  }

  entity melee();
}

function private mechznotetrackshootgrenade(entity) {
  if(!isDefined(entity.enemy)) {
    return;
  }

  base_target_pos = entity.enemy.origin;
  v_velocity = entity.enemy getvelocity();
  var_b6897326 = randomfloatrange(1, 2.5);
  base_target_pos += v_velocity * var_b6897326;
  target_pos_offset_x = math::randomsign() * randomint(48);
  target_pos_offset_y = math::randomsign() * randomint(48);
  target_pos = base_target_pos + (target_pos_offset_x, target_pos_offset_y, 0);
  dir = vectortoangles(target_pos - entity.origin);
  dir = anglesToForward(dir);
  launch_offset = dir * 5;
  launch_pos = entity gettagorigin("tag_gun_barrel2") + launch_offset;
  dist = distance(launch_pos, target_pos);
  velocity = dir * dist;
  velocity += (0, 0, 120);
  val = 1;
  oldval = entity clientfield::get("mechz_115_gun_firing");

  if(oldval === val) {
    val = 0;
  }

  entity clientfield::set("mechz_115_gun_firing", val);
  entity magicgrenadetype(getweapon("eq_mechz_firebomb"), launch_pos, velocity);
}

function function_4e89924a(entity) {
  entity clientfield::increment("mechz_long_jump");
}

function mechztargetservice(entity) {
  if(is_true(entity.ignoreall)) {
    return 0;
  }

  if(isDefined(entity.destroy_octobomb)) {
    return 0;
  }

  player = zombie_utility::get_closest_valid_player(self.origin, self.ignore_player);
  entity.favoriteenemy = player;

  if(!isDefined(player) || player isnotarget()) {
    if(isDefined(entity.ignore_player)) {
      if(isDefined(level._should_skip_ignore_player_logic) && [[level._should_skip_ignore_player_logic]]()) {
        return;
      }

      entity.ignore_player = [];
    }

    if(is_true(level.b_mechz_true_ignore)) {
      entity setgoal(entity.origin);

      if(isDefined(entity.var_9d92b55a)) {
        [[entity.var_9d92b55a]](entity);
      }

      return 0;
    }

    if(isDefined(level.no_target_override)) {
      [[level.no_target_override]](entity);
    } else {
      entity setgoal(entity.origin);

      if(isDefined(entity.var_9d92b55a)) {
        [[entity.var_9d92b55a]](entity);
      }
    }

    return 0;
  }

  if(isDefined(level.enemy_location_override_func)) {
    enemy_ground_pos = [[level.enemy_location_override_func]](entity, player);

    if(isDefined(enemy_ground_pos)) {
      entity setgoal(enemy_ground_pos);

      if(isDefined(entity.var_9d92b55a)) {
        [[entity.var_9d92b55a]](entity);
      }

      return 1;
    }
  }

  targetpos = getclosestpointonnavmesh(player.origin, 64, 30);

  if(isDefined(targetpos)) {
    entity setgoal(targetpos);

    if(isDefined(entity.var_9d92b55a)) {
      [[entity.var_9d92b55a]](entity);
    }

    return 1;
  }

  entity setgoal(entity.origin);

  if(isDefined(entity.var_9d92b55a)) {
    [[entity.var_9d92b55a]](entity);
  }

  return 0;
}

function private mechzgrenadeservice(entity) {
  if(!isDefined(entity.burstgrenadesfired)) {
    entity.burstgrenadesfired = 0;
  }

  if(entity.burstgrenadesfired >= 1) {
    if(gettime() > entity.nextgrenadetime) {
      entity.burstgrenadesfired = 0;
    }
  }

  if(isDefined(level.a_electroball_grenades)) {
    arrayremovevalue(level.a_electroball_grenades, undefined);
    a_active_grenades = array::filter(level.a_electroball_grenades, 0, &mechzfiltergrenadesbyowner, entity);
    entity.activegrenades = a_active_grenades.size;
    return;
  }

  entity.activegrenades = 0;
}

function private mechzfiltergrenadesbyowner(grenade, mechz) {
  if(grenade.owner === mechz) {
    return true;
  }

  return false;
}

function private mechzberserkknockdownservice(entity) {
  velocity = entity getvelocity();
  predict_time = 0.3;
  predicted_pos = entity.origin + velocity * predict_time;
  move_dist_sq = distancesquared(predicted_pos, entity.origin);
  speed = move_dist_sq / predict_time;

  if(speed >= 10) {
    a_zombies = getentitiesinradius(entity.origin, 48, 15);
    a_filtered_zombies = array::filter(a_zombies, 0, &mechzzombieeligibleforberserkknockdown, entity, predicted_pos);

    if(a_filtered_zombies.size > 0) {
      foreach(zombie in a_filtered_zombies) {
        zombie.knockdown = 1;
        zombie.knockdown_type = "knockdown_shoved";
        zombie_to_mechz = entity.origin - zombie.origin;
        zombie_to_mechz_2d = vectorNormalize((zombie_to_mechz[0], zombie_to_mechz[1], 0));
        zombie_forward = anglesToForward(zombie.angles);
        zombie_forward_2d = vectorNormalize((zombie_forward[0], zombie_forward[1], 0));
        zombie_right = anglestoright(zombie.angles);
        zombie_right_2d = vectorNormalize((zombie_right[0], zombie_right[1], 0));
        dot = vectordot(zombie_to_mechz_2d, zombie_forward_2d);

        if(dot >= 0.5) {
          zombie.knockdown_direction = "front";
          zombie.getup_direction = "getup_back";
          continue;
        }

        if(dot < 0.5 && dot > -0.5) {
          dot = vectordot(zombie_to_mechz_2d, zombie_right_2d);

          if(dot > 0) {
            zombie.knockdown_direction = "right";

            if(math::cointoss()) {
              zombie.getup_direction = "getup_back";
            } else {
              zombie.getup_direction = "getup_belly";
            }
          } else {
            zombie.knockdown_direction = "left";
            zombie.getup_direction = "getup_belly";
          }

          continue;
        }

        zombie.knockdown_direction = "back";
        zombie.getup_direction = "getup_belly";
      }
    }
  }
}

function private mechzzombieeligibleforberserkknockdown(zombie, mechz, predicted_pos) {
  if(!isDefined(mechz) || !isDefined(predicted_pos)) {
    return false;
  }

  if(mechz.knockdown === 1) {
    return false;
  }

  if(mechz.archetype !== #"zombie") {
    return false;
  }

  if(mechz.is_immune_to_knockdown === 1) {
    return false;
  }

  origin = predicted_pos.origin;
  facing_vec = anglesToForward(predicted_pos.angles);
  enemy_vec = mechz.origin - origin;
  enemy_yaw_vec = (enemy_vec[0], enemy_vec[1], 0);
  facing_yaw_vec = (facing_vec[0], facing_vec[1], 0);
  enemy_yaw_vec = vectorNormalize(enemy_yaw_vec);
  facing_yaw_vec = vectorNormalize(facing_yaw_vec);
  enemy_dot = vectordot(facing_yaw_vec, enemy_yaw_vec);

  if(enemy_dot < 0) {
    return false;
  }

  return true;
}

function mechzshouldmelee(entity) {
  if(!isDefined(entity.enemy)) {
    return false;
  }

  if(distancesquared(entity.origin, entity.enemy.origin) > 12544) {
    return false;
  }

  if(is_true(entity.enemy.usingvehicle)) {
    return true;
  }

  yaw = abs(zombie_utility::getyawtoenemy());

  if(yaw > 45) {
    return false;
  }

  return true;
}

function private mechzshouldshowpain(entity) {
  if(entity.partdestroyed === 1) {
    return true;
  }

  return false;
}

function private mechzshouldshowjetpackpain(entity) {
  if(entity.var_97601164 === 1) {
    return true;
  }

  return false;
}

function private mechzenemyinaim(entity) {
  if(entity mechzserverutils::mechzcheckinarc()) {
    return true;
  }

  return false;
}

function private mechzenemynotinaim(entity) {
  return !mechzenemyinaim(entity);
}

function mechzshouldshootgrenade(entity) {
  if(entity.berserk === 1) {
    return false;
  }

  if(entity.gun_attached !== 1) {
    return false;
  }

  if(is_true(entity.var_10552fac)) {
    return false;
  }

  if(entity.var_9329a57c > gettime()) {
    return false;
  }

  if(is_true(self.ignoreall)) {
    return false;
  }

  if(isDefined(self.var_bfd4c4c4) || isDefined(self.var_6da37a9a)) {
    return false;
  }

  enemy = zm_ai_utility::function_825317c(entity);

  if(!isDefined(enemy)) {
    return false;
  }

  if(!isDefined(entity.burstgrenadesfired) || entity.burstgrenadesfired >= 1) {
    return false;
  }

  if(entity.activegrenades >= 3) {
    return false;
  }

  if(!entity cansee(enemy)) {
    var_b51839b1 = 0;

    if(isPlayer(enemy) && enemy isinvehicle()) {
      vehicle = enemy getvehicleoccupied();
      var_b51839b1 = entity cansee(vehicle);
    }

    if(!var_b51839b1) {
      return false;
    }
  }

  dist_sq = distancesquared(entity.origin, enemy.origin);

  if(dist_sq < 62500 || dist_sq > 1440000) {
    return false;
  }

  if(!mechzenemyinaim(self)) {
    return false;
  }

  return true;
}

function mechzshouldshootflame(entity) {
  if(is_true(entity.shoot_flame)) {
    return true;
  }

  if(entity.berserk === 1) {
    return false;
  }

  if(is_true(entity.isshootingflame) && gettime() < entity.stopshootingflametime) {
    return true;
  }

  enemy = is_true(entity.var_1fa24724) ? entity.enemy : entity.favoriteenemy;

  if(!isDefined(enemy)) {
    return false;
  }

  if(entity.isshootingflame === 1 && entity.stopshootingflametime <= gettime()) {
    return false;
  }

  if(entity.nextflametime > gettime() || entity.var_9329a57c > gettime()) {
    return false;
  }

  if(!entity mechzserverutils::mechzcheckinarc(26)) {
    return false;
  }

  var_52ef606d = !is_true(entity.var_1fa24724) && isDefined(enemy) && abs(entity.origin[2] - enemy.origin[2]) < 60;
  dist_sq = distancesquared(entity.origin, enemy.origin);

  if(var_52ef606d && dist_sq < 9216 || dist_sq > 90000) {
    return false;
  }

  in_vehicle = isPlayer(enemy) && enemy isinvehicle();
  can_see = bullettracepassed(entity.origin + (0, 0, 36), enemy.origin + (0, 0, 36), 0, undefined);

  if(!can_see && !in_vehicle) {
    entity.nextflametime = gettime() + 2500;
    return false;
  }

  return true;
}

function private mechzshouldshootflamesweep(entity) {
  if(entity.berserk === 1) {
    return false;
  }

  if(!mechzshouldshootflame(entity)) {
    return false;
  }

  if(randomint(100) > 10) {
    return false;
  }

  near_players = 0;
  players = getPlayers(undefined, entity.origin, 100);

  if(players.size < 2) {
    return false;
  }

  return true;
}

function private mechzshouldturnberserk(entity) {
  if(entity.berserk === 1 && entity.hasturnedberserk !== 1) {
    return true;
  }

  if(is_true(entity.var_10552fac) && !is_true(entity.berserk) && !is_true(entity.hasturnedberserk)) {
    return true;
  }

  return false;
}

function private mechzshouldstumble(entity) {
  if(is_true(entity.stumble)) {
    return true;
  }

  return false;
}

function mechzisinsafezone(entity) {
  if(!isDefined(entity.favoriteenemy)) {
    return false;
  }

  distsqr = distancesquared(entity.origin, entity.favoriteenemy.origin);

  if(distsqr < 360000 && distsqr > 50625) {
    return true;
  }

  return false;
}

function mechzshouldturninplacebeforeidle(entity) {
  enemy = is_true(entity.var_1fa24724) ? entity.enemy : entity.favoriteenemy;

  if(!isDefined(enemy)) {
    return false;
  }

  if(entity mechzserverutils::mechzcheckinarc(26)) {
    return false;
  }

  return true;
}

function private mechzshootgrenadeaction(entity, asmstatename) {
  animationstatenetworkutility::requeststate(entity, asmstatename);
  entity.grenadestarttime = gettime() + 3000;
  return 5;
}

function private mechzshootgrenadeactionupdate(entity, asmstatename) {
  if(!is_true(asmstatename.shoot_grenade)) {
    return 4;
  }

  return 5;
}

function private mechzstumblestart(entity, asmstatename) {
  animationstatenetworkutility::requeststate(entity, asmstatename);
  entity.stumbletime = gettime() + 500;
  return 5;
}

function private mechzstumbleupdate(entity, asmstatename) {
  if(gettime() > asmstatename.stumbletime) {
    return 4;
  }

  return 5;
}

function private mechzstumbleend(entity, asmstatename) {
  asmstatename.stumble = 0;
  asmstatename.stumble_stun_cooldown_time = gettime() + 10000;
  return 4;
}

function mechzshootflameactionstart(entity, asmstatename) {
  animationstatenetworkutility::requeststate(entity, asmstatename);
  mechzshootflame(entity);
  entity.blindaim = 1;
  return 5;
}

function mechzshootflameactionupdate(entity, asmstatename) {
  if(is_true(asmstatename.berserk)) {
    mechzstopflame(asmstatename);
    return 4;
  }

  var_5e55975f = isDefined(self.var_5e55975f) ? self.var_5e55975f : &mechzshouldmelee;

  if(is_true([[var_5e55975f]](asmstatename))) {
    mechzstopflame(asmstatename);
    return 4;
  }

  if(is_true(asmstatename.isshootingflame)) {
    if(isDefined(asmstatename.stopshootingflametime) && gettime() > asmstatename.stopshootingflametime) {
      mechzstopflame(asmstatename);
      return 4;
    }

    mechzupdateflame(asmstatename);
  }

  return 5;
}

function mechzshootflameactionend(entity, asmstatename) {
  mechzstopflame(asmstatename);
  asmstatename.blindaim = 0;
  return 4;
}

function private mechzpreptoshootgrenadestart(entity) {
  entity.blindaim = 1;
  return true;
}

function private mechzpreptoshootgrenadesterminate(entity) {
  entity.blindaim = 0;
  return true;
}

function private mechzshootgrenadestart(entity) {
  entity.burstgrenadesfired++;

  if(entity.burstgrenadesfired >= 1) {
    entity.nextgrenadetime = gettime() + 6000;
  }

  entity.blindaim = 1;
  return true;
}

function private mechzshootgrenadeterminate(entity) {
  entity.blindaim = 0;
  entity clearpath();
  entity setgoal(entity.origin);

  if(isDefined(entity.var_9d92b55a)) {
    [[entity.var_9d92b55a]](entity);
  }

  entity.var_9329a57c = gettime() + 2000;
  return true;
}

function private mechzsetspeedwalk(entity) {
  entity setblackboardattribute("_locomotion_speed", "locomotion_speed_walk");
}

function private mechzsetspeedrun(entity) {
  entity setblackboardattribute("_locomotion_speed", "locomotion_speed_run");
}

function private mechzshootflame(entity) {
  entity thread mechzdelayflame();
}

function private mechzdelayflame() {
  self endon(#"death");
  self notify(#"mechzdelayflame");
  self endon(#"mechzdelayflame");
  wait 0.3;
  self clientfield::set("mechz_ft", 1);
  self.isshootingflame = 1;
  self.stopshootingflametime = gettime() + 2500;
}

function private mechzupdateflame(entity) {
  if(!isDefined(entity.flametrigger)) {
    return;
  }

  if(isDefined(level.mechz_flamethrower_player_callback)) {
    [[level.mechz_flamethrower_player_callback]](entity);
  } else {
    players = getPlayers();

    foreach(player in players) {
      var_86d02e70 = 0;

      if(player isinvehicle()) {
        vehicle = player getvehicleoccupied();
        var_86d02e70 = is_true(vehicle.var_9a6644f2);
      }

      if(!is_true(player.is_burning) && !is_true(var_86d02e70)) {
        if(player istouching(entity.flametrigger)) {
          if(isDefined(entity.mechzflamedamage)) {
            player thread[[entity.mechzflamedamage]]();
            continue;
          }

          player thread playerflamedamage(entity);
        }
      }
    }

    if(!isDefined(entity.var_15978c43)) {
      entity.var_15978c43 = [];
    }

    if(!isDefined(entity.var_22dae8df)) {
      entity.var_22dae8df = -1;
    }

    if(entity.var_22dae8df < gettime()) {
      entity.var_22dae8df = gettime() + 500;
      entity.var_15978c43 = getentitiesinradius(entity.origin, 300, 12);
    }

    foreach(vehicle in entity.var_15978c43) {
      if(isvehicle(vehicle) && vehicle istouching(entity.flametrigger)) {
        vehicle thread function_fd99ea48(entity);

        if(!is_true(vehicle.var_9a6644f2)) {
          occupants = vehicle getvehoccupants();

          foreach(occupant in occupants) {
            if(!is_true(occupant.burning)) {
              occupant thread playerflamedamage(entity);
            }
          }
        }
      }
    }
  }

  if(isDefined(level.mechz_flamethrower_ai_callback)) {
    [[level.mechz_flamethrower_ai_callback]](entity);
  }
}

function playerflamedamage(mechz) {
  self endon(#"death");
  self endon(#"disconnect");

  if(!is_true(self.is_burning) && zombie_utility::is_player_valid(self, 1)) {
    self.is_burning = 1;

    if(!self hasperk("specialty_armorvest")) {
      self burnplayer::setplayerburning(1.5, 0.5, 30, mechz, undefined, 1);
    } else {
      self burnplayer::setplayerburning(1.5, 0.5, 20, mechz, undefined, 1);
    }

    wait 1.5;
    self.is_burning = 0;
  }
}

function function_fd99ea48(mechz) {
  self endon(#"death");
  self endon(#"disconnect");
  tick_rate = 0.25;

  if(!is_true(self.is_burning)) {
    self.is_burning = 1;
    percentage = 0;

    while(percentage <= 1) {
      self dodamage(250 * tick_rate, self.origin, mechz, undefined, undefined, "MOD_BURNED", 0);
      wait 1.5 * tick_rate;
      percentage += tick_rate;
    }

    self.is_burning = 0;
  }
}

function mechzstopflame(entity) {
  self notify(#"mechzdelayflame");
  entity clientfield::set("mechz_ft", 0);
  entity.isshootingflame = 0;
  var_82d51e42 = randomintrange(2500, 3500);
  entity.nextflametime = gettime() + var_82d51e42;
  entity.var_9329a57c = gettime() + 2000;
  entity.stopshootingflametime = undefined;
}

function mechzgoberserk() {
  entity = self;
  g_time = gettime();
  entity.berserkendtime = g_time + 10000;

  if(entity.berserk !== 1) {
    entity.berserk = 1;
    entity thread mechzendberserk();
    entity setblackboardattribute("_locomotion_speed", "locomotion_speed_sprint");
  }
}

function private mechzplayedberserkintro(entity) {
  entity.hasturnedberserk = 1;
}

function private mechzendberserk() {
  self endon(#"death");
  self endon(#"disconnect");

  while(self.berserk === 1) {
    if(gettime() >= self.berserkendtime) {
      self.berserk = 0;
      self.hasturnedberserk = 0;

      if(!isDefined(self.var_19ec2cc3)) {
        self asmsetanimationrate(1);
      }

      self setblackboardattribute("_locomotion_speed", "locomotion_speed_run");
    }

    wait 0.25;
  }
}

function private mechzattackstart(entity) {
  entity clientfield::set("mechz_face", 1);
}

function private mechzdeathstart(entity) {
  entity clientfield::set("mechz_face", 2);
}

function private mechzidlestart(entity) {
  entity clientfield::set("mechz_face", 3);
}

function private mechzpainstart(entity) {
  entity clientfield::set("mechz_face", 4);
}

function private mechzpainterminate(entity) {
  entity.partdestroyed = 0;
  entity.show_pain_from_explosive_dmg = undefined;
}

function private mechzjetpackpainterminate(entity) {
  entity.var_97601164 = 0;
  mechzpainterminate(entity);
}

#namespace mechzserverutils;

function private mechzspawnsetup() {
  self.disableammodrop = 1;
  self.no_gib = 1;
  self.ignore_nuke = 1;
  self.ignore_enemy_count = 1;
  self.ignore_round_robbin_death = 1;
  self.var_1c0eb62a = 180;
  self.zombie_move_speed = "run";
  self setblackboardattribute("_locomotion_speed", "locomotion_speed_run");
  self.var_cccb0ad2 = 1;
  self.grenadecount = 3;
  self.nextflametime = gettime();
  self.stumble_stun_cooldown_time = gettime();
  self.var_9329a57c = gettime();
  self.var_e9c62827 = 1;
  self weaponobjects::createwatcher("eq_mechz_firebomb", &function_d0651b24, 1);

  self.debug_traversal_ast = "<dev string:x38>";

  self.flametrigger = spawn("trigger_box", self.origin, 0, 700, 50, 25);
  self thread deleteondeath(self.flametrigger);
  self.flametrigger enablelinkTo();
  self.flametrigger.origin = self gettagorigin("tag_flamethrower_fx");
  self.flametrigger.angles = self gettagangles("tag_flamethrower_fx");
  self.flametrigger linkTo(self, "tag_flamethrower_fx");
  self thread weaponobjects::watchweaponobjectspawn();
  self.pers = [];
  self.pers[#"team"] = self.team;
  self destructserverutils::togglespawngibs(self, 1);
  self.var_28621cf4 = "j_neck";
  self.var_e5365d8a = (0, 0, 6);
  aiutility::addaioverridedamagecallback(self, &mechzdamagecallback);
  self thread function_fe2419fc();
  self namespace_47c5b560::function_904442b2();
  self.var_6d409ca1 = &function_6d409ca1;
  self callback::function_d8abfc3d(#"hash_69106b41ba3763f7", &function_9d12d0d2);
  level thread zm_spawner::zombie_death_event(self);
}

function private function_6d409ca1() {
  if(is_true(self.favoriteenemy.ignoreme)) {
    return undefined;
  }

  return self.favoriteenemy;
}

function function_5d873f78() {
  self mechzaddattachments();
  namespace_81245006::initweakpoints(self);
  self.completed_emerging_into_playable_area = 1;
  self.canbetargetedbyturnedzombies = 1;
}

function function_d0651b24(watcher) {
  mechzfirebomb::function_5545649e(watcher);
}

function deleteondeath(object) {
  self waittill(#"death");

  if(isDefined(object)) {
    object delete();
  }
}

function private mechzflamewatcher() {
  self endon(#"death");

  while(true) {
    if(isDefined(self.favoriteenemy)) {
      if(self.flametrigger istouching(self.favoriteenemy)) {
        printtoprightln("<dev string:x4a>");
      }
    }

    waitframe(1);
  }
}

function private mechzaddattachments() {
  self.var_7c4488fd = 1;
  self.gun_attached = 1;
  self.has_faceplate = 1;
  self.has_powercap = 1;
  self.powercap_covered = 1;
}

function mechzdamagecallback(inflictor, attacker, damage, dflags, mod, weapon, var_fd90b0bb, point, dir, hitloc, offsettime, boneindex, modelindex) {
  if(damage === self || !util::function_fbce7263(damage.team, self.team)) {
    return 0;
  }

  if(isDefined(self.b_flyin_done) && !is_true(self.b_flyin_done)) {
    return 0;
  }

  if(self flag::get("kill_hvt_teleporting")) {
    weakpoint = namespace_81245006::function_3131f5dd(self, hitloc, 1);
    self.var_6936b30b = {
      #weakpoint: weakpoint, #var_ebcff177: 4
    };
    return 0;
  }

  if(is_true(self.stumble)) {
    if(self.stumble_stun_cooldown_time < gettime() && !is_true(self.berserk)) {
      self[[level.mechz_should_stun_override]](attacker, damage, dflags, mod, weapon, var_fd90b0bb, point, dir, hitloc, offsettime, boneindex, modelindex);
    }
  }

  dflags = mechzweapondamagemodifier(dflags, var_fd90b0bb);

  if(isDefined(level.mechz_damage_override)) {
    dflags = [[level.mechz_damage_override]](damage, dflags);
  }

  if(!isDefined(self.next_pain_time) || gettime() >= self.next_pain_time) {
    self thread mechz_play_pain_audio();
    self.next_pain_time = gettime() + 250 + randomint(500);
  }

  if(isDefined(self.damage_scoring_function)) {
    self[[self.damage_scoring_function]](attacker, damage, dflags, mod, weapon, var_fd90b0bb, point, dir, hitloc, offsettime, boneindex, modelindex);
  }

  if(is_true(level.var_85a39c96)) {
    return (self.health + 1);
  }

  damage_type = 1;

  if(namespace_81245006::hasarmor(self) && (weapon === "MOD_PROJECTILE_SPLASH" || weapon === "MOD_GRENADE_SPLASH" || weapon == "MOD_EXPLOSIVE")) {
    var_3cddb028 = 0.5 * dflags;
    var_31e96b81 = int(var_3cddb028);

    foreach(weakpoint in self.var_5ace757d) {
      if(weakpoint.type === #"armor" && weakpoint.currstate === 1) {
        function_669e8e27(self, weakpoint, damage, dflags, var_fd90b0bb, weapon, attacker);
      }
    }
  }

  weakpoint = namespace_81245006::function_3131f5dd(self, hitloc, 1);

  if(!isDefined(weakpoint)) {
    weakpoint = namespace_81245006::function_73ab4754(self, point, 1);
  }

  if(weakpoint.var_3765e777 === 1 && aiutility::function_e2278a4b(var_fd90b0bb, weapon)) {
    damage show_hit_marker();
    dflags = int(dflags * 1);

    iprintlnbold("<dev string:x56>" + dflags + "<dev string:x64>" + self.health - dflags);

    damage_type = 2;
  }

  if(hitloc !== "none") {
    iprintlnbold("<dev string:x6e>" + dflags + "<dev string:x64>" + self.health - dflags);
  } else if(weapon == "MOD_PROJECTILE" || weapon == "MOD_GRENADE") {
    dflags = int(dflags * 2);

    iprintlnbold("<dev string:x7f>" + dflags + "<dev string:x64>" + self.health - dflags);
  } else if(weapon == "MOD_PROJECTILE_SPLASH" || weapon == "MOD_BURNED" || weapon == "MOD_GRENADE_SPLASH" || weapon == "MOD_EXPLOSIVE") {
    dflags = int(dflags * 3);

    iprintlnbold("<dev string:x93>" + dflags + "<dev string:x64>" + self.health - dflags);
  } else if(weapon == "MOD_CRUSH") {
    iprintlnbold("<dev string:xae>" + dflags + "<dev string:x64>" + self.health - dflags);
  }

  if(!isDefined(weakpoint)) {
    weakpoint = namespace_81245006::function_37e3f011(self, boneindex, 1);
  }

  if(isDefined(weakpoint)) {
    var_6dd5345c = function_669e8e27(self, weakpoint, damage, dflags, var_fd90b0bb, weapon, attacker);

    if(isDefined(var_6dd5345c)) {
      damage_type = var_6dd5345c;

      if(damage_type == 3) {
        dflags *= 0.75;

        if(isDefined(level.var_1b01acb4)) {
          dflags *= [[level.var_1b01acb4]](self, var_fd90b0bb, damage);
        }
      }
    }
  }

  if(!aiutility::function_493e5914(weapon)) {
    point = aiutility::function_cb552839(self);
  }

  if(killstreaks::is_killstreak_weapon(var_fd90b0bb)) {
    damage_type = 1;
  }

  self.var_6936b30b = {
    #weakpoint: weakpoint, #var_ebcff177: damage_type
  };
  return dflags;
}

function private function_669e8e27(entity, weakpoint, attacker, damage, weapon, mod, inflictor) {
  var_6dd5345c = undefined;

  if(weakpoint.type === #"weakpoint") {
    var_6dd5345c = 2;
    namespace_81245006::damageweakpoint(weakpoint, damage);

    if(namespace_81245006::function_f29756fe(weakpoint) === 3 && isDefined(weakpoint.var_f371ebb0)) {
      destructserverutils::function_8475c53a(entity, weakpoint.var_f371ebb0);

      if(weakpoint.var_f371ebb0 == "left_arm_armor") {
        scoreevent = "mechz_power_core_destroyed_zm";
        entity function_39d47bef(attacker, weapon, mod, inflictor);
      }
    }

    level scoreevents::doscoreeventcallback("scoreEventZM", {
      #attacker: attacker, #scoreevent: "hit_weak_point_zm"});
  } else if(weakpoint.type === #"armor") {
    var_6dd5345c = 3;
    damage_mod = 1;

    if(isDefined(level.var_56f626bc)) {
      damage_mod = [[level.var_56f626bc]](entity, weapon, attacker);
    }

    damage *= damage_mod;
    namespace_81245006::damageweakpoint(weakpoint, damage);

    if(namespace_81245006::function_f29756fe(weakpoint) === 3 && isDefined(weakpoint.var_f371ebb0)) {
      destructserverutils::function_8475c53a(entity, weakpoint.var_f371ebb0);
      scoreevent = "destroyed_armor_zm";

      if(weakpoint.var_f371ebb0 == "helmet") {
        entity function_40c68562();
      }

      if(weakpoint.var_f371ebb0 == "jet_pack") {
        entity function_4c489c31(attacker);
        scoreevent = "mechz_jetpack_destroyed_zm";
      }

      if(weakpoint.var_f371ebb0 == "power_core_cover") {
        entity function_3ebf4258();
      }

      level scoreevents::doscoreeventcallback("scoreEventZM", {
        #attacker: attacker, #scoreevent: scoreevent
      });
    }
  }

  return var_6dd5345c;
}

function private mechzweapondamagemodifier(damage, weapon) {
  if(isDefined(weapon) && isDefined(weapon.name)) {
    if(weapon.name == #"eq_mechz_firebomb") {
      return 0;
    }

    if(weapon.name == #"molotov_fire") {
      return 0;
    }
  }

  return damage;
}

function mechz_play_pain_audio() {
  self playSound("zmb_ai_mechz_destruction");
}

function show_hit_marker() {
  self util::show_hit_marker();
}

function hide_part(strtag) {
  if(self haspart(strtag)) {
    self hidepart(strtag);
  }
}

function function_40c68562() {
  self clientfield::set("mechz_faceplate_detached", 1);
  self.has_faceplate = 0;
  self mechz_turn_off_headlamp();
  self.partdestroyed = 1;
  self setblackboardattribute("_mechz_part", "mechz_faceplate");
  self mechzbehavior::mechzgoberserk();
  level notify(#"mechz_faceplate_detached");
}

function function_3ebf4258() {
  self clientfield::set("mechz_powercap_detached", 1);
  self.powercap_covered = 0;
  self.partdestroyed = 1;
  self setblackboardattribute("_mechz_part", "mechz_powercore");
}

function function_39d47bef(attacker, weapon, mod, inflictor) {
  self clientfield::set("mechz_claw_detached", 1);
  self.has_powercap = 0;
  self.gun_attached = 0;
  self.partdestroyed = 1;
  self setblackboardattribute("_mechz_part", "mechz_gun");
  level notify(#"mechz_gun_detached");
  var_4f88297a = self.maxhealth * 0.1;
  self zombie_utility::function_6975aa10(weapon);
  self dodamage(var_4f88297a, self.origin, attacker, inflictor, "none", mod, 0, weapon);
}

function function_4c489c31(attacker) {
  self hide_part("j_jetpack");
  self clientfield::set("mechz_jetpack_explosion", 1);
  self.var_7c4488fd = 0;
  self.var_97601164 = 1;
  self.partdestroyed = 1;

  if(isPlayer(attacker)) {
    attacker.var_6de2953f = gettime();
  }

  self radiusdamage(self.origin + (0, 0, 36), 128, 150, 95, attacker, "MOD_EXPLOSIVE");

  if(isDefined(self.var_bacf9a1a)) {
    self thread[[self.var_bacf9a1a]](attacker);
  }
}

function mechzcheckinarc(right_offset, aim_tag, var_40f25562 = 0.5) {
  origin = self.origin;
  angles = self.angles;

  if(isDefined(aim_tag)) {
    origin = self gettagorigin(aim_tag);
    angles = self gettagangles(aim_tag);
  }

  if(isDefined(right_offset)) {
    right_angle = anglestoright(angles);
    origin += right_angle * right_offset;
  }

  facing_vec = anglesToForward(angles);
  enemy = is_true(self.var_1fa24724) ? self.enemy : self.favoriteenemy;

  if(!isDefined(enemy)) {
    return false;
  }

  enemy_vec = enemy.origin - origin;
  enemy_yaw_vec = (enemy_vec[0], enemy_vec[1], 0);
  facing_yaw_vec = (facing_vec[0], facing_vec[1], 0);
  enemy_yaw_vec = vectorNormalize(enemy_yaw_vec);
  facing_yaw_vec = vectorNormalize(facing_yaw_vec);
  enemy_dot = vectordot(facing_yaw_vec, enemy_yaw_vec);

  if(enemy_dot < var_40f25562) {
    return false;
  }

  enemy_angles = vectortoangles(enemy_vec);

  if(!is_true(self.var_1fa24724) && abs(angleclamp180(enemy_angles[0])) > 60) {
    return false;
  }

  return true;
}

function mechz_turn_off_headlamp(headlamp_broken) {
  if(headlamp_broken !== 1) {
    self clientfield::set("mechz_headlamp_off", 1);
    return;
  }

  self clientfield::set("mechz_headlamp_off", 2);
}

function function_fe2419fc() {
  self.var_b467f3a1 = &function_53f176ae;
  self thread function_fb451f53();
}

function function_53f176ae(eventstruct) {
  if(!is_true(level.var_2356dff1)) {
    return;
  }

  notify_string = eventstruct.action;
  str_alias = notify_string;
  b_override = 0;
  n_priority = 1;
  var_c8109157 = 0;

  switch (notify_string) {
    case #"arrive":
    case #"death":
      b_override = 1;
      n_priority = 4;
      break;
    case #"pain":
    case #"land":
    case #"weapon_fire":
      b_override = 1;
      n_priority = 3;
      break;
    case #"summon":
    case #"stun_stunned":
    case #"enrage":
    case #"pain_jetpack":
    case #"melee_notetrack_2":
      b_override = 1;
      n_priority = 3;
      var_c8109157 = 1;
      break;
    case #"alerted":
    case #"melee_notetrack":
    case #"stun_intro":
    case #"jump":
    case #"lose_enemy":
      b_override = 1;
      n_priority = 2;
      var_c8109157 = 1;
      break;
    case #"ambient":
    case #"ambient_enraged":
    case #"ambient_alert":
      n_priority = 1;
      break;
    case #"attack_melee":
      return;
    default:
      n_priority = 2;
      break;
  }

  level thread zm_audio::zmbaivox_playvox(self, str_alias, b_override, n_priority, var_c8109157);
}

function function_fb451f53() {
  self endon(#"death");
  str_notify = "ambient";

  while(true) {
    min_wait = 2;
    max_wait = 5;

    if(is_true(self.berserk) || is_true(self.var_e8f3d773)) {
      str_notify = "ambient_enraged";
    } else if(isDefined(self.zombie_move_speed) && self.zombie_move_speed === "run") {
      str_notify = "ambient_enraged";
    } else if(isDefined(self.awarenesslevelcurrent) && self.awarenesslevelcurrent === "combat") {
      str_notify = "ambient_alert";
    } else {
      str_notify = "ambient";
    }

    bhtnactionstartevent(self, str_notify);
    self notify(#"bhtn_action_notify", {
      #action: str_notify
    });
    wait randomfloatrange(min_wait, max_wait);
  }
}

function function_9d12d0d2(params) {
  self mechzbehavior::mechzgoberserk();
}