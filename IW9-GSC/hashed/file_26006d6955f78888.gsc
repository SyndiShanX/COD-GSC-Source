/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_26006d6955f78888.gsc
***********************************************/

main() {
  level._id_EF796AC0B0326726 = ::_id_5D07E8092CB10167;
  level._id_C3A0F3B16CCE4CA9._id_A1E7FB7B162A7323 = ::_id_0A62D0F50F690359;
  level._id_04056F15D39BCF78 = ::_id_2A96CA08E3426168;
  level._id_42354BFD2F2F8439 = ::_id_C6477B99E150A457;
  level.skip_nav_check_on_spectate_respawn = 1;
  level.disable_start_spawn_on_navmesh = 1;
  level._id_A359CB3E2BFA1964 = 0;
  level._id_9EEAB63C54988C55 = 0;
  level._id_359C318944444B78 = 0;
  level._id_318CEAE290567709 = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 0, 0, 1, 0);
  level._id_8EE9C5604A4FB6C0 = 2048;
  level._id_1F9A4D8F7E4586BB = 1;
  scripts\engine\scriptable_door::_id_29BA88E5CE21F3FD(::_id_31C405AA2D21F0B5);
  scripts\engine\scriptable_door::_id_E37078F3D00EF312(::_id_42974A5D66E156B8);
  scripts\engine\scriptable_door::_id_87D7BE37D61CBAE3(::_id_20381C7B081C3F54);

  if(level.script == "cp_raid1_intro")
    scripts\engine\utility::flag_wait("cp_raid1_intro_create_script_completed");
  else
    scripts\engine\utility::flag_wait("cp_raid1_intro_cs_container_completed");

  if(istrue(level._id_E1F6DB0A259574B7)) {
    return;
  }
  thread _id_F253A478190E29D0();
  thread _id_E8EA11A4A414F435();
  thread _id_5048E6EA21E402E0();
  thread _id_261279357BF86D6C();
  thread _id_9884222DE259F62C();
  thread _id_510DCDCBF4FC993C();
  thread _id_E78CB61B13476835();
  thread scripts\cp\coop_stealth::_id_778F9D9E0731E729();
  thread _id_952A793B3FEF082B();
  thread _id_6D1083A44E89852C();
  thread _id_90849BEA55C6A883();
}

_id_90849BEA55C6A883() {
  level._id_FB7FD80599167F74 = spawn("script_model", (9152, 12832, 1552));
  level._id_FB7FD80599167F74 setModel("clip128x128x128");
  level._id_FB7FD80599167F74.angles = (0, 0, 0);
  doors = getentitylessscriptablearray(undefined, undefined, level._id_FB7FD80599167F74.origin, 256, "door");

  foreach(door in doors)
  _id_FBBFE6F05EDA5EB1(door);

  scripts\engine\utility::flag_wait("both_players_intro_binks_complete");

  foreach(door in doors)
  _id_B092780F9EC4496E(door);

  level._id_FB7FD80599167F74 delete();
}

register_objectives() {
  scripts\cp\cp_objectives::registerobjective("raid1_intro", ::_id_1CC62C075A045548, ::_id_928693128E296C9A, ::_id_C6F6D963E427538F, scripts\cp\cp_objectives::debugbeatobjective, ::_id_22DB6F177B7BCCA5);
  scripts\cp\cp_objectives::registerobjective("raid1_mask", ::mask_init, ::_id_89ACBD54365FDE76, ::_id_FF7161E79B7DC173, scripts\cp\cp_objectives::debugbeatobjective, ::_id_5A379CCC24FD65B1);
  scripts\cp\cp_objectives::registerobjective("raid1_enter_maze", ::_id_F17D3135DD46548D, ::_id_9398FBDDF69B8641, ::_id_20A78B442591CFA0, scripts\cp\cp_objectives::debugbeatobjective, ::_id_47A7FDCB52489F3A);
}

_id_1CC62C075A045548(objectivestruct, _id_5DCDFD3A4EFF9961) {
  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(checkpoint == "") {
    if(!istrue(level._id_C04EE29C854B01B8) && !istrue(level._id_4E6D8478422F5569)) {
      level._id_C04EE29C854B01B8 = 1;
      level._id_4E6D8478422F5569 = 1;
    }
  }
}

_id_928693128E296C9A(objectivestruct, _id_5DCDFD3A4EFF9961) {
  scripts\engine\utility::flag_wait("maze_intro_doors_opened");
}

_id_C6F6D963E427538F(objectivestruct, _id_5DCDFD3A4EFF9961) {
  scripts\cp\cp_objectives::overridenextstep(objectivestruct, "raid1_mask");
}

_id_22DB6F177B7BCCA5(objectivestruct) {
  thread _id_7F77182E4FAA9C0F();
}

_id_7F77182E4FAA9C0F() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("strike_init_done");

  if(level.script == "cp_raid1_intro")
    scripts\engine\utility::flag_wait("cp_raid1_intro_create_script_completed");
  else
    scripts\engine\utility::flag_wait("cp_raid1_intro_cs_container_completed");

  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "default_player_start_intro", 1);
}

mask_init(objectivestruct, _id_5DCDFD3A4EFF9961) {}

_id_89ACBD54365FDE76(objectivestruct, _id_5DCDFD3A4EFF9961) {
  scripts\engine\utility::flag_wait("picked_up_oxygen_mask");
}

_id_FF7161E79B7DC173(objectivestruct, _id_5DCDFD3A4EFF9961) {
  scripts\cp\cp_objectives::overridenextstep(objectivestruct, "raid1_enter_maze");
}

_id_5A379CCC24FD65B1(objectivestruct, _id_5DCDFD3A4EFF9961) {}

_id_F17D3135DD46548D(objectivestruct, _id_5DCDFD3A4EFF9961) {}

_id_9398FBDDF69B8641(objectivestruct, _id_5DCDFD3A4EFF9961) {
  scripts\engine\utility::flag_wait("maze_completed");
  level._id_7CAA8AB2F4145CFA = "mx_cp_raid1_puzzleoneshots";
  setmusicstate(level._id_7CAA8AB2F4145CFA);
}

_id_20A78B442591CFA0(objectivestruct, _id_5DCDFD3A4EFF9961) {}

_id_47A7FDCB52489F3A(objectivestruct) {
  thread _id_0630D15B7F9859B2();
}

_id_0630D15B7F9859B2() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("cp_raid1_maze_create_script_completed");
}

_id_952A793B3FEF082B() {
  level endon("stop_intro_vo");
  wait 6;
  scripts\engine\utility::flag_wait("both_players_intro_binks_complete");
  thread _id_669C0F6CB0B7F0CD::_id_5175593A7A2CCDB5();
  thread _id_669C0F6CB0B7F0CD::_id_FC711A4308F52F72();

  if(!isDefined(level.start_point)) {
    return;
  }
  switch (level.start_point) {
    case "raid1_intro":
      _id_669C0F6CB0B7F0CD::_id_97F8AA617741E7FF();
    case "raid1_intro_puzzle":
      _id_669C0F6CB0B7F0CD::_id_0670B7C2821CB804();
    default:
      return;
  }
}

_id_81A2AB3347B15604() {
  level endon("end_claymore_vo_thread");

  if(1) {
    return;
  }
  for(;;) {
    waitframe();

    foreach(_id_656F0AE440B1B5D5 in level._id_B5F9A3C3AC825819) {
      _id_7EF6A8808A48F958 = scripts\engine\utility::getclosest(_id_656F0AE440B1B5D5.origin, level.players, 333);

      if(isDefined(_id_7EF6A8808A48F958))
        level notify("end_claymore_vo_thread");
    }
  }
}

_id_EA3BE33E83F63AEC() {
  level endon("end_bigDoors_vo_thread");

  for(;;) {
    waitframe();

    foreach(_id_656F0AE440B1B5D5 in level._id_B5F9A3C3AC825819) {
      _id_7EF6A8808A48F958 = scripts\engine\utility::getclosest(_id_656F0AE440B1B5D5.origin, level.players, 333);

      if(isDefined(_id_7EF6A8808A48F958))
        level notify("end_bigDoors_vo_thread");
    }
  }
}

_id_5048E6EA21E402E0() {
  wait 10;
}

_id_0A62D0F50F690359() {
  return 4;
}

_id_261279357BF86D6C() {
  if(level.script == "cp_raid1_intro")
    scripts\engine\utility::flag_wait("cp_raid1_intro_create_script_completed");
  else
    scripts\engine\utility::flag_wait("cp_raid1_intro_cs_container_completed");

  if(!isDefined(level._id_6487376C3EC9446B)) {
    level._id_6487376C3EC9446B = getEnt("endofscript_trigger", "targetname");
    level._id_6487376C3EC9446B thread _id_BDC427F957C93E9F();
  }
}

_id_BDC427F957C93E9F() {
  self endon("death");

  for(;;) {
    self waittill("trigger", player);

    if(isDefined(player)) {
      if(!player scripts\cp\utility::is_valid_player()) {
        continue;
      }
      iprintln("End Of Script");
      self delete();
    }
  }
}

_id_E8EA11A4A414F435() {
  thread _id_7D0F9F8E29EAF0AB();
}

