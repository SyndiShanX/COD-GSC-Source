/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7f2fd7fc559755e4.gsc
***********************************************/

onplayerconnect() {
  for(;;) {
    level waittill("connected", player);
    player.numareas = 0;
    player thread _id_6D7327642515D1BB();
  }
}

_id_6176A97040B8CA67(trigger) {
  self.numareas++;

  if(self.numareas == 1)
    thread _id_6D7327642515D1BB();
}

_id_421BB85F5CBFDA96(trigger) {
  self.numareas--;

  if(self.numareas != 0) {
    return;
  }
  self._id_D60E12EBA99F3BC4 = 0;
  self notify("leftTrigger");

  if(isDefined(self.radiationoverlay))
    self.radiationoverlay fadeoutblackout(0.1, 0);
}

_id_9951FC0A61ED02DE(_id_AB98CD0C6E2F21F2, _id_C73348459BE85799, _id_FF3595D54DDB65F5) {
  self endon("disconnect");
  self notify("radiation_playRadTickSound");
  self endon("radiation_playRadTickSound");
  level endon("game_ended");
  _id_4CF58793CC4F1AD6 = self;

  if(isDefined(_id_AB98CD0C6E2F21F2) && isDefined(_id_C73348459BE85799))
    self setsoundsubmix("cp_raid_radioactive_poison", _id_AB98CD0C6E2F21F2, _id_C73348459BE85799);

  for(;;) {
    self playsoundtoplayer("cp_raid4_geiger_counter_tick", _id_4CF58793CC4F1AD6);
    wait(_id_FF3595D54DDB65F5);
  }
}

_id_433E164C70E2029D(_id_4CF58793CC4F1AD6) {
  self endon("stop_radiation_soundWatcher");
  self endon("death_or_disconnect");
  self endon("game_ended");

  if(istrue(self._id_D60E12EBA99F3BC4 > 0)) {
    if(istrue(self._id_D60E12EBA99F3BC4 < 20)) {
      self setsoundsubmix("cp_raid_radioactive_poison", 2, 0.2);

      while(istrue(self._id_D60E12EBA99F3BC4 < 20)) {
        self playsoundtoplayer("cp_raid4_geiger_counter_tick", _id_4CF58793CC4F1AD6);
        wait(randomfloatrange(1.5, 2));
      }
    }

    if(istrue(self._id_D60E12EBA99F3BC4 < 40)) {
      self setsoundsubmix("cp_raid_radioactive_poison", 2, 0.4);
      self playLoopSound("cp_raid4_warhead_radiation_lp");

      while(istrue(self._id_D60E12EBA99F3BC4 < 40)) {
        self playsoundtoplayer("cp_raid4_geiger_counter_tick", _id_4CF58793CC4F1AD6);
        wait(randomfloatrange(0.8, 1.2));
      }
    }

    if(istrue(self._id_D60E12EBA99F3BC4 < 60)) {
      self setsoundsubmix("cp_raid_radioactive_poison", 2, 0.6);

      while(istrue(self._id_D60E12EBA99F3BC4 < 60)) {
        self playsoundtoplayer("cp_raid4_geiger_counter_tick", _id_4CF58793CC4F1AD6);
        wait(randomfloatrange(0.5, 0.8));
      }
    }

    if(istrue(self._id_D60E12EBA99F3BC4 < 80)) {
      self setsoundsubmix("cp_raid_radioactive_poison", 4, 0.8);

      while(istrue(self._id_D60E12EBA99F3BC4 < 80)) {
        self playsoundtoplayer("cp_raid4_geiger_counter_tick", _id_4CF58793CC4F1AD6);
        wait(randomfloatrange(0.3, 0.5));
      }
    }

    if(istrue(self._id_D60E12EBA99F3BC4 < 100)) {
      self setsoundsubmix("cp_raid_radioactive_poison", 4, 1);

      while(istrue(self._id_D60E12EBA99F3BC4 < 80)) {
        self playsoundtoplayer("cp_raid4_geiger_counter_tick", _id_4CF58793CC4F1AD6);
        wait 0.2;
      }
    }

    if(istrue(self._id_D60E12EBA99F3BC4 >= 100)) {
      self playsoundtoplayer("cp_raid4_warhead_radiation_stack_alert_lvl5", _id_4CF58793CC4F1AD6);
      self playsoundtoplayer("cp_raid4_warhead_radiation_stack_lvl5_swt", _id_4CF58793CC4F1AD6);

      while(istrue(self._id_D60E12EBA99F3BC4 >= 100)) {
        self playsoundtoplayer("cp_raid4_geiger_counter_tick", _id_4CF58793CC4F1AD6);
        wait 0.1;
      }
    }
  }
}

_id_E071D94D339BCB28(_id_4CF58793CC4F1AD6) {
  self endon("stop_radiation_soundWatcher");
  self notify("radiation_soundWatcher");
  self endon("radiation_soundWatcher");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    waittime = 0.1;

    if(istrue(self._id_D60E12EBA99F3BC4 > 0)) {
      if(self._id_D60E12EBA99F3BC4 < 20 && self._id_D60E12EBA99F3BC4 > 0)
        waittime = randomfloatrange(1.5, 2);

      if(self._id_D60E12EBA99F3BC4 < 40 && self._id_D60E12EBA99F3BC4 >= 20)
        waittime = randomfloatrange(0.8, 1.2);

      if(self._id_D60E12EBA99F3BC4 < 60 && self._id_D60E12EBA99F3BC4 >= 40)
        waittime = randomfloatrange(0.5, 0.8);

      if(self._id_D60E12EBA99F3BC4 < 80 && self._id_D60E12EBA99F3BC4 >= 60)
        waittime = randomfloatrange(0.3, 0.5);

      if(self._id_D60E12EBA99F3BC4 < 100 && self._id_D60E12EBA99F3BC4 >= 80)
        waittime = 0.2;

      if(istrue(self._id_D60E12EBA99F3BC4 >= 100))
        waittime = 0.1;

      self playsoundtoplayer("cp_raid4_geiger_counter_tick", _id_4CF58793CC4F1AD6);
    } else
      waittime = 0.1;

    wait(waittime);
  }
}

_id_8BF2A5E6474828A2() {
  self notify("radiation_watchForAntidoteApplied");
  self endon("radiation_watchForAntidoteApplied");

  for(;;) {
    self waittill("antidote_applied");
    self._id_BEB14E3C966E001D = 1;
    _id_2B2F2B3CC2194C30();
    self._id_BEB14E3C966E001D = undefined;
    self notify("antidoteEnded");
  }
}

_id_6D7327642515D1BB() {
  self endon("death_or_disconnect");
  self endon("game_ended");

  if(!isDefined(self._id_D60E12EBA99F3BC4))
    self._id_D60E12EBA99F3BC4 = 0;

  thread _id_8BF2A5E6474828A2();

  for(;;) {
    if(istrue(self._id_BEB14E3C966E001D)) {
      waitframe();
      continue;
    }

    self._id_D60E12EBA99F3BC4++;

    switch (self._id_D60E12EBA99F3BC4) {
      case 1:
        self.radiationsound = "item_geigercouner_level2";
        break;
      case 2:
        self.radiationsound = "item_geigercouner_level3";
        break;
      case 3:
        self.radiationsound = "item_geigercouner_level3";
        thread _id_D826BB7D0133DA0C();
        break;
      case 4:
        self.radiationsound = "item_geigercouner_level4";
        thread _id_D826BB7D0133DA0C();
        break;
      case 5:
        self.radiationsound = "item_geigercouner_level4";
        thread _id_D826BB7D0133DA0C();
        break;
      case 10:
      case 9:
      case 8:
      case 7:
        break;
    }

    wait 0.2;
  }
}

_id_A120F77E1E2E2A2C() {
  self iprintln(" applying Antidote in 5 seconds ! ");
  wait 5;
  self iprintln(" applying Antidote! ");
  self notify("antidote_applied");
}

