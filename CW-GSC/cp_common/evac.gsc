/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\evac.gsc
***********************************************/

#using script_3dc93ca9902a9cda;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\objectives;
#using scripts\cp_common\util;
#namespace evac;

function setup() {
  init_flags();
}

function private init_flags() {
  level flag::init("flag_evac_hint_stop");
  level flag::init("flag_evac_defend_start");
  level flag::init("flag_evac_exfil_ready");
  level flag::init("flag_evac_helicopter_load");
  level flag::init("flag_evac_helicopter_board");
}

function main(var_834e775, var_d12d84db, var_eb954041, var_5859bbb4, var_3e8a01bb, var_115eeb93, var_3f0bbf52, var_f771f6f2, var_3618156) {
  if(!isPlayer(self)) {
    assertmsg("<dev string:x38>" + self);
  }

  if(!isDefined(var_834e775)) {
    var_834e775 = self function_b99870d0();
    var_f771f6f2 = 1;
    childthread function_d1e14c76(var_834e775);
  }

  var_edfdb06f = 0;

  if(!isDefined(var_eb954041)) {
    var_eb954041 = var_834e775;
  } else {
    var_edfdb06f = 1;
  }

  if(!isDefined(var_f771f6f2)) {
    var_f771f6f2 = 1;
  }

  level flag::set("flag_evac_defend_start");

  if(!isDefined(level.var_5e56e2a8)) {
    level.var_5e56e2a8 = 1200;
  }

  if(is_true(var_f771f6f2)) {
    self childthread helicopter(var_eb954041, var_edfdb06f, var_d12d84db);
  }

  self childthread function_2795b4f9(var_834e775, var_5859bbb4, var_3e8a01bb);

  if(!isDefined(var_3618156) || !is_true(var_3618156)) {
    self childthread function_c878abd2(var_834e775);
  }

  self childthread function_f3b365e9(var_834e775, var_3f0bbf52);
  self function_604a7e5d(var_115eeb93);
}

