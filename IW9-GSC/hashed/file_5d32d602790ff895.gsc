/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5d32d602790ff895.gsc
***********************************************/

main() {
  _id_1CFEA9FD23EE5416::main();
  _id_3E059A30E20B0CAE::main();
  _id_0DC559D5A05DC474::main();
  scripts\cp_mp\utility\game_utility::registernightmap();
  scripts\cp_mp\utility\game_utility::_id_67C053F33E4F21A1();
  _id_60DB8D4D6C0719A2();
  scripts\mp\load::main();
  scripts\mp\utility\player::overridevisionsetnightforlevel("iw9_mp_nvg_base_color");
  _id_40C107A7CB7AC462();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  level.outofboundstriggers[level.outofboundstriggers.size] = getEnt("OutOfBounds2", "targetname");
  level._id_057B13482577DD10 = _func_F159C10D5CF8F0B4("dcover_invalid_noent", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_oilfield_6v6");
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.music_style = "middle_east";
  thread scripts\mp\animation_suite::animationsuite();
  level thread _id_D9F84068CD75CA89();
  _id_B2F8F087CEB71FEA();
}

_id_60DB8D4D6C0719A2() {
  _id_44D0EF7925078979 = getEntArray("trigger_hurt", "classname");

  foreach(trig in _id_44D0EF7925078979) {
    if(isDefined(trig.dmg) && trig.dmg == 2) {
      trig.dmg = 20;
      trig thread _id_ADBA4585CF5ABB91();
    }
  }
}

_id_ADBA4585CF5ABB91() {
  interval = 1;
  _id_6F23DE6F51723774 = self.origin;

  for(;;) {
    self waittill("trigger");
    self triggerdisable();
    wait(interval);
    self triggerenable();
  }
}

_id_B2F8F087CEB71FEA() {
  _id_45428B56EF07EA91 = spawn("script_model", (-3654, 6058, 264));
  _id_45428B56EF07EA91 setModel("storage_cardboard_box_large_01");
  _id_45428B56EF07EA91.angles = (0, 266, 0);
  _id_AF5DF9A502E8811A = spawn("script_model", (-3630, 6002, 264));
  _id_AF5DF9A502E8811A setModel("storage_cardboard_box_large_01");
  _id_AF5DF9A502E8811A.angles = (0, 93, 0);
  scripts\mp\equipment\tactical_cover::_id_D147E0986E29DD8D((-2655, 4970, 303), 60, 96);
  scripts\mp\equipment\tactical_cover::_id_D147E0986E29DD8D((-2651, 5058, 303), 56, 96);
  scripts\mp\equipment\tactical_cover::_id_D147E0986E29DD8D((-2651, 5140, 303), 54, 96);
  scripts\mp\equipment\tactical_cover::_id_D147E0986E29DD8D((-2883, 4950, 303), 54, 96);
  scripts\mp\equipment\tactical_cover::_id_D147E0986E29DD8D((2040, 6600, 308), 52, 96);
  scripts\mp\equipment\tactical_cover::_id_D147E0986E29DD8D((2040, 6530, 308), 52, 96);
}

_id_40C107A7CB7AC462() {
  _id_A6A93E193F358641 = (4736, 2944, 256);
  _id_2A8E86DE37268098 = (-5248, 8576, 256);
  _id_F5AA3B29E75AD829 = getEntArray("minimap_corner", "targetname");

  if(_id_F5AA3B29E75AD829.size > 0 && (_id_F5AA3B29E75AD829[0].origin == _id_A6A93E193F358641 || _id_F5AA3B29E75AD829[0].origin == _id_2A8E86DE37268098)) {
    return;
  }
  foreach(index, _id_4E6D9BE609009734 in _id_F5AA3B29E75AD829) {
    if(index == 0) {
      _id_4E6D9BE609009734.origin = _id_A6A93E193F358641;
      continue;
    }

    if(index == 1) {
      _id_4E6D9BE609009734.origin = _id_2A8E86DE37268098;
      continue;
    }

    _id_4E6D9BE609009734 delete();
  }
}

_id_D9F84068CD75CA89() {
  level._id_5AB515A97EA2A880 = _func_F159C10D5CF8F0B4("motion_light_trig", "targetname");

  if(level._id_5AB515A97EA2A880.size == 0) {
    return;
  }
  level._id_24F81C9E5DBADB61 = ["main_warehouse_interior_west", "main_warehouse_interior_east", "main_warehouse_interior_upper"];
  level._id_085F074821C98BDD = ["office_05_interior", "office_02_interior", "office_05_exterior", "office_02_exterior"];
  wait 2;

  foreach(_id_D596B9CFFB652EF6 in level._id_5AB515A97EA2A880)
  _id_D596B9CFFB652EF6 thread _id_D1566A936A2FEC73();
}

_id_D1566A936A2FEC73() {
  _id_D596B9CFFB652EF6 = self;
  _id_24C429FC65683F9F = getscriptablearray(_id_D596B9CFFB652EF6.target, "targetname");

  if(isDefined(_id_D596B9CFFB652EF6.script_noteworthy)) {
    if(scripts\engine\utility::array_contains(level._id_24F81C9E5DBADB61, _id_D596B9CFFB652EF6.script_noteworthy)) {
      foreach(_id_ABBC68933EEC5493 in _id_24C429FC65683F9F)
      _id_ABBC68933EEC5493 setscriptablepartstate("onoff", "on");

      return;
    }

    if(scripts\engine\utility::array_contains(level._id_085F074821C98BDD, _id_D596B9CFFB652EF6.script_noteworthy))
      return;
  }

  foreach(_id_ABBC68933EEC5493 in _id_24C429FC65683F9F)
  _id_ABBC68933EEC5493 setscriptablepartstate("onoff", "off");

  for(;;) {
    _id_D596B9CFFB652EF6 waittill("trigger", ent);

    if(!isDefined(ent))
      continue;
    else if(isDefined(ent._id_C2578B7A679EDC2F) && ent._id_C2578B7A679EDC2F == _id_D596B9CFFB652EF6)
      continue;
    else
      _id_D596B9CFFB652EF6 thread _id_2A92DC385AA005AD(ent, _id_24C429FC65683F9F);
  }
}

_id_2A92DC385AA005AD(ent, _id_24C429FC65683F9F) {
  ent._id_C2578B7A679EDC2F = self;
  _id_598C2E1EED395BC2 = 0.15;
  _id_F85CE754D0A9DB78 = 0.3;
  wait(_id_598C2E1EED395BC2);
  _id_C19143F66473517E = 0;

  if(isDefined(ent)) {
    if(isPlayer(ent)) {
      stance = ent getstance();
      player_speed = length(ent getvelocity());

      if(player_speed >= 110 || ent isinfreefall() || ent isskydiving() || ent issprintsliding())
        _id_C19143F66473517E = 1;
      else if(stance == "stand" && player_speed >= 80 && !ent ismantling())
        _id_C19143F66473517E = 1;
      else
        _id_C19143F66473517E = 0;
    } else if(isDefined(ent.tanktype) && ent.tanktype == "remote_tank") {
      _id_2153DD90E248BFC6 = ent vehicle_gettopspeedforward() / 2;
      _id_606CBFA571315301 = ent vehicle_getspeed();

      if(_id_606CBFA571315301 > _id_2153DD90E248BFC6)
        _id_C19143F66473517E = 1;
    }
  }

  if(_id_C19143F66473517E) {
    foreach(_id_ABBC68933EEC5493 in _id_24C429FC65683F9F) {
      state = _id_ABBC68933EEC5493 getscriptablepartstate("onoff");

      if(state == "dead") {
        continue;
      }
      _id_ABBC68933EEC5493 thread _id_06C39C625C831278(state);
    }

    wait(_id_F85CE754D0A9DB78);
  }

  if(isDefined(ent))
    ent._id_C2578B7A679EDC2F = undefined;
}

_id_06C39C625C831278(current_state) {
  _id_ABBC68933EEC5493 = self;
  _id_ABBC68933EEC5493 notify("motion_light_on");
  _id_ABBC68933EEC5493 endon("motion_light_on");

  if(!isDefined(current_state))
    current_state = _id_ABBC68933EEC5493 getscriptablepartstate("onoff");

  if(current_state == "off") {
    wait(randomfloatrange(0.1, 0.4));
    _id_ABBC68933EEC5493 setscriptablepartstate("onoff", "on");
  }

  wait 6;
  state = _id_ABBC68933EEC5493 getscriptablepartstate("onoff");

  if(state == "dead") {
    return;
  }
  _id_ABBC68933EEC5493 setscriptablepartstate("onoff", "off");
}