/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_dataheist.gsc
*************************************************************/

_id_E733436716E17E49() {}

main() {
  level thread _id_566F849E77540164();
}

_id_566F849E77540164() {
  level endon("disable_public_event");
  level endon("game_ended");

  if(isDefined(level._id_034714CE799B6017) && !level._id_034714CE799B6017) {
    return;
  }
  level waittill("init_public_event");
  init();
}

init() {
  _id_BD00EBB44A0208E0 = spawnStruct();
  _id_BD00EBB44A0208E0.validatefunc = ::_id_FF2F2144CED4051A;
  _id_BD00EBB44A0208E0.waitfunc = ::_id_0259BECAE806189D;
  _id_BD00EBB44A0208E0.activatefunc = ::_id_DCE158CD5558C35D;
  _id_BD00EBB44A0208E0._id_C9E871D29702E8CF = ::_id_DE40A46BAAB733F5;
  _id_BD00EBB44A0208E0._id_0F4FD1F55EC89DED = ::_id_862BCE27F6C70842;
  _id_337BD370F7C5E6F9::registerpublicevent(8, _id_BD00EBB44A0208E0);
  _id_7AB5B649FA408138::_id_0F1AED36AB4598EA("wz_pe_dataheist");
}

_id_DE40A46BAAB733F5() {
  init_dvars(self);
  _id_6E94141D9DE9568D(self);
  level thread init_ai(self);
  _id_D9C64C99BD5F47A0();
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("br_pe_dataheist_uplink_useable", ::_id_533C18EE02139B7E);
  scripts\mp\rank::registerscoreinfo("stat_D63D75FE692BD8AA", "stat_7CE4FD9430E80CEA", 1000);
  self._id_5790067A8A484040 = [];
  self._id_5790067A8A484040[0] = "default";
  self._id_5790067A8A484040[1] = "downloading";
  self._id_5790067A8A484040[2] = "interference";
  self._id_5790067A8A484040[3] = "blocked";
}

init_dvars(_id_97F61EF86C0EAF04) {
  _id_97F61EF86C0EAF04.weight = getdvarfloat("dvar_028EF148FCD0B54A", 0);
  _id_97F61EF86C0EAF04._id_D72A1842C5B57D1D = getdvarint("dvar_46EA29E8BBED4151", 0);
  _id_97F61EF86C0EAF04._id_F0F6529C88A18128 = _id_337BD370F7C5E6F9::_id_4634160166FB7F8B("dataheist", "00 0 00 0 0 0");
  _id_97F61EF86C0EAF04._id_B9B56551E1ACFEE2 = _id_294DDA4A4B00FFE3::_id_8BE9BAE8228A91F7("dataheist");
  _id_90A9CD95EF6496B4 = getdvarint("dvar_4838B7C39021124C", 4);

  switch (_id_90A9CD95EF6496B4) {
    case 1:
      _id_97F61EF86C0EAF04._id_A1579DC24E9412DD = 50;
      _id_97F61EF86C0EAF04._id_78FD234FEBF0416A = 3;
      _id_97F61EF86C0EAF04._id_7DF9FDB99D27A28B = 4;
      break;
    case 2:
      _id_97F61EF86C0EAF04._id_A1579DC24E9412DD = 50;
      _id_97F61EF86C0EAF04._id_78FD234FEBF0416A = 3;
      _id_97F61EF86C0EAF04._id_7DF9FDB99D27A28B = 4;
      break;
    case 3:
      _id_97F61EF86C0EAF04._id_A1579DC24E9412DD = 60;
      _id_97F61EF86C0EAF04._id_78FD234FEBF0416A = 4;
      _id_97F61EF86C0EAF04._id_7DF9FDB99D27A28B = 3;
      break;
    case 4:
    default:
      _id_97F61EF86C0EAF04._id_A1579DC24E9412DD = 60;
      _id_97F61EF86C0EAF04._id_78FD234FEBF0416A = 4;
      _id_97F61EF86C0EAF04._id_7DF9FDB99D27A28B = 3;
  }

  _id_CCA5FC6C8ED8BE7F = getdvarint("dvar_193A2E0CE733E6D1", 0);

  if(_id_CCA5FC6C8ED8BE7F > -1)
    _id_97F61EF86C0EAF04._id_78FD234FEBF0416A = _id_CCA5FC6C8ED8BE7F;

  _id_97F61EF86C0EAF04._id_A1579DC24E9412DD = getdvarint("dvar_DC4CB3509E8702A4", _id_97F61EF86C0EAF04._id_A1579DC24E9412DD);
  _id_97F61EF86C0EAF04._id_7DF9FDB99D27A28B = getdvarint("dvar_6B8529AE11C8C7F6", _id_97F61EF86C0EAF04._id_7DF9FDB99D27A28B);
  _id_97F61EF86C0EAF04._id_9E852AC0876C3BBE = [0.25];
  _id_C1150641505DF131();
  _id_97F61EF86C0EAF04._id_453503008F1B0D85 = getdvarint("dvar_F1BEC911A034DCE4", 1500);
  _id_97F61EF86C0EAF04._id_ADC5129FF19A0342 = squared(_id_97F61EF86C0EAF04._id_453503008F1B0D85);
  _id_97F61EF86C0EAF04._id_CC79EC8EC36334D3 = getdvarint("dvar_3FE660588B6F40CE", 5000);
  _id_97F61EF86C0EAF04._id_A355AE253087E6EC = squared(_id_97F61EF86C0EAF04._id_CC79EC8EC36334D3);
  _id_97F61EF86C0EAF04._id_6DC1E20D4411F853 = getdvarint("dvar_63A6751A902ECAEC", 750);
  _id_97F61EF86C0EAF04._id_AD5DEFF214441F02 = getdvarint("dvar_0EBB538DE66A9395", 500);
  _id_97F61EF86C0EAF04._id_01DE3F81C4507840 = getdvarint("dvar_C70440C743BC72F1", 1) == 1;
  _id_97F61EF86C0EAF04._id_76013AA23B2588D8 = getdvarint("dvar_36DB07FD99BB9B31", 1) == 1;
  _id_97F61EF86C0EAF04._id_F2F4664F784BB1B0 = getdvarint("dvar_9EC61CFA337DC3E1", 1000);
  _id_97F61EF86C0EAF04._id_F6769D2B85AAF27E = int(max(1, getdvarint("dvar_3B2AD4CC6D705455", 300)));
  _id_97F61EF86C0EAF04._id_F25B6E5894571EB2 = _id_97F61EF86C0EAF04._id_F6769D2B85AAF27E + _id_97F61EF86C0EAF04._id_A1579DC24E9412DD;
  _id_97F61EF86C0EAF04._id_160294B506C51A7C = getdvarint("dvar_86ACA5C7CDAF36B5", 4000);
  _id_97F61EF86C0EAF04._id_C740830CDB73800E = int(max(1, getdvarint("dvar_F33906AB457ED275", 3)));
  _id_97F61EF86C0EAF04._id_5DFA1429CDDCBC96 = int(max(1, getdvarint("dvar_E87DF641AD60DFBD", 3)));
  _id_97F61EF86C0EAF04._id_00C5F1EB4D167935 = 1 / _id_97F61EF86C0EAF04._id_5DFA1429CDDCBC96;
  _id_97F61EF86C0EAF04._id_080242DC777BB3F8 = getdvarint("dvar_C70CAAFA18FE870F", 240);
  _id_97F61EF86C0EAF04._id_8B248D86225E95C5 = getdvarint("dvar_AE3EC08CD03905E0", 50);
  _id_97F61EF86C0EAF04._id_62F375887033841F = getdvarint("dvar_F63BB46F84687AAC", 500);
  _id_97F61EF86C0EAF04._id_8FAE2A4C66DA64C0 = getdvarint("dvar_8DBF9E06474B2BA7", 1) == 1;
  _id_97F61EF86C0EAF04._id_7E9FD2D078543358 = getdvarint("dvar_17B8716C1C9CA6FF", 1);
  _id_97F61EF86C0EAF04._id_D03B16E4339A4546 = getdvarint("dvar_9E246216C8AB73CD", 2);
  _id_97F61EF86C0EAF04._id_5B470C719E713BAA = getdvarint("dvar_D1254CB3A6456CD3", 3);
  _id_97F61EF86C0EAF04._id_3B2FE32897FFD722 = getdvarint("dvar_6F20A3B0BC339FCB", 2);
  _id_97F61EF86C0EAF04._id_B9F9031320C76AA6 = getdvarfloat("dvar_743F2AAFCE01B00D", 0.4);
  _id_97F61EF86C0EAF04._id_464FF1EF779C439D = getdvarint("dvar_8A328FC0A8B887E4", 8);
  _id_97F61EF86C0EAF04._id_4FEBD27038048FFB = getdvarint("dvar_89E40BCFF5370F82", 120);
  _id_97F61EF86C0EAF04._id_94B952789D039ABB = getdvarint("dvar_005B21ED44F9D400", 1) == 1;
}

