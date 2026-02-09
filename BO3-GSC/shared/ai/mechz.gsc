/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\mechz.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\_burnplayer;
#using scripts\shared\ai\archetype_mocomps_utility;
#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\systems\animation_state_machine_mocomp;
#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\systems\debug;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\shared\weapons\_weaponobjects;
#namespace mechzbehavior;

function autoexec init() {
  initmechzbehaviorsandasm();
  spawner::add_archetype_spawn_function("mechz", &archetypemechzblackboardinit);
  spawner::add_archetype_spawn_function("mechz", &mechzserverutils::mechzspawnsetup);
  clientfield::register("actor", "mechz_ft", 5000, 1, "int");
  clientfield::register("actor", "mechz_faceplate_detached", 5000, 1, "int");
  clientfield::register("actor", "mechz_powercap_detached", 5000, 1, "int");
  clientfield::register("actor", "mechz_claw_detached", 5000, 1, "int");
  clientfield::register("actor", "mechz_115_gun_firing", 5000, 1, "int");
  clientfield::register("actor", "mechz_rknee_armor_detached", 5000, 1, "int");
  clientfield::register("actor", "mechz_lknee_armor_detached", 5000, 1, "int");
  clientfield::register("actor", "mechz_rshoulder_armor_detached", 5000, 1, "int");
  clientfield::register("actor", "mechz_lshoulder_armor_detached", 5000, 1, "int");
  clientfield::register("actor", "mechz_headlamp_off", 5000, 2, "int");
  clientfield::register("actor", "mechz_face", 1, 3, "int");
}

function private initmechzbehaviorsandasm() {
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzTargetService", &mechztargetservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzGrenadeService", &mechzgrenadeservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzBerserkKnockdownService", &mechzberserkknockdownservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldMelee", &mechzshouldmelee);
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldShowPain", &mechzshouldshowpain);
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldShootGrenade", &mechzshouldshootgrenade);
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldShootFlame", &mechzshouldshootflame);
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldShootFlameSweep", &mechzshouldshootflamesweep);
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldTurnBerserk", &mechzshouldturnberserk);
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldStun", &mechzshouldstun);
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldStumble", &mechzshouldstumble);
  behaviortreenetworkutility::registerbehaviortreeaction("mechzStunLoop", &mechzstunstart, &mechzstunupdate, &mechzstunend);
  behaviortreenetworkutility::registerbehaviortreeaction("mechzStumbleLoop", &mechzstumblestart, &mechzstumbleupdate, &mechzstumbleend);
  behaviortreenetworkutility::registerbehaviortreeaction("mechzShootFlameAction", &mechzshootflameactionstart, &mechzshootflameactionupdate, &mechzshootflameactionend);
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShootGrenade", &mechzshootgrenade);
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShootFlame", &mechzshootflame);
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzUpdateFlame", &mechzupdateflame);
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzStopFlame", &mechzstopflame);
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzPlayedBerserkIntro", &mechzplayedberserkintro);
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzAttackStart", &mechzattackstart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzDeathStart", &mechzdeathstart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzIdleStart", &mechzidlestart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzPainStart", &mechzpainstart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("mechzPainTerminate", &mechzpainterminate);
  animationstatenetwork::registernotetrackhandlerfunction("melee_soldat", &mechznotetrackmelee);
  animationstatenetwork::registernotetrackhandlerfunction("fire_chaingun", &mechznotetrackshootgrenade);
}

