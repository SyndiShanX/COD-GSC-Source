/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_lootcache.gsc
***********************************************/

brlootcache_init() {
  scripts\engine\scriptable::_id_12F5B("_encstr_AD9B0589ED9197", ::lootcacheused);
  var_0 = getDvar("_encstr_8E07178E5BF3D685DAB970704233B76E23CF18858F5BD9D347", "_encstr_B40101");
  var_1 = getDvar("_encstr_8DFB1E2308F5D9834B509C95D6734F1161D06ACB8189CAFF61A76281F9984B20", 0.0);
  var_2 = strtok(var_0, "_encstr_974C0246");
  var_3 = strtok(var_1, "_encstr_974C0246");

  if(var_3.size == 0)
    var_3[var_3.size] = "_encstr_96180497850F";

  level.dummy_backpack = [];

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_5 = spawnStruct();
    var_5.name = var_2[var_4];
    var_6 = int(min(var_4, var_3.size - 1));
    var_5._id_1289A = float(var_3[var_6]);
    level.dummy_backpack[level.dummy_backpack.size] = var_5;
  }

  if(istrue(level.setplayerselfrevivingextrainfo)) {
    setmatchdata("_encstr_81981B78BF80BBDDEFD0A20A413D944FD8A7EADC4EC9D7238DB83AB250", 1);
    _getactualcost::init();
  }

  level.dummy_hint = [];
  level thread _id_119FF();
}

get_bonus_targets(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid()) {
    if(isDefined(level.playerhandleredeploy) && isDefined(level.playerhandleredeploy[var_0]))
      return 0;
  }

  if(var_0 == "_encstr_92DD158AA878E89FF1F87E0B1F6B1EDFD5011DC78C6D38" && _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12CB6())
    return 0;

  if((var_0 == "_encstr_865216B27B6327F74871ABB25A03183310A8E1FB9020A238" || var_0 == "_encstr_97C613F92AD4C00883B71F3353FA44F964C54091D5") && istrue(level.br_pickups._encstr_ACDA0B86A591AC477B5B59E637))
    return 0;

  return 1;
}

_id_11A41(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(istrue(var_4)) {
    var_9 = 35;

    if(isDefined(var_6)) {
      var_10 = [115, 75, 95, 85, 105, 65];
      var_11 = (var_1.ml_p3_to_safehouse_transition + var_6 * 3) % var_10.size;
      var_12 = var_10[var_11];
      var_9 = var_9 + 20 * var_6;
    } else if(var_1.ml_p3_to_safehouse_transition % 2 > 0)
      var_12 = 75;
    else
      var_12 = 115;

    var_12 = var_12 + randomfloatrange(-10, 10);
    var_13 = var_9 + var_1.ml_p3_to_safehouse_transition / 2 * 25 + randomfloatrange(-5, 5);
    var_14 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_1, var_2, var_3, var_7, var_12, var_13);
  } else if(isDefined(self.intro_ride))
    var_14 = [[self.intro_ride]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  else
    var_14 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_1, var_2, var_3, var_7);

  if(_encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::vandalize_attack_max_cooldown(var_0))
    var_15 = _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_getweaponstartingclipammo(var_0);
  else
    var_15 = level.br_pickups.counts[var_0];

  var_16 = undefined;

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_AC0212205BFB68E398F4B8856F9130F645CD7B63"))
    var_15 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E07("_encstr_AC0212205BFB68E398F4B8856F9130F645CD7B63", var_0, var_4, var_15, var_1);

  if(isDefined(self.intro_moveplayercliphack))
    var_15 = [[self.intro_moveplayercliphack]](var_0, var_15);

  if(_encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::vandalize_attack_max_cooldown(var_0)) {
    var_17 = createheadicon(var_0);
    var_18 = 0;

    if(scripts\mp\utility\weapon::turnexfiltoside(var_0))
      var_16 = var_15;

    if(var_0.hasalternate) {
      var_19 = var_0 getaltweapon();

      if(!_encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::debug_spawn_crate_on_train(var_0, var_19))
        var_18 = _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_getweaponstartingclipammo(var_19);
    }

    var_20 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup(var_17, var_14, var_15, 1, var_0, undefined, var_16, var_18);
  } else {
    var_21 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::relics_monitor_on_player(var_0);

    if(isDefined(var_21)) {
      var_15 = _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_getweaponstartingclipammo(var_21);

      if(scripts\mp\utility\weapon::turnexfiltoside(var_21))
        var_16 = var_15;
    }

    var_20 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup(var_0, var_14, var_15, 1, undefined, undefined, var_16);
    var_22 = level.br_pickups.delay_hide_player_clip[var_0];

    if(var_5 && isDefined(self.type) && self.type != "_encstr_8E0114B5E6B9D0CF40C4293F21FF4AB13730A0FFCB2D")
      playsoundatpos(var_14.origin, "_encstr_A73E171B75204AEDB8D1ED7749C829B101F7A7DB47D5F3AF28");
  }

  return var_20;
}

