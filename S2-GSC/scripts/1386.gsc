/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1386.gsc
**************************************/

init() {
  if(isDefined(level._id_6F5C)) {
    return;
  }
  level._id_6F5C = [];
  _id_532B("fastreload", 3000, "reload_speed_buy", &"ZOMBIES_BUY_PERK_SPEEDY_RELOAD", ::_id_47B5, ::_id_95F1, "ui_zm_fastreload", undefined, undefined, &"ZOMBIES_HINT_PERK_SPEEDY_RELOAD", 1);
  _id_532B("punchperk", 2000, "punch_perk_buy", &"ZOMBIES_BUY_PERK_PUNCH", ::_id_47B0, ::_id_95EF, "ui_zm_punchperk", undefined, undefined, &"ZOMBIES_HINT_PERK_PUNCH", 2);
  _id_532B("runperk", 2000, "run_perk_buy", &"ZOMBIES_BUY_PERK_RUN", ::_id_47B8, ::_id_95F3, "ui_zm_runperk", undefined, undefined, &"ZOMBIES_HINT_PERK_RUN", 3);
  _id_532B("quickrevive", 1500, "quickrevive_buy", &"ZOMBIES_BUY_PERK_REVIVE", ::_id_47B1, ::_id_95F0, "ui_zm_quickrevive", 3, 500, &"ZOMBIES_HINT_PERK_REVIVE", 4);
  _id_532B("electriccherry", 2000, "electriccherry_buy", &"ZOMBIES_BUY_PERK_ELECTRIC_CHERRY", ::_id_4785, ::_id_95D5, "ui_zm_electriccherry", undefined, undefined, &"ZOMBIES_HINT_PERK_ELECTRIC_CHERRY", 5);
  _id_532B("doubletap", 2000, "doubletap_buy", &"ZOMBIES_BUY_PERK_DOUBLE_TAP", ::_id_4784, ::_id_95D3, "ui_zm_doubletap", undefined, undefined, &"ZOMBIES_HINT_PERK_DOUBLE_TAP", 6);
  _id_532B("armor", 500, "armor_buy", &"ZOMBIES_BUY_ARMOR", ::_id_4775, ::_id_95D2, undefined, undefined, undefined, &"ZOMBIES_HINT_ARMOR");
  _id_532B("perk_random", 2000, "random_perk_buy", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  _id_532B("perk_all", 0, "all_perk_buy", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  _id_532C("fastreload");
  _id_532C("punchperk");
  _id_532C("runperk");
  _id_532C("quickrevive");
  _id_532C("electriccherry");
  _id_532C("doubletap");
  _id_5295("armor");
  _id_532C("perk_random");
  _id_532C("perk_all");
  thread _id_5F1E();
  level._effect["care_package_allies_beacon"] = loadfx("vfx/lights/usa_carepackage_beacon");
  level._effect["zmb_elec_cherry_zombie"] = loadfx("vfx/gameplay/mp/zombie/zmb_elec_cherry_zombie");
  level._effect["zmb_elec_cherry_player"] = loadfx("vfx/gameplay/mp/zombie/zmb_elec_cherry_player");
  level._effect["zmb_elec_cherry_wv"] = loadfx("vfx/gameplay/mp/zombie/zmb_elec_cherry_wv");
  level._effect["zmb_pm_armor_use"] = loadfx("vfx/zombie/perk_machines/zmb_pm_armor_use");
  level._effect["zmb_hand_blood"] = loadfx("vfx/zombie/perk_machines/zmb_hand_blood");
  level._effect["zmb_pm_random_use"] = loadfx("vfx/zombie/perk_machines/zmb_pm_random_use");
  level thread maps\mp\_utility::_id_6F74(::restore_tactical_usage_on_spawn);
}

restore_tactical_usage_on_spawn() {
  self endon("disconnect");

  for(;;) {
    self waittill("spectator_revive");

    if(!isDefined(self.zmb_plr_tactical)) {
      continue;
    }
    if(_id_0547::_id_5866(self.zmb_plr_tactical)) {
      self setoffhandsecondaryclass(self.zmb_plr_tactical);

      if(!self hasweapon(self.zmb_plr_tactical))
        _id_0586::_id_078C(self.zmb_plr_tactical);

      var_0 = 0;

      if(isDefined(level.persistent_ammo_tacticals) && common_scripts\utility::_id_0F79(level.persistent_ammo_tacticals, self.zmb_plr_tactical))
        var_0 = 1;

      self setweaponammoclip(self.zmb_plr_tactical, var_0);
    }
  }
}

_id_420E(var_0) {
  if(!common_scripts\utility::_id_562E(level._id_5F5A)) {
    if(var_0)
      return 5;
    else
      return 4;
  } else
    return 6;
}

_id_4506() {
  return 200;
}

onplayerconnect() {
  self._id_6F66 = [];
  self._id_6F67 = [];
  self._id_0F60 = 0;
  var_0 = _id_420E(_id_0547::_id_4BA7("specialty_class_hoarder_zm"));
  self setclientomnvar("zm_blitz_items_limit", var_0);
}

_id_86E9(var_0) {
  level._id_5F5A = var_0;

  foreach(var_2 in level.players) {
    var_3 = _id_420E(_id_0547::_id_4BA7("specialty_class_hoarder_zm"));
    var_2 setclientomnvar("zm_blitz_items_limit", var_3);
  }
}

_id_532B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = spawnStruct();
  var_11.name = var_0;
  var_11._id_64F7 = var_1;
  var_11._id_267B = var_1;
  var_11.targetname = var_2;
  var_11._id_868B = var_4;
  var_11._id_A067 = var_5;
  var_11._id_537C = 0;
  var_11._id_6078 = -1;
  var_11._id_8F63 = undefined;
  var_11._id_6731 = 0;
  var_11._id_8C82 = 0;
  var_11._id_6A6E = var_6;
  var_11.perkid = var_10;

  if(isDefined(var_7) && var_7 > -1) {
    var_11._id_6078 = var_7;
    var_11._id_6731 = 0;
  }

  if(isDefined(var_8)) {
    var_11._id_8F63 = var_8;
    var_11._id_267B = var_8;
  }

  level._id_6F5C[var_0] = var_11;
}

_id_5295(var_0) {
  var_1 = level._id_6F5C[var_0];
  var_2 = common_scripts\utility::_id_46B7(var_1.targetname, "targetname");

  foreach(var_4 in var_2) {
    var_1._id_537C = 1;
    var_4._id_9DC2 = [];
    var_5 = getEntArray(var_4.target, "targetname");

    foreach(var_7 in var_5) {
      var_8 = var_7._id_0165;

      if(!isDefined(var_8)) {
        continue;
      }
      switch (var_8) {
        case "armor_buy_trig":
          var_4._id_9DC2[var_4._id_9DC2.size] = var_7;
          break;
        case "armor_model":
          var_4._id_0F5F = var_7;
          break;
      }
    }

    foreach(var_11 in var_4._id_9DC2) {
      var_11 _meth_8660(1, var_4._id_0F5F.origin + (0, 0, 48));
      var_11._id_8C82 = 1;
      var_11._id_6F63 = var_0;
      _id_0547::_id_8A4F(var_11, ::_id_0F66);
      var_11 thread _id_6F61(var_0, var_4._id_0F5F);
    }
  }
}

_id_532C(var_0, var_1) {
  var_2 = level._id_6F5C[var_0];
  var_3 = getEntArray(var_2.targetname, "targetname");
  var_4 = undefined;

  if(var_3.size == 4) {
    if(var_2.name == "perk_all") {
      var_5 = common_scripts\utility::_id_46B7("perkmachine_look_at_loc", "targetname");
      var_6 = common_scripts\utility::_id_4461(var_3[0].origin, var_5);
      var_7 = common_scripts\utility::_id_46B5(var_6.target, "targetname");

      for(var_8 = 0; var_8 < 4; var_8++) {
        var_3[var_8].setmovespeedscale = var_8;
        var_3[var_8].look_at_loc = var_6;
        var_3[var_8].fake_scriptable = var_7;
      }
    } else {
      var_9 = _getscriptablearray("perkmachine_scriptable_ent", "targetname");
      var_9 = var_3[0] _id_45A0(var_9, 4);

      for(var_8 = 0; var_8 < 4; var_8++) {
        var_3[var_8].setmovespeedscale = var_8;
        var_3[var_8].issighted = var_9[var_8];
        var_3[var_8].issighted setscriptablepartstate("machine_main", "closed");
      }
    }
  }

  var_10 = common_scripts\utility::_id_46B7("playerLerpPos", "targetname");

  foreach(var_12 in var_3) {
    var_13 = common_scripts\utility::_id_4461(var_12.origin, var_10, 100);
    var_12._id_741E = var_13;
    var_12._id_6F63 = var_2.name;
    var_2._id_537C = 1;

    if(var_2.name == "perk_all" && isDefined(var_12.look_at_loc))
      var_12 _meth_8660(1, var_12.look_at_loc.origin);
    else
      var_12 _meth_8660(1, var_12.issighted.origin + (0, 0, 52));

    var_12._id_8C82 = var_1;

    if(_id_0547::_id_5819(var_12)) {
      if(var_2.name == "perk_all")
        _id_0547::_id_8A4F(var_12, ::assignperkallmachinetoplayer);
      else
        _id_0547::_id_8A4F(var_12, ::_id_10E2, ::_id_4D16);
    } else {}

    if(var_2.name == "perk_random") {
      var_12 thread _id_7A5A(var_2.name);
      continue;
    }

    if(var_2.name == "perk_all") {
      var_12 thread allperkmachinethink(var_2.name);
      continue;
    }

    var_12 thread _id_6F61(var_2.name);
  }
}

_id_45A0(var_0, var_1) {
  var_2 = _sortbydistance(var_0, self.origin);
  var_3 = [];

  for(var_4 = 0; var_4 < var_1; var_4++)
    var_3[var_4] = var_2[var_4];

  return var_3;
}

assignperkallmachinetoplayer(var_0) {
  var_0 endon("disconnect");

  if(1) {
    self._id_65DC = _id_0552::_id_7BE1(var_0, self, 1, self.look_at_loc.origin);
    self._id_65DC._id_4028 = _id_0552::_id_44FF("perk_all");
    var_1 = level._id_6F5C["perk_all"];
  }

  thread _id_A149(var_0, 1);
}

_id_10E2(var_0) {
  var_0 endon("disconnect");

  if(1)
    self._id_65DC = _id_0552::_id_7BF3(var_0, self, 1, self.issighted.origin + (0, 0, 52));

  thread _id_8C11(var_0);
  thread _id_6F62(var_0);
  thread _id_A149(var_0, 0);
  _id_0559::_id_7BE2(var_0, self, self._id_6F63);
}

_id_6F5E(var_0, var_1) {
  var_2 = self;
  var_3 = level._id_6F5C[var_2._id_6F63];
  var_4 = _id_4602(var_0, var_2);

  if(1) {
    var_5 = var_2._id_6F63;
    var_6 = var_4;

    if(common_scripts\utility::_id_562E(var_1)) {
      if(!common_scripts\utility::_id_562E(var_2._id_65DC.interact_disabled)) {
        var_2._id_65DC._id_6642 = 1;
        var_2._id_65DC.require_standing = 1;
      }
    } else {
      var_7 = var_0 _id_4B7E(var_5);

      if(var_3._id_6078 > -1) {
        if(var_3._id_6731 >= var_3._id_6078 && level.players.size == 1) {
          var_5 = "sold_out";
          var_6 = 0;
          var_2._id_65DC.interact_disabled = 1;
        }
      }

      var_2._id_65DC._id_6F58 = var_5;
      var_2._id_65DC._id_6F56 = var_6;
      var_2._id_65DC._id_6642 = 1;
      var_2._id_65DC.require_standing = 1;
    }
  }

  if(!common_scripts\utility::_id_562E(var_1))
    var_2 _id_8719(var_0);
}

_id_A149(var_0, var_1) {
  var_0 endon("disconnect");
  var_2 = self;

  for(;;) {
    var_2 _id_6F5E(var_0, var_1);
    var_0 common_scripts\utility::_id_A70A("perk_discount_applied", "used_vending_machine_discount", "update_trigger_cost", "perkmachine_activated", "take_perk");
  }
}

#using_animtree("destructibles");

_id_6F62(var_0) {
  var_1 = self;
  var_0 endon("disconnect");
  var_2 = 0;
  var_3 = 250000;

  if(isDefined(level.blitz_react_dist_override))
    var_3 = level.blitz_react_dist_override;

  if(common_scripts\utility::_id_562E(level.blitz_always_open)) {
    wait 0.25;
    self.issighted setscriptablepartstate("machine_main", "opening");
    wait(_getanimlength(%zmb_perk_machine_open));
    self.issighted setscriptablepartstate("machine_main", "opened");
    return;
  }

  for(;;) {
    wait 0.25;
    var_4 = !var_0 _id_4B7E(self._id_6F63) && should_open_based_on_distance(var_0, var_3) && (var_0._id_62D6 >= _id_4602(var_0, var_1) || common_scripts\utility::_id_562E(var_0._id_5799)) || isDefined(level.perk_machine_should_open) && [[level.perk_machine_should_open]](self);

    if(var_2 == var_4) {
      continue;
    }
    if(var_4) {
      var_0.wasperkgreeted = 1;
      var_5 = _id_0380::_id_2889("zmb_perk_machine_open", undefined, self.origin + (0, 0, 100));
      _id_0378::_id_8D14(var_5);
      self.issighted setscriptablepartstate("machine_main", "opening");
      wait(_getanimlength(%zmb_perk_machine_open));
      self.issighted setscriptablepartstate("machine_main", "opened");
    } else {
      var_6 = _id_0380::_id_2889("zmb_perk_machine_close", undefined, self.origin + (0, 0, 100));
      _id_0378::_id_8D14(var_6);
      self.issighted setscriptablepartstate("machine_main", "closing");
      wait(_getanimlength(%zmb_perk_machine_reverse));
      self.issighted setscriptablepartstate("machine_main", "closed");
    }

    var_2 = var_4;
  }
}

should_open_based_on_distance(var_0, var_1) {
  if(common_scripts\utility::_id_562E(var_0.wasperkgreeted))
    return 1;

  return distancesquared(var_0.origin, self.origin) < var_1;
}

_id_8719(var_0) {
  var_1 = self;
  var_2 = 5;

  for(var_3 = "" + _id_4602(var_0, var_1); var_3.size < var_2; var_3 = "0" + var_3) {}

  for(var_4 = 0; var_4 < var_2; var_4++) {
    var_5 = "gears_0" + (var_4 + 1);
    var_6 = "idle_" + int(var_3[var_4]);
    var_1.issighted setscriptablepartstate(var_5, var_6);
  }
}

_id_4D16(var_0) {
  self.issighted _meth_8006(var_0);
}

_id_8C11(var_0) {
  self.issighted showtoplayer(var_0);
}

_id_6F61(var_0, var_1) {
  var_2 = self;
  level endon("game_over");
  var_3 = level._id_6F5C[var_0];

  if(isDefined(var_3._id_8F63) && var_3._id_267B == var_3._id_8F63)
    thread _id_A183(var_0);

  for(;;) {
    [var_5, var_6] = _id_0547::_id_A795();

    if((var_5 getstance() == "crouch" || var_5 getstance() == "prone") && var_0 != "armor") {
      continue;
    }
    if(var_3._id_6078 > -1 && var_3._id_6731 >= var_3._id_6078 && level.players.size == 1) {
      _id_0555::issprinting("blitz_soldout", var_5);
      continue;
    }

    var_7 = _id_4602(var_5, var_2);

    if(var_5 _id_4B7E(var_0)) {
      _id_0555::issprinting("blitz_owned", var_5);
      continue;
    } else if(var_0 == "armor" && var_5 _id_4B53()) {
      _id_0555::issprinting("armor_full", var_5);
      continue;
    } else if(var_5 maps\mp\gametypes\zombies::_id_11C2(var_7)) {
      if(var_5 _id_056B::_id_9D19(self._id_6F63))
        var_5 _id_056B::_id_9D1A(self._id_6F63);
      else
        var_5 _id_0578::_id_A245();

      if(!isDefined(self._id_8C82))
        _id_6F5D(var_5);

      if(isDefined(var_3._id_868B))
        var_5[[var_3._id_868B]]();

      var_5._id_6F5F++;

      if(var_0 == "armor") {
        if(!isDefined(var_5._id_0F60))
          var_5._id_0F60 = 0;

        var_5._id_0F60++;

        if(isDefined(var_1))
          playFX(level._effect["zmb_pm_armor_use"], var_1.origin, anglesToForward(var_1.angles));

        var_1 _id_0378::_id_8D74("aud_use_armor_machine");
        _id_0547::_id_4AE4(var_5, "armor_booth", var_7, "none", "none");
      } else {
        _id_0547::_id_4AE4(var_5, "perk_machine", var_7, "none", "none");
        var_5 thread _id_054E::_id_73B9(var_0, var_5._id_6F5F == 1);
        level._id_400E[level._id_400E.size] = ["assassin_set 2 -1", var_5];
        level._id_400E[level._id_400E.size] = ["survivalist_set 1 -1", var_5];
      }

      self notify("perkmachine_activated");
      var_5 notify("perkmachine_activated", var_3);
      level notify("perkmachine_activated", var_3);
      level notify("perkmachine_player", var_3, self.origin, var_5);
      var_5 _id_0547::_id_7ACD();

      if(isDefined(var_3._id_8F63) && var_3._id_267B == var_3._id_8F63) {
        if(!isDefined(var_5.numperkbuys))
          var_5.numperkbuys = [];

        if(!isDefined(var_5.numperkbuys[var_0]))
          var_5.numperkbuys[var_0] = 0;

        var_5.numperkbuys[var_0]++;
        var_3._id_6731++;
      }
    }
  }
}

allperkmachinethink(var_0) {
  level endon("game_over");
  var_1 = self;
  var_2 = level._id_6F5C[var_0];

  for(;;) {
    [var_4, var_5] = _id_0547::_id_A795();

    if(var_4 getstance() == "crouch" || var_4 getstance() == "prone") {
      continue;
    }
    var_6 = _id_4602(var_4, var_1);
    var_7 = 0;

    if(var_4 maps\mp\gametypes\zombies::_id_11C2(var_6)) {
      if(!isDefined(self._id_8C82))
        _id_6F5D(var_4, 1);

      var_4 _id_4772();
      var_4._id_6F5F++;
      _id_0547::_id_4AE4(var_4, "perk_machine", var_6, "none", "none");
      self notify("perkmachine_activated");
      var_4 notify("perkmachine_activated");
      level notify("all_perkmachine_activated", var_4);
      var_4 _id_0547::_id_7ACD();
      break;
    }
  }

  waitframe();
  var_1._id_65DC.interact_disabled = 1;
  var_1._id_65DC._id_6642 = 1;
  var_1._id_65DC._id_2F74 = 1;
}

_id_7A5A(var_0) {
  level endon("game_over");
  var_1 = self;
  var_2 = level._id_6F5C[var_0];

  for(;;) {
    [var_4, var_5] = _id_0547::_id_A795();

    if(var_4 getstance() == "crouch" || var_4 getstance() == "prone") {
      continue;
    }
    if(common_scripts\utility::_id_562E(var_4.random_blitz_resetting)) {
      _id_0555::issprinting("machine_reset", var_4);
      continue;
    }

    var_6 = ["quickrevive", "doubletap", "fastreload", "punchperk", "runperk", "electriccherry"];

    if(level._id_6F5C["quickrevive"]._id_6078 > -1) {
      if(!isDefined(var_4.numperkbuys))
        var_4.numperkbuys = [];

      if(!isDefined(var_4.numperkbuys["quickrevive"]))
        var_4.numperkbuys["quickrevive"] = 0;

      if(isDefined(var_4.numselfrevivedowns) && var_4.numselfrevivedowns >= level._id_6F5C["quickrevive"]._id_6078 && level.players.size == 1)
        var_6 = common_scripts\utility::_id_0F93(var_6, "quickrevive");
    }

    var_7 = common_scripts\utility::random(var_6);
    var_8 = _id_4602(var_4, var_1);

    for(var_9 = 0; var_4 _id_4B7E(var_7); var_7 = common_scripts\utility::random(var_6)) {
      var_6 = common_scripts\utility::_id_0F93(var_6, var_7);

      if(var_6.size <= 0) {
        _id_0555::issprinting("blitz_owned", var_4);
        var_9 = 1;
        break;
      }
    }

    if(var_9 == 1) {
      continue;
    }
    if(var_4 maps\mp\gametypes\zombies::_id_11C2(var_8)) {
      var_4 _id_0578::_id_A245();

      if(!isDefined(self._id_8C82))
        _id_6F5D(var_4);

      var_4[[level._id_6F5C[var_7]._id_868B]]();
      var_4._id_6F5F++;
      _id_0547::_id_4AE4(var_4, "perk_machine", var_8, "none", "none");
      var_4 thread _id_054E::_id_73B9(var_7, var_4._id_6F5F == 1);
      self notify("perkmachine_activated");
      var_4 notify("perkmachine_activated", level._id_6F5C[var_7]);
      level notify("perkmachine_activated", level._id_6F5C[var_7]);
      level notify("perkmachine_player", level._id_6F5C[var_7], self.origin, var_4);
      var_4 _id_0547::_id_7ACD();

      if(level._id_6F5C[var_7]._id_6078 > -1 && level.players.size == 1) {
        level._id_6F5C[var_7]._id_6731++;

        if(!isDefined(var_4.numperkbuys))
          var_4.numperkbuys = [];

        if(!isDefined(var_4.numperkbuys[level._id_6F5C[var_7].name]))
          var_4.numperkbuys[level._id_6F5C[var_7].name] = 0;

        var_4.numperkbuys[level._id_6F5C[var_7].name]++;
      }

      var_4.random_blitz_resetting = 1;
      thread _id_7A59(var_4);
    }
  }
}

_id_7A59(var_0) {
  var_0 endon("death");
  wait 120;

  if(isDefined(var_0))
    var_0.random_blitz_resetting = 0;
}

_id_6F5D(var_0, var_1) {
  var_2 = spawn("script_model", var_0.origin);
  var_2 setModel("tag_origin");
  var_3 = self._id_741E.angles * (1, 0, 0) + var_0.angles * (0, 1, 0);
  var_2.angles = var_3;
  var_0 playerlinktoblend(var_2, "tag_origin", 0.25);
  var_2 moveto(self._id_741E.origin, 0.25);
  var_2 rotateto(self._id_741E.angles, 0.25);
  var_0 common_scripts\utility::_id_0603();
  var_0 common_scripts\utility::_disableoffhandweapons();
  var_0 maps\mp\_utility::freezecontrolswrapper(1);
  var_0._id_5799 = 1;
  var_0 notify("can_use_consumable");
  wait 0.25;
  var_4 = isDefined(var_0.has_purchased_any_blitz) && var_0.has_purchased_any_blitz || common_scripts\utility::_id_562E(level.iszombiesshotgun);

  if(common_scripts\utility::_id_562E(var_1))
    var_4 = 1;

  var_0 _id_0586::_id_078C("unarmed_perk_machine_zm");
  var_0 _id_0586::_id_078E("unarmed_perk_machine_zm", 0, var_4);
  var_0 _id_0547::_id_7ACD();
  var_5 = 0;

  while(!var_0 _meth_8677() && var_5 < 3) {
    var_5 = var_5 + 0.05;
    waitframe();
  }

  var_6 = 4.1;

  if(var_4)
    var_6 = 2.1;

  var_0 thread _id_2CE0(var_6);

  if(common_scripts\utility::_id_562E(var_1))
    playFX(common_scripts\utility::_id_44F5("zmb_pm_random_use"), self.fake_scriptable.origin, anglesToForward(self.fake_scriptable.angles), anglestoup(self.fake_scriptable.angles));
  else
    self.issighted setscriptablepartstate("machine_main", "use");

  var_7 = undefined;

  if(isDefined(level.groundrefent)) {
    var_7 = spawn("script_model", (0, 0, 0));
    var_7.angles = level.groundrefent.angles;
    var_0 playersetgroundreferenceent(var_7);
    var_7 rotateto((0, 0, 0), 0.3325);
  }

  wait 1.33;

  if(isDefined(level.groundrefent)) {
    var_0 playersetgroundreferenceent(level.groundrefent);

    if(isDefined(var_7))
      var_7 delete();
  }

  var_0 maps\mp\_utility::freezecontrolswrapper(0);
  var_0 unlink(var_2);
  var_2 delete();
  var_0._id_5799 = 0;
  var_0.has_purchased_any_blitz = 1;

  if(common_scripts\utility::_id_562E(level.zmb_player_safe_teleport_on_perk_buy))
    var_0 setOrigin(_func_2E1(self._id_741E.origin, var_0) + (0, 0, 1));
}

_id_0F62() {
  if(!isDefined(self.issighted)) {
    return;
  }
  if(!common_scripts\utility::_id_562E(self.anyammoforweaponmodes)) {
    self.anyammoforweaponmodes = 1;
    var_0 = 2.86667;
    self.issighted setscriptablepartstate("machine_main", "working");
    wait(var_0 * 0.3333);
    self.issighted setscriptablepartstate("machine_main", "idle");
    self.anyammoforweaponmodes = 0;
  }
}

_id_2CE0(var_0) {
  wait(var_0);
  _id_0586::_id_078E(_id_0547::_id_AB2B());
  common_scripts\utility::_id_0617();
  common_scripts\utility::_id_0614();
  self notify("can_use_consumable");

  if(self hasweapon("unarmed_perk_machine_zm"))
    _id_0586::_id_0790("unarmed_perk_machine_zm");
}

isusingperkmachine() {
  return common_scripts\utility::_id_562E(self._id_5799) || self hasweapon("unarmed_perk_machine_zm");
}

_id_4B7E(var_0) {
  if(!isDefined(self._id_6F66))
    self._id_6F66 = [];

  if(var_0 == "perk_random")
    return 0;

  if(var_0 == "perk_all")
    return 0;

  if(isDefined(self._id_6F66[var_0]))
    return 1;

  return 0;
}

_id_A183(var_0) {
  level endon("game_over");

  for(;;) {
    level common_scripts\utility::_id_A70A("player_spawned", "player_disconnected");

    if(level.players.size > 1) {
      var_1 = level._id_6F5C[var_0];

      if(var_1._id_267B != var_1._id_64F7) {
        var_1._id_267B = var_1._id_64F7;

        foreach(var_3 in level.players) {
          if(!isDefined(var_3.numperkbuys))
            var_3.numperkbuys = [];

          if(!isDefined(var_3.numperkbuys[var_0]))
            var_3.numperkbuys[var_0] = 0;

          var_3 notify("update_trigger_cost");
        }
      }

      continue;
    }

    var_1 = level._id_6F5C[var_0];

    if(isDefined(var_1._id_8F63) && var_1._id_267B != var_1._id_8F63) {
      var_1._id_267B = var_1._id_8F63;

      foreach(var_3 in level.players) {
        var_3 notify("update_trigger_cost");

        if(var_0 == "quickrevive") {
          if(isDefined(var_3.numselfrevivedowns) && var_3.numselfrevivedowns >= var_1._id_6078 && var_3 _id_4B7E(var_0))
            var_3 _id_95D7(var_0);
        }
      }
    }
  }
}

_id_4772(var_0) {
  if(_id_0547::_id_577E(self)) {
    return;
  }
  if(_id_0547::_id_57E1(self))
    return 0;

  if(self.sessionstate == "spectator")
    return 0;

  level._id_5F5A = 1;
  var_1 = 0;

  if(!isDefined(var_0))
    var_0 = 1;

  foreach(var_3 in level._id_6F5C) {
    if(var_0 == 0 || common_scripts\utility::_id_562E(var_3._id_537C)) {
      if(var_3.name != "armor" && var_3.name != "perk_random" && var_3.name != "perk_all") {
        _id_4792(var_3.name);
        var_1++;
      }
    }
  }

  self setclientomnvar("zm_blitz_items_limit", var_1);
}

givefreemachineperks(var_0, var_1, var_2) {
  level._id_5F5A = 1;
  var_3 = 0;

  if(!isDefined(var_0))
    var_0 = 1;

  var_4 = [];
  var_5 = [];

  foreach(var_7 in level._id_6F5C)
  var_5 = common_scripts\utility::_id_0F6F(var_5, var_7.name);

  if(isDefined(var_2))
    var_5 = var_2;

  foreach(var_7 in var_5) {
    if(var_7 != "armor" && var_7 != "perk_random" && var_7 != "perk_all" && !_id_4B7E(var_7)) {
      var_4 = common_scripts\utility::_id_0F6F(var_4, var_7);
      _id_4792(var_7);
      var_3++;

      if(var_3 == var_1) {
        break;
      }
    }
  }

  self setclientomnvar("zm_blitz_items_limit", var_3);
  return var_4;
}

_id_95D0(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  foreach(var_2 in level._id_6F5C) {
    if(var_0 == 0 || common_scripts\utility::_id_562E(var_2._id_537C)) {
      if(var_2.name != "armor" && var_2.name != "perk_random" && var_2.name != "perk_all")
        _id_95D7(var_2.name);
    }
  }
}

_id_4603(var_0) {
  var_1 = level._id_6F5C[var_0];
  return var_1._id_6A6E;
}

_id_4792(var_0) {
  var_1 = level._id_6F5C[var_0];
  self[[var_1._id_868B]]();
}

_id_95D7(var_0) {
  var_1 = level._id_6F5C[var_0];

  if(isDefined(var_1._id_A067))
    self[[var_1._id_A067]]();
}

_id_95D8(var_0) {
  var_1 = self._id_6F66[var_0];
  self._id_6F66[var_0] = undefined;
  self._id_6F67 = common_scripts\utility::_id_0F93(self._id_6F67, var_1);

  for(var_2 = 0; var_2 < self._id_6F67.size; var_2++) {
    var_3 = self._id_6F67[var_2];
    var_3._id_00D4 = var_2;
    self setclientomnvar(_id_4603(var_3.name), var_2);
  }

  if(isDefined(self.characterclientindex)) {
    var_4 = 0;

    foreach(var_6 in self._id_6F67) {
      var_7 = var_6._id_00D4;
      var_8 = level._id_6F5C[var_6.name].perkid;

      if(isDefined(var_8))
        var_4 = var_4 << 3 | var_8;
    }

    var_10 = "ui_zm_blitz_" + self.characterclientindex;
    _setomnvar(var_10, var_4);
  }

  self notify("take_perk", var_0);
  self setclientomnvar(_id_4603(var_0), -1);
}

_id_4793(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.name = var_0;
  var_2._id_00D4 = self._id_6F67.size;
  self._id_6F66[var_0] = var_2;
  self._id_6F67[var_2._id_00D4] = var_2;
  self setclientomnvar(_id_4603(var_0), var_2._id_00D4);
  var_3 = undefined;
  var_4 = _id_420E(_id_0547::_id_4BA7("specialty_class_hoarder_zm"));

  while(self._id_6F67.size > var_4) {
    var_3 = self._id_6F67[0].name;
    _id_95D7(self._id_6F67[0].name);
  }

  if(isDefined(self.characterclientindex)) {
    var_5 = 0;

    foreach(var_7 in self._id_6F67) {
      var_8 = var_7._id_00D4;
      var_9 = level._id_6F5C[var_7.name].perkid;

      if(isDefined(var_9))
        var_5 = var_5 << 3 | var_9;
    }

    var_11 = "ui_zm_blitz_" + self.characterclientindex;
    _setomnvar(var_11, var_5);
  }

  if(isDefined(var_3))
    _id_0555::issprinting("biltz_replaced", self, var_0, var_3);
  else
    _id_0555::issprinting("buy_blitz", self, var_0);
}

_id_47B5() {
  if(_id_4B7E("fastreload")) {
    return;
  }
  _id_4793("fastreload", (0, 1, 0));
  maps\mp\_utility::giveperk("specialty_fastreload");
}

_id_95F1() {
  if(!_id_4B7E("fastreload")) {
    return;
  }
  if(maps\mp\_utility::_hasperk("specialty_fastreload"))
    maps\mp\_utility::_id_0735("specialty_fastreload");

  _id_95D8("fastreload");
}

_id_47B0() {
  if(_id_4B7E("punchperk")) {
    return;
  }
  _id_4793("punchperk", (1, 1, 1));
}

_id_95EF() {
  if(!_id_4B7E("punchperk")) {
    return;
  }
  _id_95D8("punchperk");
}

_id_4B85() {
  return _id_4B7E("punchperk");
}

_id_47B8() {
  if(_id_4B7E("runperk")) {
    return;
  }
  _id_4793("runperk", (1, 1, 0));
  maps\mp\_utility::giveperk("specialty_lightweight");
  maps\mp\_utility::giveperk("specialty_marathon");
  _id_0547::_id_7ACD();
}

_id_95F3() {
  if(!_id_4B7E("runperk")) {
    return;
  }
  if(maps\mp\_utility::_hasperk("specialty_lightweight"))
    maps\mp\_utility::_id_0735("specialty_lightweight");

  if(maps\mp\_utility::_hasperk("specialty_marathon"))
    maps\mp\_utility::_id_0735("specialty_marathon");

  _id_0547::_id_7ACD();
  _id_95D8("runperk");
}

_id_47B1() {
  if(_id_4B7E("quickrevive")) {
    return;
  }
  _id_4793("quickrevive", (0, 1, 1));
}

_id_95F0() {
  if(!_id_4B7E("quickrevive")) {
    return;
  }
  _id_95D8("quickrevive");
}

_id_4785() {
  if(_id_4B7E("electriccherry")) {
    return;
  }
  _id_4793("electriccherry", (0, 0, 1));
  thread _id_35B0();
}

_id_95D5() {
  if(!_id_4B7E("electriccherry")) {
    return;
  }
  self notify("take_electriccherry");

  if(isDefined(self._id_6F66["electriccherry"]._id_AAC0))
    self._id_6F66["electriccherry"]._id_AAC0 delete();

  if(isDefined(self._id_6F66["electriccherry"]._id_AAC1))
    self._id_6F66["electriccherry"]._id_AAC1 delete();

  _id_95D8("electriccherry");
}

_id_35B0() {
  self endon("death");
  self endon("disconnect");
  self endon("take_electriccherry");
  var_0 = self;
  var_1 = self._id_6F66["electriccherry"];
  var_1._id_A66D = [];
  var_1._id_258C = 0;
  var_1._id_AAC1 = spawn("script_model", (0, 0, 0));
  var_1._id_AAC1 setModel("tag_origin");
  var_1._id_AAC1 linkto(var_0, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_0 thread maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_1._id_AAC1);
  var_1._id_AAC0 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_elec_cherry_wv"), var_1._id_AAC1, "tag_origin");
  var_1._id_AAC0 _meth_8006(var_0);
  var_0 thread maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_1._id_AAC0);

  for(;;) {
    var_0 waittill("reload_start");
    var_2 = var_0 getcurrentweapon();

    if(common_scripts\utility::_id_0F79(var_1._id_A66D, var_2)) {
      continue;
    }
    var_1._id_A66D[var_1._id_A66D.size] = var_2;
    var_1._id_258C++;
    var_3 = var_0 getweaponammoclip(var_2);
    var_4 = _weaponclipsize(var_2);
    var_5 = 1 - var_3 / var_4;
    var_6 = common_scripts\utility::_id_5D92(var_5, 0, 1, 1, 1045);
    var_7 = common_scripts\utility::_id_5D92(var_5, 0, 1, 32, 128);
    var_0 thread _id_2161(var_2);

    switch (var_1._id_258C) {
      case 1:
      case 0:
        var_8 = undefined;
        break;
      case 2:
        var_8 = 8;
        break;
      case 3:
        var_8 = 4;
        break;
      case 4:
        var_8 = 2;
        break;
      default:
        var_8 = 0;
    }

    var_0 thread _id_35AD(var_2);

    if(isDefined(var_8) && var_8 == 0) {
      continue;
    }
    _triggerfx(var_1._id_AAC0);
    var_0 _id_0378::_id_8D74("electric_cherry_vfx");
    _playfxontagforclients(common_scripts\utility::_id_44F5("zmb_elec_cherry_player"), var_0, "J_Spine4", var_0);
    var_9 = maps\mp\agents\_agent_utility::_id_43FD("all");
    var_9 = common_scripts\utility::_id_40B0(var_0.origin, var_9, undefined, var_8, var_7);

    foreach(var_11 in var_9) {
      var_11 _id_0546::mark_electrified();
      var_11 dodamage(var_6, var_11.origin, var_0, var_0, "MOD_MELEE", "electric_cherry_zm");
      playFX(common_scripts\utility::_id_44F5("zmb_elec_cherry_zombie"), var_11.origin + (0, 0, 40));
    }
  }
}

