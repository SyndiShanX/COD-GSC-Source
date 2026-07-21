/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_remote_tank.gsc
***********************************************/

main(var_0, var_1, var_2) {
  scripts\common\vehicle_build::build_template("_encstr_BE1B129DCAA1F583B036BEB92B37D14E5E7DAD83", var_0, var_1, var_2);
  scripts\common\vehicle_build::build_localinit(::init_local);
  scripts\common\vehicle_build::build_life(1500, 1499, 1500);
  scripts\common\vehicle_build::build_team("_encstr_8E8405EA382B2A");
}

init_local() {}

init_remote_tank() {
  level._effect["_encstr_B47D0F3BB443FA83D24728CE03F970838D"] = loadfx("_encstr_962136E34C7176E16352E72F2850AC9A3555EDCDA6C9C93C49682E73F0D2A763E1FD3795160F124753E03763B82857DA6118AA1B5095CA98");
  level._effect["_encstr_9B1314A28D9BB23CE1A98BE71818DFDA699FAD1DE523"] = loadfx("_encstr_8C9E3CF84B11D740732F2957D186143B5BA8680A7EC3D791A216767ED99B7E93D86F8D68D3383D2E6CF3A95DC0AF38C373C73260676380351B90E6C3744A");
  level.tanksettings = [];
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"] = spawnStruct();
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].timeout = 60.0;
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].maxhealth = 500;
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].hitstokill = 5;
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].streakname = "_encstr_B1B30B51D176511E377A1BC313";
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].modelbase = "_encstr_850114B32B430EBE6BA536AFC6B923FAEE43DEA359B1";
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].modeldestroyed = "_encstr_850114B32B430EBE6BA536AFC6B923FAEE43DEA359B1";
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].mgturretmodelbase = "_encstr_B6941B55DDAC72AF1F32107E4A3B459183389FD9451501DD079BEB2133";
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].mgturretinfo = "_encstr_8DC0152AE28E9F8B7F0273BE1B5E24FD03CDCD53914303";
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].sentrymodeon = "_encstr_9B1807D39B48FD93A3";
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].sentrymodeoff = "_encstr_84FD0F03BB736BB3C36E7AF251911725E0";
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].vehicleinfo = "_encstr_BD9F15EB550A18B9D2D3B973F7B818C033915FF8D15E10";
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].stringcannotplace = &"_encstr_8FBF20B8242923C2B9856D71AFD9997BC3BCC161CD17F34D89A17F7BD30995DF1B14";
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].scorepopup = "_encstr_99B31528D8CBCCDB2878F291A13B21683010A506257D8B";
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].vodestroyed = "_encstr_99B31528D8CBCCDB2878F291A13B21683010A506257D8B";
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].destoyedsplash = "_encstr_A9F01D6C858D8DEDABE8BE91956E8EE4DEE5B232F507C2D8AFCD9537D13997";
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].premoddamagefunc = undefined;
  level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].lifetime = 600;
  level.remote_tank_armor_bulletdamage = 0.5;
  setdvarifuninitialized("_encstr_8CFA13F05AF2CF7BFFE32836FD1B235D98217A6042", 0);
  setdvarifuninitialized("_encstr_96EF189B1BC9D738586CF537CA9BA3E497D78DB43359E8D2B5CA", level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].timeout);
  setdvarifuninitialized("_encstr_9BDE1A765F3316982187215BFD409443E2CF9F50026D2E08874B5743", 0);
}

