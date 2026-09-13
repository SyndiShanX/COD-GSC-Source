/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_16591a48f7d6f223.gsc
***********************************************/

main() {
  level endon("game_ended");
  init_trap_room_vfx();
  setdvarifuninitialized("dvar_76B4B8CAEF956836", 1);
  setdvarifuninitialized("dvar_1C967BE13D082FDB", 1);
  level thread register_trap_room_objectives();
  level thread _id_3593E95C2FCFA407::register_spawn_modules();
  level _id_C45105D089BE3CD2();
  level _id_78547FBB6C0083E0::_id_27120F8531805439();
  _id_E490602DE087226F = getEntArray("platform_closed", "script_noteworthy");

  foreach(_id_36C12D04A03471D6 in _id_E490602DE087226F) {
    _id_2758AE319FD6A1AD = scripts\cp_mp\anim_scene::anim_scene_create_actor(_id_36C12D04A03471D6, "trap_platform");
    _id_36C12D04A03471D6 thread scripts\cp_mp\anim_scene::anim_scene([_id_2758AE319FD6A1AD], "close", 1, 0);
  }

  level._id_6A2EAC0EF4A956CB = _id_3593E95C2FCFA407::_id_4C0D9FDA8D7884E8;
  level thread _id_00A911FC5F1EACBA();
  level thread _id_81DDB99DF8CD0810();
}

register_trap_room_objectives() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("objective_table_parsed");
  scripts\cp\cp_objectives::registerobjective("trap_platforms", ::_id_C29141273CA988DE, ::_id_4503E2A24552B588, ::_id_638EEB4580A420FF, scripts\cp\cp_objectives::debugbeatobjective, undefined);
  scripts\cp\cp_objectives::registerobjective("trap_room", ::init_trap_room_obj, ::start_trap_room, ::complete_trap_room, scripts\cp\cp_objectives::debugbeatobjective, ::debug_trap_room);
  scripts\cp\cp_objectives::registerobjective("trap_room_final_wave", ::_id_6405E9DAABAEEF10, ::_id_A07E33B9FF9AC944, ::_id_99359A860F9AD52D, scripts\cp\cp_objectives::debugbeatobjective, ::debug_trap_room);
  scripts\cp\cp_objectives::registerobjective("trap_room_enrage", ::_id_E2091120FCAB4150, ::_id_FCA343807C918EE2, ::_id_52F382FB42A8D58F, scripts\cp\cp_objectives::debugbeatobjective, ::debug_trap_room);
  scripts\cp\cp_objectives::registerobjective("trap_room_escape", ::_id_1447242A64C33AE7, ::_id_FC710C45BB7BC223, ::_id_25D085D6B4ACD8B2, scripts\cp\cp_objectives::debugbeatobjective, ::debug_trap_room);
}

#using_animtree("script_model");

_id_C45105D089BE3CD2() {
  level.scr_animtree["plyr_c4_door"] = #animtree;
  level.scr_anim["plyr_c4_door"]["front"] = % iw9_cp_raid2_c4_door_breach_front_plr;
  level.scr_animname["plyr_c4_door"]["front"] = "iw9_cp_raid2_c4_door_breach_front_plr";
  level.scr_eventanim["plyr_c4_door"]["front"] = "iw9_cp_raid2_c4_door_breach_front_plr";
  level.scr_anim["plyr_c4_door"]["left"] = % iw9_cp_raid2_c4_door_breach_left_plr;
  level.scr_animname["plyr_c4_door"]["left"] = "iw9_cp_raid2_c4_door_breach_left_plr";
  level.scr_eventanim["plyr_c4_door"]["left"] = "iw9_cp_raid2_c4_door_breach_left_plr";
  level.scr_anim["plyr_c4_door"]["right"] = % iw9_cp_raid2_c4_door_breach_right_plr;
  level.scr_animname["plyr_c4_door"]["right"] = "iw9_cp_raid2_c4_door_breach_right_plr";
  level.scr_eventanim["plyr_c4_door"]["right"] = "iw9_cp_raid2_c4_door_breach_right_plr";
  scripts\common\anim::addnotetrack_notify("plyr_c4_door", "spawn_c4", "plant_c4", "front");
  scripts\common\anim::addnotetrack_notify("plyr_c4_door", "spawn_c4", "plant_c4", "left");
  scripts\common\anim::addnotetrack_notify("plyr_c4_door", "spawn_c4", "plant_c4", "right");
  level.scr_animtree["plyr_c4_door_f"] = #animtree;
  level.scr_anim["plyr_c4_door_f"]["front"] = % iw9_cp_raid2_c4_door_breach_front_plr_female;
  level.scr_animname["plyr_c4_door_f"]["front"] = "iw9_cp_raid2_c4_door_breach_front_plr_female";
  level.scr_eventanim["plyr_c4_door_f"]["front"] = "iw9_cp_raid2_c4_door_breach_front_plr_female";
  level.scr_anim["plyr_c4_door_f"]["left"] = % iw9_cp_raid2_c4_door_breach_left_plr_female;
  level.scr_animname["plyr_c4_door_f"]["left"] = "iw9_cp_raid2_c4_door_breach_left_plr_female";
  level.scr_eventanim["plyr_c4_door_f"]["left"] = "iw9_cp_raid2_c4_door_breach_left_plr_female";
  level.scr_anim["plyr_c4_door_f"]["right"] = % iw9_cp_raid2_c4_door_breach_right_plr_female;
  level.scr_animname["plyr_c4_door_f"]["right"] = "iw9_cp_raid2_c4_door_breach_right_plr_female";
  level.scr_eventanim["plyr_c4_door_f"]["right"] = "iw9_cp_raid2_c4_door_breach_right_plr_female";
  scripts\common\anim::addnotetrack_notify("plyr_c4_door_f", "spawn_c4", "plant_c4", "front");
  scripts\common\anim::addnotetrack_notify("plyr_c4_door_f", "spawn_c4", "plant_c4", "left");
  scripts\common\anim::addnotetrack_notify("plyr_c4_door_f", "spawn_c4", "plant_c4", "right");
  level.scr_animtree["airlock_door"] = #animtree;
  level.scr_anim["airlock_door"]["open"] = % iw9_cp_raid2_airlock_door_open;
  level.scr_anim["airlock_door"]["open_idle"][0] = % iw9_cp_raid2_airlock_door_open_idle;
  level.scr_anim["airlock_door"]["close"] = % iw9_cp_raid2_airlock_door_close;
  level.scr_animname["airlock_door"]["open"] = "iw9_cp_raid2_airlock_door_open";
  level.scr_animname["airlock_door"]["open_idle"][0] = "iw9_cp_raid2_airlock_door_open_idle";
  level.scr_animname["airlock_door"]["close"] = "iw9_cp_raid2_airlock_door_close";
  level.scr_animtree["plyr_gasfan_f"] = #animtree;
  level.scr_anim["plyr_gasfan_f"]["right"] = % iw9_cp_raid2_gas_console_plr_right_female;
  level.scr_animname["plyr_gasfan_f"]["right"] = "iw9_cp_raid2_gas_console_plr_right_female";
  level.scr_eventanim["plyr_gasfan_f"]["right"] = "iw9_cp_raid2_gas_console_plr_right_female";
  level.scr_anim["plyr_gasfan_f"]["left"] = % iw9_cp_raid2_fan_console_plr_left_female;
  level.scr_animname["plyr_gasfan_f"]["left"] = "iw9_cp_raid2_fan_console_plr_left_female";
  level.scr_eventanim["plyr_gasfan_f"]["left"] = "iw9_cp_raid2_fan_console_plr_left_female";
  level.scr_animtree["plyr_gasfan_m"] = #animtree;
  level.scr_anim["plyr_gasfan_m"]["right"] = % iw9_cp_raid2_gas_console_plr_right_male;
  level.scr_animname["plyr_gasfan_m"]["right"] = "iw9_cp_raid2_gas_console_plr_right_male";
  level.scr_eventanim["plyr_gasfan_m"]["right"] = "iw9_cp_raid2_gas_console_plr_right_male";
  level.scr_anim["plyr_gasfan_m"]["left"] = % iw9_cp_raid2_fan_console_plr_left_male;
  level.scr_animname["plyr_gasfan_m"]["left"] = "iw9_cp_raid2_fan_console_plr_left_male";
  level.scr_eventanim["plyr_gasfan_m"]["left"] = "iw9_cp_raid2_fan_console_plr_left_male";
  level.scr_animtree["gas_console"] = #animtree;
  level.scr_animtree["fan_console"] = #animtree;
  level.scr_anim["gas_console"]["right"] = % iw9_cp_raid2_gas_console_knob_right;
  level.scr_anim["fan_console"]["left"] = % iw9_cp_raid2_fan_console_knob_left;
  level.scr_animname["gas_console"]["right"] = "iw9_cp_raid2_gas_console_knob_right";
  level.scr_animname["fan_console"]["left"] = "iw9_cp_raid2_fan_console_knob_left";
  level.scr_animtree["plyr_airlock"] = #animtree;
  level.scr_anim["plyr_airlock"]["use_console"] = % iw9_cp_raid2_airlock_computer;
  level.scr_animname["plyr_airlock"]["use_console"] = "iw9_cp_raid2_airlock_computer";
  level.scr_eventanim["plyr_airlock"]["use_console"] = "iw9_cp_raid2_airlock_computer";
  level.scr_animtree["plyr_silo"] = #animtree;
  level.scr_anim["plyr_silo"]["button_pressed"] = % iw9_cp_raid2_silo_door_console_plr;
  level.scr_animname["plyr_silo"]["button_pressed"] = "iw9_cp_raid2_silo_door_console_plr";
  level.scr_eventanim["plyr_silo"]["button_pressed"] = "iw9_cp_raid2_silo_door_console_plr";
  level.scr_animtree["silo_button"] = #animtree;
  level.scr_anim["silo_button"]["button_pressed"] = % iw9_cp_raid2_silo_door_console_button;
  level.scr_animname["silo_button"]["button_pressed"] = "iw9_cp_raid2_silo_door_console_button";
  level.scr_animtree["plyr_valve_m"] = #animtree;
  level.scr_anim["plyr_valve_m"]["fire_off"] = % iw9_cp_raid2_extinguisher_valve_turn_plr_male;
  level.scr_animname["plyr_valve_m"]["fire_off"] = "iw9_cp_raid2_extinguisher_valve_turn_plr_male";
  level.scr_eventanim["plyr_valve_m"]["fire_off"] = "iw9_cp_raid2_extinguisher_valve_turn_plr_male";
  level.scr_anim["plyr_valve_m"]["steam_off"] = % iw9_cp_raid2_steam_valve_turn_off_plr_female;
  level.scr_animname["plyr_valve_m"]["steam_off"] = "iw9_cp_raid2_steam_valve_turn_off_plr_female";
  level.scr_eventanim["plyr_valve_m"]["steam_off"] = "iw9_cp_raid2_steam_valve_turn_off_plr_female";
  level.scr_animtree["plyr_valve_f"] = #animtree;
  level.scr_anim["plyr_valve_f"]["fire_off"] = % iw9_cp_raid2_extinguisher_valve_turn_plr_female;
  level.scr_animname["plyr_valve_f"]["fire_off"] = "iw9_cp_raid2_extinguisher_valve_turn_plr_female";
  level.scr_eventanim["plyr_valve_f"]["fire_off"] = "iw9_cp_raid2_extinguisher_valve_turn_plr_female";
  level.scr_anim["plyr_valve_f"]["steam_off"] = % iw9_cp_raid2_steam_valve_turn_off_plr_female;
  level.scr_animname["plyr_valve_f"]["steam_off"] = "iw9_cp_raid2_steam_valve_turn_off_plr_female";
  level.scr_eventanim["plyr_valve_f"]["steam_off"] = "iw9_cp_raid2_steam_valve_turn_off_plr_female";
  level.scr_animtree["fire_valve"] = #animtree;
  level.scr_anim["fire_valve"]["fire_off"] = % iw9_cp_raid2_extinguisher_valve_turn;
  level.scr_animname["fire_valve"]["fire_off"] = "iw9_cp_raid2_extinguisher_valve_turn";
  level.scr_anim["fire_valve"]["reset"] = % iw9_cp_raid2_extinguisher_valve_reset;
  level.scr_animname["fire_valve"]["reset"] = "iw9_cp_raid2_extinguisher_valve_reset";
  level.scr_animtree["steam_valve"] = #animtree;
  level.scr_anim["steam_valve"]["steam_off"] = % iw9_cp_raid2_steam_valve_turn_off;
  level.scr_animname["steam_valve"]["steam_off"] = "iw9_cp_raid2_steam_valve_turn_off";
  level.scr_anim["steam_valve"]["reset"] = % iw9_cp_raid2_steam_valve_turn_reset;
  level.scr_animname["steam_valve"]["reset"] = "iw9_cp_raid2_steam_valve_turn_reset";
}

init_trap_room_vfx() {
  level._effect["trap_room_lasers"] = loadfx("vfx/iw8_cp/vfx_cp_trap_room_laser.vfx");
  level._effect["vfx_cp_raid_trap_room_gas"] = loadfx("vfx/iw8_cp/raid/vfx_cp_raid_trap_room_gas.vfx");
}

get_trap_room_spawnpoints() {
  return _id_6425D54AF3CD5A44::getassignedspawnpoint(scripts\engine\utility::getStructArray("trap_room_spawners", "targetname"));
}

_id_6341E2983505A5AD(downed_player) {
  if(istrue(downed_player._id_36468B38F0FF4BA6)) {
    _id_4C2A5BC6ECA4173A = scripts\engine\utility::getStruct("dogtag_trap_respawn", "targetname");
    downed_player._id_36468B38F0FF4BA6 = undefined;
    return _id_4C2A5BC6ECA4173A;
  } else {
    _id_28D4A609D75FADF2 = spawnStruct();
    _id_28D4A609D75FADF2.origin = downed_player.origin;
    _id_28D4A609D75FADF2.angles = (0, 0, 0);
    return _id_28D4A609D75FADF2;
  }
}

trap_room_dogtag_revive(downed_player) {
  downed_player endon("disconnect");
  _id_414DDA4CABF358AF = getEnt("trap_room", "targetname");
  _id_4C2A5BC6ECA4173A = downed_player.origin;

  if(ispointinvolume(downed_player.origin, _id_414DDA4CABF358AF)) {
    _id_4C2A5BC6ECA4173A = scripts\engine\utility::getStruct("dogtag_trap_respawn", "targetname").origin;
    downed_player._id_36468B38F0FF4BA6 = 1;
  }

  dogtag = spawn("script_model", _id_4C2A5BC6ECA4173A + (0, 0, 40));
  dogtag _id_0AFB7E332AEE4BF2::_id_C919AFEBF9FE06C4();
  downed_player.respawn_forcespawnorigin = _id_4C2A5BC6ECA4173A;

  if(isDefined(downed_player.angles))
    downed_player.respawn_forcespawnangles = downed_player.angles;
  else
    downed_player.respawn_forcespawnangles = (0, 0, 0);

  downed_player.dogtag = dogtag;
  downed_player.dogtag.owner = downed_player;
  _id_0AFB7E332AEE4BF2::makereviveicon(dogtag, downed_player, (1, 0, 0));
  dogtag thread _id_0AFB7E332AEE4BF2::revivetriggerthink(downed_player.team);
  dogtag thread _id_0AFB7E332AEE4BF2::endreviveonownerdeathordisconnect();
}

wait_in_spectate_for_time(dogtag) {
  self endon("disconnect");
  wait 5;
  self notify("force_bleed_out");
  self notify("last_stand_finished");
  self notify("instant_revive");
}

init_trap_room_traps() {
  level endon("game_ended");

  if(getdvarint("dvar_B60090127EFC2F43", 0) > 0) {
    return;
  }
  scripts\engine\utility::flag_wait("level_ready_for_script");
  scripts\engine\utility::flag_wait("cp_raid_complex_cs_trap_room_completed");
  level thread _id_F69E16FBDDAEE065();
  thread _id_3AAF21BF0A95EED4::_id_9C706E1E0C18C0A3("traproom_gas", "traproom_gas_trigger", undefined, undefined, ::_id_21F646F2859184F8, "raid_vent_gas");
  thread _id_3AAF21BF0A95EED4::_id_9C706E1E0C18C0A3("sidea_gas", "side_a_gas", "sidea_gas_fx", "sidea_gas_fx_linger");
  thread _id_3AAF21BF0A95EED4::_id_9C706E1E0C18C0A3("sideb_gas", "side_b_gas", "sideb_gas_fx", "sideb_gas_fx_linger");
  wait 1;
  _id_2998D1395ED3E462();
  scripts\engine\utility::flag_set("traps_initialized");
}

