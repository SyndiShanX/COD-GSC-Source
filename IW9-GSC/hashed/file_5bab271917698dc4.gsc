/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5bab271917698dc4.gsc
***********************************************/

_id_2A11E499A21720EC(_id_8F7040E569EC9E98, _id_4AC881E2A39322A5, _id_57D71760971F748F, _id_5806C4765695A2F4, _id_74AF5908127B6729, _id_36F3C4E4A602E257, _id_DF631FDD92A76BB1, _id_B6ACF0C07C4311E6) {
  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("kioskRevivePlayer"))
    _id_8F7040E569EC9E98 thread _id_362C58E8BB39BCDA::runbrgametypefunc("kioskRevivePlayer", _id_4AC881E2A39322A5);
  else
    _id_8F7040E569EC9E98 thread _id_67708F418B1FAC79::playergulagautowin("br_kioskRevive", _id_4AC881E2A39322A5, _id_57D71760971F748F, _id_5806C4765695A2F4, _id_74AF5908127B6729, _id_36F3C4E4A602E257, _id_DF631FDD92A76BB1, _id_B6ACF0C07C4311E6);
}

_id_D5EE3D3FAD992D43(_id_A7E165A26E5BA7E9, _id_30A91E1938CFD1B2, _id_06FF65A93BB36C6A) {
  player = self;

  if(istrue(level.brgametype._id_6F3C4D74A8C614AB))
    player notify("started_spawnPlayer");

  if(isDefined(_id_30A91E1938CFD1B2._id_B90BD4C9BEF3FB64)) {
    _id_C7094F9A17968AB2 = self[[_id_30A91E1938CFD1B2._id_B90BD4C9BEF3FB64]](_id_30A91E1938CFD1B2._id_9FDC1F9E4FC628E4);

    if(!istrue(_id_C7094F9A17968AB2))
      return;
  }

  _id_1476E0F78320A501 = 0;

  if(istrue(level.brgametype._id_A916B204F027AF6B))
    _id_1476E0F78320A501 = player playerwaitforprestreaming();

  streamtimeout = _id_2CEDCC356F1B9FC8::getdefaultstreamhinttimeoutms() / 1000;

  if(isDefined(_id_06FF65A93BB36C6A))
    spawnpoint = _id_06FF65A93BB36C6A;
  else
    spawnpoint = _id_952548D8AED47102(0, streamtimeout);

  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("modifyRespawnPoint"))
    _id_362C58E8BB39BCDA::runbrgametypefunc("modifyRespawnPoint", spawnpoint, streamtimeout);

  if(isDefined(_id_06FF65A93BB36C6A))
    _id_11F3B4465C8B637B = spawnpoint.origin;
  else
    _id_11F3B4465C8B637B = playerprestreamrespawnorigin(spawnpoint);

  self.forcespawnorigin = _id_11F3B4465C8B637B;

  if(isDefined(_id_A7E165A26E5BA7E9))
    wait(_id_A7E165A26E5BA7E9);

  if(_id_1476E0F78320A501)
    player scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");

  player thread _id_334A8FE67E88BBE7();
  player thread _id_9CEB26B230856D29();
  player _id_6489FCDFE6FA2E36::playerclearspectatekillchainsystem();
  _id_B59F471C2C064E56 = 1.0;
  wait(_id_B59F471C2C064E56);
  player scripts\mp\hud_message::clearsplashqueue();
  player scripts\mp\playerlogic::spawnplayer(undefined, 0);
  player scripts\cp_mp\execution::_clearexecution();
  player _id_7E52B56769FA7774::initplayer();
  player.respawningfromtoken = undefined;

  if(isDefined(_id_30A91E1938CFD1B2._id_46FF3A000308206A))
    player thread triggerrespawnoverlay(_id_30A91E1938CFD1B2._id_46FF3A000308206A);

  if(isDefined(player))
    _id_7642A6BEE4CDAAA2(spawnpoint, _id_11F3B4465C8B637B, _id_30A91E1938CFD1B2);
}

_id_7642A6BEE4CDAAA2(spawnpoint, _id_11F3B4465C8B637B, _id_30A91E1938CFD1B2) {
  scripts\cp_mp\calloutmarkerping::calloutmarkerping_removeallcalloutsforplayer();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "isEnabled") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "isEnabled")]]() && scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "enablePlayer"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "enablePlayer")]](self, "player_dead");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "isEnabled") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "isEnabled")]]() && scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "enablePlayer"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "enablePlayer")]](self, "br_gulag");

  _id_0D4066589FEF0017 = 0;

  if(isDefined(_id_30A91E1938CFD1B2._id_5B6FE32D0163F96A))
    _id_0D4066589FEF0017 = self[[_id_30A91E1938CFD1B2._id_5B6FE32D0163F96A]](_id_30A91E1938CFD1B2._id_9FDC1F9E4FC628E4);

  level notify("update_circle_hide");

  if(isDefined(self.oobimmunity))
    scripts\mp\outofbounds::disableoobimmunity(self);

  _id_1E4A61DB11011446::givelaststandifneeded(self);

  if(istrue(_id_0D4066589FEF0017)) {
    return;
  }
  if(!isDefined(spawnpoint))
    spawnpoint = _id_952548D8AED47102();

  spawnorigin = spawnpoint.origin;
  spawnangles = spawnpoint.angles;
  startorigin = spawnorigin;

  if(isDefined(_id_11F3B4465C8B637B))
    startorigin = _id_11F3B4465C8B637B;

  _id_961B4AFC4C695B94();
  _id_AB31CF673D70F72D(startorigin, spawnangles);
  linker = spawn("script_model", startorigin);
  linker setModel("tag_origin");
  linker.angles = spawnangles;
  linker hide();
  linker showtoplayer(self);
  self playerlinktoabsolute(linker, "tag_origin");
  scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
  scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("br_spawnrespawn::br_respawn()");
  thread playercleanupentondisconnect(linker);
  waitframe();

  if(getDvar("dvar_87485ECA39B418A6") == "1" && !isbot(self) && scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587() && !istrue(self.gulag))
    scripts\mp\playerlogic::_id_8F1890D7F6B565C4();

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(_id_30A91E1938CFD1B2._id_260A81DF7CA3956D))
    self[[_id_30A91E1938CFD1B2._id_260A81DF7CA3956D]](_id_30A91E1938CFD1B2._id_9FDC1F9E4FC628E4);

  if(getdvarint("dvar_DF02345C60008647", 1) == 0)
    _id_2CEDCC356F1B9FC8::playerwaittillstreamhintcomplete();

  _id_2CEDCC356F1B9FC8::playerclearstreamhintorigin();

  if(isDefined(_id_11F3B4465C8B637B))
    linker.origin = spawnorigin;

  self clearsoundsubmix("deaths_door_mp");
  self clearsoundsubmix("iw9_mp_killcam");
  wait 0.5;

  if(isDefined(_id_30A91E1938CFD1B2._id_95C583A6D556569A))
    linker playsoundtoplayer(_id_30A91E1938CFD1B2._id_95C583A6D556569A, self);

  wait 1;

  if(!isDefined(self)) {
    return;
  }
  if(!self islinked())
    _id_AB31CF673D70F72D(spawnorigin, spawnangles);

  self unlink();
  self clearclienttriggeraudiozone(1);

  if(_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF())
    self clearsoundsubmix("iw8_br_gulag_tutorial", 2);
  else
    self clearsoundsubmix("solo_cin_igc_music", 2);

  scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76(1);
  _id_D669022F6CD65402(1);
  _id_BDA1DE83E1856735 = 0;

  if(isDefined(level.parachutedeploydelay))
    _id_BDA1DE83E1856735 = level.parachutedeploydelay;

  if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF())
    thread scripts\cp_mp\parachute::startfreefall(_id_BDA1DE83E1856735, 0, undefined, undefined, 1);

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    self setclientomnvar("ui_show_spectateHud", -1);

  resetplayermovespeedscale();

  if(isDefined(_id_30A91E1938CFD1B2._id_104E34B87A973660))
    thread triggerrespawnoverlay(_id_30A91E1938CFD1B2._id_104E34B87A973660);

  if(istrue(_id_30A91E1938CFD1B2._id_03BD8653773757C7))
    self setclientomnvar("ui_br_transition_type", 0);

  if(!_id_362C58E8BB39BCDA::isfeaturedisabled("armor") && !istrue(_id_30A91E1938CFD1B2._id_9FDC1F9E4FC628E4._id_AB53D8433A949828)) {
    _id_968BD61837A9C038 = getdvarint("dvar_3C87CCC2C15B53A4", 150);
    _id_381776CAE951DA48 = getdvarint("dvar_8B8E8245086EFDD1", 0);
    _id_07C40FA80892A721::givestartingarmor(_id_968BD61837A9C038, undefined, _id_381776CAE951DA48);
  }

  _id_64ACB6CE534155B7::onplayerrespawn();
  _id_3ACF1C0EBAF602F2::onplayerrespawn();
  _id_4D5A55FCA0ED1835::onplayerrespawn();
  _id_046CF752D93DC17B::_id_F5D7F1682F6FC578();

  if(isDefined(_id_30A91E1938CFD1B2._id_D6433DA0DDC40010))
    self[[_id_30A91E1938CFD1B2._id_D6433DA0DDC40010]](_id_30A91E1938CFD1B2._id_9FDC1F9E4FC628E4);

  wait 0.5;

  if(!isDefined(self)) {
    return;
  }
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    thread _id_E68E4BB4F65F5FE4();

  self notify("respawn_fade_from_black");
  thread _id_1E4A61DB11011446::_id_467380E90C7DB5A7();
  waitframe();
  linker delete();

  if(istrue(level._id_3FF7C73209FCF59D))
    _id_002E0206D4774172::_id_FA674FB6E8372620();

  if(_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF())
    self notify("respawn_from_gulag");

  self notify("can_show_splashes");

  if(!istrue(level.ignoregulagredeploysplash) && isDefined(_id_30A91E1938CFD1B2._id_4A8A68AFCCFA6692))
    thread scripts\mp\hud_message::showsplash(_id_30A91E1938CFD1B2._id_4A8A68AFCCFA6692, _id_30A91E1938CFD1B2._id_24FBC5C0DA36EF41, undefined, undefined, undefined, _id_30A91E1938CFD1B2._id_748A99415228DE0E);

  if(isDefined(_id_30A91E1938CFD1B2._id_DD58A7AFDB07F8CD))
    _id_2CEDCC356F1B9FC8::brleaderdialogplayer(_id_30A91E1938CFD1B2._id_DD58A7AFDB07F8CD, self, undefined, undefined, 0, undefined, _id_30A91E1938CFD1B2._id_A256BBF96994AAD1);

  if(isDefined(_id_30A91E1938CFD1B2._id_03BE6A6420B9E919))
    self[[_id_30A91E1938CFD1B2._id_03BE6A6420B9E919]](_id_30A91E1938CFD1B2._id_9FDC1F9E4FC628E4);

  if(_id_396A814D39E7044F::_id_7BA31CB6B21C346F()) {
    if(isDefined(_id_30A91E1938CFD1B2._id_9FDC1F9E4FC628E4._id_4AC881E2A39322A5) && _id_30A91E1938CFD1B2._id_9FDC1F9E4FC628E4._id_4AC881E2A39322A5 != self)
      thread _id_396A814D39E7044F::_id_36EDF91561322753(1);
  }
}

