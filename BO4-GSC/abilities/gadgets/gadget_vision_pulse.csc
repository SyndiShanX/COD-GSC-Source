/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\gadgets\gadget_vision_pulse.csc
*****************************************************/

#include scripts\core_common\animation_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\player\player_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\shoutcaster;
#include scripts\core_common\util_shared;
#include scripts\core_common\visionset_mgr_shared;

#namespace gadget_vision_pulse;

init_shared() {
  level.vision_pulse = [];
  level.registerdevgui_dev_cac_fallimp = [];
  level.weaponvisionpulse = getweapon(#"gadget_vision_pulse");
  callback::on_localplayer_spawned(&on_localplayer_spawned);
  callback::on_spawned(&on_player_spawned);
  callback::on_player_corpse(&on_player_corpse);
  callback::function_17381fe(&function_17381fe);
  clientfield::register("toplayer", "vision_pulse_active", 1, 1, "int", &vision_pulse_changed, 0, 1);
  clientfield::register("toplayer", "toggle_postfx", 1, 1, "int", &toggle_postfx, 0, 1);
  visionset_mgr::register_visionset_info("vision_pulse", 1, 12, undefined, "vision_puls_bw");
  animation::add_notetrack_func(#"gadget_vision_pulse::vision_pulse_notetracks", &function_ab898b2d);
}

on_localplayer_spawned(localclientnum) {
  if(self function_21c0fa55()) {
    level.vision_pulse[localclientnum] = 0;
    level.registerdevgui_dev_cac_fallimp[localclientnum] = 0;
    self.vision_pulse_owner = undefined;
    self.var_f0b8faa1 = undefined;
    self gadgetpulseresetreveal();
    self set_reveal_self(localclientnum, 0);
    self set_reveal_enemy(localclientnum, 0);
    self toggle_spectator(localclientnum);
  }

  if(self function_da43934d()) {
    self stop_postfx(1);
  }
}

on_player_spawned(local_client_num) {
  if(!self hasdobj(local_client_num)) {
    return;
  }

  self clearanim(#"pt_recon_t8_stand_vision_pulse_goggles_down_loop", 0);
  self clearanim(#"pt_recon_t8_prone_vision_pulse_goggles_down_loop", 0);
}

on_player_corpse(localclientnum, params) {
  self endon(#"death");
  var_1edcbdd3 = params.player.visionpulsereveal;

  if(isDefined(var_1edcbdd3) && var_1edcbdd3) {
    self.visionpulsereveal = 1;
    self.var_a768b7b6 = params.player.var_a768b7b6;
    self util::waittill_dobj(localclientnum);
    self set_reveal_enemy(localclientnum, 1);
  }
}

function_17381fe(localclientnum) {
  if(shoutcaster::is_shoutcaster(localclientnum)) {
    localplayer = function_5c10bd79(localclientnum);
    localplayer function_ea179305(localclientnum, shoutcaster::function_2e6e4ee0(localclientnum));
  }
}

stop_postfx(immediate) {
  if(isDefined(self)) {
    self.var_f0b8faa1 = undefined;

    if(isDefined(immediate) && immediate) {
      if(self postfx::function_556665f2(#"hash_5a76eaaf7f7e3de5")) {
        self postfx::stoppostfxbundle(#"hash_5a76eaaf7f7e3de5");
      }

      if(self postfx::function_556665f2(#"hash_1356e810590b8caf")) {
        self postfx::stoppostfxbundle(#"hash_1356e810590b8caf");
      }
    } else {
      if(self postfx::function_556665f2(#"hash_5a76eaaf7f7e3de5")) {
        self postfx::exitpostfxbundle(#"hash_5a76eaaf7f7e3de5");
      }

      if(self postfx::function_556665f2(#"hash_1356e810590b8caf")) {
        self postfx::exitpostfxbundle(#"hash_1356e810590b8caf");
      }
    }

    self.var_1618a13f = undefined;
  }
}

toggle_spectator(localclientnum) {
  if(is_enabled(localclientnum)) {
    return;
  }

  stop_postfx(1);
}

function_5f4276b8() {
  self endon(#"stop_googles", #"death");

  if(!isplayer(self)) {
    return;
  }

  while(true) {
    if(self isplayerprone()) {
      self clearanim(#"pt_recon_t8_stand_vision_pulse_goggles_down_loop", 0);
      self setanimknob(#"pt_recon_t8_prone_vision_pulse_goggles_down_loop", 1, 0, 1);
    } else {
      self clearanim(#"pt_recon_t8_prone_vision_pulse_goggles_down_loop", 0);
      self setanimknob(#"pt_recon_t8_stand_vision_pulse_goggles_down_loop", 1, 0, 1);
    }

    waitframe(1);
  }
}

function_3e2cd736(local_client_num) {
  self endon(#"stop_googles");
  wait 0.8;
  level.vision_pulse[local_client_num] = 1;
  level notify(#"hash_7f642789ed08aae0");
}

function_43c942dc(local_client_num) {
  self endon(#"stop_googles");
  wait 0.85;
  level.vision_pulse[local_client_num] = 0;
  level notify(#"hash_7f642789ed08aae0");
}

function_ab898b2d(notifystring) {
  self endon(#"death");
  localclientnum = self.localclientnum;

  if(notifystring == "visor_down") {
    self childthread function_5f4276b8();
    level.registerdevgui_dev_cac_fallimp[localclientnum] = 1;
  } else if(notifystring == "visor_up") {
    self clearanim(#"pt_recon_t8_stand_vision_pulse_goggles_down_loop", 0);
    self clearanim(#"pt_recon_t8_prone_vision_pulse_goggles_down_loop", 0);
    self notify(#"stop_googles");
    level.registerdevgui_dev_cac_fallimp[localclientnum] = 0;
  }

  if(self function_21c0fa55()) {
    if(notifystring == "visor_up") {
      stop_postfx();
      return;
    }

    if(notifystring == "overlay_on") {
      if(!isDefined(self.var_f0b8faa1)) {
        stop_postfx();
        self thread function_3e2cd736(localclientnum);
        self.var_f0b8faa1 = 1;
        self.var_1618a13f = #"hash_5a76eaaf7f7e3de5";
        self postfx::playpostfxbundle(self.var_1618a13f);
        self function_116b95e5(self.var_1618a13f, #"hash_7c1a0903a45d4d45", 0);
        self function_116b95e5(self.var_1618a13f, #"hash_51ebcff0b5d75894", 0);
        self function_116b95e5(self.var_1618a13f, #"hash_2efccfad2b32081a", 1);
        self thread function_844dbcb7(localclientnum);
        self thread function_85e399a9(localclientnum);
        self callback::on_end_game(&on_game_ended);
        waitframe(1);
        self.var_168d7f5c = 0;
        enemies = getplayers(localclientnum);

        foreach(enemy in enemies) {
          if(isDefined(enemy) && util::function_fbce7263(enemy.team, self.team)) {
            enemy.var_1d0bc391 = 0;
          }
        }

        extraduration = 3000;
        thread util::lerp_generic(localclientnum, level.weaponvisionpulse.gadget_pulse_duration + extraduration, &do_vision_world_pulse_lerp_helper);
      }

      return;
    }

    if(notifystring == "overlay_off") {
      self notify(#"stop_googles");
      self thread function_43c942dc(localclientnum);
      stop_postfx();
      self function_f4ebfe85(localclientnum);
    }
  }
}

function_f4ebfe85(localclientnum) {
  if(isDefined(self)) {
    players = getplayers(localclientnum);

    foreach(enemy in players) {
      if(isDefined(enemy) && isalive(enemy) && util::function_fbce7263(enemy.team, self.team) && (isDefined(enemy.visionpulsereveal) && enemy.visionpulsereveal || isDefined(enemy.var_f4f50357) && enemy.var_f4f50357)) {
        enemy stoprenderoverridebundle(#"hash_75f4d8048e6adb94");
        enemy stoprenderoverridebundle(#"hash_62b3e8ea5469c2f5");
        enemy function_9b51bc6(localclientnum, 0);
        enemy notify(#"rob_cleanup");
      }
    }
  }
}

on_game_ended(localclientnum) {
  local_player = function_5c10bd79(localclientnum);

  if(isDefined(local_player)) {
    local_player shutdown_vision_pulse(localclientnum);
  }
}

shutdown_vision_pulse(localclientnum) {
  if(isDefined(level.vision_pulse[localclientnum]) && level.vision_pulse[localclientnum]) {
    self stop_postfx(1);
    self function_f4ebfe85(localclientnum);
    level.vision_pulse[localclientnum] = 0;
  }
}

function_85e399a9(localclientnum) {
  self notify(#"hash_54f15501beb799f9");
  self endon(#"hash_54f15501beb799f9");
  self endon(#"stop_googles");
  self waittill(#"death", #"game_ended");
  self shutdown_vision_pulse(localclientnum);
}

function_844dbcb7(localclientnum) {
  self notify(#"hash_72d43e802a417711");
  self endon(#"hash_72d43e802a417711");
  self endon(#"activation_confirmed");
  wait 2;

  if(isDefined(self) && self function_da43934d()) {
    self stop_postfx(1);
    self clearanim(#"pt_recon_t8_stand_vision_pulse_goggles_down_loop", 0);
    self clearanim(#"pt_recon_t8_prone_vision_pulse_goggles_down_loop", 0);
  }
}

do_vision_world_pulse_lerp_helper(currenttime, elapsedtime, localclientnum, duration) {
  if(!isDefined(self)) {
    return;
  }

  pulseduration = level.weaponvisionpulse.gadget_pulse_duration;

  if(elapsedtime < pulseduration * 0.1) {
    irisamount = elapsedtime / pulseduration * 0.1;
  } else if(elapsedtime < pulseduration * 0.6) {
    irisamount = 1 - elapsedtime / pulseduration * 0.5;
  } else {
    irisamount = 0;
  }

  pulseradius = getvisionpulseradius(localclientnum);
  pulsemaxradius = level.weaponvisionpulse.gadget_pulse_max_range;

  if(pulseradius > 0 && self.var_168d7f5c == 0) {
    self.var_168d7f5c = 1;
    playSound(localclientnum, #"hash_151b724086b2955b");
  }

  if(pulseradius > pulsemaxradius) {
    if(self.var_168d7f5c * pulsemaxradius < pulseradius) {
      self.var_168d7f5c++;
      playSound(localclientnum, #"hash_151b724086b2955b");
    }

    pulseradius = int(pulseradius) % pulsemaxradius;
  }

  if(!isDefined(self.var_1618a13f)) {
    self.var_1618a13f = #"hash_5a76eaaf7f7e3de5";
  }

  if(self postfx::function_556665f2(self.var_1618a13f)) {
    self function_116b95e5(self.var_1618a13f, #"hash_7c1a0903a45d4d45", pulseradius);
    self function_116b95e5(self.var_1618a13f, #"hash_51ebcff0b5d75894", irisamount);
    self function_116b95e5(self.var_1618a13f, #"hash_2efccfad2b32081a", pulsemaxradius);
  }
}

vision_pulse_owner_valid(owner) {
  if(isDefined(owner) && isplayer(owner) && isalive(owner)) {
    return true;
  }

  return false;
}

watch_vision_pulse_owner_death(localclientnum) {
  self endon(#"death");
  self endon(#"finished_local_pulse");
  self notify(#"watch_vision_pulse_owner_death");
  self endon(#"watch_vision_pulse_owner_death");
  owner = self.vision_pulse_owner;

  if(vision_pulse_owner_valid(owner)) {
    owner waittill(#"death");
  }

  self notify(#"vision_pulse_owner_death");
  self stoprenderoverridebundle(#"hash_75f4d8048e6adb94");
  self stoprenderoverridebundle(#"hash_62b3e8ea5469c2f5");
  self player::function_f2ba057();

  if(self function_d2503806(#"hash_1978eff2ac047e65")) {
    self function_78233d29(#"hash_1978eff2ac047e65", "", #"brightness", 0);
    self stoprenderoverridebundle(#"hash_1978eff2ac047e65");
  }

  level callback::callback(#"vision_pulse_off", localclientnum);
  self.vision_pulse_owner = undefined;
}

do_vision_local_pulse(localclientnum) {
  self endon(#"death");
  self endon(#"vision_pulse_owner_death");
  self notify(#"local_pulse");
  self endon(#"startlocalpulse");
  self thread watch_vision_pulse_owner_death(localclientnum);
  self playrenderoverridebundle(#"hash_1978eff2ac047e65");
  origin = getrevealpulseorigin(localclientnum);
  self function_78233d29(#"hash_1978eff2ac047e65", "", #"brightness", 1);
  starttime = function_41f5de53(localclientnum);
  revealtime = level.weaponvisionpulse.var_b9951041;
  fadeout_duration = level.weaponvisionpulse.var_8e0b0827;
  jammed = self clientfield::get("gps_jammer_active");
  var_8ac8d61d = isDefined(level.weaponvisionpulse.var_5be370e9) ? level.weaponvisionpulse.var_5be370e9 : 1;
  var_6f9f5fef = fadeout_duration * (jammed ? var_8ac8d61d : 1);
  var_42a54adc = var_6f9f5fef * (isDefined(level.weaponvisionpulse.var_a2d7b97c) ? level.weaponvisionpulse.var_a2d7b97c : 0.8);

  while(true) {
    elapsedtime = getservertime(localclientnum) - starttime;

    if(elapsedtime >= revealtime) {
      break;
    }

    pulseradius = 0;

    if(getservertime(localclientnum) - starttime < level.weaponvisionpulse.gadget_pulse_duration) {
      pulseradius = (getservertime(localclientnum) - starttime) / level.weaponvisionpulse.gadget_pulse_duration * 2000;
    }

    t = elapsedtime % fadeout_duration;

    if(t < var_42a54adc) {
      frac = 1;
    } else if(t < var_6f9f5fef) {
      frac = 1 - (t - var_42a54adc) / (var_6f9f5fef - var_42a54adc);
    } else {
      frac = 0;
    }

    self function_78233d29(#"hash_1978eff2ac047e65", "", #"brightness", frac);
    waitframe(1);
  }

  self function_78233d29(#"hash_1978eff2ac047e65", "", #"brightness", 0);
  self stoprenderoverridebundle(#"hash_75f4d8048e6adb94");
  self notify(#"finished_local_pulse");
  self function_9b51bc6(localclientnum, 0);
  self.vision_pulse_owner = undefined;
}

function_85790e6c(localclientnum) {
  self endon(#"death", #"disconnect", #"rob_cleanup");
  wait 1;
  self stop_postfx();
  self function_f4ebfe85(localclientnum);
}

vision_pulse_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self notify(#"activation_confirmed");
  }

  if(newval && bnewent && bwastimejump) {
    self.var_1618a13f = #"hash_5a76eaaf7f7e3de5";
    self postfx::playpostfxbundle(self.var_1618a13f);
    self function_116b95e5(self.var_1618a13f, #"hash_7c1a0903a45d4d45", 0);
    self function_116b95e5(self.var_1618a13f, #"hash_51ebcff0b5d75894", 0);
    self function_116b95e5(self.var_1618a13f, #"hash_2efccfad2b32081a", 1);
    return;
  }

  if(newval == 0) {
    self thread function_85790e6c(localclientnum);
  }
}

toggle_postfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(is_active(localclientnum)) {
    if(newval) {
      if(isDefined(self.var_1618a13f) && self postfx::function_556665f2(self.var_1618a13f)) {
        self postfx::stoppostfxbundle(self.var_1618a13f);
      }

      return;
    }

    if(!isDefined(self.var_1618a13f)) {
      self.var_1618a13f = #"hash_5a76eaaf7f7e3de5";
    }

    if(!self postfx::function_556665f2(self.var_1618a13f)) {
      self postfx::playpostfxbundle(self.var_1618a13f);
    }
  }
}

function_ea179305(localclientnum, enabled) {
  if(is_enabled(localclientnum)) {
    if(enabled) {
      if(!isDefined(self.var_1618a13f)) {
        self.var_1618a13f = #"hash_5a76eaaf7f7e3de5";
      }

      if(self postfx::function_556665f2(self.var_1618a13f)) {
        self postfx::stoppostfxbundle(self.var_1618a13f);
      }

      return;
    }

    if(self postfx::function_556665f2(#"hash_5a76eaaf7f7e3de5")) {
      self postfx::stoppostfxbundle(#"hash_5a76eaaf7f7e3de5");
    }

    if(!self postfx::function_556665f2(#"hash_1356e810590b8caf")) {
      self.var_1618a13f = #"hash_1356e810590b8caf";
      self postfx::playpostfxbundle(self.var_1618a13f);
    }
  }
}

function_9e2a452e(localclientnum, robname) {
  self notify("55d14ddd4012cb9a");
  self endon("55d14ddd4012cb9a");
  self endon(#"death", #"disconnect", #"rob_cleanup");
  speed = function_c505bc89(localclientnum);
  maxradius = getvisionpulsemaxradius(localclientnum);
  fadeout_duration = level.weaponvisionpulse.var_8e0b0827;
  jammed = 0;

  if(isplayer(self)) {
    jammed = self clientfield::get("gps_jammer_active");
  }

  var_8ac8d61d = isDefined(level.weaponvisionpulse.var_5be370e9) ? level.weaponvisionpulse.var_5be370e9 : 1;
  var_6f9f5fef = fadeout_duration * (jammed ? var_8ac8d61d : 1);
  var_42a54adc = var_6f9f5fef * (isDefined(level.weaponvisionpulse.var_a2d7b97c) ? level.weaponvisionpulse.var_a2d7b97c : 0.8);
  elapsedtime = 0;
  owner = self gadgetpulsegetowner(localclientnum);

  while(true) {
    waitframe(1);

    if(isDefined(self.visionpulsereveal) && self.visionpulsereveal) {
      currenttime = getservertime(localclientnum);
      elapsedtime = currenttime - self.var_a768b7b6;

      if(elapsedtime < var_42a54adc) {
        alpha = 1;
      } else if(elapsedtime < var_6f9f5fef) {
        alpha = 1 - (elapsedtime - var_42a54adc) / (var_6f9f5fef - var_42a54adc);
      } else if(elapsedtime < fadeout_duration) {
        alpha = 0;
      } else {
        self.visionpulsereveal = 0;
        alpha = 0;

        if(!isDefined(self.var_1d0bc391)) {
          self.var_1d0bc391 = 0;
        }

        self.var_1d0bc391++;
        self stoprenderoverridebundle(robname);
        self function_9b51bc6(localclientnum, 0);
      }

      self function_78233d29(robname, "", "Alpha", alpha);

      if(!isDefined(self.var_1618a13f)) {
        self.var_1618a13f = #"hash_5a76eaaf7f7e3de5";
      }

      if(self postfx::function_556665f2(self.var_1618a13f)) {
        self function_116b95e5(self.var_1618a13f, #"enemy tint", 1 - alpha);
      }
    }
  }
}

set_reveal_enemy(localclientnum, on_off) {
  if(on_off) {
    owner = self gadgetpulsegetowner(localclientnum);

    if(isDefined(self.insmoke) && !owner function_21c0fa55()) {
      return;
    }

    owner thread function_85e399a9(localclientnum);

    if(isalive(owner) && isDefined(level.gameended) && !level.gameended && util::function_fbce7263(owner.team, self.team)) {
      robname = #"hash_75f4d8048e6adb94";

      if(!owner function_21c0fa55()) {
        robname = #"hash_62b3e8ea5469c2f5";
      }

      if(!(isDefined(self.var_f4f50357) && self.var_f4f50357)) {
        self function_9b51bc6(localclientnum, 1);
        self player::function_f2ba057();
        self playrenderoverridebundle(robname);
        self thread function_9e2a452e(localclientnum, robname);
      }

      self function_78233d29(robname, "", "Alpha", 1);

      if(!owner function_21c0fa55()) {
        self function_78233d29(robname, "", "Tint", 0);
        self function_78233d29(robname, "", "Alpha", 1);
      }
    }

    return;
  }

  self stoprenderoverridebundle(#"hash_75f4d8048e6adb94");
  self stoprenderoverridebundle(#"hash_62b3e8ea5469c2f5");
  self function_9b51bc6(localclientnum, 0);
  self notify(#"rob_cleanup");
}

set_reveal_self(localclientnum, on_off) {
  if(!isplayer(self)) {
    return;
  }

  if(on_off && self function_da43934d()) {
    self thread do_vision_local_pulse(localclientnum);
    return;
  }

  if(!on_off) {
    if(self function_d2503806(#"hash_1978eff2ac047e65")) {
      self stoprenderoverridebundle(#"hash_1978eff2ac047e65");
    }
  }
}

gadget_visionpulse_reveal(localclientnum, breveal) {
  self notify(#"gadget_visionpulse_changed");

  if(!isDefined(self.visionpulserevealself) && self function_21c0fa55()) {
    self.visionpulserevealself = 0;
  }

  if(!isDefined(self.visionpulsereveal)) {
    self.visionpulsereveal = 0;
  }

  if(!isDefined(self)) {
    return;
  }

  owner = self gadgetpulsegetowner(localclientnum);

  if(owner !== self) {
    if(self function_21c0fa55()) {
      if(self.visionpulserevealself != breveal || isDefined(self.vision_pulse_owner) && isDefined(owner) && self.vision_pulse_owner != owner) {
        self.vision_pulse_owner = owner;
        self.visionpulserevealself = breveal;
        self set_reveal_self(localclientnum, breveal);
      }

      return;
    }

    if(isalive(self) && self.visionpulsereveal != breveal && owner function_e9fc6a64()) {
      if(isDefined(breveal) && breveal) {
        pulseradius = owner function_692b47c1(localclientnum);
        pulsemaxradius = level.weaponvisionpulse.gadget_pulse_max_range;
        var_168d7f5c = int(pulseradius) / int(pulsemaxradius);

        if(isDefined(self.var_1d0bc391) && self.var_1d0bc391 > 0 && self.var_1d0bc391 >= var_168d7f5c) {
          return;
        }

        dist = distance2d(owner.origin, self.origin);
        dist2 = dist * dist;
        radius = int(pulseradius) % pulsemaxradius;
        radius2 = radius * radius;

        if(dist2 > radius2) {
          return;
        }

        if(!isDefined(self.var_1d0bc391)) {
          self.var_1d0bc391 = int(floor(var_168d7f5c) + 1);
          return;
        }

        self.var_a768b7b6 = getservertime(localclientnum);
      }

      self.visionpulsereveal = breveal;

      if(!(isDefined(breveal) && breveal)) {
        self.var_1d0bc391 = 0;
      }

      self set_reveal_enemy(localclientnum, breveal);
      return;
    }

    if(!(isDefined(breveal) && breveal)) {
      self.var_1d0bc391 = 0;
    }
  }
}

function_9b51bc6(local_client_num, pulsed) {
  self.var_f4f50357 = pulsed;
}

is_active(local_client_num) {
  return isDefined(level.vision_pulse) && isDefined(level.vision_pulse[local_client_num]) && level.vision_pulse[local_client_num];
}

is_enabled(local_client_num) {
  return isDefined(level.registerdevgui_dev_cac_fallimp) && isDefined(level.registerdevgui_dev_cac_fallimp[local_client_num]) && level.registerdevgui_dev_cac_fallimp[local_client_num];
}