/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7fba4131729fe74d.gsc
***********************************************/

_id_80D68C9701E1AEA5(data) {
  level._id_CABA91EECF74C36C = spawnStruct();
  level._id_CABA91EECF74C36C.capturetime = getdvarint("dvar_3C0F9FA2BC4D4D67", 120);
  level._id_CABA91EECF74C36C._id_029A79D378C70E0B = getdvarint("dvar_57953E874D9DD19C", 800);
  level._id_CABA91EECF74C36C._id_DFE92BB3A3B6A89A = getdvarint("dvar_1EC4D1950E884A45", 800);
  level._id_CABA91EECF74C36C._id_5E7A8E300A12B235 = getdvarint("dvar_F4B9219B332581A2", 1);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_secret_stash", ::_id_2D03C352AFD1F1BF);
  script_model_anims();

  while(!isDefined(level._id_F1073FBD45B59A06) || !istrue(level._id_F1073FBD45B59A06._id_F9CF165941D1A5BE))
    waitframe();

  _id_879BADB8C80B0204 = [];
  _id_BCB418497D44610B = scripts\engine\utility::getStructArray("dmz_secret_stash", "script_noteworthy");

  if(!istrue(level._id_CABA91EECF74C36C._id_5E7A8E300A12B235))
    _id_BCB418497D44610B = getunusedlootcachepoints();

  foreach(node in _id_BCB418497D44610B) {
    _id_276AC5E84835EA87 = _id_4948CDF739393D2D::_id_C0A211A69F5F8F2F(node.origin);

    if(isDefined(_id_276AC5E84835EA87) && !_id_4948CDF739393D2D::_id_4EC4F39A2E1745F2(_id_276AC5E84835EA87)) {
      node._id_276AC5E84835EA87 = _id_276AC5E84835EA87;
      _id_879BADB8C80B0204[_id_879BADB8C80B0204.size] = node;
    }
  }

  _id_03314ADD7998AB13::_id_B713F2D39B34540F(data, ::_id_3F49DB86FC08365D, _id_879BADB8C80B0204);
}

#using_animtree("script_model");

script_model_anims() {
  level.scr_animtree["gun_safe_drill_player"] = #animtree;
  level.scr_anim["gun_safe_drill_player"]["gun_safe_enter"] = % iw9_dmz_stashdrill_enter_stand_sdr;
  level.scr_animname["gun_safe_drill_player"]["gun_safe_enter"] = "iw9_dmz_stashdrill_enter_stand_sdr";
  level.scr_eventanim["gun_safe_drill_player"]["gun_safe_enter"] = "gun_safe_enter";
  level.scr_viewmodelanim["gun_safe_drill_player"]["gun_safe_enter"] = "iw9_dmz_stashdrill_enter_stand_sdr";
}

_id_9B5FC1D0B7049FD3(_id_BD138DE99B3B3507) {
  if(!_id_BD138DE99B3B3507) {
    _id_3B64EB40368C1450::set("drilling", "allow_jump", 0);
    _id_3B64EB40368C1450::set("drilling", "gesture", 0);
    _id_3B64EB40368C1450::set("drilling", "melee", 0);
    _id_3B64EB40368C1450::set("drilling", "mantle", 0);
    _id_3B64EB40368C1450::set("drilling", "offhand_weapons", 0);
    _id_3B64EB40368C1450::set("drilling", "allow_movement", 0);
    _id_3B64EB40368C1450::set("drilling", "sprint", 0);
    _id_3B64EB40368C1450::set("drilling", "fire", 0);
    _id_3B64EB40368C1450::set("drilling", "reload", 0);
    _id_3B64EB40368C1450::set("drilling", "weapon_pickup", 0);
    _id_3B64EB40368C1450::set("drilling", "weapon_switch", 0);
    _id_3B64EB40368C1450::set("drilling", "offhand_weapons", 0);
    _id_3B64EB40368C1450::set("drilling", "supers", 0);
    self _meth_35501B42058D4DE9();
  } else {
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("drilling");
    self _meth_BB04491D50D9E43E();
  }
}

