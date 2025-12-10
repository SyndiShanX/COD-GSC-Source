/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_staff_air.csc
*************************************************/

#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_weap_staff_common;
#namespace zm_weap_staff_air;

function autoexec __init__sytem__() {
  system::register("zm_weap_staff_air", &__init__, undefined, undefined);
}

function __init__() {
  level._effect["whirlwind"] = "dlc5/zmb_weapon/fx_staff_air_impact_ug_miss";
  clientfield::register("scriptmover", "whirlwind_play_fx", 21000, 1, "int", &function_c6b66912, 0, 0);
  clientfield::register("actor", "air_staff_launch", 21000, 1, "int", &air_staff_launch, 0, 0);
  clientfield::register("allplayers", "air_staff_source", 21000, 1, "int", &function_869adfb, 0, 0);
  level.var_1e7d95e0 = (0, 0, 0);
  level.var_654c7116 = [];
  zm_weap_staff::function_4be5e665(getweapon("staff_air_upgraded"), "dlc5/zmb_weapon/fx_staff_charge_air_lv1");
}

function function_869adfb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  level.var_1e7d95e0 = self.origin;
}

function ragdoll_impact_watch(localclientnum) {
  self endon("entityshutdown");
  wait(0.1);
  waittime = 0.016;
  gibspeed = 500;
  prevorigin = self.origin;
  waitrealtime(waittime);
  prevvel = self.origin - prevorigin;
  prevspeed = length(prevvel);
  prevorigin = self.origin;
  waitrealtime(waittime);
  firstloop = 1;
  while(true) {
    vel = self.origin - prevorigin;
    speed = length(vel);
    if(speed < (prevspeed * 0.5) && prevspeed > (gibspeed * waittime)) {
      if(isDefined(level._effect["zombie_guts_explosion"]) && util::is_mature()) {
        where = self gettagorigin("J_SpineLower");
        playFX(localclientnum, level._effect["zombie_guts_explosion"], where);
      }
      break;
    }
    if(prevspeed < (gibspeed * waittime) && !firstloop) {
      break;
    }
    prevorigin = self.origin;
    prevvel = vel;
    prevspeed = speed;
    firstloop = 0;
    waitrealtime(waittime);
  }
}

function air_staff_launch(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  v_source = level.var_1e7d95e0;
  var_8178243a = randomfloatrange(0.05, 0.35);
  var_bf0620ca = level.var_654c7116[localclientnum];
  if(isDefined(var_bf0620ca)) {
    dist_sq = distancesquared(var_bf0620ca, self.origin);
    if(dist_sq < 22500) {
      var_5321b51d = (randomfloatrange(-1000, 1000), randomfloatrange(-1000, 1000), 0);
      v_source = var_bf0620ca + var_5321b51d;
    }
  }
  dir = self.origin - v_source;
  dir = vectornormalize(dir);
  v_force = length(dir) * 300;
  launch = (dir[0], dir[1], var_8178243a);
  launch = vectorscale(launch, v_force);
  self launchragdoll(launch);
  self thread ragdoll_impact_watch(localclientnum);
}

function function_c6b66912(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon("entityshutdown");
  if(newval) {
    self.is_active = 1;
    original_pos = self.origin;
    level.var_654c7116[localclientnum] = self.origin;
    level.var_c6b66912 = playFXOnTag(localclientnum, level._effect["whirlwind"], self, "tag_origin");
    if(!isDefined(self.sndent)) {
      self.sndent = spawn(0, self.origin, "script_origin");
      self.sndent.n_id = self.sndent playLoopSound("wpn_airstaff_tornado", 1);
      self.sndent thread function_3a4d4e97();
    }
  } else {
    if(isDefined(level.var_c6b66912)) {
      self.is_active = 0;
      level.var_654c7116[localclientnum] = undefined;
      stopfx(localclientnum, level.var_c6b66912);
    }
    if(isDefined(self.sndent)) {
      self.sndent stoploopsound(self.sndent.n_id, 1.5);
      self.sndent delete();
      self.sndent = undefined;
    }
  }
}

function function_3a4d4e97() {
  self endon("entityshutdown");
  level waittill("demo_jump");
  self delete();
}