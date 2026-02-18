/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\killstreaks_shared.csc
***********************************************/

#using script_13da4e6b98ca81a1;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\renderoverridebundle;
#using scripts\core_common\spawning_squad;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#namespace killstreaks;

function init_shared() {
  clientfield::register_clientuimodel("locSel.commandMode", #"hash_5bbe0cd6740ab2b6", #"commandmode", 1, 1, "int", undefined, 0, 0);
  clientfield::register_clientuimodel("locSel.snapTo", #"hash_5bbe0cd6740ab2b6", #"snapto", 1, 1, "int", undefined, 0, 0);
  clientfield::register("vehicle", "timeout_beep", 1, 2, "int", &timeout_beep, 0, 0);
  clientfield::register("toplayer", "thermal_glow", 1, 1, "int", &function_6d265b7f, 0, 1);
  clientfield::register("toplayer", "thermal_glow_enemies_only", 12000, 1, "int", &function_c66f053, 0, 1);
  clientfield::register("allplayers", "killstreak_spawn_protection", 1, 1, "int", &function_77515127, 0, 0);
  clientfield::register("vehicle", "timeout_beep", 1, 2, "int", &timeout_beep, 0, 0);
  clientfield::register("vehicle", "standardTagFxSet", 1, 1, "int", &function_eef48704, 0, 0);
  clientfield::register("scriptmover", "standardTagFxSet", 1, 1, "int", &function_eef48704, 0, 0);
  clientfield::register("scriptmover", "lowHealthTagFxSet", 1, 1, "int", &function_11044e2b, 0, 0);
  clientfield::register("scriptmover", "deathTagFxSet", 1, 1, "int", &function_d440313, 0, 0);
  clientfield::register("toplayer", "" + # "hash_524d30f5676b2070", 1, 1, "int", &function_ce367b0c, 0, 0);
  clientfield::register("vehicle", "scorestreakActive", 1, 1, "int", &function_5ec060c4, 0, 0);
  clientfield::register("scriptmover", "scorestreakActive", 1, 1, "int", &function_5ec060c4, 0, 0);
  callback::on_spawned(&on_player_spawned);
  callback::function_74f5faf8(&function_74f5faf8);
  level.killstreakcorebundle = getscriptbundle("killstreak_core");
}

function private function_5ec060c4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    if(self.weapon == getweapon(#"uav") || self.weapon == getweapon(#"counteruav")) {
      if(self function_e9fc6a64()) {
        return;
      }
    }

    self function_1f0c7136(2);
  }
}

function timeout_beep(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self notify(#"timeout_beep");

  if(!bwastimejump) {
    return;
  }

  if(isDefined(self.killstreakbundle)) {
    beepalias = self.killstreakbundle.kstimeoutbeepalias;
  } else if(isDefined(self.settingsbundle)) {
    beepalias = self.settingsbundle.kstimeoutbeepalias;
    var_4f5f9e46 = self.settingsbundle.var_90af4f48;
  }

  self endon(#"death");
  self endon(#"timeout_beep");
  interval = 1;

  if(bwastimejump == 2) {}

  for(interval = 0.133; true; interval = math::clamp(interval / 1.17, 0.1, 1)) {
    if(isDefined(beepalias)) {
      var_91e09a3a = 1;

      if(var_4f5f9e46 === 1) {
        driver = self getlocalclientdriver();

        if(!isDefined(driver)) {
          var_91e09a3a = 0;
        }
      }

      if(var_91e09a3a) {
        offset = (0, 0, isDefined(self.killstreakbundle.var_19d5e80a) ? self.killstreakbundle.var_19d5e80a : 0);
        self playSound(fieldname, beepalias, self.origin + offset);
      }
    }

    if(self.timeoutlightsoff === 1) {
      self vehicle::lights_on(fieldname);
      self.timeoutlightsoff = 0;
    } else {
      self vehicle::lights_off(fieldname);
      self.timeoutlightsoff = 1;
    }

    util::server_wait(fieldname, interval);
  }
}

function function_6d265b7f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  players = getplayers(fieldname);

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    player renderoverridebundle::function_f4eab437(fieldname, bwastimejump, #"hash_2c6fce4151016478", &function_429c452);
  }
}

function function_c66f053(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  local_player = self;
  var_c86e6ba8 = self.team;
  players = getplayers(fieldname);
  should_play = bwastimejump == 1;

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    player renderoverridebundle::function_f4eab437(fieldname, should_play, #"hash_53798044d9a468d7", &function_e56218ab);
  }
}

function function_429c452(localclientnum, should_play) {
  if(!should_play) {
    return 0;
  }

  if(!isDefined(self)) {
    return 0;
  }

  if(!isPlayer(self)) {
    return should_play;
  }

  localplayer = function_5c10bd79(localclientnum);

  if(isDefined(localplayer) && !localplayer util::isenemyteam(self.team)) {
    return 0;
  }

  if(!function_266be0d4(localclientnum)) {
    return 0;
  }

  if(self hasperk(localclientnum, #"specialty_nokillstreakreticle")) {
    return 0;
  }

  if(self clientfield::get("killstreak_spawn_protection")) {
    return 0;
  }

  if(codcaster::function_c955fbd1(localclientnum)) {
    return 0;
  }

  return 1;
}

function function_e56218ab(localclientnum, should_play) {
  if(!should_play) {
    return 0;
  }

  if(!isDefined(self)) {
    return 0;
  }

  if(!isPlayer(self)) {
    return should_play;
  }

  localplayer = function_5c10bd79(localclientnum);

  if(isDefined(localplayer) && localplayer.team == self.team) {
    return 0;
  }

  if(!function_266be0d4(localclientnum)) {
    return 0;
  }

  if(self hasperk(localclientnum, #"specialty_nokillstreakreticle")) {
    return 0;
  }

  if(self clientfield::get("killstreak_spawn_protection")) {
    return 0;
  }

  if(codcaster::function_c955fbd1(localclientnum)) {
    return 0;
  }

  return 1;
}

function function_77515127(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread renderoverridebundle::function_ee77bff9(bwastimejump, "thermal_glow", #"hash_2c6fce4151016478", &function_429c452);
  self thread renderoverridebundle::function_ee77bff9(bwastimejump, "thermal_glow_enemies_only", #"hash_53798044d9a468d7", &function_e56218ab);
}

function on_player_spawned(localclientnum) {
  self renderoverridebundle::function_f4eab437(localclientnum, 0, #"hash_2c6fce4151016478");
  self renderoverridebundle::function_f4eab437(localclientnum, 0, #"hash_53798044d9a468d7");

  if(self function_da43934d()) {
    if(isDefined(self.var_29806c31) && self function_d2cb869e(self.var_29806c31)) {
      self codestoppostfxbundle(self.var_29806c31);
      self.var_29806c31 = undefined;
    }
  }
}

function function_74f5faf8(eventparams) {
  localclientnum = eventparams.localclientnum;
  var_dc39bd32 = function_5c10bd79(localclientnum);

  if(codcaster::function_c955fbd1(localclientnum)) {
    if(isDefined(var_dc39bd32.var_29806c31) && var_dc39bd32 function_d2cb869e(var_dc39bd32.var_29806c31)) {
      var_dc39bd32 codestoppostfxbundle(var_dc39bd32.var_29806c31);
    }

    foreach(player in getplayers(localclientnum)) {
      if(isDefined(player) && !function_3132f113(player)) {
        player renderoverridebundle::function_f4eab437(localclientnum, 0, #"hash_2c6fce4151016478");
      }
    }

    return;
  }

  if(codcaster::function_b8fe9b52(localclientnum)) {
    if(isDefined(var_dc39bd32.var_29806c31) && !var_dc39bd32 function_d2cb869e(var_dc39bd32.var_29806c31)) {
      var_dc39bd32 codeplaypostfxbundle(var_dc39bd32.var_29806c31);
    }
  }
}

function function_eef48704(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  entnum = self getentitynumber();
  function_fb18ebcc(fieldname, entnum);

  if(bwastimejump == 1) {
    self util::waittill_dobj(fieldname);
    waittillframeend();

    if(!isentity(self)) {
      return;
    }

    if(!isDefined(self.killstreakbundle.var_d81025a)) {
      return;
    }

    if(!isDefined(level.var_da32fba8)) {
      level.var_da32fba8 = [];
    }

    level.var_da32fba8[entnum] = playtagfxset(fieldname, self.killstreakbundle.var_d81025a, self);
  }
}

function function_fb18ebcc(localclientnum, entnum) {
  if(!isDefined(entnum)) {
    return;
  }

  if(!isDefined(level.var_da32fba8[entnum])) {
    return;
  }

  fxarray = level.var_da32fba8[entnum];

  foreach(fx_id in fxarray) {
    stopfx(localclientnum, fx_id);
  }

  level.var_da32fba8[entnum] = undefined;
}

function function_11044e2b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 0) {
    return;
  }

  if(!isDefined(self.killstreakbundle.var_7021eaaa)) {
    return;
  }

  self util::waittill_dobj(fieldname);

  if(!isentity(self)) {
    return;
  }

  if(!isDefined(self.killstreakbundle.var_7021eaaa)) {
    return;
  }

  playtagfxset(fieldname, self.killstreakbundle.var_7021eaaa, self);
}

function function_d440313(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 0) {
    return;
  }

  if(!isDefined(self.killstreakbundle.var_349c25fe)) {
    return;
  }

  self util::waittill_dobj(fieldname);

  if(!isentity(self)) {
    return;
  }

  if(!isDefined(self.killstreakbundle.var_349c25fe)) {
    return;
  }

  playtagfxset(fieldname, self.killstreakbundle.var_349c25fe, self);
}

function function_ce367b0c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"disconnect");

  if(isDefined(self.var_29806c31)) {
    if(self function_d2cb869e(self.var_29806c31)) {
      self codestoppostfxbundle(self.var_29806c31);
    }

    self.var_29806c31 = undefined;
  }

  if(squad_spawn::function_21b773d5(fieldname)) {
    return;
  }

  if(bwastimejump) {
    killstreakbundle = function_bd2d5a8e(self.weapon.name);
    postfxbundle = killstreakbundle.var_bda68f72;

    if(!isDefined(postfxbundle)) {
      return;
    }

    if(!codcaster::function_c955fbd1(fieldname)) {
      self codeplaypostfxbundle(postfxbundle);
    }

    self.var_29806c31 = postfxbundle;

    if(isDefined(killstreakbundle.var_d80ce136)) {
      self playSound(fieldname, killstreakbundle.var_d80ce136);
    }

    if(function_1cbf351b(fieldname) || function_65b9eb0f(fieldname)) {
      self thread function_2dab81c1(postfxbundle);
    }

    if(codcaster::function_b8fe9b52(fieldname)) {
      thread function_712a3516(fieldname, self, postfxbundle);
    }
  }
}

function private function_bd2d5a8e(killstreakweaponname) {
  if(!isDefined(killstreakweaponname)) {
    return;
  }

  switch (killstreakweaponname) {
    case # "inventory_ac130":
    case # "ac130":
      bundle = getscriptbundle("killstreak_ac130");
      break;
    case # "inventory_chopper_gunner":
    case # "chopper_gunner":
      bundle = getscriptbundle("killstreak_chopper_gunner");
      break;
    case # "recon_car":
    case # "inventory_recon_car":
      bundle = getscriptbundle("killstreak_recon_car");
      break;
    case # "remote_missile":
    case # "inventory_remote_missile":
      bundle = getscriptbundle("killstreak_remote_missile");
      break;
    default:
      break;
  }

  return bundle;
}

function function_2dab81c1(bundlename) {
  var_17b7891d = "18bfe48c89c5e499" + bundlename;
  self notify(var_17b7891d);
  self endon(var_17b7891d);
  localclientnum = self.localclientnum;
  self waittill(#"death");

  if(function_148ccc79(localclientnum, bundlename)) {
    codestoppostfxbundlelocal(localclientnum, bundlename);

    if(self.var_29806c31 === bundlename) {
      self.var_29806c31 = undefined;
    }
  }
}

function function_712a3516(localclientnum, var_38d5ac93, bundlename) {
  level endon(#"disconnect", #"game_ended");

  if(isDefined(var_38d5ac93) && isDefined(bundlename)) {
    playerentnum = var_38d5ac93 getentitynumber();

    while(true) {
      waitframe(1);

      if(!isDefined(var_38d5ac93) || !isDefined(var_38d5ac93.var_29806c31)) {
        player = getentbynum(localclientnum, playerentnum);

        if(isDefined(player) && player function_d2cb869e(bundlename)) {
          player codestoppostfxbundle(bundlename);
        }

        return;
      }
    }
  }
}

function is_killstreak_weapon(weapon) {
  if(!isDefined(weapon)) {
    return false;
  }

  if(weapon == level.weaponnone || weapon.notkillstreak) {
    return false;
  }

  if(weapon.isspecificuse || is_weapon_associated_with_killstreak(weapon)) {
    return true;
  }

  return false;
}

function private is_weapon_associated_with_killstreak(weapon) {
  return isDefined(level.killstreakweapons[weapon]);
}