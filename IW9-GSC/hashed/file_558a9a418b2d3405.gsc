/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_558a9a418b2d3405.gsc
***********************************************/

#using_animtree("script_model");

_id_8A879C8E46F826E6() {
  if(istrue(level._id_A18BAA0F9A6E1A1E)) {
    return;
  }
  level.scr_animtree["plyr_generic_btnpress"] = #animtree;
  level.scr_anim["plyr_generic_btnpress"]["button_pressed"] = % iw9_cp_raid2_silo_door_console_plr;
  level.scr_animname["plyr_generic_btnpress"]["button_pressed"] = "iw9_cp_raid2_silo_door_console_plr";
  level.scr_eventanim["plyr_generic_btnpress"]["button_pressed"] = "iw9_cp_raid2_silo_door_console_plr";
  level.scr_animtree["btn_generic_btnpress"] = #animtree;
  level.scr_anim["btn_generic_btnpress"]["button_pressed"] = % iw9_cp_raid2_silo_door_console_button;
  level.scr_animname["btn_generic_btnpress"]["button_pressed"] = "iw9_cp_raid2_silo_door_console_button";
  level._id_A18BAA0F9A6E1A1E = 1;
}

_id_F9F389DB8514931E() {
  if(istrue(level._id_2FA4DCDAC72E8991)) {
    return;
  }
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_anim["player_rig"]["power_switch"] = % iw9_cp_raid3_fusebox_on_plr_female;
  level.scr_animname["player_rig"]["power_switch"] = "iw9_cp_raid3_fusebox_on_plr_female";
  level.scr_eventanim["player_rig"]["power_switch"] = "iw9_cp_raid3_fusebox_on_plr_female";
  level.scr_animtree["power_switch"] = #animtree;
  level.scr_anim["power_switch"]["power_switch"] = % iw9_cp_raid3_fusebox_on_prop;
  level.scr_animname["power_switch"]["power_switch"] = "iw9_cp_raid3_fusebox_on_prop";
  level._id_2FA4DCDAC72E8991 = 1;
}

_id_A858510E43065956() {
  if(istrue(level._id_1BC00CC0BF802716)) {
    return;
  }
  level.scr_animtree["plyr_console"] = #animtree;
  level.scr_anim["plyr_console"]["use_console"] = % iw9_cp_raid2_airlock_computer;
  level.scr_animname["plyr_console"]["use_console"] = "iw9_cp_raid2_airlock_computer";
  level.scr_eventanim["plyr_console"]["use_console"] = "iw9_cp_raid2_airlock_computer";
  level._id_1BC00CC0BF802716 = 1;
}

_id_6C7AFDA240D43C96() {
  if(istrue(level._id_A7812DE51318AF9E)) {
    return;
  }
  level.scr_animtree["plyr_valve"] = #animtree;
  level.scr_anim["plyr_valve"]["valve_in"] = % iw9_cp_raid3_water_valve_in_plr_female;
  level.scr_animname["plyr_valve"]["valve_in"] = "iw9_cp_raid3_water_valve_in_plr_female";
  level.scr_eventanim["plyr_valve"]["valve_in"] = "iw9_cp_raid3_water_valve_in_plr_female";
  level.scr_anim["plyr_valve"]["valve_out"] = % iw9_cp_raid3_water_valve_out_plr_female;
  level.scr_animname["plyr_valve"]["valve_out"] = "iw9_cp_raid3_water_valve_out_plr_female";
  level.scr_eventanim["plyr_valve"]["valve_out"] = "iw9_cp_raid3_water_valve_out_plr_female";
  level.scr_anim["plyr_valve"]["valve_turn"] = % iw9_cp_raid3_water_valve_turn_plr_female;
  level.scr_animname["plyr_valve"]["valve_turn"] = "iw9_cp_raid3_water_valve_turn_plr_female";
  level.scr_eventanim["plyr_valve"]["valve_turn"] = "iw9_cp_raid3_water_valve_turn_plr_female";
  level.scr_anim["plyr_valve"]["valve_idle_start"][0] = % iw9_cp_raid3_water_valve_idle_start_plr_female;
  level.scr_animname["plyr_valve"]["valve_idle_start"][0] = "iw9_cp_raid3_water_valve_idle_start_plr_female";
  level.scr_eventanim["plyr_valve"]["valve_idle_start"][0] = "iw9_cp_raid3_water_valve_idle_start_plr_female";
  level.scr_anim["plyr_valve"]["valve_idle_end"][0] = % iw9_cp_raid3_water_valve_idle_end_plr_female;
  level.scr_animname["plyr_valve"]["valve_idle_end"][0] = "iw9_cp_raid3_water_valve_idle_end_plr_female";
  level.scr_eventanim["plyr_valve"]["valve_idle_end"][0] = "iw9_cp_raid3_water_valve_idle_end_plr_female";
  level.scr_animtree["water_valve"] = #animtree;
  level.scr_anim["water_valve"]["valve_in"] = % iw9_cp_raid3_water_valve_in_valve;
  level.scr_animname["water_valve"]["valve_in"] = "iw9_cp_raid3_water_valve_in_valve";
  level.scr_anim["water_valve"]["valve_out"] = % iw9_cp_raid3_water_valve_out_valve;
  level.scr_animname["water_valve"]["valve_out"] = "iw9_cp_raid3_water_valve_out_valve";
  level.scr_anim["water_valve"]["valve_turn"] = % iw9_cp_raid3_water_valve_turn_valve;
  level.scr_animname["water_valve"]["valve_turn"] = "iw9_cp_raid3_water_valve_turn_valve";
  level.scr_anim["water_valve"]["valve_idle_start"][0] = % iw9_cp_raid3_water_valve_idle_start_valve;
  level.scr_animname["water_valve"]["valve_idle_start"][0] = "iw9_cp_raid3_water_valve_idle_start_valve";
  level.scr_anim["water_valve"]["valve_idle_end"][0] = % iw9_cp_raid3_water_valve_idle_end_valve;
  level.scr_animname["water_valve"]["valve_idle_end"][0] = "iw9_cp_raid3_water_valve_idle_end_valve";
  level._id_A7812DE51318AF9E = 1;
}