_id_2161(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("take_electriccherry");
  self endon("player_lost_weapon_" + var_0);
  thread _id_A9B5(var_0);

  for(;;) {
    self waittill("reload");
    var_1 = self getcurrentweapon();

    if(var_1 == var_0) {
      self._id_6F66["electriccherry"]._id_A66D = common_scripts\utility::_id_0F93(self._id_6F66["electriccherry"]._id_A66D, var_0);
      self notify("weapon_reload_complete_" + var_0);
      break;
    }
  }
}

_id_A9B5(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("take_electriccherry");
  self endon("weapon_reload_complete_" + var_0);

  for(;;) {
    self waittill("weapon_change");
    var_1 = self getweaponlistprimaries();

    if(!common_scripts\utility::_id_0F79(var_1, var_0)) {
      self notify("player_lost_weapon_" + var_0);
      self._id_6F66["electriccherry"]._id_A66D = common_scripts\utility::_id_0F93(self._id_6F66["electriccherry"]._id_A66D, var_0);
      break;
    }
  }
}

_id_35AD(var_0) {
  self notify("electric_cherry_cooldown_started");
  self endon("electric_cherry_cooldown_started");
  self endon("death");
  self endon("disconnect");
  self endon("take_electriccherry");
  var_1 = 0.25;

  if(maps\mp\_utility::_hasperk("specialty_fastreload"))
    var_1 = var_1 * 0.5;

  var_2 = var_1 + 3;
  wait(var_2);
  self._id_6F66["electriccherry"]._id_258C = 0;
}

