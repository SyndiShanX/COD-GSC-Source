/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\bots\_bots_gametype_gun.gsc
*******************************************************/

main() {
  _id_87A7();
  _id_8795();
}

_id_87A7() {
  level.bot_funcs["gametype_think"] = ::_id_1A0E;
}

_id_8795() {}

_id_1A0D(var_0, var_1) {
  if(isDefined(var_0)) {
    var_2 = var_0 + "";
    var_3 = level._id_1B2C[var_2];

    if(isDefined(var_3)) {
      var_4 = strtok(var_3, "| ");

      if(maps\mp\_utility::getweaponclass(maps\mp\_utility::_id_452B(var_0)) == "weapon_pistol")
        var_4 = ["cqb", "run_and_gun"];

      if(var_4.size > 0) {
        var_5 = undefined;

        if(common_scripts\utility::_id_0F79(var_4, var_1))
          var_5 = var_1;
        else
          var_5 = common_scripts\utility::random(var_4);

        maps\mp\bots\_bots_util::_id_1AD5(var_5);
      }
    }
  }
}

_id_1A0E() {
  self notify("bot_gun_think");
  self endon("bot_gun_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("owner_disconnect");
  var_0 = "";
  var_1 = self._id_6F7D;
  wait 0.1;

  for(;;) {
    var_2 = self getcurrentweapon();

    if(var_2 != "none" && !maps\mp\_utility::iskillstreakweapon(var_2) && var_2 != var_0) {
      var_0 = var_2;

      if(self botgetdifficultysetting("advancedPersonality") && self botgetdifficultysetting("strategyLevel") > 0) {
        var_3 = maps\mp\_utility::_id_452A(var_2);
        _id_1A0D(var_3, var_1);
      }
    }

    self[[self._id_6F7F]]();
    waitframe();
  }
}