/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\safehouse\safehouse_lighting.gsc
****************************************************/

init_lighting() {
  thread lighting_setup_lights();
  scripts\engine\sp\utility::post_load_precache(::post_load);
}

post_load() {
  scripts\engine\sp\utility::motion_blur_enable(1);
  thread lighting_setup_dvars();
}

lighting_setup_dvars() {
  setsaveddvar("NPONLLLSPL", ".32");
  setsaveddvar("TLMMOPMSK", "1");
  setsaveddvar("TMNTMTQRM", "0");
  setsaveddvar("LLNMKLQQP", "4");
  setsaveddvar("LSNRQTOKRR", "2");
  setsaveddvar("NTLKNLNPLK", "2");
  setsaveddvar("LTQMSPKRKO", 4);
  setsaveddvar("MROOOROPKL", 6);
  wait 5;
  setsaveddvar("LKOLRONRNQ", 500);
}

lighting_setup_lights() {
  level.lt_start_key = getEnt("lt_start_key", "targetname");
  level.lt_start_fill = getEnt("lt_start_fill", "targetname");
  level.lt_room = getEnt("lt_room", "targetname");
  level.lt_ceiling = getEnt("lt_ceiling", "targetname");
  level.lt_end_key = getEnt("lt_end_key", "targetname");
  level.lt_end_fill1 = getEnt("lt_end_fill1", "targetname");
  level.lt_end_fill2 = getEnt("lt_end_fill2", "targetname");
  level.lt_end_fill3 = getEnt("lt_end_fill3", "targetname");
  level.lt_end_rimvol = getEnt("lt_end_rimvol", "targetname");
  level.lt_end_rim = getEnt("lt_end_rim", "targetname");
  level.lt_end_rim1 = getEnt("lt_end_rim1", "targetname");
  level.lt_intro_rim2 = getEnt("lt_intro_rim2", "targetname");
  level.lt_intro_fill = getEnt("lt_intro_fill", "targetname");
  level.lt_windowfill = getEnt("lt_windowfill", "targetname");
  level.ls_sunfill = getEnt("ls_sunfill", "targetname");
  level.ls_sunfill2 = getEnt("ls_sunfill2", "targetname");
  level.lt_wall = getEnt("lt_wall", "targetname");
  level.lt_fill_farah = getEnt("lt_fill_farah", "targetname");
  level.lt_tunnel_fill = getEnt("tunnel_fill", "targetname");
  level.lt_tunnel_fill_farah = getEnt("tunnel_fill_farah", "targetname");
  level.lt_tunnel_fill_hadir = getEnt("tunnel_fill_hadir", "targetname");
  level.lt_tunnel_omni = getEnt("tunnel_omni", "targetname");
  var_0 = [level.lt_start_key, level.lt_wall, level.lt_fill_farah, level.lt_start_fill, level.lt_ceiling, level.lt_end_fill1, level.lt_end_fill2, level.lt_end_fill3, level.lt_end_key, level.lt_end_rim, level.lt_end_rim1, level.lt_end_rimvol, level.lt_windowfill, level.ls_sunfill, level.ls_sunfill2];

  foreach(var_2 in var_0)
  var_2 setlightintensity(0);
}

lighting_intro(var_0, var_1) {
  thread lighting_intro_dof(var_0, var_1);
  var_2 = 1.2;
  var_3 = 0.01;
  var_4 = 0.1;
  var_5 = 1;
  level.lt_intro_fill setlightintensity(0.01);
  level.lt_intro_rim2 setlightintensity(0.1);
  wait 6.0;
  level.lt_tunnel_fill_farah linkTo(var_0, "j_neck", (-5, 15, 0), (0, -80, 0));
  level.lt_tunnel_fill_farah setlightradius(500);
  level.lt_tunnel_fill_farah setlightfovrange(110, 50);
  level.lt_tunnel_fill_farah setlightcolor((1, 0, 0));
  level.lt_intro_fill thread lerp_value_up(var_3, 0, var_2, level.lt_intro_fill);
  level.lt_intro_rim2 thread lerp_value_up(var_4, 0, var_2, level.lt_intro_rim2);
}

