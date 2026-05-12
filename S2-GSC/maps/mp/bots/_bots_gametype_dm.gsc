/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_dm.gsc
**********************************************/

func_00F9() {
  func_87A7();
  func_8793();
}

func_87A7() {
  level.var_19D5["gametype_think"] = ::func_19B1;
}

func_8793() {}

func_19B1() {
  self notify("bot_dm_think");
  self endon("bot_dm_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("owner_disconnect");
  for(;;) {
    self[[self.var_6F7F]]();
    wait 0.05;
  }
}