_id_F253A478190E29D0() {
  _id_3F20D39AA8BDC920();
  _id_18A73A64992DD07D::run_spawn_module("intro_shotgun_1");
  _id_18A73A64992DD07D::run_spawn_module("intro_shotgun_2");
  _id_18A73A64992DD07D::run_spawn_module("intro_storage_spawners");

  if(!isDefined(level._id_7A491C0AF7FF297C))
    level._id_7A491C0AF7FF297C = getEnt("reinforcements_trigger", "targetname");

  level._id_7A491C0AF7FF297C thread _id_904591D87723966D();

  if(!isDefined(level._id_6EE49CDEB94917B3))
    level._id_6EE49CDEB94917B3 = getEnt("reinforcements_first_trigger", "targetname");

  level._id_6EE49CDEB94917B3 thread _id_0B834C506B6375B9();
  thread spawn_claymore_group("claymore_traps");
  level thread _id_5E17B2A3A47AF9E3();
}

_id_5E17B2A3A47AF9E3() {
  for(;;) {
    _id_62E5520E8111A644 = 0;

    foreach(player in level.players) {
      if(!player istouching(level._id_6EE49CDEB94917B3) && !player istouching(level._id_7A491C0AF7FF297C))
        _id_62E5520E8111A644 = 1;
    }

    if(istrue(_id_62E5520E8111A644)) {
      if(_func_EAC0CD99C9C6D8EE() == "spotted") {}

      return;
    }

    waitframe();
  }
}

_id_0B834C506B6375B9() {
  for(;;) {
    _id_62E5520E8111A644 = 0;

    foreach(player in level.players) {
      if(player istouching(level._id_6EE49CDEB94917B3))
        _id_62E5520E8111A644 = 1;
    }

    if(istrue(_id_62E5520E8111A644)) {
      if(_func_EAC0CD99C9C6D8EE() == "spotted")
        _id_5E5D5AC433C8E1CA("intro_reinforcements_first");

      return;
    }

    waitframe();
  }
}

_id_904591D87723966D() {
  for(;;) {
    _id_62E5520E8111A644 = 0;

    foreach(player in level.players) {
      if(player istouching(level._id_7A491C0AF7FF297C))
        _id_62E5520E8111A644 = 1;
    }

    if(istrue(_id_62E5520E8111A644)) {
      if(!scripts\engine\utility::array_contains(level.active_spawn_modules, "intro_shotgun_final"))
        _id_18A73A64992DD07D::run_spawn_module("intro_shotgun_final");

      if(!scripts\engine\utility::array_contains(level.active_spawn_modules, "intro_shotgun_final_upper"))
        _id_18A73A64992DD07D::run_spawn_module("intro_shotgun_final_upper");

      if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
        if(!scripts\engine\utility::array_contains(level.active_spawn_modules, "intro_jugg_final_hard"))
          _id_18A73A64992DD07D::run_spawn_module("intro_jugg_final_hard");

        if(!scripts\engine\utility::array_contains(level.active_spawn_modules, "intro_lmg_final_hard"))
          _id_18A73A64992DD07D::run_spawn_module("intro_lmg_final_hard");
      }

      if(_func_EAC0CD99C9C6D8EE() == "spotted") {
        if(_id_B7880B1F4A69BF01())
          _id_5E5D5AC433C8E1CA("intro_reinforcements_final");
      }

      thread _id_669C0F6CB0B7F0CD::_id_29ECBC29B4D0FE6A();
      return;
    }

    waitframe();
  }
}

_id_B7880B1F4A69BF01() {
  struct = scripts\engine\utility::getStruct("cctv_hint_security", "targetname");
  _id_CDC5DD6C28C9709D = squared(533);

  if(!isDefined(struct)) {
    if(!scripts\cp\utility::any_player_nearby((2077.37, 18888.6, 1552), _id_CDC5DD6C28C9709D))
      return 1;

    return 0;
  }

  if(!scripts\cp\utility::any_player_nearby(struct.origin, _id_CDC5DD6C28C9709D))
    return 1;

  return 0;
}

