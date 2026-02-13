/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1732.gsc
*************************************************/

_id_D5FB(var_0) {
  if(!scripts\common\utility::issp()) {
    self setModel(var_0[randomint(var_0.size)]);
  } else {
    if(!isDefined(level._id_33FB)) {
      level._id_33FB = [];
    }

    var_1 = _id_654B(var_0);

    if(!isDefined(var_1)) {
      var_1 = var_0[randomint(var_0.size)];
    }

    level._id_33FB["last_used"] = var_1;
    level._id_33FB[var_1]++;
    self setModel(var_1);
  }
}

_id_654B(var_0) {
  var_1 = [];
  var_2 = 999999;
  var_1[0] = 0;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(!isDefined(level._id_33FB[var_0[var_3]])) {
      level._id_33FB[var_0[var_3]] = 0;
    }

    var_4 = level._id_33FB[var_0[var_3]];

    if(var_4 > var_2) {
      continue;
    }
    if(var_4 < var_2) {
      var_1 = [];
      var_2 = var_4;
    }

    var_1[var_1.size] = var_3;
  }

  var_5 = random(var_1);
  return var_0[var_5];
}

_id_BB6B(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    precachemodel(var_0[var_1]);
  }
}

_id_1D8B(var_0, var_1) {
  if(!isDefined(level._id_33F9)) {
    level._id_33F9 = [];
  }

  if(!isDefined(level._id_33F9[var_0])) {
    level._id_33F9[var_0] = randomint(var_1.size);
  }

  var_2 = (level._id_33F9[var_0] + 1) % var_1.size;

  if(isDefined(self._id_CCD9)) {
    var_2 = self._id_CCD9 % var_1.size;
  }

  level._id_33F9[var_0] = var_2;
  self attach(var_1[var_2], "", 1);
  self._id_7611 = var_1[var_2];
}

_id_1D8A(var_0, var_1) {
  if(!isDefined(level._id_33F8)) {
    level._id_33F8 = [];
  }

  if(!isDefined(level._id_33F8[var_0])) {
    level._id_33F8[var_0] = randomint(var_1.size);
  }

  var_2 = (level._id_33F8[var_0] + 1) % var_1.size;
  level._id_33F8[var_0] = var_2;
  self attach(var_1[var_2]);
  self._id_75C6 = var_1[var_2];
}

_id_A445() {
  self _meth_809E();
  var_0 = self._id_17D9;

  if(!isDefined(var_0)) {
    return;
  }
  self._id_17D9 = "none";
  self[[anim._id_BE6F]](var_0);
}

_id_CB31() {
  var_0["gunHand"] = self._id_17D9;
  var_0["gunInHand"] = self._id_17DA;
  var_0["model"] = self.model;
  var_0["hatModel"] = self._id_75C6;

  if(isDefined(self.name)) {
    var_0["name"] = self.name;
  } else {}

  var_1 = self _meth_8117();

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_0["attach"][var_2]["model"] = self _meth_8115(var_2);
    var_0["attach"][var_2]["tag"] = self _meth_8118(var_2);
  }

  return var_0;
}

_id_95A8(var_0) {
  self _meth_809E();
  self._id_17D9 = var_0["gunHand"];
  self._id_17DA = var_0["gunInHand"];
  self setModel(var_0["model"]);
  self._id_75C6 = var_0["hatModel"];

  if(isDefined(var_0["name"])) {
    self.name = var_0["name"];
  } else {}

  var_1 = var_0["attach"];
  var_2 = var_1.size;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    self attach(var_1[var_3]["model"], var_1[var_3]["tag"]);
  }
}

_id_0340(var_0) {
  if(isDefined(var_0["name"])) {} else {}

  precachemodel(var_0["model"]);
  var_1 = var_0["attach"];
  var_2 = var_1.size;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    precachemodel(var_1[var_3]["model"]);
  }
}

_id_66D6(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(isDefined(var_3)) {
    var_5 = strtok(var_3, "_");
  } else {
    var_5 = strtok(self.classname, "_");
  }

  if(!scripts\common\utility::issp()) {
    if(isDefined(self.pers["modelIndex"]) && self.pers["modelIndex"] < var_0) {
      return self.pers["modelIndex"];
    }

    var_4 = randomint(var_0);
    self.pers["modelIndex"] = var_4;
    return var_4;
  } else if(var_5.size <= 2)
    return randomint(var_0);

  var_6 = "auto";

  if(isDefined(self._id_CCD9)) {
    var_4 = self._id_CCD9;
  } else if(isDefined(var_1)) {
    var_4 = _id_66EA(var_1);
  }

  if(isDefined(self._id_CCD8)) {
    var_6 = "group_" + self._id_CCD8;
  }

  if(!isDefined(level._id_33FA)) {
    level._id_33FA = [];
  }

  if(!isDefined(level._id_33FA[var_6])) {
    level._id_33FA[var_6] = [];
  }

  if(!isDefined(var_4)) {
    var_4 = _id_654A(var_2, var_6);

    if(!isDefined(var_4)) {
      var_4 = randomint(var_2.size);
    }
  }

  if(!isDefined(level._id_33FA[var_6][var_2[var_4]])) {
    level._id_33FA[var_6][var_2[var_4]] = 0;
  }

  level._id_33FA[var_6][var_2[var_4]]++;
  return var_4;
}

_id_654A(var_0, var_1) {
  var_2 = [];
  var_3 = 999999;
  var_2[0] = 0;

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    if(!isDefined(level._id_33FA[var_1][var_0[var_4]])) {
      level._id_33FA[var_1][var_0[var_4]] = 0;
    }

    var_5 = level._id_33FA[var_1][var_0[var_4]];

    if(var_5 > var_3) {
      continue;
    }
    if(var_5 < var_3) {
      var_2 = [];
      var_3 = var_5;
    }

    var_2[var_2.size] = var_4;
  }

  return random(var_2);
}

_id_81CC(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < var_2; var_3++) {
    level._id_33FA[var_0][var_1][var_3] = 0;
  }
}

_id_66E6(var_0) {
  return randomint(var_0);
}

random(var_0) {
  return var_0[randomint(var_0.size)];
}

_id_66EA(var_0) {
  var_1 = randomfloat(1);

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_1 < var_0[var_2]) {
      return var_2;
    }
  }

  return 0;
}