/*******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\shipcrib_epilogue\shipcrib_epilogue.gsc
*******************************************************************/

main() {
  scripts\sp\utility::_id_1263F("shipcrib_epilogue_bridge_tr");
  scripts\sp\utility::_id_1263F("shipcrib_epilogue_exterior_tr");
  scripts\sp\utility::_id_F343("epilogue start");
  scripts\sp\utility::_id_1749("epilogue start", ::_id_6684, "", undefined, ["shipcrib_epilogue_bridge_tr", "shipcrib_epilogue_exterior_tr"]);
  scripts\sp\utility::_id_116CB("shipcrib_epilogue");
  scripts\sp\maps\shipcrib_epilogue\gen\shipcrib_epilogue_art::main();
  scripts\sp\maps\shipcrib_epilogue\shipcrib_epilogue_fx::main();
  scripts\sp\maps\shipcrib_epilogue\shipcrib_epilogue_precache::main();
  scripts\sp\maps\shipcrib_epilogue\shipcrib_epilogue_anim::main();
  _id_4A3B();
  scripts\sp\load::main();
  _id_0B18::_id_97F3();
  setsaveddvar("sv_saveOnStartMap", 0);
  setomnvar("ui_epilogue_lines", 0);
  scripts\engine\utility::flag_init("start_scene");
  precachemodel("heist_planet_mars_halfsphere_s0p75_base_stage1");
  precachemodel("heist_planet_mars_halfsphere_edge_glow_s0p75_stage1");
  precachemodel("fullbody_hero_eth3n");
}

_id_6684() {
  level thread _id_667C();
}

_id_667C() {
  visionsetnaked("shipcrib_epilogue", 0.5);
  thread credits_pan();
  disable_player();
  level.player thread scripts\sp\utility::_id_C12D("entering_new_demeanor", 2);
  thread scripts\sp\hud_util::_id_6AA3(0);
  var_0 = scripts\sp\hud_util::_id_7B4F();
  var_0.foreground = 0;
  setomnvar("ui_hide_hud", 1);
  setsaveddvar("hud_showStance", "0");
  setsaveddvar("compass", "0");
  setomnvar("ui_hide_weapon_info", 1);
  setsaveddvar("g_friendlyNameDist", 0);
  _id_62C3(1);
  setmusicstate("");
  var_0 fadeovertime(4);
  var_0.alpha = 1;
  wait 4.1;
  scripts\sp\utility::_id_BF95();
}

disable_player() {
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player takeallweapons();
  level.player allowmelee(0);
  level.player allowads(0);
  level.player disableweapons();
}

credits_pan() {
  var_0 = (-4800, 3380, 0);
  level.spaceparticles = scripts\engine\utility::spawn_tag_origin();
  playFXOnTag(scripts\engine\utility::getfx("space_particle"), level.spaceparticles, "tag_origin");
  var_1 = 170 + randomintrange(-30, 30);
  var_2 = (-135, angleclamp180(var_1), randomintrange(-10, 10));
  var_3 = (0, 170, 0);
  var_4 = spawn("script_origin", level.player getEye());
  var_5 = spawn("script_origin", level.player.origin);
  var_5 linkTo(var_4);
  level.player _meth_84FE();
  level.player playerlinktodelta(var_5, "", 1, 0, 0, 0, 0);
  level.player _meth_823F(var_5);
  var_6 = 125000;
  var_1 = randomintrange(-30, 30);
  var_7 = spawn("script_model", level.player.origin);
  var_7.angles = (280, 270, -90);
  var_7 setModel("heist_planet_mars_halfsphere_s0p75_base_stage1");
  var_7 add_link_model("heist_planet_mars_halfsphere_edge_glow_s0p75_stage1");
  var_7._id_BCDA = spawn("script_origin", var_7.origin);
  var_7 linkTo(var_7._id_BCDA);
  var_8 = spawn("script_origin", var_0);
  var_9 = var_0 + anglesToForward((-60, 170, 0)) * var_6;
  var_8.angles = vectortoangles(var_9 - var_0);
  var_7._id_BCDA.origin = var_9;
  var_7._id_BCDA.angles = vectortoangles(var_8.origin - var_7._id_BCDA.origin);
  var_7._id_BCDA linkTo(var_8);
  var_4.angles = var_2;
  var_4.origin = var_0;
  level waittill("start_credits_pan", var_10);
  thread eth_flyby(var_7, var_4, var_5);
  var_11 = scripts\sp\hud_util::_id_7B4F();
  var_11 fadeovertime(5);
  var_11.alpha = 0;

  if(isDefined(level._id_4A40)) {
    level._id_4A40 fadeovertime(30);
    level._id_4A40.alpha = 0;
  }

  var_4 rotateTo(var_3, var_10 + 10);
  var_8 rotatepitch(-90, var_10 * 0.7);
}