_id_3F20D39AA8BDC920() {
  _id_18A73A64992DD07D::registerambientgroup("intro_shotgun_1", 5, 5, 5, 0.05, undefined, "intro_shotgun_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_shotgun_1", ::_id_14FE3380FA58FDF5);
  _id_18A73A64992DD07D::registerambientgroup("intro_shotgun_2", 10, 10, 10, 0.05, undefined, "intro_shotgun_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_shotgun_2", ::_id_14FE3380FA58FDF5);
  _id_18A73A64992DD07D::registerambientgroup("intro_storage_spawners", 4, 4, 4, 0.05, undefined, "intro_storage_spawners", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_storage_spawners", ::_id_14FE3380FA58FDF5);
  _id_18A73A64992DD07D::registerambientgroup("intro_shotgun_final", 5, 5, 5, 0.05, undefined, "intro_shotgun_final", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_shotgun_final", ::_id_F033CE8FEFC9CFDA);
  _id_18A73A64992DD07D::registerambientgroup("intro_lmg_final_hard", 2, 2, 2, 0.05, undefined, "intro_lmg_final_hard", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_lmg_final_hard", ::_id_F033CE8FEFC9CFDA);
  _id_18A73A64992DD07D::registerambientgroup("intro_jugg_final_hard", 2, 2, 2, 0.05, undefined, "intro_jugg_final_hard", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_jugg_final_hard", ::_id_C941F0B372A23D1B);
  _id_18A73A64992DD07D::registerambientgroup("intro_shotgun_final_upper", 2, 2, 2, 0.05, undefined, "intro_shotgun_final_upper", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_shotgun_final_upper", ::_id_01C38898EE1373B9);
  _id_18A73A64992DD07D::registerambientgroup("intro_reinforcements", 4, 4, 4, 0.05, undefined, "intro_reinforcements", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_reinforcements", ::_id_00F596B70FD6B78E);
  _id_18A73A64992DD07D::registerambientgroup("intro_reinforcements_final", 4, 4, 4, 0.05, undefined, "intro_reinforcements_final", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_reinforcements_final", ::_id_00F596B70FD6B78E);
  _id_18A73A64992DD07D::registerambientgroup("intro_reinforcements_first", 4, 4, 4, 0.05, undefined, "intro_reinforcements_first", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_reinforcements_first", ::_id_00F596B70FD6B78E);
  _id_18A73A64992DD07D::registerambientgroup("intro_shotgun_reinforcements", 2, 2, 2, 0.05, undefined, "intro_shotgun_reinforcements", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_shotgun_reinforcements", ::_id_00F596B70FD6B78E);
}

_id_01C38898EE1373B9(group_name, func) {
  setup_soldier_stealth(group_name, func);
  _id_9F4D554E3AE3D383(group_name);
  thread _id_80DC965028D873A2("upstairs");
  scripts\stealth\utility::set_stealth_func("event_investigate", ::_id_F161C068112045E3);
  scripts\stealth\utility::set_stealth_func("event_cover_blown", ::_id_F161C068112045E3);
  scripts\stealth\utility::set_stealth_func("event_combat", ::_id_F161C068112045E3);
  _id_07CE00325DB4A194();

  if(istrue(level._id_5F4F92A8E2B137E7)) {
    if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]()) {
      return;
    }
    self[[self.fnsetstealthstate]]("hunt");
  }
}

_id_F161C068112045E3(event) {
  _id_7B64EABBDC923F61 = ["silenced_shot", "silenced_shot_impact", "death", "ally_killed", "ally_damaged", "footstep", "footstep_sprint", "footstep_walk", "gunshot_impact", "projectile_impact"];
  _id_1F3A015EEC95CC1E = ["silenced_shot", "silenced_shot_impact", "death", "ally_killed", "ally_damaged", "footstep", "footstep_walk", "footstep_sprint"];

  if(scripts\engine\utility::array_contains(_id_7B64EABBDC923F61, event.typeorig)) {
    if(isDefined(event.origin)) {
      if(!self hastacvis(event.origin, 1) && !_id_CA53F38B1EB70113(event.origin, 1, level._id_8EE9C5604A4FB6C0))
        return 1;
      else {}
    }
  }

  if(_id_D4A08728BF86E790(event) && scripts\engine\utility::array_contains(_id_1F3A015EEC95CC1E, event.typeorig))
    return 1;

  if(_id_9A9B91C11482389F(event))
    return 1;

  _id_1C0C872AA3BF0CB0::flashlight_on();
  self laseron();

  if(isDefined(event.type) && event.type == "combat" || event.type == "cover_blown") {
    self.goalradius = 128;
    return 0;
  }

  return 0;
}

_id_D4A08728BF86E790(ent) {
  return abs(ent.origin[2] - self.origin[2]) > 120;
}

_id_9A9B91C11482389F(event) {
  _id_9AE80645C2B78E8A = [];

  if(isDefined(self.stealth._id_90CDC499FC2BDDD7))
    _id_9AE80645C2B78E8A = scripts\cp\utility::array_merge(_id_9AE80645C2B78E8A, self.stealth._id_90CDC499FC2BDDD7);

  if(scripts\engine\utility::array_contains(_id_9AE80645C2B78E8A, event.typeorig))
    return 1;

  _id_1C01519BD9CEC9A6 = event.typeorig == "grenade danger" && isDefined(event.entity) && isDefined(event.entity.weapon_name) && scripts\engine\utility::is_equal(event.entity.weapon_name, "geiger_counter_mp");

  if(_id_1C01519BD9CEC9A6)
    return 1;

  return 0;
}

_id_CA53F38B1EB70113(origin, _id_7E6761D0C6470CA2, dist) {
  if(!isDefined(_id_7E6761D0C6470CA2))
    _id_7E6761D0C6470CA2 = 1;

  if(_id_7E6761D0C6470CA2 && !scripts\engine\utility::within_fov(self.origin, self.angles, origin, cos(180)))
    return 0;

  _id_67245ACC80F2296D = _id_CABCC7C3E8682497();
  _id_C127D102DD2295C3 = _id_0B071913D4B91319();

  if(!isDefined(dist))
    dist = 1024;

  if(!_id_86C6AFB41A6C383B(_id_67245ACC80F2296D, origin, dist))
    return 0;

  if(_id_86C6AFB41A6C383B(_id_67245ACC80F2296D, origin, level.stealth.damage_sight_range))
    return 1;

  if(_id_7E6761D0C6470CA2) {
    if(isai(self) && !self aipointinfov(origin))
      return 0;
  }

  _id_125435EA93CCA389 = level._id_318CEAE290567709;
  return scripts\engine\trace::ray_trace_passed(_id_67245ACC80F2296D, origin, [self], _id_125435EA93CCA389);
}

_id_86C6AFB41A6C383B(start, end, dist) {
  if(!isDefined(start) || !isDefined(end))
    return 0;

  return distancesquared(start, end) <= dist * dist;
}

_id_CABCC7C3E8682497() {
  if(isDefined(self._id_18718F98529A77D8)) {
    if(self._id_695601297697AB71 == gettime())
      return self._id_18718F98529A77D8;

    if(isDefined(self._id_DF2EC152343705D2) && self._id_DF2EC152343705D2 == self.origin)
      return self._id_18718F98529A77D8;
  }

  if(isai(self))
    self._id_18718F98529A77D8 = self getEye();
  else {
    self._id_18718F98529A77D8 = self gettagorigin("tag_eye");
    self._id_DF2EC152343705D2 = self.origin;
  }

  self._id_695601297697AB71 = gettime();
  return self._id_18718F98529A77D8;
}

_id_0B071913D4B91319() {
  if(isDefined(self._id_2B5F8CE7DE8E2AF2)) {
    if(self._id_BE76BF1CCA511D73 == gettime())
      return self._id_2B5F8CE7DE8E2AF2;

    if(isDefined(self._id_87B23FA7022B1C46) && self._id_87B23FA7022B1C46 == self.angles)
      return self._id_2B5F8CE7DE8E2AF2;
  }

  self._id_2B5F8CE7DE8E2AF2 = self gettagangles("tag_eye");
  self._id_BE76BF1CCA511D73 = gettime();
  return self._id_2B5F8CE7DE8E2AF2;
}

_id_C941F0B372A23D1B(group_name) {
  if(_id_18A73A64992DD07D::is_specified_unittype("juggernaut")) {
    scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
    self _meth_B11B5190B03C861C("");
    self.combatmode = "no_cover";
    self._id_2626D6897D71B728 = 2000;
    self._id_85A0F6383A5DD784 = 1200;
    self enabletraversals(0);
    _id_18A73A64992DD07D::set_goal_radius(2048);
    scripts\engine\utility::set_movement_speed(50);
    thread _id_5C60EE71D6E3B4A9(self.spawner);
    thread _id_E3ECA859CF54E448(100);
  }
}

_id_E3ECA859CF54E448(_id_9743A24AC8368484) {
  level endon("game_ended");
  self endon("death");
  self waittill("enter_combat");
  scripts\engine\utility::set_movement_speed(_id_9743A24AC8368484);
}

_id_5C60EE71D6E3B4A9(spawner) {
  level endon("game_ended");
  self endon("death");
  self endon("enter_combat");

  while(isDefined(spawner.target)) {
    _id_57F5444230951BC7 = scripts\engine\utility::getStruct(spawner.target, "targetname");

    if(!isDefined(_id_57F5444230951BC7)) {
      break;
    }

    self setgoalpos(_id_57F5444230951BC7.origin, 64);
    self waittill("goal");
    spawner = _id_57F5444230951BC7;
  }
}

_id_F033CE8FEFC9CFDA(group_name, func) {
  setup_soldier_stealth(group_name, func);
  _id_BBAECC3D1A13A428(group_name);
  scripts\stealth\utility::set_stealth_func("event_investigate", ::_id_F161C068112045E3);
  scripts\stealth\utility::set_stealth_func("event_cover_blown", ::_id_F161C068112045E3);
  scripts\stealth\utility::set_stealth_func("event_combat", ::_id_F161C068112045E3);
  thread _id_80DC965028D873A2("downstairs");
  _id_07CE00325DB4A194();

  if(istrue(level._id_5F4F92A8E2B137E7)) {
    if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]()) {
      return;
    }
    spawner = self.spawner;
    _id_3B2C9CA866EA9EAC = scripts\engine\utility::ter_op(isDefined(spawner.target), scripts\engine\utility::getStruct(spawner.target, "targetname"), scripts\engine\utility::getclosest(self.origin, scripts\engine\utility::getStructArray("dock_edge", "targetname"), 1024));
    self._id_97DB6F81BA0702E3 = 1000;
    self.stealth.script_nexthuntpos = _id_3B2C9CA866EA9EAC.origin;
    self[[self.fnsetstealthstate]]("hunt");
  }
}

_id_07CE00325DB4A194() {
  if(_func_EAC0CD99C9C6D8EE() == "spotted") {
    if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]()) {
      return;
    }
    player = scripts\cp\utility::get_closest_living_player();

    if(isDefined(player)) {
      self setgoalpos(player.origin);
      event = spawnStruct();
      event.typeorig = "combat";
      event.type = "combat";
      event.origin = player.origin;
      event.investigate_pos = player.origin;
      self[[self.fnsetstealthstate]]("combat", event);
    }

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++)
      self getenemyinfo(level.players[_id_AC0E594AC96AA3A8]);

    _id_18A73A64992DD07D::set_goal_radius(2048);
    return;
  }
}

_id_14FE3380FA58FDF5(group_name, func) {
  setup_soldier_stealth(group_name, func);
  _id_BBAECC3D1A13A428(group_name);
  scripts\stealth\utility::set_stealth_func("event_investigate", ::_id_F161C068112045E3);
  scripts\stealth\utility::set_stealth_func("event_cover_blown", ::_id_F161C068112045E3);
  scripts\stealth\utility::set_stealth_func("event_combat", ::_id_F161C068112045E3);
  thread _id_80DC965028D873A2("downstairs");
  _id_07CE00325DB4A194();

  if(istrue(level._id_5F4F92A8E2B137E7)) {
    if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]()) {
      return;
    }
    self[[self.fnsetstealthstate]]("hunt");
  }
}

_id_123701A00E645E19() {
  self.script_forcegrenade = 1;
  self.grenadeammo = 255;
  self.grenadesafedist = 200;
}

_id_D24590F588A71CA2() {
  _id_C729D49D406ACED8 = scripts\cp\utility::get_closest_living_player();

  if(!isDefined(_id_C729D49D406ACED8))
    _id_C729D49D406ACED8 = scripts\engine\utility::getclosest(self.origin, level.players);

  thread _id_43A45E199254CE4F(_id_C729D49D406ACED8);
}

_id_43A45E199254CE4F(player) {
  self endon("death");
  self getenemyinfo(player);
  self.lastenemysightpos = player.origin;

  if(getdvarint("dvar_53839302A8032F77", 1) != 0)
    self._id_5323A94889EFF1DE = 1;

  self.goalradius = 2048;
  self.aggressivemode = 1;
  self setgoalentity(player);
  thread _id_6DAE2816A58B8A6D(player);
}

_id_6DAE2816A58B8A6D(player) {
  self endon("death");
  self endon("stop_player_seek");
  _id_7E1EC739AE6C0015 = 1200;
  _id_016D0BB7FD27FCFC = distance(self.origin, player.origin);

  for(;;) {
    wait 2;
    self clearbtgoal(0);
    self getenemyinfo(player);
    self setgoalentity(player);
    _id_016D0BB7FD27FCFC = _id_016D0BB7FD27FCFC - 175;

    if(_id_016D0BB7FD27FCFC < _id_7E1EC739AE6C0015) {
      _id_016D0BB7FD27FCFC = _id_7E1EC739AE6C0015;
      return;
    }
  }
}

_id_36A68D2EA9C75B0D(_id_F9FA10E07F13F5FD) {
  if(issubstr(_id_F9FA10E07F13F5FD, "ar_laser"))
    return "ar_laser";

  if(issubstr(_id_F9FA10E07F13F5FD, "ar"))
    return "ar";

  if(issubstr(_id_F9FA10E07F13F5FD, "shotgun"))
    return "shotgun";

  if(issubstr(_id_F9FA10E07F13F5FD, "sniper"))
    return "sniper";

  if(issubstr(_id_F9FA10E07F13F5FD, "lmg"))
    return "lmg";

  return _id_F9FA10E07F13F5FD;
}

_id_BBAECC3D1A13A428(group) {
  _id_A664AAD02EE98BD2 = "molotov_mp";
  _id_F9FA10E07F13F5FD = self.spawner.script_noteworthy;
  _id_F9FA10E07F13F5FD = _id_36A68D2EA9C75B0D(_id_F9FA10E07F13F5FD);

  switch (_id_F9FA10E07F13F5FD) {
    case "cartel_shotgun":
    case "shotgun":
      body = "body_sp_opforce_al_qatala_shotgun_1_2";
      head = "head_sp_opforce_al_qatala_ar";
      _id_A664AAD02EE98BD2 = "molotov_mp";
      break;
    case "sniper":
      body = "body_sp_opforce_al_qatala_sniper_1_2";
      head = "head_sp_opforce_al_qatala_ar";
      _id_A664AAD02EE98BD2 = "frag_grenade_mp";
      break;
    case "lmg":
      body = "body_sp_opforce_al_qatala_lmg_1_2";
      head = "head_sp_opforce_al_qatala_ar";
      _id_A664AAD02EE98BD2 = "semtex_mp";
      break;
    case "smg":
      body = "body_sp_opforce_al_qatala_smg_1_2";
      head = "head_sp_opforce_al_qatala_ar";
      _id_A664AAD02EE98BD2 = "smoke_grenade_mp";
      break;
    case "ar_laser":
    case "ar":
      body = "body_sp_opforce_al_qatala_ar_1_2";
      head = "head_sp_opforce_al_qatala_ar";
      _id_A664AAD02EE98BD2 = "flash_mp";
      break;
    default:
      body = "body_sp_opforce_al_qatala_tier_2_1_1";
      head = "head_sp_opforce_al_qatala_tier_2_1_1";
      break;
  }
}

