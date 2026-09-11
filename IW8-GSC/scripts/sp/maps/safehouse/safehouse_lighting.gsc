/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\safehouse\safehouse_lighting.gsc
************************************************************/

function init_lighting() {
  thread lighting_setup_lights();
  scripts\engine\sp\utility::post_load_precache(&post_load);
}

function post_load() {
  scripts\engine\sp\utility::motion_blur_enable(1);
  thread lighting_setup_dvars();
}

function lighting_setup_dvars() {
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

function lighting_setup_lights() {
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
  var0 = [level.lt_start_key, level.lt_wall, level.lt_fill_farah, level.lt_start_fill, level.lt_ceiling, level.lt_end_fill1, level.lt_end_fill2, level.lt_end_fill3, level.lt_end_key, level.lt_end_rim, level.lt_end_rim1, level.lt_end_rimvol, level.lt_windowfill, level.ls_sunfill, level.ls_sunfill2];

  foreach(var2 in var0) {
    var2 setlightintensity(0);
  }
}

function lighting_intro(var0, var1) {
  thread lighting_intro_dof(var0, var1);
  var2 = 1.2;
  var3 = 0.01;
  var4 = 0.1;
  var5 = 1;
  level.lt_intro_fill setlightintensity(0.01);
  level.lt_intro_rim2 setlightintensity(0.1);
  wait 6;
  level.lt_tunnel_fill_farah linkTo(var0, "j_neck", (-5, 15, 0), (0, -80, 0));
  level.lt_tunnel_fill_farah setlightradius(500);
  level.lt_tunnel_fill_farah setlightfovrange(110, 50);
  level.lt_tunnel_fill_farah setlightcolor((1, 0, 0));
  thread lerp_value_up(level.lt_intro_fill, var3, 0, var2);
  thread lerp_value_up(level.lt_intro_rim2, var4, 0, var2);
}

function lighting_intro_dof(var0, var1) {
  var0 scripts\engine\sp\utility::dof_enable_autofocus(2, 10, undefined, undefined, "tag_eye", undefined, 1);
  level.lt_tunnel_fill linkTo(var1, "j_neck", (-35, 55, 0), (0, -60, 0));
  level.lt_tunnel_fill setlightradius(500);
  level.lt_tunnel_fill setlightfovrange(80, 50);
  level.lt_tunnel_fill setlightcolor((1, 0, 0));
  level.lt_tunnel_omni linkTo(var0, "tag_accessory_right", (0, 0, -7), (0, -14, 0));
  level.lt_tunnel_omni setlightradius(500);
  level.lt_tunnel_omni setlightcolor((0.85, 0, 0));
  level.lt_tunnel_omni setlightintensity(0.02);
  level.lt_tunnel_fill_hadir linkTo(var1, "j_neck", (21, -5, 0), (160, 0, 0));
  level.lt_tunnel_fill_hadir setlightradius(222);
  level.lt_tunnel_fill_hadir setlightfovrange(110, 60);
  level.lt_tunnel_fill_hadir setlightcolor((1, 0, 0));
  wait 4;
  thread lerp_value_up(level.lt_tunnel_fill, 0, 0.06, 1.5);
  thread lerp_value_up(level.lt_tunnel_fill_farah, 0, 0.005, 1.5);
  thread lerp_value_up(level.lt_tunnel_fill_hadir, 0, 0.03, 4);
  wait 4;
  thread lerp_value_up(level.lt_tunnel_omni, 0.02, 0.2, 3);
  wait 8;
  thread lerp_value_up(level.lt_tunnel_fill, 0.06, 0, 2);
  thread lerp_value_up(level.lt_tunnel_fill_farah, 0.005, 0, 6);
  thread lerp_value_up(level.lt_tunnel_fill_hadir, 0.03, 0, 6);
  wait 2;
  var2 = 0.2;
  var3 = 0.03;
  thread lerp_value_up(level.lt_tunnel_omni, var2, var3, 2);
  var0 waittillmatch("single anim", "flare_to_hadir");
  level.lt_tunnel_omni linkTo(var1, "tag_accessory_right", (0, 0, -7), (0, 0, 0));
  var1 scripts\engine\sp\utility::dof_enable_autofocus(2, 10, undefined, undefined, "tag_eye", undefined, 1);
}

function lighting_tunnels(var0, var1, var2) {
  thread lighting_tunnels_dof(var0, var1, var2);
  level.lt_ceiling setlightintensity(5);
  scripts\sp\maps\safehouse\safehouse_utility::animation_waittillend(var1);
  level.lt_room setlightintensity(0.12);
}

function lighting_tunnels_dof(var0, var1, var2) {
  var0 endon("trigger");
  var1 scripts\engine\sp\utility::dof_enable_autofocus(2, 10, undefined, undefined, "tag_eye", undefined, 1);
  var3 = level.player isonladder();

  for(;;) {
    var4 = level.player isonladder();

    if(var4 && !var3) {
      level thread scripts\engine\sp\utility::dof_enable_autofocus(10, 4, 2, undefined);
    } else if(!var4 && var3) {
      var2 scripts\engine\sp\utility::dof_enable_autofocus(2, 10, undefined, undefined, "tag_eye", undefined, 1);
    }

    var3 = var4;
    waitframe();
  }
}

function lighting_disguise(var0) {
  setsaveddvar("MPOKKOPMTN", "64 128 256 512");
  var0 scripts\engine\sp\utility::dof_enable_autofocus(2, 9, undefined, undefined, "tag_eye", undefined, 1);
  thread lerp_value_up(level.lt_tunnel_omni, 0.03, 0, 1);
  thread lerp_value_up(level.lt_room, 0.12, 0.005, 0.2);
  thread lerp_value_up(level.lt_wall, 0, 0.006, 0.5);
  wait 6.2;
  var1 = 1.2;
  var2 = 4;
  var3 = 2;
  var4 = 0.2;
  var5 = 0.01;
  var6 = 0.7;
  var7 = 0.7;
  var8 = 0.25;
  var7 = 0.7;
  thread lerp_value_up(level.lt_start_key, 0, var5, var1);
  thread lerp_value_up(level.lt_start_fill, 0, var6, var1);
  thread lerp_value_up(level.lt_fill_farah, 0, var8, var1);
  wait 3.7;
  thread lerp_value_up(level.ls_sunfill, 0, var7, 2.5);
  thread lerp_value_up(level.lt_wall, 0.009, 0, 0.5);
  wait 1.5;
  thread lerp_value_up(level.lt_start_fill, var6, 0, 1);
  thread lerp_value_up(level.lt_fill_farah, var8, 0, 1);
  wait 1;
  thread lerp_value_up(level.lt_windowfill, 0, 0.25, 1);
  wait 0.7;
  thread lerp_value_up(level.lt_start_key, var5, 0, 1);
  wait 1.2;
  thread lerp_value_up(level.lt_room, 0.005, 0.12, 0.1);
}

function lighting_holster() {
  var0 = 2;
  setsaveddvar("MPOKKOPMTN", "128 256 512 1024");
  setsaveddvar("NLOTLQMORR", "0.999");
  wait 0.8;
  thread lerp_value_up(level.ls_sunfill2, 0, var0, 2);
  wait 2;
  setsaveddvar("NLOTLQMORR", "0.9");
}

function lighting_leave() {}

function lighting_hero_leave() {
  setsuncolorandintensity(0);
  waitframe();
  waitframe();
  setsaveddvar("MQRQQONQSL", 0);
  wait 0.8;
  thread lerp_value_up(level.lt_ceiling, 5, 0, 0.9);
  var0 = 1.5;
  var1 = 0.1;
  var2 = 0.004;
  var3 = 0.01;
  var4 = 0.0009;
  var5 = 0.05;
  var6 = 0.03;
  var7 = 0.65;
  var8 = scripts\sp\maps\safehouse\safehouse::level_getfarah();
  var8 scripts\engine\sp\utility::dof_enable_autofocus(2, 9, undefined, undefined, "tag_eye", undefined, 1);
  visionsetnaked("safehouse_room_disguise", 1);
  thread lerp_value_up(level.ls_sunfill, 0.7, 0, 2);
  thread lerp_value_up(level.ls_sunfill2, 0.7, 0, 2);
  setsaveddvar("MPOKKOPMTN", "64 128 256 512");
  wait 2.4;
  level.player modifybasefov(54, 3.5);
  thread lerp_value_up(level.lt_end_rimvol, 0, var7, 10);
  thread lerp_value_up(level.lt_end_fill2, 0, var3, var0);
  thread lerp_value_up(level.lt_end_key, 0, var1, 0.8);
  thread lerp_value_up(level.lt_end_fill3, 0, var4, var0);
  thread lerp_value_up(level.lt_end_fill1, 0, var2, 1);
  thread lerp_value_up(level.lt_end_rim1, 0, var6, 1);
  wait 7.8;
  level.player modifybasefov(44, 5);
  thread lerp_value_up(level.lt_end_fill1, var2, 0, 0.5);
}

function lerp_value_up(var0, var1, var2, var3) {
  var4 = var1 - var0;
  var5 = 0.02;
  var6 = int(var2 / var5);

  if(var6 > 0) {
    var7 = var4 / var6;

    while(var6) {
      var0 = max(var0 + var7, 0);
      var3 setlightintensity(var0);
      wait var5;
      var6--;
    }
  }

  var3 setlightintensity(var1);
}