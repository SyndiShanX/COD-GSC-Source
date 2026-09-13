/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7933519955f32c4e.gsc
***********************************************/

init() {
  _id_01F065571B3854F0 = _id_362C58E8BB39BCDA::isbrgametypefuncdefined("infilSequence");
  level._id_B4E9D46918F067BB = getdvarint("dvar_0C4A4576C5CA4960", 0) || _id_01F065571B3854F0;
  level._id_A696A93807ABB2FD = spawnStruct();
}

_id_B4E9D46918F067BB() {
  return level._id_B4E9D46918F067BB;
}

main() {
  if(!_id_B4E9D46918F067BB()) {
    return;
  }
  _id_567639D26F6A140B = getEnt("infil_plane", "script_noteworthy");

  if(isDefined(_id_567639D26F6A140B))
    _id_567639D26F6A140B hide();

  level.brlatespawnplayer = ::latespawnplayer;
  setdvarifuninitialized("dvar_04265A52F9F8A703", 1);
  setdvarifuninitialized("dvar_8BE4ACC5EEBB19CA", 1);
  setdvarifuninitialized("dvar_E65DC975D6FCFCA0", 0);
  level._effect["vfx_br_ac130_clouds"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_ac130_clouds");

  if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73()) {
    level._effect["vfx_br_infil_cloud_anim"] = loadfx("vfx/mgl/iw8_br/gameplay/infil/vfx_br_infil_cloud_anim");
    level._effect["vfx_br_infil_cloud_anim_moving"] = loadfx("vfx/mgl/iw8_br/gameplay/infil/vfx_br_infil_cloud_anim");
  } else
    level._effect["vfx_br_infil_cloud_anim"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_cloud_anim");
}

_id_5DF8C6ABD0B861CD() {
  if(!_id_B4E9D46918F067BB()) {
    return;
  }
  c130pathstruct = undefined;

  if(!istrue(level.br_infils_disabled) && !istrue(level._id_59FF09549058DDA2)) {
    if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("createC130PathStruct"))
      c130pathstruct = _id_362C58E8BB39BCDA::runbrgametypefunc("createC130PathStruct");
    else
      c130pathstruct = _id_45B2B4A889E633FA::createtestc130path();
  }

  level._id_A696A93807ABB2FD.c130pathstruct = c130pathstruct;
}

_id_F5C1889669D23A75() {
  if(!_id_B4E9D46918F067BB()) {
    return;
  }
  level.br_c130spawndone = 0;
  level.br_latejoininfilready = 0;

  if(!istrue(level.br_infils_disabled)) {
    setdvarifuninitialized("dvar_FC6EBBEB3426B854", 0);

    if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("infilSequence"))
      _id_362C58E8BB39BCDA::runbrgametypefunc("infilSequence");
    else {
      players = undefined;

      if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("getInfilPlayers"))
        players = _id_362C58E8BB39BCDA::runbrgametypefunc("getInfilPlayers");

      if(!getdvarint("dvar_FC6EBBEB3426B854", 0))
        beginbrc130playeraniminfilsequence(level._id_A696A93807ABB2FD.c130pathstruct, "player", players);
      else
        beginbrc130playeraniminfilsequence(level._id_A696A93807ABB2FD.c130pathstruct, "script_model");

      level thread _id_45B2B4A889E633FA::waittoplayinfildialog();
    }
  } else {
    scripts\mp\flags::gameflagset("prematch_fade_done");
    waitframe();
    level.allowprematchdamage = 0;
    players = undefined;

    if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("getInfilPlayers"))
      players = _id_362C58E8BB39BCDA::runbrgametypefunc("getInfilPlayers");

    if(!isDefined(players) || players.size > 0)
      waitforc130andforcespawnallplayers(players);

    foreach(player in level.players)
    player.plotarmor = undefined;

    scripts\mp\flags::gameflagset("br_ready_to_jump");
  }
}

latespawnplayer() {
  self endon("disconnect");

  if(!_id_B4E9D46918F067BB()) {
    return;
  }
  player = self;
  istutorial = _id_2CEDCC356F1B9FC8::istutorial() || _id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF();

  if(getDvar("dvar_215446C7A0657E95") != "" || istutorial)
    oldlatespawnplayer();
  else if(!isalive(player)) {
    _id_92A929921D302E13 = getdvarint("dvar_25AD2925D6075C8F", 0) == 2;
    _id_AFE7B88AB44F0601 = !istrue(level.br_c130spawndone) || !isDefined(level.latejoinersanimstruct);

    if(!_id_92A929921D302E13 && _id_AFE7B88AB44F0601) {
      _id_A2E7DF444A8AAFA9 = isbot(player) && _id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF();

      while(!istrue(level.br_latejoininfilready) && !_id_A2E7DF444A8AAFA9) {
        if(!_id_A2E7DF444A8AAFA9) {
          player _id_1E4A61DB11011446::_id_258C4F40DEE8189A();
          player setclientomnvar("ui_br_transition_type", 4);
        }

        wait 0.3;
      }

      player thread latespawnsnatchtoc130();
    } else {
      player.br_isininfil = 0;
      player.br_infilstarted = 1;
      _id_6ECC7CD453466014 = player _id_1E4A61DB11011446::_id_7DBB8165D792B06C();

      if(_id_92A929921D302E13 && isbot(player) && !_id_6ECC7CD453466014) {
        player.jumped = 1;
        player scripts\mp\playerlogic::addtoalivecount();
      }

      if(!_id_362C58E8BB39BCDA::isfeaturedisabled("squadLeader")) {
        _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(player.team, "players");

        if(!isDefined(_id_A6AB8D0FDA441DC2) || _id_A6AB8D0FDA441DC2.size == 0)
          _id_A6AB8D0FDA441DC2 = [self];

        _id_0930A1E7BD882C1D::setupbrsquadleader(_id_A6AB8D0FDA441DC2);
      }

      if(_id_6ECC7CD453466014)
        player thread scripts\mp\playerlogic::spawnplayer(undefined, 0);
      else
        player thread missedinfilplayerhandler();
    }
  } else {}

  player setclientomnvar("ui_br_transition_type", 0);
  player setclientomnvar("ui_br_extended_load_screen", 0);
}

oldlatespawnplayer() {
  self endon("disconnect");

  if(!_id_B4E9D46918F067BB()) {
    return;
  }
  player = self;

  if(!isalive(player))
    player scripts\mp\playerlogic::spawnplayer(0);

  if(!_id_362C58E8BB39BCDA::isfeaturedisabled("squadLeader")) {
    if(level.teambased) {
      _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(player.team, "players");

      if(!isDefined(_id_A6AB8D0FDA441DC2) || _id_A6AB8D0FDA441DC2.size == 0)
        _id_A6AB8D0FDA441DC2 = [self];

      _id_FC8439660D24B9C4 = _id_0930A1E7BD882C1D::setupbrsquadleader(_id_A6AB8D0FDA441DC2);

      if(isDefined(_id_FC8439660D24B9C4))
        _id_0930A1E7BD882C1D::registerbrsquadleaderjumpcommands(_id_FC8439660D24B9C4);
      else {}
    } else {
      player _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("jumpMasterState", 2);
      _id_0930A1E7BD882C1D::registerbrsquadleaderjumpcommands(player);
    }
  }

  player.br_infilstarted = 1;
}