_id_07D1DB2BA1A39D29(body, head, weapon, _id_A664AAD02EE98BD2, helmet) {
  self setModel(body);

  if(isDefined(self.headmodel))
    self detach(self.headmodel);

  self attach(head, "", 1);
  self.headmodel = head;

  if(isDefined(helmet)) {
    self attach(helmet, "", 1);
    self.hatmodel = helmet;
  }

  _id_1C0C872AA3BF0CB0::flashlight_on();
  self laseron();
}

_id_00F596B70FD6B78E(group_name, func) {
  setup_soldier_stealth(group_name, func);
  _id_9F4D554E3AE3D383(group_name);
  self.maxfacenewenemydist = 4000;
  self.baseaccuracy = getdvarfloat("dvar_9F78280356EF4531", 2.0);

  if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]())
    thread _id_D24590F588A71CA2();
  else {
    foreach(player in level.players) {
      if(!istrue(player.inlaststand))
        scripts\engine\utility::delaycall(0.1, ::getenemyinfo, player);
    }

    _id_18A73A64992DD07D::set_goal_radius(2048);
    player = scripts\cp\utility::get_closest_living_player();

    if(isDefined(player)) {
      self setgoalpos(player.origin);
      event = spawnStruct();
      event.typeorig = "combat";
      event.type = "combat";
      event.origin = player.origin;
      event.investigate_pos = player.origin;
      self[[self.fnsetstealthstate]]("combat", event);
      thread _id_D24590F588A71CA2();
      return;
    }

    self[[self.fnsetstealthstate]]("hunt");
  }
}

_id_9F4D554E3AE3D383(group) {
  if(_id_18A73A64992DD07D::is_specified_unittype("juggernaut") || _id_18A73A64992DD07D::is_specified_unittype("dog")) {
    self _meth_B11B5190B03C861C("");
    self.combatmode = "no_cover";
    self._id_2626D6897D71B728 = 2000;
    return;
  }

  _id_A664AAD02EE98BD2 = "frag_grenade_mp";
  _id_16C92180949DB961();
}

_id_16C92180949DB961() {
  _id_1C0C872AA3BF0CB0::flashlight_on();
  self laseron();
}

setup_soldier_stealth(group_name, func) {
  if(getdvarint("dvar_DCF5FCEDE3345FB8", 0) != 0)
    self.ignoreall = 1;

  if(_id_18A73A64992DD07D::is_specified_unittype("juggernaut")) {
    self _meth_B11B5190B03C861C("");
    self.combatmode = "no_cover";
    self._id_2626D6897D71B728 = 2000;
  }

  if(istrue(self.bhasriotshieldattached))
    self._id_2626D6897D71B728 = 1400;

  scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);

  if(getdvarint("dvar_14212EBE71FA1B35", 0) != 0) {
    self _meth_95D5375059C2A022("cp_raid1_intro_longer");
    self _meth_D493E7FE15E5EAF4("cp_raid1_intro_longer");
  } else {
    self _meth_95D5375059C2A022("cp_raid1_intro");
    self _meth_D493E7FE15E5EAF4("cp_raid1_intro");
  }

  self._id_D4C11C85EE9C6A42 = 1500;
  self._id_A4709D00B598B7BF = 1;
  _id_123701A00E645E19();

  if(!_id_2B79931B08683E0A::isshotgunai())
    self _meth_9215CE6FC83759B9(4000);
}

_id_1C8C03372BADE56E() {
  self endon("death_or_disconnect");
  self endon("last_stand");
  level waittill("player_spawned_with_loadout");
  _id_531CB1BE084314F7::br_forcegivecustompickupitem(self, "brloot_offhand_semtex", 0, 2, 0, 0);
  scripts\cp\utility::giveperk("specialty_sixth_sense");
  scripts\cp\utility::giveperk("specialty_hack");
  thread scripts\cp\execution::_id_94C333BD965E6685();
}

_id_7D0F9F8E29EAF0AB() {
  level thread _id_6024AE62A775BA86();
}

_id_6024AE62A775BA86() {
  scripts\engine\utility::flag_wait("level_ready_for_script");
  level._id_1E8FC1E741DC1A34 = getEnt("intro_door_left", "script_noteworthy");
  level._id_A6A27B1987DAF40D = getEnt("intro_door_right", "script_noteworthy");
  level._id_A1A1A2E7A6AC0AEF = getEnt("intro_door_left_brush", "script_noteworthy");
  level._id_E48B2CAF6FFA1196 = getEnt("intro_door_right_brush", "script_noteworthy");
  level._id_A1A1A2E7A6AC0AEF linkTo(level._id_1E8FC1E741DC1A34);
  level._id_E48B2CAF6FFA1196 linkTo(level._id_A6A27B1987DAF40D);
}

