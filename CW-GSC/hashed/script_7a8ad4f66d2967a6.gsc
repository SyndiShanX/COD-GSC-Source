/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_7a8ad4f66d2967a6.gsc
***********************************************/

#using scripts\abilities\ability_player;
#using scripts\abilities\ability_util;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp_common\util;
#using scripts\killstreaks\airsupport;
#using scripts\killstreaks\helicopter_shared;
#using scripts\killstreaks\killstreaks_shared;
#namespace namespace_486c0593;

function private autoexec __init__system__() {
  system::register(#"hash_1a2d9866d1e59eb6", &preinit, undefined, undefined, undefined);
}

function function_81b25df4() {}

function preinit() {
  level.chopper_fx[# "explode"][# "death"] = "destruct/fx8_atk_chppr_exp_lg";
  level.chopper_fx[# "explode"][# "guard"] = "killstreaks/fx_heli_exp_md";
  level.chopper_fx[# "explode"][# "gunner"] = "killstreaks/fx_vtol_exp";
  level.chopper_fx[# "explode"][# "large"] = "killstreaks/fx_heli_exp_sm";
  level.chopper_fx[# "damage"][# "light_smoke"] = "destruct/fx8_atk_chppr_smk_trail";
  level.chopper_fx[# "damage"][# "heavy_smoke"] = "destruct/fx8_atk_chppr_exp_trail";
  level.chopper_fx[# "smoke"][# "trail"] = "destruct/fx8_atk_chppr_exp_trail";
  level.chopper_fx[# "fire"][# "trail"][# "large"] = "killstreaks/fx_heli_smk_trail_engine";
  function_792e5cc5();
  level.var_e071ed64 = 1;

  level thread function_24111b5e();

  level.var_6ec3a820 = getdvarint(#"hash_1300f6ba32e8d68c", 512);
  level.var_aaa4273e = getdvarint(#"hash_163c95340307e3aa", 320);
  level.var_3851f0df = getdvarint(#"hash_16579f34031ebc60", 512);
  level.var_46574a81 = getdvarint(#"hash_26f6fa23a134bc05", 4);
  level.var_eacd8867 = getdvarint(#"hash_27120423a14b94bb", 6);
  level.var_324af044 = getdvarint(#"scr_heli_protect_time", 20);
  level.heli_targeting_delay = getDvar(#"scr_heli_targeting_delay", 1);
  level.var_17076139 = getdvarint(#"hash_5681be4514516b7a", 320);
  level.var_c2bbc18f = getdvarint(#"hash_569da8451469c0d0", 512);
  level.var_d9c77d70 = getdvarint(#"hash_7e0189d9c55ba919", 350);
  level.heli_debug = getDvar(#"scr_heli_debug", 0);
  level.heli_turretreloadtime = getDvar(#"scr_heli_turretreloadtime", 0.5);
  level.heli_turretclipsize = getDvar(#"scr_heli_turretclipsize", 60);
  level.heli_visual_range = isDefined(level.heli_visual_range_override) ? level.heli_visual_range_override : getDvar(#"scr_heli_visual_range", 3500);
  level.heli_target_recognition = getDvar(#"scr_heli_target_recognition", 0.2);
}

function function_6973d387(start_node, var_212b9b37, var_2747d300) {
  waitframe(1);
  level.players[0] endon(#"death", #"hash_5ad36894fc83f27f");

  if(!isDefined(start_node)) {
    var_b202465d = self function_5dcf6173();
    loop = level.var_462eb982[var_b202465d].var_5943fcff;
    start_node = loop[0];
    iprintlnbold("starting loop " + start_node.script_noteworthy);
  }

  var_eec612d4 = function_e913c7a3(start_node, var_212b9b37, var_2747d300);
  var_eec612d4 function_2cadff8e();
  var_eec612d4 function_e1c90bb4();
  var_eec612d4 endon(#"death");
  level notify(#"hash_3fc267cc03439279");
  level.players[0] thread function_e5ece755();
  level.players[0] thread function_80b42ad9(var_eec612d4);
  level.players[0] function_def737fb();
  self callback::on_grenade_fired(&function_8b1917b3);
  var_18e578d4 = undefined;
  var_bd7aec31 = undefined;
  var_eec612d4 thread function_79c4d29d();
}

function function_e913c7a3(start_node, var_212b9b37, var_2747d300) {
  chopper = undefined;

  if(isDefined(var_2747d300)) {
    chopper = var_2747d300;

    if(!isDefined(level.var_fb14fd3b)) {
      level.var_fb14fd3b = var_2747d300;
    }
  } else if(isDefined(level.var_fb14fd3b)) {
    chopper = level.var_fb14fd3b;
  }

  if(!isDefined(chopper)) {
    chopper = spawn_chopper(start_node);

    if(!isDefined(chopper)) {
      assertmsg("<dev string:x38>");
    }

    level.var_fb14fd3b = chopper;
  } else if(isDefined(start_node)) {
    if(is_true(var_212b9b37)) {
      chopper.origin = start_node.origin;
      chopper.angles = start_node.angles;
    } else {
      chopper function_a57c34b7(start_node.origin, 1);
      chopper setgoalyaw((0, start_node.angles[1], 0)[1]);
      chopper settargetyaw((0, start_node.angles[1], 0)[1]);
      chopper waittill(#"goal", #"near_goal", #"reached_end_node", #"reached_node");
      chopper cleartargetyaw();
      chopper cleargoalyaw();
      chopper function_d4c687c9();
      chopper setspeedimmediate(50);
    }
  }

  return chopper;
}

function function_2cadff8e() {
  self.ignoreme = 1;
  self setCanDamage(0);
  self val::set("killstreak_chopper", "allowdeath", 0);
  self setowner(level.players[0]);
  self.owner = level.players[0];
  self.destroyfunc = &destroyhelicopter;
  self.soundmod = "heli";
  self.targetname = "chopper";
  self.team = # "allies";
  self setteam(#"allies");
  self.target_offset = (0, 0, 0);
  self.var_54b19f55 = 1;
  self.var_94e122a8 = undefined;
  self.var_5b7a23a6 = undefined;
  self.var_62bbe904 = undefined;
  self.primarytarget = undefined;
  self.secondarytarget = undefined;
  self.var_d27dd600 = undefined;
  self.var_fefc75e8 = undefined;
  self.targeting_delay = level.heli_targeting_delay;
  self flag::clear("on_attack_run");
  self.var_a519d8a = getweapon(#"hash_4385cf507401820f");
  self.var_be3896fe = getweapon(#"hash_603c083704cefb0c");
  self.defaultweapon = self.var_a519d8a;
  riders = self vehicle::function_86c7bebb();
  self.gunners = [];

  foreach(rider in riders) {
    if(rider.var_5574287b === "gunner1") {
      self.leftgunner = rider;

      if(!isDefined(self.gunners)) {
        self.gunners = [];
      } else if(!isarray(self.gunners)) {
        self.gunners = array(self.gunners);
      }

      self.gunners[self.gunners.size] = rider;
      continue;
    }

    if(rider.var_5574287b === "gunner2") {
      self.var_e8b1fa34 = rider;

      if(!isDefined(self.gunners)) {
        self.gunners = [];
      } else if(!isarray(self.gunners)) {
        self.gunners = array(self.gunners);
      }

      self.gunners[self.gunners.size] = rider;
      continue;
    }

    rider.ignoreall = 1;
  }

  self notify(#"riders_spawned");
}

function function_792e5cc5() {
  level.var_462eb982 = [];
  level.var_130e29a7 = [];
  var_311100f0 = util::get_array("heli_loop_start");
  var_130e29a7 = util::get_array("loop_anchor");

  for(i = 0; i < var_311100f0.size; i++) {
    if(var_311100f0[i].script_noteworthy == "bamboo_loop") {
      continue;
    }

    startnode = getent(var_311100f0[i].target, "targetname");

    if(!isDefined(startnode)) {
      startnode = struct::get(var_311100f0[i].target, "targetname");
    }

    if(!isDefined(startnode)) {
      startnode = getvehiclenode(var_311100f0[i].target, "targetname");
    }

    startnode.var_5943fcff = [];

    if(isDefined(startnode.target)) {
      array::add(startnode.var_5943fcff, startnode);
      next_node = getent(startnode.target, "targetname");

      if(!isDefined(next_node)) {
        next_node = struct::get(startnode.target, "targetname");
      }

      if(!isDefined(next_node)) {
        next_node = getvehiclenode(startnode.target, "targetname");
      }

      while(true) {
        array::add(startnode.var_5943fcff, next_node);
        current_node = next_node;
        next_node = getent(current_node.target, "targetname");

        if(!isDefined(next_node)) {
          next_node = struct::get(current_node.target, "targetname");
        }

        if(!isDefined(next_node)) {
          next_node = getvehiclenode(current_node.target, "targetname");
        }

        if(next_node == startnode) {
          break;
        }
      }
    }

    level.var_462eb982[int(startnode.script_noteworthy)] = startnode;
  }

  for(i = 0; i < var_130e29a7.size; i++) {
    level.var_130e29a7[int(var_130e29a7[i].script_noteworthy)] = var_130e29a7[i];
  }
}

function spawn_chopper(start_node) {
  vehicledef = "vehicle_t9_mil_us_helicopter_large_cp_armada_player";
  spawn_node = start_node;

  if(!isDefined(spawn_node)) {
    spawn_node = function_89116a1e();
  }

  if(!isDefined(spawn_node)) {
    return;
  }

  chopper = spawnvehicle(vehicledef, spawn_node.origin, spawn_node.angles);
  chopper vehicle::toggle_tread_fx(1);
  chopper vehicle::toggle_exhaust_fx(1);
  chopper vehicle::toggle_sounds(1);
  chopper vehicle::lights_on();
  chopper setrotorspeed(1);
  var_4301b21d = vehicle::function_999240f5(chopper);

  if(var_4301b21d < 0) {
    var_4301b21d = 0;
  } else if(var_4301b21d > 4) {
    var_4301b21d = 4;
  }

  for(i = 0; i < var_4301b21d; i++) {
    rider = spawnactor("spawner_bo5_human_allies_us_army_ar", chopper.origin, (0, 0, 0), "killstreak_chopper_passenger");

    if(i == 0) {
      seat = "driver";
    } else if(i == 1) {
      seat = "passenger1";
    } else if(i == 2) {
      seat = "gunner1";
    } else if(i == 3) {
      seat = "gunner2";
    }

    vehicle::get_in(rider, chopper, seat);
    rider util::magic_bullet_shield();
    rider ai::gun_remove();
  }

  return chopper;
}

function private function_89116a1e() {
  spawn_node = undefined;

  if(isDefined(level.var_af853ba7) && level.var_af853ba7.size > 0) {
    spawn_node = level.var_af853ba7[0];
  } else if(isDefined(level.var_462eb982) && level.var_462eb982.size > 0) {
    spawn_node = array::random(level.var_462eb982);
  } else {
    iprintlnbold("cp_heli_killstreak - no viable nodes spawn points defined! Aborting!");
  }

  return spawn_node;
}

function destroyhelicopter(var_fec7078b) {
  if(self.var_6c027ee0 === 1) {
    return;
  }

  self.var_6c027ee0 = 1;

  if(target_istarget(self)) {
    target_remove(self);
  }

  if(isDefined(self.interior_model)) {
    self.interior_model delete();
    self.interior_model = undefined;
  }

  if(isDefined(self.minigun_snd_ent)) {
    self.minigun_snd_ent stoploopsound();
    self.minigun_snd_ent delete();
    self.minigun_snd_ent = undefined;
  }

  if(is_true(var_fec7078b)) {
    self helicopter::function_e1058a3e();
  }

  self deletedelay();
}

function function_e5ece755() {
  self endon(#"death", #"hash_5ad36894fc83f27f");
  wait 5;
  self util::show_hint_text(#"hash_6807d115b178021b", 0, "heli_killstreak_grenade_out", 20);
}

function function_5f5aa1e3(chopper) {
  self endon(#"death", #"hash_5ad36894fc83f27f");

  iprintlnbold("<dev string:x66>");

  chopper flag::set("on_attack_run");
  chopper.scripted_targets = [];
  chopper.targets = [];

  if(isDefined(level.var_63a234) && level.var_63a234.size > 0) {
    arrayremovevalue(level.var_63a234, undefined);
  }

  if(isDefined(level.var_63a234) && level.var_63a234.size > 0) {
    foreach(target in level.var_63a234) {
      if(isDefined(target.ent.origin) && isDefined(target.ent) && isDefined(target) && isDefined(chopper.var_94e122a8) && isDefined(target.var_146dd712)) {
        dist = distance(chopper.var_94e122a8, target.ent.origin);

        if(dist <= target.var_146dd712 && !target.is_destroyed) {
          chopper flag::set("has_scripted_target");

          iprintlnbold("<dev string:x88>");

          if(!isDefined(chopper.scripted_targets)) {
            chopper.scripted_targets = [];
          } else if(!isarray(chopper.scripted_targets)) {
            chopper.scripted_targets = array(chopper.scripted_targets);
          }

          chopper.scripted_targets[chopper.scripted_targets.size] = target.ent;
        }
      }
    }
  }

  if(chopper.scripted_targets.size <= 0 && chopper flag::get("has_scripted_target")) {
    chopper flag::clear("has_scripted_target");
  }

  riders = chopper vehicle::function_86c7bebb();

  foreach(rider in riders) {
    rider val::set("heli_killstreak_attack_run", "ignoreme", 1);
  }

  chopper notify(#"flying");
  chopper function_c4b00a04();
  chopper notify(#"hash_3700e857135dadfa");
  self function_def737fb();
  waitframe(1);
  function_44cf45ff(chopper);

  iprintlnbold("<dev string:xaa>");
}

function function_44cf45ff(chopper) {
  chopper.perfectaim = 0;
  chopper.script_accuracy = 1;
  chopper.scripted_targets = [];
  riders = chopper vehicle::function_86c7bebb();

  foreach(rider in riders) {
    rider val::set("heli_killstreak_attack_run", "ignoreme", 0);
  }

  chopper flag::clear("on_attack_run");
  chopper flag::clear("has_scripted_target");
}

function function_8b1917b3(params) {
  function_41d2eebc(params, level.var_fb14fd3b);
}

function function_41d2eebc(params, chopper) {
  self endon(#"death", #"hash_5ad36894fc83f27f");

  if(!function_8f2cab5d(params, chopper)) {
    return;
  }

  self notify(#"heli_killstreak_grenade_out");
  grenade = params.projectile;
  waitresult = grenade waittill(#"explode", #"death");

  if(waitresult._notify === # "explode") {
    chopper.var_94e122a8 = grenade.origin;
    chopper.var_1768de8f = util::spawn_model("tag_origin", chopper.var_94e122a8, (0, 0, 0));
    chopper.var_5b7a23a6 = getclosestpointonnavmesh(grenade.origin, 1000);
    function_5f5aa1e3(chopper);
    chopper thread function_79c4d29d();
  }
}

function private function_8f2cab5d(params, chopper) {
  if(!(isDefined(params.weapon.name) && isDefined(params.weapon) && isDefined(params) && isDefined(params.projectile))) {
    return false;
  }

  if(params.weapon.name != "willy_pete_armada") {
    return false;
  }

  if(chopper flag::get("on_attack_run")) {
    return false;
  }

  return true;
}

function function_def737fb() {
  weapon = getweapon("willy_pete_armada");

  if(!self hasweapon(weapon)) {
    self giveweapon(weapon);
  } else {
    self setweaponammostock(weapon, 1);
  }

  self setactionslot(4, "weapon", weapon);
}

function function_28edaba7() {
  weapon = getweapon("willy_pete_armada");

  if(self hasweapon(weapon)) {
    self takeweapon(weapon);
  }

  self callback::remove_on_grenade_fired(&function_8b1917b3);
  self notify(#"hash_5ad36894fc83f27f");

  if(isDefined(level.var_fb14fd3b)) {
    level.var_fb14fd3b turret::_get_turret_data(1).is_enabled = 0;
    level.var_fb14fd3b turret::_get_turret_data(2).is_enabled = 0;
    level.var_fb14fd3b turret::stop(1, 1);
    level.var_fb14fd3b turret::stop(2, 1);
    function_44cf45ff(level.var_fb14fd3b);
  }

  setDvar(#"scr_stop_postfx_bundle", "pstfx_dust_concrete");
  self stopgestureviewmodel();
  self setmovespeedscale(1);
}

function function_80b42ad9(chopper) {
  self endon(#"death", #"hash_5ad36894fc83f27f");
  chopper endon(#"death", #"hash_3700e857135dadfa");
  self notify("699897a1e8f4f4c6");
  self endon("699897a1e8f4f4c6");
  dist_check = 600;
  var_c49fe85b = 0;
  var_c09dcd14 = 0;

  while(true) {
    if(!isDefined(chopper)) {
      waitframe(1);
      continue;
    }

    dist = distance(self.origin, chopper.origin);

    if(dist < dist_check) {
      var_c49fe85b = 1;
    } else {
      var_c49fe85b = 0;
    }

    if(var_c49fe85b) {
      var_c09dcd14 = 1;
      setDvar(#"scr_play_postfx_bundle", "pstfx_dust_concrete");
      screenshake(chopper.origin, 0.3, 0.2, 0.1, 1, 0, 0.3, dist_check + 100, 10, 7);
    } else if(var_c09dcd14) {
      var_c09dcd14 = 0;
      setDvar(#"scr_stop_postfx_bundle", "pstfx_dust_concrete");
    }

    wait 0.05;
  }
}

function function_1da8ff40(ent, var_146dd712) {
  if(!isDefined(level.var_63a234)) {
    level.var_63a234 = [];
  }

  arrayremovevalue(level.var_63a234, undefined);

  if(!isDefined(level.var_63a234)) {
    level.var_63a234 = [];
  } else if(!isarray(level.var_63a234)) {
    level.var_63a234 = array(level.var_63a234);
  }

  level.var_63a234[level.var_63a234.size] = var_146dd712;
}

function function_e19bff4c(ent) {
  foreach(i in level.var_63a234) {
    if(i.ent === ent) {
      i.is_destroyed = 1;
    }
  }

  if(isDefined(level.var_fb14fd3b) && isDefined(level.var_fb14fd3b.scripted_targets) && array::contains(level.var_fb14fd3b.scripted_targets, ent)) {
    arrayremovevalue(level.var_fb14fd3b.scripted_targets, ent);
  }
}

function function_6fa79c8c() {}

function function_e1c90bb4() {
  self cleartargetyaw();
  self cleargoalyaw();
  self setyawspeed(120, 60, 60);
  self setmaxpitchroll(30, 60);
  self.var_cb55c804 = 256;
  self setneargoalnotifydist(self.var_cb55c804);
}

function function_7c23816d(goalpos, stop, usepath = 1, setgoal = 0) {
  if(!isDefined(self) || !isDefined(goalpos)) {
    return;
  }

  goal = goalpos;

  if(!isvec(goalpos)) {
    goal = goalpos.origin;
  }

  self.heligoalpos = goal;

  if(level.var_6158b82e) {
    line(self.origin, goal, (0, 1, 0), 1, 0, 1000);
    sphere(goalpos, self.var_cb55c804, (0, 1, 0), 0.5, 0, 10, 1000);
  }

  self function_a57c34b7(goal, stop, usepath);

  if(setgoal) {
    self setgoal(goal, stop);
  }
}

function function_1f538466(val1, val2) {
  return val1.threatlevel > val2.threatlevel;
}

function function_d49ffab6() {
  self notify("792372433b9dd6c6");
  self endon("792372433b9dd6c6");
  level.players[0] endon(#"death");
  self endon(#"hash_3700e857135dadfa", #"death");

  for(;;) {
    n_fire_min = 0.5;
    n_fire_max = 2;
    n_wait_min = 0.2;
    n_wait_max = 0.8;
    self waittilltimeout(3, #"gunner_turret_on_target");
    self vehicle_ai::fire_for_time(randomfloatrange(n_fire_min, n_fire_max), self.var_c2634283, self.target);
    wait randomfloatrange(n_wait_min, n_wait_max);
  }
}

function heli_targeting() {
  self notify("7e21303a96d1d277");
  self endon("7e21303a96d1d277");
  self endon(#"death", #"hash_3700e857135dadfa");
  self.owner endon(#"death", #"hash_5ad36894fc83f27f");
  var_d80214ef = util::get_enemy_team(self.team);
  self.var_b420e989 = undefined;
  self thread function_d49ffab6();

  for(;;) {
    self.targets = [];
    enemies = getaiteamarray(var_d80214ef);

    if(isDefined(self.var_c2634283)) {
      self.var_b420e989 = isDefined(self turret::get_target(self.var_c2634283)) ? self turret::get_target(self.var_c2634283) : self.var_b420e989;
    }

    for(i = 0; i < enemies.size; i++) {
      guy = enemies[i];

      if(self isvalidtarget(guy)) {
        self.targets[self.targets.size] = guy;
        guy.threatlevel = 0;
      }
    }

    if(isDefined(level.var_63a234)) {
      for(i = 0; i < level.var_63a234.size; i++) {
        thing = level.var_63a234[i];

        if(self isvalidtarget(thing)) {
          self.targets[self.targets.size] = thing;
          thing.threatlevel = 0;
        }
      }
    }

    if(self.targets.size == 0) {
      self.var_dc70d94d++;

      if(isDefined(self.loopcount) && self.loopcount >= 1 && self.var_dc70d94d >= 5) {
        self notify(#"hash_3700e857135dadfa");
      }
    } else {
      self.var_dc70d94d = 0;
    }

    for(idx = 0; idx < self.targets.size; idx++) {
      if(self function_e943de0c(self.targets[idx])) {
        function_c7e60da8(self.targets[idx], self.var_b420e989);
      }
    }

    var_95525e25 = function_1c4791e0(self.targets);

    if(isDefined(var_95525e25)) {
      if(level.var_6158b82e) {
        thread function_a9c8d69a("<dev string:xcc>", (1, 0.6, 0.6), var_95525e25, (0, 0, 0), 100, 1, 1);
        line(self.origin, var_95525e25.origin, (1, 0.6, 0.6), 1, 0, 100);
      }

      self turret::set_target(var_95525e25, undefined, self.var_c2634283);
    } else {
      self turret::set_target(self.var_1768de8f, undefined, self.var_c2634283);
    }

    wait self.targeting_delay;

    function_1c2c90c7();
  }
}

function function_1c4791e0(targets) {
  highest = 0;
  var_95525e25 = undefined;

  for(idx = 0; idx < targets.size; idx++) {
    assert(isDefined(targets[idx].threatlevel), "<dev string:xd6>");

    if(targets[idx].threatlevel >= highest) {
      highest = targets[idx].threatlevel;
      var_95525e25 = targets[idx];
    }
  }

  return var_95525e25;
}

function function_c7e60da8(target, var_b420e989) {
  heli = self;
  var_9c3abcf7 = 500;
  var_102770fe = 100;
  var_7568c029 = 200;

  if(isDefined(var_b420e989)) {
    var_2dafff1b = distance(target.origin, var_b420e989.origin);
    target.threatlevel += (level.heli_visual_range - var_2dafff1b) / level.heli_visual_range * var_9c3abcf7;
  }

  if(heli.owner === level.players[0]) {
    var_d8441ed6 = distance(target.origin, level.players[0].origin);
    target.threatlevel += (level.heli_visual_range - var_d8441ed6) / level.heli_visual_range * var_102770fe;
  }

  if(isDefined(heli.var_94e122a8)) {
    var_a8b2c70d = distance(target.origin, heli.var_94e122a8);
    target.threatlevel += (level.heli_visual_range - var_a8b2c70d) / level.heli_visual_range * var_7568c029;
  }

  if(isDefined(target.antithreat)) {
    target.threatlevel -= target.antithreat;
  }

  if(isDefined(target.var_128610e4)) {
    target.threatlevel = target.var_128610e4;
  }

  if(target.vehicleclass === "artillery") {
    target.threatlevel = 1000000;
  }

  if(target.threatlevel <= 0) {
    target.threatlevel = 1;
  }
}

function isvalidtarget(guy) {
  if(!isalive(guy)) {
    return false;
  }

  if(isvehicle(guy) && !(guy.vehicleclass === "artillery")) {
    return false;
  }

  if(distance(guy.origin, self.origin) > level.heli_visual_range) {
    return false;
  }

  if(distance(guy.origin, self.var_94e122a8) > 400) {
    return false;
  }

  return true;
}

function function_e943de0c(guy) {
  heli_centroid = self.origin + (0, 0, -64);
  var_40784873 = 1;
  var_545a1f9b = 1;
  var_7271b9b5 = 85;
  var_bc97b716 = anglestoright(self.angles);
  var_b57b3df7 = var_bc97b716 * -1;
  var_a23d8dc9 = heli_centroid + var_7271b9b5 * var_bc97b716;
  var_11b66a65 = heli_centroid + var_7271b9b5 * var_b57b3df7;

  if(level.var_71caccee === 1) {
    frames = int(self.targeting_delay * 20) + 1;
    self thread function_79dbd1f7(heli_centroid, var_b57b3df7, var_7271b9b5, frames);
    self thread function_79dbd1f7(heli_centroid, var_bc97b716, var_7271b9b5, frames, (0, 0, 1));
    sphere(var_11b66a65, 10, (0, 1, 0), 1, 0, 10, frames);
    sphere(var_a23d8dc9, 10, (0, 1, 0), 1, 0, 10, frames);
  }

  var_afd9b820 = guy sightconetrace(var_a23d8dc9, self, var_bc97b716, var_7271b9b5);

  if(var_afd9b820 < level.heli_target_recognition) {
    var_545a1f9b = 0;
  }

  var_8d6a2030 = guy sightconetrace(var_11b66a65, self, var_b57b3df7, var_7271b9b5);

  if(var_8d6a2030 < level.heli_target_recognition) {
    var_40784873 = 0;
  }

  if(self.var_c2634283 === 1) {
    return var_40784873;
  }

  return var_545a1f9b;
}

function function_aba085be(val1, val2) {
  return abs(length(val1.origin - level.players[0].origin)) < abs(length(val2.origin - level.players[0].origin));
}

function function_5dcf6173() {
  var_130e29a7 = level.var_130e29a7;
  var_130e29a7 = array::remove_keys(var_130e29a7);
  sorted = array::merge_sort(var_130e29a7, &function_aba085be);
  return int(sorted[0].script_noteworthy);
}

function function_f674a4dd(val1, val2) {
  var_345c80c2 = 500;
  return abs(length(val1.origin - self.origin) - var_345c80c2) < abs(length(val2.origin - self.origin) - var_345c80c2);
}

function function_79c4d29d() {
  self notify("1604b66161951077");
  self endon("1604b66161951077");
  self endon(#"death");
  self notify(#"flying");
  self endon(#"flying");
  self.owner endon(#"death", #"hash_5ad36894fc83f27f");
  function_e1c90bb4();
  self.goalradius = 30;
  self.var_cb55c804 = 512;
  self setneargoalnotifydist(self.var_cb55c804);
  pos = self.origin;

  for(currentnode = undefined; true; currentnode = nextnode) {
    var_b202465d = self function_5dcf6173();
    loop = level.var_462eb982[var_b202465d].var_5943fcff;

    if(isDefined(currentnode) && var_b202465d == int(currentnode.script_noteworthy)) {
      nextnodes = util::get_array(currentnode.target, "targetname");
      assert(isDefined(nextnodes), "<dev string:xfb>");
      nextnode = nextnodes[0];

      if(vectordot(nextnode.origin - self.origin, self getvelocity()) < 0) {
        var_904ef016 = array::find(loop, currentnode);
        nextnodeidx = var_904ef016 < 0 ? loop.size - 1 : var_904ef016 - 1;
        nextnode = loop[nextnodeidx];
      }
    } else {
      validnodes = [];

      for(i = 0; i < loop.size; i++) {
        if(vectordot(loop[i].origin - self.origin, self getvelocity()) > 0) {
          array::add(validnodes, loop[i]);
        }
      }

      if(validnodes.size == 0) {
        validnodes = loop;
      }

      validnodes = array::merge_sort(validnodes, &function_f674a4dd);
      nextnode = validnodes[0];
      iprintlnbold("switching to loop" + nextnode.script_noteworthy);
    }

    pos = nextnode.origin;
    heli_speed = 40;
    heli_accel = 20;

    if(isDefined(self.pathspeedscale)) {
      heli_speed *= self.pathspeedscale;
      heli_accel *= self.pathspeedscale;
    }

    self setspeed(heli_speed, heli_accel);
    self function_7c23816d(pos, 0);
    self waittill(#"near_goal");
    self notify(#"path start");
  }
}

function function_f8db61f8(val1, val2, var_99ec1a2c) {
  var_345c80c2 = 500;
  return abs(length(var_99ec1a2c[val1] - self.origin) - var_345c80c2) < abs(length(var_99ec1a2c[val2] - self.origin) - var_345c80c2);
}

function function_c4b00a04(startnode) {
  self endon(#"death", #"hash_3700e857135dadfa");
  self.owner endon(#"death", #"hash_5ad36894fc83f27f");
  function_e1c90bb4();
  self.goalradius = 30;
  self.var_cb55c804 = 512;
  self setneargoalnotifydist(self.var_cb55c804);
  protectdest = self.var_94e122a8;
  self.loopcount = 0;
  self.var_dc70d94d = 0;
  self thread helicopter::function_81cba63();
  var_b09000c1 = vectornormalize(self.var_94e122a8 - level.players[0].origin) * 1200;
  var_f8927edb = vectornormalize(level.players[0].origin - self.origin);
  var_6da223e6 = vectornormalize(self.var_94e122a8 - self.origin);
  var_99ec1a2c = [];
  var_99ec1a2c[0] = self.var_94e122a8 + (var_b09000c1[0], var_b09000c1[1], self.origin[2]);
  var_99ec1a2c[1] = self.var_94e122a8 + (var_b09000c1[1], var_b09000c1[0] * -1, self.origin[2]);
  var_99ec1a2c[2] = self.var_94e122a8 + (var_b09000c1[0] * -1, var_b09000c1[1] * -1, self.origin[2]);
  var_99ec1a2c[3] = self.var_94e122a8 + (var_b09000c1[1] * -1, var_b09000c1[0], self.origin[2]);
  var_60a69279 = [];

  for(i = 0; i < var_99ec1a2c.size; i++) {
    if(vectordot(var_99ec1a2c[i] - self.origin, self getvelocity()) > 0) {
      array::add(var_60a69279, i);
    }
  }

  if(var_60a69279.size == 0) {
    var_60a69279 = [0, 1, 2, 3];
  }

  var_60a69279 = array::merge_sort(var_60a69279, &function_f8db61f8, var_99ec1a2c);
  idx = var_60a69279[0];
  var_ef413b39 = 1;
  self.var_c2634283 = 2;
  var_99ec1a2c[idx] = (var_99ec1a2c[idx][0], var_99ec1a2c[idx][1], self.var_94e122a8[2] + 1200);
  var_99ec1a2c[idx] = getclosestpointonnavvolume(var_99ec1a2c[idx], "navvolume_big", 10000);
  self function_7c23816d(var_99ec1a2c[idx], 0);
  self waittill(#"near_goal");

  if(vectordot((isDefined(var_99ec1a2c[idx + 1]) ? var_99ec1a2c[idx + 1] : var_99ec1a2c[0]) - self.origin, self getvelocity()) < 0) {
    var_ef413b39 = -1;
    self.var_c2634283 = 1;
  }

  idx += var_ef413b39;
  self thread function_8d430af1();

  for(;;) {
    if(idx == var_99ec1a2c.size) {
      idx = 0;
    } else if(idx == -1) {
      idx = var_99ec1a2c.size - 1;
    }

    if(idx == var_60a69279[0]) {
      self.loopcount++;

      if(self.loopcount == 3) {
        break;
      }
    }

    if(idx == var_60a69279[0] - var_ef413b39) {
      var_99ec1a2c[idx] = (var_99ec1a2c[idx][0], var_99ec1a2c[idx][1], self.var_94e122a8[2] + 1200);
    } else {
      var_99ec1a2c[idx] = (var_99ec1a2c[idx][0], var_99ec1a2c[idx][1], self.var_94e122a8[2] + 1000);
    }

    var_99ec1a2c[idx] = getclosestpointonnavvolume(var_99ec1a2c[idx], "navvolume_big", 10000);

    if(level.var_6158b82e) {
      util::debug_sphere(var_99ec1a2c[idx], 100, (1, 1, 1), 1, 500);
    }

    self function_7c23816d(var_99ec1a2c[idx], 0);
    self waittill(#"near_goal");
    idx += var_ef413b39;
  }
}

function function_fef96e3d() {}

function private function_8d430af1() {
  self notify("468c7069bab83a8d");
  self endon("468c7069bab83a8d");
  self endon(#"death", #"hash_3700e857135dadfa");
  self.owner endon(#"death", #"hash_5ad36894fc83f27f");
  self thread heli_targeting();
  self.perfectaim = 0;
  self.script_accuracy = 1;
  self.sightlatency = 0;
  self.fovcosine = 0;
  self.fovcosinebusy = 0;
  self turret::_init_turret(1);
  self turret::_init_turret(2);
  self turret::_set_turret_needs_user(1, 0);
  self turret::_set_turret_needs_user(2, 0);
  self turret::set_torso_targetting(1, -12);
  self turret::set_torso_targetting(2, -12);
  self turret::set_target_leading(1, 0.1);
  self turret::set_target_leading(2, 0.1);
  self turret::set_on_target_angle(10, 1);
  self turret::set_on_target_angle(10, 2);

  self thread function_c6423bad();
}

function function_3b979ded() {}

function private function_24111b5e() {
  while(!canadddebugcommand()) {
    waitframe(1);
  }

  level.var_6158b82e = 0;
  level.var_804dc5e = 0;
  level.var_71caccee = 0;
  mapname = util::get_map_name();
  adddebugcommand("<dev string:x128>" + mapname + "<dev string:x139>");
  adddebugcommand("<dev string:x128>" + mapname + "<dev string:x188>");
  adddebugcommand("<dev string:x128>" + mapname + "<dev string:x1e1>");
  level thread debug_killstreak();
}

function private debug_killstreak() {
  while(true) {
    if(getdvarint(#"hash_194cd67703e18982", 0) > 0) {
      level.var_6158b82e = !level.var_6158b82e;
      setDvar(#"hash_194cd67703e18982", 0);
    }

    if(getdvarint(#"hash_5c9ff4b526e3df6a", 0) > 0) {
      level.var_804dc5e = !level.var_804dc5e;
      setDvar(#"hash_5c9ff4b526e3df6a", 0);
    }

    if(getdvarint(#"hash_39dae3b6f7742cf1", 0) > 0) {
      level.var_71caccee = !level.var_71caccee;
      setDvar(#"hash_39dae3b6f7742cf1", 0);
    }

    waitframe(1);
  }
}

function private function_1c2c90c7() {
  if(level.var_804dc5e === 1) {
    frames = int(self.targeting_delay * 20) + 1;

    if(isDefined(self.targets)) {
      for(i = 0; i < self.targets.size; i++) {
        if(isDefined(self.targets[i])) {
          thread function_a9c8d69a("<dev string:x246>" + i + self.targets[i].threatlevel, (1, 0.6, 0.6), self.targets[i], (0, 0, -20 + i * 10), frames, 1, 1);
          line(self.origin, self.targets[i].origin, (1, 0.6, 0.6), 1, 0, frames);
        }
      }
    }
  }
}

function private function_79dbd1f7(centroid, norm, var_95e06609, frames, color) {
  if(!isDefined(color)) {
    color = (1, 0, 0);
  }

  if(frames == 0) {
    while(isDefined(self)) {
      dome_apex = centroid + vectorscale(norm, level.heli_visual_range);
      util::debug_spherical_cone(centroid, dome_apex, var_95e06609, 16, color, 0.3, 1, frames);
      waitframe(1);
    }

    return;
  }

  for(i = 0; i < frames; i++) {
    if(!isDefined(self)) {
      break;
    }

    dome_apex = centroid + vectorscale(norm, level.heli_visual_range);
    util::debug_spherical_cone(centroid, dome_apex, var_95e06609, 16, color, 0.3, 1, frames);
    waitframe(1);
  }
}

function private function_c6423bad() {
  self endon(#"death");
  self notify("<dev string:x251>");
  self endon("<dev string:x251>");
  var_121adbaa = self turret::_get_turret_data(1);
  var_1c60f036 = self turret::_get_turret_data(2);

  while(true) {
    if(level.var_804dc5e === 1) {
      if(!isDefined(self)) {
        return;
      }

      if(isDefined(var_121adbaa) && isDefined(var_121adbaa.str_tag_pivot)) {
        var_6ce79b30 = self gettagorigin(var_121adbaa.str_tag_pivot);
      }

      if(isDefined(var_1c60f036) && isDefined(var_1c60f036.str_tag_pivot)) {
        var_545b32e1 = self gettagorigin(var_1c60f036.str_tag_pivot);
      }

      gunner1enemy = self turret::get_target(1);
      gunner2enemy = self turret::get_target(2);

      if(isDefined(var_121adbaa.str_tag_pivot) && isDefined(var_121adbaa) && isDefined(gunner1enemy) && isDefined(self) && isDefined(var_6ce79b30) && isalive(gunner1enemy)) {
        line(var_6ce79b30, gunner1enemy.origin, (1, 0, 0));
      }

      if(isDefined(var_1c60f036.str_tag_pivot) && isDefined(var_1c60f036) && isDefined(gunner2enemy) && isDefined(self) && isDefined(var_545b32e1) && isalive(gunner2enemy)) {
        line(var_545b32e1, gunner2enemy.origin, (1, 0, 0));
      }
    }

    waitframe(1);
  }
}

function private function_a9c8d69a(msg, color, ent, offset, frames, scale, alpha) {
  if(!isDefined(scale)) {
    scale = 3;
  }

  if(!isDefined(alpha)) {
    alpha = 0.5;
  }

  if(frames == 0) {
    while(isDefined(ent) && isDefined(ent.origin)) {
      print3d(ent.origin + offset, msg, color, alpha, scale);
      waitframe(1);
    }

    return;
  }

  for(i = 0; i < frames; i++) {
    if(!isDefined(ent)) {
      break;
    }

    print3d(ent.origin + offset, msg, color, alpha, scale);
    waitframe(1);
  }
}

function function_43719a68(vector) {
  x = vector[0];
  y = vector[1];
  z = vector[2];
  x = string(x);
  y = string(y);
  z = string(z);
  vector_string = x + "<dev string:x264>" + y + "<dev string:x264>" + z;
  return vector_string;
}