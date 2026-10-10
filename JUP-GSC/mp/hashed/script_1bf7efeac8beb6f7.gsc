/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1bf7efeac8beb6f7.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_jugg_common;
#using scripts\mp\hud_util;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\player;
#namespace namespace_e802a675d14dd923;

function init() {
  level endon("game_ended");
  level.var_e0cfb5f49d017c0d = spawnStruct();
  level.var_e0cfb5f49d017c0d.damagevalue = getdvarint(@ "hash_dfa925ae7a8944b", 25);
  level.var_e0cfb5f49d017c0d.var_dc1e1cab01bbd55c = getdvarfloat(@ "hash_f75fa2d39b642f0f", 1.5);
  level.var_e0cfb5f49d017c0d.var_94868ec813b5d794 = getdvarfloat(@ "hash_e5759b8ac4c9c0e9", 0.7);
  function_ac2fdad03eb19a59();
  function_55a323ee4b154170();
  function_2fad0a26c2a1a703();
  function_835a25422ae7c69f();
  level.var_e0cfb5f49d017c0d.inited = 1;

  level.var_e0cfb5f49d017c0d thread function_718576c0d4d8ca36();
}

function private function_ac2fdad03eb19a59() {
  level.var_e0cfb5f49d017c0d.var_c229310c9f8adb7e = [];
  nodearray = getStructArray("jup_skydiving_radiation_spawn", "script_noteworthy");

  foreach(node in nodearray) {
    tokens = strtok(node.script_parameters, "|");
    var_61dce5b9524fde5e = level.var_e0cfb5f49d017c0d.var_c229310c9f8adb7e.size;
    struct = spawnStruct();
    struct.startradius = 0;
    struct.goalradius = int(tokens[0]);
    struct.radius = struct.startradius;
    struct.var_22f4f2be3e6b7e32 = int(tokens[1]);
    struct.var_dfda3fe9dc92c095 = int(tokens[2]);
    struct.height = 1000;
    struct.startpoint = node.origin;
    var_ec0839e67621564 = getStructArray(tokens[3], "script_noteworthy");
    struct.var_ec0839e67621564 = sortbydistance(var_ec0839e67621564, struct.startpoint);
    struct.var_f238df140288eba2 = 0;
    struct.idx = var_61dce5b9524fde5e;

    foreach(trigger in struct.var_ec0839e67621564) {
      trigger.var_d7cc23f6b3a10a7 = distance2d(struct.startpoint, trigger.origin);
    }

    level.var_e0cfb5f49d017c0d.var_c229310c9f8adb7e[var_61dce5b9524fde5e] = struct;
  }
}

