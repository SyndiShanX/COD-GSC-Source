/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4d346da49a80368c.gsc
***********************************************/

main() {
  scripts\engine\utility::flag_wait("objectives_registered");
  script_model_anims();
  scripts\cp\utility::coop_mode_enable("sp_stealth");
  register_jugg_maze_objectives();
  scripts\engine\utility::flag_init("cp_raid_complex_interactions_registered");
  scripts\engine\utility::flag_wait("cp_raid_complex_jugg_maze_completed");
  setomnvar("ui_raid_lua_render_stage", 7);
  level._id_30783085C294B022 = 1;
  thread _id_0BAEFB7122360383();

  if(getdvarint("dvar_F88A4DF5CBC0B9EF", 0) == 0)
    level thread _id_11811C954BBA79E3::_id_706C000482606389();

  thread _id_BF1EF385656F6ED9();
  thread _id_7F2FD7FC559755E4::_id_550B3495A71687C3();
  register_jugg_maze_interactions();
  _id_4BB23F70102CF6BC::main();
  _id_6DE96568512EB1CA::main();
  _id_55EE5F7836D9C6C4::main();
  thread _id_11811C954BBA79E3::_id_11176FBF41AC6322();
  thread _id_11811C954BBA79E3::_id_5A13959F7AF9E427();
  thread _id_11811C954BBA79E3::_id_B050F27723670DDE();
  setup_teleport_rooms();
  level endon("game_ended");
  thread _id_11811C954BBA79E3::_id_B70F7000FA998CBA();

  if(getdvarint("dvar_DA6B87817DB1CBA0", 0) == 0 && getdvarint("dvar_176FA03E6DA10955", 0) == 0) {
    level.button_sequence = [];
    level.current_button_counter = 0;
    level.current_button_progress = [];
    level.current_button_progress[level.current_button_counter] = [];
    level.button_sequence[0] = ["G"];
    level.button_sequence[1] = ["H", "I"];
    level.button_sequence[2] = ["G", "H", "I"];
    level.button_sequence[3] = ["C", "E", "F"];
    level.button_sequence[4] = ["B", "A", "D"];
    thread scripts\cp\cp_puzzles_core::generatepath(level.button_sequence[0]);
  } else {}

  level.pit_locations = scripts\engine\utility::getStructArray("pit_location", "targetname");
  level.airduct_locations = scripts\engine\utility::getStructArray("airduct_location", "targetname");
  level._id_04056F15D39BCF78 = ::_id_45AE9C036541A7A9;
  level.scripted_laser_func = undefined;
  level thread sequence_progression();
  _id_18A73A64992DD07D::run_spawn_module("jugg_spawn_localized_a");
  _id_18A73A64992DD07D::run_spawn_module("jugg_spawn_localized_b");
  _id_18A73A64992DD07D::run_spawn_module("jugg_spawn_localized_c");
  _id_18A73A64992DD07D::run_spawn_module("jugg_spawn_localized_d");
  _id_18A73A64992DD07D::run_spawn_module("jugg_spawn_localized_e");
  level thread _id_7A90F3503FFEA6A4();
  register_respawn_functions();
}

_id_BF1EF385656F6ED9() {
  level endon("game_ended");
  level endon("progress_level");
  level._id_E20F47A317DB0129 = undefined;
  level._id_48C577B7BCD1AFBE = undefined;

  for(;;) {
    wait 0.2;
    level._id_E20F47A317DB0129 = _id_4BB23F70102CF6BC::_id_91C2742E256F657D();
    level._id_48C577B7BCD1AFBE = level._id_E20F47A317DB0129;
  }
}

#using_animtree("script_model");

script_model_anims() {
  level.scr_animtree["vault_door"] = #animtree;
  level.scr_model["vault_door"] = "structural_blast_door_bunker_assembly";
  level.scr_anim["vault_door"]["open"] = % cp_raid_nuke_vault_door_open;
  level.scr_animname["vault_door"]["open"] = "cp_raid_nuke_vault_door_open";
  level.scr_anim["vault_door"]["close"] = % cp_raid_nuke_vault_door_close;
  level.scr_animname["vault_door"]["close"] = "cp_raid_nuke_vault_door_close";
}

load_fx() {
  level._effect["pipe_steam"] = loadfx("vfx/iw8_cp/raid/vfx_cp_steampipe_exp.vfx");
}

register_jugg_maze_objectives() {
  scripts\engine\utility::flag_wait("objectives_registered");
  _id_11811C954BBA79E3::_id_DAE7BA0B1B96ACF1();
}

register_jugg_maze_interactions() {
  scripts\cp\cp_interaction::registerinteraction("gasmask", ::hint_gasmask, ::activate_gasmask, ::init_gasmask, 0, "duration_long");
  scripts\cp\cp_interaction::registerinteraction("escape_maze", ::hint_escape_maze, ::activate_escape_maze, ::init_escape_maze, 0, "duration_long");

  if(getdvarint("dvar_B4866A8ED52FBD69", 1) == 0)
    scripts\cp\cp_interaction::registerinteraction("seq_button", ::hint_seq_button, ::activate_seq_button, ::init_seq_button, 0, "duration_long");

  if(getdvarint("dvar_B4866A8ED52FBD69", 1) != 0) {
    return;
  }
  _id_16037153C1704C7E = scripts\engine\utility::getStructArray("jugg_maze_camera", "targetname");

  foreach(_id_DF071553D0996FF9 in _id_16037153C1704C7E) {
    popup_omnvar = _id_DF071553D0996FF9.script_index;
    _id_287CC7482806C9F7 = scripts\cp\cp_computerscreen::create_computer_interaction(_id_DF071553D0996FF9.origin, int(popup_omnvar));
    _id_287CC7482806C9F7 thread computer_think(_id_DF071553D0996FF9.origin, int(popup_omnvar));
  }

  level._id_D33F6CE75E322B89 = scripts\engine\utility::getStruct("gas_interaction", "targetname");
  level._id_D33F6CE75E322B89 = _id_5C6E4E1582514A69(level._id_D33F6CE75E322B89.origin, undefined, undefined, "show", 2000, 360);
  level._id_D33F6CE75E322B89 thread _id_A76F087CC4CA1528();
}

