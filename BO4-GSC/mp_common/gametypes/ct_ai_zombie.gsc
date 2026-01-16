/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\ct_ai_zombie.gsc
************************************************/

#include scripts\core_common\ai\archetype_damage_utility;
#include scripts\core_common\ai\systems\animation_state_machine_notetracks;
#include scripts\core_common\ai\systems\behavior_state_machine;
#include scripts\core_common\ai\systems\behavior_tree_utility;
#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\ai\zombie;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\values_shared;
#include scripts\mp_common\armor;

#namespace mp_ai_zombie;

autoexec __init__system__() {
  system::register(#"mp_ai_zombie", &__init__, undefined, undefined);
}

private __init__() {
  clientfield::register("actor", "zombie_riser_fx", 1, 1, "int");
  clientfield::register("actor", "zombie_has_eyes", 1, 1, "int");
  level.var_9ee73630 = [];
  level.var_9ee73630[#"walk"] = [];
  level.var_9ee73630[#"run"] = [];
  level.var_9ee73630[#"sprint"] = [];
  level.var_9ee73630[#"super_sprint"] = [];
  level.var_9ee73630[#"walk"][#"down"] = 14;
  level.var_9ee73630[#"walk"][#"up"] = 16;
  level.var_9ee73630[#"run"][#"down"] = 13;
  level.var_9ee73630[#"run"][#"up"] = 12;
  level.var_9ee73630[#"sprint"][#"down"] = 9;
  level.var_9ee73630[#"sprint"][#"up"] = 8;
  level.var_9ee73630[#"super_sprint"][#"down"] = 1;
  level.var_9ee73630[#"super_sprint"][#"up"] = 1;
  spawner::add_archetype_spawn_function(#"zombie", &function_cf051788);
  initzombiebehaviors();
  val::register("allowoffnavmesh", 1);
  val::default_value("allowoffnavmesh", 0);
  level.attackablecallback = &attackable_callback;
  level.var_cdc822b = &function_cdc822b;
  level.var_a6a84389 = &function_a6a84389;
  level.custom_melee_fire = &custom_melee_fire;
  level.startinghealth = 100;
}

custom_melee_fire() {
  idflags = 0;

  if(isDefined(self.enemy) && isDefined(self.enemy.armor) && self.enemy.armor) {
    idflags |= 2048;
  }

  self function_f3813b8a(idflags);
}

function_cdc822b() {
  if(isDefined(self.ai_zone) && isDefined(self.ai_zone.is_active) && self.ai_zone.is_active) {
    return true;
  }

  return false;
}

function_a6a84389(playerradius) {
  position = getclosestpointonnavmesh(self.origin - (0, 0, 60), 200, playerradius);

  if(isDefined(position)) {
    self.last_valid_position = position;
  }

  return self.last_valid_position;
}

function_2713ff17(vehicle) {
  if(isDefined(vehicle)) {
    vehicle dodamage(50, vehicle.origin);
    org = vehicle.origin;
    earthquake(0.3, 1, org, 2000);
    playrumbleonposition("grenade_rumble", org);
  }
}

attackable_callback(entity) {
  function_2713ff17(self);
}

initzombiebehaviors() {
  assert(isscriptfunctionptr(&function_e91d8371));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombieupdatethrottle", &function_e91d8371, 1);
  assert(isscriptfunctionptr(&zombieshouldmelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombieshouldmelee", &zombieshouldmelee);
  assert(isscriptfunctionptr(&function_e8f3596d));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_350ddff40ea2207b", &function_e8f3596d);
  assert(isscriptfunctionptr(&function_cc184b8b));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_77070e8fef81d6da", &function_cc184b8b);
  assert(isscriptfunctionptr(&function_562c0e1d));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_23448cac3a176df3", &function_562c0e1d);
  assert(isscriptfunctionptr(&function_e8f3596d));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_350ddff40ea2207b", &function_e8f3596d);
  assert(isscriptfunctionptr(&function_a58eaeea));
  behaviorstatemachine::registerbsmscriptapiinternal(#"wzzombieshouldreact", &function_a58eaeea);
  assert(isscriptfunctionptr(&zombieshouldmove));
  behaviorstatemachine::registerbsmscriptapiinternal(#"wzzombieshouldmove", &zombieshouldmove);
  assert(isscriptfunctionptr(&function_37abea6f));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_2b17bbf6d0ceff72", &function_37abea6f);
  assert(isscriptfunctionptr(&function_55b7ea22));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_336e28ae1ed4640b", &function_55b7ea22);
  assert(isscriptfunctionptr(&function_98b102d8));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_53e4632b82a3a930", &function_98b102d8);
  assert(isscriptfunctionptr(&function_6ec0bcc1));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_791763042d13fef1", &function_6ec0bcc1);
  assert(isscriptfunctionptr(&function_4402c40a));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_24de191ac3416c18", &function_4402c40a);
  assert(isscriptfunctionptr(&function_6a3bcddc));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_33c14e313f684eab", &function_6a3bcddc);
  assert(isscriptfunctionptr(&zombiemoveactionstart));
  behaviorstatemachine::registerbsmscriptapiinternal(#"wzzombiemoveactionstart", &zombiemoveactionstart);
  assert(isscriptfunctionptr(&zombiemoveactionupdate));
  behaviorstatemachine::registerbsmscriptapiinternal(#"wzzombiemoveactionupdate", &zombiemoveactionupdate);
  assert(isscriptfunctionptr(&function_a0acf641));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_796d69f77ff45304", &function_a0acf641);
  assert(isscriptfunctionptr(&function_f8250d5e));
  behaviorstatemachine::registerbsmscriptapiinternal(#"wzzombieidleactionstart", &function_f8250d5e);
  assert(isscriptfunctionptr(&function_860d5d8));
  behaviorstatemachine::registerbsmscriptapiinternal(#"wzzombieidleactionupdate", &function_860d5d8);
  animationstatenetwork::registernotetrackhandlerfunction("zombieRiserFx", &function_79c3a487);
  animationstatenetwork::registernotetrackhandlerfunction("showZombie", &showzombie);
}

function_9758722(speed) {
  if(self.zombie_move_speed === speed) {
    return;
  }

  self.zombie_move_speed = speed;

  if(!isDefined(self.zombie_arms_position)) {
    self.zombie_arms_position = math::cointoss() == 1 ? "up" : "down";
  }

  if(isDefined(level.var_9ee73630)) {
    self.variant_type = randomint(level.var_9ee73630[self.zombie_move_speed][self.zombie_arms_position]);
  }
}

private function_cf051788() {
  self callback::function_d8abfc3d(#"on_ai_damage", &function_3d9b8ab3);
  self callback::function_d8abfc3d(#"on_ai_killed", &zombie_death_event);
  aiutility::addaioverridedamagecallback(self, &function_c75fae30);
  self.clamptonavmesh = 1;
  self.ignorepathenemyfightdist = 1;
  self.var_bb185cc5 = 0;
  self.var_1c0eb62a = 180;
  self.var_737e8510 = 128;
  self function_9758722("walk");
  self.spawn_anim = "ai_zombie_base_traverse_ground_climbout_fast";
  self thread function_6c308e81();
  self thread zombie_gib_on_damage();
  self thread function_e261b81d();
  self.maxhealth = level.startinghealth;
  self.health = self.maxhealth;
  self.var_31a789c0 = 0;
  self.var_15fe3985 = 0;
  self.var_2c628c0f = 1;
  self.var_20e07206 = 1;
}

isheadshot(shitloc) {
  if(isDefined(shitloc) && (shitloc == "head" || shitloc == "helmet")) {
    return true;
  }

  return false;
}

private function_c75fae30(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  if(isheadshot(shitloc)) {
    idamage *= 2;
  }

  return idamage;
}

private function_3d9b8ab3(params) {
  if(!isDefined(self.enemy_override) && isDefined(self.favoriteenemy) && isDefined(params.eattacker) && isplayer(params.eattacker)) {
    self.favoriteenemy = params.eattacker;
  }
}

private function_9c573bc6() {
  self notify("403817714a013a66");
  self endon("6c94e145f7d12787", #"death");

  if(isDefined(self.allowoffnavmesh) && self.allowoffnavmesh && isDefined(level.var_5e8121a) && level.var_5e8121a) {
    self.var_ef59b90 = 5;
    return;
  }

  self collidewithactors(0);
  wait 2;
  self collidewithactors(1);
}

private function_e91d8371(entity) {
  level.var_8de0b84e = entity getentitynumber();
}

private zombieshouldmelee(entity) {
  if(isDefined(entity.enemy_override)) {
    return false;
  }

  if(!isDefined(entity.enemy)) {
    return false;
  }

  if(isDefined(entity.ignoremelee) && entity.ignoremelee) {
    return false;
  }

  if(isDefined(entity.var_8a96267d) && entity.var_8a96267d || isDefined(entity.var_8ba6ede3) && entity.var_8ba6ede3) {
    return false;
  }

  if(abs(entity.origin[2] - entity.enemy.origin[2]) > (isDefined(entity.var_737e8510) ? entity.var_737e8510 : 64)) {
    return false;
  }

  meleedistsq = zombiebehavior::function_997f1224(entity);

  if(distancesquared(entity.origin, entity.enemy.origin) > meleedistsq) {
    return false;
  }

  yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);

  if(abs(yawtoenemy) > (isDefined(entity.var_1c0eb62a) ? entity.var_1c0eb62a : 60)) {
    return false;
  }

  if(!entity cansee(entity.enemy)) {
    return false;
  }

  if(distancesquared(entity.origin, entity.enemy.origin) < 40 * 40) {
    return true;
  }

  if(isDefined(entity.enemy.usingvehicle) && entity.enemy.usingvehicle) {
    entity.attackable = entity.enemy getvehicleoccupied();
    entity.attackable.is_active = 1;
    entity.is_at_attackable = 1;
    return true;
  }

  if(isDefined(self.isonnavmesh) && self.isonnavmesh && !tracepassedonnavmesh(entity.origin, isDefined(entity.enemy.last_valid_position) ? entity.enemy.last_valid_position : entity.enemy.origin, entity.enemy getpathfindingradius())) {
    return false;
  }

  return true;
}

private function_e8f3596d(entity) {
  return isDefined(entity.var_8a96267d) && entity.var_8a96267d;
}

private function_cc184b8b(entity) {
  return isDefined(entity.var_8ba6ede3) && entity.var_8ba6ede3;
}

private function_562c0e1d(entity) {
  return entity haspath() || isDefined(entity.is_digging) && entity.is_digging;
}

private function_a58eaeea(entity) {
  return !(isDefined(entity.missinglegs) && entity.missinglegs) && isDefined(entity.shouldreact) && entity.shouldreact;
}

private zombieshouldmove(entity) {
  return entity.allowoffnavmesh || entity haspath();
}

private function_37abea6f(entity) {
  return isDefined(entity.var_4c4ad20a) && entity.var_4c4ad20a;
}

private function_c9153928(entity) {
  origin = undefined;

  if(isDefined(self.enemy_override)) {
    origin = self.enemy_override.origin;
  } else if(isDefined(self.favoriteenemy)) {
    origin = self.favoriteenemy.origin;
  }

  if(!isDefined(origin)) {
    return;
  }

  to_origin = origin - entity.origin;
  yaw = vectortoangles(to_origin)[1] - entity.angles[1];
  yaw = absangleclamp360(yaw);
  entity.shouldreact = 1;

  if(yaw <= 45 || yaw > 315) {
    entity setblackboardattribute("_zombie_react_direction", "front");
    return;
  }

  if(yaw > 45 && yaw <= 135) {
    entity setblackboardattribute("_zombie_react_direction", "left");
    return;
  }

  if(yaw > 135 && yaw <= 225) {
    entity setblackboardattribute("_zombie_react_direction", "back");
    return;
  }

  entity setblackboardattribute("_zombie_react_direction", "right");
}

private function_4402c40a(entity) {
  entity.var_8a96267d = undefined;
  entity.is_digging = 1;
  entity pathmode("dont move", 1);
  return true;
}

private function_6a3bcddc(entity) {
  entity ghost();
  entity notsolid();
  entity clientfield::set("zombie_riser_fx", 0);
  entity notify(#"is_underground");
  return true;
}

private function_55b7ea22(entity) {
  entity solid();
  entity clientfield::set("zombie_riser_fx", 1);
  entity.var_8ba6ede3 = undefined;
}

private function_98b102d8(entity) {
  entity clientfield::set("zombie_riser_fx", 0);
  entity.is_digging = 0;
  entity pathmode("move allowed");
  entity notify(#"not_underground");
}

private function_6ec0bcc1(entity) {
  entity.shouldreact = undefined;
  return true;
}

private zombiemoveactionstart(entity) {
  entity.movetime = gettime();
  entity.moveorigin = entity.origin;
  return true;
}

private zombiemoveactionupdate(entity) {
  if(!(isDefined(entity.missinglegs) && entity.missinglegs) && gettime() - entity.movetime > 1000) {
    distsq = distance2dsquared(entity.origin, entity.moveorigin);

    if(distsq < 144) {
      if(isDefined(entity.cant_move_cb)) {
        entity thread[[entity.cant_move_cb]]();
      }
    }

    entity.movetime = gettime();
    entity.moveorigin = entity.origin;
  }

  return true;
}

private function_f8250d5e(entity) {
  entity.idletime = gettime();
  entity.moveorigin = entity.origin;
  return true;
}

private function_860d5d8(entity) {
  if(!(isDefined(entity.missinglegs) && entity.missinglegs) && gettime() - entity.idletime > 1000) {
    distsq = distance2dsquared(entity.origin, entity.moveorigin);

    if(distsq < 144) {
      if(isDefined(entity.cant_move_cb)) {
        entity thread[[entity.cant_move_cb]]();
      }
    }

    entity.idletime = gettime();
    entity.moveorigin = entity.origin;
  }

  return true;
}

private function_a0acf641(entity) {
  entity.var_4c4ad20a = undefined;
  return true;
}

private function_79c3a487(entity) {
  entity clientfield::set("zombie_riser_fx", 1);
}

private showzombie(entity) {
  entity show();
}

private function_7c7e7339() {
  switch (self.aistate) {
    case 3:
      self.goalradius = 64;
      break;
    default:
      self.goalradius = 32;
      break;
  }
}

private function_d1e55248(id, value) {
  if(isDefined(value) && value) {
    self val::set(id, "allowoffnavmesh", 1);
    return;
  }

  self val::reset(id, "allowoffnavmesh");
}

function_e261b81d() {
  level endon(#"game_ended");
  self endon(#"death");
  waitframe(1);
  self.aistate = 1;
  self setgoal(self.origin);

  while(true) {
    self.isonnavmesh = ispointonnavmesh(self.origin, self);
    self function_bf21ead1();

    if(!self.isonnavmesh && self.allowoffnavmesh) {
      if(!isDefined(self.var_6bcb6977)) {
        self.var_6bcb6977 = gettime();

        if(isDefined(self.ai_zone.var_2209cb79)) {
          self.var_f9d7afa3 = self.ai_zone.var_2209cb79;
        } else {
          self.var_f9d7afa3 = randomintrange(6000, 10000);
        }
      }
    } else {
      self.var_6bcb6977 = undefined;
      self function_7c7e7339();
    }

    if(isDefined(level.var_3140c814) && level.var_3140c814) {
      if(self.aistate !== 5 && self isonground() && isDefined(self.var_6bcb6977) && gettime() - self.var_6bcb6977 > self.var_f9d7afa3) {
        self.var_ef59b90 = 5;
      }
    }

    if(isDefined(self.var_ef59b90) && self.aistate != self.var_ef59b90) {
      self function_cc9c6a13(self.aistate);
      self.aistate = self.var_ef59b90;
      self function_b8eff92a(self.aistate);
      self notify(#"state_changed");
      self.var_ef59b90 = undefined;
    }

    switch (self.aistate) {
      case 1:
        self function_34eacecd();
        break;
      case 3:
        self function_36151fe3();
        break;
      case 5:
        self function_101763c9();
        break;
      case 0:
      default:
        break;
    }

    update_goal();
    waitframe(1);
  }
}

private update_goal() {
  if(isDefined(self.var_80780af2) && (level.var_8de0b84e === self getentitynumber() || self.archetype == #"blight_father")) {
    if(!self.allowoffnavmesh && self.isonnavmesh) {
      adjustedgoal = getclosestpointonnavmesh(self.var_80780af2, 100, self getpathfindingradius());

      if(isDefined(adjustedgoal)) {
        pathdata = generatenavmeshpath(self.origin, adjustedgoal, self);

        if(isDefined(pathdata) && pathdata.status === "succeeded") {
          self setgoal(adjustedgoal);
        }
      }
    }

    self.var_80780af2 = undefined;
  }
}

is_player_valid(player) {
  if(!isDefined(player)) {
    return false;
  }

  if(!isalive(player)) {
    return false;
  }

  if(!isplayer(player)) {
    return false;
  }

  if(player.sessionstate == "spectator") {
    return false;
  }

  if(player.sessionstate == "intermission") {
    return false;
  }

  if(isDefined(player.intermission) && player.intermission) {
    return false;
  }

  if(player.ignoreme || player isnotarget()) {
    return false;
  }

  return true;
}

function_f10600c(enemy) {
  if(!is_player_valid(enemy)) {
    return 0;
  }

  if(isDefined(self.canseeplayer) && gettime() < self.var_ea34ab74) {
    return self.canseeplayer;
  }

  targetpoint = isDefined(enemy.var_88f8feeb) ? enemy.var_88f8feeb : enemy getcentroid();

  if(bullettracepassed(self getEye(), targetpoint, 0, enemy)) {
    self clearentitytarget();
    self.canseeplayer = 1;
    self.var_ea34ab74 = gettime() + 2000;
  } else {
    self.canseeplayer = 0;
    self.var_ea34ab74 = gettime() + 500;
  }

  return self.canseeplayer;
}

ai_can_see() {
  players_in_zone = getplayers();
  var_13324143 = arraysortclosest(players_in_zone, self.origin, 4);

  for(i = 0; i < var_13324143.size; i++) {
    if(self function_f10600c(var_13324143[i])) {
      return var_13324143[i];
    }
  }

  return undefined;
}

private function_bf21ead1() {
  var_f5acb8b9 = self.favoriteenemy;
  self.enemy_override = function_b67c088d();

  if(isDefined(self.enemy_override)) {
    self.favoriteenemy = undefined;
  } else {
    var_293b2af1 = ai_can_see();

    if(isDefined(var_293b2af1)) {
      self.favoriteenemy = var_293b2af1;
      self.var_bb185cc5 = gettime();
    } else if(isDefined(self.favoriteenemy)) {
      if(self function_f10600c(self.favoriteenemy)) {
        self.var_bb185cc5 = gettime();
      }

      if(gettime() - self.var_bb185cc5 > 8000 || !is_player_valid(self.favoriteenemy)) {
        self.favoriteenemy = undefined;
      }
    }
  }

  if(var_f5acb8b9 !== self.favoriteenemy) {
    self callback::callback(#"hash_45b50cc48ee7f9d8");
  }
}

private function_827edb6() {
  var_f5acb8b9 = self.favoriteenemy;
  self.enemy_override = function_b67c088d();

  if(isDefined(self.enemy_override)) {
    self.favoriteenemy = undefined;
  } else if(isDefined(self.favoriteenemy)) {
    if(self function_f10600c(self.favoriteenemy)) {
      self.var_bb185cc5 = gettime();
    }

    if(gettime() - self.var_bb185cc5 > 8000 || !is_player_valid(self.favoriteenemy)) {
      self.favoriteenemy = undefined;
    }
  }

  if(!isDefined(self.enemy_override) && !isDefined(self.favoriteenemy)) {
    self.favoriteenemy = ai_can_see();
  }

  if(var_f5acb8b9 !== self.favoriteenemy) {
    self callback::callback(#"hash_45b50cc48ee7f9d8");
  }
}

private function_b67c088d() {
  return undefined;
}

private function_cc9c6a13(state) {
  switch (state) {
    case 1:
      self.var_9a79d89d = undefined;
      self clearpath();

      if(self.var_ef59b90 === 3) {
        function_c9153928(self);
      }

      break;
    case 3:
      self function_d1e55248(#"hash_6e6d6ff06622efa4", 0);
      self pathmode("move allowed");
      break;
    case 5:
      self function_d1e55248(#"hash_5780e28b762b831a", 0);
      val::reset(#"hash_5780e28b762b831a", "ignoreall");
      self pathmode("move allowed");
      break;
    default:
      break;
  }
}

private function_b8eff92a(state) {
  switch (state) {
    case 1:
      self function_9758722("walk");
      self.favoriteenemy = undefined;
      break;
    case 3:
      self function_9758722("sprint");
      break;
    case 5:
      self function_d1e55248(#"hash_5780e28b762b831a", !self.isonnavmesh);
      val::set(#"hash_5780e28b762b831a", "ignoreall", 1);

      if(!self.isonnavmesh) {
        self pathmode("dont move", 1);
      }

      break;
    default:
      break;
  }

  self function_7c7e7339();
}

private function_36151fe3() {
  self pathmode("move allowed");
  self function_d4c687c9();

  if(isDefined(self.enemy_override)) {
    var_31e67a12 = ispointonnavmesh(self.enemy_override.origin, self);

    if(var_31e67a12 && self.isonnavmesh) {
      self function_d1e55248(#"hash_6e6d6ff06622efa4", 0);
      self.var_80780af2 = self.enemy_override.origin;
      return;
    }

    if(self.isonnavmesh && isDefined(self.enemy_override.var_acdc8d71) && !self isingoal(self.enemy_override.var_acdc8d71)) {
      self.var_80780af2 = self.enemy_override.var_acdc8d71;
      return;
    }

    if(!self.isonnavmesh || self isatgoal()) {
      self function_d1e55248(#"hash_6e6d6ff06622efa4", 1);
      self pathmode("dont move", 1);
      self function_a57c34b7(self.enemy_override.origin);
    }

    return;
  }

  if(isDefined(self.favoriteenemy)) {
    if(isDefined(self.favoriteenemy.last_valid_position) && self.favoriteenemy.ai_zone === self.ai_zone) {
      self.var_80780af2 = self.favoriteenemy.last_valid_position;

      if(self.isonnavmesh) {
        self function_d1e55248(#"hash_6e6d6ff06622efa4", 0);
      }

      return;
    } else if(isDefined(self.favoriteenemy.last_valid_position) && !ispointonnavmesh(self.favoriteenemy.origin, self)) {
      if(!self.isonnavmesh && !self function_dd070839() || self isatgoal()) {
        self pathmode("dont move", 1);
        self function_d1e55248(#"hash_6e6d6ff06622efa4", 1);
      }
    }

    return;
  }

  self.var_ef59b90 = 1;
}

private function_34eacecd() {
  if(isDefined(self.enemy_override) || isDefined(self.favoriteenemy)) {
    self.var_ef59b90 = 3;
  }
}

private function_b793bca2() {
  self.var_ef59b90 = 1;
}

private function_101763c9() {
  self endon(#"death");
  spawn_point = self.ai_zone.spawn_points[randomint(self.ai_zone.spawn_points.size)];

  if(isDefined(self.var_31a789c0) && self.var_31a789c0) {
    self.var_8a96267d = 1;
    self waittill(#"is_underground");

    if(!isDefined(spawn_point)) {
      self kill();
    }

    wait 2;
    self forceteleport(spawn_point.origin, spawn_point.angles);
    wait 2;
    self.var_8ba6ede3 = 1;
    self waittill(#"not_underground");
  } else {
    self.var_8a96267d = 1;
    self waittill(#"is_screamed");

    if(!isDefined(spawn_point)) {
      self kill();
    }

    self forceteleport(spawn_point.origin, spawn_point.angles);
    wait 2;
    self.var_8ba6ede3 = 1;
    self waittill(#"not_underground");
  }

  self.var_ef59b90 = 1;
}

delayed_zombie_eye_glow() {
  self endon(#"death");

  if(isDefined(self.in_the_ground) && self.in_the_ground || isDefined(self.in_the_ceiling) && self.in_the_ceiling) {
    while(!isDefined(self.create_eyes)) {
      wait 0.1;
    }
  } else {
    wait 0.5;
  }

  self zombie_eye_glow();
}

zombie_eye_glow() {
  if(!isDefined(self) || !isactor(self)) {
    return;
  }

  if(!(isDefined(self.no_eye_glow) && self.no_eye_glow)) {
    self clientfield::set("zombie_has_eyes", 1);
  }
}

zombie_eye_glow_stop() {
  if(!isDefined(self) || !isactor(self)) {
    return;
  }

  if(!(isDefined(self.no_eye_glow) && self.no_eye_glow)) {
    self clientfield::set("zombie_has_eyes", 0);
  }
}

zombie_gut_explosion() {
  self.guts_explosion = 1;
  gibserverutils::annihilate(self);
}

zombie_death_event(params) {
  self thread zombie_eye_glow_stop();

  if(isDefined(params.weapon.doannihilate) && params.weapon.doannihilate || params.smeansofdeath === "MOD_GRENADE" || params.smeansofdeath === "MOD_GRENADE_SPLASH" || params.smeansofdeath === "MOD_EXPLOSIVE") {
    if(isDefined(params.weapon.doannihilate) && params.weapon.doannihilate) {
      tag = "J_SpineLower";

      if(isDefined(self.isdog) && self.isdog) {
        tag = "tag_origin";
      }

      if(isDefined(self.var_b69c12bc) && self.var_b69c12bc && !(isDefined(self.is_on_fire) && self.is_on_fire) && !(isDefined(self.guts_explosion) && self.guts_explosion)) {
        self thread zombie_gut_explosion();
      }
    }
  }
}

zombie_gib_on_damage() {
  self endon(#"death");

  while(true) {
    waitresult = self waittill(#"damage");
    self thread zombie_gib(waitresult.amount, waitresult.attacker, waitresult.direction, waitresult.position, waitresult.mod, waitresult.tag_name, waitresult.model_name, waitresult.part_name, waitresult.weapon);
  }
}

zombie_gib(amount, attacker, direction_vec, point, type, tagname, modelname, partname, weapon) {
  if(!isDefined(self)) {
    return;
  }

  if(!self zombie_should_gib(amount, attacker, type)) {
    return;
  }

  if(self head_should_gib(attacker, type, point) && type != "MOD_BURNED") {
    self zombie_head_gib(attacker, type);
    return;
  }

  if(!(isDefined(self.gibbed) && self.gibbed) && isDefined(self.damagelocation)) {
    if(self.damagelocation == "head" || self.damagelocation == "helmet" || self.damagelocation == "neck") {
      return;
    }

    switch (self.damagelocation) {
      case #"torso_upper":
      case #"torso_lower":
        if(!gibserverutils::isgibbed(self, 32)) {
          gibserverutils::gibrightarm(self);
        }

        break;
      case #"right_arm_lower":
      case #"right_arm_upper":
      case #"right_hand":
        if(!gibserverutils::isgibbed(self, 32)) {
          gibserverutils::gibrightarm(self);
        }

        break;
      case #"left_arm_lower":
      case #"left_arm_upper":
      case #"left_hand":
        if(!gibserverutils::isgibbed(self, 16)) {
          gibserverutils::gibleftarm(self);
        }

        break;
      case #"right_leg_upper":
      case #"left_leg_lower":
      case #"right_leg_lower":
      case #"left_foot":
      case #"right_foot":
      case #"left_leg_upper":
        break;
      default:
        if(self.damagelocation == "none") {
          if(type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH") {
            self derive_damage_refs(point);
            break;
          }
        }

        break;
    }

    if(isDefined(self.missinglegs) && self.missinglegs && self.health > 0) {
      level notify(#"crawler_created", {
        #zombie: self, 
        #player: attacker, 
        #weapon: weapon
      });
      self allowedstances("crouch");
      self setphysparams(15, 0, 24);
      self allowpitchangle(1);
      self setpitchorient();
      health = self.health;
      health *= 0.1;
    }
  }
}

derive_damage_refs(point) {
  if(!isDefined(level.gib_tags)) {
    init_gib_tags();
  }

  closesttag = undefined;

  for(i = 0; i < level.gib_tags.size; i++) {
    if(!isDefined(closesttag)) {
      closesttag = level.gib_tags[i];
      continue;
    }

    if(distancesquared(point, self gettagorigin(level.gib_tags[i])) < distancesquared(point, self gettagorigin(closesttag))) {
      closesttag = level.gib_tags[i];
    }
  }

  if(closesttag == "J_SpineLower" || closesttag == "J_SpineUpper" || closesttag == "J_Spine4") {
    gibserverutils::gibrightarm(self);
    return;
  }

  if(closesttag == "J_Shoulder_LE" || closesttag == "J_Elbow_LE" || closesttag == "J_Wrist_LE") {
    if(!gibserverutils::isgibbed(self, 16)) {
      gibserverutils::gibleftarm(self);
    }

    return;
  }

  if(closesttag == "J_Shoulder_RI" || closesttag == "J_Elbow_RI" || closesttag == "J_Wrist_RI") {
    if(!gibserverutils::isgibbed(self, 32)) {
      gibserverutils::gibrightarm(self);
    }

    return;
  }

  if(closesttag == "J_Hip_LE" || closesttag == "J_Knee_LE" || closesttag == "J_Ankle_LE") {
    gibserverutils::gibleftleg(self);

    if(randomint(100) > 75) {
      gibserverutils::gibrightleg(self);
    }

    self function_df5afb5e(1);
    return;
  }

  if(closesttag == "J_Hip_RI" || closesttag == "J_Knee_RI" || closesttag == "J_Ankle_RI") {
    gibserverutils::gibrightleg(self);

    if(randomint(100) > 75) {
      gibserverutils::gibleftleg(self);
    }

    self function_df5afb5e(1);
  }
}

init_gib_tags() {
  tags = [];
  tags[tags.size] = "J_SpineLower";
  tags[tags.size] = "J_SpineUpper";
  tags[tags.size] = "J_Spine4";
  tags[tags.size] = "J_Shoulder_LE";
  tags[tags.size] = "J_Elbow_LE";
  tags[tags.size] = "J_Wrist_LE";
  tags[tags.size] = "J_Shoulder_RI";
  tags[tags.size] = "J_Elbow_RI";
  tags[tags.size] = "J_Wrist_RI";
  tags[tags.size] = "J_Hip_LE";
  tags[tags.size] = "J_Knee_LE";
  tags[tags.size] = "J_Ankle_LE";
  tags[tags.size] = "J_Hip_RI";
  tags[tags.size] = "J_Knee_RI";
  tags[tags.size] = "J_Ankle_RI";
  level.gib_tags = tags;
}

function_df5afb5e(missinglegs = 0) {
  if(missinglegs) {
    self.knockdown = 0;
  }

  self.missinglegs = missinglegs;
}

zombie_should_gib(amount, attacker, type) {
  if(!isDefined(type)) {
    return false;
  }

  if(isDefined(self.is_on_fire) && self.is_on_fire) {
    return false;
  }

  if(isDefined(self.no_gib) && self.no_gib == 1) {
    return false;
  }

  prev_health = amount + self.health;

  if(prev_health <= 0) {
    prev_health = 1;
  }

  damage_percent = amount / prev_health * 100;
  weapon = undefined;

  if(isDefined(attacker)) {
    if(isplayer(attacker) || isDefined(attacker.can_gib_zombies) && attacker.can_gib_zombies) {
      if(isplayer(attacker)) {
        weapon = attacker getcurrentweapon();
      } else {
        weapon = attacker.weapon;
      }
    }
  }

  switch (type) {
    case #"mod_telefrag":
    case #"mod_unknown":
    case #"mod_burned":
    case #"mod_trigger_hurt":
    case #"mod_suicide":
    case #"mod_falling":
      return false;
    case #"mod_melee":
      return false;
  }

  if(type == "MOD_PISTOL_BULLET" || type == "MOD_RIFLE_BULLET") {
    if(!isDefined(attacker) || !isplayer(attacker)) {
      return false;
    }

    if(weapon == level.weaponnone || isDefined(level.start_weapon) && weapon == level.start_weapon || weapon.isgasweapon) {
      return false;
    }
  }

  return true;
}

head_should_gib(attacker, type, point) {
  if(isDefined(self.head_gibbed) && self.head_gibbed) {
    return false;
  }

  if(!isDefined(attacker) || !isplayer(attacker)) {
    if(!(isDefined(attacker.can_gib_zombies) && attacker.can_gib_zombies)) {
      return false;
    }
  }

  if(isplayer(attacker)) {
    weapon = attacker getcurrentweapon();
  } else {
    weapon = attacker.weapon;
  }

  if(type != "MOD_RIFLE_BULLET" && type != "MOD_PISTOL_BULLET") {
    if(type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH") {
      if(distance(point, self gettagorigin("j_head")) > 55) {
        return false;
      } else {
        return true;
      }
    } else if(type == "MOD_PROJECTILE") {
      if(distance(point, self gettagorigin("j_head")) > 10) {
        return false;
      } else {
        return true;
      }
    } else if(weapon.weapclass != "spread") {
      return false;
    }
  }

  if(!(self.damagelocation == "head" || self.damagelocation == "helmet" || self.damagelocation == "neck")) {
    return false;
  }

  if(type == "MOD_PISTOL_BULLET" && weapon.weapclass != "smg" || weapon == level.weaponnone || isDefined(level.start_weapon) && weapon == level.start_weapon || weapon.isgasweapon) {
    return false;
  }

  if(sessionmodeiscampaigngame() && type == "MOD_PISTOL_BULLET" && weapon.weapclass != "smg") {
    return false;
  }

  low_health_percent = self.health / self.maxhealth * 100;

  if(low_health_percent > 10) {
    return false;
  }

  return true;
}

zombie_head_gib(attacker, means_of_death) {
  self endon(#"death");

  if(isDefined(self.head_gibbed) && self.head_gibbed) {
    return;
  }

  self.head_gibbed = 1;
  self zombie_eye_glow_stop();

  if(!(isDefined(self.disable_head_gib) && self.disable_head_gib)) {
    gibserverutils::gibhead(self);
  }

  self thread damage_over_time(ceil(self.health * 0.2), 1, attacker, means_of_death);
}

damage_over_time(dmg, delay, attacker, means_of_death) {
  self endon(#"death", #"exploding");

  if(!isalive(self)) {
    return;
  }

  if(!isplayer(attacker)) {
    attacker = self;
  }

  if(!isDefined(means_of_death)) {
    means_of_death = "MOD_UNKNOWN";
  }

  while(true) {
    if(isDefined(delay)) {
      wait delay;
    }

    if(isDefined(self)) {
      if(isDefined(attacker)) {
        self dodamage(dmg, self gettagorigin("j_neck"), attacker, self, self.damagelocation, means_of_death, 4096, self.damageweapon);
        continue;
      }

      self dodamage(dmg, self gettagorigin("j_neck"));
    }
  }
}

event_handler[bhtn_action_start] function_320145f7(eventstruct) {
  notify_string = eventstruct.action;

  switch (notify_string) {
    case #"death":
      level thread zmbaivox_playvox(self, notify_string, 1, 4);
      break;
    case #"pain":
      level thread zmbaivox_playvox(self, notify_string, 1, 3);
      break;
    case #"behind":
      level thread zmbaivox_playvox(self, notify_string, 1, 3);
      break;
    case #"attack_melee_notetrack":
      level thread zmbaivox_playvox(self, "attack_melee", 1, 2, 1);
      break;
    case #"chase_state_start":
      level thread zmbaivox_playvox(self, "sprint", 1, 2);
      break;
    case #"sprint":
    case #"ambient":
    case #"crawler":
    case #"teardown":
    case #"taunt":
      level thread zmbaivox_playvox(self, notify_string, 0, 1);
      break;
    case #"attack_melee":
      break;
    default:
      level thread zmbaivox_playvox(self, notify_string, 0, 2);
      break;
  }
}

zmbaivox_playvox(zombie, type, override, priority, delayambientvox = 0) {
  zombie endon(#"death");

  if(!isDefined(zombie)) {
    return;
  }

  if(!isDefined(zombie.voiceprefix)) {
    return;
  }

  if(!isDefined(priority)) {
    priority = 1;
  }

  if(!isDefined(zombie.talking)) {
    zombie.talking = 0;
  }

  if(!isDefined(zombie.currentvoxpriority)) {
    zombie.currentvoxpriority = 1;
  }

  if(!isDefined(self.delayambientvox)) {
    self.delayambientvox = 0;
  }

  if((type == "ambient" || type == "sprint" || type == "crawler") && isDefined(self.delayambientvox) && self.delayambientvox) {
    return;
  }

  if(delayambientvox) {
    self.delayambientvox = 1;
    self thread zmbaivox_ambientdelay();
  }

  alias = "zmb_vocals_" + zombie.voiceprefix + "_" + type;

  if(sndisnetworksafe()) {
    if(isDefined(override) && override) {
      if(isDefined(zombie.currentvox) && priority >= zombie.currentvoxpriority) {
        zombie stopsound(zombie.currentvox);
      }

      if(type == "death" || type == "death_whimsy" || type == "death_nohead") {
        zombie playSound(alias);
        return;
      }
    }

    if(zombie.talking === 1 && (priority < zombie.currentvoxpriority || priority === 1)) {
      return;
    }

    zombie.talking = 1;
    zombie.currentvox = alias;
    zombie.currentvoxpriority = priority;
    zombie playsoundontag(alias, "j_head");
    playbacktime = soundgetplaybacktime(alias);

    if(!isDefined(playbacktime)) {
      playbacktime = 1;
    }

    if(playbacktime >= 0) {
      playbacktime *= 0.001;
    } else {
      playbacktime = 1;
    }

    wait playbacktime;
    zombie.talking = 0;
    zombie.currentvox = undefined;
    zombie.currentvoxpriority = 1;
  }
}

zmbaivox_ambientdelay() {
  self notify(#"sndambientdelay");
  self endon(#"sndambientdelay", #"death", #"disconnect");
  wait 2;
  self.delayambientvox = 0;
}

networksafereset() {
  while(true) {
    level._numzmbaivox = 0;
    waitframe(1);
  }
}

sndisnetworksafe() {
  if(!isDefined(level._numzmbaivox)) {
    level thread networksafereset();
  }

  if(level._numzmbaivox >= 2) {
    return false;
  }

  level._numzmbaivox++;
  return true;
}

function_6c308e81() {
  self thread play_ambient_zombie_vocals();
  self thread zmbaivox_playdeath();
}

play_ambient_zombie_vocals() {
  self endon(#"death");
  self thread function_b8c2c5cc();

  while(true) {
    type = "ambient";
    float = 3;

    if(isDefined(self.aistate)) {
      switch (self.aistate) {
        case 0:
        case 1:
        case 2:
        case 4:
          type = "ambient";
          float = 3;
          break;
        case 3:
          type = "sprint";
          float = 3;
          break;
      }
    }

    if(isDefined(self.missinglegs) && self.missinglegs) {
      float = 2;
      type = "crawler";
    }

    bhtnactionstartevent(self, type);
    self notify(#"bhtn_action_notify", {
      #action: type
    });
    wait randomfloatrange(1, float);
  }
}

zmbaivox_playdeath() {
  self endon(#"disconnect");
  self waittill(#"death");

  if(isDefined(self)) {
    level thread zmbaivox_playvox(self, "death", 1);
  }
}

function_b8c2c5cc() {
  self endon(#"death", #"disconnect");

  while(true) {
    self waittill(#"reset_pathing");

    if(self.aistate == 3) {
      bhtnactionstartevent(self, "chase_state_start");
    }
  }
}