/**********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_assassination\sa_assassination_util.gsc
**********************************************************************/

_id_8951(var_0, var_1) {
  var_2 = 3;
  scripts\engine\utility::flag_wait(var_0);

  switch (var_1) {
    case "barracks":
      level._id_E99E["trig_barracks_door_exit"] _id_0F05::_id_AED6(0);
      wait(var_2);
      _id_40B9("sa_barracks_vol");
      break;
    case "hub_stern":
      level._id_E99E["trig_door_to_armory"] _id_0F05::_id_AED6(0);
      wait(var_2);
      _id_40B9("sa_hubstern_vol");
      break;
    case "armory":
      level._id_E99E["trig_armory_door_exit"] _id_0F05::_id_AED6(0);
      wait(var_2);
      _id_40B9("sa_armory_room_vol");
      level notify("armory_crate_cleanup");
      break;
    case "hub_bow":
      level._id_E99E["trig_door_to_conf_hall"] _id_0F05::_id_AED6(0);
      wait(var_2);
      _id_40B9("sa_hubbow_vol");
      break;
    case "conf_room":
      level._id_E99E["trig_door_to_conf_hall"] _id_0F05::_id_AED6(0);
      wait(var_2);
      _id_40B9("sa_bowupper_roomb_vol");
      break;
    case "conf_hallway":
      _id_40B9("sac_bowupper_vol");
      break;
  }
}

_id_40B9(var_0) {
  _id_0F0C::_id_E9D1(var_0, "cleared");
  level notify("cleaned_up_" + var_0);
  var_0 = getEnt(var_0, "targetname");
  var_1 = var_0 scripts\sp\utility::_id_77E3("axis");

  foreach(var_3 in var_1) {
    if(isDefined(var_3))
      var_3 delete();
  }
}

