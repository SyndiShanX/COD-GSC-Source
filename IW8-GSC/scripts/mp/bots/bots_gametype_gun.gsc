/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_gun.gsc
*************************************************/

function main() {
  setup_callbacks();
  setup_bot_gun();
}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &bot_gun_think;
}

function setup_bot_gun() {}

function data_pickup_logic(var0, var1) {
  if(isDefined(var0) && var0 != "none") {
    var2 = scripts\mp\utility\weapon::getweaponrootname(var0);
    var3 = level.bot_weap_personality[var2];
    var4 = strtok(var3, "| ");
    var5 = weaponclass(var0);

    if(var5 == "pistol") {
      var4 = ["cqb", "run_and_gun"];
    }

    if(var4.size > 0) {
      var6 = undefined;

      if(scripts\engine\utility::array_contains(var4, var1)) {
        var6 = var1;
      } else {
        var6 = scripts\engine\utility::random(var4);
      }

      if(self.personality != var6) {
        scripts\mp\bots\bots_util::bot_set_personality(var6);
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
  var0 = self botgetdifficultysetting("throwKnifeChance");

  if(var0 < 0.25) {
    self botsetdifficultysetting("throwKnifeChance", 0.25);
  }

  self botsetdifficultysetting("allowGrenades", 1);
  var1 = "";
  var2 = self.personality;
  wait 0.1;

  for(;;) {
    var3 = self getcurrentweapon();

    if(var3.basename != "none" && !scripts\mp\utility\weapon::iskillstreakweapon(var3) && var3.basename != var1 && !scripts\mp\utility\weapon::update_health_bar_to_player(var3)) {
      var1 = var3.basename;

      if(self botgetdifficultysetting("advancedPersonality") && self botgetdifficultysetting("strategyLevel") > 0) {
        data_pickup_logic(var3.basename, var2);
      }
    }

    self[[self.personality_update_function]]();
    wait 0.05;
  }
}