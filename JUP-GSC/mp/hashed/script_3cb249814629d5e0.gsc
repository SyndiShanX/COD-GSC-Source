/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3cb249814629d5e0.gsc
*************************************************/

#using script_5120873d6d2bb7e2;
#using script_d74ae0b4aa21186;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace evade_cars;

function function_eda57308516bfc5f() {
  return function_bffb5b682a4ef6a2(&evaluatescore, undefined, 250);
}

function evaluatescore(bot) {
  var_1ba734c0960ed497 = undefined;
  var_55110dce256e40cd = undefined;
  nearbyevent = bot namespace_27cc7cdc2e4475be::getevent();

  foreach(vehicle in nearbyevent) {
    hittime = vehicletrace(bot, vehicle);

    if(isDefined(hittime) && (!isDefined(var_55110dce256e40cd) || hittime < var_55110dce256e40cd)) {
      var_1ba734c0960ed497 = vehicle;
      var_55110dce256e40cd = hittime;
    }
  }

  if(!isDefined(var_1ba734c0960ed497)) {
    return 0;
  }

  self.var_df9d35d9b4bee654 = createactionbase("Evade Cars", var_1ba734c0960ed497, "main", var_1ba734c0960ed497.unique_id, &actionprocess, self);
  return self.constants.basescore;
}

function vehicletrace(bot, vehicle) {
  assert(isDefined(bot) && isDefined(vehicle));
  vehiclevelocity = vehicle vehicle_getvelocity();
  speed = length(vehiclevelocity) * self.constants.var_3b344b36c6469a5d;
  assert(speed != 0);
  size = vehicle function_80715c3a9a2ddf68();
  carhalfheight = size[2];
  carhalfwidth = min(size[0], size[1]);
  ignore = array_combine([vehicle], vehicle.owners);
  var_c1998072ee17bf47 = vehiclevelocity * self.constants.var_3b344b36c6469a5d;

  if(length(var_c1998072ee17bf47) < self.constants.var_bd58d59c468151dd) {
    var_c1998072ee17bf47 = vectorNormalize(vehiclevelocity) * self.constants.var_bd58d59c468151dd;
  }

  var_c62e720e2d862648 = axistoangles(anglesToForward(vehicle.angles), anglestoup(vehicle.angles), anglestoleft(vehicle.angles));
  var_8bc8bdb284860e7e = carhalfheight;
  var_dae54575a795336 = max(carhalfwidth + self.constants.var_e41be6ba8b297901, var_8bc8bdb284860e7e);
  tracestart = vehicle.origin + anglestoright(vehicle.angles) * var_dae54575a795336 + (0, 0, 45);
  traceend = tracestart + var_c1998072ee17bf47;
  trace = scripts\engine\trace::capsule_trace(tracestart, traceend, var_8bc8bdb284860e7e, var_dae54575a795336 * 2, var_c62e720e2d862648, ignore);

  if(getdvarint(@ "hash_1dc83ffcca238cbf", 0)) {
    color = (0, 1, 0);

    if(isDefined(trace["<dev string:x1c>"]) && trace["<dev string:x1c>"] == bot) {
      color = (1, 0, 0);
      print3d(bot.origin + (0, 0, 50), "<dev string:x26>" + distance(bot.origin, vehicle.origin), (1, 0, 0), 1, 1, 2);
    }

    scripts\engine\trace::draw_trace(trace, color, 1, 2);
  }

  if(isDefined(trace["entity"]) && trace["entity"] == bot) {
    return (distance(bot.origin, vehicle.origin) / speed);
  }

  return undefined;
}

function actionprocess(bot) {
  vehicle = self.argument;
  assert(isDefined(vehicle));
  botforward = anglesToForward(bot.angles);
  vehiclevelocity = vehicle vehicle_getvelocity();
  vehicleforward = vectorNormalize(vehiclevelocity);
  dot = vectordot(botforward, vehicleforward);
  var_313dfd46e0bdd035 = abs(dot) < 0.7;
  var_e4ce48294cfee033 = vectorcross(vehicleforward, vectorNormalize(bot.origin - vehicle.origin))[2] < 0;
  angledelta = 0;

  if(var_313dfd46e0bdd035) {
    moveforward = var_e4ce48294cfee033;
    var_1ed1d46da636e25 = vectorcross(botforward, vectorNormalize(vehicle.origin - bot.origin))[2] < 0;

    if(!var_1ed1d46da636e25) {
      moveforward = !moveforward;
    }

    angledelta = ter_op(moveforward, 0, -180);
  } else {
    moveright = var_e4ce48294cfee033;

    if(dot > 0) {
      moveright = !moveright;
    }

    angledelta = ter_op(moveright, 90, -90);
  }

  yaw = angleclamp(bot.angles[1] + angledelta);
  movementduration = 1;
  bot botsetscriptmove(yaw, movementduration, 1);
  bot botpressbutton("sprint", movementduration);
}