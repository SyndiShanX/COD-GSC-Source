/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\equipment\snapshot_grenade.gsc
***********************************************/

snapshot_grenade_used(var_0, var_1) {
  var_0 thread scripts\mp\utility\script::notifyafterframeend("_encstr_AD75063D571AE108", "_encstr_BDF90C4D10A95F47E990CAF2D83B");
  var_0 endon("_encstr_BDF90C4D10A95F47E990CAF2D83B");

  if(var_1)
    var_0 waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_6, var_2, var_3, var_4, var_5);
  else {
    var_0 setotherent(self);
    var_0 thread scripts\mp\damage::monitordamage(19, "_encstr_A2FB098A2035874AB0F358", ::snapshot_grenade_handle_fatal_damage, ::snapshot_grenade_handle_damage);
    scripts\cp_mp\emp_debuff::add_emp_ent(var_0);
    var_0 scripts\cp_mp\emp_debuff::set_apply_emp_callback(::snapshot_grenade_empapplied);
    var_0 thread snapshot_grenade_watch_cleanup();
    var_0 waittill("_encstr_860808CB78E2984063BA", var_6);
  }

  thread snapshot_grenade_watch_flight(var_6);
}

snapshot_get_flight_dest(var_0, var_1, var_2) {
  var_1 = (0, 0, 1);
  var_3 = var_0 + var_1;
  var_4 = var_3 + var_1 * 137;
  var_5 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80"]);
  var_6 = physics_raycast(var_3, var_4, var_5, var_2, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

  if(isDefined(var_6) && var_6.size > 0) {
    var_4 = var_6[0]["_encstr_BD260953AA97E3F014279D"];

    if(1) {
      var_7 = vectordot(var_4 - var_3, var_1);

      if(var_7 > 0) {
        if(var_7 >= 50)
          var_7 = min(var_7 - 25, 112);
        else
          var_7 = var_7 / 2;

        var_4 = var_3 + var_1 * var_7;
      }
    }
  } else
    var_4 = var_3 + var_1 * 112;

  return var_4;
}

nukeplayer() {
  self endon("_encstr_AD75063D571AE108");
  self.velocity = (0, 0, 0);

  for(;;) {
    var_0 = self.origin;
    wait 0.05;
    self.velocity = 20.0 * (self.origin - var_0);
  }
}

snapshot_grenade_watch_flight(var_0) {
  var_1 = scripts\mp\utility\weapon::_launchgrenade("_encstr_AD1414DCDC1683CD34DB8EF53B272BE65832CAAFDA0E", var_0, (0, 0, 0), 100, 1);
  var_1 scripts\cp_mp\ent_manager::registerspawn(3, ::snapshot_grenade_delete);
  var_1 setotherent(self);
  var_1 setscriptablepartstate("_encstr_83380768EF1919AF8A", "_encstr_930B07BB1B6B3854FF", 0);
  var_1 setscriptablepartstate("_encstr_A3CD06BF48102D73", "_encstr_AD830746560EB17BCB", 0);
  var_1 missilehidetrail();
  var_1.owner = self;
  var_1 thread scripts\mp\damage::monitordamage(19, "_encstr_A2FB098A2035874AB0F358", ::snapshot_grenade_handle_fatal_damage, ::snapshot_grenade_handle_damage);
  scripts\cp_mp\emp_debuff::add_emp_ent(var_1);
  var_1 scripts\cp_mp\emp_debuff::set_apply_emp_callback(::snapshot_grenade_empapplied);
  var_1 thread snapshot_grenade_watch_cleanup();
  var_1 endon("_encstr_AD75063D571AE108");
  var_2 = scripts\mp\utility\weapon::_launchgrenade("_encstr_91291B6812AE1993A36735B847E3999D161A4081CAC66D294F82A8A948", var_1.origin, (0, 0, 0), 100, 1);
  var_2.weapon_name = "_encstr_91291B6812AE1993A36735B847E3999D161A4081CAC66D294F82A8A948";
  var_2 linkTo(var_1);
  var_2 hidefromplayer(self);
  var_1 thread snapshot_grenade_cleanup_danger_icon(var_2);
  var_3 = spawnStruct();
  var_3._id_133CA = 1;
  var_1 thread scripts\mp\movers::handle_moving_platforms(var_3);
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
  var_4.angles = var_1.angles;
  var_4 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1 linkTo(var_4, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  var_1 thread snapshot_grenade_cleanup_mover(var_4);
  waitframe();
  var_5 = undefined;

  if(istrue(var_1._id_13BFF))
    var_1 thread nukeplayer();

  var_6 = (0, 0, 1);
  var_7 = snapshot_get_flight_dest(var_0, var_6, [var_1, var_2]);
  var_8 = vectordot(var_7 - var_0, var_6);
  var_9 = (0, 0, 0);

  if(var_8 > 0) {
    var_10 = var_8 / 112;
    var_11 = 0.65 * var_10;
    var_12 = var_11 * 0.19;
    var_13 = var_11 * 0.6;
    var_14 = 0.3 * var_10;
    var_15 = var_11 * 0;
    var_16 = var_11 * 0.35;
    var_4 rotateTo(var_9, var_14, var_15, var_16);

    if(isDefined(var_1.wam_number_of_failures)) {
      var_5 = _calloutmarkerping_handleluinotify_enemyrepinged::trophy_tryreflectsnapshot(var_1.wam_number_of_failures);

      if(var_5)
        var_4 linkTo(var_1.wam_number_of_failures);
    }

    wait 0.3;

    if(istrue(var_5)) {
      var_4 unlink();
      var_7 = var_7 + var_1.velocity * var_11;
    }

    var_1 setscriptablepartstate("_encstr_A16605C8AB6E47", "_encstr_930B07BB1B6B3854FF", 0);
    var_1 setscriptablepartstate("_encstr_A3CD06BF48102D73", "_encstr_A7C5056BD931D1", 0);
    var_4 moveTo(var_7, var_11, var_12, var_13);
    var_1 childthread scripts\mp\utility\equipment::_id_14444();
    var_1 scripts\engine\utility::_id_143B9(var_11, "_encstr_8C4918EA30E953BC7023976EB7A844FB03AE53A259BD03755003");
  } else {
    var_4.angles = var_9;
    wait 0.3;
  }

  if(istrue(var_5))
    var_4 linkTo(var_1.wam_number_of_failures);

  var_17 = 0.0;
  wait(var_17);
  var_1 setscriptablepartstate("_encstr_95A107E3BB553A0BC0", "_encstr_930B07BB1B6B3854FF", 0);
  var_1 setscriptablepartstate("_encstr_A3CD06BF48102D73", "_encstr_A7C5056BD931D1", 0);
  var_1 setscriptablepartstate("_encstr_83380768EF1919AF8A", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  wait 0.5;
  var_1 snapshot_grenade_detect();
  var_1 thread snapshot_grenade_destroy();
}

snapshot_grenade_detect() {
  var_0 = self.owner;
  var_1 = self.origin;
  var_2 = self.angles;
  var_3 = _id_13436(var_0, var_1);
  var_4 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA"]);
  var_5 = scripts\mp\utility\game::unset_relic_grounded();
  var_6 = scripts\common\utility::playersinsphere(var_1, scripts\engine\utility::ter_op(var_5, 865, 540));
  var_7 = binocularsstate(var_1, scripts\engine\utility::ter_op(var_5, 865, 540));

  if(var_7.size)
    var_6 = scripts\engine\utility::array_combine(var_6, var_7);

  foreach(var_9 in var_6) {
    if(!scripts\mp\utility\player::isreallyalive(var_9)) {
      continue;
    }
    if(!scripts\cp_mp\utility\player_utility::playersareenemies(var_0, var_9)) {
      continue;
    }
    if(0) {
      var_10 = var_1;
      var_11 = var_9 getEye();
      var_12 = physics_raycast(var_10, var_11, var_4, undefined, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

      if(isDefined(var_12) && var_12.size > 0)
        continue;
    }

    _id_13435(var_9, var_0, var_3);
  }

  if(1)
    triggerportableradarping(var_1, var_0, scripts\engine\utility::ter_op(var_5, 865, 540), 500, "_encstr_83371CE0BB1D19A37A7D65EB9973E50150DF4088338F9073422350FB2B8B");
}

_id_13436(var_0, var_1) {
  var_2 = undefined;

  if(1) {
    var_2 = spawnStruct();
    var_2.owner = var_0;
    var_2.position = var_1;
    var_2.isalive = 1;
    var_2.targets = [];
    var_2.endtimes = [];
    var_2.outlineids = [];
  }

  return var_2;
}

_id_13435(var_0, var_1, var_2) {
  if(var_0 scripts\mp\utility\perk::_hasperk("_encstr_83371CE0BB1D19A37A7D65EB9973E50150DF4088338F9073422350FB2B8B")) {
    var_1 scripts\mp\damagefeedback::updatedamagefeedback("_encstr_8D760DB8F77343CF62BEB7E3D01013");
    return;
  }

  var_1 scripts\mp\damagefeedback::updatedamagefeedback("_encstr_B40101");

  if(1) {
    var_3 = scripts\mp\utility\game::unset_relic_grounded();
    var_4 = var_0 getentitynumber();
    var_2.targets[var_4] = var_0;
    var_2.endtimes[var_4] = gettime() + scripts\engine\utility::ter_op(var_3, 2000, 1250);

    if(!level.teambased)
      var_2.outlineids[var_4] = scripts\mp\utility\outline::outlineenableforplayer(var_0, var_1, "_encstr_851510A39042189B5C38D18F72E308667D7B", "_encstr_BE8F0A272F9B2BE97268AE8B");
    else if(isDefined(var_1.squadindex))
      var_2.outlineids[var_4] = scripts\mp\utility\outline::outlineenableforsquad(var_0, var_1.team, var_1.squadindex, "_encstr_851510A39042189B5C38D18F72E308667D7B", "_encstr_BE8F0A272F9B2BE97268AE8B");
    else
      var_2.outlineids[var_4] = scripts\mp\utility\outline::outlineenableforteam(var_0, var_1.team, "_encstr_851510A39042189B5C38D18F72E308667D7B", "_encstr_BE8F0A272F9B2BE97268AE8B");

    if(isPlayer(var_0) || isbot(var_0)) {
      var_0 scripts\mp\utility\outline::_hudoutlineviewmodelenable("_encstr_851510A39042189B5C38D18F72E308667D7B", 0);
      var_0 scripts\cp_mp\killstreaks\helper_drone::markeduion();
    }

    var_2 thread snapshot_grenade_update_outlines();
  }

  if(0)
    var_1 thread snapshot_grenade_create_marker(var_0 gettagorigin("_encstr_813B0D4027B390B37585BBC819FD28"), var_0.angles, var_0);

  var_0.lastsnapshotgrenadetime = gettime();
  var_1 scripts\mp\damage::combatrecordtacticalstat("_encstr_A15317C13205384F894F55535B939BC0BC0109BB5F76200D02");
  var_1 scripts\mp\utility\stats::incpersstat("_encstr_A5910DC36001AB5F38D063F487B53F", 1);
}

snapshot_grenade_destroy() {
  self setscriptablepartstate("_encstr_AFCB082AC1D6A3EA7B73", "_encstr_930B07BB1B6B3854FF", 0);
  self setscriptablepartstate("_encstr_83380768EF1919AF8A", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_A16605C8AB6E47", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_95A107E3BB553A0BC0", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_A3CD06BF48102D73", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self missilehidetrail();
  thread snapshot_grenade_delete(0.35);
}

snapshot_grenade_delete(var_0) {
  self notify("_encstr_AD75063D571AE108");
  scripts\cp_mp\ent_manager::deregisterspawn();
  self endon("_encstr_AD75063D571AE108");
  self.exploding = 1;
  self setCanDamage(0);

  if(isDefined(var_0))
    wait(var_0);

  self delete();
}

snapshot_grenade_handle_damage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;

  if(scripts\engine\utility::isbulletdamage(var_3)) {
    if(isDefined(var_2)) {
      var_6 = 1;

      if(var_4 >= scripts\mp\weapons::minegettwohitthreshold())
        var_6 = var_6 + 1;

      if(scripts\mp\utility\damage::isfmjdamage(var_2, var_3, 1))
        var_6 = var_6 * 2;

      var_4 = var_6 * 19;
    }
  }

  scripts\mp\weapons::equipmenthit(self.owner, var_1, var_2, var_3);
  return var_4;
}

snapshot_grenade_handle_fatal_damage(var_0) {
  var_1 = var_0.attacker;

  if(isDefined(var_1) && scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_1)) {
    var_1 notify("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");
    var_1 scripts\mp\killstreaks\killstreaks::givescoreforequipment(self, var_0.objweapon);
  }

  thread snapshot_grenade_destroy();
}

snapshot_grenade_empapplied(var_0) {
  if(!isDefined(self.owner)) {
    return;
  }
  var_1 = var_0.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_1))) {
    var_1 notify("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");
    var_1 scripts\mp\killstreaks\killstreaks::givescoreforequipment(self);
  }

  if(isPlayer(var_1))
    var_1 scripts\mp\damagefeedback::updatedamagefeedback("_encstr_B40101");

  thread snapshot_grenade_destroy();
}