_id_5B7AFD9AB30170A9() {
  if(istrue(level._id_B372C7353471DE81)) {
    return;
  }
  level.scr_animtree["plyr_pump_f"] = #animtree;
  level.scr_animtree["plyr_pump_m"] = #animtree;
  level.scr_anim["plyr_pump_f"]["button_press"] = % iw9_cp_raid3_pump_activate_plr_female;
  level.scr_animname["plyr_pump_f"]["button_press"] = "iw9_cp_raid3_pump_activate_plr_female";
  level.scr_eventanim["plyr_pump_f"]["button_press"] = "iw9_cp_raid3_pump_activate_plr_female";
  level.scr_anim["plyr_pump_m"]["button_press"] = % iw9_cp_raid3_pump_activate_plr_male;
  level.scr_animname["plyr_pump_m"]["button_press"] = "iw9_cp_raid3_pump_activate_plr_male";
  level.scr_eventanim["plyr_pump_m"]["button_press"] = "iw9_cp_raid3_pump_activate_plr_male";
  level._id_B372C7353471DE81 = 1;
}

_id_180DEE5A8E135B2A() {
  if(istrue(level._id_09EBED4B070D2FCE)) {
    return;
  }
  level.scr_animtree["plyr_plantcharge_f"] = #animtree;
  level.scr_animtree["plyr_plantcharge_m"] = #animtree;
  level.scr_anim["plyr_plantcharge_m"]["plantcharge"] = % iw9_cp_raid3_catwalk_c4_plant_plr;
  level.scr_animname["plyr_plantcharge_m"]["plantcharge"] = "iw9_cp_raid3_catwalk_c4_plant_plr";
  level.scr_eventanim["plyr_plantcharge_m"]["plantcharge"] = "iw9_cp_raid3_catwalk_c4_plant_plr";
  level.scr_anim["plyr_plantcharge_f"]["plantcharge"] = % iw9_cp_raid3_catwalk_c4_plant_plr_female;
  level.scr_animname["plyr_plantcharge_f"]["plantcharge"] = "iw9_cp_raid3_catwalk_c4_plant_plr_female";
  level.scr_eventanim["plyr_plantcharge_f"]["plantcharge"] = "iw9_cp_raid3_catwalk_c4_plant_plr_female";
  level._id_09EBED4B070D2FCE = 1;
}

