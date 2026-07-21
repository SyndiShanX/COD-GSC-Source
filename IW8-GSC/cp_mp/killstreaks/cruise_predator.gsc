/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\killstreaks\cruise_predator.gsc
*************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", "_encstr_88C5055208731B")]]();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", "_encstr_82750B33D0116933E1BD8A8B80"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", "_encstr_82750B33D0116933E1BD8A8B80")]]();

  level._effect["_encstr_B69D1370E5281F8F35F83BD12380D399488D1DE94F"] = loadfx("_encstr_82BF382B7F90925B831ABFD3D3EE92782C5533E3E2F5A8023E3B35E1577266D0F16A791E0A4A704DB21B2FFD3F3AAB409CC52350758E627C1A53");
  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", "_encstr_A2BE0AB4DC3BB46E5A981BAC", 7);
  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", "_encstr_AB0703DBB9", 8);
}

weapongivencruisepredator(var_0) {
  return 1;
}

tryusecruisepredator() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", self);
  return tryusecruisepredatorfromstruct(var_0);
}

tryusecruisepredatorfromstruct(var_0) {
  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle())
    return 0;

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0)) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return 0;
    }
  }

  var_1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(var_0, ::weapongivencruisepredator);

  if(!istrue(var_1)) {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return 0;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0)) {
      var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return 0;
    }
  }

  if(level.gameended) {
    var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
    return 0;
  }

  var_2 = getdvarint("_encstr_A5900FC3C112591FE893B293B7203E8B2A", 0);
  var_3 = runcruisepredator(var_0.streakname, var_0, var_2);

  if(!istrue(var_3))
    return 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18")]]("_encstr_918F15D5DCCA32AFD8C9ABD2B92BAF072795C82CA3BD93", self);

  return 1;
}

runcruisepredator(var_0, var_1, var_2) {
  self disablephysicaldepthoffieldscripting();
  var_3 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var_4 = 10000;

  if(isDefined(var_3))
    var_4 = var_3.origin[2] + 6000;

  var_5 = level.mapcenter;

  if(scripts\cp_mp\utility\game_utility::islargemap() || scripts\common\utility::iscp() || scripts\cp_mp\utility\game_utility::unload_after_timeout())
    var_5 = self.origin;

  var_6 = [];
  var_7 = (0, 0, 0);
  var_8 = undefined;
  var_9 = level.players;

  if(scripts\common\utility::iscp())
    var_9 = level.characters;

  foreach(var_11 in var_9) {
    if(var_11 == self) {
      continue;
    }
    if(level.teambased && var_11.team == self.team) {
      continue;
    }
    var_7 = var_7 + (var_11.origin - var_5);
    var_6[var_6.size] = var_11;
  }

  if(isDefined(var_7) && var_6.size > 0) {
    var_8 = vectorNormalize(var_7 / var_6.size);
    var_8 = var_8 * (1, 1, 0);
  } else {
    var_13 = randomint(360);
    var_8 = anglesToForward((0, var_13, 0));
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", "_encstr_86CD1238A8B31A477018B7B5F4D5A3BD2A64C20A"))
    var_8 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", "_encstr_86CD1238A8B31A477018B7B5F4D5A3BD2A64C20A")]](var_8);

  var_14 = var_5 + (0, 0, var_4);
  var_15 = var_14 + var_8 * -3000;
  var_16 = var_14;
  var_17 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_15);
  var_17 setModel("_encstr_87E11677D6917D9DDAD7AD5AE6CDD263B2F51B275D5A6E2B");
  var_17.owner = self;
  var_17.origin = var_15;
  var_17.angles = vectortoangles(var_16 - var_15);
  var_17.type = "_encstr_A1530723371D084D2A";
  var_17.team = self.team;
  var_17.entitynumber = var_17 getentitynumber();
  var_17.streakinfo = var_1;
  var_17.duration = 30;
  self.restoreangles = self.angles;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084")]](var_0, var_17.origin);

  level.rockets[var_17.entitynumber] = var_17;
  level.remotemissileinprogress = 1;
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_A7E40528F8D8C7" + var_0, 1);
  var_18 = cruisepredator_followmissilepod(var_17, var_16, var_2, var_1);
  return var_18;
}