_id_ADE48AF7C782E202(_id_441BCD0BA1507F10, soundalias, _id_03BD8653773757C7) {
  _id_CDD53A78F51F64FE = spawnStruct();
  _id_CDD53A78F51F64FE._id_260A81DF7CA3956D = _id_441BCD0BA1507F10;
  _id_CDD53A78F51F64FE._id_95C583A6D556569A = soundalias;
  _id_CDD53A78F51F64FE._id_03BD8653773757C7 = _id_03BD8653773757C7;
  _id_CDD53A78F51F64FE._id_9FDC1F9E4FC628E4 = spawnStruct();
  return _id_CDD53A78F51F64FE;
}

_id_9FD565BCD654ED48(_id_70611A166496B64F) {
  self._id_B90BD4C9BEF3FB64 = _id_70611A166496B64F;
}

_id_B4C313DF5D7FB216(_id_423DD9037C2EFE0D, _id_46FF3A000308206A) {
  self._id_5B6FE32D0163F96A = _id_423DD9037C2EFE0D;
  self._id_46FF3A000308206A = _id_46FF3A000308206A;
}

_id_8CB232CDF47DA79C(_id_F3255509DC99AE6B, _id_104E34B87A973660) {
  self._id_D6433DA0DDC40010 = _id_F3255509DC99AE6B;
  self._id_104E34B87A973660 = _id_104E34B87A973660;
}

_id_02556973693D6315(_id_63EEDD53DF6143EA, _id_4A8A68AFCCFA6692, _id_24FBC5C0DA36EF41, _id_748A99415228DE0E, _id_DD58A7AFDB07F8CD, _id_A256BBF96994AAD1) {
  self._id_03BE6A6420B9E919 = scripts\engine\utility::ter_op(isDefined(level.brgametype._id_63EEDD53DF6143EA), level.brgametype._id_63EEDD53DF6143EA, _id_63EEDD53DF6143EA);
  self._id_4A8A68AFCCFA6692 = scripts\engine\utility::ter_op(isDefined(level.brgametype._id_4A8A68AFCCFA6692), level.brgametype._id_4A8A68AFCCFA6692, _id_4A8A68AFCCFA6692);
  self._id_24FBC5C0DA36EF41 = scripts\engine\utility::ter_op(isDefined(level.brgametype._id_24FBC5C0DA36EF41), level.brgametype._id_24FBC5C0DA36EF41, _id_24FBC5C0DA36EF41);
  self._id_748A99415228DE0E = scripts\engine\utility::ter_op(isDefined(level.brgametype._id_748A99415228DE0E), level.brgametype._id_748A99415228DE0E, _id_748A99415228DE0E);
  self._id_DD58A7AFDB07F8CD = scripts\engine\utility::ter_op(isDefined(level.brgametype._id_DD58A7AFDB07F8CD), level.brgametype._id_DD58A7AFDB07F8CD, _id_DD58A7AFDB07F8CD);
  self._id_A256BBF96994AAD1 = scripts\engine\utility::ter_op(isDefined(level.brgametype._id_A256BBF96994AAD1), level.brgametype._id_A256BBF96994AAD1, _id_A256BBF96994AAD1);
}

playerhandlesponsor(_id_4AC881E2A39322A5, _id_57D71760971F748F, _id_74AF5908127B6729, _id_899BEB1FC66D0EC6, _id_36F3C4E4A602E257, context) {
  player = self;
  _id_84E2123AACA9A965 = player;
  _id_DF2FBB13C226BE75 = "token";

  if(isDefined(_id_4AC881E2A39322A5)) {
    _id_473D8D8843D86E8D = istrue(player.br_iseliminated) && !isalive(player) && istrue(player.wasingulag);

    if(istrue(_id_36F3C4E4A602E257)) {} else {}

    _id_84E2123AACA9A965 = _id_4AC881E2A39322A5;
    _id_DF2FBB13C226BE75 = "token_sponsored";

    if(!istrue(_id_899BEB1FC66D0EC6)) {
      if(istrue(_id_57D71760971F748F))
        _id_106D02E26E82A4CF = 6;
      else
        _id_106D02E26E82A4CF = 10;

      player thread triggerrespawnoverlay(_id_106D02E26E82A4CF);
    }
  }

  if(isDefined(_id_4AC881E2A39322A5) || istrue(_id_74AF5908127B6729)) {
    if(!scripts\engine\utility::array_contains(level.teamdata[player.team]["alivePlayers"], player))
      player scripts\mp\playerlogic::addtoalivecount(context);

    _id_0A34750D17473C49::unmarkplayeraseliminated(player, context);
  }

  _id_715028F54BAD19A1::branalytics_gulagstart(player, _id_DF2FBB13C226BE75);
  _id_715028F54BAD19A1::branalytics_respawn(self, int(isDefined(_id_4AC881E2A39322A5)));

  if(istrue(_id_84E2123AACA9A965.hasrespawntoken))
    _id_84E2123AACA9A965 _id_7E52B56769FA7774::removerespawntoken();

  return [_id_84E2123AACA9A965, _id_DF2FBB13C226BE75];
}

