/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4f9a55dee6aebc8f.gsc
***********************************************/

_id_7AAE8CB0D8B0AC6A(data) {
  level._id_DAC66BB7E0B0F8A5 = spawnStruct();
  level._id_DAC66BB7E0B0F8A5.circleradius = getdvarint("dvar_456CCED132E54C3D", 512);
  level._id_DAC66BB7E0B0F8A5.capturetime = getdvarfloat("dvar_70CB1DCB1D1AC8FE", 90);
  level._id_DAC66BB7E0B0F8A5._id_CBB87A25616A7681 = getdvarint("dvar_D1DDB41C6C8A3AF0", 4);
  level._id_DAC66BB7E0B0F8A5._id_62623980DC128FD7 = getdvarint("dvar_EF416AC86FBCD18E", 6);
  level._id_DAC66BB7E0B0F8A5._id_B78E47E5CB9E429A = getdvarfloat("dvar_9EFDDFF4D4E1DC53", 0.2);
  level._id_DAC66BB7E0B0F8A5._id_EE98DF80874C48E0 = getdvarint("dvar_631C94C8C496EC51", 5);
  level._id_DAC66BB7E0B0F8A5._id_281E288AE263A2B9 = getdvarfloat("dvar_9D45AADC299781B0", 0.5);
  data._id_68E354FCEB08D97B = ::_id_9490CCB2177749A8;

  if(!isDefined(level._effect["bomb_squad_explosion"]))
    level._effect["bomb_squad_explosion"] = loadfx("vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx");
}

_id_9490CCB2177749A8(_id_EFA8EF05B190D7D0, owner) {
  _id_B8EBE3F71A08AB40 = _id_6C4E8CEA70BF4B6D::_id_5F6D9FD82BDD2D05(_id_EFA8EF05B190D7D0);
  _id_B8EBE3F71A08AB40.owner = owner;
  owner._id_B8EBE3F71A08AB40 = _id_B8EBE3F71A08AB40;
  _id_B8EBE3F71A08AB40.players = [];
  _id_B8EBE3F71A08AB40.funcs["onInit"] = ::_id_1C76CE9FAF00EDD7;
  _id_B8EBE3F71A08AB40.funcs["onPlayerAssigned"] = ::_id_DD6410A59565D135;
  _id_B8EBE3F71A08AB40.funcs["onPlayerJoined"] = ::_id_B380232FAFD74325;
  _id_B8EBE3F71A08AB40.funcs["onPlayerRemoved"] = ::_id_7204F8AB0CCDB640;
  _id_B8EBE3F71A08AB40.funcs["onTeamStart"] = ::_id_B28DC157DBD35764;
  _id_B8EBE3F71A08AB40.funcs["onPlayerExitVolume"] = ::_id_FC5CEBAF6FF3BFD6;
  _id_B8EBE3F71A08AB40.funcs["onPlayerExitTimeout"] = ::_id_E09F977D133BAC40;
  _id_B8EBE3F71A08AB40.funcs["onPlayerReenterVolume"] = ::_id_E687CE41DA9F8EF7;
  _id_B8EBE3F71A08AB40.ref = "br_hold";
  _id_B8EBE3F71A08AB40._id_30E8A65CFF941C7A = _id_64ACB6CE534155B7::getquesttableindex(_id_B8EBE3F71A08AB40.ref);
  _id_B8EBE3F71A08AB40._id_40DBDB41F33299F7 = 0;
  _id_B8EBE3F71A08AB40.tier = _id_B8EBE3F71A08AB40.owner _id_744CAD313ED0A87E::_id_B7A9796C95AA8E8D();

  if(_id_B8EBE3F71A08AB40.tier == "black") {
    _id_B8EBE3F71A08AB40._id_8A05EBA9B77F8D12 = 49;
    _id_B8EBE3F71A08AB40.mission_complete = 50;
    _id_B8EBE3F71A08AB40.mission_fail = 0;
    _id_B8EBE3F71A08AB40._id_BD764B17D3BF6325 = 0;
    _id_B8EBE3F71A08AB40._id_3FA17A5A7AF04803 = 65;
  } else {
    _id_B8EBE3F71A08AB40._id_8A05EBA9B77F8D12 = 49;
    _id_B8EBE3F71A08AB40.mission_complete = 50;
    _id_B8EBE3F71A08AB40.mission_fail = 0;
    _id_B8EBE3F71A08AB40._id_BD764B17D3BF6325 = 0;
    _id_B8EBE3F71A08AB40._id_3FA17A5A7AF04803 = 65;
  }

  return _id_B8EBE3F71A08AB40;
}

_id_1C76CE9FAF00EDD7() {
  _id_B8EBE3F71A08AB40 = self;
  _id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0.origin = _id_B8EBE3F71A08AB40.owner.origin;
  _id_B8EBE3F71A08AB40.circleradius = level._id_DAC66BB7E0B0F8A5.circleradius;
  level.iconneutral = "hold_icon_captureneutral_br";
  level.iconcapture = "hold_icon_capture_br";
  level._id_1AB489E74BD53602 = "hold_icon_capture_enemy_br";
  level.icondefend = "hold_icon_defend_br";
  level.icondefending = "hold_icon_defending_br";
  level.iconcontested = "hold_icon_contested_br";
  level.icontaking = "hold_icon_taking_br";
  level._id_FA0FE1EB08253674 = "hold_icon_taking_enemy_br";
  level.iconlosing = "hold_icon_losing_br";
  level.iconovertime = "hold_icon_ot_br";
}

