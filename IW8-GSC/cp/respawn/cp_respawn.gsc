/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\respawn\cp_respawn.gsc
***********************************************/

main() {
  level._effect["_encstr_A14018B3CCF0AFCDE60B3A8DA17D5836139981F51B8DDEBA23DC"] = loadfx("_encstr_BE60307395D360F780CF51EFAA6A5FB9F0E11568D457A27E9B2B593F281A55B602C7F01757AA77F7BFD9373D7AB640FC9DE8");
  level._effect["_encstr_9BBD0C0B0BF2620FC6F072DB1926"] = loadfx("_encstr_97822B3BCCF0974BEE837D6B0779DAB4B1B1DC1D4E590B5B5E9D990FFA16C626330CAFD8C6DBD5199B71D966E1");
  level._effect["_encstr_92970C36989918EBB196D91A47CD"] = loadfx("_encstr_888C2BEC99F0BC4BBBE07DD638BCD65AB136CD3A9395C25BE53B99C3AF2CC6266603D78D4BCED047E671B399F0");
  setomnvar("_encstr_97881C033AD7963049F94961E92D4065C763DE4907CEF721DCD54B4F6853", 6666);
  setomnvar("_encstr_92F21BD5A5BE4CC9FA0BB13A4B6B593AB293FA6E5616F50D56A5760D3A", scripts\cp_mp\parachute::getc130sealevel());
  var_0 = getEntArray("_encstr_A6BC0F4183703022A7E3EFDE40DB48380B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = level.mapcenter;

  if(var_0.size)
    var_1 = scripts\cp\cp_globallogic::findboxcenter(var_0[0].origin, var_0[1].origin);

  level.ac130 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  level.ac130 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  level.ac130.angles = (0, 115, 0);
  thread rotate_plane();
  level.respawn_func = ::respawn_bleedout_func;
  level.parachutetakeweaponscb = ::takeweaponsdefaultfunc;
  level.parachuterestoreweaponscb = ::give_loadout_back_after_landing;
  level.respawn_uses = 0;
  level._id_12880 = [];

  if(scripts\cp\respawn\cp_ac130_respawn::trial_ui_decrease_tries_remaining())
    scripts\cp\respawn\cp_ac130_respawn::_id_131D9();

  if(getdvarint("_encstr_B8B8109BC6E4EB6ED07B9C3ABEC96EE07737", 0) != 0)
    level.respawn_cooldown = 5;

  level.respawn_cooldown = 60 + 0 * level.respawn_uses;
  level.time_till_next_respawn = level.respawn_cooldown;
  level.automated_respawn_delay = 60;
  level.initialize_flag_role = 0;
  level.disable_hotjoin_via_ac130 = 1;
  scripts\cp_mp\parachute::initparachutedvars();
  level.respawn_c130 = [];
}

rotate_plane() {
  level.ac130_speed["_encstr_ACA20538F84D39"] = 250;
  level.ac130_speed["_encstr_B4F507E4BD4785E856"] = 120;
  var_0 = 10;
  var_1 = level.ac130_speed["_encstr_B4F507E4BD4785E856"] / 360 * var_0;
  level.ac130 rotateYaw(level.ac130.angles[2] + var_0, var_1, var_1, 0);
  var_2 = 360 / level.ac130_speed["_encstr_B4F507E4BD4785E856"];
  var_3 = var_2 * 0.0174533;
  level.ac130_magnitude = var_3 * 9000;

  for(;;) {
    level.ac130 rotateYaw(360, level.ac130_speed["_encstr_B4F507E4BD4785E856"]);
    wait(level.ac130_speed["_encstr_B4F507E4BD4785E856"]);
  }
}

get_respawn_cooldown() {
  level.respawn_cooldown = 60 + 0 * level.respawn_uses;

  if(getdvarint("_encstr_B8B8109BC6E4EB6ED07B9C3ABEC96EE07737", 0) != 0)
    level.respawn_cooldown = 5;

  return level.respawn_cooldown;
}

activate_respawn_flare() {
  if(istrue(self.bgivensentry)) {
    return;
  }
  if(istrue(self.tablet_out)) {
    return;
  }
  if(istrue(self.waiting_to_spawn)) {
    return;
  }
  if(self isskydiving()) {
    return;
  }
  if(istrue(self.spectating)) {
    return;
  }
  if(istrue(self.binc130)) {
    return;
  }
  if(istrue(self.isreviving)) {
    return;
  }
  if(istrue(self.inlaststand)) {
    return;
  }
  if(!istrue(self.respawn_active)) {
    return;
  }
  if(!isDefined(level.players_in_respawn_queue)) {
    return;
  }
  if(level.players_in_respawn_queue.size == 0) {
    return;
  }
  level.respawn_uses++;
  level.respawn_in_progress = 1;

  if(!istrue(self._id_12C9C)) {
    self._id_12C9C = 1;
    thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("_encstr_B442086D6763FB3D4F0A");
  }

  scripts\cp\crafting_system::scriptable_autouse_funcs();
  scripts\cp\respawn\cp_ac130_respawn::start_ac130_respawn_sequence(self.origin, level.players_in_respawn_queue, self);

  foreach(var_1 in level.players) {
    var_1 thread scripts\cp\cp_hud_message::showsplash("_encstr_BAA1108D38D7EA6E5619FAC9956EC10BDDE6", undefined, self);
    var_1 thread toggle_respawn_functionality_after_timeout(get_respawn_cooldown());
  }

  level notify("_encstr_AAAD0D7819931B490F0397F39FB05C");
  level.respawn_in_progress = undefined;
  return;
  return;
}

respawn_bleedout_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  scripts\cp\cp_laststand::enter_camera_zoomout();

  if(istrue(var_0.fauxdead) || istrue(var_0.binc130)) {
    var_0.fauxdead = undefined;
    var_0 scripts\cp\cp_laststand::enter_bleed_out(var_0);
    var_0 scripts\cp\cp_laststand::playslamzoomflash();
  } else
    scripts\cp\cp_laststand::camera_zoomout(var_0, var_1, undefined);

  scripts\cp\cp_laststand::exit_camera_zoomout();

  if(!isDefined(level.players_in_respawn_queue))
    level.players_in_respawn_queue = [];

  level.players_in_respawn_queue = scripts\engine\utility::array_add(level.players_in_respawn_queue, var_0);
  var_12 = 0;
  var_13 = undefined;

  foreach(var_15 in level.players) {
    if(var_15.sessionstate == "_encstr_AF8C0A1B6A1D6045925B4F7D")
      var_12++;
  }

  if(var_12 == level.players.size - 1) {
    foreach(var_15 in level.players) {
      if(var_15.sessionstate == "_encstr_AF8C0A1B6A1D6045925B4F7D")
        continue;
    }
  }

  foreach(var_15 in level.players) {
    if(!istrue(level.player_cam_disable)) {
      level.player_cam_disable = 1;

      foreach(var_15 in level.players) {
        var_15.respawn_active = 0;
        var_15 notify("_encstr_AC51189B306C7FFDC04F8A65EF9046F737AE3233B8364BF4B805", 1);
      }
    }
  }

  for(;;) {
    var_23 = var_0 scripts\engine\utility::_id_143AE("_encstr_956C0F7507A3AF90D73D46BBA5A9186DCB", "_encstr_ADDB0D9B2D4B28E08312533B3AFF20", "_encstr_AF1C19BBFF262A7D30E69AA73BA09682685117E76DC51222408B12");

    if(isDefined(var_23)) {
      if(istrue(var_0.binc130)) {
        continue;
      }
      if(istrue(level._id_12213)) {
        continue;
      }
      if(var_23 == "_encstr_ADDB0D9B2D4B28E08312533B3AFF20") {
        scripts\cp\respawn\cp_ac130_respawn::start_ac130_respawn_sequence(var_0.origin, level.players_in_respawn_queue, var_0);

        foreach(var_15 in level.players)
        var_15 thread scripts\cp\cp_hud_message::showsplash("_encstr_BD2B10FE2BD9414B2DCF77CB3356E3B97070");

        var_0 setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 1);
        wait 2;
        var_0 setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 1);
        scripts\cp\cp_analytics::_id_119BB(var_0);
      } else if(var_23 == "_encstr_956C0F7507A3AF90D73D46BBA5A9186DCB")
        scripts\cp\cp_analytics::_id_119BD(var_0);
      else
        var_0.playerjailwaitvo = 1;

      level.players_in_respawn_queue = scripts\engine\utility::array_remove(level.players_in_respawn_queue, var_0);
      return 1;
    }
  }
}

