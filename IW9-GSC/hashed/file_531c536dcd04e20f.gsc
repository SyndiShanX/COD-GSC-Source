/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_531c536dcd04e20f.gsc
***********************************************/

main() {
  scripts\cp\tripwire_cp::init();
  scripts\cp_mp\tripwire::precachetrap("tripwire_trap_frag", "offhand_wm_grenade_mike67", 1);
  level._id_EF796AC0B0326726 = ::_id_5D07E8092CB10167;
  level._id_04056F15D39BCF78 = ::_id_4A2FEAC0DC1352A6;
  level._id_42354BFD2F2F8439 = ::_id_C6477B99E150A457;
  level.skip_nav_check_on_spectate_respawn = 1;
  level.disable_start_spawn_on_navmesh = 1;
  level._id_A359CB3E2BFA1964 = 0;
  level._id_9EEAB63C54988C55 = 0;
  level._id_359C318944444B78 = 0;
  level._id_318CEAE290567709 = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 0, 0, 1, 0);
  level._id_8EE9C5604A4FB6C0 = 1024;
  level._id_460285F52F6BC514 = 1;
  level._id_5D782F80A85DE595 = [];
  scripts\cp\utility::_id_363A8CF87098E10A();
  level._id_2BC9DA10C058E6BC = getEntArray("vehicle_underside_sightblocker", "targetname");

  foreach(_id_F058EDB91C155846 in level._id_2BC9DA10C058E6BC) {
    _id_F058EDB91C155846.ogorigin = _id_F058EDB91C155846.origin;
    scripts\cp\utility::_id_119B3F1336549DDB("vehicle_storage", _id_F058EDB91C155846);
  }

  level thread _id_47B1122F901E0B5D();
  scripts\engine\scriptable_door::_id_29BA88E5CE21F3FD(::_id_31C405AA2D21F0B5);
  scripts\engine\scriptable_door::_id_E37078F3D00EF312(::_id_42974A5D66E156B8);
  scripts\engine\scriptable_door::_id_87D7BE37D61CBAE3(::_id_20381C7B081C3F54);
  scripts\engine\utility::flag_wait("cp_jugg_maze_stealth_create_script_completed");
  _id_59F9DCFC9C58436A = scripts\engine\utility::getStructArray("stealth_dogtag_reloc", "script_noteworthy");

  if(!isDefined(level._id_B6CD3626C14C131E))
    level._id_B6CD3626C14C131E = [];

  if(isDefined(_id_59F9DCFC9C58436A)) {
    foreach(struct in _id_59F9DCFC9C58436A)
    level._id_B6CD3626C14C131E[level._id_B6CD3626C14C131E.size] = struct;
  }

  level._id_279257756AC8D38F = scripts\engine\utility::getStruct("enemy_sentry_spawn", "targetname");
  thread _id_437AA40D5BF054D3();
  level._id_75AEBC73793D8C40 = getEntArray("tripwire_blocker", "targetname");

  if(getdvarint("dvar_1C4F79C62DD337F0", 1)) {
    thread scripts\cp_mp\tripwire::init();

    foreach(_id_32595262B98E6F31 in level._id_75AEBC73793D8C40) {
      scripts\cp\utility::_id_119B3F1336549DDB("vehicle_storage", _id_32595262B98E6F31);
      _id_32595262B98E6F31 disconnectPaths();
    }
  } else {
    foreach(_id_32595262B98E6F31 in level._id_75AEBC73793D8C40)
    _id_32595262B98E6F31 delete();
  }

  thread _id_11811C954BBA79E3::_id_5A13959F7AF9E427(1);
  thread _id_9884222DE259F62C();
  thread _id_AB1910B1FE79295E();
  thread _id_A85A3BB76B2DE00D();
  thread _id_1E1F8329D840E8DF();

  if(getdvarint("dvar_854CC7FAB5BE182B", 0))
    thread _id_E9D484989CB66D52();

  if(getdvarint("dvar_1C312A6305C960CC", 1))
    thread _id_40761E15A68A9D19();

  thread scripts\cp\coop_stealth::_id_778F9D9E0731E729();
  thread _id_0598E0C00C8151F7::_id_C47EE3C82EA9FA70();
  thread _id_11811C954BBA79E3::_id_85CB4FB3C2383B84();
}

#using_animtree("script_model");

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

_id_1E1F8329D840E8DF() {
  _id_18D47B24198907FA = getEntArray("ee_power_switch", "targetname");

  foreach(button in _id_18D47B24198907FA) {
    _id_C103BFC366A53063 = &"COOP_GAME_PLAY/FLIP_SWITCH";
    thread _id_DA52367A10BB4327(button, _id_C103BFC366A53063, 0);
  }
}

_id_DA52367A10BB4327(button, _id_C103BFC366A53063, _id_F076B9BAF2E13623, _id_FADA7C861D5EDE93, _id_3D3C2619E235F17E, playerent) {
  level endon("game_ended");
  _id_F9F389DB8514931E();
  button makeusable();
  button setHintString(_id_C103BFC366A53063);
  button sethintdisplayrange(150);
  button setCursorHint("HINT_BUTTON");
  button sethintdisplayfov(45);
  button sethintonobstruction("hide");
  button setuseholdduration("duration_none");
  button setuserange(50);
  ent = button _id_4EB04DEA142DC8EA(_id_F076B9BAF2E13623, _id_FADA7C861D5EDE93);
  actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(ent, "player_rig", 1, 1);
  _id_54E38BC53ABC8A5E = scripts\cp_mp\anim_scene::anim_scene_create_actor(button, "power_switch", 0, 0);
  actorplayer scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1);
  actors = [actorplayer, _id_54E38BC53ABC8A5E];
  button scripts\cp_mp\anim_scene::anim_scene(actors, "power_switch", 1, 1);
  level notify("easter_egg_switch_flipped", button.script_noteworthy, ent);
  return ent;
}

_id_8C533B43960E754E(button) {
  button playSound("scn_cp_elevator_button_press");
  button setModel("electrical_cell_door_button_green");
}

_id_4EB04DEA142DC8EA(_id_F076B9BAF2E13623, _id_FADA7C861D5EDE93) {
  ent = undefined;

  for(;;) {
    self waittill("trigger", ent);

    if(!isDefined(ent) || !ent scripts\cp\utility::is_valid_player() || !ent isonground() || ent isjumping()) {
      continue;
    }
    self _meth_DFB78B3E724AD620(0);
    break;
  }

  level notify("player_interaction_success", ent, self);

  if(!isDefined(ent))
    return undefined;

  return ent;
}

_id_47B1122F901E0B5D() {
  level endon("game_ended");
  level endon("stealth_section_complete");

  for(;;) {
    while(_func_EAC0CD99C9C6D8EE() != "spotted")
      waitframe();

    level notify("back_in_combat");

    foreach(_id_F058EDB91C155846 in level._id_2BC9DA10C058E6BC)
    _id_F058EDB91C155846.origin = _id_F058EDB91C155846.ogorigin - (0, 0, 666);

    while(_func_EAC0CD99C9C6D8EE() == "spotted")
      waitframe();

    level notify("back_in_stealth");

    foreach(_id_F058EDB91C155846 in level._id_2BC9DA10C058E6BC)
    _id_F058EDB91C155846.origin = _id_F058EDB91C155846.ogorigin;

    waittillframeend;
  }
}

_id_22D29FC24500AD09(_id_7F5945B55E97B8B0) {
  return getdvarint(_func_2EF675C13CA1C4AF("dvar_49931488CC7CD6BB", _id_7F5945B55E97B8B0), 1);
}