latespawnsnatchtoc130() {
  player = self;
  player endon("disconnect");

  if(!isalive(player)) {
    player.latetoinfil = 1;
    player scripts\mp\playerlogic::spawnplayer(0);
  }

  player scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
  player scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("br_infils_legacy::lateSpawnSnatchToC130()");
  player.latetoinfil = undefined;
  player freezecontrols(1);

  if(player _id_2CEDCC356F1B9FC8::isplayerbrsquadleader())
    player.infilanimindex = 1;

  if(!isDefined(player.infilanimindex) && level.teambased) {
    _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(player.team, "players");
    _id_F5B09A636E6E3153 = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A6AB8D0FDA441DC2.size - 1; _id_AC0E594AC96AA3A8++)
      _id_F5B09A636E6E3153[_id_AC0E594AC96AA3A8] = _id_AC0E594AC96AA3A8 + 2;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F5B09A636E6E3153.size; _id_AC0E594AC96AA3A8++) {
      used = 0;

      foreach(_id_736D8D9188CCBD45 in _id_A6AB8D0FDA441DC2) {
        if(_id_736D8D9188CCBD45 != player && _id_736D8D9188CCBD45 _id_2CEDCC356F1B9FC8::isplayerbrsquadleader()) {
          continue;
        }
        if(isDefined(_id_736D8D9188CCBD45.infilanimindex) && isDefined(_id_F5B09A636E6E3153[_id_AC0E594AC96AA3A8]) && _id_736D8D9188CCBD45.infilanimindex == _id_F5B09A636E6E3153[_id_AC0E594AC96AA3A8]) {
          used = 1;
          break;
        }
      }

      if(!used) {
        player.infilanimindex = _id_F5B09A636E6E3153[_id_AC0E594AC96AA3A8];
        break;
      }
    }
  }

  player playerjoininfil();
  player playerlinktopositionent(level.latejoinersanimstruct);
  player.c130 = level.latejoinersanimstruct.movingc130;
  player setOrigin(level.latejoinersanimstruct.movingc130.origin);
  player playerplayinfilloopanim(level.latejoinersanimstruct);
  waitframe();

  if(isDefined(player.team) && level.teambased) {
    _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(player.team, "players");

    foreach(_id_6EE5484560EC747C in _id_A6AB8D0FDA441DC2) {
      player showtoplayer(_id_6EE5484560EC747C);
      _id_6EE5484560EC747C showtoplayer(player);
    }
  }

  if(!isbot(player))
    _id_45B2B4A889E633FA::orbitcam(level.br_ac130);

  wait 0.5;
  player freezecontrols(0);
  player setclientomnvar("ui_br_transition_type", 0);
  player.br_infilstarted = 1;
}

playerlinktopositionent(animstruct) {
  if(isai(self) && !istrue(self.hasspawned)) {
    return;
  }
  if(!isDefined(self.infilanimindex))
    self.infilanimindex = 1;

  _id_8E3AFD40D3C95B46 = "j_prop_" + self.infilanimindex;

  if(isent(animstruct.playerpositionents[_id_8E3AFD40D3C95B46]))
    self playerlinkTo(animstruct.playerpositionents[_id_8E3AFD40D3C95B46], "tag_player");
}

_id_35BE50043C0855AE() {
  return getdvarint("dvar_09CEA5B03E26FE23", 0);
}

