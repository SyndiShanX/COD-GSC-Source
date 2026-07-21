/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_stealth_zombie.gsc
***********************************************/

scriptagentstealth_init() {
  scripts\engine\utility::flag_init("_encstr_A68C14CC58B5ACBE6EE8AC5863D10DAF3816AE6E2B23");
  load_stealth_values_from_table();
  level.const_cos60 = cos(65);
  level.current_escalation_level = 0;
  level.maxescalationvalue = level.zombie_stealth_values.size;
  level.nearbyposarray = [];
}

isgroundspawner(var_0) {
  if(isDefined(var_0.spawner) && isDefined(var_0.spawner.script_parameters) && (var_0.spawner.script_parameters == "_encstr_A76E173B9CF6BA3732F59BC11677B97DE6BD7D26DE16E419E6" || var_0.spawner.script_parameters == "_encstr_A71A0D504BB59BB8EBDF3EB7F97F60"))
    return 1;
  else
    return 0;
}

zombiescriptedstealth(var_0, var_1) {
  var_0 notify("_encstr_8DEF16BAE73FC143CFA9B83822A2217973A3C5BD4183CB89");
  var_0 endon("_encstr_8DEF16BAE73FC143CFA9B83822A2217973A3C5BD4183CB89");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_82CA0D07613BCBD718F32F36E8F838");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_0.ignoreall = 1;
    var_0.scripted_mode = 1;
    var_0.scriptedstealth = 1;
    var_0 fake_stealth_funcs(var_1);
    var_2 = var_0 scripts\engine\utility::_id_143AF("_encstr_BA22087EA808525BA5D9", "_encstr_B2BE0788BAF573592F", "_encstr_AD990EC9ACCD56A3FACD1D592CD8A30D", "_encstr_BD420EB0C6ACC98ECA46BE13E5D785B4");

    if(!isDefined(var_2) || var_2 == "_encstr_AD990EC9ACCD56A3FACD1D592CD8A30D") {
      continue;
    }
    var_0.forcedpatrol = undefined;
    var_0.scriptedstealth = undefined;

    if(var_2 == "_encstr_BA22087EA808525BA5D9" || var_2 == "_encstr_B2BE0788BAF573592F") {
      foreach(var_4 in scripts\engine\utility::get_array_of_closest(var_0.origin, level.spawned_enemies, [var_0], undefined, getzombiestealthvalues(var_0).propdistance, 0)) {
        if(var_4.agent_type != var_0.agent_type) {
          continue;
        }
        if(var_4.team != var_0.team) {
          continue;
        }
        if(var_4 != var_0)
          var_4 notify("_encstr_BA22087EA808525BA5D9");
      }
    }

    if(var_2 == "_encstr_BA22087EA808525BA5D9")
      setstealthstate("_encstr_8ADA089BC1B78EE8B246");
    else if(var_2 == "_encstr_B2BE0788BAF573592F")
      setstealthstate("_encstr_951B0CC8F71838706BFBB04B376A");

    chaseplayerthenreverttostealth(var_0);
  }
}

chaseplayerthenreverttostealth(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");

  if(isDefined(var_0.og_goalradius))
    var_0.goalradius = var_0.og_goalradius;

  var_0 setgoalpos(var_0.origin);
  var_0.ignoreall = 0;
  var_0.scripted_mode = 0;
  var_0.dont_cleanup = undefined;
  var_0.fake_stealth = 0;
  var_0.legacy.movemode = "_encstr_92100762872552A643";
  var_1 = getzombiestealthvalues(var_0).timehiddennolosbeforedeescalate;
  var_2 = 0;
  var_3 = getzombiestealthvalues(var_0).distancebeforedeescalate;
  var_4 = 0.5;

  while(var_2 < var_1) {
    var_5 = 0;
    var_6 = scripts\engine\utility::array_combine(level.players, scripts\cp\cp_agent_utils::getactiveenemyagents(var_0.team));

    foreach(var_8 in var_6) {
      if(istrue(var_8.ignoreme)) {
        continue;
      }
      if(isenemynearby(var_0, var_8, 0, 0)) {
        var_2 = 0;
        var_5 = 1;
        break;
      }
    }

    if(!var_5)
      var_2 = var_2 + var_4;

    wait(var_4);
  }
}

getstealthstate() {
  if(isDefined(self.patrol_state))
    return self.patrol_state;
  else
    return undefined;
}

setstealthstate(var_0) {
  self.patrol_state = var_0;
  self notify("_encstr_A1C716E2B31059F215F95FD7F9B7BB9519B9DCEE68A8E52A");
}

fake_stealth_funcs(var_0) {
  set_stealth_values(self, int(level.current_escalation_level));
  thread setambientmovespeed(self, var_0);
  thread whizby_listener(self);
  thread grenade_listener(self);
  thread environment_listener(self);
  thread player_nearby_listener(self);
  thread player_weapon_listener(self);
  thread move_speed_monitor(self);
  thread stealth_patrol(self.origin);
  self.fake_stealth = 1;
  self notify("_encstr_8890116616D62BD7CDD195B01B8E43BE9BB2E8");
}