setup_target_anims() {
  register_script_model_animation("target_fall", %cp_raid_trap_room_target_fall, "cp_raid_trap_room_target_fall");
  register_script_model_animation("target_stand_up", %cp_raid_trap_room_target_stand_up, "cp_raid_trap_room_target_stand_up");
  register_script_model_animation("target_idle_down", %cp_raid_trap_room_target_idle_down, "cp_raid_trap_room_target_idle_down");
  register_script_model_animation("target_idle_up", %cp_raid_trap_room_target_idle_up, "cp_raid_trap_room_target_idle_up");
  register_script_model_animation("target_idle_up_forward", %cp_raid_trap_room_target_idle_up_forward, "cp_raid_trap_room_target_idle_up_forward");
  register_script_model_animation("target_idle_up_backward", %cp_raid_trap_room_target_idle_up_backward, "cp_raid_trap_room_target_idle_up_backward");
  register_script_model_animation("accordion_gate_open", %cp_raid_accordion_gate_open, "cp_raid_accordion_gate_open");
  register_script_model_animation("player_triggered_console", %cp_trap_console_off_prop, "cp_trap_console_off_prop");
}

register_script_model_animation(_id_CA85A0DE365C6A63, animation, animname) {
  level.scr_animtree[_id_CA85A0DE365C6A63] = #animtree;
  level.scr_animname[animname][_id_CA85A0DE365C6A63] = animname;
  level.scr_anim[animname][_id_CA85A0DE365C6A63] = animation;
}

_id_5736748AFD2D5223() {
  foreach(player in level.players)
  player scripts\cp\utility::allow_player_basejumping(0, "trap_platforms");
}

_id_C29141273CA988DE(objectivestruct) {
  scripts\engine\utility::flag_wait("level_ready_for_script");
  scripts\engine\utility::flag_set("cp_raid1_trap_plat_cs");
  scripts\engine\utility::flag_wait("cp_raid1_trap_plat_cs_completed");
  level._id_AD9B99883D277045 = "trap_platforms";
  level.default_player_spawns = "platform_player_start";
  _id_78547FBB6C0083E0::_id_1B674D5590FD9605();
  level._id_CF829458F676A8EF = 1;
  wait 1;
}

_id_4503E2A24552B588(objectivestruct) {
  level.enter_spectator_func = ::trap_room_dogtag_revive;
  level.force_respawn_location = ::_id_6341E2983505A5AD;
  level._id_A3E60D4FD52EFC95 = 1;
  _id_75DAA35A5A19AA29();
  _id_9B2F0ED66B9CE35B();
  _id_1B42BA40587C09A1();
  _id_5736748AFD2D5223();
  level notify("trap_platforms_objective_started");

  if(getdvarint("dvar_134E5199D41FFC91", 0) > 0)
    level thread _id_3593E95C2FCFA407::_id_03E12320A4B71A96();

  thread _id_95147F81CC6598F6();
  thread _id_38632D9C26C45D63();
  thread _id_2DC5B00040824BCF();
  thread _id_D3CDCA6007F725BF();
  thread _id_3593E95C2FCFA407::_id_5C7633E120166DAC("platforms_spawntrigger");
  thread _id_78547FBB6C0083E0::_id_E7098BD047B3A491("platform_seq_1");
  thread _id_78547FBB6C0083E0::_id_E7098BD047B3A491("platform_seq_2");
  thread _id_78547FBB6C0083E0::_id_E7098BD047B3A491("platform_seq_4");
  thread _id_78547FBB6C0083E0::_id_67DB0E8A3AABE16E();
  thread _id_78547FBB6C0083E0::_id_70197F8D0EA6E56A();
  thread _id_78547FBB6C0083E0::_id_E16C201CE8526768();
  thread _id_78547FBB6C0083E0::_id_15DE54CD8BAC80B4();
  thread _id_78547FBB6C0083E0::_id_DF73C5B842B650FE();
  thread _id_78547FBB6C0083E0::_id_CDA921070628E761();
  thread _id_78547FBB6C0083E0::_id_1C8CDFD35FDDBA98();
  thread _id_78547FBB6C0083E0::_id_2BA5B97B6AA3DCCC();
  thread _id_78547FBB6C0083E0::_id_7476C41BA9781C78();
  thread _id_78547FBB6C0083E0::_id_96759DD993A14C8E();
  thread _id_79823539CA298145::_id_B65BCB262597FB2B();
  thread _id_7CCFD1C780C9C158();
  thread _id_CBF69C2A4262D68C();
  thread _id_E5F8CEE084EAF1A7();
  thread _id_A69497FB557DFA9B();
  thread _id_5FE553EECB367184::_id_6CA33D6D1362E2ED("puddle_seq3", 1);
  thread _id_5FE553EECB367184::_id_6CA33D6D1362E2ED("plats_puddle", 1);
  _id_F1C12E7F5B714194 = getEntArray("intro_steam_valve", "targetname");

  foreach(_id_05CE5B54E58D14C5 in _id_F1C12E7F5B714194) {
    _id_05CE5B54E58D14C5 thread _id_2E3C207F7651DDEC::steam_valve_think();
    wait 0.5;
  }

  if(getdvarint("dvar_1CDD8235BDC1092D", 0) > 0)
    level thread _id_B53A1C085C4BC72F();

  level thread _id_87844A999F8A2DA5("rappel_exit_3_man_door");
  level thread _id_965FEEB6EA485E13();
  level thread _id_18AF78602B67B70C::_id_92233BCD56EA95C5("seq2_exit_door");
  level thread _id_18AF78602B67B70C::_id_92233BCD56EA95C5("seq4_exit_door");
  level waittill("trap_platforms_done");
}

_id_2DC5B00040824BCF() {
  level endon("game_ended");
  level endon("trap_platforms_done");
  level thread _id_8C1ECA7F0A760652("plat_seq1_end_trigger_first_contact", "plat_seq1_start_trigger");
  level thread _id_8C1ECA7F0A760652("plat_seq2_end_trigger_first_contact", "plat_seq2_start_trigger");
}

_id_8C1ECA7F0A760652(_id_53850ACA4B5352D8, _id_D3C6AA11473DCDC7) {
  level endon("game_ended");
  level endon("trap_platforms_done");
  level waittill(_id_53850ACA4B5352D8);
  _id_526D28D8642C8C69 = getEntArray("trap_plat_respawn_cp", "targetname");
  _id_3C37D125189D1A4D = getEntArray("trap_plat_teamrespawn_cp", "targetname");
  _id_526D28D8642C8C69 = scripts\cp\utility::array_merge(_id_526D28D8642C8C69, _id_3C37D125189D1A4D);

  foreach(trig in _id_526D28D8642C8C69) {
    if(isDefined(trig.script_flag) && trig.script_flag == _id_D3C6AA11473DCDC7) {
      trig delete();
      return;
    }
  }
}

_id_38632D9C26C45D63() {
  level endon("game_ended");
  level endon("trap_platforms_done");
  level thread _id_2BD9190D2F22660B("mx_cp_raid1_trap_jumppuzzle1", "plat_seq1_start_trigger_first_contact", "plat_seq2_end_trigger_first_contact");
  level thread _id_2BD9190D2F22660B("mx_cp_raid1_trap_jumppuzzle2", "plat_seq3_start_trigger_first_contact", "plat_seq3_end_trigger_first_contact");
}

_id_2BD9190D2F22660B(_id_F90E9A2E19CBCED8, _id_53850ACA4B5352D8, _id_44E306D53285E1F8) {
  level endon("Game_ended");
  level endon("trap_platforms_done");
  level waittill(_id_53850ACA4B5352D8);
  setmusicstate(_id_F90E9A2E19CBCED8);
  level waittill(_id_44E306D53285E1F8);
  _func_A3901A965FC1D7DD(_id_F90E9A2E19CBCED8);
}

_id_D3CDCA6007F725BF() {
  level endon("game_ended");
  level endon("trap_platforms_done");
  trigger = getEnt("bats_trigger", "script_noteworthy");

  if(!isDefined(trigger)) {
    return;
  }
  for(;;) {
    trigger waittill("trigger", player);

    if(isPlayer(player)) {
      scripts\engine\utility::exploder("raid_bats");
      return;
    }
  }
}

_id_E5F8CEE084EAF1A7() {
  level endon("game_ended");
  trigger = getEnt("rappel_fire_start", "script_noteworthy");

  for(;;) {
    trigger waittill("trigger", player);

    if(!isPlayer(player)) {
      waitframe();
      continue;
    }

    break;
  }

  _id_8CC78A9566E14CC6 = getEntArray("intro_fire_valve", "targetname");

  foreach(_id_05CE5B54E58D14C5 in _id_8CC78A9566E14CC6) {
    if(isDefined(_id_05CE5B54E58D14C5.target))
      _id_05CE5B54E58D14C5 thread _id_2E3C207F7651DDEC::steam_valve_think(2);

    wait 0.5;
  }
}

_id_7CCFD1C780C9C158() {
  level endon("game_ended");
  level endon("trap_platforms_done");
  trigger = getEnt("platform_start_marker", "targetname");

  if(isDefined(trigger)) {
    for(;;) {
      trigger waittill("trigger", player);

      if(isPlayer(player)) {
        break;
      }
    }
  }
}

_id_A69497FB557DFA9B() {
  level endon("game_ended");
  level endon("trap_platforms_done");

  for(;;) {
    msg = level scripts\engine\utility::waittill_any_return_2("set_combat_respawning", "set_traversal_respawning");

    if(msg == "set_combat_respawning")
      _id_75DAA35A5A19AA29();
    else
      _id_83E9ACC14FAA3B6B();

    waitframe();
  }
}

_id_83E9ACC14FAA3B6B() {
  level.enter_spectator_func = _id_78547FBB6C0083E0::_id_B3E9DBF35E59E979;
  level.getspawnpoint = _id_78547FBB6C0083E0::_id_04658A84663ABD3E;
  level.coop_gameshouldendfunc = _id_18AF78602B67B70C::_id_EDCE93CF6B7199A0;
  level._id_313F285051FA8329 = _id_18AF78602B67B70C::_id_EDCE93CF6B7199A0;
  level.all_players_skip_last_stand = 1;
  level.skip_nav_check_on_spectate_respawn = 1;
  level._id_3A0F2224B2310445 = 1;

  if(istrue(level._id_77F52E0CCB8547EB))
    thread scripts\cp\cp_gameskill::_id_06660798718EE459(1);

  scripts\cp\cp_gameskill::_id_0127B010126B6A90();

  foreach(player in level.players)
  player.shouldskiplaststand = 1;

  _id_18AF78602B67B70C::_id_08FF8C8BD1F7AA28("trap_plat_teamrespawn_cp");
  _id_18AF78602B67B70C::_id_55A28F2BA806FE97("trap_plat_respawn_cp");
  level._id_CF829458F676A8EF = 1;
  level._id_F4C8727CAC33C176 = 1;
  _id_5736748AFD2D5223();
  level._id_0E190575F56F40A5 = "traversal";

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
    thread _id_E856BBD1C59A41D6(0);
}

_id_75DAA35A5A19AA29() {
  level._id_C121AA6DC74CCE91 = undefined;
  level._id_7B098327E305F16D = undefined;
  level.modeplayerkilledspawn = _id_0AFB7E332AEE4BF2::playerkilledspawn;
  level.all_players_skip_last_stand = 0;
  level.player_respawn = undefined;
  level.coop_gameshouldendfunc = undefined;
  level._id_313F285051FA8329 = undefined;
  level.enter_spectator_func = _id_0AFB7E332AEE4BF2::enable_dogtag_revive;
  level.getspawnpoint = _id_0598E0C00C8151F7::getspawnpoint;
  level._id_920CBA4B7B32D2A9 = 1;
  level._id_3A0F2224B2310445 = 0;
  scripts\cp\cp_gameskill::_id_77E524F19EB4608F();

  foreach(player in level.players) {
    player.respawn_index = undefined;
    player.shouldskiplaststand = 0;
  }

  level._id_CF829458F676A8EF = undefined;
  level._id_F4C8727CAC33C176 = undefined;
  _id_5736748AFD2D5223();
  level._id_0E190575F56F40A5 = "combat";

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
    thread _id_E856BBD1C59A41D6(0);
}

_id_E856BBD1C59A41D6(_id_41D8BF229CF29051) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("hardmode_revive_tokens_setup_complete");
  scripts\cp\cp_gameskill::_id_3898E5F82C5C37DF(_id_41D8BF229CF29051);
}

_id_638EEB4580A420FF(objectivestruct) {
  _id_78547FBB6C0083E0::_id_78621CB99BCDFD8A();
  wait 1;
}

debug_trap_room(objectivestruct, _id_5DCDFD3A4EFF9961) {
  level endon("game_ended");
  wait 5;
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "trap_room_spawners");
}

init_trap_room_obj(objectivestruct, _id_5DCDFD3A4EFF9961) {
  level._id_AD9B99883D277045 = "trap_room";
  level.default_player_spawns = "trap_room_spawners";
  level thread _id_78547FBB6C0083E0::_id_1D1AB26375E861C0();
  level thread _id_CBF69C2A4262D68C(1);
  level thread init_trap_room();
  level thread init_trap_room_traps();
  _id_9B2F0ED66B9CE35B();
  scripts\engine\utility::flag_wait("level_ready_for_script");
  scripts\engine\utility::flag_set("cp_raid_complex_cs_trap_room");
  scripts\engine\utility::flag_wait("cp_raid_complex_cs_trap_room_completed");
  level thread _id_0C4367731DD539DA();
  level.getspawnpoint = ::get_trap_room_spawnpoints;
}

start_trap_room(objectivestruct, _id_5DCDFD3A4EFF9961) {
  thread _id_0A547E09B8B684DB();
  thread _id_5FE553EECB367184::_id_6CA33D6D1362E2ED("puddle_seq3", 1);

  if(!istrue(level._id_81D95BA69322AEA5)) {
    level thread _id_E39573C80E5D776E("breakout_wall_oldrooms", "c4door_oldroom");
    level thread _id_7F56CFA2EBAC33D4();
  }

  level thread _id_DDF1BBEAE2F56538();
  level thread _id_79823539CA298145::_id_B010B4375C28E3C1();
  _id_75DAA35A5A19AA29();
  level.enter_spectator_func = ::trap_room_dogtag_revive;
  level.force_respawn_location = ::_id_6341E2983505A5AD;
  level._id_A3E60D4FD52EFC95 = 1;
  level waittill("trap_room_complete");
}

_id_6405E9DAABAEEF10(objectivestruct, _id_5DCDFD3A4EFF9961) {
  level._id_AD9B99883D277045 = "trap_room";
  level.default_player_spawns = "trap_room_spawners";
  level._id_A3E60D4FD52EFC95 = 1;
  scripts\engine\utility::flag_wait("level_ready_for_script");
  scripts\engine\utility::flag_set("cp_raid_complex_cs_trap_room");
  scripts\engine\utility::flag_wait("cp_raid_complex_cs_trap_room_completed");
  level.force_respawn_location = ::_id_6341E2983505A5AD;
  level.getspawnpoint = _id_0598E0C00C8151F7::getspawnpoint;
  scripts\cp\cp_checkpoint::checkpoint_set("trap_room_final_wave");

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    _id_2E9261330FBCEC80 = scripts\engine\utility::getStructArray("trap_final_wave_spawners", "targetname");
    _id_0AFB7E332AEE4BF2::_id_79DDAC0EF09B8D0F(_id_2E9261330FBCEC80, 0);
  }
}

_id_A07E33B9FF9AC944(objectivestruct, _id_5DCDFD3A4EFF9961) {
  level endon("game_ended");
  scripts\cp\cp_objectives::_id_A245AA068AAD0C25(2);
  setomnvar("cp_objective_sub_2_index", 0);
  setomnvar("cp_objective_sub_count_2", -1);
  trigger = getEnt("final_wave_trigger", "script_noteworthy");

  for(;;) {
    trigger waittill("trigger", player);

    if(isPlayer(player)) {
      break;
    }

    waitframe();
  }

  _id_2A220EF4EA1FDDD5 = _id_3593E95C2FCFA407::_id_DEC3407B80682CF2("a");

  foreach(ai in _id_2A220EF4EA1FDDD5)
  ai kill();

  if(getdvarint("dvar_F0F10B52A800D290", 0) <= 0) {
    _id_3593E95C2FCFA407::_id_7A06712741326A05();
    wait 5;
  }

  _id_E6481949A9010C5D = gettime() + 120000;
  aicount = getaiarray("axis").size;
  _id_B24E9EB1E2C91D20 = 0;

  while(!istrue(_id_B24E9EB1E2C91D20) && gettime() <= _id_E6481949A9010C5D) {
    _id_B24E9EB1E2C91D20 = _id_A4380438139238E5();
    wait 2;
  }

  childthread _id_79823539CA298145::_id_B0E54597E03F3604();
}

_id_99359A860F9AD52D(objectivestruct, _id_5DCDFD3A4EFF9961) {}

_id_0A547E09B8B684DB() {
  level endon("game_ended");
  trigger = getEnt("trap_room_checkpoint", "targetname");

  if(isDefined(trigger)) {
    for(;;) {
      trigger waittill("trigger", player);

      if(!isPlayer(player)) {
        waitframe();
        continue;
      }

      break;
    }
  }

  scripts\cp\cp_checkpoint::checkpoint_set("trap_room");

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    _id_2E9261330FBCEC80 = scripts\engine\utility::getStructArray("trap_room_spawners", "targetname");
    _id_0AFB7E332AEE4BF2::_id_79DDAC0EF09B8D0F(_id_2E9261330FBCEC80, 0);
  }
}

