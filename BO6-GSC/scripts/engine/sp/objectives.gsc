/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\engine\sp\objectives.gsc
********************************************/

#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#namespace objectives;

function private function_8a0e2c3d960818db(objectivedatastruct) {
  if(!isDefined(objectivedatastruct.objectivename)) {
    objectivedatastruct.objectivename = undefined;
  }

  if(!isDefined(objectivedatastruct.objstate)) {
    objectivedatastruct.objstate = "\f5\xd5\x03\xff";
  }

  if(!isDefined(objectivedatastruct.objposition)) {
    objectivedatastruct.objposition = undefined;
  }

  if(!isDefined(objectivedatastruct.objlabel)) {
    objectivedatastruct.objlabel = undefined;
  }

  if(!isDefined(objectivedatastruct.objiconname)) {
    objectivedatastruct.objiconname = undefined;
  }

  if(!isDefined(objectivedatastruct.objzoffset)) {
    objectivedatastruct.objzoffset = undefined;
  }

  if(!isDefined(objectivedatastruct.objshowdistance)) {
    objectivedatastruct.objshowdistance = 1;
  }

  if(!isDefined(objectivedatastruct.objshowprogress)) {
    objectivedatastruct.objshowprogress = 0;
  }

  if(!isDefined(objectivedatastruct.objshowsplash)) {
    objectivedatastruct.objshowsplash = 1;
  }

  if(!isDefined(objectivedatastruct.objscreenoffsety)) {
    objectivedatastruct.objscreenoffsety = undefined;
  }

  if(!isDefined(objectivedatastruct.objisoptional)) {
    objectivedatastruct.objisoptional = 0;
  }

  if(!isDefined(objectivedatastruct.var_8f3fdb9d6288eb06)) {
    objectivedatastruct.var_8f3fdb9d6288eb06 = undefined;
  }

  if(!isDefined(objectivedatastruct.var_e6edf68d826e8da9)) {
    objectivedatastruct.var_e6edf68d826e8da9 = undefined;
  }

  if(!isDefined(objectivedatastruct.objmaxcount)) {
    objectivedatastruct.objmaxcount = 1;
  }

  if(!isDefined(objectivedatastruct.objcurcount)) {
    objectivedatastruct.objcurcount = 0;
  }

  if(!isDefined(objectivedatastruct.objentitytag)) {
    objectivedatastruct.objentitytag = undefined;
  }

  if(!isDefined(objectivedatastruct.var_4063b9dab5164cca)) {
    objectivedatastruct.var_4063b9dab5164cca = 1;
  }

  if(!isDefined(objectivedatastruct.objdescription)) {
    objectivedatastruct.objdescription = undefined;
  }

  if(!isDefined(objectivedatastruct.objismarked)) {
    objectivedatastruct.objismarked = undefined;
  }

  if(!isDefined(objectivedatastruct.objparent)) {
    objectivedatastruct.objparent = undefined;
  }
}

function objective_add(objectivename = undefined, objstate = "\f5\xd5\x03\xff", objposition = undefined, objdescription = undefined, objlabel = undefined, objiconname = undefined, objzoffset = undefined, objshowdistance = 1, objshowprogress = 0, objshowsplash = 1, objscreenoffsety = undefined, objisoptional = 0, var_8f3fdb9d6288eb06 = undefined, var_e6edf68d826e8da9 = undefined, objmaxcount = 1, objcurcount = 0, objentitytag = undefined, var_4063b9dab5164cca = 1, objparent = undefined) {
  objectivedatastruct = spawnStruct();
  objectivedatastruct.objectivename = objectivename;
  objectivedatastruct.objstate = objstate;
  objectivedatastruct.objposition = objposition;
  objectivedatastruct.objdescription = objdescription;
  objectivedatastruct.objlabel = objlabel;
  objectivedatastruct.objiconname = objiconname;
  objectivedatastruct.objzoffset = objzoffset;
  objectivedatastruct.objshowdistance = objshowdistance;
  objectivedatastruct.objshowprogress = objshowprogress;
  objectivedatastruct.objshowsplash = objshowsplash;
  objectivedatastruct.objscreenoffsety = objscreenoffsety;
  objectivedatastruct.objisoptional = objisoptional;
  objectivedatastruct.var_8f3fdb9d6288eb06 = var_8f3fdb9d6288eb06;
  objectivedatastruct.var_e6edf68d826e8da9 = var_e6edf68d826e8da9;
  objectivedatastruct.objmaxcount = objmaxcount;
  objectivedatastruct.objcurcount = objcurcount;
  objectivedatastruct.objentitytag = objentitytag;
  objectivedatastruct.var_4063b9dab5164cca = var_4063b9dab5164cca;
  objectivedatastruct.objparent = objparent;
  return function_4d704611e992235e(objectivedatastruct);
}

