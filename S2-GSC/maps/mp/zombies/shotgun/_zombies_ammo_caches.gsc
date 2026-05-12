/************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\shotgun\_zombies_ammo_caches.gsc
************************************************************/

ammo_cache_setup() {
  var_00 = common_scripts\utility::func_44BE("ammo_cache", "targetname");
  var_01 = 500;
  foreach(var_03 in var_00) {
    var_04 = common_scripts\utility::func_44BE(var_03.var_1A2, "targetname");
    var_03.var_9DC2 = [];
    var_03.var_629F = [];
    foreach(var_06 in var_04) {
      var_07 = var_06.var_165;
      if(!isDefined(var_07)) {
        continue;
      }

      switch (var_07) {
        case "ammo_cache_trigger":
          var_06.look_pos = var_03.var_116;
          var_06.var_267B = var_01;
          var_03.var_9DC2[var_03.var_9DC2.size] = var_06;
          break;

        case "ammo_cache_model":
          var_03.var_629F[var_03.var_629F.size] = var_06;
          break;
      }
    }

    foreach(var_0A in var_03.var_9DC2) {
      var_0A usetouchtriggerrequirefacingposition(1, var_03.var_116);
      var_0A.face_pos = var_03.var_116;
      if(lib_0547::func_5819(var_0A)) {
        lib_0547::func_8A4F(var_0A, ::ammo_cache_update_hints_for_player);
      } else {}

      var_0A thread ammo_cache_think(var_03, var_0A.var_267B);
    }
  }

  level thread maps\mp\_utility::func_6F74(::ammo_cache_low_ammo_highlight);
}

ammo_cache_update_hints_for_player(param_00) {
  var_01 = self;
  param_00 endon("disconnect");
  param_00.ammo_cache_available_uses = 3;
  param_00.ammo_cache_uses = 0;
  var_02 = lib_0552::func_7BE1(param_00, self, 1, self.face_pos);
  var_02.var_4028 = lib_0552::func_44FF("ammo_cache_3");
  var_03 = 500;
  for(;;) {
    waittillframeend;
    var_02.var_6642 = 1;
    var_02.var_401E = var_03;
    self.var_267B = int(var_02.var_401E);
    var_04 = common_scripts\utility::func_A70E(param_00, "ammo_cache_used", level, "sg_obj_end");
    var_05 = var_04[0];
    var_06 = var_04[1];
    waittillframeend;
    if(lib_0547::func_5565(var_05, "sg_obj_end")) {
      if(param_00.ammo_cache_available_uses < 3) {
        param_00.ammo_cache_available_uses++;
      }
    } else {
      var_03 = var_03 * 2;
      if(var_03 > 2000) {
        var_03 = 2000;
      }
    }

    var_07 = "ammo_cache_3";
    if(param_00.ammo_cache_available_uses == 2) {
      var_07 = "ammo_cache_2";
    } else if(param_00.ammo_cache_available_uses == 1) {
      var_07 = "ammo_cache_1";
    } else if(param_00.ammo_cache_available_uses <= 0) {
      var_07 = "ammo_cache_0";
    }

    var_02.var_4028 = lib_0552::func_44FF(var_07);
  }
}

ammo_cache_get_cost_for_player(param_00, param_01) {
  return 500;
}

ammo_cache_hide_from_other_player() {}

ammo_cache_think(param_00, param_01) {
  var_02 = self;
  for(;;) {
    var_03 = var_02 lib_0547::func_A795();
    var_04 = var_03[0];
    var_05 = var_03[1];
    var_06 = lib_0547::func_462A(var_04);
    var_07 = 0;
    if(!lib_0547::func_5836(var_06)) {
      continue;
    }

    if(maps\mp\zombies\_zombies_magicbox::func_4B6A(var_04, var_06)) {
      maps\mp\zombies\_zombies_magicbox::func_300A(var_04, var_07);
      continue;
    }

    if(var_04.ammo_cache_available_uses <= 0) {
      lib_0555::func_83DD("blitz_soldout", var_04);
      continue;
    }

    if(var_04 maps\mp\gametypes\zombies::func_11C2(var_02.var_267B)) {
      maps\mp\zombies\_zombies_magicbox::func_3AC1(var_04, var_06);
      var_04.ammo_cache_uses++;
      var_04.ammo_cache_available_uses--;
      var_04 notify("ammo_cache_used");
      var_04 givemaxammo(var_06);
      var_04 thread lib_054E::func_62D9();
      continue;
    }

    var_04 thread lib_054E::func_695("needmoney");
  }
}

