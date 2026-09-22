/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1341.gsc
**************************************/

init() {
  level._id_AC18 = common_scripts\utility::_id_46B7("zombie_debris", "targetname");
  common_scripts\utility::_id_0FB2(level._id_AC18, ::_id_51B0);
}

_id_51B0() {
  var_0 = getEntArray(self.target, "targetname");
  self._id_17E7 = [];
  self._id_9DC2 = [];
  self._id_267B = self.setanimknobrestart;

  foreach(var_2 in var_0) {
    waitframe();

    switch (var_2._id_0165) {
      case "zombies_debris_blocker":
        self._id_17E7 = common_scripts\utility::_id_0F6F(self._id_17E7, var_2);
        break;
      case "zombies_debris_trigger":
        self._id_9DC2 = common_scripts\utility::_id_0F6F(self._id_9DC2, var_2);
        var_2._id_267B = self._id_267B;
        var_2._id_7778 = _id_0552::_id_7BDD(var_2);
        var_2._id_7778._id_3259 = self._id_267B;
        break;
    }
  }

  foreach(var_5 in self._id_9DC2) {
    var_5 thread _id_11BA(self);
  }

  self waittill("debris_purchased", var_7);

  if(isDefined(self.getnegotiationnextnode)) {
    common_scripts\utility::flag_set(self.getnegotiationnextnode, var_7);
  }

  foreach(var_9 in self._id_17E7) {
    if(var_9.classname != "script_model") {
      var_9 connectpaths();
    }

    var_9 notsolid();
    var_9 delete();
  }

  foreach(var_9 in self._id_9DC2) {
    var_9 common_scripts\utility::_id_9D9F();
  }
}

_id_11BA(var_0) {
  self notify("start_attempt_debris_purchase");
  self endon("start_attempt_debris_purchase");
  var_1 = 0;
  var_2 = undefined;

  if(_id_0547::_id_5565(self.setgoalnode, "requires_power")) {
    self._id_3276 = spawnStruct();
    self._id_3276.setgoalnode = "power_sz2";
  }

  while(!var_1) {
    self waittill("trigger", var_2);

    if(_id_0547::_id_5565(self.setgoalnode, "requires_power") && !common_scripts\utility::_id_3C77("power_sz2")) {
      var_2 iprintlnbold("requires power!");
      continue;
    }

    var_1 = var_2 maps\mp\gametypes\zombies::_id_11C2(var_0._id_267B);
  }

  var_0 notify("debris_purchased", var_2);
}