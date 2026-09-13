/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\stealth\stealth_music.gsc
***************************************************/

main() {
  childthread stealth_combat_music_init();
}

stealth_combat_music_init() {
  scripts\engine\utility::flag_wait("level_stealth_initialized");
  setDvar("dvar_4A4DE8B30C5647A8", 1);
  level.music_array[0] = "a";
  level.music_array[1] = "b";
  level.music_array[2] = "c";

  if(getdvarint("dvar_F5740209893CDF46", 0) == 0) {
    level.stealth.fnthreatsightplayersightaudio = ::threat_sight_player_sight_audio;
    level notify("threat_sight_audio_enabled");
  }

  level.hvts_identified = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("stealth_music", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("stealth_music", "init")]]();
}

_id_9FF225017EF5CE19() {
  if(!isDefined(self.stealth)) {
    return;
  }
  player = self;

  if(istrue(player._id_72ABA1E496402EBF)) {
    return;
  }
  if(getdvarint("dvar_F5740209893CDF46", 0))
    player thread _id_F17FB237C7E883B2();

  player.fnstealthmusictransition = ::_id_E9C9FD46E63ABE80;
  player.stealth.fnthreatsightplayersightaudio = ::threat_sight_player_sight_audio;
  player scripts\engine\utility::ent_flag_init("player_in_combat");
  player thread scripts\stealth\player::combatstate_thread();
  player._id_72ABA1E496402EBF = 1;
  player.stealth.combatstate.maxcombatdist = 2000;
  player.stealth_combat_music_state = player.stealth.combatstate.name;
  player.stealth_combat_music_state_type = player.stealth.combatstate.type;
  player.music_last_stealth_cue = "";
}

_id_9D95291BB222AD5F(message, delay) {
  self endon(message);
  wait(delay);
  scripts\engine\utility::ent_flag_clear(message);
}

_id_E9C9FD46E63ABE80(_id_A675F64A80383D1E) {
  self notify("stealth_music_transition_cp");
  self endon("stealth_music_transition_cp");
  self endon("disconnect");

  if(!isDefined(self.stealth))
    thread scripts\stealth\player::main();

  if(istrue(level._id_C04EE29C854B01B8))
    level._id_C04EE29C854B01B8 = undefined;
  else {
    if(!isDefined(self._id_BD670C1E0F4290DA))
      self._id_BD670C1E0F4290DA = "init";

    _id_B18D3429CF88F29F = 1.0;
    _id_D51349C1F64450E3 = 0.05;

    if(!isDefined(self.stealth.music_ent))
      self.stealth.music_ent = [];

    alias = _id_A675F64A80383D1E;

    if(!isDefined(_id_A675F64A80383D1E)) {
      self setplayermusicstate("");
      self._id_BD670C1E0F4290DA = "";
      return;
    } else {
      if(_id_A675F64A80383D1E != self._id_BD670C1E0F4290DA) {
        thread _id_FD514168432A7053(alias);
        return;
      }

      self setplayermusicstate("");
      self._id_BD670C1E0F4290DA = "";
    }
  }
}

_id_FD514168432A7053(_id_F1E5DD9037C67CD6) {
  self notify("player_music_loop");
  self endon("player_music_loop");
  self endon("disconnect");

  if(self._id_BD670C1E0F4290DA != "init" && _id_F1E5DD9037C67CD6 == "")
    self setplayermusicstate("");

  self._id_BD670C1E0F4290DA = _id_F1E5DD9037C67CD6;

  if(isDefined(_id_F1E5DD9037C67CD6) && (_id_F1E5DD9037C67CD6 != "" && _id_F1E5DD9037C67CD6 != "init")) {
    self setplayermusicstate(_id_F1E5DD9037C67CD6);

    if(!istrue(level._id_4F2AB335EF95E1E3)) {
      wait 60;
      self setplayermusicstate("");
      self._id_BD670C1E0F4290DA = "";
    }
  }
}