spawn_remote_tank(var_0, var_1, var_2) {
  var_3 = level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"];

  if(isDefined(var_2))
    var_3 = var_2;

  var_4 = var_0.origin;
  var_5 = var_0.angles;

  if(!isDefined(var_5))
    var_5 = (0, 0, 0);

  var_6 = spawnVehicle(var_3.modelbase, "_encstr_BD9F15EB550A18B9D2D3B973F7B818C033915FF8D15E10", var_3.vehicleinfo, var_4, var_5);

  if(!isDefined(var_6))
    return undefined;

  var_6.team = "_encstr_8E8405EA382B2A";
  var_6.tanktype = "_encstr_A3AC0C1A9D50B2D162C0E3B0C28A";
  var_6.streakname = "_encstr_B1B30B51D176511E377A1BC313";
  var_6.config = var_3;
  var_6.maxhealth = var_3.maxhealth;
  var_6.health = var_6.maxhealth;
  var_6.lifetime = var_3.lifetime;
  var_7 = var_6 getentitynumber();
  var_6 addtoassaultdronelist(var_7);
  var_6 thread removefromassaultdronelistondeath(var_7);
  var_8 = var_6 gettagorigin("_encstr_99FE0B2B19086F6B9DC5D387E1");
  var_9 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_8, var_3.mgturretinfo, 0);
  var_9 linkTo(var_6, "_encstr_99FE0B2B19086F6B9DC5D387E1", (0, 0, 0), (0, 0, 0));
  var_9 setModel(level.tanksettings["_encstr_A3AC0C1A9D50B2D162C0E3B0C28A"].mgturretmodelbase);
  var_9.angles = var_6.angles;
  var_9.tank = var_6;
  var_9 setmode("_encstr_849007B268BD03DFD8");
  var_9 setturretteam("_encstr_8E8405EA382B2A");
  var_9 setdefaultdroppitch(0);
  var_9 setleftarc(360);
  var_9 setrightarc(360);
  var_9 settoparc(45);
  var_9 setbottomarc(45);
  var_9 setconvergencetime(0.05, "_encstr_AF1904C7E3A4");
  var_9 setconvergencetime(0.05, "_encstr_BD6506F36A2B46B0");
  var_6.mgturret = var_9;
  var_6.spawn_node = var_0;
  var_6.repulsor = createnavrepulsor("_encstr_8CAB0EBB60A01B819DCD9AD3A1475ACA", 0, var_6, 128, 1);

  if(isDefined(var_1)) {
    if(!isDefined(level.remote_tanks))
      level.remote_tanks = [];

    level.remote_tanks[var_1] = var_6;
  }

  var_6 thread remotetank_rumble();
  return var_6;
}

remotetank_rumble() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    playrumbleonposition("_encstr_ABC013C6077DBB1A59CA36B9EDDC7D9C576B2636B2", self.origin);
    wait 0.25;
  }
}

use_remote_tank(var_0) {
  var_1 = playremotesequence("_encstr_99300BBDCF8AE8C00D7359B05C", 1);

  if(var_1)
    tank_finishdropoffsequence(self, var_0);
}

addtoassaultdronelist(var_0) {
  if(!isDefined(level.assaultdrones))
    level.assaultdrones = [];

  level.assaultdrones[var_0] = self;
}

removefromassaultdronelistondeath(var_0) {
  self waittill("_encstr_AD75063D571AE108");
  level.assaultdrones[var_0] = undefined;
}

tank_finishdropoffsequence(var_0, var_1) {
  var_2 = var_1.origin + (0, 0, 200);
  var_3 = var_1.angles;
  var_4 = var_2 - anglesToForward(var_3) * 100;
  var_5 = var_3;
  var_6 = "_encstr_AB0703DBB9";

  if(isDefined(self.config._id_13E88))
    var_6 = self.config._id_13E88;

  var_1.mgturret setscriptablepartstate("_encstr_938A07DDE8F8A8FB0E", var_6);
  var_1.mgturret laseron();
  var_0 scripts\common\utility::allow_fire(0);
  var_1.owner = var_0;
  var_1.mgturret maketurretoperable();
  var_1 tank_playercameratransition(var_2, var_3, var_4, var_5);
  var_0 scripts\common\utility::allow_fire(1);
  var_0 thread startusingtank(var_1);
  var_1 thread tank_watchfortimeoutdisowned();
  var_1 thread tank_handleairburst();
  var_1 thread tank_handlewheeldustfx();
}

