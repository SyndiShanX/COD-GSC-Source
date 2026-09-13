/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\mgl_mp.gsc
***********************************************/

_id_8BB13AA2A5D32576(player, _id_F7B6CC6C062A7A43, _id_DE02835724550257) {
  level endon("game_ended");
  self endon("disconnect");
  _id_0510DF850B7BBEE9 = undefined;

  if(getdvarint("dvar_D8987A7FC5903870", 0) == 1) {
    _id_DE02835724550257 = 1;
    _id_0510DF850B7BBEE9 = 1.5;
  } else if(!isDefined(_id_DE02835724550257))
    _id_DE02835724550257 = getdvarfloat("dvar_1EC37B5E27207639", 7.0);

  player thread scripts\mp\hud_message::_id_CD236201B71F07E2(_id_F7B6CC6C062A7A43, _id_DE02835724550257, _id_0510DF850B7BBEE9);
  self setclientomnvar("ui_br_extended_load_screen", 1);
  wait(getdvarfloat("dvar_EED49E631705B0BA", 6.0));
  self setclientomnvar("ui_br_extended_load_screen", 0);
}

_id_97A717C89C217036(_id_51A32B881BE32558) {
  return scripts\engine\utility::array_combine([scripts\cp_mp\utility\game_utility::getlocaleid()], _id_51A32B881BE32558);
}

_id_DA8AF86F82F90504() {
  level thread _id_27FDECE778E999D8::_id_C38398385AFC10FC();
}

_id_F9AE07213A0AF3DE() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(isai(self)) {
    return;
  }
  _id_CBA993AFE88EB432 = getdvarint("dvar_FD56CD977B402492", 0);

  if(_id_CBA993AFE88EB432 <= 0) {
    return;
  }
  for(;;) {
    self waittill("giveLoadout");
    childthread _id_212D126522AD2C4F(_id_CBA993AFE88EB432);
  }
}

_id_212D126522AD2C4F(_id_CBA993AFE88EB432) {
  self endon("giveLoadout");

  for(;;) {
    _id_24B56B36C35A0973 = self getcurrentprimaryweapon();

    if(isDefined(_id_24B56B36C35A0973) && !isnullweapon(_id_24B56B36C35A0973) && _id_24B56B36C35A0973.classname != "melee") {
      _id_624E160470ABA9B9 = weaponclipsize(_id_24B56B36C35A0973);
      self setweaponammostock(_id_24B56B36C35A0973, _id_24B56B36C35A0973.startammo + (_id_CBA993AFE88EB432 - 1) * _id_624E160470ABA9B9, 0);
      return;
    }

    waitframe();
  }
}

_id_9ACF99E8C077E74D() {
  _id_27FDECE778E999D8::initialize(::_id_8BD0955F703E9104);
}

_id_8BD0955F703E9104(_id_E2055BF088954E86) {
  _id_577F45571C039A54 = _id_4A941421347FF7DF::_id_E65493518B3DE050();
  _id_577F45571C039A54[_id_577F45571C039A54.size] = "CaptureFlag";
  return _id_577F45571C039A54;
}

_id_4248416FFFB4C5B3() {
  return _id_97A717C89C217036(["dom_mgl"]);
}

_id_8C9C24A50231B1F9() {
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  _id_DA8AF86F82F90504();
}

_id_53AE52A625B5C703() {
  level.bot_funcs["should_do_killcam"] = ::_id_4EB101B735D9F3FD;
  _id_27FDECE778E999D8::initialize();
  _id_642082E8EDBA5663::initialize(::_id_CB998B58D19F72A5, ::_id_132E4BFC51F7ECEA, ::_id_0D4307F8C6AF7844);
}

_id_CB998B58D19F72A5() {
  return getdvarint("dvar_E4DAE95C1CA21E20", 0);
}

_id_132E4BFC51F7ECEA() {
  self.entity_number = self getentitynumber();
  _id_59FF79D681BB860C::_id_21B2D65575E9C0CC("Combat");
}