playerwaitforprestreaming() {
  player = self;
  _id_1476E0F78320A501 = istrue(player.prestreamingspectatetarget);

  if(_id_1476E0F78320A501) {
    player scripts\mp\utility\lower_message::setlowermessageomnvar("br_standby_for_respawn");

    while(istrue(player.prestreamingspectatetarget))
      waitframe();
  }

  return _id_1476E0F78320A501;
}

playerprestreamrespawnorigin(spawnpoint, timeoutms) {
  droporigin = _id_2CEDCC356F1B9FC8::playerstreamhintdroptoground(spawnpoint.origin, spawnpoint.height);
  self setpredictedstreamloaddist(0.0);
  _id_2CEDCC356F1B9FC8::playerstreamhintlocation(droporigin, timeoutms);
  return droporigin;
}

_id_961B4AFC4C695B94() {
  self setallstreamloaddist(0.0);
}

_id_AB31CF673D70F72D(origin, angles) {
  self cancelmantle();

  if(!isDefined(self.sessionstate) || self.sessionstate != "spectator") {
    _id_362C58E8BB39BCDA::_id_D72AFACCEDFC946E("onPlayerTeleport", self, self.origin, origin, "respawn");
    self setOrigin(origin, 1);
    self setplayerangles(angles);
  }
}

_id_B70D7F3BDDDD33FD(_id_90128D0639A1315D) {
  _id_A80E089F93DCD3A4 = isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent);

  if(!_id_A80E089F93DCD3A4)
    return 1;

  if(_id_58F20490049AF6AC::_id_D987886BB9DE9137() > 1)
    return _id_58F20490049AF6AC::_id_27779E30FE4C0D62(_id_90128D0639A1315D);

  safeorigin = _id_2695A20D4011076D::getsafecircleorigin();
  _id_F434D604C09196AA = _id_2695A20D4011076D::getsafecircleradius();
  dist = distance2d(_id_90128D0639A1315D, safeorigin);
  return dist < _id_F434D604C09196AA;
}

_id_82AB584AC2A991B7(_id_90128D0639A1315D) {
  _id_A80E089F93DCD3A4 = isDefined(level.br_circle) && isDefined(level.br_circle.dangercircleent);

  if(!_id_A80E089F93DCD3A4)
    return 1;

  if(_id_58F20490049AF6AC::_id_D987886BB9DE9137() > 1)
    return _id_58F20490049AF6AC::_id_EE854FDD1E77EFC4(_id_90128D0639A1315D);

  _id_EF8F7E66DC0FEB2C = _id_2695A20D4011076D::getdangercircleorigin();
  _id_B2739C0F5213D0E8 = _id_2695A20D4011076D::getdangercircleradius();
  dist = distance2d(_id_90128D0639A1315D, _id_EF8F7E66DC0FEB2C);
  return dist < _id_B2739C0F5213D0E8;
}

_id_61B5424AA3FE974E(_id_90128D0639A1315D, timeuntilspawn, _id_40CB6248DEE31807) {
  if(!_id_45B2B4A889E633FA::ispointinbounds(_id_90128D0639A1315D, 1))
    return 0;

  if(istrue(_id_40CB6248DEE31807)) {
    if(_id_2695A20D4011076D::_ispointinbadarea(_id_90128D0639A1315D))
      return 0;
  }

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.safecircleent) || !isDefined(level.br_circle.dangercircleent))
    return 1;

  if(_id_58F20490049AF6AC::_id_D8FBACC18E5D8498() && _id_58F20490049AF6AC::_id_EE854FDD1E77EFC4(_id_90128D0639A1315D))
    return 1;

  if(_id_B70D7F3BDDDD33FD(_id_90128D0639A1315D))
    return 1;

  if(!_id_82AB584AC2A991B7(_id_90128D0639A1315D))
    return 0;

  if(isDefined(timeuntilspawn)) {
    _id_653BF8AEF0B21244 = _id_2695A20D4011076D::getmintimetillpointindangercircle(_id_90128D0639A1315D);

    if(timeuntilspawn > _id_653BF8AEF0B21244)
      return 0;
  }

  safeorigin = _id_2695A20D4011076D::getsafecircleorigin();
  _id_F434D604C09196AA = _id_2695A20D4011076D::getsafecircleradius();
  _id_EF8F7E66DC0FEB2C = _id_2695A20D4011076D::getdangercircleorigin();
  _id_B2739C0F5213D0E8 = _id_2695A20D4011076D::getdangercircleradius();
  _id_A1F3366DDB6D1B0A = length(_id_EF8F7E66DC0FEB2C - safeorigin);
  _id_EB45834677A22F12 = vectorNormalize(_id_EF8F7E66DC0FEB2C - safeorigin);
  _id_1DE6CAAEAF5F81BA = level.respawncircleinterppct;
  _id_3A7066356862F921 = safeorigin + _id_EB45834677A22F12 * _id_A1F3366DDB6D1B0A * _id_1DE6CAAEAF5F81BA;
  _id_D29771BA9E188F0D = _id_F434D604C09196AA + (_id_B2739C0F5213D0E8 - _id_F434D604C09196AA) * _id_1DE6CAAEAF5F81BA;
  dist = distance2d(_id_90128D0639A1315D, _id_3A7066356862F921);
  return dist < _id_D29771BA9E188F0D;
}

isplayervalidrespawntarget(player, timeuntilspawn) {
  if(player == self)
    return 0;

  if(!isalive(player) || player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag() || istrue(player.br_iseliminated) || istrue(player._id_E6204058F06B94E5))
    return 0;

  if(!_id_61B5424AA3FE974E(player.origin, timeuntilspawn))
    return 0;

  return 1;
}

