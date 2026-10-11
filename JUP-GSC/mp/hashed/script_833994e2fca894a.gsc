/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_833994e2fca894a.gsc
************************************************/

#using scripts\common\callbacks;
#using scripts\common\vehicle_build;
#using scripts\common\vehicle_paths;
#using scripts\cp_mp\killstreaks\chopper_support;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\utility\points;
#using scripts\mp\utility\teams;
#using scripts\mp\vehicles\damage;
#namespace namespace_b78d657d6d9b410d;

function main() {
  level.var_33208cc9a89d1a0d = &spawn_chopper_boss;
  function_66ed22dfc3b03993();
}

function function_66ed22dfc3b03993() {
  level.var_cb36bea0db8a829f = getdvarint(@ "hash_41a5f023a6b9d7b6", 100);
  level.var_d44040648e9624f = getdvarint(@ "hash_2e1a1ee4432ba896", 4000);
  level.var_426503bd899fe79d = getdvarint(@ "hash_f8cfa0a3e3979732", 2000);
  level.var_8b0166c08f79ba6f = getdvarint(@ "hash_fb9f16d91bcc8a8", 420);
  level.var_af333105a68edcaf = getdvarint(@ "hash_d539a28855e76e9a", 0);
  level.var_72f4ae7b6cc41376 = getdvarint(@ "hash_4b206bd3a88e108b", 360);
  level.var_7317a07b6cea3c64 = getdvarint(@ "hash_4afd81d3a867f935", 440);
  level.var_6884e659bd874ed9 = getdvarint(@ "hash_29c7a74c7b9dd1b2", 3);
  level.var_920d2d352811f372 = getdvarint(@ "hash_4e73bb68df397fbf", 6);
  level.var_eda461803cdadc2c = getdvarint(@ "hash_995dd383d134e9ed", 10000);
  level.var_fdd8206d27c6e843 = getdvarint(@ "hash_7926da00afdcd474", 4500);
  level.var_147a8bca293848ea = getdvarint(@ "hash_87a6941b45c05399", 4);
  level.var_c11e773465a38fb7 = getdvarint(@ "hash_b45a6072bee6b2d4", 15);
  level.var_f787cf36b2e0e7f7 = getdvarint(@ "hash_369e173b0e8d08ba", 12);
  level.var_50b14458069e6de = getdvarint(@ "hash_8b1842e92794c807", 7);
  level.var_26c9eb02a050f11a = getdvarint(@ "hash_cc7feb01eae01a3f", 1);
  level.var_103b912267715093 = getdvarint(@ "hash_45da2e0688e80016", 5000);
  level.var_808f834a75546c5c = getdvarint(@ "hash_dd6e4061977972e5", 4);
  level.var_30c5e90e94b964fc = getdvarint(@ "hash_1da644016c35bdad", 0) == 1;
  registersharedfunc("veh9_mil_air_heli_hind_physics_limbo", "explode", &function_8c55246fcf664138);
}

function function_8f5cde869b76b0e() {
  var_4480a107283a6a21 = [];

  foreach(player in level.players) {
    if(isDefined(player.var_94908079eda0edb0) && player.var_94908079eda0edb0 >= 5) {
      var_4480a107283a6a21[var_4480a107283a6a21.size] = player;
    }
  }

  return random(var_4480a107283a6a21);
}

function spawn_chopper_boss() {
  scripts\mp\flags::gameflagwait("prematch_done");
  choppermodel = "veh9_mil_air_heli_hind_limbo_weapons";
  var_44dd61e9bc4b4304 = "veh9_mil_air_heli_hind_physics_limbo";
  level.var_d44040648e9624f = 1000;

  if(isDefined(level.var_a47c6934a36494b0) && level.var_a47c6934a36494b0.size > 0) {
    struct = random(level.var_a47c6934a36494b0);
    pos = struct.origin;
  } else {
    pos = (0, 0, 800);
  }

  chopper = spawnVehicle(choppermodel, "dmz_ai_chopper", var_44dd61e9bc4b4304, pos, (0, 0, 0));
  chopper.vehiclename = var_44dd61e9bc4b4304;
  level.var_ef0dad85a40b1807 = chopper;
  scripts\common\vehicle_build::build_is_helicopter(chopper.vehicletype);
  chopper.speed = 20;
  chopper.originalspeed = chopper.speed;
  chopper.accel = 50;
  chopper.var_5424df833ac6a6f2 = chopper.accel;
  chopper.lifetime = 9999;
  chopper.team = "team_hundred_ninety_nine";
  chopper.postmodifydamage = &chopper_postmodifydamage;
  chopper.targetplayer = function_8f5cde869b76b0e();
  chopper.var_605b121f1fadd46c = 1;
  chopper.damagestate = 0;
  chopper.currenthealth = level.var_426503bd899fe79d;
  chopper.health = chopper.currenthealth;
  chopper.maxhealth = chopper.currenthealth;
  chopper setCanDamage(1);
  chopper setmaxpitchroll(15, 15);
  chopper vehicle_setspeed(chopper.speed, chopper.accel);
  chopper setvehicleteam(chopper.team);
  chopper setneargoalnotifydist(400);
  chopper vehicleshowonminimap(0);
  chopper thread function_a4f67639da6c8a7d();
  scripts\mp\vehicles\damage::set_post_mod_damage_callback(chopper.vehiclename, &chopper_postmodifydamage);
  scripts\mp\vehicles\damage::set_death_callback(chopper.vehiclename, &chopper_handledeathdamage);
  chopper thread chopper_ondeath();
  chopper thread function_382f6d5ccce841f0(pos);

  if(!isDefined(chopper)) {
    return;
  }

  if(!isDefined(level.var_cbfdb6b806e34512)) {
    level.var_cbfdb6b806e34512 = [];
  }

  level.var_cbfdb6b806e34512 = array_add(level.var_cbfdb6b806e34512, chopper);
}

