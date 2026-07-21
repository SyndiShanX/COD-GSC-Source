/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_kidnapper.gsc
***********************************************/

init_kidnapper_combat_loop() {
  return;
  init_anims();
  registerkidnapperspawnmod();
  scripts\engine\utility::flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");

  if(getdvarint("_encstr_84322006A30B2E2F144258195AACC9C09F580FF52A17504DFCFB98E0C2C9D779D7E4", 0) <= 0)
    wait(randomfloatrange(20, 40));

  level.cp_kidnappers_active = 1;
  level thread kidnapper_monitor();
}

kidnapper_monitor() {
  wait 30;

  for(;;) {
    if(!istrue(level.cp_kidnappers_active) || getdvarint("_encstr_B87D167F1AB2C89A1A2669FA98E59917F77BFD1AE3671F62", 0) > 0) {
      wait 1;
      continue;
    }

    var_0 = getvulnerableplayersinteam("_encstr_9A8507BA4040188D08");

    if(isDefined(var_0) && var_0.size > 0) {
      var_1 = var_0[randomint(var_0.size)];
      level thread spawn_kidnapper_for_player(var_1);
    }

    level scripts\engine\utility::waittill_notify_or_timeout("_encstr_ACC414C17BDF33E0012DCE0343AF3307C1889BEA2D54", 40);
    wait(randomfloatrange(20, 40));
    wait 1;
  }
}

