/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\ber3_event_plaza.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;
#include maps\ber3;
#include maps\ber3_util;
#include maps\_music;

event_plaza_start() {
  thread simple_spawners_level_init();
  warp_players_underworld();
  warp_friendlies("struct_plaza_start_friends", "targetname");
  GetEnt("trig_spawn_basement_friendlies", "script_noteworthy") notify("trigger");
  GetEnt("trig_e2_friendlies_start", "script_noteworthy") notify("trigger");
  getent("e2_trig_spawn_plaza_mgs", "script_noteworthy") notify("trigger");
  for(i = 0; i < 4; i++) {
    if(i != 1) {
      thread wait_repopulate_flak(i + 10);
    }
  }
  flak_trigs = getEntArray("trig_e2_spawn_flak", "script_noteworthy");
  for(i = 0; i < flak_trigs.size; i++) {
    flak_trigs[i] notify("trigger");
    wait_network_frame();
  }
  remove_allies = getEntArray("rus_leave_at_library", "script_noteworthy");
  for(i = 0; i < remove_allies.size; i++) {
    remove_allies[i] notify("_disable_reinforcement");
    remove_allies[i] delete();
  }
  warp_players("struct_plaza_start", "targetname");
  thread maps\ber3_event_intro::e1_drones();
  thread maps\ber3_event_intro::delete_street_allies();
  wait(1);
  getent("trig_left_street", "targetname") notify("trigger");
  level thread e2_init_charge();
  wait(1);
  getent("trig_entering_basement", "targetname") notify("trigger");
}

e2_init_charge() {
  thread reich_fake_mg_fire();
  thread move_tank_2();
  getent("trig_entering_basement", "targetname") waittill("trigger");
  level.e1_rez_10_done = false;
  thread reznov_cellar_vo();
  thread remove_e1_friendlies();
  thread move_street_tanks();
  thread move_charging_tanks();
  thread e2_drone_battle_right_init();
  thread e2_tank_plaza_logic();
  thread destroy_mg();
  getent("trig_leaving_basement", "targetname") waittill("trigger");
  thread first_mortar();
  thread e2_charge_drones();
  while(!level.e1_rez_10_done) {
    wait(.1);
  }
  wait(1);
  thread blow_whistle();
  level notify("battle_cry");
  thread e2_charge_destroy_flaks_vo();
  pClip = getent("e2_charge_player_clip", "targetname");
  pClip delete();
  level notify("stop katyusha");
  setmusicstate("LAST_FIGHT");
  getent("e2_start_charge", "targetname") notify("trigger");
  getent("e2_friendlies_charge", "targetname") notify("trigger");
  thread e2_objectives();
  thread e2_friendly_fodder();
  thread e2_plaza_planes_init();
  thread e2_plaza_amb_left();
  thread maps\ber3_event_steps::e3_init_event();
}

lower_veteran_nade_count() {
  if(getDifficulty() == "fu") {
    germs = getEntArray("veteran_remove_grenades", "script_noteworthy");
    array_thread(germs, ::add_spawn_function, ::veteran_remove_grenades);
  }
}

veteran_remove_grenades() {
  self.grenadeAmmo = 0;
}

e2_charge_drones() {
  for(i = 0; i < level.trig_charge_drones.size; i++) {
    while(!OkTospawn()) {
      wait_network_frame();
    }
    if(NumRemoteClients()) {
      if(i % 2) {
        level.trig_charge_drones[i] notify("trigger");
      } else {
        level.trig_charge_drones[i] delete();
      }
    } else {
      level.trig_charge_drones[i] notify("trigger");
    }
    wait(0.1);
  }
}

reznov_cellar_vo() {
  level.sarge anim_single_solo(level.sarge, "e1_rez_wait_signal");
  level.sarge anim_single_solo(level.sarge, "e1_rez_09");
  level.sarge anim_single_solo(level.sarge, "e1_rez_10");
  level.e1_rez_10_done = true;
}

e2_charge_destroy_flaks_vo() {
  level.sarge thread anim_single_solo(level.sarge, "e1_rez_11");
  getent("trig_vo_destroy_flaks", "targetname") waittill("trigger");
  level.sarge anim_single_solo(level.sarge, "e2_rez_01");
  level.sarge anim_single_solo(level.sarge, "e2_rez_02");
  level.sarge anim_single_solo(level.sarge, "e2_rez_03");
  level.sarge anim_single_solo(level.sarge, "e2_rez_04");
  level.sarge anim_single_solo(level.sarge, "e2_rez_05");
}

