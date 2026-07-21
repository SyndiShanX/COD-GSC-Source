/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_extract_chopper.gsc
***********************************************/

spawnextractchopper(var_0, var_1, var_2, var_3) {
  var_4 = var_0.origin;
  var_5 = var_4;
  var_6 = (0, 0, 0);
  var_7 = 24000;
  var_8 = getEnt("_encstr_A9E210B2E845424BDB3BE3E543C1C78F9998", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_9 = var_8.origin[2];
  var_10 = "_encstr_B88607820996877650";
  var_11 = level.mapcenter - var_0.origin;
  var_11 = (var_11[0], var_11[1], 0);
  var_12 = vectorNormalize(var_11);
  var_13 = var_12 * -10000 + (0, 0, 1) * var_9;
  var_14 = (var_4[0], var_4[1], var_9);
  var_15 = fakestreakinfo();
  var_16 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_4, 0, 90, 128);
  var_16.angles = (0, 0, 0);
  var_16.team = self.team;
  var_16.ownerteam = self.team;
  var_16.visibleteam = "_encstr_9A19040BCDBC";
  var_16.offset3d = (0, 0, 16);
  var_16.location = var_4;
  var_17 = beginlittlebird(0, var_13, var_14, var_15, var_16, var_1, self.team, var_3);
  var_17.onhelikilled = var_2;
  var_17.zone = var_0;
  return var_17;
}

fakestreakinfo() {
  var_0 = spawnStruct();
  var_0.available = 1;
  var_0.firednotify = "_encstr_A2600E386AB2399AF3D9B99FA3BDBAA0";
  var_0.isgimme = 1;
  var_0.kid = 5;
  var_0.lifeid = 0;
  var_0.madeavailabletime = gettime();
  var_0.scriptuseagetype = "_encstr_AD56169FC186E14B0B222E10A9B28BA3D38FD76FE2A17735";
  var_0.streakname = "_encstr_B88607820996877650";
  var_0.streaksetupinfo = undefined;
  var_0.variantid = -1;
  var_0.weaponname = "_encstr_93B116F067F7496BAB8B35BE2781A7F13ED7A0689F5F4039";
  var_0.objweapon = getcompleteweaponname(var_0.weaponname);
  return var_0;
}

beginlittlebird(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = undefined;

  if(isDefined(var_4)) {
    var_8 = var_4.marker;

    if(!isDefined(var_8)) {
      var_8 = spawnStruct();

      if(isDefined(var_5))
        var_8.location = var_5;
      else if(isDefined(var_4.location))
        var_8.location = var_4.location;
      else
        var_8.location = var_4.trigger.origin;

      var_8.angles = (0, 0, 0);
      var_8.string = "_encstr_859917A2DB4D5FE2F9C17568F950683FF6F35A4A212D239FF8";
      var_8.visual = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_8.location);
      var_8.visual setModel("_encstr_8AF40D5B6EEBDA85396DB293F5B50E");
      var_8.visual setotherent(self);
    }

    if(!isDefined(var_8.location)) {
      self notify("_encstr_88C212F2E9F04797B0678C8119581D872E2D1B0A");
      return 0;
    }
  }

  self notify("_encstr_8CA2158210D8E04F9DE0982D0FC0807443EBD71EBCA339");
  var_9 = getEnt("_encstr_A9E210B2E845424BDB3BE3E543C1C78F9998", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_9))
    var_10 = var_9.origin[2] + 500;
  else
    var_10 = 1300;

  if(isDefined(var_8) && isDefined(var_8.location))
    var_2 = var_8.location;

  var_2 = var_2 * (1, 1, 0);
  var_11 = var_2 + (0, 0, var_10);
  var_12 = spawnlittlebird(var_0, self, var_1, var_11, var_3, var_4);
  var_12.lz = var_4;
  var_12.pathgoal = var_11;
  thread monitorarriveoverdestination(var_12, var_8, var_6, var_7);
  return var_12;
}