_id_D5612C9774F4ED30(player) {
  player endon("death_or_disconnect");
  player endon("enter_live_ragdoll");
  player endon("interact_interrupt");
  player _id_9B5FC1D0B7049FD3(0);
  _id_A66FD1B124C32F51 = player getplayerangles();
  player.linktoent = player scripts\engine\utility::spawn_tag_origin(player.origin, player._id_A66FD1B124C32F51);
  player playerlinktodelta(player.linktoent, "tag_origin", 1, 0, 0, 30, 30, 0, 1);
  goalpos = self.origin + rotatevector((0, 41.127, 0), self.angles + (0, -90, 0));
  forward = (0, 0, 0) - anglesToForward(self.angles);
  up = (0, 0, 1);
  right = vectorcross(forward, up);
  _id_8003B0D4F9FBEE0E = axistoangles(forward, right, up) + (0, 0, 0);
  _id_57C87883AE437750 = 0.5;
  player.linktoent moveTo(goalpos, _id_57C87883AE437750, 0.1, 0.1);
  player.linktoent rotateTo(_id_8003B0D4F9FBEE0E, _id_57C87883AE437750, 0.1, 0.1);
  player setstance("stand");
  _id_CD9982ADB17761A8 = gettime();
  player scripts\cp_mp\utility\inventory_utility::_id_FC6A5B145563BE33();
  _id_698CC218E4ADE75F = gettime();
  _id_218F64CB035D54BE = _id_57C87883AE437750 - (_id_698CC218E4ADE75F - _id_CD9982ADB17761A8) / 1000.0;
  waittime = max(0, _id_218F64CB035D54BE);
  wait(waittime);
  player setOrigin(goalpos);
  player setplayerangles(_id_8003B0D4F9FBEE0E);
  player thread scripts\mp\utility\infilexfil::infil_player_rig_updated("gun_safe_drill_player", player.origin, player.angles);
  player.player_rig showonlytoplayer(player);
  animstruct = spawnStruct();
  animstruct.origin = self.origin;
  animstruct.angles = self.angles + (0, 90, 0);
  self setscriptablepartstate("dmz_secret_stash", "drill_enter");
  animstruct scripts\mp\anim::anim_player_solo(player, player.player_rig, "gun_safe_enter");

  if(isDefined(player) && scripts\mp\utility\player::isreallyalive(player))
    player notify("interact_finished");

  waitframe();

  if(istrue(level.gameended)) {
    return;
  }
  if(isDefined(player)) {
    player notify("remove_rig");

    if(scripts\mp\utility\player::isreallyalive(player))
      player _id_9B5FC1D0B7049FD3(1);
  }

  self._id_B14A331BA425C286 = 1;
}

_id_783F84B2AAF11D69(player) {
  player endon("interact_finished");
  player scripts\engine\utility::waittill_any_3("death_or_disconnect", "enter_live_ragdoll", "last_stand_start");
  player notify("interact_interrupt");
  player stopanimscriptsceneevent();

  if(isDefined(player.linktoent)) {
    player unlink();
    player.linktoent delete();
    player.linktoent = undefined;
  }

  player notify("remove_rig");
  player _id_9B5FC1D0B7049FD3(1);
}

_id_2D03C352AFD1F1BF(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(player.team)) {
    return;
  }
  if(part == "dmz_secret_stash" && state == "usable") {
    instance setscriptablepartstate("dmz_secret_stash", "unusable");
    instance._id_B14A331BA425C286 = 0;
    instance thread _id_783F84B2AAF11D69(player);
    instance _id_D5612C9774F4ED30(player);

    if(istrue(instance._id_B14A331BA425C286))
      instance._id_B8EBE3F71A08AB40 thread _id_F339128058791C31(player.team);
    else
      instance setscriptablepartstate("dmz_secret_stash", "usable");
  } else if(part == "dmz_secret_stash" && (state == "closed_usable" || state == "partially_open_usable")) {
    if(!isDefined(instance.contents)) {
      items = _id_552B8E4EA5FF7DF1::_id_A76B46F057488CC0(instance, player.team, 22, getdvarint("dvar_3AA9346EDFFDB1BD", 2));
      instance._id_46A3A8565AC0C17C = 5;
      instance.contents = _id_552B8E4EA5FF7DF1::_id_EC87B214CD429E96(items, undefined);
      _id_8BD50C7E994C7434 = int(instance._id_B8EBE3F71A08AB40._id_723B8F7CB71CEB11);
      instance.contents = _id_552B8E4EA5FF7DF1::_id_163D360C111CAA16(instance.contents, _id_8BD50C7E994C7434, 750);
      _id_552B8E4EA5FF7DF1::lootcacheused(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61, 1);
    } else
      _id_552B8E4EA5FF7DF1::lootcacheused(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61, 1);
  }
}

