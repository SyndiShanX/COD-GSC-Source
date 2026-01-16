/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\pakistan_2.csc
****************************************/

#include clientscripts\_utility;
#include clientscripts\_filter;
#include clientscripts\_argus;
#include clientscripts\_bigdog;
#include clientscripts\_glasses;
#include clientscripts\pakistan_2_fx;
#include clientscripts\_load;
#include clientscripts\_audio;
#include clientscripts\pakistan_2_amb;
#include clientscripts\_swimming;
#include clientscripts\_footsteps;

main() {
  clientscripts\pakistan_2_fx::main();
  clientscripts\_load::main();
  thread clientscripts\_audio::audio_init(0);
  thread clientscripts\pakistan_2_amb::main();
  clientscripts\_swimming::main();
  level.is_bink_playing = 0;
  level.is_argus_enabled = 0;
  level.surveillance_zoom_enabled = 0;
  level.extra_cam_enabled = 0;
  level.onargusnotify = ::onargusnotify;
  level thread argus_toggle_think();
  level thread underground_fog_bank();
  level thread set_xcam_specs();
  level thread surveillance_box_position_think();
  init_filter_sonar_attachment(level.localplayers[0]);
  set_filter_sonar_attachment_params(level.localplayers[0], 0, 5, 2);
  register_clientflag_callback("player", 8, ::toggle_rain_overlay);
  register_clientflag_callback("actor", 3, clientscripts\pakistan_2_amb::menendezstartrecording);
  register_clientflag_callback("scriptmover", 5, ::incendiary_water);
  register_clientflag_callback("scriptmover", 6, ::start_extra_cam);
  register_clientflag_callback("player", 7, ::surveillance_zoom);
  register_clientflag_callback("scriptmover", 9, ::toggle_water_fx_actor);
  register_clientflag_callback("actor", 15, ::toggle_flame_char_actor);
  level thread millibar_scanner_on();
  level thread millibar_scanner_off();
  waitforclient(0);
  visionsetunderwater(0, "sp_pakistan2_swimming", 1);

  println("*** Client : pakistan_2 running...");

  init_filter_raindrops(level.localplayers[0]);
  set_player_viewmodel("c_usa_cia_masonjr_armlaunch_viewhands");
  clientscripts\_footsteps::registeraitypefootstepcb("Ally_SEAL_Pakistan_Bigdog", clientscripts\_footsteps::bigdogfootstepcbfunc);
  level thread fire_crates();
  level thread cleanup_underwater_dynents();
  level thread underwater_blur();
}

toggle_rain_overlay(localclientnum, set, newent) {
  if(set) {
    println("**** rain overlay on****");

    enable_filter_raindrops(level.localplayers[0], 2);
  } else {
    println("**** rain overlay off****");

    disable_filter_raindrops(level.localplayers[0], 2);
  }
}

incendiary_water(localclientnum, set, newent) {
  self mapshaderconstant(localclientnum, 0, "scriptVector0");
  self mapshaderconstant(localclientnum, 1, "scriptVector1");
  x = -0.5;
  y = 0;
  self setshaderconstant(localclientnum, 0, x, y, 0, 0);
  self setshaderconstant(localclientnum, 1, 2.5, 0, 0, 0);

  while(x < -0.1) {
    self setshaderconstant(localclientnum, 0, x, y, 0, 0);
    x = x + 0.01;
    wait 0.1;
  }

  self setshaderconstant(localclientnum, 1, 1.5, 0, 0, 0);

  while(x > -0.35) {
    self setshaderconstant(localclientnum, 0, x, y, 0, 0);
    x = x - 0.02;
    wait 0.05;
  }
}

feedfacialrec(elem, tag) {
  level endon(tag);
  i = 0;

  while(true) {
    if(randomint(100) > 50)
      elem.label = tablelookup("sp/argus_boot.csv", 0, i, 1) + "\\n";

    wait 0.0225;
    i++;

    if(i >= 371)
      i = 0;
  }
}

facialrectransition(startelem, endelem, transitionnotify) {
  self waittill(transitionnotify);
  thread set_elem_alpha(startelem, 0);
  thread set_elem_alpha(endelem, 1);
}