_id_61812FA9A3F898F5() {
  self endon("death_or_disconnect");
  self endon("game_ended");
  self endon("leftTrigger");
  self notify("radiation_blackout_gradual");
  self endon("radiation_blackout_gradual");

  if(!isDefined(self.radiationoverlay)) {
    self.radiationoverlay = newclienthudelem(self);
    self.radiationoverlay.x = 0;
    self.radiationoverlay.y = 0;
    self.radiationoverlay setshader("black", 640, 480);
    self.radiationoverlay.alignx = "left";
    self.radiationoverlay.aligny = "top";
    self.radiationoverlay.horzalign = "fullscreen";
    self.radiationoverlay.vertalign = "fullscreen";
    self.radiationoverlay.alpha = 0;
  }

  _id_9D575B46AA2771B0 = 1;
  _id_EA06B331E1F4081A = 2;
  _id_8237EACF859DFB80 = 0;
  _id_0488CF627600F486 = 1.1;
  _id_387334F9BF4CD1C5 = 1;
  _id_E2209E013BA9B457 = 100;
  fraction = 0;

  if(!isDefined(self._id_D60E12EBA99F3BC4))
    self._id_D60E12EBA99F3BC4 = 0;

  for(;;) {
    _id_67FEC5F745DE9AE8 = _id_E2209E013BA9B457 - _id_387334F9BF4CD1C5;
    fraction = (self._id_D60E12EBA99F3BC4 - _id_387334F9BF4CD1C5) / _id_67FEC5F745DE9AE8;

    if(fraction < 0)
      fraction = 0;
    else if(fraction > 1)
      fraction = 1;

    _id_61627E6F9FF7862F = _id_EA06B331E1F4081A - _id_9D575B46AA2771B0;
    length = _id_9D575B46AA2771B0 + _id_61627E6F9FF7862F * (1 - fraction);
    _id_58373CC29306836D = _id_0488CF627600F486 - _id_8237EACF859DFB80;
    alpha = _id_8237EACF859DFB80 + _id_58373CC29306836D * fraction;
    _id_A8C0283B948A1EBD = fraction * 0.5;

    if(fraction == 1) {
      wait 0.05;
      continue;
    }

    duration = length / 2;
    self.radiationoverlay fadeinblackout(duration, alpha);
    wait(fraction * 0.5);
  }
}

_id_D826BB7D0133DA0C() {
  self endon("death_or_disconnect");
  self endon("game_ended");
  self endon("leftTrigger");

  if(!isDefined(self.radiationoverlay)) {
    self.radiationoverlay = newclienthudelem(self);
    self.radiationoverlay.x = 0;
    self.radiationoverlay.y = 0;
    self.radiationoverlay setshader("black", 640, 480);
    self.radiationoverlay.alignx = "left";
    self.radiationoverlay.aligny = "top";
    self.radiationoverlay.horzalign = "fullscreen";
    self.radiationoverlay.vertalign = "fullscreen";
    self.radiationoverlay.alpha = 0;
  }

  _id_9D575B46AA2771B0 = 1;
  _id_EA06B331E1F4081A = 2;
  _id_8237EACF859DFB80 = 0.9;
  _id_0488CF627600F486 = 1;
  _id_387334F9BF4CD1C5 = 69;
  _id_E2209E013BA9B457 = 100;
  fraction = 0;

  for(;;) {
    while(self._id_D60E12EBA99F3BC4 > 1) {
      _id_67FEC5F745DE9AE8 = _id_E2209E013BA9B457 - _id_387334F9BF4CD1C5;
      fraction = (self._id_D60E12EBA99F3BC4 - _id_387334F9BF4CD1C5) / _id_67FEC5F745DE9AE8;

      if(fraction < 0)
        fraction = 0;
      else if(fraction > 1)
        fraction = 1;

      _id_61627E6F9FF7862F = _id_EA06B331E1F4081A - _id_9D575B46AA2771B0;
      length = _id_9D575B46AA2771B0 + _id_61627E6F9FF7862F * (1 - fraction);
      _id_58373CC29306836D = _id_0488CF627600F486 - _id_8237EACF859DFB80;
      alpha = _id_8237EACF859DFB80 + _id_58373CC29306836D * fraction;
      _id_A8C0283B948A1EBD = fraction * 0.5;

      if(fraction == 1) {
        break;
      }

      duration = length / 2;
      self.radiationoverlay fadeinblackout(duration, alpha);
      self.radiationoverlay fadeoutblackout(duration, _id_A8C0283B948A1EBD);
      wait(fraction * 0.5);
    }

    if(fraction == 1) {
      break;
    }

    if(self.radiationoverlay.alpha != 0)
      self.radiationoverlay fadeoutblackout(1, 0);

    wait 0.05;
  }

  self.radiationoverlay fadeinblackout(2, 0);
}

fadeinblackout(duration, alpha) {
  self fadeovertime(duration);
  self.alpha = alpha;
  wait(duration);
}

fadeoutblackout(duration, alpha) {
  self fadeovertime(duration);
  self.alpha = alpha;
  wait(duration);
}

_id_2B2F2B3CC2194C30() {
  self._id_BEB14E3C966E001D = 1;
  thread _id_FE49754C00B491DE();
  _id_565E186323A0642C(1);
  thread _id_34C57016C836D9B0();
  return 1;
}

_id_34C57016C836D9B0() {
  self endon("disconnect");
  wait 15;
  _id_5083FF4D159A8C10();
}

_id_FE49754C00B491DE() {
  self notify("antidoteStart");
  self._id_FD9AF106042E49BD = 1;
  self notify("force_regeneration");
  thread _id_183CF3AD62921106();
  thread _id_F9934E3F92AB3751(0.5, 0.2);
  _id_F28CBA6BAF17D9DA();
}

_id_F9934E3F92AB3751(_id_A274FF78F6BE5BE1, _id_3BCD7E754EE4931D) {
  self notify("antidote_visionSetsPainSurge");
  self endon("antidote_visionSetsPainSurge");
  self._id_5CD1342D8FD3DD61 = 1;
  self earthquakeforplayer(0.3, _id_A274FF78F6BE5BE1, self.origin, 50);
  self visionsetnakedforplayer("battlerage-low-health", _id_A274FF78F6BE5BE1);
  wait(_id_3BCD7E754EE4931D);
  self._id_5CD1342D8FD3DD61 = 0;
  self playlocalsound("plr_breath_rage");
  self setscriptablepartstate("battleRageVfx", "vfx_start", 0);
  _id_5EA40841AAFD4EDA(0.5, 0.5);
}

_id_F28CBA6BAF17D9DA() {
  scripts\cp\utility::giveperk("specialty_blastshield");
  scripts\cp\utility::giveperk("specialty_tac_resist");
  scripts\cp\utility::giveperk("specialty_hustle");
  scripts\cp\utility::giveperk("specialty_fastcrouchmovement");
  scripts\cp\utility::giveperk("specialty_stalker");
  scripts\cp\utility::giveperk("specialty_fastreload");
  scripts\cp\utility::giveperk("specialty_tactical_recon");
  scripts\cp\utility::giveperk("specialty_warhead");
  scripts\cp\utility::giveperk("specialty_quickswap");
  scripts\cp\utility::giveperk("specialty_pistoldraw");
  scripts\cp\utility::giveperk("specialty_fastoffhand");
  scripts\cp\utility::giveperk("specialty_fastreload");
  scripts\cp\utility::giveperk("specialty_reducedsway");
}

_id_A693667C8046BE19() {
  _id_6E09A830FAB9468F::removeperk("specialty_blastshield");
  _id_6E09A830FAB9468F::removeperk("specialty_tac_resist");
  _id_6E09A830FAB9468F::removeperk("specialty_hustle");
  _id_6E09A830FAB9468F::removeperk("specialty_fastcrouchmovement");
  _id_6E09A830FAB9468F::removeperk("specialty_stalker");
  _id_6E09A830FAB9468F::removeperk("specialty_fastreload");
  _id_6E09A830FAB9468F::removeperk("specialty_tactical_recon");
  _id_6E09A830FAB9468F::removeperk("specialty_warhead");
  _id_6E09A830FAB9468F::removeperk("specialty_quickswap");
  _id_6E09A830FAB9468F::removeperk("specialty_pistoldraw");
  _id_6E09A830FAB9468F::removeperk("specialty_fastoffhand");
  _id_6E09A830FAB9468F::removeperk("specialty_fastreload");
  _id_6E09A830FAB9468F::removeperk("specialty_reducedsway");
}

