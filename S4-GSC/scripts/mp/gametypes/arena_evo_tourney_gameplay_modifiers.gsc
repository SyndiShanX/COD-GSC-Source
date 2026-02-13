/*************************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\arena_evo_tourney_gameplay_modifiers.gsc
*************************************************************************/

_id_81CF() {
  _id_C1DA("none", "arena", ::_id_4C17, ::_id_4C17);
  _id_C1DA("armor", "player", ::_id_6F25, ::_id_ED92);
  _id_C1DA("laststand", "player", ::_id_6F2E, ::_id_ED95);
  _id_C1DA("plus_lethal", "player", ::_id_6F2A, ::_id_ED94);
  _id_C1DA("pistolonly", "player", ::_id_D32D, ::_id_FA2C);
  _id_C1DA("knifeonly", "player", ::_id_D3E3, ::_id_FA42);
  _id_C1DA("uav", "arena", ::_id_D3FC, ::_id_FA43);
  _id_C1DA("gammononly", "player", ::_id_D222, ::_id_F9BE);
  _id_C1DA("doubledamage", "arena", ::_id_D2E9, ::_id_F9ED);
  _id_C1DA("inf_ammo", "player", ::_id_D149, ::_id_F9B5);
  _id_C1DA("cranked", "player", ::_id_D335, ::_id_FA2D);
  _id_C1DA("sniperonly", "player", ::_id_D3AD, ::_id_FA40);
  scripts\engine\utility::_id_0FDC("decor_barrels_gameplay_flammable_debris", "vfx/iw8/prop/scriptables/decor_barrels_gameplay_flammable_debris.vfx");
}

_id_C1DA(var_0, var_1, var_2, var_3) {
  if(!isDefined(level._id_433B)) {
    level._id_433B = [];
  }

  var_4 = tablelookuprownum("mp/modcardtable.csv", 1, var_0);
  var_5 = scripts\engine\utility::_id_EA52(_func_0222("mp/modcardtable.csv", 1, var_0, 1));
  var_6 = _func_0483("#x336339467cdad1bb7", var_5);

  if(getdvarint(_func_0483("#x33880edb0ab3f8758", var_0), 0) != 0) {
    setdvarifuninitialized(var_6, 0);
    return;
  }

  var_7 = int(_func_0222("mp/modcardtable.csv", 1, var_0, 3));

  if(getdvarint("#x37b1d8e3caad83b08", 1) && !scripts\engine\utility::is_equal(var_0, "none")) {
    var_7 = 0;
  }

  setdvarifuninitialized(var_6, var_7);
  var_8 = spawnStruct();
  var_8._id_7C8C = int(_func_0222("mp/modcardtable.csv", 1, var_0, 0));
  var_8._id_D570 = var_2;
  var_8._id_FA98 = var_3;
  var_8._id_19F0 = var_1;
  var_8._id_C189 = var_0;
  var_8._id_722F = _func_0222("mp/modcardtable.csv", 1, var_0, 4);
  var_9 = getdvarint(var_6);

  if(_id_9FC5(var_8)) {
    return;
  }
  for(var_10 = 0; var_10 < var_9; var_10++) {
    level._id_433B = scripts\engine\utility::array_add(level._id_433B, var_8);
  }

  if(!isDefined(level._id_1A6A)) {
    level._id_1A6A = [];
  }

  level._id_1A6A[var_0] = var_5;
}

_id_9FC5(var_0) {
  var_1 = getdvarint("#x3304cdf8d28ef2cac", -1);

  if(var_1 != -1) {
    if(!issubstr(var_0._id_722F, var_1)) {
      return 1;
    }
  }

  return 0;
}

_id_1AC4() {
  if(_id_433C()) {
    [[level._id_4168._id_D570]]();
  }
}

_id_1AC9() {
  if(_id_433C()) {
    [[level._id_4168._id_FA98]]();
  }
}

_id_1AC5() {
  var_0 = self;

  if(!_id_433C()) {
    [[level._id_4168._id_D570]](var_0);
  }
}

_id_1ACA() {
  var_0 = self;

  if(!_id_433C()) {
    [[level._id_4168._id_FA98]](var_0);
  }
}

_id_1AC8() {
  _id_1AC9();

  foreach(var_1 in level.players) {
    var_1 thread _id_1ACA();
  }
}

_id_433C() {
  if(!isDefined(level._id_4168)) {
    return 0;
  }

  if(!scripts\engine\utility::is_equal(level._id_4168._id_19F0, "arena")) {
    return 0;
  }

  return 1;
}