_id_62D882541A989602() {
  _id_B8EBE3F71A08AB40 = self;
  trigger = spawn("trigger_radius", _id_B8EBE3F71A08AB40.owner.crate.origin, 0, level._id_DAC66BB7E0B0F8A5.circleradius, 62);
  _id_B8EBE3F71A08AB40._id_54F5E15C58954932 = _id_B8EBE3F71A08AB40 _id_90087F601DAF9FA1(trigger, "neutral", 0, 1, 0);
  _id_B8EBE3F71A08AB40._id_54F5E15C58954932.onuse = ::_id_9498066C4D179FC0;
  _id_B8EBE3F71A08AB40._id_54F5E15C58954932.onbeginuse = ::_id_423F3FA547719245;
  _id_B8EBE3F71A08AB40._id_54F5E15C58954932.onenduse = ::_id_581B3C43ABA983C5;
  _id_B8EBE3F71A08AB40._id_54F5E15C58954932.id = "domFlag";
  _id_B8EBE3F71A08AB40._id_54F5E15C58954932.ignorestomp = 1;
  _id_B8EBE3F71A08AB40._id_54F5E15C58954932 scripts\mp\gameobjects::requestid(0, 1, undefined, 0, 0);
  _id_B8EBE3F71A08AB40._id_54F5E15C58954932.visibilitymanuallycontrolled = 1;
  _id_B8EBE3F71A08AB40._id_54F5E15C58954932._id_F0A9A5C4D6084AE7 = _id_B8EBE3F71A08AB40.owner;
  _id_B8EBE3F71A08AB40._id_54F5E15C58954932._id_B8EBE3F71A08AB40 = _id_B8EBE3F71A08AB40;
  _id_B8EBE3F71A08AB40.circlecenter = _id_B8EBE3F71A08AB40.owner.crate.origin;
  _id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_325390EDB051CD5D("Explore_Dmz", [_id_B8EBE3F71A08AB40.circlecenter], level._id_DAC66BB7E0B0F8A5.circleradius);
  objective_removeallfrommask(_id_B8EBE3F71A08AB40._id_54F5E15C58954932.objidnum);
  objective_showtoplayersinmask(_id_B8EBE3F71A08AB40._id_54F5E15C58954932.objidnum);
  _id_B8EBE3F71A08AB40 _id_DD16568083975585();
}

_id_90087F601DAF9FA1(trigger, team, _id_5DDBC1FAED2C56E6, _id_08B9949739F4E0F6, showoncompass) {
  _id_B8EBE3F71A08AB40 = self;
  _id_B8069681EDB5D72D();
  trigger scripts\common\utility::_id_57257D1ED9CE2F48(::_id_A75FAC84A75A8110);
  trigger._id_B8EBE3F71A08AB40 = _id_B8EBE3F71A08AB40;
  visuals[0] = spawn("script_model", trigger.origin);
  visuals[0] setModel("tag_origin");
  visuals[0].angles = _id_B8EBE3F71A08AB40.owner.crate.angles;

  if(!isDefined(level._id_FB607D7BF823F6F9))
    level._id_FB607D7BF823F6F9 = level._id_DAC66BB7E0B0F8A5.capturetime * 0.5;

  _id_3C2389BA69E5822B = undefined;
  team = "neutral";
  domflag = scripts\mp\gameobjects::createuseobject(team, trigger, visuals, (0, 0, 62), _id_3C2389BA69E5822B, _id_08B9949739F4E0F6, showoncompass);
  domflag scripts\mp\gameobjects::allowuse("any");
  domflag scripts\mp\gameobjects::cancontestclaim(1);
  domflag scripts\mp\gameobjects::setusetime(level._id_DAC66BB7E0B0F8A5.capturetime);
  domflag scripts\mp\gameobjects::pinobjiconontriggertouch();

  if(isDefined(level.capturetype))
    domflag scripts\mp\gameobjects::setcapturebehavior(_id_6663215F917210AE::getcapturetype());

  domflag.onuse = ::_id_9498066C4D179FC0;
  domflag.onbeginuse = ::_id_423F3FA547719245;
  domflag.onenduse = ::_id_581B3C43ABA983C5;
  domflag.onuncontested = ::_id_425361A8192F04A3;
  domflag.oncontested = ::_id_37011FA9CB797322;
  domflag.onuseupdate = _id_6663215F917210AE::dompoint_onuseupdate;
  domflag.onpinnedstate = _id_6663215F917210AE::dompoint_onpinnedstate;
  domflag.onunpinnedstate = _id_6663215F917210AE::dompoint_onunpinnedstate;
  domflag.nousebar = 1;
  domflag.id = "domFlag";
  domflag.claimgracetime = level._id_DAC66BB7E0B0F8A5.capturetime * 1000;
  domflag.firstcapture = 1;
  domflag._id_823C5A7BF6A0E64A = 0;
  domflag._id_FB60F3AEC3A62F06 = level._id_0393D50BC6A378DC;

  if(istrue(domflag._id_823C5A7BF6A0E64A)) {
    domflag._id_9ABE4AB71AE5D548 = domflag.usetime - 1;
    domflag._id_D701BF01C81A10B3 = level._id_D701BF01C81A10B3;

    if(isDefined(level._id_CF4070FA327A81A2) && level._id_CF4070FA327A81A2 > 0)
      domflag.decayrate = domflag.usetime * level.framedurationseconds / level._id_CF4070FA327A81A2;
  }

  domflag.baseeffectpos = trigger.origin;
  domflag.noscriptable = 1;
  domflag _id_6663215F917210AE::initializematchrecording();

  if(!istrue(_id_08B9949739F4E0F6))
    domflag _id_6663215F917210AE::domflag_setneutral();

  return domflag;
}

_id_A75FAC84A75A8110() {
  trigger = self;

  if(isDefined(trigger._id_B8EBE3F71A08AB40))
    trigger._id_B8EBE3F71A08AB40 thread _id_ADDDA96BA479DB4E(undefined, 1);

  return 0;
}