_id_C1150641505DF131() {
  _id_F087E13B64FB79CA = getDvar("dvar_4675782A74D204DC");

  if(isDefined(_id_F087E13B64FB79CA) && _id_F087E13B64FB79CA != "") {
    _id_4976EAFAD6C14C36 = [];
    _id_67F14F8315CB0F2F = strtok(_id_F087E13B64FB79CA, ",", 0);

    foreach(_id_E921CD2D3FB29B66 in _id_67F14F8315CB0F2F) {
      threshold = float(_id_E921CD2D3FB29B66);

      if(!isfloat(threshold)) {
        continue;
      }
      _id_4976EAFAD6C14C36[_id_4976EAFAD6C14C36.size] = threshold;
    }

    if(_id_4976EAFAD6C14C36.size > 0)
      self._id_9E852AC0876C3BBE = _id_4976EAFAD6C14C36;
  }
}

_id_6E94141D9DE9568D(_id_97F61EF86C0EAF04) {
  _id_ADABC9F186B54E6A = [];
  id = 0;
  _id_EE2CFBB2D478E835 = scripts\engine\utility::getStructArray("dataheist_uplink_location", "script_noteworthy");

  foreach(struct in _id_EE2CFBB2D478E835) {
    _id_ADABC9F186B54E6A = scripts\engine\utility::array_add(_id_ADABC9F186B54E6A, _id_C82760FFF0DC45DF(struct.origin, struct.angles, struct.group, id));
    id++;
  }

  if(_id_ADABC9F186B54E6A.size <= 0) {
    switch (level.mapname) {
      case "mp_br_hms_mechanics":
      case "mp_br_mechanics":
        _id_ADABC9F186B54E6A = scripts\engine\utility::array_add(_id_ADABC9F186B54E6A, _id_C82760FFF0DC45DF((-471, -1886, 25), (0, 180, 0), "none", 0));
        _id_ADABC9F186B54E6A = scripts\engine\utility::array_add(_id_ADABC9F186B54E6A, _id_C82760FFF0DC45DF((-367, -811, 25), (0, 180, 0), "none", 1));
        _id_ADABC9F186B54E6A = scripts\engine\utility::array_add(_id_ADABC9F186B54E6A, _id_C82760FFF0DC45DF((704, -2767, 25), (0, 270, 0), "none", 2));
        _id_ADABC9F186B54E6A = scripts\engine\utility::array_add(_id_ADABC9F186B54E6A, _id_C82760FFF0DC45DF((1970, -4096, 25), (0, 270, 0), "none", 3));
        _id_ADABC9F186B54E6A = scripts\engine\utility::array_add(_id_ADABC9F186B54E6A, _id_C82760FFF0DC45DF((3077, -2300, 25), (0, 180, 0), "none", 4));
        _id_ADABC9F186B54E6A = scripts\engine\utility::array_add(_id_ADABC9F186B54E6A, _id_C82760FFF0DC45DF((2935, 59, 25), (0, 0, 0), "none", 5));
        _id_ADABC9F186B54E6A = scripts\engine\utility::array_add(_id_ADABC9F186B54E6A, _id_C82760FFF0DC45DF((5015, -674, 25), (0, 0, 0), "none", 6));
        break;
    }
  }

  _id_97F61EF86C0EAF04._id_ADABC9F186B54E6A = _id_ADABC9F186B54E6A;
}

_id_C82760FFF0DC45DF(origin, angles, group, id) {
  point = spawnStruct();
  point.origin = origin;
  point.angles = angles;
  point.group = group;
  point.id = id;

  if(!isDefined(group))
    point.group = "none";

  if(!isDefined(id))
    id = -1;

  point.used = 0;
  point._id_3EA06EB9EC84616C = 0;
  point._id_927206BDB3F7000D = [];
  return point;
}

init_ai(_id_97F61EF86C0EAF04) {
  level endon("game_ended");

  if(_id_97F61EF86C0EAF04._id_78FD234FEBF0416A < 1) {
    return;
  }
  _id_48814951E916AF89::_id_2FC80954FA70D153();
  _id_48814951E916AF89::_id_BA4022744DCE59F6("dataheist", _id_97F61EF86C0EAF04._id_8B248D86225E95C5);
  _id_252FA7D2B1B1B50B::_id_B146E2B40516B668("dataheist");
}

_id_D9C64C99BD5F47A0() {
  game["dialog"]["dataheist_event_start"] = "dths_wzan_dhes";
  game["dialog"]["dataheist_comp_success"] = "dths_wzan_dhcs";
  game["dialog"]["dataheist_comp_failure"] = "dths_wzan_dhcf";
  game["dialog"]["dataheist_team_act_uplink"] = "dths_wzan_dhtu";
  game["dialog"]["dataheist_enemy_act_uplink"] = "dths_wzan_dheu";
  game["dialog"]["dataheist_enemy_cap_uplink"] = "dths_wzan_dhec";
  game["dialog"]["dataheist_team_cap_uplink"] = "dths_wzan_dhtc";
  game["dialog"]["dataheist_ai_spawn"] = "dths_wzan_dhai";
  game["dialog"]["dataheist_enemy_block_down"] = "dths_wzan_dhef";
  game["dialog"]["dataheist_out_range"] = "dths_wzan_dhor";
  game["dialog"]["dataheist_team_comp_uplink"] = "dths_wzan_dtup";
  game["dialog"]["dataheist_enemy_comp_uplink"] = "dths_wzan_esin";
  game["dialog"]["dataheist_enemy_comp_lost_uplink"] = "dths_wzan_deup";
  game["dialog"]["dataheist_time_warn"] = "dths_wzan_dtwn";
}

_id_23B03B3F109AB44D() {}

_id_FF2F2144CED4051A() {
  if(!scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414())
    return 0;

  if(scripts\cp_mp\utility\game_utility::_id_6C1FCE6F6B8779D5() != "resurgence")
    return 0;

  return 1;
}

_id_0259BECAE806189D() {}