_id_A76F087CC4CA1528() {
  level endon("game_ended");
  self endon("death");
  self _meth_DFB78B3E724AD620(1);

  for(;;) {
    self waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    level notify("stopping_gas");
    scripts\engine\utility::flag_set("gas_cleared");
    self _meth_DFB78B3E724AD620(0);
    break;
  }
}

_id_5C6E4E1582514A69(_id_963953C3478BF4FE, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov) {
  _id_A26DA51362334CBA = spawn("script_model", _id_963953C3478BF4FE);
  _id_A26DA51362334CBA setModel("tag_origin");
  _id_A26DA51362334CBA.angles = (0, 0, 0);
  _id_A26DA51362334CBA makeusable();

  if(isDefined(duration))
    _id_A26DA51362334CBA setuseholdduration(duration);
  else
    _id_A26DA51362334CBA setuseholdduration("duration_medium");

  if(!isDefined(duration) || duration == "duration_medium" || duration == "duration_long")
    _id_A26DA51362334CBA sethintrequiresholding(1);

  if(isDefined(onobstruction))
    _id_A26DA51362334CBA sethintonobstruction(onobstruction);
  else
    _id_A26DA51362334CBA sethintonobstruction("hide");

  if(isDefined(hintdist))
    _id_A26DA51362334CBA sethintdisplayrange(hintdist);
  else
    _id_A26DA51362334CBA sethintdisplayrange(200);

  _id_A26DA51362334CBA sethintdisplayfov(65);

  if(isDefined(usedist))
    _id_A26DA51362334CBA setuserange(usedist);
  else
    _id_A26DA51362334CBA setuserange(72);

  if(isDefined(usefov))
    _id_A26DA51362334CBA setusefov(usefov);
  else
    _id_A26DA51362334CBA setusefov(65);

  _id_A26DA51362334CBA sethinticon("icon_electrical_box");
  hintstring = &"CP_STRIKE/DEFUSE";
  _id_A26DA51362334CBA setHintString(hintstring);
  _id_A26DA51362334CBA setCursorHint("HINT_BUTTON");
  return _id_A26DA51362334CBA;
}

computer_think(popup_omnvar, _id_094BDE51D48A4DDE, _id_6AA6E1A0A555C210) {
  self notify("computer_think");
  self endon("computer_think");

  for(;;) {
    self waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    level notify("manifest_computer_used", player);
    self makeunusable();
    thread computer_think_internal(player, popup_omnvar, _id_094BDE51D48A4DDE, _id_6AA6E1A0A555C210);
  }
}

computer_think_internal(player, popup_omnvar, _id_094BDE51D48A4DDE, _id_6AA6E1A0A555C210) {
  self notify("computer_think_internal");
  self endon("computer_think_internal");
  player endon("disconnect");

  while(player useButtonPressed())
    wait 0.05;

  thread scripts\cp\cp_computerscreen::computer_laststand_handler(player, popup_omnvar);
  thread scripts\cp\cp_computerscreen::computer_disconnect_handler(player);
  player playlocalsound("cp_computer_use");
  self.scenenode = scripts\engine\utility::getclosest(self.origin, scripts\engine\utility::getStructArray("cpu_use_spot", "script_noteworthy"));
  scripts\cp\cp_computerscreen::computer_player_allow(player, 0);
  _id_17F8267EFFFB27D6 = 4;
  scripts\engine\utility::delaythread(1, ::computer_activate, player, _id_17F8267EFFFB27D6);
  scripts\cp\cp_computerscreen::do_computer_anims(player);
  player thread scripts\cp\cp_computerscreen::computer_anim_loop_exit(player);
  scripts\cp\cp_computerscreen::computer_player_allow(player, 1);
  player setclientomnvar("dpad_popup", 0);

  if(!istrue(self.disable_playeruse))
    self makeusable();
}

computer_activate(player, popup_omnvar) {
  player setclientomnvar("dpad_popup", popup_omnvar);
}

createobjectivelist(shadername, team, _id_3E2EF879EE8848E2, _id_70DAB3207FB65169) {
  curobjid = [];
  _id_1EE636AD961E6207 = 8;
  _id_D37C6DEEA2415EB3 = ceil(_id_70DAB3207FB65169.size / _id_1EE636AD961E6207);

  for(objindex = 0; objindex < _id_D37C6DEEA2415EB3; objindex++) {
    curobjid[objindex] = scripts\cp\utility::nonobjective_requestobjectiveid();
    objective_icon(curobjid[objindex], shadername);
    objective_state(curobjid[objindex], "active");
    objective_setspecialobjectivedisplay(curobjid[objindex], 1);
    objective_setbackground(curobjid[objindex], 1);
    _id_B3720D45E34D6FBB = scripts\engine\utility::ter_op(objindex == _id_D37C6DEEA2415EB3 - 1, _id_70DAB3207FB65169.size % _id_1EE636AD961E6207, _id_1EE636AD961E6207);

    for(index = 0; index < _id_B3720D45E34D6FBB; index++)
      objective_setlocation(curobjid[objindex], index, _id_70DAB3207FB65169[_id_1EE636AD961E6207 * objindex + index].origin);

    if(isDefined(team)) {
      objective_setownerteam(curobjid[objindex], team);

      if(!level.teambased && isDefined(self.owner)) {
        if(istrue(_id_3E2EF879EE8848E2))
          scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam(curobjid[objindex], self.owner);
        else
          scripts\mp\objidpoolmanager::objective_teammask_single(curobjid[objindex], team);
      }

      continue;
    }

    scripts\mp\objidpoolmanager::objective_playermask_showtoall(curobjid[objindex]);
  }

  return curobjid;
}

