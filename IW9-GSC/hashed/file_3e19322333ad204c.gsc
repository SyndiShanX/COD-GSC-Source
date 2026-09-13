/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3e19322333ad204c.gsc
***********************************************/

main() {
  if(isDefined(level._id_68A620593C937E78)) {
    return;
  }
  level._id_68A620593C937E78 = 1;
  _id_78C32AE28C78C917();
  level thread _id_E63EC71C8C1DC585();
}

_id_78C32AE28C78C917() {
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_1BD4D94E5C712D0F", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_DD4F9AAE14A06A39", 9999, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_6CC448EE583199A9", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_34AF8CA56A01ED17", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_F241138DC4147E30", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_D4ED36D1F90CA352", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_4A4DE8B30C5647A8", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_2A9089585B058526", 0, 0);
  level._id_EFE609BCE901CAA8 = 1;

  if(getdvarint("dvar_8169ECBE42B9A407", 0) > 0) {
    scripts\cp\utility::_id_0C72FF775CD61B11("dvar_8169ECBE42B9A407", 1, 0);
    level._id_EFE609BCE901CAA8 = 0;
  }

  level._id_21F279867AD3E473 = 1;

  if(getdvarint("dvar_7D7E0BBD84A4488F", 0) > 0) {
    scripts\cp\utility::_id_0C72FF775CD61B11("dvar_7D7E0BBD84A4488F", 1, 0);
    level._id_21F279867AD3E473 = 0;
  }

  level.default_player_spawns = "defend_player_start";
  level._id_85AF047F9154DC4C = 1;
  level._id_A244732F8807FC19 = 1;
  level._id_BE46ED9FDE731E08 = 1;
  level._id_4B12176117D66EBB = 8;
  level._id_AD1D6202B804074E = 7;
  level._id_7B57AB2CC8BA008A = 1;
  level._id_EEDBACC5FD767772 = 1;
  level.spawn_infil_lbravo = _id_1685E6D8181C932A::_id_7CAD6330F341F78C;
  level.vehicle._id_9442D439C225C3FE = _id_1685E6D8181C932A::_id_2A3D0EB105242615;
  level.prematchallowfunc = scripts\cp\cp_infilexfil::_id_A49AF99ADDCF2646;
  level _id_14609B809484646E::_id_8ECE37593311858A(::_id_7DA5557A7B275877);
  level thread _id_1685E6D8181C932A::_id_14CE3704BCC6E611();
  level thread _id_EF24852E3DD47373();
  level thread _id_8F94303A4CB50F0D();
  level thread _id_0D64ABD0333272E1::_id_70F8C27BE0D8C82E();

  if(istrue(level._id_EFE609BCE901CAA8))
    level.strike_player_connect_black_screen_fn = _id_0598E0C00C8151F7::lbravo_infil_spawn_blackscreen_func;

  level _id_757C9AC43A532DAC::_id_19F98938B071A88F();
  level thread _id_74502A9E0EF1F19C::_id_F2525BF18ABAD733("briefcase_bomb_defuse_mp");
  scripts\engine\utility::flag_init("defender_waves_init");
  scripts\engine\utility::flag_init("defender_wave_started");
}

_id_7DA5557A7B275877() {
  thread _id_AF8B68BFCEA641A8();
  thread _id_5BC0F070AA89D04B::_id_057D85DBFBD24236();
}

_id_C6FBD3E680AE0DA8() {
  _id_FFED1DA1387E6D58 = getEntArray("airstrikeheight", "targetname");

  foreach(ent in _id_FFED1DA1387E6D58)
  ent delete();

  struct = scripts\engine\utility::getStruct("airstrikeheight", "targetname");
  level.eairstrikeheight = spawn("script_origin", struct.origin);
  level.eairstrikeheight.targetname = "airstrikeheight";
  ac130 = spawn("script_model", struct.origin - (0, 0, 6000));
  ac130 setModel("veh9_mil_air_cargo_plane_wm");
}

_id_AF8B68BFCEA641A8() {
  if(getdvarint("dvar_03BBBED1090811C4", 0) == 0) {
    wait 5;
    scripts\engine\utility::flag_wait("both_players_intro_binks_complete");
  }

  if(_id_0C108B17C5F8B3BB())
    thread scripts\engine\utility::delaythread(0.1, scripts\cp\utility::showminimap);
  else if(_id_6ADB77D6377D4E86())
    thread scripts\engine\utility::delaythread(0.1, scripts\cp\utility::showminimap);
}

_id_0C108B17C5F8B3BB() {
  mapname = getDvar("ui_mapname");
  _id_E9DDF04233FFC198 = mapname == "cp_observatory" && !istrue(level._id_EFE609BCE901CAA8);
  _id_E9DDF34233FFC831 = (mapname == "cp_lone" || mapname == "cp_lone_dev") && level.start_point != "defender_infil";
  return _id_E9DDF04233FFC198 || _id_E9DDF34233FFC831;
}

_id_6ADB77D6377D4E86() {
  _id_E9DDF04233FFC198 = istrue(_id_0598E0C00C8151F7::player_infil_already_played());
  _id_E9DDF34233FFC831 = istrue(game["completed_infil"]);
  _id_E9DDF24233FFC5FE = istrue(level._id_C67E4686BD0FADFC);
  return _id_E9DDF04233FFC198 || _id_E9DDF34233FFC831 || _id_E9DDF24233FFC5FE;
}

_id_FFA025B83EB2828C() {
  level._id_8FDE5731BB1BA3BB = 1;
  level.suicide_bomber_combat_func = _id_1685E6D8181C932A::suicide_bomber_combat_func;
  level thread _id_1985BEABA5E12B38::_id_5333CDA790154851();
  level thread _id_1685E6D8181C932A::_id_4AD1751DD6EF5881();
  _id_C81AA6C5B1CDBCA7 = scripts\engine\utility::getStructArray("group_c_aux", "targetname");
  _id_C81AA7C5B1CDBEDA = scripts\engine\utility::getStructArray("group_b_center", "targetname");
  _id_C81AA8C5B1CDC10D = scripts\engine\utility::getStructArray("group_a_left", "targetname");
  _id_3C2526B6DA5BE77F = scripts\engine\utility::getStructArray("mindia_temp_riotshield", "targetname");
  _id_E61597A1317B9C38 = scripts\engine\utility::getStruct("hack_defender_spawn_a", "targetname");
  _id_E6159AA1317BA2D1 = scripts\engine\utility::getStruct("hack_defender_spawn_b", "targetname");
  _id_E61599A1317BA09E = scripts\engine\utility::getStruct("hack_defender_spawn_c", "targetname");

  foreach(struct in _id_C81AA6C5B1CDBCA7) {
    _id_C12A580CEB39E9F8 = getnodesinradius(_id_E61597A1317B9C38.origin, 600, 4, 3000);
    _id_FD80F71F608A4C9A = scripts\engine\utility::random(_id_C12A580CEB39E9F8);

    if(isDefined(_id_FD80F71F608A4C9A))
      struct.origin = getclosestpointonnavmesh(_id_FD80F71F608A4C9A.origin) + (0, 0, 32);
  }

  foreach(struct in _id_C81AA7C5B1CDBEDA) {
    _id_C99BCC1633FD3654 = _id_E6159AA1317BA2D1.origin + (randomintrange(-64, 64), randomintrange(-64, 64), 0);
    struct.origin = _id_C99BCC1633FD3654 + (0, 0, 32);
  }

  foreach(struct in _id_C81AA8C5B1CDC10D) {
    _id_C12A580CEB39E9F8 = getnodesinradius(_id_E61599A1317BA09E.origin, 300, 4, 3000);
    _id_FD80F71F608A4C9A = scripts\engine\utility::random(_id_C12A580CEB39E9F8);

    if(isDefined(_id_FD80F71F608A4C9A))
      struct.origin = getclosestpointonnavmesh(_id_FD80F71F608A4C9A.origin) + (0, 0, 32);
  }

  _id_3C2526B6DA5BE77F[0].origin = _id_C81AA6C5B1CDBCA7[0].origin;
  _id_3C2526B6DA5BE77F[1].origin = _id_C81AA7C5B1CDBEDA[0].origin;
  _id_3C2526B6DA5BE77F[2].origin = _id_C81AA8C5B1CDC10D[0].origin;
}

_id_EF24852E3DD47373() {
  scripts\cp\cp_player_battlechatter::registerbcsoundtype("stat_8545DA6DD67C6763", "enum_5137F98B1BA67374", 1.0, 1.0);
  scripts\cp\cp_player_battlechatter::registerbcsoundtype("stat_2DD6D8E505E44F82", "enum_75B8C3D3B48D9E11", 1.0, 1.0);
  scripts\cp\cp_player_battlechatter::registerbcsoundtype("stat_518DBCC3021DB184", "enum_2516215B5DEEE881", 1.0, 1.0);
  scripts\cp\cp_player_battlechatter::registerbcsoundtype("stat_C75CFEA420D58A45", "enum_7C7103C7C4C29DE2", 1.0, 1.0);
  scripts\cp\cp_player_battlechatter::registerbcsoundtype("stat_128194340206E3B1", "enum_65B3F12A06792B12", 1.0, 1.0);
}

_id_E63EC71C8C1DC585() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  level thread _id_5BC0F070AA89D04B::_id_903421D8C3915B6B();
  level thread _id_1685E6D8181C932A::_id_690BA9393A0059AD();

  if(getdvarint("dvar_9A6DEDB182DA1326", 0) == 0)
    level thread _id_5BC0F070AA89D04B::_id_12BE2EFCA81C224E();

  level thread _id_1985BEABA5E12B38::_id_38681B3333B831D4();
  level thread _id_C6FBD3E680AE0DA8();
  scripts\cp\killstreaks\uav_cp::init_uav_cp();
  level thread scripts\cp\killstreaks\uav_cp::give_radar_to_team();
  scripts\cp\utility::_id_0C72FF775CD61B11("scr_game_enableMinimap", 1, 0);
  level thread _id_0D64ABD0333272E1::_id_4D55FCBCFCD4DF9F();
  level thread _id_A4AC008F03F60BDA();
  level thread _id_3BDFAB16FC1C3474();
  level thread _id_A765A686693A8989();
  level thread _id_D9125E2FE614EC7A();
  level thread _id_741F9061D83F2F6B();
  _id_83FDD199E5FFA2D2();
  wait 4;

  if(istrue(level._id_21F279867AD3E473))
    level _id_0D64ABD0333272E1::_id_977CCB9B09ABA742();
  else {
    level _id_48A361DFE93B27FA();
    level _id_C34CF5F751B9CA97();
    level thread _id_D7BE119A8AC5456D();
  }

  level _id_1F72EBEB702C9017();
  wait(randomfloat(0.1));
  scripts\cp\cp_analytics::_id_B6283AC45A607764("Observatory - Intro");
  level thread _id_B18D55C57A8CB646();
}

_id_01F3D7489C1107FC() {
  if(!isDefined(game["defender_attempts"]))
    game["defender_attempts"] = 0;

  game["defender_attempts"]++;
}

_id_0EE6B5E7B3965978() {
  return game["defender_attempts"] == 1;
}

_id_C34CF5F751B9CA97() {
  level thread _id_48F20B0FE71DD6DF::_id_A3FD2DA53A75B24A();
  level thread _id_31BD4ACB1472DF82();
  level._id_7B57AB2CC8BA008A = 0;
}

_id_31BD4ACB1472DF82() {
  level endon("game_ended");
  wait 15;
  hintstring = &"CP_MISSION_DEFENDER/TUTORIAL";

  if(isDefined(level._id_B335AC3B1F30362F))
    hintstring = level._id_B335AC3B1F30362F;

  _id_02DBCB1ED82DFFD5 = 10;
  level thread scripts\cp\cp_hud_message::teamhudtutorialmessage(hintstring, "allies", _id_02DBCB1ED82DFFD5);
}

_id_741F9061D83F2F6B() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  wait 1;

  if(getdvarint("dvar_0B6B48EBDAFC846B", 0) > 0) {
    return;
  }
  level._id_F75835DDF309C521 = 1;
  _id_907CF78238187E27 = scripts\engine\utility::getStructArray("defender_kiosk", "targetname");

  foreach(struct in _id_907CF78238187E27) {
    _id_15B89FF206500554 = spawnscriptable("br_plunder_box", struct.origin, struct.angles);
    _id_15B89FF206500554 setscriptablepartstate("br_plunder_box", "open");
    _id_15B89FF206500554.visible = 1;
    _id_15B89FF206500554.badplace = createnavbadplacebybounds(struct.origin, (20, 30, 40), struct.angles);
    _id_3FD3C5A2E270592E::_id_EF7118F0EF2196B5(_id_15B89FF206500554);
  }

  if(getdvarint("dvar_9496DB3E51FC0703", 1)) {
    instances = _id_3FD3C5A2E270592E::getallspawninstances();
    _id_3FD3C5A2E270592E::setspawninstances(instances);
  }

  _id_7864D1F6EFBF3E24 = "cp_core";

  if(isDefined(level._id_8538329F94B9C271))
    _id_7864D1F6EFBF3E24 = level._id_8538329F94B9C271;

  _id_3FD3C5A2E270592E::onprematchdone();
  _id_3FD3C5A2E270592E::_id_B38F5FFE645943C3(_id_7864D1F6EFBF3E24);
  level thread _id_5B66D0D9D2F2DFDD();
  level thread _id_4CD42871587EC934();
}

_id_5B66D0D9D2F2DFDD() {
  level endon("game_ended");
  _id_7864D1F6EFBF3E24 = "cp_core";

  if(isDefined(level._id_8538329F94B9C271))
    _id_7864D1F6EFBF3E24 = level._id_8538329F94B9C271;

  for(;;) {
    foreach(player in level.players)
    player setclientomnvar("ui_buystation_override", _id_600B944A95C3A7BF::_id_54B046AA3BA2678A(_id_7864D1F6EFBF3E24));

    wait 3;
  }
}

_id_4CD42871587EC934() {
  level endon("game_ended");

  while(!isDefined(level._id_62F5F42C7C300055) || level._id_62F5F42C7C300055 < 2)
    wait 3;

  foreach(player in level.players)
  player thread _id_ABB218BE395B7DC0();
}

_id_ABB218BE395B7DC0() {
  level endon("game_ended");
  self endon("disconnect");
  instances = _id_3FD3C5A2E270592E::getallspawninstances();
  _id_907CF78238187E27 = scripts\engine\utility::getStructArray("defender_kiosk", "targetname");
  _id_150CE843E1FB54C5 = scripts\engine\utility::array_combine(instances, _id_907CF78238187E27);
  _id_4DFADAC361F46C0D = 300;

  while(level._id_62F5F42C7C300055 < 3) {
    foreach(_id_15B89FF206500554 in _id_150CE843E1FB54C5) {
      if(distance2d(self.origin, _id_15B89FF206500554.origin) < _id_4DFADAC361F46C0D)
        return;
    }

    wait 3;
  }

  while(!istrue(level._id_CC94777AC6E61971))
    wait 1;

  wait 5;
  thread scripts\cp\cp_hud_message::tutorialprint(&"CP_MISSION_DEFENDER/BUY_STATION_HINT_1", 8);
  wait 10;

  foreach(_id_15B89FF206500554 in _id_150CE843E1FB54C5) {
    if(distance2d(self.origin, _id_15B89FF206500554.origin) < _id_4DFADAC361F46C0D * 2)
      return;
  }

  thread scripts\cp\cp_hud_message::tutorialprint(&"CP_MISSION_DEFENDER/BUY_STATION_HINT_2", 12);
}

_id_2A1304C7BFE893EB() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  wait 2;
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  wait 10;
  level._id_BE46ED9FDE731E08 = undefined;
}

_id_48A361DFE93B27FA() {
  level endon("game_ended");
  _id_4549CD5FC4176D49 = undefined;
  _id_F95FEB63C772E28F = undefined;
  _id_482BFE636B50DC53 = 16;
  _id_0C2A758AB84D9CAF = 120;
  _id_33C2A141EBC8F7AE = gettime();

  while(level.players.size == 0)
    wait 0.05;

  if(getdvarint("dvar_03BBBED1090811C4", 0) == 0) {
    wait 5;
    scripts\engine\utility::flag_wait("both_players_intro_binks_complete");
  }

  wait 0.5;

  foreach(player in level.players) {
    if(!isDefined(_id_F95FEB63C772E28F)) {
      _id_4549CD5FC4176D49 = player.origin;
      continue;
    }

    _id_4549CD5FC4176D49 = _id_4549CD5FC4176D49 + player.origin;
  }

  for(;;) {
    _id_F95FEB63C772E28F = undefined;

    if(gettime() > _id_33C2A141EBC8F7AE + _id_0C2A758AB84D9CAF * 1000) {
      return;
    }
    foreach(player in level.players) {
      if(isDefined(player.br_kiosk)) {
        return;
      }
      if(!isDefined(_id_F95FEB63C772E28F)) {
        _id_F95FEB63C772E28F = player.origin;
        continue;
      }

      _id_F95FEB63C772E28F = _id_F95FEB63C772E28F + player.origin;
    }

    if(isDefined(_id_F95FEB63C772E28F) && isDefined(_id_4549CD5FC4176D49)) {
      if(distance(_id_F95FEB63C772E28F, _id_4549CD5FC4176D49) > _id_482BFE636B50DC53)
        return;
    }

    wait 0.05;
  }
}

_id_D7BE119A8AC5456D() {
  foreach(player in level.players)
  player _id_07C40FA80892A721::_id_774133DC8DF0CCD5(2);
}

_id_A765A686693A8989() {
  struct = scripts\engine\utility::getStruct("obj_shops", "targetname");
  struct thread _id_A159464B4C6A9F84(800);
}

_id_7B00A65A5908DE81() {}

_id_A82101086E655FDF(struct, delay) {
  level endon("game_ended");
  level._id_FECE02A99189C2DE[level._id_FECE02A99189C2DE.size] = struct;
  level._id_671D9F52D923F36E[level._id_671D9F52D923F36E.size] = struct.targetname;
  logprint("DEFENDER GAMEMODE: On Wave: " + level._id_62F5F42C7C300055 + " , New hardpoint objective chosen: " + struct.targetname);

  if(level._id_62F5F42C7C300055 == 1)
    level._id_6138A7806100029B = struct;
  else if(level._id_62F5F42C7C300055 == 2)
    level._id_CCEFFFEF98E05B09 = struct;

  if(isDefined(delay))
    wait(delay);

  _id_B37FECB6C481CCD8 = (0, 0, 96);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("defender", "choose_hardpoint_label"))
    label = struct[[scripts\cp_mp\utility\script_utility::getsharedfunc("defender", "choose_hardpoint_label")]]();
  else
    label = struct _id_404A16229E3DC104();

  _id_D19D3D61F6E33ED5(struct);
  _id_49ECE3D0608350F7 = struct.origin + _id_B37FECB6C481CCD8;

  if(isDefined(struct._id_F4951B6AB8E49D24)) {
    _id_2D11E8B19A657F3E = scripts\cp\utility::get_average_origin(struct._id_F4951B6AB8E49D24.items);
    _id_49ECE3D0608350F7 = (struct.origin + _id_2D11E8B19A657F3E + _id_2D11E8B19A657F3E) / 3 + _id_B37FECB6C481CCD8;
  }

  struct._id_19F73147145116D3 = _id_49ECE3D0608350F7;
  objindex = scripts\cp\cp_objectives::requestworldid("defender_hardpoint", 25);
  objective_state(objindex, "current");
  objective_position(objindex, _id_49ECE3D0608350F7);
  objective_icon(objindex, struct._id_768859ECE1925E5F);
  objective_setminimapiconsize(objindex, "icon_medium");
  objective_setshowdistance(objindex, 1);
  objective_setplayintro(objindex, 1);
  objective_sethot(objindex, 0);
  objective_setownerteam(objindex, "allies");

  if(isDefined(label)) {
    struct._id_DE418C13B3D4665B = label;
    objective_setlabel(objindex, label);
  }

  level._id_726A4A2973C34CD4[struct.targetname] = objindex;
  level._id_0C636F650491AE5C[struct.targetname] = struct;
}

_id_404A16229E3DC104() {
  label = undefined;
  self._id_768859ECE1925E5F = "icon_waypoint_dom_a";

  switch (self.targetname) {
    case "point_a":
      self._id_768859ECE1925E5F = "icon_waypoint_dom_a";
      label = &"CP_MISSION_DEFENDER/HARDPOINT_LABEL_A";
      break;
    case "point_b":
      self._id_768859ECE1925E5F = "icon_waypoint_dom_b";
      label = &"CP_MISSION_DEFENDER/HARDPOINT_LABEL_B";
      break;
    case "point_c":
      self._id_768859ECE1925E5F = "icon_waypoint_dom_c";
      label = &"CP_MISSION_DEFENDER/HARDPOINT_LABEL_C";
      break;
  }

  return label;
}

_id_D19D3D61F6E33ED5(_id_3DEF217D9BD38E42) {
  _id_8FAE0F7F4B09E7F9 = [_id_3DEF217D9BD38E42];
  _id_63DABF33662D0860 = _id_8FAE0F7F4B09E7F9;

  if(isDefined(_id_3DEF217D9BD38E42.target)) {
    targets = scripts\engine\utility::getStructArray(_id_3DEF217D9BD38E42.target, "targetname");
    _id_8FAE0F7F4B09E7F9 = scripts\engine\utility::array_combine(_id_8FAE0F7F4B09E7F9, targets);
    _id_63DABF33662D0860 = _id_8FAE0F7F4B09E7F9;
  }

  if(isDefined(_id_3DEF217D9BD38E42._id_A06CC0F5B71F672F)) {
    if(_id_3DEF217D9BD38E42._id_A06CC0F5B71F672F.size >= _id_8FAE0F7F4B09E7F9.size)
      _id_3DEF217D9BD38E42._id_A06CC0F5B71F672F = [];

    foreach(_id_46B0D97704218F4A in _id_3DEF217D9BD38E42._id_A06CC0F5B71F672F)
    _id_63DABF33662D0860 = scripts\engine\utility::array_remove(_id_63DABF33662D0860, _id_46B0D97704218F4A);
  }

  _id_7850E9FCBB2CC85F = scripts\engine\utility::random(_id_63DABF33662D0860);
  _id_8FAE0F7F4B09E7F9 = scripts\engine\utility::array_remove(_id_8FAE0F7F4B09E7F9, _id_7850E9FCBB2CC85F);
  _id_7850EAFCBB2CCA92 = scripts\engine\utility::getclosest(_id_7850E9FCBB2CC85F.origin, _id_8FAE0F7F4B09E7F9);
  _id_B73D36AC3D7E17F4 = [_id_7850E9FCBB2CC85F, _id_7850EAFCBB2CCA92];
  _id_3DEF217D9BD38E42._id_F4951B6AB8E49D24 = scripts\engine\utility::create_deck(_id_B73D36AC3D7E17F4);
  _id_3DEF217D9BD38E42 _id_CA49D570B97BA28A(_id_7850E9FCBB2CC85F);
  _id_3DEF217D9BD38E42 _id_CA49D570B97BA28A(_id_7850EAFCBB2CCA92);
  level thread _id_2745009A92B65728(_id_3DEF217D9BD38E42, _id_B73D36AC3D7E17F4);
}

_id_CA49D570B97BA28A(point) {
  if(!isDefined(self._id_A06CC0F5B71F672F))
    self._id_A06CC0F5B71F672F = [];

  self._id_A06CC0F5B71F672F[self._id_A06CC0F5B71F672F.size] = point;
}

_id_2745009A92B65728(_id_3DEF217D9BD38E42, _id_B73D36AC3D7E17F4) {
  level endon("game_ended");
  struct = spawnStruct();
  _id_C56AC98044693987 = scripts\cp\utility::get_average_origin(_id_B73D36AC3D7E17F4);
  _id_43797180CF8ACFDB = scripts\cp\utility::getfarthest(_id_C56AC98044693987, _id_B73D36AC3D7E17F4);

  if(!isDefined(_id_43797180CF8ACFDB.radius))
    _id_43797180CF8ACFDB.radius = 150;

  radius = distance(_id_C56AC98044693987, _id_43797180CF8ACFDB.origin) + _id_43797180CF8ACFDB.radius + 150;
  wait 2;
  _id_3DEF217D9BD38E42 scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("Defender_Cp", _id_C56AC98044693987, radius);
  _id_3DEF217D9BD38E42 scripts\cp_mp\utility\game_utility::_id_6988310081DE7B45();
}

_id_0BC605248188B640(objindex) {
  objective_delete(objindex);
  scripts\cp\cp_objectives::freeworldidbyobjid(objindex);
}

_id_0254C1F7183C6C19(_id_5834268872D84AA8) {
  if(isDefined(level._id_726A4A2973C34CD4)) {
    foreach(_id_51DACC11FA52F8C7 in level._id_726A4A2973C34CD4)
    _id_0BC605248188B640(_id_51DACC11FA52F8C7);
  }

  if(isDefined(level._id_0C636F650491AE5C)) {
    foreach(_id_3DEF217D9BD38E42 in level._id_0C636F650491AE5C)
    _id_3DEF217D9BD38E42 scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
  }

  if(isDefined(_id_5834268872D84AA8))
    _id_5834268872D84AA8 scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
}