_id_7F56CFA2EBAC33D4() {
  level endon("game_ended");
  _id_F25BED886FD05253 = scripts\engine\utility::getStruct("breakout_wall_oldrooms", "script_noteworthy");
  objectiveindex = scripts\cp\cp_objectives::requestworldid("trap_c4_breach");
  objective_setminimapiconsize(objectiveindex, "icon_regular");
  objective_setlabel(objectiveindex, &"CP_TRAP_ROOM/PLANT_C4_NO_NUMBER");
  objective_position(objectiveindex, _id_F25BED886FD05253.origin + (0, 0, 20));
  objective_setshowoncompass(objectiveindex, 1);
  objective_icon(objectiveindex, "icon_waypoint_objective_general");
  objective_state(objectiveindex, "current");
  objective_setplayintro(objectiveindex, 1);
  objective_setplayoutro(objectiveindex, 0);
  level waittill("breakout_wall_oldrooms_wall_blown");
  objective_delete(objectiveindex);
  scripts\cp\cp_objectives::freeworldid("trap_c4_breach");
}

complete_trap_room(objectivestruct) {}

_id_DDF1BBEAE2F56538() {
  level endon("game_ended");

  if(istrue(level._id_7B7C6C306C9E89A4)) {
    return;
  }
  level._id_7B7C6C306C9E89A4 = 1;

  if(getdvarint("dvar_AEE4E4BF022E7244", 1) <= 0) {
    return;
  }
  if(!scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    return;
  }
  struct = scripts\engine\utility::getStruct("velikan_spawnarea", "targetname");
  spawnfunc = _id_18A73A64992DD07D::registerambientgroup;
  [[spawnfunc]]("traproom_velikan", 1, 1, 1, 0.1, 0, "traproom_velikan", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("traproom_velikan", _id_266C399FB76E6719::_id_38084F83D390A611);
  [[spawnfunc]]("traproom_velikan2", 1, 1, 1, 0.1, 0, "traproom_velikan2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("traproom_velikan2", _id_266C399FB76E6719::_id_38084F83D390A611);
  [[spawnfunc]]("traproom_velikan3", 1, 1, 1, 0.1, 0, "traproom_velikan3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("traproom_velikan3", _id_266C399FB76E6719::_id_38084F83D390A611);
  [[spawnfunc]]("velikan_traproom_squad", 4, 4, 4, 0.1, 0, "velikan_traproom_squad", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("velikan_traproom_squad", _id_3593E95C2FCFA407::_id_81FCB63BC44A4463);
  wait 1;
  dist = 40000;

  while(!scripts\cp\utility::any_player_nearby(struct.origin, dist))
    wait 0.25;

  level._id_FF5EC32704BBC90A = thread _id_18A73A64992DD07D::run_spawn_module("traproom_velikan");
  level._id_E5AC2772A242802B = thread _id_18A73A64992DD07D::run_spawn_module("velikan_traproom_squad");
  wait 5;
  _id_7C7ACB9B77D6CC7B = 0;
  _id_9E4E2382CB40EAC2 = scripts\engine\utility::getStruct("traproom_velikan_bside", "targetname");
  _id_636C8575D7A7768B = 1000000;

  while(!scripts\cp\utility::any_player_nearby(_id_9E4E2382CB40EAC2.origin, _id_636C8575D7A7768B))
    wait 0.25;

  while(_id_7C7ACB9B77D6CC7B < 2) {
    foreach(player in level.players) {
      if(distancesquared(player.origin, _id_9E4E2382CB40EAC2.origin) <= _id_636C8575D7A7768B) {
        if(!istrue(player._id_774CF30931B25E52)) {
          player._id_774CF30931B25E52 = 1;
          _id_7C7ACB9B77D6CC7B = _id_7C7ACB9B77D6CC7B + 1;
        }
      }
    }

    wait 0.5;
  }

  wait(randomfloatrange(1, 5));
  level._id_593066CF68FB8628 = thread _id_18A73A64992DD07D::run_spawn_module("traproom_velikan2");
  wait(randomfloatrange(10, 20));
  level._id_593067CF68FB885B = thread _id_18A73A64992DD07D::run_spawn_module("traproom_velikan3");
}

_id_E2091120FCAB4150(objstruct) {}

_id_FCA343807C918EE2(objstruct) {
  wait 1;
  _id_E2EC899DAE6AA861 = getdvarint("dvar_4A7B03B14C029E47", 8);
  _id_B0449399AF03D221 = _id_E2EC899DAE6AA861 * 60;
  level thread scripts\cp\utility::objective_update("trap_room_enrage", _id_B0449399AF03D221, 30, 10, 1);
  level thread _id_FA78BC97633FCC99();
  level._id_54E9827205F4474F = level scripts\engine\utility::waittill_any_return_2("trap_room_complete", "trap_room_enraged");
  level thread scripts\cp\utility::objective_update("trap_room_enrage", 1, 1, 1, 1);
}

_id_52F382FB42A8D58F(objstruct) {
  if(isDefined(level._id_54E9827205F4474F) && level._id_54E9827205F4474F == "trap_room_enraged") {
    scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_TRAP_ROOM/GAS_ENRAGED", "allies", 10);
    thread _id_3E4C65BC79512515();
    wait 1;
    level thread[[level.endgame]]("axis", level.end_game_string_index["trap_gas_enraged"]);
  }
}

_id_1447242A64C33AE7(objstruct) {
  _id_75DAA35A5A19AA29();
  _id_107CB9038C5A7F98();

  foreach(player in level.players)
  player._id_36468B38F0FF4BA6 = undefined;

  level.force_respawn_location = ::_id_6341E2983505A5AD;
  level.enter_spectator_func = _id_0AFB7E332AEE4BF2::enable_dogtag_revive;
  level._id_A3E60D4FD52EFC95 = 1;
  _id_3AAF21BF0A95EED4::_id_9C706E1E0C18C0A3("sidea_gas", "side_a_gas", "sidea_gas_fx", "sidea_gas_fx_linger");
  _id_3AAF21BF0A95EED4::_id_9C706E1E0C18C0A3("sideb_gas", "side_b_gas", "sideb_gas_fx", "sideb_gas_fx_linger");
  scripts\cp\cp_checkpoint::checkpoint_set("trap_room_escape");

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    _id_2E9261330FBCEC80 = scripts\engine\utility::getStructArray("trap_escape_spawners", "targetname");
    _id_0AFB7E332AEE4BF2::_id_79DDAC0EF09B8D0F(_id_2E9261330FBCEC80, 0);
  }
}

_id_FC710C45BB7BC223(objstruct) {
  level thread _id_3593E95C2FCFA407::_id_5C7633E120166DAC("platforms_spawntrigger");
  level thread _id_3593E95C2FCFA407::_id_5C7633E120166DAC("outro_spawntrigger");
  wait 1;
  level thread _id_237CF63F0571ADD4();
  level thread _id_36A8C5D7AD75086E();
  level thread _id_4259EF11E5397D26::_id_E63A4681058E4596();
  wait 1;
  level thread _id_E39573C80E5D776E("breakout_wall_b", "c4door_b", 1);
  level thread _id_37A7B32044FF1030();
  level thread _id_EE236B85D5AD4751();
  wait 1;
  level thread _id_2342F39A2950FAFF();
  level thread _id_5CF22F751F678C8B();
  level thread _id_D16D995842D5A15C();
  level thread _id_79823539CA298145::_id_F345F7CE204CB664();
  level thread _id_54F7702029D163F8();
  wait 2;
  level waittill("trap_escape_finished");
  wait 0.5;
}

_id_25D085D6B4ACD8B2(objstruct) {
  index = 0;

  foreach(player in level.players) {
    if(!isalive(player) || player isspectatingplayer() || istrue(player.inlaststand)) {
      _id_0AFB7E332AEE4BF2::_id_7956D96AF822A9A3(player);
      starts = scripts\engine\utility::getStructArray("platform_final_airlock_spawners", "script_noteworthy");
      player setOrigin(starts[index].origin);
      index++;
    }

    player thread _id_6F1004E80B298892(1.0, player);
  }

  thread _id_D3CB8E66A665F324();
  wait 1.0;
  level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
}

_id_6F1004E80B298892(_id_BB6F264BF4547737, player) {
  player endon("disconnect");
  level endon("game_ended");
  player setsoundsubmix("fade_to_black_all_except_music_and_scripted5", _id_BB6F264BF4547737);
  wait 0.3;
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 1, 0.3);
  wait(_id_BB6F264BF4547737);
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 0);
}

_id_37A7B32044FF1030() {
  level endon("game_ended");
  scripts\engine\utility::exploder("raid_godray");
  level waittill("breakout_wall_b_wall_blown");
  scripts\engine\utility::stop_exploder("raid_godray");
}

_id_2342F39A2950FAFF() {
  level endon("game_ended");
  _id_D33994DAC40772A6 = getEnt("outro_gaswall_start", "script_noteworthy");
  _id_3AAF21BF0A95EED4::_id_653EBA3B129AEA0E("gas_wall", "gas_wall_");
  _id_78547FBB6C0083E0::_id_484F5447591913C5(_id_D33994DAC40772A6);
  _id_3AAF21BF0A95EED4::_id_6532A0C1B8B58A22("gas_wall", 180);
}

_id_36A8C5D7AD75086E() {
  level endon("game_ended");
  level waittill("breakout_wall_b_wall_blown");
  airlock = getEnt("outro_airlock_trigger", "script_noteworthy");
  _id_F6A4BA96EC94D880 = getEnt("final_airlock_button", "script_noteworthy");
  _id_F43D677258F780F3 = getEnt("outro_end_trigger", "script_noteworthy");
  _id_78547FBB6C0083E0::_id_484F5447591913C5(airlock);
  objectiveindex = scripts\cp\cp_objectives::requestworldid("trap_escape_obj");
  objective_setminimapiconsize(objectiveindex, "icon_regular");
  objective_setlabel(objectiveindex, &"CP_TRAP_ROOM/GET_TO_AIRLOCK");
  objective_position(objectiveindex, _id_F6A4BA96EC94D880.origin + (0, 0, 20));
  objective_setshowoncompass(objectiveindex, 1);
  objective_icon(objectiveindex, "icon_waypoint_objective_general");
  objective_state(objectiveindex, "current");
  objective_setplayintro(objectiveindex, 1);
  objective_setplayoutro(objectiveindex, 0);
  level waittill("final_airlock_door_opening");
  objective_delete(objectiveindex);
  scripts\cp\cp_objectives::freeworldid("trap_escape_obj");
}

_id_FA78BC97633FCC99() {
  level endon("game_ended");
  level endon("trap_room_complete");
  _id_E2EC899DAE6AA861 = getdvarint("dvar_4A7B03B14C029E47", 8);
  _id_B0449399AF03D221 = _id_E2EC899DAE6AA861 * 60;
  _id_427CA64CE0970C8E = 0;

  for(;;) {
    if(_id_427CA64CE0970C8E % 60 == 0)
      childthread _id_79823539CA298145::_id_9A72C3D82EAE10C7(_id_B0449399AF03D221 - _id_427CA64CE0970C8E);

    _id_427CA64CE0970C8E++;

    if(_id_427CA64CE0970C8E >= _id_B0449399AF03D221) {
      level notify("trap_room_enraged");
      return;
    }

    wait 1;
  }
}

_id_5CF22F751F678C8B() {
  level endon("game_ended");

  if(istrue(level._id_F7F0B9B847C0B8C2)) {
    return;
  }
  level._id_F7F0B9B847C0B8C2 = 1;

  if(getdvarint("dvar_FF8159B46C9F20A2", 1) <= 0) {
    return;
  }
  if(!scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    return;
  }
  level thread _id_D0A620941141A32A();
  level thread _id_D0A61F941141A0F7();
  level waittill("final_airlock_door_opening");
  level thread _id_746B6A89A2EA92F5::_id_8D5E27863A5831E9();
}

_id_D0A620941141A32A() {
  level endon("game_ended");
  level endon("final_airlock_door_opening");
  _id_07132F053DB6712D = scripts\engine\utility::getStructArray("drone_grenade_spawn_p_final", "targetname");
  struct = _id_07132F053DB6712D[0];
  dist = squared(2200);
  _id_7F281683902BC1F5 = squared(800);

  while(!scripts\cp\utility::any_player_nearby(struct.origin, dist))
    wait 1;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(struct.origin, _id_7F281683902BC1F5)) {
      return;
    }
    _id_60F7CB484EC61F6C = scripts\engine\utility::random(_id_07132F053DB6712D);
    drone = _id_746B6A89A2EA92F5::_id_AE2FF42BCA6D6DCC(_id_60F7CB484EC61F6C);
    drone waittill("death");
    wait 5;
  }
}

_id_D0A61F941141A0F7() {
  level endon("game_ended");
  level endon("final_airlock_door_opening");
  _id_07132F053DB6712D = scripts\engine\utility::getStructArray("drone_grenade_spawn_p_final2", "targetname");
  struct = _id_07132F053DB6712D[0];
  dist = squared(1100);
  _id_7F281683902BC1F5 = squared(400);

  while(!scripts\cp\utility::any_player_nearby(struct.origin, dist))
    wait 1;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(struct.origin, _id_7F281683902BC1F5)) {
      return;
    }
    _id_60F7CB484EC61F6C = scripts\engine\utility::random(_id_07132F053DB6712D);
    drone = _id_746B6A89A2EA92F5::_id_AE2FF42BCA6D6DCC(_id_60F7CB484EC61F6C);
    drone waittill("death");
    wait 5;
  }
}

_id_D16D995842D5A15C() {
  level endon("game_ended");

  if(istrue(level._id_7B3C2DB9D2DFED20)) {
    return;
  }
  level._id_7B3C2DB9D2DFED20 = 1;

  if(getdvarint("dvar_CE4BE14331AF9353", 1) <= 0) {
    return;
  }
  if(!scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    return;
  }
  _id_07132F053DB6712D = scripts\engine\utility::getStructArray("drone_grenade_spawn_p_final", "targetname");
  struct = _id_07132F053DB6712D[0];
  dist = squared(2500);

  while(!scripts\cp\utility::any_player_nearby(struct.origin, dist))
    wait 1;

  spawnfunc = _id_18A73A64992DD07D::registerambientgroup;
  [[spawnfunc]]("escape_velikan", 1, 1, 1, 0.1, 0, "escape_velikan", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("escape_velikan", ::_id_5C0F3030D75E6AB2);
  wait 1;
  level._id_B4AA294BD7CC4A41 = thread _id_18A73A64992DD07D::run_spawn_module("escape_velikan");
}

_id_5C0F3030D75E6AB2(group_name, func) {
  struct = scripts\engine\utility::getStruct("escape_velikan", "targetname");
  _id_9284CBA34E9BF9AE = scripts\engine\utility::getStruct(struct.target, "targetname");
  _id_18A73A64992DD07D::set_goal_pos(getclosestpointonnavmesh(_id_9284CBA34E9BF9AE.origin));
  _id_18A73A64992DD07D::set_goal_radius(int(_id_9284CBA34E9BF9AE.radius));
  self.script_origin_other = _id_9284CBA34E9BF9AE.origin;
  self._id_894D1167ACE5B58C = 1;
  scripts\common\utility::set_battlechatter(0);
  thread _id_5C1195C372A5EB56();
}

_id_5C1195C372A5EB56() {
  self endon("death");
  dist = 250000;

  while(!scripts\cp\utility::any_player_nearby(self.origin, dist))
    wait 1;

  self.script_origin_other = undefined;
  self._id_894D1167ACE5B58C = 0;
  thread _id_266C399FB76E6719::_id_38084F83D390A611();
}

init_trap_room() {
  level endon("game_ended");

  if(!isDefined(level.additional_laststand_weapon_exclusion))
    level.additional_laststand_weapon_exclusion = [];

  level.additional_laststand_weapon_exclusion[level.additional_laststand_weapon_exclusion.size] = makeweapon("gas_cough_heavy_mp");

  foreach(struct in scripts\engine\utility::getStructArray("nav_exclusion", "targetname"))
  struct.nav_obstacle = createnavobstaclebybounds(struct.origin, (struct.radius, struct.radius, 64), (0, 0, 0));

  scripts\engine\utility::flag_init("traps_initialized");
  scripts\engine\utility::flag_init("start_trap_room_combat");
  scripts\engine\utility::flag_init("trap_sequence_activated");
  scripts\engine\utility::flag_init("laser_trap_disabled");
  scripts\engine\utility::flag_init("gas_trap_disabled");
  scripts\engine\utility::flag_init("sentry_trap_disabled");
  scripts\engine\utility::flag_init("all_traps_disabled");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  setup_trap_consoles();
  thread _id_B386CF3CF0BB1D27();
  thread init_fan_blades();
  thread _id_F5A46878A79D02AA();
  level thread watch_for_player_entered_trap_room();
  level thread _id_61EC91709D97070B();
  level thread _id_3593E95C2FCFA407::_id_908561DCB5D29464();
  level thread _id_3593E95C2FCFA407::_id_648CA482C539FEA0();
}

_id_61EC91709D97070B() {
  level endon("game_ended");
  level endon("trap_room_complete");
  trigger = getEnt("trap_room_combat_start", "targetname");

  for(;;) {
    trigger waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    scripts\engine\utility::delaythread(2, _id_3593E95C2FCFA407::_id_C1E6B81F3E693135);
    return;
  }
}

_id_CBF69C2A4262D68C(_id_6D3C6056A9E7EED7) {
  level endon("game_ended");
  level notify("single_watch_for_flashlight_trigger");
  level endon("single_watch_for_flashlight_trigger");
  scripts\engine\utility::flag_wait("introscreen_over");
  scripts\engine\utility::flag_wait("level_ready_for_script");

  if(istrue(_id_6D3C6056A9E7EED7))
    scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  trigger = getEnt("oldroom_flashlights", "targetname");

  if(!isDefined(trigger)) {
    return;
  }
  for(;;) {
    foreach(player in level.players) {
      if(player istouching(trigger) && !istrue(player._id_4AAD4F06D972E6B2)) {
        player _id_435C3F85A3D06576::toggle_flashlight(1);
        continue;
      }

      if(!player istouching(trigger) && istrue(player._id_4AAD4F06D972E6B2))
        player _id_435C3F85A3D06576::toggle_flashlight(0);
    }

    wait 2;
  }
}

setup_trap_consoles() {
  _id_AC6285400BB56750();
  level.trap_consoles = getEntArray("trap_console", "targetname");
  _id_15CA06DD9E32849E = getEntArray("side_a", "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.trap_consoles.size; _id_AC0E594AC96AA3A8++) {
    _id_A7E1A78C6A6C6307 = 0;

    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_15CA06DD9E32849E.size; _id_AC0E5C4AC96AAA41++) {
      if(ispointinvolume(level.trap_consoles[_id_AC0E594AC96AA3A8].origin, _id_15CA06DD9E32849E[_id_AC0E5C4AC96AAA41])) {
        _id_A7E1A78C6A6C6307 = 1;
        break;
      }
    }

    if(_id_A7E1A78C6A6C6307) {
      level.trap_consoles[_id_AC0E594AC96AA3A8] setModel("electronics_security_operations_console_a_on");
      level.trap_consoles[_id_AC0E594AC96AA3A8]._id_B71FD8467F451E88 = "electronics_security_operations_console_a";
      level.trap_consoles[_id_AC0E594AC96AA3A8]._id_68F3FAEEFCD00AD6 = "electronics_security_operations_console_a_on";
      continue;
    }

    level.trap_consoles[_id_AC0E594AC96AA3A8] setModel("electronics_security_operations_console_b_on");
    level.trap_consoles[_id_AC0E594AC96AA3A8]._id_B71FD8467F451E88 = "electronics_security_operations_console_b";
    level.trap_consoles[_id_AC0E594AC96AA3A8]._id_68F3FAEEFCD00AD6 = "electronics_security_operations_console_b_on";
  }
}

