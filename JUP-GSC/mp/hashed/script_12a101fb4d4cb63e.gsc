/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_12a101fb4d4cb63e.gsc
*************************************************/

#using script_443d99fe707f1d9f;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;
#using scripts\mp\hud_message;
#namespace namespace_fcd9a54e8b7f9724;

function function_ef5eba565dd3356d() {
  if(istrue(level.var_f9bff0af71d1f9f4)) {
    common_item::function_900f562c61c6a5d6("generic", &function_305c6fc0fc454238, &function_387d47abb2c993f4, &function_bd0abf833bce4547, &function_1fb722119725a2fb, undefined, &function_ff41eb8083c83fd8);
  } else {
    common_item::function_900f562c61c6a5d6("generic", &function_305c6fc0fc454238, &function_387d47abb2c993f4, &function_bd0abf833bce4547, &function_1fb722119725a2fb);
  }

  common_item::function_900f562c61c6a5d6("schematic", &function_305c6fc0fc454238, &function_387d47abb2c993f4, &function_bd0abf833bce4547, &function_1fb722119725a2fb);
}

function function_305c6fc0fc454238(itembundle, item, auto_use) {
  remainderquantity = item.count;

  if(isDefined(itembundle.subtype)) {
    switch (itembundle.subtype) {
      case #"hash_d42d44f53610ee5":
        remainderquantity = function_83497abd7c9780c6(itembundle, item);
        break;
      case #"hash_9bbb9bc426bb5e34":
        remainderquantity = function_dac0c3ec1375e14(itembundle, item);
        break;
      case #"hash_7eee054ac1766fba":
        remainderquantity = function_3b5ce4bc5dac6b1a(itembundle, item);
        break;
    }
  }

  return remainderquantity;
}

function function_387d47abb2c993f4(itembundle, item, autouse, allowswap) {
  return false;
}

function function_1fb722119725a2fb(slot) {
  itembundle = undefined;
  quantity = 0;
  return [itembundle, quantity];
}

function function_bd0abf833bce4547(itembundle, item, autouse, allowswap) {
  if(isDefined(itembundle.subtype)) {
    switch (itembundle.subtype) {
      case #"hash_9bbb9bc426bb5e34":
        return function_223094b2ed141ff(itembundle, item);
      case #"hash_d42d44f53610ee5":
        return 1;
      case #"hash_7eee054ac1766fba":
        return 1;
      default:
        return 0;
    }
  }

  return 0;
}

function function_83497abd7c9780c6(itembundle, item) {
  var_270fb50737e1cc01 = undefined;
  var_24e2c5972d3aedba = "";

  switch (itembundle.ref) {
    case #"hash_e32e0721e646db90":
      var_24e2c5972d3aedba = "obloot_weapon_pi_raygun";
      break;
    case #"hash_bbc0c6aba2eaea4b":
      var_24e2c5972d3aedba = "obloot_weapon_ar_dg2";
      break;
    case #"hash_192988071f8b3b12":
      var_24e2c5972d3aedba = "obloot_weapon_la_plasmagun";
      break;
    case #"hash_f05e09a94601223f":
      var_24e2c5972d3aedba = "obloot_offhand_aether_blade";
      break;
    case #"hash_3174218ab9517c94":
      var_24e2c5972d3aedba = "obloot_weapon_la_humangun";
      break;
  }

  var_9f32b69efec89f19 = function_1749413ee00b69f(var_24e2c5972d3aedba);

  if(isDefined(var_9f32b69efec89f19) && isDefined(var_9f32b69efec89f19.scriptable)) {
    var_270fb50737e1cc01 = spawnStruct();
    var_270fb50737e1cc01.type = var_9f32b69efec89f19.scriptable;

    if(isDefined(var_9f32b69efec89f19.baseweapon)) {
      var_270fb50737e1cc01.weaponobj = function_777497d9d98fa0b8(var_9f32b69efec89f19);
    }

    if(isweapon(var_270fb50737e1cc01.weaponobj)) {
      var_270fb50737e1cc01.count = common_item::function_7209c8cd4b2e3afd(weaponmaxammo(var_270fb50737e1cc01.weaponobj));
    } else {
      var_270fb50737e1cc01.count = 1;
    }

    var_84ab4c28dc11052d = common_item::function_de489fa2ffdb7f2d(var_270fb50737e1cc01, 0);

    if(istrue(var_84ab4c28dc11052d)) {
      self playsoundtoplayer("uin_ob_pickup_weaponcase_used", self);
      return (item.count - 1);
    }
  }

  return item.count;
}

function function_dac0c3ec1375e14(itembundle, item) {
  vehiclemodel = "";
  vehicleref = "";
  vehicletype = "";

  switch (itembundle.ref) {
    case #"hash_eabeae1c849c14ce":
      vehiclemodel = "veh_jup_motocycle_blood_burner";
      vehicleref = "veh9_motorcycle_blood_burner";
      vehicletype = "veh9_motorcycle_blood_burner_physics_mp";
      break;
    default:
      return item.count;
  }

  var_317e5132733169cb = function_b3d32603c3dea744(itembundle.ref);
  level.var_928a0b65c0f3936 = gettime() + getdvarfloat(@ "hash_b80dcc258939a2fa", 500);
  self playsoundtoplayer("uin_ob_pickup_weaponcase_used", self);
  spawndata = spawnStruct();
  spawndata.origin = var_317e5132733169cb;
  spawndata.angles = self.angles;
  spawndata.vehicleoverride = vehicletype;
  spawndata.modeloverride = vehiclemodel;
  spawndata.var_699ac4a9c9e9f0ec = 1;
  spawndata.var_24993ee24f7c7c0 = 1;
  self.var_c3a143513a389265 = vehicle::vehicle_spawn(vehicleref, spawndata);

  if(!isDefined(self.var_c3a143513a389265)) {
    return item.count;
  }

  return 0;
}