function function_4d704611e992235e(objectivedatastruct) {
  function_8a0e2c3d960818db(objectivedatastruct);
  return function_352e34fae43afebd(objectivedatastruct);
}

function private function_352e34fae43afebd(objectivedatastruct) {
  _objective_validatename(objectivedatastruct.objectivename);
  objectiveindex = _objective_initindexforname(objectivedatastruct.objectivename);
  objective_update_internal(objectivedatastruct);

  if(istrue(objectivedatastruct.objshowsplash) && isDefined(level.objectives_splash) && isDefined(objectivedatastruct.objdescription) && isDefined(level.objectives_splash.callback)) {
    level utility::flag_wait("X\x1bo\xae\x06\x90l\xc0\x11\xbc\xa9{\xec)\x19\xabh7t\x9a\xb7Y\xb6\xd6\x90\x06e]");
    objcomplete = 0;

    if(objectivedatastruct.objmaxcount > 1) {
      function_b7f9bf096a3d0141(objectiveindex, objectivedatastruct.objcurcount, objectivedatastruct.objmaxcount);
    }

    level.player[[level.objectives_splash.callback]](objectivedatastruct.objectivename, objectivedatastruct.objdescription, objectivedatastruct.var_8f3fdb9d6288eb06, objectivedatastruct.var_e6edf68d826e8da9, objectivedatastruct.objmaxcount, objectivedatastruct.objcurcount, objectivedatastruct.objisoptional, objectivedatastruct.objcomplete);
  }

  if(istrue(objectivedatastruct.objisoptional)) {
    function_311939d85d8658e6(objectiveindex, objectivedatastruct.objisoptional);
  }

  return objectiveindex;
}

function function_9e0b1a3890138a95(callback_func) {
  assert(isDefined(level.objectives_splash));
  level.objectives_splash.callback = callback_func;
}

function objective_update(objectivename, objstate, objposition, objdescription, objlabel, objiconname, objzoffset, objshowdistance, objshowprogress, objscreenoffsety, objentitytag, var_4063b9dab5164cca, objismarked, objparent) {
  objectivedatastruct = spawnStruct();
  objectivedatastruct.objectivename = objectivename;
  objectivedatastruct.objstate = objstate;
  objectivedatastruct.objposition = objposition;
  objectivedatastruct.objdescription = objdescription;
  objectivedatastruct.objlabel = objlabel;
  objectivedatastruct.objiconname = objiconname;
  objectivedatastruct.objzoffset = objzoffset;
  objectivedatastruct.objshowdistance = objshowdistance;
  objectivedatastruct.objshowprogress = objshowprogress;
  objectivedatastruct.objscreenoffsety = objscreenoffsety;
  objectivedatastruct.objentitytag = objentitytag;
  objectivedatastruct.var_4063b9dab5164cca = var_4063b9dab5164cca;
  objectivedatastruct.objismarked = objismarked;
  objectivedatastruct.objparent = objparent;
  function_403545979e879c7a(objectivedatastruct);
  return objectivedatastruct;
}

function function_403545979e879c7a(objectivedatastruct) {
  function_8a0e2c3d960818db(objectivedatastruct);
  objective_update_internal(objectivedatastruct);
}

