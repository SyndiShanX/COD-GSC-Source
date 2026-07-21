/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: engine\sp\objectives.gsc
***********************************************/

objective_add(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  _objective_validatename(var_0);
  _objective_initindexforname(var_0);
  objective_update(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

objective_update(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  _objective_validatename(var_0);

  if(isDefined(var_1))
    objective_set_state(var_0, var_1);

  if(isDefined(var_2))
    objective_set_position(var_0, var_2);

  if(isDefined(var_3))
    objective_set_description(var_0, var_3);

  if(isDefined(var_4))
    objective_set_label(var_0, var_4);

  if(isDefined(var_5))
    objective_set_icon(var_0, var_5);

  if(isDefined(var_6))
    objective_set_z_offset(var_0, var_6);

  if(isDefined(var_7))
    objective_set_show_distance(var_0, var_7);

  if(isDefined(var_8))
    objective_set_show_progress(var_0, var_8);

  level notify("objectives_updated");
}

objective_remove(var_0) {
  var_1 = _objective_getindexforname(var_0);
  level.objective_array[var_1] = undefined;
  objective_delete(var_1);
  level notify("objectives_updated");
}

objective_exists(var_0) {
  _objective_validatename(var_0);

  if(isDefined(level.objective_array)) {
    foreach(var_2 in level.objective_array) {
      if(isDefined(var_2.objectivename) && var_2.objectivename == var_0)
        return 1;
    }
  }

  return 0;
}

objective_complete(var_0) {
  objective_set_state(var_0, "done");
  var_1 = _objective_getindexforname(var_0);
}

objective_set_state(var_0, var_1) {
  _objective_validatename(var_0);
  var_2 = _objective_getindexforname(var_0);
  objective_state(var_2, var_1);
  level notify("objectives_updated");
  level notify("objectives_updated_state", var_1);
}

objective_set_position(var_0, var_1) {
  _objective_validatename(var_0);
  var_2 = _objective_getindexforname(var_0);
  objective_position(var_2, var_1);
  level notify("objectives_updated");
}

objective_set_description(var_0, var_1) {
  _objective_validatename(var_0);
  var_2 = _objective_getindexforname(var_0);
  objective_setdescription(var_2, var_1);
  level notify("objectives_updated");
}

objective_set_label(var_0, var_1) {
  _objective_validatename(var_0);
  var_2 = _objective_getindexforname(var_0);
  objective_setlabel(var_2, var_1);
  level notify("objectives_updated");
}

objective_set_icon(var_0, var_1) {
  _objective_validatename(var_0);
  var_2 = _objective_getindexforname(var_0);
  objective_icon(var_2, var_1);
  level notify("objectives_updated");
}

objective_set_z_offset(var_0, var_1) {
  _objective_validatename(var_0);
  var_2 = _objective_getindexforname(var_0);
  objective_setzoffset(var_2, var_1);
  level notify("objectives_updated");
}

objective_set_show_distance(var_0, var_1) {
  _objective_validatename(var_0);
  var_2 = _objective_getindexforname(var_0);
  objective_setshowdistance(var_2, var_1);
  level notify("objectives_updated");
}

objective_set_show_progress(var_0, var_1) {
  _objective_validatename(var_0);
  var_2 = _objective_getindexforname(var_0);
  objective_setshowprogress(var_2, var_1);
  level notify("objectives_updated");
}

objective_set_on_entity(var_0, var_1, var_2) {
  _objective_validatename(var_0);
  var_3 = _objective_getindexforname(var_0);

  if(level.objective_array[var_3].locations.size > 0) {
    scripts\engine\utility::error("Calling this function while having locations set is scary. OnEntity always takes the first index.");
    objective_remove_all_locations(var_0);
  }

  level.objective_array[var_3].locations[0] = var_1;
  objective_onentity(var_3, var_2);
  level notify("objectives_updated");
}

objective_add_location_entity(var_0, var_1, var_2) {
  _objective_addlocation(var_0, var_1, var_2);
}

objective_add_location_position(var_0, var_1, var_2) {
  _objective_addlocation(var_0, var_1, var_2);
}

objective_remove_location(var_0, var_1) {
  var_2 = -1;
  var_3 = _objective_getindexforname(var_0);
  var_4 = level.objective_array[var_3].locations;

  foreach(var_7, var_6 in var_4) {
    if(isDefined(var_6) && var_6 == var_1) {
      var_2 = var_7;
      break;
    }
  }

  level.objective_array[var_3].locations[var_2] = undefined;
  objective_unsetlocation(var_3, var_2);
  level notify("objectives_updated", "location");
}

objective_remove_all_locations(var_0) {
  var_1 = _objective_getindexforname(var_0);

  for(var_2 = 0; var_2 < 8; var_2++)
    objective_unsetlocation(var_1, var_2);

  level.objective_array[var_1].locations = [];
  level notify("objectives_updated");
}

_objective_addlocation(var_0, var_1, var_2) {
  var_3 = _objective_getindexforname(var_0);
  var_4 = _objective_getnextfreelocationindex(var_3);
  level.objective_array[var_3].locations[var_4] = var_1;
  objective_setlocation(var_3, var_4, var_2);
  level notify("objectives_updated");
}

_objective_validatename(var_0) {}

_objective_initindexforname(var_0) {
  _objective_getindexforname(var_0, 1);
}

_objective_getindexforname(var_0, var_1) {
  if(!isDefined(level.objective_array))
    level.objective_array = [];

  var_2 = -1;

  if(istrue(var_1)) {
    var_2 = _objective_getnextfreeobjectiveindex();
    level.objective_array[var_2] = spawnStruct();
    level.objective_array[var_2].objectivename = var_0;
    level.objective_array[var_2].locations = [];
    objective_delete(var_2);
  } else {
    for(var_3 = 0; var_3 < 32; var_3++) {
      if(isDefined(level.objective_array[var_3]) && isDefined(level.objective_array[var_3].objectivename) && level.objective_array[var_3].objectivename == var_0) {
        var_2 = var_3;
        break;
      }
    }
  }

  return var_2;
}

_objective_getnextfreelocationindex(var_0) {
  var_1 = level.objective_array[var_0].locations;

  for(var_2 = 0; var_2 < 8; var_2++) {
    if(!isDefined(var_1[var_2]))
      return var_2;
    else if(var_1[var_2] == "")
      return var_2;
  }
}

_objective_getnextfreeobjectiveindex() {
  for(var_0 = 0; var_0 < 32; var_0++) {
    if(!isDefined(level.objective_array[var_0]))
      return var_0;
  }
}