_id_11A42(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_6 = 0;
  var_7 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
  var_7.ml_p3_to_safehouse_transition = self.itemsdropped;
  var_7.playersetattractiontype = var_4;
  var_8 = [];

  foreach(var_10 in var_0) {
    if(_encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::vandalize_attack_max_cooldown(var_10)) {
      var_11 = scripts\mp\utility\weapon::getweaponrootname(var_10);

      if(get_bonus_targets(var_11))
        var_8[var_8.size] = var_10;

      continue;
    }

    if(get_bonus_targets(var_10))
      var_8[var_8.size] = var_10;
  }

  var_7._encstr_8D970F25851BB021B4BA7059E76F885AB9 = var_8.size;

  foreach(var_10 in var_8) {
    if(_encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::vandalize_attack_max_cooldown(var_10)) {
      var_5[var_5.size] = _id_11A41(var_10, var_7, self.origin, self.angles, var_1, 1, var_2, var_3, 1);
      self.itemsdropped++;
      var_14 = _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_type_for_weapon(var_10);

      if(isDefined(var_14)) {
        var_5[var_5.size] = _id_11A41(var_14, var_7, self.origin, self.angles, var_1, 1, var_2, var_3);
        self.itemsdropped++;
      }

      continue;
    }

    var_15 = level.br_pickups.delay_hide_player_clip[var_10];

    if(isDefined(var_15) && var_15 == 4 && var_6 == 0) {
      var_5[var_5.size] = _id_11A41(var_10, var_7, self.origin, self.angles, var_1, 1, var_2, var_3);
      self.itemsdropped++;
      var_6 = 1;
    } else {
      var_5[var_5.size] = _id_11A41(var_10, var_7, self.origin, self.angles, var_1, 0, var_2, var_3);
      self.itemsdropped++;
    }
  }

  return var_5;
}

_id_11A02(var_0, var_1) {
  return _id_11A42(var_0, 1, var_1);
}

heli_flyloop(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A350079E35DACF8944");
  var_1 = getdvarint("_encstr_96DB219B6C4EBEE42B5DCDB098C62BF5D8166C1A95FA4EB21B1AB09C9D95EBD14B5B59", 90);
  var_2 = 10;
  var_3 = 1;

  for(var_4 = var_1 / var_2; var_3 < var_2; var_3++) {
    wait(var_4);
    self setscriptablepartstate(var_0, "_encstr_96190434978B" + var_3);
  }

  waitframe();
  var_5 = getdvarint("_encstr_AA0C1D485FA2262D92E30E1F3E5A5B6E1BEF4008AF7798DF1ACB101ED733BF", 3);
  self.intel_collected = (self.intel_collected + 1) % var_5;
  self setscriptablepartstate(var_0, "_encstr_BEE608BF50D84BAA9DF4");

  if(_encstr_A68B30E6D8392DE08EE6E55B83BCECB0B6568E2F832B37BC31C9BE0E57C46396C6563BCACD47FA4EB2E61DBDB16DC5B3CD1B::use_dropkit_marker())
    _encstr_A68B30E6D8392DE08EE6E55B83BCECB0B6568E2F832B37BC31C9BE0E57C46396C6563BCACD47FA4EB2E61DBDB16DC5B3CD1B::_id_12C00();
}

