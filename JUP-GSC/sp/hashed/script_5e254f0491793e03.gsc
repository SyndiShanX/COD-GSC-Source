/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_5e254f0491793e03.gsc
*************************************************/

#using script_3a8f9ace195c9da9;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\utility;
#using scripts\cp_mp\armor;
#using scripts\engine\utility;
#namespace namespace_9e68fcb064867fe8;

function function_ed62d4f89b19c4f7() {
  self endon("disconnect");
  level endon("game_ended");

  thread function_b37245d7128a7c9d();

  function_2f72e447279d8fe5();
  flag_wait_all("cp_equipment_pickups_spawned", "dungeon_load_finished");
  level.var_40c0670d21517637 = function_55637fdcab8e697a();

  if(scripts\cp\utility::function_240f7f4e57340e8f() && isDefined(level.var_1b908bf18691b097) && isDefined(level.var_40c0670d21517637)) {
    var_a81adeb0e1f89320 = level.var_1b908bf18691b097.plate_carriers.size;
    assertex(level.var_40c0670d21517637.size <= var_a81adeb0e1f89320, "There can only be a maximum of " + var_a81adeb0e1f89320 + " in the level");
  }

  function_1623793645979b39();
}

function function_1623793645979b39() {
  if(isDefined(level.var_1b908bf18691b097)) {
    if(level.var_1b908bf18691b097.plate_level >= namespace_1170726b2799ea65::function_c9e9a9b526daf36a()) {
      function_5bb1ea396e15a905();
      return;
    }

    if(isDefined(level.var_40c0670d21517637)) {
      foreach(platecarrier in level.var_40c0670d21517637) {
        if(isDefined(platecarrier)) {
          if(function_e3d0931a4dd44ca5(platecarrier.id)) {
            function_3bc22ac967f38c8f(platecarrier);
          }
        }
      }
    }
  }
}

function function_b4492a14e5453ff9() {
  if(self.platecarrierlevel >= function_6f16016c53d6cf63()) {
    scripts\cp_mp\armor::setarmorhealth(self.maxarmorhealth);
    return;
  }

  self.platecarrierlevel++;
  self.maxarmorhealth += level.var_4b78859bacc88808;
  var_584d2e9b2d0a8db5 = self.armorhealth + level.var_4b78859bacc88808;
  scripts\cp_mp\armor::setarmorhealth(var_584d2e9b2d0a8db5);
}

function function_3bc22ac967f38c8f(platecarrier) {
  platecarrier setscriptablepartstate("jup_armor_platecarrier_upgrade", "hidden");
}

function function_482dddfa4e4203ec(platecarrier) {
  platecarrier setscriptablepartstate("jup_armor_platecarrier_upgrade", "visible");
}

function function_5bb1ea396e15a905() {
  self endon("disconnect");
  level endon("game_ended");

  if(isDefined(level.var_40c0670d21517637)) {
    foreach(platecarrier in level.var_40c0670d21517637) {
      if(isDefined(platecarrier)) {
        platecarrier setscriptablepartstate("jup_armor_platecarrier_upgrade", "hidden");
      }
    }
  }
}

function function_a0ea72ada55fbd51(platecarrier) {
  if(isDefined(platecarrier) && isDefined(platecarrier.id)) {
    namespace_1170726b2799ea65::function_bad5ef3aa306f41f(platecarrier.id, 1);
  }
}

function function_2d1491de2f41ee76(platecarrier) {
  if(isDefined(platecarrier) && isDefined(platecarrier.id)) {
    namespace_1170726b2799ea65::function_bad5ef3aa306f41f(platecarrier.id, 0);
  }
}

function function_e3d0931a4dd44ca5(id) {
  return istrue(level.var_1b908bf18691b097.plate_carriers[id]);
}

function function_71e5374cd9767388() {
  armorplates = getdvarint(@ "hash_d7b4016f72a67d64", -1);

  if(armorplates == -1) {
    if(isDefined(level.var_1b908bf18691b097)) {
      armorplates = level.var_1b908bf18691b097.plate_level;
    } else {
      armorplates = level.spawnarmorplates;
    }
  }

  armorhealth = armorplates * level.var_4b78859bacc88808;
  return int(armorhealth);
}

function function_5ce5226e2af5abf0(player) {
  maxarmor = function_71e5374cd9767388();
  return [maxarmor, level.spawnarmorplates];
}