playinfilplayeranims(animstruct, players) {
  _id_0E4C30D4C191BAAE = getanimlength(level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_redux_player1"]);

  if(_id_35BE50043C0855AE())
    _id_0E4C30D4C191BAAE = 0;

  _id_FA371B137DF55A75 = scripts\engine\utility::ter_op(isDefined(players), players, level.players);

  foreach(player in _id_FA371B137DF55A75) {
    if(!isDefined(player)) {
      continue;
    }
    player thread[[level.parachutetakeweaponscb]]();
    player _id_1E4A61DB11011446::playerexecutionsdisable();
    player.c130 = animstruct.movingc130;
    player.plotarmor = 1;
    player playerlinktopositionent(animstruct);
    _id_A1483D10035E2A59 = "sdr_mp_infil_ac130_redux_player" + player.infilanimindex;
    player playanimscriptsceneevent("scripted_scene", _id_A1483D10035E2A59);
  }

  wait(_id_0E4C30D4C191BAAE);
  _id_FA371B137DF55A75 = scripts\engine\utility::ter_op(isDefined(players), players, level.players);

  foreach(player in _id_FA371B137DF55A75) {
    if(!isDefined(player)) {
      continue;
    }
    player thread playerplayinfilloopanim(animstruct);
  }
}

playerplayinfilloopanim(animstruct) {
  if(!isDefined(self.infilanimindex))
    self.infilanimindex = 1;

  _id_A1483D10035E2A59 = "sdr_mp_infil_ac130_loop_pl0" + self.infilanimindex;
  self playanimscriptsceneevent("scripted_scene", _id_A1483D10035E2A59);
  thread watchinfiljumpanim(animstruct);
}

watchinfiljumpanim(animstruct) {
  self endon("death_or_disconnect");

  if(!isDefined(level.infiljumpentsspawned))
    level.infiljumpentsspawned = 0;

  self.hasspawnweapons = 0;
  self waittill("br_jump");
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(self.team, "players");
  _id_EF848FEB5C017E25 = [];

  if(self.jumptype == "leader") {
    foreach(player in _id_A6AB8D0FDA441DC2) {
      if(isDefined(player.infilanimindex))
        _id_EF848FEB5C017E25[_id_EF848FEB5C017E25.size] = player;
    }
  } else if(self.jumptype == "solo" || self.jumptype == "outOfBounds")
    _id_EF848FEB5C017E25 = [self];

  _id_BEE01CB211C7E185 = _id_EF848FEB5C017E25.size > 0;

  if(_id_BEE01CB211C7E185) {
    _id_A2117EA816A8B7F1 = getdvarint("dvar_8BE4ACC5EEBB19CA", 1) != 0;

    if(level.infiljumpentsspawned >= 100)
      _id_A2117EA816A8B7F1 = 0;

    _id_77B785278F139079 = undefined;

    if(_id_A2117EA816A8B7F1) {
      _id_77B785278F139079 = 0;
      [_id_8DEC95713EC1F7BA, _id_4D261EF98868B4E6, _id_66809387054FC02A] = getanimsforplanefacing(animstruct);
      _id_9B145EB55513DBB5["parent"] = spawn("script_model", animstruct.movingc130.origin);
      level.infiljumpentsspawned++;
      _id_9B145EB55513DBB5["parent"] setModel("generic_prop_x10");
      _id_9B145EB55513DBB5["parent"] linkTo(animstruct.movingc130, "tag_body", (0, 0, 0), (0, 0, 0));

      foreach(player in _id_EF848FEB5C017E25) {
        if(!isDefined(player.infilanimindex))
          player.infilanimindex = 1;

        _id_8E3AFD40D3C95B46 = "j_prop_" + (player.infilanimindex + 2);
        _id_9B145EB55513DBB5[_id_8E3AFD40D3C95B46] = spawn("script_model", _id_9B145EB55513DBB5["parent"] gettagorigin(_id_8E3AFD40D3C95B46));
        level.infiljumpentsspawned++;
        _id_9B145EB55513DBB5[_id_8E3AFD40D3C95B46] setModel("tag_player");
        _id_9B145EB55513DBB5[_id_8E3AFD40D3C95B46] linkTo(_id_9B145EB55513DBB5["parent"], _id_8E3AFD40D3C95B46, (0, 0, 0), (0, 0, 0));
        player playerlinkTo(_id_9B145EB55513DBB5[_id_8E3AFD40D3C95B46], "tag_player");
        player scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76(1);
        player playanimscriptsceneevent("scripted_scene", _id_66809387054FC02A);
        player.infilanimindex = undefined;
        player._id_DB122A8941DFEE14 = undefined;
        player playlocalsound("evt_br_infil_jump_stinger");
        level thread playjumpsoundtosquad(player);
      }

      _id_9B145EB55513DBB5["parent"] scriptmodelplayanim(_id_8DEC95713EC1F7BA, "prop");
      _id_7A79E5C326955318 = getanimlength(_id_4D261EF98868B4E6);
      _id_886F7978500ACB10 = 1.0;
      _id_7A79E5C326955318 = max(_id_7A79E5C326955318, _id_886F7978500ACB10 + 0.1);
      wait(_id_7A79E5C326955318 - _id_886F7978500ACB10);

      foreach(player in _id_EF848FEB5C017E25)
      player cameradefault();

      wait(_id_886F7978500ACB10);

      foreach(ent in _id_9B145EB55513DBB5) {
        ent delete();
        level.infiljumpentsspawned--;
      }
    } else {
      _id_77B785278F139079 = 1;
      waittillframeend;
    }

    foreach(player in _id_EF848FEB5C017E25) {
      player.infilanimindex = undefined;
      player._id_DB122A8941DFEE14 = undefined;
      player stopanimscriptsceneevent();
      player notify("infil_jump_done");
      player _id_1E4A61DB11011446::playerexecutionsenable();
      player _id_362C58E8BB39BCDA::runbrgametypefunc("onInfilJumpCompleted");
    }

    if(_id_77B785278F139079) {
      waitframe();

      if(isDefined(animstruct.movingc130)) {
        if(isDefined(animstruct.movingc130.playeroffsets) && isDefined(animstruct.movingc130.currentplayeroffset)) {
          foreach(player in _id_EF848FEB5C017E25) {
            offset = animstruct.movingc130.playeroffsets[animstruct.movingc130.currentplayeroffset];
            player setOrigin(animstruct.movingc130.origin + offset, 1, 1);
            animstruct.movingc130.currentplayeroffset++;

            if(animstruct.movingc130.currentplayeroffset == animstruct.movingc130.playeroffsets.size)
              animstruct.movingc130.currentplayeroffset = 0;

            player scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76(1);
            level thread playjumpsoundtosquad(player);
          }
        }
      }
    }
  }
}

getanimsforplanefacing(animstruct) {
  _id_522A77434D41564A = self getplayerangles(1);
  _id_20AF753DED3657E1 = anglesToForward(_id_522A77434D41564A);
  _id_4B52F031A2CBEF8E = anglesToForward(animstruct.movingc130.angles);
  _id_D8BB89F41AE3D919 = anglestoright(animstruct.movingc130.angles);
  _id_172D42D175E16C61 = vectordot(_id_20AF753DED3657E1, _id_4B52F031A2CBEF8E);
  _id_ED451F0EA36C48C6 = vectordot(_id_20AF753DED3657E1, _id_D8BB89F41AE3D919);
  _id_C29AC1B887131D03 = cos(45.0);

  if(_id_172D42D175E16C61 < -1.0 * _id_C29AC1B887131D03)
    return ["sdr_mp_infil_ac130_jump_genpropx10", level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_jump_genpropx10"], "sdr_mp_infil_ac130_jump"];

  if(_id_ED451F0EA36C48C6 > _id_C29AC1B887131D03)
    return ["sdr_mp_infil_ac130_jump_genpropx10_90_l", level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_jump_genpropx10_90_l"], "sdr_mp_infil_ac130_jump_90_l"];
  else if(_id_ED451F0EA36C48C6 < -1.0 * _id_C29AC1B887131D03)
    return ["sdr_mp_infil_ac130_jump_genpropx10_90_r", level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_jump_genpropx10_90_r"], "sdr_mp_infil_ac130_jump_90_r"];
  else if(_id_ED451F0EA36C48C6 > 0.0)
    return ["sdr_mp_infil_ac130_jump_genpropx10_180_l", level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_jump_genpropx10_180_l"], "sdr_mp_infil_ac130_jump_180_l"];
  else
    return ["sdr_mp_infil_ac130_jump_genpropx10_180_r", level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_jump_genpropx10_180_r"], "sdr_mp_infil_ac130_jump_180_r"];
}

playjumpsoundtosquad(player) {
  aliasname = "evt_br_infil_squadmate_jump";

  if(player _id_2CEDCC356F1B9FC8::isplayerbrsquadleader())
    aliasname = "evt_br_infil_squad_leader_jump";

  player playsoundtoteam(aliasname, player.team, player);
}

missedinfilplayerhandler() {
  player = self;
  player.br_infilstarted = 1;
  player _id_7E52B56769FA7774::addrespawntoken(1);
  player _id_67708F418B1FAC79::playergulagautowin("missedInfil", undefined, undefined, 1);

  if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
    self notify("br_jump");
}

playerjoininfil() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("joining_Infil");
  player = self;
  player.br_infilstarted = 1;

  if(!istrue(level.c130inbounds))
    self setclientomnvar("ui_hide_minimap", 1);

  player.health = player.maxhealth;
  player _id_45B2B4A889E633FA::spawnplayertoc130();
  player playersetupcontrolsforinfil();
  player _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("isInInfilPlane", 1);
  level.infilstruct.playersinc130++;
  player _id_2CEDCC356F1B9FC8::_id_64FA4C213439177F();
  player thread playercleanupinfilondisconnect();
}

playersetupcontrolsforinfil(_id_A19E18E7CC768828) {
  if(!isDefined(_id_A19E18E7CC768828))
    _id_A19E18E7CC768828 = 0;

  self setclientomnvar("ui_br_infil_started", 1);
  self setclientomnvar("ui_br_infiled", 0);

  if(!_id_A19E18E7CC768828)
    self notifyonplayercommand("halo_jump_c130", "+gostand");
  else
    self notifyonplayercommand("halo_jump_solo_c130", "+gostand");

  self notifyonplayercommand("br_pass_squad_leader", "+usereload");
  self notifyonplayercommand("br_pass_squad_leader", "+activate");
}

playercleanupinfilondisconnect() {
  level endon("game_ended");
  self endon("death");
  self endon("cancel_c130");
  self endon("br_jump");
  self waittill("disconnect");

  if(isDefined(level.infilstruct) && isDefined(level.infilstruct.playersinc130) && level.infilstruct.playersinc130 > 0)
    level.infilstruct.playersinc130--;
}

beginbrc130playeraniminfilsequence(c130pathstruct, infil_anim_type, players) {
  _id_FA371B137DF55A75 = scripts\engine\utility::ter_op(isDefined(players), players, level.players);

  foreach(player in _id_FA371B137DF55A75) {
    if(!isDefined(player)) {
      continue;
    }
    player setallstreamloaddist(-1.0);
  }

  level.infilstruct = spawnStruct();
  level.infilstruct.playersinc130 = 0;

  if(!isDefined(c130pathstruct))
    c130pathstruct = _id_45B2B4A889E633FA::createtestc130path();

  level.infilstruct.c130pathstruct = c130pathstruct;
  _id_45B2B4A889E633FA::spawnc130(undefined, undefined, undefined, level.infilstruct.c130pathstruct);
  animstruct = buildac130infilanimstruct(level.br_ac130, infil_anim_type);
  level.latejoinersanimstruct = animstruct;
  infilvideopreload(players);

  if(isDefined(level.preinfilstreamfunc))
    [[level.preinfilstreamfunc]](animstruct);

  level.infilcinematicactive = 1;
  level.allowprematchdamage = 0;
  level.br_ac130 thread gunship_updateplayercount();
  _id_FA371B137DF55A75 = scripts\engine\utility::ter_op(isDefined(players), players, level.players);
  transitionplayerstoac130cinematic(_id_FA371B137DF55A75, infil_anim_type, animstruct.staticc130);

  if(_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF() || _id_2CEDCC356F1B9FC8::isdmzbotpracticematch()) {
    _id_FA371B137DF55A75 = scripts\engine\utility::ter_op(isDefined(players), players, level.players);

    foreach(player in _id_FA371B137DF55A75) {
      if(isDefined(player) && isPlayer(player))
        player notify("play_intro");
    }
  }

  infilvideoplay(players);
  infilvideowaituntilcomplete(players);
  level thread infilallfadetoblack(0.0, 3.45, 0.6, undefined, players);
  playac130infilanim(animstruct, players);
  _id_FA371B137DF55A75 = scripts\engine\utility::ter_op(isDefined(players), players, level.players);
  transitionplayersoutofac130cinematic(_id_FA371B137DF55A75, infil_anim_type);
  level.infilcinematicactive = 0;
  level.infilstruct.infil_anim_type = infil_anim_type;
  thread _id_362C58E8BB39BCDA::runbrgametypefunc("onInfilSequenceEnd", players);
  _id_2CEDCC356F1B9FC8::brleaderdialog("match_start", 0, players, undefined, undefined, undefined, level.brgametype._id_B09B7AFE082A9239);
  istutorial = _id_2CEDCC356F1B9FC8::istutorial() || _id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF();

  if(!istutorial) {
    _id_CB130A107612FDDF = getDvar("dvar_215446C7A0657E95") == "";
    _id_FA371B137DF55A75 = scripts\engine\utility::ter_op(isDefined(players), players, level.players);

    foreach(player in _id_FA371B137DF55A75) {
      if(!isDefined(player)) {
        continue;
      }
      if(!istrue(player.br_isininfil) && _id_CB130A107612FDDF) {
        continue;
      }
      player thread playerjoininfil();

      if(player isplayerheadless())
        registerheadlessinfil(player);
    }

    if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("addToC130Infil"))
      level.br_ac130 _id_362C58E8BB39BCDA::runbrgametypefunc("addToC130Infil");
  }

  if(isDefined(level.headlessinfilplayers))
    level thread headlessinfils();
}

infilvideopreload(players) {
  _id_4F105563CA74CF73 = "mp_donetsk_c130_intro";

  if(!isDefined(players))
    preloadcinematicforall(_id_4F105563CA74CF73);
  else {
    foreach(player in players) {
      if(isDefined(player))
        player preloadcinematicforplayer(_id_4F105563CA74CF73);
    }
  }
}

_id_F94830AC89CBE22C(waittime) {
  wait(waittime);
  self stopsounds();
}

infilvideoplay(players) {
  _id_FA371B137DF55A75 = scripts\engine\utility::ter_op(isDefined(players), players, level.players);
  _id_5C882C8F7BB9C72A = level.players.size == _id_FA371B137DF55A75.size;
  thread scripts\mp\music_and_dialog::stopsuspensemusic();

  if(_id_5C882C8F7BB9C72A)
    setglobalsoundcontext("lobby_fade", "", 2);

  foreach(player in _id_FA371B137DF55A75) {
    if(!isDefined(player)) {
      continue;
    }
    if(!_id_5C882C8F7BB9C72A)
      player setentitysoundcontext("lobby_fade", "", 2);

    player playlocalsound("br_infil_part1_lr");

    if(_id_35BE50043C0855AE())
      player thread _id_F94830AC89CBE22C(7);

    player clearsoundsubmix("mp_br_lobby_fade", 1.5);
    player setsoundsubmix("solo_cin_igc_music", 0.5);
    _id_D788FBB04A7A099D = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_infil_intro");
    player setplayermusicstate(_id_D788FBB04A7A099D);
  }

  _id_4F105563CA74CF73 = "mp_donetsk_c130_intro";

  if(_id_5C882C8F7BB9C72A)
    playcinematicforall(_id_4F105563CA74CF73);
  else {
    foreach(player in _id_FA371B137DF55A75) {
      if(!isDefined(player)) {
        continue;
      }
      player playcinematicforplayer(_id_4F105563CA74CF73);
    }
  }

  foreach(player in _id_FA371B137DF55A75) {
    if(!isDefined(player)) {
      continue;
    }
    if(!istrue(player.latetoinfil))
      player setclientomnvar("ui_br_bink_overlay_state", 3);
  }
}

infilvideocompletecallback(_id_7148C1A6F25491F8, val) {
  if(_id_7148C1A6F25491F8 == "bink_complete") {
    self setclientomnvar("ui_br_bink_overlay_state", 0);
    self stopcinematicforplayer();
  }
}

infilvideowaituntilcomplete(players) {
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::infilvideocompletecallback);
  time = 3.2;
  wait(time);
  _id_FA371B137DF55A75 = scripts\engine\utility::ter_op(isDefined(players), players, level.players);

  if(isDefined(level._id_9D615A366EC2FB6F))
    level._id_9D615A366EC2FB6F = undefined;

  foreach(player in _id_FA371B137DF55A75) {
    if(!isDefined(player)) {
      continue;
    }
    player notify("beginC130");
  }

  if(isDefined(level.throwingknives)) {
    foreach(throwingknife in level.throwingknives) {
      if(isDefined(throwingknife))
        throwingknife thread scripts\cp_mp\equipment\throwing_knife::throwing_knife_deletepickup();
    }
  }
}

gunship_updateplayercount() {
  level endon("game_ended");
  self notify("ac130_player_count");
  self endon("ac130_player_count");
  _id_512E1C239C8F0640 = getdvarint("dvar_57377F405B99ECD2", 0);

  if(_id_512E1C239C8F0640) {
    level.infilstruct._id_129D4A6C887FCFA5 = level.players.size;

    if(isDefined(level._id_7B37B2193F163B9B) && isDefined(level._id_7B37B2193F163B9B._id_156F390A5362BC55))
      level.infilstruct._id_129D4A6C887FCFA5 = level.infilstruct._id_129D4A6C887FCFA5 + level._id_7B37B2193F163B9B._id_156F390A5362BC55.size;
  }

  for(;;) {
    if(_id_512E1C239C8F0640)
      setomnvar("ui_br_players_left_in_plane", level.infilstruct._id_129D4A6C887FCFA5);
    else
      setomnvar("ui_br_players_left_in_plane", level.infilstruct.playersinc130);

    if(!isDefined(self)) {
      break;
    }

    wait 0.5;
  }
}

spawnplayerpositionparentent(animstruct, ac130) {
  animstruct.playerpositionents["parent"] = spawn("script_model", ac130.origin);
  animstruct.playerpositionents["parent"] setModel("generic_prop_x5");
  animstruct.playerpositionents["parent"] linkTo(ac130, "", (0, 0, 0), (0, 0, 0));
}

spawnplayerpositionent(animstruct, _id_3E904658641F342F) {
  animstruct.playerpositionents[_id_3E904658641F342F] = spawn("script_model", animstruct.playerpositionents["parent"] gettagorigin(_id_3E904658641F342F));
  animstruct.playerpositionents[_id_3E904658641F342F] setModel("tag_player");
  animstruct.playerpositionents[_id_3E904658641F342F] linkTo(animstruct.playerpositionents["parent"], _id_3E904658641F342F, (0, 0, 0), (0, 0, 0));
}

buildac130infilanimstruct(movingc130, infil_anim_type) {
  animstruct = spawnStruct();

  if(isDefined(movingc130)) {
    movingc130.animstruct = animstruct;
    animstruct.movingc130 = movingc130;
  }

  animstruct.staticc130 = getEnt("infil_plane", "script_noteworthy");

  if(isDefined(animstruct.staticc130))
    animstruct.staticc130 show();
  else {
    animstruct.staticc130 = spawn("script_model", getdvarvector("br_infil_anim_pos", (0, 0, 0)));
    animstruct.staticc130 setModel("veh8_mil_air_acharlie130_magma_animated");
    animstruct.staticc130.cleanme = 1;
  }

  animstruct.cameraent = spawn("script_model", animstruct.staticc130.origin);
  animstruct.cameraent setModel("generic_prop_x5");

  if(isDefined(movingc130)) {
    animstruct.cameraentmoving = spawn("script_model", animstruct.movingc130.origin);
    animstruct.cameraentmoving setModel("generic_prop_x5");
    animstruct.cameraentmoving linkTo(animstruct.movingc130, "tag_origin", (0, 0, 0), (0, 0, 0));
    animstruct.cameraentmoving forcenetfieldhighlod(1);
  }

  spawnplayerpositionparentent(animstruct, animstruct.staticc130);

  if(infil_anim_type == "script_model") {
    animstruct.playerslot1 = spawn("script_model", animstruct.staticc130.origin);
    animstruct.playerslot1 setModel("fullbody_usmc_ar_br_infil");
    animstruct.playerslot2 = spawn("script_model", animstruct.staticc130.origin);
    animstruct.playerslot2 setModel("fullbody_usmc_ar_br_infil");
    animstruct.playerslot3 = spawn("script_model", animstruct.staticc130.origin);
    animstruct.playerslot3 setModel("fullbody_usmc_ar_br_infil");
    animstruct.playerslot4 = spawn("script_model", animstruct.staticc130.origin);
    animstruct.playerslot4 setModel("fullbody_usmc_ar_br_infil");
    animstruct.playerslot1 linkTo(animstruct.playerpositionents["parent"], "j_prop_1", (0, 0, 0), (0, 0, 0));
    animstruct.playerslot2 linkTo(animstruct.playerpositionents["parent"], "j_prop_2", (0, 0, 0), (0, 0, 0));
    animstruct.playerslot3 linkTo(animstruct.playerpositionents["parent"], "j_prop_3", (0, 0, 0), (0, 0, 0));
    animstruct.playerslot4 linkTo(animstruct.playerpositionents["parent"], "j_prop_4", (0, 0, 0), (0, 0, 0));
    animstruct.infil_anim_type = "script_model";
  } else {
    _id_589033938EFC0461 = ["j_prop_1", "j_prop_2", "j_prop_3", "j_prop_4"];

    foreach(_id_3E904658641F342F in _id_589033938EFC0461)
    spawnplayerpositionent(animstruct, _id_3E904658641F342F);

    animstruct.infil_anim_type = "player";
  }

  if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73()) {
    animstruct.aidoorchief = spawn("script_model", animstruct.staticc130.origin);
    animstruct.aidoorchief setModel("body_mp_western_otter_3_1_lod1");
    head = spawn("script_model", animstruct.aidoorchief gettagorigin("j_neck"));
    head setModel("head_mp_eastern_metalghost_1_1");
    head linkTo(animstruct.aidoorchief, "j_neck", (-9, 1, 0), (0, 0, 0));
  } else {
    animstruct.aidoorchief = spawn("script_model", animstruct.staticc130.origin);
    animstruct.aidoorchief setModel("fullbody_usmc_ar_br_infil");
  }

  if(isDefined(movingc130))
    animstruct.movingc130.innards linkTo(animstruct.movingc130, "", (0, 0, 0), (0, 0, 0));

  animstruct.aidoorchief linkTo(animstruct.playerpositionents["parent"], "j_prop_5", (0, 0, 0), (0, 0, 0));
  animstruct.cameraent linkTo(animstruct.staticc130, "", (0, 0, 0), (0, 0, 0));
  animstruct.cloudanimfx = spawnfx(level._effect["vfx_br_infil_cloud_anim"], animstruct.staticc130.origin);

  if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
    animstruct._id_352D21900A2AA86F = spawnfx(level._effect["vfx_br_infil_cloud_anim_moving"], animstruct.movingc130.origin + (-500, 0, 0));

  return animstruct;
}

setuphudelemninfilblack(_id_94480E1669B7FF0D) {
  _id_94480E1669B7FF0D.x = 0;
  _id_94480E1669B7FF0D.y = 0;
  _id_94480E1669B7FF0D setshader("black", 640, 480);
  _id_94480E1669B7FF0D.alignx = "left";
  _id_94480E1669B7FF0D.aligny = "top";
  _id_94480E1669B7FF0D.horzalign = "fullscreen";
  _id_94480E1669B7FF0D.vertalign = "fullscreen";
  _id_94480E1669B7FF0D.sort = -1;
  _id_94480E1669B7FF0D setshowinrealism(1);
}

infilallfadetoblack(_id_EE006CF398BCD8FD, _id_E4AB5EF161C5FFCB, _id_C8FE6E3CA9715960, _id_BFD3CEC846E4FBF7, players, _id_69618EB692FC8288) {
  if(!isDefined(_id_69618EB692FC8288))
    _id_69618EB692FC8288 = 0;

  _id_FA371B137DF55A75 = scripts\engine\utility::ter_op(isDefined(players), players, level.players);
  _id_5C882C8F7BB9C72A = level.players.size == _id_FA371B137DF55A75.size;

  if(_id_5C882C8F7BB9C72A && !isDefined(level.infilblackoverlay)) {
    level.infilblackoverlay = newhudelem();
    setuphudelemninfilblack(level.infilblackoverlay);
  } else if(!_id_5C882C8F7BB9C72A) {
    foreach(player in _id_FA371B137DF55A75) {
      if(!isDefined(player)) {
        continue;
      }
      player.infilblackoverlay = newclienthudelem(player);
      setuphudelemninfilblack(player.infilblackoverlay);
    }
  }

  if(isDefined(_id_EE006CF398BCD8FD) && _id_EE006CF398BCD8FD > 0) {
    _id_FA371B137DF55A75 = scripts\engine\utility::ter_op(isDefined(players), players, level.players);

    foreach(player in _id_FA371B137DF55A75) {
      if(!isDefined(player)) {
        continue;
      }
      if(!_id_69618EB692FC8288) {
        player setsoundsubmix("iw8_br_infil_fadeout", 0.0);
        player setsoundsubmix("mp_br_infil_music", 0.0);
      }

      if(!_id_5C882C8F7BB9C72A) {
        player.infilblackoverlay.alpha = 0;
        player.infilblackoverlay fadeovertime(_id_EE006CF398BCD8FD);
        player.infilblackoverlay.alpha = 1;
      }
    }

    if(_id_5C882C8F7BB9C72A) {
      level.infilblackoverlay.alpha = 0;
      level.infilblackoverlay fadeovertime(_id_C8FE6E3CA9715960);
      level.infilblackoverlay.alpha = 1;
    }

    wait(_id_EE006CF398BCD8FD);
  }

  if(_id_5C882C8F7BB9C72A)
    level.infilblackoverlay.alpha = 1;

  _id_FA371B137DF55A75 = scripts\engine\utility::ter_op(isDefined(players), players, level.players);

  foreach(player in _id_FA371B137DF55A75) {
    if(!isDefined(player)) {
      continue;
    }
    if(!_id_69618EB692FC8288) {
      player setsoundsubmix("mp_br_infil_anim", 0.0);
      player setsoundsubmix("mp_br_infil_ac130", 0.0);
    }

    if(!_id_5C882C8F7BB9C72A)
      player.infilblackoverlay.alpha = 1;
  }

  if(isDefined(_id_BFD3CEC846E4FBF7))
    level waittill(_id_BFD3CEC846E4FBF7);

  if(isDefined(_id_E4AB5EF161C5FFCB) && _id_E4AB5EF161C5FFCB > 0)
    wait(_id_E4AB5EF161C5FFCB);

  if(isDefined(_id_C8FE6E3CA9715960) && _id_C8FE6E3CA9715960 > 0) {
    if(_id_5C882C8F7BB9C72A) {
      level.infilblackoverlay.alpha = 1;
      level.infilblackoverlay fadeovertime(_id_C8FE6E3CA9715960);
      level.infilblackoverlay.alpha = 0;
    }

    _id_FA371B137DF55A75 = scripts\engine\utility::ter_op(isDefined(players), players, level.players);

    foreach(player in _id_FA371B137DF55A75) {
      if(!isDefined(player)) {
        continue;
      }
      if(!_id_69618EB692FC8288) {
        player setclienttriggeraudiozone("mp_br_c130_infil_int", _id_C8FE6E3CA9715960);
        player clearsoundsubmix("iw8_br_infil_fadeout", 2);
        player notify("deaths_door_exit");
        player clearsoundsubmix("deaths_door_mp");
      }

      if(!_id_5C882C8F7BB9C72A) {
        player.infilblackoverlay.alpha = 1;
        player.infilblackoverlay fadeovertime(_id_C8FE6E3CA9715960);
        player.infilblackoverlay.alpha = 0;
      }
    }

    wait(_id_C8FE6E3CA9715960);
  }

  if(_id_5C882C8F7BB9C72A)
    level.infilblackoverlay.alpha = 0;
  else {
    _id_FA371B137DF55A75 = scripts\engine\utility::ter_op(isDefined(players), players, level.players);

    foreach(player in _id_FA371B137DF55A75) {
      if(!isDefined(player)) {
        continue;
      }
      if(isDefined(player.infilblackoverlay))
        player.infilblackoverlay destroy();

      player.infilblackoverlay = undefined;
    }
  }
}

transitionplayerstoac130cinematic(players, infil_anim_type, c130) {
  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    if(isDefined(c130))
      player.c130 = level.br_ac130;

    if(!scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
      player scripts\mp\utility\player::hidehudenable();
  }

  scripts\mp\deathicons::removealldeathicons();
  setomnvar("ui_hide_player_icons", 1);
  thread infilallfadetoblack(1, 1.5, 1, "prematch_respawn_finished", players);

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    player _meth_BC667001F9DD3808(c130.origin);
  }

  level.infiltransistioning = 1;
  _id_0930A1E7BD882C1D::waitandpause(1);
  waitframe();
  _id_46AF76764B1FC7F0::emptyallvehicles();
  setomnvar("ui_in_infil", 1);
  scripts\mp\flags::gameflagset("prematch_fade_done");
  waitforc130andforcespawnallplayers(players);
  level notify("prematch_respawn_finished");

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    if(!isDefined(player.sessionstate) || player.sessionstate == "spectator") {
      continue;
    }
    _id_362C58E8BB39BCDA::_id_D72AFACCEDFC946E("onPlayerTeleport", player, player.origin, c130.origin, "c130");
    player setOrigin(c130.origin);

    if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
      player setclientomnvar("ui_options_menu", 0);
  }

  _id_0930A1E7BD882C1D::waitandpause(1.5);

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    player clearpredictedstreampos();
    player _id_0930A1E7BD882C1D::endprematchskydiving();
    player.br_isininfil = 1;

    if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
      player setclientomnvar("ui_options_menu", -1);
  }

  if(infil_anim_type == "script_model") {
    foreach(player in players) {
      if(!isDefined(player)) {
        continue;
      }
      player scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
      player scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("br_infils_legacy::transitionPlayersToAC130Cinematic()");
    }
  }
}

