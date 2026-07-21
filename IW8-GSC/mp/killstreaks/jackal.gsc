/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\jackal.gsc
***********************************************/

beginjackal(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.jackals))
    level.jackals = [];

  var_5 = undefined;

  if(isDefined(var_4)) {
    var_5 = var_4.marker;
    var_6 = 2;

    if(!isDefined(var_5)) {
      var_5 = spawnStruct();

      if(isDefined(var_4.location))
        var_5.location = var_4.location;
      else
        var_5.location = var_4.trigger.origin;

      var_5.angles = (0, 0, 0);
      var_5.string = "_encstr_859917A2DB4D5FE2F9C17568F950683FF6F35A4A212D239FF8";
      var_5.visual = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5.location);
      var_5.visual setModel("_encstr_8AF40D5B6EEBDA85396DB293F5B50E");
      var_5.visual setotherent(self);
    }

    if(!isDefined(var_5.location)) {
      self notify("_encstr_91320ED82C73B159C6D7D4C28DD60B8D");
      return 0;
    } else if(isDefined(level.jackal_incoming) || level.jackals.size >= var_6) {
      if(isDefined(var_5.visual))
        var_5.visual delete();

      scripts\mp\hud_message::showerrormessage("_encstr_819B225BAB843BD2A969A0F8B97F05C79C8EC7DB5F4D5F6F97B1081031370247B71D6544");

      if(isDefined(var_3.objweapon) && var_3.objweapon.basename != "_encstr_8BBA05185F8B99")
        self notify("_encstr_95E2216DD2631BE61DE4B20BB6F5995ADC9637A12B32AFDD4BE834AFEEB2C21CBD37AF" + var_3.weaponname);

      self notify("_encstr_91320ED82C73B159C6D7D4C28DD60B8D");
      return 0;
    }
  }

  self notify("_encstr_A2EE11A837DC2063E24923B851DAB30933CF58");
  level.jackal_incoming = 1;
  var_7 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();

  if(isDefined(var_7))
    var_8 = var_7.origin[2] + 500;
  else
    var_8 = 1300;

  if(isDefined(var_5) && isDefined(var_5.location))
    var_2 = var_5.location;

  var_2 = var_2 * (1, 1, 0);
  var_9 = var_2 + (0, 0, var_8);
  var_10 = spawnksjackal(var_0, self, var_1, var_9, var_3, var_4);
  var_10.tacopslz = var_4;
  var_11 = var_9;
  var_12 = var_9 + anglestoright(self.angles) * 2000;
  var_13 = var_9 - anglestoright(self.angles) * 2000;
  var_14 = [var_11, var_12, var_13];

  foreach(var_16 in var_14) {
    if(!jackalcanseelocation(var_10, var_16)) {
      continue;
    }
    var_9 = var_16;
    break;
  }

  var_10.pathgoal = var_9;
  thread defendlocation(var_10, var_5);
  return var_10;
}

