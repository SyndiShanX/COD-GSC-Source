/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_46d1e884b696efc3.gsc
*****************************************************/

#namespace spatial_grid;

function create_category(var_7bdff97009197402, var_c64b7d522b7f4728 = 0, var_214e4112306fa828 = 0) {
  assert(isDefined(level));

  if(!isDefined(level.spatialgrid)) {
    level.spatialgrid = spawnStruct();
    level.spatialgrid.categories = [];
    level.spatialgrid.var_6e5b98a5775cb1fd = 1;
  }

  if(isDefined(level.spatialgrid.categories[var_7bdff97009197402])) {
    assert(var_214e4112306fa828);
    return level.spatialgrid.categories[var_7bdff97009197402];
  }

  level.spatialgrid.categories[var_7bdff97009197402] = spawnStruct();
  category = level.spatialgrid.categories[var_7bdff97009197402];
  category.objarray = [];
  category.intid = level.spatialgrid.var_6e5b98a5775cb1fd;
  category.var_c64b7d522b7f4728 = var_c64b7d522b7f4728;
  level.spatialgrid.var_6e5b98a5775cb1fd++;
  assert(level.spatialgrid.var_6e5b98a5775cb1fd < 254);
  return category;
}

function function_9610dcc083b0f8c8(var_7bdff97009197402) {
  return isDefined(level.spatialgrid.categories[var_7bdff97009197402]);
}

function add(var_7bdff97009197402, obj) {
  assert(isDefined(obj));
  assert(isstring(var_7bdff97009197402));
  category = level function_6038b7a51a411204(var_7bdff97009197402);
  add_helper(category, obj);
}

function add_array(var_7bdff97009197402, objarray) {
  assert(isDefined(objarray));
  assert(isstring(var_7bdff97009197402));
  category = level function_6038b7a51a411204(var_7bdff97009197402);

  foreach(obj in objarray) {
    add_helper(category, obj);
  }
}

function private add_helper(category, obj) {
  idx = category.objarray.size;

  if(category.var_c64b7d522b7f4728) {
    category.objarray[idx] = spawnStruct();
    objelement = category.objarray[idx];
    objelement.obj = obj;
    obj.var_93644fc0c12b68b2 = spatialgridadd(category.intid, idx, obj.origin);
    return;
  }

  category.objarray[idx] = obj;
  spatialgridadd(category.intid, idx, obj.origin);
}

function remove(var_7bdff97009197402, obj) {
  assert(isDefined(obj));
  assert(isstring(var_7bdff97009197402));

  if(!isDefined(level.spatialgrid) || !isDefined(level.spatialgrid.categories[var_7bdff97009197402])) {
    assertmsg("<dev string:x24>");
    return;
  }

  category = level.spatialgrid.categories[var_7bdff97009197402];

  if(!category.var_c64b7d522b7f4728) {
    assertmsg("<dev string:x59>");
    return;
  }

  if(!isDefined(obj.var_93644fc0c12b68b2)) {
    assertmsg("<dev string:x81>");
    return;
  }

  spatialgridremove(obj.var_93644fc0c12b68b2);
}

function remove_all(var_7bdff97009197402) {
  assert(isstring(var_7bdff97009197402));

  if(!isDefined(level.spatialgrid) || !isDefined(level.spatialgrid.categories[var_7bdff97009197402])) {
    assertmsg("<dev string:xb8>");
    return;
  }

  category = level.spatialgrid.categories[var_7bdff97009197402];

  if(!category.var_c64b7d522b7f4728) {
    assertmsg("<dev string:x59>");
    return;
  }

  foreach(obj in category.objarray) {
    spatialgridremove(obj.obj.var_93644fc0c12b68b2);
  }

  level.spatialgrid.categories[var_7bdff97009197402] = undefined;
}

function move(var_7bdff97009197402, obj, movetoorigin, previousorigin) {
  assert(isDefined(obj));
  assert(isstring(var_7bdff97009197402));
  assert(isDefined(movetoorigin));

  if(!isDefined(previousorigin)) {
    previousorigin = obj.origin;
  }

  if(!isDefined(level.spatialgrid) || !isDefined(level.spatialgrid.categories[var_7bdff97009197402])) {
    assertmsg("<dev string:xf1>");
    return;
  }

  category = level.spatialgrid.categories[var_7bdff97009197402];

  if(!category.var_c64b7d522b7f4728) {
    assertmsg("<dev string:x124>");
    return;
  }

  if(!isDefined(obj.var_93644fc0c12b68b2)) {
    assertmsg("<dev string:x14a>");
    return;
  }

  spatialgridmove(obj.var_93644fc0c12b68b2, movetoorigin);
}

function query(var_7bdff97009197402, origin, radius) {
  if(!isDefined(level.spatialgrid) || !isDefined(level.spatialgrid.categories[var_7bdff97009197402])) {
    return [];
  }

  category = level.spatialgrid.categories[var_7bdff97009197402];
  queryarray = function_37c8b3d275041e4a(category.intid, origin, radius);
  returnarray = [];

  foreach(idx in queryarray) {
    if(category.var_c64b7d522b7f4728) {
      returnarray[returnarray.size] = category.objarray[idx].obj;
      continue;
    }

    returnarray[returnarray.size] = category.objarray[idx];
  }

  return returnarray;
}

function private function_6038b7a51a411204(var_7bdff97009197402) {
  if(!isDefined(level.spatialgrid) || !isDefined(level.spatialgrid.categories[var_7bdff97009197402])) {
    return create_category(var_7bdff97009197402);
  }

  return level.spatialgrid.categories[var_7bdff97009197402];
}