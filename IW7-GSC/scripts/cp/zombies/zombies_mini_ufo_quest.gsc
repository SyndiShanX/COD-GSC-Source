/*********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombies_mini_ufo_quest.gsc
*********************************************************/

init() {
  level.active_mini_ufo_trap = [];
  level.active_mini_ufo_trap["disco"] = 0;
  level.active_mini_ufo_trap["beam"] = 0;
  level.active_mini_ufo_trap["blackhole"] = 0;
  level.active_mini_ufo_trap["rocket"] = 0;
  var_0 = getent("pap_room_mini_ufo_trigger", "targetname");
  var_1 = scripts\engine\utility::getStructArray("pap_room_mini_ufos", "targetname");
  var_0.miniufos = [];
  level thread waitforplayertriggered(var_0);
  var_2 = scripts\engine\utility::array_randomize(["yellow", "blue", "green", "red"]);
  foreach(var_5, var_4 in var_1) {
    level thread mini_ufo_init(var_4, var_0, var_2[var_5]);
    wait(0.05);
  }

  scripts\engine\utility::flag_init("mini_ufo_blue_ready");
  scripts\engine\utility::flag_init("mini_ufo_red_ready");
  scripts\engine\utility::flag_init("mini_ufo_yellow_ready");
  scripts\engine\utility::flag_init("mini_ufo_green_ready");
  scripts\engine\utility::flag_init("mini_ufo_blue_collecting");
  scripts\engine\utility::flag_init("mini_ufo_red_collecting");
  scripts\engine\utility::flag_init("mini_ufo_yellow_collecting");
  scripts\engine\utility::flag_init("mini_ufo_green_collecting");
}

mini_ufo_init(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0.origin);
  if(isDefined(var_0.angles)) {
    var_3.angles = var_0.angles;
  }

  var_3 setModel("park_ufo_statue_toy");
  var_1.miniufos[var_1.miniufos.size] = var_3;
  var_3.effect = var_2;
  var_3.color = strtok(var_2, "_")[0];
  var_3.path = [];
  switch (var_2) {
    case "blue":
      level.rocket_mini_ufo = var_3;
      break;

    case "green":
      level.disco_mini_ufo = var_3;
      break;

    case "yellow":
      level.steel_dragon_mini_ufo = var_3;
      break;

    case "red":
      level.chromosphere_mini_ufo = var_3;
      break;

    default:
      break;
  }

  level thread getminiufopath(var_0, var_3);
}

getminiufopath(var_0, var_1) {
  var_1.startingstruct = var_0;
  var_2 = var_0;
  var_3 = undefined;
  var_4 = undefined;
  for(;;) {
    if(isDefined(var_3)) {
      var_4 = var_3;
      var_3 = undefined;
    } else if(isDefined(var_2.target)) {
      var_5 = scripts\engine\utility::getStructArray(var_2.target, "targetname");
      if(var_5.size > 1) {
        foreach(var_7 in var_5) {
          if(isDefined(var_7.script_noteworthy) && var_7.script_noteworthy == var_1.color) {
            var_4 = var_7;
            break;
          }
        }
      } else {
        var_4 = var_5[0];
      }
    } else {
      break;
    }

    if(scripts\engine\utility::array_contains(var_1.path, var_4)) {
      break;
    }

    var_1.path[var_1.path.size] = var_4;
    if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "mini_ufo_teleport_to_center") {
      var_3 = scripts\engine\utility::getstruct("mini_ufo_center_struct", "targetname");
    }

    var_2 = var_4;
  }
}

waitforplayertriggered(var_0) {
  if(scripts\cp\utility::is_codxp()) {
    return;
  }

  var_0 waittill("trigger", var_1);
  var_2 = 0;
  foreach(var_4 in var_0.miniufos) {
    level thread spawnuniversaldangerzone(var_4);
    var_2++;
    wait(randomfloatrange(0.25, 1));
  }
}