tank_playercameratransition(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.owner unlink();
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_4 setModel("_encstr_8E010B996FB7B6B3C1D1183343");
  var_4.owner = self.owner;
  var_4.angles = var_1;
  self.owner playerlinkweaponviewtodelta(var_4, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 0, 0, 0, 0, 1);
  self.owner playerlinkedsetviewznear(0);
  level notify("_encstr_96291AA5D89B04C875960FA5AB2729121B05F9EF8F72B807A5454724", "_encstr_9A591141C97E59285BA366EBBAF7D188952FEB", self.owner, 0.2);
  var_2 = var_2 + (0, 0, 20);
  var_3 = vectortoangles(var_0 - var_2);
  var_4 moveTo(var_2, 0.5);
  var_4 rotateTo(var_3, 0.5);
  self.owner thread tank_startfadetransition();
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  level notify("_encstr_96291AA5D89B04C875960FA5AB2729121B05F9EF8F72B807A5454724", undefined, self.owner, 0.2, "_encstr_9A591141C97E59285BA366EBBAF7D188952FEB");
  self.owner unlink();
  var_4 delete();
}

tank_startfadetransition() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level notify("_encstr_96291AA5D89B04C875960FA5AB2729121B05F9EF8F72B807A5454724", "_encstr_9A591141C97E59285BA366EBBAF7D188952FEB", self, 0.5);
  wait 0.5;
  level notify("_encstr_96291AA5D89B04C875960FA5AB2729121B05F9EF8F72B807A5454724", undefined, self, 0.5, "_encstr_9A591141C97E59285BA366EBBAF7D188952FEB");
}

startusingtank(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.isusingremotetank = 1;
  var_0.mgturret setCanDamage(1);
  var_0 setCanDamage(1);
  var_1 = spawnStruct();
  var_1.playdeathfx = 1;
  var_1.deathoverridecallback = ::tank_override_moving_platform_death;
  var_0 setotherent(self);
  var_0 setentityowner(self);
  var_0.driver = self;
  self controlslinkTo(var_0);
  self remotecontrolturret(var_0.mgturret);
  self painvisionoff();
  self setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 1);
  self setclientomnvar("_encstr_A72E17BAA5F50EB036EBB92B9BD19C2FBE8DDB731D4E7BC6CD", 1);
  self setclientomnvar("_encstr_88171447D87EE88A670872EF8821F3990660CB8F2BB1", 0);
  self setclientomnvar("_encstr_B42D181FA4C122A3EC31C0BB932B52E26F3B600BD68C2B3F4738", gettime() + int(var_0.lifetime * 1000));
  self setclientomnvar("_encstr_8B4F1557D2F5B6D236C637E839AC2CDABE0DB2B0B11D1A", var_0.health / var_0.maxhealth);
  var_0 thread tank_earthquake();
  var_0 thread scripts\cp\utility::allowridekillstreakplayerexit("_encstr_AD75063D571AE108");
  scripts\cp\utility::_freezecontrols(0);
}

tank_handlehelidamage() {
  self endon("_encstr_AD75063D571AE108");
}

tank_modifyhelidamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = var_4;
  return var_6;
}

tank_handlehelideathdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;

  if(isDefined(self.intromodel))
    self.intromodel delete();

  self notify("_encstr_AD75063D571AE108");
}

tank_modifydamageresponse(var_0) {
  thread tank_modifydamagestate(var_0);
  var_1 = var_0.damage;
  var_2 = var_0.meansofdeath;
  return 1;
}

tank_modifydamagestate(var_0) {
  var_1 = var_0.damage;
  self.currenthealth = self.health - var_1;
  return 1;
}

tank_override_moving_platform_death(var_0) {
  thread tank_destroy();
}

tank_watchfortimeoutdisowned() {
  self endon("_encstr_AD75063D571AE108");
  tank_watchfortimeoutdisownedendearly();
  thread tank_destroy();
}

