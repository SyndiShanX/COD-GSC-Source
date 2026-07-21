/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\trials\mp_trl_boneyard_gw_race.gsc
*************************************************/

_id_134AD(var_0, var_1, var_2) {
  self endon(var_1 + "_encstr_A3DB0AF5332DDCD237D0AC8C");
  self.scripted_mode = 1;
  self animmode("_encstr_B69807B9DE36C69683");
  var_3 = scripts\asm\asm_mp::asm_getanimindex(var_0, var_1);
  var_4 = 0.01;
  thread scripts\asm\asm_mp::asm_playanimstateindex(var_0, var_1, var_3, var_4);

  if(isDefined(level._id_1355B))
    self[[level._id_1355B]]();

  wait 0.5;
  self.shouldbekilledoff = 1;
}

_id_134AE(var_0, var_1, var_2) {
  self endon(var_1 + "_encstr_A3DB0AF5332DDCD237D0AC8C");
  self._id_1286D = self.ignoreall;

  if(isDefined(self.scripted_mode))
    self._id_1286E = self.scripted_mode;

  if(getdvarint("_encstr_88121B5F88DBC7BA4508F6EC102FD38103884B8FB8F13F43A33F3D6665", 0) == 1) {
    self.scripted_mode = 1;
    self.turbopetchallengewatcher = 1;
    self._id_142B2 = 1;
    self.ignoreall = 1;
    self animmode("_encstr_B69807B9DE36C69683");
    self.hasplayedvignetteanim = 0;
    var_3 = scripts\asm\asm_mp::asm_getanimindex(var_0, var_1);
    var_4 = 1.0;

    if(isDefined(self._id_142B3))
      var_4 = self._id_142B3;

    var_5 = self.do_immediate_ragdoll;
    self.do_immediate_ragdoll = 1;
    scripts\asm\asm_mp::care_pkg(var_0, var_1, var_3, var_4, "_encstr_B6B30A278FC7F078673A0B11");
    self.do_immediate_ragdoll = var_5;
  }

  self.hasplayedvignetteanim = 1;
}

_id_134BF(var_0, var_1, var_2) {
  self animmode("_encstr_8AD6086722F1FB98F58B");

  if(isDefined(self._id_1286E)) {
    self.scripted_mode = self._id_1286E;
    self._id_1286E = undefined;
  } else
    self.scripted_mode = undefined;

  self.ignoreall = self._id_1286D;
  self._id_1286D = undefined;
  self.hasplayedvignetteanim = 1;
  self.turbopetchallengewatcher = undefined;
  self._id_142B2 = undefined;
  self _meth_87BC(0);
  self notify("_encstr_82CD14B812EB1D107F7EBBA44EBFBBA917A9487B6AC7");
}

_id_134A2(var_0, var_1, var_2, var_3) {
  return istrue(self.shouldbekilledoff);
}

_id_134A1(var_0, var_1, var_2, var_3) {
  return istrue(self.hasplayedvignetteanim);
}