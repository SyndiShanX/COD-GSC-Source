/******************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_deployable_adrenaline_mist.gsc
******************************************************************/

init() {
  var_00 = spawnStruct();
  var_00.id = "deployable_adrenaline_mist";
  var_00.var_39B = "deployable_adrenaline_mist_marker_mp";
  var_00.streakname = "deployable_adrenaline_mist";
  var_00.grenadeusefunc = ::scripts\mp\adrenalinemist::func_18A5;
  level.boxsettings["deployable_adrenaline_mist"] = var_00;
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("deployable_adrenaline_mist", ::func_128DD);
}

func_128DD(param_00, param_01) {
  var_02 = scripts\mp\killstreaks\_deployablebox::begindeployableviamarker(param_00, "deployable_adrenaline_mist");
  if(!isDefined(var_02) || !var_02) {
    return 0;
  }

  scripts\mp\matchdata::logkillstreakevent("deployable_adrenaline_mist", self.origin);
  return 1;
}