set_elem_alpha(elem, alpha) {
  setcolorelem(elem, 1, 1, 1, alpha, 0);
}

facialrecognitionui_soldier1(localclientnum, text, tag) {
  root = newmaterialelem(localclientnum, undefined, 0, 0, 200, 100, "white");
  setcolorelem(root, 1, 1, 1, 0.1, 0);
  elem1 = newmaterialelem(localclientnum, root, 5, 5, 90, 90, "cinematic");
  elem2 = newtextelem(localclientnum, root, 100, 5, 95, 90, text, "small", 0.5);
  elem2.presentation = "scrolling";
  elem2.font_style = "shadowed";
  elem2.rate = 3;
  elem2.columns = 40;
  elem2.rows = 12;
  elem3 = newmaterialelem(localclientnum, root, 5, 5, 90, 90, "photo_picture_id_1");
  setcolorelem(elem3, 1, 1, 1, 0, 0);
  thread feedfacialrec(elem2, tag);
  level thread facialrectransition(elem1, elem3, "facialRec_soldier_transition_start");
  root.is_attached = 1;
  return root;
}

facialrecognitionui_soldier2(localclientnum, text, tag) {
  root = newmaterialelem(localclientnum, undefined, 0, 0, 200, 100, "white");
  setcolorelem(root, 1, 1, 1, 0.1, 0);
  elem1 = newmaterialelem(localclientnum, root, 5, 5, 90, 90, "cinematic");
  elem2 = newtextelem(localclientnum, root, 100, 5, 95, 90, text, "small", 0.5);
  elem2.presentation = "scrolling";
  elem2.font_style = "shadowed";
  elem2.rate = 3;
  elem2.columns = 40;
  elem2.rows = 12;
  elem3 = newmaterialelem(localclientnum, root, 5, 5, 90, 90, "photo_picture_id_2");
  setcolorelem(elem3, 1, 1, 1, 0, 0);
  thread feedfacialrec(elem2, tag);
  level thread facialrectransition(elem1, elem3, "facialRec_soldier_transition_start");
  root.is_attached = 1;
  return root;
}

facialrecognitionui_soldier3(localclientnum, text, tag) {
  root = newmaterialelem(localclientnum, undefined, 0, 0, 200, 100, "white");
  setcolorelem(root, 1, 1, 1, 0.1, 0);
  elem1 = newmaterialelem(localclientnum, root, 5, 5, 90, 90, "cinematic");
  elem2 = newtextelem(localclientnum, root, 100, 5, 95, 90, text, "small", 0.5);
  elem2.presentation = "scrolling";
  elem2.font_style = "shadowed";
  elem2.rate = 3;
  elem2.columns = 40;
  elem2.rows = 12;
  elem3 = newmaterialelem(localclientnum, root, 5, 5, 90, 90, "photo_picture_id_3");
  setcolorelem(elem3, 1, 1, 1, 0, 0);
  thread feedfacialrec(elem2, tag);
  level thread facialrectransition(elem1, elem3, "facialRec_soldier_transition_start");
  root.is_attached = 1;
  return root;
}

facialrecognitionui_soldier4(localclientnum, text, tag) {
  root = newmaterialelem(localclientnum, undefined, 0, 0, 200, 100, "white");
  setcolorelem(root, 1, 1, 1, 0.1, 0);
  elem1 = newmaterialelem(localclientnum, root, 5, 5, 90, 90, "cinematic");
  elem2 = newtextelem(localclientnum, root, 100, 5, 95, 90, text, "small", 0.5);
  elem2.presentation = "scrolling";
  elem2.font_style = "shadowed";
  elem2.rate = 3;
  elem2.columns = 40;
  elem2.rows = 12;
  elem3 = newmaterialelem(localclientnum, root, 5, 5, 90, 90, "photo_picture_id_4");
  setcolorelem(elem3, 1, 1, 1, 0, 0);
  thread feedfacialrec(elem2, tag);
  level thread facialrectransition(elem1, elem3, "facialRec_soldier_transition_start");
  root.is_attached = 1;
  return root;
}