distance_check_for_vo(var_0) {
  level endon("game_ended");
  self endon("death");
  scripts\engine\utility::flag_wait("mini_ufo_" + var_0 + "_ready");
  if(!scripts\engine\utility::istrue(self.played_alias_ufostart)) {
    self.played_alias_ufostart = 0;
  }

  while(scripts\engine\utility::flag("mini_ufo_" + var_0 + "_ready")) {
    var_1 = scripts\engine\utility::get_array_of_closest(self.origin, level.players, undefined, 10, 1000);
    foreach(var_3 in var_1) {
      if(sighttracepassed(self.origin, var_3 getEye(), 0, self)) {
        if(!scripts\cp\utility::weaponhasattachment(var_3 getcurrentweapon(), "arcane_base") && !self.played_alias_ufostart) {
          var_3 thread scripts\cp\cp_vo::try_to_play_vo("quest_arcane_nocore_start", "zmb_comment_vo");
          self.played_alias_ufostart = 1;
          continue;
        } else {
          var_3 thread scripts\cp\cp_vo::try_to_play_vo("quest_arcane_ufo_question", "zmb_comment_vo");
          self.played_alias_ufostart = 1;
          continue;
        }
      }
    }

    wait(randomfloatrange(10, 30));
  }
}

spawnuniversaldangerzone(var_0, var_1) {
  var_0 setModel("tag_origin_mini_ufo");
  var_1 = var_0.effect;
  var_0 setscriptablepartstate("miniufo", var_1);
  thread update_ufo_angles(var_0, var_1);
  var_2 = var_0.startingstruct;
  var_3 = get_next_valid_struct(var_0, var_2, var_1);
  var_4 = 300;
  var_0 thread distance_check_for_vo(var_1);
  for(;;) {
    if(scripts\engine\utility::flag("mini_ufo_" + var_1 + "_collecting")) {
      scripts\engine\utility::flag_waitopen("mini_ufo_" + var_1 + "_collecting");
      var_0 setscriptablepartstate("miniufo", "mini_ufo");
    }

    if(scripts\engine\utility::flag("mini_ufo_" + var_1 + "_ready")) {
      var_4 = 150;
    } else if(isDefined(var_2.script_speed)) {
      var_4 = var_2.script_speed;
    }

    var_5 = var_3;
    var_5 = get_next_valid_struct(var_0, var_5, var_1);
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "mini_ufo_teleport_to_center") {
      var_0 dontinterpolate();
      var_0.origin = var_3.origin;
      var_0.angles = var_3.angles;
      wait(0.05);
    } else {
      var_6 = get_move_rate(var_0, var_2.origin, var_3.origin, var_4);
      thread changeangledelay(var_0, var_6, var_5, var_2, var_3);
      var_0 moveto(var_3.origin, var_6);
      var_0 waittill("movedone");
      if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "mini_ufo_ready") {
        var_4 = 150;
        scripts\engine\utility::flag_set("mini_ufo_" + var_1 + "_ready");
        var_0 setscriptablepartstate("miniufo", "mini_ufo");
      }
    }

    var_2 = var_3;
    var_3 = var_5;
  }
}

update_ufo_angles(var_0, var_1) {
  for(;;) {
    if(scripts\engine\utility::flag("mini_ufo_" + var_1 + "_collecting")) {
      scripts\engine\utility::flag_waitopen("mini_ufo_" + var_1 + "_collecting");
    }

    var_0 waittill("next_position_found", var_2, var_3);
    var_4 = vectortoangles(var_3.origin - var_2.origin) + (180, 0, 0);
    var_0 rotateto(var_4, 0.5, 0.05, 0.05);
  }
}

changeangledelay(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "mini_ufo_teleport_to_center") {
    wait(var_1 + 0.1);
  } else {
    wait(max(0.05, var_1 - 0.35));
  }

  var_0 notify("next_position_found", var_4, var_2);
}

get_next_valid_struct(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStructArray(var_1.target, "targetname");
  var_4 = [];
  var_5 = undefined;
  foreach(var_7 in var_3) {
    if(isDefined(var_7.script_noteworthy) && var_7.script_noteworthy == var_2) {
      var_5 = var_7;
      break;
    } else {
      var_5 = scripts\engine\utility::random(var_3);
    }
  }

  return var_5;
}

startrotationwhenneargoal(var_0, var_1, var_2) {
  var_3 = var_1;
  var_4 = 0.5;
  if(var_1 > 0.3) {
    var_3 = var_1 - 0.25;
    var_4 = min(max(var_3 / 10, 0.5), var_1);
  }

  wait(var_3);
  var_0 rotateto(var_2, var_4, 0.05, 0.05);
}

get_move_rate(var_0, var_1, var_2, var_3) {
  var_4 = distance(var_1, var_2);
  var_5 = var_4 / var_3;
  if(var_5 < 0.05) {
    var_5 = 0.05;
  }

  return var_5;
}