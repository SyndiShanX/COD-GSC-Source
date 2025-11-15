/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\2821.gsc
************************/

main() {
  level.analytics = spawnStruct();
  level.analytics.var_B8D3 = level.player _meth_84C6("totalGameplayTime");
  level.analytics.var_10DB5 = func_7E73();
  setdvar("scr_analytics_playerJustDied", 0);
  thread func_1E6C();
}

func_1E6C() {
  for(;;) {
    if(issaverecentlyloaded() || getdvarint("scr_analytics_playerJustDied")) {
      setdvar("scr_analytics_playerJustDied", 0);
      setdvar("scr_analytics_playerStartTime", gettime());
    }

    wait(0.5);
  }
}

func_B8CE(param_00) {
  var_01 = func_12F49();
  func_F230(param_00, var_01);
}

func_D37D() {
  func_12F49();
  setdvar("scr_analytics_playerJustDied", 1);
}

func_F230(param_00, param_01) {
  if(!isDefined(level.analytics)) {
    return;
  }

  var_02 = param_01 - level.analytics.var_B8D3;
  var_03 = func_7E73();
  self _meth_84C9(param_00, int(var_02), level.analytics.var_10DB5, var_03);
}

func_12F49() {
  var_00 = level.player _meth_84C6("totalGameplayTime");
  var_01 = int(gettime() - getdvarint("scr_analytics_playerStartTime") / 1000);
  if(var_01 > 0) {
    var_00 = var_00 + var_01;
    level.player _meth_84C7("totalGameplayTime", var_00);
  }

  return var_00;
}

func_7E73() {
  var_00 = getdvarint("g_gameskill") + 1;
  if(scripts\sp\utility::func_93A6()) {
    var_00 = 5;
  } else if(scripts\sp\utility::func_93AB()) {
    var_00 = 6;
  }

  return var_00;
}