spawnksjackal(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = vectortoangles(var_3 - var_2);
  var_7 = 4;
  var_8 = 50;
  var_9 = 175;
  var_10 = 10000;
  var_11 = "_encstr_B85414BCDF02F19615D70899DF390B87EA86364F732A";
  var_12 = "_encstr_A38411B0A66358B7CA6FF1CBE3138DE8073D7B";
  var_13 = "_encstr_86DB223BACD0F56B96D87DB0A5E4AFD80BBEC8E4B71CE6434B07FAB60EEBE8AE27C9953A";
  var_14 = 1;
  var_15 = "_encstr_AFBB119A85B1DA0BD87DC6169B9BEDDCD7DAC1";
  var_16 = "_encstr_9A4C27368D30476DE348D10A58ED297FC978ACCA109B4F748BC0D95350055A3F03C03D59B6836FBD4B";
  var_17 = 1;
  var_18 = &"_encstr_A3A31FD2293162A9A249A805D29AF584929351A9EB250A86968298D73A55052922";
  var_19 = "_encstr_8DA40E33F63663F6EEF538D885F2B24E";

  if(isDefined(var_5))
    var_19 = "_encstr_859B0F825B4733E7F9D17F7BE3886CFF78";

  var_20 = spawnhelicopter(var_1, var_2, var_6, "_encstr_82930F3B09E0FF8A23751B4BA7579135C8", var_11);

  if(!isDefined(var_20)) {
    return;
  }
  if(isDefined(var_5))
    var_20.lz = var_5;

  var_20 thread handledestroydamage();
  var_20.damagecallback = ::callback_vehicledamage;
  var_20.speed = var_8;
  var_20.accel = var_9;
  var_20.health = var_10;
  var_20.maxhealth = var_20.health;
  var_20.team = var_1.team;
  var_20.owner = var_1;
  var_20 setCanDamage(1);
  var_20.defendloc = var_3;
  var_20.lifeid = var_0;
  var_20.jackal = 1;
  var_20.streakinfo = var_4;
  var_20.streakname = var_4.streakname;
  var_20.evasivemaneuvers = 0;
  var_20.combatmode = var_19;
  var_20.currentstring = var_18;
  var_20.streakinfo = var_4;
  var_20.flaresreservecount = var_7;
  var_20.turreton = var_14;
  var_20.turretweapon = var_12;
  var_20.cannonweapon = var_15;
  var_20.cannonon = var_17;
  var_20 scripts\mp\utility\killstreak::addtoactivekillstreaklist(var_4.streakname, "_encstr_81860F1741A58ADBBB43D3B36C79AF3083", var_1, 0, 1, 100);
  var_20 setmaxpitchroll(0, 90);
  var_20 vehicle_setspeed(var_20.speed, var_20.accel);
  var_20 sethoverparams(50, 100, 50);
  var_20 setturningability(0.05);
  var_20 setyawspeed(45, 25, 25, 0.5);
  var_20 setotherent(var_1);
  var_21 = anglesToForward(var_20.angles);

  if(!isDefined(var_5)) {
    var_20.turret = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_20 gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37"), var_12);
    var_20.turret setModel(var_13);
    var_20.turret.owner = var_1;
    var_20.turret.team = var_1.team;
    var_20.turret.angles = var_20.angles;
    var_20.turret.type = "_encstr_A6A60CA9B01B43D2732BEB74EA37";
    var_20.turret.streakinfo = var_4;
    var_20.turret linkTo(var_20, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (200, 0, 55), (0, 0, 0));
    var_20.turret setturretmodechangewait(0);
    var_20.turret setmode("_encstr_BA7D0EF916AAA3692C479020EB7FA1E9");
    var_20.turret setsentryowner(var_1);
    var_20.cannon = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_20 gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37"), var_15);
    var_20.cannon setModel(var_16);
    var_20.cannon.owner = var_1;
    var_20.cannon.team = var_1.team;
    var_20.cannon.angles = var_20.angles;
    var_20.cannon.type = "_encstr_A6AA07CE9F0DE3D8F2";
    var_20.cannon.streakinfo = var_4;
    var_20.cannon linkTo(var_20, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (-100, 0, 55), (0, 0, 0));
    var_20.cannon setturretmodechangewait(0);
    var_20.cannon setmode("_encstr_BA7D0EF916AAA3692C479020EB7FA1E9");
    var_20.cannon setsentryowner(var_1);
  }

  var_20.useobj = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_20 gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37"));
  var_20.useobj linkTo(var_20, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  level.jackals[level.jackals.size] = var_20;
  level.jackals = scripts\engine\utility::array_removeundefined(level.jackals);
  level.jackal_incoming = undefined;

  if(isDefined(var_5))
    var_20 thread scripts\mp\killstreaks\flares::flares_handleincomingstinger(undefined, undefined);

  var_20 thread jackaldestroyed();
  var_20 thread delayjackalloopsfx(0.05, "_encstr_BA8820B5AAC0E7DF2A126ABF293A2531A3FF48BF3C1B8B611C90939A19C16FC3D8A9");
  var_20 thread delay_jackal_arrive_sfx();

  if(!isDefined(var_5)) {
    var_20.turret.vehicle_fired_from = var_20;
    var_20.cannon.vehicle_fired_from = var_20;
    var_20.turret.vehicle_fired_from.killcament = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_20 gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37"));
    var_20.turret.vehicle_fired_from.killcament linkTo(var_20, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_20.cannon.vehicle_fired_from.killcament = var_20.turret.vehicle_fired_from.killcament;
  }

  var_22 = anglesToForward(var_20.angles);
  return var_20;
}

getnumownedjackals(var_0) {
  var_1 = 0;

  if(level.teambased) {
    foreach(var_3 in level.jackals) {
      if(var_3.team != var_0.team) {
        continue;
      }
      var_1++;
    }
  } else {
    foreach(var_3 in level.jackals) {
      if(var_3.owner != var_0) {
        continue;
      }
      var_1++;
    }
  }

  return var_1;
}

delay_jackal_arrive_sfx() {
  self endon("_encstr_AD75063D571AE108");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(6);
}

delayjackalloopsfx(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  self playLoopSound(var_1);
}

defendlocation(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 setvehgoalpos(var_0.pathgoal, 1);
  var_0 thread closetogoalcheck(var_0.pathgoal);
  var_0 thread monitorowner();

  if(isDefined(var_0.dropcrates))
    var_0 thread watchdropcratesearly(var_1);

  var_0 waittill("_encstr_8B7205D9ED5958");

  if(isDefined(var_1) && isDefined(var_0.lz)) {
    var_0 thread jackaltimer();
    var_0 thread watchgameendleave();
    var_0 thread engageprimarytarget();
    var_0.speed = 250;
    var_0 vehicle_setspeed(50, 15);
    var_0 jackalmovetolocation(var_1.location);
    var_0 waittill("_encstr_A6201117400BFA9A57AD49BC185F83B131C037");
    var_0 thread jackalleave(50, 15);
  } else if(isDefined(var_1) && isDefined(var_0.dropcrates)) {
    var_0 thread jackaltimer();
    var_0 thread watchgameendleave();
    var_0 thread engageprimarytarget();
    var_0 thread engagesecondarytarget();
    var_0 vehicle_setspeed(50, 15);
    var_0 jackalmovetolocation(var_1.location);
    var_0 thread dropcrates(var_0.dropcrates, var_1);
    var_0 thread watchjackalcratepickup();
    var_0 scripts\engine\utility::_id_143B9(10, "_encstr_A63010E02AF54F9933613DBD6B5FC1E7DD02");
    var_0.combatmode = "_encstr_8DA40E33F63663F6EEF538D885F2B24E";
  } else {
    var_0 thread jackaltimer();
    var_0 thread watchgameendleave();
    var_0 thread engageprimarytarget();
    var_0 thread engagesecondarytarget();
    var_0 vehicle_setspeed(int(var_0.speed / 14), int(var_0.accel / 16));
  }

  if(!isDefined(var_0.lz)) {
    var_0.useobj scripts\mp\utility\killstreak::setkillstreakcontrolpriority(var_0.owner, var_0.currentstring, 360, 360, 30000, 30000, 2);
    var_0 thread patrolfield();
    var_0 thread watchmodechange(getothermode(var_0.combatmode), var_0.currentstring);
  }
}

engageprimarytarget() {
  self notify("_encstr_87660EB2B9B358B32B41935ADAB0E4F2");
  self endon("_encstr_87660EB2B9B358B32B41935ADAB0E4F2");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_AD75063D571AE108");
  self.lastaction = undefined;

  if(istrue(self.turreton)) {
    for(;;) {
      var_0 = jackalgettargets();

      if(isDefined(var_0) && var_0.size > 0) {
        acquireturrettarget(var_0);
        self.turret waittill("_encstr_ACF70C97A3824F81E6DCC3B805CF");

        if(self.combatmode == "_encstr_8DA40E33F63663F6EEF538D885F2B24E")
          thread patrolfield();
      } else
        self.lastaction = "_encstr_9BEB0FF58701F1627FBD7306F438B3E32F";

      wait 0.05;
    }
  }
}

engagesecondarytarget() {
  self notify("_encstr_B4CD10CAB93BC2EC56A695B17B9B8C2CE45E");
  self endon("_encstr_B4CD10CAB93BC2EC56A695B17B9B8C2CE45E");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_AD75063D571AE108");
  var_0 = weaponfiretime(self.cannonweapon);

  if(istrue(self.cannonon)) {
    for(;;) {
      var_1 = jackalgettargets();

      if(!isDefined(var_1) || var_1.size < 2) {
        waitframe();
        continue;
      }

      acquirecannontarget(var_1);
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
    }
  }
}

followplayer() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_859B0F825B4733E7F9D17F7BE3886CFF78");
  self endon("_encstr_A549105702D7989D24C34069DBFE55515FAC");
  self endon("_encstr_834F10F2726A6339BCFF3243DB681CD46B4C");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_A2911166BDD8D8B7DD5A73ECF51CB1162F95E4");
  self vehicle_setspeed(50, 15);

  for(;;) {
    var_0 = undefined;

    if(istrue(self.evasivemaneuvers)) {
      var_1 = self.owner.origin[0];
      var_2 = self.owner.origin[1];
      var_3 = var_1 + randomintrange(-500, 500);
      var_4 = var_2 + randomintrange(-500, 500);
      var_5 = getcorrectheight(var_3, var_4, 350);
      var_0 = (var_3, var_4, var_5);
    } else {
      var_1 = self.owner.origin[0];
      var_2 = self.owner.origin[1];
      var_5 = getcorrectheight(var_1, var_2, 20);
      var_0 = (var_1, var_2, var_5);
    }

    self setlookatent(self.owner);
    self setvehgoalpos(var_0, 1);
    self.lastaction = "_encstr_A2911166BDD8D8B7DD5A73ECF51CB1162F95E4";
    scripts\engine\utility::_id_143A5("_encstr_8B7205D9ED5958", "_encstr_8EED1805A567F080CFFA6BB1A32F4458B1358BE54D4BB05D13F3");
    self clearlookatent();
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  }
}

guardposition(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_8DA40E33F63663F6EEF538D885F2B24E");
  self endon("_encstr_834F10F2726A6339BCFF3243DB681CD46B4C");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self vehicle_setspeed(int(self.speed / 14), int(self.accel / 16));
  var_1 = undefined;

  if(isDefined(var_0)) {
    var_2 = var_0[0];
    var_3 = var_0[1];
    var_4 = getcorrectheight(var_2, var_3, 20);
    var_1 = (var_2, var_3, var_4);
  } else if(istrue(self.evasivemaneuvers)) {
    var_2 = self.owner.origin[0];
    var_3 = self.owner.origin[1];
    var_5 = var_2 + randomintrange(-500, 500);
    var_6 = var_3 + randomintrange(-500, 500);
    var_4 = getcorrectheight(var_5, var_6, 350);
    var_1 = (var_5, var_6, var_4);
  } else {
    var_2 = self.owner.origin[0];
    var_3 = self.owner.origin[1];
    var_4 = getcorrectheight(var_2, var_3, 20);
    var_1 = (var_2, var_3, var_4);
  }

  self setlookatent(self.owner);
  self setvehgoalpos(var_1, 1);
  self.lastaction = "_encstr_A2911166BDD8D8B7DD5A73ECF51CB1162F95E4";
  scripts\engine\utility::_id_143A5("_encstr_8B7205D9ED5958", "_encstr_8EED1805A567F080CFFA6BB1A32F4458B1358BE54D4BB05D13F3");
  self clearlookatent();
}

patrolfield() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_859B0F825B4733E7F9D17F7BE3886CFF78");
  self endon("_encstr_A549105702D7989D24C34069DBFE55515FAC");
  self endon("_encstr_834F10F2726A6339BCFF3243DB681CD46B4C");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self vehicle_setspeed(int(self.speed / 14), int(self.accel / 16));

  for(;;) {
    var_0 = undefined;

    if(isDefined(self.patroltarget) && isalive(self.patroltarget) && isPlayer(self.patroltarget) && !self.patroltarget scripts\mp\utility\perk::_hasperk("_encstr_9A86139BA008488198DBDB8B56EE5901CD4B57F0A7")) {
      if(!jackalcanseeenemy(self.patroltarget) || distance2dsquared(self.origin, self.patroltarget.origin) > 4194304)
        jackalmovetoenemy(self.patroltarget);
    } else {
      var_1 = jackalfindclosestenemy();

      if(isDefined(var_1)) {
        self.patroltarget = var_1;
        thread watchpatroltarget();
        jackalmovetoenemy(var_1);
      } else {
        self.patroltarget = undefined;
        var_2 = jackalfindfirstopenpoint();

        if(isDefined(var_2))
          jackalmovetolocation(var_2.origin);
      }
    }

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  }
}