lootcacheused(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_0.computer_force_player_to_exit)) {
    return;
  }
  if(istrue(var_3 _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_ADBB1538C49859E5C29B60B8A33047CAA3AF31F1D38BE8", var_0))) {
    return;
  }
  if(isDefined(var_0) && isDefined(var_0.get_circle_back_nodes_on_same_side) && ![[var_0.get_circle_back_nodes_on_same_side]](var_0, var_1, var_2, var_3, var_4)) {
    return;
  }
  if((var_2 == "_encstr_A350079E35DACF8944" || var_2 == "_encstr_ACAE0DEFDB15AF50C5B1A047569F6D") && !isDefined(var_0.entity)) {
    if(var_2 == "_encstr_A350079E35DACF8944")
      var_0 setscriptablepartstate(var_1, "_encstr_93CF08C7684F60BBB372");
    else if(var_2 == "_encstr_ACAE0DEFDB15AF50C5B1A047569F6D")
      var_0 setscriptablepartstate(var_1, "_encstr_AA100EA813B5CD1B226718987DAA4F08");

    if(isDefined(var_0) && isDefined(var_0._id_1406C))
      thread[[var_0._id_1406C]](var_0, var_1, var_2, var_3, var_4);

    var_0.itemsdropped = 0;
    thread allow_forward_factor(var_0, var_1, var_2, var_3, var_4);

    if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_8432150FA453AF2996A3A8811A2DE965A7460DF536BB13"))
      var_0 thread _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_8432150FA453AF2996A3A8811A2DE965A7460DF536BB13");

    _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_11C91("_encstr_B4D90E9636AFD277F08057BF3029380A", -1);

    if(isDefined(var_0.type) && var_0.type == "_encstr_8E0114B5E6B9D0CF40C4293F21FF4AB13730A0FFCB2D") {
      var_3 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_A9181205B26928B72FFB09F582074B58B52883E5");
      var_3 dlog_recordplayerevent("_encstr_AB4F178C1B7BD9FACAEC56E61D7D9CDEECEA957D1BC26C86B2", []);
    } else
      var_3 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_93D50D50754757B91858A1848079C8");

    foreach(var_6 in level.teamdata[var_3.team]["_encstr_85F0132F46DB4B5BF5C728F8B30472F7336F952FDA"]) {
      if(isDefined(var_6) && var_6.owner != var_3)
        var_6.owner thread scripts\mp\utility\points::giveunifiedpoints("_encstr_BD7D179E33D86F957B3A49F22948AB0D6370C64FC3A057C348", undefined, undefined, undefined, undefined, undefined, var_6);
    }

    var_3 scripts\cp\vehicles\vehicle_compass_cp::_id_12002();

    if(!isDefined(var_3._id_11A01))
      var_3._id_11A01 = 1;
    else
      var_3._id_11A01++;

    var_3 scripts\mp\utility\stats::setextrascore1(var_3._id_11A01);

    if(istrue(level.setplayerselfrevivingextrainfo))
      var_3 thread _getactualcost::_id_12120(var_0.type, var_0, var_3.calloutarea);

    if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_9671100BC050B4F00B7ECC874011AA66B923"))
      var_3 thread _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_9671100BC050B4F00B7ECC874011AA66B923", var_0);

    var_8 = _encstr_92CD26C37908D8EB3D1F670F50C8DA3955FB5BD792B14F9E42836953ACF2D18F7312F230F087FB66::_encstr_92391287D32D137C0B2AA76A23A8A8DB057B6F43(var_3);

    if(isDefined(var_8)) {
      var_3 thread scripts\mp\events::killeventtextpopup("_encstr_8E2B0C2A98B79BA7F3589C87685B", 0, 0);
      var_8 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_encstr_B2D2134BF3EDAF7BC8A315E56D08C3238D8BC2D27B(getdvarint("_encstr_ABD61EB8F6201FB52B7FCB74CA8F410FEF582D29033B5F17C847F85F9D6BC8FE", 5));
    }

    level notify("_encstr_82941EBD48D8D4AA27572B17C7D8633D389137C960B08412106F17CBB9F07B64" + var_0.origin);
    level.dummy_hint = scripts\engine\utility::array_remove(level.dummy_hint, var_0);
  }
}

