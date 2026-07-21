/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\killstreaks\sentry_gun.gsc
***********************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_88C5055208731B")]]();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_A6FC132FD03008172AB6C3C662F3899B5BE36AB26F"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_A6FC132FD03008172AB6C3C662F3899B5BE36AB26F")]]();
}

weaponcleanupsentryturret(var_0, var_1, var_2) {
  if(!istrue(var_1))
    scripts\cp_mp\killstreaks\killstreakdeploy::rocket_fuel(var_2);
}

tryusesentryturret(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(var_0, self);
  return tryusesentryturretfromstruct(var_1);
}

tryusesentryturretfromstruct(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0)) {
      self.bgivensentry = 0;
      return 0;
    }
  }

  scripts\cp_mp\utility\weapon_utility::_id_12EB2();
  var_1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(var_0, getcompleteweaponname("_encstr_865111D227E024F720718BB2FA21086791AD98"), 1, undefined, undefined, ::weaponcleanupsentryturret);

  if(!istrue(var_1)) {
    self.bgivensentry = 0;
    return 0;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0)) {
      self.bgivensentry = 0;
      return 0;
    }
  }

  scripts\cp_mp\killstreaks\manual_turret::_id_11ACC(0);
  var_2 = sentryturret_create("_encstr_AB8E0E73E9709BD298E7141D95E8DF43", var_0);

  if(!isDefined(var_2)) {
    scripts\cp_mp\killstreaks\manual_turret::_id_11ACC(1);
    self.bgivensentry = 0;
    return 0;
  }

  var_3 = sentryturret_watchplacement(var_2, var_0, 0, 1.25);

  if(!isDefined(var_3)) {
    scripts\cp_mp\killstreaks\manual_turret::_id_11ACC(1);
    var_2 delete();
    self.bgivensentry = 0;
    return 0;
  }

  var_2 scripts\cp_mp\emp_debuff::set_start_emp_callback(::sentryturret_empstarted);
  var_2 scripts\cp_mp\emp_debuff::set_clear_emp_callback(::sentryturret_empcleared);
  scripts\cp_mp\killstreaks\manual_turret::_id_11ACC(1);
  sentryturret_setplaced(var_2, var_3);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_8B330D3ADBD0F47B4B9536570725A8"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_8B330D3ADBD0F47B4B9536570725A8")]]();

  return 1;
}

sentryturret_watchplacement(var_0, var_1, var_2, var_3) {
  self.bgivensentry = 1;
  var_0 laseroff();
  thread sentryturret_delayplacementinstructions(var_3);
  var_4 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB"))
    var_4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]() == "_encstr_B607038AAB";

  if(var_4)
    thread _id_13029();

  var_5 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_B6F720D3A849463B5D38FAD04141870FAD11CA5B201DBC6B5181F10B652FFB562DF0"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_B6F720D3A849463B5D38FAD04141870FAD11CA5B201DBC6B5181F10B652FFB562DF0")]]();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_BDEC10D7BDF951795318BFE3516922EAA34E"))
    var_5 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_BDEC10D7BDF951795318BFE3516922EAA34E")]](var_1, var_2);

  self notify("_encstr_B4F71A4B9BBA587D93A7013177CAB57845B5B3A6C719F0239B631339");

  if(!isDefined(var_5) || !isDefined(var_5.location)) {
    if(scripts\cp_mp\utility\player_utility::_isalive())
      scripts\cp_mp\killstreaks\manual_turret::manualturret_switchbacklastweapon("_encstr_865111D227E024F720718BB2FA21086791AD98");

    return undefined;
  }

  var_0 thread scripts\cp_mp\killstreaks\manual_turret::manualturret_disablefire(self, 1, 1);

  if(self hasweapon("_encstr_865111D227E024F720718BB2FA21086791AD98"))
    thread scripts\cp_mp\killstreaks\manual_turret::manualturret_switchbacklastweapon("_encstr_865111D227E024F720718BB2FA21086791AD98", 1, 1);

  var_6 = 0.85;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_6);
  return var_5;
}

