/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_d64abd0333272e1.gsc
***********************************************/

_id_977CCB9B09ABA742() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  if(isDefined(level._id_A90AED074077E2B0))
    level thread[[level._id_A90AED074077E2B0]]();
  else {
    level._id_0C636F650491AE5C = [];
    level._id_FECE02A99189C2DE = [];
    level _id_3E19322333AD204C::_id_70CB5F79C7F11728();
    level _id_EF12E8C82F081B32();
    level thread _id_68198EF8D68A5BF3();
  }

  scripts\engine\utility::flag_wait("defender_intro_completed");

  if(!istrue(level._id_0F3D1630DE429691)) {
    scripts\cp\utility::_id_0C72FF775CD61B11("dvar_7D7E0BBD84A4488F", 1, 0);
    level._id_21F279867AD3E473 = 0;
  }
}

_id_EF12E8C82F081B32() {
  scripts\engine\utility::flag_init("defender_intro_completed");
  _id_1685E6D8181C932A::_id_FC8EF090DF82817E();
}

_id_68198EF8D68A5BF3() {
  scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("Observatory - Intro");
  scripts\cp\utility::_id_3069B525E1C98FAF("Clear Bunker");
  level endon("game_ended");
  scripts\engine\utility::flag_wait("create_script_initialized");
  scripts\engine\utility::flag_wait("objectives_registered");
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  if(istrue(level._id_EFE609BCE901CAA8))
    scripts\cp\utility::gameflagwait("infil_started");

  level._id_7B57AB2CC8BA008A = 0;
  level._id_24A52C281A08470E = [];
  level._id_513942FD91EA2BF4 = 0;
  level thread _id_1685E6D8181C932A::_id_BC078843F4469108();
  level thread _id_48F20B0FE71DD6DF::_id_AA41ADFD5BD54BD0();
  level thread _id_48F20B0FE71DD6DF::_id_9121843B830CD3E4();
  level thread scripts\cp\utility::play_music_to_team("mx_cp_observatory_infil");
  wait 1;
  _id_278BA2944DB8A0EA = _id_3E19322333AD204C::_id_A74D0CFDC9AF0414("a");
  level thread _id_08C3717ABA2F9431(_id_278BA2944DB8A0EA);
  level thread _id_F33A9DEF89B73B7B();
  level thread _id_1E70C02AC0EC5917();
  wait 1;
  _id_C4AB5EBDBF4C1F83 = level._id_24A52C281A08470E.size;

  while(level._id_513942FD91EA2BF4 < _id_C4AB5EBDBF4C1F83)
    wait 0.5;

  if(istrue(_id_278BA2944DB8A0EA._id_ABEAE1966A23E2E3))
    level waittill("defender_defuse_" + _id_278BA2944DB8A0EA.targetname);

  level _id_3E19322333AD204C::_id_C34CF5F751B9CA97();
  level thread _id_5BC0F070AA89D04B::_id_DA0C1DF1584374E7();
  level thread _id_5BC0F070AA89D04B::_id_9C506A9D5C505E23();
  scripts\engine\utility::flag_set("defender_intro_completed");
}

