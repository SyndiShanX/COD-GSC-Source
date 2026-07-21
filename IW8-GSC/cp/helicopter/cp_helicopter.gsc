/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\helicopter\cp_helicopter.gsc
***********************************************/

heli_precache() {
  level._effect["_encstr_A27B0C1A71177AB53E782B6FB870"] = loadfx("_encstr_8E3C2D67CC1E79D8B7E4CA97E6B56DD12785A563CB37ADDBDAB2AFD19CB09663F5EED0D2E8957D43951BA5719D99C3");
  level._effect["_encstr_B87011F355B2609793E9B902034B58788CA765"] = loadfx("_encstr_BE1723B3330F5EB17B27CACB95F01C8DE50B9539A5B0B1D75687C163DB6E5A7B9BE2CE3387");
  level._effect["_encstr_8215172CAC4EB48536D7AC3CC1C6DB6E5A7BB97DD8C239B356"] = loadfx("_encstr_A3462E0426A3A08F9573701A3A68618D26C905FEB16F70AF7FBBD00872426B384B4F1BFD1C375E01A60370587E5B3D12");
  level._effect["_encstr_B2C50FC873BFC32992221816BA8A75E80B"] = loadfx("_encstr_8F1A37DE94AA1EC4775279B2F82F7DCF838D5C0FBEF3970A29F0611A68AD7483D9E397EE445A4FD639B89B7360C5210793DF327B6668A3DFE1");
  level._effect["_encstr_AA5613F59DC0480F1F8B12105A85DB409DB91956A1"] = loadfx("_encstr_A222356B4B320EC0EF71B2E7BA8B2D5D532E3AF11BC757C32632BF297ADEF94B77A98B706E23281877A3B769B178F193B8FFD13D3BD170");
  level._effect["_encstr_91940F1BD14B275EE85BC7C671B8225F6E"] = loadfx("_encstr_8AD4322327D2AD98742B5F8837D732731A7AEE2BF2519BF2081C4FA37187EF8E01FB5379731260451BA98F19A62E718FDD131380");
}

heli_mg_create(var_0, var_1, var_2, var_3) {
  var_4 = "_encstr_A14F0AE336178944BA076F41";

  if(isDefined(var_2))
    var_4 = var_2;

  var_5 = (0, 0, 0);

  if(isDefined(var_3))
    var_6 = var_3;

  var_7 = self gettagorigin(var_4);

  if(!isDefined(var_1))
    var_1 = "_encstr_ACA312FBB97D1B1EFB17451B90AB4F05ED9FD043";

  if(isDefined(level.heli_minigun_override))
    var_1 = level.heli_minigun_override;

  self.minigun = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_7, var_1);
  self.minigun.angles = self gettagangles(var_4);

  if(isDefined(var_0))
    self.minigun setModel(var_0);
  else
    self.minigun setModel("_encstr_82BC202BBF802A40225FD9B7978A1EC92154B0E327FC12AD393313F5E3126581EFED");

  self.minigun setmode("_encstr_849007B268BD03DFD8");
  self.minigun setdefaultdroppitch(0);
  self.minigun setleftarc(360);
  self.minigun setrightarc(360);
  self.minigun settoparc(5);
  self.minigun setbottomarc(90);
  self.minigun setconvergencetime(0.05, "_encstr_AF1904C7E3A4");
  self.minigun setconvergencetime(0.05, "_encstr_BD6506F36A2B46B0");
  self.minigun linkTo(self, var_4, var_5, (0, 0, 0));
  self.minigun setturretteam("_encstr_8E8405EA382B2A");
  self.minigun.chopper = self;
  thread scripts\engine\utility::delete_on_death(self.minigun);
}

