/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5307834cd39b435c.gsc
***********************************************/

_id_36F1BD0F5D72054A() {
  if(getdvarint("dvar_25B11256C0DA51A1", 1) == 0) {
    return;
  }
  level._effect["vfx_smk_signal"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal");
  level._effect["vfx_smk_signal_gr"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal_gr");
  level._effect["vfx_smk_signal_dmz"] = loadfx("vfx/iw9/level/mp_dmz_hydro/vfx_smk_signal_dmz");
  level._effect["vfx_smk_signal_dmz_diss"] = loadfx("vfx/iw9/level/mp_dmz_hydro/vfx_smk_signal_dmz_diss");
  _id_832F6C1A7BB8C4FF();
  level thread _id_9792D0E6C82398BF();
  level._id_95DE4B6BB41FBBFA = [];
  level._id_B8457C8044B2EE02 = getdvarint("dvar_BF86D2B0958E8803", 300);
  level._id_9405ABD1DB7CF2CF = getdvarint("dvar_9EB35FD11109D87D", 60);
  level._id_B91D57DF9D8EC00E = getdvarint("dvar_28CC46B930476566", 10);
  level._id_745BEBF82B7D49F8 = getdvarint("dvar_ED723AB06879FDB5", 60);
  level._id_DF3A6E8886416B36 = int(getdvarint("dvar_918D5EA00183221C", 999) * 100);
  level._id_D962891163D17D4A = getdvarint("scr_dmz_dmzsamepoiexfil", 0);
  level._id_C8FF03474C1DE67F = getdvarint("scr_dmz_dmznumofpoiawayexfil", 2);
  level._id_6B712F0345BF6F12 = getdvarint("dvar_8E317CE550E11531", 30);
  level._id_662586EDE589F49C = getdvarint("scr_dmz_exfilremoveonuse", 0);
  level._id_08F7D92F10FC80CE = getdvarint("scr_dmz_exfilunlockonmissioncomplete", 0);
  level._id_9B6B8C7ECB7AC7C0 = getdvarint("scr_dmz_exfilusesharedpool", 0);
  level._id_4644C9DA9A611950 = getdvarint("dvar_4F0A08CC7285B3C7", 0);
  level._id_CDC76BC962358072 = getdvarint("scr_dmz_exfilforceshared", 1);
  level._id_858DBA9DA8DC5419 = getdvarint("scr_dmz_exfilinitialshared", 3);
  level._id_50477DC063210A56 = getdvarint("dvar_F96D14F35ABA8181", 0) == 1;
  level._id_C69D2B1EEB329A5A = getdvarint("dvar_7ACEAF0413D3F442", 1);
  level._id_F3A3F7CF0A42D67C = getdvarint("dvar_71DE0410D6B8A154", 5000);
  level._id_68CDDDBBE057395D = getdvarint("dvar_BA94141588893FF2", 1);
  level._id_09B3294726F6D3A6 = getdvarint("dvar_987DA8AB1C15D96B", 1) == 1;
  level._id_DD83D323306DCBA7 = getdvarint("dvar_761322608DA01456", 0) == 1;
  level._id_540F24BB9ACF4C02 = getdvarint("scr_dmz_exfilusesharedpoolcount", 2);
  level._id_01EFF61A95657CA2 = getdvarint("dvar_04726749F66554EE", 1);
  level._id_628F636DE1F2DDA3 = getdvarint("scr_dmz_exfilusesharedpoolmaxteams", 2);
  level._id_A276CD366472B025 = getdvarint("dvar_4AC155BCB91CC93E", 5);
  level._id_BBF4A84349D0FDEB = getdvarint("dvar_06719472694F0112", 2000);
  level._id_CF4723BFB4CC7643 = getdvarint("dvar_B41C17E4FF85FB3C", 0);
  level._id_9FB5000AE38DCF7F = getdvarint("dvar_87418A428FACD9BB", 1);
  level._id_C64BEB7B042390C8 = getdvarint("dvar_8D43DB8F06FFDA3F", 1);
  level._id_679B51811BC32ADC = getdvarint("dvar_F9F43C362802CA01", 5);
  level._id_E5261A9A2FEAF655 = getdvarint("dvar_277D1A4CBE10E33C", 4);
  level._id_C7825757649C018E = getdvarint("dvar_1D32C1595DE57577", 15);
  level._id_50FF14B675031D14 = getdvarint("dvar_A9EBE44E535CC367", 0);
  level._id_C42D6E4A40F70691 = getdvarint("scr_dmz_exfil_req_missions", 0);

  if(level._id_C42D6E4A40F70691 || level._id_08F7D92F10FC80CE)
    level._id_FAA873310ADD1096 = ::_id_52781BE0B4E8A959;

  level._id_FF04728F8E36403F = getdvarint("scr_dmz_exfil_req_time", 0);
  level._id_53BDD63AC87A9076 = getdvarint("dvar_62CC42AA2ACA04C9", 1);
  level._id_4BE8962610EE659B = getdvarfloat("dvar_82CA0DECE965EFBA", 0);
  level._id_CD6E8342A9C09C26 = getdvarfloat("dvar_3BBB199DFB8A5BC7", 0.9);
  level._id_0BA138AD5136D87D = getdvarint("dvar_5D13B090CA102618", 900) * 1000;
  level._id_6C41580562FD09E2 = gettime();
  level thread _id_119B893A0CA18687();
  level thread _id_1FAC2465EB5DDA23();
  _id_3FF084F114B7F6C9::_id_F3D757808130BAC4(::_id_A857C0CB4FCB1819);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_exfil_site", ::_id_C5F291ACF1B44B69);
  _id_5C65D346AC65390C::_id_7D47BDED29ED7882(level._id_9405ABD1DB7CF2CF, level._id_BBF4A84349D0FDEB, level._id_745BEBF82B7D49F8, level._id_A276CD366472B025, level._id_06FC3398B5A13400, getdvarint("dvar_A3C1D41C94507F92", 279), level._id_C7825757649C018E, level._id_DF3A6E8886416B36);
  _id_43516E81BA78395D();
}

_id_43516E81BA78395D() {
  _id_5C65D346AC65390C::_id_3C673414D075EBFC("airspace_too_crowded", ::_id_40D3FB596096AC55);
  _id_5C65D346AC65390C::_id_3C673414D075EBFC("initial_splash", ::_id_595EEDE45A673B1F);
  _id_5C65D346AC65390C::_id_3C673414D075EBFC("setup_gas_masks", ::_id_AA3139C5FAE701B8);
  _id_5C65D346AC65390C::_id_3C673414D075EBFC("player_exfil_timer", ::_id_496941BF27AF77B1);
  _id_5C65D346AC65390C::_id_3C673414D075EBFC("exfil_players", ::_id_309C0A11484CC0DB);
  _id_5C65D346AC65390C::_id_3C673414D075EBFC("reset_exfil", ::_id_1DCDA56EFB76E334);
  _id_5C65D346AC65390C::_id_3C673414D075EBFC("remove_exfil", ::_id_673F07BB8A61BCF3);
  _id_5C65D346AC65390C::_id_3C673414D075EBFC("music_stop", ::_id_113D0E9D241C8568);
  _id_5C65D346AC65390C::_id_3C673414D075EBFC("music_reset", ::_id_704DC2A5075C58B9);
  _id_5C65D346AC65390C::_id_3C673414D075EBFC("music_start", ::_id_1CE7B362085D943E);
  _id_5C65D346AC65390C::_id_3C673414D075EBFC("music_exfil_end", ::_id_B1219A25435AB949);
  _id_5C65D346AC65390C::_id_3C673414D075EBFC("dialog_start_exfil", ::_id_133DEEBBE58FB347);
  _id_5C65D346AC65390C::_id_3C673414D075EBFC("dialog_handle_touchdown", ::_id_25E48C3D85F4A59C);
  _id_5C65D346AC65390C::_id_3C673414D075EBFC("dialog_final_warning", ::_id_AB7F97A0B46CBEAF);
  _id_5C65D346AC65390C::_id_3C673414D075EBFC("dialog_final_leaving", ::_id_0A0D539B960B93BB);
  _id_5C65D346AC65390C::_id_3C673414D075EBFC("dialog_shortcut", ::_id_E392FD7CAD768E25);
}

_id_119B893A0CA18687() {
  while(!isDefined(level.teamnamelist))
    waitframe();

  foreach(team in level.teamnamelist)
  level.teamdata[team]["exfils"] = [];
}

_id_9792D0E6C82398BF() {
  wait 1;
  level._id_0CC6F9CF228ACCB4 = [];

  foreach(_id_F90358454413407F in level.teamnamelist)
  level._id_0CC6F9CF228ACCB4[_id_F90358454413407F] = 0;
}

_id_832F6C1A7BB8C4FF() {
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_waitfor_exfil", 1, "neutral", "MP_INGAME_ONLY/OBJ_EXFIL_NOTACTIVE_CAPS", "ui_map_icon_extraction", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_active_exfil", 1, "neutral", "MP_INGAME_ONLY/OBJ_Exfil_CAPS", "ui_map_icon_extraction", 0);
}

_id_A4181028915C44FA(node, _id_D5998E8874D77B02) {
  _id_3064FA24DBBD5BBF = spawnStruct();

  if(!isDefined(_id_D5998E8874D77B02))
    _id_D5998E8874D77B02 = getdvarint("dvar_2F6AA396E5E4E4F1", 1) == 1;

  if(isDefined(node._id_B205D90302DA2F07))
    _id_3064FA24DBBD5BBF._id_B205D90302DA2F07 = node._id_B205D90302DA2F07;
  else
    _id_3064FA24DBBD5BBF._id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(node.origin);

  _id_3064FA24DBBD5BBF.angles = node.angles;
  _id_3064FA24DBBD5BBF.origin = scripts\engine\utility::ter_op(_id_D5998E8874D77B02, scripts\engine\utility::drop_to_ground(getclosestpointonnavmesh(node.origin)), node.origin);
  _id_3064FA24DBBD5BBF.modelname = "dmz_exfil_site_xmodel";
  _id_3064FA24DBBD5BBF._id_D81E4008D63C5E96 = [];

  if(isDefined(node.target)) {
    _id_23D42B1195DDA679 = scripts\engine\utility::getStruct(node.target, "targetname");

    if(isDefined(_id_23D42B1195DDA679)) {
      _id_3064FA24DBBD5BBF._id_B44C269EA13F56AE = _id_23D42B1195DDA679.origin;
      _id_3064FA24DBBD5BBF._id_A55FA332B1255E04 = _id_23D42B1195DDA679.angles;
    }
  }

  if(isDefined(node.script_label)) {
    if(node.script_label == "land")
      _id_3064FA24DBBD5BBF.land = 1;
  }

  return _id_3064FA24DBBD5BBF;
}

_id_1FAC2465EB5DDA23() {
  if(getdvarint("dvar_61C64C6E38290AA1", 0) == 1) {
    return;
  }
  waitframe();
  level endon("game_ended");
  level._id_C26F0D22BC1FA7EF = [];
  level._id_B95A019FC748357A = [];
  level._id_0CCBB0E8B2A740B8 = [];
  _id_6B6476844B6ADA68 = [];
  _id_56EA112138F55047 = getdvarint("dvar_B4F00BD105203EC9", 1);
  _id_5A3867693588454B = getdvarint("dvar_41D95A4CAF9B2E7D", 0) == 1;
  _id_0FA41506CCE024E8 = "dmz_squadExfilPoint";

  if(level._id_68CDDDBBE057395D == 1)
    _id_0FA41506CCE024E8 = "dmz_communalExfilPoint" + level._id_53BDD63AC87A9076;

  foreach(node in scripts\engine\utility::getStructArray(_id_0FA41506CCE024E8, "script_noteworthy")) {
    if(_id_5A3867693588454B && !isDefined(node._id_B205D90302DA2F07)) {
      continue;
    }
    if(isDefined(node._id_B205D90302DA2F07) && scripts\engine\utility::array_contains(level._id_AB20B3A256911579, node._id_B205D90302DA2F07)) {
      continue;
    }
    groundpos = getclosestpointonnavmesh(node.origin);

    if(isDefined(level._id_3796DC1D470DFAB8))
      _id_3064FA24DBBD5BBF = [[level._id_3796DC1D470DFAB8]](node);
    else
      _id_3064FA24DBBD5BBF = _id_A4181028915C44FA(node);

    _id_6B6476844B6ADA68[_id_6B6476844B6ADA68.size] = _id_3064FA24DBBD5BBF;
  }

  foreach(node in scripts\engine\utility::getStructArray("dmz_communalExfilPointFinal", "script_noteworthy")) {
    if(_id_5A3867693588454B && !isDefined(node._id_B205D90302DA2F07)) {
      continue;
    }
    if(isDefined(node._id_B205D90302DA2F07) && scripts\engine\utility::array_contains(level._id_AB20B3A256911579, node._id_B205D90302DA2F07)) {
      continue;
    }
    groundpos = getclosestpointonnavmesh(node.origin);
    _id_3064FA24DBBD5BBF = _id_A4181028915C44FA(node);
    level._id_B95A019FC748357A[level._id_B95A019FC748357A.size] = _id_3064FA24DBBD5BBF;
  }

  _id_442BB8E42C0D40B7(_id_6B6476844B6ADA68);

  if(level._id_9B6B8C7ECB7AC7C0 == 1)
    _id_1DB005B6EB39A56D();

  if(level._id_C69D2B1EEB329A5A == 1)
    level thread _id_B9730BFE1E8B9F81();

  level thread _id_9A7567A2D46B857A();
}

_id_442BB8E42C0D40B7(_id_3064FA24DBBD5BBF, _id_D8AA357ADF7CB05D) {
  _id_F951F4BB16E92179 = 0;
  level._id_5FAD09539823F92E = [];

  foreach(exfil in _id_3064FA24DBBD5BBF) {
    _id_F951F4BB16E92179++;
    exfil._id_302F61F95F10F7F3 = _id_F951F4BB16E92179;
    level._id_C26F0D22BC1FA7EF[level._id_C26F0D22BC1FA7EF.size] = exfil;

    if(istrue(_id_D8AA357ADF7CB05D)) {
      _id_BBE41F41D0F13612(exfil);
      exfil.ent setscriptablepartstate("dmz_exfil_icon", "communal_icon");
    }

    if(isDefined(exfil._id_B205D90302DA2F07)) {
      if(!isDefined(level._id_5FAD09539823F92E[exfil._id_B205D90302DA2F07]))
        level._id_5FAD09539823F92E[exfil._id_B205D90302DA2F07] = [];

      level._id_5FAD09539823F92E[exfil._id_B205D90302DA2F07][level._id_5FAD09539823F92E[exfil._id_B205D90302DA2F07].size] = exfil;
    }
  }
}

_id_1DB005B6EB39A56D() {
  level._id_58F477E9E7E8F739 = [];

  if(getdvarint("dvar_A4617FB891CA21CB", 0) == 1) {
    foreach(exfil in level._id_C26F0D22BC1FA7EF)
    level._id_58F477E9E7E8F739[level._id_58F477E9E7E8F739.size] = exfil;
  } else {
    foreach(_id_B205D90302DA2F07, _id_36847C9A092F0703 in level._id_5FAD09539823F92E) {
      _id_77B74BCC1CF886A8 = scripts\engine\utility::array_randomize(_id_36847C9A092F0703);

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_540F24BB9ACF4C02; _id_AC0E594AC96AA3A8++)
        level._id_58F477E9E7E8F739[level._id_58F477E9E7E8F739.size] = _id_77B74BCC1CF886A8[_id_AC0E594AC96AA3A8];
    }
  }
}

