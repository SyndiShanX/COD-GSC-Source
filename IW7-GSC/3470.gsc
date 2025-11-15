/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3470.gsc
***************************************/

init() {
  var_00 = spawnStruct();
  var_0.id = "deployable_speed_strip";
  var_0.weaponinfo = "deployable_speed_strip_marker_mp";
  var_0.streakname = "deployable_speed_strip";
  var_0.grenadeusefunc = scripts\mp\speedstrip::func_109C1;
  level.boxsettings["deployable_speed_strip"] = var_00;
  scripts\mp\killstreaks\killstreaks::registerkillstreak("deployable_speed_strip", ::func_128DD);
}

func_128DD(var_00, var_01) {
  var_02 = scripts\mp\killstreaks\deployablebox::begindeployableviamarker(var_00, "deployable_speed_strip");

  if(!isDefined(var_02) || !var_02)
    return 0;

  scripts\mp\matchdata::logkillstreakevent("deployable_speed_strip", self.origin);
  return 1;
}