_id_0D4307F8C6AF7844() {
  self notify("bot_suspended");
  waitframe();
}

_id_4EB101B735D9F3FD() {
  if(istrue(game["isLaunchChunk"]))
    return 1;

  return randomfloat(1.0) < 0.9;
}

_id_E6CABFEFE9DB5685() {
  return _id_97A717C89C217036(["war_mgl"]);
}

_id_CE76A0F1345B7F4F() {
  level.onplayerconnect = ::_id_BC2DDBF95AECC9E0;
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  _id_DA8AF86F82F90504();
}

_id_BC2DDBF95AECC9E0(player) {
  player thread _id_8BB13AA2A5D32576(player, "mp_gametype_war_mgl_match_introduction");
}

_id_892DB361940E142D() {
  _id_27FDECE778E999D8::initialize(::_id_8AAC6813797463E4);
}

_id_8AAC6813797463E4(_id_E2055BF088954E86) {
  _id_577F45571C039A54 = _id_4A941421347FF7DF::_id_E65493518B3DE050();
  _id_577F45571C039A54[_id_577F45571C039A54.size] = "CaptureHardpoint";
  return _id_577F45571C039A54;
}

_id_7B7C572755736C13() {
  return _id_97A717C89C217036(["koth_mgl", "hardpoint", "tdm"]);
}

_id_29020E26E20049D9() {
  if(!getdvarint("dvar_131A7029DB1ED456", 0))
    _id_DA8AF86F82F90504();
}

_id_D91924619AE46B1F() {
  return "icon_medium";
}

_id_AFADC6882A95F376(_id_9156B53BCF7CE573) {
  thread _id_F9AE07213A0AF3DE();
  isfirstround = scripts\mp\utility\game::isfirstround();
  _id_F959A774A90894C4 = istrue(game["shouldDisplayRoundSwitch"]);

  if(isfirstround || _id_F959A774A90894C4) {
    _id_DE02835724550257 = undefined;

    if(!isfirstround)
      _id_DE02835724550257 = 2.9;

    if(game["attackers"] == self.team) {
      thread _id_8BB13AA2A5D32576(self, "mp_gametype_sd_mgl_match_attacker_introduction", _id_DE02835724550257);
      return;
    }

    thread _id_8BB13AA2A5D32576(self, "mp_gametype_sd_mgl_match_defender_introduction", _id_DE02835724550257);
    return;
  } else
    thread _id_4E616C2DD44DAA33();
}

_id_4E616C2DD44DAA33() {
  level endon("game_ended");
  self endon("disconnected");
  level waittill("matchStartTimer_done");

  if(game["attackers"] == self.team)
    scripts\mp\hud_message::showsplash("mp_gametype_sd_mgl_match_attacker_objective");
  else
    scripts\mp\hud_message::showsplash("mp_gametype_sd_mgl_match_defender_objective");
}

_id_47E2A0DE1D6B6115() {
  level.onplayerconnect = ::_id_E96348590E5E9676;
}

_id_E96348590E5E9676(player) {
  player thread _id_8BB13AA2A5D32576(player, "mp_gametype_conf_mgl_match_introduction");
}

_id_1150A8D7A08DF473() {
  _id_5E3E1F21A61EF5F2 = "allies";
  _id_DDE1D31B534402A5 = "axis";
  scripts\mp\spawnlogic::setactivespawnlogic("Front", "Crit_Frontline");
  _id_D3495009979E4577 = scripts\mp\spawnlogic::getspawnpointarray("mp_front_spawn_allies");
  _id_92857CDD974903FC = scripts\mp\spawnlogic::getspawnpointarray("mp_front_spawn_axis");
  scripts\mp\spawnlogic::registerspawnset(_id_5E3E1F21A61EF5F2, _id_D3495009979E4577);
  scripts\mp\spawnlogic::registerspawnset(_id_DDE1D31B534402A5, _id_92857CDD974903FC);
}