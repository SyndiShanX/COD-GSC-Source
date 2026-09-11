/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_oic.gsc
*************************************************/

function main() {
  setup_callbacks();
  setup_bot_gun();
}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &bot_gun_think;
}

function setup_bot_gun() {}

function data_pickup_logic(var_0, var_1) {
  if(isDefined(var_0) && var_0 != "none") {
    var_2 = scripts\mp\utility\weapon::getweaponrootname(var_0);
    var_3 = level.bot_weap_personality[var_2];
    var_4 = strtok(var_3, "| ");
    var_5 = weaponclass(var_0);

    if(var_5 == "pistol") {
      var_4 = ["cqb", "run_and_gun"];
    }

    if(var_4.size > 0) {
      var_6 = undefined;

      if(scripts\engine\utility::array_contains(var_4, var_1)) {
        var_6 = var_1;
      } else {
        var_6 = scripts\engine\utility::random(var_4);
      }

      if(self.personality != var_6) {
        scripts\mp\bots\bots_util::bot_set_personality(var_6);
        return;
      }

      return;
    }

    return;
  }
}

function bot_gun_think() {
  self notify("bot_gun_think");
  self endon("bot_gun_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_0 = "";
  var_1 = self.personality;
  wait 0.1;

  for(;;) {
    var_2 = self getcurrentweapon();

    if(var_2.basename != "none" && !scripts\mp\utility\weapon::iskillstreakweapon(var_2) && var_2.basename != var_0 && var_2.basename != "iw8_knifestab_mp") {
      var_0 = var_2.basename;

      if(self botgetdifficultysetting("advancedPersonality") && self botgetdifficultysetting("strategyLevel") > 0) {
        data_pickup_logic(var_2.basename, var_1);
      }
    }

    self[[self.personality_update_function]]();
    wait 0.05;
  }
}