/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2304453c69e996e2.gsc
*************************************************/

#using script_20a226c24f1585bf;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\vehicle_paths;
#using scripts\cp_mp\killstreaks\chopper_support;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\utility\player;
#using scripts\mp\vehicles\damage;
#namespace namespace_c908de38bcdbd93d;

function heli_spawn(spawn_ref, is_landed, preventrespawn, settings_bundle, var_d553022aa7804f03) {
  heli = undefined;
  is_landed = default_to(is_landed, 0);
  preventrespawn = default_to(preventrespawn, 1);

  if(!isDefined(settings_bundle)) {
    settings_bundle = getscriptbundle("helicoptersettings:default_helicopter_settings");
  }

  if(!isDefined(settings_bundle)) {
    assertmsg("<dev string:x1c>");
    return undefined;
  }

  spawndata = spawnStruct();
  spawndata.origin = spawn_ref.origin + (0, 0, 128);
  spawndata.angles = (0, 0, 0);

  if(isDefined(spawn_ref.angles)) {
    spawndata.angles = (0, spawn_ref.angles[1], 0);
  }

  spawndata.team = "team_hundred_ninety";
  heli_ref = settings_bundle.helicopterref;

  switch (heli_ref) {
    case #"hash_174ce9a6344b18a4":
      spawndata.model = "veh9_mil_air_heli_hind_vehphys_mp";
      break;
    case #"hash_66c8846b85d8c948":
      spawndata.model = "veh9_mil_air_heli_palfa_vehphys_mp";
      break;
    case #"hash_bc31095b59d83674":
      spawndata.model = "veh9_mil_air_heli_blima_mp";
      spawndata.initai = 1;
      break;
    default:
      spawndata.model = "veh9_mil_air_heli_hind_vehphys_mp";
      break;
  }

  heli = vehicle_spawn(heli_ref, spawndata);
  heli.preventrespawn = preventrespawn;

  if(isDefined(var_d553022aa7804f03)) {
    heli.var_81d4390e43c90346 = var_d553022aa7804f03;
  } else {
    heli.var_81d4390e43c90346 = &function_4c9ef1ed5aef03c7;
  }

  assertex(isDefined(heli), "<dev string:x8b>");

  if(getDvar(@ "hash_1a8fc884f08fce8", "0") == "1") {
    heli function_9e96cdf67b925aa0();
    heli function_7dac0131a74b9e48();
    heli function_46f757d9ff2fdfcc();
    heli function_268f89699b68533e();
    heli function_324badbe006153();
    heli function_618793408ff0894a();
  } else {
    heli function_c96e4b15db766b84(settings_bundle);
  }

  heli.is_landed = is_landed;
  heli heli_init(heli_ref);
  heli function_fc4e8c5a8f831cab();

  if(istrue(heli.hasmissiles)) {
    heli.missileweapon = makeweapon(heli.var_ffd128d3b3bac67a);
  }

  if(istrue(heli.hasturret)) {
    heli namespace_d80401e4aca8c66f::function_403ee60da9709c3d(settings_bundle.turretsettings, "team_hundred_ninety", ["allies", "team_two_hundred"], heli.var_81d4390e43c90346, 1);
  }

  heli scripts\mp\vehicles\damage::set_vehicle_hit_damage_data("veh_jup_hind", 20);
  heli.flaresreservecount = 1;
  heli.flareslive = [];

  if(scripts\engine\utility::issharedfuncdefined("flares", "handleIncomingStinger")) {
    heli thread[[scripts\engine\utility::getsharedfunc("flares", "handleIncomingStinger")]](&function_c1d877c72f9161f7);
  }

  return heli;
}

function function_fc4e8c5a8f831cab() {
  self endon("death");
  self endon("crashing");
  self endon("entitydeleted");

  childthread function_de3fc172a25ca50b();
}

function private heli_init(heli_ref) {
  self.usedpositions = [];
  self.originalspeed = self.speed;
  self.accel = 50;
  self.lifetime = 9999;
  self.team = "team_hundred_ninety";
  self.heightoffset = (0, 0, self.var_a32eb5da7024e7c4);
  self.var_1e0eb63ecb3f1e2 = 1;
  self.attackers = [];
  self setmaxpitchroll(30, 30);
  self vehicle_setspeed(self.speed, self.accel);

  if(self.is_landed) {
    self sethoverparams(0, 0, 0);
  } else {
    self sethoverparams(self.hover_radius, self.hover_speed, self.hover_accel);
  }

  self setturningability(self.var_27b3267d1a2697dd);
  self setyawspeed(100, 25, 25, 0.1);
  self setCanDamage(1);
  self setneargoalnotifydist(self.pathgoaldistance);
  self setvehicleteam(self.team);
  self.ignorelist = [self];
  self.crashoffset = self.var_a32eb5da7024e7c4 - 250;
  self.var_fd91112a53ea4fea = 1;
  self.damagestate = 3;
  scripts\mp\sentientpoolmanager::registersentient("Level_Vehicle", self.team);
  thread function_e3ab01a91dc64df0();
  scripts\mp\vehicles\damage::set_death_callback(self.vehiclename, &function_d9630ff97ef012cf);

  if(self.var_7472d0ddfd2019ca) {
    self.var_52dcdba485e7ceeb = "tag_origin";
    scripts\mp\vehicles\damage::set_post_mod_damage_callback(self.vehiclename, &function_45cc03649256e6f3);
  }
}

function function_89891a51d22c497e(settings_bundle) {
  foreach(turret in self.turrets) {
    turret namespace_adca7bd47b8c5e04::function_9e96cdf67b925aa0(settings_bundle);
  }
}

function function_4782ceab7eadd844(death_callback) {
  if(!isDefined(self.deathcallbacks)) {
    self.deathcallbacks = [];
  }

  self.deathcallbacks[self.deathcallbacks.size] = death_callback;
}

function function_a4db8fd7d61d6687() {}

function function_4c9ef1ed5aef03c7(vehicle) {
  function_3d8d8ad244283e65(#"hash_9aadbc16f4d5a77b");
  self endon("death");
  self endon("crashing");
  self endon("entitydeleted");
  self endon("target_acquired");
  canseetarget = 0;
  contentsoverride = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0, 1, 1);
  var_b9d5783a4f34efbc = [self];
  childthread function_6967cf4bacd2142f();
  targets = vehicle function_cd5b61d2bbbf08ad(["team_two_hundred", "allies"]);

  foreach(target_ent in targets) {
    if(!isDefined(target_ent)) {
      waitframe();
      continue;
    }

    if(isPlayer(target_ent) && isalive(target_ent)) {
      if(istrue(function_618e0f50b9b8b310(target_ent))) {
        function_7f3923ed3d66f8ad();
        return target_ent;
      }

      continue;
    }

    if(isalive(target_ent) && istrue(function_b5a44a788ec704f(target_ent))) {
      function_7f3923ed3d66f8ad();
      return target_ent;
    }

    waitframe();
  }

  function_7f3923ed3d66f8ad();
  return undefined;
}

function function_f307cefb91e4e283() {
  highest_dmg = 0;
  highest_attacker = undefined;

  foreach(ent_num, damage in self.attackers) {
    if(damage > highest_dmg) {
      highest_dmg = damage;
      highest_attacker = getentbynum(ent_num);
    }
  }

  return highest_attacker;
}