facialrecognitionui_soldier5(localclientnum, text, tag) {
  root = newmaterialelem(localclientnum, undefined, 0, 0, 200, 100, "white");
  setcolorelem(root, 1, 1, 1, 0.1, 0);
  elem1 = newmaterialelem(localclientnum, root, 5, 5, 90, 90, "cinematic");
  elem2 = newtextelem(localclientnum, root, 100, 5, 95, 90, text, "small", 0.5);
  elem2.presentation = "scrolling";
  elem2.font_style = "shadowed";
  elem2.rate = 3;
  elem2.columns = 40;
  elem2.rows = 12;
  elem3 = newmaterialelem(localclientnum, root, 5, 5, 90, 90, "photo_picture_id_5");
  setcolorelem(elem3, 1, 1, 1, 0, 0);
  thread feedfacialrec(elem2, tag);
  level thread facialrectransition(elem1, elem3, "facialRec_soldier_transition_start");
  root.is_attached = 1;
  return root;
}

facialrecognitionui_soldier6(localclientnum, text, tag) {
  root = newmaterialelem(localclientnum, undefined, 0, 0, 200, 100, "white");
  setcolorelem(root, 1, 1, 1, 0.1, 0);
  elem1 = newmaterialelem(localclientnum, root, 5, 5, 90, 90, "cinematic");
  elem2 = newtextelem(localclientnum, root, 100, 5, 95, 90, text, "small", 0.5);
  elem2.presentation = "scrolling";
  elem2.font_style = "shadowed";
  elem2.rate = 3;
  elem2.columns = 40;
  elem2.rows = 12;
  elem3 = newmaterialelem(localclientnum, root, 5, 5, 90, 90, "photo_picture_id_6");
  setcolorelem(elem3, 1, 1, 1, 0, 0);
  thread feedfacialrec(elem2, tag);
  level thread facialrectransition(elem1, elem3, "facialRec_soldier_transition_start");
  root.is_attached = 1;
  return root;
}

facialrecognitionui_militia_leader(localclientnum, text, tag) {
  root = newmaterialelem(localclientnum, undefined, 0, 0, 200, 100, "white");
  setcolorelem(root, 1, 1, 1, 0.1, 0);
  elem1 = newmaterialelem(localclientnum, root, 5, 5, 90, 90, "cinematic");
  elem2 = newtextelem(localclientnum, root, 100, 5, 95, 90, text, "small", 0.5);
  elem2.presentation = "scrolling";
  elem2.font_style = "shadowed";
  elem2.rate = 3;
  elem2.columns = 40;
  elem2.rows = 12;
  elem3 = newmaterialelem(localclientnum, root, 5, 5, 90, 90, "photo_picture_id_1");
  setcolorelem(elem3, 1, 1, 1, 0, 0);
  thread feedfacialrec(elem2, tag);
  level thread facialrectransition(elem1, elem3, "facialRec_soldier_transition_start");
  root.is_attached = 1;
  return root;
}

facialrecognitionui_menendez(localclientnum, text, tag) {
  root = newmaterialelem(localclientnum, undefined, 0, 0, 200, 100, "white");
  setcolorelem(root, 1, 1, 1, 0.1, 0);
  elem1 = newmaterialelem(localclientnum, root, 5, 5, 90, 90, "cinematic");
  elem2 = newtextelem(localclientnum, root, 100, 5, 95, 90, text, "small", 0.5);
  elem2.presentation = "scrolling";
  elem2.font_style = "shadowed";
  elem2.rate = 3;
  elem2.columns = 40;
  elem2.rows = 12;
  elem3 = newmaterialelem(localclientnum, root, 5, 5, 90, 90, "photo_menendez");
  setcolorelem(elem3, 1, 1, 1, 0, 0);
  thread feedfacialrec(elem2, tag);
  level thread facialrectransition(elem1, elem3, "facialRec_Menendez_transition_start");
  root.is_attached = 1;
  return root;
}

