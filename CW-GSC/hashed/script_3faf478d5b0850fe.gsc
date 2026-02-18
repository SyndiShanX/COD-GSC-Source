/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3faf478d5b0850fe.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_74a56359b7d02ab6;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_9fc66ac;

function init() {
  clientfield::register("world", "doa_announce", 1, 11, "int");
}

function main() {
  level clientfield::set("doa_announce", 0);
}

function announce(id, var_971e1071 = 15) {
  if(!isDefined(id)) {
    return;
  }

  assert(id >= 0 && id <= 72, "<dev string:x38>");
  payload = (id << 4) + var_971e1071;
  level clientfield::set("doa_announce", payload);
  util::wait_network_frame();
  level clientfield::set("doa_announce", 0);
}

function function_a77649db(name, onoff) {
  if(is_true(onoff)) {
    level.var_7704256 = level.musicstate;

    if(name === "slideways" || name === "slideways2" || name === "slideways3" || name === "slideways4" || name === "slideways5" || name === "eggxit") {
      function_5e3127a5(undefined, "slideways");
    } else {
      function_5e3127a5(#"bonusroom");
    }

    return;
  }

  function_5e3127a5(undefined, level.var_7704256);
}

function function_5beeba99() {
  if(!isDefined(level.doa.var_39e3fa99)) {
    return;
  }

  name = [[level.doa.var_39e3fa99]] - > getname();
  var_8576a4b1 = level.doa.roundnumber;

  if(name === "boss") {
    function_5e3127a5(#"bossfight");
    return;
  }

  function_5e3127a5(#"arena");
}

function function_2fc07d61() {
  if(!isDefined(level.doa.var_39e3fa99)) {
    return;
  }

  name = [[level.doa.var_39e3fa99]] - > getname();
  var_8576a4b1 = level.doa.roundnumber;
}

function function_65fcd877() {
  switch (level.doa.world_state) {
    case 0:
      break;
    case 4:
      function_5e3127a5(#"overworld");
      break;
    case 5:
      function_5e3127a5(#"dungeon");
      break;
    case 1:
      function_5e3127a5(undefined, "winners_circle");
      break;
  }
}

function function_5e3127a5(var_75e87d7f, var_6ea1719d = undefined) {
  if(!isDefined(level.var_402c5b0e)) {
    level.var_402c5b0e = [];
  }

  if(!isDefined(level.var_402c5b0e[# "arena"])) {
    level.var_402c5b0e[# "arena"] = [];
  }

  if(!isDefined(level.var_402c5b0e[# "overworld"])) {
    level.var_402c5b0e[# "overworld"] = [];
  }

  if(!isDefined(level.var_402c5b0e[# "dungeon"])) {
    level.var_402c5b0e[# "dungeon"] = [];
  }

  if(!isDefined(level.var_402c5b0e[# "bossfight"])) {
    level.var_402c5b0e[# "bossfight"] = [];
  }

  if(!isDefined(level.var_402c5b0e[# "bonusroom"])) {
    level.var_402c5b0e[# "bonusroom"] = [];
  }

  if(is_true(level.var_1c6708d0)) {
    return;
  }

  if(isDefined(var_6ea1719d)) {
    music::setmusicstate(var_6ea1719d);
    return;
  }

  if(!isDefined(var_75e87d7f)) {
    return;
  }

  if(level.var_402c5b0e[var_75e87d7f].size <= 0) {
    function_914016fe(var_75e87d7f);
  }

  music::setmusicstate(level.var_402c5b0e[var_75e87d7f][0]);
  level.var_402c5b0e[var_75e87d7f] = array::remove_index(level.var_402c5b0e[var_75e87d7f], 0);
}

function function_914016fe(var_75e87d7f) {
  switch (var_75e87d7f) {
    case # "arena":
      min = 0;
      max = 8;
      str_prefix = "arena_0";
      break;
    case # "overworld":
      min = 0;
      max = 2;
      str_prefix = "overworld_0";
      break;
    case # "dungeon":
      min = 0;
      max = 2;
      str_prefix = "dungeon_0";
      break;
    case # "bossfight":
      min = 0;
      max = 0;
      str_prefix = "bossfight_0";
      break;
    case # "bonusroom":
      min = 0;
      max = 1;
      str_prefix = "bonusroom_0";
      break;
  }

  for(i = min; i < max + 1; i++) {
    level.var_402c5b0e[var_75e87d7f][i] = str_prefix + i;
  }

  level.var_402c5b0e[var_75e87d7f] = array::randomize(level.var_402c5b0e[var_75e87d7f]);
}

function networksafereset() {
  self notify("736ddcf43ece996d");
  self endon("736ddcf43ece996d");

  while(true) {
    level.doa.var_3d0539c1 = 0;
    util::wait_network_frame();
  }
}

function sndisnetworksafe() {
  if(!isDefined(level.doa.var_3d0539c1)) {
    level thread networksafereset();
  }

  if(level.doa.var_3d0539c1 >= 2) {
    return false;
  }

  level.doa.var_3d0539c1++;
  return true;
}

function function_ba33d23d(var_78c0dedd, var_8871bfcd, var_43d8daa2) {
  self.var_2b45c795 = {
    #var_6ceeee01: var_78c0dedd, #var_71846889: var_8871bfcd, #death: var_43d8daa2
  };
  self thread function_7e8995ce();
  self thread function_55aa8bb7();
}

function function_7e8995ce() {
  str_alias = self.var_2b45c795.death;
  var_acdd3525 = self.var_2b45c795.var_6ceeee01;
  var_9a9e90a8 = self.var_2b45c795.var_71846889;
  self waittill(#"death");

  if(isDefined(self)) {
    if(isDefined(var_acdd3525)) {
      self stopsound(var_acdd3525);
    }

    if(isDefined(var_9a9e90a8)) {
      self stopsound(var_9a9e90a8);
    }

    if(isDefined(str_alias) && namespace_ec06fe4a::function_a8975c67()) {
      self playSound(str_alias);
    }
  }
}

function function_55aa8bb7() {
  self endon(#"death");
  wait 1;

  if(!isDefined(self.var_2b45c795)) {
    return;
  }

  while(true) {
    if(isDefined(self.zombie_move_speed)) {
      if(self.zombie_move_speed === "sprint" || self.zombie_move_speed === "run") {
        str_alias = self.var_2b45c795.var_71846889;
      } else {
        str_alias = self.var_2b45c795.var_6ceeee01;
      }
    } else {
      str_alias = self.var_2b45c795.var_71846889;
    }

    if(namespace_ec06fe4a::function_a8975c67()) {
      if(sndisnetworksafe()) {
        self playSound(str_alias);
      }
    }

    wait randomfloatrange(1.5, 5);
  }
}