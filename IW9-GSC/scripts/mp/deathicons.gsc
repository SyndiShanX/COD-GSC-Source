/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\deathicons.gsc
***********************************************/

init() {}

adddeathicon(attacker, entity, _id_FDF2150B2EE00667, team, timeout) {
  _id_FDF2150B2EE00667 endon("disconnect");

  if(istrue(_id_FDF2150B2EE00667.skipdeathicon)) {
    return;
  }
  if(!level.teambased) {
    return;
  }
  if(getDvar("ui_hud_showdeathicons") == "0") {
    return;
  }
  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924()) {
    return;
  }
  if(istrue(_id_FDF2150B2EE00667 _id_2CEDCC356F1B9FC8::isplayeringulag())) {
    return;
  }
  if(scripts\mp\utility\game::isteamreviveenabled()) {
    return;
  }
  if(attacker scripts\mp\utility\perk::_hasperk("specialty_operative")) {
    return;
  }
  _id_E005D4B70D6F2611 = scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508();
  _id_8F0D5DCEEB1EC104 = scripts\mp\utility\game::getgametype() == "brtdm" || scripts\mp\utility\game::getgametype() == "brtdm_mgl";
  _id_D9622D6CF6275394 = attacker scripts\mp\utility\perk::_hasperk("specialty_silentkill");

  if(!_id_E005D4B70D6F2611 && _id_D9622D6CF6275394) {
    return;
  }
  _id_1453F424673CF292 = entity.origin;
  _id_1453F424673CF292 = _id_1453F424673CF292 + (0, 0, 40);
  _id_FDF2150B2EE00667 notify("addDeathIcon()");
  _id_FDF2150B2EE00667 endon("addDeathIcon()");

  if(isDefined(_id_FDF2150B2EE00667.lastdeathheadicon)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(_id_FDF2150B2EE00667.lastdeathheadicon);
    _id_FDF2150B2EE00667.lastdeathheadicon = undefined;
  }

  _id_FDF2150B2EE00667 notify("removed_death_icon");
  image = "hud_icon_death_spawn";
  showto = team;

  if(_id_E005D4B70D6F2611) {
    _id_43EBEB802E94DD92 = _id_FDF2150B2EE00667._id_3F78C6A0862F9E25;

    if(!isDefined(_id_43EBEB802E94DD92) || _id_43EBEB802E94DD92 < 0) {
      return;
    }
    image = "hud_icon_player_dead_" + (_id_FDF2150B2EE00667._id_3F78C6A0862F9E25 + 1);

    if(_id_D9622D6CF6275394)
      showto = [_id_FDF2150B2EE00667];
    else
      showto = scripts\mp\utility\teams::getteamdata(_id_FDF2150B2EE00667.team, "players");
  } else if(_id_8F0D5DCEEB1EC104) {
    if(_id_D9622D6CF6275394)
      showto = [_id_FDF2150B2EE00667];
    else
      showto = scripts\mp\utility\teams::getteamdata(_id_FDF2150B2EE00667.team, "players");
  }

  _id_7591ED99E87A77D3 = _id_FDF2150B2EE00667.origin;
  _id_B3EA37733A1577E5 = _id_E005D4B70D6F2611;
  showonminimap = _id_E005D4B70D6F2611;
  _id_FDF2150B2EE00667.lastdeathheadicon = _id_FDF2150B2EE00667 scripts\cp_mp\entityheadicons::setheadicon_singleimage(showto, image, undefined, 1, 0, 0, undefined, undefined, _id_B3EA37733A1577E5, _id_7591ED99E87A77D3, showonminimap);

  if(_id_E005D4B70D6F2611)
    _func_EA1DDEF8AEDE7460(_id_FDF2150B2EE00667.lastdeathheadicon, _id_FDF2150B2EE00667._id_3F78C6A0862F9E25 + 1);

  if(isDefined(_id_FDF2150B2EE00667.lastdeathheadicon)) {
    if(_id_E005D4B70D6F2611 || _id_8F0D5DCEEB1EC104)
      _id_FDF2150B2EE00667 thread handleteamvisibility(_id_D9622D6CF6275394);
    else
      _id_FDF2150B2EE00667 thread destroyslowly(timeout);
  }
}

handleteamvisibility(_id_D9622D6CF6275394) {
  self endon("removed_death_icon");
  team = self.team;
  icon = self.lastdeathheadicon;

  if(!_id_D9622D6CF6275394)
    handlefriendlyvisibility(icon, team);

  if(isDefined(self))
    handleownervisibility();

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(icon);

  if(isDefined(self))
    self.lastdeathheadicon = undefined;
}

handlefriendlyvisibility(icon, team) {
  _id_BE5E71251B2FDB9D = getdvarfloat("death_icon_teammate_duration", 10.0);
  _id_EC15E7C2B73E1708 = getdvarfloat("dvar_D4E44EECF9BC8099", 0.0);
  wait(_id_BE5E71251B2FDB9D);
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getfriendlyplayers(team);

  foreach(player in _id_6D5ED003AF1F9612) {
    if(!isDefined(player)) {
      continue;
    }
    if(_id_EC15E7C2B73E1708 > 0) {
      if(isDefined(self._id_0FF97225579DE16A) && isDefined(player._id_0FF97225579DE16A) && self._id_0FF97225579DE16A == player._id_0FF97225579DE16A)
        continue;
    }

    if(isDefined(self) && player == self) {
      continue;
    }
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(icon, player);
  }

  if(_id_EC15E7C2B73E1708 > 0) {
    wait(_id_EC15E7C2B73E1708);
    _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getfriendlyplayers(team);

    foreach(player in _id_6D5ED003AF1F9612) {
      if(!isDefined(player)) {
        continue;
      }
      if(isDefined(self._id_0FF97225579DE16A) && isDefined(player._id_0FF97225579DE16A) && self._id_0FF97225579DE16A != player._id_0FF97225579DE16A) {
        continue;
      }
      if(isDefined(self) && player == self) {
        continue;
      }
      scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(icon, player);
    }
  }
}

