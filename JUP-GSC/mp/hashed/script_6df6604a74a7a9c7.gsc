/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6df6604a74a7a9c7.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\utility\game;
#namespace namespace_6c6964e55ab1bec8;

function get_linked_struct() {
  array = get_linked_structs();
  assert(array.size == 1);
  assert(isDefined(array[0]));
  return array[0];
}

function get_linked_vehicle_node() {
  array = get_linked_vehicle_nodes();
  assert(array.size == 1);
  assert(isDefined(array[0]));
  return array[0];
}

function function_98123b667b8f7daa(value, key) {
  array = [];
  filtered_nodes = getvehiclenodearray(value, key);

  if(isDefined(self.script_linkto)) {
    linked_nodes = get_linked_vehicle_nodes();
    array = array_intersection(linked_nodes, filtered_nodes);
  }

  return array;
}

function function_90f7f7052df0614b(value, key) {
  array = function_98123b667b8f7daa(value, key);
  assert(array.size == 1);
  assert(isDefined(array[0]));
  return array[0];
}

function function_954eb52ab4cdeb46(value, key) {
  array = [];
  filtered_structs = getStructArray(value, key);

  if(isDefined(self.script_linkto)) {
    linknames = get_links();

    for(i = 0; i < linknames.size; i++) {
      linked_structs = getStructArray(linknames[i], "script_linkname");
      structs = array_intersection(linked_structs, filtered_structs);

      if(structs.size > 0) {
        array = array_combine(array, structs);
      }
    }
  }

  return array;
}

function function_98edf48d14333f3f(value, key) {
  array = function_954eb52ab4cdeb46(value, key);

  if(array.size > 0) {
    return array[0];
  }

  return undefined;
}

function function_2ccdcbc0a0056226(value, key) {
  array = [];
  filtered_ents = getEntArray(value, key);

  if(isDefined(self.script_linkto)) {
    linknames = get_links();

    for(i = 0; i < linknames.size; i++) {
      linked_ents = getEntArray(linknames[i], "script_linkname");
      ents = array_intersection(linked_ents, filtered_ents);

      if(ents.size > 0) {
        array = array_combine(array, ents);
      }
    }
  }

  return array;
}

function function_45c24888c616581f(value, key) {
  array = function_2ccdcbc0a0056226(value, key);
  assert(array.size == 1);
  assert(isDefined(array[0]));
  return array[0];
}

function function_53b040ee753f26b1(value, key) {
  array = function_50b5e4fcc500bb90(value, key);
  assert(array.size == 1);
  assert(isDefined(array[0]));
  return array[0];
}

function function_50b5e4fcc500bb90(value, key) {
  array = [];
  var_8d08e5afdc964181 = [];
  var_a2e2c8edb4508f35 = getscriptablearray(value, key);
  var_7815a6f6f10f4cd4 = getentitylessscriptablearray(value, key);
  var_8d08e5afdc964181 = array_combine_unique(var_a2e2c8edb4508f35, var_7815a6f6f10f4cd4);

  if(isDefined(self.script_linkto)) {
    linknames = get_links();

    for(i = 0; i < linknames.size; i++) {
      var_3a6b6499601b4cfb = [];
      var_a2e2c8edb4508f35 = getscriptablearray(linknames[i], "script_linkname");
      var_7815a6f6f10f4cd4 = getentitylessscriptablearray(linknames[i], "script_linkname");
      var_3a6b6499601b4cfb = array_combine_unique(var_a2e2c8edb4508f35, var_7815a6f6f10f4cd4);
      scriptables = array_intersection(var_3a6b6499601b4cfb, var_8d08e5afdc964181);

      if(scriptables.size > 0) {
        array = array_combine(array, scriptables);
      }
    }
  }

  return array;
}

function function_a230870ff680af93(value, key) {
  array = [];
  filtered_volumes = function_f159c10d5cf8f0b4(value, key);

  if(isDefined(self.script_linkto)) {
    linknames = get_links();

    for(i = 0; i < linknames.size; i++) {
      for(j = 0; j < filtered_volumes.size; j++) {
        if(is_equal(linknames[i], filtered_volumes[j].script_linkname)) {
          array = array_add(array, filtered_volumes[j]);
        }
      }
    }
  }

  return array;
}