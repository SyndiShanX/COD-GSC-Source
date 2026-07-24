/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2821.gsc
**************************************/

main() {
  level.analytics = spawnStruct();
  level.analytics._id_B8D3 = level.player _meth_84C6("totalGameplayTime");
  level.analytics._id_10DB5 = _id_7E73();
  setDvar("scr_analytics_playerJustDied", 0);
  thread _id_1E6C();
}

_id_1E6C() {
  for(;;) {
    if(issaverecentlyloaded() || getdvarint("scr_analytics_playerJustDied")) {
      setDvar("scr_analytics_playerJustDied", 0);
      setDvar("scr_analytics_playerStartTime", gettime());
    }

    wait 0.5;
  }
}

_id_B8CE(var_0) {
  var_1 = _id_12F49();
  _id_F230(var_0, var_1);
}

_id_D37D() {
  _id_12F49();
  setDvar("scr_analytics_playerJustDied", 1);
}

_id_F230(var_0, var_1) {
  if(!isDefined(level.analytics)) {
    return;
  }
  var_2 = var_1 - level.analytics._id_B8D3;
  var_3 = _id_7E73();
  self _meth_84C9(var_0, int(var_2), level.analytics._id_10DB5, var_3);
}

_id_12F49() {
  var_0 = level.player _meth_84C6("totalGameplayTime");
  var_1 = int((gettime() - getdvarint("scr_analytics_playerStartTime")) / 1000);

  if(var_1 > 0) {
    var_0 = var_0 + var_1;
    level.player _meth_84C7("totalGameplayTime", var_0);
  }

  return var_0;
}

_id_7E73() {
  var_0 = getdvarint("g_gameskill") + 1;

  if(scripts\sp\utility::_id_93A6()) {
    var_0 = 5;
  } else if(scripts\sp\utility::_id_93AB()) {
    var_0 = 6;
  }

  return var_0;
}