_id_AC6285400BB56750() {
  _id_8402078F777D6909("player_triggered_console", %cp_trap_console_off_player, "cp_trap_console_off_player");
  level.scr_eventanim["cp_trap_console_off_player"]["player_triggered_console"] = "player_triggered_console";
}

#using_animtree("generic_human");

_id_8402078F777D6909(_id_CA85A0DE365C6A63, animation, animname) {
  level.scr_animtree[_id_CA85A0DE365C6A63] = #animtree;
  level.scr_animname[animname][_id_CA85A0DE365C6A63] = animname;
  level.scr_anim[animname][_id_CA85A0DE365C6A63] = animation;
  level.scr_viewmodelanim[animname][_id_CA85A0DE365C6A63] = animation;
}

_id_E92B4CEEDE125AE7(_id_9CB3AB5121831D50) {
  player_count = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_9CB3AB5121831D50.size; _id_AC0E5C4AC96AAA41++) {
      if(level.players[_id_AC0E594AC96AA3A8] istouching(_id_9CB3AB5121831D50[_id_AC0E5C4AC96AAA41])) {
        player_count++;
        break;
      }
    }
  }

  return player_count;
}

_id_A37CD934088F6BD0() {
  level endon("trap_room_complete");
  level endon("game_ended");
  _id_81503EDD3735B37B = getEntArray("side_b", "targetname");

  for(;;) {
    _id_EC4DE51D2485D6A9 = 1;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      _id_805F35E184305FCD = 0;

      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_81503EDD3735B37B.size; _id_AC0E5C4AC96AAA41++) {
        if(level.players[_id_AC0E594AC96AA3A8] istouching(_id_81503EDD3735B37B[_id_AC0E5C4AC96AAA41])) {
          _id_805F35E184305FCD = 1;
          break;
        }
      }

      if(!istrue(_id_805F35E184305FCD)) {
        _id_EC4DE51D2485D6A9 = 0;
        break;
      }
    }

    if(istrue(_id_EC4DE51D2485D6A9))
      return;
    else
      wait 0.25;
  }
}

watch_for_player_entered_trap_room() {
  level endon("game_ended");
  level endon("trap_room_complete");
  scripts\engine\utility::flag_init("any_player_in_trap_room");
  _id_3593E95C2FCFA407::_id_B3FD2845FD414E11(2);
  _id_414DDA4CABF358AF = getEnt("trap_room", "targetname");

  if(isDefined(_id_414DDA4CABF358AF)) {
    for(;;) {
      _id_D1A187C382257293 = 0;

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
        triggering_ent = level.players[_id_AC0E594AC96AA3A8];

        if(triggering_ent istouching(_id_414DDA4CABF358AF) && triggering_ent scripts\cp\utility::is_valid_player(1)) {
          _id_D1A187C382257293 = 1;
          scripts\engine\utility::flag_clear("trap_sequence_activated");

          if(!scripts\engine\utility::flag("any_player_in_trap_room")) {
            scripts\engine\utility::flag_set("any_player_in_trap_room");

            if(!scripts\cp\cp_objectives::is_objective_active("trap_room_enrage"))
              thread scripts\cp\cp_objectives::run_objective("trap_room_enrage");
          }
        }
      }

      if(!_id_D1A187C382257293)
        scripts\engine\utility::flag_clear("any_player_in_trap_room");

      wait 0.25;
    }
  }
}

_id_0C4367731DD539DA() {
  level endon("game_ended");

  if(getdvarint("dvar_CA0F7A9EAE7CD4CC", 0) > 0) {
    return;
  }
  wait 3;
  _id_A37CD934088F6BD0();
  wait 5;
  level._id_D017B9C13EC2BB69 = undefined;
  level notify("trap_room_complete");
}

_id_A4380438139238E5() {
  _id_2A220BF4EA1FD73C = _id_3593E95C2FCFA407::_id_DEC3407B80682CF2("b");

  foreach(ai in _id_2A220BF4EA1FD73C) {
    if(ai scripts\cp\utility::isjuggernaut())
      return 0;
  }

  return _id_2A220BF4EA1FD73C.size <= 3;
}

_id_EE236B85D5AD4751() {
  level endon("game_ended");
  _id_3AAF21BF0A95EED4::_id_653EBA3B129AEA0E("pre_gas_wall", "pre_gas_wall_");
  _id_F4602F48207975DE = getEnt("end_trap_room", "script_noteworthy");
  _id_7E36905D920EE4F6 = scripts\engine\utility::getStruct("outro_start_marker", "script_noteworthy");
  _id_51CADFDC1E9ABC18 = scripts\engine\utility::getStruct("breakout_wall_b", "script_noteworthy");
  level childthread _id_79823539CA298145::_id_00A9F1B83150E746();
  wait_for_players_near(_id_7E36905D920EE4F6.origin, 512, 1);
  objectiveindex = scripts\cp\cp_objectives::requestworldid("trap_room_exit");
  objective_setminimapiconsize(objectiveindex, "icon_regular");
  objective_setlabel(objectiveindex, &"CP_TRAP_ROOM/3MANWALL");
  objective_position(objectiveindex, _id_7E36905D920EE4F6.origin + (0, 0, 20));
  objective_setshowoncompass(objectiveindex, 1);
  objective_icon(objectiveindex, "icon_waypoint_objective_general");
  objective_state(objectiveindex, "current");
  objective_setplayintro(objectiveindex, 1);
  objective_setplayoutro(objectiveindex, 0);
  _id_78547FBB6C0083E0::_id_0E12022EA41CB33D(_id_F4602F48207975DE);
  level thread _id_E39573C80E5D776E("breakout_wall_a", "c4door_a");
  level waittill("breakout_wall_a_c4_used");

  if(getdvarint("dvar_F0F10B52A800D290", 0) <= 0)
    thread _id_18A73A64992DD07D::run_spawn_module("outrostart_t3");

  setmusicstate("mx_cp_raid1_trap_gaswall");
  thread _id_3AAF21BF0A95EED4::_id_6532A0C1B8B58A22("pre_gas_wall", 35);
  thread _id_3E4C65BC79512515();
  wait 2;
  level waittill("breakout_wall_a_wall_blown");
  wait 1;
  thread _id_79823539CA298145::_id_0F43A35048F4ADE0();
  objective_delete(objectiveindex);
  scripts\cp\cp_objectives::freeworldid("trap_room_exit");
}

wait_for_players_near(point, maxdist, _id_D12A341B40354143) {
  level endon("game_ended");
  count = 0;

  if(!isDefined(_id_D12A341B40354143))
    _id_D12A341B40354143 = level.players.size;

  while(count < _id_D12A341B40354143) {
    count = 0;

    foreach(player in level.players) {
      dist = distance2d(player.origin, point);

      if(dist < maxdist)
        count++;
    }

    wait 0.25;
  }
}

_id_54F7702029D163F8() {
  level endon("game_ended");
  thread _id_3AAF21BF0A95EED4::_id_9C706E1E0C18C0A3("sidea_gas", "side_a_gas", "sidea_gas_fx", "sidea_gas_fx_linger");
  thread _id_3AAF21BF0A95EED4::_id_9C706E1E0C18C0A3("sideb_gas", "side_b_gas", "sideb_gas_fx", "sideb_gas_fx_linger");
  _id_3593E95C2FCFA407::_id_E4E8395176F82C74("side_a", 2);
  _id_3E4C65BC79512515();
}

_id_F3493A61496A2C45(direction, _id_006796EE14E02833) {
  if(direction > 0) {
    _func_90FB4916AA7FD9F3("enum_26D53FEC7B246007");
    waitframe();
    _func_7C2E0421AA80F818("enum_26D536EC7B2450BC", int(_id_006796EE14E02833 * 1000 * 10));
  }

  if(direction < 0) {
    _func_90FB4916AA7FD9F3("enum_26D536EC7B2450BC");
    waitframe();
    _func_7C2E0421AA80F818("enum_26D53FEC7B246007", int(_id_006796EE14E02833 * 1000 * 10));
  }
}

_id_2998D1395ED3E462() {
  if(istrue(level._id_26396B92520392D7)) {
    return;
  }
  level notify("toxic_gas_activated");
  thread _id_3AAF21BF0A95EED4::_id_1F5D08BE8B7E5501("traproom_gas");
  level._id_26396B92520392D7 = 1;
  thread _id_F3493A61496A2C45(1, 0.5);
}

_id_3E4C65BC79512515() {
  if(istrue(level._id_18159FCD25FD648B)) {
    return;
  }
  level._id_18159FCD25FD648B = 1;

  foreach(player in level.players)
  thread scripts\cp\utility::playsoundtoplayer_safe("emt_alarm_power_button", player);

  level notify("traproom_enraged");
  thread _id_3AAF21BF0A95EED4::_id_1F5D08BE8B7E5501("sidea_gas");
  thread _id_3AAF21BF0A95EED4::_id_1F5D08BE8B7E5501("sideb_gas");
  wait 4;
  _id_D3CB8E66A665F324();
}

_id_893BFA9B819C4275() {
  if(!istrue(level._id_26396B92520392D7)) {
    return;
  }
  level notify("toxic_gas_deactivated");
  thread _id_3AAF21BF0A95EED4::_id_8E85F07351C72547("traproom_gas");
  level._id_26396B92520392D7 = 0;
  thread _id_F3493A61496A2C45(-1, 0.5);
}

_id_9553BBBE653D6B53() {
  keycard = self;
  _id_5C66A1D0D8E81C85 = "outro_keycard";
  objectiveindex = scripts\cp\cp_objectives::requestworldid(_id_5C66A1D0D8E81C85);
  objective_setminimapiconsize(objectiveindex, "icon_regular");
  objective_setlabel(objectiveindex, &"CP_TRAP_ROOM/PICK_KEYCARD");
  objective_position(objectiveindex, keycard.origin + (0, 0, 20));
  objective_setshowoncompass(objectiveindex, 1);
  objective_icon(objectiveindex, "icon_waypoint_objective_general");
  objective_state(objectiveindex, "current");
  objective_setplayintro(objectiveindex, 1);
  objective_setplayoutro(objectiveindex, 1);
  level thread _id_AA678EC497AB5B1B(keycard, objectiveindex);
}

_id_AA678EC497AB5B1B(keycard, objectiveindex) {
  level endon("game_ended");
  keycard makeusable();
  keycard setHintString(&"CP_TRAP_ROOM/PICK_KEYCARD");
  keycard setCursorHint("HINT_BUTTON");
  keycard sethintdisplayrange(200);
  keycard sethintdisplayfov(90);
  keycard setuserange(72);
  keycard setusefov(90);
  keycard sethintonobstruction("show");
  keycard setuseholdduration("duration_short");
  keycard _meth_DFB78B3E724AD620(1);

  for(;;) {
    keycard waittill("trigger", player);

    if(!isPlayer(player)) {
      waitframe();
      continue;
    }

    player thread scripts\cp\utility::playerplaypickupanim("iw9_ges_pickup");
    thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_6A6FCDCC9BBE2CB7");
    level notify("keycard_picked");
    player._id_F0EDB4E48F6D0393 = 1;
    level thread _id_108A3772022F7C07(player);
    wait 0.3;
    objective_delete(objectiveindex);
    keycard delete();
    return;
  }
}

_id_108A3772022F7C07(player) {
  level endon("game_ended");
  level endon("outro_keycard_used");
  player waittill("disconnect");

  foreach(player in level.players)
  player._id_F0EDB4E48F6D0393 = 1;
}

_id_E5E6760F4432038F(player, button) {
  level endon("game_ended");
  anim_array = [];

  if(isDefined(player)) {
    actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(player, "cp_trap_console_off_player", 1);
    actorplayer scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1, "cp_trap_console_off_player", 1);
    anim_array[anim_array.size] = actorplayer;
  }

  if(anim_array.size > 0 && isDefined(button.console))
    result = button.console scripts\cp_mp\anim_scene::anim_scene(anim_array, "player_triggered_console");
}

_id_D3CB8E66A665F324() {
  _id_FC9AC45209F959BB = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  foreach(enemy in _id_FC9AC45209F959BB)
  enemy kill();
}

_id_70C33B522935DB87(_id_125C4FD2FBF97B87) {
  level notify("start_trap_timer");
  level endon("start_trap_timer");
  level endon("game_ended");
  _id_34AEA439DAD5AEAA = _id_125C4FD2FBF97B87 * 1000;
  setomnvar("cp_detonation_timer", gettime() + _id_34AEA439DAD5AEAA);
  childthread _id_79823539CA298145::_id_5914153D9652CC82(_id_125C4FD2FBF97B87);
  wait(_id_125C4FD2FBF97B87 - 20);
  childthread _id_79823539CA298145::_id_5914153D9652CC82(20);
  wait 10;
  playsoundatpos(self.origin, "cp_raid2_gas_attack_countdown");
  _id_4259EF11E5397D26::_id_6A27C9C7590D9DA8(2);
  childthread _id_79823539CA298145::_id_5914153D9652CC82(10);
  thread _id_303E0C96CFF5468D();
  wait 1;

  for(_id_BE650BC3EC8FF6CE = 9; _id_BE650BC3EC8FF6CE > 1; _id_BE650BC3EC8FF6CE--) {
    playsoundatpos(self.origin, "cp_raid2_gas_attack_countdown");
    wait 1;
  }

  playsoundatpos(self.origin, "cp_raid2_gas_attack_countdown");
  wait 1;
  playsoundatpos(self.origin, "cp_raid2_gas_attack_alarm");
  self notify("reenable_console_interactions");
  level notify("traproom_gas_countdown_done");
}

_id_303E0C96CFF5468D() {
  wait 1;
  setmusicstate("mx_cp_raid1_trap_chamberend");
}