playergetbestrespawnteammate(_id_447913206D1F7916, timeuntilspawn, _id_E4E4AC01DB0BE398) {
  _id_DF1B054C1838D0DE = undefined;

  if(istrue(level.onlinegame) && isDefined(self) && self getprivatepartysize()) {
    _id_EFD570582B503C0F = undefined;

    foreach(_id_7EEF32A705DE8BEE in self getfireteammembers()) {
      if(!isplayervalidrespawntarget(_id_7EEF32A705DE8BEE, timeuntilspawn)) {
        continue;
      }
      _id_EFD570582B503C0F = _id_7EEF32A705DE8BEE;

      if(_id_7EEF32A705DE8BEE isfireteamleader()) {
        break;
      }
    }

    if(isDefined(_id_EFD570582B503C0F) && istrue(_id_447913206D1F7916)) {
      _id_DF1B054C1838D0DE = _id_EFD570582B503C0F;
      _id_EFD570582B503C0F = undefined;

      foreach(_id_7EEF32A705DE8BEE in self getfireteammembers()) {
        if(isDefined(_id_DF1B054C1838D0DE) && _id_DF1B054C1838D0DE == _id_7EEF32A705DE8BEE) {
          continue;
        }
        if(!isplayervalidrespawntarget(_id_7EEF32A705DE8BEE, timeuntilspawn)) {
          continue;
        }
        _id_EFD570582B503C0F = _id_7EEF32A705DE8BEE;

        if(_id_7EEF32A705DE8BEE isfireteamleader()) {
          break;
        }
      }
    }

    if(isDefined(_id_EFD570582B503C0F))
      return _id_EFD570582B503C0F;
  }

  if(isDefined(self.lastdeathpos)) {
    _id_CD8409952C0BE5C8 = undefined;
    _id_42CA41C7DADAE0C0 = undefined;
    players = scripts\mp\utility\teams::getfriendlyplayers(self.team, 1);

    foreach(player in players) {
      if(isDefined(_id_DF1B054C1838D0DE) && _id_DF1B054C1838D0DE == player) {
        continue;
      }
      if(!isplayervalidrespawntarget(player, timeuntilspawn)) {
        continue;
      }
      if(player isparachuting() || player isskydiving()) {
        continue;
      }
      _id_12810E24E83ACB1D = distance2dsquared(self.lastdeathpos, player.origin);

      if(!isDefined(_id_42CA41C7DADAE0C0) || _id_12810E24E83ACB1D < _id_42CA41C7DADAE0C0) {
        _id_CD8409952C0BE5C8 = player;
        _id_42CA41C7DADAE0C0 = _id_12810E24E83ACB1D;
      }
    }

    if(isDefined(_id_CD8409952C0BE5C8) && istrue(_id_447913206D1F7916) && !isDefined(_id_DF1B054C1838D0DE)) {
      _id_DF1B054C1838D0DE = _id_CD8409952C0BE5C8;
      _id_CD8409952C0BE5C8 = undefined;
      _id_42CA41C7DADAE0C0 = undefined;

      foreach(player in players) {
        if(isDefined(_id_DF1B054C1838D0DE) && _id_DF1B054C1838D0DE == player) {
          continue;
        }
        if(!isplayervalidrespawntarget(player, timeuntilspawn)) {
          continue;
        }
        if(player isparachuting() || player isskydiving()) {
          continue;
        }
        _id_12810E24E83ACB1D = distance2dsquared(self.lastdeathpos, player.origin);

        if(!isDefined(_id_42CA41C7DADAE0C0) || _id_12810E24E83ACB1D < _id_42CA41C7DADAE0C0) {
          _id_CD8409952C0BE5C8 = player;
          _id_42CA41C7DADAE0C0 = _id_12810E24E83ACB1D;
        }
      }
    }

    if(isDefined(_id_CD8409952C0BE5C8))
      return _id_CD8409952C0BE5C8;
  }

  _id_CD8409952C0BE5C8 = undefined;
  _id_517E15E5E8524C5A = scripts\engine\utility::array_randomize(level.teamdata[self.team]["alivePlayers"]);

  foreach(_id_89C718895A5117B3 in _id_517E15E5E8524C5A) {
    if(isDefined(_id_DF1B054C1838D0DE) && _id_DF1B054C1838D0DE == _id_89C718895A5117B3) {
      continue;
    }
    if(!isplayervalidrespawntarget(_id_89C718895A5117B3, timeuntilspawn)) {
      continue;
    }
    _id_CD8409952C0BE5C8 = _id_89C718895A5117B3;

    if(istrue(_id_89C718895A5117B3 _id_2CEDCC356F1B9FC8::isplayerbrsquadleader())) {
      break;
    }
  }

  if(isDefined(_id_CD8409952C0BE5C8))
    return _id_CD8409952C0BE5C8;
  else if(!istrue(_id_E4E4AC01DB0BE398)) {
    if(scripts\mp\utility\game::getsubgametype() == "plunder" || scripts\mp\utility\game::getsubgametype() == "risk") {
      _id_652F47620AC4713F = scripts\mp\utility\teams::getteamdata(self.team, "teamCount");

      if(_id_652F47620AC4713F == 1 && !istrue(self.disconnecting) && !scripts\mp\outofbounds::ispointinoutofbounds(self.origin))
        return self;
    }
  }

  return undefined;
}

_id_C3AD6AAE08369E12() {
  _id_6D5ED003AF1F9612 = level.teamdata[self.team]["players"];

  foreach(_id_89C718895A5117B3 in _id_6D5ED003AF1F9612) {
    if(_id_89C718895A5117B3 == self) {
      continue;
    }
    _id_B3070BB45EC5B461 = _id_89C718895A5117B3.forcespawnorigin;

    if(!isDefined(_id_B3070BB45EC5B461))
      _id_B3070BB45EC5B461 = _id_89C718895A5117B3._id_F9792C4242DC4625;

    if(!isDefined(_id_B3070BB45EC5B461)) {
      continue;
    }
    return _id_B3070BB45EC5B461;
  }

  return undefined;
}

getsafeoriginaroundpoint(point, _id_C4000FD1C78D0587, timeuntilspawn, _id_40CB6248DEE31807) {
  _id_974DDA820500E74A = 3.14159;
  _id_A9AECD1F10A3AC37 = _id_58F20490049AF6AC::_id_DE2F1B656EE04BA9();

  foreach(safeorigin in _id_A9AECD1F10A3AC37) {
    _id_CEE024D90697BB29 = vectorNormalize(point - safeorigin);
    _id_8BC14603A27FA3E7 = vectortoangles(_id_CEE024D90697BB29);
    _id_6768A915ED3C9351 = randomfloatrange(getdvarfloat("dvar_83A1498ACDDBC2FA", 0.0), getdvarfloat("dvar_83C5338ACE040D50", 359.0));

    if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
      dir = _id_CEE024D90697BB29;
    else
      dir = vectorNormalize(anglesToForward(_id_8BC14603A27FA3E7 + (0, scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), _id_6768A915ED3C9351, _id_6768A915ED3C9351 * -1), 0)));

    origin = point + dir * _id_C4000FD1C78D0587;

    if(_id_61B5424AA3FE974E(origin, timeuntilspawn, _id_40CB6248DEE31807))
      return origin;

    dir = dir * -1;
    origin = point + dir * _id_C4000FD1C78D0587;

    if(_id_61B5424AA3FE974E(origin, timeuntilspawn, _id_40CB6248DEE31807))
      return origin;

    dir = vectorNormalize(safeorigin - point);
    origin = point + dir * _id_C4000FD1C78D0587;

    if(_id_61B5424AA3FE974E(origin, timeuntilspawn, _id_40CB6248DEE31807))
      return origin;

    _id_B2867FE57BB578AF = _id_C4000FD1C78D0587;
    radius = distance2d(point, safeorigin);
    angle = _id_B2867FE57BB578AF / radius;

    if(angle > _id_974DDA820500E74A)
      angle = _id_974DDA820500E74A;

    _id_44DFFBE9663DF3F0 = angle * 180 / _id_974DDA820500E74A;
    origin = rotatepointaroundvector((0, 0, 1), point - safeorigin, _id_44DFFBE9663DF3F0) + safeorigin;

    if(_id_61B5424AA3FE974E(origin, timeuntilspawn, _id_40CB6248DEE31807))
      return origin;

    origin = _id_2695A20D4011076D::getrandompointincircle(point, _id_C4000FD1C78D0587);

    if(_id_61B5424AA3FE974E(origin, timeuntilspawn, _id_40CB6248DEE31807))
      return origin;
  }

  return undefined;
}

playergetbestrespawnmissionorigin() {
  if(_id_362C58E8BB39BCDA::isfeaturedisabled("missions"))
    return undefined;

  _id_6640C2677653D96F = _id_64ACB6CE534155B7::_id_22239D4CFF05D0A1(self.team);

  if(isDefined(_id_6640C2677653D96F)) {
    switch (_id_6640C2677653D96F.type.ref) {
      case "assassination":
        if(isDefined(_id_6640C2677653D96F.targetplayer))
          return _id_6640C2677653D96F.targetplayer.origin;

        break;
      case "domination":
        if(isDefined(_id_6640C2677653D96F.domflag) && isDefined(_id_6640C2677653D96F.domflag.curorigin))
          return _id_6640C2677653D96F.domflag.curorigin;

        break;
      case "scavenger":
        if(isDefined(_id_6640C2677653D96F._id_4EAD6B4FF3816236) && isDefined(_id_6640C2677653D96F._id_4EAD6B4FF3816236[_id_6640C2677653D96F._id_003BB6053DB23449]))
          return _id_6640C2677653D96F._id_4EAD6B4FF3816236[_id_6640C2677653D96F._id_003BB6053DB23449].origin;

        break;
      case "hacker_phone":
        if(isDefined(_id_6640C2677653D96F._id_09AA953016FACACC))
          return _id_6640C2677653D96F._id_09AA953016FACACC.origin;

        break;
      case "elite_arrow":
        break;
      case "smokinggun":
      case "safecracker":
      case "x1stash":
      case "x1fin":
      case "history":
      case "vip":
        break;
      default:
        break;
    }
  }

  return undefined;
}

