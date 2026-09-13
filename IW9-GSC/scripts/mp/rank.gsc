/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\rank.gsc
***********************************************/

init() {
  level.scoreinfo = [];
  xpscale = scripts\cp_mp\utility\game_utility::_id_E3EF0908B595E8E1();

  if(xpscale > 4 || xpscale < 0)
    exitlevel(0);

  addglobalrankxpmultiplier(xpscale, "online_mp_xpscale");
  level.ranktable = [];
  level.weaponranktable = [];
  level._id_E0E30C15F736BD96 = int(tablelookup("mp/rankTable.csv", 0, "maxstandardrank", 1));
  level.maxrank = int(tablelookup("mp/rankTable.csv", 0, "maxlifetime", 1));
  level.maxelderrank = int(tablelookup("mp/rankTable.csv", 0, "maxelder", 1));

  for(_id_C5B5347389C6B7D6 = 0; _id_C5B5347389C6B7D6 <= level.maxrank; _id_C5B5347389C6B7D6++) {
    level.ranktable[_id_C5B5347389C6B7D6][0] = int(tablelookup("mp/rankTable.csv", 0, _id_C5B5347389C6B7D6, 2));
    level.ranktable[_id_C5B5347389C6B7D6][1] = int(tablelookup("mp/rankTable.csv", 0, _id_C5B5347389C6B7D6, 3));
    level.ranktable[_id_C5B5347389C6B7D6][2] = int(tablelookup("mp/rankTable.csv", 0, _id_C5B5347389C6B7D6, 7));
    level.ranktable[_id_C5B5347389C6B7D6][3] = tablelookup("mp/rankTable.csv", 0, _id_C5B5347389C6B7D6, 15);
  }

  level._id_CC985BC5548342E8 = getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_xp_dr_enabled_rank"), 0) == 1;
  level._id_9CA8191D077DAEBE = getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_xp_dr_enabled_weapon"), 0) == 1;
  level._id_272C8FB7F8A58135 = getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_xp_dr_lower"), 25000);
  level._id_FE4DB4AB7AD9D95E = getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_xp_dr_upper"), 40000);
  level._id_BD959547D81BA9F6 = level._id_FE4DB4AB7AD9D95E - level._id_272C8FB7F8A58135;
  level._id_CE487746206452F4 = getdvarfloat(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_xp_dr_lower_rate"), 0.75);
  level._id_79C0B5F1954D30C9 = getdvarfloat(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_xp_dr_upper_rate"), 0.25);
  _id_E21B6077B21CA1BF = getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_xp_dr_avg_length"), 0);

  if(_id_E21B6077B21CA1BF == 0)
    _id_E21B6077B21CA1BF = scripts\mp\utility\game::gettimelimit();

  level._id_6677795065862D93 = _id_E21B6077B21CA1BF / 3600;
  scripts\mp\weaponrank::init();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
  level.prestigeextras = [];
  level thread onplayerconnect();
}

_id_377A94F711D96927(type) {
  return isDefined(level.scoreinfo[type]);
}

_id_4806D99C032B59E9(type, _id_98EA5AFB293A76A2) {
  if(!_func_D03495FE6418377B(type))
    type = _func_1823FF50BB28148D(type);

  level._id_C811D43E15974EBD[type] = _id_98EA5AFB293A76A2;
}

_id_6D17F84162F0D8F0(type) {
  if(!_func_D03495FE6418377B(type))
    type = _func_1823FF50BB28148D(type);

  return scripts\engine\utility::_id_53C4C53197386572(level._id_C811D43E15974EBD[type], 1.0);
}

registerscoreinfo(type, category, value) {
  if(!_func_D03495FE6418377B(type))
    type = _func_1823FF50BB28148D(type);

  if(!_func_D03495FE6418377B(category))
    category = _func_1823FF50BB28148D(category);

  if(category == "stat_7CE4FD9430E80CEA") {
    _id_5575922F0879E65E = getdvarint(_func_2EF675C13CA1C4AF("dvar_655CD9F8AA8E671A", _func_0F28FD66285FA2C9(type), "_score_override"), -1);

    if(_id_5575922F0879E65E >= 0)
      value = _id_5575922F0879E65E;

    level._id_8C835BDF5CB251A3[type] = value;

    if(type == "stat_EF9582D72160F199") {
      setomnvar("ui_game_type_kill_value", int(value));
      return;
    }
  } else if(category == "stat_08F14807B58DDF35") {
    _id_5575922F0879E65E = getdvarint(_func_2EF675C13CA1C4AF("dvar_655CD9F8AA8E671A", _func_0F28FD66285FA2C9(type), "_xp_override"), -1);

    if(_id_5575922F0879E65E >= 0)
      value = _id_5575922F0879E65E;

    level._id_CA1E8121E5AED622[type] = value;
  } else if(category == "stat_6DD3D93BBF03ABC6")
    level._id_0F749DDA4BF7912B[type] = value;
  else if(category == "stat_582866801A05178B")
    level._id_AC143FE8D620124E[type] = value;
  else if(category == "stat_2A95DA1330928B16")
    level._id_08511C09177D02B1[type] = value;
  else
    level.scoreinfo[type][category] = value;
}

getscoreinfovalue(type) {
  if(!_func_D03495FE6418377B(type))
    type = _func_1823FF50BB28148D(type);

  return level._id_8C835BDF5CB251A3[type];
}

_id_D06C3CBB904AE29B(type) {
  if(!_func_D03495FE6418377B(type))
    type = _func_1823FF50BB28148D(type);

  if(isPlayer(self)) {
    _id_4B5A99C16ABFDFB1 = self _meth_B2617441D2B73E0B(type, level._id_4C4124986B28EFBB);

    if(isDefined(_id_4B5A99C16ABFDFB1))
      return _id_4B5A99C16ABFDFB1;
  }

  return level._id_CA1E8121E5AED622[type];
}

_id_034294184E90B96C(type) {
  if(!_func_D03495FE6418377B(type))
    type = _func_1823FF50BB28148D(type);

  return istrue(level._id_0F749DDA4BF7912B[type]);
}

_id_E3DFD7E570749681(type) {
  if(!_func_D03495FE6418377B(type))
    type = _func_1823FF50BB28148D(type);

  return istrue(level._id_AC143FE8D620124E[type]);
}

_id_B2425A8C88E4A460(type) {
  if(!_func_D03495FE6418377B(type))
    type = _func_1823FF50BB28148D(type);

  return level._id_08511C09177D02B1[type];
}

getscoreinfocategory(type, category) {
  if(!_func_D03495FE6418377B(type))
    type = _func_1823FF50BB28148D(type);

  if(!_func_D03495FE6418377B(category))
    category = _func_1823FF50BB28148D(category);

  if(istrue(level.removekilleventsplash) && !isDefined(level.scoreinfo[type]))
    return undefined;

  if(category == "stat_7CE4FD9430E80CEA")
    return getscoreinfovalue(type);
  else if(category == "stat_08F14807B58DDF35")
    return _id_D06C3CBB904AE29B(type);
  else if(category == "stat_6DD3D93BBF03ABC6")
    return _id_034294184E90B96C(type);
  else if(category == "stat_582866801A05178B")
    return _id_E3DFD7E570749681(type);

  if(!isDefined(level.scoreinfo[type]))
    return undefined;

  return level.scoreinfo[type][category];
}

getrankinfominxp(_id_C5B5347389C6B7D6) {
  return level.ranktable[_id_C5B5347389C6B7D6][0];
}

getrankinfoxpamt(_id_C5B5347389C6B7D6) {
  return level.ranktable[_id_C5B5347389C6B7D6][1];
}

getrankinfomaxxp(_id_C5B5347389C6B7D6) {
  return level.ranktable[_id_C5B5347389C6B7D6][2];
}

getrankinfofull(_id_C5B5347389C6B7D6) {
  return tablelookupistring("mp/rankTable.csv", 0, _id_C5B5347389C6B7D6, 16);
}

getrankinfoicon(_id_C5B5347389C6B7D6, _id_066753F64E5CD3E9) {
  return tablelookup("mp/rankIconTable.csv", 0, _id_C5B5347389C6B7D6, _id_066753F64E5CD3E9 + 1);
}

getrankinfolevel(_id_C5B5347389C6B7D6) {
  return int(tablelookup("mp/rankTable.csv", 0, _id_C5B5347389C6B7D6, 13));
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", player);

    if(!isai(player)) {
      if(level.playerxpenabled) {
        player.pers["rankxp"] = player getplayerdata(level.loadoutsgroup, "squadMembers", "player_xp");
        _id_C52868E86C820DE4 = player getplayerdata(level.loadoutsgroup, "squadMembers", "season_rank");

        if(!isDefined(player.pers["xpEarnedThisMatch"]))
          player.pers["xpEarnedThisMatch"] = 0;
      } else {
        _id_C52868E86C820DE4 = 0;
        player.pers["rankxp"] = 0;
      }
    } else {
      _id_C52868E86C820DE4 = 0;
      player.pers["rankxp"] = 0;
    }

    player.pers["prestige"] = _id_C52868E86C820DE4;

    if(player.pers["rankxp"] < 0)
      player.pers["rankxp"] = 0;

    _id_C5B5347389C6B7D6 = player getrankforxp(player getrankxp());
    player.pers["rank"] = _id_C5B5347389C6B7D6;
    player setrank(_id_C5B5347389C6B7D6, _id_C52868E86C820DE4);
    player.pers["participation"] = 0;
    player.scoreupdatetotal = 0;
    player.scorepointsqueue = 0;
    player.scoreeventqueue = [];
    player.postgamepromotion = 0;
    player setclientdvar("ui_promotion", 0);

    if(!isDefined(player.pers["summary"])) {
      player.pers["summary"] = [];
      player.pers["summary"]["xp"] = 0;
      player.pers["summary"]["score"] = 0;
      player.pers["summary"]["challenge"] = 0;
      player.pers["summary"]["match"] = 0;
      player.pers["summary"]["misc"] = 0;
      player.pers["summary"]["medal"] = 0;
      player.pers["summary"]["bonusXP"] = 0;
      player.pers["summary"]["weaponXP"] = 0;
      player.pers["summary"]["operatorXP"] = 0;
      player.pers["summary"]["clanXP"] = 0;
      player.pers["summary"]["battlepassXP"] = 0;
    }

    player setclientdvar("ui_opensummary", 0);

    if(level.playerxpenabled) {
      _id_2B96F5B26B76CABB = getdvarint("online_mp_party_xpscale");
      _id_E2F208FF5491C24E = player getprivatepartysize() > 1;

      if(_id_E2F208FF5491C24E)
        player addrankxpmultiplier(_id_2B96F5B26B76CABB, "online_mp_party_xpscale");

      if(player getplayerdata(level._id_5D69837CF4DB0407, "prestigeDoubleWeaponXp"))
        player.prestigedoubleweaponxp = 1;
      else
        player.prestigedoubleweaponxp = 0;
    }

    player.scoreeventcount = 0;
    player.scoreeventlistindex = 0;
    player setclientomnvar("ui_score_event_control", -1);
    player setclientomnvar("ui_potg_score_event_control", -1);
  }
}

onplayerspawned() {
  if(isai(self))
    self.pers["rankxp"] = scripts\mp\bots\bots_util::get_rank_xp_for_bot();
  else if(!level.playerxpenabled)
    self.pers["rankxp"] = 0;
  else {}

  playerupdaterank();
}

playerupdaterank() {
  _id_C5732E73897E110B = self.pers["rankxp"];

  if(_id_C5732E73897E110B < 0) {
    _id_C5732E73897E110B = 0;
    self.pers["rankxp"] = 0;
  }

  _id_C5B5347389C6B7D6 = getrankforxp(_id_C5732E73897E110B);
  self.pers["rank"] = _id_C5B5347389C6B7D6;

  if(isai(self) || !isDefined(self.pers["prestige"])) {
    if(level.playerxpenabled && isDefined(self.bufferedstats))
      _id_C52868E86C820DE4 = getprestigelevel();
    else
      _id_C52868E86C820DE4 = 0;

    self setrank(_id_C5B5347389C6B7D6, _id_C52868E86C820DE4);
    self.pers["prestige"] = _id_C52868E86C820DE4;
  }
}

tryresetrankxp() {
  if(issubstr(self.class, "custom")) {
    if(!level.playerxpenabled)
      self.pers["rankxp"] = 0;
    else if(isai(self))
      self.pers["rankxp"] = 0;
    else {}
  }
}

giverankxp(type, value, objweapon, _id_719B93858D7B1C94, _id_8197B2CE199B9025, _id_339E50A026E4674F, _id_B01ACA3236595958) {
  self endon("disconnect");

  if(isDefined(self.owner) && !isbot(self) && self != self.owner) {
    self.owner giverankxp(type, value, objweapon, _id_719B93858D7B1C94, _id_8197B2CE199B9025, _id_339E50A026E4674F);
    return;
  }

  if(isai(self) || !isPlayer(self)) {
    return;
  }
  if(!isDefined(value))
    value = 0;

  _id_C6EA1889CB72E9A4 = getplayerrateofgamerevenue(self);
  value = int(value * _id_C6EA1889CB72E9A4);

  if(!isDefined(_id_719B93858D7B1C94))
    _id_719B93858D7B1C94 = 0;

  if(!isDefined(_id_8197B2CE199B9025))
    _id_8197B2CE199B9025 = 0;

  if(!isDefined(value) || value == 0) {
    return;
  }
  if(scripts\mp\utility\game::getsubgametype() == "dmz") {} else if(!istrue(level._id_FC96A942BE145B56)) {
    if(level.teambased) {
      _id_C1743D96950B8B2F = 0;

      foreach(_id_F90358454413407F in level.teamnamelist) {
        if(scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "teamCount")) {
          _id_C1743D96950B8B2F++;

          if(_id_C1743D96950B8B2F >= 2) {
            break;
          }
        }
      }

      if(_id_C1743D96950B8B2F < 2)
        return;
    } else {
      _id_F8D5A7B136B378F3 = 0;

      foreach(_id_F90358454413407F in level.teamnamelist) {
        _id_F8D5A7B136B378F3 = _id_F8D5A7B136B378F3 + scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "teamCount");

        if(_id_F8D5A7B136B378F3 >= 2) {
          break;
        }
      }

      if(_id_F8D5A7B136B378F3 < 2)
        return;
    }
  }

  _id_A29C313EC2AD5E22 = getscoreinfocategory(type, "stat_90AAF79C829783F5");
  _id_9A4F747BEEFEA6D7 = 1.0;
  _id_E07CC288C1153C7F = value;
  _id_68EB858FD6EA5428 = 0;

  if(istrue(_id_A29C313EC2AD5E22)) {
    _id_9A4F747BEEFEA6D7 = getrankxpmultipliertotal();
    _id_E07CC288C1153C7F = int(value * _id_9A4F747BEEFEA6D7);
    _id_68EB858FD6EA5428 = int(max(_id_E07CC288C1153C7F - value, 0));
  }

  thread waitandapplyxp(type, value, _id_E07CC288C1153C7F, _id_68EB858FD6EA5428, objweapon, _id_8197B2CE199B9025, _id_339E50A026E4674F, _id_B01ACA3236595958, _id_719B93858D7B1C94);
}