_id_4784() {
  if(_id_4B7E("doubletap")) {
    return;
  }
  maps\mp\_utility::giveperk("specialty_rof");
  _id_4793("doubletap", (1, 0, 1));
}

_id_95D3() {
  if(!_id_4B7E("doubletap")) {
    return;
  }
  if(maps\mp\_utility::_hasperk("specialty_rof"))
    maps\mp\_utility::_id_0735("specialty_rof");

  _id_95D8("doubletap");
}

_id_5F1E() {
  level endon("game_over");
  level._id_5F20 = ::_id_5F20;
  level._id_5F1D = ::_id_5F1D;
  var_0 = getEntArray("photobooth_buy", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_2 in var_0) {
    var_3 = undefined;

    if(isDefined(var_2.target)) {
      var_3 = common_scripts\utility::_id_46B5(var_2.target, "targetname");

      if(isDefined(var_3))
        var_2 _meth_8660(1, var_3.origin);
      else
        var_2 usetriggerrequirelookat(1);
    }

    if(isDefined(var_3) && isDefined(var_3.target))
      var_2._id_191E = _getent(var_3.target, "targetname");

    _id_0547::_id_8A4F(var_2, ::_id_5F22);
  }
}

_id_5F22(var_0) {
  var_0 endon("disconnect");
  var_0._id_6F93 = 0;
  childthread _id_5F23(var_0);
  childthread _id_5F21(var_0);
}