_id_183CF3AD62921106() {
  self endon("antidoteEnded");
  self endon("death");

  for(;;) {
    wait 0.1;
    self refreshsprinttime();
  }
}

_id_5083FF4D159A8C10() {
  self notify("antidoteEnded");
  _id_F0077CD971D9D96A();
  self._id_BEB14E3C966E001D = undefined;
  _id_A693667C8046BE19();
  _id_565E186323A0642C(0);
  self notify("can_use_mask_now");
}

_id_F0077CD971D9D96A() {
  self setscriptablepartstate("battleRageVfx", "off", 0);
  self visionsetnakedforplayer("", 0.5);
}

_id_565E186323A0642C(_id_DE0C04C7F580D2F7) {
  if(_id_DE0C04C7F580D2F7) {
    self._id_EAA417C82FC6F913 = ::_id_E213A2BC26C02154;
    self._id_71C054A8DF6F6E2B = ::_id_4C948FBDE3B45F80;
    self._id_50FBC0F48CCFE94E = ::_id_893044B6F4E776A1;
  } else {
    self._id_EAA417C82FC6F913 = undefined;
    self._id_71C054A8DF6F6E2B = undefined;
    self._id_50FBC0F48CCFE94E = undefined;
  }
}

_id_E213A2BC26C02154() {
  _id_5EA40841AAFD4EDA(0.5, 0.5);
}

_id_893044B6F4E776A1() {
  _id_5EA40841AAFD4EDA(0.5, 0.5);
}

_id_4C948FBDE3B45F80() {
  _id_5EA40841AAFD4EDA(0.5, 0.5);
}

_id_B9D1DCA78C6CE9D9() {
  _id_5EA40841AAFD4EDA(0.5, 0.5);
}

_id_5EA40841AAFD4EDA(_id_D64FCAAA5C3DDA68, _id_E477D587907EACB9) {
  if(self._id_5CD1342D8FD3DD61)
    return 0;

  if(self.health <= 0) {
    return;
  }
  _id_99E1809851C25F06 = self.health / self.maxhealth;

  if(_id_99E1809851C25F06 < 0.9)
    self visionsetnakedforplayer("battlerage-low-health", _id_D64FCAAA5C3DDA68);

  if(_id_99E1809851C25F06 >= 0.9)
    self visionsetnakedforplayer("battlerage-full-health", _id_E477D587907EACB9);
}

_id_550B3495A71687C3() {
  thread _id_7759FD7EFE801A64();
  scripts\engine\utility::flag_set("antidote_pickedup");
}

_id_3182E44BB20CC5AF(_id_9B1941CB7354665E) {
  _id_69E96A4CAA72D794 = self;
  partname = _id_69E96A4CAA72D794 _meth_90069777043E7833()[0];
  _id_69E96A4CAA72D794 setscriptablepartstate(partname, _id_9B1941CB7354665E);
}

_id_7759FD7EFE801A64() {
  if(!isDefined(level.objectives)) {
    level.objectives = [];
    level.objectives["allies"] = [];
    level.objectives["axis"] = [];
    level.objectives["none"] = [];
  }

  level._id_211D8FB2DF2498AE = 1;
  level._id_23B6AEBD7CA47050 = [];
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("nuke_carrier", ["cp_munitions", "ads", "fire", "weapon_switch", "offhand_weapons", "offhand_primary_weapons", "offhand_secondary_weapons", "killstreaks", "supers", "prone", "melee", "sprint"]);
  level._id_79EB0B188D3AE900 = getEntArray("nuke_withdraw_crate", "targetname");
  level._id_EAD897F6345A60BC = [];

  foreach(index, _id_A89690B7AF27B827 in level._id_79EB0B188D3AE900) {
    if(int(_id_A89690B7AF27B827.script_noteworthy) == level._id_211D8FB2DF2498AE) {
      if(!isDefined(level._id_EAD897F6345A60BC[level._id_211D8FB2DF2498AE]))
        level._id_EAD897F6345A60BC[level._id_211D8FB2DF2498AE] = [];

      level._id_EAD897F6345A60BC[level._id_211D8FB2DF2498AE] = scripts\engine\utility::array_add(level._id_EAD897F6345A60BC[level._id_211D8FB2DF2498AE], _id_A89690B7AF27B827);
    }
  }

  level._id_96C4EC15F6D0210E = getEntArray("nuke_deposit_crate", "targetname");
  level._id_D526C84266C6DBB7 = [];
  crate = scripts\engine\utility::random(level._id_EAD897F6345A60BC[level._id_211D8FB2DF2498AE]);
  id = 0;
  level._id_26B757D7E7CB09E1 = ["offhand_2h_wm_nuke_core_v0", "offhand_2h_wm_nuke_core_v0", "offhand_2h_wm_nuke_core_v0"];
  level._id_53EE8A753A8C3E86 = [];
  level._id_53EE8A753A8C3E86["tag_origin_nukecore_blue"] = "brloot_elite_arrow_beryllium";
  level._id_53EE8A753A8C3E86["tag_origin_nukecore_green"] = "brloot_elite_arrow_tritium";
  level._id_53EE8A753A8C3E86["tag_origin_nukecore_red"] = "brloot_elite_arrow_plutonium";
  level._id_C2658E4099393A71 = scripts\engine\utility::getStructArray("nuke_withdraw_reference", "targetname");

  if(getdvarint("dvar_E6D869A47947B887", 1)) {
    level._id_FF075601AF048EEC = scripts\engine\utility::getclosest(crate.origin, level._id_C2658E4099393A71);
    level._id_F39F83F75261142C = _id_36C40EB9B7EAA034(level._id_FF075601AF048EEC);
  } else {
    foreach(_id_150804D061D660CE in level._id_C2658E4099393A71) {
      _id_150804D061D660CE._id_6C71B524B452342A = _id_36C40EB9B7EAA034(_id_150804D061D660CE);

      if(getdvarint("dvar_E6D869A47947B887", 1) == level._id_23B6AEBD7CA47050.size) {
        break;
      }
    }
  }

  visuals[id] = level._id_F39F83F75261142C;
  _id_F167A595131CCF58 = spawn("script_model", visuals[id].origin, 0, 32, 128);

  if(int(crate.script_noteworthy) == level._id_211D8FB2DF2498AE) {
    crate.curorigin = crate.origin;
    crate.offset3d = (0, 0, 16);
    crate.type = "bombDeposit";
    _id_2DD8B8E19A6AF432 = 0;

    if(getdvarint("dvar_3B9202E5E20F6322", 0))
      _id_2DD8B8E19A6AF432 = 1;

    crate _id_6B18C507926DD700::requestid(1, 0, 30, 0, undefined, undefined, !_id_2DD8B8E19A6AF432);
    crate _id_6B18C507926DD700::setobjectivestatusicons("waypoint_bomb");
    crate _id_6B18C507926DD700::setvisibleteam("any");
    level._id_2DFA52A052B72AFA = crate;

    if(istrue(_id_2DD8B8E19A6AF432))
      objective_setspecialobjectivedisplay(crate.objidnum, 1);

    _id_F167A595131CCF58 linkTo(visuals[id]);
    _id_F167A595131CCF58.linktoenabledflag = 1;
    _id_F167A595131CCF58.baseorigin = _id_F167A595131CCF58.origin;
    _id_F167A595131CCF58.no_moving_platfrom_unlink = 1;
    _id_F167A595131CCF58.usetype = 1;
    _id_F167A595131CCF58 makeusable();
    _id_F167A595131CCF58 _meth_DFB78B3E724AD620(1);
    _id_F167A595131CCF58 setCursorHint("HINT_BUTTON");
    _id_F167A595131CCF58 setHintString(&"WEAPON/PICKUP_MISSILE_WARHEAD");
    _id_F167A595131CCF58 setusepriority(-4);
    _id_F167A595131CCF58 sethintonobstruction("show");
    level._id_D526C84266C6DBB7[id] = _id_6B18C507926DD700::createcarryobject("neutral", _id_F167A595131CCF58, visuals, (0, 0, 16), undefined, undefined);
    level._id_D526C84266C6DBB7[id].origin = level._id_D526C84266C6DBB7[id].curorigin;
    _id_479E458F6F530F0D::_id_F0D61E14DFDE9CCD(level._id_D526C84266C6DBB7[id]);
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(level._id_D526C84266C6DBB7[id].objidnum);
    objective_state(level._id_D526C84266C6DBB7[id].objidnum, "active");
    level._id_D526C84266C6DBB7[id].cancontestclaim = 1;
    level._id_D526C84266C6DBB7[id].stalemate = 0;
    level._id_D526C84266C6DBB7[id].wasstalemate = 1;
    level._id_D526C84266C6DBB7[id] _id_6B18C507926DD700::allowuse("any");
    level._id_D526C84266C6DBB7[id].curprogress = 0;
    level._id_D526C84266C6DBB7[id].usetime = 1.5;
    level._id_D526C84266C6DBB7[id].userate = 1;
    level._id_D526C84266C6DBB7[id].id = "";
    level._id_D526C84266C6DBB7[id].exclusiveuse = 1;
    level._id_D526C84266C6DBB7[id].skiptouching = 1;
    level._id_D526C84266C6DBB7[id].skipminimapids = 1;
    level._id_D526C84266C6DBB7[id].onuse = ::_id_9676B7DBDB12B1B7;
    level._id_D526C84266C6DBB7[id] _id_6B18C507926DD700::setusetime(level._id_D526C84266C6DBB7[id].usetime);
    level._id_D526C84266C6DBB7[id] _id_6B18C507926DD700::setwaitweaponchangeonuse(0);
    level._id_D526C84266C6DBB7[id].allowweapons = 1;
    level._id_D526C84266C6DBB7[id].onpickup = ::_id_0B4BD23523A0A870;
    level._id_D526C84266C6DBB7[id].ondrop = ::_id_71D2EFE1DDECCE59;
    level._id_D526C84266C6DBB7[id].firstpickup = 1;
    level._id_D526C84266C6DBB7[id]._id_A91D3DE9EA692914 = crate;
    level.bombrespawnpoint = level._id_D526C84266C6DBB7[id].visuals[id].origin;
    level.bombrespawnangles = level._id_D526C84266C6DBB7[id].visuals[id].angles;
    level._id_D526C84266C6DBB7[id].visualgroundoffset = (0, 0, 8);

    if(isent(level._id_D526C84266C6DBB7[id].visuals[id]))
      level._id_D526C84266C6DBB7[id] _id_6B18C507926DD700::_id_316D9DA870E12A03([level._id_D526C84266C6DBB7[id].visuals[id]], level._id_D526C84266C6DBB7[id].trigger, 3.0, undefined, undefined, ::_id_34A2B67CA3830426);
    else
      level._id_D526C84266C6DBB7[id] _id_6B18C507926DD700::_id_316D9DA870E12A03([], level._id_D526C84266C6DBB7[id].trigger, 3.0, 69, 0, ::_id_34A2B67CA3830426);
  }

  foreach(crate in level._id_96C4EC15F6D0210E) {
    visuals[id] = spawn("script_model", crate gettagorigin("j_ball_spawn"));
    visuals[id].angles = crate gettagangles("j_ball_spawn");
    visuals[id] setModel("tag_origin");
    visuals[id].parent = crate;
    crate _id_11811C954BBA79E3::_id_C613344C81956A3C("nuke_crate");
    visuals[id] thread _id_633165B2625DABCE();
  }
}

