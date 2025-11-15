/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_bot.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\bots\_bot;
#using scripts\shared\bots\_bot_combat;
#using scripts\shared\callbacks_shared;
#using scripts\shared\killstreaks_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons_shared;
#using scripts\zm\_zm_weapons;
#namespace zm_bot;

function autoexec __init__sytem__() {
  system::register("zm_bot", & __init__, undefined, undefined);
}

function __init__() {
  println("");
  level.onbotspawned = & on_bot_spawned;
  level.getbotthreats = & bot_combat::get_ai_threats;
  level.botprecombat = & bot::coop_pre_combat;
  level.botpostcombat = & bot::coop_post_combat;
  level.botidle = & bot::follow_coop_players;
  level.botdevguicmd = & bot::coop_bot_devgui_cmd;
  thread debug_coop_bot_test();
}

function debug_coop_bot_test() {
  botcount = 0;
  adddebugcommand("");
  while(true) {
    if(getdvarint("") > 0) {
      while(getdvarint("") > 0) {
        if(botcount > 0 && randomint(100) > 60) {
          adddebugcommand("");
          botcount--;
          debugmsg("" + botcount);
        } else if(botcount < getdvarint("") && randomint(100) > 50) {
          adddebugcommand("");
          botcount++;
          debugmsg("" + botcount);
        }
        wait(randomintrange(1, 3));
      }
    } else {
      while(botcount > 0) {
        adddebugcommand("");
        botcount--;
        debugmsg("" + botcount);
        wait(1);
      }
    }
    wait(1);
  }
}

function on_bot_spawned() {
  host = bot::get_host_player();
  loadout = host zm_weapons::player_get_loadout();
  self zm_weapons::player_give_loadout(loadout);
}

function debugmsg(str_txt) {
  iprintlnbold(str_txt);
  if(isDefined(level.name)) {
    println((("" + level.name) + "") + str_txt);
  }
}