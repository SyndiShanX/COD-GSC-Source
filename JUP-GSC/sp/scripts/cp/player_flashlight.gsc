/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\player_flashlight.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp\cp_debug;
#using scripts\cp\utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#namespace player_flashlight;

function function_41b2475a04910ba() {
  level._effect["1st_person_flashlight"] = loadfx("vfx/iw9/cp/vfx_helmet_bright_light_player.vfx");
  level._effect["3rd_person_flashlight"] = loadfx("vfx/iw9/core/flashlight/vfx_flashlight_3rd_person.vfx");
}

function function_b9b3106c0cef675e() {
  self endon("disconnect");
  wait 0.5;
  thread toggle_flashlight(1);
}

function toggle_flashlight(enable) {
  if(!isDefined(self) || !isPlayer(self) || !isalive(self)) {
    return;
  }

  if(!isDefined(enable)) {
    enable = !isDefined(self.var_4aad4f06d972e6b2);
  }

  if(enable) {
    if(isDefined(self.var_4aad4f06d972e6b2)) {
      return;
    }

    if(function_54846d3aa2d31163()) {
      return;
    }

    thread scripts\cp\utility::playerplaypickupanim("iw9_vm_ges_helmet_light");
    thread flashlight_on();
    return;
  }

  if(!isDefined(self.var_4aad4f06d972e6b2)) {
    return;
  }

  if(function_54846d3aa2d31163()) {
    return;
  }

  thread flashlight_off();
}

function function_cbfcb92384926a17(var_4a626586e20b384d, delay) {
  if(istrue(var_4a626586e20b384d)) {
    if(!isDefined(self.var_4aad4f06d972e6b2)) {
      return;
    }
  }

  minimum = 3;

  if(!isDefined(delay)) {
    delay = minimum;
  }

  if(delay < minimum) {
    delay = minimum;
  }

  toggle_flashlight();
  wait delay;
  toggle_flashlight();
}

function private flashlight_on(ent, tag) {
  self playlocalsound("weap_variable_scope_click");
  self.var_4aad4f06d972e6b2 = 1;

  if(!isDefined(self.var_cad18c06d2fad5c2)) {
    self.var_cad18c06d2fad5c2 = spawn("script_model", self.origin);
    self.var_cad18c06d2fad5c2 setModel("tag_origin");
    self.var_cad18c06d2fad5c2.angles = self.angles;
    self.var_cad18c06d2fad5c2 linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  }

  if(!isDefined(self.var_d10dad930a698f9)) {
    self.var_d10dad930a698f9 = spawn("script_model", self.origin);
    self.var_d10dad930a698f9 setModel("tag_origin");
    self.var_d10dad930a698f9.angles = self.angles;
    self.var_d10dad930a698f9 linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  }

  wait 0.1;

  if(!isDefined(level.var_219755583dc9479b)) {
    level.var_219755583dc9479b = 0;
  }

  thread function_75d93edf3e7e2b10();
  thread flashlight_off_on_death();
}

function private flashlight_off(ent, tag) {
  self notify("turn_off_flashlight");
  self playlocalsound("weap_variable_scope_click");
  wait 0.1;

  if(isDefined(self.var_cad18c06d2fad5c2)) {
    self.var_cad18c06d2fad5c2 delete();
  }

  if(isDefined(self.var_d10dad930a698f9)) {
    self.var_d10dad930a698f9 delete();
  }

  self.var_4aad4f06d972e6b2 = undefined;
}