_id_36C40EB9B7EAA034(_id_150804D061D660CE) {
  if(!isDefined(level._id_23B6AEBD7CA47050))
    level._id_23B6AEBD7CA47050 = [];

  _id_6B9FF2CE2F598D65 = scripts\engine\utility::getStructArray("core_location_point", "targetname");
  level._id_21CC7CF44C9FAFCE = scripts\engine\utility::getclosest(_id_150804D061D660CE.origin, _id_6B9FF2CE2F598D65);
  _id_C4572C8243B206EA = scripts\engine\utility::random(level._id_26B757D7E7CB09E1);
  _id_6C71B524B452342A = spawn("script_model", _id_150804D061D660CE.origin);
  _id_6C71B524B452342A setModel(_id_C4572C8243B206EA);
  _id_6C71B524B452342A.angles = _id_150804D061D660CE.angles;
  level._id_23B6AEBD7CA47050 = scripts\engine\utility::array_add(level._id_23B6AEBD7CA47050, _id_6C71B524B452342A);
  return _id_6C71B524B452342A;
}

_id_626204CE475DD42F() {
  self endon("death");
  level endon("game_ended");
  states = ["opening", "closing", "active_and_closed", "opening", "active_and_open", "closing", "empty_and_open"];
  _id_AC0E594AC96AA3A8 = 0;

  for(;;) {
    if(_id_AC0E594AC96AA3A8 >= states.size - 1)
      _id_AC0E594AC96AA3A8 = 0;

    _id_3182E44BB20CC5AF(states[_id_AC0E594AC96AA3A8]);
    wait 5;
    _id_AC0E594AC96AA3A8++;
  }
}

_id_9676B7DBDB12B1B7(player) {}

_id_0B4BD23523A0A870(player, _id_5760E0F038D1BAA3, defused) {
  level notify("bomb_pickup");
  player playsoundtoplayer("cp_raid4_warhead_pickup", player);
  player thread _id_1E00AD569AEF9AFD();

  if(!istrue(level._id_F42F906D762287DA)) {
    if(isDefined(self._id_A91D3DE9EA692914))
      self._id_A91D3DE9EA692914 _id_6B18C507926DD700::releaseid(1);

    level._id_F42F906D762287DA = 1;
    level._id_2AEBAA33ED0079F4 = 1;

    foreach(door in level._id_6266E73962148BD0)
    _id_531C536DCD04E20F::_id_B092780F9EC4496E(door);

    _id_18A73A64992DD07D::run_spawn_module("enemy_wave_1");

    foreach(c in level._id_96C4EC15F6D0210E) {
      c.curorigin = c.origin;
      c.offset3d = (0, 0, 16);
      c.type = "bombDeposit";
      c _id_6B18C507926DD700::requestid(1, 0, 27, 1);
      c _id_6B18C507926DD700::setobjectivestatusicons("waypoint_bomb");
      c _id_6B18C507926DD700::setvisibleteam("any");
      objective_setspecialobjectivedisplay(c.objidnum, 1);
    }

    thread _id_4BB23F70102CF6BC::_id_0F5B7D094EEBD9B3(player.origin, player);
  }

  _id_2869A3A20D48E6AD = player getcurrentprimaryweapon();

  if(_id_74502A9E0EF1F19C::player_has_minigun(player)) {
    _id_74502A9E0EF1F19C::drop_minigun(player);
    player notify("switched_from_minigun");
  }

  player scripts\cp_mp\utility\inventory_utility::_giveweapon("iw9_nukecore_mp");

  if(!istrue(defused) && !isbot(player))
    player scripts\cp_mp\utility\inventory_utility::_switchtoweapon("iw9_nukecore_mp");

  team = player.pers["team"];

  if(team == "allies")
    otherteam = "axis";
  else
    otherteam = "allies";

  player.isbombcarrier = 1;

  if(!isDefined(defused)) {
    if(self.firstpickup) {
      _id_0A675744864C65C1 = "emppickup_friendly_first";
      self.firstpickup = 0;
    } else
      _id_0A675744864C65C1 = "emppickup_friendly";

    _id_4725E52B7C3AA25C = scripts\cp\cp_outline_utility::getteamdata(player.team, "players");
  }

  self.offset3d = (0, 0, 85);
  _id_6B18C507926DD700::setownerteam(team);
  _id_6B18C507926DD700::allowuse("none");
  _id_6B18C507926DD700::requestid(1, 0);
  _id_6B18C507926DD700::setobjectivestatusicons("icon_waypoint_objective_general");

  if(isDefined(self.visuals[0]))
    self.visuals[0] setasgametypeobjective();

  _id_220BE32C83520117 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  self.pingobjidnum = _id_220BE32C83520117;
  scripts\mp\objidpoolmanager::objective_add_objective(_id_220BE32C83520117, "active", self.origin);
  scripts\mp\objidpoolmanager::objective_set_play_intro(_id_220BE32C83520117, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(_id_220BE32C83520117, 0);
  _id_6B18C507926DD700::setvisibleteam("none", _id_220BE32C83520117);
  objective_setownerteam(_id_220BE32C83520117, undefined);
  _id_6B18C507926DD700::setobjectivestatusallicons("icon_waypoint_objective_general", "icon_waypoint_objective_general", undefined, _id_220BE32C83520117);
  _id_6B18C507926DD700::setobjectivestatusicons("icon_waypoint_objective_general", "icon_waypoint_objective_general");
  scripts\mp\objidpoolmanager::update_objective_setbackground(_id_220BE32C83520117, 5);
  scripts\mp\objidpoolmanager::update_objective_setbackground(self.objidnum, 5);
  player _id_3B64EB40368C1450::_id_3633B947164BE4F3("nuke_carrier", 0);
  player scripts\cp\utility::_id_4CBAED764C116A25(1);
  player.playerstreakspeedscale = -0.4;
  player _id_12E2FB553EC1605E::updatemovespeedscale();

  if(!isDefined(player._id_2C6BDB05338FD8EB))
    player._id_2C6BDB05338FD8EB = scripts\cp\utility::set_carry_item(player, "raid_nukecore");

  _id_7E2C53B0BCF117D9 = spawnStruct();
  _id_7E2C53B0BCF117D9.player = player;
  _id_7E2C53B0BCF117D9.eventname = "pickup";
  _id_7E2C53B0BCF117D9.position = player.origin;
  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_game_event", _id_7E2C53B0BCF117D9);
}

_id_B424375B0A82C968() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("bomb_planted");
  self endon("last_stand_start");
  self endon("nuke_dropped");
  thread weaponswapwatcher();

  while(isDefined(level.cyberemp.carrier) && self == level.cyberemp.carrier) {
    waitframe();

    if(self.currentprimaryweapon.basename != "iw9_nukecore_mp") {
      continue;
    }
    if(!isDefined(self.nextradarpingtime) || gettime() > self.nextradarpingtime) {
      if(istrue(level._id_AE278016E96E91F8))
        triggeroneoffradarsweep(self);
      else
        triggerportableradarping(self.origin, self, 1000);

      self.nextradarpingtime = gettime() + level.radarpingtime * 1000;
    }
  }
}

