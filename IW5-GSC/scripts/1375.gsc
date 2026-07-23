/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1375.gsc
**************************************/

_id_4235() {
  _id_4232();
  var_0 = self._id_0B6E._id_41D0._id_41D1["state"]["hidden"];
  thread maps\_stealth_shared_utilities::_id_41CE(var_0, "friendly_behavior");
  var_0 = self._id_0B6E._id_41D0._id_41D1["state"]["spotted"];
  thread maps\_stealth_shared_utilities::_id_41CB(var_0, "friendly_behavior");
}

_id_4236() {
  thread maps\_utility::_id_0D72(0);
  self._id_0B6E._id_41D0._id_4237 = self.grenadeammo;
  self.grenadeammo = 0;
  self._id_1117 = undefined;
  self.ignoreme = 1;
}

_id_4238() {
  thread maps\_utility::_id_0D72(1);

  if(isDefined(self._id_0B6E._id_41D0._id_4237)) {
    self.grenadeammo = self._id_0B6E._id_41D0._id_4237;
  } else {
    self.grenadeammo = 3;
  }
  self.ignoreme = 0;
  self pushplayer(0);
  maps\_utility::_id_109E();
  thread _id_4239();
  self allowedstances("prone", "crouch", "stand");
  maps\_utility::_id_1414();
}

_id_4239(var_0) {
  self endon("death");

  if(self._id_0B6E._id_41ED.stance != "prone") {
    return;
  }
  maps\_utility::_id_13DC("_stealth_custom_anim");
  var_1 = "_stealth_prone_2_run_roll";

  if(isDefined(var_0)) {
    self orientmode("face angle", var_0[1] + 20);
  }
  thread maps\_anim::_id_11CC(self, "gravity", var_1);
  var_2 = getanimlength(maps\_utility::_id_26EC(var_1));
  wait(var_2 - 0.2);
  self notify("stop_animmode");
  maps\_utility::_id_13DE("_stealth_custom_anim");
}

_id_4232() {
  maps\_utility::_id_1402("_stealth_custom_anim");
  maps\_utility::_id_1402("_stealth_override_goalpos");
  self._id_0B6E._id_41D0 = spawnStruct();
  self._id_0B6E._id_41D0._id_41D1 = [];
  _id_423C();
  self._id_0B6E._id_423A = spawnStruct();
  thread maps\_stealth_shared_utilities::_id_41E3();
}

_id_423B(var_0) {
  foreach(var_3, var_2 in var_0) {}
  maps\_stealth_shared_utilities::_id_41CF("state", var_3, var_2);

  var_4 = self._id_0B6E._id_41D0._id_41D1["state"]["hidden"];
  thread maps\_stealth_shared_utilities::_id_41CE(var_4, "friendly_behavior");
  var_4 = self._id_0B6E._id_41D0._id_41D1["state"]["spotted"];
  thread maps\_stealth_shared_utilities::_id_41CB(var_4, "friendly_behavior");
}

_id_423C() {
  var_0 = [];
  var_0["hidden"] = ::_id_4236;
  var_0["spotted"] = ::_id_4238;
  _id_423B(var_0);
}