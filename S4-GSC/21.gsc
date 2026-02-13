/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 21.gsc
*************************************************/

_id_00F0() {
  self[[level._id_812C]]();
  var_0 = "axis";

  if(level._id_A76A % 2 == 0) {
    var_0 = "allies";
  }

  level._id_A76A++;
  self _meth_84C4("ai_lochit_dmgtable");
  self[[level._id_D468]](var_0);
  level.agentarray[level.agentarray.size] = self;
}

_id_00F1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = var_5;
  var_1 = [[level._id_121E]](var_1);
  var_14 = self[[level._id_1215]]("on_damaged");

  if(isDefined(var_14)) {
    if(level.gametype == "zombie") {
      self[[var_14]](var_0, var_1, var_2, var_3, var_4, var_13, var_6, var_7, var_8, var_9, var_10, var_11, var_5, var_12);
    } else {
      self[[var_14]](var_0, var_1, var_2, var_3, var_4, var_13, var_6, var_7, var_8, var_9, var_10, var_11, var_5);
    }
  }
}

_id_00F3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(level._id_2F4E)) {
    [[level._id_2F4E]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  }
}

_id_00F4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = var_5;
  var_1 = [[level._id_121E]](var_1);
  var_11 = self[[level._id_1215]]("on_killed");

  if(isDefined(var_11)) {
    self thread[[var_11]](var_0, var_1, var_2, var_4, var_10, var_6, var_7, var_8, var_9);
  }
}

_id_00F2(var_0, var_1) {}

init() {
  _id_812B();
  scripts\anim\notetracks_mp::_id_C27C();
  _id_0009::_id_D7DD();
  level thread _id_0F90();
}

_id_3B84(var_0, var_1, var_2) {
  var_3 = [[level._id_6A56]](var_0);

  if(isDefined(var_3)) {
    var_3._id_3B86 = gettime();

    if(isDefined(var_1)) {
      var_3[[level._id_D468]](var_1);
    } else {
      var_3[[level._id_D468]](var_3.team);
    }

    if(isDefined(var_2)) {
      var_3._id_3800 = var_2;
    }

    if(isDefined(level._id_11EF[var_0]["onAIConnect"])) {
      var_3[[var_3[[level._id_1215]]("onAIConnect")]]();
    }

    var_3[[level._id_115A]]();
  }

  return var_3;
}

_id_812B() {
  level.agentarray = [];
  level._id_A76A = 0;
}

_id_0F90() {
  level endon("game_ended");
  level waittill("connected", var_0);
  var_1 = _func_00AE();

  while(level.agentarray.size < var_1) {
    var_2 = _func_0004();

    if(!isDefined(var_2)) {
      waitframe();
      continue;
    }
  }
}

_id_D132(var_0) {
  self._id_002C = var_0;
  self.health = var_0;
  self.maxhealth = var_0;
}