weaponswapwatcher() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("bomb_planted");
  self.showempminimap = 0;

  for(;;) {
    if(self.currentprimaryweapon.basename == "iw9_nukecore_mp") {
      if(!istrue(self.showempminimap))
        self.showempminimap = 1;
    } else if(istrue(self.showempminimap))
      self.showempminimap = 0;

    waitframe();
  }
}

_id_11C85D46CB2FFC9D(player) {
  player endon("disconnect");
  wait 2;
  player scripts\cp\utility::_id_4CBAED764C116A25(0);
}

_id_71D2EFE1DDECCE59(player) {
  self notify("nuke_dropped");
  player notify("nuke_dropped");
  player thread _id_11C85D46CB2FFC9D(player);
  player _id_3B64EB40368C1450::_id_3633B947164BE4F3("nuke_carrier", 1);
  player.playerstreakspeedscale = 0.0;
  player _id_12E2FB553EC1605E::updatemovespeedscale();
  player.isbombcarrier = undefined;

  if(isDefined(player._id_2C6BDB05338FD8EB)) {
    player scripts\cp\utility::_id_98F7CA3781DAC77C(player, player._id_2C6BDB05338FD8EB.carry_ref);
    player._id_2C6BDB05338FD8EB = undefined;
  }

  if(istrue(level.bombplanted)) {
    _id_6B18C507926DD700::setownerteam(player.team);
    _id_6B18C507926DD700::allowuse("none");
  } else {
    player playsoundtoplayer("cp_raid4_warhead_drop", player);
    self.offset3d = (0, 0, 16);
    _id_6B18C507926DD700::allowuse("any");
    _id_6B18C507926DD700::setobjectivestatusicons("icon_waypoint_escort_bomb", "icon_waypoint_escort_bomb");
    _id_6B18C507926DD700::setownerteam("neutral");
    _id_6B18C507926DD700::setvisibleteam("any");
  }

  player scripts\cp_mp\utility\inventory_utility::_takeweapon("iw9_nukecore_mp");
  player scripts\cp\cp_weapons::switchtolastweapon();
}

returnaftertime() {
  level endon("nuke_pickup");
  _id_8E53D4CA3DE8531A = 0.0;

  while(_id_8E53D4CA3DE8531A < level.idleresettime) {
    waitframe();

    if(self.ownerteam == "neutral")
      _id_8E53D4CA3DE8531A = _id_8E53D4CA3DE8531A + level.framedurationseconds;
  }

  foreach(team in level.teamnamelist)
  scripts\cp\cp_music_and_dialog::playsoundonplayers(game["bomb_dropped_sound"], team);

  _id_6B18C507926DD700::returnhome();
}

_id_34A2B67CA3830426(player) {}

_id_194432710E485F02() {
  level endon("game_ended");

  for(;;) {
    level waittill("bomb_pickup", _id_956F5CFAA1473A42);
    iprintln(" bomb was picked up. Do something now ");
    waitframe();
  }
}

_id_633165B2625DABCE() {
  self endon("death");

  if(!istrue(self._id_0E1D86A45DF92D80)) {
    self._id_0E1D86A45DF92D80 = 1;
    self makeusable();
  } else
    self _meth_DFB78B3E724AD620(1);

  self.hintstring = &"CP_RAID_COMPLEX_JUGG_MAZE/DEPOSIT_CORE";
  self setCursorHint("HINT_BUTTON");
  self sethintdisplayfov(80);
  self setuserange(65);
  self setusefov(60);
  self sethintonobstruction("show");
  self setuseholdduration("duration_short");
  self setHintString(self.hintstring);
  self setusepriority(0);
  self sethintdisplayrange(110);
  self.state = "opened";
  time = getanimlength(level.scr_anim["nuke_crate"]["nuke_open"]);
  self.parent scripts\common\anim::anim_single_solo(self.parent, "nuke_open");
  _id_6C71B524B452342A = spawn("script_model", self.parent.origin);
  _id_6C71B524B452342A setModel("offhand_2h_vm_nuke_core_v0");
  _id_6C71B524B452342A _id_11811C954BBA79E3::_id_C613344C81956A3C("ball");
  _id_6C71B524B452342A hide();

  for(;;) {
    self waittill("trigger", player);

    if(isDefined(player)) {
      if(!player scripts\cp\utility::is_valid_player()) {
        continue;
      }
      if(istrue(self._id_2EF06340D91524CC)) {
        continue;
      }
      if(istrue(player.iscarrying)) {
        continue;
      }
      if(getdvarint("dvar_BC4C3AB21E57CEB8", 0) != 0) {
        self.parent _id_11811C954BBA79E3::_id_C613344C81956A3C("nuke_crate_post_open");
        self.parent _id_D516286DFA5A786E(player, _id_6C71B524B452342A, self.parent);
        continue;
      }

      if(!istrue(player.isbombcarrier)) {
        continue;
      }
      if(isDefined(player.carryobject)) {
        player notify("force_manual_drop");
        player notify("drop_called");
        waitframe();

        foreach(_id_61B9936BD67AFC79 in level._id_D526C84266C6DBB7) {
          _id_61B9936BD67AFC79 _id_6B18C507926DD700::deleteuseobject();
          _id_61B9936BD67AFC79 _id_6B18C507926DD700::deletecarryobject();
          _id_61B9936BD67AFC79 notify("gameobject_deleted");
        }
      }

      self _meth_DFB78B3E724AD620(0);
      self makeunusable();
      self.parent _id_11811C954BBA79E3::_id_C613344C81956A3C("nuke_crate_post_open");
      self.parent _id_D516286DFA5A786E(player, _id_6C71B524B452342A, self.parent);
      level notify("core_secured");
      self.parent _id_6B18C507926DD700::releaseid(1);

      if(isDefined(self.parent.headicon) && isDefined(self.parent.headicon))
        scripts\cp\utility::ent_deleteheadicon(self.parent, self.parent.headicon);

      self.parent delete();
      _id_407E0F6FC77840B3::_id_52FABB5C93DEB661();
      level thread _id_746C1B1EC4F81AC4();
      level thread _id_4BB23F70102CF6BC::_id_D1BFBCB28C0CD76E();
      player _id_559B368F3098D38B();
      level notify("progress_level");
      self.state = "closed";
      self delete();
      return;
    }
  }
}

