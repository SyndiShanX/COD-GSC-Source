/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_146d12c281f80426.gsc
*************************************************/

#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\weapon;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\warrior;
#using scripts\mp\utility\game;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\teams;
#namespace warrior_metagame;

function function_84ff73203e4fc8a4() {
  thread onplayerspawned();
  thread function_492b4dec632917ec("warrior_metagame");
}

function onplayerspawned() {
  level endon("game_ended");
  level endon("round_end_finished");

  while(true) {
    level waittill("player_spawned", player);
    player takeallweapons();
    player function_d513817a1e585d0f("jup_p10_sm_victor_ever_warrior");
  }
}

function function_d513817a1e585d0f(blueprintname) {
  variantid = 0;
  weapon = getweaponrootname(blueprintname);
  weaponasset = undefined;

  if(isDefined(level.weaponmapdata[weapon])) {
    weaponasset = level.weaponmapdata[weapon].assetname;
  }

  weaponblueprint = getxhashasset(blueprintname);

  if(isDefined(weaponasset)) {
    weaponvariants = getweaponblueprintnames(weaponasset);

    foreach(variant, id in weaponvariants) {
      if(weaponblueprint == variant) {
        variantid = id;
        var_c88b10f789adf8eb = scripts\cp_mp\weapon::buildweapon_blueprint(weapon, undefined, undefined, variantid, undefined, undefined);
        var_c88b10f789adf8eb = var_c88b10f789adf8eb function_7e483d6e6b4b5688(id);
        self giveweapon(var_c88b10f789adf8eb);
        self setweaponammoclip(var_c88b10f789adf8eb, weaponclipsize(var_c88b10f789adf8eb));
        self setweaponammostock(var_c88b10f789adf8eb, weaponmaxammo(var_c88b10f789adf8eb));
        scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_c88b10f789adf8eb);
        scripts\cp_mp\weapon::fixupplayerweapons(self, weapon);
        self setspawnweapon(var_c88b10f789adf8eb);
      }
    }
  }
}