_id_425361A8192F04A3(lastclaimteam) {
  if(istrue(level.flagneutralization) && !self.firstcapture)
    scripts\mp\gameobjects::setusetime(level.flagcapturetime * 0.5);

  self.contestedtime = undefined;
  self.didstatusnotify = 0;
  ownerteam = scripts\mp\gameobjects::getownerteam();
  _id_FF99447227B9FBAC = scripts\engine\utility::ter_op(ownerteam == "neutral", "idle", ownerteam);
  thread _id_6663215F917210AE::updateflagstate(_id_FF99447227B9FBAC, 0);
  self._id_B8EBE3F71A08AB40 _id_68B9BA1DE74CB130();
}

_id_B8069681EDB5D72D() {
  _setdomencountericoninfo("hold_icon_captureneutral_br", "neutral", "hud_icon_objective_defend_point_neutral");
  _setdomencountericoninfo("hold_icon_defend_br", "friendly", "hud_icon_objective_defend_point_friendly");
  _setdomencountericoninfo("hold_icon_defending_br", "friendly", "hud_icon_objective_defend_point_friendly");
  _setdomencountericoninfo("hold_icon_contested_br", "contest", "hud_icon_objective_defend_point_contest");
  _setdomencountericoninfo("hold_icon_losing_br", "enemy", "hud_icon_objective_defend_point_enemy");
  _setdomencountericoninfo("hold_icon_ot_br", "friendly", "hud_icon_objective_defend_point_friendly");
  _setdomencountericoninfo("hold_icon_taking_br", "friendly", "hud_icon_objective_defend_point_friendly");
  _setdomencountericoninfo("hold_icon_taking_enemy_br", "enemy", "hud_icon_objective_defend_point_enemy");
  _setdomencountericoninfo("hold_icon_capture_br", "friendly", "hud_icon_objective_defend_point_friendly");
  _setdomencountericoninfo("hold_icon_capture_enemy_br", "enemy", "hud_icon_objective_defend_point_enemy");
}

_setdomencountericoninfo(name, colors, icon) {
  level.waypointcolors[name] = colors;
  level.waypointbgtype[name] = 1;
  level.waypointshader[name] = icon;
}

_id_37011FA9CB797322(lastclaimteam) {
  _id_6663215F917210AE::dompoint_oncontested();
  self._id_B8EBE3F71A08AB40 _id_68B9BA1DE74CB130();
}

_id_423F3FA547719245(player) {
  _id_54F5E15C58954932 = self;
  player.iscapturing = 1;
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral" && isPlayer(player))
    player setclientomnvar("ui_objective_pinned_text_param", 1);

  self.didstatusnotify = 1;
  self._id_B8EBE3F71A08AB40 _id_68B9BA1DE74CB130();
}

_id_9498066C4D179FC0(player) {
  _id_54F5E15C58954932 = self;
  isvalidplayer = isDefined(player) && isPlayer(player) && isalive(player);

  if(isvalidplayer) {
    if(istrue(level._id_25E8B4AFE5E06169)) {
      if(isDefined(_id_54F5E15C58954932._id_F0A9A5C4D6084AE7._id_04756733ECC825A2)) {
        if(_id_54F5E15C58954932._id_F0A9A5C4D6084AE7._id_04756733ECC825A2 != player.team) {
          level thread _id_64ACB6CE534155B7::utilflare_shootflare(_id_54F5E15C58954932._id_F0A9A5C4D6084AE7.origin, "revive", 1);
          dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

          if(!isDefined(_id_54F5E15C58954932._id_BA8EBD863C649D8E))
            _id_54F5E15C58954932._id_BA8EBD863C649D8E = [];

          if(!scripts\engine\utility::array_contains(_id_54F5E15C58954932._id_BA8EBD863C649D8E, player.team) && !istrue(level._id_702998E8E05D126F)) {
            player _id_744CAD313ED0A87E::_id_9D216F4CD30F141D(dropstruct, scripts\mp\utility\player::getteamarray(player.team, 0), player.team);
            _id_54F5E15C58954932._id_BA8EBD863C649D8E = scripts\engine\utility::array_add(_id_54F5E15C58954932._id_BA8EBD863C649D8E, player.team);
          }

          _id_54F5E15C58954932._id_B8EBE3F71A08AB40 _id_ADDDA96BA479DB4E(player.team, 0, 1);
          _id_54F5E15C58954932._id_B8EBE3F71A08AB40.owner _id_C148F98E91E7DF37(dropstruct, player);
        }
      } else {
        level thread _id_64ACB6CE534155B7::utilflare_shootflare(_id_54F5E15C58954932._id_F0A9A5C4D6084AE7.origin, "revive", 1);
        dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

        if(!isDefined(_id_54F5E15C58954932._id_BA8EBD863C649D8E))
          _id_54F5E15C58954932._id_BA8EBD863C649D8E = [];

        if(!scripts\engine\utility::array_contains(_id_54F5E15C58954932._id_BA8EBD863C649D8E, player.team)) {
          player _id_744CAD313ED0A87E::_id_9D216F4CD30F141D(dropstruct, scripts\mp\utility\player::getteamarray(player.team, 0), player.team);
          _id_54F5E15C58954932._id_BA8EBD863C649D8E = scripts\engine\utility::array_add(_id_54F5E15C58954932._id_BA8EBD863C649D8E, player.team);
        }

        _id_54F5E15C58954932._id_B8EBE3F71A08AB40 _id_ADDDA96BA479DB4E(player.team, 0, 1);
        _id_54F5E15C58954932._id_B8EBE3F71A08AB40.owner _id_C148F98E91E7DF37(dropstruct, player);
      }
    } else {
      level thread _id_64ACB6CE534155B7::utilflare_shootflare(_id_54F5E15C58954932._id_F0A9A5C4D6084AE7.origin, "revive", 1);
      dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
      _id_54F5E15C58954932._id_B8EBE3F71A08AB40.owner _id_C148F98E91E7DF37(dropstruct, player);
      _id_6C4E8CEA70BF4B6D::_id_6F6F83AB76483811(_id_54F5E15C58954932._id_B8EBE3F71A08AB40, player);
      player _id_744CAD313ED0A87E::_id_9D216F4CD30F141D(dropstruct, scripts\mp\utility\player::getteamarray(player.team, 0), player.team);
      _id_54F5E15C58954932._id_B8EBE3F71A08AB40 _id_ADDDA96BA479DB4E(player.team);
    }
  }
}