_id_AEBE0D181B587C6C(_id_6D2552E5D036E732) {
  level endon("game_ended");
  level endon("defender_wave_fail");
  level endon("defender_wave_win");
  level endon("defender_defuse_" + _id_6D2552E5D036E732._id_8E55DFD0D38FE9A9);
  objindex = undefined;
  _id_3DEF217D9BD38E42 = undefined;

  if(istrue(level._id_21F279867AD3E473)) {
    _id_3DEF217D9BD38E42 = _id_A74D0CFDC9AF0414("a");
    objindex = level._id_24A52C281A08470E[_id_3DEF217D9BD38E42.targetname];
  } else {
    if(!isDefined(level._id_726A4A2973C34CD4)) {
      return;
    }
    _id_3DEF217D9BD38E42 = level._id_0C636F650491AE5C[_id_6D2552E5D036E732._id_8E55DFD0D38FE9A9];
    objindex = level._id_726A4A2973C34CD4[_id_6D2552E5D036E732._id_8E55DFD0D38FE9A9];
  }

  if(!isDefined(objindex)) {
    return;
  }
  _id_6D2552E5D036E732.planted = 1;
  _id_6D2552E5D036E732._id_2444B7785351D927._id_ABEAE1966A23E2E3 = 1;
  _id_6D2552E5D036E732._id_2444B7785351D927._id_E49DD7E4AB8DBEE1++;
  level notify("defender_bomb_planted", _id_6D2552E5D036E732, _id_3DEF217D9BD38E42);
  _id_6D2552E5D036E732 scripts\cp\cp_juggernaut::_id_91ED8C25C9B88686();
  level thread _id_59BA02EE2DCD7B1C();
  level thread _id_258708535CA467D2(_id_6D2552E5D036E732._id_2444B7785351D927, 30, _id_6D2552E5D036E732);
  _id_6D2552E5D036E732._id_2444B7785351D927 notify("bomb_armed");
  objective_sethot(objindex, 0);
  objective_setshowprogress(objindex, 1);
  objective_position(objindex, _id_6D2552E5D036E732.origin + (0, 0, 40));
  objective_setownerteam(objindex, "axis");
  hintstring = &"CP_MISSION_DEFENDER/DEFUSE";
  objective_setlabel(objindex, hintstring);
  _id_D2ED205FE3C7E046 = 0;
  _id_95DEFB0C60C8FA3C = 60;

  switch (level.players.size) {
    case 1:
      _id_95DEFB0C60C8FA3C = 120;
      break;
    case 2:
      _id_95DEFB0C60C8FA3C = 75;
      break;
    case 3:
      _id_95DEFB0C60C8FA3C = 50;
      break;
  }

  _id_AC8E455E4F52BC0E = 9;

  if(level.script == "cp_lone")
    _id_AC8E455E4F52BC0E = 12;

  if(level._id_215CD837F06FA79E._id_16F443B9685E5E91 > _id_AC8E455E4F52BC0E)
    _id_95DEFB0C60C8FA3C = _id_95DEFB0C60C8FA3C + 60;

  _id_839E21D32CB1B18F = int(_id_95DEFB0C60C8FA3C * 0.1);
  _id_CF82E9A35F2316ED = int(_id_95DEFB0C60C8FA3C * 0.33);
  _id_4CE60039FF511A67 = int(_id_95DEFB0C60C8FA3C * 0.66);
  _id_47BA6EC4AF8EEFD9 = gettime() + _id_95DEFB0C60C8FA3C * 1000;
  _func_16BAE3E0B0AA09E3(_id_6D2552E5D036E732.origin, _id_47BA6EC4AF8EEFD9, 1000);
  level _id_F67FCD8E78A3E9A4(_id_6D2552E5D036E732);
  level thread _id_7D6A9B842F69F783(_id_6D2552E5D036E732, _id_95DEFB0C60C8FA3C);
  level thread _id_7C52DCEEBA00AF8C(_id_6D2552E5D036E732._id_2444B7785351D927, _id_95DEFB0C60C8FA3C);

  while(_id_D2ED205FE3C7E046 <= _id_95DEFB0C60C8FA3C) {
    objective_setprogress(objindex, 1 - _id_D2ED205FE3C7E046 / _id_95DEFB0C60C8FA3C);

    if(int(_id_D2ED205FE3C7E046) % _id_CF82E9A35F2316ED == 0 && _id_D2ED205FE3C7E046 > 1) {
      level thread _id_A030E72A2745702D(objindex, 2, _id_6D2552E5D036E732);
      _id_CF82E9A35F2316ED = 9999;
    } else if(int(_id_D2ED205FE3C7E046) % _id_4CE60039FF511A67 == 0 && _id_D2ED205FE3C7E046 > 1) {
      level thread _id_A030E72A2745702D(objindex, 2, _id_6D2552E5D036E732);
      objective_setpulsate(objindex, 1);
      _id_4CE60039FF511A67 = 9999;
    } else if(int(_id_D2ED205FE3C7E046) % _id_839E21D32CB1B18F == 0 && _id_D2ED205FE3C7E046 > 1) {
      level thread _id_A030E72A2745702D(objindex, 2, _id_6D2552E5D036E732);
      _id_839E21D32CB1B18F = 9999;
    }

    _id_D2ED205FE3C7E046 = _id_D2ED205FE3C7E046 + 0.1;
    _id_6D2552E5D036E732._id_2444B7785351D927._id_B26717F6F0C58C41 = _id_95DEFB0C60C8FA3C - _id_D2ED205FE3C7E046;
    wait 0.1;
  }

  _id_33611D9AAE37ACA0(_id_95DEFB0C60C8FA3C);

  if(istrue(_id_6D2552E5D036E732._id_C1E50A41666E5E4D))
    _id_6D2552E5D036E732 scripts\engine\utility::waittill_either("defuse", "defuse_stopped");

  objective_setpulsate(objindex, 0);
  _id_7290E4A1A78862C5(_id_3DEF217D9BD38E42);
  level thread _id_FAC6DA1B9966BC99(_id_6D2552E5D036E732);
}

_id_33611D9AAE37ACA0(_id_95DEFB0C60C8FA3C) {
  if(level.frameduration < 50) {
    _id_D071D5367F3B9E12 = 0.05;
    _id_A0B4BE40585BBDED = level.framedurationseconds;
    _id_3777ECE6A73EADA5 = _id_D071D5367F3B9E12 - _id_A0B4BE40585BBDED;
    modifier = 20;
    _id_EDFE023B7AABC95A = _id_3777ECE6A73EADA5 * _id_95DEFB0C60C8FA3C * modifier;
    wait(_id_EDFE023B7AABC95A);
  }
}

_id_59BA02EE2DCD7B1C() {
  if(!isDefined(level._id_215CD837F06FA79E._id_16F443B9685E5E91))
    level._id_215CD837F06FA79E._id_16F443B9685E5E91 = 0;

  if(istrue(level._id_21F279867AD3E473)) {
    return;
  }
  level._id_215CD837F06FA79E._id_16F443B9685E5E91++;
  setomnvar("num_bombs_planted", level._id_215CD837F06FA79E._id_16F443B9685E5E91);

  if(isDefined(level._id_62F5F42C7C300055)) {
    if(level._id_62F5F42C7C300055 == 6) {
      if(!isDefined(level._id_9DCC9F8CADBC7C6A))
        level._id_9DCC9F8CADBC7C6A = 0;

      level._id_9DCC9F8CADBC7C6A++;
    }
  }

  if(level.script == "cp_lone") {
    _id_E1275A0810098760 = 5;
    _id_F8375DAC9AA7968E = 12;
  } else {
    _id_E1275A0810098760 = 3;
    _id_F8375DAC9AA7968E = 9;
  }

  if(level._id_215CD837F06FA79E._id_16F443B9685E5E91 <= _id_E1275A0810098760)
    _id_1E22D314CC16F807::_id_26DC2F0B0BD90E86(3);
  else if(level._id_215CD837F06FA79E._id_16F443B9685E5E91 <= _id_F8375DAC9AA7968E)
    _id_1E22D314CC16F807::_id_26DC2F0B0BD90E86(2);
  else
    _id_1E22D314CC16F807::_id_26DC2F0B0BD90E86(1);
}

_id_A030E72A2745702D(objindex, number, _id_6D2552E5D036E732) {
  level endon("game_ended");
  level endon("defender_wave_fail");
  level endon("defender_wave_win");
  level endon("defender_defuse_" + _id_6D2552E5D036E732._id_8E55DFD0D38FE9A9);
  waittime = 0.25;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < number; _id_AC0E594AC96AA3A8++) {
    objective_sethot(objindex, 1);
    wait(waittime);
    objective_sethot(objindex, 0);
    wait(waittime);
  }
}

_id_258708535CA467D2(_id_3DEF217D9BD38E42, time, _id_6D2552E5D036E732) {
  level endon("game_ended");
  level endon("defender_wave_fail");
  level endon("defender_wave_win");
  level waittill("defender_defuse_" + _id_3DEF217D9BD38E42.targetname);
  _id_3DEF217D9BD38E42._id_9D05FBD51E1BE264 = _id_3DEF217D9BD38E42._id_8417E0F03AE0E83A;

  if(isDefined(_id_3DEF217D9BD38E42._id_8417E0F03AE0E83A))
    _id_3DEF217D9BD38E42._id_8417E0F03AE0E83A = undefined;

  if(isDefined(level._id_215CD837F06FA79E._id_B4703EA502094BC1)) {
    if(_id_3DEF217D9BD38E42._id_E49DD7E4AB8DBEE1 >= level._id_215CD837F06FA79E._id_B4703EA502094BC1) {
      _id_3DEF217D9BD38E42._id_4C9317C1E2AEB7D6 = 1;
      return;
    } else
      wait(level._id_215CD837F06FA79E._id_C014A8B31EFCFF70);
  }

  _id_73FC39BBE98EB99F(_id_3DEF217D9BD38E42);
}

_id_73FC39BBE98EB99F(_id_3DEF217D9BD38E42) {
  if(isDefined(_id_3DEF217D9BD38E42._id_9D05FBD51E1BE264)) {
    _id_3DEF217D9BD38E42._id_9D05FBD51E1BE264 delete();
    _id_3DEF217D9BD38E42._id_9D05FBD51E1BE264 = undefined;
  }
}

_id_38F856040C372731(_id_6D2552E5D036E732) {
  if(isDefined(_id_6D2552E5D036E732._id_C49D0B9FFFED5356)) {
    return;
  }
  hintstring = &"CP_MISSION_DEFENDER/DEFUSE";
  objindex = scripts\cp\cp_objectives::requestworldid("defender_defuse", 25);
  objective_state(objindex, "current");
  objective_onentity(objindex, _id_6D2552E5D036E732);
  objective_setzoffset(objindex, 16);
  objective_icon(objindex, _id_6D2552E5D036E732._id_2444B7785351D927._id_768859ECE1925E5F);
  objective_setminimapiconsize(objindex, "icon_regular");
  objective_setshowdistance(objindex, 0);
  objective_setplayintro(objindex, 0);
  objective_sethot(objindex, 0);
  objective_setownerteam(objindex, "axis");
  objective_setlabel(objindex, hintstring);
  objective_setbackground(objindex, 0);
  objective_hidefromplayersinmask(objindex);
  objective_addalltomask(objindex);
  _id_6D2552E5D036E732._id_C49D0B9FFFED5356 = objindex;
  _id_6D2552E5D036E732.startuseweapon = makeweapon("briefcase_bomb_defuse_mp");
  _id_6D2552E5D036E732._id_C5D3D8FF129F88BA thread _id_7B03ADBF71E96C78();
}

_id_F67FCD8E78A3E9A4(_id_6D2552E5D036E732) {
  if(!isDefined(_id_6D2552E5D036E732._id_C5D3D8FF129F88BA)) {
    _id_6D2552E5D036E732._id_C5D3D8FF129F88BA = scripts\engine\utility::spawn_tag_origin(_id_6D2552E5D036E732.origin + (0, 0, 15), _id_6D2552E5D036E732.angles);
    _id_6D2552E5D036E732._id_C5D3D8FF129F88BA show();
    _id_6D2552E5D036E732._id_C5D3D8FF129F88BA makeusable();
  } else
    _id_6D2552E5D036E732._id_C5D3D8FF129F88BA _meth_DFB78B3E724AD620(1);

  hintstring = &"CP_MISSION_DEFENDER/DEFUSE";
  _id_6D2552E5D036E732._id_C5D3D8FF129F88BA setHintString(hintstring);
  _id_6D2552E5D036E732._id_C5D3D8FF129F88BA setCursorHint("HINT_BUTTON");
  _id_6D2552E5D036E732._id_C5D3D8FF129F88BA sethintdisplayrange(256);
  _id_6D2552E5D036E732._id_C5D3D8FF129F88BA sethintdisplayfov(160);
  _id_6D2552E5D036E732._id_C5D3D8FF129F88BA setuserange(125);
  _id_6D2552E5D036E732._id_C5D3D8FF129F88BA setusefov(60);
  _id_6D2552E5D036E732._id_C5D3D8FF129F88BA sethintonobstruction("show");
  _id_6D2552E5D036E732._id_C5D3D8FF129F88BA sethinticon("hud_icon_objective_bomb_defuse");
  _id_6D2552E5D036E732._id_C5D3D8FF129F88BA setuseholdduration("duration_none");
  _id_6D2552E5D036E732._id_C5D3D8FF129F88BA setuseprioritymax();
  _id_6D2552E5D036E732._id_C5D3D8FF129F88BA sethintrequiresholding(1);
  _id_6D2552E5D036E732._id_C5D3D8FF129F88BA._id_6D2552E5D036E732 = _id_6D2552E5D036E732;
  level thread _id_38F856040C372731(_id_6D2552E5D036E732);
}

_id_4F984C7AAFB5B2AC() {
  level endon("game_ended");
  level endon("defender_wave_fail");
  level endon("defender_wave_win");
  level endon("defender_defuse_" + self._id_8E55DFD0D38FE9A9);
  self endon("death");
  self._id_C5D3D8FF129F88BA endon("death");
  wait 1;
  self._id_C5D3D8FF129F88BA _meth_DFB78B3E724AD620(1);
}

_id_2DCDFC97FC0FE4B0(_id_6D2552E5D036E732) {
  _id_6D2552E5D036E732._id_C5D3D8FF129F88BA makeunusable();
}

_id_7B03ADBF71E96C78() {
  self endon("death");
  self endon("defuse");

  for(;;) {
    self waittill("trigger", player);

    if(isDefined(player)) {
      if(!player scripts\cp\utility::is_valid_player()) {
        continue;
      }
      if(!istrue(_id_B42B8567448E204A(player getEye(), self.origin, self))) {
        player thread scripts\cp\utility::hint_prompt("defuse_blocked", 1, 1.4);
        continue;
      }

      self _meth_DFB78B3E724AD620(0);
      level thread _id_6D2C80F679202DB1(player, self._id_6D2552E5D036E732);
    }
  }
}

_id_B42B8567448E204A(start, end, _id_75BEA58D65510615) {
  if(distance(start, end) < 50)
    return 1;

  _id_C56207BDA09B3A36 = ["physicscontents_foliage", "physicscontents_glass", "physicscontents_ainoshoot", "physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicleclip", "physicscontents_itemclip", "physicscontents_clipshot", "physicscontents_playerclip", "physicscontents_aiclip", "physicscontents_vehicle", "physicscontents_useclip"];
  contents = physics_createcontents(_id_C56207BDA09B3A36);
  trace = scripts\engine\trace::ray_trace_passed(start, end, _id_75BEA58D65510615, contents);
  return trace;
}

_id_6D2C80F679202DB1(player, _id_6D2552E5D036E732) {
  player endon("death_or_disconnect");
  _id_6D2552E5D036E732 endon("explode");
  _id_6D2552E5D036E732._id_C1E50A41666E5E4D = 1;
  _id_6D2552E5D036E732 hide();
  objective_setshowprogress(_id_6D2552E5D036E732._id_C49D0B9FFFED5356, 1);
  objective_pinforclient(_id_6D2552E5D036E732._id_C49D0B9FFFED5356, player);
  _func_D1B64C3D055CEEB0(2, player);
  _func_8B71EB96E1636EDC(&"CP_MISSION_DEFENDER/DEFUSE", player);
  _id_14C1392E5D9436BC = 0;
  use_time = 3500;
  player _id_23D754560637BB31(1, _id_6D2552E5D036E732);

  while(_id_C058F3BE07F5700F(player)) {
    if(_id_14C1392E5D9436BC >= use_time) {
      objective_unpinforclient(_id_6D2552E5D036E732._id_C49D0B9FFFED5356, player);
      _func_D1B64C3D055CEEB0(0, player);
      player thread _id_23D754560637BB31(0, _id_6D2552E5D036E732);
      _id_6D2552E5D036E732 thread _id_09252B29213A382B(player);
      return 1;
    }

    _id_14C1392E5D9436BC = _id_14C1392E5D9436BC + 50;
    _id_5D3A428E1F92C6BA = _id_14C1392E5D9436BC / use_time;
    objective_setprogress(_id_6D2552E5D036E732._id_C49D0B9FFFED5356, _id_5D3A428E1F92C6BA);
    waitframe();
  }

  player _id_23D754560637BB31(0, _id_6D2552E5D036E732, 1);
  _id_6D2552E5D036E732 notify("defuse_stopped");
  _id_F67FCD8E78A3E9A4(_id_6D2552E5D036E732);
  _id_6D2552E5D036E732._id_C1E50A41666E5E4D = 0;
  _id_6D2552E5D036E732 show();
  _id_6D2552E5D036E732 _id_FE660700623BB3B7(player);
  objective_unpinforclient(_id_6D2552E5D036E732._id_C49D0B9FFFED5356, player);
  _func_D1B64C3D055CEEB0(0, player);
  return 0;
}

_id_C058F3BE07F5700F(_id_34E4B26FEE2CFD2B) {
  _id_9CE41514A0D1BB4B = !level.gameended && _id_34E4B26FEE2CFD2B scripts\cp_mp\utility\player_utility::_isalive() && _id_34E4B26FEE2CFD2B useButtonPressed() && !_id_0AFB7E332AEE4BF2::player_in_laststand(_id_34E4B26FEE2CFD2B);
  return _id_9CE41514A0D1BB4B;
}

_id_23D754560637BB31(enable, _id_6D2552E5D036E732, _id_67332BE3B7A81716) {
  if(istrue(enable)) {
    _id_6D2552E5D036E732.unuseweapon = self getcurrentweapon();
    self giveweapon(_id_6D2552E5D036E732.startuseweapon);
    scripts\cp\cp_weapons::switchtoweaponreliable(_id_6D2552E5D036E732.startuseweapon);
    _id_3B64EB40368C1450::set("bomb_use", "allow_movement", 0);
    _id_3B64EB40368C1450::set("bomb_use", "allow_jump", 0);
    _id_3B64EB40368C1450::set("bomb_use", "mount_side", 0);
    _id_3B64EB40368C1450::set("bomb_use", "mount_top", 0);
    _id_3B64EB40368C1450::set("bomb_use", "mantle", 0);
    _id_3B64EB40368C1450::set("bomb_use", "offhand_weapons", 0);
    _id_3B64EB40368C1450::set("bomb_use", "offhand_throwback", 0);
    _id_3B64EB40368C1450::set("bomb_use", "weapon_pickup", 0);

    if(isDefined(_id_6D2552E5D036E732._id_C49D0B9FFFED5356))
      objective_removeclientfrommask(_id_6D2552E5D036E732._id_C49D0B9FFFED5356, self);
  } else {
    _id_15CEF21E3BD6382A = 0;

    if(istrue(_id_67332BE3B7A81716))
      _id_15CEF21E3BD6382A = 1;
    else if(_id_BD289C55884628C0())
      _id_15CEF21E3BD6382A = 1;

    if(_id_2669878CF5A1B6BC::isminigunweapon(_id_6D2552E5D036E732.unuseweapon) && istrue(self.isjuggernaut))
      scripts\cp\cp_juggernaut::_id_F14F648C7F449690();
    else if(issubstr(_id_6D2552E5D036E732.unuseweapon.basename, "la_mike32")) {
      _id_929E81472980EC28 = scripts\cp\utility::getweapontoswitchbackto();
      success = thread scripts\engine\utility::delaythread(0.2, scripts\cp\cp_weapons::switchtoweaponreliable, _id_929E81472980EC28, 0);
    } else
      scripts\cp\cp_weapons::switchtoweaponreliable(_id_6D2552E5D036E732.unuseweapon, _id_15CEF21E3BD6382A);

    self takeweapon(_id_6D2552E5D036E732.startuseweapon);
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("bomb_use");

    if(isDefined(_id_6D2552E5D036E732._id_C49D0B9FFFED5356))
      objective_addclienttomask(_id_6D2552E5D036E732._id_C49D0B9FFFED5356, self);
  }
}

_id_BD289C55884628C0() {
  guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  _id_4D6D6A486EF55682 = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < guys.size; _id_AC0E594AC96AA3A8++) {
    _id_4D6D6A486EF55682 = scripts\cp\utility::ifcanseeplayer(guys[_id_AC0E594AC96AA3A8], self);

    if(_id_4D6D6A486EF55682) {
      break;
    }
  }

  return _id_4D6D6A486EF55682;
}

_id_09252B29213A382B(player) {
  self notify("defuse");
  level notify("defender_defuse_" + self._id_8E55DFD0D38FE9A9);
  self._id_2444B7785351D927._id_ABEAE1966A23E2E3 = undefined;
  self.disabled = 1;
  self show();
  _id_9AEFD325D33E4111();
  _id_FE660700623BB3B7(player);
  _id_2CB4F13D2A50282C = undefined;
  _id_3DEF217D9BD38E42 = undefined;

  if(istrue(level._id_21F279867AD3E473)) {
    _id_278BA2944DB8A0EA = _id_A74D0CFDC9AF0414("a");
    _id_2CB4F13D2A50282C = level._id_24A52C281A08470E[_id_278BA2944DB8A0EA.targetname];
    _id_3DEF217D9BD38E42 = self._id_2444B7785351D927;
  } else {
    _id_2CB4F13D2A50282C = level._id_726A4A2973C34CD4[self._id_8E55DFD0D38FE9A9];
    _id_3DEF217D9BD38E42 = level._id_0C636F650491AE5C[self._id_8E55DFD0D38FE9A9];
  }

  _id_49ECE3D0608350F7 = _id_3DEF217D9BD38E42.origin + (0, 0, 96);

  if(isDefined(_id_3DEF217D9BD38E42._id_19F73147145116D3))
    _id_49ECE3D0608350F7 = _id_3DEF217D9BD38E42._id_19F73147145116D3;

  objective_sethot(_id_2CB4F13D2A50282C, 0);
  objective_setshowprogress(_id_2CB4F13D2A50282C, 0);
  objective_position(_id_2CB4F13D2A50282C, _id_49ECE3D0608350F7);
  objective_setpulsate(_id_2CB4F13D2A50282C, 0);
  objective_setownerteam(_id_2CB4F13D2A50282C, "allies");

  if(isDefined(_id_3DEF217D9BD38E42._id_DE418C13B3D4665B))
    objective_setlabel(_id_2CB4F13D2A50282C, _id_3DEF217D9BD38E42._id_DE418C13B3D4665B);

  thread scripts\cp\cp_juggernaut::_id_84BAE1E96A725EC5(5);
  _id_26C89011A1A919FA();
  _id_7290E4A1A78862C5(_id_3DEF217D9BD38E42);

  if(soundexists("cp_obsv_bomb_defused"))
    self playSound("cp_obsv_bomb_defused");

  _id_69F6AB6FECF9622E = _id_936911BE45BEB356();

  if(_id_69F6AB6FECF9622E == 0) {
    level._id_89235EF6F8495217 = undefined;
    level thread scripts\cp\utility::play_music_to_team(level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8.defused);
  }

  level thread _id_48F20B0FE71DD6DF::_id_90C10B7C29A8BE21(self._id_2444B7785351D927, player);

  if(isDefined(self.objindex))
    _id_E9E9BC2CE1E746B7(self);
}

_id_26C89011A1A919FA() {
  if(!isDefined(self._id_C49D0B9FFFED5356)) {
    return;
  }
  objective_delete(self._id_C49D0B9FFFED5356);
  scripts\cp\cp_objectives::freeworldidbyobjid(self._id_C49D0B9FFFED5356);
  self._id_C49D0B9FFFED5356 = undefined;
  self notify("delete_objective");
}

_id_D9125E2FE614EC7A() {
  setomnvar("cp_bomb_state", 10);
  setomnvar("cp_bomb_state", 20);
  setomnvar("cp_bomb_state", 30);
  setomnvar("cp_bomb_state", 40);
  setomnvar("cp_bomb_state", 50);
  setomnvar("cp_bomb_state", 60);
}

