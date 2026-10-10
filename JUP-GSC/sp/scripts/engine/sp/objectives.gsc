/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\engine\sp\objectives.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\utility;
#namespace objectives;

function objective_add(objectivename, objstate, objposition, objdescription, objlabel, var_c6caf52c65d084b8, objzoffset, var_780b9710a4c60f44, var_d54b9310847f6bf4, var_2f87f92eb31189cc, var_2431ebabbcc67a2c, var_c13020776c269a42, var_d85ab98698be6559) {
  _objective_validatename(objectivename);
  _objective_initindexforname(objectivename);
  objective_update(objectivename, objstate, objposition, objdescription, objlabel, var_c6caf52c65d084b8, objzoffset, var_780b9710a4c60f44, var_d54b9310847f6bf4, var_2431ebabbcc67a2c);
  var_2f87f92eb31189cc = default_to(var_2f87f92eb31189cc, 1);

  if(istrue(var_2f87f92eb31189cc) && isDefined(objdescription) && isDefined(level.objectives_splash) && isDefined(level.objectives_splash.callback)) {
    objcomplete = 0;
    var_71bb4595bfba1caf = 0;
    level.player[[level.objectives_splash.callback]](objectivename, objdescription, objcomplete, var_71bb4595bfba1caf, var_d85ab98698be6559);
  }

  var_c13020776c269a42 = default_to(var_c13020776c269a42, 0);

  if(istrue(var_c13020776c269a42)) {
    objectiveindex = _objective_getindexforname(objectivename);
    function_5fd2627c5ce186db(objectiveindex, var_c13020776c269a42);
  }
}

function function_1a7f32a7c56ad4e0(callback_func) {
  assert(isDefined(level.objectives_splash));
  level.objectives_splash.callback = callback_func;
}

function objective_update(objectivename, objstate, objposition, objdescription, objlabel, var_c6caf52c65d084b8, objzoffset, var_780b9710a4c60f44, var_d54b9310847f6bf4, var_2431ebabbcc67a2c, entitytag) {
  _objective_validatename(objectivename);
  assertex(objective_exists(objectivename), "Objective with name " + objectivename + " doesn't exist!");

  if(isDefined(objstate)) {
    objective_set_state(objectivename, objstate);
  }

  if(isDefined(objposition)) {
    if(isent(objposition)) {
      objective_set_on_entity(objectivename, objectivename, objposition);

      if(isDefined(entitytag)) {
        function_5e1102ec9d97ed2c(objectivename, entitytag);
      }
    } else {
      objective_set_position(objectivename, objposition);
    }
  }

  if(isDefined(objdescription)) {
    objective_set_description(objectivename, objdescription);
  }

  if(isDefined(objlabel)) {
    objective_set_label(objectivename, objlabel);
  }

  if(isDefined(var_c6caf52c65d084b8)) {
    objective_set_icon(objectivename, var_c6caf52c65d084b8);
  }

  if(isDefined(objzoffset)) {
    objective_set_z_offset(objectivename, objzoffset);
  }

  if(isDefined(var_780b9710a4c60f44)) {
    objective_set_show_distance(objectivename, var_780b9710a4c60f44);
  }

  if(isDefined(var_d54b9310847f6bf4)) {
    objective_set_show_progress(objectivename, var_d54b9310847f6bf4);
  }

  if(isDefined(var_2431ebabbcc67a2c)) {
    function_ff959ec1bd44c166(objectivename, var_2431ebabbcc67a2c);
  }

  level notify("objectives_updated");
}

function objective_remove(objectivename) {
  assert(objective_exists(objectivename));
  objectiveindex = _objective_getindexforname(objectivename);
  level.objective_array[objectiveindex] = undefined;
  objective_delete(objectiveindex);
  level notify("objectives_updated");
}

function objective_exists(objectivename) {
  _objective_validatename(objectivename);

  if(isDefined(level.objective_array)) {
    foreach(objective in level.objective_array) {
      if(isDefined(objective.objectivename) && objective.objectivename == objectivename) {
        return true;
      }
    }
  }

  return false;
}