waitandapplyxp(type, _id_A40A13BC564139BF, _id_E07CC288C1153C7F, _id_68EB858FD6EA5428, objweapon, _id_8197B2CE199B9025, _id_339E50A026E4674F, _id_B01ACA3236595958, _id_719B93858D7B1C94) {
  self endon("disconnect");

  if(!isDefined(_id_8197B2CE199B9025))
    _id_8197B2CE199B9025 = 0;

  if(!_id_8197B2CE199B9025) {
    waitframe();
    scripts\mp\utility\script::waittillslowprocessallowed();
  }

  _id_3D1080482DAC9C6A = getrankxp();

  if(updaterank(_id_3D1080482DAC9C6A)) {}

  syncxpstat();
  _id_DE29895DCA8987CE = 0;

  if(!istrue(_id_339E50A026E4674F)) {
    if(!isDefined(objweapon) || isDefined(objweapon.basename) && objweapon.basename == "none") {
      if(isDefined(self.lastcacweaponobj))
        objweapon = self.lastcacweaponobj;
      else if(isDefined(self.lastdroppableweaponobj))
        objweapon = self.lastdroppableweaponobj;
    }

    if(isDefined(objweapon)) {
      objweapon = scripts\cp_mp\utility\weapon_utility::_id_1E3102980C3A4CC1(objweapon);

      if(isDefined(objweapon)) {
        if(scripts\mp\weaponrank::weaponshouldgetxp(objweapon)) {
          if(istrue(level._id_D45CBFD4ECD2662C))
            _id_DE29895DCA8987CE = [[level._id_D45CBFD4ECD2662C]](type);
          else {
            _id_DE29895DCA8987CE = _id_A40A13BC564139BF;
            _id_DE29895DCA8987CE = _id_DE29895DCA8987CE * scripts\mp\weaponrank::getweaponrankxpmultipliertotal(objweapon);
            _id_DE29895DCA8987CE = int(_id_DE29895DCA8987CE);
          }
        }
      }
    }
  }

  _id_CA4ECB96C19485FE = _id_A40A13BC564139BF;
  _id_E07CC288C1153C7F = _id_C465F9A27979C865(_id_E07CC288C1153C7F, _id_B01ACA3236595958);
  _id_68EB858FD6EA5428 = _id_78802B8C6DE6EEBA(_id_68EB858FD6EA5428, _id_B01ACA3236595958);
  _id_A40A13BC564139BF = _id_736110BFD2A3A5EA(_id_A40A13BC564139BF, _id_B01ACA3236595958);
  _id_DE29895DCA8987CE = _id_199D881C43179C3F(_id_DE29895DCA8987CE, _id_B01ACA3236595958);

  if(level._id_CC985BC5548342E8 || level._id_9CA8191D077DAEBE)
    [_id_E07CC288C1153C7F, _id_DE29895DCA8987CE] = _id_8ED5EA54BB5C5194(_id_E07CC288C1153C7F, _id_DE29895DCA8987CE);

  if(!_id_719B93858D7B1C94 && level._id_27DCAF9644646944 == "stat_DB5FE74CFCEEBFE6") {
    if(!level.playerxpenabled || level._id_EC2FB549B15AD827 || scripts\mp\utility\game::isanymlgmatch() && !getdvarint("dvar_0093109B9D6F2BF2")) {
      _id_B3A25CC5438CD047 = getscoreinfovalue(type);

      if(level.mapname != "mp_firingrange") {}

      if(!isDefined(_id_B3A25CC5438CD047))
        _id_B3A25CC5438CD047 = 0;

      scripts\mp\utility\points::displayscoreeventpoints(_id_B3A25CC5438CD047, type);
    } else
      scripts\mp\utility\points::displayscoreeventpoints(_id_C465F9A27979C865(_id_E07CC288C1153C7F, _id_B01ACA3236595958), type);
  }

  incrankxp(_id_E07CC288C1153C7F, objweapon, _id_DE29895DCA8987CE, type, _id_CA4ECB96C19485FE, _id_B01ACA3236595958);

  if(level.playerxpenabled && !isai(self)) {
    if(isDefined(objweapon) && (scripts\mp\utility\weapon::iscacprimaryweapon(objweapon) || scripts\mp\utility\weapon::iscacsecondaryweapon(objweapon))) {
      _id_7E2C53B0BCF117D9 = spawnStruct();
      _id_7E2C53B0BCF117D9.weaponname = _id_2669878CF5A1B6BC::getweaponrootname(objweapon);
      _id_7E2C53B0BCF117D9.fullweaponname = getcompleteweaponname(objweapon);
      _id_7E2C53B0BCF117D9._id_629757F5C9E770D8 = "xp_earned";
      _id_7E2C53B0BCF117D9._id_A1D4E7D5EF9DA660 = _id_DE29895DCA8987CE;
      _id_7E2C53B0BCF117D9.variantid = -1;
      _id_7E2C53B0BCF117D9.weaponobj = objweapon;
      _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_update_weapon_stats", _id_7E2C53B0BCF117D9);
    }
  }

  recordxpgains(type, _id_A40A13BC564139BF, _id_68EB858FD6EA5428);
  _id_814960839FF2DC12 = getprestigelevel();
  _id_EBFEBB497C5F0C29 = getrank();
}

