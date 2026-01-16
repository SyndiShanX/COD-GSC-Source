/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\equipment\phase_shift.gsc
************************************************/

init() {
  level._effect["vfx_phase_shift_trail_friendly"] = loadfx("vfx\iw7\_requests\mp\vfx_phase_shift_body_fr.vfx");
  level._effect["vfx_phase_shift_trail_enemy"] = loadfx("vfx\iw7\_requests\mp\vfx_phase_shift_body_en.vfx");
  level._effect["vfx_screen_flash"] = loadfx("vfx\core\mp\core\vfx_screen_flash");
}

func_E154(var_0) {
  if(scripts\mp\utility::istrue(self.phaseshift_active)) {
    if(!scripts\mp\utility::istrue(var_0)) {
      if(scripts\mp\utility::_hasperk("specialty_ftlslide")) {
        if(scripts\mp\utility::isanymlgmatch() && level.tactical) {
          self setsuit("assassin_mlgslide_mp_tactical");
        } else if(scripts\mp\utility::isanymlgmatch()) {
          self setsuit("assassin_mlgslide_mp");
        } else if(level.tactical) {
          self setsuit("assassin_slide_mp_tactical");
        } else {
          self setsuit("assassin_slide_mp");
        }
      } else {
        self setsuit("assassin_mp");
      }

      if(scripts\mp\utility::istrue(self.phaseshift_removedtracker)) {
        scripts\mp\utility::giveperk("specialty_tracker");
      }

      scripts\mp\utility::removeperk("specialty_blindeye");
      scripts\mp\utility::removeperk("specialty_radarringresist");
      scripts\engine\utility::allow_offhand_weapons(1);
      scripts\engine\utility::allow_usability(1);
      scripts\mp\utility::func_1C47(1);
      self.var_38ED = 1;
      self setscriptablepartstate("compassicon", "defaulticon", 0);
      scripts\mp\utility::func_8ECC();
      self playlocalsound("ftl_phase_in");
      self playSound("ftl_phase_in_npc");
      self visionsetnakedforplayer("", 0.1);
    } else {
      self visionsetnakedforplayer("", 0);
    }

    self clearclienttriggeraudiozone(0.1);
    func_F7E3(0);
    thread restartweaponvfx();
    self.phaseshift_active = undefined;
    self.phaseshift_removedtracker = undefined;
  }
}

func_E88D() {
  if(!scripts\mp\utility::istrue(self.phaseshift_active)) {
    func_6626(0, 4);
    return 1;
  }

  return 0;
}

func_6626(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 4;
  }

  self setsuit("assassin_mp_phase");
  self notify("phase_shift_start");
  thread func_4524(3);
  func_F7E3(1);
  thread restartweaponvfx();
  self visionsetnakedforplayer("phase_shift_mp", 0.1);
  self playlocalsound("ftl_phase_out");
  self playSound("ftl_phase_out_npc");
  func_2A71(self, var_1);
  self func_82C0("phaseshift_mp_shock", 0.1);
  scripts\engine\utility::allow_offhand_weapons(0);
  scripts\mp\equipment\peripheral_vision::func_CA2A();
  self setscriptablepartstate("compassicon", "hideIcon", 0);
  scripts\mp\utility::func_8ECD();
  scripts\mp\utility::giveperk("specialty_blindeye");
  scripts\mp\utility::giveperk("specialty_radarringresist");
  scripts\engine\utility::allow_usability(0);
  scripts\mp\utility::func_1C47(0);
  self.var_38ED = 0;
  if(scripts\mp\utility::_hasperk("specialty_tracker")) {
    scripts\mp\utility::removeperk("specialty_tracker");
    self.phaseshift_removedtracker = 1;
  }

  self.phaseshift_active = 1;
}

restartweaponvfx() {
  self endon("death");
  self endon("disconnect");
  self notify("startWeaponVFX");
  self endon("restartWeaponVFX");
  var_0 = self getcurrentprimaryweapon();
  scripts\mp\weapons::clearweaponscriptvfx(var_0, scripts\mp\utility::istrue(self isalternatemode(var_0)));
  scripts\engine\utility::waitframe();
  var_0 = self getcurrentprimaryweapon();
  scripts\mp\weapons::runweaponscriptvfx(var_0, scripts\mp\utility::istrue(self isalternatemode(var_0)));
}

