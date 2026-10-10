/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\whizby.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\common\whizby;
#using scripts\cp\cp_player_battlechatter;
#using scripts\cp\utility;
#using scripts\cp\utility\spawn_event_aggregator;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace whizby;

function init() {
  scripts\common\whizby::init();
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
}

function onplayerspawned() {
  self._whizbyfxent = [];
  thread whizbythink();
}

function whizbythink() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\common\whizby::initplayer();

  for(;;) {
    self waittill("bulletwhizby", attacker, distance, position, forward);
    dowhizby(attacker, distance, position, forward);
  }
}

function dowhizby(attacker, distance, position, forward) {
  if(!isusingremote()) {
    thread scripts\common\whizby::function_a6e6611efb4164d5(attacker, distance, position, forward);
  }

  weapon = attacker getcurrentweapon();

  if(weaponclass(weapon) == "sniper") {}

  thread scripts\cp\cp_player_battlechatter::addrecentattacker(attacker);
}