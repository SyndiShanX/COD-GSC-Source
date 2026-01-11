/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3469.gsc
***************************************/

init() {
  var_00 = spawnStruct();
  var_0.id = "deployable_adrenaline_mist";
  var_0.weaponinfo = "deployable_adrenaline_mist_marker_mp";
  var_0.streakname = "deployable_adrenaline_mist";
  var_0.grenadeusefunc = scripts\mp\adrenaline::func_18A5;
  level.boxsettings["deployable_adrenaline_mist"] = var_00;
  scripts\mp\killstreaks\killstreaks::registerkillstreak("deployable_adrenaline_mist", ::func_128DD);
}

func_128DD(var_00, var_01) {
  var_02 = scripts\mp\killstreaks\deployablebox::begindeployableviamarker(var_00, "deployable_adrenaline_mist");

  if(!isDefined(var_02) || !var_02) {
    return 0;
  }

  scripts\mp\matchdata::logkillstreakevent("deployable_adrenaline_mist", self.origin);
  return 1;
}