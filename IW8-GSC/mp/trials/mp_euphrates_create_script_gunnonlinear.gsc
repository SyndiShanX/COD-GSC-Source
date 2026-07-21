/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\trials\mp_euphrates_create_script_gunnonlinear.gsc
*****************************************************************/

_id_134A3(var_0) {
  self.spec = "_encstr_939A09C2278AE93BD9A339" + getsubstr(self.agent_type, 12);
  self allowedstances("_encstr_A5AD069B231F0BAF", "_encstr_B13D076BED70539F23");
  self.dontmeleeme = 1;
  self.aggressivemode = 1;
  self.ignoresuppression = 1;
  self.disablepistol = 1;
  self.meleetryhard = 0;
  self.meleeignorefinalzdiff = 0;
  self.meleeignoreplayerstance = 1;
  self.dontsyncmelee = 1;
  self.disablebulletwhizbyreaction = 1;
  self.neversprintforvariation = 1;
  self.disabledodge = 1;
  self.disablelmgmount = 1;
  self.brking_getcirclepercentmoved = 1;
  self.combat_func_active = 1;
  self.clear_kill_off_flags_after_unload = 1;
  self.minpaindamage = 200;
  self.meleechargedistvsplayer = 120;
  self.meleechargedist = 120;
  self.meleemaxzdiff = 500;
  self.meleetargetallowedoffmeshdistsq = squared(50);
  self._id_11BBF = 0.5;
  self.pathenemyfightdist = 192;
  self.runngun = 0;
  self.eliminate_drone_minigun_speed = 2000;
  self.eliminate_drone_internal = 100;
  self._id_11E7E = 0;
  self._id_1216E = squared(730);
  self.meleebashmaxdistsq = squared(90);
  self.inside_bush = 0;

  if(getdvarint("_encstr_B1921BDC8DC9F558A57DD8DDD726C97DD8B767959C7D95371689D859C8", 0) == 1)
    self.combatmode = "_encstr_B68E06D8F6B3CA27";
  else
    self.combatmode = "_encstr_821109FAE81117DA568730";

  if(self.spec == "_encstr_91181243A212272C1120DF82BBE9A253367D3B27") {
    self.disable_bomb_detonator_interactivity = 1;
    self.combatmode = "_encstr_821109FAE81117DA568730";
    self._id_11EBE = 1;
    self allowedstances("_encstr_A5AD069B231F0BAF");
    self.dontmelee = 1;
  }

  self.fnshouldplaypainanim = ::_id_134BA;
  self.playerenemypool = ::_id_13497;

  if(isDefined(self.a))
    self.a.disablelongdeath = 0;

  scripts\engine\utility::set_movement_speed(120);
  _id_1328A();

  if(!threatbiasgroupexists("_encstr_87E80E37DE63915AB2E4BED8EEF59893")) {
    createthreatbiasgroup("_encstr_87E80E37DE63915AB2E4BED8EEF59893");
    setignoremegroup("_encstr_849C0E9130898B0EE380AF2867D8882A", "_encstr_87E80E37DE63915AB2E4BED8EEF59893");
  }

  self setthreatbiasgroup("_encstr_87E80E37DE63915AB2E4BED8EEF59893");
  self disableexecutionvictim();
  self _meth_87BC(gettime() + randomintrange(1000, 2000));

  if(self isscriptable())
    thread initscriptable();
}

_id_1328A() {
  var_0 = "_encstr_AF510F2DBB83EBC2E47D0BB696C6B743E6";

  if(self.spec == "_encstr_87E80E37DE63915AB2E4BED8EEF59893") {
    if(0)
      var_0 = "_encstr_A52C0E7020307103407898128DC7C6CB";
  } else if(self.spec == "_encstr_91181243A212272C1120DF82BBE9A253367D3B27")
    var_0 = "_encstr_BA090ED4634AD742CFC7BBABA36F5A77";

  var_1 = scripts\mp\class::buildweapon(var_0);
  self.weapon = var_1;
  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
}

_id_134B4(var_0) {
  level notify("_encstr_BDAF0E16DCF52B73955B2FFAE60DED47", self);
  self.a.lastshoottime = gettime();
  _id_134AF();
  self notify("_encstr_938C091AC8B8AFFB036D37");

  if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::isasniper() && istrue(self._blackboard.shootparams_valid) && isDefined(self._blackboard.shootparams_pos))
    self shoot(1, self._blackboard.shootparams_pos, 1, 0, 1);
  else {
    if(isagent(self))
      var_0 = 1;

    self shoot(1, undefined, var_0);
  }
}