jackalfindfirstopenpoint() {
  var_0 = undefined;

  if(isDefined(level.carepackagedropnodes) && level.carepackagedropnodes.size > 0) {
    foreach(var_2 in level.carepackagedropnodes) {
      if(isDefined(var_2.free) && !var_2.free) {
        continue;
      }
      if(!jackalcanseelocation(self, var_2.origin)) {
        continue;
      }
      var_2.free = 0;
      var_0 = var_2;

      if(!isDefined(self.initialpatrolpoint))
        self.initialpatrolpoint = var_0;

      break;
    }

    if(!isDefined(var_0)) {
      if(isDefined(self.initialpatrolpoint)) {
        foreach(var_2 in level.carepackagedropnodes) {
          if(var_2 != self.initialpatrolpoint)
            var_2.free = undefined;
        }

        var_0 = self.initialpatrolpoint;
      }
    }
  }

  return var_0;
}

jackalcanseelocation(var_0, var_1) {
  var_2 = 0;
  var_3 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);

  if(scripts\engine\trace::ray_trace_passed(var_0.origin, var_1, var_0, var_3))
    var_2 = 1;

  return var_2;
}

jackalcanseeenemy(var_0) {
  var_1 = 0;
  var_2 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0);
  var_3 = [var_0 gettagorigin("_encstr_AADA07DBF19A4A81D7"), var_0 gettagorigin("_encstr_8FE10B52092BB64F28E6B7BFFD"), var_0 gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37")];

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if(!scripts\engine\trace::ray_trace_passed(self.origin, var_3[var_4], self, var_2)) {
      continue;
    }
    var_1 = 1;
    break;
  }

  return var_1;
}

jackalmovetoenemy(var_0) {
  if(isDefined(self.patroltarget))
    var_0 = self.patroltarget;

  if(jackalcanseeenemy(var_0))
    self setlookatent(var_0);

  var_1 = undefined;

  if(istrue(self.evasivemaneuvers)) {
    var_2 = var_0.origin[0];
    var_3 = var_0.origin[1];
    var_4 = var_2 + randomintrange(-500, 500);
    var_5 = var_3 + randomintrange(-500, 500);
    var_6 = getcorrectheight(var_4, var_5, 350);
    var_1 = (var_4, var_5, var_6);
  } else {
    var_2 = var_0.origin[0];
    var_3 = var_0.origin[1];
    var_6 = getcorrectheight(var_2, var_3, 20);
    var_1 = (var_2, var_3, var_6);
  }

  var_7 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  var_8 = scripts\engine\trace::ray_trace(self.origin, var_1, level.characters, var_7);

  if(var_8["_encstr_AA1C0886968EA32FE056"] != "_encstr_AC4B0D3BD013D433491D6125700D8A") {
    var_9 = getcorrectheight(var_8["_encstr_BD260953AA97E3F014279D"][0], var_8["_encstr_BD260953AA97E3F014279D"][1], 20);
    var_1 = (var_8["_encstr_BD260953AA97E3F014279D"][0], var_8["_encstr_BD260953AA97E3F014279D"][1], var_9);
  }

  self setvehgoalpos(var_1 + (0, 0, 500), 2);
  self.lastaction = "_encstr_96080730D8534E0A28";
  scripts\engine\utility::_id_143A5("_encstr_8B7205D9ED5958", "_encstr_8EED1805A567F080CFFA6BB1A32F4458B1358BE54D4BB05D13F3");
  self clearlookatent();
}

jackalfindclosestenemy() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(var_2.ignoreme || isDefined(var_2.owner) && var_2.owner.ignoreme) {
      continue;
    }
    if(!isalive(var_2)) {
      continue;
    }
    if(isDefined(level.teambased) && isDefined(var_2.team) && self.team == var_2.team) {
      continue;
    }
    if(var_2 scripts\mp\utility\perk::_hasperk("_encstr_9A86139BA008488198DBDB8B56EE5901CD4B57F0A7")) {
      continue;
    }
    if(var_2 isjackalenemyindoors()) {
      continue;
    }
    var_0[var_0.size] = var_2;
    waitframe();
  }

  var_4 = undefined;

  if(var_0.size > 0)
    var_4 = sortbydistance(var_0, self.origin);

  if(isDefined(var_4) && var_4.size > 0)
    return var_4[0];

  return undefined;
}

isjackalenemyindoors() {
  var_0 = 0;
  var_1 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0);

  if(!scripts\engine\trace::ray_trace_passed(self.origin, self.origin + (0, 0, 10000), self, var_1))
    var_0 = 1;

  return var_0;
}

watchpatroltarget() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_834F10F2726A6339BCFF3243DB681CD46B4C");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = self.patroltarget scripts\engine\utility::_id_143B9(5, "_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self.patroltarget = undefined;
}

