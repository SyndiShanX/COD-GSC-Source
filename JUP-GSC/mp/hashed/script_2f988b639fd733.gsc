/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2f988b639fd733.gsc
***********************************************/

#using script_38db8bccc9eb301f;
#using script_7edf952f8921aa6b;
#using script_9880b9dc28bc25e;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\vision_utility;
#using scripts\engine\throttle;
#using scripts\engine\utility;
#using scripts\mp\supers;
#namespace namespace_458c9ac11f854403;

function init() {
  scripts\mp\supers::function_53110a12409d01da("super_frenzied_guard", undefined, undefined, &function_b230d73ba6f02512, &function_fbc03cda5116c3ae, undefined);
  level.var_f513e9d749fb81cd = throttle_initialize("super_frenzied_guard", 2);
  var_6f0c028c94328ae3 = namespace_e23f629a8349dfaf::function_e7b6474ebd683537("super_frenzied_guard", #"hash_8adcece6f9625090");
  var_9462543a62d56ae0 = namespace_e23f629a8349dfaf::function_e7b6474ebd683537("super_frenzied_guard", #"hash_4a48365785177b20");
  var_21ecbfef71b4de59 = namespace_e23f629a8349dfaf::function_e7b6474ebd683537("super_frenzied_guard", #"hash_44303def58ce1a91");

  function_6e7290c8ee4f558b("<dev string:x1c>");
  add_devgui_command("<dev string:x35>", "<dev string:x4c>");
  add_devgui_command("<dev string:x7f>", "<dev string:x99>");
  function_fe953f000498048f();

  level._effect["frenzied_guard_1p_effect"] = loadfx(default_to(var_6f0c028c94328ae3, ""));
  level._effect["frenzied_guard_3p_head_effect"] = loadfx(default_to(var_9462543a62d56ae0, ""));
  level._effect["frenzied_guard_3p_torso_effect"] = loadfx(default_to(var_21ecbfef71b4de59, ""));
  supertable = getscriptbundle(level.supertable);

  foreach(super in supertable.super_list) {
    if(super.ref == "super_frenzied_guard") {
      level.var_f04301db8ca5ecfa["super_frenzied_guard"] = getscriptbundle("super:" + super.bundle);
      break;
    }
  }

  level callback::add("on_ai_killed", &on_ai_killed);
}

function on_ai_killed(params) {
  if(isPlayer(params.eattacker) && params.eattacker ent_flag("frenzied_guard_active")) {
    var_950a4c0355e0ab64 = default_to(level.var_f04301db8ca5ecfa["super_frenzied_guard"].var_950a4c0355e0ab64, 0.25);
    var_6eb34aa70f42c2f2 = default_to(level.var_f04301db8ca5ecfa["super_frenzied_guard"].var_6eb34aa70f42c2f2, 50);
    params.eattacker scripts\cp_mp\armor::setarmorhealth(params.eattacker.armorhealth + var_6eb34aa70f42c2f2 * var_950a4c0355e0ab64);
  }
}

function function_b230d73ba6f02512() {
  if(isDefined(level.var_f04301db8ca5ecfa["super_frenzied_guard"])) {
    var_3a5535e47f5de9a3 = level.var_f04301db8ca5ecfa["super_frenzied_guard"].offhandweapon;
    deploysuccess = namespace_e23f629a8349dfaf::function_75abcff430ed00b7(var_3a5535e47f5de9a3);

    if(deploysuccess) {
      self setscriptablepartstate("wand_fx", "wand_on_frenzied_guard", 0);
      var_45b3d22c6cca7734 = namespace_e23f629a8349dfaf::function_dabbdf1761a23f5c();
      base_duration = namespace_e23f629a8349dfaf::function_e7b6474ebd683537("super_frenzied_guard", #"hash_66e98430fa91d10e");
      base_duration = default_to(base_duration, 10);

      switch (var_45b3d22c6cca7734) {
        case 0:
          thread frenzied_guard_active(base_duration);
          thread function_fbb31130e1db8a38();
          break;
        case 1:
        default:
          thread frenzied_guard_active(base_duration);
          thread function_fbb31130e1db8a38();
          break;
        case 2:
          thread frenzied_guard_active(base_duration);
          thread function_fbb31130e1db8a38();
          break;
        case 3:
          thread frenzied_guard_active(base_duration);
          thread function_fbb31130e1db8a38();
          break;
        case 4:
          thread frenzied_guard_active(base_duration);
          thread function_fbb31130e1db8a38();
          break;
        case 5:
          thread frenzied_guard_active(base_duration);
          thread function_fbb31130e1db8a38();
          break;
      }

      return 1;
    }
  }
}

function function_fbc03cda5116c3ae(fromdeath, attacker) {
  self notify("end_frenzied_guard");
  ent_flag_clear("field_upgrade_in_use");
  ent_flag_clear("frenzied_guard_active");
  return false;
}

function frenzied_guard_active(n_duration) {
  self endon("disconnect");
  ent_flag_init("field_upgrade_in_use");
  ent_flag_set("field_upgrade_in_use");
  ent_flag_init("frenzied_guard_active");
  ent_flag_set("frenzied_guard_active");
  self.frenzied_zombies = [];
  s_super = scripts\mp\supers::getcurrentsuper();
  s_super.staticdata.usetime = n_duration;
  thread apply_effects(n_duration);
  playernum = self getentitynumber();
  var_90001396aba1b3e8 = "frenzied_guard_player_" + playernum;
  thread function_fd55871e70d0572e(n_duration, var_90001396aba1b3e8);
  s_waitresult = waittill_any_timeout_3(n_duration, "player_downed", "death", "end_frenzied_guard");
  function_1dcb61539c18f311(var_90001396aba1b3e8);
  thread remove_effects();
  ent_flag_clear("field_upgrade_in_use");
  ent_flag_clear("frenzied_guard_active");
}

function function_fbb31130e1db8a38() {
  scripts\cp_mp\armor::setarmorhealth(self.maxarmorhealth);
}

function function_1dcb61539c18f311(var_90001396aba1b3e8) {
  foreach(zombie in self.frenzied_zombies) {
    if(isalive(zombie)) {
      zombie function_a047f71d0256058b(undefined, var_90001396aba1b3e8, 0);

      if(zombie getscriptablehaspart("frenzied_guard")) {
        zombie setscriptablepartstate("frenzied_guard", "frenzied_guard_off", 1);
      }

      zombie.favoriteenemy = undefined;
      zombie.var_d8d6b31e877461b4 = default_to(zombie.var_d8d6b31e877461b4, []);

      foreach(var_c67af61827586b0f in zombie.var_d8d6b31e877461b4) {
        if(var_c67af61827586b0f.player == self) {
          zombie namespace_5381a59d140f4df8::function_6e660434fe00b495(var_c67af61827586b0f.attractor);
        }

        zombie.var_d8d6b31e877461b4 = array_remove(zombie.var_d8d6b31e877461b4, var_c67af61827586b0f);
      }
    }
  }

  self.frenzied_zombies = undefined;
}

function function_fd55871e70d0572e(n_duration, var_90001396aba1b3e8) {
  self endon("death");
  self endon("player_downed");
  self endon("end_frenzied_guard");
  starttime = gettime();
  time = gettime();
  pull_radius = namespace_e23f629a8349dfaf::function_e7b6474ebd683537("super_frenzied_guard", #"hash_ff3573675daf9e80");
  pull_radius = default_to(pull_radius, 1000);

  while(time - starttime < n_duration * 1000) {
    foreach(zombie in self.frenzied_zombies) {
      if(isalive(zombie) && distance2d(self.origin, zombie.origin) > pull_radius) {
        zombie function_a047f71d0256058b(undefined, var_90001396aba1b3e8, 0);

        if(zombie getscriptablehaspart("frenzied_guard")) {
          zombie setscriptablepartstate("frenzied_guard", "frenzied_guard_off", 1);
        }

        zombie.var_d8d6b31e877461b4 = default_to(zombie.var_d8d6b31e877461b4, []);

        foreach(var_c67af61827586b0f in zombie.var_d8d6b31e877461b4) {
          if(var_c67af61827586b0f.player == self) {
            zombie namespace_5381a59d140f4df8::function_6e660434fe00b495(var_c67af61827586b0f.attractor);
          }

          zombie.var_d8d6b31e877461b4 = array_remove(zombie.var_d8d6b31e877461b4, var_c67af61827586b0f);
        }
      }

      zombie.frenzied_zombies = array_remove(self.frenzied_zombies, zombie);
    }

    closezombies = getaiarrayinradius(self.origin, pull_radius);

    foreach(zombie in closezombies) {
      if(isalive(zombie) && zombie.type == "zombie" && zombie.team != self.team) {
        if(!isDefined(zombie.enemy) && flag("level_stealth_initialized")) {
          zombie aieventlistenerevent("combat", self, self.origin);
        }

        self.frenzied_zombies = function_6d6af8144a5131f1(self.frenzied_zombies, zombie);
        zombie function_a047f71d0256058b(self, var_90001396aba1b3e8, 9999);

        if(zombie getscriptablehaspart("frenzied_guard")) {
          zombie setscriptablepartstate("frenzied_guard", "frenzied_guard_on", 1);
        }

        zombie.var_d8d6b31e877461b4 = default_to(zombie.var_d8d6b31e877461b4, []);
        var_6926d9171198bd48 = 0;

        foreach(var_c67af61827586b0f in zombie.var_d8d6b31e877461b4) {
          if(var_c67af61827586b0f.player == self) {
            var_6926d9171198bd48 = 1;
            break;
          }
        }

        if(!var_6926d9171198bd48) {
          var_c67af61827586b0f = zombie namespace_5381a59d140f4df8::function_c0d3ba0eab1acba0(self, 9999, pull_radius, 1, undefined, undefined, 1);
          var_2847bb496d0bf2d1 = spawnStruct();
          var_2847bb496d0bf2d1.attractor = var_c67af61827586b0f;
          var_2847bb496d0bf2d1.player = self;
          zombie.var_d8d6b31e877461b4 = array_add(zombie.var_d8d6b31e877461b4, var_2847bb496d0bf2d1);
        }
      }
    }

    function_f632348cbb773537(level.var_f513e9d749fb81cd, self);
    time = gettime();
  }
}

function apply_effects(n_duration) {
  thread function_9ffad06921ecb845(n_duration);
  visionset = level.var_f04301db8ca5ecfa["super_frenzied_guard"].var_2de362df81a9a62d;
  scripts\cp_mp\utility\vision_utility::function_27a921508cb04613(visionset, 0.5);
  waitframe();

  if(isalive(self)) {
    self setscriptablepartstate("frenzied_guard_fx", "super_fx_on", 0);
  }
}

function function_9ffad06921ecb845(n_duration) {
  self endon("death_or_disconnect");
  self notify("applyFOVPresentation");
  self endon("applyFOVPresentation");
  self lerpfovbypreset("zombiedefault");
  waittill_any_timeout_no_endon_death_2(n_duration, "super_use_finished", "end_frenzied_guard");
  self lerpfovbypreset("default_2seconds");
  self playlocalsound("deadsilence_end");
}

function remove_effects() {
  visionset = level.var_f04301db8ca5ecfa["super_frenzied_guard"].var_2de362df81a9a62d;
  scripts\cp_mp\utility\vision_utility::function_9a92ae402e209ecc(visionset);
  self setscriptablepartstate("frenzied_guard_fx", "super_fx_deactivate", 0);
}