_id_2431347A478DC694(_id_2B6DEB0F4170E1A4) {
  level._id_F9E4EFEA742E3709 = [];
  _id_F951F4BB16E92179 = 0;
  level._id_5FAD09539823F92E = [];

  foreach(exfil in _id_2B6DEB0F4170E1A4) {
    _id_F951F4BB16E92179++;
    exfil._id_302F61F95F10F7F3 = _id_F951F4BB16E92179;
    exfil._id_067F7D5BA67F4AD6 = [];
    exfil thread _id_4BBC9B547EEB547F();
    level._id_C26F0D22BC1FA7EF[level._id_C26F0D22BC1FA7EF.size] = exfil;
    _id_BBE41F41D0F13612(exfil);
    exfil.ent setscriptablepartstate("dmz_exfil_icon", "communal_icon");
  }
}

_id_4BBC9B547EEB547F() {
  level endon("game_ended");

  for(;;) {
    players = scripts\common\utility::playersincylinder(self.origin, 500);

    if(players.size > 0) {
      foreach(player in players) {
        if(!isDefined(self._id_067F7D5BA67F4AD6[player.team]) || self._id_067F7D5BA67F4AD6[player.team] == 0) {
          self._id_067F7D5BA67F4AD6[player.team] = 1;
          _id_9251FF271B0450DD(player.team);
        }
      }
    }

    wait 1;
  }
}

_id_9251FF271B0450DD(team) {
  _id_940A3890AC273220 = level._id_6B712F0345BF6F12;

  while(_id_940A3890AC273220 > 0) {
    players = scripts\common\utility::playersincylinder(self.origin, 500);

    foreach(player in players) {
      if(!isDefined(player._id_A09B2CB47A28054A) && player.team == team) {
        self._id_0902A7FFCFF8AA65[self._id_0902A7FFCFF8AA65.size] = player;
        player thread _id_496941BF27AF77B1(self.origin, _id_940A3890AC273220, 500);
      }
    }

    _id_940A3890AC273220--;
    wait 1;
  }

  players = scripts\common\utility::playersincylinder(self.origin, 500);
  _id_6D5ED003AF1F9612 = [];

  foreach(player in players) {
    if(player.team == team)
      _id_6D5ED003AF1F9612[_id_6D5ED003AF1F9612.size] = player;
  }

  _id_309C0A11484CC0DB(_id_6D5ED003AF1F9612);
  self._id_067F7D5BA67F4AD6[team] = 0;
}

_id_496941BF27AF77B1(pos, time, dist) {
  self notify("dmz_exfil_timer");
  self endon("disconnect");
  self endon("dmz_exfil_timer");
  timer = time;

  if(!isDefined(timer)) {
    return;
  }
  while(timer > 0) {
    if(timer < 11)
      self setentitysoundcontext("lobby_fade", "on");

    if(isDefined(dist) && (!isDefined(self) || distance(pos, self.origin) > dist)) {
      break;
    }

    if(timer < 80)
      self setclientomnvar("ui_match_start_countdown", timer);

    timer--;
    wait 1;
  }

  _id_5C65D346AC65390C::_id_423F49E2512A5F53();
  self setclientomnvar("ui_match_start_countdown", 0);
  self setentitysoundcontext("lobby_fade", "", 2);
}

_id_A9F268ABD153B713() {
  self notify("dmz_exfil_timer");
  _id_5C65D346AC65390C::_id_423F49E2512A5F53();
  self setclientomnvar("ui_match_start_countdown", 0);
}

_id_B9730BFE1E8B9F81() {
  level waittill("dmz_radiation_started");

  if(!_id_1174ABEDBEFE9ADA::_id_DFA94748AF73C087()) {
    return;
  }
  wait 5;
  level thread _id_48272DE6DC9130F7();
}

_id_48272DE6DC9130F7() {
  for(;;) {
    if(level._id_FE2E551DA0962C3C.size > 0) {
      foreach(exfil in level._id_FE2E551DA0962C3C) {
        if(_id_1174ABEDBEFE9ADA::_id_26879895DB23C779(exfil.origin)) {
          _id_DDA47641682585D9(exfil);
          level._id_FE2E551DA0962C3C = scripts\engine\utility::array_remove(level._id_FE2E551DA0962C3C, exfil);
        }
      }
    } else {
      level thread _id_A3F113DC69814771();
      return;
    }

    wait 1;
  }
}

_id_A3F113DC69814771() {
  if(!isDefined(level._id_C5074BF13FFB95EF)) {
    return;
  }
  _id_755BC4C5615671AF = _id_1174ABEDBEFE9ADA::_id_2A0C5B28DDED3E06();
  _id_C444E48AE40730BA = distance2d(level._id_AA174DF565129C2B.origin, level._id_33A2175A9A4306BC.startorigin);
  _id_1E6C96F9D4B225C4 = distance2d(level._id_C5074BF13FFB95EF.origin, level._id_33A2175A9A4306BC.startorigin);
  timer = (_id_1E6C96F9D4B225C4 - _id_C444E48AE40730BA) / _id_755BC4C5615671AF;
  _id_10817A88AD06996F = level._id_C5074BF13FFB95EF;
  _id_BBE41F41D0F13612(_id_10817A88AD06996F);

  if(isDefined(_id_10817A88AD06996F.ent)) {
    _id_10817A88AD06996F.ent setscriptablepartstate("dmz_exfil_site", "standby");
    _id_10817A88AD06996F.ent setscriptablepartstate("dmz_exfil_icon", "final_exfil_icon");
  }

  thread _id_9FDF14C5AAC8CE53("dmz_exfil_pilot_called_final");
  timer = timer - (level._id_A276CD366472B025 + 5);
  timer = timer - level._id_C7825757649C018E;

  if(level.players.size <= 0) {
    return;
  }
  thread _id_5BC15F36914E63C7(_id_10817A88AD06996F.ent, undefined, undefined, level.players[randomint(level.players.size)], timer, 0, 1);
}

