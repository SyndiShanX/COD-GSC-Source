/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3e407bc1a2cb914a.gsc
*************************************************/

#using script_22b5518d4dea99e0;
#using script_3ed005fe9b78b9da;
#using scripts\engine\utility;
#using scripts\mp\hud_util;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\weapon;
#namespace namespace_bebd6cb802693d5;

function function_efcef5f4202ca985() {
  var_91453439419c79cd = getdvarfloat(@ "hash_39d77d3dc4a00ecc", 30);
  addpowerbutton(self, "shout", "+frag", &function_5c2396a10a0c5296, 0, undefined, undefined, undefined, &"MP_ZXP/SHOUT", undefined, var_91453439419c79cd, "shoutStatus", "shoutProgress");
}

function function_5c2396a10a0c5296(powerstruct, powerref) {
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
  zombie thread function_747fdce9aa07ad2b(powerstruct, powerref);
  zombie thread function_2726f662b9cd30a8();
}

function function_747fdce9aa07ad2b(powerstruct, powerref) {
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

  self setscriptablepartstate("mutant_cloak", "cloak_on");
  wait 10;
  self setscriptablepartstate("mutant_cloak", "off");
  zombie.var_a2906c0a3da2c192 = 0;
  zombie notify("zombie_shouting_finished");
  zombie.buffed = 1;
  zombie thread function_74b142ac51e57492();
  self setscriptablepartstate("zombieBuffVfx", "on", 0);
  wait level.var_ec4da42b3bbf344c.var_5a945be17bf844bd;
  self setscriptablepartstate("zombieBuffVfx", "off", 0);
  self setscriptablepartstate("zombieRageVfx", "fx_end", 0);

  if(isDefined(powerstruct.powers[powerref].statusupdate)) {
    function_936f0ef6e203a7fc(powerstruct.powers[powerref].statusupdate, 1);
  }

  zombie.movespeedscaler = 1;
  zombie setmovespeedscale(zombie.movespeedscaler);
  zombie function_9354c4c50c43abc0(zombie.movespeedscaler);
  zombie.buffed = 0;
  zombie notify("zombie_shout_finished");
}