function private objective_update_internal(objectivedatastruct) {
  _objective_validatename(objectivedatastruct.objectivename);
  assert(objective_exists(objectivedatastruct.objectivename), "<dev string:x24>" + objectivedatastruct.objectivename + "<dev string:x3c>");

  if(isDefined(objectivedatastruct.objstate)) {
    objective_set_state(objectivedatastruct.objectivename, objectivedatastruct.objstate, 0);
  }

  if(isDefined(objectivedatastruct.objposition)) {
    if(isent(objectivedatastruct.objposition)) {
      objective_set_on_entity(objectivedatastruct.objectivename, objectivedatastruct.objectivename, objectivedatastruct.objposition, 0);

      if(isDefined(objectivedatastruct.objentitytag)) {
        function_b2fa5f16ecff924d(objectivedatastruct.objectivename, objectivedatastruct.objentitytag, 0);
      }
    } else {
      objective_set_position(objectivedatastruct.objectivename, objectivedatastruct.objposition, 0);
    }
  }

  if(isDefined(objectivedatastruct.objdescription)) {
    objective_set_description(objectivedatastruct.objectivename, objectivedatastruct.objdescription, 0);
  }

  if(isDefined(objectivedatastruct.objlabel)) {
    objective_set_label(objectivedatastruct.objectivename, objectivedatastruct.objlabel, 0);
  }

  if(isDefined(objectivedatastruct.objiconname)) {
    objective_set_icon(objectivedatastruct.objectivename, objectivedatastruct.objiconname, 0);
  }

  if(isDefined(objectivedatastruct.objzoffset)) {
    objective_set_z_offset(objectivedatastruct.objectivename, objectivedatastruct.objzoffset, 0);
  }

  if(isDefined(objectivedatastruct.objshowdistance)) {
    objective_set_show_distance(objectivedatastruct.objectivename, objectivedatastruct.objshowdistance, 0);
  }

  if(isDefined(objectivedatastruct.objshowprogress)) {
    objective_set_show_progress(objectivedatastruct.objectivename, objectivedatastruct.objshowprogress, 0);
  }

  if(isDefined(objectivedatastruct.objscreenoffsety)) {
    function_999d6a8b6e09b1b3(objectivedatastruct.objectivename, objectivedatastruct.objscreenoffsety, 0);
  }

  if(isDefined(objectivedatastruct.objismarked)) {
    function_77271db8e5d72965(objectivedatastruct.objectivename, objectivedatastruct.objismarked);
  }

  if(isDefined(objectivedatastruct.objparent)) {
    function_aa0b4b04d5272f95(objectivedatastruct.objectivename, objectivedatastruct.objparent);
  }

  if(objectivedatastruct.var_4063b9dab5164cca) {
    level notify("\x03\xf6\x16\xc1\x8e\x9e#\xcbz\xb0\x97\xb9\xbc\xb0L\x1d[\xbc");
    return;
  }

  level notify("\xbbe\xe1D\x17\x96\b\xd0R\xb4\xe1\xbb\x8d\xab\x84\xb3\xd7\x8e\x92\x89\f\xfb\xae\x17\v\x90");
}