handleownervisibility() {
  if(!_id_2CEDCC356F1B9FC8::isplayeringulag()) {
    _id_E0605C9A54D6CF08 = getdvarfloat("dvar_D045D41EBE40BF8D", 15.0);

    if(!scripts\mp\utility\player::isreallyalive(self))
      self waittill("spawned_player");
    else {
      _id_282BFAAE40D9A8A1 = gettime() - self.lastspawntime;
      _id_E0605C9A54D6CF08 = _id_E0605C9A54D6CF08 - _id_282BFAAE40D9A8A1 / 1000;
    }

    if(_id_E0605C9A54D6CF08 > 0)
      wait(_id_E0605C9A54D6CF08);
  }
}

destroyslowly(timeout) {
  self endon("removed_death_icon");
  owner = self;
  icon = self.lastdeathheadicon;
  wait(timeout);
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(icon);

  if(isDefined(owner))
    owner.lastdeathheadicon = undefined;
}

hidedeathicon(player) {
  if(!isDefined(player) || !isDefined(player.lastdeathheadicon)) {
    return;
  }
  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(player.lastdeathheadicon, player);
}

removedeathicon(player) {
  if(!isDefined(player) || !isDefined(player.lastdeathheadicon)) {
    return;
  }
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(player.lastdeathheadicon);
  player.lastdeathheadicon = undefined;
  player notify("removed_death_icon");
}

removealldeathicons() {
  foreach(player in level.players)
  removedeathicon(player);
}

addenemydeathicon(entity, _id_FDF2150B2EE00667, _id_DD573EDAA0C55862, _id_5582B247A8570F9B, timeout, _id_29693175F0940203) {
  _id_FDF2150B2EE00667 endon("disconnect");

  if(!level.teambased) {
    return;
  }
  if(istrue(_id_FDF2150B2EE00667 _id_2CEDCC356F1B9FC8::isplayeringulag())) {
    return;
  }
  _id_1453F424673CF292 = entity.origin;
  _id_1453F424673CF292 = _id_1453F424673CF292 + (0, 0, 40);
  _id_FDF2150B2EE00667 notify("addDeathIcon()");
  _id_FDF2150B2EE00667 endon("addDeathIcon()");

  if(!_id_29693175F0940203) {
    if(getDvar("ui_hud_showdeathicons") == "0") {
      return;
    }
    if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
      return;
  }

  if(isDefined(_id_FDF2150B2EE00667._id_795AD0631CF24432)) {
    foreach(icon in _id_FDF2150B2EE00667._id_795AD0631CF24432)
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(icon);

    _id_FDF2150B2EE00667._id_795AD0631CF24432 = undefined;
  }

  _id_FDF2150B2EE00667 notify("removed_enemy_death_icon");

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924()) {
    image = "hud_realism_head_death";
    _id_E0E11F3B4551BE11 = 0;
    _id_C5409CA7522182B3 = 768;
    _id_30516B4AFD1763DE = 10;

    if(istrue(level._id_32FE21B3C5052471))
      image = "hud_icon_death_spawn";
  } else {
    image = "hud_icon_death_hunter_spawn";
    _id_E0E11F3B4551BE11 = 1;
    _id_C5409CA7522182B3 = 768;
    _id_30516B4AFD1763DE = 0;

    if(istrue(level._id_32FE21B3C5052471))
      image = "hud_icon_death_spawn";
  }

  _id_7591ED99E87A77D3 = _id_FDF2150B2EE00667.origin;

  if(_id_5582B247A8570F9B.size > 0) {
    _id_5E156D8393667BCF = "esports_codcaster_waypoint_skull";
    head_icon = _id_FDF2150B2EE00667 scripts\cp_mp\entityheadicons::setheadicon_singleimage(_id_5582B247A8570F9B, _id_5E156D8393667BCF, undefined, _id_E0E11F3B4551BE11, _id_C5409CA7522182B3, _id_30516B4AFD1763DE, undefined, undefined, undefined, _id_7591ED99E87A77D3);
    setheadiconteam(head_icon, _id_FDF2150B2EE00667.team);
    _id_FDF2150B2EE00667._id_795AD0631CF24432 = scripts\engine\utility::array_add_safe(_id_FDF2150B2EE00667._id_795AD0631CF24432, head_icon);
  }

  if(_id_DD573EDAA0C55862.size > 0) {
    head_icon = _id_FDF2150B2EE00667 scripts\cp_mp\entityheadicons::setheadicon_singleimage(_id_DD573EDAA0C55862, image, undefined, _id_E0E11F3B4551BE11, _id_C5409CA7522182B3, _id_30516B4AFD1763DE, undefined, undefined, undefined, _id_7591ED99E87A77D3);
    _id_FDF2150B2EE00667._id_795AD0631CF24432 = scripts\engine\utility::array_add_safe(_id_FDF2150B2EE00667._id_795AD0631CF24432, head_icon);
  }

  if(isDefined(_id_FDF2150B2EE00667._id_795AD0631CF24432))
    _id_FDF2150B2EE00667 thread destroyenemyiconslowly(timeout);
}

destroyenemyiconslowly(timeout) {
  self endon("removed_enemy_death_icon");
  owner = self;
  _id_BA552A1766DA85FD = self._id_795AD0631CF24432;
  wait(timeout);

  foreach(icon in _id_BA552A1766DA85FD)
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(icon);

  if(isDefined(owner))
    owner._id_795AD0631CF24432 = undefined;
}