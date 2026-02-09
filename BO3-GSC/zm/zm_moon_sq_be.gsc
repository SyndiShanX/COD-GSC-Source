/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_moon_sq_be.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\sound_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_sidequests;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weap_black_hole_bomb;
#using scripts\zm\_zm_weap_microwavegun;
#using scripts\zm\_zm_weap_quantum_bomb;
#using scripts\zm\_zm_weapons;
#using scripts\zm\zm_moon_amb;
#using scripts\zm\zm_moon_sq;
#using_animtree("generic");
#namespace zm_moon_sq_be;

function init() {
  level.motivational_struct = struct::get("struct_motivation", "targetname");
  assert(isDefined(level.motivational_struct.name));
  if(!isDefined(level.motivational_struct)) {
    println("");
    return;
  }
  level._be_start = strtok(level.motivational_struct.script_parameters, ",");
  for(i = 0; i < level._be_start.size; i++) {
    level flag::init(level._be_start[i]);
  }
  level._be_complete = strtok(level.motivational_struct.script_flag, ",");
  for(j = 0; j < level._be_complete.size; j++) {
    if(!level flag::exists(level._be_complete[j])) {
      level flag::init(level._be_complete[j]);
    }
  }
  level.motivational_array = strtok(level.motivational_struct.script_string, ",");
  level._sliding_doors = getEntArray("zombie_door_airlock", "script_noteworthy");
  level._sliding_doors = arraycombine(level._sliding_doors, getEntArray("zombie_door", "targetname"), 0, 0);
  level._my_speed = 12;
  zm_sidequests::declare_sidequest_stage("be", "stage_one", &init_stage_1, &stage_logic_1, &exit_stage_1);
  zm_sidequests::declare_sidequest_stage("be", "stage_two", &init_stage_2, &stage_logic_2, &exit_stage_2);
}

function init_stage_2() {}

function stage_logic_2() {
  org = level._be.origin;
  angles = level._be.angles;
  exploder::exploder("fxexp_405");
  level._be playSound("evt_be_insert");
  level._be stopanimscripted();
  level._be unlink();
  level._be dontinterpolate();
  level._be.origin = org;
  level._be.angles = angles;
  level._be thread wait_for_close_player();
  if(isDefined(level._be_vehicle)) {
    level._be_vehicle delete();
  }
  if(isDefined(level._be_origin_animate)) {
    level._be_origin_animate stopanimscripted();
    level._be_origin_animate delete();
  }
  zm_weap_quantum_bomb::quantum_bomb_register_result("be2", undefined, 100, &be2_validation);
  level._be_pos = level._be.origin;
  level waittill("be2_validation");
  zm_weap_quantum_bomb::quantum_bomb_deregister_result("be2");
  s = struct::get("be2_pos", "targetname");
  level._be dontinterpolate();
  level._be.origin = s.origin;
  level.teleport_target_trigger = spawn("trigger_radius", s.origin + (vectorscale((0, 0, -1), 70)), 0, 125, 100);
  level.black_hole_bomb_loc_check_func = &bhb_teleport_loc_check;
  level waittill("be2_tp_done");
  players = getplayers();
  players[randomintrange(0, players.size)] thread zm_audio::create_and_play_dialog("eggs", "quest8", 2);
  level.black_hole_bomb_loc_check_func = undefined;
  level._be delete();
  level._be = undefined;
  zm_sidequests::stage_completed("be", "stage_two");
}

function wait_for_close_player() {
  level endon("be2_validation");
  self endon("death");
  wait(25);
  while(true) {
    players = getplayers();
    for(i = 0; i < players.size; i++) {
      if(distancesquared(players[i].origin, self.origin) <= 62500) {
        players[i] thread zm_audio::create_and_play_dialog("eggs", "quest8", 0);
        return;
      }
    }
    wait(0.5);
  }
}

function bhb_teleport_loc_check(grenade, model, info) {
  if(isDefined(level.teleport_target_trigger) && grenade istouching(level.teleport_target_trigger)) {
    level._be clientfield::set("toggle_black_hole_deployed", 1);
    level thread teleport_target(grenade, level._be);
    return true;
  }
  return false;
}