_id_DDA47641682585D9(exfil) {
  if(!isDefined(exfil)) {
    return;
  }
  if(!isDefined(level._id_35A1CDD4A92304A5))
    level._id_35A1CDD4A92304A5 = [];

  _id_29F917AE2719196A = _id_F2811D61401A5E40(exfil);

  if(istrue(exfil._id_B6B245F03C15D48D) && level._id_F3A3F7CF0A42D67C > 0)
    _id_29F917AE2719196A = scripts\mp\utility\player::getplayersinradius(exfil.origin, level._id_F3A3F7CF0A42D67C);

  _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("radiation_delete_personal_exfils", scripts\engine\utility::array_remove_array(_id_29F917AE2719196A, level._id_35A1CDD4A92304A5));
  level._id_35A1CDD4A92304A5 = scripts\engine\utility::array_combine_unique(level._id_35A1CDD4A92304A5, _id_29F917AE2719196A);

  if(isDefined(exfil.ent)) {
    exfil.ent notify("disable");
    exfil.ent.disabled = 1;
    exfil.ent setscriptablepartstate("dmz_exfil_icon", "disabled_icon");
    exfil.ent setscriptablepartstate("dmz_exfil_smoke", "stop");
    exfil.ent setscriptablepartstate("dmz_exfil_site", "standby");
  }

  level._id_C26F0D22BC1FA7EF = scripts\engine\utility::array_remove(level._id_C26F0D22BC1FA7EF, exfil);

  if(isDefined(exfil._id_B205D90302DA2F07) && isDefined(level._id_5FAD09539823F92E) && isDefined(level._id_5FAD09539823F92E[exfil._id_B205D90302DA2F07]))
    level._id_5FAD09539823F92E[exfil._id_B205D90302DA2F07] = scripts\engine\utility::array_remove(level._id_5FAD09539823F92E[exfil._id_B205D90302DA2F07], exfil);

  if(isDefined(level._id_58F477E9E7E8F739))
    level._id_58F477E9E7E8F739 = scripts\engine\utility::array_remove(level._id_58F477E9E7E8F739, exfil);
}

_id_F2811D61401A5E40(exfil) {
  if(!isDefined(exfil))
    return [];

  if(istrue(exfil._id_B6B245F03C15D48D))
    return level.players;

  _id_1A379627CF4B5391 = [];

  if(isDefined(exfil._id_D81E4008D63C5E96)) {
    foreach(team in exfil._id_D81E4008D63C5E96)
    _id_1A379627CF4B5391 = scripts\engine\utility::array_combine(_id_1A379627CF4B5391, scripts\mp\utility\teams::getteamdata(team, "players"));
  }

  return _id_1A379627CF4B5391;
}

_id_5086B40CFD533087() {
  _id_8C75C28DA153BEC6 = _id_1174ABEDBEFE9ADA::_id_F3FB60F986F267C5();

  if(!isDefined(_id_8C75C28DA153BEC6)) {
    return;
  }
  nodes = scripts\engine\utility::getStructArray("dmz_communalExfilPoint" + level._id_53BDD63AC87A9076, "script_noteworthy");

  if(nodes.size > 0) {
    _id_2C1975F487BBE252 = getdvarint("dvar_65D6B521AB74DC34", 1);
    _id_5FC0BB331FCC1784 = getdvarint("dvar_DF07EA3EC5250762", 4);
    _id_87D5384A614BA40C = scripts\engine\utility::ter_op(_id_2C1975F487BBE252 >= _id_5FC0BB331FCC1784, _id_2C1975F487BBE252, randomintrange(_id_2C1975F487BBE252, _id_5FC0BB331FCC1784));

    if(_id_87D5384A614BA40C <= 0) {
      return;
    }
    _id_5F48EE4ED384234C = [];

    if(getdvarint("dvar_2317BF1EBB6514F7", 0) == 1)
      _id_5F48EE4ED384234C[_id_5F48EE4ED384234C.size] = sortbydistance(nodes, _id_8C75C28DA153BEC6)[nodes.size - 1];
    else {
      _id_5F48EE4ED384234C[_id_5F48EE4ED384234C.size] = scripts\engine\utility::random(scripts\engine\utility::array_slice(sortbydistance(nodes, _id_8C75C28DA153BEC6), int(max(0, nodes.size - 2))));

      foreach(_id_25F0CCA0E08B71D0 in [45000, 25000, 10000, 3000]) {
        foreach(node in scripts\engine\utility::array_randomize(nodes)) {
          _id_267C3C85C7B5A7C5 = 1;

          foreach(_id_8504857C0C6F38C3 in _id_5F48EE4ED384234C) {
            if(distance(_id_8504857C0C6F38C3.origin, node.origin) < _id_25F0CCA0E08B71D0) {
              _id_267C3C85C7B5A7C5 = 0;
              break;
            }
          }

          if(_id_267C3C85C7B5A7C5) {
            _id_5F48EE4ED384234C[_id_5F48EE4ED384234C.size] = node;

            if(_id_5F48EE4ED384234C.size >= _id_87D5384A614BA40C) {
              break;
            }
          }
        }

        if(_id_5F48EE4ED384234C.size >= _id_87D5384A614BA40C) {
          break;
        }
      }
    }

    _id_1EB20C7E1F001A1E = [];
    _id_6DB47C254E98CC63 = getdvarint("scr_dmz_exfils_useendareas", 1) == 1;

    foreach(node in _id_5F48EE4ED384234C) {
      groundpos = scripts\engine\utility::drop_to_ground(node.origin);
      _id_3064FA24DBBD5BBF = spawnStruct();

      if(isDefined(node._id_B205D90302DA2F07))
        _id_3064FA24DBBD5BBF._id_B205D90302DA2F07 = node._id_B205D90302DA2F07;
      else
        _id_3064FA24DBBD5BBF._id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(node.origin);

      _id_3064FA24DBBD5BBF.angles = node.angles;
      _id_3064FA24DBBD5BBF.origin = groundpos;
      _id_3064FA24DBBD5BBF._id_D81E4008D63C5E96 = [];
      _id_3064FA24DBBD5BBF.modelname = scripts\engine\utility::ter_op(_id_6DB47C254E98CC63, "dmz_exfil_zone_xmodel", "dmz_exfil_site_xmodel");
      _id_1EB20C7E1F001A1E[_id_1EB20C7E1F001A1E.size] = _id_3064FA24DBBD5BBF;
    }

    if(_id_6DB47C254E98CC63)
      _id_2431347A478DC694(_id_1EB20C7E1F001A1E);
    else
      _id_442BB8E42C0D40B7(_id_1EB20C7E1F001A1E, 1);

    level thread _id_4868B0DABBB185F9(_id_1EB20C7E1F001A1E);
  }
}

_id_4868B0DABBB185F9(_id_1EB20C7E1F001A1E) {
  foreach(_id_3064FA24DBBD5BBF in _id_1EB20C7E1F001A1E)
  level thread _id_6613AEB065E36928(_id_3064FA24DBBD5BBF);
}

_id_6613AEB065E36928(loc) {
  if(!istrue(level._id_289DF80E1DED586F)) {
    return;
  }
  _id_8E39DA7681BBCC4B = getdvarint("dvar_0F895A6B12ACEB46", 12);

  if(_id_8E39DA7681BBCC4B <= 0) {
    return;
  }
  _id_89593782B8B4434D = getdvarint("dvar_B7F14FBC972E9210", 6);
  _id_6D3480DE3B55C1AA = getdvarint("dvar_EC0AD58367541FE3", 6);
  _id_51FB808F0AD7B056 = getdvarint("dvar_99E18E59ACA26047", 6);
  _id_EEFD5067DC92A0E3 = getdvarint("dvar_CDDE0B9F53CD9D6A", 6);

  if(isDefined(level._id_4B195D3DD0024B9C))
    team = level._id_4B195D3DD0024B9C;
  else
    team = "team_hundred_ninety_five";

  _id_C5E7FCE963586EC0 = loc;
  priority = "high";
  category = "reinforcements";
  _id_1C9CB43BCF3EB16D = "exfil";
  _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_C5E7FCE963586EC0);
  _id_19B18E5335B6E88A = 256;
  _id_2898710BEC2562DC = 3500;
  _id_8B2F5B7CAA9B211C = getdvarint("dvar_63D7F015B040D9C6", 5000);
  _id_11B3529E57CFED0E = _id_48814951E916AF89::_id_353FECD1549F5F42(_id_C5E7FCE963586EC0, _id_8B2F5B7CAA9B211C, team, _id_89593782B8B4434D, undefined, 1024, 1024, undefined);

  if(isarray(_id_11B3529E57CFED0E)) {
    _id_8E39DA7681BBCC4B = _id_8E39DA7681BBCC4B - _id_11B3529E57CFED0E.size;

    if(_id_8E39DA7681BBCC4B <= 0) {
      return;
    }
    foreach(agent in _id_11B3529E57CFED0E) {
      _id_16290C9DDA466BCE = rotatevector((1, 0, 0), (0, randomint(360), 0));
      _id_6FCFAF50CA25F632 = _id_16290C9DDA466BCE * randomfloatrange(512, 1536) + _id_C5E7FCE963586EC0;
      _id_6FCFAF50CA25F632 = agent getclosestreachablepointonnavmesh(_id_6FCFAF50CA25F632);
      _id_120270BD0A747A35::_id_E786AA52B93833EB(agent, _id_6FCFAF50CA25F632, 256, 256);
    }
  }

  if(!_id_33357506B39DF2EF()) {
    return;
  }
  if(_id_8E39DA7681BBCC4B > 2) {
    _id_0B58631347B6AB04 = _id_2BC0B0102F9B7751::_id_03779DEB97B61A65(min(_id_8E39DA7681BBCC4B, _id_51FB808F0AD7B056), _id_C5E7FCE963586EC0, priority, category, _id_1C9CB43BCF3EB16D, undefined, team, 1, _id_171F90B9C4C76D44);

    if(isarray(_id_0B58631347B6AB04)) {
      _id_8E39DA7681BBCC4B = _id_8E39DA7681BBCC4B - (_id_0B58631347B6AB04.size - 2);

      if(_id_8E39DA7681BBCC4B <= 0) {
        return;
      }
      foreach(agent in _id_0B58631347B6AB04) {
        _id_16290C9DDA466BCE = rotatevector((1, 0, 0), (0, randomint(360), 0));
        _id_6FCFAF50CA25F632 = _id_16290C9DDA466BCE * randomfloatrange(512, 1536) + _id_C5E7FCE963586EC0;
        _id_6FCFAF50CA25F632 = agent getclosestreachablepointonnavmesh(_id_6FCFAF50CA25F632);
        _id_120270BD0A747A35::_id_E786AA52B93833EB(agent, _id_6FCFAF50CA25F632, 256, 256);
      }
    }
  }
}

_id_40BE536148B7548E(agent) {
  agent endon("death");
  level endon("game_ended");

  for(;;) {
    agent thread scripts\mp\utility\debug::drawsphere(agent.origin, 32, 1, (0, 1, 0));
    wait 1;
  }
}

_id_00377D92658A1E91(_id_3064FA24DBBD5BBF, model) {
  if(isDefined(_id_3064FA24DBBD5BBF.ent)) {
    return;
  }
  if(!isDefined(model))
    model = _id_3064FA24DBBD5BBF.modelname;

  ent = spawn("script_model", _id_3064FA24DBBD5BBF.origin);
  ent setModel(model);
  ent.angles = _id_3064FA24DBBD5BBF.angles;
  ent.info = _id_3064FA24DBBD5BBF;
  scripts\cp_mp\calloutmarkerping::_id_6B9641D0060C3A2C(ent);
  ent setscriptablepartstate("dmz_exfil_smoke", "smoking", 0);
  ent setscriptablepartstate("dmz_exfil_site", "ready", 0);
  ent hide();
  _id_3064FA24DBBD5BBF.ent = ent;
}

_id_BBE41F41D0F13612(_id_3064FA24DBBD5BBF) {
  if(!isDefined(level._id_FE2E551DA0962C3C))
    level._id_FE2E551DA0962C3C = [];

  if(!isDefined(_id_3064FA24DBBD5BBF.ent))
    _id_00377D92658A1E91(_id_3064FA24DBBD5BBF);

  _id_3064FA24DBBD5BBF.ent show();
  _id_3064FA24DBBD5BBF._id_B6B245F03C15D48D = 1;
  level._id_FE2E551DA0962C3C[level._id_FE2E551DA0962C3C.size] = _id_3064FA24DBBD5BBF;
}

