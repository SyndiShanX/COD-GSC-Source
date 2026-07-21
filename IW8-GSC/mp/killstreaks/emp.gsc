/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\emp.gsc
***********************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_8B1804DF2043", ::tryuseempfromstruct);
}

tryuseemp() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_8B1804DF2043", self);
  return tryuseempfromstruct(var_0);
}

tryuseempfromstruct(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0))
      return 0;
  }

  var_1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(var_0, getcompleteweaponname("_encstr_93B116F067F7496BAB8B35BE2781A7F13ED7A0689F5F4039"));

  if(!istrue(var_1))
    return 0;

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0))
      return 0;
  }

  thread startemp();

  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](self.streakinfo);

  return 1;
}

startemp() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var_1 = 3000;

  if(isDefined(var_0))
    var_1 = var_0.origin[2] + 500;

  var_2 = level.mapcenter * (1, 1, 0) + (0, 0, var_1);
  playFX(scripts\engine\utility::getfx("_encstr_BA6C0E5268E12937F8588B8B6CE11BEF"), var_2);
  self playSound("_encstr_84EC17B239A1AF47B097544A9F380F1FD6707AAAC004577BD0");

  foreach(var_4 in level.players) {
    if(!scripts\mp\utility\player::isreallyalive(var_4)) {
      continue;
    }
    var_4 thread applyempshellshock();
  }

  var_6 = scripts\mp\utility\teams::getenemyteams(self.owner.team);

  foreach(var_8 in var_6)
  destroyactiveobjects(var_8, self);
}

applyempshellshock() {
  self setscriptablepartstate("_encstr_86B306C03AF23B79", "_encstr_930B07BB1B6B3854FF", 0);
  self playLoopSound("_encstr_9ADE0CBBD9D117889A2569A9E160");
  thread applyempshellshockvisionset();
  wait 0.5;
  self setscriptablepartstate("_encstr_86B306C03AF23B79", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self playSound("_encstr_86C110ADDDF829373F5A4BBEC117EFCDF810");
  self stoploopsound("_encstr_9ADE0CBBD9D117889A2569A9E160");
}

applyempshellshockvisionset() {
  visionsetnaked("_encstr_B26E0E5E6828F089CE9BD3EB81FBA25C", 0.05);
  waitframe();
  visionsetnaked("_encstr_B26E0E5E6828F089CE9BD3EB81FBA25C", 0);
  visionsetnaked("_encstr_B40101", 0.5);
}

destroyactiveobjects(var_0, var_1) {
  var_2 = "_encstr_A29408E6D5D6CAAF5B1C";
  var_3 = level.activekillstreaks;
  var_4 = [[level.getactiveequipmentarray]]();
  var_5 = undefined;

  if(isDefined(var_3) && isDefined(var_4))
    var_5 = scripts\engine\utility::array_combine_unique(var_3, var_4);
  else if(isDefined(var_3))
    var_5 = var_3;
  else if(isDefined(var_4))
    var_5 = var_4;

  if(isDefined(var_5)) {
    foreach(var_7 in var_5) {
      if(isDefined(var_7))
        var_7 scripts\mp\utility\killstreak::dodamagetokillstreak(10000, var_1, var_1, var_0, var_7.origin, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_2);
    }
  }
}