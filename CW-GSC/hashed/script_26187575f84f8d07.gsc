/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_26187575f84f8d07.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\oob;
#using scripts\core_common\util_shared;
#namespace namespace_b77e8eb1;

function init(var_551ace8a, var_94aa053c) {
  level.var_2c9f7c6b = isDefined(getgametypesetting(#"hash_1cf5e61c49992dc3")) ? getgametypesetting(#"hash_1cf5e61c49992dc3") : 0;
  level.var_cd139dc0 = (isDefined(getgametypesetting(#"hash_7f837b709840950")) ? getgametypesetting(#"hash_7f837b709840950") : 1) * 100;
  level.var_67432513 = (isDefined(getgametypesetting(#"hash_6cd4374035db175e")) ? getgametypesetting(#"hash_6cd4374035db175e") : 0) * 100;
  level.var_d18d7655 = (isDefined(getgametypesetting(#"hash_786ee581eedabff0")) ? getgametypesetting(#"hash_786ee581eedabff0") : 0) * 100;
  level.var_7108bd31 = isDefined(getgametypesetting(#"hash_eff3a2f99071600")) ? getgametypesetting(#"hash_eff3a2f99071600") : 0;
  level.var_c0839e43 = isDefined(getgametypesetting(#"hash_162ebc3912b68841")) ? getgametypesetting(#"hash_162ebc3912b68841") : 0;
  level.var_de7aa071 = isDefined(getgametypesetting(#"hash_570912155889089e")) ? getgametypesetting(#"hash_570912155889089e") : 0;
  level.var_aa6b51f5 = isDefined(getgametypesetting(#"hash_5d04a19b625d7300")) ? getgametypesetting(#"hash_5d04a19b625d7300") : 0;
  level.var_35b75d82 = isDefined(getgametypesetting(#"hash_371e83f096bf0548")) ? getgametypesetting(#"hash_371e83f096bf0548") : 0;
  level.var_380f7d22 = 200;
  clientfield::register("scriptmover", "ftdb_zoneCircle", 1, 3, "int");
  clientfield::register("scriptmover", "zoneNearOOB", 1, 1, "int");
  clientfield::register("scriptmover", "disable_compass_arrow", 1, 1, "int");
  level.var_551ace8a = var_551ace8a;
  level.var_94aa053c = var_94aa053c;
  level.var_ac7be286 = [];
}

function onstartgametype() {
  if(getdvarint(#"hash_26399e7b3c887ffb", 0)) {
    level thread function_64d94faa();
  }
}

function function_8e4e3bb2() {
  foreach(var_9bbce2cd in level.var_ac7be286) {
    var_8e392e0f = var_9bbce2cd.var_8e392e0f;

    if(distance2dsquared(self.origin, var_9bbce2cd.origin) < var_8e392e0f * var_8e392e0f) {
      return true;
    }

    var_537b12bd = var_9bbce2cd.var_261dd536 * 800 + level.var_cd139dc0;

    if(distance2dsquared(self.origin, var_9bbce2cd.origin) < var_537b12bd * var_537b12bd) {
      var_b04baebd = 0;

      for(i = var_9bbce2cd.var_e17ae8be.size - 1; i >= 0; i--) {
        if(var_9bbce2cd.var_e17ae8be[i].size > 0) {
          var_b04baebd++;

          if(self function_c7c0cee2(var_9bbce2cd, i)) {
            return true;
          }
        }

        if(var_b04baebd >= 2) {
          break;
        }
      }
    }
  }

  return false;
}

function private function_c7c0cee2(var_9bbce2cd, ringindex) {
  assert(isPlayer(self));

  for(i = 0; i < var_9bbce2cd.var_e17ae8be[ringindex].size; i++) {
    var_ac287808 = var_9bbce2cd.var_e17ae8be[ringindex][i];

    if(!isDefined(var_ac287808.model.curradius)) {
      continue;
    }

    if(distance2dsquared(self.origin, var_ac287808.origin) < var_ac287808.model.curradius * var_ac287808.model.curradius) {
      return true;
    }
  }

  return false;
}

function function_1cb7e339() {
  self clientfield::set("ftdb_zoneCircle", 3);
}

function function_a5caaee0() {
  level.var_ac7be286[level.var_ac7be286.size] = self;
  self function_6a583613();

  if(getdvarint(#"hash_1216cbfbf11758ce", 0)) {
    self thread function_3d8141ab();
  }

  self thread function_57172b7();
}

function private function_57172b7() {
  level endon(#"game_ended");

  if(isDefined(level.var_551ace8a)) {
    [[level.var_551ace8a]](self.origin);
  }

  self.var_261dd536++;

  while(self.var_261dd536 < self.numrings) {
    self function_87a78a13();
    self.var_261dd536++;
  }

  if(isDefined(self.script_radius)) {
    var_85eee64 = self.var_261dd536 - 2;

    for(i = 0; i < self.var_fa06c0e[var_85eee64].size; i++) {
      origin = self.var_fa06c0e[var_85eee64][i];
      var_5162de87 = self function_2be7a212(var_85eee64, origin);
      var_5162de87 thread function_60c3117b(0.1, 1, 5, 0);
      util::wait_network_frame(1);
    }

    for(i = 0; i < self.var_e17ae8be[var_85eee64].size; i++) {
      self.var_e17ae8be[var_85eee64][i].model clientfield::set("ftdb_zoneCircle", 0);
    }

    return;
  }

  wait level.var_c0839e43;

  if(isDefined(level.var_94aa053c)) {
    [[level.var_94aa053c]](self.origin);
  }

  self.var_261dd536--;

  while(self.var_261dd536 >= 0) {
    self function_5c839f44();
    self.var_261dd536--;
  }

  var_a8c6fd3b = level.var_de7aa071 / (self.numrings + 1);
  wait var_a8c6fd3b;
  self function_ea7ab3a9();

  for(i = 0; i < level.var_ac7be286.size; i++) {
    if(self == level.var_ac7be286[i]) {
      level.var_ac7be286[i] = level.var_ac7be286[level.var_ac7be286.size - 1];
      level.var_ac7be286[level.var_ac7be286.size - 1] = undefined;
    }
  }
}

function private function_6a583613() {
  self.var_8e392e0f = level.var_cd139dc0;
  self.var_261dd536 = 0;
  self function_218080fb();
  self function_cd602d73();
}

function private function_218080fb() {
  self.var_fa06c0e = [];
  self.var_e17ae8be = [];
  self.var_3401d807 = [];
  initialradius = level.var_cd139dc0;
  self.var_a96d0116 = 0;

  if(isDefined(self.script_radius)) {
    maxradius = self.script_radius;

    if(!isDefined(level.var_e1206a08)) {
      maxradius -= 1600;
    }

    self.var_a96d0116 = 4;
  } else {
    maxradius = randomintrange(level.var_d18d7655, level.var_67432513);
  }

  self.numrings = int((maxradius - initialradius) / 800 + 0.5) + self.var_a96d0116;
  var_92d713c7 = level.var_aa6b51f5;
  totaldelta = maxradius - initialradius;

  if(isDefined(self.script_radius) && !isDefined(level.var_e1206a08)) {
    totaldelta += 1600;
  }

  self.var_91017512 = totaldelta / (self.numrings - 1 - self.var_a96d0116);
  self.circleradius = 800;

  for(i = 0; i < self.numrings; i++) {
    self.var_fa06c0e[i] = [];
    self.var_e17ae8be[i] = [];
    self.var_3401d807[i] = [];
    var_4fc3d1c0 = initialradius + self.var_91017512 * i;
    numcircles = int(var_4fc3d1c0 * 2 * 3.14159 / self.circleradius / 1 / (1 + var_92d713c7) + 0.5);
    angledelta = 360 / numcircles;

    for(j = 0; j < numcircles; j++) {
      angle = angledelta * j;
      vector = (cos(angle), sin(angle), 0);
      origin = self.origin + vectorscale(vector, var_4fc3d1c0);

      if(level.var_380f7d22 > 0) {
        offsetangle = randomint(360);
        offsetvector = (cos(offsetangle), sin(offsetangle), 0);
        var_3413960f = randomint(level.var_380f7d22);
        origin += vectorscale(offsetvector, var_3413960f);
      }

      self.var_fa06c0e[i][j] = origin;
    }
  }

  if(isDefined(level.var_36cba6d6)) {
    for(i = 1; self.numrings - i > 3; i++) {
      self function_7a12a868(self.numrings - i, level.var_36cba6d6);
    }
  }

  self.numrings -= self.var_a96d0116;
}

function private function_7a12a868(var_4838ddab, origin) {
  var_27ad1fd0 = self.var_fa06c0e[var_4838ddab].size * 0.75;
  var_5669bf82 = 0;

  for(i = 0; i < self.var_fa06c0e[var_4838ddab].size; i++) {
    var_180a7ec0 = 0;

    if(var_5669bf82 >= var_27ad1fd0) {
      var_180a7ec0 = 1;
    } else {
      var_1d8f74ad = distancesquared(self.var_fa06c0e[var_4838ddab][i], origin);
      var_7047a386 = distancesquared(self.origin, origin);

      if(var_1d8f74ad > var_7047a386 * (2 - 0.6)) {
        var_180a7ec0 = 1;
      } else if(var_1d8f74ad > var_7047a386 * 0.6) {
        if(randomfloat(1) > 0.4) {
          var_180a7ec0 = 1;
        }
      }
    }

    if(var_180a7ec0) {
      self.var_fa06c0e[var_4838ddab][i] = self.var_fa06c0e[var_4838ddab][self.var_fa06c0e[var_4838ddab].size - 1];
      self.var_fa06c0e[var_4838ddab][self.var_fa06c0e[var_4838ddab].size - 1] = undefined;
      i--;
      continue;
    }

    var_5669bf82++;
  }
}

function private function_cd602d73() {
  self.var_b06ed2fa = spawn("script_model", self.origin);
  self.var_b06ed2fa.team = # "neutral";
  self.var_b06ed2fa setModel("tag_origin");
  self.var_b06ed2fa clientfield::set("ftdb_zoneCircle", 2);
  self.var_b06ed2fa.numrings = self.numrings;
  self.var_b06ed2fa.var_2c8491dd = self;
  self.var_b06ed2fa setforcenocull();
  self.var_b06ed2fa setscale(0.1);

  if(self function_2020d6b0()) {
    self.var_b06ed2fa clientfield::set("zoneNearOOB", 1);
  }

  if(level.gametype == "spy") {
    self.var_b06ed2fa clientfield::set("disable_compass_arrow", 1);
  }
}

function private function_2020d6b0() {
  if(!isDefined(self)) {
    assert(0);
    return false;
  }

  checkdistance = level.var_67432513;
  checks = [(0, checkdistance, self.origin[2]), (0, checkdistance * -1, self.origin[2]), (checkdistance, 0, self.origin[2]), (checkdistance * -1, 0, self.origin[2])];

  foreach(check in checks) {
    pointinfo = function_9cc082d2(self.origin + check, 10000);

    if(!isDefined(pointinfo)) {
      return true;
    }

    if(oob::chr_party(pointinfo[#"point"])) {
      return true;
    }
  }

  return false;
}

function private function_87a78a13() {
  var_b75abae3 = isDefined(self.growtime) ? self.growtime / self.numrings : level.var_7108bd31 / self.numrings;

  if(self.var_261dd536 >= 2) {
    nextradius = self.var_8e392e0f + self.var_91017512;
    currentscale = self.var_8e392e0f / level.var_cd139dc0;
    var_ac2ef1c2 = nextradius / level.var_cd139dc0;
    self thread function_6941b393(currentscale, var_ac2ef1c2, var_b75abae3);
  }

  maxindex = 0;

  for(i = 0; i < self.var_261dd536; i++) {
    maxindex += self.var_fa06c0e[i].size;
  }

  var_806fff0a = int(maxindex * level.var_35b75d82);
  var_1082b7c4 = var_b75abae3 / var_806fff0a;

  for(i = 0; i < var_806fff0a; i++) {
    wait var_1082b7c4;
    index = randomint(maxindex);
    maxindex--;

    for(j = 0; j < self.var_261dd536; j++) {
      if(index < self.var_fa06c0e[j].size) {
        origin = self.var_fa06c0e[j][index];
        self.var_fa06c0e[j][index] = self.var_fa06c0e[j][self.var_fa06c0e[j].size - 1];
        self.var_fa06c0e[j][self.var_fa06c0e[j].size - 1] = undefined;
        var_5162de87 = self function_2be7a212(j, origin);
        var_5162de87 thread function_60c3117b(0.1, 1, 5, 0);
        break;
      }

      index -= self.var_fa06c0e[j].size;
    }

    if(is_true(self.var_3dde41e2) && isDefined(var_5162de87)) {
      util::wait_network_frame(1);

      if(isDefined(var_5162de87)) {
        var_5162de87 clientfield::set("ftdb_zoneCircle", 0);
      }
    }
  }

  if(self.var_261dd536 >= 2) {
    self thread function_f8afee63(self.var_261dd536 - 2);
  }
}

function private function_5c839f44() {
  var_b75abae3 = level.var_de7aa071 / (self.numrings + 1);

  if(self.var_261dd536 + 1 < self.numrings) {
    nextradius = self.var_8e392e0f - self.var_91017512;
    currentscale = self.var_8e392e0f / level.var_cd139dc0;
    var_ac2ef1c2 = nextradius / level.var_cd139dc0;

    if(self.var_261dd536 > 0) {
      self thread function_6941b393(currentscale, var_ac2ef1c2, var_b75abae3);
    } else {
      self thread function_6941b393(currentscale, var_ac2ef1c2, var_b75abae3 * 2);
    }
  }

  maxindex = self.var_e17ae8be[self.var_261dd536].size;
  var_7a62ca2 = self.var_261dd536 - 1;

  if(var_7a62ca2 >= 0) {
    for(i = 0; i < self.var_3401d807[var_7a62ca2].size; i++) {
      var_5162de87 = self function_2be7a212(var_7a62ca2, self.var_3401d807[var_7a62ca2][i]);
    }
  }

  if(maxindex == 0) {
    wait var_b75abae3;
    return;
  }

  loopmax = maxindex - 1;
  var_1082b7c4 = var_b75abae3 / maxindex;

  for(i = loopmax; i >= 0; i--) {
    wait var_1082b7c4;
    self thread function_40c81ea4(self.var_261dd536, i);
  }
}

function private function_f8afee63(ringindex) {
  self endon(#"death");
  level endon(#"game_ended");

  for(i = self.var_fa06c0e[ringindex].size - 1; i >= 0; i--) {
    self.var_fa06c0e[ringindex][i] = undefined;
  }

  for(i = self.var_e17ae8be[ringindex].size - 1; i >= 0; i--) {
    self.var_e17ae8be[ringindex][i].model clientfield::set("ftdb_zoneCircle", 4);
    self.var_3401d807[ringindex][self.var_3401d807[ringindex].size] = self.var_e17ae8be[ringindex][i].model.origin;
    util::wait_network_frame(1);
    self.var_e17ae8be[ringindex][i].model delete();
    self.var_e17ae8be[ringindex][i] = undefined;
  }
}

function private function_2be7a212(ringindex, origin) {
  origin = function_b4c74561(origin + (0, 0, 16));
  radindex = self.var_e17ae8be[ringindex].size;
  self.var_e17ae8be[ringindex][radindex] = {};
  self.var_e17ae8be[ringindex][radindex].origin = origin;
  self.var_e17ae8be[ringindex][radindex].model = spawn("script_model", origin);
  self.var_e17ae8be[ringindex][radindex].model.team = # "neutral";
  self.var_e17ae8be[ringindex][radindex].model setModel("tag_origin");
  self.var_e17ae8be[ringindex][radindex].model clientfield::set("ftdb_zoneCircle", 1);
  self.var_e17ae8be[ringindex][radindex].model.var_2c8491dd = self;
  self.var_e17ae8be[ringindex][radindex].model setforcenocull();
  return self.var_e17ae8be[ringindex][radindex].model;
}

function private function_b4c74561(origin) {
  var_9912c765 = (0, 0, 200);
  attempts = 1;
  uptrace = bulletTrace(origin + var_9912c765, origin, 0, self);
  downtrace = bulletTrace(origin, origin - var_9912c765, 0, self);

  while(downtrace[#"fraction"] == 1 && uptrace[#"fraction"] == 1 && attempts < 10) {
    uptrace = bulletTrace(origin + var_9912c765 * (attempts + 1), origin + var_9912c765 * attempts, 0, self);
    downtrace = bulletTrace(origin - var_9912c765 * attempts, origin - var_9912c765 * (attempts + 1), 0, self);
    attempts++;
  }

  if(downtrace[#"fraction"] <= uptrace[#"fraction"]) {
    origin = downtrace[#"position"];
  } else {
    origin = uptrace[#"position"];
  }

  return origin;
}

function private function_60c3117b(startscale, goalscale, duration, var_8253fe22) {
  self endon(#"death");
  level endon(#"game_ended");
  starttime = gettime();

  if(startscale < 0.1) {
    startscale = 0.1;
  }

  self setscale(var_8253fe22 ? startscale / 10 : startscale);
  waitframe(1);

  while(gettime() < starttime + int(duration * 1000)) {
    timefrac = (gettime() - starttime) / int(duration * 1000);
    scale = startscale + timefrac * (goalscale - startscale);

    if(scale < 0.1) {
      self setscale(0.1);
      return;
    }

    self setscale(var_8253fe22 ? scale / 10 : scale);

    if(var_8253fe22) {
      self.var_2c8491dd.var_8e392e0f = level.var_cd139dc0 * scale;
    } else {
      self.curradius = scale * self.var_2c8491dd.circleradius;
    }

    waitframe(1);
  }

  self setscale(var_8253fe22 ? goalscale / 10 : goalscale);
}

function private function_6941b393(startscale, endscale, duration) {
  self endon(#"death");
  level endon(#"game_ended");

  if(is_true(self.var_3dde41e2)) {
    self.var_b06ed2fa function_60c3117b(startscale, endscale, duration, 1);
    return;
  }

  var_65bcb0ae = duration / 2;
  wait var_65bcb0ae;
  self.var_b06ed2fa function_60c3117b(startscale, endscale, var_65bcb0ae, 1);
}

function private function_40c81ea4(ringindex, circleindex) {
  self endon(#"death");
  level endon(#"game_ended");
  var_867cdc1a = self.var_e17ae8be[ringindex][circleindex];

  if(!isDefined(var_867cdc1a.model)) {
    return;
  }

  var_867cdc1a.model function_60c3117b(1, 0.1, 5, 0);
  self function_7886d66d(ringindex, var_867cdc1a);
}

function private function_7886d66d(ringindex, var_867cdc1a) {
  var_867cdc1a.model clientfield::set("ftdb_zoneCircle", 4);
  util::wait_network_frame(1);
  var_867cdc1a.model delete();
  self.var_e17ae8be[ringindex][self.var_e17ae8be[ringindex].size - 1] = undefined;
}

function private function_ea7ab3a9() {
  if(isDefined(self.var_b06ed2fa)) {
    self.var_b06ed2fa clientfield::set("ftdb_zoneCircle", 4);
    util::wait_network_frame(1);
    self.var_b06ed2fa delete();
    self.var_b06ed2fa = undefined;
  }
}

function function_904efdb8() {
  for(i = 0; i < 4; i++) {
    foreach(var_9bbce2cd in level.var_ac7be286) {
      if(i == 0) {
        var_9bbce2cd thread function_f8afee63(var_9bbce2cd.var_261dd536 - 1);
        var_9bbce2cd thread function_f8afee63(var_9bbce2cd.var_261dd536 - 2);
      }

      var_9bbce2cd.var_261dd536++;
      var_9bbce2cd.growtime = 20 * var_9bbce2cd.numrings;
      var_9bbce2cd.var_3dde41e2 = 1;
      var_9bbce2cd thread function_87a78a13();
    }

    wait 20.1;
  }
}

function private function_64d94faa() {
  level endon(#"game_ended");
  level.var_8c48fd1 = 0;
  level.var_a0cb7a38 = [];

  while(true) {
    waitframe(1);
    level.var_2c9f7c6b = isDefined(getgametypesetting(#"hash_1cf5e61c49992dc3")) ? getgametypesetting(#"hash_1cf5e61c49992dc3") : 0;
    level.var_cd139dc0 = (isDefined(getgametypesetting(#"hash_7f837b709840950")) ? getgametypesetting(#"hash_7f837b709840950") : 0) * 100;
    level.var_67432513 = (isDefined(getgametypesetting(#"hash_6cd4374035db175e")) ? getgametypesetting(#"hash_6cd4374035db175e") : 0) * 100;
    level.var_d18d7655 = (isDefined(getgametypesetting(#"hash_786ee581eedabff0")) ? getgametypesetting(#"hash_786ee581eedabff0") : 0) * 100;
    level.var_7108bd31 = isDefined(getgametypesetting(#"hash_eff3a2f99071600")) ? getgametypesetting(#"hash_eff3a2f99071600") : 0;
    level.var_c0839e43 = isDefined(getgametypesetting(#"hash_162ebc3912b68841")) ? getgametypesetting(#"hash_162ebc3912b68841") : 0;
    level.var_de7aa071 = isDefined(getgametypesetting(#"hash_570912155889089e")) ? getgametypesetting(#"hash_570912155889089e") : 0;
    level.var_aa6b51f5 = isDefined(getgametypesetting(#"hash_5d04a19b625d7300")) ? getgametypesetting(#"hash_5d04a19b625d7300") : 0;
    level.var_35b75d82 = isDefined(getgametypesetting(#"hash_371e83f096bf0548")) ? getgametypesetting(#"hash_371e83f096bf0548") : 0;
    level.var_380f7d22 = getdvarint(#"hash_59bc959721744fcb", 200);
    players = getplayers();

    foreach(player in players) {
      if(player useButtonPressed() && !is_true(level.var_a0cb7a38[level.var_8c48fd1])) {
        level.var_2f418a15[level.var_8c48fd1] thread function_33e28605(level.var_8c48fd1);
        level.var_8c48fd1++;
        level.var_8c48fd1 %= 3;
        wait 0.5;
      }
    }
  }
}

function private function_33e28605(var_f07efec7) {
  level.var_a0cb7a38[var_f07efec7] = 1;
  level.var_ac7be286[level.var_ac7be286.size] = self;
  self function_6a583613();

  if(getdvarint(#"hash_1216cbfbf11758ce", 0)) {
    self thread function_3d8141ab();
  }

  self function_57172b7();
  level.var_a0cb7a38[var_f07efec7] = 0;
}

function private function_3d8141ab() {
  level endon(#"game_ended");

  while(!isDefined(self.var_b06ed2fa)) {
    waitframe(1);
  }

  while(isDefined(self.var_b06ed2fa)) {
    var_1b8f1752 = self.var_b06ed2fa getscale();
    sphere(self.var_b06ed2fa.origin, level.var_cd139dc0 * var_1b8f1752 * 10, (0, 1, 0), 0.5, 1, 100, 1);

    foreach(ring in self.var_e17ae8be) {
      foreach(circle in ring) {
        var_a13932b6 = circle.model getscale();
        sphere(circle.model.origin, self.circleradius * var_a13932b6, (0, 1, 0), 0.5, 1, 100, 1);
      }
    }

    waitframe(1);
  }
}

function function_c6ce0ef0(structs) {
  foreach(struct in structs) {
    level.var_ac7be286[level.var_ac7be286.size] = struct;
    struct.var_8e392e0f = struct.script_radius - 1200;
    struct.var_261dd536 = 0;
    struct function_cd602d73();
    targetscale = struct.var_8e392e0f / level.var_cd139dc0 / 10;

    if(targetscale > 10) {
      targetscale = 10;
      level.players[0] iprintlnbold("<dev string:x38>");
    }

    struct.var_b06ed2fa setscale(targetscale);
  }
}

function function_366d6aba() {
  foreach(var_5aeec5ab in level.var_ac7be286) {
    var_5aeec5ab function_ea7ab3a9();
  }

  level.var_ac7be286 = [];
}