function private function_2fad0a26c2a1a703() {
  for(idx = 0; idx < level.var_e0cfb5f49d017c0d.var_c229310c9f8adb7e.size; idx++) {
    var_2b0bb0a5c78456d3 = level.var_e0cfb5f49d017c0d.var_c229310c9f8adb7e[idx];
    var_87053c2ad76d0818 = [];
    var_c00339bd413f94f6 = 0;
    var_c2fae916fa6c1ecf = spawnStruct();
    var_75bcce1e32241224 = spawnStruct();
    var_75bcce1e32241224.startpoint = var_2b0bb0a5c78456d3.startpoint;
    var_75bcce1e32241224.origin = var_75bcce1e32241224.startpoint;
    var_356e20933d3c5596 = [];
    var_356e20933d3c5596[0] = var_75bcce1e32241224;
    var_c2fae916fa6c1ecf.var_356e20933d3c5596 = var_356e20933d3c5596;
    var_c2fae916fa6c1ecf.var_973dfd1577d2e255 = 0;
    var_87053c2ad76d0818[var_c00339bd413f94f6] = var_c2fae916fa6c1ecf;

    if(var_2b0bb0a5c78456d3.goalradius <= 800) {
      continue;
    }

    while(true) {
      var_c00339bd413f94f6++;
      var_973dfd1577d2e255 = var_c00339bd413f94f6 * 800 * 2;

      if(var_973dfd1577d2e255 > var_2b0bb0a5c78456d3.goalradius) {
        var_973dfd1577d2e255 = var_2b0bb0a5c78456d3.goalradius;
      }

      var_d21ba183323ff90a = var_973dfd1577d2e255 - var_87053c2ad76d0818[var_c00339bd413f94f6 - 1].var_973dfd1577d2e255;
      var_e1975252fc1aa40d = (90 - acos(800 / var_973dfd1577d2e255)) * 2;
      var_89483b96b1585631 = ceil(360 / var_e1975252fc1aa40d);
      var_f567fa361445fec3 = spawnStruct();
      var_f567fa361445fec3.var_356e20933d3c5596 = [];
      var_f567fa361445fec3.var_973dfd1577d2e255 = var_973dfd1577d2e255;
      var_f567fa361445fec3.var_d21ba183323ff90a = var_d21ba183323ff90a;

      for(var_335247298b7df538 = 0; var_335247298b7df538 < var_89483b96b1585631; var_335247298b7df538++) {
        angle = var_e1975252fc1aa40d * var_335247298b7df538;
        offsetangle = randomintrange(0, 360);
        var_eb86d0d8f22c74 = cos(angle) * var_973dfd1577d2e255 + var_2b0bb0a5c78456d3.startpoint[0] + 300 * cos(offsetangle);
        var_eb87d0d8f22ea7 = sin(angle) * var_973dfd1577d2e255 + var_2b0bb0a5c78456d3.startpoint[1] + 300 * sin(offsetangle);
        startx = var_eb86d0d8f22c74 - cos(angle) * var_d21ba183323ff90a;
        starty = var_eb87d0d8f22ea7 - sin(angle) * var_d21ba183323ff90a;
        circleinfo = spawnStruct();
        circleinfo.targetpoint = (var_eb86d0d8f22c74, var_eb87d0d8f22ea7, var_2b0bb0a5c78456d3.startpoint[2]);
        circleinfo.startpoint = (startx, starty, var_2b0bb0a5c78456d3.startpoint[2]);
        circleinfo.origin = circleinfo.startpoint;
        circleinfo.movespeed = var_2b0bb0a5c78456d3.var_feda7490ccc8ceda.var_d68e45e062983e30 * randomfloatrange(0.98, 1.02);
        circleinfo.radius = 800;
        circleinfo.radiussquared = circleinfo.radius * circleinfo.radius;
        var_f567fa361445fec3.var_356e20933d3c5596[var_335247298b7df538] = circleinfo;
      }

      var_87053c2ad76d0818[var_c00339bd413f94f6] = var_f567fa361445fec3;

      if(var_973dfd1577d2e255 >= var_2b0bb0a5c78456d3.goalradius) {
        break;
      }
    }

    level.var_e0cfb5f49d017c0d.var_c229310c9f8adb7e[idx].var_87053c2ad76d0818 = var_87053c2ad76d0818;
  }
}

function private function_55a323ee4b154170() {
  for(idx = 0; idx < level.var_e0cfb5f49d017c0d.var_c229310c9f8adb7e.size; idx++) {
    var_2b0bb0a5c78456d3 = level.var_e0cfb5f49d017c0d.var_c229310c9f8adb7e[idx];
    var_feda7490ccc8ceda = spawnStruct();
    var_feda7490ccc8ceda.currentradius = var_2b0bb0a5c78456d3.startradius;
    var_feda7490ccc8ceda.var_d68e45e062983e30 = (var_2b0bb0a5c78456d3.goalradius - var_2b0bb0a5c78456d3.startradius) / var_2b0bb0a5c78456d3.var_22f4f2be3e6b7e32;
    level.var_e0cfb5f49d017c0d.var_c229310c9f8adb7e[idx].var_feda7490ccc8ceda = var_feda7490ccc8ceda;
  }
}

function private function_835a25422ae7c69f() {
  level.var_e0cfb5f49d017c0d.var_ca1abbc76a5b384e = [];
  level.var_e0cfb5f49d017c0d.var_ca1abbc76a5b384e[0] = 0;
  level.var_e0cfb5f49d017c0d.var_ca1abbc76a5b384e[1] = 3;
  level.var_e0cfb5f49d017c0d.var_ca1abbc76a5b384e[2] = 2.5;
  level.var_e0cfb5f49d017c0d.var_ca1abbc76a5b384e[3] = 2;
  level.var_e0cfb5f49d017c0d.var_ca1abbc76a5b384e[4] = 1.5;
  level.var_e0cfb5f49d017c0d.var_ca1abbc76a5b384e[5] = 1;
  level.var_e0cfb5f49d017c0d.var_ca1abbc76a5b384e[6] = 0.5;
}