_id_5F23(var_0) {
  var_1 = 2000;
  _id_0559::_id_7BE2(var_0, self, "photo");
  var_2 = undefined;

  if(1) {
    var_2 = _id_0552::_id_7BF3(var_0, self);
    var_2._id_6F58 = "lost_and_found_empty";
    var_2._id_6F56 = 0;
    var_2.require_standing = 0;
  }

  for(;;) {
    waittillframeend;

    if(var_0._id_6F93) {
      var_3 = _distance2d(self.origin, var_0.origin);

      if(!_id_0547::_id_577E(var_0) && !(_id_0547::_id_57E1(var_0) || var_0.sessionstate == "spectator")) {
        if(!common_scripts\utility::_id_562E(self._id_5594) && var_3 <= var_1) {
          self._id_5594 = 1;
          self._id_191E hudoutlineenableforclient(var_0, 0, 0);
          thread lostandfoundcountdown(var_0);
        }

        if(1) {
          var_2._id_6F58 = "lost_and_found_restore";
          var_2._id_6F56 = 500;
          var_2._id_6642 = 1;
          var_2.interact_disabled = undefined;
          var_2.require_standing = 0;
        }
      }
    } else {
      if(!isDefined(self._id_5594) || common_scripts\utility::_id_562E(self._id_5594)) {
        self._id_191E hudoutlinedisableforclient(var_0);
        self._id_5594 = 0;
      }

      if(1) {
        var_2._id_6F58 = "lost_and_found_empty";
        var_2._id_6F56 = 0;
        var_2._id_6642 = 1;
        var_2.interact_disabled = 1;
        var_2.require_standing = 0;
      }
    }

    common_scripts\utility::_id_A70C(var_0, "perk_discount_applied", var_0, "update_lost_and_found_hint", level, "zombie_wave_started", var_0, "spawned");
  }
}