_id_8ED5EA54BB5C5194(_id_C5732E73897E110B, _id_CC603E175ABFEF2D) {
  _id_2AB33F3FECA6DAA9 = _id_C5732E73897E110B;
  _id_A272DD31F410CA93 = _id_CC603E175ABFEF2D;
  _id_9E57D571F220152F = scripts\engine\utility::_id_53C4C53197386572(self.pers["xpEarnedThisMatch"], 0) / level._id_6677795065862D93;

  if(_id_9E57D571F220152F > level._id_FE4DB4AB7AD9D95E) {
    if(level._id_CC985BC5548342E8)
      _id_2AB33F3FECA6DAA9 = int(_id_2AB33F3FECA6DAA9 * level._id_79C0B5F1954D30C9);

    if(level._id_9CA8191D077DAEBE)
      _id_A272DD31F410CA93 = int(_id_A272DD31F410CA93 * level._id_79C0B5F1954D30C9);
  } else if(_id_9E57D571F220152F > level._id_272C8FB7F8A58135) {
    _id_CCBBA16287668F0A = clamp((_id_9E57D571F220152F - level._id_272C8FB7F8A58135) / level._id_BD959547D81BA9F6, 0.0, 1.0);
    _id_B55C419A0DD99381 = scripts\engine\math::lerp(level._id_CE487746206452F4, level._id_79C0B5F1954D30C9, _id_CCBBA16287668F0A);

    if(level._id_CC985BC5548342E8)
      _id_2AB33F3FECA6DAA9 = int(_id_2AB33F3FECA6DAA9 * _id_B55C419A0DD99381);

    if(level._id_9CA8191D077DAEBE)
      _id_A272DD31F410CA93 = int(_id_A272DD31F410CA93 * _id_B55C419A0DD99381);
  }

  return [_id_2AB33F3FECA6DAA9, _id_A272DD31F410CA93];
}