tank_watchfortimeoutdisownedendearly() {
  self endon("_encstr_A2DA0F6DD2B136CDD1275958B5A8E1D2A3");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.owner endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self.owner endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(self.lifetime);
}

tank_destroy(var_0) {
  if(istrue(self.destroyed))
    return;
  else
    self.destroyed = 1;

  level.remote_tanks = scripts\engine\utility::array_remove(level.remote_tanks, self);
  self notify("_encstr_AD75063D571AE108");
  self.mgturret notify("_encstr_AD75063D571AE108");

  if(!isDefined(var_0))
    var_0 = self.owner;

  if(isDefined(self.driver))
    thread tank_driverexit(self.driver);

  self.health = 0;
  self setCanDamage(0);
  self.mgturret setmode("_encstr_84FD0F03BB736BB3C36E7AF251911725E0");
  waitframe();
}

tank_destroycallback(var_0) {
  thread tank_destroy(var_0.attacker);
  return 0;
}

tank_driverexit(var_0) {
  self waittill("_encstr_A2DA0F6DD2B136CDD1275958B5A8E1D2A3");
  self notify("_encstr_920E0BE7880931BA61B86733C0");
  self.driver = undefined;
  var_0.isusingremotetank = undefined;
  var_0 controlsunlink();

  if(isDefined(self.mgturret))
    var_0 remotecontrolturretoff(self.mgturret);

  if(isDefined(var_0.restoreangles)) {
    var_0 setplayerangles(var_0.restoreangles);
    var_0.restoreangles = undefined;
  }

  var_0 setclientomnvar("_encstr_A72E17BAA5F50EB036EBB92B9BD19C2FBE8DDB731D4E7BC6CD", 0);
  var_0 thread stopremotesequence(1);
  self setotherent(undefined);
  self setentityowner(undefined);
  self.owner = undefined;
  self.mgturret maketurretinoperable();
  var_0 painvisionon();
}

tank_handleairburst() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self.mgturret waittill("_encstr_ACA30D383847FB93AAFF7705139D4B", var_0);
    var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
    var_1 setModel("_encstr_B8B311442EAFD80639DFE3529D08BA4A110A4B");
    var_1.angles = var_0.angles;
    var_1 linkTo(var_0);
    var_1 setentityowner(self.owner);
    thread tank_watchprojectiledeath(var_0, var_1);
    thread tank_findclosestairbursttarget(var_0);
  }
}

tank_watchprojectiledeath(var_0, var_1) {
  var_1 endon("_encstr_AD75063D571AE108");
  var_2 = var_0 scripts\engine\utility::_id_143AD("_encstr_AD75063D571AE108", "_encstr_8B93119A356DEAFFDBF0DF2FF8F3AA830556E3");

  if(isDefined(var_2) && var_2 == "_encstr_8B93119A356DEAFFDBF0DF2FF8F3AA830556E3") {
    var_1 setscriptablepartstate("_encstr_881C0916B43931BA9337D1", "_encstr_955B0822180E2F20C091");
    var_1 unlink();
    var_1 thread tank_delayairburstscriptabledeath();

    if(isDefined(var_0))
      var_0 delete();
  } else
    var_1 delete();
}

tank_delayairburstscriptabledeath() {
  self endon("_encstr_AD75063D571AE108");
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(2);
  self delete();
}

tank_findclosestairbursttarget(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_1 = undefined;
    var_2 = undefined;
    var_3 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");
    var_4 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_3, undefined, 10, 100);

    foreach(var_6 in var_4) {
      if(!isDefined(var_6) || !scripts\cp\utility::should_be_affected_by_trap(var_6, 1)) {
        continue;
      }
      if(level.teambased && var_6.team == self.owner.team) {
        continue;
      }
      if(!var_0 tank_canseetarget(var_6)) {
        continue;
      }
      var_2 = var_6;
      break;
    }

    if(isDefined(var_2)) {
      var_0 notify("_encstr_8B93119A356DEAFFDBF0DF2FF8F3AA830556E3");
      break;
    } else
      waitframe();
  }
}