initbrc130airdropdropanims(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_974C090268FEF793209304");

  if(isDefined(self)) {
    initbattleroyalejuggernautcratedata(var_0, var_1, var_2);
    self delete();
  }
}

initbattleroyalejuggernautcratedata(var_0, var_1, var_2) {
  var_3 = self.owner;

  if(isDefined(var_3)) {
    var_3 disablephysicaldepthoffieldscripting();
    var_3 unlink();
    var_3 scripts\common\utility::allow_fire(1);
    var_3 scripts\common\utility::allow_melee(1);
    var_3 scripts\common\utility::allow_weapon_switch(1);
    var_3 scripts\common\utility::allow_usability(1);
    var_3 scripts\common\utility::allow_shellshock(1);
    var_3 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(var_0.streakname, "_encstr_BA19049F4B2D");
    var_3 setclientomnvar("_encstr_A5C1142363C173DBC231BA01508AB67B21F67B4C100D", 0);
    var_3 painvisionon();
    var_3 scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
    var_3 visionsetkillstreakforplayer("_encstr_B40101");
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(var_3, 0, 0);
  }

  var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");

  if(isDefined(var_1))
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var_1);

  if(isDefined(var_2))
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var_2);
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

cruisepredator_followmissilepod(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::get_notetrack_time(%_encstr_BA731DF89168F9A823EF9018E7C2B11FDBDC345108CFDD3B6947628320B2E7, "_encstr_8B2D0BF0DAD59FDB9301D3590B");
  var_5 = scripts\engine\utility::get_notetrack_time(%_encstr_BA731DF89168F9A823EF9018E7C2B11FDBDC345108CFDD3B6947628320B2E7, "_encstr_A1400C9BD0CA36B1F513399585AD");
  var_6 = scripts\engine\utility::get_notetrack_time(%_encstr_BA731DF89168F9A823EF9018E7C2B11FDBDC345108CFDD3B6947628320B2E7, "_encstr_97F01828E26E6770539779639327D8D957E988786B03970B0FC2");
  var_7 = scripts\engine\utility::get_notetrack_time(%_encstr_BA731DF89168F9A823EF9018E7C2B11FDBDC345108CFDD3B6947628320B2E7, "_encstr_8C4C09CA106B5731C02D9C");
  var_8 = var_4;
  var_9 = var_5 - var_4;
  var_10 = var_6 - var_5;
  var_11 = var_7 - var_6;
  var_12 = undefined;
  var_13 = undefined;

  if(!istrue(var_2)) {
    scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
    scripts\common\utility::allow_fire(0);
    scripts\common\utility::allow_melee(0);
    scripts\common\utility::allow_weapon_switch(0);
    scripts\common\utility::allow_usability(0);
    scripts\common\utility::allow_shellshock(0);
    scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(var_3.streakname, "_encstr_A2BE0AB4DC3BB46E5A981BAC");
    self setclientomnvar("_encstr_A5C1142363C173DBC231BA01508AB67B21F67B4C100D", 1);
    var_14 = [];
    var_15 = [];
    var_16 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", "_encstr_9A54146BDB7AE82C23D1A1CB0AE75D311632E7EB6222"))
      var_16 = self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", "_encstr_9A54146BDB7AE82C23D1A1CB0AE75D311632E7EB6222")]](self);

    if(isDefined(var_16.enemytargetmarkergroup))
      var_14 = var_16.enemytargetmarkergroup;

    if(isDefined(var_16.friendlytargetmarkergroup))
      var_15 = var_16.friendlytargetmarkergroup;

    var_12 = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("_encstr_85041AA3432B9CDA0BB13BB437A57B73AC73CA6B5E91AC33C25D8DA3", self, var_14, self, 0, 1, 1);
    var_13 = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("_encstr_8AA71D73E46590B11AA3F5F3E7A288383EFA58290DCCD873A26FDDEB979A4D", self, var_15, self, 1, 1);
    self playerlinkweaponviewtodelta(var_0, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 0, 0, 0, 0, 1);
    self playerlinkedsetviewznear(0);
    var_0 thread cruisepredator_playdofsequence();
    self painvisionoff();
    scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
    var_0 thread initbrc130airdropdropanims(var_3, var_12, var_13);
    var_0 thread initbrmechanics("_encstr_8D820B49520F0EC02DDE6367EC");
    var_0 thread initbrmechanics("_encstr_81170C244F9CBDE72C01BB99A298");
    var_0 thread initbrmechanics("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  }

  var_17 = "_encstr_BA731DF89168F9A823EF9018E7C2B11FDBDC345108CFDD3B6947628320B2E7";
  var_18 = getdvarint("_encstr_BE9716C7AF038830426B102B170728583B4347173F2A6B98", 0);

  if(var_18 == 1)
    var_17 = "_encstr_B8D42308C1F8665BFBA367CD9FB9509BEFA89203667D8D4E3A3E96FD64B53F46A3E07910BF";

  var_0 scriptmodelplayanimdeltamotion(var_17);
  var_0 setscriptablepartstate("_encstr_ACE90E9DC2D03A698D78D8DB1B8B72ED", "_encstr_AB0703DBB9", 0);
  var_0 setscriptablepartstate("_encstr_9A5007A9E5275F8ACA", "_encstr_AB0703DBB9", 0);

  if(!istrue(var_2))
    var_0 playsoundtoplayer("_encstr_A19E1DD434E161FBD3080F7F902EBD4A0F4E5C0D95874B0C3B71070370A367", self);

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_8);

  if(!isDefined(var_0))
    return 0;

  var_0 setscriptablepartstate("_encstr_99760C3BB425F90F7192E8070B20", "_encstr_AB0703DBB9");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_9);

  if(!isDefined(var_0))
    return 0;

  var_0 setscriptablepartstate("_encstr_99760C3BB425F90F7192E8070B20", "_encstr_BA19049F4B2D");
  var_0 setscriptablepartstate("_encstr_ACE90E9DC2D03A698D78D8DB1B8B72ED", "_encstr_BA19049F4B2D", 0);
  playFXOnTag(scripts\engine\utility::getfx("_encstr_B69D1370E5281F8F35F83BD12380D399488D1DE94F"), var_0, "_encstr_91630C0C561F51EA516F0F610550");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_10);

  if(!isDefined(var_0))
    return 0;

  var_0 setscriptablepartstate("_encstr_B4AE0D3757C4EBD1D0E4EADC8ECA27", "_encstr_AB0703DBB9", 0);

  if(!isDefined(var_0) || !isDefined(self))
    return 0;

  thread cruisepredator_delayplayslamzoom(var_11 - 0.15, var_2);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_11 - 0.05);

  if(!isDefined(var_0) || !isDefined(self))
    return 0;

  thread cruisepredator_takecontrol(var_0, var_3, var_2, var_12, var_13);
  return 1;
}

