/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\ja_titan\ja_titan.gsc
*************************************************/

main() {
  scripts\sp\utility::_id_116CB("ja_titan");
  _id_10AE::_id_A0AB();
  scripts\sp\maps\ja_titan\gen\ja_titan_art::main();
  scripts\sp\maps\ja_titan\ja_titan_fx::main();
  scripts\sp\maps\ja_titan\ja_titan_precache::main();
  level._effect["vfx_atmos_titan_dust_01"] = loadfx("vfx/iw7/levels/ja_assault/vfx_atmos_titan_dust_particulate_01.vfx");
  scripts\sp\utility::_id_F343("equipment_select");
  scripts\sp\utility::_id_1749("launch", ::_id_10C98, "launch", ::_id_B209, undefined, undefined, 1);
  scripts\sp\utility::_id_1749("mission_complete", ::_id_10CAE, "mission_complete", ::_id_B20F, undefined, undefined, 1);
  scripts\sp\load::main();
  scripts\sp\utility::_id_241F(1);
  _id_10AE::_id_9637();
  _id_10AE::_id_1C44();
  _id_A04B();
  setsaveddvar("r_transShadowEnable", 1);
  setsaveddvar("r_heightfieldSunShadow", 0);
  setsaveddvar("sm_sunSampleSizeNear", 10.3);
  setsaveddvar("sm_sunCascadeSizeMultiplier2", 3);
}

_id_A04B() {
  _id_0BDC::_id_F435("jackal_landing_ja_titan");
  thread _id_10AE::_id_104D0("debris_cloud_struct", "vfx_atmos_titan_dust_01");
}

_id_10C98() {}

_id_B209() {
  _id_10AE::_id_D7C9();
  var_0 = getEnt("player_jackal", "targetname");
  _id_0BDC::_id_10CD1(var_0);
  var_0 thread _id_10AE::_id_57C4("player_spline_intro", 400, 4.5, 1.75);
  scripts\engine\utility::flag_wait("intro_start");
  scripts\engine\utility::delaythread(0.5, _id_10AE::_id_CE81, ::_id_AAA1);
  scripts\engine\utility::flag_wait("intro_hold_on_black_done");
  thread _id_10AE::_id_57A9("missileboats", "sdf_missileboats", 5, undefined, ::_id_B881);
  scripts\engine\utility::delaythread(0.2, ::_id_B880);
  thread _id_10AE::_id_E3B6(0);
  thread _id_10AE::_id_56B3("missileboats", "jackal_objective_missile_boats", 1, &"JACKAL_OBJECTIVE_MISSILE_BOATS_MENU");
  setmusicstate("mx_288_ja_titan");
  thread _id_11984();
  scripts\engine\utility::flag_wait("intro_done");
  _id_0BDC::_id_A321(0.5);
  _id_10AE::_id_C2A0("missileboats");
  thread _id_B885();
  thread _id_10234();
  thread _id_155D();
  thread _id_EAAD();
  thread _id_B886();
  thread _id_C505();
  scripts\engine\utility::flag_wait("missileboatscomplete_vo_finished");
  scripts\engine\utility::flag_wait("skelterscomplete_vo_finished");
  scripts\engine\utility::flag_wait("acescomplete_vo_finished");
}

_id_11984() {
  _id_10AE::_id_E3FA("ret_start");
  thread _id_10AE::_id_5768("intro_jackals", "intro_jackal", undefined, 1);
  _id_10AE::_id_E3A7("ret_goal1", 1500, 0, 0);
  _id_10AE::_id_E3A7("ret_goal2", 1000, 0, 0);
  thread _id_10AE::_id_E382("ret_pivot");
}

