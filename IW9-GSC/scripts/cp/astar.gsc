/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\astar.gsc
***********************************************/

astar_get_path(_id_E032318567F8AFCD, _id_D5685B7BAEE6505E, end_pos, _id_17947F4A9AA52B15, _id_6EE6C2CA7C64E9C9, _id_ACF81F9900BE7297) {
  if(!isDefined(_id_ACF81F9900BE7297))
    _id_ACF81F9900BE7297 = 1024;

  if(!isDefined(_id_17947F4A9AA52B15))
    _id_17947F4A9AA52B15 = [];

  _id_1BFA180C6FDD09DD = physics_createcontents(["physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
  node_grid = [];

  foreach(node in _id_E032318567F8AFCD) {
    if(!node_is_valid(node, _id_17947F4A9AA52B15, _id_1BFA180C6FDD09DD)) {
      continue;
    }
    node_grid[node_grid.size] = node;
  }

  if(isDefined(_id_6EE6C2CA7C64E9C9) && node_is_valid(_id_6EE6C2CA7C64E9C9, _id_17947F4A9AA52B15, _id_1BFA180C6FDD09DD))
    node_grid[node_grid.size] = _id_6EE6C2CA7C64E9C9;

  start_node = scripts\engine\utility::getclosest(_id_D5685B7BAEE6505E, node_grid);
  end_node = scripts\engine\utility::getclosest(end_pos, node_grid);

  if(distancesquared(start_node.origin, end_node.origin) < 256)
    return undefined;

  nodes_set_children(node_grid, start_node, _id_17947F4A9AA52B15, _id_ACF81F9900BE7297);
  _id_162B3E05FAA30992 = [];
  _id_162B3E05FAA30992[_id_162B3E05FAA30992.size] = start_node;
  start_node.open = 1;
  start_node.closed = 0;

  while(_id_162B3E05FAA30992.size > 0) {
    current_node = _id_162B3E05FAA30992[_id_162B3E05FAA30992.size - 1];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_162B3E05FAA30992.size; _id_AC0E594AC96AA3A8++) {
      if(_id_162B3E05FAA30992[_id_AC0E594AC96AA3A8].f < current_node.f)
        current_node = _id_162B3E05FAA30992[_id_AC0E594AC96AA3A8];
    }

    if(current_node == end_node) {
      path = [];

      for(current = current_node; isDefined(current); current = current.parent) {
        path[path.size] = current;

        if(!isDefined(current.parent)) {
          break;
        }
      }

      data = spawnStruct();
      data.path = scripts\engine\utility::array_reverse(path);
      data.end_node = end_node;
      data.start_node = start_node;
      return data;
    } else {
      _id_162B3E05FAA30992 = scripts\engine\utility::array_remove(_id_162B3E05FAA30992, current_node);
      current_node.closed = 1;
      current_node.open = 0;

      if(!isDefined(current_node.children)) {
        continue;
      }
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < current_node.children.size; _id_AC0E594AC96AA3A8++) {
        current_node.children[_id_AC0E594AC96AA3A8].g = current_node.g + distance(start_node.origin, current_node.children[_id_AC0E594AC96AA3A8].origin);
        current_node.children[_id_AC0E594AC96AA3A8].h = distance(end_node.origin, current_node.children[_id_AC0E594AC96AA3A8].origin);
        current_node.children[_id_AC0E594AC96AA3A8].f = current_node.children[_id_AC0E594AC96AA3A8].g + current_node.children[_id_AC0E594AC96AA3A8].h;

        if(current_node.children[_id_AC0E594AC96AA3A8].f < current_node.f && current_node.children[_id_AC0E594AC96AA3A8].closed)
          continue;
        else if(current_node.f < current_node.children[_id_AC0E594AC96AA3A8].f && current_node.children[_id_AC0E594AC96AA3A8].open)
          continue;
        else if(!current_node.children[_id_AC0E594AC96AA3A8].open && !current_node.children[_id_AC0E594AC96AA3A8].closed) {
          if(!node_cansee_child(current_node.children[_id_AC0E594AC96AA3A8], current_node, _id_17947F4A9AA52B15, _id_1BFA180C6FDD09DD)) {
            continue;
          }
          _id_162B3E05FAA30992[_id_162B3E05FAA30992.size] = current_node.children[_id_AC0E594AC96AA3A8];
          current_node.children[_id_AC0E594AC96AA3A8].parent = current_node;
          current_node.children[_id_AC0E594AC96AA3A8].open = 1;
          current_node.children[_id_AC0E594AC96AA3A8].closed = 0;
        }
      }
    }
  }
}