init_jugg_maze(objectivestruct, _id_5DCDFD3A4EFF9961) {
  level.jugg_objective_struct = objectivestruct;
  level thread start_timed_event_on_detection(objectivestruct);
}

register_respawn_functions() {
  level.enter_spectator_func = _id_0AFB7E332AEE4BF2::enable_dogtag_revive;
  level.skip_nav_check_on_spectate_respawn = 1;
}

getjuggmazespawnpoint() {
  return _id_116171939929AF39::getassignedspawnpoint(scripts\engine\utility::getStructArray("jugg_maze_spawner_dogtags", "targetname"));
}

juggmazedogtagrevive(downed_player) {
  spawnpoint = downed_player getjuggmazespawnpoint();
  dogtag = spawn("script_model", spawnpoint.origin + (0, 0, 40));
  dogtag setModel("military_dogtags_iw8_blue");
  dogtag makeusable();
  dogtag scriptmodelplayanim("mp_dogtag_spin");
  dogtag setHintString(&"COOP_GAME_PLAY/REVIVE_USE");
  dogtag endon("death");
  downed_player.respawn_forcespawnorigin = scripts\engine\utility::drop_to_ground(spawnpoint.origin, 32, -100);
  downed_player.respawn_forcespawnangles = spawnpoint.angles;
  downed_player.dogtag = dogtag;
  downed_player.dogtag.owner = downed_player;
  _id_0AFB7E332AEE4BF2::makereviveicon(dogtag, downed_player, (1, 0, 0));
  dogtag thread _id_0AFB7E332AEE4BF2::revivetriggerthink(downed_player.team);
  dogtag thread _id_0AFB7E332AEE4BF2::endreviveonownerdeathordisconnect();
}

sequence_progression() {
  for(;;) {
    level waittill("progress_level");

    if(getdvarint("dvar_176FA03E6DA10955", 0) != 0) {
      iprintln(" UNLOCKED Airlock! ");
      break;
    } else if(getdvarint("dvar_DA6B87817DB1CBA0", 0) != 0) {
      objective_setlocation(level.jugg_objective_struct.objectiveindex, 0, scripts\engine\utility::getStruct("escape_maze", "script_noteworthy").origin);
      iprintln(" UNLOCKED ESCAPE DOOR! ");
      break;
    } else if(getdvarint("dvar_B4866A8ED52FBD69", 1) != 0) {
      level.unlocked_escape_door = 1;
      level notify("escaped_maze");
      level notify("stopping_gas");
      wait 2;
      return;
    } else {
      level.escapepathpermutations = undefined;
      level.current_button_counter++;
      level.current_button_progress[level.current_button_counter] = [];

      if(level.current_button_counter == 5) {
        foreach(struct in scripts\engine\utility::getStructArray("seq_button", "script_noteworthy")) {
          if(isDefined(struct.headicon))
            deleteheadicon(struct.headicon);
        }

        objective_setlocation(level.jugg_objective_struct.objectiveindex, 0, scripts\engine\utility::getStruct("escape_maze", "script_noteworthy").origin);
        scripts\cp\cp_interaction::removefrominteractionslistbynoteworthy("seq_button");
        iprintln(" UNLOCKED ESCAPE DOOR! ");
        break;
      } else {
        switch (level.current_button_counter) {
          case 1:
            break;
          case 2:
            break;
          case 3:
            break;
          case 4:
            break;
          case 5:
            break;
        }

        level notify("phase_" + level.current_button_counter + "_complete");
        scripts\engine\utility::flag_set("phase_" + level.current_button_counter + "_complete");
        scripts\cp\cp_puzzles_core::generatepath(level.button_sequence[level.current_button_counter]);
        iprintln(" ^4 SEQUENCE UPDATED !! ");
      }
    }
  }

  level.unlocked_escape_door = 1;
  level notify("escaped_maze");
}

start_jugg_maze(objectivestruct, _id_5DCDFD3A4EFF9961) {
  level.scurrentobjective = objectivestruct.objname;

  if(getdvarint("dvar_F9B9942166F1DFFF", 0) != 0)
    start_periodic_jugg_pulses();

  level waittill("escaped_maze");
  level notify(objectivestruct.ref + "_update_instance");
  scripts\cp\cp_objectives::reset_objective_timers();
  _id_4BB23F70102CF6BC::unset_maze_ai_stealth_settings();
  open_any_random_airlock_door();
}

end_jugg_maze(objectivestruct, _id_5DCDFD3A4EFF9961) {
  scripts\cp\cp_objectives::overridenextstep(objectivestruct, "silo_thrust");
}

debug_jugg_maze(objectivestruct) {
  scripts\engine\utility::flag_wait("cp_raid_complex_jugg_maze_completed");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "jugg_maze_spawner_dogtags", 1);
}