cruisepredator_playdofsequence() {
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.owner enablephysicaldepthoffieldscripting();
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);
  self.owner setphysicaldepthoffield(0.2, 300, 20, 10);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);
  self.owner setphysicaldepthoffield(5.6, 5000, 3, 10);
}

cruisepredator_takecontrol(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 setscriptablepartstate("_encstr_9A5007A9E5275F8ACA", "_encstr_BA19049F4B2D", 0);
  var_0 setscriptablepartstate("_encstr_B4AE0D3757C4EBD1D0E4EADC8ECA27", "_encstr_BA19049F4B2D", 0);
  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  var_5 = spawnStruct();
  var_5.origin = var_0 gettagorigin("_encstr_91630C0C561F51EA516F0F610550");
  var_5.angles = var_0 gettagangles("_encstr_91630C0C561F51EA516F0F610550");
  var_5.modelname = "_encstr_BD821E2B9DAC31F402A73B3B3FCBB37045F9510303191825591F1B15AB728F78";
  var_5.vehicletype = "_encstr_A18F17EC5643D7D8C9AEA56EB2FA383959C82CE8DB4EBE6B07";
  var_5.targetname = "_encstr_9B47087BFE3354A92D42";
  var_5.cannotbesuspended = 1;
  var_6 = spawnStruct();
  var_7 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_5, var_6);

  if(!isDefined(var_7)) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A76B16AD2D1B366EE8279558AD6A586D2B65B24396368D2B"))
    var_7[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A76B16AD2D1B366EE8279558AD6A586D2B65B24396368D2B")]](var_1.streakname);

  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(var_7);
  var_1.shots_fired++;
  var_7 setCanDamage(0);
  var_7 setotherent(self);
  var_7 setentityowner(self);
  var_7.angles = var_0 gettagangles("_encstr_91630C0C561F51EA516F0F610550");
  var_7.team = self.team;
  var_7.owner = self;
  var_7.streakinfo = var_1;
  var_7.lifetime = 10;
  var_7 setscriptablepartstate("_encstr_8FA2115F37938390A1DF265BC49A58464B8FCD", "_encstr_AB0703DBB9", 0);
  var_7 setvehicleteam(var_7.team);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23"))
    var_7[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23")]](var_1.streakname, "_encstr_81860F1741A58ADBBB43D3B36C79AF3083", self, 0, 1, 50);

  var_7.killcament = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_7 gettagorigin("_encstr_8E010B996FB7B6B3C1D1183343"));
  var_7.killcament setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_7.killcament linkTo(var_7, "_encstr_8E010B996FB7B6B3C1D1183343");
  var_7 endon("_encstr_AD75063D571AE108");
  var_7 scripts\cp_mp\emp_debuff::set_apply_emp_callback(::cruisepredator_empapplied);
  var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_7 gettagorigin("_encstr_B2BF0708BA770F795B"));
  var_8 setModel("_encstr_8DBB16D66EF5C64E574BB92BD707C9B246581DDE39D7D60E");
  var_8.angles = var_7 gettagangles("_encstr_B2BF0708BA770F795B");
  var_8.team = var_7.team;
  var_8.owner = var_7.owner;
  var_8.streakinfo = var_7.streakinfo;
  var_8 linkTo(var_7, "_encstr_B2BF0708BA770F795B");
  var_8 setscriptablepartstate("_encstr_93640BB9B39752774DD59789A4", "_encstr_AB0703DBB9", 0);
  var_8 setotherent(self);
  var_8 thread initbattleroyalelootchoppercratedata(var_1);
  var_8 thread cruisepredator_watchmissileinfo(var_7);
  var_8 thread cruisepredator_watchmissileexplosion(var_7, self, var_7.killcament, var_2, var_3, var_4);
  var_7 thread initbrmechanics("_encstr_8D820B49520F0EC02DDE6367EC");
  var_7 thread initbrmechanics("_encstr_81170C244F9CBDE72C01BB99A298");
  var_7 thread initbrmechanics("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");

  if(!istrue(var_2))
    self visionsetkillstreakforplayer("_encstr_B40101", 0.1);

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.05);

  if(!istrue(var_2)) {
    self disablephysicaldepthoffieldscripting();
    self unlink();
    self cameralinkTo(var_7, "_encstr_8E010B996FB7B6B3C1D1183343", 1);
    self controlslinkTo(var_7);
    self visionsetkillstreakforplayer("_encstr_86570D765A9313D3DDCFB0D82BFFCB");
    self.soundent = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_7.origin);
    self.soundent showonlytoplayer(self);
    self.soundent playLoopSound("_encstr_BA321749CFE2F1A7169BAA73E1F8D734E06FF1C47331C2433E");
    scripts\cp_mp\utility\shellshock_utility::_shellshock("_encstr_A37A196F13897ACB10E3FFC6F871F62253E7C7BFF3A523912168B2", "_encstr_AC190479FF92", var_7.lifetime, 0);
    scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(var_1.streakname, "_encstr_AB0703DBB9");
    self setclientomnvar("_encstr_A5C1142363C173DBC231BA01508AB67B21F67B4C100D", 2);
    self setclientomnvar("_encstr_8B4F1557D2F5B6D236C637E839AC2CDABE0DB2B0B11D1A", 1);
    self setclientomnvar("_encstr_B42D181FA4C122A3EC31C0BB932B52E26F3B600BD68C2B3F4738", gettime() + int(10000));
    self setclientomnvar("_encstr_82311AEA4BFA8327CA910BD1DE9CD76BA5B9372DD8959B7DB156CCD1", -1);

    if(scripts\cp_mp\utility\game_utility::isnightmap()) {
      self visionsetthermalforplayer("_encstr_9966162345622836E29FAE98038AD0BEBDDF207C2BDBB320");
      scripts\cp_mp\utility\player_utility::setthermalvision(1, 12, 1500);
      scripts\cp_mp\utility\shellshock_utility::_shellshock("_encstr_9A4B1E2B8BB08BEAD9B8720A48B76367E878ABD911394B36E770EA82685F9D6B", "_encstr_AC190479FF92", var_7.lifetime, 0);
    }
  }

  var_7 thread cruisepredator_delaymissilecollision();
  var_9 = randomintrange(1, 3);
  var_7 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_8EA510C983772B9BCFCF4F5F1673F0E0FBC9" + var_9);
  var_7 thread cruisepredator_watchtimer(self);
  waitframe();

  if(isDefined(var_0))
    var_0 delete();
}