_id_97061811695243EA(_id_3064FA24DBBD5BBF) {
  if(!isDefined(level._id_FE2E551DA0962C3C)) {
    return;
  }
  if(!isDefined(_id_3064FA24DBBD5BBF.ent)) {
    return;
  }
  _id_3064FA24DBBD5BBF.ent hide();
  _id_3064FA24DBBD5BBF._id_B6B245F03C15D48D = 0;
  level._id_FE2E551DA0962C3C = scripts\engine\utility::array_remove(level._id_FE2E551DA0962C3C, _id_3064FA24DBBD5BBF);
}

_id_B513AAF6E49F184A(_id_3064FA24DBBD5BBF) {
  if(!isDefined(_id_3064FA24DBBD5BBF.ent))
    _id_00377D92658A1E91(_id_3064FA24DBBD5BBF);

  foreach(team in _id_3064FA24DBBD5BBF._id_D81E4008D63C5E96) {
    foreach(player in scripts\mp\utility\teams::getteamdata(team, "players"))
    _id_3064FA24DBBD5BBF.ent showtoplayer(player);
  }
}

_id_F4DC35C0F47A461C(_id_3064FA24DBBD5BBF, team) {
  if(!isDefined(_id_3064FA24DBBD5BBF.ent))
    _id_00377D92658A1E91(_id_3064FA24DBBD5BBF);

  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players"))
  _id_3064FA24DBBD5BBF.ent showtoplayer(player);
}

_id_A857C0CB4FCB1819(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  _id_87B0B8A08FB5E71A = level.teamdata[_id_8A04AA0E0755E7E3]["exfils"];
  _id_F0E72070CF6E1EB1 = level.teamdata[_id_EB06B338608EF354]["exfils"];

  foreach(exfil in _id_87B0B8A08FB5E71A)
  exfil.ent hidefromplayer(player);

  foreach(exfil in _id_F0E72070CF6E1EB1)
  exfil.ent showtoplayer(player);

  players = scripts\mp\utility\teams::getteamdata(_id_EB06B338608EF354, "players");

  foreach(_id_F0EA4030349A33D5 in players) {
    if(istrue(_id_F0EA4030349A33D5._id_5A4D470F2093FFF1)) {
      player setclientomnvar("ui_owns_personal_exfil", 1);
      break;
    }
  }
}

_id_AEE6FE083265E34C() {
  self endon("disable");
  numagents = getdvarint("dvar_1CE7B251C3164B2C", 6);

  if(numagents == 0) {
    return;
  }
  _id_8B61A19A823C6C0A = getdvarint("dvar_3D1B037BBE89B3AC", 4000);
  _id_3B40988F103F331E = _id_8B61A19A823C6C0A * _id_8B61A19A823C6C0A;

  for(;;) {
    foreach(team in self.info._id_D81E4008D63C5E96) {
      foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
        if(distancesquared(self.origin, player.origin) < _id_3B40988F103F331E) {
          _id_5AEB0C8E23FF1430 = _id_48814951E916AF89::_id_77ACC10C4823DD8A(numagents, self.origin, "medium", "reinforcements", "ExtractAmbush", undefined, undefined, 1, _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(player.origin));
          return;
        }
      }
    }

    wait 1.0;
  }
}

_id_309C0A11484CC0DB(players, _id_3064FA24DBBD5BBF) {
  if(!isDefined(_id_3064FA24DBBD5BBF))
    _id_3064FA24DBBD5BBF = _id_5C65D346AC65390C::_id_730C660D9FC6808E(players, 0, 0, 0, 0);

  _id_3AACF02225CA0DA5::_id_025A4B6A2083E2AB(players);

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    player.extracted = 1;
    _id_17950170D1365EE0([player]);
  }

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    player thread _id_AC298C756F30AEA6(_id_3064FA24DBBD5BBF);
  }
}

_id_AC298C756F30AEA6(_id_3064FA24DBBD5BBF) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(self)) {
    if(getdvarint("dvar_83914B051F41C82D", 1) == 1 && !_id_362C58E8BB39BCDA::isfeaturedisabled("teamSpectate"))
      _id_6489FCDFE6FA2E36::migratespectators(self, undefined, 0);

    thread fadetoblack();

    if(istrue(level._id_95DE4B6BB41FBBFA[self.team]))
      self setclientomnvar("ui_dmz_extract_successful", 2);
    else {
      _id_5E076183A565C611 = 1;

      foreach(player in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
        if(!istrue(player.extracted)) {
          _id_5E076183A565C611 = 0;
          break;
        }
      }

      if(_id_5E076183A565C611) {
        level._id_95DE4B6BB41FBBFA[self.team] = 1;
        self setclientomnvar("ui_dmz_extract_successful", 2);
      } else
        self setclientomnvar("ui_dmz_extract_successful", 1);
    }

    scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("event", "player_win");
    self._id_E7AF56A2DF18030D = 0;
    self._id_68426CBAAC96006B = self.origin;
    self.spawnprotection = 1;
    scripts\mp\lightarmor::setlightarmorvalue(self, 1000, undefined, 0);
    _id_3B64EB40368C1450::_id_2D6E7E0B80767910("exfil_success", ["usability", "offhand_weapons", "killstreaks", "supers", "gesture", "weapon", "weapon_switch"]);
    _id_3B64EB40368C1450::_id_3633B947164BE4F3("exfil_success", 0);
    self allowmovement(0);
    self allowfire(0);
    self freezecontrols(1);
    self notify("successful_exfil");
    wait 0.25;

    if(getdvarint("dvar_A186FF3C324CDD8E", 1) == 1) {
      if(isDefined(level._id_11D0C321045F514F) && isDefined(level._id_11D0C321045F514F[self.team]))
        self playerlinkTo(level._id_11D0C321045F514F[self.team]);
      else {
        _id_6489FCDFE6FA2E36::_id_3C5421C26D253EB0(0);
        self playerlinkTo(level._id_11D0C321045F514F[self.team]);
      }
    }

    _id_4480C6CE37B2BDF3::_id_53109B63A7168074();
    _id_46F56BF948599140(self);
    thread scripts\mp\hud_message::showsplash("callout_exfil_success");
  }

  if(isDefined(self)) {
    if(isDefined(self._id_68426CBAAC96006B))
      self setOrigin(self._id_68426CBAAC96006B);

    scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
    scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("br_dmz_extract::onPlayerExfilSuccess()");
    self sethidenameplate(0);
    self disableoffhandprimaryweapons(0);
    self disableoffhandsecondaryweapons(0);
    self disableweapons(0);
    self disableweaponswitch(0);
    self setcamerathirdperson(1);
    self allowcrouch(0);
    self allowmelee(0);
    self allowjump(0);
    self allowprone(0);
    self.ignoreme = 1;
    self.plotarmor = 1;
    scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/EXTRACTED_SUCCESS");
    _id_6FC415FF6A905DC1::_id_5332E1C0F06B0245(_id_3064FA24DBBD5BBF);

    if(!isDefined(self._id_E7FAF08F327B0FB5))
      self._id_E7FAF08F327B0FB5 = 0;

    _id_FEC4228317AFE4FF = scripts\engine\utility::_id_53C4C53197386572(self._id_FEC4228317AFE4FF, 0);
    self._id_E7FAF08F327B0FB5 = self._id_E7FAF08F327B0FB5 + _id_2CC6455920627806::_id_0160A29300CE1E14(_id_FEC4228317AFE4FF, self, getdvarfloat("dvar_CE8C20AC42E3C18A", 0.75));
    _id_D6DE66CFADA71A27 = getdvarfloat("dvar_0B733889F0B8C700", 1.0);
    _id_689A927D39BA7262 = int(min(_id_FEC4228317AFE4FF / _id_D6DE66CFADA71A27, getdvarint("dvar_890DF0079E1885B8", 10000)));
    self._id_26D7A92A39B78748 = _id_689A927D39BA7262;
    _id_33E0291812D90FC1 = scripts\mp\rank::_id_D06C3CBB904AE29B("stat_A664E407EB3E39D4");

    if(_id_2391409EF7B431E1::_id_C07675F2CE32FCB5(self))
      _id_33E0291812D90FC1 = _id_33E0291812D90FC1 + getdvarint("dvar_2B3CB1F1B979A35B", 500);

    scripts\mp\utility\points::_id_0366980B6A8796AE("stat_A664E407EB3E39D4", undefined, undefined, _id_33E0291812D90FC1 + _id_689A927D39BA7262, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
    level thread _id_0EE113AF8FBA94BA(self);
    wait 1.0;
    _id_4480C6CE37B2BDF3::_id_0865B1A5A62C49D7();
  }
}

