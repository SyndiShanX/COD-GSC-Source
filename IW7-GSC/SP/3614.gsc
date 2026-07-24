/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3614.gsc
**************************************/

_id_5374() {
  precacheitem("car_grenade");
  thread _id_5375();
}

_id_5375() {
  scripts\engine\utility::waitframe();
  var_0 = getEntArray("scriptable", "code_classname");

  foreach(var_2 in var_0) {
    if(issubstr(var_2.model, "veh_"))
      var_2 thread _id_5376();
  }
}

_id_5376() {
  self._id_00ED = "vehicle";

  for(;;) {
    self waittill("scriptableNotification", var_0, var_1);

    switch (var_0) {
      case "onfire":
      case "flareup":
        thread _id_329E();
        break;
      case "vehicle_death":
        self notify("destroyed");

        if(isDefined(self._id_329F))
          self._id_329F delete();

        self._id_C528 = undefined;
        return;
    }
  }
}

_id_329E() {
  if(isDefined(self._id_329F)) {
    return;
  }
  self endon("destroyed");
  self._id_C528 = 1;
  wait 0.2;
  self._id_329F = magicgrenade("car_grenade", self.origin + (0, 0, 10), self.origin, 9999, 0);
  self._id_329F._id_C182 = 1;
  self._id_329F makeunusable();
}