/**************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\zombies\zm_comics_pages.gsc
**************************************************/

init() {
  level load_comics_pages();
}

load_comics_pages() {
  level.comics_pages = [];
  var_0 = tablelookupgetnumrows("cp/zombies/zm_comics_pages.csv");

  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = tablelookupbyrow("cp/zombies/zm_comics_pages.csv", var_1, 0);

    if(var_2 == "") {
      continue;
    }
    if(!_func_0107(level.comics_pages[var_2])) {
      level.comics_pages[var_2] = [];
    }

    var_3 = int(tablelookupbyrow("cp/zombies/zm_comics_pages.csv", var_1, 1));
    var_4 = float(tablelookupbyrow("cp/zombies/zm_comics_pages.csv", var_1, 3));
    var_5 = strtok(tablelookupbyrow("cp/zombies/zm_comics_pages.csv", var_1, 4), " ");
    level.comics_pages[var_2][var_3] = spawnStruct();
    level.comics_pages[var_2][var_3].display_time = var_4;
    level.comics_pages[var_2][var_3].narrations = var_5;
  }
}

play_page_narrations(var_0) {
  level endon("game_ended");

  if(!_func_0107(var_0) || var_0.size == 0) {
    return;
  }
  level _id_0720::play_narrations(var_0);
}

fade_to_white(var_0) {
  level endon("game_ended");
  var_1 = newclienthudelem(self);
  var_1 setshader("white", 640, 480);
  var_1.sort = 1;
  var_1.horzalign = "fullscreen";
  var_1.vertalign = "fullscreen";
  var_1._id_01D6 = 1;
  var_1.alpha = 0.0;
  var_1 fadeovertime(var_0);
  var_1.alpha = 1.0;
  wait(var_0);
  level waittill("page_sequence_done");
  var_1 fadeovertime(var_0);
  var_1.alpha = 0.0;
  wait(var_0);
  var_1 destroy();
}

play_page_sequence(var_0) {
  level endon("game_ended");
  var_1 = level.comics_pages[var_0];

  if(!isDefined(var_1)) {
    return;
  }
  foreach(var_3 in scripts\cp\utility::_id_6C5C()) {
    if(!isPlayer(var_3)) {
      continue;
    }
    var_3 thread fade_to_white(0.5);

    if(!isalive(var_3)) {
      continue;
    }
    var_3 freezecontrols(1);
  }

  wait 0.5;
  setomnvar("ui_zm_comics_title", var_0);

  foreach(var_7, var_6 in var_1) {
    setomnvar("ui_zm_comics_page", var_7);
    wait 0.3;

    if(var_6.display_time > 0) {
      level thread play_page_narrations(var_6.narrations);
      wait(var_6.display_time);
      continue;
    }

    level play_page_narrations(var_6.narrations);
  }

  setomnvar("ui_zm_comics_page", -1);
  setomnvar("ui_zm_comics_title", "none");
  level notify("page_sequence_done");
  wait 0.5;

  foreach(var_3 in scripts\cp\utility::_id_6C5C()) {
    if(!isalive(var_3)) {
      continue;
    }
    var_3 freezecontrols(0);
  }
}