e2_init_friendly_spawners() {
  base_guy_spawner = getent("e2_basement_guy", "script_noteworthy");
  base_guy_spawner thread add_spawn_function(::init_basement_guy);
}

init_basement_guy() {
  level.base_guy = self;
  level.base_guy.animname = "basement_guy1";
}

move_street_tanks() {
  tank2 = getent("e1_tank2", "targetname");
  tank3 = getent("e1_tank3", "targetname");
  if(NumRemoteClients()) {
    tank2 delete();
    tank3 delete();
  } else {
    tank2 thread move_tank_on_trigger("e2_tank2_start_node", "e2_start_charge");
    tank3 thread move_tank_on_trigger("e2_tank3_start_node", "e2_start_charge");
  }
}

move_charging_tanks() {
  getent("e2_start_charge", "targetname") waittill("trigger");
  tank_nodes = getvehiclenodearray("e2_charge_tanks", "targetname");
  for(i = 0; i < tank_nodes.size; i++) {
    newTank = spawn_tank("vehicle_rus_tracked_t34", tank_nodes[i], false);
    newTank thread e2_charge_tanks_shoot();
    wait_network_frame();
  }
}

e2_charge_tanks_shoot() {
  self endon("death");
  tank_targs = getstructarray("e2_charge_tank_targ", "targetname");
  while(true) {
    wait(randomintrange(2, 6));
    targ = tank_targs[randomint(tank_targs.size)];
    self setturrettargetvec(targ.origin);
    self waittill("turret_on_target");
    wait(1);
    self fireWeapon();
  }
}

remove_e1_friendlies() {
  guys = getEntArray("e1_friendly_fodder", "script_noteworthy");
  for(i = 0; i < guys.size; i++) {
    if(isDefined(guys[i]) && isalive(guys[i])) {
      guys[i] delete();
    }
  }
}

blow_whistle() {
  tank2 = getent("e2_tank1", "targetname");
  tank2 playSound("whistle_blow");
  level.comm notify("stop_comm_idle");
  level.comm anim_single_solo(level.comm, "comm_whistle");
  level.comm thread anim_loop_solo(level.comm, "comm_whistle_idle", undefined, "stop_comm_idle");
}

e2_friendly_fodder() {
  guys = getEntArray("friendly_charge_fodder", "script_noteworthy");
  for(i = 0; i < guys.size; i++) {
    if(isDefined(guys[i]) && isalive(guys[i])) {
      guys[i] thread bloody_death_after_wait(5, true, 5);
    }
  }
}

e2_objectives() {
  wait(3);
  obj_struct0 = getstruct("obj_flak88_0", "targetname");
  obj_struct1 = getstruct("obj_flak88_1", "targetname");
  obj_struct2 = getstruct("obj_flak88_2", "targetname");
  obj_struct3 = getstruct("obj_flak88_3", "targetname");
  level.flaks_alive = 4;
  level.flak0_destroyed = false;
  level.flak1_destroyed = false;
  level.flak2_destroyed = false;
  level.flak3_destroyed = false;
  objective_add(3, "current", &"BER3_OBJ3_4", obj_struct0.origin);
  objective_AdditionalPosition(3, 1, obj_struct1.origin);
  objective_AdditionalPosition(3, 2, obj_struct2.origin);
  objective_AdditionalPosition(3, 3, obj_struct3.origin);
}