cruisepredator_watchkillborder() {
  if(!isDefined(level.kill_border_triggers)) {
    return;
  }
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_93510A16C71B20636A2AB8B8");
  self endon("_encstr_B8ED0C0FF093FFE2639CEB627519");
  self endon("_encstr_9B260FF3FBB77BA40877B2B43FF02C973D");

  for(;;) {
    if(cruisepredator_istouchingkillborder(level.kill_border_triggers)) {
      self notify("_encstr_860808CB78E2984063BA");
      break;
    }

    waitframe();
  }
}

cruisepredator_istouchingkillborder(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(self istouching(var_3)) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

cruisepredator_delaymissilecollision() {
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_AD75063D571AE108");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.75);
  self vehphys_enablecollisioncallback(1);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1.25);
  thread cruisepredator_watchkillborder();
}

initbattleroyalelootchoppercratedata(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.owner endon("_encstr_924218E7524350AE87F9A8D0C3276BB09FE7654BE62CF87BAF62");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  self.owner scripts\cp_mp\utility\killstreak_utility::_id_12AA7(var_0);
}

cruisepredator_watchmissileinfo(var_0) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self.missilelastpos = var_0.origin;
    self.missilelastangle = var_0.angles;
    waitframe();
  }
}

cruisepredator_watchmissileexplosion(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_2;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = var_0.streakinfo;
  var_10 = var_0 cruisepredator_waittillexplode("_encstr_93510A16C71B20636A2AB8B8", "_encstr_860808CB78E2984063BA", "_encstr_AD75063D571AE108", "_encstr_974C090268FEF793209304", "_encstr_B8ED0C0FF093FFE2639CEB627519", "_encstr_9B260FF3FBB77BA40877B2B43FF02C973D");

  if(isDefined(var_4))
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var_4);

  if(isDefined(var_5))
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var_5);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", "_encstr_8434101E9097085396F380C90AAFDB208F5B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", "_encstr_8434101E9097085396F380C90AAFDB208F5B")]](var_1);

  if(isDefined(self)) {
    var_7 = self.missilelastpos;
    var_8 = self.missilelastangle;

    if(isDefined(var_1)) {
      var_1 cameraunlink();
      var_1 controlsunlink();
    }

    if(isDefined(var_0)) {
      scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(var_0);
      scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(var_0);
    }

    if(!isDefined(var_10) || var_10.msg != "_encstr_B8ED0C0FF093FFE2639CEB627519" && var_10.msg != "_encstr_9B260FF3FBB77BA40877B2B43FF02C973D") {
      var_11 = 600;
      var_12 = "_encstr_B45C0E2DFF41B17F437FB870E733FBFF";
      var_13 = "_encstr_8DCB0F47F22330CEE7996B13A2E390583A";

      if(isDefined(var_1)) {
        var_14 = isDefined(var_10) && var_10.msg == "_encstr_974C090268FEF793209304";

        if(!istrue(var_14))
          self radiusdamage(var_7, var_11, 1000, 1000, var_1, var_12, var_13);

        var_15 = scripts\common\utility::playersinsphere(var_7, var_11);

        foreach(var_17 in var_15) {
          if(var_17 scripts\cp_mp\utility\player_utility::_isalive() && scripts\cp_mp\utility\player_utility::playersareenemies(var_17, var_1)) {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8260069BDBBACD46", "_encstr_8E8311D9FBA39E303955A0390604E9C8DB2361"))
              level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8260069BDBBACD46", "_encstr_8E8311D9FBA39E303955A0390604E9C8DB2361")]](var_17, "_encstr_8B521166D81667DE39F536D8B76EACD8C28D36", undefined, 1);
          }
        }
      }
    }

    scripts\cp_mp\utility\shellshock_utility::shellshock_artilleryearthquake(var_7, 1, 1, 1000);
    thread cruisepredator_handlevfxstates(var_10);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", "_encstr_A26B0C88C3FF7523FBDD0E70A24B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", "_encstr_A26B0C88C3FF7523FBDD0E70A24B")]](var_7);

  if(isDefined(var_1)) {
    var_1 thread cruisepredator_watchkills(var_10);

    if(!istrue(var_3)) {
      if(isDefined(var_1.soundent)) {
        var_1.soundent stoploopsound("_encstr_BA321749CFE2F1A7169BAA73E1F8D734E06FF1C47331C2433E");
        var_1.soundent delete();
      }

      var_1 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(var_9.streakname, "_encstr_BA19049F4B2D");
      var_1 setclientomnvar("_encstr_A5C1142363C173DBC231BA01508AB67B21F67B4C100D", 0);
      var_19 = 1;
      var_20 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_7);
      var_20 setModel("_encstr_8E010B996FB7B6B3C1D1183343");
      var_21 = getdvarint("_encstr_8CBC175E3EC35FB1AA0780582FEF2953CB26DE6B997AFB7B74", 1000);
      var_22 = getdvarint("_encstr_AF3019C31EE3D77E453002BBA8C777F7DBF75B40B808678407F0DB", 0);
      var_23 = anglesToForward(var_8);
      var_24 = var_7 - var_23 * var_21;
      var_25 = (0, 0, var_22);
      var_26 = var_24 + var_25;
      var_20.angles = vectortoangles(var_7 + (0, 0, 150) - var_26);
      var_6 unlink();
      var_6 linkTo(var_20, "_encstr_8E010B996FB7B6B3C1D1183343", (0, 0, 0), (0, 0, 0));

      if(scripts\cp_mp\utility\game_utility::isnightmap())
        var_1 scripts\cp_mp\utility\player_utility::setthermalvision(0);

      var_20.origin = var_26;
      var_1 cameralinkTo(var_20, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
      var_27 = "_encstr_A13817972B0FDAEFB8915BFE15F72F4B48E3CEAED5F8E3F18E";

      if(var_19 == 2)
        var_27 = "_encstr_9A7416B19CD55ACDB2FAC12756C8C21DB793D799632C6E86";

      var_1 thread cruisepredator_startfadecamtransition(0.4, 0.6, 0.05, var_27);
      var_28 = scripts\common\utility::playersinsphere(var_7, 2000);

      foreach(var_17 in var_28) {
        if(!isDefined(var_17) || !var_17 scripts\cp_mp\utility\player_utility::_isalive() || var_17 == var_1) {
          continue;
        }
        var_17 earthquakeforplayer(0.3, 2, var_17.origin, 100);
        var_17 setclientomnvar("_encstr_BA2A0D5D4BD743AE32EB6E340BB559", 1);
        var_17 playrumbleonpositionforclient("_encstr_A9D111B0278EA5D8D85939CBF5E4AED613D8B2", var_17.origin);
      }

      var_1 earthquakeforplayer(0.3, 3, var_1.origin, 100);
      var_1 setclientomnvar("_encstr_BA2A0D5D4BD743AE32EB6E340BB559", 1);
      var_1 playrumbleonpositionforclient("_encstr_A9D111B0278EA5D8D85939CBF5E4AED613D8B2", var_1.origin);
      wait 0.5;
      var_1 notify("_encstr_924218E7524350AE87F9A8D0C3276BB09FE7654BE62CF87BAF62");
      var_1 cruisepredator_returnplayer(var_9, var_20);
      var_1 scripts\cp_mp\utility\killstreak_utility::_id_12AA7(var_9);
    }
  }

  if(isDefined(var_6))
    var_6 delete();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", "_encstr_B672136E3DEFB08D3FF8D050521F7D480793F96884"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", "_encstr_B672136E3DEFB08D3FF8D050521F7D480793F96884")]](var_1);
}