function function_618e0f50b9b8b310(player, var_3aabd49a2a48dd5a) {
  if(scripts\mp\utility\player::isinlaststand(player) || istrue(player.ignoreme) || istrue(player.notarget) || istrue(player.disguised)) {
    return 0;
  }

  if(!istrue(var_3aabd49a2a48dd5a) && function_93ff5e5ba263fc6d(self, player) < self.var_cc99a14e60508d29) {
    return 0;
  }

  contentsoverride = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 0, 0, 1, 1);
  var_b9d5783a4f34efbc = [self];

  if(isDefined(player.vehicle)) {
    var_b9d5783a4f34efbc[var_b9d5783a4f34efbc.size] = player.vehicle;
    linkedmodels = player.vehicle getlinkedchildren();

    if(isDefined(linkedmodels) && linkedmodels.size > 0) {
      var_b9d5783a4f34efbc = array_combine(var_b9d5783a4f34efbc, linkedmodels);
    }
  }

  if(player tagexists("j_head")) {
    return scripts\engine\trace::ray_trace_passed(self gettagorigin("tag_origin"), player gettagorigin("j_head"), var_b9d5783a4f34efbc, contentsoverride);
  }

  return 0;
}

function function_b5a44a788ec704f(ai) {
  if(function_93ff5e5ba263fc6d(self, ai) < self.var_cc99a14e60508d29) {
    return 0;
  }

  contentsoverride = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0, 1, 1);
  var_b9d5783a4f34efbc = [self];

  if(isDefined(ai.vehicle) && isDefined(ai.vehicle_position)) {
    var_b9d5783a4f34efbc[var_b9d5783a4f34efbc.size] = ai.vehicle;
    linkedmodels = ai.vehicle getlinkedchildren();

    if(isDefined(linkedmodels) && linkedmodels.size > 0) {
      var_b9d5783a4f34efbc = array_combine(var_b9d5783a4f34efbc, linkedmodels);
    }
  }

  return scripts\engine\trace::ray_trace_passed(self gettagorigin("tag_origin"), ai getEye(), var_b9d5783a4f34efbc, contentsoverride);
}

function function_6967cf4bacd2142f() {
  self notify("heli_get_attacker_singleton");
  self endon("heli_get_attacker_singleton");

  while(true) {
    self waittill("damage", idamage, eattacker);

    iprintlnbold("<dev string:xb6>");

    self.current_target = eattacker;
    self notify("target_acquired");
  }
}

function function_fbb9f19c8d061491(time) {
  self endon("death");
  self endon("crashing");
  self endon("entitydeleted");
  time = default_to(time, 20);
  self.var_b6e6b30178ec0f54 = 1;
  wait time;
  self.var_b6e6b30178ec0f54 = 0;
}