_id_7A90F3503FFEA6A4() {
  level endon("game_ended");

  while(level.players.size == 0)
    wait 1;

  struct = scripts\engine\utility::getStruct("juggmaze_screen_guy", "targetname");
  _id_CEFF7287F4AFEC76 = 0;

  foreach(player in level.players) {
    if(!isDefined(player.origin) || player.origin[2] > struct.origin[2] + 50) {
      continue;
    }
    _id_CEFF7287F4AFEC76 = 1;
  }

  if(_id_CEFF7287F4AFEC76) {
    return;
  }
  _id_18A73A64992DD07D::run_spawn_module("juggmaze_screen_guy");
}

open_any_random_airlock_door() {
  level.chosen_airlock_door = scripts\engine\utility::random(level.teleport_room_doors);
  level.chosen_airlock_door open_teleport_room_door();
  wait_for_all_players_in_airlock(level.chosen_airlock_door);
  scripts\engine\utility::array_call(level.players, ::freezecontrols, 1);
  level.chosen_airlock_door close_teleport_room_door();

  foreach(player in level.players)
  thread teleport_to_silo_airlock(player, level.teleport_reference_juggmaze, level.teleport_reference_silo);

  wait 1;
  scripts\engine\utility::array_call(level.players, ::freezecontrols, 0);
}

wait_for_all_players_in_airlock(door) {
  level.teleport_reference_silo = scripts\engine\utility::getStruct("teleport_ref_silo", "targetname");
  level.teleport_reference_juggmaze = scripts\engine\utility::getclosest(door.origin, scripts\engine\utility::getStructArray("teleport_ref_juggmaze", "targetname"), 512);
  objective_position(level.jugg_objective_struct.objectiveindex, level.teleport_reference_juggmaze.origin);
  _id_C85928B34D8E7FC8 = level.teleport_reference_juggmaze.origin + anglesToForward(level.teleport_reference_juggmaze.angles) * 233;
  waitforallplayersnearpoint(_id_C85928B34D8E7FC8, 128);
}

waitforallplayersnearpoint(point, radius) {
  _id_8CB3F312A0FE20E4 = 0;

  while(!_id_8CB3F312A0FE20E4) {
    _id_8CB3F312A0FE20E4 = 1;

    foreach(player in level.players) {
      if(distance(player.origin, point) > radius) {
        _id_8CB3F312A0FE20E4 = 0;
        continue;
      }
    }

    wait 0.5;
  }
}

start_timed_event_on_detection(objectivestruct) {
  if(istrue(level.gas_sequence_activated)) {
    return;
  }
  level notify("start_timed_event_on_detection");
  level endon("start_timed_event_on_detection");
  level endon("escaped_maze");
  level scripts\engine\utility::waittill_any_2("players_detected", "weapons_free");
  play_lighting_sequence("alert_mode");
  level notify("vision_set_change_request", "cp_raid_complex_maze_alert", undefined, 8);
  level.gas_sequence_activated = 1;

  foreach(ai in getaiarray("axis"))
  ai.sightmaxdistance = ai.sightmaxdistance / 2;

  if(getdvarint("dvar_28E0D2BF6DA32BE1", 0) == 0)
    level thread start_gas_sequence();

  level thread start_game_end_timer(objectivestruct, 360);
}

start_gas_sequence() {
  wait 19;

  foreach(player in level.players) {
    playFX(level._effect["vfx_cp_raid_jugg_gas_screen"], player.origin);
    player playsoundtoplayer("scavenger_pack_pickup", player);
    player forceplaygestureviewmodel("ges_visor_down");

    if(!istrue(player.gasmaskequipped)) {
      player.gasmaskhealth = 180;
      player thread scripts\cp_mp\gasmask::equipgasmask();
      player setclientomnvar("ui_head_equip_class", 2);
    }
  }
}

play_gas_sequence() {
  ents = scripts\engine\utility::getStructArray("smoke_pipe", "targetname");
  _id_1FE5B916408712E8 = [];

  foreach(struct in ents) {
    struct.ent = spawn("script_origin", struct.origin);

    if(!isDefined(struct.ent))
      struct.ent.angles = (0, 0, 0);
    else
      struct.ent.angles = struct.angles;

    _id_1FE5B916408712E8[_id_1FE5B916408712E8.size] = struct.ent;
    struct.ent thread play_smoke_sequence_on_ent_looped(struct.ent);
  }
}

play_smoke_sequence_on_ent_looped(ent) {
  level endon("escape_maze");
  ent childthread scripts\cp\utility::play_sound_on_entity("fire_system_start");
  ent childthread scripts\engine\utility::play_loop_sound_on_entity("fire_system_hiss");

  for(;;) {
    ent childthread play_smoke_fx();
    wait 19;
    ent delete_smoke_fx();
    wait 1;
  }
}

deletesoundents() {
  self notify("stop soundfire_system_start");
  waitframe();
  self notify("stop soundfire_system_hiss");
}