_id_134AF() {
  if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::isasniper() && isalive(self.enemy)) {
    _id_134B2();
    return;
  }

  if(isPlayer(self.enemy)) {
    scripts\common\gameskill::resetmissdebouncetime();

    if(self.a.misstime > gettime()) {
      self.accuracy = 0;
      return;
    }
  }

  if(isDefined(self.script) && self.script == "_encstr_ACA20538F84D39") {
    if(scripts\engine\utility::actor_is3d() && isDefined(self._blackboard.lastusednode) && (self._blackboard.lastusednode.type == "_encstr_87820B3588934FE3ED137AEA7B" || self._blackboard.lastusednode.type == "_encstr_926B08AB070DD449229D"))
      self.accuracy = self.baseaccuracy;
    else if(_encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::iscqbwalkingorfacingenemy())
      self.accuracy = anim.walk_accuracy * self.baseaccuracy;
    else
      self.accuracy = anim.run_accuracy * self.baseaccuracy;

    return;
  }

  self.accuracy = self.baseaccuracy;

  if(isDefined(self.isrambo) && isDefined(self.ramboaccuracymult))
    self.accuracy = self.accuracy * self.ramboaccuracymult;
}

_id_134B2() {
  if(!isDefined(self.snipershotcount)) {
    self.snipershotcount = 0;
    self.sniperhitcount = 0;
  }

  var_0 = level.gameskill;

  if(!isDefined(self.sniperaccuracyset)) {
    self.sniperaccuracyset = 1;
    var_1 = level.difficultysettings["_encstr_8394146BC55002B71E05020AEB6DFFFF4027F3C169E8"][level.difficultytype[var_0]];
    self.baseaccuracy = self.accuracy * var_1;
  }

  self.snipershotcount++;

  if(scripts\common\gameskill::shouldforcesnipermissshot()) {
    self.accuracy = 0;

    if(var_0 > 0 || self.snipershotcount > 1)
      self.lastmissedenemy = self.enemy;

    return;
  }

  if(self.accuracy <= 10)
    self.accuracy = (1 + 1 * self.sniperhitcount) * self.baseaccuracy;

  self.sniperhitcount++;

  if(var_0 < 1 && self.sniperhitcount == 1)
    self.lastmissedenemy = undefined;
}

initscriptable() {
  self setscriptablepartstate("_encstr_91D412889743FAA31A374E7409E9D3052411270B", "_encstr_930B07BB1B6B3854FF", 0);
}

_id_134A5(var_0) {
  scripts\aitypes\combat_mp::initcombatfunctions_mp(var_0);
  self.minexposedgrenadedist = 450;
  anim.shootenemywrapper_func = ::_id_134B4;
  return anim.success;
}

_id_1349F(var_0, var_1) {
  if(!isDefined(self.grenadeweapon) || self.grenadeweapon.basename != var_0)
    self.grenadeweapon = getcompleteweaponname(var_0);

  self.grenadeammo = var_1;
}

_id_1349A() {
  if(self.ignoreall)
    return undefined;

  if(isDefined(self.favoriteenemy) && isalive(self.favoriteenemy) && self.favoriteenemy.notarget != 1)
    return self.favoriteenemy;

  if(isDefined(self.enemy) && self.enemy.notarget != 1)
    return self.enemy;

  return undefined;
}

_id_1349E() {
  if(scripts\mp\trials\mp_t_reflex_create_script_quadrace::_encstr_A938134BCF0540DA4A12771B26C7C04B5F11DFF20B())
    return "_encstr_8F7905C4AEC319";
  else
    return "_encstr_99F605EE16B1DA";
}

_id_134B1(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  self.set_disable_leave_truck = var_0;
}

_id_13496(var_0, var_1) {
  self._id_11E7E = gettime() + randomintrange(var_0, var_1);
}

_encstr_B61F1B737860AD7B2D68DFB6FAD04935CC754D1E39A8BFF4A39527A429(var_0) {
  if(var_0.select_mid_roof_spawners == 4) {
    self.inside_bush = self.inside_bush + 1;

    if(self._encstr_839D11F3F3150B4740134E1308789F72E02177.size <= self.inside_bush)
      self.inside_bush = 0;

    return self._encstr_839D11F3F3150B4740134E1308789F72E02177[self.inside_bush];
  } else
    return self._encstr_839D11F3F3150B4740134E1308789F72E02177[self.inside_bush];
}