_id_9B2F0ED66B9CE35B() {
  if(!scripts\engine\utility::flag("cp_raid1_trap_plat_cs_completed")) {
    scripts\engine\utility::flag_set("cp_raid1_trap_plat_cs");
    scripts\engine\utility::flag_wait("cp_raid1_trap_plat_cs_completed");
  }

  if(istrue(level._id_102FD3491CDFC22C)) {
    return;
  }
  level._id_102FD3491CDFC22C = 1;

  if(getdvarint("dvar_16C27BD9C165F4D6")) {
    return;
  }
  weapons = [];
  _id_CDE2EC78F52F00F9 = makeweaponfromstring("iw9_ar_akilo105_mp+bp_tune1+ammo_545s+bar_ar_long_p04_akilo105+iw9_minireddot06_tall+laserbox_ads04+mag_ar_lgtxlarge_p04+pgrip_p04_akilo105+rec_akilo105+selectsemi_akilo+stock_ar_tactical_p04_akilo105");
  _id_CDE2E978F52EFA60 = makeweaponfromstring("iw9_ar_akilo_mp+ammo_762s+bar_ar_hvylong_p04_akilo+mag_ar_large_p04_akilo+pgrip_p04+rec_akilo+reflex04_tall+selectsemi_akilo+stock_ar_light_p04_akilo");
  _id_CDE2EA78F52EFC93 = makeweaponfromstring("iw9_ar_akilo74_mp+ammo_545s+bar_ar_short_p04+comp_ar_08+holotherm01+laserbox_ads04+mag_ar_lgtlarge_p04_akilo74+pgrip_p04+rec_akilo74+selectsemi_akilo+stock_ar_p04_akilo74");
  _id_CDE2EF78F52F0792 = makeweaponfromstring("iw9_lm_rkilo_mp+ammo_762s_db+bar_ar_hvylong_p04_rkilo+drum_lm_large_p04+laserbox_ads04+pgrip_p04+rec_rkilo+reflex02_tall+stock_lmg_p04_rkilo");
  _id_CDE2F078F52F09C5 = makeweaponfromstring("iw9_lm_rkilo_mp+ammo_762s_db+bar_ar_hvylong_p04_rkilo+drum_lm_large_p04+laserbox_ads04+pgrip_p04+rec_rkilo+reflex02_tall+stock_lmg_p04_rkilo");
  _id_CDE2ED78F52F032C = makeweaponfromstring("iw9_sm_aviktor_mp+ammo_9p+bar_sm_long_p04+grip_vertshort05+iw9_minireddot01_tall+iw9_selectsemi+laserbox_hip04+mag_sm_large_p04+pgrip_p04+rec_aviktor+stock_sm_p04_aviktor");
  _id_CDE2EE78F52F055F = makeweaponfromstring("iw9_sm_papa90_mp+ammo_5x28+barsil_sm_p07+lasercyl_hip04+grip_vert05+iw9_minireddot04_tall+iw9_rec_papa90+mag_sm_p07+pgrip_ass_p07+rail_sm_p07+stock_sm_light_p07");
  _id_CDE2F378F52F105E = makeweaponfromstring("iw9_sh_vecho_mp+ammo_12g+bar_sh_hvylong2_p04+bolt_p04+choke_sh04+mag_sh_p04+grip_vertshort07+iw9_minireddot01_tall+lasercyl_hip04+pgrip_p04_vecho+rec_vecho+stock_sh_light_p04_vecho");
  _id_CDE2F478F52F1291 = makeweaponfromstring("iw9_sh_mbravo_mp+ammo_12g_db_mbravo+bartube_sh_long_p13+beadiron_mbravo+choke_sh04+flashlight_cyl01+guard_p13+rec_mbravo+stock_sh_heavy_p13_mbravo+tube_6_12g_mbravo");
  _id_F90ED703365EBA0B = makeweaponfromstring("iw9_br_soscar14_mp+ammo_762n+bar_br_short_p18_soscar14+mag_br_large_p18+hybridtherm02+laserbox_ads04+rec_soscar14+selectauto_soscar+stockr_br_heavy_p18");
  _id_F90ED603365EB7D8 = makeweaponfromstring("iw9_dm_scromeo_mp+ammo_65cm+bar_sn_short_p05+grip_angled05+arscope_therm01+mag_sn_xlarge_p05+pgrip_p05+rec_scromeo+stock_ar_p05_scromeo");
  weapons = [_id_CDE2EC78F52F00F9, _id_CDE2E978F52EFA60, _id_CDE2EA78F52EFC93, _id_CDE2EF78F52F0792, _id_CDE2F078F52F09C5, _id_CDE2ED78F52F032C, _id_CDE2EE78F52F055F, _id_CDE2F378F52F105E, _id_CDE2F478F52F1291, _id_F90ED703365EBA0B, _id_F90ED603365EB7D8];
  _id_A13FD508CAD5931C = scripts\engine\utility::getStructArray("start_weapon", "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A13FD508CAD5931C.size; _id_AC0E594AC96AA3A8++) {
    _id_28A6B68460F4FD6B = _id_A13FD508CAD5931C[_id_AC0E594AC96AA3A8];
    weapon_object = undefined;

    if(!isDefined(_id_28A6B68460F4FD6B.weaponinfo)) {
      continue;
    }
    switch (_id_28A6B68460F4FD6B.weaponinfo) {
      case "ar_kastav_545":
        weapon_object = _id_CDE2EC78F52F00F9;
        break;
      case "ar_kastav_762":
        weapon_object = _id_CDE2E978F52EFA60;
        break;
      case "ar_kastav_74u":
        weapon_object = _id_CDE2EA78F52EFC93;
        break;
      case "lm_rpk":
        weapon_object = _id_CDE2EF78F52F0792;
        break;
      case "lm_hcr_56_hybrid":
        weapon_object = _id_CDE2F078F52F09C5;
        break;
      case "sm_vasnev_9k":
        weapon_object = _id_CDE2ED78F52F032C;
        break;
      case "sm_pdsw_528":
        weapon_object = _id_CDE2EE78F52F055F;
        break;
      case "sh_kv_broadside":
        weapon_object = _id_CDE2F378F52F105E;
        break;
      case "sh_bryson_800":
        weapon_object = _id_CDE2F478F52F1291;
        break;
      case "br_so_14":
        weapon_object = _id_F90ED703365EBA0B;
        break;
      case "dm_taqm":
        weapon_object = _id_F90ED603365EB7D8;
        break;
    }

    if(isDefined(weapon_object)) {
      if(getdvarint("dvar_BAC49DC689DDA280", 1))
        _id_28A6B68460F4FD6B _id_9655BF427A5ABDB8(undefined, weapon_object);
      else
        _id_28A6B68460F4FD6B _id_2531C3CE4182E7AA(undefined, weapon_object);

      continue;
    }
  }

  _id_D5ECF70A4D407B43 = scripts\engine\utility::getStructArray("start_offhand_struct", "targetname");
  _id_18AF78602B67B70C::level_offhand_spawn(_id_D5ECF70A4D407B43);
}

_id_9655BF427A5ABDB8(sweapon, _id_E6C13F566F945346) {
  if(!isDefined(_id_E6C13F566F945346))
    objweapon = makeweaponfromstring(sweapon);
  else
    objweapon = _id_E6C13F566F945346;

  sweapon = getcompleteweaponname(objweapon);
  _id_B8F5AC23CE0DFDE3 = spawn("weapon_" + sweapon, self.origin, 17);
  _id_B8F5AC23CE0DFDE3.angles = self.angles;
  _id_B8F5AC23CE0DFDE3 itemweaponsetammo(weaponclipsize(objweapon), weaponstartammo(objweapon));
  _id_B8F5AC23CE0DFDE3 thread _id_74502A9E0EF1F19C::watchweaponpickup(weaponclipsize(objweapon), weaponstartammo(objweapon));
  _id_B8F5AC23CE0DFDE3 thread _id_7BED63E134C9AE06(sweapon);

  if(!isDefined(level._id_ED9613A1460DC261))
    level._id_ED9613A1460DC261 = [];

  level._id_ED9613A1460DC261[level._id_ED9613A1460DC261.size] = _id_B8F5AC23CE0DFDE3;
  return _id_B8F5AC23CE0DFDE3;
}

_id_2531C3CE4182E7AA(sweapon, _id_E6C13F566F945346) {
  if(!isDefined(_id_E6C13F566F945346))
    objweapon = makeweaponfromstring(sweapon);
  else
    objweapon = _id_E6C13F566F945346;

  sweapon = getcompleteweaponname(objweapon);
  _id_B8F5AC23CE0DFDE3 = spawn("weapon_" + sweapon, self.origin, 17);
  _id_B8F5AC23CE0DFDE3.angles = self.angles;
  _id_B8F5AC23CE0DFDE3 itemweaponsetammo(weaponclipsize(objweapon), weaponstartammo(objweapon));
  _id_B8F5AC23CE0DFDE3 thread _id_74502A9E0EF1F19C::watchweaponpickup(weaponclipsize(objweapon), weaponstartammo(objweapon));
  _id_B8F5AC23CE0DFDE3 thread _id_7BED63E134C9AE06(sweapon);
  return _id_B8F5AC23CE0DFDE3;
}

_id_B53A1C085C4BC72F() {
  level endon("game_ended");
  level endon("trap_platforms_done");
  _id_733EBEE6FC41E4E6 = makeweaponfromstring("iw9_ar_akilo74_mp+ammo_545s|1+bar_ar_short_p04|1+comp_ar_08|3+ironsdefault_akilo74+laserbox_ads04|24+mag_ar_lgtlarge_p04_akilo74|1+pgrip_tac_p04|7+rec_akilo74|4+selectsemi_akilo+stock_ar_p04_akilo74|7");
  _id_F5E11FC2E4B8FBB9 = scripts\engine\utility::getStructArray("secretwpn", "targetname");

  foreach(_id_6A56A4079F195610 in _id_F5E11FC2E4B8FBB9) {
    sweapon = getcompleteweaponname(_id_733EBEE6FC41E4E6);
    _id_B8F5AC23CE0DFDE3 = spawn("weapon_" + sweapon, _id_6A56A4079F195610.origin, 17);
    _id_B8F5AC23CE0DFDE3.angles = _id_6A56A4079F195610.angles;
    _id_B8F5AC23CE0DFDE3 itemweaponsetammo(weaponclipsize(_id_733EBEE6FC41E4E6), weaponstartammo(_id_733EBEE6FC41E4E6));
    _id_B8F5AC23CE0DFDE3 thread _id_74502A9E0EF1F19C::watchweaponpickup(weaponclipsize(_id_733EBEE6FC41E4E6), weaponstartammo(_id_733EBEE6FC41E4E6));
    _id_B8F5AC23CE0DFDE3 thread _id_7BED63E134C9AE06(_id_733EBEE6FC41E4E6);
    level thread _id_FD123FFC502AB603(_id_B8F5AC23CE0DFDE3);
    level thread _id_79823539CA298145::_id_A39C97933985B5F4(_id_B8F5AC23CE0DFDE3);
  }
}

_id_FD123FFC502AB603(weapon) {
  level endon("game_ended");
  _id_0788A9C187362ABE = 0;

  while(!istrue(_id_0788A9C187362ABE)) {
    weapon waittill("trigger", player);

    if(isPlayer(player)) {
      _id_0788A9C187362ABE = 1;
      player thread _id_79823539CA298145::_id_FF078026D67B1A6B(weapon);
    }
  }

  foreach(player in level.players) {
    typeid = _func_96B7FC7E35353254("raids2_reward_weapon_blueprint_collect");
    scripts\cp\challenges_cp::_id_7D7322BF935AB06A(player, typeid);
    player setplayerdata("cp", "lastRaidClassifiedReward", "raids2_reward_weapon_blueprint_collect");
  }

  thread _id_CBAB17DA47218978();
}

_id_CBAB17DA47218978() {
  if(istrue(level._id_BE62B5BD7C6ECF0B)) {
    return;
  }
  level._id_BE62B5BD7C6ECF0B = 1;
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_TRAP_ROOM/SECRET_REWARD_SPLASH", "allies", 4);
}

_id_7BED63E134C9AE06(weaponobj) {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", player);

    if(isDefined(player) && isPlayer(player) && !istestclient(player))
      player _id_66122A002AFF5D57::_id_4172A10AE7CBDB41(weaponobj);
  }
}

_id_F5A46878A79D02AA() {
  _id_EB922F6D2C4004E3 = spawnStruct();
  _id_EB922F6D2C4004E3.buttons = [];
  _id_091DEC6EAD639A66 = getEntArray("trap_console", "targetname");
  _id_CB2025210AE0BD2F = getEntArray("traproom_main_door", "script_noteworthy");
  _id_883A3FB1C00212A2 = getEntArray("main_door_clip", "script_noteworthy");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_CB2025210AE0BD2F.size; _id_AC0E594AC96AA3A8++) {
    model = _id_CB2025210AE0BD2F[_id_AC0E594AC96AA3A8];
    clip = _id_883A3FB1C00212A2[_id_AC0E594AC96AA3A8];
    clip linkTo(model);
    model.animnode = spawnStruct();
    model.animnode.origin = model.origin;
    model.animnode.angles = model.angles;
    model.actor = scripts\cp_mp\anim_scene::anim_scene_create_actor(model, "airlock_door");
  }

  _id_EB922F6D2C4004E3._id_CB2025210AE0BD2F = _id_CB2025210AE0BD2F;
  buttons = scripts\engine\utility::getStructArray("traproom_door_button_1", "script_noteworthy");

  foreach(_id_EF0DA79BC6D64DC0 in buttons) {
    button = _id_18AF78602B67B70C::_id_683F024F53CEE760(_id_EF0DA79BC6D64DC0, &"CP_TRAP_ROOM/OPEN_DOOR", "tag_origin", undefined, 64, 512);
    _id_EB922F6D2C4004E3.buttons[_id_EB922F6D2C4004E3.buttons.size] = button;
    button.console = scripts\engine\utility::getclosest(button.origin, _id_091DEC6EAD639A66);
    button.animnode = scripts\engine\utility::getStruct(_id_EF0DA79BC6D64DC0.target, "targetname");
    button thread _id_88E737253E4220FE(button);
  }

  level._id_EB922F6D2C4004E3 = _id_EB922F6D2C4004E3;
  level thread _id_5CA9B826C9D2498F(_id_EB922F6D2C4004E3);
  level thread _id_72081F7FDF3D074B();
}

_id_72081F7FDF3D074B() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("scriptables_ready");
  _id_A5123F279AFA8209 = getEntArray("trap_room_door_monitor", "script_noteworthy");
  _id_DD41C7ADF515A925 = getEntArray("server_screen_a", "targetname");

  foreach(screen in _id_DD41C7ADF515A925)
  screen delete();

  foreach(monitor in _id_A5123F279AFA8209) {
    _id_B63531330F002351 = spawnscriptable("security_monitor_01_raid_trap", monitor.origin, monitor.angles);
    _id_B63531330F002351 setscriptablepartstate("screen", "bink1");
    monitor delete();
  }

  for(;;) {
    _func_CE942237D1ECA7D8("sp_sb_laptop");
    wait 20;
  }
}

_id_5CA9B826C9D2498F(_id_EB922F6D2C4004E3) {
  level endon("game_ended");
  level endon("finish_trap_room");
  _id_EB922F6D2C4004E3 endon("death");
  _id_E30448ABB2B25926 = getdvarint("dvar_1C967BE13D082FDB", 2);

  for(;;) {
    if(_id_02C33B816036AF34(_id_EB922F6D2C4004E3) >= _id_E30448ABB2B25926) {
      _id_13479A07340DCA47(_id_EB922F6D2C4004E3);
      level waittill("door_anim_complete");
      level notify("trap_console_activated");

      if(getdvarint("dvar_5FE4C69AB5463DD7", 0) > 0)
        wait 10;

      _id_4259EF11E5397D26::_id_E28646C2F17F9535(2);
      open_door(_id_EB922F6D2C4004E3);
      _id_22CE6E003F3E5F4D(_id_EB922F6D2C4004E3);
      _id_4259EF11E5397D26::_id_E28646C2F17F9535(1);
      continue;
    }

    waitframe();
  }
}

_id_88E737253E4220FE(button) {
  level endon("game_ended");
  button endon("disable_button");
  button endon("death");

  for(;;) {
    button._id_DF8DCC39FC051041 = 0;
    button waittill("trigger", player);

    if(!isPlayer(player)) {
      waitframe();
      continue;
    }

    level notify("vo_door_pressed", player);
    button._id_DF8DCC39FC051041 = 1;
    actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(player, "plyr_airlock", 1);
    player _id_3B64EB40368C1450::set("door_console", "damage", 0);
    player playSound("cp_raid2_airlock_computer_fly");
    button.animnode scripts\cp_mp\anim_scene::anim_scene([actorplayer], "use_console", 1, 1);
    player _id_3B64EB40368C1450::_id_462E6336A0DC84A8("door_console", "damage");
    level notify("door_anim_complete");
    button playSound("cp_raid2_fan_console_activated_beep");
    thread _id_3E368DFEC412AEB8();
    wait 4;
  }
}

open_door(_id_FB4D3F10B10F2765) {
  scripts\engine\utility::flag_set("vo_gasdoor_open");

  foreach(model in _id_FB4D3F10B10F2765._id_CB2025210AE0BD2F)
  thread _id_11D070770637EDAA(model);

  wait 5;
  close_door(_id_FB4D3F10B10F2765);
  scripts\engine\utility::flag_clear("vo_gasdoor_open");
}