_id_581B3C43ABA983C5(team, player, success) {
  if(isPlayer(player)) {
    player.iscapturing = 0;
    player setclientomnvar("ui_objective_pinned_text_param", 0);
    player.ui_dom_securing = undefined;
  }

  self._id_B8EBE3F71A08AB40 _id_68B9BA1DE74CB130();
  self.didstatusnotify = 0;

  if(isDefined(team) && team == "none" || player.team != team) {
    return;
  }
  thread _id_6663215F917210AE::updateflagstate(team, 0);
  self.neutralized = 0;
}

_id_29C7E65E828011CF(enable) {
  if(enable) {
    scripts\mp\gameobjects::allowuse("any");
    self.trigger scripts\engine\utility::trigger_on();
  } else {
    scripts\mp\gameobjects::allowuse("none");
    self.trigger scripts\engine\utility::trigger_off();
    scripts\mp\gameobjects::resetcaptureprogress();
  }
}

_id_41A10DD91E376F32(enable, _id_9CB4BDC2122D46EB, _id_DDF49B0F7BD17A0C) {
  _id_B8EBE3F71A08AB40 = self;
  _id_B8EBE3F71A08AB40._id_54F5E15C58954932 notify("brTask_holdSetVisible");

  if(enable)
    _id_B8EBE3F71A08AB40 _id_68B9BA1DE74CB130();
  else
    _id_B8EBE3F71A08AB40._id_54F5E15C58954932 _id_5F306CD80AD9FD17(_id_B8EBE3F71A08AB40.owner, _id_9CB4BDC2122D46EB, _id_DDF49B0F7BD17A0C);
}

_id_5F306CD80AD9FD17(owner, _id_9CB4BDC2122D46EB, _id_DDF49B0F7BD17A0C) {
  _id_54F5E15C58954932 = self;
  _id_54F5E15C58954932 endon("brTask_holdSetVisible");

  if(!istrue(_id_DDF49B0F7BD17A0C)) {
    objective_setpinned(_id_54F5E15C58954932.objidnum, 0);
    wait 1;
  }

  _id_54F5E15C58954932._id_B8EBE3F71A08AB40 _id_562F681BFEEDC7C3();
}

_id_69826AF85003AB57(owner) {
  _id_54F5E15C58954932 = self;

  if(!isDefined(owner._id_AAC94CE6A0278A36)) {
    return;
  }
  objective_removeallfrommask(_id_54F5E15C58954932.objidnum);

  foreach(ent in owner._id_AAC94CE6A0278A36._id_ABE8F125E1A6AD1E) {
    if(isPlayer(ent) && scripts\mp\utility\player::isreallyalive(ent))
      objective_addclienttomask(_id_54F5E15C58954932.objidnum, ent);
  }
}

_id_562F681BFEEDC7C3() {
  _id_B8EBE3F71A08AB40 = self;
  objective_removeallfrommask(_id_B8EBE3F71A08AB40._id_54F5E15C58954932.objidnum);
  objective_removeallfrommask(_id_B8EBE3F71A08AB40._id_936E3FF613F879A1.objidnum);
}

_id_DD6410A59565D135(_id_FABF84450735DD93, player) {
  _id_B8EBE3F71A08AB40 = self;
  _id_AA128E29D7C10074 = scripts\cp_mp\utility\game_utility::isaigameparticipant(player);
  _id_B8EBE3F71A08AB40.owner _id_744CAD313ED0A87E::_id_DACF98A6E7ACADEB(player, player.team);

  if(!istrue(player._id_03E65A82AFB7EB67))
    player._id_03E65A82AFB7EB67 = 1;
  else
    return;

  if(istrue(level._id_25E8B4AFE5E06169) && isDefined(_id_B8EBE3F71A08AB40._id_54F5E15C58954932)) {
    if(!isDefined(_id_B8EBE3F71A08AB40._id_54F5E15C58954932._id_F0A9A5C4D6084AE7._id_04756733ECC825A2))
      _id_4948CDF739393D2D::_id_D95DBF57B47734D9(_id_B8EBE3F71A08AB40.owner, 1);
  } else
    _id_4948CDF739393D2D::_id_D95DBF57B47734D9(_id_B8EBE3F71A08AB40.owner, 1);

  _id_B8EBE3F71A08AB40 thread _id_03314ADD7998AB13::_id_A33C10C0682918BD(_id_B8EBE3F71A08AB40.owner._id_E1DD7BED632A13C3, 3000);

  if(!isDefined(_id_B8EBE3F71A08AB40._id_54F5E15C58954932)) {
    _id_B8EBE3F71A08AB40 _id_62D882541A989602();
    _id_B8EBE3F71A08AB40._id_54F5E15C58954932._id_B939ABDEDC45C697 = player.team;
    _id_B8EBE3F71A08AB40 thread _id_744CAD313ED0A87E::_id_6162D039FD0CDBD4(_id_B8EBE3F71A08AB40.owner, "high", level._id_DAC66BB7E0B0F8A5._id_CBB87A25616A7681);
    _id_B8EBE3F71A08AB40 thread _id_56D0BE781029A019();
  }

  if(_id_AA128E29D7C10074) {
    _id_B8EBE3F71A08AB40 _id_B380232FAFD74325(player);
    return;
  }

  _id_B8EBE3F71A08AB40 thread _id_682E6A05A3109EA1();
  _id_B8EBE3F71A08AB40 _id_B380232FAFD74325(player);
  player._id_03E65A82AFB7EB67 = undefined;
}

