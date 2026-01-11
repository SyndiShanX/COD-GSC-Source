/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_dog_kinect.gsc
*****************************************************/

enable_dog_kinect() {
  if(level.script == "enemyhq") {
    speechenablegrammar("speech/iw6/grammars/en-us_rileyenemyhq.cfg", 1);
  } else if(level.script == "nml") {
    speechenablegrammar("speech/iw6/grammars/en-us_rileynml.cfg", 1);
  }

  speechenable(1);
  setdvar("show_riley_commands", 0);
}

disable_dog_kinect() {
  speechenable(0);

  if(level.script == "enemyhq") {
    speechenablegrammar("speech/iw6/grammars/en-us_rileyenemyhq.cfg", 0);
  } else if(level.script == "nml") {
    speechenablegrammar("speech/iw6/grammars/en-us_rileynml.cfg", 0);
  }
}

speechcommands() {
  enable_dog_kinect();
  level.player thread listen_for_dog_kinect_commands(level.dog);
}

listen_for_dog_kinect_commands(var_0) {
  self endon("death");
  var_0 endon("death");

  for(;;) {
    level.player waittill("speechCommand", var_1, var_2);

    if(getdvarint("show_riley_commands") == 1) {
      iprintlnbold("speechCommand: " + var_2 + " at " + var_1 + " confidence.");
    }

    var_3 = 0.3;
    var_4 = 0.7;

    switch (var_2) {
      case "attack":
        if(var_1 > var_3) {
          if(isDefined(var_0.controlling_dog) && var_0 maps\_utility::ent_flag("pause_dog_command")) {
            level.player notify("attack_command");
          } else {
            level.player notify("fired_laser");
          }
        }

        break;
      case "cancel":
        if(var_1 > var_3) {
          var_0 notify("cancel_dog_attack");
        }

        break;
      case "bark":
        if(var_1 > var_4) {
          if(isDefined(var_0.controlling_dog)) {
            level.player notify("LISTEN_ads_button_pressed");
          }
        }

        break;
      case "platform":
        if(var_1 > var_3) {
          var_5 = ["platform", "ramp", "walkway", "catwalk"];

          foreach(var_7 in var_5) {
            var_8 = findlocation(var_7);

            if(isDefined(var_8)) {
              laser_designate_target_kinect(var_8);
              break;
            }
          }
        }

        break;
      case "cart":
        if(var_1 > var_3) {
          var_10 = ["cart", "counter", "stand", "conession", "concession"];

          foreach(var_12 in var_10) {
            var_8 = findlocation(var_12);

            if(isDefined(var_8)) {
              laser_designate_target_kinect(var_8);
              break;
            }
          }
        }

        break;
      case "vehicle":
        if(var_1 > var_3) {
          var_14 = ["car", "van", "bus"];

          foreach(var_16 in var_14) {
            var_8 = findlocation(var_16);

            if(isDefined(var_8)) {
              laser_designate_target_kinect(var_8);
              break;
            }
          }
        }

        break;
      case "debris":
        if(var_1 > var_3) {
          var_18 = ["debris", "rubble"];

          foreach(var_20 in var_18) {
            var_8 = findlocation(var_20);

            if(isDefined(var_8)) {
              laser_designate_target_kinect(var_8);
              break;
            }
          }
        }

        break;
      default:
        if(var_1 > var_3) {
          var_8 = findlocation(var_2);

          if(isDefined(var_8)) {
            laser_designate_target_kinect(var_8);
          }
        }

        break;
    }
  }
}

findlocation(var_0) {
  var_1 = anim.bcs_locations;

  foreach(var_3 in var_1) {
    if(isDefined(var_3.locationaliases)) {
      foreach(var_5 in var_3.locationaliases) {
        if(issubstr(var_5, var_0)) {
          return var_5;
        }
      }
    }
  }

  return undefined;
}

laser_designate_target_kinect(var_0) {
  var_1 = [];
  var_2 = getaiarray("axis");

  foreach(var_4 in var_2) {
    if(var_4.type == "dog") {
      continue;
    }
    var_5 = var_4 gettagorigin("J_SpineUpper");

    if(maps\_utility::player_looking_at(var_5, 0.8, 1)) {
      var_6 = var_4 animscripts\battlechatter::get_all_my_locations();

      foreach(var_8 in var_6) {
        var_9 = var_8.locationaliases;

        foreach(var_11 in var_9) {
          if(var_11 == var_0) {
            var_1 = common_scripts\utility::array_add(var_1, var_4);
            break;
          }
        }
      }
    }
  }

  var_15 = maps\_dog_control::get_eye();

  if(var_1.size > 0) {
    var_1 = sortbydistance(var_1, var_15);

    foreach(var_4 in var_1) {
      if(!isDefined(var_4.a.doinglongdeath)) {
        var_17 = maps\_dog_control::get_laser_designated_trace();
        self notify("issue_dog_command", var_17, undefined, var_4);
        return;
      }
    }
  }
}