launch_respawn_functionality_for_players() {
  level notify("_encstr_8F88296358EA37B10DEB4E596E0758DDB9BECCABB9D81D2DEDCD85C6968EBCAF33F6E47D0763B0BCB2C9B9");
  level endon("_encstr_8F88296358EA37B10DEB4E596E0758DDB9BECCABB9D81D2DEDCD85C6968EBCAF33F6E47D0763B0BCB2C9B9");

  foreach(var_1 in level.players) {
    if(scripts\engine\utility::array_contains(level.players_in_respawn_queue, var_1)) {
      continue;
    }
    var_1 thread respawn_dpad_func();
  }
}

respawn_dpad_func() {
  self endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  self notify("_encstr_9779127A4A62828AB793F9403B39B3603BBB7387");
  self endon("_encstr_9779127A4A62828AB793F9403B39B3603BBB7387");
  self notifyonplayercommand("_encstr_8290103A0938D08A2C4DF743A1DFF33DD853", "_encstr_97410B23BD6B976233901AF2F8");
  waitframe();

  for(;;) {
    self waittill("_encstr_8290103A0938D08A2C4DF743A1DFF33DD853");

    foreach(var_1 in level.players_in_respawn_queue) {
      var_1 thread do_resurrection_logic(self);
      level.players_in_respawn_queue = scripts\engine\utility::array_remove(level.players_in_respawn_queue, var_1);
    }
  }
}

do_resurrection_logic(var_0) {
  scripts\cp\cp_laststand::record_revive_success(var_0, self);
  var_0 notify("_encstr_8C8A103333CC6286C00EC38FE1A8D5BAA55B", self);
  var_1 = scripts\cp\cp_endgame::get_current_zone(var_0);
  var_2 = 1;
  self.last_stand_state = undefined;

  if(isPlayer(var_0) && istrue(var_0.can_give_revive_xp))
    var_0.can_give_revive_xp = 0;
}

_id_13A9C(var_0, var_1, var_2) {
  self setweaponhudiconoverride("_encstr_8DE40B413BB3F2B0A85BE9184B" + var_0, var_1);

  if(isDefined(var_2))
    thread _id_13A9D(var_0, var_2);
}

_id_13A9D(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A720118A339025DBB525225B0898839A30BF04" + var_0);
  self notifyonplayercommand("_encstr_AFD410243599C5DFD31D331333E0A98F46F0", "_encstr_A7190C30FA75A91BABF2353FF372");

  for(;;) {
    self waittill("_encstr_AFD410243599C5DFD31D331333E0A98F46F0");
    self thread[[var_1]]();
  }
}

respawn_function_toggle() {
  self notify("_encstr_B67F188B011673EEBB1D97B63390362BB3F8C2C1CBE0F7A7F063");
  self endon("_encstr_B67F188B011673EEBB1D97B63390362BB3F8C2C1CBE0F7A7F063");

  for(;;) {
    self waittill("_encstr_AC51189B306C7FFDC04F8A65EF9046F737AE3233B8364BF4B805", var_0);

    if(istrue(var_0)) {
      if(!istrue(self.respawn_active)) {
        thread _id_119DF();
        thread _id_12DE7();
      }

      self.respawn_active = 1;
      continue;
    }

    self.respawn_active = 0;
    self setclientomnvar("_encstr_92E018562B474B455F2D4E9315DA8B971B039F943B70B8D13953", 2);
  }
}

_id_12DE7() {
  level endon("_encstr_AAAD0D7819931B490F0397F39FB05C");
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self._id_12C98 = undefined;
  self._id_12C96 = undefined;

  for(;;) {
    if(!istrue(level.automated_respawn_available)) {
      wait 1;
      continue;
    }

    if(level.players.size > 1) {
      if(isDefined(level.players_in_respawn_queue) && level.players_in_respawn_queue.size > 0) {
        if(istrue(self.binc130)) {
          wait 1;
          continue;
        }

        if(!istrue(self._id_12C98)) {
          self._id_12C98 = 1;
          self setclientomnvar("_encstr_92E018562B474B455F2D4E9315DA8B971B039F943B70B8D13953", 3);
          self._id_12C96 = undefined;
        }
      } else if(!istrue(self._id_12C96)) {
        self._id_12C96 = 1;
        self setclientomnvar("_encstr_92E018562B474B455F2D4E9315DA8B971B039F943B70B8D13953", 1);
        self._id_12C98 = undefined;
      }
    }

    wait 0.5;
  }
}

getcpcratedropcaststart() {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self._id_12C97 = undefined;
  self._id_12C95 = undefined;
  thread respawn_function_toggle();

  for(;;) {
    if(level.players.size == 1) {
      if(!istrue(self._id_12C97)) {
        self._id_12C97 = 1;
        self._id_12C98 = undefined;
        self._id_12C96 = undefined;
        level notify("_encstr_AAAD0D7819931B490F0397F39FB05C");
        self notify("_encstr_B67F188B011673EEBB1D97B63390362BB3F8C2C1CBE0F7A7F063");
        self setclientomnvar("_encstr_92E018562B474B455F2D4E9315DA8B971B039F943B70B8D13953", 0);
        self._id_12C95 = 1;
      }
    } else {
      self._id_12C97 = undefined;

      if(istrue(self._id_12C95)) {
        self setclientomnvar("_encstr_92E018562B474B455F2D4E9315DA8B971B039F943B70B8D13953", 1);
        thread respawn_function_toggle();
        level.players_in_respawn_queue = [];
      }

      self._id_12C95 = undefined;
    }

    wait 1;
  }
}

_id_119DF() {
  level endon("_encstr_AAAD0D7819931B490F0397F39FB05C");
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_83281A904F9FE357C3876EF79ECB6D4EEA1F7048BF175BC1CAAE66F3");
  self endon("_encstr_83281A904F9FE357C3876EF79ECB6D4EEA1F7048BF175BC1CAAE66F3");

  for(;;) {
    if(!istrue(self.respawn_active)) {
      wait 1;
      continue;
    }

    if(level.players_in_respawn_queue.size > 0) {
      if(istrue(self.binc130)) {
        continue;
      }
      thread scripts\cp\cp_hud_message::showsplash("_encstr_85F0112E82697D39E34B88C0CB37139B522F9B", undefined, self);
    }

    wait 15;
  }
}

toggle_respawn_functionality_after_timeout(var_0, var_1) {
  self notify("_encstr_B6C717E68EC239D1BE272B37E02CDDB9D71BB7DE1B46EDBBE6");
  self endon("_encstr_B6C717E68EC239D1BE272B37E02CDDB9D71BB7DE1B46EDBBE6");
  level.automated_respawn_available = 0;
  self notify("_encstr_AC51189B306C7FFDC04F8A65EF9046F737AE3233B8364BF4B805", 0);

  if(isDefined(var_1) && isstring(var_1))
    level waittill(var_1);
  else {
    level.time_till_next_respawn = level.respawn_cooldown;
    level thread time_till_next_respawn_tick();
    var_2 = gettime() + var_0 * 1000;
    setomnvar("_encstr_8DF8162290AF139F2949A78255B3139E57D869CB30B30F8B", var_2);

    for(var_3 = var_0; var_3 >= 0; var_3--)
      wait 1;

    setomnvar("_encstr_8DF8162290AF139F2949A78255B3139E57D869CB30B30F8B", 0);
  }

  self notify("_encstr_AC51189B306C7FFDC04F8A65EF9046F737AE3233B8364BF4B805", 1);
  level.automated_respawn_available = 1;
}

checkforactiveobjicon() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_AAAD0D7819931B490F0397F39FB05C");
  level endon("_encstr_ADDB0D9B2D4B28E08312533B3AFF20");
  level notify("_encstr_97891381FB7B105902FD7769E1AB18F083D2988933");
  level endon("_encstr_97891381FB7B105902FD7769E1AB18F083D2988933");

  for(;;) {
    var_0 = gettime() + level.automated_respawn_delay * 1000;
    setomnvar("_encstr_AA7D164651AFAF57138DAE1ED316E387FBD0172B273B456A", var_0);
    setomnvar("_encstr_92E018562B474B455F2D4E9315DA8B971B039F943B70B8D13953", 4);

    for(level.initialize_flag_role = level.automated_respawn_delay; level.initialize_flag_role >= 0; level.initialize_flag_role--)
      wait 1;

    setomnvar("_encstr_AA7D164651AFAF57138DAE1ED316E387FBD0172B273B456A", 0);
    setomnvar("_encstr_92E018562B474B455F2D4E9315DA8B971B039F943B70B8D13953", 0);

    foreach(var_2 in level.players)
    var_2 notify("_encstr_ADDB0D9B2D4B28E08312533B3AFF20");

    level.automated_respawn_delay = 60;
    level.initialize_flag_role = 0;
    level notify("_encstr_ADDB0D9B2D4B28E08312533B3AFF20");
  }
}