eth_flyby(var_0, var_1, var_2) {
  while(!scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), var_0.origin, -0.087155)) {
    wait 1;
  }

  thread remove_spaceparticles(var_0);
  var_3 = spawn("script_model", var_0.origin);
  var_3 setModel("fullbody_hero_eth3n");
  var_3._id_BCDA = scripts\engine\utility::spawn_tag_origin(var_3 gettagorigin("j_head"));
  var_3 linkTo(var_3._id_BCDA);
  var_3 hide();
  var_3._id_BCDA.flyent = var_3;
  var_3 hidepart("j_spineupper");
  var_3 hidepart("j_shoulder_le");
  var_3 hidepart("j_shoulder_ri");
  var_3 hidepart("j_wrist_le");
  var_3 hidepart("j_wrist_ri");
  var_3 hidepart("j_hiptwist_ri");
  var_3 hidepart("j_hiptwist_le");
  var_3 hidepart("j_proc_knee_le");
  var_3 hidepart("j_proc_knee_ri");
  var_3 hidepart("j_ankle_le");
  var_3 hidepart("j_ankle_ri");
  var_4 = (120000, -3000, 1500);
  var_5 = var_0._id_BCDA.origin + rotatevector(var_4, var_0._id_BCDA.angles);
  var_3._id_BCDA.origin = var_5;
  var_4 = (120000, 3000, 1000);
  var_6 = var_0._id_BCDA.origin + rotatevector(var_4, var_0._id_BCDA.angles);
  var_3._id_BCDA.end = var_6;
  var_7 = gettime();

  if(getdvarint("credits_test_fast")) {
    level.flybttime = 15;
  } else {
    level.flybttime = 180;
  }

  var_3._id_BCDA moveTo(var_6, level.flybttime);
  var_8 = (108, 36, 72);
  var_3._id_BCDA rotatevelocity(var_8, level.flybttime);
  level.flybypressed = 0;
  level.stopflyby = 0;
  var_3._id_BCDA thread flyby_thread();
  var_9 = spawn("script_origin", var_1.origin);
  var_9.angles = var_2.angles;
  var_10 = spawn("script_origin", level.player.origin);
  var_10.angles = var_2.angles;
  var_10 linkTo(var_9);
  var_11 = 0;
  var_12 = 0;
  var_13 = vectortoangles(var_6 - var_5) + (0, 40, 0);
  var_14 = anglesToForward(var_13);
  var_15 = distance(var_3.origin, level.player.origin) + 1000;
  var_16 = 1;
  var_17 = isdofenabled();
  var_18 = 1;
  var_19 = -175;
  var_20 = 0;

  while(!level.stopflyby) {
    var_21 = vectortoangles(var_3._id_BCDA.origin + var_14 * 110 - var_9.origin);
    var_21 = (angleclamp180(var_21[0]), angleclamp180(var_21[1]), angleclamp180(var_21[2]));
    var_9.angles = var_21 + (0, 0, var_19);

    if(level.player adsButtonPressed(1)) {
      var_11 = 1;
    } else {
      var_11 = 0;
    }

    if(var_16 && var_11) {
      wait 0.05;
      continue;
    }

    var_16 = 0;

    if(gettime() > var_20 && (var_11 != var_12 || isdofenabled() != var_17)) {
      var_17 = isdofenabled();

      if(var_11 && var_17 && var_18 != 0) {
        var_18 = 0;
        level.flybypressed = 1;
        level.player _meth_81DE(1.5, 1);
        level.player _meth_823F(var_2);
        level.player _meth_823C(var_10, "", 1, 1);
        earthquake(0.02, 30, var_10.origin, 1000);
        _id_0B0A::_id_583F(0, var_15, 6, 0, var_15 - 100, 15, 0.2);
        var_3._id_BCDA.flyent show();
      } else if(var_18 != 1) {
        var_18 = 1;
        level.flybypressed = 0;
        level.player _meth_81DE(65, 1);
        level.player _meth_823F(var_2);
        level.player _meth_823C(var_2, "", 1, 0.5, 0.5);
        _id_0B0A::_id_583D(0.5);
        var_3._id_BCDA.flyent hide();
      }

      var_20 = gettime() + 500;
      var_12 = var_11;
    }

    wait 0.05;
  }

  if(var_11) {
    level.player _meth_81DE(65, 1);
    level.player _meth_823F(var_2);
    level.player _meth_823C(var_2, "", 0.4, 0.2, 0.2);
    _id_0B0A::_id_583D(0.5);
  }

  var_22 = gettime() - var_7;
  var_3._id_BCDA moveTo(var_0._id_BCDA.origin, var_22);
  var_3._id_BCDA waittill("movedone");
  var_3._id_BCDA delete();
}

