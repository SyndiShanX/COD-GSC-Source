/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\utility\infilexfil.gsc
***********************************************/

getinfilpath(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_1)) {
    return;
  }
  foreach(var_3 in var_1) {
    if(istrue(level.interactiveinfil)) {
      if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "_encstr_AA010C9063AC7935DA1E850333F2")
        return var_3;
    } else if(!isDefined(var_3.script_noteworthy) || var_3.script_noteworthy != "_encstr_AA010C9063AC7935DA1E850333F2")
      return var_3;
  }
}

player_unlink(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;

  if(var_1 islinked())
    var_1 unlink();
}

player_free_look(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;

  if(var_1 islinked())
    var_1 lerpviewangleclamp(0, 0, 0, 45, 45, 45, 45);
}

player_fov_80_instant(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;

  var_1 lerpfovbypreset("_encstr_82300B7081FA4BE6E6D10BB9E8");
}

_id_12497(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;

  var_1 lerpfovbypreset("_encstr_8E420DE9EDDA98B4AC16C936162359");
}

player_fov_default_2(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;

  var_1 lerpfovbypreset("_encstr_BA79117D172A8BEB2CEBC9BAEF7D61DF12FF6E");
}

player_lock_look_1_second(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;

  if(var_1 islinked())
    var_1 lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
}

player_lock_look_2_second(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;

  if(var_1 islinked())
    var_1 lerpviewangleclamp(2, 0.5, 0.5, 0, 0, 0, 0);
}

player_lock_look_instant(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;

  if(var_1 islinked())
    var_1 lerpviewangleclamp(0, 0, 0, 0, 0, 0, 0);
}

rumble_low(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;

  var_1 thread updateshakeonplayer(undefined, undefined, undefined, undefined, undefined, "_encstr_A27F0B27D879C7BB4B1136AD0D", 0.05, 0.1);
}

cam_shake_low(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;

  var_1 thread updateshakeonplayer(0.06, 0.075, 2, var_1.origin, 8000, "_encstr_A27F0B27D879C7BB4B1136AD0D", 0.05, 0.1);
}

cam_shake_running(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;

  var_1 thread updateshakeonplayer(0.09, 0.115, 2, var_1.origin, 8000, undefined, 0.15, 0.5);
}

cam_shake_parked(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;

  var_1 thread updateshakeonplayer(0.065, 0.09, 0.5, var_1.origin, 8000, undefined, 0.15, 0.5);
}

cam_shake_off(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;

  var_1 notify("_encstr_BA690F0390EF325749AF754FBEF0773C13");
}

updateshakeonplayer(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(istrue(level.interactiveinfil) && istrue(self.interactivecombat)) {
    return;
  }
  self notify("_encstr_BA690F0390EF325749AF754FBEF0773C13");
  self endon("_encstr_BA690F0390EF325749AF754FBEF0773C13");
  level endon("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  level endon("_encstr_A3860BD065664831F983C7FDBF");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  while(isDefined(self)) {
    if(isDefined(var_0) && isDefined(var_1))
      self earthquakeforplayer(randomfloatrange(var_0, var_1), var_2, var_3, var_4);

    if(isDefined(var_5))
      self playrumbleonpositionforclient(var_5, self.origin);

    wait(randomfloatrange(var_6, var_7));
  }
}

hideactors() {
  if(!isDefined(self.actors)) {
    return;
  }
  foreach(var_1 in self.actors)
  var_1 hide();
}

showactors() {
  if(!isDefined(self.actors)) {
    return;
  }
  foreach(var_1 in self.actors)
  var_1 show();
}

setcinematicmotion_heli(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;

  var_1 setcinematicmotionoverride("_encstr_A3FA119934268978BB01837A036FE9D3E4CC50");
}

setcinematicmotion_playermotion(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;

  var_1 setcinematicmotionoverride("_encstr_966114C11CA2DF8241981BD2E8ABBD8B60885E7FB9F3");
}

setcinematicmotion_disabled(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;

  var_1 setcinematicmotionoverride("_encstr_921D09D9D9C0090D7275B4");
}