_id_7C52DCEEBA00AF8C(_id_3209496A323A08B7, _id_546BDD6F69FD53E0) {
  id = _id_DE5BD5987042469C(_id_3209496A323A08B7);
  _id_750606C52335E646 = undefined;

  switch (id) {
    case "a":
      _id_750606C52335E646 = "cp_bomb_A_timer";
      break;
    case "b":
      _id_750606C52335E646 = "cp_bomb_B_timer";
      break;
    case "c":
      _id_750606C52335E646 = "cp_bomb_C_timer";
      break;
    case "d":
      _id_750606C52335E646 = "cp_bomb_D_timer";
      break;
    case "e":
      _id_750606C52335E646 = "cp_bomb_E_timer";
      break;
  }

  _id_0C89A900B743838B = gettime() + _id_546BDD6F69FD53E0 * 1000;
  setomnvar(_id_750606C52335E646, _id_0C89A900B743838B);
  level thread _id_C5E7343F447087CD(_id_546BDD6F69FD53E0, _id_3209496A323A08B7);
}

_id_C5E7343F447087CD(_id_546BDD6F69FD53E0, _id_3DEF217D9BD38E42) {
  level notify("defender_clearbombtimer");
  level endon("defender_clearbombtimer");
  level endon("defender_wave_fail");
  _id_69F6AB6FECF9622E = _id_936911BE45BEB356();

  if(_id_69F6AB6FECF9622E == 1)
    level thread scripts\cp\utility::play_music_to_team(level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8.planted);
  else if(_id_69F6AB6FECF9622E > 1 && !istrue(level._id_89235EF6F8495217)) {
    level._id_89235EF6F8495217 = 1;
    level thread scripts\cp\utility::play_music_to_team(level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_6977D15374CB8BD5);
  }

  level thread _id_8D39A354D0F18833(_id_546BDD6F69FD53E0, _id_3DEF217D9BD38E42);
  level thread _id_19A7EEDAD75E7908(_id_546BDD6F69FD53E0, _id_3DEF217D9BD38E42);

  for(;;) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      _id_42EC9EF814F1A23D = 1;
      _id_CA0FF426F7D9B4DA = scripts\engine\utility::getclosest(level.players[_id_AC0E594AC96AA3A8].origin, level._id_FECE02A99189C2DE);

      if(isDefined(_id_CA0FF426F7D9B4DA) && isalive(level.players[_id_AC0E594AC96AA3A8]) && istrue(_id_CA0FF426F7D9B4DA._id_ABEAE1966A23E2E3)) {
        if(distance(_id_CA0FF426F7D9B4DA.origin, level.players[_id_AC0E594AC96AA3A8].origin) < 1000) {}
      }

      if(_id_42EC9EF814F1A23D) {
        if(_id_546BDD6F69FD53E0 < 15) {
          level.players[_id_AC0E594AC96AA3A8] playlocalsound("cp_ui_bomb_timer_urgent");
          continue;
        }

        level.players[_id_AC0E594AC96AA3A8] playlocalsound("cp_ui_bomb_timer");
      }
    }

    wait 1;
  }
}

_id_8D39A354D0F18833(_id_546BDD6F69FD53E0, _id_3DEF217D9BD38E42) {
  level endon("defender_defuse_" + _id_3DEF217D9BD38E42.targetname);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("defender_vo", "bomb_timer"))
    thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("defender_vo", "bomb_timer")]](_id_546BDD6F69FD53E0, _id_3DEF217D9BD38E42);
  else {
    _id_3777ECE6A73EADA5 = undefined;

    if(_id_546BDD6F69FD53E0 > 45) {
      _id_3777ECE6A73EADA5 = _id_546BDD6F69FD53E0 - 45;
      wait(_id_3777ECE6A73EADA5);
      level thread _id_48F20B0FE71DD6DF::_id_1E310AB5E401426D(45, _id_3DEF217D9BD38E42);
    }

    if(isDefined(_id_3777ECE6A73EADA5)) {
      if(_id_546BDD6F69FD53E0 - _id_3777ECE6A73EADA5 > 30) {
        wait(_id_546BDD6F69FD53E0 - _id_3777ECE6A73EADA5 - 30);
        level thread _id_48F20B0FE71DD6DF::_id_1E310AB5E401426D(30, _id_3DEF217D9BD38E42);
        return;
      }

      return;
    }

    if(_id_546BDD6F69FD53E0 > 30) {
      wait(_id_546BDD6F69FD53E0 - 30);
      level thread _id_48F20B0FE71DD6DF::_id_1E310AB5E401426D(30, _id_3DEF217D9BD38E42);
    }
  }
}

_id_7290E4A1A78862C5(_id_3DEF217D9BD38E42) {
  id = _id_DE5BD5987042469C(_id_3DEF217D9BD38E42);
  _id_3387F91824006DA7 = undefined;

  if(!isDefined(level._id_4C8172DF058274E1))
    level._id_4C8172DF058274E1 = [];

  if(isDefined(level._id_4C8172DF058274E1[id])) {
    if(gettime() < level._id_4C8172DF058274E1[id] + 100)
      return;
  }

  level._id_4C8172DF058274E1[id] = gettime();

  switch (id) {
    case "a":
      _id_3387F91824006DA7 = 11;
      break;
    case "b":
      _id_3387F91824006DA7 = 21;
      break;
    case "c":
      _id_3387F91824006DA7 = 31;
      break;
    case "d":
      _id_3387F91824006DA7 = 41;
      break;
    case "e":
      _id_3387F91824006DA7 = 51;
      break;
  }

  setomnvar("cp_bomb_state", _id_3387F91824006DA7);
  level thread _id_88D1F197F390B60F(id);
  _id_F3317D86D7C54015 = _id_936911BE45BEB356();

  if(_id_F3317D86D7C54015 < 1)
    level notify("defender_clearbombtimer");
}

_id_88D1F197F390B60F(id) {
  wait 3;
  _id_3387F91824006DA7 = undefined;

  switch (id) {
    case "a":
      _id_3387F91824006DA7 = 10;
      break;
    case "b":
      _id_3387F91824006DA7 = 20;
      break;
    case "c":
      _id_3387F91824006DA7 = 30;
      break;
    case "d":
      _id_3387F91824006DA7 = 40;
      break;
    case "e":
      _id_3387F91824006DA7 = 50;
      break;
  }

  setomnvar("cp_bomb_state", _id_3387F91824006DA7);
}

_id_D5DB35B22BA6B057(_id_3DEF217D9BD38E42) {
  id = _id_DE5BD5987042469C(_id_3DEF217D9BD38E42);
  _id_3387F91824006DA7 = undefined;

  switch (id) {
    case "a":
      _id_3387F91824006DA7 = 12;
      break;
    case "b":
      _id_3387F91824006DA7 = 22;
      break;
    case "c":
      _id_3387F91824006DA7 = 32;
      break;
    case "d":
      _id_3387F91824006DA7 = 42;
      break;
    case "e":
      _id_3387F91824006DA7 = 52;
      break;
  }

  setomnvar("cp_bomb_state", _id_3387F91824006DA7);
}

_id_19A7EEDAD75E7908(timer, _id_3DEF217D9BD38E42) {
  level endon("defender_defuse_" + _id_3DEF217D9BD38E42.targetname);

  if(timer > 30)
    wait(timer - 30);

  level thread _id_D5DB35B22BA6B057(_id_3DEF217D9BD38E42);
}

_id_7D6A9B842F69F783(_id_DE1467AC3ED1D213, _id_9DB41B52A00B806B) {
  level endon("game_ended");
  level endon("defender_wave_fail");
  level endon("defender_wave_win");
  level endon("defender_defuse_" + _id_DE1467AC3ED1D213._id_8E55DFD0D38FE9A9);
  id = _id_DE5BD5987042469C(_id_DE1467AC3ED1D213._id_2444B7785351D927);
  level thread _id_48F20B0FE71DD6DF::_id_F1D362485830C36B(id);
  currenttime = gettime();
  _id_F28399727742EB23 = int(currenttime + 1000 * _id_9DB41B52A00B806B);
  _id_C301D652D9A73075 = _id_F28399727742EB23 - currenttime;

  while(_id_C301D652D9A73075 > 0) {
    currenttime = gettime();
    _id_C301D652D9A73075 = _id_F28399727742EB23 - currenttime;

    if(_id_C301D652D9A73075 < 3000) {
      if(_id_C301D652D9A73075 <= 3000) {
        if(soundexists("cp_obsv_bomb_beep_05"))
          _id_DE1467AC3ED1D213 playSound("cp_obsv_bomb_beep_05");
      } else if(_id_C301D652D9A73075 < 5000) {
        if(soundexists("cp_obsv_bomb_beep_04"))
          _id_DE1467AC3ED1D213 playSound("cp_obsv_bomb_beep_04");
      } else if(_id_C301D652D9A73075 < 7500) {
        if(soundexists("cp_obsv_bomb_beep_03"))
          _id_DE1467AC3ED1D213 playSound("cp_obsv_bomb_beep_03");
      } else if(soundexists("cp_obsv_bomb_beep_02"))
        _id_DE1467AC3ED1D213 playSound("cp_obsv_bomb_beep_02");

      wait 0.25;
    } else if(_id_C301D652D9A73075 < 15000) {
      if(soundexists("cp_obsv_bomb_beep_02"))
        _id_DE1467AC3ED1D213 playSound("cp_obsv_bomb_beep_02");

      wait 0.5;
    } else {
      if(soundexists("cp_obsv_bomb_beep_01"))
        _id_DE1467AC3ED1D213 playSound("cp_obsv_bomb_beep_01");

      wait 0.5;
    }

    if(_id_C301D652D9A73075 < 0) {
      break;
    }
  }
}

_id_FAC6DA1B9966BC99(_id_6D2552E5D036E732) {
  _id_0A07F7F1ED7864DB = _id_6D2552E5D036E732.origin;

  foreach(player in level.players)
  player.shouldskipdeathsshield = 1;

  _id_AE3D81E20A030504(_id_0A07F7F1ED7864DB);
  _id_6D2552E5D036E732 thread _id_47C820C5B168000E();
  setslowmotion(1, 0.25, 0.1);
  level thread scripts\engine\utility::delaythread(1, ::_id_D9125E2FE614EC7A);
  _id_6D2552E5D036E732 notify("explode");
  _id_6D2552E5D036E732._id_2444B7785351D927 notify("explode");

  if(istrue(level._id_21F279867AD3E473)) {
    scripts\cp\cp_analytics::_id_B6283AC45A607764("Observatory - Intro failed");
    _id_04B6CB49055B1244("a");
  } else {
    id = _id_DE5BD5987042469C(_id_6D2552E5D036E732._id_2444B7785351D927);
    level thread _id_48F20B0FE71DD6DF::_id_5118F876A195E8AE(id);
    level notify("defender_wave_fail");
  }
}

_id_47C820C5B168000E() {
  _id_A02118632C7F1621 = scripts\engine\utility::getStructArray("defender_hardpoint", "script_noteworthy");
  _id_FFF1B402F8B2915A = scripts\engine\utility::getclosest(self.origin, _id_A02118632C7F1621);
  _id_F9126EE91C2CB0D7 = scripts\engine\utility::getStructArray("defender_fail_explode_point", "targetname");
  _id_3A48E08E4D0522F1 = sortbydistancecullbyradius(_id_F9126EE91C2CB0D7, _id_FFF1B402F8B2915A.origin, 1400);
  _id_3A48E08E4D0522F1 = sortbydistance(_id_3A48E08E4D0522F1, self.origin);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3A48E08E4D0522F1.size; _id_AC0E594AC96AA3A8++) {
    delay = _func_CF14FFC946066DBD(100, 1400, 0.05, 0.3, distance(_id_3A48E08E4D0522F1[_id_AC0E594AC96AA3A8].origin, _id_FFF1B402F8B2915A.origin));
    wait(delay);
    type = "default";

    if(isDefined(_id_3A48E08E4D0522F1[_id_AC0E594AC96AA3A8].script_noteworthy) && _id_3A48E08E4D0522F1[_id_AC0E594AC96AA3A8].script_noteworthy == "sparks")
      type = "sparks";

    fwd = anglesToForward(_id_3A48E08E4D0522F1[_id_AC0E594AC96AA3A8].angles);
    up = anglestoup(_id_3A48E08E4D0522F1[_id_AC0E594AC96AA3A8].angles);
    level thread _id_AE3D81E20A030504(_id_3A48E08E4D0522F1[_id_AC0E594AC96AA3A8].origin, type, fwd, up, 1);
  }
}

_id_AE3D81E20A030504(_id_0A07F7F1ED7864DB, type, fwd, up, _id_B53415265B603895) {
  modifier = 15;
  effect = "bomb_explosion";

  if(isDefined(type)) {
    if(type == "sparks")
      effect = "bombsite_sparks";
  }

  _id_EFDFC6EBE7A152C5 = undefined;

  if(isDefined(fwd) && isDefined(up))
    _id_EFDFC6EBE7A152C5 = spawnfx(scripts\engine\utility::getfx(effect), _id_0A07F7F1ED7864DB, fwd, up);
  else
    _id_EFDFC6EBE7A152C5 = spawnfx(scripts\engine\utility::getfx(effect), _id_0A07F7F1ED7864DB);

  triggerfx(_id_EFDFC6EBE7A152C5);
  radiusdamage(_id_0A07F7F1ED7864DB, 384 * modifier, 256 * modifier, 40 * modifier, undefined, "MOD_EXPLOSIVE", "frag_grenade_mp");
  physicsexplosionsphere(_id_0A07F7F1ED7864DB, 200 * modifier, 100 * modifier, 3);
  playrumbleonposition("grenade_rumble", _id_0A07F7F1ED7864DB);
  earthquake(0.7, 0.7, _id_0A07F7F1ED7864DB, 800 * modifier);

  if(soundexists("exp_bombsite_lr") && !istrue(_id_B53415265B603895))
    playsoundatpos(_id_0A07F7F1ED7864DB, "exp_bombsite_lr");
}

_id_1F72EBEB702C9017() {
  if(level.script == "cp_observatory")
    _id_FFA025B83EB2828C();

  level._id_62F5F42C7C300055 = 1;

  if(getdvarint("dvar_88F99F8AAD71F40D", 0))
    level._id_62F5F42C7C300055 = getdvarint("dvar_88F99F8AAD71F40D");

  level._id_70100E2C8547084F = 6;
  setomnvar("cp_wave_maximum", level._id_70100E2C8547084F);

  if(getdvarint("dvar_1CA4483A010FA2E3", -1) > 1)
    level._id_62F5F42C7C300055 = getdvarint("dvar_1CA4483A010FA2E3", -1);
  else if(isDefined(level._id_51444070C494BD3E))
    level._id_62F5F42C7C300055 = level._id_51444070C494BD3E;

  scripts\cp\utility::_id_3069B525E1C98FAF("Wave: " + level._id_62F5F42C7C300055);
  _id_7F279DC5A10FAEA9();
  _id_01F3D7489C1107FC();
  level._id_7B57AB2CC8BA008A = undefined;
  level._id_215CD837F06FA79E._id_D97C715A28AB9260 = [];
  level._id_365210DF3B94B112["brloot_armor_plate"] = 30;
  level._id_7B57AB2CC8BA008A = 0;
  level thread _id_2A1304C7BFE893EB();
}

_id_3BDFAB16FC1C3474() {
  _id_A02118632C7F1621 = scripts\engine\utility::getStructArray("defender_hardpoint", "script_noteworthy");

  foreach(_id_C00448D30DF1BEA6 in _id_A02118632C7F1621) {
    _id_C00448D30DF1BEA6.entity = scripts\engine\utility::spawn_tag_origin(_id_C00448D30DF1BEA6.origin, _id_C00448D30DF1BEA6.angles);
    _id_C00448D30DF1BEA6 thread _id_A159464B4C6A9F84();

    if(isDefined(_id_C00448D30DF1BEA6.target)) {
      _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray(_id_C00448D30DF1BEA6.target, "targetname");

      foreach(struct in _id_9E4E1482CB40C9C5)
      struct thread _id_A159464B4C6A9F84();
    }
  }
}

_id_A159464B4C6A9F84(_id_921B9D1AB6394420) {
  level endon("game_ended");
  radius = 1000;

  if(isDefined(self.radius))
    radius = self.radius * 3;

  if(isDefined(_id_921B9D1AB6394420))
    radius = _id_921B9D1AB6394420;

  distsq = radius * radius;
  _id_E30532966BDAECB9 = 0;

  for(;;) {
    if(_id_E30532966BDAECB9 == 0)
      wait 2.5;
    else
      wait 1;

    _id_E30532966BDAECB9 = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      if(!isDefined(level.players[_id_AC0E594AC96AA3A8])) {
        continue;
      }
      if(distancesquared(level.players[_id_AC0E594AC96AA3A8].origin, self.origin) < distsq) {
        level.players[_id_AC0E594AC96AA3A8] notify("show_hud_near_objective");
        _id_E30532966BDAECB9 = _id_E30532966BDAECB9 + 1;
      }
    }
  }
}

_id_83FDD199E5FFA2D2() {
  if(isDefined(level._id_215CD837F06FA79E)) {
    return;
  }
  level._id_215CD837F06FA79E = spawnStruct();
  level _id_B9DFBE35558A2B16();
  level._id_215CD837F06FA79E._id_16F443B9685E5E91 = 0;
  level._id_215CD837F06FA79E._id_B4703EA502094BC1 = 2;
  level._id_215CD837F06FA79E._id_C014A8B31EFCFF70 = 50;
  level._id_215CD837F06FA79E._id_1F44055D8DF16E0B = 0;
  level._id_215CD837F06FA79E._id_A28A00A25B2B35C5 = [];
  level._id_215CD837F06FA79E._id_69714C701D381A31[1] = 1;
  level._id_215CD837F06FA79E._id_DEF74253F2C565A1[1] = ["medium_close", 1, "truck", 1, "soldier", 3, "medium", 9, "medium", 12, "soldier"];
  level._id_215CD837F06FA79E._id_AC09429F0F9FF18F[1] = "Wave One: Counter-attack.";
  _id_1985BEABA5E12B38::_id_23B61F49117D9DBE();
  level._id_215CD837F06FA79E._id_69714C701D381A31[2] = 1;
  level._id_215CD837F06FA79E._id_DEF74253F2C565A1[2] = ["medium_hover", 1, "medium_close", 1, "soldier", 1, "truck", 15, "medium", 1, "soldier", 10, "soldier"];
  level._id_215CD837F06FA79E._id_BE6E74B71830F399[2] = 1500;
  level._id_215CD837F06FA79E._id_AC09429F0F9FF18F[2] = "Wave Two: Hover.";
  level._id_215CD837F06FA79E._id_69714C701D381A31[3] = 1;
  level._id_215CD837F06FA79E._id_DEF74253F2C565A1[3] = ["medium_close", 1, "bomber_small", 5, "soldier", 5, "medium", 5, "soldier", 15, "bomber_medium", 15, "medium", 1, "bomber_small", 5, "bomber_small"];
  level._id_215CD837F06FA79E._id_BE6E74B71830F399[3] = 1500;
  level._id_215CD837F06FA79E._id_AC09429F0F9FF18F[3] = "Wave Three: Explosions.";
  level._id_215CD837F06FA79E._id_D97C715A28AB9260[3] = "smoke_grenade_mp";
  level._id_215CD837F06FA79E._id_69714C701D381A31[4] = 2;
  level._id_215CD837F06FA79E._id_DEF74253F2C565A1[4] = ["medium", 3, "mortar", 15, "soldier", 20, "medium"];
  level._id_215CD837F06FA79E._id_BE6E74B71830F399[4] = 1500;
  level._id_215CD837F06FA79E._id_AC09429F0F9FF18F[4] = "Wave Four: Mortar.";
  level._id_215CD837F06FA79E._id_4757143D8FD7202C[4] = 5;
  level._id_215CD837F06FA79E._id_69714C701D381A31[5] = 2;
  level._id_215CD837F06FA79E._id_DEF74253F2C565A1[5] = ["medium", 3, "riotshield", 1, "truck", 26, "medium", 15, "riotshield"];
  level._id_215CD837F06FA79E._id_BE6E74B71830F399[5] = 1500;
  level._id_215CD837F06FA79E._id_AC09429F0F9FF18F[5] = "Wave Five: Riots.";
  level._id_215CD837F06FA79E._id_4757143D8FD7202C[5] = 7;
  level._id_215CD837F06FA79E._id_69714C701D381A31[6] = 3;
  level._id_215CD837F06FA79E._id_DEF74253F2C565A1[6] = ["medium", 1, "soldier", 1, "truck", 70, "juggernaut", 40, "medium"];
  level._id_215CD837F06FA79E._id_BE6E74B71830F399[6] = 1500;
  level._id_215CD837F06FA79E._id_AC09429F0F9FF18F[6] = "Wave Six: All Sectors + Jugg.";
  level._id_215CD837F06FA79E._id_4757143D8FD7202C[6] = 7;

  if(isDefined(level._id_5627D6C50B64EFCD))
    [[level._id_5627D6C50B64EFCD]]();
}

_id_0553FD7172D17D5E(_id_338B646DD0B1EB7F, _id_CB82A844F5E47950) {
  if(level.script == "cp_lone")
    _id_E1275A0810098760 = 5;
  else
    _id_E1275A0810098760 = 3;

  if(!isDefined(level._id_215CD837F06FA79E._id_16F443B9685E5E91) || level._id_215CD837F06FA79E._id_16F443B9685E5E91 <= _id_E1275A0810098760)
    return _id_CB82A844F5E47950;

  return _id_338B646DD0B1EB7F;
}

_id_B18D55C57A8CB646() {
  level endon("game_ended");
  level thread _id_C3A97C1C50693AFA();
  scripts\cp\utility::_id_3069B525E1C98FAF("Wave: " + level._id_62F5F42C7C300055);
  level thread _id_2A107EC8307AFBAA(3);
  _id_6E3005B605484F98(45);
  level thread _id_D9125E2FE614EC7A();
  scripts\engine\utility::flag_set("defender_waves_init");
  _id_956AD594B13A4D58 = undefined;

  while(level._id_62F5F42C7C300055 <= level._id_70100E2C8547084F) {
    level thread _id_1108B8A315362948();
    scripts\engine\utility::flag_set("defender_wave_started");
    msg = level scripts\engine\utility::waittill_any_return_2("defender_wave_win", "defender_wave_fail");
    scripts\engine\utility::flag_clear("defender_wave_started");

    if(msg == "defender_wave_win") {
      level thread _id_F42675B77C6F47C9();
      _id_0254C1F7183C6C19();
      _id_21BC1B4A1175E031();
      scripts\cp\cp_analytics::_id_B6283AC45A607764("Observatory - Wave: " + level._id_62F5F42C7C300055);
      _id_956AD594B13A4D58 = _id_DC284E92E1C92385();
      level notify("end_wave_defender_spawners");
      wait 1;
      level thread _id_48F20B0FE71DD6DF::_id_29BC7E43DFDC6E43();
      setomnvar("cp_enemies_special", 0);

      if(!istrue(_id_956AD594B13A4D58)) {
        level thread _id_D9125E2FE614EC7A();
        level thread _id_D927724DDDAD1EA0();
        level thread _id_2A107EC8307AFBAA(4);
        _id_6E3005B605484F98(45);
      }

      continue;
    }

    if(msg == "defender_wave_fail") {
      scripts\cp\cp_analytics::_id_B6283AC45A607764("Observatory - Wave: " + level._id_62F5F42C7C300055, "Failed");
      _id_0254C1F7183C6C19();
      _id_21BC1B4A1175E031();
      _id_04B6CB49055B1244();
      level thread _id_2A107EC8307AFBAA(4);
      _id_6E3005B605484F98(45);
    }
  }

  setomnvar("cp_enemies_remaining", 0);
  setomnvar("cp_enemies_special", 0);
  level notify("defender_mode_win");
  _id_3F67385F8F80EB4C::_id_609C4A9EDF17904E();
  level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
}

_id_6E3005B605484F98(input) {
  level endon("game_ended");

  if(level._id_62F5F42C7C300055 > level._id_70100E2C8547084F) {
    return;
  }
  level thread _id_48F20B0FE71DD6DF::_id_A9933584A8B9B252(level._id_62F5F42C7C300055, input);
  level thread _id_B077E4A328BB9808(input);
  level thread _id_0CAC5E08D5D7DA2A();
  level thread _id_612D04F632CAA0AE();
  level notify("kiosks_pulsate_objectives");
  level._id_E9922F45DB5AE222 = input;
  level._id_55800A1E1F54D5EF = input;
  currenttime = 0;

  while(currenttime < input && !istrue(level._id_93155EFBF58F4C89)) {
    wait 1;
    currenttime = currenttime + 1;
    _id_8DD9F2EB8215A139 = input - currenttime;
    _id_D5ADBC626EA67B4D = scripts\cp\utility::_id_9A83883F756A4330(_id_8DD9F2EB8215A139 + 1);
    _id_1BE4F70E2CF74453(_id_D5ADBC626EA67B4D);
    level._id_E9922F45DB5AE222 = _id_8DD9F2EB8215A139;
    level notify("defender_skiptimer_updatecost", _id_8DD9F2EB8215A139);
  }

  foreach(player in level.players)
  player scripts\cp\utility::clearlowermessages();

  level._id_E9922F45DB5AE222 = undefined;
  wait 1;
}

