/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_133ea27280b07bc2.gsc
*************************************************/

#using scripts\cp_mp\utility\weapon_utility;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\warrior;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\utility\game;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\teams;
#namespace warrior_turrettime;

function function_f1e15d6ce495e904() {
  thread onplayerspawned();
  setDvar(@ "hash_b9422777c9947030", 1);
  thread function_492b4dec632917ec("warrior_turrettime");
}

function function_6e36432069ac5ccc() {
  setDvar(@ "hash_b9422777c9947030", 0);

  foreach(player in level.players) {
    player scripts\mp\killstreaks\killstreaks::clearkillstreaks();
  }
}

function onplayerspawned() {
  level endon("game_ended");
  level endon("round_end_finished");

  while(true) {
    level waittill("player_spawned", player);
    player takeallweapons();
    empweapon = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845("jup_jp22_la_dromeo_mp");
    player giveweapon(empweapon);
    player setspawnweapon(empweapon);
    player.primaryweaponobj = empweapon;
    player scripts\mp\killstreaks\killstreaks::awardkillstreak("remote_turret");
    player thread function_3464ff6a11549a11();
  }
}

function function_3464ff6a11549a11() {
  level endon("game_ended");
  level endon("round_end_finished");

  while(true) {
    self waittill("remote_turret_active");
    self.placedsentries["remote_turret"][0] waittill("remote_turret_death");
    scripts\mp\killstreaks\killstreaks::awardkillstreak("remote_turret");
  }
}