setambientmovespeed(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_BA22087EA808525BA5D9");
  var_0 endon("_encstr_82CA0D07613BCBD718F32F36E8F838");

  if(istrue(var_1))
    wait 0.15;

  var_2 = strtok(var_0.stealthvals.zombiemovespeed, "_encstr_964C0249");
  var_3 = scripts\engine\utility::random(var_2);
  var_0.legacy.movemode = var_3;
  var_0 setstealthmovespeed(var_0, var_3);
}

setstealthmovespeed(var_0, var_1) {
  var_0 scripts\asm\asm_bb::bb_requestmovetype(var_1);
}

move_speed_monitor(var_0) {
  var_0 notify("_encstr_97751388127B23063F884DB5746788EFA5DAF8105B");
  var_0 endon("_encstr_97751388127B23063F884DB5746788EFA5DAF8105B");
  var_0 endon("_encstr_BA22087EA808525BA5D9");
  var_0 endon("_encstr_BD420EB0C6ACC98ECA46BE13E5D785B4");
  var_0 endon("_encstr_82CA0D07613BCBD718F32F36E8F838");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_ADE909AD87474FB75ACA79");

  for(;;) {
    if(istrue(var_0.scriptedstealth)) {
      var_1 = strtok(getzombiestealthvalues(var_0).zombiemovespeed, "_encstr_964C0249");
      var_2 = scripts\engine\utility::random(var_1);
      var_0 setstealthmovespeed(var_0, var_2);
    }

    scripts\engine\utility::waittill_any_ents(var_0, "_encstr_8C7C135ABD439AFC1BD8DF73B830BD820740225725", level, "_encstr_9BC50FFA3D48CF62BBC88AB020991B8B81");
  }
}

whizby_listener(var_0) {
  var_0 notify("_encstr_A2A810EE86B4F44C5EEB1BA59B8EB23756C9");
  var_0 endon("_encstr_A2A810EE86B4F44C5EEB1BA59B8EB23756C9");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_BA22087EA808525BA5D9");
  var_0 endon("_encstr_82CA0D07613BCBD718F32F36E8F838");

  for(;;) {
    var_0 waittill("_encstr_A5490D5E05C3F8B363F3C8D83B3E43", var_1);

    if(istrue(var_1.ignoreme)) {
      continue;
    }
    if(isagent(var_1)) {
      var_0 setstealthstate("_encstr_8ADA089BC1B78EE8B246");
      var_0 playSound("_encstr_8E9E10E95B98F5B37BD71BED1CBE07B0D2DC");
      var_0 notify("_encstr_BD420EB0C6ACC98ECA46BE13E5D785B4");
      continue;
    }

    if(istrue(var_0.scriptedstealth))
      var_0 thread go_to_spot(var_0, var_1.origin, undefined, "_encstr_ADE31CF8320B7D50DBA97773DCC4E034074AF3C0FABF2DF933B0135DF228");
  }
}

environment_listener(var_0) {
  var_0 notify("_encstr_83A015A7ED14BA5A58D04D57C858AF22632F6B3F453553");
  var_0 endon("_encstr_83A015A7ED14BA5A58D04D57C858AF22632F6B3F453553");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_BA22087EA808525BA5D9");
  var_0 endon("_encstr_82CA0D07613BCBD718F32F36E8F838");
  var_0 endon("_encstr_ADE909AD87474FB75ACA79");

  for(;;) {
    level waittill("_encstr_9554123DFE4BB87D4542C0985ADB6FF15B9D3E2D", var_1);

    if(!istrue(var_0.scriptedstealth)) {
      continue;
    }
    if(distance(var_0.origin, var_1) > 650)
      continue;
    else
      var_0 thread go_to_spot(var_0, var_1, undefined, "_encstr_81A31A61D5B857DF2D30523ABB8BF38F62BBEEE673201D6359A9FA73");
  }
}

grenade_listener(var_0) {
  var_0 notify("_encstr_96E3114C23C2255A3ACF79282DAB4B57936D6E");
  var_0 endon("_encstr_96E3114C23C2255A3ACF79282DAB4B57936D6E");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_BA22087EA808525BA5D9");
  var_0 endon("_encstr_82CA0D07613BCBD718F32F36E8F838");
  var_0 endon("_encstr_ADE909AD87474FB75ACA79");

  for(;;) {
    var_0 waittill("_encstr_860808CB78E2984063BA", var_1);

    if(!istrue(var_0.scriptedstealth)) {
      continue;
    }
    if(distance(var_0.origin, var_1) > 1500)
      continue;
    else
      var_0 thread go_to_spot(var_0, var_1, undefined, "_encstr_95DE202DDCB359E61DD2B30B4796B9D9BE76279573B0329501CA3C388DB7E65ABD37");
  }
}

enemynearbylistener(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 notify("_encstr_B8C2143AE397570AD14F57E2FA2B552BFBC54A604AD0");
  var_0 endon("_encstr_B8C2143AE397570AD14F57E2FA2B552BFBC54A604AD0");
  var_0 endon("_encstr_BA22087EA808525BA5D9");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_82CA0D07613BCBD718F32F36E8F838");

  for(;;) {
    if(istrue(var_0.scriptedstealth)) {
      var_1 = scripts\engine\utility::array_combine(level.players, scripts\cp\cp_agent_utils::getactiveenemyagents(var_0.team));

      foreach(var_3 in var_1) {
        if(istrue(var_3.ignoreme)) {
          continue;
        }
        isenemynearby(var_0, var_3, 0, 1);
      }
    }

    wait 0.1;
  }
}