_id_DF3BFE2C77975120() {
  _id_33E0291812D90FC1 = scripts\mp\rank::_id_D06C3CBB904AE29B("stat_A664E407EB3E39D4");

  if(_id_2391409EF7B431E1::_id_C07675F2CE32FCB5(self))
    _id_33E0291812D90FC1 = _id_33E0291812D90FC1 + getdvarint("dvar_2B3CB1F1B979A35B", 500);

  scripts\mp\utility\points::_id_0366980B6A8796AE("stat_A664E407EB3E39D4", undefined, undefined, _id_33E0291812D90FC1, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  _id_4480C6CE37B2BDF3::_id_0865B1A5A62C49D7(1);
  _id_0B7A9CE0A2282B79::_id_2AB8227B96AB5D5F(self);
}

_id_46F56BF948599140(player) {
  _id_5A0FC1D304E970EA = "unset";

  if(isDefined(player.sessionteam))
    _id_5A0FC1D304E970EA = player.sessionteam;

  if(isDefined(player.team))
    _id_5A0FC1D304E970EA = player.team;

  _id_9C02E895E4DBDC3B = "0";

  if(isDefined(level._id_A7B62649C81B481A) && isDefined(level._id_A7B62649C81B481A._id_ACC161DE36707DE2))
    _id_9C02E895E4DBDC3B = scripts\engine\utility::string(level._id_A7B62649C81B481A._id_ACC161DE36707DE2);

  _id_E259EEA64AEF58D5 = player _id_2D9D24F7C63AC143::_id_254150D1E667DEE7();
  _id_7838B9DF983AD1EA = [];
  _id_EA9DD7D31F4B0630 = player _id_6FC415FF6A905DC1::_id_9CD290910C24D4D3();
  _id_A1FC16D2EA055338 = [];
  _id_1C78E184E8E6AE71 = _id_2D9D24F7C63AC143::_id_2985254128B1C262(player);

  if(!isDefined(_id_1C78E184E8E6AE71))
    _id_1C78E184E8E6AE71 = "none";
  else
    _id_1C78E184E8E6AE71 = _id_1C78E184E8E6AE71.basename;

  foreach(item in _id_E259EEA64AEF58D5) {
    if(!isDefined(item.lootid)) {
      _id_7838B9DF983AD1EA[_id_7838B9DF983AD1EA.size] = "null";
      continue;
    }

    _id_CB325DDB4A764623 = scripts\engine\utility::string(item.lootid);
    _id_7838B9DF983AD1EA[_id_7838B9DF983AD1EA.size] = _id_CB325DDB4A764623;
  }

  foreach(item in _id_EA9DD7D31F4B0630) {
    if(isDefined(item.lootid)) {
      _id_CB325DDB4A764623 = item.lootid;
      _id_A1FC16D2EA055338[_id_A1FC16D2EA055338.size] = _id_CB325DDB4A764623;
    }
  }

  [_id_153FDEE861E0F06F, perks] = _id_0B7A9CE0A2282B79::_id_1558F8FB859C492A(player);

  if(!isDefined(_id_153FDEE861E0F06F))
    _id_153FDEE861E0F06F = 0;

  data = spawnStruct();
  data.player = player;
  data._id_5A0FC1D304E970EA = _id_5A0FC1D304E970EA;
  data.x = player.origin[0];
  data.y = player.origin[1];
  data.z = player.origin[2];
  data._id_6437FC57F57C9AD8 = player.angles[0];
  data._id_FE76A03A13318315 = player.angles[1];
  data._id_868460883D5CE6A2 = player.angles[2];
  data._id_9C02E895E4DBDC3B = _id_9C02E895E4DBDC3B;
  data._id_C983D3ABB7EC13D9 = int(scripts\mp\utility\game::getsecondspassed());
  data._id_FCC975EE4C8B02CC = "0";
  data._id_42623C2865853280 = player.plundercount;
  data._id_8003724EAD57BA09 = _id_7838B9DF983AD1EA;
  data._id_1C78E184E8E6AE71 = _id_1C78E184E8E6AE71;
  data._id_8919314D1DF8D669 = _id_A1FC16D2EA055338;
  data._id_3D1611A538E77206 = "none";
  data._id_3E8D5A83AE37A4FF = "none";
  data._id_D9BB11BFF39D0BAC = "none";
  data._id_D35C23115990E1CE = [];
  data._id_BC4AE9E25D0666C5 = _id_153FDEE861E0F06F;
  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_dmz_on_exfil", data);
}

_id_0EE113AF8FBA94BA(player) {
  _id_1E4A61DB11011446::updateclientmatchdata(player);
  _id_9C60D720A2BC0F37 = 5;
  player._id_E7AF56A2DF18030D = 1;
  wait(_id_9C60D720A2BC0F37);

  if(isDefined(player)) {
    if(istrue(player.inlaststand)) {
      if(player scripts\mp\laststand::finishreviveplayer("self_revive_on_kill_success", player))
        player scripts\mp\laststand::onrevive(1);
    }

    if(istrue(player.gasmaskequipped))
      player thread _id_7E52B56769FA7774::removegasmaskbr();

    if(istrue(player.insertingarmorplate))
      player notify("try_armor_cancel", "game_end");

    player _id_6A5D3BF7A5B7064A::onexitdeathsdoor(0);
    player.spawnprotection = 1;
    level.skipplaybodycountsound = 1;
    player scripts\mp\playerlogic::removefromalivecount(1, "dmzExfil");
    scripts\mp\utility\teams::validatealivecount("extract", player.team, player, "handlePlayerExfilDone");

    if(istrue(level._id_95DE4B6BB41FBBFA[player.team])) {
      if(isDefined(self._id_68426CBAAC96006B)) {
        spawnpoint = spawnStruct();
        spawnpoint.origin = player._id_68426CBAAC96006B;
        spawnpoint.angles = player.angles;
        player scripts\mp\playerlogic::spawnintermission(spawnpoint, undefined, 0);
      } else
        player _id_6489FCDFE6FA2E36::spawnintermissionatplayer(player);

      player.br_spectatorinitialized = 1;
      player notify("br_spectatorInitialized");
    } else {
      player thread _id_6489FCDFE6FA2E36::spawnspectator();
      _id_B892C6B4C68C344A([player], 1);
    }

    player setclientomnvar("ui_br_squad_eliminated_active", 1);
    player setclientomnvar("ui_round_end_title", game["round_end"]["victory"]);
    player setclientomnvar("ui_round_end_reason", game["end_reason"]["objective_completed"]);
    player setclientdvar("ui_opensummary", 1);
  }

  level thread _id_4480C6CE37B2BDF3::_id_DA0FA1AFAA8835CF();
}

_id_EFF2A482B361A6ED(player, fadetoblack, _id_F69BA8D7B96E8326) {
  player notify("start_fade_to_black");
  player endon("start_fade_to_black");
  player endon("disconnect");
  _id_400FC540BBC48AA9 = 0;

  if(istrue(fadetoblack))
    _id_400FC540BBC48AA9 = 1;

  if(!isDefined(_id_F69BA8D7B96E8326) || _id_F69BA8D7B96E8326 == 0) {
    player setclientomnvar("ui_total_fade", _id_400FC540BBC48AA9);
    return;
  }

  _id_226A6D12E60638A5 = _id_400FC540BBC48AA9;
  _id_400FC540BBC48AA9 = 0;
  _id_DB4AF00B8B0BF7C6 = int(_id_F69BA8D7B96E8326 / level.framedurationseconds);
  _id_F2C7B24B4F8544F3 = 1 / _id_DB4AF00B8B0BF7C6;

  if(!istrue(fadetoblack)) {
    _id_F2C7B24B4F8544F3 = _id_F2C7B24B4F8544F3 * -1;
    _id_400FC540BBC48AA9 = 1;
  }

  while(_id_DB4AF00B8B0BF7C6 > 0) {
    _id_400FC540BBC48AA9 = _id_400FC540BBC48AA9 + _id_F2C7B24B4F8544F3;
    player setclientomnvar("ui_total_fade", _id_400FC540BBC48AA9);
    _id_DB4AF00B8B0BF7C6--;
    waitframe();
  }

  player setclientomnvar("ui_total_fade", _id_226A6D12E60638A5);
  player notify("finish_fade_to_black");
}

fadetoblack() {
  level endon("game_ended");
  self endon("disconnect");
  level _id_EFF2A482B361A6ED(self, 1, 0.25);
  scripts\engine\utility::waittill_any_timeout_3(4, "force_spectate_done", "br_team_fully_eliminated", "br_spectatorInitialized");
  level _id_EFF2A482B361A6ED(self, 0, 1);
}

_id_0AAEF0BD11948A0C() {
  self waittill("force_spectate_done");

  if(self.hidehudenabled)
    scripts\cp_mp\utility\player_utility::hidehuddisable();
}

_id_1DCDA56EFB76E334(team) {
  self endon("disable");
  wait(level._id_B91D57DF9D8EC00E);
  self setscriptablepartstate("dmz_exfil_smoke", "smoking", 1);
  self setscriptablepartstate("dmz_exfil_site", "ready", 1);

  if(isDefined(team)) {
    self._id_D81E4008D63C5E96[team] = team;
    _id_AC66B79A73B21444(team, self.info);
  }
}

_id_8FC5AEAB9CB08048(ent) {
  if(isDefined(ent)) {
    if(level._id_09B3294726F6D3A6 && (!level._id_DD83D323306DCBA7 || !level._id_33A2175A9A4306BC._id_009BADBB469626F6))
      level thread _id_6613AEB065E36928(ent.origin);

    thread _id_5BC15F36914E63C7(ent, undefined, undefined, self);
  }
}

_id_33357506B39DF2EF() {
  if(level._id_0BA138AD5136D87D > 0) {
    _id_2B38C1D78139313E = clamp((gettime() - level._id_6C41580562FD09E2) / level._id_0BA138AD5136D87D, 0, 1);
    _id_D3E80203D73E375C = level._id_CD6E8342A9C09C26 - level._id_4BE8962610EE659B;
    c = clamp(_id_D3E80203D73E375C * _id_2B38C1D78139313E + level._id_4BE8962610EE659B, 0, 1);
    return scripts\engine\utility::_id_51D76700600CEBE3(c);
  } else if(level._id_0BA138AD5136D87D == 0)
    return scripts\engine\utility::_id_51D76700600CEBE3(level._id_CD6E8342A9C09C26);

  return 1;
}

_id_7FF5E35E992DF372() {
  if(!isDefined(level._id_6AD981AE12245CBE))
    level._id_6AD981AE12245CBE = [];

  if(!isDefined(level._id_6AD981AE12245CBE[self.team]))
    level._id_6AD981AE12245CBE[self.team] = 0;

  if(level._id_6AD981AE12245CBE[self.team] >= getdvarint("dvar_BD34018FBF7C5375", 1))
    return 0;

  _id_F5AA0AAC262FBF0B = sortbydistance(level._id_883F54A2A56E126C, self.origin);

  foreach(exfil in _id_F5AA0AAC262FBF0B) {
    if(istrue(exfil._id_02312C613DAC6449) || istrue(exfil._id_B6B245F03C15D48D)) {
      continue;
    }
    exfil._id_02312C613DAC6449 = 1;
    level._id_6AD981AE12245CBE[self.team] = level._id_6AD981AE12245CBE[self.team] + 1;
    _id_F4DC35C0F47A461C(exfil, self.team);
    exfil.ent setscriptablepartstate("dmz_exfil_icon", "personal_icon");
    return 1;
  }

  return 0;
}

_id_9A7567A2D46B857A() {
  level endon("game_ended");

  while(!isDefined(level._id_C26F0D22BC1FA7EF))
    waitframe();

  if(level.mapname == "mp_ai_firefight") {
    foreach(exfil in level._id_C26F0D22BC1FA7EF)
    _id_BBE41F41D0F13612(exfil);

    return;
  }

  while(!isDefined(level._id_33A2175A9A4306BC))
    waitframe();

  while(!isDefined(level._id_33A2175A9A4306BC.origin))
    waitframe();

  while(!isDefined(level._id_1B7407DFFE81E6E8) || !isDefined(level._id_1B7407DFFE81E6E8._id_B2F15037287A033A))
    waitframe();

  _id_56EA112138F55047 = getdvarint("dvar_B4F00BD105203EC9", 1);
  level._id_449A83B6455A0F37 = scripts\engine\utility::getStructArray("dmz_hostage_exfil", "script_noteworthy");

  foreach(exfil in level._id_449A83B6455A0F37) {
    exfil.origin = (0, 0, -10) + scripts\engine\utility::ter_op(_id_56EA112138F55047 == 1, scripts\engine\utility::drop_to_ground(getclosestpointonnavmesh(exfil.origin)), exfil.origin);
    exfil.modelname = "dmz_exfil_site_xmodel";

    if(isDefined(exfil.target)) {
      _id_23D42B1195DDA679 = scripts\engine\utility::getStruct(exfil.target, "targetname");

      if(isDefined(_id_23D42B1195DDA679)) {
        exfil._id_B44C269EA13F56AE = _id_23D42B1195DDA679.origin;
        exfil._id_A55FA332B1255E04 = _id_23D42B1195DDA679.angles;
      }
    }

    if(isDefined(exfil.script_label)) {
      if(exfil.script_label == "land")
        exfil.land = 1;
    }
  }

  if(istrue(level._id_50477DC063210A56)) {
    _id_883F54A2A56E126C = [];

    foreach(exfil in level._id_C26F0D22BC1FA7EF)
    _id_883F54A2A56E126C[_id_883F54A2A56E126C.size] = exfil;

    foreach(exfil in level._id_449A83B6455A0F37)
    _id_883F54A2A56E126C[_id_883F54A2A56E126C.size] = exfil;

    foreach(exfil in level._id_B95A019FC748357A)
    _id_883F54A2A56E126C[_id_883F54A2A56E126C.size] = exfil;

    foreach(exfil in _id_883F54A2A56E126C)
    _id_BBE41F41D0F13612(exfil);
  } else if(level._id_858DBA9DA8DC5419 != 0) {
    if(level._id_858DBA9DA8DC5419 < 0) {
      _id_58E0D6D6E9B4C639 = abs(level._id_858DBA9DA8DC5419);

      foreach(_id_B205D90302DA2F07, _id_36847C9A092F0703 in level._id_5FAD09539823F92E) {
        _id_CEE0C6760060DFF8 = scripts\engine\utility::array_randomize(_id_36847C9A092F0703);

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_58E0D6D6E9B4C639; _id_AC0E594AC96AA3A8++)
          _id_BBE41F41D0F13612(_id_CEE0C6760060DFF8[_id_AC0E594AC96AA3A8]);
      }
    } else {
      _id_CEE0C6760060DFF8 = scripts\engine\utility::array_randomize(level._id_C26F0D22BC1FA7EF);

      if(_id_CEE0C6760060DFF8.size < level._id_858DBA9DA8DC5419)
        level._id_858DBA9DA8DC5419 = _id_CEE0C6760060DFF8.size;

      _id_099A5914EFBB9B30 = spawnStruct();
      _id_099A5914EFBB9B30.points = [];
      _id_099A5914EFBB9B30._id_F700D2836AAB75A4 = [];
      _id_099A5914EFBB9B30._id_F700D2836AAB75A4[0] = [];
      _id_099A5914EFBB9B30._id_F700D2836AAB75A4[1] = [];
      _id_099A5914EFBB9B30._id_F700D2836AAB75A4[2] = [];
      _id_099A5914EFBB9B30._id_F700D2836AAB75A4[3] = [];
      _id_099A5914EFBB9B30._id_09F9244294D1D74E = [];
      _id_099A5914EFBB9B30._id_09F9244294D1D74E[0] = [];
      _id_099A5914EFBB9B30._id_09F9244294D1D74E[1] = [];
      _id_099A5914EFBB9B30._id_09F9244294D1D74E[2] = [];
      _id_099A5914EFBB9B30._id_09F9244294D1D74E[3] = [];
      _id_099A5914EFBB9B30._id_B2F070298A88DBCB = [];
      _id_883F54A2A56E126C = [];

      foreach(exfil in level._id_C26F0D22BC1FA7EF)
      _id_883F54A2A56E126C[_id_883F54A2A56E126C.size] = exfil;

      _id_56EA112138F55047 = getdvarint("dvar_B4F00BD105203EC9", 1);

      foreach(exfil in level._id_449A83B6455A0F37) {
        if(!istrue(exfil.chosen)) {
          exfil.origin = (0, 0, -10) + scripts\engine\utility::ter_op(_id_56EA112138F55047 == 1, scripts\engine\utility::drop_to_ground(getclosestpointonnavmesh(exfil.origin)), exfil.origin);
          exfil.modelname = "dmz_exfil_site_xmodel";
          _id_883F54A2A56E126C[_id_883F54A2A56E126C.size] = exfil;
        }
      }

      level._id_883F54A2A56E126C = _id_883F54A2A56E126C;
      _id_F5AA0AAC262FBF0B = sortbydistance(_id_883F54A2A56E126C, level._id_33A2175A9A4306BC.origin);

      foreach(point in _id_F5AA0AAC262FBF0B) {
        _id_6FCD82720E35BEC2 = point.origin - level._id_33A2175A9A4306BC.origin;
        point._id_6FCD82720E35BEC2 = _id_6FCD82720E35BEC2;
        index = scripts\engine\utility::ter_op(_id_6FCD82720E35BEC2[0] < 0, -1, 0) + scripts\engine\utility::ter_op(_id_6FCD82720E35BEC2[1] < 0, 3, 1);
        _id_099A5914EFBB9B30._id_F700D2836AAB75A4[index][_id_099A5914EFBB9B30._id_F700D2836AAB75A4[index].size] = point;
      }

      foreach(point in level._id_B95A019FC748357A) {
        _id_6FCD82720E35BEC2 = point.origin;
        point._id_6FCD82720E35BEC2 = _id_6FCD82720E35BEC2;
        index = scripts\engine\utility::ter_op(_id_6FCD82720E35BEC2[0] < 0, -1, 0) + scripts\engine\utility::ter_op(_id_6FCD82720E35BEC2[1] < 0, 3, 1);
        _id_099A5914EFBB9B30._id_09F9244294D1D74E[index][_id_099A5914EFBB9B30._id_09F9244294D1D74E[index].size] = point;
      }

      _id_D23334F7ED3AEF60 = scripts\engine\utility::ter_op(level._id_33A2175A9A4306BC.origin[0] * -1 < 0, -1, 0) + scripts\engine\utility::ter_op(level._id_33A2175A9A4306BC.origin[1] * -1 < 0, 3, 1);

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
        if(_id_AC0E594AC96AA3A8 != _id_D23334F7ED3AEF60)
          _id_099A5914EFBB9B30._id_B2F070298A88DBCB[_id_099A5914EFBB9B30._id_B2F070298A88DBCB.size] = _id_AC0E594AC96AA3A8;
      }

      _id_099A5914EFBB9B30._id_B2F070298A88DBCB = scripts\engine\utility::array_randomize(_id_099A5914EFBB9B30._id_B2F070298A88DBCB);
      level._id_C5074BF13FFB95EF = _id_099A5914EFBB9B30._id_09F9244294D1D74E[_id_D23334F7ED3AEF60][randomint(_id_099A5914EFBB9B30._id_09F9244294D1D74E[_id_D23334F7ED3AEF60].size)];

      if(!isDefined(level._id_C5074BF13FFB95EF)) {
        _id_A82A50C49958A9EF = sortbydistance(level._id_B95A019FC748357A, level._id_33A2175A9A4306BC.origin);
        level._id_C5074BF13FFB95EF = _id_A82A50C49958A9EF[_id_A82A50C49958A9EF.size - 1];
      }

      level._id_C919655BC36D8C87 = _id_099A5914EFBB9B30;
      _id_8438F4A482DA474A = undefined;
      _id_1C2BD1D8CCEA9D4B = 0;

      if(isDefined(level._id_A422458EC66A5DFB) && getdvarint("dvar_4D4F07CDDE717AAF", 0)) {
        _id_8438F4A482DA474A = [[level._id_A422458EC66A5DFB]](_id_F5AA0AAC262FBF0B, level._id_B95A019FC748357A, level._id_C5074BF13FFB95EF, level._id_858DBA9DA8DC5419, level._id_33A2175A9A4306BC);

        if(isDefined(_id_8438F4A482DA474A) && _id_8438F4A482DA474A.size == level._id_858DBA9DA8DC5419)
          _id_8438F4A482DA474A = scripts\engine\utility::array_reverse(_id_8438F4A482DA474A);
      }

      if(!isDefined(_id_8438F4A482DA474A)) {
        _id_822DB80CE3C87A54 = getdvarfloat("dvar_D92C4387F959542C", 0.65);
        _id_DEE7A3B516180A52 = getdvarint("dvar_F24F686449931240", 2);
        _id_636C8575D7A7768B = getdvarint("dvar_5D9984A8FA843DE9", 20000);
        _id_636C8575D7A7768B = _id_636C8575D7A7768B * _id_636C8575D7A7768B;
        midpoint = level._id_33A2175A9A4306BC.origin + (level._id_C5074BF13FFB95EF.origin - level._id_33A2175A9A4306BC.origin) * _id_822DB80CE3C87A54;
        _id_E2231EC8BDD4A84F = sortbydistance(_id_F5AA0AAC262FBF0B, midpoint);
        _id_8438F4A482DA474A = [_id_E2231EC8BDD4A84F[randomint(_id_DEE7A3B516180A52)]];
        failed = 0;
        _id_9A6BA9F5A0E705C7 = 0;

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_858DBA9DA8DC5419 - 1; _id_AC0E594AC96AA3A8++) {
          index = _id_AC0E594AC96AA3A8;
          _id_C4B448E975A0779B = 0;

          for(_id_8243432C62A4DC77 = 0; !_id_8243432C62A4DC77 && _id_C4B448E975A0779B < _id_099A5914EFBB9B30._id_B2F070298A88DBCB.size; _id_C4B448E975A0779B = _id_C4B448E975A0779B + 1) {
            while(index >= _id_099A5914EFBB9B30._id_B2F070298A88DBCB.size)
              index = index - _id_099A5914EFBB9B30._id_B2F070298A88DBCB.size;

            foreach(point in _id_099A5914EFBB9B30._id_F700D2836AAB75A4[_id_099A5914EFBB9B30._id_B2F070298A88DBCB[index]]) {
              if(distance2dsquared(point.origin, level._id_33A2175A9A4306BC.origin) < _id_636C8575D7A7768B) {
                continue;
              }
              _id_05956C54E54EBF3D = 1;

              foreach(_id_4A95E4581CD308CA in _id_8438F4A482DA474A) {
                if(distance2dsquared(point.origin, _id_4A95E4581CD308CA.origin) < _id_636C8575D7A7768B) {
                  _id_05956C54E54EBF3D = 0;
                  break;
                }
              }

              if(!_id_05956C54E54EBF3D) {
                continue;
              }
              _id_8438F4A482DA474A[_id_8438F4A482DA474A.size] = point;
              _id_8243432C62A4DC77 = 1;
              break;
            }

            index = index + 1;
          }

          if(!_id_8243432C62A4DC77)
            failed = failed + 1;
        }

        if(failed > 0) {
          for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < failed; _id_AC0E594AC96AA3A8++)
            _id_8438F4A482DA474A[_id_8438F4A482DA474A.size] = scripts\engine\utility::_id_7A2AAA4A09A4D250(_id_F5AA0AAC262FBF0B);
        }
      }

      foreach(e in _id_8438F4A482DA474A)
      _id_BBE41F41D0F13612(e);

      level._id_AA174DF565129C2B = _id_8438F4A482DA474A[0];
    }

    timer = getdvarint("scr_br_timelimit");
    waittime = int(max(timer - level._id_B8457C8044B2EE02, 0));

    if(waittime <= 0) {
      return;
    }
    wait(waittime);
    level notify("start_dmz_extracts");
    return;
  }

  level._id_45B8EBF14DBC4E63 = [];

  foreach(player in level.players) {
    _id_CEE0C6760060DFF8 = scripts\mp\utility\teams::getteamdata(player.team, "exfils");

    if(isDefined(_id_CEE0C6760060DFF8) && _id_CEE0C6760060DFF8.size > 0) {
      continue;
    }
    if(level._id_C42D6E4A40F70691 == 0 && level._id_FF04728F8E36403F == 0)
      _id_1C2BD1696D29935B(player.team, "dmz_exfil_intro");

    if(isDefined(player) && isDefined(level._id_C26F0D22BC1FA7EF) && isDefined(level._id_C26F0D22BC1FA7EF[0])) {
      exfil = level._id_C26F0D22BC1FA7EF[0];
      maxdist = 0;

      if(isDefined(level.teamdata[player.team]["startPoint"])) {
        _id_AC33FED0DD8063F8 = level.teamdata[player.team]["startPoint"]._id_B205D90302DA2F07;
        _id_DE6CB1958BE41B40 = undefined;
        _id_E97FC2F67229C010 = scripts\engine\utility::ter_op(level._id_9B6B8C7ECB7AC7C0, level._id_58F477E9E7E8F739, level._id_C26F0D22BC1FA7EF);

        if(level._id_C8FF03474C1DE67F >= level._id_B205D90302DA2F07.size)
          level._id_C8FF03474C1DE67F = level._id_B205D90302DA2F07.size - 1;

        if(level._id_E5993849FC7D5987 == 0 && isDefined(_id_AC33FED0DD8063F8) && isDefined(level._id_B205D90302DA2F07[_id_AC33FED0DD8063F8]["otherPoiByDist"]))
          _id_DE6CB1958BE41B40 = level._id_B205D90302DA2F07[_id_AC33FED0DD8063F8]["otherPoiByDist"][level._id_C8FF03474C1DE67F];

        for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < _id_E97FC2F67229C010.size; _id_AC0E594AC96AA3A8++) {
          if(level._id_D962891163D17D4A == 1) {
            if(isDefined(_id_AC33FED0DD8063F8) && _id_E97FC2F67229C010[_id_AC0E594AC96AA3A8]._id_B205D90302DA2F07 != _id_AC33FED0DD8063F8)
              continue;
          } else if(level._id_C8FF03474C1DE67F != 0 && isDefined(_id_DE6CB1958BE41B40)) {
            if(_id_E97FC2F67229C010[_id_AC0E594AC96AA3A8]._id_B205D90302DA2F07 != _id_DE6CB1958BE41B40)
              continue;
          }

          dist = distance2dsquared(player.origin, _id_E97FC2F67229C010[_id_AC0E594AC96AA3A8].origin);

          if(dist > maxdist) {
            maxdist = dist;
            exfil = _id_E97FC2F67229C010[_id_AC0E594AC96AA3A8];
          }
        }
      }

      if(getdvarint("dvar_7F50C115586DC8CA", -1) != -1)
        exfil = level._id_C26F0D22BC1FA7EF[getdvarint("dvar_7F50C115586DC8CA", 0)];

      if(level._id_C42D6E4A40F70691 || level._id_FF04728F8E36403F != 0)
        level._id_45B8EBF14DBC4E63[player.team] = exfil;
      else if(level._id_CDC76BC962358072)
        _id_BBE41F41D0F13612(exfil);
      else {
        exfil._id_D81E4008D63C5E96[player.team] = player.team;
        _id_AC66B79A73B21444(player.team, exfil);

        if(getdvarint("dvar_F0FC10CEB2D6142C", 0) == 0) {
          if(isDefined(exfil._id_D81E4008D63C5E96) && exfil._id_D81E4008D63C5E96.size > 0)
            _id_B513AAF6E49F184A(exfil);
          else
            _id_BBE41F41D0F13612(exfil);
        }
      }
    }
  }

  timer = getdvarint("scr_br_timelimit");
  waittime = int(max(timer - level._id_B8457C8044B2EE02, 0));

  if(waittime <= 0) {
    return;
  }
  wait(waittime);
  level notify("start_dmz_extracts");
}