_id_1349C(var_0) {
  var_1 = self.goalradius * 0.66;
  var_2 = [var_0.origin + (0.5, 0.5, 0) * var_1, var_0.origin + (0.5, -0.5, 0) * var_1, var_0.origin + (-0.5, 0.5, 0) * var_1, var_0.origin + (-0.5, -0.5, 0) * var_1];
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = getrandomnavpoint(var_5, var_1 * 0.5, self);

    if(isDefined(var_6))
      var_3[var_3.size] = var_6;
  }

  if(var_3.size > 0)
    return var_3[randomint(var_3.size)];

  var_6 = var_0 getpointinbounds(randomfloatrange(-1, 1), randomfloatrange(-1, 1), 0);
  return self getclosestreachablepointonnavmesh(var_6);
}

_id_1349B(var_0) {
  if(getdvarint("_encstr_B1921BDC8DC9F558A57DD8DDD726C97DD8B767959C7D95371689D859C8", 0) == 1) {
    if(isDefined(self.move_closest_chopper_boss_vandalize_node_down) && self.move_closest_chopper_boss_vandalize_node_down) {
      self clearbtgoal(0);
      self forceupdategoalpos();
      self.keepclaimednode = 0;
      self.keepclaimednodeifvalid = 0;
      var_1 = self findbestcoverlist();

      foreach(var_3 in var_1) {
        if(self usecovernode(var_3)) {
          var_0.select_mid_roof_spawners = 4;
          return var_3;
        }
      }
    }
  }

  var_5 = var_0.enemy;

  if(!isDefined(var_5)) {
    if(isDefined(var_0.select_mountain_three_spawners)) {
      var_0.select_mid_roof_spawners = 1;
      return _id_1349C(var_0.select_mountain_three_spawners);
    }

    var_0.select_mid_roof_spawners = 0;
    return self.origin;
  }

  if(isDefined(var_0.select_mountain_three_spawners) && !self iswithinscriptgoalRadius()) {
    var_0.select_mid_roof_spawners = 1;
    return _id_1349C(var_0.select_mountain_three_spawners);
  }

  var_6 = var_5.origin - self.origin;
  var_7 = length2d(var_6);
  var_8 = scripts\engine\utility::ter_op(var_7 > 400, (var_7 - 400) / 330, 0.0);
  var_8 = clamp(var_8, 0, 0.85);

  if(randomfloat(1.0) < var_8) {
    var_0.select_mid_roof_spawners = 3;
    return var_5.origin;
  }

  if(randomfloat(1.0) < 0.66) {
    var_9 = vectortoangles(var_6);
    var_10 = scripts\engine\utility::ter_op(randomfloat(1.0) > 0.5, 1.0, -1.0);
    var_11 = self.origin + anglestoright(var_9) * 150 * var_10;
    var_12 = getclosestpointonnavmesh(var_11, self);
    var_0.select_mid_roof_spawners = 2;
    return var_12;
  }

  var_0.select_mid_roof_spawners = 0;
  return self.origin;
}

_id_134A6(var_0) {
  scripts\aitypes\cover::inithidetimers();
}

_id_134BA() {
  if(!isDefined(self.a.paintime) || !isDefined(self.eliminate_drone_internal) || !isDefined(self.eliminate_drone_minigun_speed))
    return 1;

  if(gettime() - self.a.paintime < self.eliminate_drone_minigun_speed)
    return 0;

  return randomfloat(100) < self.eliminate_drone_internal;
}

_id_134B5(var_0) {
  if(!isDefined(self.enemy))
    return anim.success;

  return scripts\aitypes\combat::shoot_update(var_0);
}

_id_134A7(var_0) {
  if(!isDefined(self.weapon))
    return anim.failure;

  var_1 = scripts\aitypes\combat::shouldshoot();

  if(var_1) {
    var_2 = isDefined(self.enemy) && isDefined(self.enemy.vehicle) && isDefined(self.enemy.vehicle.vehiclename);

    if(var_2 && istrue(self.dontgiveuponsuppression) && isDefined(self.goodshootpos))
      return anim.success;

    var_1 = scripts\aitypes\combat::calcgoodshootpos();
  } else
    self.goodshootpos = undefined;

  if(!var_1)
    return anim.failure;

  return anim.success;
}