lostandfoundcountdown(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 endon("lost_and_found_restored");
  wait 45;
  self._id_191E hudoutlineenableforclient(var_0, 1, 0);
  wait 15;

  if(common_scripts\utility::_id_562E(var_0._id_6F93)) {
    if(isDefined(level._id_5F1D))
      var_0[[level._id_5F1D]]();
  }
}

_id_5F21(var_0) {
  for(;;) {
    [var_2, var_3] = _id_0547::_id_A795();

    if(var_2._id_6F93) {
      var_4 = 500;

      if(var_2 maps\mp\gametypes\zombies::_id_11C2(var_4)) {
        _id_0555::issprinting("photo", var_2);
        _id_0547::_id_4AE4(var_2, "photo_booth", var_4, "none", "none");
        var_2 _id_5F1F();
        var_2 thread _id_054E::playeruselostandfound();
        var_2 notify("lost_and_found_restored");

        if(isDefined(level._id_5F1D))
          var_2[[level._id_5F1D]]();
      }
    }
  }
}

lostandfoundsaveweapon(var_0) {
  var_1 = self;
  var_2 = spawnStruct();
  var_2._id_A9E0 = var_0;
  var_2.ammoinfo = var_1 _id_0586::_id_4129(var_0);

  if(!isDefined(var_1.lostandfoundinfos))
    var_1.lostandfoundinfos = [];

  var_1.lostandfoundinfos[var_1.lostandfoundinfos.size] = var_2;
}

