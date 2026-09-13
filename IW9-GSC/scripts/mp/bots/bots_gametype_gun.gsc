/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_gun.gsc
*************************************************/

main() {
  setup_callbacks();
  setup_bot_gun();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_gun_think;
}

setup_bot_gun() {
  level.bots_gametype_handles_class_choice = 1;
}

bot_gun_pick_personality_from_weapon(weaponname, _id_8739A29D57D25941) {
  if(isDefined(weaponname) && weaponname != "none") {
    _id_6F94DB6D48B3FD6D = _id_2669878CF5A1B6BC::_id_309BCC0C19DE2D18(weaponname);

    if(isDefined(_id_6F94DB6D48B3FD6D) && _id_6F94DB6D48B3FD6D.size > 0) {
      _id_DC061F521C45D732 = undefined;

      if(scripts\engine\utility::array_contains(_id_6F94DB6D48B3FD6D, _id_8739A29D57D25941))
        _id_DC061F521C45D732 = _id_8739A29D57D25941;
      else
        _id_DC061F521C45D732 = scripts\engine\utility::random(_id_6F94DB6D48B3FD6D);

      if(self.personality != _id_DC061F521C45D732)
        scripts\mp\bots\bots_util::bot_set_personality(_id_DC061F521C45D732);
    }
  }
}

bot_gun_think() {
  self notify("bot_gun_think");
  self endon("bot_gun_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  _id_178BA45A7F7990C4 = self botgetdifficultysetting("throwKnifeChance");

  if(_id_178BA45A7F7990C4 < 0.25)
    self botsetdifficultysetting("throwKnifeChance", 0.25);

  self botsetdifficultysetting("allowGrenades", 1);
  _id_C07A3AC6B0E54838 = "";
  _id_3FFF2E131F17CF45 = self.personality;
  wait 0.1;

  for(;;) {
    _id_89162A7340BA32F3 = self getcurrentweapon();

    if(_id_89162A7340BA32F3.basename != "none" && !_id_2669878CF5A1B6BC::iskillstreakweapon(_id_89162A7340BA32F3) && _id_89162A7340BA32F3.basename != _id_C07A3AC6B0E54838 && !scripts\mp\utility\weapon::ismeleeoverrideweapon(_id_89162A7340BA32F3)) {
      _id_C07A3AC6B0E54838 = _id_89162A7340BA32F3.basename;

      if(self botgetdifficultysetting("advancedPersonality") && self botgetdifficultysetting("strategyLevel") > 0)
        bot_gun_pick_personality_from_weapon(_id_89162A7340BA32F3.basename, _id_3FFF2E131F17CF45);
    }

    self[[self.personality_update_function]]();
    wait 0.05;
  }
}