_id_DCE158CD5558C35D() {
  self endon("event_deactivated");
  self._id_8D20F50B331DB1F5 = [];
  self._id_FA407070D9AB9ADA = [];
  thread _id_CDB11D6D4CE247EA();
  _id_337BD370F7C5E6F9::showsplashtoall("br_pe_dataheist_start", "splash_list_br_pe_dataheist");
  setomnvar("ui_publicevent_minimap_pulse", 1);
  setomnvar("ui_publicevent_timer_type", 6);
  _id_F6769D2B85AAF27E = self._id_F6769D2B85AAF27E;

  if(!level.br_circle_disabled)
    _id_F6769D2B85AAF27E = min(self._id_F6769D2B85AAF27E, _id_2695A20D4011076D::_id_ABBFB4D18D1A9CA7() - 5);

  self.end_time = gettime() + _id_F6769D2B85AAF27E * 1000;
  self.warning_time = self.end_time - 30000;
  setomnvar("ui_publicevent_timer", self.end_time);
  _id_24AFCBB2EA0CCB49(_id_F6769D2B85AAF27E);
  _id_2F1F2BD8531E8866 = getDvar("dvar_8326C0FB793FFE45", "");
  _id_11CB71DBFD7F944E = _id_671CC803581D0E65(_id_2F1F2BD8531E8866);
  points = [];

  if(_id_11CB71DBFD7F944E.size > 0) {
    foreach(_id_CC5B761AD372767A in _id_11CB71DBFD7F944E)
    points[points.size] = self._id_ADABC9F186B54E6A[_id_CC5B761AD372767A];
  } else {
    _id_FF9E6FBB61B45590 = _id_45A890C985D26276();

    if(_id_FF9E6FBB61B45590.size <= 0) {
      level thread _id_337BD370F7C5E6F9::_id_2907D01A7D692108(8);
      return;
    }

    points[0] = scripts\engine\utility::random(_id_FF9E6FBB61B45590);
    _id_6906D84DB2A3BC80 = scripts\engine\utility::array_randomize(points[0]._id_927206BDB3F7000D);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self._id_C740830CDB73800E - 1; _id_AC0E594AC96AA3A8++)
      points[_id_AC0E594AC96AA3A8 + 1] = _id_6906D84DB2A3BC80[_id_AC0E594AC96AA3A8];
  }

  foreach(point in points)
  thread _id_E2125C5400CC5BF3(point);

  self.midpoint = (0, 0, 0);

  foreach(point in points)
  self.midpoint = self.midpoint + point.origin;

  self.midpoint = self.midpoint / points.size;
  _id_C27AA5EDD70A0762 = 0;

  foreach(point in points) {
    _id_ABD9EE4725B96FC2 = distance2dsquared(self.midpoint, point.origin);

    if(_id_ABD9EE4725B96FC2 > _id_C27AA5EDD70A0762)
      _id_C27AA5EDD70A0762 = _id_ABD9EE4725B96FC2;
  }

  self._id_59EA6B2EF4905653 = sqrt(_id_C27AA5EDD70A0762) + self._id_F2F4664F784BB1B0;

  if(self._id_01DE3F81C4507840) {
    circle_radius = max(sqrt(_id_C27AA5EDD70A0762) + 250, self._id_160294B506C51A7C);
    self._id_09852072496D7F7E = _func_DC11C1CAFFE56E16("Dataheist_Br", self.midpoint[0], self.midpoint[1], circle_radius, undefined);
    self._id_09852072496D7F7E show();

    if(self._id_F2F4664F784BB1B0 > self._id_6DC1E20D4411F853)
      thread _id_54539D559ADC405C();

    if(self._id_76013AA23B2588D8)
      thread _id_E6B8718FAA7F2EDF();
  }

  _id_48814951E916AF89::_id_93ADD0B65DB9F722(::_id_60FDECEEA0C7A20E);
  thread _id_2B9E294B137A88D1();
  thread _id_518AF9F5C4BCDE52(_id_F6769D2B85AAF27E - 30);

  if(self._id_94B952789D039ABB)
    thread _id_E86F6C7B0F5447E2();

  _id_E8CE5F018D2B942C("dataheist_event_start", 1.0);
  scripts\engine\utility::waittill_any_timeout_1(_id_F6769D2B85AAF27E, "all_uplinks_complete");
  winners = [];
  _id_93B3B06A17CC437B = [];

  foreach(player in level.players) {
    if(_id_8D72849F49068945(player.team) > 0) {
      winners[winners.size] = player;
      continue;
    }

    _id_93B3B06A17CC437B[_id_93B3B06A17CC437B.size] = player;
  }

  _id_63BDBC18191BE5F9("dataheist_comp_success", winners, 0.5);
  _id_63BDBC18191BE5F9("dataheist_comp_failure", _id_93B3B06A17CC437B, 0.5);
  level thread _id_337BD370F7C5E6F9::_id_2907D01A7D692108(8);
}

_id_862BCE27F6C70842() {
  _id_337BD370F7C5E6F9::showsplashtoall("br_pe_dataheist_end", "splash_list_br_pe_dataheist");
  _id_48814951E916AF89::_id_66A6064FAD612BF3(::_id_60FDECEEA0C7A20E);

  if(isDefined(self._id_09852072496D7F7E))
    self._id_09852072496D7F7E delete();

  foreach(_id_DC3EDBF6042EE344 in self._id_8D20F50B331DB1F5)
  _id_DC3EDBF6042EE344 _id_CDB8EA404983A187();

  self._id_8D20F50B331DB1F5 = undefined;
  self._id_FA407070D9AB9ADA = undefined;
  setomnvar("ui_publicevent_minimap_pulse", 0);
  setomnvar("ui_publicevent_timer_type", 0);
  self notify("event_deactivated");
}

_id_2B9E294B137A88D1() {
  level endon("game_ended");
  self endon("event_deactivated");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self._id_8D20F50B331DB1F5.size; _id_AC0E594AC96AA3A8++)
    self waittill("uplink_complete");

  self notify("all_uplinks_complete");
}

_id_518AF9F5C4BCDE52(time) {
  level endon("game_ended");
  self endon("event_deactivated");
  wait(time);
  nearby_players = scripts\mp\utility\player::getplayersinradius(self.midpoint, self._id_59EA6B2EF4905653);
  _id_63BDBC18191BE5F9("dataheist_time_warn", nearby_players);
}

_id_54539D559ADC405C() {
  level endon("game_ended");
  self endon("event_deactivated");

  for(;;) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self._id_8D20F50B331DB1F5.size; _id_AC0E594AC96AA3A8++) {
      _id_DC3EDBF6042EE344 = self._id_8D20F50B331DB1F5[_id_AC0E594AC96AA3A8];
      _id_DC3EDBF6042EE344.nearby_players = scripts\mp\utility\player::getplayersinradius(_id_DC3EDBF6042EE344.origin, self._id_F2F4664F784BB1B0);

      foreach(player in _id_DC3EDBF6042EE344.nearby_players) {
        if(isDefined(player.team) && !scripts\engine\utility::array_contains_key(_id_DC3EDBF6042EE344._id_CF3B62C466FC43BB, player.team)) {
          _id_DC3EDBF6042EE344._id_CF3B62C466FC43BB[player.team] = 1;

          if(isDefined(_id_DC3EDBF6042EE344.obj_id))
            objective_addteamtomask(_id_DC3EDBF6042EE344.obj_id, player.team);
        }
      }

      wait 1;
    }
  }
}

_id_E6B8718FAA7F2EDF() {
  level endon("game_ended");
  self endon("event_deactivated");
  _id_5902F65B650F4A55 = 0;

  while(_id_5902F65B650F4A55 < self._id_8D20F50B331DB1F5.size) {
    self waittill("uplink_reveal", _id_DC3EDBF6042EE344);
    _id_5902F65B650F4A55++;

    foreach(team, data in level.teamdata) {
      if(isDefined(team) && !scripts\engine\utility::array_contains_key(_id_DC3EDBF6042EE344._id_CF3B62C466FC43BB, team)) {
        _id_DC3EDBF6042EE344._id_CF3B62C466FC43BB[team] = 1;

        if(isDefined(_id_DC3EDBF6042EE344.obj_id))
          objective_addteamtomask(_id_DC3EDBF6042EE344.obj_id, team);
      }
    }
  }

  self._id_09D8C59410245296 = 1;
}

_id_2F06F510AFF6C900(team) {
  if(istrue(self._id_09D8C59410245296)) {
    return;
  }
  foreach(_id_DC3EDBF6042EE344 in self._id_8D20F50B331DB1F5) {
    if(!scripts\engine\utility::array_contains_key(_id_DC3EDBF6042EE344._id_CF3B62C466FC43BB, team)) {
      _id_DC3EDBF6042EE344._id_CF3B62C466FC43BB[team] = 1;

      if(isDefined(_id_DC3EDBF6042EE344.obj_id))
        objective_addteamtomask(_id_DC3EDBF6042EE344.obj_id, team);
    }
  }
}

_id_CDB11D6D4CE247EA() {
  level endon("game_ended");
  self endon("event_deactivated");
  level waittill("cancel_public_event");
  _id_862BCE27F6C70842();
}

_id_DA3599E311B1241A(team) {
  if(isDefined(self._id_FA407070D9AB9ADA[team]))
    self._id_FA407070D9AB9ADA[team]++;
  else
    self._id_FA407070D9AB9ADA[team] = 1;

  _id_C96877A325B94330 = "";

  switch (self._id_FA407070D9AB9ADA[team]) {
    case 1:
      _id_C96877A325B94330 = "stat_0CFDDC35E5F58E75";
      break;
    case 2:
      _id_C96877A325B94330 = "stat_0CFDD935E5F5895C";
      break;
    case 3:
    default:
      _id_C96877A325B94330 = "stat_0CFDDA35E5F58B0F";
  }

  _id_BBCF436A8958AC11 = scripts\mp\utility\teams::getteamdata(team, "players");
  _id_88846AEEF1F75A50 = 0;

  foreach(player in _id_BBCF436A8958AC11) {
    if(!player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag()) {
      if(!_id_88846AEEF1F75A50) {
        player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_D63D75FE692BD8AA");
        _id_88846AEEF1F75A50 = 1;
      }

      player thread scripts\mp\utility\points::_id_0366980B6A8796AE(_id_C96877A325B94330);
    }
  }
}