play_smoke_fx() {
  playFX(level._effect["vfx_raid_jugg_gas_start"], self.origin);
  self.fx = spawnfx(level._effect["vfx_raid_jugg_gas_start"], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  wait 1;
  triggerfx(self.fx);
}

delete_smoke_fx() {
  if(isDefined(self.fx))
    self.fx delete();

  waitframe();
}

ambush_halon_gas_control() {}

start_game_end_timer(objectivestruct, delay) {
  level endon("escaped_maze");
  iprintln(" THEY ARE DEPLOYING GAS TO FLUSH US OUT. WE HAVE A LIMITED AMOUNT OF TIME LEFT! ");
  thread scripts\cp\utility::objective_update(objectivestruct.ref, delay, int(delay / 2), int(delay / 3), 1);
  result = level scripts\engine\utility::waittill_any_return_2(objectivestruct.ref + "_timer_complete", "escaped_maze");

  if(isDefined(result) && result == "escaped_maze") {
    return;
  }
  level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
}

give_fists() {
  gunless = makeweapon("iw8_fists_mp");
  _id_F9F3100428A6E476 = makeweapon("none");
  self.weaponlist = self.primaryweapons;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.weaponlist.size; _id_AC0E594AC96AA3A8++) {
    weapon = self.weaponlist[_id_AC0E594AC96AA3A8];

    if(isDefined(weapon) && !issameweapon(gunless, weapon) && !issameweapon(_id_F9F3100428A6E476, weapon))
      self takeweapon(weapon);
  }

  scripts\cp_mp\utility\inventory_utility::_giveweapon(gunless, undefined, undefined, 1);
  scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(gunless, 1);
}

init_escape_maze(_id_70DAB3207FB65169) {}

hint_escape_maze(_id_DF071553D0996FF9, player) {
  if(1)
    return "";

  return &"CP_RAID_COMPLEX_JUGG_MAZE/ESCAPE";
}

activate_escape_maze(_id_DF071553D0996FF9, player) {
  player endon("disconnect");

  if(1) {
    return;
  }
  open_any_random_airlock_door();
}

init_seq_button(_id_70DAB3207FB65169) {
  if(_id_70DAB3207FB65169.size > 0) {
    level.switchminimapid = createobjectivelist("icon_cp_maze_switch", undefined, 1, _id_70DAB3207FB65169);

    foreach(struct in _id_70DAB3207FB65169) {
      struct.blocked = 0;

      switch (struct.script_label) {
        case "A":
          headicon = "icon_electronic_interact";
          break;
        case "B":
          headicon = "icon_electronic_interact";
          break;
        case "C":
          headicon = "hud_icon_perk_momentum_pro";
          break;
        case "D":
          headicon = "icon_electronic_interact";
          break;
        case "E":
          headicon = "hud_icon_perk_momentum_pro";
          break;
        case "F":
          headicon = "hud_icon_perk_momentum_pro";
          break;
        case "G":
          headicon = "hud_icon_sng_intel";
          break;
        case "H":
          headicon = "cp_crate_icon_armor";
          break;
        case "I":
          headicon = "hud_icon_hardpoint_diamond";
          break;
        default:
          continue;
      }

      struct.model = spawn("script_model", struct.origin);
      struct.headicon = createheadicon(struct.model);
      setheadiconimage(struct.headicon, headicon);
      setheadiconzoffset(struct.headicon, 5);
      setheadiconsnaptoedges(struct.headicon, 0);
      setheadicondrawthroughgeo(struct.headicon, 1);
      setheadiconmaxdistance(struct.headicon, 5000);
      setheadiconnaturaldistance(struct.headicon, 500);
    }
  }
}

hint_seq_button(_id_DF071553D0996FF9, player) {
  if(!scripts\engine\utility::flag("gas_cleared"))
    return "";

  if(!scripts\engine\utility::array_contains(level.button_sequence[level.current_button_counter], _id_DF071553D0996FF9.script_label))
    return "";

  if(istrue(_id_DF071553D0996FF9.blocked))
    return "";

  return &"CP_RAID_COMPLEX_JUGG_MAZE/PRESS_BUTTON";
}

activate_seq_button(_id_DF071553D0996FF9, player) {
  player endon("disconnect");

  if(!scripts\engine\utility::flag("gas_cleared"))
    player playlocalsound("br_pickup_deny");
  else {
    if(istrue(_id_DF071553D0996FF9.blocked)) {
      player playlocalsound("br_pickup_deny");
      return;
    }

    if(!scripts\engine\utility::array_contains(level.button_sequence[level.current_button_counter], _id_DF071553D0996FF9.script_label)) {
      player playlocalsound("br_pickup_deny");
      return;
    }

    if(level.current_button_progress[level.current_button_counter].size >= level.button_sequence[level.current_button_counter].size) {
      player playlocalsound("br_pickup_deny");
      return;
    }

    level.current_button_progress[level.current_button_counter] = scripts\engine\utility::array_add(level.current_button_progress[level.current_button_counter], _id_DF071553D0996FF9.script_label);
    _id_927B3199642B75FC = "";

    foreach(_id_F7806D4CF24AACD3 in level.current_button_progress[level.current_button_counter])
    _id_927B3199642B75FC = _id_927B3199642B75FC + _id_F7806D4CF24AACD3;

    iprintln(" Current Sequence = ^1" + _id_927B3199642B75FC);
    level thread start_countdown_till_sequence_is_cleared();

    if(has_sequence_been_entered_correctly()) {
      level notify("progress_level");
      return;
    }

    if(level.current_button_progress[level.current_button_counter].size == level.button_sequence[level.current_button_counter].size) {
      level.current_button_progress[level.current_button_counter] = [];
      iprintln(" ^1 Sequence CLEARED ");
    }
  }
}

start_countdown_till_sequence_is_cleared() {
  if(getdvarint("dvar_2CEBD4CD2BA72BB9", 0) == 0) {
    timer = getdvarfloat("dvar_A0EAB8801610F747", 2);
    wait(timer);
    level.current_button_progress[level.current_button_counter] = [];
    iprintln(" ^1 Sequence CLEARED ");
  }
}

