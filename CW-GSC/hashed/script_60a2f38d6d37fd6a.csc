/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_60a2f38d6d37fd6a.csc
***********************************************/

#using script_18910f59cc847b42;
#using script_30c7fb449869910;
#using script_3314b730521b9666;
#using script_38635d174016f682;
#using script_42cbbdcd1e160063;
#using script_64e5d3ad71ce8140;
#using script_67049b48b589d81;
#using script_6b71c9befed901f2;
#using script_71603a58e2da0698;
#using script_75c3996cce8959f7;
#using script_76abb7986de59601;
#using script_77163d5a569e2071;
#using script_771f5bff431d8d57;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace doa_sound;

function init() {
  clientfield::register("world", "doa_announce", 1, 11, "int", &function_b9918ac7, 0, 0);
  level thread function_d32819b7();
  level.doa.var_f5ac1256 = array({
    #id: 0, #audio: undefined, #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 1, #audio: #"vox_zdan_doa_mode_title", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 2, #audio: #"vox_zdan_doa_fate_feet", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 3, #audio: #"vox_zdan_doa_fate_firepower", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 4, #audio: #"vox_zdan_doa_fate_fortune", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 5, #audio: #"vox_zdan_doa_fate_friend", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 6, #audio: #"vox_zdan_doa_fate_dvn_shield", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 7, #audio: #"vox_zdan_doa_fate_dvn_chalice", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 8, #audio: #"vox_zdan_doa_rof_choose", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 9, #audio: #"vox_zdan_doa_rof_done", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 10, #audio: #"vox_zdan_doa_rof_hint", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 11, #audio: #"vox_zdan_doa_hurry", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 12, #audio: #"vox_zdan_doa_bns_rm_discover", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 13, #audio: #"vox_zdan_doa_bns_rm_armory", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 14, #audio: #"vox_zdan_doa_bns_rm_coop", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 15, #audio: #"vox_zdan_doa_bns_rm_kaboom", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 16, #audio: #"vox_zdan_doa_bns_rm_trade_pst", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 17, #audio: #"vox_zdan_doa_bns_rm_veh_dpt", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 18, #audio: #"vox_zdan_doa_bns_rm_treasure", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 19, #audio: #"vox_zdan_doa_bns_area_discover", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 20, #audio: #"vox_zdan_doa_bns_area_cellar", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 21, #audio: #"vox_zdan_doa_bns_area_platform", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 22, #audio: #"vox_zdan_doa_bns_area_crypt", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 23, #audio: #"vox_zdan_doa_bns_area_temple", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 24, #audio: #"vox_zdan_doa_item_ammo_can", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 25, #audio: #"vox_zdan_doa_item_arcade", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 26, #audio: #"vox_zdan_doa_item_barrel", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 27, #audio: #"vox_zdan_doa_item_booster", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 28, #audio: #"vox_zdan_doa_item_nuke", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 29, #audio: #"vox_zdan_doa_item_boots", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 30, #audio: #"vox_zdan_doa_item_boxing", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 31, #audio: #"vox_zdan_doa_item_chicken", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 32, #audio: #"vox_zdan_doa_item_clock", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 33, #audio: #"vox_zdan_doa_item_coat_arms", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 34, #audio: #"vox_zdan_doa_item_egg", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 35, #audio: #"vox_zdan_doa_item_egg_gold", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 36, #audio: #"vox_zdan_doa_item_life", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 37, #audio: #"vox_zdan_doa_item_1st_person", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 38, #audio: #"vox_zdan_doa_item_flashlight", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 39, #audio: #"vox_zdan_doa_item_gift", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 40, #audio: #"vox_zdan_doa_item_hat", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 41, #audio: #"vox_zdan_doa_item_health", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 42, #audio: #"vox_zdan_doa_item_hind", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 43, #audio: #"vox_zdan_doa_item_lantern", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 44, #audio: #"vox_zdan_doa_item_magnet", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 45, #audio: #"vox_zdan_doa_item_monkey", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 46, #audio: #"vox_zdan_doa_item_sawblade", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 47, #audio: #"vox_zdan_doa_item_sentry", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 48, #audio: #"vox_zdan_doa_item_skeleton", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 49, #audio: #"vox_zdan_doa_item_skeleton_key", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 50, #audio: #"vox_zdan_doa_item_sprinkler", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 51, #audio: #"vox_zdan_doa_item_teddy", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 52, #audio: #"vox_zdan_doa_item_tesla", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 53, #audio: #"vox_zdan_doa_item_umbrella", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 54, #audio: #"vox_zdan_doa_item_vortex", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 55, #audio: #"vox_zdan_doa_item_wpn_charge", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 56, #audio: #"vox_zdan_doa_item_mech", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 57, #audio: #"vox_zdan_doa_item_tank", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 58, #audio: #"vox_zdan_doa_item_sam_turret", #cooldown: 120000, #lastplayed: 0, #roll: 5
  }, {
    #id: 59, #audio: #"vox_zdan_doa_wild_enter", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 60, #audio: #"vox_zdan_doa_wild_exit", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 61, #audio: #"vox_zdan_doa_deadly_dungeon", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 62, #audio: #"vox_zdan_doa_challenge_rnd", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 63, #audio: #"vox_zdan_doa_boss_enc_enter", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 64, #audio: #"vox_zdan_doa_monster_mashup", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 65, #audio: #"vox_zdan_doa_boss_enc_skeleton", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 66, #audio: #"vox_zdan_doa_boss_enc_margwa", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 67, #audio: #"vox_zdan_doa_boss_enc_wwolf", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 68, #audio: #"vox_zdan_doa_boss_enc_gngnss", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 69, #audio: #"vox_zdan_doa_boss_enc_blight", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 70, #audio: #"vox_zdan_doa_mama_chase", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 71, #audio: #"vox_zdan_doa_fate_room", #cooldown: 0, #lastplayed: 0, #roll: 100
  }, {
    #id: 72, #audio: #"vox_zdan_doa_game_over", #cooldown: 0, #lastplayed: 0, #roll: 100
  });
  function_32d5e898();
}

