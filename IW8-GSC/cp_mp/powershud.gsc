/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\powershud.gsc
***********************************************/

powershud_init() {
  var_0 = spawnStruct();
  level.power_hud_info = var_0;
  var_0.omnvarnames = ["_encstr_BA7F0830B3A7859B60B0", "_encstr_AC8F0AE74163F85AAA380AD8"];
  var_0.omnvarnames["_encstr_BA7F0830B3A7859B60B0"][0] = "_encstr_BA1E157B08D950EAACDBC37F25553287D0B0F60261501B";
  var_0.omnvarnames["_encstr_BA7F0830B3A7859B60B0"][1] = "_encstr_A2A415ED312753BFBB3AE08152D6694E3FA87FE697977B";
  var_0.omnvarnames["_encstr_BA7F0830B3A7859B60B0"][2] = "_encstr_A6A91243BF419BD86327EB975B2FA650EA5597A7";
  var_0.omnvarnames["_encstr_BA7F0830B3A7859B60B0"][3] = "_encstr_9A980C077391D28F337D5A871409";
  var_0.omnvarnames["_encstr_BA7F0830B3A7859B60B0"][4] = "_encstr_875911BAD2D70EF6EEACC97D36F6736EEAD695";
  var_0.omnvarnames["_encstr_BA7F0830B3A7859B60B0"][5] = "_encstr_8D3E128564C9D9D847BFB0E183619333C2CD7585";
  var_0.omnvarnames["_encstr_BA7F0830B3A7859B60B0"][6] = "_encstr_83800F8BF829A03A7C0B73CF4FA582FC50";
  var_0.omnvarnames["_encstr_AC8F0AE74163F85AAA380AD8"][0] = "_encstr_832B1F5BA70160ED732A6677B6318EAF956A472A7A879813FA2E1A38015ED77583";
  var_0.omnvarnames["_encstr_AC8F0AE74163F85AAA380AD8"][1] = "_encstr_AF0E1F3DE1F7834F4BCA305183E70F385B944F36594FE89B707180F0DA7ACFB1F7";
  var_0.omnvarnames["_encstr_AC8F0AE74163F85AAA380AD8"][2] = "_encstr_85FA1C6314B1EAD7EF891010223BC9278644D9A06A8FEDD1D343A7CBBF98";
  var_0.omnvarnames["_encstr_AC8F0AE74163F85AAA380AD8"][3] = "_encstr_88E71643520E63977FAD2279D7EA61379BF0386081B85BB2";
  var_0.omnvarnames["_encstr_AC8F0AE74163F85AAA380AD8"][4] = "_encstr_A2051BC8F2B18980AF1D4628E30FC96F258AD0786BD9E7D8F313CD39CD";
  var_0.omnvarnames["_encstr_AC8F0AE74163F85AAA380AD8"][5] = "_encstr_BAE41CED0CA1B1A03FD7A8C9E74579D71AF76FF6E05951A803DF5048879C";
  var_0.omnvarnames["_encstr_AC8F0AE74163F85AAA380AD8"][6] = "_encstr_8B791905E2D7100F6FC7D28EF80ADF380E890FD3C8B72A19FE7CA8";
}

powershud_assignpower(var_0, var_1, var_2, var_3) {
  if(var_0 == "_encstr_84DB09430E5B9A0B6D2001") {
    return;
  }
  self setclientomnvar(powershud_getslotomnvar(var_0, 3), var_1);
  var_4 = scripts\engine\utility::ter_op(var_2, 1000, 0);
  self setclientomnvar(powershud_getslotomnvar(var_0, 2), var_4);

  if(!isDefined(var_3))
    var_3 = 0;

  self setclientomnvar(powershud_getslotomnvar(var_0, 0), var_3);
  self setclientomnvar(powershud_getslotomnvar(var_0, 4), 0);
}

powershud_clearpower(var_0) {
  if(var_0 == "_encstr_84DB09430E5B9A0B6D2001") {
    return;
  }
  self setclientomnvar(powershud_getslotomnvar(var_0, 3), -1);
  self setclientomnvar(powershud_getslotomnvar(var_0, 2), -1);
  self setclientomnvar(powershud_getslotomnvar(var_0, 0), 0);
  self setclientomnvar(powershud_getslotomnvar(var_0, 4), -1);
}

powershud_updatepowercharges(var_0, var_1) {
  self setclientomnvar(powershud_getslotomnvar(var_0, 0), int(var_1));
}

powershud_updatepowermaxcharges(var_0, var_1) {
  self setclientomnvar(powershud_getslotomnvar(var_0, 1), int(var_1));
}

powershud_updatepowerdrain(var_0, var_1) {
  self setclientomnvar(powershud_getslotomnvar(var_0, 4), var_1);
}

powershud_updatepowermeter(var_0, var_1) {
  self setclientomnvar(powershud_getslotomnvar(var_0, 2), int(var_1));
}

powershud_updatepowerdisabled(var_0, var_1) {
  self setclientomnvar(powershud_getslotomnvar(var_0, 5), var_1);
}

powershud_updatepoweroffcooldown(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(var_1, 1, 0);
  self setclientomnvar(powershud_getslotomnvar(var_0, 6), var_2);
}

powershud_updatepowerstate(var_0, var_1) {
  self setclientomnvar(powershud_getslotomnvar(var_0, 6), var_1);
}

powershud_beginpowerdrain(var_0) {
  powershud_updatepowerdrain(var_0, 1);
}

powershud_endpowerdrain(var_0) {
  powershud_updatepowerdrain(var_0, 0);
}

powershud_beginpowercooldown(var_0, var_1) {
  powershud_updatepowermeter(var_0, 0);

  if(isDefined(var_1) && var_1)
    powershud_updatepowerdisabled(var_0, 1);

  powershud_updatepowerstate(var_0, 1);
}

powershud_finishpowercooldown(var_0, var_1) {
  powershud_updatepowermeter(var_0, 1000);

  if(isDefined(var_1) && var_1)
    powershud_updatepowerdisabled(var_0, 0);

  if(var_0 == "_encstr_BA7F0830B3A7859B60B0")
    self playlocalsound("_encstr_AFC716FA83730FED506FD7FF5DF0F737FDF883A2EEAEB320");
  else
    self playlocalsound("_encstr_AFC716FA83730FED506FD7FF5DF0F737FDF883A2EEAEB320");

  powershud_updatepowerstate(var_0, 0);
}

powershud_updatepowercooldown(var_0, var_1) {
  powershud_updatepowermeter(var_0, 1000 * var_1);
}

powershud_updatepowerdrainprogress(var_0, var_1) {
  powershud_updatepowermeter(var_0, 1000 * var_1);
}

powershud_getslotomnvar(var_0, var_1) {
  if(var_0 == "_encstr_84DB09430E5B9A0B6D2001") {
    return;
  }
  return level.power_hud_info.omnvarnames[var_0][var_1];
}