function private function_b7f79cecb63ff5bc(player, var_25bbc3661dfe101e) {
  var_dd1d08b0c203d5ce = player getcamerathirdperson();

  if(istrue(var_25bbc3661dfe101e)) {
    var_25622a3c0a7eb960 = !var_dd1d08b0c203d5ce;
  } else {
    var_25622a3c0a7eb960 = var_dd1d08b0c203d5ce;
  }

  if(istrue(var_25622a3c0a7eb960)) {
    player.var_cad18c06d2fad5c2 hide();
    player.var_d10dad930a698f9 show();
    wait 0.1;
    playFXOnTag(level._effect["3rd_person_flashlight"], player.var_d10dad930a698f9, "tag_origin");
    return;
  }

  player.var_cad18c06d2fad5c2 show();

  foreach(otherplayer in level.players) {
    if(player != otherplayer) {
      player.var_d10dad930a698f9 showtoplayer(otherplayer);
    }
  }

  wait 0.1;

  foreach(otherplayer in level.players) {
    if(player != otherplayer) {
      playfxontagforclients(level._effect["3rd_person_flashlight"], player.var_d10dad930a698f9, "tag_origin", otherplayer);
    }
  }

  playfxontagforclients(level._effect["1st_person_flashlight"], player.var_cad18c06d2fad5c2, "tag_origin", player);
}

function function_41c3302121be1a40() {
  player = self;
  var_dd1d08b0c203d5ce = player getcamerathirdperson();

  if(istrue(var_dd1d08b0c203d5ce)) {
    player.var_cad18c06d2fad5c2 hide();
    player.var_d10dad930a698f9 show();
    wait 0.1;
    playFXOnTag(level._effect["3rd_person_flashlight"], player.var_d10dad930a698f9, "tag_origin");
    return;
  }

  player.var_cad18c06d2fad5c2 show();

  foreach(otherplayer in level.players) {
    if(player != otherplayer) {
      player.var_d10dad930a698f9 showtoplayer(otherplayer);
    }
  }

  wait 0.1;

  foreach(otherplayer in level.players) {
    if(player != otherplayer) {
      playfxontagforclients(level._effect["3rd_person_flashlight"], player.var_d10dad930a698f9, "tag_origin", otherplayer);
    }
  }

  playfxontagforclients(level._effect["1st_person_flashlight"], player.var_cad18c06d2fad5c2, "tag_origin", player);
}

function private function_75d93edf3e7e2b10() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("turn_off_flashlight");

  for(notifyresult = undefined; true; notifyresult = waittill_any_return_4("toggled_third_person_camera", "pickedupweapon", "update_flashlight_tags")) {
    if(self tagexists("TAG_helmetlight")) {
      self.var_cad18c06d2fad5c2 linkTo(self, "TAG_helmetlight", (0, 0, 0), (0, 0, 0));
    } else if(self tagexists("j_helmet")) {
      self.var_cad18c06d2fad5c2 linkTo(self, "j_helmet", (0, 0, 0), (0, 0, 0));
    } else if(self tagexists("tag_helmet")) {
      self.var_cad18c06d2fad5c2 linkTo(self, "tag_helmet", (0, 0, 0), (0, 0, 0));
    } else {
      self.var_cad18c06d2fad5c2 linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
    }

    if(self tagexists("J_Shoulder_LE")) {
      if(isDefined(self.currentprimaryweapon)) {
        if(self.currentprimaryweapon.basename == "iw9_me_pushfists") {
          self.var_d10dad930a698f9 linkTo(self, "tag_helmetlight", (-5, 0, 5), (0, 0, 0));
        } else if(self.currentprimaryweapon.basename == "iw9_oxygenmask") {
          self.var_d10dad930a698f9 linkTo(self, "tag_origin", (0, 0, 60), (0, 0, 0));
        } else {
          self.var_d10dad930a698f9 linkTo(self, "J_Shoulder_LE", (0, 10, -5), (-25, -15, 0));
        }
      } else if(isDefined(self.prevweaponobj)) {
        if(self.prevweaponobj.basename == "iw9_me_riotshield_mp") {
          self.var_d10dad930a698f9 linkTo(self, "tag_origin", (0, 20, 0), (0, 0, 0));
        } else if(self.prevweaponobj.basename == "iw9_oxygenmask") {
          self.var_d10dad930a698f9 linkTo(self, "tag_origin", (0, 0, 70), (0, 0, 0));
        } else {
          self.var_d10dad930a698f9 linkTo(self, "J_Shoulder_LE", (0, 10, -5), (-25, -15, 0));
        }
      } else {
        self.var_d10dad930a698f9 linkTo(self, "J_Shoulder_LE", (0, 10, -5), (-25, -15, 0));
      }
    } else if(self tagexists("j_helmet")) {
      self.var_d10dad930a698f9 linkTo(self, "j_helmet", (-5, -5, 0), (0, 270, 0));
    } else if(self tagexists("tag_helmet")) {
      self.var_d10dad930a698f9 linkTo(self, "tag_helmet", (-5, -5, 0), (0, 270, 0));
    } else {
      self.var_d10dad930a698f9 linkTo(self, "tag_origin", (0, 0, 0), (90, 0, 0));
    }

    if(isDefined(notifyresult)) {
      if(notifyresult != "toggled_third_person_camera") {
        if(isDefined(self.currentprimaryweapon.basename) && (self.currentprimaryweapon.basename == "iw9_me_pushfists" || self.currentprimaryweapon.basename == "none")) {
          function_b7f79cecb63ff5bc(self, 1);
        } else {
          function_b7f79cecb63ff5bc(self, 0);
        }
      } else {
        function_b7f79cecb63ff5bc(self, 1);
      }

      continue;
    }

    function_b7f79cecb63ff5bc(self, 0);
  }
}

