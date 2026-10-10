/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_57d78f3552757ec4.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_345253ecdfc854;
#using script_3d3d1ef33cecfb62;
#using script_482376d10f69832c;
#using script_4e6e58ab5d96c2b0;
#using script_57bdd8aff28a4717;
#using script_638d701d263ee1ed;
#using script_7153ce70c6d8ab9b;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\cp_mp\interaction;
#using scripts\cp_mp\loot\common_cache;
#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\cp_mp\utility\vision_utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\mp_agent;
#using scripts\ob\points;
#namespace namespace_dc0140c0d20a7e8f;

function private autoexec __init__system__() {
  system::register(#"hash_4d85fa813d39fbeb", undefined, undefined, &init);
}

function function_d99864f8b4032562(element, base_struct, var_5f8bb464b19d1f53, orb_struct, var_fc394e11bae17823, var_f5acf56d7a0a1404, var_7eb73407060d7cb6, var_42679ba6cdba9ee1, alignment) {
  obelisk_struct = base_struct;
  obelisk = spawnscriptable("jup_zm_activity_spatial_pedestal_top_scriptable", obelisk_struct.origin + (0, 0, 40), obelisk_struct.angles);
  obelisk setscriptablepartstate("fx", "off");
  obelisk setscriptablepartstate("body", "end");
  obelisk setscriptablepartstate("sfx", "off");
  obelisk.state = 0;
  obelisk.killcount = 0;
  obelisk.playerdeaths = 0;
  obelisk.element = element;
  obelisk.completed = 0;
  obelisk.unique_name = obelisk_struct.targetname;
  obelisk.players = undefined;
  obelisk.var_e00ac5b70d752deb = undefined;
  obelisk.var_fa9e06a77032916e = 0;
  obelisk.puzzle_state = 0;
  obelisk.var_fc394e11bae17823 = var_fc394e11bae17823;
  obelisk.var_f5acf56d7a0a1404 = var_f5acf56d7a0a1404;
  obelisk.season = 3;

  if(isDefined(var_7eb73407060d7cb6)) {
    assert(isfunction(var_7eb73407060d7cb6));
    obelisk.var_7eb73407060d7cb6 = var_7eb73407060d7cb6;
  }

  obelisk_base = spawnscriptable("jup_zm_activity_spatial_pedestal_base_scriptable", obelisk_struct.origin, obelisk_struct.angles);
  obelisk_base setscriptablepartstate("body", "end");
  obelisk_base setscriptablepartstate("interact", "off");
  var_5f8bb464b19d1f53 = array_randomize(var_5f8bb464b19d1f53);
  obelisk.rune_manager = namespace_26050772d3578b37::function_b7c2ddf5f84c1f61(array_slice(var_5f8bb464b19d1f53, 0, 3), obelisk.unique_name);
  obelisk.base = obelisk_base;
  obelisk_base.obelisk = obelisk;

  if(!isDefined(orb_struct)) {
    obelisk.orb_struct = spawnStruct();
    obelisk.orb_struct.origin = obelisk_base.origin + (0, 0, 40);
    obelisk.orb_struct.angles = obelisk_base.angles;
  } else {
    obelisk.orb_struct = orb_struct;
  }

  if(isDefined(var_42679ba6cdba9ee1)) {
    obelisk.var_42679ba6cdba9ee1 = var_42679ba6cdba9ee1;
  }

  if(isDefined(alignment)) {
    obelisk.alignment = alignment.origin;
    obelisk.var_7ff65a976101ff55 = alignment.angles;
    obelisk.var_713f07f1f3d7b5f7 = 1;

    if(obelisk.element == "air") {
      obelisk.var_67a552129d9ade80 = 1;
    }

    obelisk.season = 5;
  }

  obelisk.var_d6f622d1668f0b04 = getdvarfloat(@ "hash_7f90626745758176", 1500);
  obelisk.var_db65e387ed5c1ef5 = getdvarfloat(@ "hash_2676fd5c44bd192b", 1500);

  if(obelisk.element == "land") {
    obelisk.var_d6f622d1668f0b04 = 880;
    obelisk.var_db65e387ed5c1ef5 = 880;
  }

  s3_name = namespace_9866a3bced571d62::function_54b2c5a00ed87d60(obelisk.element);
  itembundle = getscriptbundle("itemspawnentry:" + "ob_jup_item_key_rift_gate_season3_" + s3_name);
  lootid = scripts\cp_mp\loot\common_item::function_6d15e119c2779a93(itembundle);
  obelisk.relic_lootid = lootid;
  level thread function_6abd388d691cb822(obelisk);
  return obelisk;
}

function init() {
  load_vfx();
  setdvarifuninitialized(@ "hash_5a8ca99f137d0a44", 0);
  level flag_wait("ob_infil_completed");
  level.var_f607826b73b56d1c = [5, 3.75, 2.5];
  level.var_50f9183dc541bd7d["ice"] = "jup_spawner_zombie_mimic_hvt_spatial";
  level.var_50f9183dc541bd7d["toxic"] = "jup_spawner_zombie_mangler_hvt_spatial";

  if(istrue(level.var_90744c9d7cb71043)) {
    assertmsg("<dev string:x1c>");
  } else {
    level callback::add("on_zombie_ai_killed", &function_6e42339d9503b6b7);
    level.var_90744c9d7cb71043 = 1;
  }

  if(istrue(level.var_4bf569cf41d32514)) {
    assertmsg("<dev string:x5f>");
  } else {
    level callback::add("player_laststand", &function_35682bc06e3a7d3a);
    level.var_4bf569cf41d32514 = 1;
  }

  level.var_4ff113324b51bedd = [];
  namespace_26050772d3578b37::function_a110e6203cd98cc9();
  namespace_26050772d3578b37::function_98264e8b6400bc85("complete", &function_4f321c7904a7562b);
  namespace_26050772d3578b37::function_f35c102a1c5f2a6d(&function_9b4b90d44dc1c350);
}

function load_vfx() {
  level._effect["zombie_death"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_obelisk_soul_spawn.vfx");
  level._effect["zombie_soul"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_obelisk_soul_trail.vfx");
  level._effect["zombie_soul_impact"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_obelisk_soul_impact.vfx");
}

function function_5a3e2f3da27cb304() {
  obelisk = self;
  obelisk endon("spatial_puzzle_completed");
  obelisk endon("spatial_puzzle_reset");
  level endon("game_ended");
  alignment_point = obelisk.base.origin;

  if(isDefined(obelisk.alignment)) {
    alignment_point = obelisk.alignment;
  }

  if(obelisk.element == "air") {
    obelisk.activation_trigger = spawn("noent_volume_trigger_radius", alignment_point, 0, 400, 400);
  } else if(obelisk.element == "land") {
    obelisk.activation_trigger = spawn("noent_volume_trigger_radius", alignment_point, 0, 15, 100);
  } else {
    obelisk.activation_trigger = spawn("noent_volume_trigger_radius", alignment_point, 0, 60, 100);
  }

  while(true) {
    if(istrue(obelisk.var_e00ac5b70d752deb)) {
      assert(isDefined(obelisk.players));
      function_1831b668cb43b6c9(obelisk, 1);
    } else if(!istrue(obelisk.var_713f07f1f3d7b5f7)) {
      obelisk.potential_players = [];
      players_in_range = getplayersinradius(obelisk.activation_trigger.origin, 60);

      foreach(player in players_in_range) {
        if(!isDefined(player)) {
          continue;
        }

        obelisk.potential_players = function_fdc9d5557c53078e(obelisk.potential_players);

        if(obelisk.potential_players.size != 0 && array_contains_key(obelisk.potential_players, player)) {
          continue;
        }

        squad_array = player scripts\cp_mp\utility\squad_utility::getsquadmembers();

        foreach(player_member in squad_array) {
          backpackindex = player_member scripts\cp_mp\loot\common_inventory::function_4776284a348ebb6a(obelisk.relic_lootid);

          if(backpackindex > -1 || getdvarint(@ "hash_90ad914fd463e008", 0)) {
            if(!istrue(obelisk.var_ff9089bede742254)) {
              obelisk.base setscriptablepartstate("interact", "on");
              obelisk.var_ff9089bede742254 = 1;
            }

            if(!istrue(obelisk.var_e1d182b0ee52d43e)) {
              scripts\cp_mp\interaction::function_32645103f7520635(obelisk.base, &activate_obelisk, undefined, undefined);
              obelisk.var_e1d182b0ee52d43e = 1;
              obelisk.base scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_a8e7372d3c4366e);
            }

            obelisk.potential_players = array_combine(obelisk.potential_players, squad_array);
            break;
          }
        }
      }

      if(isDefined(obelisk.players)) {
        function_1831b668cb43b6c9(obelisk, 0);
      }
    }

    waitframe();
  }
}

function function_1831b668cb43b6c9(obelisk, should_notify) {
  obelisk.players = function_fdc9d5557c53078e(obelisk.players);

  foreach(player in obelisk.players) {
    if(player istouching(obelisk.activation_trigger)) {
      if(!istrue(player.var_338560ff664aecb3)) {
        if(!istrue(obelisk.var_67a552129d9ade80)) {
          var_b77ce47890ca655f = undefined;

          if(isDefined(obelisk.var_42679ba6cdba9ee1)) {
            var_b77ce47890ca655f = obelisk.var_42679ba6cdba9ee1.origin;
          }

          if(isDefined(obelisk.var_7ff65a976101ff55)) {
            var_b77ce47890ca655f = obelisk.alignment + 200 * anglesToForward(obelisk.var_7ff65a976101ff55);
          }

          if(!within_fov(player.origin, player.angles, var_b77ce47890ca655f, 0.766)) {
            continue;
          }
        }

        if(obelisk.element == "land" && player getstance() != "prone") {
          continue;
        }

        player playRumbleOnEntity("heavy_3s");
        player earthquakeforplayer(0.5, 3, player.origin, 500);
        player.var_338560ff664aecb3 = 1;

        if(should_notify) {
          obelisk notify("player_at_spatial_activation");
        }
      }

      if(!player function_8e888e08a6ab22d3("jup_ob_spatial_puzzle")) {
        player vision_utility::function_27a921508cb04613("jup_ob_spatial_puzzle");
      }

      continue;
    }

    if(player function_8e888e08a6ab22d3("jup_ob_spatial_puzzle")) {
      player vision_utility::function_9a92ae402e209ecc("jup_ob_spatial_puzzle");
    }
  }
}

function function_4f321c7904a7562b(var_96ae350eff4a278d, eattacker) {
  level notify(var_96ae350eff4a278d + "_initialized", "ee", eattacker);
}

function function_9b4b90d44dc1c350(eattacker) {
  return !istrue(eattacker.var_fdbbf03042084910);
}

function function_6abd388d691cb822(obelisk) {
  level endon("game_ended");
  obelisk endon("spatial_puzzle_reset");
  obelisk thread function_5a3e2f3da27cb304();
  level waittill(obelisk.unique_name + "_initialized", msg, eattacker);

  if(msg == "ee") {
    iprintlnbold("<dev string:xa2>");

    obelisk.puzzle_state = 1;

    if(isDefined(obelisk.var_7eb73407060d7cb6)) {
      obelisk thread[[obelisk.var_7eb73407060d7cb6]](obelisk.puzzle_state);
    }

    obelisk.var_e00ac5b70d752deb = 1;
    obelisk.players = eattacker scripts\cp_mp\utility\squad_utility::getsquadmembers();
    obelisk.players = function_fdc9d5557c53078e(obelisk.players);

    foreach(player in obelisk.players) {
      player.var_fdbbf03042084910 = 1;
    }

    thread timeout_watcher(obelisk, 300, 1);

    if(obelisk.season == 5) {
      thread scripts\cp_mp\overlord::playevent("STY_S5_5_SPEEQ_Activate", obelisk.players);
    } else {
      thread scripts\cp_mp\overlord::playevent("STY_S3_5_SPEEQ_Activate", obelisk.players);
    }

    obelisk waittill("player_at_spatial_activation");
    obelisk.base activate_obelisk();
  }
}

function function_a8e7372d3c4366e(obelisk_base, player) {
  if(isDefined(obelisk_base.obelisk.players)) {
    if(!array_contains(obelisk_base.obelisk.players, player)) {
      return {
        #string: &"JUP_OB_S1/SEAL_ALREADY_ACTIVE", #type: "HINT_NOBUTTON"};
    } else {
      return {
        #string: &"JUP_OB_S3/CALL_THE_NEGOTIATOR", #type: "HINT_BUTTON"};
    }

    return;
  }

  if(!isDefined(obelisk_base.obelisk.potential_players) || !array_contains(obelisk_base.obelisk.potential_players, player)) {
    return {
      #string: &"", #type: "HINT_NOBUTTON"};
  }

  if(isDefined(obelisk_base.obelisk.var_42679ba6cdba9ee1) && !within_fov(player.origin, player.angles, obelisk_base.obelisk.var_42679ba6cdba9ee1.origin, 0.766)) {
    return {
      #string: &"", #type: "HINT_NOBUTTON"};
  }

  return {
    #string: &"JUP_OB_S3/CALL_THE_NEGOTIATOR", #type: "HINT_BUTTON"};
}

function activate_obelisk(player) {
  obelisk = self.obelisk;

  if(!istrue(obelisk.var_713f07f1f3d7b5f7)) {
    if(isDefined(obelisk.players)) {
      foreach(player_iteration in obelisk.players) {
        backpackindex = player_iteration scripts\cp_mp\loot\common_inventory::function_4776284a348ebb6a(obelisk.relic_lootid);

        if(backpackindex > -1 || getdvarint(@ "hash_90ad914fd463e008", 0)) {
          squad_array = player_iteration scripts\cp_mp\utility\squad_utility::getsquadmembers();
          obelisk.potential_players = squad_array;

          if(!istrue(obelisk.var_ff9089bede742254)) {
            obelisk.base setscriptablepartstate("interact", "on");
            obelisk.var_ff9089bede742254 = 1;
          }

          if(!istrue(obelisk.var_e1d182b0ee52d43e)) {
            scripts\cp_mp\interaction::function_32645103f7520635(obelisk.base, &activate_obelisk, undefined, undefined);
            obelisk.var_e1d182b0ee52d43e = 1;
            obelisk.base scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_a8e7372d3c4366e);
          }

          break;
        }
      }
    }

    if(!istrue(obelisk.var_e00ac5b70d752deb) || obelisk.puzzle_state == 2 || obelisk.puzzle_state == 3) {
      obelisk.var_e00ac5b70d752deb = 0;
      obelisk.rune_manager function_a63a2112c7b585e5();
      obelisk.players = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
      obelisk.players = function_fdc9d5557c53078e(obelisk.players);

      foreach(player in obelisk.players) {
        player.var_fdbbf03042084910 = 1;
      }

      obelisk.var_152662fdff5f3b47 = [];

      foreach(player_iteration in obelisk.players) {
        if(player_iteration scripts\cp_mp\loot\common_inventory::function_181a584e4a68d5d6(obelisk.relic_lootid)) {
          obelisk.var_152662fdff5f3b47 = array_add(obelisk.var_152662fdff5f3b47, player_iteration);
        }
      }

      obelisk.base setscriptablepartstate("interact", "off");

      if(obelisk.puzzle_state == 2) {
        return;
      }
    }
  }

  obelisk notify("spatial_obelisk_started");
  level thread namespace_b3f32c8cb80b8124::function_115bd456be8e071d(obelisk.players, "ob_contract_action_loop");

  if(!istrue(obelisk.var_713f07f1f3d7b5f7)) {
    if(obelisk.potential_players.size == 0) {
      obelisk.base setscriptablepartstate("interact", "off");
    }
  }

  obelisk.base setscriptablepartstate("body", "active_" + "electric");
  obelisk setscriptablepartstate("sfx", "activated");
  obelisk.var_68d7534b8c965ed9 = spawnscriptable("jup_zm_rift_pedestal_orb_scriptable", obelisk.orb_struct.origin, obelisk.orb_struct.angles);
  obelisk.puzzle_state = 2;

  if(isDefined(obelisk.var_7eb73407060d7cb6)) {
    obelisk thread[[obelisk.var_7eb73407060d7cb6]](obelisk.puzzle_state);
  }

  iprintlnbold("<dev string:xe8>");

  if(istrue(obelisk.var_e00ac5b70d752deb)) {
    if(obelisk.season == 5) {
      thread scripts\cp_mp\overlord::playevent("STY_S5_5_SPEEQ_Visualized", obelisk.players, 3);
    } else {
      thread scripts\cp_mp\overlord::playevent("STY_S3_5_SPEEQ_Visualized", obelisk.players, 3);
    }
  } else if(!istrue(obelisk.var_e00ac5b70d752deb)) {
    thread scripts\cp_mp\overlord::playevent("RFT_S3_5_RGUQ_Accept_Unattuned", obelisk.players, 3);
  }

  thread timeout_watcher(obelisk, 300, 2);
  var_587ea45bcb61087f = getdvarint(@ "hash_86a96d7e221cbf1e", 30);
  var_8aebfae0dba02157 = getdvarfloat(@ "hash_78d6cb32428c66fc", 0.3);
  var_8aebfae0dba02157 = isDefined(obelisk) && isDefined(obelisk.season) && obelisk.season == 5 ? 0.6 : var_8aebfae0dba02157;
  obelisk.var_3144cc2ba8121676 = var_587ea45bcb61087f * (1 + var_8aebfae0dba02157 * (min(obelisk.players.size, 3) - 1));
  obelisk.var_6d298bb3b2c8bf0 = 0;
  level.var_4ff113324b51bedd = array_add(level.var_4ff113324b51bedd, obelisk);
  var_f911aed45eb961a3 = getaiarrayinradius(self.origin, obelisk.var_d6f622d1668f0b04);

  foreach(zombie in var_f911aed45eb961a3) {
    if(isDefined(zombie.var_66c1831357048c02)) {
      continue;
    }

    if(isDefined(zombie) && isalive(zombie) && zombie.type == "zombie") {
      zombie.marked_for_death = 1;
      zombie.nuked = 1;
      zombie.full_gib = 1;
      zombie.var_745cd904c1ec804c = 1;
      zombie kill();
    }
  }

  function_606642b946a01237(obelisk.unique_name, self.origin, obelisk.var_d6f622d1668f0b04, 1);
  obelisk function_6094ec6f1a58a381(obelisk);
  obelisk thread function_658b421b37fd7662();
  wait 5;
  obelisk.var_21dcf44eef6e9fa2 = 1;
}

function function_da098c7b6ef1993e(var_2eb33feb1aba5335) {
  var_44b27a8e32ebe296 = spawn_request(var_2eb33feb1aba5335, self.origin, self.var_d6f622d1668f0b04, 1, 1, 0);
  function_bc5315dc37ae4cf(var_44b27a8e32ebe296, &function_b07493f60764eed4, self);
  function_73147cdf5c28d10c(var_44b27a8e32ebe296, &function_64f4df7704af6dc2, self);
  function_e4a67fe4ddca7ed5(var_44b27a8e32ebe296, &function_5d1738a71dc36fa0, self);
}

function function_6094ec6f1a58a381(obelisk) {
  if(isDefined(obelisk.element)) {
    switch (obelisk.element) {
      case #"hash_ceb098150f024a39":
        function_da098c7b6ef1993e("ai_flood_fill_encounter:ob_activity_spatial_obelisk_encounter_fire");
        break;
      case #"hash_6fe0d38b135245cc":
        function_da098c7b6ef1993e("ai_flood_fill_encounter:ob_activity_spatial_obelisk_encounter");
        break;
      case #"hash_47276d6c2f4cfd60":
        function_da098c7b6ef1993e("ai_flood_fill_encounter:ob_activity_spatial_obelisk_encounter");
        break;
      case #"hash_7651db02434beff0":
        function_da098c7b6ef1993e("ai_flood_fill_encounter:ob_s5_activity_spatial_obelisk_encounter_water");
        break;
      case #"hash_c574c6c109cbbf7":
        function_da098c7b6ef1993e("ai_flood_fill_encounter:ob_s5_activity_spatial_obelisk_encounter_air");
        break;
      case #"hash_aaf97f3a074169fc":
        function_da098c7b6ef1993e("ai_flood_fill_encounter:ob_s5_activity_spatial_obelisk_encounter_land");
        break;
      default:
        break;
    }
  }
}

function function_658b421b37fd7662() {
  level endon("game_ended");
  self endon("spatial_puzzle_reset");
  var_43049aa480097901 = ter_op(self.element == "air", 4000, 2500);

  while(self.puzzle_state == 2) {
    var_f911aed45eb961a3 = getaiarrayinradius(self.origin, var_43049aa480097901);

    foreach(zombie in var_f911aed45eb961a3) {
      if(isDefined(zombie.var_66c1831357048c02)) {
        continue;
      }

      if(!isDefined(zombie.var_f89106513931332c)) {
        zombie.var_f89106513931332c = 0;
      }

      var_52d83275cdaec498 = distance2dsquared(zombie.origin, self.origin) < self.var_db65e387ed5c1ef5 * self.var_db65e387ed5c1ef5;

      if(var_52d83275cdaec498 == 1 && zombie.var_f89106513931332c == 0 && isalive(zombie)) {
        zombie function_3ab9164ef76940fd("obelisk_vfx", "electric");
        zombie.var_f89106513931332c = 1;
        continue;
      }

      if(var_52d83275cdaec498 == 0 && zombie.var_f89106513931332c == 1) {
        zombie function_3ab9164ef76940fd("obelisk_vfx", "off");
        zombie.var_f89106513931332c = 0;
      }
    }

    cylinder(self.origin, self.origin + (0, 0, 100), self.var_db65e387ed5c1ef5, (0, 0, 1), 0, 4);

    wait 0.2;
  }
}

function function_35682bc06e3a7d3a(params) {
  foreach(obelisk in level.var_4ff113324b51bedd) {
    if(obelisk.puzzle_state == 2 && obelisk.var_6d298bb3b2c8bf0 == 0) {
      if(distance2dsquared(self.origin, obelisk.origin) < obelisk.var_d6f622d1668f0b04 * obelisk.var_d6f622d1668f0b04) {
        if(obelisk.playerdeaths < level.var_f607826b73b56d1c.size) {
          obelisk.var_6d298bb3b2c8bf0 = level.var_f607826b73b56d1c[obelisk.playerdeaths];
          obelisk.playerdeaths++;
          wait obelisk.var_6d298bb3b2c8bf0;
          obelisk.var_7e133de1e5867d3c = 0;
        }
      }
    }
  }
}

function function_b07493f60764eed4(requestid, obelisk) {
  if(obelisk.puzzle_state != 2) {
    return 0;
  }

  squadsize = obelisk.players.size;
  var_b4a0bb985e832edf = obelisk.killcount / obelisk.var_3144cc2ba8121676;
  var_b15b75e63e5adfff = 1 / pow(squadsize, 1.5);
  waveinterval = var_b15b75e63e5adfff * (1 + 0.5 * (1 - var_b4a0bb985e832edf));

  iprintln("<dev string:x104>" + waveinterval + obelisk.var_6d298bb3b2c8bf0);

  iprintln("<dev string:x117>" + var_b4a0bb985e832edf + "<dev string:x129>" + obelisk.killcount + "<dev string:x130>" + obelisk.var_3144cc2ba8121676);

  wait waveinterval + obelisk.var_6d298bb3b2c8bf0;

  if(obelisk.puzzle_state == 2) {
    return 1;
  }

  return 0;
}

function function_64f4df7704af6dc2(requestid, obelisk) {
  if(obelisk.puzzle_state == 2) {
    return 0;
  }

  return 1;
}

function function_5d1738a71dc36fa0(requestid, obelisk, zombie, ai_data) {
  zombie function_65cdab0fc78aba8f(obelisk.origin, obelisk.var_db65e387ed5c1ef5 * 1.5);
}

function function_6e42339d9503b6b7(params) {
  self function_9322f3cb1cd4111a();
  function_3ab9164ef76940fd("obelisk_vfx", "off");

  foreach(obelisk in level.var_4ff113324b51bedd) {
    var_3e5bef4b6dd3e32a = obelisk.origin;

    if(distance2dsquared(self.origin, var_3e5bef4b6dd3e32a) < obelisk.var_db65e387ed5c1ef5 * obelisk.var_db65e387ed5c1ef5) {
      playFX(getfx("zombie_death"), self.origin);

      if(obelisk.killcount < obelisk.var_3144cc2ba8121676 && istrue(obelisk.var_21dcf44eef6e9fa2)) {
        obelisk.killcount++;
        function_2b6783f1c69393ff(self.origin + (0, 0, 40), obelisk.orb_struct.origin, 0.25, obelisk);

        if(obelisk.killcount == obelisk.var_3144cc2ba8121676 / 2) {
          if(istrue(obelisk.var_e00ac5b70d752deb)) {
            if(obelisk.season == 5) {
              thread scripts\cp_mp\overlord::playevent("STY_S5_5_SPEEQ_50_Charged", obelisk.players, 1);
            } else {
              thread scripts\cp_mp\overlord::playevent("STY_S3_5_SPEEQ_50_Charged", obelisk.players, 1);
            }

            continue;
          }

          if(!istrue(obelisk.var_e00ac5b70d752deb)) {
            thread scripts\cp_mp\overlord::playevent("RFT_S3_5_RGUQ_50_Charged", obelisk.players);
          }
        }
      }
    }
  }
}

function function_2b6783f1c69393ff(spawn_origin, goal_position, move_delay, obelisk) {
  move_delay = utility::default_to(move_delay, 0);
  trail = utility::spawn_model("tag_origin", spawn_origin);
  trail.goal_position = goal_position + (0, 0, 170);
  playFXOnTag(getfx("zombie_soul"), trail, "tag_origin");
  trail thread function_57961c5b765c270(move_delay, obelisk);
}

function function_57961c5b765c270(move_delay, obelisk) {
  level endon("game_ended");
  obelisk endon("spatial_puzzle_reset");
  self endon("death");
  self playSound("evt_ob_rr_obelisk_soul_spawn");
  self playLoopSound("evt_ob_rr_obelisk_soul_lp");

  if(move_delay > 0) {
    wait move_delay;
  }

  self moveTo(self.goal_position, 0.8, 0.2);
  self waittill("movedone");
  playFX(getfx("zombie_soul_impact"), self.goal_position);
  killfxontag(getfx("zombie_soul"), self, "tag_origin");
  playsoundatpos(self.origin, "evt_ob_rr_obelisk_soul_impact");
  function_4234407e34a559f9(obelisk);
  self delete();
}

function function_4234407e34a559f9(obelisk) {
  var_2da558e8c88e09c = min(obelisk.killcount / obelisk.var_3144cc2ba8121676, 1);

  if(var_2da558e8c88e09c >= 1) {
    obelisk_completed(obelisk);
    return;
  }

  if(var_2da558e8c88e09c * 4 >= obelisk.state + 1) {
    obelisk.state++;
  }
}

function shutdown_obelisk(obelisk) {
  if(!istrue(obelisk.var_713f07f1f3d7b5f7)) {
    obelisk setscriptablepartstate("fx", obelisk.element + "_done");
  }

  obelisk.var_68d7534b8c965ed9 setscriptablepartstate("body", "done");
  obelisk.state = 0;
  obelisk.playerdeaths = 0;
  obelisk.killcount = 0;
  level.var_4ff113324b51bedd = array_remove(level.var_4ff113324b51bedd, obelisk);
  obelisk.base setscriptablepartstate("body", "end");
  obelisk setscriptablepartstate("sfx", "activated");
  function_c7311cb3f768f21e(obelisk.unique_name, 10);
  explosionzombies = getaiarrayinradius(obelisk.origin, obelisk.var_db65e387ed5c1ef5, "team_two_hundred");

  foreach(zombie in explosionzombies) {
    if(isalive(zombie)) {
      zombie function_3ab9164ef76940fd("obelisk_vfx", "off");
      zombie kill();
      corpse = zombie getcorpseentity();

      if(isDefined(corpse)) {
        var_a33d2a2c3ffecb81 = corpse.origin - obelisk.origin + (0, 0, 60);
        var_83fd98f3ac829176 = max(500 - distance2d(corpse.origin, obelisk.origin), 0) / 4;
        corpse startragdollfromimpact("torso_upper", var_a33d2a2c3ffecb81 * var_83fd98f3ac829176);
      }
    }
  }
}

function obelisk_completed(obelisk) {
  obelisk.puzzle_state = 3;

  if(isDefined(obelisk.var_7eb73407060d7cb6)) {
    obelisk thread[[obelisk.var_7eb73407060d7cb6]](obelisk.puzzle_state);
  }

  thread timeout_watcher(obelisk, 300, 3);
  shutdown_obelisk(obelisk);
  level thread namespace_b3f32c8cb80b8124::function_115bd456be8e071d(obelisk.players, "ob_contract_win");
  obelisk.players = function_fdc9d5557c53078e(obelisk.players);

  foreach(player in obelisk.players) {
    player scripts\ob\points::function_b5b4f530f1c579aa(2000);
  }

  waitframe();

  if(!obelisk.var_e00ac5b70d752deb) {
    function_de57fa38335a4b65(obelisk);
    return;
  }

  obelisk.var_fa9e06a77032916e = 1;
  spawn_reward(obelisk);
}

function range_watcher() {
  obelisk = self;

  while(true) {
    var_f27c366795e1174c = 0;
    obelisk.players = function_fdc9d5557c53078e(obelisk.players);

    foreach(player in obelisk.players) {
      max_range = 2500;

      if(obelisk.element == "air") {
        max_range = 4000;
      }

      if(distance2dsquared(player.origin, obelisk.origin) < max_range * max_range) {
        var_f27c366795e1174c = 1;
        break;
      }
    }

    if(!var_f27c366795e1174c) {
      obelisk notify("players_out_of_range");
    }

    waitframe();
  }
}

function timeout_watcher(obelisk, time, starting_state) {
  level endon("game_ended");
  obelisk notify("timeout_watcher");
  obelisk endon("timeout_watcher");
  obelisk endon("spatial_puzzle_reset");

  if(obelisk.puzzle_state > 1) {
    obelisk childthread range_watcher();
  }

  function_cf308f348d516c65(time, obelisk, "players_out_of_range");

  if(starting_state == obelisk.puzzle_state) {
    iprintlnbold("<dev string:x135>");

    thread reset_puzzle(obelisk);
  }
}

function reset_puzzle(obelisk) {
  iprintlnbold("<dev string:x151>");

  assert(obelisk.puzzle_state != 0);

  if(obelisk.puzzle_state == 1) {
    obelisk.base setscriptablepartstate("interact", "off");
  } else if(obelisk.puzzle_state == 2) {
    shutdown_obelisk(obelisk);
  } else if(obelisk.puzzle_state == 3) {
    if(isDefined(obelisk.negotiator)) {
      obelisk.negotiator callback::remove("on_zombie_ai_killed", &function_7c0957e4e8184593);
      obelisk.negotiator kill();
      obelisk.negotiator = undefined;
    }

    if(isDefined(obelisk.rewardrift)) {
      function_6099c5a2ad80e231(obelisk.rewardrift);
      obelisk.rewardrift = undefined;
    }
  }

  if(!istrue(obelisk.var_fa9e06a77032916e) || getdvarint(@ "hash_5a8ca99f137d0a44", 0)) {
    obelisk.rune_manager function_24e03be2bc20e57b();
  }

  obelisk notify("spatial_puzzle_reset");
  waitframe();
  obelisk.players = function_fdc9d5557c53078e(obelisk.players);

  foreach(player in obelisk.players) {
    player.var_338560ff664aecb3 = 0;

    if(player function_8e888e08a6ab22d3("jup_ob_spatial_puzzle")) {
      player vision_utility::function_9a92ae402e209ecc("jup_ob_spatial_puzzle");
    }
  }

  if(isDefined(obelisk.activation_trigger)) {
    obelisk.activation_trigger delete();
  }

  obelisk.puzzle_state = 0;

  if(isDefined(obelisk.var_7eb73407060d7cb6)) {
    obelisk thread[[obelisk.var_7eb73407060d7cb6]](obelisk.puzzle_state);
  }

  obelisk.var_e00ac5b70d752deb = undefined;

  foreach(player in obelisk.players) {
    if(isDefined(player)) {
      player.var_fdbbf03042084910 = 0;
    }
  }

  obelisk.players = undefined;
  obelisk.potential_players = undefined;
  obelisk.var_152662fdff5f3b47 = undefined;
  obelisk.var_ff9089bede742254 = undefined;
  obelisk.var_21dcf44eef6e9fa2 = undefined;
  level thread function_6abd388d691cb822(obelisk);
}

function function_de57fa38335a4b65(obelisk) {
  zombie_spawn_loc = obelisk.var_fc394e11bae17823;

  if(obelisk.element == "fire") {
    obelisk.var_ab4d4020e9dafd85 = 0;
    obelisk.var_a17335bae5bfec86 = 0;

    while(obelisk.var_ab4d4020e9dafd85 < 6) {
      if(obelisk.var_ab4d4020e9dafd85 == 5) {
        negotiator = scripts\mp\mp_agent::spawnnewagentaitype("jup_spawner_zombie_hellhound_spatial", zombie_spawn_loc.origin, undefined, "team_two_hundred");
        negotiator namespace_4df2ab39b0e96ec7::function_4a4fab5fd0b06d7b("difficulty_hard");
        negotiator callback::add("on_zombie_ai_killed", &on_dog_killed, obelisk);
        obelisk.var_ab4d4020e9dafd85++;
        continue;
      }

      negotiator = scripts\mp\mp_agent::spawnnewagentaitype("jup_spawner_zombie_hellhound", zombie_spawn_loc.origin, undefined, "team_two_hundred");
      negotiator namespace_4df2ab39b0e96ec7::function_4a4fab5fd0b06d7b("difficulty_hard");
      negotiator callback::add("on_zombie_ai_killed", &on_dog_killed, obelisk);
      obelisk.var_ab4d4020e9dafd85++;
      wait 1;
    }

    thread scripts\cp_mp\overlord::playevent("RFT_S3_5_RGUQ_Negotiator_Spawn_Drawing", obelisk.players);
    return;
  }

  negotiator = scripts\mp\mp_agent::spawnnewagentaitype(level.var_50f9183dc541bd7d[obelisk.element], zombie_spawn_loc.origin, undefined, "team_two_hundred");

  if(obelisk.element == "ice") {
    thread scripts\cp_mp\overlord::playevent("RFT_S3_5_RGUQ_Negotiator_Spawn_Laptop", obelisk.players);
  } else if(obelisk.element == "toxic") {
    thread scripts\cp_mp\overlord::playevent("RFT_S3_5_RGUQ_Negotiator_Spawn_Journal", obelisk.players);
  }

  negotiator namespace_4df2ab39b0e96ec7::function_4a4fab5fd0b06d7b("difficulty_hard");
  negotiator callback::add("on_zombie_ai_killed", &function_7c0957e4e8184593, obelisk);
  obelisk.negotiator = negotiator;
}

function on_dog_killed(params, obelisk) {
  obelisk.var_a17335bae5bfec86++;

  if(obelisk.var_a17335bae5bfec86 >= 6) {
    spawn_reward(obelisk);
  }
}

function function_7c0957e4e8184593(params, obelisk) {
  obelisk.negotiator = undefined;
  spawn_reward(obelisk);
}

function function_510aa363d2583f0(params) {
  cache = spawnStruct();
  items = function_bc2f4857c90f5344("ob_jup_items_activity_spatial", 3);
  common_cache::function_fd95ef820bb2b980(items, cache);
  return cache.contents;
}

function function_ae2ad994e01b239e(var_ed118e6dd8c246) {
  cache = spawnStruct();
  s3_name = namespace_9866a3bced571d62::function_54b2c5a00ed87d60(var_ed118e6dd8c246.obelisk.element);
  items = function_bc2f4857c90f5344("ob_jup_hydro_obelisk_reward_" + s3_name + "_attuned_s3", 1);
  common_cache::function_fd95ef820bb2b980(items, cache);
  return cache.contents;
}

function spawn_reward(obelisk) {
  level endon("game_ended");
  obelisk endon("spatial_puzzle_reset");
  obelisk notify("spatial_puzzle_completed");
  obelisk.players = function_fdc9d5557c53078e(obelisk.players);

  foreach(player in obelisk.players) {
    if(player function_8e888e08a6ab22d3("jup_ob_spatial_puzzle")) {
      player vision_utility::function_9a92ae402e209ecc("jup_ob_spatial_puzzle");
    }
  }

  a_players = obelisk.players;

  if(!isarray(a_players)) {
    return;
  }

  if(a_players.size == 0) {
    return;
  }

  iprintlnbold("<dev string:x16d>");

  reward_groups = [];

  foreach(player in a_players) {
    reward_groups[reward_groups.size] = [player];
  }

  if(istrue(obelisk.var_e00ac5b70d752deb)) {
    namespace_e8853d3344e33cf6::function_863be9e39e19fe2f(reward_groups, obelisk.var_f5acf56d7a0a1404, &function_510aa363d2583f0, undefined, obelisk);

    if(obelisk.season == 5) {
      thread scripts\cp_mp\overlord::playevent("STY_S5_5_SPEEQ_Complete", obelisk.players, 3);
    } else {
      i = randomint(3);

      switch (i) {
        case 0:
          thread scripts\cp_mp\overlord::playconversation("STY_S3_5_SPEEQ_Complete_Alt01", obelisk.players, 5);
          break;
        case 1:
          thread scripts\cp_mp\overlord::playconversation("STY_S3_5_SPEEQ_Complete_Alt02", obelisk.players, 5);
          break;
        case 2:
          thread scripts\cp_mp\overlord::playconversation("STY_S3_5_SPEEQ_Complete_Alt03", obelisk.players, 5);
          break;
      }
    }
  } else {
    var_ed118e6dd8c246 = spawnStruct();
    var_ed118e6dd8c246.obelisk = obelisk;
    reward_groups = [];

    foreach(player in obelisk.var_152662fdff5f3b47) {
      if(isDefined(player)) {
        reward_groups[reward_groups.size] = [player];
      }
    }

    namespace_e8853d3344e33cf6::function_863be9e39e19fe2f(reward_groups, obelisk.var_f5acf56d7a0a1404, &function_ae2ad994e01b239e, var_ed118e6dd8c246, obelisk);

    if(obelisk.element == "fire") {
      thread scripts\cp_mp\overlord::playevent("RFT_S3_5_RGUQ_Collect_Journal", obelisk.players, 3);
    } else if(obelisk.element == "ice") {
      thread scripts\cp_mp\overlord::playevent("RFT_S3_5_RGUQ_Collect_Laptop", obelisk.players, 3);
    } else if(obelisk.element == "toxic") {
      thread scripts\cp_mp\overlord::playevent("RFT_S3_5_RGUQ_Collect_Drawing", obelisk.players, 3);
    }
  }

  obelisk waittill("managed_reward_cache_spawn_done", rewardrift);
  obelisk.rewardrift = rewardrift;
  rewardrift waittill("managed_reward_cache_despawned");
  obelisk.rewardrift = undefined;

  if(obelisk.puzzle_state != 2) {
    thread reset_puzzle(obelisk);
  }
}