_id_13029() {
  self endon("_encstr_B4F71A4B9BBA587D93A7013177CAB57845B5B3A6C719F0239B631339");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self waittill("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  self notify("_encstr_AF98149D096B11095F8A71A019221A88E0494EDFF754");
}

sentryturret_delayplacementinstructions(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_B4F71A4B9BBA587D93A7013177CAB57845B5B3A6C719F0239B631339");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self setclientomnvar("_encstr_A77514BF208604239D46DF9338416AD9A9F85767709B", 1);
  thread scripts\cp_mp\killstreaks\manual_turret::_id_11AC6("_encstr_AD75063D571AE108");
  thread scripts\cp_mp\killstreaks\manual_turret::_id_11AC6("_encstr_B4F71A4B9BBA587D93A7013177CAB57845B5B3A6C719F0239B631339");
}

sentryturret_create(var_0, var_1) {
  var_2 = level.sentrysettings[var_0];
  var_3 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", self.origin, level.sentrysettings[var_0].weaponinfo);
  var_3.owner = self;
  var_3.team = self.team;
  var_3.angles = self.angles;
  var_3.health = 9999;
  var_3.maxhealth = var_2.maxhealth;
  var_3.streakinfo = var_1;
  var_3.turrettype = var_0;
  var_3.shouldsplash = 1;
  var_3.ammocount = var_2.ammo;
  var_3.timeout = var_2.timeout;
  var_3.carriedby = self;
  var_3 sentryturret_setturretmodel("_encstr_B8B00782A191CB07D9");
  var_3 setturretowner(var_3.owner);
  var_3 setturretteam(var_3.team);
  var_3 makeunusable();
  var_3 setnodeploy(1);
  var_3 setdefaultdroppitch(0);
  var_3 hide();
  var_3 setautorotationdelay(0.2);
  var_3.momentum = 0;
  var_3.heatlevel = 0;
  var_3.overheated = 0;
  var_3.cooldownwaittime = 0.1;

  switch (var_0) {
    case "_encstr_AB8E0E73E9709BD298E7141D95E8DF43":
    default:
      var_3 maketurretinoperable();
      var_3 setleftarc(80);
      var_3 setrightarc(80);
      var_3 setbottomarc(50);
      var_3 settoparc(60);
      var_3 setconvergencetime(0.6, "_encstr_BD6506F36A2B46B0");
      var_3 setconvergencetime(0.6, "_encstr_AF1904C7E3A4");
      var_3 setconvergenceheightpercent(0.65);
      var_3 setdefaultdroppitch(-89.0);
      break;
  }

  var_3 setturretmodechangewait(1);
  var_3 scripts\cp_mp\emp_debuff::allow_emp(0);
  var_5 = anglesToForward(var_3.angles);
  var_6 = var_3 gettagorigin("_encstr_9A1E0A3A85B3F5632CB9954E") + (0, 0, 10);
  var_6 = var_6 - var_5 * 20;
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_6);
  var_7 linkTo(var_3);
  var_3.killcament = var_7;
  var_3.helperdrone_isbeingpingedbydrone = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3.origin);
  var_3.helperdrone_isbeingpingedbydrone.team = var_3.team;
  var_3.helperdrone_isbeingpingedbydrone.owner = var_3.owner;
  var_3.helperdrone_isbeingpingedbydrone setModel("_encstr_82EE2697EDA73962101FC4FD3F714F280B9760DB43D099E345B38BD5F1C144204D403FCF8AF9E665");
  var_3.helperdrone_isbeingpingedbydrone dontinterpolate();
  var_3.helperdrone_isbeingpingedbydrone hide();
  var_8 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB"))
    var_8 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]() == "_encstr_B607038AAB";

  if(var_8) {
    var_3.helperdrone_monitorcollision = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3.origin);
    var_3.helperdrone_monitorcollision.team = var_3.team;
    var_3.helperdrone_monitorcollision.owner = var_3.owner;
    var_3.helperdrone_monitorcollision setModel("_encstr_956A2E1F67E2CF806ED1C3B8C94508907BCFB591430BAF60AD724BB12B0F20B0C36707BFAB52DEA0EF4B5128141BC07D");
    var_3.helperdrone_monitorcollision dontinterpolate();
    var_3.helperdrone_monitorcollision hide();
  }

  return var_3;
}