_id_DC284E92E1C92385() {
  if(getdvarint("dvar_C502F00D1CEF7073"))
    return level._id_62F5F42C7C300055 > level._id_70100E2C8547084F;

  if(getdvarint("dvar_88F99F8AAD71F40D", 0))
    level._id_62F5F42C7C300055 = getdvarint("dvar_88F99F8AAD71F40D");

  if(level._id_62F5F42C7C300055 <= level._id_70100E2C8547084F) {
    level._id_62F5F42C7C300055++;

    if(level._id_62F5F42C7C300055 <= level._id_70100E2C8547084F) {
      scripts\cp\utility::_id_3069B525E1C98FAF("Wave: " + level._id_62F5F42C7C300055);
      setomnvar("cp_wave_number", level._id_62F5F42C7C300055);
    }
  }

  return level._id_62F5F42C7C300055 > level._id_70100E2C8547084F;
}

_id_C3A97C1C50693AFA() {
  level notify("defender_constantly_display_omnvars");
  level endon("defender_constantly_display_omnvars");
  level endon("game_ended");
  childthread _id_347AD72AD05585F7();
}

_id_347AD72AD05585F7() {
  for(;;) {
    setomnvar("cp_wave_maximum", level._id_70100E2C8547084F);

    if(level._id_62F5F42C7C300055 < 7)
      setomnvar("cp_wave_number", level._id_62F5F42C7C300055);

    wait 0.5;
    setomnvar("cp_wavenum_redisplay", 1);
    wait 0.5;
    setomnvar("cp_wavenum_redisplay", 2);
  }
}

_id_D927724DDDAD1EA0() {
  amount = 500;

  if(level.players.size == 1)
    amount = 1000;

  foreach(player in level.players)
  player _id_3BCAA2CBAF54ABDD::give_player_currency(amount, "large");
}

_id_B077E4A328BB9808(wait_time) {
  level endon("game_ended");
  level notify("timeout_wave");
  level endon("timeout_wave");
  self endon("death");

  if(level._id_62F5F42C7C300055 == 1)
    scripts\cp\utility::play_music_to_team(level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_9D5DBA3CE27BD539);
  else if(level._id_62F5F42C7C300055 == 2)
    scripts\cp\utility::play_music_to_team(level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_0170D67A12DAF854);
  else if(level._id_62F5F42C7C300055 == 3)
    scripts\cp\utility::play_music_to_team(level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_4BF453555EF34147);
  else if(level._id_62F5F42C7C300055 == 4)
    scripts\cp\utility::play_music_to_team(level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_AF36B4CCA8A906F2);
  else if(level._id_62F5F42C7C300055 == 5)
    scripts\cp\utility::play_music_to_team(level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_C7FD5D271E9953A5);
  else if(level._id_62F5F42C7C300055 == 6)
    scripts\cp\utility::play_music_to_team(level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_8B3E75861FD5C530);

  setomnvar("cp_countdown_color", 0);
  wait_time = wait_time + 1;
  _id_E84E755251284EC2 = gettime() + wait_time * 1000;
  setomnvar("cp_wave_timer", int(_id_E84E755251284EC2));

  if(wait_time - 10 > 0) {
    wait(wait_time - 10);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++) {
      setomnvar("cp_countdown_color", 2);
      wait 1;
    }
  }

  setomnvar("cp_wave_timer", 0);
}

_id_0CAC5E08D5D7DA2A() {
  level endon("game_ended");
  level endon("timeout_wave");
  level._id_93155EFBF58F4C89 = undefined;
  level._id_CC94777AC6E61971 = 1;
  level thread _id_C8240872001664EF();
  level childthread _id_2389D31A553DC871();
  level waittill("interaction_skiptimer");
  setomnvar("cp_enemies_special", 0);
  setomnvar("cp_wave_timer", 0);
  level._id_93155EFBF58F4C89 = 1;
  level._id_73406D0E0C2662ED = 1;
  level._id_CC94777AC6E61971 = 0;
  level notify("timeout_wave");
}

_id_2389D31A553DC871() {
  level endon("interaction_skiptimer");

  if(level._id_62F5F42C7C300055 == 1) {
    return;
  }
  if(istrue(level._id_73406D0E0C2662ED)) {
    return;
  }
  wait 21;
  setomnvar("cp_enemies_special", 71);
}

_id_C8240872001664EF() {
  use_struct = scripts\engine\utility::getStruct("defender_skiptimer_interact", "targetname");
  offset = (0, 0, 4);
  hintstring = undefined;
  hintstring = &"CP_WEAPON_BUY/SKIPTIMER";
  _id_EFE526BF6A23D275 = "icon_electrical_box";
  level._id_824802C9291AB2EB = scripts\cp\utility::createhintobject(use_struct.origin + offset, "HINT_BUTTON", _id_EFE526BF6A23D275, hintstring, undefined, "duration_none", "show", 210, 90, 80, 70, undefined);
  _id_830905E5C2645826 = "defender_interact_skiptimer";
  level thread _id_D428787F7E266691(_id_830905E5C2645826);
  level thread _id_404FE0DDB53FB827(_id_830905E5C2645826);
  _id_29DD0FFF7E381059 = "icon_waypoint_hq";
  icon = level._id_824802C9291AB2EB scripts\cp_mp\entityheadicons::setheadicon_singleimage(level.players, _id_29DD0FFF7E381059, 12, 0, 512, 256, undefined, undefined, 1);
  level scripts\engine\utility::waittill_any_3(_id_830905E5C2645826, "timeout_wave", "defender_wave_started");
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(icon);
  level._id_824802C9291AB2EB delete();
}

_id_D428787F7E266691(_id_830905E5C2645826) {
  level endon(_id_830905E5C2645826);
  level endon("timeout_wave");
  level endon("defender_wave_started");
  level._id_824802C9291AB2EB endon("death");

  for(;;) {
    level._id_824802C9291AB2EB waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(!isDefined(level._id_824802C9291AB2EB)) {
      continue;
    }
    player thread _id_D523DC706B0D4B40();
    level notify(_id_830905E5C2645826);
    return;
  }
}

_id_404FE0DDB53FB827(_id_830905E5C2645826) {
  level endon(_id_830905E5C2645826);
  level endon("timeout_wave");
  level endon("defender_wave_started");
  level._id_824802C9291AB2EB endon("death");
  _id_E12E030746E5588B = _id_6EBAC0A4FB497116();
  _id_E12E030746E5588B = _id_BAAD00E6EAA2ECE2(_id_E12E030746E5588B);
  level._id_824802C9291AB2EB sethintstringparams(_id_E12E030746E5588B);

  for(;;) {
    level waittill("defender_skiptimer_updatecost", _id_8DD9F2EB8215A139);

    if(!isDefined(level._id_824802C9291AB2EB)) {
      continue;
    }
    amount = _id_6EBAC0A4FB497116();
    level._id_824802C9291AB2EB setuseholdduration("duration_short");
    level._id_824802C9291AB2EB sethintstringparams(amount);
  }
}

_id_6EBAC0A4FB497116() {
  if(!isDefined(level._id_E9922F45DB5AE222))
    return 0;

  amount = level._id_E9922F45DB5AE222 * 15;
  return amount;
}

_id_BAAD00E6EAA2ECE2(_id_946FD3DC91FE2EBE) {
  modifier = 1;

  switch (level._id_62F5F42C7C300055) {
    case 1:
    case 0:
      modifier = 1.1;
      break;
    case 2:
      modifier = 1.2;
      break;
    case 3:
      modifier = 1.4;
      break;
    case 4:
      modifier = 1.6;
      break;
    case 5:
      modifier = 1.8;
      break;
    case 6:
      modifier = 2;
      break;
    default:
      modifier = 1;
      break;
  }

  _id_724DF5056137CBBD = int(_id_946FD3DC91FE2EBE * modifier);
  return _id_724DF5056137CBBD;
}

_id_D523DC706B0D4B40() {
  if(isDefined(level._id_2876E8A209847089) && gettime() < level._id_2876E8A209847089 + 5000) {
    return;
  }
  level._id_2876E8A209847089 = gettime();
  amount = _id_6EBAC0A4FB497116();

  if(isDefined(level._id_55800A1E1F54D5EF) && level._id_E9922F45DB5AE222 == level._id_55800A1E1F54D5EF) {
    if(level.players.size == 1)
      level thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_WEAPON_BUY/SKIPTIMER_DISPLAY_SUPER_SOLO", 5);
    else
      level thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_WEAPON_BUY/SKIPTIMER_DISPLAY_SUPER", 5);

    if(!isDefined(level._id_2EE179CAF9A097EA))
      level._id_2EE179CAF9A097EA = 0;

    level._id_2EE179CAF9A097EA++;

    if(level._id_2EE179CAF9A097EA == level._id_70100E2C8547084F)
      level thread scripts\engine\utility::delaythread(5.25, scripts\cp\cp_hud_message::teamhudtutorialmessage, &"CP_WEAPON_BUY/SKIPTIMER_DISPLAY_SUPER_WOW", 5);

    amount = _id_BAAD00E6EAA2ECE2(amount);
  } else if(level.players.size == 1)
    level thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_WEAPON_BUY/SKIPTIMER_DISPLAY_SOLO", 5);
  else
    level thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_WEAPON_BUY/SKIPTIMER_DISPLAY", 5);

  level notify("interaction_skiptimer");

  if(soundexists("buystation_deltasquad_buy"))
    level._id_824802C9291AB2EB playsoundtoteam("buystation_deltasquad_buy", "allies");

  if(level.script == "cp_observatory")
    scripts\cp\challenges_cp::_id_66B45CB5DD35268C();

  _id_75F20D0C941389FE = amount;

  if(level.players.size == 1)
    _id_75F20D0C941389FE = _id_75F20D0C941389FE * 2;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    level.players[_id_AC0E594AC96AA3A8] _id_3BCAA2CBAF54ABDD::give_player_currency(amount);
    level.players[_id_AC0E594AC96AA3A8] thread _id_293BC33BD79CABD1::killeventtextpopup("cp_used_skiptimer");
  }
}

_id_612D04F632CAA0AE() {
  level endon("game_ended");
  wait 5;

  foreach(player in level.players) {
    if(!isPlayer(player)) {
      continue;
    }
    if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(_id_0AFB7E332AEE4BF2::isinlaststand(player)) {
      continue;
    }
    player notify("force_regeneration");
  }
}

_id_2A107EC8307AFBAA(delay) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("defender", "choose_hardpoint"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("defender", "choose_hardpoint")]](delay);
  else {
    if(level._id_62F5F42C7C300055 > level._id_70100E2C8547084F) {
      return;
    }
    level._id_726A4A2973C34CD4 = [];
    level._id_0C636F650491AE5C = [];
    level._id_671D9F52D923F36E = [];
    level._id_FECE02A99189C2DE = [];
    _id_189B0BD812D4111B = [0, 1, 2];
    _id_50982862CFBCE565 = undefined;

    if(getDvar("dvar_ACDD33D10BB6166E", "") != "") {
      _id_783809DA65285CB1 = getDvar("dvar_ACDD33D10BB6166E", "");

      switch (_id_783809DA65285CB1) {
        case "a":
        case "A":
          _id_50982862CFBCE565 = 2;
          break;
        case "B":
        case "b":
          _id_50982862CFBCE565 = 1;
          break;
        case "C":
        case "c":
          _id_50982862CFBCE565 = 0;
          break;
      }

      if(isDefined(_id_50982862CFBCE565))
        _id_189B0BD812D4111B = [_id_50982862CFBCE565];
    }

    _id_4B57F37451FFE58F = level._id_215CD837F06FA79E._id_69714C701D381A31[level._id_62F5F42C7C300055];
    _id_A02118632C7F1621 = scripts\engine\utility::getStructArray("defender_hardpoint", "script_noteworthy");
    _id_6481A5603EF00ABB = min(_id_4B57F37451FFE58F, _id_189B0BD812D4111B.size);
    _id_B0DEB10ED5BF7BE8 = -1;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_6481A5603EF00ABB; _id_AC0E594AC96AA3A8++) {
      if(level._id_62F5F42C7C300055 == 1 && !isDefined(_id_50982862CFBCE565)) {
        _id_52C28724A2B7979A = 2;
        _id_189B0BD812D4111B = scripts\engine\utility::array_remove(_id_189B0BD812D4111B, _id_52C28724A2B7979A);
      }

      if(isDefined(level._id_6138A7806100029B) && isDefined(level._id_CCEFFFEF98E05B09) && level._id_62F5F42C7C300055 == 3 && !isDefined(_id_50982862CFBCE565)) {
        _id_A7CC23938CDCD04D = _id_DE5BD5987042469C(level._id_6138A7806100029B);
        _id_E0E6EEA93CDB3C6F = _id_DE5BD5987042469C(level._id_CCEFFFEF98E05B09);

        if(_id_A7CC23938CDCD04D == "b" && _id_E0E6EEA93CDB3C6F == "c") {
          _id_52C28624A2B79567 = 1;
          _id_189B0BD812D4111B = scripts\engine\utility::array_remove(_id_189B0BD812D4111B, _id_52C28624A2B79567);
          _id_52C28524A2B79334 = 0;
          _id_189B0BD812D4111B = scripts\engine\utility::array_remove(_id_189B0BD812D4111B, _id_52C28524A2B79334);
        } else if(_id_A7CC23938CDCD04D == "c" && _id_E0E6EEA93CDB3C6F == "b") {
          _id_52C28624A2B79567 = 1;
          _id_189B0BD812D4111B = scripts\engine\utility::array_remove(_id_189B0BD812D4111B, _id_52C28624A2B79567);
          _id_52C28524A2B79334 = 0;
          _id_189B0BD812D4111B = scripts\engine\utility::array_remove(_id_189B0BD812D4111B, _id_52C28524A2B79334);
        }
      }

      if(isDefined(level._id_F168838CCB5AE29E) && level._id_F168838CCB5AE29E.size > 0) {
        _id_B0DEB10ED5BF7BE8 = scripts\engine\utility::random(level._id_F168838CCB5AE29E);
        _id_189B0BD812D4111B = scripts\engine\utility::array_remove(_id_189B0BD812D4111B, _id_B0DEB10ED5BF7BE8);
        level._id_F168838CCB5AE29E = scripts\engine\utility::array_remove(level._id_F168838CCB5AE29E, _id_B0DEB10ED5BF7BE8);
      } else {
        _id_B0DEB10ED5BF7BE8 = scripts\engine\utility::random(_id_189B0BD812D4111B);
        _id_189B0BD812D4111B = scripts\engine\utility::array_remove(_id_189B0BD812D4111B, _id_B0DEB10ED5BF7BE8);
      }

      level thread _id_A82101086E655FDF(_id_A02118632C7F1621[_id_B0DEB10ED5BF7BE8], delay);
    }

    level._id_F168838CCB5AE29E = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_189B0BD812D4111B.size; _id_AC0E594AC96AA3A8++)
      level._id_F168838CCB5AE29E[_id_AC0E594AC96AA3A8] = _id_189B0BD812D4111B[_id_AC0E594AC96AA3A8];
  }
}

_id_1108B8A315362948() {
  level endon("game_ended");
  level _id_70CB5F79C7F11728();
  setomnvar("cp_enemies_remaining", 0);
  setomnvar("cp_enemies_special", 0);
  level thread _id_3CC8618F2B6ED582();
  level thread _id_3931050D960DABA4();
  level thread _id_C0734B712262B530();
  scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("Observatory - Wave: " + level._id_62F5F42C7C300055, undefined, "Started");

  if(level._id_62F5F42C7C300055 == 1)
    scripts\cp\utility::play_music_to_team(level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_8FE276C01BFFEA6B);
  else if(level._id_62F5F42C7C300055 == 2)
    scripts\cp\utility::play_music_to_team(level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_8FE277C01BFFEC9E);
  else if(level._id_62F5F42C7C300055 == 3)
    scripts\cp\utility::play_music_to_team(level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_8FE278C01BFFEED1);
  else if(level._id_62F5F42C7C300055 == 4)
    scripts\cp\utility::play_music_to_team(level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_8FE279C01BFFF104);
  else if(level._id_62F5F42C7C300055 == 5)
    scripts\cp\utility::play_music_to_team(level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_8FE27AC01BFFF337);
  else if(level._id_62F5F42C7C300055 == 6)
    scripts\cp\utility::play_music_to_team(level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_8FE27BC01BFFF56A);
}

_id_C0734B712262B530() {
  foreach(player in level.players) {
    player thread scripts\cp\cp_hud_message::showsplash("cp_wave_started", level._id_62F5F42C7C300055, undefined);
    player scripts\cp\utility::playsoundtoplayer_safe("ui_iw9_cp_defender_wave_start", player);
  }
}

_id_F42675B77C6F47C9() {
  if(level._id_62F5F42C7C300055 < level._id_70100E2C8547084F) {
    foreach(player in level.players) {
      player thread scripts\cp\cp_hud_message::showsplash("cp_wave_ended", level._id_62F5F42C7C300055, undefined);
      player scripts\cp\utility::playsoundtoplayer_safe("ui_iw9_cp_defender_wave_end", player);
    }
  }
}

_id_3CC8618F2B6ED582() {
  level endon("game_ended");
  level endon("defender_wave_fail");
  level endon("defender_wave_win");

  if(!scripts\engine\utility::flag_exist("defender_done_spawning"))
    scripts\engine\utility::flag_init("defender_done_spawning");
  else
    scripts\engine\utility::flag_clear("defender_done_spawning");

  level._id_215CD837F06FA79E._id_F50AB1ED6CCB5D0E = 0;
  level._id_215CD837F06FA79E._id_A28A00A25B2B35C5 = [];
  _id_B3BC25E7929A4FFF = 0.1;

  if(isDefined(level._id_215CD837F06FA79E._id_4757143D8FD7202C[level._id_62F5F42C7C300055]))
    _id_B3BC25E7929A4FFF = level._id_215CD837F06FA79E._id_4757143D8FD7202C[level._id_62F5F42C7C300055];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_FECE02A99189C2DE.size; _id_AC0E594AC96AA3A8++) {
    level thread _id_682FAB4ABE2FB868(level._id_FECE02A99189C2DE[_id_AC0E594AC96AA3A8]);

    if(isDefined(_id_B3BC25E7929A4FFF) && _id_B3BC25E7929A4FFF > 0)
      wait(_id_B3BC25E7929A4FFF);
  }

  while(level._id_215CD837F06FA79E._id_F50AB1ED6CCB5D0E < level._id_FECE02A99189C2DE.size)
    level scripts\engine\utility::waittill_any_timeout_1(10, "defender_wave_hardpoint_cleared");

  scripts\engine\utility::flag_set("defender_done_spawning");
}

_id_3931050D960DABA4() {
  level endon("game_ended");
  level endon("defender_wave_fail");
  wait 5;
  _id_307FF213BE4E59BB = 0;
  _id_CE4B48E2A63B3705 = 5;
  _id_C2DD9430AF6391A7 = gettime();
  _id_5F7FA99806781AB4 = 0;
  _id_8FB9280CA908209F = 0;
  _id_5665FF1603A75A32 = 0;
  _id_8FE37576A1761AA0 = 240;

  for(;;) {
    _id_A00FE886E805DF48 = [];
    guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < guys.size; _id_AC0E594AC96AA3A8++) {
      guys[_id_AC0E594AC96AA3A8] thread _id_1685E6D8181C932A::_id_58AC0D3936B07904();

      if(guys[_id_AC0E594AC96AA3A8] _id_4901C404F0A36FF5()) {
        continue;
      }
      _id_A00FE886E805DF48[_id_A00FE886E805DF48.size] = guys[_id_AC0E594AC96AA3A8];
    }

    setomnvar("cp_enemies_remaining", _id_A00FE886E805DF48.size);
    level thread _id_E7841485E7E9073F();
    _id_0FA2DDA40F1444C4 = 0;

    if(isDefined(level._id_D2AE25FA1777E73D))
      _id_0FA2DDA40F1444C4 = [[level._id_D2AE25FA1777E73D]]();

    if(scripts\engine\utility::flag("defender_done_spawning")) {
      if(guys.size > 15 && guys.size < 30 && !_id_8FB9280CA908209F) {
        level thread _id_48F20B0FE71DD6DF::_id_1747AC0335F930DD();
        _id_8FB9280CA908209F = 1;
      }

      if(guys.size < 6 && !_id_5F7FA99806781AB4) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("defender", "soldier_isolated_killoff"))
          level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("defender", "soldier_isolated_killoff")]](guys);
        else
          level thread _id_1685E6D8181C932A::_id_43EBC66899EF6383(guys);

        level thread _id_8CE770EB2B805C15();
        level thread _id_48F20B0FE71DD6DF::_id_D32EEC2E245BB0BA(_id_A00FE886E805DF48);
        _id_5F7FA99806781AB4 = 1;
      }

      if(guys.size == 0 && !_id_0FA2DDA40F1444C4)
        _id_307FF213BE4E59BB++;

      if(_id_307FF213BE4E59BB >= _id_CE4B48E2A63B3705) {
        break;
      }
    } else if(guys.size == 0 && !_id_0FA2DDA40F1444C4) {
      _id_5665FF1603A75A32++;

      if(_id_5665FF1603A75A32 >= _id_8FE37576A1761AA0) {
        break;
      }
    }

    wait 0.2;
  }

  _id_FB9DC0AD605A3A56 = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_FECE02A99189C2DE.size; _id_AC0E594AC96AA3A8++) {
    if(istrue(level._id_FECE02A99189C2DE[_id_AC0E594AC96AA3A8]._id_ABEAE1966A23E2E3)) {
      level waittill("defender_defuse_" + level._id_FECE02A99189C2DE[_id_AC0E594AC96AA3A8].targetname);
      _id_FB9DC0AD605A3A56 = 1;
    }
  }

  level thread _id_453016C5DBB14273(_id_FB9DC0AD605A3A56);
  level notify("defender_wave_win");
}

_id_453016C5DBB14273(_id_FB9DC0AD605A3A56) {
  if(level._id_62F5F42C7C300055 == level._id_70100E2C8547084F) {
    return;
  }
  if(istrue(_id_FB9DC0AD605A3A56))
    wait 5;

  scripts\cp\utility::play_music_to_team(level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_DE9E52B68B6EAD41);
}

_id_E7841485E7E9073F() {
  if(isDefined(level._id_5D9392255ABBFD4E)) {
    [[level._id_5D9392255ABBFD4E]]();
    return;
  }

  _id_AA82E6D1B3760575 = level._id_62F5F42C7C300055 * 10;
  _id_39CF0DFC43581EBB = 0;

  if(level._id_62F5F42C7C300055 == 1) {
    if(isDefined(level._id_693F5F3CC4BB0D59)) {
      level._id_693F5F3CC4BB0D59 = scripts\engine\utility::array_removedead(level._id_693F5F3CC4BB0D59);
      _id_39CF0DFC43581EBB = level._id_693F5F3CC4BB0D59.size;
    }
  } else if(level._id_62F5F42C7C300055 == 2) {
    if(isDefined(level._id_9BC999AAF7CD0976)) {
      level._id_9BC999AAF7CD0976 = scripts\engine\utility::array_removedead(level._id_9BC999AAF7CD0976);
      _id_39CF0DFC43581EBB = level._id_9BC999AAF7CD0976.size;
    }
  } else if(level._id_62F5F42C7C300055 == 3) {
    _id_A00FE886E805DF48 = [];
    guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < guys.size; _id_AC0E594AC96AA3A8++) {
      if(isDefined(guys[_id_AC0E594AC96AA3A8].unittype) && guys[_id_AC0E594AC96AA3A8].unittype == "suicidebomber")
        _id_A00FE886E805DF48[_id_A00FE886E805DF48.size] = guys[_id_AC0E594AC96AA3A8];
    }

    if(_id_A00FE886E805DF48.size > 0) {
      if(!isDefined(level._id_7AFEACA3EB9AEEC6))
        level._id_7AFEACA3EB9AEEC6 = 1;
    }

    if(!istrue(level._id_7AFEACA3EB9AEEC6))
      _id_39CF0DFC43581EBB = 0;
    else if(!scripts\engine\utility::flag("defender_done_spawning"))
      _id_39CF0DFC43581EBB = 1;
    else if(guys.size > 0)
      _id_39CF0DFC43581EBB = 1;
    else
      _id_39CF0DFC43581EBB = 0;
  } else if(level._id_62F5F42C7C300055 == 4) {
    if(isDefined(level._id_2B218E6AEBB46057))
      _id_39CF0DFC43581EBB = level._id_2B218E6AEBB46057.size;
  } else if(level._id_62F5F42C7C300055 == 5) {
    _id_A00FE886E805DF48 = [];
    guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < guys.size; _id_AC0E594AC96AA3A8++) {
      if(istrue(guys[_id_AC0E594AC96AA3A8].hasriotshieldequipped) || istrue(guys[_id_AC0E594AC96AA3A8].bhasriotshieldattached))
        _id_A00FE886E805DF48[_id_A00FE886E805DF48.size] = guys[_id_AC0E594AC96AA3A8];
    }

    _id_39CF0DFC43581EBB = _id_A00FE886E805DF48.size;
  } else if(level._id_62F5F42C7C300055 == 6) {
    _id_A00FE886E805DF48 = [];
    guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < guys.size; _id_AC0E594AC96AA3A8++) {
      if(isDefined(guys[_id_AC0E594AC96AA3A8].unittype) && guys[_id_AC0E594AC96AA3A8].unittype == "juggernaut")
        _id_A00FE886E805DF48[_id_A00FE886E805DF48.size] = guys[_id_AC0E594AC96AA3A8];
    }

    _id_39CF0DFC43581EBB = _id_A00FE886E805DF48.size;
  }

  value = _id_AA82E6D1B3760575 + _id_39CF0DFC43581EBB;
  setomnvar("cp_enemies_special", value);
}