function radiation_start() {
  level endon("game_ended");

  if(!radiation_isinit()) {
    return;
  }

  level function_88e7cbcfedb66392();
  level thread function_c77df0bb21ac825e();
  level thread function_7ad505eaad0fa6a();
  level thread function_12addfe2fe32c7d();
  level thread function_193b2a718d6b9967();
  level thread function_77c265219f46ec1d();
  level thread function_d462717261efdf24();

  level thread function_d1717a8d12495503();

  function_d33f5adb2144e076();
  level function_54ca68b32911fffd();
}

function private function_d33f5adb2144e076() {
  for(idx = 0; idx < level.var_e0cfb5f49d017c0d.var_c229310c9f8adb7e.size; idx++) {
    var_2b0bb0a5c78456d3 = level.var_e0cfb5f49d017c0d.var_c229310c9f8adb7e[idx];
    var_7e17a0e9f40f32f0 = 2 * (var_2b0bb0a5c78456d3.goalradius + 800 + 300);
    var_e3546795d53ff399 = ceil(var_7e17a0e9f40f32f0 / 10000);
    var_a843b06ef2d37d1e = var_e3546795d53ff399 * 10000;
    var_8401868362093dd4 = var_2b0bb0a5c78456d3.startpoint - (var_a843b06ef2d37d1e / 2, var_a843b06ef2d37d1e / 2, 0) + (5000, 5000, 0);
    level.var_e0cfb5f49d017c0d.var_c229310c9f8adb7e[idx].var_d09fb53f6323062b = [];

    for(row = 0; row < var_e3546795d53ff399; row++) {
      for(col = 0; col < var_e3546795d53ff399; col++) {
        var_c3f9640f4f488fea = function_d5071129a188189d(var_8401868362093dd4 + (col * 10000, row * 10000, 0));

        if(istrue(level.enablezombie)) {
          var_c3f9640f4f488fea setscriptablepartstate("bbox", "bbox_10000_10000_p", 1);
        } else {
          var_c3f9640f4f488fea setscriptablepartstate("bbox", "bbox_10000_10000", 1);
        }

        level.var_e0cfb5f49d017c0d.var_c229310c9f8adb7e[idx].var_d09fb53f6323062b[var_2b0bb0a5c78456d3.var_d09fb53f6323062b.size] = var_c3f9640f4f488fea;
      }
    }
  }
}

function function_54ca68b32911fffd() {
  for(idx = 0; idx < level.var_e0cfb5f49d017c0d.var_c229310c9f8adb7e.size; idx++) {
    level.var_e0cfb5f49d017c0d.var_c229310c9f8adb7e[idx] thread function_a1caa81a59f8d52d();
  }
}

function function_88e7cbcfedb66392() {}

function private function_c77df0bb21ac825e() {
  level endon("game_ended");

  while(true) {
    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }

      centerpos = undefined;

      if(isDefined(player.origin)) {
        centerpos = player scripts\mp\utility\player::getstancecenter();
      }

      player.isinradiation = function_70eacb255e596673(centerpos);
    }

    waitframe();
  }
}

function private function_70eacb255e596673(testorigin) {
  if(!isDefined(testorigin)) {
    return false;
  }

  for(idx = 0; idx < level.var_e0cfb5f49d017c0d.var_c229310c9f8adb7e.size; idx++) {
    var_2b0bb0a5c78456d3 = level.var_e0cfb5f49d017c0d.var_c229310c9f8adb7e[idx];
    var_929a937dde246eea = var_2b0bb0a5c78456d3.startpoint[2] - var_2b0bb0a5c78456d3.height;
    var_92bd9d7dde4acca0 = var_2b0bb0a5c78456d3.startpoint[2] + var_2b0bb0a5c78456d3.height;

    if(testorigin[2] >= var_929a937dde246eea && testorigin[2] <= var_92bd9d7dde4acca0) {
      testdistance = distance2d(testorigin, var_2b0bb0a5c78456d3.startpoint);

      if(testdistance < var_2b0bb0a5c78456d3.var_feda7490ccc8ceda.currentradius) {
        return true;
      }

      if(isDefined(var_2b0bb0a5c78456d3.var_2be52256801022f0) && testdistance < var_2b0bb0a5c78456d3.var_feda7490ccc8ceda.currentradius + 1600) {
        var_f567fa361445fec3 = var_2b0bb0a5c78456d3.var_87053c2ad76d0818[var_2b0bb0a5c78456d3.var_2be52256801022f0];

        if(isDefined(var_f567fa361445fec3)) {
          for(var_335247298b7df538 = 0; var_335247298b7df538 < var_f567fa361445fec3.var_356e20933d3c5596.size; var_335247298b7df538++) {
            circleinfo = var_f567fa361445fec3.var_356e20933d3c5596[var_335247298b7df538];

            if(distance2dsquared(circleinfo.origin, testorigin) < circleinfo.radiussquared) {
              return true;
            }
          }
        }
      }
    }
  }

  return false;
}