_id_08C3717ABA2F9431(struct) {
  level endon("game_ended");
  struct._id_768859ECE1925E5F = "icon_waypoint_dom_a";
  _id_04FE778EB22A7108 = undefined;
  label = &"CP_MISSION_DEFENDER/CLEAR_HARDPOINT";

  switch (struct.targetname) {
    case "point_a":
      struct._id_768859ECE1925E5F = "icon_waypoint_dom_a";
      _id_04FE778EB22A7108 = level._id_193893EC58A382AF;
      label = &"CP_MISSION_DEFENDER/CLEAR_HARDPOINT_A";
      break;
    case "point_b":
      struct._id_768859ECE1925E5F = "icon_waypoint_dom_b";
      _id_04FE778EB22A7108 = level._id_193894EC58A384E2;
      label = &"CP_MISSION_DEFENDER/CLEAR_HARDPOINT_B";
      break;
    case "point_c":
      struct._id_768859ECE1925E5F = "icon_waypoint_dom_c";
      _id_04FE778EB22A7108 = level._id_193895EC58A38715;
      label = &"CP_MISSION_DEFENDER/CLEAR_HARDPOINT_C";
      break;
  }

  objindex = scripts\cp\cp_objectives::requestworldid("defender_intro_hardpoint");
  objective_state(objindex, "current");
  objective_position(objindex, struct.origin);
  objective_icon(objindex, struct._id_768859ECE1925E5F);
  objective_setminimapiconsize(objindex, "icon_regular");
  objective_setshowdistance(objindex, 1);
  objective_setplayintro(objindex, 1);
  objective_sethot(objindex, 0);
  objective_setownerteam(objindex, "axis");
  objective_setlabel(objindex, label);
  level._id_24A52C281A08470E[struct.targetname] = objindex;
  _id_3E19322333AD204C::_id_D19D3D61F6E33ED5(struct);
  wait 5;

  for(_id_1C02F7505726FD1E = getaiarray("axis"); _id_1C02F7505726FD1E.size == 0; _id_1C02F7505726FD1E = getaiarray("axis"))
    wait 0.1;

  wait 0.5;

  while(_id_1C02F7505726FD1E.size > 6) {
    wait 0.1;
    _id_1C02F7505726FD1E = getaiarray("axis");
  }

  level thread _id_48F20B0FE71DD6DF::_id_D32EEC2E245BB0BA(_id_1C02F7505726FD1E);

  while(_id_1C02F7505726FD1E.size > 0) {
    wait 0.1;
    _id_1C02F7505726FD1E = getaiarray("axis");
  }

  level thread _id_48F20B0FE71DD6DF::_id_FADF2EDC6F35FDCA("a");
  wait 1;

  if(istrue(struct._id_ABEAE1966A23E2E3)) {
    level thread _id_48F20B0FE71DD6DF::_id_33C82CAE6F347302();
    level waittill("defender_defuse_" + struct.targetname);
    wait 0.05;
    level thread _id_48F20B0FE71DD6DF::_id_83DCECF8FCAD91A7(1);
  } else
    level thread _id_48F20B0FE71DD6DF::_id_83DCECF8FCAD91A7();

  _id_3E19322333AD204C::_id_0254C1F7183C6C19(struct);
  objective_delete(objindex);
  scripts\cp\cp_objectives::freeworldidbyobjid(objindex);
  level._id_24A52C281A08470E = scripts\engine\utility::array_remove(level._id_24A52C281A08470E, objindex);
  level._id_513942FD91EA2BF4++;
}

_id_4D55FCBCFCD4DF9F() {
  if(!istrue(level._id_EFE609BCE901CAA8) || istrue(_id_0598E0C00C8151F7::player_infil_already_played())) {
    return;
  }
  foreach(player in level.players)
  player setclientomnvar("ui_hack_scoreboard_forbidden", 1);

  level._id_BBEEFAD58B75989A = 1;
  _id_973B79FAEEE9DEC4(1);
  level thread scripts\cp\infilexfil\lbravo_infil_cp::lbravo_init("alpha");
  level thread _id_CE8A637803DEC400();
  level waittill("players_unloaded_from_infil");
  level._id_BBEEFAD58B75989A = 0;
  game["player_infil_already_played"] = 1;

  foreach(player in level.players) {
    player setclientomnvar("ui_hack_scoreboard_forbidden", 0);
    player._id_7269DEEBA689CD65 = undefined;
    player scripts\cp\utility::_id_4CBAED764C116A25(0);
    player thread scripts\cp\utility::showminimap();
  }

  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_8169ECBE42B9A407", 1, 0);
  _id_973B79FAEEE9DEC4(0);
}

_id_973B79FAEEE9DEC4(_id_41D8BF229CF29051) {
  if(_id_41D8BF229CF29051) {
    level.modifyplayerdamage = ::_id_FDE70AB10E21BDBD;
    level._id_E9F82B2A9789C174 = 1;
  } else {
    level.modifyplayerdamage = undefined;
    level._id_E9F82B2A9789C174 = undefined;
  }
}