tank_handlewheeldustfx() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = 0;

  if(istrue(level.wet_level)) {
    return;
  }
  while(isDefined(self.owner)) {
    var_1 = self vehicle_getspeed();
    var_2 = var_1 * 1.60934;

    if(var_1 > 3 && !istrue(var_0)) {
      var_0 = 1;
      self setscriptablepartstate("_encstr_A16605C8AB6E47", "_encstr_AB0703DBB9");
    } else if(var_1 <= 3 && istrue(var_0)) {
      var_0 = 0;
      self setscriptablepartstate("_encstr_A16605C8AB6E47", "_encstr_BA19049F4B2D");
    }

    self.owner setclientomnvar("_encstr_88171447D87EE88A670872EF8821F3990660CB8F2BB1", int(var_2));
    waitframe();
  }
}

tank_empgrenaded() {
  self notify("_encstr_9AD81147C2CDB5BEA2D405E893ACE6B0322B8C");
  self endon("_encstr_9AD81147C2CDB5BEA2D405E893ACE6B0322B8C");
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.empgrenaded = 1;
  self.mgturret turretfiredisable();
  wait 3.5;
  self.empgrenaded = 0;
  self.mgturret turretfireenable();
}

tank_watchfiring(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_920E0BE7880931BA61B86733C0");
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 = 50;
  var_2 = var_1;
  var_3 = weaponfiretime(level.tanksettings[var_0.tanktype].mgturretinfo);

  for(;;) {
    if(var_0.mgturret isfiringvehicleturret()) {
      var_2--;

      if(var_2 <= 0) {
        var_0.mgturret turretfiredisable();
        wait 2.5;
        var_0 playSound("_encstr_B2F70DD373524A2326C5FDAAF893A1");
        self playlocalsound("_encstr_BA741130B3F17848818320508702BCAFBB9D2A");
        var_2 = var_1;
        var_0.mgturret turretfireenable();
      }
    }

    wait(var_3);
  }
}

tank_earthquake() {
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_920E0BE7880931BA61B86733C0");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(isDefined(self.owner)) {
    self.owner earthquakeforplayer(0.07, 0.25, self gettagorigin("_encstr_8F1E092CC9F71178C01941"), 500);
    wait 0.25;
  }
}

tank_canseetarget(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  var_2 = 0;
  var_3 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0, 1);
  var_4 = [var_0 gettagorigin("_encstr_AADA07DBF19A4A81D7"), var_0 gettagorigin("_encstr_8FE10B52092BB64F28E6B7BFFD"), var_0 gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37")];

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    if(!scripts\engine\trace::ray_trace_passed(self.origin + var_1, var_4[var_5], self, var_3)) {
      continue;
    }
    var_2 = 1;
    break;
  }

  return var_2;
}

stopremotesequence(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_B45E151389187A1756D9AA720325DF72902BAD8D251047");

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    var_1 = "_encstr_979914D35F4122577120938A0EDD6F9B58E7551F8BE0";

    if(istrue(var_0)) {
      wait 0.1;
      self notify("_encstr_85D31DAEA242BB50514D3967832BF11BAE0557E8D3D709E887FA8EA398AD48" + var_1);
    } else
      self notify("_encstr_95E2216DD2631BE61DE4B20BB6F5995ADC9637A12B32AFDD4BE834AFEEB2C21CBD37AF" + var_1);

    self takeweapon(var_1);
  }

  scripts\cp\utility::clearusingremote();
  scripts\engine\utility::_id_143B9(1.3, "_encstr_AD75063D571AE108");
  self setclientomnvar("_encstr_86601BAE2D7D9C95AD7B8E59D76CBDCD8E93BDD8EBCD59B8AE95CD1BB2", 0);
  self setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 0);
}