facialrecognitionui_defalco(localclientnum, text, tag) {
  root = newmaterialelem(localclientnum, undefined, 0, 0, 200, 100, "white");
  setcolorelem(root, 1, 1, 1, 0.1, 0);
  elem1 = newmaterialelem(localclientnum, root, 5, 5, 90, 90, "cinematic");
  elem2 = newtextelem(localclientnum, root, 100, 5, 95, 90, text, "small", 0.5);
  elem2.presentation = "scrolling";
  elem2.font_style = "shadowed";
  elem2.rate = 3;
  elem2.columns = 40;
  elem2.rows = 12;
  elem3 = newmaterialelem(localclientnum, root, 5, 5, 90, 90, "photo_defalco");
  setcolorelem(elem3, 1, 1, 1, 0, 0);
  thread feedfacialrec(elem2, tag);
  level thread facialrectransition(elem1, elem3, "facialRec_Defalco_transition_start");
  root.is_attached = 1;
  return root;
}

argusbuildui(localclientnum, usertag) {
  switch (usertag) {
    case "soldier1":
      return facialrecognitionui_soldier1(localclientnum, & "PAKISTAN_2_ARGUS_SOLDIER", usertag);
    case "soldier2":
      return facialrecognitionui_soldier2(localclientnum, & "PAKISTAN_2_ARGUS_SOLDIER", usertag);
    case "soldier3":
      return facialrecognitionui_soldier3(localclientnum, & "PAKISTAN_2_ARGUS_SOLDIER", usertag);
    case "soldier4":
      return facialrecognitionui_soldier4(localclientnum, & "PAKISTAN_2_ARGUS_SOLDIER", usertag);
    case "soldier5":
      return facialrecognitionui_soldier5(localclientnum, & "PAKISTAN_2_ARGUS_SOLDIER", usertag);
    case "soldier6":
      return facialrecognitionui_soldier6(localclientnum, & "PAKISTAN_2_ARGUS_SOLDIER", usertag);
    case "militia_leader":
      return facialrecognitionui_militia_leader(localclientnum, & "PAKISTAN_2_ARGUS_SOLDIER", usertag);
    case "menendez":
      return facialrecognitionui_menendez(localclientnum, & "PAKISTAN_2_ARGUS_MENENDEZ", usertag);
    case "defalco":
      return facialrecognitionui_defalco(localclientnum, & "PAKISTAN_2_ARGUS_DEFALCO", usertag);
  }
}

onargusnotify(localclientnum, argusid, usertag, message) {
  if(!level.is_argus_enabled) {
    argussetdistance(argusid, 0);
    argusforcedrawbracket(argusid, 0);
  }

  switch (message) {
    case "buildui":
      return argusbuildui(localclientnum, usertag);
    case "create":
      argussetoffset(argusid, vectorscale((0, 0, 1), 64.0));
      argussetdistance(argusid, 4096);
      argussetbracket(argusid, "square_bound");
      argusforcedrawbracket(argusid, 1);
      break;
    case "in":
      switch (usertag) {
        case "defalco":
        case "menendez":
        case "militia_leader":
        case "soldier1":
        case "soldier2":
        case "soldier3":
        case "soldier4":
        case "soldier5":
        case "soldier6":
          if(!within_fov(level.localplayers[localclientnum] geteye(), level.localplayers[localclientnum] getplayerangles(), argusgetorigin(argusid), cos(2.3)))
            return 0;

          break;
      }

      break;
    case "active":
      switch (usertag) {
        case "defalco":
        case "menendez":
        case "militia_leader":
        case "soldier1":
        case "soldier2":
        case "soldier3":
        case "soldier4":
        case "soldier5":
        case "soldier6":
          if(!within_fov(level.localplayers[localclientnum] geteye(), level.localplayers[localclientnum] getplayerangles(), argusgetorigin(argusid), cos(2.3))) {
            if(level.is_bink_playing) {
              argussetbracket(argusid, "square_bound");
              cancel_facial_recognition();
            }

            return 0;
          }

          if(!level.is_bink_playing)
            level thread run_facial_recognition(argusid, usertag);

          break;
      }

      break;
    case "out":
      level notify(usertag);

      switch (usertag) {
        case "defalco":
        case "menendez":
        case "militia_leader":
        case "soldier1":
        case "soldier2":
        case "soldier3":
        case "soldier4":
        case "soldier5":
        case "soldier6":
          if(level.is_bink_playing)
            cancel_facial_recognition();

          break;
      }

      break;
  }

  return 1;
}

