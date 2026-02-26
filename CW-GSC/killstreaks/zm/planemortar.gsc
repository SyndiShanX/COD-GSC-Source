/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\zm\planemortar.gsc
***********************************************/

#using script_396f7d71538c9677;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\scene_shared;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreak_dialog;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\killstreaks\planemortar_shared;
#using scripts\killstreaks\zm\airsupport;
#using scripts\killstreaks\zm\killstreakrules;
#using scripts\killstreaks\zm\killstreaks;
#using scripts\zm_common\zm_player;
#namespace planemortar;

function private autoexec __init__system__() {
  system::register(#"planemortar", &preinit, undefined, &function_3675de8b, #"killstreaks");
}

function private preinit() {
  init_shared();
  clientfield::register("scriptmover", "planemortar_marker_on", 1, 2, "int");
  bundlename = "killstreak_planemortar" + "_zm";
  killstreaks::register_killstreak(bundlename, &function_c9ca313b);
  level.plane_mortar_bda_dialog = &plane_mortar_bda_dialog;
  level.var_269fec2 = &function_269fec2;
  level.var_eb0c5d6 = 1;
  zm_player::register_player_damage_callback(&function_5e7e3e86);
}

function private function_3675de8b() {
  killstreaks::function_7b6102ed("planemortar");
  killstreaks::function_7b6102ed("inventory_planemortar");
}

function function_269fec2() {
  if(isDefined(level.var_30264985)) {
    self notify(#"mortarradarused");
  }
}

function plane_mortar_bda_dialog() {
  if(isDefined(self.planemortarbda)) {
    if(self.planemortarbda === 1) {
      bdadialog = "kill1";
      killconfirmed = "killConfirmed1_p";
    } else if(self.planemortarbda === 2) {
      bdadialog = "kill2";
      killconfirmed = "killConfirmed2_p";
    } else if(self.planemortarbda === 3) {
      bdadialog = "kill3";
      killconfirmed = "killConfirmed3_p";
    } else if(isDefined(self.planemortarbda) && self.planemortarbda > 3) {
      bdadialog = "killMultiple";
      killconfirmed = "killConfirmedMult_p";
    }

    self killstreak_dialog::play_pilot_dialog(bdadialog, "planemortar", undefined, self.planemortarpilotindex);

    if(battlechatter::dialog_chance("taacomPilotKillConfirmChance")) {
      self killstreak_dialog::play_taacom_dialog_response(killconfirmed, "planemortar", undefined, self.planemortarpilotindex);
    } else {
      self killstreak_dialog::play_taacom_dialog_response("hitConfirmed_p", "planemortar", undefined, self.planemortarpilotindex);
    }

    globallogic_audio::play_taacom_dialog("confirmHit");
  } else {
    killstreak_dialog::play_pilot_dialog("killNone", "planemortar", undefined, self.planemortarpilotindex);
    globallogic_audio::play_taacom_dialog("confirmMiss");
  }

  self.planemortarbda = undefined;
}

function function_c9ca313b(killstreaktype) {
  if(!self killstreakrules::iskillstreakallowed("planemortar", self.team)) {
    return 0;
  }

  if(!self killstreakrules::function_71e94a3b()) {
    self.var_baf4657c = 1;
    self killstreakrules::function_65739e7b("planemortar");
    self killstreaks::switch_to_last_non_killstreak_weapon();
    return;
  }

  if(isint(level.var_fd269dce)) {
    level.var_fd269dce = (level.var_fd269dce + 1) % 100;
  } else {
    level.var_fd269dce = 0;
  }

  if(isDefined(level.var_269fec2)) {
    self[[level.var_269fec2]]();
  }

  result = function_66133f8b(level.var_fd269dce);
  return result;
}

function function_58189f7d(killstreaktype) {
  self endon(#"death");
  waitresult = self waittill(#"weapon_fired", #"weapon_change");

  if(!self killstreakrules::function_71e94a3b() && waitresult._notify === "weapon_fired") {
    return 0;
  }

  if(waitresult._notify === "weapon_fired") {
    return 1;
  }

  return 0;
}

function private event_handler[grenade_fire] function_4776caf4(eventstruct) {
  if(!is_true(level.var_eb0c5d6)) {
    return;
  }

  if(!isPlayer(self)) {
    return;
  }

  weapon = eventstruct.weapon;

  if(!isDefined(weapon)) {
    return;
  }

  if(weapon == killstreaks::get_killstreak_weapon("planemortar") || weapon == killstreaks::get_killstreak_weapon("inventory_" + "planemortar")) {
    if(!self killstreakrules::function_71e94a3b()) {
      self.var_baf4657c = 1;
      self killstreakrules::function_65739e7b("planemortar");
      projectile = eventstruct.projectile;

      if(isDefined(projectile)) {
        projectile delete();
      }

      return;
    }

    projectile = eventstruct.projectile;

    if(isDefined(projectile)) {
      projectile endon(#"death");
      projectile waittill(#"rolling");

      if(isDefined(projectile)) {
        playFXOnTag("weapon/fx8_equip_swat_smk_signal", projectile, "tag_flash");
      }

      projectile waittill(#"stationary");

      if(isDefined(projectile)) {
        projectile.angles = (-90, 0, 90);
      }

      wait 1;

      if(isDefined(projectile) && isPlayer(self)) {
        projectile thread function_5673c107();
        s_location = spawnStruct();
        s_location.origin = projectile.origin;
        s_params = killstreaks::get_script_bundle("planemortar");
        killstreakid = self killstreakrules::killstreakstart("planemortar", self.team, 0, 1);

        if(killstreakid == -1) {
          self notify(#"planemortar_failed");
          return 0;
        }

        self thread function_8f181838(s_params, s_location.origin);
      }
    }
  }
}

function function_66133f8b(var_5b276012) {
  self endon(#"disconnect");
  s_params = killstreaks::get_script_bundle("planemortar");
  var_2558cb51 = array("planemortar_complete" + var_5b276012, "planemortar_failed" + var_5b276012);
  self namespace_bf7415ae::function_890b3889("planemortar", s_params.ksweapon, 2500, &function_142c133b, &function_f2cd26bf, var_2558cb51, 0, &function_fa592333);
  s_location = self namespace_bf7415ae::function_be6de952("planemortar", &function_c6fe946e);

  if(isDefined(s_location)) {
    killstreak_id = self killstreakrules::killstreakstart("planemortar", self.team, 0, 1);

    if(killstreak_id == -1) {
      self notify("planemortar_failed" + var_5b276012);
      return false;
    }

    if((isDefined(self.var_fb18d24e) ? self.var_fb18d24e : 0) < gettime()) {
      self killstreak_dialog::play_killstreak_start_dialog("planemortar", self.team, killstreak_id);
      self.var_fb18d24e = gettime() + int(battlechatter::mpdialog_value("planeMortarCooldown", 7) * 1000);
    }

    self thread function_8f181838(var_5b276012, s_params, s_location.origin);
    return true;
  }

  return false;
}

function private function_142c133b() {
  self clientfield::set("planemortar_marker_on", 1);
}

function private function_c6fe946e() {
  self clientfield::set("planemortar_marker_on", 2);
}

function private function_f2cd26bf() {
  self clientfield::set("planemortar_marker_on", 0);
}

function private function_fa592333(b_valid) {
  self clientfield::set("planemortar_marker_on", is_true(b_valid) ? 1 : 3);
}

function function_5673c107() {
  self endon(#"death");
  wait 7;
  self delete();
}

function private function_8f181838(var_5b276012, params, targetposition) {
  self endon(#"disconnect");
  self.planemortarpilotindex = self killstreak_dialog::get_random_pilot_index("planemortar");
  self thread function_16f87e96(8);

  if(isDefined(params.var_675bebb2)) {
    wait params.var_675bebb2;
  }

  n_yaw = randomintrange(0, 360);

  for(i = 0; i < 8; i++) {
    if(i != 0) {
      n_interval = randomfloatrange(0.5, 2);
      wait n_interval;
    }

    n_radius = 500 * randomfloat(1);
    n_angle = randomintrange(0, 360);
    v_position = targetposition + (n_radius * cos(n_angle), n_radius * sin(n_angle), 0);
    var_86f8b2c9 = (0, 0, getheliheightlockheight(v_position));
    a_trace = groundtrace(v_position + var_86f8b2c9, v_position - var_86f8b2c9, 1, undefined);
    var_5acfe25f = a_trace[#"position"];
    self thread function_83e61117(var_5acfe25f, n_yaw);
  }

  n_length = scene::function_12479eba(#"p9_fxanim_mp_planemortar_01_bundle");
  wait n_length + 0.5;
  self notify("planemortar_complete" + var_5b276012);
}

function private function_5e7e3e86(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
  if(shitloc === self && psoffsettime == getweapon("planemortar")) {
    return 50;
  }

  return -1;
}