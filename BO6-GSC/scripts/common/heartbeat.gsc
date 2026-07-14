/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\heartbeat.gsc
****************************************/

#using scripts\common\swim_common;
#using scripts\engine\math;
#namespace heartbeat;

function initcommonheartbeat(playsoundfunc) {
  level.heartbeat = spawnStruct();
  level.heartbeat.playsoundfunc = playsoundfunc;
}

function function_d34358e241e5f2ee() {
  self.heartbeat = spawnStruct();
  self.heartbeat.pulsetime = 0;
  thread heartbeattimer();
}

function function_7881ac21030295f6() {
  if(isDefined(level.gamemodebundle.heartbeat)) {
    heartbeatbundle = getscriptbundle(level.gamemodebundle.heartbeat);
  }

  return [[heartbeatbundle.var_78a6041dedc6b73f.alias ?? "\xb4\v\x05\xd9\xda\xb3\xfe\xd9{x\x84f\xdcM\xa9\xcf\xcc9\x17V\x9a\xb5\x10C\x85\xac\xf7|", heartbeatbundle.var_78a6041dedc6b73f.time ?? 1.3], [heartbeatbundle.var_d407e713f21e354e.alias ?? "%\xa6\xe4rWoF\x7fz\x1d\xe8IZ>\xacw\x18x\xbfS\xab\xf3\xcf", heartbeatbundle.var_d407e713f21e354e.time ?? 1.721], [heartbeatbundle.var_e75a8db51d8ca9a9.alias ?? "\xad\xa6VvO\xe1A\xf1\xf6\x8bi\xaa\x154|\xa7\xb5\xafr\xf4\xa5Y", heartbeatbundle.var_e75a8db51d8ca9a9.time ?? 1.973], [heartbeatbundle.var_d5593cca700e91b7.alias ?? "k;\xb5\xa3\xd7\r\xacXN\x1d1e\x16\xe8\xd7\a\xc6N}s\xd8\xdb\xbb", heartbeatbundle.var_d5593cca700e91b7.time ?? 2.321], [heartbeatbundle.var_e480888e360ea6c2.alias ?? "\x9e-\xd8\x93\xd5m\a\xe4*5Y\xd6_\x1a\xd1\xb3\x0exA\xc2\xf1\x8a\x98\xa6y\xba!\x0f", heartbeatbundle.var_e480888e360ea6c2.time ?? 2.86]];
}

function function_8ea7fe6eb54dea55() {
  if(isDefined(level.gamemodebundle.heartbeat)) {
    heartbeatbundle = getscriptbundle(level.gamemodebundle.heartbeat);
  }

  return [[heartbeatbundle.var_11c9d66cf9abcb0e.alias ?? "C\xcen\xfc\x9b\x12\xd4\x05\x14\x87<\xf1\xfb|<]q\xd3\xfc\x956\\Kk\x1du\x16u\\\xea6\x85W", heartbeatbundle.var_11c9d66cf9abcb0e.time ?? 1.3], [heartbeatbundle.var_29f76dde296ee2c1.alias ?? "\x81^_\x95\xf2w\xde\xcd\xcb\xf0\x86(v\xd4j\x06\x03\x94i\xfa\x9b#\xad@9#\xf8u", heartbeatbundle.var_29f76dde296ee2c1.time ?? 1.721], [heartbeatbundle.var_bce2b84b1e4781b6.alias ?? "N\xa4&e\x97& 3\x0e.\xb1\x97\xb7t\x14\x8b\xbe\xde\xd2v\xd7\xe1\xf7\xe3MN\x92w", heartbeatbundle.var_bce2b84b1e4781b6.time ?? 1.973], [heartbeatbundle.var_64237cecb744d860.alias ?? "w\xc6-\xe8w\xbdl\xc7\xeb\xa3\xcb\xac\xb1\x12\x9c\xc0G ;\xc5J\b\xc0\xdeG\x9d\x8c\xb9", heartbeatbundle.var_64237cecb744d860.time ?? 2.321], [heartbeatbundle.var_8a313028ead78c77.alias ?? ",\xeb\xba\xe8\xbc&\xc3\xd1nG\xd3\xb3\xc9\xaa\xb1T\x02\x8f\xcf\xf4\x18*\xaaa\xfa\xb3=\xe6z\xf3Op\x89", heartbeatbundle.var_8a313028ead78c77.time ?? 2.86]];
}

