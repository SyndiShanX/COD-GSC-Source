/******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\marsbase\marsbase_elevator_retreat.gsc
******************************************************************/

_id_10C34() {
  var_0 = ["salter", "ethan", "brooks", "mccallum", "griff"];
  scripts\sp\maps\marsbase\marsbase_util::_id_10626(var_0, "ally_start_bridgewalk", 1);
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("player_start_bridgewalk", "targetname"));
  level thread scripts\sp\maps\marsbase\marsbase_hill_gate::_id_88E5();
  level thread _id_CCF3();
  scripts\sp\maps\marsbase\marsbase_code::_id_DFB4("aa_gun_3");
  scripts\sp\maps\marsbase\marsbase_code::_id_DFB4("aa_gun_4");
  level thread scripts\sp\maps\marsbase\marsbase_dialogue::_id_5414();
  level thread _id_88B9();
  level notify("loot_crate_aa1_cleanup");
  level notify("loot_crate_greenhouse_cleanup");
  level notify("loot_crate_aa2_cleanup");
  scripts\sp\maps\marsbase\marsbase_code::_id_C2AC("aa3_complete");
}

_id_B1D3() {
  scripts\sp\utility::_id_2669("Bridge Walk");
  scripts\sp\maps\marsbase\marsbase_elevator::_id_608C("elevator_sunfake_off");
  scripts\sp\maps\marsbase\marsbase_util::_id_F338();
  scripts\sp\utility::_id_15F5("trig_allies_bridgewalk");
  var_0 = getaiarray("axis");
  var_1 = getspawnerarray();
  var_2 = getEnt("hill_battle_cleanup_volume", "targetname");

  foreach(var_4 in var_1) {
    if(var_4 istouching(var_2)) {
      var_4 delete();
    }
  }

  foreach(var_7 in var_0) {
    if(!scripts\engine\utility::is_true(var_7.damageshield) && var_7 istouching(var_2)) {
      var_7 _meth_81D0();
    }
  }

  var_2 delete();
  thread scripts\sp\maps\marsbase\marsbase_dialogue::_id_541A();
  scripts\engine\utility::flag_wait_all("flag_bridgewalk_end", "elevator_dropship_docked");
  scripts\sp\maps\marsbase\marsbase_util::_id_7271("flag_hill_battle_elevator_started");
}

_id_60BE() {
  scripts\sp\maps\marsbase\marsbase_util::_id_7271("elevator_dropship_docked");
  scripts\sp\maps\marsbase\marsbase_util::_id_7271("flag_hill_battle_elevator_started");
}

_id_CCF3() {
  var_0 = getEnt("elevator_dropship_spawner", "targetname");
  var_1 = getEnt("elevator_dropship_trigger", "targetname");
  var_2 = var_0 scripts\sp\utility::_id_10808();
  var_2.ignoreme = 1;
  level._id_6066 = var_2;
  var_2 endon("death");
  var_3 = scripts\engine\utility::getStruct("tag_align_elevator_retreat_dropship", "targetname");
  var_3.angles = (0, 0, 0);
  var_2 notsolid();
  var_2 scripts\sp\utility::_id_23B7("dropship_elevator");
  wait 2.0;
  level thread _id_88DE(var_2);
  var_2 thread _id_6069();
  var_3 scripts\sp\anim::_id_1F35(var_2, "elevator_retreat_flyin");
  var_3 thread scripts\sp\anim::_id_1EEA(var_2, "elevator_retreat_idle");
  level waittill("elevator_dropship_crew_ready");
  wait 1.2;
  scripts\engine\utility::flag_wait("flag_elevator_dropship_unloaded");
  scripts\engine\utility::flag_set("elevator_dropship_docked");
  scripts\engine\utility::flag_waitopen("flag_elevator_dropship_unloaded");
  var_1 delete();
  wait 1;
  level waittill("loop_end");
  wait 1.1;
  var_2 playSound("mars_base_dropship_door_close");
  var_2 _id_0BBC::_id_4265("back");
  var_3 notify("stop_loop");
  var_2 notify("dropship_takeoff_snd");
  var_3 scripts\sp\anim::_id_1F35(var_2, "elevator_retreat_flyout");
}