_id_0E9A() {
  var_0 = 0;

  if(!isDefined(level._id_BC05)) {
    level._id_BC05 = [];
  }

  if(getdvarint("#x384f8e66c64c6fb23", 0)) {
    var_0 = 1;
  }

  if(getDvar("#x3fd3e727b089f95ea", "") != "") {
    var_1 = getDvar("#x3fd3e727b089f95ea", "");

    if(var_1 == "0") {
      var_1 = "";
    }
  } else if(getDvar("#x3c016a8c0e42666e9", "") != "") {
    var_1 = getDvar("#x3c016a8c0e42666e9", "");
    setDvar("#x3c016a8c0e42666e9", "");
  } else if(!istrue(var_0))
    var_1 = "none";
  else {
    var_1 = undefined;
  }

  if(isDefined(var_1)) {
    var_2 = var_1;

    foreach(var_4 in level._id_433B) {
      if(scripts\engine\utility::is_equal(var_2, var_4._id_C189)) {
        level._id_4168 = var_4;
        break;
      }
    }
  } else {
    var_6 = [];

    foreach(var_8 in level._id_433B) {
      if(scripts\engine\utility::array_contains(level._id_BC05, var_8._id_C189)) {
        continue;
      }
      var_6[var_6.size] = var_8;
    }

    level._id_4168 = scripts\engine\utility::random(var_6);
  }

  if(!isDefined(level._id_4168)) {
    level._id_4168 = scripts\engine\utility::random(level._id_433B);
    level._id_BC05 = [];
  }

  level._id_BC05 = scripts\engine\utility::array_add(level._id_BC05, level._id_4168._id_C189);

  if(level._id_BC05.size >= 5) {
    level._id_BC05 = scripts\engine\utility::array_remove(level._id_BC05, level._id_BC05[0]);
  }

  foreach(var_11 in level.players) {
    var_11._id_DC94 = 1;

    if(scripts\engine\utility::is_equal(level._id_4168._id_19F0, "player")) {
      var_11 _id_D1A3(level._id_4168);
    }
  }
}

_id_D1A3(var_0) {
  var_1 = self;

  if(isDefined(var_1._id_4342)) {
    [[var_1._id_4342._id_FA98]](var_1);
  }

  var_1._id_4342 = var_0;
}

_id_6F2A(var_0) {
  if(!var_0 scripts\mp\utility\perk::_hasperk("specialty_extra_deadly")) {
    var_0 scripts\mp\utility\perk::_id_6FC2("specialty_extra_deadly");
  }
}

_id_ED94(var_0) {
  if(var_0 scripts\mp\utility\perk::_hasperk("specialty_extra_deadly")) {
    var_0 scripts\mp\utility\perk::removeperk("specialty_extra_deadly");
  }
}

_id_4C17() {}

_id_6F2E(var_0) {
  var_0 _id_F711("specialty_pistoldeath");
}

_id_ED95(var_0) {
  var_0 _id_F724("specialty_pistoldeath");
}

_id_F711(var_0) {
  var_1 = self;

  if(!var_1 scripts\mp\utility\perk::_hasperk(var_0)) {
    var_1 scripts\mp\utility\perk::_id_6FC2(var_0);
  }
}

_id_F724(var_0) {
  var_1 = self;

  if(var_1 scripts\mp\utility\perk::_hasperk(var_0)) {
    var_1 scripts\mp\utility\perk::removeperk(var_0);
  }
}

_id_6F25(var_0) {
  _id_D331(var_0);
}

_id_D331(var_0) {
  _id_07EA::_id_9453(var_0, 175, 0);
}

_id_ED92(var_0) {
  _id_07EA::_id_9455(var_0);
}

_id_D32D(var_0) {
  var_0 _id_D44D(["s4_pi_mike1911"]);
}

_id_FA2C(var_0) {
  var_0 _id_FA48();
}

_id_D3AD(var_0) {
  var_0 _id_D44D(["s4_mr_kalpha98"], undefined, ["snprscope_strong_kalpha98"]);
}

_id_FA40(var_0) {
  var_0 _id_FA48();
}

_id_D3E3(var_0) {
  var_0 _id_D44D(["s4_me_fists"], "equip_throwing_knife");
}

_id_FA42(var_0) {
  var_0 _id_FA48();
}

_id_D222(var_0) {
  var_0 _id_D44D(["s4_me_fists"], "equip_gammon_bomb");
}

_id_F9BE(var_0) {
  var_0 _id_FA48();
}

_id_D3FC() {
  level thread _id_CA16();
}

_id_FA43() {
  level notify("unset_uav_active");

  if(!getdvarint("#x38913d7054b641361", 1)) {
    foreach(var_1 in level.players) {
      var_1 setclientomnvar("ui_hide_minimap", 0);
    }
  }
}

