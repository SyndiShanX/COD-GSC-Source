/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_vehicletypes.gsc
**************************************/

setup_types(model, type) {
  level.vehicle_types = [];
  level.vehicle_compass_types = [];
}

set_type(type, model) {
  level.vehicle_types[model] = type;
}

set_compassType(type, compassType) {
  level.vehicle_compass_types[type] = compassType;
}

get_type(model) {
  if(!isDefined(level.vehicle_types[model])) {
    println("type doesn't exist for model: " + model);
    println("Set it in vehicletypes::setup_types().");
    assertmsg("vehicle type for model " + model + " doesn't exits, see console for info");
  }
  return level.vehicle_types[model];
}

get_compassTypeForVehicleType(type) {
  if(!isDefined(level.vehicle_compass_types[type])) {
    println("Compass-type doesn't exist for type '" + type + "'.");
    println("Set it in vehicletypes::setup_types().");
    return "tank";
  }
  return level.vehicle_compass_types[type];
}

get_compassTypeForModel(model) {
  type = get_type(model);
  return get_compassTypeForVehicleType(type);
}

is_type(model) {
  if(isDefined(level.vehicle_types[model])) {
    return true;
  }
  else {
    return false;
  }
}