_id_40761E15A68A9D19() {
  _id_90096803CAEAAECD = scripts\engine\utility::getStructArray("at_mine", "targetname");
  _id_7B9275A42826A296(_id_90096803CAEAAECD);
}

_id_7B9275A42826A296(_id_90096803CAEAAECD) {
  if(!isDefined(level._id_495A85B8678D3C6A))
    level._id_495A85B8678D3C6A = [];
  else
    level._id_495A85B8678D3C6A = scripts\engine\utility::array_removeundefined(level._id_495A85B8678D3C6A);

  foreach(loc in _id_90096803CAEAAECD) {
    if(isDefined(loc.script_noteworthy) && loc.script_noteworthy == "hardmode") {
      if(!scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
        continue;
    }

    mine = magicgrenademanual("at_mine_mp", loc.origin + (0, 0, 20), (0, 0, 10));
    mine.team = "axis";
    mine.owner = mine;
    mine.weapon_object = makeweapon("at_mine_mp");
    trace = scripts\engine\trace::_bullet_trace(mine.origin + (0, 0, 20), mine.origin - (0, 0, 250), 0, mine);
    pos = getgroundposition(trace["position"], 2);
    finalangles = trace["normal"];
    mine.angles = finalangles;
    mine.health = 100000;
    mine setCanDamage(1);
    org = getgroundposition(mine.origin, 4, 150);
    org = org + (0, 0, 2.25);
    mine.origin = org;
    mine setscriptablepartstate("arm", "active");
    mine setscriptablepartstate("visibility", "show");
    mine thread scripts\cp\equipment\cp_at_mine::at_mine_plant(mine);
    level thread _id_945A9AB839F2EEA0(mine);
    level._id_495A85B8678D3C6A[level._id_495A85B8678D3C6A.size] = mine;

    if(isDefined(level._id_495A85B8678D3C6A) && level._id_495A85B8678D3C6A.size >= 1)
      scripts\cp\utility::_id_119B3F1336549DDB("laser_mines_mines", mine);
    else
      scripts\cp\utility::_id_119B3F1336549DDB("vehicle_storage", mine);

    waitframe();
  }
}

_id_26C2D9123065FEFB() {
  self endon("death");

  for(;;) {
    self waittill("damage", idamage, eattacker, vdir, vpoint, smeansofdeath, modelname, shitloc, partname, idflags, sweapon, origin, angles, normal, einflictor);
    _id_354C862768CFE202::process_damage_feedback(eattacker, eattacker, idamage, idflags, smeansofdeath, sweapon, vdir, vdir, partname, undefined, self);
    wait 0.25;
    self setscriptablepartstate("explode", "fromDamage");
    self notify("detonate");
    return;
  }
}

_id_945A9AB839F2EEA0(mine) {
  level endon("game_ended");
  mine waittill("death");

  if(isDefined(level._id_495A85B8678D3C6A) && level._id_495A85B8678D3C6A.size >= 1) {
    if(isDefined(level._id_F107BD5B4C54277E) && !istrue(level._id_CD59367309B1C64C))
      mine thread[[level._id_F107BD5B4C54277E]](undefined);
  }

  wait 0.1;
  level notify("trigger_reinforcements_if_applicable");
}

_id_1D2711033DE4EE0B() {
  self endon("entitydeleted");
  _id_F5A2985226F286F0 = 0;
  _id_2237BDCCAB8A4D35 = 0;
  _id_4E7B0DB23C2F971B = 50;

  for(;;) {
    foreach(player in level.players) {
      if(player isufo()) {
        continue;
      }
      if(player scripts\cp_mp\utility\player_utility::isinvehicle()) {
        if(distance2d(self.origin, player.vehicle.origin) < 200)
          _id_F5A2985226F286F0 = 1;

        continue;
      }

      if(abs(player.origin[2] - self.origin[2]) >= _id_4E7B0DB23C2F971B)
        continue;
      else if(distance2d(self.origin, player.origin) < 64)
        _id_2237BDCCAB8A4D35 = 1;
    }

    if(_id_2237BDCCAB8A4D35 || _id_F5A2985226F286F0) {
      break;
    }

    waitframe();
  }

  self setscriptablepartstate("trigger", "active");
  self setscriptablepartstate("launch", "land");
  wait 0.5;

  if(_id_2237BDCCAB8A4D35) {
    level notify("at_mine_exploded_near_player");
    self setscriptablepartstate("explode", "fromPlayer");
  } else
    self setscriptablepartstate("explode", "fromDamage");

  wait 0.4;
  self notify("detonate");
}

_id_AB1910B1FE79295E() {
  level._id_D91C1D1D122F797C = getEnt("endOfScriptTrigger", "targetname");
  level._id_D91C1D1D122F797C thread _id_BDC427F957C93E9F();
}

_id_C5B3082A763524BE(objectivestruct) {
  while(!isDefined(level._id_D91C1D1D122F797C))
    waitframe();

  objectivestruct._id_D31685C0A626FF37 = scripts\cp\cp_objectives::requestworldid("exfil_obj" + objectivestruct.index, 1 + int(objectivestruct.index));
  objective_setplayintro(objectivestruct._id_D31685C0A626FF37, 1);
  objective_setplayoutro(objectivestruct._id_D31685C0A626FF37, 1);
  objective_setlocation(objectivestruct._id_D31685C0A626FF37, 0, level._id_D91C1D1D122F797C.origin);
  objective_state(objectivestruct._id_D31685C0A626FF37, "current");
  objective_icon(objectivestruct._id_D31685C0A626FF37, "icon_waypoint_objective_general");
  level._id_D91C1D1D122F797C._id_D31685C0A626FF37 = objectivestruct._id_D31685C0A626FF37;
}

register_objectives() {
  scripts\cp\cp_objectives::registerobjective("raid4_intro", ::_id_1CC62C075A045548, ::_id_928693128E296C9A, ::_id_C6F6D963E427538F, scripts\cp\cp_objectives::debugbeatobjective, ::_id_22DB6F177B7BCCA5);
}

_id_1CC62C075A045548(objectivestruct, _id_5DCDFD3A4EFF9961) {
  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();
}

_id_928693128E296C9A(objectivestruct, _id_5DCDFD3A4EFF9961) {
  scripts\engine\utility::flag_wait("reached_end_of_sequence");
  iprintln(" END OF SCRIPT... FOR NOW!!");
}

_id_C6F6D963E427538F(objectivestruct, _id_5DCDFD3A4EFF9961) {
  scripts\cp\cp_objectives::overridenextstep(objectivestruct, "turn_off_gas");
}

_id_22DB6F177B7BCCA5(objectivestruct) {
  thread _id_7F77182E4FAA9C0F(objectivestruct);
}

_id_7F77182E4FAA9C0F() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("cp_jugg_maze_stealth_create_script_completed");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "stealth_section_spawner", 1);
}

_id_BDC427F957C93E9F() {
  self endon("death");
  _id_62E11D77B25C1D30::_id_ADD4AC211AB1D84D(self.origin, 666);
  _id_11811C954BBA79E3::_id_C4E1DB936975EB1B();
  level notify("stealth_section_complete");
}