_id_FDE70AB10E21BDBD(inflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags) {
  if(!isPlayer(victim))
    return idamage;

  if(scripts\engine\utility::flag("infil_over"))
    return idamage;

  if(isPlayer(victim) && victim.health - idamage > 0)
    return idamage;

  return 0;
}

_id_02388CD0D5589652() {
  level waittill("trying_to_join_infil", player);
  level thread _id_48F20B0FE71DD6DF::_id_57A2962EB1F07B36();
}

_id_D7A959F04B6A8F5C() {
  scripts\cp\utility::gameflagwait("infil_started");

  if(soundexists("cp_observatory_infil_chopper")) {
    wait 0.1;
    level.infil_struct.linktoent playsoundonmovingent("cp_observatory_infil_chopper");
  }

  level thread _id_48F20B0FE71DD6DF::_id_E95C395D21DDE751();
}

_id_CE8A637803DEC400() {
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  level thread _id_02388CD0D5589652();
  level thread _id_D7A959F04B6A8F5C();

  foreach(player in level.players) {
    player._id_7269DEEBA689CD65 = 1;
    player thread _id_5AF31A147AFA5466();
  }

  weapon = "iw9_ar_mike4_mp";
  wait 1;
  scripts\cp\utility::gameflagwait("infil_started");
  level thread _id_7FC146D7ACCFAB6B();
  struct = scripts\engine\utility::getStruct("intro_gunfire_origin", "targetname");
  level thread _id_213BCEC18C342BF8();
  level thread _id_D0CF2EBB2443247A(struct);
  dist = squared(3200);

  while(!scripts\cp\utility::any_player_nearby(struct.origin, dist))
    wait 0.5;

  level thread _id_48F20B0FE71DD6DF::_id_9F60BD505EAEDDF0();
  level notify("deltaSquad_intro_runbackwards");
  level thread _id_405F6C7601C76ADF();
  _id_AC029CAF30646920 = scripts\engine\utility::getStruct("intro_magicguns_origin_left", "targetname");
  _id_1F0D98A2DE9D9835 = scripts\engine\utility::getStruct("intro_magicguns_origin_right", "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    _id_0C3EA9B1A20FF199 = level.players[_id_AC0E594AC96AA3A8] scripts\cp\infilexfil\infilexfil::get_spot_from_player(level.players[_id_AC0E594AC96AA3A8]);

    if(isDefined(_id_0C3EA9B1A20FF199)) {
      if(_id_0C3EA9B1A20FF199 % 2 == 0) {
        level thread _id_D4BDCE2176006661(weapon, _id_AC029CAF30646920, level.players[_id_AC0E594AC96AA3A8]);
        continue;
      }

      level thread _id_D4BDCE2176006661(weapon, _id_1F0D98A2DE9D9835, level.players[_id_AC0E594AC96AA3A8]);
    }
  }
}

_id_D4BDCE2176006661(weapon, struct, player) {
  level thread _id_8EBB2159B989A887();

  for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < 3; _id_AC0E5C4AC96AAA41++) {
    if(soundexists("cp_observatory_infil_chopper_bullet_impacts"))
      level.infil_struct.linktoent playsoundonmovingent("cp_observatory_infil_chopper_bullet_impacts");

    for(_id_AC0E5B4AC96AA80E = 0; _id_AC0E5B4AC96AA80E < 4; _id_AC0E5B4AC96AA80E++) {
      magicbullet(weapon, struct.origin, player getEye());
      wait 0.1;
    }

    wait(randomfloatrange(0.5, 1.5));
  }
}

_id_8EBB2159B989A887() {
  if(soundexists("cp_observatory_infil_chopper_alarms"))
    level.infil_struct.linktoent._id_01592C4B325FFFF4 playsoundonmovingent("cp_observatory_infil_chopper_alarms");
}