sentryturret_setplaced(var_0, var_1) {
  var_2 = level.sentrysettings[var_0.turrettype];
  var_0 sentryturret_setturretmodel("_encstr_B8B00782A191CB07D9");

  if(!isDefined(self.placedsentries))
    self.placedsentries = [];

  if(!isDefined(self.placedsentries[var_0.turrettype]))
    self.placedsentries[var_0.turrettype] = [];

  if(istrue(var_0.shouldsplash)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8260069BDBBACD46", "_encstr_83011BC11B0B5E2D5AD8B1373A395916B688CA83B17BE5444B16D8F6D9"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8260069BDBBACD46", "_encstr_83011BC11B0B5E2D5AD8B1373A395916B688CA83B17BE5444B16D8F6D9")]](self, var_0.streakinfo.streakname);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A2401B452E92BFC11A5B20F0EF261A89DA56435D42FB2B68C2FF1070A7"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A2401B452E92BFC11A5B20F0EF261A89DA56435D42FB2B68C2FF1070A7")]](var_0.origin, 2048, var_0.streakinfo.streakname);

    var_3 = var_2.teamsplash;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18"))
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18")]](var_3, self);

    var_0.shouldsplash = 0;
  }

  var_4 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB"))
    var_4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]() == "_encstr_B607038AAB";

  var_0 show();
  var_0 dontinterpolate();
  var_0.angles = var_1.angles;
  var_0.carriedby = undefined;

  if(isDefined(var_1.moving_platform)) {
    var_0.moving_platform = var_1.moving_platform;
    var_0._id_11DBE = var_1._id_11DBE;
    var_0._id_11DBD = var_1._id_11DBD;
  }

  self.bgivensentry = 0;
  var_0.origin = var_1.location;
  var_0 playSound("_encstr_931A11C275C203937A69DC3F0D89CB65633853");
  var_0.helperdrone_isbeingpingedbydrone show();
  var_0.helperdrone_isbeingpingedbydrone.angles = var_0.angles;
  var_0.helperdrone_isbeingpingedbydrone.origin = var_0.origin;
  var_5 = var_0.helperdrone_isbeingpingedbydrone;

  if(var_4) {
    var_0.helperdrone_monitorcollision show();
    var_0.helperdrone_monitorcollision.angles = var_0.angles;
    var_0.helperdrone_monitorcollision.origin = var_0.origin;
    var_0.helperdrone_isbeingpingedbydrone linkTo(var_0, "_encstr_99FE0B2B19086F6B9DC5D387E1");
    var_0.helperdrone_monitorcollision linkTo(var_0, "_encstr_99FE0B2B19086F6B9DC5D387E1");
    var_0.helperdrone_monitorcollision linkTo(var_0, "_encstr_8AFF0E7BE26F40E0BC8D6731A123C89D");
    var_5 = var_0.helperdrone_monitorcollision;
  } else
    var_0.helperdrone_isbeingpingedbydrone linkTo(var_0, "_encstr_8AFF0E7BE26F40E0BC8D6731A123C89D");

  var_0 thread _id_13023(var_0, var_5);
  var_6 = self.placedsentries[var_0.turrettype].size;
  self.placedsentries[var_0.turrettype][var_6] = var_0;

  if(var_6 + 1 > 2)
    self.placedsentries[var_0.turrettype][0] notify("_encstr_932D0C087BD23CA6CBBB553A4DE8", 0, 0);

  var_7 = 70;

  if(var_0.model == level.sentrysettings[var_0.turrettype].modelbasecover)
    var_7 = 35;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23"))
    var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23")]](var_0.turrettype, "_encstr_912912A962ED2193D37ABDA74B57DDA5950B1858", self, 0, 1, var_7, "_encstr_A93B084AF782F0DA4A04");

  var_0 setmode(level.sentrysettings[var_0.turrettype].sentrymodeon);
  var_8 = "_encstr_91D8084CA5FA89B0DCAC";

  if(!isDefined(var_0.useownerobj)) {
    var_9 = var_0 gettagorigin(var_8);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_BEDD11FE1EE33A449979E7F3F0B40AD24B3E83"))
      var_0.useownerobj = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_BEDD11FE1EE33A449979E7F3F0B40AD24B3E83")]](var_9, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, var_2.ownerusehintstring);
  } else {
    var_9 = var_0 gettagorigin(var_8);
    var_0.useownerobj makeusable();
    var_0.useownerobj dontinterpolate();
    var_0.useownerobj.origin = var_9;
  }

  var_0.useownerobj linkTo(var_0, var_8);

  foreach(var_11 in level.players) {
    if(var_11 != var_0.owner)
      var_0.useownerobj disableplayeruse(var_11);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_824D15630388FAD498047D03B8F8E771519B9BA3F72ED2"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_824D15630388FAD498047D03B8F8E771519B9BA3F72ED2")]](var_0);

  var_0 scripts\cp_mp\emp_debuff::allow_emp(1);
  var_0 scripts\mp\sentientpoolmanager::registersentient("_encstr_B1B01227D9B5C81E73BB39A13207C6C00E3CEBEF", self);
  var_0 sentryturret_empupdate();
  var_0 _id_13020();
  var_0 thread sentry_attacktargets();
  var_0 thread sentry_beepsounds();
  thread sentryturret_delaydeletemarker(var_0, var_1);
  thread sentryturret_watchpickup(var_0);
  thread sentryturret_watchdamage(var_0);
  thread sentryturret_watchdeath(var_0);
  thread sentryturret_watchtimeout(var_0);
  thread sentryturret_watchdisown(var_0);
  thread _id_13028(var_0);
  var_0 notify("_encstr_B1F8181B23FEE3A5185EB2BDB188ED89D68BDFCFFBA63B9E4840");
}

