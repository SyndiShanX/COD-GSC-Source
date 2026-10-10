/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3532f3f421f0fb30.gsc
*************************************************/

#using script_5d813d45c6b1b1be;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;
#namespace namespace_a58b72ccaa110b13;

function init(var_5179c48492d1d2c2) {
  function_efabc5ae0422de9e(var_5179c48492d1d2c2, 1, undefined, "sitting");
  trigger_struct = getStruct(var_5179c48492d1d2c2.target, "targetname");
  trigger_box = function_698513ab21b7913d(trigger_struct);
  thread function_7de3883507acf30d(trigger_box, var_5179c48492d1d2c2);
}

function private function_7de3883507acf30d(trigger_box, var_5179c48492d1d2c2) {
  var_5179c48492d1d2c2 endon("MRP_FREEBIRD_NOTIFY_SUCCESS");

  while(isDefined(trigger_box)) {
    trigger_box waittill("trigger", data);

    if(data scripts\common\vehicle::isvehicle()) {
      if(istrue(data vehicle_isphysveh()) && !data vehicle_isonground()) {
        driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(data);

        if(isPlayer(driver)) {
          childthread function_d9710cca01e9c3a8(driver, data, var_5179c48492d1d2c2, trigger_box);
        }
      }
    }
  }
}

function private function_d9710cca01e9c3a8(player, vehicle, var_5179c48492d1d2c2, trigger_box) {
  player notify("MRP_FREEDBIRD_NOTIFY_COMPLETE_SINGLETON");
  player endon("MRP_FREEDBIRD_NOTIFY_COMPLETE_SINGLETON");

  iprintlnbold("<dev string:x1c>");

  while(isDefined(vehicle) && !vehicle vehicle_isonground()) {
    wait 0.1;
  }

  driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(vehicle);

  if(isPlayer(driver) && driver == player) {
    iprintlnbold("<dev string:x34>");

    trigger_box delete();
    thread function_44bde26a853364c4(player, vehicle, var_5179c48492d1d2c2);
    var_5179c48492d1d2c2 notify("MRP_FREEBIRD_NOTIFY_SUCCESS");
  }
}

function private function_44bde26a853364c4(player, vehicle, var_5179c48492d1d2c2) {
  function_568b8a57e0fa955f(var_5179c48492d1d2c2, player, undefined, vehicle);
  namespace_8eedd8f6cf5d9f19::function_a4dfabe55dd4a652(player, undefined, "ob_jup_items_activity_mrp_freebird", 1);
}