jackalmovetolocation(var_0) {
  var_1 = undefined;

  if(istrue(self.evasivemaneuvers)) {
    var_2 = var_0[0];
    var_3 = var_0[1];
    var_4 = var_2 + randomintrange(-500, 500);
    var_5 = var_3 + randomintrange(-500, 500);
    var_6 = getcorrectheight(var_4, var_5, 350);
    var_1 = (var_4, var_5, var_6);
  } else {
    var_2 = var_0[0];
    var_3 = var_0[1];

    if(!isDefined(self.tacopslz))
      var_6 = getcorrectheight(var_2, var_3, 20);
    else
      var_6 = 160;

    var_1 = (var_2, var_3, var_6);
  }

  self clearlookatent();
  self setvehgoalpos(var_1 + (0, 0, 500), 10);
  scripts\engine\utility::_id_143A5("_encstr_8B7205D9ED5958", "_encstr_8EED1805A567F080CFFA6BB1A32F4458B1358BE54D4BB05D13F3");
}

jackalleave(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self setmaxpitchroll(0, 0);
  self notify("_encstr_BA2D081B2B58B32D37EC");
  self clearlookatent();
  self.turret setsentryowner(undefined);

  if(isDefined(self.turrettarget) && isDefined(self.targetoutline))
    scripts\mp\utility\outline::outlinedisable(self.targetoutline, self.turrettarget);

  var_2 = int(self.speed / 14);
  var_3 = int(self.accel / 16);

  if(isDefined(var_0))
    var_2 = var_0;

  if(isDefined(var_1))
    var_3 = var_1;

  self vehicle_setspeed(var_2, var_3);
  var_4 = self.origin + anglesToForward((0, randomint(360), 0)) * 500;
  var_4 = var_4 + (0, 0, 1000);
  self setvehgoalpos(var_4, 1);

  if(isDefined(self.useobj))
    self.useobj delete();

  self waittill("_encstr_8B7205D9ED5958");
  var_5 = getpathend();
  self vehicle_setspeed(250, 75);
  self setvehgoalpos(var_5, 1);
  self waittill("_encstr_8B7205D9ED5958");
  self stoploopsound();
  level.jackals[level.jackals.size - 1] = undefined;
  self notify("_encstr_BD9A0C532CD8D6161BEBB3DBB9B2");
  thread jackaldelete();
}

jackaldelete() {
  scripts\mp\utility\print::printgameaction("_encstr_AC901AEFE275C8E3C8A60FA6AB5FE876E3150191B902C2365A6A4ADA", self.owner);

  if(isDefined(self.turret))
    self.turret delete();

  if(isDefined(self.cannon))
    self.cannon delete();

  if(isDefined(self.useobj))
    self.useobj delete();

  foreach(var_1 in level.carepackagedropnodes)
  var_1.free = undefined;

  self delete();
}

jackaltimer() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 9999;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);

  if(isDefined(self.owner))
    self.owner scripts\mp\utility\dialog::playkillstreakdialogonplayer("_encstr_A56D0BFDAF1A9A3854E9E9804F", undefined, undefined, self.owner.origin);

  thread jackalleave();
}

watchgameendleave() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  thread jackalleave();
}

randomjackalmovement() {
  self notify("_encstr_96C815CBDB383CCF50ECF18AD45E9D68D750D5F0057E21");
  self endon("_encstr_96C815CBDB383CCF50ECF18AD45E9D68D750D5F0057E21");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A56910C7FEFF7B196E3B10F8638EF09C1B24");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self.lastaction = "_encstr_96DD0F932CCDC8DE6B53BD3B59D62BE61D";
  var_0 = self.defendloc;
  var_1 = getrandompoint(self.origin);
  self setvehgoalpos(var_1, 1);
  thread scripts\mp\utility\debug::drawline(self.origin, var_1, 5, (1, 0, 1));
  self waittill("_encstr_8B7205D9ED5958");
}

getrandompoint(var_0) {
  self clearlookatent();

  if(distance2dsquared(self.origin, self.owner.origin) > 4194304) {
    var_1 = self.owner.origin[0];
    var_2 = self.owner.origin[1];
    var_3 = getcorrectheight(var_1, var_2, 20);
    var_4 = (var_1, var_2, var_3);
    self setlookatent(self.owner);
    return var_4;
  } else {
    var_5 = self.angles[1];
    var_6 = int(var_5 - 60);
    var_7 = int(var_5 + 60);
    var_8 = randomintrange(var_6, var_7);
    var_9 = (0, var_8, 0);
    var_10 = self.origin + anglesToForward(var_9) * randomintrange(400, 800);
    var_11 = var_10[0];
    var_12 = var_10[1];
    var_13 = getcorrectheight(var_11, var_12, 20);
    var_14 = tracenewpoint(var_11, var_12, var_13);

    if(var_14 != 0)
      return var_14;

    var_11 = randomfloatrange(var_0[0] - 1200, var_0[0] + 1200);
    var_12 = randomfloatrange(var_0[1] - 1200, var_0[1] + 1200);
    var_15 = (var_11, var_12, var_13);
    return var_15;
  }
}

getnewpoint(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A56910C7FEFF7B196E3B10F8638EF09C1B24");
  self endon("_encstr_BA2D081B2B58B32D37EC");

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = [];

  foreach(var_4 in level.players) {
    if(var_4 == self) {
      continue;
    }
    if(!level.teambased || var_4.team != self.team)
      var_2[var_2.size] = var_4.origin;
  }

  if(var_2.size > 0) {
    var_6 = averagepoint(var_2);
    var_7 = var_6[0];
    var_8 = var_6[1];
  } else {
    var_9 = level.mapcenter;
    var_10 = level.mapsize / 4;
    var_7 = randomfloatrange(var_9[0] - var_10, var_9[0] + var_10);
    var_8 = randomfloatrange(var_9[1] - var_10, var_9[1] + var_10);
  }

  var_11 = getcorrectheight(var_7, var_8, 20);
  var_12 = tracenewpoint(var_7, var_8, var_11);

  if(var_12 != 0)
    return var_12;

  var_7 = randomfloatrange(var_0[0] - 1200, var_0[0] + 1200);
  var_8 = randomfloatrange(var_0[1] - 1200, var_0[1] + 1200);
  var_11 = getcorrectheight(var_7, var_8, 20);
  var_13 = (var_7, var_8, var_11);
  return var_13;
}

getpathstart(var_0) {
  var_1 = 100;
  var_2 = 15000;
  var_3 = randomfloat(360);
  var_4 = (0, var_3, 0);
  var_5 = var_0 + anglesToForward(var_4) * (-1 * var_2);
  var_5 = var_5 + ((randomfloat(2) - 1) * var_1, (randomfloat(2) - 1) * var_1, 0);
  return var_5;
}

getpathend() {
  var_0 = 150;
  var_1 = 15000;
  var_2 = self.angles[1];
  var_3 = (0, var_2, 0);
  var_4 = self.origin + anglesToForward(var_3) * var_1;
  return var_4;
}