_id_3F49DB86FC08365D(_id_EFA8EF05B190D7D0, node) {
  _id_B8EBE3F71A08AB40 = _id_6C4E8CEA70BF4B6D::_id_5F6D9FD82BDD2D05(_id_EFA8EF05B190D7D0);
  _id_B8EBE3F71A08AB40.funcs["onInit"] = ::_id_1CA0090AC5FEC38E;
  _id_B8EBE3F71A08AB40.funcs["onPlayerJoined"] = ::_id_B91953894E06C4FC;
  _id_B8EBE3F71A08AB40.funcs["onPlayerRemoved"] = ::_id_F04510C7F0F2BDDF;
  _id_B8EBE3F71A08AB40.funcs["onTeamAssigned"] = ::_id_3AD407F03F87FBC5;
  _id_B8EBE3F71A08AB40.funcs["onTeamStart"] = ::_id_D757790E96368877;
  _id_B8EBE3F71A08AB40.funcs["onCancel"] = ::_id_B69813E0EF9569BE;
  _id_B8EBE3F71A08AB40.ref = "dmz_fortress_search";
  _id_B8EBE3F71A08AB40._id_30E8A65CFF941C7A = _id_64ACB6CE534155B7::getquesttableindex(_id_B8EBE3F71A08AB40.ref);
  _id_B8EBE3F71A08AB40.node = node;
  _id_B8EBE3F71A08AB40._id_276AC5E84835EA87 = node._id_276AC5E84835EA87;
  return _id_B8EBE3F71A08AB40;
}

_id_1CA0090AC5FEC38E() {
  self._id_EFA8EF05B190D7D0.origin = self.node.origin;
  self.capturetime = level._id_CABA91EECF74C36C.capturetime;
  _id_E7F010F72A055377();
  self._id_1C17E70621BB1BBC = _id_8B3D13F0D1A8607D(self._id_276AC5E84835EA87);
  self._id_65513AD5397A67EF = "trap" + gettime();

  foreach(door in self._id_1C17E70621BB1BBC) {
    door._id_65513AD5397A67EF = self._id_65513AD5397A67EF;
    door._id_AF0662D6485D5D58 = "trap";
  }

  self._id_69B705B3551A18C0 = 0;
  self.curorigin = self._id_B038ED928EC17A81.origin;
  self.offset3d = (0, 0, 85);
  _id_6C4E8CEA70BF4B6D::_id_C847BFD52C064289(self.curorigin + self.offset3d, "trap");
  scripts\mp\objidpoolmanager::objective_set_play_intro(self.icon, 1);
  scripts\mp\objidpoolmanager::objective_set_play_outro(self.icon, 0);
}

_id_B91953894E06C4FC(player) {
  self._id_B038ED928EC17A81 enablescriptableplayeruse(player);
  player._id_65513AD5397A67EF = self._id_65513AD5397A67EF;
}

_id_F04510C7F0F2BDDF(player) {
  if(!istrue(self._id_B0B10C60924B7F5F))
    self._id_B038ED928EC17A81 disablescriptableplayeruse(player);

  player._id_65513AD5397A67EF = undefined;
}

