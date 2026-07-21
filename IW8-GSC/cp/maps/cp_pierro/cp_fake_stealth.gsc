/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_pierro\cp_fake_stealth.gsc
*************************************************/

cp_fake_stealth() {
  scripts\engine\utility::flag_init("_encstr_A68C14CC58B5ACBE6EE8AC5863D10DAF3816AE6E2B23");
  level.const_cos60 = cos(65);
  level thread load_stealth_values_from_table();
  level.current_escalation_level = 0;

  for(;;) {
    if(scripts\engine\utility::flag("_encstr_A68C14CC58B5ACBE6EE8AC5863D10DAF3816AE6E2B23")) {
      waitframe();
      continue;
    }

    var_0 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");

    if(var_0.size == 0) {
      waitframe();
      continue;
    }

    foreach(var_2 in var_0) {
      if(isDefined(var_2.issoldier)) {
        continue;
      }
      if(isDefined(var_2.fake_stealth)) {
        continue;
      }
      var_2.dont_cleanup = 1;
      var_2.fake_stealth = 1;
      var_2 thread zombie_fake_stealth();
      var_2 thread stealth_patrol(var_2.origin);
      waitframe();
    }

    waitframe();
  }
}

set_zombie_awareness(var_0) {}

zombie_fake_stealth() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_82CA0D07613BCBD718F32F36E8F838");

  if(!istrue(self.hasplayedvignetteanim))
    wait 2;

  waitframe();
  self.ignoreall = 1;
  self.scripted_mode = 1;
  fake_stealth_funcs();
  var_0 = scripts\engine\utility::waittill_any_return("_encstr_BA22087EA808525BA5D9", "_encstr_B2BE0788BAF573592F");

  if(var_0 == "_encstr_B2BE0788BAF573592F")
    self.fake_stealth_state = "_encstr_951B0CC8F71838706BFBB04B376A";

  if(isDefined(self.og_goalradius))
    self.goalradius = self.og_goalradius;

  if(self islegacyagent())
    self scragentsetgoalpos(self.origin);
  else {
    self setgoalpos(self.origin);
    self clearpath();
  }

  self.ignoreall = 0;
  self.scripted_mode = 0;
  self.legacy.movemode = "_encstr_92100762872552A643";
  wait 5;
  thread revert_to_stealth();
}

revert_to_stealth() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_82CA0D07613BCBD718F32F36E8F838");

  for(;;) {
    while(!isDefined(self.enemy)) {
      waitframe();
      continue;
    }

    if(!isPlayer(self.enemy)) {
      waitframe();
      continue;
    }

    var_0 = self.enemy;
    var_1 = distance(var_0.origin, self.origin);
    var_2 = self cansee(var_0) && sighttracepassed(self getEye(), var_0.origin + (0, 0, 40), 0, self);
    var_3 = scripts\engine\utility::within_fov(self getEye(), self gettagangles("_encstr_A130084D2FDAD8AA8F62"), var_0.origin + (0, 0, 40), level.const_cos60);
    var_4 = var_0 getstance();

    if(var_2 && var_3) {
      if(var_1 < 650) {
        if(var_4 == "_encstr_A5AD069B231F0BAF") {
          wait 0.25;
          continue;
        } else {
          go_to_last_player_position(var_0);
          return;
        }
      } else if(var_1 < 128) {
        if(var_4 == "_encstr_922406F1A6FD5E05") {
          wait 0.25;
          continue;
        } else {
          go_to_last_player_position(var_0);
          return;
        }
      }
    } else if(var_1 > 196) {
      go_to_last_player_position(var_0);
      return;
    }

    wait 0.25;
  }
}

go_to_last_player_position(var_0) {
  self.fake_stealth_state = "_encstr_B4EE173F7F2B7AFF69035DA9F8601313E8D997D7DBCD72BFC8";
  self.scripted_mode = 1;
  self.ignoreall = 1;
  thread zombie_fake_stealth();
  thread go_to_spot(var_0.origin);
}

fake_stealth_funcs() {
  thread whizby_listener();
  thread grenade_listener();
  thread environment_listener();
  thread player_nearby_listener();
  thread player_weapon_listener();
  set_stealth_values(self, 0);
  thread zombie_3dtext_handler();
  thread draw_fov();
}