argus_toggle_think() {
  while(true) {
    level waittill("enable_argus");
    level.is_argus_enabled = 1;
    level waittill("disable_argus");
    level.is_argus_enabled = 0;
  }
}

run_facial_recognition(argusid, usertag) {
  level endon("stop_facial_recognition");
  level.is_bink_playing = 1;
  argussetbracket(argusid, "round_timer");
  level.facial_recognition_bink = playbink("faces_scroll", 1);
  playloopat("evt_surv_scan_dude", (0, 0, 0));
  wait 2.0;

  if(usertag == "menendez") {
    level notify("facialRec_Menendez_transition_start");
    wait 3.0;
  } else if(usertag == "defalco") {
    level notify("facialRec_Defalco_transition_start");
    wait 3.0;
  } else if(usertag == "militia_leader" || usertag == "soldier1" || usertag == "soldier2" || usertag == "soldier3" || usertag == "soldier4" || usertag == "soldier5" || usertag == "soldier6") {
    level notify("facialRec_soldier_transition_start");
    wait 3.0;
  }

  soundstoploopemitter("evt_surv_scan_dude", (0, 0, 0));
  argussetdistance(argusid, 0);
  argusforcedrawbracket(argusid, 0);
  level.is_bink_playing = 0;
}

cancel_facial_recognition() {
  level notify("stop_facial_recognition");
  soundstoploopemitter("evt_surv_scan_dude", (0, 0, 0));
  playsound(0, "evt_surv_scan_deny", (0, 0, 0));
  stopbink(level.facial_recognition_bink);
  level.is_bink_playing = 0;
}

millibar_scanner_on(localclientnum, ent, ent2) {
  level waittill("force");
  level.localplayers[0] forceinfraredmaterialsstreaming(1);
  level waittill("millibar_on");
  enable_filter_sonar_attachment(level.localplayers[0], 0, 0);
  setsaveddvar("r_stereo3DEyeSeparationScaler", 0.166667);
  level.localplayers[0] setsonarattachmentenabled(1);
}

millibar_scanner_off(localclientnum, ent, ent2) {
  level waittill("millibar_off");
  level.localplayers[0] forceinfraredmaterialsstreaming(0);
  disable_filter_sonar_attachment(level.localplayers[0], 0, 0);
  setsaveddvar("r_stereo3DEyeSeparationScaler", 1);
  level.localplayers[0] setsonarattachmentenabled(0);
}

swimming_fog() {
  start_dist = 0;
  half_dist = 75;
  half_height = 1000;
  base_height = 0;
  fog_r = 0.14;
  fog_g = 0.199;
  fog_b = 0.292;
  fog_scale = 0.1;
  sun_col_r = 14;
  sun_col_g = 0.199;
  sun_col_b = 0.292;
  sun_dir_x = 0;
  sun_dir_y = 0;
  sun_dir_z = 0;
  sun_start_ang = 0;
  sun_stop_ang = 180;
  max_fog_opacity = 1;
  setwaterfog(start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale, sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang, sun_stop_ang, max_fog_opacity);
}

underground_fog_bank() {
  level waittill("fog_bank_3");
  setworldfogactivebank(0, 4);
  level waittill("fog_bank_1");
  setworldfogactivebank(0, 1);
}

set_xcam_specs() {
  level.pip_filterid = 2;
  level.pip_passid = 0;
  level.pip_materialid = 12;
  level.pip_opacity = 0.5;
  level.pip_squash = 1.0;
  level.pip_material = "generic_filter_pak_magnifier";
  level.pip_left = 362;
  level.pip_top = 305;
  level.pip_right = 522;
  level.pip_bottom = 415;
  player = level.localplayers[0];
  player map_material(level.pip_materialid, level.pip_material);
  player set_filter_pass_material(level.pip_filterid, level.pip_passid, level.pip_materialid);
  player set_filter_pass_constant(level.pip_filterid, level.pip_passid, 4, level.pip_left);
  player set_filter_pass_constant(level.pip_filterid, level.pip_passid, 5, level.pip_top);
  player set_filter_pass_constant(level.pip_filterid, level.pip_passid, 6, level.pip_right);
  player set_filter_pass_constant(level.pip_filterid, level.pip_passid, 7, level.pip_bottom);
  player set_filter_bit_flag(level.pip_filterid, 2, 1);
}