set_cinematicmotionomnvaroverrides(var_0) {
  self setclientomnvar("_encstr_B6642BFBBB88698B7DD34D17AE6ACA81A8772105F5C8CF70D45D68EEAA0FA3F5F605CF506860448A22CD4B37CF", var_0);
  self setclientomnvar("_encstr_B4152BD0820D519037C49D18A34F782B72EAF188DA2393EBDFFF9010AE57A1C791B2F880313DE5819B0A2BF595", var_0);
  self setclientomnvar("_encstr_8F852E4358DC3234AC8D8CD76C165B59C9C2EBA3C9589B6E8D2CD196F6CDAFB6B767CA7DD67B32AFB7D9B2C9C9B423CA", var_0);
  self setclientomnvar("_encstr_86D22E481E26687B02EBA9D7FF6A31B8D2F65643429170AEEAC7B1A337421068914FDBBE2DF79870F2F39B9D6B5AC508", var_0);
}

set_cinematicmotionomnvarovertime(var_0, var_1, var_2) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_3 = gettime();
  var_2 = var_2 * 1000;
  var_4 = int(var_3 + var_2);
  var_5 = abs(var_0 - var_1);

  for(;;) {
    var_3 = gettime();
    var_6 = clamp(1.0 - (var_4 - var_3) / var_2, 0.0, 1.0);
    var_7 = scripts\engine\utility::ter_op(var_0 < var_1, var_5 * var_6 + var_0, var_0 - var_5 * var_6);
    set_cinematicmotionomnvaroverrides(var_7);

    if(var_6 == 1.0) {
      break;
    }

    waitframe();
  }
}

setcinematicmotion_omnvaroverride_max_instant(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;

  var_1 set_cinematicmotionomnvaroverrides(1.0);
}

setcinematicmotion_omnvaroverride_max_1(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;

  var_1 thread set_cinematicmotionomnvarovertime(0.0, 1.0, 1.0);
}

setcinematicmotion_omnvaroverride_max_2(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;

  var_1 thread set_cinematicmotionomnvarovertime(0.0, 1.0, 2.0);
}

setcinematicmotion_omnvaroverride_max_3(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;

  var_1 thread set_cinematicmotionomnvarovertime(0.0, 1.0, 3.0);
}

setcinematicmotion_omnvaroverride_max_4(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;

  var_1 thread set_cinematicmotionomnvarovertime(0.0, 1.0, 4.0);
}

setcinematicmotion_omnvaroverride_max_5(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;

  var_1 thread set_cinematicmotionomnvarovertime(0.0, 1.0, 5.0);
}

setcinematicmotion_omnvaroverride_min_instant(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;

  var_1 set_cinematicmotionomnvaroverrides(0.0);
}

setcinematicmotion_omnvaroverride_min_1(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;

  var_1 thread set_cinematicmotionomnvarovertime(1.0, 0.0, 1.0);
}

setcinematicmotion_omnvaroverride_min_2(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;

  var_1 thread set_cinematicmotionomnvarovertime(1.0, 0.0, 2.0);
}

setcinematicmotion_omnvaroverride_min_3(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;

  var_1 thread set_cinematicmotionomnvarovertime(1.0, 0.0, 3.0);
}

setcinematicmotion_omnvaroverride_min_4(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;

  var_1 thread set_cinematicmotionomnvarovertime(1.0, 0.0, 4.0);
}

setcinematicmotion_omnvaroverride_min_5(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;

  var_1 thread set_cinematicmotionomnvarovertime(1.0, 0.0, 5.0);
}

player_equip_nvg(var_0) {
  if(!scripts\cp_mp\utility\game_utility::isnightmap()) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;

  var_1 nightvisionviewon();
}

getgroundcompensationheight(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;

  var_2 = var_1.origin[2];
  var_3 = scripts\engine\trace::create_solid_ai_contents(1);
  var_4 = var_1.origin + (0, 0, 12);
  var_5 = var_1.origin - (0, 0, 24);
  var_6 = scripts\engine\trace::player_trace(var_4, var_5, var_1.angles, [var_1, var_1.infil.linktoent], var_3)["_encstr_BD260953AA97E3F014279D"];
  var_7 = var_6[2];
  var_1.infilheightcompensation = var_7 - var_2;
}