_id_134B7(var_0) {
  if(istrue(self.disable_bomb_detonator_interactivity))
    return 0;

  var_1 = _id_1349A();

  if(isDefined(var_1)) {
    if(!issentient(var_1))
      return 0;

    if(self lastknowntime(var_1) <= 0)
      return 0;
  }

  if(gettime() < self._id_11E7E)
    return 0;

  if(isDefined(self.melee)) {
    self.dmztut_endgame = gettime();
    return 0;
  }

  if(scripts\asm\asm_bb::bb_throwgrenaderequested())
    return 0;

  return 1;
}

_id_13492(var_0) {
  var_1 = _id_1349A();
  var_2 = spawnStruct();
  var_2.enemy = var_1;
  var_2._id_11E71 = 0;
  var_2.select_mountain_three_spawners = self getgoalvolume();
  var_2.select_mid_roof_spawners = 0;

  if(isDefined(self._id_12EAF)) {
    var_2.goalpos = self._id_12EAF;
    self setbtgoalpos(0, var_2.goalpos);
    self._id_12EAF = undefined;
  }

  self aisettargetspeed(120);
  scripts\engine\utility::set_movement_speed(120);
  self.bt.instancedata[var_0] = var_2;
}

_id_13491(var_0) {
  var_1 = self.bt.instancedata[var_0];
  var_1.select_mountain_three_spawners = self getgoalvolume();
  var_2 = _id_1349A();
  var_3 = isDefined(self.dmztut_endgame) && gettime() - self.dmztut_endgame < 1000;
  self clearbtgoal(2);

  if(var_3 || !isDefined(var_2)) {
    self setbtgoalpos(0, self.origin);
    self setbtgoalRadius(0, 35);
    var_1.select_mid_roof_spawners = 0;
    return anim.running;
  }

  var_4 = gettime();

  if(var_4 >= var_1._id_11E71) {
    var_5 = !(isDefined(var_2) && isDefined(var_1.enemy) && var_2 == var_1.enemy);
    var_1.enemy = var_2;

    if((var_5 || !self aipointinfov(var_2.origin)) && var_1.select_mid_roof_spawners != 4) {
      _id_13496(2000, 3000);
      self setbtgoalpos(0, self.origin);
      var_1.select_mid_roof_spawners = 0;
      return anim.running;
    }

    var_6 = self pathdisttogoal();
    var_7 = (var_1.select_mid_roof_spawners == 2 || var_1.select_mid_roof_spawners == 4) && var_6 < 35;
    var_8 = var_1.select_mid_roof_spawners == 1 && var_6 < 35;

    if(var_7 || var_8) {
      var_1.select_mid_roof_spawners = 0;
      var_1.goalpos = self.origin;
      _id_13496(4000, 10000);
    }

    var_9 = var_1.select_mid_roof_spawners == 3 && var_6 <= 400;
    var_10 = var_1.select_mid_roof_spawners == 0 && var_4 >= self._id_11E7E;

    if(var_9 || var_10)
      var_1.goalpos = _id_1349B(var_1);

    var_1._id_11E71 = var_4 + 500;
  }

  var_11 = isDefined(var_2) && self cansee(var_2) && self canshootenemy(249, 1, 1);

  if(var_11)
    self getenemyinfo(var_2);

  var_12 = isDefined(var_2) && isDefined(var_2.vehicle) && isDefined(var_2.vehicle.vehiclename);

  if(var_12) {
    self.dontgiveuponsuppression = 1;
    self.goodshootpos = var_2 getshootatpos();
  } else
    self.dontgiveuponsuppression = 0;

  if(!isDefined(var_1.goalpos)) {
    var_1.goalpos = self.origin;
    var_1.select_mid_roof_spawners = 0;
  }

  if(var_1.select_mid_roof_spawners != 4) {
    if(!self iswithinscriptgoalRadius(var_1.goalpos)) {
      var_1.goalpos = self getplayerip(var_1.goalpos);
      var_1.goalpos = self getclosestreachablepointonnavmesh(var_1.goalpos);
    }

    self setbtgoalpos(0, var_1.goalpos);
  } else {
    self._id_11EBE = 1;
    self.keepclaimednode = 0;
    self.keepclaimednodeifvalid = 0;
    self usecovernode(var_1.goalpos, 0);
  }

  self aisettargetspeed(120);
  scripts\engine\utility::set_movement_speed(120);
  return anim.running;
}

