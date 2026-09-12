/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\supers\super_deadsilence.gsc
***************************************************/

function superdeadsilence_beginsuper() {
  scripts\mp\utility\perk::giveperk("specialty_quieter");
  scripts\mp\utility\perk::giveperk("specialty_no_battle_chatter");

  if(!scripts\mp\utility\game::isanymlgmatch()) {
    scripts\mp\utility\perk::giveperk("specialty_lightweight");
  }

  self.deadsilencekills = 0;
  self playlocalsound("deadsilence_start");
  superdeadsilence_updateuistate(0);
  thread applyfovpresentation();
  thread ref_1397E();
  return true;
}

function superdeadsilence_endsuper(var_0) {
  scripts\mp\utility\perk::removeperk("specialty_quieter");
  scripts\mp\utility\perk::removeperk("specialty_no_battle_chatter");

  if(!scripts\mp\utility\game::isanymlgmatch()) {
    scripts\mp\utility\perk::removeperk("specialty_lightweight");
  }

  scripts\cp\vehicles\vehicle_compass_cp::ref_12032("super_deadsilence", self.deadsilencekills);

  if(scripts\mp\utility\game::getgametype() != "infect") {
    scripts\mp\analyticslog::logevent_fieldupgradeexpired(self, level.superglobals.staticsuperdata["super_deadsilence"].id, self.deadsilencekills, istrue(var_0));
  }

  thread superdeadsilence_endhudsequence();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br", "superSlotCleanUp")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("br", "superSlotCleanUp")]](self);
  }

  return false;
}

function superdeadsilence_onkill() {
  if(scripts\mp\utility\game::getgametype() != "infect") {
    scripts\mp\utility\stats::incpersstat("deadSilenceKills", 1);
    scripts\mp\supers::combatrecordsuperkill("super_deadsilence");
    self.deadsilencekills++;
    var_0 = scripts\mp\supers::relic_fastbleedout_returnfunc("super_deadsilence");

    if(self.deadsilencekills > var_0) {
      var_1 = self.deadsilencekills - var_0;
      scripts\mp\supers::hide_plunderboxes("super_deadsilence", var_1);
    }
  }

  var_2 = scripts\mp\utility\game::unset_relic_grounded();
  var_3 = 1;

  if(var_2) {
    var_4 = scripts\mp\supers::getcurrentsuper();

    if(istrue(var_4.shouldcrossbowhitmarker)) {
      var_3 = 0;
    } else {
      var_4.shouldcrossbowhitmarker = 1;
    }
  }

  if(var_3) {
    self playlocalsound("deadsilence_start");
    superdeadsilence_updateuistate(1);
    scripts\mp\supers::resetsuperusepercent();
    thread applyfovpresentation();
    return;
  }
}

function superdeadsilence_endhudsequence() {
  self endon("disconnect");
  superdeadsilence_updateuistate(2);
  wait 1;
  superdeadsilence_updateuistate(-1);
}

function superdeadsilence_updateuistate(var_0) {
  self.deadsilenceuistate = var_0;
  self setclientomnvar("ui_deadsilence_overlay", var_0);
}

function applyfovpresentation() {
  self endon("death_or_disconnect");
  self notify("applyFOVPresentation");
  self endon("applyFOVPresentation");
  self lerpfovbypreset("zombiedefault");
  var_0 = self.super.staticdata.usetime;
  var_1 = var_0 - 2;
  scripts\engine\utility::ref_143BF(var_1, "super_use_finished");
  self lerpfovbypreset("default_2seconds");
  self playlocalsound("deadsilence_end");
}

function ref_1397E() {
  self endon("death_or_disconnect");
  self endon("super_use_finished");
  self notify("superDeadsilence_watchForGameEnded");
  self endon("superDeadsilence_watchForGameEnded");
  level scripts\engine\utility::ref_143A5("game_ended", "prematch_cleanup");
  thread scripts\mp\supers::superusefinished();
}