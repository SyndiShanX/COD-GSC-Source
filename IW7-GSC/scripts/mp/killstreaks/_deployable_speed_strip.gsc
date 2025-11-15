/**************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_deployable_speed_strip.gsc
**************************************************************/

init() {
  var_00 = spawnStruct();
  var_00.id = "deployable_speed_strip";
  var_00.var_39B = "deployable_speed_strip_marker_mp";
  var_00.streakname = "deployable_speed_strip";
  var_00.grenadeusefunc = ::scripts\mp\speedboost::func_109C1;
  level.boxsettings["deployable_speed_strip"] = var_00;
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("deployable_speed_strip", ::func_128DD);
}

func_128DD(param_00, param_01) {
  var_02 = scripts\mp\killstreaks\_deployablebox::begindeployableviamarker(param_00, "deployable_speed_strip");
  if(!isDefined(var_02) || !var_02) {
    return 0;
  }

  scripts\mp\matchdata::logkillstreakevent("deployable_speed_strip", self.origin);
  return 1;
}