cruisepredator_cameramove(var_0, var_1) {
  self moveTo(var_0, 0.2, 0, 0.05);
  wait 0.15;
  self moveTo(var_0 + vectorNormalize(var_1 - var_0) * 24, 2);
}

cruisepredator_returnplayer(var_0, var_1) {
  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](var_0);

  scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
  self cameraunlink();
  var_1 delete();
  self visionsetkillstreakforplayer("_encstr_B40101");
  scripts\common\utility::allow_fire(1);
  scripts\common\utility::allow_melee(1);
  scripts\common\utility::allow_weapon_switch(1);
  scripts\common\utility::allow_usability(1);
  scripts\common\utility::allow_shellshock(1);
  self painvisionon();
  scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
  level thread scripts\cp_mp\utility\killstreak_utility::_id_12CC6(self);
  var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
}

cruisepredator_watchtimer(var_0) {
  self endon("_encstr_AD75063D571AE108");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(10.1);
  self notify("_encstr_860808CB78E2984063BA", self.origin);
}

cruisepredator_watchexplosiondistance(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = [self, var_1];
  var_3 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 0, 0);

  for(;;) {
    var_4 = anglesToForward(self.angles);
    var_5 = self gettagorigin("_encstr_91630C0C561F51EA516F0F610550");
    var_0.lastknownmissilepos = var_5;
    var_0.lastknownmissileangles = self.angles;
    var_6 = getdvarint("_encstr_BA67170328D5F9A76BA57163B51657BD39C08AEB61412CAFC3", 50);

    if(isDefined(self.missilebooston))
      var_6 = getdvarint("_encstr_A2161DC399CE872690E3796BEBD16CF777715A3B66AE0F1D40195744EBC873", 150);

    var_7 = var_5 + var_4 * var_6;
    var_8 = scripts\engine\trace::sphere_trace(var_5, var_7, 5, var_2, var_3);

    if(isDefined(var_8["_encstr_AA1C0886968EA32FE056"]) && var_8["_encstr_AA1C0886968EA32FE056"] != "_encstr_AC4B0D3BD013D433491D6125700D8A") {
      if(isDefined(var_8["_encstr_BD260953AA97E3F014279D"])) {
        var_0.lastknowntrace = var_8;
        self notify("_encstr_875516B6D2DC6E968DAC7D8DC6F69BACBE56E1E036F6C8B2", var_8["_encstr_BD260953AA97E3F014279D"]);
        break;
      }
    }

    wait 0.05;
  }
}

