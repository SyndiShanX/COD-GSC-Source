/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\utility\join_team_aggregator.gsc
***********************************************/

onplayerjointeam(var_0) {
  thread _id_1206F(var_0);

  if(isDefined(level.onjointeamcallbacks)) {
    foreach(var_2 in level.onjointeamcallbacks)
    self[[var_2]](var_0);
  }
}

registeronplayerjointeamcallback(var_0) {
  if(!isDefined(level.onjointeamcallbacks))
    level.onjointeamcallbacks = [];

  level.onjointeamcallbacks[level.onjointeamcallbacks.size] = var_0;
}

_id_1206F(var_0) {
  var_0 notify("_encstr_8A7A1CD8B5C10908607178D3C26CD8CBB7B1CA84877AE04DFFD00BC0F06B");

  if(var_0.sessionstate == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
    var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
    var_0 endon("_encstr_8A7A1CD8B5C10908607178D3C26CD8CBB7B1CA84877AE04DFFD00BC0F06B");

    while(var_0.sessionstate == "_encstr_AF8C0A1B6A1D6045925B4F7D")
      waitframe();
  }

  if(isDefined(level._id_12045)) {
    foreach(var_2 in level._id_12045)
    self[[var_2]](var_0);
  }
}

_id_12B2F(var_0) {
  if(!isDefined(level._id_12045))
    level._id_12045 = [];

  level._id_12045[level._id_12045.size] = var_0;
}