playergetbestdropbagorigin(timeuntilspawn) {
  foreach(crate in level.br_pickups.crates) {
    if(!isDefined(crate) || !isDefined(crate.team) || crate.team != self.team) {
      continue;
    }
    if(isDefined(crate.playerscaptured) && isDefined(crate.playerscaptured[self getentitynumber()])) {
      continue;
    }
    if(_id_61B5424AA3FE974E(crate.origin, timeuntilspawn))
      return crate.origin;
  }
}

_id_952548D8AED47102(_id_447913206D1F7916, timeuntilspawn, _id_F9A785628F97EEC6) {
  spawnorigin = undefined;
  spawnangles = undefined;
  height = _id_F9A785628F97EEC6;
  _id_53480B10269770A5 = 1;
  spawntype = "";

  if(isDefined(self.setspawnpoint)) {
    spawnorigin = self.setspawnpoint.playerspawnpos;
    spawnangles = self.setspawnpoint.playerspawnangles;
    spawntype = "setSpawnPoint";
  }

  if(level._id_6BED852A909E4F70 == 1 || level._id_6BED852A909E4F70 == 2) {
    spawnpoint = spawnStruct();
    spawnpoint.origin = level.prematchspawnorigins[0].origin;
    spawnpoint.angles = (0, 0, 0);
    spawnpoint.height = 0;
    return spawnpoint;
  }

  _id_F6AC3C609E85CB74 = getdvarfloat("dvar_B3366FB6BBCD6DAB", -1);

  if(!isDefined(spawnorigin) && _id_F6AC3C609E85CB74 >= 0 && isDefined(self.lastdeathpos)) {
    startorigin = getsafeoriginaroundpoint(self.lastdeathpos, _id_F6AC3C609E85CB74, timeuntilspawn);

    if(isDefined(startorigin)) {
      spawnorigin = _id_2CEDCC356F1B9FC8::droptogroundmultitrace(startorigin);
      spawnangles = getanglesfacingorigin(spawnorigin, startorigin);
      spawntype = "lastDeath";
    }
  }

  _id_F6AC3C609E85CB74 = getdvarfloat("dvar_8D9AD523F40BE455", 1000);

  if(!isDefined(spawnorigin) && _id_F6AC3C609E85CB74 >= 0) {
    _id_B4E45DBE012F4A40 = playergetbestrespawnteammate(_id_447913206D1F7916, timeuntilspawn);

    if(isDefined(_id_B4E45DBE012F4A40)) {
      _id_B1959D90F987E135 = getdvarfloat("dvar_0879A2FDE5543837", 5.0) * 1000;
      _id_06E6B11A5415DC87 = getdvarfloat("dvar_5845AE9020002373", 30.0) * 1000;
      brgametype = getDvar("dvar_7611A2790A0BF7FE", "");

      if((brgametype == "plunder" || brgametype == "risk" || brgametype == "kingslayer") && isDefined(level.teamdata[self.team]["lastParachuteTime"]) && level.teamdata[self.team]["lastParachuteTime"] + _id_06E6B11A5415DC87 > gettime() + _id_B1959D90F987E135 && distance2d(level.teamdata[self.team]["lastParachuteOrigin"], _id_B4E45DBE012F4A40.origin) < getdvarfloat("dvar_8D9AD523F40BE455", 1000) * 1.25) {
        spawnorigin = level.teamdata[self.team]["lastParachuteOrigin"];
        spawnangles = level.teamdata[self.team]["lastParachuteAngles"];
        spawntype = "abovePlayerCached";
      } else {
        _id_40CB6248DEE31807 = getdvarint("dvar_899E9302A5910263", 1) == 1;
        spawnorigin = getsafeoriginaroundpoint(_id_B4E45DBE012F4A40.origin, _id_F6AC3C609E85CB74, timeuntilspawn, _id_40CB6248DEE31807);

        if(isDefined(spawnorigin)) {
          spawnorigin = _id_2CEDCC356F1B9FC8::droptogroundmultitrace(spawnorigin);
          spawnangles = getanglesfacingorigin(spawnorigin, _id_B4E45DBE012F4A40.origin);
          spawntype = "abovePlayer";
          level.teamdata[self.team]["lastParachuteOrigin"] = spawnorigin;
          level.teamdata[self.team]["lastParachuteAngles"] = spawnangles;
          level.teamdata[self.team]["lastParachuteTime"] = gettime();
        }
      }
    }

    if(!isDefined(spawnorigin) && !scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73()) {
      _id_4A1A29CA5D2A5A9F = _id_C3AD6AAE08369E12();

      if(isDefined(_id_4A1A29CA5D2A5A9F)) {
        spawnorigin = getsafeoriginaroundpoint(_id_4A1A29CA5D2A5A9F, _id_F6AC3C609E85CB74, timeuntilspawn);

        if(isDefined(spawnorigin)) {
          spawnorigin = _id_2CEDCC356F1B9FC8::droptogroundmultitrace(spawnorigin);
          spawnangles = getanglesfacingorigin(spawnorigin, _id_4A1A29CA5D2A5A9F);
          spawntype = "respawningTeammate";
        }
      }
    }
  }

  _id_F6AC3C609E85CB74 = getdvarfloat("dvar_721AA1F6148749EB", 3000);

  if(!isDefined(spawnorigin) && _id_F6AC3C609E85CB74 >= 0) {
    _id_1EA80BF05351C1CF = playergetbestrespawnmissionorigin();

    if(isDefined(_id_1EA80BF05351C1CF)) {
      spawnorigin = getsafeoriginaroundpoint(_id_1EA80BF05351C1CF, _id_F6AC3C609E85CB74, timeuntilspawn);
      spawnangles = getanglesfacingorigin(spawnorigin, _id_1EA80BF05351C1CF);
      spawntype = "missionOrigin";
    }
  }

  _id_F6AC3C609E85CB74 = getdvarfloat("dvar_5243C598E26F304A", 3000);

  if(!isDefined(spawnorigin) && _id_F6AC3C609E85CB74 >= 0) {
    _id_8C4038F0270DE13E = playergetbestdropbagorigin(timeuntilspawn);

    if(isDefined(_id_8C4038F0270DE13E)) {
      spawnorigin = getsafeoriginaroundpoint(_id_8C4038F0270DE13E, _id_F6AC3C609E85CB74, timeuntilspawn);
      spawnangles = getanglesfacingorigin(spawnorigin, _id_8C4038F0270DE13E);
      spawntype = "dropBagOrigin";
    }
  }

  if(!isDefined(spawnorigin) && _id_362C58E8BB39BCDA::isbrgametypefuncdefined("playerGetRespawnPoint")) {
    spawnorigin = _id_362C58E8BB39BCDA::_id_D72AFDCCEDFC9B07("playerGetRespawnPoint", _id_447913206D1F7916, timeuntilspawn, _id_F9A785628F97EEC6);
    spawntype = "brGameTypeFunc";
  }

  if(!isDefined(spawnorigin)) {
    if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
      _id_A26567D70B7326AE = _id_58F20490049AF6AC::_id_D8FBACC18E5D8498();

      if(getdvarint("dvar_89FD9A93B31A5CF2", 0) && !istrue(_id_A26567D70B7326AE)) {
        timeoffset = getdvarfloat("dvar_45C8AE384E9D6B92", 2.0);
        spawnorigin = _id_2695A20D4011076D::_id_BF5F4D7A498988A8(self, timeuntilspawn, timeoffset);
        spawntype = "pointFromSquadmate";
      }

      if(!isDefined(spawnorigin)) {
        _id_1848FFDBD8A2E93E = getdvarfloat("dvar_2FC319E6652DA3D9", 0.9);

        if(getdvarint("dvar_F1D47DDB5B62548B", 1)) {
          spawnorigin = _id_2695A20D4011076D::_id_FC52AE1478A8FC25(_id_1848FFDBD8A2E93E, timeuntilspawn);
          spawntype = "perimeterPointFromSquadmate";
        }

        if(!isDefined(spawnorigin) && getdvarint("dvar_EF1AC888D0EFEB04", 1)) {
          spawnorigin = _id_2695A20D4011076D::_id_BF16029A7B6FF1FA(_id_1848FFDBD8A2E93E, timeuntilspawn);
          spawntype = "perimeterPointFromLoadout";
        }

        if(isDefined(spawnorigin)) {
          spawnangles = getanglesfacingorigin(_id_2695A20D4011076D::getsafecircleorigin(), spawnorigin);
          _id_DDC96F0E004AC435 = 0;

          if(getdvarint("dvar_43845157C16D2358", 1)) {
            baseorigin = _id_2695A20D4011076D::getdangercircleorigin();
            _id_40CB6248DEE31807 = getdvarint("dvar_6094DB79787DEA90", 1) == 1;
            _id_DDC96F0E004AC435 = -90;
            _id_87CEF474127DE542 = 10.0;

            if(scripts\engine\utility::cointoss()) {
              _id_DDC96F0E004AC435 = -1 * _id_DDC96F0E004AC435;
              _id_87CEF474127DE542 = -1 * _id_87CEF474127DE542;
            }

            _id_1CFCCAC3E5778BBB = rotatevector(spawnorigin - baseorigin, (0, _id_87CEF474127DE542, 0)) + baseorigin;

            if(_id_2695A20D4011076D::isvalidpointinbounds(_id_1CFCCAC3E5778BBB, _id_40CB6248DEE31807, timeuntilspawn))
              spawnorigin = _id_1CFCCAC3E5778BBB;
            else {
              _id_DDC96F0E004AC435 = -1 * _id_DDC96F0E004AC435;
              _id_87CEF474127DE542 = -1 * _id_87CEF474127DE542;
              _id_1CFCCAC3E5778BBB = rotatevector(spawnorigin - baseorigin, (0, _id_87CEF474127DE542, 0)) + baseorigin;

              if(_id_2695A20D4011076D::isvalidpointinbounds(_id_1CFCCAC3E5778BBB, _id_40CB6248DEE31807, timeuntilspawn))
                spawnorigin = _id_1CFCCAC3E5778BBB;
              else
                _id_DDC96F0E004AC435 = 0;
            }
          }

          yaw = angleclamp(spawnangles[1] + _id_DDC96F0E004AC435);
          spawnangles = (0, yaw, 0);
        }
      }

      if(!isDefined(spawnorigin)) {
        origin = _id_2695A20D4011076D::getsafecircleorigin();
        radius = _id_2695A20D4011076D::getsafecircleradius();

        if(istrue(_id_A26567D70B7326AE)) {
          origin = _id_2695A20D4011076D::getdangercircleorigin();
          radius = _id_2695A20D4011076D::getdangercircleradius();
        } else if(!_id_58F20490049AF6AC::_id_778A4C3D053ED0A9(origin))
          origin = _id_2695A20D4011076D::getdangercircleorigin();

        _id_8970EF161276A714 = getdvarfloat("dvar_8EB0CED475A9BAF1", 0.5);
        _id_1848FFDBD8A2E93E = getdvarfloat("dvar_4E9825C71CEB94FF", 0.9);
        _id_D5998E8874D77B02 = getdvarint("dvar_951C7B13FFDD6905", 1);
        _id_38A4C729748AD94C = getdvarint("dvar_7017AD29DBEDC8B1", 1);
        _id_40CB6248DEE31807 = getdvarint("dvar_7371A5983F296BD6", 1);
        spawnorigin = _id_2695A20D4011076D::getrandompointinboundscircle(origin, radius, _id_8970EF161276A714, _id_1848FFDBD8A2E93E, _id_D5998E8874D77B02, _id_38A4C729748AD94C, _id_40CB6248DEE31807, timeuntilspawn);
        spawntype = "randomPointInBounds";
      }
    } else if(isDefined(level.prematchspawnorigins)) {
      if(isDefined(level.teamdata[self.team]["chosenSpawnWipeOrigin"]) && isDefined(level.teamdata[self.team]["spawnWipeOriginUseStartTime"]) && isDefined(level.autorespawnwaittime) && level.teamdata[self.team]["spawnWipeOriginUseStartTime"] + level.autorespawnwaittime * 1000 > gettime()) {
        spawnorigin = level.teamdata[self.team]["chosenSpawnWipeOrigin"];
        spawntype = "chosenOrigin";
      } else {
        _id_24A1D3CB9D6D7992 = [];

        foreach(struct in level.prematchspawnorigins) {
          if(distance2dsquared(struct.origin, self.origin) > _id_F6AC3C609E85CB74)
            _id_24A1D3CB9D6D7992[_id_24A1D3CB9D6D7992.size] = struct;
        }

        if(_id_24A1D3CB9D6D7992.size == 0)
          _id_24A1D3CB9D6D7992 = level.prematchspawnorigins;

        _id_24A1D3CB9D6D7992 = scripts\engine\utility::array_randomize(_id_24A1D3CB9D6D7992);
        spawnorigin = _id_24A1D3CB9D6D7992[0].origin;
        spawnorigin = spawnorigin + scripts\engine\math::random_vector_2d() * randomfloatrange(100, 500);
        spawntype = "randomPotential";
        level.teamdata[self.team]["chosenSpawnWipeOrigin"] = spawnorigin;
        level.teamdata[self.team]["spawnWipeOriginUseStartTime"] = gettime();
      }

      spawnangles = (0, 0, 0);

      if(spawnorigin[2] > 10000) {
        _id_53480B10269770A5 = 0;
        height = _id_0930A1E7BD882C1D::getinfilspawnoffset();
      }
    } else {
      spawnorigin = (0, 0, 0);
      spawnangles = (0, 0, 0);
      spawntype = "zero";
    }
  }

  if(!isDefined(spawnangles)) {
    circleorigin = _id_2695A20D4011076D::getsafecircleorigin();
    _id_D097B5E68BAA10D1 = vectortoyaw(circleorigin - spawnorigin);
    spawnangles = (0, _id_D097B5E68BAA10D1, 0);
  }

  if(_id_53480B10269770A5) {
    if(!isDefined(height))
      height = scripts\cp_mp\parachute::getc130height();

    if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("onRespawnScaleHeightOffset"))
      height = height * _id_362C58E8BB39BCDA::runbrgametypefunc("onRespawnScaleHeightOffset");

    if(isDefined(level._id_DC52A11D1EE2690E) && scripts\mp\utility\game::getsubgametype() != "dmz" && !scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
      height = level._id_DC52A11D1EE2690E;

    if(isDefined(level.respawnheightoverride))
      height = level.respawnheightoverride;

    if(istrue(level._id_5B5A1FCD1024EDA5) && scripts\mp\utility\game::getsubgametype() != "dmz" && !scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
      height = _id_D6BFA8A9E6D014DB(height);

    _id_A6427A6A24F058DC = (0, 0, height);
    spawnorigin = _id_1E4A61DB11011446::getoffsetspawnorigin(spawnorigin, _id_A6427A6A24F058DC);
  }

  spawnpoint = spawnStruct();
  spawnpoint.origin = spawnorigin;
  spawnpoint.angles = spawnangles;
  spawnpoint.height = height;

  if(getdvarint("dvar_3055E0F04CCAC0E4", 1)) {
    if(scripts\mp\outofbounds::ispointinoutofbounds(spawnpoint.origin)) {
      switch (spawntype) {
        case "setSpawnPoint":
          scripts\mp\utility\script::demoforcesre("Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using setSpawnPoint");
          break;
        case "lastDeath":
          scripts\mp\utility\script::demoforcesre("Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using lastDeath");
          break;
        case "abovePlayerCached":
          scripts\mp\utility\script::demoforcesre("Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using abovePlayerCached");
          break;
        case "abovePlayer":
          scripts\mp\utility\script::demoforcesre("Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using abovePlayer");
          break;
        case "respawningTeammate":
          scripts\mp\utility\script::demoforcesre("Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using respawningTeammate");
          break;
        case "missionOrigin":
          scripts\mp\utility\script::demoforcesre("Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using missionOrigin");
          break;
        case "dropBagOrigin":
          scripts\mp\utility\script::demoforcesre("Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using dropBagOrigin");
          break;
        case "brGameTypeFunc":
          scripts\mp\utility\script::demoforcesre("Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using brGameTypeFunc");
          break;
        case "pointFromSquadmate":
          scripts\mp\utility\script::demoforcesre("Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using pointFromSquadmate");
          break;
        case "perimeterPointFromSquadmate":
          scripts\mp\utility\script::demoforcesre("Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using perimeterPointFromSquadmate");
          break;
        case "perimeterPointFromLoadout":
          scripts\mp\utility\script::demoforcesre("Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using perimeterPointFromLoadout");
          break;
        case "randomPointInBounds":
          scripts\mp\utility\script::demoforcesre("Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using randomPointInBounds");
          break;
        case "chosenOrigin":
          scripts\mp\utility\script::demoforcesre("Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using chosenOrigin");
          break;
        case "randomPotential":
          scripts\mp\utility\script::demoforcesre("Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using randomPotential");
          break;
        case "zero":
          scripts\mp\utility\script::demoforcesre("Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using zero");
          break;
        default:
          scripts\mp\utility\script::demoforcesre("Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using " + spawntype);
          break;
      }
    }
  }

  return spawnpoint;
}