recordxpgains(type, _id_7C6B134E84356E37, _id_68EB858FD6EA5428) {
  _id_61339CC7C44BDE8B = _id_7C6B134E84356E37 + _id_68EB858FD6EA5428;
  group = getscoreinfocategory(type, "stat_DC57E42946F6E08C");

  if(!isDefined(group) || group == "") {
    self.pers["summary"]["misc"] = self.pers["summary"]["misc"] + _id_7C6B134E84356E37;
    self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + _id_68EB858FD6EA5428;
    self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + _id_61339CC7C44BDE8B;
    return;
  }

  switch (group) {
    case "match_bonus":
      self.pers["summary"]["match"] = self.pers["summary"]["match"] + _id_7C6B134E84356E37;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + _id_68EB858FD6EA5428;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + _id_61339CC7C44BDE8B;
      break;
    case "challenge":
      self.pers["summary"]["challenge"] = self.pers["summary"]["challenge"] + _id_7C6B134E84356E37;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + _id_68EB858FD6EA5428;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + _id_61339CC7C44BDE8B;
      break;
    case "medal":
      if(!isDefined(self.pers["combatXP"]))
        self.pers["combatXP"] = _id_7C6B134E84356E37;
      else
        self.pers["combatXP"] = self.pers["combatXP"] + _id_7C6B134E84356E37;

      self.pers["summary"]["medal"] = self.pers["summary"]["medal"] + _id_7C6B134E84356E37;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + _id_68EB858FD6EA5428;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + _id_61339CC7C44BDE8B;
      break;
    case "combat":
      if(!isDefined(self.pers["combatXP"]))
        self.pers["combatXP"] = _id_7C6B134E84356E37;
      else
        self.pers["combatXP"] = self.pers["combatXP"] + _id_7C6B134E84356E37;

      if(type == "stat_AB2FA142759B4C26") {
        if(!isDefined(self.pers["reviveXP"]))
          self.pers["reviveXP"] = _id_7C6B134E84356E37;
        else
          self.pers["reviveXP"] = self.pers["reviveXP"] + _id_7C6B134E84356E37;
      }

      self.pers["summary"]["score"] = self.pers["summary"]["score"] + _id_7C6B134E84356E37;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + _id_68EB858FD6EA5428;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + _id_61339CC7C44BDE8B;
      break;
    case "br_logistics":
    case "looting":
      if(!isDefined(self.pers["lootingXP"]))
        self.pers["lootingXP"] = _id_7C6B134E84356E37;
      else
        self.pers["lootingXP"] = self.pers["lootingXP"] + _id_7C6B134E84356E37;

      self.pers["summary"]["score"] = self.pers["summary"]["score"] + _id_7C6B134E84356E37;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + _id_68EB858FD6EA5428;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + _id_61339CC7C44BDE8B;
      break;
    case "br_support":
      if(!isDefined(self.pers["supportXP"]))
        self.pers["supportXP"] = _id_7C6B134E84356E37;
      else
        self.pers["supportXP"] = self.pers["supportXP"] + _id_7C6B134E84356E37;

      self.pers["summary"]["score"] = self.pers["summary"]["score"] + _id_7C6B134E84356E37;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + _id_68EB858FD6EA5428;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + _id_61339CC7C44BDE8B;
      break;
    case "br_recon":
      if(!isDefined(self.pers["reconXP"]))
        self.pers["reconXP"] = _id_7C6B134E84356E37;
      else
        self.pers["reconXP"] = self.pers["reconXP"] + _id_7C6B134E84356E37;

      self.pers["summary"]["score"] = self.pers["summary"]["score"] + _id_7C6B134E84356E37;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + _id_68EB858FD6EA5428;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + _id_61339CC7C44BDE8B;
      break;
    case "br_strategy":
    case "missions":
      if(!isDefined(self.pers["missionXP"]))
        self.pers["missionXP"] = _id_7C6B134E84356E37;
      else
        self.pers["missionXP"] = self.pers["missionXP"] + _id_7C6B134E84356E37;

      self.pers["summary"]["score"] = self.pers["summary"]["score"] + _id_7C6B134E84356E37;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + _id_68EB858FD6EA5428;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + _id_61339CC7C44BDE8B;
      break;
    case "gametype":
      if(type == "stat_3B0B5B72C38E1A56") {
        if(!isDefined(self.pers["explorationXP"]))
          self.pers["explorationXP"] = _id_7C6B134E84356E37;
        else
          self.pers["explorationXP"] = self.pers["explorationXP"] + _id_7C6B134E84356E37;
      } else if(type == "stat_A664E407EB3E39D4") {
        if(!isDefined(self.pers["extractionXP"]))
          self.pers["extractionXP"] = _id_7C6B134E84356E37;
        else
          self.pers["extractionXP"] = self.pers["extractionXP"] + _id_7C6B134E84356E37;
      } else if(type == "stat_0541F0B57F321A27") {
        if(!isDefined(self.pers["uavTowerXP"]))
          self.pers["uavTowerXP"] = _id_7C6B134E84356E37;
        else
          self.pers["uavTowerXP"] = self.pers["uavTowerXP"] + _id_7C6B134E84356E37;
      } else if(type == "stat_C02C8C802F07C908") {
        if(!isDefined(self.pers["safeOpenedXP"]))
          self.pers["safeOpenedXP"] = _id_7C6B134E84356E37;
        else
          self.pers["safeOpenedXP"] = self.pers["safeOpenedXP"] + _id_7C6B134E84356E37;
      } else if(type == "stat_9A68D11B1688325A") {
        if(!isDefined(self.pers["supplyDropsOpenedXP"]))
          self.pers["supplyDropsOpenedXP"] = _id_7C6B134E84356E37;
        else
          self.pers["supplyDropsOpenedXP"] = self.pers["supplyDropsOpenedXP"] + _id_7C6B134E84356E37;
      } else if(type == "stat_4F33A2C9E6F878F3" || type == "stat_903730F789CD3EA8" || type == "stat_39A2298D6704DF34" || type == "stat_73698E98EEE3B648") {
        if(!isDefined(self.pers["contractXP"]))
          self.pers["contractXP"] = _id_7C6B134E84356E37;
        else
          self.pers["contractXP"] = self.pers["contractXP"] + _id_7C6B134E84356E37;
      } else if(type == "stat_6C63C18261A7AF97" || type == "stat_584786512B068A29" || type == "stat_F3613BEAE4483DB1" || type == "stat_6BC346A4E4CEEC9C" || type == "stat_8F214DB6809E7A45" || type == "stat_7F4E32E3118376D1" || type == "stat_1DA43ECD73FE96D8" || type == "stat_1DA441CD73FE9BF1" || type == "stat_B89531208DD457D9" || type == "stat_32CC2C1E56E5B931" || type == "stat_32CC291E56E5B418" || type == "stat_95F9ED42EF9AC79A") {
        if(!isDefined(self.pers["areaUnlockedXP"]))
          self.pers["areaUnlockedXP"] = _id_7C6B134E84356E37;
        else
          self.pers["areaUnlockedXP"] = self.pers["areaUnlockedXP"] + _id_7C6B134E84356E37;
      } else if(type == "stat_05A2C275279403F5") {
        if(!isDefined(self.pers["missionXP"]))
          self.pers["missionXP"] = _id_7C6B134E84356E37;
        else
          self.pers["missionXP"] = self.pers["missionXP"] + _id_7C6B134E84356E37;
      }

      self.pers["summary"]["score"] = self.pers["summary"]["score"] + _id_7C6B134E84356E37;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + _id_68EB858FD6EA5428;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + _id_61339CC7C44BDE8B;
      break;
    default:
      self.pers["summary"]["score"] = self.pers["summary"]["score"] + _id_7C6B134E84356E37;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + _id_68EB858FD6EA5428;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + _id_61339CC7C44BDE8B;
      break;
  }
}

