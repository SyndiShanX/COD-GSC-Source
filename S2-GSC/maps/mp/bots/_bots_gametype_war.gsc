/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_war.gsc
***********************************************/

func_00F9() {
  func_87A7();
  func_879B();
}

func_87A7() {
  level.var_19D5["gametype_think"] = ::func_1B25;
}

func_879B() {}

func_1B25() {
  self notify("bot_war_think");
  self endon("bot_war_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("owner_disconnect");
  for(;;) {
    self[[self.var_6F7F]]();
    wait 0.05;
  }
}