lostandfoundgetbackupweapon(var_0) {
  var_1 = self;

  if(!isDefined(var_1.lostandfoundinfos)) {
    return;
  }
  foreach(var_3 in var_1.lostandfoundinfos) {
    if(weaponinventorytype(var_3._id_A9E0) == var_0)
      return var_3._id_A9E0;
  }
}

_id_5F20() {
  var_0 = self;
  var_0.lostandfoundinfos = [];
  var_1 = self getweaponlistprimaries();

  foreach(var_3 in var_1) {
    var_4 = _id_0586::_id_0632(var_3);

    if(issubstr(var_4, "tesla")) {
      continue;
    }
    if(isDefined(level.dlc4specialweapons) && common_scripts\utility::_id_0F79(level.dlc4specialweapons, var_3)) {
      continue;
    }
    if(_id_0547::iszombieconsumableweapon(var_4) || _id_0547::_id_5865(var_4) || _id_0547::_id_585B(var_4)) {
      continue;
    }
    var_0 lostandfoundsaveweapon(var_4);
  }

  var_6 = self getweaponslistoffhands();

  foreach(var_3 in var_6)
  var_0 lostandfoundsaveweapon(var_3);

  var_9 = self getweaponslistitems();

  foreach(var_11 in var_9) {
    var_12 = _id_0586::_id_0632(var_11);

    if(!isDefined(var_12) || !_id_0547::_id_5836(var_12)) {
      continue;
    }
    var_0 lostandfoundsaveweapon(var_12);
  }

  var_14 = self getcurrentprimaryweapon();
  var_14 = _id_0586::_id_0632(var_14);

  if(_id_0547::iszombieconsumableweapon(var_14) || _id_0547::_id_5865(var_14) || _id_0547::_id_585B(var_14) || _id_0547::_id_5864(var_14) || issubstr(var_14, "tesla")) {
    var_15 = lostandfoundgetbackupweapon("primary");
    var_16 = lostandfoundgetbackupweapon("offhand");

    if(isDefined(var_15))
      self._id_6F94 = var_15;
    else if(isDefined(var_16))
      self._id_6F94 = var_16;
    else {
      var_17 = _id_0548::_id_454B(self, "shovel_zm");
      self._id_6F94 = var_17;
    }
  } else
    self._id_6F94 = var_14;

  self._id_6F93 = 1;
  self notify("update_lost_and_found_hint");
}