_id_383F128FBDC68574() {
  _id_3F20D39AA8BDC920();

  if(_id_22D29FC24500AD09("a"))
    _id_18A73A64992DD07D::run_spawn_module("intro_section_a");

  if(_id_22D29FC24500AD09("b"))
    _id_18A73A64992DD07D::run_spawn_module("intro_section_b");

  if(_id_22D29FC24500AD09("c"))
    _id_18A73A64992DD07D::run_spawn_module("intro_section_c");

  if(getdvarint("dvar_7FCAC9DE6D8A3F35", 1)) {
    if(_id_22D29FC24500AD09("a"))
      _id_18A73A64992DD07D::run_spawn_module("intro_section_catwalk_a");

    if(_id_22D29FC24500AD09("b"))
      _id_18A73A64992DD07D::run_spawn_module("intro_section_catwalk_b");

    if(_id_22D29FC24500AD09("c"))
      _id_18A73A64992DD07D::run_spawn_module("intro_section_catwalk_c");
  }

  if(_id_22D29FC24500AD09("a"))
    _id_18A73A64992DD07D::run_spawn_module("intro_room_a");

  if(_id_22D29FC24500AD09("b"))
    _id_18A73A64992DD07D::run_spawn_module("intro_room_b");

  if(_id_22D29FC24500AD09("c"))
    _id_18A73A64992DD07D::run_spawn_module("intro_room_c");

  if(_id_22D29FC24500AD09("ab"))
    _id_18A73A64992DD07D::run_spawn_module("intro_room_ab");

  if(!isDefined(level._id_7A491C0AF7FF297C))
    level._id_7A491C0AF7FF297C = getEnt("reinforcements_trigger", "targetname");

  if(!isDefined(level._id_6EE49CDEB94917B3))
    level._id_6EE49CDEB94917B3 = getEnt("reinforcements_first_trigger", "targetname");

  if(!isDefined(level._id_E4259B1F13BE67DF))
    level._id_E4259B1F13BE67DF = getEnt("reinforcements_second_trigger", "targetname");

  if(!isDefined(level._id_7A701334C7E0215E))
    level._id_7A701334C7E0215E = getEntArray("reinforcements_blocker_trigger", "targetname");

  thread spawn_claymore_group("claymore_traps");
}

_id_5E17B2A3A47AF9E3() {
  level notify("game_spawnAIAndReinforcementsWhenPlayersAreInTheSecondArea");
  level endon("game_spawnAIAndReinforcementsWhenPlayersAreInTheSecondArea");

  for(;;) {
    _id_62E5520E8111A644 = 0;

    foreach(player in level.players) {
      if(!player istouching(level._id_6EE49CDEB94917B3) && !player istouching(level._id_7A491C0AF7FF297C))
        _id_62E5520E8111A644 = 1;
    }

    if(istrue(_id_62E5520E8111A644)) {
      if(_func_EAC0CD99C9C6D8EE() == "spotted") {
        if(_id_22D29FC24500AD09("b"))
          _id_5E5D5AC433C8E1CA("intro_reinforcements_second");
        else
          iprintln(" SECTION B IS DISABLED SO NO REINFORCEMENTS!! CHECK DVAR: ^1scr_jugg_maze_stealth_spawners_b");
      }

      return;
    }

    waitframe();
  }
}

_id_904591D87723966D() {
  level notify("game_spawnAIAndReinforcementsWhenPlayersGetCloseToTheFinalSection");
  level endon("game_spawnAIAndReinforcementsWhenPlayersGetCloseToTheFinalSection");

  for(;;) {
    _id_62E5520E8111A644 = 0;

    foreach(player in level.players) {
      if(player istouching(level._id_7A491C0AF7FF297C))
        _id_62E5520E8111A644 = 1;
    }

    if(istrue(_id_62E5520E8111A644)) {
      if(!istrue(level._id_D6B59B9728E6A58F)) {
        if(istrue(level._id_A4930701DE2B0AF3) || istrue(level._id_59B86633C9D847DF)) {
          level._id_942F39C640EF7CDE = undefined;
          scripts\engine\utility::flag_clear("sounded_alarm");
          _id_18A73A64992DD07D::run_spawn_module("intro_room_d");
          level._id_D6B59B9728E6A58F = 1;
        }
      }

      if(_func_EAC0CD99C9C6D8EE() == "spotted") {
        if(_id_22D29FC24500AD09("c"))
          _id_5E5D5AC433C8E1CA("intro_reinforcements_final");
        else
          iprintln(" SECTION C IS DISABLED SO NO REINFORCEMENTS!! CHECK DVAR: ^1scr_jugg_maze_stealth_spawners_c");

        if(istrue(level._id_D6B59B9728E6A58F))
          _id_5E5D5AC433C8E1CA("intro_reinforcements_hard");
      }

      return;
    }

    waitframe();
  }
}