cruisepredator_watchmissileboost(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 notifyonplayercommand("_encstr_955E11E2188EF76420830F3ABF10AA5320704A", "_encstr_A9E60828803C73F11780");

  for(;;) {
    var_0 waittill("_encstr_955E11E2188EF76420830F3ABF10AA5320704A");
    self.missilebooston = 1;
    break;
  }
}

initbrmechanics(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_974C090268FEF793209304");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = self.owner;
  var_1 waittill(var_0);
  self notify("_encstr_974C090268FEF793209304");
}

cruisepredator_startexplodecamtransition() {
  self visionsetkillstreakforplayer("_encstr_B4C919474BD33310F54193EBF7DCC8F52A2347EFAB3A898007A538", 0.05);
  wait 0.1;
  self visionsetkillstreakforplayer("_encstr_B40101", 0.05);
}

cruisepredator_startfadecamtransition(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0))
    var_0 = 0.5;

  if(!isDefined(var_1))
    var_1 = 0.5;

  if(!isDefined(var_2))
    var_2 = 0.05;

  if(isDefined(var_3)) {
    self visionsetkillstreakforplayer(var_3, var_0);
    wait(var_1);
    self visionsetkillstreakforplayer("_encstr_B40101", var_2);
  } else {
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, var_0);
    wait(var_1);
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, var_2);
  }
}

