/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\ob_season2.gsc
**************************************************/

#using script_4a6760982b403bad;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\interaction;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#namespace ob_season2;

function autoexec init() {
  level callback::add("ob_season_main", &main);
  level callback::add("ob_register_activities", &register_activities);
  level callback::add("ob_register_objectives", &register_objectives);
  level callback::add("ob_register_features", &register_features);
  level.var_5a66999895b55b96 = getdvarint(@ "hash_bd0a763d48b336f5", 0) > 0;
}

function main(params) {
  level callback::remove("ob_season_main", &main);

  if(getdvarint(@ "hash_ad72718b4d22e7ab")) {
    level thread function_426e2d5e82b19fb();
  }
}

function function_426e2d5e82b19fb() {
  level.var_e6d635dd9b7f73b3 = getdvarint(@ "hash_caf515c488fdab2d", 10);
  level.var_2862a46691940273 = getdvarint(@ "hash_b0c6c5ca6091cbad", 1);
  level.var_eb9d721411a7178a = getdvarint(@ "hash_5f5d3ac3132ad474", 1);
  level.var_2a0c9dcc6a722a85 = getdvarint(@ "hash_298806cb88a49b17", 1);
  level.bones = [];
  level.skulls = [];
  callback::add("player_laststand", &function_1fd107db3ec3ec54);
  callback::add("on_zombie_ai_killed", &function_7d05d2bf4fbde466);
  telemetry_utils::function_aacbbe63c26687ae("callback_on_player_disconnect", &function_e13c1c48f9ef635);
}

function register_activities(params) {
  level callback::remove("ob_register_activities", &register_activities);
}

function register_objectives(params) {
  level callback::remove("ob_register_objectives", &register_objectives);
}

function register_features(params) {
  mapname = getmapname();

  switch (mapname) {
    case #"hash_9ae3f9a4f2372775":
      break;
  }

  level callback::remove("ob_register_features", &register_features);
}

function private function_7d05d2bf4fbde466(params) {
  playerattacker = params.eattacker;

  if(isDefined(playerattacker) && !isPlayer(playerattacker) && isPlayer(playerattacker.owner)) {
    playerattacker = playerattacker.owner;
  }

  if(isPlayer(playerattacker)) {
    if(isDefined(self) && isDefined(self.subclass)) {
      var_c70099220a5c67ee = getdvarint(@ "hash_493b5b1eb25f7f81", 0);

      if(var_c70099220a5c67ee > 0) {
        spawn_location = self.origin + (0, 0, 14);

        switch (self.subclass) {
          case #"hash_1380581f5144c465":
          case #"hash_f297af39454fdc7b":
            if(var_c70099220a5c67ee >= 1 && percent_chance(getdvarint(@ "hash_6dea1d89fd168935", 75))) {
              thread spawn_bone(spawn_location);
            }

            break;
          case #"hash_99a38be9e88b5244":
            if(var_c70099220a5c67ee >= 1 && percent_chance(getdvarint(@ "hash_652b35661fa52935", 100))) {
              thread spawn_skull(spawn_location, self.subclass);
            }

            break;
          case #"hash_99d5ac2f7a4d8083":
            if(var_c70099220a5c67ee >= 2 && percent_chance(getdvarint(@ "hash_e1878b1f5eae27dd", 100))) {
              thread spawn_skull(spawn_location, self.subclass);
            }

            break;
          case #"hash_59740dd906312a95":
          case #"hash_c1fa8721b046b258":
            if(var_c70099220a5c67ee >= 3 && percent_chance(getdvarint(@ "hash_1947619f873ba823", 100))) {
              thread spawn_skull(spawn_location, self.subclass);
            }

            break;
          default:
            break;
        }
      }
    }
  }
}

function function_1fd107db3ec3ec54(params) {
  self endon("death_or_disconnect");
  self endon("laststand_revived");

  while(true) {
    skulls = sortbydistancecullbyradius(level.skulls, self.origin, 256);
    bones = sortbydistancecullbyradius(level.bones, self.origin, 256);
    var_dbfc725687c096de = [];
    var_cddb5759bba08001 = [];

    foreach(skull in skulls) {
      if(isDefined(skull)) {
        if(distancesquared(self.origin, skull.origin) <= squared(50)) {
          var_dbfc725687c096de = array_add(var_dbfc725687c096de, skull);
        }
      }
    }

    foreach(bone in bones) {
      if(isDefined(bone)) {
        if(distancesquared(self.origin, bone.origin) <= squared(50)) {
          var_cddb5759bba08001 = array_add(var_cddb5759bba08001, bone);
        }
      }
    }

    foreach(skull in var_dbfc725687c096de) {
      if(isDefined(skull)) {
        skull function_5ef509a71c51c2a0(self);
      }
    }

    foreach(bone in var_cddb5759bba08001) {
      if(isDefined(bone)) {
        bone function_42322dcd60709cc3(self);
      }
    }

    wait 0.1;
  }
}