player_nearby_listener(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 notify("_encstr_B4181783B10BF22BC9D773951627985ED71B2D6E3A95B9954E");
  var_0 endon("_encstr_B4181783B10BF22BC9D773951627985ED71B2D6E3A95B9954E");
  var_0 endon("_encstr_BA22087EA808525BA5D9");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_82CA0D07613BCBD718F32F36E8F838");

  for(;;) {
    if(istrue(var_0.scriptedstealth)) {
      var_1 = scripts\engine\utility::array_combine(level.players, scripts\cp\cp_agent_utils::getactiveenemyagents(var_0.team));

      foreach(var_3 in var_1) {
        if(istrue(var_3.ignoreme)) {
          continue;
        }
        isenemynearby(var_0, var_3, 1, 1);
      }
    }

    wait 0.1;
  }
}

setandunsetzombieignoreme(var_0, var_1) {
  var_0 notify("_encstr_A9EA1AD235EBD526D4FBC5D7CDC4D9A8A0813909BB0FA397DB38D05A");
  var_0 endon("_encstr_A9EA1AD235EBD526D4FBC5D7CDC4D9A8A0813909BB0FA397DB38D05A");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = scripts\engine\utility::waittill_any_ents_return(var_1, "_encstr_8890116616D62BD7CDD195B01B8E43BE9BB2E8", var_1, "_encstr_AD75063D571AE108");
}

alertzombie(var_0, var_1, var_2) {
  if(isPlayer(var_1)) {
    if(var_2) {
      var_0.spottedplayer = var_1;
      var_0 setstealthstate("_encstr_8ADA089BC1B78EE8B246");
      show_spotted_text(var_1);
      var_0 playsoundtoplayer("_encstr_8E9E10E95B98F5B37BD71BED1CBE07B0D2DC", var_1);
      var_1 thread setandunsetzombieignoreme(var_1, var_0);
    }

    var_0 notify("_encstr_BA22087EA808525BA5D9");
  } else {
    var_0 setstealthstate("_encstr_8ADA089BC1B78EE8B246");
    var_0 playSound("_encstr_8E9E10E95B98F5B37BD71BED1CBE07B0D2DC");
    var_0 notify("_encstr_BD420EB0C6ACC98ECA46BE13E5D785B4");
  }
}

isenemynearby(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    return 0;

  var_4 = isPlayer(var_1);
  var_5 = getzombiestealthvalues(var_0);
  var_6 = var_5.losfov;
  var_7 = distance(var_1.origin, var_0.origin);
  var_0.spottedplayer = undefined;
  var_2 = istrue(var_2);
  var_8 = var_0 getplayerangles(1);
  var_9 = istrue(var_5.canseethroughfoliage);

  if(var_4) {
    if(!var_1 scripts\cp\utility::is_valid_player())
      return 0;

    if(isDefined(var_1.skill_data))
      var_7 = var_7 * var_1.skill_data["_encstr_830E086EE82B0B361D86"].stealth_dist_scalar;
  }

  if(var_7 < 96) {
    if(vectordot(var_8, vectorNormalize(var_1.origin - var_0.origin)) > 0) {
      alertzombie(var_0, var_1, var_2);
      return 1;
    }
  }

  var_10 = var_0 cansee(var_1) && sighttracepassed(var_0 getEye(), var_1.origin, 0, var_0, var_9);

  if(var_10 || istrue(level.skipstealthcanseecheck)) {
    var_11 = scripts\engine\math::get_dot(var_0.origin, var_8, var_1.origin);

    if(var_11 < 0.573576 && !istrue(level.skipstealthcanseecheck)) {
      var_0.spottedplayer = undefined;
      return 0;
    }

    var_3 = istrue(var_3);
    var_12 = var_1 getstance();
    var_13 = 1;
    var_14 = 1;
    var_15 = var_1 getvelocity();
    var_16 = length(var_15);

    if(var_16 < 128)
      var_13 = 0.75;
    else if(var_16 < 200 || var_4 && var_1.skill_data["_encstr_830E086EE82B0B361D86"].stealth_velocity_override)
      var_13 = 1;
    else
      var_13 = 1.25;

    if(var_12 == "_encstr_A5AD069B231F0BAF" && var_7 <= int(var_5.standdetectdist * var_11 * var_13 * var_14) && (!var_3 || canpathtotarget(var_0, var_1.origin))) {
      alertzombie(var_0, var_1, var_2);
      return 1;
    } else if(var_12 == "_encstr_B13D076BED70539F23" && var_7 <= int(var_5.crouchdetectdist * var_11 * var_13 * var_14) && (!var_3 || canpathtotarget(var_0, var_1.origin))) {
      alertzombie(var_0, var_1, var_2);
      return 1;
    } else if(var_12 != "_encstr_922406F1A6FD5E05" && var_7 <= int(var_5.pronedetectdist * var_11 * var_13 * var_14) && (!var_3 || canpathtotarget(var_0, var_1.origin))) {
      alertzombie(var_0, var_1, var_2);
      return 1;
    } else {
      var_0.spottedplayer = undefined;
      return 0;
    }
  } else {
    var_0.spottedplayer = undefined;
    return 0;
  }

  var_0.spottedplayer = undefined;
  return 0;
}

