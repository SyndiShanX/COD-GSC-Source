/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\qrdrone.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#namespace qrdrone;

function init_shared() {
  if(!isDefined(level.var_2444b2ee)) {
    level.var_2444b2ee = {};
    type = "qrdrone_mp";
    clientfield::register("vehicle", "qrdrone_state", 1, 3, "int", &statechange, 0, 0);
    clientfield::register("vehicle", "qrdrone_countdown", 1, 1, "int", &start_blink, 0, 0);
    clientfield::register("vehicle", "qrdrone_timeout", 1, 1, "int", &final_blink, 0, 0);
    clientfield::register("vehicle", "qrdrone_out_of_range", 1, 1, "int", &out_of_range_update, 0, 0);
    vehicle::add_vehicletype_callback("qrdrone_mp", &spawned);
  }
}

function spawned(localclientnum) {
  self util::waittill_dobj(localclientnum);
  self thread restartfx(localclientnum, 0);
  self thread collisionhandler(localclientnum);
  self thread enginestutterhandler(localclientnum);
  self thread qrdrone_watch_distance();
}

function statechange(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);
  self restartfx(fieldname, bwastimejump);
}

function restartfx(localclientnum, blinkstage) {
  self notify(#"restart_fx");
  println("<dev string:x38>" + blinkstage);

  switch (blinkstage) {
    case 0:
      self spawn_solid_fx(localclientnum);
      break;
    case 1:
      self.fx_interval = 1;
      self spawn_blinking_fx(localclientnum);
      break;
    case 2:
      self.fx_interval = 0.133;
      self spawn_blinking_fx(localclientnum);
      break;
    case 3:
      self notify(#"stopfx");
      self notify(#"fx_death");
      return;
  }

  self thread watchrestartfx(localclientnum);
}

function watchrestartfx(localclientnum) {
  self endon(#"death");
  level waittill(#"demo_jump", #"player_switch", #"killcam_begin", #"killcam_end");
  self restartfx(localclientnum, clientfield::get("qrdrone_state"));
}

function spawn_solid_fx(localclientnum) {
  if(self function_4add50a7()) {}
}

function spawn_blinking_fx(localclientnum) {
  self thread blink_fx_and_sound(localclientnum, "wpn_qr_alert");
}

function blink_fx_and_sound(localclientnum, soundalias) {
  self endon(#"death");
  self endon(#"restart_fx");
  self endon(#"fx_death");

  if(!isDefined(self.interval)) {
    self.interval = 1;
  }

  while(true) {
    self playSound(localclientnum, soundalias);
    self spawn_solid_fx(localclientnum);
    util::server_wait(localclientnum, self.interval / 2);
    self notify(#"stopfx");
    util::server_wait(localclientnum, self.interval / 2);
    self.interval /= 1.17;

    if(self.interval < 0.1) {
      self.interval = 0.1;
    }
  }
}

function cleanupfx(localclientnum, handle) {
  self waittill(#"death", #"blink", #"stopfx", #"restart_fx");
  stopfx(localclientnum, handle);
}

function start_blink(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!bwastimejump) {
    return;
  }

  self notify(#"blink");
}

function final_blink(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!bwastimejump) {
    return;
  }

  self.interval = 0.133;
}

function out_of_range_update(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  model = getuimodel(function_1df4c3b0(fieldname, #"vehicle_info"), "outOfRange");

  if(isDefined(model)) {
    setuimodelvalue(model, bwastimejump);
  }
}

function loop_local_sound(localclientnum, alias, interval, fx) {
  self endon(#"death");
  self endon(#"stopfx");
  level endon(#"demo_jump");
  level endon(#"player_switch");

  if(!isDefined(self.interval)) {
    self.interval = fx;
  }

  while(true) {
    self playSound(alias, interval);
    self spawn_solid_fx(alias);
    util::server_wait(alias, self.interval / 2);
    self notify(#"stopfx");
    util::server_wait(alias, self.interval / 2);
    self.interval /= 1.17;

    if(self.interval < 0.1) {
      self.interval = 0.1;
    }
  }
}

function check_for_player_switch_or_time_jump(localclientnum) {
  self endon(#"death");
  level waittill(#"demo_jump", #"player_switch", #"killcam_begin");
  self notify(#"stopfx");
  waittillframeend();
  self thread blink_light(localclientnum);

  if(isDefined(self.blinkstarttime) && self.blinkstarttime <= getservertime(0)) {
    self.interval = 1;
    self thread start_blink(localclientnum, 1);
  } else {
    self spawn_solid_fx(localclientnum);
  }

  self thread check_for_player_switch_or_time_jump(localclientnum);
}

function blink_light(localclientnum) {
  self endon(#"death");
  level endon(#"demo_jump");
  level endon(#"player_switch");
  level endon(#"killcam_begin");
  self waittill(#"blink");

  if(!isDefined(self.blinkstarttime)) {
    self.blinkstarttime = getservertime(0);
  }

  if(self function_4add50a7()) {
    self thread loop_local_sound(localclientnum, "wpn_qr_alert", 1, level._effect[# "qrdrone_viewmodel_light"]);
    return;
  }

  if(self function_ca024039()) {
    self thread loop_local_sound(localclientnum, "wpn_qr_alert", 1, level._effect[# "qrdrone_friendly_light"]);
    return;
  }

  self thread loop_local_sound(localclientnum, "wpn_qr_alert", 1, level._effect[# "qrdrone_enemy_light"]);
}

function collisionhandler(localclientnum) {
  self endon(#"death");

  while(true) {
    waitresult = self waittill(#"veh_collision");
    hip = waitresult.velocity;
    hitn = waitresult.normal;
    hit_intensity = waitresult.intensity;
    driver_local_client = self getlocalclientdriver();

    if(isDefined(driver_local_client)) {
      player = function_5c10bd79(driver_local_client);

      if(isDefined(player)) {
        if(hit_intensity > 15) {
          player playrumbleonentity(driver_local_client, "damage_heavy");
          continue;
        }

        player playrumbleonentity(driver_local_client, "damage_light");
      }
    }
  }
}

function enginestutterhandler(localclientnum) {
  self endon(#"death");

  while(true) {
    self waittill(#"veh_engine_stutter");

    if(self function_4add50a7()) {
      function_36e4ebd4(localclientnum, "rcbomb_engine_stutter");
    }
  }
}

function getminimumflyheight() {
  if(!isDefined(level.airsupportheightscale)) {
    level.airsupportheightscale = 1;
  }

  airsupport_height = struct::get("air_support_height", "targetname");

  if(isDefined(airsupport_height)) {
    planeflyheight = airsupport_height.origin[2];
  } else {
    println("<dev string:x56>");
    planeflyheight = 850;

    if(isDefined(level.airsupportheightscale)) {
      level.airsupportheightscale = getdvarint(#"scr_airsupportheightscale", level.airsupportheightscale);
      planeflyheight *= getdvarint(#"scr_airsupportheightscale", level.airsupportheightscale);
    }

    if(isDefined(level.forceairsupportmapheight)) {
      planeflyheight += level.forceairsupportmapheight;
    }
  }

  return planeflyheight;
}

function qrdrone_watch_distance() {
  self endon(#"death");
  qrdrone_height = struct::get("qrdrone_height", "targetname");

  if(isDefined(qrdrone_height)) {
    self.maxheight = qrdrone_height.origin[2];
  } else {
    self.maxheight = int(getminimumflyheight());
  }

  self.maxdistance = 12800;
  level.mapcenter = getmapcenter();
  self.minheight = level.mapcenter[2] - 800;
  inrangepos = self.origin;
  soundent = spawn(0, self.origin, "script_origin");
  soundent linkto(self);
  self thread qrdrone_staticstopondeath(soundent);

  while(true) {
    if(!self qrdrone_in_range()) {
      staticalpha = 0;

      while(!self qrdrone_in_range()) {
        if(isDefined(self.heliinproximity)) {
          dist = distance(self.origin, self.heliinproximity.origin);
          staticalpha = 1 - (dist - 150) / 150;
        } else {
          dist = distance(self.origin, inrangepos);
          staticalpha = min(1, dist / 200);
        }

        sid = soundent playLoopSound(#"veh_qrdrone_static_lp", 0.2);
        self vehicle::set_static_amount(staticalpha * 2);
        waitframe(1);
      }

      self thread qrdrone_staticfade(staticalpha, soundent, sid);
    }

    inrangepos = self.origin;
    waitframe(1);
  }
}

function qrdrone_in_range() {
  if(self.origin[2] < self.maxheight && self.origin[2] > self.minheight) {
    if(self function_4826630a()) {
      return true;
    }
  }

  return false;
}

function qrdrone_staticfade(staticalpha, sndent, sid) {
  self endon(#"death");

  while(self qrdrone_in_range()) {
    staticalpha -= 0.05;

    if(staticalpha <= 0) {
      sndent stopallloopsounds(0.5);
      self vehicle::set_static_amount(0);
      break;
    }

    setsoundvolumerate(sid, 0.6);
    setsoundvolume(sid, staticalpha);
    self vehicle::set_static_amount(staticalpha * 2);
    waitframe(1);
  }
}

function qrdrone_staticstopondeath(sndent) {
  self waittill(#"death");
  sndent stopallloopsounds(0.1);
  sndent delete();
}