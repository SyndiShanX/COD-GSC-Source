/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2544.gsc
*************************************************/

_id_19C5() {
  _id_554E();
}

_id_554E() {}

_id_C474() {}

_id_1F05() {
  self endon("death_or_disconnect");
  self endon("removeArchetype");
  self setclientomnvar("ui_aura_quickswap", 0);

  for(;;) {
    self waittill("got_a_kill");
    var_0 = scripts\common\utility::_id_B7B6(self.origin, 384);

    foreach(var_2 in var_0) {
      if(var_2.team != self.team) {
        continue;
      }
      var_2 thread _id_1F04(self);
    }
  }
}

_id_1F04(var_0) {
  self endon("death_or_disconnect");
  self endon("giveLoadout_start");
  level endon("game_ended");

  if(self != var_0) {
    var_0 thread _id_0A9F::_id_7003("buff_teammate");
  }

  self setclientomnvar("ui_aura_quickswap", 1);
  scripts\mp\utility\perk::_id_6FC2("specialty_fastreload");
  self playlocalsound("mp_overcharge_on");
  thread _id_386C();
  wait 5;
  self playlocalsound("mp_overcharge_off");
  self notify("removeAuraQuickswap");
  scripts\mp\utility\perk::removeperk("specialty_fastreload");
  self setclientomnvar("ui_aura_quickswap", 0);
}

_id_386C() {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  self setclientomnvar("ui_aura_quickswap", 0);
}