canpathtotarget(var_0, var_1) {
  if(!isDefined(level.findpathcount))
    level.findpathcount = 1;

  level.findpathcount = level.findpathcount + 1;
  var_2 = istrue(var_0.skiptraversals);
  var_3 = var_0 findpath(var_0.origin, var_1, 0, var_2);

  if(var_3.size >= 1 && distance(var_3[var_3.size - 1], var_1) <= 64)
    return 1;
  else
    return 0;
}

stealth_patrol(var_0) {
  var_1 = self;
  var_1 notify("_encstr_92310F87A1F5522C9838F93A31B07A0AD9");
  var_1 endon("_encstr_92310F87A1F5522C9838F93A31B07A0AD9");
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_BA22087EA808525BA5D9");
  var_1 endon("_encstr_BD420EB0C6ACC98ECA46BE13E5D785B4");
  var_1 endon("_encstr_ADE909AD87474FB75ACA79");
  var_1.og_goalradius = var_1.goalradius;

  if(!istrue(var_1.fake_stealth))
    var_1 waittill("_encstr_8890116616D62BD7CDD195B01B8E43BE9BB2E8");

  if(!isDefined(var_0))
    var_0 = var_1.origin;

  var_1 setstealthstate("_encstr_96080730D8534E0A28");
  var_2 = undefined;
  var_3 = undefined;

  for(;;) {
    var_4 = undefined;

    if(isDefined(var_1.patrol_state) && var_1.patrol_state != "_encstr_96080730D8534E0A28") {
      var_1.waitingforstealthstatechange = 1;
      var_1 waittill("_encstr_A1C716E2B31059F215F95FD7F9B7BB9519B9DCEE68A8E52A");
      var_1.waitingforstealthstatechange = undefined;
      continue;
    }

    if(istrue(var_1.scriptedstealth)) {
      if(isDefined(var_1.forcedpatrol)) {
        var_5 = getclosestpointonnavmesh(var_1.forcedpatrol.origin);

        if(isDefined(var_2))
          var_3 = var_2;

        var_2 = var_1.forcedpatrol;
        thread scripts\cp\cp_agent_patrol::setcooldown(var_1.forcedpatrol, 20);
        thread removeifalerted(var_1, var_1.forcedpatrol);
        _setgoalpos(var_1, var_5, 32);
        scripts\cp\cp_agent_patrol::unsetcooldown(var_1.forcedpatrol);
        var_1.forcedpatrol = undefined;
      } else {
        var_6 = scripts\engine\utility::get_array_of_closest(var_1.origin, level.allzpatrolpoints, undefined, 10);
        var_6 = var_1 getscoredpatrolpoints(var_1, var_6, [var_2, var_3], "_encstr_A26D0F9F2BE801D84F2197E54F2B9AC26A");

        if(isDefined(var_6)) {
          foreach(var_8 in var_6) {
            var_5 = getclosestpointonnavmesh(var_8.origin);

            if(distance(var_8.origin, var_5) <= 40 && canpathtotarget(var_1, var_5)) {
              if(isDefined(var_2))
                var_3 = var_2;

              var_2 = var_8;
              thread scripts\cp\cp_agent_patrol::setcooldown(var_8, 20);
              thread removeifalerted(var_1, var_8);
              _setgoalpos(var_1, var_5, 32);
              scripts\cp\cp_agent_patrol::unsetcooldown(var_8);
              break;
            } else {
              var_2 = undefined;
              var_3 = undefined;
            }
          }
        } else {
          var_2 = undefined;
          var_3 = undefined;
        }
      }
    }

    if(randomint(100) < 20)
      wait(randomfloatrange(2.5, 5));
  }
}

removeifalerted(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_A3130D9AF069D2310E87C1D9C03A82");
  var_0 endon("_encstr_8B7205D9ED5958");
  var_0 endon("_encstr_833608E0AB19F8A93A7F");
  var_0 scripts\engine\utility::_id_143A6("_encstr_AD75063D571AE108", "_encstr_BA22087EA808525BA5D9", "_encstr_BD420EB0C6ACC98ECA46BE13E5D785B4");
  scripts\cp\cp_agent_patrol::unsetcooldown(var_1);
}

cooldownpatrolpoint(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0.cooldown = 1;
  wait 20;
  var_0.cooldown = undefined;
}