function function_5521aa1c(localclientnum) {
  if(localclientnum != 0) {
    return;
  }

  self notify("11fa0ea36c3aeb7c");
  self endon("11fa0ea36c3aeb7c");

  if(isDefined(level.doa.var_57e2aa98)) {
    stopsound(level.doa.var_57e2aa98);
    level.doa.var_57e2aa98 = undefined;
  }

  level.doa.voqueue = [];

  while(true) {
    if(!isDefined(level.doa.var_57e2aa98)) {
      if(level.doa.voqueue.size) {
        queueitem = level.doa.voqueue[0];
        arrayremoveindex(level.doa.voqueue, 0);

        if(queueitem.localclientnum != localclientnum) {
          continue;
        }

        if(isDefined(queueitem.entity)) {
          level.doa.var_57e2aa98 = queueitem.entity playSound(queueitem.localclientnum, queueitem.line);
        } else {
          level.doa.var_57e2aa98 = playSound(queueitem.localclientnum, queueitem.line);
        }
      }

      wait 0.1;
      continue;
    }

    while(soundplaying(level.doa.var_57e2aa98)) {
      wait 0.2;
    }

    level.doa.var_57e2aa98 = undefined;
    wait 1.2;
  }
}

function function_9a237f2f(localclientnum, voline, entity) {
  if(isDefined(voline)) {
    queueitem = {
      #line: voline, #localclientnum: localclientnum, #time: gettime(), #entity: entity
    };

    if(!isDefined(level.doa.voqueue)) {
      level.doa.voqueue = [];
    } else if(!isarray(level.doa.voqueue)) {
      level.doa.voqueue = array(level.doa.voqueue);
    }

    level.doa.voqueue[level.doa.voqueue.size] = queueitem;
  }
}

