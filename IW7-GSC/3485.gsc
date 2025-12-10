/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3485.gsc
***************************************/

init() {
  var_00 = spawnStruct();
  var_0.func_B923 = [];
  var_0.func_B923["allies"] = "vehicle_mig29_desert";
  var_0.func_B923["axis"] = "vehicle_mig29_desert";
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
  var_0.func_2C5A = "projectile_cbu97_clusterbomb";
  var_0.func_C21A = 3;
  var_0.func_5703 = 350;
  var_0.func_5FEF = 200;
  var_0.func_5FEA = 120;
  var_0.func_5FF4 = loadfx("vfx\core\smktrail\poisonous_gas_linger_medium_thick_killer_instant");
  var_0.func_5FEE = 0.25;
  var_0.func_5FED = 0.5;
  var_0.func_5FEC = 13;
  var_0.func_5FE7 = 1.0;
  var_0.func_5FE8 = 10;
  var_0.func_C263 = "gas_strike_mp";
  var_0.killcamoffset = (0, 0, 60);
  level.planeconfigs["gas_airstrike"] = var_00;
  scripts\mp\killstreaks\killstreaks::registerkillstreak("gas_airstrike", ::onuse);
}

onuse(var_00, var_01) {
  var_02 = scripts\mp\utility\game::getotherteam(self.team);

  if(isDefined(level.func_C22F)) {
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  } else {
    var_03 = scripts\mp\killstreaks\plane::selectairstrikelocation(var_00, "gas_airstrike", ::dostrike);
    return isDefined(var_03) && var_03;
  }
}

dostrike(var_00, var_01, var_02, var_03) {
  level.func_C22F = 0;
  wait 1;
  var_04 = scripts\mp\killstreaks\plane::_meth_806A();
  var_05 = anglesToForward((0, var_02, 0));
  dooneflyby(var_03, var_00, var_01, var_05, var_04);
  self waittill("gas_airstrike_flyby_complete");
}

dooneflyby(var_00, var_01, var_02, var_03, var_04) {
  var_05 = level.planeconfigs[var_00];
  var_06 = scripts\mp\killstreaks\plane::getflightpath(var_02, var_03, var_5.halfdistance, 1, var_04, var_5.speed, 0, var_00);
  level thread scripts\mp\killstreaks\plane::doflyby(var_01, self, var_01, var_6["startPoint"] + (0, 0, randomint(var_5.heightrange)), var_6["endPoint"] + (0, 0, randomint(var_5.heightrange)), var_6["attackTime"], var_6["flyTime"], var_03, var_00);
}

cleanupgamemodes(var_00, var_01, var_02) {
  var_00 notify("gas_airstrike_flyby_complete");
}

dropbombs(var_00, var_01, var_02, var_03, var_04) {
  self endon("death");
  wait(var_02);
  var_05 = level.planeconfigs[var_04];
  var_06 = var_5.func_C21A;
  var_07 = var_5.func_5703 / var_5.speed;

  while(var_06 > 0) {
    thread func_5D35(var_03, var_04);
    var_6--;
    wait(var_07);
  }
}

func_5D35(var_00, var_01) {
  level.func_C22F++;
  var_02 = self;
  var_03 = level.planeconfigs[var_01];
  var_04 = anglesToForward(var_2.angles);
  var_05 = spawnbomb(var_3.func_2C5A, var_2.origin, var_2.angles);
  var_05 movegravity(var_04 * (var_3.speed / 1.5), 3.0);
  var_06 = spawn("script_model", var_5.origin);
  var_06 setModel("tag_origin");
  var_6.origin = var_5.origin;
  var_6.angles = var_5.angles;
  var_05 setModel("tag_origin");
  wait 0.1;
  var_07 = var_6.origin;
  var_08 = var_6.angles;

  if(level.splitscreen)
    playFXOnTag(level.airstrikessfx, var_06, "tag_origin");
  else
    playFXOnTag(level.airstrikefx, var_06, "tag_origin");

  wait 1.0;
  var_09 = bulletTrace(var_6.origin, var_6.origin + (0, 0, -1000000.0), 0, undefined);
  var_10 = var_9["position"];
  var_05 func_C4CD(var_00, var_10, var_01);
  var_06 delete();
  var_05 delete();
  level.func_C22F--;

  if(level.func_C22F == 0)
    level.func_C22F = undefined;
}

spawnbomb(var_00, var_01, var_02) {
  var_03 = spawn("script_model", var_01);
  var_3.angles = var_02;
  var_03 setModel(var_00);
  return var_03;
}

func_C4CD(var_00, var_01, var_02) {
  var_03 = level.planeconfigs[var_02];
  var_04 = spawn("trigger_radius", var_01, 0, var_3.func_5FEF, var_3.func_5FEA);
  var_4.owner = var_00;
  var_05 = var_3.func_5FEF;
  var_06 = spawnfx(var_3.func_5FF4, var_01);
  triggerfx(var_06);
  wait(randomfloatrange(var_3.func_5FEE, var_3.func_5FED));
  var_07 = var_3.func_5FEC;
  var_08 = spawn("script_model", var_01 + var_3.killcamoffset);
  var_08 linkto(var_04);

  for(self.killcament = var_08; var_07 > 0.0; var_07 = var_07 - var_3.func_5FE7) {
    foreach(var_10 in level.characters)
    var_10 applygaseffect(var_00, var_01, var_04, self, var_3.func_5FE8);

    wait(var_3.func_5FE7);
  }

  self.killcament delete();
  var_04 delete();
  var_06 delete();
}

applygaseffect(var_00, var_01, var_02, var_03, var_04) {
  if(var_00 scripts\mp\utility\game::isenemy(self) && isalive(self) && self istouching(var_02)) {
    var_03 radiusdamage(self.origin, 1, var_04, var_04, var_00, "MOD_RIFLE_BULLET", "gas_strike_mp");

    if(!scripts\mp\utility\game::isusingremote()) {
      var_05 = scripts\mp\perks\perkfunctions::applystunresistence(var_00, self, 2.0);
      self shellshock("default", var_05);
    }
  }
}