_id_AF594BDB5B8E4FEB() {
  for(;;) {
    self waittill("trigger", ent);

    if(!ent scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(istrue(self.disabled)) {
      continue;
    }
    thread scripts\cp\utility::playsoundatpos_safe(self.origin, "cp_puzzledoor_open");
    self _meth_DFB78B3E724AD620(0);
    level._id_528C03AECFD23A0D _meth_DFB78B3E724AD620(0);
    iprintln(" open those crazy big doors now !! ");
    thread _id_561517D90F73C662();
  }
}

_id_561517D90F73C662() {
  if(istrue(level._id_8EBDFE2ABD24D26B)) {
    return;
  }
  level._id_8EBDFE2ABD24D26B = 1;

  if(!isDefined(level._id_DC2DB005C20283BB))
    level._id_DC2DB005C20283BB = 1;

  scripts\engine\utility::flag_set("maze_intro_doors_opened");
  level._id_7CAA8AB2F4145CFA = "mx_cp_raid1_puzzleoneshots";
  setmusicstate(level._id_7CAA8AB2F4145CFA);
  level thread _id_F963DF2D657B3FB9();
  level thread _id_CAC245A406C54AB5();
  _id_4304A1E29279A798 = 24;
  _id_05C5BE3BB256144E = [];
  _id_05C5BE3BB256144E[_id_05C5BE3BB256144E.size] = level._id_1E8FC1E741DC1A34;
  _id_05C5BE3BB256144E[_id_05C5BE3BB256144E.size] = level._id_A6A27B1987DAF40D;
  level._id_1E8FC1E741DC1A34.fxent = scripts\engine\utility::spawn_tag_origin(level._id_1E8FC1E741DC1A34.origin, level._id_1E8FC1E741DC1A34.angles);
  level._id_A6A27B1987DAF40D.fxent = scripts\engine\utility::spawn_tag_origin(level._id_A6A27B1987DAF40D.origin, level._id_A6A27B1987DAF40D.angles);
  level._id_1E8FC1E741DC1A34.fxent setModel("tag_origin_subdoor");
  level._id_1E8FC1E741DC1A34.fxent show();
  level._id_A6A27B1987DAF40D.fxent setModel("tag_origin_subdoor");
  level._id_A6A27B1987DAF40D.fxent show();
  level._id_1E8FC1E741DC1A34.fxent linkTo(level._id_1E8FC1E741DC1A34);
  level._id_A6A27B1987DAF40D.fxent linkTo(level._id_A6A27B1987DAF40D);
  level thread _id_4EF7B47214030AA8(_id_4304A1E29279A798 * 0.8);
  wait 2.5;
  level._id_1E8FC1E741DC1A34.fxent setscriptablepartstate("subdoor", "left_door_foam");
  level._id_A6A27B1987DAF40D.fxent setscriptablepartstate("subdoor", "right_door_foam");
  level._id_1E8FC1E741DC1A34 rotateYaw(-55, _id_4304A1E29279A798, _id_4304A1E29279A798 * 0.3, _id_4304A1E29279A798 * 0.4);
  level._id_A6A27B1987DAF40D rotateYaw(55, _id_4304A1E29279A798, _id_4304A1E29279A798 * 0.3, _id_4304A1E29279A798 * 0.4);
  scripts\engine\utility::play_sound_in_space("cp_raid_intro_door_open_water", (1951, 18358, 1546));
  scripts\engine\utility::play_sound_in_space("cp_raid_intro_door_open", (1951, 18358, 1750));
  wait(_id_4304A1E29279A798);
  level._id_1E8FC1E741DC1A34.fxent delete();
  level._id_A6A27B1987DAF40D.fxent delete();
  wait 6;
  level thread _id_71717E6C4597A196::_id_330C2AB6D9B0CBE0();
}

_id_CAC245A406C54AB5() {
  _id_2AFC91629DE00A1A = scripts\engine\utility::getStruct("cctv_interact_2", "targetname");
  _id_2AFC91629DE00A1A = getclosestpointonnavmesh(_id_2AFC91629DE00A1A.origin);
  _id_8D14BD622ABE0CB5 = undefined;

  if(isDefined(level._id_5A2AF420BC54EE97) && isDefined(level._id_5A2AF420BC54EE97._id_46E51D9C12FF301C)) {
    foreach(_id_DBCE45A33308630D in level._id_5A2AF420BC54EE97._id_46E51D9C12FF301C) {
      if(isDefined(_id_DBCE45A33308630D.name) && _id_DBCE45A33308630D.name == "cctv_interact_2")
        _id_8D14BD622ABE0CB5 = _id_DBCE45A33308630D;
    }
  }

  _id_709BA5EBD730FFAE = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  agents = scripts\engine\utility::get_array_of_closest(_id_2AFC91629DE00A1A, _id_709BA5EBD730FFAE, undefined, undefined, 2048);

  foreach(agent in agents)
  agent aieventlistenerevent("investigate", _id_8D14BD622ABE0CB5, _id_2AFC91629DE00A1A);
}

_id_F963DF2D657B3FB9() {
  level endon("game_ended");
  wait 5;
  _id_669C0F6CB0B7F0CD::_id_DD654A48F02EBFD9();
}

_id_4EF7B47214030AA8(_id_4304A1E29279A798) {
  _id_FD060D980E92432B = scripts\engine\utility::getStruct("intro_tutorialpuzzle_cypher_location", "targetname");
  _id_8A4B695D23F59FB5 = scripts\engine\utility::spawn_tag_origin();
  _id_8A4B695D23F59FB5.origin = _id_FD060D980E92432B.origin + (0, 0, 8);
  _id_8A4B695D23F59FB5 show();
  _id_8A4B695D23F59FB5 playLoopSound("cp_raid_intro_door_alarm_lp");
  wait(_id_4304A1E29279A798);
  wait 5;
  _id_8A4B695D23F59FB5 stoploopsound("cp_raid_intro_door_alarm_lp");
  wait 1;
  _id_8A4B695D23F59FB5 delete();
}

_id_F3416EE6BFA2F955() {
  level endon("game_ended");
  _id_C410B587DC57AF6E = getdvarint("dvar_D534F8E2E07F4673", 1);

  if(_id_C410B587DC57AF6E) {
    self setHintString(&"CP_RAID_WATERMAZE/NO_POWER");
    self setuseholdduration("duration_none");
    self.disabled = 1;
  }

  for(;;) {
    level waittill("maze_power_enabled", _id_3068716C250A5E58, player, _id_B729C64158EE9E78);

    if(istrue(_id_3068716C250A5E58)) {
      self _meth_DFB78B3E724AD620(1);
      self setHintString(&"CP_RAID_WATERMAZE/DOOR_OPEN");
      self setuseholdduration("duration_none");
      self.disabled = 0;
      thread _id_9BD624633C15A154(player, _id_B729C64158EE9E78);
      thread _id_AF594BDB5B8E4FEB();
      continue;
    }

    self setHintString(&"CP_RAID_WATERMAZE/NO_POWER");
    self setuseholdduration("duration_none");
    self.disabled = 1;
  }
}

_id_9BD624633C15A154(_id_54A4A3210A79D76F, _id_CE15E68E59D99AE6) {
  foreach(ai in getaiarray("axis")) {
    if(isDefined(ai)) {
      _id_AEBCD718CC197D49 = distance(ai.origin, _id_54A4A3210A79D76F.origin);

      if(_id_AEBCD718CC197D49 < 2000)
        ai aieventlistenerevent("cover_blown", _id_54A4A3210A79D76F, _id_CE15E68E59D99AE6.origin);
    }
  }
}

_id_55CD3AB76D72BDAF() {
  foreach(door in self.doors)
  door thread _id_C093C2F3D1CFEE0B();
}

_id_C093C2F3D1CFEE0B() {
  level endon("game_ended");
  self notify("puzzle_doors_sound_watchfornotify");
  self endon("puzzle_doors_sound_watchfornotify");

  for(;;) {
    scripts\engine\utility::waittill_any_2("door_open", "door_close");
    thread scripts\cp\utility::playsoundatpos_safe(self.origin, "cp_puzzledoor_open");

    if(!isDefined(level._id_DC2DB005C20283BB))
      level._id_DC2DB005C20283BB = 1;
  }
}

_id_5D07E8092CB10167(stealth_group, _id_65661AE3A873C9AE) {
  if(isDefined(stealth_group) && isstring(stealth_group)) {
    if(!isDefined(level._id_72069798E35CC6BC[stealth_group]))
      level._id_72069798E35CC6BC[stealth_group] = 0;

    level._id_72069798E35CC6BC[stealth_group]++;
    level._id_892990D1B2DA4A65 = 4000000;

    switch (stealth_group) {
      default:
        level thread _id_62B762D8A739DE9E(_id_65661AE3A873C9AE);
        break;
    }
  } else
    level thread _id_62B762D8A739DE9E(_id_65661AE3A873C9AE);
}

_id_62B762D8A739DE9E(_id_65661AE3A873C9AE, _id_C8FCFEAE020541D9) {
  if(!istrue(_id_C8FCFEAE020541D9)) {
    if(_func_EAC0CD99C9C6D8EE() != "spotted" && !istrue(_id_65661AE3A873C9AE)) {
      return;
    }
    if(level._id_A359CB3E2BFA1964 < 1 && level._id_9EEAB63C54988C55 < 1 && level._id_359C318944444B78 < 1) {
      thread _id_922DE60337409A17();
      return;
    }
  }

  wait 2;

  if(_func_EAC0CD99C9C6D8EE() != "spotted") {
    return;
  }
  if(!istrue(level._id_942F39C640EF7CDE)) {
    if(!isDefined(level._id_F75A58E27E264659))
      level._id_F75A58E27E264659 = getEntArray("pa_system", "targetname");

    foreach(_id_CDCD3C78F5177DB6 in level._id_F75A58E27E264659)
    thread scripts\cp\coop_stealth::_id_C72B7181608C8607(_id_CDCD3C78F5177DB6, 1);

    level._id_942F39C640EF7CDE = 1;
    scripts\engine\utility::flag_set("sounded_alarm");
  }

  thread _id_9E5571DD747F3333();
  level._id_B640E3525916BD06 = 1;

  if(!isDefined(level._id_7A491C0AF7FF297C))
    level._id_7A491C0AF7FF297C = getEnt("reinforcements_trigger", "targetname");

  if(!isDefined(level._id_6EE49CDEB94917B3))
    level._id_6EE49CDEB94917B3 = getEnt("reinforcements_first_trigger", "targetname");

  _id_3AD2BE7D5E488DDC = 0;

  foreach(player in level.players) {
    if(player istouching(level._id_7A491C0AF7FF297C))
      _id_3AD2BE7D5E488DDC = 1;
  }

  _id_FF72167D32441E3A = 0;

  foreach(player in level.players) {
    if(player istouching(level._id_6EE49CDEB94917B3))
      _id_FF72167D32441E3A = 1;
  }

  if(istrue(_id_FF72167D32441E3A))
    _id_5E5D5AC433C8E1CA("intro_reinforcements_first");

  if(!istrue(_id_FF72167D32441E3A) && !istrue(_id_3AD2BE7D5E488DDC)) {
    _id_5E5D5AC433C8E1CA("intro_reinforcements");
    _id_5E5D5AC433C8E1CA("intro_shotgun_reinforcements");
  }

  if(istrue(_id_3AD2BE7D5E488DDC)) {
    _id_5E5D5AC433C8E1CA("intro_reinforcements");
    _id_5E5D5AC433C8E1CA("intro_reinforcements_first");
    _id_5E5D5AC433C8E1CA("intro_shotgun_reinforcements");

    if(_id_B7880B1F4A69BF01())
      _id_5E5D5AC433C8E1CA("intro_reinforcements_final");
  }
}

_id_5E5D5AC433C8E1CA(name) {
  if(_id_C21568605A0EB71E(name)) {
    foreach(door in level._id_C7927AECF45A7AED) {
      if(!istrue(door._id_A16669FDD0578E00)) {
        _id_B092780F9EC4496E(door);

        foreach(player in level.players)
        door enablescriptableplayeruse(player);

        if(isDefined(door.nearbysnakecams)) {
          foreach(snakecam in door.nearbysnakecams) {
            foreach(player in level.players)
            snakecam enablescriptableplayeruse(player);
          }
        }
      }
    }

    if(!scripts\engine\utility::array_contains(level.active_spawn_modules, name))
      _id_18A73A64992DD07D::run_spawn_module(name);
  }
}

_id_9E5571DD747F3333() {
  if(isDefined(level._id_44AF77A334B9AE2C)) {
    level._id_44AF77A334B9AE2C _id_FBBFE6F05EDA5EB1(level._id_44AF77A334B9AE2C);

    foreach(player in level.players)
    level._id_44AF77A334B9AE2C disablescriptableplayeruse(player);
  }
}

_id_922DE60337409A17() {
  level notify("reinforcements_spawnReinforcementsIfWorldIsStillInCombat");
  level endon("reinforcements_spawnReinforcementsIfWorldIsStillInCombat");
  wait 5;

  if(_func_EAC0CD99C9C6D8EE() != "spotted") {
    return;
  }
  _id_62B762D8A739DE9E(1);
}

_id_2A96CA08E3426168() {
  while(!isDefined(level.stealth))
    waitframe();

  setDvar("dvar_AE9C969DF88E37E1", 5000);
  setDvar("dvar_F72CE39DD23B00D1", 5000);
  setDvar("dvar_CDA36D9770CF5189", 150);
  level.stealth._id_792E4B9A380ADE11 = 5000;
  level.stealth._id_094F8771062F2161 = 5000;
  level.stealth._id_E2E3C78D7DC88605 = 22500;
  _func_4FF17EFD15D01D3F(2300);
  _func_1611D0F6B5F84B9A(4000);
  _func_7AFB89FC511BF315("silenced_shot", 128);
  _func_1A3DD0FBFE26893F("silenced_shot", 256);
  _func_7AFB89FC511BF315("gunshot_teammate", 1024);
  _func_1A3DD0FBFE26893F("gunshot_teammate", 1024);
  level.stealth._id_3495E2E91301FEBD = [];
  level.stealth._id_3495E2E91301FEBD["idle"] = "cp_raid1_intro";
  level.stealth._id_3495E2E91301FEBD["investigate"] = "cp_raid1_intro";
  level.stealth._id_3495E2E91301FEBD["hunt"] = "cp_raid1_intro";
  setDvar("dvar_0DF03D7AC5B31599", 0);
  _func_03875866B3A6D349(1);
  level._id_DA217073B223521A = 1;
}

_id_80DC965028D873A2(location) {
  self endon("death");

  for(;;) {
    self waittill("weapon_fired");
    level thread _id_AA672E8DA9F814D9(location, 0.05);
  }
}

_id_AA672E8DA9F814D9(region, delay) {
  wait(delay);

  switch (region) {
    case "exterior":
      level._id_359C318944444B78++;
      break;
    case "downstairs":
      level._id_A359CB3E2BFA1964++;
      break;
    case "upstairs":
      level._id_9EEAB63C54988C55++;
      break;
  }
}

_id_B108188EDBFC1E04(weapon_obj) {
  attachment = "laserbox_ads02";

  switch (weapon_obj.classname) {
    case "mg":
      attachment = "laserbox_ads02";
      break;
    case "sniper":
      attachment = "laserbox_ads02";
      break;
    case "smg":
      attachment = "lasercyl_ads02";
      break;
    case "spread":
      attachment = "lasercyl_ads02";
      break;
    case "ar":
      attachment = "laserbox_ads02";
      break;
    case "rifle":
      attachment = "laserbox_ads02";
      break;
    case "pistol":
      attachment = "lasercyl_ads02";
      break;
  }

  return attachment;
}

_id_13B2E016B1AB4103(weapon_obj) {
  attachment = "laserbox_ads02";

  switch (weapon_obj.classname) {
    case "mg":
      attachment = "holo03";
      break;
    case "sniper":
      attachment = "thermal02";
      break;
    case "smg":
      attachment = "reflex02_tall";
      break;
    case "spread":
      attachment = "reflex02_tall";
      break;
    case "ar":
      attachment = "holo03";
      break;
    case "rifle":
      attachment = "holo03";
      break;
    case "pistol":
      if(weapon_obj.basename == "iw9_pi_golf17_mp" || weapon_obj.basename == "iw9_pi_golf18_mp" || weapon_obj.basename == "iw9_pi_papa220_mp")
        attachment = "iw9_minireddot02_pstl";
      else
        attachment = "iw9_minireddot02";

      break;
  }

  if(weapon_obj.basename == "iw9_br_msecho_mp")
    attachment = "arscope_therm01_p01";

  return attachment;
}

addattachmenttoweapon(_id_DD515FCF025B2E79, _id_EFFB4AE1788A8B10) {
  variantid = getweaponvariantindex(_id_DD515FCF025B2E79);
  _id_DD515FCF025B2E79 = _id_DD515FCF025B2E79 getnoaltweapon();
  _id_91BBF8D2294A656E = _id_DD515FCF025B2E79.attachmentvarindices;
  attachments = [];

  foreach(attachment, id in _id_91BBF8D2294A656E)
  attachments[attachments.size] = attachment;

  failed = 0;

  if(scripts\engine\utility::array_contains(attachments, _id_EFFB4AE1788A8B10))
    failed = 1;
  else if(!_id_DD515FCF025B2E79 canuseattachment(_id_EFFB4AE1788A8B10))
    failed = 1;

  if(failed)
    return undefined;

  attachments = scripts\cp\utility::weaponattachremoveextraattachments(attachments, _id_DD515FCF025B2E79);
  _id_7809AD191E44FE6A = [];

  foreach(_id_FE8F7703F6313ED4, attachment in attachments)
  _id_7809AD191E44FE6A[_id_FE8F7703F6313ED4] = _id_91BBF8D2294A656E[attachment];

  attachments[attachments.size] = _id_EFFB4AE1788A8B10;
  _id_7809AD191E44FE6A[_id_7809AD191E44FE6A.size] = 0;
  camo = _id_DD515FCF025B2E79.camo;
  stickers = [];

  if(isDefined(_id_DD515FCF025B2E79.stickerslot0))
    stickers[stickers.size] = _id_DD515FCF025B2E79.stickerslot0;

  if(isDefined(_id_DD515FCF025B2E79.stickerslot1))
    stickers[stickers.size] = _id_DD515FCF025B2E79.stickerslot1;

  if(isDefined(_id_DD515FCF025B2E79.stickerslot2))
    stickers[stickers.size] = _id_DD515FCF025B2E79.stickerslot2;

  if(isDefined(_id_DD515FCF025B2E79.stickerslot3))
    stickers[stickers.size] = _id_DD515FCF025B2E79.stickerslot3;

  if(isDefined(_id_DD515FCF025B2E79._id_B39AC546CC8621F8))
    stickers[stickers.size] = _id_DD515FCF025B2E79._id_B39AC546CC8621F8;

  _id_11A1FA68AEB971C0 = scripts\cp_mp\utility\game_utility::isnightmap();
  _id_DD515FCF025B2E79 = _id_2669878CF5A1B6BC::buildweapon(_id_2669878CF5A1B6BC::getweaponrootname(_id_DD515FCF025B2E79), attachments, camo, "none", variantid, _id_7809AD191E44FE6A, undefined, stickers, _id_11A1FA68AEB971C0);
  return _id_DD515FCF025B2E79;
}

_id_7130A012256D173B() {
  level endon("sequence_ended");

  for(;;) {
    wait 1;
    _id_7CF05B9F257286F5 = _id_B9C1226FDF0CB62D();

    if(_id_7CF05B9F257286F5.size == 0) {
      continue;
    }
    if(_func_EAC0CD99C9C6D8EE() != "spotted") {
      continue;
    }
    _id_DA96C8943126A950 = getaiarray("axis");

    foreach(ai in _id_DA96C8943126A950)
    ai thread _id_AD269850A039A5B6(_id_7CF05B9F257286F5);
  }
}

_id_B9C1226FDF0CB62D() {
  array = [];

  foreach(player in level.players) {
    if(istrue(player _meth_6F55D55CCFF20D14()))
      array = scripts\engine\utility::array_add(array, player);
  }

  return array;
}

_id_AD269850A039A5B6(_id_7CF05B9F257286F5) {
  self endon("death");
  self endon("stop_throwing");
  level endon("stop_force_throwing_grenades_thread");
  self notify("ai_ThrowGrenadesWhilePlayersAreInWater");
  self endon("ai_ThrowGrenadesWhilePlayersAreInWater");

  if(istrue(self.bhasriotshieldattached)) {
    return;
  }
  grenades = 2;
  _id_B98850B58450BF4B = gettime();

  for(;;) {
    if(!isDefined(self.enemy)) {
      wait 0.1;
      continue;
    }

    if(isDefined(self.node) && distance(self.origin, self.node.origin) > 72 || isDefined(self.pathgoalpos)) {
      wait 0.05;
      continue;
    }

    if(gettime() >= _id_B98850B58450BF4B) {
      if(self.enemy _meth_6F55D55CCFF20D14()) {
        thread scripts\cp\utility::_id_AE99616202575E39(self.enemy.origin, "semtex_mp");
        _id_B98850B58450BF4B = gettime() + randomintrange(3, 6) * 1000;
        grenades--;
      } else {
        foreach(player in _id_7CF05B9F257286F5) {
          if(player _meth_6F55D55CCFF20D14()) {
            thread scripts\cp\utility::_id_AE99616202575E39(player.origin, "semtex_mp");
            _id_B98850B58450BF4B = gettime() + randomintrange(3, 6) * 1000;
            grenades--;
          }
        }
      }
    }

    if(grenades == 0) {
      return;
    }
    wait 0.1;
  }
}

_id_06CB156D573D96B9() {
  if(level.script == "cp_raid1_intro")
    scripts\engine\utility::flag_wait("cp_raid1_intro_create_script_completed");
  else
    scripts\engine\utility::flag_wait("cp_raid1_intro_cs_container_completed");

  struct = scripts\engine\utility::getStruct("watermaze_oxygenmask", "targetname");
  mask = level _id_4D5D872A7BD5C0C3::_id_18DFEA62F135DEF6(struct.origin, struct.angles);
  mask waittill("death");
}

_id_4924FEF1A691B814() {
  for(;;) {
    level waittill("picked_oxygen_mask", player);

    if(!isPlayer(player)) {
      continue;
    }
    player thread _id_435C3F85A3D06576::toggle_flashlight(1);
  }
}

spawn_claymore_group(_id_9EA7808F138295B7) {
  if(getdvarint("dvar_0E87416769ABD9B7", 0) != 0) {
    return;
  }
  level._id_B5F9A3C3AC825819 = scripts\engine\utility::getStructArray(_id_9EA7808F138295B7, "targetname");

  foreach(spawner in level._id_B5F9A3C3AC825819)
  thread spawn_enemy_claymore(spawner.origin, spawner.angles);
}

spawn_enemy_claymore(origin, angles, _id_F8F2EBF05B9AF55A) {
  _id_656F0AE440B1B5D5 = magicgrenademanual("claymore_mp", origin + (0, 0, 10), (0, 0, 10));
  _id_656F0AE440B1B5D5 childthread plant_enemy_claymore(origin, angles, _id_F8F2EBF05B9AF55A);
  return _id_656F0AE440B1B5D5;
}

plant_enemy_claymore(origin, angles, _id_F8F2EBF05B9AF55A) {
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
  self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 5, undefined, undefined, undefined, 0.1);
  thread minedamagemonitor();
  thread scripts\cp\cp_claymore::claymore_explodeonnotify();
  thread scripts\cp\cp_claymore::claymore_destroyonemp();
  self setscriptablepartstate("plant", "active", 0);
  wait 0.1;
  self enableplayermarks("equipment");
  self setscriptablepartstate("arm", "active", 0);
  self.equipmentref = "equip_claymore";
  _id_6159D9FD44490F13::_hacksetup();
  thread custom_explode_mine(origin);
  thread _id_669C0F6CB0B7F0CD::_id_2E2D08CB518DBEAF();
  thread scripts\cp\cp_claymore::enemy_claymore_watchfortrigger(_id_F8F2EBF05B9AF55A);
}