cruisepredator_shakerider(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = 0;

  while(var_1 < var_0) {
    self playrumbleonpositionforclient("_encstr_B14F0D7B2B51F287F03ED59C51F0DC", self.origin);
    var_1 = var_1 + 0.05;
    wait 0.05;
  }
}

cruisepredator_waittillexplode(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("_encstr_AD75063D571AE108");
  var_6 = spawnStruct();

  if(isDefined(var_0))
    thread waittill_explodestring(var_0, var_6);

  if(isDefined(var_1))
    thread waittill_explodestring(var_1, var_6);

  if(isDefined(var_2))
    thread waittill_explodestring(var_2, var_6);

  if(isDefined(var_3))
    thread waittill_explodestring(var_3, var_6);

  if(isDefined(var_4))
    thread waittill_explodestring(var_4, var_6);

  if(isDefined(var_5))
    thread waittill_explodestring(var_5, var_6);

  var_6 waittill("_encstr_BE3009989F7CABE51AAFDD", var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15);
  var_6 notify("_encstr_B81804322D2B");
  self.owner notify("_encstr_A93F171B93AB4BE695D7B55A37B9961BB2F5ACC383D87BC895");
  var_16 = spawnStruct();
  var_16.msg = var_7;
  var_16.param1 = var_8;
  var_16.param2 = var_9;
  var_16.param3 = var_10;
  var_16.param4 = var_11;
  var_16.param5 = var_12;
  var_16.param6 = var_13;
  var_16.param7 = var_14;
  var_16.param8 = var_15;
  return var_16;
}