function objective_complete(objectivename, var_2f87f92eb31189cc, objdescription) {
  assertex(objective_exists(objectivename), "Objective with name " + objectivename + " doesn't exist!");
  objective_set_state(objectivename, "done");
  var_2f87f92eb31189cc = default_to(var_2f87f92eb31189cc, 0);

  if(istrue(var_2f87f92eb31189cc) && isDefined(level.objectives_splash) && isDefined(level.objectives_splash.callback)) {
    objcomplete = 1;
    var_71bb4595bfba1caf = 0;
    level.player[[level.objectives_splash.callback]](objectivename, objdescription, objcomplete, var_71bb4595bfba1caf);
  }

  objectiveindex = _objective_getindexforname(objectivename);
}

function objective_show_progress(objectivename, objdescription, var_71bb4595bfba1caf, var_d85ab98698be6559) {
  assertex(objective_exists(objectivename), "Objective with name " + objectivename + " doesn't exist!");

  if(isDefined(level.objectives_splash) && isDefined(level.objectives_splash.callback)) {
    objcomplete = 0;
    level.player[[level.objectives_splash.callback]](objectivename, objdescription, objcomplete, var_71bb4595bfba1caf, var_d85ab98698be6559);
  }

  objectiveindex = _objective_getindexforname(objectivename);
}

function objective_set_state(objectivename, objstate) {
  _objective_validatename(objectivename);
  assert(isstring(objstate));
  assertex(objstate == "empty" || objstate == "active" || objstate == "invisible" || objstate == "done" || objstate == "current" || objstate == "failed", "Invalid state: " + objstate + ". Valid states are 'empty', 'active', 'invisible', 'done', 'current' and 'failed'");
  objectiveindex = _objective_getindexforname(objectivename);
  objective_state(objectiveindex, objstate);
  level notify("objectives_updated");
  level notify("objectives_updated_state", objstate);
}

function objective_set_position(objectivename, objposition) {
  _objective_validatename(objectivename);
  assert(isvector(objposition));
  objectiveindex = _objective_getindexforname(objectivename);
  objective_position(objectiveindex, objposition);
  level notify("objectives_updated");
}

function objective_set_description(objectivename, objdescription) {
  _objective_validatename(objectivename);
  assert(isstring(objdescription) || isistring(objdescription));
  objectiveindex = _objective_getindexforname(objectivename);
  objective_setdescription(objectiveindex, objdescription);
  level notify("objectives_updated");
}

function objective_set_label(objectivename, objlabel) {
  _objective_validatename(objectivename);
  assert(isstring(objlabel) || isistring(objlabel));
  objectiveindex = _objective_getindexforname(objectivename);
  objective_setlabel(objectiveindex, objlabel);
  level notify("objectives_updated");
}

function objective_set_icon(objectivename, var_c6caf52c65d084b8) {
  _objective_validatename(objectivename);
  assert(isstring(var_c6caf52c65d084b8));
  objectiveindex = _objective_getindexforname(objectivename);
  objective_icon(objectiveindex, var_c6caf52c65d084b8);
  level notify("objectives_updated");
}

function objective_set_z_offset(objectivename, objzoffset) {
  _objective_validatename(objectivename);
  assert(isint(objzoffset) || isfloat(objzoffset));
  objectiveindex = _objective_getindexforname(objectivename);
  objective_setzoffset(objectiveindex, objzoffset);
  level notify("objectives_updated");
}

function function_ff959ec1bd44c166(objectivename, var_2431ebabbcc67a2c) {
  _objective_validatename(objectivename);
  assert(isint(var_2431ebabbcc67a2c) || isfloat(var_2431ebabbcc67a2c));
  objectiveindex = _objective_getindexforname(objectivename);
  function_7d22acc637a98c43(objectiveindex, var_2431ebabbcc67a2c);
  level notify("objectives_updated");
}

function function_3234e40df03b0a40(objectivename) {
  _objective_validatename(objectivename);
  function_ff959ec1bd44c166(objectivename, -55);
}

function function_54586a40e8a00778(objectivename) {
  _objective_validatename(objectivename);
  function_5e1102ec9d97ed2c(objectivename, "j_head");
  objective_set_z_offset(objectivename, 25);
}

function objective_set_show_distance(objectivename, var_780b9710a4c60f44) {
  _objective_validatename(objectivename);
  assert(isint(var_780b9710a4c60f44));
  objectiveindex = _objective_getindexforname(objectivename);
  objective_setshowdistance(objectiveindex, var_780b9710a4c60f44);
  level notify("objectives_updated");
}

