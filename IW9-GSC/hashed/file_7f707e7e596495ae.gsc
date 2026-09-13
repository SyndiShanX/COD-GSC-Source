/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7f707e7e596495ae.gsc
***********************************************/

_id_7AFC5B8F74443ABA() {
  if(isDefined(game["completed_defender_intro"])) {
    level._id_21F279867AD3E473 = 0;
    wait 3;
    scripts\engine\utility::flag_set("defender_intro_completed");
    return;
  }

  level thread _id_6180969B56CB426F();
  level thread _id_8A76BE61007A785A();
  level thread _id_BC078843F4469108();
  level thread _id_6D7723FE67D5EAF1::_id_4FBE9685C432A4AC();
}

_id_BC078843F4469108() {
  level endon("game_ended");
  spawnfunc = _id_18A73A64992DD07D::registerambientgroup;
  [[spawnfunc]]("lone_intro_velikan", 1, 1, 1, 0.1, 0, "lone_intro_velikan", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("lone_intro_velikan", undefined, 20000, 30000);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("lone_intro_velikan", _id_1685E6D8181C932A::spawn_in_cover);
  [[spawnfunc]]("lone_intro_smgs", 10, 10, 10, 0.1, 0, "lone_intro_smgs", undefined, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("lone_intro_smgs", undefined, 20000, 30000);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("lone_intro_smgs", _id_1685E6D8181C932A::spawn_in_cover);
  wait 1;
  _id_C5D70CB59ACE4A06 = _id_18A73A64992DD07D::run_spawn_module("lone_intro_velikan");
  _id_03659633B747A6D6 = _id_18A73A64992DD07D::run_spawn_module("lone_intro_smgs");

  for(guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis"); guys.size == 0; guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis"))
    wait 1;

  while(guys.size > 0) {
    if(guys.size <= 3)
      setomnvar("cp_enemies_remaining", guys.size);
    else
      setomnvar("cp_enemies_remaining", 0);

    wait 0.25;
    guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  }

  setomnvar("cp_enemies_remaining", 0);
  scripts\engine\utility::flag_set("defender_intro_completed");
  game["completed_defender_intro"] = 1;
}

_id_6180969B56CB426F() {
  origin = scripts\engine\utility::getStruct("lone_intro_obj", "targetname").origin;
  objindex = scripts\cp\cp_objectives::requestworldid("defender_lone_intro");
  objective_state(objindex, "current");
  objective_position(objindex, origin);
  objective_icon(objindex, "hud_icon_head_marked");
  objective_setminimapiconsize(objindex, "icon_small");
  objective_setshowdistance(objindex, 1);
  objective_setplayintro(objindex, 0);
  objective_sethot(objindex, 0);
  objective_setownerteam(objindex, "axis");
  objective_setbackground(objindex, 1);
  objective_setlabel(objindex, &"CP_MISSION_DEFENDER/SECURE_THE_AREA");
  scripts\engine\utility::flag_wait("defender_intro_completed");
  objective_delete(objindex);
  scripts\cp\cp_objectives::freeworldidbyobjid(objindex);
}

_id_8A76BE61007A785A() {
  level endon("game_ended");

  while(!isDefined(level.players) || level.players.size == 0)
    wait 1;

  struct = scripts\engine\utility::getStruct("lone_intro_obj", "targetname");
  dist = 9000000;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(struct.origin, dist)) {
      level._id_C67E4686BD0FADFC = 1;

      foreach(player in level.players) {
        if(!isDefined(player.minimapstatetracker) || player.minimapstatetracker == 0)
          player thread scripts\cp\utility::showminimap();
      }

      return;
    }

    wait 0.5;
  }
}

_id_091EF3AA2C696B6F(_id_32F2098B0BA7ED28, _id_5FF76B0E0C5B9EEE) {
  level endon("game_ended");
  level endon("defender_intro_completed");
  _id_240A5ED442A1A68E = level.player;
  scripts\engine\utility::flag_wait("both_players_intro_binks_complete");
  wait 1;

  if(isDefined(level._id_6E0DA54E3DBFD74F))
    level._id_6E0DA54E3DBFD74F scripts\engine\utility::ent_flag_wait("infil_stopped");
  else {
    wait 3;
    _id_850A0F04F8EDABA5 = _id_240A5ED442A1A68E.origin;
    _id_5EC59205989350E7 = _id_240A5ED442A1A68E.angles;

    while(isDefined(_id_240A5ED442A1A68E) && isDefined(_id_240A5ED442A1A68E.origin) && _id_240A5ED442A1A68E.origin == _id_850A0F04F8EDABA5 && _id_240A5ED442A1A68E.angles == _id_5EC59205989350E7)
      wait 0.05;
  }

  while(!isDefined(_id_240A5ED442A1A68E))
    wait 0.5;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_32F2098B0BA7ED28.ai_spawned.size; _id_AC0E594AC96AA3A8++) {
    if(isalive(_id_32F2098B0BA7ED28.ai_spawned[_id_AC0E594AC96AA3A8])) {
      soldier = _id_32F2098B0BA7ED28.ai_spawned[_id_AC0E594AC96AA3A8];
      level thread _id_A495D2F0EB2A23A9(soldier);
    }
  }
}

_id_A495D2F0EB2A23A9(soldier) {
  level endon("game_ended");
  soldier endon("death");
  soldier scripts\common\ai::magic_bullet_shield(1);
  scripts\engine\utility::flag_wait("defender_intro_completed");

  if(isalive(soldier) && isDefined(soldier.magic_bullet_shield))
    soldier thread scripts\common\ai::stop_magic_bullet_shield();
}