/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_oic.gsc
*************************************************/

main() {
  setup_callbacks();
  _id_48B5FAF91FC74726();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_gun_think;
}

_id_48B5FAF91FC74726() {
  level.bots_gametype_handles_class_choice = 1;
}

_id_81FF256686F12D6D(weaponname, _id_C888B338EA57D1EA) {
  if(isDefined(weaponname) && weaponname != "none") {
    _id_6F94DB6D48B3FD6D = _id_2669878CF5A1B6BC::_id_309BCC0C19DE2D18(weaponname);

    if(isDefined(_id_6F94DB6D48B3FD6D) && _id_6F94DB6D48B3FD6D.size > 0) {
      _id_DC061F521C45D732 = undefined;

      if(scripts\engine\utility::array_contains(_id_6F94DB6D48B3FD6D, _id_C888B338EA57D1EA))
        _id_DC061F521C45D732 = _id_C888B338EA57D1EA;
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
  _id_C07A3AC6B0E54838 = "";
  _id_3FFF2E131F17CF45 = self.personality;
  wait 0.1;

  for(;;) {
    _id_89162A7340BA32F3 = self getcurrentweapon();

    if(_id_89162A7340BA32F3.basename != "none" && !_id_2669878CF5A1B6BC::iskillstreakweapon(_id_89162A7340BA32F3) && _id_89162A7340BA32F3.basename != _id_C07A3AC6B0E54838 && _id_89162A7340BA32F3.basename != "iw9_knifestab_mp") {
      _id_C07A3AC6B0E54838 = _id_89162A7340BA32F3.basename;

      if(self botgetdifficultysetting("advancedPersonality") && self botgetdifficultysetting("strategyLevel") > 0)
        _id_81FF256686F12D6D(_id_89162A7340BA32F3.basename, _id_3FFF2E131F17CF45);
    }

    self[[self.personality_update_function]]();
    wait 0.05;
  }
}