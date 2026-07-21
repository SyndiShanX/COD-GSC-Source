/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\killstreaks\nuke.gsc
***********************************************/

terminal_pusher_approach_array(var_0) {
  var_0.unlockableindex = 1;
  thread _id_138DA(var_0);
}

_id_138DA(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\engine\utility::_id_143A5("_encstr_95350FCADC197D19932CEC1239CAB03A0D", "_encstr_AD75063D571AE108");

  if(isDefined(var_0))
    var_0.unlockableindex = undefined;
}

_id_13638() {
  var_0 = spawnStruct();
  var_0._id_11E62 = [];
  var_0.spawn_little_bird_mg_at_location = [];
  var_0.flares = "_encstr_B40101";
  return var_0;
}

_id_13146(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    if(usedpropsindex(var_4))
      var_0 = scripts\engine\utility::array_remove(var_0, var_4);
  }

  if(var_0.size == 0) {
    return;
  }
  thread flareready(var_0, var_1, var_2);
}

_id_13147() {
  var_0 = self getcorpseentity();

  if(isDefined(var_0))
    var_0 setscriptablepartstate("_encstr_A9B10826EAC9374BCDB3", "_encstr_86390885FB5A76780D42", 0);
}

_id_138DB() {
  self notify("_encstr_880919D6739A898E04935870FF5643E5335F47DDCC807330E9EF70");
  self.mine_caves_ambusher = undefined;
}

flareready(var_0, var_1, var_2) {
  self notify("_encstr_84C510D03D834A23301DC0B87CDFE79BF3E3");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_84C510D03D834A23301DC0B87CDFE79BF3E3");
  self endon("_encstr_880919D6739A898E04935870FF5643E5335F47DDCC807330E9EF70");
  var_0 = scripts\engine\utility::array_remove_duplicates(var_0);

  foreach(var_4 in var_0) {
    if(isDefined(self.mine_caves_ambusher.spawn_little_bird_mg_at_location[var_4])) {
      self.mine_caves_ambusher.spawn_little_bird_mg_at_location[var_4] = self.mine_caves_ambusher.spawn_little_bird_mg_at_location[var_4] + 0.5;
      self.mine_caves_ambusher.spawn_little_bird_mg_at_location[var_4] = min(self.mine_caves_ambusher.spawn_little_bird_mg_at_location[var_4], 4.0);
      continue;
    }

    self.mine_caves_ambusher.spawn_little_bird_mg_at_location[var_4] = 0.5;
  }

  childthread _id_13130(var_1, var_2);
  _id_13131();

  for(;;) {
    wait 0.2;

    if(!isalive(self) || self.mine_caves_ambusher.spawn_little_bird_mg_at_location.size == 0)
      _id_138DB();

    var_6 = 0;

    foreach(var_9, var_8 in self.mine_caves_ambusher.spawn_little_bird_mg_at_location) {
      if(isDefined(var_1))
        self.mine_caves_ambusher.spawn_little_bird_mg_at_location[var_9] = self.mine_caves_ambusher.spawn_little_bird_mg_at_location[var_9] - 0.2;
      else
        self.mine_caves_ambusher.spawn_little_bird_mg_at_location[var_9] = 0;

      if(self.mine_caves_ambusher.spawn_little_bird_mg_at_location[var_9] <= 0) {
        self.mine_caves_ambusher.spawn_little_bird_mg_at_location = scripts\engine\utility::array_remove_key(self.mine_caves_ambusher.spawn_little_bird_mg_at_location, var_9);
        var_6 = 1;
      }
    }

    if(var_6)
      _id_13131();
  }
}

_id_13130(var_0, var_1) {
  var_2 = getcompleteweaponname("_encstr_AB45111102C198104A7F7D255FC2E5A8A75D1B");
  var_2._id_121D9 = var_1;
  var_3 = 1.0;

  if(level.gametype == "_encstr_B607038AAB" && var_1.classname == "_encstr_A1100738A33A638123")
    var_3 = 0.75;

  for(;;) {
    wait 0.25;
    var_4 = scripts\engine\math::normalize_value(5, 1, self.mine_caves_ambusher.spawn_little_bird_mg_at_location.size);
    var_5 = scripts\engine\math::factor_value(40, 54, var_4);
    var_6 = int(var_5 * 0.25) * var_3;
    var_6 = floor(var_6);

    if(var_1 hasattachment("_encstr_ADE110F9026778319CAE7F7BC687D837B3FB", 1) && weaponclass(var_1) != "_encstr_A1100738A33A638123") {
      var_6 = int(level._id_12E38 * level._id_12E39);

      if(weaponisboltaction(var_1) && issubstr(var_1.basename, "_encstr_AB8807DC68EBAD27EB"))
        var_6 = var_6 - 1;
    }

    if(isDefined(var_0))
      self dodamage(var_6, self.origin, var_0, var_0, "_encstr_9B0D099AD3887D91252954", var_2);
  }
}