makeexplosiveusabletag(tagname, isgrenade) {
  self endon("death");
  self endon("makeExplosiveUnusable");
  owner = self.owner;
  weaponname = self.weapon_name;

  if(!isDefined(isgrenade))
    isgrenade = 0;

  self makeusable();

  if(isgrenade)
    self enablemissilehint(1);
  else
    self setCursorHint("HINT_NOICON");

  self sethinttag(tagname);
  self setuserange(72);
  _id_1DB8D0E02A99C5E2::setexplosiveusablehintstring(self.weapon_name);
  self setHintString(&"COOP_GAME_PLAY/DISABLE_TRAP");

  for(;;) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    self setscriptablepartstate("hacked", "active", 0);
    self playSound("cp_claymore_disable");
    wait 0.25;
    _id_16B65EE43D765196();
    return;
  }
}

_id_16B65EE43D765196() {
  self notify("clean_custom_explode");

  if(isDefined(self.useobj))
    self.useobj delete();

  thread _id_74502A9E0EF1F19C::deleteexplosive();
}

custom_explode_mine(origin) {
  self endon("clean_custom_explode");
  _id_B9CE53DAD043E9E4 = origin + (0, 0, 50) + anglesToForward(self.angles) * 95;
  _id_419BFD33C72E7EF9 = origin + (0, 0, 50) + anglesToForward(self.angles) * 30;
  self waittill("death");
  attacker = getaiarray("axis")[0];
  radiusdamage(_id_419BFD33C72E7EF9, 30, 1000, 200, undefined, "MOD_EXPLOSIVE", "claymore_radial_mp");
  radiusdamage(_id_B9CE53DAD043E9E4, 75, 1000, 80, undefined, "MOD_EXPLOSIVE", "claymore_radial_mp");
}

