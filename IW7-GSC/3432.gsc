/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3432.gsc
************************/

applyarchetype() {
  equipextras();
}

equipextras() {}

removearchetype() {
  self notify("removeArchetype");
}

auraquickswap_run() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  self setclientomnvar("ui_aura_quickswap", 0);
  for(;;) {
    self waittill("got_a_kill");
    foreach(var_01 in level.players) {
      if(var_01.team != self.team) {
        continue;
      }

      if(distance2dsquared(var_01.origin, self.origin) > 147456) {
        continue;
      }

      var_01 thread auraquickswap_bestowaura(self);
    }
  }
}

auraquickswap_bestowaura(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("giveLoadout_start");
  level endon("game_ended");
  if(self != param_00) {
    param_00 thread scripts\mp\utility::giveunifiedpoints("buff_teammate");
  }

  self setclientomnvar("ui_aura_quickswap", 1);
  scripts\mp\utility::giveperk("specialty_fastreload");
  self playlocalsound("mp_overcharge_on");
  thread cleanupafterplayerdeath();
  wait(5);
  self playlocalsound("mp_overcharge_off");
  self notify("removeAuraQuickswap");
  scripts\mp\utility::removeperk("specialty_fastreload");
  self setclientomnvar("ui_aura_quickswap", 0);
}

cleanupafterplayerdeath() {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  self setclientomnvar("ui_aura_quickswap", 0);
}