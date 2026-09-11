/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\engine\sp\objectives.gsc
***********************************************/

function objective_add(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  _objective_validatename(var0);
  _objective_initindexforname(var0);
  objective_update(var0, var1, var2, var3, var4, var5, var6, var7, var8);
}

function objective_update(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  _objective_validatename(var0);

  if(isDefined(var1)) {
    objective_set_state(var0, var1);
  }

  if(isDefined(var2)) {
    objective_set_position(var0, var2);
  }

  if(isDefined(var3)) {
    objective_set_description(var0, var3);
  }

  if(isDefined(var4)) {
    objective_set_label(var0, var4);
  }

  if(isDefined(var5)) {
    objective_set_icon(var0, var5);
  }

  if(isDefined(var6)) {
    objective_set_z_offset(var0, var6);
  }

  if(isDefined(var7)) {
    objective_set_show_distance(var0, var7);
  }

  if(isDefined(var8)) {
    objective_set_show_progress(var0, var8);
  }

  level notify("objectives_updated");
}

function objective_remove(var0) {
  var1 = _objective_getindexforname(var0);
  level.objective_array[var1] = undefined;
  objective_delete(var1);
  level notify("objectives_updated");
}

function objective_exists(var0) {
  _objective_validatename(var0);

  if(isDefined(level.objective_array)) {
    foreach(var2 in level.objective_array) {
      if(isDefined(var2.objectivename) && var2.objectivename == var0) {
        return true;
      }
    }
  }

  return false;
}

function objective_complete(var0) {
  objective_set_state(var0, "done");
  var1 = _objective_getindexforname(var0);
}

function objective_set_state(var0, var1) {
  _objective_validatename(var0);
  var2 = _objective_getindexforname(var0);
  objective_state(var2, var1);
  level notify("objectives_updated");
  level notify("objectives_updated_state", var1);
}

function objective_set_position(var0, var1) {
  _objective_validatename(var0);
  var2 = _objective_getindexforname(var0);
  objective_position(var2, var1);
  level notify("objectives_updated");
}

function objective_set_description(var0, var1) {
  _objective_validatename(var0);
  var2 = _objective_getindexforname(var0);
  objective_setdescription(var2, var1);
  level notify("objectives_updated");
}

function objective_set_label(var0, var1) {
  _objective_validatename(var0);
  var2 = _objective_getindexforname(var0);
  objective_setlabel(var2, var1);
  level notify("objectives_updated");
}

function objective_set_icon(var0, var1) {
  _objective_validatename(var0);
  var2 = _objective_getindexforname(var0);
  objective_icon(var2, var1);
  level notify("objectives_updated");
}

function objective_set_z_offset(var0, var1) {
  _objective_validatename(var0);
  var2 = _objective_getindexforname(var0);
  objective_setzoffset(var2, var1);
  level notify("objectives_updated");
}

function objective_set_show_distance(var0, var1) {
  _objective_validatename(var0);
  var2 = _objective_getindexforname(var0);
  objective_setshowdistance(var2, var1);
  level notify("objectives_updated");
}

function objective_set_show_progress(var0, var1) {
  _objective_validatename(var0);
  var2 = _objective_getindexforname(var0);
  objective_setshowprogress(var2, var1);
  level notify("objectives_updated");
}

function objective_set_on_entity(var0, var1, var2) {
  _objective_validatename(var0);
  var3 = _objective_getindexforname(var0);

  if(level.objective_array[var3].locations.size > 0) {
    scripts\engine\utility::error("Calling this function while having locations set is scary. OnEntity always takes the first index.");
    objective_remove_all_locations(var0);
  }

  level.objective_array[var3].locations[0] = var1;
  objective_onentity(var3, var2);
  level notify("objectives_updated");
}

function objective_add_location_entity(var0, var1, var2) {
  _objective_addlocation(var0, var1, var2);
}

function objective_add_location_position(var0, var1, var2) {
  _objective_addlocation(var0, var1, var2);
}

function objective_remove_location(var0, var1) {
  var2 = -1;
  var3 = _objective_getindexforname(var0);
  var4 = level.objective_array[var3].locations;

  foreach(var6 in var4) {
    if(isDefined(var6) && var6 == var1) {
      var2 = var7;
      break;
    }
  }

  level.objective_array[var3].locations[var2] = undefined;
  objective_unsetlocation(var3, var2);
  level notify("objectives_updated", "location");
}

function objective_remove_all_locations(var0) {
  var1 = _objective_getindexforname(var0);

  for(var2 = 0; var2 < 8; var2++) {
    objective_unsetlocation(var1, var2);
  }

  level.objective_array[var1].locations = [];
  level notify("objectives_updated");
}

function _objective_addlocation(var0, var1, var2) {
  var3 = _objective_getindexforname(var0);
  var4 = _objective_getnextfreelocationindex(var3);
  level.objective_array[var3].locations[var4] = var1;
  objective_setlocation(var3, var4, var2);
  level notify("objectives_updated");
}

function _objective_validatename(var0) {}

function _objective_initindexforname(var0) {
  _objective_getindexforname(var0, 1);
}

function _objective_getindexforname(var0, var1) {
  if(!isDefined(level.objective_array)) {
    level.objective_array = [];
  }

  var2 = -1;

  if(istrue(var1)) {
    var2 = _objective_getnextfreeobjectiveindex();
    level.objective_array[var2] = spawnStruct();
    level.objective_array[var2].objectivename = var0;
    level.objective_array[var2].locations = [];
    objective_delete(var2);
  } else {
    for(var3 = 0; var3 < 32; var3++) {
      if(isDefined(level.objective_array[var3]) && isDefined(level.objective_array[var3].objectivename) && level.objective_array[var3].objectivename == var0) {
        var2 = var3;
        break;
      }
    }
  }

  return var2;
}

function _objective_getnextfreelocationindex(var0) {
  var1 = level.objective_array[var0].locations;

  for(var2 = 0; var2 < 8; var2++) {
    if(!isDefined(var1[var2])) {
      return var2;
    }

    if(var1[var2] == "") {
      return var2;
    }
  }
}

function _objective_getnextfreeobjectiveindex() {
  for(var0 = 0; var0 < 32; var0++) {
    if(!isDefined(level.objective_array[var0])) {
      return var0;
    }
  }
}