function function_cd5b61d2bbbf08ad(teams) {
  function_3d8d8ad244283e65(#"hash_9868c1c7bf64e461");

  if(!isDefined(teams)) {
    function_7f3923ed3d66f8ad();
    return [];
  }

  ai_array = [];

  foreach(s_team in teams) {
    ai_array = array_combine(ai_array, getaiarrayinradius(self.origin, self.var_e309f77b84ade0d9, s_team));
  }

  function_7f3923ed3d66f8ad();
  return ai_array;
}

function function_966229df2aba3d79() {
  return scripts\mp\utility\player::getplayersinradius(self.origin, self.var_e309f77b84ade0d9);
}

function function_5177db9fd4c16935() {}

function function_7988d9c7d6393d8(start_node, forceheight, var_f1ff4c8c32027852, var_c070b40128ceccf4, var_a0953585793a7d3c, var_24c51e78424bbcba, var_50f65d9cdf36989e) {
  if(!isDefined(var_50f65d9cdf36989e)) {
    var_50f65d9cdf36989e = 0;
  }

  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self endon("stop_patrol_behavior");
  self endon("stop_all_action");

  while(true) {
    namespace_d80401e4aca8c66f::function_ed737153dc8baac7(self.var_81d4390e43c90346);
    childthread function_a99e82b41834f9a4();
    childthread function_bc77383cc0c4d3b9(start_node, forceheight, var_f1ff4c8c32027852);
    self waittill("target_acquired");

    if(!isDefined(var_a0953585793a7d3c) || isDefined(var_a0953585793a7d3c) && [[var_a0953585793a7d3c]](self, self.current_target)) {
      if(isDefined(var_24c51e78424bbcba)) {
        childthread function_efb6239d789d19f3(var_24c51e78424bbcba);
      }

      behavior_combat(undefined, var_c070b40128ceccf4, var_50f65d9cdf36989e);
    }

    start_node = self.next_target;
    self setturningability(self.var_27b3267d1a2697dd);
    self setneargoalnotifydist(self.pathgoaldistance);
  }
}

function private function_a99e82b41834f9a4(var_855c177366117677) {
  self notify("target_watcher_start");
  self endon("target_watcher_start");

  while(true) {
    if(isDefined(var_855c177366117677)) {
      targ = [[var_855c177366117677]](self);
    } else {
      targ = [[self.var_81d4390e43c90346]](self);
    }

    if(isDefined(targ)) {
      self notify("target_acquired");
      self.current_target = targ;
    }

    targ = undefined;
    wait 10;
  }
}

function private function_efb6239d789d19f3(callback) {
  self waittill("start_combat");

  while(true) {
    if([[callback]](self)) {
      self clearlookatent();
      self notify("stop_combat_behavior");
      return;
    }

    waitframe();
  }
}

function function_343f1b24108dc4c3() {}

function behavior_chase(target_ent) {
  self endon("stop_all_action");
  self.circlespeed = 80;
  self.hasmissiles = 0;
  self setmaxpitchroll(20, 30);
  thread target_update(target_ent);

  if(isDefined(target_ent)) {
    self.current_target = target_ent;
  }

  if(istrue(self.hasmissiles)) {
    childthread function_a86f57c94f688e4c();
  }

  thread missile_handler(target_ent);

  while(true) {
    if(isDefined(self.current_target)) {
      function_c726703023325c0a(self.current_target, 1, 0, 0, undefined, 2000, 1000, undefined, undefined);
    }

    waitframe();
  }
}

function private missile_handler(target_ent) {
  last_time = gettime();

  while(true) {
    if(gettime() - last_time > 15000) {
      self notify("missile_attack");
      function_90786c097a7d7433(target_ent);
      last_time = gettime();
    }

    waitframe();
  }
}

function private target_update(target_ent) {
  while(true) {
    self notify("new_orders");
    self.var_1ae978cf5dc05edb = target_ent.origin;
    wait 1;
  }
}

function function_c1d877c72f9161f7(player, missileteam, missiletarget, fxtagoverride) {
  self endon("death");

  while(true) {
    if(!isDefined(missiletarget)) {
      break;
    }

    center = missiletarget getpointinbounds(0, 0, 0);
    curdist = distance(self.origin, center);

    if(curdist < 4000 && missiletarget.flaresreservecount > 0) {
      missiletarget.flaresreservecount--;
      missiletarget thread heli_playflarefx(fxtagoverride);
      newtarget = undefined;

      if(issharedfuncdefined("flares", "deploy")) {
        newtarget = missiletarget[[getsharedfunc("flares", "deploy")]]();
      }

      self.var_afcd53cfa79abccf = 1;
      self missile_settargetEnt(newtarget);
      self notify("missile_pairedWithFlare");
      level notify("flares", player);
      return;
    }

    waitframe();
  }
}

function heli_playflarefx(fxtagoverride) {
  flarestag = "tag_origin";

  if(isDefined(fxtagoverride)) {
    flarestag = fxtagoverride;
  }

  playsoundatpos(self gettagorigin(flarestag), "ks_ac130_flares");
  playFXOnTag(getfx("gunship_flares"), self, flarestag);
}

function function_774c6c9e717da747() {}

function function_2fb28a9e4728e86a(target_position, var_eb17d5c958e3fcda, var_855c177366117677, var_50f65d9cdf36989e) {
  if(!isDefined(var_50f65d9cdf36989e)) {
    var_50f65d9cdf36989e = 0;
  }

  self endon("stop_combat_behavior");
  self endon("stop_all_action");
  self endon("crashing");
  self endon("death");
  self notify("start_combat");

  if(!isDefined(target_position)) {
    return;
  }

  self.in_combat = 1;
  function_ec247bbe9627170d(var_855c177366117677, var_50f65d9cdf36989e);
  function_9bf8b74a65eaa76(target_position, 1, 1, 0, undefined, var_eb17d5c958e3fcda, undefined, undefined, undefined);
  self.in_combat = 0;
}

function behavior_combat(target_ent, var_855c177366117677, var_50f65d9cdf36989e) {
  if(!isDefined(var_50f65d9cdf36989e)) {
    var_50f65d9cdf36989e = 0;
  }

  self endon("stop_combat_behavior");
  self endon("stop_all_action");
  self endon("crashing");
  self endon("death");
  self notify("start_combat");
  self.in_combat = 1;
  function_ec247bbe9627170d(var_855c177366117677, var_50f65d9cdf36989e);

  if(isDefined(target_ent)) {
    self.current_target = target_ent;
  }

  while(true) {
    if(isDefined(self.current_target)) {
      function_c726703023325c0a(self.current_target, 1, 1, 0, undefined, undefined, undefined, undefined, undefined);
    }

    waitframe();
  }

  self.in_combat = 0;
}

function function_ec247bbe9627170d(var_855c177366117677, var_50f65d9cdf36989e) {
  if(!isDefined(var_50f65d9cdf36989e)) {
    var_50f65d9cdf36989e = 0;
  }

  if(isDefined(var_855c177366117677)) {
    namespace_d80401e4aca8c66f::function_ed737153dc8baac7(&function_2db62831ba7a2266);
  }

  childthread function_a99e82b41834f9a4(var_855c177366117677);

  if(istrue(self.hasmissiles)) {
    childthread function_a86f57c94f688e4c(var_50f65d9cdf36989e);
  }
}

function private function_2db62831ba7a2266(vehicle) {
  return vehicle.current_target;
}

function private function_a86f57c94f688e4c(require_los) {
  if(!isDefined(require_los)) {
    require_los = 0;
  }

  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self.var_1dc887e33d97a12e = gettime();

  while(true) {
    time_elapsed = gettime() - self.var_1dc887e33d97a12e;

    if(time_elapsed > self.missileinterval) {
      attack_target = self.current_target;

      if(require_los) {
        if(isPlayer(attack_target) && !function_618e0f50b9b8b310(attack_target)) {
          wait 1;
          continue;
        } else if(isai(attack_target) && !function_b5a44a788ec704f(attack_target)) {
          wait 1;
          continue;
        }
      }

      if(isDefined(attack_target)) {
        pitch = getpitchtospot3d(attack_target.origin);

        if(pitch > self.var_da6ccdbfcffb23b1) {
          waitframe();
          continue;
        }

        vector_to_target = vectornormalize2(attack_target.origin - self.origin);
        strafe_goal = self.origin + vector_to_target * 4000;
        obstructiontrace = function_56ebd2471f52c901(self.origin, strafe_goal, 325, self.ignorelist);
        var_738caee3d4576e5c = obstructiontrace["hittype"] == "hittype_none";

        if(!var_738caee3d4576e5c) {
          wait 1;
          continue;
        }

        self notify("resume_circling");
        thread function_b91a289ed9de4db7(undefined, 1);
        self waittill("circling_paused");
        wait 1;
        function_2029e383e2ec901(attack_target);
        waittill_any_ents(self, "strafe_complete", attack_target, "death");
        self.var_1dc887e33d97a12e = gettime();
        self notify("resume_circling");
      }
    }

    waitframe();
  }
}

function function_efc08e4ed244673b() {}

function function_bc77383cc0c4d3b9(start_node, forceheight, speedoverride, isdrone) {
  self notify("new_orders");
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self endon("new_orders");
  self endon("stop_all_action");

  if(!isDefined(start_node)) {
    assertmsg("<dev string:xd2>");
    return;
  }

  self.next_target = start_node;
  path_end = 0;
  self setturningability(self.var_27b3267d1a2697dd);
  self setneargoalnotifydist(self.pathgoaldistance);

  while(!path_end) {
    forcestopatgoal = 0;

    if(!isDefined(self.next_target.target)) {
      forcestopatgoal = 1;
      path_end = 1;
    }

    function_d6eba8149fb949e9(self.next_target, path_end, forceheight, 1, undefined, undefined, speedoverride, undefined, undefined, isdrone, 0);

    if(!path_end) {
      if(issharedfuncdefined("activity_chopper_util", "CustomPathNextTarget")) {
        self.next_target = function_f3bb4f4911a1beb2("activity_chopper_util", "CustomPathNextTarget", self, self.next_target.target);
      } else if(isstruct(self.next_target)) {
        self.next_target = getStruct(self.next_target.target, "targetname");
      } else if(isent(self.next_target)) {
        self.next_target = getEnt(self.next_target.target, "targetname");
      } else {
        self.next_target = getvehiclenode(self.next_target.target, "targetname");
      }
    }

    waitframe();
  }
}

function function_a2262da7c12166e1(position, n_height, strafe_distance, isdrone) {
  self endon("stop_all_action");
  wait 0.5;
  speed_override = 80;
  accel_override = 18;
  self.current_angle += 180;
  self.current_angle = angleclamp(self.current_angle);
  vector_to_target = vectornormalize2(position - self.origin);
  strafe_goal = self.origin + vector_to_target * strafe_distance;
  function_d6eba8149fb949e9(strafe_goal, undefined, n_height, 0, undefined, undefined, speed_override, accel_override, 1, isdrone);
  self notify("strafe_complete");
}

function function_21c899c9bbaf0adc(var_5eaa2d980f1cc4b4, var_4885ccb2d176409, var_7d1523a65b5c8edd, var_451cc3c179e7ce9d, pause_turrets) {
  if(!isDefined(var_4885ccb2d176409)) {
    var_4885ccb2d176409 = 100;
  }

  if(!isDefined(var_7d1523a65b5c8edd)) {
    var_7d1523a65b5c8edd = 15000;
  }

  if(!isDefined(var_451cc3c179e7ce9d)) {
    var_451cc3c179e7ce9d = 15000;
  }

  if(!isDefined(pause_turrets)) {
    pause_turrets = 1;
  }

  if(var_5eaa2d980f1cc4b4) {
    self notify("stop_all_action");
  }

  self endon("stop_all_action");

  if(istrue(pause_turrets)) {
    foreach(turret in self.turrets) {
      turret namespace_adca7bd47b8c5e04::function_917a46654478df92();
    }
  }

  self clearlookatent();
  function_d6eba8149fb949e9(self.origin + (0, 0, 1500), 0, 0, 0, undefined, undefined, var_4885ccb2d176409, undefined, 1);
  result = 0;
  var_e57aabbdb1b44208 = [anglesToForward(self.angles), anglestoleft(self.angles), anglestoright(self.angles), anglesToForward(self.angles) * -1, anglestoup(self.angles)];
  idx = 0;

  while(!result && idx < var_e57aabbdb1b44208.size) {
    direction = var_e57aabbdb1b44208[idx];
    var_57d125e36a7ac9c1 = self.origin + direction * (var_7d1523a65b5c8edd, var_7d1523a65b5c8edd, 0) + (0, 0, var_451cc3c179e7ce9d);
    result = function_d6eba8149fb949e9(var_57d125e36a7ac9c1, 0, 0, 0, undefined, undefined, 70, undefined, 1);
    idx++;
    wait 0.3;
  }

  self delete();
}

function function_c726703023325c0a(var_d6dfead8a1d3957e, var_31759f0a1036d495, var_4aed5403298a4d7f, var_25b8738ccc2f5e33, var_aaa98411bc77fb1f, var_29c1049cdd91eb32, var_64459132907ac449, var_41976210805f0afe, var_a22b586ea0f535ef, isdrone) {
  self.circle_ent = var_d6dfead8a1d3957e;
  internal_circle(var_d6dfead8a1d3957e.origin, var_31759f0a1036d495, var_4aed5403298a4d7f, var_25b8738ccc2f5e33, var_aaa98411bc77fb1f, &function_68fca835889ce704, var_29c1049cdd91eb32, var_64459132907ac449, var_41976210805f0afe, var_a22b586ea0f535ef, 1, isdrone);
}

function function_68fca835889ce704(heli) {
  if(is_dead_or_dying(heli.circle_ent)) {
    heli.circle_ent = undefined;
    heli notify("stop_circling");
    return undefined;
  }

  return heli.circle_ent.origin;
}

function function_9bf8b74a65eaa76(var_ce5c8b45f5bf97e8, var_31759f0a1036d495, var_4aed5403298a4d7f, var_25b8738ccc2f5e33, var_aaa98411bc77fb1f, var_eb17d5c958e3fcda, var_29c1049cdd91eb32, var_64459132907ac449, var_41976210805f0afe, var_a22b586ea0f535ef, isdrone) {
  internal_circle(var_ce5c8b45f5bf97e8, var_31759f0a1036d495, var_4aed5403298a4d7f, var_25b8738ccc2f5e33, var_aaa98411bc77fb1f, var_eb17d5c958e3fcda, var_29c1049cdd91eb32, var_64459132907ac449, var_41976210805f0afe, var_a22b586ea0f535ef, isdrone);
}

function private internal_circle(var_ce5c8b45f5bf97e8, var_31759f0a1036d495, var_4aed5403298a4d7f, var_25b8738ccc2f5e33, var_aaa98411bc77fb1f, var_eb17d5c958e3fcda, var_29c1049cdd91eb32, var_64459132907ac449, var_41976210805f0afe, var_3a036abee5c890ba, is_entity, isdrone) {
  self notify("new_orders");
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self endon("stop_circling");
  self endon("stop_all_action");
  self setneargoalnotifydist(self.circlegoaldist);
  self setturningability(self.var_5bee9b82a537f1c0);
  var_e3ef073dd9338298 = getdvarint(@ "hash_2c1d3a8768e5e585", 0);
  self.var_1ae978cf5dc05edb = var_ce5c8b45f5bf97e8 + (0, 0, self.circleheight);
  var_d1d5a4e841132f8c = undefined;
  var_d5e8237d157774ec = undefined;
  var_31759f0a1036d495 = default_to(var_31759f0a1036d495, 0);
  var_4aed5403298a4d7f = default_to(var_4aed5403298a4d7f, 0);

  if(isDefined(var_64459132907ac449)) {
    self.circleheight = var_64459132907ac449;
  }

  assertex(isDefined(self.var_1ae978cf5dc05edb), "<dev string:xfa>");
  n_current_distance = distance2d(self.origin, self.var_1ae978cf5dc05edb);
  var_f0a3055b7b71a641 = randomintrange(self.circleradiusmin, self.circleradiusmax);

  if(isDefined(var_29c1049cdd91eb32)) {
    var_f0a3055b7b71a641 = var_29c1049cdd91eb32;
  }

  if(n_current_distance < var_f0a3055b7b71a641) {
    var_f0a3055b7b71a641 = max(n_current_distance, self.circleradiusmin);
  }

  var_aea88efa8310a0d7 = self.var_34226496d5530b2a;

  if(isDefined(var_3a036abee5c890ba)) {
    var_aea88efa8310a0d7 = var_3a036abee5c890ba * var_3a036abee5c890ba;
  } else if(isDefined(self.var_aea88efa8310a0d7)) {
    var_aea88efa8310a0d7 = self.var_aea88efa8310a0d7 * self.var_aea88efa8310a0d7;
  }

  var_738caee3d4576e5c = 0;
  increment_count = 0;

  while(!var_738caee3d4576e5c) {
    self.current_angle = function_e3a3b10fbf64512d(self.var_1ae978cf5dc05edb, var_f0a3055b7b71a641, increment_count);
    var_528d52dd307b6f07 = 32;
    circleincrement = 360 / var_528d52dd307b6f07;
    starttime = gettime();
    self.lastattackedtime = gettime();
    newgoal = self.var_1ae978cf5dc05edb + anglesToForward((0, self.current_angle, 0)) * var_f0a3055b7b71a641;
    obstructiontrace = function_56ebd2471f52c901(self.origin, newgoal, 325, self.ignorelist);
    var_738caee3d4576e5c = obstructiontrace["hittype"] == "hittype_none";
    var_2e7ebfa03d229b76 = 0;

    if(var_e3ef073dd9338298 == 1) {
      duration = 200;

      if(!var_738caee3d4576e5c) {
        sphere(obstructiontrace["<dev string:x11d>"], 325, (1, 0, 0), 0, duration);
        line(self.origin, obstructiontrace["<dev string:x11d>"], (1, 0, 0), 1, 0, duration);
        line(self.origin, newgoal, (0, 1, 0), 1, 0, duration);
        sphere(newgoal, 325, (0, 1, 0), 0, duration);
      } else {
        line(self.origin, newgoal, (0, 1, 0), 1, 0, duration);
        sphere(newgoal, 325, (0, 1, 0), 0, duration);
      }
    }

    increment_count++;
    wait 0.25;
  }

  while(var_738caee3d4576e5c) {
    if(isDefined(var_41976210805f0afe)) {
      timeout_duration = gettime() - starttime;

      if(function_c89ed1840c8d0f0f(timeout_duration) > var_41976210805f0afe) {
        break;
      }
    }

    if(var_e3ef073dd9338298 == 1) {
      thread function_1126bfe77ada7e75(var_f0a3055b7b71a641, self.var_1ae978cf5dc05edb);
    }

    newgoal = self.var_1ae978cf5dc05edb + anglesToForward((0, self.current_angle, 0)) * var_f0a3055b7b71a641;

    if(!var_2e7ebfa03d229b76) {
      if(var_e3ef073dd9338298 == 1) {
        duration = 200;
        line(self.origin, newgoal, (0, 1, 0), 1, 0, duration);
        sphere(newgoal, 325, (0, 1, 0), 0, duration);
      }

      obstructiontrace = function_56ebd2471f52c901(self.origin, newgoal, 325, self.ignorelist);

      if(obstructiontrace["hittype"] != "hittype_none") {
        if(var_e3ef073dd9338298 == 1) {
          duration = 200;
          sphere(obstructiontrace["<dev string:x11d>"], 325, (1, 0, 0), 0, duration);
          line(self.origin, obstructiontrace["<dev string:x11d>"], (1, 0, 0), 1, 0, duration);
        }

        self.var_cee00573b191bdb9 = !self.var_cee00573b191bdb9;
        self.current_angle += ter_op(self.var_cee00573b191bdb9, circleincrement * -1, circleincrement) * 2;
        self.current_angle = angleclamp(self.current_angle);
        self.var_1ae978cf5dc05edb = (self.var_1ae978cf5dc05edb[0], self.var_1ae978cf5dc05edb[1], self.var_1ae978cf5dc05edb[2] + 100);
        var_2e7ebfa03d229b76 = 1;
        continue;
      }
    }

    self.current_angle += ter_op(self.var_cee00573b191bdb9, circleincrement * -1, circleincrement);
    self.current_angle = angleclamp(self.current_angle);
    var_2e7ebfa03d229b76 = 0;

    if(var_e3ef073dd9338298 == 1) {
      duration = 200;
      print3d(self.origin, "<dev string:x129>" + self.current_angle, (1, 1, 1), 1, 1, duration, 1);
    }

    if(istrue(var_31759f0a1036d495)) {
      if(isDefined(self.current_target)) {
        self clearlookatent();
        waitframe();
        self setlookatent(self.current_target);
      }
    }

    var_36f900747ad147e6 = self.circlespeed;

    if(isDefined(self.var_36f900747ad147e6)) {
      var_36f900747ad147e6 = self.var_36f900747ad147e6;
    }

    function_d6eba8149fb949e9(newgoal, var_25b8738ccc2f5e33, self.circleheight, 1, undefined, undefined, var_36f900747ad147e6, undefined, undefined, isdrone);

    while(istrue(self.circle_paused)) {
      self notify("circling_paused");
      just_paused = 1;
      waitframe();
    }

    if(istrue(var_4aed5403298a4d7f) && isDefined(self.current_target) && !istrue(just_paused)) {
      if(scripts\engine\trace::ray_trace_passed(self.current_target getEye(), self.origin, [self.current_target, self])) {
        function_b91a289ed9de4db7(randomfloatrange(0, 5));
      }
    } else if(istrue(just_paused)) {
      just_paused = 0;
    }

    if(isDefined(var_eb17d5c958e3fcda)) {
      updated_pos = [[var_eb17d5c958e3fcda]](self);

      if(isDefined(updated_pos)) {
        self.var_1ae978cf5dc05edb = (updated_pos[0], updated_pos[1], updated_pos[2] + self.circleheight);
      }
    }

    waitframe();
  }

  self clearlookatent();
  self.var_38ed6a306a44585a = undefined;
  self.var_7690d8c6ccfe1f73 = undefined;
  self notify("stop_circling");
}

function function_b91a289ed9de4db7(pause_time, var_3756c44715a73d25) {
  self notify("pause_circling");
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self endon("stop_circling");
  self endon("pause_circling");
  self.circle_paused = 1;

  if(istrue(var_3756c44715a73d25)) {
    self sethoverparams(100, 10, 5);
    self waittill("resume_circling");
    self sethoverparams(self.hover_radius, self.hover_speed, self.hover_accel);
  } else if(isDefined(pause_time)) {
    self sethoverparams(100, 10, 5);
    wait pause_time;
    self sethoverparams(self.hover_radius, self.hover_speed, self.hover_accel);
  }

  self.circle_paused = 0;
}

function function_d6eba8149fb949e9(target, forcestopatgoal, forceheight, ignoreblocks, goalyaw, usegroundpoint, speedoverride, acceloverride, var_94b77a8a675ccd6e, isdrone, performgroundtrace) {
  if(!isDefined(performgroundtrace)) {
    performgroundtrace = 1;
  }

  self notify("state_change");
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self endon("new_orders");
  self endon("state_change");
  self endon("stop_all_action");
  newpos = undefined;
  anglevehicle = undefined;
  unload = 0;
  flagwait = 0;
  var_ccf44cff39a902f0 = 0;
  goalyaw = default_to(goalyaw, undefined);
  var_e3ef073dd9338298 = getdvarint(@ "hash_2c1d3a8768e5e585", 0);
  testtarget = target;
  assertex(isDefined(target), "<dev string:x12d>");

  if(!isvector(target)) {
    testtarget = target.origin;

    if(isDefined(target.script_goalyaw)) {
      goalyaw = target.script_goalyaw;
    }

    if(isDefined(target.script_anglevehicle)) {
      anglevehicle = target.script_anglevehicle;
    }

    if(isDefined(target.script_unload)) {
      unload = target.script_unload;
    }

    flagwait = isDefined(target.script_flag_wait);
    var_ccf44cff39a902f0 = !isDefined(target.target);
  }

  min_height = ter_op(isDefined(forceheight), forceheight, self.var_a32eb5da7024e7c4);
  traceradius = istrue(isdrone) ? 32 : 325;
  ignorelist = self.ignorelist;

  while(true) {
    xpos = testtarget[0];
    ypos = testtarget[1];
    zpos = testtarget[2];

    if(performgroundtrace || isDefined(forceheight)) {
      ground_point = getgroundposition(testtarget, traceradius, min_height);

      if(isDefined(ground_point)) {
        zpos = ground_point[2] + min_height;

        if(var_e3ef073dd9338298) {
          sphere((xpos, ypos, ground_point[2]), traceradius, (1, 0, 1), undefined, 100);
        }
      }
    }

    currentpos = self.origin;
    initialgoalpos = (xpos, ypos, zpos);
    obstructed = 0;

    if(!istrue(ignoreblocks)) {
      obstructiontrace = function_56ebd2471f52c901(currentpos, initialgoalpos, traceradius, ignorelist);

      if(isDefined(obstructiontrace)) {
        if(obstructiontrace["hittype"] != "hittype_none") {
          if(istrue(var_94b77a8a675ccd6e)) {
            return false;
          }

          xpos = obstructiontrace["position"][0];
          ypos = obstructiontrace["position"][1];
          obstructed = 1;
          ground_point = getgroundposition(obstructiontrace["position"], traceradius, 2500, 2000);
          var_a7b8e7eed2e7734e = ter_op(isDefined(ground_point), ground_point[2], 2000);

          if(var_e3ef073dd9338298) {
            sphere(obstructiontrace["<dev string:x11d>"], traceradius, (1, 0, 0), undefined, 100);
            sphere((xpos, ypos, var_a7b8e7eed2e7734e), traceradius, (1, 0, 1), undefined, 100);
          }
        }
      }
    }

    if(obstructed) {
      zpos = var_a7b8e7eed2e7734e + min_height;
    }

    zpos = clamp(zpos, 0, 8000);
    newpos = (xpos, ypos, zpos);

    if(var_e3ef073dd9338298) {
      sphere(newpos, traceradius, (1, 1, 0), undefined, 100);
    }

    stopatgoal = 0;

    if(istrue(forcestopatgoal) && !istrue(obstructed)) {
      stopatgoal = forcestopatgoal;
    }

    if(var_e3ef073dd9338298 == 1) {
      thread function_4dc385ff6dceb535(newpos);
      thread function_4dc385ff6dceb535(initialgoalpos, (0, 1, 0));
    }

    speed = undefined;

    if(isDefined(speedoverride)) {
      speed = speedoverride;
    } else if(!isvector(target) && isDefined(target.script_speed)) {
      speed = target.script_speed;
    } else {
      speed = self.speed;
    }

    self vehicle_helisetai(newpos, speed, acceloverride, 50, goalyaw, anglevehicle, 0, undefined, 0, stopatgoal, unload, flagwait, var_ccf44cff39a902f0);
    msg = waittill_any_return_2("near_goal", "begin_evasive_maneuvers");

    if(!istrue(obstructed)) {
      break;
    }
  }

  return true;
}

function heli_takeoff(target_location) {
  self notify("new_orders");
  self endon("new_orders");
  self endon("death");
  self endon("leaving");
  self endon("crashing");

  if(!isDefined(target_location)) {
    target_location = self.origin;
  }

  self sethoverparams(self.hover_radius, self.hover_speed, self.hover_accel);
  self vehicle_setspeed(self.takeoffspeed, self.var_ab0a05a03b262cf1);
  wait 2;
  function_d6eba8149fb949e9(target_location, 1);
  self.is_landed = 0;

  if(isDefined(self.turrets) && self.turrets.size > 0) {
    foreach(turret in self.turrets) {
      turret.turreton = 1;
    }
  }

  self vehicle_setspeed(self.originalspeed, self.accel);
}

function heli_land(target_location) {
  self notify("new_orders");
  self endon("new_orders");
  self endon("death");
  self endon("leaving");
  self endon("crashing");

  if(!isDefined(target_location)) {
    target_location = self.origin;
  }

  if(!isvector(target_location)) {
    target_location = target_location.origin;
  }

  function_d6eba8149fb949e9(target_location, 1);

  while(distance2dsquared(self.origin, target_location) > self.var_413cd32ed3724791) {
    waitframe();
  }

  self vehicle_setspeed(self.takeoffspeed, self.var_ab0a05a03b262cf1);
  function_d6eba8149fb949e9(target_location, 1, undefined, undefined, undefined, 1);
  self.is_landed = 1;

  if(isDefined(self.turrets) && self.turrets.size > 0) {
    foreach(turret in self.turrets) {
      turret.turreton = 0;
    }
  }

  self sethoverparams(0, 0, 0);
}

function function_f638b39453994581() {}

function function_90786c097a7d7433(target_ent) {
  self endon("missile_attack");
  self setlookatent(target_ent);
  dot = 0;

  while(dot < 0.98) {
    vector_to_target = target_ent.origin - self.origin;
    vector_forward = anglesToForward(self.angles);
    dot = vectordot2(vector_to_target, vector_forward, 1);
    waitframe();
  }

  thread function_d19d987a94ac039a(target_ent);
}

function private function_2029e383e2ec901(target_ent) {
  self setlookatent(target_ent);
  target_ent endon("death");
  dot = 0;

  while(dot < 0.98) {
    vector_to_target = target_ent.origin - self.origin;
    vector_forward = anglesToForward(self.angles);
    dot = vectordot2(vector_to_target, vector_forward, 1);
    waitframe();
  }

  childthread function_a2262da7c12166e1(target_ent.origin, 0, 4000);
  childthread function_d19d987a94ac039a(target_ent);
}

function private function_d19d987a94ac039a(target_ent) {
  self endon("strafe_complete");
  childthread function_61e90c153370f34c(target_ent);
  childthread function_8c6288b37bca3acc();
  dot = 0;

  while(dot < 0.98) {
    vector_to_target = vectorNormalize(target_ent.origin - self.origin);
    vector_forward = vectorNormalize(anglesToForward(self.angles));
    dot = vectordot(vector_to_target, vector_forward);
    waitframe();
  }

  missiles_fire();
}

function private function_8c6288b37bca3acc() {
  self waittill("missiles_fired");
  function_8e54039e0bb56066(self.angles[0], 0);
}

function private function_61e90c153370f34c(target_ent) {
  self endon("missiles_fired");
  self endon("strafe_complete");
  function_35ebc7f46056f245(target_ent);
}

function private missiles_fire() {
  self.var_580ba3be57af233e = 0;
  self.team = "team_hundred_ninety";
  missiletags = ["tag_gun_right1", "tag_gun_left1", "tag_gun_right2", "tag_gun_left2"];
  var_eca5243ed04c621 = 4;
  wait 1;

  for(i = 0; i < var_eca5243ed04c621; i++) {
    missilestart = self gettagorigin(missiletags[i % 4]) + anglesToForward(self.angles + (0, 0, 0)) * 200;
    missileend = self gettagorigin(missiletags[i % 4]) + anglesToForward(self.angles + (6, 0, 0)) * 1000;
    missile = scripts\cp_mp\utility\weapon_utility::_magicbullet(self.missileweapon, missilestart, missileend, self);
    wait 0.3;
  }

  self notify("missiles_fired");
}

function function_3c82ba8af1c7ea09() {}

function private function_56ebd2471f52c901(start, end, radius, ignore, contentoverride, getsurfacetype, var_b00c60a54d663ca2) {
  dist = distance(start, end);
  println("<dev string:x159>" + start + "<dev string:x177>" + end + "<dev string:x181>" + radius + "<dev string:x18e>" + dist);

  if(getdvarint(@ "hash_2c1d3a8768e5e585", 0) || getdvarint(@ "hash_9aa835d8fcd3b58d", 0)) {
    sphere(start, radius, (1, 0, 0), undefined, 100);
    line(start, end, (1, 0, 0), 1, undefined, 100);
    sphere(end, radius, (1, 0, 0), undefined, 100);

    if(!isDefined(level.var_f40761825dce0d99)) {
      level.var_f40761825dce0d99 = 0;
    } else {
      level.var_f40761825dce0d99++;
    }

    iprintln("<dev string:x19d>" + level.var_f40761825dce0d99 + "<dev string:x18e>" + dist);
  }

  return trace::sphere_trace(start, end, radius, ignore, contentoverride, getsurfacetype, var_b00c60a54d663ca2);
}

function private function_e3a3b10fbf64512d(circleorigin, circleradius, interval) {
  heliforward = anglesToForward(self.angles);
  var_b99d0690ec1b48a0 = vectorNormalize(heliforward * (1, 1, 0));
  helileft = anglestoleft(self.angles);
  var_c7c2d0d0c038878a = vectorNormalize(helileft * (1, 1, 0));
  var_db4b7f35a2b65598 = circleorigin - self.origin;
  var_350e5874d177850e = vectorNormalize(var_db4b7f35a2b65598 * (1, 1, 0));
  var_b419b1df445ce254 = vectordot(var_b99d0690ec1b48a0, var_350e5874d177850e);
  var_6eabde346129539a = vectordot(var_c7c2d0d0c038878a, var_350e5874d177850e);

  if(var_b419b1df445ce254 > 0) {
    self.var_cee00573b191bdb9 = ter_op(var_6eabde346129539a > 0, 0, 1);
  } else {
    self.var_cee00573b191bdb9 = ter_op(var_6eabde346129539a > 0, 1, 0);
  }

  var_88b83b0d7a43ea72 = ter_op(var_6eabde346129539a > 0, (0, -90, 0), (0, 90, 0));
  radiusdirection = rotatevector(var_b99d0690ec1b48a0, var_88b83b0d7a43ea72);

  var_e3ef073dd9338298 = getdvarint(@ "hash_2c1d3a8768e5e585", 0);

  if(var_e3ef073dd9338298) {
    duration = 8000;
    desiredlocation = circleorigin + radiusdirection * circleradius;
    directionlength = 200;
    spherecolor = ter_op(var_b419b1df445ce254 > 0, (0, 1, 0), (1, 0, 0));
    line(self.origin, self.origin + var_b99d0690ec1b48a0 * directionlength, (1, 0, 0), 1, 0, duration);
    line(self.origin, self.origin + var_c7c2d0d0c038878a * directionlength, (0, 0, 1), 1, 0, duration);
    line(self.origin, self.origin + radiusdirection * directionlength, (0.01, 0.85, 1), 1, 0, duration);
    line(self.origin, self.origin + var_db4b7f35a2b65598, (1, 0.92, 0.16), 1, 0, duration);
    line(circleorigin, desiredlocation, (0.98, 0.75, 0.79), 1, 0, duration);
    sphere(circleorigin, 10, spherecolor, 0, duration);
    debugtext = "<dev string:x129>";
    debugtext = ter_op(var_b419b1df445ce254 > 0, "<dev string:x1bb>", "<dev string:x1c4>");
    debugtext += ter_op(var_6eabde346129539a > 0, "<dev string:x1cc>", "<dev string:x1d5>");
    debugtext += ter_op(self.var_cee00573b191bdb9, "<dev string:x1df>", "<dev string:x1e6>");
    print3d(circleorigin, debugtext, (1, 1, 1), 1, 1, duration, 1);
  }

  var_3568b4d1648d2c20 = vectortoangles(radiusdirection);
  return var_3568b4d1648d2c20[1] - 15 * interval;
}

function private function_93ff5e5ba263fc6d(attacker, targ) {
  target_direction = targ.origin - attacker.origin;
  return vectordot2(target_direction, anglesToForward(attacker.angles), 1);
}

function private function_4dc385ff6dceb535(newpos, color) {
  self notify("<dev string:x1ee>");
  self endon("<dev string:x1ee>");
  self endon("<dev string:x20c>");
  self endon("<dev string:x215>");
  self endon("<dev string:x220>");
  self endon("<dev string:x22c>");
  self endon("<dev string:x239>");

  if(!isDefined(color)) {
    color = (1, 0, 0);
  }

  while(true) {
    sphere(newpos, 32, color, 0, 1);
    line(self.origin, newpos, color, 1, 0, 0, 1);
    waitframe();
  }
}

function private function_1126bfe77ada7e75(var_f0a3055b7b71a641, var_9110a770bb630563) {
  self notify("<dev string:x254>");
  self endon("<dev string:x254>");
  self endon("<dev string:x20c>");
  self endon("<dev string:x215>");
  self endon("<dev string:x220>");
  self endon("<dev string:x22c>");
  self endon("<dev string:x239>");

  while(true) {
    level thread draw_circle(var_9110a770bb630563, var_f0a3055b7b71a641, (1, 0, 0), 1, 0, 10);
    wait 0.5;
  }
}

function private function_35ebc7f46056f245(target_ent) {
  self setmaxpitchroll(self.var_d9ba194b1c40ff94, 30);
  function_8e54039e0bb56066(self.angles[0], getpitchtospot3d(target_ent.origin));
}

function private function_8e54039e0bb56066(starting_pitch, pitch_needed, pitch_rate) {
  pitch_rate = default_to(pitch_rate, 13);

  if(starting_pitch > 180) {
    pitch_needed += 360;
  }

  pitch_dif = abs(pitch_needed - self.angles[0]);
  total_time = pitch_dif / pitch_rate;
  start_time = gettime();
  time_elapsed = 0;

  if(total_time <= 0) {
    return;
  }

  while(true) {
    time_elapsed = (gettime() - start_time) / 1000;
    pitch = math::lerp(starting_pitch, pitch_needed, clamp(time_elapsed / total_time, 0, 1)) % 360;
    self.angles = (pitch, self.angles[1], self.angles[2]);
    waitframe();
  }
}

function function_e3ab01a91dc64df0() {
  level endon("game_ended");
  self endon("chopperSupport_gone");
  owner = self.owner;

  while(isDefined(self) && self.health > 0) {
    waitframe();
  }

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.turrets) && self.turrets.size > 0) {
    foreach(turret in self.turrets) {
      turret.turreton = 0;
    }
  }

  if(issharedfuncdefined("killstreak", "isKillstreakWeapon")) {
    if(!function_f3bb4f4911a1beb2("killstreak", "isKillStreakWeapon", self.killedbyweapon)) {
      heli_crash(100);
    }
  }

  heli_explode();
}

