/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_22b5518d4dea99e0.gsc
*************************************************/

#using script_3ed005fe9b78b9da;
#using scripts\engine\utility;
#using scripts\mp\hud_util;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\weapon;
#namespace namespace_f093628c456dc33;

function function_453d52eb553e1047() {
  var_9e373019b587e34 = getdvarfloat(@ "hash_341483558fb0f08f", 20);
  addpowerbutton(self, "shout", "+frag", &function_7f013d8a91788fdf, 0, undefined, &playerzombiecleanup, undefined, &"MP_ZXP/SHOUT", undefined, var_9e373019b587e34, "shoutStatus", "shoutProgress");
}

function function_7f013d8a91788fdf(powerstruct, powerref) {
  zombie = self;

  if(!isDefined(zombie)) {
    return;
  }

  zombie.var_3f4318a44cfc517f = undefined;

  if(!zombie function_72e633a2cadc2f8f()) {
    zombie function_e63114420500fb();
    zombie function_ae8ecf6e5f68f1ea(zombie.var_3f4318a44cfc517f);
    zombie thread function_f2ddb7c78178c1be(powerstruct, powerref);
    return;
  }

  if(zombie scripts\mp\utility\weapon::grenadeinpullback()) {
    zombie function_187fb04ebd01baea();
  }

  zombie thread function_120695737abd78f4(powerstruct, powerref);
  zombie thread function_502603b3a9bddbc4(powerstruct, powerref);
  zombie thread function_2726f662b9cd30a8();
}

function function_72e633a2cadc2f8f() {
  zombie = self;

  if(!isDefined(zombie) || !zombie ismutationgamemodezombie() && !function_7586e7f1e96dc16d()) {
    return false;
  }

  if(zombie isswimunderwater()) {
    zombie.var_3f4318a44cfc517f = "MP_BR_INGAME/ZMB_SHOUT_ERROR_UNDERWATER";
    return false;
  }

  if(zombie isonladder()) {
    zombie.var_3f4318a44cfc517f = "MP_BR_INGAME/ZMB_SHOUT_ERROR_LADDER";
    return false;
  }

  return true;
}

function function_502603b3a9bddbc4(powerstruct, powerref) {
  zombie = self;

  if(!isDefined(zombie) || !isPlayer(zombie)) {
    return;
  }

  zombie endon("death");
  zombie endon("disconnect");
  zombie endon("zombie_unset");
  level endon("game_ended");
  zombie.var_a2906c0a3da2c192 = 1;

  if(isDefined(powerstruct.powers[powerref].statusupdate)) {
    function_936f0ef6e203a7fc(powerstruct.powers[powerref].statusupdate, 4);
  }

  if(!isbot(zombie)) {
    zombie forceplaygestureviewmodel("ges_zombie_shout");
  }

  playFXOnTag(level._effect["zombie_shout"], zombie, "j_head");
  playFXOnTag(level._effect["zombie_shout_shockwaves"], zombie, "tag_origin");
  self setscriptablepartstate("zombieRageVfx", "fx_start", 0);
  otherteam = scripts\mp\utility\game::getotherteam(self.pers["team"])[0];

  foreach(player in level.teamdata[otherteam]["alivePlayers"]) {
    player hudoutlineenableforclient(zombie, "outline_depth_zombievision_enemy");
  }

  var_7912c8225d6a3c35 = getdvarfloat(@ "hash_61b61f0247cb96ea", 5);
  wait var_7912c8225d6a3c35;
  zombie playerzombiecleanup(powerstruct, powerref, 1);
  zombie stopgestureviewmodel("ges_zombie_shout");
  zombie setscriptablepartstate("zombieRageVfx", "fx_end", 0);

  if(isDefined(powerstruct.powers[powerref].statusupdate)) {
    function_936f0ef6e203a7fc(powerstruct.powers[powerref].statusupdate, 1);
  }

  zombie notify("zombie_shout_finished");
}

function playerzombiecleanup(powerstruct, powerref, docooldown) {
  otherteam = scripts\mp\utility\game::getotherteam(self.pers["team"])[0];

  foreach(player in level.teamdata[otherteam]["players"]) {
    player hudoutlinedisableforclient(self);
  }
}

function function_74b142ac51e57492() {
  zombie = self;
  zombie endon("death");
  zombie endon("disconnect");
  zombie endon("zombie_unset");
  zombie endon("zombie_shout_finished");
  level endon("game_ended");

  if(!isDefined(zombie) || !zombie ismutationgamemodezombie()) {
    return;
  }

  zombie function_9354c4c50c43abc0(level.var_ec4da42b3bbf344c.var_2d23e5b9abed638c);

  while(true) {
    zombie.movespeedscaler = zombie function_9af8aa334971aeb0();

    if(isDefined(zombie.movespeedscaler) && zombie.movespeedscaler > 0) {
      zombie setmovespeedscale(zombie.movespeedscaler);
    }

    waitframe();
  }
}

function function_9af8aa334971aeb0() {
  zombie = self;

  if(!isDefined(zombie) || !zombie ismutationgamemodezombie()) {
    return undefined;
  }

  if(zombie isswimming()) {
    return undefined;
  }

  if(zombie issprintsliding()) {
    return level.var_ec4da42b3bbf344c.var_6225ce8e059e5ce5;
  }

  return level.var_ec4da42b3bbf344c.var_695b3601560f5703;
}

function function_c6519d37adedcb4f(time) {
  if(isDefined(time)) {
    wait time;
  }

  self enableplayerbreathsystem(1);
}

function function_120695737abd78f4(powerstruct, powerref) {
  if(level.var_ec4da42b3bbf344c.hudserver) {
    self.powershud[powerref].barelem updatebar(1, 0);
  } else {
    self.powershud[powerref].frac = 1;
  }

  thread playerpowerstartcooldown(powerstruct, powerref);
}

function function_cd06c81e9adcbee9(powerstruct, powerref) {
  self notify("playerZombieGasOrShout");
}

function function_2726f662b9cd30a8() {
  zombie = self;
  zombie endon("zombie_shout_finished");
  waittill_any_ents(zombie, "death", zombie, "disconnect", level, "game_ended", zombie, "zombie_unset");

  if(!isDefined(zombie)) {
    return;
  }

  if(istrue(zombie.var_a2906c0a3da2c192)) {
    stopFXOnTag(level._effect["zombie_shout"], zombie, "j_head");
    stopFXOnTag(level._effect["zombie_shout_shockwaves"], zombie, "tag_origin");

    if(zombie isgestureplaying("ges_zombie_shout")) {
      zombie stopgestureviewmodel("ges_zombie_shout");
    }
  }

  if(istrue(zombie.buffed)) {
    zombie setscriptablepartstate("zombieBuffVfx", "off", 0);
    zombie setscriptablepartstate("zombieRageVfx", "off", 0);
    zombie.movespeedscaler = 1;
    zombie setmovespeedscale(zombie.movespeedscaler);
  }

  zombie.var_a2906c0a3da2c192 = 0;
  zombie.buffed = 0;
}