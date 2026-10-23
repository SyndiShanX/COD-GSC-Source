/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\bots\_bots_gametype_gun.gsc
*******************************************************/

main() {
  setup_callbacks();
  setup_bot_gun();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_gun_think;
}

setup_bot_gun() {}

bot_gun_pick_personality_from_weapon(var_0, var_1) {
  if(isDefined(var_0)) {
    var_2 = var_0 + "";
    var_3 = level.bot_weap_personality[var_2];

    if(isDefined(var_3)) {
      var_4 = strtok(var_3, "| ");

      if(maps\mp\_utility::getweaponclass(maps\mp\_utility::_id_452B(var_0)) == "weapon_pistol") {
        var_4 = ["cqb", "run_and_gun"];
      }

      if(var_4.size > 0) {
        var_5 = undefined;

        if(common_scripts\utility::_id_0F79(var_4, var_1)) {
          var_5 = var_1;
        } else {
          var_5 = common_scripts\utility::random(var_4);
        }

        maps\mp\bots\_bots_util::bot_set_personality(var_5);
      }
    }
  }
}

bot_gun_think() {
  self notify("bot_gun_think");
  self endon("bot_gun_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("owner_disconnect");
  var_0 = "";
  var_1 = self.personality;
  wait 0.1;

  for(;;) {
    var_2 = self getcurrentweapon();

    if(var_2 != "none" && !maps\mp\_utility::iskillstreakweapon(var_2) && var_2 != var_0) {
      var_0 = var_2;

      if(self botgetdifficultysetting("advancedPersonality") && self botgetdifficultysetting("strategyLevel") > 0) {
        var_3 = maps\mp\_utility::_id_452A(var_2);
        bot_gun_pick_personality_from_weapon(var_3, var_1);
      }
    }

    self[[self.personality_update_function]]();
    waitframe();
  }
}