_id_D8CC0613A4D4C3E1() {
  if(istrue(level._id_65BD2F5E3EF29609)) {
    return;
  }
  level.scr_animtree["plyr_cranecontrols_f"] = #animtree;
  level.scr_animtree["plyr_cranecontrols_m"] = #animtree;
  level.scr_anim["plyr_cranecontrols_m"]["crane_in"] = % iw9_cp_raid3_crane_console_plr_in;
  level.scr_animname["plyr_cranecontrols_m"]["crane_in"] = "iw9_cp_raid3_crane_console_plr_in";
  level.scr_eventanim["plyr_cranecontrols_m"]["crane_in"] = "iw9_cp_raid3_crane_console_plr_in";
  level.scr_anim["plyr_cranecontrols_m"]["crane_idle"][0] = % iw9_cp_raid3_crane_console_plr_loop;
  level.scr_animname["plyr_cranecontrols_m"]["crane_idle"][0] = "iw9_cp_raid3_crane_console_plr_loop";
  level.scr_eventanim["plyr_cranecontrols_m"]["crane_idle"][0] = "iw9_cp_raid3_crane_console_plr_loop";
  scripts\common\anim::addnotetrack_customfunction("plyr_cranecontrols_m", "sfx_crane_control_m_01", ::_id_EB4CDA8EB731276E, "crane_idle");
  scripts\common\anim::addnotetrack_customfunction("plyr_cranecontrols_m", "sfx_crane_control_m_02", ::_id_EB4CD98EB731253B, "crane_idle");
  scripts\common\anim::addnotetrack_customfunction("plyr_cranecontrols_m", "sfx_crane_control_m_03", ::_id_EB4CD88EB7312308, "crane_idle");
  scripts\common\anim::addnotetrack_customfunction("plyr_cranecontrols_m", "sfx_crane_control_m_04", ::_id_EB4CDF8EB731326D, "crane_idle");
  scripts\common\anim::addnotetrack_customfunction("plyr_cranecontrols_m", "sfx_crane_control_m_05", ::_id_EB4CDE8EB731303A, "crane_idle");
  level.scr_anim["plyr_cranecontrols_m"]["crane_out"] = % iw9_cp_raid3_crane_console_plr_out;
  level.scr_animname["plyr_cranecontrols_m"]["crane_out"] = "iw9_cp_raid3_crane_console_plr_out";
  level.scr_eventanim["plyr_cranecontrols_m"]["crane_out"] = "iw9_cp_raid3_crane_console_plr_out";
  level.scr_anim["plyr_cranecontrols_f"]["crane_in"] = % iw9_cp_raid3_crane_console_plr_in_female;
  level.scr_animname["plyr_cranecontrols_f"]["crane_in"] = "iw9_cp_raid3_crane_console_plr_in_female";
  level.scr_eventanim["plyr_cranecontrols_f"]["crane_in"] = "iw9_cp_raid3_crane_console_plr_in_female";
  level.scr_anim["plyr_cranecontrols_f"]["crane_idle"][0] = % iw9_cp_raid3_crane_console_plr_loop_female;
  level.scr_animname["plyr_cranecontrols_f"]["crane_idle"][0] = "iw9_cp_raid3_crane_console_plr_loop_female";
  level.scr_eventanim["plyr_cranecontrols_f"]["crane_idle"][0] = "iw9_cp_raid3_crane_console_plr_loop_female";
  scripts\common\anim::addnotetrack_customfunction("plyr_cranecontrols_f", "sfx_crane_control_f_01", ::_id_EB4CDA8EB731276E, "crane_idle");
  scripts\common\anim::addnotetrack_customfunction("plyr_cranecontrols_f", "sfx_crane_control_f_02", ::_id_EB4CD98EB731253B, "crane_idle");
  scripts\common\anim::addnotetrack_customfunction("plyr_cranecontrols_f", "sfx_crane_control_f_03", ::_id_EB4CD88EB7312308, "crane_idle");
  scripts\common\anim::addnotetrack_customfunction("plyr_cranecontrols_f", "sfx_crane_control_f_04", ::_id_EB4CDF8EB731326D, "crane_idle");
  scripts\common\anim::addnotetrack_customfunction("plyr_cranecontrols_f", "sfx_crane_control_f_05", ::_id_EB4CDE8EB731303A, "crane_idle");
  level.scr_anim["plyr_cranecontrols_f"]["crane_out"] = % iw9_cp_raid3_crane_console_plr_out_female;
  level.scr_animname["plyr_cranecontrols_f"]["crane_out"] = "iw9_cp_raid3_crane_console_plr_out_female";
  level.scr_eventanim["plyr_cranecontrols_f"]["crane_out"] = "iw9_cp_raid3_crane_console_plr_out_female";
  level.scr_animtree["cranecontrols"] = #animtree;
  level.scr_anim["cranecontrols"]["crane_in"] = % iw9_cp_raid3_crane_console_lever_in;
  level.scr_animname["cranecontrols"]["crane_in"] = "iw9_cp_raid3_crane_console_lever_in";
  level.scr_anim["cranecontrols"]["crane_idle"][0] = % iw9_cp_raid3_crane_console_lever_loop;
  level.scr_animname["cranecontrols"]["crane_idle"][0] = "iw9_cp_raid3_crane_console_lever_loop";
  level.scr_anim["cranecontrols"]["crane_out"] = % iw9_cp_raid3_crane_console_lever_out;
  level.scr_animname["cranecontrols"]["crane_out"] = "iw9_cp_raid3_crane_console_lever_out";
  level.scr_animtree["plyr_platforms"] = #animtree;
  level.scr_anim["plyr_platforms"]["button_press"] = % iw9_cp_raid2_platform_console_press;
  level.scr_animname["plyr_platforms"]["button_press"] = "iw9_cp_raid2_platform_console_press";
  level.scr_eventanim["plyr_platforms"]["button_press"] = "iw9_cp_raid2_platform_console_press";
  level.scr_animtree["platforms_button"] = #animtree;
  level.scr_anim["platforms_button"]["button_press"] = % iw9_cp_raid2_platform_console_press_button;
  level.scr_animname["platforms_button"]["button_press"] = "iw9_cp_raid2_platform_console_press_button";
  level._id_65BD2F5E3EF29609 = 1;
}

_id_42B3BAF315B2C222() {
  level.scr_animtree["cutter_player"] = #animtree;
  level.scr_anim["cutter_player"]["saw_in"] = % iw9_cp_raid3_saw_door_in_plr;
  level.scr_animname["cutter_player"]["saw_in"] = "iw9_cp_raid3_saw_door_in_plr";
  level.scr_eventanim["cutter_player"]["saw_in"] = "iw9_cp_raid3_saw_door_in_plr";
  level.scr_anim["cutter_player"]["saw_out"] = % iw9_cp_raid3_saw_door_out_plr;
  level.scr_animname["cutter_player"]["saw_out"] = "iw9_cp_raid3_saw_door_out_plr";
  level.scr_eventanim["cutter_player"]["saw_out"] = "iw9_cp_raid3_saw_door_out_plr";
  level.scr_anim["cutter_player"]["saw_loop"][0] = % iw9_cp_raid3_saw_door_loop_plr;
  level.scr_animname["cutter_player"]["saw_loop"][0] = "iw9_cp_raid3_saw_door_loop_plr";
  level.scr_eventanim["cutter_player"]["saw_loop"][0] = "iw9_cp_raid3_saw_door_loop_plr";
  level.scr_anim["saw"]["saw_in"] = % iw9_cp_raid3_saw_door_in_saw;
  level.scr_animname["saw"]["saw_in"] = "iw9_cp_raid3_saw_door_in_saw";
  level.scr_anim["saw"]["saw_out"] = % iw9_cp_raid3_saw_door_out_saw;
  level.scr_animname["saw"]["saw_out"] = "iw9_cp_raid3_saw_door_out_saw";
  level.scr_anim["saw"]["saw_loop"][0] = % iw9_cp_raid3_saw_door_loop_saw;
  level.scr_animname["saw"]["saw_loop"][0] = "iw9_cp_raid3_saw_door_loop_saw";
}