_id_746C1B1EC4F81AC4() {
  level endon("game_ended");

  for(_id_6EB04909CB5CA84D = getEnt("final_hallway_keypad", "script_noteworthy"); !isDefined(_id_6EB04909CB5CA84D); _id_6EB04909CB5CA84D = getEnt("final_hallway_keypad", "script_noteworthy"))
    wait 1;

  _id_6EB04909CB5CA84D makeusable();
  _id_6EB04909CB5CA84D _meth_DFB78B3E724AD620(1);
  _id_6EB04909CB5CA84D.hintstring = &"CP_RAID_COMPLEX_JUGG_MAZE/SILO_DOOR_BUTTON";
  _id_6EB04909CB5CA84D setCursorHint("HINT_BUTTON");
  _id_6EB04909CB5CA84D sethintdisplayfov(80);
  _id_6EB04909CB5CA84D setuserange(65);
  _id_6EB04909CB5CA84D setusefov(60);
  _id_6EB04909CB5CA84D sethintonobstruction("show");
  _id_6EB04909CB5CA84D setuseholdduration("duration_short");
  _id_6EB04909CB5CA84D setHintString(_id_6EB04909CB5CA84D.hintstring);
  _id_6EB04909CB5CA84D setusepriority(0);
  _id_6EB04909CB5CA84D sethintdisplayrange(210);
  _id_6EB04909CB5CA84D childthread _id_AA7A50FE613341C6();

  for(;;) {
    _id_6EB04909CB5CA84D waittill("trigger", player);
    start = getDvar("start");

    if(start == "start_airlock_door") {
      playsoundatpos(_id_6EB04909CB5CA84D.origin, "cp_raid2_keycard_door_unlocked_beep");
      wait 1.0;
      playsoundatpos(_id_6EB04909CB5CA84D.origin, "cp_raid2_keycard_door_unlocked");
      break;
    }

    if(!isDefined(level._id_2313A19F59121665) || level._id_2313A19F59121665 != player) {
      player thread scripts\cp\cp_hud_message::tutorialprint(&"CP_TRAP_ROOM/NO_KEYCARD", 4);
      playsoundatpos(_id_6EB04909CB5CA84D.origin, "cp_raid2_keycard_swipe_beep");
      wait 1;
      continue;
    } else {
      level notify("nuke_finalhallway_keycard_success", player);
      playsoundatpos(_id_6EB04909CB5CA84D.origin, "cp_raid2_keycard_door_unlocked_beep");
      wait 1.0;
      playsoundatpos(_id_6EB04909CB5CA84D.origin, "cp_raid2_keycard_door_unlocked");
      break;
    }
  }

  _id_6EB04909CB5CA84D makeunusable();
  _id_6EB04909CB5CA84D.activated = 1;

  foreach(player in level.players) {
    if(isDefined(player._id_F793C712094E383C)) {
      player scripts\cp\utility::_id_98F7CA3781DAC77C(player, player._id_F793C712094E383C.carry_ref);
      player._id_F793C712094E383C = undefined;
      _id_5BA045294C1D4D1B = "interactable_note_keycard_raid4_maze";
      _id_55C80BAE27E47104 = _id_66122A002AFF5D57::_id_F8D85C542911E3A9(player, _id_5BA045294C1D4D1B);

      if(!isDefined(_id_55C80BAE27E47104)) {
        _id_5BA045294C1D4D1B = "interactable_note_keycard_raid4_maze_2";
        _id_55C80BAE27E47104 = _id_66122A002AFF5D57::_id_F8D85C542911E3A9(player, _id_5BA045294C1D4D1B);

        if(!isDefined(_id_55C80BAE27E47104))
          return;
      }

      player _id_531CB1BE084314F7::_id_DB1DD76061352E5B(_id_55C80BAE27E47104, 1);
    }
  }

  level._id_8B27465C29D6521B = scripts\engine\utility::getStruct("door_lock_post_laser_3", "targetname");
  doors = getentitylessscriptablearray(undefined, undefined, level._id_8B27465C29D6521B.origin, 82, "door");

  if(!isDefined(level._id_D5004D58A7E1D8DE))
    level._id_D5004D58A7E1D8DE = doors;

  foreach(door in level._id_D5004D58A7E1D8DE)
  _id_531C536DCD04E20F::_id_B092780F9EC4496E(door);
}

_id_4CB96ABD2EBB6414(_id_4B3B70184EBD0AFA) {
  self _meth_DFB78B3E724AD620(0);
  self sethintinoperable(_id_4B3B70184EBD0AFA);
  wait 0.25;
  self _meth_DFB78B3E724AD620(1);
}

_id_AA7A50FE613341C6() {
  level endon("nuke_finalhallway_keycard_success");
  dist = squared(1600);

  while(!scripts\cp\utility::any_player_nearby(self.origin, dist))
    wait 0.5;

  if(scripts\engine\utility::flag_exist("flag_clear_laswell_radio")) {
    if(!scripts\engine\utility::flag("flag_clear_laswell_radio"))
      scripts\engine\utility::flag_wait("flag_clear_laswell_radio");
  }

  wait 5;
  dist = squared(700);

  while(scripts\cp\utility::any_player_nearby(self.origin, dist))
    wait 0.5;

  objindex = scripts\cp\cp_objectives::requestworldid("juggmaze_keycard");
  objective_state(objindex, "current");
  objective_onentity(objindex, self);
  objective_setzoffset(objindex, 40);
  objective_icon(objindex, "icon_waypoint_objective_general");
  objective_setminimapiconsize(objindex, "icon_small");
  objective_setshowdistance(objindex, 1);
  objective_setplayintro(objindex, 1);
  objective_sethot(objindex, 0);
  objective_setownerteam(objindex, "allies");
  objective_setbackground(objindex, 1);
  objective_setlabel(objindex, &"CP_RAID_COMPLEX_JUGG_MAZE/SILO_DOOR_BUTTON");
  thread _id_95B1794BE13D9DC8(objindex);
}

_id_95B1794BE13D9DC8(objindex) {
  level endon("game_ended");
  level waittill("nuke_finalhallway_keycard_success");
  objective_delete(objindex);
  scripts\cp\cp_objectives::freeworldidbyobjid(objindex);
}

_id_7406111D66051BBE() {
  if(isDefined(self.headicon)) {
    iprintln(" headicon forr crate already created!! ERROR");
    return;
  }

  self.headicon = scripts\cp\utility::ent_createheadicon(self, 20, "allies", "cp_tac_hud_icon_nuke", 1);
  setheadiconmaxdistance(self.headicon, 10000);
  setheadiconsnaptoedges(self.headicon, 1);
  setheadicondrawinmap(self.headicon, 1);
  removeteamfromheadiconmask(self.headicon, "allies");
}

_id_CBD254C8CF0049C2(_id_B1AD25AD91B2627D) {
  _id_B1AD25AD91B2627D endon("entitydeleted");
  self notify("nuke_updateObjectiveIcon");
  self endon("nuke_updateObjectiveIcon");
  _id_B291FA39EF7C3A62 = 0.1;

  for(;;) {
    foreach(player in level.players) {
      if(_id_467F0FDFDD155A45::gamealreadyended()) {
        foreach(guy in level.players) {
          objective_removeclientfrommask(_id_B1AD25AD91B2627D.objidnum, guy);
          return 1;
        }
      }

      if(!istrue(player istacmapactive()) || !istrue(player._id_BB67AB77A5842176)) {
        objective_removeclientfrommask(_id_B1AD25AD91B2627D.objidnum, player);
        continue;
      }

      objective_addclienttomask(_id_B1AD25AD91B2627D.objidnum, player);
    }

    wait(_id_B291FA39EF7C3A62);
  }
}