_id_13493(var_0) {
  self.bt.instancedata[var_0] = undefined;

  if(scripts\asm\asm_bb::bb_throwgrenaderequested()) {
    self._id_12EAF = self.goalpos;
    self setbtgoalpos(0, self.origin);
  }

  self clearpath();
  scripts\common\utility::demeanor_override("_encstr_AA7C07466F9DA30713");
  self.moveplaybackrate = 1;
}

_id_13494(var_0) {}

_encstr_B19921486FBC411B9222189E3A6971A90CA32028F75C39E5ABCD0D91D443B1914E9770() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A52E1533E025BF19C5EE1EA2C307E367911830F92B23B7");
  self waittill("_encstr_B4580A0740984DFBF2C57BEB", var_0);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    switch (var_2.type) {
      case "_encstr_92FD082A30066B713094":
      case "_encstr_91CE0F3102DBEA5A50B550D0737DFA5FFA":
      case "_encstr_A5490D5E05C3F8B363F3C8D83B3E43":
      case "_encstr_860808CB78E2984063BA":
        self asmsetstate(self.asmname, "_encstr_A13D1083C2E839BDC6FAB9D185C91DC65623");
        return;
    }
  }
}

_id_134B9(var_0) {
  if(istrue(self.disable_bomb_detonator_interactivity))
    return 0;

  if(!isDefined(self getgoalvolume()))
    return 0;

  return 1;
}

_id_134AA(var_0) {
  var_1 = spawnStruct();
  var_1.select_mountain_three_spawners = self getgoalvolume();
  var_1.goalpos = self.origin;
  var_1.select_mid_roof_spawners = 0;

  if(!ispointinvolume(self getapproxeyepos(), var_1.select_mountain_three_spawners)) {
    var_1.goalpos = self getclosestreachablepointonnavmesh(var_1.select_mountain_three_spawners.origin);
    var_1._id_11E7C = var_1.goalpos;
    var_1.select_mid_roof_spawners = 1;
  }

  if(!scripts\mp\trials\mp_t_reflex_create_script_quadrace::_encstr_A938134BCF0540DA4A12771B26C7C04B5F11DFF20B())
    thread _encstr_B19921486FBC411B9222189E3A6971A90CA32028F75C39E5ABCD0D91D443B1914E9770();

  self.bt.instancedata[var_0] = var_1;
}

_encstr_A5D2216EDED8C8A55627F5C4C9F5665A73239B95F0D1E0C23A93DEC676F685D8C17BDC(var_0) {
  if(isDefined(self._encstr_839D11F3F3150B4740134E1308789F72E02177)) {
    var_0._id_11E7C = _encstr_B61F1B737860AD7B2D68DFB6FAD04935CC754D1E39A8BFF4A39527A429(var_0);
    var_0._encstr_8A570FC852E3C5C02D913107AC96600D67 = 4;

    if(!isDefined(var_0._id_11E7C)) {
      var_0._id_11E7C = _id_1349C(var_0.select_mountain_three_spawners);
      var_0._encstr_8A570FC852E3C5C02D913107AC96600D67 = 2;
    }
  } else {
    var_0._id_11E7C = _id_1349C(var_0.select_mountain_three_spawners);
    var_0._encstr_8A570FC852E3C5C02D913107AC96600D67 = 2;
  }
}