heli_dmg_sparks() {
  self endon("_encstr_AD75063D571AE108");
  playFXOnTag(level._effect["_encstr_A27B0C1A71177AB53E782B6FB870"], self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_0 = 0;

  for(;;) {
    wait(randomfloatrange(0.2, 3));
    playFX(level._effect["_encstr_B2C50FC873BFC32992221816BA8A75E80B"], self.origin + (randomintrange(-100, 100), randomintrange(-50, 50), randomintrange(-100, 0)));
  }
}

heli_think_default(var_0, var_1, var_2) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_82EB0B8CEDA735C29963C6FF01");

  if(isDefined(var_2))
    var_1 = scripts\engine\utility::getStructArray(var_2, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B")[0].origin[2];
  else if(!isDefined(var_1))
    var_1 = scripts\engine\utility::getStructArray("_encstr_A37A0C630B892AE72801FE02F9C8", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B")[0].origin[2];

  var_0.chopper_height = var_1;
  var_0 thread rumble_nearby_players();
  level thread evasive_think(var_0);
  var_0.minigun setmode("_encstr_849007B268BD03DFD8");
  var_0.nextfiretime = gettime() + 2000;
  var_3 = 0;
  var_4 = 5;
  var_0 vehicle_setspeed(50, 30);

  for(;;) {
    if(var_0.needs_to_evade) {
      var_0 notify("_encstr_A501062B67C22395");
      var_0 waittill("_encstr_8FB414155441A73C8D70A15A58D1749FD8A89C87E069");
      var_0.circling_target = 0;
      var_0.needs_to_evade = 0;
    }

    var_5 = var_0 heli_get_target(undefined, 0);

    if(!isDefined(var_5)) {
      wait 1;
      var_3 = var_3 + 1;

      if(var_3 > var_4) {
        var_0 heli_go_search(undefined, undefined, var_2);
        var_5 = var_0.best_target;
        var_3 = 0;
      } else
        continue;
    }

    if(var_0 should_move_to_target(var_0.minigun, var_5))
      var_0 heli_move_to_target(var_5);

    if(istrue(var_0.nocircle))
      var_0 thread engage_target_from_pos(var_5);
    else
      var_0 thread engage_target_circle_strafe(var_5, var_1);

    var_0 scripts\engine\utility::_id_143BA(60, "_encstr_96EF0FA30BC9D9B21DEB56E6CE583BCA46", "_encstr_B8950FB9AC59C8DCF5E8F6AF5667C246CA");
    var_0.nocircle = 0;
  }
}

heli_rocket_think_default(var_0) {
  if(!isDefined(var_0) || !isalive(var_0)) {
    return;
  }
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 = scripts\engine\utility::getStructArray("_encstr_A37A0C630B892AE72801FE02F9C8", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B")[0].origin[2];
  var_0.has_rockets = 1;
  var_0.chopper_height = var_1;
  var_0 thread rumble_nearby_players();

  if(!isDefined(var_0.evade_radius))
    var_0.evade_radius = 2000;

  var_0.rockets_ready = 1;
  level thread evasive_think(var_0);

  if(isDefined(var_0.minigun))
    var_0.minigun setmode("_encstr_849007B268BD03DFD8");

  var_0.nextfiretime = gettime() + 2000;
  var_2 = 0;
  var_3 = 5;
  var_0 vehicle_setspeed(50, 30);

  for(;;) {
    if(var_0.needs_to_evade) {
      var_0 notify("_encstr_A501062B67C22395");
      var_0 waittill("_encstr_8FB414155441A73C8D70A15A58D1749FD8A89C87E069");
      var_0.circling_target = 0;
      var_0.needs_to_evade = 0;
    }

    if(istrue(var_0.force_search)) {
      var_0 heli_go_search();
      var_4 = var_0.best_target;
      var_2 = 0;
    } else {
      var_4 = var_0 heli_get_target(undefined, 0);

      if(!isDefined(var_4)) {
        wait 1;
        var_2 = var_2 + 1;

        if(var_2 > var_3) {
          var_0 heli_go_search();
          var_4 = var_0.best_target;
          var_2 = 0;
        } else
          continue;
      }
    }

    if(var_0 should_move_to_target(var_0, var_4))
      var_0 heli_move_to_target(var_4);

    if(istrue(var_0.nocircle))
      var_0 thread engage_target_from_pos(var_4);
    else
      var_0 thread engage_target_circle_strafe(var_4, var_1);

    var_0 scripts\engine\utility::_id_143A5("_encstr_96EF0FA30BC9D9B21DEB56E6CE583BCA46", "_encstr_B8950FB9AC59C8DCF5E8F6AF5667C246CA");
  }
}

heli_move_to_target(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self cleartargetyaw();
  self cleargoalyaw();
  self setlookatent(var_0);
  var_1 = (self.gotopos[0], self.gotopos[1], self.chopper_height);

  if(distance2dsquared(self.origin, var_1) > 640000) {
    self setneargoalnotifydist(300);
    self vehicle_setspeed(50, 30, 30);
    self setvehgoalpos(var_1, 1);
  } else {
    self vehicle_setspeed(15, 12, 12);
    self setvehgoalpos(var_1, 0);
  }

  scripts\engine\utility::_id_143BB(15, "_encstr_8B7205D9ED5958", "_encstr_A3130D9AF069D2310E87C1D9C03A82", "_encstr_B4D10ADC950BE4EB76DE8536");
}

engage_target_circle_strafe(var_0, var_1) {
  self endon("_encstr_B8950FB9AC59C8DCF5E8F6AF5667C246CA");
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  thread circle_around_target(var_0, var_1);
  self setlookatent(var_0);

  if(isDefined(self.minigun))
    self.minigun settargetentity(var_0, (0, 0, 40));

  var_2 = undefined;

  while(istrue(self.circling_target)) {
    var_3 = heli_can_target(var_0, (0, 0, 60));

    if(!var_3) {
      self clearlookatent();

      if(isDefined(self.rockets))
        var_4 = self gettagorigin("_encstr_8A93108CA9C9994B4A3B72A933B73A0891DC");
      else
        var_4 = self.minigun gettagorigin("_encstr_A14F0AE336178944BA076F41");

      var_2 = choose_new_target(var_4);

      if(!isDefined(var_2)) {
        self notify("_encstr_BA610EEBAD7853594FC85B4208B3CDD7");
        waitframe();
        self notify("_encstr_96EF0FA30BC9D9B21DEB56E6CE583BCA46");
        return;
      } else {
        var_3 = 1;

        if(isDefined(self.minigun))
          self.minigun settargetentity(var_2);

        self setlookatent(var_2);
      }
    }

    if(isDefined(self.minigun)) {
      var_5 = scripts\engine\utility::waittill_any_ents_or_timeout_return(2, self.minigun, "_encstr_97881123FB639E8883C74F55DF6B6066CF12BB");

      if(var_5 != "_encstr_97881123FB639E8883C74F55DF6B6066CF12BB")
        continue;
    }

    if(istrue(self.has_rockets)) {
      if(istrue(self.rockets_ready)) {
        if(isDefined(var_2))
          hover_and_shoot_rockets(var_2);
        else
          hover_and_shoot_rockets(var_0);
      }

      continue;
    }

    if(isDefined(var_2))
      shoot_at_target(var_2);
    else
      shoot_at_target(var_0);

    wait(randomintrange(2, 4));
  }

  self notify("_encstr_96EF0FA30BC9D9B21DEB56E6CE583BCA46");
}

engage_target_from_pos(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self sethoverparams(150, 35, 35);

  if(!istrue(self.has_rockets)) {
    self.minigun settargetentity(var_0, (0, 0, 40));
    var_1 = scripts\engine\utility::waittill_any_ents_or_timeout_return(3, self.minigun, "_encstr_97881123FB639E8883C74F55DF6B6066CF12BB");
  } else
    wait 2;

  if(istrue(self.has_rockets)) {
    if(istrue(self.rockets_ready))
      hover_and_shoot_rockets(var_0);
  } else
    shoot_at_target(var_0);

  self notify("_encstr_96EF0FA30BC9D9B21DEB56E6CE583BCA46");
  self sethoverparams(0, 0, 0);
}

choose_new_target(var_0) {
  var_1 = 3500;

  if(isDefined(self.new_target_dist))
    var_1 = self.new_target_dist;

  var_2 = var_1 * var_1;

  foreach(var_4 in level.players) {
    if(!var_4 scripts\cp\utility::is_valid_player() || distance2dsquared(var_0, var_4.origin) > var_2) {
      continue;
    }
    if(!heli_can_target(var_4)) {
      continue;
    }
    return var_4;
  }

  return undefined;
}

shoot_at_target(var_0) {
  var_1 = randomintrange(20, 30);
  self.minigun startbarrelspin();
  wait 2;

  if(isPlayer(var_0) && var_0 scripts\cp\utility::_hasperk("_encstr_8E0E159E3A72E73079A3A8C8879308359A229530557B8F"))
    wait 2;

  var_2 = getcompleteweaponname("_encstr_B1DA118FE9B73268D01EF3BB9340ADFBAF6753");
  var_3 = weaponfiretime(var_2);

  for(var_4 = 0; var_4 < var_1; var_4++) {
    self.minigun shootturret();
    wait(var_3);
  }

  self.minigun stopbarrelspin();
  wait 2;
}

shoot_rockets_at_target(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B8950FB9AC59C8DCF5E8F6AF5667C246CA");
  thread rocket_fire_cooldown(5);
  var_1 = 100;

  for(var_2 = 0; var_2 < 1; var_2++) {
    var_3 = var_0.origin;
    var_4 = self gettagorigin("_encstr_9BE9111B5097819BA0F62B5D15CED354CFB0A3");
    var_5 = self gettagangles("_encstr_9BE9111B5097819BA0F62B5D15CED354CFB0A3");
    var_6 = (0, 0, 30);
    var_7 = randomintrange(-20, 20);
    var_8 = randomintrange(-20, 20);
    var_3 = (var_3[0] + var_7, var_3[1] + var_8, var_3[2]);
    var_3 = var_3 + var_6;

    if(scripts\engine\utility::within_fov(var_4, var_5, var_3, cos(45))) {
      playFXOnTag(level._effect["_encstr_AA5613F59DC0480F1F8B12105A85DB409DB91956A1"], self, "_encstr_9BE9111B5097819BA0F62B5D15CED354CFB0A3");
      var_9 = anglesToForward(var_5);
      var_9 = var_9 * var_1;
      var_4 = var_4 + var_9;
      var_10 = "_encstr_990816687738C9790BF853936BC8F633B130726DC1295023";
      var_11 = magicbullet(var_10, var_4, var_3);

      if(isDefined(var_11))
        var_11.owner = self;
    }

    wait 0.25;
    var_4 = self gettagorigin("_encstr_8A93108CA9C9994B4A3B72A933B73A0891DC");
    var_5 = self gettagangles("_encstr_8A93108CA9C9994B4A3B72A933B73A0891DC");
    var_6 = (0, 0, 30);
    var_7 = randomintrange(-20, 20);
    var_8 = randomintrange(-20, 20);
    var_3 = (var_3[0] + var_7, var_3[1] + var_8, var_3[2]);
    var_3 = var_3 + var_6;

    if(scripts\engine\utility::within_fov(var_4, var_5, var_3, cos(45))) {
      playFXOnTag(level._effect["_encstr_AA5613F59DC0480F1F8B12105A85DB409DB91956A1"], self, "_encstr_8A93108CA9C9994B4A3B72A933B73A0891DC");
      var_9 = anglesToForward(var_5);
      var_9 = var_9 * var_1;
      var_4 = var_4 + var_9;
      var_10 = "_encstr_990816687738C9790BF853936BC8F633B130726DC1295023";
      var_11 = magicbullet(var_10, var_4, var_3);

      if(isDefined(var_11))
        var_11.owner = self;
    }

    wait 0.5;
  }

  wait 2;
}

rocket_fire_cooldown(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self.rockets_ready = 0;
  wait(var_0);
  self.rockets_ready = 1;
}

hover_and_shoot_rockets(var_0) {
  self endon("_encstr_B8950FB9AC59C8DCF5E8F6AF5667C246CA");
  self notify("_encstr_BA610EEBAD7853594FC85B4208B3CDD7");
  self.hovering = 1;
  self sethoverparams(25, 15, 10);
  self vehicle_setspeed(10, 10, 10);

  if(isPlayer(var_0) && var_0 scripts\cp\utility::_hasperk("_encstr_8E0E159E3A72E73079A3A8C8879308359A229530557B8F"))
    wait 2;

  shoot_rockets_at_target(var_0);
  self.hovering = 0;
}

heli_get_target(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = self.origin;

  var_2 = undefined;
  var_3 = scripts\engine\utility::get_array_of_closest(var_0, level.players, undefined, undefined);

  foreach(var_5 in var_3) {
    if(!var_5 scripts\cp\utility::is_valid_player(undefined, 0) || istrue(var_5 isinfreefall()) || istrue(var_5 isskydiving()) || istrue(var_5 isparachuting())) {
      continue;
    }
    var_0 = (var_5.origin[0], var_5.origin[1], self.chopper_height);

    if(isDefined(var_5.vehicle))
      var_6 = [self, var_5, var_5.vehicle];
    else
      var_6 = [self, var_5];

    if(!istrue(self.has_rockets)) {
      if(scripts\engine\trace::ray_trace_passed(var_0, var_5.origin + (0, 0, 10), var_6)) {
        var_2 = var_5;
        self.gotopos = var_0;
      }
    }

    if(!isDefined(var_2)) {
      var_7 = anglestoright(var_5.angles);
      var_8 = anglestoleft(var_5.angles);
      var_9 = anglesToForward(var_5.angles);
      var_10 = var_9 * -1;
      var_11 = [var_7, var_8, var_9, var_10];

      foreach(var_13 in var_11) {
        var_0 = (var_5.origin[0], var_5.origin[1], 0) + (var_13[0], var_13[1], 0) * 1800 + (0, 0, self.chopper_height);

        if(scripts\engine\trace::ray_trace_passed(var_0, var_5.origin + (0, 0, 10), var_6)) {
          var_2 = var_5;
          self.gotopos = var_0;
          self.nocircle = 1;
          return var_2;
        }
      }
    }

    if(isDefined(var_2)) {
      break;
    }
  }

  return var_2;
}

heli_can_target(var_0, var_1) {
  var_2 = 3500;

  if(isDefined(self.heli_can_target_dist))
    var_2 = self.heli_can_target_dist;

  if(!var_0 scripts\cp\utility::is_valid_player() || distance2d(self.origin, var_0.origin) > var_2)
    return 0;

  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  var_3 = self.minigun gettagorigin("_encstr_A14F0AE336178944BA076F41");
  var_4 = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 1, 0, 1);
  var_5 = [var_0 gettagorigin("_encstr_AADA07DBF19A4A81D7"), var_0 gettagorigin("_encstr_8FE10B52092BB64F28E6B7BFFD"), var_0 gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37")];

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    if(!scripts\engine\trace::ray_trace_passed(var_3 + var_1, var_5[var_6], self, var_4)) {
      continue;
    }
    return 1;
  }

  return 0;
}

heli_go_search(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8B260DD0878CA848FA4333E5DB422D");

  if(isDefined(var_0))
    var_3 = var_0;
  else if(isDefined(var_2))
    var_3 = scripts\engine\utility::getclosest(self.origin, scripts\engine\utility::getStructArray(var_2, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"));
  else
    var_3 = scripts\engine\utility::getclosest(self.origin, scripts\engine\utility::getStructArray("_encstr_A37A0C630B892AE72801FE02F9C8", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"));

  self clearlookatent();
  self cleartargetyaw();
  self cleargoalyaw();

  if(isDefined(self.minigun))
    self.minigun cleartargetentity();

  var_4 = scripts\engine\utility::getStruct(var_3.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  self setvehgoalpos(var_3.origin, 0);
  thread heli_check_players();
  scripts\engine\utility::_id_143BA(15, "_encstr_8B7205D9ED5958", "_encstr_A3130D9AF069D2310E87C1D9C03A82");
  self vehicle_setspeed(30, 15);
  self setneargoalnotifydist(500);

  for(;;) {
    self setvehgoalpos(var_4.origin, 0);
    scripts\engine\utility::_id_143BA(15, "_encstr_8B7205D9ED5958", "_encstr_A3130D9AF069D2310E87C1D9C03A82");
    var_4 = scripts\engine\utility::getStruct(var_4.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  }
}

heli_check_players() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8B260DD0878CA848FA4333E5DB422D");
  self endon("_encstr_A501062B67C22395");
  self.best_target = undefined;

  for(;;) {
    var_0 = heli_get_target(undefined, 0);

    if(!isDefined(var_0)) {
      wait 1;
      continue;
    } else
      break;
  }

  self vehicle_setspeed(50, 30);
  self.best_target = var_0;
  self notify("_encstr_8B260DD0878CA848FA4333E5DB422D");
}

evasive_think(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");

  if(!isDefined(var_0.needs_to_evade))
    var_0.needs_to_evade = 0;

  while(var_0.health_remaining > 0) {
    var_0 waittill("_encstr_A501062B67C22395", var_1);
    var_0.circling_target = 0;
    var_0 thread heli_evade((var_0.origin[0], var_0.origin[1], var_0.chopper_height));
    var_0 waittill("_encstr_8FB414155441A73C8D70A15A58D1749FD8A89C87E069");
  }
}

should_move_to_target(var_0, var_1) {
  var_2 = 3400;

  if(isDefined(self.should_move_to_target_dist))
    var_2 = self.should_move_to_target_dist;

  if(istrue(self.landed)) {
    self.landed = undefined;
    return 1;
  }

  if(distance2d(var_0.origin, var_1.origin) > var_2 || isDefined(self.gotopos) && distance(var_0.origin, self.gotopos) > var_2)
    return 1;

  return 0;
}

rumble_nearby_players() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    playrumbleonposition("_encstr_97011287E9A8326880FBF2BF9329BAEB19652317", self.origin);
    wait 0.1;
  }
}

circle_around_target(var_0, var_1) {
  self endon("_encstr_A501062B67C22395");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA610EEBAD7853594FC85B4208B3CDD7");

  if(!isDefined(var_0) || !isDefined(var_0.origin)) {
    return;
  }
  if(!isDefined(var_0.origin[0]) || !isDefined(var_0.origin[1])) {
    return;
  }
  self.circling_target = 1;
  var_2 = 1500;

  if(isDefined(self.circle_radius))
    var_2 = self.circle_radius;

  var_3 = (var_0.origin[0], var_0.origin[1], var_1);
  var_4 = create_radius_around_point(var_3, 6, var_2);
  var_5 = 0;
  var_6 = var_4[0];
  var_7 = distance2dsquared(self.origin, var_4[0].origin);

  foreach(var_11, var_9 in var_4) {
    var_10 = distance2dsquared(self.origin, var_9.origin);

    if(var_10 < var_7) {
      var_7 = var_10;
      var_6 = var_9;
      var_5 = var_11;
    }
  }

  self.veh_goal_pos = var_4[var_5].origin;
  self setvehgoalpos(var_4[var_5].origin);
  self setneargoalnotifydist(30);
  self vehicle_setspeed(12, 10, 10);
  self.veh_speed_vals = (12, 10, 10);
  self.can_rocket_hover = 1;
  var_12 = 0;
  var_11 = var_5 + 1;

  while(var_12 < var_4.size - 1) {
    while(istrue(self.hovering))
      wait 0.1;

    if(var_11 >= var_4.size)
      var_11 = 0;

    if(!isalive(var_0)) {
      break;
    }

    var_13 = var_0.origin + (0, 0, 60);

    if(!sighttracepassed(var_4[var_11].origin, var_13, 0, undefined)) {
      wait 0.1;
      var_12++;
      var_11++;
      continue;
    }

    self.veh_goal_pos = var_4[var_11].origin;
    self setvehgoalpos(var_4[var_11].origin, 1);
    scripts\engine\utility::waittill_notify_or_timeout("_encstr_B4D10ADC950BE4EB76DE8536", 60);
    var_12++;
    var_11++;
  }

  self.can_rocket_hover = 0;
  self.circling_target = 0;
}

create_radius_around_point(var_0, var_1, var_2) {
  var_3 = 360 / var_1;
  var_4 = [];
  var_5 = (1, 0, 0);

  for(var_6 = 0; var_6 < 360; var_6 = var_6 + var_3) {
    var_7 = var_5 * var_2;
    var_8 = (cos(var_6) * var_7[0] - sin(var_6) * var_7[1], sin(var_6) * var_7[0] + cos(var_6) * var_7[1], var_7[2]);
    var_9 = var_0 + var_8;
    var_10 = spawnStruct();
    var_10.origin = var_9;
    var_4[var_4.size] = var_10;
  }

  return var_4;
}

heli_evade(var_0) {
  self notify("_encstr_8101178E58D6B49B3B7D59CE2CB9A53B59F558361DA5F6DCDC");
  self endon("_encstr_8101178E58D6B49B3B7D59CE2CB9A53B59F558361DA5F6DCDC");
  self endon("_encstr_AD75063D571AE108");
  var_1 = 5000;

  if(isDefined(self.evade_radius))
    var_1 = self.evade_radius;

  if(show_on_minimap(self)) {
    lootleadermarks(self);
    var_0 = (self.origin[0], self.origin[1], self.chopper_height);
  }

  var_2 = create_radius_around_point(var_0, 8, var_1);
  var_3 = 0;
  var_4 = var_2[0];
  self cleargoalyaw();
  self cleartargetyaw();
  self clearlookatent();

  foreach(var_7, var_6 in var_2) {
    if(scripts\engine\utility::within_fov(self.origin, self.angles, var_6.origin, cos(25))) {
      var_4 = var_6;
      var_3 = var_7;
      break;
    }
  }

  self setvehgoalpos(var_2[var_3].origin, 0);
  var_8 = 1500;
  var_8 = var_8 * (var_1 / 5000);
  var_9 = 100;
  var_9 = var_9 * (var_1 / 5000);
  self setneargoalnotifydist(1500);
  self vehicle_setspeed(100, 50, 50);
  var_10 = 0;
  var_7 = var_3 + 1;
  var_11 = randomint(4);

  while(var_10 < var_2.size - 1) {
    if(var_7 >= var_2.size)
      var_7 = 0;

    self setvehgoalpos(var_2[var_7].origin, 0);
    scripts\engine\utility::waittill_notify_or_timeout("_encstr_B4D10ADC950BE4EB76DE8536", 15);
    var_10++;
    var_7++;

    if(var_10 == var_11) {
      break;
    }
  }

  self notify("_encstr_8FB414155441A73C8D70A15A58D1749FD8A89C87E069");
}

lootleadermarks(var_0) {
  var_1 = undefined;
  var_2 = propminigameupdateui(var_0);

  if(var_2.size > 0)
    var_1 = scripts\engine\utility::getclosest(var_0.origin, var_2);
  else
    var_1 = scripts\engine\utility::getclosest(var_0.origin, scripts\engine\utility::getStructArray(var_0.obj_pregame, "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));

  var_0 setneargoalnotifydist(250);
  var_0 vehicle_setspeed(100, 50, 50);
  var_0 setvehgoalpos(var_1.origin, 0);
  var_0 scripts\engine\utility::waittill_notify_or_timeout("_encstr_B4D10ADC950BE4EB76DE8536", 15);
}

show_on_minimap(var_0) {
  if(!isDefined(var_0.obj_pregame))
    return 0;

  var_1 = scripts\engine\utility::getStructArray(var_0.obj_pregame, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_1.size == 0)
    return 0;

  return 1;
}

propminigameupdateui(var_0) {
  var_1 = [];
  var_2 = scripts\engine\utility::getStructArray(var_0.obj_pregame, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = anglesToForward(var_0.angles);

  foreach(var_5 in var_2) {
    var_6 = vectorNormalize(var_5.origin - var_0.origin);

    if(vectordot(var_6, var_3) > 0)
      var_1[var_1.size] = var_5;
  }

  return var_1;
}

setup_pilot(var_0, var_1, var_2, var_3) {
  var_4 = "_encstr_BDF30A3B51CCFF9AC049F7D4";

  if(isDefined(var_1))
    var_4 = var_1;

  if(!self tagexists(var_4) && self tagexists("_encstr_AB680B55361AD76B09EB28E886"))
    var_4 = "_encstr_AB680B55361AD76B09EB28E886";

  if(!self tagexists(var_4)) {
    return;
  }
  var_5 = (0, 0, 0);

  if(isDefined(var_2))
    var_5 = var_2;

  var_6 = (0, 0, 0);

  if(isDefined(var_3))
    var_6 = var_3;

  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self gettagorigin(var_4));
  var_7 setModel("_encstr_967D148517D7E02DC6DB1DEB665D1B8D4C7B8C97F5C4");
  var_7 linkTo(self, var_4, var_5, var_6);
  var_7 scriptmodelplayanim("_encstr_AFB4168310E1758238C1A77F8148DBB9A058BB41A8500C1A");
  self.pilot = var_7;

  if(istrue(var_0))
    thread heli_damagemonitor();

  return var_7;
}

heli_damagemonitor(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  var_2 = 0;
  self.health = 1000000;
  self.interaction_is_jugg_maze_button = 1;

  if(!isDefined(var_1))
    var_1 = 2500;

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16);
    self.health = 1000000;

    if(isDefined(var_4) && var_4 == self) {
      continue;
    }
    if(isDefined(var_16) && isDefined(var_16.owner) && var_16.owner == self) {
      continue;
    }
    if(isDefined(var_4) && isDefined(self.minigun) && var_4 == self.minigun) {
      continue;
    }
    if(isDefined(var_4) && isDefined(var_4.owner) && var_4.owner scripts\cp\utility::is_valid_player())
      var_4 = var_4.owner;

    if(is_snipe_kill(var_4, var_6, var_12)) {
      var_2++;

      if(var_2 == 1) {
        var_4 scripts\cp\cp_achievement::scriptable_enginedamaged();
        var_4 thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_BD2118AD2DD8C6BE9BDCD76CA1F6E0C1CAE47DB9ABC107EDC9E8");
        var_4 scripts\cp\cp_persistence::give_player_currency(500, "_encstr_8DEC06B1E943615B");
        thread do_heli_crash(var_4);
        return;
      }

      var_4.lasthitmarkertime = undefined;
      var_4 scripts\cp\cp_damagefeedback::updatedamagefeedback("_encstr_8B5E0C1A5A3A1B4ED2A3D28D58D8", 1);
      self.needs_to_evade = 1;
      self vehicle_setspeed(100, 100, 100);
      self setvehgoalpos(self.origin + (randomintrange(-50, 50), randomintrange(-50, 50), 0), 0);
      self notify("_encstr_B8950FB9AC59C8DCF5E8F6AF5667C246CA");
      continue;
    }

    if(!isexplosivedamagemod(var_7)) {
      var_4.lasthitmarkertime = undefined;
      var_4 scripts\cp\cp_damagefeedback::updatedamagefeedback("_encstr_A5D20E0DD2E8C2C9D6F627D09516675E");
    } else {
      var_4.lasthitmarkertime = undefined;
      var_4 scripts\cp\cp_damagefeedback::updatedamagefeedback("_encstr_8B5E0C1A5A3A1B4ED2A3D28D58D8");

      if(isDefined(var_12) && isDefined(var_12.basename)) {
        switch (var_12.basename) {
          case "_encstr_A93010035F88EE71B82FAD78F10352C7C518":
            break;
          case "_encstr_81931411E5B039F5EB6F052B97F3C90B617F7BAE0D18":
            var_3 = 1400;
            break;
          default:
            break;
        }
      } else if(var_3 < 700)
        var_3 = 700;

      if(isDefined(var_0) && scripts\engine\utility::flag_exist(var_0) && !scripts\engine\utility::flag(var_0))
        scripts\engine\utility::flag_set(var_0);
      else {
        if(!istrue(self.needs_to_evade))
          self.needs_to_evade = 1;

        self notify("_encstr_B8950FB9AC59C8DCF5E8F6AF5667C246CA");
        self vehicle_setspeed(100, 100, 100);
        self setvehgoalpos(self.origin + (randomintrange(-850, 850), randomintrange(-850, 850), 0), 0);
      }
    }

    if(isDefined(var_12) && isDefined(var_12.basename)) {
      switch (var_12.basename) {
        case "_encstr_8DCB0F47F22330CEE7996B13A2E390583A":
          var_3 = self.health_remaining;
          break;
        case "_encstr_9B69114A571F8EBD17484FBA87220987C71A97":
          var_3 = int(var_1 * 0.5);
          break;
      }
    }

    if(self.health_remaining <= var_1 * 0.75) {
      if(isDefined(var_0) && scripts\engine\utility::flag_exist(var_0) && !scripts\engine\utility::flag(var_0))
        scripts\engine\utility::flag_set(var_0);
    }

    self.health_remaining = self.health_remaining - var_3;

    if(self.health_remaining <= var_1 * 0.25 && !isDefined(self.deathfx)) {
      playFX(level._effect["_encstr_B87011F355B2609793E9B902034B58788CA765"], self.origin);
      self setscriptablepartstate("_encstr_AD411231DB23CBBE8CC2D616B395AFA1ACB0ECE5", "_encstr_AB0703DBB9");
      self.deathfx = 1;
    } else if(self.health_remaining <= var_1 * 0.5 && !isDefined(self.deathfx1)) {
      self setscriptablepartstate("_encstr_ABBC1331BD462FF51916AD583B56FAB62B462DD5D6", "_encstr_AB0703DBB9");
      playFX(level._effect["_encstr_B87011F355B2609793E9B902034B58788CA765"], self.origin);
      self.deathfx1 = 1;
    } else if(self.health_remaining <= var_1 * 0.75 && !isDefined(self.deathfx2)) {
      self setscriptablepartstate("_encstr_A5291219482C48E9A0CEC2928F6DBE0A979F9873", "_encstr_AB0703DBB9");
      self.deathfx2 = 1;
    }

    if(self.health_remaining <= 0) {
      if(isDefined(self.headicon))
        setheadiconimage(self.headicon);

      level.cashtypes = undefined;
      self.headicon = undefined;

      if(isDefined(var_12) && issubstr(var_12.basename, "_encstr_8DCB085BEF657B4DCF0B")) {
        if(isDefined(var_4) && isPlayer(var_4))
          var_4 thread scripts\cp\cp_achievement::scriptable_setups();
      }

      if(isDefined(var_4) && isPlayer(var_4)) {
        var_4 thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_BD2118AD2DD8C6BE9BDCD76CA1F6E0C1CAE47DB9ABC107EDC9E8");
        var_4 scripts\cp\cp_persistence::give_player_currency(500, "_encstr_8DEC06B1E943615B");
      }

      if(isDefined(self.veh_spawn_point) && istrue(self.veh_spawn_point.in_use))
        level thread silo_door_clip(self);

      level.all_spawned_vehicles = scripts\engine\utility::array_remove(level.all_spawned_vehicles, self);
      var_4 scripts\cp\cp_damagefeedback::updatedamagefeedback("_encstr_8B5E0C1A5A3A1B4ED2A3D28D58D8", 1);
      playFX(level._effect["_encstr_B14E143325DB1182B8F8959E5698D09BB95FBFC78F08"], self.origin);

      if(istrue(self._id_11E98))
        thread _id_11BD8(var_4);
      else
        thread do_heli_crash(var_4);

      return;
    } else if(isDefined(var_4) && isPlayer(var_4))
      var_4 scripts\cp\cp_persistence::give_player_currency(10, "_encstr_8DEC06B1E943615B");
  }
}

silo_door_clip(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!scripts\cp\utility::turn_off_sniper_laser()) {
    return;
  }
  var_1 = var_0.veh_spawn_point;
  level waittill("_encstr_A6370DE8B4DA597BAEA3F5EE0BCE59");
  waitframe();

  if(isDefined(var_1) && istrue(var_1.in_use))
    var_1 scripts\cp\cp_vehicles::_id_13BB7(0);
}

do_heli_crash(var_0) {
  if(isDefined(self.headicon)) {
    setheadiconimage(self.headicon);
    self.headicon = undefined;
  }

  self.crash_speed = 150;
  thread crash_deathfx();
  self notify("_encstr_AD75063D571AE108", var_0, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", undefined, self.origin);
}

_id_11BD8(var_0) {
  playFX(level._effect["_encstr_B8DC10183F8D7457BF7738A11271B8E0B44D"], self.origin);

  if(isDefined(self.pilot))
    self.pilot delete();

  self delete();
}

crash_deathfx() {
  self waittill("_encstr_A5D616CECAD0D28DC656F5C89516471A1A7B5BC1D895E8CA", var_0);
  playFX(level._effect["_encstr_B14E143325DB1182B8F8959E5698D09BB95FBFC78F08"], var_0 + (0, 0, -100));
  playsoundatpos(var_0, "_encstr_B4E1196C83BE1327AFE6CB9CDAAF8D43DBE0C159C97DC693B0DCD0");
  self stoploopsound();
  wait 0.15;
  playFX(level._effect["_encstr_B14E143325DB1182B8F8959E5698D09BB95FBFC78F08"], var_0 + (0, 0, -100));
  earthquake(0.45, 3, var_0 + (0, 0, -100), 1024);
  radiusdamage(var_0 + (0, 0, -100), 1024, 500, 50);

  if(isDefined(self.pilot))
    self.pilot delete();

  if(isDefined(self))
    self delete();
}

is_snipe_kill(var_0, var_1, var_2) {
  var_3 = isDefined(var_2) && isDefined(var_2.classname) && var_2.classname == "_encstr_850707F7E5833355B8";

  if(!ispointnearpilot(self, var_1) || !var_3)
    return 0;

  return 1;
}

ispointnearpilot(var_0, var_1) {
  var_2 = anglesToForward(self.angles);
  var_3 = anglestoleft(self.angles);
  var_4 = self.origin + var_2 * 133 + (0, 0, -70);
  var_5 = self.origin + var_2 * 112 + var_3 * 17 + (0, 0, -70);
  var_6 = self.origin + var_2 * 112 + (0, 0, -50);

  if(distance(var_1, var_4) <= 20)
    return 1;
  else if(distance(var_1, var_5) <= 20)
    return 1;
  else if(distance(var_1, var_6) <= 20)
    return 1;
  else
    return 0;
}