sentryturret_setcarried(var_0) {
  var_0 endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(createheadicon(self getcurrentweapon()) == "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB") {
    self notify("_encstr_8EE016B9EE2D8E6CA1AC32FA3327DBB6EBAD2DE64B9D5D37");

    while(createheadicon(self getcurrentweapon()) == "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB")
      waitframe();
  }

  if(isDefined(var_0.moving_platform)) {
    var_0.moving_platform = undefined;
    var_0._id_11DBE = undefined;
    var_0._id_11DBD = undefined;
    var_0 unlink();
  }

  var_0 scripts\cp_mp\emp_debuff::allow_emp(0);
  var_0 scripts\mp\sentientpoolmanager::unregistersentient(var_0.sentientpool, var_0.sentientpoolindex);
  var_1 = var_0 getlinkedchildren();

  foreach(var_3 in var_1) {
    if(isDefined(var_3))
      var_3 unlink();
  }

  if(isDefined(var_0.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924")]](var_0.minimapid);

    var_0.minimapid = undefined;
  }

  var_5 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB"))
    var_5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]() == "_encstr_B607038AAB";

  var_0.helperdrone_isbeingpingedbydrone unlink();
  var_0.helperdrone_isbeingpingedbydrone hide();

  if(var_5) {
    var_0.helperdrone_monitorcollision unlink();
    var_0.helperdrone_monitorcollision hide();
  }

  sentryturret_setinactive(var_0);
  var_0 hide();
  var_0.carriedby = self;
  var_0 notify("_encstr_A93B084AF782F0DA4A04");
  var_0 playSound("_encstr_8AF00E9BACCDE8C9BCEB384B36ADAE83");
  scripts\cp_mp\utility\weapon_utility::_id_12EB2();
  scripts\cp_mp\utility\inventory_utility::_giveweapon("_encstr_865111D227E024F720718BB2FA21086791AD98");
  scripts\cp_mp\utility\inventory_utility::_switchtoweapon("_encstr_865111D227E024F720718BB2FA21086791AD98");
  scripts\cp_mp\killstreaks\manual_turret::_id_11ACC(0);
  var_6 = sentryturret_watchplacement(var_0, var_0.streakinfo, 1, 2);

  if(!isDefined(var_6)) {
    scripts\cp_mp\killstreaks\manual_turret::_id_11ACC(1);
    return 0;
  }

  scripts\cp_mp\killstreaks\manual_turret::_id_11ACC(1);
  sentryturret_setplaced(var_0, var_6);
}