function objective_set_show_progress(objectivename, var_d54b9310847f6bf4) {
  _objective_validatename(objectivename);
  assert(isint(var_d54b9310847f6bf4));
  objectiveindex = _objective_getindexforname(objectivename);
  objective_setshowprogress(objectiveindex, var_d54b9310847f6bf4);
  level notify("objectives_updated");
}

function function_cd6027322dca40(objectivename, objmarked) {
  _objective_validatename(objectivename);
  assert(isint(objmarked));
  objectiveindex = _objective_getindexforname(objectivename);
  objective_setmarked(objectiveindex, objmarked);
}

function objective_set_on_entity(objectivename, locationname, locationentity) {
  _objective_validatename(objectivename);
  assert(isent(locationentity));
  objectiveindex = _objective_getindexforname(objectivename);

  if(level.objective_array[objectiveindex].locations.size > 0) {
    error("Calling this function while having locations set is scary. OnEntity always takes the first index.");
    objective_remove_all_locations(objectivename);
  }

  level.objective_array[objectiveindex].locations[0] = locationname;
  objective_onentity(objectiveindex, locationentity);
  level notify("objectives_updated");
}

function function_5e1102ec9d97ed2c(objectivename, entitytag) {
  _objective_validatename(objectivename);
  assert(isstring(entitytag) || isistring(entitytag));
  objectiveindex = _objective_getindexforname(objectivename);
  function_fd97acb2885e7860(objectiveindex, entitytag);
  level notify("objectives_updated");
}

function objective_add_location_entity(objectivename, locationname, locationentity) {
  assert(isent(locationentity));
  _objective_addlocation(objectivename, locationname, locationentity);
}

function objective_add_location_position(objectivename, locationname, locationposition) {
  assert(isvector(locationposition));
  _objective_addlocation(objectivename, locationname, locationposition);
}

function objective_remove_location(objectivename, locationname) {
  assert(objective_exists(objectivename));
  assert(isstring(locationname));
  var_9be69c18c91160a9 = -1;
  objectiveindex = _objective_getindexforname(objectivename);
  objectivelocations = level.objective_array[objectiveindex].locations;

  foreach(location in objectivelocations) {
    if(isDefined(location) && location == locationname) {
      var_9be69c18c91160a9 = locationindex;
      break;
    }
  }

  assertex(var_9be69c18c91160a9 >= 0, "The location - " + locationname + " - was not defined for objective: " + objectivename);
  level.objective_array[objectiveindex].locations[var_9be69c18c91160a9] = undefined;
  objective_unsetlocation(objectiveindex, var_9be69c18c91160a9);
  level notify("objectives_updated", "location");
}

function function_9ecf0d4a951abebf(objectivename, locationname) {
  assert(objective_exists(objectivename));
  assert(isstring(locationname));
  var_9be69c18c91160a9 = -1;
  objectiveindex = _objective_getindexforname(objectivename);
  objectivelocations = level.objective_array[objectiveindex].locations;

  foreach(location in objectivelocations) {
    if(isDefined(location) && location == locationname) {
      var_9be69c18c91160a9 = locationindex;
      break;
    }
  }

  return var_9be69c18c91160a9 >= 0;
}

function objective_remove_all_locations(objectivename) {
  assert(objective_exists(objectivename));
  objectiveindex = _objective_getindexforname(objectivename);

  for(locationindex = 0; locationindex < 8; locationindex++) {
    objective_unsetlocation(objectiveindex, locationindex);
  }

  level.objective_array[objectiveindex].locations = [];
  level notify("objectives_updated");
}

function function_ab69b0fe7021a308(scaledistance) {
  if(!isDefined(scaledistance)) {
    scaledistance = 1000;
  }

  setomnvar("ui_objective_scale_distance", scaledistance);
}

function function_cd037dbe1fe3943(index) {
  if(level.objective_array != undefined && level.objective_array.size) {
    return level.objective_array[index];
  }

  return undefined;
}

function _objective_addlocation(objectivename, locationname, var_8c7c19c9172500f) {
  assert(objective_exists(objectivename));
  assert(isstring(locationname));
  objectiveindex = _objective_getindexforname(objectivename);
  assertex(!array_contains(level.objective_array[objectiveindex].locations, locationname), "The location - " + locationname + " - is already defined for objective: " + objectivename);
  var_9be69c18c91160a9 = _objective_getnextfreelocationindex(objectiveindex);
  assertex(var_9be69c18c91160a9 < 8, "This objective can only have a limited number of max locations. Can't add more!");
  level.objective_array[objectiveindex].locations[var_9be69c18c91160a9] = locationname;
  objective_setlocation(objectiveindex, var_9be69c18c91160a9, var_8c7c19c9172500f);
  level notify("objectives_updated");
}