function private heli_explode() {
  self notify("explode");
  self notify("state_change");
  self radiusdamage(self.origin, 1000, 200, 200, undefined, "MOD_EXPLOSIVE", "chopper_support_turret_mp");
  self setscriptablepartstate("explode", "on", 0);
  wait 0.35;
  heli_cleanup(1);
}

function heli_cleanup(wasdestroyed) {
  if(self.turrets.size > 0) {
    foreach(turret in self.turrets) {
      if(isDefined(turret)) {
        turret setentityowner(undefined);
        turret.groundtargetent delete();
        turret delete();
      }
    }
  }

  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(self);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

function private heli_crash(speed) {
  self endon("explode");
  self setscriptablepartstate("crash", "on", 0);

  if(isDefined(self.killcament)) {
    self.killcament unlink();
    self.killcament.origin = self.origin + (0, 0, 100);
  }

  self clearlookatent();
  self notify("crashing");
  self.iscrashing = 1;
  self vehicle_setspeed(speed, 20, 20);
  self setneargoalnotifydist(100);
  var_6847739e80fb4e81 = function_7e27abfd534d1e45(2000, 500, 1000);

  if(!isDefined(var_6847739e80fb4e81)) {
    return;
  }

  self setvehgoalpos(var_6847739e80fb4e81, 0);
  thread heli_spinout(speed);
  self vehicle_turnengineoff();
  self waittill("near_goal");
}

function private function_7e27abfd534d1e45(crashdist, var_6c56ff5ecc704c48, var_6c7af55ecc98b102) {
  crashstart = self.origin;
  crashoffset = self.crashoffset;
  crashpos = undefined;
  jetforward = anglesToForward(self.angles);
  jetright = anglestoright(self.angles);
  crashend = crashstart + jetforward * crashdist - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart - jetforward * crashdist - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + jetright * crashdist - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart - jetright * crashdist - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + 0.707 * crashdist * (jetforward + jetright) - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + 0.707 * crashdist * (jetforward - jetright) - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + 0.707 * crashdist * (jetright - jetforward) - (0, 0, crashoffset);
  crashtrace = ray_trace(crashstart, crashend, self);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + 0.707 * crashdist * (-1 * jetforward - jetright) - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  return crashpos;
}

function private heli_spinout(speed) {
  self endon("death");
  self setyawspeed(speed, 50, 50, 0.5);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + speed * 0.4);
    wait 0.5;
  }
}

