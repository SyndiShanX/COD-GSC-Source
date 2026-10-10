/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\archetypes\archassault.gsc
****************************************************/

#using scripts\common\utility;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\points;
#namespace archassault;

function applyarchetype() {
  equipextras();
}

function equipextras() {}

function removearchetype() {}

function auraquickswap_run() {
  self endon("death_or_disconnect");
  self endon("removeArchetype");
  self setclientomnvar("ui_aura_quickswap", 0);

  while(true) {
    self waittill("got_a_kill");
    auraplayers = utility::playersincylinder(self.origin, 384);

    foreach(player in auraplayers) {
      if(player.team != self.team) {
        continue;
      }

      player thread auraquickswap_bestowaura(self);
    }
  }
}

function auraquickswap_bestowaura(player) {
  self endon("death_or_disconnect");
  self endon("giveLoadout_start");
  level endon("game_ended");

  if(self != player) {
    player thread doscoreevent(#"buff_teammate");
  }

  self setclientomnvar("ui_aura_quickswap", 1);
  giveperk("specialty_fastreload");
  self playlocalsound("mp_overcharge_on");
  thread cleanupafterplayerdeath();
  wait 5;
  self playlocalsound("mp_overcharge_off");
  self notify("removeAuraQuickswap");
  removeperk("specialty_fastreload");
  self setclientomnvar("ui_aura_quickswap", 0);
}

function cleanupafterplayerdeath() {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  self setclientomnvar("ui_aura_quickswap", 0);
}