nodes_set_children(_id_2AAD46D2DF2BCE53, start_node, _id_17947F4A9AA52B15, _id_ACF81F9900BE7297) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2AAD46D2DF2BCE53.size; _id_AC0E594AC96AA3A8++) {
    _id_2AAD46D2DF2BCE53[_id_AC0E594AC96AA3A8].g = 0;
    _id_2AAD46D2DF2BCE53[_id_AC0E594AC96AA3A8].h = 0;
    _id_2AAD46D2DF2BCE53[_id_AC0E594AC96AA3A8].f = 0;
    _id_2AAD46D2DF2BCE53[_id_AC0E594AC96AA3A8].parent = undefined;
    _id_2AAD46D2DF2BCE53[_id_AC0E594AC96AA3A8].open = 0;
    _id_2AAD46D2DF2BCE53[_id_AC0E594AC96AA3A8].closed = 0;
    node_set_children(_id_2AAD46D2DF2BCE53[_id_AC0E594AC96AA3A8], _id_2AAD46D2DF2BCE53, start_node, _id_ACF81F9900BE7297);
  }
}

node_set_children(node, _id_C6736586AE30F7EA, start_node, _id_ACF81F9900BE7297) {
  _id_17947F4A9AA52B15 = [node, start_node];
  children = node_get_children(node, _id_C6736586AE30F7EA, _id_ACF81F9900BE7297, _id_17947F4A9AA52B15);
  node.children = children;
}

node_get_children(node, _id_C6736586AE30F7EA, _id_ACF81F9900BE7297, _id_6342A5CD84590602) {
  if(!isDefined(_id_6342A5CD84590602))
    _id_6342A5CD84590602 = [];

  _id_21B0311D64CADFA2 = squared(_id_ACF81F9900BE7297);
  _id_C6736586AE30F7EA = sortbydistance(_id_C6736586AE30F7EA, node.origin);
  children = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C6736586AE30F7EA.size; _id_AC0E594AC96AA3A8++) {
    _id_80BF6212193E8983 = 0;

    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_6342A5CD84590602.size; _id_AC0E5C4AC96AAA41++) {
      if(_id_C6736586AE30F7EA[_id_AC0E594AC96AA3A8] == _id_6342A5CD84590602[_id_AC0E5C4AC96AAA41]) {
        _id_80BF6212193E8983 = 1;
        break;
      }
    }

    if(_id_80BF6212193E8983) {
      continue;
    }
    if(isDefined(_id_C6736586AE30F7EA[_id_AC0E594AC96AA3A8].radius))
      _id_21B0311D64CADFA2 = squared(_id_C6736586AE30F7EA[_id_AC0E594AC96AA3A8].radius);

    _id_ABD9EE4725B96FC2 = distancesquared(node.origin, _id_C6736586AE30F7EA[_id_AC0E594AC96AA3A8].origin);

    if(_id_ABD9EE4725B96FC2 > _id_21B0311D64CADFA2) {
      break;
    }

    children[children.size] = _id_C6736586AE30F7EA[_id_AC0E594AC96AA3A8];
  }

  return children;
}

