/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3485.gsc
***************************************/

init() {
  var_0 = spawnStruct();
  var_0.var_B923 = [];
  var_0.var_B923["allies"] = "vehicle_mig29_desert";
  var_0.var_B923["axis"] = "vehicle_mig29_desert";
  var_0.inboundsfx = "veh_mig29_dist_loop";
  var_0.compassiconfriendly = "compass_objpoint_airstrike_friendly";
  var_0.compassiconenemy = "compass_objpoint_airstrike_busy";
  var_0.speed = 5000;
  var_0.halfdistance = 15000;
  var_0.heightrange = 500;
  var_0.outboundflightanim = "airstrike_mp_roll";
  var_0.onattackdelegate = ::dropbombs;
  var_0.onflybycompletedelegate = ::cleanupgamemodes;
  var_0.choosedirection = 1;
  var_0.selectlocationvo = "KS_hqr_airstrike";
  var_0.inboundvo = "KS_ast_inbound";
  var_0.var_2C5A = "projectile_cbu97_clusterbomb";
  var_0.var_C21A = 3;
  var_0.var_5703 = 350;
  var_0.var_5FEF = 200;
  var_0.var_5FEA = 120;
  var_0.var_5FF4 = loadfx("vfx\core\smktrail\poisonous_gas_linger_medium_thick_killer_instant");
  var_0.var_5FEE = 0.25;
  var_0.var_5FED = 0.5;
  var_0.var_5FEC = 13;
  var_0.var_5FE7 = 1.0;
  var_0.var_5FE8 = 10;
  var_0.var_C263 = "gas_strike_mp";
  var_0.killcamoffset = (0, 0, 60);
  level.planeconfigs["gas_airstrike"] = var_0;
  scripts\mp\killstreaks\killstreaks::registerkillstreak("gas_airstrike", ::onuse);
}

onuse(var_0, var_1) {
  var_2 = scripts\mp\utility\game::getotherteam(self.team);

  if(isDefined(level.var_C22F)) {
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  } else {
    var_3 = scripts\mp\killstreaks\plane::selectairstrikelocation(var_0, "gas_airstrike", ::dostrike);
    return isDefined(var_3) && var_3;
  }
}

dostrike(var_0, var_1, var_2, var_3) {
  level.var_C22F = 0;
  wait 1;
  var_4 = scripts\mp\killstreaks\plane::_meth_806A();
  var_5 = anglesToForward((0, var_2, 0));
  dooneflyby(var_3, var_0, var_1, var_5, var_4);
  self waittill("gas_airstrike_flyby_complete");
}

dooneflyby(var_0, var_1, var_2, var_3, var_4) {
  var_5 = level.planeconfigs[var_0];
  var_6 = scripts\mp\killstreaks\plane::getflightpath(var_2, var_3, var_5.halfdistance, 1, var_4, var_5.speed, 0, var_0);
  level thread scripts\mp\killstreaks\plane::doflyby(var_1, self, var_1, var_6["startPoint"] + (0, 0, randomint(var_5.heightrange)), var_6["endPoint"] + (0, 0, randomint(var_5.heightrange)), var_6["attackTime"], var_6["flyTime"], var_3, var_0);
}

cleanupgamemodes(var_0, var_1, var_2) {
  var_0 notify("gas_airstrike_flyby_complete");
}

dropbombs(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  wait(var_2);
  var_5 = level.planeconfigs[var_4];
  var_6 = var_5.var_C21A;
  var_7 = var_5.var_5703 / var_5.speed;

  while(var_6 > 0) {
    thread func_5D35(var_3, var_4);
    var_6--;
    wait(var_7);
  }
}

func_5D35(var_0, var_1) {
  level.var_C22F++;
  var_2 = self;
  var_3 = level.planeconfigs[var_1];
  var_4 = anglesToForward(var_2.angles);
  var_5 = spawnbomb(var_3.var_2C5A, var_2.origin, var_2.angles);
  var_5 movegravity(var_4 * (var_3.speed / 1.5), 3.0);
  var_6 = spawn("script_model", var_5.origin);
  var_6 setModel("tag_origin");
  var_6.origin = var_5.origin;
  var_6.angles = var_5.angles;
  var_5 setModel("tag_origin");
  wait 0.1;
  var_7 = var_6.origin;
  var_8 = var_6.angles;

  if(level.splitscreen) {
    playFXOnTag(level.airstrikessfx, var_6, "tag_origin");
  } else {
    playFXOnTag(level.airstrikefx, var_6, "tag_origin");
  }

  wait 1.0;
  var_9 = bulletTrace(var_6.origin, var_6.origin + (0, 0, -1000000.0), 0, undefined);
  var_10 = var_9["position"];
  var_5 func_C4CD(var_0, var_10, var_1);
  var_6 delete();
  var_5 delete();
  level.var_C22F--;

  if(level.var_C22F == 0) {
    level.var_C22F = undefined;
  }
}

spawnbomb(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_1);
  var_3.angles = var_2;
  var_3 setModel(var_0);
  return var_3;
}

func_C4CD(var_0, var_1, var_2) {
  var_3 = level.planeconfigs[var_2];
  var_4 = spawn("trigger_radius", var_1, 0, var_3.var_5FEF, var_3.var_5FEA);
  var_4.owner = var_0;
  var_5 = var_3.var_5FEF;
  var_6 = spawnfx(var_3.var_5FF4, var_1);
  triggerfx(var_6);
  wait(randomfloatrange(var_3.var_5FEE, var_3.var_5FED));
  var_7 = var_3.var_5FEC;
  var_8 = spawn("script_model", var_1 + var_3.killcamoffset);
  var_8 linkto(var_4);

  for(self.killcament = var_8; var_7 > 0.0; var_7 = var_7 - var_3.var_5FE7) {
    foreach(var_10 in level.characters) {
      var_10 applygaseffect(var_0, var_1, var_4, self, var_3.var_5FE8);
    }

    wait(var_3.var_5FE7);
  }

  self.killcament delete();
  var_4 delete();
  var_6 delete();
}

applygaseffect(var_0, var_1, var_2, var_3, var_4) {
  if(var_0 scripts\mp\utility\game::isenemy(self) && isalive(self) && self istouching(var_2)) {
    var_3 radiusdamage(self.origin, 1, var_4, var_4, var_0, "MOD_RIFLE_BULLET", "gas_strike_mp");

    if(!scripts\mp\utility\game::isusingremote()) {
      var_5 = scripts\mp\perks\perkfunctions::applystunresistence(var_0, self, 2.0);
      self shellshock("default", var_5);
    }
  }
}