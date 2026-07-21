/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: common\screens.gsc
***********************************************/

init() {
  setdvarifuninitialized("_encstr_85930E9F354DDBF77E9B2F639811A6E3", 0);
  waitframe();
  level.screens = spawnStruct();
  level.screens.screens = scripts\engine\utility::getStructArray("_encstr_B2A10F336A93E578D53BFFDF49FAB8BDB7", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(!isDefined(level.screens.screens) || level.screens.screens.size <= 0) {
    return;
  }
  level.screens.screens_flagged = [];
  level thread screens_debug_counter();

  foreach(var_1 in level.screens.screens) {
    var_1.state = "_encstr_BA19049F4B2D";
    var_1 group_by_flag();
    var_1 thread watch_scriptable();
  }

  if(isDefined(level.screens_think_func))
    scripts\engine\utility::array_thread(level.screens.screens, level.screens_think_func);
  else
    scripts\engine\utility::array_thread(level.screens.screens, ::screens_think);
}

group_by_flag() {
  if(isDefined(self.script_flag)) {
    if(!isDefined(level.screens.screens_flagged[self.script_flag])) {
      level.screens.screens_flagged[self.script_flag] = [];
      level thread screens_wait_for_flag(self.script_flag);
    }

    level.screens.screens_flagged[self.script_flag] = scripts\engine\utility::array_add(level.screens.screens_flagged[self.script_flag], self);
    level.screens.screens = scripts\engine\utility::array_remove(level.screens.screens, self);
  }
}

screens_think() {
  if(istrue(level.screens_off_test)) {
    return;
  }
  self endon("_encstr_AD75063D571AE108");
  screens_create();
  var_0 = get_state();

  if(isDefined(var_0))
    do_state(var_0);
  else
    screens_fixed();
}

do_state(var_0) {
  self endon("_encstr_AD75063D571AE108");

  if(issubstr(var_0, "_encstr_852907B9D8C959B2CD")) {
    childthread screens_fixed(var_0);
    return;
  }

  switch (var_0) {
    case "_encstr_887F06664BE19519":
      if(debug()) {}

      childthread screens_fixed();
      break;
    case "_encstr_AB79054E1108E3":
      if(debug()) {}

      childthread screens_flip();
      break;
    case "_encstr_BD0108BEE1F8135215E0":
      if(debug()) {}

      childthread screens_fliprnd();
      break;
    case "_encstr_AC6D0770ABB619D877":
      if(debug()) {}

      childthread screens_static();
      break;
    case "_encstr_8419044EB232":
      if(debug()) {}

      childthread screens_red();
      break;
    case "_encstr_A69B0539E2CBDA":
      if(debug()) {}

      childthread screens_bink();
      break;
    case "_encstr_ABBE0AB0B1564E4799C62D1C":
      if(debug()) {}

      childthread screens_alertflip();
      break;
  }
}

screens_create() {
  self.screen_model = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  self.screen_model.angles = self.angles;
  self.screen_model setModel(self.script_modelname);
  self.screen_model hideallparts();
  get_screens();
}

screens_damage_think() {
  self.screen_model setCanDamage(1);
  self.screen_model waittill("_encstr_B2BE0788BAF573592F");
  self notify("_encstr_B4750D67F4A5F8D8BF5A2BF102F386");
  self.screen_model delete();
}

screens_delete() {
  self.state = "_encstr_BA19049F4B2D";
  self notify("_encstr_B4750D67F4A5F8D8BF5A2BF102F386");

  if(isDefined(self.screen_model))
    self.screen_model delete();

  delete_screens();
}

screens_fixed(var_0) {
  if(!isDefined(self.screens_fixed) && !isDefined(var_0)) {
    return;
  }
  self endon("_encstr_B4750D67F4A5F8D8BF5A2BF102F386");
  self endon("_encstr_A53213F3601FA2C7DB1EDAC525404FA1A510CB6A08");

  if(isDefined(var_0))
    var_1 = var_0;
  else
    var_1 = "_encstr_934E0D1ECB63017B2D49F080538721" + (randomint(self.screens_fixed.size) + 1);

  if(debug()) {
    var_2 = var_1;

    if(isDefined(var_0))
      var_2 = "_encstr_8D3F0A88A36ADD7B59BB081A" + var_2;
  }

  self.state = "_encstr_AB0703DBB9";
  self.screen_model hideallparts();
  self.screen_model showpart(var_1);

  if(isDefined(self.screens_widget) && !isDefined(var_0)) {
    if(randomint(3) == 0) {
      var_1 = "_encstr_A9580EDC1BC9AC5973F5DD9691CE59A3" + (randomint(self.screens_widget.size) + 1);
      self.screen_model showpart(var_1);
    }
  }
}

screens_static() {
  if(!isDefined(self.screens_static)) {
    return;
  }
  self endon("_encstr_B4750D67F4A5F8D8BF5A2BF102F386");
  self endon("_encstr_BE46142375A08B91A720137A08C5D27F9BDDB9BC03C9");
  var_0 = "_encstr_9BC60E9F3708ADA0A55E1045620C1B57" + (randomint(self.screens_static.size) + 1);

  if(debug()) {}

  self.state = "_encstr_AB0703DBB9";
  self.screen_model hideallparts();
  self.screen_model showpart(var_0);
}

screens_flip() {
  if(!isDefined(self.screens_flip)) {
    return;
  }
  self endon("_encstr_B4750D67F4A5F8D8BF5A2BF102F386");
  self endon("_encstr_994D121B88F73A5F73A6626D4D3827091DA022A3");
  var_0 = randomint(self.screens_flip.size) + 1;

  for(;;) {
    for(var_1 = var_0; var_1 < self.screens_flip.size + 1; var_1++) {
      var_2 = 3;
      var_3 = "_encstr_A2E20C7B3835203816F94F3AF478" + var_1;

      if(debug()) {}

      self.state = "_encstr_AB0703DBB9";
      self.screen_model hideallparts();
      self.screen_model showpart(var_3);
      wait(var_2);
    }

    var_0 = 1;
  }
}

screens_fliprnd() {
  if(!isDefined(self.screens_fliprnd)) {
    return;
  }
  self endon("_encstr_B4750D67F4A5F8D8BF5A2BF102F386");
  self endon("_encstr_B609159BCB38AA49803645AF6FD5AF5F8D4AC4EFCA531F");
  var_0 = randomint(self.screens_fliprnd.size) + 1;

  for(;;) {
    for(var_1 = var_0; var_1 < self.screens_fliprnd.size + 1; var_1++) {
      var_2 = randomfloatrange(1.5, 4);
      var_3 = "_encstr_A3830FE66C4E2B599BAF998D5A1C939B19" + var_1;

      if(debug()) {}

      self.state = "_encstr_AB0703DBB9";
      self.screen_model hideallparts();
      self.screen_model showpart(var_3);
      wait(var_2);
    }

    var_0 = 1;
  }
}

screens_bink() {
  if(!isDefined(self.screens_bink)) {
    return;
  }
  self endon("_encstr_B4750D67F4A5F8D8BF5A2BF102F386");
  self endon("_encstr_B87012D744F5A888EF2A5BA1524356194EA1657F");
  var_0 = "_encstr_93BF0C7B2176C70F28DF0A19A5D8" + (randomint(self.screens_bink.size) + 1);

  if(debug()) {}

  self.state = "_encstr_AB0703DBB9";
  self.screen_model hideallparts();
  self.screen_model showpart(var_0);
}

screens_red() {
  if(!isDefined(self.screens_red)) {
    return;
  }
  self endon("_encstr_B4750D67F4A5F8D8BF5A2BF102F386");
  self endon("_encstr_A31611DB7DA813318E9FD219A88AF366269289");
  self.reversed = 0;
  var_0 = randomint(self.screens_red.size) + 1;

  for(;;) {
    for(var_1 = 1; var_1 < self.screens_red.size + 1; var_1++) {
      var_2 = randomfloatrange(0.25, 0.5);

      if(randomint(6) == 0 && !self.reversed) {
        self.reversed = 1;

        if(var_1 <= 2)
          var_1 = var_1 + self.screens_red.size;

        var_1 = var_1 - 2;
        var_2 = 0.1;
      } else
        self.reversed = 0;

      var_3 = "_encstr_832C0B9B8FD3C86F358966033D" + var_1;

      if(debug()) {}

      self.state = "_encstr_AB0703DBB9";
      self.screen_model hideallparts();
      self.screen_model showpart(var_3);
      wait(var_2);
    }

    var_0 = 1;
  }
}

screens_alertflip() {
  if(!isDefined(self.screens_alertflip)) {
    return;
  }
  self endon("_encstr_B4750D67F4A5F8D8BF5A2BF102F386");
  self endon("_encstr_93EB17670840C0415F0E5A97653DDBA72970B7FBE09904EA71");
  self.screen_model hideallparts();

  for(;;) {
    var_0 = randomfloatrange(0.5, 1);

    if(debug()) {}

    self.state = "_encstr_AB0703DBB9";
    self.screen_model hidepart("_encstr_8AC7120BBFE82717B066825A09966B5FB0338031");
    self.screen_model showpart("_encstr_84C712D3F805874F1860A9AC05E3730F51306B7F");
    wait(var_0);
    self.screen_model showpart("_encstr_8AC7120BBFE82717B066825A09966B5FB0338031");
    self.screen_model hidepart("_encstr_84C712D3F805874F1860A9AC05E3730F51306B7F");
    wait(var_0);
  }
}

get_screens() {
  var_0 = getnumparts(self.screen_model.model);

  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = getpartname(self.screen_model.model, var_1);

    if(issubstr(var_2, "_encstr_84F10853C07BDD7AD0B9")) {
      if(issubstr(var_2, "_encstr_832C0B9B8FD3C86F358966033D")) {
        if(!isDefined(self.screens_red))
          self.screens_red = [];

        self.screens_red = scripts\engine\utility::array_add(self.screens_red, var_2);
        continue;
      }

      if(issubstr(var_2, "_encstr_934E0D1ECB63017B2D49F080538721")) {
        if(!isDefined(self.screens_fixed))
          self.screens_fixed = [];

        self.screens_fixed = scripts\engine\utility::array_add(self.screens_fixed, var_2);
        continue;
      }

      if(issubstr(var_2, "_encstr_9BC60E9F3708ADA0A55E1045620C1B57")) {
        if(!isDefined(self.screens_static))
          self.screens_static = [];

        self.screens_static = scripts\engine\utility::array_add(self.screens_static, var_2);
        continue;
      }

      if(issubstr(var_2, "_encstr_A3830FE66C4E2B599BAF998D5A1C939B19")) {
        if(!isDefined(self.screens_fliprnd))
          self.screens_fliprnd = [];

        self.screens_fliprnd = scripts\engine\utility::array_add(self.screens_fliprnd, var_2);
        continue;
      }

      if(issubstr(var_2, "_encstr_A2E20C7B3835203816F94F3AF478")) {
        if(!isDefined(self.screens_flip))
          self.screens_flip = [];

        self.screens_flip = scripts\engine\utility::array_add(self.screens_flip, var_2);
        continue;
      }

      if(issubstr(var_2, "_encstr_93BF0C7B2176C70F28DF0A19A5D8")) {
        if(!isDefined(self.screens_bink))
          self.screens_bink = [];

        self.screens_bink = scripts\engine\utility::array_add(self.screens_bink, var_2);
        continue;
      }

      if(issubstr(var_2, "_encstr_B2B2110E5120C7FD70998734EF3D8331A09398")) {
        if(!isDefined(self.screens_alertflip))
          self.screens_alertflip = [];

        self.screens_alertflip = scripts\engine\utility::array_add(self.screens_alertflip, var_2);
        continue;
      }

      if(issubstr(var_2, "_encstr_A9580EDC1BC9AC5973F5DD9691CE59A3")) {
        if(!isDefined(self.screens_widget))
          self.screens_widget = [];

        self.screens_widget = scripts\engine\utility::array_add(self.screens_widget, var_2);
      }
    }
  }
}