whizby_listener() {
  self endon("_encstr_BA22087EA808525BA5D9");
  self endon("_encstr_82CA0D07613BCBD718F32F36E8F838");

  for(;;) {
    self waittill("_encstr_A5490D5E05C3F8B363F3C8D83B3E43", var_0);
    self.fake_stealth_state = "_encstr_ADE31CF8320B7D50DBA97773DCC4E034074AF3C0FABF2DF933B0135DF228";
    thread go_to_spot(var_0.origin);
  }
}

environment_listener() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA22087EA808525BA5D9");
  self endon("_encstr_82CA0D07613BCBD718F32F36E8F838");

  for(;;) {
    level waittill("_encstr_9554123DFE4BB87D4542C0985ADB6FF15B9D3E2D", var_0);

    if(distance(self.origin, var_0) > 650)
      continue;
    else {
      self.fake_stealth_state = "_encstr_81A31A61D5B857DF2D30523ABB8BF38F62BBEEE673201D6359A9FA73";
      thread go_to_spot(var_0);
    }
  }
}

grenade_listener() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA22087EA808525BA5D9");
  self endon("_encstr_82CA0D07613BCBD718F32F36E8F838");

  for(;;) {
    self waittill("_encstr_860808CB78E2984063BA", var_0);

    if(distance(self.origin, var_0) > 1000)
      continue;
    else {
      self.fake_stealth_state = "_encstr_95DE202DDCB359E61DD2B30B4796B9D9BE76279573B0329501CA3C388DB7E65ABD37";
      thread go_to_spot(var_0);
    }
  }
}

player_nearby_listener() {
  self endon("_encstr_BA22087EA808525BA5D9");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_82CA0D07613BCBD718F32F36E8F838");

  for(;;) {
    foreach(var_1 in level.players) {
      var_2 = distance(var_1.origin, self.origin);

      if(var_2 > 600) {
        continue;
      }
      if(var_2 < 96) {
        self.fake_stealth_state = "_encstr_8ADA089BC1B78EE8B246";
        self notify("_encstr_BA22087EA808525BA5D9");
        break;
      }

      var_3 = self cansee(var_1) && sighttracepassed(self getEye(), var_1.origin + (0, 0, 40), 0, self);
      var_4 = var_1 getstance();

      if(var_3) {
        var_5 = scripts\engine\utility::within_fov(self getEye(), self gettagangles("_encstr_A130084D2FDAD8AA8F62"), var_1.origin + (0, 0, 40), level.const_cos60);

        if(!var_5) {
          continue;
        }
        if(var_2 <= 600 && var_4 == "_encstr_A5AD069B231F0BAF") {
          self playSound("_encstr_834C1759ADE8FAEE7BDB32FA982CE4275A9593D732B2378E9C");
          self.fake_stealth_state = "_encstr_8ADA089BC1B78EE8B246";
          self notify("_encstr_BA22087EA808525BA5D9");
          return;
        } else if(var_2 <= 400 && var_4 == "_encstr_A5AD069B231F0BAF") {
          self playSound("_encstr_834C1759ADE8FAEE7BDB32FA982CE4275A9593D732B2378E9C");
          self.fake_stealth_state = "_encstr_8ADA089BC1B78EE8B246";
          self notify("_encstr_BA22087EA808525BA5D9");
          return;
        } else if(var_2 <= 200 && var_4 != "_encstr_922406F1A6FD5E05") {
          self playSound("_encstr_834C1759ADE8FAEE7BDB32FA982CE4275A9593D732B2378E9C");
          self.fake_stealth_state = "_encstr_8ADA089BC1B78EE8B246";
          self notify("_encstr_BA22087EA808525BA5D9");
          return;
        }
      }

      waitframe();
    }

    waitframe();
  }
}

stealth_patrol(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA22087EA808525BA5D9");
  self endon("_encstr_ADE909AD87474FB75ACA79");
  self endon("_encstr_82CA0D07613BCBD718F32F36E8F838");
  self.og_goalradius = self.goalradius;

  if(!isDefined(var_0))
    var_0 = self.origin;

  var_1 = getrandomnavpoints(var_0, 350, 6);

  if(!isDefined(var_1)) {
    return;
  }
  self.fake_stealth_state = "_encstr_96080730D8534E0A28";

  for(;;) {
    var_2 = scripts\engine\utility::random(var_1);

    if(self islegacyagent()) {
      self scragentsetgoalRadius(8);
      self scragentsetgoalpos(var_2);
    } else {
      self.goalradius = 8;
      self setgoalpos(var_2);
    }

    scripts\engine\utility::waittill_any("_encstr_8B7205D9ED5958", "_encstr_A3130D9AF069D2310E87C1D9C03A82");
    wait(randomfloatrange(0.05, 3));
  }
}