function private archetypemechzblackboardinit() {
  blackboard::createblackboardforentity(self);
  self aiutility::registerutilityblackboardattributes();
  blackboard::registerblackboardattribute(self, "_locomotion_speed", "locomotion_speed_run", undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_locomotion_should_turn", "should_not_turn", &bb_getshouldturn);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_zombie_damageweapon_type", "regular", undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_mechz_part", "mechz_powercore", undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  self.___archetypeonanimscriptedcallback = &archetypemechzonanimscriptedcallback;
  self finalizetrackedblackboardattributes();
}

function private archetypemechzonanimscriptedcallback(entity) {
  entity.__blackboard = undefined;
  entity archetypemechzblackboardinit();
}

function private bb_getshouldturn() {
  if(isDefined(self.should_turn) && self.should_turn) {
    return "should_turn";
  }
  return "should_not_turn";
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
  base_target_pos = base_target_pos + (v_velocity * 1.5);
  target_pos_offset_x = math::randomsign() * randomint(32);
  target_pos_offset_y = math::randomsign() * randomint(32);
  target_pos = base_target_pos + (target_pos_offset_x, target_pos_offset_y, 0);
  dir = vectortoangles(target_pos - entity.origin);
  dir = anglesToForward(dir);
  launch_offset = dir * 5;
  launch_pos = entity gettagorigin("tag_gun_barrel2") + launch_offset;
  dist = distance(launch_pos, target_pos);
  velocity = dir * dist;
  velocity = velocity + vectorscale((0, 0, 1), 120);
  val = 1;
  oldval = entity clientfield::get("mechz_115_gun_firing");
  if(oldval === val) {
    val = 0;
  }
  entity clientfield::set("mechz_115_gun_firing", val);
  entity magicgrenadetype(getweapon("electroball_grenade"), launch_pos, velocity);
  playsoundatposition("wpn_grenade_fire_mechz", entity.origin);
}

function mechztargetservice(entity) {
  if(isDefined(entity.ignoreall) && entity.ignoreall) {
    return false;
  }
  if(isDefined(entity.destroy_octobomb)) {
    return false;
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
    if(isDefined(level.b_mechz_true_ignore) && level.b_mechz_true_ignore) {
      entity setgoal(entity.origin);
      return false;
    }
    if(isDefined(level.no_target_override)) {
      [[level.no_target_override]](entity);
    } else {
      entity setgoal(entity.origin);
    }
    return false;
  }
  if(isDefined(level.enemy_location_override_func)) {
    enemy_ground_pos = [[level.enemy_location_override_func]](entity, player);
    if(isDefined(enemy_ground_pos)) {
      entity setgoal(enemy_ground_pos);
      return true;
    }
  }
  targetpos = getclosestpointonnavmesh(player.origin, 64, 30);
  if(isDefined(targetpos)) {
    entity setgoal(targetpos);
    return true;
  }
  entity setgoal(entity.origin);
  return false;
}

function private mechzgrenadeservice(entity) {
  if(!isDefined(entity.burstgrenadesfired)) {
    entity.burstgrenadesfired = 0;
  }
  if(entity.burstgrenadesfired >= 3) {
    if(gettime() > entity.nextgrenadetime) {
      entity.burstgrenadesfired = 0;
    }
  }
  if(isDefined(level.a_electroball_grenades)) {
    level.a_electroball_grenades = array::remove_undefined(level.a_electroball_grenades);
    a_active_grenades = array::filter(level.a_electroball_grenades, 0, &mechzfiltergrenadesbyowner, entity);
    entity.activegrenades = a_active_grenades.size;
  } else {
    entity.activegrenades = 0;
  }
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
  predicted_pos = entity.origin + (velocity * predict_time);
  move_dist_sq = distancesquared(predicted_pos, entity.origin);
  speed = move_dist_sq / predict_time;
  if(speed >= 10) {
    a_zombies = getaiarchetypearray("zombie");
    a_filtered_zombies = array::filter(a_zombies, 0, &mechzzombieeligibleforberserkknockdown, entity, predicted_pos);
    if(a_filtered_zombies.size > 0) {
      foreach(zombie in a_filtered_zombies) {
        zombie.knockdown = 1;
        zombie.knockdown_type = "knockdown_shoved";
        zombie_to_mechz = entity.origin - zombie.origin;
        zombie_to_mechz_2d = vectornormalize((zombie_to_mechz[0], zombie_to_mechz[1], 0));
        zombie_forward = anglesToForward(zombie.angles);
        zombie_forward_2d = vectornormalize((zombie_forward[0], zombie_forward[1], 0));
        zombie_right = anglestoright(zombie.angles);
        zombie_right_2d = vectornormalize((zombie_right[0], zombie_right[1], 0));
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
  if(zombie.knockdown === 1) {
    return false;
  }
  knockdown_dist_sq = 2304;
  dist_sq = distancesquared(predicted_pos, zombie.origin);
  if(dist_sq > knockdown_dist_sq) {
    return false;
  }
  if(zombie.is_immune_to_knockdown === 1) {
    return false;
  }
  origin = mechz.origin;
  facing_vec = anglesToForward(mechz.angles);
  enemy_vec = zombie.origin - origin;
  enemy_yaw_vec = (enemy_vec[0], enemy_vec[1], 0);
  facing_yaw_vec = (facing_vec[0], facing_vec[1], 0);
  enemy_yaw_vec = vectornormalize(enemy_yaw_vec);
  facing_yaw_vec = vectornormalize(facing_yaw_vec);
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
  if(isDefined(entity.enemy.usingvehicle) && entity.enemy.usingvehicle) {
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

function private mechzshouldshootgrenade(entity) {
  if(entity.berserk === 1) {
    return false;
  }
  if(entity.gun_attached !== 1) {
    return false;
  }
  if(!isDefined(entity.favoriteenemy)) {
    return false;
  }
  if(entity.burstgrenadesfired >= 3) {
    return false;
  }
  if(entity.activegrenades >= 9) {
    return false;
  }
  if(!entity mechzserverutils::mechzgrenadecheckinarc()) {
    return false;
  }
  if(!entity cansee(entity.favoriteenemy)) {
    return false;
  }
  dist_sq = distancesquared(entity.origin, entity.favoriteenemy.origin);
  if(dist_sq < 62500 || dist_sq > 1440000) {
    return false;
  }
  return true;
}

function private mechzshouldshootflame(entity) {
  if(isDefined(entity.shoot_flame) && entity.shoot_flame) {
    return true;
  }
  if(entity.berserk === 1) {
    return false;
  }
  if(isDefined(entity.isshootingflame) && entity.isshootingflame && gettime() < entity.stopshootingflametime) {
    return true;
  }
  if(!isDefined(entity.favoriteenemy)) {
    return false;
  }
  if(entity.isshootingflame === 1 && entity.stopshootingflametime <= gettime()) {
    return false;
  }
  if(entity.nextflametime > gettime()) {
    return false;
  }
  if(!entity mechzserverutils::mechzcheckinarc(26, "tag_flamethrower_fx")) {
    return false;
  }
  dist_sq = distancesquared(entity.origin, entity.favoriteenemy.origin);
  if(dist_sq < 9216 || dist_sq > 50625) {
    return false;
  }
  can_see = bullettracepassed(entity.origin + vectorscale((0, 0, 1), 36), entity.favoriteenemy.origin + vectorscale((0, 0, 1), 36), 0, undefined);
  if(!can_see) {
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
  players = getplayers();
  foreach(player in players) {
    if(distance2dsquared(entity.origin, player.origin) < 10000) {
      near_players++;
    }
  }
  if(near_players < 2) {
    return false;
  }
  return true;
}

function private mechzshouldturnberserk(entity) {
  if(entity.berserk === 1 && entity.hasturnedberserk !== 1) {
    return true;
  }
  return false;
}

function private mechzshouldstun(entity) {
  if(isDefined(entity.stun) && entity.stun) {
    return true;
  }
  return false;
}

function private mechzshouldstumble(entity) {
  if(isDefined(entity.stumble) && entity.stumble) {
    return true;
  }
  return false;
}

function private mechzshootgrenadeaction(entity, asmstatename) {
  animationstatenetworkutility::requeststate(entity, asmstatename);
  entity.grenadestarttime = gettime() + 3000;
  return 5;
}

function private mechzshootgrenadeactionupdate(entity, asmstatename) {
  if(!(isDefined(entity.shoot_grenade) && entity.shoot_grenade)) {
    return 4;
  }
  return 5;
}

function private mechzstunstart(entity, asmstatename) {
  animationstatenetworkutility::requeststate(entity, asmstatename);
  entity.stuntime = gettime() + 500;
  return 5;
}

function private mechzstunupdate(entity, asmstatename) {
  if(gettime() > entity.stuntime) {
    return 4;
  }
  return 5;
}

function private mechzstunend(entity, asmstatename) {
  entity.stun = 0;
  entity.stumble_stun_cooldown_time = gettime() + 10000;
  return 4;
}

function private mechzstumblestart(entity, asmstatename) {
  animationstatenetworkutility::requeststate(entity, asmstatename);
  entity.stumbletime = gettime() + 500;
  return 5;
}

function private mechzstumbleupdate(entity, asmstatename) {
  if(gettime() > entity.stumbletime) {
    return 4;
  }
  return 5;
}

function private mechzstumbleend(entity, asmstatename) {
  entity.stumble = 0;
  entity.stumble_stun_cooldown_time = gettime() + 10000;
  return 4;
}

function mechzshootflameactionstart(entity, asmstatename) {
  animationstatenetworkutility::requeststate(entity, asmstatename);
  mechzshootflame(entity);
  return 5;
}

function mechzshootflameactionupdate(entity, asmstatename) {
  if(isDefined(entity.berserk) && entity.berserk) {
    mechzstopflame(entity);
    return 4;
  }
  if(isDefined(mechzshouldmelee(entity)) && mechzshouldmelee(entity)) {
    mechzstopflame(entity);
    return 4;
  }
  if(isDefined(entity.isshootingflame) && entity.isshootingflame) {
    if(isDefined(entity.stopshootingflametime) && gettime() > entity.stopshootingflametime) {
      mechzstopflame(entity);
      return 4;
    }
    mechzupdateflame(entity);
  }
  return 5;
}

function mechzshootflameactionend(entity, asmstatename) {
  mechzstopflame(entity);
  return 4;
}

function private mechzshootgrenade(entity) {
  entity.burstgrenadesfired++;
  if(entity.burstgrenadesfired >= 3) {
    entity.nextgrenadetime = gettime() + 6000;
  }
}

function private mechzshootflame(entity) {
  entity thread mechzdelayflame();
}

function private mechzdelayflame() {
  self endon("death");
  self notify("mechzdelayflame");
  self endon("mechzdelayflame");
  wait(0.3);
  self clientfield::set("mechz_ft", 1);
  self.isshootingflame = 1;
  self.stopshootingflametime = gettime() + 2500;
}

function private mechzupdateflame(entity) {
  if(isDefined(level.mechz_flamethrower_player_callback)) {
    [[level.mechz_flamethrower_player_callback]](entity);
  } else {
    players = getplayers();
    foreach(player in players) {
      if(!(isDefined(player.is_burning) && player.is_burning)) {
        if(player istouching(entity.flametrigger)) {
          if(isDefined(entity.mechzflamedamage)) {
            player thread[[entity.mechzflamedamage]]();
            continue;
          }
          player thread playerflamedamage(entity);
        }
      }
    }
  }
  if(isDefined(level.mechz_flamethrower_ai_callback)) {
    [[level.mechz_flamethrower_ai_callback]](entity);
  }
}

function playerflamedamage(mechz) {
  self endon("death");
  self endon("disconnect");
  if(!(isDefined(self.is_burning) && self.is_burning) && zombie_utility::is_player_valid(self, 1)) {
    self.is_burning = 1;
    if(!self hasperk("specialty_armorvest")) {
      self burnplayer::setplayerburning(1.5, 0.5, 30, mechz, undefined);
    } else {
      self burnplayer::setplayerburning(1.5, 0.5, 20, mechz, undefined);
    }
    wait(1.5);
    self.is_burning = 0;
  }
}

function mechzstopflame(entity) {
  self notify("mechzdelayflame");
  entity clientfield::set("mechz_ft", 0);
  entity.isshootingflame = 0;
  entity.nextflametime = gettime() + 7500;
  entity.stopshootingflametime = undefined;
}

function mechzgoberserk() {
  entity = self;
  g_time = gettime();
  entity.berserkendtime = g_time + 10000;
  if(entity.berserk !== 1) {
    entity.berserk = 1;
    entity thread mechzendberserk();
    blackboard::setblackboardattribute(entity, "_locomotion_speed", "locomotion_speed_sprint");
  }
}

function private mechzplayedberserkintro(entity) {
  entity.hasturnedberserk = 1;
}

function private mechzendberserk() {
  self endon("death");
  self endon("disconnect");
  while(self.berserk === 1) {
    if(gettime() >= self.berserkendtime) {
      self.berserk = 0;
      self.hasturnedberserk = 0;
      self asmsetanimationrate(1);
      blackboard::setblackboardattribute(self, "_locomotion_speed", "locomotion_speed_run");
    }
    wait(0.25);
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

#namespace mechzserverutils;

function private mechzspawnsetup() {
  self disableaimassist();
  self.disableammodrop = 1;
  self.no_gib = 1;
  self.ignore_nuke = 1;
  self.ignore_enemy_count = 1;
  self.ignore_round_robbin_death = 1;
  self.zombie_move_speed = "run";
  blackboard::setblackboardattribute(self, "_locomotion_speed", "locomotion_speed_run");
  self.ignorerunandgundist = 1;
  self mechzaddattachments();
  self.grenadecount = 9;
  self.nextflametime = gettime();
  self.stumble_stun_cooldown_time = gettime();
  self.debug_traversal_ast = "";
  self.flametrigger = spawn("trigger_box", self.origin, 0, 200, 50, 25);
  self.flametrigger enablelinkto();
  self.flametrigger.origin = self gettagorigin("tag_flamethrower_fx");
  self.flametrigger.angles = self gettagangles("tag_flamethrower_fx");
  self.flametrigger linkto(self, "tag_flamethrower_fx");
  self thread weaponobjects::watchweaponobjectusage();
  self.pers = [];
  self.pers["team"] = self.team;
}

function private mechzflamewatcher() {
  self endon("death");
  while(true) {
    if(isDefined(self.favoriteenemy)) {
      if(self.flametrigger istouching(self.favoriteenemy)) {
        printtoprightln("");
      }
    }
    wait(0.05);
  }
}

function private mechzaddattachments() {
  self.has_left_knee_armor = 1;
  self.left_knee_armor_health = 50;
  self.has_right_knee_armor = 1;
  self.right_knee_armor_health = 50;
  self.has_left_shoulder_armor = 1;
  self.left_shoulder_armor_health = 50;
  self.has_right_shoulder_armor = 1;
  self.right_shoulder_armor_health = 50;
  org = self gettagorigin("tag_gun_spin");
  ang = self gettagangles("tag_gun_spin");
  self.gun_attached = 1;
  self.has_faceplate = 1;
  self.faceplate_health = 50;
  self.has_powercap = 1;
  self.powercap_covered = 1;
  self.powercap_cover_health = 50;
  self.powercap_health = 50;
}

function mechzdamagecallback(inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
  if(isDefined(self.b_flyin_done) && (!(isDefined(self.b_flyin_done) && self.b_flyin_done))) {
    return 0;
  }
  if(isDefined(level.mechz_should_stun_override) && (!(isDefined(self.stun) && self.stun || (isDefined(self.stumble) && self.stumble)))) {
    if(self.stumble_stun_cooldown_time < gettime() && (!(isDefined(self.berserk) && self.berserk))) {
      self[[level.mechz_should_stun_override]](inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex);
    }
  }
  if(issubstr(weapon.name, "elemental_bow") && isDefined(inflictor) && inflictor.classname === "rocket") {
    return 0;
  }
  damage = mechzweapondamagemodifier(damage, weapon);
  if(isDefined(level.mechz_damage_override)) {
    damage = [[level.mechz_damage_override]](attacker, damage);
  }
  if(!isDefined(self.next_pain_time) || gettime() >= self.next_pain_time) {
    self thread mechz_play_pain_audio();
    self.next_pain_time = (gettime() + 250) + randomint(500);
  }
  if(isDefined(self.damage_scoring_function)) {
    self[[self.damage_scoring_function]](inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex);
  }
  if(isDefined(level.mechz_staff_damage_override)) {
    staffdamage = [[level.mechz_staff_damage_override]](inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex);
    if(staffdamage > 0) {
      n_mechz_damage_percent = 0.5;
      if(!(isDefined(self.has_faceplate) && self.has_faceplate) && n_mechz_damage_percent < 1) {
        n_mechz_damage_percent = 1;
      }
      staffdamage = staffdamage * n_mechz_damage_percent;
      if(isDefined(self.has_faceplate) && self.has_faceplate) {
        self mechz_track_faceplate_damage(staffdamage);
      }
      iprintlnbold((("" + staffdamage) + "") + (self.health - staffdamage));
      if(!isDefined(self.explosive_dmg_taken)) {
        self.explosive_dmg_taken = 0;
      }
      self.explosive_dmg_taken = self.explosive_dmg_taken + staffdamage;
      if(isDefined(level.mechz_explosive_damage_reaction_callback)) {
        self[[level.mechz_explosive_damage_reaction_callback]]();
      }
      return staffdamage;
    }
  }
  if(isDefined(level.mechz_explosive_damage_reaction_callback)) {
    if(isDefined(mod) && mod == "MOD_GRENADE" || mod == "MOD_GRENADE_SPLASH" || mod == "MOD_PROJECTILE" || mod == "MOD_PROJECTILE_SPLASH" || mod == "MOD_EXPLOSIVE") {
      n_mechz_damage_percentage = 0.5;
      if(isDefined(attacker) && isPlayer(attacker) && isalive(attacker) && (level.zombie_vars[attacker.team]["zombie_insta_kill"] || (isDefined(attacker.personal_instakill) && attacker.personal_instakill))) {
        n_mechz_damage_percentage = 1;
      }
      explosive_damage = damage * n_mechz_damage_percentage;
      if(!isDefined(self.explosive_dmg_taken)) {
        self.explosive_dmg_taken = 0;
      }
      self.explosive_dmg_taken = self.explosive_dmg_taken + explosive_damage;
      if(isDefined(self.has_faceplate) && self.has_faceplate) {
        self mechz_track_faceplate_damage(explosive_damage);
      }
      self[[level.mechz_explosive_damage_reaction_callback]]();
      iprintlnbold((("" + explosive_damage) + "") + (self.health - explosive_damage));
      return explosive_damage;
    }
  }
  if(hitloc == "head") {
    attacker show_hit_marker();
    iprintlnbold((("" + damage) + "") + (self.health - damage));
    return damage;
  }
  if(hitloc !== "none") {
    switch (hitloc) {
      case "torso_upper": {
        if(self.has_faceplate == 1) {
          faceplate_pos = self gettagorigin("j_faceplate");
          dist_sq = distancesquared(faceplate_pos, point);
          if(dist_sq <= 144) {
            self mechz_track_faceplate_damage(damage);
            attacker show_hit_marker();
          }
          headlamp_dist_sq = distancesquared(point, self gettagorigin("tag_headlamp_FX"));
          if(headlamp_dist_sq <= 9) {
            self mechz_turn_off_headlamp(1);
          }
        }
        partname = getpartname("c_zom_mech_body", boneindex);
        if(self.powercap_covered === 1 && (partname === "tag_powersupply" || partname === "tag_powersupply_hit")) {
          self mechz_track_powercap_cover_damage(damage);
          attacker show_hit_marker();
          iprintlnbold((("" + (damage * 0.1)) + "") + (self.health - (damage * 0.1)));
          return damage * 0.1;
        } else {
          if(self.powercap_covered !== 1 && self.has_powercap === 1 && (partname === "tag_powersupply" || partname === "tag_powersupply_hit")) {
            self mechz_track_powercap_damage(damage);
            attacker show_hit_marker();
            iprintlnbold((("" + damage) + "") + (self.health - damage));
            return damage;
          } else if(self.powercap_covered !== 1 && self.has_powercap !== 1 && (partname === "tag_powersupply" || partname === "tag_powersupply_hit")) {
            iprintlnbold((("" + (damage * 0.5)) + "") + (self.health - (damage * 0.5)));
            attacker show_hit_marker();
            return damage * 0.5;
          }
        }
        if(self.has_right_shoulder_armor === 1 && partname === "j_shoulderarmor_ri") {
          self mechz_track_rshoulder_armor_damage(damage);
          iprintlnbold((("" + (damage * 0.1)) + "") + (self.health - (damage * 0.1)));
          return damage * 0.1;
        }
        if(self.has_left_shoulder_armor === 1 && partname === "j_shoulderarmor_le") {
          self mechz_track_lshoulder_armor_damage(damage);
          iprintlnbold((("" + (damage * 0.1)) + "") + (self.health - (damage * 0.1)));
          return damage * 0.1;
        }
        iprintlnbold((("" + (damage * 0.1)) + "") + (self.health - (damage * 0.1)));
        return damage * 0.1;
        break;
      }
      case "left_leg_lower": {
        partname = getpartname("c_zom_mech_body", boneindex);
        if(partname === "j_knee_attach_le" && self.has_left_knee_armor === 1) {
          self mechz_track_lknee_armor_damage(damage);
        }
        iprintlnbold((("" + (damage * 0.1)) + "") + (self.health - (damage * 0.1)));
        return damage * 0.1;
        break;
      }
      case "right_leg_lower": {
        partname = getpartname("c_zom_mech_body", boneindex);
        if(partname === "j_knee_attach_ri" && self.has_right_knee_armor === 1) {
          self mechz_track_rknee_armor_damage(damage);
        }
        iprintlnbold((("" + (damage * 0.1)) + "") + (self.health - (damage * 0.1)));
        return damage * 0.1;
        break;
      }
      case "left_arm_lower":
      case "left_arm_upper":
      case "left_hand": {
        if(isDefined(level.mechz_left_arm_damage_callback)) {
          self[[level.mechz_left_arm_damage_callback]]();
        }
        iprintlnbold((("" + (damage * 0.1)) + "") + (self.health - (damage * 0.1)));
        return damage * 0.1;
        break;
      }
      default: {
        iprintlnbold((("" + (damage * 0.1)) + "") + (self.health - (damage * 0.1)));
        return damage * 0.1;
        break;
      }
    }
  }
  if(mod == "MOD_PROJECTILE") {
    hit_damage = damage * 0.1;
    if(self.has_faceplate !== 1) {
      head_pos = self gettagorigin("tag_eye");
      dist_sq = distancesquared(head_pos, point);
      if(dist_sq <= 144) {
        iprintlnbold((("" + damage) + "") + (self.health - damage));
        attacker show_hit_marker();
        return damage;
      }
    }
    if(self.has_faceplate === 1) {
      faceplate_pos = self gettagorigin("j_faceplate");
      dist_sq = distancesquared(faceplate_pos, point);
      if(dist_sq <= 144) {
        self mechz_track_faceplate_damage(damage);
        attacker show_hit_marker();
      }
      headlamp_dist_sq = distancesquared(point, self gettagorigin("tag_headlamp_FX"));
      if(headlamp_dist_sq <= 9) {
        self mechz_turn_off_headlamp(1);
      }
    }
    power_pos = self gettagorigin("tag_powersupply_hit");
    power_dist_sq = distancesquared(power_pos, point);
    if(power_dist_sq <= 25) {
      if(self.powercap_covered !== 1 && self.has_powercap !== 1) {
        iprintlnbold((("" + damage) + "") + (self.health - damage));
        attacker show_hit_marker();
        return damage;
      }
      if(self.powercap_covered !== 1 && self.has_powercap === 1) {
        self mechz_track_powercap_damage(damage);
        attacker show_hit_marker();
        iprintlnbold((("" + damage) + "") + (self.health - damage));
        return damage;
      }
      if(self.powercap_covered === 1) {
        self mechz_track_powercap_cover_damage(damage);
        attacker show_hit_marker();
      }
    }
    if(self.has_right_shoulder_armor === 1) {
      armor_pos = self gettagorigin("j_shoulderarmor_ri");
      dist_sq = distancesquared(armor_pos, point);
      if(dist_sq <= 64) {
        self mechz_track_rshoulder_armor_damage(damage);
      }
    }
    if(self.has_left_shoulder_armor === 1) {
      armor_pos = self gettagorigin("j_shoulderarmor_le");
      dist_sq = distancesquared(armor_pos, point);
      if(dist_sq <= 64) {
        self mechz_track_lshoulder_armor_damage(damage);
      }
    }
    if(self.has_right_knee_armor === 1) {
      armor_pos = self gettagorigin("j_knee_attach_ri");
      dist_sq = distancesquared(armor_pos, point);
      if(dist_sq <= 36) {
        self mechz_track_rknee_armor_damage(damage);
      }
    }
    if(self.has_left_knee_armor === 1) {
      armor_pos = self gettagorigin("j_knee_attach_le");
      dist_sq = distancesquared(armor_pos, point);
      if(dist_sq <= 36) {
        self mechz_track_lknee_armor_damage(damage);
      }
    }
    iprintlnbold((("" + hit_damage) + "") + (self.health - hit_damage));
    return hit_damage;
  }
  if(mod == "MOD_PROJECTILE_SPLASH") {
    hit_damage = damage * 0.2;
    i_num_armor_pieces = 0;
    if(isDefined(level.mechz_faceplate_damage_override)) {
      self[[level.mechz_faceplate_damage_override]](inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex);
    }
    if(self.has_right_shoulder_armor === 1) {
      i_num_armor_pieces = i_num_armor_pieces + 1;
      right_shoulder_index = i_num_armor_pieces;
    }
    if(self.has_left_shoulder_armor === 1) {
      i_num_armor_pieces = i_num_armor_pieces + 1;
      left_shoulder_index = i_num_armor_pieces;
    }
    if(self.has_right_knee_armor === 1) {
      i_num_armor_pieces = i_num_armor_pieces + 1;
      right_knee_index = i_num_armor_pieces;
    }
    if(self.has_left_knee_armor === 1) {
      i_num_armor_pieces = i_num_armor_pieces + 1;
      left_knee_index = i_num_armor_pieces;
    }
    if(i_num_armor_pieces > 0) {
      if(i_num_armor_pieces <= 1) {
        i_random = 0;
      } else {
        i_random = randomint(i_num_armor_pieces - 1);
      }
      i_random = i_random + 1;
      if(self.has_right_shoulder_armor === 1 && right_shoulder_index === i_random) {
        self mechz_track_rshoulder_armor_damage(damage);
      }
      if(self.has_left_shoulder_armor === 1 && left_shoulder_index === i_random) {
        self mechz_track_lshoulder_armor_damage(damage);
      }
      if(self.has_right_knee_armor === 1 && right_knee_index === i_random) {
        self mechz_track_rknee_armor_damage(damage);
      }
      if(self.has_left_knee_armor === 1 && left_knee_index === i_random) {
        self mechz_track_lknee_armor_damage(damage);
      }
    } else {
      if(self.powercap_covered === 1) {
        self mechz_track_powercap_cover_damage(damage * 0.5);
      }
      if(self.has_faceplate == 1) {
        self mechz_track_faceplate_damage(damage * 0.5);
      }
    }
    iprintlnbold((("" + hit_damage) + "") + (self.health - hit_damage));
    return hit_damage;
  }
  return 0;
}

function private mechzweapondamagemodifier(damage, weapon) {
  if(isDefined(weapon) && isDefined(weapon.name)) {
    if(issubstr(weapon.name, "shotgun_fullauto")) {
      return damage * 0.5;
    }
    if(issubstr(weapon.name, "lmg_cqb")) {
      return damage * 0.65;
    }
    if(issubstr(weapon.name, "lmg_heavy")) {
      return damage * 0.65;
    }
    if(issubstr(weapon.name, "shotgun_precision")) {
      return damage * 0.65;
    }
    if(issubstr(weapon.name, "shotgun_semiauto")) {
      return damage * 0.75;
    }
  }
  return damage;
}

function mechz_play_pain_audio() {
  self playSound("zmb_ai_mechz_destruction");
}

function show_hit_marker() {
  if(isDefined(self) && isDefined(self.hud_damagefeedback)) {
    self.hud_damagefeedback setshader("damage_feedback", 24, 48);
    self.hud_damagefeedback.alpha = 1;
    self.hud_damagefeedback fadeovertime(1);
    self.hud_damagefeedback.alpha = 0;
  }
}

function hide_part(strtag) {
  if(self haspart(strtag)) {
    self hidepart(strtag);
  }
}

function mechz_track_faceplate_damage(damage) {
  self.faceplate_health = self.faceplate_health - damage;
  if(self.faceplate_health <= 0) {
    self hide_part("j_faceplate");
    self clientfield::set("mechz_faceplate_detached", 1);
    self.has_faceplate = 0;
    self mechz_turn_off_headlamp();
    self.partdestroyed = 1;
    blackboard::setblackboardattribute(self, "_mechz_part", "mechz_faceplate");
    self mechzbehavior::mechzgoberserk();
    level notify("mechz_faceplate_detached");
  }
}

function mechz_track_powercap_cover_damage(damage) {
  self.powercap_cover_health = self.powercap_cover_health - damage;
  if(self.powercap_cover_health <= 0) {
    self hide_part("tag_powersupply");
    self clientfield::set("mechz_powercap_detached", 1);
    self.powercap_covered = 0;
    self.partdestroyed = 1;
    blackboard::setblackboardattribute(self, "_mechz_part", "mechz_powercore");
  }
}

function mechz_track_powercap_damage(damage) {
  self.powercap_health = self.powercap_health - damage;
  if(self.powercap_health <= 0) {
    if(isDefined(level.mechz_powercap_destroyed_callback)) {
      self[[level.mechz_powercap_destroyed_callback]]();
    }
    self hide_part("tag_gun_spin");
    self hide_part("tag_gun_barrel1");
    self hide_part("tag_gun_barrel2");
    self hide_part("tag_gun_barrel3");
    self hide_part("tag_gun_barrel4");
    self hide_part("tag_gun_barrel5");
    self hide_part("tag_gun_barrel6");
    self clientfield::set("mechz_claw_detached", 1);
    self.has_powercap = 0;
    self.gun_attached = 0;
    self.partdestroyed = 1;
    blackboard::setblackboardattribute(self, "_mechz_part", "mechz_gun");
    level notify("mechz_gun_detached");
  }
}

function mechz_track_rknee_armor_damage(damage) {
  self.right_knee_armor_health = self.right_knee_armor_health - damage;
  if(self.right_knee_armor_health <= 0) {
    self hide_part("j_knee_attach_ri");
    self clientfield::set("mechz_rknee_armor_detached", 1);
    self.has_right_knee_armor = 0;
  }
}

function mechz_track_lknee_armor_damage(damage) {
  self.left_knee_armor_health = self.left_knee_armor_health - damage;
  if(self.left_knee_armor_health <= 0) {
    self hide_part("j_knee_attach_le");
    self clientfield::set("mechz_lknee_armor_detached", 1);
    self.has_left_knee_armor = 0;
  }
}

function mechz_track_rshoulder_armor_damage(damage) {
  self.right_shoulder_armor_health = self.right_shoulder_armor_health - damage;
  if(self.right_shoulder_armor_health <= 0) {
    self hide_part("j_shoulderarmor_ri");
    self clientfield::set("mechz_rshoulder_armor_detached", 1);
    self.has_right_shoulder_armor = 0;
  }
}

function mechz_track_lshoulder_armor_damage(damage) {
  self.left_shoulder_armor_health = self.left_shoulder_armor_health - damage;
  if(self.left_shoulder_armor_health <= 0) {
    self hide_part("j_shoulderarmor_le");
    self clientfield::set("mechz_lshoulder_armor_detached", 1);
    self.has_left_shoulder_armor = 0;
  }
}

function mechzcheckinarc(right_offset, aim_tag) {
  origin = self.origin;
  angles = self.angles;
  if(isDefined(aim_tag)) {
    origin = self gettagorigin(aim_tag);
    angles = self gettagangles(aim_tag);
  }
  if(isDefined(right_offset)) {
    right_angle = anglestoright(angles);
    origin = origin + (right_angle * right_offset);
  }
  facing_vec = anglesToForward(angles);
  enemy_vec = self.favoriteenemy.origin - origin;
  enemy_yaw_vec = (enemy_vec[0], enemy_vec[1], 0);
  facing_yaw_vec = (facing_vec[0], facing_vec[1], 0);
  enemy_yaw_vec = vectornormalize(enemy_yaw_vec);
  facing_yaw_vec = vectornormalize(facing_yaw_vec);
  enemy_dot = vectordot(facing_yaw_vec, enemy_yaw_vec);
  if(enemy_dot < 0.5) {
    return false;
  }
  enemy_angles = vectortoangles(enemy_vec);
  if(abs(angleclamp180(enemy_angles[0])) > 60) {
    return false;
  }
  return true;
}

function private mechzgrenadecheckinarc(right_offset) {
  origin = self.origin;
  if(isDefined(right_offset)) {
    right_angle = anglestoright(self.angles);
    origin = origin + (right_angle * right_offset);
  }
  facing_vec = anglesToForward(self.angles);
  enemy_vec = self.favoriteenemy.origin - origin;
  enemy_yaw_vec = (enemy_vec[0], enemy_vec[1], 0);
  facing_yaw_vec = (facing_vec[0], facing_vec[1], 0);
  enemy_yaw_vec = vectornormalize(enemy_yaw_vec);
  facing_yaw_vec = vectornormalize(facing_yaw_vec);
  enemy_dot = vectordot(facing_yaw_vec, enemy_yaw_vec);
  if(enemy_dot < 0.5) {
    return false;
  }
  enemy_angles = vectortoangles(enemy_vec);
  if(abs(angleclamp180(enemy_angles[0])) > 60) {
    return false;
  }
  return true;
}

function mechz_turn_off_headlamp(headlamp_broken) {
  if(headlamp_broken !== 1) {
    self clientfield::set("mechz_headlamp_off", 1);
  } else {
    self clientfield::set("mechz_headlamp_off", 2);
  }
}