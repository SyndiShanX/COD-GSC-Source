/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_radiation.gsc
**************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

main() {
  precachemodel("tag_origin");
  maps\mp\mp_radiation_fx::main();
  precachemodel("collision_geo_64x64x256");
  precachemodel("collision_wall_128x128x10");
  precachemodel("collision_geo_256x256x10");
  maps\mp\_load::main();
  maps\mp\mp_radiation_amb::main();
  if(GetDvarInt(#"xblive_wagermatch") == 1) {
    maps\mp\_compass::setupMiniMap("compass_map_mp_radiation_wager");
  } else {
    maps\mp\_compass::setupMiniMap("compass_map_mp_radiation");
  }
  SetDvar("sm_sunSampleSizeNear", ".5");
  maps\mp\gametypes\_teamset_urbanspecops::level_init();
  setdvar("compassmaxrange", "2100");
  spawncollision("collision_geo_64x64x256", "collider", (1221, 41, 236), (0, 0, 0));
  spawncollision("collision_wall_128x128x10", "collider", (1042, -309, 309), (0, 0, 0));
  spawncollision("collision_wall_128x128x10", "collider", (1080, -309, 309), (0, 0, 0));
  spawncollision("collision_geo_64x64x256", "collider", (568, 219, 264), (0, 0, 0));
  spawncollision("collision_geo_64x64x256", "collider", (567, -105, 264), (0, 0, 0));
  spawncollision("collision_wall_128x128x10", "collider", (1157, -345, 186), (0, 270, 0));
  spawncollision("collision_wall_128x128x10", "collider", (1157, -345, 314), (0, 270, 0));
  spawncollision("collision_wall_128x128x10", "collider", (1157, -345, 442), (0, 270, 0));
  addNoTurretTrigger((1440, -1116, 145), 230, 256);
  addNoTurretTrigger((1446, -1659, 145), 230, 256);
  maps\mp\gametypes\_spawning::level_use_unified_spawning(true);
  flag_init_func();
  level_objects_init();
}
flag_init_func() {
  flag_init("kill_stuck_players");
}
level_objects_init() {
  level._digger_fx = LoadFX("maps/mp_maps/fx_mp_sand_digger_radiation");
  waittillframeend;
  level._door_switch_trig1 = getent_and_assert("switch_trigger1");
  level._door_switch_trig2 = getent_and_assert("switch_trigger2");
  level._door1 = getent_and_assert("big_door1_clip");
  level._door2 = getent_and_assert("big_door2_clip");
  level.const_fx_exploder_switch_green_light = 2001;
  level.const_fx_exploder_switch_red_light = 2002;
  level thread digger_dig_init();
  moving_diggers_init();
  level thread door_switch_func();
  if(!level.wagerMatch) {
    level thread double_doors_open_at_start();
  }
  level thread conveyer_belt_init();
}
turnSwitchPanelRed() {
  exploder_stop(level.const_fx_exploder_switch_green_light);
  exploder(level.const_fx_exploder_switch_red_light);
}
turnSwitchPanelGreen() {
  exploder_stop(level.const_fx_exploder_switch_red_light);
  exploder(level.const_fx_exploder_switch_green_light);
}
door_switch_func() {
  level._door_switch_trig1 thread door_switch_setup();
  level._door_switch_trig2 thread door_switch_setup();
  cooldown_switches = getEntArray("off_trigger", "targetname");
  AssertEx(cooldown_switches.size > 0, "Missing off_triggers");
  for(i = 0; i < cooldown_switches.size; i++) {
    cooldown_switches[i] UseTriggerRequireLookAt();
    cooldown_switches[i] SetCursorHint("HINT_NOICON");
    cooldown_switches[i] SetHintString(&"MP_HOLD_DOOR_SWITCH_UNAVAILABLE");
    cooldown_switches[i] trigger_off();
  }
  turnSwitchPanelRed();
  kill_trig1 = getent_and_assert("edge_death_trig1");
  kill_trig2 = getent_and_assert("edge_death_trig2");
  center_death_trig = getent_and_assert("center_death_trig");
  d1_new_angle = set_dvar_int_if_unset("scr_d1_new_angle", "123");
  d2_new_angle = set_dvar_int_if_unset("scr_d2_new_angle", "-123");
  door_model1 = getent_and_assert("big_door1");
  door_model2 = getent_and_assert("big_door2");
  door_model1 LinkTo(level._door1);
  door_model2 LinkTo(level._door2);
  door_monster_clip = GetEnt("door_monster_clip", "targetname");
  snd_door_status = 0;
  light_structs = getstructarray("switch_struct", "targetname");
  AssertEx(light_structs.size > 0, "Missing light structs");
  for(i = 0; i < light_structs.size; i++) {
    light_structs[i] thread switch_lights(i);
  }
  tunnel_structs = getstructarray("tunnel_light_spot", "targetname");
  AssertEx(tunnel_structs.size > 0, "Missing light structs");
  for(i = 0; i < light_structs.size; i++) {
    tunnel_structs[i] thread tunnel_lights(i);
  }
  while(!level.wagermatch) {
    waittill_any_ents(level._door_switch_trig1, "trigger", level._door_switch_trig2, "trigger");
    level._door_switch_trig1 trigger_off();
    level._door_switch_trig2 trigger_off();
    for(i = 0; i < cooldown_switches.size; i++) {
      cooldown_switches[i] trigger_on();
    }
    door_time = set_dvar_int_if_unset("scr_d1_time", "8");
    if(snd_door_status == 0) {
      d1_accel = door_time * .6;
      d2_accel = door_time * .7;
      d1_decel = door_time * .4;
      d2_decel = door_time * .3;
      door_monster_clip trigger_on();
      door_monster_clip DisconnectPaths();
    } else {
      d1_accel = door_time * .7;
      d2_accel = door_time * .6;
      d1_decel = door_time * .3;
      d2_decel = door_time * .4;
    }
    door_cooldown = set_dvar_int_if_unset("scr_door_cooldown", "20");
    level._door1 RotateRoll(d1_new_angle, door_time, d1_accel, d1_decel);
    level._door2 RotateRoll(d2_new_angle, door_time, d2_accel, d2_decel);
    thread dropEverythingOnDoorsToGround();
    level thread destroyEquipment();
    level._door1 playLoopSound("evt_hydraulic_loop", .5);
    level._door1 playSound("evt_hydraulic_start");
    level._door1 thread door_snd_alarm(5);
    d1_new_angle = d1_new_angle * -1;
    d2_new_angle = d1_new_angle * -1;
    flag_set("kill_stuck_players");
    wait 4;
    if(snd_door_status == 1) {
      kill_trig1 thread kill_edge_players_func();
      kill_trig2 thread kill_edge_players_func();
      center_death_trig thread kill_edge_players_func();
    }
    level._door1 waittill("rotatedone");
    if(snd_door_status == 0) {
      level._door1 stoploopsound(1);
      center_death_trig playSound("evt_hydraulic_open");
      snd_door_status = 1;
    } else {
      level._door1 stoploopsound(1);
      center_death_trig playSound("evt_hydraulic_close");
      door_monster_clip ConnectPaths();
      door_monster_clip trigger_off();
      snd_door_status = 0;
    }
    flag_clear("kill_stuck_players");
    level notify("edge_check");
    wait(door_cooldown);
    level notify("no_cooldown");
    for(i = 0; i < cooldown_switches.size; i++) {
      cooldown_switches[i] trigger_off();
    }
    level._door_switch_trig1 trigger_on();
    level._door_switch_trig2 trigger_on();
  }
}
door_snd_alarm(alarmTimes) {
  for(i = 0; i < alarmTimes; i++) {
    wait(.5);
    playsoundatposition("amb_alarm_buzz", (-664, 110, 436));
    playsoundatposition("amb_alarm_buzz", (-664, -72, 436));
    playsoundatposition("amb_alarm_buzz", (-666, -602, 436));
    playsoundatposition("amb_alarm_buzz", (-666, 660, 444));
    wait(1.5);
  }
}
door_switch_setup() {
  self usetriggerrequirelookat();
  if(level.wagerMatch) {
    self SetHintString(&"MP_HOLD_DOOR_SWITCH_UNAVAILABLE");
    turnSwitchPanelRed();
  } else {
    self SetHintString(&"MP_HOLD_TO_OPERATE_DOORS");
    turnSwitchPanelGreen();
  }
  while(!level.wagerMatch) {
    self waittill("trigger", who);
    if(isDefined(who)) {
      who playSound("evt_hydraulic_switch");
    }
    wait(1);
  }
}
kill_edge_players_func() {
  level endon("edge_check");
  while(1) {
    self waittill("trigger", player);
    if((player IsTouching(level._door1)) || (player IsTouching(level._door2))) {
      player DoDamage(player.health * 2, self.origin, player, player, 0, "MOD_SUICIDE");
    } else {
      wait .05;
    }
  }
}
switch_lights(element_number) {
  if(level.PrematchPeriod > 0 && level.inPrematchPeriod == true) {
    level waittill("prematch_over");
  }
  while(1) {
    effect_ent = spawn("script_model", self.origin);
    effect_ent setModel("tag_origin");
    wait .1;
    turnSwitchPanelGreen();
    waittill_any_ents(level._door_switch_trig1, "trigger", level._door_switch_trig2, "trigger");
    for(i = 0; i < element_number; i++) {
      wait .1;
    }
    effect_ent Delete();
    blinky_effect_ent = spawn("script_model", self.origin);
    blinky_effect_ent setModel("tag_origin");
    wait .1;
    turnSwitchPanelRed();
    level waittill("edge_check");
    for(i = 0; i < element_number; i++) {
      wait .1;
    }
    blinky_effect_ent Delete();
    final_effect_ent = spawn("script_model", self.origin);
    final_effect_ent setModel("tag_origin");
    wait .1;
    level waittill("no_cooldown");
    for(i = 0; i < element_number; i++) {
      wait .1;
    }
    final_effect_ent Delete();
  }
}
tunnel_lights(element_number) {
  door_closed = true;
  while(1) {
    effect_ent = undefined;
    if(door_closed) {
      effect_ent = spawn("script_model", self.origin);
      effect_ent setModel("tag_origin");
      wait .1;
      playFXOnTag(level._effect["green_light"], effect_ent, "tag_origin");
    }
    waittill_any_ents(level._door_switch_trig1, "trigger", level._door_switch_trig2, "trigger");
    for(i = 0; i < element_number; i++) {
      wait .1;
    }
    new_effect_ent = spawn("script_model", self.origin);
    new_effect_ent setModel("tag_origin");
    if(isDefined(effect_ent)) {
      effect_ent Delete();
    }
    wait .1;
    playFXOnTag(level._effect["blink_light"], new_effect_ent, "tag_origin");
    level waittill("edge_check");
    for(i = 0; i < element_number; i++) {
      wait .1;
    }
    new_effect_ent Delete();
    if(!door_closed) {
      door_closed = true;
    } else {
      door_closed = false;
    }
  }
}
double_doors_open_at_start() {
  if(level.PrematchPeriod > 0 && level.inPrematchPeriod == true) {
    level waittill("prematch_over");
  }
  wait .3;
  level._door_switch_trig1 notify("trigger");
}
devgui_radiation(cmd) {
  while(1) {
    wait(0.5);
    devgui_string = GetDvar(#"devgui_notify");
    switch (devgui_string) {
      case "":
        break;
      case "operate_doors":
        level._door_switch_trig1 notify("trigger");
        break;
      default:
        level notify(devgui_string);
        break;
    }
    SetDvar("devgui_notify", "");
  }
}
digger_dig_init() {
  diggers = getEntArray("digger_body", "targetname");
  AssertEx(diggers.size > 0, "Unable to find entity with targetname 'digger_body'");
  array_thread(diggers, ::digger_dig_think);
}
digger_dig_think() {
  body = self;
  arm = GetEnt(self.target, "targetname");
  AssertEx(isDefined(arm), "Unable to find arm entity for a digger at " + self.origin);
  blade_center = GetEnt(arm.target, "targetname");
  AssertEx(isDefined(blade_center), "Unable to find blade entity for a digger at " + self.origin);
  blade_pieces = getEntArray("digger_blade", "targetname");
  for(i = 0; i < blade_pieces.size; i++) {
    blade_pieces[i] LinkTo(blade_center);
  }
  blade_center LinkTo(arm);
  arm LinkTo(body);
  body playLoopSound("evt_excavator_idle", .5);
  if(isDefined(self.script_float)) {
    set_dvar_int_if_unset("scr_dig_delay", self.script_float);
  } else {
    set_dvar_int_if_unset("scr_dig_delay", 20);
  }
  while(1) {
    arm_move_speed = set_dvar_int_if_unset("scr_arm_move_speed", 11);
    blade_spin_speed = set_dvar_int_if_unset("scr_blade_spin_speed", 80);
    blade_spin_up_time = set_dvar_int_if_unset("scr_blade_spin_up_time", 3);
    body_turn = RandomIntRange(-15, 15);
    body_turn_speed = (positive_value_func(body_turn)) * .3;
    body RotateYaw(body_turn, body_turn_speed, body_turn_speed / 4, body_turn_speed / 4);
    arm playLoopSound("evt_excavator_move", .5);
    body playSound("evt_excavator_rev");
    body waittill("rotatedone");
    arm Unlink(body);
    arm RotatePitch(-45, arm_move_speed, arm_move_speed / 4, arm_move_speed / 4);
    arm waittill("rotatedone");
    blade_center UnLink(arm);
    blade_center RotatePitch(1800, blade_spin_speed, blade_spin_up_time, blade_spin_up_time);
    smokeAngles = (0, arm.angles[1] + 180, arm.angles[2]);
    forward = anglesToForward(smokeAngles);
    playFX(level._digger_fx, (blade_center.origin[0], blade_center.origin[1], blade_center.origin[2] - 560), forward);
    arm stoploopsound(1);
    blade_center playLoopSound("evt_excavator_blade", .5);
    blade_center waittill("rotatedone");
    blade_center stoploopsound(.5);
    blade_center LinkTo(arm);
    arm RotatePitch(45, arm_move_speed, arm_move_speed / 4, arm_move_speed / 4);
    arm playLoopSound("evt_excavator_move", .5);
    body playSound("evt_excavator_rev");
    arm waittill("rotatedone");
    arm LinkTo(body);
    body RotateYaw((body_turn * -1), body_turn_speed, body_turn_speed / 4, body_turn_speed / 4);
    body waittill("rotatedone");
    arm stoploopsound(.5);
    wait(GetDvarFloat(#"scr_dig_delay"));
  }
}
moving_diggers_init() {
  diggers = getEntArray("moving_digger", "targetname");
  array_thread(diggers, ::moving_diggers_think);
}
moving_diggers_think() {
  digger_struct = getstruct_and_assert(self.target);
  while(1) {
    self MoveTo(digger_struct.origin, digger_struct.script_int);
    AssertEx(isDefined(digger_struct.script_int), "Unable to find digger struct's 'script_int' key value pair for moving digger");
    self waittill("movedone");
    if(isDefined(digger_struct.target)) {
      digger_struct = GetStruct(digger_struct.target, "targetname");
    } else {
      break;
    }
  }
}
positive_value_func(num) {
  return (max(1, abs(num)));
}
conveyer_belt_init() {
  set_dvar_int_if_unset("scr_coveyer_speed", 45);
  conveyer_trigger = getent_and_assert("coveyer_trig");
  trigger_struct = getstruct_and_assert(conveyer_trigger.target);
  trigger_angles = anglesToForward(trigger_struct.angles);
  conveyer_trigger._conveyer_vector = vector_scale(trigger_angles, GetDvarInt(#"scr_coveyer_speed"));
  while(1) {
    conveyer_trigger waittill("trigger", player);
    if(IsPlayer(player)) {
      conveyer_trigger thread trigger_thread(player, ::player_on_conveyer);
    }
    wait .05;
  }
}
player_on_conveyer(player, endon_string) {
  player endon("death");
  player endon("disconnect");
  player endon(endon_string);
  while(1) {
    player_velocity = player GetVelocity();
    if(player IsOnGround()) {
      player SetVelocity(player_velocity + self._conveyer_vector);
    }
    wait .05;
  }
}
getent_and_assert(ent_name) {
  thing = GetEnt(ent_name, "targetname");
  AssertEx(isDefined(thing), "Unable to find targetname " + ent_name);
  return thing;
}
getstruct_and_assert(struct_name) {
  thing = getstruct(struct_name, "targetname");
  AssertEx(isDefined(thing), "Unable to find struct at " + struct_name);
  return thing;
}
dropEverythingOnDoorsToGround() {
  level endon("edge_check");
  while(1) {
    wait(0.1);
    dropAllToGround((0, 0, 128), 181, 100);
  }
}
destroyEquipment() {
  level endon("edge_check");
  for(;;) {
    wait(2);
    grenades = getEntArray("grenade", "classname");
    for(i = 0; i < grenades.size; i++) {
      item = grenades[i];
      if(!isDefined(item.name)) {
        continue;
      }
      if(!isDefined(item.owner)) {
        continue;
      }
      if(!IsWeaponEquipment(item.name)) {
        continue;
      }
      if(!item IsTouching(level._door1) && !item IsTouching(level._door2)) {
        continue;
      }
      watcher = item.owner getWatcherForWeapon(item.name);
      if(!isDefined(watcher)) {
        continue;
      }
      watcher thread maps\mp\gametypes\_weaponobjects::waitAndDetonate(item, 0.0, undefined);
    }
  }
}
getWatcherForWeapon(weapname) {
  if(!isDefined(self)) {
    return undefined;
  }
  if(!IsPlayer(self)) {
    return undefined;
  }
  for(i = 0; i < self.weaponObjectWatcherArray.size; i++) {
    if(self.weaponObjectWatcherArray[i].weapon != weapname) {
      continue;
    }
    return (self.weaponObjectWatcherArray[i]);
  }
  return undefined;
}
addNoTurretTrigger(position, radius, height) {
  while(!isDefined(level.noTurretPlacementTriggers)) {
    wait(0.1);
  }
  trigger = spawn("trigger_radius", position, 0, radius, height);
  level.noTurretPlacementTriggers[level.noTurretPlacementTriggers.size] = trigger;
}