e2_objectives_update_flak88() {
  objective_delete(3);
  objective_add(3, "current");
  if(isDefined(level.flaks_alive) && level.flaks_alive) {
    switch (level.flaks_alive) {
      case 1:
        objective_string(3, &"BER3_OBJ3_1");
        thread e2_flak88_vo(level.flaks_alive);
        break;
      case 2:
        objective_string(3, &"BER3_OBJ3_2");
        autosave_by_name("ber3 two flaks destroyed");
        thread e2_flak88_vo(level.flaks_alive);
        break;
      case 3:
        objective_string(3, &"BER3_OBJ3_3");
        thread e2_flak88_vo(level.flaks_alive);
        break;
      case 4:
        objective_string(3, &"BER3_OBJ3_4");
        thread e2_flak88_vo(level.flaks_alive);
        break;
    }
    first_set = false;
    obj_index = 1;
    if(!level.flak0_destroyed) {
      obj_struct0 = getstruct("obj_flak88_0", "targetname");
      objective_additionalPosition(3, obj_index, obj_struct0.origin);
      obj_index++;
    }
    if(!level.flak1_destroyed) {
      obj_struct1 = getstruct("obj_flak88_1", "targetname");
      objective_AdditionalPosition(3, obj_index, obj_struct1.origin);
      obj_index++;
    }
    if(!level.flak2_destroyed) {
      obj_struct2 = getstruct("obj_flak88_2", "targetname");
      objective_AdditionalPosition(3, obj_index, obj_struct2.origin);
      obj_index++;
    }
    if(!level.flak3_destroyed) {
      obj_struct3 = getstruct("obj_flak88_3", "targetname");
      objective_AdditionalPosition(3, obj_index, obj_struct3.origin);
      obj_index++;
    }
  } else {
    objective_string(3, &"BER3_OBJ3");
    objective_state(3, "done");
    autosave_by_name("ber3 flaks destroyed");
  }
}

e2_flak88_vo(flaks_left) {
  switch (flaks_left) {
    case 3:
      level.sarge anim_single_solo(level.sarge, "e2_rez_flak3_1");
      level.sarge thread anim_single_solo(level.sarge, "e2_rez_flak3_2");
      break;
    case 2:
      level.sarge anim_single_solo(level.sarge, "e2_rez_flak2_1");
      level.sarge thread anim_single_solo(level.sarge, "e2_rez_flak2_2");
      break;
    case 1:
      level.sarge anim_single_solo(level.sarge, "e2_rez_flak1_1");
      level.sarge thread anim_single_solo(level.sarge, "e2_rez_flak1_2");
      break;
    case 0:
      level.sarge anim_single_solo(level.sarge, "e2_rez_flak0_1");
      level.sarge thread anim_single_solo(level.sarge, "e2_rez_flak0_2");
      break;
  }
}

move_tank_2() {
  tank2 = getent("e2_tank1", "targetname");
  tank2 move_tank_on_trigger("e2_tank1_start_node", "trig_entering_basement");
  tank_targ = getstruct("e2_tank1_target1", "targetname");
  tank2 setturrettargetvec(tank_targ.origin);
  tank2 waittill("turret_on_target");
  wait(1);
  tank2 fireWeapon();
  getent("e2_tank1_destroy", "targetname") waittill("trigger");
  flak = getent("flak88_11", "targetname");
  aim_org = (tank2.origin + (0, 0, 40));
  flak setTurretTargetVec(aim_org);
  flak waittill("turret_on_target");
  flak clearTurretTarget();
  flak maps\_flak88::shoot_flak(aim_org);
  tank2 waittill("damage");
  tank2 notify("death");
}

e2_tank_plaza_logic() {
  getent("e2_start_charge", "targetname") waittill("trigger");
  start_node = getvehiclenode("e2_plaza_tank", "targetname");
  tank = spawnvehicle("vehicle_rus_tracked_t34", "tank", "t34", start_node.origin, start_node.angles);
  tank.vehicletype = "t34";
  maps\_vehicle::vehicle_init(tank);
  tank.script_turretmg = 0;
  tank attachPath(start_node);
  tank thread maps\_vehicle::vehicle_paths(start_node);
  tank startPath();
  level.plaza_tank_move = false;
  thread e2_tank_plaza_wait_move();
  tank veh_stop_at_node("e2_plaza_tank_stop1");
  level waittill("flak0 destroyed");
  tank resumespeed(8);
  tank thread e2_tank_plaza_shoot();
  tank veh_stop_at_node("e2_plaza_tank_stop2");
  while(!level.plaza_tank_move) {
    wait(.5);
  }
  tank resumespeed(8);
  tank veh_stop_at_node("e2_plaza_tank_stop3");
  tank doDamage(tank.health + 200, (0, 0, 0));
  tank notify("death");
}

e2_tank_plaza_shoot() {
  self endon("death");
  tank_targs = getstructarray("e2_plaza_tank_targ", "targetname");
  statue_targ = getstruct("e2_tank1_target2", "targetname");
  wait(7);
  self setturrettargetvec(statue_targ.origin);
  self waittill("turret_on_target");
  self fireWeapon();
  wait(.5);
  playFX(level._effect["e2_statue_explode"], statue_targ.origin);
  statue = getent("ber3_plaza_statue", "targetname");
  statue delete();
  while(true) {
    wait(randomintrange(4, 7));
    targ = tank_targs[randomint(tank_targs.size)];
    self setturrettargetvec(targ.origin);
    self waittill("turret_on_target");
    wait(1);
    self fireWeapon();
  }
}

