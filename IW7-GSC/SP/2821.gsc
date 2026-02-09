/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\2821.gsc
*********************************************/

main() {
  level.analytics = spawnStruct();
  level.analytics.var_B8D3 = level.player func_84C6("totalGameplayTime");
  level.analytics.var_10DB5 = func_7E73();
  setDvar("scr_analytics_playerJustDied", 0);
  thread func_1E6C();
}

func_1E6C() {
  for(;;) {
    if(issaverecentlyloaded() || getdvarint("scr_analytics_playerJustDied")) {
      setDvar("scr_analytics_playerJustDied", 0);
      setDvar("scr_analytics_playerStartTime", gettime());
    }

    wait(0.5);
  }
}

func_B8CE(var_0) {
  var_1 = func_12F49();
  func_F230(var_0, var_1);
}

func_D37D() {
  func_12F49();
  setDvar("scr_analytics_playerJustDied", 1);
}

func_F230(var_0, var_1) {
  if(!isDefined(level.analytics)) {
    return;
  }

  var_2 = var_1 - level.analytics.var_B8D3;
  var_3 = func_7E73();
  self func_84C9(var_0, int(var_2), level.analytics.var_10DB5, var_3);
}

func_12F49() {
  var_0 = level.player func_84C6("totalGameplayTime");
  var_1 = int(gettime() - getdvarint("scr_analytics_playerStartTime") / 1000);
  if(var_1 > 0) {
    var_0 = var_0 + var_1;
    level.player func_84C7("totalGameplayTime", var_0);
  }

  return var_0;
}

func_7E73() {
  var_0 = getdvarint("g_gameskill") + 1;
  if(scripts\sp\utility::func_93A6()) {
    var_0 = 5;
  } else if(scripts\sp\utility::func_93AB()) {
    var_0 = 6;
  }

  return var_0;
}