_id_4127() {
  _id_0F0C::_id_E9D1("sa_hubbow_vol", "cleared");
  _id_0F0C::_id_E9D1("sa_hubstern_vol", "cleared");
  _id_0F0C::_id_E9D1("sa_armory_room_vol", "cleared");
  _id_0F0C::_id_E9D1("sa_starboard_lower_vol", "cleared");
  _id_0F0C::_id_E9D1("sa_starboard_lower_rooma_vol", "cleared");
  _id_0F0C::_id_E9D1("sac_bowupper_vol", "cleared");
  var_0 = getEnt("sac_bowupper_vol", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_77E3("axis");

  foreach(var_3 in var_1) {
    if(isDefined(var_3))
      var_3 delete();
  }
}

_id_57C2() {
  var_0 = getspawnerarray("post_gas_enemies1");
  var_1 = getspawnerarray("hubbow_post_gas_enemies");
  var_2 = getspawnerarray("salter_exfil_enemies1");
  var_3 = scripts\sp\utility::_id_77DF("runout_enemies");
  var_4 = scripts\sp\utility::_id_22A2(var_0, var_1);
  var_5 = scripts\sp\utility::_id_22A2(var_2, var_3);
  var_6 = scripts\sp\utility::_id_22A2(var_4, var_5);
  level._id_F06F = _id_DC98();
  level._id_F070 = _id_DC99();

  foreach(var_8 in var_6)
  var_8 scripts\sp\utility::_id_1747(::_id_FA3B);
}

_id_57C1() {
  setsaveddvar("g_friendlyNameDist", 200);
  var_0 = getspawnerarray("sa_lmg_spawner");
  var_1 = getspawnerarray("sa_smg_spawner");
  var_2 = getspawnerarray("sa_ar_spawner");
  var_3 = getspawnerarray("sa_crew_spawner");
  var_4 = getspawnerarray("sa_crew_pistol_spawner");
  var_5 = getspawnerarray("conf_grunts");
  var_6 = getspawnerarray("conf_guys");
  var_7 = getspawnerarray("conf_grunts2a");
  var_8 = getspawnerarray("conf_grunts2b");
  level._id_F06F = _id_DC98();
  level._id_F070 = _id_DC99();
  var_9 = scripts\engine\utility::array_combine(var_0, var_1);
  var_10 = scripts\engine\utility::array_combine(var_9, var_2);
  var_11 = scripts\engine\utility::array_combine(var_10, var_3);
  var_12 = scripts\engine\utility::array_combine(var_11, var_4);
  var_13 = scripts\engine\utility::array_combine(var_12, var_5);
  var_14 = scripts\engine\utility::array_combine(var_13, var_6);
  var_15 = scripts\engine\utility::array_combine(var_14, var_7);
  var_16 = scripts\engine\utility::array_combine(var_15, var_8);

  foreach(var_18 in var_16)
  var_18 scripts\sp\utility::_id_1747(::_id_FA3B);
}

_id_FA3B() {
  var_0 = level._id_F06F;
  var_1 = level._id_F070;
  var_2 = randomintrange(0, var_1.size);
  var_3 = randomintrange(0, var_0.size);

  switch (var_0[var_3]) {
    case "Raffel":
      self.name = "Admiral " + var_0[var_3];
      self._id_EDB8 = "Admiral " + var_0[var_3];
      level._id_F06F = scripts\sp\utility::array_remove_index(var_0, var_3);
      break;
    case "Vondrak":
      self.name = "Capt. " + var_0[var_3];
      self._id_EDB8 = "Capt. " + var_0[var_3];
      level._id_F06F = scripts\sp\utility::array_remove_index(var_0, var_3);
      break;
    case "Danz":
      self.name = "Rdml. " + var_0[var_3];
      self._id_EDB8 = "Rdml. " + var_0[var_3];
      level._id_F06F = scripts\sp\utility::array_remove_index(var_0, var_3);
      break;
    default:
      self.name = var_1[var_2] + var_0[var_3];
      self._id_EDB8 = var_1[var_2] + var_0[var_3];
      level._id_F06F = scripts\sp\utility::array_remove_index(var_0, var_3);
      break;
  }
}

_id_DC98() {
  var_0 = ["Vondrak", "Danz", "Zuk", "Parkinson", "Dusette", "Stevenson", "Williams", "Wiegert", "Menard", "Sherman", "Hill", "Widner", "Tiran", "Koberstein", "Blumel", "Saleh", "Graham", "Spray", "Tomplait", "Hamilton", "Peterson", "Blondin", "Pellas", "Raffel", "Schlautman", "McBain", "Stampfli", "Sloan", "Ganous", "Majernik", "Pinkston", "Renner", "Foster", "Kleiman", "Shorey", "Sabin", "Bychowski", "Superty", "Kraft", "Holt", "Zart", "Matejka", "Love", "Kilborn", "McDaniel", "Gulisano", "Sinclair", "Biessman", "Cork", "Christopher", "Bernstein", "Kreeger", "Bayless", "Morrow", "Kuykendall", "Ekberg", "Serio", "Luetscher", "Burnett", "Beese", "Linn"];
  return var_0;
}

_id_DC99() {
  var_0 = ["Sn. ", "Ens. ", "CPO. ", "PO1. ", "PO2. ", "PO3. ", "Lt. ", "Capt. ", "Cmc. "];
  return var_0;
}

_id_9133(var_0, var_1, var_2, var_3, var_4) {
  var_5 = level.player scripts\sp\hud_util::_id_499B("cinematic", var_2, var_3);
  var_5.alignx = "right";
  var_5.aligny = "top";
  var_5.horzalign = "right";
  var_5.vertalign = "top";
  var_5.x = var_0;
  var_5.y = var_1;
  setsaveddvar("bg_cinematicFullScreen", "0");
  setsaveddvar("bg_cinematicCanPause", "1");
  cinematicingame(var_4);
  level.player waittill("delete_hud_cinematic");
  var_5 destroy();
}

_id_1086E(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = getEnt(var_0, "targetname");
    var_2 thread scripts\sp\utility::_id_1747(var_1);
  }
}

_id_D85C() {
  level.player _meth_80D1();
  level.player disableweapons();
  level.player disableoffhandweapons();
  level.player scripts\engine\utility::allow_offhand_secondary_weapons(0);
  level.player _meth_84FE();
  level.player freezecontrols(1);
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player allowsprint(0);
}

_id_D85D() {
  level.player _meth_80D1();
  level.player disableweapons();
  level.player disableoffhandweapons();
  level.player scripts\engine\utility::allow_offhand_secondary_weapons(0);
  level.player _meth_84FE();
  level.player freezecontrols(1);
  level.player setstance("crouch");
  level.player allowprone(0);
  level.player allowstand(0);
  level.player allowcrouch(1);
  level.player allowsprint(0);
}