registerkidnapperspawnmod() {
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  var_0 = scripts\cp\cp_modular_spawning::registerambientgroup;
  [[var_0]]("_encstr_8B650D8D07AF5BD2C89B853807CAC9", 1, 1, 1, 0.5, undefined, ::getspawnerstructbehindcurplayer, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8B650D8D07AF5BD2C89B853807CAC9", ::kidnapper_after_spawn_func);
}

getspawnerstructbehindcurplayer(var_0) {
  if(isDefined(level.curplayertohavekidnapperspawned))
    var_1 = level.curplayertohavekidnapperspawned;
  else
    return undefined;

  var_2 = createspawnerstructbehindplayer(var_1);
  var_2.script_forcespawn = 1;
  return var_2;
}

kidnapper_after_spawn_func(var_0) {
  waitframe();
  level notify("_encstr_B40B15E64927C211ABCD895FC1B5EA9888630EB038ADFD", self);
}

spawn_kidnapper_for_player(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.curplayertohavekidnapperspawned = var_0;
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8B650D8D07AF5BD2C89B853807CAC9");
  level waittill("_encstr_B40B15E64927C211ABCD895FC1B5EA9888630EB038ADFD", var_1);
  var_2 = var_1;

  if(!isDefined(var_2)) {
    return;
  }
  var_0 playsoundtoplayer("_encstr_999728C531F8FDC2206107D7BB55AA2730DEFC8D28C085390E490FFBE7067264C0E172D786D040F2E651", var_0);
  var_2.drawoncompass = 1;
  var_0.being_hunted_by_kidnapper = 1;
  var_2.maxfaceenemydist = 768;
  var_2.dontevershoot = 1;
  var_2.ignoreall = 1;
  var_2.maxhealth = 250;
  var_2.health = var_2.maxhealth;
  var_2.wearing_armor = 1;
  var_2 scripts\engine\utility::set_movement_speed(200);
  var_2 getenemyinfo(var_0);
  var_2 scripts\cp\cp_modular_spawning::set_character_models("_encstr_97D01482D869C0E7B9B9D7F1C7E3E74D8BC13FE90B1D", "_encstr_AA381240E320374F87B0B15B7965EF6D882FC1C2");
  var_2.a.disablelongdeath = 1;
  var_2.tripledefenderkill = 1;
  var_2 thread get_to_target_player(var_2, var_0);
  var_2 thread watch_for_kidnapper_death(var_2, var_0);
  var_2 thread _id_14464(var_2, var_0);
  var_2 thread player_see_me_monitor(var_2, var_0);
  var_2 thread kidnapper_toggle_monitor(var_2, var_0);
  level notify("_encstr_9A86209AA0D90881B0D39E1BB32F5637A31B47738B117921B25A104879C292B71D13");
}

get_to_target_player(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.goalradius = 40;

  while(1 && isDefined(var_1) && isalive(var_1)) {
    var_0.disablearrivals = 1;
    var_0 setgoalpos(var_1.origin);

    if(distancesquared(var_0.origin, var_1.origin) <= 2500) {
      break;
    }

    waitframe();
  }

  if(ishuntedplayerabletobekidnapped(var_1) || getdvarint("_encstr_AF5618E7636201CD67DB6B36626F8DC0FEE869B31A814818BFD2", 0) > 0)
    var_0 thread manageminigunpickup(var_0, var_1);
  else {
    turnkidnappertonormalai(var_0);

    if(isDefined(var_1))
      var_1.being_hunted_by_kidnapper = 0;
  }
}

manageminigunpickup(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_A9601ED6B423E6B0C13856397D3AABC937AC32BEA3EDBEDCED4EDA0B63BE585A");
  var_1 disableusability();
  var_1 allowcrouch(0);
  var_1.lasttimekidnapped = gettime();
  var_0 scripts\engine\utility::set_movement_speed(0);
  var_0.health = 99999;
  var_0 thread _id_12B51(var_0, var_1, 100);
  var_0 thread release_player_on_death(var_0, var_1);
  var_0.restoreweapon = var_0._id_1237E;
  var_0 takeweapon(var_0.weapon);
  var_0 thread _id_13650(var_0);

  if(getdvarint("_encstr_A13718D73A13B9E1B89ADB681BB4A92B4E870825D8F8A3E80FC5", 0) >= 1)
    var_0 thread issameteamagent(var_0);

  screen_fade_to_black(var_1);
  var_1 cameraset("_encstr_ADF219108F65A9E5EA215E5D02931710EF1F9390D714A65DD1D6CF");
  var_0 thread lootleaderoneperteam(var_0, var_1);
  var_0 notify("_encstr_863F10E7D72235A0798DF1CE325448F30AA3");
  var_1 notify("_encstr_838B0E86EF226D41F76F30801BF5D9A1");
  wait 1;
  screen_fade_back_to_normal(var_1);
  createobjectiveicon(var_1);

  if(!isDefined(var_1.times_kidnapped))
    var_1.times_kidnapped = 1;
  else
    var_1.times_kidnapped++;

  scripts\cp\cp_analytics::_id_119B4(var_1, 1.8);
  var_0 waittill("_encstr_B4DA19D4BBD9F27913D9E7A7B0EB35BAAFC5514E1063CB8C59A8B7");

  if(isDefined(var_1.restoreweapon))
    var_1 switchtoweapon(var_1.restoreweapon);

  killkidnappedplayer(var_1, var_0);

  if(isDefined(var_0._id_12F89))
    var_0._id_12F89 delete();

  var_1 notify("_encstr_BE840BF2FFD8B0A4DB6EE31FA1");
  var_1 enableusability();
  var_1 allowcrouch(1);
  var_1 cameradefault();

  if(isDefined(var_0.restoreweapon))
    var_0 giveweapon(var_0.restoreweapon);

  level notify("_encstr_ACC414C17BDF33E0012DCE0343AF3307C1889BEA2D54");
  thread turnkidnappertonormalai(var_0);
}

turnkidnappertonormalai(var_0) {
  var_0.dontevershoot = 0;
  var_0.ignoreall = 0;
  var_0 scripts\engine\utility::set_movement_speed(300);
  var_0.scripted_mode = 0;
  var_0 scripts\asm\shared\mp\utility::bunkercounteruav();
  var_0.health = 100;
  var_0.tripledefenderkill = 0;
  var_0 notify("_encstr_A9601ED6B423E6B0C13856397D3AABC937AC32BEA3EDBEDCED4EDA0B63BE585A");
}

_id_12D9C(var_0, var_1) {
  var_2 = var_1.player_rig;
  var_2 rotateTo(var_0.angles, 0.2);
  wait 0.2;
  var_1 dontinterpolate();
  var_1 setplayerangles(var_0.angles);
}

_id_12B51(var_0, var_1, var_2) {
  var_0 endon("_encstr_A76A14AD2D19372CE0F5AD5AB163D76EA31639A35646");
  var_0 endon("_encstr_AD75063D571AE108");

  for(var_3 = 0; var_3 < var_2; var_3 = var_3 + var_4)
    var_0 waittill("_encstr_B2BE0788BAF573592F", var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18);

  var_0 lootspawnitemlist(var_1, var_0);
}

release_player_on_death(var_0, var_1) {
  var_0 endon("_encstr_A76A14AD2D19372CE0F5AD5AB163D76EA31639A35646");
  var_0 waittill("_encstr_AD75063D571AE108");
  break_player_out_of_anim(var_1);
}

killkidnappedplayer(var_0, var_1) {
  var_1 notify("_encstr_A76A14AD2D19372CE0F5AD5AB163D76EA31639A35646");
  deleteobjectiveicon(var_0);
  var_0.shouldskiplaststand = 1;
  var_0.shouldskipdeathsshield = 1;
  var_0.islockedinkidnapanim = 0;
  var_0.being_hunted_by_kidnapper = 0;
  screen_fade_to_black(var_0);
  wait 1;
  var_0 dodamage(var_0.maxhealth + 1000, var_0.origin);
  screen_fade_back_to_normal(var_0);
}

screen_fade_to_black(var_0) {
  if(!isDefined(var_0.kidnap_black_screen)) {
    var_0.kidnap_black_screen = newclienthudelem(var_0);
    var_0.kidnap_black_screen.x = 0;
    var_0.kidnap_black_screen.y = 0;
    var_0.kidnap_black_screen setshader("_encstr_83AB065EE1391A7B", 640, 480);
    var_0.kidnap_black_screen.alignx = "_encstr_A5AD056A019C63";
    var_0.kidnap_black_screen.aligny = "_encstr_AC190479FF92";
    var_0.kidnap_black_screen.sort = 1;
    var_0.kidnap_black_screen.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
    var_0.kidnap_black_screen.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
    var_0.kidnap_black_screen.foreground = 1;
  }

  var_0.kidnap_black_screen.alpha = 0;
  var_0.kidnap_black_screen fadeovertime(1);
  var_0.kidnap_black_screen.alpha = 1;
}

screen_fade_back_to_normal(var_0) {
  if(isDefined(var_0.kidnap_black_screen)) {
    var_0.kidnap_black_screen fadeovertime(1);
    var_0.kidnap_black_screen.alpha = 0;
    var_0.kidnap_black_screen destroy();
    var_0.kidnap_black_screen = undefined;
  }
}

player_see_me_monitor(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_863F10E7D72235A0798DF1CE325448F30AA3");
  var_1 endon("_encstr_AD75063D571AE108");

  while(1 && isalive(var_1)) {
    if(var_1 worldpointinreticle_circle(var_0 getEye(), 65, 300) && sighttracepassed(var_0 getEye(), var_1 getEye(), 0, var_0)) {
      break;
    }

    waitframe();
  }

  var_0 scripts\engine\utility::set_movement_speed(300);
  var_1.lasttimesawkidnapper = gettime();
  var_0 notify("_encstr_9A6015439F2857CB093158F1E18BC1F2C1EA587F6770B7");
}

kidnapper_toggle_monitor(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_863F10E7D72235A0798DF1CE325448F30AA3");
  level waittill("_encstr_A99912D618176DA36F9A880893C74DDBBFBFECDC");
  var_1.being_hunted_by_kidnapper = 0;
  thread break_player_out_of_anim(var_1);
  var_0 turnkidnappertonormalai();
}

watch_for_kidnapper_death(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 waittill("_encstr_AD75063D571AE108");
  level notify("_encstr_ACC414C17BDF33E0012DCE0343AF3307C1889BEA2D54");

  if(isDefined(var_1) && var_1 scripts\cp\utility::is_valid_player()) {
    var_1.being_hunted_by_kidnapper = 0;
    deleteobjectiveicon(var_1);
  }
}

_id_14464(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC");
  turnkidnappertonormalai(var_0);
}

sort_players_based_on_previous_kidnap_attempt_time() {
  var_0 = gettime();

  foreach(var_2 in level.players) {
    if(!isDefined(var_2.previous_kidnap_attempt_time))
      var_2.previous_kidnap_attempt_time = 0;
  }

  var_4 = level.players;
  var_5 = var_4.size;

  if(var_5 > 1) {
    for(;;) {
      var_6 = 0;

      for(var_7 = 1; var_7 <= var_5 - 1; var_7++) {
        var_8 = var_4[var_7 - 1];
        var_9 = var_4[var_7];

        if(var_9.previous_kidnap_attempt_time < var_8.previous_kidnap_attempt_time) {
          var_4[var_7 - 1] = var_9;
          var_4[var_7] = var_8;
          var_6 = 1;
        }
      }

      if(var_6 == 0) {
        break;
      }
    }
  }

  return var_4;
}

createspawnerstructbehindplayer(var_0) {
  var_1 = getclosestpointonnavmesh(scripts\cp\utility::get_point_in_local_ent_space(var_0, (-1000, 0, 0)));
  var_2 = spawnStruct();
  var_2.origin = var_1;
  var_2.angles = scripts\engine\utility::ter_op(isDefined(var_0.angles), var_0.angles, (0, 0, 0));
  return var_2;
}

getrandomplayersinteam(var_0) {
  var_1 = scripts\cp\utility::getplayersinteam(var_0);

  if(var_1.size <= 1) {
    if(getdvarint("_encstr_A3D2139BC693AFDA2D919BB0C17D7B37EB9BB78DDB", 0) <= 0)
      return undefined;
    else {
      var_2 = var_1[0];

      if(isDefined(var_2.lasttimekidnapped) && gettime() - var_2.lasttimekidnapped <= 60000 || istrue(var_2.being_hunted_by_kidnapper))
        return undefined;
      else
        return var_1;
    }
  }

  var_3 = [];

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    var_2 = var_1[var_4];

    if(!isalive(var_2) || var_2.inlaststand || istrue(var_2.being_hunted_by_kidnapper)) {
      continue;
    }
    if(isDefined(var_2.lasttimekidnapped) && gettime() - var_2.lasttimekidnapped <= 60000) {
      continue;
    }
    if(randomint(2) > 0)
      var_3[var_3.size] = var_2;
  }

  return var_3;
}