_id_6ECEF0D5BE659E3A(door, _id_B6491E67852275DA, _id_DAA61BE7C338D798, _id_30BFB3138218E061) {
  _id_7D03D2D2566E7AB6 = spawnStruct();
  _id_7D03D2D2566E7AB6.origin = door.origin;
  _id_7D03D2D2566E7AB6.angles = door.angles;
  hintstring = &"CP_BR_SYRK_OBJECTIVES/CUT_PILOT_OBJ";
  interaction = scripts\cp\utility::createhintobject(_id_DAA61BE7C338D798, "HINT_BUTTON", "cp_tac_waypoint_buzzsaw", hintstring, undefined, "duration_none", "hide", 200, 65, 72, 65);
  interaction._id_7D03D2D2566E7AB6 = _id_7D03D2D2566E7AB6;
  interaction.door = door;
  interaction._id_DAA61BE7C338D798 = _id_DAA61BE7C338D798;
  interaction._id_30BFB3138218E061 = _id_30BFB3138218E061;
  interaction.objectiveindex = _id_B6491E67852275DA;
  interaction.scenenode = spawnStruct();
  interaction.scenenode.origin = door.origin;
  interaction.scenenode.angles = door.angles;
  scripts\engine\utility::flag_init(_id_30BFB3138218E061);
  interaction thread _id_CA6DA2721F4C774A();
  interaction scripts\cp\cp_juggernaut::_id_91ED8C25C9B88686();
  return interaction;
}

_id_CA6DA2721F4C774A() {
  self endon("death");
  thread _id_B962C424B3103C43();

  for(;;) {
    self _meth_DFB78B3E724AD620(1);
    self waittill("trigger", player);

    if(player getstance() == "prone") {
      continue;
    }
    if(player getstance() != "stand")
      player setstance("stand", 1, 1);

    if(!isDefined(player) || !player scripts\cp\utility::is_valid_player() || !player isonground() || player isjumping()) {
      continue;
    }
    if(!player hasweapon("iw9_me_buzzsaw_mp")) {
      level notify("failed_saw_use", player);
      player scripts\cp\utility::setlowermessage("havesaw", &"CP_DWN_TWN_OBJECTIVES/NEED_SAW", 5);
      continue;
    }

    level notify("saw_used", self.objectiveindex, player);
    level notify("saw_door_started", self._id_30BFB3138218E061);
    objective_state(self.objectiveindex, "current");
    self _meth_DFB78B3E724AD620(0);

    if(!_id_F8E0AF123CBDD15A(player)) {
      level notify("saw_released_early", self.objectiveindex, player);
      wait 1;
      continue;
    }

    level notify("saw_finished", self.objectiveindex, player);
    self delete();
  }
}

_id_B962C424B3103C43() {
  self endon("death");

  for(;;) {
    if(!scripts\cp\utility::any_player_nearby(self.origin, squared(1000)))
      objective_state(self.objectiveindex, "done");

    wait 1;
  }
}

_id_F8E0AF123CBDD15A(player) {
  _id_42B3BAF315B2C222();
  actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(player, "cutter_player", 1, 0);
  _id_BE31E8030AEAE176 = spawn("script_model", self.scenenode.origin);
  _id_BE31E8030AEAE176.angles = self.scenenode.angles;
  _id_BE31E8030AEAE176 setModel("misc_wm_buzzsaw_v0");
  _id_BE31E8030AEAE176 hide();
  _id_2F104DB7D9715D4F = scripts\cp_mp\anim_scene::anim_scene_create_actor(_id_BE31E8030AEAE176, "saw", 0);
  player._id_5D43389756907528 = 1;
  objective_pinforclient(self.objectiveindex, player);
  _func_D1B64C3D055CEEB0(2, player);
  _func_8B71EB96E1636EDC(&"CP_RAID1_BOSS1/SAW_CUT", player);
  thread _id_59EE7E6E5C100827(actorplayer, player, _id_BE31E8030AEAE176, _id_2F104DB7D9715D4F);
  thread _id_D7A47D3FA95922AC(player, _id_BE31E8030AEAE176);
  thread _id_DEA2280D54F96878(actorplayer);
  self waittill("cut_finished", success);
  objective_unpinforclient(self.objectiveindex, player);

  if(istrue(success)) {
    scripts\engine\utility::flag_set(self._id_30BFB3138218E061);
    objective_delete(self.objectiveindex);
  }

  if(isDefined(player) && isalive(player)) {
    player forceusehintoff();
    player._id_5D43389756907528 = 1;
  }

  _id_BE31E8030AEAE176 notify("stopsparks");

  if(istrue(success)) {
    wait 0.1;
    _id_BE31E8030AEAE176 delete();
  } else {
    wait 2;
    _id_BE31E8030AEAE176 delete();
  }

  if(istrue(success))
    return 1;

  return 0;
}

