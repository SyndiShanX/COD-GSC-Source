/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_gastrap.gsc
***********************************************/

init_gastrap() {
  scripts\engine\utility::flag_init("gastrap_initted");
  _id_EABF1641F5306271 = scripts\engine\utility::getStructArray("gastrap", "script_noteworthy");

  if(isDefined(_id_EABF1641F5306271) && _id_EABF1641F5306271.size > 0) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_EABF1641F5306271.size; _id_AC0E594AC96AA3A8++)
      _id_EABF1641F5306271[_id_AC0E594AC96AA3A8] thread initindividualgastrap();
  }
}

initindividualgastrap() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("introscreen_over");
  scripts\engine\utility::flag_wait("infil_complete");
  level.gasvfxstructs = scripts\engine\utility::getStructArray("gastrap_spout_vfx", "script_noteworthy");
  ents = getEntArray("gastrap_damage_trigger", "script_noteworthy");
  damage_area = undefined;

  foreach(struct in level.gasvfxstructs) {
    if(struct.script_noteworthy == "gastrap_spout_vfx") {
      struct.gasmodel = spawn("script_model", struct.origin);
      struct.gasmodel setModel("tag_origin_gas_spout");
      struct.gasmodel.angles = (0, 0, 180);
    }
  }

  foreach(ent in ents) {
    if(ent.script_noteworthy == "gastrap_damage_trigger")
      self.damage_area = ent;
  }

  gasmodel = spawn("script_model", scripts\engine\utility::drop_to_ground(self.origin, 0, -10000));
  gasmodel setModel("tag_origin_gas_trap");
  self.gasmodel = gasmodel;
  level.gastrapstruct = self;
  scripts\engine\utility::flag_set("gastrap_initted");
}

activategastrap(_id_97282C14346A7FCF) {
  scripts\engine\utility::flag_wait("gastrap_initted");
  trap = level.gastrapstruct;

  if(!isDefined(self.gasmodel.sound_ent))
    self.gasmodel.sound_ent = spawn("script_origin", self.gasmodel.origin - (0, 0, 150));

  if(!isDefined(level.gastrap_dmg_trig))
    level.gastrap_dmg_trig = trap.damage_area;

  foreach(struct in level.gasvfxstructs)
  struct.gasmodel setscriptablepartstate("target", "active");

  level.gastrapstruct.gasmodel setscriptablepartstate("target", "active");
  level thread watchgastrapdamage(level.gastrap_dmg_trig);
  self.gasmodel.sound_ent playLoopSound("gas_trap_hiss_lp");
  trap.trapactive = 1;
  level notify("gas_trap_activated");
}

deactivategastrap(_id_97282C14346A7FCF) {
  level.gastrapstruct.gasmodel setscriptablepartstate("target", "neutral");
  level.gastrapstruct.trapactive = 0;

  foreach(struct in level.gasvfxstructs)
  struct.gasmodel setscriptablepartstate("target", "neutral");

  if(isDefined(self.gasmodel.sound_ent)) {
    self.gasmodel.sound_ent stoploopsound("gas_trap_hiss_lp");
    self.gasmodel.sound_ent delete();
  }

  level notify("gas_trap_deactivated");
}

watchgastrapdamage(dmg_trig) {
  level endon("gas_trap_deactivated");
  level endon("game_ended");

  if(isDefined(dmg_trig)) {
    for(;;) {
      foreach(player in level.players) {
        if(player istouching(dmg_trig)) {
          if(isalive(player) && _id_0AFB7E332AEE4BF2::player_in_laststand(player)) {
            continue;
          }
          player.padding_damage = 1;
          player dodamage(35, player.origin, undefined, undefined, "MOD_UNKNOWN");
          player thread trytoplaydamagesound();
          player thread remove_padding_damage();
        }
      }

      wait 0.2;
    }
  }
}

remove_padding_damage() {
  self endon("disconnect");
  wait 0.25;
  self.padding_damage = undefined;
}

trytoplaydamagesound() {
  self endon("death");

  if(isDefined(self.playingcoughdamagesound) && self.playingcoughdamagesound) {
    return;
  }
  self.playingcoughdamagesound = 1;
  _id_818F7C4CF3588018 = "player_cough_a";

  switch (randomint(3)) {
    case 0:
      _id_818F7C4CF3588018 = "player_cough_a";
      break;
    case 1:
      _id_818F7C4CF3588018 = "player_cough_b";
      break;
    default:
      _id_818F7C4CF3588018 = "player_cough_c";
      break;
  }

  scripts\cp\utility::playsoundtoplayer_safe(_id_818F7C4CF3588018, self);
  waittime = lookupsoundlength(_id_818F7C4CF3588018);
  wait(waittime / 1000);
  self.playingcoughdamagesound = undefined;
}