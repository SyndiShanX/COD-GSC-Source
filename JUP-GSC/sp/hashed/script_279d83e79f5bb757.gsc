/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_279d83e79f5bb757.gsc
*************************************************/

#using scripts\cp_mp\vehicles\vehicle_interact;
#namespace namespace_7f5956e577370452;

function function_82b422f2ec92a2b7(vehiclename, vehicle) {
  if(function_4b8893bb155fc08b(vehiclename)) {
    function_cf493e05d95647(vehicle);
  }
}

function function_4b8893bb155fc08b(vehname) {
  dvarstring = hashcat(@ "scr_", vehname);

  if(getDvar(dvarstring, "") == "") {
    setDvar(dvarstring, "enable");
  }

  println("<dev string:x1c>" + vehname);
  dvarstatus = getDvar(dvarstring, "enable") == "disable";
  return dvarstatus;
}

function function_cf493e05d95647(vehicle) {
  println("<dev string:x2d>");
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse(vehicle, 0);
}