waittill_explodestring(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_B81804322D2B");
  self waittill(var_0, var_2, var_3, var_4, var_5, var_6, var_7);
  var_1 notify("_encstr_BE3009989F7CABE51AAFDD", var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

cruisepredator_handlevfxstates(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self unlink();

  if(!isDefined(var_0) || var_0.msg == "_encstr_860808CB78E2984063BA" || var_0.msg == "_encstr_974C090268FEF793209304" || var_0.msg == "_encstr_B8ED0C0FF093FFE2639CEB627519" || var_0.msg == "_encstr_9B260FF3FBB77BA40877B2B43FF02C973D") {
    self setscriptablepartstate("_encstr_88460E53F9127135637BF88053FFF830", "_encstr_AB0703DBB9", 0);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.2);
    self delete();
  }

  var_1 = (0, 0, 1);
  var_2 = var_0.param6;
  self.angles = vectortoangles(var_2);
  var_3 = vectordot(var_2, var_1);

  if(var_3 >= 0.7)
    self setscriptablepartstate("_encstr_861B113BC9B7D537C8BEACF038D87BCD4BF637", "_encstr_AB0703DBB9", 0);
  else
    self setscriptablepartstate("_encstr_88460E53F9127135637BF88053FFF830", "_encstr_AB0703DBB9", 0);

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  self delete();
}

cruisepredator_watchkills(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);

  if(isDefined(self) && isDefined(self.recentkillcount)) {
    if(self.recentkillcount >= 1)
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_A17E0CBB0DA329131B09E782F418", 1);
    else
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_B66D0C6CE4AED2CDACEBB5B4CD37", 1);
  }
}

cruisepredator_delayplayslamzoom(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);

  if(!istrue(var_1)) {
    self visionsetkillstreakforplayer("_encstr_B4C919474BD33310F54193EBF7DCC8F52A2347EFAB3A898007A538", 0.1);
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0.2);
    wait 0.2;
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0);
  }
}

cruisepredator_empapplied(var_0) {
  if(isDefined(self))
    self notify("_encstr_B8ED0C0FF093FFE2639CEB627519");
}