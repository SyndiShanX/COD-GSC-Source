/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_sotf.gsc
**************************************************/

function main() {
  setup_callbacks();
  setup_bot_sotf();
}

function setup_callbacks() {
  level.bot_funcs["dropped_weapon_think"] = &sotf_bot_think_seek_dropped_weapons;
  level.bot_funcs["dropped_weapon_cancel"] = &sotf_should_stop_seeking_weapon;
  level.bot_funcs["crate_low_ammo_check"] = &sotf_crate_low_ammo_check;
  level.bot_funcs["crate_should_claim"] = &sotf_crate_should_claim;
  level.bot_funcs["crate_wait_use"] = &sotf_crate_wait_use;
  level.bot_funcs["crate_in_range"] = &sotf_crate_in_range;
  level.bot_funcs["crate_can_use"] = &sotf_crate_can_use;
}

function setup_bot_sotf() {
  level.bots_gametype_handles_class_choice = 1;
}

function sotf_should_stop_seeking_weapon(var0) {
  if(scripts\mp\bots\bots_util::bot_get_total_gun_ammo() > 0) {
    var1 = scripts\mp\utility\weapon::getweapongroup(self getcurrentweapon());

    if(isDefined(var0.object)) {
      var2 = var0.object.classname;

      if(scripts\engine\utility::string_starts_with(var2, "weapon_")) {
        var2 = getsubstr(var2, 7);
      }

      var3 = scripts\mp\utility\weapon::getweapongroup(var2);

      if(!bot_weapon_is_better_class(var1, var3)) {
        return true;
      }
    }
  }

  if(!isDefined(var0.object)) {
    return true;
  }

  return false;
}

function sotf_bot_think_seek_dropped_weapons() {
  self notify("bot_think_seek_dropped_weapons");
  self endon("bot_think_seek_dropped_weapons");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    var0 = 0;

    if(self[[level.bot_funcs["should_pickup_weapons"]]]() && !scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
      if(scripts\mp\bots\bots_util::bot_out_of_ammo()) {
        var1 = getEntArray("dropped_weapon", "targetname");
        var2 = scripts\engine\utility::get_array_of_closest(self.origin, var1);

        if(var2.size > 0) {
          var3 = var2[0];
          scripts\mp\bots\bots::bot_seek_dropped_weapon(var3);
        }
      } else {
        var1 = getEntArray("dropped_weapon", "targetname");
        var2 = scripts\engine\utility::get_array_of_closest(self.origin, var1);

        if(var2.size > 0) {
          var4 = self getnearestnode();

          if(isDefined(var4)) {
            var5 = scripts\mp\utility\weapon::getweapongroup(self getcurrentweapon());

            foreach(var3 in var2) {
              var7 = var3.classname;

              if(scripts\engine\utility::string_starts_with(var7, "weapon_")) {
                var7 = getsubstr(var7, 7);
              }

              var8 = scripts\mp\utility\weapon::getweapongroup(var7);

              if(bot_weapon_is_better_class(var5, var8)) {
                if(!isDefined(var3.calculated_nearest_node) || !var3.calculated_nearest_node) {
                  var3.nearest_node = getclosestnodeinsight(var3.origin);
                  var3.calculated_nearest_node = 1;
                }

                if(isDefined(var3.nearest_node) && nodesvisible(var4, var3.nearest_node, 1)) {
                  scripts\mp\bots\bots::bot_seek_dropped_weapon(var3);
                  break;
                }
              }
            }
          }
        }
      }
    }

    wait randomfloatrange(0.25, 0.75);
  }
}

function bot_rank_weapon_class(var0) {
  var1 = 0;

  switch (var0) {
    case "weapon_other":
    case "weapon_projectile":
    case "weapon_explosive":
    case "weapon_grenade":
      break;
    case "weapon_pistol":
      var1 = 1;
      break;
    case "weapon_dmr":
    case "weapon_sniper":
      var1 = 2;
      break;
    case "weapon_shotgun":
    case "weapon_lmg":
    case "weapon_assault":
    case "weapon_smg":
    case "weapon_tactical":
      var1 = 3;
      break;
  }

  return var1;
}

function bot_weapon_is_better_class(var0, var1) {
  var2 = bot_rank_weapon_class(var0);
  var3 = bot_rank_weapon_class(var1);
  return var3 > var2;
}

function sotf_crate_low_ammo_check() {
  var0 = self getcurrentweapon();
  var1 = self getweaponammoclip(var0);
  var2 = self getweaponammostock(var0);
  var3 = weaponclipsize(var0);
  return var1 + var2 < var3 * 0.25;
}

function sotf_crate_should_claim() {
  return false;
}

function sotf_crate_wait_use() {
  scripts\mp\bots\bots_util::bot_waittill_out_of_combat_or_time(5000);
}

function sotf_crate_in_range(var0) {
  return true;
}

function sotf_crate_can_use(var0) {
  if(scripts\mp\bots\bots::crate_can_use_always(var0)) {
    if(isDefined(var0) && isDefined(var0.bots_used) && scripts\engine\utility::array_contains(var0.bots_used, self)) {
      if(scripts\mp\bots\bots_util::bot_out_of_ammo()) {
        return true;
      } else {
        return false;
      }
    }

    var1 = scripts\mp\utility\weapon::getweapongroup(self getcurrentweapon());

    if(bot_rank_weapon_class(var1) <= 1) {
      return true;
    }

    if(sotf_crate_low_ammo_check()) {
      return true;
    }

    return false;
  }

  return false;
}