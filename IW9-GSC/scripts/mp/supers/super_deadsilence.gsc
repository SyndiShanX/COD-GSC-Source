/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\supers\super_deadsilence.gsc
***************************************************/

superdeadsilence_beginsuper() {
  result = _id_0EF312894C6CAE23();
  return result;
}

_id_0EF312894C6CAE23() {
  if(getdvarint("dvar_88050A1CA3A6C70F", 0) == 1)
    return 1;

  objweapon = makeweapon("deadsilence_device_mp");
  _id_D54D53EAF955518D = scripts\cp_mp\utility\weapon_utility::_id_F19F8B4CF085ECBD(objweapon);

  if(istrue(_id_D54D53EAF955518D))
    return _id_2649CDB548D89C04();
  else
    scripts\mp\supers::refundsuper();
}

_id_2649CDB548D89C04() {
  scripts\mp\utility\perk::giveperk("specialty_quieter");
  scripts\mp\utility\perk::giveperk("specialty_no_battle_chatter");
  self.deadsilencekills = 0;
  self.super.isactive = 1;

  if(isDefined(self.pers["deadSilenceTime"]))
    self._id_2CF78151A82050FB = gettime();

  self playlocalsound("deadsilence_start");
  _id_74B851B7AA1EF32D::_id_693D12AA2C1C02C5(1, "deadSilenceUsed");
  superdeadsilence_updateuistate(0);
  _id_189B67B2735B981D::_id_55B08D6D71B41402(self, "equipment_deployed");
  thread applyfovpresentation();
  thread superdeadsilence_watchforgameended();
  agents = getaiarrayinradius(self.origin, 2048);

  foreach(agent in agents) {
    if(agent getthreatsight(self) >= 1)
      agent setthreatsight(self, 0);
  }

  scripts\cp_mp\challenges::_id_D997435895422ECC("super_deadsilence", 0);
  thread _id_43EBA8EB08BB6EDC();
  return 1;
}

superdeadsilence_endsuper(_id_FCEF8D217A441961) {
  if(getdvarint("dvar_88050A1CA3A6C70F", 0) == 1)
    return 0;

  self setscriptablepartstate("deadSilenceFX", "end", 0);
  scripts\mp\utility\perk::removeperk("specialty_quieter");
  scripts\mp\utility\perk::removeperk("specialty_no_battle_chatter");
  self.super.isactive = 0;

  if(isDefined(self.pers["deadSilenceTime"])) {
    currenttime = gettime();
    _id_57A6268FB3DF10D0 = currenttime - self._id_2CF78151A82050FB;
    scripts\mp\utility\stats::incpersstat("deadSilenceTime", _id_57A6268FB3DF10D0);
  }

  if(scripts\mp\utility\game::getgametype() != "infect")
    scripts\mp\analyticslog::logevent_fieldupgradeexpired(self, level.superglobals.staticsuperdata["super_deadsilence"].id, self.deadsilencekills, istrue(_id_FCEF8D217A441961));

  thread superdeadsilence_endhudsequence();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br", "superSlotCleanUp"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("br", "superSlotCleanUp")]](self);

  if(isDefined(self._id_1BB565E508AC38A5))
    scripts\cp_mp\challenges::_id_D997435895422ECC("super_deadsilence", 3, self._id_8C1B3C647DC1C8CA);

  return 0;
}

superdeadsilence_onkill() {
  if(getdvarint("dvar_88050A1CA3A6C70F", 0) == 1) {
    return;
  }
  if(scripts\mp\utility\game::getgametype() != "infect") {
    scripts\mp\utility\stats::incpersstat("deadSilenceKills", 1);
    scripts\mp\supers::combatrecordsuperkill("super_deadsilence");
    self.deadsilencekills++;
    _id_F8627BC73976807C = scripts\mp\supers::getcombatrecordsupermisc("super_deadsilence");

    if(self.deadsilencekills > _id_F8627BC73976807C) {
      _id_2F977E27FA739602 = self.deadsilencekills - _id_F8627BC73976807C;
      scripts\mp\supers::combatrecordsupermisc("super_deadsilence", _id_2F977E27FA739602);
    }
  }

  self playlocalsound("deadsilence_start");
  superdeadsilence_updateuistate(1);
  scripts\mp\supers::resetsuperusepercent();
  thread applyfovpresentation();
}

superdeadsilence_endhudsequence() {
  self endon("disconnect");
  superdeadsilence_updateuistate(2);
  wait 1;
  superdeadsilence_updateuistate(-1);
}

superdeadsilence_updateuistate(_id_9B1941CB7354665E) {
  self.deadsilenceuistate = _id_9B1941CB7354665E;
  self setclientomnvar("ui_deadsilence_overlay", _id_9B1941CB7354665E);
}

applyfovpresentation() {
  self endon("death_or_disconnect");
  self notify("applyFOVPresentation");
  self endon("applyFOVPresentation");
  self setscriptablepartstate("deadSilenceFX", "neutral", 0);
  waitframe();
  self lerpfovbypreset("zombiedefault");
  self playlocalsound("deadsilence_end");
  self setscriptablepartstate("deadSilenceFX", "start", 0);
  duration = self.super.staticdata.usetime;
  _id_ECF8FF7B7B97525C = duration - 2;
  scripts\engine\utility::waittill_any_timeout_no_endon_death_1(_id_ECF8FF7B7B97525C, "super_use_finished");
  self lerpfovbypreset("default_2seconds");
}

superdeadsilence_watchforgameended() {
  self endon("death_or_disconnect");
  self endon("super_use_finished");
  self notify("superDeadsilence_watchForGameEnded");
  self endon("superDeadsilence_watchForGameEnded");
  level scripts\engine\utility::waittill_any_2("game_ended", "prematch_cleanup");
  thread scripts\mp\supers::superusefinished();
}

_id_43EBA8EB08BB6EDC() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("super_use_finished");
  self._id_8C1B3C647DC1C8CA = 0;
  _id_6468F56D9F67C8BF = 39.3701;
  _id_BB9E3661D7B1FF9D = self.origin;
  _id_E48200809888835A = 0;

  while(isDefined(self.super) && self.super.isactive) {
    if(1) {
      _id_CB1505FFB6643ABE = self.origin;
      _id_E48200809888835A = _id_E48200809888835A + distance(_id_CB1505FFB6643ABE, _id_BB9E3661D7B1FF9D);
      _id_BB9E3661D7B1FF9D = _id_CB1505FFB6643ABE;
      self._id_8C1B3C647DC1C8CA = int(_func_C5CF558181E12D1F(_id_E48200809888835A / _id_6468F56D9F67C8BF));
    }

    wait 0.1;
  }
}