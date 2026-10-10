/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5fd79768b8941cfb.gsc
*************************************************/

#using script_67cc94c07ab18d3a;
#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_collision;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_armory_kiosk;
#namespace namespace_eef7baa06e67a550;

function function_b585808f22e26aa6(var_9b9f1075db564acd, var_cb1cd0599c50f0e9) {
  scriptablearray = [];

  foreach(loot in var_9b9f1075db564acd.lootarray) {
    type = loot.targetname;

    switch (type) {
      case #"hash_735d8d8888878a53":
        scriptable = function_863b4187f0955e66(loot);
        break;
      case #"hash_48c2dbc1e832de89":
        scriptable = function_5efffd6ea06bab7b(loot);
        break;
      case #"hash_417c605750c7baa5":
        if(isDefined(var_9b9f1075db564acd.var_fd5b04de8603c8a6)) {
          scriptable = [[var_9b9f1075db564acd.var_fd5b04de8603c8a6]](var_9b9f1075db564acd, loot, type);
        } else {
          scriptable = function_e3f46ad7bac518e8(loot, type);
        }

        break;
      default:
        scriptable = undefined;
        break;
    }

    if(isDefined(scriptable)) {
      scriptablearray[scriptablearray.size] = scriptable;
    }
  }

  thread function_b6875112271fac46(var_9b9f1075db564acd, scriptablearray, var_cb1cd0599c50f0e9);
}

function function_863b4187f0955e66(loot) {
  scriptable = scripts\mp\gametypes\br_armory_kiosk::function_7cb54f604c35be8c(loot);
  scriptable setscriptablepartstate("br_plunder_box", "hidden");
  return scriptable;
}

function function_5efffd6ea06bab7b(loot) {
  if(namespace_dbfbff3eb10fab94::function_19598c1ea1487b84()) {
    scriptable = spawnscriptable("br_workbench", loot.origin, loot.angles);
    scriptable setscriptablepartstate("br_workbench", "visible");
    return scriptable;
  }
}

function function_e3f46ad7bac518e8(loot, type) {
  scriptable = spawnscriptable(type, loot.origin, loot.angles);
  thread function_7a553db47dd1d2b5(scriptable);
  return scriptable;
}

function function_7a553db47dd1d2b5(var_cb2499e4e9d175a2) {
  level waittill("prematch_fade_done");

  if(var_cb2499e4e9d175a2 getscriptablehaspart("body") && var_cb2499e4e9d175a2 getscriptableparthasstate("body", "closed_usable_no_collision")) {
    var_cb2499e4e9d175a2 setscriptablepartstate("body", "closed_usable_no_collision");
    return;
  }

  if(var_cb2499e4e9d175a2 getscriptablehaspart("body") && var_cb2499e4e9d175a2 getscriptableparthasstate("body", "closed_usable")) {
    var_cb2499e4e9d175a2 setscriptablepartstate("body", "closed_usable");
  }
}

function function_b6875112271fac46(var_9b9f1075db564acd, scriptablearray, var_cb1cd0599c50f0e9) {
  level waittill("prematch_fade_done");

  foreach(scriptable in scriptablearray) {
    offset = function_9d12545308a35fd2(scriptable, var_9b9f1075db564acd);
    scriptable thread function_c8f65416ce71277a(var_cb1cd0599c50f0e9, offset, scriptable.angles);
  }
}

function function_9d12545308a35fd2(loot, var_9b9f1075db564acd) {
  var_c35e1c74aefb4992 = loot.origin - var_9b9f1075db564acd.parentorigin;
  return var_c35e1c74aefb4992;
}

function function_c8f65416ce71277a(scriptmodel, offset, angles) {
  level endon("game_ended");
  waitframe();
  utility::function_6e506f39f121ea8a(scriptmodel, offset, angles);
  self.parent = scriptmodel;
}

function function_702ee23aca4d2485(animent, animref, currentrate, targetrate, time) {
  acceleration = ter_op(targetrate >= currentrate, 1, -1);
  minvalue = ter_op(acceleration >= 0, currentrate, targetrate);
  maxvalue = ter_op(acceleration >= 0, targetrate, currentrate);
  accelerationrate = (maxvalue - minvalue) / time;

  while(currentrate != targetrate) {
    currentrate = function_dbf72252b51c25af(animent, animref, acceleration, accelerationrate, currentrate, targetrate);
    waitframe();
  }

  return currentrate;
}

function function_bc6bbd377f04b278(currentrate, targetrate, time) {
  return 0.5 * (currentrate + targetrate) * time;
}

function function_dbf72252b51c25af(animent, animref, acceleration, accelerationrate, currentrate, targetrate) {
  newrate = currentrate + acceleration * level.framedurationseconds * accelerationrate;

  if(acceleration == 1 && newrate >= targetrate || acceleration == -1 && newrate <= targetrate) {
    newrate = targetrate;
  }

  if(newrate != currentrate) {
    currentrate = newrate;
    function_ee6ac63a2f326fe8(animent, animref, currentrate);
  }

  return currentrate;
}

