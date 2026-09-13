/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_28a1eb678d22e4e3.gsc
***********************************************/

_id_FB7271D5EE18B98D(data) {
  level._id_11CF2E43F74913DF = spawnStruct();
  level._id_11CF2E43F74913DF.time = getdvarint("dvar_F3296F3F7C79BFB8", 240);
  level._id_11CF2E43F74913DF.maxrange = getdvarint("dvar_79550894C085D1DB", 45000);
  level._id_11CF2E43F74913DF._id_8F7C18F3DCCE9DFF = getdvarint("dvar_1B3CC7A99C2F33E5", 25000);
  game["dialog"]["mission_infiltration_accept"] = "mission_mission_time_accept";
  game["dialog"]["mission_infiltration_fail"] = "mission_mission_time_failed";
  data.funcs["onInit"] = ::_id_712CF8277BCBD463;
  data.funcs["onTeamAssigned"] = ::_id_C53C8C4438DE68A4;
}

_id_712CF8277BCBD463() {
  if(_id_744CAD313ED0A87E::_id_A9B26D3ED078E149())
    self.tablet.startdisabled = 1;

  self.tablet._id_B393CB8247AA43E1 = 1;
  return 1;
}

_id_C53C8C4438DE68A4() {
  if(!isDefined(self._id_276AC5E84835EA87)) {
    _id_276AC5E84835EA87 = self.tablet _id_FB13F636F30F3817();

    if(!isDefined(_id_276AC5E84835EA87)) {
      thread _id_34BD31F3BEBA8F5A(1);
      return;
    }

    self._id_276AC5E84835EA87 = _id_276AC5E84835EA87;
  }

  _id_64ACB6CE534155B7::uiobjectiveshowtoteam("strongholdInfil", self.teams[0]);
  time = level._id_11CF2E43F74913DF.time;
  time = _id_64ACB6CE534155B7::_id_9B6275085FBCB8F4(time);
  _id_64ACB6CE534155B7::_id_5A15174D34F0670C(time);
  thread _id_B8BAB058C4C9CCB4(time);
  thread _id_3B7D7950DDA9E2B5();
  _id_64ACB6CE534155B7::displayteamsplash(self.teams[0], "stronghold_infil_contract_accepted");
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_infiltration_accept", self.teams[0], 1, 1);
  self.curorigin = self._id_276AC5E84835EA87.origin;
  _id_64ACB6CE534155B7::createquestobjicon("ui_map_icon_obj_fortress", "current", self.curorigin + (0, 0, 65));
  players = scripts\mp\utility\teams::getteamdata(self.teams[0], "players");

  foreach(player in players)
  _id_64ACB6CE534155B7::showquestobjicontoplayer(player);

  thread _id_E3EEF0B907523E1D();
}

_id_34BD31F3BEBA8F5A(success) {
  self notify("task_ended");

  if(isDefined(self.objectiveiconid))
    _id_64ACB6CE534155B7::deletequestobjicon();

  wait 1.0;
  _id_64ACB6CE534155B7::_id_93663FE58D95F174(scripts\engine\utility::ter_op(istrue(success), self.teams[0], undefined));

  if(isDefined(self._id_276AC5E84835EA87) && istrue(success)) {
    self._id_276AC5E84835EA87._id_7F893C2E20A823DB = 1;
    self._id_276AC5E84835EA87._id_21D7DEF7D337F552 = self.teams[0];
    self._id_276AC5E84835EA87 notify("stronghold_infiltrated");
    _id_4948CDF739393D2D::_id_D95DBF57B47734D9(self._id_276AC5E84835EA87, 1);
    logstring("BR STRONGHOLD " + scripts\engine\utility::array_find(level._id_F1073FBD45B59A06._id_DF987907A483DF89, self._id_276AC5E84835EA87) + ": Fortress Infiltrated!");
  } else if(istrue(success)) {
    params = spawnStruct();
    _id_501265B5FE210821 = _id_64ACB6CE534155B7::_id_D282041688C032B5("strongholdInfil");
    params.intvar = _id_501265B5FE210821;
    _id_64ACB6CE534155B7::_id_878EBCC241B54505("stronghold_infil_contract_none", _id_64ACB6CE534155B7::_id_3D262D56274BD22E("strongholdInfil"), _id_501265B5FE210821, self.teams[0]);

    foreach(player in scripts\mp\utility\teams::getteamdata(self.teams[0], "players")) {
      player _id_6AFF3948CF4CCA03::playerplunderpickup(_id_501265B5FE210821);
      player _id_6AFF3948CF4CCA03::_id_05A2284274D70F7D(1, _id_501265B5FE210821);
    }

    logstring("BR STRONGHOLDS ERROR: Undefined Fortress Infiltrated!");
  }
}