_id_D92380BFC792A6A9() {
  wait 10;

  for(;;) {
    if(getDvar("dvar_EC9D0BC135119057", "") != "") {
      val = getDvar("dvar_EC9D0BC135119057", "");
      setDvar("dvar_EC9D0BC135119057", "");

      if(isDefined(level._id_FE2E551DA0962C3C)) {
        foreach(exfil in level._id_FE2E551DA0962C3C)
        _id_97061811695243EA(exfil);
      }

      vals = strtok(val, " ");
      _id_56EA112138F55047 = getdvarint("dvar_B4F00BD105203EC9", 1);
      _id_883F54A2A56E126C = [];

      if(scripts\engine\utility::array_contains(vals, "hostage") && isDefined(level._id_449A83B6455A0F37)) {
        foreach(exfil in level._id_449A83B6455A0F37) {
          exfil.origin = (0, 0, -10) + scripts\engine\utility::ter_op(_id_56EA112138F55047 == 1, scripts\engine\utility::drop_to_ground(getclosestpointonnavmesh(exfil.origin)), exfil.origin);
          exfil.modelname = "dmz_exfil_site_xmodel";
          _id_883F54A2A56E126C[_id_883F54A2A56E126C.size] = exfil;
        }
      }

      if(scripts\engine\utility::array_contains(vals, "normal") && isDefined(level._id_C26F0D22BC1FA7EF)) {
        foreach(exfil in level._id_C26F0D22BC1FA7EF)
        _id_883F54A2A56E126C[_id_883F54A2A56E126C.size] = exfil;
      }

      if(scripts\engine\utility::array_contains(vals, "final") && isDefined(level._id_B95A019FC748357A)) {
        foreach(exfil in level._id_B95A019FC748357A)
        _id_883F54A2A56E126C[_id_883F54A2A56E126C.size] = exfil;
      }

      foreach(exfil in _id_883F54A2A56E126C)
      _id_BBE41F41D0F13612(exfil);
    }

    if(getdvarint("dvar_A48FC6794F79A816", 0) == 1) {
      player = level.players[0];
      _id_A21D92F62733E9C9 = spawnStruct();
      _id_A21D92F62733E9C9._id_B205D90302DA2F07 = scripts\engine\utility::array_randomize(level._id_B205D90302DA2F07)[0];
      player.brmissionscompleted++;
      player setclientomnvar("ui_dmz_missions_completed", player.brmissionscompleted);
      _id_52781BE0B4E8A959(player.team, _id_A21D92F62733E9C9);
      wait 4;
    }

    if(getdvarint("dvar_DFBC149F9D4E85BF", 0) == 1) {
      foreach(player in level.players)
      player dodamage(999999, player.origin, player, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");

      setDvar("dvar_DFBC149F9D4E85BF", 0);
    }

    wait 1;
  }
}

_id_52781BE0B4E8A959(team, _id_EFA8EF05B190D7D0) {
  level._id_0CC6F9CF228ACCB4[team]++;

  if(istrue(level._id_98C3DB0DBB3D3029)) {
    return;
  }
  if(level._id_08F7D92F10FC80CE) {
    if(level._id_0CC6F9CF228ACCB4[team] % level._id_08F7D92F10FC80CE != 0) {
      return;
    }
    if(level._id_9B6B8C7ECB7AC7C0) {
      _id_204F99D788C2C529 = level._id_58F477E9E7E8F739[0];

      foreach(exfil in level._id_58F477E9E7E8F739) {
        if(!scripts\engine\utility::array_contains_key(exfil._id_D81E4008D63C5E96, team)) {
          if(exfil._id_D81E4008D63C5E96.size > level._id_628F636DE1F2DDA3) {
            _id_204F99D788C2C529 = exfil;
            continue;
          }

          if(level._id_01EFF61A95657CA2 && isDefined(level.teamdata[team]["startPoint"]._id_B205D90302DA2F07) && exfil._id_B205D90302DA2F07 == level.teamdata[team]["startPoint"]._id_B205D90302DA2F07) {
            continue;
          }
          level thread _id_F9DDC1898E570753(exfil, team);
          return;
        }
      }

      if(isDefined(_id_204F99D788C2C529)) {
        level._id_628F636DE1F2DDA3 = level._id_628F636DE1F2DDA3 + 1;
        level thread _id_F9DDC1898E570753(_id_204F99D788C2C529, team);
      }

      return;
    } else {
      players = scripts\mp\utility\teams::getfriendlyplayers(team, 1);
      _id_B205D90302DA2F07 = scripts\engine\utility::ter_op(isDefined(_id_EFA8EF05B190D7D0._id_B205D90302DA2F07), _id_EFA8EF05B190D7D0._id_B205D90302DA2F07, _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(players[0].origin));
      exfil = _id_FFEF19D55026B498(team, _id_EFA8EF05B190D7D0._id_B205D90302DA2F07);

      if(isDefined(exfil)) {
        level thread _id_F9DDC1898E570753(exfil, team);
        return;
      }
    }
  }

  if(level._id_0CC6F9CF228ACCB4[team] != level._id_C42D6E4A40F70691) {
    return;
  }
  level thread _id_ED7BC1AAEB97B0EF(team);
}

_id_F9DDC1898E570753(exfil, team) {
  wait 4;
  exfil._id_D81E4008D63C5E96[team] = team;
  _id_AC66B79A73B21444(team, exfil);
  players = scripts\mp\utility\teams::getfriendlyplayers(team, 1);
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_exfil_ready", players, exfil._id_B205D90302DA2F07);

  if(getdvarint("dvar_F0FC10CEB2D6142C", 0) == 0) {
    if(isDefined(exfil._id_D81E4008D63C5E96) && exfil._id_D81E4008D63C5E96.size > 0)
      _id_B513AAF6E49F184A(exfil);
    else
      _id_BBE41F41D0F13612(exfil);
  }
}

_id_ED7BC1AAEB97B0EF(team) {
  wait 4;
  exfil = level._id_45B8EBF14DBC4E63[team];
  exfil._id_D81E4008D63C5E96[team] = team;
  _id_AC66B79A73B21444(team, exfil);
  players = scripts\mp\utility\teams::getfriendlyplayers(team, 1);
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_exfil_ready", players, exfil._id_B205D90302DA2F07);
  scripts\mp\utility\dialog::leaderdialog("dmz_contract_complete_2", team);

  if(getdvarint("dvar_F0FC10CEB2D6142C", 0) == 0) {
    if(isDefined(exfil._id_D81E4008D63C5E96) && exfil._id_D81E4008D63C5E96.size > 0)
      _id_B513AAF6E49F184A(exfil);
    else
      _id_BBE41F41D0F13612(exfil);
  }
}

_id_FFEF19D55026B498(team, _id_B205D90302DA2F07) {
  _id_921A13367F73AB4D = undefined;

  if(!isDefined(level._id_5FAD09539823F92E[_id_B205D90302DA2F07]))
    return undefined;

  foreach(exfil in level._id_5FAD09539823F92E[_id_B205D90302DA2F07]) {
    if(exfil._id_D81E4008D63C5E96.size == 0 || level._id_4644C9DA9A611950)
      _id_921A13367F73AB4D = exfil;

    if(scripts\engine\utility::array_contains_key(exfil._id_D81E4008D63C5E96, team))
      return undefined;
  }

  return _id_921A13367F73AB4D;
}

_id_40D3FB596096AC55(player) {
  player _id_6C155294223488B5(undefined, &"KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
}

_id_595EEDE45A673B1F(players, _id_B205D90302DA2F07, _id_27144879B0C7BEED) {
  if(istrue(_id_27144879B0C7BEED))
    _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_exfil_inbound_final", players, _id_B205D90302DA2F07);
  else
    _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_exfil_inbound", players, _id_B205D90302DA2F07);
}

_id_0779FDC701BFA688(players, _id_27144879B0C7BEED) {
  _id_3A594B90827CDE7E("dmz_exfil_start", players, _id_27144879B0C7BEED, "dmz_exfil_start_classic");

  foreach(player in players) {
    if(isPlayer(player))
      player._id_2441210FE6EEA080 = 1;
  }
}

_id_133DEEBBE58FB347(players, team, _id_27144879B0C7BEED, ent, _id_2C728460E4C9349D) {
  if(!istrue(_id_27144879B0C7BEED)) {
    if(scripts\mp\gamelogic::gettimeremaining() / 1000 < 30 + level._id_9405ABD1DB7CF2CF || _id_1174ABEDBEFE9ADA::_id_28F7A303238284EE())
      _id_1C2BD1696D29935B(team, "dmz_exfil_pilot_called_gas");
    else
      _id_1C2BD1696D29935B(team, "dmz_exfil_pilot_called_default");
  }

  if(_id_2C728460E4C9349D >= 45) {
    _id_2C728460E4C9349D = _id_2C728460E4C9349D - 30;
    wait(_id_2C728460E4C9349D);
    _id_0EFD3004BCAA728F("dmz_exfil_pilot_called_30out", players);
    _id_2C728460E4C9349D = 30;
  }

  if(_id_2C728460E4C9349D >= 30) {
    _id_2C728460E4C9349D = _id_2C728460E4C9349D - 15;
    wait(_id_2C728460E4C9349D);
    _id_0EFD3004BCAA728F("dmz_exfil_pilot_called_15out", players);
    _id_2C728460E4C9349D = 15;
  }

  wait(_id_2C728460E4C9349D);

  if(!isDefined(ent) || istrue(ent.disabled))
    return;
  else
    _id_0EFD3004BCAA728F("dmz_exfil_pilot_called_close", players);
}

_id_25E48C3D85F4A59C(players, heli) {
  if(isDefined(heli._id_9A9890E85503C247))
    _id_0EFD3004BCAA728F("dmz_exfil_pilot_called_masks", players);
  else
    _id_0EFD3004BCAA728F("dmz_exfil_pilot_called_touchdown", players);
}

_id_0A0D539B960B93BB(players, _id_27144879B0C7BEED) {
  if(istrue(_id_27144879B0C7BEED))
    _id_0EFD3004BCAA728F("dmz_exfil_pilot_called_final_leaving", players);
}

_id_AB7F97A0B46CBEAF(players) {
  _id_0EFD3004BCAA728F("dmz_exfil_pilot_called_final_warning", players);
}

_id_E392FD7CAD768E25() {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.team)) {
    return;
  }
  _id_1C2BD1696D29935B(self.team, "dmz_exfil_pilot_called_shortcut");
}