time_till_next_respawn_tick() {
  for(;;) {
    if(level.time_till_next_respawn <= 0) {
      break;
    }

    level.time_till_next_respawn--;
    wait 1;
  }
}

give_loadout_back_after_landing() {
  thread give_loadout_after_entire_landing_is_done();
}

give_loadout_after_entire_landing_is_done() {
  self waittill("_encstr_A9E113A3A845C6179835FCE5D801DF0DA9587A5B20");
  self getclientomnvar();
  self skydive_cutautodeployon();
  thread little_bird_mg_initdamage(3);
  self.parachuting = undefined;

  if(self hasweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C"))
    self takeweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");

  if(isDefined(self.classstruct.loadoutaccessorydata) && isDefined(self.classstruct.loadoutaccessoryweapon) && self.classstruct.loadoutaccessoryweapon != "_encstr_8BBA05185F8B99")
    scripts\cp\cp_accessories::giveplayeraccessory(self.classstruct.loadoutaccessorydata, self.classstruct.loadoutaccessoryweapon, self.classstruct.loadoutaccessorylogic);

  if(istrue(self.bspawningviaac130)) {
    self.bspawningviaac130 = undefined;

    if(!istrue(self.inlaststand)) {
      foreach(var_1 in self.copy_fullweaponlist) {
        if(!self hasweapon(var_1))
          self giveweapon(var_1, -1, 0, -1, 1);

        var_2 = createheadicon(var_1);

        if(isDefined(self.powerprimarygrenade) && self.powerprimarygrenade == var_2)
          self assignweaponoffhandprimary(var_1);

        if(isDefined(self.powersecondarygrenade) && self.powersecondarygrenade == var_2)
          self assignweaponoffhandsecondary(var_1);

        if(isDefined(self.specialoffhandgrenade) && self.specialoffhandgrenade == var_2)
          self assignweaponoffhandspecial(var_1);

        var_3 = self getweaponammoclip(var_1, "_encstr_A5AD056A019C63");
        var_4 = self getweaponammoclip(var_1, "_encstr_8253060E2B5FE330");
        self setweaponammoclip(var_1, var_3, "_encstr_A5AD056A019C63");
        self setweaponammoclip(var_1, var_4, "_encstr_8253060E2B5FE330");

        if(isDefined(self.copy_weapon_ammo_stock[var_2]))
          self setweaponammostock(var_1, self.copy_weapon_ammo_stock[var_2]);
      }

      var_6 = self.copy_weapon_current;

      if(getqueuedspleveltransients(var_6)) {
        foreach(var_8 in self.copy_fullweaponlist) {
          if(scripts\cp\cp_weapon::isbulletweapon(var_8)) {
            var_6 = var_8;
            break;
          }
        }
      }

      self.copy_fullweaponlist = undefined;
      self.copy_weapon_current = undefined;
      self.copy_weapon_ammo_clip = undefined;
      self.copy_weapon_ammo_stock = undefined;
      self.copy_weapon_ammo_clip_left = undefined;
    }
  } else {
    if(istrue(self.fly_to_end_point)) {
      var_10 = scripts\cp\loot_system::get_empty_munition_slot(self);

      if(isDefined(var_10))
        scripts\cp\cp_munitions::give_munition_to_slot("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", var_10);

      self.fly_to_end_point = undefined;
    }

    if(isDefined(self.primaryweaponobj)) {
      scripts\cp_mp\utility\inventory_utility::_giveweapon(self.primaryweaponobj, undefined, undefined, 0);

      if(isDefined(self.primaryweaponclipammo)) {
        self setweaponammoclip(self.primaryweaponobj, self.primaryweaponclipammo);
        self setweaponammostock(self.primaryweaponobj, self.primaryweaponstockammo);
      }
    }

    if(isDefined(self.secondaryweaponobj)) {
      scripts\cp_mp\utility\inventory_utility::_giveweapon(self.secondaryweaponobj, undefined, undefined, 1);

      if(isDefined(self.secondaryweaponclipammo)) {
        self setweaponammoclip(self.secondaryweaponobj, self.secondaryweaponclipammo);
        self setweaponammostock(self.secondaryweaponobj, self.secondaryweaponstockammo);
      }
    }
  }

  if(!istrue(self.inlaststand)) {
    self.weaponlist = self.primaryweapons;

    if(isDefined(level.nuclear_core_carrier)) {
      if(level.nuclear_core_carrier == self) {
        var_11 = getcompleteweaponname("_encstr_91D510B0F75059CB1D1F4D760ADDDB672D1F");
        scripts\cp\utility::_giveweapon(var_11, undefined, undefined, 0);
        self switchtoweaponimmediate(var_11);
        scripts\mp\playeractions::allowactionset("_encstr_AF960A180D8A1D57633A9308", 0);
        self allowmountside(0);
        self allowmounttop(0);
        self allowjog(0);
        watchnukeweaponenduse(var_11, self.primaryweaponobj);
      } else
        scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(self.weaponlist[0]);
    } else
      scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(self.weaponlist[0]);

    if(isDefined(self.weaponlist) && self.weaponlist.size > 1) {
      if(scripts\cp\cp_weapon::iscacprimaryweapon(self.weaponlist[0].basename)) {
        var_12 = 0;

        for(var_13 = 0; var_13 < self.weaponlist.size; var_13++) {
          if(istrue(self.weaponlist[var_13].isalternate))
            continue;
          else {
            if(!var_12) {
              self.primaryweaponobj = self.weaponlist[var_13];
              var_12 = 1;
              continue;
            }

            self.secondaryweaponobj = self.weaponlist[var_13];
            break;
          }
        }
      } else {
        self.secondaryweaponobj = self.weaponlist[0];
        self.primaryweaponobj = self.weaponlist[1];
      }
    } else {
      if(isDefined(self.weaponlist) && isDefined(self.weaponlist[0]))
        self.primaryweaponobj = self.weaponlist[0];

      if(isDefined(self.weaponlist) && isDefined(self.weaponlist[1]))
        self.secondaryweaponobj = self.weaponlist[1];
    }

    if(isDefined(self.primaryweaponobj)) {
      var_14 = weaponclipsize(self.primaryweaponobj);
      var_15 = self getweaponammoclip(self.primaryweaponobj);
      var_16 = self getweaponammostock(self.primaryweaponobj);

      if(var_15 < var_14) {
        var_17 = var_14 - var_15;

        if(var_17 >= var_16) {
          var_15 = var_15 + var_16;
          var_16 = 0;
        } else {
          var_15 = var_14;
          var_16 = var_16 - var_17;
        }
      }

      self.primaryweaponclipammo = var_15;
      self.primaryweaponstockammo = var_16;

      if(isDefined(self.primaryweaponclipammo)) {
        self setweaponammoclip(self.primaryweaponobj, self.primaryweaponclipammo);
        self setweaponammostock(self.primaryweaponobj, self.primaryweaponstockammo);
      }
    }

    if(isDefined(self.secondaryweaponobj)) {
      var_14 = weaponclipsize(self.secondaryweaponobj);
      var_15 = self getweaponammoclip(self.secondaryweaponobj);
      var_16 = self getweaponammostock(self.secondaryweaponobj);

      if(var_15 < var_14) {
        var_17 = var_14 - var_15;

        if(var_17 >= var_16) {
          var_15 = var_15 + var_16;
          var_16 = 0;
        } else {
          var_15 = var_14;
          var_16 = var_16 - var_17;
        }
      }

      self.secondaryweaponclipammo = var_15;
      self.secondaryweaponstockammo = var_16;

      if(isDefined(self.secondaryweaponclipammo)) {
        self setweaponammoclip(self.secondaryweaponobj, self.secondaryweaponclipammo);
        self setweaponammostock(self.secondaryweaponobj, self.secondaryweaponstockammo);
      }
    }
  } else if(scripts\cp\cp_loadout::is_player_carrying_special_item())
    scripts\cp\cp_loadout::drop_special_item();

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.execution))
    scripts\cp_mp\execution::_giveexecution(self.operatorcustomization.execution);

  if(isDefined(level.outofboundstriggers) && level.outofboundstriggers.size > 0) {
    if(istrue(self.oob) || self.origin[2] <= -1429) {
      if(!istrue(self.binc130))
        thread scripts\cp\cp_outofbounds::playeroutoftimecallback("_encstr_BE1910DBDE89F5A3B4D6CAB7AB3A7DAC9B91", "_encstr_8A930A9BA489684B49377049");
    }
  }

  if(istrue(self.unset_relic_oneclip))
    thread _id_12DE6();

  self notify("_encstr_BD3B15285AD599F9CB3FD75C0C17C3273AE25850F22BD5");
}