_id_3AD407F03F87FBC5(_id_FABF84450735DD93) {
  if(self._id_B038ED928EC17A81 getscriptablepartstate("dmz_secret_stash") == "unusable")
    self._id_B038ED928EC17A81 setscriptablepartstate("dmz_secret_stash", "usable");

  _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_trap_assigned", _id_FABF84450735DD93);

  foreach(player in level.players)
  self._id_B038ED928EC17A81 disablescriptableplayeruse(player);

  _id_E99A003997B05A0C = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

  foreach(player in _id_E99A003997B05A0C)
  self._id_B038ED928EC17A81 enablescriptableplayeruse(player);

  _id_6C4E8CEA70BF4B6D::_id_DFFCBCE998C9EE50(_id_FABF84450735DD93);
  _id_16D030ED02EC724D(_id_FABF84450735DD93);
  self._id_723B8F7CB71CEB11 = _id_6C4E8CEA70BF4B6D::_id_9C6AB63C4B6BD08B(_id_FABF84450735DD93);
}

_id_16D030ED02EC724D(_id_FABF84450735DD93) {
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, "dmz_trap_start", 1.5, "dmz_trap_start_classic");
  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("trap_assigned", _id_FABF84450735DD93, 2.5);
}

_id_D757790E96368877(_id_FABF84450735DD93) {
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, "dmz_trap_approach", 0.0, "dmz_trap_approach_classic");
  _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("trap_near", _id_FABF84450735DD93);
}

_id_B69813E0EF9569BE(_id_FABF84450735DD93) {
  players = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

  foreach(player in players) {
    if(!istrue(self._id_B0B10C60924B7F5F))
      self._id_B038ED928EC17A81 disablescriptableplayeruse(player);
  }

  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, undefined, undefined);
  _id_8250FD658E3AAE32();
  _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3();
}

_id_8250FD658E3AAE32() {
  self._id_2935F440EE6950CE = 1;

  if(!istrue(self._id_B0B10C60924B7F5F)) {
    self._id_B038ED928EC17A81.trigger delete();
    _id_6C4E8CEA70BF4B6D::_id_629ED367D1393020();
  }

  _id_6C4E8CEA70BF4B6D::_id_45BD3184FF146B46(self.teams[0]);
}

_id_91B74D9DFA893111(_id_FABF84450735DD93) {
  if(isDefined(self._id_B038ED928EC17A81.trigger))
    self._id_B038ED928EC17A81.trigger delete();

  _id_6C4E8CEA70BF4B6D::_id_629ED367D1393020();

  if(!istrue(self._id_2935F440EE6950CE)) {
    _id_8250FD658E3AAE32();

    foreach(team in self.teams) {
      _id_6C4E8CEA70BF4B6D::_id_A1738A95D7AA8094("dmz_survive_unlocked", "trap", self._id_EFA8EF05B190D7D0._id_723B8F7CB71CEB11, team);
      _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(team, "", 1.5);
    }

    _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3(self.teams[0]);
  }
}

_id_E7F010F72A055377() {
  origin = self.node.origin;
  angles = self.node.angles;

  if(!istrue(level._id_CABA91EECF74C36C._id_5E7A8E300A12B235))
    angles = angles + (0, 90, 0);

  _id_B038ED928EC17A81 = spawnscriptable("dmz_secret_stash", origin, angles);
  _id_B038ED928EC17A81._id_B8EBE3F71A08AB40 = self;
  self._id_B038ED928EC17A81 = _id_B038ED928EC17A81;
  trigger = spawn("trigger_radius", self._id_B038ED928EC17A81.origin, 0, level._id_CABA91EECF74C36C._id_029A79D378C70E0B, level._id_CABA91EECF74C36C._id_DFE92BB3A3B6A89A);
  trigger scripts\engine\utility::trigger_off();
  self._id_B038ED928EC17A81.trigger = trigger;
  thread _id_BB2CA071F1918797(trigger, level._id_CABA91EECF74C36C._id_029A79D378C70E0B);
}

