/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_bcf73325fb07789.gsc
************************************************/

#using script_33b83540dd41c31e;
#using script_3ed005fe9b78b9da;
#using scripts\common\values;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\engine\utility;
#using scripts\mp\equipment;
#using scripts\mp\hud_util;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#namespace namespace_82a062af69d3ecd6;

function function_2b4e536e2b50c34d() {
  var_da7c69ee550ab7b8 = &namespace_e5b8d54a860243e8::function_3287e064cd7027f;
  var_85e4766d1a697392 = &function_a046fe4ee22f6664;
  var_ade21e7520b57247 = &namespace_e5b8d54a860243e8::function_95863013475ad0e9;
  cooldowntime = getdvarfloat(@ "hash_859e9c7c3ac9260c", 12);
  addpowerbutton(self, "gas", "+smoke", var_da7c69ee550ab7b8, 0, var_85e4766d1a697392, var_ade21e7520b57247, var_85e4766d1a697392, &"MP_ZXP/GAS_GRENADE", undefined, cooldowntime, "gasGrenadeStatus", "gasGrenadeProgress");
  self.powers["gas"].var_ad6e547ed6ed5a8c = &function_71135b545ab121c;
  self.powers["gas"].istactical = 1;

  level thread function_29eb33d34673b609();
}

function function_a046fe4ee22f6664(powerstruct, powerref) {
  grenade = "equip_mutant_ability_5";
  scripts\mp\equipment::giveequipment(grenade, "secondary");
  scripts\mp\equipment::setequipmentslotammo("secondary", 1);
}

function function_71135b545ab121c(powerstruct, powerref) {
  otherteam = scripts\mp\utility\game::getotherteam(self.pers["team"])[0];

  foreach(player in level.teamdata[otherteam]["alivePlayers"]) {
    if(distance(player.origin, self.origin) > 700) {
      continue;
    }

    player thread scripts\cp_mp\utility\shellshock_utility::_shellshock("frag_grenade_mp", "explosion", 4);
  }

  myteam = self.pers["team"];

  foreach(player in level.teamdata[myteam]["alivePlayers"]) {
    if(is_equal(player, self)) {
      continue;
    }

    if(distance(player.origin, self.origin) > 700) {
      continue;
    }

    playFXOnTag(level._effect["zombie_shout"], player, "j_head");
    playFXOnTag(level._effect["zombie_shout_shockwaves"], player, "tag_origin");
    player notify("force_regeneration");
    self.maxhealth = 325;
    self.health = 325;
  }

  sphere(self.origin, 700, (1, 1, 1), 1, 300);

  self playsoundonmovingent("ai_radioactive_beast_howl_activate");
  thread function_93b112da59dc77a7();
  thread function_d9aa75397a185cdf();
}

function function_d9aa75397a185cdf() {
  self endon("death_or_disconnect");
  val::set("dogAbilityActivate", "sprint", 0);
  wait 3;
  val::set("dogAbilityActivate", "sprint", 1);
}

function function_93b112da59dc77a7() {
  playFXOnTag(level._effect["vfx_jup_mut_beast_roar_aoe"], self, "tag_origin");
}

function function_29eb33d34673b609() {
  while(true) {
    if(!getdvarint(@ "hash_ece73b4b43634539", 0)) {
      waitframe();
      continue;
    }

    level.player thread scripts\cp_mp\utility\shellshock_utility::_shellshock("<dev string:x1c>", "<dev string:x2f>", 4);
    level.player setblurforplayer(1, 1);
    wait 1;
    level.player setblurforplayer(0, 1);
    setDvar(@ "hash_ece73b4b43634539", 0);
  }
}

# /