getscoredpatrolpoints(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = level.allspatrolpoints;

  if(!isDefined(var_2))
    var_2 = [];
  else
    var_2 = scripts\engine\utility::array_removeundefined(var_2);

  if(!isDefined(var_3))
    var_3 = "_encstr_A7E80E1818902B623DBA872BD4C1184C";

  var_4 = 25;
  var_5 = scripts\cp\cp_agent_utils::getactiveagentsoftype(var_3);
  var_6 = sortbydistance(scripts\engine\utility::array_remove_array(var_1, var_2), var_0.origin);
  var_7 = [];
  var_8 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_5, undefined, 4, 256).size >= 3;
  var_9 = 5 / var_4;
  var_10 = 20 / var_4;

  foreach(var_12 in var_6) {
    var_13 = var_12.patrolscore;
    var_12.personalscore = 0;
    var_14 = 250;
    var_15 = distance(var_0.origin, var_12.origin);

    if(var_8 && var_15 <= 500)
      var_14 = 500;
    else if(var_15 >= 1500)
      var_14 = 500;
    else {
      var_16 = scripts\engine\math::get_dot(var_0.origin, anglesToForward(var_0.angles), var_12.origin);

      if(isDefined(var_12.target)) {
        var_17 = scripts\engine\utility::getStructArray(var_12.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

        if(var_17.size > 1) {
          var_18 = var_10 * 500;
          var_14 = var_14 - var_18;
        }

        var_19 = var_9 * 500;
        var_14 = var_19 * var_16;
      } else
        var_14 = 500 * var_16;
    }

    var_14 = clamp(var_14, 0, 500);
    var_14 = clamp(var_14 + var_13, 0, 999);
    var_12.personalscore = int(var_14);
    var_7[var_7.size] = var_12;
  }

  var_21 = scripts\cp\utility::array_sort_by_handler(var_7, ::getpersonalpatrolscore);
  return var_21;
}

getpersonalpatrolscore() {
  if(isDefined(self.personalscore))
    return self.personalscore;
  else
    return 999;
}

getpatrolscore() {
  if(isDefined(self.patrolscore))
    return self.patrolscore;
  else
    return 0;
}

go_to_spot(var_0, var_1, var_2, var_3) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_BA22087EA808525BA5D9");
  var_0 endon("_encstr_BD420EB0C6ACC98ECA46BE13E5D785B4");
  var_0 endon("_encstr_82CA0D07613BCBD718F32F36E8F838");
  var_4 = getclosestpointonnavmesh(var_1);

  if(distance(var_4, var_1) <= 32 && canpathtotarget(var_0, var_4)) {
    var_0 notify("_encstr_ADE909AD87474FB75ACA79");
    var_0 endon("_encstr_ADE909AD87474FB75ACA79");
    var_0 setstealthstate(var_3);
    resetgoalpos(var_0);

    if(!isDefined(var_0.legacy)) {
      iprintln("_encstr_AFA12022D260ABD67958E403CD514EAC639A5B5D319FCB5FD897582660471EA1DAAE" + var_0 getentitynumber() + "_encstr_87560B16401AAC168D8EA1E802" + var_0.health + "_encstr_87950A1601C29D95DCA34704" + var_0.agent_type);
      var_0.legacy = spawnStruct();
    }

    if(isDefined(var_2))
      var_0.legacy.movemode = var_2;
    else
      var_0.legacy.movemode = "_encstr_92100762872552A643";

    _setgoalpos(var_0, var_4, 32);
    var_0.legacy.movemode = "_encstr_97BC0AB9C67BDD7DDD851B6D";
    wait(getzombiestealthvalues(var_0).timehiddennolosbeforedeescalate);
    var_0 notify("_encstr_AD990EC9ACCD56A3FACD1D592CD8A30D");
  }
}

weapon_fire_monitor() {
  self notify("_encstr_A1E9148785F1F04F6851E5A7CA49E9F59060BAF3DF0A");
  self endon("_encstr_A1E9148785F1F04F6851E5A7CA49E9F59060BAF3DF0A");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19");
    level notify("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", self.origin, self getcurrentweapon(), self);
  }
}

player_weapon_listener(var_0) {
  var_0 notify("_encstr_AFBC171CB1B05E2BE47DEE56581CEDDCD7D8A5E6A359CDB2E4");
  var_0 endon("_encstr_AFBC171CB1B05E2BE47DEE56581CEDDCD7D8A5E6A359CDB2E4");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_BA22087EA808525BA5D9");
  var_0 endon("_encstr_82CA0D07613BCBD718F32F36E8F838");

  for(;;) {
    level waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", var_1, var_2, var_3, var_4);

    if(!istrue(var_0.scriptedstealth)) {
      continue;
    }
    if(isPlayer(var_3))
      var_5 = 2000 * var_3.skill_data["_encstr_830E086EE82B0B361D86"].stealth_weapon_noise_scalar;
    else
      var_5 = 2000;

    foreach(var_7 in var_2.attachments) {
      if(issubstr(var_7, "_encstr_AD3E09B95A632BDC6CCA27")) {
        var_5 = var_5 * 0.75;
        break;
      }
    }

    var_5 = int(var_5);

    if(distance(var_1, var_0.origin) > var_5)
      continue;
    else {
      var_0 thread go_to_spot(var_0, var_1, undefined, "_encstr_AFC91AFAA054E7AAD853EFF171E83527683BB2E20BA093E960BBF2FD");
      wait 0.5;
    }
  }
}