getanglesfacingorigin(startorigin, _id_851F0CE8DF2EB27D) {
  if(isDefined(startorigin) && isDefined(_id_851F0CE8DF2EB27D)) {
    _id_E568A3CD90718F39 = vectortoyaw(_id_851F0CE8DF2EB27D - startorigin);
    angles = (0, _id_E568A3CD90718F39, 0);
    return angles;
  }
}

playercleanupentondisconnect(ent) {
  ent endon("death");
  self waittill("disconnect");

  if(isDefined(ent))
    ent delete();
}

_id_D669022F6CD65402(enable) {
  if(enable) {
    self enableoffhandweapons();
    self enableusability();
  } else {
    self disableoffhandweapons();
    self disableusability();
  }
}

triggerrespawnoverlay(_id_8D90BD1972A435BF, _id_0BE9140F1DFFFE7A) {
  self endon("disconnect");
  _id_DBC5E63A72F2678A = _id_362C58E8BB39BCDA::runbrgametypefunc("triggerRespawnOverlay");

  if(istrue(_id_DBC5E63A72F2678A)) {
    return;
  }
  wait 0.5;
  splashname = undefined;

  if(isDefined(_id_0BE9140F1DFFFE7A)) {
    if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73() && _id_0BE9140F1DFFFE7A == "winner")
      splashname = "br_gulag_winner";
    else
      splashname = _id_0BE9140F1DFFFE7A;
  } else if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("gulagGetWinSplashName"))
    splashname = _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("gulagGetWinSplashName");
  else
    splashname = "br_gulag_winner";

  thread scripts\mp\hud_message::showsplash(splashname);
}