_id_AA3139C5FAE701B8(heli) {
  _id_135FFB663CA88BBC = getdvarint("dvar_2BE93DD484220A45", 0) == 1;

  if(scripts\mp\gamelogic::gettimeremaining() / 1000 < 30 || _id_1174ABEDBEFE9ADA::_id_28F7A303238284EE() || _id_135FFB663CA88BBC) {
    _id_BF80F581FDCE86D2 = heli.angles + (0, -90, -18);
    _id_840C2EE92C8F78FE = [(33, 40, -198), (-15, 40, -198), (-58, 40, -198), (-105, 40, -198)];

    foreach(offset in _id_840C2EE92C8F78FE) {
      _id_B96E8BC44751CFAE = rotatevector(offset, heli.angles);
      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(heli.origin + _id_B96E8BC44751CFAE, _id_BF80F581FDCE86D2);
      gasmask = _id_7E52B56769FA7774::spawnpickup(scripts\engine\utility::ter_op(_id_135FFB663CA88BBC, "brloot_equip_gasmask_durable", "brloot_equip_gasmask"), _id_CB4FAD49263E20C4, scripts\engine\utility::ter_op(_id_135FFB663CA88BBC, 216, 108));
      gasmask scripts\common\utility::_id_6E506F39F121EA8A(heli, offset);
    }
  }
}

