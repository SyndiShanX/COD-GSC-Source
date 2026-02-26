/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_elemental_pop.gsc
***********************************************/

#using script_5f261a5d57de5f7c;
#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\weapons_shared;
#using scripts\zm_common\aats\zm_aat;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#namespace zm_perk_elemental_pop;

function private autoexec __init__system__() {
  system::register(#"zm_perk_elemental_pop", &preinit, undefined, undefined, #"hash_2d064899850813e2");
}

function private preinit() {
  function_27473e44();
}

function function_27473e44() {
  zm_perks::register_perk_basic_info(#"talent_elemental_pop", #"perk_elemental_pop", 2000, #"hash_3aca6fccecde9e86", getweapon("zombie_perk_bottle_elemental_pop"), undefined, #"hash_363622d67a410b29");
  zm_perks::register_perk_precache_func(#"talent_elemental_pop", &precache);
  zm_perks::register_perk_clientfields(#"talent_elemental_pop", &register_clientfield, &set_clientfield);
  zm_perks::register_perk_machine(#"talent_elemental_pop", &perk_machine_setup);
  zm_perks::register_perk_host_migration_params(#"talent_elemental_pop", "vending_elemental_pop", "elemental_pop_light");
  zm_perks::register_actor_damage_override(#"talent_elemental_pop", &function_abddd809);
  zm_perks::register_perk_threads(#"talent_elemental_pop", &function_fdaa251f, &function_cf066d32);
  clientfield::register("allplayers", "elemental_pop_reload_fx", 1, 2, "int");
  clientfield::register("actor", "tesla_death_fx", 1, 1, "int");
  clientfield::register("vehicle", "tesla_death_fx", 1, 1, "int");
  clientfield::register("actor", "tesla_shock_eyes_fx", 1, 1, "int");
  clientfield::register("vehicle", "tesla_shock_eyes_fx", 1, 1, "int");
  level.custom_laststand_func = &function_70c2d1b6;
}

function precache() {
  if(isDefined(level.var_cf57ff63)) {
    [[level.var_cf57ff63]]();
    return;
  }

  level._effect[#"elemental_pop_light"] = # "hash_17afc35bb449d1c2";
  level.machine_assets[#"talent_elemental_pop"] = spawnStruct();
  level.machine_assets[#"talent_elemental_pop"].weapon = getweapon("zombie_perk_bottle_elemental_pop");
  level.machine_assets[#"talent_elemental_pop"].off_model = "p9_sur_elemental_pop_off";
  level.machine_assets[#"talent_elemental_pop"].on_model = "p9_sur_elemental_pop";
}

function register_clientfield() {
  clientfield::register("scriptmover", "" + # "hash_2bc83061af453e44", 1, 1, "counter");
  clientfield::register("toplayer", "" + # "hash_12c6e46c315cd43b", 1, 1, "counter");
}

function set_clientfield(state) {}

function perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision) {
  perk_machine.script_sound = "mus_perks_elementalpop_jingle";
  perk_machine.script_string = "elemental_perk";
  perk_machine.script_label = "mus_perks_elementalpop_sting";
  perk_machine.target = "vending_elemental_pop";
  bump_trigger.script_string = "elemental_perk";
  bump_trigger.targetname = "vending_elemental_pop";

  if(isDefined(collision)) {
    collision.script_string = "elemental_perk";
  }

  bump_trigger.use_func = &on_use;
}

function function_abddd809(inflictor, attacker, damage, flags, meansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(weapon === "MOD_AAT") {
    return flags;
  }

  if(isPlayer(damage) && !(self.zm_ai_category === # "elite") && !(self.zm_ai_category === # "boss")) {
    if(damage namespace_e86ffa8::function_cd6787b()) {
      if(isvehicle(attacker) && !damage namespace_e86ffa8::function_cd6787b(1)) {
        return flags;
      }

      if(!isDefined(damage.var_4caed594)) {
        damage.var_4caed594 = 0;
      }

      if(math::cointoss(5) && flags > 1 && damage is_valid_weapon(var_fd90b0bb) && damage.var_4caed594 + int(15 * 1000) < gettime()) {
        b_death = flags > self.health;
        str_name = damage.aat[aat::function_702fb333(var_fd90b0bb)];
        a_aat = getarraykeys(level.var_e44e90d6);
        arrayremovevalue(a_aat, "ammomod_electriccherry");
        str_choice = array::random(a_aat);
        damage.var_2defbefd = 1;
        w_aat = getweapon(#"hash_2b2738038b4c33be");
        var_bebe15e1 = 0;
        weapon = "MOD_PISTOL_BULLET";

        if(damage namespace_e86ffa8::function_cd6787b(3)) {
          n_tier = damage zm_aat::function_14ccd92a(str_choice);

          if(!isDefined(n_tier)) {
            n_tier = 0;
          }

          str_choice = n_tier < 0 ? str_choice : str_choice + "_" + n_tier;
        }

        damage.aat[w_aat] = str_choice;

        if(self.zm_ai_category === # "normal" || self.zm_ai_category === # "special" && isDefined(n_tier) && n_tier > 3) {
          damage clientfield::increment_to_player("" + # "hash_12c6e46c315cd43b", 1);
          aat::aat_response(b_death, attacker, damage, flags, meansofdeath, weapon, w_aat, var_bebe15e1, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
          damage.var_4caed594 = gettime();
        }

        damage thread function_751b9d86(w_aat);
      }
    }
  }

  return flags;
}

function function_751b9d86(w_aat) {
  self endon(#"death");
  self notify("3b0a02adb5fc6c9b");
  self endon("3b0a02adb5fc6c9b");
  waitframe(2);
  self.aat[w_aat] = undefined;
  self.var_13a70bc8 = undefined;
}

function is_valid_weapon(weapon) {
  if(weapon === level.weaponnone || weapon === level.weaponbasemeleeheld) {
    return false;
  }

  if(isDefined(weapon.dualwieldweapon) && is_true(weapon.var_bf0eb41)) {
    weapon = weapon.dualwieldweapon;
  }

  if(is_true(weapon.isprimary)) {
    return true;
  }

  if(self namespace_e86ffa8::function_cd6787b(1)) {
    if(weapon.inventorytype === "offhand") {
      return true;
    }
  }

  return false;
}

function on_use(player) {
  self clientfield::increment("" + # "hash_2bc83061af453e44");
}

function function_fdaa251f() {
  if(self namespace_e86ffa8::function_cd6787b(5)) {
    self thread function_a26b7152();
  }
}

function function_cf066d32(b_pause, str_perk, str_result, n_slot) {
  self notify(#"talent_elemental_pop" + "_take");
}

function function_a26b7152() {
  self endon(#"disconnect", #"talent_elemental_pop" + "_take");
  self.wait_on_reload = [];
  self.var_cb7633ba = 0;

  while(true) {
    self waittill(#"reload_start");
    current_weapon = self getcurrentweapon();

    if(isinarray(self.wait_on_reload, current_weapon)) {
      continue;
    }

    if(current_weapon.isabilityweapon) {
      continue;
    }

    if(!isDefined(self.wait_on_reload)) {
      self.wait_on_reload = [];
    } else if(!isarray(self.wait_on_reload)) {
      self.wait_on_reload = array(self.wait_on_reload);
    }

    if(!isinarray(self.wait_on_reload, current_weapon)) {
      self.wait_on_reload[self.wait_on_reload.size] = current_weapon;
    }

    self.var_cb7633ba++;
    n_clip_current = self getweaponammoclip(current_weapon);
    n_clip_max = self getweaponammoclipsize(current_weapon);

    if(n_clip_max <= 0) {
      continue;
    }

    n_fraction = 1 - n_clip_current / n_clip_max;

    if(n_fraction < 0) {
      n_fraction = 0;
    } else if(n_fraction > 1) {
      n_fraction = 1;
    }

    perk_radius = mapfloat(0, 1, 32, 128, n_fraction);
    perk_dmg = mapfloat(0, 1, 1, 200, n_fraction);

    if(zm_utility::is_survival()) {
      perk_dmg = zm_equipment::function_739fbb72(perk_dmg);
    } else {
      perk_dmg = zm_equipment::function_379f6b5d(perk_dmg);
    }

    self thread check_for_reload_complete(current_weapon);

    if(isDefined(self)) {
      switch (self.var_cb7633ba) {
        case 0:
        case 1:
          n_zombie_limit = undefined;
          break;
        case 2:
          n_zombie_limit = 8;
          break;
        case 3:
          n_zombie_limit = 4;
          break;
        case 4:
          n_zombie_limit = 2;
          break;
        default:
          n_zombie_limit = 0;
          break;
      }

      self thread function_7c82917f(current_weapon);

      if(isDefined(n_zombie_limit) && n_zombie_limit == 0) {
        continue;
      }

      self thread elemental_pop_reload_fx(n_fraction);
      self notify(#"hash_410b85a0d0e82dc1");
      self playSound(#"hash_44f5e332b770413c");
      a_zombies = getaiteamarray(level.zombie_team);
      a_zombies = arraysortclosest(a_zombies, self.origin, undefined, undefined, perk_radius);
      n_zombies_hit = 0;

      for(i = 0; i < a_zombies.size; i++) {
        if(isalive(self) && isalive(a_zombies[i])) {
          if(isDefined(n_zombie_limit)) {
            if(n_zombies_hit < n_zombie_limit) {
              n_zombies_hit++;
            } else {
              break;
            }
          }

          if(a_zombies[i].health <= perk_dmg) {
            a_zombies[i] thread function_3a74fa68(self);

            if(isDefined(self.var_75b93fdb)) {
              self.var_75b93fdb++;
            }
          } else {
            a_zombies[i] thread function_c262b70e(self);
            a_zombies[i] thread function_99e4dfef();
          }

          wait 0.1;

          if(isDefined(a_zombies[i]) && isalive(a_zombies[i])) {
            a_zombies[i] dodamage(perk_dmg, self.origin, self, self, "none", "MOD_UNKNOWN", 0, level.weapondefault);
          }
        }
      }

      self notify(#"hash_519404e413ec7fa0");
    }
  }
}

function function_7c82917f(current_weapon) {
  self notify("6c2ff240c1061e6f");
  self endon("6c2ff240c1061e6f");
  self endon(#"disconnect");
  n_reload_time = isDefined(current_weapon.reloadtime) ? current_weapon.reloadtime : 0.25;

  if(self namespace_e86ffa8::function_efb6dedf()) {
    n_reload_time *= getdvarfloat(#"perk_weapreloadmultiplier", 0);
  }

  n_cooldown_time = n_reload_time + 3;
  wait n_cooldown_time;
  self.var_cb7633ba = 0;
}

function check_for_reload_complete(weapon) {
  self endon(#"disconnect", "player_lost_weapon_" + weapon.name);
  self thread weapon_replaced_monitor(weapon);

  while(true) {
    self waittill(#"reload", #"hash_278526d0bbdb4ce7");
    current_weapon = self getcurrentweapon();

    if(current_weapon == weapon) {
      arrayremovevalue(self.wait_on_reload, weapon);
      self notify("weapon_reload_complete_" + weapon.name);
      break;
    }
  }
}

function weapon_replaced_monitor(weapon) {
  self endon(#"disconnect", "weapon_reload_complete_" + weapon.name);

  while(true) {
    self waittill(#"weapon_change");
    primaryweapons = self getweaponslistprimaries();

    if(!isinarray(primaryweapons, weapon)) {
      arrayremovevalue(self.wait_on_reload, weapon);
      self notify("player_lost_weapon_" + weapon.name);
      break;
    }
  }
}

function elemental_pop_reload_fx(n_fraction) {
  self endon(#"disconnect");

  if(n_fraction >= 0.67) {
    self clientfield::set("elemental_pop_reload_fx", 1);
  } else if(n_fraction >= 0.33 && n_fraction < 0.67) {
    self clientfield::set("elemental_pop_reload_fx", 2);
  } else {
    self clientfield::set("elemental_pop_reload_fx", 3);
  }

  wait 1;
  self clientfield::set("elemental_pop_reload_fx", 0);
}

function function_c262b70e(player) {
  self notify(#"stun_zombie");
  self endon(#"death", #"stun_zombie");

  if(self.health <= 0) {
    iprintln("<dev string:x38>");

    return;
  }

  if(self.zm_ai_category === # "special" || self.zm_ai_category === # "elite" || self.zm_ai_category === # "boss") {
    return;
  }

  self ai::stun(4);
  self val::set(#"hash_76ad14d5686b6f9f", "ignoreall", 1);

  if(isPlayer(player)) {
    player zm_stats::increment_challenge_stat(#"hash_19ddacc82a4cd51f");
  }

  wait 4;

  if(isDefined(self)) {
    self ai::clear_stun();
    self val::reset(#"hash_76ad14d5686b6f9f", "ignoreall");
    self notify(#"stun_fx_end");
  }
}

function function_99e4dfef() {
  self endon(#"death");

  if(isvehicle(self)) {
    self clientfield::set("tesla_shock_eyes_fx", 1);
  } else {
    self clientfield::set("tesla_shock_eyes_fx", 1);
  }

  self waittill(#"stun_fx_end");

  if(isvehicle(self)) {
    self clientfield::set("tesla_shock_eyes_fx", 0);
    return;
  }

  self clientfield::set("tesla_shock_eyes_fx", 0);
}

function function_3a74fa68(player) {
  self endon(#"death");

  if(!is_true(self.head_gibbed)) {
    self clientfield::set("tesla_shock_eyes_fx", 1);
  } else {
    self clientfield::set("tesla_death_fx", 1);
  }

  if(isPlayer(player)) {
    player zm_stats::increment_challenge_stat(#"hash_19ddacc82a4cd51f");
  }
}

function function_70c2d1b6() {
  self endon(#"disconnect");
  visionsetlaststand("zombie_last_stand", 1);

  if(isDefined(self)) {
    playFX(#"hash_70912cde462752a8", self.origin);
    self playSound(#"hash_75ba32e48680203a");
    self notify(#"hash_410b85a0d0e82dc1");
    waitframe(1);
    a_zombies = getaiteamarray(level.zombie_team);
    a_zombies = arraysortclosest(a_zombies, self.origin, undefined, undefined, 500);
    n_damage = 200;

    if(zm_utility::is_survival()) {
      n_damage = zm_equipment::function_739fbb72(n_damage);
    } else {
      n_damage = zm_equipment::function_379f6b5d(n_damage);
    }

    for(i = 0; i < a_zombies.size; i++) {
      if(isalive(self) && isalive(a_zombies[i])) {
        if(a_zombies[i].health <= n_damage) {
          a_zombies[i] thread function_3a74fa68();

          if(isDefined(self.var_75b93fdb)) {
            self.var_75b93fdb++;
          }
        } else {
          a_zombies[i] thread function_c262b70e();
          a_zombies[i] thread function_99e4dfef();
        }

        wait 0.1;

        if(isalive(self) && isalive(a_zombies[i])) {
          if(a_zombies[i].health - n_damage <= 0) {
            a_zombies[i].var_4f3445ab = 1;
          }

          a_zombies[i] dodamage(n_damage, self.origin, self, self, "none", "MOD_UNKNOWN", 0, level.weapondefault);
        }
      }
    }

    self notify(#"hash_519404e413ec7fa0");
  }
}