/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3191.gsc
**************************************/

_id_13F64() {
  if(scripts\asm\asm_bb::bb_movetyperequested("fly")) {
    return 1;
  }

  return 0;
}

_id_13F66() {
  if(scripts\asm\asm_bb::bb_meleerequested()) {
    return 1;
  }

  return 0;
}

_id_13F67() {
  if(scripts\asm\asm_bb::bb_movetyperequested("entangled")) {
    return 1;
  }

  return 0;
}

_id_13F68() {
  if(scripts\aitypes\zombie_ghost\behaviors::getghostnavmode() == "launched") {
    return 1;
  }

  return 0;
}

_id_13F65() {
  if(!isDefined(self.ghost_target_position)) {
    return 0;
  }

  if(scripts\aitypes\zombie_ghost\behaviors::getghostnavmode() == "entangled") {
    return 0;
  }

  var_0 = self.ghost_target_position - self.origin;
  var_1 = calculate_final_spider_score(var_0);

  if(isDefined(var_1)) {
    self._id_6FF5 = var_1;
    return 1;
  } else
    return 0;
}

_id_13F6D(var_0, var_1, var_2, var_3) {
  if(isDefined(self.zombie_ghost_target)) {
    _id_1299A(self.zombie_ghost_target.origin);
  }

  _id_CECF(var_0, var_1, var_2, var_3);
  self notify("ghost_played_melee_anim");
}

_id_13F63(var_0, var_1, var_2, var_3) {
  if(var_0 == "hit") {
    if(!isDefined(self.zombie_ghost_target)) {
      return;
    }
    if(!scripts\cp\utility::isreallyalive(self.zombie_ghost_target)) {
      return;
    }
    if(self.zombie_ghost_target scripts\cp\utility::isignoremeenabled()) {
      return;
    }
    if(scripts\mp\agents\zombie\zombie_util::shouldignoreent(self.zombie_ghost_target)) {
      return;
    }
    if(distancesquared(self.zombie_ghost_target.origin, self.origin) > 9216) {
      return;
    }
    self.zombie_ghost_target dodamage(45, self.origin, self, self, "MOD_MELEE");
  }
}

_id_13F6C(var_0, var_1, var_2, var_3) {
  _id_CECF(var_0, var_1, var_2, var_3);
}

_id_13F6A(var_0, var_1, var_2, var_3) {
  _id_CECF(var_0, var_1, var_2, var_3);
}

_id_826A(var_0, var_1, var_2, var_3, var_4) {
  self endon(var_1 + "_finished");

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  self.currentanimstate = var_1;
  var_5 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  self.currentanimindex = var_5;
  var_6 = scripts\asm\asm::_id_2341(var_0, var_1);

  for(;;) {
    self setanimstate(var_1, var_5, var_3);
    scripts\anim\notetracks_mp::_id_1384C(var_1, "end", var_1, var_5, var_6);
  }
}

_id_13F6E(var_0, var_1, var_2, var_3) {}

zombieghost_constantanglesadjust() {
  self endon("death");

  for(;;) {
    scripts\engine\utility::waitframe();

    if(isDefined(self.ghost_target_position)) {
      _id_1299A(self.ghost_target_position);
    }
  }
}

_id_13F6B(var_0, var_1, var_2, var_3) {
  _id_CECF(var_0, var_1, var_2, var_3);

  if(isDefined(self.ghost_target_position)) {
    _id_1299A(self.ghost_target_position);
  }
}

calculate_final_spider_score(var_0) {
  var_1 = 10;
  var_2 = vectortoangles(var_0);
  var_3 = angleclamp180(var_2[1] - self.angles[1]);
  var_4 = getangleindex(var_3, var_1);

  if(var_4 == 4 || var_4 < 0 || var_4 > 8) {
    return undefined;
  }

  var_5 = _id_79C4();
  return var_5[var_4];
}

_id_13F61(var_0, var_1, var_2, var_3) {
  return self._id_6FF5;
}

_id_79C4() {
  var_0 = [];
  var_0[0] = 0;
  var_0[1] = 1;
  var_0[2] = 2;
  var_0[3] = 3;
  var_0[5] = 4;
  var_0[6] = 5;
  var_0[7] = 6;
  var_0[8] = 7;
  return var_0;
}

_id_1299A(var_0) {
  var_1 = var_0 - self.origin;
  self orientmode("face angle abs", vectortoangles(var_1));
  self.angles = vectortoangles(var_1);
}

_id_CECF(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  var_5 = scripts\asm\asm::_id_2341(var_0, var_1);
  self.currentanimstate = var_1;
  self.currentanimindex = var_4;
  scripts\anim\notetracks_mp::_id_CED2(var_1, var_4, self.animplaybackrate, var_1, "end", var_5);
}