_id_113D0E9D241C8568(players, _id_27144879B0C7BEED) {}

_id_704DC2A5075C58B9(players) {
  foreach(player in players) {
    if(isPlayer(player) && !istrue(player.extracted)) {
      player._id_2441210FE6EEA080 = undefined;
      player notify("end_heli_exit_listener");
      _id_B892C6B4C68C344A([player], 2);
    }
  }
}

_id_1CE7B362085D943E(players, _id_27144879B0C7BEED) {
  _id_3A594B90827CDE7E("dmz_exfil_start", players, _id_27144879B0C7BEED, "dmz_exfil_start_classic");

  foreach(player in players)
  thread _id_2094EF55DEE7B236(player);
}

_id_B1219A25435AB949(players) {}

_id_17950170D1365EE0(players) {
  _id_3A594B90827CDE7E("dmz_exfil_end", players);
  _id_2EDA2621150BD589(players, 4.0);
}

_id_E7994A561BE9B933(players) {
  _id_3A594B90827CDE7E("dmz_exfil_manual", players);
  _id_2EDA2621150BD589(players, 4.0);
}

_id_2094EF55DEE7B236(player) {
  player notify("end_heli_exit_listener");
  player endon("end_heli_exit_listener");
  player waittill("exited_chopper");

  if(istrue(player.extracted)) {
    return;
  }
  _id_B892C6B4C68C344A([player], 1);
  _id_3A594B90827CDE7E("dmz_exfil_abort", [player]);
}

_id_673F07BB8A61BCF3(ent, _id_BEDB769CC0E5E018) {
  if(level._id_662586EDE589F49C && _id_BEDB769CC0E5E018) {
    ent.info.used = 1;
    ent delete();
    return;
  }
}

_id_5BC15F36914E63C7(ent, part, state, player, waittime, _id_292D5D91FB6427FF, _id_27144879B0C7BEED) {
  _id_5C65D346AC65390C::_id_D1478474B036B87F(ent, part, state, player, waittime, _id_292D5D91FB6427FF, _id_27144879B0C7BEED);
}

_id_184FF6B45E3F1B70() {
  self endon("death_or_disconnect");
  _id_2CEDCC356F1B9FC8::playerplaygestureweaponanim("iw8_ges_plyr_plunder_smoke", 1.867);
}

_id_6C155294223488B5(_id_06B62DB6EEC868E2, _id_734564FF3D4FD467) {
  self iprintlnbold(_id_734564FF3D4FD467);
  self playlocalsound("br_pickup_deny");

  if(isDefined(_id_06B62DB6EEC868E2)) {
    ammo = self getweaponammoclip(_id_06B62DB6EEC868E2);
    self setweaponammoclip(_id_06B62DB6EEC868E2, ammo + 1);
  }
}

callback_vehicledamage(inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, partname, eventid) {
  if(isDefined(attacker)) {
    if(isDefined(attacker.owner))
      attacker = attacker.owner;
  }

  if(istrue(level._id_F7C6553E5222163F)) {
    return;
  }
  if((attacker == self || isDefined(attacker.pers) && attacker.pers["team"] == self.team && !level.friendlyfire && level.teambased) && attacker != self.owner) {
    return;
  }
  if(self.health <= 0) {
    return;
  }
  damage = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(attacker, objweapon, meansofdeath, damage, self.maxhealth, 3, 4, 5);
  scripts\mp\killstreaks\killstreaks::killstreakhit(attacker, objweapon, self, meansofdeath, damage);
  attacker _id_5762AC2F22202BA2::updatedamagefeedback("");

  if(self.health - damage <= 900 && (!isDefined(self.smoking) || !self.smoking))
    self.smoking = 1;

  self vehicle_finishdamage(inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, partname);
}

_id_0EFD3004BCAA728F(dialog, players) {
  _id_CB3339ECE72DBDEB = game["dialog"][dialog];

  foreach(player in players) {
    if(isDefined(player) && scripts\cp_mp\utility\player_utility::isreallyalive(player))
      player queuedialogforplayer(_id_CB3339ECE72DBDEB, dialog, 2);
  }
}

_id_9FDF14C5AAC8CE53(dialog) {
  _id_CB3339ECE72DBDEB = game["dialog"][dialog];

  foreach(player in level.players) {
    if(!isbot(player) && isDefined(player) && scripts\cp_mp\utility\player_utility::isreallyalive(player))
      player queuedialogforplayer(_id_CB3339ECE72DBDEB, dialog, 2);
  }
}

_id_1C2BD1696D29935B(_id_FABF84450735DD93, dialog) {
  _id_CB3339ECE72DBDEB = game["dialog"][dialog];

  foreach(_id_B2810E8D06E0A042 in scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players")) {
    if(isDefined(_id_B2810E8D06E0A042) && scripts\cp_mp\utility\player_utility::isreallyalive(_id_B2810E8D06E0A042))
      _id_B2810E8D06E0A042 queuedialogforplayer(_id_CB3339ECE72DBDEB, dialog, 2);
  }
}

_id_C5F291ACF1B44B69(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(instance) || !isDefined(player)) {
    return;
  }
  player thread _id_8FC5AEAB9CB08048(instance.entity);
  instance setscriptablepartstate("dmz_exfil_site", "standby");
}

_id_3A594B90827CDE7E(_id_F90E9A2E19CBCED8, _id_3A3D1B991AC7BA41, _id_7E6513B2AE0D5C1D, _id_6B9A0DBBF039DECE) {
  _id_51941101270F867D = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85(_id_F90E9A2E19CBCED8);

  if(isDefined(_id_6B9A0DBBF039DECE))
    _id_CBFB00F6FDB0AFBA = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85(_id_6B9A0DBBF039DECE);
  else
    _id_CBFB00F6FDB0AFBA = undefined;

  if(isarray(_id_3A3D1B991AC7BA41)) {
    players = _id_3A3D1B991AC7BA41;
    _id_7AB5B649FA408138::_id_FE75A89529DD0FD0(players, _id_51941101270F867D, undefined, undefined, _id_CBFB00F6FDB0AFBA);
  } else if(isstring(_id_3A3D1B991AC7BA41)) {
    team = _id_3A3D1B991AC7BA41;
    _id_7AB5B649FA408138::_id_46979D2FD81A6D4B(team, _id_51941101270F867D, undefined, _id_CBFB00F6FDB0AFBA);
  }
}

_id_2EDA2621150BD589(players, _id_F69BA8D7B96E8326) {
  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    player setsoundsubmix("iw9_mp_dmz_exfil_fadeout", _id_F69BA8D7B96E8326);
    player._id_30DC7DFD9BE2A276 = 1;
  }

  _id_1F97A44D1761C919::_id_2C722A2EF9574E87(players, "exfil_fadeout", 120);
}

_id_B892C6B4C68C344A(players, _id_F69BA8D7B96E8326) {
  foreach(player in players) {
    player clearsoundsubmix("iw9_mp_dmz_exfil_fadeout", _id_F69BA8D7B96E8326);
    player._id_30DC7DFD9BE2A276 = undefined;
  }

  _id_1F97A44D1761C919::_id_70979C1EABF04180(players, "exfil_fadeout");
}

_id_AC66B79A73B21444(team, _id_3064FA24DBBD5BBF) {
  _id_3FE83C7FBE0F3DFC = scripts\engine\utility::array_add(scripts\mp\utility\teams::getteamdata(team, "exfils"), _id_3064FA24DBBD5BBF);
  scripts\mp\utility\teams::setteamdata(team, "exfils", _id_3FE83C7FBE0F3DFC);
}