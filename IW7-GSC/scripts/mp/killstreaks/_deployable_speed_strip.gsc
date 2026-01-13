/**************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_deployable_speed_strip.gsc
**************************************************************/

init() {
  var_0 = spawnStruct();
  var_0.id = "deployable_speed_strip";
  var_0.var_39B = "deployable_speed_strip_marker_mp";
  var_0.streakname = "deployable_speed_strip";
  var_0.grenadeusefunc = ::scripts\mp\speedboost::func_109C1;
  level.boxsettings["deployable_speed_strip"] = var_0;
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("deployable_speed_strip", ::func_128DD);
}

func_128DD(var_0, var_1) {
  var_2 = scripts\mp\killstreaks\_deployablebox::begindeployableviamarker(var_0, "deployable_speed_strip");
  if(!isDefined(var_2) || !var_2) {
    return 0;
  }

  scripts\mp\matchdata::logkillstreakevent("deployable_speed_strip", self.origin);
  return 1;
}