_id_F339128058791C31(_id_FABF84450735DD93) {
  self._id_69B705B3551A18C0 = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players").size;
  self._id_B038ED928EC17A81.trigger scripts\engine\utility::trigger_on();

  if(!istrue(self._id_B038ED928EC17A81._id_9AEF22E3CD04E1DD)) {
    _id_6C4E8CEA70BF4B6D::_id_5314298E777E5688("dmz_trap");
    self._id_276AC5E84835EA87._id_6451879E18908224 setscriptablepartstate("fortress_tacmap_location_scriptable", "attacked", 0);
    objective_setshowprogress(self.icon, 1);
    thread _id_24F28C302A07B6A1(self._id_1C17E70621BB1BBC);
    thread _id_E6C617663E95D7E7(self._id_1C17E70621BB1BBC);
    groupname = "no_group";
    _id_13666CFBC0B4D87B = getdvarint("dvar_DC6EFD2D90A799E4", 6);
    _id_CFDDA0A45322F3B1 = getdvarint("dvar_D9950352BE0CDCD0", 8);
    _id_399DD745F3429984 = getdvarint("dvar_EAFC74F33B34F9E7", 6);
    _id_BA7DD45BD1A38818 = getdvarint("dvar_FC93BFBCA571EE92", 1);
    _id_1B61ED3F5BBA31FC = getdvarint("dvar_A9568DA46C605FCE", 1);
    _id_AEDACC7BF9F69197 = getdvarint("dvar_5C3CC2A96E90E73F", 1);
    thread _id_6727841E301AFF6E(self._id_B038ED928EC17A81.origin, _id_13666CFBC0B4D87B, groupname, _id_BA7DD45BD1A38818);
    thread _id_126DC0519B8A8EF6(self._id_B038ED928EC17A81.origin, _id_CFDDA0A45322F3B1, groupname, _id_1B61ED3F5BBA31FC);
    thread _id_3AF43B43F5A74CD9(self._id_B038ED928EC17A81.origin, _id_399DD745F3429984, groupname, _id_AEDACC7BF9F69197);
  }

  foreach(player in level.players) {
    if(isDefined(player))
      self._id_B038ED928EC17A81 enablescriptableplayeruse(player);
  }

  self._id_B0B10C60924B7F5F = 1;
  thread _id_F61CF2955D03326B(self._id_B038ED928EC17A81.origin, _id_FABF84450735DD93);
  _id_6C4E8CEA70BF4B6D::_id_C9F97BAA0D7F59BF("dmz_global_trap_start", _id_FABF84450735DD93);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, "dmz_trap_drill", 1.5, "dmz_trap_drill_classic");
  self.agents = [];
  self._id_90FB369A18926018 = [];
  self.progress = 0;

  for(;;) {
    if(isDefined(self._id_B038ED928EC17A81.trigger) && !istrue(self._id_B038ED928EC17A81.trigger.trigger_off)) {
      if(self._id_78122E18403A8DC4.size > 0) {
        _id_F8527642EA162AE5 = self.progress;
        self.progress = min(self.capturetime, self.progress + level.framedurationseconds);
      }

      progress = self.progress / self.capturetime;

      if(self.progress >= self.capturetime) {
        _id_DC537616AA6CD0B0();
        return;
      } else if(!istrue(self._id_B038ED928EC17A81._id_9AEF22E3CD04E1DD)) {
        self._id_90FB369A18926018 = _id_F69E0B0E05FD9B85(self._id_78122E18403A8DC4, self._id_90FB369A18926018);
        scripts\mp\objidpoolmanager::objective_set_progress(self.icon, progress);
      }
    }

    waitframe();
  }
}

_id_DC537616AA6CD0B0() {
  self notify("cache_unlocked");
  self._id_B038ED928EC17A81 setscriptablepartstate("dmz_secret_stash", "opening");

  if(!istrue(self._id_B038ED928EC17A81._id_9AEF22E3CD04E1DD)) {
    foreach(player in self._id_90FB369A18926018) {
      if(isDefined(player))
        scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(self.icon, player);
    }

    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.icon);
    objective_setshowprogress(self.icon, 0);
    _id_AC4C51BF033F6323 = scripts\engine\utility::array_combine_unique(scripts\mp\utility\teams::getteamdata(self.teams[0], "players"), self._id_78122E18403A8DC4);
    _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("trap_unlocked", _id_AC4C51BF033F6323);
    self._id_276AC5E84835EA87._id_6451879E18908224 setscriptablepartstate("fortress_tacmap_location_scriptable", "visible", 0);
    _id_91B74D9DFA893111(self.teams[0]);
  }
}

