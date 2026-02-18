/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\gametypes\shellshock.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\util;
#namespace shellshock;

function private autoexec __init__system__() {
  system::register(#"shellshock", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::on_start_gametype(&init);
  level.shellshockonplayerdamage = &on_damage;
}

function init() {}

function on_damage(eattacker, einflictor, weapon, smeansofdeath, idamage) {
  if(self util::isflashbanged()) {
    return;
  }

  if(smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH") {
    if(idamage > 10) {
      if(self util::mayapplyscreeneffect()) {
        self shellshock(#"frag_grenade_mp", 0.5);
      }
    }
  }
}

function end_on_death() {
  self waittill(#"death");
  waittillframeend();
  self notify(#"end_explode");
}

function end_on_timer(timer) {
  self endon(#"disconnect");
  wait timer;
  self notify(#"end_on_timer");
}

function rcbomb_earthquake(position) {
  playrumbleonposition("grenade_rumble", position);
  earthquake(0.5, 0.5, self.origin, 512);
}