ammo_cache_low_ammo_remove_highlights(param_00) {
  var_01 = common_scripts\utility::func_44BE("ammo_cache", "targetname");
  foreach(var_03 in var_01) {
    foreach(var_05 in var_03.var_629F) {
      var_05 hudoutlinedisableforclient(param_00);
    }
  }

  param_00.caches_highlighted = 0;
}

ammo_cache_low_ammo_apply_highlights(param_00) {
  var_01 = common_scripts\utility::func_44BE("ammo_cache", "targetname");
  foreach(var_03 in var_01) {
    foreach(var_05 in var_03.var_629F) {
      var_05 hudoutlineenableforclient(param_00, 0, 0);
    }
  }

  param_00.caches_highlighted = 1;
}

ammo_cache_low_ammo_highlight() {
  var_00 = self;
  var_00 endon("disconnect");
  if(!isalive(var_00)) {
    var_00 common_scripts\utility::knock_off_battery("spawned_player", "faux_spawn");
  }

  var_00.caches_highlighted = 0;
  var_00.ammocachelowammohighlightneedsupdate = 1;
  var_00 childthread ammo_cache_low_ammo_highlight_watcher();
  var_01 = 0.2;
  while(isDefined(var_00) && var_00 getentitynumber() % 4 != int(gettime() / 50) % 4) {
    wait 0.05;
  }

  var_02 = common_scripts\utility::func_44BE("ammo_cache", "targetname");
  while(isDefined(var_00)) {
    wait(var_01);
    if(!common_scripts\utility::func_562E(var_00.ammocachelowammohighlightneedsupdate)) {
      continue;
    }

    var_00.ammocachelowammohighlightneedsupdate = 0;
    if(!isalive(var_00)) {
      if(common_scripts\utility::func_562E(var_00.caches_highlighted)) {
        ammo_cache_low_ammo_remove_highlights(var_00);
      }

      continue;
    }

    if(lib_0547::func_577E(var_00)) {
      continue;
    }

    var_03 = var_00 getcurrentweapon();
    if(lib_0547::func_5565(var_03, "none")) {
      continue;
    }

    if(lib_0547::func_5865(var_03) || lib_0547::func_585B(var_03) || lib_0547::iszombieconsumableweapon(var_03) || lib_0547::func_585C(var_03)) {
      continue;
    }

    var_04 = var_00 getfractionmaxammo(var_03);
    if(var_04 >= 0.2) {
      if(common_scripts\utility::func_562E(var_00.caches_highlighted)) {
        ammo_cache_low_ammo_remove_highlights(var_00);
      }

      continue;
    }

    if(var_00.ammo_cache_available_uses <= 0) {
      if(common_scripts\utility::func_562E(var_00.caches_highlighted)) {
        ammo_cache_low_ammo_remove_highlights(var_00);
      }

      continue;
    }

    ammo_cache_low_ammo_apply_highlights(var_00);
  }
}

ammo_cache_low_ammo_highlight_watcher() {
  var_00 = self;
  while(isDefined(var_00)) {
    var_01 = common_scripts\utility::func_A70E(var_00, "weapon_fired", var_00, "weapon_change", var_00, "ammo_cache_used", var_00, "death", level, "maxAmmoPickup");
    var_02 = var_01[0];
    var_03 = var_01[1];
    var_00.ammocachelowammohighlightneedsupdate = 1;
  }
}