waitforc130andforcespawnallplayers(players) {
  _id_FA371B137DF55A75 = scripts\engine\utility::ter_op(isDefined(players), players, level.players);

  foreach(player in _id_FA371B137DF55A75) {
    if(!isDefined(player)) {
      continue;
    }
    player _id_0930A1E7BD882C1D::endprematchskydiving();

    if(!isalive(player))
      player c130forcespawnplayer();
    else
      player.br_infilstarted = 1;

    if(!isDefined(player)) {
      continue;
    }
    if(istrue(player.br_iseliminated))
      _id_0A34750D17473C49::unmarkplayeraseliminated(player);

    player notify("beginC130");
  }

  if(!_id_362C58E8BB39BCDA::isfeaturedisabled("squadLeader")) {
    if(level.teambased) {
      foreach(team in level.teamnamelist) {
        _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(team, "players");
        _id_FC8439660D24B9C4 = _id_0930A1E7BD882C1D::setupbrsquadleader(_id_A6AB8D0FDA441DC2);

        if(isDefined(_id_FC8439660D24B9C4)) {
          _id_0930A1E7BD882C1D::registerbrsquadleaderjumpcommands(_id_FC8439660D24B9C4);
          _id_FC8439660D24B9C4 thread _id_0930A1E7BD882C1D::watchbrsquadleaderdisconnect(team);
        }

        _id_1E4A61DB11011446::updatesquadleaderpassstateforteam(team);
      }
    } else {
      _id_FA371B137DF55A75 = scripts\engine\utility::ter_op(isDefined(players), players, level.players);

      foreach(player in _id_FA371B137DF55A75) {
        if(isDefined(player))
          _id_0930A1E7BD882C1D::registerbrsquadleaderjumpcommands(player);
      }
    }
  }

  if(!_id_362C58E8BB39BCDA::isfeaturedisabled("oneLife")) {
    level.disablespawning = 1;
    setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_numLives"), 1);
  }

  level.snatchspawnalltoc130done = 1;
}

