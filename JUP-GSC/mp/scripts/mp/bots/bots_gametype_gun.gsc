/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\bots\bots_gametype_gun.gsc
****************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_util;
#using scripts\mp\gamelogic;
#using scripts\mp\utility\weapon;
#namespace bots_gametype_gun;

function main() {
  setup_callbacks();
  setup_bot_gun();
}

function function_e45e46b7c35deadb() {}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &bot_gun_think;
}

function setup_bot_gun() {
  level.bots_gametype_handles_class_choice = 1;
}

function bot_gun_pick_personality_from_weapon(weaponname, preferred_personality) {
  if(isDefined(weaponname) && weaponname != "none") {
    var_6f94db6d48b3fd6d = scripts\cp_mp\weapon::function_309bcc0c19de2d18(weaponname);

    if(isDefined(var_6f94db6d48b3fd6d) && var_6f94db6d48b3fd6d.size > 0) {
      choice = undefined;

      if(array_contains(var_6f94db6d48b3fd6d, preferred_personality)) {
        choice = preferred_personality;
      } else {
        choice = random(var_6f94db6d48b3fd6d);
      }

      if(self.personality != choice) {
        scripts\mp\bots\bots_util::bot_set_personality(choice);
      }
    }
  }
}

function bot_gun_think() {
  self notify("bot_gun_think");
  self endon("bot_gun_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  throwknifechance = self botgetdifficultysetting("throwKnifeChance");

  if(throwknifechance < 0.25) {
    self botsetdifficultysetting("throwKnifeChance", 0.25);
  }

  self botsetdifficultysetting("allowGrenades", 1);
  last_weapon_name = "";
  original_personality = self.personality;
  wait 0.1;

  while(true) {
    if(getdvarint(@ "hash_c2de8ca6dc8512c1")) {
      wait 0.05;
      continue;
    }

    current_weapon = self getcurrentweapon();

    if(current_weapon.basename != "none" && !iskillstreakweapon(current_weapon) && current_weapon.basename != last_weapon_name && !ismeleeoverrideweapon(current_weapon)) {
      last_weapon_name = current_weapon.basename;

      if(self botgetdifficultysetting("advancedPersonality") && self botgetdifficultysetting("strategyLevel") > 0) {
        bot_gun_pick_personality_from_weapon(current_weapon.basename, original_personality);
      }
    }

    self[[self.personality_update_function]]();
    wait 0.05;
  }
}