_id_405F6C7601C76ADF() {
  level endon("game_ended");

  if(istrue(level._id_EFE609BCE901CAA8)) {
    wait 1.25;
    level._id_41E42386446FA026 = level thread _id_18A73A64992DD07D::run_spawn_module("defend_intro_guys_flank");
    level thread _id_7FC146D7ACCFAB6B();
    level thread _id_7FC146D7ACCFAB6B(15);
    level thread _id_7FC146D7ACCFAB6B(35, 5);
  }
}

_id_7FC146D7ACCFAB6B(delay, limit) {
  if(isDefined(delay))
    wait(delay);

  _id_513BBEF138316DD3 = 0;
  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray("intro_grenade_drop", "targetname");

  foreach(struct in _id_9E4E1482CB40C9C5) {
    offset = (randomintrange(-25, 25), randomintrange(-25, 25), 0);
    position = scripts\engine\utility::drop_to_ground(struct.origin + offset, 250, -400);
    thread _id_BB19FA5C585A2030(position, 2 + randomfloat(16));
    _id_513BBEF138316DD3++;

    if(isDefined(limit) && _id_513BBEF138316DD3 > limit)
      return;
  }
}

_id_F33A9DEF89B73B7B() {
  level endon("game_ended");
  level endon("defender_intro_completed");

  if(istrue(level._id_EFE609BCE901CAA8)) {
    level waittill("deltaSquad_intro_runbackwards");
    wait 15;
  } else
    wait 5;

  level thread _id_1685E6D8181C932A::_id_66C79C508B095F85();

  while(!isDefined(level._id_367842BAEBE766BB))
    wait 0.05;

  wait 0.05;
  _id_C6D7E43C4D408CCE = _id_3E19322333AD204C::_id_A74D0CFDC9AF0414("a");
  level._id_367842BAEBE766BB = scripts\engine\utility::array_removedead_or_dying(level._id_367842BAEBE766BB);
  sortbydistancecullbyradius(level._id_367842BAEBE766BB, _id_C6D7E43C4D408CCE.origin, 600);
  _id_7F33680CB4F2DA3F = min(3, level._id_367842BAEBE766BB.size);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_7F33680CB4F2DA3F; _id_AC0E594AC96AA3A8++) {
    soldier = level._id_367842BAEBE766BB[_id_AC0E594AC96AA3A8];
    soldier._id_6D3FBC4590EDA90E = 1;
    soldier thread _id_3E19322333AD204C::_id_90B5F7A3A8C60478(_id_C6D7E43C4D408CCE);
  }
}

_id_579807479AF3C10F() {
  level endon("prematch_over");
  level endon("game_ended");
  self endon("death_or_disconnect");

  while(isalive(self)) {
    self waittill("playerdamaged");

    if(self.health < 50)
      self.health = 50;
  }
}

_id_D0CF2EBB2443247A(struct, _id_FB6F8D94499F97D6, _id_832F2C1EB63C5D22) {
  weapon = "iw9_ar_mike4_mp";
  end = struct.origin + (-1000, 0, 0);

  if(isDefined(_id_FB6F8D94499F97D6))
    end = _id_FB6F8D94499F97D6;

  _id_0F2C6E7B3FC1C38A = 0.1;

  if(isDefined(_id_832F2C1EB63C5D22))
    _id_901FD2D40F40F8D6 = _id_832F2C1EB63C5D22;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 30; _id_AC0E594AC96AA3A8++) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 50; _id_AC0E594AC96AA3A8++) {
      magicbullet(weapon, struct.origin, end, undefined, undefined, _id_0F2C6E7B3FC1C38A);
      wait 0.05;
    }

    wait(randomfloatrange(1.2, 2.5));
  }
}

_id_213BCEC18C342BF8() {
  wait 8;
  weapon = "iw9_ar_mike4_mp";
  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray("intro_magic_wild_gunfire", "targetname");

  foreach(struct in _id_9E4E1482CB40C9C5) {
    target = scripts\engine\utility::getStruct(struct.target, "targetname");
    level thread _id_D0CF2EBB2443247A(struct, target.origin, 30);
    level thread _id_1EE1181931757274(target.origin);
  }

  level thread _id_470373F8CE72FC31();
}