_id_12DE6() {
  self.unset_relic_oneclip = undefined;
}

little_bird_mg_initdamage(var_0) {
  self endon("_encstr_AD75063D571AE108");
  thread _id_12BFA();
  self.waitgiveammo = 1;
  scripts\common\utility::allow_usability(0);
  wait(var_0);
  self.waitgiveammo = undefined;
  scripts\common\utility::allow_usability(1);
  self notify("_encstr_B88F1E18E2C35991BB01B1972067A088CB8AB341CA5B0E59171785F7440CB066");
}

_id_12BFA() {
  self endon("_encstr_B88F1E18E2C35991BB01B1972067A088CB8AB341CA5B0E59171785F7440CB066");
  scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_8CBE0BD1BED30936AB03C0B02B");
  scripts\common\utility::allow_usability(1);
  self.waitgiveammo = undefined;
}

watchnukeweaponenduse(var_0, var_1) {
  self notify("_encstr_9AB616BB16E88DA19CAB6DCABA5916E0BD372ADC32AA9BAC");
  self endon("_encstr_9AB616BB16E88DA19CAB6DCABA5916E0BD372ADC32AA9BAC");
  self notifyonplayercommand("_encstr_81D818B52C375785C6F5E6EED28E1BD0F5CCE4EDDABED8BD27AC", "_encstr_A6E60A229B175A3B48A543AB");
  thread _id_13C53();
  thread _id_13367();
  thread removenukeweapononaction("_encstr_BD6C137BA3FB838E18AB0C2FB510552F08D932F349", var_1);
  thread removenukeweapononaction("_encstr_AD75063D571AE108", var_1);
  thread removenukeweapononaction("_encstr_8CBE0BD1BED30936AB03C0B02B", var_1);
  thread watchnukeweaponswitch(var_0, var_1);
  thread _id_1196E();
  thread _id_144AF();
  self.c4_placed_bc = 1;
}

_id_13C53() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_91FF0D5DF29A896B05CBA950FF4A81");
  self notify("_encstr_872A1AEB43E7EE5BC53F95DF77BEA1218F6B41930807169863018FE5");
  self endon("_encstr_872A1AEB43E7EE5BC53F95DF77BEA1218F6B41930807169863018FE5");
  self.waittill_any_timeout_6 = self.origin;

  for(;;) {
    wait 1;

    if(scripts\cp\cp_outofbounds::isoob(self, 0)) {
      continue;
    }
    self.waittill_any_timeout_6 = self.origin;
  }
}

_id_13367() {
  self notify("_encstr_91A51B37B81570EF73AA9A0183AB38382F1AC3834BFA184C7F509068CB");
  self endon("_encstr_91A51B37B81570EF73AA9A0183AB38382F1AC3834BFA184C7F509068CB");
  scripts\cp\utility::hint_prompt("_encstr_A2B80A8C4E7BC1D7367BC92B", 1);
}

_id_1196E() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_A38711702563083D9AAFC59FFB138F50333F3B");
  self endon("_encstr_A38711702563083D9AAFC59FFB138F50333F3B");
  self endon("_encstr_91FF0D5DF29A896B05CBA950FF4A81");
  level._id_11EDF = spawnStruct();
  level._id_11EDF.origin = (0, 0, 0);
  level._id_11EDF.angles = (0, 0, 0);

  for(;;) {
    if(scripts\cp\cp_outofbounds::isoob(self, 0)) {
      waitframe();
      continue;
    }

    level._id_11EDF.origin = self.origin;
    level._id_11EDF.angles = self.angles;
    waitframe();
  }
}

_id_144AF() {
  self notify("_encstr_82011A0F5190A7DB25E2265631E206537DD5FBB1976A37EB33F518F0");
  self endon("_encstr_82011A0F5190A7DB25E2265631E206537DD5FBB1976A37EB33F518F0");
  self waittill("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(self.headicon))
    thread scripts\cp\utility::ent_deleteheadicon(self, self.headicon);

  var_0 = level._id_11EDF.origin;
  level.nuclear_core_carrier = undefined;
  level.nuclear_core = _id_11AA1(var_0 + (0, 0, 64));
}

watchnukeweaponswitch(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_91FF0D5DF29A896B05CBA950FF4A81");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_A11D16EE0B3A1B8693576DACEA56C20EB7E64DDD5AE88D34");
  self endon("_encstr_A11D16EE0B3A1B8693576DACEA56C20EB7E64DDD5AE88D34");

  for(;;) {
    self waittill("_encstr_81D818B52C375785C6F5E6EED28E1BD0F5CCE4EDDABED8BD27AC", var_2, var_3);

    if(istrue(var_3))
      self notify("_encstr_BD6C137BA3FB838E18AB0C2FB510552F08D932F349");

    if(isDefined(var_2)) {
      self takeweapon(var_1);
      self notify("_encstr_BD6C137BA3FB838E18AB0C2FB510552F08D932F349");
      continue;
    }

    if(self getcurrentweapon() != var_0) {
      continue;
    }
    self notify("_encstr_BD6C137BA3FB838E18AB0C2FB510552F08D932F349");
    break;
  }
}

removenukeweapononaction(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_91FF0D5DF29A896B05CBA950FF4A81");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8A8211E8F86AF7AB451AF0A74191D60FE6AB12");
  self notify("_encstr_8B3019CBD951755B4DDD2DAF5F3CA0030B90A54FCE6D01195F589A" + var_0);
  self endon("_encstr_8B3019CBD951755B4DDD2DAF5F3CA0030B90A54FCE6D01195F589A" + var_0);
  self waittill(var_0, var_2);

  if(var_0 == "_encstr_AD75063D571AE108") {
    return;
  }
  level.nuclear_core_carrier = undefined;

  if(isDefined(var_2))
    dropnukeweapon(var_0, var_1, var_2);
  else
    dropnukeweapon(var_0, var_1);

  self.c4_placed_bc = undefined;
}

dropnukeweapon(var_0, var_1, var_2) {
  self.mine_explosion_vfx = 1;
  self.playerstreakspeedscale = undefined;

  if(!istrue(self.c4_placed_bc) && istrue(self.inlaststand)) {
    if(!isDefined(var_1))
      var_1 = self.lastdroppableweaponobj;
  } else if(!isDefined(self.play_disguise_vo))
    scripts\mp\playeractions::allowactionset("_encstr_AF960A180D8A1D57633A9308", 1);

  if(isDefined(level.outofboundstriggers) && level.outofboundstriggers.size > 0) {
    if(istrue(self.oob)) {
      self notify("_encstr_A38711702563083D9AAFC59FFB138F50333F3B");
      level._id_11EDF.origin = getEnt("_encstr_85D215A6639239E0435A4F5B801DD3C7291A5766E9D50D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin;
      level._id_11EDF.angles = getEnt("_encstr_85D215A6639239E0435A4F5B801DD3C7291A5766E9D50D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").angles;
    }
  }

  self allowmountside(1);
  self allowmounttop(1);
  self allowjog(1);

  if(isDefined(self.headicon)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headicon);
    self.headicon = undefined;
  }

  var_3 = self.origin;

  if(scripts\cp\cp_outofbounds::isoob(self, 0))
    var_3 = level._id_11EDF.origin;

  scripts\cp\utility::hint_prompt("_encstr_A2B80A8C4E7BC1D7367BC92B", 0);
  var_4 = self getcurrentweapon();

  if(!isDefined(var_4) || var_4.basename == "_encstr_8BBA05185F8B99")
    var_4 = getcompleteweaponname("_encstr_91D510B0F75059CB1D1F4D760ADDDB672D1F");

  if(var_4.basename == "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB")
    scripts\cp_mp\utility\inventory_utility::_takeweapon(getcompleteweaponname("_encstr_91D510B0F75059CB1D1F4D760ADDDB672D1F"));
  else if(isDefined(var_2)) {
    if(issameweapon(var_2))
      scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1);
    else if(isstring(var_2))
      scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1);
  } else
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_4);

  level.nuclear_core = _id_11AA1(var_3 + (0, 0, 64));

  if(isDefined(var_2)) {
    if(issameweapon(var_2)) {
      self.lastdroppableweaponobj = var_2;
      self switchtoweaponimmediate(var_2);
    } else if(isstring(var_2)) {
      var_5 = getcompleteweaponname(var_2);
      self.lastdroppableweaponobj = var_5;
      self switchtoweaponimmediate(var_5);
    }
  } else if(isDefined(var_1)) {
    self.lastdroppableweaponobj = var_1;
    self switchtoweaponimmediate(var_1);
  }

  self.mine_explosion_vfx = undefined;
  self notify("_encstr_91FF0D5DF29A896B05CBA950FF4A81");
}