playremotesequence(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\cp\utility::isusingremote())
    return 0;

  if(!scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  self notify("_encstr_AD66151CC6B0CBBE93566BED1D56BE37952ED5ACCDD8CA");
  self playlocalsound("_encstr_84391A8DDB29BB5AF11977634D2D82E381E306D6B02B6CF15C134763");
  var_2 = undefined;

  if(istrue(var_1)) {
    if(self isonladder() || self ismantling() || !self isonground()) {
      scripts\cp\cp_hud_message::showerrormessage("_encstr_88DC1899E78C341FF13A053F44B9DFDF265FF9310F542D751897");
      return 0;
    }

    var_2 = "_encstr_979914D35F4122577120938A0EDD6F9B58E7551F8BE0";
    scripts\cp\utility::_giveweapon(var_2, 0, 0, 1);
    self setclientomnvar("_encstr_86601BAE2D7D9C95AD7B8E59D76CBDCD8E93BDD8EBCD59B8AE95CD1BB2", 1);
    var_3 = scripts\cp\cp_weapons::switchtoweaponreliable(var_2);

    if(!istrue(var_3))
      return 0;
  }

  scripts\cp\utility::setusingremote("_encstr_99300BBDCF8AE8C00D7359B05C");
  scripts\cp\utility::_freezecontrols(1);
  thread scripts\cp\cp_weapons::unfreezeonroundend();
  thread scripts\cp\cp_weapons::startfadetransition(1.8);
  var_4 = scripts\engine\utility::_id_143B9(1.8, "_encstr_AD75063D571AE108");
  self notify("_encstr_8A7B0EDA8FB90C908071386FC16FD8C7");

  if(!isDefined(var_4) || var_4 != "_encstr_995408F398012F656821") {
    self setclientomnvar("_encstr_86601BAE2D7D9C95AD7B8E59D76CBDCD8E93BDD8EBCD59B8AE95CD1BB2", 0);
    scripts\cp\utility::_freezecontrols(0);
    scripts\cp\utility::clearusingremote();

    if(isDefined(var_2))
      self notify("_encstr_85D31DAEA242BB50514D3967832BF11BAE0557E8D3D709E887FA8EA398AD48" + var_2);

    self stoplocalsound("_encstr_84391A8DDB29BB5AF11977634D2D82E381E306D6B02B6CF15C134763");
    self notify("_encstr_B44F170EF9A0B39AF17F73277328D3ED81030712932B76325D");
    return 0;
  }

  scripts\cp\utility::_freezecontrols(0);
  self setclientomnvar("_encstr_86601BAE2D7D9C95AD7B8E59D76CBDCD8E93BDD8EBCD59B8AE95CD1BB2", 0);
  return 1;
}