function function_99a774485b72ded3(starttrace) {
  droplocation = undefined;
  endtrace = starttrace - (0, 0, 20000);
  ignorelist = [self];
  trace = scripts\engine\trace::ray_trace(starttrace, endtrace, ignorelist);

  if(isDefined(trace) && trace["hittype"] != "hittype_none") {
    droplocation = trace["position"];
  }

  return droplocation;
}

function private function_45cc03649256e6f3(data) {
  if(isDefined(data.attacker)) {
    ent_num = data.attacker getentitynumber();

    if(!array_contains_key(self.attackers, ent_num)) {
      self.attackers[ent_num] = 0;
    }

    self.attackers[ent_num] += data.damage;
    scripts\mp\mp_agent_damage::function_c54b2cc2e762c201(data.attacker, self, data.hitloc, data.meansofdeath, data.objweapon, int(data.damage), data.point, 0, undefined, 0, 0);
  }

  return true;
}

function private function_d9630ff97ef012cf(data) {
  scripts\cp_mp\killstreaks\chopper_support::choppersupport_handledeathdamage(data);

  foreach(deathcallback in self.deathcallbacks) {
    self thread[[deathcallback]](self, data);
  }

  self notify("death");
  return true;
}

function function_c96e4b15db766b84(settings_bundle) {
  if(!isDefined(settings_bundle)) {
    settings_bundle = getscriptbundle("helicoptersettings:default_helicopter_settings");
  }

  if(isDefined(settings_bundle)) {
    assertex(settings_bundle.bundletype == "<dev string:x26d>", "<dev string:x284>");
  }

  function_f8d9191e53984195(settings_bundle.var_1677a5799ea2d883);
  function_9e96cdf67b925aa0(settings_bundle.hasturret, settings_bundle.turretsettings);
  function_7dac0131a74b9e48(settings_bundle.hoverradius, settings_bundle.hoverspeed, settings_bundle.hoveraccel, settings_bundle.hoverminheight);
  function_46f757d9ff2fdfcc(settings_bundle.helihealth, settings_bundle.var_7472d0ddfd2019ca);
  function_268f89699b68533e(settings_bundle.circlegoaldist, settings_bundle.circlespeed, settings_bundle.circleradiusmin, settings_bundle.circleradiusmax, settings_bundle.circleheight, settings_bundle.var_5bee9b82a537f1c0, settings_bundle.var_34226496d5530b2a, settings_bundle.var_46d92644542e2ae6, settings_bundle.var_8ee581a878abca60);
  function_324badbe006153(settings_bundle.var_27b3267d1a2697dd, settings_bundle.pathgoaldistance, settings_bundle.basespeed, settings_bundle.takeoffspeed, settings_bundle.var_ab0a05a03b262cf1, settings_bundle.groundoffset, settings_bundle.var_413cd32ed3724791);
  function_618793408ff0894a(settings_bundle.hasmissiles, settings_bundle.missileinterval, settings_bundle.missileweapon, settings_bundle.var_d9ba194b1c40ff94, settings_bundle.var_da6ccdbfcffb23b1, settings_bundle.var_90487055ec2291ba);
}

