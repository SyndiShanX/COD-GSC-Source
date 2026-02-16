/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1365.gsc
**************************************/

_id_416B() {
  precacheshader("hud_temperature_gauge");
}

_id_416C(var_0) {
  if(isDefined(self._id_3C98)) {
    return;
  }
  self._id_3C98 = spawnStruct();
  self._id_3C98._id_416D = 1;
  self._id_3C98.overheated = 0;
  self._id_3C98._id_416E = 114;
  self._id_3C98._id_416F = 1.0;
  self._id_3C98._id_4170 = 1.0;
  self._id_3C98._id_4171 = 2.0;
  self._id_3C98._id_4172 = 0.2;
  self._id_3C98._id_4173 = 0.1;
  self._id_3C98._id_4174 = 2.0;
  thread _id_417A();
  thread _id_4178(var_0);
}

_id_4175() {
  self notify("disable_overheat");
  level._id_1C4F = undefined;
  waittillframeend;

  if(isDefined(self._id_3C98._id_4176)) {
    self._id_3C98._id_4176 destroy();
  }
  if(isDefined(self._id_3C98._id_4177)) {
    self._id_3C98._id_4177 destroy();
  }
  self._id_3C98 = undefined;
}

_id_4178(var_0) {
  self endon("disable_overheat");

  for(;;) {
    if(self._id_3C98._id_416D >= self._id_3C98._id_416E) {
      wait 0.05;
      continue;
    }

    if(self attackButtonPressed() && !self._id_3C98.overheated) {
      self._id_3C98._id_416D = self._id_3C98._id_416D + self._id_3C98._id_416F;
    } else {
      self._id_3C98._id_416D = self._id_3C98._id_416D - self._id_3C98._id_4170;
    }
    self._id_3C98._id_416D = clamp(self._id_3C98._id_416D, 1, self._id_3C98._id_416E);
    _id_4179();
    thread overheated(var_0);
    wait 0.05;
  }
}

_id_4179() {
  self._id_3C98._id_4177 scaleovertime(0.05, 10, int(self._id_3C98._id_416D));
  thread _id_417B(self._id_3C98._id_416D, 0.05);
}

_id_417A() {
  self endon("disable_overheat");
  var_0 = 0;

  if(maps\_utility::_id_12C1()) {
    var_0 = 70;
  }
  var_1 = -10;
  var_2 = -152 + var_0;

  if(!isDefined(self._id_3C98._id_4176)) {
    self._id_3C98._id_4176 = newclienthudelem(self);
    self._id_3C98._id_4176.alignx = "right";
    self._id_3C98._id_4176.aligny = "bottom";
    self._id_3C98._id_4176.horzalign = "right";
    self._id_3C98._id_4176.vertalign = "bottom";
    self._id_3C98._id_4176.x = 2;
    self._id_3C98._id_4176.y = -120 + var_0;
    self._id_3C98._id_4176 setshader("hud_temperature_gauge", 35, 150);
    self._id_3C98._id_4176.sort = 4;
  }

  if(!isDefined(self._id_3C98._id_4177)) {
    self._id_3C98._id_4177 = newclienthudelem(self);
    self._id_3C98._id_4177.alignx = "right";
    self._id_3C98._id_4177.aligny = "bottom";
    self._id_3C98._id_4177.horzalign = "right";
    self._id_3C98._id_4177.vertalign = "bottom";
    self._id_3C98._id_4177.x = var_1;
    self._id_3C98._id_4177.y = var_2;
    self._id_3C98._id_4177 setshader("white", 10, 1);
    self._id_3C98._id_4177.color = (1, 0.9, 0);
    self._id_3C98._id_4177.alpha = 1;
    self._id_3C98._id_4177.sort = 1;
  }
}

overheated(var_0) {
  self endon("disable_overheat");

  if(self._id_3C98._id_416D < self._id_3C98._id_416E) {
    return;
  }
  if(self._id_3C98.overheated) {
    return;
  }
  self._id_3C98.overheated = 1;
  level._id_1C4F = 0;
  thread maps\_utility::play_sound_on_entity("smokegrenade_explode_default");
  self._id_3C98._id_416D = self._id_3C98._id_416E;

  if(isDefined(var_0.mgturret)) {
    var_0.mgturret[0] turretfiredisable();
  }
  var_1 = gettime();
  var_2 = self._id_3C98._id_4172;

  for(;;) {
    self._id_3C98._id_4177 fadeovertime(var_2);
    self._id_3C98._id_4177.alpha = 0.2;
    wait(var_2);
    self._id_3C98._id_4177 fadeovertime(var_2);
    self._id_3C98._id_4177.alpha = 1.0;
    wait(var_2);
    var_2 = var_2 + self._id_3C98._id_4173;

    if(gettime() - var_1 >= self._id_3C98._id_4171 * 1000) {
      break;
    }
  }

  self._id_3C98._id_4177.alpha = 1.0;
  self._id_3C98._id_416D = self._id_3C98._id_416D - self._id_3C98._id_4170;
  wait(self._id_3C98._id_4174);

  if(isDefined(var_0.mgturret)) {
    var_0.mgturret[0] turretfireenable();
  }
  level._id_1C4F = undefined;
  self._id_3C98.overheated = 0;
}

_id_417B(var_0, var_1) {
  self endon("disable_overheat");
  var_2 = [];
  var_2[0] = 1.0;
  var_2[1] = 0.9;
  var_2[2] = 0.0;
  var_3 = [];
  var_3[0] = 1.0;
  var_3[1] = 0.5;
  var_3[2] = 0.0;
  var_4 = [];
  var_4[0] = 0.9;
  var_4[1] = 0.16;
  var_4[2] = 0.0;
  var_5 = [];
  var_5[0] = var_2[0];
  var_5[1] = var_2[1];
  var_5[2] = var_2[2];
  var_6 = 0;
  var_7 = self._id_3C98._id_416E / 2;
  var_8 = self._id_3C98._id_416E;
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;

  if(var_0 > var_6 && var_0 <= var_7) {
    var_9 = int(var_0 * (100 / var_7));

    for(var_12 = 0; var_12 < var_5.size; var_12++) {
      var_10 = var_3[var_12] - var_2[var_12];
      var_11 = var_10 / 100;
      var_5[var_12] = var_2[var_12] + var_11 * var_9;
    }
  } else if(var_0 > var_7 && var_0 <= var_8) {
    var_9 = int((var_0 - var_7) * (100 / (var_8 - var_7)));

    for(var_12 = 0; var_12 < var_5.size; var_12++) {
      var_10 = var_4[var_12] - var_3[var_12];
      var_11 = var_10 / 100;
      var_5[var_12] = var_3[var_12] + var_11 * var_9;
    }
  }

  if(isDefined(var_1)) {
    self._id_3C98._id_4177 fadeovertime(var_1);
  }
  if(isDefined(self._id_3C98._id_4177.color)) {
    self._id_3C98._id_4177.color = (var_5[0], var_5[1], var_5[2]);
  }
}