updaterank(_id_3D1080482DAC9C6A) {
  _id_5931B9C1E935811F = getrank();
  _id_091A1278FE976E80 = getprestigelevel();
  _id_E6633FE0FB633E52 = self.pers["rank"] + self.pers["prestige"];
  _id_7A8CD849F0DBF2C7 = _id_5931B9C1E935811F + _id_091A1278FE976E80;
  self.pers["rank"] = _id_5931B9C1E935811F;
  self.pers["prestige"] = _id_091A1278FE976E80;

  if(_id_7A8CD849F0DBF2C7 == _id_E6633FE0FB633E52 || _id_7A8CD849F0DBF2C7 >= level.maxrank + level.maxelderrank)
    return 0;

  self setrank(_id_5931B9C1E935811F, _id_091A1278FE976E80);
  return 1;
}

updaterankannouncehud() {
  self endon("disconnect");
  self notify("update_rank");
  self endon("update_rank");
  team = self.pers["team"];

  if(!isDefined(team)) {
    return;
  }
  if(!scripts\mp\flags::levelflag("game_over"))
    level scripts\engine\utility::waittill_notify_or_timeout("game_over", 0.25);

  _id_5931B9C1E935811F = self.pers["rank"] + self.pers["prestige"];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    player = level.players[_id_AC0E594AC96AA3A8];
    playerteam = player.pers["team"];

    if(isDefined(playerteam) && playerteam == team)
      player iprintln(&"RANK/PLAYER_WAS_PROMOTED", self, _id_5931B9C1E935811F + 1);
  }
}

queuescorepointspopup(amount) {
  self.scorepointsqueue = self.scorepointsqueue + amount;
}

flushscorepointspopupqueue() {
  scorepointspopup(self.scorepointsqueue);
  self.scorepointsqueue = 0;
}

flushscorepointspopupqueueonspawn() {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self notify("flushScorePointsPopupQueueOnspawn()");
  self endon("flushScorePointsPopupQueueOnspawn()");
  self waittill("spawned_player");
  wait 0.1;
  flushscorepointspopupqueue();
}

scorepointspopup(amount, _id_644B10FB91C1254C) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");

  if(istrue(level._id_BB8596FB319EB83E)) {
    return;
  }
  if(amount == 0) {
    return;
  }
  if(!scripts\mp\utility\player::isreallyalive(self) && !self _meth_8420670EAFC8D391() && !scripts\mp\utility\player::isusingremote()) {
    if(!istrue(_id_644B10FB91C1254C) || scripts\mp\utility\player::isinkillcam()) {
      queuescorepointspopup(amount);
      thread flushscorepointspopupqueueonspawn();
      return;
    }
  }

  self notify("scorePointsPopup");
  self endon("scorePointsPopup");
  self.scoreupdatetotal = self.scoreupdatetotal + amount;
  self setclientomnvar("ui_points_popup", self.scoreupdatetotal);
  self setclientomnvar("ui_points_popup_notify", gettime());
  wait 1.0;
  self.scoreupdatetotal = 0;
}

notifyplayerscore() {
  waitframe();
  level notify("update_player_score", self, self.scoreupdatetotal);
}

queuescoreeventpopup(event) {
  self.scoreeventqueue[self.scoreeventqueue.size] = event;
}

flushscoreeventpopupqueue() {
  _id_88B5EFD806F46560 = self.scoreeventqueue;
  self.scoreeventqueue = [];

  foreach(event in _id_88B5EFD806F46560)
  scoreeventpopup(event);
}

flushscoreeventpopupqueueonspawn() {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self notify("flushScoreEventPopupQueueOnspawn()");
  self endon("flushScoreEventPopupQueueOnspawn()");
  self waittill("spawned_player");
  wait 0.1;
  flushscoreeventpopupqueue();
}

getscoreeventpriority(event) {
  if(getdvarint("scr_disableScoreSplash", 0) == 1)
    return 0;

  value = getscoreinfocategory(event, "stat_F5B6EA8C35AC1E89");

  if(!istrue(value))
    return 0;

  return value;
}

scoreeventalwaysshowassplash(event) {
  if(getdvarint("scr_disableScoreSplash", 0) == 1)
    return 0;

  value = getscoreinfocategory(event, "stat_4EA41C9D7136599E");

  if(!istrue(value))
    return 0;

  return 1;
}

scoreeventhastext(event) {
  if(getdvarint("scr_disableScoreSplash", 0) == 1)
    return 0;

  eventid = getscoreinfocategory(event, "stat_EC3B335BB0B2F752");
  text = getscoreinfocategory(event, "stat_FA04F4EF1995407E");

  if(!isDefined(eventid) || eventid < 0 || !isDefined(text) || text == "")
    return 0;

  return 1;
}

