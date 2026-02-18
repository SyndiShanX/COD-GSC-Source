/*************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\blackboard_vehicle.gsc
*************************************************/

#namespace blackboard;

function registervehicleblackboardattributes() {
  assert(isvehicle(self), "<dev string:x38>");
}

function bb_getspeed() {
  velocity = self getvelocity();
  return length(velocity);
}

function bb_vehgetenemyyaw() {
  enemy = self.enemy;

  if(!isDefined(enemy)) {
    return 0;
  }

  toenemyyaw = vehgetpredictedyawtoenemy(self, 0.2);
  return toenemyyaw;
}

function vehgetpredictedyawtoenemy(entity, lookaheadtime) {
  if(isDefined(entity.predictedyawtoenemy) && isDefined(entity.predictedyawtoenemytime) && entity.predictedyawtoenemytime == gettime()) {
    return entity.predictedyawtoenemy;
  }

  selfpredictedpos = entity.origin;
  moveangle = entity.angles[1] + entity getmotionangle();
  selfpredictedpos += (cos(moveangle), sin(moveangle), 0) * 200 * lookaheadtime;
  yaw = vectortoangles(entity.enemy.origin - selfpredictedpos)[1] - entity.angles[1];
  yaw = absangleclamp360(yaw);
  entity.predictedyawtoenemy = yaw;
  entity.predictedyawtoenemytime = gettime();
  return yaw;
}