_id_11AA1(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_1 setModel("_encstr_A7C11863783150438B9BC0B9302D946991425DD25287502220B2");
  var_1 physicslaunchserver(var_1.origin, (0, 0, -1));
  var_2 = var_1 physics_getbodyid(0);
  physics_setbodycenterofmassnormal(var_2, (0, 0, -1));
  var_1 physics_registerforcollisioncallback();
  var_1 watchnukeimpact();

  if(!isDefined(var_1)) {} else {
    var_1 scripts\cp\utility::createhintobject("_encstr_A2B40B8E2C3B7DDB274B9D4B37", "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_A23A1556E2017D47AAE749AA8B89DD3FC99AD0CE8D69B3", undefined, "_encstr_82370F09B522B08D175A6876A32BC8E07B", undefined, 500, 120, 100, 120, var_1);
    var_1.objid = scripts\cp\utility::nonobjective_requestobjectiveid();
    scripts\cp\cp_objectives::minimap_objective_add(var_1.objid, "_encstr_AF5A081BBAC993AC73A3", var_1.origin, "_encstr_956215D838EB8E8536EB86AB32AFD236DE37BEE65DDA95");
    scripts\cp\cp_objectives::minimap_objective_onentitywithrotation(var_1.objid, var_1);
    scripts\cp\cp_objectives::minimap_objective_icon(var_1.objid, "_encstr_956215D838EB8E8536EB86AB32AFD236DE37BEE65DDA95");
    objective_setzoffset(var_1.objid, 32);
    objective_setbackground(var_1.objid, 1);
    objective_setshowdistance(var_1.objid, 1);
    objective_sethot(var_1.objid, 1);
    objective_setpulsate(var_1.objid, 1);
    objective_setplayintro(var_1.objid, 0);
    var_1 thread give_nuclear_core();
  }

  level notify("_encstr_91FF0D5DF29A896B05CBA950FF4A81", var_1);
  return var_1;
}

watchnukeimpact() {
  level endon("_encstr_86D808B2CDC8474396E6");
  var_0 = 1;

  for(;;) {
    self waittill("_encstr_93510A16C71B20636A2AB8B8", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    var_9 = "_encstr_AA66152FE0E3D49367871116EE23AB9DEE5897F348391C";
    var_10 = gettime();
    self notify("_encstr_AC01143363EA4BE186D3BE037F53F0FE83E713241975", var_10);

    if(var_7 < 100) {} else if(var_7 < 200) {} else if(var_7 < 300) {} else if(var_7 < 400) {} else if(var_7 > 400) {}

    if(istrue(var_0))
      var_0 = 0;
    else
      self waittill("_encstr_AC5F0F4359CFEB2738C07A0639E81F521B");

    level notify("_encstr_AC8E13D32074FD9BFA280C5852453B09A6A47F9DCB");
    level notify("_encstr_86D808B2CDC8474396E6");
  }
}

nuclear_core_delete_after_timeout() {
  self endon("_encstr_AD75063D571AE108");
  wait 60;

  if(!isDefined(self)) {
    return;
  }
  announcement("_encstr_957C53607707E33B3A175B9F27717DBEE1582310304A4965D70B016BCAFDFE4018C7FBF88F4E7AC845205DF880A09EE5E7ED28EF737389D76B2EC96DC38E15B3751DDE404198BC60430817ADD9D5E9B42459842E3E");
  level thread[[level.endgame]]("_encstr_8E8405EA382B2A", level.end_game_string_index["_encstr_BA19049B7723"]);
  self delete();
}

watcher_for_core_pickup() {
  self endon("_encstr_91FF0D5DF29A896B05CBA950FF4A81");

  for(;;) {
    self waittill("_encstr_A6251833B4DCD29BA1EB382DC6B5EA07AFDE33FADD56161CF6E6", var_0, var_1);
    scripts\cp\utility::_giveweapon(var_0);
    self notify("_encstr_BD6C137BA3FB838E18AB0C2FB510552F08D932F349", var_0);
  }
}

watchpickup() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = scripts\cp\cp_weapon::getitemweaponname();

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1, var_2);
    var_3 = undefined;

    if(isDefined(var_2))
      var_3 = var_1.lastdroppableweaponobj;
    else if(var_1.lastweaponobj.basename == "_encstr_91D510B0F75059CB1D1F4D760ADDDB672D1F") {
      var_3 = var_1.lastdroppableweaponobj;
      var_1 forcedropweapon();
      var_1 scripts\cp\utility::_giveweapon("_encstr_91D510B0F75059CB1D1F4D760ADDDB672D1F");
    } else
      var_3 = var_1 getcurrentweapon();

    var_1 thread watchpickupcomplete(self.objweapon, var_3);
    var_1 notify("_encstr_914C0EDDB20B837BB97D38D2365BAB83", self.objweapon);
    var_4 = fixupplayerweapons(var_1, var_0);

    if(isDefined(var_2) || var_4) {
      break;
    }
  }

  if(isDefined(var_2)) {
    var_5 = var_2 scripts\cp\cp_weapon::getitemweaponname();
    var_6 = asmdevgetallstates(var_5);

    if(isDefined(var_1.tookweaponfrom[var_5])) {
      var_2.owner = var_1.tookweaponfrom[var_5];
      var_1.tookweaponfrom[var_5] = undefined;
    }

    var_2.objweapon = var_6;
    var_2.targetname = "_encstr_AD580F5F2388E9EB57322E3069A1074090";
    var_2 thread watchpickup();
  }

  var_1.tookweaponfrom[var_0] = self.owner;
}

forcedropweapon(var_0) {
  if(isDefined(level.blockweapondrops)) {
    return;
  }
  if(isDefined(self.droppeddeathweapon)) {
    return;
  }
  var_1 = self.lastdroppableweaponobj;

  if(isDefined(var_0))
    var_1 = var_0;

  if(!isDefined(var_1)) {
    return;
  }
  if(var_1.basename == "_encstr_8BBA05185F8B99") {
    return;
  }
  if(!self hasweapon(var_1)) {
    return;
  }
  if(isDefined(level.gamemodemaydropweapon) && !self[[level.gamemodemaydropweapon]](var_1)) {
    return;
  }
  var_1 = var_1 getnoaltweapon();
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;

  if(!scripts\cp_mp\parachute::isriotshield_parachute(var_1.basename)) {
    if(!self anyammoforweaponmodes(var_1)) {
      return;
    }
    var_2 = self getweaponammoclip(var_1, "_encstr_8253060E2B5FE330");
    var_3 = self getweaponammoclip(var_1, "_encstr_A5AD056A019C63");

    if(!var_2 && !var_3) {
      return;
    }
    var_4 = self getweaponammostock(var_1);
    var_5 = weaponmaxammo(var_1);

    if(var_4 > var_5)
      var_4 = var_5;

    var_6 = self dropitem(var_1);

    if(!isDefined(var_6)) {
      return;
    }
    if(istrue(level.clearstockondrop))
      var_4 = 0;

    var_6 itemweaponsetammo(var_2, var_4, var_3);
  } else {
    var_6 = self dropitem(var_1);

    if(!isDefined(var_6)) {
      return;
    }
    var_6 itemweaponsetammo(1, 1, 0);
  }

  var_6 sethintdisplayrange(96);
  var_6 setuserange(96);
  var_6.owner = self;
  var_6.targetname = "_encstr_AD580F5F2388E9EB57322E3069A1074090";
  var_6.objweapon = var_1;
  var_6 thread watchpickup();
}

deletepickupafterawhile() {
  self endon("_encstr_AD75063D571AE108");
  wait 60;

  if(!isDefined(self)) {
    return;
  }
  self delete();
}