exitphaseshift(var_0) {}

func_10918(var_0) {
  var_1 = spawn("script_model", self.origin);
  var_1 setModel("tag_origin");
  if(getdvarint("bg_thirdPerson") == 0) {
    var_1 hidefromplayer(self);
  }

  wait(0.1);
  playfxontagforteam(scripts\engine\utility::getfx(var_0 + "_friendly"), var_1, "tag_origin", self.team);
  playfxontagforteam(scripts\engine\utility::getfx(var_0), var_1, "tag_origin", scripts\mp\utility::getotherteam(self.team));
  wait(0.15);
  var_1 delete();
}

func_108EE(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("script_model", var_1.origin);
  var_5.angles = var_1.angles;
  var_5 setModel("tag_origin");
  var_5.owner = var_1;
  var_5.var_CACB = var_2;
  var_5.var_762C = var_0;
  wait(0.1);
  if(var_1 == var_2) {
    playfxontagforteam(var_0, var_5, "tag_origin", var_3);
    var_5 hidefromplayer(var_2);
  } else {
    playfxontagforclients(var_0, var_5, "tag_origin", var_2);
  }

  var_5 thread func_12EEA(var_4);
}

func_2A71(var_0, var_1) {
  var_2 = undefined;
  if(var_0.team == "allies") {
    var_2 = "axis";
  } else if(var_0.team == "axis") {
    var_2 = "allies";
  }

  thread func_108EE(scripts\engine\utility::getfx("vfx_phase_shift_trail_enemy"), var_0, var_0, var_2, var_1);
  var_3 = scripts\engine\utility::ter_op(level.teambased, scripts\engine\utility::getfx("vfx_phase_shift_trail_friendly"), scripts\engine\utility::getfx("vfx_phase_shift_trail_enemy"));
  thread func_108EE(var_3, var_0, var_0, var_0.team, var_1);
  foreach(var_5 in level.players) {
    if(var_5 == var_0) {
      continue;
    }

    var_6 = scripts\engine\utility::ter_op(level.teambased && var_5.team == var_0.team, scripts\engine\utility::getfx("vfx_phase_shift_trail_friendly"), scripts\engine\utility::getfx("vfx_phase_shift_trail_enemy"));
    thread func_108EE(var_6, var_5, var_0, var_0.team, var_1);
  }
}

func_12EEA(var_0) {
  var_1 = 0;
  var_2 = 0.15;
  for(;;) {
    if(!isDefined(self) || !isDefined(self.owner) || !scripts\mp\utility::isreallyalive(self.owner) || !isDefined(self.var_CACB) || !scripts\mp\utility::isreallyalive(self.var_CACB) || !isentityphaseshifted(self.var_CACB) || var_1 > var_0) {
      self.origin = self.origin + (0, 0, 10000);
      wait(0.2);
      self delete();
      return;
    }

    var_1 = var_1 + var_2;
    if(self.var_CACB == self.owner) {
      foreach(var_4 in level.players) {
        if(!areentitiesinphase(var_4, self.owner)) {
          self showtoplayer(var_4);
          continue;
        }

        self hidefromplayer(var_4);
      }
    } else {
      foreach(var_4 in level.players) {
        if(!areentitiesinphase(var_4, self.owner)) {
          self showtoplayer(self.owner);
          continue;
        }

        self hidefromplayer(self.owner);
      }
    }

    self moveto(self.owner.origin, var_2);
    wait(var_2);
  }
}

isentityphaseshifted(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  var_1 = (isplayer(var_0) || isagent(var_0)) && var_0 isinphase();
  var_2 = isDefined(var_0.var_FF03) && var_0.var_FF03 == 1;
  return var_1 || var_2;
}

areentitiesinphase(var_0, var_1) {
  var_2 = isentityphaseshifted(var_0);
  var_3 = isentityphaseshifted(var_1);
  return (var_2 && var_3) || !var_3 && !var_2;
}

func_F7E3(var_0) {
  return self setphasestatus(var_0);
}

func_4524(var_0) {
  self endon("death");
  self endon("disconnect");
  self notify("confuseBotsOnTeleport");
  self endon("confuseBotsOnTeleport");
  scripts\mp\utility::_enableignoreme();
  wait(var_0);
  scripts\mp\utility::_disableignoreme();
}