_id_42F04B0131885759(player, _id_BE31E8030AEAE176) {
  player endon("disconnect");
  wait 0.1;

  if(isDefined(_id_BE31E8030AEAE176)) {
    stopFXOnTag(level._effect["vfx_cp_raid_saw_sparks"], _id_BE31E8030AEAE176, "tag_fx");
    _id_BE31E8030AEAE176 stoploopsound();
    playsoundatpos(_id_BE31E8030AEAE176.origin, "saw_spinup_stop");
  }

  wait 0.65;
  player _id_6438F84C6B2CA0A1(0);
}

_id_D7A47D3FA95922AC(player, _id_BE31E8030AEAE176) {
  _id_BE31E8030AEAE176 endon("death");
  _id_BE31E8030AEAE176 endon("stopsparks");
  player endon("disconnect");
  player endon("last_stand");
  wait 0.2;
  player _id_6438F84C6B2CA0A1(1);
  _id_BE31E8030AEAE176 show();
  wait 1.5;
  _id_BE31E8030AEAE176 playLoopSound("saw_spinup");
  wait 1.9;
  playFXOnTag(level._effect["vfx_cp_raid_saw_sparks"], _id_BE31E8030AEAE176, "tag_fx");
}

_id_6438F84C6B2CA0A1(_id_E3108E412AFB3811) {
  if(istrue(_id_E3108E412AFB3811)) {
    self setclientomnvar("ui_toggle_third_person", 1);
    _id_10B8EEB0CCDB73F5(1);
  } else if(!istrue(self._id_911B640702FEC71A)) {
    self setclientomnvar("ui_toggle_third_person", 0);
    _id_10B8EEB0CCDB73F5(0);
  }
}

_id_10B8EEB0CCDB73F5(_id_E3108E412AFB3811) {
  if(istrue(_id_E3108E412AFB3811))
    self setcamerathirdperson(1);
  else {
    self setcamerathirdperson(0);
    self _meth_5762CF97C6F1A2C1("none");
  }
}

_id_59EE7E6E5C100827(actorplayer, player, _id_BE31E8030AEAE176, _id_2F104DB7D9715D4F) {
  player endon("disconnect");
  player endon("death");
  _id_F7D79C7C83E5DF5B = getanimlength(level.scr_anim["cutter_player"]["saw_in"]);
  _id_621528A23A9B2007 = 15;
  _id_950C749B2EAB4F0A = getanimlength(level.scr_anim["cutter_player"]["saw_out"]);
  animname = "player_cutter";
  actorplayer scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1);
  _id_2F104DB7D9715D4F scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1);
  actors = [actorplayer, _id_2F104DB7D9715D4F];

  for(;;) {
    _id_2A39C361FA052EC4 = getanimlength(level.scr_anim["cutter_player"]["saw_in"]);
    _id_63D9E852FB3AF677 = gettime() + _id_2A39C361FA052EC4 * 1000;
    self.scenenode thread scripts\cp_mp\anim_scene::anim_scene(actors, "saw_in", 1, 0);

    while(gettime() < _id_63D9E852FB3AF677 && player scripts\cp\utility::is_valid_player())
      waitframe();

    if(!player scripts\cp\utility::is_valid_player() || !player hasweapon("iw9_me_buzzsaw_mp")) {
      self.scenenode scripts\cp_mp\anim_scene::anim_scene_stop(1);
      player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("anim_scene");
      player stopanimscriptsceneevent();
      player unlink();

      foreach(actor in actors) {
        actor.forceendscene = 1;

        if(isent(actor.player_rig))
          actor.player_rig hide();
      }

      thread _id_42F04B0131885759(player, _id_BE31E8030AEAE176);
      player notify("cut_failed");
      self notify("cut_finished", 0);
      return;
    }

    self.scenenode thread scripts\cp_mp\anim_scene::anim_scene_loop(actors, "saw_loop", 0, 0);
    result = _id_67EEE84BAED1DE02(player, _id_621528A23A9B2007);

    if(!istrue(result)) {
      if(!player scripts\cp\utility::is_valid_player()) {
        _id_BE31E8030AEAE176 hide();
        self.scenenode scripts\cp_mp\anim_scene::anim_scene_stop(1);
        player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("anim_scene");
        player stopanimscriptsceneevent();
        player unlink();

        foreach(actor in actors) {
          actor.forceendscene = 1;

          if(isent(actor.player_rig))
            actor.player_rig hide();
        }

        thread _id_42F04B0131885759(player, _id_BE31E8030AEAE176);
        player notify("cut_failed");
        self notify("cut_finished", 0);
        return;
      }

      thread _id_42F04B0131885759(player, _id_BE31E8030AEAE176);
      self.scenenode scripts\cp_mp\anim_scene::anim_scene(actors, "saw_out", 0, 1);
      player forceusehintoff();
      player notify("cut_failed");
      self notify("cut_finished", 0);
      return;
    }

    thread _id_42F04B0131885759(player, _id_BE31E8030AEAE176);
    playsoundatpos(self.origin, "cp_saw_door_break");

    if(player scripts\cp\utility::is_valid_player()) {
      self.scenenode scripts\cp_mp\anim_scene::anim_scene(actors, "saw_out", 0, 1);
      player forceusehintoff();
    }

    self notify("cut_finished", 1);
    return;
  }
}