_id_11D070770637EDAA(model, clip) {
  model.animnode scripts\cp_mp\anim_scene::anim_scene([model.actor], "open", 0, 0);
}

close_door(_id_FB4D3F10B10F2765) {
  foreach(model in _id_FB4D3F10B10F2765._id_CB2025210AE0BD2F)
  thread _id_12618C72455EB8B4(model);
}

_id_12618C72455EB8B4(model, clip) {
  model.animnode scripts\cp_mp\anim_scene::anim_scene([model.actor], "close", 0, 0);
}

_id_3E368DFEC412AEB8() {
  wait 1;
  setmusicstate("mx_cp_raid1_trap_chamberstart");
}

_id_B386CF3CF0BB1D27() {
  _id_91554E96494CE0A9 = scripts\engine\utility::getStructArray("hack_console_1", "script_noteworthy");
  _id_EA6A492A79307C10 = spawn("script_model", (0, 0, 0));
  _id_EA6A492A79307C10 setModel("tag_origin");
  _id_EA6A492A79307C10.buttons = [];
  _id_091DEC6EAD639A66 = getEntArray("trap_console", "targetname");

  foreach(_id_51E00DEAD921083B in _id_91554E96494CE0A9) {
    button = _id_18AF78602B67B70C::_id_683F024F53CEE760(_id_51E00DEAD921083B, &"CP_TRAP_ROOM/DISABLE_GAS", "tag_origin", undefined, 64, 512, "show", 120);
    button sethintdisplayfov(120);
    _id_EA6A492A79307C10.buttons[_id_EA6A492A79307C10.buttons.size] = button;
    button scripts\cp\cp_juggernaut::_id_91ED8C25C9B88686();
    button.console = scripts\engine\utility::getclosest(button.origin, _id_091DEC6EAD639A66);
    button thread _id_D6A4D80497D8F3C3(button);
  }

  level._id_EA6A492A79307C10 = _id_EA6A492A79307C10;
  _id_CE4AD8D11D92FD56(_id_EA6A492A79307C10);
  level thread _id_FDB0F8AFA8E9480B(_id_EA6A492A79307C10);
}

_id_D6A4D80497D8F3C3(button) {
  level endon("game_ended");
  button endon("death");

  for(;;) {
    button._id_DF8DCC39FC051041 = 0;
    button waittill("trigger", player);

    if(!isPlayer(player)) {
      waitframe();
      continue;
    } else if(!istrue(button._id_E60552DD6ABCC4AA)) {
      waitframe();
      level notify("vo_gas_cooldown_pressed", player);
      continue;
    }

    level notify("vo_gas_pressed", player);
    button._id_DF8DCC39FC051041 = 1;
    console = scripts\engine\utility::getclosest(button.origin, getEntArray("gasfan_console", "script_noteworthy"));

    if(scripts\engine\utility::is_equal(player._id_938E8B2CA6549759, "farah"))
      animname = "plyr_gasfan_f";
    else
      animname = "plyr_gasfan_m";

    actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(player, animname, 1);
    _id_CF3F507FDBDD8367 = scripts\cp_mp\anim_scene::anim_scene_create_actor(console, "gas_console");
    player _id_3B64EB40368C1450::set("gas_console", "damage", 0);
    player playSound("cp_raid2_vent_console_fly");
    console scripts\cp_mp\anim_scene::anim_scene([actorplayer, _id_CF3F507FDBDD8367], "right", 1, 1);
    player _id_3B64EB40368C1450::_id_462E6336A0DC84A8("gas_console", "damage");
    level notify("gas_anim_complete");
    level thread _id_7B8D38C9D14253A2("cp_raid2_fan_console_activated_beep");
    wait 4;
  }
}

_id_FDB0F8AFA8E9480B(_id_EA6A492A79307C10) {
  level endon("game_ended");
  level endon("finish_trap_room");
  level endon("cleanup_traproom_ents_started");
  _id_EA6A492A79307C10 endon("death");
  _id_E30448ABB2B25926 = getdvarint("dvar_1C967BE13D082FDB", 2);

  for(;;) {
    if(_id_02C33B816036AF34(_id_EA6A492A79307C10) >= _id_E30448ABB2B25926) {
      _id_FA351987D306AD2F(_id_EA6A492A79307C10);
      level waittill("gas_anim_complete");
      _id_893BFA9B819C4275();
      level notify("trap_console_activated");
      thread _id_F0D74B165E2D6FCC();
      _id_4259EF11E5397D26::_id_6A27C9C7590D9DA8(3);
      _id_928B160C136333A8 = 40;

      if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
        _id_928B160C136333A8 = getdvarint("dvar_48D3F7628B4A2DB9", 35);

      thread _id_1EC43ACE029020E6(_id_928B160C136333A8);
      _id_EA6A492A79307C10 thread _id_70C33B522935DB87(_id_928B160C136333A8);
      _id_EA6A492A79307C10 waittill("reenable_console_interactions");
      thread _id_2998D1395ED3E462();
      wait 20;
      _id_4259EF11E5397D26::_id_6A27C9C7590D9DA8(1);
      _id_CE4AD8D11D92FD56(_id_EA6A492A79307C10);
      level thread _id_7B8D38C9D14253A2("cp_raid2_fan_console_reset_beep");
      continue;
    }

    waitframe();
  }
}

_id_F0D74B165E2D6FCC() {
  wait 0.1;
  playsoundatpos((-281, 658, -534), "scn_raid2_gas_vent_activate");
  playsoundatpos((-1235, 626, -534), "scn_raid2_gas_vent_run");
  playsoundatpos((-1803, 648, -534), "scn_raid2_gas_vent_shudder");
}

init_fan_blades() {
  if(getdvarint("dvar_B60090127EFC2F43", 0) > 0) {
    _id_FD162409E2E6C1DC = getEntArray("fan_blades", "script_noteworthy");

    foreach(_id_EDC35C03E9099B16 in _id_FD162409E2E6C1DC)
    _id_EDC35C03E9099B16 delete();

    return;
  }

  _id_FD162409E2E6C1DC = getEntArray("fan_blades", "script_noteworthy");
  _id_091DEC6EAD639A66 = getEntArray("trap_console", "targetname");
  _id_17C8DEDD925BE429 = getEntArray("trap_room_fan_clip", "script_noteworthy");
  _id_30C6E37B83A53658 = scripts\engine\utility::getStructArray("fan_button", "script_noteworthy");
  buttons = [];
  _id_9FAB894FBA306F2A = _id_30C6E37B83A53658[0] scripts\engine\utility::spawn_tag_origin();

  foreach(_id_51E00DEAD921083B in _id_30C6E37B83A53658) {
    button = _id_18AF78602B67B70C::_id_683F024F53CEE760(_id_51E00DEAD921083B, &"CP_TRAP_ROOM/STOP_FANS", "tag_origin", undefined, 64, 512);
    button scripts\cp\cp_juggernaut::_id_91ED8C25C9B88686();
    button.console = scripts\engine\utility::getclosest(button.origin, _id_091DEC6EAD639A66);
    button thread _id_921FC9692502FADC(button);
    buttons[buttons.size] = button;
  }

  _id_9FAB894FBA306F2A.buttons = buttons;

  foreach(_id_EDC35C03E9099B16 in _id_FD162409E2E6C1DC) {
    _id_EDC35C03E9099B16.buttons = [];
    _id_EDC35C03E9099B16._id_B00FB16DEE5B40E7 = randomfloatrange(4, 5);
    _id_EDC35C03E9099B16._id_6A5C1D956EC59723 = randomfloatrange(0.3, 0.6);

    if(_id_17C8DEDD925BE429.size > 0)
      _id_EDC35C03E9099B16.clip = scripts\engine\utility::getclosest(_id_EDC35C03E9099B16.origin, _id_17C8DEDD925BE429);

    foreach(button in buttons) {
      _id_EDC35C03E9099B16.buttons[_id_EDC35C03E9099B16.buttons.size] = button;
      button._id_EDC35C03E9099B16 = _id_EDC35C03E9099B16;
    }

    _id_EDC35C03E9099B16 thread spin_fan_blades();
    wait 0.5;
  }

  level._id_9FAB894FBA306F2A = _id_9FAB894FBA306F2A;
  _id_9FAB894FBA306F2A thread _id_4A3E1C05FD004BA2(_id_9FAB894FBA306F2A, _id_FD162409E2E6C1DC);

  foreach(_id_6E863394B4EBF2C7 in _id_FD162409E2E6C1DC)
  _id_6E863394B4EBF2C7 thread _id_8568ACF25A919136();
}

_id_4A3E1C05FD004BA2(_id_E6078E4A848F04F5, _id_EE3EC1998020BF1F) {
  level endon("game_ended");
  _id_E6078E4A848F04F5 endon("death");

  for(;;) {
    if(_id_02C33B816036AF34(_id_E6078E4A848F04F5) >= 1) {
      _id_13479A07340DCA47(_id_E6078E4A848F04F5);
      level waittill("fans_anim_complete");
      level notify("trap_console_activated");
      thread _id_4259EF11E5397D26::_id_F3F4B8824C7FF680(2);
      level thread _id_26C874616B2E28DA("cp_raid2_fan_console_activated_beep");
      _id_31FC3E189175DA52 = scripts\engine\utility::random(_id_EE3EC1998020BF1F);
      _id_31FC3E189175DA52 notify("stop_fan_blade");
      _id_31FC3E189175DA52.current_speed = "slow";
      _id_31FC3E189175DA52._id_CE35BC0885F04F6A = 0;

      if(isDefined(_id_31FC3E189175DA52.clip))
        _id_31FC3E189175DA52.clip notsolid();

      level._id_ABA1FB7E45F15F7B = 1;
      _id_13479A07340DCA47(self);
      wait 15;
      _id_31FC3E189175DA52.current_speed = "quick";
      _id_31FC3E189175DA52._id_CE35BC0885F04F6A = 1;
      thread _id_D3F158F810FA9AF4(_id_31FC3E189175DA52);

      if(isDefined(_id_31FC3E189175DA52.clip))
        _id_31FC3E189175DA52.clip solid();

      level._id_ABA1FB7E45F15F7B = 0;
      thread _id_4259EF11E5397D26::_id_F3F4B8824C7FF680(1);
      _id_4EB3240418B348DE(_id_E6078E4A848F04F5);
      level thread _id_26C874616B2E28DA("cp_raid2_fan_console_reset_beep");
    }

    waitframe();
  }
}

_id_D3F158F810FA9AF4(_id_EDC35C03E9099B16) {
  level endon("game_ended");

  foreach(player in level.players) {
    if(distance2d(player.origin, _id_EDC35C03E9099B16.origin) <= 64)
      push_player(player, _id_EDC35C03E9099B16);
  }
}

push_player(player, _id_EDC35C03E9099B16) {
  _id_06A3A1033FFC2699 = anglesToForward(_id_EDC35C03E9099B16.angles);
  _id_06A3A1033FFC2699 = vectorNormalize(_id_06A3A1033FFC2699);
  _id_06A3A1033FFC2699 = _id_06A3A1033FFC2699 * 64;
  _id_06A3A1033FFC2699 = (_id_06A3A1033FFC2699[0], _id_06A3A1033FFC2699[1], 0);
  player setOrigin(player.origin + _id_06A3A1033FFC2699, 1);
  _id_EDC35C03E9099B16 playsoundtoplayer("evt_raid2_fans_block", player);
}

_id_8568ACF25A919136(_id_31FC3E189175DA52) {
  level endon("game_ended");
  level endon("cleanup_traproom_ents_started");
  self endon("death");

  for(;;) {
    self playLoopSound("cp_raid2_fans_lp");
    self waittill("stop_fan_blade");
    self playSound("cp_raid2_fans_shutdown");
    self stoploopsound("cp_raid2_fans_lp");
    wait 15;
    self playSound("cp_raid2_fans_startup");
    self playLoopSound("cp_raid2_fans_lp");
  }
}

_id_921FC9692502FADC(button) {
  level endon("game_ended");
  button endon("disable_button");
  button endon("death");

  for(;;) {
    button._id_DF8DCC39FC051041 = 0;
    button waittill("trigger", player);

    if(!isPlayer(player)) {
      waitframe();
      continue;
    }

    level notify("vo_fans_pressed", player);
    button._id_DF8DCC39FC051041 = 1;
    console = scripts\engine\utility::getclosest(button.origin, getEntArray("gasfan_console", "script_noteworthy"));

    if(scripts\engine\utility::is_equal(player._id_938E8B2CA6549759, "farah"))
      animname = "plyr_gasfan_f";
    else
      animname = "plyr_gasfan_m";

    actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(player, animname, 1);
    _id_CF3F507FDBDD8367 = scripts\cp_mp\anim_scene::anim_scene_create_actor(console, "fan_console");
    player _id_3B64EB40368C1450::set("fan_console", "damage", 0);
    player playSound("cp_raid2_vent_console_fly");
    console scripts\cp_mp\anim_scene::anim_scene([actorplayer, _id_CF3F507FDBDD8367], "left", 1, 1);
    player _id_3B64EB40368C1450::_id_462E6336A0DC84A8("fan_console", "damage");
    level notify("fans_anim_complete");
    wait 4;
  }
}

spin_fan_blades() {
  level endon("game_ended");
  level endon("cleanup_traproom_ents_started");
  thread _id_D733D8955B8F5F27(self._id_6A5C1D956EC59723, self._id_B00FB16DEE5B40E7, 5, 1);
}

_id_D733D8955B8F5F27(_id_6A5C1D956EC59723, _id_B00FB16DEE5B40E7, _id_D4E2D77BD72891CF, _id_12FB549A1FDD4CC2) {
  level endon("game_ended");
  level endon("pipe_room_done");
  level endon("cleanup_traproom_ents_started");
  _id_AF508DD08DFDEF7F = self.angles;
  self._id_CE35BC0885F04F6A = 0;
  _id_EA23EA0A721D136E = 360;
  self._id_0EBB06FE2C2E0F43 = _id_6A5C1D956EC59723;
  self.current_speed = "quick";
  self._id_CE35BC0885F04F6A = 1;

  for(;;) {
    self.angles = _id_AF508DD08DFDEF7F;

    if(self.current_speed == "slow")
      wait 15;

    if(self.current_speed == "quick") {
      self._id_CE35BC0885F04F6A = 1;
      _id_781FEF231F3CD60F = 8;
      _id_3798629785A66F97 = combineangles(_id_AF508DD08DFDEF7F, (0, 0, _id_EA23EA0A721D136E / _id_781FEF231F3CD60F));
      self rotateTo(_id_3798629785A66F97, self._id_0EBB06FE2C2E0F43 / _id_781FEF231F3CD60F, 0, 0);
      wait(self._id_0EBB06FE2C2E0F43 / _id_781FEF231F3CD60F);
      _id_781FEF231F3CD60F = 4;
      _id_3798629785A66F97 = combineangles(_id_3798629785A66F97, (0, 0, _id_EA23EA0A721D136E / _id_781FEF231F3CD60F));
      self rotateTo(_id_3798629785A66F97, self._id_0EBB06FE2C2E0F43 / _id_781FEF231F3CD60F, 0, 0);
      wait(self._id_0EBB06FE2C2E0F43 / _id_781FEF231F3CD60F);
      _id_781FEF231F3CD60F = 8;
      _id_3798629785A66F97 = combineangles(_id_3798629785A66F97, (0, 0, _id_EA23EA0A721D136E / _id_781FEF231F3CD60F));
      self rotateTo(_id_3798629785A66F97, self._id_0EBB06FE2C2E0F43 / _id_781FEF231F3CD60F, 0, 0);
      wait(self._id_0EBB06FE2C2E0F43 / _id_781FEF231F3CD60F);
      _id_781FEF231F3CD60F = 4;
      _id_3798629785A66F97 = combineangles(_id_3798629785A66F97, (0, 0, _id_EA23EA0A721D136E / _id_781FEF231F3CD60F));
      self rotateTo(_id_3798629785A66F97, self._id_0EBB06FE2C2E0F43 / _id_781FEF231F3CD60F, 0, 0);
      wait(self._id_0EBB06FE2C2E0F43 / _id_781FEF231F3CD60F);
      _id_781FEF231F3CD60F = 4;
      _id_3798629785A66F97 = combineangles(_id_3798629785A66F97, (0, 0, _id_EA23EA0A721D136E / _id_781FEF231F3CD60F));
      self rotateTo(_id_3798629785A66F97, self._id_0EBB06FE2C2E0F43 / _id_781FEF231F3CD60F, 0, 0);
      wait(self._id_0EBB06FE2C2E0F43 / _id_781FEF231F3CD60F);
    }
  }
}

_id_9A1D658CF210D131(button, _id_02D57D503E610999) {
  level endon("game_ended");
  _id_02D57D503E610999 endon("death");
  _id_9AF72BBDFDEACE5D = spawn("script_model", button.origin + (0, 0, 5));
  _id_9AF72BBDFDEACE5D setModel("tag_origin");
  _id_9AF72BBDFDEACE5D.angles = scripts\engine\utility::ter_op(isDefined(button.angles), button.angles, (0, 0, 0));
  waitframe();
  waitframe();
  playFXOnTag(level._effect["red_light"], _id_9AF72BBDFDEACE5D, "tag_origin");
  _id_02D57D503E610999 scripts\engine\utility::waittill_any_timeout_2(50, "stop_lights_vfx");
  _id_9AF72BBDFDEACE5D delete();
}