_id_13131() {
  var_0 = "_encstr_B40101";
  var_1 = [];
  var_1["_encstr_877D06BB570AB0D0"] = 0;
  var_1["_encstr_ABAD054DE5976B"] = 0;

  foreach(var_5, var_3 in self.mine_caves_ambusher.spawn_little_bird_mg_at_location) {
    var_4 = _id_11AE5(var_5);

    if(isDefined(var_4)) {
      var_1[var_4] = var_1[var_4] + 1;
      continue;
    }
  }

  if(var_1["_encstr_877D06BB570AB0D0"] > 2)
    var_0 = "_encstr_92FE091BE01A6B7FB18C1E";
  else if(var_1["_encstr_877D06BB570AB0D0"] > 0)
    var_0 = "_encstr_B4FE09939F060B57C943F1";

  if(var_1["_encstr_ABAD054DE5976B"] > 2)
    var_0 = var_0 + "_encstr_938C07DD69F8B34981";
  else if(var_1["_encstr_ABAD054DE5976B"] > 0)
    var_0 = var_0 + "_encstr_A68C07D859B36EBE6E";

  if(var_0 == "_encstr_B40101")
    var_0 = "_encstr_A7A408B9CA5D1D4E2C63";

  if(var_0 != self.mine_caves_ambusher.flares) {
    if(var_0 == "_encstr_A7A408B9CA5D1D4E2C63")
      scripts\mp\weapons::disableburnfx(1, self.mine_caves_ambusher.flares);
    else
      scripts\mp\weapons::enableburnfx(1, var_0);

    self.mine_caves_ambusher.flares = var_0;
  }
}

_id_11AE5(var_0) {
  switch (var_0) {
    case "_encstr_A6CC076A05751852B3":
      return "_encstr_877D06BB570AB0D0";
    case "_encstr_81CC0586952C91":
      return "_encstr_877D06BB570AB0D0";
    case "_encstr_9ABA05E87F4B70":
      return "_encstr_877D06BB570AB0D0";
    case "_encstr_952B0C65857BBFB80F9FC0B8A75A":
      return "_encstr_877D06BB570AB0D0";
    case "_encstr_9B7A0CF35815C3971660B7CF306B":
      return "_encstr_877D06BB570AB0D0";
    case "_encstr_8D9A10260457F8118F7ED3639F75A0BB9BDB":
      return "_encstr_877D06BB570AB0D0";
    case "_encstr_A9C30F63CA998ED716E4D67D5D1C0ECAE4":
      return "_encstr_877D06BB570AB0D0";
    case "_encstr_970110C3DBB4827401D972BD36B0A7CB1D45":
      return "_encstr_877D06BB570AB0D0";
    case "_encstr_8B970F1B56991DD758E4D6EB63ED77B239":
      return "_encstr_877D06BB570AB0D0";
    case "_encstr_A1BD0B9C96D9D0A3F51A169B19":
      return "_encstr_877D06BB570AB0D0";
    case "_encstr_BDB30AC6CA66A3FAA158CD23":
      return "_encstr_877D06BB570AB0D0";
    case "_encstr_8B1D10834BA13813E7693FB7D86B8BE80920":
      return "_encstr_ABAD054DE5976B";
    case "_encstr_BDF80F4495E9F3C9C1387AF15011FA4F83":
      return "_encstr_ABAD054DE5976B";
    case "_encstr_A91A1025A967F88DCF6A0971613BC8C83F2A":
      return "_encstr_ABAD054DE5976B";
    case "_encstr_BACF0FC17D8FB0A0BB52111E2A5F6CE022":
      return "_encstr_ABAD054DE5976B";
    case "_encstr_8ECF0B734B47E3AB67AD07909B":
      return "_encstr_ABAD054DE5976B";
    case "_encstr_95E80A8D59CCD1F533DBED3A":
      return "_encstr_ABAD054DE5976B";
  }
}

unlockables(var_0) {
  var_1 = getweaponammopoolname(var_0);
  var_2 = var_0 hasattachment("_encstr_ADE110F9026778319CAE7F7BC687D837B3FB", 1);
  return var_1 == "_encstr_86AB0F5D54A082E9275E059A6AE9AF8821" || var_2;
}

usedpropsindex(var_0) {
  if(var_0 == "_encstr_A32D07CFD14BAA94D0")
    return 1;
  else
    return 0;
}