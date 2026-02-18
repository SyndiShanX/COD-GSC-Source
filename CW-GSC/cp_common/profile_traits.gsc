/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\profile_traits.gsc
***********************************************/

#using script_25c09ccacf057919;
#using scripts\abilities\ability_util;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\perks;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\util;
#namespace profile_traits;

function private autoexec __init__system__() {
  system::register(#"profile_traits", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  function_bba23c40("<dev string:x38>", 0.75);
  function_bba23c40("<dev string:x53>", 0.75);

  level.var_e85d5a3f = spawnStruct();
  var_1f7a9822 = getscriptbundle(#"profile_traits");
  level.var_e85d5a3f.var_e4f193a3 = [];

  for(i = 0; i < var_1f7a9822.traits.size; i++) {
    if(!is_true(var_1f7a9822.traits[i].disabled)) {
      var_1f7a9822.traits[i].bitflag = 1 << i;
      level.var_e85d5a3f.var_e4f193a3[level.var_e85d5a3f.var_e4f193a3.size] = var_1f7a9822.traits[i];
      continue;
    }

    if(var_1f7a9822.traits[i].ref_name == "classified") {
      level.var_e85d5a3f.var_8651d525 = var_1f7a9822.traits[i];
    }
  }

  function_5ac4dc99("<dev string:x70>", 0);
  function_5ac4dc99("<dev string:x88>", -1);
  function_5ac4dc99("<dev string:x9e>", -1);
  function_5ac4dc99("<dev string:xb7>", 0);
  function_cd140ee9("<dev string:x70>", &function_df62d47f);
  function_cd140ee9("<dev string:x88>", &function_df62d47f);
  function_cd140ee9("<dev string:x9e>", &function_df62d47f);
  function_cd140ee9("<dev string:xb7>", &function_df62d47f);

  for(i = 0; i < level.var_e85d5a3f.var_e4f193a3.size; i++) {
    var_fb7d23d9 = level.var_e85d5a3f.var_e4f193a3[i];
    adddebugcommand("<dev string:xd4>" + var_fb7d23d9.var_7c0b3589 + "<dev string:x100>" + i + "<dev string:x105>" + i + "<dev string:x123>");
    adddebugcommand("<dev string:x129>" + var_fb7d23d9.var_7c0b3589 + "<dev string:x100>" + i + "<dev string:x158>" + i + "<dev string:x123>");
  }

  adddebugcommand("<dev string:x179>");
  adddebugcommand("<dev string:x1cc>");
}

function function_df62d47f(params) {
  level thread function_b8f86396(params);
}

function private function_b8f86396(params) {
  level endon(#"game_ended");
  waitframe(1);
  player = getplayers()[0];

  if(params.name == "<dev string:x88>") {
    var_e3ffeeb4 = params.value;

    if(var_e3ffeeb4 > -1) {
      assert(var_e3ffeeb4 < level.var_e85d5a3f.var_e4f193a3.size);
      var_fb7d23d9 = level.var_e85d5a3f.var_e4f193a3[var_e3ffeeb4];
      player function_18198dfb(var_fb7d23d9.bitflag);
      setDvar(#"hash_1d3ff4dcafbd084e", -1);
    }

    return;
  }

  if(params.name == "<dev string:x9e>") {
    var_eccea24e = params.value;

    if(var_eccea24e > -1) {
      assert(var_eccea24e < level.var_e85d5a3f.var_e4f193a3.size);
      var_fb7d23d9 = level.var_e85d5a3f.var_e4f193a3[var_eccea24e];
      player function_1c1fa213(var_fb7d23d9.bitflag);
      setDvar(#"hash_35ef1fad3aba3507", -1);
    }

    return;
  }

  if(params.name == "<dev string:x70>") {
    var_6eee7673 = params.value;

    if(var_6eee7673) {
      player function_56266435();
      setDvar(#"hash_28a6f53c5000afe4", 0);
    }

    return;
  }

  if(params.name == "<dev string:xb7>") {
    if(params.value) {
      player thread function_30a971a4();
      return;
    }

    player notify(#"hash_639ee73311ef0e56");
  }
}

function private function_30a971a4() {
  player = self;
  player endoncallback(&function_6f60cb1e, #"hash_639ee73311ef0e56");
  player.var_adeb44c2 = [];

  for(i = 0; i < level.var_e85d5a3f.var_e4f193a3.size; i++) {
    trait = level.var_e85d5a3f.var_e4f193a3[i];
    hudelem = newdebughudelem(player);
    hudelem.alignx = "<dev string:x22f>";
    hudelem.aligny = "<dev string:x237>";
    hudelem.x = 400;
    hudelem.y = 220 + i * 14;
    hudelem.foreground = 1;
    hudelem.fontscale = 1;
    hudelem settext(trait.ref_name + "<dev string:x23e>");
    hudelem.var_16021753 = 0;
    hudelem.perkactive = 0;
    hudelem.color = (0.75, 0.75, 0.75);
    player.var_adeb44c2[i] = hudelem;
  }

  while(true) {
    wait 0.5;

    for(i = 0; i < level.var_e85d5a3f.var_e4f193a3.size; i++) {
      trait = level.var_e85d5a3f.var_e4f193a3[i];
      var_16021753 = function_a996bd5e(trait.bitflag);
      perkactive = -1;

      if(is_true(trait.use_perk)) {
        if(player hasperk(trait.perk_name)) {
          perkactive = 1;
        } else {
          perkactive = 0;
        }
      }

      hudelem = player.var_adeb44c2[i];

      if(var_16021753 != hudelem.var_16021753 || perkactive != hudelem.perkactive) {
        hudelem.var_16021753 = var_16021753;
        hudelem.perkactive = perkactive;
        var_63d9d5cb = trait.ref_name + "<dev string:x259>";

        if(var_16021753) {
          var_63d9d5cb += "<dev string:x25f>";
          hudelem.color = (0, 1, 0);
        } else {
          var_63d9d5cb += "<dev string:x271>";
          hudelem.color = (0.75, 0.75, 0.75);
        }

        if(perkactive == -1) {
          var_63d9d5cb += "<dev string:x280>";
        } else if(perkactive) {
          var_63d9d5cb += "<dev string:x294>";

          if(!var_16021753) {
            hudelem.color = (1, 0, 0);
          }
        } else {
          var_63d9d5cb += "<dev string:x2a5>";

          if(var_16021753) {
            hudelem.color = (1, 0, 0);
          }
        }

        hudelem settext(var_63d9d5cb);
      }
    }
  }
}

function private function_6f60cb1e() {
  player = self;

  if(isDefined(player.var_adeb44c2)) {
    foreach(elem in player.var_adeb44c2) {
      elem destroy();
    }

    player.var_adeb44c2 = undefined;
  }
}

function function_979631fd() {
  return level.var_e85d5a3f.var_e4f193a3;
}

function function_3937b542() {
  return level.var_e85d5a3f.var_8651d525;
}

function function_d9b59414(var_f2c93983) {
  if(var_f2c93983 == "classified") {
    return 0;
  }

  foreach(trait in level.var_e85d5a3f.var_e4f193a3) {
    if(trait.ref_name == var_f2c93983) {
      return trait.bitflag;
    }
  }

  assertmsg("<dev string:x2b3>" + var_f2c93983 + "<dev string:x2fc>");
}

function function_56266435() {
  player = self;
  player function_1c1fa213(~0);
}

function function_a996bd5e(var_f03e5d1b) {
  assert(isPlayer(self));
  player = self;
  var_b3903404 = player savegame::function_2ee66e93("savegame_personal_trait_flags", undefined);

  if(!isDefined(var_b3903404)) {
    var_b3903404 = 0;
    player savegame::set_player_data("savegame_personal_trait_flags", var_b3903404);
  }

  return var_b3903404 &var_f03e5d1b;
}

function function_18198dfb(var_f03e5d1b) {
  assert(isPlayer(self));
  player = self;
  var_b3903404 = player savegame::function_2ee66e93("savegame_personal_trait_flags", undefined);

  if(!isDefined(var_b3903404)) {
    var_b3903404 = 0;
  }

  var_b3903404 |= var_f03e5d1b;
  player savegame::set_player_data("savegame_personal_trait_flags", var_b3903404);
  player function_d53bb873();
}

function function_1c1fa213(var_f03e5d1b) {
  assert(isPlayer(self));
  player = self;
  var_b3903404 = player savegame::function_2ee66e93("savegame_personal_trait_flags", undefined);

  if(!isDefined(var_b3903404)) {
    var_b3903404 = 0;
  }

  foreach(trait in level.var_e85d5a3f.var_e4f193a3) {
    if(var_f03e5d1b &var_b3903404 &trait.bitflag) {
      if(is_true(trait.use_perk) && player hasperk(trait.perk_name)) {
        player perks::perk_unsetperk(trait.perk_name);
      } else if(trait.ref_name == "jugernog") {
        player player::function_b933de24("jugernog", 0);
      }

      println("<dev string:x301>" + trait.ref_name + "<dev string:x2fc>");
    }
  }

  if(var_b3903404 &var_f03e5d1b) {
    var_b3903404 &= ~var_f03e5d1b;
  }

  player savegame::set_player_data("savegame_personal_trait_flags", var_b3903404);
  player function_d53bb873();
}

function function_d53bb873() {
  assert(isPlayer(self));
  player = self;
  var_b3903404 = player savegame::function_2ee66e93("savegame_personal_trait_flags", undefined);

  if(!isDefined(var_b3903404)) {
    return 0;
  }

  foreach(trait in level.var_e85d5a3f.var_e4f193a3) {
    if(var_b3903404 &trait.bitflag) {
      if(is_true(trait.use_perk) && !player hasperk(trait.perk_name)) {
        player perks::perk_setperk(trait.perk_name);
      } else if(trait.ref_name == "jugernog") {
        player player::function_2a67df65("jugernog", 25, undefined, 1);
        player.health = 125;
        player.maxhealth = 125;
      }

      println("<dev string:x325>" + trait.ref_name + "<dev string:x2fc>");
    }
  }
}