allow_earthquake(var_0) {
  var_1 = 0;
  var_1 = var_1 | var_0 == "_encstr_8B2E22586B9989B8E714C8DF145FA16B7A415850F22BD5F6BF29EE43F5D7A93FA5CA4028";
  var_1 = var_1 | var_0 == "_encstr_B640255EF299B1880F8BA940F34F01D323D14EDF8EB36D76EBF74043BF4F7813CAC7486D663B0B";
  var_1 = var_1 | var_0 == "_encstr_8EF923721BF8EB8518812F195930CE471656FBDBC144ABF120930BE85349D45731080272AA";
  return var_1;
}

allow_forward_factor(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_6 = "_encstr_8B1608EC43B8D647A113";
  var_7 = 0;

  if(var_0.type == "_encstr_95D0174C277D9CAC5D37B0263659AF63EDED8EFA6C0BD8A156") {
    if(!isDefined(var_0.intel_collected))
      var_0.intel_collected = 0;

    var_7 = var_0.intel_collected;
  }

  if(isDefined(var_0._id_12F7F)) {
    if(isDefined(var_0._id_12F80))
      var_8 = verifybunkercode(var_0._id_12F7F, var_0._id_12F80);
    else
      var_8 = verifybunkercode(var_0._id_12F7F);

    var_8 = scripts\engine\utility::array_randomize(var_8);
    var_6 = "_encstr_914E0CA313E37352BC4FDAF72037";
  } else if(allow_earthquake(var_0.type) && isDefined(level.playerwaittospawn)) {
    var_8 = [[level.playerwaittospawn]](var_0, var_3);
    var_6 = "_encstr_B1730A035069980A136687FF";
  } else
    var_8 = pickscriptablelootitem(var_0, var_7);

  var_9 = 0;

  if(isDefined(var_8))
    var_9 = var_8.size;

  logstring("_encstr_918C1C7D1BDEB73AD0851BD0B2AAB956464DE02CBBB982D2D8B6EAC1CD40" + var_0.type + "_encstr_974C0246" + var_6 + "_encstr_B8200D40DC561D25DC32CAC308E940" + var_7 + "_encstr_ABA7100896A3CADAB971C6F6579BA3409E08" + var_9);

  if(isDefined(var_8))
    var_8 = _id_11A1A(var_8, var_3);

  if(isDefined(var_8) && var_3 scripts\mp\utility\perk::_hasperk("_encstr_A525253BC72DCE64888D531381EE1B39A7581BF2D0612790AD2867E108076FA8B6096323CDA015"))
    var_8 = _id_11A1D(var_8, var_3);

  var_8 = _id_11A1E(var_8, var_3);

  if(isDefined(var_8)) {
    if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8AE1099A0B999F2D28AF15" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_9B1F05BE4B9B52" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_866209ECEDB1197DEE0B4E") {
      if(scripts\mp\flags::gameflag("_encstr_BA261AC1365836CA5BB29B477DAE838CB08E2B9BD7B06363DBEE598C")) {
        var_10 = game["_encstr_85920F9B354B5AC018902F3FD811A69307"][var_3.team];

        if(!isDefined(level.lootchopper_initspawninfo))
          _encstr_913B2988662341C84372B58BE2A089BB0F17B36823076860A92B6117F1D5CB9117C357A7302B206E4F43AE::freefallfromplanestatemachine();

        var_11 = 100 - 100 * var_10 / level.lootchopper_initspawninfo;

        if(isDefined(level.debug_kill_tromeo) && var_11 < level.debug_kill_tromeo)
          var_8 = _id_11A1B(var_0, var_8);
        else if(isDefined(level._id_13BDF) && var_11 > level._id_13BDF)
          var_8 = _id_11A1C(var_0, var_8);
      }
    }

    if(isDefined(level._id_11B50))
      var_8 = _id_11A19(var_8);

    if(var_0.type != "_encstr_95D0174C277D9CAC5D37B0263659AF63EDED8EFA6C0BD8A156")
      var_7 = undefined;

    if(var_0.type == "_encstr_AA5F12F2B6663B5D5FD8815A689F54D7DE1A7765") {
      if(isDefined(var_0._id_12F80))
        var_7 = var_0._id_12F80 % 3;

      wait 0.7;
    }

    if(isDefined(var_0.type) && var_0.type == "_encstr_8E0114B5E6B9D0CF40C4293F21FF4AB13730A0FFCB2D") {
      var_12 = ["_encstr_A70708DF6DCAB0B8BF17", "_encstr_A307088717F8DDDD407F", "_encstr_930708BF0DAAD0D8DF57", "_encstr_9107083785324850579F", "_encstr_8F0708D09B1239386FD5", "_encstr_B80708569588A8800563", "_encstr_AC07087767838DC0AD0B", "_encstr_BE07082645E74367A0D2", "_encstr_8E0708864DF7B39F1DDF", "_encstr_9375099857F3F3A7A2227F"];
      var_13 = var_3 getplayerdata(level.loadoutsgroup, "_encstr_AC3B17D8AEE6D1F6D696D3581DD27B9B230BB3BDC9A58ECA37", "_encstr_9951158731A87733BBE197CB2F579ABF683BF40D095818");

      if(!isDefined(var_13))
        var_13 = randomint(var_12.size);

      var_13 = var_12[var_13];
      var_14 = var_3 thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_encstr_A7321A10206B3779A25B8D31E94F6753A2F25BEDD07F5D100E4C8723(var_13);
      var_15 = var_3 _encstr_8E741E1082AD91113FE6B525CE7BDB03D79A88801A07EFEB8B07352FC86F20EF(var_14);

      foreach(var_17 in var_15)
      var_8[var_8.size] = var_17;
    }

    var_5 = var_0 _id_11A02(var_8, var_7);
  } else {
    var_19 = (0, 0, 0);
    var_20 = "_encstr_AC8824675030B42A3FDD392A4DE1E1430120EBCF9111FF42517D7DE3AE8F6A09EB887A6F98EB";

    if(getdvarint("_encstr_9383157EAB0326154A29E888B329D3F8B35590FE01BF88", 0))
      var_20 = "_encstr_A98E293870FE5A452FDDB7269805FF86E36FE4D1893E7AAB104FCD53EF997243E382AF48899A80A2F66353";
    else if(getdvarint("_encstr_BE8413F37E20A8AEF56E810BC337E1E001403E6F7A", 0))
      var_20 = "_encstr_825627B583BCB17BDBD1FAB92B8EF51B0B1B4356AFC6BDCD472BCD1DDCAF98B0CD95F53B3B178DB9CE";
    else if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8AE1099A0B999F2D28AF15" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_9B1F05BE4B9B52" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_866209ECEDB1197DEE0B4E") {
      var_19 = (0, 45, 0);

      if(var_0.type == "_encstr_912213069327B01747A37913EA7E6C40AF691DDC1D")
        var_20 = "_encstr_A25137E7B1D88A2738B3E1F289B84F32472F7B5F071662EEC8F9A53B6309B4EA2C4B1FD3FBC229DF93801B857931D46276C17F6B6F40128308";
      else if(var_0.type == "_encstr_B4D90E9636AFD277F08057BF3029380A")
        var_20 = "_encstr_ADC93740F2DF90400AD3B7F78F638020298E68D951FBD088937FDDF1FFB95E88D2E73671453A99348B6F13FDDB81A5C09A3DF90B6AC61BF6E3";
    }

    var_21 = var_0 chooseandspawnitems(2, 1, "_encstr_AC20072B9FA9487832", var_20, var_19);
    var_5[var_5.size] = var_21[0];
    var_21 = var_0 chooseandspawnitems(0, 1, "_encstr_B483058670B0B7", var_20, var_19);
    var_5[var_5.size] = var_21[0];
    var_21 = var_0 chooseandspawnitems(0, 1, undefined, var_20, var_19);
    var_5[var_5.size] = var_21[0];
    var_21 = var_0 chooseandspawnitems(0, 1, undefined, var_20, var_19);
    var_5[var_5.size] = var_21[0];
    var_21 = var_0 chooseandspawnitems(2, 1, "_encstr_83A20883C6EA378C2B93", var_20, var_19);
    var_5[var_5.size] = var_21[0];
    var_0 setscriptablepartstate(var_1, "_encstr_ADB405071B8AE8");
  }

  if(getdvarint("_encstr_8CBE155E3EC35FB3A85770B0C7D86B757963D8EA17DACF", 0)) {
    var_22 = getdvarfloat("_encstr_92F020CD8DE4EB8993FAA13BB3FA1DB7B52B73EB368616CD3695F5ED37FA8DEDDBE8", 0.5);

    if(randomfloat(1.0) < var_22) {
      var_23 = anglestoleft(var_0.angles);
      _encstr_8F9B2D92FEB5C228D3F8D6C7F860F78A7305DB88DF333B0F79D81FE798ADADA3F3276789C879D29A2010CF3A90BB63::_encstr_96D316F2C05717CDC30DADC87D24F8EB830730CD9F431120(var_0.origin + 50 * var_23, var_0.angles, undefined, var_0.origin);
    }
  }

  var_24 = "_encstr_AF3A063777C2C3D0";

  switch (var_0.type) {
    case "_encstr_969713904BDFF0B373B9DFE50F7BA9DE4B9F10B87F":
    case "_encstr_82041F5B33C987F7C173ADC0F127063F69DB7FAB99A93BD7077328A9C990F4DAB3":
    case "_encstr_A5C319C1EEC143F98215FA35104F131F39F5B9CA1337EE1E828BC8":
      var_24 = "_encstr_9B49104F1720FB37B95AA643CCCF8327FB15";
      break;
    case "_encstr_875F1239530F5910BD14E79729E67095670B1003":
    case "_encstr_BA2116BE6BD94CEAA0F9778F3B5E62BD31F3F787017B0773":
    case "_encstr_AADE1A09DA1728F8A28BDFAFF74AB3B8FFF791A3C39590A54BD78599":
    case "_encstr_912213069327B01747A37913EA7E6C40AF691DDC1D":
      var_24 = "_encstr_84CA10D2E827C44F3EF9ADA7056033CE6DB0";
      break;
    case "_encstr_879916BDB389CCA8E15739D371C11075E3334FC797120360":
      var_24 = "_encstr_BDB512303AF6E1994727F5FB3FF7239F9B8238F0";
      break;
    case "_encstr_95D0174C277D9CAC5D37B0263659AF63EDED8EFA6C0BD8A156":
      var_0 thread heli_flyloop(var_1);
      break;
    case "_encstr_8E0114B5E6B9D0CF40C4293F21FF4AB13730A0FFCB2D":
      var_24 = "_encstr_B6780CD82C36A156D739DB3BABB2";
      break;
  }

  if(_encstr_A68B30E6D8392DE08EE6E55B83BCECB0B6568E2F832B37BC31C9BE0E57C46396C6563BCACD47FA4EB2E61DBDB16DC5B3CD1B::use_dropkit_marker())
    var_0 _encstr_A68B30E6D8392DE08EE6E55B83BCECB0B6568E2F832B37BC31C9BE0E57C46396C6563BCACD47FA4EB2E61DBDB16DC5B3CD1B::_id_12CC0();

  foreach(var_26 in var_5) {
    if(isDefined(var_26))
      var_26._id_11A40 = var_24;
  }
}