_id_B880() {
  level.player endon("death");

  foreach(var_1 in level._id_A3A8["missileboats"]._id_FE2D) {
    if(!isDefined(var_1) || !isalive(var_1)) {
      continue;
    }
    var_1 thread _id_0BA9::_id_3985(0);
    var_1._id_E35C = 90;
  }

  var_3 = 0;
  var_4 = 90;

  while(!var_3) {
    foreach(var_1 in level._id_A3A8["missileboats"]._id_FE2D) {
      if(!isDefined(var_1) || !isalive(var_1)) {
        continue;
      }
      if(isDefined(var_1._id_8CCA) && var_1._id_8CCA <= var_4) {
        var_3 = 1;
        break;
      }
    }

    wait 0.05;
  }

  foreach(var_1 in level._id_A3A8["missileboats"]._id_FE2D) {
    if(!isDefined(var_1) || !isalive(var_1)) {
      continue;
    }
    var_1 thread _id_0BA9::_id_3985(1, 1);
    scripts\engine\utility::delaythread(1, ::_id_E2C9);
  }

  var_3 = 0;
  var_4 = 50;

  while(!var_3) {
    foreach(var_1 in level._id_A3A8["missileboats"]._id_FE2D) {
      if(!isDefined(var_1) || !isalive(var_1)) {
        continue;
      }
      if(isDefined(var_1._id_8CCA) && var_1._id_8CCA <= var_4) {
        var_3 = 1;
        break;
      }
    }

    wait 0.05;
  }

  foreach(var_1 in level._id_A3A8["missileboats"]._id_FE2D) {
    if(!isDefined(var_1) || !isalive(var_1)) {
      continue;
    }
    var_1 thread _id_0BA9::_id_3985(1);
  }
}

_id_E2C9() {
  if(isDefined(self) && isalive(self))
    self._id_E35C = 60;
}

_id_10234() {
  scripts\engine\utility::flag_wait("missileboats4_left");
  wait 4.5;
  thread _id_10AE::_id_57AB("skelters", "sdf_skelters1", "axis_arena_jackals", undefined, 8.0, 13, 4, 7, 1, ::_id_10235, ::_id_10237);
  scripts\engine\utility::delaythread(5.0, ::_id_10236, "skelters");
  thread _id_10AE::_id_56B3("skelters", "jackal_objective_skelters", 0, &"JACKAL_OBJECTIVE_SKELTERS_MENU");
}

_id_10236(var_0) {
  foreach(var_2 in level._id_A3A8[var_0]._id_FE2D)
  var_2 thread _id_0BDC::_id_1983();
}

_id_155D() {
  scripts\engine\utility::flag_wait("missileboats1_left");
  wait 5.0;
  thread _id_10AE::_id_57A7("aces", "sdf_ace", 2, ::_id_155E, ::_id_155F);
  thread _id_10AE::_id_56B3("aces", "jackal_objective_aces", 1, &"JACKAL_OBJECTIVE_ACES_MENU");
  thread _id_1562();
}

_id_EAAD() {
  scripts\engine\utility::flag_wait("missileboats3_left");
  wait 5.0;
  level._id_A3A8["missileboats"]._id_FE2D = scripts\engine\utility::array_removeundefined(level._id_A3A8["missileboats"]._id_FE2D);

  foreach(var_1 in level._id_A3A8["missileboats"]._id_FE2D)
  var_1 thread _id_137A7();

  level waittill("missileboat_in_pov", var_1);
  var_1 _id_0BB1::_id_B85F();
  wait 2.5;
  thread _id_10AE::_id_CE80(::_id_EAAE);
}

_id_137A7() {
  self endon("death");
  level endon("missileboat_in_pov");
  var_0 = 0.8;
  var_1 = 0.5;
  var_2 = undefined;

  for(;;) {
    if(!isDefined(self) || !isalive(self)) {
      break;
    }

    var_3 = anglesToForward(level._id_D127.angles);
    var_4 = self.origin - level._id_D127.origin;
    var_5 = vectorNormalize(var_4);
    var_6 = length(var_4);
    var_7 = vectordot(var_5, var_3);

    if(var_7 >= var_0) {
      if(isDefined(var_2)) {
        if(gettime() - var_1 * 1000 >= var_2) {
          break;
        }
      } else
        var_2 = gettime();
    } else
      var_2 = undefined;

    wait 0.05;
  }

  level notify("missileboat_in_pov", self);
}

_id_B886() {
  foreach(var_1 in level._id_A3A8["missileboats"]._id_FE2D)
  var_1 thread _id_B86A();
}