function teleport_target(grenade, model) {
  level.teleport_target_trigger delete();
  level.teleport_target_trigger = undefined;
  wait(1);
  time = 3;
  model moveto(grenade.origin + vectorscale((0, 0, 1), 50), time, time - 0.05);
  wait(time);
  teleport_targets = struct::get_array("vista_rocket", "targetname");
  model ghost();
  playsoundatposition("zmb_gersh_teleporter_out", grenade.origin + vectorscale((0, 0, 1), 50));
  wait(0.5);
  model stoploopsound(1);
  wait(0.5);
  for(i = 0; i < teleport_targets.size; i++) {
    playFX(level._effect["black_hole_bomb_event_horizon"], teleport_targets[i].origin + vectorscale((0, 0, 1), 2500));
  }
  model playSound("zmb_gersh_teleporter_go");
  wait(2);
  level notify("be2_tp_done");
}

function be2_validation(position) {
  if(distancesquared(level._be_pos, position) < 26896) {
    level notify("be2_validation");
  }
  return false;
}

function exit_stage_2(success) {
  level flag::set("be2");
}

function init_stage_1() {
  level thread moon_be_start_capture();
}

function stage_logic_1() {
  level flag::wait_till("complete_be_1");
  level._be playSound("evt_be_insert");
  exploder::exploder("fxexp_405");
  level thread play_vox_on_closest_player(6);
  zm_sidequests::stage_completed("be", "stage_one");
}

function exit_stage_1(success) {}

function moon_be_start_capture() {
  level endon("end_game");
  while(!level flag::get(level._be_complete[0])) {
    if(level flag::get("teleporter_breached") && !level flag::get("teleporter_blocked")) {
      level flag::set(level._be_complete[0]);
    }
    wait(0.1);
  }
  level thread moon_be_activate();
}

function moon_be_activate() {
  start = struct::get("struct_be_start", "targetname");
  road_start = getvehiclenode("vs_stage_1a", "targetname");
  level.var_e9ab794e = 0;
  if(!isDefined(road_start)) {
    println("");
    wait(1);
    return;
  }
  level._be = util::spawn_model("p7_zm_moo_egg_black", road_start.origin, road_start.angles);
  level._be notsolid();
  level._be useanimtree($generic);
  level._be.animname = "_be_";
  level._be playLoopSound("evt_sq_blackegg_loop", 1);
  level._be.stopped = 0;
  level._be thread waittill_player_is_close();
  origin_animate = util::spawn_model("tag_origin_animate", level._be.origin);
  level._be linkto(origin_animate, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));
  level._be_vehicle = spawnvehicle("misc_freefall", road_start.origin, road_start.angles, "be_mover");
  level._be_vehicle._be_model = level._be;
  level._be_vehicle._be_org_anim = origin_animate;
  origin_animate linkto(level._be_vehicle);
  level._be_origin_animate = origin_animate;
  level._be_vehicle attachpath(road_start);
  d_trig = spawn("trigger_damage", level._be_vehicle.origin, 0, 32, 72);
  start = 0;
  while(!start) {
    d_trig waittill("damage", amount, attacker, direction, point, dmg_type, modelname, tagname);
    if(isPlayer(attacker) && moon_be_move(road_start.script_string)) {
      if(moon_be_move(dmg_type)) {
        level._be playSound("evt_sq_blackegg_activate");
        attacker thread play_be_hit_vox(1);
        start = 1;
      }
    }
  }
  d_trig delete();
  level._be animscripted("spin", level._be.origin, level._be.angles, "p7_fxanim_zm_sha_crystal_sml_anim");
  level._be_vehicle thread moon_be_think();
  level._be_vehicle startpath();
}

