/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz\wz_open_skyscrapers_fixup.gsc
***********************************************/

#include scripts\mp_common\item_world_fixup;

#namespace wz_open_skyscrapers_fixup;

autoexec __init__() {
  function_4305a789();
  function_c94723bd();
}

private function_4305a789() {}

private function_c94723bd() {
  if(isDefined(getgametypesetting(#"wzenableflareguns")) && getgametypesetting(#"wzenableflareguns") && !(isDefined(getgametypesetting(#"wzheavymetalheroes")) && getgametypesetting(#"wzheavymetalheroes"))) {
    item_world_fixup::function_e70fa91c(#"supply_stash_parent_dlc1", #"supply_stash_parent_dlc1_flare_guns", 5);
  }
}