function _objective_validatename(objectivename) {
  assertex(!isint(objectivename), "objectiveName needs to be a string - not an integer index. Accessing the script-side index system shouldn't be done explicitly!");
  assertex(isstring(objectivename), "objectiveName needs to be a string!");
}

function _objective_initindexforname(objectivename) {
  _objective_getindexforname(objectivename, 1);
}

function _objective_getindexforname(objectivename, var_2e5a6b3339d8d1e0) {
  assert(isstring(objectivename));

  if(!isDefined(level.objective_array)) {
    level.objective_array = [];
  }

  objectiveindex = -1;

  if(istrue(var_2e5a6b3339d8d1e0)) {
    assertex(!objective_exists(objectivename), "An objective with this name was already added: " + objectivename);
    objectiveindex = _objective_getnextfreeobjectiveindex();
    level.objective_array[objectiveindex] = spawnStruct();
    level.objective_array[objectiveindex].objectivename = objectivename;
    level.objective_array[objectiveindex].locations = [];
    level.objective_array[objectiveindex].objid = objectiveindex;

    if(!objective_isunlimited()) {
      objective_delete(objectiveindex);
    }
  } else if(objective_isunlimited()) {
    foreach(obj in level.objective_array) {
      if(isDefined(obj) && isDefined(obj.objectivename) && obj.objectivename == objectivename) {
        objectiveindex = obj.objid;
        break;
      }
    }
  } else {
    assert(level.objective_array.size <= 32);

    for(i = 0; i < 32; i++) {
      if(isDefined(level.objective_array[i]) && isDefined(level.objective_array[i].objectivename) && level.objective_array[i].objectivename == objectivename) {
        objectiveindex = i;
        break;
      }
    }
  }

  assertex(objectiveindex >= 0, "The objective - " + objectivename + " - could not be found!");
  assert(objective_exists(objectivename));
  return objectiveindex;
}

function _objective_getnextfreelocationindex(objectiveindex) {
  assert(isDefined(level.objective_array));
  objectivelocations = level.objective_array[objectiveindex].locations;

  for(i = 0; i < 8; i++) {
    if(!isDefined(objectivelocations[i])) {
      return i;
    }

    if(objectivelocations[i] == "") {
      return i;
    }
  }

  assertmsg("Can't add another location, we are already at capacity: " + 8);
}

function _objective_getnextfreeobjectiveindex() {
  if(objective_isunlimited()) {
    return objective_create();
  }

  assert(isDefined(level.objective_array));

  for(i = 0; i < 32; i++) {
    if(!isDefined(level.objective_array[i])) {
      return i;
    }
  }

  assertmsg("Can't add another objective, we are already at capacity: " + 32);
}

function function_bb9ff75fdab01612(boolean) {
  level.var_58d876adc5a3a383.enabled = boolean;

  if(istrue(level.var_58d876adc5a3a383.enabled)) {
    function_51fa6750df4678ca();
  }
}

function function_51fa6750df4678ca(delay_time) {
  if(!isDefined(level.var_58d876adc5a3a383.delay_time) || !isDefined(delay_time)) {
    level.var_58d876adc5a3a383.delay_time = 180000;
  }

  if(isDefined(delay_time) && delay_time > 0) {
    level.var_58d876adc5a3a383.delay_time = delay_time;
  }

  level.var_58d876adc5a3a383.next_time = gettime() + level.var_58d876adc5a3a383.delay_time;
}

function function_198bcf281b9c6e01(duration) {
  if(!isDefined(duration) || duration == 0) {
    duration = 180000;
  } else {
    duration *= 1000;
  }

  level.var_58d876adc5a3a383.delay_time = duration;
  function_51fa6750df4678ca(duration);
}

function function_6294c59db36291e6(var_9f34c2c1d6c74955) {
  if(isDefined(var_9f34c2c1d6c74955)) {
    if(var_9f34c2c1d6c74955 == 0) {
      thread function_78a5f36ae600540();
      function_51fa6750df4678ca();
      return;
    }

    var_9f34c2c1d6c74955 = int(var_9f34c2c1d6c74955 * 1000);
    function_51fa6750df4678ca(var_9f34c2c1d6c74955);
  }

  function_51fa6750df4678ca(var_9f34c2c1d6c74955);
}