fireonturrettarget(var_0) {
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_9B010F13FFB8DFAFF46E33C7FB6D08A32B");

  if(istrue(var_0) && scripts\mp\utility\player::isreallyalive(self.owner) && (!isDefined(self.lastfiretime) || self.lastfiretime + 10000 <= gettime())) {
    self.owner scripts\cp_mp\utility\dialog_utility::operatordialogonplayer("_encstr_8A8F0CB5E752D2601CA1B1A812FD");
    self.lastfiretime = gettime();
  }

  var_1 = scripts\mp\utility\outline::outlineenableforplayer(self.turrettarget, self.owner, "_encstr_96AE15674513800375C947242F6863285787EB2916E22F", "_encstr_AD4214B3689849BEABFAB35A7A0883FD43F8C78B6BDB");
  self.targetoutline = var_1;
  var_2 = 3;
  thread watchforlosttarget(self.turret, self.turrettarget, "_encstr_9B010F13FFB8DFAFF46E33C7FB6D08A32B", var_2);
  self.turret waittill("_encstr_97881123FB639E8883C74F55DF6B6066CF12BB");
  level thread scripts\mp\battlechatter_mp::saytoself(self.turrettarget, "_encstr_85B2162AB8A06F9A93F9ABDFE1C6A2898026A3F6D3B01D23");
  self.turret notify("_encstr_99570D833B0773A33905B9AA33982F");
  var_3 = weaponfiretime(self.turretweapon);

  while(isDefined(self.turrettarget) && scripts\mp\utility\player::isreallyalive(self.turrettarget) && isDefined(self.turret getturrettarget(1)) && self.turret getturrettarget(1) == self.turrettarget) {
    self.turret shootturret();
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_3);
  }
}

fireoncannontarget(var_0) {
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_9A45168032BAE781E3678EF73EE388ADA9CBD0C0EA150B7B");
  var_1 = 3;
  thread watchforlosttarget(self.cannon, self.cannontarget, "_encstr_9A45168032BAE781E3678EF73EE388ADA9CBD0C0EA150B7B", var_1);
  self.cannon waittill("_encstr_97881123FB639E8883C74F55DF6B6066CF12BB");
  level thread scripts\mp\battlechatter_mp::saytoself(self.cannontarget, "_encstr_85B2162AB8A06F9A93F9ABDFE1C6A2898026A3F6D3B01D23");
  self.cannon notify("_encstr_99570D833B0773A33905B9AA33982F");
  var_2 = weaponfiretime(self.cannonweapon);

  if(isDefined(self.cannontarget) && scripts\mp\utility\player::isreallyalive(self.cannontarget) && isDefined(self.cannon getturrettarget(1)) && self.cannon getturrettarget(1) == self.cannontarget) {
    self.cannon thread watchmissilelaunch();
    self.cannon shootturret();
  }
}

watchmissilelaunch() {
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_ACA30D383847FB93AAFF7705139D4B", var_0);
  var_0.streakinfo = self.streakinfo;
}

setmissilekillcament() {
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_9A45168032BAE781E3678EF73EE388ADA9CBD0C0EA150B7B");
  self.cannon waittill("_encstr_ACA30D383847FB93AAFF7705139D4B", var_0);
  var_0.vehicle_fired_from = self;
  var_0.vehicle_fired_from.killcament = self.cannon.vehicle_fired_from.killcament;
}

watchforlosttarget(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  var_0 endon("_encstr_ACF70C97A3824F81E6DCC3B805CF");
  var_4 = self.targetoutline;
  var_5 = var_1 scripts\engine\utility::_id_143B9(var_3, "_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(var_5 == "_encstr_995408F398012F656821")
    self notify(var_2);

  if(var_0.type == "_encstr_A6A60CA9B01B43D2732BEB74EA37") {
    if(isDefined(var_4) && isDefined(var_1))
      scripts\mp\utility\outline::outlinedisable(var_4, var_1);

    self clearlookatent();
  }

  var_0 cleartargetentity();
  var_0 notify("_encstr_ACF70C97A3824F81E6DCC3B805CF");
}

isreadytofire(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");

  if(!isDefined(var_0))
    var_0 = 10;

  var_1 = anglesToForward(self.angles);
  var_2 = self.turrettarget.origin - self.origin;
  var_1 = var_1 * (1, 1, 0);
  var_2 = var_2 * (1, 1, 0);
  var_2 = vectorNormalize(var_2);
  var_1 = vectorNormalize(var_1);
  var_3 = vectordot(var_2, var_1);
  var_4 = cos(var_0);

  if(var_3 >= var_4)
    return 1;
  else
    return 0;
}

acquireturrettarget(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self notify("_encstr_A549105702D7989D24C34069DBFE55515FAC");

  if(isDefined(self.outlinedent) && isDefined(self.turrettarget))
    scripts\mp\utility\outline::outlinedisable(self.outlinedent, self.turrettarget);

  if(var_0.size == 1)
    self.turrettarget = var_0[0];
  else
    self.turrettarget = getbesttarget(var_0);

  if(isDefined(self.turrettarget)) {
    self clearlookatent();
    self setlookatent(self.turrettarget);
    self.turret settargetentity(self.turrettarget);
    self.lastaction = "_encstr_8E0A0D874CEB11879C0958C8123791";
    thread fireonturrettarget(1);
  }
}

acquirecannontarget(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self.cannontarget = getbesttarget(var_0);

  if(isDefined(self.cannontarget)) {
    self.cannon settargetentity(self.cannontarget);
    thread fireoncannontarget(0);
  }
}

jackalgettargets() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  var_0 = [];
  var_1 = level.players;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(istarget(var_3)) {
      if(isDefined(var_1[var_2]))
        var_0[var_0.size] = var_1[var_2];
    } else
      continue;

    wait 0.05;
  }

  return var_0;
}

istarget(var_0) {
  self endon("_encstr_AD75063D571AE108");

  if(!isalive(var_0) || var_0.sessionstate != "_encstr_877508C1D8C22F2DDC3B")
    return 0;

  if(isDefined(self.owner) && var_0 == self.owner)
    return 0;

  if(!isDefined(var_0.pers["_encstr_8AEF05472BC2D6"]))
    return 0;

  if(level.teambased && var_0.pers["_encstr_8AEF05472BC2D6"] == self.team)
    return 0;

  if(var_0.pers["_encstr_8AEF05472BC2D6"] == "_encstr_AF8C0A1B6A1D6045925B4F7D")
    return 0;

  if(isDefined(var_0.spawntime) && (gettime() - var_0.spawntime) / 1000 <= 5)
    return 0;

  if(var_0 scripts\mp\utility\perk::_hasperk("_encstr_9A86139BA008488198DBDB8B56EE5901CD4B57F0A7"))
    return 0;

  if(distance2dsquared(self.origin, var_0.origin) > 4194304)
    return 0;

  var_1 = (0, 0, 35);
  var_2 = var_0.origin + rotatevector(var_1, var_0 getworldupreferenceangles());
  var_3 = [self];
  var_4 = scripts\engine\trace::ray_trace(self.origin, var_2, var_3, undefined, 1);

  if(!isDefined(var_4["_encstr_850E077B0BF30318B9"]))
    return 0;

  return 1;
}