getvulnerableplayersinteam(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = scripts\cp\utility::getplayersinteam(var_0);

  if(var_1.size <= 1) {
    if(getdvarint("_encstr_A3D2139BC693AFDA2D919BB0C17D7B37EB9BB78DDB", 0) <= 0)
      return undefined;
    else {
      var_2 = var_1[0];

      if(isplayerabletobekidnapped(var_2))
        return var_1;
    }
  }

  var_3 = [];
  var_4 = [];

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    var_2 = var_1[var_5];

    if(isplayerabletobekidnapped(var_2)) {
      var_3 = sortbydistance(var_1, var_2.origin);
      var_3 = scripts\engine\utility::array_remove(var_3, var_2);

      if(distance(var_2.origin, var_3[0].origin) > 6000)
        var_4[var_4.size] = var_2;
    }
  }

  return var_4;
}

setimmunetokidnapper(var_0) {
  if(!isPlayer(self)) {
    scripts\engine\utility::error("_encstr_848A333CB750B7C3C554525A3BA83FA3B8478994DD183AFBFD2B7EA281F153A738793716D9B0D6BB9080769B485FFF1FE0E1B56ED9");
    return;
  }

  self.immunetokidnapper = var_0;
}

ishuntedplayerabletobekidnapped(var_0) {
  if(!isDefined(var_0) || !isalive(var_0) || isDefined(var_0.lasttimekidnapped) && gettime() - var_0.lasttimekidnapped <= 60000 || istrue(var_0.inlaststand) || istrue(var_0.fauxdead) || istrue(var_0.binvehicle) || istrue(var_0.immunetokidnapper) || istrue(updateparachutestreamhint(var_0)))
    return 0;
  else
    return 1;
}

