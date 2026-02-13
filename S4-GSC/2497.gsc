/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2497.gsc
*************************************************/

_id_AC3E(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(level._id_4A7D)) {
    return;
  }
  if(!isDefined(game["dialog"][var_0])) {
    return;
  }
  var_5 = _id_6DD4(self.pers["team"]);

  if(isDefined(var_4)) {
    var_5 = var_4;
  }

  var_6 = "dx_mpo_" + var_5 + "op_" + game["dialog"][var_0];
  self _meth_8287(var_6, var_0, 2, var_1, var_2, var_3);
}

_id_6DD4(var_0) {
  var_1 = "us";

  if(var_0 == "axis") {
    var_1 = "ru";
  }

  return var_1;
}

_id_B8A7() {
  if(istrue(level._id_4A7D)) {
    return;
  }
  var_0 = self;

  if(isDefined(self.owner)) {
    var_0 = self.owner;
  }

  var_0 _meth_8287("dx_mpo_static_crash", "static_crash", 2);
}