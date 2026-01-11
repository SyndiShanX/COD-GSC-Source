/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\ship_graveyard_audio.gsc
*****************************************/

main() {
  level.player setclienttriggeraudiozone("ship_graveyard_intro_black", 0.1);
  thread start_overhead_waves();
}

start_overhead_waves() {
  common_scripts\utility::waitframe();
  common_scripts\utility::flag_wait("start_swim");
  level.player clearclienttriggeraudiozone(0.8);
  level.panfront = 1;
  self endon("stop_waves");
  wait 0.5;

  for(;;) {
    thread start_individual_wave();

    if(level.panfront == 1) {
      level.panfront = 0;
    }
    else {
      level.panfront = 1;
    }

    wait 6;
  }
}

start_individual_wave() {
  if(level.panfront == 1) {
    var_0 = randomintrange(350, 550);
  }
  else {
    var_0 = randomintrange(-600, -500);
  }

  var_1 = spawn("script_origin", level.player.origin + (800, var_0, level.water_level_z - level.player.origin[2]));
  var_1 playSound("elm_waves_pass_by");
  var_1 moveto(var_1.origin + (-1600, 650, 0), 13);
  wait 21;
  var_1 stopsounds();
  var_1 delete();
}

stop_overhead_waves() {
  level notify("stop_waves");
}