isplayerabletobekidnapped(var_0) {
  if(!isDefined(var_0) || !isalive(var_0) || isDefined(var_0.lasttimekidnapped) && gettime() - var_0.lasttimekidnapped <= 60000 || istrue(var_0.being_hunted_by_kidnapper) || istrue(var_0.inlaststand) || istrue(var_0.fauxdead) || istrue(var_0.binvehicle) || istrue(var_0.immunetokidnapper) || istrue(var_0.usinggunship) || istrue(updateparachutestreamhint(var_0)))
    return 0;
  else
    return 1;
}

updateparachutestreamhint(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.currentweapon))
    return 0;

  var_1 = var_0.currentweapon;
  return var_1.basename == "_encstr_979914D35F4122577120938A0EDD6F9B58E7551F8BE0";
}

togglekidnappers(var_0) {
  if(var_0)
    level notify("_encstr_A58B112AD3BFEBF788302173A3FBD3CEA140C5");
  else
    level notify("_encstr_A99912D618176DA36F9A880893C74DDBBFBFECDC");

  level.cp_kidnappers_active = var_0;
}

_id_13A37(var_0) {
  var_0.restoreweapon = var_0 getcurrentweapon();
  var_1 = getcompleteweaponname("_encstr_9A0D0C4B54606F8F63C84B8B53EE");
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1, undefined, undefined, 1);
  var_2 = var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_1, 0);
  var_0.gunlessweapon = var_1;
  var_0 scripts\common\utility::allow_weapon_switch(0);
}

