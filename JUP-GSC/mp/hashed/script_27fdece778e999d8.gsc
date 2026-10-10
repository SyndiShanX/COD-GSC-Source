/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_27fdece778e999d8.gsc
*************************************************/

#using script_59ff79d681bb860c;
#using script_d74ae0b4aa21186;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_util;
#using scripts\mp\utility\game;
#namespace namespace_e8b353934f3548ee;

function initialize(var_f9320d3953360ca2) {
  namespace_56b9cc3deb6e3f5e::globalinitialize(var_f9320d3953360ca2);
  level.bot_funcs["player_spawned_gamemode"] = &onbotspawned;
  level.bot_funcs["gametype_think"] = &function_a3b11047212a9bbd;

  if(!scripts\cp_mp\utility\game_utility::function_6493ec89ae923684()) {
    level.modifyplayerdamage = &modifyplayerdamage;
  }

  level.bot_funcs["revive_think"] = &void;
}

function onbotspawned() {
  onbotspawnedcommon("Combat");
  self botsetflag("ignore_nodes", 1);
  function_5f51c5c13fd2911b();
}

function function_5f51c5c13fd2911b() {
  if(!scripts\cp_mp\utility\game_utility::function_6493ec89ae923684() && !isDefined(self.var_d298338a64096d6d)) {
    difficulty = function_d55289ceec7cf934();
    bot_set_difficulty(difficulty);
    self.difficulty = difficulty;
    self.var_d298338a64096d6d = difficulty;
  }
}

function function_a3b11047212a9bbd() {
  self.var_deb55e4a0429ef1 = 1;
  self notify("bot_br_super_think");
  self endon("bot_br_super_think");
  self endon("bot_suspended");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isnavmeshloaded()) {
    wait 0.05;
  }

  val::set(getgametype(), "vehicle_use", 0);
  function_142b713a2846f9ac("Mind");
  namespace_56b9cc3deb6e3f5e::initializeupdate();

  while(true) {
    if(getdvarint(@ "hash_c2de8ca6dc8512c1") || self.sessionstate == "<dev string:x1c>") {
      wait 0.05;
      continue;
    }

    if(bot_is_remote_or_linked()) {
      wait 0.05;
      continue;
    }

    namespace_56b9cc3deb6e3f5e::update();
  }
}

function modifyplayerdamage(einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_be4285b26ed99ab1) {
  modifieddamage = namespace_41f4dfb71dd08362::function_d111733407f6518(smeansofdeath, victim, eattacker, idamage, 0);
  return modifieddamage;
}

function function_c38398385afc10fc(var_245fedb867efee4b) {
  level waittill("player_spawned", player);

  if(!scripts\mp\utility\game::matchmakinggame()) {
    botcount = getdvarint(@ "hash_409bdb274de67d6e", 0);

    if(istrue(var_245fedb867efee4b)) {
      level thread function_f166b9f78beca5e6(botcount, player.team);
    } else {
      if(botcount > 0) {
        alliescount = int(botcount / 2);
        axiscount = botcount - alliescount;
      } else {
        alliescount = 0;
        axiscount = 0;
      }

      level thread function_f166b9f78beca5e6(alliescount, "allies");
      level thread function_f166b9f78beca5e6(axiscount, "axis");
    }
  }

  setupdevgui();
}

function function_f166b9f78beca5e6(count, team) {
  var_50ade409b1e5efcb = [];

  for(i = 1; i <= count; i++) {
    botinfo = spawnStruct();
    botinfo.name = "";
    var_50ade409b1e5efcb[var_50ade409b1e5efcb.size] = botinfo;
  }

  level spawnbots(var_50ade409b1e5efcb, team, undefined, undefined, "spawned_bots");
}

function isvalidplayermp(player) {
  return isaliveplayer(player);
}