e2_tank_plaza_wait_move() {
  getent("e2_plaza_tank_move", "targetname") waittill("trigger");
  level.plaza_tank_move = true;
}

destroy_mg() {
  thread e2_satchel_init();
  thread watch_flak("trig_dmg_flak0", "flak88_10", 0, "flak0 destroyed");
  thread watch_flak("trig_dmg_flak1", "flak88_11", 1);
  thread watch_flak("trig_dmg_flak2", "flak88_12", 2);
  thread watch_flak("trig_dmg_flak3", "flak88_13", 3);
}

watch_flak(trigName, flakName, destVar, specNotify) {
  flak = getent(flakName, "targetname");
  flak thread wait_stop_flak_firing();
  flak thread watch_flak_death(destVar, specNotify);
  getent(trigName, "targetname") waittill("damage", amount, attacker);
  if(isDefined(attacker) && isplayer(attacker)) {
    if(isDefined(attacker.damageWeapon) && attacker.damageWeapon == "panzerschrek") {
      flak notify("death");
      level notify("flak destroyed");
    }
  }
}

watch_flak_death(destVar, specNotify) {
  self waittill("death");
  level thread rumble_all_players("damage_heavy", "damage_light", self.origin, 512, 512);
  if(isDefined(specNotify)) {
    level notify(specNotify);
  }
  if(destVar == 0) {
    level.flak0_destroyed = 1;
  } else if(destVar == 1) {
    level.flak1_destroyed = 1;
  } else if(destVar == 2) {
    level.flak2_destroyed = 1;
  } else if(destVar == 3) {
    level.flak3_destroyed = 1;
  }
  level.flaks_alive--;
  e2_objectives_update_flak88();
  if(level.flaks_alive == 0) {
    wait(2);
    thread maps\ber3_event_steps::e3_objectives();
  }
}

wait_stop_flak_firing() {
  self waittill_any("crew dismounted", "crew dead", "death");
  self.target = undefined;
}

e2_satchel_init() {
  trigs = getEntArray("trig_flak_objective", "script_noteworthy");
  for(i = 0; i < trigs.size; i++) {
    trigs[i] SetHintString(&"BER3_HINT_PLANT_CHARGE");
  }
  flak0 = getent("flak88_10", "targetname");
  flak0_satchel_trig = getent("objective_flak0", "targetname");
  flak1 = getent("flak88_11", "targetname");
  flak1_satchel_trig = getent("objective_flak1", "targetname");
  flak2 = getent("flak88_12", "targetname");
  flak2_satchel_trig = getent("objective_flak2", "targetname");
  flak3 = getent("flak88_13", "targetname");
  flak3_satchel_trig = getent("objective_flak3", "targetname");
  flak0 thread satchel_setup(flak0_satchel_trig, flak0);
  flak1 thread satchel_setup(flak1_satchel_trig, flak1);
  flak2 thread satchel_setup(flak2_satchel_trig, flak2);
  flak3 thread satchel_setup(flak3_satchel_trig, flak3);
}

wait_repopulate_flak(spawn_group) {
  level waittill("spawnvehiclegroup" + spawn_group);
  wait(1);
  flak = getent("flak88_" + spawn_group, "targetname");
  flak repopulate_flak();
}

repopulate_flak() {
  self endon("death");
  while(true) {
    self waittill("crew dead");
    wait(5);
    new_flak_gunners = [];
    for(; new_flak_gunners.size < 4;) {
      guy = get_closest_ai_exclude(self.origin, "axis", new_flak_gunners);
      if(isDefined(guy) && isalive(guy)) {
        guy.script_ignoreme = 1;
        new_flak_gunners = array_add(new_flak_gunners, guy);
      } else {
        wait(1);
      }
    }
    self thread maps\_flak88::mount_world_flakcrew(new_flak_gunners);
  }
}

reich_fake_mg_fire() {
  clientNotify("rff");
}