_id_F69E0B0E05FD9B85(_id_78122E18403A8DC4, _id_90FB369A18926018) {
  _id_5C882C8F7BB9C72A = scripts\engine\utility::array_combine(_id_78122E18403A8DC4, _id_90FB369A18926018);
  _id_F6FD7B0E73C3270C = _id_90FB369A18926018;

  foreach(player in _id_5C882C8F7BB9C72A) {
    if(!isDefined(player)) {
      continue;
    }
    if(!scripts\engine\utility::array_contains(_id_90FB369A18926018, player) && scripts\engine\utility::array_contains(_id_78122E18403A8DC4, player)) {
      if(scripts\mp\objidpoolmanager::_id_CE702E5925E31FC9(self.icon, player, 2, 2, &"MP_DMZ_MISSIONS/STASH_DRILL_PROGRESS_TITLE")) {
        scripts\mp\objidpoolmanager::objective_pin_player(self.icon, player);
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.icon, player);
        _id_F6FD7B0E73C3270C = scripts\engine\utility::array_add(_id_F6FD7B0E73C3270C, player);
      }

      continue;
    }

    if(scripts\engine\utility::array_contains(_id_90FB369A18926018, player) && !scripts\engine\utility::array_contains(_id_78122E18403A8DC4, player)) {
      if(self.teams[0] != player.team || istrue(self._id_2935F440EE6950CE))
        scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self.icon, player);

      scripts\mp\objidpoolmanager::objective_unpin_player(self.icon, player);
      scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(self.icon, player);
      _id_F6FD7B0E73C3270C = scripts\engine\utility::array_remove(_id_F6FD7B0E73C3270C, player);
    }
  }

  return _id_F6FD7B0E73C3270C;
}

_id_F61CF2955D03326B(location, _id_FABF84450735DD93) {
  wait(randomintrange(2, 4));
  playsoundatpos(location, "mp_dmz_alrm_trap");
  wait 3;
  _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("trap_start_unlock", _id_FABF84450735DD93);
}

_id_24F28C302A07B6A1(nodes) {
  wait 45;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 2; _id_AC0E594AC96AA3A8++) {
    foreach(node in nodes)
    thread _id_401F6C148C1FD7A8(node);

    wait 30;
  }
}

_id_401F6C148C1FD7A8(node) {
  wait(randomfloatrange(0.0, 2.0));
  magicgrenademanual("smoke_grenade_mp", node._id_F87CE576CBF4518A, (0, 0, -10), 0.5);
  thread scripts\engine\utility::play_sound_in_space("smoke_grenade_expl_trans", node._id_F87CE576CBF4518A);
}

_id_E6C617663E95D7E7(doors) {
  foreach(door in doors)
  door _meth_80902296B05BE00A();
}

_id_6727841E301AFF6E(location, numagents, groupname, _id_7D97C0571433F835) {
  level endon("game_ended");
  agents = [];
  _id_CF2FF249C028B242 = _id_48814951E916AF89::_id_AB14D6652E44FDA0(numagents, level.spawnset["guard"], 1);
  _id_CF2FF249C028B242._id_083C3368707C68E6 = "Helicopter";

  while(!isDefined(agents) || agents.size == 0) {
    agents = _id_48814951E916AF89::_id_77ACC10C4823DD8A(numagents, location, "high", "mission", "trapWave1", groupname, undefined, 1, self.node._id_B205D90302DA2F07, undefined, undefined, undefined, _id_CF2FF249C028B242);

    if(isDefined(agents) && agents.size != 0) {
      break;
    }

    wait 1;
  }

  self._id_7AFE9CF22B565562 = agents;
}

