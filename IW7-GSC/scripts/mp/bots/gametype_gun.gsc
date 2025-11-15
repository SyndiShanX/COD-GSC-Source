/********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\bots\gametype_gun.gsc
********************************************/

main() {
  level.bot_funcs["gametype_think"] = ::bot_gun_think;
}

bot_gun_think() {
  var_00 = self botgetdifficultysetting("throwKnifeChance");
  if(var_00 < 0.25) {
    self getpassivestruct("throwKnifeChance", 0.25);
  }

  self getpassivestruct("allowGrenades", 1);
}