node_cansee_child(start_node, end_node, _id_17947F4A9AA52B15, _id_1BFA180C6FDD09DD) {
  offset = 128;

  if(isDefined(level._id_9DEF439B33EAC09D))
    offset = level._id_9DEF439B33EAC09D;

  startpos = start_node.origin + (0, 0, offset);
  endpos = end_node.origin + (0, 0, offset);

  if(isDefined(start_node.target)) {
    if(isDefined(end_node.targetname)) {
      if(end_node.targetname == start_node.target)
        return 1;
    }
  }

  radius = 64;

  if(isDefined(level.astar_node_radius_override))
    radius = level.astar_node_radius_override;

  passed = scripts\engine\trace::sphere_trace_passed(startpos, endpos, radius, _id_17947F4A9AA52B15, _id_1BFA180C6FDD09DD);

  if(getDvar("astar_debug") != "") {
    if(!passed)
      debug_data = scripts\engine\trace::sphere_trace(startpos, endpos, radius, _id_17947F4A9AA52B15, _id_1BFA180C6FDD09DD, 1);
  }

  return passed;
}

node_is_valid(node, _id_17947F4A9AA52B15, _id_1BFA180C6FDD09DD) {
  if(istrue(node.claimed))
    return 0;

  _id_745EB0A20E398D5D = 256;

  if(isDefined(level._id_0AC33444DF3B5F6B))
    _id_745EB0A20E398D5D = level._id_0AC33444DF3B5F6B;

  _id_7F7202915D835C61 = 128;

  if(isDefined(level._id_E769257BA0EA53F7))
    _id_7F7202915D835C61 = level._id_E769257BA0EA53F7;

  startpos = node.origin + (0, 0, _id_745EB0A20E398D5D);
  endpos = node.origin + (0, 0, _id_7F7202915D835C61);
  radius = 72;

  if(isDefined(level.astar_node_radius_override))
    radius = level.astar_node_radius_override;

  passed = scripts\engine\trace::sphere_trace_passed(startpos, endpos, radius, _id_17947F4A9AA52B15, _id_1BFA180C6FDD09DD);

  if(getDvar("astar_debug") != "") {
    if(!passed) {
      _id_A54D8B03B3F42B54 = (1, 0, 0);
      debug_data = scripts\engine\trace::sphere_trace(startpos, endpos, radius, _id_17947F4A9AA52B15, _id_1BFA180C6FDD09DD, 1);
    }
  }

  return passed;
}

_id_845FD743C0FADC39(_id_E032318567F8AFCD, _id_D5685B7BAEE6505E, end_pos, _id_17947F4A9AA52B15, _id_6EE6C2CA7C64E9C9, _id_ACF81F9900BE7297) {
  if(!isDefined(level._id_1B2CD26D577B5480))
    level._id_1B2CD26D577B5480 = [];

  modifier = 1;

  if(isDefined(level._id_2C85DB303881A3C8))
    modifier = level._id_2C85DB303881A3C8;

  if(modifier > 0) {
    _id_8BCA894B5A04261D = level.frameduration * modifier;
    _id_9E1154A76B3EB920 = gettime();

    foreach(key, value in level._id_1B2CD26D577B5480) {
      if(gettime() >= value + _id_8BCA894B5A04261D)
        level._id_1B2CD26D577B5480 = scripts\engine\utility::array_remove(level._id_1B2CD26D577B5480, value);
    }

    if(level._id_1B2CD26D577B5480.size > 0)
      _id_9E1154A76B3EB920 = _id_9E1154A76B3EB920 + level._id_1B2CD26D577B5480.size * _id_8BCA894B5A04261D;

    level._id_1B2CD26D577B5480[level._id_1B2CD26D577B5480.size] = _id_9E1154A76B3EB920;

    while(gettime() < _id_9E1154A76B3EB920)
      wait 0.05;
  }

  path_data = astar_get_path(_id_E032318567F8AFCD, _id_D5685B7BAEE6505E, end_pos, _id_17947F4A9AA52B15, _id_6EE6C2CA7C64E9C9, _id_ACF81F9900BE7297);
  return path_data;
}