_id_B86A() {
  self endon("death");
  self endon("entitydeleted");
  level.player endon("death");

  if(!isDefined(self._id_E35C))
    self._id_E35C = 60;

  while(isDefined(self._id_8CCA) && self._id_8CCA > self._id_E35C)
    wait 0.05;

  var_0 = _id_0BB1::_id_77D2(getEntArray("missileboat_volume", "targetname"));

  if(var_0.size > 0)
    _id_0BB1::_id_F486(var_0[randomint(var_0.size)]);
}

_id_C505() {
  for(;;) {
    var_0 = ["missileboatscomplete_vo_finished", "skelterscomplete_vo_finished", "acescomplete_vo_finished"];
    var_1 = level scripts\engine\utility::waittill_any_return(var_0[0], var_0[1], var_0[2]);
    var_2 = [];

    foreach(var_4 in var_0) {
      if(!scripts\engine\utility::flag_exist(var_4) || !scripts\engine\utility::flag(var_4))
        var_2[var_2.size] = var_4;
    }

    if(var_2.size == 1) {
      var_6 = 0.8;

      if(var_2[0] == "missileboatscomplete_vo_finished")
        thread _id_10AE::_id_CE80(::_id_B884, 0, var_6);
      else
        thread _id_10AE::_id_CE80(::_id_C077, 0, var_6);

      break;
    }

    wait 0.05;
  }

  scripts\engine\utility::flag_wait("missileboatscomplete_vo_finished");
  scripts\engine\utility::flag_wait("skelterscomplete_vo_finished");
  scripts\engine\utility::flag_wait("acescomplete_vo_finished");
}

_id_10CAE() {
  var_0 = getEnt("player_jackal", "targetname");
  _id_0BDC::_id_10CD1(var_0);
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_6EEB();
  thread _id_10AE::_id_E3B6(1);

  if(getdvarint("ja_skip_preload", 0) == 0)
    level thread scripts\sp\utility::_id_BF97();

  _id_10AE::_id_E3FA("ret_goal2");
}

_id_B20F() {
  while(!isDefined(level._id_E35D))
    wait 0.05;

  scripts\sp\utility::_id_28D7();
  scripts\sp\utility::_id_CF8B();
  scripts\sp\utility::_id_6EEA();
  setmusicstate("");
  scripts\engine\utility::flag_init("mission_complete_vo_done");
  thread _id_10AE::_id_CE81(::_id_B8BD);
  _id_10AE::_id_E3F9();
  scripts\engine\utility::flag_wait("mission_complete_vo_done");
  _id_10AE::_id_E3F8();
  _id_10AE::_id_579D(::_id_A7DA, ::_id_A7D9, ::_id_A82F, ::_id_A7F4);
}

_id_AAA1() {
  scripts\sp\utility::_id_10350("ja_titan_slt_fogsthick");
  scripts\sp\utility::_id_1034D("ja_titan_plr_weshouldbeinrange");
  scripts\sp\utility::_id_10350("ja_titan_eth_markingajaksony");
  scripts\sp\utility::_id_10350("ja_titan_slt_eyesonmultiple");
  scripts\sp\utility::_id_1034D("ja_titan_plr_cleartoengageli");
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_6EEB();
}

_id_B885() {
  scripts\engine\utility::flag_wait("missileboats3_left");
  wait 2.5;
  _id_10AE::_id_1350F();
  scripts\sp\utility::_id_10350("ja_titan_eth_3ajaksstillinth");
  _id_10AE::_id_134D1();
  scripts\engine\utility::flag_wait("missileboats2_left");
  scripts\engine\utility::flag_wait("missileboats1_left");
  wait 2.5;
  _id_10AE::_id_1350F();
  scripts\sp\utility::_id_10350("ja_titan_eth_oneajakremainin");
  _id_10AE::_id_134D1();
}

_id_EAAE() {
  scripts\sp\utility::_id_10350("ja_titan_slt_oneajakupin");
  scripts\sp\utility::_id_1034D("ja_titan_plr_niceonefever");
  scripts\sp\utility::_id_10350("ja_titan_eth_2moreajaks");
}

_id_B881() {
  scripts\sp\utility::_id_10350("ja_titan_eth_allenemyajaksdi");
}