_id_1EE1181931757274(origin) {
  _id_513BBEF138316DD3 = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 50; _id_AC0E594AC96AA3A8++) {
    offset = (randomintrange(-200, 200), randomintrange(-200, 200), 0);
    position = scripts\engine\utility::drop_to_ground(origin + offset, 250, -400);
    position = getclosestpointonnavmesh(position);
    thread _id_BB19FA5C585A2030(position, 2 + randomfloat(1));
    wait 0.5;

    if(_id_AC0E594AC96AA3A8 > 20)
      wait 1;

    if(_id_AC0E594AC96AA3A8 > 40)
      wait 1;
  }
}

_id_BB19FA5C585A2030(origin, _id_14B4389A101AE384) {
  if(isDefined(_id_14B4389A101AE384))
    wait(_id_14B4389A101AE384);

  origin = origin + (0, 0, 64);
  playFX(scripts\engine\utility::getfx("vfx_frag_explode"), origin);
  scripts\cp\utility::playsoundatpos_safe(origin, "exp_ground_observatory_infil");
}

_id_470373F8CE72FC31() {
  level endon("game_ended");
  level endon("deltaSquad_introEngage");
  level endon("defender_intro_completed");
  level endon("intro_soldier_damaged");

  if(!istrue(level._id_21F279867AD3E473)) {
    return;
  }
  struct = _id_3E19322333AD204C::_id_A74D0CFDC9AF0414("a");
  _id_88A17B45B2570488 = squared(1600);

  for(;;) {
    offset = (randomintrange(-200, 200), randomintrange(-200, 200), 0);
    position = scripts\engine\utility::drop_to_ground(struct.origin + offset, 250, -400);
    position = getclosestpointonnavmesh(position);
    thread _id_BB19FA5C585A2030(position, 2 + randomfloat(1));
    wait 3;

    if(!istrue(level._id_EFE609BCE901CAA8) && scripts\cp\utility::any_player_nearby(struct.origin, _id_88A17B45B2570488))
      return;
  }
}

_id_1E70C02AC0EC5917() {
  level endon("game_ended");
  level endon("defender_intro_completed");

  if(istrue(level._id_EFE609BCE901CAA8)) {
    level waittill("deltaSquad_intro_runbackwards");
    wait 15;
  }

  for(;;) {
    _id_1C02F7505726FD1E = getaiarray("axis");

    if(_id_1C02F7505726FD1E.size <= 3) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1C02F7505726FD1E.size; _id_AC0E594AC96AA3A8++) {
        if(istrue(_id_1C02F7505726FD1E[_id_AC0E594AC96AA3A8]._id_9ED1E0D59012EC45)) {
          continue;
        }
        target = _id_1C02F7505726FD1E[_id_AC0E594AC96AA3A8] scripts\cp\utility::get_closest_living_player();

        if(isDefined(target)) {
          _id_A00884ED3A6D8B4B = getclosestpointonnavmesh(target.origin);
          _id_1C02F7505726FD1E[_id_AC0E594AC96AA3A8] getenemyinfo(target);
          _id_1C02F7505726FD1E[_id_AC0E594AC96AA3A8].goalheight = 96;
          _id_1C02F7505726FD1E[_id_AC0E594AC96AA3A8].script_origin_other = undefined;
          _id_1C02F7505726FD1E[_id_AC0E594AC96AA3A8] _id_18A73A64992DD07D::set_goal_radius(300);
          _id_1C02F7505726FD1E[_id_AC0E594AC96AA3A8] _id_18A73A64992DD07D::set_goal_pos(_id_A00884ED3A6D8B4B);
        }
      }
    }

    wait 20;
  }
}

_id_4B11467E22875DE6() {
  if(istrue(level._id_423720C2EF0933EC)) {
    return;
  }
  level._id_423720C2EF0933EC = 1;

  foreach(guy in level._id_FD1113A8AAB586AB.ai_spawned) {
    if(isalive(guy))
      guy thread _id_13D1C402F1421C35::throwgrenadeatplayerasap_combat_utility();
  }
}