go_to_spot(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA22087EA808525BA5D9");
  self endon("_encstr_82CA0D07613BCBD718F32F36E8F838");
  self notify("_encstr_ADE909AD87474FB75ACA79");
  self endon("_encstr_ADE909AD87474FB75ACA79");

  if(self islegacyagent()) {
    self scragentsetgoalpos(self.origin);
    scripts\engine\utility::waittill_any("_encstr_8B7205D9ED5958", "_encstr_A3130D9AF069D2310E87C1D9C03A82");
  } else {
    self setgoalpos(self.origin);
    self clearpath();
  }

  if(!isDefined(self.legacy)) {
    iprintln("_encstr_AFA12022D260ABD67958E403CD514EAC639A5B5D319FCB5FD897582660471EA1DAAE" + self getentitynumber() + "_encstr_87560B16401AAC168D8EA1E802" + self.health + "_encstr_87950A1601C29D95DCA34704" + self.agent_type);
    self.legacy = spawnStruct();
  }

  self.legacy.movemode = "_encstr_92100762872552A643";

  if(self islegacyagent()) {
    self scragentsetgoalpos(getclosestpointonnavmesh(var_0));
    var_1 = scripts\engine\utility::waittill_any_return("_encstr_8B7205D9ED5958", "_encstr_A3130D9AF069D2310E87C1D9C03A82");
  } else {
    self setgoalpos(getclosestpointonnavmesh(var_0));
    self waittill("_encstr_8B7205D9ED5958");
  }

  self.legacy.movemode = "_encstr_97BC0AB9C67BDD7DDD851B6D";
  wait 3;
  self.fake_stealth_state = "_encstr_96080730D8534E0A28";
  thread stealth_patrol(var_0);
}

weapon_fire_monitor() {
  self notify("_encstr_A1E9148785F1F04F6851E5A7CA49E9F59060BAF3DF0A");
  self endon("_encstr_A1E9148785F1F04F6851E5A7CA49E9F59060BAF3DF0A");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19");
    level notify("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", self.origin, self getcurrentweapon());
  }
}

player_weapon_listener() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA22087EA808525BA5D9");
  self endon("_encstr_82CA0D07613BCBD718F32F36E8F838");

  for(;;) {
    level waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", var_0, var_1);

    if(distance(var_0, self.origin) > 1500)
      continue;
    else {
      self.fake_stealth_state = "_encstr_AFC91AFAA054E7AAD853EFF171E83527683BB2E20BA093E960BBF2FD";
      thread go_to_spot(var_0);
    }
  }
}

zombie_3dtext_handler() {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_AF4C0CA32B1EE81A16B98C639539");
  self endon("_encstr_AF4C0CA32B1EE81A16B98C639539");

  for(;;) {
    if(getDvar("_encstr_857814AFC0C909AA9943A95ABB47D3EFD3685F3BD063") == "_encstr_B40101") {
      wait 1;
      continue;
    }

    waitframe();
  }
}

draw_fov() {
  self notify("_encstr_A7D109D7F613A387119833");
  self endon("_encstr_A7D109D7F613A387119833");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(getDvar("_encstr_BE93115BE3DDF76DD851D7E349D873C7F138D3") == "_encstr_B40101") {
      wait 1;
      continue;
    }

    var_0 = self gettagorigin("_encstr_A130084D2FDAD8AA8F62");
    var_1 = self gettagangles("_encstr_A130084D2FDAD8AA8F62");
    var_2 = anglesToForward(var_1);
    var_3 = var_0 + var_2 * self.stealthvals.standdetectdist;
    waitframe();
  }
}