function private function_b99870d0() {
  self notifyonplayercommand("evac_signal", "+actionslot 2");
  var_b6f06448 = 0;
  trace = [];

  iprintlnbold("<dev string:x6a>");

  while(!var_b6f06448) {
    self waittill(#"evac_signal");
    trace = beamtrace(self.origin + (0, 0, 128), self.origin + (0, 0, 512), 1, self);

    if(trace[#"surfacetype"] == "none") {
      iprintlnbold("<dev string:x81>");

      var_834e775 = self.origin;
      var_b6f06448 = 1;
      level flag::set("flag_evac_hint_stop");
      self notify(#"flag_evac_hint_stop");
    } else {
      iprintlnbold("<dev string:x9c>");

      level notify(#"hash_367dfd7dedd4ef13");
    }

    waitframe(1);
  }

  return var_834e775;
}

function function_d1e14c76(var_1b6599c9) {
  var_c39b3c14 = function_787dbb94(var_1b6599c9, (-90, 0, 0), undefined, "tag_origin");
  snd::play("wpn_smoke_grenade_explode", var_c39b3c14);
  snd::play(["wpn_smoke_hiss_start", 0.2], var_c39b3c14);
  var_61c561f8 = snd::play(["wpn_smoke_hiss_lp", 0.2], var_c39b3c14);
  snd::function_f4f3a2a(var_61c561f8, var_c39b3c14, 1);
  playFXOnTag("smoke/fx9_smk_grenade_green_windy", var_c39b3c14, "tag_origin");
  level thread function_a64f1050(var_c39b3c14);
  level flag::set("flag_evac_location_set");
}

function private function_a64f1050(var_c39b3c14) {
  level flag::wait_till("flag_evac_stop_smoke");
  snd::play("wpn_smoke_hiss_end", var_c39b3c14);
  var_c39b3c14 delete();
}

function private helicopter(var_eb954041, var_edfdb06f, var_d12d84db) {
  if(isDefined(var_d12d84db)) {
    flag::wait_till(var_d12d84db);
  }

  level flag::wait_till("flag_evac_location_set");

  if(isDefined(level.var_a16d9e19)) {
    var_eb954041 = level.var_a16d9e19;
  }

  if(isDefined(level.var_59f4fec6) && isDefined(level.var_f7ac00e1)) {
    var_7933bf99 = (level.var_59f4fec6 - gettime()) / 1000;
    ips = 528;
    var_4e6f66f4 = var_7933bf99 * ips;
    var_4a70cbd6 = getEntArray("vehicle_evac_heli", "targetname")[0];
    dir = vectornormalize((var_4a70cbd6.origin[0] - var_eb954041[0], var_4a70cbd6.origin[1] - var_eb954041[1], 0));
    start_loc = var_4a70cbd6.origin + dir * var_4e6f66f4;
    var_45832177 = vectortoangles(dir * -1);
    level.var_7d23cf81 = util::spawn_model(var_4a70cbd6.model, start_loc, var_45832177);
    var_4a70cbd6.angles = var_45832177;
    level notify(#"hash_56c65465d6639b92");
    level.var_7d23cf81 moveto(var_4a70cbd6.origin, var_7933bf99, 0, 0);
    objectives::follow("evac_heli", level.var_7d23cf81, undefined, undefined, undefined, #"hash_3451f8476f4b14bf");
    objectives::function_67f87f80("evac_heli", [level.var_7d23cf81], level.var_f7ac00e1);
  }

  level flag::wait_till("flag_evac_exfil_ready");

  if(isDefined(level.var_a16d9e19)) {
    var_eb954041 = level.var_a16d9e19;
  }

  var_52d7f450 = vehicle::simple_spawn("vehicle_evac_heli");
  var_b4a49886 = var_52d7f450[0];
  var_b4a49886.spawn_point = var_b4a49886.origin;
  var_b4a49886 setrotorspeed(1);
  var_b4a49886 vehicle::god_on();
  var_b4a49886 vehicle::toggle_tread_fx(1);
  var_b4a49886 vehicle::toggle_exhaust_fx(1);
  level.vehicle_evac_heli = var_b4a49886;
  var_b4a49886 setspeedimmediate(30, 25, 25);
  var_b4a49886 val::set(#"evac", "takedamage", 0);
  var_b4a49886 val::set(#"evac", "ignoreme", 1);
  var_b4a49886 val::set(#"evac", "ignoreall", 1);
  var_b4a49886 thread function_a4772898();
  level notify(#"hash_2f4020343cecc6f0");
  var_b4a49886 endon(#"death");

  if(isDefined(level.var_7d23cf81)) {
    level.var_7d23cf81 linkto(var_b4a49886, "tag_origin", (0, 0, 0), (0, 0, 0));
    level.var_7d23cf81 setModel("tag_origin");
  } else if(isDefined(level.var_f7ac00e1)) {
    objectives::follow("evac_heli", level.vehicle_evac_heli, undefined, undefined, undefined, #"hash_3451f8476f4b14bf");
    objectives::function_67f87f80("evac_heli", [level.vehicle_evac_heli], level.var_f7ac00e1);
  }

  var_5358032b = struct::get_array("struct_heli_lz", "targetname");

  if(var_5358032b.size) {
    var_8ef93e88 = array::get_all_closest(var_eb954041, var_5358032b);
    lz = var_8ef93e88[0];
  }

  if(is_true(var_edfdb06f)) {
    var_b4a49886 vehicle::set_goal_pos(lz.origin, 1);
    var_b4a49886 setgoalyaw(lz.angles[1]);
    var_b4a49886 waittill(#"goal");
  } else {
    var_b4a49886 vehicle::set_goal_pos(lz.origin + (0, 0, 1024), 1);
    var_b4a49886 setgoalyaw(lz.angles[1]);
    wait 5;
    var_b4a49886 waittill(#"goal");
  }

  level flag::wait_till("flag_evac_exfil_ready");

  if(!isalive(var_b4a49886)) {
    return;
  }

  if(isDefined(lz.script_parameters)) {
    switch (lz.script_parameters) {
      case # "hover":
        self function_b064c2b3(0, var_b4a49886);
        break;
      case # "land":
      default:
        self function_f724246e(var_b4a49886, lz);
        break;
    }

    return;
  }

  self function_f724246e(var_b4a49886, lz);
}

function function_a4772898() {
  wait 1;

  if(isDefined(self.var_761c973.riders)) {
    foreach(rider in self.var_761c973.riders) {
      rider val::set(#"evac_pilot", "takedamage", 0);
    }
  }
}

function function_ec8bba3b(kill_flag) {
  level.vehicle_evac_heli endon(#"death");
  level flag::wait_till(kill_flag);
  level.vehicle_evac_heli vehicle::god_off();
  level.vehicle_evac_heli kill();
}

function private function_f724246e(var_b4a49886, lz) {
  var_b4a49886 vehicle::set_goal_pos(lz.origin + (0, 0, 1024), 1);
  var_b4a49886 waittill(#"goal");
  var_b4a49886 setgoalyaw(lz.angles[1]);
  var_b4a49886 function_f4db9f04();
  self function_b064c2b3(1, var_b4a49886);
  var_b4a49886 setspeed(11);
  level.player util::delay(0.1, undefined, &playrumbleonentity, #"hash_5f4c8cad06be5f5d");
  var_b4a49886 vehicle::liftoff(550);
  var_b4a49886 setspeed(35);
  var_b4a49886 vehicle::set_goal_pos(var_b4a49886.origin + (0, 0, 3096) + anglesToForward(var_b4a49886.angles) * 4096, 1);
}

function private function_f4db9f04() {
  ground_pos = groundtrace(self.origin + (0, 0, 8), self.origin + (0, 0, -100000), 0, self)[#"position"] + (0, 0, 24);
  var_c7f41a78 = self.origin;
  level flag::set("flag_evac_stop_smoke");
  self setneargoalnotifydist(5);
  self sethoverparams(0, 0, 10);
  self setspeed(15, 3, 10);
  self cleargoalyaw();
  self settargetyaw((0, self.angles[1], 0)[1]);
  self thread function_76525803(ground_pos, [level.player], 500);

  while(!level flag::get("evac_chopper_landed")) {
    if(level flag::get("landing_obstructed")) {
      self notify(#"hash_649de7ef40beeba1");
      self vehicle::set_goal_pos(var_c7f41a78, 1);

      if(isDefined(level.var_5bb760e8)) {
        level.player thread util::show_hint_text(#"hash_375f464aa679494f", 1, "stop_landing_clear_hint", 99);
      }

      level flag::wait_till_clear("landing_obstructed");
      level.player notify(#"stop_landing_clear_hint");
    }

    self vehicle::set_goal_pos(ground_pos + (0, 0, 110), 1);
    thread function_9e39f358();
    level flag::wait_till_any(["evac_chopper_landed", "landing_obstructed"]);
  }

  self sethoverparams(6, 10, 10);
}

function function_76525803(var_ad1ba59d, var_9b1de80a, var_8db0ea88) {
  level endon(#"evac_chopper_landed");
  var_568798 = var_8db0ea88 * var_8db0ea88;
  var_1cea5425 = 25;
  var_b90d30a9 = 1;
  badplace_cylinder("evac_badplace", -1, var_ad1ba59d + (0, 0, -32), var_8db0ea88 + var_1cea5425, 128, #"any");

  while(true) {
    set = 0;
    var_b90d30a9 = -1;

    if(level flag::get("landing_obstructed")) {
      var_568798 = var_8db0ea88 + var_1cea5425;
    } else {
      var_568798 = var_8db0ea88 - var_1cea5425;
    }

    var_568798 *= var_568798;

    foreach(ob in var_9b1de80a) {
      if(distancesquared(var_ad1ba59d, ob.origin) < var_568798) {
        set = 1;
        break;
      }
    }

    if(set) {
      level flag::set("landing_obstructed");
    } else {
      level flag::clear("landing_obstructed");
    }

    if(!set && self.origin[2] - var_ad1ba59d[2] < 300) {
      break;
    }

    waitframe(1);
  }
}

function function_9e39f358() {
  self endon(#"hash_649de7ef40beeba1");
  self waittill(#"goal");
  level flag::set("evac_chopper_landed");
  badplace_delete("evac_badplace");
}

function private function_b064c2b3(var_b12eb97e, var_b4a49886) {
  if(is_true(var_b12eb97e)) {
    thread function_172759f0(var_b4a49886, "tag_rider1", (20, -14, 2));
    thread function_172759f0(var_b4a49886, "tag_rider3", (20, 14, 2));
    level waittill(#"evac_helicopter_board_trigger");
  } else {
    level flag::wait_till("flag_evac_helicopter_load");
  }

  var_354d59b2 = var_b4a49886 gettagorigin("tag_rider1");
  var_81a8490e = var_b4a49886 gettagorigin("tag_rider3");
  var_b6da2acf = distance2dsquared(self.origin, var_354d59b2);
  var_331f2810 = distance2dsquared(self.origin, var_81a8490e);
  var_9425642c = "tag_rider1";

  if(var_b6da2acf > var_331f2810) {
    var_9425642c = "tag_rider3";
  }

  var_b4a49886 makevehicleusable();
  var_b4a49886 setseatoccupied(0, 1);
  seat = 2;
  level.player val::set(#"hash_58a42d1b99bdf015", "takedamage", 0);

  if(isDefined(level.var_24f69721)) {
    side = "left";

    if(var_b6da2acf > var_331f2810) {
      side = "right";
    }

    thread function_7f59e31f(var_b4a49886, side);
    wait 0.8;
  } else {
    var_b4a49886 usevehicle(level.player, seat);
    var_b4a49886 makevehicleunusable();
  }

  if(isDefined(level.var_f7ac00e1)) {
    objectives::complete("evac_heli");
  }

  level flag::set("flag_evac_helicopter_board");
}

function function_7f59e31f(var_b4a49886, side) {
  level.player util::delay(0.4, undefined, &playrumbleonentity, #"damage_light");
  var_b4a49886 val::reset(#"evac", "ignoreme");
  var_b4a49886 scene::play(level.var_24f69721, side + "_enter");
  var_b4a49886 thread scene::play(level.var_24f69721, side + "_idle");
}

function function_172759f0(var_b4a49886, str_tag, offset = (0, 0, 0)) {
  e_origin = function_787dbb94(var_b4a49886 gettagorigin(str_tag), var_b4a49886 gettagangles(str_tag), undefined, "tag_origin");
  e_origin util::create_cursor_hint("tag_origin", (0, 0, 0), #"hash_62df17fd9f467834");
  e_origin linkto(var_b4a49886, str_tag, offset, (0, 0, 0));
  e_origin util::waittill_any_ents(e_origin, "trigger", level, "evac_helicopter_board_trigger");
  level notify(#"evac_helicopter_board_trigger");
  e_origin util::remove_cursor_hint();
}

function function_787dbb94(v_location, v_angles, v_offset = (0, 0, 0), str_model) {
  e_origin = spawn("script_model", v_location + v_offset);
  e_origin.origin = v_location + v_offset;
  e_origin.angles = v_angles;
  e_origin setModel(str_model);
  return e_origin;
}

function private function_f3b365e9(var_834e775, var_3f0bbf52) {
  if(isDefined(level.var_e07323b5) && isalive(level.var_e07323b5)) {
    level.var_e07323b5 thread function_4e3254e1(var_834e775, var_3f0bbf52);
    return;
  }

  if(isDefined(level.var_e07323b5) && level.var_e07323b5.size) {
    foreach(asset in level.var_e07323b5) {
      if(isDefined(asset)) {
        asset thread function_4e3254e1(var_834e775, var_3f0bbf52);
      }
    }
  }
}

function private function_4e3254e1(var_834e775, var_3f0bbf52) {
  self endon(#"death");
  self.goalradius = 64;
  self ai::set_behavior_attribute("demeanor", "frantic");

  if(!isDefined(var_3f0bbf52)) {
    var_3f0bbf52 = 512;
  }

  self thread function_5986f4a1(var_834e775, var_3f0bbf52, 64, 64);
}

function private function_c878abd2(var_834e775) {
  if(is_true(level.var_fe86dfc1)) {
    return;
  }

  allies = getaiarray("allies");

  foreach(guy in allies) {
    guy.goalradius = 192;
    guy thread function_5986f4a1(var_834e775, 512, 64, 256);
  }
}

function private function_5986f4a1(var_834e775, var_3f0bbf52, var_71dc0c70, var_1ecc7105) {
  nodes = getnodesinradius(var_834e775, var_3f0bbf52, var_71dc0c70, var_1ecc7105);

  if(nodes.size) {
    self setgoal(array::random(nodes));
    return;
  }

  self setgoal(var_834e775);
}

function function_2795b4f9(var_834e775, var_5859bbb4, var_3e8a01bb) {
  level endon(#"hash_659b6dc260129701");
  level.var_dc8cac2a = [];
  e_vol = getent("volume_evac_loc", "targetname");

  if(isDefined(e_vol)) {
    e_vol.origin = var_834e775;
  }

  level.var_dc8cac2a[level.var_dc8cac2a.size] = getplayers()[0];

  if(isDefined(level.heroes)) {
    foreach(guy in level.heroes) {
      level.var_dc8cac2a[level.var_dc8cac2a.size] = guy;
    }
  }

  spawner::add_spawn_function_group("evac_enemy", "targetname", &function_b5b9e9e8, e_vol);

  if(!isDefined(var_5859bbb4)) {
    var_5859bbb4 = 30;
  }

  if(!isDefined(var_3e8a01bb)) {
    var_3e8a01bb = 5;
  }

  wait var_3e8a01bb;
  a_spawners = [];
  a_spawners = getEntArray("evac_enemy", "targetname");
  self function_524bc520(a_spawners);

  while(!flag::get("flag_evac_exfil_ready")) {
    var_1647b5dc = getaiarray("evac_enemy", "targetname");

    iprintln(var_1647b5dc.size);

    if(var_1647b5dc.size < var_5859bbb4 || level flag::get("evac_start_next_wave")) {
      if(!level flag::get("evac_start_next_wave") && isDefined(level.var_5fc12b72)) {
        iprintln("<dev string:xc3>" + level.var_5fc12b72 + "<dev string:xd6>");

        level waittilltimeout(level.var_5fc12b72, #"evac_start_next_wave");
      }

      level notify(#"hash_c3e7fb6791a728b");
      self function_524bc520(a_spawners);
      level flag::clear("evac_start_next_wave");
    }

    level waittilltimeout(1, #"evac_start_next_wave");
  }
}

function private function_b5b9e9e8(e_vol) {
  if(isDefined(level.var_dc8cac2a)) {
    self setgoal(level.player, 0, level.var_5e56e2a8, 512);
    self.var_c5b45b0 = 1;
    self thread function_10af795e();
    return;
  }

  if(isDefined(e_vol)) {
    self setgoal(e_vol);
    return;
  }

  self setgoal(getplayers()[0], 0, level.var_5e56e2a8, 512);
  self.var_c5b45b0 = 1;
}

function private function_10af795e() {
  self endon(#"death");
  self.old_goalradius = self.goalradius;
  self.var_32cd4e27 = self.goalradius * 0.75;
  self.var_37320b46 = self.var_32cd4e27 / (2 + 1);

  while(self.var_32cd4e27 > 10) {
    self function_ce0da52b();
    wait 15 + randomfloat(15) - 15 / 2;
    self.var_32cd4e27 -= self.var_37320b46;
  }

  self.var_32cd4e27 = 0;
  self function_ce0da52b();
}

function private function_ce0da52b() {
  self.goalradius = max(256, self.old_goalradius);
  self.var_2ef83f64 = self.goalradius / 2;
  self.var_f6a4f05e = self.goalradius / 2;
  self.var_dfbd2a28 = self.goalradius / 2;
  self.old_goalradius = self.var_32cd4e27;
}

function function_31ad18bd() {
  self notify(#"hash_391bfe4a5caec7c7");
  self endon(#"death", #"hash_391bfe4a5caec7c7");

  while(!isDefined(self.var_2ef83f64) || self.var_2ef83f64 > 10) {
    if(isDefined(self.var_2ef83f64)) {
      dist = distance(self.origin, level.player getorigin());
      color = (1, 1, 0);

      if(dist >= self.var_2ef83f64) {
        color = (0, 0, 1);
      } else if(dist < self.var_2ef83f64 - 100) {
        color = (1, 0, 0);
      }

      print3d(self.origin + (0, 0, 86), "<dev string:xe3>" + self.goalradius, (1, 0, 1), 1, 0.3, 1, 1);
      print3d(self.origin + (0, 0, 72), "<dev string:xe3>" + self.var_2ef83f64, color, 1, 0.5, 1, 1);
    }

    waitframe(1);
  }
}

function private function_524bc520(a_spawners) {
  self function_7cb7ee37(self function_767a70b6(), a_spawners);
}

function private function_767a70b6() {
  a_vols = getEntArray("volume_evac_defend", "targetname");
  str_zone_name = undefined;
  var_5749d3e1 = undefined;

  for(i = 0; i < a_vols.size; i++) {
    if(isDefined(a_vols[i].script_noteworthy) && a_vols[i].script_noteworthy == "default_evac_spawns") {
      str_zone_name = a_vols[i].target;
    }

    if(self istouching(a_vols[i])) {
      str_zone_name = a_vols[i].target;
      break;
    }
  }

  iprintln(str_zone_name);

  return str_zone_name;
}

function debug_spawnpoints(locs) {
  foreach(loc in locs) {
    sphere(loc.origin, 12, (0, 0, 1), 1, 0, 10, 19980);
    line(loc.origin, loc.origin + (0, 0, 2048), (0, 0, 1), 1, 0, 19980);
  }
}

function private function_7cb7ee37(str_zone_name, a_spawners, var_ce4e368a = 0) {
  var_e16917a1 = struct::get_array(str_zone_name, "targetname");
  var_e16917a1 = array::randomize(var_e16917a1);
  wave_size = a_spawners.size;

  if(isDefined(level.var_dd0b1f89)) {
    wave_size = level.var_dd0b1f89;
  }

  if(var_ce4e368a) {
    wave_size = max(1, wave_size - getaiarray("evac_enemy", "targetname").size);
  }

  for(i = 0; i < wave_size; i++) {
    if(!isspawner(a_spawners[i % a_spawners.size])) {
      waitframe(1);
      continue;
    }

    counter = i % var_e16917a1.size;

    if(i > counter) {
      wait 0.25;
    }

    enemy = a_spawners[i % a_spawners.size] spawnfromspawner();

    if(isDefined(enemy)) {
      enemy forceteleport(var_e16917a1[counter].origin, var_e16917a1[counter].angles);
    } else {
      i--;
    }

    waitframe(1);
  }
}

function private function_604a7e5d(var_115eeb93 = 60) {
  if(isDefined(level.var_fe030804)) {
    var_115eeb93 = level.var_fe030804;
  }

  level thread function_179db8b3(var_115eeb93);
  level flag::wait_till("flag_evac_location_set");
  level.var_59f4fec6 = gettime() + var_115eeb93 * 1000;
  wait var_115eeb93;
  level flag::set("flag_evac_exfil_ready");
}

function private function_179db8b3(var_115eeb93) {
  if(var_115eeb93 > 30) {
    wait var_115eeb93 - 30;
  }

  if(isDefined(level.var_84790ecd)) {
    level thread dialogue::radio(level.var_84790ecd);
  }

  if(var_115eeb93 > 20) {
    wait 10;
  }

  level notify(#"hash_96dccf37ba89a2");

  if(isDefined(level.var_d2f39d7c)) {
    level thread dialogue::radio(level.var_d2f39d7c);
  }

  if(var_115eeb93 > 10) {
    wait 10;
  }

  if(isDefined(level.var_6ae39cd0)) {
    level thread dialogue::radio(level.var_6ae39cd0);
  }
}