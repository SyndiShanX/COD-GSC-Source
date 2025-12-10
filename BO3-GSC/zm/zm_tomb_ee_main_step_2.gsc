/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_tomb_ee_main_step_2.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\hud_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_powerup_zombie_blood;
#using scripts\zm\_zm_sidequests;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\zm_tomb_chamber;
#using scripts\zm\zm_tomb_craftables;
#using scripts\zm\zm_tomb_ee_main;
#using scripts\zm\zm_tomb_utility;
#using scripts\zm\zm_tomb_vo;
#namespace zm_tomb_ee_main_step_2;

function init() {
  zm_sidequests::declare_sidequest_stage("little_girl_lost", "step_2", &init_stage, &stage_logic, &exit_stage);
}

function init_stage() {
  level._cur_stage_name = "step_2";
  a_structs = struct::get_array("robot_head_staff", "targetname");
  foreach(unitrigger_stub in a_structs) {
    level thread create_robot_head_trigger(unitrigger_stub);
    util::wait_network_frame();
    util::wait_network_frame();
    util::wait_network_frame();
  }
}

function stage_logic() {
  iprintln(level._cur_stage_name + "");
  level flag::wait_till("ee_all_staffs_placed");
  playsoundatposition("zmb_squest_robot_alarm_blast", (-14, -1, 871));
  wait(3);
  util::wait_network_frame();
  zm_sidequests::stage_completed("little_girl_lost", level._cur_stage_name);
}

function exit_stage(success) {
  a_structs = struct::get_array("robot_head_staff", "targetname");
  foreach(struct in a_structs) {
    struct thread remove_plinth();
    util::wait_network_frame();
    util::wait_network_frame();
    util::wait_network_frame();
  }
  foreach(var_5ec0aa73 in level.a_elemental_staffs) {
    e_upgraded_staff = zm_tomb_craftables::get_staff_info_from_weapon_name(var_5ec0aa73.w_weapon, 0);
    e_upgraded_staff.ee_in_use = undefined;
  }
  level notify("hash_4c5352e3");
}

function remove_plinth() {
  playFX(level._effect["teleport_1p"], self.m_plinth.origin);
  playsoundatposition("zmb_footprintbox_disappear", self.m_plinth.origin);
  wait(3);
  if(isDefined(self.m_plinth.m_staff)) {
    self.m_plinth.m_staff unlink();
    self.m_plinth.m_staff.origin = self.m_plinth.v_old_origin;
    self.m_plinth.m_staff.angles = self.m_plinth.v_old_angles;
    self.m_plinth.e_staff.ee_in_use = undefined;
  }
  self.m_sign delete();
  self.m_plinth delete();
  self.m_coll delete();
  zm_unitrigger::unregister_unitrigger(self);
}

function create_robot_head_trigger(unitrigger_stub) {
  playFX(level._effect["teleport_1p"], unitrigger_stub.origin);
  playsoundatposition("zmb_footprintbox_disappear", unitrigger_stub.origin);
  wait(3);
  unitrigger_stub.radius = 50;
  unitrigger_stub.height = 256;
  unitrigger_stub.script_unitrigger_type = "unitrigger_radius_use";
  unitrigger_stub.cursor_hint = "HINT_NOICON";
  unitrigger_stub.require_look_at = 1;
  m_coll = spawn("script_model", unitrigger_stub.origin);
  m_coll setModel("drone_collision");
  unitrigger_stub.m_coll = m_coll;
  util::wait_network_frame();
  m_plinth = spawn("script_model", unitrigger_stub.origin);
  m_plinth.angles = unitrigger_stub.angles;
  m_plinth setModel("p7_zm_ori_staff_holder");
  unitrigger_stub.m_plinth = m_plinth;
  util::wait_network_frame();
  m_sign = spawn("script_model", unitrigger_stub.origin);
  m_sign setModel("p7_zm_ori_runes");
  m_sign linkto(unitrigger_stub.m_plinth, "tag_origin", (0, 15, 40));
  m_sign hidepart("j_fire");
  m_sign hidepart("j_ice");
  m_sign hidepart("j_lightning");
  m_sign hidepart("j_wind");
  switch (unitrigger_stub.script_noteworthy) {
    case "fire": {
      m_sign showpart("j_fire");
      break;
    }
    case "water": {
      m_sign showpart("j_ice");
      break;
    }
    case "lightning": {
      m_sign showpart("j_lightning");
      break;
    }
    case "air": {
      m_sign showpart("j_wind");
      break;
    }
  }
  m_sign zm_powerup_zombie_blood::make_zombie_blood_entity();
  unitrigger_stub.m_sign = m_sign;
  unitrigger_stub.origin = unitrigger_stub.origin + vectorscale((0, 0, 1), 30);
  zm_unitrigger::register_static_unitrigger(unitrigger_stub, &robot_head_trigger_think);
}

function robot_head_trigger_think() {
  self endon("kill_trigger");
  str_weap_staff = "staff_" + self.script_noteworthy;
  var_5ec0aa73 = level.a_elemental_staffs[str_weap_staff].w_weapon;
  e_upgraded_staff = zm_tomb_craftables::get_staff_info_from_weapon_name(var_5ec0aa73, 0);
  while(true) {
    self waittill("trigger", player);
    if(player hasweapon(e_upgraded_staff.w_weapon)) {
      e_upgraded_staff.ee_in_use = 1;
      player takeweapon(e_upgraded_staff.w_weapon);
      zm_tomb_craftables::clear_player_staff(e_upgraded_staff.w_weapon);
      level.n_ee_robot_staffs_planted++;
      if(level.n_ee_robot_staffs_planted == 4) {
        level flag::set("ee_all_staffs_placed");
      }
      var_5ec0aa73 thread place_staff(self.stub.m_plinth);
    }
  }
}

function place_staff(m_plinth) {
  m_staff = getent(("craftable_" + self.name) + "_zm", "targetname");
  m_plinth.e_staff = self;
  m_plinth.m_staff = m_staff;
  m_plinth.v_old_angles = m_staff.angles;
  m_plinth.v_old_origin = m_staff.origin;
  m_staff linkto(m_plinth, "tag_origin", (0, 9, 30), (0, 0, 0));
  m_staff show();
  m_plinth playSound("zmb_squest_robot_place_staff");
}