function function_ee6ac63a2f326fe8(animent, animref, newrate) {
  animent setanimrate(animref, newrate);

  if(isDefined(animent.var_f5ab71e8bf7a604b)) {
    [[animent.var_f5ab71e8bf7a604b]](animent, animref, newrate);
  }
}

function function_ffd9b2fe58c97f7c(var_776bae99312943ae, animref) {
  var_dfb7ff3bef234b0e = var_776bae99312943ae getanimtime(animref);
  var_cdd725f8f73b94 = getanimlength(animref) * var_dfb7ff3bef234b0e;
  return var_cdd725f8f73b94;
}

function function_e549e7bb5a16c3bc() {
  level endon("game_ended");
  self endon("death");
  self.velocity = (0, 0, 0);

  while(true) {
    self.lastorigin = self.origin;
    wait 0.05;
    self.velocity = (self.origin - self.lastorigin) / 0.05;
  }
}

function function_84114acff04cfccb(vehicle1, vehicle2, vehicleref, collisioncooldown, var_c4e36a338fa34f19) {
  if(vehicle1 scripts\cp_mp\vehicles\vehicle::function_d93ec4635290febd() == vehicleref) {
    movingplatform = vehicle1;
    vehicle = vehicle2;
  } else {
    movingplatform = vehicle2;
    vehicle = vehicle1;
  }

  if(scripts\cp_mp\vehicles\vehicle_collision::function_d88aed99025a81e4(vehicle, movingplatform)) {
    return;
  }

  if(!isDefined(vehicle) || !isDefined(vehicle.health)) {
    return;
  }

  var_dc494b3df72d32cf = undefined;
  vehiclevelocity = vehicle vehicle_getvelocity();

  if(isDefined(movingplatform.velocity)) {
    var_dc494b3df72d32cf = movingplatform.velocity;
  } else if(isDefined(movingplatform getlinkedchildren())) {
    velocity = undefined;
    children = movingplatform getlinkedchildren();

    foreach(child in children) {
      if(isDefined(child.velocity)) {
        var_dc494b3df72d32cf = child.velocity;
        break;
      }
    }
  }

  magdamagemodifier = 1;
  dirdamagemodifier = 1;
  dvarmodifier = 1;
  var_6d4fc1af18b13a8b = 1;
  var_baf692851ee3418d = 20;
  var_e0c9cbab4ab671f3 = 0.5;
  var_d768b2ab879aaf25 = 30;
  var_45dfde7180341dd5 = length(vehiclevelocity);
  magdamagemodifier = scripts\engine\math::remap(var_45dfde7180341dd5, 0, 600, var_6d4fc1af18b13a8b, var_baf692851ee3418d);
  var_4ef87be7f0367144 = scripts\engine\math::anglebetweenvectorsunit(vectorNormalize(vehiclevelocity), vectorNormalize(var_dc494b3df72d32cf));
  dirdamagemodifier = scripts\engine\math::remap(var_4ef87be7f0367144, 0, 180, var_e0c9cbab4ab671f3, var_d768b2ab879aaf25);

  if(getdvarfloat(@ "hash_c243128198440f06", -1) != -1) {
    dvarmodifier = getdvarfloat(@ "hash_c243128198440f06", -1);
  }

  health = vehicle.health;
  mindamage = health / 10;
  damage = mindamage * dirdamagemodifier * magdamagemodifier * dvarmodifier;
  isvehicledestroyed = damage >= health;

  if(isvehicledestroyed) {
    vehicle.var_a8f4bb03b366aa80 = 1;
  }

  vehicle dodamage(damage, movingplatform.origin, movingplatform, movingplatform, "MOD_CRUSH");

  if(vehicle vehicle_isphysveh()) {
    impulsestrength = ter_op(isDefined(var_c4e36a338fa34f19), var_c4e36a338fa34f19, 250);
    vehicle function_e0201404a8b6f664(vehicle.origin - movingplatform.origin + (0, 0, 200), impulsestrength, 1);
  }

  if(vehicle.health < health) {
    level thread scripts\cp_mp\vehicles\vehicle_collision::vehicle_collision_ignorefutureevent(vehicle, movingplatform, collisioncooldown);
  }

  collisionresult = spawnStruct();
  collisionresult.movingplatform = movingplatform;
  collisionresult.vehicle = vehicle;
  collisionresult.isvehicledestroyed = isvehicledestroyed;
  return collisionresult;
}

function function_80c06497397ed757(scriptable, model_name) {
  collider = spawn("script_model", scriptable.origin);
  collider setModel(model_name);
  collider markkeyframedmover();
  collider forcenetfieldhighlod(1);
  collider setmoveroptimized(1);
  collider setmoverantilagged(1);
  level thread function_17565402222f8072(scriptable, collider);
  return collider;
}

function private function_17565402222f8072(scriptable, collider) {
  level endon("game_ended");
  collider endon("death");

  while(!isDefined(scriptable.linkedparent)) {
    wait 1;
  }

  collider.origin = scriptable.origin;
  collider.angles = scriptable.angles;
  collider linkTo(scriptable.linkedparent);
}