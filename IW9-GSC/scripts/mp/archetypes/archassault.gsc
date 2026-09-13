/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\archetypes\archassault.gsc
*************************************************/

applyarchetype() {
  equipextras();
}

equipextras() {}

removearchetype() {}

auraquickswap_run() {
  self endon("death_or_disconnect");
  self endon("removeArchetype");
  self setclientomnvar("ui_aura_quickswap", 0);

  for(;;) {
    self waittill("got_a_kill");
    _id_D54EA18DC801BDF8 = scripts\common\utility::playersincylinder(self.origin, 384);

    foreach(player in _id_D54EA18DC801BDF8) {
      if(player.team != self.team) {
        continue;
      }
      player thread auraquickswap_bestowaura(self);
    }
  }
}

auraquickswap_bestowaura(player) {
  self endon("death_or_disconnect");
  self endon("giveLoadout_start");
  level endon("game_ended");

  if(self != player)
    player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_AA59CED8C6DDA32D");

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

cleanupafterplayerdeath() {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  self setclientomnvar("ui_aura_quickswap", 0);
}