_id_DF3E() {
  level.player unlink();
  level.player showviewmodel();
  level.player _meth_84FD();
  level.player freezecontrols(0);
  level.player enableweapons();
  level.player enableoffhandweapons();
  level.player scripts\engine\utility::allow_offhand_secondary_weapons(1);
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player allowsprint(1);
  level.player allowstand(1);
  level.player _meth_80A1();
}

_id_E986(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(var_0) {
    setsaveddvar("cg_helmetLinearVelocityToAngleRate", (0.4, 0.4, 1));
    setsaveddvar("cg_helmetViewSwayRate", -0.1);
  } else {
    setsaveddvar("cg_helmetLinearVelocityToAngleRate", (1.2, 1.2, 2));
    setsaveddvar("cg_helmetViewSwayRate", -0.3);
  }

  level thread _id_E984(var_0);
}

_id_E984(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(isDefined(level.player.helmet)) {
    if(scripts\sp\utility::_id_93A6())
      level.player.helmet = level._id_10964.helmet;
    else
      level _id_0E4B::_id_8E04(1);
  }

  if(getDvar("createfx") != "") {
    return;
  }
  if(getdvarint("no_helmet") == 0 || getdvarint("no_helmet") == 2) {
    if(!scripts\sp\utility::_id_93A6())
      level _id_0E4B::_id_8E06();

    if(isDefined(level.player.helmet) && getdvarint("no_helmet") == 0) {
      if(var_0)
        level.player.helmet setModel("vm_hero_protagonist_helmet_zerog_empty");
      else
        level.player.helmet setModel("vm_hero_protagonist_helmet_zerog");
    }
  }
}

_id_2FB0(var_0, var_1, var_2, var_3) {
  var_4 = getEnt(var_0, "targetname");
  var_5 = scripts\engine\utility::getStruct(var_4.target, "targetname");

  if(isDefined(var_5)) {
    var_6 = var_5.origin;
    level thread _id_12DFB(var_1, var_6);
  }

  while(isDefined(var_4) && isDefined(var_4.target)) {
    var_7 = getEnt(var_4.target, "targetname");
    var_4 waittill("trigger");
    var_4 = var_7;

    if(isDefined(var_4)) {
      var_6 = var_4 getorigin();

      if(isDefined(var_4.target)) {
        var_5 = scripts\engine\utility::getStruct(var_4.target, "targetname");

        if(isDefined(var_5))
          var_6 = var_5.origin;
      }

      level thread _id_12DFB(var_1, var_6);
    }
  }

  if(isDefined(var_4))
    var_4 waittill("trigger");

  if(isDefined(var_2))
    scripts\engine\utility::flag_set(var_2);

  if(scripts\engine\utility::is_true(var_3))
    _id_12DFB(var_1, (0, 0, 0));
}

_id_12DFB(var_0, var_1) {
  if(scripts\sp\utility::_id_C268(var_0)) {
    objective_position(scripts\sp\utility::_id_C264(var_0), var_1);
    thread _id_0F16::_id_C278(scripts\sp\utility::_id_C264(var_0));
  }
}

_id_11685(var_0, var_1, var_2) {
  if(getdvarint("loc_warnings", 0)) {
    return;
  }
  if(!isDefined(level._id_545A))
    level._id_545A = [];

  var_3 = 0;

  for(;;) {
    if(!isDefined(level._id_545A[var_3])) {
      break;
    }

    var_3++;
  }

  var_4 = "^3";

  if(!isDefined(var_2))
    var_2 = 1;

  var_2 = max(1, var_2);
  level._id_545A[var_3] = 1;
  var_5 = scripts\sp\hud_util::createfontstring("default", 1.5);
  var_5.location = 0;
  var_5.alignx = "left";
  var_5.aligny = "top";
  var_5.foreground = 1;
  var_5.sort = 20;
  var_5.alpha = 0;
  var_5 fadeovertime(0.5);
  var_5.alpha = 1;
  var_5.x = 40;
  var_5.y = 260 + var_3 * 18;
  var_5.label = " " + var_4 + "< " + var_0 + " > ^7" + var_1;
  var_5.color = (1, 1, 1);
  wait(var_2);
  var_6 = 10.0;
  var_5 fadeovertime(0.5);
  var_5.alpha = 0;

  for(var_7 = 0; var_7 < var_6; var_7++) {
    var_5.color = (1, 1, 0 / (var_6 - var_7));
    wait 0.05;
  }

  wait 0.25;
  var_5 destroy();
  level._id_545A[var_3] = undefined;
}