function function_382f6d5ccce841f0(pos) {
  chopper = self;
  chopper endon("death");
  loc = undefined;
  chopper childthread function_5bb279a05d2a871c();

  while(true) {
    if(!isDefined(chopper.targetplayer) || !isalive(chopper.targetplayer) || chopper.targetplayer.var_94908079eda0edb0 < 5) {
      newtarget = function_8f5cde869b76b0e();
      chopper.targetplayer = newtarget;
    }

    newloc = undefined;

    if(isDefined(chopper.targetplayer)) {
      if(issharedfuncdefined("limbo", "find_closest_loc_to_player")) {
        newloc = [[getsharedfunc("limbo", "find_closest_loc_to_player")]](level.var_5656ad3e90854d58, chopper.targetplayer);
      }
    } else {
      chopper function_24fee42d71078694();
      return;
    }

    if(!isDefined(loc) || newloc != loc) {
      loc = newloc;
      chopper setvehgoalpos(loc.origin, 1);
    }

    chopper waittill_any_timeout_1(10, "goal");
  }
}

function function_a4f67639da6c8a7d() {
  level endon("game_ended");
  owner = self.owner;
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }

  chopper_explode();
}

function chopper_explode() {
  if(istrue(self.isexploding)) {
    return;
  }

  self notify("explode");
  self notify("state_change");
  self radiusdamage(self.origin, 1000, 200, 200, undefined, "MOD_EXPLOSIVE", "chopper_support_turret_mp");
  self setscriptablepartstate("explode", "on", 0);

  if(isDefined(self.lootfunc)) {
    self[[self.lootfunc]]();
  }

  self.isexploding = 1;
  wait 0.35;
  chopper_cleanup(1);
}

function chopper_cleanup(wasdestroyed) {
  self notify("chopperSupport_gone");

  if(isDefined(self.frontturret)) {
    self.frontturret setentityowner(undefined);
    self.frontturret.groundtargetent delete();
    self.frontturret delete();
  }

  if(isDefined(self.rearturret)) {
    self.rearturret setentityowner(undefined);
    self.rearturret.groundtargetent delete();
    self.rearturret delete();
  }

  level.var_ef0dad85a40b1807 = undefined;
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(self);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);

  if(isDefined(function_8f5cde869b76b0e())) {
    spawn_chopper_boss();
  }
}

function function_8c55246fcf664138(data, other) {
  level.var_ef0dad85a40b1807 chopper_explode();
}

function chopper_handledeathdamage(data) {
  scripts\cp_mp\killstreaks\chopper_support::choppersupport_handledeathdamage(data);
  thread function_aa4375c53e07b7ec(data.attacker.team);
  self notify("death");

  if(isDefined(data.attacker) && isPlayer(data.attacker)) {
    data.attacker thread scripts\mp\utility\points::doscoreevent(#"hash_ed50c46f7d175008");
  }

  return true;
}

function function_aa4375c53e07b7ec(team) {
  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {}
}

function chopper_ondeath() {
  self waittill("death");
}

function chopper_postmodifydamage(data) {
  scripts\cp_mp\killstreaks\chopper_support::function_400022dabdb64055(data);

  switch (self.damagestate) {
    case 0:
      if(self.currenthealth < level.var_426503bd899fe79d * 0.65) {
        self.damagestate = 1;
        self setscriptablepartstate("body_damage_light", "on", 0);
      }

      break;
    case 1:
      if(self.currenthealth < level.var_426503bd899fe79d * 0.25) {
        self.damagestate = 2;
        self setscriptablepartstate("damage_left_wing", "on", 0);
        self setscriptablepartstate("body_damage_medium", "on", 0);
      }

      break;
    case 2:
      if(self.currenthealth < level.var_426503bd899fe79d * 0.05) {
        self.damagestate = 3;
        self setscriptablepartstate("damage_right_wing", "on", 0);
        self setscriptablepartstate("body_damage_heavy", "on", 0);
      }

      break;
    case 3:
    default:
      break;
  }

  return true;
}

function function_5bb279a05d2a871c() {
  self endon("chopper_exiting");
  self endon("explode");
  playvo = 0;

  while(true) {
    playvo = !playvo;

    if(playvo) {
      self setscriptablepartstate("speaker", "warning");
      wait 0.7;
      self setscriptablepartstate("speaker", "idle");
    }

    for(i = 0; i < 20; i++) {
      if(self.health <= 0) {
        return;
      }

      var_259bc878059e4154 = undefined;

      if(isDefined(self.targetplayer)) {
        var_259bc878059e4154 = self.targetplayer;
      } else {
        var_259bc878059e4154 = getclosest(self.origin, level.players, 5000);
      }

      if(isDefined(var_259bc878059e4154) && isalive(var_259bc878059e4154)) {
        self setturrettargetvec(var_259bc878059e4154 getEye());
      }

      self fireweapon();
      wait 0.1;
    }

    wait randomintrange(3, 7);
  }
}

function function_24fee42d71078694() {
  self notify("chopper_exiting");
  end_point = random(level.var_3122f605f0e8e125);
  self.end_point = end_point;
  path_start = end_point;
  path_start.radius = 1000;
  self.var_918c5a31037e00ee = spawnStruct();
  self.var_918c5a31037e00ee.speed = 80;
  self function_247ad6a91f6a4ffe(0);
  self.var_6df468049c1f41dc = 1;
  thread scripts\common\vehicle_paths::vehicle_paths_helicopter(path_start);
}