_id_11A1B(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_1) {
    if(issubstr(var_4, "_encstr_AF860FF0BBC3C727F90E5B05F0F599BB60")) {
      if(var_0.type == "_encstr_912213069327B01747A37913EA7E6C40AF691DDC1D") {
        if(var_4 != "_encstr_A14F2021F21C08C03BFF69494F429D90BA0189D9DA70D10902F74B4523DADEC87F72" && scripts\engine\utility::cointoss())
          var_4 = "_encstr_A14F2021F21C08C03BFF69494F429D90BA0189D9DA70D10902F74B4523DADEC87F72";
      } else if(var_4 != "_encstr_B8F81BDDD3DAA8585CF93BB01B3E78D553FF57637F4278C0704C41AED2" && scripts\engine\utility::cointoss())
        var_4 = "_encstr_B8F81BDDD3DAA8585CF93BB01B3E78D553FF57637F4278C0704C41AED2";
    }

    var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_11A1C(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_1) {
    if(issubstr(var_4, "_encstr_AF860FF0BBC3C727F90E5B05F0F599BB60")) {
      if(var_0.type == "_encstr_912213069327B01747A37913EA7E6C40AF691DDC1D") {
        if((var_4 == "_encstr_B8F81BDDD3DAA8585CF93BB01B3E78D553FF57637F4278C0704C41AED2" || var_4 == "_encstr_A14F2021F21C08C03BFF69494F429D90BA0189D9DA70D10902F74B4523DADEC87F72") && scripts\engine\utility::cointoss())
          var_4 = "_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926";
      } else if((var_4 == "_encstr_B8F81BDDD3DAA8585CF93BB01B3E78D553FF57637F4278C0704C41AED2" || var_4 == "_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926") && scripts\engine\utility::cointoss())
        var_4 = "_encstr_BE611B23BDD940EF98B99AEBEB609FBD08A61B6FC363217A878B888FA3";
    }

    var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_11A19(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3 != "_encstr_8BAD176296FDB2C083198F6B51BB0768570F468668DF258AA4") {
      var_1[var_1.size] = var_3;
      continue;
    }

    if(level._id_11B50 > level.armoryswitches) {
      var_1[var_1.size] = var_3;
      level.armoryswitches++;
    }
  }

  return var_1;
}