function function_6f16016c53d6cf63() {
  if(scripts\cp\utility::function_240f7f4e57340e8f()) {
    var_a81adeb0e1f89320 = namespace_1170726b2799ea65::function_c9e9a9b526daf36a();
  } else {
    var_a81adeb0e1f89320 = 3;
  }

  return var_a81adeb0e1f89320;
}

function private function_2f72e447279d8fe5() {
  level.var_3c8e175d92be01ea = &function_5ce5226e2af5abf0;
  level.var_ade00516ceb8b9dc = &function_71e5374cd9767388;
  level.var_4941fc1ee570d4cb = &function_6f16016c53d6cf63;
}

function private function_55637fdcab8e697a() {
  var_5a6d897e9cfe5f52 = getentitylessscriptablearray("jup_armor_platecarrier_upgrade");
  var_5a6d897e9cfe5f52 = function_5e688876e26aad86(var_5a6d897e9cfe5f52);
  return var_5a6d897e9cfe5f52;
}

function private function_f9847167b5f0aef9() {
  if(isDefined(level.var_40c0670d21517637)) {
    for(i = 0; i < level.var_40c0670d21517637.size; i++) {
      if(isDefined(level.var_40c0670d21517637[i])) {
        namespace_1170726b2799ea65::function_bad5ef3aa306f41f(level.var_40c0670d21517637[i].id, 0);
        wait 0.25;
      }
    }
  }
}

function private function_13c824bf49bdd856() {
  if(isDefined(level.var_40c0670d21517637)) {
    for(i = 0; i < level.var_40c0670d21517637.size; i++) {
      if(isDefined(level.var_40c0670d21517637[i])) {
        namespace_1170726b2799ea65::function_bad5ef3aa306f41f(level.var_40c0670d21517637[i].id, 1);
        wait 0.25;
      }
    }
  }
}

function private function_5e688876e26aad86(var_5a6d897e9cfe5f52) {
  var_5a6d897e9cfe5f52 = sortbydistance(var_5a6d897e9cfe5f52, (0, 0, 0));

  for(i = 0; i < var_5a6d897e9cfe5f52.size; i++) {
    var_5a6d897e9cfe5f52[i].id = i;
  }

  return var_5a6d897e9cfe5f52;
}

function function_9a925eab434edb31(params) {
  plate_level = int(params[0]);

  foreach(player in level.players) {
    player namespace_1170726b2799ea65::function_58311dfacdcaf94c(plate_level);
    player.platecarrierlevel = plate_level;
    player.maxarmorhealth = plate_level * level.var_4b78859bacc88808;
    player scripts\cp_mp\armor::setarmorhealth(plate_level * level.var_4b78859bacc88808);
  }
}

function function_4682f8dfa41d520b() {
  for(i = 0; i <= level.var_1b908bf18691b097.plate_carriers.size; i++) {
    namespace_1170726b2799ea65::function_bad5ef3aa306f41f(i, 0);

    if(isDefined(level.var_40c0670d21517637)) {
      foreach(platecarrier in level.var_40c0670d21517637) {
        if(isDefined(platecarrier) && platecarrier.id == i) {
          function_482dddfa4e4203ec(platecarrier);
        }
      }
    }
  }
}

function function_b9cded415f99324c() {
  for(i = 0; i <= level.var_1b908bf18691b097.plate_carriers.size; i++) {
    namespace_1170726b2799ea65::function_bad5ef3aa306f41f(i, 1);

    if(isDefined(level.var_40c0670d21517637)) {
      foreach(platecarrier in level.var_40c0670d21517637) {
        if(isDefined(platecarrier) && platecarrier.id == i) {
          function_3bc22ac967f38c8f(platecarrier);
        }
      }
    }
  }
}

function function_b37245d7128a7c9d() {
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x1c>");
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x41>", "<dev string:x5a>", &function_4682f8dfa41d520b);
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x73>", "<dev string:x8a>", &function_b9cded415f99324c);
  scripts\common\devgui::function_fe953f000498048f();
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:xa1>");

  for(i = namespace_1170726b2799ea65::function_7a8132b8df34eec4(); i <= namespace_1170726b2799ea65::function_c9e9a9b526daf36a(); i++) {
    scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:xd6>" + i, "<dev string:xd7>" + i, &function_9a925eab434edb31);
  }

  scripts\common\devgui::function_fe953f000498048f();
}

# /