getbesttarget(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in var_0) {
    if(isDefined(self.turrettarget) && self.turrettarget == var_4) {
      continue;
    }
    var_5 = abs(vectortoangles(var_4.origin - self.origin)[1]);
    var_6 = abs(self gettagangles("_encstr_A2B40B8E2C3B7DDB274B9D4B37")[1]);
    var_5 = abs(var_5 - var_6);
    var_7 = var_4 getweaponslistitems();

    foreach(var_9 in var_7) {
      var_10 = var_9.basename;

      if(issubstr(var_10, "_encstr_83DE0BC6D02CC976ACE60DF63A") || issubstr(var_10, "_encstr_A1DF0739FD13B7A71A"))
        var_5 = var_5 - 40;
    }

    if(distance(self.origin, var_4.origin) > 4000)
      var_5 = var_5 + 40;

    if(!isDefined(var_1)) {
      var_1 = var_5;
      var_2 = var_4;
      continue;
    }

    if(var_1 > var_5) {
      var_1 = var_5;
      var_2 = var_4;
    }
  }

  return var_2;
}

handledestroydamage() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    var_9 = scripts\mp\utility\weapon::mapweapon(var_9, var_13);

    if((var_9.basename == "_encstr_A63B18C2B0DA5A9B6E4BC6CAFA0E9CDE35CA36475A8D59FA6BE0" || var_9.basename == "_encstr_A29408E6D5D6CAAF5B1C") && var_4 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" && var_0 >= self.health)
      callback_vehicledamage(var_1, var_1, 9001, 0, var_4, var_9, var_3, var_2, var_3, 0, 0, var_7);
  }
}

callback_vehicledamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isDefined(var_1)) {
    if(isDefined(var_1.owner))
      var_1 = var_1.owner;
  }

  if((var_1 == self || isDefined(var_1.pers) && var_1.pers["_encstr_8AEF05472BC2D6"] == self.team && !level.friendlyfire && level.teambased) && var_1 != self.owner) {
    return;
  }
  if(self.health <= 0) {
    return;
  }
  var_2 = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(var_1, var_5, var_4, var_2, self.maxhealth, 3, 4, 5);
  scripts\mp\killstreaks\killstreaks::killstreakhit(var_1, var_5, self, var_4, var_2);
  var_1 scripts\mp\damagefeedback::updatedamagefeedback("_encstr_B40101");
  scripts\mp\damage::logattackerkillstreak(self, var_2, var_1, var_7, var_6, var_4, var_10, undefined, var_11, var_3, createheadicon(var_5));

  if(self.health <= var_2) {
    if(isPlayer(var_1) && (!isDefined(self.owner) || var_1 != self.owner))
      scripts\mp\damage::onkillstreakkilled("_encstr_B88607820996877650", var_1, var_5, var_4, var_2, "_encstr_A78D118C956EA39CF65EAC467DA6168D6D58B1", "_encstr_ADF111588F6B68C33A21DD5502932D50C937B0", "_encstr_95CB1A77BF207118254BFF81FD270CE3AAB07FCCFF3088F592607333");
  }

  if(self.health - var_2 <= 900 && (!isDefined(self.smoking) || !self.smoking))
    self.smoking = 1;

  self vehicle_finishdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

getcorrectheight(var_0, var_1, var_2) {
  var_3 = 600;
  var_4 = tracegroundpoint(var_0, var_1);
  var_5 = var_4 + var_3;
  var_5 = var_5 + randomint(var_2);
  return var_5;
}

playdamageefx() {
  self endon("_encstr_AD75063D571AE108");
  stopFXOnTag(level.harrier_afterburnerfx, self, "_encstr_BE48103A2C3BFA95733B4BE62BD7B1CA333A");
  playFXOnTag(level.harrier_smoke, self, "_encstr_BE48103A2C3BFA95733B4BE62BD7B1CA333A");
  stopFXOnTag(level.harrier_afterburnerfx, self, "_encstr_A32511E37AF7C848C53F839525E1B8AB8F827B");
  playFXOnTag(level.harrier_smoke, self, "_encstr_A32511E37AF7C848C53F839525E1B8AB8F827B");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.15);
  stopFXOnTag(level.harrier_afterburnerfx, self, "_encstr_9B68119B7BEA8EFF2B5477A69301288DFE8BB6");
  playFXOnTag(level.harrier_smoke, self, "_encstr_9B68119B7BEA8EFF2B5477A69301288DFE8BB6");
  stopFXOnTag(level.harrier_afterburnerfx, self, "_encstr_A1A012933F5F61FD50980F0B902EA24A27C31B9A");
  playFXOnTag(level.harrier_smoke, self, "_encstr_A1A012933F5F61FD50980F0B902EA24A27C31B9A");
  playFXOnTag(level.chopper_fx["_encstr_B2BE0788BAF573592F"]["_encstr_AB710C138DF945135923C1873708"], self, "_encstr_BE48103A2C3BFA95733B4BE62BD7B1CA333A");
}

jackaldestroyed() {
  self endon("_encstr_BD9A0C532CD8D6161BEBB3DBB9B2");
  var_0 = self.owner;
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(self.turrettarget) && isDefined(self.targetoutline))
    scripts\mp\utility\outline::outlinedisable(self.targetoutline, self.turrettarget);

  if(!isDefined(self)) {
    return;
  }
  self.owner scripts\mp\utility\lower_message::clearlowermessage(getothermode(self.combatmode));

  if(!isDefined(self.largeprojectiledamage)) {
    self vehicle_setspeed(25, 5);
    thread jackalcrash(75);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.7);
  }

  if(isDefined(self.lz))
    self.lz notify("_encstr_963715B53B8DFAA769EBAB5ADEDFB1BD8B535BF0DABFA8");

  jackalexplode();
}

jackalexplode() {
  self playSound("_encstr_9B501454D5482AF70B684BA1F15BB365F051CDE71358");
  level.jackals[level.jackals.size - 1] = undefined;
  self notify("_encstr_860808CB78E2984063BA");

  if(isDefined(self.lz))
    playFXOnTag(scripts\engine\utility::getfx("_encstr_8FA11152F837346F6870BDA8FF300F7A4BF09A"), self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");

  wait 0.35;
  thread jackaldelete();
}

jackalcrash(var_0) {
  self endon("_encstr_860808CB78E2984063BA");
  self clearlookatent();
  self notify("_encstr_834F10F2726A6339BCFF3243DB681CD46B4C");
  self setvehgoalpos(self.origin + (0, 0, 100), 1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self setyawspeed(var_0, var_0, var_0);
  self settargetyaw(self.angles[1] + var_0 * 2.5);
}

tracenewpoint(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A56910C7FEFF7B196E3B10F8638EF09C1B24");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_A279095A77158A9D386877");
  var_3 = scripts\engine\trace::sphere_trace(self.origin, (var_0, var_1, var_2), 256, self, undefined, 1);

  if(var_3["_encstr_8BCA0C2BFD504F333E6D7513637B"] != "_encstr_9B0C0EE65DE4991DE53856AFB97BE6B2")
    return 0;

  var_4 = (var_0, var_1, var_2);
  return var_4;
}

tracegroundpoint(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A56910C7FEFF7B196E3B10F8638EF09C1B24");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  var_2 = -99999;
  var_3 = self.origin[2] + 2000;
  var_4 = level.averagealliesz;
  var_5 = [self];

  if(isDefined(self.dropcrates)) {
    foreach(var_7 in self.dropcrates)
    var_5[var_5.size] = var_7;
  }

  var_9 = scripts\engine\trace::sphere_trace((var_0, var_1, var_3), (var_0, var_1, var_2), 256, var_5, undefined, 1);

  if(var_9["_encstr_BD260953AA97E3F014279D"][2] < var_4)
    var_10 = var_4;
  else
    var_10 = var_9["_encstr_BD260953AA97E3F014279D"][2];

  return var_10;
}

closetogoalcheck(var_0) {
  self endon("_encstr_8B7205D9ED5958");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(distance2d(self.origin, var_0) < 768) {
      self setmaxpitchroll(10, 25);
      break;
    }

    wait 0.05;
  }
}