function function_de3fc172a25ca50b() {
  while(true) {
    helihealth = getdvarint(@ "hash_39512dcad0dfbf5a", -1);

    if(helihealth != -1 && self.helihealth != helihealth) {
      self.helihealth = helihealth;
      function_3dcc8d2fa9bc93f7(self.helihealth);
    }

    missileinterval = getdvarfloat(@ "hash_61b0eb8825f9e210", -1);

    if(missileinterval != -1 && self.missileinterval != missileinterval) {
      self.missileinterval = missileinterval;
    }

    waitframe();
  }
}

function private function_f8d9191e53984195(var_c8e4f9c808bc6727) {
  var_c8e4f9c808bc6727 = default_to(var_c8e4f9c808bc6727, 45);
  self.var_cc99a14e60508d29 = cos(var_c8e4f9c808bc6727);
}

function private function_9e96cdf67b925aa0(hasturret, turretsettings) {
  hasturret = default_to(hasturret, 1);
  self.hasturret = hasturret;
  self.turretsettings = turretsettings;
}

function private function_46f757d9ff2fdfcc(helihealth, var_7472d0ddfd2019ca) {
  helihealth = default_to(helihealth, 2000);
  var_7472d0ddfd2019ca = default_to(var_7472d0ddfd2019ca, 0);
  self.helihealth = helihealth;
  self.var_7472d0ddfd2019ca = var_7472d0ddfd2019ca;
}