fixupplayerweapons(var_0, var_1) {
  var_2 = var_0 getweaponslistprimaries();
  var_3 = 1;
  var_4 = 1;
  var_5 = undefined;

  if(issameweapon(var_1))
    var_5 = createheadicon(var_1);
  else
    var_5 = var_1;

  foreach(var_7 in var_2) {
    if(isDefined(var_0.primaryweaponobj) && var_0.primaryweaponobj == var_7) {
      var_3 = 0;
      continue;
    }

    if(isDefined(var_0.secondaryweaponobj) && var_0.secondaryweaponobj == var_7)
      var_4 = 0;
  }

  if(var_3) {
    var_0.primaryweapon = var_5;
    var_0.primaryweaponobj = asmdevgetallstates(var_5);
  } else if(var_4) {
    var_0.secondaryweapon = var_5;
    var_0.secondaryweaponobj = asmdevgetallstates(var_5);
  }

  return var_3 || var_4;
}

watchpickupcomplete(var_0, var_1, var_2) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_956C167F17D326D8F0FCC1D8E3B8C9683A3BD1D3FB6A5B2A");
  self endon("_encstr_956C167F17D326D8F0FCC1D8E3B8C9683A3BD1D3FB6A5B2A");
  var_3 = self.currentweapon;
  var_4 = 0;

  if(var_3 == var_0)
    var_4 = 1;
  else {
    for(;;) {
      waitframe();
      var_5 = self.currentweapon;

      if(isnullweapon(var_3, var_5, 0)) {
        continue;
      }
      if(isnullweapon(var_0, var_5, 0))
        var_4 = 1;
      else
        var_4 = 0;

      break;
    }
  }

  if(var_4) {
    if(var_0.basename == "_encstr_91D510B0F75059CB1D1F4D760ADDDB672D1F")
      nuclearcorepickedup(var_0, var_1);

    thread scripts\cp\cp_weapon::notifyuiofpickedupweapon();
  }
}

nuclearcorepickedup(var_0, var_1) {
  scripts\mp\playeractions::allowactionset("_encstr_AF960A180D8A1D57633A9308", 0);
  self allowmountside(0);
  self allowmounttop(0);
  self allowjog(0);
  watchnukeweaponenduse(var_0, var_1);
}

give_nuclear_core() {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_867B12E4B32C8DE8D8101F4DFD6A83B193401377");
  self endon("_encstr_867B12E4B32C8DE8D8101F4DFD6A83B193401377");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    if(var_0 meleeButtonPressed()) {
      continue;
    }
    level.nuclear_core_carrier = var_0;

    if(var_0 hasweapon("_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB")) {
      var_0 thread scripts\cp\utility::hint_prompt("_encstr_B1F40F50CF26CBFF3B6C9E92C9B2E31197", 1, 2);
      continue;
    }

    var_1 = var_0 getcurrentweapon();
    var_2 = getcompleteweaponname("_encstr_91D510B0F75059CB1D1F4D760ADDDB672D1F");
    var_0 scripts\cp\utility::_giveweapon(var_2);
    var_0 switchtoweapon(var_2);
    var_0 scripts\mp\playeractions::allowactionset("_encstr_AF960A180D8A1D57633A9308", 0);
    var_0 allowmountside(0);
    var_0 allowmounttop(0);
    var_0 allowjog(0);
    var_0 watchnukeweaponenduse(var_2, var_1);
    var_0 thread watcher_for_core_pickup();
    var_0.headicon = var_0 thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(level.players, "_encstr_956215D838EB8E8536EB86AB32AFD236DE37BEE65DDA95", 30, 1, 29000, 29000, undefined, 1, 0, undefined, 1);

    foreach(var_4 in level.players) {
      if(var_4 == var_0) {
        continue;
      }
      if(istrue(var_4.binc130)) {
        if(istrue(level._id_11EDA))
          scripts\cp_mp\entityheadicons::_id_1315E(var_0.headicon, var_4);
        else {}

        continue;
      }

      if(istrue(level._id_11EDA)) {
        thread autofeeder(var_4, 4);
        continue;
      }

      scripts\cp_mp\entityheadicons::_id_1315E(var_0.headicon, var_4);
    }

    scripts\cp\utility::nonobjective_returnobjectiveid(self.objid);
    self delete();
  }
}

autofeeder(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait(var_1);

  if(isDefined(level.nuclear_core_carrier))
    scripts\cp_mp\entityheadicons::_id_1315D(level.nuclear_core_carrier.headicon, var_0);
}

start_automated_respawn_func() {
  level.automated_respawn_delay_skip = 1;
  wait(level.automated_respawn_delay);
  automated_respawn_sequence();
  level.automated_respawn_delay_skip = undefined;
}

automated_respawn_sequence() {
  level.respawn_uses++;
  level.respawn_in_progress = 1;
  var_0 = [];

  foreach(var_2 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_2)) {
      continue;
    }
    var_0 = scripts\engine\utility::array_add(var_0, var_2);
  }

  var_4 = scripts\engine\utility::random(var_0);
  scripts\cp\respawn\cp_ac130_respawn::start_ac130_respawn_sequence(var_4.origin, level.players_in_respawn_queue, var_4);

  foreach(var_2 in level.players) {
    var_2 thread scripts\cp\cp_hud_message::showsplash("_encstr_BAA1108D38D7EA6E5619FAC9956EC10BDDE6");
    var_2 thread toggle_respawn_functionality_after_timeout(get_respawn_cooldown());
  }

  level.respawn_in_progress = undefined;
}

show_respawn_hint_lastplayer() {
  self setclientomnvar("_encstr_970213DFDBA87265587B353E3060AD9BAF49076399", "_encstr_BDF7234B90C8E3C9D718DA520111FD5FE210C2C53673EF8B9DD1023A801BF75F9E635176CD");
  self.disabletakecoverwarning = 1;
  self setclientomnvar("_encstr_ADD1141D20997F2BD98348BF1F7B6272B7EBB91E3878", 1);
  wait 1;
  self setclientomnvar("_encstr_ADD1141D20997F2BD98348BF1F7B6272B7EBB91E3878", 2);
  wait 1;
  self setclientomnvar("_encstr_ADD1141D20997F2BD98348BF1F7B6272B7EBB91E3878", 3);
  wait 1;
  self setclientomnvar("_encstr_ADD1141D20997F2BD98348BF1F7B6272B7EBB91E3878", 4);
  wait 1;
  self setclientomnvar("_encstr_ADD1141D20997F2BD98348BF1F7B6272B7EBB91E3878", 5);
  wait 1;
  self setclientomnvar("_encstr_ADD1141D20997F2BD98348BF1F7B6272B7EBB91E3878", 0);
  self setclientomnvar("_encstr_970213DFDBA87265587B353E3060AD9BAF49076399", "_encstr_848A120FAB6B37CEC4D1C3791B28D76EB83D8582");
  self.disabletakecoverwarning = undefined;
}

show_respawn_hint() {
  thread scripts\cp\utility::hint_prompt("_encstr_A94E0D39CAB91C58EE73EB9AAED683", 1);
  scripts\engine\utility::_id_143B9(6, "_encstr_8F7D08C66A0125438523");
  self setclientomnvar("_encstr_A3AD0E1299C1C2EBD2554FF0C20D3A99", 0);
}

hotjoin_via_ac130() {
  if(!can_do_hotjoin_via_ac130()) {
    return;
  }
  if(istrue(level.dogtag_revive)) {
    return;
  }
  self.unset_relic_oneclip = 1;
  self notify("_encstr_97C91ADBABD92885316B0F314B1A43707985C1D6D3097828AA76AF81");
  var_0 = (0, 0, 0);
  var_1 = scripts\cp\respawn\cp_ac130_respawn::get_path_over_players(var_0, undefined, 1);
  thread scripts\cp\respawn\cp_ac130_respawn::spawnc130(var_1, 1, self);
  thread scripts\cp\respawn\cp_ac130_respawn::start_black_screen(self, 1);
}

can_do_hotjoin_via_ac130() {
  return !istrue(level.disable_hotjoin_via_ac130);
}