monitorowner() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");

  if(!isDefined(self.owner) || self.owner.team != self.team) {
    thread jackalexplode();
    return;
  }

  self.owner scripts\engine\utility::_id_143A5("_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_8D820B49520F0EC02DDE6367EC");
  jackalexplode();
}

watchmodechange(var_0, var_1) {
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = level.framedurationseconds;

  for(;;) {
    self.useobj waittill("_encstr_8F5C086405E70FBA4B4A", var_3);

    if(var_3 != self.owner) {
      continue;
    }
    if(self.owner scripts\mp\utility\player::isusingremote()) {
      continue;
    }
    if(!self.owner scripts\common\utility::is_usability_allowed()) {
      continue;
    }
    if(scripts\mp\utility\entity::istouchingboundstrigger(self.owner)) {
      continue;
    }
    var_4 = 0;

    while(self.owner useButtonPressed()) {
      var_4 = var_4 + var_2;

      if(var_4 > 0.1) {
        var_5 = getothermode(self.combatmode);

        if(var_5 == "_encstr_859B0F825B4733E7F9D17F7BE3886CFF78") {
          var_6 = self.owner.origin[0];
          var_7 = self.owner.origin[1];
          var_8 = self.origin[2];
          var_9 = (var_6, var_7, var_8);
          var_10 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);

          if(!scripts\engine\trace::ray_trace_passed(self.origin, var_9, self, var_10)) {
            self.owner scripts\mp\hud_message::showerrormessage("_encstr_AD4F1DA15CFCDC5A1989D957794F98A1A545B86FAB675138C9B69B79317807");
            break;
          }
        }

        self.combatmode = var_5;
        self notify(self.combatmode);

        if(self.combatmode == "_encstr_859B0F825B4733E7F9D17F7BE3886CFF78") {
          var_0 = "_encstr_8DA40E33F63663F6EEF538D885F2B24E";
          var_1 = &"_encstr_99CF20584909FC62372FE721D4BF409CD318072F49BCEFD0B90804CF38104085EF3F";
          self.owner scripts\cp_mp\utility\dialog_utility::operatordialogonplayer("_encstr_A9570D9A0B8D6D5863F59D5785E419");
          thread dropship_change_thrust_sfx();
          thread guardposition();
        } else {
          var_0 = "_encstr_859B0F825B4733E7F9D17F7BE3886CFF78";
          var_1 = &"_encstr_A3A31FD2293162A9A249A805D29AF584929351A9EB250A86968298D73A55052922";
          thread patrolfield();
          thread dropship_change_thrust_sfx();
        }

        self.useobj makeunusable();
        scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
        self.currentstring = var_1;
        self.useobj scripts\mp\utility\killstreak::setkillstreakcontrolpriority(self.owner, self.currentstring, 360, 360, 30000, 30000, 2);
        break;
      }

      wait(var_2);
    }

    wait(var_2);
  }
}

dropship_change_thrust_sfx() {
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.3);
  self playsoundonmovingent("_encstr_8D1722989B6521AB6BB9EF70835770D1CA63A06842BCC70303CA755E74675981366A90E0");
}

getothermode(var_0) {
  if(var_0 == "_encstr_8DA40E33F63663F6EEF538D885F2B24E")
    var_0 = "_encstr_859B0F825B4733E7F9D17F7BE3886CFF78";
  else
    var_0 = "_encstr_8DA40E33F63663F6EEF538D885F2B24E";

  return var_0;
}

looptriggeredeffect(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    triggerfx(var_0);
    wait 0.05;

    if(!isDefined(var_1) || !isDefined(var_0)) {
      break;
    }
  }

  if(isDefined(var_0))
    var_0 delete();
}

attacklasedtarget(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = 6000;
  var_5 = (0, 0, var_4);
  var_6 = 3000;
  var_7 = anglesToForward(self.angles);
  var_8 = self.origin;
  var_9 = var_8 + var_5 + var_7 * var_6 * -1;
  var_10 = [self];
  var_11 = 0;
  var_12 = scripts\engine\trace::ray_trace(var_0 + (0, 0, var_4), var_0);

  if(var_12["_encstr_A53009A25003666B9818C6"] > 0.99) {
    var_11 = 1;
    var_9 = var_0 + (0, 0, var_4);
  }

  if(!var_11) {
    var_12 = scripts\engine\trace::ray_trace(var_0 + (300, 0, var_4), var_0);

    if(var_12["_encstr_A53009A25003666B9818C6"] > 0.99) {
      var_11 = 1;
      var_9 = var_0 + (300, 0, var_4);
    }
  }

  if(!var_11) {
    var_12 = scripts\engine\trace::ray_trace(var_0 + (0, 300, var_4), var_0);

    if(var_12["_encstr_A53009A25003666B9818C6"] > 0.99) {
      var_11 = 1;
      var_9 = var_0 + (0, 300, var_4);
    }
  }

  if(!var_11) {
    var_12 = scripts\engine\trace::ray_trace(var_0 + (0, -300, var_4), var_0);

    if(var_12["_encstr_A53009A25003666B9818C6"] > 0.99) {
      var_11 = 1;
      var_9 = var_0 + (0, -300, var_4);
    }
  }

  if(!var_11) {
    var_12 = scripts\engine\trace::ray_trace(var_0 + (300, 300, var_4), var_0);

    if(var_12["_encstr_A53009A25003666B9818C6"] > 0.99) {
      var_11 = 1;
      var_9 = var_0 + (300, 300, var_4);
    }
  }

  if(!var_11) {
    var_12 = scripts\engine\trace::ray_trace(var_0 + (-300, 0, var_4), var_0);

    if(var_12["_encstr_A53009A25003666B9818C6"] > 0.99) {
      var_11 = 1;
      var_9 = var_0 + (-300, 0, var_4);
    }
  }

  if(!var_11) {
    var_12 = scripts\engine\trace::ray_trace(var_0 + (-300, -300, var_4), var_0);

    if(var_12["_encstr_A53009A25003666B9818C6"] > 0.99) {
      var_11 = 1;
      var_9 = var_0 + (-300, -300, var_4);
    }
  }

  if(!var_11) {
    var_12 = scripts\engine\trace::ray_trace(var_0 + (300, -300, var_4), var_0);

    if(var_12["_encstr_A53009A25003666B9818C6"] > 0.99) {
      var_11 = 1;
      var_9 = var_0 + (300, -300, var_4);
    }
  }

  if(!var_11) {
    for(var_13 = 0; var_13 < 5; var_13++) {
      var_4 = var_4 / 2;
      var_5 = (0, 0, var_4);
      var_9 = var_8 + var_5 + var_7 * var_6 * -1;
      var_14 = scripts\engine\trace::ray_trace(var_0, var_9, var_10);

      if(var_14["_encstr_A53009A25003666B9818C6"] > 0.99) {
        var_11 = 1;
        break;
      }

      wait 0.05;
    }
  }

  if(!var_11) {
    for(var_13 = 0; var_13 < 5; var_13++) {
      var_4 = var_4 * 2.5;
      var_5 = (0, 0, var_4);
      var_9 = var_8 + var_5 + var_7 * var_6 * -1;
      var_14 = scripts\engine\trace::ray_trace(var_0, var_9, var_10);

      if(var_14["_encstr_A53009A25003666B9818C6"] > 0.99) {
        var_11 = 1;
        break;
      }

      wait 0.05;
    }
  }
}