surveillance_zoom(localclientnum, set, newent) {
  level.surveillance_zoom_enabled = set;
}

start_extra_cam(localclientnum, set, newent) {
  if(set) {
    self linktocamera();
    start_sw_cam(0.1, 0.1, 0.1);
  } else {
    stop_sw_cam();
    self unlinkfromcamera();
    snd_set_snapshot("spl_pakistan_2_bfutz");
  }

  level.extra_cam_enabled = set;

  if(level.wiiu)
    setsaveddvar("wiiu_disableYellowDot", set);
}

start_sw_cam(fade_in_time, hold_static_time, static_time) {
  level.localplayers[0] set_filter_pass_enabled(level.pip_filterid, level.pip_passid, 1);
  level.localplayers[0] set_filter_pass_constant(level.pip_filterid, level.pip_passid, 0, level.pip_opacity);
  level.localplayers[0] set_filter_pass_constant(level.pip_filterid, level.pip_passid, 1, level.pip_squash);

  if(!isDefined(fade_in_time))
    fade_in_time = 2.0;

  if(!isDefined(hold_static_time))
    hold_static_time = 0.6;

  if(!isDefined(static_time))
    static_time = 2.2;

  level thread fade_in_sw_extra_cam(fade_in_time, hold_static_time, static_time);
}

stop_sw_cam() {
  level.localplayers[0] set_filter_pass_enabled(level.pip_filterid, level.pip_passid, 0);
}

fade_in_sw_extra_cam(fade_in_time, hold_static_time, static_time) {
  level.localplayers[0] set_filter_pass_constant(level.pip_filterid, level.pip_passid, 0, 1);
  level.localplayers[0] set_filter_pass_constant(level.pip_filterid, level.pip_passid, 2, 1);
  alpha = 0;
  fuzz = 0;
}

fade_out_sw_extra_cam(fade_out_time, hold_static_time, static_time) {
  alpha = 1.0;
  fuzz = 0.5;
  time = 0;
  start_time = getrealtime();

  while(time < static_time) {
    time = (getrealtime() - start_time) / 1000;

    if(time > static_time)
      time = static_time;

    frac = (static_time - time) / static_time;
    fuzz = frac;

    if(fuzz < 0.01)
      fuzz = 0.01;

    level.localplayers[0] set_filter_pass_constant(level.pip_filterid, level.pip_passid, 0, alpha);
    level.localplayers[0] set_filter_pass_constant(level.pip_filterid, level.pip_passid, 2, fuzz);
    wait 0.01;
  }

  wait(hold_static_time);
  time = 0;
  start_time = getrealtime();

  while(time < fade_out_time) {
    time = (getrealtime() - start_time) / 1000;

    if(time > fade_out_time)
      time = fade_out_time;

    alpha = (fade_out_time - time) / fade_out_time;
    level.localplayers[0] set_filter_pass_constant(level.pip_filterid, level.pip_passid, 0, alpha);
    level.localplayers[0] set_filter_pass_constant(level.pip_filterid, level.pip_passid, 2, fuzz);
    wait 0.01;
  }
}

fire_crates() {
  level waittill("crates_on_fire");
  a_e_crates = getdynentarray("grenade_room_crate");

  for(i = 0; i < a_e_crates.size; i++)
    playfxondynent(level._effect["fire_crate"], a_e_crates[i]);
}

setgrappeltarget(b_state) {
  setdvarbool("cg_BallisticArc_ForceHitIndicator", b_state);
}

toggle_flame_char_actor(localclientnum, set, newent) {
  self mapshaderconstant(localclientnum, 0, "ScriptVector0");
  s_timer = new_timer();

  do {
    wait 0.01;
    n_current_time = s_timer get_time_in_seconds();
    n_delta_val = lerpfloat(0, 0.85, n_current_time / 3);
    self setshaderconstant(localclientnum, 0, 0, 0, n_delta_val, 0);
  }
  while(n_current_time < 3);
}

