/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\archetypes\archassault.gsc
*************************************************/

function applyarchetype() {
  equipextras();
}

function equipextras() {}

function removearchetype() {}

function auraquickswap_run() {
  self endon("death_or_disconnect");
  self endon("removeArchetype");
  self setclientomnvar("ui_aura_quickswap", 0);

  for(;;) {
    self waittill("got_a_kill");
    var0 = scripts\common\utility::playersincylinder(self.origin, 384);

    foreach(var2 in var0) {
      if(var2.team != self.team) {
        continue;
      }

      thread auraquickswap_bestowaura(var2);
    }
  }
}

function auraquickswap_bestowaura(var0) {
  self endon("death_or_disconnect");
  self endon("giveLoadout_start");
  level endon("game_ended");

  if(self != var0) {
    var0 thread scripts\mp\utility\points::giveunifiedpoints("buff_teammate");
  }

  self setclientomnvar("ui_aura_quickswap", 1);
  scripts\mp\utility\perk::giveperk("specialty_fastreload");
  self playlocalsound("mp_overcharge_on");
  thread cleanupafterplayerdeath();
  wait 5;
  self playlocalsound("mp_overcharge_off");
  self notify("removeAuraQuickswap");
  scripts\mp\utility\perk::removeperk("specialty_fastreload");
  self setclientomnvar("ui_aura_quickswap", 0);
}

function cleanupafterplayerdeath() {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  self setclientomnvar("ui_aura_quickswap", 0);
}