_id_8CE770EB2B805C15() {
  level endon("game_ended");
  wait 2.5;

  if(!isDefined(level.players) || level.players.size == 0) {
    return;
  }
  guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  guys = sortbydistance(guys, level.players[0].origin);

  foreach(agent in guys) {
    if(isalive(agent)) {
      if(soundexists("mp_dmz_overseer_radio_tag"))
        agent playsoundonmovingent("mp_dmz_overseer_radio_tag");

      agent thread _id_A81B48F1432BCC1B(0.75);

      if(isDefined(agent._id_665888749D290FDB))
        scripts\cp_mp\entityheadicons::setheadicon_deleteicon(agent._id_665888749D290FDB);

      icon = agent thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(level.players, "hud_icon_head_marked", 8, 1, undefined, 500);
      agent._id_665888749D290FDB = icon;
      agent thread _id_A086077C80386C63(icon);
      agent thread _id_9121F5053FBAC88D(icon, getdvarfloat("dvar_1D5D579C0529A5A8", 8.0));
      wait(randomfloatrange(0.25, 0.4));
    }
  }
}

_id_A81B48F1432BCC1B(waittime) {
  self notify("radio_marked");
  self endon("death");
  self endon("radio_marked");
  wait(waittime);
  self stopsounds();
}

_id_A086077C80386C63(icon) {
  self notify("headicon_death_watch");
  self endon("overseer_headicon_deleted");
  self endon("headicon_death_watch");
  level endon("game_ended");
  self waittill("death");
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(icon);
  self._id_665888749D290FDB = undefined;
  self notify("overseer_headicon_deleted");
}

_id_9121F5053FBAC88D(icon, waittime) {
  self notify("headicon_timeout");
  self endon("overseer_headicon_deleted");
  self endon("headicon_timeout");
  level endon("game_ended");
  wait(waittime);
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(icon);
  self._id_665888749D290FDB = undefined;
  self notify("overseer_headicon_deleted");
}

_id_4901C404F0A36FF5() {
  if(isDefined(self.vehicle) && (self.vehicle_position == 0 || self.vehicle_position == 1))
    return 1;

  return 0;
}

_id_96A4544BE1843F0E() {
  if(isDefined(self.vehicle) && self.vehicle.targetname == "veh9_jltv_mg" && self.vehicle_position == 4)
    return 1;

  return 0;
}

_id_04B6CB49055B1244(_id_452A79095E20EF94) {
  level thread _id_5A52715BF68D9C6C();
  wait 2;
  type = "kia";
  id = undefined;

  if(isDefined(_id_452A79095E20EF94))
    id = _id_452A79095E20EF94;

  if(isDefined(level._id_ADFA9C802373792D))
    id = level._id_ADFA9C802373792D;

  if(isDefined(id)) {
    switch (id) {
      case "a":
        type = "defender_alpha";
        break;
      case "b":
        type = "defender_beta";
        break;
      case "c":
        type = "defender_charlie";
        break;
      case "d":
        type = "defender_delta";
        break;
      case "e":
        type = "defender_echo";
        break;
    }
  }

  level thread[[level.endgame]]("axis", level.end_game_string_index[type]);
}

_id_D3CB8E66A665F324() {
  level notify("end_wave_defender_spawners");
  _id_18A73A64992DD07D::stop_all_groups();

  foreach(ai in level.agentarray) {
    if(isalive(ai))
      ai suicide();
  }

  if(isDefined(level._id_6E5FF6CAE14C4081)) {
    foreach(vehicle in level._id_6E5FF6CAE14C4081)
    vehicle dodamage(vehicle.health + 1000, vehicle.origin);

    level._id_6E5FF6CAE14C4081 = scripts\engine\utility::array_removeundefined(level._id_6E5FF6CAE14C4081);
    level._id_6E5FF6CAE14C4081 = scripts\engine\utility::array_removedead(level._id_6E5FF6CAE14C4081);
  }
}

_id_90B5F7A3A8C60478(_id_3DEF217D9BD38E42) {
  self.dontkilloff = 1;
  thread _id_E0E39E60287FD525(_id_3DEF217D9BD38E42);
}

_id_7DFF7E168DC5F859(group) {
  _id_800676BBD5453FC0 = _id_8337B218350D8D9B(group.group_name);
  self._id_800676BBD5453FC0 = _id_800676BBD5453FC0;

  if(!isDefined(_id_800676BBD5453FC0)) {
    return;
  }
  if(!isDefined(_id_800676BBD5453FC0._id_2444B7785351D927)) {
    return;
  }
  if(getdvarint("dvar_66669D95EF270015", 1) && level.script == "cp_lone")
    self._id_4EBE755E0A0A430E = 1;

  if(isDefined(_id_800676BBD5453FC0._id_57F8B4C321038A32) && _id_800676BBD5453FC0._id_57F8B4C321038A32 == "medium") {
    _id_DE6A059FE818D56B = "gas_mp";

    if(isDefined(level._id_215CD837F06FA79E._id_D97C715A28AB9260[level._id_62F5F42C7C300055]))
      _id_DE6A059FE818D56B = level._id_215CD837F06FA79E._id_D97C715A28AB9260[level._id_62F5F42C7C300055];

    self.script_forcegrenade = 1;
    self.grenadeweapon = makeweapon(_id_DE6A059FE818D56B);
    self.grenadeammo = 3;
    self.grenadesafedist = 200;
  } else if(isDefined(_id_800676BBD5453FC0._id_57F8B4C321038A32) && _id_800676BBD5453FC0._id_57F8B4C321038A32 == "velikan_small")
    self._id_6D3FBC4590EDA90E = 1;
  else if(level.script == "cp_lone" && _id_800676BBD5453FC0._id_57F8B4C321038A32 == "juggernaut") {
    self._id_6D3FBC4590EDA90E = 1;
    self._id_734F7E3306DEEA28 = 1;
  } else if(level.script == "cp_lone" && _id_800676BBD5453FC0._id_57F8B4C321038A32 == "riotshield") {
    self._id_89D731AA29617691 = 1;
    self._id_1510D407FD4E16C1 = 1;
    self._id_6D3FBC4590EDA90E = 1;
    self._id_734F7E3306DEEA28 = 1;
    thread _id_8F0EF70C034A0477(_id_800676BBD5453FC0);

    if(getdvarint("dvar_A1760CE2E3F17F78", 1))
      self._id_C833409FB72D15FB = 1;
  }

  _id_90B5F7A3A8C60478(_id_800676BBD5453FC0._id_2444B7785351D927);
}

_id_8F0EF70C034A0477(_id_800676BBD5453FC0) {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("defender_bomb_planted", _id_6D2552E5D036E732, _id_3DEF217D9BD38E42);

    if(scripts\engine\utility::is_equal(_id_3DEF217D9BD38E42.targetname, _id_800676BBD5453FC0._id_8E55DFD0D38FE9A9)) {
      behavior = getDvar("dvar_F29CEDA238074DBA");

      if(behavior == "aggro")
        _id_ED8EA2155ED5CC6D(_id_3DEF217D9BD38E42);
      else if(scripts\common\utility::_id_1FB1CB439AA1E23C(behavior) && int(behavior) > 0)
        _id_B6CE87C382EA62F0(_id_3DEF217D9BD38E42, int(behavior));
      else
        _id_B6CE87C382EA62F0(_id_3DEF217D9BD38E42, 750);
    }
  }
}

_id_ED8EA2155ED5CC6D(_id_3DEF217D9BD38E42) {
  level endon("game_ended");
  self endon("death");
  self._id_C833409FB72D15FB = 0;
  level waittill("defender_defuse_" + _id_3DEF217D9BD38E42.targetname);
  self._id_C833409FB72D15FB = 1;
}

_id_B6CE87C382EA62F0(_id_3DEF217D9BD38E42, goal_radius) {
  level endon("game_ended");
  self endon("death");
  _id_18A73A64992DD07D::set_goal_radius(goal_radius);

  if(isDefined(_id_3DEF217D9BD38E42.points)) {
    if(getdvarint("dvar_BF4E690B12A81B75", 0)) {
      _id_18A73A64992DD07D::set_goal_pos(_id_3DEF217D9BD38E42.points[0]);
      _id_3DEF217D9BD38E42.points = scripts\engine\utility::array_remove_index(_id_3DEF217D9BD38E42.points, 0);
    }
  }

  self._id_1BD24C17AEE24DCE = 1;
  self._id_42DD56E19557F95A = 1;
  thread _id_1934E124EE63C90E(_id_3DEF217D9BD38E42);
  level waittill("defender_defuse_" + _id_3DEF217D9BD38E42.targetname);
  self._id_1BD24C17AEE24DCE = undefined;
  self._id_42DD56E19557F95A = undefined;
  _id_18A73A64992DD07D::set_goal_radius(self.last_goalradius);
}

_id_1934E124EE63C90E(_id_3DEF217D9BD38E42) {
  level endon("game_ended");
  level endon("defender_defuse_" + _id_3DEF217D9BD38E42.targetname);
  self endon("death");
  self waittill("");
}

_id_C60FE242A75AC1A3() {
  maxdist = 1250.0;
  _id_A358A38491A8BF41 = 1500.0;
  _id_42EAF72C59B78E70 = 2000.0;

  switch (self.aitype) {
    case "shotgun":
      maxdist = 750.0;
      _id_A358A38491A8BF41 = 1000.0;
      _id_42EAF72C59B78E70 = 900.0;
      break;
    case "sniper":
      maxdist = 3250.0;
      _id_A358A38491A8BF41 = 3500.0;
      _id_42EAF72C59B78E70 = 4000.0;
      break;
    case "ar_laser":
    case "lmg":
    case "smg":
    case "juggernaut":
    case "ar":
    default:
      break;
  }

  self setengagementmindist(725.0, 250.0);
  self setengagementmaxdist(maxdist, _id_A358A38491A8BF41);
  self _meth_9215CE6FC83759B9(_id_42EAF72C59B78E70);
}

_id_4886FCDE2970A5B5(group, _id_92DEFECADE96A443) {
  level endon("game_ended");
  self endon("death");
  self._id_6D3FBC4590EDA90E = 1;
  _id_8D34AA9DE4CF3556 = undefined;

  if(isDefined(group))
    _id_8D34AA9DE4CF3556 = group.spawn_points[0].script_parameters;
  else if(isDefined(_id_92DEFECADE96A443))
    _id_8D34AA9DE4CF3556 = _id_92DEFECADE96A443.script_parameters;

  _id_3DEF217D9BD38E42 = undefined;

  if(isDefined(_id_8D34AA9DE4CF3556))
    _id_3DEF217D9BD38E42 = _id_A74D0CFDC9AF0414(_id_8D34AA9DE4CF3556);

  if(isDefined(_id_3DEF217D9BD38E42)) {
    self waittill("unload");
    _id_90B5F7A3A8C60478(_id_3DEF217D9BD38E42);
  }
}

_id_5A52715BF68D9C6C() {
  level endon("game_ended");
  _id_9215D834F0060ABD = getaiarray("axis");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_9215D834F0060ABD.size; _id_AC0E594AC96AA3A8++) {
    if(isalive(_id_9215D834F0060ABD[_id_AC0E594AC96AA3A8])) {
      _id_9215D834F0060ABD[_id_AC0E594AC96AA3A8].dontkilloff = 0;
      _id_9215D834F0060ABD[_id_AC0E594AC96AA3A8] _id_18A73A64992DD07D::script_kill_ai();
    }
  }
}

_id_C568E04118C5C1B7() {
  _id_6D2552E5D036E732 = spawn("script_model", self.origin);
  _id_6D2552E5D036E732.angles = (0, 0, 0);
  _id_6D2552E5D036E732 setModel("offhand_2h_wm_briefcase_bomb_v0");
  _id_6D2552E5D036E732 setnonstick(1);
  return _id_6D2552E5D036E732;
}

_id_E0E39E60287FD525(_id_3DEF217D9BD38E42) {
  self endon("death");

  if(isDefined(self._id_800676BBD5453FC0) && istrue(self._id_800676BBD5453FC0.isheli)) {
    self._id_A488DDE722359BFF = self.baseaccuracy;
    self.baseaccuracy = 0.1;
  }

  if(isDefined(self.aitype) && self.aitype == "juggernaut") {
    _id_5B8DB1F519F9AB09 = scripts\cp\utility::get_closest_living_player();

    if(isDefined(_id_5B8DB1F519F9AB09))
      self getenemyinfo(_id_5B8DB1F519F9AB09);

    _id_18A73A64992DD07D::set_goal_radius(1250);
    _id_18A73A64992DD07D::set_goal_pos(_id_3DEF217D9BD38E42.origin);
  }

  if(!istrue(self._id_6D3FBC4590EDA90E))
    scripts\engine\utility::waittill_any_timeout_1(60, "vehicle_unloaded_me");

  _id_C60FE242A75AC1A3();

  if(isDefined(self._id_800676BBD5453FC0) && istrue(self._id_800676BBD5453FC0.isheli))
    self.baseaccuracy = self._id_A488DDE722359BFF;

  if(!istrue(self._id_6D3FBC4590EDA90E)) {
    self.goalheight = 512;
    _id_18A73A64992DD07D::set_goal_radius(1250);
    _id_18A73A64992DD07D::set_goal_pos(self.origin);
    wait 5;
  }

  level thread _id_1036D90B9590E441(self, self.group, _id_3DEF217D9BD38E42);

  while(!istrue(self._id_57FE63DB5392BD20))
    waitframe();

  thread _id_A089939911962257(_id_3DEF217D9BD38E42);
}

_id_1036D90B9590E441(_id_AAC4C873EE2EC04F, spawn_group, _id_3DEF217D9BD38E42) {
  if(!isDefined(spawn_group) && isDefined(_id_AAC4C873EE2EC04F._id_52284A320885226B)) {
    spawn_group = spawnStruct();
    spawn_group.ai_spawned = _id_AAC4C873EE2EC04F._id_52284A320885226B._id_0F29D6C1B1FA2281;
  } else if(!isDefined(spawn_group) && isDefined(_id_AAC4C873EE2EC04F._id_29EC6586C72EE216)) {
    spawn_group = spawnStruct();
    spawn_group.ai_spawned = _id_AAC4C873EE2EC04F._id_29EC6586C72EE216._id_0F29D6C1B1FA2281;
  }

  if(!isDefined(spawn_group)) {
    _id_8D34AA9DE4CF3556 = _id_DE5BD5987042469C(_id_3DEF217D9BD38E42);
    return;
  }

  if(istrue(spawn_group._id_58E5F54A72FC8F32) && level.script != "cp_lone") {
    return;
  }
  spawn_group._id_58E5F54A72FC8F32 = 1;
  _id_724652FE4F6D03D3 = [];

  foreach(guy in spawn_group.ai_spawned) {
    if(isalive(guy))
      _id_724652FE4F6D03D3[_id_724652FE4F6D03D3.size] = guy;
  }

  if(_id_724652FE4F6D03D3.size == 0) {
    return;
  }
  spawn_group._id_1566EFAF650DA642 = [];

  if(_id_724652FE4F6D03D3.size == 1) {
    _id_D8762563700992C5 = spawnStruct();
    _id_D8762563700992C5.guys = [_id_724652FE4F6D03D3[0]];
    spawn_group._id_1566EFAF650DA642[spawn_group._id_1566EFAF650DA642.size] = _id_D8762563700992C5;
  } else {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_724652FE4F6D03D3.size - 1; _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + 2) {
      guy1 = _id_724652FE4F6D03D3[_id_AC0E594AC96AA3A8];
      guy2 = _id_724652FE4F6D03D3[_id_AC0E594AC96AA3A8 + 1];
      _id_D8762563700992C5 = spawnStruct();
      _id_D8762563700992C5.guys = [];

      if(isDefined(guy1))
        _id_D8762563700992C5.guys[_id_D8762563700992C5.guys.size] = guy1;

      if(isDefined(guy2))
        _id_D8762563700992C5.guys[_id_D8762563700992C5.guys.size] = guy2;

      spawn_group._id_1566EFAF650DA642[spawn_group._id_1566EFAF650DA642.size] = _id_D8762563700992C5;
    }

    if(_id_724652FE4F6D03D3.size % 2 != 0) {
      _id_F7AD2A3EDB79C4DC = spawn_group._id_1566EFAF650DA642[spawn_group._id_1566EFAF650DA642.size - 1].guys.size;
      spawn_group._id_1566EFAF650DA642[spawn_group._id_1566EFAF650DA642.size - 1].guys[_id_F7AD2A3EDB79C4DC] = _id_724652FE4F6D03D3[_id_724652FE4F6D03D3.size - 1];
    }
  }

  _id_3AEDEE5FEEB11605 = [];
  _id_D45D0A861CCC8501 = _id_3DEF217D9BD38E42.origin + _id_724652FE4F6D03D3[0].origin;
  _id_B5C022F32DCC8947 = _id_D45D0A861CCC8501 * 0.5;
  _id_3AEDEE5FEEB11605[_id_3AEDEE5FEEB11605.size] = _id_B5C022F32DCC8947;
  _id_1E5D0ACFAE371CFC = scripts\engine\utility::randomvectorrange(300, 600);
  _id_B1BF0A1548C93485 = _id_B5C022F32DCC8947 + _id_1E5D0ACFAE371CFC;
  _id_CE3CD25204C11C93 = scripts\engine\utility::randomvectorrange(300, 600);
  _id_B1BF091548C93252 = _id_B5C022F32DCC8947 + _id_CE3CD25204C11C93;
  _id_3AEDEE5FEEB11605[_id_3AEDEE5FEEB11605.size] = _id_B1BF0A1548C93485;
  _id_3AEDEE5FEEB11605[_id_3AEDEE5FEEB11605.size] = _id_B1BF091548C93252;
  _id_3AEDEE5FEEB11605 = scripts\engine\utility::create_deck(_id_3AEDEE5FEEB11605);

  foreach(_id_D8762563700992C5 in spawn_group._id_1566EFAF650DA642) {
    _id_0E9BB2199503AD2A = _id_3AEDEE5FEEB11605 scripts\engine\utility::deck_draw();
    _id_637C181837130A35 = scripts\engine\utility::drop_to_ground(_id_0E9BB2199503AD2A, 1500);
    _id_637C181837130A35 = getclosestpointonnavmesh(_id_637C181837130A35);

    foreach(soldier in _id_D8762563700992C5.guys) {
      _id_BBEFE95087F2541E = soldier getclosestreachablepointonnavmesh(_id_637C181837130A35);
      soldier._id_82A322551D0D32D7 = _id_BBEFE95087F2541E;
      soldier._id_D7030CE8AE990036 = 250;
    }

    _id_B336A9C81B119DDD = _id_3DEF217D9BD38E42._id_F4951B6AB8E49D24 scripts\engine\utility::deck_draw();
    _id_B4D50444A55A7FC1 = 250;

    if(isDefined(_id_B336A9C81B119DDD.radius))
      _id_B4D50444A55A7FC1 = _id_B336A9C81B119DDD.radius;

    _id_B011942956062664 = scripts\engine\utility::drop_to_ground(_id_B336A9C81B119DDD.origin, 100);

    if(getdvarint("dvar_8D76FED7109A336A", 0) != 0) {
      level thread scripts\engine\utility::draw_circle(_id_637C181837130A35, 250, (1, 0.2, 0), 1, 0, 2400);
      level thread scripts\engine\utility::draw_circle(_id_B011942956062664, _id_B4D50444A55A7FC1, (1, 1, 0), 1, 0, 2400);
    }

    foreach(soldier in _id_D8762563700992C5.guys) {
      soldier._id_5C02CC2D0687BA76 = _id_B011942956062664;
      soldier._id_711A3F3F2DCAD5C3 = _id_B4D50444A55A7FC1;
    }
  }

  foreach(soldier in _id_724652FE4F6D03D3)
  soldier._id_57FE63DB5392BD20 = 1;
}

_id_A089939911962257(_id_3DEF217D9BD38E42) {
  level endon("game_ended");
  level endon("defender_wave_fail");
  self endon("death");
  _id_FC1B68D35BF3C6F6 = self._id_82A322551D0D32D7;
  _id_94C591C8C5B30E43 = self._id_D7030CE8AE990036;
  _id_B011942956062664 = self._id_5C02CC2D0687BA76;
  radius = self._id_711A3F3F2DCAD5C3;

  if(!isDefined(_id_B011942956062664)) {
    _id_B011942956062664 = _id_9472000B5A2CE4FC(self.origin);
    self.goalheight = 48;
    _id_18A73A64992DD07D::set_goal_pos(_id_B011942956062664.origin);
    _id_18A73A64992DD07D::set_goal_radius(500);
    return;
  }

  _id_C072C88EB4FEC698 = distancesquared(self.origin, _id_B011942956062664);
  thread _id_C2F4E54BF2DE4F3F(_id_FC1B68D35BF3C6F6, _id_94C591C8C5B30E43);

  if(!isDefined(radius))
    radius = 200;

  _id_636C8575D7A7768B = radius * radius;
  _id_75E3FC7AC2A4A855 = 0;
  self.dropweapon = 1;
  _id_70C20D1C0379C569 = 0;

  if(isDefined(_id_FC1B68D35BF3C6F6) && isDefined(_id_B011942956062664)) {
    if(istrue(self._id_1510D407FD4E16C1) || distancesquared(self.origin, _id_FC1B68D35BF3C6F6) > distancesquared(self.origin, _id_B011942956062664))
      _id_70C20D1C0379C569 = 1;
  }

  if(isDefined(_id_FC1B68D35BF3C6F6) && isDefined(_id_94C591C8C5B30E43) && !_id_70C20D1C0379C569) {
    self.goalheight = 48;
    self.script_origin_other = _id_FC1B68D35BF3C6F6;
    _id_18A73A64992DD07D::set_goal_pos(_id_FC1B68D35BF3C6F6);
    _id_18A73A64992DD07D::set_goal_radius(int(_id_94C591C8C5B30E43 * 0.75));
    _id_3507311C485A1877 = _id_94C591C8C5B30E43 * _id_94C591C8C5B30E43;

    for(;;) {
      wait 0.25;
      _id_C192D13430500382(_id_FC1B68D35BF3C6F6, radius);

      if(distancesquared(self.origin, _id_FC1B68D35BF3C6F6) <= _id_3507311C485A1877) {
        break;
      }
    }
  }

  self.goalheight = 48;
  self.script_origin_other = _id_B011942956062664;
  _id_18A73A64992DD07D::set_goal_pos(_id_B011942956062664);
  _id_18A73A64992DD07D::set_goal_radius(int(radius * 0.75));
  _id_DDA735B01842CE27 = undefined;
  _id_72F7ACEFFD267EFF = 15000;

  if(istrue(level._id_21F279867AD3E473))
    _id_72F7ACEFFD267EFF = 500;
  else if(isDefined(level._id_62F5F42C7C300055) && level._id_62F5F42C7C300055 == 4)
    _id_72F7ACEFFD267EFF = _id_0553FD7172D17D5E(15, 10) * 1000;
  else if(isDefined(level._id_62F5F42C7C300055) && level._id_62F5F42C7C300055 == 5)
    _id_72F7ACEFFD267EFF = _id_0553FD7172D17D5E(14, 9) * 1000;
  else if(isDefined(level._id_62F5F42C7C300055) && level._id_62F5F42C7C300055 == 6)
    _id_72F7ACEFFD267EFF = _id_0553FD7172D17D5E(13, 8) * 1000;

  for(;;) {
    wait 0.25;
    self.goalheight = 48;

    if(isDefined(_id_3DEF217D9BD38E42._id_8417E0F03AE0E83A)) {
      _id_18A73A64992DD07D::set_goal_radius(int(radius * 2));
      _id_18A73A64992DD07D::set_goal_pos(_id_B011942956062664);
      self.goalheight = 48;
      _id_75E3FC7AC2A4A855 = 1;
      continue;
    }

    while(distancesquared(self.origin, _id_B011942956062664) > _id_636C8575D7A7768B) {
      wait 0.25;
      _id_C192D13430500382(_id_B011942956062664, radius, _id_3DEF217D9BD38E42);

      if(_id_75E3FC7AC2A4A855) {
        if(isDefined(_id_3DEF217D9BD38E42._id_8417E0F03AE0E83A))
          _id_18A73A64992DD07D::set_goal_radius(int(radius * 0.5));
        else
          _id_18A73A64992DD07D::set_goal_radius(int(radius * 1.5));

        _id_18A73A64992DD07D::set_goal_pos(_id_B011942956062664);
        self.goalheight = 48;
        _id_75E3FC7AC2A4A855 = 0;
      }
    }

    if(!isDefined(_id_DDA735B01842CE27))
      _id_DDA735B01842CE27 = gettime();

    if(gettime() < _id_DDA735B01842CE27 + _id_72F7ACEFFD267EFF) {
      continue;
    }
    if(istrue(_id_3DEF217D9BD38E42._id_4C9317C1E2AEB7D6)) {
      _id_18A73A64992DD07D::set_goal_radius(int(radius * 3));
      continue;
    }

    if(isDefined(_id_3DEF217D9BD38E42._id_8417E0F03AE0E83A) || isDefined(_id_3DEF217D9BD38E42._id_9D05FBD51E1BE264)) {
      continue;
    }
    if(self.origin - _id_B011942956062664[2] > self.goalheight + 1) {
      continue;
    }
    if(!isDefined(_id_3DEF217D9BD38E42._id_78EA08F11A7CDB0E))
      _id_3DEF217D9BD38E42._id_78EA08F11A7CDB0E = [];

    if(_id_3DEF217D9BD38E42._id_78EA08F11A7CDB0E.size >= 1) {
      continue;
    }
    level _id_1B3A8AF37328E37B(_id_3DEF217D9BD38E42, self);
  }
}

