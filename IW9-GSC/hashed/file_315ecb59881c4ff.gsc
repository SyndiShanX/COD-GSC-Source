/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_315ecb59881c4ff.gsc
***********************************************/

init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("cluster_spike", "munitionUsed", ::_id_FE25039B3E24F942);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cluster_spike", "lifetimeOverride", ::_id_12F3623076EFB2E9);
}

_id_FE25039B3E24F942() {
  self notify("munitions_used", "cluster_spike");

  foreach(player in level.players)
  player thread scripts\cp\cp_hud_message::showsplash("used_cluster_spike", undefined, self);

  scripts\cp\utility::_id_98F7CA3781DAC77C(self, "cluster_spike");
}

_id_12F3623076EFB2E9() {
  return 180;
}