snapshot_grenade_watch_cleanup() {
  self endon("_encstr_AD75063D571AE108");
  snapshot_grenade_watch_cleanup_end_early();

  if(isDefined(self))
    thread snapshot_grenade_destroy();
}

snapshot_grenade_watch_cleanup_end_early() {
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.owner endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self.owner endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;)
    waitframe();
}

snapshot_grenade_cleanup_mover(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_AD75063D571AE108");
  wait 1;
  var_0 delete();
}

snapshot_grenade_cleanup_danger_icon(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_AD75063D571AE108");
  var_0 delete();
}

snapshot_grenade_update_outlines() {
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self.owner endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self.owner endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!istrue(self.isalive)) {
    return;
  }
  self notify("_encstr_BD3107D507320BA356");
  self endon("_encstr_BD3107D507320BA356");
  thread snapshot_grenade_watch_cleanup_outlines();

  while(self.targets.size > 0) {
    foreach(var_4, var_1 in self.targets) {
      var_1 = self.targets[var_4];
      var_2 = self.endtimes[var_4];
      var_3 = self.outlineids[var_4];

      if(!isDefined(var_1) || !scripts\mp\utility\player::isreallyalive(var_1) || gettime() >= var_2) {
        scripts\mp\utility\outline::outlinedisable(var_3, var_1);

        if(isDefined(var_1) && (isPlayer(var_1) || isbot(var_1)))
          var_1 scripts\mp\utility\outline::_hudoutlineviewmodeldisable();

        self.targets[var_4] = undefined;
        self.endtimes[var_4] = undefined;
        self.outlineids[var_4] = undefined;
      }
    }

    waitframe();
  }

  thread snapshot_grenade_clear_outlines();
}