function function_f420c7fbd15a416b() {
  level endon("game_ended");
  println("<dev string:x1c>");
  level.var_58d876adc5a3a383 = spawnStruct();
  function_bb9ff75fdab01612(0);
  function_51fa6750df4678ca();
  childthread function_17b90f3fe7fbd28f();

  while(true) {
    cur_time = gettime();

    if(function_d0acca3f41921ad2()) {
      function_51fa6750df4678ca();
    } else if(level.var_58d876adc5a3a383.next_time <= cur_time || istrue(level.var_58d876adc5a3a383.forced)) {
      if(istrue(level.var_58d876adc5a3a383.enabled)) {
        thread function_78a5f36ae600540();
        self waittill("objective_reminder_end");
        function_51fa6750df4678ca();
      }
    }

    wait 5;
  }
}

function function_78a5f36ae600540() {
  focus_display_hint(undefined, undefined, level.player, "objective_reminder_end");

  if(getdvarint(@ "hash_cbacc26f16af0e07", 0) > 0) {
    iprintlnbold("<dev string:x37>");
  }

  end_time = gettime() + 10000;

  while(gettime() < end_time || istrue(level.var_58d876adc5a3a383.forced)) {
    if(function_d0acca3f41921ad2()) {
      break;
    }

    waitframe();
  }

  function_3895aa5d9337bee1();
}

function function_3895aa5d9337bee1() {
  level.player notify("objective_reminder_end");

  if(getdvarint(@ "hash_cbacc26f16af0e07", 0) > 0) {
    iprintlnbold("<dev string:x50>");
  }
}

function function_17b90f3fe7fbd28f() {
  level endon("game_ended");

  while(true) {
    result = waittill_any_ents_return(level.player, "focus_pressed", level, "objectives_updated", level, "player_linked_to_rig");

    if(getdvarint(@ "hash_cbacc26f16af0e07", 0) > 0) {
      iprintlnbold("<dev string:x72>" + result);
    }

    function_51fa6750df4678ca();
  }
}

function function_d0acca3f41921ad2() {
  return flag("objectives_displayed") || function_d501bbf61ed965b7() == 0 || function_2d6537807828303e() || function_1e4aaaddfd5236ca();
}

function focus_display_hint(timeout, delay, endonentity, endonmessage) {
  display_hint("focus_hint", timeout, delay, endonentity, endonmessage);
}

function function_d501bbf61ed965b7(objectivename) {
  if(!isDefined(level.objective_array)) {
    return 0;
  }

  return level.objective_array.size;
}

function function_2d6537807828303e() {
  return getomnvar("ui_cutscene_active");
}

function function_1e4aaaddfd5236ca() {
  enemies = getaiarrayinradius(level.player.origin, 500, get_enemy_team(level.player.team));

  foreach(nearbyai in enemies) {
    if(isalive(nearbyai) && gettime() - nearbyai lastknowntime(level.player) < 10000) {
      return true;
    }
  }

  return false;
}

function function_e18920c0717c1b4e(boolean) {
  level.player setclientomnvar("ui_objective_reveal_fanfare_enabled", boolean);
}

function function_84126bde5bb3888b(boolean) {
  level.player setclientomnvar("ui_objective_dismiss_fanfare_enabled", boolean);
}

function function_4e1c4a6c6eec1568() {
  return level.player getclientomnvar("ui_objective_reveal_fanfare_enabled");
}

function function_b338aa1e9ec37fbd() {
  level.player setclientomnvar("ui_show_objectives", 1);
  wait 3;
  level.player setclientomnvar("ui_show_objectives", 0);
}

function function_b26ad6615e6cf8ce(start_flag, end_flag) {
  level endon("game_ended");

  if(isDefined(start_flag)) {
    flag_wait(start_flag);
  }

  level.player setclientomnvar("ui_show_objectives", 1);

  if(isDefined(end_flag)) {
    flag_wait(end_flag);
  } else {
    while(true) {
      result = level function_28551e899093b138("objectives_updated_state", "objectives_updated");

      if(result["message"] == "objectives_updated") {
        break;
      }

      if(result[0] != "current" && result[0] != "invisible") {
        break;
      }
    }
  }

  level.player setclientomnvar("ui_show_objectives", 0);
}