function heartbeattimer() {
  self notify("\x04J\xd8\xd95\xc4\x8cZP\xe46r\x01Y");
  self endon("\x04J\xd8\xd95\xc4\x8cZP\xe46r\x01Y");
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");

  while(true) {
    time = gettime();
    var_8d5d2fe6e364665c = function_860eeab31c70c53a();

    if(isDefined(var_8d5d2fe6e364665c)) {
      pulsesoundalias = var_8d5d2fe6e364665c[0];
      childthread function_588577dc91bbf34d(pulsesoundalias);
      pulses = 2;
      pulsedurationms = var_8d5d2fe6e364665c[1] * 1000 * 0.5;

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

    self waittill("_\xbb\x82\x86!\x93\x15\xaa\xed3\xf2\xd9\x0f\x9b\xa8\xa3p\xafW");
  }
}

function factorpulsetime(time, pulsestarttime, pulsedurationms) {
  pulsenormalized = (time - pulsestarttime) / pulsedurationms;
  pulsenormalized = math::normalized_offset(pulsenormalized, 0.65);
  self.heartbeat.pulsetime = 1 - math::normalized_parabola(pulsenormalized);
}

function pulse_rumble(pulsedurationms) {
  if(swim_common::isbreathcritical() || !function_1ffd140a33010923() || !isdeathsdoor()) {
    return;
  }

  pulseduration = pulsedurationms / 1000;
  wait pulseduration * 0.1;
  childthread function_24a414d24677f4ca("\xf4\x1b\xe5\xc0\xc72\xb9\x93\x9c'\xb1}\x0f\xb2\x05\xa6\\\f\xec");
}

function function_1ffd140a33010923() {
  return !isDefined(self.usingremote);
}

function function_24a414d24677f4ca(heartbeat) {
  self setscriptablepartstate("4\xabvVj8\xfeq\xaa", heartbeat);
  wait 0.05;
  self setscriptablepartstate("4\xabvVj8\xfeq\xaa", "\xba\xa5\x1f\xc9m\x80i");
}

function function_860eeab31c70c53a() {
  if(isdeathsdoor()) {
    return function_ea51c5fdc3353af5();
  }

  if(swim_common::isplayerunderwater()) {
    return function_3e8718a5c228a813();
  }
}

function function_ea51c5fdc3353af5() {
  if(!isDefined(self.currentregendelay) && !istrue(self.healing)) {
    return undefined;
  }

  var_ce00030cd73e2732 = function_7881ac21030295f6();

  if(isDefined(self.currentregendelay) && self.currentregendelay > 4.5) {
    return var_ce00030cd73e2732[0];
  }

  if(isDefined(self.currentregendelay) && self.currentregendelay > 2.8) {
    return var_ce00030cd73e2732[1];
  }

  if(isDefined(self.currentregendelay) && self.currentregendelay > 0.7) {
    return var_ce00030cd73e2732[2];
  }

  return var_ce00030cd73e2732[3];
}

function function_3e8718a5c228a813() {
  if(!swim_common::function_aaa20e190b8443f2()) {
    return undefined;
  }

  var_b65a07c743eeb2e7 = 2;
  pulselevelindex = 0;
  time = 0;
  beats = 0;

  if(swim_common::function_2fc5aa221f94a0b4()) {
    return ["\xc3MN\x83\x81\xb9\x15\xe7\xe7\x10\x1c\x82\xd9\x9e\x1d3K<>8\xf3P\xc5\xc4\xa5\xa0\xdds\xd2\xffl\x1aZ", 0.65];
  }

  var_ce00030cd73e2732 = function_8ea7fe6eb54dea55();

  if(swim_common::isbreathcritical()) {
    var_ce00030cd73e2732 = [var_ce00030cd73e2732[0], var_ce00030cd73e2732[1]];
    remainingtime = swim_common::function_4e5b950863bc54da();
  } else {
    var_ce00030cd73e2732 = [var_ce00030cd73e2732[2], var_ce00030cd73e2732[3], var_ce00030cd73e2732[4]];
    remainingtime = swim_common::function_4e5b950863bc54da() - [[level.swim.var_5dd94eede306043b]]();
  }

  while(true) {
    if(beats < var_b65a07c743eeb2e7) {
      time += var_ce00030cd73e2732[pulselevelindex][1];
      beats++;

      if(time > remainingtime) {
        break;
      }

      continue;
    }

    pulselevelindex++;
    beats = 0;

    if(pulselevelindex >= var_ce00030cd73e2732.size - 1) {
      break;
    }
  }

  return var_ce00030cd73e2732[pulselevelindex];
}

function function_8efe6d1af74270e4() {
  var_ce00030cd73e2732 = function_7881ac21030295f6();
  return var_ce00030cd73e2732[5];
}

function isdeathsdoor() {
  return isDefined(self.deathsdoor) && self.deathsdoor;
}

function isfocus() {
  return isDefined(self.focus) && self.focus;
}

function function_588577dc91bbf34d(plrsfx) {
  if(!swim_common::function_662ec63e13efb2bb()) {
    return;
  }

  self[[level.heartbeat.playsoundfunc]](plrsfx);
}