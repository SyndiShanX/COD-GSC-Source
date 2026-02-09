/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_moon_sq_be.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;
#include maps\_zombiemode_sidequests;
#include maps\_vehicle;
#using_animtree("fxanim_props_dlc5");
init() {
  PreCacheModel("p_zom_moon_black_egg");
  PrecacheVehicle("misc_freefall");
  level.scr_anim["_be_"]["to_the_right"][0] = % fxanim_zom_ztem_crystal_small_anim;
  level.scr_anim["_be_"]["to_the_left"][0] = % fxanim_zom_ztem_crystal_small_anim;
  level.motivational_struct = getstruct("struct_motivation", "targetname");
  Assert(isDefined(level.motivational_struct.name));
  if(!isDefined(level.motivational_struct)) {
    PrintLn("$$$$ No structs, reBSP $$$$");
    return;
  }
  level._be_start = StrTok(level.motivational_struct.script_parameters, ",");
  for(i = 0; i < level._be_start.size; i++) {
    flag_init(level._be_start[i]);
  }
  level._be_complete = StrTok(level.motivational_struct.script_flag, ",");
  for(j = 0; j < level._be_complete.size; j++) {
    flag_init(level._be_complete[j]);
  }
  level.motivational_array = StrTok(level.motivational_struct.script_string, ",");
  level._sliding_doors = getEntArray("zombie_door_airlock", "script_noteworthy");
  level._sliding_doors = array_merge(level._sliding_doors, getEntArray("zombie_door", "targetname"));
  level._my_speed = 12;
  declare_sidequest_stage("be", "stage_one", ::init_stage_1, ::stage_logic_1, ::exit_stage_1);
  declare_sidequest_stage("be", "stage_two", ::init_stage_2, ::stage_logic_2, ::exit_stage_2);
}
init_stage_2() {}
stage_logic_2() {
  org = level._be.origin;
  angles = level._be.angles;
  exploder(405);
  level._be playSound("evt_be_insert");
  level._be StopAnimScripted();
  level._be Unlink();
  level._be DontInterpolate();
  level._be.origin = org;
  level._be.angles = angles;
  level._be thread wait_for_close_player();
  if(isDefined(level._be_vehicle)) {
    level._be_vehicle Delete();
  }
  if(isDefined(level._be_origin_animate)) {
    level._be_origin_animate StopAnimScripted();
    level._be_origin_animate Delete();
  }
  maps\_zombiemode_weap_quantum_bomb::quantum_bomb_register_result("be2", undefined, 100, ::be2_validation);
  level._be_pos = level._be.origin;
  level waittill("be2_validation");
  maps\_zombiemode_weap_quantum_bomb::quantum_bomb_deregister_result("be2");
  s = getstruct("be2_pos", "targetname");
  level._be DontInterpolate();
  level._be.origin = s.origin;
  level.teleport_target_trigger = spawn("trigger_radius", s.origin + (0, 0, -70), 0, 125, 100);
  level.black_hole_bomb_loc_check_func = ::bhb_teleport_loc_check;
  level waittill("be2_tp_done");
  players = get_players();
  players[randomintrange(0, players.size)] thread maps\_zombiemode_audio::create_and_play_dialog("eggs", "quest8", undefined, 2);
  level.black_hole_bomb_loc_check_func = undefined;
  level._be Delete();
  level._be = undefined;
  stage_completed("be", "stage_two");
}
wait_for_close_player() {
  level endon("be2_validation");
  self endon("death");
  wait(25);
  while(1) {
    players = get_players();
    for(i = 0; i < players.size; i++) {
      if(distancesquared(players[i].origin, self.origin) <= 250 * 250) {
        players[i] thread maps\_zombiemode_audio::create_and_play_dialog("eggs", "quest8", undefined, 0);
        return;
      }
    }
    wait(.5);
  }
}
bhb_teleport_loc_check(grenade, model, info) {
  if(isDefined(level.teleport_target_trigger) && grenade IsTouching(level.teleport_target_trigger)) {
    level._be SetClientFlag(level._SCRIPTMOVER_CLIENT_FLAG_BLACKHOLE);
    grenade thread maps\_zombiemode_weap_black_hole_bomb::do_black_hole_bomb_sound(level._be, info);
    level thread teleport_target(grenade, level._be);
    return true;
  }
  return false;
}
teleport_target(grenade, model) {
  level.teleport_target_trigger Delete();
  level.teleport_target_trigger = undefined;
  wait(1.0);
  time = 3.0;
  model MoveTo(grenade.origin + (0, 0, 50), time, time - 0.05);
  wait(time);
  teleport_targets = getEntArray("vista_rocket", "targetname");
  model Hide();
  playsoundatposition("zmb_gersh_teleporter_out", grenade.origin + (0, 0, 50));
  wait(0.5);
  model StopLoopSound(1);
  wait(0.5);
  for(i = 0; i < teleport_targets.size; i++) {
    playFX(level._effect["black_hole_bomb_event_horizon"], teleport_targets[i].origin + (0, 0, 2500));
  }
  model playSound("zmb_gersh_teleporter_go");
  wait(2.0);
  level notify("be2_tp_done");
}
be2_validation(position) {
  if(DistanceSquared(level._be_pos, position) < (164 * 164)) {
    level notify("be2_validation");
  }
  return false;
}
exit_stage_2(success) {
  flag_set("be2");
}
init_stage_1() {
  level thread moon_be_start_capture();
}
stage_logic_1() {
  flag_wait("complete_be_1");
  level._be playSound("evt_be_insert");
  exploder(405);
  level thread play_vox_on_closest_player(6);
  stage_completed("be", "stage_one");
}
exit_stage_1(success) {}
moon_be_start_capture() {
  level endon("end_game");
  while(!flag(level._be_complete[0])) {
    if(flag("teleporter_breached") && !flag("teleporter_blocked")) {
      flag_set(level._be_complete[0]);
    }
    wait(.1);
  }
  level thread moon_be_activate();
}
moon_be_activate() {
  start = getstruct("struct_be_start", "targetname");
  road_start = GetVehicleNode("vs_stage_1a", "targetname");
  if(!isDefined(road_start)) {
    PrintLn("$$$$ Missing road_start, rebsp the level $$$$");
    wait(1.0);
    return;
  }
  level._be = spawn("script_model", road_start.origin);
  level._be.angles = road_start.angles;
  level._be setModel("p_zom_moon_black_egg");
  level._be NotSolid();
  level._be UseAnimTree(#animtree);
  level._be.animname = "_be_";
  level._be playLoopSound("evt_sq_blackegg_loop", 1);
  level._be.stopped = false;
  level._be thread waittill_player_is_close();
  origin_animate = spawn("script_model", level._be.origin);
  origin_animate setModel("tag_origin_animate");
  level._be LinkTo(origin_animate, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));
  level._be_vehicle = SpawnVehicle("tag_origin", "be_mover", "misc_freefall", road_start.origin, road_start.angles);
  level._be_vehicle._be_model = level._be;
  level._be_vehicle._be_org_anim = origin_animate;
  origin_animate LinkTo(level._be_vehicle);
  level._be_origin_animate = origin_animate;
  level._be_vehicle maps\_vehicle::getonpath(road_start);
  d_trig = spawn("trigger_damage", level._be_vehicle.origin, 0, 32, 72);
  start = false;
  while(!start) {
    d_trig waittill("damage", amount, attacker, direction, point, dmg_type, modelName, tagName);
    if(isPlayer(attacker) && moon_be_move(road_start.script_string)) {
      if(moon_be_move(dmg_type)) {
        level._be playSound("evt_sq_blackegg_activate");
        attacker thread play_be_hit_vox(1);
        start = true;
      }
    }
  }
  d_trig Delete();
  origin_animate thread maps\_anim::anim_loop_aligned(level._be_vehicle._be_model, "to_the_right", "tag_origin_animate_jnt");
  level._be_vehicle thread moon_be_think();
  level._be_vehicle thread maps\_vehicle::gopath();
}
moon_be_think() {
  self endon("death");
  self endon("finished_path");
  self endon("be_stage_one_over");
  vox_num = 2;
  vox_dude = undefined;
  while(isDefined(self)) {
    self waittill("reached_node", node);
    if(isDefined(node.script_sound)) {
      level._be playSound(node.script_sound);
    }
    if(isDefined(node.script_flag)) {
      flag_set(node.script_flag);
    }
    if(isDefined(node.script_string)) {
      self SetSpeedImmediate(0);
      level._be playSound("evt_sq_blackegg_stop");
      self thread moon_be_stop_anim();
      d_trig = spawn("trigger_damage", self.origin, 0, 32, 72);
      motivation = false;
      while(!motivation) {
        if(isDefined(node.script_string) && node.script_string == "zap") {
          maps\_zombiemode_weap_microwavegun::add_microwaveable_object(d_trig);
          d_trig waittill("microwaved", vox_dude);
          maps\_zombiemode_weap_microwavegun::remove_microwaveable_object(d_trig);
          motivation = true;
        } else {
          d_trig waittill("damage", amount, attacker, direction, point, dmg_type, modelName, tagName);
          if(isPlayer(attacker) && moon_be_move(node.script_string)) {
            motivation = moon_be_move(dmg_type);
            vox_dude = attacker;
          }
        }
        self Solid();
        wait(0.05);
      }
      if(isDefined(vox_dude)) {
        vox_dude thread play_be_hit_vox(vox_num);
        vox_num++;
      }
      level._be playSound("evt_sq_blackegg_activate");
      d_trig Delete();
      self NotSolid();
      self SetSpeed(level._my_speed);
      self thread moon_be_resume_anim();
    }
    if(isDefined(node.script_waittill) && node.script_waittill == "sliding_door") {
      self SetSpeedImmediate(0);
      self thread moon_be_stop_anim();
      door_index = get_closest_index_2d(self.origin, level._sliding_doors);
      if(!isDefined(door_index)) {
        PrintLn("$$$$ door_index is not defined $$$$");
        wait(1.0);
        continue;
      }
      if(!isDefined(level._sliding_doors[door_index]._door_open)) {
        PrintLn("$$$$ door is missing knowledge of it being open $$$$");
        wait(1.0);
        continue;
      }
      if(!level._sliding_doors[door_index]._door_open) {
        level thread play_vox_on_closest_player(5);
        level._be playSound("evt_sq_blackegg_wait");
        level._be.stopped = true;
      }
      while(!level._sliding_doors[door_index]._door_open) {
        wait(0.05);
      }
      if(is_true(level._be.stopped)) {
        level._be playSound("evt_sq_blackegg_accel");
        level._be.stopped = false;
      }
      self SetSpeed(level._my_speed);
      self thread moon_be_resume_anim();
    }
    if(isDefined(node.script_hidden)) {
      self SetSpeedImmediate(0);
      self thread moon_be_stop_anim();
      if(!isDefined(level.flag[node.script_hidden])) {
        flag_init(node.script_hidden);
      }
      flag_wait(node.script_hidden);
      self SetSpeed(level._my_speed);
      self thread moon_be_resume_anim();
    }
    if(isDefined(node.script_parameters)) {
      next_chain_start = GetVehicleNode(node.script_parameters, "targetname");
      if(!isDefined(next_chain_start)) {
        PrintLn("$$$$ next_chain_start not defined $$$$");
        wait(1.0);
        continue;
      }
      self maps\_vehicle::vehicle_pathdetach();
      self SetSpeedImmediate(0);
      level._be playSound("evt_sq_blackegg_stop");
      self thread moon_be_stop_anim();
      self maps\_vehicle::getonpath(next_chain_start);
      if(isDefined(next_chain_start.script_string)) {
        d_trig = spawn("trigger_damage", self.origin, 0, 32, 72);
        motivation = false;
        while(!motivation) {
          if(isDefined(next_chain_start.script_string) && next_chain_start.script_string == "zap") {
            maps\_zombiemode_weap_microwavegun::add_microwaveable_object(d_trig);
            d_trig waittill("microwaved", vox_dude);
            maps\_zombiemode_weap_microwavegun::remove_microwaveable_object(d_trig);
            motivation = true;
          } else {
            d_trig waittill("damage", amount, attacker, direction, point, dmg_type, modelName, tagName);
            if(isPlayer(attacker) && moon_be_move(next_chain_start.script_string)) {
              motivation = moon_be_move(dmg_type);
              vox_dude = attacker;
            }
          }
          wait(0.05);
        }
        d_trig Delete();
      }
      if(isDefined(vox_dude)) {
        vox_dude thread play_be_hit_vox(vox_num);
        vox_num++;
      }
      level._be playSound("evt_sq_blackegg_activate");
      self SetSpeed(level._my_speed);
      self thread maps\_vehicle::gopath();
      self thread moon_be_resume_anim();
    }
    if(isDefined(node.script_int)) {
      self SetSpeedImmediate(node.script_int);
    }
    if(isDefined(node.script_index)) {
      self thread moon_be_anim_swap(node.script_index);
    }
  }
}
moon_be_move(motivation_array) {
  if(!isDefined(motivation_array)) {
    return false;
  }
  if(!IsString(motivation_array)) {
    PrintLn("$$$$ Motivation passed in that wasn't an string $$$$");
    return false;
  }
  motivational_array = StrTok(motivation_array, ",");
  match = false;
  for(i = 0; i < motivational_array.size; i++) {
    for(j = 0; j < level.motivational_array.size; j++) {
      if(motivational_array[i] == level.motivational_array[j]) {
        match = true;
        return true;
      }
    }
  }
  if(!match) {
    PrintLn("$$$$ No match to motivation $$$$");
    if(isDefined(motivational_array[0])) {
      PrintLn("$$$$ " + motivational_array[0] + " $$$$ ");
    } else {
      PrintLn("$$$$ Missing str_motivation $$$$");
    }
    return false;
  }
}
get_closest_index_2d(org, array, dist) {
  if(!isDefined(dist)) {
    dist = 9999999;
  }
  if(array.size < 1) {
    return;
  }
  index = undefined;
  for(i = 0; i < array.size; i++) {
    newdist = Distance2D(array[i].origin, org);
    if(newdist >= dist) {
      continue;
    }
    dist = newdist;
    index = i;
  }
  return index;
}
moon_be_anim_swap(int_anim) {
  self endon("death");
  self._be_model StopAnimScripted();
  if(int_anim == 0) {
    self._be_org_anim thread maps\_anim::anim_loop_aligned(self._be_model, "to_the_left", "tag_origin_animate_jnt");
  } else {
    self._be_org_anim thread maps\_anim::anim_loop_aligned(self._be_model, "to_the_right", "tag_origin_animate_jnt");
  }
}
moon_be_stop_anim() {
  self endon("death");
  self._be_model StopAnimScripted();
}
moon_be_resume_anim() {
  self endon("death");
  self endon("be_stage_one_over");
  rand = RandomInt(1);
  if(rand) {
    self._be_org_anim thread maps\_anim::anim_loop_aligned(self._be_model, "to_the_left", "tag_origin_animate_jnt");
  } else {
    self._be_org_anim thread maps\_anim::anim_loop_aligned(self._be_model, "to_the_right", "tag_origin_animate_jnt");
  }
}
waittill_player_is_close() {
  while(1) {
    players = get_players();
    for(i = 0; i < players.size; i++) {
      if(distancesquared(players[i].origin, self.origin) <= 250 * 250) {
        players[i] thread maps\_zombiemode_audio::create_and_play_dialog("eggs", "quest2", undefined, 0);
        return;
      }
    }
    wait(.5);
  }
}
play_be_hit_vox(num) {
  if(num > 4) {
    num -= 4;
  }
  self thread maps\_zombiemode_audio::create_and_play_dialog("eggs", "quest2", undefined, num);
}
play_vox_on_closest_player(num) {
  player = get_closest_player(level._be.origin);
  player thread maps\_zombiemode_audio::create_and_play_dialog("eggs", "quest2", undefined, num);
}