takeweaponsdefaultfunc() {
  if(isDefined(level.nuclear_core_carrier)) {
    if(level.nuclear_core_carrier == self) {
      var_0 = self getcurrentweapon();
      self takeweapon(var_0);
      self notify("_encstr_8A8211E8F86AF7AB451AF0A74191D60FE6AB12");
      scripts\mp\playeractions::allowactionset("_encstr_AF960A180D8A1D57633A9308", 1);
      self allowmountside(1);
      self allowmounttop(1);
      self allowjog(1);
      thread _id_1196E();
    }
  }

  if(isDefined(self.primaryweaponobj)) {
    self.primaryweaponclipammo = self getweaponammoclip(self.primaryweaponobj);
    self.primaryweaponstockammo = self getweaponammostock(self.primaryweaponobj);
  }

  if(isDefined(self.secondaryweaponobj)) {
    self.secondaryweaponclipammo = self getweaponammoclip(self.secondaryweaponobj);
    self.secondaryweaponstockammo = self getweaponammostock(self.secondaryweaponobj);
  }

  var_1 = getcompleteweaponname("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
  var_2 = getcompleteweaponname("_encstr_8BBA05185F8B99");
  self.weaponlist = self.primaryweapons;

  for(var_3 = 0; var_3 < self.weaponlist.size; var_3++) {
    var_4 = self.weaponlist[var_3];

    if(isDefined(var_4) && !isnullweapon(var_1, var_4) && !isnullweapon(var_2, var_4))
      self takeweapon(var_4);
  }

  self clearaccessory();

  if(!self hasweapon(var_1))
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1, undefined, undefined, 1);

  scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_1, 1);
  thread _id_14468();
}

_id_14468() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_B29B3318E72CB08773341EAD4E4ABF1B890BD0F8D7FE6895A95A19A7A0B22D46F7CF18408FAF816342858CB9BEBB2F884A77A0D0F3");
  self notify("_encstr_A5BB27130F3BE38CE1CEC7BB6F51C98E82675B7102AFB0C3D4D70D5034C70B67D6E8E738C3B75020C6");
  self endon("_encstr_A5BB27130F3BE38CE1CEC7BB6F51C98E82675B7102AFB0C3D4D70D5034C70B67D6E8E738C3B75020C6");
  self endon("_encstr_A9E113A3A845C6179835FCE5D801DF0DA9587A5B20");

  for(;;) {
    wait 1;

    if(isDefined(level.outofboundstriggers) && level.outofboundstriggers.size > 0) {
      if(self.origin[2] <= -1429) {
        if(istrue(self.binc130)) {
          continue;
        }
        self skydive_interrupt();
        self.shouldskiplaststand = 1;
        self.shouldskipdeathshield = 1;
        thread scripts\cp\cp_outofbounds::playeroutoftimecallback("_encstr_BE1910DBDE89F5A3B4D6CAB7AB3A7DAC9B91", "_encstr_8A930A9BA489684B49377049");
        self notify("_encstr_B29B3318E72CB08773341EAD4E4ABF1B890BD0F8D7FE6895A95A19A7A0B22D46F7CF18408FAF816342858CB9BEBB2F884A77A0D0F3");
      }
    }

    waitframe();
  }
}

removecameraondisconnect(var_0) {
  self endon("_encstr_9AA31537C158EEE6EB8D0BB5AC27C2D79156D895E8B223");
  self waittill("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(var_0))
    var_0 delete();
}

_id_1380A(var_0, var_1) {
  var_2 = vectorNormalize(var_0.origin - var_1.origin);
  var_3 = var_0.origin + var_2 * -8500 + (0, 0, 7000);
  var_4 = vectorNormalize(var_0.origin - var_3);
  var_5 = scripts\cp\utility::vectortoanglessafe(var_4, (0, 0, 1));
  var_6 = spawnStruct();
  var_6.origin = var_3;
  var_6.angles = var_5;
  var_7 = var_6.origin;
  var_8 = var_6.angles;
  var_9 = var_0.spawncameraent.origin;
  var_10 = vectorNormalize(var_9 - var_6.origin);
  var_11 = scripts\cp\utility::vectortoanglessafe(var_10, (0, 0, 1));
  var_0.spawncameraent.angles = var_11;
  var_12 = distance(var_9, var_7);
  var_13 = var_12 / 3520;
  var_13 = clamp(var_13, 1.5, 3.0);
  var_0.spawncameratargetpos = var_7;
  var_0.spawncameratargetang = var_8;
  var_0.spawncameratime = var_13;
  var_0.spawncameraendtime = gettime() + var_13 * 1000;
  var_0 earthquakeforplayer(0.03, 15.0, var_7, 1000);
}

startspawncamera(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\cp\utility::hideminimap(1);

  if(isai(self)) {
    return;
  }
  if(istrue(self.inmhccam)) {
    return;
  }
  if(istrue(level.gameended)) {
    return;
  }
  self.inmhccam = 1;
  thread _id_12768(0.0, 0.25, 0.25);
  waitframe();
  scripts\engine\utility::_id_143BF(0.1, "_encstr_A3D50C33DE93B159EBCD1CB0DDB9");
  var_1 = self getEye();
  var_2 = self.angles;
  self.deathspectatepos = var_1;
  self.deathspectateangles = var_2;

  if(!isDefined(self.spawncameraent)) {
    var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.deathspectatepos);
    var_3 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_3.angles = self.deathspectateangles;
    self.spawncameraent = var_3;
    self playerlinkTo(self.spawncameraent);
  } else {
    self.spawncameraent.origin = self.deathspectatepos;
    self.spawncameraent.angles = self.deathspectateangles;
  }

  thread removecameraondisconnect(self.spawncameraent);
  self cameralinkTo(self.spawncameraent, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1, 1);
  snaptospawncamera(var_0);
}

entitylerpovertime(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("_encstr_AD75063D571AE108");

  if(var_3 <= 0)
    var_3 = 1;

  var_5 = 1.0 / (var_3 / 0.05);
  var_6 = 0.0;
  var_7 = var_0.origin;
  var_8 = var_0.angles;

  if(var_4 == 2)
    level.c130 notify("_encstr_952516A2BB02B885630331535BAFD76F5D573FCF8D7FB6B8");

  while(var_6 < 1.0) {
    var_9 = vectorlerp(var_7, var_1, var_6);
    var_10 = scripts\engine\math::fake_slerp(var_8, var_2, var_6);

    if(isPlayer(var_0) || isagent(var_0)) {
      var_0 setOrigin(var_9, 1);
      var_0 setplayerangles(var_10);
    } else {
      var_0.origin = var_9;
      var_0.angles = var_10;
    }

    var_6 = var_6 + var_5;
    waitframe();
  }

  if(isPlayer(var_0) || isagent(var_0)) {
    var_0 setOrigin(var_1, 1);
    var_0 setplayerangles(var_2);
  } else {
    var_0.origin = var_1;
    var_0.angles = var_2;
  }
}

get_lerped_origin(var_0, var_1, var_2) {
  return vectorlerp(var_0, var_1, var_2);
}

get_fake_slerped_angles(var_0, var_1, var_2) {
  return scripts\engine\math::fake_slerp(var_0, var_1, var_2);
}

_id_12768(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = "_encstr_83AB065EE1391A7B";

  var_4 = newclienthudelem(self);
  var_4.x = 0;
  var_4.y = 0;
  var_4.alignx = "_encstr_A5AD056A019C63";
  var_4.aligny = "_encstr_AC190479FF92";
  var_4.sort = 1;
  var_4.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_4.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_4.foreground = 1;

  if(isDefined(var_0) && var_0 > 0)
    var_4.alpha = 0;
  else
    var_4.alpha = 1;

  var_4 setshader(var_3, 640, 480);

  if(isDefined(var_0) && var_0 > 0) {
    self notify("_encstr_B60B0FCA9A60EFF8603C7D2137E1E7EBA9");
    var_4 fadeovertime(var_0);
    var_4.alpha = 1.0;
    wait(var_0);
    self notify("_encstr_846A12C7CB49F517D04F68A71A88850BD5F8BB35");
  }

  if(isDefined(var_1) && var_1 > 0)
    wait(var_1);

  self notify("_encstr_867E0DE2A9B51FDB1027D3DC7328DB");

  if(!isDefined(var_2))
    var_2 = 0.5;

  var_4 fadeovertime(var_2);
  var_4.alpha = 0.0;
  wait(var_2);
  self notify("_encstr_B43C108731387D4137B78F472BDF1AB56019");

  if(isDefined(var_4))
    var_4 destroy();
}

snaptospawncamera(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_867E0DE2A9B51FDB1027D3DC7328DB");
  var_1 = var_0;
  self.spawncameraent.origin = var_1.origin;
  self.spawncameraent.angles = var_1.angles;
  self visionsetnakedforplayer("_encstr_B40101", 0);
  applythermal();

  if(isDefined(self) && isDefined(self.spawncameraent)) {
    var_2 = anglesToForward(self.spawncameraent.angles) * 300;
    var_2 = var_2 * (1, 1, 0);
    self.spawncameraent moveTo(self.spawncameraent.origin + var_2, 15.0, 1.0, 1.0);
    self earthquakeforplayer(0.03, 15.0, self.spawncameraent.origin, 1000);
  }

  self cameraunlink();
  self notify("_encstr_883D12A03B66AF883733E7E90DBB5137CCE2D0E8");
}