sentryturret_switchbacklastweapon(var_0) {
  if(istrue(var_0))
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(self.lastdroppableweaponobj);
  else
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self.lastdroppableweaponobj);

  scripts\cp_mp\utility\inventory_utility::_takeweapon("_encstr_865111D227E024F720718BB2FA21086791AD98");
}

sentryturret_setinactive(var_0) {
  var_0 setdefaultdroppitch(30);
  var_0 setmode(level.sentrysettings[var_0.turrettype].sentrymodeoff);
  var_0.useownerobj makeunusable();
  var_0.useownerobj unlink();
}

sentryturret_delaydeletemarker(var_0, var_1) {
  var_0 endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 0.25;

  if(isDefined(var_1.visual))
    var_1.visual delete();
}

sentryturret_disableplayeruseonconnect(var_0, var_1) {
  if(isDefined(var_0)) {
    var_0 endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
    var_0 endon("_encstr_A93B084AF782F0DA4A04");
  }

  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_2);
    var_1 disableplayeruse(var_2);
  }
}

sentryturret_watchpickup(var_0) {
  var_0 endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  var_0 endon("_encstr_A93B084AF782F0DA4A04");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_0.useownerobj waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(var_1 != self) {
      continue;
    }
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_8CDE1476A048475337CB9FA7EBCF1886716B2A3A3920")) {
      if(!var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_8CDE1476A048475337CB9FA7EBCF1886716B2A3A3920")]]())
        continue;
    }

    if(istrue(var_1.isjuggernaut)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
        var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_A9C1255A923189D445A45405D2D4E594AA1D1DFA0D05E439A72AEB8454D7A0A40D691522AFAA0A");

      continue;
    }

    var_0 _id_13021();
    var_0.useownerobj makeunusable();
    var_0 setmode(level.sentrysettings[var_0.turrettype].sentrymodeoff);
    self.placedsentries[var_0.turrettype] = scripts\engine\utility::array_remove(self.placedsentries[var_0.turrettype], var_0);
    thread sentryturret_setcarried(var_0);
  }
}

sentryturret_disableplayerpickuponconnect(var_0) {
  var_0 endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  var_0 endon("_encstr_A93B084AF782F0DA4A04");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_1);
    var_1 waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
    var_0.useownerobj disableplayeruse(var_1);
  }
}

sentryturret_watchdismantle(var_0) {
  var_0 endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  var_0 endon("_encstr_A93B084AF782F0DA4A04");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  foreach(var_2 in level.players) {
    if(level.teambased) {
      if(var_2.team != self.team)
        continue;
    } else if(var_2 != self)
      continue;
  }

  thread sentryturret_disableplayerdismantleonconnect(var_0);

  for(;;) {
    var_0.dismantleobj waittill("_encstr_8F5C086405E70FBA4B4A", var_2);
    var_0 notify("_encstr_932D0C087BD23CA6CBBB553A4DE8", 0, 1);
    break;
  }
}

sentryturret_watchdamage(var_0) {
  var_0 endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  var_0 endon("_encstr_A93B084AF782F0DA4A04");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_93790EDAEDCDA5D1F6E4110BDA0B3B56"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_93790EDAEDCDA5D1F6E4110BDA0B3B56")]](var_0);
}