threat_sight_player_sight_audio(_id_5A80AEB955D466DC, maxthreat, _id_67E8151F4DFC690B) {
  _id_1D73B1CAA088A858 = 180.0;
  _id_732BD773132E7010 = 0.01;
  _id_37B64319146D2F02 = 0.05;
  _id_BDD51DF6B28827EE = 0.125;
  self endon("disconnect");
  self endon("death");
  self notify("threat_sight_player_sight_audio");
  self endon("threat_sight_player_sight_audio");
  level endon("threat_sight_audio_disabled");
  aliases = ["cp_stealth_threat_low", "cp_stealth_threat_med", "cp_stealth_threat_high"];
  rumble = "damage_light";

  if(!getdvarint("dvar_21B72D8C9FF7A1B3", 0))
    maxthreat = 0;

  if(!isDefined(self.stealth.threat_sight_snd_ent) && _id_5A80AEB955D466DC && maxthreat > 0) {
    self.stealth.threat_sight_snd_ent = [];
    self.stealth.threat_sight_snd_vol = 0.0;
    self.stealth.threat_sight_snd_threat = 0.0;

    foreach(index, alias in aliases) {
      _id_D4479D622A4F5606 = spawn("script_origin", self.origin);

      if(!isPlayer(self))
        thread scripts\engine\utility::delete_on_death(_id_D4479D622A4F5606);
      else
        _id_D4479D622A4F5606 showonlytoplayer(self);

      _id_D4479D622A4F5606 linkTo(self);

      if(isPlayer(self))
        self setsoundsubmix(alias, 0, 1);

      _id_D4479D622A4F5606.isplaying = 0;
      self.stealth.threat_sight_snd_ent[alias] = _id_D4479D622A4F5606;
    }
  }

  if(isDefined(self.stealth.threat_sight_snd_ent)) {
    self.stealth.threat_sight_snd_threat = self.stealth.threat_sight_snd_threat - self.stealth.threat_sight_snd_threat * _id_BDD51DF6B28827EE;
    self.stealth.threat_sight_snd_threat = self.stealth.threat_sight_snd_threat + maxthreat * _id_BDD51DF6B28827EE;

    if(self.stealth.threat_sight_snd_threat < 0.0001)
      self.stealth.threat_sight_snd_threat = 0.0;

    maxthreat = self.stealth.threat_sight_snd_threat;
  }

  while(isDefined(self.stealth.threat_sight_snd_ent)) {
    index = 0;
    _id_CFAEEEA72851152D = 0;

    if(maxthreat > 0) {
      _id_1CDA86ECCB821EC6 = _func_8BA164C5A84FBB48(self);

      if(maxthreat < _id_37B64319146D2F02) {
        _id_2DF1B1F3E5B6238C = clamp(maxthreat, 0, _id_37B64319146D2F02);
        _id_CE432C78F5984633 = _id_2DF1B1F3E5B6238C / _id_37B64319146D2F02;
        _id_97463E5FAE955EAB = 1.0 - _id_732BD773132E7010;
        _id_11AF093D4B19EAB2 = _id_732BD773132E7010 + _id_97463E5FAE955EAB * _id_CE432C78F5984633;
        self.stealth.threat_sight_snd_vol = _id_11AF093D4B19EAB2;
      } else
        self.stealth.threat_sight_snd_vol = 1.0;
    } else {
      self.stealth.threat_sight_snd_vol = 0.0;
      self.stealth.threat_sight_snd_threat = 0.0;
    }

    self.stealth.threat_sight_snd_vol = clamp(self.stealth.threat_sight_snd_vol, 0.0, 1.0);

    foreach(alias, _id_D4479D622A4F5606 in self.stealth.threat_sight_snd_ent) {
      _id_6CCDD224B4B73694 = 1.0;

      switch (index) {
        case 0:
          if(maxthreat < 0.75)
            _id_6CCDD224B4B73694 = cos(_id_1D73B1CAA088A858 * maxthreat * 0.666);
          else
            _id_6CCDD224B4B73694 = 0.0;

          break;
        case 1:
          if(maxthreat < 0.75)
            _id_6CCDD224B4B73694 = sin(_id_1D73B1CAA088A858 * maxthreat * 0.666);
          else if(maxthreat < 1.0)
            _id_6CCDD224B4B73694 = sin(_id_1D73B1CAA088A858 * (1 - maxthreat) * 2.0);
          else
            _id_6CCDD224B4B73694 = 0.0;

          break;
        case 2:
          if(maxthreat < 0.75)
            _id_6CCDD224B4B73694 = 0.0;
          else
            _id_6CCDD224B4B73694 = cos(_id_1D73B1CAA088A858 * (1 - maxthreat) * 2.0);

          break;
      }

      vol = clamp(self.stealth.threat_sight_snd_vol * _id_6CCDD224B4B73694, 0.0, 1.0);

      if(_id_5A80AEB955D466DC) {
        _id_CFAEEEA72851152D = 1;

        if(_id_D4479D622A4F5606.isplaying == 0) {
          if(isPlayer(self))
            self setsoundsubmix(alias, 0, 1);

          _id_D4479D622A4F5606 scripts\engine\utility::delaycall(0.1, ::playloopsound, alias);
          _id_D4479D622A4F5606.isplaying = 1;
          self playrumblelooponentity(rumble);
        }

        _id_89C3E14196949443 = (vol - 1) * -1;

        if(isPlayer(self))
          self scalesoundsubmix(alias, _id_89C3E14196949443);
      } else if(_id_D4479D622A4F5606.isplaying == 1) {
        if(isPlayer(self))
          self setsoundsubmix(alias, 1, 1);

        _id_D4479D622A4F5606 scripts\engine\utility::delaycall(1, ::stoploopsound);
        _id_D4479D622A4F5606.isplaying = 0;
        self stoprumble(rumble);
      }

      index++;
    }

    if(!_id_CFAEEEA72851152D) {
      foreach(alias, _id_D4479D622A4F5606 in self.stealth.threat_sight_snd_ent) {
        if(isPlayer(self))
          self setsoundsubmix(alias, 1, 1);

        _id_D4479D622A4F5606 scripts\engine\utility::delaycall(0.9, ::stoploopsound);
        _id_D4479D622A4F5606 scripts\engine\utility::delaycall(1, ::delete);
      }

      self.stealth.threat_sight_snd_ent = undefined;
      self.stealth.threat_sight_snd_vol = undefined;
      self.stealth.threat_sight_snd_threat = undefined;
    }

    wait 0.25;
  }
}

_id_F17FB237C7E883B2() {
  level endon("kill_spotted_sound_thread");

  for(;;) {
    self waittill("stealth_hud_updated");

    if(!istrue(self._id_27C032D9C1B0D6A2)) {
      self setplayermusicstate("mx_cp_hydro_stealth_hidden");
      self._id_27C032D9C1B0D6A2 = 1;

      while(scripts\engine\utility::flag("stealth_spotted"))
        waitframe();

      self._id_27C032D9C1B0D6A2 = undefined;
    }
  }
}