_id_56D0BE781029A019() {
  level endon("game_ended");
  _id_B8EBE3F71A08AB40 = self;
  _id_B8EBE3F71A08AB40 endon("task_ended");

  while(isDefined(_id_B8EBE3F71A08AB40._id_54F5E15C58954932) && isDefined(_id_B8EBE3F71A08AB40._id_54F5E15C58954932.usetime) && _id_B8EBE3F71A08AB40._id_54F5E15C58954932.usetime * level._id_DAC66BB7E0B0F8A5._id_B78E47E5CB9E429A > _id_B8EBE3F71A08AB40._id_54F5E15C58954932.curprogress)
    wait 0.5;

  thread _id_744CAD313ED0A87E::_id_6162D039FD0CDBD4(_id_B8EBE3F71A08AB40.owner, "high", level._id_DAC66BB7E0B0F8A5._id_62623980DC128FD7);

  while(isDefined(_id_B8EBE3F71A08AB40._id_54F5E15C58954932) && isDefined(_id_B8EBE3F71A08AB40._id_54F5E15C58954932.usetime) && _id_B8EBE3F71A08AB40._id_54F5E15C58954932.usetime * level._id_DAC66BB7E0B0F8A5._id_281E288AE263A2B9 > _id_B8EBE3F71A08AB40._id_54F5E15C58954932.curprogress)
    wait 0.5;

  thread _id_744CAD313ED0A87E::_id_6162D039FD0CDBD4(_id_B8EBE3F71A08AB40.owner, "high", level._id_DAC66BB7E0B0F8A5._id_EE98DF80874C48E0);
}

_id_B380232FAFD74325(player) {
  _id_B8EBE3F71A08AB40 = self;

  if(!isDefined(scripts\engine\utility::array_find(_id_B8EBE3F71A08AB40.players, player))) {
    _id_A61C75B156FC1EE0 = _id_B8EBE3F71A08AB40.players.size;
    _id_B8EBE3F71A08AB40.players[_id_A61C75B156FC1EE0] = player;
  }

  _id_AA128E29D7C10074 = scripts\cp_mp\utility\game_utility::isaigameparticipant(player);

  if(_id_AA128E29D7C10074) {
    return;
  }
  if(!isDefined(_id_B8EBE3F71A08AB40._id_B939ABDEDC45C697))
    _id_B8EBE3F71A08AB40._id_B939ABDEDC45C697 = player.team;

  _id_B8EBE3F71A08AB40._id_54F5E15C58954932 _id_29C7E65E828011CF(1);
  _id_B8EBE3F71A08AB40 _id_41A10DD91E376F32(1);
  player.initialized_gameobject_vars = 1;

  if(!isDefined(player.touchtriggers))
    player.touchtriggers = [];

  player thread scripts\mp\hud_message::showsplash("stronghold_operation_hold_the_line");
  wait 4;

  if(!isDefined(player) || !scripts\engine\utility::array_contains(_id_B8EBE3F71A08AB40.players, player)) {
    return;
  }
  _id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_1851E9CFB7687F68(player);
}

_id_7204F8AB0CCDB640(player) {
  _id_B8EBE3F71A08AB40 = self;
  _id_AA128E29D7C10074 = scripts\cp_mp\utility\game_utility::isaigameparticipant(player);
  _id_B8EBE3F71A08AB40.players = scripts\engine\utility::array_remove(_id_B8EBE3F71A08AB40.players, player);

  if(_id_AA128E29D7C10074) {
    return;
  }
  _id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_556FB3A465F0E978(player);
  _id_B8EBE3F71A08AB40._id_54F5E15C58954932 _id_581B3C43ABA983C5(player.team, player, 0);
}

_id_B28DC157DBD35764(_id_FABF84450735DD93) {}

_id_59A5A14BCE811CDD(_id_FABF84450735DD93, _id_B677BBE2241C4E3F, _id_AD590A75663898F3, _id_0641C32466AF43F9) {
  _id_B8EBE3F71A08AB40 = self;
  _id_5F8FC154303502FA = _id_B8EBE3F71A08AB40 _id_03314ADD7998AB13::_id_AD20469C1815A7C7(_id_FABF84450735DD93, 1);
  level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[_id_FABF84450735DD93]._id_83ABCB9B3A5DBE24 = scripts\engine\utility::array_remove(level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[_id_FABF84450735DD93]._id_83ABCB9B3A5DBE24, _id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0.id);
  _id_B8EBE3F71A08AB40.teams = scripts\engine\utility::array_remove(_id_B8EBE3F71A08AB40.teams, _id_FABF84450735DD93);
  level._id_1B7407DFFE81E6E8._id_A5816A0B9C7279C1[_id_FABF84450735DD93].active = 0;

  foreach(player in _id_5F8FC154303502FA) {
    _id_B8EBE3F71A08AB40.players = scripts\engine\utility::array_remove(_id_B8EBE3F71A08AB40.players, player);
    _id_B8EBE3F71A08AB40._id_54F5E15C58954932 _id_581B3C43ABA983C5(_id_FABF84450735DD93, player, _id_0641C32466AF43F9);

    if(scripts\cp_mp\utility\game_utility::isaigameparticipant(player)) {
      continue;
    }
    if(_id_B677BBE2241C4E3F == _id_B8EBE3F71A08AB40.mission_complete) {
      player thread scripts\mp\hud_message::showsplash("stronghold_operation_hold_the_line_completed");
      continue;
    }

    if(istrue(_id_AD590A75663898F3)) {
      player thread scripts\mp\hud_message::showsplash("stronghold_operation_hold_the_line_failed");
      continue;
    }

    player thread scripts\mp\hud_message::showsplash("stronghold_operation_hold_the_line_failed");
  }
}