_id_9542D6173BC82103(center, radius, duration, color, debug, _id_D5C216E05EE2AFC5) {
  level endon("game_ended");
  contents = scripts\engine\trace::create_solid_ai_contents(1);
  _id_851DF4CD0132B5FA = 32;
  _id_7062EA7309FA49C4 = 360 / _id_851DF4CD0132B5FA;
  _id_8AF33769F877B5D6 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_851DF4CD0132B5FA; _id_AC0E594AC96AA3A8++) {
    angle = _id_7062EA7309FA49C4 * _id_AC0E594AC96AA3A8;
    _id_8A9F895755FD607E = cos(angle) * radius;
    _id_D867033AB311670B = sin(angle) * radius;
    x = center[0] + _id_8A9F895755FD607E;
    y = center[1] + _id_D867033AB311670B;
    z = center[2];
    _id_E812FA6CB1D7F220 = (x, y, z);
    _id_F0D0842E8A7BD953 = getclosestpointonnavmesh(_id_E812FA6CB1D7F220);

    if(distance(_id_E812FA6CB1D7F220, _id_F0D0842E8A7BD953) <= 256) {
      _id_79B0DA6DAA286045 = _id_E812FA6CB1D7F220 + (0, 0, 8);
      results = scripts\engine\trace::ray_trace(_id_79B0DA6DAA286045, _id_F0D0842E8A7BD953 + (0, 0, 8), level.characters, contents);
      _id_A19710458072679E = results["position"];
      _id_8AF33769F877B5D6[_id_8AF33769F877B5D6.size] = _id_A19710458072679E;
    }
  }

  if(istrue(debug))
    level thread _id_A0C6495E0E75753E(_id_8AF33769F877B5D6, duration, color, _id_D5C216E05EE2AFC5, center);

  return _id_8AF33769F877B5D6;
}

_id_A0C6495E0E75753E(_id_8AF33769F877B5D6, duration, color, _id_D5C216E05EE2AFC5, center) {
  if(!isDefined(_id_D5C216E05EE2AFC5))
    _id_D5C216E05EE2AFC5 = 0;

  if(!isDefined(center))
    _id_D5C216E05EE2AFC5 = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_8AF33769F877B5D6.size; _id_AC0E594AC96AA3A8++) {
    start = _id_8AF33769F877B5D6[_id_AC0E594AC96AA3A8];

    if(_id_AC0E594AC96AA3A8 + 1 >= _id_8AF33769F877B5D6.size)
      end = _id_8AF33769F877B5D6[0];
    else
      end = _id_8AF33769F877B5D6[_id_AC0E594AC96AA3A8 + 1];

    thread _id_97B69CF14FE2763B(start, end, duration, color);

    if(_id_D5C216E05EE2AFC5)
      thread _id_97B69CF14FE2763B(center, start, duration, color);
  }
}

_id_97B69CF14FE2763B(start, end, duration, color) {
  if(!isDefined(color))
    color = (1, 1, 1);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < duration * 20; _id_AC0E594AC96AA3A8++)
    wait 0.05;
}

_id_C2F4E54BF2DE4F3F(_id_FC1B68D35BF3C6F6, _id_94C591C8C5B30E43) {
  level endon("game_ended");
  level endon("defender_wave_fail");
  self endon("death");

  if(!istrue(self._id_57FE63DB5392BD20)) {
    return;
  }
  if(istrue(self._id_635445FFD95F8CED)) {
    return;
  }
  self._id_635445FFD95F8CED = 1;
  wait 0.5;
  _id_91AE7188F4C06C96 = gettime();
  _id_E5D77BF46A926594 = self.origin;

  for(;;) {
    _id_3DDC8C43F324A300 = 0;

    while(distance2d(self.origin, _id_E5D77BF46A926594) < 50) {
      _id_3DDC8C43F324A300++;

      if(_id_3DDC8C43F324A300 > 10) {
        break;
      }

      if(gettime() > _id_91AE7188F4C06C96 + 20000) {
        self dodamage(self.maxhealth + 100, self.origin);
        return;
      }

      wait 0.1;
    }

    if(gettime() > _id_91AE7188F4C06C96 + 20000) {
      return;
    }
    if(_id_3DDC8C43F324A300 > 10) {
      if(istrue(self.is_on_platform))
        self.is_on_platform = undefined;
      else {}

      self.goalheight = 48;
      self.script_origin_other = _id_FC1B68D35BF3C6F6;
      _id_18A73A64992DD07D::set_goal_pos(_id_FC1B68D35BF3C6F6);
      _id_18A73A64992DD07D::set_goal_radius(int(_id_94C591C8C5B30E43 * 0.75));
      _id_3DDC8C43F324A300 = 0;
      wait 1;
    } else
      return;

    wait 0.1;
  }
}

_id_C192D13430500382(_id_B011942956062664, _id_B4D50444A55A7FC1, _id_3DEF217D9BD38E42) {
  if(istrue(self._id_734F7E3306DEEA28) || getdvarint("dvar_EEDC456CB0CCE98F")) {
    return;
  }
  level endon("game_ended");
  level endon("defender_wave_fail");
  self endon("death");
  _id_CDC5DD6C28C9709D = 4000000;
  nearbyplayer = scripts\cp\utility::get_closest_living_player(_id_CDC5DD6C28C9709D);
  self._id_EE2257DCCC5D6DF8 = self.combatmode;
  _id_A1F5B8A402831248 = 0;

  if(isDefined(nearbyplayer) && _id_D837E8A474C52FDC(nearbyplayer) && _id_2B79931B08683E0A::player_can_see_ai(nearbyplayer, self) && _id_3EE5A1E40201ADF0()) {
    _id_D41F1CE9D2B706F2 = gettime() + 10000;

    while(gettime() <= _id_D41F1CE9D2B706F2 || _id_2B79931B08683E0A::player_can_see_ai(nearbyplayer, self)) {
      if(!_id_A1F5B8A402831248) {
        self.combatmode = "no_cover";
        self._id_894D1167ACE5B58C = 1;
        self getenemyinfo(nearbyplayer);
        _id_C7E2DA5EEB30DE27 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

        foreach(_id_3D37BFB60D26484E in _id_C7E2DA5EEB30DE27) {
          if(_id_3D37BFB60D26484E == self) {
            continue;
          }
          if(distance(self.origin, _id_3D37BFB60D26484E.origin) < 500)
            _id_3D37BFB60D26484E getenemyinfo(nearbyplayer);
        }

        _id_8B591B0BC361AB3D = randomint(6);

        if(_id_8B591B0BC361AB3D > 0) {
          self allowedstances("crouch", "prone");
          _id_18A73A64992DD07D::set_goal_radius(int(500));
        } else {
          self allowedstances("prone");
          _id_18A73A64992DD07D::set_goal_radius(int(30));
        }

        _id_18A73A64992DD07D::set_goal_pos(self.origin);
        _id_D41F1CE9D2B706F2 = gettime() + 10000;
        _id_A1F5B8A402831248 = 1;
      }

      wait 0.5;
    }
  }

  if(_id_A1F5B8A402831248) {
    _id_18A73A64992DD07D::set_goal_pos(_id_B011942956062664);
    self.combatmode = self._id_EE2257DCCC5D6DF8;
    self._id_894D1167ACE5B58C = 0;
    self allowedstances("stand", "crouch", "prone");

    if(isDefined(_id_3DEF217D9BD38E42)) {
      if(isDefined(_id_3DEF217D9BD38E42._id_8417E0F03AE0E83A))
        _id_18A73A64992DD07D::set_goal_radius(int(_id_B4D50444A55A7FC1 * 4));
      else
        _id_18A73A64992DD07D::set_goal_radius(int(_id_B4D50444A55A7FC1 * 0.75));
    } else
      _id_18A73A64992DD07D::set_goal_radius(int(_id_B4D50444A55A7FC1));
  }
}

_id_D837E8A474C52FDC(nearbyplayer) {
  _id_4D6D6A486EF55682 = scripts\cp\utility::ifcanseeplayer(self, nearbyplayer);

  if(_id_4D6D6A486EF55682)
    return 1;

  if(!isDefined(level._id_E3FA08A0EE652BFE))
    return 0;

  level thread _id_0D3440293BB1D1E0();
  maxdist = 500;

  if(isDefined(level._id_E3FA08A0EE652BFE) && level._id_E3FA08A0EE652BFE > 1)
    maxdist = level._id_E3FA08A0EE652BFE;

  _id_EC04BFA60B059B91 = _id_6D90D2C7541C3C24(self.origin, maxdist);
  _id_1099E57A3E1A91B3 = distance(self.origin, nearbyplayer.origin) < maxdist;
  return _id_EC04BFA60B059B91 && _id_1099E57A3E1A91B3;
}

_id_6D90D2C7541C3C24(origin, maxdist) {
  foreach(index, value in level._id_7B69DA49FA892AE5) {
    if(distance(origin, value) < maxdist)
      return 1;
  }

  return 0;
}

_id_0D3440293BB1D1E0() {
  level endon("game_ended");

  if(isDefined(level._id_0D3440293BB1D1E0)) {
    return;
  }
  level._id_0D3440293BB1D1E0 = 1;
  level._id_7B69DA49FA892AE5 = [];
  level thread _id_D04F2647C38C06C6();

  for(;;) {
    level waittill("ai_killed", _id_C9B351269A319209, sweapon, smeansofdeath, eattacker, _id_E851FFA44B7E0D54, team);
    level._id_7B69DA49FA892AE5[gettime()] = _id_C9B351269A319209;
  }
}

_id_D04F2647C38C06C6() {
  level endon("game_ended");

  for(;;) {
    foreach(index, value in level._id_7B69DA49FA892AE5) {
      if(gettime() > index + 10000)
        level._id_7B69DA49FA892AE5 = scripts\engine\utility::array_remove_index(level._id_7B69DA49FA892AE5, index);
    }

    wait 1;
  }
}

_id_3EE5A1E40201ADF0() {
  if(isDefined(self.unittype) && self.unittype == "juggernaut")
    return 0;

  if(isDefined(self.unittype) && self.unittype == "suicidebomber")
    return 0;

  if(istrue(self.hasriotshieldequipped) || istrue(self.bhasriotshieldattached))
    return 0;

  return 1;
}

_id_1B3A8AF37328E37B(_id_3DEF217D9BD38E42, soldier) {
  level endon("defender_wave_fail");
  level endon("defender_wave_win");
  soldier endon("stop_planting");
  soldier thread _id_27B8FD877779125A();
  _id_3DEF217D9BD38E42._id_78EA08F11A7CDB0E[_id_3DEF217D9BD38E42._id_78EA08F11A7CDB0E.size] = soldier;
  level thread _id_6EE457F206994784(soldier, _id_3DEF217D9BD38E42);
  _id_0B055EF3C7C251B3 = 5;
  wait(_id_0B055EF3C7C251B3);
  _id_3DEF217D9BD38E42._id_78EA08F11A7CDB0E = scripts\engine\utility::array_remove(_id_3DEF217D9BD38E42._id_78EA08F11A7CDB0E, soldier);

  if(!scripts\engine\utility::is_dead_or_dying(soldier) && !istrue(soldier._id_12BFB031C0A0EFD8)) {
    soldier thread _id_73B942309FE810CF();

    if(isDefined(_id_3DEF217D9BD38E42._id_8417E0F03AE0E83A) || isDefined(_id_3DEF217D9BD38E42._id_9D05FBD51E1BE264)) {
      return;
    }
    _id_6D2552E5D036E732 = soldier _id_C568E04118C5C1B7();

    if(!isDefined(_id_6D2552E5D036E732)) {
      return;
    }
    _id_3DEF217D9BD38E42._id_8417E0F03AE0E83A = _id_6D2552E5D036E732;

    if(getdvarint("dvar_BF4E690B12A81B75", 0))
      _id_3DEF217D9BD38E42.points = level thread _id_9542D6173BC82103(_id_6D2552E5D036E732.origin, 256, 30, (1, 1, 1), 1);

    _id_6D2552E5D036E732._id_800676BBD5453FC0 = _id_3DEF217D9BD38E42._id_800676BBD5453FC0;
    _id_6D2552E5D036E732._id_8E55DFD0D38FE9A9 = _id_3DEF217D9BD38E42.targetname;
    _id_6D2552E5D036E732._id_2444B7785351D927 = _id_3DEF217D9BD38E42;
    soldier notify("planting_bomb");
    soldier _id_37EAE8BA188ED2FB(_id_6D2552E5D036E732);
    soldier _id_BCAD99B8D2474FB2(_id_6D2552E5D036E732.origin);
    thread _id_457CAE897AA9DF3A(_id_6D2552E5D036E732);
    level thread _id_AEBE0D181B587C6C(_id_6D2552E5D036E732);
  }

  foreach(_id_B309C6E731DF9A84 in _id_3DEF217D9BD38E42._id_78EA08F11A7CDB0E) {
    if(isalive(_id_B309C6E731DF9A84)) {
      _id_B309C6E731DF9A84 notify("stop_planting");
      _id_B309C6E731DF9A84 thread _id_73B942309FE810CF();
    }

    _id_3DEF217D9BD38E42._id_78EA08F11A7CDB0E = scripts\engine\utility::array_remove(_id_3DEF217D9BD38E42._id_78EA08F11A7CDB0E, _id_B309C6E731DF9A84);
  }
}

_id_457CAE897AA9DF3A(_id_6D2552E5D036E732) {
  level endon("game_ended");
  _id_718895D1E87827FB = _id_6D2552E5D036E732 scripts\engine\utility::waittill_any_return_2("defuse", "explode");

  if(isDefined(_id_6D2552E5D036E732))
    _id_6D2552E5D036E732 hide();

  wait 1.5;

  if(isDefined(_id_6D2552E5D036E732))
    _id_6D2552E5D036E732 show();
}

_id_FE660700623BB3B7(guy) {
  if(!isDefined(guy) || !isent(guy) || !isalive(guy)) {
    return;
  }
  _id_CABA8F7514DC5EDE = self.angles;
  angles = vectortoangles(self.origin - guy.origin);
  angles = (_id_CABA8F7514DC5EDE[0], angles[1], _id_CABA8F7514DC5EDE[2]);
  self.angles = angles;
}

_id_BCAD99B8D2474FB2(location) {
  if(istrue(self._id_89D731AA29617691)) {
    return;
  }
  self.combatmode = "cover";
  self._id_456F1227DDA72419 = 1;
  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 1);
  _id_79B0DA6DAA286045 = location + (0, 0, 24);
  _id_C12A580CEB39E9F8 = getnodesinradius(self.origin, 512, 4, 128);
  _id_D779AB9570AC3C49 = [];
  _id_0386C209C4BE9E91 = undefined;

  foreach(node in _id_C12A580CEB39E9F8) {
    if(!scripts\engine\trace::ray_trace_passed(_id_79B0DA6DAA286045, node.origin, self, contents)) {
      continue;
    }
    _id_D779AB9570AC3C49[_id_D779AB9570AC3C49.size] = node;
  }

  if(_id_D779AB9570AC3C49.size > 0) {
    _id_D779AB9570AC3C49 = sortbydistance(_id_D779AB9570AC3C49, location);
    _id_0386C209C4BE9E91 = scripts\engine\utility::random_weight_sorted(_id_D779AB9570AC3C49);
  } else {
    _id_18A73A64992DD07D::set_goal_radius(256);
    _id_18A73A64992DD07D::set_goal_pos(location);
    self.goalheight = 48;
  }

  if(isDefined(_id_0386C209C4BE9E91) && !isDefined(self._id_22DEE6061A1F28FA)) {
    self._id_22DEE6061A1F28FA = _id_0386C209C4BE9E91;
    self._id_F62666252EB4A534 = _id_0386C209C4BE9E91.origin;
    self usecovernode(self._id_22DEE6061A1F28FA, 1);
    self setgoalnode(self._id_22DEE6061A1F28FA);
    _id_18A73A64992DD07D::set_goal_radius(48);
    _id_18A73A64992DD07D::set_goal_pos(self._id_F62666252EB4A534);
    self.goalheight = 48;
    self.script_origin_other = self._id_F62666252EB4A534;
  }
}

_id_6EE457F206994784(soldier, _id_3DEF217D9BD38E42) {
  level endon("game_ended");
  soldier endon("stop_planting");
  soldier waittill("death");

  if(isDefined(scripts\engine\utility::array_find(_id_3DEF217D9BD38E42._id_78EA08F11A7CDB0E, soldier)))
    _id_3DEF217D9BD38E42._id_78EA08F11A7CDB0E = scripts\engine\utility::array_remove(_id_3DEF217D9BD38E42._id_78EA08F11A7CDB0E, soldier);
}

_id_27B8FD877779125A() {
  self.ignoreall = 1;

  if(!istrue(self._id_89D731AA29617691)) {
    self allowedstances("crouch", "prone");
    scripts\common\ai::set_gunpose("gun_down");
  }

  self._id_9ED1E0D59012EC45 = 1;
  self._id_E5619C9A71F194B2 = self.script_origin_other;
  self.script_origin_other = self.origin;
  _id_18A73A64992DD07D::set_goal_pos(self.script_origin_other);
  _id_18A73A64992DD07D::set_goal_radius(32);
  maxdist = 22500;
  nearbyplayer = scripts\cp\utility::get_closest_living_player(maxdist);

  if(isDefined(nearbyplayer))
    scripts\common\utility::lookatentity(nearbyplayer);
}

_id_73B942309FE810CF() {
  self.ignoreall = 0;
  self allowedstances("stand", "prone", "crouch");
  scripts\common\ai::reset_gunpose();
  scripts\common\utility::lookatentity();
  self._id_9ED1E0D59012EC45 = undefined;

  if(isDefined(self._id_E5619C9A71F194B2))
    self.script_origin_other = self._id_E5619C9A71F194B2;

  if(isDefined(self.script_origin_other))
    _id_18A73A64992DD07D::set_goal_pos(self.script_origin_other);

  _id_18A73A64992DD07D::set_goal_radius(512);
}

_id_37EAE8BA188ED2FB(_id_6D2552E5D036E732, _id_084D0C3E36ADDFA4) {
  _id_6D2552E5D036E732 unlink();
  _id_6D2552E5D036E732.carrier = undefined;
  _id_6D2552E5D036E732 _id_9AEFD325D33E4111();
  _id_6D2552E5D036E732 _id_FE660700623BB3B7(self);
  level _id_F67FCD8E78A3E9A4(_id_6D2552E5D036E732);
  self notify("dropped_bomb");
}

_id_9AEFD325D33E4111() {
  _id_FFB3AE7992A8FE03 = scripts\engine\utility::drop_to_ground(self.origin, 100);
  _id_FFB3AE7992A8FE03 = getclosestpointonnavmesh(_id_FFB3AE7992A8FE03);
  _id_FFB3AE7992A8FE03 = _getphysicspointaboutnavmesh(_id_FFB3AE7992A8FE03);
  self.origin = _id_FFB3AE7992A8FE03 + (0, 0, 2);
}

_getphysicspointaboutnavmesh(_id_CDCD3178F5176585) {
  contents = scripts\engine\trace::create_contents(undefined, 1, 1, undefined, undefined, undefined, undefined);
  _id_BC1FB594D8A6E68A = physics_raycast(_id_CDCD3178F5176585 + (0, 0, 48), _id_CDCD3178F5176585 - (0, 0, 48), contents, undefined, 0, "physicsquery_closest");
  hit = isDefined(_id_BC1FB594D8A6E68A) && _id_BC1FB594D8A6E68A.size > 0;

  if(hit) {
    _id_2E3BC21C15E7AB6C = _id_BC1FB594D8A6E68A[0]["position"];
    return _id_2E3BC21C15E7AB6C;
  }

  return _id_CDCD3178F5176585;
}

_id_5F547506E25B5635(_id_6D2552E5D036E732) {
  level endon("game_ended");
  level endon("defender_wave_fail");
  self endon("planting_bomb");
  self waittill("death");
  _id_37EAE8BA188ED2FB(_id_6D2552E5D036E732);
}

_id_74AED39F9F2BE31E(_id_6D2552E5D036E732) {
  _id_6D2552E5D036E732._id_631FE08093CF6DD5 = scripts\engine\utility::spawn_tag_origin(_id_6D2552E5D036E732.origin, (0, 0, 0));
  _id_6D2552E5D036E732._id_631FE08093CF6DD5 linkTo(_id_6D2552E5D036E732, "tag_origin", (0, 0, 64), (0, 0, 0));
  _id_6D2552E5D036E732 thread scripts\engine\utility::delete_on_death(_id_6D2552E5D036E732._id_631FE08093CF6DD5);
  _id_6D2552E5D036E732._id_631FE08093CF6DD5 show();
  objindex = scripts\cp\cp_objectives::requestworldid("defender_bomb", 25);
  objective_state(objindex, "current");
  objective_icon(objindex, "hud_objective_bomb");
  objective_setminimapiconsize(objindex, "icon_regular");
  objective_setshowdistance(objindex, 1);
  objective_setplayintro(objindex, 1);
  objective_sethot(objindex, 0);
  objective_setownerteam(objindex, "axis");
  objective_onentity(objindex, _id_6D2552E5D036E732._id_631FE08093CF6DD5);
  _id_6D2552E5D036E732.objindex = objindex;
}

_id_E9E9BC2CE1E746B7(_id_6D2552E5D036E732) {
  if(!isDefined(_id_6D2552E5D036E732.objindex)) {
    return;
  }
  objective_delete(_id_6D2552E5D036E732.objindex);
  scripts\cp\cp_objectives::freeworldidbyobjid(_id_6D2552E5D036E732.objindex);
  _id_6D2552E5D036E732.objindex = undefined;
}