scoreeventpopup(event) {
  if(getdvarint("scr_disableScoreSplash", 0) == 1) {
    return;
  }
  if(istrue(level._id_BB8596FB319EB83E)) {
    return;
  }
  if(isDefined(self.owner) && self.owner != self)
    self.owner scoreeventpopup(event);

  if(!isPlayer(self)) {
    return;
  }
  eventid = getscoreinfocategory(event, "stat_EC3B335BB0B2F752");
  text = getscoreinfocategory(event, "stat_FA04F4EF1995407E");

  if(!isDefined(eventid) || eventid < 0 || !isDefined(text) || text == "") {
    return;
  }
  _id_F331E293F923DC53 = 0;

  if(event == "stat_F954FA77F78FCA21" || event == "stat_59943F6A740F581B" || event == "stat_9A53FCA16067806B")
    _id_F331E293F923DC53 = 1;

  _id_0D78469A6A0ECC19 = !scripts\mp\utility\player::isreallyalive(self) && !_id_F331E293F923DC53;

  if(_id_0D78469A6A0ECC19 && !self _meth_8420670EAFC8D391() && !scripts\mp\utility\player::isusingremote()) {
    queuescoreeventpopup(event);
    thread flushscoreeventpopupqueueonspawn();
    return;
  }

  if(!isDefined(self.scoreeventlistsize)) {
    self.scoreeventlistsize = 1;
    thread clearscoreeventlistafterwait();
  } else {
    self.scoreeventlistsize++;

    if(self.scoreeventlistsize > 5) {
      self.scoreeventlistsize = 5;
      return;
    }
  }

  self setclientomnvar("ui_potg_score_event_list_" + self.scoreeventlistindex, eventid);
  self setclientomnvar("ui_score_event_list_" + self.scoreeventlistindex, eventid);
  self setclientomnvar("ui_score_event_control", self.scoreeventcount % 10);
  self setclientomnvar("ui_potg_score_event_control", self.scoreeventcount % 10);
  self.scoreeventlistindex++;
  self.scoreeventlistindex = self.scoreeventlistindex % 5;
  self.scoreeventcount++;
}

clearscoreeventlistafterwait() {
  self endon("disconnect");
  self notify("clearScoreEventListAfterWait()");
  self endon("clearScoreEventListAfterWait()");
  scripts\engine\utility::waittill_notify_or_timeout("death", 0.5);
  self.scoreeventlistsize = undefined;
}

getrank() {
  _id_C5732E73897E110B = self.pers["rankxp"];
  _id_C5B5347389C6B7D6 = self.pers["rank"];

  if(_id_C5732E73897E110B < getrankinfominxp(_id_C5B5347389C6B7D6) + getrankinfoxpamt(_id_C5B5347389C6B7D6))
    return _id_C5B5347389C6B7D6;
  else
    return getrankforxp(_id_C5732E73897E110B);
}

getrankforxp(_id_9F9DFAA0DD863910) {
  _id_C5B5347389C6B7D6 = level.maxrank;

  if(_id_9F9DFAA0DD863910 >= getrankinfominxp(_id_C5B5347389C6B7D6))
    return _id_C5B5347389C6B7D6;
  else
    _id_C5B5347389C6B7D6--;

  while(_id_C5B5347389C6B7D6 > 0) {
    if(_id_9F9DFAA0DD863910 >= getrankinfominxp(_id_C5B5347389C6B7D6) && _id_9F9DFAA0DD863910 < getrankinfominxp(_id_C5B5347389C6B7D6) + getrankinfoxpamt(_id_C5B5347389C6B7D6))
      return _id_C5B5347389C6B7D6;

    _id_C5B5347389C6B7D6--;
  }

  return _id_C5B5347389C6B7D6;
}

getmatchbonusspm() {
  _id_438C82141964EB5B = getrank() + 1;
  return (3 + _id_438C82141964EB5B * 0.5) * 10;
}

getprestigelevel() {
  if(isai(self) && isDefined(self.pers["prestige_fake"]))
    return self.pers["prestige_fake"];
  else
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "season_rank");
}

getrankxp() {
  return self.pers["rankxp"];
}

incrankxp(amount, objweapon, _id_DE29895DCA8987CE, type, _id_158745DE00C72D3E, _id_B01ACA3236595958) {
  if(!level.playerxpenabled) {
    return;
  }
  if(isai(self)) {
    return;
  }
  if(isDefined(self._id_F4E78B41C7D793A2) && !istrue(self._id_F4E78B41C7D793A2)) {
    return;
  }
  if(!isDefined(level.maxbetarank))
    level.maxbetarank = getdvarint("scr_beta_max_level", 0);

  if(level.maxbetarank > 0 && getrank() + 1 >= level.maxbetarank)
    amount = 0;

  if(!isDefined(_id_158745DE00C72D3E))
    _id_158745DE00C72D3E = amount;

  xp = getrankxp();
  _id_BEF14957020C6A3D = int(min(xp + amount, getrankinfomaxxp(level.maxrank) - 1));

  if(self.pers["rank"] == level.maxrank && _id_BEF14957020C6A3D >= getrankinfomaxxp(level.maxrank))
    _id_BEF14957020C6A3D = getrankinfomaxxp(level.maxrank);

  self.pers["xpEarnedThisMatch"] = self.pers["xpEarnedThisMatch"] + amount;
  self.pers["rankxp"] = _id_BEF14957020C6A3D;
  weapon = "";
  _id_904C82687DDFEB02 = 0;

  if(isDefined(objweapon)) {
    weapon = _id_2669878CF5A1B6BC::getweaponrootname(objweapon.basename);

    if(isDefined(level.weaponmapdata[weapon]) && isDefined(level.weaponmapdata[weapon]._id_904C82687DDFEB02))
      _id_904C82687DDFEB02 = level.weaponmapdata[weapon]._id_904C82687DDFEB02;
  }

  _id_904C82687DDFEB02 = _id_064CA1AA18FDEABC(_id_904C82687DDFEB02, _id_B01ACA3236595958);

  if(_id_DE29895DCA8987CE > 0 && _id_904C82687DDFEB02 == 0) {}

  _id_F078590F66174E29 = _id_6352822C84CB9722();
  _id_F761F69E71210F99 = amount * _id_F078590F66174E29;
  _id_F761F69E71210F99 = int(_id_F761F69E71210F99);
  _id_457E79C91A142869 = int(amount);
  _id_EDFAF8A1EE65E5B1 = [];

  if(amount > 0) {
    _id_EDFAF8A1EE65E5B1[_id_EDFAF8A1EE65E5B1.size] = 31;
    _id_EDFAF8A1EE65E5B1[_id_EDFAF8A1EE65E5B1.size] = amount;
  }

  if(_id_DE29895DCA8987CE > 0) {
    if(level.onlinegame && self _meth_2129E0E4D014E1B3()) {
      _id_796AEC2915BE9ED7 = getdvarfloat("dvar_AE1BEF48F6B2083C", 1.25);
      _id_DE29895DCA8987CE = int(_id_DE29895DCA8987CE * _id_796AEC2915BE9ED7);
    }

    _id_EDFAF8A1EE65E5B1[_id_EDFAF8A1EE65E5B1.size] = 45;
    _id_EDFAF8A1EE65E5B1[_id_EDFAF8A1EE65E5B1.size] = _id_DE29895DCA8987CE;
    _id_EDFAF8A1EE65E5B1[_id_EDFAF8A1EE65E5B1.size] = 44;
    _id_EDFAF8A1EE65E5B1[_id_EDFAF8A1EE65E5B1.size] = _id_904C82687DDFEB02;
  }

  if(_id_158745DE00C72D3E > 0) {
    _id_EDFAF8A1EE65E5B1[_id_EDFAF8A1EE65E5B1.size] = 0;
    _id_EDFAF8A1EE65E5B1[_id_EDFAF8A1EE65E5B1.size] = _id_158745DE00C72D3E;
  }

  if(_id_F761F69E71210F99 > 0) {
    _id_F7A4049E7169C7FC = scripts\cp_mp\challenges::_id_AFF35122A61A900B(self.team);
    _id_EDFAF8A1EE65E5B1[_id_EDFAF8A1EE65E5B1.size] = 19;
    _id_EDFAF8A1EE65E5B1[_id_EDFAF8A1EE65E5B1.size] = _id_F761F69E71210F99;
    _id_EDFAF8A1EE65E5B1[_id_EDFAF8A1EE65E5B1.size] = 20;
    _id_EDFAF8A1EE65E5B1[_id_EDFAF8A1EE65E5B1.size] = _id_F7A4049E7169C7FC;
  }

  if(_id_457E79C91A142869 > 0) {
    _id_EDFAF8A1EE65E5B1[_id_EDFAF8A1EE65E5B1.size] = 3;
    _id_EDFAF8A1EE65E5B1[_id_EDFAF8A1EE65E5B1.size] = _id_457E79C91A142869;
  }

  _id_EDFAF8A1EE65E5B1[_id_EDFAF8A1EE65E5B1.size] = 32;
  _id_EDFAF8A1EE65E5B1[_id_EDFAF8A1EE65E5B1.size] = 1;
  _id_B2FF82EC901486E4 = scripts\cp_mp\challenges::getchallengegamemode(self);
  _id_EDFAF8A1EE65E5B1[_id_EDFAF8A1EE65E5B1.size] = 8;
  _id_EDFAF8A1EE65E5B1[_id_EDFAF8A1EE65E5B1.size] = _id_B2FF82EC901486E4;
  self _meth_DB073176839D77FB("95", _id_EDFAF8A1EE65E5B1);
  self.pers["summary"]["weaponXP"] = self.pers["summary"]["weaponXP"] + _id_DE29895DCA8987CE;
  self.pers["summary"]["operatorXP"] = self.pers["summary"]["operatorXP"] + _id_F761F69E71210F99;
  self.pers["summary"]["clanXP"] = self.pers["summary"]["clanXP"] + _id_457E79C91A142869;
  self.pers["summary"]["battlepassXP"] = self.pers["summary"]["battlepassXP"] + _id_158745DE00C72D3E;
  scripts\mp\analyticslog::logevent_xpearned(self, amount, weapon, _id_DE29895DCA8987CE, type);
}