_id_6F19(var_0, var_1) {
  scripts\sp\utility::_id_65E0("kill_light");
  var_2 = self._id_99EE;
  var_3 = 0;
  var_4 = var_2;
  var_5 = 0;

  for(;;) {
    var_5 = randomintrange(1, 10);

    while(var_5) {
      wait(randomfloatrange(0.05, 0.1));

      if(var_4 > 0.2)
        var_4 = randomfloatrange(0, 0.3);
      else
        var_4 = var_2;

      if(!scripts\sp\utility::_id_65DB("kill_light")) {
        self setlightintensity(var_4);
        var_5--;
        continue;
      }

      self setlightintensity(self._id_99EE * 0.5);
      return;
    }

    if(!scripts\sp\utility::_id_65DB("kill_light")) {
      self setlightintensity(var_2);
      wait(randomfloatrange(var_0, var_1));
      continue;
    }

    return;
  }
}

_id_4546(var_0) {
  if(!scripts\sp\utility::_id_65DF("console_finish"))
    scripts\sp\utility::_id_65E0("console_finish");

  if(!scripts\sp\utility::_id_65DF("console_interacting"))
    scripts\sp\utility::_id_65E0("console_interacting");

  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_2 = ["sa_console_twitch_2", "sa_console_twitch_3", "sa_console_twitch_5", "sa_console_twitch_6"];
  var_3 = var_1 scripts\engine\utility::spawn_tag_origin();
  var_3 scripts\sp\anim::_id_1F17(self, "sa_console_enter");
  scripts\sp\utility::_id_65E1("console_interacting");
  var_3 scripts\sp\anim::_id_1F35(self, "sa_console_enter", "tag_origin");

  for(;;) {
    if(scripts\engine\utility::cointoss())
      var_3 scripts\sp\anim::_id_1F35(self, var_2[randomint(var_2.size - 1)], "tag_origin");
    else
      var_3 scripts\sp\anim::_id_1F35(self, "sa_console_loop", "tag_origin");

    if(scripts\sp\utility::_id_65DB("sa_console_finish")) {
      break;
    }
  }

  var_3 scripts\sp\anim::_id_1F35(self, "sa_console_exit", "tag_origin");
  var_3 delete();
  scripts\sp\utility::_id_65DD("console_finish");
  scripts\sp\utility::_id_65DD("console_interacting");
}

_id_4547() {
  scripts\sp\utility::_id_65E1("console_finish");
  scripts\sp\utility::_id_65E8("console_finish");
}

_id_E709(var_0, var_1) {
  if(isDefined(var_1))
    level endon(var_1);

  if(isDefined(var_0)) {
    self setlightintensity(var_0);
    self _meth_82FC((1, 0, 0));
  }

  if(self.script_noteworthy == "wall") {
    for(;;) {
      self rotatepitch(360, 0.85);
      wait 0.05;
    }
  }

  if(self.script_noteworthy == "ceiling") {
    for(;;) {
      self rotateYaw(360, 0.85);
      wait 0.05;
    }
  }
}

_id_5B25() {
  self endon("death");

  for(;;) {
    scripts\sp\debug::_id_5B24(self.origin, (1, 0, 0), (0, 0, 0), 128, 1, 0);
    scripts\engine\utility::waitframe();
  }
}

_id_13481(var_0, var_1) {
  visionsetnaked(var_0, var_1);
}

_id_5B09() {
  for(;;) {
    if(level.player buttonPressed("DPAD_UP")) {
      foreach(var_1 in level._id_1559) {
        var_1 dodamage(200000, var_1.origin, level.player);
        break;
      }
    }

    wait 0.25;
  }
}