lighting_intro_dof(var_0, var_1) {
  var_0 scripts\engine\sp\utility::dof_enable_autofocus(2.0, 10, undefined, undefined, "tag_eye", undefined, 1);
  level.lt_tunnel_fill linkTo(var_1, "j_neck", (-35, 55, 0), (0, -60, 0));
  level.lt_tunnel_fill setlightradius(500);
  level.lt_tunnel_fill setlightfovrange(80, 50);
  level.lt_tunnel_fill setlightcolor((1, 0, 0));
  level.lt_tunnel_omni linkTo(var_0, "tag_accessory_right", (0, 0, -7), (0, -14, 0));
  level.lt_tunnel_omni setlightradius(500);
  level.lt_tunnel_omni setlightcolor((0.85, 0, 0));
  level.lt_tunnel_omni setlightintensity(0.02);
  level.lt_tunnel_fill_hadir linkTo(var_1, "j_neck", (21, -5, 0), (160, 0, 0));
  level.lt_tunnel_fill_hadir setlightradius(222);
  level.lt_tunnel_fill_hadir setlightfovrange(110, 60);
  level.lt_tunnel_fill_hadir setlightcolor((1, 0, 0));
  wait 4.0;
  level.lt_tunnel_fill thread lerp_value_up(0, 0.06, 1.5, level.lt_tunnel_fill);
  level.lt_tunnel_fill_farah thread lerp_value_up(0, 0.005, 1.5, level.lt_tunnel_fill_farah);
  level.lt_tunnel_fill_hadir thread lerp_value_up(0, 0.03, 4, level.lt_tunnel_fill_hadir);
  wait 4.0;
  level.lt_tunnel_omni thread lerp_value_up(0.02, 0.2, 3.0, level.lt_tunnel_omni);
  wait 8.0;
  level.lt_tunnel_fill thread lerp_value_up(0.06, 0, 2, level.lt_tunnel_fill);
  level.lt_tunnel_fill_farah thread lerp_value_up(0.005, 0, 6, level.lt_tunnel_fill_farah);
  level.lt_tunnel_fill_hadir thread lerp_value_up(0.03, 0, 6, level.lt_tunnel_fill_hadir);
  wait 2.0;
  var_2 = 0.2;
  var_3 = 0.03;
  level.lt_tunnel_omni thread lerp_value_up(var_2, var_3, 2.0, level.lt_tunnel_omni);
  var_0 waittillmatch("single anim", "flare_to_hadir");
  level.lt_tunnel_omni linkTo(var_1, "tag_accessory_right", (0, 0, -7), (0, 0, 0));
  var_1 scripts\engine\sp\utility::dof_enable_autofocus(2.0, 10, undefined, undefined, "tag_eye", undefined, 1);
}

lighting_tunnels(var_0, var_1, var_2) {
  thread lighting_tunnels_dof(var_0, var_1, var_2);
  level.lt_ceiling setlightintensity(5.0);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_waittillend(var_1);
  level.lt_room setlightintensity(0.12);
}

lighting_tunnels_dof(var_0, var_1, var_2) {
  var_0 endon("trigger");
  var_1 scripts\engine\sp\utility::dof_enable_autofocus(2.0, 10, undefined, undefined, "tag_eye", undefined, 1);
  var_3 = level.player isonladder();

  for(;;) {
    var_4 = level.player isonladder();

    if(var_4 && !var_3)
      level thread scripts\engine\sp\utility::dof_enable_autofocus(10.0, 4.0, 2.0, undefined);
    else if(!var_4 && var_3)
      var_2 scripts\engine\sp\utility::dof_enable_autofocus(2.0, 10, undefined, undefined, "tag_eye", undefined, 1);

    var_3 = var_4;
    waitframe();
  }
}