function moon_be_think() {
  self endon("death");
  self endon("finished_path");
  self endon("be_stage_one_over");
  vox_num = 2;
  vox_dude = undefined;
  while(isDefined(self)) {
    self waittill("reached_node", node);
    if(level.var_e9ab794e) {
      nd_end = getvehiclenode(node.target, "targetname");
      node = nd_end;
    }
    if(isDefined(node.script_sound)) {
      level._be playSound(node.script_sound);
    }
    if(isDefined(node.script_flag)) {
      level flag::set(node.script_flag);
    }
    if(isDefined(node.script_string)) {
      self setspeedimmediate(0);
      level._be playSound("evt_sq_blackegg_stop");
      self thread moon_be_stop_anim();
      d_trig = spawn("trigger_damage", self.origin, 0, 32, 72);
      motivation = 0;
      while(!motivation) {
        if(isDefined(node.script_string) && node.script_string == "zap") {
          zm_weap_microwavegun::add_microwaveable_object(d_trig);
          d_trig waittill("microwaved", vox_dude);
          zm_weap_microwavegun::remove_microwaveable_object(d_trig);
          motivation = 1;
        } else {
          d_trig waittill("damage", amount, attacker, direction, point, dmg_type, modelname, tagname);
          if(isPlayer(attacker) && moon_be_move(node.script_string)) {
            motivation = moon_be_move(dmg_type);
            vox_dude = attacker;
          }
        }
        self solid();
        wait(0.05);
      }
      if(isDefined(vox_dude)) {
        vox_dude thread play_be_hit_vox(vox_num);
        vox_num++;
      }
      level._be playSound("evt_sq_blackegg_activate");
      d_trig delete();
      self notsolid();
      self setspeed(level._my_speed);
      self thread moon_be_resume_anim();
    }
    if(isDefined(node.script_waittill) && node.script_waittill == "sliding_door") {
      self setspeedimmediate(0);
      self thread moon_be_stop_anim();
      door_index = get_closest_index_2d(self.origin, level._sliding_doors);
      if(!isDefined(door_index)) {
        println("");
        wait(1);
        continue;
      }
      if(!isDefined(level._sliding_doors[door_index]._door_open)) {
        println("");
        wait(1);
        continue;
      }
      if(!level._sliding_doors[door_index]._door_open) {
        level thread play_vox_on_closest_player(5);
        level._be playSound("evt_sq_blackegg_wait");
        level._be.stopped = 1;
      }
      while(!level._sliding_doors[door_index]._door_open) {
        wait(0.05);
      }
      if(isDefined(level._be.stopped) && level._be.stopped) {
        level._be playSound("evt_sq_blackegg_accel");
        level._be.stopped = 0;
      }
      self setspeed(level._my_speed);
      self thread moon_be_resume_anim();
    }
    if(isDefined(node.script_noteworthy)) {
      switch (node.script_noteworthy) {
        case "flag_wait_for_osc": {
          self setspeedimmediate(0);
          self thread moon_be_stop_anim();
          if(!isDefined(level.flag["flag_wait_for_osc"])) {
            level flag::init("flag_wait_for_osc");
          }
          level flag::wait_till("flag_wait_for_osc");
          self setspeed(level._my_speed);
          self thread moon_be_resume_anim();
          level.var_e9ab794e = 1;
          break;
        }
        case "complete_be_1": {
          self setspeedimmediate(0);
          self thread moon_be_stop_anim();
          level flag::set("complete_be_1");
          self notify("finished_path");
          break;
        }
        default: {
          level.var_e9ab794e = int(node.script_noteworthy);
          break;
        }
      }
    }
    if(isDefined(node.script_parameters)) {
      next_chain_start = getvehiclenode(node.script_parameters, "targetname");
      if(!isDefined(next_chain_start)) {
        println("");
        wait(1);
        continue;
      }
      self setspeedimmediate(0);
      level._be playSound("evt_sq_blackegg_stop");
      self thread moon_be_stop_anim();
      self attachpath(next_chain_start);
      if(isDefined(next_chain_start.script_string)) {
        d_trig = spawn("trigger_damage", self.origin, 0, 32, 72);
        motivation = 0;
        while(!motivation) {
          if(isDefined(next_chain_start.script_string) && next_chain_start.script_string == "zap") {
            zm_weap_microwavegun::add_microwaveable_object(d_trig);
            d_trig waittill("microwaved", vox_dude);
            zm_weap_microwavegun::remove_microwaveable_object(d_trig);
            motivation = 1;
          } else {
            d_trig waittill("damage", amount, attacker, direction, point, dmg_type, modelname, tagname);
            if(isPlayer(attacker) && moon_be_move(next_chain_start.script_string)) {
              motivation = moon_be_move(dmg_type);
              vox_dude = attacker;
            }
          }
          wait(0.05);
        }
        d_trig delete();
      }
      if(isDefined(vox_dude)) {
        vox_dude thread play_be_hit_vox(vox_num);
        vox_num++;
      }
      level._be playSound("evt_sq_blackegg_activate");
      self setspeed(level._my_speed);
      self startpath();
      self thread moon_be_resume_anim();
      level.var_e9ab794e = 0;
    }
    if(isDefined(node.script_int)) {
      self setspeedimmediate(node.script_int);
    }
    if(isDefined(node.script_index)) {
      self thread moon_be_anim_swap(node.script_index);
    }
  }
}