snapshot_grenade_watch_cleanup_outlines() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BD3107D507320BA356");
  snapshot_grenade_watch_cleanup_outlines_end_early();
  thread snapshot_grenade_clear_outlines();
}

snapshot_grenade_watch_cleanup_outlines_end_early() {
  self.owner endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self.owner endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self.owner endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;)
    waitframe();
}

snapshot_grenade_clear_outlines() {
  self notify("_encstr_AD75063D571AE108");
  self.isalive = 0;

  foreach(var_3, var_1 in self.targets) {
    var_1 = self.targets[var_3];
    var_2 = self.outlineids[var_3];
    scripts\mp\utility\outline::outlinedisable(var_2, var_1);

    if(isDefined(var_1) && (isPlayer(var_1) || isbot(var_1)))
      var_1 scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
  }
}

snapshot_grenade_create_marker(var_0, var_1, var_2) {
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_3.angles = var_1;

  if(isDefined(var_2) && 1)
    var_3 linkTo(var_2);

  var_3 setModel("_encstr_887D1995B8EAA583AF9BCD1607CDD0BDA3F5AD0B39AD2B39F5DA07");
  var_3 setotherent(self);
  var_3 setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_930B07BB1B6B3854FF", 0);
  var_3 snapshot_grenade_watch_marker_end_early(self, 3000, var_2, 1250);

  if(isDefined(var_3))
    var_3 delete();
}