_id_8D72849F49068945(team) {
  if(isDefined(self._id_FA407070D9AB9ADA[team]))
    return self._id_FA407070D9AB9ADA[team];
  else
    return 0;
}

_id_60FDECEEA0C7A20E(agent, attacker) {
  self endon("event_deactivated");
  category = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "category");

  if(!scripts\engine\utility::is_equal("dataheist", category)) {
    return;
  }
  if(!isDefined(attacker) || !isPlayer(attacker)) {
    return;
  }
  if(isDefined(self._id_8D20F50B331DB1F5)) {
    foreach(_id_DC3EDBF6042EE344 in self._id_8D20F50B331DB1F5) {
      if(_id_DC3EDBF6042EE344._id_80A0D80CF59CB4B1) {
        continue;
      }
      if(attacker.team == _id_DC3EDBF6042EE344._id_6BCB8569EF76541A && scripts\engine\utility::array_contains(_id_DC3EDBF6042EE344.agents, agent))
        _id_DC3EDBF6042EE344 _id_05E4D7FF52575526(self._id_7DF9FDB99D27A28B);
    }
  }
}

_id_E86F6C7B0F5447E2() {
  level endon("game_ended");
  wait 5.0;

  foreach(player in level.players) {
    if(isalive(player) && !player _id_2CEDCC356F1B9FC8::isplayeringulag())
      player _id_21C19CFC7139D773::_id_1976438A8865AC27("br_ftue_dataheist");
  }
}

_id_57F7776E835D33B2() {}

_id_E2125C5400CC5BF3(_id_26E940F5841AB19D) {
  level endon("game_ended");
  self endon("event_deactivated");
  _id_26E940F5841AB19D.used = 1;
  _id_DC3EDBF6042EE344 = spawnStruct();
  _id_DC3EDBF6042EE344.event = self;
  self._id_8D20F50B331DB1F5[self._id_8D20F50B331DB1F5.size] = _id_DC3EDBF6042EE344;
  _id_DC3EDBF6042EE344._id_80A0D80CF59CB4B1 = 0;
  _id_DC3EDBF6042EE344._id_1987381AD16D054C = 0;
  _id_DC3EDBF6042EE344._id_FE1D54BCB3C5043B = 0;
  _id_DC3EDBF6042EE344._id_A5D01C9B7F5297AF = 0;
  _id_DC3EDBF6042EE344.time = 0.0;
  _id_DC3EDBF6042EE344.progress = 0.0;
  _id_DC3EDBF6042EE344._id_6BCB8569EF76541A = "None";
  _id_DC3EDBF6042EE344.origin = _id_26E940F5841AB19D.origin;
  _id_DC3EDBF6042EE344.angles = _id_26E940F5841AB19D.angles;
  _id_DC3EDBF6042EE344.agents = [];
  _id_DC3EDBF6042EE344._id_CF3B62C466FC43BB = [];
  _id_DC3EDBF6042EE344._id_EDE20A7B50019DAB = 0;
  _id_DC3EDBF6042EE344._id_A5D01C9B7F5297AF = 0;
  _id_DC3EDBF6042EE344._id_FE1D54BCB3C5043B = 0;
  _id_DC3EDBF6042EE344._id_F64E221D661E7341 = "Uplink #" + _id_26E940F5841AB19D.id + " @ " + _id_26E940F5841AB19D.group;
  _id_DC3EDBF6042EE344._id_AA83C2DDC32095ED = self._id_A1579DC24E9412DD;
  _id_DC3EDBF6042EE344._id_A515D13BFDCB33F1 = [];
  _id_DC3EDBF6042EE344.obj_id = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  _id_DC3EDBF6042EE344.trigger = spawn("trigger_radius", _id_DC3EDBF6042EE344.origin - (0, 0, self._id_AD5DEFF214441F02 * 0.5), 0, self._id_6DC1E20D4411F853, self._id_AD5DEFF214441F02);
  _id_DC3EDBF6042EE344.trigger._id_DC3EDBF6042EE344 = _id_DC3EDBF6042EE344;
  _id_DC3EDBF6042EE344._id_4C25F559CCCBAADA = [];
  _id_DC3EDBF6042EE344 thread _id_2BB37C482DE07FD3();
  _id_DC3EDBF6042EE344._id_4C42AC43DDE49B92 = 0;
  scripts\cp_mp\emp_debuff::add_emp_ent(_id_DC3EDBF6042EE344.trigger);
  _id_DC3EDBF6042EE344.trigger scripts\cp_mp\emp_debuff::set_start_emp_callback(::_id_88A9CE111608764A);
  _id_DC3EDBF6042EE344.trigger scripts\cp_mp\emp_debuff::set_clear_emp_callback(::_id_635613A90782EE9B);
  _id_DC3EDBF6042EE344.scriptable = spawnscriptable("br_pe_dataheist_uplink", _id_DC3EDBF6042EE344.origin, _id_DC3EDBF6042EE344.angles);
  _id_DC3EDBF6042EE344.scriptable._id_DC3EDBF6042EE344 = _id_DC3EDBF6042EE344;

  if(self._id_78FD234FEBF0416A > 0) {
    _id_DD4F509B9C56C76F = _id_E27B61F74DFBA712(self._id_78FD234FEBF0416A);
    _id_DC3EDBF6042EE344 thread _id_3723563CAD2EB687(_id_DD4F509B9C56C76F, ["heli", "para", "safe"], _id_27BA596AAFA69F39(1));
  }

  scripts\mp\objidpoolmanager::objective_add_objective(_id_DC3EDBF6042EE344.obj_id, "current", _id_DC3EDBF6042EE344.origin + (0, 0, 15), "ui_map_icon_obj_dataheist_uplink");

  if(self._id_01DE3F81C4507840) {
    objective_removeallfrommask(_id_DC3EDBF6042EE344.obj_id);
    objective_showtoplayersinmask(_id_DC3EDBF6042EE344.obj_id);
  }

  objective_setdescription(_id_DC3EDBF6042EE344.obj_id, &"MP_BR_PE_DATAHEIST/NAME");
  objective_setbackground(_id_DC3EDBF6042EE344.obj_id, 6);
  _id_DC3EDBF6042EE344 waittill("activated", team);
  self notify("uplink_reveal", _id_DC3EDBF6042EE344);
  _id_DC3EDBF6042EE344.scriptable setscriptablepartstate("br_pe_dataheist_uplink_useable", "active");
  _id_DC3EDBF6042EE344._id_1987381AD16D054C = 1;
  objective_setshowprogress(_id_DC3EDBF6042EE344.obj_id, 1);

  foreach(player in level.players)
  objective_showprogressforclient(_id_DC3EDBF6042EE344.obj_id, player);

  foreach(ent in _id_DC3EDBF6042EE344._id_4C25F559CCCBAADA) {
    if(isPlayer(ent))
      objective_hideprogressforclient(_id_DC3EDBF6042EE344.obj_id, ent);
  }

  _id_DC3EDBF6042EE344 _id_06FC077E1F039CF7(team);
  nearby_players = _id_2A43E356ECD267C7(_id_DC3EDBF6042EE344._id_6BCB8569EF76541A);
  _id_63BDBC18191BE5F9("dataheist_team_act_uplink", nearby_players, 2);
  nearby_players = _id_F8CD8B690A39BEC2(_id_DC3EDBF6042EE344._id_6BCB8569EF76541A);
  _id_63BDBC18191BE5F9("dataheist_enemy_act_uplink", nearby_players, 2);
  nearby_players = undefined;
  _id_DC3EDBF6042EE344 childthread _id_F5B8C7D6BB6609C4();
  _id_DC3EDBF6042EE344 childthread _id_DB1CE4CD12DD95D5();

  if(self._id_78FD234FEBF0416A > 0)
    _id_DC3EDBF6042EE344 childthread _id_6314BC0655F4A7C9(self._id_9E852AC0876C3BBE);

  _id_2D2B1231F2F50CF3 = _id_DC3EDBF6042EE344._id_EDE20A7B50019DAB;
  _id_DC3EDBF6042EE344.scriptable setscriptablepartstate("br_pe_dataheist_uplink_screen", self._id_5790067A8A484040[_id_DC3EDBF6042EE344._id_EDE20A7B50019DAB]);
  _id_D13206C3844D8288 = 0.25;
  _id_6C602B41960A6297 = gettime() + 5000;
  _id_234548A5923400D2 = -1;
  _id_836160B8B34BC69A = gettime() + 5000;
  _id_B1DA730A8BF61935 = -1;

  while(_id_DC3EDBF6042EE344.time < _id_DC3EDBF6042EE344._id_AA83C2DDC32095ED) {
    time = gettime();

    if(!_id_DC3EDBF6042EE344._id_A5D01C9B7F5297AF)
      _id_DC3EDBF6042EE344._id_EDE20A7B50019DAB = 0;
    else if(_id_DC3EDBF6042EE344._id_4C42AC43DDE49B92 || _id_DC3EDBF6042EE344._id_FE1D54BCB3C5043B >= self._id_5DFA1429CDDCBC96)
      _id_DC3EDBF6042EE344._id_EDE20A7B50019DAB = 3;
    else if(_id_DC3EDBF6042EE344._id_FE1D54BCB3C5043B > 0)
      _id_DC3EDBF6042EE344._id_EDE20A7B50019DAB = 2;
    else
      _id_DC3EDBF6042EE344._id_EDE20A7B50019DAB = 1;

    if(_id_DC3EDBF6042EE344._id_EDE20A7B50019DAB != _id_2D2B1231F2F50CF3) {
      foreach(ent in _id_DC3EDBF6042EE344._id_4C25F559CCCBAADA) {
        if(isPlayer(ent))
          ent setclientomnvar("resurgence_dataheist_state", _id_DC3EDBF6042EE344._id_EDE20A7B50019DAB);
      }

      if(_id_DC3EDBF6042EE344._id_EDE20A7B50019DAB == 0)
        _id_234548A5923400D2 = gettime() + 10000;
      else
        _id_234548A5923400D2 = -1;

      if(_id_DC3EDBF6042EE344._id_EDE20A7B50019DAB > 1)
        _id_B1DA730A8BF61935 = gettime() + 6000;
      else
        _id_B1DA730A8BF61935 = -1;

      _id_2D2B1231F2F50CF3 = _id_DC3EDBF6042EE344._id_EDE20A7B50019DAB;
      _id_DC3EDBF6042EE344.scriptable setscriptablepartstate("br_pe_dataheist_uplink_screen", self._id_5790067A8A484040[_id_DC3EDBF6042EE344._id_EDE20A7B50019DAB]);
    }

    if(_id_234548A5923400D2 > 0) {
      if(time > _id_234548A5923400D2 && time > _id_6C602B41960A6297) {
        _id_6C602B41960A6297 = time + 30000;
        _id_E0A7E2154A8C2F62 = _id_DC3EDBF6042EE344 _id_0AEB8753295C3577(_id_DC3EDBF6042EE344._id_6BCB8569EF76541A);
        _id_63BDBC18191BE5F9("dataheist_out_range", _id_E0A7E2154A8C2F62);
        _id_234548A5923400D2 = -1;
      }
    } else if(_id_B1DA730A8BF61935 > 0) {
      if(time > _id_B1DA730A8BF61935 && time > _id_836160B8B34BC69A) {
        _id_836160B8B34BC69A = time + 30000;
        _id_E0A7E2154A8C2F62 = _id_DC3EDBF6042EE344 _id_0AEB8753295C3577(_id_DC3EDBF6042EE344._id_6BCB8569EF76541A);
        _id_63BDBC18191BE5F9("dataheist_enemy_block_down", _id_E0A7E2154A8C2F62);
      }
    }

    if(_id_DC3EDBF6042EE344._id_A5D01C9B7F5297AF && !_id_DC3EDBF6042EE344._id_4C42AC43DDE49B92) {
      scale = (time - self.warning_time) / (self.end_time - self.warning_time);
      scale = clamp(scale, 0, 1);
      _id_16B27ED58761766D = 3 * scale + 1;
      _id_2F977E27FA739602 = _id_D13206C3844D8288 * _id_16B27ED58761766D;
      _id_DC3EDBF6042EE344 _id_05E4D7FF52575526((1 - min(1, self._id_00C5F1EB4D167935 * _id_DC3EDBF6042EE344._id_FE1D54BCB3C5043B)) * _id_2F977E27FA739602);
    }

    wait(_id_D13206C3844D8288);
  }

  _id_DC3EDBF6042EE344.scriptable setscriptablepartstate("br_pe_dataheist_uplink_screen", "complete");
  _id_DC3EDBF6042EE344.scriptable setscriptablepartstate("br_pe_dataheist_uplink_useable", "complete");
  _id_DA3599E311B1241A(_id_DC3EDBF6042EE344._id_6BCB8569EF76541A);
  _id_DC3EDBF6042EE344.scriptable _id_358DE5CAA85AABF7();

  foreach(player in _id_DC3EDBF6042EE344._id_72495D8D02F97943)
  player thread _id_DDFC2513FFDC4DDC();

  if(_id_DC3EDBF6042EE344.obj_id != -1) {
    scripts\mp\objidpoolmanager::returnobjectiveid(_id_DC3EDBF6042EE344.obj_id);
    _id_DC3EDBF6042EE344.obj_id = undefined;
  }

  nearby_players = _id_F3167A32A9D8B1E8();
  winners = [];
  _id_93B3B06A17CC437B = [];
  _id_BD1E3580BA157785 = [];

  foreach(player in nearby_players) {
    if(player.team == _id_DC3EDBF6042EE344._id_6BCB8569EF76541A) {
      winners[winners.size] = player;
      continue;
    }

    if(isDefined(_id_DC3EDBF6042EE344._id_A515D13BFDCB33F1[player.team])) {
      _id_93B3B06A17CC437B[_id_93B3B06A17CC437B.size] = player;
      continue;
    }

    _id_BD1E3580BA157785[_id_BD1E3580BA157785.size] = player;
  }

  _id_DC3EDBF6042EE344.scriptable thread _id_A52DEF3D6B40207A(winners);
  _id_DC3EDBF6042EE344._id_80A0D80CF59CB4B1 = 1;
  _id_DC3EDBF6042EE344 notify("complete");
  self notify("uplink_complete");
  _id_2F06F510AFF6C900(_id_DC3EDBF6042EE344._id_6BCB8569EF76541A);
  wait 1.0;
  _id_63BDBC18191BE5F9("dataheist_team_comp_uplink", winners, 2);

  foreach(player in winners)
  player scripts\mp\hud_message::showsplash("br_pe_dataheist_success", undefined, undefined, undefined, undefined, "splash_list_br_pe_dataheist");

  _id_63BDBC18191BE5F9("dataheist_enemy_comp_lost_uplink", _id_93B3B06A17CC437B, 2);
  _id_63BDBC18191BE5F9("dataheist_enemy_comp_uplink", _id_BD1E3580BA157785, 2);
  _id_DC3EDBF6042EE344 _id_CDB8EA404983A187();
}