_id_5AF31A147AFA5466() {
  level waittill("trying_to_join_infil", player);
  self setsoundsubmix("iw9_cp_obsv_infil_black");
  self playlocalsound("cp_obsv_infil_black_hit");
  scripts\cp\utility::gameflagwait("infil_started");
  self clearsoundsubmix("iw9_cp_obsv_infil_black", 1.0);
}

_id_70F8C27BE0D8C82E() {
  level._id_4C0339FDED885183 = ::_id_B1BFE90016DA2DA8;
  level._id_79ED5BB784E23EC9 = ::_id_F515F69A7EF10E50;
  scripts\engine\utility::flag_init("readyroom_cleanup");
}

_id_012937B27C36955E(player) {
  if(istrue(level._id_C33B373241D2B7A4)) {
    wait 3;
    player _id_66122A002AFF5D57::_id_46EE9182CF6872D5(0);
    scripts\engine\utility::flag_wait("readyroom_cleanup");
  } else {
    wait 3;
    player _id_66122A002AFF5D57::_id_46EE9182CF6872D5(0);
    wait 5;

    if(istrue(level._id_C33B373241D2B7A4))
      scripts\engine\utility::flag_wait("readyroom_cleanup");
  }
}

_id_0A28AA4F3A16F0D8() {
  level endon("readyroom_cleanup");
  level thread _id_B1BFE90016DA2DA8();
  wait 30;
  level thread _id_F515F69A7EF10E50();
}

_id_B1BFE90016DA2DA8() {
  if(istrue(level._id_C33B373241D2B7A4)) {
    return;
  }
  level._id_C33B373241D2B7A4 = 1;
  level thread _id_2CE06CFD129D85C0();
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "defend_player_start_readyroom", 1);
  level thread _id_25B64B630FB1EE3D();

  foreach(player in level.players) {
    player _id_3B64EB40368C1450::set("readyroom", "allow_jump", 0);
    player _id_3B64EB40368C1450::set("readyroom", "mount_side", 0);
    player _id_3B64EB40368C1450::set("readyroom", "mount_top", 0);
    player _id_3B64EB40368C1450::set("readyroom", "mantle", 0);
    player _id_3B64EB40368C1450::set("readyroom", "cp_munitions", 0);
    player _id_3B64EB40368C1450::set("readyroom", "killstreaks", 0);
    player _id_3B64EB40368C1450::set("readyroom", "supers", 0);
    player _id_3B64EB40368C1450::set("readyroom", "sprint", 0);
    player _id_3B64EB40368C1450::set("readyroom", "supersprint", 0);
    player _id_3B64EB40368C1450::set("readyroom", "ascender_use", 0);
    player _id_3B64EB40368C1450::set("readyroom", "armor", 0);
    player _id_3B64EB40368C1450::set("readyroom", "vehicle_use", 0);
    player _id_3B64EB40368C1450::set("readyroom", "fire", 0);
    player _id_3B64EB40368C1450::set("readyroom", "offhand_weapons", 0);
    player _id_3B64EB40368C1450::set("readyroom", "offhand_primary_weapons", 0);
    player _id_3B64EB40368C1450::set("readyroom", "offhand_secondary_weapons", 0);
    player setclientomnvar("ui_hide_bigmap", 1);
    player setclientomnvar("ui_show_tac_map", 0);
    player setclientomnvar("ui_radar_blocked", 1);
    player setclientomnvar("ui_hide_minimap", 1);
    player._id_AA6914D5FEBE3CFB = 1;
  }
}