_id_B8BAB058C4C9CCB4(time) {
  self endon("task_ended");
  level endon("game_ended");
  wait(time);
  _id_832B654E4B84C000();
}

_id_3B7D7950DDA9E2B5() {
  self endon("task_ended");
  level endon("game_ended");
  self._id_276AC5E84835EA87 waittill("stronghold_infiltrated");
  _id_832B654E4B84C000(1);
}

_id_832B654E4B84C000(_id_257A28CD85BD4479) {
  if(!isDefined(_id_257A28CD85BD4479))
    _id_257A28CD85BD4479 = 0;

  params = spawnStruct();
  params.intvar = 0;
  _id_1B4ADA49A21B51CA = "stronghold_infil_contract_failed";

  if(istrue(_id_257A28CD85BD4479))
    _id_1B4ADA49A21B51CA = "stronghold_infil_contract_poached";

  _id_64ACB6CE534155B7::displayteamsplash(self.teams[0], _id_1B4ADA49A21B51CA, params);
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_infiltration_fail", self.teams[0], 1, 1);
  thread _id_34BD31F3BEBA8F5A(0);
}

_id_FB13F636F30F3817(_id_D83087EC1B2D5259) {
  locations = scripts\engine\utility::array_randomize(level._id_F1073FBD45B59A06._id_DF987907A483DF89);
  _id_276AC5E84835EA87 = undefined;
  _id_02ED718E1DA0B965 = undefined;
  _id_BE0F4D48FA40793F = level._id_11CF2E43F74913DF.maxrange;

  foreach(location in locations) {
    if(istrue(location._id_7F893C2E20A823DB)) {
      continue;
    }
    if(istrue(location._id_933F9685674999FB) && !istrue(_id_D83087EC1B2D5259)) {
      continue;
    }
    _id_B1E1B0A993DBD52A = _id_58F20490049AF6AC::_id_A465E3C1371D7DAB(location.origin);

    if(!istrue(_id_B1E1B0A993DBD52A)) {
      continue;
    }
    if(istrue(location._id_9611BF5BFF3C688C)) {
      continue;
    }
    dist = distance2d(location.origin, self.origin);
    _id_5435995E95681B89 = 0;

    if(dist > level._id_11CF2E43F74913DF._id_8F7C18F3DCCE9DFF)
      _id_5435995E95681B89 = dist - level._id_11CF2E43F74913DF._id_8F7C18F3DCCE9DFF;

    if(_id_5435995E95681B89 < _id_BE0F4D48FA40793F) {
      _id_BE0F4D48FA40793F = _id_5435995E95681B89;
      _id_276AC5E84835EA87 = location;

      if(_id_5435995E95681B89 <= 0) {
        break;
      }
    }
  }

  return _id_276AC5E84835EA87;
}

_id_1CF1557A05B2AE73(spawn_origin, team) {
  finishlinevfx = spawnfx(level._effect["vfx_marker_base_orange_pulse"], spawn_origin + (0, 0, 10));
  finishlinevfx.angles = vectortoangles((0, 0, 1));
  finishlinevfx hide();
  wait 0.5;
  triggerfx(finishlinevfx);

  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players"))
  finishlinevfx showtoplayer(player);

  self.finishlinevfx = finishlinevfx;
}

_id_E3EEF0B907523E1D() {
  self endon("task_ended");
  level endon("game_ended");

  for(;;) {
    foreach(player in scripts\mp\utility\teams::getteamdata(self.teams[0], "players")) {
      if(distance2d(player.origin, self._id_276AC5E84835EA87._id_E1DD7BED632A13C3.origin) < self._id_276AC5E84835EA87._id_E1DD7BED632A13C3.radius) {
        params = spawnStruct();
        _id_501265B5FE210821 = _id_64ACB6CE534155B7::_id_D282041688C032B5("strongholdInfil");
        params.intvar = _id_501265B5FE210821;

        foreach(player in scripts\mp\utility\teams::getteamdata(self.teams[0], "players")) {
          player _id_6AFF3948CF4CCA03::playerplunderpickup(_id_501265B5FE210821);
          player _id_6AFF3948CF4CCA03::_id_05A2284274D70F7D(1, _id_501265B5FE210821);
        }

        _id_64ACB6CE534155B7::_id_878EBCC241B54505("stronghold_infil_contract_completed", _id_64ACB6CE534155B7::_id_3D262D56274BD22E("strongholdInfil"), _id_501265B5FE210821, self.teams[0]);
        level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_misc_success", self.teams[0], 1, 1);
        _id_51F2B611A0573B40 = scripts\mp\utility\teams::getteamdata(self.teams[0], "players");
        self.rewardmodifier = undefined;
        self.result = "success";
        thread _id_34BD31F3BEBA8F5A(1);
        return;
      }
    }

    waitframe();
  }
}