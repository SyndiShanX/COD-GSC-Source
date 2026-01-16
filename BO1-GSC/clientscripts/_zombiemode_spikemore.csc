/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_zombiemode_spikemore.csc
***************************************************/

#include clientscripts\_utility;
#include clientscripts\_fx;

init() {
  if(getDvar(#"createfx") == "on") {
    return;
  }
  register_clientflag_callback("missile", level._CF_SCRIPTMOVER_CLIENT_FLAG_SPIKEMORE, ::spikemore_detonate);
  register_clientflag_callback("actor", level._CF_ACTOR_CLIENT_FLAG_SPIKEMORE, ::spikemore_add_spikes);
  level.spikemore_fired_recently = false;
  level.recent_spikemore_fire_origin = (0, 0, 0);
  level.recent_spikemore_fire_angles = (0, 0, 0);
  level.spikemore_detectionAngle = 50.0;
  level.spikemore_detectionDot = cos(level.spikemore_detectionAngle);
  level.spikemore_projectile_speed = 1500;
}

_set_recently_fired(origin, angles) {
  level.recent_spikemore_fire_origin = origin;
  level.recent_spikemore_fire_angels = angles;
}

spikemore_detonate(local_client_num, int_set, ent_new) {
  playsound(local_client_num, "wpn_spikemore_impact", self.origin);
  println("Client Spikemore detonate: " + local_client_num);
  _set_recently_fired(self.origin, self.angels);
  PlayFX(local_client_num, level._effect["fx_ztem_spikemore"], self.origin, AnglesToForward(self.angles));
  for(i = 0; i < 3; i++) {
    yaw = RandomFloatRange(level.recent_spikemore_fire_angles[1] - level.spikemore_detectionAngle, level.recent_spikemore_fire_angles[1] + level.spikemore_detectionAngle);
    forward = AnglesToForward((0.0, yaw, 0.0));
    z = RandomFloatRange(100.0, 150.0);
    dest = level.recent_spikemore_fire_origin + forward * 400.0 + (0, 0, z);
    trace = BulletTrace(level.recent_spikemore_fire_origin, dest, false, undefined);
    if(isDefined(trace) && trace["fraction"] < 1.0) {
      level thread _spawn_spear(local_client_num, trace, VectorToAngles(forward));
    }
  }
}

_spawn_spear(local_client_num, trace, angles) {
  dist = Distance(trace["position"], level.recent_spikemore_fire_origin);
  time = dist / level.spikemore_projectile_speed;
  wait(time);
  e = spawn(local_client_num, trace["position"], "script_model");
  e.angles = angles + (0, 90, 0);
  e setModel("t5_weapon_bamboo_spear_spikemore_small");
  delayed_remove(e);
}

spikemore_add_spikes(local_client_num, int_set, ent_new) {
  println("Client Spikemore add spikes");
  j = [];
  j[j.size] = "J_SpineLower";
  j[j.size] = "J_Elbow_LE";
  j[j.size] = "J_Elbow_RI";
  j[j.size] = "J_Head";
  j[j.size] = "J_Clavicle_RI";
  j[j.size] = "J_Clavicle_LE";
  j[j.size] = "J_Hip_LE";
  j[j.size] = "J_Hip_RI";
  j = array_randomize(j);
  for(i = 0; i < 3 && i < j.size; i++) {
    joint = j[i];
    jointPos = self GetTagOrigin(joint);
    e = spawn(local_client_num, jointPos, "script_model");
    e setModel("t5_weapon_bamboo_spear_spikemore_small");
    e LinkTo(self, joint);
    self thread delayed_remove_or_ent_shutdown(e);
  }
}

spikemore_waittill_notify_or_timeout(msg, timer) {
  self endon(msg);
  wait(timer);
}

delayed_remove_or_ent_shutdown(ent) {
  self spikemore_waittill_notify_or_timeout("entityshutdown", 10);
  if(isDefined(ent)) {
    ent Delete();
  }
}

delayed_remove(ent) {
  wait(10.0);
  if(isDefined(ent)) {
    ent Delete();
  }
}