_id_7F279DC5A10FAEA9() {
  level._id_1B897F0A3B2671E3 = [];
  spawnfunc = _id_18A73A64992DD07D::registerambientgroup;
  _id_C53ACC7459F21481 = scripts\engine\utility::getStructArray("defender_attackgroup", "script_noteworthy");

  foreach(struct in _id_C53ACC7459F21481) {
    _id_800676BBD5453FC0 = spawnStruct();
    _id_45F52061EA9ACA92 = [];

    if(isDefined(struct.target))
      _id_45F52061EA9ACA92 = scripts\engine\utility::getStructArray(struct.target, "targetname");

    _id_800676BBD5453FC0._id_79F102B3ABCC6F8A = _id_45F52061EA9ACA92;

    foreach(_id_8E202DCAA9E92C3D in _id_800676BBD5453FC0._id_79F102B3ABCC6F8A)
    _id_8E202DCAA9E92C3D.script_parameters = struct.script_parameters;

    _id_800676BBD5453FC0._id_8E55DFD0D38FE9A9 = "point_" + struct.script_parameters;
    _id_800676BBD5453FC0._id_2444B7785351D927 = scripts\engine\utility::getStruct(_id_800676BBD5453FC0._id_8E55DFD0D38FE9A9, "targetname");
    _id_800676BBD5453FC0._id_57F8B4C321038A32 = struct.script_aigroup;

    if(!isDefined(_id_800676BBD5453FC0._id_2444B7785351D927._id_C68454D783B47EF5))
      _id_800676BBD5453FC0._id_2444B7785351D927._id_C68454D783B47EF5 = [];

    if(!isDefined(_id_800676BBD5453FC0._id_2444B7785351D927._id_C68454D783B47EF5[_id_800676BBD5453FC0._id_57F8B4C321038A32]))
      _id_800676BBD5453FC0._id_2444B7785351D927._id_C68454D783B47EF5[_id_800676BBD5453FC0._id_57F8B4C321038A32] = 1;
    else
      _id_800676BBD5453FC0._id_2444B7785351D927._id_C68454D783B47EF5[_id_800676BBD5453FC0._id_57F8B4C321038A32]++;

    _id_3E955591D6FEBC8D = _id_800676BBD5453FC0._id_2444B7785351D927._id_C68454D783B47EF5[_id_800676BBD5453FC0._id_57F8B4C321038A32];
    _id_800676BBD5453FC0._id_0609A4782A20A699 = _id_3E955591D6FEBC8D;

    if(!isDefined(_id_800676BBD5453FC0._id_2444B7785351D927._id_D376D216074B16A9))
      _id_800676BBD5453FC0._id_2444B7785351D927._id_D376D216074B16A9 = [];

    _id_800676BBD5453FC0._id_2444B7785351D927._id_D376D216074B16A9[_id_800676BBD5453FC0._id_2444B7785351D927._id_D376D216074B16A9.size] = _id_800676BBD5453FC0;
    _id_C0EFC1E0E1B79D08 = 1;
    _id_FC3670006DAE0C6E = 5;
    _id_96F6432A4795C30A = 5;
    script_function = undefined;
    _id_FBA3035AFBCB1EAA = undefined;
    isheli = undefined;
    script_noteworthy = undefined;
    _id_83EE2EFFB4CB1B81 = undefined;
    _id_BD8883D612FBB662 = undefined;
    _id_620CF63F086981E0 = undefined;
    _id_4F808D1D41DA006C = 0.1;

    if(isDefined(_id_800676BBD5453FC0._id_57F8B4C321038A32)) {
      switch (_id_800676BBD5453FC0._id_57F8B4C321038A32) {
        case "soldier":
          _id_C0EFC1E0E1B79D08 = 1;
          _id_FC3670006DAE0C6E = 8;
          _id_96F6432A4795C30A = 8;
          _id_FBA3035AFBCB1EAA = 1;
          break;
        case "turret":
          _id_C0EFC1E0E1B79D08 = 1;
          _id_FC3670006DAE0C6E = 7;
          _id_96F6432A4795C30A = 7;
          _id_FBA3035AFBCB1EAA = 0;
          break;
        case "riotshield":
          if(level.script == "cp_observatory") {
            _id_C0EFC1E0E1B79D08 = 1;
            _id_FC3670006DAE0C6E = 4;
            _id_96F6432A4795C30A = 4;
            _id_FBA3035AFBCB1EAA = 0;
          } else {
            _id_C0EFC1E0E1B79D08 = 3;
            _id_FC3670006DAE0C6E = 3;
            _id_96F6432A4795C30A = 3;
            _id_FBA3035AFBCB1EAA = 1;
            isheli = 0;
          }

          break;
        case "truck":
        case "suicidebomber":
          _id_C0EFC1E0E1B79D08 = 1;
          _id_FC3670006DAE0C6E = 4;
          _id_96F6432A4795C30A = 4;
          _id_FBA3035AFBCB1EAA = 0;
          break;
        case "medium_close":
        case "medium":
          _id_C0EFC1E0E1B79D08 = 1;
          _id_FC3670006DAE0C6E = 7;
          _id_96F6432A4795C30A = 7;
          _id_FBA3035AFBCB1EAA = 1;
          script_function = "veh9_mil_air_heli_medium_mp";
          script_noteworthy = "ar smg";
          isheli = 1;
          break;
        case "medium_hover":
          _id_C0EFC1E0E1B79D08 = 1;
          _id_FC3670006DAE0C6E = 8;
          _id_96F6432A4795C30A = 8;
          _id_FBA3035AFBCB1EAA = 1;
          script_function = "medium_hover";
          script_noteworthy = "ar smg";
          isheli = 1;
          break;
        case "heli_heavy":
          _id_C0EFC1E0E1B79D08 = 1;
          _id_FC3670006DAE0C6E = 1;
          script_function = "heli_heavy";
          isheli = 1;
          break;
        case "mortar":
          _id_FBA3035AFBCB1EAA = 0;
        case "bomber_small":
          _id_C0EFC1E0E1B79D08 = 1;
          _id_FC3670006DAE0C6E = 1;
          _id_96F6432A4795C30A = 1;
          _id_FBA3035AFBCB1EAA = 1;
          script_noteworthy = "suicidebomber";
          isheli = 0;
          _id_83EE2EFFB4CB1B81 = 0;
          break;
        case "bomber_medium":
          _id_C0EFC1E0E1B79D08 = 2;
          _id_FC3670006DAE0C6E = 2;
          _id_96F6432A4795C30A = 2;
          _id_4F808D1D41DA006C = 3;
          _id_FBA3035AFBCB1EAA = 1;
          script_noteworthy = "suicidebomber";
          isheli = 0;
          _id_83EE2EFFB4CB1B81 = 0;
          break;
        case "bomber_large":
          _id_C0EFC1E0E1B79D08 = 3;
          _id_FC3670006DAE0C6E = 3;
          _id_96F6432A4795C30A = 3;
          _id_4F808D1D41DA006C = 4;
          _id_FBA3035AFBCB1EAA = 1;
          script_noteworthy = "suicidebomber";
          isheli = 0;
          _id_83EE2EFFB4CB1B81 = 0;
          break;
        case "juggernaut":
          _id_C0EFC1E0E1B79D08 = 1;
          _id_FC3670006DAE0C6E = 1;
          _id_96F6432A4795C30A = 1;
          _id_FBA3035AFBCB1EAA = 1;
          script_noteworthy = "juggernaut";
          isheli = 0;
          break;
        case "velikan_small":
          _id_C0EFC1E0E1B79D08 = 2;
          _id_FC3670006DAE0C6E = 2;
          _id_96F6432A4795C30A = 2;
          _id_FBA3035AFBCB1EAA = 1;
          isheli = 0;
          break;
      }
    }

    if(istrue(isheli)) {
      _id_FC3670006DAE0C6E = _id_FC3670006DAE0C6E + 2;
      _id_96F6432A4795C30A = _id_96F6432A4795C30A + 2;
    }

    _id_3E2A73CF57C32C7C = "defender_group_" + _id_800676BBD5453FC0._id_8E55DFD0D38FE9A9 + "_" + _id_800676BBD5453FC0._id_57F8B4C321038A32 + "_" + _id_3E955591D6FEBC8D;
    _id_800676BBD5453FC0._id_3E2A73CF57C32C7C = _id_3E2A73CF57C32C7C;

    if(istrue(_id_FBA3035AFBCB1EAA)) {
      [[spawnfunc]](_id_3E2A73CF57C32C7C, _id_C0EFC1E0E1B79D08, _id_FC3670006DAE0C6E, _id_96F6432A4795C30A, _id_4F808D1D41DA006C, 0, struct.target, ::watchforstopwaves, undefined, undefined);
      _id_759EE77E620C0DB7 = level.ambientgroups[_id_3E2A73CF57C32C7C];
      _id_800676BBD5453FC0._id_759EE77E620C0DB7 = _id_759EE77E620C0DB7;
      _id_18A73A64992DD07D::register_module_ai_spawn_func(_id_3E2A73CF57C32C7C, ::_id_7DFF7E168DC5F859);

      if(isDefined(script_function))
        _id_800676BBD5453FC0._id_759EE77E620C0DB7.script_function = script_function;

      if(isDefined(_id_BD8883D612FBB662))
        _id_800676BBD5453FC0._id_759EE77E620C0DB7._id_BD8883D612FBB662 = _id_BD8883D612FBB662;

      if(isDefined(isheli))
        _id_800676BBD5453FC0.isheli = isheli;

      if(isDefined(script_noteworthy))
        _id_800676BBD5453FC0.script_noteworthy = script_noteworthy;

      if(isDefined(_id_83EE2EFFB4CB1B81))
        _id_800676BBD5453FC0._id_83EE2EFFB4CB1B81 = _id_83EE2EFFB4CB1B81;

      if(isDefined(_id_620CF63F086981E0))
        _id_800676BBD5453FC0._id_620CF63F086981E0 = _id_620CF63F086981E0;
    }

    level._id_1B897F0A3B2671E3[level._id_1B897F0A3B2671E3.size] = _id_800676BBD5453FC0;
  }
}

_id_8337B218350D8D9B(_id_1DBEA318DE624F2E) {
  foreach(_id_800676BBD5453FC0 in level._id_1B897F0A3B2671E3) {
    if(!isDefined(_id_800676BBD5453FC0._id_3E2A73CF57C32C7C)) {
      continue;
    }
    if(_id_800676BBD5453FC0._id_3E2A73CF57C32C7C == _id_1DBEA318DE624F2E)
      return _id_800676BBD5453FC0;
  }

  return undefined;
}

_id_0FE848B7E773DB20(_id_800676BBD5453FC0, type) {
  level endon("game_ended");

  if(!isDefined(_id_800676BBD5453FC0) || !isDefined(_id_800676BBD5453FC0._id_57F8B4C321038A32)) {
    return;
  }
  _id_800676BBD5453FC0 thread _id_96BBAAC35A60C43C("group_spawning_completed");
  level._id_215CD837F06FA79E._id_1F44055D8DF16E0B++;

  if(_id_800676BBD5453FC0._id_57F8B4C321038A32 == "juggernaut") {
    if(istrue(level._id_5F45D2B2F52FD7D1)) {
      return;
    }
    level._id_5F45D2B2F52FD7D1 = 1;
    _id_20EDD29C5EC08E09(type);
    level thread _id_48F20B0FE71DD6DF::_id_A2B9761A329063EE(_id_800676BBD5453FC0._id_3E2A73CF57C32C7C);
  }

  if(_id_800676BBD5453FC0._id_57F8B4C321038A32 == "truck") {
    level thread _id_A6CAE4648AAFCD7B(_id_800676BBD5453FC0._id_79F102B3ABCC6F8A[0], _id_800676BBD5453FC0);
    level thread _id_ED3FEFEBBF3E58AD(_id_800676BBD5453FC0);
    return;
  }

  if(_id_800676BBD5453FC0._id_57F8B4C321038A32 == "turret") {
    level thread _id_A6CAE4648AAFCD7B(_id_800676BBD5453FC0._id_79F102B3ABCC6F8A[0], _id_800676BBD5453FC0);
    level thread _id_ED3FEFEBBF3E58AD(_id_800676BBD5453FC0);
    return;
  }

  if(_id_800676BBD5453FC0._id_57F8B4C321038A32 == "bomber_small" || _id_800676BBD5453FC0._id_57F8B4C321038A32 == "bomber_medium" || _id_800676BBD5453FC0._id_57F8B4C321038A32 == "bomber_large")
    level thread _id_48F20B0FE71DD6DF::_id_B52DDE30EF712E97(_id_800676BBD5453FC0);

  if(_id_800676BBD5453FC0._id_57F8B4C321038A32 == "riotshield") {
    level thread _id_48F20B0FE71DD6DF::_id_E492A31537903303(_id_800676BBD5453FC0);
    level thread _id_1685E6D8181C932A::_id_2418A46F24F01BD1(_id_800676BBD5453FC0);
    return;
  }

  if(_id_800676BBD5453FC0._id_57F8B4C321038A32 == "mortar") {
    id = _id_DE5BD5987042469C(_id_800676BBD5453FC0._id_2444B7785351D927);
    level thread _id_48F20B0FE71DD6DF::_id_DBFD1C084C4A1365(_id_800676BBD5453FC0);
    level thread _id_1685E6D8181C932A::_id_CC07567B08D95292("mortar_area_hardpoint_" + id);
    level thread _id_ED3FEFEBBF3E58AD(_id_800676BBD5453FC0);
    return;
  }

  if(istrue(_id_800676BBD5453FC0.isheli)) {
    spawn_point = _id_1685E6D8181C932A::_id_2E1F95D1B1F30D30(_id_800676BBD5453FC0);
    heli = scripts\cp\cp_spawning_util::_id_94E3A9862B435632(spawn_point);
    heli thread _id_1685E6D8181C932A::_id_21E835AC16584AEC(_id_800676BBD5453FC0);
    heli.team = "axis";
    heli scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable(heli);
    level thread _id_ED3FEFEBBF3E58AD(_id_800676BBD5453FC0);
    return;
  }

  if(isDefined(_id_800676BBD5453FC0.script_noteworthy))
    _id_1685E6D8181C932A::_id_1C9666BEF6857EF4(_id_800676BBD5453FC0);

  _id_F318D96DABD3B489 = _id_18A73A64992DD07D::run_spawn_module(_id_800676BBD5453FC0._id_3E2A73CF57C32C7C);
  _id_800676BBD5453FC0._id_F318D96DABD3B489 = _id_F318D96DABD3B489;
  level thread _id_ED3FEFEBBF3E58AD(_id_800676BBD5453FC0);
}

_id_20EDD29C5EC08E09(type) {
  level._id_215CD837F06FA79E._id_A28A00A25B2B35C5[level._id_215CD837F06FA79E._id_A28A00A25B2B35C5.size] = type;
}

_id_DE93EF97771CDC36(type) {
  found = scripts\engine\utility::array_find(level._id_215CD837F06FA79E._id_A28A00A25B2B35C5, type);
  return isDefined(found);
}

_id_7E99CEA9E4C0B5E2() {
  guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  _id_545A954648CC70D5 = _id_5CB623572B271C34::_id_87AC668A043AF5DD();
  maxagents = getmaxagents();
  _id_750C94BA41F40A47 = 8;
  _id_915163619025C96D = maxagents - _id_545A954648CC70D5 - _id_750C94BA41F40A47;

  if(guys.size >= _id_915163619025C96D)
    return 1;

  return 0;
}

_id_96BBAAC35A60C43C(_id_FF8E35622C1CD1C3) {
  level endon("game_ended");
  self endon(_id_FF8E35622C1CD1C3);

  for(guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis"); guys.size == 0; guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis"))
    wait 1;

  while(guys.size > 0) {
    wait 1;
    guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  }

  self notify(_id_FF8E35622C1CD1C3);
}

_id_ED3FEFEBBF3E58AD(_id_800676BBD5453FC0) {
  level endon("game_ended");
  wait 1;
  groupspawned = _id_800676BBD5453FC0._id_F318D96DABD3B489;
  _id_BB125E359CE306AF = undefined;

  while(!isDefined(_id_BB125E359CE306AF)) {
    if(isDefined(groupspawned) && isDefined(groupspawned.module_vehicles) && groupspawned.module_vehicles.size > 0) {
      _id_BB125E359CE306AF = groupspawned.module_vehicles[0];
      break;
    }

    if(isDefined(groupspawned) && isDefined(groupspawned.ai_spawned) && groupspawned.ai_spawned.size > 0) {
      spawnpoint = groupspawned.ai_spawned[0].spawnpoint;

      if(isDefined(spawnpoint) && isDefined(spawnpoint.last_spawned_vehicle)) {
        _id_BB125E359CE306AF = spawnpoint.last_spawned_vehicle;
        break;
      }
    }

    if(isDefined(groupspawned) && isDefined(groupspawned.spawn_points) && groupspawned.spawn_points.size > 0) {
      spawnpoint = groupspawned.spawn_points[0];

      if(isDefined(spawnpoint) && isDefined(spawnpoint.last_spawned_vehicle)) {
        _id_BB125E359CE306AF = spawnpoint.last_spawned_vehicle;
        break;
      }
    }

    if(isDefined(groupspawned) && isDefined(groupspawned.ai_spawned) && groupspawned.ai_spawned.size > 0) {
      foreach(_id_0CE3DD3C6D3B576F in groupspawned.ai_spawned) {
        if(isDefined(_id_0CE3DD3C6D3B576F.ridingvehicle)) {
          _id_BB125E359CE306AF = _id_0CE3DD3C6D3B576F.ridingvehicle;
          break;
        }
      }
    }

    wait 1;
  }

  wait 10;

  if(!isDefined(_id_BB125E359CE306AF) || !isent(_id_BB125E359CE306AF) || !isalive(_id_BB125E359CE306AF)) {
    return;
  }
  _id_6A4BCDA8FAF04AC1 = _id_BB125E359CE306AF.riders;
  objindex = scripts\cp\cp_objectives::requestworldid("defender_attackGroup");
  objective_state(objindex, "current");
  objective_onentity(objindex, _id_BB125E359CE306AF);
  objective_icon(objindex, "hud_icon_head_marked");
  objective_setminimapiconsize(objindex, "icon_small");
  objective_setshowdistance(objindex, 1);
  objective_setplayintro(objindex, 0);
  objective_sethot(objindex, 0);
  objective_setownerteam(objindex, "axis");
  objective_setbackground(objindex, 1);

  if(!isDefined(level._id_E27A333459EF4DBE))
    level._id_E27A333459EF4DBE = [];

  level._id_E27A333459EF4DBE[level._id_E27A333459EF4DBE.size] = objindex;
  _id_B751A35197EAAE0F = undefined;

  if(isDefined(_id_BB125E359CE306AF.ent_flag)) {
    _id_C34D59CA25C2F1AF = spawnStruct();
    _id_BB125E359CE306AF _id_7C81FA28694241FF(_id_C34D59CA25C2F1AF);

    if(isDefined(_id_BB125E359CE306AF) && isent(_id_BB125E359CE306AF) && !istrue(_id_C34D59CA25C2F1AF._id_F45C5A9512ECB9A2)) {
      foreach(rider in _id_6A4BCDA8FAF04AC1)
      rider notify("vehicle_unloaded_me");

      _id_B751A35197EAAE0F = scripts\engine\utility::spawn_tag_origin(_id_BB125E359CE306AF.origin, (0, 0, 0));
      _id_B751A35197EAAE0F show();
      objective_onentity(objindex, _id_B751A35197EAAE0F);
      wait 5;
    }
  } else
    wait 5;

  objective_delete(objindex);
  scripts\cp\cp_objectives::freeworldidbyobjid(objindex);
  level._id_E27A333459EF4DBE = scripts\engine\utility::array_remove(level._id_E27A333459EF4DBE, objindex);

  if(isDefined(_id_B751A35197EAAE0F)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 15; _id_AC0E594AC96AA3A8++) {
      _id_7EFDA5D1CF3F4B5B = undefined;
      _id_A41C4D7191AE4579 = 0;

      foreach(rider in _id_6A4BCDA8FAF04AC1) {
        if(isalive(rider) && !isDefined(rider.ridingvehicle)) {
          if(!isDefined(_id_7EFDA5D1CF3F4B5B))
            _id_7EFDA5D1CF3F4B5B = rider.origin;
          else
            _id_7EFDA5D1CF3F4B5B = _id_7EFDA5D1CF3F4B5B + rider.origin;

          _id_A41C4D7191AE4579++;
        }
      }

      if(_id_A41C4D7191AE4579 > 0)
        _id_7EFDA5D1CF3F4B5B = _id_7EFDA5D1CF3F4B5B / _id_A41C4D7191AE4579;

      if(isDefined(_id_7EFDA5D1CF3F4B5B)) {
        _id_B751A35197EAAE0F.origin = _id_7EFDA5D1CF3F4B5B;
        wait 2.5;
        continue;
      }

      break;
    }

    _id_B751A35197EAAE0F delete();
  }
}

_id_7C81FA28694241FF(_id_C34D59CA25C2F1AF) {
  self endon("stop_follow_path");
  self endon("stop_waiting_for_unload");
  thread _id_1581AB5CA026D5E8(_id_C34D59CA25C2F1AF);
  scripts\engine\utility::ent_flag_wait("unloaded");
}

_id_1581AB5CA026D5E8(_id_C34D59CA25C2F1AF) {
  self waittill("death");
  self notify("stop_waiting_for_unload");
  _id_C34D59CA25C2F1AF._id_F45C5A9512ECB9A2 = 1;
}

_id_682FAB4ABE2FB868(_id_3DEF217D9BD38E42) {
  level endon("game_ended");
  level endon("defender_wave_fail");
  level endon("defender_wave_win");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("defender", "choose_ordering_array"))
    _id_DB06BA5FB0C46867 = _id_3DEF217D9BD38E42[[scripts\cp_mp\utility\script_utility::getsharedfunc("defender", "choose_ordering_array")]](level._id_62F5F42C7C300055);
  else
    _id_DB06BA5FB0C46867 = level._id_215CD837F06FA79E._id_DEF74253F2C565A1[level._id_62F5F42C7C300055];

  if(!isDefined(_id_3DEF217D9BD38E42._id_AEE6E67227E0C8C6))
    _id_3DEF217D9BD38E42._id_AEE6E67227E0C8C6 = 0;

  if(_id_3DEF217D9BD38E42._id_AEE6E67227E0C8C6 > _id_DB06BA5FB0C46867.size) {
    return;
  }
  while(_id_3DEF217D9BD38E42._id_AEE6E67227E0C8C6 < _id_DB06BA5FB0C46867.size) {
    type = undefined;
    delay = 0.1;

    for(_id_AC0E594AC96AA3A8 = _id_3DEF217D9BD38E42._id_AEE6E67227E0C8C6; _id_AC0E594AC96AA3A8 < _id_DB06BA5FB0C46867.size; _id_AC0E594AC96AA3A8++) {
      input = _id_DB06BA5FB0C46867[_id_AC0E594AC96AA3A8];

      if(isnumber(input))
        delay = input;

      if(isstring(input)) {
        if(isDefined(type)) {
          break;
        }

        type = input;
      }

      _id_3DEF217D9BD38E42._id_AEE6E67227E0C8C6++;
    }

    if(_id_DE93EF97771CDC36(type))
      delay = 1;

    while(_id_7E99CEA9E4C0B5E2())
      wait 1;

    _id_5BC33F257485A56C = level _id_A6BDFD44D60A76B8(_id_3DEF217D9BD38E42, type);
    _id_087C58B8F5629F16 = gettime();
    _id_9E2C70D6D7BBC370 = _id_087C58B8F5629F16 + min(delay, 5) * 1000;
    _id_5BC33F257485A56C scripts\engine\utility::waittill_any_timeout_1(delay, "group_spawning_completed");

    if(gettime() < _id_9E2C70D6D7BBC370) {
      _id_2EDA814AC4A5CD0B = (_id_9E2C70D6D7BBC370 - gettime()) / 1000;
      wait(_id_2EDA814AC4A5CD0B);
    }

    wait(randomfloat(2));
  }

  level._id_215CD837F06FA79E._id_F50AB1ED6CCB5D0E++;
  level notify("defender_wave_hardpoint_cleared");
}

_id_5D54009437A8EF42(_id_8146086EF44D4B08) {
  wave_num = level._id_62F5F42C7C300055;

  if(isDefined(_id_8146086EF44D4B08))
    wave_num = _id_8146086EF44D4B08;

  _id_DB06BA5FB0C46867 = level._id_215CD837F06FA79E._id_DEF74253F2C565A1[wave_num];
  _id_02C49C5AFF86FE65 = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_DB06BA5FB0C46867.size; _id_AC0E594AC96AA3A8++) {
    input = _id_DB06BA5FB0C46867[_id_AC0E594AC96AA3A8];

    if(isnumber(input)) {
      delay = input;
      _id_02C49C5AFF86FE65 = _id_02C49C5AFF86FE65 + delay;
    }
  }

  if(_id_02C49C5AFF86FE65 > 0)
    return _id_02C49C5AFF86FE65;
  else
    return undefined;
}

_id_A6BDFD44D60A76B8(_id_3DEF217D9BD38E42, type) {
  _id_1920003C0F69E874 = [];

  foreach(_id_40A020DF02992995 in _id_3DEF217D9BD38E42._id_D376D216074B16A9) {
    if(_id_40A020DF02992995._id_57F8B4C321038A32 == type)
      _id_1920003C0F69E874[_id_1920003C0F69E874.size] = _id_40A020DF02992995;
  }

  _id_54C666FEF00BA529 = scripts\engine\utility::random(_id_1920003C0F69E874);
  _id_0609A4782A20A699 = _id_54C666FEF00BA529._id_0609A4782A20A699;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("defender", "attackgroup_handle_spawns"))
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("defender", "attackgroup_handle_spawns")]](_id_54C666FEF00BA529, type);
  else
    level thread _id_0FE848B7E773DB20(_id_54C666FEF00BA529, type);

  return _id_54C666FEF00BA529;
}

watchforstopwaves(group) {
  level endon("game_ended");
  level thread _watchforstopwaves(group);
}

_watchforstopwaves(group) {
  level endon("game_ended");
  level waittill("end_wave_defender_spawners");
  level notify("spawn_module_" + group.moduleid + "_completed");
}

_id_70CB5F79C7F11728() {
  _id_A02118632C7F1621 = scripts\engine\utility::getStructArray("defender_hardpoint", "script_noteworthy");

  if(_id_A02118632C7F1621.size > 0) {
    foreach(_id_3DEF217D9BD38E42 in _id_A02118632C7F1621) {
      if(isDefined(_id_3DEF217D9BD38E42._id_8417E0F03AE0E83A)) {
        if(isDefined(_id_3DEF217D9BD38E42._id_8417E0F03AE0E83A.objindex)) {
          _id_3DEF217D9BD38E42._id_8417E0F03AE0E83A _id_26C89011A1A919FA();
          _id_E9E9BC2CE1E746B7(_id_3DEF217D9BD38E42._id_8417E0F03AE0E83A);
        }

        if(isent(_id_3DEF217D9BD38E42._id_8417E0F03AE0E83A._id_C5D3D8FF129F88BA))
          _id_3DEF217D9BD38E42._id_8417E0F03AE0E83A._id_C5D3D8FF129F88BA delete();

        if(isent(_id_3DEF217D9BD38E42._id_8417E0F03AE0E83A))
          _id_3DEF217D9BD38E42._id_8417E0F03AE0E83A delete();

        _id_3DEF217D9BD38E42._id_8417E0F03AE0E83A = undefined;
      }

      if(istrue(_id_3DEF217D9BD38E42._id_ABEAE1966A23E2E3))
        _id_3DEF217D9BD38E42._id_ABEAE1966A23E2E3 = undefined;

      if(isDefined(_id_3DEF217D9BD38E42._id_AEE6E67227E0C8C6))
        _id_3DEF217D9BD38E42._id_AEE6E67227E0C8C6 = undefined;

      _id_3DEF217D9BD38E42._id_4C9317C1E2AEB7D6 = undefined;
      _id_3DEF217D9BD38E42._id_78EA08F11A7CDB0E = [];
      _id_3DEF217D9BD38E42._id_E49DD7E4AB8DBEE1 = 0;
    }
  }
}