function private function_7dac0131a74b9e48(hover_radius, hover_speed, hover_accel, var_a32eb5da7024e7c4) {
  hover_radius = default_to(hover_radius, 50);
  hover_speed = default_to(hover_speed, 5);
  hover_accel = default_to(hover_accel, 2.5);
  var_a32eb5da7024e7c4 = default_to(var_a32eb5da7024e7c4, 256);
  self.hover_radius = hover_radius;
  self.hover_speed = hover_speed;
  self.hover_accel = hover_accel;
  self.var_a32eb5da7024e7c4 = var_a32eb5da7024e7c4;
}

function private function_324badbe006153(var_27b3267d1a2697dd, pathgoaldistance, basespeed, takeoffspeed, var_ab0a05a03b262cf1, groundoffset, var_413cd32ed3724791) {
  var_27b3267d1a2697dd = default_to(var_27b3267d1a2697dd, 3);
  pathgoaldistance = default_to(pathgoaldistance, 256);
  basespeed = default_to(basespeed, 40);
  takeoffspeed = default_to(takeoffspeed, 10);
  var_ab0a05a03b262cf1 = default_to(var_ab0a05a03b262cf1, 5);
  groundoffset = default_to(groundoffset, 128);
  var_413cd32ed3724791 = default_to(var_413cd32ed3724791, 65536);
  self.var_27b3267d1a2697dd = var_27b3267d1a2697dd;
  self.pathgoaldistance = pathgoaldistance;
  self.speed = basespeed;
  self.takeoffspeed = takeoffspeed;
  self.var_ab0a05a03b262cf1 = var_ab0a05a03b262cf1;
  self.groundoffset = groundoffset;
  self.var_413cd32ed3724791 = var_413cd32ed3724791;
}