delete_screens() {
  if(isDefined(self.screens_red))
    self.screens_red = [];

  if(isDefined(self.screens_fixed))
    self.screens_fixed = [];

  if(isDefined(self.screens_static))
    self.screens_static = [];

  if(isDefined(self.screens_flip))
    self.screens_flip = [];

  if(isDefined(self.screens_fliprnd))
    self.screens_fliprnd = [];

  if(isDefined(self.screens_bink))
    self.screens_bink = [];

  if(isDefined(self.screens_alertflip))
    self.screens_alertflip = [];

  if(isDefined(self.screens_widget))
    self.screens_widget = [];
}

get_state() {
  if(isDefined(self.script_parameters)) {
    var_0 = strtok(self.script_parameters, "_encstr_974C0246");

    foreach(var_2 in var_0) {
      if(issubstr(var_2, "_encstr_852907B9D8C959B2CD"))
        return var_2;
    }

    foreach(var_2 in var_0) {
      if(issubstr(var_2, "_encstr_A1AD062E09D98338")) {
        switch (var_2) {
          case "_encstr_A5AF0C8ADB58241AE88D9FD3E32D":
            return "_encstr_887F06664BE19519";
          case "_encstr_B86F0BD7447688955F7A982003":
            return "_encstr_AB79054E1108E3";
          case "_encstr_81E10E1389687BFFC0B9BA1283AE1BB7":
            return "_encstr_BD0108BEE1F8135215E0";
          case "_encstr_BA870D3EACC7E58759B36BC30B4A23":
            return "_encstr_AC6D0770ABB619D877";
          case "_encstr_8AF50A9B8E2CE895AF4EB223":
            return "_encstr_8419044EB232";
          case "_encstr_A94B0B37A3583A95FA31D2E6AD":
            return "_encstr_A69B0539E2CBDA";
          case "_encstr_A9D410BF03C98C60D17E7DEB63EBE4618970":
            return "_encstr_ABBE0AB0B1564E4799C62D1C";
          default:
        }
      }
    }
  }

  return undefined;
}

