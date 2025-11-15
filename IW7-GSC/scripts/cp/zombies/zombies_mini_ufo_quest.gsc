/*********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombies_mini_ufo_quest.gsc
*********************************************************/

init() {
  level.active_mini_ufo_trap = [];
  level.active_mini_ufo_trap["disco"] = 0;
  level.active_mini_ufo_trap["beam"] = 0;
  level.active_mini_ufo_trap["blackhole"] = 0;
  level.active_mini_ufo_trap["rocket"] = 0;
  var_00 = getent("pap_room_mini_ufo_trigger", "targetname");
  var_01 = scripts\engine\utility::getstructarray("pap_room_mini_ufos", "targetname");
  var_00.miniufos = [];
  level thread waitforplayertriggered(var_00);
  var_02 = scripts\engine\utility::array_randomize(["yellow", "blue", "green", "red"]);
  foreach(var_05, var_04 in var_01) {
    level thread mini_ufo_init(var_04, var_00, var_02[var_05]);
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

mini_ufo_init(param_00, param_01, param_02) {
  var_03 = spawn("script_model", param_00.origin);
  if(isDefined(param_00.angles)) {
    var_03.angles = param_00.angles;
  }

  var_03 setModel("park_ufo_statue_toy");
  param_01.miniufos[param_01.miniufos.size] = var_03;
  var_03.effect = param_02;
  var_03.color = strtok(param_02, "_")[0];
  var_03.path = [];
  switch (param_02) {
    case "blue":
      level.rocket_mini_ufo = var_03;
      break;

    case "green":
      level.disco_mini_ufo = var_03;
      break;

    case "yellow":
      level.steel_dragon_mini_ufo = var_03;
      break;

    case "red":
      level.chromosphere_mini_ufo = var_03;
      break;

    default:
      break;
  }

  level thread getminiufopath(param_00, var_03);
}

getminiufopath(param_00, param_01) {
  param_01.startingstruct = param_00;
  var_02 = param_00;
  var_03 = undefined;
  var_04 = undefined;
  for(;;) {
    if(isDefined(var_03)) {
      var_04 = var_03;
      var_03 = undefined;
    } else if(isDefined(var_02.target)) {
      var_05 = scripts\engine\utility::getstructarray(var_02.target, "targetname");
      if(var_05.size > 1) {
        foreach(var_07 in var_05) {
          if(isDefined(var_07.script_noteworthy) && var_07.script_noteworthy == param_01.color) {
            var_04 = var_07;
            break;
          }
        }
      } else {
        var_04 = var_05[0];
      }
    } else {
      break;
    }

    if(scripts\engine\utility::array_contains(param_01.path, var_04)) {
      break;
    }

    param_01.path[param_01.path.size] = var_04;
    if(isDefined(var_04.script_noteworthy) && var_04.script_noteworthy == "mini_ufo_teleport_to_center") {
      var_03 = scripts\engine\utility::getstruct("mini_ufo_center_struct", "targetname");
    }

    var_02 = var_04;
  }
}

waitforplayertriggered(param_00) {
  if(scripts\cp\utility::is_codxp()) {
    return;
  }

  param_00 waittill("trigger", var_01);
  var_02 = 0;
  foreach(var_04 in param_00.miniufos) {
    level thread spawnuniversaldangerzone(var_04);
    var_02++;
    wait(randomfloatrange(0.25, 1));
  }
}

distance_check_for_vo(param_00) {
  level endon("game_ended");
  self endon("death");
  scripts\engine\utility::flag_wait("mini_ufo_" + param_00 + "_ready");
  if(!scripts\engine\utility::istrue(self.played_alias_ufostart)) {
    self.played_alias_ufostart = 0;
  }

  while(scripts\engine\utility::flag("mini_ufo_" + param_00 + "_ready")) {
    var_01 = scripts\engine\utility::get_array_of_closest(self.origin, level.players, undefined, 10, 1000);
    foreach(var_03 in var_01) {
      if(sighttracepassed(self.origin, var_03 getEye(), 0, self)) {
        if(!scripts\cp\utility::weaponhasattachment(var_03 getcurrentweapon(), "arcane_base") && !self.played_alias_ufostart) {
          var_03 thread scripts\cp\cp_vo::try_to_play_vo("quest_arcane_nocore_start", "zmb_comment_vo");
          self.played_alias_ufostart = 1;
          continue;
        } else {
          var_03 thread scripts\cp\cp_vo::try_to_play_vo("quest_arcane_ufo_question", "zmb_comment_vo");
          self.played_alias_ufostart = 1;
          continue;
        }
      }
    }

    wait(randomfloatrange(10, 30));
  }
}

spawnuniversaldangerzone(param_00, param_01) {
  param_00 setModel("tag_origin_mini_ufo");
  param_01 = param_00.effect;
  param_00 setscriptablepartstate("miniufo", param_01);
  thread update_ufo_angles(param_00, param_01);
  var_02 = param_00.startingstruct;
  var_03 = get_next_valid_struct(param_00, var_02, param_01);
  var_04 = 300;
  param_00 thread distance_check_for_vo(param_01);
  for(;;) {
    if(scripts\engine\utility::flag("mini_ufo_" + param_01 + "_collecting")) {
      scripts\engine\utility::flag_waitopen("mini_ufo_" + param_01 + "_collecting");
      param_00 setscriptablepartstate("miniufo", "mini_ufo");
    }

    if(scripts\engine\utility::flag("mini_ufo_" + param_01 + "_ready")) {
      var_04 = 150;
    } else if(isDefined(var_02.script_speed)) {
      var_04 = var_02.script_speed;
    }

    var_05 = var_03;
    var_05 = get_next_valid_struct(param_00, var_05, param_01);
    if(isDefined(var_02.script_noteworthy) && var_02.script_noteworthy == "mini_ufo_teleport_to_center") {
      param_00 dontinterpolate();
      param_00.origin = var_03.origin;
      param_00.angles = var_03.angles;
      wait(0.05);
    } else {
      var_06 = get_move_rate(param_00, var_02.origin, var_03.origin, var_04);
      thread changeangledelay(param_00, var_06, var_05, var_02, var_03);
      param_00 moveto(var_03.origin, var_06);
      param_00 waittill("movedone");
      if(isDefined(var_03.script_noteworthy) && var_03.script_noteworthy == "mini_ufo_ready") {
        var_04 = 150;
        scripts\engine\utility::flag_set("mini_ufo_" + param_01 + "_ready");
        param_00 setscriptablepartstate("miniufo", "mini_ufo");
      }
    }

    var_02 = var_03;
    var_03 = var_05;
  }
}

update_ufo_angles(param_00, param_01) {
  for(;;) {
    if(scripts\engine\utility::flag("mini_ufo_" + param_01 + "_collecting")) {
      scripts\engine\utility::flag_waitopen("mini_ufo_" + param_01 + "_collecting");
    }

    param_00 waittill("next_position_found", var_02, var_03);
    var_04 = vectortoangles(var_03.origin - var_02.origin) + (180, 0, 0);
    param_00 rotateto(var_04, 0.5, 0.05, 0.05);
  }
}

changeangledelay(param_00, param_01, param_02, param_03, param_04) {
  if(isDefined(param_02.script_noteworthy) && param_02.script_noteworthy == "mini_ufo_teleport_to_center") {
    wait(param_01 + 0.1);
  } else {
    wait(max(0.05, param_01 - 0.35));
  }

  param_00 notify("next_position_found", param_04, param_02);
}

get_next_valid_struct(param_00, param_01, param_02) {
  var_03 = scripts\engine\utility::getstructarray(param_01.target, "targetname");
  var_04 = [];
  var_05 = undefined;
  foreach(var_07 in var_03) {
    if(isDefined(var_07.script_noteworthy) && var_07.script_noteworthy == param_02) {
      var_05 = var_07;
      break;
    } else {
      var_05 = scripts\engine\utility::random(var_03);
    }
  }

  return var_05;
}

startrotationwhenneargoal(param_00, param_01, param_02) {
  var_03 = param_01;
  var_04 = 0.5;
  if(param_01 > 0.3) {
    var_03 = param_01 - 0.25;
    var_04 = min(max(var_03 / 10, 0.5), param_01);
  }

  wait(var_03);
  param_00 rotateto(param_02, var_04, 0.05, 0.05);
}

get_move_rate(param_00, param_01, param_02, param_03) {
  var_04 = distance(param_01, param_02);
  var_05 = var_04 / param_03;
  if(var_05 < 0.05) {
    var_05 = 0.05;
  }

  return var_05;
}