_id_FC5CEBAF6FF3BFD6(player) {
  _id_B8EBE3F71A08AB40 = self;
  player._id_E09C6EA56555F1ED = 1;
  _id_AA128E29D7C10074 = scripts\cp_mp\utility\game_utility::isaigameparticipant(player);
}

_id_E687CE41DA9F8EF7(player) {
  _id_B8EBE3F71A08AB40 = self;
  player._id_E09C6EA56555F1ED = undefined;
}

_id_E09F977D133BAC40(player) {
  _id_B8EBE3F71A08AB40 = self;
  _id_B8EBE3F71A08AB40 _id_7204F8AB0CCDB640(player);
  player._id_E09C6EA56555F1ED = undefined;
  player._id_ED5A962D857703EC = undefined;

  if(isDefined(level._id_FC0E8C2EA4F84613))
    _id_B8EBE3F71A08AB40[[level._id_FC0E8C2EA4F84613]](player);
}

_id_ADDDA96BA479DB4E(_id_FABF84450735DD93, _id_AD590A75663898F3, loop) {
  _id_B8EBE3F71A08AB40 = self;

  if(isDefined(level._id_3AFACC0C3B10B7FE))
    _id_B8EBE3F71A08AB40.owner[[level._id_3AFACC0C3B10B7FE]](_id_FABF84450735DD93, !istrue(_id_AD590A75663898F3));

  if(istrue(loop)) {
    if(isDefined(_id_B8EBE3F71A08AB40._id_54F5E15C58954932._id_F0A9A5C4D6084AE7._id_04756733ECC825A2)) {
      foreach(player in scripts\mp\utility\teams::getteamdata(_id_B8EBE3F71A08AB40._id_54F5E15C58954932._id_F0A9A5C4D6084AE7._id_04756733ECC825A2, "players"))
      player thread scripts\mp\hud_message::showsplash("stronghold_operation_hold_the_line_stolen");
    }

    foreach(team in _id_B8EBE3F71A08AB40.teams) {
      _id_0641C32466AF43F9 = 0;

      if(isDefined(_id_FABF84450735DD93) && isDefined(team))
        _id_0641C32466AF43F9 = team == _id_FABF84450735DD93;

      _id_B677BBE2241C4E3F = _id_B8EBE3F71A08AB40.mission_fail;

      if(_id_0641C32466AF43F9)
        _id_B677BBE2241C4E3F = _id_B8EBE3F71A08AB40.mission_complete;

      _id_5F8FC154303502FA = _id_B8EBE3F71A08AB40 _id_03314ADD7998AB13::_id_AD20469C1815A7C7(team, 1);

      foreach(player in _id_5F8FC154303502FA) {
        if(isDefined(_id_B8EBE3F71A08AB40._id_54F5E15C58954932._id_F0A9A5C4D6084AE7._id_04756733ECC825A2)) {
          if(player.team == _id_B8EBE3F71A08AB40._id_54F5E15C58954932._id_F0A9A5C4D6084AE7._id_04756733ECC825A2)
            continue;
        }

        if(scripts\cp_mp\utility\game_utility::isaigameparticipant(player)) {
          continue;
        }
        if(_id_B677BBE2241C4E3F == _id_B8EBE3F71A08AB40.mission_complete) {
          player thread scripts\mp\hud_message::showsplash("stronghold_operation_hold_the_line_completed");
          continue;
        }

        if(istrue(_id_AD590A75663898F3)) {
          player thread scripts\mp\hud_message::showsplash("stronghold_operation_hold_the_line_failed");
          continue;
        }

        player thread scripts\mp\hud_message::showsplash("stronghold_operation_hold_the_line_failed");
      }
    }
  } else {
    _id_B8EBE3F71A08AB40 notify("task_ended");
    _id_4948CDF739393D2D::_id_BE5A531F97B7C07E(_id_B8EBE3F71A08AB40.owner);
    _id_ED264F0DF8BF58FB = 0;

    foreach(team in _id_B8EBE3F71A08AB40.teams) {
      _id_0641C32466AF43F9 = 0;

      if(isDefined(_id_FABF84450735DD93) && isDefined(team))
        _id_0641C32466AF43F9 = team == _id_FABF84450735DD93;

      _id_B677BBE2241C4E3F = _id_B8EBE3F71A08AB40.mission_fail;

      if(_id_0641C32466AF43F9) {
        _id_ED264F0DF8BF58FB = 1;
        _id_B677BBE2241C4E3F = _id_B8EBE3F71A08AB40.mission_complete;
      }

      _id_B8EBE3F71A08AB40 _id_59A5A14BCE811CDD(team, _id_B677BBE2241C4E3F, _id_AD590A75663898F3, _id_0641C32466AF43F9);
    }

    _id_B8EBE3F71A08AB40.players = [];
    _id_B8EBE3F71A08AB40.teams = [];
    _id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_2476DAEFA3384C5E();
    _id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_629ED367D1393020();
    _id_B8EBE3F71A08AB40 _id_114582ECFEBB0ACC();

    if(istrue(_id_AD590A75663898F3))
      _id_B8EBE3F71A08AB40.owner.crate thread _id_744CAD313ED0A87E::_id_FAA1ECBC7F0BED85(undefined, 0, 1, 1, 0);

    if(!isDefined(_id_AD590A75663898F3))
      _id_AD590A75663898F3 = 0;

    _id_B8EBE3F71A08AB40.starttime = undefined;

    if(isDefined(_id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0) && isDefined(_id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0._id_B7718B6E41108129) && _id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0._id_B7718B6E41108129.size >= 1 && (_id_ED264F0DF8BF58FB || _id_AD590A75663898F3)) {
      _id_B8EBE3F71A08AB40.owner._id_E1DD7BED632A13C3 notify("activity_ended");
      level._id_1B7407DFFE81E6E8._id_83ABCB9B3A5DBE24[_id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0.id] = undefined;
      _id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0._id_B7718B6E41108129 = undefined;
      _id_6663215F917210AE::removeobjective(_id_B8EBE3F71A08AB40._id_54F5E15C58954932);
    }
  }
}