remove_spaceparticles(var_0) {
  while(!scripts\engine\utility::within_fov(level.player.origin, level.player _meth_857C(), var_0.origin, 0.642787)) {
    wait 1;
  }

  while(scripts\engine\utility::within_fov(level.player.origin, level.player _meth_857C(), var_0.origin, 0.642787)) {
    wait 1;
  }

  stopFXOnTag(scripts\engine\utility::getfx("space_particle"), level.spaceparticles, "tag_origin");
  playFX(scripts\engine\utility::getfx("space_particle_end"), (0, 0, 0));
}

isdofenabled() {
  return getdvarint("r_dof_enable") > 0;
}

flyby_thread() {
  var_0 = level.flybttime * 1000 * 0.5;
  var_1 = gettime() + var_0;
  var_2 = gettime() + 1000;

  while(gettime() < var_1) {
    wait 0.05;

    if(level.flybypressed) {
      continue;
    }
    if(gettime() > var_2) {
      var_2 = gettime() + randomfloatrange(2000, 5000);
      var_3 = vectorNormalize(level.player getEye() - self.origin);
      var_4 = self.origin + var_3 * 1000;
      playFX(level._id_7649["sniper_glint"], var_4, var_3);
    }
  }

  level.stopflyby = 1;
}

add_link_model(var_0) {
  var_1 = spawn("script_model", self.origin);
  var_1 setModel(var_0);
  var_1 linkTo(self, "", (0, 0, 0), (0, 0, 0));
}

_id_4A3B() {
  if(getdvarint("ui_play_credits", 0)) {
    level notify("going_to_credits");
    level._id_4A43 = 1;
  }

  level._id_4A3A = 1;
}

_id_62C3(var_0) {
  level notify("start_end_credits");
  thread credits_music();
  level.player _meth_82C0("shipcrib_epilogue_bridge_credits", 10.0);
  setDvar("credits_active", 1);

  if(isDefined(var_0)) {
    wait 1;
  } else {
    wait 5;
  }

  _id_0B18::_id_CF09();
}

credits_music() {
  wait 1.8;
  setmusicstate("mx_credits");
}