first_mortar() {
  launchers = getstructarray("e2_mortar_start", "targetname");
  targ = getstruct("e2_mortar_targ_first", "targetname");
  launchers[0] thread fire_mortar(targ);
  for(i = 0; i < launchers.size; i++) {
    launchers[i] thread e2_mortar_looping();
    wait(2);
  }
}

e2_mortar_looping() {
  thread e2_mortar_looping2();
  level endon("stop first mortar set");
  targs = getstructarray("e2_mortar_targ", "targetname");
  while(true) {
    self thread fire_mortar(targs[randomint(targs.size)]);
    wait(randomintrange(4, 7));
  }
}

e2_mortar_looping2() {
  getent("trig_vo_destroy_flaks", "targetname") waittill("trigger");
  level notify("stop first mortar set");
  targs = getstructarray("e2_mortar_targ2", "targetname");
  while(true) {
    self thread fire_mortar(targs[randomint(targs.size)]);
    wait(randomintrange(4, 7));
  }
}

fake_launch(org) {
  targs = getstructarray("dirt_mortar", "targetname");
  targ = targs[randomint(targs.size)];
}

fire_mortar(targ_struct) {
  playsoundatposition(level.scr_sound["mortar_flash"], self.origin);
  playFX(level._effect["mortar_flash"], self.origin, anglesToForward(self.angles));
  wait(randomintrange(4, 7));
  playsoundatposition("mortar_dirt", targ_struct.origin);
  playFX(level._effect["dirt_mortar"], targ_struct.origin);
  earthquake(0.5, 2.5, targ_struct.origin, 512);
  radiusDamage(targ_struct.origin, 128, 300, 35);
  physicsExplosionSphere(targ_struct.origin, 160, 100, 1);
}

e2_plaza_planes_init() {
  if(!NumRemoteClients()) {
    il2_nodes = getvehiclenodearray("e2_plaza_planes", "targetname");
    il2_nodes2 = getvehiclenodearray("e2_plaza_planes2", "targetname");
    while(true) {
      for(i = 0; i < il2_nodes.size; i++) {
        thread spawn_plane("vehicle_rus_airplane_il2", il2_nodes[i]);
      }
      wait(5);
      for(i = 0; i < il2_nodes2.size; i++) {
        thread spawn_plane("vehicle_rus_airplane_il2", il2_nodes2[i]);
      }
      wait(10);
    }
  }
}

e2_plaza_amb_left() {
  thread e2_plaza_amb_left_panzer();
}

e2_plaza_amb_left_panzer() {
  trig = getent("trig_e2_amb_building_schreck", "targetname");
  trig waittill("trigger");
  schreck_start = getstruct("e2_amb_building_shreck", "targetname");
  schreck_end = getstruct(schreck_start.target, "targetname");
  thread maps\ber3_event_intro::fire_shrecks(schreck_start, schreck_end, 1);
}

e2_drone_battle_right_init() {
  thread e2_dbattle_right_tanks();
}

e2_dbattle_right_tanks() {
  if(!NumRemoteClients()) {
    getent("e2_spawn_right_tanks", "targetname") waittill("trigger");
    wait(2);
    tank1 = getent("e2_db_tank1", "targetname");
    tank2 = getent("e2_db_tank2", "targetname");
    tank3 = getent("e2_db_tank3", "targetname");
    tank4 = getent("e2_db_tank4", "targetname");
    tank5 = getent("e2_db_tank5", "targetname");
    tank1 thread veh_stop_at_node("e2_db_tank1_stop1");
    tank2 thread veh_stop_at_node("e2_db_tank2_stop1");
    tank3 thread veh_stop_at_node("e2_db_tank3_stop1");
    tank4 thread veh_stop_at_node("e2_db_tank4_stop1");
    tank5 thread veh_stop_at_node("e2_db_tank5_stop1");
    getent("e2_setup_back_flaks", "targetname") waittill("trigger");
    tank1 resumespeed(8);
    tank2 resumespeed(8);
    tank3 resumespeed(8);
    tank4 resumespeed(8);
    tank5 resumespeed(8);
    tank1 thread veh_stop_at_node("e2_db_tank1_stop2");
    tank2 thread veh_stop_at_node("e2_db_tank2_stop2");
    tank3 thread veh_stop_at_node("e2_db_tank3_stop2");
    tank4 thread veh_stop_at_node("e2_db_tank4_stop2");
    tank5 thread veh_stop_at_node("e2_db_tank5_stop2");
  }
}