_id_2CE06CFD129D85C0() {
  _id_9792640B164CDEB1 = scripts\engine\utility::getStructArray("cp_observatory_lockdoor_readyroom", "targetname");
  level._id_13758481E2008B34 = [];

  foreach(_id_1E92D8D3755A9FF8 in _id_9792640B164CDEB1) {
    _id_1E92D8D3755A9FF8.obstacle = createnavbadplacebybounds(_id_1E92D8D3755A9FF8.origin, (70, 70, 70), (0, 0, 0));
    _id_1E92D8D3755A9FF8._id_3089C6859DE1A2DC = getentitylessscriptablearray(undefined, undefined, _id_1E92D8D3755A9FF8.origin, 128, "door");

    foreach(door in _id_1E92D8D3755A9FF8._id_3089C6859DE1A2DC) {
      if(isDefined(door.type) && issubstr(door.type, "invisible")) {
        continue;
      }
      _id_1E92D8D3755A9FF8._id_3089C6859DE1A2DC = door;
      door._id_87ED8CB5B10DBE85 = _id_1E92D8D3755A9FF8;
      level._id_13758481E2008B34 = scripts\engine\utility::array_add(level._id_13758481E2008B34, _id_1E92D8D3755A9FF8._id_3089C6859DE1A2DC);
      _id_1E92D8D3755A9FF8._id_3089C6859DE1A2DC _id_99FEB3DFD5E88B94(_id_1E92D8D3755A9FF8._id_3089C6859DE1A2DC);
    }
  }
}

_id_F35D4AAC85A1C121() {
  foreach(door in level._id_13758481E2008B34)
  _id_8705B61D41C83C4F(door);
}

_id_99FEB3DFD5E88B94(door) {
  door _meth_9AF4C9B2CC1BF989(1);
  door.blocked = 1;
}

_id_8705B61D41C83C4F(door) {
  door _meth_80902296B05BE00A();

  if(isDefined(door._id_5C493302B016B154))
    door._id_5C493302B016B154 _meth_80902296B05BE00A();

  door.blocked = undefined;
  door._id_A16669FDD0578E00 = 1;

  foreach(player in level.players)
  door enablescriptableplayeruse(player);
}

_id_25B64B630FB1EE3D() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  wait 1;

  if(getdvarint("dvar_0B6B48EBDAFC846B", 0) > 0) {
    return;
  }
  level._id_F75835DDF309C521 = 1;
  _id_907CF78238187E27 = scripts\engine\utility::getStructArray("defender_kiosk_readyroom", "targetname");

  foreach(struct in _id_907CF78238187E27) {
    _id_15B89FF206500554 = spawnscriptable("br_plunder_box", struct.origin, struct.angles);
    _id_15B89FF206500554 setscriptablepartstate("br_plunder_box", "open");
    _id_15B89FF206500554.visible = 1;
  }

  instances = _id_3FD3C5A2E270592E::getallspawninstances();
  thread _id_3FD3C5A2E270592E::setspawninstances(instances);
  thread _id_3FD3C5A2E270592E::onprematchdone();
  thread _id_3FD3C5A2E270592E::_id_B38F5FFE645943C3("cp_core");
}

_id_F515F69A7EF10E50() {
  if(!istrue(level._id_C33B373241D2B7A4)) {
    return;
  }
  scripts\engine\utility::flag_set("readyroom_cleanup");
  struct = scripts\engine\utility::getStruct("defender_ready_room", "targetname");

  if(isDefined(struct)) {
    _id_06DA2DA4BA7C41FD = scripts\engine\utility::getclosest(struct.origin, level._id_F3AF0989226D9CF0, 500);

    if(isDefined(_id_06DA2DA4BA7C41FD)) {
      _id_06DA2DA4BA7C41FD thread scripts\cp_mp\killstreaks\airdrop::makecrateunusable();
      _id_06DA2DA4BA7C41FD thread scripts\cp_mp\killstreaks\airdrop::deletecrate(1);
    }
  }

  foreach(player in level.players)
  player notify("exit_airdrop_loadout", 0);

  foreach(player in level.players) {
    if(istrue(player._id_AA6914D5FEBE3CFB)) {
      player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("readyroom");
      player setclientomnvar("ui_hide_bigmap", 0);
      player setclientomnvar("ui_show_tac_map", 1);
      player setclientomnvar("ui_radar_blocked", 0);
      player setclientomnvar("ui_hide_minimap", 0);
      player._id_AA6914D5FEBE3CFB = undefined;
    }
  }

  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "defend_player_start", 1);
}