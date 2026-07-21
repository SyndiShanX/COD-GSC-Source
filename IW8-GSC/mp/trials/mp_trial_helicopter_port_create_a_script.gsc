/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\trials\mp_trial_helicopter_port_create_a_script.gsc
******************************************************************/

_id_1348D(var_0, var_1, var_2) {
  var_3 = scripts\asm\soldier\pain::getpaindirectiontoactor();
  var_4 = "_encstr_877D06BB570AB0D0";
  var_5 = "_encstr_8B9B085B961998DB19F2";
  var_6 = [];

  if(scripts\engine\utility::damagelocationisany("_encstr_81CC0586952C91", "_encstr_A6CC076A05751852B3", "_encstr_9ABA05E87F4B70")) {
    var_4 = "_encstr_81CC0586952C91";
    var_5 = "_encstr_81CC0586952C91";
    var_6[var_6.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "_encstr_81CC0586952C91" + var_3);
  } else if(scripts\engine\utility::damagelocationisany("_encstr_8D9A10260457F8118F7ED3639F75A0BB9BDB", "_encstr_970110C3DBB4827401D972BD36B0A7CB1D45", "_encstr_A1BD0B9C96D9D0A3F51A169B19")) {
    var_4 = "_encstr_A61F054B88CBE5";
    var_5 = "_encstr_8B9B085B961998DB19F2";
    var_6[var_6.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "_encstr_A61F054B88CBE5" + var_3);
  } else if(scripts\engine\utility::damagelocationisany("_encstr_A9C30F63CA998ED716E4D67D5D1C0ECAE4", "_encstr_8B970F1B56991DD758E4D6EB63ED77B239", "_encstr_BDB30AC6CA66A3FAA158CD23")) {
    var_4 = "_encstr_86AD05B116396B";
    var_5 = "_encstr_8B9B085B961998DB19F2";
    var_6[var_6.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "_encstr_86AD05B116396B" + var_3);
  } else if(scripts\engine\utility::damagelocationisany("_encstr_BDF80F4495E9F3C9C1387AF15011FA4F83", "_encstr_BACF0FC17D8FB0A0BB52111E2A5F6CE022", "_encstr_95E80A8D59CCD1F533DBED3A")) {
    var_4 = "_encstr_B2AD05EDF1C38F";
    var_5 = "_encstr_AFD50A3C308FCD6BD2187B33";
    var_6[var_6.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "_encstr_B2AD05EDF1C38F" + var_3);
  } else if(scripts\engine\utility::damagelocationisany("_encstr_8B1D10834BA13813E7693FB7D86B8BE80920", "_encstr_A91A1025A967F88DCF6A0971613BC8C83F2A", "_encstr_8ECF0B734B47E3AB67AD07909B")) {
    var_4 = "_encstr_A11F0525739274";
    var_5 = "_encstr_AFD50A3C308FCD6BD2187B33";
    var_6[var_6.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "_encstr_A11F0525739274" + var_3);
  } else {
    var_4 = "_encstr_877D06BB570AB0D0";
    var_5 = "_encstr_8B9B085B961998DB19F2";
    var_6[var_6.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "_encstr_877D06BB570AB0D0" + var_3);
  }

  var_7 = var_4 + var_3;
  var_8 = "_encstr_8C0703271D";

  if(var_3 == "_encstr_B40703E96D")
    var_8 = "_encstr_8B0703EBE0";
  else if(var_3 == "_encstr_A50703AFB1")
    var_8 = "_encstr_A50703AFD8";
  else if(var_3 == "_encstr_9207034F36")
    var_8 = "_encstr_AF0703DE3B";

  self.asm.aliaspain = var_7;
  return var_6[randomint(var_6.size)];
}

_id_1348F(var_0, var_1, var_2) {
  var_3 = 30;
  var_4 = 150;
  var_5 = 300;
  var_6 = [];
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = navtrace(self.origin, self localtoworldcoords((var_5, 0, 0)), self, 1);

  if(var_10["_encstr_A53009A25003666B9818C6"] > 0.9)
    var_8 = 1;

  if(var_10["_encstr_A53009A25003666B9818C6"] > 0.9 * (var_4 / var_5))
    var_7 = 1;

  if(isDefined(self.a.disablelongpain)) {
    var_8 = 0;
    var_7 = 0;
  }

  var_11 = length(self.velocity);
  var_12 = scripts\asm\shared\utility::getbasearchetype();
  var_13 = scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::_id_1349E();

  if(var_8) {
    var_14 = "_encstr_B4AD059D68F0E7" + var_13;
    var_6[var_6.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_14);
  } else if(var_7) {
    var_14 = "_encstr_AB5E07609A5B7368E5" + var_13;
    var_6[var_6.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_14);
  } else if(var_10["_encstr_A53009A25003666B9818C6"] > 0.9 * (var_3 / var_5)) {
    var_14 = "_encstr_8C4806EBD0682BFB" + var_13;
    var_6[var_6.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_14);
  }

  if(var_6.size == 0)
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "_encstr_B88211F02D5F023F5D325F91B8696E3242D3F3");

  return var_6[randomint(var_6.size)];
}