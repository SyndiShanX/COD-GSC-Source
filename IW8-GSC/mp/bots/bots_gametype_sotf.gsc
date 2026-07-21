/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_gametype_sotf.gsc
***********************************************/

main() {
  setup_callbacks();
  setup_bot_sotf();
}

setup_callbacks() {
  level.bot_funcs["_encstr_AB45151102CF209FFA23072F5FC2E79096D19B286C265B"] = ::sotf_bot_think_seek_dropped_weapons;
  level.bot_funcs["_encstr_8E6C1675DAB2A1335DA3D1988F710B270A097E0F35AA43F8"] = ::sotf_should_stop_seeking_weapon;
  level.bot_funcs["_encstr_91C915D84EB08E2BEBD8DBBBAF2CB5B5ED7D8D1AAC6CD6"] = ::sotf_crate_low_ammo_check;
  level.bot_funcs["_encstr_B2A713E34651AB2FCFF0E2AAF891274F4921699151"] = ::sotf_crate_should_claim;
  level.bot_funcs["_encstr_9B600F8B0DE0F3675813129A9BB0FFEA68"] = ::sotf_crate_wait_use;
  level.bot_funcs["_encstr_B8430FFED25AA1E91F9F40D1EB79C0CFA2"] = ::sotf_crate_in_range;
  level.bot_funcs["_encstr_99EB0E12DB5279E596CEBBD2C11B30F8"] = ::sotf_crate_can_use;
}

setup_bot_sotf() {
  level.bots_gametype_handles_class_choice = 1;
}

sotf_should_stop_seeking_weapon(var_0) {
  if(scripts\mp\bots\bots_util::bot_get_total_gun_ammo() > 0) {
    var_1 = scripts\mp\utility\weapon::getweapongroup(self getcurrentweapon());

    if(isDefined(var_0.object)) {
      var_2 = var_0.object.classname;

      if(scripts\engine\utility::string_starts_with(var_2, "_encstr_B2010820C5337B67C8CF"))
        var_2 = getsubstr(var_2, 7);

      var_3 = scripts\mp\utility\weapon::getweapongroup(var_2);

      if(!bot_weapon_is_better_class(var_1, var_3))
        return 1;
    }
  }

  if(!isDefined(var_0.object))
    return 1;

  return 0;
}

sotf_bot_think_seek_dropped_weapons() {
  self notify("_encstr_BEF81F651FE30808D8EC70A819ABC85D4A77D1CD874B6758EC495B61BE70603763");
  self endon("_encstr_BEF81F651FE30808D8EC70A819ABC85D4A77D1CD874B6758EC495B61BE70603763");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_0 = 0;

    if(self[[level.bot_funcs["_encstr_8252168E297F97F00D3748CB8040537BE0831F5F11D0E6B7"]]]() && !scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
      if(scripts\mp\bots\bots_util::bot_out_of_ammo()) {
        var_1 = getEntArray("_encstr_AD580F5F2388E9EB57322E3069A1074090", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
        var_2 = scripts\engine\utility::get_array_of_closest(self.origin, var_1);

        if(var_2.size > 0) {
          var_3 = var_2[0];
          scripts\mp\bots\bots::bot_seek_dropped_weapon(var_3);
        }
      } else {
        var_1 = getEntArray("_encstr_AD580F5F2388E9EB57322E3069A1074090", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
        var_2 = scripts\engine\utility::get_array_of_closest(self.origin, var_1);

        if(var_2.size > 0) {
          var_4 = self getnearestnode();

          if(isDefined(var_4)) {
            var_5 = scripts\mp\utility\weapon::getweapongroup(self getcurrentweapon());

            foreach(var_3 in var_2) {
              var_7 = var_3.classname;

              if(scripts\engine\utility::string_starts_with(var_7, "_encstr_B2010820C5337B67C8CF"))
                var_7 = getsubstr(var_7, 7);

              var_8 = scripts\mp\utility\weapon::getweapongroup(var_7);

              if(bot_weapon_is_better_class(var_5, var_8)) {
                if(!isDefined(var_3.calculated_nearest_node) || !var_3.calculated_nearest_node) {
                  var_3.nearest_node = getclosestnodeinsight(var_3.origin);
                  var_3.calculated_nearest_node = 1;
                }

                if(isDefined(var_3.nearest_node) && nodesvisible(var_4, var_3.nearest_node, 1)) {
                  scripts\mp\bots\bots::bot_seek_dropped_weapon(var_3);
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
    case "_encstr_A5EB0D7BCFF9182842D76F51639AEE":
    case "_encstr_BDBF1277568507DEE67D0E9CED4DB21BA32DB195":
    case "_encstr_998911DD5916C17BCDD795F01CB17B6E5AB356":
    case "_encstr_82F10F832FFB4B67E0E9897260907E55FA":
      break;
    case "_encstr_ABC90E77AC5883F6DCBE38A5CD1D7B36":
      var_1 = 1;
      break;
    case "_encstr_A1710B57AD31DBCDCDF1422A60":
    case "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33":
      var_1 = 2;
      break;
    case "_encstr_87E60F77CA0BC1DB37BEE6D0DE47D9ABB9":
    case "_encstr_A3710BEEACC2E0B737EB36B676":
    case "_encstr_8E250FDD59C283DE37F5169BCD85BA1B1D":
    case "_encstr_AF710BF4355A9195B0FF0AEAD0":
    case "_encstr_9B65109F23E0F24FC016431A79258FEE4889":
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
  scripts\mp\bots\bots_util::bot_waittill_out_of_combat_or_time(5000);
}

sotf_crate_in_range(var_0) {
  return 1;
}

sotf_crate_can_use(var_0) {
  if(scripts\mp\bots\bots::crate_can_use_always(var_0)) {
    if(isDefined(var_0) && isDefined(var_0.bots_used) && scripts\engine\utility::array_contains(var_0.bots_used, self)) {
      if(scripts\mp\bots\bots_util::bot_out_of_ammo())
        return 1;
      else
        return 0;
    }

    var_1 = scripts\mp\utility\weapon::getweapongroup(self getcurrentweapon());

    if(bot_rank_weapon_class(var_1) <= 1)
      return 1;

    if(sotf_crate_low_ammo_check())
      return 1;

    return 0;
  }

  return 0;
}