snapshot_grenade_watch_marker_end_early(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_4 = gettime() + var_1;
  var_5 = scripts\engine\utility::ter_op(1, gettime() + 1250, undefined);

  while(var_4 > gettime()) {
    if(isDefined(var_5)) {
      if(var_5 < gettime()) {
        self unlink();
        var_5 = undefined;
      } else if(!isDefined(var_2)) {
        self unlink();
        var_5 = undefined;
      } else if(!scripts\mp\utility\player::isreallyalive(var_2)) {
        self unlink();
        var_5 = undefined;
      }
    }

    waitframe();
  }
}

binocularsstate(var_0, var_1) {
  var_2 = binocularsstruct(var_0, var_1);
  var_3 = [];
  var_4 = var_1 * var_1;

  foreach(var_6 in var_2) {
    var_7 = distancesquared(var_6.origin, var_0);

    if(var_7 < var_4)
      var_3[var_3.size] = var_6;
  }

  return var_3;
}

binocularsstruct(var_0, var_1) {
  var_2 = physics_createcontents(["_encstr_B2741680E3403FEBF1A319E7C24393FD73AB51792F157763"]);
  var_3 = (var_1, var_1, var_1);
  var_4 = var_0 - var_3;
  var_5 = var_0 + var_3;
  var_6 = physics_aabbbroadphasequery(var_4, var_5, var_2, []);
  return var_6;
}

removespawnselections() {
  return 3000;
}