function private function_268f89699b68533e(circlegoaldist, circlespeed, circleradiusmin, circleradiusmax, circleheight, var_5bee9b82a537f1c0, var_34226496d5530b2a, var_46d92644542e2ae6, var_8ee581a878abca60) {
  circlegoaldist = default_to(circlegoaldist, 128);
  circlespeed = default_to(circlespeed, 30);
  circleradiusmin = default_to(circleradiusmin, 1500);
  circleradiusmax = default_to(circleradiusmax, 2560);
  circleheight = default_to(circleheight, 768);
  var_5bee9b82a537f1c0 = default_to(var_5bee9b82a537f1c0, 1);
  var_34226496d5530b2a = default_to(var_34226496d5530b2a, 4194304);
  var_46d92644542e2ae6 = default_to(var_46d92644542e2ae6, 3);
  var_8ee581a878abca60 = default_to(var_8ee581a878abca60, 8);
  self.circlegoaldist = circlegoaldist;
  self.circlespeed = circlespeed;
  self.circleradiusmin = circleradiusmin;
  self.circleradiusmax = circleradiusmax;
  self.circleheight = circleheight;
  self.var_5bee9b82a537f1c0 = var_5bee9b82a537f1c0;
  self.var_34226496d5530b2a = var_34226496d5530b2a;
  self.var_46d92644542e2ae6 = var_46d92644542e2ae6;
  self.var_8ee581a878abca60 = var_8ee581a878abca60;
}

function private function_618793408ff0894a(hasmissiles, missileinterval, var_ffd128d3b3bac67a, var_d9ba194b1c40ff94, var_da6ccdbfcffb23b1, var_e309f77b84ade0d9) {
  hasmissiles = default_to(hasmissiles, 1);
  missileinterval = default_to(missileinterval, 15000);
  var_ffd128d3b3bac67a = default_to(var_ffd128d3b3bac67a, "chopper_gunner_proj_dmz");
  var_d9ba194b1c40ff94 = default_to(var_d9ba194b1c40ff94, 60);
  var_da6ccdbfcffb23b1 = default_to(var_da6ccdbfcffb23b1, 30);
  var_e309f77b84ade0d9 = default_to(var_e309f77b84ade0d9, 5500);
  self.hasmissiles = hasmissiles;
  self.missileinterval = missileinterval;
  self.var_ffd128d3b3bac67a = var_ffd128d3b3bac67a;
  self.var_d9ba194b1c40ff94 = var_d9ba194b1c40ff94;
  self.var_da6ccdbfcffb23b1 = var_da6ccdbfcffb23b1;
  self.var_e309f77b84ade0d9 = var_e309f77b84ade0d9;
}

function function_3dcc8d2fa9bc93f7(helihealth) {
  self.health = helihealth;
  self.maxhealth = helihealth;
}