_id_5F1D() {
  self._id_6F93 = 0;
  self.lostandfoundinfos = undefined;
  self._id_6F94 = undefined;
  self notify("update_lost_and_found_hint");
}

_id_5F1F() {
  var_0 = self;
  var_1 = self getweaponlistprimaries();

  foreach(var_3 in var_1) {
    if(isDefined(level.dlc4specialweapons) && common_scripts\utility::_id_0F79(level.dlc4specialweapons, var_3)) {
      continue;
    }
    _id_0586::_id_0790(var_3);
  }

  var_5 = self getweaponslistitems();

  foreach(var_7 in var_5) {
    if(!_id_0547::_id_5836(var_7)) {
      continue;
    }
    if(isDefined(level.dlc4specialweapons) && common_scripts\utility::_id_0F79(level.dlc4specialweapons, var_7)) {
      continue;
    }
    var_0 _id_0586::_id_0790(var_7);
  }

  var_9 = self._id_6F94;

  if(isDefined(var_0.lostandfoundinfos)) {
    foreach(var_11 in var_0.lostandfoundinfos) {
      var_12 = var_11._id_A9E0;
      var_0 _id_0586::_id_078C(var_12);
      var_0 _id_0586::_id_0F21(var_12, var_11.ammoinfo);
    }
  }

  if(var_9 != "none")
    _id_0586::_id_078E(var_9, 1);
}