_id_2E5DA220FA07621F(_id_B1AD25AD91B2627D) {
  _id_B1AD25AD91B2627D endon("entitydeleted");
  self endon("head_icon_deleted_" + self.headicon);
  _id_B291FA39EF7C3A62 = 0.1;

  for(;;) {
    foreach(player in level.players) {
      if(_id_467F0FDFDD155A45::gamealreadyended()) {
        foreach(guy in level.players) {
          removeclientfromheadiconmask(_id_B1AD25AD91B2627D.headicon, guy);
          return 1;
        }
      }

      if(!istrue(player istacmapactive()) || !istrue(player._id_BB67AB77A5842176)) {
        removeclientfromheadiconmask(_id_B1AD25AD91B2627D.headicon, player);
        continue;
      }

      addclienttoheadiconmask(_id_B1AD25AD91B2627D.headicon, player);
    }

    wait(_id_B291FA39EF7C3A62);
  }
}

_id_674F631414D85D46() {
  _id_41F1DBEC9B231DA5();
  _id_BF5C8773B34CA653();
  _id_58D4ACED806D366F();
  _id_C63764DDE18D5697();
}

#using_animtree("script_model");

_id_41F1DBEC9B231DA5() {
  level.scr_animtree["nuke"] = #animtree;
  level.scr_anim["nuke"]["nuke_open"] = % cp_prop_nuclear_warhead_open;
  level.scr_animname["nuke"]["nuke_open"] = "cp_prop_nuclear_warhead_open";
}