has_sequence_been_entered_correctly() {
  if(level.button_sequence[level.current_button_counter].size != level.current_button_progress[level.current_button_counter].size)
    return 0;

  foreach(array in level.escapepathpermutations) {
    if(scripts\cp\utility::array_compare(array, level.current_button_progress[level.current_button_counter]))
      return 1;
  }

  return 0;
}

init_gasmask(_id_70DAB3207FB65169) {
  if(_id_70DAB3207FB65169.size > 0) {
    foreach(struct in _id_70DAB3207FB65169) {
      struct.model = spawn("script_model", struct.origin);
      struct.model setModel("hat_gasmask");

      if(!isDefined(struct.angles))
        struct.angles = (0, 0, 0);

      struct.model.angles = struct.angles;
    }
  }
}

hint_gasmask(_id_DF071553D0996FF9, player) {
  return &"CP_BAD_SITUATION_OBJ/EQUIP_GASMASK_FILTER";
}

activate_gasmask(_id_DF071553D0996FF9, player) {
  player endon("disconnect");
  player playsoundtoplayer("scavenger_pack_pickup", player);
  player forceplaygestureviewmodel("ges_visor_down");

  if(!istrue(player.gasmaskequipped)) {
    player.gasmaskhealth = 180;
    player thread scripts\cp_mp\gasmask::equipgasmask();
    player setclientomnvar("ui_head_equip_class", 2);
  } else {
    player.gasmaskswapinprogress = 1;
    wait 0.338;
    player.gasmaskswapinprogress = 0;
    player iprintln(" ^7you added a ^1gas mask^7 filter! ");
    player.gasmaskhealth = player.gasmaskhealth + 30;
  }

  _id_DF071553D0996FF9.model delete();
  scripts\cp\cp_interaction::remove_from_current_interaction_list(_id_DF071553D0996FF9);
}

start_periodic_jugg_pulses() {
  _id_31ED809382E5C603 = 5;
  _id_43E236FCB934E2BE = 6666;

  foreach(player in level.players)
  thread runscoperadarinloop(player, _id_31ED809382E5C603, _id_43E236FCB934E2BE);
}

give_periodic_jugg_pulses() {
  _id_31ED809382E5C603 = 5;
  _id_43E236FCB934E2BE = 6666;
  thread runscoperadarinloop(self, _id_31ED809382E5C603, _id_43E236FCB934E2BE);
}

runscoperadarinloop(player, _id_31ED809382E5C603, _id_43E236FCB934E2BE) {
  level endon("game_ended");
  player notify("runScopeRadarInLoop");
  player endon("runScopeRadarInLoop");
  player endon("last_stand");
  player endon("death");
  player endon("disconnect");
  level endon("escaped_maze");
  level endon("end_jugg_recon_thread");

  for(;;) {
    player playlocalsound("uav_ping");
    player thread scoperadar_executeping(player, _id_31ED809382E5C603, _id_43E236FCB934E2BE);
    player scoperadar_executevisuals(player, _id_31ED809382E5C603);
    wait(randomintrange(3, 10));
  }
}

scoperadar_executeping(player, _id_31ED809382E5C603, _id_43E236FCB934E2BE) {
  level endon("game_ended");
  player endon("death");
  player endon("scope_radar_ads_out");
  hit = 0;
  enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  closestenemies = scripts\engine\utility::get_array_of_closest(player.origin, enemies, undefined, 24, _id_43E236FCB934E2BE);
  player.closestenemies = closestenemies;
  count = 0;

  foreach(victim in player.closestenemies) {
    victim.is_outlined_from_scoperadar = 0;
    count++;
    _id_340D59422336E85A = victim.origin - player.origin;
    _id_F85C8A0556EDF077 = _id_43E236FCB934E2BE * _id_43E236FCB934E2BE;

    if(length2dsquared(_id_340D59422336E85A) > _id_F85C8A0556EDF077) {
      continue;
    }
    player thread outlineplayerbydistance(victim, player, distance2d(player.origin, victim.origin) / _id_43E236FCB934E2BE, _id_31ED809382E5C603);
    hit = 1;
  }
}

outlineplayerbydistance(victim, player, delay, _id_31ED809382E5C603) {
  level endon("game_ended");
  player endon("scope_radar_ads_out");
  player endon("last_stand");
  player endon("death");
  player endon("disconnect");
  player endon("weapon_change");
  wait(_id_31ED809382E5C603 * delay);
  victim.is_outlined_from_scoperadar = 1;
  victim hudoutlineenableforclient(player, "snapshotgrenade");
}

watchhighlightfadetime(player, ent, time) {
  player endon("disconnect");
  level endon("game_ended");
  player scripts\engine\utility::waittill_any_timeout_no_endon_death_1(time);

  if(isDefined(ent))
    disable_outline_for_player(ent, player);
}

disable_outline_for_player(item, player) {
  item hudoutlinedisableforclient(player);
}

scoperadar_executevisuals(player, _id_31ED809382E5C603) {
  level endon("game_ended");
  player endon("disconnect");
  player scripts\engine\utility::waittill_any_timeout_no_endon_death_2(_id_31ED809382E5C603, "last_stand", "death");

  if(isDefined(player.closestenemies)) {
    foreach(victim in player.closestenemies) {
      if(isDefined(victim)) {
        if(istrue(victim.is_outlined_from_scoperadar)) {
          disable_outline_for_player(victim, player);
          victim.is_outlined_from_scoperadar = 0;
        }
      }
    }
  }

  if(isDefined(player.fxent))
    player.fxent delete();
}