_id_13479A07340DCA47(_id_02D57D503E610999) {
  _id_02D57D503E610999 endon("death");

  foreach(button in _id_02D57D503E610999.buttons)
  button _meth_DFB78B3E724AD620(0);
}

_id_4EB3240418B348DE(_id_E6078E4A848F04F5) {
  foreach(button in _id_E6078E4A848F04F5.buttons)
  button _meth_DFB78B3E724AD620(1);
}

_id_22CE6E003F3E5F4D(door) {
  foreach(button in door.buttons)
  button _meth_DFB78B3E724AD620(1);
}

_id_CE4AD8D11D92FD56(_id_41DA9CD4C860E60D) {
  foreach(button in _id_41DA9CD4C860E60D.buttons) {
    button setHintString(&"CP_TRAP_ROOM/DISABLE_GAS");
    button._id_E60552DD6ABCC4AA = 1;
  }

  level notify("vo_gas_console_ready");
}

_id_FA351987D306AD2F(_id_41DA9CD4C860E60D) {
  foreach(button in _id_41DA9CD4C860E60D.buttons) {
    button._id_E60552DD6ABCC4AA = 0;
    button setHintString(&"CP_TRAP_ROOM/GAS_DISABLED");
  }
}

_id_02C33B816036AF34(_id_02D57D503E610999) {
  _id_02D57D503E610999 endon("death");
  buttonspressed = 0;

  foreach(button in _id_02D57D503E610999.buttons) {
    if(istrue(button._id_DF8DCC39FC051041))
      buttonspressed++;
  }

  return buttonspressed;
}

_id_0B238F204E31EF89() {
  level endon("pipe_room_done");

  if(!isDefined(self.target)) {
    return;
  }
  self._id_85CC286ED5BA0688 = getEnt(self.target, "targetname");

  for(;;) {
    self._id_85CC286ED5BA0688 waittill("trigger", player);

    if(self._id_CE35BC0885F04F6A) {
      player.shouldskipdeathsshield = 1;
      player dodamage(10000, self.origin, self._id_85CC286ED5BA0688, self._id_85CC286ED5BA0688, "MOD_TRIGGER_HURT");
    }

    wait 0.1;
  }
}

_id_F69E16FBDDAEE065() {
  _id_1BDCA2C14E960685 = ["puddle_a_1", "puddle_a_2", "puddle_a_3", "puddle_c_1", "puddle_c_2", "puddle_c_3"];

  foreach(group in _id_1BDCA2C14E960685) {
    _id_5FE553EECB367184::_id_6CA33D6D1362E2ED(group);
    waitframe();
  }

  _id_AA16D15B8384FD88 = getEntArray("puddle_b", "targetname");
  _id_5FE553EECB367184::_id_6CA33D6D1362E2ED("puddle_b_main", 0, _id_AA16D15B8384FD88);
}

_id_225337895D1215BC() {
  _id_5FE553EECB367184::_id_E570E7FCB1B057D5("puddle_a_1");
  _id_5FE553EECB367184::_id_E570E7FCB1B057D5("puddle_a_2");
  _id_5FE553EECB367184::_id_E570E7FCB1B057D5("puddle_a_3");
  _id_5FE553EECB367184::_id_E570E7FCB1B057D5("puddle_b_1");
  _id_5FE553EECB367184::_id_E570E7FCB1B057D5("puddle_c_1");
  _id_5FE553EECB367184::_id_E570E7FCB1B057D5("puddle_c_2");
  _id_5FE553EECB367184::_id_E570E7FCB1B057D5("puddle_c_3");
}

_id_1EC43ACE029020E6(_id_928B160C136333A8) {
  level endon("game_ended");
  thread _id_4ADDC751C82B7393();
  _id_1BDCA2C14E960685 = ["puddle_a_1", "puddle_a_2", "puddle_a_3", "puddle_c_1", "puddle_c_2"];

  foreach(_id_CDDF1005585A4C14 in _id_1BDCA2C14E960685)
  thread _id_5FE553EECB367184::_id_5ED33FE490E1736E(_id_CDDF1005585A4C14, 1);

  thread _id_5FE553EECB367184::_id_5ED33FE490E1736E("puddle_b_main", 1);
  level waittill("traproom_gas_countdown_done");
  wait 5;
  _id_26CD21282423A4C9();

  foreach(_id_CDDF1005585A4C14 in _id_1BDCA2C14E960685)
  thread _id_5FE553EECB367184::_id_D1DDBE614C354C9F(_id_CDDF1005585A4C14);
}

_id_4ADDC751C82B7393() {
  _id_D0B7811B6DDC9700 = ["steam_b_1", "steam_b_2", "steam_b_3", "steam_b_5"];

  foreach(group in _id_D0B7811B6DDC9700) {
    _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray(group, "targetname");
    _id_95BEE5745540FFFF = 10;

    if(randomfloat(100) <= _id_95BEE5745540FFFF) {
      continue;
    }
    _id_D436B1DA1BF36140 = scripts\engine\utility::random(_id_9E4E1482CB40C9C5);
    _id_5D99A225CB875DDA = scripts\engine\utility::getStructArray(_id_D436B1DA1BF36140.target, "targetname");

    foreach(struct in _id_5D99A225CB875DDA)
    struct thread _id_2E3C207F7651DDEC::steam_point_think();
  }
}

_id_26CD21282423A4C9() {
  level notify("stop_steam");
}

_id_237CF63F0571ADD4() {
  level endon("game_ended");
  _id_D5E3E7FF59379DBB = getEnt("airlock_entrance", "script_noteworthy");
  trigger = getEnt("outro_airlock_trigger", "script_noteworthy");
  _id_B75898C18B35C6A7 = getEntArray("final_airlock_left", "script_noteworthy");
  _id_5A1F55FE010F012C = getEntArray("final_airlock_right", "script_noteworthy");
  _id_339B5EC9D4FDCB60 = getEntArray("final_airlock_clip", "script_noteworthy");
  button = getEnt("final_airlock_button", "script_noteworthy");
  _id_13AAF746212BC225 = scripts\engine\utility::getStruct("final_airlock_hint", "script_noteworthy");
  _id_C5D3D8FF129F88BA = scripts\cp\utility::createhintobject(_id_13AAF746212BC225.origin, "HINT_BUTTON", undefined, &"CP_TRAP_ROOM/SHUT_AIRLOCK", undefined, "duration_short", "show");
  _id_78547FBB6C0083E0::_id_0E12022EA41CB33D(trigger);
  waitframe();
  level notify("vo_all_players_in_airlock");
  _id_C5D3D8FF129F88BA makeusable();
  _id_C5D3D8FF129F88BA _meth_DFB78B3E724AD620(1);

  for(;;) {
    _id_C5D3D8FF129F88BA waittill("trigger", player);

    if(isPlayer(player)) {
      _id_C5D3D8FF129F88BA _meth_DFB78B3E724AD620(0);
      level notify("vo_airlock_button_hit");
      thread _id_A857EF26EAEB6D9D(player, button);
      break;
    }
  }

  wait 3;
  level notify("final_airlock_door_opening");
  _id_D5E3E7FF59379DBB movez(110, 0.3, 0, 0);
  thread _id_690DFE62BA019D9B(1.7, (-5257, 130, -398), "cp_raid2_escape_airlock_door_open");

  foreach(_id_CD8BBB2551106912 in _id_B75898C18B35C6A7)
  _id_CD8BBB2551106912 _meth_431D6E8AB1FDC578(-110, 0.5, 0, 0);

  foreach(_id_CD8BBB2551106912 in _id_5A1F55FE010F012C)
  _id_CD8BBB2551106912 _meth_431D6E8AB1FDC578(110, 0.5, 0, 0);

  wait 0.5;
  level notify("trap_escape_finished");
}

_id_690DFE62BA019D9B(delay, position, alias) {
  level endon("game_ended");
  wait(delay);
  playsoundatpos(position, alias);
}

_id_E39573C80E5D776E(_id_34E17131001C3DE9, _id_E608E4A9B96FA5F6, _id_D18DC90864DC9BB9) {
  level endon("game_ended");
  _id_B9ABF8C9B08EA45F = getEntArray(_id_E608E4A9B96FA5F6, "script_noteworthy");
  _id_0FE5E08B6494785E = scripts\engine\utility::getStruct(_id_34E17131001C3DE9, "script_noteworthy");
  _id_FE941516E0961813 = scripts\engine\utility::getStructArray(_id_0FE5E08B6494785E.target, "targetname");
  _id_12BFE6D203B0CDF3 = [];
  _id_C5D3D8FF129F88BA = scripts\cp\utility::createhintobject(_id_0FE5E08B6494785E.origin, "HINT_BUTTON", undefined, &"CP_TRAP_ROOM/PLANT_C4", undefined, "duration_short", "show", 400, 180, 64, 40, undefined);
  _id_C5D3D8FF129F88BA.angles = _id_0FE5E08B6494785E.angles;
  _id_830905E5C2645826 = _id_34E17131001C3DE9 + "_c4_done";
  _id_CEBB22306F7A7C58 = _id_34E17131001C3DE9 + "_c4_used";
  childthread _id_1676C2F258C858B8(_id_C5D3D8FF129F88BA, 512, &"CP_TRAP_ROOM/BRING_PARTY_HERE", &"CP_TRAP_ROOM/PLANT_C4");
  _id_B975301B70104FD4 = [];

  for(;;) {
    interact = _id_FE941516E0961813[0];
    _id_C5D3D8FF129F88BA.origin = interact.origin;
    _id_C5D3D8FF129F88BA.angles = interact.angles;
    _id_C5D3D8FF129F88BA waittill("trigger", player);

    if(!isPlayer(player) || !istrue(_id_C5D3D8FF129F88BA._id_862279B9184C2295)) {
      continue;
    }
    level notify(_id_CEBB22306F7A7C58);
    level notify("vo_" + _id_CEBB22306F7A7C58, player);
    _id_B975301B70104FD4[_id_B975301B70104FD4.size] = player;
    _id_C5D3D8FF129F88BA makeusable();
    _id_C5D3D8FF129F88BA _meth_DFB78B3E724AD620(0);
    player _id_3B64EB40368C1450::set("c4_door", "damage", 0);
    animname = "plyr_c4_door";

    if(scripts\engine\utility::is_equal(player._id_938E8B2CA6549759, "farah"))
      animname = animname + "_f";

    animnode = scripts\engine\utility::getStruct(interact.target, "targetname");
    actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(player, animname, 1);
    c4 = spawn("script_model", actorplayer.entity gettagorigin("tag_accessory_right"));
    c4 hide();
    c4.angles = actorplayer.entity gettagangles("tag_accessory_right");
    c4 dontinterpolate();
    c4 linkTo(actorplayer.entity, "tag_accessory_right");
    c4 setModel("offhand_2h_c4_prop");
    thread _id_DABFDF04F879BC4F(c4);
    thread _id_742848E1A6724249(c4, animnode);
    thread _id_274C2BFD735A6985(c4, _id_D18DC90864DC9BB9);
    animnode scripts\cp_mp\anim_scene::anim_scene([actorplayer], animnode.script_noteworthy, 1, 1);
    _id_12BFE6D203B0CDF3[_id_12BFE6D203B0CDF3.size] = c4;
    player _id_3B64EB40368C1450::_id_462E6336A0DC84A8("c4_door", "damage");
    _id_0F714A515FC59FF0 = 1;

    if(_id_B975301B70104FD4.size >= _id_0F714A515FC59FF0) {
      break;
    }

    _id_C5D3D8FF129F88BA _meth_DFB78B3E724AD620(1);
  }

  _id_C5D3D8FF129F88BA notify("stop_hintstring_monitoring");
  _id_C5D3D8FF129F88BA _meth_DFB78B3E724AD620(0);
  _id_C5D3D8FF129F88BA makeunusable();
  _id_C5D3D8FF129F88BA.origin = _id_FE941516E0961813[0].origin;
  _id_C5D3D8FF129F88BA.angles = _id_FE941516E0961813[0].angles;
  _id_C5D3D8FF129F88BA _id_253B4F09261976E6(_id_C5D3D8FF129F88BA.origin, _id_C5D3D8FF129F88BA.angles, 5, "escape_blown_wall", _id_D18DC90864DC9BB9);

  foreach(wall in _id_B9ABF8C9B08EA45F) {
    wall hide();
    wall notsolid();
    wall connectpaths();
  }

  foreach(_id_5D3CEBD52D05C532 in _id_12BFE6D203B0CDF3)
  _id_5D3CEBD52D05C532 delete();

  _id_C5D3D8FF129F88BA delete();
  level notify(_id_34E17131001C3DE9 + "_wall_blown");
}

_id_DABFDF04F879BC4F(c4) {
  c4 endon("death");
  wait 1;
  c4 show();
}

_id_742848E1A6724249(c4, animnode) {
  level waittill("plant_c4");
  c4 unlink();
  c4.origin = animnode.origin + rotatevector((-29.353, 2.473, 55.763), animnode.angles);
}

_id_274C2BFD735A6985(c4, _id_D18DC90864DC9BB9) {
  level endon("game_ended");
  alias = "cp_raid2_c4_plant";

  if(isDefined(_id_D18DC90864DC9BB9) && istrue(_id_D18DC90864DC9BB9))
    alias = alias + "_concrete";

  wait 0.9;
  c4 playSound(alias);
}

_id_253B4F09261976E6(plant_spot, _id_328BBB29B418D9B3, detonation_time, _id_6638147FD86D86D6, _id_D18DC90864DC9BB9) {
  level endon("game_ended");
  _id_55C83680627EFE37 = detonation_time;
  level thread _id_29DE2B4A8FFCCE02(self.origin);

  while(_id_55C83680627EFE37 > 0) {
    _id_55C83680627EFE37--;
    wait 1;
  }

  level notify("stop_c4_countdown_sounds");
  thread _id_8B5682DAE8329E4F(self.origin, self.angles, _id_D18DC90864DC9BB9);
}

_id_29DE2B4A8FFCCE02(org) {
  level endon("game_ended");
  level endon("stop_c4_countdown_sounds");
  _id_9B97E09F743B4D45 = 1.2;
  _id_D8FF3230FA968357 = 0;

  for(;;) {
    alias = "breach_warning_beep_0";
    alias = alias + scripts\engine\utility::string(_id_D8FF3230FA968357);
    playsoundatpos(org, alias);
    wait(_id_9B97E09F743B4D45);

    if(_id_D8FF3230FA968357 < 5) {
      _id_9B97E09F743B4D45 = _id_9B97E09F743B4D45 - 0.2;
      _id_D8FF3230FA968357++;
    }
  }
}

_id_8B5682DAE8329E4F(origin, angles, _id_D18DC90864DC9BB9) {
  level endon("game_ended");
  scripts\cp\utility\cp_controlled_callbacks::runcontrolledcallback("Earthquake", 1.0, 0.6, origin, 512);
  earthquake(1.0, 0.6, origin, 256);
  _id_74181F86971884B6 = scripts\engine\utility::ter_op(istrue(_id_D18DC90864DC9BB9), "vfx_cp_raid_wall_breach_debris", "claymore_explode");
  _id_EFDFC6EBE7A152C5 = spawnfx(level._effect[_id_74181F86971884B6], origin, anglesToForward(angles) * -1.0, (0, 0, 1));
  triggerfx(_id_EFDFC6EBE7A152C5);

  if(istrue(_id_D18DC90864DC9BB9)) {
    if(soundexists("bcharge_raid2_expl_trans_wall"))
      playsoundatpos(origin, "bcharge_raid2_expl_trans_wall");
  } else if(soundexists("bcharge_raid2_expl_trans_door"))
    playsoundatpos(origin, "bcharge_raid2_expl_trans_door");

  radiusdamage(origin, 128, 150, 50, undefined, "MOD_EXPLOSIVE");
  wait 10;
  _id_EFDFC6EBE7A152C5 delete();
}

_id_2052D222948E3568(_id_532FBDDCB39DED58, _id_FCE2DA54AA3EE955) {
  level endon("game_ended");
  door = getEnt(_id_FCE2DA54AA3EE955, "script_noteworthy");
  use_struct = scripts\engine\utility::getStruct(_id_532FBDDCB39DED58, "script_noteworthy");

  if(!isDefined(door) || !isDefined(use_struct)) {
    return;
  }
  _id_C5D3D8FF129F88BA = scripts\cp\utility::createhintobject(use_struct.origin, "HINT_BUTTON", undefined, &"CP_TRAP_ROOM/3MANDOOR", undefined, "duration_short", "show", 200, 320, 64, 40, undefined);
  _id_830905E5C2645826 = _id_532FBDDCB39DED58 + "_door_open";
  _id_C5D3D8FF129F88BA sethintstringparams(0);
  childthread _id_18AF78602B67B70C::_id_F6BC7D593D54CFEC(_id_C5D3D8FF129F88BA, _id_830905E5C2645826);
  childthread _id_18AF78602B67B70C::_id_4D3C7EB683BC1E25(use_struct, _id_830905E5C2645826);
  level waittill(_id_830905E5C2645826);
  _id_C5D3D8FF129F88BA delete();
  door notsolid();
  door connectpaths();
  door delete();
}