chooseandspawnitems(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];
  var_7 = 0;

  if(!isDefined(var_2))
    var_2 = "_encstr_B40101";

  if(!isDefined(var_0))
    var_0 = 0;

  var_8 = "_encstr_AC8824675030B42A3FDD392A4DE1E1430120EBCF9111FF42517D7DE3AE8F6A09EB887A6F98EB";

  if(isDefined(var_3))
    var_8 = var_3;

  var_9 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();

  for(var_10 = 0; var_10 < var_1; var_10++) {
    if(!isDefined(var_5))
      var_5 = 0;

    var_11 = registerscriptedspawnpoints(var_2, var_0, var_5, var_8);

    if(var_11 == "_encstr_B40101") {
      continue;
    }
    if(get_bonus_targets(var_11)) {
      var_12 = self.angles;

      if(isDefined(var_4))
        var_12 = var_12 + var_4;

      var_13 = level.br_pickups.delay_hide_player_clip[var_11];

      if(isDefined(var_13) && var_13 == 4 && var_7 == 0) {
        var_6[var_6.size] = _id_11A41(var_11, var_9, self.origin, var_12, undefined, 1);
        self.itemsdropped++;
        var_7 = 1;
      } else {
        var_6[var_6.size] = _id_11A41(var_11, var_9, self.origin, var_12, undefined, 0);
        self.itemsdropped++;
      }
    }
  }

  return var_6;
}

