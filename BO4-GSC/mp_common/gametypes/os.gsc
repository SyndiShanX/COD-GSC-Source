/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\os.gsc
***********************************************/

#include scripts\core_common\gameobjects_shared;
#include scripts\mp_common\player\player_loadout;

#namespace os;

turn_back_time(basegametype) {
  gameobjects::register_allowed_gameobject("os");
  gameobjects::register_allowed_gameobject(basegametype);
  level.oldschoolweapon = getweapon("pistol_standard");
  level.primaryoffhandnull = getweapon(#"null_offhand_primary");
  level.secondaryoffhandnull = getweapon(#"null_offhand_secondary");
  level.givecustomloadout = &give_oldschool_loadout;
}

give_oldschool_loadout() {
  self loadout::init_player(1);
  self loadout::function_f436358b("CLASS_ASSAULT");
  self giveweapon(level.oldschoolweapon);
  self switchtoweapon(level.oldschoolweapon);
  self giveweapon(level.primaryoffhandnull);
  self giveweapon(level.secondaryoffhandnull);
  self setweaponammoclip(level.primaryoffhandnull, 0);
  self setweaponammoclip(level.secondaryoffhandnull, 0);

  if(self.firstspawn !== 0) {
    self setspawnweapon(level.oldschoolweapon);
  }

  return level.oldschoolweapon;
}