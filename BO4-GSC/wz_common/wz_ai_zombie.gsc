/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_ai_zombie.gsc
***********************************************/

#include scripts\abilities\gadgets\gadget_concertina_wire;
#include scripts\abilities\gadgets\gadget_cymbal_monkey;
#include scripts\abilities\gadgets\gadget_homunculus;
#include scripts\abilities\wz\gadgets\gadget_concertina_wire;
#include scripts\core_common\ai\archetype_damage_utility;
#include scripts\core_common\ai\archetype_locomotion_utility;
#include scripts\core_common\ai\systems\animation_state_machine_mocomp;
#include scripts\core_common\ai\systems\animation_state_machine_notetracks;
#include scripts\core_common\ai\systems\animation_state_machine_utility;
#include scripts\core_common\ai\systems\behavior_state_machine;
#include scripts\core_common\ai\systems\behavior_tree_utility;
#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\ai\zombie;
#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\infection;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\system_shared;
#include scripts\core_common\throttle_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\mp_common\armor;
#include scripts\mp_common\player\player_damage;
#include scripts\wz_common\wz_ai_utils;
#include scripts\wz_common\wz_ai_zonemgr;

#namespace wz_ai_zombie;

autoexec __init__system__() {
  system::register(#"wz_ai_zombie", &__init__, &__main__, undefined);
}

private __init__() {
  clientfield::register("actor", "zombie_riser_fx", 1, 1, "int");
  clientfield::register("actor", "zombie_has_eyes_col", 13000, 2, "int");
  clientfield::register("actor", "zombie_has_microwave", 1, 1, "int");
  clientfield::register("toplayer", "zombie_vehicle_shake", 19000, 1, "counter");
  level.var_8de0b84e = [];
  level.var_a2fbb776 = 0;
  level.var_12956b7c = 29;
  level.var_6838a92d = 5;
  level.var_b8ce09f3 = 2000;
  level.var_c83a9084 = 0;
  level.var_3ee83e3f = [];
  level.var_3ee83e3f[0] = #"grass";
  level.var_3ee83e3f[1] = #"sand";
  level.var_3ee83e3f[2] = #"dirt";
  level.var_3ee83e3f[3] = #"mud";
  level.var_3ee83e3f[4] = #"rock";
  level.var_3ee83e3f[5] = #"asphalt";
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
  level.var_9ee73630[#"super_super_sprint"][#"down"] = 1;
  level.var_9ee73630[#"super_super_sprint"][#"up"] = 1;
  spawner::add_archetype_spawn_function(#"zombie", &function_cf051788);

  if(getdvarint(#"survival_prototype", 0) || getdvarint(#"cluster_awareness", 0)) {
    spawner::function_89a2cd87(#"zombie", &function_b670d610);
    level thread function_7a84e563();
    level thread function_cb2c8fea();
    callback::on_spawned(&function_25b61968);
  }

  initzombiebehaviors();

  if(getdvarint(#"survival_prototype", 0) || getdvarint(#"cluster_awareness", 0)) {
    function_d2106375();

    level thread function_ef4bd1a6();

  }

  val::register("allowoffnavmesh", 1);
  val::default_value("allowoffnavmesh", 0);
  val::register("blockingpain", 1);
  val::default_value("blockingpain", 0);
  level.attackablecallback = &attackable_callback;
  level.var_cdc822b = &function_cdc822b;
  level.var_a6a84389 = &function_a6a84389;
  level.var_eeb66e64 = &function_839910c5;
  level.custom_melee_fire = &custom_melee_fire;
}

private __main__() {
  if(isDefined(getgametypesetting(#"wzzombiesattackablesenabled")) ? getgametypesetting(#"wzzombiesattackablesenabled") : 0) {
    callback::add_callback(#"hash_70eeb7d813f149b2", &function_cf065988);
    callback::add_callback(#"hash_15858698313c5f32", &function_b0503d98);
    callback::add_callback(#"hash_6d9bdacc6c29cfa5", &function_68cc8bce);
    callback::add_callback(#"on_turret_destroyed", &on_turret_destroyed);
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

function_68cc8bce(params) {
  owner = params.owner;
  turret = params.turret;
  owner endon(#"death");
  turret endon(#"death");
  slots = wz_ai_utils::function_bdb2b85b(turret, turret.origin, turret.angles, 30, 4, 300);

  if(!isDefined(slots) || slots.size <= 0) {
    return;
  }

  turret.var_b79a8ac7 = {
    #var_f019ea1a: 500, 
    #slots: slots
  };
  turret.var_ba721a2c = 20;
  level.attackables[level.attackables.size] = turret;
}

on_turret_destroyed(params) {
  owner = params.owner;
  turret = params.turret;

  if(isDefined(turret.var_b79a8ac7) && isDefined(turret.var_b79a8ac7.slots)) {
    foreach(slot in turret.var_b79a8ac7.slots) {
      if(isDefined(slot.entity)) {
        wz_ai_utils::function_2b925fa5(slot.entity);
      }
    }

    arrayremovevalue(level.attackables, turret);
  }
}

function_cf065988(params) {
  owner = params.owner;
  cover = params.cover;
  owner endon(#"death");
  cover endon(#"death");
  slots = wz_ai_utils::function_bdb2b85b(cover, owner.smartcover.lastvalid.origin, owner.smartcover.lastvalid.angles, owner.smartcover.lastvalid.width / 2 + 12, 6, level.smartcoversettings.bundle.var_b345c668);

  if(!isDefined(slots) || slots.size <= 0) {
    return;
  }

  cover.var_b79a8ac7 = {
    #slots: slots
  };
  cover.var_ba721a2c = 1;
  cover.var_d83d7db3 = 100;
  level.attackables[level.attackables.size] = cover;
}

function_b0503d98(params) {
  owner = params.owner;
  cover = params.cover;

  if(isDefined(cover.var_b79a8ac7) && isDefined(cover.var_b79a8ac7.slots)) {
    foreach(slot in cover.var_b79a8ac7.slots) {
      if(isDefined(slot.entity)) {
        wz_ai_utils::function_2b925fa5(slot.entity);
      }
    }
  }

  arrayremovevalue(level.attackables, cover);
}

custom_melee_fire() {
  idflags = 0;

  if(isDefined(self.enemy) && isDefined(self.enemy.armor) && self.enemy.armor) {
    idflags |= 2048;
  }

  melee_dir = undefined;

  if(isDefined(self.attackable)) {
    melee_dir = self.attackable.origin - self getcentroid();
  } else if(isDefined(self.meleeweapon) && isDefined(self.enemy) && isplayer(self.enemy) && self.enemy haspart("j_spine4")) {
    eye_pos = self getEye();
    vehicle = self.enemy getvehicleoccupied();

    if(isDefined(vehicle) && vehicle.scriptvehicletype == #"player_motorcycle") {
      hitent = self function_987a9b39(self.enemy gettagorigin("j_spine4") - eye_pos, idflags);
    }
  }

  if(!isDefined(hitent)) {
    hitent = self melee(melee_dir, idflags);
  }

  if(isDefined(hitent)) {
    if(isvehicle(hitent)) {
      damage = self.var_a0193213;

      if(isDefined(self.is_miniboss) && self.is_miniboss) {
        damage = randomintrange(850, 1200);
      }

      function_2713ff17(hitent, damage);
    }

    if(self.attackable === hitent) {
      var_aabf4080 = undefined;

      if(isDefined(hitent.startinghealth)) {
        var_aabf4080 = hitent.startinghealth;
      } else if(isDefined(hitent.maxhealth)) {
        var_aabf4080 = hitent.maxhealth;
      }

      if(isDefined(var_aabf4080)) {
        if(isDefined(self.is_miniboss) && self.is_miniboss) {
          damage = int(var_aabf4080 / 2) + 1;
          hitent dodamage(damage, hitent.origin, self, self);
        } else {
          damage = int(var_aabf4080 / 20) + 1;
          hitent dodamage(damage, hitent.origin, self, self);
        }
      }
    }
  }

  return hitent;
}

function_cdc822b() {
  self.isonnavmesh = ispointonnavmesh(self.origin, self getpathfindingradius() / 1.0125);

  if(isDefined(self.ai_zone) || isDefined(self.isonnavmesh) && self.isonnavmesh) {
    return true;
  }

  return false;
}

debugline(frompoint, topoint, color, durationframes) {
  for(i = 0; i < durationframes * 20; i++) {
    line(frompoint, topoint, color);
    waitframe(1);
  }
}

drawdebugcross(atpoint, radius, color, durationframes) {
  if(getdvarint(#"survival_prototype", 0) || !(isDefined(level.var_e066667d) && level.var_e066667d)) {
    return;
  }

  atpoint_high = atpoint + (0, 0, radius);
  atpoint_low = atpoint + (0, 0, -1 * radius);
  atpoint_left = atpoint + (0, radius, 0);
  atpoint_right = atpoint + (0, -1 * radius, 0);
  atpoint_forward = atpoint + (radius, 0, 0);
  atpoint_back = atpoint + (-1 * radius, 0, 0);
  thread debugline(atpoint_high, atpoint_low, color, durationframes);
  thread debugline(atpoint_left, atpoint_right, color, durationframes);
  thread debugline(atpoint_forward, atpoint_back, color, durationframes);
}

  function function_a6a84389(playerradius) {
    position = getclosestpointonnavmesh(self.origin - (0, 0, 100), 100, playerradius);

    if(isDefined(position)) {
      player_position = self.origin + (0, 0, 20);
      var_f5df51f2 = position + (0, 0, 20);

      if(bullettracepassed(player_position, var_f5df51f2, 0, self)) {
        self.last_valid_position = position;
      }
    } else {
      position = getclosestpointonnavmesh(self.origin - (0, 0, 100), 200, playerradius);

      if(isDefined(position)) {
        player_position = self.origin + (0, 0, 20);
        var_f5df51f2 = position + (0, 0, 20);

        if(bullettracepassed(player_position, var_f5df51f2, 0, self)) {
          self.last_valid_position = position;
        }
      }
    }

    drawdebugcross(self.last_valid_position, 5, (1, 0, 0), 1);

      return self.last_valid_position;
  }

function_2713ff17(vehicle, damage_amount) {
  if(isDefined(vehicle)) {
    vehicle dodamage(damage_amount, vehicle.origin);
    org = vehicle.origin;
    nearby_players = getentitiesinradius(vehicle.origin, vehicle.radius, 1);

    foreach(player in nearby_players) {
      if(isDefined(vehicle getoccupantseat(player)) || player getgroundent() === vehicle || player getmoverent() === vehicle && player istouching(player getmoverent())) {
        player clientfield::increment_to_player("zombie_vehicle_shake", 1);
      }
    }
  }
}

attackable_callback(entity) {
  function_2713ff17(self, entity.var_a0193213);
}

initzombiebehaviors() {
  assert(isscriptfunctionptr(&function_e91d8371));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombieupdatethrottle", &function_e91d8371, 2);
  assert(isscriptfunctionptr(&function_5aeeecac));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3ac312897079296a", &function_5aeeecac, 2);
  assert(isscriptfunctionptr(&function_eea7a68a));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_300dd0c6326499f2", &function_eea7a68a, 1);
  assert(isscriptfunctionptr(&zombieshouldmelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombieshouldmelee", &zombieshouldmelee);
  assert(isscriptfunctionptr(&function_d8b225ae));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombieshouldmeleeattackable", &function_d8b225ae);
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
  assert(isscriptfunctionptr(&function_bfc25c77));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_502cf2e8eca970f0", &function_bfc25c77);
  assert(isscriptfunctionptr(&function_b9b03294));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_91cfd1edd5185d1", &function_b9b03294);
  assert(isscriptfunctionptr(&function_c711d679));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_53dd60145334e75a", &function_c711d679);
  assert(isscriptfunctionptr(&function_37abea6f));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_2b17bbf6d0ceff72", &function_37abea6f);
  assert(isscriptfunctionptr(&function_c7f10f39));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_35230f28e597f859", &function_c7f10f39);
  assert(isscriptfunctionptr(&function_638581d2));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_44f23dd5a213d52a", &function_638581d2);
  assert(isscriptfunctionptr(&zombieshouldknockdown));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombieshouldknockdown", &zombieshouldknockdown);
  assert(isscriptfunctionptr(&function_2a7b4aab));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombieinwire", &function_2a7b4aab);
  assert(isscriptfunctionptr(&function_55b7ea22));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_336e28ae1ed4640b", &function_55b7ea22);
  assert(isscriptfunctionptr(&function_98b102d8));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_53e4632b82a3a930", &function_98b102d8);
  assert(isscriptfunctionptr(&function_6ec0bcc1));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_791763042d13fef1", &function_6ec0bcc1);
  assert(isscriptfunctionptr(&function_6f4ab71c));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_8ad1466eac37282", &function_6f4ab71c);
  assert(isscriptfunctionptr(&function_4402c40a));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_24de191ac3416c18", &function_4402c40a);
  assert(isscriptfunctionptr(&function_6a3bcddc));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_33c14e313f684eab", &function_6a3bcddc);
  assert(isscriptfunctionptr(&function_4402c40a));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_24de191ac3416c18", &function_4402c40a);
  assert(isscriptfunctionptr(&function_6a3bcddc));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_33c14e313f684eab", &function_6a3bcddc);
  assert(isscriptfunctionptr(&zombiemoveactionstart));
  behaviorstatemachine::registerbsmscriptapiinternal(#"wzzombiemoveactionstart", &zombiemoveactionstart);
  assert(isscriptfunctionptr(&zombiemoveactionupdate));
  behaviorstatemachine::registerbsmscriptapiinternal(#"wzzombiemoveactionupdate", &zombiemoveactionupdate);
  assert(isscriptfunctionptr(&zombiemoveactionstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombiemoveactionstart", &zombiemoveactionstart);
  assert(isscriptfunctionptr(&zombiemoveactionupdate));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombiemoveactionupdate", &zombiemoveactionupdate);
  assert(isscriptfunctionptr(&function_a0acf641));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_796d69f77ff45304", &function_a0acf641);
  assert(isscriptfunctionptr(&function_6a2634da));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_205c6638add95fc5", &function_6a2634da);
  assert(isscriptfunctionptr(&function_7c8e35e8));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5b037e170b517862", &function_7c8e35e8);
  assert(isscriptfunctionptr(&function_66e2c5fb));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_79acdac8ad5d0019", &function_66e2c5fb);
  assert(!isDefined(&function_7c8e35e8) || isscriptfunctionptr(&function_7c8e35e8));
  assert(!isDefined(&function_fee7d867) || isscriptfunctionptr(&function_fee7d867));
  assert(!isDefined(&function_3f71b9c2) || isscriptfunctionptr(&function_3f71b9c2));
  behaviortreenetworkutility::registerbehaviortreeaction(#"hash_5bd00a38dffd47e", &function_7c8e35e8, &function_fee7d867, &function_3f71b9c2);
  assert(isscriptfunctionptr(&zombieknockdownactionstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombieknockdownactionstart", &zombieknockdownactionstart);
  assert(isscriptfunctionptr(&function_c8939973));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7a21325931f5ca2f", &function_c8939973);
  assert(isscriptfunctionptr(&zombiegetupactionterminate));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombiegetupactionterminate", &zombiegetupactionterminate);
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&function_78106a79) || isscriptfunctionptr(&function_78106a79));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  behaviortreenetworkutility::registerbehaviortreeaction(#"wzzombiestunnedloop", undefined, &function_78106a79, undefined);
  assert(isscriptfunctionptr(&function_f8250d5e));
  behaviorstatemachine::registerbsmscriptapiinternal(#"wzzombieidleactionstart", &function_f8250d5e);
  assert(isscriptfunctionptr(&function_860d5d8));
  behaviorstatemachine::registerbsmscriptapiinternal(#"wzzombieidleactionupdate", &function_860d5d8);
  assert(isscriptfunctionptr(&function_f8250d5e));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombieidleactionstart", &function_f8250d5e);
  assert(isscriptfunctionptr(&function_860d5d8));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombieidleactionupdate", &function_860d5d8);
  assert(isscriptfunctionptr(&function_f37b0fbd));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombiewaitfortraversalstart", &function_f37b0fbd);
  animationstatenetwork::registernotetrackhandlerfunction("zombieRiserFx", &function_79c3a487);
  animationstatenetwork::registernotetrackhandlerfunction("showZombie", &showzombie);
  animationstatenetwork::registernotetrackhandlerfunction("damageDoor", &damagedoor);
  animationstatenetwork::registeranimationmocomp("mocomp_zombie_attack_attackable", &function_81349d20, undefined, undefined);
}

private function_81349d20(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(isDefined(self.attackable)) {
    self orientmode("face point", self.attackable.origin);
  } else {
    self orientmode("face current");
  }

  self animmode("angle deltas");
}

private function_cf051788() {
  self callback::function_d8abfc3d(#"on_ai_melee", &zombie_on_melee);
  self callback::function_d8abfc3d(#"hash_3bb51ce51020d0eb", &wz_ai_utils::function_16e2f075);

  if(getdvarint(#"survival_prototype", 0) || getdvarint(#"cluster_awareness", 0)) {
    self callback::function_d8abfc3d(#"hash_10ab46b52df7967a", &function_bb3c1175);
  } else {
    self callback::function_d8abfc3d(#"on_ai_damage", &function_3d9b8ab3);
    self callback::function_d8abfc3d(#"on_ai_killed", &zombie_death_event);
  }

  aiutility::addaioverridedamagecallback(self, &function_c75fae30);
  self.var_65e57a10 = 1;
  self.clamptonavmesh = 0;
  self.var_ff3f3261 = 0;

  if(isDefined(level.var_ff8e9324) && (self.aitype == #"spawner_boct_zombie_wz" || self.aitype == #"spawner_boct_zombie_mob_wz")) {
    if(randomint(100) <= level.var_ff8e9324) {
      self.var_ff3f3261 = 1;
    }
  }

  if(isDefined(level.var_e8ef5457)) {
    self.var_ff3f3261 = level.var_e8ef5457;
  }

  self.ignorepathenemyfightdist = 1;
  self.var_bb185cc5 = 0;
  self.var_1c0eb62a = 180;
  self.var_737e8510 = 128;
  self wz_ai_utils::function_9758722("walk");
  self.spawn_anim = "ai_zombie_base_traverse_ground_climbout_fast";
  self.var_b8c61fc5 = 1;
  self thread function_6c308e81();
  self thread zombie_gib_on_damage();

  if(getdvarint(#"survival_prototype", 0) || getdvarint(#"cluster_awareness", 0)) {
    self.var_16dd87ad = 0.1;
    self.spawn_anim = "ai_t8_zombie_traverse_ground_dugup";
    self.clamptonavmesh = 1;
    self setavoidancemask("avoid actor");
  } else {
    self thread function_e261b81d();
  }

  self.maxhealth = level.startinghealth;
  self.health = self.maxhealth;
  self.cant_move_cb = &function_9c573bc6;
  self.var_31a789c0 = 1;
  self.itemdropcount = 1;
  self.isonnavmeshcount = 0;
  self.surfacetype = "";
  self.var_db912cfe = 1;
  self.var_a0193213 = 50;
  self.var_46618155 = 1;

  if(!getdvarint(#"survival_prototype", 0)) {
    self.var_15fe3985 = 1;
  }

  self.var_de6e22f7 = 1;
  self.var_13138acf = 1;
  self.var_2c628c0f = 1;
  self.var_20e07206 = 1;
  self.var_721a3dbd = 1;
  self.var_35eedf58 = 1;
  self.instakill_doors = 1;
  self.is_special = 0;
}

function_b670d610() {
  setup_awareness(self);
  self thread function_41dc2cb0();
}

isheadshot(shitloc) {
  if(isDefined(shitloc) && (shitloc == "head" || shitloc == "helmet")) {
    return true;
  }

  return false;
}

private function_c75fae30(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  if(isactor(eattacker) && eattacker.team == self.team) {
    return 0;
  }

  if(isplayer(eattacker) && eattacker infection::is_infected()) {
    return 0;
  }

  if(isheadshot(shitloc)) {
    idamage *= 2;
  }

  if(isDefined(weapon) && smeansofdeath !== "MOD_DOT") {
    dot_params = function_f74d2943(weapon, 7);

    if(isDefined(dot_params)) {
      status_effect::status_effect_apply(dot_params, weapon, einflictor);
    }
  }

  idamage = player::function_74a5d514(eattacker, idamage, smeansofdeath, weapon, shitloc);
  var_3b037158 = isDefined(weapon) && isarray(level.var_7fc48a1a) && isinarray(level.var_7fc48a1a, weapon);

  if(var_3b037158 && isDefined(einflictor)) {
    if(!isDefined(self.attackable) && isDefined(einflictor.var_b79a8ac7)) {
      if(einflictor wz_ai_utils::get_attackable_slot(self)) {
        self.attackable = einflictor;
      }
    }

    if(isDefined(einflictor.var_d83d7db3)) {
      if(isDefined(self.var_1b3acc36) && gettime() < self.var_1b3acc36) {
        return 0;
      } else {
        self.var_1b3acc36 = gettime() + einflictor.var_d83d7db3;
      }
    }

    idamage = isDefined(einflictor.var_ba721a2c) ? einflictor.var_ba721a2c : idamage;
  }

  if(isDefined(level.var_85a39c96) && level.var_85a39c96) {
    idamage = self.health + 1;
  }

    if((getdvarint(#"survival_prototype", 0) || getdvarint(#"cluster_awareness", 0)) && isDefined(weapon) && (!isDefined(weapon.statname) || weapon.statname !== #"melee_bowie" && weapon.statname !== #"hatchet") && !isDefined(self.enemy_override) && !isDefined(self.favoriteenemy) && isDefined(eattacker) && isplayer(eattacker)) {
      self function_efc86793(self.origin, 300, self.team, 5, eattacker);
    }

  return idamage;
}

private function_3d9b8ab3(params) {
  if(!isDefined(self.enemy_override) && !isDefined(self.favoriteenemy) && isDefined(params.eattacker) && isplayer(params.eattacker)) {
    self.favoriteenemy = params.eattacker;
    self.var_bb185cc5 = gettime();
  }
}

function_9c573bc6() {
  self notify("3181030c4896e54e");
  self endon("16e9d2db81fbdb7b", #"death");

  if(isDefined(self.enemy_override)) {
    return;
  }

  if(isDefined(self.allowoffnavmesh) && self.allowoffnavmesh && isDefined(level.var_5e8121a) && level.var_5e8121a && isDefined(self.var_35eedf58) && self.var_35eedf58) {
    self.var_ef59b90 = 5;
    return;
  } else if(self.aistate === 3 && isDefined(self.canseeplayer) && self.canseeplayer) {
    if(isDefined(self.favoriteenemy) && isDefined(self.var_de6e22f7) && self.var_de6e22f7 && !self.var_13138acf) {
      self.var_ef59b90 = 6;
      return;
    }

    self.var_ef59b90 = 5;
    return;
  }

  self collidewithactors(0);
  wait 2;
  self collidewithactors(1);
}

private function_e91d8371(entity) {
  level.var_8de0b84e[level.var_a2fbb776] = entity getentitynumber();
  level.var_a2fbb776 = (level.var_a2fbb776 + 1) % 2;

  if((getdvarint(#"survival_prototype", 0) || getdvarint(#"cluster_awareness", 0)) && isDefined(entity.has_awareness) && entity.has_awareness) {
    function_eea7a68a(entity);
  }
}

private zombieshouldmelee(entity) {
  if(isDefined(entity.var_8a96267d) && entity.var_8a96267d || isDefined(entity.var_8ba6ede3) && entity.var_8ba6ede3) {
    return false;
  }

  if(isDefined(entity.var_4c85ebad) && entity.var_4c85ebad) {
    return true;
  }

  if(isDefined(entity.enemy_override)) {
    return false;
  }

  if(function_d8b225ae(entity)) {
    return true;
  }

  if(!isDefined(entity.enemy)) {
    return false;
  }

  if(!wz_ai_utils::is_player_valid(entity.enemy) && !function_f41ded83(entity.enemy)) {
    return false;
  }

  if(isDefined(entity.ignoremelee) && entity.ignoremelee) {
    return false;
  }

  meleedistsq = zombiebehavior::function_997f1224(entity);
  enemy_vehicle = undefined;
  test_origin = entity.enemy.origin;

  if(function_f41ded83(entity.enemy)) {
    test_origin = entity.enemy.origin;
  } else if(function_142c3c86(entity.enemy, entity)) {
    enemy_vehicle = entity.enemy getvehicleoccupied();
    var_81952387 = enemy_vehicle.origin;

    for(i = 0; i < 11; i++) {
      if(enemy_vehicle function_dcef0ba1(i)) {
        var_ec950ebd = enemy_vehicle function_defc91b2(i);

        if(isDefined(var_ec950ebd) && var_ec950ebd >= 0) {
          seat_pos = enemy_vehicle function_5051cc0c(i);

          if(distancesquared(entity.origin, var_81952387) > distancesquared(entity.origin, seat_pos)) {
            var_81952387 = seat_pos;
          }
        }
      }
    }

    test_origin = var_81952387;
  } else if(isvehicle(entity.enemy getgroundent())) {
    enemy_vehicle = entity.enemy getgroundent();
    test_origin = isDefined(entity.enemy.last_valid_position) ? entity.enemy.last_valid_position : entity.enemy.origin;
  } else if(isplayer(entity.enemy) && isvehicle(entity.enemy getmoverent())) {
    enemy_vehicle = entity.enemy getmoverent();
    test_origin = isDefined(entity.enemy.last_valid_position) ? entity.enemy.last_valid_position : entity.enemy.origin;
  }

  if(isDefined(enemy_vehicle) && isDefined(entity.var_cbc65493)) {
    meleedistsq *= entity.var_cbc65493;
  }

  if(abs(entity.origin[2] - test_origin[2]) > (isDefined(entity.var_737e8510) ? entity.var_737e8510 : 64)) {
    return false;
  }

  if(function_f41ded83(entity.enemy)) {
    if(distance2dsquared(entity.origin, test_origin) > meleedistsq) {
      return false;
    }
  } else if(distancesquared(entity.origin, test_origin) > meleedistsq) {
    return false;
  }

  yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);

  if(abs(yawtoenemy) > (isDefined(entity.var_1c0eb62a) ? entity.var_1c0eb62a : 60)) {
    return false;
  }

  if(!entity cansee(isDefined(enemy_vehicle) ? enemy_vehicle : entity.enemy)) {
    return false;
  }

  if(distancesquared(entity.origin, test_origin) < 40 * 40) {
    entity.idletime = gettime();
    entity.idleorigin = entity.origin;
    return true;
  }

  if(isDefined(enemy_vehicle)) {
    entity.idletime = gettime();
    entity.idleorigin = entity.origin;
    return true;
  }

  if(!function_f41ded83(entity.enemy) && isDefined(self.isonnavmesh) && self.isonnavmesh && !tracepassedonnavmesh(entity.origin, isDefined(entity.enemy.last_valid_position) ? entity.enemy.last_valid_position : entity.enemy.origin, entity.enemy getpathfindingradius())) {
    return false;
  }

  entity.idletime = gettime();
  entity.idleorigin = entity.origin;
  return true;
}

private function_d8b225ae(entity) {
  if(!isDefined(entity.attackable)) {
    return false;
  }

  if(isDefined(entity.var_b238ef38) && distance2dsquared(entity.origin, entity.var_b238ef38.position) < 16 * 16 && abs(entity.origin[2] - entity.var_b238ef38.position[2]) < 50) {
    return true;
  }

  return false;
}

private function_e8f3596d(entity) {
  return isDefined(entity.var_8a96267d) && entity.var_8a96267d;
}

private function_cc184b8b(entity) {
  return isDefined(entity.var_8ba6ede3) && entity.var_8ba6ede3;
}

private function_562c0e1d(entity) {
  return entity haspath() || isDefined(entity.is_digging) && entity.is_digging || entity.allowoffnavmesh;
}

private function_a58eaeea(entity) {
  return !(isDefined(entity.missinglegs) && entity.missinglegs) && isDefined(entity.shouldreact) && entity.shouldreact;
}

private zombieshouldmove(entity) {
  return entity.allowoffnavmesh || entity haspath();
}

private function_c711d679(entity) {
  if(isDefined(entity.var_1a3ca72b) && entity.var_1a3ca72b) {
    return false;
  }

  return true;
}

private function_37abea6f(entity) {
  return isDefined(entity.var_4c4ad20a) && entity.var_4c4ad20a;
}

private function_c7f10f39(entity) {
  return isDefined(entity.var_3f2dc1d) && entity.var_3f2dc1d;
}

private function_638581d2(entity) {
  entity.var_13138acf = 1;
  entity.var_3f2dc1d = undefined;
  entity.var_ef59b90 = 3;
  return true;
}

zombie_on_melee() {
  var_d54999e4 = ee_head(self, 1.5);

  foreach(dynent in var_d54999e4) {
    if(function_8f57dc52(dynent)) {
      var_f3fec032 = function_489009c1(dynent);
      setdynentstate(dynent, var_f3fec032.destroyed);
    }
  }

  self.var_4c85ebad = undefined;
}

private function_8f57dc52(dynent) {
  if(isDefined(dynent)) {
    dynentstate = function_ffdbe8c2(dynent);
    var_f3fec032 = function_489009c1(dynent);

    if(!dynent.destructible || !dynent.var_e76c7e9f || !isDefined(var_f3fec032) || !isDefined(var_f3fec032.destroyed) || dynentstate === var_f3fec032.destroyed || dynentstate === var_f3fec032.vehicledestroyed || isDefined(dynent.var_993e9bb0) && dynent.var_993e9bb0) {
      return false;
    }

    return true;
  }

  return false;
}

private ee_head(entity, var_30ce4d1e = 1, forwardoffset) {
  if(!isactor(entity)) {
    return [];
  }

  if(!isDefined(forwardoffset)) {
    forwardoffset = anglesToForward(entity.angles) * entity getpathfindingradius();
  }

  return function_c3d68575(entity.origin + forwardoffset, (entity getpathfindingradius() * var_30ce4d1e, entity getpathfindingradius() * var_30ce4d1e, entity function_6a9ae71() * var_30ce4d1e));
}

private function_5aeeecac(entity) {
  if(isDefined(entity.var_4c85ebad) && entity.var_4c85ebad) {
    return;
  }

  radiusmultiplier = entity.var_e729ffb;

  if(!isDefined(radiusmultiplier)) {
    radiusmultiplier = 3;
  }

  forwardoffset = anglesToForward(entity.angles) * entity getpathfindingradius() * radiusmultiplier;
  var_d54999e4 = ee_head(entity, 0.8, forwardoffset);

  foreach(dynent in var_d54999e4) {
    if(function_8f57dc52(dynent)) {
      entity.var_4c85ebad = 1;
      return;
    }
  }
}

private function_c9153928(entity, position) {
  origin = position;

  if(!isDefined(origin)) {
    if(isDefined(self.enemy_override)) {
      origin = self.enemy_override.origin;
    } else if(isDefined(self.favoriteenemy)) {
      origin = self.favoriteenemy.origin;
    }

    if(!isDefined(origin)) {
      return;
    }
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

private function_6f4ab71c(entity) {}

private zombiemoveactionstart(entity) {
  entity.movetime = gettime();
  entity.moveorigin = entity.origin;
  entity.var_13138acf = 0;
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
  entity.idleorigin = entity.origin;
  return true;
}

private function_860d5d8(entity) {
  if(!(isDefined(entity.missinglegs) && entity.missinglegs) && gettime() - entity.idletime > 1000) {
    if(getdvarint(#"survival_prototype", 0) == 1 && gettime() - entity.idletime < 1700) {
      return;
    }

    distsq = distance2dsquared(entity.origin, entity.idleorigin);

    if(distsq < 144) {
      if(isDefined(entity.cant_move_cb)) {
        entity thread[[entity.cant_move_cb]]();
      }
    }

    entity.idletime = gettime();
    entity.idleorigin = entity.origin;
  }

  return 1;
}

private function_a0acf641(entity) {
  entity.var_4c4ad20a = undefined;
  return true;
}

private function_6a2634da(entity) {
  entity.var_3f2dc1d = undefined;

  if(!isDefined(level.var_dd9c5dbb)) {
    level.var_dd9c5dbb = 100;
  }

  origin = undefined;

  if(isDefined(self.enemy_override)) {
    origin = self.enemy_override.origin;
  } else if(isDefined(self.favoriteenemy)) {
    origin = self.favoriteenemy.origin;
  }

  if(isDefined(self.var_e47f11d7) && self.var_e47f11d7) {
    self setblackboardattribute("_range_attack_type", "VOMIT");
  } else {
    self setblackboardattribute("_range_attack_type", "REACH");
  }

  if(isDefined(origin)) {
    height_diff = origin[2] - entity.origin[2];

    if(abs(height_diff) > level.var_dd9c5dbb) {
      self.zombie_arms_position = "up";
    } else {
      self.zombie_arms_position = "down";
    }
  }

  return true;
}

private function_79c3a487(entity) {
  entity clientfield::set("zombie_riser_fx", 1);
}

private showzombie(entity) {
  entity show();
}

private function_78106a79(entity, asmstatename) {
  if(entity ai::is_stunned() || isDefined(entity.var_85c3882d) && entity.var_85c3882d) {
    return 5;
  }

  return 4;
}

function_142c3c86(entity, var_8fde7117) {
  if(isDefined(entity.usingvehicle) && entity.usingvehicle) {
    vehicle = entity getvehicleoccupied();
    dist_squared = distancesquared(vehicle.origin, var_8fde7117.origin);

    if(isDefined(vehicle) && vehicle.scriptvehicletype !== "recon_wz" && vehicle.scriptvehicletype !== "dart_wz" && vehicle.scriptvehicletype != "hawk") {
      return true;
    }
  }

  return false;
}

private function_7c7e7339() {
  if(isDefined(self.attackable) || isDefined(self.var_f1b4d6d3) && self.var_f1b4d6d3 && isDefined(self.favoriteenemy) && function_142c3c86(self.favoriteenemy, self)) {
    self.goalradius = 16;
    return;
  }

  if(self.aistate === 3) {
    self.goalradius = 64;
    return;
  }

  self.goalradius = 32;
}

function_d1e55248(id, value) {
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

  if(isDefined(self.spawn_anim) && isDefined(self.var_b8c61fc5) && self.var_b8c61fc5) {
    self wz_ai_utils::function_55625f76(self.origin, self.angles, self.spawn_anim);
  }

  waitframe(1);
  self.aistate = 1;
  self setgoal(self.origin);

  while(true) {
    self.isonnavmesh = ispointonnavmesh(self.origin, self getpathfindingradius() / 1.0125);
    self.var_6e3313ab = 0;

    if(isDefined(self.ai_zone) && self istouching(self.ai_zone.def)) {
      self.var_6e3313ab = 1;
    }

    if((getdvarint(#"survival_prototype", 0) == 1 || getdvarint(#"cluster_awareness", 0)) && !isDefined(self.ai_zone)) {
      self.var_6e3313ab = 1;
    }

    self function_bf21ead1();

    self function_173e098f();

      if(!self.var_6e3313ab || !self.isonnavmesh && self.allowoffnavmesh) {
        if(!isDefined(self.var_6bcb6977)) {
          self.var_6bcb6977 = gettime();

          if(isDefined(self.ai_zone) && isDefined(self.ai_zone.var_2209cb79)) {
            self.var_f9d7afa3 = self.ai_zone.var_2209cb79;
          } else {
            self.var_f9d7afa3 = randomintrange(6000, 10000);
          }
        }
      }
    else {
      self.var_6bcb6977 = undefined;
      self function_7c7e7339();
    }

    if(isDefined(level.var_3140c814) && level.var_3140c814 && isDefined(self.var_721a3dbd) && self.var_721a3dbd) {
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
      case 6:
        self function_936718a8();
        break;
      case 0:
      default:
        break;
    }

    if(self.aistate == 3) {
      if((self getentitynumber()&1) == (getlevelframenumber()&1)) {
        self.clamptonavmesh = !self.isonnavmesh && isDefined(self.ai_zone) && self istouching(self.ai_zone.def);
      }
    } else {
      self.clamptonavmesh = 1;
    }

    update_goal();
    waitframe(1);
  }
}

private function_eea7a68a(entity) {
  entity.enemy_override = function_b67c088d();

  if(isDefined(entity.enemy_override)) {
    wz_ai_utils::function_2b925fa5(entity);
  } else if(!isDefined(entity.attackable)) {
    entity.attackable = wz_ai_utils::get_attackable(entity, 1);
  }

  if(isDefined(entity.current_state) && isDefined(entity.current_state.target_func)) {
    [[entity.current_state.target_func]](entity);
  }
}

private setup_awareness(entity) {
  if(isDefined(entity.var_60b5cb76)) {
    entity[[entity.var_60b5cb76]](entity);
  } else {
    entity.fovcosine = 0.5;
    entity.maxsightdistsqrd = 900 * 900;
  }

  entity.has_awareness = 1;
  entity.ignorelaststandplayers = 1;
  set_state(entity, #"wander");
}

private function_cb2c8fea() {
  level endon(#"game_ended");

  while(true) {
    waitresult = level waittill(#"glass_smash");
    origin = undefined;
    radius = undefined;
    entity = undefined;

    if(waitresult._notify === #"glass_smash") {
      origin = waitresult.position;
      radius = 1000;
      ai = getentitiesinradius(origin, 50, 15);

      if(ai.size > 0) {
        continue;
      }
    }

    if(isDefined(origin) && isDefined(radius)) {
      function_e732359c(origin, radius, entity);
    }
  }
}

private function_7a84e563() {
  level endon(#"game_ended");
  level.var_ee6c4739 = [];

  while(true) {
    waitframe(1);

    if(level.var_ee6c4739.size > 0) {
      event = array::pop(level.var_ee6c4739, 0, 0);
      function_83baeaf1(event);
    }
  }
}

private function_25b61968() {
  self endon(#"death");
  self thread function_d1675b11();

  while(true) {
    wait 0.5;
    waitresult = self waittill(#"weapon_fired");

    switch (waitresult._notify) {
      case #"weapon_fired":
        weapon_fired_event(waitresult.weapon);
        break;
    }
  }
}

function_e732359c(position, var_4603c944, entity, ...) {
  level.var_ee6c4739[level.var_ee6c4739.size] = {
    #position: position, 
    #radius: var_4603c944, 
    #entity: entity, 
    #params: vararg
  };
}

function_83baeaf1(event) {
  close_ai = getentitiesinradius(event.position, event.radius, 15);

  foreach(ai in close_ai) {
    ai callback::callback(#"awareness_event", {
      #entity: event.entity, 
      #position: event.position, 
      #params: event.params
    });
  }
}

private weapon_fired_event(weapon) {
  radius = 2200;

  if(weaponhasattachment(weapon, "suppressed")) {
    radius = 1000;
  }

  function_e732359c(self.origin, radius, self);
}

private function_d2106375() {
  register_state(#"wander", &wander_enter, &wander_update, &wander_exit, undefined, &function_81c2c3d5);
  register_state(#"investigate", &investigate_enter, &investigate_update, &function_8972a415, undefined, &function_c62b82f);
  register_state(#"chase", &chase_enter, &chase_update, &function_3cf0d017, &function_5c293c05, undefined);
}

private register_state(name, enter, update, exit, target_update, debug_update) {
  if(!isDefined(level.zombie_states)) {
    level.zombie_states = [];
  }

  assert(!isDefined(level.zombie_states[name]));
  level.zombie_states[name] = {
    #name: name, 
    #enter_func: enter, 
    #update_func: update, 
    #exit_func: exit, 
    #target_func: target_update, 
    #debug_func: debug_update
  };
}

private set_state(entity, state_name) {
  assert(isDefined(level.zombie_states[state_name]), "<dev string:x38>" + (ishash(state_name) ? function_9e72a96(state_name) : state_name));
  state = level.zombie_states[state_name];

  if(isDefined(entity.current_state)) {
    if(isDefined(entity.current_state.exit_func)) {
      [
        [entity.current_state.exit_func]
      ](entity);
    }

    entity callback::callback(#"hash_540e54ba804a87b9");
  }

  entity notify(#"state_changed");

  if(isDefined(state) && isDefined(state.enter_func)) {
    [[state.enter_func]](entity);
  }

  entity.current_state = state;
  entity callback::callback(#"hash_4afe635f36531659");
}

function_9d0a9f4e(entity, awareness_event) {
  if(isDefined(entity.var_b4b8ad5f)) {
    if(distancesquared(entity.var_b4b8ad5f.position, awareness_event.position) <= 64 * 64) {
      return false;
    }
  }

  return true;
}

private function_16b8d0ed(event) {
  if(!function_9d0a9f4e(self, event)) {
    return false;
  }

  self.var_b4b8ad5f = event;
  return true;
}

private function_81c2c3d5(entity) {

  if(isDefined(entity.spawn_point) && isDefined(entity.spawn_point.wander_radius)) {
    circle(entity.spawn_point.origin, int(entity.spawn_point.wander_radius), (0, 1, 1), 1, 1, 1);
  }

  goalinfo = entity function_4794d6a3();

  if(isDefined(goalinfo)) {
    debugstar(goalinfo.goalpos, 1, (0, 1, 0));
  }

}

private wander_enter(entity) {
  entity wz_ai_utils::function_9758722("walk");
  entity.favoriteenemy = undefined;
  entity thread function_76f8bf36(entity);
  entity callback::function_d8abfc3d(#"awareness_event", &function_16b8d0ed);
}

private function_76f8bf36(entity) {
  entity endon(#"death", #"state_changed");
  origin = entity.origin;

  while(true) {
    if(isDefined(entity.spawn_point) && isDefined(entity.spawn_point.wander_radius)) {
      goal = function_b184324d(entity.spawn_point.origin, int(entity.spawn_point.wander_radius), entity getpathfindingradius() * 1.2, 32);
    } else if(isDefined(entity.cluster)) {
      for(var_6bb3efb6 = entity.cluster.spawn_points[randomintrange(0, entity.cluster.spawn_points.size)]; var_6bb3efb6.origin === entity.goalpos && entity.cluster.spawn_points.size > 1; var_6bb3efb6 = entity.cluster.spawn_points[randomintrange(0, entity.cluster.spawn_points.size)]) {}

      goal = getclosestpointonnavmesh(var_6bb3efb6.origin, 200, max(entity getpathfindingradius(), 32));
    } else {
      goal = function_b184324d(entity.origin, 300, 100, 32);
    }

    if(!isDefined(goal)) {
      goal = entity.origin;
    }

    entity setgoal(goal);
    wait randomfloatrange(3, 5);
  }
}

private wander_update(entity) {
  if(isDefined(entity.enemy)) {
    var_27cd0f02 = entity seerecently(entity.enemy, 1);
    var_7be806db = entity attackedrecently(entity.enemy, 1);
    var_8bbedf63 = entity.enemy attackedrecently(entity, 1);

    if(var_27cd0f02 || var_7be806db || var_8bbedf63) {
      entity.favoriteenemy = entity.enemy;
    }
  }

  if(isDefined(entity.favoriteenemy) || isDefined(entity.enemy_override) || isDefined(entity.attackable)) {
    set_state(entity, #"chase");
  }

  if(isDefined(entity.var_b4b8ad5f)) {
    set_state(entity, #"investigate");
  }
}

private wander_exit(entity) {
  entity callback::function_52ac9652(#"awareness_event", &function_16b8d0ed);
}

private function_853a6d58(event) {
  if(self function_16b8d0ed(event)) {
    self thread function_102ca651(self);
  }
}

private investigate_enter(entity) {
  if(!isDefined(level.var_812c573d)) {
    level.var_812c573d = new throttle();
    [[level.var_812c573d]] - > initialize();
  }

  callback::function_d8abfc3d(#"awareness_event", &function_853a6d58);
  entity thread function_102ca651(entity);
}

function_1cfdbe7(notifyhash) {
  [[level.var_812c573d]] - > leavequeue(self);
}

function_102ca651(entity) {
  self notify(#"hash_1ea32021fdf52a8b");
  self endoncallback(&function_1cfdbe7, #"death", #"state_changed", #"hash_1ea32021fdf52a8b");
  investigate_point = undefined;

  if(isDefined(entity.var_b4b8ad5f)) {
    [[level.var_812c573d]] - > waitinqueue(entity);
    investigate_point = function_b184324d(entity.var_b4b8ad5f.position, 256, 8, 50);
  }

  if(!isDefined(investigate_point)) {
    entity.var_b4b8ad5f = undefined;
    return;
  }

  entity setgoal(investigate_point);
  entity waittill(#"goal_changed");
  entity waittill(#"goal");
  wait randomfloatrange(2, 5);
  entity.var_b4b8ad5f = undefined;
}

private function_c62b82f(entity) {

  if(isDefined(entity.goalpos)) {
    debugstar(entity.goalpos, 1, (0, 0, 1));
    line(entity.origin, entity.goalpos, (0, 0, 1), 1, 1, 1);
  }

}

private investigate_update(entity) {
  if(isDefined(entity.enemy)) {
    var_27cd0f02 = entity seerecently(entity.enemy, 1);
    var_7be806db = entity attackedrecently(entity.enemy, 1);
    var_8bbedf63 = entity.enemy attackedrecently(entity, 1);

    if(var_27cd0f02 || var_7be806db || var_8bbedf63) {
      entity.favoriteenemy = entity.enemy;
    }
  }

  if(isDefined(entity.favoriteenemy) || isDefined(entity.enemy_override) || isDefined(entity.attackable)) {
    set_state(entity, #"chase");
  }

  if(!isDefined(entity.var_b4b8ad5f)) {
    set_state(entity, #"wander");
  }
}

private function_8972a415(entity) {
  entity.var_b4b8ad5f = undefined;
  entity callback::function_52ac9652(#"awareness_event", &function_853a6d58);
}

private function_efc86793(origin, radius, team, var_128faa2, enemy) {
  var_434e7f4e = getentitiesinradius(origin, radius, 15);

  foreach(ai in var_434e7f4e) {
    if(ai.team !== team) {
      continue;
    }

    function_c241ef9a(ai, enemy, var_128faa2);
  }
}

function_c241ef9a(ai, enemy, var_fb09158c) {
  if(!issentient(enemy)) {
    return;
  }

  ai.favoriteenemy = enemy;
  ai.var_6324ed63 = gettime() + int(var_fb09158c * 1000);
}

private function_219b823c(entity, target) {
  if(!issentient(target)) {
    return false;
  }

  var_a63ddc4 = isDefined(entity.var_6324ed63) && gettime() < entity.var_6324ed63;
  var_27cd0f02 = entity seerecently(target, 5);
  var_7be806db = entity attackedrecently(target, 5);
  var_8bbedf63 = target attackedrecently(entity, 5);
  return var_a63ddc4 || var_27cd0f02 || var_7be806db || var_8bbedf63;
}

private function_5c293c05(entity) {
  potential_targets = [];
  var_8d6705e8 = [];

  foreach(player in getplayers()) {
    if(!wz_ai_utils::is_player_valid(player)) {
      continue;
    }

    if(isDefined(player.last_valid_position) && function_219b823c(entity, player)) {
      potential_targets[potential_targets.size] = {
        #player: player, 
        #origin: player.last_valid_position
      };
      var_8d6705e8[var_8d6705e8.size] = player.last_valid_position;
    }
  }

  if(potential_targets.size > 1) {
    pathdata = generatenavmeshpath(entity.origin, var_8d6705e8, entity);

    if(isDefined(pathdata) && pathdata.status === "succeeded") {
      var_6f5b42c8 = arraygetclosest(pathdata.pathpoints[pathdata.pathpoints.size - 1], potential_targets);

      if(isDefined(var_6f5b42c8)) {
        entity.favoriteenemy = var_6f5b42c8.player;
      }
    }

    return;
  }

  if(potential_targets.size == 1) {
    entity.favoriteenemy = potential_targets[0].player;
    return;
  }

  entity.favoriteenemy = undefined;
}

private chase_enter(entity) {
  if(entity.archetype === #"zombie") {
    n_random = randomint(100);

    if(n_random < 33) {
      entity wz_ai_utils::function_9758722("sprint");
    } else if(n_random < 66) {
      entity wz_ai_utils::function_9758722("super_sprint");
    } else {
      entity wz_ai_utils::function_9758722("super_super_sprint");
    }
  } else {
    entity wz_ai_utils::function_9758722("run");
  }

  entity.var_b4b8ad5f = undefined;
  var_1daa824a = undefined;

  if(isDefined(entity.enemy_override)) {
    var_1daa824a = entity.enemy_override.origin;
    return;
  }

  if(isDefined(entity.attackable)) {
    var_1daa824a = entity.attackable.origin;
    return;
  }

  if(isDefined(entity.favoriteenemy)) {
    var_1daa824a = entity.favoriteenemy.origin;
    function_efc86793(entity.origin, 300, entity.team, 5, entity.favoriteenemy);
  }
}

private chase_update(entity) {
  if(!isDefined(entity.enemy_override) && !isDefined(entity.attackable) && !function_219b823c(entity, entity.enemy)) {
    set_state(entity, #"wander");
    return;
  }

  if(isDefined(entity.var_b238ef38) && isDefined(entity.var_b238ef38.position)) {
    entity setgoal(entity.var_b238ef38.position);
    return;
  }

  if(isDefined(entity.enemy_override)) {
    goal = getclosestpointonnavmesh(entity.enemy_override.origin, 200, entity getpathfindingradius() * 1.2);

    if(isDefined(goal)) {
      entity setgoal(goal);
      return;
    }
  }

  lastknownpos = entity lastknownpos(entity.enemy);

  if(isDefined(lastknownpos)) {
    goal = getclosestpointonnavmesh(lastknownpos, 200, entity getpathfindingradius() * 1.2);

    if(isDefined(goal)) {
      entity setgoal(goal);
    }
  }
}

private function_3cf0d017(entity) {}

function_54fc0f3e() {
  level endon(#"game_ended");
  self endon(#"death");

  while(true) {
    if(isDefined(self.current_state) && isDefined(self.current_state.update_func)) {
      [
        [self.current_state.update_func]
      ](self);
    }

    if(isDefined(self.current_state) && getdvarint(#"hash_7c11c6eba2f88f9f", 0)) {
      if(getdvarint(#"recorder_enablerec", 0)) {
        record3dtext(function_9e72a96(self.current_state.name), self.origin, (0, 1, 1), "<dev string:x71>", self);
      } else {
        print3d(self.origin, function_9e72a96(self.current_state.name), (0, 1, 1), 1, 1);
      }

      if(isDefined(self.current_state.debug_func)) {
        [
          [self.current_state.debug_func]
        ](self);
      }
    }

      waitframe(1);
  }
}

function_41dc2cb0() {
  level endon(#"game_ended");
  self endon(#"death");
  waitframe(1);

  if(isDefined(self.spawn_anim) && isDefined(self.var_b8c61fc5) && self.var_b8c61fc5) {
    self wz_ai_utils::function_55625f76(self.origin, self.angles, self.spawn_anim, self.var_16dd87ad);
  }

  waitframe(1);
  self.aistate = 1;
  self setgoal(self.origin);
  self thread function_54fc0f3e();
}

private function_d3a12e63() {
  if(isDefined(self.var_80780af2)) {
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

private update_goal() {
  if(isDefined(self.var_80780af2) && (isinarray(level.var_8de0b84e, self getentitynumber()) || self.archetype == #"blight_father")) {
    if(!self.allowoffnavmesh && self.isonnavmesh) {
      adjustedgoal = getclosestpointonnavmesh(self.var_80780af2, 100, self getpathfindingradius());

      if(isDefined(adjustedgoal)) {
        iteration_limit = wz_ai_utils::function_5f460765();

        if(!isDefined(iteration_limit)) {
          pathdata = generatenavmeshpath(self.origin, adjustedgoal, self);
        } else {
          pathdata = generatenavmeshpath(self.origin, adjustedgoal, self, undefined, undefined, iteration_limit);
        }

        if(isDefined(pathdata) && pathdata.status === "succeeded") {
          self setgoal(adjustedgoal);
        }
      }
    }

    self.var_80780af2 = undefined;
  }
}

private function_bf21ead1() {
  if((getdvarint(#"survival_prototype", 0) == 1 || getdvarint(#"cluster_awareness", 0)) && (self getentitynumber()&1) == (getlevelframenumber()&1)) {
    return;
  }

  var_f5acb8b9 = self.favoriteenemy;
  self.enemy_override = function_b67c088d();

  if(isDefined(self.enemy_override)) {
    self.favoriteenemy = undefined;
    wz_ai_utils::function_2b925fa5(self);
  } else {
    if(!isDefined(self.attackable)) {
      self.attackable = wz_ai_utils::get_attackable(self);
    }

    var_293b2af1 = undefined;

    if(isinarray(level.var_8de0b84e, self getentitynumber())) {
      var_293b2af1 = wz_ai_utils::ai_wz_can_see();
    }

    if(isDefined(var_293b2af1)) {
      self.favoriteenemy = var_293b2af1;
      self.var_bb185cc5 = gettime();
    } else if(isDefined(self.favoriteenemy)) {
      if(self wz_ai_utils::function_f10600c(self.favoriteenemy)) {
        self.var_bb185cc5 = gettime();
      }

      if(gettime() - self.var_bb185cc5 > 8000 || !wz_ai_utils::is_player_valid(self.favoriteenemy)) {
        self.favoriteenemy = undefined;
      }
    }
  }

  if(isDefined(self.var_50826790) && self.var_50826790) {
    if(isDefined(self.favoriteenemy) && !ispointonnavmesh(self.favoriteenemy.origin, self.favoriteenemy)) {
      self.favoriteenemy = undefined;
    }
  }

  if(var_f5acb8b9 !== self.favoriteenemy) {
    self callback::callback(#"hash_45b50cc48ee7f9d8");
  }
}

function_21b44b70(currentsurface) {
  if(array::contains(level.var_3ee83e3f, currentsurface)) {
    return true;
  }

  return false;
}

function_173e098f() {
  if(isDefined(level.var_e649db79) && level.var_e649db79) {
    self.var_db912cfe = function_6397251f();
  }
}

  function function_6397251f() {
    if(isDefined(self.var_872e52b0)) {
      return self[[self.var_872e52b0]]();
    }

    trace = bulletTrace(self.origin, self.origin + (0, 0, level.var_12956b7c * -1), 0, self, 0);

    if(isDefined(trace[#"position"]) && trace[#"surfacetype"] != #"none") {
      pos = trace[#"position"];
      self.surfacetype = trace[#"surfacetype"];

      if(function_21b44b70(self.surfacetype)) {

        drawdebugcross(pos, 5, (0, 1, 0), 1);

          return 1;
      }

      trace2 = bulletTrace(self.origin + (0, 0, level.var_12956b7c * -1), self.origin + (0, 0, level.var_6838a92d * -1), 0, self, 0);

      if(isDefined(trace2[#"position"]) && trace2[#"surfacetype"] != #"none") {
        if(trace2[#"surfacetype"] != #"default") {

          drawdebugcross(pos, 5, (1, 0, 0), 1);

            return 0;
        }

        var_a4e5b05b = trace2[#"surfacetype"];

        if(function_21b44b70(var_a4e5b05b)) {

          drawdebugcross(pos, 5, (0, 1, 0), 1);

            return 1;
        }

        var_1a1b6b0e = trace2[#"normal"];

        if(lengthsquared(var_1a1b6b0e) > 0) {
          pos2 = trace2[#"position"];

          drawdebugcross(pos2, 5, (1, 0, 1), 1);

            trace3 = bulletTrace(pos2 + (0, 0, level.var_6838a92d * -1), pos2 + (0, 0, level.var_b8ce09f3 * -1), 0, self, 0);

          if(isDefined(trace3[#"position"]) && trace3[#"surfacetype"] != #"none") {
            pos3 = trace3[#"position"];
            var_bc50df31 = trace3[#"surfacetype"];

  
            drawdebugcross(pos3, 5, (1, 1, 0), 1);
  

              if(function_21b44b70(var_bc50df31)) {
      
                drawdebugcross(pos, 5, (0, 1, 0), 1);
      

                  return 1;
              }

  
            drawdebugcross(pos, 5, (1, 0, 0), 1);
  

              return 0;
          }
        }
      }
    }

    return 1;
  }

private function_b67c088d() {
  enemy_override = undefined;

  if(self.archetype === #"zombie") {
    enemy_override = self function_a9cfe717();
  }

  return enemy_override;
}

private function_a9cfe717() {
  closest_attractor = undefined;
  closest_attractor = gadget_cymbal_monkey::function_4a5dff80(self);
  var_b26b6492 = gadget_homunculus::function_bd59a592(self);

  if(isDefined(var_b26b6492)) {
    if(!isDefined(closest_attractor)) {
      closest_attractor = var_b26b6492;
    } else {
      closest_attractor = arraygetclosest(self.origin, array(closest_attractor, var_b26b6492));
    }
  }

  return closest_attractor;
}

private function_cc9c6a13(state) {
  switch (state) {
    case 1:
      self.var_9a79d89d = undefined;
      self.var_50826790 = 0;
      self clearpath();

      if(self.var_ef59b90 === 3) {
        function_c9153928(self);
      }

      break;
    case 3:
      self function_d1e55248(#"hash_6e6d6ff06622efa4", 0);
      self pathmode("move allowed");

      if(isDefined(self.ai_zone)) {
        wz_ai_zonemgr::function_37411c68(self.ai_zone, self);
      }

      break;
    case 5:
      self function_d1e55248(#"hash_5780e28b762b831a", 0);
      val::reset(#"hash_5780e28b762b831a", "ignoreall");
      self pathmode("move allowed");
      break;
    default:
      break;
  }

  self callback::callback(#"hash_9198809e683b517", {
    #state: state
  });
}

private function_b8eff92a(state) {
  switch (state) {
    case 1:
      if(isDefined(self.var_50826790) && self.var_50826790) {
        move_speed = "sprint";

        if(getdvarint(#"survival_prototype", 0) == 1) {
          move_speed = "super_sprint";
        }

        self wz_ai_utils::function_9758722(move_speed);
      } else {
        self wz_ai_utils::function_9758722("walk");
      }

      self.favoriteenemy = undefined;
      self.isonnavmeshcount = 0;
      break;
    case 3:
      move_speed = "sprint";

      if(getdvarint(#"survival_prototype", 0) == 1) {
        move_speed = "super_sprint";
      }

      self wz_ai_utils::function_9758722(move_speed);

      if(isDefined(self.ai_zone)) {
        wz_ai_zonemgr::function_769a0b3f(self.ai_zone, self);
      }

      break;
    case 5:
      self function_d1e55248(#"hash_5780e28b762b831a", !self.isonnavmesh);
      val::set(#"hash_5780e28b762b831a", "ignoreall", 1);

      if(!self.isonnavmesh) {
        self pathmode("dont move", 1);
      }

      break;
    case 6:
      self.var_620ecd9d = 0;
      self.var_7340c103 = gettime();
      break;
    default:
      break;
  }

  self callback::callback(#"hash_4e449871617e2c25", {
    #state: state
  });
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
    if(isDefined(self.favoriteenemy.last_valid_position) && (isDefined(self.ai_zone) && isDefined(self.ai_zone.is_global) && self.ai_zone.is_global || self.favoriteenemy.ai_zone === self.ai_zone)) {
      self.var_80780af2 = self.favoriteenemy.last_valid_position;

      drawdebugcross(self.favoriteenemy.last_valid_position, 3, (0, 1, 0), 1);

        if(self.isonnavmesh) {
          self function_d1e55248(#"hash_6e6d6ff06622efa4", 0);
        }
    } else if(isDefined(self.favoriteenemy.last_valid_position)) {
      if(!ispointonnavmesh(self.favoriteenemy.origin, self)) {
        if(!self.isonnavmesh && !self function_dd070839() || self isatgoal()) {
          self pathmode("dont move", 1);
          self function_d1e55248(#"hash_6e6d6ff06622efa4", 1);
        }
      } else {
        self.var_80780af2 = self.favoriteenemy.last_valid_position;

        drawdebugcross(self.favoriteenemy.last_valid_position, 3, (0, 1, 0), 1);

          if(self.isonnavmesh) {
            self function_d1e55248(#"hash_6e6d6ff06622efa4", 0);
          }
      }
    }
  }

  if(!isDefined(self.favoriteenemy) && !isDefined(self.attackable)) {
    if(isDefined(self.ai_zone) && isDefined(self.ai_zone.is_global) && self.ai_zone.is_global) {
      self.var_ef59b90 = 5;
    } else {
      self.var_ef59b90 = 1;
    }
  } else if(self.isonnavmesh && isDefined(self.attackable) && isDefined(self.var_b238ef38) && (self.var_b238ef38.slot.on_navmesh || isDefined(self.var_b238ef38.slot.var_acdc8d71) && !self isingoal(self.var_b238ef38.slot.var_acdc8d71))) {
    if(!isinarray(level.var_8de0b84e, self getentitynumber())) {
      return;
    }

    var_bc4c0533 = [];

    if(isDefined(self.var_80780af2)) {
      var_bc4c0533[var_bc4c0533.size] = self.var_80780af2;
    }

    if(self.var_b238ef38.slot.on_navmesh) {
      var_bc4c0533[var_bc4c0533.size] = self.var_b238ef38.position;
      var_d01c2da3 = self.var_b238ef38.position;
    } else if(isDefined(self.var_b238ef38.slot.var_acdc8d71)) {
      var_bc4c0533[var_bc4c0533.size] = self.var_b238ef38.slot.var_acdc8d71;
      var_d01c2da3 = self.var_b238ef38.slot.var_acdc8d71;
    }

    if(var_bc4c0533.size > 1) {
      iteration_limit = wz_ai_utils::function_5f460765();

      if(!isDefined(iteration_limit)) {
        pathdata = generatenavmeshpath(self.origin, var_bc4c0533, self);
      } else {
        pathdata = generatenavmeshpath(self.origin, var_bc4c0533, self, undefined, undefined, iteration_limit);
      }

      if(isDefined(pathdata) && pathdata.status === "succeeded") {
        pathgoal = pathdata.pathpoints[pathdata.pathpoints.size - 1];

        if(distancesquared(pathgoal, self.var_80780af2) < distancesquared(pathgoal, var_d01c2da3)) {
          wz_ai_utils::function_2b925fa5(self);
        }

        self.var_80780af2 = pathgoal;
      }
    } else if(var_bc4c0533.size == 1) {
      self.var_80780af2 = var_bc4c0533[0];
    }
  } else if(isDefined(self.var_b238ef38) && (self isatgoal() || !self.isonnavmesh)) {
    self function_d1e55248(#"hash_6e6d6ff06622efa4", 1);
    self pathmode("dont move", 1);
    self function_a57c34b7(self.var_b238ef38.position);
  }

  if(function_d8b225ae(self)) {
    val::set(#"zombie_combat_state", "blockingpain", 1);
    return;
  }

  val::reset(#"zombie_combat_state", "blockingpain");
}

function_b184324d(origin, radius, var_5e8ea34a = 0, dist_from_boundary = 15) {
  theta = randomfloatrange(0, 360);
  x = var_5e8ea34a + cos(theta) * (radius - var_5e8ea34a) * randomfloatrange(0, 1);
  y = var_5e8ea34a + sin(theta) * (radius - var_5e8ea34a) * randomfloatrange(0, 1);
  point = (origin[0] + x, origin[1] + y, origin[2]);
  var_d1a33279 = groundtrace(point + (0, 0, 8), point + (0, 0, -100000), 0, undefined)[#"position"];

  if(isDefined(var_d1a33279)) {
    return getclosestpointonnavmesh(var_d1a33279, 50, dist_from_boundary);
  }

  return undefined;
}

function_d4f2933d() {
  level endon(#"game_ended");
  self endon(#"death", #"state_changed");
  self.var_9a79d89d = self.origin;

  while(true) {
    wander_point = function_b184324d(self.origin, 200, 50);

    if(isDefined(wander_point)) {
      self.var_9a79d89d = wander_point;
    }

    if(isDefined(self.var_9a79d89d)) {
      self.var_80780af2 = self.var_9a79d89d;
    } else {
      self.var_80780af2 = self.origin;
    }

    wait_time = randomfloatrange(3, 5);
    waitresult = self waittilltimeout(wait_time, #"goal");

    if(isDefined(self.var_50826790) && self.var_50826790) {
      self.var_ef59b90 = 5;
      self.var_50826790 = 0;
    }

    if(waitresult._notify !== "timeout") {
      idle_time = randomfloatrange(3, 5);
      wait idle_time;
    }
  }
}

private function_34eacecd() {
  if(!isDefined(self.var_9a79d89d) && isDefined(self.ai_zone) && isDefined(self.ai_zone.spawn_points) && self.ai_zone.spawn_points.size > 0) {
    if(isDefined(self.var_5d58d4c0)) {
      self thread[[self.var_5d58d4c0]]();
    } else {
      self thread function_af47322e();
    }
  } else if((getdvarint(#"survival_prototype", 0) == 1 || getdvarint(#"cluster_awareness", 0)) && !isDefined(self.var_9a79d89d) && !isDefined(self.ai_zone)) {
    self thread function_d4f2933d();
  }

  if(isDefined(level.var_3140c814) && level.var_3140c814 && isDefined(self.var_721a3dbd) && self.var_721a3dbd) {
    if(!self.isonnavmesh && !self function_dd070839()) {
      if(!isDefined(self.isonnavmeshcount)) {
        self.isonnavmeshcount = 0;
      }

      self.isonnavmeshcount++;

      if(self.isonnavmeshcount > 10) {
        self.var_ef59b90 = 5;
      }
    } else if(isDefined(self.enemy_override) || isDefined(self.favoriteenemy) || isDefined(self.attackable)) {
      self.var_ef59b90 = 3;
      self.isonnavmeshcount = 0;
    } else {
      self.isonnavmeshcount = 0;
    }
  }

  if(isDefined(self.var_5ed989c7) && self.var_5ed989c7) {
    if(isDefined(self.var_31a789c0) && self.var_31a789c0 && isDefined(self.var_db912cfe) && self.var_db912cfe) {
      players_in_zone = [];
      players = getplayers();

      for(i = 0; i < players.size; i++) {
        if(isDefined(players[i].ai_zone) && players[i].ai_zone === self.ai_zone) {
          if(!isDefined(players_in_zone)) {
            players_in_zone = [];
          } else if(!isarray(players_in_zone)) {
            players_in_zone = array(players_in_zone);
          }

          players_in_zone[players_in_zone.size] = players[i];
        }
      }

      if(players_in_zone.size == 0) {
        self.var_ef59b90 = 5;
      }
    }
  }
}

private function_af47322e() {
  level endon(#"game_ended");
  self endon(#"death", #"state_changed");

  while(true) {
    self.var_9a79d89d = self.ai_zone.spawn_points[self.ai_zone.var_96d81013].origin;
    self.ai_zone.var_96d81013++;

    if(self.ai_zone.var_96d81013 >= self.ai_zone.spawn_points.size) {
      self.ai_zone.var_96d81013 = 0;
    }

    if(isDefined(self.var_9a79d89d)) {
      self.var_80780af2 = self.var_9a79d89d;
    } else {
      self.var_80780af2 = self.origin;
    }

    wait_time = randomfloatrange(3, 5);
    waitresult = self waittilltimeout(wait_time, #"goal");

    if(isDefined(self.var_50826790) && self.var_50826790) {
      self.var_ef59b90 = 5;
      self.var_50826790 = 0;
    }

    if(waitresult._notify !== "timeout") {
      idle_time = randomfloatrange(3, 5);
      wait idle_time;
    }
  }
}

private function_b793bca2() {
  self.var_ef59b90 = 1;
}

private function_101763c9() {
  self endon(#"death");

  if(isDefined(self.attackable)) {
    wz_ai_utils::function_2b925fa5(self);
  }

  self.var_db912cfe = function_6397251f();

  if(isDefined(self.var_31a789c0) && self.var_31a789c0 && isDefined(self.var_db912cfe) && self.var_db912cfe) {
    self.var_8a96267d = 1;
    self waittill(#"is_underground");

    if(!isDefined(self.ai_zone)) {
      self kill(undefined, undefined, undefined, undefined, 0, 1);
    }

    spawn_point = self.ai_zone.spawn_points[randomint(self.ai_zone.spawn_points.size)];

    if(!isDefined(spawn_point)) {
      self kill();
    }

    wait 2;
    self forceteleport(spawn_point.origin, spawn_point.angles);
    wait 2;

    while(isDefined(self.var_381e689e) && self.var_381e689e) {
      players_in_zone = [];
      players = getplayers();
      var_fcf24551 = undefined;

      for(i = 0; i < players.size; i++) {
        if(isDefined(players[i].ai_zone) && players[i].ai_zone == self.ai_zone) {
          if(!isDefined(players_in_zone)) {
            players_in_zone = [];
          } else if(!isarray(players_in_zone)) {
            players_in_zone = array(players_in_zone);
          }

          players_in_zone[players_in_zone.size] = players[i];

          if(isDefined(players[i].usingvehicle) && players[i].usingvehicle) {
            var_fcf24551 = players[i];
          }
        }
      }

      if(players_in_zone.size > 0) {
        if(isDefined(var_fcf24551)) {
          self.favoriteenemy = var_fcf24551;
          self.var_bb185cc5 = gettime();
        }

        break;
      }

      wait 0.2;
    }

    self.var_8ba6ede3 = 1;
    self waittill(#"not_underground");
    self.var_ef59b90 = 1;
  } else {
    self.var_ef59b90 = 1;
    self.var_50826790 = 1;
  }

  self.var_ef59b90 = 1;
}

private function_936718a8() {
  level endon(#"game_ended");
  self endon(#"death", #"state_changed");
  self orientmode("face enemy");
  self.var_80780af2 = self.origin;

  if(isDefined(level.var_c83a9084) && level.var_c83a9084) {
    self.var_e47f11d7 = 1;
  } else {
    self.var_e47f11d7 = 0;
  }

  if(isDefined(self.favoriteenemy)) {
    head_pos = self.origin + (0, 0, 60);
    var_1b7d301e = self.favoriteenemy.origin + (0, 0, 60);
    vec_to_enemy = var_1b7d301e - head_pos;
    vec_to_enemy_norm = vectornormalize(vec_to_enemy);
    self.angles_to_enemy = vectortoangles(vec_to_enemy_norm);
    self.var_11c3e0a6 = head_pos;

    if(isDefined(self.fxent)) {
      self.fxent.origin = self.var_11c3e0a6;
      self.fxent.angles = self.angles_to_enemy;
    }
  }

  if(!(isDefined(self.var_620ecd9d) && self.var_620ecd9d)) {
    delaytime = int(self.var_46618155 * 1000);
    currenttime = gettime();

    if(!self.var_620ecd9d && currenttime > self.var_7340c103 + delaytime) {
      self.var_620ecd9d = 1;
      self.var_3f2dc1d = 1;
      self.var_1a3ca72b = 0;

      if(isDefined(self.var_e47f11d7) && self.var_e47f11d7) {
        self function_6e9cc039();
      }
    }
  }

  if(isDefined(self.favoriteenemy) && ispointonnavmesh(self.favoriteenemy.origin, self.favoriteenemy)) {
    self.var_1a3ca72b = 1;
  }
}

function_6e9cc039() {
  if(!isDefined(level.var_f13b4c3b)) {
    level.var_f13b4c3b = 200;
    level.var_d7209a5f = 15;
    level.var_5cd6f2e3 = int(2 * 1000);
    level.var_26448f1f = int(4 * 1000);
  }

  if(isDefined(self.fxent)) {
    self.fxent delete();
  }

  self.fxent = spawn("script_model", self.origin);
  self.fxent.targetname = "zm_microwave_fx";
  self.fxent.angles = self.angles;
  self.fxent setModel(#"tag_origin");
  self clientfield::set("zombie_has_microwave", 1);
  self.var_2853518c = gettime();
  self.var_fdeb16c7 = randomfloatrange(level.var_5cd6f2e3, level.var_26448f1f);
  self thread turretthink();
}

function_939e4f03() {
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.fxent)) {
    self clientfield::set("zombie_has_microwave", 0);
    self.fxent delete();
  }

  self.var_13138acf = 1;
  self.var_3f2dc1d = undefined;
  self.var_ef59b90 = 3;
}

turretdebug() {
  if(isDefined(level.var_e066667d) && level.var_e066667d) {
    turret = self;
    angles = turret.angles_to_enemy;
    origin = turret.var_11c3e0a6;
    cone_apex = origin;
    forward = anglesToForward(angles);
    dome_apex = cone_apex + vectorscale(forward, isDefined(level.var_f13b4c3b) ? level.var_f13b4c3b : 0);
    util::debug_spherical_cone(cone_apex, dome_apex, isDefined(level.var_d7209a5f) ? level.var_d7209a5f : 0, 16, (0.95, 0.1, 0.1), 0.3, 1, 3);
  }
}

  function turretthink() {
    turret = self;
    turret endon(#"microwave_turret_shutdown", #"death");
    damageinterval = 0.3;
    damage = 2;

    if(isDefined(level.deathcircle)) {
      damageinterval = level.deathcircle.damageinterval;
      damage = level.deathcircle.damage;
    }

    var_f4d9a132 = gettime() + damageinterval * 1000;

    while(gettime() < self.var_2853518c + self.var_fdeb16c7) {
      dodamage = gettime() >= var_f4d9a132;

      if(dodamage) {
        players_in_zone = [];
        players = getplayers();

        for(i = 0; i < players.size; i++) {
          if(isDefined(players[i].ai_zone) && players[i].ai_zone == self.ai_zone) {
            if(!isDefined(players_in_zone)) {
              players_in_zone = [];
            } else if(!isarray(players_in_zone)) {
              players_in_zone = array(players_in_zone);
            }

            players_in_zone[players_in_zone.size] = players[i];
          }
        }

        for(i = 0; i < players_in_zone.size; i++) {
          ent = players_in_zone[i];

          if(turret microwaveturretaffectsentity(ent)) {
            org = ent.origin;
            earthquake(0.3, 0.2, org, 500);
            playrumbleonposition("grenade_rumble", org);
            ent dodamage(damage, org, turret, undefined, undefined, "MOD_DEATH_CIRCLE");
          }
        }

        var_f4d9a132 = gettime() + damageinterval * 1000;
      }

      turret turretdebug();

        waitframe(1);
    }

    function_939e4f03();
  }

microwaveturretaffectsentity(entity) {
  turret = self;

  if(!isalive(entity)) {
    return false;
  }

  if(!isplayer(entity)) {
    return false;
  }

  if(entity.ignoreme === 1) {
    return false;
  }

  if(distancesquared(entity.origin, turret.origin) > level.var_f13b4c3b * level.var_f13b4c3b) {
    return false;
  }

  angles = turret.angles_to_enemy;
  origin = turret.var_11c3e0a6;
  shoot_at_pos = entity getshootatpos(turret);
  entdirection = vectornormalize(shoot_at_pos - origin);
  forward = anglesToForward(angles);
  dot = vectordot(entdirection, forward);

  if(dot < cos(level.var_d7209a5f)) {
    return false;
  }

  return true;
}

private function_839910c5(entity) {
  if(isDefined(entity.var_834b0770)) {
    return false;
  }

  return true;
}

private function_f37b0fbd(entity) {
  entity clearpath();
}

private function_b9b03294(entity) {
  startnode = entity.traversestartnode;

  if(!isDefined(startnode) || !isnodeenabled(startnode)) {
    return false;
  }

  return true;
}

private function_2a7b4aab(entity) {
  return entity.var_85c3882d === 1;
}

private zombieshouldknockdown(entity) {
  return entity.knockdown === 1;
}

zombieknockdownactionstart(behaviortreeentity) {
  behaviortreeentity setblackboardattribute("_knockdown_type", behaviortreeentity.knockdown_type);
  behaviortreeentity setblackboardattribute("_knockdown_direction", behaviortreeentity.knockdown_direction);
  behaviortreeentity setblackboardattribute("_getup_direction", behaviortreeentity.getup_direction);
  behaviortreeentity collidewithactors(0);
  behaviortreeentity val::set(#"zombie_knockdown", "blockingpain", 1);
}

private function_c8939973(behaviortreeentity) {
  if(isDefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs) {
    behaviortreeentity.knockdown = 0;
    behaviortreeentity collidewithactors(1);
  }
}

private zombiegetupactionterminate(behaviortreeentity) {
  behaviortreeentity.knockdown = 0;
  behaviortreeentity collidewithactors(1);
  behaviortreeentity clearpath();
  behaviortreeentity val::reset(#"zombie_knockdown", "blockingpain");
}

private function_bfc25c77(entity) {
  if(!(isDefined(getgametypesetting(#"wzzombiesbreakdoors")) ? getgametypesetting(#"wzzombiesbreakdoors") : 0)) {
    return false;
  }

  startnode = entity.traversestartnode;

  if(entity.traversestartnode.type == #"end") {
    startnode = getothernodeinnegotiationpair(entity.traversestartnode);
  }

  if(!isnodeenabled(startnode)) {
    return false;
  }

  if(isDefined(startnode) && isDefined(startnode.targetname)) {
    dynentarray = function_c79d31c4(startnode.targetname);

    if(isDefined(dynentarray) && dynentarray.size > 0) {
      entity.dynentarray = dynentarray;
      return true;
    }
  }

  return false;
}

private damagedoor(entity) {
  if(isDefined(self.dynentarray) && self.dynentarray.size > 0) {
    var_9b1a1b39 = 1;

    foreach(dynent in self.dynentarray) {
      damage = 10;

      if(isDefined(self.instakill_doors) && self.instakill_doors) {
        damage = dynent.health;
      }

      dynent dodamage(damage, self.origin, self, self, "none", "MOD_EXPLOSIVE");

      if(dynent.health > 0) {
        var_9b1a1b39 = 0;
      }
    }

    if(var_9b1a1b39) {
      self.dynentarray = undefined;
    }
  }
}

private function_66e2c5fb(entity) {
  return isDefined(entity.var_fc781a6f) && entity.var_fc781a6f;
}

private function_7c8e35e8(entity, asmstate) {
  entity.var_fc781a6f = undefined;

  if(isDefined(self.traversestartnode)) {
    node = entity.traversestartnode;

    if(entity.traversestartnode.type !== #"begin" && entity.traversestartnode.type !== "Volume") {
      node = getothernodeinnegotiationpair(node);
    }

    unlinktraversal(node);
    entity.var_834b0770 = node;
    node.owner = entity;

    if(isDefined(entity.instakill_doors) && entity.instakill_doors || isDefined(entity.is_miniboss) && entity.is_miniboss) {
      entity callback::function_d8abfc3d(#"on_ai_melee", &damagedoor);
    }

    if(isDefined(asmstate)) {
      animationstatenetworkutility::requeststate(entity, asmstate);
    }

    entity pathmode("dont move");
  }

  return 5;
}

private function_fee7d867(entity, asmstate) {
  if(entity asmgetstatus() == "asm_status_complete") {
    return 4;
  }

  if(isDefined(entity.dynentarray)) {
    foreach(dynent in entity.dynentarray) {
      if(function_ffdbe8c2(dynent) != 0) {
        return 4;
      }
    }
  }

  return 5;
}

private function_3f71b9c2(entity, asmstate) {
  entity finishtraversal();
  entity pathmode("move allowed", 1);

  if(isDefined(entity.var_834b0770)) {
    linktraversal(entity.var_834b0770);
    entity.var_834b0770.owner = undefined;
    self.var_834b0770 = undefined;
  }

  entity.dynentarray = undefined;
  entity callback::function_52ac9652(#"on_ai_melee", &damagedoor);

  if(entity asmgetstatus() == "asm_status_running") {
    entity.var_fc781a6f = 1;
  }

  return 4;
}

delayed_zombie_eye_glow(var_80bea5a6) {
  self endon(#"death");

  if(isDefined(self.in_the_ground) && self.in_the_ground || isDefined(self.in_the_ceiling) && self.in_the_ceiling) {
    while(!isDefined(self.create_eyes)) {
      wait 0.1;
    }
  } else {
    wait 0.5;
  }

  self zombie_eye_glow(var_80bea5a6);
}

zombie_eye_glow(var_80bea5a6) {
  if(!isDefined(self) || !isactor(self)) {
    return;
  }

  if(!(isDefined(self.no_eye_glow) && self.no_eye_glow)) {
    self clientfield::set("zombie_has_eyes_col", var_80bea5a6);
  }
}

zombie_eye_glow_stop() {
  if(!isDefined(self) || !isactor(self)) {
    return;
  }

  if(!(isDefined(self.no_eye_glow) && self.no_eye_glow)) {
    self clientfield::set("zombie_has_eyes_col", 0);
  }
}

zombie_gut_explosion() {
  self.guts_explosion = 1;
  gibserverutils::annihilate(self);
}

zombie_death_event(params) {
  e_attacker = params.eattacker;
  self thread zombie_eye_glow_stop();

  if(isDefined(self.ai_zone) && isDefined(self.ai_zone.var_78823914) && self.ai_zone.var_78823914) {
    if(isDefined(self.is_special) && self.is_special && isDefined(self.ai_zone)) {
      self.ai_zone thread wz_ai_zonemgr::function_3effc794(self);
    } else {
      self.ai_zone.var_78823914 = 0;
      self.ai_zone thread wz_ai_zonemgr::function_1992880a();
    }
  }

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

  if(isDefined(self.ai_zone) && isplayer(e_attacker)) {
    self.ai_zone.var_f2fb3bb7 = e_attacker;
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

  self thread damage_over_time(ceil(self.health * 0.2), 1, attacker);
}

damage_over_time(dmg, delay, attacker) {
  self endon(#"death", #"exploding");

  if(!isalive(self)) {
    return;
  }

  if(!isplayer(attacker)) {
    attacker = self;
  }

  while(true) {
    if(isDefined(delay)) {
      wait delay;
    }

    if(isDefined(self)) {
      if(isDefined(attacker)) {
        self dodamage(dmg, self gettagorigin("j_neck"), attacker, self, self.damagelocation, "MOD_DOT_SELF", 4096, self.damageweapon);
        continue;
      }

      self dodamage(dmg, self gettagorigin("j_neck"));
    }
  }
}

function_2d87c1f1(str_zone, v_loc) {
  e_pickup = spawn("script_model", v_loc);
  e_pickup.targetname = "zm_ammo_pickup";
  e_pickup setModel(#"p7_zm_power_up_max_ammo");
  e_pickup playSound(#"zmb_spawn_powerup");
  e_pickup playLoopSound(#"zmb_spawn_powerup_loop");
  e_pickup thread powerup_wobble();
  e_pickup thread powerup_timeout();
  e_pickup thread function_4346d61d(str_zone);
}

function_4346d61d(str_zone) {
  self endon(#"powerup_grabbed", #"powerup_timedout", #"death");

  while(true) {
    e_player = wz_ai_utils::get_closest_player(str_zone, self.origin);

    if(isDefined(e_player)) {
      n_dist = distance(self.origin, e_player.origin);

      if(n_dist < 80) {
        a_weapons = e_player getweaponslistprimaries();

        foreach(weapon in a_weapons) {
          e_player setweaponammoclip(weapon, weapon.clipsize);
          e_player givestartammo(weapon);
        }

        e_player playSound(#"zmb_powerup_grabbed");
        self delete();
      }
    }

    waitframe(1);
  }
}

powerup_wobble() {
  self endon(#"powerup_grabbed", #"powerup_timedout", #"death");
  playFXOnTag(#"zombie/fx_powerup_on_green_zmb", self, "tag_origin");

  while(true) {
    waittime = randomfloatrange(2.5, 5);
    yaw = randomint(360);

    if(yaw > 300) {
      yaw = 300;
    } else if(yaw < 60) {
      yaw = 60;
    }

    yaw = self.angles[1] + yaw;
    new_angles = (-60 + randomint(120), yaw, -45 + randomint(90));
    self rotateto(new_angles, waittime, waittime * 0.5, waittime * 0.5);
    wait randomfloat(waittime - 0.1);
  }
}

powerup_timeout() {
  self endon(#"powerup_grabbed", #"death", #"powerup_reset");
  self show();
  wait 15;
  self hide_and_show();
  self notify(#"powerup_timedout");
  self delete();
}

hide_and_show() {
  self endon(#"death");

  for(i = 0; i < 40; i++) {
    if(i % 2) {
      self ghost();
    } else {
      self show();
    }

    if(i < 15) {
      wait 0.5;
      continue;
    }

    if(i < 25) {
      wait 0.25;
      continue;
    }

    wait 0.1;
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
  wait 1;
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
  if(getdvarint(#"survival_prototype", 0)) {
    self thread function_625a781d();
  } else {
    self thread play_ambient_zombie_vocals();
  }

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

function_625a781d() {
  self endon(#"death");
  self thread function_c2be61f2();

  while(true) {
    type = "ambient";
    float = 3;

    if(isDefined(self.current_state)) {
      switch (self.current_state.name) {
        case #"investigate":
        case #"wander":
          type = "ambient";
          float = 3;
          break;
        case #"chase":
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

function_c2be61f2() {
  self endon(#"death", #"disconnect");

  while(true) {
    self waittill(#"state_changed");
    waitframe(1);

    if(self.current_state.name == #"chase") {
      bhtnactionstartevent(self, "chase_state_start");
    }
  }
}

function_d1675b11() {
  level endon(#"unloaded");
  self endon(#"death", #"disconnect");

  if(!isDefined(level._zbv_vox_last_update_time)) {
    level._zbv_vox_last_update_time = 0;
    level._audio_zbv_shared_ent_list = getaiarchetypearray(#"zombie");
  }

  while(true) {
    wait 1;
    t = gettime();

    if(t > level._zbv_vox_last_update_time + 1000) {
      level._zbv_vox_last_update_time = t;
      level._audio_zbv_shared_ent_list = getaiarchetypearray(#"zombie");
    }

    zombs = level._audio_zbv_shared_ent_list;
    played_sound = 0;

    for(i = 0; i < zombs.size; i++) {
      if(!isDefined(zombs[i])) {
        continue;
      }

      if(zombs[i].isdog) {
        continue;
      }

      dist = 150;
      z_dist = 50;
      alias = level.vox_behind_zombie;

      if(isDefined(zombs[i].zombie_move_speed)) {
        switch (zombs[i].zombie_move_speed) {
          case #"walk":
            dist = 150;
            break;
          case #"run":
            dist = 175;
            break;
          case #"sprint":
            dist = 200;
            break;
        }
      }

      if(distancesquared(zombs[i].origin, self.origin) < dist * dist) {
        angles = vectortoangles(zombs[i].origin - self.origin);
        yaw = self.angles[1] - angles[1];
        yaw = angleclamp180(yaw);
        z_diff = self.origin[2] - zombs[i].origin[2];

        if((yaw < -95 || yaw > 95) && abs(z_diff) < 50) {
          wait 0.1;

          if(isDefined(zombs[i]) && isalive(zombs[i])) {
            bhtnactionstartevent(zombs[i], "behind");
            zombs[i] notify(#"bhtn_action_notify", {
              #action: "behind"
            });
            played_sound = 1;
          }

          break;
        }
      }
    }

    if(played_sound) {
      wait 2.5;
    }
  }
}

function_833ce8c8() {
  return true;
}

function_bb3c1175(params) {
  self.var_ef59b90 = 5;
  self.var_872e52b0 = &function_833ce8c8;

  if(getdvarint(#"survival_prototype", 0) || getdvarint(#"cluster_awareness", 0)) {
    self endon(#"death");

    if(isDefined(self.attackable)) {
      wz_ai_utils::function_2b925fa5(self);
    }

    self.var_8a96267d = 1;
    self waittilltimeout(10, #"is_underground");
    self kill(undefined, undefined, undefined, undefined, 0, 1);
  }
}

function_f41ded83(vehicle) {
  if(vehicle.scriptvehicletype === "hawk") {
    return true;
  }

  return false;
}

private function_ef4bd1a6() {
  util::waittill_can_add_debug_command();
  mapname = util::get_map_name();
  adddebugcommand("<dev string:x7a>");
  adddebugcommand("<dev string:x97>" + mapname + "<dev string:xa7>");
}