_id_29F807C6DB37B933(agent) {
  weapon = _id_2669878CF5A1B6BC::buildweapon("iw9_ar_mike4_mp", ["laserbox_hip04", "none", "none", "none", "silencer01_ar", "none"], "none", "none");
  agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF(undefined, undefined, weapon, "smoke_grenade_mp", 5);
}

_id_126DC0519B8A8EF6(location, numagents, groupname, _id_7D97C0571433F835) {
  level endon("game_ended");
  wait 15;
  agents = [];
  _id_CF2FF249C028B242 = _id_48814951E916AF89::_id_AB14D6652E44FDA0(numagents, level.spawnset["guard"], 2);
  _id_CF2FF249C028B242._id_083C3368707C68E6 = "Helicopter";

  while(!isDefined(agents) || agents.size == 0) {
    agents = _id_48814951E916AF89::_id_77ACC10C4823DD8A(numagents, location, "high", "mission", "trapWave2", groupname, undefined, 0, self.node._id_B205D90302DA2F07, undefined, undefined, undefined, _id_CF2FF249C028B242);

    if(isDefined(agents) && agents.size != 0) {
      break;
    }

    wait 1;
  }

  self._id_7158F739DB4A1D2F = agents;

  foreach(agent in agents) {
    _id_371B4C2AB5861E62::_id_58AAB2EDAEC2599F(agent, "dmzTask_setupSecondWaveAgent", ::_id_29F807C6DB37B933);

    if(isagent(agent))
      _id_29F807C6DB37B933(agent);
  }
}

_id_A1F4D17456E2A3CA(agent) {
  weapon = _id_2669878CF5A1B6BC::buildweapon("iw9_ar_mike4_mp", ["laserbox_hip04", "none", "none", "none", "silencer01_ar", "none"], "none", "none");
  agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF(undefined, undefined, weapon, "smoke_grenade_mp", 5);
}

_id_3AF43B43F5A74CD9(location, numagents, groupname, _id_7D97C0571433F835) {
  level endon("game_ended");
  wait 35;
  agents = [];
  _id_CF2FF249C028B242 = _id_48814951E916AF89::_id_AB14D6652E44FDA0(numagents, level.spawnset["guard"], 3);
  _id_CF2FF249C028B242._id_083C3368707C68E6 = "Helicopter";

  while(!isDefined(agents) || agents.size == 0) {
    agents = _id_48814951E916AF89::_id_77ACC10C4823DD8A(numagents, location, "high", "mission", "trapWave3", groupname, undefined, 0, self.node._id_B205D90302DA2F07, undefined, undefined, undefined, _id_CF2FF249C028B242);

    if(isDefined(agents) && agents.size != 0) {
      break;
    }

    wait 1;
  }

  self._id_E4B11D6C6E0CF57C = agents;

  foreach(agent in agents) {
    _id_371B4C2AB5861E62::_id_58AAB2EDAEC2599F(agent, "dmzTask_setupThirdWaveAgent", ::_id_A1F4D17456E2A3CA);

    if(isagent(agent))
      _id_A1F4D17456E2A3CA(agent);
  }
}

_id_1939C892064FCC20(agents, location, _id_7D97C0571433F835) {
  _id_7D97C0571433F835 = !isDefined(_id_7D97C0571433F835) || _id_7D97C0571433F835;

  foreach(agent in agents) {
    if(!isDefined(agent)) {
      continue;
    }
    if(_id_7D97C0571433F835) {
      if(isagent(agent))
        _id_942195A20BD3495B(agent);

      _id_371B4C2AB5861E62::_id_58AAB2EDAEC2599F(agent, "dmzTask_overrideBoss", ::_id_942195A20BD3495B);
      _id_7D97C0571433F835 = 0;
    } else {
      if(isagent(agent))
        _id_DA2B83358074ACB8(agent);

      _id_371B4C2AB5861E62::_id_58AAB2EDAEC2599F(agent, "dmzTask_overrideReinforcementAgent", ::_id_DA2B83358074ACB8);
    }

    thread _id_120270BD0A747A35::_id_A5117518725DA028(agent, location);
    self.agents[self.agents.size] = agent;
  }
}