_id_67EEE84BAED1DE02(player, _id_46F432042B3473D8, objectiveindex) {
  player endon("last_stand");
  player endon("disconnect");

  if(!isDefined(self.cut_progress))
    self.cut_progress = 0;

  while(self.cut_progress <= _id_46F432042B3473D8 && player useButtonPressed() && player scripts\cp\utility::is_valid_player() && player getstance() == "stand" && player hasweapon("iw9_me_buzzsaw_mp")) {
    objective_setprogress(self.objectiveindex, self.cut_progress / _id_46F432042B3473D8);
    wait 0.05;
    self.cut_progress = self.cut_progress + 0.05;
  }

  return self.cut_progress >= _id_46F432042B3473D8;
}

_id_D9A8B633F287833C(playerent, console) {
  level endon("game_ended");
  _id_D8CC0613A4D4C3E1();

  if(!isDefined(console.scenenode)) {
    console.scenenode = spawnStruct();
    console.scenenode.origin = console.origin;
    console.scenenode.angles = console.angles;
  }

  animname = "plyr_cranecontrols_m";

  if(scripts\engine\utility::is_equal(playerent._id_938E8B2CA6549759, "farah"))
    animname = "plyr_cranecontrols_f";

  actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(playerent, animname, 1, 0);
  actorplayer scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1);
  actors = [actorplayer];
  actorplayer thread _id_5F326FA1B6B3EB5F();
  console scriptmodelplayanim(level.scr_anim["cranecontrols"]["crane_in"]);
  success = console.scenenode scripts\cp_mp\anim_scene::anim_scene(actors, "crane_in", 1, 0);

  if(istrue(success)) {
    console.scenenode thread scripts\cp_mp\anim_scene::anim_scene_loop(actors, "crane_idle", 0, 0);
    console scriptmodelplayanim(level.scr_anim["cranecontrols"]["crane_idle"][0]);

    while(istrue(playerent._id_BD0DA10D4E08DF86))
      waitframe();
  }

  console scriptmodelplayanim(level.scr_anim["cranecontrols"]["crane_out"]);
  console.scenenode scripts\cp_mp\anim_scene::anim_scene(actors, "crane_out", 0, 1);
  console scriptmodelclearanim();
  console.scenenode scripts\cp_mp\anim_scene::anim_scene_stop();

  if(isDefined(playerent))
    playerent._id_BD0DA10D4E08DF86 = undefined;
}

_id_5F326FA1B6B3EB5F() {
  self.entity endon("disconnect");
  wait 0.5;
  self.entity playerlinktoblend(self.player_rig, "tag_player", 0.2);
  wait 0.2;
  self.entity playerlinktodelta(self.player_rig, "tag_player", 1, 30, 30, 10, 0, 1, 0, 1);
  self.entity notify("oncrane");
}

_id_DEA2280D54F96878(actor) {
  self endon("cut_finished");
  actor.entity endon("last_stand");
  actor.entity endon("disconnect");
  wait 0.5;
  actor.entity playerlinktoblend(actor.player_rig, "tag_player", 0.2);
  wait 0.2;
  actor.entity playerlinktodelta(actor.player_rig, "tag_player", 1, 45, 45, 0, 0, 1, 0, 1);
}

_id_1A3A5E66BF63BEB5(button, _id_C103BFC366A53063, _id_F076B9BAF2E13623, _id_FADA7C861D5EDE93, _id_3D3C2619E235F17E, playerent) {
  level endon("game_ended");
  _id_8A879C8E46F826E6();
  button makeusable();
  button setHintString(_id_C103BFC366A53063);
  button sethintdisplayrange(256);
  button setCursorHint("HINT_BUTTON");
  button sethintdisplayfov(65);
  button setuserange(72);
  button sethintonobstruction("show");
  button setuseholdduration("duration_none");
  ent = undefined;

  if(!istrue(_id_3D3C2619E235F17E))
    ent = button _id_4EB04DEA142DC8EA(_id_F076B9BAF2E13623, _id_FADA7C861D5EDE93);

  if(isDefined(playerent))
    ent = playerent;

  ent scripts\engine\utility::delaythread(1.25, ::_id_8C533B43960E754E, button);
  scenenode = spawnStruct();
  scenenode.origin = button.origin;
  scenenode.angles = button.angles;
  actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(ent, "plyr_generic_btnpress", 1, 1);
  _id_54E38BC53ABC8A5E = scripts\cp_mp\anim_scene::anim_scene_create_actor(button, "btn_generic_btnpress", 0, 0);
  actorplayer scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1);
  actors = [actorplayer, _id_54E38BC53ABC8A5E];
  scenenode scripts\cp_mp\anim_scene::anim_scene(actors, "button_pressed", 1, 1);
  return ent;
}