resetplayermovespeedscale() {
  player = self;
  player.fastcrouchspeedmod = 0;
  player scripts\mp\weapons::updatemovespeedscale();
}

fadeoutin(_id_F69BA8D7B96E8326) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isDefined(_id_F69BA8D7B96E8326))
    _id_F69BA8D7B96E8326 = 1.0;

  playercinematicfadein();
  wait(_id_F69BA8D7B96E8326);
  _id_E68E4BB4F65F5FE4();
}

_id_334A8FE67E88BBE7(_id_89834994170E7989) {
  if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73() && !scripts\cp_mp\utility\game_utility::_id_3BF9723F3DDB4D76())
    _id_19E0946144544A19();
  else
    playercinematicfadein();

  if(istrue(_id_89834994170E7989))
    _id_9E7BD567746E94A1();
}

_id_9CEB26B230856D29() {
  self endon("disconnect");
  self endon("respawn_fade_from_black");
  level waittill("game_ended");
  self setclientomnvar("ui_br_bink_overlay_state", 0);
}

_id_E68E4BB4F65F5FE4() {
  thread playercinematicfadeout();
  _id_8375DB589E70A6EE();
}

_id_9E7BD567746E94A1() {
  _id_721982228624D657 = _id_6489FCDFE6FA2E36::getspectatorsofplayer(self);

  foreach(spectator in _id_721982228624D657) {
    if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73()) {
      spectator _id_19E0946144544A19();
      continue;
    }

    spectator playercinematicfadein();
  }
}

_id_8375DB589E70A6EE() {
  _id_721982228624D657 = _id_6489FCDFE6FA2E36::getspectatorsofplayer(self);

  foreach(spectator in _id_721982228624D657)
  spectator thread playercinematicfadeout();
}

fadeoutinspectatorsofplayer(_id_F69BA8D7B96E8326) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isDefined(_id_F69BA8D7B96E8326))
    _id_F69BA8D7B96E8326 = 1.0;

  _id_9E7BD567746E94A1();
  wait(_id_F69BA8D7B96E8326);
  _id_8375DB589E70A6EE();
}

playeriscinematiclayeron() {
  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    return 0;

  _id_A143CDB0E0E442C2 = self getclientomnvar("ui_br_bink_overlay_state");

  if(_id_A143CDB0E0E442C2 != 0 && _id_A143CDB0E0E442C2 != 6)
    return 1;

  return 0;
}

playeriscinematicblacklayeron() {
  _id_A143CDB0E0E442C2 = self getclientomnvar("ui_br_bink_overlay_state");
  return isDefined(_id_A143CDB0E0E442C2) && _id_A143CDB0E0E442C2 == 7;
}

playercinematicfadein() {
  self setclientomnvar("ui_br_bink_overlay_state", 7);
}

_id_19E0946144544A19() {
  self setclientomnvar("ui_br_bink_overlay_state", 11);
}

playercinematicfadeout() {
  self endon("disconnect");

  if(playeriscinematiclayeron()) {
    self setclientomnvar("ui_br_bink_overlay_state", 6);
    wait 1;
    self setclientomnvar("ui_br_bink_overlay_state", 0);
  }
}