c130forcespawnplayer() {
  self endon("disconnect");

  if(self.team == "codcaster") {
    return;
  }
  if(self.class == "") {
    self.class = "custom1";
    self.pers["class"] = "custom1";
  }

  scripts\mp\playerlogic::spawnplayer(0);
  self.br_infilstarted = 1;
  self notify("brWaitAndSpawnClientComplete");
  self setclientomnvar("ui_br_transition_type", 0);
  self setclientomnvar("ui_br_extended_load_screen", 0);
}

transitionplayersoutofac130cinematic(players, infil_anim_type) {
  _id_505A6D9B4EB5D4F3 = infil_anim_type == "script_model";

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    player.instantclassswapallowed = 1;

    if(_id_1E4A61DB11011446::get_int_or_0(player.hidehudenabled) > 0)
      player scripts\mp\utility\player::hidehuddisable();

    player visionsetfadetoblackforplayer("", 1.0);

    if(_id_505A6D9B4EB5D4F3) {
      player scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76();
      player scripts\cp_mp\utility\player_utility::_id_985B0973F29DA4F8("br_infils_legacy::transitionPlayersOutOfAC130Cinematic()");
    }
  }

  setomnvar("ui_in_infil", -1);
  level.infiltransistioning = undefined;
}

clearsoundsubmixmpbrinfilac130(players) {
  _id_0930A1E7BD882C1D::waitandpause(7.7);
  _id_FA371B137DF55A75 = scripts\engine\utility::ter_op(isDefined(players), players, level.players);

  foreach(player in _id_FA371B137DF55A75) {
    if(!isDefined(player)) {
      continue;
    }
    player clearsoundsubmix("mp_br_infil_ac130", 30.0);
  }
}

