/*****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_gas_airstrike.gsc
*****************************************************/

init() {
  var_00 = spawnStruct();
  var_00.var_B923 = [];
  var_00.var_B923["allies"] = "vehicle_mig29_desert";
  var_00.var_B923["axis"] = "vehicle_mig29_desert";
  var_00.inboundsfx = "veh_mig29_dist_loop";
  var_00.compassiconfriendly = "compass_objpoint_airstrike_friendly";
  var_00.compassiconenemy = "compass_objpoint_airstrike_busy";
  var_00.getclosestpointonnavmesh3d = 5000;
  var_00.halfdistance = 15000;
  var_00.heightrange = 500;
  var_00.outboundflightanim = "airstrike_mp_roll";
  var_00.onattackdelegate = ::dropbombs;
  var_00.onflybycompletedelegate = ::cleanupgamemodes;
  var_00.choosedirection = 1;
  var_00.selectlocationvo = "KS_hqr_airstrike";
  var_00.inboundvo = "KS_ast_inbound";
  var_00.var_2C5A = "projectile_cbu97_clusterbomb";
  var_00.var_C21A = 3;
  var_00.var_5703 = 350;
  var_00.var_5FEF = 200;
  var_00.var_5FEA = 120;
  var_00.var_5FF4 = loadfx("vfx\core\smktrail\poisonous_gas_linger_medium_thick_killer_instant");
  var_00.var_5FEE = 0.25;
  var_00.var_5FED = 0.5;
  var_00.var_5FEC = 13;
  var_00.var_5FE7 = 1;
  var_00.var_5FE8 = 10;
  var_00.var_C263 = "gas_strike_mp";
  var_00.killcamoffset = (0, 0, 60);
  level.planeconfigs["gas_airstrike"] = var_00;
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("gas_airstrike", ::onuse);
}

onuse(param_00, param_01) {
  var_02 = scripts\mp\utility::getotherteam(self.team);
  if(isDefined(level.var_C22F)) {
    self iprintlnbold( & "KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  var_03 = scripts\mp\killstreaks\_plane::selectairstrikelocation(param_00, "gas_airstrike", ::dostrike);
  return isDefined(var_03) && var_03;
}

dostrike(param_00, param_01, param_02, param_03) {
  level.var_C22F = 0;
  wait(1);
  var_04 = scripts\mp\killstreaks\_plane::_meth_806A();
  var_05 = anglesToForward((0, param_02, 0));
  dooneflyby(param_03, param_00, param_01, var_05, var_04);
  self waittill("gas_airstrike_flyby_complete");
}

dooneflyby(param_00, param_01, param_02, param_03, param_04) {
  var_05 = level.planeconfigs[param_00];
  var_06 = scripts\mp\killstreaks\_plane::getflightpath(param_02, param_03, var_05.halfdistance, 1, param_04, var_05.getclosestpointonnavmesh3d, 0, param_00);
  level thread scripts\mp\killstreaks\_plane::doflyby(param_01, self, param_01, var_06["startPoint"] + (0, 0, randomint(var_05.heightrange)), var_06["endPoint"] + (0, 0, randomint(var_05.heightrange)), var_06["attackTime"], var_06["flyTime"], param_03, param_00);
}

cleanupgamemodes(param_00, param_01, param_02) {
  param_00 notify("gas_airstrike_flyby_complete");
}

dropbombs(param_00, param_01, param_02, param_03, param_04) {
  self endon("death");
  wait(param_02);
  var_05 = level.planeconfigs[param_04];
  var_06 = var_05.var_C21A;
  var_07 = var_05.var_5703 / var_05.getclosestpointonnavmesh3d;
  while(var_06 > 0) {
    thread func_5D35(param_03, param_04);
    var_06--;
    wait(var_07);
  }
}

func_5D35(param_00, param_01) {
  level.var_C22F++;
  var_02 = self;
  var_03 = level.planeconfigs[param_01];
  var_04 = anglesToForward(var_02.angles);
  var_05 = spawnbomb(var_03.var_2C5A, var_02.origin, var_02.angles);
  var_05 movegravity(var_04 * var_03.getclosestpointonnavmesh3d / 1.5, 3);
  var_06 = spawn("script_model", var_05.origin);
  var_06 setModel("tag_origin");
  var_06.origin = var_05.origin;
  var_06.angles = var_05.angles;
  var_05 setModel("tag_origin");
  wait(0.1);
  var_07 = var_06.origin;
  var_08 = var_06.angles;
  if(level.splitscreen) {
    playFXOnTag(level.airstrikessfx, var_06, "tag_origin");
  } else {
    playFXOnTag(level.airstrikefx, var_06, "tag_origin");
  }

  wait(1);
  var_09 = bulletTrace(var_06.origin, var_06.origin + (0, 0, -1000000), 0, undefined);
  var_0A = var_09["position"];
  var_05 func_C4CD(param_00, var_0A, param_01);
  var_06 delete();
  var_05 delete();
  level.var_C22F--;
  if(level.var_C22F == 0) {
    level.var_C22F = undefined;
  }
}

spawnbomb(param_00, param_01, param_02) {
  var_03 = spawn("script_model", param_01);
  var_03.angles = param_02;
  var_03 setModel(param_00);
  return var_03;
}

func_C4CD(param_00, param_01, param_02) {
  var_03 = level.planeconfigs[param_02];
  var_04 = spawn("trigger_radius", param_01, 0, var_03.var_5FEF, var_03.var_5FEA);
  var_04.triggerportableradarping = param_00;
  var_05 = var_03.var_5FEF;
  var_06 = spawnfx(var_03.var_5FF4, param_01);
  triggerfx(var_06);
  wait(randomfloatrange(var_03.var_5FEE, var_03.var_5FED));
  var_07 = var_03.var_5FEC;
  var_08 = spawn("script_model", param_01 + var_03.killcamoffset);
  var_08 linkto(var_04);
  self.killcament = var_08;
  while(var_07 > 0) {
    foreach(var_0A in level.characters) {
      var_0A applygaseffect(param_00, param_01, var_04, self, var_03.var_5FE8);
    }

    wait(var_03.var_5FE7);
    var_07 = var_07 - var_03.var_5FE7;
  }

  self.killcament delete();
  var_04 delete();
  var_06 delete();
}

applygaseffect(param_00, param_01, param_02, param_03, param_04) {
  if(param_00 scripts\mp\utility::isenemy(self) && isalive(self) && self istouching(param_02)) {
    param_03 radiusdamage(self.origin, 1, param_04, param_04, param_00, "MOD_RIFLE_BULLET", "gas_strike_mp");
    if(!scripts\mp\utility::isusingremote()) {
      var_05 = scripts\mp\perks\_perkfunctions::applystunresistence(param_00, self, 2);
      self shellshock("default", var_05);
    }
  }
}