_id_13650(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_1 setModel("_encstr_95792121C36BE62A781DF7D8D3A13BED8150E2E1287759E4C21EEEAB1AFEAAD3B3CB83");
  var_1 linkTo(var_0, "_encstr_91AC11A5C6EA277BF50F837BCB371383322C1D", (0, 0, 0), (0, 0, 0));
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_2 setModel("_encstr_97931EA3144350E6F39AE9F07357A478D1883B67AF6DC0BCB277A65BDAA7D5E0");
  var_2 linkTo(var_1);
  var_0.pistol = var_1;
  var_0._id_1237D = var_2;
  var_0 scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_A76A14AD2D19372CE0F5AD5AB163D76EA31639A35646");
  var_1 delete();
  var_2 delete();
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

lootleaderoneperteam(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_A76A14AD2D19372CE0F5AD5AB163D76EA31639A35646");
  var_1 setstance("_encstr_A5AD069B231F0BAF");
  var_1.islockedinkidnapanim = 1;
  var_0.scripted_mode = 1;
  var_0.ignoreall = 1;
  var_1 thread create_player_rig(var_1, "_encstr_B6230E13600823633A017B33BE45883D");
  var_1 scripts\common\anim::anim_first_frame_solo(var_1.player_rig, "_encstr_8DE10F6D9619730BC1385693EB9DE42CC4");
  var_1.player_rig hide();
  link_player_to_rig(var_1, 0.2);
  _id_12D9C(var_0, var_1);
  var_2 = var_0 scripts\asm\asm::asm_lookupanimfromalias("_encstr_84610D49100897C2DF809A03583BFF", "_encstr_AF761A0B3F1E3F3AB3BA37E758A0BBD785C7E405DDC91F63EBE90F20");
  var_3 = var_0 scripts\asm\asm::asm_getxanim("_encstr_84610D49100897C2DF809A03583BFF", var_2);
  var_4 = getanimlength(%_encstr_B1D51EB107F5A1B76E470BCE954758D6AC9CBED9392C4CF5B08ED1C2D8B5CAC9);
  var_5 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_1.origin);
  var_5.origin = var_1.origin;
  var_5.angles = var_1.angles;
  var_0._id_12F89 = var_5;
  var_6 = getstartorigin(var_5.origin, var_5.angles, var_3);
  var_7 = getstartangles(var_5.origin, var_5.angles, var_3);
  var_1 dontinterpolate();
  var_1 setplayerangles(var_7);
  var_1 setOrigin(var_6);
  var_5 thread scripts\cp\cp_anim::anim_player_solo(var_1, var_1.player_rig, "_encstr_8DE10F6D9619730BC1385693EB9DE42CC4");
  var_0 scripts\asm\shared\mp\utility::burningpartlogic("_encstr_AF761A0B3F1E3F3AB3BA37E758A0BBD785C7E405DDC91F63EBE90F20", var_5, undefined, 1);
  wait(var_4 / 2);
  thread _id_13A37(var_1);
  wait(var_4 / 2);
  var_2 = var_0 scripts\asm\asm::asm_lookupanimfromalias("_encstr_84610D49100897C2DF809A03583BFF", "_encstr_8F6C16C6C1BE5BD28CB985C1C1CAE4AF6E5D8932575A9BEC");
  var_3 = var_0 scripts\asm\asm::asm_getxanim("_encstr_84610D49100897C2DF809A03583BFF", var_2);
  var_4 = getanimlength(%_encstr_88E11CB73F769B3778242F4807CDC347912ADE11459983BF18B84BD0D01D);
  var_6 = getstartorigin(var_5.origin, var_5.angles, var_3);
  var_7 = getstartangles(var_5.origin, var_5.angles, var_3);
  var_0 forceteleport(var_6, var_7);
  var_1 setplayerangles(var_7);
  var_1 setOrigin(var_6);
  var_5 scripts\common\anim::anim_first_frame_solo(var_1.player_rig, "_encstr_B487131F639D4AC92093CF126EE0054265A39F93D7");
  var_8 = gettime() + 15000;

  while(gettime() < var_8) {
    var_1 dontinterpolate();
    var_1 setplayerangles(var_7);
    var_1 setOrigin(var_6);
    var_5 thread scripts\cp\cp_anim::anim_player_solo(var_1, var_1.player_rig, "_encstr_B487131F639D4AC92093CF126EE0054265A39F93D7");
    var_0 scripts\asm\shared\mp\utility::burningpartlogic("_encstr_8F6C16C6C1BE5BD28CB985C1C1CAE4AF6E5D8932575A9BEC", var_5, undefined, 1);
    wait(var_4);
  }

  var_2 = var_0 scripts\asm\asm::asm_lookupanimfromalias("_encstr_84610D49100897C2DF809A03583BFF", "_encstr_8A3D1527231152A0946DD10B127DB0806AAB93AFAFCB2D");
  var_3 = var_0 scripts\asm\asm::asm_getxanim("_encstr_84610D49100897C2DF809A03583BFF", var_2);
  var_4 = getanimlength(%_encstr_AA1A203607EB43EDE64716D959A3C25BAC39D7E42B37C6EAB27D2CE8A316D86DB29C);
  var_6 = getstartorigin(var_5.origin, var_5.angles, var_3);
  var_7 = getstartangles(var_5.origin, var_5.angles, var_3);
  var_1 dontinterpolate();
  var_1 setplayerangles(var_7);
  var_1 setOrigin(var_6);
  var_5 thread scripts\cp\cp_anim::anim_player_solo(var_1, var_1.player_rig, "_encstr_9164141354131D2A4869577AC950635D8E3FD357AF30");
  var_0 scripts\asm\shared\mp\utility::burningpartlogic("_encstr_8A3D1527231152A0946DD10B127DB0806AAB93AFAFCB2D", var_5, undefined, 1);
  wait(var_4);
  var_5 delete();

  if(isDefined(var_1.set_tank_target_player))
    var_1 scripts\cp\cp_weapons::_takeweapon(var_1.set_tank_target_player);

  var_0 notify("_encstr_B4DA19D4BBD9F27913D9E7A7B0EB35BAAFC5514E1063CB8C59A8B7");
}