clearsoundsubmixmpbrinfilanim(players) {
  _id_0930A1E7BD882C1D::waitandpause(0.65);
  _id_FA371B137DF55A75 = scripts\engine\utility::ter_op(isDefined(players), players, level.players);

  foreach(player in _id_FA371B137DF55A75) {
    if(!isDefined(player)) {
      continue;
    }
    player clearsoundsubmix("mp_br_infil_anim", 3.0);
  }
}

clearsoundsubmixfadetoblackamb(players) {
  _id_0930A1E7BD882C1D::waitandpause(0.5);
  _id_FA371B137DF55A75 = scripts\engine\utility::ter_op(isDefined(players), players, level.players);

  foreach(player in _id_FA371B137DF55A75) {
    if(!isDefined(player)) {
      continue;
    }
    player clearsoundsubmix("fade_to_black_all_except_music_scripted5_and_amb", 1.0);
  }
}

setsoundsubmixfadetoblackamb(players) {
  _id_0930A1E7BD882C1D::waitandpause(2.0);
  _id_FA371B137DF55A75 = scripts\engine\utility::ter_op(isDefined(players), players, level.players);

  foreach(player in _id_FA371B137DF55A75) {
    if(!isDefined(player)) {
      continue;
    }
    player clearsoundsubmix("solo_cin_igc_music", 0.5);
    player setsoundsubmix("fade_to_black_all_except_music_scripted5_and_amb", 2.0);
  }
}

playac130infilanim(animstruct, players) {
  thread setsoundsubmixfadetoblackamb(players);
  playac130animinternal(animstruct, players);
  transitionac130tomovinganim(animstruct, players);
  endac130infilanimsinternal(animstruct, players);
}