_id_682E6A05A3109EA1() {
  _id_B8EBE3F71A08AB40 = self;
  level endon("game_ended");
  _id_B8EBE3F71A08AB40 endon("task_ended");
  _id_B8EBE3F71A08AB40.owner._id_E1DD7BED632A13C3 endon("deleted");
  _id_B8EBE3F71A08AB40.owner._id_E1DD7BED632A13C3 endon("activity_ended");

  if(istrue(_id_B8EBE3F71A08AB40.owner._id_D7BE9C77CE31B93D)) {
    return;
  }
  origin = _id_B8EBE3F71A08AB40.owner.origin + (0, 0, 62);
  _id_B8EBE3F71A08AB40.owner._id_D7BE9C77CE31B93D = 1;
  waitframe();
  waittillframeend;

  while(_id_58F20490049AF6AC::_id_EE854FDD1E77EFC4(origin) || _id_58F20490049AF6AC::_id_A465E3C1371D7DAB(origin))
    wait 0.25;

  foreach(player in _id_B8EBE3F71A08AB40.players) {
    if(!isDefined(player)) {
      continue;
    }
    _id_AA128E29D7C10074 = scripts\cp_mp\utility\game_utility::isaigameparticipant(player);

    if(_id_AA128E29D7C10074) {
      continue;
    }
    _id_B8EBE3F71A08AB40 thread _id_E09F977D133BAC40(player);
  }

  _id_B8EBE3F71A08AB40 thread _id_ADDDA96BA479DB4E(undefined, 1);
  return;
}

_id_C148F98E91E7DF37(dropstruct, player) {
  _id_276AC5E84835EA87 = self;

  if(istrue(level._id_25E8B4AFE5E06169) && istrue(_id_276AC5E84835EA87._id_6DFAEE5EE2B3FA4B))
    _id_276AC5E84835EA87 _id_744CAD313ED0A87E::_id_5C26662D5381E975(player, undefined, undefined, 1);
  else {
    _id_276AC5E84835EA87 _id_744CAD313ED0A87E::_id_5C26662D5381E975(player, undefined, undefined, 1);

    if(istrue(level._id_10171E70E51C0380))
      _id_11245B6B51AC26B7(dropstruct, player, _id_276AC5E84835EA87.crate);
  }
}

_id_11245B6B51AC26B7(dropstruct, player, crate) {
  _id_4DBE8EF27554367A = getdvarint("dvar_3174D9A2553A5FA7", -1);
  _id_75EA56AC509FED3B = getscriptcachecontents("bomb_defuse_reward", 0);
  _id_DF2F68507645906F = ["brloot_super_munitionsbox", "brloot_super_armorbox"];
  _id_F2B8863302006284 = undefined;
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::_id_3D0F2343793D709B(player.team, player._id_0FF97225579DE16A, 0);

  if(isDefined(_id_6D5ED003AF1F9612))
    _id_F2B8863302006284 = _id_6D5ED003AF1F9612.size;

  if(_id_4DBE8EF27554367A >= 0) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_4DBE8EF27554367A; _id_AC0E594AC96AA3A8++) {
      _id_610520BE555433B2 = randomintrange(0, 25);
      _id_75EA56AC509FED3B = getscriptcachecontents("bomb_defuse_reward", _id_610520BE555433B2);
      _id_3D712346AFFF9EF3(dropstruct, player, crate, _id_75EA56AC509FED3B);
    }
  } else if(isDefined(_id_F2B8863302006284)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F2B8863302006284; _id_AC0E594AC96AA3A8++) {
      _id_610520BE555433B2 = randomintrange(0, 25);
      _id_75EA56AC509FED3B = getscriptcachecontents("bomb_defuse_reward", _id_610520BE555433B2);
      _id_75EA56AC509FED3B[_id_75EA56AC509FED3B.size] = _id_DF2F68507645906F[_id_AC0E594AC96AA3A8 % _id_DF2F68507645906F.size];
      _id_3D712346AFFF9EF3(dropstruct, player, crate, _id_75EA56AC509FED3B);
    }
  } else
    _id_3D712346AFFF9EF3(dropstruct, player, crate, _id_75EA56AC509FED3B);

  if(getdvarint("dvar_81E631C248118CD6", 1) != 1)
    return;
  else {
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, player.origin, player.angles, player);
    count = undefined;
    spawned = _id_7E52B56769FA7774::spawnpickup("brloot_gascan_palfa", _id_CB4FAD49263E20C4, count);
  }
}

_id_3D712346AFFF9EF3(dropstruct, player, crate, _id_75EA56AC509FED3B) {
  if(isDefined(crate) && getdvarint("dvar_13C3754911CCA521", 1)) {
    crate.itemsdropped = 0;
    crate _id_552B8E4EA5FF7DF1::lootspawnitemlist(dropstruct, _id_75EA56AC509FED3B, 1, player);
    return;
  }

  count = undefined;

  foreach(_id_5B63AED4A779B0AA in _id_75EA56AC509FED3B) {
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, player.origin, player.angles, player);
    count = level.br_pickups.counts[_id_5B63AED4A779B0AA];
    spawned = _id_7E52B56769FA7774::spawnpickup(_id_5B63AED4A779B0AA, _id_CB4FAD49263E20C4, count);

    if(isDefined(spawned))
      spawned setscriptablepartstate(_id_5B63AED4A779B0AA, "dropped");
  }
}

