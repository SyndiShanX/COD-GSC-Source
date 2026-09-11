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
  thread ref_1397e();
  return true;
}

function superdeadsilence_endsuper(var0) {
  scripts\mp\utility\perk::removeperk("specialty_quieter");
  scripts\mp\utility\perk::removeperk("specialty_no_battle_chatter");

  if(!scripts\mp\utility\game::isanymlgmatch()) {
    scripts\mp\utility\perk::removeperk("specialty_lightweight");
  }

  scripts\cp\vehicles\vehicle_compass_cp::ref_12032("super_deadsilence", self.deadsilencekills);

  if(scripts\mp\utility\game::getgametype() != "infect") {
    scripts\mp\analyticslog::logevent_fieldupgradeexpired(self, level.superglobals.staticsuperdata["super_deadsilence"].id, self.deadsilencekills, istrue(var0));
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
    var0 = scripts\mp\supers::relic_fastbleedout_returnfunc("super_deadsilence");

    if(self.deadsilencekills > var0) {
      var1 = self.deadsilencekills - var0;
      scripts\mp\supers::hide_plunderboxes("super_deadsilence", var1);
    }
  }

  var2 = scripts\mp\utility\game::unset_relic_grounded();
  var3 = 1;

  if(var2) {
    var4 = scripts\mp\supers::getcurrentsuper();

    if(istrue(var4.shouldcrossbowhitmarker)) {
      var3 = 0;
    } else {
      var4.shouldcrossbowhitmarker = 1;
    }
  }

  if(var3) {
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

function superdeadsilence_updateuistate(var0) {
  self.deadsilenceuistate = var0;
  self setclientomnvar("ui_deadsilence_overlay", var0);
}

function applyfovpresentation() {
  self endon("death_or_disconnect");
  self notify("applyFOVPresentation");
  self endon("applyFOVPresentation");
  self lerpfovbypreset("zombiedefault");
  var0 = self.super.staticdata.usetime;
  var1 = var0 - 2;
  scripts\engine\utility::ref_143bf(var1, "super_use_finished");
  self lerpfovbypreset("default_2seconds");
  self playlocalsound("deadsilence_end");
}

function ref_1397e() {
  self endon("death_or_disconnect");
  self endon("super_use_finished");
  self notify("superDeadsilence_watchForGameEnded");
  self endon("superDeadsilence_watchForGameEnded");
  level scripts\engine\utility::ref_143a5("game_ended", "prematch_cleanup");
  thread scripts\mp\supers::superusefinished();
}