playac130animinternal(animstruct, players) {
  animstruct endon("stopScene");
  _id_384446A35F40358C = undefined;

  if(animstruct.infil_anim_type == "player") {
    if(!isDefined(players)) {
      foreach(team in level.teamnamelist) {
        _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(team, "players");
        _id_F5B09A636E6E3153 = [1, 2, 3, 4];

        foreach(index, player in _id_A6AB8D0FDA441DC2) {
          player scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
          player scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("br_infils_legacy::playAC130AnimInternal() - if");
          player.infilanimindex = _id_F5B09A636E6E3153[index % _id_F5B09A636E6E3153.size];

          foreach(_id_6EE5484560EC747C in _id_A6AB8D0FDA441DC2)
          player showtoplayer(_id_6EE5484560EC747C);
        }
      }
    } else {
      foreach(player in players) {
        if(!isDefined(player)) {
          continue;
        }
        player scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
        player scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("br_infils_legacy::playAC130AnimInternal() - else");
        player showtoplayer(player);
        player.infilanimindex = 1;
      }
    }
  } else {}

  _id_E74DA054403180A2 = 34;
  _id_5EEA6039C4F26FDF = 5.6;
  _id_108437A9E3168337 = 50.7;
  _id_63916E6C46C30B92 = 2.0;
  _id_5004850B0EC526A1 = 4;
  _id_E05B28669275A9EB = scripts\engine\utility::ter_op(_id_35BE50043C0855AE(), 12.5, 0);
  animstruct.cameraent scriptmodelplayanim("sdr_mp_infil_ac130_redux_players_cam", "camera", _id_E05B28669275A9EB);

  if(isDefined(animstruct.cameraentmoving))
    animstruct.cameraentmoving scriptmodelplayanim("sdr_mp_infil_ac130_redux_players_cam", "camera", _id_E05B28669275A9EB);

  if(isDefined(animstruct.movingc130))
    animstruct.movingc130 stoploopsound();

  animstruct.aidoorchief hide();
  _id_FA371B137DF55A75 = scripts\engine\utility::ter_op(isDefined(players), players, level.players);

  foreach(player in _id_FA371B137DF55A75) {
    if(!isDefined(player)) {
      continue;
    }
    player setsoundsubmix("mp_br_infil_anim", 0.0);
    player setsoundsubmix("mp_br_infil_music", 0.0);
    player setsoundsubmix("mp_br_infil_ac130", 0.0);
    player setclienttriggeraudiozone("mp_br_c130_infil_int", 1.0);
    animstruct.cameraentlinktag = "j_prop_" + player.infilanimindex;
    player cameraunlink();
    player cameralinkTo(animstruct.cameraent, animstruct.cameraentlinktag, 1, 1);
    player setclientdvar("cg_fov", _id_E74DA054403180A2);
    player enablephysicaldepthoffieldscripting();
    player setphysicaldepthoffield(_id_5EEA6039C4F26FDF, _id_108437A9E3168337, _id_63916E6C46C30B92, _id_5004850B0EC526A1);
    player scripts\mp\utility\player::_freezelookcontrols(1);
    animstruct.aidoorchief showtoplayer(player);
  }

  thread clearsoundsubmixmpbrinfilanim(players);
  thread getlightingvalues();
  playFXOnTag(level._effect["vfx_br_ac130_clouds"], animstruct.staticc130, "tag_body");
  animstruct.staticc130 scriptmodelplayanim("sdr_mp_infil_ac130_redux_players_ac130", "plane");

  if(isDefined(animstruct.movingc130)) {
    animstruct.movingc130 scriptmodelplayanim("sdr_mp_infil_ac130_redux_players_ac130", "plane");
    animstruct.movingc130.innards scriptmodelplayanim("sdr_mp_infil_ac130_redux_players_ac130", "planeInnards");
  }

  animstruct.playerpositionents["parent"] scriptmodelplayanim("sdr_mp_infil_ac130_redux_character_link", "prop");

  if(animstruct.infil_anim_type == "script_model") {
    animstruct.playerslot1 scriptmodelplayanim("sdr_mp_infil_ac130_redux_player1", "p1");
    animstruct.playerslot2 scriptmodelplayanim("sdr_mp_infil_ac130_redux_player2", "p2");
    animstruct.playerslot3 scriptmodelplayanim("sdr_mp_infil_ac130_redux_player3", "p3");
    animstruct.playerslot4 scriptmodelplayanim("sdr_mp_infil_ac130_redux_player4", "p4");
  } else if(animstruct.infil_anim_type == "player")
    thread playinfilplayeranims(animstruct, players);

  animstruct.aidoorchief scriptmodelplayanim("sdr_mp_infil_ac130_redux_doorchief", "doorchief");
  level thread offlight(animstruct);
  level thread redlight(animstruct);
  level thread greenlight(animstruct);
  level thread playerwind(animstruct, players);
  level thread cloud_cover(animstruct);
  level thread fade_cover(animstruct);
  level thread infil_light_dvars(animstruct);
  level thread delaystreamtomovingplane(animstruct, players);

  if(_id_35BE50043C0855AE())
    animstruct.cameraent waittillmatch("camera", "transition");
  else
    animstruct.cameraent scripts\engine\utility::waittill_match_or_timeout("camera", "transition", 30.0);

  animstruct notify("infil_reset_light_dvars");
  level clearplayerwind(animstruct, players);
  _id_31524FF7E103FE42 = 0.1;
  _id_6DBF75F07032BE02 = 0.0;
  _id_965E07B090747071 = 0.2;
}

transitionac130tomovinganim(animstruct, players) {
  _id_D69C3085D8CF2730 = 65;
  _id_DECC5773BF6D2DC5 = 14;
  _id_6642AE82A680F3E9 = 35;
  _id_CE7B1C2D2F4235C0 = 2.0;
  _id_5E0F870C68F3CFAB = 4;

  if(isDefined(animstruct.cameraentmoving)) {
    _id_FA371B137DF55A75 = scripts\engine\utility::ter_op(isDefined(players), players, level.players);

    foreach(player in _id_FA371B137DF55A75) {
      if(!isDefined(player)) {
        continue;
      }
      player setallstreamloaddist(0.0);

      if(!isDefined(player.infilanimindex))
        player.infilanimindex = 1;

      animstruct.cameraentlinktag = "j_prop_" + player.infilanimindex;
      player cameraunlink();
      player cameralinkTo(animstruct.cameraentmoving, animstruct.cameraentlinktag, 1, 1);
      player setclientdvar("cg_fov", _id_D69C3085D8CF2730);
      player setphysicaldepthoffield(_id_DECC5773BF6D2DC5, _id_6642AE82A680F3E9, _id_CE7B1C2D2F4235C0, _id_5E0F870C68F3CFAB);
      player notify("infil_move");
    }

    thread clearsoundsubmixfadetoblackamb(players);
  } else {
    _id_FA371B137DF55A75 = scripts\engine\utility::ter_op(isDefined(players), players, level.players);

    foreach(player in _id_FA371B137DF55A75) {
      if(!isDefined(player)) {
        continue;
      }
      player setallstreamloaddist(0.0);
    }
  }

  if(isDefined(animstruct.cloudanimfx)) {
    if(isDefined(animstruct.movingc130))
      animstruct.cloudanimfx.origin = animstruct.movingc130.origin;
  }

  if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73()) {
    if(isDefined(animstruct._id_352D21900A2AA86F) && isDefined(animstruct.movingc130))
      animstruct._id_352D21900A2AA86F.origin = animstruct.movingc130.origin;
  }

  animstruct.staticc130 hide();
  animstruct.cameraent unlink();
  animstruct.playerpositionents["parent"] unlink();

  if(isDefined(animstruct.movingc130)) {
    animstruct.playerpositionents["parent"] linkTo(animstruct.movingc130, "", (0, 0, 0), (0, 0, 0));
    animstruct.cameraent linkTo(animstruct.movingc130, "", (0, 0, 0), (0, 0, 0));
    animstruct.movingc130 notify("start_moving");
  }

  setomnvar("ui_hide_player_icons", 0);
  setomnvar("ui_in_infil", 2);
  _id_FA371B137DF55A75 = scripts\engine\utility::ter_op(isDefined(players), players, level.players);

  foreach(player in _id_FA371B137DF55A75) {
    if(!isDefined(player)) {
      continue;
    }
    player setclienttriggeraudiozone("mp_br_c130_infil_ext", 2.0);
  }

  thread clearsoundsubmixmpbrinfilac130(players);

  if(animstruct.infil_anim_type == "script_model") {
    animstruct.playerslot1 scriptmodelplayanim("sdr_mp_infil_ac130_loop_pl01", "p1");
    animstruct.playerslot2 scriptmodelplayanim("sdr_mp_infil_ac130_loop_pl02", "p2");
    animstruct.playerslot3 scriptmodelplayanim("sdr_mp_infil_ac130_loop_pl03", "p3");
    animstruct.playerslot4 scriptmodelplayanim("sdr_mp_infil_ac130_loop_pl04", "p4");
  }

  animstruct.aidoorchief scriptmodelplayanim("sdr_mp_infil_ac130_loop_doorchief", "doorchief");
  level thread playac130infilloopanims(animstruct);

  if(isDefined(animstruct.cameraentmoving))
    animstruct.cameraentmoving waittillmatch("camera", "end");

  thread unfreezeplayercontrols(1.2, players);
}

unfreezeplayercontrols(_id_74B5B12BB6514385, players) {
  wait(_id_74B5B12BB6514385);
  _id_FA371B137DF55A75 = scripts\engine\utility::ter_op(isDefined(players), players, level.players);

  foreach(player in _id_FA371B137DF55A75) {
    if(!isDefined(player)) {
      continue;
    }
    player scripts\mp\utility\player::_freezelookcontrols(0);
  }
}

endac130infilanimsinternal(animstruct, players) {
  thread lightsreset();
  stopFXOnTag(level._effect["vfx_br_ac130_clouds"], animstruct.staticc130, "tag_body");
  animstruct.staticc130 stoploopsound();

  if(isDefined(animstruct.movingc130))
    animstruct.movingc130 playLoopSound("br_ac130_lp");

  _id_FA371B137DF55A75 = scripts\engine\utility::ter_op(isDefined(players), players, level.players);

  foreach(player in _id_FA371B137DF55A75) {
    if(!isDefined(player)) {
      continue;
    }
    player setallstreamloaddist(0.0);
    player cameraunlink();
    player setclientdvar("cg_fov", 65);
    player disablephysicaldepthoffieldscripting();
    player scripts\mp\utility\player::setdof_default();
  }

  level thread stopstreamtomovingplane(animstruct, players);
}

playac130infilloopanims(animstruct) {
  if(isDefined(animstruct.movingc130)) {
    animstruct.movingc130 scriptmodelplayanim("sdr_mp_infil_ac130_loop2_plane", "plane");
    animstruct.movingc130.innards scriptmodelplayanim("sdr_mp_infil_ac130_loop2_plane", "planeInnards");
  }

  animstruct.playerpositionents["parent"] scriptmodelplayanim("sdr_mp_infil_ac130_loop_genpropx10", "prop");
}