spawnlittlebird(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = vectortoangles(var_3 - var_2);

  if(scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B") {
    var_7 = 99;
    var_8 = 10000;
  } else if(scripts\mp\utility\game::getgametype() == "_encstr_A9190405B4E5") {
    var_7 = 99;
    var_8 = 99999;
  } else {
    var_7 = 1;
    var_8 = 10000;
  }

  var_9 = "_encstr_B85414BCDF02F19615D70899DF390B87EA86364F732A";
  var_10 = spawnhelicopter(var_1, var_2, var_6, "_encstr_BADC10304DDB593E1FE6C245DCE75BCF28E3", var_9);

  if(!isDefined(var_10)) {
    return;
  }
  if(isDefined(var_5))
    var_10.lz = var_5;

  var_10 thread handledestroydamage();
  var_10.damagecallback = ::callback_vehicledamage;
  var_10.speed = 50;
  var_10.accel = 125;
  var_10.health = var_8;
  var_10.maxhealth = var_10.health;
  var_10.team = var_1.team;
  var_10.owner = var_1;
  var_10 setCanDamage(1);
  var_10.defendloc = var_3;
  var_10.lifeid = var_0;
  var_10.jackal = 1;
  var_10.streakinfo = var_4;
  var_10.streakname = var_4.streakname;
  var_10.streakinfo = var_4;
  var_10.flaresreservecount = var_7;
  var_10 scripts\mp\utility\killstreak::addtoactivekillstreaklist(var_4.streakname, "_encstr_81860F1741A58ADBBB43D3B36C79AF3083", var_1, 0, 1, 100);
  var_10 setmaxpitchroll(0, 90);
  var_10 vehicle_setspeed(var_10.speed, var_10.accel);
  var_10 sethoverparams(50, 100, 50);
  var_10 setturningability(0.05);
  var_10 setyawspeed(45, 25, 25, 0.5);
  var_10 setotherent(var_1);
  var_10.useobj = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_10 gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37"));
  var_10.useobj linkTo(var_10, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");

  if(!isDefined(level.jackals))
    level.jackals = [];

  level.jackals[level.jackals.size] = var_10;
  level.jackals = scripts\engine\utility::array_removeundefined(level.jackals);
  var_10 thread scripts\mp\killstreaks\flares::flares_handleincomingstinger(undefined, undefined);
  var_10 thread littlebirddestroyed();
  var_10 thread delay_jackal_arrive_sfx();
  return var_10;
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

littlebirddestroyed() {
  self endon("_encstr_BD9A0C532CD8D6161BEBB3DBB9B2");
  var_0 = self.owner;
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(self.turrettarget) && isDefined(self.targetoutline))
    scripts\mp\utility\outline::outlinedisable(self.targetoutline, self.turrettarget);

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.largeprojectiledamage)) {
    self vehicle_setspeed(25, 5);
    thread littlebirdcrash(75);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.7);
  }

  if(isDefined(self.lz))
    self.lz notify("_encstr_963715B53B8DFAA769EBAB5ADEDFB1BD8B535BF0DABFA8");

  littlebirdexplode();
}

littlebirdexplode() {
  self playSound("_encstr_9B501454D5482AF70B684BA1F15BB365F051CDE71358");
  level.jackals[level.jackals.size - 1] = undefined;
  self notify("_encstr_860808CB78E2984063BA");

  if(isDefined(self.lz))
    playFXOnTag(scripts\engine\utility::getfx("_encstr_8FA11152F837346F6870BDA8FF300F7A4BF09A"), self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");

  wait 0.35;
  thread littlebirddelete();
}

littlebirddelete() {
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

littlebirdcrash(var_0) {
  self endon("_encstr_860808CB78E2984063BA");
  self clearlookatent();
  self notify("_encstr_834F10F2726A6339BCFF3243DB681CD46B4C");
  self setvehgoalpos(self.origin + (0, 0, 100), 1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self setyawspeed(var_0, var_0, var_0);
  self settargetyaw(self.angles[1] + var_0 * 2.5);
}

handledestroydamage() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    var_9 = scripts\mp\utility\weapon::mapweapon(var_9, var_13);

    if((var_9.basename == "_encstr_A63B18C2B0DA5A9B6E4BC6CAFA0E9CDE35CA36475A8D59FA6BE0" || var_9.basename == "_encstr_A29408E6D5D6CAAF5B1C") && var_4 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" && var_0 >= self.health) {
      if(isDefined(self.onhelikilled))
        [[self.onhelikilled]](self.team);

      callback_vehicledamage(var_1, var_1, 9001, 0, var_4, var_9, var_3, var_2, var_3, 0, 0, var_7);
    }
  }
}

callback_vehicledamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
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

monitorarriveoverdestination(var_0, var_1, var_2, var_3) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_BA2D081B2B58B32D37EC");
  var_0 setvehgoalpos(var_0.pathgoal, 1);
  var_0 thread changemaxpitchrollwhenclosetogoal(var_0.pathgoal);
  var_0 waittill("_encstr_8B7205D9ED5958");
  var_0 thread watchgameendleave();

  if(isDefined(var_3)) {
    var_4 = var_0.speed;
    var_5 = var_0.accel;
  } else {
    var_4 = var_0.speed / 4;
    var_5 = var_0.accel / 6;
  }

  var_0 vehicle_setspeed(var_4, var_5);
  var_0 littlebirddescendtoextraction(var_1.location, var_0.zone, var_2);
}

