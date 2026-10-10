/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_39faae597e351db7.gsc
*************************************************/

#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\content_manager;
#using scripts\cp_mp\currency;
#using scripts\cp_mp\loot\common_item;
#using scripts\engine\utility;
#namespace namespace_abf9477bf4a0e36e;

function function_ef875512a592bbc1() {
  flag_wait("common_items_init");
  level.var_abf9477bf4a0e36e = [];
  callback::add("ob_content_process_create_script", &function_17af5fcd80a95961);
}

function function_17af5fcd80a95961(sparams) {
  var_3c3122af5c02bd7 = getStructArray("content_struct", "variantname");
  var_a1e0b05ac75f968 = [];

  foreach(struct in var_3c3122af5c02bd7) {
    if(isDefined(struct.content_key) && struct.content_key == "essence_large_spawn") {
      var_a1e0b05ac75f968[var_a1e0b05ac75f968.size] = struct;
    }
  }

  if(isDefined(level.var_c383b967aa7e551b)) {
    var_a1e0b05ac75f968 = [[level.var_c383b967aa7e551b]]("essence", var_a1e0b05ac75f968, &function_51b5ba468783ae71);
  }

  callback::callback("ob_essence_create_script_done");
}

function function_e8b0e602ea21de7b() {
  scripts\cp_mp\content_manager::register_script("essence_large", &function_4cdf5f740a62fd75);
  mapdestinations = getStructArray("content_destination", "variantname");

  if(isDefined(mapdestinations) && mapdestinations.size > 0) {
    foreach(destination in mapdestinations) {
      level thread function_eb034db4994911d1(destination);
    }
  }
}

function function_eb034db4994911d1(destination) {
  foreach(location in destination.locations) {
    essence_container = location.instances["essence_large"];

    if(isDefined(essence_container)) {
      foreach(instance in essence_container.versions) {
        scripts\cp_mp\content_manager::spawn_instance(instance);
      }
    }
  }
}

function function_4cdf5f740a62fd75(struct) {
  assert(isstruct(struct), "<dev string:x1c>");
  spawn_points = struct.contentgroups["essence_large_spawn"];

  if(isDefined(spawn_points)) {
    foreach(point in spawn_points) {
      point function_51b5ba468783ae71(point);
    }
  }
}

function function_51b5ba468783ae71(structspawn) {
  dropbundle = getscriptbundle("itemspawnentry:ob_jup_item_essence_large");
  scripts\cp_mp\loot\common_item::function_d59d110ccf0f5b8b(dropbundle, dropbundle.spawncount, structspawn.origin, structspawn.angles, 0, 1);
}

function function_8d5e4f5d5d501bb6(player) {}