_id_6069() {
  self endon("death");
  self playSound("mars_base_elevator_dropship_flyin");
  wait 3;
  self playLoopSound("mars_base_elevator_dropship_loop");
  var_0 = spawn("script_origin", self.origin);
  var_0 linkTo(self);
  self waittill("dropship_takeoff_snd");
  var_0 playSound("mars_base_gator_dropship_flyout");
  var_0 playLoopSound("mars_base_elevator_dropship_ascend");
  wait 2;
  self stoploopsound();
  wait 15;
  var_0 stoploopsound();
  var_0 delete();
}

_id_88DE(var_0) {
  level waittill("open_door");
  var_0 _id_0BBC::_id_C5F1("back");
  wait 1;
  level._id_6067 = _id_106BD();
  level._id_6067 = scripts\sp\utility::_id_22B9(level._id_6067);
  scripts\engine\utility::array_thread(level._id_6067, scripts\sp\utility::_id_5131);
  scripts\engine\utility::array_thread(level._id_6067, ::_id_4A5F);
  wait 0.2;
  scripts\sp\utility::_id_15F5("trig_allies_bridge_stand_ready");
  wait 1;
  level notify("elevator_dropship_crew_ready");
  wait 1;

  while(getaiarray("axis").size > 0) {
    wait 0.15;
  }

  wait 1;
  level.player scripts\sp\utility::_id_F526("relaxed");
  scripts\engine\utility::flag_wait("flag_dropship_crew_ready");
  level._id_6067 = scripts\sp\utility::_id_22B9(level._id_6067);
  scripts\engine\utility::array_thread(level._id_6067, scripts\sp\utility::_id_77B9, 0.5);
  scripts\engine\utility::array_thread(level._id_6067, scripts\sp\utility::_id_51E1, "cqb");
  scripts\engine\utility::array_thread(level._id_6067, ::_id_4A5F, "_ready", 0.3, 0.7);
  scripts\sp\utility::_id_15F5("trig_dropshop_crew_unload");
  level waittill("elevator_igc_started");
  level waittill("gate_raised");
  wait 3;
  _id_4A68("elevator_dropship_crew_ar_unit_front_l", "elevator_dropship_crew_ar_unit_back_l", "_combat");
  wait 3;
  _id_4A68("elevator_dropship_crew_ar_unit_front_r", "elevator_dropship_crew_ar_unit_back_r", "_combat");
  wait 2;
  _id_4A68("elevator_dropship_crew_sniper_unit_front_r", "elevator_dropship_crew_sniper_unit_back_r", "_combat");
  wait 2;
  _id_4A68("elevator_dropship_crew_sniper_unit_front_l", "elevator_dropship_crew_sniper_unit_back_l", "_combat");
  level._id_6067 = scripts\sp\utility::_id_22B9(level._id_6067);
  scripts\engine\utility::array_thread(level._id_6067, scripts\sp\utility::_id_51E1, "frantic");
}

_id_3B5C(var_0) {
  level._id_6067 = _id_106BD();
  scripts\sp\maps\marsbase\marsbase_util::_id_10626(level._id_6067, "ally_start_elevator_door");
  level._id_6067 = scripts\sp\utility::_id_22B9(level._id_6067);
  scripts\engine\utility::array_thread(level._id_6067, scripts\sp\utility::_id_5131);
  scripts\engine\utility::array_thread(level._id_6067, ::_id_4A5F);
  wait 0.2;
  scripts\sp\utility::_id_15F5("trig_allies_bridge_stand_ready");
  wait 1;
  level notify("elevator_dropship_crew_ready");
  scripts\engine\utility::flag_wait("flag_bridgewalk_start");
  wait 1;

  while(getaiarray("axis").size > 0) {
    wait 0.15;
  }

  wait 1;
  level.player scripts\sp\utility::_id_F526("relaxed");
  scripts\engine\utility::flag_wait("flag_dropship_crew_ready");
  level._id_6067 = scripts\sp\utility::_id_22B9(level._id_6067);
  scripts\engine\utility::array_thread(level._id_6067, scripts\sp\utility::_id_77B9, 0.5);
  scripts\engine\utility::array_thread(level._id_6067, scripts\sp\utility::_id_51E1, "cqb");
  scripts\engine\utility::array_thread(level._id_6067, ::_id_4A5F, "_ready", 0.3, 0.7);
  scripts\sp\utility::_id_15F5("trig_dropshop_crew_unload");
  level waittill("elevator_igc_started");
  level waittill("gate_raised");
  wait 3;
  _id_4A68("elevator_dropship_crew_ar_unit_front_l", "elevator_dropship_crew_ar_unit_back_l", "_combat");
  wait 3;
  _id_4A68("elevator_dropship_crew_ar_unit_front_r", "elevator_dropship_crew_ar_unit_back_r", "_combat");
  wait 3;
  _id_4A68("elevator_dropship_crew_sniper_unit_front_r", "elevator_dropship_crew_sniper_unit_back_r", "_combat");
  wait 3;
  _id_4A68("elevator_dropship_crew_sniper_unit_front_l", "elevator_dropship_crew_sniper_unit_back_l", "_combat");
  level._id_6067 = scripts\sp\utility::_id_22B9(level._id_6067);
  scripts\engine\utility::array_thread(level._id_6067, scripts\sp\utility::_id_51E1, "frantic");
}