_id_11A1D(var_0, var_1) {
  if(!isDefined(var_1.display_hint_forced))
    var_1.display_hint_forced = 10;

  var_2 = 0;

  foreach(var_5, var_4 in var_0) {
    if(issubstr(var_4, "_encstr_85CE0B9770B02C73A1760F06D2")) {
      var_2 = 1;
      break;
    }
  }

  if(!var_2) {
    if(randomint(100) < var_1.display_hint_forced) {
      if(!isDefined(level.vip_info))
        level.vip_info = 0;
      else
        level.vip_info = randomint(25);

      var_6 = verifybunkercode("_encstr_93E8106B4B704B2E21E0723A290D650FCBAD", level.vip_info);

      foreach(var_8 in var_6)
      var_0[var_0.size] = var_8;

      var_1.display_hint_forced = 10;
    } else
      var_1.display_hint_forced = var_1.display_hint_forced + 15;
  }

  return var_0;
}

_id_11A1A(var_0, var_1) {
  foreach(var_3 in level.dummy_backpack) {
    if(var_3._id_1289A > randomfloat(1.0))
      var_0[var_0.size] = var_3.name;
  }

  return var_0;
}

_id_11A1E(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  var_2 = getdvarfloat("_encstr_BD901B13A7F0B1E3569E7B4223A033F72877B98C2DA0C2E3E853537AE9", 0.8);

  if(randomfloat(1.0) < var_2 && !vehicle_collision_takedamage(var_0)) {
    if(!var_1 _id_1373A())
      var_0[var_0.size] = "_encstr_A7201F9A1D9825BF3DE613DA8B18AB1FC0DF13E177E0611FE899FAF290E0CB5922";
  }

  return var_0;
}