function private function_d462717261efdf24() {
  level waittill("game_ended");

  foreach(player in level.players) {
    if(istrue(player.var_6c0135e48bd01bc9.isplaying)) {
      player.var_6c0135e48bd01bc9 stoploopsound();
    }
  }
}

function private function_d5071129a188189d(origin) {
  var_c3d9ac38a1a7c973 = spawn("script_model", origin);
  var_c3d9ac38a1a7c973 setModel("jup_skydiving_radiation_vfx_bbox");
  var_c3d9ac38a1a7c973.angles = (0, 0, 0);
  return var_c3d9ac38a1a7c973;
}

function private function_3243e10a747ae1cb(origin, angles) {
  vfxent = spawn("script_model", origin);
  vfxent setModel("jup_skydiving_radiation_vfx");
  vfxent.angles = angles;
  return vfxent;
}

function private function_7ad505eaad0fa6a() {
  level endon("game_ended");
  playerdamage = level.var_e0cfb5f49d017c0d.damagevalue;
  assertex(isDefined(playerdamage), "<dev string:x1c>");

  while(true) {
    foreach(player in level.players) {
      if(isalive(player) && !istrue(player.plotarmor) && player radiation_isinradiation() && randomfloat(1) <= level.var_e0cfb5f49d017c0d.var_94868ec813b5d794) {
        function_c4a3072ce7b3f1fd(player, playerdamage);
      }
    }

    wait level.var_e0cfb5f49d017c0d.var_dc1e1cab01bbd55c;
  }
}