_id_134A9(var_0) {
  var_1 = self.bt.instancedata[var_0];
  var_2 = var_1.select_mid_roof_spawners;
  var_3 = _id_1349A();

  if(isDefined(var_3)) {
    _id_13496(2000, 3000);
    self setbtgoalpos(0, self.origin);
    self getenemyinfo(var_3);
    return anim.success;
  }

  var_4 = self pathdisttogoal();
  var_5 = var_2 == 1 && var_4 < 35;
  var_6 = (var_2 == 2 || var_1.select_mid_roof_spawners == 4) && var_4 <= 35;

  if(var_5 || var_6) {
    _encstr_A5D2216EDED8C8A55627F5C4C9F5665A73239B95F0D1E0C23A93DEC676F685D8C17BDC(var_1);

    if(var_2 == 2 || var_2 == 4) {
      _id_13496(4500, 10000);
      var_1.select_mid_roof_spawners = 0;
    }
  }

  if(isDefined(var_1._id_11E7C))
    self.smartfacingpos = var_1._id_11E7C;

  var_7 = var_1.select_mid_roof_spawners == 0 && gettime() > self._id_11E7E;

  if((var_5 || var_7) && isDefined(var_1._id_11E7C)) {
    var_1.goalpos = var_1._id_11E7C;
    var_1.select_mid_roof_spawners = var_1._encstr_8A570FC852E3C5C02D913107AC96600D67;
    var_1._id_11E7C = undefined;
    var_1._encstr_8A570FC852E3C5C02D913107AC96600D67 = undefined;
  } else if(var_7 && !isDefined(var_1._id_11E7C)) {
    _encstr_A5D2216EDED8C8A55627F5C4C9F5665A73239B95F0D1E0C23A93DEC676F685D8C17BDC(var_1);
    var_1.goalpos = var_1._id_11E7C;
    var_1.select_mid_roof_spawners = var_1._encstr_8A570FC852E3C5C02D913107AC96600D67;
    var_1._id_11E7C = undefined;
    var_1._encstr_8A570FC852E3C5C02D913107AC96600D67 = undefined;
  }

  if(var_1.select_mid_roof_spawners == 1 || var_1.select_mid_roof_spawners == 2 || var_1.select_mid_roof_spawners == 4)
    self setbtgoalpos(0, var_1.goalpos);
  else
    self setbtgoalpos(0, self.origin);

  self aisettargetspeed(120);
  scripts\engine\utility::set_movement_speed(120);
  return anim.running;
}

_id_134AB(var_0) {
  var_1 = self.bt.instancedata[var_0];
  self notify("_encstr_A52E1533E025BF19C5EE1EA2C307E367911830F92B23B7");

  if(isDefined(_id_1349A())) {
    if(scripts\asm\asm_bb::bb_throwgrenaderequested())
      self setbtgoalpos(0, self.origin);

    self._id_11E7E = 0;
  }

  self.bt.instancedata[var_0] = undefined;
}

_id_13495(var_0) {}

_id_134B0() {
  self.bt.getbunkernamefromkeypadscriptableinstance = gettime() + randomintrange(2000, 10000);
}

_id_134B6(var_0) {
  if(!isDefined(self.bt.getbunkernamefromkeypadscriptableinstance))
    _id_134B0();

  if(isDefined(self._id_11EBE)) {
    if(self.currentpose != "_encstr_A5AD069B231F0BAF")
      return anim.success;
    else
      return anim.failure;
  }

  if(self.currentpose != "_encstr_A5AD069B231F0BAF" && scripts\asm\asm_bb::bb_meleerequested())
    return anim.success;

  if(self pathdisttogoal() > self.goalradius)
    return anim.failure;

  if(gettime() < self.bt.getbunkernamefromkeypadscriptableinstance)
    return anim.failure;

  return anim.success;
}

_id_134A4(var_0) {
  var_1 = undefined;

  if(self.currentpose != "_encstr_B13D076BED70539F23" || scripts\asm\asm_bb::bb_getrequestedstance() != "_encstr_B13D076BED70539F23")
    var_1 = "_encstr_B13D076BED70539F23";
  else
    var_1 = "_encstr_A5AD069B231F0BAF";

  if(isDefined(self._id_11EBE))
    var_1 = "_encstr_A5AD069B231F0BAF";

  scripts\asm\asm_bb::bb_requeststance(var_1);
}

_id_13486(var_0) {
  if(scripts\asm\asm::asm_ephemeraleventfired("_encstr_8211132AE8581B0B7F02A3D9B85831E124335286A8", "_encstr_961804BD954A"))
    return anim.success;

  var_1 = 5000;

  if(gettime() - self.bt.getbunkernamefromkeypadscriptableinstance > var_1)
    return anim.success;

  if(self.currentpose == scripts\asm\asm_bb::bb_getrequestedstance())
    return anim.success;

  return anim.running;
}

_id_134BE(var_0) {
  scripts\asm\asm_bb::bb_requeststance(self.currentpose);
  _id_134B0();
}

_id_134C0(var_0) {
  scripts\asm\asm_bb::bb_requestthrowgrenade(1, self.enemy);
  self.bt.instancedata[var_0] = spawnStruct();
  self.bt.instancedata[var_0].timeout = gettime() + 6000;
}

_id_134C1(var_0) {
  scripts\asm\asm_bb::bb_requestthrowgrenade(0);
  self.bt.instancedata[var_0] = undefined;
  self.a.nextgrenadetrytime = gettime() + 3000;
}