opennukecrate(crate) {
  crate useanimtree(#animtree);
  crate.animname = "nuke";
  crate thread scripts\common\anim::anim_single_solo(crate, "nuke_open");
}

_id_F544E1F770400812() {
  self endon("disconnect");
  self endon("game_ended");
  self notify("radiation_runGradualEffects");
  self endon("radiation_runGradualEffects");
  self endon("end_radiation_fx");
  self clearsoundsubmix("cp_raid_radioactive_poison");

  if(!isDefined(self._id_D60E12EBA99F3BC4))
    self._id_D60E12EBA99F3BC4 = 0;

  if(!isDefined(self._id_E4D2EF4335AA8942)) {
    self._id_E4D2EF4335AA8942 = [];
    self._id_E4D2EF4335AA8942[100] = 0;
    self._id_E4D2EF4335AA8942[80] = 0;
    self._id_E4D2EF4335AA8942[60] = 0;
    self._id_E4D2EF4335AA8942[40] = 0;
    self._id_E4D2EF4335AA8942[20] = 0;
  }

  if(!isDefined(self._id_B295428FB4AA81A8)) {
    self._id_B295428FB4AA81A8 = [];
    self._id_B295428FB4AA81A8[100] = 0;
    self._id_B295428FB4AA81A8[80] = 0;
    self._id_B295428FB4AA81A8[60] = 0;
    self._id_B295428FB4AA81A8[40] = 0;
    self._id_B295428FB4AA81A8[20] = 0;
  }

  thread _id_E071D94D339BCB28(self);

  for(;;) {
    if(istrue(self._id_BEB14E3C966E001D) || !istrue(self.isbombcarrier) || istrue(self.inlaststand)) {
      if(self._id_D60E12EBA99F3BC4 == 0) {
        waitframe();
        continue;
      }

      self._id_D60E12EBA99F3BC4 = self._id_D60E12EBA99F3BC4 - 2;

      if(self._id_D60E12EBA99F3BC4 < 100 && self._id_D60E12EBA99F3BC4 >= 80 && !istrue(self._id_E4D2EF4335AA8942[100])) {
        self notify("new_radiation_stage_reached", self._id_D60E12EBA99F3BC4);
        level notify("vision_set_change_request", "", self, 1.0, "cp_jugg_maze_radial_distort_5");
        self._id_E4D2EF4335AA8942[100] = 1;
        self._id_B295428FB4AA81A8[100] = 0;
        self playsoundtoplayer("cp_raid4_warhead_radiation_stack_lvl3", self);
      }

      if(self._id_D60E12EBA99F3BC4 < 80 && self._id_D60E12EBA99F3BC4 >= 60 && !istrue(self._id_E4D2EF4335AA8942[80])) {
        self notify("new_radiation_stage_reached", self._id_D60E12EBA99F3BC4);
        level notify("vision_set_change_request", "", self, 1.0, "cp_jugg_maze_radial_distort_4");
        self._id_E4D2EF4335AA8942[80] = 1;
        self._id_B295428FB4AA81A8[80] = 0;
        self playsoundtoplayer("cp_raid4_warhead_radiation_stack_lvl3", self);
      }

      if(self._id_D60E12EBA99F3BC4 < 60 && self._id_D60E12EBA99F3BC4 >= 40 && !istrue(self._id_E4D2EF4335AA8942[60])) {
        self notify("new_radiation_stage_reached", self._id_D60E12EBA99F3BC4);
        level notify("vision_set_change_request", "", self, 1.0, "cp_jugg_maze_radial_distort_3");
        self._id_E4D2EF4335AA8942[60] = 1;
        self._id_B295428FB4AA81A8[60] = 0;
        self playsoundtoplayer("cp_raid4_warhead_radiation_stack_lvl3", self);
      }

      if(self._id_D60E12EBA99F3BC4 < 40 && self._id_D60E12EBA99F3BC4 >= 20 && !istrue(self._id_E4D2EF4335AA8942[40])) {
        self notify("new_radiation_stage_reached", self._id_D60E12EBA99F3BC4);
        level notify("vision_set_change_request", "", self, 1.0, "cp_jugg_maze_radial_distort_2");
        self._id_E4D2EF4335AA8942[40] = 1;
        self._id_B295428FB4AA81A8[40] = 0;
        self playsoundtoplayer("cp_raid4_warhead_radiation_stack_lvl2", self);
      }

      if(self._id_D60E12EBA99F3BC4 < 20 && self._id_D60E12EBA99F3BC4 > 0 && !istrue(self._id_E4D2EF4335AA8942[20])) {
        self notify("new_radiation_stage_reached", self._id_D60E12EBA99F3BC4);
        level notify("vision_set_change_request", "", self, 1.0, "cp_jugg_maze_radial_distort_1");
        self._id_E4D2EF4335AA8942[20] = 1;
        self._id_B295428FB4AA81A8[20] = 0;
        self playsoundtoplayer("cp_raid4_warhead_radiation_stack_lvl2", self);
      }

      if(self._id_D60E12EBA99F3BC4 <= 0) {
        self._id_D60E12EBA99F3BC4 = 0;
        self._id_E4D2EF4335AA8942[100] = 0;
        self._id_E4D2EF4335AA8942[80] = 0;
        self._id_E4D2EF4335AA8942[60] = 0;
        self._id_E4D2EF4335AA8942[40] = 0;
        self._id_E4D2EF4335AA8942[20] = 0;
        self._id_B295428FB4AA81A8[100] = 0;
        self._id_B295428FB4AA81A8[80] = 0;
        self._id_B295428FB4AA81A8[60] = 0;
        self._id_B295428FB4AA81A8[40] = 0;
        self._id_B295428FB4AA81A8[20] = 0;
        self notify("leftTrigger");
        thread _id_559B368F3098D38B(1, 1);

        if(isDefined(self.radiationoverlay))
          self.radiationoverlay destroy();

        self clearsoundsubmix("cp_raid_radioactive_poison");
      }

      wait 0.2;
      continue;
    }

    self._id_D60E12EBA99F3BC4++;

    if(self._id_D60E12EBA99F3BC4 >= 100) {
      if(!isDefined(self._id_FDA5FD894490C5B5))
        self._id_FDA5FD894490C5B5 = gettime();

      if(gettime() >= self._id_FDA5FD894490C5B5) {
        self dodamage(10, self.origin, undefined, undefined, "MOD_TRIGGER_HURT");
        _id_C033BF759EDE92F5();
        self._id_FDA5FD894490C5B5 = self._id_FDA5FD894490C5B5 + 5000;
      }

      self._id_D60E12EBA99F3BC4 = 100;
    }

    if(self._id_D60E12EBA99F3BC4 % 20 == 0 && self._id_D60E12EBA99F3BC4 <= 100) {
      switch (self._id_D60E12EBA99F3BC4) {
        case 20:
          if(!istrue(self._id_B295428FB4AA81A8[20])) {
            self dodamage(2, self.origin, undefined, undefined, "MOD_TRIGGER_HURT");
            _id_C033BF759EDE92F5();
            level notify("vision_set_change_request", "cp_jugg_maze_radial_distort_1", self, 1.0);
            self._id_B295428FB4AA81A8[20] = 1;
            self setsoundsubmix("cp_raid_radioactive_poison", 2, 0.2);
            self playsoundtoplayer("cp_raid4_warhead_radiation_stack_lvl1", self);
          }

          break;
        case 40:
          if(!istrue(self._id_B295428FB4AA81A8[40])) {
            self dodamage(4, self.origin, undefined, undefined, "MOD_TRIGGER_HURT");
            _id_C033BF759EDE92F5();
            level notify("vision_set_change_request", "cp_jugg_maze_radial_distort_2", self, 1.0);
            self._id_B295428FB4AA81A8[40] = 1;
            self scalesoundsubmix("cp_raid_radioactive_poison", 0.4);
            self playsoundtoplayer("cp_raid4_warhead_radiation_stack_lvl2", self);
          }

          break;
        case 60:
          if(!istrue(self._id_B295428FB4AA81A8[60])) {
            self dodamage(6, self.origin, undefined, undefined, "MOD_TRIGGER_HURT");
            _id_C033BF759EDE92F5();
            thread _id_D826BB7D0133DA0C();
            level notify("vision_set_change_request", "cp_jugg_maze_radial_distort_3", self, 1.0);
            self._id_B295428FB4AA81A8[60] = 1;
            self scalesoundsubmix("cp_raid_radioactive_poison", 0.6);
            self playsoundtoplayer("cp_raid4_warhead_radiation_stack_lvl3", self);
          }

          break;
        case 80:
          if(!istrue(self._id_B295428FB4AA81A8[80])) {
            self dodamage(8, self.origin, undefined, undefined, "MOD_TRIGGER_HURT");
            _id_C033BF759EDE92F5();
            level notify("vision_set_change_request", "cp_jugg_maze_radial_distort_4", self, 1.0);
            self._id_B295428FB4AA81A8[80] = 1;
            self scalesoundsubmix("cp_raid_radioactive_poison", 0.8);
            self playsoundtoplayer("cp_raid4_warhead_radiation_stack_lvl4", self);
          }

          break;
        case 100:
          if(!istrue(self._id_B295428FB4AA81A8[100])) {
            self dodamage(10, self.origin, undefined, undefined, "MOD_TRIGGER_HURT");
            _id_C033BF759EDE92F5();
            thread _id_D826BB7D0133DA0C();
            level notify("vision_set_change_request", "cp_jugg_maze_radial_distort_5", self, 1.0);
            self scalesoundsubmix("cp_raid_radioactive_poison", 1);
            self playsoundtoplayer("cp_raid4_warhead_radiation_stack_lvl5", self);
            self._id_B295428FB4AA81A8[100] = 1;
          }

          break;
      }
    }

    switch (self._id_D60E12EBA99F3BC4) {
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
        break;
      case 5:
        break;
      case 10:
      case 9:
      case 8:
      case 7:
        break;
    }

    wait 0.2;
  }
}

_id_559B368F3098D38B(_id_AE4236AF36E273DC, _id_AAC42BFAA1E15BBC) {
  self endon("disconnect");
  level endon("game_ended");

  if(!istrue(_id_AAC42BFAA1E15BBC))
    self notify("end_radiation_fx");

  if(isDefined(_id_AE4236AF36E273DC))
    wait(_id_AE4236AF36E273DC);

  self._id_D60E12EBA99F3BC4 = 0;
  self._id_E4D2EF4335AA8942[100] = 0;
  self._id_E4D2EF4335AA8942[80] = 0;
  self._id_E4D2EF4335AA8942[60] = 0;
  self._id_E4D2EF4335AA8942[40] = 0;
  self._id_E4D2EF4335AA8942[20] = 0;
  self._id_B295428FB4AA81A8[100] = 0;
  self._id_B295428FB4AA81A8[80] = 0;
  self._id_B295428FB4AA81A8[60] = 0;
  self._id_B295428FB4AA81A8[40] = 0;
  self._id_B295428FB4AA81A8[20] = 0;

  foreach(_id_FC0043E95242D5CB in self.visionset_stack) {
    level notify("vision_set_change_request", "", self, 1.0, _id_FC0043E95242D5CB);
    wait 1;
  }

  waitframe();
  level notify("vision_set_change_request", "", self, 1.0);
}

_id_C033BF759EDE92F5() {
  self._id_1983AF7858AA2ABA = 1;
  self._id_AB0E6A7A6909FC4D = 9;
}

#using_animtree("scriptables");

_id_BF5C8773B34CA653() {
  level.scr_animtree["nuke_crate"] = #animtree;
  level.scr_anim["nuke_crate"]["nuke_open"] = % iw9_br_core_container_open;
  level.scr_animname["nuke_crate"]["nuke_open"] = "iw9_br_core_container_open";
  level.scr_anim["nuke_crate"]["nuke_close"] = % iw9_br_core_container_close;
  level.scr_animname["nuke_crate"]["nuke_close"] = "iw9_br_core_container_close";
  level.scr_anim["nuke_crate"]["nuke_open_idle"][0] = % iw9_br_core_container_open_idle;
  level.scr_animname["nuke_crate"]["nuke_open_idle"][0] = "iw9_br_core_container_open_idle";
}

#using_animtree("script_model");

_id_58D4ACED806D366F() {
  level.scr_animtree["nuke_crate_post_open"] = #animtree;
  level.scr_anim["nuke_crate_post_open"]["nuke_store_core"] = % iw9_cp_raid4_nukecore_drop_box;
  level.scr_animname["nuke_crate_post_open"]["nuke_store_core"] = "iw9_cp_raid4_nukecore_drop_box";
  level.scr_animtree["ball"] = #animtree;
  level.scr_anim["ball"]["nuke_store_core"] = % iw9_cp_raid4_nukecore_drop_ball;
  level.scr_animname["ball"]["nuke_store_core"] = "iw9_cp_raid4_nukecore_drop_ball";
}

_id_C63764DDE18D5697() {
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_anim["player_rig"]["nuke_store_core"] = % iw9_cp_raid4_nukecore_drop_plr;
  level.scr_animname["player_rig"]["nuke_store_core"] = "iw9_cp_raid4_nukecore_drop_plr";
  level.scr_eventanim["player_rig"]["nuke_store_core"] = "nuke_store_core";
}

_id_1E00AD569AEF9AFD() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("hint_showNukeDropHint");
  self endon("hint_showNukeDropHint");
  self._id_BB67386BD1C78E34 = 1;
  scripts\cp\utility::hint_prompt("drop_warhead", 1, undefined, 1);
  self waittill("nuke_dropped");
  scripts\cp\utility::_id_C2963CDB537E31A0();
  self._id_BB67386BD1C78E34 = undefined;
}

_id_D516286DFA5A786E(player, _id_6C71B524B452342A, crate) {
  level endon("game_ended");
  scenenode = spawnStruct();
  scenenode.origin = crate.origin;
  scenenode.angles = crate.angles;
  crate.scenenode = scenenode;
  self.scenenode = crate.scenenode;
  _id_6C71B524B452342A show();
  actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(player, "player_rig", 1, 1, 1);
  _id_46F153C619AC882D = scripts\cp_mp\anim_scene::anim_scene_create_actor(crate, "nuke_crate_post_open");
  _id_892C68C43AE02CE1 = scripts\cp_mp\anim_scene::anim_scene_create_actor(_id_6C71B524B452342A, "ball");
  actors = [actorplayer, _id_46F153C619AC882D, _id_892C68C43AE02CE1];
  started = crate scripts\cp_mp\anim_scene::anim_scene(actors, "nuke_store_core", 1, 1);
  _id_6C71B524B452342A delete();
}