#using_animtree("_encstr_B40101");

lootspawnitemlist(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1.scripted_mode = 1;
  var_1.ignoreall = 1;
  var_2 = var_1 scripts\asm\asm::asm_lookupanimfromalias("_encstr_84610D49100897C2DF809A03583BFF", "_encstr_8A36137778166B92C1384E021FFB1B17D948F753D0");
  var_3 = var_1 scripts\asm\asm::asm_getxanim("_encstr_84610D49100897C2DF809A03583BFF", var_2);
  var_4 = getanimlength(%_encstr_96D81F1B0EEBD0DE9B1D85B359470BB65927EB19950B8E34FA583A1D858D6D9593);
  var_5 = var_1._id_12F89;
  var_5.origin = var_0.origin;
  var_5.angles = var_0.angles;
  var_1._id_12F89 = var_5;
  var_6 = getstartorigin(var_5.origin, var_5.angles, var_3);
  var_7 = getstartangles(var_5.origin, var_5.angles, var_3);
  var_0 dontinterpolate();
  var_0 setplayerangles(var_7);
  var_0 setOrigin(var_6);
  var_5 thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, "_encstr_8C6110B6D2469BB00E38B227D7195985A343");
  var_1 scripts\asm\shared\mp\utility::burningpartlogic("_encstr_8A36137778166B92C1384E021FFB1B17D948F753D0", var_5, undefined, 1);
  wait(var_4);
  var_1 suicide();
  var_5 delete();
  break_player_out_of_anim();
}