zombie_3dtext_handler() {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_AF4C0CA32B1EE81A16B98C639539");
  self endon("_encstr_AF4C0CA32B1EE81A16B98C639539");
  var_0 = self getentitynumber();

  for(;;) {
    if(getDvar("_encstr_857814AFC0C909AA9943A95ABB47D3EFD3685F3BD063") == "_encstr_B40101")
      level waittill("_encstr_A2E4141B2098EFE1A0A92D3181C074073E1BB2F3696E");

    if(isDefined(self.patrol_state)) {}

    waitframe();
  }
}

draw_fov() {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_A7D109D7F613A387119833");
  self endon("_encstr_A7D109D7F613A387119833");

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

  if(isDefined(level.zombie_stealth_table))
    var_0 = level.zombie_stealth_table;
  else
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
    var_4.losfov = cos(int(tablelookupbyrow(var_0, 21, var_1)));
    var_4.canseethroughfoliage = cos(int(tablelookupbyrow(var_0, 22, var_1)));
    level.zombie_stealth_values[int(var_3)] = var_4;
    var_1++;
  }
}

set_stealth_values(var_0, var_1) {
  if(isDefined(var_1))
    var_1 = int(clamp(var_1, 0, level.maxescalationvalue - 1));

  var_1 = int(max(var_1, 0));
  var_2 = spawnStruct();
  var_2.currentstealthlevel = int(var_1);
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
  var_2.canseethroughfoliage = level.zombie_stealth_values[var_1].canseethroughfoliage;
  var_0.stealthvals = var_2;
  setzombiestate(var_0, var_1);
  var_0 notify("_encstr_8C7C135ABD439AFC1BD8DF73B830BD820740225725");
}

