/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2341.gsc
*************************************************/

_id_5895() {}

_id_6F2B(var_0) {
  if(isDefined(var_0)) {
    self setplayerdata("cp", "zombiePlayerLoadout", "faction_name", var_0);
  }

  var_1 = self getplayerdata("cp", "zombiePlayerLoadout", "faction_name");
  self._id_5894 = var_1;
}

_id_4450(var_0) {
  _id_6F2B(var_0);
}