function function_b3d32603c3dea744(var_379371b67c6dcccb) {
  var_7f2c87da89524d1a = 0;

  switch (var_379371b67c6dcccb) {
    case #"hash_eabeae1c849c14ce":
      var_7f2c87da89524d1a = getdvarint(@ "hash_4664f6c6cdf4208d", 56);
      break;
    default:
      var_7f2c87da89524d1a = getdvarint(@ "hash_891d570f2968d147", 0);
      break;
  }

  forwardoffset = anglesToForward(self.angles) * 150;
  var_317e5132733169cb = utility::function_114e5c055b13dacf(self.origin + forwardoffset, 150);

  if(!isDefined(var_317e5132733169cb)) {
    var_317e5132733169cb = getclosestpointonnavmesh(self.origin + forwardoffset);
    var_317e5132733169cb = var_7f2c87da89524d1a > 0 ? var_317e5132733169cb + (0, 0, var_7f2c87da89524d1a) : var_317e5132733169cb;
  }

  return var_317e5132733169cb;
}

function function_223094b2ed141ff(itembundle, item) {
  vehicleref = "";

  switch (itembundle.ref) {
    case #"hash_eabeae1c849c14ce":
      vehicleref = "veh9_motorcycle_blood_burner";

      if(level.mapname != "mp_jup_bigmap") {
        hud_message::showerrormessage("MP/VEHICLE_PURCHASE_FAILED");
        return false;
      }

      if(isDefined(self.var_c3a143513a389265)) {
        hud_message::showerrormessage("MP/VEHICLE_PURCHASE_FAILED");
        return false;
      }

      if(!self isonground() || self isswimming()) {
        hud_message::showerrormessage("MP/VEHICLE_PURCHASE_FAILED");
        return false;
      }

      if(isDefined(level.var_928a0b65c0f3936) && gettime() < level.var_928a0b65c0f3936) {
        hud_message::showerrormessage("MP/VEHICLE_PURCHASE_FAILED");
        return false;
      }

      break;
  }

  if(vehicle_tracking::vehicle_tracking_atinstancelimit(vehicleref)) {
    hud_message::showerrormessage("KILLSTREAKS/TOO_MANY_VEHICLES");
    return false;
  }

  if(!vehicle_tracking::canspawnVehicle()) {
    vehicle::function_f9aa6f0d46bc950b();

    if(!vehicle_tracking::canspawnVehicle()) {
      hud_message::showerrormessage("KILLSTREAKS/TOO_MANY_VEHICLES");
      return false;
    }
  }

  if(isDefined(level.vehicle) && isDefined(level.vehicle.instances)) {
    var_317e5132733169cb = function_b3d32603c3dea744(itembundle.ref);
    minradius = getdvarfloat(@ "hash_2a8a89f65fb730e1", 240);

    foreach(var_31ff46f336b8b4d5 in level.vehicle.instances) {
      foreach(vehicle in var_31ff46f336b8b4d5) {
        if(isDefined(vehicle) && distance_2d_squared(vehicle.origin, self.origin) < squared(minradius)) {
          hud_message::showerrormessage("MP/VEHICLE_PURCHASE_FAILED");
          return false;
        }
      }
    }
  }

  return true;
}

function function_3b5ce4bc5dac6b1a(itembundle, item) {
  if(isDefined(level.var_867a2a58a53c66f2)) {
    [[level.var_867a2a58a53c66f2]](#"hash_2a29c734c3883c89");
  }

  return false;
}

function function_ff41eb8083c83fd8(itembundle, count, origin, angles, overridelifetime) {
  itembundlename = function_61d960957fcf3ca0(itembundle.ref);
  var_befe30ad29a799c6 = [#"teamselect", self getentitynumber()];

  if(itembundle.subtype == "lootcase") {
    if(isDefined(level.var_9790a6a9ef017f5c)) {
      [item, itembundle] = self[[level.var_9790a6a9ef017f5c]](origin, angles, 0, 0, var_befe30ad29a799c6);
    }
  } else {
    dropstruct = function_3fa6e9da3fd741f2();
    dropinfo = function_49b86047c8a8b228(dropstruct, self.origin, self.angles, self);
    item = function_d59d110ccf0f5b8b(itembundle, count, origin, angles, 0, 0, var_befe30ad29a799c6, dropinfo.payload, overridelifetime);
  }

  function_a703a4241f091edc(item, 300);
  params = spawnStruct();
  params.item = item;
  params.itembundle = itembundle;
  params.itembundlename = itembundlename;
  params.payload = var_befe30ad29a799c6;
  callback::callback("player_item_drop", params);
}