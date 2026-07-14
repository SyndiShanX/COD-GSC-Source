/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\art.gsc
**************************************/

#using scripts\common\vehicle;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace art;

function main() {
  setdevdvarifuninitialized(@ "scr_art_tweak", 0);
  setsaveddvar(@ "r_artusetweaks", 0);

  if(!isDefined(level.level_specific_dof)) {
    level.level_specific_dof = 0;
  }

  level._clearalltextafterhudelem = 0;
  dof_init();
  tess_init();
  mb_init();
  level.special_weapon_dof_funcs = [];
  level.buttons = [];
  setsaveddvar(@ "hash_9e7bc885a6c0ab17", 1);

  thread tweakart();

  if(!isDefined(level.script)) {
    level.script = tolower(getDvar(@ "g_mapname"));
  }
}

function tweakart() {
  if(!isDefined(level.tweakfile)) {
    level.tweakfile = 0;
  }

  setDvar(@ "scr_fog_fraction", "<dev string:x24>");
  setDvar(@ "scr_art_dump", "<dev string:x2b>");
  setDvar(@ "scr_dof_nearstart", level.dof["<dev string:x30>"]["<dev string:x38>"]["<dev string:x43>"]);
  setDvar(@ "scr_dof_nearend", level.dof["<dev string:x30>"]["<dev string:x38>"]["<dev string:x50>"]);
  setDvar(@ "scr_dof_farstart", level.dof["<dev string:x30>"]["<dev string:x38>"]["<dev string:x5b>"]);
  setDvar(@ "scr_dof_farend", level.dof["<dev string:x30>"]["<dev string:x38>"]["<dev string:x67>"]);
  setDvar(@ "scr_dof_nearblur", level.dof["<dev string:x30>"]["<dev string:x38>"]["<dev string:x71>"]);
  setDvar(@ "scr_dof_farblur", level.dof["<dev string:x30>"]["<dev string:x38>"]["<dev string:x7d>"]);
  level.fogfraction = 1;
  file = undefined;
  function_7a597d912717c9d7();
  printed = 0;

  for(;;) {
    while(getdvarint(@ "scr_art_tweak") == 0) {
      wait 0.05;
    }

    setsaveddvar(@ "r_artusetweaks", 1);

    if(!printed) {
      printed = 1;
      setDvar(@ "loc_warnings", 0);
      iprintlnbold("<dev string:x88>");
      hud_init();
    }

    function_7a597d912717c9d7();
    function_ff750d008942ecb4();
    dump = dumpsettings();
    wait 0.05;
  }
}

function function_7a597d912717c9d7() {
  nearstart = getdvarint(@ "scr_dof_nearstart");
  nearend = getdvarint(@ "scr_dof_nearend");
  nearblur = getdvarfloat(@ "scr_dof_nearblur");
  farstart = getdvarint(@ "scr_dof_farstart");
  farend = getdvarint(@ "scr_dof_farend");
  farblur = getdvarfloat(@ "scr_dof_farblur");

  foreach(player in level.players) {
    player setdepthoffield(nearstart, nearend, farstart, farend, nearblur, farblur);
  }
}