_id_05E4D7FF52575526(_id_2F977E27FA739602) {
  self.time = self.time + _id_2F977E27FA739602;
  self.progress = min(1.0, self.time / self._id_AA83C2DDC32095ED);

  if(isDefined(self.obj_id))
    objective_setprogress(self.obj_id, self.progress);

  foreach(ent in self._id_4C25F559CCCBAADA) {
    if(isPlayer(ent))
      ent setclientomnvar("resurgence_dataheist_progress", self.progress);
  }
}

_id_F5B8C7D6BB6609C4() {
  self endon("complete");

  for(;;) {
    self waittill("activated", team);

    if(team == self._id_6BCB8569EF76541A) {
      continue;
    }
    nearby_players = self.event _id_2A43E356ECD267C7(self._id_6BCB8569EF76541A);
    _id_63BDBC18191BE5F9("dataheist_enemy_cap_uplink", nearby_players, 2);

    foreach(player in nearby_players)
    player scripts\mp\hud_message::showsplash("br_pe_dataheist_stolen", undefined, undefined, undefined, undefined, "splash_list_br_pe_dataheist");

    _id_06FC077E1F039CF7(team);
    nearby_players = self.event _id_2A43E356ECD267C7(self._id_6BCB8569EF76541A);
    _id_63BDBC18191BE5F9("dataheist_team_cap_uplink", nearby_players, 2);
  }
}

_id_88A9CE111608764A(data) {
  if(data.attacker.team == self._id_DC3EDBF6042EE344._id_6BCB8569EF76541A) {
    return;
  }
  self._id_DC3EDBF6042EE344._id_4C42AC43DDE49B92 = 1;
}