function objective_remove(objectivename) {
  assert(objective_exists(objectivename));
  objectiveindex = _objective_getindexforname(objectivename);
  level.objective_array[objectiveindex] = undefined;
  objective_delete(objectiveindex);
  level notify("\x03\xf6\x16\xc1\x8e\x9e#\xcbz\xb0\x97\xb9\xbc\xb0L\x1d[\xbc");
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

function objective_complete(objectivename = undefined, objshowsplash = 0, objtitle = undefined, var_1b151ff59a425d82 = undefined, var_b2db06a99c7aa059 = 0, objisoptional = 0) {
  assert(objective_exists(objectivename), "<dev string:x24>" + objectivename + "<dev string:x3c>");
  objective_set_state(objectivename, "\x7f5dI");

  if(istrue(objshowsplash) && isDefined(level.objectives_splash) && isDefined(level.objectives_splash.callback)) {
    level.player[[level.objectives_splash.callback]](objectivename, objtitle, var_1b151ff59a425d82, undefined, 0, 0, objisoptional, 1, var_b2db06a99c7aa059);
  }

  objectiveindex = _objective_getindexforname(objectivename);
}

function objective_show_progress(objectivename = undefined, objdescription = undefined, objcurcount = 0, objmaxcount = 1, var_8f3fdb9d6288eb06 = undefined, var_e6edf68d826e8da9 = undefined, var_7f283ebb6eb0c0d6 = 0) {
  objectivedatastruct = spawnStruct();
  objectivedatastruct.objectivename = objectivename;
  objectivedatastruct.objdescription = objdescription;
  objectivedatastruct.objcurcount = objcurcount;
  objectivedatastruct.var_8f3fdb9d6288eb06 = var_8f3fdb9d6288eb06;
  objectivedatastruct.var_e6edf68d826e8da9 = var_e6edf68d826e8da9;
  objectivedatastruct.objmaxcount = objmaxcount;
  objectivedatastruct.objisoptional = var_7f283ebb6eb0c0d6;
  return function_f33759def624338(objectivedatastruct);
}

function function_f33759def624338(objectivedatastruct) {
  function_8a0e2c3d960818db(objectivedatastruct);
  return function_579067e8db097a43(objectivedatastruct);
}

function private function_579067e8db097a43(objectivedatastruct) {
  assert(objective_exists(objectivedatastruct.objectivename), "<dev string:x24>" + objectivedatastruct.objectivename + "<dev string:x3c>");

  if(isDefined(level.objectives_splash) && isDefined(level.objectives_splash.callback)) {
    objcomplete = 0;
    level.player[[level.objectives_splash.callback]](objectivedatastruct.objectivename, objectivedatastruct.objdescription, objectivedatastruct.var_8f3fdb9d6288eb06, objectivedatastruct.var_e6edf68d826e8da9, objectivedatastruct.objmaxcount, objectivedatastruct.objcurcount, objectivedatastruct.objisoptional);
  }

  objectiveindex = _objective_getindexforname(objectivedatastruct.objectivename);

  if(objectivedatastruct.objmaxcount > 1) {
    setomnvar("oL5\xcac\x1d\xb4vY\xebn\x1c\x8das\r\xaf-7}o\x0e\xa3K\xdenX\xd8", objectivedatastruct.objisoptional);
    function_b7f9bf096a3d0141(objectiveindex, objectivedatastruct.objcurcount, objectivedatastruct.objmaxcount);
  }

  return objectiveindex;
}

function function_aa0b4b04d5272f95(subobjectivename, parentobjectivename) {
  objective_setparentobjective(_objective_getindexforname(subobjectivename), _objective_getindexforname(parentobjectivename));
}

function objective_set_state(objectivename, objstate, shouldfirenotify = 1) {
  _objective_validatename(objectivename);
  assert(isstring(objstate));
  assert(objstate == "<dev string:x4f>" || objstate == "<dev string:x58>" || objstate == "<dev string:x62>" || objstate == "<dev string:x6f>" || objstate == "<dev string:x77>" || objstate == "<dev string:x82>", "<dev string:x8c>" + objstate + "<dev string:x9f>");
  objectiveindex = _objective_getindexforname(objectivename);
  objective_state(objectiveindex, objstate);

  if(shouldfirenotify) {
    level notify("\x03\xf6\x16\xc1\x8e\x9e#\xcbz\xb0\x97\xb9\xbc\xb0L\x1d[\xbc");
  }

  level notify("1\x92\xbd\xdd\x83{$\xd6\xdcg\xd3\x13>\\Cn(\xa6\xf6\xc1\x1d\xd6\xc0\xae", objstate);
}

function objective_set_position(objectivename, objposition, shouldfirenotify = 1) {
  _objective_validatename(objectivename);
  assert(isvector(objposition));
  objectiveindex = _objective_getindexforname(objectivename);
  objective_position(objectiveindex, objposition);

  if(shouldfirenotify) {
    level notify("\x03\xf6\x16\xc1\x8e\x9e#\xcbz\xb0\x97\xb9\xbc\xb0L\x1d[\xbc");
  }
}

function objective_set_description(objectivename, objdescription, shouldfirenotify = 1) {
  _objective_validatename(objectivename);
  assert(isstring(objdescription) || isistring(objdescription));
  objectiveindex = _objective_getindexforname(objectivename);
  objective_setdescription(objectiveindex, objdescription);

  if(shouldfirenotify) {
    level notify("\x03\xf6\x16\xc1\x8e\x9e#\xcbz\xb0\x97\xb9\xbc\xb0L\x1d[\xbc");
  }
}

function objective_set_label(objectivename, objlabel, shouldfirenotify = 1) {
  _objective_validatename(objectivename);
  assert(isstring(objlabel) || isistring(objlabel));
  objectiveindex = _objective_getindexforname(objectivename);
  objective_setlabel(objectiveindex, objlabel);

  if(shouldfirenotify) {
    level notify("\x03\xf6\x16\xc1\x8e\x9e#\xcbz\xb0\x97\xb9\xbc\xb0L\x1d[\xbc");
  }
}

function objective_set_icon(objectivename, objiconname, shouldfirenotify = 1) {
  _objective_validatename(objectivename);
  assert(isstring(objiconname));
  objectiveindex = _objective_getindexforname(objectivename);
  objective_icon(objectiveindex, objiconname);

  if(shouldfirenotify) {
    level notify("\x03\xf6\x16\xc1\x8e\x9e#\xcbz\xb0\x97\xb9\xbc\xb0L\x1d[\xbc");
  }
}

function objective_set_z_offset(objectivename, objzoffset, shouldfirenotify = 1) {
  _objective_validatename(objectivename);
  assert(isint(objzoffset) || isfloat(objzoffset));
  objectiveindex = _objective_getindexforname(objectivename);
  objective_setzoffset(objectiveindex, objzoffset);

  if(shouldfirenotify) {
    level notify("\x03\xf6\x16\xc1\x8e\x9e#\xcbz\xb0\x97\xb9\xbc\xb0L\x1d[\xbc");
  }
}

function function_999d6a8b6e09b1b3(objectivename, objscreenoffsety, shouldfirenotify = 1) {
  _objective_validatename(objectivename);
  assert(isint(objscreenoffsety) || isfloat(objscreenoffsety));
  objectiveindex = _objective_getindexforname(objectivename);
  function_ebb1dab23d23fbf2(objectiveindex, objscreenoffsety);

  if(shouldfirenotify) {
    level notify("\x03\xf6\x16\xc1\x8e\x9e#\xcbz\xb0\x97\xb9\xbc\xb0L\x1d[\xbc");
  }
}

function function_3a6ffa76cf8d99a1(objectivename) {
  _objective_validatename(objectivename);
  function_999d6a8b6e09b1b3(objectivename, -55);
}

function function_c1586c7b8435b621(objectivename) {
  _objective_validatename(objectivename);
  function_b2fa5f16ecff924d(objectivename, "\xa6\xeb\x1ae\x85#");
  objective_set_z_offset(objectivename, 25);
}

function objective_set_show_distance(objectivename, objshowdistance, shouldfirenotify = 1) {
  _objective_validatename(objectivename);
  assert(isint(objshowdistance));
  objectiveindex = _objective_getindexforname(objectivename);
  objective_setshowdistance(objectiveindex, objshowdistance);

  if(shouldfirenotify) {
    level notify("\x03\xf6\x16\xc1\x8e\x9e#\xcbz\xb0\x97\xb9\xbc\xb0L\x1d[\xbc");
  }
}

function objective_set_show_progress(objectivename, objshowprogress, shouldfirenotify = 1) {
  _objective_validatename(objectivename);
  assert(isint(objshowprogress));
  objectiveindex = _objective_getindexforname(objectivename);
  objective_setshowprogress(objectiveindex, objshowprogress);

  if(shouldfirenotify) {
    level notify("\x03\xf6\x16\xc1\x8e\x9e#\xcbz\xb0\x97\xb9\xbc\xb0L\x1d[\xbc");
  }
}

function function_77271db8e5d72965(objectivename, objmarked) {
  _objective_validatename(objectivename);
  assert(isint(objmarked));
  objectiveindex = _objective_getindexforname(objectivename);
  objective_setmarked(objectiveindex, objmarked);
}

function function_c189022d1ae40deb(objectivename, var_922d7e5f819c1d38) {
  _objective_validatename(objectivename);
  assert(isint(var_922d7e5f819c1d38));
  objectiveindex = _objective_getindexforname(objectivename);
  function_7775bcf5ffdf4de3(objectiveindex, var_922d7e5f819c1d38);
}

function function_b96e99f61a5c9bc(objectivesnamearray, shouldmark) {
  foreach(objectivename in objectivesnamearray) {
    function_77271db8e5d72965(objectivename, shouldmark);
  }

  level notify("\xbbe\xe1D\x17\x96\b\xd0R\xb4\xe1\xbb\x8d\xab\x84\xb3\xd7\x8e\x92\x89\f\xfb\xae\x17\v\x90");
}

function objective_set_on_entity(objectivename, locationname, locationentity, shouldfirenotify = 1) {
  _objective_validatename(objectivename);
  assert(isent(locationentity));
  objectiveindex = _objective_getindexforname(objectivename);

  if(level.objective_array[objectiveindex].locations.size > 0) {
    utility::error("\xc0\xc8\xee\x93\x9f'\x9d/a\xf8-}\x1b\x9ehFS\xfe\x19\xafm\x8cx\xe06@\xc9j\xcct\x95\x9b\v9EeC\xc7\x19\xaf@\xdf\xb0_wnk\x91\xf6\x87\x13bC\xf6\x97\xa5oZL\xbc\xb6\xb7h&\xf2v\x0fF%8\xd5\xde8 \xa9\xd6\xc4\xe5\xbb1&\xe8&\xae\xe5B\x1b\xdc\xf5:\xbc\xda\xd1\x01\xce\xa0w");
    objective_remove_all_locations(objectivename);
  }

  level.objective_array[objectiveindex].locations[0] = locationname;
  objective_onentity(objectiveindex, locationentity);

  if(shouldfirenotify) {
    level notify("\x03\xf6\x16\xc1\x8e\x9e#\xcbz\xb0\x97\xb9\xbc\xb0L\x1d[\xbc");
  }
}

function function_b2fa5f16ecff924d(objectivename, entitytag, shouldfirenotify = 1) {
  _objective_validatename(objectivename);
  assert(isstring(entitytag) || isistring(entitytag));
  objectiveindex = _objective_getindexforname(objectivename);
  function_7e0f86734e5f7c89(objectiveindex, entitytag);

  if(shouldfirenotify) {
    level notify("\x03\xf6\x16\xc1\x8e\x9e#\xcbz\xb0\x97\xb9\xbc\xb0L\x1d[\xbc");
  }
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
  objectivelocationindex = -1;
  objectiveindex = _objective_getindexforname(objectivename);
  objectivelocations = level.objective_array[objectiveindex].locations;

  foreach(location in objectivelocations) {
    if(isDefined(location) && location == locationname) {
      objectivelocationindex = locationindex;
      break;
    }
  }

  assert(objectivelocationindex >= 0, "<dev string:xf4>" + locationname + "<dev string:x107>" + objectivename);
  level.objective_array[objectiveindex].locations[objectivelocationindex] = undefined;
  objective_unsetlocation(objectiveindex, objectivelocationindex);
  level notify("\x03\xf6\x16\xc1\x8e\x9e#\xcbz\xb0\x97\xb9\xbc\xb0L\x1d[\xbc", "\x94o_\xf9|\x88\x90\xcf");
}

function function_f17fe81c22301e7a(objectivename, locationname) {
  assert(objective_exists(objectivename));
  assert(isstring(locationname));
  objectivelocationindex = -1;
  objectiveindex = _objective_getindexforname(objectivename);
  objectivelocations = level.objective_array[objectiveindex].locations;

  foreach(location in objectivelocations) {
    if(isDefined(location) && location == locationname) {
      objectivelocationindex = locationindex;
      break;
    }
  }

  return objectivelocationindex >= 0;
}

function objective_remove_all_locations(objectivename) {
  assert(objective_exists(objectivename));
  objectiveindex = _objective_getindexforname(objectivename);

  for(locationindex = 0; locationindex < 8; locationindex++) {
    objective_unsetlocation(objectiveindex, locationindex);
  }

  level.objective_array[objectiveindex].locations = [];
  level notify("\x03\xf6\x16\xc1\x8e\x9e#\xcbz\xb0\x97\xb9\xbc\xb0L\x1d[\xbc");
}

function function_300f209371f3670d(scaledistance) {
  if(!isDefined(scaledistance)) {
    scaledistance = 1000;
  }

  setomnvar(":/^\x99T\x1c\xbb\xfc\xf26B\xd1L\x96\xb6\x10n\x19z\xd7\x98\x7fy\xf0\xc4g\xf1", scaledistance);
}

function function_8c83b31d330529e(index) {
  if(level.objective_array != undefined && level.objective_array.size) {
    return level.objective_array[index];
  }

  return undefined;
}

function _objective_addlocation(objectivename, locationname, var_53962f3989d549d6) {
  assert(objective_exists(objectivename));
  assert(isstring(locationname));
  objectiveindex = _objective_getindexforname(objectivename);
  assert(!arraycontains(level.objective_array[objectiveindex].locations, locationname), "<dev string:xf4>" + locationname + "<dev string:x12d>" + objectivename);
  objectivelocationindex = _objective_getnextfreelocationindex(objectiveindex);
  assert(objectivelocationindex < 8, "<dev string:x156>");
  level.objective_array[objectiveindex].locations[objectivelocationindex] = locationname;
  objective_setlocation(objectiveindex, objectivelocationindex, var_53962f3989d549d6);
  level notify("\x03\xf6\x16\xc1\x8e\x9e#\xcbz\xb0\x97\xb9\xbc\xb0L\x1d[\xbc");
}

function _objective_validatename(objectivename) {
  assert(!isint(objectivename), "<dev string:x1a9>");
  assert(isstring(objectivename), "<dev string:x22c>");
}

function _objective_initindexforname(objectivename) {
  return _objective_getindexforname(objectivename, 1);
}

function _objective_getindexforname(objectivename, isnewobjective) {
  assert(isstring(objectivename));

  if(!isDefined(level.objective_array)) {
    level.objective_array = [];
  }

  objectiveindex = -1;

  if(istrue(isnewobjective)) {
    assert(!objective_exists(objectivename), "<dev string:x253>" + objectivename);
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

  assert(objectiveindex >= 0, "<dev string:x286>" + objectivename + "<dev string:x29a>");
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

  assertmsg("<dev string:x2b4>" + 8);
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

  assertmsg("<dev string:x2f0>" + 32);
}

function function_42319356ab46b03(boolean) {
  level.objective_reminder.enabled = boolean;

  if(istrue(level.objective_reminder.enabled)) {
    function_5c0640f2fae52593();
  }
}

function function_5c0640f2fae52593(delay_time) {
  if(!(isDefined(level.objective_reminder.delay_time) && isDefined(delay_time))) {
    level.objective_reminder.delay_time = 180000;
  }

  if(isDefined(delay_time) && delay_time > 0) {
    level.objective_reminder.delay_time = delay_time;
  }

  level.objective_reminder.next_time = gettime() + level.objective_reminder.delay_time;
}

function function_31d29fe0b5463868(duration) {
  if(!isDefined(duration) || duration == 0) {
    duration = 180000;
  } else {
    duration *= 1000;
  }

  level.objective_reminder.delay_time = duration;
  function_5c0640f2fae52593(duration);
}

function function_42aa266610f59a3(var_503f26a664fadd60) {
  if(isDefined(var_503f26a664fadd60)) {
    if(var_503f26a664fadd60 == 0) {
      thread function_974cd09953748f65();
      function_5c0640f2fae52593();
      return;
    }

    var_503f26a664fadd60 = int(var_503f26a664fadd60 * 1000);
    function_5c0640f2fae52593(var_503f26a664fadd60);
  }

  function_5c0640f2fae52593(var_503f26a664fadd60);
}

function function_db1a8c8d97b93be() {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  println("<dev string:x32d>");
  level.objective_reminder = spawnStruct();
  function_42319356ab46b03(0);
  function_5c0640f2fae52593();
  childthread function_cd95a75187059d16();

  while(true) {
    cur_time = gettime();

    if(function_4c1db615602ea94f()) {
      function_5c0640f2fae52593();
    } else if(level.objective_reminder.next_time <= cur_time || istrue(level.objective_reminder.forced)) {
      if(istrue(level.objective_reminder.enabled)) {
        thread function_974cd09953748f65();
        self waittill("'\x8a.\xe4\xc3u\x1cp\xbfOY<\x96\xf3\x8f\x12\xb99\x12\xee\x16h");
        function_5c0640f2fae52593();
      }
    }

    wait 5;
  }
}

function function_974cd09953748f65() {
  focus_display_hint(undefined, undefined, level.player, "'\x8a.\xe4\xc3u\x1cp\xbfOY<\x96\xf3\x8f\x12\xb99\x12\xee\x16h");

  if(getdvarint(@ "hash_cbacc26f16af0e07", 0) > 0) {
    iprintlnbold("<dev string:x34b>");
  }

  end_time = gettime() + 10000;

  while(gettime() < end_time || istrue(level.objective_reminder.forced)) {
    if(function_4c1db615602ea94f()) {
      break;
    }

    waitframe();
  }

  function_f54dfe31e7147f0c();
}

function function_f54dfe31e7147f0c() {
  level.player notify("'\x8a.\xe4\xc3u\x1cp\xbfOY<\x96\xf3\x8f\x12\xb99\x12\xee\x16h");

  if(getdvarint(@ "hash_cbacc26f16af0e07", 0) > 0) {
    iprintlnbold("<dev string:x367>");
  }
}

function function_cd95a75187059d16() {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");

  while(true) {
    result = utility::waittill_any_ents_return(level.player, "3\xb7\xc6\xab7\xfa\x0e\xe4\xca\x9b7e#", level, "\x03\xf6\x16\xc1\x8e\x9e#\xcbz\xb0\x97\xb9\xbc\xb0L\x1d[\xbc", level, "\xee\xc8\xf0\xc9\x1fg\xfav\xcb\xee5\xd7\x8c'\x15\xfe\xd5op\xf5");

    if(getdvarint(@ "hash_cbacc26f16af0e07", 0) > 0) {
      iprintlnbold("<dev string:x38c>" + result);
    }

    function_5c0640f2fae52593();
  }
}

function function_4c1db615602ea94f() {
  return utility::flag("\xc1\x9ez\\a\xa5pA)c\x1d\xc9\xc5\xe6_\xdc\xa9\xeb\xf2o") || function_5510ea282342523a() == 0 || function_6f790995914fcb73() || function_36f8e535adeae48b();
}

function focus_display_hint(timeout, delay, endonentity, endonmessage) {
  utility_sp::display_hint("\xce\x9d\xa1E\xe8P\xdf\x97\ri", timeout, delay, endonentity, endonmessage);
}

function function_5510ea282342523a(objectivename) {
  if(!isDefined(level.objective_array)) {
    return 0;
  }

  return level.objective_array.size;
}

function function_6f790995914fcb73() {
  return getomnvar("\xc8\x16\xc1\xc4\x02MA\xf8\xa9\xbbEAr7\x15d\xcd\x15");
}

function function_36f8e535adeae48b() {
  enemies = getaiarrayinradius(level.player.origin, 500, utility::get_enemy_team(level.player.team));

  foreach(nearbyai in enemies) {
    if(isalive(nearbyai) && gettime() - nearbyai lastknowntime(level.player) < 10000) {
      return true;
    }
  }

  return false;
}

function function_855c89a7a26f4ae3(boolean) {
  level.player setclientomnvar("y\x1aN5\x1b\x18\xd4>0{u\xcf\x99\xd20\r!@R!\xd43E\xdd\"7\x19__M0E\x92\x01\x06", boolean);
}

function function_4f47376a2e860032(boolean) {
  level.player setclientomnvar("\xeaZ\xd7\xed\x13\x9a\xac\x1b:\xb4\xec\xca\xafF\xb4\xb9\xb5K\xe6\xdc\xd7fX\xdcf\x85\xc9+\xfa+\xcd\x16\x98\xc6e\x8c", boolean);
}

function function_8f5906bfeecee02d() {
  return level.player getclientomnvar("y\x1aN5\x1b\x18\xd4>0{u\xcf\x99\xd20\r!@R!\xd43E\xdd\"7\x19__M0E\x92\x01\x06");
}

function function_6a716326b0952674() {
  level.player setclientomnvar("S\xa0Z\xdf\xf6\xdc\xbe\x99\xe0\x06~ >\xaet\x10\xf1=", 1);
  wait 5;
  level.player setclientomnvar("S\xa0Z\xdf\xf6\xdc\xbe\x99\xe0\x06~ >\xaet\x10\xf1=", 0);
}

function function_4881eaecaf586017(start_flag, end_flag) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");

  if(isDefined(start_flag)) {
    utility::flag_wait(start_flag);
  }

  level.player setclientomnvar("S\xa0Z\xdf\xf6\xdc\xbe\x99\xe0\x06~ >\xaet\x10\xf1=", 1);

  if(isDefined(end_flag)) {
    utility::flag_wait(end_flag);
  } else {
    while(true) {
      result = level utility::function_83d4645466d36f1d("1\x92\xbd\xdd\x83{$\xd6\xdcg\xd3\x13>\\Cn(\xa6\xf6\xc1\x1d\xd6\xc0\xae", "\x03\xf6\x16\xc1\x8e\x9e#\xcbz\xb0\x97\xb9\xbc\xb0L\x1d[\xbc");

      if(result["\xa0+4i\xca\b\xf3"] == "\x03\xf6\x16\xc1\x8e\x9e#\xcbz\xb0\x97\xb9\xbc\xb0L\x1d[\xbc") {
        break;
      }

      if(result[0] != "\x96\x99\x05\x0en\x80\xc0" && result[0] != "\x194\xc9\x879\xc7\xbe\xb2\xb6") {
        break;
      }
    }
  }

  level.player setclientomnvar("S\xa0Z\xdf\xf6\xdc\xbe\x99\xe0\x06~ >\xaet\x10\xf1=", 0);
}