watch_scriptable() {
  if(!isDefined(self.target)) {
    return;
  }
  var_0 = getscriptablearray(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_0[0])) {
    if(debug()) {}

    var_0[0] waittill("_encstr_AD75063D571AE108");
    screens_delete();
    var_1 = getarraykeys(level.screens.screens_flagged);

    foreach(var_3 in var_1) {
      foreach(var_5 in level.screens.screens_flagged[var_3]) {
        if(self == var_5) {
          level.screens.screens_flagged[var_3] = scripts\engine\utility::array_remove(level.screens.screens_flagged[var_3], self);
          return;
        }
      }
    }
  }
}

debug() {
  if(getdvarint("_encstr_85930E9F354DDBF77E9B2F639811A6E3") > 0)
    return 1;

  return 0;
}

set_screens_to_red() {}

screens_debug_counter() {
  if(!debug()) {
    return;
  }
  for(;;) {
    var_0 = 0;
    var_1 = 0;
    var_2 = getarraykeys(level.screens.screens_flagged);

    foreach(var_4 in var_2) {
      var_1 = var_1 + level.screens.screens_flagged[var_4].size;

      foreach(var_6 in level.screens.screens_flagged[var_4]) {
        if(isDefined(var_6.state) && var_6.state == "_encstr_AB0703DBB9")
          var_0 = var_0 + 1;
      }
    }

    foreach(var_6 in level.screens.screens) {
      if(isDefined(var_6.state) && var_6.state == "_encstr_AB0703DBB9")
        var_0 = var_0 + 1;
    }

    var_11 = level.screens.screens.size + var_1;
    waitframe();
  }
}

screens_wait_for_flag(var_0) {
  if(!scripts\engine\utility::flag_exist(var_0))
    scripts\engine\utility::flag_init(var_0);

  for(;;) {
    scripts\engine\utility::flag_wait(var_0);

    if(debug())
      iprintln(level.screens.screens_flagged[var_0].size + "_encstr_A3DF1D81A6A5B0042FFA2999A30746583F36AF7949CEA05B03D223393A8A57" + var_0);

    if(!istrue(level.screens_off_test)) {
      if(isDefined(level.screens_think_func))
        scripts\engine\utility::array_thread(level.screens.screens_flagged[var_0], level.screens_think_func);
      else
        scripts\engine\utility::array_thread(level.screens.screens_flagged[var_0], ::screens_think);
    }

    scripts\engine\utility::flag_waitopen(var_0);

    if(debug())
      iprintln(level.screens.screens_flagged[var_0].size + "_encstr_B2E71F2AB34409EF6A4F3D1722C20D71B57B28A203E5419F03742C4FFB9A79D258" + var_0);

    if(!istrue(level.screens_off_test))
      scripts\engine\utility::array_thread(level.screens.screens_flagged[var_0], ::screens_delete);
  }
}