_id_DD16568083975585() {
  _id_B8EBE3F71A08AB40 = self;
  _id_B8EBE3F71A08AB40._id_936E3FF613F879A1 = spawnStruct();
  _id_B8EBE3F71A08AB40._id_936E3FF613F879A1.curorigin = _id_B8EBE3F71A08AB40._id_54F5E15C58954932.curorigin;
  _id_B8EBE3F71A08AB40._id_936E3FF613F879A1.offset3d = _id_B8EBE3F71A08AB40._id_54F5E15C58954932.offset3d;
  _id_B8EBE3F71A08AB40._id_936E3FF613F879A1 scripts\mp\gameobjects::requestid(0, 1, undefined, 0, 0);
  icon = scripts\mp\gameobjects::getwaypointshader(level._id_1AB489E74BD53602);
  scripts\mp\objidpoolmanager::update_objective_icon(_id_B8EBE3F71A08AB40._id_936E3FF613F879A1.objidnum, icon);
  _id_BAB98E6EFFF82B79 = scripts\mp\gameobjects::getwaypointbackgroundtype(level._id_1AB489E74BD53602);
  scripts\mp\objidpoolmanager::update_objective_setbackground(_id_B8EBE3F71A08AB40._id_936E3FF613F879A1.objidnum, _id_BAB98E6EFFF82B79);
  objective_setshowprogress(_id_B8EBE3F71A08AB40._id_936E3FF613F879A1.objidnum, 1);
  objective_removeallfrommask(_id_B8EBE3F71A08AB40._id_936E3FF613F879A1.objidnum);
  objective_showtoplayersinmask(_id_B8EBE3F71A08AB40._id_936E3FF613F879A1.objidnum);
  _id_B8EBE3F71A08AB40 thread _id_8676671228AC7F2C(_id_B8EBE3F71A08AB40._id_54F5E15C58954932, _id_B8EBE3F71A08AB40._id_936E3FF613F879A1);
}

_id_114582ECFEBB0ACC() {
  _id_B8EBE3F71A08AB40 = self;

  if(isDefined(_id_B8EBE3F71A08AB40._id_936E3FF613F879A1)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(_id_B8EBE3F71A08AB40._id_936E3FF613F879A1.objidnum);
    _id_B8EBE3F71A08AB40._id_936E3FF613F879A1.objidnum = -1;
  }
}

_id_8676671228AC7F2C(_id_54F5E15C58954932, _id_7457E79DBF4EBD2A) {
  _id_B8EBE3F71A08AB40 = self;
  level endon("game_ended");
  _id_B8EBE3F71A08AB40 endon("task_ended");

  while(isDefined(_id_7457E79DBF4EBD2A.objidnum) && _id_7457E79DBF4EBD2A.objidnum != -1) {
    progress = scripts\engine\utility::_id_53C4C53197386572(_id_54F5E15C58954932.curprogress, 0);
    _id_9565886677A296E0 = _id_54F5E15C58954932.curprogress / _id_54F5E15C58954932.usetime;
    scripts\mp\objidpoolmanager::objective_set_progress(_id_7457E79DBF4EBD2A.objidnum, _id_9565886677A296E0);
    wait 0.2;
  }
}

_id_68B9BA1DE74CB130() {
  _id_B8EBE3F71A08AB40 = self;
  _id_54F5E15C58954932 = _id_B8EBE3F71A08AB40._id_54F5E15C58954932;
  _id_936E3FF613F879A1 = _id_B8EBE3F71A08AB40._id_936E3FF613F879A1;
  claimteam = _id_54F5E15C58954932.claimteam;
  contested = isDefined(_id_54F5E15C58954932.contestedtime);
  neutral = !isDefined(claimteam) || claimteam == "none";

  if(contested)
    _id_54F5E15C58954932 scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontested);
  else if(neutral)
    _id_54F5E15C58954932 scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
  else {
    _id_54F5E15C58954932 scripts\mp\gameobjects::setobjectivestatusicons(level.icontaking);
    scripts\mp\objidpoolmanager::_id_9B1A086F348520B0(_id_54F5E15C58954932.objidnum, claimteam);
    scripts\mp\objidpoolmanager::objective_set_progress_team(_id_54F5E15C58954932.objidnum, claimteam);
    scripts\mp\objidpoolmanager::_id_9B1A086F348520B0(_id_936E3FF613F879A1.objidnum, claimteam);
    scripts\mp\objidpoolmanager::objective_set_progress_team(_id_936E3FF613F879A1.objidnum, claimteam);
  }

  _id_54F5E15C58954932 scripts\mp\gameobjects::setvisibleteam("any");
  _id_54F5E15C58954932 scripts\mp\gameobjects::setownerteam("neutral");
  objective_removeallfrommask(_id_54F5E15C58954932.objidnum);
  objective_removeallfrommask(_id_936E3FF613F879A1.objidnum);

  foreach(player in _id_B8EBE3F71A08AB40.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(contested || neutral || player.team == claimteam)
      objective_addclienttomask(_id_54F5E15C58954932.objidnum, player);
    else
      objective_addclienttomask(_id_936E3FF613F879A1.objidnum, player);

    _id_ECB343C4E911D9D0 = undefined;

    if(neutral)
      _id_ECB343C4E911D9D0 = 0;
    else if(contested)
      _id_ECB343C4E911D9D0 = 3;
    else if(player.team == claimteam)
      _id_ECB343C4E911D9D0 = 1;
    else
      _id_ECB343C4E911D9D0 = 2;

    player setclientomnvar("ui_br_stronghold_mission_status", _id_ECB343C4E911D9D0);
  }
}