function spawn_bone(spawn_location) {
  bone = spawnscriptable("ob_hunt_bone_pile", spawn_location);
  scripts\cp_mp\interaction::function_32645103f7520635(bone, undefined, &function_42322dcd60709cc3);
  level.bones = array_add(level.bones, bone);
  bone thread function_637a0270d3f077d3();
}

function spawn_skull(spawn_location, zombie_subclass) {
  switch (zombie_subclass) {
    case #"hash_99a38be9e88b5244":
      var_80199c685105ede4 = "ob_hunt_armored_skull";
      break;
    case #"hash_99d5ac2f7a4d8083":
      var_80199c685105ede4 = "ob_hunt_hellhound_skull";
      break;
    case #"hash_59740dd906312a95":
    case #"hash_c1fa8721b046b258":
      var_80199c685105ede4 = "ob_hunt_mimic_skull";
      break;
    default:
      break;
  }

  skull = spawnscriptable(var_80199c685105ede4, spawn_location);
  skull.var_12a8270096fdd301 = zombie_subclass;
  scripts\cp_mp\interaction::function_32645103f7520635(skull, undefined, &function_5ef509a71c51c2a0);
  level.skulls = array_add(level.skulls, skull);
  skull thread function_637a0270d3f077d3();
}

function function_637a0270d3f077d3() {
  self endon("stop_spin");
  wait getdvarint(@ "hash_4d140eb9ae94e43", 30);

  if(isDefined(self.var_12a8270096fdd301)) {
    level.skulls = array_remove(level.skulls, self);
  } else {
    level.bones = array_remove(level.bones, self);
  }

  self freescriptable();
}

function function_42322dcd60709cc3(player) {
  scriptable = self;

  if(!isDefined(player.bone_count)) {
    player.bone_count = 0;
  }

  player.bone_count++;
  player scripts\cp_mp\challenges::function_8359cadd253f9604(player, "event_the_hunt_bones", level.var_e6d635dd9b7f73b3);
  player function_b216b39d9ea94e4a(level.var_e6d635dd9b7f73b3);
  player playsoundtoplayer("jup_hordepoint_bone_pickup", player);
  scriptable notify("stop_spin");
  level.bones = array_remove(level.bones, self);
  scriptable freescriptable();
  player notify("drop_pickup");
}

function function_5ef509a71c51c2a0(player) {
  squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();

  switch (self.var_12a8270096fdd301) {
    case #"hash_99a38be9e88b5244":
      foreach(member in squad) {
        if(!isDefined(member.var_d0b217f00fef3917)) {
          member.var_d0b217f00fef3917 = 0;
        }

        member.var_d0b217f00fef3917++;
        member scripts\cp_mp\challenges::function_8359cadd253f9604(member, "event_the_hunt_skulls_armored", level.var_eb9d721411a7178a);
        member function_cadce08fab348041(level.var_eb9d721411a7178a);
      }

      player playsoundtoplayer("jup_hordepoint_skull_helmet_pickup", player);
      break;
    case #"hash_99d5ac2f7a4d8083":
      foreach(member in squad) {
        if(!isDefined(member.var_d848e2025d8597d2)) {
          member.var_d848e2025d8597d2 = 0;
        }

        member.var_d848e2025d8597d2++;
        member scripts\cp_mp\challenges::function_8359cadd253f9604(member, "event_the_hunt_skulls_hellhound", level.var_2862a46691940273);
        member function_cadce08fab348041(level.var_2862a46691940273);
      }

      player playsoundtoplayer("jup_hordepoint_skull_dog_pickup", player);
      break;
    case #"hash_59740dd906312a95":
    case #"hash_c1fa8721b046b258":
      foreach(member in squad) {
        if(!isDefined(member.var_92e210c188ad9778)) {
          member.var_92e210c188ad9778 = 0;
        }

        member.var_92e210c188ad9778++;
        member scripts\cp_mp\challenges::function_8359cadd253f9604(member, "event_the_hunt_skulls_mimic", level.var_2a0c9dcc6a722a85);
        member function_cadce08fab348041(level.var_2a0c9dcc6a722a85);
      }

      player playsoundtoplayer("jup_hordepoint_skull_elite_pickup", player);
      break;
    default:
      break;
  }

  self notify("stop_spin");
  level.skulls = array_remove(level.skulls, self);
  self freescriptable();
  player notify("drop_pickup");
}

function function_b216b39d9ea94e4a(drop_amount) {
  if(!isDefined(self.var_71466585b9fe6080)) {
    self.var_71466585b9fe6080 = 0;
  }

  self.var_71466585b9fe6080 += drop_amount;
  self setclientomnvar("ui_bones_collected", self.var_71466585b9fe6080);
}

function function_cadce08fab348041(drop_amount) {
  if(!isDefined(self.var_4096aeb7caafc01f)) {
    self.var_4096aeb7caafc01f = 0;
  }

  self.var_4096aeb7caafc01f += drop_amount;
  self setclientomnvar("ui_skulls_collected", self.var_4096aeb7caafc01f);
}

function function_e13c1c48f9ef635(data) {
  gamelogic::function_8abcf76787cc51aa(data.player);
}