load_stealth_values_from_table() {
  level.zombie_stealth_values = [];
  var_0 = "_encstr_978F1E1B30CD7CE393AE3F6BC71003050BD022F2696773CF69196C68F0A17F0B";
  var_1 = 1;
  var_2 = 1;

  for(;;) {
    var_3 = tablelookupbyrow(var_0, var_2, var_1);

    if(var_3 == "_encstr_B40101") {
      break;
    }

    var_4 = spawnStruct();
    var_4.standdetectdist = int(tablelookupbyrow(var_0, 2, var_1));
    var_4.crouchdetectdist = int(tablelookupbyrow(var_0, 3, var_1));
    var_4.pronedetectdist = int(tablelookupbyrow(var_0, 4, var_1));
    var_4.hiddenstanddetectdist = int(tablelookupbyrow(var_0, 5, var_1));
    var_4.hiddencrouchdetectdist = int(tablelookupbyrow(var_0, 6, var_1));
    var_4.hiddenpronedetectdist = int(tablelookupbyrow(var_0, 7, var_1));
    var_4.propdistance = int(tablelookupbyrow(var_0, 8, var_1));
    var_4.timebeforeescalate = int(tablelookupbyrow(var_0, 9, var_1));
    var_4.timebeforedeescalate = int(tablelookupbyrow(var_0, 10, var_1));
    var_4.distancebeforedeescalate = int(tablelookupbyrow(var_0, 11, var_1));
    var_4.timehiddennolosbeforedeescalate = int(tablelookupbyrow(var_0, 12, var_1));
    var_4.zombiemovespeed = tablelookupbyrow(var_0, 13, var_1);
    var_4.playerstandmovedist = int(tablelookupbyrow(var_0, 14, var_1));
    var_4.playercrouchmovedist = int(tablelookupbyrow(var_0, 15, var_1));
    var_4.playerpronemovedist = int(tablelookupbyrow(var_0, 16, var_1));
    var_4.hiddenplayerstandmovedist = int(tablelookupbyrow(var_0, 17, var_1));
    var_4.hiddenplayercrouchmovedist = int(tablelookupbyrow(var_0, 18, var_1));
    var_4.hiddenplayerpronemovedist = int(tablelookupbyrow(var_0, 19, var_1));
    var_4.playermovedistlerptime = int(tablelookupbyrow(var_0, 20, var_1));
    var_4.losfov = int(tablelookupbyrow(var_0, 21, var_1));
    level.zombie_stealth_values[int(var_3)] = var_4;
    var_1++;
  }
}

set_stealth_values(var_0, var_1) {
  var_1 = "_encstr_B40101" + var_1;
  var_2 = spawnStruct();
  var_2.standdetectdist = level.zombie_stealth_values[var_1].standdetectdist;
  var_2.crouchdetectdist = level.zombie_stealth_values[var_1].crouchdetectdist;
  var_2.pronedetectdist = level.zombie_stealth_values[var_1].pronedetectdist;
  var_2.hiddenstanddetectdist = level.zombie_stealth_values[var_1].hiddenstanddetectdist;
  var_2.hiddencrouchdetectdist = level.zombie_stealth_values[var_1].hiddencrouchdetectdist;
  var_2.hiddenpronedetectdist = level.zombie_stealth_values[var_1].hiddenpronedetectdist;
  var_2.propdistance = level.zombie_stealth_values[var_1].propdistance;
  var_2.timebeforeescalate = level.zombie_stealth_values[var_1].timebeforeescalate;
  var_2.timebeforedeescalate = level.zombie_stealth_values[var_1].timebeforedeescalate;
  var_2.distancebeforedeescalate = level.zombie_stealth_values[var_1].distancebeforedeescalate;
  var_2.timehiddennolosbeforedeescalate = level.zombie_stealth_values[var_1].timehiddennolosbeforedeescalate;
  var_2.zombiemovespeed = level.zombie_stealth_values[var_1].zombiemovespeed;
  var_2.playerstandmovedist = level.zombie_stealth_values[var_1].playerstandmovedist;
  var_2.playercrouchmovedist = level.zombie_stealth_values[var_1].playercrouchmovedist;
  var_2.playerpronemovedist = level.zombie_stealth_values[var_1].playerpronemovedist;
  var_2.hiddenplayerstandmovedist = level.zombie_stealth_values[var_1].hiddenplayerstandmovedist;
  var_2.hiddenplayercrouchmovedist = level.zombie_stealth_values[var_1].hiddenplayercrouchmovedist;
  var_2.hiddenplayerpronemovedist = level.zombie_stealth_values[var_1].hiddenplayerpronemovedist;
  var_2.playermovedistlerptime = level.zombie_stealth_values[var_1].playermovedistlerptime;
  var_2.losfov = level.zombie_stealth_values[var_1].losfov;
  var_0.stealthvals = var_2;
}