minedamagemonitor() {
  self endon("mine_triggered");
  self endon("mine_selfdestruct");
  self endon("death");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  attacker = undefined;

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon);

    if(istrue(self.isbeingused)) {
      continue;
    }
    self notify("mine_destroyed");

    if(isDefined(type) && (issubstr(type, "MOD_GRENADE") || issubstr(type, "MOD_EXPLOSIVE")))
      self.waschained = 1;

    if(isDefined(idflags) && idflags &level.idflags_penetration)
      self.wasdamagedfrombulletpenetration = 1;

    self.wasdamaged = 1;

    if(isDefined(attacker))
      self.damagedby = attacker;

    self notify("detonateExplosive", attacker);
    return;
  }
}

enemy_claymore_watchfortrigger(_id_F8F2EBF05B9AF55A) {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  self endon("hacked");

  if(isDefined(self.owner))
    self.owner endon("disconnect");

  contents = physics_createcontents(["physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_solid", "physicscontents_glass", "physicscontents_water"]);

  for(;;) {
    _id_00AF3B9624C6AB60 = level.players;
    forward = anglesToForward(self.angles);
    up = anglestoup(self.angles);
    _id_2CC97E113610CA14 = self.origin + up * 0;
    ignorelist = [self];

    if(isDefined(level.dynamicladders)) {
      foreach(struct in level.dynamicladders)
      ignorelist[ignorelist.size] = struct.ents[0];
    }

    if(istrue(_id_F8F2EBF05B9AF55A))
      _id_00AF3B9624C6AB60 = scripts\engine\utility::array_combine(_id_00AF3B9624C6AB60, getaiarray("allies"));

    foreach(_id_548B9F6609CE3883 in _id_00AF3B9624C6AB60) {
      if(!isDefined(_id_548B9F6609CE3883)) {
        continue;
      }
      if(isPlayer(_id_548B9F6609CE3883) && _id_0AFB7E332AEE4BF2::player_in_laststand(_id_548B9F6609CE3883) || isagent(_id_548B9F6609CE3883) && !isalive(_id_548B9F6609CE3883)) {
        continue;
      }
      if(lengthsquared(_id_548B9F6609CE3883 getentityvelocity()) < 10) {
        continue;
      }
      if(distance2dsquared(_id_548B9F6609CE3883.origin, self.origin) > 50625) {
        continue;
      }
      _id_AD283A45677A1EA3 = _id_548B9F6609CE3883 gettagorigin("j_mainroot");
      _id_44060504F23C16AF = [_id_AD283A45677A1EA3];
      _id_340D59422336E85A = _id_2CC97E113610CA14 - _id_AD283A45677A1EA3;

      if(vectordot(_id_340D59422336E85A, (0, 0, 1)) >= 0)
        _id_44060504F23C16AF[_id_44060504F23C16AF.size] = _id_548B9F6609CE3883 gettagorigin("j_spineupper");
      else
        _id_44060504F23C16AF[_id_44060504F23C16AF.size] = _id_548B9F6609CE3883.origin;

      foreach(_id_A00164B06F60F5E6 in _id_44060504F23C16AF) {
        _id_340D59422336E85A = _id_A00164B06F60F5E6 - self.origin;
        _id_CC00B910BD1D69C8 = vectordot(_id_340D59422336E85A, forward);

        if(_id_CC00B910BD1D69C8 > 192 || _id_CC00B910BD1D69C8 < 20) {
          continue;
        }
        _id_69211973F7D7BBD6 = vectordot(_id_340D59422336E85A, up);

        if(abs(_id_69211973F7D7BBD6) > 32) {
          continue;
        }
        _id_A3D051EF761EFD24 = vectorNormalize(_id_340D59422336E85A);
        _id_74876E67651C79A6 = vectordot(_id_A3D051EF761EFD24, forward);

        if(_id_74876E67651C79A6 < 0.86602) {
          continue;
        }
        _id_E021C2744CC7ED68 = physics_raycast(_id_2CC97E113610CA14, _id_A00164B06F60F5E6, contents, ignorelist, 0, "physicsquery_closest", 1);

        if(isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0) {
          continue;
        }
        playFX(scripts\engine\utility::getfx("claymore_explode"), self.origin, forward, up);
        thread scripts\cp\cp_claymore::claymore_trigger(_id_548B9F6609CE3883);
      }
    }

    wait 0.05;
  }
}

_id_9884222DE259F62C() {
  wait 3;
  level._id_B42BAE31267C8576 = scripts\engine\utility::getStructArray("door_modifier", "targetname");
  level._id_C7927AECF45A7AED = [];

  foreach(_id_133832B8060C9C8B in level._id_B42BAE31267C8576) {
    _id_133832B8060C9C8B._id_3089C6859DE1A2DC = getentitylessscriptablearray(undefined, undefined, _id_133832B8060C9C8B.origin, 128, "door");

    foreach(door in _id_133832B8060C9C8B._id_3089C6859DE1A2DC) {
      _id_133832B8060C9C8B._id_3089C6859DE1A2DC = door;
      level._id_C7927AECF45A7AED = scripts\engine\utility::array_add(level._id_C7927AECF45A7AED, _id_133832B8060C9C8B._id_3089C6859DE1A2DC);
      _id_133832B8060C9C8B._id_3089C6859DE1A2DC _id_FBBFE6F05EDA5EB1(_id_133832B8060C9C8B._id_3089C6859DE1A2DC);
      _id_133832B8060C9C8B._id_3089C6859DE1A2DC.nearbysnakecams = getentitylessscriptablearray("snakecam_interaction", undefined, _id_133832B8060C9C8B._id_3089C6859DE1A2DC.origin, 128);

      if(isDefined(_id_133832B8060C9C8B._id_3089C6859DE1A2DC.nearbysnakecams)) {
        foreach(snakecam in _id_133832B8060C9C8B._id_3089C6859DE1A2DC.nearbysnakecams) {
          foreach(player in level.players)
          snakecam disablescriptableplayeruse(player);
        }
      }
    }
  }
}

_id_E78CB61B13476835() {
  grenades = scripts\engine\utility::getStructArray("semtex_pickup", "targetname");

  foreach(grenade in grenades) {
    _id_06FE80416B4BE165 = _id_66122A002AFF5D57::getitemdropinfo(grenade.origin, grenade.angles);
    _id_CD9D13143E83EEC9 = "brloot_offhand_semtex";
    item = _id_66122A002AFF5D57::spawnpickup(_id_CD9D13143E83EEC9, _id_06FE80416B4BE165, 4, undefined, undefined, 0);
    waitframe();
  }
}