offlight(animstruct) {
  _id_620D0024527F448C = getentitylessscriptablearray("infil_blinking_light", "script_noteworthy");

  foreach(_id_4D81CDDC98ED9537 in _id_620D0024527F448C)
  _id_4D81CDDC98ED9537 setscriptablepartstate("light_blinking_slow", "light_off_hold", 1);
}

redlight(animstruct) {
  animstruct endon("stopScene");
  animstruct.staticc130 waittillmatch("plane", "gored");
  _id_620D0024527F448C = getentitylessscriptablearray("infil_blinking_light", "script_noteworthy");

  foreach(_id_4D81CDDC98ED9537 in _id_620D0024527F448C)
  _id_4D81CDDC98ED9537 setscriptablepartstate("light_blinking_slow", "light_on", 1);
}

greenlight(animstruct) {
  animstruct endon("stopScene");
  animstruct.staticc130 waittillmatch("plane", "gogreen");
  _id_620D0024527F448C = getentitylessscriptablearray("infil_blinking_light", "script_noteworthy");

  foreach(_id_4D81CDDC98ED9537 in _id_620D0024527F448C)
  _id_4D81CDDC98ED9537 setscriptablepartstate("light_blinking_slow", "light_jump", 1);
}

playerwind(animstruct, players) {
  if(_id_35BE50043C0855AE()) {
    return;
  }
  animstruct endon("stopScene");
  animstruct.staticc130 scripts\engine\utility::waittill_match_or_timeout("plane", "opendoor", 30.0);
  _id_FA371B137DF55A75 = scripts\engine\utility::ter_op(isDefined(players), players, level.players);

  foreach(player in _id_FA371B137DF55A75) {
    if(!isDefined(player) || isbot(player)) {
      continue;
    }
    player scripts\mp\utility\player::setwind("100", 1);
  }

  animstruct.aidoorchief scripts\mp\utility\player::setwind("100");
}

clearplayerwind(animstruct, players) {
  _id_FA371B137DF55A75 = scripts\engine\utility::ter_op(isDefined(players), players, level.players);

  foreach(player in _id_FA371B137DF55A75) {
    if(!isDefined(player)) {
      continue;
    }
    player scripts\mp\utility\player::setwind("1");
    player.manualoverridewindmaterial = undefined;
  }

  animstruct.aidoorchief scripts\mp\utility\player::setwind("0");
}

cloud_cover(animstruct) {
  animstruct endon("stopScene");
  animstruct.staticc130 waittillmatch("plane", "transitionstart");
  triggerfx(animstruct.cloudanimfx);

  if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
    triggerfx(animstruct._id_352D21900A2AA86F);
}

fade_cover(animstruct) {
  level endon("game_ended");

  if(!isDefined(animstruct.cameraentmoving)) {
    return;
  }
  overlay = newhudelem();
  overlay.x = 0;
  overlay.y = 0;
  overlay setshader("white", 640, 480);
  overlay.alignx = "left";
  overlay.aligny = "top";
  overlay.horzalign = "fullscreen";
  overlay.vertalign = "fullscreen";
  overlay.sort = -1;
  overlay.color = (0.5, 0.5, 0.5);
  overlay.alpha = 0;
  _id_EE006CF398BCD8FD = 0.16;
  _id_C8FE6E3CA9715960 = 0.5;
  animstruct.cameraentmoving waittillmatch("camera", "fadeinstart");
  overlay fadeovertime(_id_EE006CF398BCD8FD);
  overlay.alpha = 0.8;
  animstruct.cameraentmoving waittillmatch("camera", "fadeoutstart");
  overlay fadeovertime(_id_C8FE6E3CA9715960);
  overlay.alpha = 0;
  _id_0930A1E7BD882C1D::waitandpause(_id_C8FE6E3CA9715960 + 0.1);
  overlay destroy();
}

infil_light_dvars(animstruct) {
  _id_C3ED855FE7C983E3 = getdvarfloat("sm_spotDistCull");
  _id_1800E53D66415E2D = getdvarint("sm_spotUpdateLimit");
  _id_5506432D2291C178 = getdvarint("sm_roundRobinPrioritySpotShadows");
  _id_488F9B9FE1EAD0A6 = getdvarfloat("sm_sunSampleSizeNear");
  _id_8A123774D2925E5D = getdvarint("dvar_27D9CB2953410E87");
  _id_99598B81BA0F7519 = getdvarfloat("dvar_A589D43A51D526DF");
  setDvar("sm_spotDistCull", 1000.0);
  setDvar("sm_spotUpdateLimit", 6);
  setDvar("sm_roundRobinPrioritySpotShadows", 8);
  setDvar("sm_sunSampleSizeNear", 0.25);
  setDvar("dvar_27D9CB2953410E87", 1);
  setDvar("dvar_A589D43A51D526DF", 0.35);
  animstruct scripts\engine\utility::waittill_either("infil_reset_light_dvars", "stopScene");
  setDvar("sm_spotDistCull", _id_C3ED855FE7C983E3);
  setDvar("sm_spotUpdateLimit", _id_1800E53D66415E2D);
  setDvar("sm_roundRobinPrioritySpotShadows", _id_5506432D2291C178);
  setDvar("sm_sunSampleSizeNear", _id_488F9B9FE1EAD0A6);
  setDvar("dvar_27D9CB2953410E87", _id_8A123774D2925E5D);
  setDvar("dvar_A589D43A51D526DF", _id_99598B81BA0F7519);
}

delaystreamtomovingplane(animstruct, players) {
  if(isDefined(animstruct.movingc130) && getdvarint("dvar_EB8A05AFA7735E5F", 1) == 1) {
    _id_74B5B12BB6514385 = getdvarint("dvar_D01D0472D843D39E", 8);
    wait(_id_74B5B12BB6514385);
    _id_11F3B4465C8B637B = animstruct.movingc130.origin;
    forward = getdvarint("dvar_7ABCDA2D7AABBE4C", 0);

    if(forward > 0) {
      dir = anglesToForward(animstruct.movingc130.angles);
      _id_11F3B4465C8B637B = animstruct.movingc130.origin + dir * forward;
    }

    _id_FA371B137DF55A75 = scripts\engine\utility::ter_op(isDefined(players), players, level.players);

    foreach(player in _id_FA371B137DF55A75) {
      if(!isDefined(player)) {
        continue;
      }
      player setpredictedstreamloaddist(0.0);
      player _id_2CEDCC356F1B9FC8::playerstreamhintlocation(_id_11F3B4465C8B637B);
    }
  }
}

stopstreamtomovingplane(animstruct, players) {
  if(isDefined(animstruct.movingc130) && getdvarint("dvar_EB8A05AFA7735E5F", 1) == 1) {
    _id_74B5B12BB6514385 = getdvarint("dvar_B7C6D487B0F5506B", 5);
    wait(_id_74B5B12BB6514385);
    _id_FA371B137DF55A75 = scripts\engine\utility::ter_op(isDefined(players), players, level.players);

    foreach(player in _id_FA371B137DF55A75) {
      if(!isDefined(player)) {
        continue;
      }
      player thread _id_2CEDCC356F1B9FC8::playerclearstreamhintorigin();
    }
  }
}

getlightingvalues() {}

lightsreset() {}

movetowithpause(point, time, accel, decel) {
  self moveTo(point, time, accel, decel);
}

rotatetowithpause(angles, time, accel, decel) {
  self rotateTo(angles, time, accel, decel);
}

headlessinfils() {
  dist = distance(level.br_ac130.pathstruct.startpt, level.br_ac130.pathstruct.endpt);
  time = dist / _id_45B2B4A889E633FA::getc130speed() / level.headlessinfilplayers.size;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.headlessinfilplayers.size; _id_AC0E594AC96AA3A8++) {
    wait(time);
    level.headlessinfilplayers[_id_AC0E594AC96AA3A8] notify("halo_jump_c130");
  }

  level.headlessinfilplayers = undefined;
}

registerheadlessinfil(player) {
  if(!isDefined(level.headlessinfilplayers))
    level.headlessinfilplayers = [];

  level.headlessinfilplayers[level.headlessinfilplayers.size] = player;
}