_id_C63BF3F0A81ED015(button, _id_4D932CFABB42EEF4, _id_279A4854B51C5AF2, _id_C103BFC366A53063, _id_F076B9BAF2E13623, _id_FADA7C861D5EDE93, _id_3D3C2619E235F17E, playerent) {
  level endon("game_ended");
  _id_8A879C8E46F826E6();
  button makeusable();
  button setHintString(_id_C103BFC366A53063);
  button sethintdisplayrange(256);
  button setCursorHint("HINT_BUTTON");
  button sethintdisplayfov(65);
  button setuserange(72);
  button sethintonobstruction("show");
  button setuseholdduration("duration_none");
  ent = undefined;

  if(!istrue(_id_3D3C2619E235F17E))
    ent = button _id_4EB04DEA142DC8EA(_id_F076B9BAF2E13623, _id_FADA7C861D5EDE93);

  if(isDefined(playerent))
    ent = playerent;

  ent scripts\engine\utility::delaythread(1.25, ::_id_8C533B43960E754E, button);
  scenenode = spawnStruct();
  scenenode.origin = button.origin + _id_4D932CFABB42EEF4;
  scenenode.angles = button.angles + _id_279A4854B51C5AF2;
  _id_8D9CDE62396B2E2F = spawnStruct();
  _id_8D9CDE62396B2E2F.origin = button.origin;
  _id_8D9CDE62396B2E2F.angles = button.angles;
  actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(ent, "plyr_generic_btnpress", 1, 1);
  _id_54E38BC53ABC8A5E = scripts\cp_mp\anim_scene::anim_scene_create_actor(button, "btn_generic_btnpress", 0, 0);
  actorplayer scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1);
  actors = [actorplayer, _id_54E38BC53ABC8A5E];
  _id_8D9CDE62396B2E2F thread scripts\cp_mp\anim_scene::anim_scene([_id_54E38BC53ABC8A5E], "button_pressed", 1, 1);
  scenenode thread scripts\cp_mp\anim_scene::anim_scene([actorplayer], "button_pressed", 1, 1);
  return ent;
}

_id_8C533B43960E754E(button) {
  button playSound("scn_cp_elevator_button_press");
  button setModel("electrical_cell_door_button_green");
}

_id_F9020783100CB7B2(button, _id_C103BFC366A53063, _id_F076B9BAF2E13623, _id_FADA7C861D5EDE93) {
  level endon("game_ended");
  _id_F9F389DB8514931E();
  button makeusable();
  button setHintString(_id_C103BFC366A53063);
  button sethintdisplayrange(300);
  button setCursorHint("HINT_BUTTON");
  button sethintdisplayfov(65);
  button sethintonobstruction("show");
  button setuseholdduration("duration_none");
  button setuserange(72);
  ent = button _id_4EB04DEA142DC8EA(_id_F076B9BAF2E13623, _id_FADA7C861D5EDE93);
  actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(ent, "player_rig", 1, 1);
  _id_54E38BC53ABC8A5E = scripts\cp_mp\anim_scene::anim_scene_create_actor(button, "power_switch", 0, 0);
  actorplayer scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1);
  actors = [actorplayer, _id_54E38BC53ABC8A5E];
  button scripts\cp_mp\anim_scene::anim_scene(actors, "power_switch", 1, 1);
  return ent;
}

_id_ED19FACE30051E39(animnode, player) {
  level endon("game_ended");
  actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(player, "plyr_console", 1, 1);
  actorplayer scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1);
  animnode scripts\cp_mp\anim_scene::anim_scene([actorplayer], "use_console", 1, 1);
}

_id_10C5879993490882(_id_05CE5B54E58D14C5, player) {
  _id_6C7AFDA240D43C96();
  actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(player, "plyr_valve", 1, 1);
  _id_CDF199F06F0846F4 = scripts\cp_mp\anim_scene::anim_scene_create_actor(_id_05CE5B54E58D14C5, "water_valve");
  actorplayer scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1);
  _id_05CE5B54E58D14C5.actors = [actorplayer, _id_CDF199F06F0846F4];
}

_id_D6E97C6A6FDC6E79(_id_05CE5B54E58D14C5, player) {
  level endon("game_ended");

  if(istrue(_id_05CE5B54E58D14C5.inuse)) {
    return;
  }
  _id_05CE5B54E58D14C5.inuse = 1;
  _id_10C5879993490882(_id_05CE5B54E58D14C5, player);
  success = _id_05CE5B54E58D14C5.scenenode scripts\cp_mp\anim_scene::anim_scene(_id_05CE5B54E58D14C5.actors, "valve_in", 1, 0, undefined, 0.1, 0.5);

  if(!istrue(success))
    _id_05CE5B54E58D14C5.inuse = undefined;
}

_id_CC53845FCC73057D(_id_05CE5B54E58D14C5, player) {
  level endon("game_ended");

  if(!istrue(_id_05CE5B54E58D14C5.inuse))
    _id_D6E97C6A6FDC6E79(_id_05CE5B54E58D14C5, player);

  success = _id_05CE5B54E58D14C5.scenenode scripts\cp_mp\anim_scene::anim_scene(_id_05CE5B54E58D14C5.actors, "valve_turn", 0, 0);

  if(!istrue(success))
    _id_05CE5B54E58D14C5.inuse = undefined;
}

_id_0A81C37F3335FF7C(_id_05CE5B54E58D14C5, player) {
  level endon("game_ended");

  if(!istrue(_id_05CE5B54E58D14C5.inuse))
    _id_D6E97C6A6FDC6E79(_id_05CE5B54E58D14C5, player);

  success = _id_05CE5B54E58D14C5.scenenode scripts\cp_mp\anim_scene::anim_scene_loop(_id_05CE5B54E58D14C5.actors, "valve_idle_start", 0, 0);

  if(!istrue(success))
    _id_05CE5B54E58D14C5.inuse = undefined;
}

