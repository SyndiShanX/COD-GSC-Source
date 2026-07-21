/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\equipment\cp_snapshot_grenade.gsc
************************************************/

snapshot_grenade_used(var_0, var_1) {
  var_0 thread scripts\cp\utility::notifyafterframeend("_encstr_AD75063D571AE108", "_encstr_BDF90C4D10A95F47E990CAF2D83B");
  var_0 endon("_encstr_BDF90C4D10A95F47E990CAF2D83B");
  var_0 setotherent(self);
  var_0 thread snapshot_grenade_watch_emp();
  var_0 thread snapshot_grenade_watch_cleanup();

  if(istrue(var_1))
    var_0 waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_6, var_2, var_3, var_4, var_5);
  else
    var_0 waittill("_encstr_860808CB78E2984063BA", var_6);

  thread snapshot_grenade_watch_flight(var_6);
}

snapshot_get_flight_dest(var_0, var_1) {
  var_1 = (0, 0, 1);
  var_2 = var_0;
  var_3 = var_0 + var_1 * 137;
  var_4 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80"]);
  var_5 = physics_raycast(var_2, var_3, var_4, undefined, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

  if(isDefined(var_5) && var_5.size > 0) {
    var_3 = var_5[0]["_encstr_BD260953AA97E3F014279D"];

    if(1) {
      var_6 = vectordot(var_3 - var_2, var_1);

      if(var_6 > 0) {
        if(var_6 >= 50)
          var_6 = min(var_6 - 25, 112);
        else
          var_6 = var_6 / 2;

        var_3 = var_2 + var_1 * var_6;
      }
    }
  } else
    var_3 = var_2 + var_1 * 112;

  return var_3;
}

snapshot_grenade_watch_flight(var_0) {
  var_1 = self.name;
  var_2 = scripts\cp\utility::_launchgrenade("_encstr_AD1414DCDC1683CD34DB8EF53B272BE65832CAAFDA0E", var_0, (0, 0, 0), 100, 1);
  var_2 setotherent(self);
  var_2 setscriptablepartstate("_encstr_83380768EF1919AF8A", "_encstr_930B07BB1B6B3854FF", 0);
  var_2 setscriptablepartstate("_encstr_A3CD06BF48102D73", "_encstr_AD830746560EB17BCB", 0);
  var_2 missilehidetrail();
  var_2.owner = self;
  var_2 thread snapshot_grenade_watch_emp();
  var_2 thread snapshot_grenade_watch_cleanup();
  var_2 endon("_encstr_AD75063D571AE108");
  var_3 = scripts\cp\utility::_launchgrenade("_encstr_91291B6812AE1993A36735B847E3999D161A4081CAC66D294F82A8A948", var_2.origin, (0, 0, 0), 100, 1);
  var_3 linkTo(var_2);
  var_3 hidefromplayer(self);
  var_2 thread snapshot_grenade_cleanup_danger_icon(var_3);
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
  var_4.angles = var_2.angles;
  var_4 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_2 linkTo(var_4, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  var_2 thread snapshot_grenade_cleanup_mover(var_4);
  var_5 = (0, 0, 1);
  var_6 = snapshot_get_flight_dest(var_0, var_5);
  var_7 = vectordot(var_6 - var_0, var_5);
  var_8 = (0, 0, 0);

  if(var_7 > 0) {
    var_9 = var_7 / 112;
    var_10 = 0.65 * var_9;
    var_11 = var_10 * 0.19;
    var_12 = var_10 * 0.6;
    var_13 = 0.3 * var_9;
    var_14 = var_10 * 0;
    var_15 = var_10 * 0.35;
    var_4 rotateTo(var_8, var_13, var_14, var_15);
    wait 0.2;
    var_2 setscriptablepartstate("_encstr_A16605C8AB6E47", "_encstr_930B07BB1B6B3854FF", 0);
    var_2 setscriptablepartstate("_encstr_A3CD06BF48102D73", "_encstr_A7C5056BD931D1", 0);
    var_4 moveTo(var_6, var_10, var_11, var_12);
    wait(var_10);
  } else {
    var_4.angles = var_8;
    wait 0.2;
  }

  var_16 = 0.0;
  wait(var_16);
  var_2 setscriptablepartstate("_encstr_95A107E3BB553A0BC0", "_encstr_930B07BB1B6B3854FF", 0);
  var_2 setscriptablepartstate("_encstr_A3CD06BF48102D73", "_encstr_A7C5056BD931D1", 0);
  var_2 setscriptablepartstate("_encstr_83380768EF1919AF8A", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  wait 0.5;
  var_2 snapshot_grenade_detect();
  level notify("_encstr_8840203B1B679D69DB35F8ED10B3F0578FF2903992BB1D209B5FE0DEF40F9909F38A", var_2, "_encstr_AD1414DCDC1683CD34DB8EF53B272BE65832CAAFDA0E", var_1);
  var_2 thread snapshot_grenade_destroy();
}

snapshot_grenade_detect() {
  var_0 = self.owner;
  var_1 = self.origin;
  var_2 = self.angles;
  var_3 = undefined;

  if(1) {
    var_3 = spawnStruct();
    var_3.owner = var_0;
    var_3.position = var_1;
    var_3.isalive = 1;
    var_3.targets = [];
    var_3.endtimes = [];
    var_3.outlineids = [];
  }

  var_4 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA"]);

  foreach(var_6 in level.characters) {
    if(!isDefined(var_6)) {
      continue;
    }
    if(!var_6 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(isPlayer(var_6)) {
      continue;
    }
    var_7 = var_6.origin - var_1;
    var_8 = lengthsquared(var_7);

    if(var_8 > 1166400) {
      continue;
    }
    if(0) {
      var_9 = var_1;
      var_10 = var_6 getEye();
      var_11 = physics_raycast(var_9, var_10, var_4, undefined, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

      if(isDefined(var_11) && var_11.size > 0) {
        continue;
      }
      if(1) {
        var_12 = var_6 getentitynumber();
        var_3.targets[var_12] = var_6;
        var_3.endtimes[var_12] = gettime() + 10000;
        var_3.outlineids[var_12] = scripts\cp\cp_outline_utility::outlineenableforall(var_6, "_encstr_851510A39042189B5C38D18F72E308667D7B", "_encstr_BE8F0A272F9B2BE97268AE8B");
        var_6 scripts\cp\cp_outline_utility::_hudoutlineviewmodelenable("_encstr_851510A39042189B5C38D18F72E308667D7B", 0);
        var_3 thread snapshot_grenade_update_outlines();
      }

      if(0)
        var_0 thread snapshot_grenade_create_marker(var_6 gettagorigin("_encstr_813B0D4027B390B37585BBC819FD28"), var_6.angles, var_6);

      continue;
    }

    if(1) {
      var_12 = var_6 getentitynumber();
      var_3.targets[var_12] = var_6;
      var_3.endtimes[var_12] = gettime() + 10000;
      var_3.outlineids[var_12] = scripts\cp\cp_outline_utility::outlineenableforall(var_6, "_encstr_851510A39042189B5C38D18F72E308667D7B", "_encstr_BE8F0A272F9B2BE97268AE8B");

      if(isPlayer(var_6))
        var_6 scripts\cp\cp_outline_utility::_hudoutlineviewmodelenable("_encstr_851510A39042189B5C38D18F72E308667D7B", 0);

      var_3 thread snapshot_grenade_update_outlines();
    }

    if(0)
      var_0 thread snapshot_grenade_create_marker(var_6 gettagorigin("_encstr_813B0D4027B390B37585BBC819FD28"), var_6.angles, var_6);
  }

  if(1)
    triggerportableradarping(var_1, var_0, 1080, 500);
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
  self endon("_encstr_AD75063D571AE108");
  self.exploding = 1;
  self setCanDamage(0);
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
      var_4 = var_6 * 19;
    }
  }

  return var_4;
}

snapshot_grenade_handle_fatal_damage(var_0) {
  var_1 = var_0.attacker;

  if(isDefined(var_1) && scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_1))
    var_1 notify("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");

  thread snapshot_grenade_destroy();
}

snapshot_grenade_watch_emp() {
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_AB770C81EB09798E707B29137D77", var_0);
  var_1 = var_0.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_1)))
    var_1 notify("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");

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
  self.owner endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
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

      if(!isDefined(var_1) || !var_1 scripts\cp_mp\utility\player_utility::_isalive() || gettime() >= var_2) {
        scripts\cp\cp_outline_utility::outlinedisable(var_3, var_1);

        if(isDefined(var_1) && isPlayer(var_1))
          var_1 scripts\cp\cp_outline_utility::_hudoutlineviewmodeldisable();

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
  self.owner endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
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
    scripts\cp\cp_outline_utility::outlinedisable(var_2, var_1);

    if(isDefined(var_1) && isPlayer(var_1))
      var_1 scripts\cp\cp_outline_utility::_hudoutlineviewmodeldisable();
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
  var_3 snapshot_grenade_watch_marker_end_early(self, 36000, var_2, 15000);

  if(isDefined(var_3))
    var_3 delete();
}

snapshot_grenade_watch_marker_end_early(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_4 = gettime() + var_1;
  var_5 = scripts\engine\utility::ter_op(1, gettime() + 15000, undefined);

  while(var_4 > gettime()) {
    if(isDefined(var_5)) {
      if(var_5 < gettime()) {
        self unlink();
        var_5 = undefined;
      } else if(!isDefined(var_2)) {
        self unlink();
        var_5 = undefined;
      } else if(!var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
        self unlink();
        var_5 = undefined;
      }
    }

    waitframe();
  }
}