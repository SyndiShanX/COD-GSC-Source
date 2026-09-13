/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_468e1c93b8555c59.gsc
***********************************************/

_id_99D8908F3450CA06(objectivestruct) {
  _id_382959D7794736CC::_id_D68D0E8E5202A02A("destroyed");
  scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("final_fight");
  scripts\engine\utility::flag_wait("subarea_ready");
  setomnvar("requires_scriptmover_ladder_checks", 1);
  level thread _id_01B1A46EFB26E5A9::_id_E00BA90C8FAF1451();
  level thread _id_24D3D5C5A0521C72::_id_8CE8975F5D76A5CF();
  level thread _id_382959D7794736CC::_id_0C735D60735EDA5F();
  level thread _id_5991758044430CF0();
  thread _id_F907753D9A7BF12F();
  level thread _id_A2DFBDB70D7616C9();
  thread _id_63325153465F8869::_id_FFEC324BD5085987();
  level waittill("saw_used");
  level notify("stop_p3_spawn");
  scripts\engine\utility::flag_wait("sub_door_4_cut");
  _id_60008A9093C7A9B5::_id_33694E6EE38B809F();
  _id_534E4BC58506118D();
  wait 2;
  index = 0;

  foreach(player in level.players) {
    if(!isalive(player) || player isspectatingplayer() || istrue(player.inlaststand)) {
      _id_0AFB7E332AEE4BF2::_id_7956D96AF822A9A3(player);
      starts = scripts\engine\utility::getStructArray("boss_player_final_respawn_spot", "targetname");
      player setOrigin(starts[index].origin);
      index++;
    }

    player thread _id_6F1004E80B298892(1.0, player);
  }

  _id_60008A9093C7A9B5::_id_D3CB8E66A665F324();
  wait 1.0;
  scripts\cp\cp_analytics::_id_B6283AC45A607764("final_fight");
  level notify("endofscripting");
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

#using_animtree("generic_human");

_id_3ABBD8F89AE307D5() {
  struct = scripts\engine\utility::getStruct("player_near_door4", "targetname");

  while(!scripts\cp\utility::any_player_nearby(struct.origin, squared(200)))
    waitframe();

  door = getEnt("boss_exit_door", "targetname");
  door _meth_431D6F8AB1FDC7AB(-52, 0.5);
  level notify("boss_go_behind_glass", struct);
  struct = scripts\engine\utility::getStruct("boss_behind_glass", "targetname");
  struct.angles = struct.angles;
  level._id_E2958F412A7425C0.goalradius = 16;
  _id_A5407B03B3E5F39F = "cp_raid_boss_idles_cap";
  _id_8B461A03A1F82E9F = "caps/cp/cp_raid_esp3_boss_behind_glass_cap";
  anime = % cap_raid_boss1_behind_glass_arrival;
  level._id_E2958F412A7425C0.disablearrivals = 1;
  startorigin = getstartorigin(struct.origin, struct.angles, anime);
  startangles = getstartangles(struct.origin, struct.angles, anime);
  level._id_E2958F412A7425C0._id_83585377F202EB80 = spawnStruct();
  level._id_E2958F412A7425C0._id_83585377F202EB80.startorigin = startorigin;
  level._id_E2958F412A7425C0._id_83585377F202EB80.startangles = startangles;
  level._id_E2958F412A7425C0._id_83585377F202EB80.origin = struct.origin;
  level._id_E2958F412A7425C0._id_83585377F202EB80.angles = struct.angles;
  level._id_E2958F412A7425C0 thread _id_010B6724C15A95E8::_id_B58F0A57ADF2948E(startorigin, _id_A5407B03B3E5F39F, _id_8B461A03A1F82E9F, 0);
}

_id_E3B88D372D2A3112() {
  while(!scripts\cp\utility::any_player_nearby(level._id_E2958F412A7425C0.origin, squared(750)))
    waitframe();

  level._id_E2958F412A7425C0._blackboard._id_A7FAECD16F0E230A = 1;
  door = getEnt("boss_exit_door", "targetname");
  _id_1DEB58575EBB5CFA = scripts\engine\utility::getStruct("boss_teleport_to_igc", "targetname");
  level._id_E2958F412A7425C0 setgoalpos(_id_1DEB58575EBB5CFA.origin, 24);
  level._id_E2958F412A7425C0 aisettargetspeed(250);
  wait 3;
  door _meth_431D6F8AB1FDC7AB(52, 0.5);
  wait 0.5;
  level._id_E2958F412A7425C0 forceteleport(_id_1DEB58575EBB5CFA.origin, _id_1DEB58575EBB5CFA.angles, 200);
}

_id_A2DFBDB70D7616C9() {
  level endon("game_ended");
  level._id_E2958F412A7425C0 notify("stop_boss_behavior");
  level._id_E2958F412A7425C0.ignoreall = 1;
  level._id_E2958F412A7425C0 allowedstances("stand");
  level._id_E2958F412A7425C0.combatmode = "no_cover";
  level._id_E2958F412A7425C0.sprint = 1;
  level._id_E2958F412A7425C0 scripts\common\utility::demeanor_override("sprint");
  scripts\engine\utility::flag_wait_either("sub_door_2_cut", "sub_door_1_cut");
  _id_856C4C1A9BA33034 = scripts\engine\utility::getStruct("boss_attack_electric", "targetname");
  level._id_E2958F412A7425C0 setgoalpos(getclosestpointonnavmesh(_id_856C4C1A9BA33034.origin), 16);
  scripts\engine\utility::flag_wait("sub_door_3_cut");
  level thread _id_3ABBD8F89AE307D5();
  scripts\engine\utility::flag_wait("sub_door_4_cut");
  level thread _id_E3B88D372D2A3112();
}

_id_534E4BC58506118D() {
  level endon("game_ended");
  _id_0C3EA9B1A20FF199 = scripts\engine\utility::getStruct("final_door_marker", "targetname");
  objindex = scripts\cp\cp_objectives::requestworldid("intro", 1);
  objective_setlabel(objindex, &"CP_RAID1_BOSS1/REGROUP");
  objective_position(objindex, _id_0C3EA9B1A20FF199.origin + (0, 0, 10));
  objective_setshowoncompass(objindex, 1);
  objective_icon(objindex, "icon_waypoint_objective_general");
  objective_setshowdistance(objindex, 1);
  objective_setplayintro(objindex, 1);
  objective_state(objindex, "current");

  while(!scripts\cp\utility::are_all_players_nearby(_id_0C3EA9B1A20FF199.origin, 40000))
    wait 0.3;

  thread _id_74C875AE07CB8E69();
  level notify("all_players_near_boss_exit");
}

_id_74C875AE07CB8E69() {
  wait 1;
  level._id_5E80846664C19D84 playSound("cp_raid3_outro_door_hit");
}

_id_5991758044430CF0() {
  level endon("saw_used");
  wait 90;
}

_id_5A51CEFF353EDEF8() {
  level endon("cut_objective_finished");

  for(;;) {
    guys = scripts\cp\cp_spawning_util::_id_81B8EDC3CB076FDA(scripts\engine\utility::getStructArray("saw1_guys", "targetname"), 1);

    while(isalive(guys[0]) || isalive(guys[1]))
      wait 1;

    wait 10;
  }
}

_id_F907753D9A7BF12F() {
  _id_230C7BB3F08D2D78::_id_B0CA36875BE60C39(getEnt("saw_pickup", "targetname"), 1, undefined, "boss_saw_pickup");
  level._id_687A0C9E54346758 = _id_230C7BB3F08D2D78::_id_6D10B2E59026C58F(scripts\engine\utility::getStruct("sub_door_1_obj", "targetname").origin);
  level._id_687A0F9E54346DF1 = _id_230C7BB3F08D2D78::_id_6D10B2E59026C58F(scripts\engine\utility::getStruct("sub_door_2_obj", "targetname").origin);
  door = getEnt("sub_door_1", "targetname");
  interactionstruct = scripts\engine\utility::getStruct("sub_door_1_cut", "targetname");
  _id_558A9A418B2D3405::_id_6ECEF0D5BE659E3A(door, level._id_687A0C9E54346758, interactionstruct.origin, "sub_door_1_cut");
  door = getEnt("sub_door_2", "targetname");
  interactionstruct = scripts\engine\utility::getStruct("sub_door_2_cut", "targetname");
  _id_558A9A418B2D3405::_id_6ECEF0D5BE659E3A(door, level._id_687A0F9E54346DF1, interactionstruct.origin, "sub_door_2_cut");
  level thread _id_1458B0D59B80A47F();
  level thread _id_6A9EBC6F30E37A7C();
}

_id_1458B0D59B80A47F() {
  scripts\engine\utility::flag_wait("sub_door_1_cut");
  clip = getEnt("sub_door_1_clip", "targetname");
  door = getEnt("sub_door_1", "targetname");
  clip linkTo(door);
  clip connectpaths();
  door rotateYaw(120, 0.6);
  door playSound(scripts\engine\utility::random(["iw9_door_metal_heavy_1_open", "iw9_door_metal_heavy_2_open"]));
  clip notsolid();
  _id_806E876A45D194C9();
  _id_25AA71F2E2EB32A9();
}

_id_6A9EBC6F30E37A7C() {
  scripts\engine\utility::flag_wait("sub_door_2_cut");
  clip = getEnt("sub_door_2_clip", "targetname");
  door = getEnt("sub_door_2", "targetname");
  clip linkTo(door);
  clip connectpaths();
  door rotateYaw(120, 0.6);
  door playSound(scripts\engine\utility::random(["iw9_door_metal_heavy_1_open", "iw9_door_metal_heavy_2_open"]));
  _id_806E876A45D194C9();
  _id_25AA71F2E2EB32A9();
}

_id_25AA71F2E2EB32A9() {
  if(isDefined(level._id_687A0E9E54346BBE)) {
    return;
  }
  level._id_687A0E9E54346BBE = _id_230C7BB3F08D2D78::_id_6D10B2E59026C58F(scripts\engine\utility::getStruct("sub_door_3_obj", "targetname").origin);
  door = getEnt("sub_door_3", "targetname");
  interactionstruct = scripts\engine\utility::getStruct("sub_door_3_cut", "targetname");
  _id_558A9A418B2D3405::_id_6ECEF0D5BE659E3A(door, level._id_687A0E9E54346BBE, interactionstruct.origin, "sub_door_3_cut");
  level thread _id_26DF380859DEACF1();
}

_id_26DF380859DEACF1() {
  scripts\engine\utility::flag_wait("sub_door_3_cut");
  clip = getEnt("sub_door_3_clip", "targetname");
  door = getEnt("sub_door_3", "targetname");
  clip linkTo(door);
  clip connectpaths();
  door rotateYaw(120, 0.6);
  door playSound(scripts\engine\utility::random(["iw9_door_metal_heavy_1_open", "iw9_door_metal_heavy_2_open"]));
  level._id_5E80846664C19D84 = spawn("script_model", (15994, 9534.69, 467.607));
  level._id_5E80846664C19D84.angles = (0, 0, 180);
  level._id_5E80846664C19D84 setModel("electrical_cell_door_button_red");
  _id_25AA72F2E2EB34DC();
}

_id_25AA72F2E2EB34DC() {
  level._id_687A119E54347257 = _id_230C7BB3F08D2D78::_id_6D10B2E59026C58F(scripts\engine\utility::getStruct("sub_door_4_obj", "targetname").origin);
  door = getEnt("sub_door_4", "targetname");
  interactionstruct = scripts\engine\utility::getStruct("sub_door_4_cut", "targetname");
  _id_558A9A418B2D3405::_id_6ECEF0D5BE659E3A(door, level._id_687A119E54347257, interactionstruct.origin, "sub_door_4_cut");
  level thread _id_7FBEE803220BC14E();
}

_id_7FBEE803220BC14E() {
  scripts\engine\utility::flag_wait("sub_door_4_cut");
  clip = getEnt("sub_door_4_clip", "targetname");
  door = getEnt("sub_door_4", "targetname");
  clip linkTo(door);
  clip connectpaths();
  door rotateYaw(120, 0.6);
  door playSound(scripts\engine\utility::random(["iw9_door_metal_heavy_1_open", "iw9_door_metal_heavy_2_open"]));
}

_id_806E876A45D194C9() {
  _id_0C4281EAA20D7F9B = scripts\engine\utility::getStructArray("sub_door_1_cut", "targetname");
  _id_6936DF147A7672FC = scripts\engine\utility::getStructArray("sub_door_2_cut", "targetname");

  foreach(interaction in _id_0C4281EAA20D7F9B) {
    if(isDefined(interaction) && isDefined(interaction.interact))
      interaction.interact makeunusable();
  }

  foreach(interaction in _id_6936DF147A7672FC) {
    if(isDefined(interaction) && isDefined(interaction.interact))
      interaction.interact makeunusable();
  }
}