lighting_disguise(var_0) {
  setsaveddvar("MPOKKOPMTN", "64 128 256 512");
  var_0 scripts\engine\sp\utility::dof_enable_autofocus(2.0, 9.0, undefined, undefined, "tag_eye", undefined, 1);
  level.lt_tunnel_omni thread lerp_value_up(0.03, 0.0, 1, level.lt_tunnel_omni);
  level.lt_room thread lerp_value_up(0.12, 0.005, 0.2, level.lt_room);
  level.lt_wall thread lerp_value_up(0.0, 0.006, 0.5, level.lt_wall);
  wait 6.2;
  var_1 = 1.2;
  var_2 = 4;
  var_3 = 2.0;
  var_4 = 0.2;
  var_5 = 0.01;
  var_6 = 0.7;
  var_7 = 0.7;
  var_8 = 0.25;
  var_7 = 0.7;
  level.lt_start_key thread lerp_value_up(0, var_5, var_1, level.lt_start_key);
  level.lt_start_fill thread lerp_value_up(0, var_6, var_1, level.lt_start_fill);
  level.lt_fill_farah thread lerp_value_up(0, var_8, var_1, level.lt_fill_farah);
  wait 3.7;
  level.ls_sunfill thread lerp_value_up(0, var_7, 2.5, level.ls_sunfill);
  level.lt_wall thread lerp_value_up(0.009, 0.0, 0.5, level.lt_wall);
  wait 1.5;
  level.lt_start_fill thread lerp_value_up(var_6, 0, 1, level.lt_start_fill);
  level.lt_fill_farah thread lerp_value_up(var_8, 0, 1, level.lt_fill_farah);
  wait 1.0;
  level.lt_windowfill thread lerp_value_up(0, 0.25, 1, level.lt_windowfill);
  wait 0.7;
  level.lt_start_key thread lerp_value_up(var_5, 0, 1, level.lt_start_key);
  wait 1.2;
  level.lt_room thread lerp_value_up(0.005, 0.12, 0.1, level.lt_room);
}

lighting_holster() {
  var_0 = 2;
  setsaveddvar("MPOKKOPMTN", "128 256 512 1024");
  setsaveddvar("NLOTLQMORR", "0.999");
  wait 0.8;
  level.ls_sunfill2 thread lerp_value_up(0, var_0, 2, level.ls_sunfill2);
  wait 2.0;
  setsaveddvar("NLOTLQMORR", "0.9");
}

lighting_leave() {}

lighting_hero_leave() {
  setsuncolorandintensity(0.0);
  waitframe();
  waitframe();
  setsaveddvar("MQRQQONQSL", 0);
  wait 0.8;
  level.lt_ceiling thread lerp_value_up(5.0, 0.0, 0.9, level.lt_ceiling);
  var_0 = 1.5;
  var_1 = 0.1;
  var_2 = 0.004;
  var_3 = 0.01;
  var_4 = 0.0009;
  var_5 = 0.05;
  var_6 = 0.03;
  var_7 = 0.65;
  var_8 = scripts\sp\maps\safehouse\safehouse.gsc::level_getfarah();
  var_8 scripts\engine\sp\utility::dof_enable_autofocus(2.0, 9.0, undefined, undefined, "tag_eye", undefined, 1);
  visionsetnaked("safehouse_room_disguise", 1);
  level.ls_sunfill thread lerp_value_up(0.7, 0.0, 2.0, level.ls_sunfill);
  level.ls_sunfill2 thread lerp_value_up(0.7, 0.0, 2.0, level.ls_sunfill2);
  setsaveddvar("MPOKKOPMTN", "64 128 256 512");
  wait 2.4;
  level.player modifybasefov(54, 3.5);
  level.lt_end_rimvol thread lerp_value_up(0, var_7, 10.0, level.lt_end_rimvol);
  level.lt_end_fill2 thread lerp_value_up(0, var_3, var_0, level.lt_end_fill2);
  level.lt_end_key thread lerp_value_up(0, var_1, 0.8, level.lt_end_key);
  level.lt_end_fill3 thread lerp_value_up(0, var_4, var_0, level.lt_end_fill3);
  level.lt_end_fill1 thread lerp_value_up(0, var_2, 1.0, level.lt_end_fill1);
  level.lt_end_rim1 thread lerp_value_up(0, var_6, 1.0, level.lt_end_rim1);
  wait 7.8;
  level.player modifybasefov(44, 5.0);
  level.lt_end_fill1 thread lerp_value_up(var_2, 0, 0.5, level.lt_end_fill1);
}

lerp_value_up(var_0, var_1, var_2, var_3) {
  var_4 = var_1 - var_0;
  var_5 = 0.02;
  var_6 = int(var_2 / var_5);

  if(var_6 > 0) {
    for(var_7 = var_4 / var_6; var_6; var_6--) {
      var_0 = max(var_0 + var_7, 0);
      var_3 setlightintensity(var_0);
      wait(var_5);
    }
  }

  var_3 setlightintensity(var_1);
}