compensatetoground() {
  level endon("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 = 0.0;
  self.personalscenenode unlink();

  while(isDefined(self.personalscenenode)) {
    getgroundcompensationheight(self.player_rig);
    var_1 = (self.personalscenenode.origin[0], self.personalscenenode.origin[1], self.personalscenenode.origin[2] + self.infilheightcompensation);

    if(abs(var_0 - self.infilheightcompensation) > 0.01) {
      var_0 = self.infilheightcompensation;
      self.personalscenenode moveTo(var_1, 0.25, 0.05, 0.2);
    }

    waitframe();
  }
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");

infil_player_rig_updated(var_0, var_1, var_2) {
  self.animname = var_0;

  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  if(!isDefined(var_2))
    var_2 = (0, 0, 0);

  self predictstreampos(var_1);
  var_3 = spawn("_encstr_BEFE0C2FAB5A88876B4181EB4A5F", var_1, 0, 0, self);
  var_3.angles = var_2;
  var_3.player = self;
  self.player_rig = var_3;
  self.player_rig hide(1);
  self.player_rig.animname = var_0;
  self.player_rig useanimtree(#animtree);
  self.player_rig.updatedversion = 1;
  self.player_rig.weapon_state_func = ::handleweaponstatenotetrack;
  self.player_rig.cinematic_motion_override = ::handlecinematicmotionnotetrack;
  self.player_rig.dof_func = ::handledofnotetrack;
  self playerlinktodelta(self.player_rig, "_encstr_8E010B996FB7B6B3C1D1183343", 1.0, 0, 0, 0, 0, 1);
  self notify("_encstr_A9920CF579D7F1B6CBAAD963B24B");
  scripts\engine\utility::_id_143A5("_encstr_BE840BF2FFD8B0A4DB6EE31FA1", "_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");

  if(istrue(level.gameended)) {
    return;
  }
  if(isDefined(self)) {
    self unlink();
    thread takegunless();
  }

  if(isDefined(var_3))
    var_3 delete();
}

handledofnotetrack(var_0) {
  if(!isDefined(self) || !isDefined(self.player)) {
    return;
  }
  switch (var_0) {
    case "_encstr_B6910F7DD4ECD81FD732501BDA4BC310C2":
      self.player enablephysicaldepthoffieldscripting();

      switch (self.animname) {
        case "_encstr_A2FF07DB605823217A":
          self.player setphysicaldepthoffield(1.8, 40, 20, 20);
          break;
        case "_encstr_95FF079B8D7B1DFA4C":
          self.player setphysicaldepthoffield(1.8, 60, 20, 20);
          break;
        case "_encstr_BAFF07CD367B1DD791":
          self.player setphysicaldepthoffield(1.9, 50, 20, 20);
          break;
      }

      break;
    case "_encstr_B1D80B83D1B3D2610159F0BC53":
      self.player enablephysicaldepthoffieldscripting();
      self.player setphysicaldepthoffield(2.8, 500, 4, 4);
      break;
    case "_encstr_A9040F8BD7F2D2402F2CB00BD7EAE8189B":
      self.player enablephysicaldepthoffieldscripting();

      switch (self.animname) {
        case "_encstr_A2FF07DB605823217A":
          self.player setphysicaldepthoffield(2.4, 50, 20, 20);
          break;
        case "_encstr_95FF079B8D7B1DFA4C":
          self.player setphysicaldepthoffield(2.4, 50, 20, 20);
          break;
        case "_encstr_BAFF07CD367B1DD791":
          self.player setphysicaldepthoffield(2.4, 50, 20, 20);
          break;
        case "_encstr_B1FF077B0D77B8B017":
          self.player setphysicaldepthoffield(2.4, 50, 20, 20);
          break;
        case "_encstr_A6FF0747907B08963F":
          self.player setphysicaldepthoffield(2.4, 50, 20, 20);
          break;
        case "_encstr_B2FF07CB61C0A3BF5D":
          self.player setphysicaldepthoffield(2.4, 50, 20, 20);
          break;
      }

      break;
    case "_encstr_BAD40B730A7F62F819AD316BC4":
      self.player enablephysicaldepthoffieldscripting();
      self.player setphysicaldepthoffield(2.8, 500, 4, 4);
      break;
    case "_encstr_97B80D7BA868F73A6D8DE75A7B07C3":
      self.player enablephysicaldepthoffieldscripting();

      switch (self.animname) {
        case "_encstr_A2FF07DB605823217A":
          self.player setphysicaldepthoffield(2.1, 40, 20, 20);
          break;
        case "_encstr_95FF079B8D7B1DFA4C":
          self.player setphysicaldepthoffield(2.1, 40, 20, 20);
          break;
        case "_encstr_BAFF07CD367B1DD791":
          self.player setphysicaldepthoffield(2.1, 40, 20, 20);
          break;
        case "_encstr_B1FF077B0D77B8B017":
          self.player setphysicaldepthoffield(2.1, 40, 20, 20);
          break;
        case "_encstr_A6FF0747907B08963F":
          self.player setphysicaldepthoffield(2.3, 60, 20, 20);
          break;
        case "_encstr_B2FF07CB61C0A3BF5D":
          self.player setphysicaldepthoffield(2.3, 60, 20, 20);
          break;
      }

      break;
    case "_encstr_86ED097B63A869FD50A09B":
      self.player enablephysicaldepthoffieldscripting();
      self.player setphysicaldepthoffield(2.8, 500, 4, 4);
      break;
  }
}

handlecinematicmotionnotetrack(var_0) {
  if(!isDefined(self) || !isDefined(self.player)) {
    return;
  }
  var_1 = getsubstr(var_0, 0, 4);

  if(var_1 == "_encstr_8E1805A37D43B7") {
    var_2 = getsubstr(var_0, 4);
    self.player setcinematicmotionoverride(var_2);
    return;
  }

  switch (var_0) {
    case "_encstr_BE880CEDFE70A82BCDEB233F801C":
      setcinematicmotion_omnvaroverride_max_instant(self);
      break;
    case "_encstr_BEA40658B748C64B":
      setcinematicmotion_omnvaroverride_max_1(self);
      break;
    case "_encstr_BDA406134F4B6042":
      setcinematicmotion_omnvaroverride_max_2(self);
      break;
    case "_encstr_82A406403A308F53":
      setcinematicmotion_omnvaroverride_max_3(self);
      break;
    case "_encstr_ACA4063839517E3D":
      setcinematicmotion_omnvaroverride_max_4(self);
      break;
    case "_encstr_91A4060BB1D0315D":
      setcinematicmotion_omnvaroverride_max_5(self);
      break;
    case "_encstr_ABB20CB59673BE96379BA3B037D1":
      setcinematicmotion_omnvaroverride_min_instant(self);
      break;
    case "_encstr_BE62061F8BD85896":
      setcinematicmotion_omnvaroverride_min_1(self);
      break;
    case "_encstr_8E62064FC8A3A846":
      setcinematicmotion_omnvaroverride_min_2(self);
      break;
    case "_encstr_B862068DF8A08FFF":
      setcinematicmotion_omnvaroverride_min_3(self);
      break;
    case "_encstr_AC6206E02FE66EE9":
      setcinematicmotion_omnvaroverride_min_4(self);
      break;
    case "_encstr_91620615543B516F":
      setcinematicmotion_omnvaroverride_min_5(self);
      break;
  }
}

handleweaponstatenotetrack(var_0) {
  if(!isDefined(self) || !isDefined(self.player)) {
    return;
  }
  switch (var_0) {
    case "_encstr_84660547ED28E0":
      self.player setdemeanorviewmodel("_encstr_820E07FAE8780B3A4C");
      self.player scripts\engine\utility::ent_flag_init("_encstr_9AB914B977C2C131DE0B8CDEAB1DF5C4B1B71BD6B223");
      self.player scripts\engine\utility::ent_flag_init("_encstr_A939144BAF46E088EA019B2FA56B712B4F109F346317");
      self.player scripts\engine\utility::ent_flag_init("_encstr_922615F7247E402C077F234875145F70E5F3EB80E8C46B");
      self.player scripts\engine\utility::ent_flag_set("_encstr_9AB914B977C2C131DE0B8CDEAB1DF5C4B1B71BD6B223");
      self.player thread has_relic_amped_victim_survived_time();

      if(!isai(self.player))
        self.player givegunless();

      if(istrue(self.updatedversion))
        self showonlytoplayer(self.player);

      self.player scripts\common\utility::allow_reload(0);
      break;
    case "_encstr_A3110693D34B8A30":
      if(isDefined(self.player.infilweapon) && self.player hasweapon(self.player.infilweapon))
        self.player scripts\cp_mp\utility\inventory_utility::_takeweapon(self.player.infilweapon);

      self.player.stopchallengetimers = 1;

      if(self.player scripts\engine\utility::ent_flag_exist("_encstr_9AB914B977C2C131DE0B8CDEAB1DF5C4B1B71BD6B223") && self.player scripts\engine\utility::ent_flag("_encstr_9AB914B977C2C131DE0B8CDEAB1DF5C4B1B71BD6B223"))
        self.player scripts\engine\utility::ent_flag_clear("_encstr_9AB914B977C2C131DE0B8CDEAB1DF5C4B1B71BD6B223");

      self.player setdemeanorviewmodel("_encstr_820E07FAE8780B3A4C");

      if(!istrue(self.updatedversion))
        self.player stopviewmodelanim();

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_9A3518F86AC669487FC4188CA16BF131ACA33899621EB9803BEB"))
        self.player[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_9A3518F86AC669487FC4188CA16BF131ACA33899621EB9803BEB")]]();

      if(!isai(self.player))
        self.player takegunless();

      if(istrue(self.updatedversion) && self.player islinked())
        self.player playerlinkedsetforceparentvisible(0);

      if(!self.player scripts\common\utility::is_reload_allowed())
        self.player scripts\common\utility::allow_reload(1);

      break;
    case "_encstr_B418059B8533CA":
      self.player setdemeanorviewmodel("_encstr_B418059B8533CA", "_encstr_A975161B174F60E8BD020E61AF6D20A7C28FA5EFAF62B4B0");
      break;
    case "_encstr_820E07FAE8780B3A4C":
      self.player setdemeanorviewmodel("_encstr_820E07FAE8780B3A4C");
      break;
    case "_encstr_BD78059C33C543":
      self.player scripts\common\utility::allow_fire(1);
      self.player scripts\common\utility::allow_ads(1);

      if(!self.player scripts\common\utility::is_reload_allowed())
        self.player scripts\common\utility::allow_reload(1);

      break;
    case "_encstr_B6CC0586B78D46":
      self.player scripts\common\utility::allow_fire(0);
      self.player scripts\common\utility::allow_ads(0);

      if(!self.player scripts\common\utility::is_reload_allowed())
        self.player scripts\common\utility::allow_reload(0);

      break;
  }
}

has_relic_amped_victim_survived_time() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\engine\utility::waittill_any_ents(self, "_encstr_AD75063D571AE108", level, "_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  scripts\engine\utility::ent_flag_clear("_encstr_9AB914B977C2C131DE0B8CDEAB1DF5C4B1B71BD6B223", 1);
  scripts\engine\utility::ent_flag_clear("_encstr_A939144BAF46E088EA019B2FA56B712B4F109F346317", 1);
  scripts\engine\utility::ent_flag_clear("_encstr_922615F7247E402C077F234875145F70E5F3EB80E8C46B", 1);
}

takegunless() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(!isDefined(self.gunnlessweapon) || !self hasweapon(self.gunnlessweapon)) {
    return;
  }
  if(scripts\engine\utility::ent_flag_exist("_encstr_A939144BAF46E088EA019B2FA56B712B4F109F346317") && scripts\engine\utility::ent_flag("_encstr_A939144BAF46E088EA019B2FA56B712B4F109F346317"))
    scripts\engine\utility::ent_flag_wait("_encstr_922615F7247E402C077F234875145F70E5F3EB80E8C46B");

  if(!scripts\common\utility::is_script_weapon_switch_allowed())
    scripts\common\utility::allow_script_weapon_switch(1);

  while(self hasweapon(self.gunnlessweapon)) {
    if(!scripts\cp_mp\utility\inventory_utility::iscurrentweapon(self.gunnlessweapon))
      scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(self.gunnlessweapon);
    else {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self.gunnlessweapon);
      scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
    }

    waitframe();
  }

  self.gunnlessweapon = undefined;
  scripts\common\utility::allow_script_weapon_switch(0);
}

givegunless() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isDefined(self.gunnlessweapon)) {
    return;
  }
  var_0 = getcompleteweaponname("_encstr_962A124B7707BE76EADC1B566EDCFA5A3799A5C6");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0, undefined, undefined, 1);

  if(!scripts\common\utility::is_script_weapon_switch_allowed())
    scripts\common\utility::allow_script_weapon_switch(1);

  var_1 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 0);

  if(var_1)
    self.gunnlessweapon = var_0;
  else {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
    scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
  }

  scripts\common\utility::allow_script_weapon_switch(0);
  return var_1;
}