_id_8E59903830E24C80(a, b) {
  _id_96FB76C792E9F0EC = 1000000;
  _id_414F1189604255F3 = 1000000;

  foreach(player in level.players) {
    _id_96FB76C792E9F0EC = min(_id_96FB76C792E9F0EC, distance(player.origin, a.origin));
    _id_414F1189604255F3 = min(_id_414F1189604255F3, distance(player.origin, b.origin));
  }

  return _id_96FB76C792E9F0EC > _id_414F1189604255F3;
}

_id_3D5F26CE20A7FB6E(location, _id_193413008FE594EC, _id_B91C2D6441FBA51C) {
  angle = _id_193413008FE594EC / _id_B91C2D6441FBA51C * 360;
  return (location[0] + cos(angle) * 25, location[1] + sin(angle) * 25, location[2]);
}

_id_8B3D13F0D1A8607D(_id_276AC5E84835EA87) {
  locations = [];

  foreach(node in _id_276AC5E84835EA87._id_E2CD8AA8B46D18AC) {
    if(!istrue(node._id_3D9512B73BDC1514))
      locations[locations.size] = node;
  }

  return locations;
}

_id_DA2B83358074ACB8(agent) {
  weapon = scripts\engine\utility::random(["brloot_weapon_sm_uzulu_epic", "brloot_weapon_ar_mike4_rare"]);
  agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF("body_mp_eastern_nikto_2_1", "head_mp_eastern_nikto_3_1", level.br_lootiteminfo[weapon].fullweaponobj, "smoke_grenade_mp");

  if(randomfloat(1) > 0.3)
    _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "dropWeapon", 0);

  if(randomfloat(1) > 0)
    _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "dropBackpack", 0);
}

_id_942195A20BD3495B(agent) {
  weapon = scripts\engine\utility::random(["brloot_weapon_sm_uzulu_epic", "brloot_weapon_ar_mike4_rare"]);
  _id_371B4C2AB5861E62::_id_1828F1E20E52B418(agent);
  agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF(undefined, undefined, level.br_lootiteminfo[weapon].fullweaponobj);

  if(randomfloat(1) > 0.3)
    _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "dropWeapon", 0);

  if(randomfloat(1) > 0)
    _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "dropBackpack", 0);
}

_id_BB2CA071F1918797(trigger, radius) {
  level endon("game_ended");
  self endon("cache_unlocked");
  self._id_78122E18403A8DC4 = [];
  self._id_C72C79B235E12114 = [];

  for(;;) {
    trigger waittill("trigger", player);

    if(!isPlayer(player) || scripts\engine\utility::array_contains(self._id_78122E18403A8DC4, player)) {
      continue;
    }
    if(!scripts\engine\utility::array_contains(self._id_C72C79B235E12114, player.team))
      self._id_C72C79B235E12114[self._id_C72C79B235E12114.size] = player.team;

    self._id_78122E18403A8DC4 = scripts\engine\utility::array_add(self._id_78122E18403A8DC4, player);
    thread _id_984758C25DBCD3EE(trigger, player, radius);
  }
}

_id_984758C25DBCD3EE(trigger, player, radius) {
  while(isDefined(player) && isalive(player) && isDefined(self._id_B038ED928EC17A81.trigger) && distance(trigger.origin, player.origin) < radius + 100)
    wait 0.2;

  self._id_78122E18403A8DC4 = scripts\engine\utility::array_remove(self._id_78122E18403A8DC4, player);
}

play_spotrep_capture_sfx(progress, team) {
  if(!isDefined(self.lastsfxplayedtime))
    self.lastsfxplayedtime = gettime();

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    _id_C3DDFB0EAA8F761C = "";
    progress = int(floor(progress * 10));
    _id_C3DDFB0EAA8F761C = "mp_dom_capturing_tick_0" + progress;
    self playsoundtoteam(_id_C3DDFB0EAA8F761C, team);
  }
}