setzombiestate(var_0, var_1) {
  var_2 = level.maxescalationvalue;

  switch (var_1) {
    case 10:
      var_0 setscriptablepartstate("_encstr_A9B10826EAC9374BCDB3", "_encstr_930B07BB1B6B3854FF");
      var_0 setscriptablepartstate("_encstr_B85D0D5893D82CB995EBBB86B4E859", "_encstr_930B07BB1B6B3854FF");
      var_0 setscriptablepartstate("_encstr_9BAD098D862B5B89EA39B9", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_88610A7A30ADDAFF5383464D", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_AF9C0847F32F37622B4A", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_AC190471F593", "_encstr_8882099673858D1D4B6756");
      break;
    case 9:
      var_0 setscriptablepartstate("_encstr_A9B10826EAC9374BCDB3", "_encstr_930B07BB1B6B3854FF");
      var_0 setscriptablepartstate("_encstr_B85D0D5893D82CB995EBBB86B4E859", "_encstr_930B07BB1B6B3854FF");
      var_0 setscriptablepartstate("_encstr_9BAD098D862B5B89EA39B9", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_88610A7A30ADDAFF5383464D", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_AF9C0847F32F37622B4A", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_AC190471F593", "_encstr_8882099673858D1D4B6756");
      break;
    case 8:
      var_0 setscriptablepartstate("_encstr_A9B10826EAC9374BCDB3", "_encstr_930B07BB1B6B3854FF");
      var_0 setscriptablepartstate("_encstr_B85D0D5893D82CB995EBBB86B4E859", "_encstr_930B07BB1B6B3854FF");
      var_0 setscriptablepartstate("_encstr_9BAD098D862B5B89EA39B9", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_88610A7A30ADDAFF5383464D", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_AF9C0847F32F37622B4A", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_AC190471F593", "_encstr_8882099673858D1D4B6756");
      break;
    case 7:
      var_0 setscriptablepartstate("_encstr_A9B10826EAC9374BCDB3", "_encstr_930B07BB1B6B3854FF");
      var_0 setscriptablepartstate("_encstr_B85D0D5893D82CB995EBBB86B4E859", "_encstr_930B07BB1B6B3854FF");
      var_0 setscriptablepartstate("_encstr_9BAD098D862B5B89EA39B9", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_88610A7A30ADDAFF5383464D", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_AF9C0847F32F37622B4A", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_AC190471F593", "_encstr_8882099673858D1D4B6756");
      break;
    case 6:
      var_0 setscriptablepartstate("_encstr_A9B10826EAC9374BCDB3", "_encstr_930B07BB1B6B3854FF");
      var_0 setscriptablepartstate("_encstr_B85D0D5893D82CB995EBBB86B4E859", "_encstr_930B07BB1B6B3854FF");
      var_0 setscriptablepartstate("_encstr_9BAD098D862B5B89EA39B9", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_88610A7A30ADDAFF5383464D", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_AF9C0847F32F37622B4A", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_AC190471F593", "_encstr_8882099673858D1D4B6756");
      break;
    case 5:
      var_0 setscriptablepartstate("_encstr_A9B10826EAC9374BCDB3", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_B85D0D5893D82CB995EBBB86B4E859", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_9BAD098D862B5B89EA39B9", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_88610A7A30ADDAFF5383464D", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_AF9C0847F32F37622B4A", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_AC190471F593", "_encstr_930B07BB1B6B3854FF");
      break;
    case 4:
      var_0 setscriptablepartstate("_encstr_A9B10826EAC9374BCDB3", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_B85D0D5893D82CB995EBBB86B4E859", "_encstr_930B07BB1B6B3854FF");
      var_0 setscriptablepartstate("_encstr_9BAD098D862B5B89EA39B9", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_88610A7A30ADDAFF5383464D", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_AF9C0847F32F37622B4A", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_AC190471F593", "_encstr_8882099673858D1D4B6756");
      break;
    case 3:
      var_0 setscriptablepartstate("_encstr_A9B10826EAC9374BCDB3", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_B85D0D5893D82CB995EBBB86B4E859", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_9BAD098D862B5B89EA39B9", "_encstr_930B07BB1B6B3854FF");
      var_0 setscriptablepartstate("_encstr_88610A7A30ADDAFF5383464D", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_AF9C0847F32F37622B4A", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_AC190471F593", "_encstr_8882099673858D1D4B6756");
      break;
    case 2:
      var_0 setscriptablepartstate("_encstr_A9B10826EAC9374BCDB3", "_encstr_930B07BB1B6B3854FF");
      var_0 setscriptablepartstate("_encstr_B85D0D5893D82CB995EBBB86B4E859", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_9BAD098D862B5B89EA39B9", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_88610A7A30ADDAFF5383464D", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_AF9C0847F32F37622B4A", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_AC190471F593", "_encstr_8882099673858D1D4B6756");
      break;
    case 1:
      var_0 setscriptablepartstate("_encstr_A9B10826EAC9374BCDB3", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_B85D0D5893D82CB995EBBB86B4E859", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_9BAD098D862B5B89EA39B9", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_88610A7A30ADDAFF5383464D", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_AF9C0847F32F37622B4A", "_encstr_930B07BB1B6B3854FF");
      var_0 setscriptablepartstate("_encstr_AC190471F593", "_encstr_8882099673858D1D4B6756");
      break;
    default:
      var_0 setscriptablepartstate("_encstr_A9B10826EAC9374BCDB3", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_B85D0D5893D82CB995EBBB86B4E859", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_9BAD098D862B5B89EA39B9", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_88610A7A30ADDAFF5383464D", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_AF9C0847F32F37622B4A", "_encstr_8882099673858D1D4B6756");
      var_0 setscriptablepartstate("_encstr_AC190471F593", "_encstr_8882099673858D1D4B6756");
      break;
  }
}

show_spotted_text(var_0) {
  if(!isDefined(var_0.last_spotted_vo) || gettime() >= var_0.last_spotted_vo + 5000) {
    var_0.last_spotted_vo = gettime();

    if(!istrue(level.disable_you_spotted_message))
      var_0 iprintlnbold("_encstr_82191583F57B67EB459A13209796E907D31D8D9DCFC233");
  }
}

increasecurrentstealthvalue(var_0) {
  if(isDefined(var_0.stealthvals) && isDefined(var_0.stealthvals.currentstealthlevel)) {
    var_1 = clamp(var_0.stealthvals.currentstealthlevel + 1, 0, level.maxescalationvalue - 1);
    set_stealth_values(var_0, int(var_1));
  }
}

decreasecurrentstealthvalue(var_0) {
  if(isDefined(var_0.stealthvals) && isDefined(var_0.stealthvals.currentstealthlevel)) {
    var_1 = clamp(var_0.stealthvals.currentstealthlevel - 1, 0, level.maxescalationvalue - 1);
    set_stealth_values(var_0, int(var_1));
  }
}

getzombiestealthvalues(var_0) {
  if(isDefined(var_0.stealthvals))
    return var_0.stealthvals;
  else
    return undefined;
}

monitorzawarenesslevel(var_0) {
  var_0 notify("_encstr_91BC17B6DE9BA53AF69C2D05DDC2E4CACDB26ECD132BECB2C6");
  var_0 endon("_encstr_91BC17B6DE9BA53AF69C2D05DDC2E4CACDB26ECD132BECB2C6");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8BDE20E32F4B613B99E53F92677A06DBC71963F78E784FA329C39103C97AA8C46B98");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0.zombieawarenesslevel = 0;
  var_1 = 100;
  var_2 = 0;

  for(;;) {
    if(scripts\engine\utility::flag("_encstr_B20916F44651F7ACCFE8A24A9883A24F88A07E9D51797BB3")) {
      if(var_0 scripts\cp\utility::is_valid_player()) {
        var_3 = var_0 getvelocity();
        var_4 = length(var_3);

        if(var_4 < 64)
          var_2 = var_2 + 2;
        else if(var_4 > 64 && var_4 < 128)
          var_2 = var_2 + 1;
        else if(var_4 > 350)
          var_2 = var_2 - 10;
        else if(var_4 > 200)
          var_2 = var_2 - 5;

        var_2 = clamp(var_2, 0, var_1);

        if(var_2 >= var_1) {
          thread sendzombiehorde(var_0);
          var_2 = 0;
          wait 10;
        }
      }
    }

    wait 0.25;
  }
}

sendzombiehorde(var_0) {
  if(istrue(var_0.ignoreme)) {
    return;
  }
  var_1 = scripts\cp\cp_agent_utils::getactiveagentsoftype("_encstr_A26D0F9F2BE801D84F2197E54F2B9AC26A");
  var_2 = sortbydistance(var_1, var_0.origin);
  var_3 = 10;
  var_4 = 0;

  foreach(var_6 in var_2) {
    if(istrue(var_6.fake_stealth)) {
      var_7 = var_6 getstealthstate();

      if(isDefined(var_7) && var_7 == "_encstr_96080730D8534E0A28") {
        var_6 thread go_to_spot(var_6, var_0.origin, "_encstr_B4190493D573", "_encstr_93C6180FE808BC39396009FAD93B937553D1FBF7C040F4027788");
        var_4++;

        if(var_4 >= var_3) {
          break;
        }
      }
    }
  }
}

spawn_ambient_zombie(var_0) {
  var_1 = undefined;

  if(!isDefined(var_1))
    return 0;

  if(!isDefined(var_1.script_parameters))
    var_1.script_parameters = "_encstr_A76E173B9CF6BA3732F59BC11677B97DE6BD7D26DE16E419E6";

  if(var_1.script_parameters != "_encstr_A76E173B9CF6BA3732F59BC11677B97DE6BD7D26DE16E419E6")
    iprintlnbold("_encstr_99690A3306B2BAB3E0E32488");

  var_2 = var_1[[level.spawn_wave_enemy_func]]("_encstr_A26D0F9F2BE801D84F2197E54F2B9AC26A", 1, var_1);

  if(isDefined(var_2)) {
    if(istrue(var_0.skiptraversals))
      var_2.skiptraversals = 1;

    if(istrue(var_0.dontkilloff))
      var_2.dontkilloff = 1;

    if(isDefined(var_1.target))
      var_2.forcedpatrol = scripts\engine\utility::random(scripts\engine\utility::getStructArray(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));

    if(isDefined(var_0.threatbiasoverride))
      var_2.threatbiasoverride = var_0.threatbiasoverride;

    var_1.lastspawntime = gettime();
    var_2.killofftime = gettime() + 10000;
    var_2 emissiveblend(1, 0.1);
    var_2 thread default_ambient_vals(var_2, var_0, 1);
    return 1;
  }

  return 0;
}

default_ambient_vals(var_0, var_1, var_2) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.iszombie = 1;
  var_0.dont_scriptkill = 1;
  var_0.dont_cleanup = 1;
  var_0.enemy_group = var_1.group_name;
  var_0.moduleid = var_1.moduleid;
  var_0.group = var_1;
  var_0.group.activecount++;
  var_3 = getdvarint("_encstr_8214146E6C4EAFA53799ACB1D15619EB1A2B85B1E8D0", 160);
  var_0.maxhealth = var_3;
  var_0.health = var_3;
  activatezombiestealth(var_0, var_2);
}

updatezombiegroupname(var_0, var_1) {
  var_0.enemy_group = var_1.group_name;
}

activatezombiestealth(var_0, var_1) {
  var_0 thread zombiescriptedstealth(var_0, var_1);
}

_setgoalpos(var_0, var_1, var_2) {
  var_0 notify("_encstr_81A4177BC3A8D98FA031E2D93B888781F0BBF1E56B28DB4FDD");
  var_0 endon("_encstr_81A4177BC3A8D98FA031E2D93B888781F0BBF1E56B28DB4FDD");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_833608E0AB19F8A93A7F");

  if(isDefined(var_2))
    var_0.goalradius = var_2;
  else
    var_0.goalradius = 32;

  var_3 = 0;

  foreach(var_5 in level.nearbyposarray) {
    if(distance(var_5, var_1) <= 32) {
      var_3 = 1;
      break;
    }
  }

  var_7 = 1;

  if(var_3) {
    var_8 = getrandomnavpoints(var_1, 128, 10, undefined, getrandomnavpoint(var_1, 64), 128);
    var_9 = 0;

    foreach(var_11 in var_8) {
      var_7 = 0;

      foreach(var_5 in level.nearbyposarray) {
        if(distance(var_5, var_11) <= 32) {
          var_7 = 1;
          break;
        }
      }

      if(!var_7) {
        var_1 = var_11;
        break;
      }
    }
  }

  thread manageposarray(var_0, var_1);
  var_0 setgoalpos(var_1);
  var_15 = var_0 scripts\engine\utility::_id_143AD("_encstr_8B7205D9ED5958", "_encstr_A3130D9AF069D2310E87C1D9C03A82");
}

manageposarray(var_0, var_1) {
  level.nearbyposarray[level.nearbyposarray.size] = var_1;
  var_2 = var_0 scripts\engine\utility::waittill_any_in_array_return(["_encstr_AD75063D571AE108", "_encstr_81A4177BC3A8D98FA031E2D93B888781F0BBF1E56B28DB4FDD", "_encstr_BA22087EA808525BA5D9", "_encstr_82CA0D07613BCBD718F32F36E8F838", "_encstr_ADE909AD87474FB75ACA79", "_encstr_BD420EB0C6ACC98ECA46BE13E5D785B4"]);

  if(scripts\engine\utility::array_contains(level.nearbyposarray, var_1))
    level.nearbyposarray = scripts\engine\utility::array_remove(level.nearbyposarray, var_1);
}

resetgoalpos(var_0) {
  var_0 setgoalpos(self.origin);
  var_0 scripts\engine\utility::_id_143A5("_encstr_8B7205D9ED5958", "_encstr_A3130D9AF069D2310E87C1D9C03A82");
}