_id_CA16(var_0) {
  level endon("unset_uav_active");

  if(isDefined(var_0)) {
    var_1 = scripts\mp\gametypes\arena_evo_tourney_util::_id_66A9(var_0);
    level notify("run_uav_" + var_0);
    level endon("run_uav_" + var_0);
    level endon("end_uav_" + var_0);
  } else
    var_1 = level.players;

  for(;;) {
    wait 1;

    foreach(var_3 in var_1) {
      if(!isDefined(var_3)) {
        continue;
      }
      var_3._id_0358 = _func_00E0();
      var_3._id_024A = 0;
      var_3.hasradar = 1;
      var_3.radarshowenemydirection = 0;
      var_3.radarmode = "normal_radar";
      var_3 setclientomnvar("ui_hide_minimap", 0);
      var_3 setclientomnvar("ui_show_hardcore_minimap", 1);
      _func_0253(var_3);
      var_3 _meth_85C0(2);
    }
  }
}

_id_D2E9() {
  level._id_1A9C = 1;
}

_id_F9ED() {
  level._id_1A9C = 0;
}

_id_D149(var_0) {
  var_0 thread _id_EBEE();
}

_id_F9B5(var_0) {
  var_0 notify("stop_sustain_all_ammo");
}

_id_EBEE() {
  self endon("disconnect");
  self endon("stop_sustain_all_ammo");
  level endon("game_ended");

  for(;;) {
    var_0 = self getcurrentweapon();
    var_1 = getcompleteweaponname(var_0);
    var_2 = 0;

    if(isDefined(var_1) && _func_0121(var_1)) {
      var_2 = weaponclipsize(var_1);
    }

    if(var_2 > 0) {
      self setweaponammoclip(var_0, var_2);
    }

    waitframe();
    waitframe();
  }
}

_id_D335(var_0) {
  var_0._id_1A63 = 1;
  var_0 thread _id_D336();
}

_id_D336() {
  self endon("death");
  self endon("disconnect");
  self endon("unset_player_cranked");
  self notify("set_player_cranked_internal");
  self endon("set_player_cranked_internal");
  self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
  self setclientomnvar("ui_cranked_bomb_timer_final_seconds", 0);

  if(scripts\mp\gametypes\arena_evo_tourney_util::_id_8602(self.pers["team"])) {
    return;
  }
  var_0 = 5;
  var_1 = 15;
  var_2 = var_1 * 1000 + gettime();
  self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", var_2);
  self setclientomnvar("ui_cranked_bomb_timer_final_seconds", 0);
  childthread _id_10732(var_0, var_1);
}

_id_10732(var_0, var_1) {
  wait(var_1 - var_0);
  self setclientomnvar("ui_cranked_bomb_timer_final_seconds", 1);
  wait(var_0);
  var_2 = magicgrenademanual("s4_frag_usa_mk2_mp", self.origin + (0, 0, 32), (0, 0, 0));
  var_2 detonate();

  foreach(var_4 in scripts\engine\utility::_id_6369(self.origin + (0, 0, 64), level.players, undefined, undefined, 300)) {
    if(scripts\engine\utility::is_equal(var_4, self)) {
      continue;
    }
    if(!_func_0202(self.origin + (0, 0, 64), var_4 getEye(), 0, self)) {
      continue;
    }
    var_4 thread scripts\mp\weapons::_id_523C(1);
    var_4 dodamage(var_4.maxhealth + 1, self.origin + (0, 0, 64), self, self, "MOD_BURNED", "s4_frag_usa_mk2_mp");
  }

  self dodamage(self.maxhealth + 1, self.origin + (0, 0, 64), self, self, "MOD_BURNED", "s4_frag_usa_mk2_mp");
}

_id_404B(var_0, var_1) {
  var_2 = newclienthudelem(self);
  var_2.elemtype = "timer";
  var_2.font = var_0;
  var_2.fontscale = var_1;
  var_2._id_22B8 = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2.hidden = 0;
  return var_2;
}

_id_FA2D(var_0) {
  self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
  self setclientomnvar("ui_cranked_bomb_timer_final_seconds", 0);
  var_0 notify("unset_player_cranked");
  var_0._id_1A63 = 0;
}

_id_FA48() {
  var_0 = self;
  var_0 notify("unset_weapons_mod_override");
  var_0._id_1A72 = undefined;
  var_0._id_1A73 = undefined;
}

_id_D44D(var_0, var_1, var_2) {}

_id_EBEF() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0 endon("unset_weapons_mod_override");
  var_1 = 3;

  while(isDefined(var_0._id_1A72)) {
    if(var_0 _meth_8109(var_0._id_1A73) < var_1) {
      var_0 setweaponammoclip(var_0._id_1A73, var_1);
    }

    wait 0.125;
  }
}