sentryturret_disableplayerdismantleonconnect(var_0) {
  var_0 endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  var_0 endon("_encstr_A93B084AF782F0DA4A04");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_1);
    var_1 waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");

    if(level.teambased) {
      if(var_1.team != self.team)
        continue;
    }
  }
}

sentryturret_empstarted(var_0) {
  sentryturret_empupdate();
}

sentryturret_empcleared(var_0) {
  if(var_0) {
    return;
  }
  sentryturret_empupdate();
}

sentryturret_empupdate() {
  if(scripts\cp_mp\emp_debuff::is_empd()) {
    self turretfiredisable();
    self setmode(level.sentrysettings[self.turrettype].sentrymodeoff);
    self laseroff();
  } else {
    self turretfireenable();
    self setmode(level.sentrysettings[self.turrettype].sentrymodeon);
  }
}

sentryturret_watchdeath(var_0) {
  var_0 endon("_encstr_A93B084AF782F0DA4A04");
  var_0 waittill("_encstr_932D0C087BD23CA6CBBB553A4DE8", var_1, var_2);

  if(isDefined(self)) {
    self.placedsentries[var_0.turrettype] = scripts\engine\utility::array_remove(self.placedsentries[var_0.turrettype], var_0);
    sentryturret_setinactive(var_0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_841B100E39B49BA3A3B0B5B2A01B47D2DBDC"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_841B100E39B49BA3A3B0B5B2A01B47D2DBDC")]]("_encstr_880321D420686433C51D676F37C79AAE90098F8ED0623D2A10FB7F537795C30AC89103", self);

    var_0.streakinfo.onspray = istrue(var_2);
    scripts\cp_mp\utility\killstreak_utility::_id_12AA7(var_0.streakinfo);
  }

  var_0 sentryturret_setturretmodel("_encstr_83320ADDB7DB01AB8F3FF8E8");
  var_0 _id_13021();
  var_0 setturretowner(undefined);

  if(!istrue(var_1)) {
    var_0 playSound("_encstr_ACB215AFFF55B3E84BB1C150DF9CAD986F9FA3737743FA");
    var_0 setscriptablepartstate("_encstr_ABEF097343AB23ABD89446", "_encstr_AB0703DBB9");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
    var_0 setscriptablepartstate("_encstr_860808CB78E2984063BA", "_encstr_813008928DA89D31A8CA");
  } else
    var_0 setscriptablepartstate("_encstr_860808CB78E2984063BA", "_encstr_88B20850478F501332D3");

  var_0 playSound("_encstr_9ACF13F5970FE2C913880BAFF84983BBEDA0786F75");

  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](var_0.streakinfo);

  if(isDefined(var_0.killcament))
    var_0.killcament delete();

  if(isDefined(var_0.useownerobj))
    var_0.useownerobj delete();

  if(isDefined(var_0.useotherobj))
    var_0.useotherobj delete();

  if(isDefined(var_0.helperdrone_isbeingpingedbydrone))
    var_0.helperdrone_isbeingpingedbydrone delete();

  if(isDefined(var_0.helperdrone_monitorcollision))
    var_0.helperdrone_monitorcollision delete();

  if(isDefined(var_0.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924")]](var_0.minimapid);

    var_0.minimapid = undefined;
  }

  wait 0.2;
  var_0 delete();
}

sentryturret_delayscriptabledelete() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  self delete();
}

sentryturret_watchtimeout(var_0) {
  var_0 endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  var_0 endon("_encstr_A93B084AF782F0DA4A04");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(var_0.timeout > 0) {
    var_0.timeout = var_0.timeout - 0.05;
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.05);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8260069BDBBACD46", "_encstr_93111DB2997323F390A07B1F78AB95EADF357C6E71871ACF5829735F38A15A"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8260069BDBBACD46", "_encstr_93111DB2997323F390A07B1F78AB95EADF357C6E71871ACF5829735F38A15A")]]("_encstr_ACB80B32E13893EAC81A9F1209" + var_0.streakinfo.streakname, undefined, undefined, self.origin);

  var_0 notify("_encstr_932D0C087BD23CA6CBBB553A4DE8", 0, 0);
}