init_claw_damage_filter() {
  level waittill("aS_off");
  init_filter_vehicle_damage(level.localplayers[0], "generic_filter_vehicle_damage");
  claw_damage_watcher();
}

claw_damage_watcher() {
  level endon("end_damage_filter_watcher");

  while(true) {
    level waittill("claw_damage_filter_enable");
    claw_damage_filter_loop();
    disable_filter_vehicle_damage(level.localplayers[0], 0);
  }
}

claw_damage_filter_loop() {
  level endon("end_damage_filter");

  while(true) {
    enable_filter_vehicle_damage(level.localplayers[0], 0, "generic_filter_vehicle_damage");
    set_filter_vehicle_damage_amount(level.localplayers[0], 0, 1);
    wait 0.05;
  }
}

cleanup_underwater_dynents() {
  level waittill("clean_under_phy");
  a_e_dynents = getdynentarray("underwater_phys_ent");

  foreach(e_dynent in a_e_dynents)
  setdynentenabled(e_dynent, 0);

  level waittill("clean_gren_phy");
  a_e_dynents = getdynentarray("grenade_phys_ent");

  foreach(e_dynent in a_e_dynents)
  setdynentenabled(e_dynent, 0);

  level waittill("clean_fire_phy");
  a_e_dynents = getdynentarray("firewater_phys_ent");

  foreach(e_dynent in a_e_dynents)
  setdynentenabled(e_dynent, 0);
}

underwater_blur() {
  level endon("blur_over");

  while(true) {
    level waittill("blur_yes");
    level.localplayers[0] setblur(1.2, 2.0);
    level waittill("blur_no");
    level.localplayers[0] setblur(0, 1.0);
  }
}

surveillance_box_position_think() {
  while(true) {
    if(level.extra_cam_enabled) {
      center_x = 442;
      center_y = 360;
      inlay_origin_x = 0;
      inlay_origin_y = 0;
      player = level.localplayers[0];

      if(level.wiiu) {
        controller_type = player getcontrollertype();

        if(controller_type == "remote") {
          screen_width = center_x * 2;
          screen_height = center_y * 2;
          pointer_pos = player getwiiuremotepointerposition();
          center_x = screen_width * pointer_pos[0];
          center_y = screen_height * pointer_pos[1];
          inlay_origin_x = pointer_pos[0] * 2.0 - 1.0;
          inlay_origin_y = pointer_pos[1] * 2.0 - 1.0;
        }
      }

      box_width = 160;
      box_height = 120;

      if(level.surveillance_zoom_enabled) {
        box_width = 280;
        box_height = 210;
      }

      if(!level.console) {
        screen_width = getscreenwidth();
        screen_height = getscreenheight();
        center_x = center_x / 884 * screen_width;
        center_y = center_y / 720 * screen_height;
        box_width = box_width / 884 * screen_width;
        box_height = box_height / 720 * screen_height;
      }

      level.pip_left = center_x - box_width / 2;
      level.pip_top = center_y - box_height / 2;
      level.pip_right = center_x + box_width / 2;
      level.pip_bottom = center_y + box_height / 2;
      player set_filter_pass_constant(level.pip_filterid, level.pip_passid, 4, level.pip_left);
      player set_filter_pass_constant(level.pip_filterid, level.pip_passid, 5, level.pip_top);
      player set_filter_pass_constant(level.pip_filterid, level.pip_passid, 6, level.pip_right);
      player set_filter_pass_constant(level.pip_filterid, level.pip_passid, 7, level.pip_bottom);
      inlay_zoom_scale = 7;
      player set_filter_pass_constant(level.pip_filterid, level.pip_passid, 8, inlay_origin_x * inlay_zoom_scale);
      player set_filter_pass_constant(level.pip_filterid, level.pip_passid, 9, inlay_origin_y * inlay_zoom_scale);
    }

    wait 0.01;
  }
}

toggle_water_fx_actor(localclientnum, set, newent) {
  if(set)
    self.fx_handle = playfxontag(localclientnum, level._effect["water_wake"], self, "tag_origin");
  else
    deletefx(localclientnum, self.fx_handle);
}