runslamzoomonspawn(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  thread scripts\cp\utility::drawline(self.spawncameraent.origin, self.origin, 100000.0, (1, 0, 0));
  self cameralinkTo(self.spawncameraent, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1, 1);
  handlemovetoblended(var_0);
}

deletespawncamera() {
  self cameraunlink();

  if(isDefined(self.spawncameraent))
    self.spawncameraent delete();

  self notify("_encstr_9AA31537C158EEE6EB8D0BB5AC27C2D79156D895E8B223");
}

handlemovetoblended(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = var_0.origin + (0, 0, 60);
  var_2 = var_0.angles;
  var_3 = angle_diff(self.spawncameraent.angles[1], var_2[1]) < 45;
  var_4 = distance2dsquared(self.spawncameraent.origin, var_1) > 1000000;

  if(!var_3 || !var_4) {
    removethermal();
    self visionsetnakedforplayer("_encstr_B40101", 0);
    wait 0.05;
    self.spawncameraent moveTo(var_1, 1.0, 0.1, 0.9);
    self.spawncameraent rotateTo(var_2, 1.0, 0.9, 0.1);
    self visionsetnakedforplayer("_encstr_9A591141C97E59285BA366EBBAF7D188952FEB", 0.8);
    wait 0.8;
    self visionsetnakedforplayer("_encstr_B40101", 0.2);
    wait 0.2;
  } else {
    var_5 = vectorNormalize(var_1 - self.spawncameraent.origin);
    var_6 = scripts\cp\utility::vectortoanglessafe(var_5, (0, 0, 1));
    self.spawncameraent rotateTo(var_6, 0.7, 0.2, 0.2);
    removethermal();
    self visionsetnakedforplayer("_encstr_B40101", 0);
    wait 0.05;
    self.spawncameraent moveTo(var_1, 1.0, 0.1, 0.9);
    self visionsetnakedforplayer("_encstr_9A591141C97E59285BA366EBBAF7D188952FEB", 0.8);
    wait 0.5;
    self.spawncameraent rotateTo(var_2, 0.5, 0.2, 0.1);
    wait 0.3;
    self visionsetnakedforplayer("_encstr_B40101", 0.2);
  }

  self notify("_encstr_A2FB163B03BFCF8DE1E7495DF3D01627D698529328051B87");
}

angle_diff(var_0, var_1) {
  return 180 - abs(abs(var_0 - var_1) - 180);
}

applythermal() {
  self visionsetthermalforplayer("_encstr_B60A15ABAB38AB4AE13741AE77D9F75F8D4AC4EE815F1A");
  self thermalvisionon();
}

removethermal() {
  self thermalvisionoff();
}

play_mhc_plane_escape_skit() {
  self freezecontrols(1);
  self playerhide();
  camera_setup_for_lerping();
  self visionsetnakedforplayer("_encstr_9A591141C97E59285BA366EBBAF7D188952FEB", 0.8);

  for(var_0 = 0; var_0 < level.mhc_escape_ents_array.size; var_0++)
    entitylerpovertime(self.spawncameraent, level.mhc_escape_ents_array[var_0].origin + (0, 0, 64), level.mhc_escape_ents_array[var_0].angles, 1 - var_0 * 0.25, var_0);

  self visionsetnakedforplayer("_encstr_B40101", 1);
  deletespawncamera();
  self unlink();
  self playershow();
}

delay_giving_controls_back() {
  wait 10;
  self freezecontrols(0);
}

create_mhc_path() {
  var_0 = getEnt("_encstr_ABF211C73019274A4331D70A2F1783B4E1483B", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_1 = [var_0];

  while(isDefined(var_0.target)) {
    var_0 = getEnt(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_0.script_linkto)) {
      var_2 = [var_0];
      var_3 = var_0 scripts\engine\utility::get_linked_structs();
      var_1[var_1.size] = scripts\engine\utility::array_combine(var_2, var_3);
      continue;
    }

    var_1[var_1.size] = var_0;
  }

  return var_1;
}

camera_setup_for_lerping(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isai(var_0)) {
    return;
  }
  if(istrue(var_0.inmhccam)) {
    return;
  }
  if(istrue(level.gameended)) {
    return;
  }
  var_0.inmhccam = 1;
  var_0.deathspectatepos = var_1.origin;
  var_0.deathspectateangles = var_1.angles;

  if(!isDefined(var_0.spawncameraent)) {
    var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.deathspectatepos);
    var_2 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_2.angles = var_0.deathspectateangles;
    var_0.spawncameraent = var_2;
    var_0 playerlinkTo(var_0.spawncameraent);
  } else {
    var_0.spawncameraent.origin = var_0.deathspectatepos;
    var_0.spawncameraent.angles = var_0.deathspectateangles;
  }

  var_0 thread removecameraondisconnect(var_0.spawncameraent);
  var_0 cameralinkTo(var_0.spawncameraent, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1, 1);
  var_0 thread _id_12768(0.0, 1, 0.25, "_encstr_83AB065EE1391A7B");
  var_3 = vectorNormalize(var_0.origin - var_1.origin);
  var_4 = var_0.origin + var_3 * -8500 + (0, 0, 7000);
  var_5 = vectorNormalize(var_0.origin - var_4);
  var_6 = scripts\cp\utility::vectortoanglessafe(var_5, (0, 0, 1));
  var_7 = spawnStruct();
  var_7.origin = var_4;
  var_7.angles = var_6;
  var_8 = var_7.origin;
  var_9 = var_7.angles;
  var_10 = var_0.spawncameraent.origin;
  var_11 = vectorNormalize(var_10 - var_7.origin);
  var_12 = scripts\cp\utility::vectortoanglessafe(var_11, (0, 0, 1));
  var_0.spawncameraent.angles = var_12;
  var_13 = distance(var_10, var_8);
  var_14 = var_13 / 3520;
  var_14 = clamp(var_14, 1.5, 3.0);
  var_0.spawncameratargetpos = var_8;
  var_0.spawncameratargetang = var_9;
  var_0.spawncameratime = var_14;
  var_0.spawncameraendtime = gettime() + var_14 * 1000;
  var_0 earthquakeforplayer(0.03, 15.0, var_8, 1000);
  var_0.spawncameraent moveTo(var_8, 1.0, 0.25, 0.75);
  var_0.spawncameraent rotateTo(var_9, 1.0, 0.25, 0.75);
  wait 1.0;
  var_0 thread _id_12768(0.0, 0.25, 0.25);
  var_0 applythermal();
  var_0 thread startoperatorsound();

  if(isDefined(var_0) && isDefined(var_0.spawncameraent)) {
    var_15 = anglesToForward(var_9) * 300;
    var_15 = var_15 * (1, 1, 0);
    var_0.spawncameraent moveTo(var_1.origin + var_15, 15.0, 1.0, 1.0);
    var_0 earthquakeforplayer(0.03, 15.0, var_1.origin, 1000);
  }

  wait 1;
  var_0 removethermal();
  var_0 visionsetnakedforplayer("_encstr_B40101", 0);
  var_0 deletespawncamera();
  var_0.inmhccam = undefined;
}

startoperatorsound() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9B1D0BC7932875276230426AA1");

  if(istrue(self.spawnselectionoperatorsound)) {
    return;
  }
  var_0 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));
  var_0 showonlytoplayer(self);
  self setsoundsubmix("_encstr_AF5F144BBBE0FAAD83FA37E02CBB37AF3658AD959C85");
  var_1 = scripts\cp\cp_player_battlechatter::getteamvoiceinfix(self.team);
  var_2 = "_encstr_84690847F92EFD1AD01F" + var_1 + "_encstr_A19F1655B72FD2EA70D03FCF9869B19B39461C4E1DD11A12";

  if(soundexists(var_2))
    var_0 playLoopSound(var_2);
  else
    var_0 playLoopSound("_encstr_BAD81F70790955381FE60302588397F4CB12C85F7712BA1FD8096A7AC0EBE36043");

  self.spawnselectionoperatorsound = 1;
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  self clearsoundsubmix("_encstr_AF5F144BBBE0FAAD83FA37E02CBB37AF3658AD959C85");
  var_0 stoploopsound(var_2);
  var_0 delete();
  self.spawnselectionoperatorsound = 0;
}