_id_13485(var_0) {
  if(self.arriving)
    return anim.failure;

  if(nullweapon(self.grenadeweapon))
    return anim.failure;

  if(isDefined(self.playerpackdataintoomnvar)) {
    if(scripts\aitypes\throwgrenade::grenadethrowvaliditycheck(level.player, 200))
      return anim.success;
  }

  if(isDefined(self.enemy) && isDefined(self.enemy.dontgrenademe) && self.enemy.dontgrenademe)
    return anim.failure;

  if(istrue(self.dontevershoot))
    return anim.failure;

  if(isDefined(self.enemy) && scripts\aitypes\throwgrenade::grenadethrowvaliditycheck(self.enemy, self.minexposedgrenadedist))
    return anim.success;

  return anim.failure;
}

_id_13481(var_0) {
  var_1 = self getposoutsidebadplace(128.0);

  if(isDefined(var_1)) {
    self setbtgoalpos(2, var_1);
    self._blackboard.badplaceavoidstarttime = gettime();
    return anim.success;
  }

  return anim.failure;
}

_id_13482(var_0) {
  if(istrue(var_0.hasriotshield)) {
    var_1 = self.origin - var_0.origin;
    var_1 = vectorNormalize((var_1[0], var_1[1], 0));
    var_2 = anglesToForward(var_0.angles);
    var_3 = vectordot(var_2, var_1);

    if(!isDefined(var_0.riotshieldmodelstowed)) {
      if(var_3 > 0.766)
        return 1;
    } else if(var_3 < -0.766)
      return 1;
  }

  return 0;
}

_id_13497(var_0) {
  var_1 = undefined;

  if(istrue(self.clear_kill_off_flags_after_unload)) {
    var_2 = [];
    var_2[0] = self;
    var_3 = self getEye() - (0, 0, 16);
    var_4 = var_0 getEye() - (0, 0, 16);
    var_5 = scripts\engine\trace::sphere_trace(var_3, var_4, 4, var_2);

    if(var_5["_encstr_A53009A25003666B9818C6"] < 1) {
      var_6 = var_5["_encstr_850E077B0BF30318B9"];

      if(isDefined(var_6))
        var_1 = var_6;
    }
  } else if(isenemyinfrontofme(var_0, self._id_11BBF) || unset_force_aitype_rpg(var_0))
    var_1 = var_0;

  if(isDefined(var_1) && isalive(var_1)) {
    var_7 = 30;

    if(isDefined(self.meleedamageoverride))
      var_7 = self.meleedamageoverride;
    else if(nullweapon(self.weapon))
      var_7 = self.unarmedmeleedamageoverride;

    if(_id_13482(var_1))
      return undefined;

    if(isPlayer(var_1) && var_1 scripts\common\utility::isprotectedbyaxeblock(self))
      return undefined;

    var_1 dodamage(var_7, self.origin, self, self, "_encstr_8DED0A21C79B660BC7588981", self.weapon);
    return var_1;
  }

  return undefined;
}

isenemyinfrontofme(var_0, var_1) {
  var_2 = vectorNormalize((var_0.origin - self.origin) * (1, 1, 0));
  var_3 = anglesToForward(self.angles);
  var_4 = vectordot(var_2, var_3);
  return var_4 > var_1;
}

unset_force_aitype_rpg(var_0) {
  var_1 = self.origin[2] + self.height;

  if(var_0.origin[2] < var_1)
    return 0;

  var_2 = self.origin[2] + self.height + 2 * self.radius;

  if(var_0.origin[2] > var_2)
    return 0;

  if(isPlayer(var_0)) {
    var_3 = var_0 getvelocity()[2];

    if(abs(var_3) > 12)
      return 0;
  }

  var_4 = 15.0;

  if(isDefined(var_0.radius))
    var_4 = var_0.radius;

  var_5 = self.radius + var_4;
  var_5 = var_5 * var_5;

  if(distance2dsquared(self.origin, var_0.origin) > var_5)
    return 0;

  return 1;
}

_id_13498(var_0) {
  if(getdvarint("_encstr_88121B5F88DBC7BA4508F6EC102FD38103884B8FB8F13F43A33F3D6665", 0) == 0)
    return anim.failure;

  if(istrue(self.hasplayedvignetteanim))
    return anim.failure;

  return anim.running;
}

_id_13487(var_0) {
  if(!istrue(self.scripted_mode))
    return anim.failure;

  return anim.running;
}