_id_FA56() {
  level._id_A359 = scripts\sp\utility::_id_8200("jackal_swarm_spawner", "targetname");
  level._id_A359._id_13D88 = [];

  foreach(var_1 in level._id_A359 scripts\sp\utility::_id_7A97())
  level._id_A359._id_13D88[level._id_A359._id_13D88.size] = (var_1.origin - level._id_A359.origin) * 5.0;
}

_id_107A3(var_0) {
  while(isDefined(self._id_1323B))
    scripts\engine\utility::waitframe();

  var_1 = scripts\sp\utility::_id_10808();

  if(var_0 > 0) {
    while(isDefined(self._id_1323B))
      scripts\engine\utility::waitframe();

    if(var_0 > self._id_13D88.size)
      var_0 = self._id_13D88.size;

    self._id_13D88 = scripts\engine\utility::array_randomize(self._id_13D88);
    var_2 = self.origin;

    for(var_3 = 0; var_3 < var_0; var_3++) {
      while(isDefined(self._id_1323B))
        scripts\engine\utility::waitframe();

      self.origin = var_2 + self._id_13D88[var_3];
      var_4 = scripts\sp\utility::_id_10808();
      var_4 _id_0BDC::_id_199E(var_1);
      var_4 thread _id_13D82(var_1);
    }
  }

  return var_1;
}

_id_13D82(var_0) {
  var_0 waittill("death");
  self delete();
}

_id_3C0C(var_0) {
  self endon("death");
  self endon("end_chain");
  self notify("chain_path");
  self endon("chain_path");
  var_1 = getnode(var_0, "targetname");
  scripts\sp\utility::_id_F3D9(var_1);
  self.goalradius = 16;

  for(;;) {
    self _meth_82EE(var_1);
    self waittill("goal");

    if(isDefined(var_1.script_delay))
      wait(var_1.script_delay);

    if(isDefined(var_1.target)) {
      var_1 = getnode(var_1.target, "targetname");
      continue;
    }

    break;
  }
}

_id_F406(var_0, var_1, var_2) {
  var_0 = int(clamp(var_0, 0, 255));
  var_1 = int(clamp(var_1, 0, 255));
  var_2 = int(clamp(var_2, 0, 255));
  var_3 = int(var_0 * pow(2, 16) + var_1 * pow(2, 8) + var_2);
  setomnvar("ui_hud_tint_color_int", var_3);
}

_id_2472() {
  foreach(var_1 in self._id_7560["thrust_vert"]) {
    var_1._id_B50D = spawn("script_model", self gettagorigin(var_1.tag));
    var_1._id_B50D setModel("ship_exterior_thruster_d_baked_flat");
    var_1._id_B50D linkTo(self, var_1.tag, (0, 0, 0), (0, 0, 0));
    var_1._id_B50D hide();
  }

  self waittill("death");

  foreach(var_1 in self._id_7560["thrust_vert"]) {
    var_1._id_B50D delete();

    if(isDefined(var_1._id_426A))
      stopFXOnTag(var_1._id_426A, self, var_1.tag);
  }
}

_id_10109() {
  foreach(var_1 in self._id_7560["thrust_vert"]) {
    scripts\engine\utility::waitframe();
    var_1._id_426A = playFXOnTag(scripts\engine\utility::getfx("closeup_thruster_fx"), self, var_1.tag);
    var_1._id_B50D show();
  }
}

_id_2473() {
  foreach(var_1 in self._id_7560["thrust_vert"])
  var_1._id_426A = playFXOnTag(scripts\engine\utility::getfx("closeup_thruster_fx"), self, var_1.tag);

  self waittill("death");

  foreach(var_1 in self._id_7560["thrust_vert"]) {
    if(isDefined(var_1._id_426A))
      stopFXOnTag(var_1._id_426A, self, var_1.tag);
  }
}

_id_AB84(var_0, var_1, var_2) {
  var_3 = var_0 / var_1;
  var_4 = (var_2 - self _meth_8134()) / var_1;

  while(abs(self _meth_8134() - var_2) > abs(var_4) * 2) {
    self setlightintensity(self _meth_8134() + var_4);
    wait(var_3);
  }

  self setlightintensity(var_2);
}

_id_F3C2(var_0) {
  self._id_749D = var_0;
}

waitforalltransients_delayed(var_0) {
  wait(var_0);
  waitforalltransients();
}