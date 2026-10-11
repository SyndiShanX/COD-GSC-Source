/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\common\heartbeat.gsc
***********************************************/

#using scripts\common\swim_common;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace heartbeat;

function initcommonheartbeat(playsoundfunc) {
  level.heartbeat = spawnStruct();
  level.heartbeat.playsoundfunc = playsoundfunc;
}

function function_a9c6f7587066ce13() {
  self.heartbeat = spawnStruct();
  self.heartbeat.pulsetime = 0;
  thread heartbeattimer();
}

function function_6c37d427b68ff9c7() {
  return [["mvmt_heartbeat_plr_superfast", 1.3], ["mvmt_heartbeat_plr_fast", 1.721], ["mvmt_heartbeat_plr_med", 1.973], ["mvmt_heartbeat_plr_slow", 2.321], ["mvmt_heartbeat_plr_superslow", 2.86]];
}

function function_fa062c79f577073c() {
  return [["mvmt_swim_heartbeat_plr_superfast", 1.3], ["mvmt_swim_heartbeat_plr_fast", 1.721], ["mvmt_swim_heartbeat_plr_med", 1.973], ["mvmt_swim_heartbeat_plr_slow", 2.321], ["mvmt_swim_heartbeat_plr_superslow", 2.86]];
}

function heartbeattimer() {
  self notify("heartBeatTimer");
  self endon("heartBeatTimer");
  self endon("death_or_disconnect");

  while(true) {
    time = gettime();
    var_be61059bb932ddd5 = function_8c8ff6fc7b5b3d67();

    if(isDefined(var_be61059bb932ddd5)) {
      pulsesoundalias = var_be61059bb932ddd5[0];
      childthread function_7c867ea17d64a37c(pulsesoundalias);
      pulses = 2;
      pulsedurationms = var_be61059bb932ddd5[1] * 1000 * 0.5;

      while(pulses > 0) {
        pulsestarttime = time;

        while(time < pulsestarttime + pulsedurationms) {
          factorpulsetime(time, pulsestarttime, pulsedurationms);
          waitframe();
          time = gettime();
        }

        pulses--;
      }

      continue;
    }

    self waittill("startHeartbeatPulse");
  }
}

function factorpulsetime(time, pulsestarttime, pulsedurationms) {
  pulsenormalized = (time - pulsestarttime) / pulsedurationms;
  pulsenormalized = math::normalized_offset(pulsenormalized, 0.65);
  self.heartbeat.pulsetime = 1 - math::normalized_parabola(pulsenormalized);
}

function pulse_rumble(pulsedurationms) {
  if(isbreathcritical() || !function_afb9ed6354e03dfa() || !isdeathsdoor()) {
    return;
  }

  pulseduration = pulsedurationms / 1000;
  wait pulseduration * 0.1;
  childthread function_b7c36a804415225b("heartbeatSuperLight");
}

function function_afb9ed6354e03dfa() {
  return !isDefined(self.usingremote);
}

function function_b7c36a804415225b(heartbeat) {
  self setscriptablepartstate("heartbeat", heartbeat);
  wait 0.05;
  self setscriptablepartstate("heartbeat", "neutral");
}

function function_8c8ff6fc7b5b3d67() {
  if(isdeathsdoor()) {
    return function_1078275b178db870();
  }

  if(isplayerunderwater()) {
    return function_14f4cbd1901f7812();
  }
}

function function_1078275b178db870() {
  if(!isDefined(self.currentregendelay) && !istrue(self.healing)) {
    return undefined;
  }

  var_b10ff79982c0153b = function_6c37d427b68ff9c7();

  if(isDefined(self.currentregendelay) && self.currentregendelay > 4.5) {
    return var_b10ff79982c0153b[0];
  }

  if(isDefined(self.currentregendelay) && self.currentregendelay > 2.8) {
    return var_b10ff79982c0153b[1];
  }

  if(isDefined(self.currentregendelay) && self.currentregendelay > 0.7) {
    return var_b10ff79982c0153b[2];
  }

  return var_b10ff79982c0153b[3];
}

function function_14f4cbd1901f7812() {
  if(!function_3776bacc92b445d3()) {
    return undefined;
  }

  var_fe17e9129d4b4bfa = 2;
  pulselevelindex = 0;
  time = 0;
  beats = 0;

  if(function_bab53c4f3c6062b9()) {
    return ["mvmt_swim_heartbeat_plr_ultrafast", 0.65];
  }

  var_b10ff79982c0153b = function_fa062c79f577073c();

  if(isbreathcritical()) {
    var_b10ff79982c0153b = [var_b10ff79982c0153b[0], var_b10ff79982c0153b[1]];
    remainingtime = function_b1b34805f6f1b18f();
  } else {
    var_b10ff79982c0153b = [var_b10ff79982c0153b[2], var_b10ff79982c0153b[3], var_b10ff79982c0153b[4]];
    remainingtime = function_b1b34805f6f1b18f() - [[level.swim.var_575e6f276810675e]]();
  }

  while(true) {
    if(beats < var_fe17e9129d4b4bfa) {
      time += var_b10ff79982c0153b[pulselevelindex][1];
      beats++;

      if(time > remainingtime) {
        break;
      }

      continue;
    }

    pulselevelindex++;
    beats = 0;

    if(pulselevelindex >= var_b10ff79982c0153b.size - 1) {
      break;
    }
  }

  return var_b10ff79982c0153b[pulselevelindex];
}

function function_2fb10e0f50e2d6c1() {
  var_b10ff79982c0153b = function_6c37d427b68ff9c7();
  return var_b10ff79982c0153b[5];
}

function isdeathsdoor() {
  return isDefined(self.deathsdoor) && self.deathsdoor;
}

function isfocus() {
  return isDefined(self.focus) && self.focus;
}

function function_7c867ea17d64a37c(plrsfx) {
  if(!function_c2be12529b0f0ad2()) {
    return;
  }

  self[[level.heartbeat.playsoundfunc]](plrsfx);
}