_id_635613A90782EE9B(_id_0C0B7B6772CD99B0) {
  self._id_DC3EDBF6042EE344._id_4C42AC43DDE49B92 = 0;
}

_id_DB1CE4CD12DD95D5() {
  self endon("complete");

  for(;;) {
    self._id_A5D01C9B7F5297AF = 0;
    self._id_FE1D54BCB3C5043B = 0;

    foreach(ent in self._id_4C25F559CCCBAADA) {
      if(ent scripts\common\vehicle::isvehicle()) {
        continue;
      }
      if(isDefined(ent.team) && ent.team == self._id_6BCB8569EF76541A) {
        self._id_A5D01C9B7F5297AF = 1;
        continue;
      }

      self._id_FE1D54BCB3C5043B++;
    }

    waitframe();
  }
}

_id_6314BC0655F4A7C9(_id_0AEA828AB13B354B) {
  event = self.event;

  foreach(progress in _id_0AEA828AB13B354B) {
    while(self.progress < progress)
      wait 1.0;

    _id_DD4F509B9C56C76F = undefined;
    _id_1FFC02522D731E6E = _id_74428D38B94D6664();

    if(istrue(event._id_8FAE2A4C66DA64C0) && _id_1FFC02522D731E6E < event._id_5B470C719E713BAA) {
      _id_148E19647354D724 = int(min(event._id_5B470C719E713BAA - _id_1FFC02522D731E6E, event._id_D03B16E4339A4546)) + 1;
      _id_DD4F509B9C56C76F = _id_016460A9DABA16A6(event._id_78FD234FEBF0416A, randomintrange(event._id_7E9FD2D078543358, _id_148E19647354D724), event._id_3B2FE32897FFD722);
    } else
      _id_DD4F509B9C56C76F = _id_E27B61F74DFBA712(event._id_78FD234FEBF0416A);

    thread _id_3723563CAD2EB687(_id_DD4F509B9C56C76F, ["safe", "para"], _id_27BA596AAFA69F39(0));
    _id_63BDBC18191BE5F9("dataheist_ai_spawn", self.nearby_players, 5);
  }
}

_id_06FC077E1F039CF7(team) {
  self.scriptable _id_AE84023E1DBB45F3(team);
  self._id_6BCB8569EF76541A = team;
  self._id_72495D8D02F97943 = scripts\mp\utility\teams::getteamdata(team, "players");

  if(!isDefined(self._id_A515D13BFDCB33F1[team]))
    self._id_A515D13BFDCB33F1[team] = 1;

  foreach(player in self._id_72495D8D02F97943)
  player scripts\mp\hud_message::showsplash("br_pe_dataheist_defend", undefined, undefined, undefined, undefined, "splash_list_br_pe_dataheist");

  foreach(ent in self._id_4C25F559CCCBAADA) {
    if(isPlayer(ent)) {
      if(ent.team == self._id_6BCB8569EF76541A) {
        _id_B2588B08AD6F485B(ent);
        continue;
      }

      _id_E232769E6EA189CA(ent);
    }
  }

  if(isDefined(self.obj_id))
    objective_setprogressteam(self.obj_id, self._id_6BCB8569EF76541A);
}

_id_CDB8EA404983A187() {
  foreach(ent in self._id_4C25F559CCCBAADA) {
    if(isPlayer(ent)) {
      ent setclientomnvar("resurgence_dataheist_state", 0);
      ent setclientomnvar("resurgence_dataheist_progress", 0);
    }
  }

  if(isDefined(self._id_09852072496D7F7E))
    self._id_09852072496D7F7E delete();

  if(!self._id_80A0D80CF59CB4B1 && isDefined(self.scriptable))
    self.scriptable freescriptable();

  if(isDefined(self.obj_id) && self.obj_id != -1)
    scripts\mp\objidpoolmanager::returnobjectiveid(self.obj_id);

  if(isDefined(self.trigger)) {
    self.trigger notify("destroy");
    self.trigger delete();
  }

  self notify("cleanup");
}

_id_2BB37C482DE07FD3() {
  level endon("game_ended");
  self endon("cleanup");

  while(isDefined(self.trigger)) {
    self.trigger waittill("trigger", ent);
    _id_CFCE1656415DAE16 = ent getentitynumber();

    if(isDefined(self._id_4C25F559CCCBAADA[_id_CFCE1656415DAE16])) {
      continue;
    }
    if(!isPlayer(ent) && !isagent(ent) && !ent scripts\common\vehicle::isvehicle()) {
      continue;
    }
    if(ent scripts\common\vehicle::isvehicle()) {
      occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(ent);

      foreach(_id_F85572CD5F6117C6 in occupants) {
        if(isPlayer(_id_F85572CD5F6117C6) || isagent(_id_F85572CD5F6117C6)) {
          _id_7D47A1BF7F608636 = _id_F85572CD5F6117C6 getentitynumber();

          if(isDefined(self._id_4C25F559CCCBAADA[_id_7D47A1BF7F608636])) {
            continue;
          }
          self._id_4C25F559CCCBAADA[_id_7D47A1BF7F608636] = _id_F85572CD5F6117C6;
          _id_F85572CD5F6117C6 thread _id_0191978F898963A8(self);
        }
      }

      continue;
    }

    self._id_4C25F559CCCBAADA[_id_CFCE1656415DAE16] = ent;
    ent thread _id_0191978F898963A8(self);
  }
}

_id_0191978F898963A8(_id_DC3EDBF6042EE344) {
  level endon("game_ended");
  _id_DC3EDBF6042EE344 endon("cleanup");

  if(isPlayer(self))
    _id_DC3EDBF6042EE344 _id_190C4BFFF3FDC6B8(self);

  while(scripts\mp\utility\player::isreallyalive(self)) {
    if(isDefined(self.vehicle)) {
      if(!self.vehicle istouching(_id_DC3EDBF6042EE344.trigger)) {
        break;
      }
    } else if(!self istouching(_id_DC3EDBF6042EE344.trigger)) {
      break;
    }

    waitframe();
  }

  _id_CFCE1656415DAE16 = self getentitynumber();
  _id_DC3EDBF6042EE344._id_4C25F559CCCBAADA[_id_CFCE1656415DAE16] = undefined;

  if(isPlayer(self))
    _id_DC3EDBF6042EE344 _id_EB7D54264004374B(self);
}

_id_190C4BFFF3FDC6B8(player) {
  if(isDefined(player.team) && !scripts\engine\utility::array_contains_key(self._id_CF3B62C466FC43BB, player.team)) {
    self._id_CF3B62C466FC43BB[player.team] = 1;

    if(isDefined(self.obj_id))
      objective_addteamtomask(self.obj_id, player.team);
  }

  if(istrue(self._id_1987381AD16D054C) && player.team == self._id_6BCB8569EF76541A)
    _id_B2588B08AD6F485B(player);
}

_id_EB7D54264004374B(player) {
  _id_E232769E6EA189CA(player);
}

_id_B2588B08AD6F485B(player) {
  if(isDefined(self.obj_id))
    objective_hideprogressforclient(self.obj_id, player);

  player setclientomnvar("resurgence_dataheist_state", self._id_EDE20A7B50019DAB);
  player setclientomnvar("resurgence_dataheist_progress", self.progress);
}

_id_E232769E6EA189CA(player) {
  if(isDefined(self.obj_id))
    objective_showprogressforclient(self.obj_id, player);

  player setclientomnvar("resurgence_dataheist_state", 0);
}

_id_533C18EE02139B7E(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(istrue(instance._id_180F4D931981E33E)) {
    if(getdvarint("dvar_ED4EFE8DF2B29DF0", 1))
      _id_5238DEE479BBF7FB::_id_647A8C40104E4866(player.team);

    instance thread _id_07A3F6A13E7005ED();
  } else if(isDefined(instance._id_DC3EDBF6042EE344))
    instance._id_DC3EDBF6042EE344 notify("activated", player.team);
}

_id_AE84023E1DBB45F3(team) {
  foreach(player in level.players) {
    if(player.team == team) {
      self disablescriptableplayeruse(player);
      continue;
    }

    self enablescriptableplayeruse(player);
  }
}

_id_2B41B2856496CBB9() {}

