/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_626264ce9b97c032.gsc
*************************************************/

#using script_d74ae0b4aa21186;
#namespace namespace_96cc481cde994b55;

function combatconstants() {
  dc1 = function_39b811fb3872bdb8(&function_ea52a9e609588f7f);
  var_639f4cce0fa6be8f = dc1 function_30e98541032449dd(&function_3f3aa202a618002f, "brtdm_mgl.*.*");
  dc_conflict = dc1 function_30e98541032449dd(&function_2d053331798842c0, "conflict.*.*");
  return [dc1, var_639f4cce0fa6be8f, dc_conflict];
}

function function_ea52a9e609588f7f(constants) {
  constants.nearbyenemydistance = 5850;
  constants.var_96af88c97db9ed21 = [0, 585, 780, 1560, 1755, 2925, 3900, 5850];
  constants.var_49e2976ca0c853ef = [98, 90, 81, 63, 53, 22, 5, 0];
  constants.var_5dcbc5ccec64f7de = 1000;
  constants.var_e3d1cf896f26ee33 = [195, 780, 1755, 2730];
  constants.var_85a0650f30c0b0b9 = [-5, -20, -30, -40];
  constants.attackermodifier = 10;
}

function function_3f3aa202a618002f(constants) {
  constants.var_5dcbc5ccec64f7de = 2000;
  constants.var_e3d1cf896f26ee33 = [195, 975, 1755, 2730];
  constants.var_85a0650f30c0b0b9 = [0, -10, -25, -40];
  constants.attackermodifier = 15;
}

function function_2d053331798842c0(constants) {
  constants.var_5dcbc5ccec64f7de = 1200;
  constants.var_e3d1cf896f26ee33 = [312, 780, 1755, 2730];
  constants.var_85a0650f30c0b0b9 = [0, -5, -20, -40];
}

function wanderconstants() {
  dc1 = function_39b811fb3872bdb8(&function_42109511957edc0c);
  return [dc1];
}

function function_42109511957edc0c(constants) {
  constants.basescore = 5;
}

function function_a785de697f238498() {
  dc1 = function_39b811fb3872bdb8(&function_515b3dd18696defb);
  return [dc1];
}

function function_515b3dd18696defb(constants) {
  constants.basescore = 60;
  constants.var_563192eda3cf18c5 = [60, 30, 10];
}

function function_9a5ee96584bc41da() {
  dc1 = function_39b811fb3872bdb8(&function_4ee3e0955c322f1);
  return [dc1];
}

function function_4ee3e0955c322f1(constants) {
  constants.basescore = 60;
  constants.var_563192eda3cf18c5 = [40, 30, 15, 10, 5];
}

function function_1715d4b0af35742b() {
  dc1 = function_39b811fb3872bdb8(&function_c355befb2390bed6);
  return [dc1];
}

function function_c355befb2390bed6(constants) {
  var_9a3d792c6b6c808 = 20;
  var_94e895f3e5ef5659 = 8;
  constants.basescore = 60;
  constants.var_cc2f39e2d76f6b7d = 51;
  constants.var_50cf5a797d61ae47 = [var_94e895f3e5ef5659, var_94e895f3e5ef5659 + 1, var_9a3d792c6b6c808];
  constants.var_f65cad93a3671678 = [0, -20, 0];
  constants.teammatemodifier = [10, 10, 0, 0, 0, 0];
}

function function_8c99be760680f663() {
  dc1 = function_39b811fb3872bdb8(&function_ea12fe3772d3229b);
  return [dc1];
}

function function_ea12fe3772d3229b(constants) {
  constants.var_96af88c97db9ed21 = [0, 1950, 3900, 7800, 19500];
  constants.var_49e2976ca0c853ef = [50, 45, 35, 25, 0];
  constants.var_ec6070e1ebb11843 = [0, 0.2, 0.4, 0.6, 0.8, 1];
  constants.var_7fef69cec64a3cf4 = [1.2, 1.15, 1.1, 1.05, 1, 0.8];
  constants.var_2348961fb298f28 = [0, 0.65, 0.85, 1.1, 1.15, 1.25];
  constants.var_57228f75b014a7b8 = 5;
  constants.var_daec6fd98c7cee50 = 18;
}