sentryturret_watchdisown(var_0) {
  var_0 endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  var_0 endon("_encstr_A93B084AF782F0DA4A04");
  scripts\engine\utility::_id_143A6("_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  var_0 notify("_encstr_932D0C087BD23CA6CBBB553A4DE8", 0, 0);
}

_id_13028(var_0) {
  var_0 endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  var_0 endon("_encstr_A93B084AF782F0DA4A04");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  var_0 notify("_encstr_932D0C087BD23CA6CBBB553A4DE8", 0, 0);
}

sentryturret_setturretmodel(var_0) {
  var_1 = undefined;

  if(var_0 == "_encstr_B8B00782A191CB07D9")
    var_1 = level.sentrysettings[self.turrettype].modelbaseground;
  else
    var_1 = level.sentrysettings[self.turrettype].modeldestroyedground;

  self setModel(var_1);
}

sentry_attacktargets() {
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  self endon("_encstr_A93B084AF782F0DA4A04");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.momentum = 0;

  for(;;) {
    self waittill("_encstr_857D12B3C82B1A3A99CE63DEB55392D891B8477F");

    if(self isfiringturret()) {
      self laseron();
      thread sentry_burstfirestart();
      continue;
    }

    self laseroff();
    sentry_spindown();
    thread sentry_burstfirestop();
  }
}

sentry_targetlocksound() {
  self endon("_encstr_AD75063D571AE108");
  self playSound("_encstr_93961CC233AAC90D5A06F84B20EF4D3A235AF561F1E57826CAA7FD1F2543");
  wait 0.19;
  self playSound("_encstr_93961CC233AAC90D5A06F84B20EF4D3A235AF561F1E57826CAA7FD1F2543");
}

sentry_spinup() {
  thread sentry_targetlocksound();

  while(self.momentum < level.sentrysettings[self.turrettype].spinuptime) {
    self.momentum = self.momentum + 0.1;
    wait 0.1;
  }
}

sentry_spindown() {
  self.momentum = 0;
}

sentry_burstfirestart() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_99210EE61DBD1CD7DCA1EDBDE8A537CE");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  sentry_spinup();
  var_0 = weaponfiretime(level.sentrysettings[self.turrettype].weaponinfo);
  var_1 = level.sentrysettings[self.turrettype].burstmin;
  var_2 = level.sentrysettings[self.turrettype].burstmax;
  var_3 = level.sentrysettings[self.turrettype].pausemin;
  var_4 = level.sentrysettings[self.turrettype].pausemax;
  var_5 = level.sentrysettings[self.turrettype].lockstrength;

  for(;;) {
    var_6 = randomintrange(var_1, var_2 + 1);

    for(var_7 = 0; var_7 < var_6 && !self.overheated; var_7++) {
      self shootturret("_encstr_A14F0AE336178944BA076F41", var_5);
      self.streakinfo.shots_fired++;
      wait(var_0);
    }

    wait(randomfloatrange(var_3, var_4));
  }
}

sentry_burstfirestop() {
  self notify("_encstr_99210EE61DBD1CD7DCA1EDBDE8A537CE");
}

turret_heatmonitor() {
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  self endon("_encstr_A93B084AF782F0DA4A04");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = level.sentrysettings[self.turrettype].overheattime;

  for(;;) {
    if(self.heatlevel > var_0) {
      self.overheated = 1;

      while(self.heatlevel)
        wait 0.1;

      self.overheated = 0;
      self notify("_encstr_BE690F1038845E50656583101090C917AF");
    }

    wait 0.05;
  }
}