_id_358DE5CAA85AABF7() {
  self._id_180F4D931981E33E = 1;
  _id_DC3EDBF6042EE344 = self._id_DC3EDBF6042EE344;
  event = _id_DC3EDBF6042EE344.event;
  score = event _id_8D72849F49068945(_id_DC3EDBF6042EE344._id_6BCB8569EF76541A);
  _id_90A9CD95EF6496B4 = getdvarint("dvar_4838B7C39021124C", 1);
  self.loot = [];
  self.loot = _id_921CAB584A3D07C0(event, score, _id_90A9CD95EF6496B4);

  foreach(player in level.players) {
    if(player.team != _id_DC3EDBF6042EE344._id_6BCB8569EF76541A) {
      self disablescriptableplayeruse(player);
      continue;
    }

    self enablescriptableplayeruse(player);
  }
}

_id_921CAB584A3D07C0(event, score, _id_90A9CD95EF6496B4) {
  _id_2BCD4D9F9D3130FF = [];

  switch (score) {
    case 3:
      _id_2BCD4D9F9D3130FF[_id_2BCD4D9F9D3130FF.size] = ["brloot_killstreak_auav", 1];

      if(scripts\engine\utility::cointoss() && (getdvarint("dvar_9264F8F1143934C6", 0) && _id_55E418C5CC946593::_id_2980F22FB01F43E6())) {
        _id_D418C6D54E23E75D = ["brloot_perkpack_beret_br", "brloot_perkpack_insurgent_br", "brloot_perkpack_demolitionist_br", "brloot_perkpack_reserves_br", "brloot_perkpack_swat_br"];
        _id_2BCD4D9F9D3130FF[_id_2BCD4D9F9D3130FF.size] = [scripts\engine\utility::_id_7A2AAA4A09A4D250(_id_D418C6D54E23E75D), 1];
      } else if(getdvarint("dvar_368EA569C1A6A4E4", 1)) {
        _id_5A6D897E9CFE5F52 = ["brloot_plate_carrier_tempered"];
        _id_2BCD4D9F9D3130FF[_id_2BCD4D9F9D3130FF.size] = [scripts\engine\utility::_id_7A2AAA4A09A4D250(_id_5A6D897E9CFE5F52), 1];
      }
    case 2:
      lootid = pickscriptablelootitem("weapon", 4, 4, "mp/loot/br/default/lootset_cache_lege.csv");
      _id_EA156F5F477A8792 = 1;

      if(isDefined(level.br_lootiteminfo[lootid])) {
        weapon = _id_7E52B56769FA7774::getfullweaponobjfromscriptablename(lootid);
        _id_EA156F5F477A8792 = weaponclipsize(weapon);
      }

      _id_2BCD4D9F9D3130FF[_id_2BCD4D9F9D3130FF.size] = [lootid, _id_EA156F5F477A8792];
    case 1:
      if(score == 1 || score == 2)
        _id_2BCD4D9F9D3130FF[_id_2BCD4D9F9D3130FF.size] = ["brloot_killstreak_uav", 1];

      _id_63DE1DEE54326FDD = _id_6AFF3948CF4CCA03::getplundernamebyamount(event._id_080242DC777BB3F8);

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_90A9CD95EF6496B4; _id_AC0E594AC96AA3A8++)
        _id_2BCD4D9F9D3130FF[_id_2BCD4D9F9D3130FF.size] = [_id_63DE1DEE54326FDD, event._id_080242DC777BB3F8];

      _id_2BCD4D9F9D3130FF[_id_2BCD4D9F9D3130FF.size] = ["brloot_super_armorbox"];
      _id_2BCD4D9F9D3130FF[_id_2BCD4D9F9D3130FF.size] = ["brloot_super_munitionsbox"];
  }

  return _id_2BCD4D9F9D3130FF;
}

_id_07A3F6A13E7005ED() {
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

  foreach(item in self.loot) {
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, self.origin, self.angles, undefined, level.br_pickups._id_AD49A38DD7C4C10F, level.br_pickups._id_3B53BC0EEE6AE84E);
    scriptable = _id_7E52B56769FA7774::spawnpickup(item[0], _id_CB4FAD49263E20C4, item[1], 1);
  }

  if(isDefined(self._id_DC3EDBF6042EE344._id_47B9ACC51B653DE0) && self._id_DC3EDBF6042EE344._id_47B9ACC51B653DE0 != -1)
    scripts\mp\objidpoolmanager::returnobjectiveid(self._id_DC3EDBF6042EE344._id_47B9ACC51B653DE0);

  self setscriptablepartstate("br_pe_dataheist_uplink_useable", "pickup");
  self setscriptablepartstate("br_pe_dataheist_uplink_screen", "hidden");
  self notify("uplink_looted");
  wait 1.0;
  self freescriptable();
}

_id_A52DEF3D6B40207A(winners) {
  level endon("game_ended");
  self endon("uplink_looted");
  self._id_DC3EDBF6042EE344._id_47B9ACC51B653DE0 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(self._id_DC3EDBF6042EE344._id_47B9ACC51B653DE0 > -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(self._id_DC3EDBF6042EE344._id_47B9ACC51B653DE0, "current", self._id_DC3EDBF6042EE344.origin, "ui_map_icon_obj_sealion_sidequest_reward");
    objective_removeallfrommask(self._id_DC3EDBF6042EE344._id_47B9ACC51B653DE0);
    objective_showtoplayersinmask(self._id_DC3EDBF6042EE344._id_47B9ACC51B653DE0);
    objective_setbackground(self._id_DC3EDBF6042EE344._id_47B9ACC51B653DE0, 1);
    objective_setplayintro(self._id_DC3EDBF6042EE344._id_47B9ACC51B653DE0, 0);
    objective_position(self._id_DC3EDBF6042EE344._id_47B9ACC51B653DE0, self._id_DC3EDBF6042EE344.origin + (0, 0, 20));
    objective_setdescription(self._id_DC3EDBF6042EE344._id_47B9ACC51B653DE0, &"MP_BR_INGAME/REWARD_ICON_NAME_DATAHEIST");
  }

  foreach(player in winners)
  objective_addclienttomask(self._id_DC3EDBF6042EE344._id_47B9ACC51B653DE0, player);

  thread _id_606BEEAE377568AD();
  scripts\mp\objidpoolmanager::objective_set_pulsate(self._id_DC3EDBF6042EE344._id_47B9ACC51B653DE0, 1);
  wait(self._id_DC3EDBF6042EE344.event._id_464FF1EF779C439D);
  scripts\mp\objidpoolmanager::objective_set_pulsate(self._id_DC3EDBF6042EE344._id_47B9ACC51B653DE0, 0);
}

_id_606BEEAE377568AD() {
  level endon("game_ended");
  self endon("uplink_looted");
  _id_D686EF7F3D2879C2 = _id_58F20490049AF6AC::_id_60951B84C58915AB(self.origin);
  _id_7B67E7DF5D9273FE = self._id_DC3EDBF6042EE344._id_47B9ACC51B653DE0;
  _id_7A4D89B99942D23C = self._id_DC3EDBF6042EE344.event._id_4FEBD27038048FFB;
  self._id_DC3EDBF6042EE344.event waittill("event_deactivated");
  _id_607904254B97E282 = _id_58F20490049AF6AC::_id_7D8550B9A2C52852(_id_D686EF7F3D2879C2);

  if(_id_607904254B97E282 < _id_7A4D89B99942D23C)
    wait(_id_607904254B97E282);
  else
    wait(_id_7A4D89B99942D23C);

  scripts\mp\objidpoolmanager::update_objective_state(_id_7B67E7DF5D9273FE, "active");
}

_id_62E43E141326B7C5() {}

_id_E27B61F74DFBA712(_id_1EAFFE65673CF616) {
  _id_DD4F509B9C56C76F = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1EAFFE65673CF616; _id_AC0E594AC96AA3A8++) {
    _id_4C3337129231E244 = _id_48814951E916AF89::_id_ED108FF3EB578327("guard");
    _id_DD4F509B9C56C76F[_id_AC0E594AC96AA3A8] = _id_48814951E916AF89::_id_DE59D7CB310C1AFF(_id_4C3337129231E244);
  }

  return _id_DD4F509B9C56C76F;
}

