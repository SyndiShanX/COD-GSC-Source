/******************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_deployable_adrenaline_mist.gsc
******************************************************************/

init() {
  var_0 = spawnStruct();
  var_0.id = "deployable_adrenaline_mist";
  var_0.var_39B = "deployable_adrenaline_mist_marker_mp";
  var_0.streakname = "deployable_adrenaline_mist";
  var_0.grenadeusefunc = ::scripts\mp\adrenalinemist::func_18A5;
  level.boxsettings["deployable_adrenaline_mist"] = var_0;
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("deployable_adrenaline_mist", ::func_128DD);
}

func_128DD(var_0, var_1) {
  var_2 = scripts\mp\killstreaks\_deployablebox::begindeployableviamarker(var_0, "deployable_adrenaline_mist");
  if(!isDefined(var_2) || !var_2) {
    return 0;
  }

  scripts\mp\matchdata::logkillstreakevent("deployable_adrenaline_mist", self.origin);
  return 1;
}