function private flashlight_off_on_death() {
  self notify("flashlight_off_on_death");
  self endon("flashlight_off_on_death");
  self endon("disconnect");
  self waittill("death");

  if(!isDefined(self.var_4aad4f06d972e6b2)) {
    return;
  }

  flashlight_off();
  self.var_4aad4f06d972e6b2 = undefined;
}

function private function_54846d3aa2d31163() {
  if(isDefined(self.var_1d66399e95195d21) && self.var_1d66399e95195d21 > gettime() - 200) {
    return true;
  }

  self.var_1d66399e95195d21 = gettime();
  return false;
}

function function_491a6611a0b52b99() {
  level.var_f2e48424baec7c2e = getEntArray("flashlight_trigger", "targetname");

  if(isDefined(level.var_f2e48424baec7c2e)) {
    foreach(trigger in level.var_f2e48424baec7c2e) {
      trigger thread function_7fcb92efb596bd83();
    }
  }
}

function function_7fcb92efb596bd83() {
  if(isDefined(self.entstouching)) {
    return;
  }

  self.entstouching = [];
  thread trigger_watchflashlighttriggerexit(self);
  thread trigger_watchflashlighttriggerenter(self);
}

function trigger_watchflashlighttriggerenter(trigger) {
  level endon("game_ended");
  trigger notify("trigger_watchFlashlightTriggerEnter");
  trigger endon("trigger_watchFlashlightTriggerEnter");
  trigger endon("death");

  while(true) {
    trigger waittill("trigger", ent);

    if(!function_dc0a66796f616fce(ent)) {
      continue;
    }

    function_7df3c090beee2450(trigger, ent);
  }
}

function trigger_watchflashlighttriggerexit(trigger) {
  level endon("game_ended");
  trigger notify("trigger_watchFlashlightTriggerExit");
  trigger endon("trigger_watchFlashlightTriggerExit");
  trigger endon("death");

  while(true) {
    temparr = trigger.entstouching;

    foreach(ent in temparr) {
      if(!isDefined(ent)) {
        trigger.entstouching[id] = undefined;
        continue;
      }

      valid = trigger istouching(ent);

      if(isPlayer(ent) && !isalive(ent)) {
        valid = 0;
      }

      if(isDefined(ent) && !valid) {
        function_bd8f6ed981f07aaa(trigger, ent);
      }
    }

    waitframe();
  }
}

function function_dc0a66796f616fce(ent) {
  if(isDefined(ent)) {
    if(isPlayer(ent)) {
      if(ent scripts\cp_mp\utility\player_utility::_isalive()) {
        return true;
      }
    }
  }

  return false;
}

function function_bd8f6ed981f07aaa(trigger, ent) {
  entnum = ent getentitynumber();
  trigger.entstouching[entnum] = undefined;

  if(!function_5aa17b8039e280d(trigger, ent)) {
    ent thread toggle_flashlight(0);
  }
}