_id_21BC1B4A1175E031() {
  _id_A02118632C7F1621 = scripts\engine\utility::getStructArray("defender_hardpoint", "script_noteworthy");

  if(_id_A02118632C7F1621.size > 0) {
    foreach(_id_3DEF217D9BD38E42 in _id_A02118632C7F1621) {
      if(isDefined(_id_3DEF217D9BD38E42._id_8417E0F03AE0E83A)) {
        if(isDefined(_id_3DEF217D9BD38E42._id_8417E0F03AE0E83A.objindex)) {
          _id_3DEF217D9BD38E42._id_8417E0F03AE0E83A _id_26C89011A1A919FA();
          _id_E9E9BC2CE1E746B7(_id_3DEF217D9BD38E42._id_8417E0F03AE0E83A);
        }

        if(!istrue(_id_3DEF217D9BD38E42._id_8417E0F03AE0E83A.disabled)) {
          _id_3DEF217D9BD38E42._id_8417E0F03AE0E83A.disabled = 1;
          _id_3DEF217D9BD38E42._id_8417E0F03AE0E83A._id_C5D3D8FF129F88BA makeunusable();
        }
      }

      _id_73FC39BBE98EB99F(_id_3DEF217D9BD38E42);
    }
  }

  level._id_89235EF6F8495217 = undefined;
}

_id_A74D0CFDC9AF0414(id) {
  _id_411D554D02AB11D0 = scripts\engine\utility::getStructArray("defender_hardpoint", "script_noteworthy");

  foreach(_id_3DEF217D9BD38E42 in _id_411D554D02AB11D0) {
    _id_B7A1D48C7C691F5F = strtok(_id_3DEF217D9BD38E42.targetname, "_");
    _id_50AB8B87B227AF4F = _id_B7A1D48C7C691F5F[1];

    if(_id_50AB8B87B227AF4F == id)
      return _id_3DEF217D9BD38E42;
  }

  return undefined;
}

_id_DE5BD5987042469C(_id_3DEF217D9BD38E42) {
  _id_50AB8B87B227AF4F = undefined;
  _id_B7A1D48C7C691F5F = strtok(_id_3DEF217D9BD38E42.targetname, "_");
  _id_50AB8B87B227AF4F = _id_B7A1D48C7C691F5F[1];
  return _id_50AB8B87B227AF4F;
}

_id_9472000B5A2CE4FC(origin, maxdist) {
  _id_36851551B5845C6B = undefined;

  if(isDefined(maxdist))
    _id_36851551B5845C6B = maxdist;

  if(isDefined(level._id_FECE02A99189C2DE) && level._id_FECE02A99189C2DE.size > 0)
    _id_8FAB55E4E1D145F1 = scripts\engine\utility::getclosest(origin, level._id_FECE02A99189C2DE, _id_36851551B5845C6B);
  else {
    _id_A02118632C7F1621 = scripts\engine\utility::getStructArray("defender_hardpoint", "script_noteworthy");
    _id_8FAB55E4E1D145F1 = scripts\engine\utility::getclosest(origin, _id_A02118632C7F1621, _id_36851551B5845C6B);
  }

  return _id_8FAB55E4E1D145F1;
}

_id_936911BE45BEB356() {
  _id_69F6AB6FECF9622E = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_FECE02A99189C2DE.size; _id_AC0E594AC96AA3A8++) {
    if(istrue(level._id_FECE02A99189C2DE[_id_AC0E594AC96AA3A8]._id_ABEAE1966A23E2E3))
      _id_69F6AB6FECF9622E++;
  }

  return _id_69F6AB6FECF9622E;
}

_id_A6CAE4648AAFCD7B(_id_92DEFECADE96A443, _id_800676BBD5453FC0) {
  level endon("game_ended");

  if(!isDefined(level._id_6E5FF6CAE14C4081))
    level._id_6E5FF6CAE14C4081 = [];

  _id_92DEFECADE96A443.skip_navmesh_check = 1;
  _id_92DEFECADE96A443._id_79FA6BD3C9BF6A0D = 1;
  _id_92DEFECADE96A443 _id_18A73A64992DD07D::define_as_vehicle_spawner();

  if(getdvarint("dvar_CAC897FA9794DDF3", 0) > 0)
    _id_92DEFECADE96A443.spawngroup = _id_1985BEABA5E12B38::_id_826D32F4C189E323(_id_92DEFECADE96A443);

  if(isDefined(_id_92DEFECADE96A443.spawngroup)) {
    if(!isDefined(level.ambientgroups[_id_92DEFECADE96A443.spawngroup])) {
      spawnfunc = _id_18A73A64992DD07D::registerambientgroup;
      [[spawnfunc]](_id_92DEFECADE96A443.spawngroup, 7, 7, 7, 0.1, 0, _id_92DEFECADE96A443.spawngroup, ::watchforstopwaves, undefined, undefined);
      _id_F8E5E3AA5762A8E7 = _id_18A73A64992DD07D::create_module_struct(_id_92DEFECADE96A443.spawngroup);
      _id_18A73A64992DD07D::register_module_ai_spawn_func(_id_92DEFECADE96A443.spawngroup, ::_id_4886FCDE2970A5B5);
    }
  }

  level._id_6E5FF6CAE14C4081 = scripts\engine\utility::array_removeundefined(level._id_6E5FF6CAE14C4081);
  level._id_6E5FF6CAE14C4081 = scripts\engine\utility::array_removedead(level._id_6E5FF6CAE14C4081);
  _id_69611B547D144550 = 0;
  _id_78CE45EE14D56854 = 0;
  _id_F8E59A62114686E3 = 7;

  switch (_id_92DEFECADE96A443.classname_mp) {
    case "script_vehicle_iw9_truck_techo_rebel_armor":
      _id_69611B547D144550 = 1;
      break;
    case "script_vehicle_iw8_decho_rebel_milgreen_physics":
    case "script_vehicle_veh9_jltv_mg_ai":
    case "script_vehicle_iw9_jltv_physics":
      _id_F8E59A62114686E3 = 5;
      _id_78CE45EE14D56854 = 1;
      _id_92DEFECADE96A443.vehicletype = "veh9_jltv_mg_physics_mp";
      break;
  }

  _id_1A977EA95154CBA4 = scripts\engine\utility::getStructArray("ai_for_trucks", "targetname");
  _id_E338D86DC3095BE7 = scripts\engine\utility::get_array_of_closest(_id_92DEFECADE96A443.origin, _id_1A977EA95154CBA4, undefined, _id_F8E59A62114686E3);

  if(!isDefined(_id_92DEFECADE96A443.classname_mp))
    _id_92DEFECADE96A443.classname_mp = "script_vehicle_iw9_truck_techo_rebel_armor";

  _id_92DEFECADE96A443.dontgetonpath = 1;
  _id_92DEFECADE96A443._id_079A88FDCF2BBDD5 = 1;

  if(!isDefined(level.ambientgroups[_id_92DEFECADE96A443.spawngroup].ent_flag)) {
    level.ambientgroups[_id_92DEFECADE96A443.spawngroup] scripts\engine\utility::ent_flag_init("pause_group");
    level.ambientgroups[_id_92DEFECADE96A443.spawngroup] scripts\engine\utility::ent_flag_init("weapons_free");
  }

  truck = level scripts\cp\cp_spawning_util::_id_94E3A9862B435632(_id_92DEFECADE96A443, _id_E338D86DC3095BE7);

  if(!isDefined(truck)) {
    return;
  }
  truck.vehicle_skipdeathmodel = 1;
  truck._id_A8F4BB03B366AA80 = 1;

  if(!isDefined(truck.classname_mp))
    truck.classname_mp = _id_92DEFECADE96A443.classname_mp;

  if(_id_69611B547D144550) {
    truck._id_AAB9695C92B0ED96 = [];
    truck thread _id_28926EABDE819B0D::_id_03DD20FF8B99819A();
  }

  while(!isDefined(truck.riders))
    wait 0.1;

  wait 0.1;

  foreach(rider in truck.riders) {
    if(!istrue(rider.dontkilloff))
      rider.dontkilloff = 1;

    rider._id_29EC6586C72EE216 = truck;
    rider._id_29EC6586C72EE216._id_0F29D6C1B1FA2281 = truck.riders;
    rider thread _id_4886FCDE2970A5B5(undefined, _id_92DEFECADE96A443);
  }

  truck thread _id_682328E4B26F431A(_id_92DEFECADE96A443);
  truck thread _id_1685E6D8181C932A::wait_to_stop_path_vehicle(1, _id_92DEFECADE96A443);
  _id_807A9ED6606103DE = level.ambientgroups[_id_92DEFECADE96A443.spawngroup];

  if(isDefined(_id_807A9ED6606103DE)) {
    truck._id_807A9ED6606103DE = _id_807A9ED6606103DE;
    _id_800676BBD5453FC0._id_F318D96DABD3B489 = _id_807A9ED6606103DE;
    level thread _id_ED3FEFEBBF3E58AD(_id_800676BBD5453FC0);
  }

  truck thread _id_1985BEABA5E12B38::_id_DAC0E77E51D99A3C();
}

_id_682328E4B26F431A(startpoint) {
  self endon("death");
  self _meth_D2E41C7603BA7697("p2p");
  self _meth_77320E794D35465A("p2p", "goalThreshold", 128);
  self _meth_77320E794D35465A("p2p", "throttleSpeedThreshold", 1);
  self _meth_77320E794D35465A("p2p", "throttleSpeedFarAbove", 1);
  self _meth_77320E794D35465A("p2p", "throttleSpeedClose", 0.5);
  self _meth_77320E794D35465A("p2p", "steeringMultiplier", 2.5);
  self _meth_77320E794D35465A("p2p", "stuckTime", 4);
  wait 1;

  if(!isDefined(self.angles)) {
    if(isDefined(startpoint.angles))
      self.angles = startpoint.angles;
    else
      self.angles = (0, 0, 0);
  }

  _id_0E80538EF14D00E1::create_simple_path(startpoint, self.angles);

  if(isDefined(self.pathing_arrays)) {
    _id_3059FD8E75830B8C = [];

    foreach(pathing_array in self.pathing_arrays) {
      pathing_array = pathing_array _id_E35B244386F26785();
      _id_3059FD8E75830B8C[_id_3059FD8E75830B8C.size] = pathing_array;
    }

    self.pathing_arrays = _id_3059FD8E75830B8C;
  } else if(isDefined(self.pathing_array))
    self.pathing_array = self.pathing_array _id_E35B244386F26785();

  speed = 500;
  thread _id_089F319E55042FFF();

  if(isDefined(self.pathing_arrays) && self.pathing_arrays.size > 0) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.pathing_arrays.size; _id_AC0E594AC96AA3A8++) {
      if(!isDefined(self.pathing_arrays) || self.pathing_arrays.size == 0) {
        return;
      }
      if(_id_AC0E594AC96AA3A8 == self.pathing_arrays.size - 1)
        self.on_last_pathing_array = 1;

      _id_0F3B4A4783EDE654::_id_9804C82501DE981B(self.pathing_arrays[_id_AC0E594AC96AA3A8], speed);
    }
  } else if(isDefined(self.pathing_array) && self.pathing_array.size > 0) {
    self.on_last_pathing_array = 1;
    _id_0F3B4A4783EDE654::_id_9804C82501DE981B(self.pathing_array, speed);
  }

  thread _id_4BE7EEE7A5972752();
}

_id_089F319E55042FFF() {
  self endon("death");
  wait 0.5;
  self._id_B7D9B54851A59550 = 0;
}

_id_E35B244386F26785() {
  _id_BFC65A378A6D8EFE = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(self[_id_AC0E594AC96AA3A8].origin))
      _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size] = self[_id_AC0E594AC96AA3A8].origin;
  }

  return _id_BFC65A378A6D8EFE;
}

_id_4BE7EEE7A5972752() {
  if(istrue(self._id_72237A0D16316759)) {
    return;
  }
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  self._id_72237A0D16316759 = 1;
  self notify("path_updated");
  self _meth_77320E794D35465A("p2p", "brakeAtGoal", 1);
  self _meth_77320E794D35465A("p2p", "goalPoint", self.origin);
  self stoppath();
  self vehicle_setspeedimmediate(0, 1, 1);
  self vehicle_cleardrivingstate();
  waitframe();

  if(getdvarint("dvar_957B41C68F110CE9", 0) != 0) {
    return;
  }
  self.nav_obstacle = createnavobstaclebybounds(self.origin, (150, 64, 64), self.angles, "axis");
  scripts\common\vehicle_code::_vehicle_unload("default");

  if(scripts\common\vehicle_aianim::riders_unloadable("default"))
    self waittill("unloaded");

  self vehicle_turnengineoff();
  _id_24E4405CF93F20ED::_id_1686ECAABFDC542D();
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(self, "neutral");
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable(self);

  if(getdvarint("dvar_C5854F02E4951EC8", 1) > 0)
    level thread scripts\engine\utility::delaythread(5, scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeusable, self);

  if(isDefined(level.vehicle._id_9442D439C225C3FE)) {
    if([[level.vehicle._id_9442D439C225C3FE]](self))
      return 1;
  }
}

_id_F3A2B97E5C848BF3(_id_ACDD88BC480898A2) {
  if(!istrue(level.announcer_vo_playing) && !istrue(level.isteamvoplaying))
    thread scripts\cp\cp_dialogue::play_vo_to_all("dx_mpa_ustl_" + _id_ACDD88BC480898A2);
}

_id_1BE4F70E2CF74453(sfx) {
  if(soundexists(sfx)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++)
      level.players[_id_AC0E594AC96AA3A8] playlocalsound(sfx);
  }
}

_id_A4AC008F03F60BDA() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  wait 2;
  _id_40ADF3976BB3C32A = "suv_1996_spawn_defender";

  if(!isDefined(level._id_907D3564338C8280))
    level._id_907D3564338C8280 = [];

  _id_532388C61E12B9DF = scripts\engine\utility::getStructArray(_id_40ADF3976BB3C32A, "script_noteworthy");
  _id_0802A2DF280FDF1A = scripts\engine\utility::random(_id_532388C61E12B9DF);
  _id_532388C61E12B9DF = scripts\engine\utility::array_remove(_id_532388C61E12B9DF, _id_0802A2DF280FDF1A);
  _id_0802A1DF280FDCE7 = scripts\engine\utility::random(_id_532388C61E12B9DF);
  _id_532388C61E12B9DF = scripts\engine\utility::array_remove(_id_532388C61E12B9DF, _id_0802A1DF280FDCE7);
  _id_0802A0DF280FDAB4 = scripts\engine\utility::random(_id_532388C61E12B9DF);
  _id_532388C61E12B9DF = scripts\engine\utility::array_remove(_id_532388C61E12B9DF, _id_0802A0DF280FDAB4);
  _id_08029FDF280FD881 = scripts\engine\utility::random(_id_532388C61E12B9DF);
  _id_BFE291B401A9BF2A = [_id_0802A2DF280FDF1A, _id_0802A1DF280FDCE7, _id_0802A0DF280FDAB4, _id_08029FDF280FD881];
  _id_228478D4175CB3B9::_id_5C3E799013E72B1A(_id_BFE291B401A9BF2A, 1);

  if(!isDefined(level.tacrovers))
    level.tacrovers = [];

  if(!isDefined(level._id_8101FC8C5DCF3CE3))
    level._id_8101FC8C5DCF3CE3 = [];

  if(!isDefined(level._id_66A1156521EE6DEA))
    level._id_66A1156521EE6DEA = [];

  _id_B00B7FA33C4EF261 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("veh9_jltv_mg");
  _id_B00B7FA33C4EF261.health = 3000;
  _id_0667BB7475AE6FA8 = scripts\cp_mp\vehicles\vehicle_damage::_id_2265B277A0DAD0F1("veh9_jltv_mg");
  _id_44310868A7F8E052 = [];
  _id_44310868A7F8E052[_id_44310868A7F8E052.size] = _id_0667BB7475AE6FA8["tag_wheel_center_front_right"];
  _id_44310868A7F8E052[_id_44310868A7F8E052.size] = _id_0667BB7475AE6FA8["tag_wheel_center_back_right"];
  _id_44310868A7F8E052[_id_44310868A7F8E052.size] = _id_0667BB7475AE6FA8["tag_wheel_center_back_left"];
  _id_44310868A7F8E052[_id_44310868A7F8E052.size] = _id_0667BB7475AE6FA8["tag_wheel_center_front_left"];

  foreach(_id_9A94DB657B4525D0 in _id_44310868A7F8E052) {
    _id_9A94DB657B4525D0._id_84872288B2E0CE95 = 200;
    _id_9A94DB657B4525D0._id_92894EF28E2B8800 = 250;
    _id_9A94DB657B4525D0._id_A776F097EB36E500 = 220;
  }

  _id_1091D0F7F04DA198 = scripts\engine\utility::getStructArray("jltv_spawn_defender", "script_noteworthy");

  foreach(_id_60F7CB484EC61F6C in _id_1091D0F7F04DA198) {
    _id_17160569DAB45FD6 = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_jltv_mg", _id_60F7CB484EC61F6C);
    level._id_66A1156521EE6DEA[level._id_66A1156521EE6DEA.size] = _id_17160569DAB45FD6;
  }

  wait 5;

  foreach(_id_BE66F9030B258BED in level._id_907D3564338C8280)
  _id_BE66F9030B258BED._id_A8F4BB03B366AA80 = 1;
}

_id_F0DB4DDA6F417EA1() {
  scripts\engine\utility::flag_wait("level_ready_for_script");
  _id_8AFA5FAB32557CEE = getdvarint("dvar_50ACFFBF7373AD3E", 0);
  _id_085AE62C3C2C7470 = scripts\engine\utility::getStructArray("starting_equipment", "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_085AE62C3C2C7470.size; _id_AC0E594AC96AA3A8++) {
    _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdropinfo(_id_085AE62C3C2C7470[_id_AC0E594AC96AA3A8].origin, _id_085AE62C3C2C7470[_id_AC0E594AC96AA3A8].angles);

    if(_id_8AFA5FAB32557CEE) {
      thread _id_775561A2418350F5(_id_085AE62C3C2C7470[_id_AC0E594AC96AA3A8].script_noteworthy, _id_CB4FAD49263E20C4, 4, undefined, undefined, 0);
      continue;
    }

    _id_66122A002AFF5D57::spawnpickup(_id_085AE62C3C2C7470[_id_AC0E594AC96AA3A8].script_noteworthy, _id_CB4FAD49263E20C4, 4, undefined, undefined, 0);
  }
}

_id_775561A2418350F5(_id_C0DD242FFCB18BD2, _id_CB4FAD49263E20C4, count, _id_8D9AE21C4B7DA354, weaponobj, _id_1AD2DB70C8D01F51, countlefthand, _id_E97D731BEDD44C63) {
  level endon("game_ended");

  while(!level.players.size)
    waitframe();

  _id_3EE87794B21506F3 = _id_CB4FAD49263E20C4.origin;
  _id_334EBF3D95E894AD = _id_CB4FAD49263E20C4.angles;

  for(;;) {
    _id_CB4FAD49263E20C4.origin = _id_3EE87794B21506F3;
    _id_CB4FAD49263E20C4.angles = _id_334EBF3D95E894AD;
    item = _id_66122A002AFF5D57::spawnpickup(_id_C0DD242FFCB18BD2, _id_CB4FAD49263E20C4, 4, undefined, undefined, 0);
    scripts\engine\utility::waittill_any_ents_array(level.players, "self_pickedupitem_" + _id_C0DD242FFCB18BD2);
  }
}

_id_9655BF427A5ABDB8(sweapon, _id_E6C13F566F945346) {
  if(!isDefined(_id_E6C13F566F945346))
    objweapon = makeweaponfromstring(sweapon);
  else
    objweapon = _id_E6C13F566F945346;

  _id_A2D8571E188FEF37 = 1;
  _id_0DA8ACF8E422B70F = -1;
  end = self.origin + anglestoleft(self.angles) * 5;
  trace = scripts\engine\trace::ray_trace_passed(self.origin, end);

  if(trace)
    _id_0DA8ACF8E422B70F = 1;

  _id_B8F5AC23CE0DFDE3 = _id_66122A002AFF5D57::createspawnweaponatpos(self.origin, self.angles + (0, 90 * _id_0DA8ACF8E422B70F, -90), objweapon, _id_A2D8571E188FEF37);

  if(isDefined(_id_B8F5AC23CE0DFDE3)) {
    _id_B8F5AC23CE0DFDE3 setscriptablepartstate(_id_B8F5AC23CE0DFDE3.type, "no_outline");
    _id_B8F5AC23CE0DFDE3 _id_66122A002AFF5D57::_id_86321FC8F45C2A9B(1);
    _id_B8F5AC23CE0DFDE3 _id_66122A002AFF5D57::_id_B10EE40ED82D45C9(1);
    return _id_B8F5AC23CE0DFDE3;
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

_id_8F94303A4CB50F0D() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");

  if(getdvarint("dvar_98B72196AAADC23C", 0) > 0) {
    return;
  }
  wait 10;

  while(!isDefined(level.outofboundstriggers))
    wait 1;

  for(;;) {
    vehicles = vehicle_getarray();

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < vehicles.size; _id_AC0E594AC96AA3A8++) {
      if(!isDefined(vehicles[_id_AC0E594AC96AA3A8]) || !isent(vehicles[_id_AC0E594AC96AA3A8]) || !isalive(vehicles[_id_AC0E594AC96AA3A8])) {
        continue;
      }
      if(istrue(vehicles[_id_AC0E594AC96AA3A8]._id_7E7897FE05B6D0B3)) {
        return;
      }
      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < level.outofboundstriggers.size; _id_AC0E5C4AC96AAA41++) {
        if(vehicles[_id_AC0E594AC96AA3A8] istouching(level.outofboundstriggers[_id_AC0E5C4AC96AAA41])) {
          if(vehicles[_id_AC0E594AC96AA3A8] _id_3D89E4087031D072()) {
            vehicles[_id_AC0E594AC96AA3A8] dodamage(vehicles[_id_AC0E594AC96AA3A8].health, vehicles[_id_AC0E594AC96AA3A8].origin);
            vehicles[_id_AC0E594AC96AA3A8]._id_F16A36CCA80F85ED = 1;
          }
        }
      }

      wait 0.05;
    }

    wait 5;
  }
}

_id_3D89E4087031D072() {
  if(!isalive(self))
    return 0;

  _id_F4F1BB5A8C944472 = 15000;

  if(isDefined(self.birthtime) && self.birthtime + _id_F4F1BB5A8C944472 > gettime())
    return 0;

  if(isDefined(self.riders) && self.riders.size > 0)
    return 0;

  if(scripts\common\vehicle::ishelicopter())
    return 0;

  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  if(isDefined(occupants) && occupants.size > 0)
    return 0;

  if(istrue(self._id_F16A36CCA80F85ED))
    return 0;

  return 1;
}

_id_B9DFBE35558A2B16() {
  level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8 = spawnStruct();

  if(level.script == "cp_lone") {
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_8FE276C01BFFEA6B = "";
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_8FE277C01BFFEC9E = "";
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_8FE278C01BFFEED1 = "";
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_8FE279C01BFFF104 = "";
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_8FE27AC01BFFF337 = "";
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_8FE27BC01BFFF56A = "";
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_9D5DBA3CE27BD539 = "mx_cp_lone_wave_1";
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_0170D67A12DAF854 = "mx_cp_lone_wave_2";
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_4BF453555EF34147 = "mx_cp_lone_wave_3";
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_AF36B4CCA8A906F2 = "mx_cp_lone_wave_4";
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_C7FD5D271E9953A5 = "mx_cp_lone_wave_5";
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_8B3E75861FD5C530 = "mx_cp_lone_wave_6";
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8.defused = "mx_cp_lone_bombdefused";
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8.planted = "mx_cp_lone_bombplanted";
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_6977D15374CB8BD5 = "mx_cp_lone_multi_bombplanted";
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_DE9E52B68B6EAD41 = "";
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8.infil = "mx_cp_lone_infil";
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8.exfil = "mx_cp_lone_exfil";
  } else {
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_8FE276C01BFFEA6B = "mx_cp_observatory_wave_1";
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_8FE277C01BFFEC9E = "mx_cp_observatory_wave_2";
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_8FE278C01BFFEED1 = "mx_cp_observatory_wave_3";
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_8FE279C01BFFF104 = "mx_cp_observatory_wave_4";
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_8FE27AC01BFFF337 = "mx_cp_observatory_wave_5";
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_8FE27BC01BFFF56A = "mx_cp_observatory_wave_6";
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_9D5DBA3CE27BD539 = "";
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_0170D67A12DAF854 = "";
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_4BF453555EF34147 = "";
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_AF36B4CCA8A906F2 = "";
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_C7FD5D271E9953A5 = "";
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_8B3E75861FD5C530 = "";
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8.defused = "mx_cp_observatory_bombdefused";
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8.planted = "mx_cp_observatory_bombplanted";
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_6977D15374CB8BD5 = "mx_cp_observatory_multi_bombplanted";
    level._id_215CD837F06FA79E._id_F90E9A2E19CBCED8._id_DE9E52B68B6EAD41 = "mx_cp_observatory_wave_victory";
  }
}