_id_016460A9DABA16A6(_id_1EAFFE65673CF616, _id_9FF8D6FF64B1E412, _id_DDF7C7237F9C720D) {
  _id_DD4F509B9C56C76F = [];
  tier = 1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1EAFFE65673CF616; _id_AC0E594AC96AA3A8++) {
    if(_id_AC0E594AC96AA3A8 >= _id_9FF8D6FF64B1E412) {
      _id_4C3337129231E244 = _id_48814951E916AF89::_id_ED108FF3EB578327("guard");
      tier = 1;
    } else {
      _id_4C3337129231E244 = "rusher";
      tier = _id_DDF7C7237F9C720D;
    }

    _id_DD4F509B9C56C76F[_id_AC0E594AC96AA3A8] = _id_48814951E916AF89::_id_DE59D7CB310C1AFF(_id_4C3337129231E244, tier);
  }

  return _id_DD4F509B9C56C76F;
}

_id_3723563CAD2EB687(_id_DD4F509B9C56C76F, _id_38EC12043600CBE0, params) {
  if(_id_DD4F509B9C56C76F.size < 1) {
    return;
  }
  agents = _id_252FA7D2B1B1B50B::_id_4E0244F0C1AB5067(self.origin, _id_DD4F509B9C56C76F, _id_38EC12043600CBE0, params);
  waitframe();

  foreach(agent in agents) {
    if(issubstr(agent.agent_type, "rusher") || agent._id_AE3EA15396B65C1F == "rusher") {
      agent.pathenemyfightdist = 0;
      agent _id_4F7C27D4FEF4BC09::_id_5213D881F2E26966(self.origin, 1000);
    }

    _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "dropWeapon", 0);
    _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "dropGrenade", 0);
  }

  self.agents = scripts\engine\utility::array_combine(self.agents, agents);
}

_id_27BA596AAFA69F39(_id_15D6C88336DEBDF4) {
  params = spawnStruct();
  params._id_AAC993A0C1361744 = "dataheist";
  params._id_6ADBAF8D10937E14 = "high";
  params._id_A78DAF96B4BDF866 = 1500;
  params._id_1B20F5FB6AEE28F7 = 500;
  params._id_0CF0B51BA5E529A7 = 5;
  params._id_15D6C88336DEBDF4 = scripts\engine\utility::ter_op(isDefined(_id_15D6C88336DEBDF4), _id_15D6C88336DEBDF4, 0);
  return params;
}

_id_74428D38B94D6664() {
  _id_4D1C2F2324FF0903 = 0;
  agents = self.agents;

  if(!isDefined(agents) || agents.size <= 0) {} else {
    foreach(agent in agents) {
      if(!scripts\engine\utility::is_dead_or_dying(agent) && (issubstr(agent.agent_type, "rusher") || agent._id_AE3EA15396B65C1F == "rusher"))
        _id_4D1C2F2324FF0903++;
    }
  }

  return _id_4D1C2F2324FF0903;
}

_id_520DD8C02A62523B() {}

_id_E8CE5F018D2B942C(dialog, delay) {
  _id_63BDBC18191BE5F9(dialog, level.players, delay);
}

_id_63BDBC18191BE5F9(dialog, players, delay) {
  _id_668B93C688B30136 = game["dialog"][dialog];

  foreach(player in players)
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer(dialog, player, undefined, undefined, delay, undefined, "dx_br_seal_");
}

_id_F1A6433B0371050B() {}

_id_2A43E356ECD267C7(team) {
  players = scripts\mp\utility\teams::getteamdata(team, "players");
  nearby_players = [];
  _id_ABD9EE4725B96FC2 = squared(self._id_59EA6B2EF4905653);

  foreach(player in players) {
    if(distance2dsquared(player.origin, self.midpoint) <= _id_ABD9EE4725B96FC2)
      nearby_players[nearby_players.size] = player;
  }

  return nearby_players;
}

_id_F8CD8B690A39BEC2(team) {
  _id_BBCF436A8958AC11 = scripts\mp\utility\teams::getteamdata(team, "players");
  return scripts\mp\utility\player::getplayersinradius(self.midpoint, self._id_59EA6B2EF4905653, undefined, _id_BBCF436A8958AC11);
}

_id_F3167A32A9D8B1E8() {
  return scripts\mp\utility\player::getplayersinradius(self.midpoint, self._id_59EA6B2EF4905653);
}

_id_0AEB8753295C3577(team) {
  members = [];

  foreach(player in self.nearby_players) {
    if(player.team == team)
      members[members.size] = player;
  }

  return members;
}

_id_63245662E2E8A786(point) {
  return point._id_3EA06EB9EC84616C && point._id_927206BDB3F7000D.size >= self._id_C740830CDB73800E - 1;
}

_id_45A890C985D26276() {
  _id_46EDFBF5C8EC3711 = [];

  foreach(point in self._id_ADABC9F186B54E6A) {
    if(_id_63245662E2E8A786(point))
      _id_46EDFBF5C8EC3711[_id_46EDFBF5C8EC3711.size] = point;
  }

  return _id_46EDFBF5C8EC3711;
}

_id_24AFCBB2EA0CCB49(_id_70A2EEF6AE310634) {
  foreach(point in self._id_ADABC9F186B54E6A) {
    point._id_927206BDB3F7000D = [];
    point._id_3EA06EB9EC84616C = 1;

    if(point.used) {
      point._id_3EA06EB9EC84616C = 0;
      continue;
    }

    if(!level.br_circle_disabled) {
      _id_3F69BE4080274AC5 = _id_58F20490049AF6AC::_id_60951B84C58915AB(point.origin);
      _id_0D24B6BA242F5C12 = _id_58F20490049AF6AC::_id_7D8550B9A2C52852(_id_3F69BE4080274AC5);

      if(_id_0D24B6BA242F5C12 < _id_70A2EEF6AE310634) {
        point._id_3EA06EB9EC84616C = 0;
        continue;
      }
    }
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self._id_ADABC9F186B54E6A.size; _id_AC0E594AC96AA3A8++) {
    _id_4ADA0DBAA779F2ED = self._id_ADABC9F186B54E6A[_id_AC0E594AC96AA3A8];

    if(!_id_4ADA0DBAA779F2ED._id_3EA06EB9EC84616C) {
      continue;
    }
    for(_id_AC0E5C4AC96AAA41 = _id_AC0E594AC96AA3A8 + 1; _id_AC0E5C4AC96AAA41 < self._id_ADABC9F186B54E6A.size; _id_AC0E5C4AC96AAA41++) {
      _id_4ADA0ABAA779EC54 = self._id_ADABC9F186B54E6A[_id_AC0E5C4AC96AAA41];

      if(!_id_4ADA0ABAA779EC54._id_3EA06EB9EC84616C) {
        continue;
      }
      dist = distance2dsquared(_id_4ADA0DBAA779F2ED.origin, _id_4ADA0ABAA779EC54.origin);

      if(dist > self._id_ADC5129FF19A0342 && dist < self._id_A355AE253087E6EC) {
        _id_4ADA0DBAA779F2ED._id_927206BDB3F7000D[_id_4ADA0DBAA779F2ED._id_927206BDB3F7000D.size] = _id_4ADA0ABAA779EC54;
        _id_4ADA0ABAA779EC54._id_927206BDB3F7000D[_id_4ADA0ABAA779EC54._id_927206BDB3F7000D.size] = _id_4ADA0DBAA779F2ED;
      }
    }
  }
}

_id_C034DC08D0D12CD8(state) {
  switch (state) {
    case 1:
      return &"MP_BR_PE_DATAHEIST/CAPTURE_STATE_DOWNLOADING";
    case 2:
      return &"MP_BR_PE_DATAHEIST/CAPTURE_STATE_INTERFERENCE";
    case 3:
      return &"MP_BR_PE_DATAHEIST/CAPTURE_STATE_BLOCKED";
    default:
      return "!! INVALID STATE !!";
  }
}

_id_671CC803581D0E65(_id_55C91E2104BE488A) {
  points = [];

  if(!isDefined(_id_55C91E2104BE488A))
    return points;

  _id_64598ECF49AB5725 = strtok(_id_55C91E2104BE488A, ",");

  foreach(_id_F797BD32DD59C4A7 in _id_64598ECF49AB5725) {
    _id_DBFD5ECC8D4E11B7 = int(_id_F797BD32DD59C4A7);

    if(isint(_id_DBFD5ECC8D4E11B7) && _id_DBFD5ECC8D4E11B7 >= 0 && _id_DBFD5ECC8D4E11B7 < self._id_ADABC9F186B54E6A.size) {
      points[points.size] = _id_DBFD5ECC8D4E11B7;
      continue;
    }
  }

  return points;
}

_id_DDFC2513FFDC4DDC() {
  scripts\cp_mp\challenges::_id_8359CADD253F9604(self, "dataheist_uplink_complete", 1);
}