function function_7df3c090beee2450(trigger, ent) {
  entnum = ent getentitynumber();

  if(isDefined(trigger.entstouching[entnum])) {
    return;
  }

  trigger.entstouching[entnum] = ent;
  ent thread toggle_flashlight(1);
}

function function_5aa17b8039e280d(trigger, ent) {
  entnum = ent getentitynumber();

  foreach(other_trigger in level.var_f2e48424baec7c2e) {
    if(other_trigger == trigger) {
      continue;
    }

    if(isDefined(other_trigger.entstouching[entnum])) {
      return true;
    }
  }

  return false;
}

function function_47f4f9f3fa1a644d() {
  cmd = "devgui_cmd \"CP Debug:2 / Debug / CP Flashlight / Toggle Flashlight P1\" \"togglep scr_cpflashlightp1_toggle 1\" \n";
  addentrytodevgui(cmd);
  level thread function_eef8fed381e4deec(@ "hash_e39637fee7dc2c32", &function_692ed79ca5616c4e);
  cmd = "devgui_cmd \"CP Debug:2 / Debug / CP Flashlight / Toggle Flashlight P2\" \"togglep scr_cpflashlightp2_toggle 1\" \n";
  addentrytodevgui(cmd);
  level thread function_eef8fed381e4deec(@ "hash_39097cbf328765f5", &function_692ed69ca5616a1b);
  cmd = "devgui_cmd \"CP Debug:2 / Debug / CP Flashlight / Toggle Flashlight P3\" \"togglep scr_cpflashlightp3_toggle 1\" \n";
  addentrytodevgui(cmd);
  level thread function_eef8fed381e4deec(@ "hash_4e79247efa17ec98", &function_692ed59ca56167e8);
  cmd = "devgui_cmd \"CP Debug:2 / Debug / CP Flashlight / Flash x4 Flashlight P1\" \"togglep scr_cpflashlightp1_flash 1\" \n";
  addentrytodevgui(cmd);
  level thread function_eef8fed381e4deec(@ "hash_5afbd1775ccd6b80", &function_d3810fcc0316553b);
  cmd = "devgui_cmd \"CP Debug:2 / Debug / CP Flashlight / Flash x4 Flashlight P2\" \"togglep scr_cpflashlightp2_flash 1\" \n";
  addentrytodevgui(cmd);
  level thread function_eef8fed381e4deec(@ "hash_b70c1770b63fba59", &function_33703dd50c607cce);
  cmd = "devgui_cmd \"CP Debug:2 / Debug / CP Flashlight / Flash x4 Flashlight P3\" \"togglep scr_cpflashlightp3_flash 1\" \n";
  addentrytodevgui(cmd);
  level thread function_eef8fed381e4deec(@ "hash_b3c0c4997d226c4e", &function_36bb90ac457dcad9);
}

function private function_692ed79ca5616c4e() {
  if(isDefined(level.players[0])) {
    level.players[0] thread toggle_flashlight();
  }
}

function private function_692ed69ca5616a1b() {
  if(isDefined(level.players[1])) {
    level.players[1] thread toggle_flashlight();
  }
}

function private function_692ed59ca56167e8() {
  if(isDefined(level.players[2])) {
    level.players[2] thread toggle_flashlight();
  }
}

function private function_d3810fcc0316553b() {
  if(isDefined(level.players[0])) {
    level.players[0] thread function_f25f2e91dbd65167();
  }
}

function private function_33703dd50c607cce() {
  if(isDefined(level.players[1])) {
    level.players[1] thread function_f25f2e91dbd65167();
  }
}

function private function_36bb90ac457dcad9() {
  if(isDefined(level.players[2])) {
    level.players[2] thread function_f25f2e91dbd65167();
  }
}

function private function_f25f2e91dbd65167() {
  if(isDefined(self)) {
    announcement("flash 1 / 4, enable");
    thread toggle_flashlight();
    wait 3;
    announcement("flash 2 / 4, disable");
    thread toggle_flashlight();
    wait 3;
    announcement("flash 3 / 4, enable");
    thread toggle_flashlight();
    wait 3;
    announcement("flash 4 / 4, disable");
    thread toggle_flashlight();
  }
}