playlocksound() {
  if(isDefined(self.playinglocksound) && self.playinglocksound) {
    return;
  }
  scripts\engine\utility::play_loopsound_in_space("_encstr_8D1B114D85D95936B4B9BE1BD85DEB367B6CB5", self.origin);
  self.playinglocksound = 1;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.75);
  self stoploopsound("_encstr_8D1B114D85D95936B4B9BE1BD85DEB367B6CB5");
  self.playinglocksound = 0;
}

playlockerrorsound() {
  if(isDefined(self.playinglocksound) && self.playinglocksound) {
    return;
  }
  self playlocalsound("_encstr_838E1A82EED37B20C11B61883BF59EAB4B138B1644EA370EBC07B8D0");
  self.playinglocksound = 1;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.75);
  self stoplocalsound("_encstr_838E1A82EED37B20C11B61883BF59EAB4B138B1644EA370EBC07B8D0");
  self.playinglocksound = 0;
}

beginevasivemaneuvers() {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_8EED1805A567F080CFFA6BB1A32F4458B1358BE54D4BB05D13F3");
  self endon("_encstr_8EED1805A567F080CFFA6BB1A32F4458B1358BE54D4BB05D13F3");
  self.evasivemaneuvers = 1;
  var_0 = scripts\engine\utility::_id_143B9(3.0, "_encstr_AD75063D571AE108");

  if(var_0 == "_encstr_995408F398012F656821")
    self.evasivemaneuvers = 0;
}

watchguardevadedamage() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_A2911166BDD8D8B7DD5A73ECF51CB1162F95E4");

  for(;;) {
    var_0 = undefined;

    if(istrue(self.evasivemaneuvers)) {
      var_1 = self.owner.origin[0];
      var_2 = self.owner.origin[1];
      var_3 = var_1 + randomintrange(-500, 500);
      var_4 = var_2 + randomintrange(-500, 500);
      var_5 = getcorrectheight(var_3, var_4, 350);
      var_0 = (var_3, var_4, var_5);
    }

    if(isDefined(var_0))
      self setvehgoalpos(var_0, 1);

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  }
}

watchdropcratesearly(var_0) {
  self endon("_encstr_96B10F6CC6A20331B7E9472373E06340E7");
  var_1 = self.dropcrates;
  self waittill("_encstr_AD75063D571AE108");
  thread dropcrates(var_1, var_0);
}

dropcrates(var_0, var_1) {
  self notify("_encstr_96B10F6CC6A20331B7E9472373E06340E7");
}

watchforcapture(var_0, var_1) {
  scripts\engine\utility::_id_143A5("_encstr_B1CF098D5838A3D5C95623", "_encstr_AD75063D571AE108");
  var_0 notify("_encstr_B65E101BE4B03AB2EBC6580E1D5D4E2BC87D" + var_1);
}

watchjackalcratepickup() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  var_0 = 0;

  for(;;) {
    scripts\engine\utility::_id_143A6("_encstr_A5CC1139CA39F8ED91E7B39953DBAE88D469CB", "_encstr_8DCC11569A6F633B21CA08885343CD99D30FC7", "_encstr_AFCC11B1E485E8567D6C58C13AEA272B327D23");
    var_0++;

    if(var_0 == self.dropcrates.size) {
      self notify("_encstr_A63010E02AF54F9933613DBD6B5FC1E7DD02");
      break;
    }
  }
}

beginjackalescort(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.jackals))
    level.jackals = [];

  var_6 = undefined;
  self notify("_encstr_A2EE11A837DC2063E24923B851DAB30933CF58");
  var_7 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var_2 = var_2 * (1, 1, 0);
  var_8 = 1000;
  var_9 = var_2 + (0, 0, var_8);
  var_10 = spawnksjackal(var_0, self, var_1, var_9, var_3, var_4);
  var_10.pathgoal = var_9;
  thread defendlocationescort(var_10, var_6);
  return var_10;
}

defendlocationescort(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 setvehgoalpos(var_0.pathgoal, 1);
  var_0 playsoundonmovingent("_encstr_8D1722989B6521AB6BB9EF70835770D1CA63A06842BCC70303CA755E74675981366A90E0");
  var_0 thread closetogoalcheck(var_0.pathgoal);
  var_0 thread monitorowner();
  var_0 waittill("_encstr_8B7205D9ED5958");
  var_0 thread watchgameendleave();
  var_0 thread engageprimarytarget();
  var_0 thread engagesecondarytarget();
  var_0 vehicle_setspeed(int(var_0.speed / 14), int(var_0.accel / 16));
}

guardpositionescort(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_8DA40E33F63663F6EEF538D885F2B24E");
  self endon("_encstr_834F10F2726A6339BCFF3243DB681CD46B4C");

  if(isDefined(self.owner))
    self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");

  self vehicle_setspeed(int(self.speed / 14), int(self.accel / 16));

  if(isDefined(var_1))
    self setlookatent(var_1);

  if(isDefined(var_0)) {
    var_3 = undefined;
    var_4 = var_0[0];
    var_5 = var_0[1];

    if(istrue(self.evasivemaneuvers)) {
      var_6 = var_4 + randomintrange(-500, 500);
      var_7 = var_5 + randomintrange(-500, 500);
      var_8 = getcorrectheightescort(var_6, var_7, 350, var_2);
      var_3 = (var_6, var_7, var_8);
    } else {
      var_8 = getcorrectheightescort(var_4, var_5, 20, var_2);
      var_3 = (var_4, var_5, var_8);
    }

    self setvehgoalpos(var_3, 1);
    self.lastaction = "_encstr_A2911166BDD8D8B7DD5A73ECF51CB1162F95E4";
    scripts\engine\utility::_id_143A5("_encstr_8B7205D9ED5958", "_encstr_8EED1805A567F080CFFA6BB1A32F4458B1358BE54D4BB05D13F3");
    self clearlookatent();
  }
}

getcorrectheightescort(var_0, var_1, var_2, var_3) {
  var_4 = 200;

  if(isDefined(var_3))
    var_4 = var_3;

  var_5 = tracegroundpoint(var_0, var_1);
  var_6 = var_5 + var_4;
  var_6 = var_6 + randomint(var_2);
  return var_6;
}