/************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\equipment\phase_shift.gsc
************************************************/

init() {
  level._effect["vfx_phase_shift_trail_friendly"] = loadfx("vfx\iw7\_requests\mp\vfx_phase_shift_body_fr.vfx");
  level._effect["vfx_phase_shift_trail_enemy"] = loadfx("vfx\iw7\_requests\mp\vfx_phase_shift_body_en.vfx");
  level._effect["vfx_screen_flash"] = loadfx("vfx\core\mp\core\vfx_screen_flash");
}

func_E154(param_00) {
  if(scripts\mp\utility::istrue(self.phaseshift_active)) {
    if(!scripts\mp\utility::istrue(param_00)) {
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

func_6626(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 4;
  }

  self setsuit("assassin_mp_phase");
  self notify("phase_shift_start");
  thread func_4524(3);
  func_F7E3(1);
  thread restartweaponvfx();
  self visionsetnakedforplayer("phase_shift_mp", 0.1);
  self playlocalsound("ftl_phase_out");
  self playSound("ftl_phase_out_npc");
  func_2A71(self, param_01);
  self _meth_82C0("phaseshift_mp_shock", 0.1);
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
  var_00 = self getcurrentprimaryweapon();
  scripts\mp\weapons::clearweaponscriptvfx(var_00, scripts\mp\utility::istrue(self _meth_8519(var_00)));
  scripts\engine\utility::waitframe();
  var_00 = self getcurrentprimaryweapon();
  scripts\mp\weapons::runweaponscriptvfx(var_00, scripts\mp\utility::istrue(self _meth_8519(var_00)));
}

exitphaseshift(param_00) {}

func_10918(param_00) {
  var_01 = spawn("script_model", self.origin);
  var_01 setModel("tag_origin");
  if(getdvarint("bg_thirdPerson") == 0) {
    var_01 hidefromplayer(self);
  }

  wait(0.1);
  playfxontagforteam(scripts\engine\utility::getfx(param_00 + "_friendly"), var_01, "tag_origin", self.team);
  playfxontagforteam(scripts\engine\utility::getfx(param_00), var_01, "tag_origin", scripts\mp\utility::getotherteam(self.team));
  wait(0.15);
  var_01 delete();
}

func_108EE(param_00, param_01, param_02, param_03, param_04) {
  var_05 = spawn("script_model", param_01.origin);
  var_05.angles = param_01.angles;
  var_05 setModel("tag_origin");
  var_05.triggerportableradarping = param_01;
  var_05.var_CACB = param_02;
  var_05.var_762C = param_00;
  wait(0.1);
  if(param_01 == param_02) {
    playfxontagforteam(param_00, var_05, "tag_origin", param_03);
    var_05 hidefromplayer(param_02);
  } else {
    playfxontagforclients(param_00, var_05, "tag_origin", param_02);
  }

  var_05 thread func_12EEA(param_04);
}

func_2A71(param_00, param_01) {
  var_02 = undefined;
  if(param_00.team == "allies") {
    var_02 = "axis";
  } else if(param_00.team == "axis") {
    var_02 = "allies";
  } else {}

  thread func_108EE(scripts\engine\utility::getfx("vfx_phase_shift_trail_enemy"), param_00, param_00, var_02, param_01);
  var_03 = scripts\engine\utility::ter_op(level.teambased, scripts\engine\utility::getfx("vfx_phase_shift_trail_friendly"), scripts\engine\utility::getfx("vfx_phase_shift_trail_enemy"));
  thread func_108EE(var_03, param_00, param_00, param_00.team, param_01);
  foreach(var_05 in level.players) {
    if(var_05 == param_00) {
      continue;
    }

    var_06 = scripts\engine\utility::ter_op(level.teambased && var_05.team == param_00.team, scripts\engine\utility::getfx("vfx_phase_shift_trail_friendly"), scripts\engine\utility::getfx("vfx_phase_shift_trail_enemy"));
    thread func_108EE(var_06, var_05, param_00, param_00.team, param_01);
  }
}

func_12EEA(param_00) {
  var_01 = 0;
  var_02 = 0.15;
  for(;;) {
    if(!isDefined(self) || !isDefined(self.triggerportableradarping) || !scripts\mp\utility::isreallyalive(self.triggerportableradarping) || !isDefined(self.var_CACB) || !scripts\mp\utility::isreallyalive(self.var_CACB) || !isentityphaseshifted(self.var_CACB) || var_01 > param_00) {
      self.origin = self.origin + (0, 0, 10000);
      wait(0.2);
      self delete();
      return;
    }

    var_01 = var_01 + var_02;
    if(self.var_CACB == self.triggerportableradarping) {
      foreach(var_04 in level.players) {
        if(!areentitiesinphase(var_04, self.triggerportableradarping)) {
          self showtoplayer(var_04);
          continue;
        }

        self hidefromplayer(var_04);
      }
    } else {
      foreach(var_04 in level.players) {
        if(!areentitiesinphase(var_04, self.triggerportableradarping)) {
          self showtoplayer(self.triggerportableradarping);
          continue;
        }

        self hidefromplayer(self.triggerportableradarping);
      }
    }

    self moveto(self.triggerportableradarping.origin, var_02);
    wait(var_02);
  }
}

isentityphaseshifted(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  var_01 = (isplayer(param_00) || isagent(param_00)) && param_00 isinphase();
  var_02 = isDefined(param_00.var_FF03) && param_00.var_FF03 == 1;
  return var_01 || var_02;
}

areentitiesinphase(param_00, param_01) {
  var_02 = isentityphaseshifted(param_00);
  var_03 = isentityphaseshifted(param_01);
  return (var_02 && var_03) || !var_03 && !var_02;
}

func_F7E3(param_00) {
  return self setphasestatus(param_00);
}

func_4524(param_00) {
  self endon("death");
  self endon("disconnect");
  self notify("confuseBotsOnTeleport");
  self endon("confuseBotsOnTeleport");
  scripts\mp\utility::_enableignoreme();
  wait(param_00);
  scripts\mp\utility::_disableignoreme();
}