function private function_c4a3072ce7b3f1fd(player, damage) {
  if(player scripts\mp\utility\killstreak::isjuggernaut()) {
    damage = scripts\mp\gametypes\br_jugg_common::modifybrgasdamage(damage);
  }

  player dodamage(damage, player.origin, player, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");

  if(randomint(100) < 60) {
    player thread scripts\mp\gametypes\br_circle::tryplaycoughaudio();
  }
}

function function_b04fbceae9e9a1f2() {
  for(idx = 0; idx < level.var_e0cfb5f49d017c0d.var_c229310c9f8adb7e.size; idx++) {
    var_2b0bb0a5c78456d3 = level.var_e0cfb5f49d017c0d.var_c229310c9f8adb7e[idx];
    var_2b0bb0a5c78456d3 function_8dc4934b21c58c7f();
  }
}

function private function_a1caa81a59f8d52d() {
  level endon("game_ended");

  if(isDefined(self.var_dfda3fe9dc92c095) && self.var_dfda3fe9dc92c095 > 0) {
    wait self.var_dfda3fe9dc92c095;
  }

  self.var_88ce3bb5d372e97b = 1;

  thread function_c5c558283d6df06d();

  thread function_591c7d494368dd5f();
  thread function_20c0cf87d5745703();
}

function private function_13c3418e0f7fde3c() {
  var_f567fa361445fec3 = self;

  for(var_335247298b7df538 = 0; var_335247298b7df538 < var_f567fa361445fec3.var_356e20933d3c5596.size; var_335247298b7df538++) {
    var_f567fa361445fec3.var_356e20933d3c5596[var_335247298b7df538].vfxent = function_749b235cde2f607f(var_f567fa361445fec3.var_356e20933d3c5596[var_335247298b7df538].startpoint, "idle");
  }
}

function private function_9038f0fd1f35fd50(state) {
  var_f567fa361445fec3 = self;

  for(var_335247298b7df538 = 0; var_335247298b7df538 < var_f567fa361445fec3.var_356e20933d3c5596.size; var_335247298b7df538++) {
    var_f567fa361445fec3.var_356e20933d3c5596[var_335247298b7df538].vfxent setscriptablepartstate("radCircle", state, 1);
  }
}

function private function_749b235cde2f607f(origin, var_170dfed210037514) {
  vfxent = function_3243e10a747ae1cb(origin, (0, 0, 0));
  vfxent setscriptablepartstate("radCircle", var_170dfed210037514, 1);
  return vfxent;
}

function private function_8ce9fe9b8cd5205c(var_f567fa361445fec3) {
  var_8df3d074aa2027ff = [];
  var_e5aa8568c516e991 = [];
  var_f567fa361445fec3.var_9c75f4cbdd855647 = [];
  var_f567fa361445fec3 function_13c3418e0f7fde3c();
  var_f567fa361445fec3 function_9038f0fd1f35fd50("rad_800");

  for(var_335247298b7df538 = 0; var_335247298b7df538 < var_f567fa361445fec3.var_356e20933d3c5596.size; var_335247298b7df538++) {
    var_8df3d074aa2027ff[var_335247298b7df538] = vectornormalize2(var_f567fa361445fec3.var_356e20933d3c5596[var_335247298b7df538].targetpoint - var_f567fa361445fec3.var_356e20933d3c5596[var_335247298b7df538].startpoint);
    var_e5aa8568c516e991[var_335247298b7df538] = 0;
  }

  movingcirclecount = var_f567fa361445fec3.var_356e20933d3c5596.size;

  while(movingcirclecount > 0) {
    function_7c1ed0cf128f227e();
    movingcirclecount = 0;

    for(var_335247298b7df538 = 0; var_335247298b7df538 < var_f567fa361445fec3.var_356e20933d3c5596.size; var_335247298b7df538++) {
      if(var_e5aa8568c516e991[var_335247298b7df538] < var_f567fa361445fec3.var_d21ba183323ff90a) {
        circleinfo = var_f567fa361445fec3.var_356e20933d3c5596[var_335247298b7df538];
        var_e5aa8568c516e991[var_335247298b7df538] += circleinfo.movespeed * 0.2;
        circleinfo.origin += circleinfo.movespeed * var_8df3d074aa2027ff[var_335247298b7df538] * 0.2;
        circleinfo.vfxent.origin = circleinfo.origin;
        movingcirclecount++;

        if(var_e5aa8568c516e991[var_335247298b7df538] >= var_f567fa361445fec3.var_d21ba183323ff90a / 2 && !isDefined(var_f567fa361445fec3.var_9c75f4cbdd855647[var_335247298b7df538])) {
          var_f567fa361445fec3.var_9c75f4cbdd855647[var_335247298b7df538] = function_749b235cde2f607f(circleinfo.origin, "rad_800");
        }
      }
    }

    wait 0.2;
  }
}

function private function_591c7d494368dd5f() {
  level endon("game_ended");
  goalradius = self.goalradius;

  while(self.var_feda7490ccc8ceda.currentradius < goalradius) {
    function_7c1ed0cf128f227e();
    self.var_feda7490ccc8ceda.currentradius += self.var_feda7490ccc8ceda.var_d68e45e062983e30 * 0.2;
    wait 0.2;
  }

  self notify("core_circle_expand_end");
}

function private function_20c0cf87d5745703() {
  level endon("game_ended");
  self endon("core_circle_expand_end");
  self.var_87053c2ad76d0818[0] function_13c3418e0f7fde3c();
  self.var_87053c2ad76d0818[0] function_9038f0fd1f35fd50("rad_800");
  var_b1a12bab3af74ae3 = 1;

  while(var_b1a12bab3af74ae3 < self.var_87053c2ad76d0818.size) {
    self.var_2be52256801022f0 = var_b1a12bab3af74ae3;
    var_f567fa361445fec3 = self.var_87053c2ad76d0818[var_b1a12bab3af74ae3];

    thread function_b643300f2b0abef2(var_f567fa361445fec3);

    function_8ce9fe9b8cd5205c(var_f567fa361445fec3);
    var_b1a12bab3af74ae3 += 1;
  }
}

function private function_193b2a718d6b9967() {
  level endon("game_ended");
  var_cdbf57a64d0416 = 1;

  while(var_cdbf57a64d0416) {
    var_cdbf57a64d0416 = 0;

    for(idx = 0; idx < level.var_e0cfb5f49d017c0d.var_c229310c9f8adb7e.size; idx++) {
      var_2b0bb0a5c78456d3 = level.var_e0cfb5f49d017c0d.var_c229310c9f8adb7e[idx];

      if(istrue(var_2b0bb0a5c78456d3.ispaused)) {
        var_cdbf57a64d0416 = 1;
        continue;
      }

      if(var_2b0bb0a5c78456d3.var_f238df140288eba2 < var_2b0bb0a5c78456d3.var_ec0839e67621564.size) {
        if(var_2b0bb0a5c78456d3.var_feda7490ccc8ceda.currentradius >= var_2b0bb0a5c78456d3.var_ec0839e67621564[var_2b0bb0a5c78456d3.var_f238df140288eba2].var_d7cc23f6b3a10a7) {
          var_2b0bb0a5c78456d3.ispaused = 1;
        }

        var_cdbf57a64d0416 = 1;
      }
    }

    waitframe();
  }
}

function private function_7c1ed0cf128f227e() {
  level endon("game_ended");
  self endon("radiation_pause_cancel");

  if(istrue(self.ispaused)) {
    level waittill("forever");
  }
}

function private function_8dc4934b21c58c7f() {
  self.var_f238df140288eba2 += 1;
  self.ispaused = 0;
  self notify("radiation_pause_cancel");
}

function private function_7fd874f94b2080ed() {
  level endon("game_ended");
  self endon("disconnect");

  if(isbot(self)) {
    return;
  }

  while(true) {
    if(!isreallyalive(self)) {
      wait 0.1;
      continue;
    }

    var_89551b0b01de8ee7 = function_dc3094bcaa9a1955(self.origin);
    maxlevel = level.var_e0cfb5f49d017c0d.var_ca1abbc76a5b384e.size - 1;
    delayseconds = level.var_e0cfb5f49d017c0d.var_ca1abbc76a5b384e[var_89551b0b01de8ee7];

    if(isDefined(delayseconds) && delayseconds > 0) {
      if(maxlevel / var_89551b0b01de8ee7 < 2) {
        self playlocalsound("jup_skydiving_geiger_high");
      } else {
        self playlocalsound("jup_skydiving_geiger_low");
      }

      wait delayseconds;
      continue;
    }

    wait 0.1;
  }
}

function private function_12addfe2fe32c7d() {
  level endon("game_ended");

  if(istrue(level.enablezombie)) {
    return;
  }

  foreach(player in level.players) {
    player thread function_7fd874f94b2080ed();
  }

  while(true) {
    level waittill("connected", player);
    player thread function_7fd874f94b2080ed();
  }
}

function private function_dc3094bcaa9a1955(testorigin) {
  var_d7c9420de7609a9e = 0;

  for(idx = 0; idx < level.var_e0cfb5f49d017c0d.var_c229310c9f8adb7e.size; idx++) {
    var_2b0bb0a5c78456d3 = level.var_e0cfb5f49d017c0d.var_c229310c9f8adb7e[idx];

    if(!istrue(var_2b0bb0a5c78456d3.var_88ce3bb5d372e97b)) {
      continue;
    }

    diffz = abs(var_2b0bb0a5c78456d3.startpoint[2] - testorigin[2]);

    if(diffz > 2000) {
      continue;
    }

    dist2d = distance2d(var_2b0bb0a5c78456d3.startpoint, testorigin);
    ratio = dist2d / (var_2b0bb0a5c78456d3.var_feda7490ccc8ceda.currentradius + 800);

    if(ratio >= 1.5) {
      var_d7c9420de7609a9e = max(var_d7c9420de7609a9e, 0);
      continue;
    }

    maxlevel = level.var_e0cfb5f49d017c0d.var_ca1abbc76a5b384e.size - 1;
    var_d7c9420de7609a9e = max(var_d7c9420de7609a9e, ceil((1 - ratio / 1.5) * maxlevel));
  }

  return int(var_d7c9420de7609a9e);
}

function private function_77c265219f46ec1d() {
  level endon("game_ended");

  while(true) {
    foreach(player in level.players) {
      if(isbot(player)) {
        continue;
      }

      if(!isDefined(player.var_6c0135e48bd01bc9)) {
        player.var_6c0135e48bd01bc9 = spawn("script_model", player.origin);
        player.var_6c0135e48bd01bc9.isplaying = 0;
      }

      player.var_6c0135e48bd01bc9 showonlytoplayer(player);

      if(isalive(player) && !istrue(player.var_6c0135e48bd01bc9.isplaying) && !istrue(player.plotarmor) && player radiation_isinradiation()) {
        player.var_6c0135e48bd01bc9 showonlytoplayer(player);
        player.var_6c0135e48bd01bc9 playLoopSound("amb_skydiving_gas_inside_lp");
        player.var_6c0135e48bd01bc9.isplaying = 1;
        continue;
      }

      if(istrue(player.var_6c0135e48bd01bc9.isplaying) && !istrue(player radiation_isinradiation())) {
        player.var_6c0135e48bd01bc9 stoploopsound();
        player playlocalsound("amb_skydiving_gas_inside_stop");
        player.var_6c0135e48bd01bc9.isplaying = 0;
      }
    }

    wait 1;
  }
}

function radiation_isinradiation() {
  return istrue(self.isinradiation);
}

function radiation_isinit() {
  return isDefined(level.var_e0cfb5f49d017c0d) && istrue(level.var_e0cfb5f49d017c0d.inited);
}

function private function_718576c0d4d8ca36() {
  level endon("<dev string:x47>");
  level waittill("<dev string:x55>");
  setdevdvarifuninitialized(@ "hash_ebece5882c98c426", 0);

  while(getdvarint(@ "hash_ebece5882c98c426", 0) == 0) {
    waitframe();
  }

  level thread radiation_start();
}

function private function_b643300f2b0abef2(var_f567fa361445fec3) {
  level endon("<dev string:x47>");
  self notify("<dev string:x6d>");
  self endon("<dev string:x6d>");

  if(getdvarint(@ "hash_ebece5882c98c426", 0) == 0) {
    return;
  }

  while(true) {
    for(var_335247298b7df538 = 0; var_335247298b7df538 < var_f567fa361445fec3.var_356e20933d3c5596.size; var_335247298b7df538++) {
      draw_circle(var_f567fa361445fec3.var_356e20933d3c5596[var_335247298b7df538].origin, var_f567fa361445fec3.var_356e20933d3c5596[var_335247298b7df538].radius, (1, 1, 0), 1, 0, 1);
    }

    waitframe();
  }
}

function private function_c5c558283d6df06d() {
  level endon("<dev string:x47>");

  if(getdvarint(@ "hash_ebece5882c98c426", 0) == 0) {
    return;
  }

  while(true) {
    print3d(self.startpoint + (0, 0, 200), "<dev string:x8a>" + self.idx, (1, 0, 0), 1, 10);
    draw_circle(self.startpoint, self.var_feda7490ccc8ceda.currentradius, (0, 1, 0), 1, 0, 1);
    waitframe();
  }
}

function private function_d1717a8d12495503() {
  level endon("<dev string:x47>");

  if(getdvarint(@ "hash_ebece5882c98c426", 0) == 0) {
    return;
  }

  level thread function_cd6ab9f89981a245();
  setdevdvarifuninitialized(@ "hash_2fd7ed6966ba850e", -1);

  while(true) {
    idx = getdvarint(@ "hash_2fd7ed6966ba850e", -1);

    if(idx >= 0) {
      var_2b0bb0a5c78456d3 = level.var_e0cfb5f49d017c0d.var_c229310c9f8adb7e[idx];

      if(isDefined(var_2b0bb0a5c78456d3)) {
        var_2b0bb0a5c78456d3 function_8dc4934b21c58c7f();
      }

      setDvar(@ "hash_2fd7ed6966ba850e", -1);
    }

    waitframe();
  }
}

function private function_cd6ab9f89981a245() {
  level endon("<dev string:x47>");

  while(true) {
    for(idx = 0; idx < level.var_e0cfb5f49d017c0d.var_c229310c9f8adb7e.size; idx++) {
      var_2b0bb0a5c78456d3 = level.var_e0cfb5f49d017c0d.var_c229310c9f8adb7e[idx];

      foreach(trigger in var_2b0bb0a5c78456d3.var_ec0839e67621564) {
        draw_circle(var_2b0bb0a5c78456d3.startpoint, trigger.var_d7cc23f6b3a10a7, (1, 0.5, 0.5), 1, 0, 1);
      }
    }

    waitframe();
  }
}

# /