/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1553cda7e2b2c52c.gsc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace pitch_and_yaw_meters;
class class_98cc868d: cluielem {
  function open(player, flags = 0) {
    cluielem::open_luielem(player, flags);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function setup_clientfields() {
    cluielem::setup_clientfields("pitch_and_yaw_meters");
  }
}

function register() {
  elem = new class_98cc868d();
  [[elem]] - > setup_clientfields();
  return elem;
}

function open(player, flags = 0) {
  [[self]] - > open(player, flags);
}

function close(player) {
  [[self]] - > close(player);
}

function is_open(player) {
  return [[self]] - > function_7bfd10e6(player);
}