_id_844BDF70E8A61534() {
  level endon("game_ended");
  self endon("disconnect");

  if(istrue(level.gameended)) {
    return;
  }
  if(getdvarint("dvar_FE3AFD6EAD4AA523", 1) == 1)
    self endon("brWaitAndSpawnClientComplete");

  _id_652F47620AC4713F = scripts\mp\utility\teams::getteamdata(self.team, "teamCount");

  if(!istrue(self.squadwiped) || _id_652F47620AC4713F == 1) {
    _id_80365E25F6E3BEFD = 1.0;
    wait(_id_80365E25F6E3BEFD);
  }

  if(istrue(self.hasrespawntoken) && isDefined(level.tokenrespawnwaittime))
    _id_30839284ADD41CED = level.tokenrespawnwaittime;
  else if(level.incrementalrespawnpunish > 0.0)
    _id_30839284ADD41CED = clamp(self.pers["deaths"] * level.incrementalrespawnpunish, 0.0, level.incrementalrespawnpunishmax);
  else if(isDefined(level.autorespawnwaittime))
    _id_30839284ADD41CED = level.autorespawnwaittime;
  else
    _id_30839284ADD41CED = getdvarint("dvar_5639A8F49B94DACB", 20);

  _id_AC5CF023CA77DB21 = getdvarfloat("dvar_DE0DFC4549393BA2", 10.0);

  if(_id_30839284ADD41CED < _id_AC5CF023CA77DB21)
    _id_30839284ADD41CED = _id_AC5CF023CA77DB21;

  if(level.respawntimedisable != 0)
    _id_30839284ADD41CED = 0;

  _id_E343378B89E661FB = getdvarfloat("dvar_CC53A64FA6E4897B", 5.0);
  scripts\engine\utility::ent_flag_init("playerRespawn_intermission_spawned");
  self.intermissionspawnorigin = undefined;
  self.intermissionspawntime = undefined;

  if(istrue(self.squadwiped) || _id_652F47620AC4713F == 1) {
    spawnpoint = _id_952548D8AED47102();
    _id_11F3B4465C8B637B = playerprestreamrespawnorigin(spawnpoint);
    thread fadetogearingup(0.0, _id_652F47620AC4713F > 1);
    wait(_id_E343378B89E661FB);
  } else if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF()) {
    scripts\mp\utility\lower_message::setlowermessageomnvar("waiting_to_spawn", int(gettime() + _id_30839284ADD41CED * 1000));
    _id_A294C35CBB452CBF = _id_30839284ADD41CED - _id_AC5CF023CA77DB21;
    _id_D2F5422694822652 = _id_30839284ADD41CED - _id_A294C35CBB452CBF;
    _id_C445F6D6BC71ED85 = _id_30839284ADD41CED - getdvarfloat("dvar_0879A2FDE5543837", 6.0);
    thread fadetogearingup(_id_C445F6D6BC71ED85);
    result = scripts\engine\utility::waittill_notify_or_timeout_return("squad_wipe_death", _id_A294C35CBB452CBF);

    if(result == "squad_wipe_death") {
      spawnpoint = _id_952548D8AED47102();
      _id_11F3B4465C8B637B = playerprestreamrespawnorigin(spawnpoint);
      thread fadetogearingup(0.0, 1);
      wait(_id_E343378B89E661FB);
    } else {
      thread updateprestreamrespawn();
      result = scripts\engine\utility::waittill_notify_or_timeout_return("squad_wipe_death", _id_D2F5422694822652);

      if(result == "squad_wipe_death") {
        spawnpoint = _id_952548D8AED47102();
        _id_11F3B4465C8B637B = playerprestreamrespawnorigin(spawnpoint);
        thread fadetogearingup(0.0, 1);
        wait(_id_E343378B89E661FB);
      }
    }
  }

  self notify("stop_updatePrestreamRespawn");
  spawnpoint = _id_952548D8AED47102();
  _id_11F3B4465C8B637B = playerprestreamrespawnorigin(spawnpoint);

  if(istrue(self.squadwiped)) {
    self.squadwiped = 0;

    if(_id_652F47620AC4713F > 1 && !_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF())
      scripts\mp\hud_message::showsplash("bm_your_squad_wiped");
  }

  if(isteamextracted(self.team)) {
    return;
  }
  if(istrue(self.hasrespawntoken)) {
    thread triggerrespawnoverlay(4);
    self.tokenrespawned = 1;
    _id_7E52B56769FA7774::removerespawntoken();
  }

  if(isteamextracted(self.team)) {
    return;
  }
  if(getdvarint("dvar_DF02345C60008647", 1) == 0)
    _id_2CEDCC356F1B9FC8::playerwaittillstreamhintcomplete();

  scripts\engine\utility::ent_flag_clear("playerRespawn_intermission_spawned");
  self.intermissionspawnorigin = undefined;
  self.intermissionspawntime = undefined;
  scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  scripts\cp_mp\execution::_clearexecution();
  _id_7E52B56769FA7774::initplayer();

  if(_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF() && isDefined(level.player_respawn_struct))
    spawnpoint = scripts\engine\utility::getStruct(level.player_respawn_struct, "targetname");

  _id_67708F418B1FAC79::gulagwinnerrespawn(1, undefined, spawnpoint, 1, _id_11F3B4465C8B637B, 1);
  _id_0A34750D17473C49::unmarkplayeraseliminated(self, "plunderPlayerRespawn");
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "stat_B092E3259EC308D8");
  scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_transition_type", 0);
}

fadetogearingup(waittime, squadwiped) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned_player");
  self notify("fadeToGearingUp");
  self endon("fadeToGearingUp");

  if(isDefined(waittime) && waittime > 0)
    wait(waittime);

  _id_B59F471C2C064E56 = 1.0;
  thread _id_35B4F2460E697A2E();
  wait(_id_B59F471C2C064E56 - 0.25);

  if(istrue(squadwiped))
    scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_transition_type", 6);
  else
    scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_transition_type", 2);

  wait 0.25;

  if(getdvarint("dvar_F006294EF8B720A4", 1) == 1) {
    _id_2CEDCC356F1B9FC8::playerclearstreamhintorigin();
    spawnpoint = _id_952548D8AED47102();
    _id_6489FCDFE6FA2E36::playerclearspectatekillchainsystem();
    _id_1E4A61DB11011446::spawnintermission(spawnpoint.origin, spawnpoint.angles);
    scripts\mp\spectating::setdisabled();
    self.intermissionspawnorigin = spawnpoint.origin;
    self.intermissionspawntime = gettime();
    scripts\engine\utility::ent_flag_set("playerRespawn_intermission_spawned");
  }
}

_id_35B4F2460E697A2E() {
  level endon("game_ended");
  self endon("disconnect");
  _id_334A8FE67E88BBE7();
  self waittill("spawned_player");
  _id_E68E4BB4F65F5FE4();
}

updateprestreamrespawn() {
  self endon("disconnect");
  self endon("spawned_player");
  self endon("stop_updatePrestreamRespawn");

  for(;;) {
    if(scripts\engine\utility::ent_flag("playerRespawn_intermission_spawned")) {
      spawnpoint = _id_952548D8AED47102();
      currenttime = gettime();

      if(currenttime - self.intermissionspawntime >= getdvarfloat("dvar_57FBCC1BAE0F210A", 2.0) * 1000) {
        spawnpoint = _id_952548D8AED47102(1);
        _id_11F3B4465C8B637B = playerprestreamrespawnorigin(spawnpoint);
      }
    } else {
      spawnpoint = _id_952548D8AED47102();
      _id_11F3B4465C8B637B = playerprestreamrespawnorigin(spawnpoint);
    }

    wait 1.0;
  }
}

setteamasextracted(team) {
  level.teamdata[team]["extracted"] = 1;
}

isteamextracted(team) {
  return istrue(level.teamdata[team]["extracted"]);
}

_id_D6BFA8A9E6D014DB(height) {
  if(isDefined(level._id_B257658F289A3108)) {
    if(level._id_27506E83D743E391 < 0 || level.br_circle.circleindex < level._id_27506E83D743E391) {
      _id_AC61029D6F979867 = level._id_B257658F289A3108 * level.br_circle.circleindex;
      height = _id_D986479E0B55E637(height, _id_AC61029D6F979867);
    } else {
      _id_AC61029D6F979867 = level._id_B257658F289A3108 * level._id_27506E83D743E391;
      height = _id_D986479E0B55E637(height, _id_AC61029D6F979867);
    }
  }

  return height;
}

_id_D986479E0B55E637(height, _id_AC61029D6F979867) {
  if(_id_AC61029D6F979867 > 0) {
    _id_B68F01B7CA095FAF = height * _id_AC61029D6F979867;
    height = height - _id_B68F01B7CA095FAF;

    if(height <= level._id_5321A1377F9CC5AA)
      height = level._id_5321A1377F9CC5AA;
  }

  return height;
}