playheatfx() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BE690F1038845E50656583101090C917AF");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_935C10831B165E2D9B3BAF0DAC58D1BE993C");
  self endon("_encstr_935C10831B165E2D9B3BAF0DAC58D1BE993C");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("_encstr_AF3613176712CD6879D1E0DB475A708D5A8BD7A34B"), self, "_encstr_A14F0AE336178944BA076F41");
    wait(level.sentrysettings[self.turrettype].fxtime);
  }
}

turret_coolmonitor() {
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  self endon("_encstr_A93B084AF782F0DA4A04");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(self.heatlevel > 0) {
      if(self.cooldownwaittime <= 0)
        self.heatlevel = max(0, self.heatlevel - 0.05);
      else
        self.cooldownwaittime = max(0, self.cooldownwaittime - 0.05);
    }

    wait 0.05;
  }
}

sentry_beepsounds() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A93B084AF782F0DA4A04");
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    wait 3.0;

    if(self isfiringturret()) {
      waitframe();
      continue;
    }

    self playSound("_encstr_A68410B329B05B125827C7DD6D415E476DE3");
  }
}

_id_13023(var_0, var_1) {
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  self endon("_encstr_A93B084AF782F0DA4A04");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = "_encstr_8BE614035F22E0218DBC20D8A56990B01BAF95B1A3EB";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_A5B0108E1B78310BF5DFB39BE3AE53614841"))
    var_0.minimapid = var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_A5B0108E1B78310BF5DFB39BE3AE53614841")]](var_2, var_0.team, undefined, 1, 1);

  scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam(var_0.minimapid, var_0.owner);
}

_id_13020() {
  var_0 = _calloutmarkerping_handleluinotify_brinventoryslotrequest::_id_12F67(self.origin, 140, 20);
  var_1 = undefined;
  var_2 = 0;

  foreach(var_4 in var_0) {
    var_5 = distancesquared(var_4.origin, self.origin);

    if(isDefined(var_1) && var_2 <= var_5) {
      continue;
    }
    var_1 = var_4;
    var_2 = var_5;
  }

  if(isDefined(var_1)) {
    var_7 = var_1 scriptabledoorangle();
    var_8 = abs(var_7) > 25;
    var_9 = undefined;

    foreach(var_11 in var_0) {
      if(var_11 == var_1) {
        continue;
      }
      if(distancesquared(var_11.heli_intro_vo_done, var_1.heli_intro_vo_done) < 3600) {
        var_9 = var_11;
        break;
      }
    }

    var_13 = 1;

    if(isDefined(var_9)) {
      var_14 = var_9 scriptabledoorangle();
      var_13 = abs(var_14) > 25;
    }

    if(var_2 < 3600 && var_8) {
      var_1.tutonplayerkilled = 1;
      var_1 _calloutmarkerping_handleluinotify_brinventoryslotrequest::matchslopekey(1, "_encstr_85340FF0D733A68FB2A38516F15ACFE88A");
      self.concussionused = var_1;

      if(isDefined(var_9) && var_13) {
        var_9.tutonplayerkilled = 1;
        var_9 _calloutmarkerping_handleluinotify_brinventoryslotrequest::matchslopekey(1, "_encstr_85340FF0D733A68FB2A38516F15ACFE88A");
        self.concusspushstart = var_9;
      }
    }
  }

  return 0;
}

_id_13021() {
  if(isDefined(self.concussionused)) {
    self.concussionused _calloutmarkerping_handleluinotify_brinventoryslotrequest::matchslopekey(0, "_encstr_85340FF0D733A68FB2A38516F15ACFE88A");
    self.concussionused.tutonplayerkilled = undefined;
    self.concussionused = undefined;
  }

  if(isDefined(self.concusspushstart)) {
    self.concusspushstart _calloutmarkerping_handleluinotify_brinventoryslotrequest::matchslopekey(0, "_encstr_85340FF0D733A68FB2A38516F15ACFE88A");
    self.concusspushstart.tutonplayerkilled = undefined;
    self.concusspushstart = undefined;
  }
}