function announce(localclientnum, var_fa5e0d11) {
  line = level.doa.var_f5ac1256[var_fa5e0d11];
  line.lastplayed = gettime() + line.cooldown;
  function_9a237f2f(localclientnum, line.audio);
}

function function_b9918ac7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 0) {
    return;
  }

  if(fieldname != 0) {
    return;
  }

  playermask = bwastimejump & 15;
  var_fa5e0d11 = bwastimejump >> 4;
  line = level.doa.var_f5ac1256[var_fa5e0d11];

  if(line.lastplayed > gettime()) {
    return;
  }

  roll = randomint(100);

  if(roll >= line.roll) {
    return;
  }

  if(playermask == 15) {
    announce(fieldname, var_fa5e0d11);
    return;
  }

  players = getlocalplayers();

  foreach(player in players) {
    if(!isDefined(player.entnum)) {
      continue;
    }

    var_a10d0ff1 = 1 << player.entnum;

    if(var_a10d0ff1 &playermask == 0) {
      continue;
    }

    announce(fieldname, var_fa5e0d11);
  }
}

function function_32d5e898(localclientnum = 0) {
  level thread function_5521aa1c(localclientnum);
  util::delay(2, "game_over", &arena_changed);

  for(i = 0; i < level.doa.var_f5ac1256.size; i++) {
    assert(i == level.doa.var_f5ac1256[i].id, "<dev string:x38>");
    level.doa.var_f5ac1256[i].lastplayed = 0;
  }
}

function function_a77649db(onoff, str_name) {
  if(is_true(onoff)) {
    level.var_1d1399b = level.var_5d4c7696;
    function_30f7911(2, str_name);
    return;
  }

  function_f2198fe(level.var_1d1399b);
}

function arena_changed() {
  if(isDefined(level.doa.current_arena)) {
    name = level.doa.current_arena.script_noteworthy;
    var_8576a4b1 = level.doa.roundnumber;
    function_30f7911(0, name);
  }
}

function function_2fc07d61() {}

function function_65fcd877() {
  switch (level.doa.world_state) {
    case 0:
      peak = 1;
      break;
    case 4:
      function_30f7911(4);
      function_319e479e();
      break;
    case 5:
      function_30f7911(5);
      break;
    case 1:
      function_30f7911(1);
      break;
  }
}

function function_30f7911(type, str_name = undefined) {
  if(!isDefined(level.var_5d4c7696)) {
    level.var_5d4c7696 = "";
  }

  if(!isDefined(level.var_1d1399b)) {
    level.var_1d1399b = "";
  }

  var_fc7248c7 = undefined;

  switch (type) {
    case 0:
      if(isDefined(str_name)) {
        var_fc7248c7 = "zm_doa_arena_" + str_name;
      } else {
        var_fc7248c7 = "zm_doa_arena_default";
      }

      break;
    case 2:
      if(isDefined(str_name)) {
        var_fc7248c7 = "zm_doa_bonusroom_" + str_name;
      } else {
        var_fc7248c7 = "zm_doa_bonusroom_default";
      }

      break;
    case 4:
      var_fc7248c7 = "zm_doa_overworld";
      break;
    case 5:
      var_fc7248c7 = "zm_doa_dungeon";
      break;
    case 1:
      var_fc7248c7 = "zm_doa_gameover";
      break;
  }

  function_f2198fe(var_fc7248c7);
}

function function_f2198fe(var_fc7248c7) {
  if(level.var_5d4c7696 !== var_fc7248c7) {
    level.var_5d4c7696 = var_fc7248c7;
    forceambientroom(var_fc7248c7);
  }
}

function function_d32819b7() {
  for(i = 1; i < 20; i++) {
    var_ad059c41 = #"hash_3e8aee7efd30e549" + i;
    function_2cca7b47(0, var_ad059c41);
  }
}

function function_319e479e() {
  audio::playloopat(#"amb_swamp_crickets_2", (1073, 7378, 1229));
  audio::playloopat(#"amb_swamp_crickets", (319, 7216, 1229));
}