_id_87844A999F8A2DA5(_id_92C4DE821390F609) {
  level endon("game_ended");
  doors = getEntArray(_id_92C4DE821390F609, "script_noteworthy");
  use_struct = scripts\engine\utility::getStruct(_id_92C4DE821390F609, "script_noteworthy");
  button = getEnt(use_struct.target, "targetname");

  if(isDefined(doors) && isDefined(use_struct)) {
    _id_18AF78602B67B70C::_id_887438C3B4B194B6(1, use_struct.origin);
    _id_C5D3D8FF129F88BA = scripts\cp\utility::createhintobject(use_struct.origin, "HINT_BUTTON", undefined, &"CP_TRAP_ROOM/BRING_PARTY_HERE", undefined, "duration_short", "show", 200, 300, 64, 40, undefined);
    _id_830905E5C2645826 = _id_92C4DE821390F609 + "_door_open";
    _id_CEBB22306F7A7C58 = _id_92C4DE821390F609 + "_button_press";
    _id_EBD2EF92934BD7D1 = _id_92C4DE821390F609 + "_deserted";
    _id_C5D3D8FF129F88BA sethintstringparams(0);
    _id_C5D3D8FF129F88BA _meth_DFB78B3E724AD620(0);
    _id_7D59633A5EBFD584 = 0;

    while(!_id_7D59633A5EBFD584) {
      _id_C5D3D8FF129F88BA setHintString(&"CP_TRAP_ROOM/BRING_PARTY_HERE");
      _id_C5D3D8FF129F88BA _meth_DFB78B3E724AD620(1);
      _id_18AF78602B67B70C::_id_4D3C7EB683BC1E25(use_struct, _id_830905E5C2645826);
      _id_C5D3D8FF129F88BA setHintString(&"CP_TRAP_ROOM/3MANDOOR_BUTTON");
      childthread _id_F552AA0023C18F6A(use_struct, _id_830905E5C2645826, _id_EBD2EF92934BD7D1);
      player = _id_787085F42789D077(_id_C5D3D8FF129F88BA, _id_EBD2EF92934BD7D1);

      if(isDefined(player)) {
        level thread _id_51BCA0E4ED6BFD24(1.5, (-6993, 2659, 174));
        _id_C5D3D8FF129F88BA _meth_DFB78B3E724AD620(0);
        _id_A857EF26EAEB6D9D(player, button);
        level notify(_id_830905E5C2645826);
        _id_7D59633A5EBFD584 = 1;
      }
    }

    _id_C5D3D8FF129F88BA delete();
    level notify(_id_92C4DE821390F609 + "_opened");
    model = undefined;
    clip = undefined;

    foreach(door in doors) {
      if(door.classname == "script_model") {
        model = door;
        continue;
      }

      clip = door;
    }

    clip linkTo(model);
    model.animnode = spawnStruct();
    model.animnode.origin = model.origin;
    model.animnode.angles = model.angles;
    model.actor = scripts\cp_mp\anim_scene::anim_scene_create_actor(model, "airlock_door");
    _id_11D070770637EDAA(model);
  }
}

_id_51BCA0E4ED6BFD24(waittime, location) {
  level endon("game_ended");

  if(!isDefined(waittime) || !isDefined(location)) {
    return;
  }
  wait(waittime);
  playsoundatpos(location, "cp_raid2_small_door_pre_open");
}

_id_787085F42789D077(_id_C5D3D8FF129F88BA, _id_EBD2EF92934BD7D1) {
  level endon(_id_EBD2EF92934BD7D1);

  for(;;) {
    _id_C5D3D8FF129F88BA waittill("trigger", player);

    if(isPlayer(player))
      return player;
  }
}

_id_A857EF26EAEB6D9D(player, button) {
  player _id_3B64EB40368C1450::set("airlock_button", "damage", 0);
  actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(player, "plyr_silo", 1);
  _id_54E38BC53ABC8A5E = scripts\cp_mp\anim_scene::anim_scene_create_actor(button, "silo_button");
  player playSound("cp_raid2_silo_door_console_fly");
  button playSound("cp_raid2_silo_door_console_button");
  button scripts\cp_mp\anim_scene::anim_scene([actorplayer, _id_54E38BC53ABC8A5E], "button_pressed", 1, 1);
  player _id_3B64EB40368C1450::_id_462E6336A0DC84A8("airlock_button", "damage");
}

_id_1676C2F258C858B8(interaction, radius, _id_D1EB2A028C943191, _id_A716C233FF94D8E8) {
  level endon("game_ended");
  interaction endon("death");
  interaction endon("stop_hintstring_monitoring");
  distsqrd = radius * radius;

  for(;;) {
    if(scripts\cp\utility::are_all_players_nearby(interaction.origin, distsqrd)) {
      interaction setHintString(_id_A716C233FF94D8E8);
      interaction._id_862279B9184C2295 = 1;
    } else {
      interaction setHintString(_id_D1EB2A028C943191);
      interaction._id_862279B9184C2295 = 0;
    }

    wait 2;
  }
}

_id_F552AA0023C18F6A(use_struct, _id_830905E5C2645826, _id_EBD2EF92934BD7D1) {
  level endon("game_ended");
  level endon(_id_830905E5C2645826);
  _id_76FC9C72CBF75ECA = squared(160);

  for(;;) {
    if(!scripts\cp\utility::are_all_players_nearby(use_struct.origin, _id_76FC9C72CBF75ECA)) {
      level notify(_id_EBD2EF92934BD7D1);
      return;
    }

    wait 2;
  }
}

_id_E0CF5BA976B37016(_id_A260750D2D3EB8B6, _id_838DCE3ED0A1A11C) {
  foreach(cam in _id_A260750D2D3EB8B6) {
    if(isDefined(cam.targetname) && cam.targetname == _id_838DCE3ED0A1A11C)
      return cam;
  }

  return undefined;
}

_id_41FAFD8966CE1F16(_id_1730C8D8475566CD, _id_FB1DEF007972B25A, reviveent) {
  _id_9DDF8D4378FCEB16 = scripts\engine\utility::getStructArray("player_death_cam", "script_noteworthy");
  _id_F42869166D50FBE9 = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(!isDefined(_id_F42869166D50FBE9) || _id_F42869166D50FBE9 == "")
    _id_F42869166D50FBE9 = getDvar("start");

  _id_5C72B818B0325D8C = undefined;

  if(isDefined(_id_F42869166D50FBE9)) {
    switch (_id_F42869166D50FBE9) {
      case "trap_platforms":
      default:
        if(isDefined(level._id_0E190575F56F40A5) && level._id_0E190575F56F40A5 == "traversal")
          _id_5C72B818B0325D8C = _id_E0CF5BA976B37016(_id_9DDF8D4378FCEB16, "platforms");
        else
          _id_5C72B818B0325D8C = _id_E0CF5BA976B37016(_id_9DDF8D4378FCEB16, "intro");

        break;
      case "trap_rappel":
        _id_5C72B818B0325D8C = _id_E0CF5BA976B37016(_id_9DDF8D4378FCEB16, "rappel");
        break;
      case "trap_doubleback":
        _id_5C72B818B0325D8C = _id_E0CF5BA976B37016(_id_9DDF8D4378FCEB16, "platforms");
        break;
      case "trap_oldrooms":
        _id_5C72B818B0325D8C = _id_E0CF5BA976B37016(_id_9DDF8D4378FCEB16, "rappel_top");
        break;
      case "trap_room":
        _id_5C72B818B0325D8C = _id_E0CF5BA976B37016(_id_9DDF8D4378FCEB16, "trap_room");
        break;
      case "trap_room_final_wave":
        _id_5C72B818B0325D8C = _id_E0CF5BA976B37016(_id_9DDF8D4378FCEB16, "trap_room");
        break;
      case "trap_room_escape":
        _id_5C72B818B0325D8C = _id_E0CF5BA976B37016(_id_9DDF8D4378FCEB16, "escape");
        break;
    }
  } else
    _id_5C72B818B0325D8C = scripts\engine\utility::getclosest(_id_1730C8D8475566CD.origin, _id_9DDF8D4378FCEB16);

  startpos = _id_5C72B818B0325D8C.origin;
  mover = spawn("script_model", startpos);
  mover setModel("tag_origin");
  mover.angles = _id_5C72B818B0325D8C.angles;
  mover thread _id_0AFB7E332AEE4BF2::cleanuplaststandent(_id_1730C8D8475566CD);
  _id_1730C8D8475566CD cameralinkTo(mover, "tag_origin");
  wait 2;
  mover delete();
}

_id_95147F81CC6598F6() {
  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    _id_B5F9A3C3AC825819 = scripts\engine\utility::getStructArray("hardmode_claymore", "targetname");

    foreach(_id_E633DDF48671E8F0 in _id_B5F9A3C3AC825819)
    thread spawn_enemy_claymore(_id_E633DDF48671E8F0.origin, _id_E633DDF48671E8F0.angles);
  }
}

_id_107CB9038C5A7F98() {
  level notify("cleanup_traproom_ents_started");
  _id_78547FBB6C0083E0::_id_CA921D0DC407EAE1();
  _id_3AAF21BF0A95EED4::_id_E98C4212D1E67EA3("traproom_gas");
  _id_5FE553EECB367184::_id_E570E7FCB1B057D5("puddle_seq3");
  _id_225337895D1215BC();

  if(isDefined(level._id_EA6A492A79307C10)) {
    foreach(button in level._id_EA6A492A79307C10.buttons)
    button delete();

    level._id_EA6A492A79307C10 delete();
  }

  if(isDefined(level._id_9FAB894FBA306F2A)) {
    foreach(button in level._id_9FAB894FBA306F2A.buttons)
    button delete();

    level._id_9FAB894FBA306F2A delete();
  }

  if(isDefined(level._id_EB922F6D2C4004E3)) {
    foreach(button in level._id_EB922F6D2C4004E3.buttons)
    button delete();
  }
}

_id_1B42BA40587C09A1() {
  _id_3F1498737D49F865 = ["keybearer2_door", "keybearer3_door"];

  foreach(_id_92C4DE821390F609 in _id_3F1498737D49F865) {
    _id_1E92D8D3755A9FF8 = scripts\engine\utility::getStruct(_id_92C4DE821390F609, "script_noteworthy");
    _id_18AF78602B67B70C::_id_887438C3B4B194B6(1, _id_1E92D8D3755A9FF8.origin);
  }
}

spawn_enemy_claymore(origin, angles) {
  _id_656F0AE440B1B5D5 = magicgrenademanual("claymore_mp", origin + (0, 0, 10), (0, 0, 10));
  _id_656F0AE440B1B5D5 childthread plant_enemy_claymore(origin, angles);
  thread _id_79823539CA298145::_id_18284518C5EF7BD3(_id_656F0AE440B1B5D5);
  return _id_656F0AE440B1B5D5;
}

plant_enemy_claymore(origin, angles) {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  self.angles = angles;
  self.owner = spawnStruct();
  self.owner.angles = angles;
  self.owner.team = "neutral";
  self.team = "neutral";
  owner = self.owner;
  self.weapon_object = makeweapon("claymore_mp");

  if(!isDefined(level._id_C4EA99FA46D27C12))
    level._id_C4EA99FA46D27C12 = [];

  level._id_C4EA99FA46D27C12[level._id_C4EA99FA46D27C12.size] = self;
  self._id_3DBA99677FD840CD = ::_id_16B65EE43D765196;
  self missilethermal();
  self missileoutline();
  self setnodeploy(1);
  self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 20, undefined, undefined, undefined, 1.3);
  thread _id_FE8AD9D819592C52();
  thread scripts\cp\cp_claymore::claymore_explodeonnotify();
  thread scripts\cp\cp_claymore::claymore_destroyonemp();
  self setscriptablepartstate("plant", "active", 0);
  wait 0.1;
  self enableplayermarks("equipment");
  self setscriptablepartstate("arm", "active", 0);
  self.equipmentref = "equip_claymore";
  _id_6159D9FD44490F13::_hacksetup();
  thread _id_CCD48385E6743B3D(origin);
  thread scripts\cp\cp_claymore::enemy_claymore_watchfortrigger();
}

_id_16B65EE43D765196() {
  self notify("clean_custom_explode");

  if(isDefined(self.useobj))
    self.useobj delete();

  thread _id_74502A9E0EF1F19C::deleteexplosive();
}

_id_CCD48385E6743B3D(origin) {
  self endon("clean_custom_explode");
  _id_B9CE53DAD043E9E4 = origin + (0, 0, 30) + anglesToForward(self.angles) * 95;
  _id_419BFD33C72E7EF9 = origin + (0, 0, 30) + anglesToForward(self.angles) * 30;
  self waittill("death");
  attacker = getaiarray("axis")[0];
  radiusdamage(_id_419BFD33C72E7EF9, 30, 1000, 200, attacker, "MOD_EXPLOSIVE", "claymore_radial_mp");
  radiusdamage(_id_B9CE53DAD043E9E4, 100, 1000, 20, attacker, "MOD_EXPLOSIVE", "claymore_radial_mp");
}

_id_FE8AD9D819592C52() {
  self endon("mine_triggered");
  self endon("mine_selfdestruct");
  self endon("death");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  attacker = undefined;
  self waittill("damage", damage, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon);
  self notify("mine_destroyed");

  if(isDefined(type) && (issubstr(type, "MOD_GRENADE") || issubstr(type, "MOD_EXPLOSIVE")))
    self.waschained = 1;

  if(isDefined(idflags) && idflags &level.idflags_penetration)
    self.wasdamagedfrombulletpenetration = 1;

  self.wasdamaged = 1;

  if(isDefined(attacker))
    self.damagedby = attacker;

  self notify("detonateExplosive", attacker);
}

_id_1B98DE7F29B1D21B(player) {
  level endon("game_ended");

  for(;;) {}
}

_id_21F646F2859184F8(player, _id_49996EBEBBBBF375) {
  level endon("game_ended");
  _id_54D84A9A7BC12344 = 1;
  player thread _id_19DCD48D287343B7(10.0, 1);

  while(_id_54D84A9A7BC12344) {
    player waittill("gas_exited", _id_D25756C73E3DB859);

    if(_id_49996EBEBBBBF375 == _id_D25756C73E3DB859)
      _id_54D84A9A7BC12344 = 0;
  }

  player thread _id_19DCD48D287343B7(1.0, 0);
}

_id_19DCD48D287343B7(duration, turnon) {
  foreach(player in level.players) {
    if(istrue(turnon)) {
      self visionsetnakedforplayer("cp_raid1_trap_gas", duration);
      continue;
    }

    self visionsetnakedforplayer("", duration);
  }
}

_id_965FEEB6EA485E13() {
  level endon("game_ended");
  level notify("single_obj_change_description");
  level endon("single_obj_change_description");
  scripts\engine\utility::flag_wait("objectives_registered");
  level waittill("rappel_exit_3_man_door_opened");
  setomnvar("cp_objective_sub_1_index", 0);
  setomnvar("cp_objective_sub_count_1", -1);
  waitframe();
  scripts\cp\cp_objectives::run_objective("trap_room_after_rappel", "primary", "allies", 1);
  setomnvar("cp_objective_sub_1_complete", 0);
}

_id_00A911FC5F1EACBA() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");

  for(;;) {
    _id_5736748AFD2D5223();
    wait 20;
  }
}

_id_81DDB99DF8CD0810() {
  _id_B7F5EB1FA4E2A05C = spawn("script_model", (0, 0, 0));
  _id_B7F5EB1FA4E2A05C setModel("offhand1h_vm_smartphone_v0");
}

_id_A4847D329D12EBC3() {
  level endon("game_ended");
  _id_6DB09A05328FC74C = scripts\engine\utility::getStruct("flashlight_test", "script_noteworthy");
  _id_2CE3819674F7D9C1 = ["test_flashlight_1st", "test_flashlight_3rd"];
  index = 0;

  for(;;) {
    _id_9AF72BBDFDEACE5D = scripts\engine\utility::spawn_tag_origin(_id_6DB09A05328FC74C.origin, _id_6DB09A05328FC74C.angles);
    _id_9AF72BBDFDEACE5D show();
    wait 2;

    if(index == 1)
      index = -1;
    else
      playFXOnTag(level._effect[_id_2CE3819674F7D9C1[index]], _id_9AF72BBDFDEACE5D, "tag_origin");

    wait 5;
    _id_9AF72BBDFDEACE5D delete();
    index++;
    wait 1;
  }
}

_id_7B8D38C9D14253A2(alias) {
  playsoundatpos((-1249, 1085, -486), alias);
  playsoundatpos((-1677, 272, -486), alias);
}

_id_26C874616B2E28DA(alias) {
  playsoundatpos((-621, -66, -486), alias);
  playsoundatpos((-179, 827, -486), alias);
}