remove_visuals(player) {
  enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  foreach(victim in enemies) {
    if(isDefined(victim)) {
      if(istrue(victim.is_outlined_from_scoperadar)) {
        disable_outline_for_player(victim, player);
        victim.is_outlined_from_scoperadar = 0;
      }
    }
  }

  if(isDefined(player.fxent))
    player.fxent delete();
}

cleanup_outlines(player) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("last_stand");
  player endon("death");
  enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  foreach(victim in enemies) {
    if(isDefined(victim)) {
      if(istrue(victim.is_outlined_from_scoperadar)) {
        disable_outline_for_player(victim, player);
        victim.is_outlined_from_scoperadar = 0;
      }
    }
  }
}

setup_teleport_rooms() {
  level.teleport_room_doors = getEntArray("teleport_room_door", "targetname");

  foreach(index, door in level.teleport_room_doors) {
    door.index = index;
    door.vstartposition = door.origin;
    _id_479E458F6F530F0D::_id_F0D61E14DFDE9CCD(door);
    door.animname = "vault_door";
    door scripts\common\anim::setanimtree();

    if(isDefined(door.target)) {
      door_clip = getEnt(door.target, "targetname");

      if(isDefined(door_clip)) {
        door.clip = door_clip;
        door.clip_mover = spawn("script_model", door gettagorigin("door_joint"));
        door.clip_mover setModel("tag_origin");
        door.vopenangles = vectortoangles(door gettagorigin("door_joint"));
        door.vcloseangles = door.vopenangles + (0, -90, 0);
        door.clip linkTo(door.clip_mover);
      }
    }

    door thread close_teleport_room_door();
  }
}

draw_door_forwards(door) {
  for(;;) {
    thread scripts\engine\utility::draw_arrow(door gettagorigin("door_joint"), door gettagorigin("door_joint") + anglesToForward(door.vopenangles) * 100, (1, 0, 0));
    thread scripts\engine\utility::draw_arrow(door gettagorigin("door_joint"), door gettagorigin("door_joint") + anglesToForward(door.vcloseangles) * 100, (0, 1, 0));
    waitframe();
  }
}

open_close_initial() {
  thread scripts\common\anim::anim_single_solo(self, "close");
  time = getanimlength(level.scr_anim["vault_door"]["close"]);
  wait(time);
}

open_close_loop() {
  for(;;) {
    open_teleport_room_door();
    wait 5;
    close_teleport_room_door();
    wait 5;
  }
}

open_teleport_room_door() {
  level endon("game_ended");
  door = self;
  door.state = "open";
  door thread scripts\common\anim::anim_single_solo(door, "open");
  time = getanimlength(level.scr_anim["vault_door"]["open"]);
  playsoundatpos(self.origin + (0, 0, 100), "evt_raid4_warhead_vault_door_open");
  door.clip_mover rotateYaw(-103, time);
  wait(time * 0.2);
  door.clip connectpaths();
  wait(time * 0.8);
}

close_teleport_room_door() {
  level endon("game_ended");
  door = self;
  door.state = "closed";
  door thread scripts\common\anim::anim_single_solo(door, "close");
  time = getanimlength(level.scr_anim["vault_door"]["close"]);
  playsoundatpos(self.origin + (0, 0, 100), "evt_raid4_warhead_vault_door_close");
  door.clip_mover rotateYaw(103, time);
  wait(time * 0.8);
  door.clip disconnectPaths();
  wait(time * 0.2);
}

teleport_to_silo_airlock(player, _id_1497FF2D8DD1F59A, _id_CBC7CF67CCA5129A) {
  _id_BC931ABB9F0773A8 = player.origin - _id_1497FF2D8DD1F59A.origin;
  _id_441191F2F70023BD = rotatevectorinverted(_id_BC931ABB9F0773A8, _id_1497FF2D8DD1F59A.angles);
  _id_3FBCCB7168F81992 = player.angles - _id_1497FF2D8DD1F59A.angles;
  _id_62DED3CBCEA293E3 = rotatevector(_id_441191F2F70023BD, _id_CBC7CF67CCA5129A.angles);
  player shellshock("flashbang_mp", 1);
  waitframe();
  player setOrigin(_id_CBC7CF67CCA5129A.origin + _id_62DED3CBCEA293E3);
  player setplayerangles(_id_CBC7CF67CCA5129A.angles + _id_3FBCCB7168F81992);
}

play_lighting_sequence(targetname) {
  lights = getscriptablearray(targetname, "targetname");

  foreach(light in lights) {
    light setscriptablepartstate("fixture", "on");

    foreach(_id_189F587033CB8F18 in light.attachedlights)
    _id_189F587033CB8F18 setlightintensity(_id_189F587033CB8F18.og_intensity);
  }
}

_id_0C0B9633531D23BA() {
  self.scriptable = spawnscriptable("silo_button_interaction", self.origin, self.angles);
  self.scriptable.parent = self;
}

_id_0BAEFB7122360383() {
  _id_A0CB1D323A1FBA64 = scripts\engine\utility::getStructArray("silo_door_button", "targetname");
  level._id_1C8FC4D6F9FCF7ED = scripts\engine\utility::getStructArray("silo_door_button_outside", "script_noteworthy");

  foreach(struct in _id_A0CB1D323A1FBA64)
  struct _id_0C0B9633531D23BA();

  _id_08556D6CA83DAF66();
}

