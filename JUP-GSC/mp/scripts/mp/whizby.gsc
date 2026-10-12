/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\whizby.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\common\whizby;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\gamescore;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\spawn_event_aggregator;
#namespace whizby;

function init() {
  setdvarifuninitialized(@ "scr_suppression", 0);
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
  scripts\common\whizby::init();
}

function onplayerspawned() {
  thread whizbythink();
}

function whizbythink() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  effecttime = gettime();
  scripts\common\whizby::initplayer();

  for(;;) {
    self waittill("bulletwhizby", attacker, distance, position, forward);
    effecttime = dowhizby(attacker, distance, position, forward, effecttime);
    dosuppression(attacker);
  }
}

function dowhizby(attacker, distance, position, forward, effecttime) {
  currenttime = gettime();

  if(!isusingremote()) {
    thread scripts\common\whizby::whizbyeffect(attacker, distance, position, forward);
  }

  weapon = attacker getcurrentweapon();

  if(isDefined(weapon) && weaponclass(weapon) == "sniper") {
    thread scripts\mp\battlechatter_mp::trysaylocalsound(self, #"bc_flavor_player_surprise", undefined, 0.2);
  }

  thread scripts\mp\battlechatter_mp::addrecentattacker(attacker);
  return effecttime;
}

function dosuppression(attacker) {
  if(getdvarint(@ "scr_suppression", 1) == 1) {
    weapon = attacker getcurrentweapon();

    if(weapon hasattachment("linearbrake") && !scripts\cp_mp\weapon::iskillstreakweapon(weapon) && !scripts\mp\utility\perk::_hasperk("specialty_blastshield")) {
      attacker hudicontype("suppression");
      scripts\mp\gamescore::trackdebuffassist(attacker, self, weapon.basename);
    }
  }
}