_id_10235() {
  scripts\sp\utility::_id_10350("ja_titan_eth_setdefskeltersi");
  scripts\sp\utility::_id_1034D("ja_titan_plr_salt");
  scripts\sp\utility::_id_10350("ja_titan_slt_confirmedskeltersincomg");
  scripts\sp\utility::_id_1034D("ja_titan_plr_rogletsclearemo");
}

_id_10237() {
  scripts\sp\utility::_id_10350("ja_titan_eth_allskeltersacco");

  if(scripts\engine\utility::flag_exist("acescomplete") && !scripts\engine\utility::flag("acescomplete"))
    scripts\sp\utility::_id_10350("ja_titan_eth_acesarestillout");
}

_id_1562() {
  scripts\engine\utility::flag_wait("aces1_left");
  wait 1.7;
  _id_10AE::_id_1350F();
  scripts\sp\utility::_id_1034D("ja_titan_plr_oneacedownonemo");
  _id_10AE::_id_134D1();
}

_id_155E() {
  scripts\sp\utility::_id_10350("ja_titan_eth_moresetdefinbou");
  scripts\sp\utility::_id_1034D("ja_titan_plr_copythat");
  scripts\sp\utility::_id_10350("ja_titan_slt_welcomingparty");
  scripts\sp\utility::_id_1034D("ja_titan_plr_letsintroduce");
  scripts\sp\utility::_id_10350("ja_titan_slt_wherearemymanners");
}

_id_155F() {
  scripts\sp\utility::_id_10350("ja_titan_slt_secondaceistoast");
  scripts\sp\utility::_id_1034D("ja_titan_plr_ethanweclear");
  scripts\sp\utility::_id_10350("ja_titan_eth_allenemyaceseli");
}

_id_B884() {
  if(scripts\engine\utility::flag_exist("missileboatscomplete") && scripts\engine\utility::flag("missileboatscomplete") && scripts\engine\utility::flag_exist("skelterscomplete") && scripts\engine\utility::flag("skelterscomplete") && scripts\engine\utility::flag_exist("acescomplete") && scripts\engine\utility::flag("acescomplete")) {
    return;
  }
  scripts\sp\utility::_id_1034D("ja_titan_plr_enemiesstillint");
  scripts\sp\utility::_id_10350("ja_titan_slt_igotoneoftheaja");
}

_id_C077() {
  if(scripts\engine\utility::flag_exist("missileboatscomplete") && scripts\engine\utility::flag("missileboatscomplete") && scripts\engine\utility::flag_exist("skelterscomplete") && scripts\engine\utility::flag("skelterscomplete") && scripts\engine\utility::flag_exist("acescomplete") && scripts\engine\utility::flag("acescomplete")) {
    return;
  }
  scripts\sp\utility::_id_1034D("ja_titan_plr_enemiesstillint");
}

_id_B8BD() {
  scripts\sp\utility::_id_10350("ja_titan_slt_wereclearsecure");
  scripts\sp\utility::_id_10350("ja_titan_eth_allinadayswork");
  scripts\sp\utility::_id_1034D("ja_titan_plr_goodworkscarshe");
  scripts\engine\utility::flag_set("mission_complete_vo_done");
  scripts\sp\utility::_id_10350("ja_titan_eth_towerisreadyfor");
}

_id_A7DA() {
  level endon("ja_vo_interrupt");
  scripts\sp\utility::_id_1034D("ja_titan_plr_retributionthis");
  scripts\sp\utility::_id_10350("ja_titan_amb_rogerjackalsare");
  scripts\sp\utility::_id_1034D("ja_titan_plr_towerthisis11");
  scripts\sp\utility::_id_10350("ja_titan_slt_12unbound");
}

_id_A7D9() {
  level endon("ja_vo_interrupt");
  scripts\sp\utility::_id_1034D("ja_titan_plr_retributionthis");
}

_id_A82F() {
  level endon("ja_vo_interrupt");
  scripts\sp\utility::_id_10350("ja_titan_amb_lineupfordrone");
  scripts\sp\utility::_id_1034D("ja_titan_plr_gearsoutforbaton");
}

_id_A7F4() {
  level endon("ja_vo_interrupt");
  scripts\sp\utility::_id_10350("ja_titan_amb_lockisgood11");
}