/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\art.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace art;

function main() {
  setdevdvarifuninitialized(@ "scr_art_tweak", 0);
  thread tweakart();
  tess_init();

  if(!isDefined(level.script)) {
    level.script = tolower(getDvar(@ "g_mapname"));
  }
}

function inittweaks() {
  setdevdvar(@ "hash_4296464306ab31a8", 1);

  if(!isDefined(level.buttons)) {
    level.buttons = [];
  }

  level._clearalltextafterhudelem = 0;
  iprintlnbold("<dev string:x1c>");
  hud_init();
}

function tweakart() {
  if(!isDefined(level.tweakfile)) {
    level.tweakfile = 0;
  }

  setdevdvar(@ "scr_fog_fraction", "<dev string:x31>");
  setdevdvar(@ "scr_art_dump", "<dev string:x38>");
  printed = 0;

  for(;;) {
    while(getdvarint(@ "scr_art_tweak", 0) == 0) {
      wait 0.05;
    }

    if(!printed) {
      printed = 1;
      inittweaks();
    }

    dumpsettings();
    wait 0.05;
  }
}

function tess_init() {
  var_75e889a96a1e1e5 = getDvar(@ "hash_3914a6109ddfa630");

  if(var_75e889a96a1e1e5 == "<dev string:x3d>") {
    return;
  }

  level.tess = spawnStruct();
  level.tess.cutoff_distance_current = 635;
  level.tess.cutoff_distance_goal = level.tess.cutoff_distance_current;
  level.tess.cutoff_falloff_current = 587;
  level.tess.cutoff_falloff_goal = level.tess.cutoff_falloff_current;
  level.tess.time_remaining = 0;
  setDvar(@ "hash_24a1cc28fae4c8e2", level.tess.cutoff_distance_current);
  setDvar(@ "hash_d786b6ac5e30f145", level.tess.cutoff_falloff_current);
  thread tess_update();
}

function tess_set_goal(var_92ad28aede5bf05e, cutoff_falloff, blend_time) {
  level.tess.cutoff_distance_goal = var_92ad28aede5bf05e;
  level.tess.cutoff_falloff_goal = cutoff_falloff;
  level.tess.time_remaining = blend_time;
}

function tess_update() {
  while(true) {
    var_8e82e2ee78f6c824 = level.tess.cutoff_distance_current;
    var_7d417327139f9f5f = level.tess.cutoff_falloff_current;
    waitframe();

    if(level.tess.time_remaining > 0) {
      frames = level.tess.time_remaining * 20;
      distance_increment = (level.tess.cutoff_distance_goal - level.tess.cutoff_distance_current) / frames;
      var_f18ef0f6f6349b6b = (level.tess.cutoff_falloff_goal - level.tess.cutoff_falloff_current) / frames;
      level.tess.cutoff_distance_current += distance_increment;
      level.tess.cutoff_falloff_current += var_f18ef0f6f6349b6b;
      level.tess.time_remaining -= level.framedurationseconds;
    } else {
      level.tess.cutoff_distance_current = level.tess.cutoff_distance_goal;
      level.tess.cutoff_falloff_current = level.tess.cutoff_falloff_goal;
    }

    if(var_8e82e2ee78f6c824 != level.tess.cutoff_distance_current) {
      setDvar(@ "hash_24a1cc28fae4c8e2", level.tess.cutoff_distance_current);
    }

    if(var_7d417327139f9f5f != level.tess.cutoff_falloff_current) {
      setDvar(@ "hash_d786b6ac5e30f145", level.tess.cutoff_falloff_current);
    }
  }
}

function dumpsettings() {
  if(getdvarint(@ "scr_art_dump") == 0) {
    return 0;
  }

  setdevdvar(@ "scr_art_dump", "<dev string:x38>");
  fileprint_launcher_start_file();
  fileprint_launcher( "<dev string:x41>" );
  fileprint_launcher( "<dev string:x97>" );
  fileprint_launcher( "<dev string:xa1>" );
  fileprint_launcher( "<dev string:xa6>" );
  fileprint_launcher( "<dev string:xc2>" );

  if(! fileprint_launcher_end_file( "<dev string:xc7>" + level.script + "<dev string:xea>", 1 ) )
    {
      return;
    }

    iprintlnbold("<dev string:xf6>"); println("<dev string:x10a>");
  }

  function button_down(btn, btn2) {
    pressed = level.players[0] buttonPressed(btn);

    if(!pressed) {
      pressed = level.players[0] buttonPressed(btn2);
    }

    if(!isDefined(level.buttons[btn])) {
      level.buttons[btn] = 0;
    }

    if(gettime() < level.buttons[btn]) {
      return 0;
    }

    level.buttons[btn] = gettime() + 400;
    return pressed;
  }

  function hud_init() {
    listsize = 7;
    hudelems = [];
    spacer = 15;
    div = int(listsize / 2);
    org = 240 - div * spacer;
    alphainc = 0.5 / div;
    alpha = alphainc;

    for(i = 0; i < listsize; i++) {
      hudelems[i] = _newhudelem();
      hudelems[i].location = 0;
      hudelems[i].alignx = "<dev string:x12a>";
      hudelems[i].aligny = "<dev string:x132>";
      hudelems[i].foreground = 1;
      hudelems[i].fontscale = 2;
      hudelems[i].sort = 20;

      if(i == div) {
        hudelems[i].alpha = 1;
      } else {
        hudelems[i].alpha = alpha;
      }

      hudelems[i].x = 20;
      hudelems[i].y = org;
      hudelems[i] _settext("<dev string:x13c>");

      if(i == div) {
        alphainc *= -1;
      }

      alpha += alphainc;
      org += spacer;
    }

    level.spam_group_hudelems = hudelems;
  }

  function _newhudelem() {
    if(!isDefined(level.scripted_elems)) {
      level.scripted_elems = [];
    }

    elem = newhudelem();
    level.scripted_elems[level.scripted_elems.size] = elem;
    return elem;
  }

  function _settext(text) {
    self.realtext = text;
    self setdevtext("<dev string:x141>");
    thread _clearalltextafterhudelem();
    var_bff8d89bfd98e29f = 0;

    foreach(elem in level.scripted_elems) {
      if(isDefined(elem.realtext)) {
        var_bff8d89bfd98e29f += elem.realtext.size;
        elem setdevtext(elem.realtext);
      }
    }

    println("<dev string:x146>" + var_bff8d89bfd98e29f);
  }

  function _clearalltextafterhudelem() {
    if(level._clearalltextafterhudelem) {
      return;
    }

    level._clearalltextafterhudelem = 1;
    self clearalltextafterhudelem();
    wait 0.05;
    level._clearalltextafterhudelem = 0;
  }

  function function_67bc9d1f5c5c787c() {
    setdevdvar(@ "hash_de86d29dde73df", 0);
    setdevdvar(@ "hash_cc21f65bade3fb07", 0);
  }

  # /