syncxpstat() {
  xp = getrankxp();
  _id_3D1080482DAC9C6A = self getplayerdata("common", "mpProgression", "playerLevel", "xp");

  if(_id_3D1080482DAC9C6A > xp) {
    return;
  }
  self setplayerdata("common", "mpProgression", "playerLevel", "xp", xp);
}

delayplayerscorepopup(_id_74B5B12BB6514385, event, victim) {
  wait(_id_74B5B12BB6514385);
  thread scripts\mp\utility\points::_id_0366980B6A8796AE(event);
}

getgametypexpmultiplier() {
  _id_4EDC3C9966D2D422 = getdvarfloat(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_match_bonus_scalar_override"), 0.0);

  if(_id_4EDC3C9966D2D422 > 0)
    return _id_4EDC3C9966D2D422;

  if(getdvarint("dvar_78653010D584AA6E", 0) == 0) {
    if(!isDefined(level.gametypexpmodifier))
      level.gametypexpmodifier = float(tablelookup("mp/gametypesTable.csv", 0, scripts\mp\utility\game::getgametype(), 17));

    return level.gametypexpmodifier;
  }

  return level._id_62F6F7640E4431E3._id_B55C419A0DD99381;
}

addglobalrankxpmultiplier(_id_98EA5AFB293A76A2, ref) {
  level addrankxpmultiplier(_id_98EA5AFB293A76A2, ref);
}

getglobalrankxpmultiplier() {
  _id_99C98EF413B2A3A4 = level getrankxpmultiplier();
  _id_018648EB9853B55B = getdvarint("dvar_A429AB6EDB6E3023", 0) == 0;

  if((_id_99C98EF413B2A3A4 > 4 || _id_99C98EF413B2A3A4 < 0) && _id_018648EB9853B55B)
    exitlevel(0);

  return _id_99C98EF413B2A3A4;
}

addrankxpmultiplier(_id_98EA5AFB293A76A2, ref) {
  _id_427D7621553DFFF6 = 4 / level getrankxpmultiplier();

  if(_id_98EA5AFB293A76A2 > _id_427D7621553DFFF6) {
    return;
  }
  if(!isDefined(self.rankxpmultipliers))
    self.rankxpmultipliers = [];

  if(isDefined(self.rankxpmultipliers[ref]))
    self.rankxpmultipliers[ref] = max(self.rankxpmultipliers[ref], _id_98EA5AFB293A76A2);
  else
    self.rankxpmultipliers[ref] = _id_98EA5AFB293A76A2;
}

_id_665218C7A5BAA481(ref) {
  if(!isDefined(self.rankxpmultipliers) || !isDefined(self.rankxpmultipliers[ref]))
    return 1.0;

  return self.rankxpmultipliers[ref];
}

getrankxpmultiplier() {
  if(!isDefined(self.rankxpmultipliers))
    return 1.0;

  _id_7662D3C556FCCB56 = 1.0;

  foreach(modifier in self.rankxpmultipliers) {
    if(!isDefined(modifier)) {
      continue;
    }
    _id_7662D3C556FCCB56 = _id_7662D3C556FCCB56 * modifier;
  }

  return _id_7662D3C556FCCB56;
}

getplatformrankxpmultiplier() {
  if(scripts\mp\utility\game::getgametype() == "br" && self isbnetigrplayer())
    return getbnetigrplayerxpmultiplier();
  else if(self isps4player()) {
    _id_3901AB9D84BEDB23 = getdvarfloat("dvar_010F733902FB6E20", 1.0);
    return _id_3901AB9D84BEDB23;
  }

  return 1.0;
}

removeglobalrankxpmultiplier(ref) {
  level removerankxpmultiplier(ref);
}

removerankxpmultiplier(ref) {
  if(!isDefined(self.rankxpmultipliers)) {
    return;
  }
  if(!isDefined(self.rankxpmultipliers[ref])) {
    return;
  }
  self.rankxpmultipliers[ref] = undefined;
}

addteamrankxpmultiplier(_id_98EA5AFB293A76A2, team, ref) {
  if(!level.teambased)
    team = "all";

  if(!isDefined(self.teamrankxpmultipliers))
    level.teamrankxpmultipliers = [];

  if(!isDefined(level.teamrankxpmultipliers[team]))
    level.teamrankxpmultipliers[team] = [];

  if(isDefined(level.teamrankxpmultipliers[team][ref]))
    level.teamrankxpmultipliers[team][ref] = max(self.teamrankxpmultipliers[team][ref], _id_98EA5AFB293A76A2);
  else
    level.teamrankxpmultipliers[team][ref] = _id_98EA5AFB293A76A2;
}

_id_3C5E15B220A3852A(team, ref) {
  if(!level.teambased)
    team = "all";

  if(!isDefined(self.teamrankxpmultipliers) || !isDefined(level.teamrankxpmultipliers[team]) || !isDefined(level.teamrankxpmultipliers[team][ref]))
    return 1.0;

  return level.teamrankxpmultipliers[team][ref];
}

removeteamrankxpmultiplier(team, ref) {
  if(!level.teambased)
    team = "all";

  if(!isDefined(level.teamrankxpmultipliers)) {
    return;
  }
  if(!isDefined(level.teamrankxpmultipliers[team])) {
    return;
  }
  if(!isDefined(level.teamrankxpmultipliers[team][ref])) {
    return;
  }
  level.teamrankxpmultipliers[team][ref] = undefined;
}

getteamrankxpmultiplier(team) {
  if(!level.teambased)
    team = "all";

  if(!isDefined(team) || !isDefined(level.teamrankxpmultipliers) || !isDefined(level.teamrankxpmultipliers[team]))
    return 1.0;

  _id_7662D3C556FCCB56 = 1.0;

  foreach(modifier in level.teamrankxpmultipliers[team]) {
    if(!isDefined(modifier)) {
      continue;
    }
    _id_7662D3C556FCCB56 = _id_7662D3C556FCCB56 * modifier;
  }

  return _id_7662D3C556FCCB56;
}

getrankxpmultipliertotal() {
  _id_39FBCC95C12E7F4D = getrankxpmultiplier();
  _id_17ADAB2B5FACD077 = getglobalrankxpmultiplier();
  _id_D522EA6454844EB9 = getteamrankxpmultiplier(self.team);
  _id_C75E49D88DF27EBB = getplatformrankxpmultiplier();
  _id_62563A3AB1624A5A = _id_39FBCC95C12E7F4D * _id_17ADAB2B5FACD077 * _id_D522EA6454844EB9 * _id_C75E49D88DF27EBB;
  return _id_62563A3AB1624A5A;
}

_id_B1BBF2BA52EB5C94(_id_98EA5AFB293A76A2, ref) {
  level _id_E43F9C736A23F8A7(_id_98EA5AFB293A76A2, ref);
}

_id_5ADB64FFE05CC777() {
  _id_99C98EF413B2A3A4 = level _id_4BEAED7D0E5C5B78();
  _id_018648EB9853B55B = getdvarint("dvar_A429AB6EDB6E3023", 0) == 0;

  if((_id_99C98EF413B2A3A4 > 4 || _id_99C98EF413B2A3A4 < 0) && _id_018648EB9853B55B)
    exitlevel(0);

  return _id_99C98EF413B2A3A4;
}

_id_E43F9C736A23F8A7(_id_98EA5AFB293A76A2, ref) {
  _id_427D7621553DFFF6 = 4 / level _id_4BEAED7D0E5C5B78();

  if(_id_98EA5AFB293A76A2 > _id_427D7621553DFFF6) {
    return;
  }
  if(!isDefined(self._id_2914BA3B302CA331))
    self._id_2914BA3B302CA331 = [];

  if(isDefined(self._id_2914BA3B302CA331[ref]))
    self._id_2914BA3B302CA331[ref] = max(self._id_2914BA3B302CA331[ref], _id_98EA5AFB293A76A2);
  else
    self._id_2914BA3B302CA331[ref] = _id_98EA5AFB293A76A2;
}

_id_6352822C84CB9722() {
  _id_39FBCC95C12E7F4D = _id_4BEAED7D0E5C5B78();
  _id_17ADAB2B5FACD077 = _id_E7B697C34BEA0FC1();
  return _id_39FBCC95C12E7F4D * _id_17ADAB2B5FACD077;
}

_id_4BEAED7D0E5C5B78() {
  if(!isDefined(self._id_2914BA3B302CA331))
    return 1.0;

  _id_7662D3C556FCCB56 = 1.0;

  foreach(modifier in self._id_2914BA3B302CA331) {
    if(!isDefined(modifier)) {
      continue;
    }
    _id_7662D3C556FCCB56 = _id_7662D3C556FCCB56 * modifier;
  }

  return _id_7662D3C556FCCB56;
}

_id_E7B697C34BEA0FC1() {
  return level _id_4BEAED7D0E5C5B78();
}

_id_531E069621C1F4C2() {
  if(getdvarint("dvar_78653010D584AA6E", 0) == 0) {
    if(!isDefined(level.gametypeweaponxpmodifier))
      level.gametypeweaponxpmodifier = float(tablelookup("mp/gametypesTable.csv", 0, scripts\mp\utility\game::getgametype(), 19));

    return level.gametypeweaponxpmodifier;
  }

  return level._id_62F6F7640E4431E3._id_3C836934A83182A5;
}

_id_7E269762B075143D() {
  return 1.0;
}

_id_FE885EED6609E08A(value, _id_B01ACA3236595958) {
  if(isDefined(_id_B01ACA3236595958) && isDefined(_id_B01ACA3236595958._id_DD7D0DDB84506614))
    return _id_B01ACA3236595958._id_DD7D0DDB84506614;

  return value;
}

_id_78802B8C6DE6EEBA(value, _id_B01ACA3236595958) {
  if(isDefined(_id_B01ACA3236595958) && isDefined(_id_B01ACA3236595958._id_68EB858FD6EA5428))
    return _id_B01ACA3236595958._id_68EB858FD6EA5428;

  return value;
}

_id_C18C8BB0776284C6(value, _id_B01ACA3236595958) {
  if(isDefined(_id_B01ACA3236595958) && isDefined(_id_B01ACA3236595958._id_05DB83A557FCD180))
    return _id_B01ACA3236595958._id_05DB83A557FCD180;

  return value;
}

_id_9E1336D25EB66326(value, _id_B01ACA3236595958) {
  if(isDefined(_id_B01ACA3236595958) && isDefined(_id_B01ACA3236595958._id_E2DDE397B32F23BC))
    return _id_B01ACA3236595958._id_E2DDE397B32F23BC;

  return value;
}

_id_C465F9A27979C865(value, _id_B01ACA3236595958) {
  if(isDefined(_id_B01ACA3236595958) && isDefined(_id_B01ACA3236595958._id_EFE4124EAA21EA43))
    return _id_B01ACA3236595958._id_EFE4124EAA21EA43;

  return value;
}

_id_736110BFD2A3A5EA(value, _id_B01ACA3236595958) {
  if(isDefined(_id_B01ACA3236595958) && isDefined(_id_B01ACA3236595958._id_DD7D0DDB84506614))
    return _id_B01ACA3236595958._id_DD7D0DDB84506614;

  return value;
}

_id_199D881C43179C3F(value, _id_B01ACA3236595958) {
  if(isDefined(_id_B01ACA3236595958) && isDefined(_id_B01ACA3236595958._id_CC603E175ABFEF2D))
    return _id_B01ACA3236595958._id_CC603E175ABFEF2D;

  return value;
}

_id_064CA1AA18FDEABC(value, _id_B01ACA3236595958) {
  if(isDefined(_id_B01ACA3236595958) && isDefined(_id_B01ACA3236595958._id_904C82687DDFEB02))
    return _id_B01ACA3236595958._id_904C82687DDFEB02;

  return value;
}