break_player_out_of_anim(var_0) {
  if(istrue(var_0.islockedinkidnapanim)) {
    var_0 freezecontrols(0);
    var_0 enableusability();
    var_0 allowcrouch(1);
    var_0 cameradefault();
    var_0 notify("_encstr_BE840BF2FFD8B0A4DB6EE31FA1");
    var_0 stopanimscriptsceneevent();
    var_0.islockedinkidnapanim = 0;

    if(isDefined(var_0.set_tank_target_player))
      var_0 scripts\cp\cp_weapons::_takeweapon(var_0.set_tank_target_player);

    if(isDefined(var_0.restoreweapon))
      var_0 switchtoweapon(var_0.restoreweapon);
  }

  screen_fade_back_to_normal(var_0);
}

#using_animtree("_encstr_B40101");

create_player_rig(var_0, var_1, var_2) {
  if(!isDefined(var_0) || isDefined(var_0.player_rig)) {
    return;
  }
  var_0.animname = var_1;

  if(!isDefined(var_2))
    var_2 = "_encstr_A7C813BBBC6B7C6BBB68413B5883D623473903130A";

  var_0 predictstreampos(var_0.origin);
  var_3 = spawn("_encstr_BEFE0C2FAB5A88876B4181EB4A5F", var_0.origin, 0, 0, var_0);
  var_3.player = var_0;
  var_0.player_rig = var_3;
  var_0.player_rig hide();
  var_0.player_rig.animname = var_1;
  var_0.player_rig useanimtree(#animtree);
  var_0.player_rig.angles = scripts\engine\utility::ter_op(isDefined(var_0.angles), var_0.angles, (0, 0, 0));
  var_0 watch_remove_rig();
  remove_player_rig(var_0);
}

watch_remove_rig(var_0) {
  scripts\engine\utility::_id_143A6("_encstr_BE840BF2FFD8B0A4DB6EE31FA1", "_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC");
}

remove_player_rig(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.player_rig)) {
    return;
  }
  var_0 unlink();
  var_1 = var_0 getdroptofloorposition(var_0.origin);

  if(isDefined(var_1))
    var_0 setOrigin(var_1);
  else
    var_0 setOrigin(var_0.origin + (0, 0, 100));

  var_0.player_rig delete();
  var_0.player_rig = undefined;
}

link_player_to_rig(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(var_0) || !isDefined(var_0.player_rig)) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 0.2;

  var_0 playerlinktoblend(var_0.player_rig, "_encstr_8E010B996FB7B6B3C1D1183343", var_1, 0.25, 0.25);
  wait(var_1);
  var_0 playerlinktodelta(var_0.player_rig, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 0, 0, 0, 0, 0, 1, 1);
}