_id_288E76E30D6D3145(_id_05CE5B54E58D14C5, player) {
  level endon("game_ended");

  if(!istrue(_id_05CE5B54E58D14C5.inuse))
    _id_D6E97C6A6FDC6E79(_id_05CE5B54E58D14C5, player);

  success = _id_05CE5B54E58D14C5.scenenode scripts\cp_mp\anim_scene::anim_scene_loop(_id_05CE5B54E58D14C5.actors, "valve_idle_end", 0, 0);

  if(!istrue(success))
    _id_05CE5B54E58D14C5.inuse = undefined;
}

_id_2B01B713C450F5FA(_id_05CE5B54E58D14C5, player) {
  level endon("game_ended");

  if(!istrue(_id_05CE5B54E58D14C5.inuse)) {
    return;
  }
  _id_05CE5B54E58D14C5.scenenode scripts\cp_mp\anim_scene::anim_scene(_id_05CE5B54E58D14C5.actors, "valve_out", 0, 1);
  _id_05CE5B54E58D14C5.inuse = undefined;
}

_id_CEA1D99FB4716416(player) {
  _id_5B7AFD9AB30170A9();
  animnode = scripts\engine\utility::getclosest(player.origin, scripts\engine\utility::getStructArray("pump_animnode", "targetname"));
  animname = "plyr_pump_m";

  if(scripts\engine\utility::is_equal(player._id_938E8B2CA6549759, "farah"))
    animname = "plyr_pump_f";

  actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(player, animname, 1, 1);
  actorplayer scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1);
  return animnode scripts\cp_mp\anim_scene::anim_scene([actorplayer], "button_press", 1, 1);
}

_id_4EB04DEA142DC8EA(_id_F076B9BAF2E13623, _id_FADA7C861D5EDE93) {
  ent = undefined;

  for(;;) {
    self waittill("trigger", ent);

    if(!isDefined(ent) || !ent scripts\cp\utility::is_valid_player() || !ent isonground() || ent isjumping()) {
      continue;
    }
    self _meth_DFB78B3E724AD620(0);

    if(istrue(_id_F076B9BAF2E13623)) {
      if(!isDefined(_id_FADA7C861D5EDE93))
        _id_FADA7C861D5EDE93 = 256;

      if(scripts\cp\utility::are_all_players_nearby(self.origin, squared(_id_FADA7C861D5EDE93))) {
        break;
      }

      ent _id_382959D7794736CC::_id_AC901BAA09661D94(&"CP_RAID1_BOSS1/NEED_ALL_PLAYERS", 1);
      wait 1;
      self _meth_DFB78B3E724AD620(1);
      continue;
    } else
      break;
  }

  level notify("player_interaction_success", ent, self);

  if(!isDefined(ent))
    return undefined;

  return ent;
}

_id_370998C9375840D6(animnode, player) {
  level endon("game_ended");
  animname = "plyr_plantcharge_m";

  if(scripts\engine\utility::is_equal(player._id_938E8B2CA6549759, "farah"))
    animname = "plyr_plantcharge_f";

  actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(player, animname, 1, 1);
  actorplayer scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1);
  c4 = spawn("script_model", actorplayer.entity gettagorigin("tag_accessory_right"));
  c4 hide();
  c4.angles = actorplayer.entity gettagangles("tag_accessory_right");
  c4 dontinterpolate();
  c4 linkTo(actorplayer.entity, "tag_accessory_right");
  c4 setModel("offhand_2h_c4_prop_cp");
  thread _id_DABFDF04F879BC4F(c4);
  animnode thread _id_742848E1A6724249(c4, actorplayer);
  animnode thread _id_27535CB6C4FA2942(c4);
  success = animnode scripts\cp_mp\anim_scene::anim_scene([actorplayer], "plantcharge", 1, 1);
  return success;
}

_id_DABFDF04F879BC4F(c4) {
  c4 endon("death");
  wait 1.25;
  c4 show();
}

_id_742848E1A6724249(_id_3D2F2E482DCE39F5, actorplayer) {
  self endon("anim_scene_interrupted");
  _id_3D2F2E482DCE39F5 endon("death");
  wait 2.2;
  c4 = spawn("script_model", actorplayer.entity gettagorigin("tag_accessory_right"));
  c4.angles = actorplayer.entity gettagangles("tag_accessory_right");
  c4 setModel("offhand_2h_c4_prop_cp");
  level._id_912C14C780D793DE[level._id_912C14C780D793DE.size] = c4;
  _id_3D2F2E482DCE39F5 delete();
}

_id_27535CB6C4FA2942(c4) {
  self endon("anim_scene_success");
  self waittill("anim_scene_interrupted");
  c4 delete();
}

_id_EB4CDA8EB731276E(ent) {
  playsoundatpos(self.origin, "evt_raid3_crane_console_fly_loop_01");
}

_id_EB4CD98EB731253B(ent) {
  playsoundatpos(self.origin, "evt_raid3_crane_console_fly_loop_02");
}

_id_EB4CD88EB7312308(ent) {
  playsoundatpos(self.origin, "evt_raid3_crane_console_fly_loop_03");
}

_id_EB4CDF8EB731326D(ent) {
  playsoundatpos(self.origin, "evt_raid3_crane_console_fly_loop_04");
}

_id_EB4CDE8EB731303A(ent) {
  playsoundatpos(self.origin, "evt_raid3_crane_console_fly_loop_05");
}