_id_510DCDCBF4FC993C() {
  scripts\engine\utility::flag_wait("level_ready_for_script");
  weapons = [];
  _id_CDE2EC78F52F00F9 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mike4");
  _id_CDE2EC78F52F00F9 = _id_CDE2EC78F52F00F9 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["holo", "silencer"]);
  _id_CDE2E978F52EFA60 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("sbeta");
  _id_CDE2E978F52EFA60 = _id_CDE2E978F52EFA60 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["fourx", "tactical", "silencer"]);
  _id_CDE2EA78F52EFC93 = makeweaponfromstring("iw9_dm_scromeo_mp+ammo_65cm+bar_sn_long_p05+arscope_therm01+grip_angled01+mag_sn_p05+pgrip_aim_p05+rec_scromeo+stock_sn_light_p05");
  _id_CDE2EF78F52F0792 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("limax");
  _id_CDE2F078F52F09C5 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("akilo");
  _id_CDE2F078F52F09C5 = _id_CDE2F078F52F09C5 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["bar_ar_light", "stock_ar_light", "reddot", "silencer"]);
  _id_CDE2ED78F52F032C = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("papa220");
  _id_CDE2ED78F52F032C = _id_CDE2ED78F52F032C _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["reddot", "silencer"]);
  _id_CDE2EE78F52F055F = _id_2669878CF5A1B6BC::buildweapon("iw9_lm_rkilo_mp", scripts\engine\utility::array_combine(_func_6527364C1ECCA6C6("iw9_lm_rkilo_mp"), ["bipod_rkilo", "fourx02"]));
  _id_CDE2EE78F52F055F = _id_CDE2EE78F52F055F _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["reddot", "silencer"]);
  _id_CDE2F378F52F105E = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("aviktor");
  _id_CDE2F378F52F105E = _id_CDE2F378F52F105E _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["holo", "mag_sm_large", "stock_sm_light", "silencer"]);
  _id_CDE2F478F52F1291 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("beta");
  _id_CDE2F478F52F1291 = _id_CDE2F478F52F1291 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["holo", "stockno", "silencer"]);
  _id_F90ED703365EBA0B = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mbravo");
  _id_F90ED603365EB7D8 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mpapa7");
  _id_F90ED603365EB7D8 = _id_F90ED603365EB7D8 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["holo", "mag_sm_xlarge", "stock_sm_heavy", "silencer"]);
  _id_F90ED903365EBE71 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("akilo105");
  _id_F90ED903365EBE71 = _id_F90ED903365EBE71 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["reddot", "silencer"]);
  _id_F90ED803365EBC3E = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("rpapa7");
  weapons = [_id_CDE2EC78F52F00F9, _id_CDE2E978F52EFA60, _id_CDE2EA78F52EFC93, _id_CDE2EF78F52F0792, _id_CDE2F078F52F09C5, _id_CDE2ED78F52F032C, _id_CDE2EE78F52F055F, _id_CDE2F378F52F105E, _id_CDE2F478F52F1291, _id_F90ED703365EBA0B, _id_F90ED603365EB7D8, _id_F90ED903365EBE71, _id_F90ED803365EBC3E];
  _id_A13FD508CAD5931C = scripts\engine\utility::getStructArray("weapon_wall", "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A13FD508CAD5931C.size; _id_AC0E594AC96AA3A8++) {
    _id_28A6B68460F4FD6B = _id_A13FD508CAD5931C[_id_AC0E594AC96AA3A8];
    weapon_object = undefined;

    if(!isDefined(_id_28A6B68460F4FD6B.weaponinfo)) {
      continue;
    }
    switch (_id_28A6B68460F4FD6B.weaponinfo) {
      case "weapon_wm_ar_mike4_brprop":
        weapon_object = _id_CDE2EC78F52F00F9;
        break;
      case "weapon_wm_sn_sbeta_brprop":
        weapon_object = _id_CDE2F478F52F1291;
        break;
      case "weapon_wm_sn_mike14_brprop":
        weapon_object = _id_CDE2EA78F52EFC93;
        break;
      case "weapon_wm_sn_alpha50_brprop":
        weapon_object = _id_CDE2EF78F52F0792;
        break;
      case "weapon_wm_ar_akilo47_brprop":
        weapon_object = _id_CDE2F078F52F09C5;
        break;
      case "weapon_wm_pi_mike1911_brprop":
        weapon_object = _id_CDE2ED78F52F032C;
        break;
      case "weapon_wm_lm_kilo121_brprop":
        weapon_object = _id_CDE2EE78F52F055F;
        break;
      case "weapon_wm_sm_mpapa5_brprop":
        weapon_object = _id_CDE2F378F52F105E;
        break;
      case "weapon_wm_sm_beta_brprop":
        weapon_object = _id_CDE2F478F52F1291;
        break;
      case "weapon_wm_sh_charlie725_brprop":
        weapon_object = _id_F90ED703365EBA0B;
        break;
      case "weapon_wm_sm_mpapa7_brprop":
        weapon_object = _id_F90ED603365EB7D8;
        break;
      case "weapon_wm_ar_kilo433_brprop":
        weapon_object = _id_F90ED903365EBE71;
        break;
      case "weapon_wm_la_rpapa7":
        weapon_object = _id_F90ED803365EBC3E;
        break;
    }

    if(isDefined(weapon_object)) {
      _id_28A6B68460F4FD6B _id_9655BF427A5ABDB8(undefined, weapon_object);
      continue;
    }
  }
}

_id_9655BF427A5ABDB8(sweapon, _id_E6C13F566F945346) {
  if(!isDefined(_id_E6C13F566F945346))
    objweapon = makeweaponfromstring(sweapon);
  else
    objweapon = _id_E6C13F566F945346;

  sweapon = getcompleteweaponname(objweapon);
  _id_B8F5AC23CE0DFDE3 = spawn("weapon_" + sweapon, self.origin, 17);
  _id_B8F5AC23CE0DFDE3.angles = self.angles;
  _id_AEC66C8D309A2AFA = 0;
  _id_5D9B5B689A1846C8 = undefined;

  if(istrue(objweapon.hasalternate)) {
    _id_5D9B5B689A1846C8 = objweapon getaltweapon();
    _id_AEC66C8D309A2AFA = weaponclipsize(_id_5D9B5B689A1846C8);
    _id_B8F5AC23CE0DFDE3 itemweaponsetammo(weaponclipsize(objweapon), weaponstartammo(objweapon), weaponclipsize(objweapon), 1);
  } else
    _id_B8F5AC23CE0DFDE3 itemweaponsetammo(weaponclipsize(objweapon), weaponstartammo(objweapon));

  _id_B8F5AC23CE0DFDE3 thread _id_74502A9E0EF1F19C::watchweaponpickup(weaponclipsize(objweapon), weaponstartammo(objweapon));
  return _id_B8F5AC23CE0DFDE3;
}

_id_7BED63E134C9AE06() {
  self endon("death");

  for(;;) {
    self waittill("trigger", player);

    if(isDefined(player) && isPlayer(player) && !istestclient(player))
      player _id_66122A002AFF5D57::_id_4172A10AE7CBDB41(self);
  }
}

_id_C6477B99E150A457() {
  _id_62B762D8A739DE9E(1, 1);
}

_id_C21568605A0EB71E(group) {
  _id_7540B485C1A55040 = undefined;

  if(isarray(group))
    _id_7540B485C1A55040 = group;
  else
    _id_7540B485C1A55040 = [group];

  _id_D8C114EDA2DADB41 = [];

  foreach(group_name in _id_7540B485C1A55040) {
    _id_5571AE8A9C277A18 = _id_18A73A64992DD07D::get_module_structs_by_groupname(group_name, 1)[0];

    if(isDefined(_id_5571AE8A9C277A18)) {
      _id_D8C114EDA2DADB41 = scripts\engine\utility::array_combine(_id_D8C114EDA2DADB41, _id_5571AE8A9C277A18.ai_spawned);
      _id_D8C114EDA2DADB41 = scripts\engine\utility::array_removedead_or_dying(_id_D8C114EDA2DADB41);
    }
  }

  if(_id_D8C114EDA2DADB41.size > 0)
    return 0;

  return 1;
}

_id_FBBFE6F05EDA5EB1(door) {
  door _meth_9AF4C9B2CC1BF989(1);
  door.blocked = 1;
}

_id_B092780F9EC4496E(door) {
  door _meth_80902296B05BE00A();

  if(isDefined(door._id_5C493302B016B154))
    door._id_5C493302B016B154 _meth_80902296B05BE00A();

  door.blocked = undefined;
  door._id_A16669FDD0578E00 = 1;
}

_id_20381C7B081C3F54(scriptable, player) {}

_id_31C405AA2D21F0B5(scriptable, player) {
  return &"SCRIPT/DOOR_HINT_LOCKED";
}

_id_42974A5D66E156B8(instance, player, _id_85E3240D30E184E7) {
  return 0;
}

_id_6D1083A44E89852C() {
  level endon("game_ended");
  wait 1;
  scripts\engine\utility::flag_wait("strike_init_done");
  wait 5;
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Raid Intro / Open Big Doors\" \"set scr_raidintrodoors 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_CB288DB7EC7C4294", ::_id_C1B7A04C36CFD06E);
}

_id_C1B7A04C36CFD06E() {
  level thread _id_03DAF8A4D8E82EAD::_id_7033B0E641EB8F1D();
}