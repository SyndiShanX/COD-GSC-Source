/*********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\bots\gametype_sotf.gsc
*********************************************/

main() {
  setup_callbacks();
  setup_bot_sotf();
}

setup_callbacks() {
  level.bot_funcs["dropped_weapon_think"] = ::sotf_bot_think_seek_dropped_weapons;
  level.bot_funcs["dropped_weapon_cancel"] = ::sotf_should_stop_seeking_weapon;
  level.bot_funcs["crate_low_ammo_check"] = ::sotf_crate_low_ammo_check;
  level.bot_funcs["crate_should_claim"] = ::sotf_crate_should_claim;
  level.bot_funcs["crate_wait_use"] = ::sotf_crate_wait_use;
  level.bot_funcs["crate_in_range"] = ::sotf_crate_in_range;
  level.bot_funcs["crate_can_use"] = ::sotf_crate_can_use;
}

setup_bot_sotf() {
  level.bots_gametype_handles_class_choice = 1;
}

sotf_should_stop_seeking_weapon(var_0) {
  if(scripts\mp\bots\_bots_util::bot_get_total_gun_ammo() > 0) {
    var_1 = scripts\mp\utility::getweapongroup(self getcurrentweapon());
    if(isDefined(var_0.object)) {
      var_2 = var_0.object.classname;
      if(scripts\engine\utility::string_starts_with(var_2, "weapon_")) {
        var_2 = getsubstr(var_2, 7);
      }

      var_3 = scripts\mp\utility::getweapongroup(var_2);
      if(!bot_weapon_is_better_class(var_1, var_3)) {
        return 1;
      }
    }
  }

  if(!isDefined(var_0.object)) {
    return 1;
  }

  return 0;
}

sotf_bot_think_seek_dropped_weapons() {
  self notify("bot_think_seek_dropped_weapons");
  self endon("bot_think_seek_dropped_weapons");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    var_0 = 0;
    if(self[[level.bot_funcs["should_pickup_weapons"]]]() && !scripts\mp\bots\_bots_util::bot_is_remote_or_linked()) {
      if(scripts\mp\bots\_bots_util::bot_out_of_ammo()) {
        var_1 = getEntArray("dropped_weapon", "targetname");
        var_2 = scripts\engine\utility::get_array_of_closest(self.origin, var_1);
        if(var_2.size > 0) {
          var_3 = var_2[0];
          scripts\mp\bots\_bots::bot_seek_dropped_weapon(var_3);
        }
      } else {
        var_1 = getEntArray("dropped_weapon", "targetname");
        var_2 = scripts\engine\utility::get_array_of_closest(self.origin, var_2);
        if(var_2.size > 0) {
          var_4 = self getnearestnode();
          if(isDefined(var_4)) {
            var_5 = scripts\mp\utility::getweapongroup(self getcurrentweapon());
            foreach(var_3 in var_2) {
              var_7 = var_3.classname;
              if(scripts\engine\utility::string_starts_with(var_7, "weapon_")) {
                var_7 = getsubstr(var_7, 7);
              }

              var_8 = scripts\mp\utility::getweapongroup(var_7);
              if(bot_weapon_is_better_class(var_5, var_8)) {
                if(!isDefined(var_3.calculated_nearest_node) || !var_3.calculated_nearest_node) {
                  var_3.nearest_node = getclosestnodeinsight(var_3.origin);
                  var_3.calculated_nearest_node = 1;
                }

                if(isDefined(var_3.nearest_node) && nodesvisible(var_4, var_3.nearest_node, 1)) {
                  scripts\mp\bots\_bots::bot_seek_dropped_weapon(var_3);
                  break;
                }
              }
            }
          }
        }
      }
    }

    wait(randomfloatrange(0.25, 0.75));
  }
}

bot_rank_weapon_class(var_0) {
  var_1 = 0;
  switch (var_0) {
    case "weapon_other":
    case "weapon_explosive":
    case "weapon_grenade":
    case "weapon_projectile":
      break;

    case "weapon_pistol":
      var_1 = 1;
      break;

    case "weapon_dmr":
    case "weapon_sniper":
      var_1 = 2;
      break;

    case "weapon_shotgun":
    case "weapon_lmg":
    case "weapon_assault":
    case "weapon_smg":
      var_1 = 3;
      break;
  }

  return var_1;
}

bot_weapon_is_better_class(var_0, var_1) {
  var_2 = bot_rank_weapon_class(var_0);
  var_3 = bot_rank_weapon_class(var_1);
  return var_3 > var_2;
}

sotf_crate_low_ammo_check() {
  var_0 = self getcurrentweapon();
  var_1 = self getweaponammoclip(var_0);
  var_2 = self getweaponammostock(var_0);
  var_3 = weaponclipsize(var_0);
  return var_1 + var_2 < var_3 * 0.25;
}

sotf_crate_should_claim() {
  return 0;
}

sotf_crate_wait_use() {
  scripts\mp\bots\_bots_util::bot_waittill_out_of_combat_or_time(5000);
}

sotf_crate_in_range(var_0) {
  return 1;
}

sotf_crate_can_use(var_0) {
  if(scripts\mp\bots\_bots::crate_can_use_always(var_0)) {
    if(isDefined(var_0) && isDefined(var_0.bots_used) && scripts\engine\utility::array_contains(var_0.bots_used, self)) {
      if(scripts\mp\bots\_bots_util::bot_out_of_ammo()) {
        return 1;
      } else {
        return 0;
      }
    }

    var_1 = scripts\mp\utility::getweapongroup(self getcurrentweapon());
    if(bot_rank_weapon_class(var_1) <= 1) {
      return 1;
    }

    if(sotf_crate_low_ammo_check()) {
      return 1;
    }

    return 0;
  }

  return 0;
}