vehicle_collision_takedamage(var_0) {
  if(!isDefined(var_0))
    return 0;

  foreach(var_2 in var_0) {
    if(issubstr(var_2, "_encstr_AF860FF0BBC3C727F90E5B05F0F599BB60"))
      return 1;
  }

  return 0;
}

_id_1373A() {
  var_0 = self;

  if(!isalive(var_0))
    return 0;

  var_1 = 0;
  var_2 = 0;
  var_3 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0.team, var_0.squadindex);

  foreach(var_5 in var_3) {
    if(var_5 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::unlockscriptabledoors()) {
      var_2 = 1;
      continue;
    }

    if(isDefined(var_5.plundercount))
      var_1 = var_1 + var_5.plundercount;
  }

  var_7 = level.br_armory_kiosk._id_13AC3;
  var_8 = var_0 scripts\mp\utility\perk::_hasperk("_encstr_AF321BC3970127FC63F8D31B79BDF21F39735D492FA93B091FF86AB330");
  var_9 = level.br_armory_kiosk._id_13AC4;

  if(!isDefined(var_9))
    var_9 = 0;

  var_10 = _encstr_8E99299B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB090263F1DFE25007B391C7A0843A14A3C2::ai_push_to_position(undefined, level.br_armory_kiosk._id_13AC2, 0, var_7, var_8, var_9);

  if(var_2 && isDefined(var_10) && var_1 < var_10)
    return 0;

  return 1;
}

_id_119FF() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
  var_0 = getlootscriptablearrayinradius("_encstr_912213069327B01747A37913EA7E6C40AF691DDC1D");

  if(isDefined(var_0))
    level.dummy_hint = var_0;
}

_encstr_8E741E1082AD91113FE6B525CE7BDB03D79A88801A07EFEB8B07352FC86F20EF(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = [];
  var_1[var_1.size] = var_0.loadoutprimaryobject;
  var_1[var_1.size] = var_0.loadoutsecondaryobject;
  return var_1;
}