_id_5BFE() {
  self endon("disconnect");
  self endon("revive");

  if(_id_0553::_id_581E()) {
    return;
  }
  if(_id_0547::_id_4BA7("specialty_class_aftertaste_zm") && self._id_6882 <= 1) {
    self waittill("death");
    _id_95D0(0);
  } else {
    var_0 = self._id_6F66.size;
    var_1 = _id_0553::_id_0634() / (var_0 + 1);
    self endon("death");

    for(var_2 = 0; var_2 < var_0; var_2++) {
      wait(var_1);
      var_3 = self._id_6F67[0];
      _id_95D7(var_3.name);
      _id_0380::_id_2888("zmb_ui_bleed_out_perk_loss", self);
    }
  }
}

_id_09DF(var_0, var_1) {
  if(!isDefined(self._id_6F66) || !isDefined(self._id_6F66[var_0])) {
    return;
  }
  var_2 = _newclienthudelem(self);
  var_2.x = 8 + (self._id_6F66.size - 1) * 16;
  var_2.y = -32;
  var_2 setshader("objpoint_default", 16, 16);
  var_2.alignx = "left";
  var_2.aligny = "bottom";
  var_2._id_00C6 = "left";
  var_2._id_01CA = "bottom";
  var_2.alpha = 1;
  var_2.color = var_1;
  self._id_6F66[var_0]._id_6F6B = var_2;
}

_id_A148() {
  var_0 = 0;

  foreach(var_2 in self._id_6F66) {
    var_2._id_6F6B.x = 8 + var_0 * 16;
    var_0++;
  }
}

_id_7CEC(var_0) {
  self._id_6F66[var_0]._id_6F6B destroy();
}

_id_4602(var_0, var_1) {
  var_2 = level._id_6F5C[var_1._id_6F63];
  var_3 = var_2._id_267B;

  if(var_1._id_6F63 == "perk_all")
    return var_3;

  if(isDefined(var_2._id_8F63) && level.players.size == 1)
    var_3 = var_2._id_8F63;

  if(var_1._id_6F63 == "armor" && isDefined(var_0._id_0F60)) {
    for(var_4 = 0; var_4 < var_0._id_0F60; var_4++)
      var_3 = _id_0547::_id_4522(var_3);
  }

  var_5 = var_0 _id_0578::_id_4717(var_1);
  var_6 = int(var_3 * var_5);
  return var_6;
}

_id_0F66(var_0) {
  var_1 = self;
  var_0 endon("disconnect");
  _id_0559::_id_7BE2(var_0, self, "armor");
  var_2 = undefined;

  if(1)
    var_2 = _id_0552::_id_7BF3(var_0, self);

  for(;;) {
    waittillframeend;
    var_3 = _id_4602(var_0, var_1);

    if(1) {
      var_4 = var_0 _id_4B53();
      var_2._id_6F58 = "armor";
      var_2._id_6F56 = var_3;
      var_2._id_6642 = 1;
      var_2.require_standing = 0;
    }

    var_0 common_scripts\utility::_id_A70A("perkmachine_activated", "take_armor", "take_perk", "perk_discount_applied", "update_armor_hints");
  }
}

_id_0F65(var_0) {
  if(!var_0 _id_4B53())
    return level._id_6F5C["armor"]._id_00C5;
  else
    return &"ZOMBIES_EMPTY_STRING";
}

_id_4B53() {
  var_0 = _id_0547::_id_73E9();
  return var_0 > 0 && var_0 == 3;
}

_id_4775() {
  _id_0547::_id_7454(3);
  thread _id_0F69();
}

_id_95D2() {
  _id_0547::_id_7454(0);
}

_id_0F69(var_0, var_1, var_2) {
  self endon("disconnect");
  self waittill("take_armor");
  self notify("lost_armor");
  self notify("take_perk", "armor");
  _id_95D2();
}