littlebirdleave() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = self.speed;
  var_1 = self.accel;
  self setmaxpitchroll(0, 0);
  self notify("_encstr_BA2D081B2B58B32D37EC");
  self.leaving = 1;
  self clearlookatent();

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

  if(scripts\mp\utility\game::getgametype() != "_encstr_B81904B04E6B")
    littlebirddelete();
}

getpathend() {
  var_0 = 150;
  var_1 = 15000;
  var_2 = self.angles[1];
  var_3 = (0, var_2, 0);
  var_4 = self.origin + anglesToForward(var_3) * var_1;
  return var_4;
}

littlebirddescendtoextraction(var_0, var_1, var_2) {
  descend(var_0, var_1);

  if(scripts\mp\utility\game::getgametype() != "_encstr_951904D8F1E0" && scripts\mp\utility\game::getgametype() != "_encstr_B81904B04E6B" && scripts\mp\utility\game::getgametype() != "_encstr_A9190405B4E5") {
    var_1.teamsextracting = scripts\engine\utility::array_remove(var_1.teamsextracting, var_2 + self.squadindex);
    thread littlebirdleave();
  }
}

descend(var_0, var_1) {
  self endon("_encstr_BAFC0789BA3BD35DA3");
  var_2 = undefined;
  var_3 = var_0[0];
  var_4 = var_0[1];
  var_5 = tracegroundheight(var_3, var_4, 20);
  var_2 = (var_3, var_4, var_5);

  if(scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B") {
    var_5 = tracegroundheight(var_3, var_4, 5, 1);
    var_2 = (var_3, var_4, var_5 + 200);
  }

  self clearlookatent();
  self setvehgoalpos(var_2, 1);
  self waittill("_encstr_8B7205D9ED5958");

  if(scripts\mp\utility\game::getgametype() == "_encstr_951904D8F1E0")
    self notify("_encstr_A7401607773E79E4C8F36B75C948396305979FC31D53B3A5");
  else if(scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B") {
    self vehicle_setspeed(self.speed / 8, self.accel / 12);
    var_5 = tracegroundheight(var_3, var_4, undefined, 1);
    var_2 = (var_3, var_4, var_5 + 120);
    self setvehgoalpos(var_2, 1);
    self notify("_encstr_A7401607773E79E4C8F36B75C948396305979FC31D53B3A5");
    self waittill("_encstr_8B7205D9ED5958");
    self vehicle_setspeed(self.speed / 3, self.accel / 4);
  } else if(scripts\mp\utility\game::getgametype() == "_encstr_A9190405B4E5")
    self notify("_encstr_A7401607773E79E4C8F36B75C948396305979FC31D53B3A5");
}

tracegroundheight(var_0, var_1, var_2, var_3) {
  var_4 = 30;
  var_5 = tracegroundpoint(var_0, var_1, var_3);
  var_6 = var_5 + var_4;

  if(isDefined(var_2))
    var_6 = var_6 + randomint(var_2);

  return var_6;
}

tracegroundpoint(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A56910C7FEFF7B196E3B10F8638EF09C1B24");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  var_3 = -99999;
  var_4 = self.origin[2] + 2000;
  var_5 = level.averagealliesz;
  var_6 = [self];

  if(isDefined(self.dropcrates)) {
    foreach(var_8 in self.dropcrates)
    var_6[var_6.size] = var_8;
  }

  var_10 = 256;

  if(isDefined(var_2))
    var_11 = scripts\engine\trace::ray_trace((var_0, var_1, var_4), (var_0, var_1, var_3), var_6, undefined, undefined, 1);
  else
    var_11 = scripts\engine\trace::sphere_trace((var_0, var_1, var_4), (var_0, var_1, var_3), 256, var_6, undefined, 1);

  if(var_11["_encstr_BD260953AA97E3F014279D"][2] < var_5)
    var_12 = var_5;
  else
    var_12 = var_11["_encstr_BD260953AA97E3F014279D"][2];

  return var_12;
}

watchgameendleave() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  thread littlebirdleave();
}

changemaxpitchrollwhenclosetogoal(var_0) {
  self endon("_encstr_8B7205D9ED5958");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");

  for(;;) {
    if(distance2d(self.origin, var_0) < 768) {
      self setmaxpitchroll(10, 25);
      break;
    }

    wait 0.05;
  }
}

abortextractpickup() {
  thread littlebirdleave();
}