_id_3F20D39AA8BDC920() {
  _id_18A73A64992DD07D::registerambientgroup("intro_section_a", 4, 4, 4, 0.05, undefined, "intro_section_a", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_section_a", ::_id_14FE3380FA58FDF5);
  _id_18A73A64992DD07D::registerambientgroup("intro_section_catwalk_a", 2, 2, 2, 0.05, undefined, "intro_section_catwalk_a", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_section_catwalk_a", ::_id_14FE3380FA58FDF5);
  _id_18A73A64992DD07D::registerambientgroup("intro_section_catwalk_b", 1, 1, 1, 0.05, undefined, "intro_section_catwalk_b", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_section_catwalk_b", ::_id_14FE3380FA58FDF5);
  _id_18A73A64992DD07D::registerambientgroup("intro_section_catwalk_c", 2, 2, 2, 0.05, undefined, "intro_section_catwalk_c", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_section_catwalk_c", ::_id_14FE3380FA58FDF5);
  _id_18A73A64992DD07D::registerambientgroup("intro_section_b", 1, 1, 1, 0.05, undefined, "intro_section_b", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_section_b", ::_id_14FE3380FA58FDF5);
  _id_18A73A64992DD07D::registerambientgroup("intro_section_c", 5, 5, 5, 0.05, undefined, "intro_section_c", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_section_c", ::_id_14FE3380FA58FDF5);
  _id_18A73A64992DD07D::registerambientgroup("intro_room_a", 3, 3, 3, 0.05, undefined, "intro_room_a", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_room_a", ::_id_14FE3380FA58FDF5);
  _id_18A73A64992DD07D::registerambientgroup("intro_room_ab", 3, 3, 3, 0.05, undefined, "intro_room_ab", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_room_ab", ::_id_14FE3380FA58FDF5);
  _id_18A73A64992DD07D::registerambientgroup("intro_room_b", 6, 6, 6, 0.05, undefined, "intro_room_b", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_room_b", ::_id_14FE3380FA58FDF5);
  _id_18A73A64992DD07D::registerambientgroup("intro_room_c", 8, 8, 8, 0.05, undefined, "intro_room_c", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_room_c", ::_id_14FE3380FA58FDF5);
  _id_18A73A64992DD07D::registerambientgroup("intro_room_d", 6, 6, 6, 0.05, undefined, "intro_room_d", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_room_d", ::_id_43F591DD30AF77A4);
  _id_18A73A64992DD07D::registerambientgroup("intro_reinforcements_final", 5, 5, 5, 0.05, undefined, "intro_reinforcements_final", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_reinforcements_final", ::_id_00F596B70FD6B78E);
  _id_18A73A64992DD07D::registerambientgroup("intro_reinforcements_first", 3, 3, 3, 0.05, undefined, "intro_reinforcements_first", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_reinforcements_first", ::_id_00F596B70FD6B78E);
  _id_18A73A64992DD07D::registerambientgroup("intro_reinforcements_second", 4, 4, 4, 0.05, undefined, "intro_reinforcements_second", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_reinforcements_second", ::_id_00F596B70FD6B78E);
  _id_18A73A64992DD07D::registerambientgroup("intro_reinforcements_hard", 6, 6, 6, 0.05, undefined, "intro_reinforcements_hard", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_reinforcements_hard", ::_id_00F596B70FD6B78E);
}

_id_F161C068112045E3(event) {
  _id_7B64EABBDC923F61 = ["silenced_shot", "silenced_shot_impact", "death", "ally_killed", "ally_damaged", "footstep", "footstep_sprint", "footstep_walk", "gunshot_impact", "projectile_impact", "door_open", "missile_spawned"];
  _id_1F3A015EEC95CC1E = ["silenced_shot", "silenced_shot_impact", "death", "ally_killed", "ally_damaged", "footstep", "footstep_walk", "footstep_sprint", "door_open"];

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

  if(event.typeorig == "grenade danger" && event.type != "cover_blown") {
    if(isDefined(event.entity.weapon_name) && issubstr(event.entity.weapon_name, "flash")) {
      _id_106C6FA2ECA424EA = 262144;

      if(!self hastacvis(event.origin))
        return 1;
    }
  }

  if(isDefined(event.type) && event.type == "combat" || event.type == "cover_blown")
    return 0;

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

  _id_4A3A80533AD1E7B0 = 0;

  if(getdvarint("dvar_1994C3FB0C180F74", 1))
    _id_4A3A80533AD1E7B0 = event.typeorig == "grenade danger" && !isDefined(event.entity);

  if(_id_4A3A80533AD1E7B0)
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
  scripts\stealth\utility::set_stealth_func("event_investigate", ::_id_F161C068112045E3);
  scripts\stealth\utility::set_stealth_func("event_cover_blown", ::_id_F161C068112045E3);
  scripts\stealth\utility::set_stealth_func("event_combat", ::_id_F161C068112045E3);
  thread _id_80DC965028D873A2("downstairs");
  _id_F077ADF688122C36 = strtok(group_name.group_name, "_");

  if(scripts\engine\utility::array_contains(_id_F077ADF688122C36, "catwalk"))
    self.dropweapon = 0;

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

_id_E26C402A01C2D25D(name) {
  if(isDefined(level._id_C7927AECF45A7AED)) {
    foreach(door in level._id_C7927AECF45A7AED) {
      if(door._id_3C0969365FB17947 == name && name != "intro_reinforcements_hard") {
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
    }
  }
}

_id_43F591DD30AF77A4(group_name, func) {
  setup_soldier_stealth(group_name, func);
  _id_9F4D554E3AE3D383(group_name);
  _id_E26C402A01C2D25D(group_name.group_name);
  self.maxfacenewenemydist = 4000;
  self.baseaccuracy = getdvarfloat("dvar_9F78280356EF4531", 2.0);

  if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]())
    return;
  else
    self[[self.fnsetstealthstate]]("hunt");

  _id_18A73A64992DD07D::set_goal_radius(2048);
}

_id_00F596B70FD6B78E(group_name, func) {
  setup_soldier_stealth(group_name, func);
  _id_9F4D554E3AE3D383(group_name);
  _id_E26C402A01C2D25D(group_name.group_name);
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
    self _meth_95D5375059C2A022("cp_raid1_intro");
    self _meth_D493E7FE15E5EAF4("cp_raid1_intro");
  } else {
    self _meth_95D5375059C2A022("cp_jugg_maze_stealth_section");
    self _meth_D493E7FE15E5EAF4("cp_jugg_maze_stealth_section");
  }

  self._id_D4C11C85EE9C6A42 = 1500;
  self._id_A4709D00B598B7BF = 1;
  _id_123701A00E645E19();

  if(!_id_2B79931B08683E0A::isshotgunai())
    self _meth_9215CE6FC83759B9(4000);

  level._id_5D782F80A85DE595 = scripts\engine\utility::array_add(level._id_5D782F80A85DE595, self);
}

_id_1C8C03372BADE56E() {
  self endon("death_or_disconnect");
  self endon("last_stand");
  scripts\engine\utility::ent_flag_wait("player_spawned_with_loadout");
  scripts\cp\utility::giveperk("specialty_sixth_sense");
  scripts\cp\utility::giveperk("specialty_hack");
  thread scripts\cp\execution::_id_94C333BD965E6685();
}

_id_CDF07F9BE860BF28() {
  scripts\cp\utility::giveperk("specialty_sixth_sense");
  scripts\cp\utility::giveperk("specialty_hack");
  thread scripts\cp\execution::_id_94C333BD965E6685();
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
  _id_D307D1C62E2260D4 = 1;

  foreach(_id_71C842BBBAFF83CA in level._id_7A701334C7E0215E) {
    foreach(player in level.players) {
      if(isDefined(_id_71C842BBBAFF83CA)) {
        if(!player istouching(_id_71C842BBBAFF83CA)) {
          _id_D307D1C62E2260D4 = undefined;
          break;
        } else
          _id_D307D1C62E2260D4 = 1;
      }
    }
  }

  if(istrue(_id_D307D1C62E2260D4)) {
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

  if(!isDefined(level._id_6EE49CDEB94917B3))
    level._id_6EE49CDEB94917B3 = getEnt("reinforcements_first_trigger", "targetname");

  if(!isDefined(level._id_E4259B1F13BE67DF))
    level._id_E4259B1F13BE67DF = getEnt("reinforcements_second_trigger", "targetname");

  if(!isDefined(level._id_7A491C0AF7FF297C))
    level._id_7A491C0AF7FF297C = getEnt("reinforcements_trigger", "targetname");

  _id_FF72167D32441E3A = 0;

  foreach(player in level.players) {
    if(player istouching(level._id_6EE49CDEB94917B3))
      _id_FF72167D32441E3A = 1;
  }

  _id_D0F896DBDFB07FB0 = 0;

  foreach(player in level.players) {
    if(player istouching(level._id_E4259B1F13BE67DF))
      _id_D0F896DBDFB07FB0 = 1;
  }

  _id_3AD2BE7D5E488DDC = 0;

  foreach(player in level.players) {
    if(player istouching(level._id_7A491C0AF7FF297C))
      _id_3AD2BE7D5E488DDC = 1;
  }

  if(istrue(_id_FF72167D32441E3A)) {
    if(_id_22D29FC24500AD09("a"))
      _id_5E5D5AC433C8E1CA("intro_reinforcements_first");
    else
      iprintln(" SECTION A IS DISABLED SO NO REINFORCEMENTS!! CHECK DVAR: ^1scr_jugg_maze_stealth_spawners_a");

    if(_id_22D29FC24500AD09("b"))
      _id_5E5D5AC433C8E1CA("intro_reinforcements_second");
    else
      iprintln(" SECTION B IS DISABLED SO NO REINFORCEMENTS!! CHECK DVAR: ^1scr_jugg_maze_stealth_spawners_b");

    if(_id_22D29FC24500AD09("c"))
      _id_5E5D5AC433C8E1CA("intro_reinforcements_final");
    else
      iprintln(" SECTION C IS DISABLED SO NO REINFORCEMENTS!! CHECK DVAR: ^1scr_jugg_maze_stealth_spawners_c");

    level._id_A4930701DE2B0AF3 = 1;
    level._id_59B86633C9D847DF = 1;
    level notify("game_spawnAIAndReinforcementsWhenPlayersAreInTheSecondArea");
    level._id_7A491C0AF7FF297C thread _id_904591D87723966D();
  }

  if(istrue(_id_D0F896DBDFB07FB0)) {
    if(_id_22D29FC24500AD09("b"))
      _id_5E5D5AC433C8E1CA("intro_reinforcements_second");
    else
      iprintln(" SECTION B IS DISABLED SO NO REINFORCEMENTS!! CHECK DVAR: ^1scr_jugg_maze_stealth_spawners_b");

    if(_id_22D29FC24500AD09("c"))
      _id_5E5D5AC433C8E1CA("intro_reinforcements_final");
    else
      iprintln(" SECTION C IS DISABLED SO NO REINFORCEMENTS!! CHECK DVAR: ^1scr_jugg_maze_stealth_spawners_c");

    level._id_59B86633C9D847DF = 1;
    level notify("game_spawnAIAndReinforcementsWhenPlayersAreInTheSecondArea");
    level._id_7A491C0AF7FF297C thread _id_904591D87723966D();
  }

  if(istrue(_id_3AD2BE7D5E488DDC)) {
    level notify("game_spawnAIAndReinforcementsWhenPlayersAreInTheSecondArea");

    if(_id_22D29FC24500AD09("c"))
      _id_5E5D5AC433C8E1CA("intro_reinforcements_final");
    else
      iprintln(" SECTION C IS DISABLED SO NO REINFORCEMENTS!! CHECK DVAR: ^1scr_jugg_maze_stealth_spawners_c");

    if(istrue(level._id_D6B59B9728E6A58F))
      _id_5E5D5AC433C8E1CA("intro_reinforcements_hard");
  }
}

_id_5E5D5AC433C8E1CA(name) {
  if(istrue(level._id_A4930701DE2B0AF3) && name == "intro_reinforcements_first") {
    return;
  }
  if(istrue(level._id_59B86633C9D847DF) && name == "intro_reinforcements_second") {
    return;
  }
  if(_id_C21568605A0EB71E(name)) {
    if(isDefined(level._id_C7927AECF45A7AED)) {
      foreach(door in level._id_C7927AECF45A7AED) {
        if(door._id_3C0969365FB17947 == name && name != "intro_reinforcements_hard") {
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

_id_4A2FEAC0DC1352A6() {
  while(!isDefined(level.stealth))
    waitframe();

  setDvar("dvar_AE9C969DF88E37E1", 5000);
  setDvar("dvar_F72CE39DD23B00D1", 5000);
  setDvar("dvar_CDA36D9770CF5189", 150);
  level.stealth._id_792E4B9A380ADE11 = 5000;
  level.stealth._id_094F8771062F2161 = 5000;
  level.stealth._id_E2E3C78D7DC88605 = 22500;
  _func_4FF17EFD15D01D3F(1300);
  _func_1611D0F6B5F84B9A(1300);
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

  _id_11A1FA68AEB971C0 = scripts\cp_mp\utility\game_utility::_id_D2D2B803A7B741A4();
  _id_DD515FCF025B2E79 = _id_2669878CF5A1B6BC::buildweapon(_id_2669878CF5A1B6BC::getweaponrootname(_id_DD515FCF025B2E79), attachments, camo, "none", variantid, _id_7809AD191E44FE6A, undefined, stickers, _id_11A1FA68AEB971C0);
  return _id_DD515FCF025B2E79;
}

spawn_claymore_group(_id_9EA7808F138295B7) {
  for(;;) {
    if(!isDefined(level.players)) {
      waitframe();
      continue;
    }

    if(level.players.size == 0) {
      waitframe();
      continue;
    }

    break;
  }

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
  scripts\cp\utility::_id_119B3F1336549DDB("vehicle_storage", _id_656F0AE440B1B5D5);
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
  thread _id_2E2D08CB518DBEAF();
  thread scripts\cp\cp_claymore::enemy_claymore_watchfortrigger(_id_F8F2EBF05B9AF55A);
}

_id_2E2D08CB518DBEAF() {
  self waittill("ownerChanged");

  if(!isDefined(level._id_B37597284A6DE133)) {
    decks = [];
    decks[decks.size] = scripts\engine\utility::create_deck(["dx_cp_cpr1_intr_pric_itsourclaymorenow", "dx_cp_cpr1_intr_pric_hackedone", "dx_cp_cpr1_intr_pric_disarmed"]);
    decks[decks.size] = scripts\engine\utility::create_deck(["dx_cp_cpr1_intr_fara_hackedthisone", "dx_cp_cpr1_intr_fara_disarmedaclaymore", "dx_cp_cpr1_intr_fara_trapdisarmed"]);
    decks[decks.size] = scripts\engine\utility::create_deck(["dx_cp_cpr1_intr_gazz_hackedaclaymore", "dx_cp_cpr1_intr_gazz_claymoredisarmed"]);
    level._id_B37597284A6DE133 = decks;
  }

  if(!scripts\engine\utility::flag("vo_combat") && !istrue(level._id_9F84E4E1C0C2A033))
    _id_62E11D77B25C1D30::_id_A606867D80CFABD5(self.owner, level._id_B37597284A6DE133, 0.3, 0, 1);
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
    _id_133832B8060C9C8B._id_3089C6859DE1A2DC = getentitylessscriptablearray(undefined, undefined, _id_133832B8060C9C8B.origin, 64, "door");

    foreach(door in _id_133832B8060C9C8B._id_3089C6859DE1A2DC) {
      door._id_3C0969365FB17947 = _id_133832B8060C9C8B.script_noteworthy;
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

_id_437AA40D5BF054D3() {
  scripts\engine\utility::flag_wait("level_ready_for_script");
  weapons = [];
  _id_CDE2EC78F52F00F9 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mike4");
  _id_CDE2EC78F52F00F9 = _id_CDE2EC78F52F00F9 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["hybrid", "silencer", "laser"]);
  _id_CDE2EC78F52F00F9 = _id_CDE2EC78F52F00F9 _meth_ 1 BD5B3BEF3D9A61(["grip_vertshort02", "bar_ar_short_p01_mike4"]);
  _id_CDE2E978F52EFA60 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("sbeta");
  _id_CDE2E978F52EFA60 = _id_CDE2E978F52EFA60 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["fourx", "tactical", "silencer", "laser"]);
  _id_CDE2EA78F52EFC93 = makeweaponfromstring("iw9_dm_scromeo_mp+ammo_65cm+bar_sn_long_p05+arscope_therm01+grip_angled01+mag_sn_p05+pgrip_aim_p05+rec_scromeo+stock_sn_light_p05+laserbox_ads03+silencer05_br");
  _id_CDE2EF78F52F0792 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("limax");
  _id_CDE2EF78F52F0792 = _id_CDE2EF78F52F0792 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["silencer", "laser"]);
  _id_CDE2F078F52F09C5 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("akilo");
  _id_CDE2F078F52F09C5 = _id_CDE2F078F52F09C5 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["bar_ar_light", "stock_ar_light", "reddot", "silencer", "laser"]);
  _id_CDE2ED78F52F032C = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("papa220");
  _id_CDE2ED78F52F032C = _id_CDE2ED78F52F032C _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["reddot", "silencer", "laser"]);
  _id_F90EDB03365EC2D7 = _id_2669878CF5A1B6BC::buildweapon("iw9_pi_decho_mp", scripts\engine\utility::array_combine(_func_6527364C1ECCA6C6("iw9_pi_decho_mp"), ["ammo_50p", "bar_pi_hvylong_p25", "comp_decho_01", "mag_pi_large_p25", "stockno_pi_p25", "trigger_p25"]));
  _id_F90EDB03365EC2D7 = _id_F90EDB03365EC2D7 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["reddot", "silencer", "laser"]);
  _id_F90EDA03365EC0A4 = _id_2669878CF5A1B6BC::buildweapon("iw9_pi_papa220_mp", scripts\engine\utility::array_combine(_func_6527364C1ECCA6C6("iw9_pi_papa220_mp"), ["silencer01_pi", "iw9_minireddot01_pstl"]));
  _id_F90EDA03365EC0A4 = _id_F90EDA03365EC0A4 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["reddot", "silencer", "laser"]);
  _id_F90EDD03365EC73D = _id_2669878CF5A1B6BC::buildweapon("iw9_pi_golf17_mp", scripts\engine\utility::array_combine(_func_6527364C1ECCA6C6("iw9_pi_golf17_mp"), ["mag_pi_xlarge_p24"]));
  _id_F90EDD03365EC73D = _id_F90EDD03365EC73D _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["reddot", "silencer", "laser"]);
  _id_CDE2EE78F52F055F = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mike14");
  _id_CDE2EE78F52F055F = _id_CDE2EE78F52F055F _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["holo", "silencer", "laser"]);
  _id_CDE2EE78F52F055F = _id_CDE2EE78F52F055F _meth_ 1 BD5B3BEF3D9A61(["stock_dm_light_p18_mike14", "mag_sn_large_p18", "fourx06"]);
  _id_CDE2F378F52F105E = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("aviktor");
  _id_CDE2F378F52F105E = _id_CDE2F378F52F105E _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["holo", "mag_sm_large", "stock_sm_light", "silencer", "laser"]);
  _id_CDE2F478F52F1291 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("beta");
  _id_CDE2F478F52F1291 = _id_CDE2F478F52F1291 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["holo", "stockno", "silencer", "laser"]);
  _id_F90ED703365EBA0B = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mbravo");
  _id_F90ED703365EBA0B = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mike1014");
  _id_F90ED703365EBA0B = _id_F90ED703365EBA0B _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["grip_angled", "ammo_12g_db_mike1014", "bolt_lgt_p12", "silencer", "laser"]);
  _id_F90ED603365EB7D8 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mpapa7");
  _id_F90ED603365EB7D8 = _id_F90ED603365EB7D8 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["holo", "mag_sm_xlarge", "stock_sm_heavy", "silencer", "laser"]);
  _id_F90ED903365EBE71 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("akilo105");
  _id_F90ED903365EBE71 = _id_F90ED903365EBE71 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["reddot", "silencer", "laser"]);
  _id_F90ED803365EBC3E = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("rpapa7");
  weapons = [_id_CDE2EC78F52F00F9, _id_CDE2E978F52EFA60, _id_CDE2EA78F52EFC93, _id_CDE2EF78F52F0792, _id_CDE2F078F52F09C5, _id_CDE2ED78F52F032C, _id_CDE2EE78F52F055F, _id_CDE2F378F52F105E, _id_CDE2F478F52F1291, _id_F90ED703365EBA0B, _id_F90ED603365EB7D8, _id_F90ED903365EBE71, _id_F90ED803365EBC3E, _id_F90EDB03365EC2D7, _id_F90EDA03365EC0A4, _id_F90EDD03365EC73D];
  _id_A13FD508CAD5931C = scripts\engine\utility::getStructArray("weapon_wall", "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A13FD508CAD5931C.size; _id_AC0E594AC96AA3A8++) {
    _id_28A6B68460F4FD6B = _id_A13FD508CAD5931C[_id_AC0E594AC96AA3A8];
    weapon_object = undefined;

    if(!isDefined(_id_28A6B68460F4FD6B.weaponinfo)) {
      continue;
    }
    switch (_id_28A6B68460F4FD6B.weaponinfo) {
      case "weapon_wm_ar_mike4_brprop":
        weapon_object = _id_F90ED903365EBE71;
        break;
      case "weapon_wm_sn_sbeta_brprop":
        weapon_object = _id_CDE2EA78F52EFC93;
        break;
      case "weapon_wm_pi_mike1911_brprop":
        weapon_object = _id_F90EDD03365EC73D;
        break;
      case "weapon_wm_lm_kilo121_brprop":
        weapon_object = _id_CDE2F078F52F09C5;
        break;
      case "weapon_wm_sm_mpapa5_brprop":
        weapon_object = _id_F90ED603365EB7D8;
        break;
      case "weapon_wm_sh_charlie725_brprop":
        weapon_object = _id_F90ED703365EBA0B;
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
  clipammo = weaponclipsize(objweapon);
  stockammo = weaponstartammo(objweapon);

  if(scripts\cp\cp_relics::is_relic_active("relic_oneInTheChamber")) {
    clipammo = 1;
    stockammo = 0;
  }

  if(istrue(objweapon.hasalternate)) {
    _id_5D9B5B689A1846C8 = objweapon getaltweapon();
    _id_AEC66C8D309A2AFA = weaponclipsize(_id_5D9B5B689A1846C8);
    _id_B8F5AC23CE0DFDE3 itemweaponsetammo(weaponclipsize(objweapon), weaponstartammo(objweapon), weaponclipsize(objweapon), 1);
  } else
    _id_B8F5AC23CE0DFDE3 itemweaponsetammo(weaponclipsize(objweapon), weaponstartammo(objweapon));

  _id_B8F5AC23CE0DFDE3 thread _id_74502A9E0EF1F19C::watchweaponpickup(weaponclipsize(objweapon), weaponstartammo(objweapon));
  scripts\cp\utility::_id_119B3F1336549DDB("vehicle_storage", _id_B8F5AC23CE0DFDE3);
  return _id_B8F5AC23CE0DFDE3;
}

_id_E9D484989CB66D52() {
  _id_CEB14301C666FBAE();
  level._id_279257756AC8D38F.turret = _id_D1696D22C979A9B1(level._id_279257756AC8D38F, undefined, "weapon_wm_mg_sentry_turret");
}

_id_D1696D22C979A9B1(_id_804269875F5062F1, _id_0E86180E07331051, _id_076BA9E808A42F81) {
  sentrytype = "sniper_sentry";
  config = level.sentrysettings[sentrytype];
  turret = spawnturret("misc_turret", _id_804269875F5062F1.origin, level.sentrysettings[sentrytype].weaponinfo);
  turret.team = "axis";

  if(!isDefined(_id_804269875F5062F1.angles))
    _id_804269875F5062F1.angles = (0, 0, 0);

  turret.angles = _id_804269875F5062F1.angles;
  turret.health = config.maxhealth;
  turret.maxhealth = config.maxhealth;
  turret.sentrytype = sentrytype;
  turret.turrettype = sentrytype;
  turret._id_0E86180E07331051 = scripts\engine\utility::ter_op(isDefined(_id_0E86180E07331051), _id_0E86180E07331051, "rpg");
  turret.momentum = 0;
  turret.heatlevel = 0;
  turret.overheated = 0;
  turret.cooldownwaittime = 2;
  turret.maxrange = level.sentrysettings[sentrytype].maxrange;
  turret._id_947AF351CE904AA5 = level.sentrysettings[sentrytype]._id_947AF351CE904AA5;
  turret.owner = turret;

  if(isDefined(_id_804269875F5062F1.radius)) {
    _id_CDC5DD6C28C9709D = _id_804269875F5062F1.radius * _id_804269875F5062F1.radius;
    turret.maxrange = int(_id_CDC5DD6C28C9709D - _id_CDC5DD6C28C9709D * 0.1);
    turret._id_947AF351CE904AA5 = int(_id_CDC5DD6C28C9709D);
  }

  if(!isDefined(_id_076BA9E808A42F81))
    _id_076BA9E808A42F81 = "";

  turret setModel(_id_076BA9E808A42F81);
  turret setturretteam("axis");
  turret makeunusable();
  turret setnodeploy(1);
  turret setdefaultdroppitch(0);
  turret setautorotationdelay(0.2);
  turret maketurretinoperable();
  turret setleftarc(90);
  turret setrightarc(90);
  turret setbottomarc(50);
  turret settoparc(60);
  turret setconvergencetime(0.6, "pitch");
  turret setconvergencetime(0.6, "yaw");
  turret setconvergenceheightpercent(0.65);
  turret setdefaultdroppitch(-89.0);
  turret setturretmodechangewait(1);
  turret solid();
  turret scripts\cp_mp\emp_debuff::set_start_emp_callback(_id_4B02400DAD63CAFB::sentryturret_empstarted);
  turret scripts\cp_mp\emp_debuff::set_clear_emp_callback(_id_4B02400DAD63CAFB::sentryturret_empcleared);
  _id_804269875F5062F1.turret = turret;
  turret._id_779C916529C44B1A = _id_804269875F5062F1;

  if(!isDefined(level.killstreak_additional_targets))
    level.killstreak_additional_targets = [];

  level.killstreak_additional_targets = scripts\engine\utility::array_add(level.killstreak_additional_targets, turret);

  if(!isDefined(level._id_CEEF08CFB883A461))
    level._id_CEEF08CFB883A461 = [];

  level._id_CEEF08CFB883A461 = scripts\engine\utility::array_add(level._id_CEEF08CFB883A461, turret);
  wait 1;
  turret setmode(level.sentrysettings[turret.turrettype].sentrymodeon);
  turret laseron();
  turret _id_4B02400DAD63CAFB::sentryturret_empupdate();
  turret _id_4B02400DAD63CAFB::_id_43F24FF330813DEC();
  turret thread wait_for_sentry_acquire_target(turret);
  turret thread _id_4B02400DAD63CAFB::damage_feedback_watch();
  turret thread _id_006ED15A22994062();

  if(turret._id_0E86180E07331051 == "airstrike")
    turret thread _id_4B02400DAD63CAFB::_id_6A1CA8DE6B373B9A();

  return turret;
}

_id_006ED15A22994062() {
  self waittill("death");
  level.killstreak_additional_targets = scripts\engine\utility::array_remove(level.killstreak_additional_targets, self);
  level._id_CEEF08CFB883A461 = scripts\engine\utility::array_remove(level._id_CEEF08CFB883A461, self);
  thread _id_4B02400DAD63CAFB::_id_86D00513B000B479();

  if(!isDefined(self)) {
    return;
  }
  self setmode("sentry_offline");
  self setscriptablepartstate("explode", "violent");

  if(isDefined(self.attackerdata)) {
    foreach(player in level.players) {
      _id_54351D786449EE9E = 0;

      if(isDefined(self.attackerdata[player.guid]) && isDefined(self.attackerdata[player.guid].damage)) {
        if(self.attackerdata[player.guid].damage >= self.maxhealth * 0.1)
          _id_54351D786449EE9E = 1;

        if(self.attackerdata[player.guid].damage >= self.maxhealth * 0.2)
          _id_54351D786449EE9E = 2;

        if(_id_54351D786449EE9E >= 1) {}
      }
    }
  }

  level notify("incursion_sentry_destroyed", self._id_0E86180E07331051);
  scripts\engine\utility::flag_set("flag_incursion_sentry_destroyed_" + self._id_0E86180E07331051);

  if(isDefined(self))
    thread _id_4B02400DAD63CAFB::sentry_deleteturret();
}

_id_CEB14301C666FBAE() {
  level.sentrysettings["sniper_sentry"] = spawnStruct();
  level.sentrysettings["sniper_sentry"].health = 999999;
  level.sentrysettings["sniper_sentry"].maxhealth = 350;
  level.sentrysettings["sniper_sentry"].burstmin = 20;
  level.sentrysettings["sniper_sentry"].burstmax = 120;
  level.sentrysettings["sniper_sentry"].pausemin = 0.15;
  level.sentrysettings["sniper_sentry"].pausemax = 0.35;
  level.sentrysettings["sniper_sentry"].maxrange = 443556;
  level.sentrysettings["sniper_sentry"]._id_947AF351CE904AA5 = 443556;
  level.sentrysettings["sniper_sentry"].lockstrength = 2;
  level.sentrysettings["sniper_sentry"].sentrymodeon = "sentry";
  level.sentrysettings["sniper_sentry"].sentrymodeoff = "sentry_offline";
  level.sentrysettings["sniper_sentry"].ammo = 200;
  level.sentrysettings["sniper_sentry"].timeout = 999999;
  level.sentrysettings["sniper_sentry"].spinuptime = 0.65;
  level.sentrysettings["sniper_sentry"].overheattime = 8.0;
  level.sentrysettings["sniper_sentry"].cooldowntime = 0.1;
  level.sentrysettings["sniper_sentry"].fxtime = 0.3;
  level.sentrysettings["sniper_sentry"].streakname = "sentry_gun";
  level.sentrysettings["sniper_sentry"].weaponinfo = "sentry_turret_jugg_maze_cp";
  level.sentrysettings["sniper_sentry"].playerweaponinfo = "sentry_turret_jugg_maze_cp";
  level.sentrysettings["sniper_sentry"].scriptable = "ks_sentry_turret_mp";
  level.sentrysettings["sniper_sentry"].modelbaseground = "wpn_wm_p45_mg_auto_sentry_v0_mp";
  level.sentrysettings["sniper_sentry"].modeldestroyedground = "wpn_wm_p45_mg_auto_sentry_v0_mp";
  level.sentrysettings["sniper_sentry"].weaponinfo = "sentry_turret_jugg_maze_cp";
  level.sentrysettings["sniper_sentry"].scriptable = "ks_sentry_turret_mp";
  level.sentrysettings["sniper_sentry"].modelbaseground = "weapon_wm_mg_sentry_turret";
  level.sentrysettings["sniper_sentry"].modeldestroyedground = "weapon_wm_mg_sentry_turret";
  level.sentrysettings["sniper_sentry"].placementhintstring = &"KILLSTREAKS_HINTS/SENTRY_GUN_PLACE";
  level.sentrysettings["sniper_sentry"].ownerusehintstring = &"KILLSTREAKS_HINTS/SENTRY_USE";
  level.sentrysettings["sniper_sentry"].otherusehintstring = &"KILLSTREAKS_HINTS/SENTRY_OTHER_USE";
  level.sentrysettings["sniper_sentry"].dismantlehintstring = &"KILLSTREAKS_HINTS/SENTRY_DISMANTLE";
  level.sentrysettings["sniper_sentry"].headicon = 1;
  level.sentrysettings["sniper_sentry"].teamsplash = "used_sentry_gun";
  level.sentrysettings["sniper_sentry"].destroyedsplash = "callout_destroyed_sentry_gun";
  level.sentrysettings["sniper_sentry"].shouldsplash = 1;
  level.sentrysettings["sniper_sentry"].votimeout = "sentry_shock_timeout";
  level.sentrysettings["sniper_sentry"].vodestroyed = "sentry_shock_destroy";
  level.sentrysettings["sniper_sentry"].scorepopup = "destroyed_sentry";
  level.sentrysettings["sniper_sentry"].lightfxtag = "tag_fx";
  level.sentrysettings["sniper_sentry"].iskillstreak = 1;
  level.sentrysettings["sniper_sentry"].headiconoffset = (0, 0, 75);
}

wait_for_sentry_acquire_target(turret) {
  turret endon("death");
  turret endon("carried");
  level endon("game_ended");
  turret.airlookatent = scripts\engine\utility::spawn_tag_origin(turret.origin, turret.angles);
  turret.airlookatent linkTo(turret, "tag_flash");

  for(;;) {
    result = turret scripts\engine\utility::waittill_any_timeout_1(1, "turret_on_target");

    if(result == "timeout") {
      continue;
    }
    turret.sentryshocktargetent = turret getturrettarget(1);

    if(isDefined(turret.sentryshocktargetent) && turret.sentryshocktargetent scripts\cp_mp\utility\player_utility::_isalive()) {
      turret thread _id_B3B2791D25BE37D0(turret.sentryshocktargetent);
      turret waittill("done_firing");
    }
  }
}

_id_B3B2791D25BE37D0(target) {
  self endon("death");
  self endon("carried");

  if(!isDefined(target)) {
    return;
  }
  thread _id_B46F3AE91AD78A69(target);
  self playSound("shock_sentry_charge_up");
  _id_82738CB37316849B();
  self notify("start_firing");
  firetime = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);

  while(isDefined(target) && target scripts\cp\utility::is_valid_player(target) && isDefined(self getturrettarget(1)) && self getturrettarget(1) == target) {
    self shootturret();
    wait(firetime);

    if(isDefined(target))
      thread _id_3E87B3096728D7AA(target, target.origin, target.angles);
  }

  self.sentryshocktargetent = undefined;
  self cleartargetentity();
  _id_13E5D8BB778415EE();
  self notify("done_firing");
}

_id_B46F3AE91AD78A69(target) {
  self endon("death");
  self laseron();
  self.laser_on = 1;
  scripts\engine\utility::waittill_any_2("done_firing", "carried");
  self laseroff();
  self.laser_on = 0;
}

_id_82738CB37316849B() {
  thread _id_9D51504B9794D6CF();

  while(self.momentum < level.sentrysettings[self.sentrytype].spinuptime) {
    self.momentum = self.momentum + 0.1;
    wait 0.1;
  }
}

_id_9D51504B9794D6CF() {
  self endon("death");
  self playSound("sentry_gun_beep");
  wait 0.1;
  self playSound("sentry_gun_beep");
  wait 0.1;
  self playSound("sentry_gun_beep");
}

_id_13E5D8BB778415EE() {
  self.momentum = 0;
}

_id_3E87B3096728D7AA(player, _id_6AFF01E5A3F618AD, _id_33348F75CDBF1E03) {
  _id_310236DBF257FBB5 = getaiarray("axis");
  _id_310236DBF257FBB5 = _id_35DE402EFC5ACFB3::_id_FD9E4CB348A5F283(_id_6AFF01E5A3F618AD, 1024);

  if(isDefined(_id_310236DBF257FBB5) && _id_310236DBF257FBB5.size > 0)
    _id_310236DBF257FBB5 = sortbydistance(_id_310236DBF257FBB5, _id_6AFF01E5A3F618AD);
  else
    _id_310236DBF257FBB5 = [];

  count = min(_id_310236DBF257FBB5.size, 2);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < count; _id_AC0E594AC96AA3A8++) {
    waitframe();
    _id_3114816C58D0AA74 = (_id_AC0E594AC96AA3A8 + 1) / count;

    if(scripts\engine\utility::_id_51D76700600CEBE3((1 - _id_3114816C58D0AA74) * 30)) {
      continue;
    }
    guy = _id_310236DBF257FBB5[_id_AC0E594AC96AA3A8];

    if(!isDefined(guy)) {
      continue;
    }
    if(!isalive(guy)) {
      continue;
    }
    team = guy.team;
    origin = guy.origin;

    if(!isDefined(team) || !isDefined(origin)) {
      continue;
    }
    state = guy _id_35DE402EFC5ACFB3::_id_16DCE705F14F4B84();

    if(!isDefined(state) || !isDefined(guy.team)) {
      continue;
    }
    if(state == "dead" || guy.team == "neutral") {
      continue;
    }
    if(state == "combat") {
      continue;
    }
    angles = vectortoangles(_id_6AFF01E5A3F618AD - guy.origin);
    _id_0C3EA9B1A20FF199 = guy.origin + anglesToForward(angles) * 750;
    guy aieventlistenerevent("investigate", player, _id_0C3EA9B1A20FF199);
    waitframe();
    guy._id_93B8288EFB765770 = 90000;
    wait(3 + randomfloat(2));
  }
}

_id_A85A3BB76B2DE00D() {
  data = spawnStruct();
  _id_7611665DE926ABA0 = getEntArray("2man_hallway_door_clip", "script_noteworthy");

  if(!isDefined(_id_7611665DE926ABA0)) {
    return;
  }
  _id_FEF7FF29C1843069 = getEnt("2man_hallway_door", "script_noteworthy");
  door_ent = scripts\engine\utility::getclosest(_id_FEF7FF29C1843069.origin, _id_7611665DE926ABA0);
  buttons = getEntArray("buddy_door_button", "script_noteworthy");

  foreach(button in buttons)
  button scripts\cp\cp_juggernaut::_id_91ED8C25C9B88686();

  _id_917C92070C46CC38 = scripts\engine\utility::getclosest(door_ent.origin, buttons);
  _id_917C92070C46CC38.origin = _id_917C92070C46CC38.origin + (0, 0, 5);
  door_ent linkTo(_id_FEF7FF29C1843069);

  if(!isDefined(_id_FEF7FF29C1843069.script_offset))
    _id_FEF7FF29C1843069.script_offset = (-50, 0, 0);

  _id_5AC49E018B46B2CD = scripts\engine\utility::getStruct("2man_hallway_out_maze", "targetname");
  _id_20F3271DC43A6012 = scripts\engine\utility::getStruct("2man_hallway_master_maze", "targetname");
  _id_5AC49E018B46B2CD.origin = _id_5AC49E018B46B2CD.origin + rotatevector((0, 0, 0.25), _id_5AC49E018B46B2CD.angles);
  _id_20F3271DC43A6012.origin = _id_20F3271DC43A6012.origin + rotatevector((0, 0, 0.25), _id_20F3271DC43A6012.angles);
  _id_FEF7FF29C1843069.target = _id_5AC49E018B46B2CD.targetname;
  hintstring = &"CP_RAID_WATERMAZE/DOOR_OPEN";
  _id_5AC49E018B46B2CD _id_34D2771929BD6022::_id_2FECC1AAB1890E7D(hintstring, "tag_origin", 64, 256, "duration_none", "hide");
  _id_20F3271DC43A6012 _id_34D2771929BD6022::_id_2FECC1AAB1890E7D(hintstring, "tag_origin", 64, 256, "duration_none", "hide");
  _id_34D2771929BD6022::_id_05F7C6BF2110C0FE(_id_FEF7FF29C1843069, undefined, 0);
  _id_FEF7FF29C1843069 thread _id_C093C2F3D1CFEE0B();
}

_id_C093C2F3D1CFEE0B() {
  level endon("game_ended");
  self notify("puzzle_doors_sound_watchfornotify");
  self endon("puzzle_doors_sound_watchfornotify");

  for(;;) {
    scripts\engine\utility::waittill_any_2("door_open", "door_close");
    thread scripts\cp\utility::playsoundatpos_safe(self.origin, "cp_puzzledoor_open");
  }
}