createobjectiveicon(var_0) {
  var_0.kidnap_wid = scripts\cp\cp_objectives::requestworldid(var_0.name + "_encstr_BD5C0B3F18682CAA936F423F56");
  objective_setplayintro(var_0.kidnap_wid, 0);
  objective_setplayoutro(var_0.kidnap_wid, 0);
  objective_state(var_0.kidnap_wid, "_encstr_AF5A081BBAC993AC73A3");
  objective_icon(var_0.kidnap_wid, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_setbackground(var_0.kidnap_wid, 1);
  objective_onentity(var_0.kidnap_wid, var_0);
  objective_setlabel(var_0.kidnap_wid, &"_encstr_AC8A1887E75FE89848193BB1304B0D69889BDFF168319FD1696C");
}

deleteobjectiveicon(var_0) {
  if(!isDefined(var_0.kidnap_wid)) {
    return;
  }
  objective_delete(var_0.kidnap_wid);
  scripts\cp\cp_objectives::freeworldid(var_0.name + "_encstr_BD5C0B3F18682CAA936F423F56");
  var_0.kidnap_wid = undefined;
}

enteredvehicle(var_0, var_1) {
  var_1 setimmunetokidnapper(1);
}

exitedvehicle(var_0, var_1) {
  var_1 setimmunetokidnapper(0);
}

init_relic_martyrdom() {
  var_0 = "_encstr_B4E2658C2BEC3B57B4BE1B5B1910881A1440115989D5CED119085E105AD2469B2C1C3856E401E5019A0758DD3796A5C87358831C2B39444044B995A304DCD15827A3AFD62D8CE6581C0EB24EEB91CA98AE9D80370EC2BB73025A10D6A532E6850E0759C9448005";
  scripts\cp\utility::addentrytodevgui(var_0);
}

vehomn_showcontrols(var_0) {
  var_1 = strtok(var_0, "_encstr_BA4C02DF");
  var_2 = level.players[0];

  switch (var_1[0]) {
    case "_encstr_8E8A06F7D987435E":
    default:
      spawn_kidnapper_for_player(var_2);
      break;
  }

  waitframe();
  setDvar("_encstr_B17E16602B99BB19193C6BE555D259A3C55B7950F73293E7", "_encstr_B40101");
}

issameteamagent(var_0) {
  wait 7;
  var_0 dodamage(200, var_0.origin, var_0, var_0, "_encstr_AB590C99ED78875F650F3951034D");
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

init_anims() {
  level.scr_animtree["_encstr_B6230E13600823633A017B33BE45883D"] = #animtree;
  level.scr_anim["_encstr_B6230E13600823633A017B33BE45883D"]["_encstr_B487131F639D4AC92093CF126EE0054265A39F93D7"] = % _encstr_88E11CB73F769B3778242F4807CDC347912ADE11459983BF18B84BD0D01D;
  level.scr_animname["_encstr_B6230E13600823633A017B33BE45883D"]["_encstr_B487131F639D4AC92093CF126EE0054265A39F93D7"] = "_encstr_88E11CB73F769B3778242F4807CDC347912ADE11459983BF18B84BD0D01D";
  level.scr_eventanim["_encstr_B6230E13600823633A017B33BE45883D"]["_encstr_B487131F639D4AC92093CF126EE0054265A39F93D7"] = "_encstr_B487131F639D4AC92093CF126EE0054265A39F93D7";
  level.scr_anim["_encstr_B6230E13600823633A017B33BE45883D"]["_encstr_8DE10F6D9619730BC1385693EB9DE42CC4"] = % _encstr_BD291C315B276328923C83F7553B10BA97D30E39E337AE71EB098FD971A5;
  level.scr_animname["_encstr_B6230E13600823633A017B33BE45883D"]["_encstr_8DE10F6D9619730BC1385693EB9DE42CC4"] = "_encstr_BD291C315B276328923C83F7553B10BA97D30E39E337AE71EB098FD971A5";
  level.scr_eventanim["_encstr_B6230E13600823633A017B33BE45883D"]["_encstr_8DE10F6D9619730BC1385693EB9DE42CC4"] = "_encstr_8A591269037F4AB0EF9E2B01A897501837BBA131";
  level.scr_anim["_encstr_B6230E13600823633A017B33BE45883D"]["_encstr_9164141354131D2A4869577AC950635D8E3FD357AF30"] = % _encstr_AC321E809B49714867C4070CAD03F13FAF23E9B0629A9FC317C79473832B38EB;
  level.scr_animname["_encstr_B6230E13600823633A017B33BE45883D"]["_encstr_9164141354131D2A4869577AC950635D8E3FD357AF30"] = "_encstr_AC321E809B49714867C4070CAD03F13FAF23E9B0629A9FC317C79473832B38EB";
  level.scr_eventanim["_encstr_B6230E13600823633A017B33BE45883D"]["_encstr_9164141354131D2A4869577AC950635D8E3FD357AF30"] = "_encstr_B18D175698978023EF1A08881347CDDED728EDDEF543886517";
  level.scr_anim["_encstr_B6230E13600823633A017B33BE45883D"]["_encstr_8C6110B6D2469BB00E38B227D7195985A343"] = % _encstr_B2D91D7A3BF7BB8787D919074B13D7F8E8D87948D5C66450E97B3B26FB0853;
  level.scr_animname["_encstr_B6230E13600823633A017B33BE45883D"]["_encstr_8C6110B6D2469BB00E38B227D7195985A343"] = "_encstr_B2D91D7A3BF7BB8787D919074B13D7F8E8D87948D5C66450E97B3B26FB0853";
  level.scr_eventanim["_encstr_B6230E13600823633A017B33BE45883D"]["_encstr_8C6110B6D2469BB00E38B227D7195985A343"] = "_encstr_8A36137778166B92C1384E021FFB1B17D948F753D0";
}