_id_08556D6CA83DAF66() {
  scripts\engine\scriptable::scriptable_addusedcallback(::_id_7D223D4CCB070697);
}

_id_7D223D4CCB070697(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(isDefined(instance)) {
    if(instance.type == "silo_button_interaction") {
      _id_455A71E8866D3EE1 = 0;

      if(isDefined(instance.parent) && isDefined(instance.parent.script_noteworthy) && instance.parent.script_noteworthy == "silo_door_ee_button") {
        if(_id_1378F1533E0BCFB9(player, "interactable_note_keycard_raid4_ee"))
          _id_455A71E8866D3EE1 = 1;
      }

      if(!istrue(_id_455A71E8866D3EE1)) {
        if(isDefined(level._id_2313A19F59121665)) {
          if(player != level._id_2313A19F59121665) {
            player thread scripts\cp\cp_hud_message::tutorialprint(&"CP_TRAP_ROOM/NO_KEYCARD", 3);
            return;
          }
        } else {
          player thread scripts\cp\cp_hud_message::tutorialprint(&"CP_TRAP_ROOM/NO_KEYCARD", 3);
          return;
        }

        if(!isDefined(level._id_2DFA52A052B72AFA._id_9495681C4A644AA1)) {
          player thread scripts\cp\cp_hud_message::tutorialprint(&"CP_TRAP_ROOM/NO_KEYCARD", 3);
          return;
        } else {
          if(!_id_1378F1533E0BCFB9(player, level._id_2DFA52A052B72AFA._id_9495681C4A644AA1)) {
            player thread scripts\cp\cp_hud_message::tutorialprint(&"CP_RAID_COMPLEX_JUGG_MAZE/WRONG_KEYCARD", 4);
            playsoundatpos(instance.origin, "cp_raid2_keycard_swipe_beep");
            return;
          }

          if(level._id_2DFA52A052B72AFA._id_B97BBDA2597193F1.scriptable != instance) {
            player thread scripts\cp\cp_hud_message::tutorialprint(&"CP_RAID_COMPLEX_JUGG_MAZE/WRONG_KEYCARD", 4);
            playsoundatpos(instance.origin, "cp_raid2_keycard_swipe_beep");
            return;
          }
        }
      }

      level notify("jugg_maze_keycard_success", instance);
      playsoundatpos(instance.origin, "cp_raid2_keycard_door_unlocked_beep");

      foreach(guy in level.players)
      instance disablescriptableplayeruse(guy);

      wait 1.0;
      playsoundatpos(instance.origin, "cp_raid2_keycard_door_unlocked");
      chosen_airlock_door = scripts\engine\utility::getclosest(instance.origin, level.teleport_room_doors);

      if(istrue(chosen_airlock_door._id_CFBBB9493F937B82)) {
        return;
      }
      chosen_airlock_door._id_CFBBB9493F937B82 = 1;

      if(chosen_airlock_door.state == "closed") {
        thread _id_4BB23F70102CF6BC::_id_0F5B7D094EEBD9B3(instance.origin, player);
        time = getanimlength(level.scr_anim["vault_door"]["open"]);
        chosen_airlock_door open_teleport_room_door();
        wait(time);
      } else {
        thread _id_4BB23F70102CF6BC::_id_0F5B7D094EEBD9B3(instance.origin, player);
        time = getanimlength(level.scr_anim["vault_door"]["close"]);
        chosen_airlock_door thread close_teleport_room_door();
        wait(time);
      }

      if(getdvarint("dvar_F6B7211CEC5D4B0E", 0) != 0)
        chosen_airlock_door._id_CFBBB9493F937B82 = 0;
    }
  }
}

_id_1378F1533E0BCFB9(player, keycard) {
  _id_0906B7B454F9A66D = _id_66122A002AFF5D57::_id_C01EB7D2911F26E1(player, keycard);

  if(_id_0906B7B454F9A66D > 0)
    return 1;

  return 0;
}

_id_45AE9C036541A7A9() {
  while(!isDefined(level.stealth))
    waitframe();

  setDvar("dvar_AE9C969DF88E37E1", 5000);
  setDvar("dvar_F72CE39DD23B00D1", 5000);
  setDvar("dvar_CDA36D9770CF5189", 150);
  level.stealth._id_792E4B9A380ADE11 = 5000;
  level.stealth._id_094F8771062F2161 = 5000;
  level.stealth._id_E2E3C78D7DC88605 = 22500;
  _func_4FF17EFD15D01D3F(getdvarint("dvar_0DC22DD1FD6974DC", 900));
  _func_1611D0F6B5F84B9A(getdvarint("dvar_A7482E2717D370C1", 900));
  _func_7AFB89FC511BF315("silenced_shot", 128);
  _func_1A3DD0FBFE26893F("silenced_shot", 256);
  _func_7AFB89FC511BF315("gunshot_teammate", 1024);
  _func_1A3DD0FBFE26893F("gunshot_teammate", 1024);
  level.stealth._id_3495E2E91301FEBD = [];
  level.stealth._id_3495E2E91301FEBD["idle"] = "cp_jugg_maze_stealth_section";
  level.stealth._id_3495E2E91301FEBD["investigate"] = "cp_jugg_maze_stealth_section";
  level.stealth._id_3495E2E91301FEBD["hunt"] = "cp_jugg_maze_stealth_section";
  setDvar("dvar_0DF03D7AC5B31599", 0);

  if(getdvarint("dvar_557F9FB52976C4FE", 0) == 0)
    _func_03875866B3A6D349(1);

  level._id_DA217073B223521A = 1;
}