fire_on_nearby_players(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_AA7516EED02B2BD89BDBE69BD732CAC2C6E84B6758E8B2C8");
  self.targetent = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);
  var_1 = 0;
  var_2 = 0.75;

  if(isDefined(self._id_13B64))
    var_2 = self._id_13B64;

  var_3 = 0.5;

  if(isDefined(self._id_13B63))
    var_3 = self._id_13B63;

  if(!isDefined(self.max_detection_sq))
    self.max_detection_sq = 640000;

  thread flicker_tank_lights();
  var_4 = (0, 0, 50);

  for(;;) {
    while(!isDefined(self.owner)) {
      var_5 = undefined;

      foreach(var_7 in level.players) {
        if(distancesquared(self.mgturret.origin, var_7.origin) > self.max_detection_sq) {
          continue;
        }
        if(isDefined(self.waittill_any_return_no_endon_death_5) && gettime() <= self.waittill_any_return_no_endon_death_4 + 5000) {} else if(isDefined(var_0)) {
          var_8 = var_0;

          if(!scripts\engine\math::within_fov_2d(self.mgturret.origin, self.mgturret.angles, var_7.origin, var_8))
            continue;
        }

        var_4 = questtimerupdate(var_5);

        if(!tank_canseetarget(var_7, var_4)) {
          continue;
        }
        if(!isDefined(self.waittill_objective_start) || var_7 != self.waittill_objective_start)
          self.waittill_objective_start = undefined;

        var_5 = var_7;
        break;
      }

      if(!isDefined(var_5)) {
        wait 0.5;
        self.mgturret cleartargetentity();

        if(var_1) {
          self.mgturret laseroff();
          var_1 = 0;
        }

        self.waittill_objective_start = undefined;
        continue;
      } else {
        if(!var_1) {
          self.mgturret laseron();
          thread flicker_tank_lights();
          var_1 = 1;
        }

        var_4 = questtimerupdate(var_5);
        self.mgturret settargetentity(var_5, var_4);
        self.mgturret scripts\engine\utility::_id_143B9(5, "_encstr_97881123FB639E8883C74F55DF6B6066CF12BB");

        if(!var_5 scripts\cp\utility::is_valid_player() || !tank_canseetarget(var_5, var_4)) {
          wait 0.5;

          if(var_1) {
            self.mgturret laseroff();
            var_1 = 0;
          }

          self.waittill_objective_start = undefined;
          continue;
        }

        if(var_5 scripts\cp\utility::is_valid_player()) {
          if(!isDefined(self.waittill_objective_start)) {
            self.waittill_objective_start = var_5;
            var_5 playlocalsound("_encstr_B271115EA9F0E94B4DBBA31FB7FF635660D0D7");
          }
        }

        wait(var_2);
        var_4 = questtimerupdate(var_5);

        if(!var_5 scripts\cp\utility::is_valid_player() || !tank_canseetarget(var_5, var_4) || distancesquared(self.mgturret.origin, var_5.origin) > self.max_detection_sq) {
          if(var_1) {
            self.mgturret laseroff();
            var_1 = 0;
          }

          continue;
        }

        if(isDefined(self.config._id_13E8C))
          [[self.config._id_13E8C]](var_5);
        else
          self.mgturret shootturret();

        thread notify_nearby_enemies();
        var_5 thread damage_nearby_dynolights();
        wait(var_3);
      }

      wait 0.5;
    }

    wait 0.1;
  }
}

notify_nearby_enemies() {
  level notify("_encstr_B13A0E93E30AE9A837B27B909BE4B095", self);
  var_0 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");
  var_1 = 1000;

  if(isDefined(self.enemy_notify_range))
    var_1 = self.enemy_notify_range;

  var_2 = scripts\engine\utility::get_array_of_closest(self.origin, var_0, undefined, undefined, var_1);

  foreach(var_4 in var_2)
  var_4 notify("_encstr_A5490D5E05C3F8B363F3C8D83B3E43");
}

questtimerupdate(var_0) {
  var_1 = (0, 0, 50);

  if(isPlayer(var_0)) {
    var_2 = var_0 getstance();

    switch (var_2) {
      case "_encstr_B13D076BED70539F23":
        var_1 = (0, 0, 25);
        break;
      case "_encstr_922406F1A6FD5E05":
        var_1 = (0, 0, 0);
        break;
      default:
        var_1 = (0, 0, 50);
        break;
    }
  }

  return var_1;
}

damage_nearby_dynolights() {
  if(!scripts\cp\utility::is_valid_player()) {
    return;
  }
  var_0 = getEntArray("_encstr_96AC1AF633334B8DB2F5B14B9D0D3ABE23566ED139D5C6D12D26C6B2", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_1 = scripts\engine\utility::get_array_of_closest(self.origin, var_0, undefined, 2, 350);

  if(var_1.size == 0) {
    return;
  }
  foreach(var_3 in var_1)
  var_3 notify("_encstr_B2BE0788BAF573592F", 1000);
}

flicker_tank_lights() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = "_encstr_AB0703DBB9";

  if(isDefined(self.config._id_13E88))
    var_0 = self.config._id_13E88;

  self.mgturret setscriptablepartstate("_encstr_938A07DDE8F8A8FB0E", "_encstr_BA19049F4B2D");
  wait 0.5;
  self.mgturret setscriptablepartstate("_encstr_938A07DDE8F8A8FB0E", var_0);
}