function button_down(btn, btn2) {
  pressed = level.player buttonPressed(btn);

  if(!pressed) {
    pressed = level.player buttonPressed(btn2);
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

function function_ff750d008942ecb4() {
  nearstart = getdvarint(@ "scr_dof_nearstart");
  nearend = getdvarint(@ "scr_dof_nearend");
  nearblur = getdvarfloat(@ "scr_dof_nearblur");
  farstart = getdvarint(@ "scr_dof_farstart");
  farend = getdvarint(@ "scr_dof_farend");
  farblur = getdvarfloat(@ "scr_dof_farblur");

  if(nearstart >= nearend) {
    nearstart = nearend - 1;
    setDvar(@ "scr_dof_nearstart", nearstart);
  }

  if(nearend <= nearstart) {
    nearend = nearstart + 1;
    setDvar(@ "scr_dof_nearend", nearend);
  }

  if(farstart >= farend) {
    farstart = farend - 1;
    setDvar(@ "scr_dof_farstart", farstart);
  }

  if(farend <= farstart) {
    farend = farstart + 1;
    setDvar(@ "scr_dof_farend", farend);
  }

  if(farblur >= nearblur) {
    farblur = nearblur - 0.1;
    setDvar(@ "scr_dof_farblur", farblur);
  }

  if(farstart <= nearend) {
    farstart = nearend + 1;
    setDvar(@ "scr_dof_farstart", farstart);
  }
}

function dumpsettings() {
  if(getDvar(@ "scr_art_dump") == "<dev string:x2b>") {
    return;
  }

  dump_art = getDvar(@ "scr_art_dump") != "<dev string:x2b>";
  setDvar(@ "scr_art_dump", "<dev string:x2b>");
  utility:: fileprint_launcher_start_file();
    utility:: fileprint_launcher( "<dev string:x9d>" );
    utility:: fileprint_launcher( "<dev string:xf2>" );
    utility:: fileprint_launcher( "<dev string:xfc>" );
    utility:: fileprint_launcher( "<dev string:x101>" );
    utility:: fileprint_launcher( "<dev string:x105>" );
    utility:: fileprint_launcher( "<dev string:x121>" );
    utility:: fileprint_launcher( "<dev string:x101>" );
    utility:: fileprint_launcher( "<dev string:x15e>" );

    if(!utility:: fileprint_launcher_end_file( "<dev string:x163>" + level.script + "<dev string:x182>" + level.script + "<dev string:x18b>", 1 ) )
      {
        return;
      }

      iprintlnbold("<dev string:x197>"); println("<dev string:x1ab>"); addstring = "<dev string:x1cb>" + level.script + "<dev string:x1e4>"; assert(level.tweakfile, "<dev string:x1f5>" + level.script + "<dev string:x213>" + addstring + "<dev string:x235>" + level.script + "<dev string:x250>" + level.script + "<dev string:x263>");
    }

  function dof_set_generic(layername, subsetname, nearstart, nearend, nearblur, farstart, farend, farblur, weight) {
    level.dof[layername][subsetname]["\xe6\x95a\xe4\xa9\x1d\x85\x9c\xd1"] = nearstart;
    level.dof[layername][subsetname]["ob\x14J\x84\x02\x9d"] = nearend;
    level.dof[layername][subsetname]["9\x90\xb5\xe7u\tV\xd4"] = nearblur;
    level.dof[layername][subsetname]["3X\x9c\xa6\xd1a\xe4\xa3"] = farstart;
    level.dof[layername][subsetname][":\x80A!tU"] = farend;
    level.dof[layername][subsetname]["\xd4\x12\x1b\x8d\x1a\v\xb8"] = farblur;
    level.dof[layername][subsetname]["\x1f\xc5\x04\xeb\xec\xb6"] = weight;
  }

  function dof_blend_interior_generic(layername) {
    if(level.dof[layername]["|\x91\r!5\xfe\xdfm\xc1\x8f\xa7\x9c\xfd"] <= 0) {
      return;
    }

    lerpfrac = min(1, 0.05 / level.dof[layername]["|\x91\r!5\xfe\xdfm\xc1\x8f\xa7\x9c\xfd"]);
    level.dof[layername]["|\x91\r!5\xfe\xdfm\xc1\x8f\xa7\x9c\xfd"] = level.dof[layername]["|\x91\r!5\xfe\xdfm\xc1\x8f\xa7\x9c\xfd"] - 0.05;

    if(level.dof[layername]["|\x91\r!5\xfe\xdfm\xc1\x8f\xa7\x9c\xfd"] <= 0) {
      level.dof[layername]["|\x91\r!5\xfe\xdfm\xc1\x8f\xa7\x9c\xfd"] = 0;
      level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"]["\xe6\x95a\xe4\xa9\x1d\x85\x9c\xd1"] = level.dof[layername]["\x83\xd6\xaf\x11"]["\xe6\x95a\xe4\xa9\x1d\x85\x9c\xd1"];
      level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"]["ob\x14J\x84\x02\x9d"] = level.dof[layername]["\x83\xd6\xaf\x11"]["ob\x14J\x84\x02\x9d"];
      level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"]["9\x90\xb5\xe7u\tV\xd4"] = level.dof[layername]["\x83\xd6\xaf\x11"]["9\x90\xb5\xe7u\tV\xd4"];
      level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"]["3X\x9c\xa6\xd1a\xe4\xa3"] = level.dof[layername]["\x83\xd6\xaf\x11"]["3X\x9c\xa6\xd1a\xe4\xa3"];
      level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"][":\x80A!tU"] = level.dof[layername]["\x83\xd6\xaf\x11"][":\x80A!tU"];
      level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"]["\xd4\x12\x1b\x8d\x1a\v\xb8"] = level.dof[layername]["\x83\xd6\xaf\x11"]["\xd4\x12\x1b\x8d\x1a\v\xb8"];
      level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"]["\x1f\xc5\x04\xeb\xec\xb6"] = level.dof[layername]["\x83\xd6\xaf\x11"]["\x1f\xc5\x04\xeb\xec\xb6"];
      return;
    }

    level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"]["\xe6\x95a\xe4\xa9\x1d\x85\x9c\xd1"] = level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"]["\xe6\x95a\xe4\xa9\x1d\x85\x9c\xd1"] + lerpfrac * (level.dof[layername]["\x83\xd6\xaf\x11"]["\xe6\x95a\xe4\xa9\x1d\x85\x9c\xd1"] - level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"]["\xe6\x95a\xe4\xa9\x1d\x85\x9c\xd1"]);
    level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"]["ob\x14J\x84\x02\x9d"] = level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"]["ob\x14J\x84\x02\x9d"] + lerpfrac * (level.dof[layername]["\x83\xd6\xaf\x11"]["ob\x14J\x84\x02\x9d"] - level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"]["ob\x14J\x84\x02\x9d"]);
    level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"]["9\x90\xb5\xe7u\tV\xd4"] = level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"]["9\x90\xb5\xe7u\tV\xd4"] + lerpfrac * (level.dof[layername]["\x83\xd6\xaf\x11"]["9\x90\xb5\xe7u\tV\xd4"] - level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"]["9\x90\xb5\xe7u\tV\xd4"]);
    level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"]["3X\x9c\xa6\xd1a\xe4\xa3"] = level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"]["3X\x9c\xa6\xd1a\xe4\xa3"] + lerpfrac * (level.dof[layername]["\x83\xd6\xaf\x11"]["3X\x9c\xa6\xd1a\xe4\xa3"] - level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"]["3X\x9c\xa6\xd1a\xe4\xa3"]);
    level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"][":\x80A!tU"] = level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"][":\x80A!tU"] + lerpfrac * (level.dof[layername]["\x83\xd6\xaf\x11"][":\x80A!tU"] - level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"][":\x80A!tU"]);
    level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"]["\xd4\x12\x1b\x8d\x1a\v\xb8"] = level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"]["\xd4\x12\x1b\x8d\x1a\v\xb8"] + lerpfrac * (level.dof[layername]["\x83\xd6\xaf\x11"]["\xd4\x12\x1b\x8d\x1a\v\xb8"] - level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"]["\xd4\x12\x1b\x8d\x1a\v\xb8"]);
    level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"]["\x1f\xc5\x04\xeb\xec\xb6"] = level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"]["\x1f\xc5\x04\xeb\xec\xb6"] + lerpfrac * (level.dof[layername]["\x83\xd6\xaf\x11"]["\x1f\xc5\x04\xeb\xec\xb6"] - level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"]["\x1f\xc5\x04\xeb\xec\xb6"]);
  }

  function mb_init() {
    if(!isplatformmobile()) {
      setsaveddvar(@ "r_mbenable", 1);
      utility_sp::create_motion_blur_defaults(1, 1);
      utility_sp::motion_blur_enable();
    }
  }

  function dof_default(layername, subsetname) {
    nearstart = 1;
    nearend = 1;
    nearblur = 4.5;
    farstart = 500;
    farend = 500;
    farblur = 0.05;
    dof_set_generic(layername, subsetname, nearstart, nearend, nearblur, farstart, farend, farblur, 1);
  }

  function dof_init() {
    if(getDvar(@ "hash_1b022342555479ae") == "") {
      setsaveddvar(@ "hash_1b022342555479ae", "\x87");
    }

    setDvar(@ "hash_16d3b68a571cd9cc", 4096);
    setDvar(@ "hash_f920da78c320d7c9", 10000);
    setDvar(@ "hash_46a24e55882202b4", 5000);
    setDvar(@ "hash_70ad5c8b5390da5b", 0.25);
    setDvar(@ "hash_cb3ccd57ba94fab4", 0.85);
    setDvar(@ "hash_8260157d7099d0a", 1.15);
    setDvar(@ "hash_3eedd8d68a0e7cad", 3);
    setDvar(@ "hash_46ecedfd7e9e40a4", 4);
    setDvar(@ "hash_ad993fc2da2f7edd", 4);
    setDvar(@ "hash_a3478a0be5d0bcae", 0);
    level.dof = [];
    level.dof["z\xd4mN"] = [];
    level.dof["z\xd4mN"]["\x96\x99\x05\x0en\x80\xc0"] = [];
    level.dof["z\xd4mN"]["\x83\xd6\xaf\x11"] = [];
    level.dof["z\xd4mN"]["|\x91\r!5\xfe\xdfm\xc1\x8f\xa7\x9c\xfd"] = 0;
    dof_default("z\xd4mN", "\x96\x99\x05\x0en\x80\xc0");
    dof_set_generic("z\xd4mN", "\x83\xd6\xaf\x11", 0, 0, 0, 0, 0, 0, 0);
    level.dof["\xcc5N\xf8\xa1\xa6"] = [];
    level.dof["\xcc5N\xf8\xa1\xa6"]["\x96\x99\x05\x0en\x80\xc0"] = [];
    level.dof["\xcc5N\xf8\xa1\xa6"]["\x83\xd6\xaf\x11"] = [];
    level.dof["\xcc5N\xf8\xa1\xa6"]["|\x91\r!5\xfe\xdfm\xc1\x8f\xa7\x9c\xfd"] = 0;
    dof_set_generic("\xcc5N\xf8\xa1\xa6", "\x96\x99\x05\x0en\x80\xc0", 0, 0, 0, 0, 0, 0, 0);
    dof_set_generic("\xcc5N\xf8\xa1\xa6", "\x83\xd6\xaf\x11", 0, 0, 0, 0, 0, 0, 0);
    level.dof["\xe4\xf1G"] = [];
    level.dof["\xe4\xf1G"]["\x96\x99\x05\x0en\x80\xc0"] = [];
    level.dof["\xe4\xf1G"]["\x83\xd6\xaf\x11"] = [];
    dof_set_generic("\xe4\xf1G", "\x96\x99\x05\x0en\x80\xc0", 0, 0, 0, 0, 0, 0, 0);
    dof_set_generic("\xe4\xf1G", "\x83\xd6\xaf\x11", 0, 0, 0, 0, 0, 0, 0);
    level.dof["v\xe5\x16h\x92\x87\xa3"] = [];
    level.dof["v\xe5\x16h\x92\x87\xa3"]["\x96\x99\x05\x0en\x80\xc0"] = [];
    dof_default("v\xe5\x16h\x92\x87\xa3", "\x96\x99\x05\x0en\x80\xc0");

    foreach(player in level.players) {
      player thread dof_update();
    }
  }

  function dof_set_base(nearstart, nearend, nearblur, farstart, farend, farblur, blend_time) {
    dof_set_generic("z\xd4mN", "\x83\xd6\xaf\x11", nearstart, nearend, nearblur, farstart, farend, farblur, 1);
    level.dof["z\xd4mN"]["|\x91\r!5\xfe\xdfm\xc1\x8f\xa7\x9c\xfd"] = blend_time;

    if(blend_time <= 0) {
      dof_set_generic("z\xd4mN", "\x96\x99\x05\x0en\x80\xc0", nearstart, nearend, nearblur, farstart, farend, farblur, 1);
    }
  }

  function dof_enable_script(nearstart, nearend, nearblur, farstart, farend, farblur, blend_time) {
    dof_set_generic("\xcc5N\xf8\xa1\xa6", "\x83\xd6\xaf\x11", nearstart, nearend, nearblur, farstart, farend, farblur, 1);
    level.dof["\xcc5N\xf8\xa1\xa6"]["|\x91\r!5\xfe\xdfm\xc1\x8f\xa7\x9c\xfd"] = blend_time;

    if(blend_time <= 0) {
      dof_set_generic("\xcc5N\xf8\xa1\xa6", "\x96\x99\x05\x0en\x80\xc0", nearstart, nearend, nearblur, farstart, farend, farblur, 1);
      return;
    }

    if(level.dof["\xcc5N\xf8\xa1\xa6"]["\x96\x99\x05\x0en\x80\xc0"]["\x1f\xc5\x04\xeb\xec\xb6"] <= 0) {
      dof_set_generic("\xcc5N\xf8\xa1\xa6", "\x96\x99\x05\x0en\x80\xc0", nearstart, nearend, nearblur, farstart, farend, farblur, 0);
    }
  }

  function dof_disable_script(blend_time) {
    level.dof["\xcc5N\xf8\xa1\xa6"]["\x83\xd6\xaf\x11"]["\x1f\xc5\x04\xeb\xec\xb6"] = 0;
    level.dof["\xcc5N\xf8\xa1\xa6"]["|\x91\r!5\xfe\xdfm\xc1\x8f\xa7\x9c\xfd"] = blend_time;

    if(blend_time <= 0) {
      level.dof["\xcc5N\xf8\xa1\xa6"]["\x96\x99\x05\x0en\x80\xc0"]["\x1f\xc5\x04\xeb\xec\xb6"] = 0;
    }
  }

  function is_dof_script_enabled() {
    return level.dof["\xcc5N\xf8\xa1\xa6"]["\x96\x99\x05\x0en\x80\xc0"]["\x1f\xc5\x04\xeb\xec\xb6"] > 0;
  }

  function dof_enable_ads(nearstart, nearend, nearblur, farstart, farend, farblur, adsfrac) {
    dof_set_generic("\xe4\xf1G", "\x83\xd6\xaf\x11", nearstart, nearend, nearblur, farstart, farend, farblur, adsfrac);

    if(level.dof["\xe4\xf1G"]["\x96\x99\x05\x0en\x80\xc0"]["\x1f\xc5\x04\xeb\xec\xb6"] <= 0) {
      dof_set_generic("\xe4\xf1G", "\x96\x99\x05\x0en\x80\xc0", nearstart, nearend, nearblur, farstart, farend, farblur, 0);
    }
  }

  function dof_blend_interior_ads_element(currentvalue, targetvalue, maxchange, changerate) {
    if(currentvalue > targetvalue) {
      changeval = (currentvalue - targetvalue) * changerate;

      if(changeval > maxchange) {
        changeval = maxchange;
      } else if(changeval < 1) {
        changeval = 1;
      }

      if(currentvalue - changeval <= targetvalue) {
        return targetvalue;
      } else {
        return (currentvalue - changeval);
      }
    } else if(currentvalue < targetvalue) {
      changeval = (targetvalue - currentvalue) * changerate;

      if(changeval > maxchange) {
        changeval = maxchange;
      } else if(changeval < 1) {
        changeval = 1;
      }

      if(currentvalue + changeval >= targetvalue) {
        return targetvalue;
      } else {
        return (currentvalue + changeval);
      }
    }

    return currentvalue;
  }

  function dof_blend_interior_ads() {
    assert(isPlayer(self));
    adsfrac = level.dof["\xe4\xf1G"]["\x83\xd6\xaf\x11"]["\x1f\xc5\x04\xeb\xec\xb6"];

    if(adsfrac < 1) {
      if(self adsButtonPressed() && self playerads() > 0) {
        adsfrac = min(1, adsfrac + 0.7);
      } else {
        adsfrac = 0;
      }

      level.dof["\xe4\xf1G"]["\x96\x99\x05\x0en\x80\xc0"]["\xe6\x95a\xe4\xa9\x1d\x85\x9c\xd1"] = level.dof["\xe4\xf1G"]["\x83\xd6\xaf\x11"]["\xe6\x95a\xe4\xa9\x1d\x85\x9c\xd1"];
      level.dof["\xe4\xf1G"]["\x96\x99\x05\x0en\x80\xc0"]["ob\x14J\x84\x02\x9d"] = level.dof["\xe4\xf1G"]["\x83\xd6\xaf\x11"]["ob\x14J\x84\x02\x9d"];
      level.dof["\xe4\xf1G"]["\x96\x99\x05\x0en\x80\xc0"]["9\x90\xb5\xe7u\tV\xd4"] = level.dof["\xe4\xf1G"]["\x83\xd6\xaf\x11"]["9\x90\xb5\xe7u\tV\xd4"];
      level.dof["\xe4\xf1G"]["\x96\x99\x05\x0en\x80\xc0"]["3X\x9c\xa6\xd1a\xe4\xa3"] = level.dof["\xe4\xf1G"]["\x83\xd6\xaf\x11"]["3X\x9c\xa6\xd1a\xe4\xa3"];
      level.dof["\xe4\xf1G"]["\x96\x99\x05\x0en\x80\xc0"][":\x80A!tU"] = level.dof["\xe4\xf1G"]["\x83\xd6\xaf\x11"][":\x80A!tU"];
      level.dof["\xe4\xf1G"]["\x96\x99\x05\x0en\x80\xc0"]["\xd4\x12\x1b\x8d\x1a\v\xb8"] = level.dof["\xe4\xf1G"]["\x83\xd6\xaf\x11"]["\xd4\x12\x1b\x8d\x1a\v\xb8"];
      level.dof["\xe4\xf1G"]["\x96\x99\x05\x0en\x80\xc0"]["\x1f\xc5\x04\xeb\xec\xb6"] = adsfrac;
      return;
    }

    if(isDefined(level.dof_blend_interior_ads_scalar)) {
      var_f3e10eb8b5664a71 = level.dof_blend_interior_ads_scalar;
    } else {
      var_f3e10eb8b5664a71 = 0.1;
    }

    var_4a383fe30cd78b51 = 10;
    nearstartmaxchange = max(var_4a383fe30cd78b51, abs(level.dof["\xe4\xf1G"]["\x96\x99\x05\x0en\x80\xc0"]["\xe6\x95a\xe4\xa9\x1d\x85\x9c\xd1"] - level.dof["\xe4\xf1G"]["\x83\xd6\xaf\x11"]["\xe6\x95a\xe4\xa9\x1d\x85\x9c\xd1"]) * var_f3e10eb8b5664a71);
    nearendmaxchange = max(var_4a383fe30cd78b51, abs(level.dof["\xe4\xf1G"]["\x96\x99\x05\x0en\x80\xc0"]["ob\x14J\x84\x02\x9d"] - level.dof["\xe4\xf1G"]["\x83\xd6\xaf\x11"]["ob\x14J\x84\x02\x9d"]) * var_f3e10eb8b5664a71);
    farstartmaxchange = max(var_4a383fe30cd78b51, abs(level.dof["\xe4\xf1G"]["\x96\x99\x05\x0en\x80\xc0"]["3X\x9c\xa6\xd1a\xe4\xa3"] - level.dof["\xe4\xf1G"]["\x83\xd6\xaf\x11"]["3X\x9c\xa6\xd1a\xe4\xa3"]) * var_f3e10eb8b5664a71);
    farendmaxchange = max(var_4a383fe30cd78b51, abs(level.dof["\xe4\xf1G"]["\x96\x99\x05\x0en\x80\xc0"][":\x80A!tU"] - level.dof["\xe4\xf1G"]["\x83\xd6\xaf\x11"][":\x80A!tU"]) * var_f3e10eb8b5664a71);
    blurmaxchange = 0.1;
    level.dof["\xe4\xf1G"]["\x96\x99\x05\x0en\x80\xc0"]["\xe6\x95a\xe4\xa9\x1d\x85\x9c\xd1"] = dof_blend_interior_ads_element(level.dof["\xe4\xf1G"]["\x96\x99\x05\x0en\x80\xc0"]["\xe6\x95a\xe4\xa9\x1d\x85\x9c\xd1"], level.dof["\xe4\xf1G"]["\x83\xd6\xaf\x11"]["\xe6\x95a\xe4\xa9\x1d\x85\x9c\xd1"], nearstartmaxchange, 0.33);
    level.dof["\xe4\xf1G"]["\x96\x99\x05\x0en\x80\xc0"]["ob\x14J\x84\x02\x9d"] = dof_blend_interior_ads_element(level.dof["\xe4\xf1G"]["\x96\x99\x05\x0en\x80\xc0"]["ob\x14J\x84\x02\x9d"], level.dof["\xe4\xf1G"]["\x83\xd6\xaf\x11"]["ob\x14J\x84\x02\x9d"], nearendmaxchange, 0.33);
    level.dof["\xe4\xf1G"]["\x96\x99\x05\x0en\x80\xc0"]["9\x90\xb5\xe7u\tV\xd4"] = dof_blend_interior_ads_element(level.dof["\xe4\xf1G"]["\x96\x99\x05\x0en\x80\xc0"]["9\x90\xb5\xe7u\tV\xd4"], level.dof["\xe4\xf1G"]["\x83\xd6\xaf\x11"]["9\x90\xb5\xe7u\tV\xd4"], blurmaxchange, 0.33);
    level.dof["\xe4\xf1G"]["\x96\x99\x05\x0en\x80\xc0"]["3X\x9c\xa6\xd1a\xe4\xa3"] = dof_blend_interior_ads_element(level.dof["\xe4\xf1G"]["\x96\x99\x05\x0en\x80\xc0"]["3X\x9c\xa6\xd1a\xe4\xa3"], level.dof["\xe4\xf1G"]["\x83\xd6\xaf\x11"]["3X\x9c\xa6\xd1a\xe4\xa3"], farstartmaxchange, 0.33);
    level.dof["\xe4\xf1G"]["\x96\x99\x05\x0en\x80\xc0"][":\x80A!tU"] = dof_blend_interior_ads_element(level.dof["\xe4\xf1G"]["\x96\x99\x05\x0en\x80\xc0"][":\x80A!tU"], level.dof["\xe4\xf1G"]["\x83\xd6\xaf\x11"][":\x80A!tU"], farendmaxchange, 0.33);
    level.dof["\xe4\xf1G"]["\x96\x99\x05\x0en\x80\xc0"]["\xd4\x12\x1b\x8d\x1a\v\xb8"] = dof_blend_interior_ads_element(level.dof["\xe4\xf1G"]["\x96\x99\x05\x0en\x80\xc0"]["\xd4\x12\x1b\x8d\x1a\v\xb8"], level.dof["\xe4\xf1G"]["\x83\xd6\xaf\x11"]["\xd4\x12\x1b\x8d\x1a\v\xb8"], blurmaxchange, 0.33);
    level.dof["\xe4\xf1G"]["\x96\x99\x05\x0en\x80\xc0"]["\x1f\xc5\x04\xeb\xec\xb6"] = 1;
  }

  function dof_disable_ads() {
    level.dof["\xe4\xf1G"]["\x83\xd6\xaf\x11"]["\x1f\xc5\x04\xeb\xec\xb6"] = 0;
    level.dof["\xe4\xf1G"]["\x96\x99\x05\x0en\x80\xc0"]["\x1f\xc5\x04\xeb\xec\xb6"] = 0;
  }

  function dof_apply_to_results(layername) {
    layer_weight = level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"]["\x1f\xc5\x04\xeb\xec\xb6"];
    inverse_weight = 1 - layer_weight;
    level.dof["v\xe5\x16h\x92\x87\xa3"]["\x96\x99\x05\x0en\x80\xc0"]["\xe6\x95a\xe4\xa9\x1d\x85\x9c\xd1"] = level.dof["v\xe5\x16h\x92\x87\xa3"]["\x96\x99\x05\x0en\x80\xc0"]["\xe6\x95a\xe4\xa9\x1d\x85\x9c\xd1"] * inverse_weight + level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"]["\xe6\x95a\xe4\xa9\x1d\x85\x9c\xd1"] * layer_weight;
    level.dof["v\xe5\x16h\x92\x87\xa3"]["\x96\x99\x05\x0en\x80\xc0"]["ob\x14J\x84\x02\x9d"] = level.dof["v\xe5\x16h\x92\x87\xa3"]["\x96\x99\x05\x0en\x80\xc0"]["ob\x14J\x84\x02\x9d"] * inverse_weight + level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"]["ob\x14J\x84\x02\x9d"] * layer_weight;
    level.dof["v\xe5\x16h\x92\x87\xa3"]["\x96\x99\x05\x0en\x80\xc0"]["9\x90\xb5\xe7u\tV\xd4"] = level.dof["v\xe5\x16h\x92\x87\xa3"]["\x96\x99\x05\x0en\x80\xc0"]["9\x90\xb5\xe7u\tV\xd4"] * inverse_weight + level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"]["9\x90\xb5\xe7u\tV\xd4"] * layer_weight;
    level.dof["v\xe5\x16h\x92\x87\xa3"]["\x96\x99\x05\x0en\x80\xc0"]["3X\x9c\xa6\xd1a\xe4\xa3"] = level.dof["v\xe5\x16h\x92\x87\xa3"]["\x96\x99\x05\x0en\x80\xc0"]["3X\x9c\xa6\xd1a\xe4\xa3"] * inverse_weight + level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"]["3X\x9c\xa6\xd1a\xe4\xa3"] * layer_weight;
    level.dof["v\xe5\x16h\x92\x87\xa3"]["\x96\x99\x05\x0en\x80\xc0"][":\x80A!tU"] = level.dof["v\xe5\x16h\x92\x87\xa3"]["\x96\x99\x05\x0en\x80\xc0"][":\x80A!tU"] * inverse_weight + level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"][":\x80A!tU"] * layer_weight;
    level.dof["v\xe5\x16h\x92\x87\xa3"]["\x96\x99\x05\x0en\x80\xc0"]["\xd4\x12\x1b\x8d\x1a\v\xb8"] = level.dof["v\xe5\x16h\x92\x87\xa3"]["\x96\x99\x05\x0en\x80\xc0"]["\xd4\x12\x1b\x8d\x1a\v\xb8"] * inverse_weight + level.dof[layername]["\x96\x99\x05\x0en\x80\xc0"]["\xd4\x12\x1b\x8d\x1a\v\xb8"] * layer_weight;
  }

  function dof_calc_results() {
    assert(isPlayer(self));
    dof_blend_interior_generic("z\xd4mN");
    dof_blend_interior_generic("\xcc5N\xf8\xa1\xa6");
    dof_blend_interior_ads();
    dof_apply_to_results("z\xd4mN");
    dof_apply_to_results("\xcc5N\xf8\xa1\xa6");
    dof_apply_to_results("\xe4\xf1G");
    nearstart = level.dof["v\xe5\x16h\x92\x87\xa3"]["\x96\x99\x05\x0en\x80\xc0"]["\xe6\x95a\xe4\xa9\x1d\x85\x9c\xd1"];
    nearend = level.dof["v\xe5\x16h\x92\x87\xa3"]["\x96\x99\x05\x0en\x80\xc0"]["ob\x14J\x84\x02\x9d"];
    nearblur = level.dof["v\xe5\x16h\x92\x87\xa3"]["\x96\x99\x05\x0en\x80\xc0"]["9\x90\xb5\xe7u\tV\xd4"];
    farstart = level.dof["v\xe5\x16h\x92\x87\xa3"]["\x96\x99\x05\x0en\x80\xc0"]["3X\x9c\xa6\xd1a\xe4\xa3"];
    farend = level.dof["v\xe5\x16h\x92\x87\xa3"]["\x96\x99\x05\x0en\x80\xc0"][":\x80A!tU"];
    farblur = level.dof["v\xe5\x16h\x92\x87\xa3"]["\x96\x99\x05\x0en\x80\xc0"]["\xd4\x12\x1b\x8d\x1a\v\xb8"];
    nearstart = max(0, nearstart);
    nearend = max(0, nearend);
    farstart = max(0, farstart);
    farend = max(0, farend);
    nearblur = max(4, nearblur);
    nearblur = min(10, nearblur);
    farblur = max(0, farblur);
    farblur = min(nearblur, farblur);

    if(farblur > 0) {
      farstart = max(nearend, farstart);
    }

    level.dof["v\xe5\x16h\x92\x87\xa3"]["\x96\x99\x05\x0en\x80\xc0"]["\xe6\x95a\xe4\xa9\x1d\x85\x9c\xd1"] = nearstart;
    level.dof["v\xe5\x16h\x92\x87\xa3"]["\x96\x99\x05\x0en\x80\xc0"]["ob\x14J\x84\x02\x9d"] = nearend;
    level.dof["v\xe5\x16h\x92\x87\xa3"]["\x96\x99\x05\x0en\x80\xc0"]["9\x90\xb5\xe7u\tV\xd4"] = nearblur;
    level.dof["v\xe5\x16h\x92\x87\xa3"]["\x96\x99\x05\x0en\x80\xc0"]["3X\x9c\xa6\xd1a\xe4\xa3"] = farstart;
    level.dof["v\xe5\x16h\x92\x87\xa3"]["\x96\x99\x05\x0en\x80\xc0"][":\x80A!tU"] = farend;
    level.dof["v\xe5\x16h\x92\x87\xa3"]["\x96\x99\x05\x0en\x80\xc0"]["\xd4\x12\x1b\x8d\x1a\v\xb8"] = farblur;
  }

  function dof_process_ads() {
    assert(isPlayer(self));
    adsfrac = self playerads();

    if(getdvarint(@ "hash_a3478a0be5d0bcae", 0)) {
      adsfrac = 1;
    }

    if(adsfrac <= 0) {
      dof_disable_ads();
      return;
    }

    if(isDefined(level.custom_dof_trace)) {
      [[level.custom_dof_trace]]();
      return;
    }

    tracedist = getdvarfloat(@ "hash_16d3b68a571cd9cc", 4096);
    maxenemydist = getdvarfloat(@ "hash_f920da78c320d7c9", 0);
    var_f3dc3b23367ad267 = getdvarint(@ "hash_46a24e55882202b4", 5000);
    nearstartscale = getdvarfloat(@ "hash_70ad5c8b5390da5b", 0.25);
    nearendscale = getdvarfloat(@ "hash_cb3ccd57ba94fab4", 0.85);
    farstartscale = getdvarfloat(@ "hash_8260157d7099d0a", 1.15);
    farendscale = getdvarfloat(@ "hash_3eedd8d68a0e7cad", 3);
    nearblur = getdvarfloat(@ "hash_46ecedfd7e9e40a4", 4);
    farblur = getdvarfloat(@ "hash_ad993fc2da2f7edd", 8);
    playereye = self getvieworigin();
    playeranglesrel = self getplayerangles();

    if(isDefined(self.dof_ref_ent)) {
      playerangles = combineangles(self.dof_ref_ent.angles, playeranglesrel);
    } else {
      playerangles = playeranglesrel;
    }

    playerforward = vectorNormalize(anglesToForward(playerangles));
    ignorearray = [self];

    if(vehicle::function_e445c44d3e148147()) {
      ignorearray = [self, vehicle::get_vehicle()];
    }

    trace = trace::_bullet_trace(playereye, playereye + playerforward * tracedist, 1, ignorearray, 1, 0, 0, 0, 0);
    enemies = getaiarray("?\xb1\xc0\x9a");
    weapon = self getcurrentweapon();
    weaponname = getcompleteweaponname(weapon);

    if(isDefined(level.special_weapon_dof_funcs[weaponname])) {
      [[level.special_weapon_dof_funcs[weaponname]]](trace, enemies, playereye, playerforward, adsfrac);
      return;
    }

    if(trace["\xda\x16\x81\aw}^i"] == 1) {
      tracedist = 4096;
      nearend = 1024;
      farstart = tracedist * farstartscale * 2;
    } else {
      tracedist = distance(playereye, trace["\xc1\xbd\xdci\xe8i{7"]);
      nearend = tracedist * nearstartscale;
      farstart = tracedist * farstartscale;
    }

    foreach(enemy in enemies) {
      enemyaware = enemy isenemyaware();
      enemyseen = enemy hasenemybeenseen(var_f3dc3b23367ad267);

      if(!enemyaware && !enemyseen) {
        continue;
      }

      enemydir = vectorNormalize(enemy.origin - playereye);
      dot = vectordot(playerforward, enemydir);

      if(dot < 0.923) {
        continue;
      }

      distfrom = distance(playereye, enemy.origin);

      if(distfrom - 30 < nearend) {
        nearend = distfrom - 30;
      }

      distfromfar = min(distfrom, maxenemydist);

      if(distfromfar + 30 > farstart) {
        farstart = distfromfar + 30;
      }
    }

    if(nearend > farstart) {
      nearend = farstart - 256;
    }

    if(nearend > tracedist) {
      nearend = tracedist - 30;
    }

    if(nearend < 1) {
      nearend = 1;
    }

    if(farstart < tracedist) {
      farstart = tracedist;
    }

    nearstart = nearend * nearstartscale;
    farend = farstart * farendscale;
    dof_enable_ads(nearstart, nearend, nearblur, farstart, farend, farblur, adsfrac);
  }

  function setdoftracerange(range) {
    if(!isDefined(range)) {
      range = 4096;
    }

    setDvar(@ "hash_16d3b68a571cd9cc", range);
  }

  function dof_process_physical_ads(adsfrac) {
    if(isDefined(level.custom_dof_trace)) {
      return [[level.custom_dof_trace]]();
    }

    tracedist = getdvarfloat(@ "hash_16d3b68a571cd9cc", 4096);
    maxenemydist = getdvarfloat(@ "hash_f920da78c320d7c9", 0);
    var_f3dc3b23367ad267 = getdvarint(@ "hash_46a24e55882202b4", 5000);
    mountfrac = self playermount();
    playereye = self getvieworigin();
    playeranglesrel = self getplayerangles();

    if(mountfrac > 0) {
      switch (level.player playermounttype()) {
        case #"hash_b882c19d3b9f4eb6":
          playereye += anglestoright(playeranglesrel) * -3;
          break;
        case #"hash_c00b1399e3e96eeb":
          playereye += anglestoright(playeranglesrel) * 3;
          break;
        case #"hash_d45b94ed344be47e":
          playereye += anglestoup(playeranglesrel) * 3;
          break;
      }
    }

    if(isDefined(self.dof_ref_ent)) {
      playerangles = combineangles(self.dof_ref_ent.angles, playeranglesrel);
    } else {
      playerangles = playeranglesrel;
    }

    playerforward = vectorNormalize(anglesToForward(playerangles));
    ignorearray = [self];

    if(vehicle::function_e445c44d3e148147()) {
      ignorearray = [self, vehicle::get_vehicle()];
    }

    trace = trace::_bullet_trace(playereye, playereye + playerforward * tracedist, 1, ignorearray, 0, 1, 0, 0, 0);
    enemies = getaiarray("?\xb1\xc0\x9a");
    weapon = self getcurrentweapon();
    results["\x17\xad\v\xde8"] = distance(playereye, trace["\xc1\xbd\xdci\xe8i{7"]);
    results["8\xdb\x90"] = results["\x17\xad\v\xde8"];

    foreach(enemy in enemies) {
      enemyaware = enemy isenemyaware();
      enemyseen = enemy hasenemybeenseen(var_f3dc3b23367ad267);

      if(!enemyaware && !enemyseen) {
        continue;
      }

      enemydir = vectorNormalize(enemy.origin - playereye);
      dot = vectordot(playerforward, enemydir);

      if(dot < 0.923) {
        continue;
      }

      distfrom = distance(playereye, enemy.origin);

      if(distfrom < results["\x17\xad\v\xde8"]) {
        results["\x17\xad\v\xde8"] = distfrom;
      }

      distfromfar = min(distfrom, maxenemydist);

      if(distfromfar > results["8\xdb\x90"]) {
        results["8\xdb\x90"] = distfromfar;
      }
    }

    return results;
  }

  function javelin_dof(trace, enemies, playereye, playerforward, adsfrac) {
    if(adsfrac < 0.88) {
      dof_disable_ads();
      return;
    }

    nearend = 10000;
    farstart = -1;
    nearend = 2400;
    nearstart = 2400;

    for(index = 0; index < enemies.size; index++) {
      enemydir = vectorNormalize(enemies[index].origin - playereye);
      dot = vectordot(playerforward, enemydir);

      if(dot < 0.923) {
        continue;
      }

      distfrom = distance(playereye, enemies[index].origin);

      if(distfrom < 2500) {
        distfrom = 2500;
      }

      if(distfrom - 30 < nearend) {
        nearend = distfrom - 30;
      }

      if(distfrom + 30 > farstart) {
        farstart = distfrom + 30;
      }
    }

    if(nearend > farstart) {
      nearend = 2400;
      farstart = 3000;
    } else {
      if(nearend < 50) {
        nearend = 50;
      }

      if(farstart > 2500) {
        farstart = 2500;
      } else if(farstart < 1000) {
        farstart = 1000;
      }
    }

    tracedist = distance(playereye, trace["\xc1\xbd\xdci\xe8i{7"]);

    if(tracedist < 2500) {
      tracedist = 2500;
    }

    if(nearend > tracedist) {
      nearend = tracedist - 30;
    }

    if(nearend < 1) {
      nearend = 1;
    }

    if(farstart < tracedist) {
      farstart = tracedist;
    }

    if(nearstart >= nearend) {
      nearstart = nearend - 1;
    }

    farend = farstart * 4;
    nearblur = 4;
    farblur = 1.8;
    dof_enable_ads(nearstart, nearend, nearblur, farstart, farend, farblur, adsfrac);
  }

  function dof_update() {
    assert(isPlayer(self));

    thread dof_debug();

    while(true) {
      waitframe();

      if(level.level_specific_dof) {
        continue;
      }

      if(getdvarint(@ "scr_art_tweak")) {
        continue;
      }

      if(!getdvarint(@ "hash_1b022342555479ae")) {
        continue;
      }

      if(getdvarint(@ "r_dof_physical_enable")) {
        adsfrac = self playerads();

        if(adsfrac > 0) {
          results = dof_process_physical_ads(adsfrac);
          self setadsphysicaldepthoffield(results["\x17\xad\v\xde8"], results["8\xdb\x90"]);
        }

        continue;
      }

      dof_process_ads();
      dof_calc_results();
      nearstart = level.dof["v\xe5\x16h\x92\x87\xa3"]["\x96\x99\x05\x0en\x80\xc0"]["\xe6\x95a\xe4\xa9\x1d\x85\x9c\xd1"];
      nearend = level.dof["v\xe5\x16h\x92\x87\xa3"]["\x96\x99\x05\x0en\x80\xc0"]["ob\x14J\x84\x02\x9d"];
      farstart = level.dof["v\xe5\x16h\x92\x87\xa3"]["\x96\x99\x05\x0en\x80\xc0"]["3X\x9c\xa6\xd1a\xe4\xa3"];
      farend = level.dof["v\xe5\x16h\x92\x87\xa3"]["\x96\x99\x05\x0en\x80\xc0"][":\x80A!tU"];
      nearblur = level.dof["v\xe5\x16h\x92\x87\xa3"]["\x96\x99\x05\x0en\x80\xc0"]["9\x90\xb5\xe7u\tV\xd4"];
      farblur = level.dof["v\xe5\x16h\x92\x87\xa3"]["\x96\x99\x05\x0en\x80\xc0"]["\xd4\x12\x1b\x8d\x1a\v\xb8"];
      self setdepthoffield(nearstart, nearend, farstart, farend, nearblur, farblur);
    }
  }

  function dof_debug() {
    assert(isPlayer(self));
    setdvarifuninitialized(@ "hash_3c32490464e4a898", "<dev string:x2b>");

    while(true) {
      while(true) {
        if(getDvar(@ "hash_3c32490464e4a898") != "<dev string:x2b>") {
          break;
        }

        wait 0.5;
      }

      thread dof_debug_start();

      while(true) {
        if(getDvar(@ "hash_3c32490464e4a898") == "<dev string:x2b>") {
          break;
        }

        wait 0.5;
      }

      thread dof_debug_stop();
    }
  }

  function function_be94af6ecedc8690(layername, xval, yval) {
    textelem = newhudelem();
    textelem.x = xval;
    textelem.y = yval;
    textelem.alignx = "<dev string:x26b>";
    textelem.aligny = "<dev string:x273>";
    textelem.horzalign = "<dev string:x27a>";
    textelem.vertalign = "<dev string:x27a>";
    textelem.font = "<dev string:x288>";
    textelem.fontscale = 0.5;
    textelem settext(layername);
    barelem = newhudelem();
    barelem.x = xval + 240;
    barelem.y = yval;
    barelem.alignx = "<dev string:x26b>";
    barelem.aligny = "<dev string:x273>";
    barelem.horzalign = "<dev string:x27a>";
    barelem.vertalign = "<dev string:x27a>";
    barelem setshader("<dev string:x296>", 1, 8);
    textelem.bar = barelem;
    level.var_60204b3221d96688[layername] = textelem;
  }

  function function_59d0ef6a4d7f7e68(layername) {
    elem = level.var_60204b3221d96688[layername];

    if(layername == "<dev string:x29f>") {
      layername = "<dev string:x101>";
      nearstart = "<dev string:x2aa>";
      nearend = "<dev string:x2b0>";
      nearblur = "<dev string:x2b6>";
      farstart = "<dev string:x2bc>";
      farend = "<dev string:x2c2>";
      farblur = "<dev string:x2c8>";
      weight = "<dev string:x2ce>";
      actual_weight = 0;
    } else {
      nearstart = math::round_float(level.dof[layername]["<dev string:x38>"]["<dev string:x43>"], 2);
      nearend = math::round_float(level.dof[layername]["<dev string:x38>"]["<dev string:x50>"], 2);
      nearblur = math::round_float(level.dof[layername]["<dev string:x38>"]["<dev string:x71>"], 2);
      farstart = math::round_float(level.dof[layername]["<dev string:x38>"]["<dev string:x5b>"], 2);
      farend = math::round_float(level.dof[layername]["<dev string:x38>"]["<dev string:x67>"], 2);
      farblur = math::round_float(level.dof[layername]["<dev string:x38>"]["<dev string:x7d>"], 2);
      weight = math::round_float(level.dof[layername]["<dev string:x38>"]["<dev string:x2d3>"], 2);
      actual_weight = level.dof[layername]["<dev string:x38>"]["<dev string:x2d3>"];
    }

    layer_width = 10;
    value_width = 8;
    text = layername;

    for(i = 0; i < layer_width - layername.size; i++) {
      text += "<dev string:x2dd>";
    }

    text += nearstart;

    for(i = 0; i < value_width - utility::string(nearstart).size; i++) {
      text += "<dev string:x2dd>";
    }

    text += nearend;

    for(i = 0; i < value_width - utility::string(nearend).size; i++) {
      text += "<dev string:x2dd>";
    }

    text += nearblur;

    for(i = 0; i < value_width - utility::string(nearblur).size; i++) {
      text += "<dev string:x2dd>";
    }

    text += farstart;

    for(i = 0; i < value_width - utility::string(farstart).size; i++) {
      text += "<dev string:x2dd>";
    }

    text += farend;

    for(i = 0; i < value_width - utility::string(farend).size; i++) {
      text += "<dev string:x2dd>";
    }

    text += farblur;

    for(i = 0; i < value_width - utility::string(farblur).size; i++) {
      text += "<dev string:x2dd>";
    }

    text += weight;
    elem settext(text);
    bar_width = 100;
    bar = elem.bar;
    bar setshader("<dev string:x296>", int(bar_width * actual_weight), 8);
  }

  function dof_debug_start() {
    level notify("<dev string:x2e2>");
    level endon("<dev string:x2e2>");
    x = 40;
    y = 40;
    yspacing = 10;
    level.var_60204b3221d96688 = [];
    function_be94af6ecedc8690("<dev string:x29f>", x, y);
    y += yspacing;
    function_be94af6ecedc8690("<dev string:x30>", x, y);
    y += yspacing;
    function_be94af6ecedc8690("<dev string:x2f4>", x, y);
    y += yspacing;
    function_be94af6ecedc8690("<dev string:x2fe>", x, y);
    y += yspacing;
    function_be94af6ecedc8690("<dev string:x305>", x, y);
    function_59d0ef6a4d7f7e68("<dev string:x29f>");

    while(true) {
      waitframe();
      function_59d0ef6a4d7f7e68("<dev string:x30>");
      function_59d0ef6a4d7f7e68("<dev string:x2f4>");
      function_59d0ef6a4d7f7e68("<dev string:x2fe>");
      function_59d0ef6a4d7f7e68("<dev string:x305>");
    }
  }

  function dof_debug_stop() {
    level notify("<dev string:x2e2>");
    level.var_60204b3221d96688["<dev string:x29f>"].bar destroy();
    level.var_60204b3221d96688["<dev string:x30>"].bar destroy();
    level.var_60204b3221d96688["<dev string:x2f4>"].bar destroy();
    level.var_60204b3221d96688["<dev string:x2fe>"].bar destroy();
    level.var_60204b3221d96688["<dev string:x305>"].bar destroy();
    level.var_60204b3221d96688["<dev string:x29f>"] destroy();
    level.var_60204b3221d96688["<dev string:x30>"] destroy();
    level.var_60204b3221d96688["<dev string:x2f4>"] destroy();
    level.var_60204b3221d96688["<dev string:x2fe>"] destroy();
    level.var_60204b3221d96688["<dev string:x305>"] destroy();
    level.var_60204b3221d96688 = undefined;
  }

  function tess_init() {
    using_tessellation = getDvar(@ "r_tessellation");

    if(using_tessellation == "") {
      return;
    }

    level.tess = spawnStruct();
    level.tess.cutoff_distance_current = 635;
    level.tess.cutoff_distance_goal = level.tess.cutoff_distance_current;
    level.tess.cutoff_falloff_current = 587;
    level.tess.cutoff_falloff_goal = level.tess.cutoff_falloff_current;
    level.tess.time_remaining = 0;
    setsaveddvar(@ "r_tessellationcutoffdistance", level.tess.cutoff_distance_current);
    setsaveddvar(@ "r_tessellationcutofffalloff", level.tess.cutoff_falloff_current);

    foreach(player in level.players) {
      player thread tess_update();
    }
  }

  function tess_set_goal(cutoff_distance, cutoff_falloff, blend_time) {
    level.tess.cutoff_distance_goal = cutoff_distance;
    level.tess.cutoff_falloff_goal = cutoff_falloff;
    level.tess.time_remaining = blend_time;
  }

  function tess_update() {
    assert(isPlayer(self));

    while(true) {
      var_613d29966528a11d = level.tess.cutoff_distance_current;
      var_5e45eed45d3a888e = level.tess.cutoff_falloff_current;
      waitframe();

      if(level.tess.time_remaining > 0) {
        frames = level.tess.time_remaining * 20;
        distance_increment = (level.tess.cutoff_distance_goal - level.tess.cutoff_distance_current) / frames;
        falloff_increment = (level.tess.cutoff_falloff_goal - level.tess.cutoff_falloff_current) / frames;
        level.tess.cutoff_distance_current += distance_increment;
        level.tess.cutoff_falloff_current += falloff_increment;
        level.tess.time_remaining -= 0.05;
      } else {
        level.tess.cutoff_distance_current = level.tess.cutoff_distance_goal;
        level.tess.cutoff_falloff_current = level.tess.cutoff_falloff_goal;
      }

      if(var_613d29966528a11d != level.tess.cutoff_distance_current) {
        setsaveddvar(@ "r_tessellationcutoffdistance", level.tess.cutoff_distance_current);
      }

      if(var_5e45eed45d3a888e != level.tess.cutoff_falloff_current) {
        setsaveddvar(@ "r_tessellationcutofffalloff", level.tess.cutoff_falloff_current);
      }
    }
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
      hudelems[i].alignx = "<dev string:x26b>";
      hudelems[i].aligny = "<dev string:x310>";
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
      hudelems[i] _settext("<dev string:x31a>");

      if(i == div) {
        alphainc *= -1;
      }

      alpha += alphainc;
      org += spacer;
    }

    level.spam_group_hudelems = hudelems;
    crosshair = _newhudelem();
    crosshair.location = 0;
    crosshair.alignx = "<dev string:x31f>";
    crosshair.aligny = "<dev string:x329>";
    crosshair.foreground = 1;
    crosshair.fontscale = 2;
    crosshair.sort = 20;
    crosshair.alpha = 1;
    crosshair.x = 320;
    crosshair.y = 244;
    crosshair _settext("<dev string:x31a>");
    level.crosshair = crosshair;
    crosshair = _newhudelem();
    crosshair.location = 0;
    crosshair.alignx = "<dev string:x31f>";
    crosshair.aligny = "<dev string:x329>";
    crosshair.foreground = 1;
    crosshair.fontscale = 2;
    crosshair.sort = 20;
    crosshair.alpha = 0;
    crosshair.x = 320;
    crosshair.y = 244;
    crosshair setvalue(0);
    level.crosshair_value = crosshair;
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
    self setdevtext("<dev string:x333>");
    thread _clearalltextafterhudelem();
    var_9f3cad54b7003a02 = 0;

    foreach(elem in level.scripted_elems) {
      if(isDefined(elem.realtext)) {
        var_9f3cad54b7003a02 += elem.realtext.size;
        elem setdevtext(elem.realtext);
      }
    }

    println("<dev string:x338>" + var_9f3cad54b7003a02);
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

  function reset_cmds() {
    setdevdvar(@ "hash_de86d29dde73df", 0);
    setdevdvar(@ "hash_cc21f65bade3fb07", 0);
  }

  function set_veil_weights(val) {
    switch (val) {
      case 1:
        setsaveddvar(@ "hash_c783a19d256907f8", ">\xae\xfb\rg\xc3\xde\xa6\x9a\xd1\x93");
        setsaveddvar(@ "hash_c783a49d25690e91", "\x8f\xf5\"\x13\x0f`\b\xc8\xff\x97\xd27=ir");
        break;
      case 2:
        setsaveddvar(@ "hash_c783a19d256907f8", "\x15\xf88\xd0\xb0v\x8aI\xa9");
        setsaveddvar(@ "hash_c783a49d25690e91", "`2\x12\x92\x9a\xe7\x9d\xfe\\vM\xbb7");
        break;
      case 3:
        setsaveddvar(@ "hash_c783a19d256907f8", "\x13\x010\xc56\x83\xe6\xa6 0\x8b\xcc\xcd\xa9");
        setsaveddvar(@ "hash_c783a49d25690e91", "7\xa8\xe71\xb8\b\xdc\xea\x1a\xf22Z\xb8\x04k\xd77\xcb");
        break;
      case 4:
        setsaveddvar(@ "hash_c783a19d256907f8", "a\"\xa6w\x8a\xae(ukx");
        setsaveddvar(@ "hash_c783a49d25690e91", "J\xa8\xc5!\x9a?~\xaa\xec\xfe\x1f\xbe");
        break;
      case 5:
        setsaveddvar(@ "hash_c783a19d256907f8", "\x82A\x0f\xc2\x9c\x9c\xf0\xa2\x84\xdb");
        setsaveddvar(@ "hash_c783a49d25690e91", "jm\x91\x1ag\xef\r&>\x8dUk!\xf9\a");
        break;
      default:
        setsaveddvar(@ "hash_c783a19d256907f8", "\xb2}\x9bc\x01|\xe4\x17\x05\x1d9\xc9a");
        setsaveddvar(@ "hash_c783a49d25690e91", "\xa54\xe4\xb6|\xff\xc9");
        break;
    }
  }