_id_4A5F(var_0, var_1, var_2) {
  self endon("death");
  self notify("move_to_node");
  self endon("move_to_node");
  var_3 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, "");
  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 0.05);
  var_2 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, 0.2);
  var_4 = getnode(self._id_ECE7 + var_3, "targetname");

  if(scripts\engine\utility::is_true(self._id_9316)) {
    return;
  }
  wait(randomfloatrange(var_1, var_2));

  if(!isDefined(var_4)) {
    return;
  } else if(isDefined(var_4.script_parameters)) {
    scripts\sp\utility::_id_51E1(var_4.script_parameters);
  }

  if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "look_at_player") {
    scripts\sp\utility::_id_7799(level.player);
  }

  self _meth_82EE(var_4);
  self waittill("goal");
  self orientmode("face angle", var_4.angles[1]);
}

_id_4A68(var_0, var_1, var_2) {
  var_3 = getaiarray("allies");
  var_4 = [];
  var_5 = 0;

  foreach(var_7 in var_3) {
    if(isDefined(var_7._id_ECE7) && (var_7._id_ECE7 == var_0 || var_7._id_ECE7 == var_1)) {
      var_4[var_5] = var_7;
      var_5++;
    }
  }

  scripts\engine\utility::array_thread(var_4, ::_id_4A5F, var_2);
}

_id_106BD() {
  var_0 = getspawnerarray("elevator_retreat_dropship_crew");
  var_1 = [];

  foreach(var_4, var_3 in var_0) {
    var_1[var_4] = var_3 scripts\sp\utility::_id_10619(1);
  }

  return var_1;
}

_id_88B9() {
  var_0 = scripts\engine\utility::getStruct("tag_align_elevator_retreat_dropship", "targetname");
  var_0.angles = (0, 0, 0);
  var_1 = getspawner("bridge_execution_ally", "targetname");
  var_2 = getspawner("bridge_execution_enemy", "targetname");
  var_3 = var_2 scripts\sp\utility::_id_10619(1, 1);
  var_3._id_1FBB = "executed";
  var_0 thread _id_3006(var_3);
  var_3 scripts\sp\utility::_id_F415(1);
  var_3 scripts\sp\utility::_id_F416(1);
  var_3 _meth_84AE();
  var_3._id_10265 = 1;
  var_3.allowdeath = 0;
  var_3._id_C015 = 1;
  var_0 scripts\sp\anim::_id_1EC3(var_3, "bridge_execution");
  var_4 = var_1 scripts\sp\utility::_id_10619(1, 1);
  var_4 scripts\sp\utility::_id_F416(1);
  var_4._id_1FBB = "executioner";
  scripts\engine\utility::flag_wait("flag_bridgewalk_start");
  var_0 scripts\sp\anim::_id_1F17(var_4, "bridge_execution");
  var_0 thread scripts\sp\anim::_id_1F35(var_4, "bridge_execution");
  var_0 scripts\sp\anim::_id_1F35(var_3, "bridge_execution");
  var_4 scripts\sp\utility::_id_51E1("cqb");
  var_4 setgoalpos(var_4.origin);
  scripts\engine\utility::flag_wait("flag_dropship_crew_ready");
  var_5 = getnode("bridge_execution_ally_path", "targetname");
  var_4 scripts\sp\utility::_id_7226(var_5);
}

_id_3006(var_0) {
  level waittill("execution_fire");
  var_0 _id_0C60::_id_8E17();
  level waittill("execution_fire");
  scripts\sp\anim::_id_1EE0(var_0, "bridge_execution");
}