function moon_be_move(motivation_array) {
  if(!isDefined(motivation_array)) {
    return false;
  }
  if(!isstring(motivation_array)) {
    println("");
    return false;
  }
  motivational_array = strtok(motivation_array, ",");
  match = 0;
  for(i = 0; i < motivational_array.size; i++) {
    for(j = 0; j < level.motivational_array.size; j++) {
      if(motivational_array[i] == level.motivational_array[j]) {
        match = 1;
        return true;
      }
    }
  }
  if(!match) {
    println("");
    if(isDefined(motivational_array[0])) {
      println(("" + motivational_array[0]) + "");
    } else {
      println("");
    }
    return false;
  }
}

function get_closest_index_2d(org, array, dist = 9999999) {
  if(array.size < 1) {
    return;
  }
  index = undefined;
  for(i = 0; i < array.size; i++) {
    newdist = distance2d(array[i].origin, org);
    if(newdist >= dist) {
      continue;
    }
    dist = newdist;
    index = i;
  }
  return index;
}

function moon_be_anim_swap(int_anim) {
  self endon("death");
  self._be_model stopanimscripted();
  if(int_anim == 0) {
    self._be_model animscripted("spin", self._be_model.origin, self._be_model.angles, "p7_fxanim_zm_sha_crystal_sml_anim");
  } else {
    self._be_model animscripted("spin", self._be_model.origin, self._be_model.angles, "p7_fxanim_zm_sha_crystal_sml_anim");
  }
}

function moon_be_stop_anim() {
  self endon("death");
  self._be_model stopanimscripted();
}

function moon_be_resume_anim() {
  self endon("death");
  self endon("be_stage_one_over");
  rand = randomint(1);
  if(rand) {
    self._be_model animscripted("spin", self._be_model.origin, self._be_model.angles, "p7_fxanim_zm_sha_crystal_sml_anim");
  } else {
    self._be_model animscripted("spin", self._be_model.origin, self._be_model.angles, "p7_fxanim_zm_sha_crystal_sml_anim");
  }
}

function waittill_player_is_close() {
  while(true) {
    players = getplayers();
    for(i = 0; i < players.size; i++) {
      if(distancesquared(players[i].origin, self.origin) <= 62500) {
        players[i] thread zm_audio::create_and_play_dialog("eggs", "quest2", 0);
        return;
      }
    }
    wait(0.5);
  }
}

function play_be_hit_vox(num) {
  if(num > 4) {
    num = num - 4;
  }
  self thread zm_audio::create_and_play_dialog("eggs", "quest2", num);
}

function play_vox_on_closest_player(num) {
  player = zm_utility::get_closest_player(level._be.origin);
  player thread zm_audio::create_and_play_dialog("eggs", "quest2", num);
}